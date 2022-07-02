#!/bin/bash

##-------------------------------------------------------------##
# checks for figlet on system and if not found #
# then checks for the package manager of your distro #
# and uses the right command to install figlet accordingly #
##-------------------------------------------------------------##
while true; do
    if command -v figlet &> /dev/null
    then
        break
    else
        if command -v pacman &> /dev/null
        then
            sudo pacman -S figlet
            break
        elif command -v apt &> /dev/null
        then
            sudo apt install figlet
            break
        elif command -v xbps-install &> /dev/null
        then
            sudo xbps-install figlet
            break
        else
            break
        fi
    fi
done
clear

##----------------------------- ##
# prints out header for program #
# if figlet didn't get installed the header won't show #
##------------------------------##
if command -v figlet &> /dev/null
then
    figlet -c -f slant "Schedule Manager"
    printf "\n"
    figlet -c -f digital "by: Yousef-Saeed"
    printf "\n "

##--------------------------------------------------------------------##
# prompts for user input and checks for action user wishes to complete #
##--------------------------------------------------------------------##
while true; do
    printf "Make a Selection\n(options: A/a = add, V/v = view, & E/e = exit)\n"
    printf " : "
    read -r answer


##-------------------------------------------------##
# prompts for appointment info if "add" is selected #
##-------------------------------------------------##
if [[ "$answer" == [A/a] ]]
then
    printf "\n"
    printf "Date\n(format = Dec12)"
    printf "\n : "
    read -r date
    printf "\n"
    printf "Time\n(format = HH:MM AM/PM) "
    printf "\n : "
    read -r time
    printf "\n"
    printf "Entry\n "
    printf "\n : "
    read -r entry


##---------------------------------------------------------------------##    
# checks for file with selected date, if found, stores new appointment. #
# if not found, it creates new file                                     #
##---------------------------------------------------------------------##
if [[ -f "$HOME/.local/share/todo/$date" ]]; then
    printf '%s %s :\n %s\n\n' "$date" "$time" "$entry" >> "$HOME/.local/share/todo/$date"
    vim "$HOME/.local/share/todo/$date"
else
    touch "$HOME/.local/share/todo/$date"

    if command -v figlet &> /dev/null
    then
    figlet -s -f slant "$date" >> "$HOME/.local/share/todo/$date"
    else
    printf "$date" >> "$HOME/.local/share/todo/$date"
    fi

    printf '%s %s :\n %s\n\n' "$date" "$time" "$entry" >> "$HOME/.local/share/todo/$date"
    vim "$HOME/.local/share/todo/$date"
fi

##-----------------------------------------------------------------------------##
# if "view" selected, prompts user for which date to view or all, if date given #
# opens file for given date, if all selected, opens dir of all files for user   #
# to choose from, if exit chosen, closes program                                #
##-----------------------------------------------------------------------------##
elif [[ "$answer" == [V/v] ]]
then
    printf "\n"
    printf "Please type \"date\" or \"all\" to choose from list"
    printf "\n : "
    read -r choice
    printf "\n"
    if [[ "$choice" == all ]]
    then
        vim "$HOME/.local/share/todo/"
    else
        if [[ "$choice" == date ]]
        then
            printf "Which date would you like to view?\n"
            printf "(format = Dec12)"
            printf "\n : "
            read -r day
            vim "$HOME/.local/share/todo/$day"
        fi
    fi
elif [[ "$answer" == [E/e] ]]
then
    exit
else [[ "$answer" == ? ]]
    printf "Please make proper selection"
fi

##------------------------------------------------------------------------##
# prompts user if wants to add another entry if "yes" loops the programe #
# if "no" exit #
##----------------------------------------------------------------------- ##
printf "\nWould you like to add or view another entry?\n"
printf "(Y/y or N/n)"
printf "\n: "
read -r decision
printf "\n"
if [[ "$decision" == [Y/y] ]]
then
    printf "Great!\n"
else
    exit
fi

done
fi
