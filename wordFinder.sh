#!/bin/bash
array=($@)
count=0
final_array=()
cou=0;
if (( ${#array[@]}<3 ))
then 
	echo  "Number of parameters received : [${#array[@]}]" >&2
	echo 'Usage : wordFinder.sh <valid file name> [More Files]... <char> <length>'
	exit

else
	flag=true
	letter=${array[${#array[@]}-2]}
	num=${array[${#array[@]}-1]}
	if (( ${#array[${#array[@]}-2]}!=1 ))
	then
		flag=false
		echo "Only one char needed : [${array[${#array[@]}-2]}]" >&2
	elif ! [[ ${array[${#array[@]}-2]} =~ [a-zA-Z] ]]
	then 
		flag=false
		echo "Only one char needed : [${array[${#array[@]}-2]}]" >&2
	fi
	if  (( array[${#array[@]}-1]<0 ))
	then
		flag=false
		echo "Not a positive number : [${array[${#array[@]}-1]}]" >&2
	else
		if ! [[ ${array[${#array[@]}-1]} =~ ^[0-9]+$ ]]
		then
		flag=false
		echo "Not a positive number : [${array[${#array[@]}-1]}]" >&2
		fi
	fi
	if [[ "$flag" = "false" ]]
	then
		echo 'Usage : wordFinder.sh <valid file name> [More Files]... <char> <length>'
		exit
	fi
	for (( n=0; n<${#array[@]}-2; n++ ))
	do
		if ! [ -f "${array[n]}" ]	
			then
				echo "File does not exist : [${array[n]}]" >&2
				flag=false
		fi
       done	
	if [[ "$flag" = "false" ]]
	then
		echo 'Usage : wordFinder.sh <valid file name> [More Files]... <char> <length>'
		exit
	fi
	touch orderFile
	for (( n=0; n<${#array[@]}-2; n++ ))
	do
		echo | cat ${array[n]} | tr ' ' '\n'| tr "'" '\n'| tr -cd "[0-9A-Za-z]\n" | tr '[:upper:]' '[:lower:]' >> orderFile
	done	
	touch finalFile
	grep ^$letter orderFile > finalFile
	touch finalFile2
	cat finalFile | while read line || [[ -n $line ]];
	do   
		if (( ${#line}>=$num ))
		then
			echo ${line} >> finalFile2
		fi
	done
	touch finalFile3
	sort finalFile2 >> finalFile3
	echo "&" >> finalFile3
	touch realFinal
	count=0
	amount=1
	row="#"
	f_array=()
	cat finalFile3 | while read line || [[ -n $line ]];
	do
		f_array[count]=$line
		if (( count>0 ))
		then
			if [[ ${f_array[count]} == ${f_array[count-1]} ]]
			then
				amount=$((amount+1))
				count=$((count+1))
			else
				if [[ $line == "&" ]]
				then
					echo "$amount ${f_array[count-1]}" >> realFinal
					break
				fi
				echo "$amount ${f_array[count-1]}" >> realFinal
				count=$((count+1))
				amount=1
				
			fi
		else 
			count=$((count+1))
		fi		
	done
	sort -n realFinal	
	rm finalFile
	rm finalFile2
	rm finalFile3
	rm realFinal
	rm orderFile
fi	
	

			
			
	
	
	
				
				
				

	
				
			
	
	
		
			
		
		
		
		
 
		

	
		
	
		



