#!/bin/bash


if [ $# -ne 3 ]
then echo "param error"
	exit 0;
fi

for (( ; ; ))
do
	echo "------------------------------------------------"
	echo "User Name : Lee_Tak_Gyoung"
	echo "Student Number : 12181669"
	echo "[  MENU  ]"
	echo "1. Get the data of the movie identified by a specific"
	echo "'movie id' from 'u.item'"
	echo "2. Get the data of action genre movies from 'u.item'"
	echo "3. Get the average 'rating' of the movie identified by"
	echo "specific 'movie id' from 'u.data'"
	echo "4. Delete the 'IMDB URL' from 'u.item'"
	echo "5. Get the data about users from 'u.user'"
	echo "6. Modify the format of 'release date' in 'u.item'"
	echo "7. Get the data of movies rated by a specific 'user id'"
	echo "from 'u.data'"
	echo "8. Get the averrage 'rating' of movies rated by users with"
	echo "'age' between 20 and 29 and 'occupation' as 'programmer'"
	echo "9. Exit"
	echo "------------------------------------------------"
	read -p "Enter your choice [ 1-9 ] " choice


	if [ ${choice} -eq 1 ]; then
        	read -p "please enter 'movie id' (1~1682) : " choice_1
		
		export choice_1

		awk -F '|' '$1 == ENVIRON["choice_1"] { print $0 }' ./u.item
	
	fi

	if [ ${choice} -eq 2 ]; then
        	echo "De you want to get the data of 'action' genre movies"
        	read -p "from 'u.item'? (y/n) : " choice_2

        	if [ ${choice_2} = "y" ]; then
			
			
			awk -F '|' '$7 == 1{i++;print $1,$2,$3} i==10{exit}' ./u.item	

			continue

		else
                	continue
        	fi
	fi
	
	if [ ${choice} -eq 3 ]; then
                read -p "please enter 'movie id' (1~1682) : " choice_3
		
		export choice_3

		awk '$2 == ENVIRON["choice_3"] {sum += $3; i++}END{printf "%.5f\n", sum/i}' ./u.data

		continue

        fi
	
	if [ ${choice} -eq 4 ]; then
		read -p "Do you want to delete the 'IMDB URL' from 'u.item'? (y/n) : " choice_4

		if [ ${choice_4} = "y" ]; then
			
			awk -F '|' '$5="\b" {i++; print $0} i==10{exit}' ./u.item

			continue

		else
			continue
		fi
        fi
	

	if [ ${choice} -eq 5 ]; then
                echo "Dd you want to get the data about users from"
                read -p "'u.user'? (y/n) : " choice_5

                if [ ${choice_5} = "y" ]; then
                        
			awk -F '|' '{i++; sub("M","male",$3);sub("F","female",$3) ; print "user "$1,"is "$2,"years old "$3,$4} i==10{exit}' ./u.user
                        continue

                else
                        continue
                fi
        fi

	if [ ${choice} -eq 6 ]; then
		read -p "Do you want to Modify the format of 'release data' in 'u.item'? (y/n) : " choice_6

		if [ ${choice_6} = "y" ]; then
                        
			awk -F '|' 'NR==1673 {$3="19950101"; print $0}' ./u.item
			awk -F '|' 'NR==1674 {$3="19620101"; print $0}' ./u.item
			awk -F '|' 'NR==1675 {$3="19961025"; print $0}' ./u.item
                        awk -F '|' 'NR==1676 {$3="19960101"; print $0}' ./u.item
			awk -F '|' 'NR==1677 {$3="19960920"; print $0}' ./u.item
                        awk -F '|' 'NR==1678 {$3="19980206"; print $0}' ./u.item
			awk -F '|' 'NR==1679 {$3="19980206"; print $0}' ./u.item
                        awk -F '|' 'NR==1680 {$3="19980101"; print $0}' ./u.item
			awk -F '|' 'NR==1681 {$3="19940101"; print $0}' ./u.item
                        awk -F '|' 'NR==1682 {$3="19960308"; print $0}' ./u.item

                        continue

                else
                        continue
                fi



        fi
	

	if [ ${choice} -eq 7 ]; then
                read -p "please enter the 'user id' (1~943) : " choice_7

		export choice_7

		touch tmp.txt
		awk '$1 == ENVIRON["choice_7"] {print $2}' u.data > tmp.txt

		awk '$1 == ENVIRON["choice_7"] {printf "%s%s",NR==1 ? "" : "|" ,$2}' ./u.data && echo ""

		echo ""
		
		

		awk -F '|' 'FNR==NR {out[$1]=1; next} {i++; if (out[FNR]==1); print $1"|",$2} i==10{exit}' tmp.txt u.item

		rm tmp.txt
        fi


	if [ ${choice} -eq 8 ]; then
		echo "Do tou want to get the average 'rating' of"
		echo "movies rated by users with 'age' between 20 and"
		read -p "29 and 'occupation' as 'programmer'? (y/n) : " choice_8

		if [ ${choice_8} = "y" ]; then
                        
			touch tmp2.txt
			touch tmp3.txt

			awk -F '|' '$2 >= 20 && $2 < 30 {print $1,$2,$4}' u.user > tmp2.txt
			awk '/programmer/{print $1,$2,$3}' tmp2.txt > tmp3.txt



			#rm tmp2.txt
			#rm tmp3.txt

                        continue

                else
                        continue
                fi


	fi


	if [ ${choice} -eq 9 ]; then
		echo "Bye!"
		exit
        fi

done
