Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D6E23EA40
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHGJW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 05:22:59 -0400
Received: from tretyak2.mcst.ru ([212.5.119.215]:48360 "EHLO tretyak2.mcst.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgHGJW7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:22:59 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2020 05:22:58 EDT
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 21A8520C1D;
        Fri,  7 Aug 2020 12:15:46 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 0673620C65;
        Fri,  7 Aug 2020 12:15:36 +0300 (MSK)
Received: from [192.168.1.7] (e2k7 [192.168.1.7])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 0779FTVw022461;
        Fri, 7 Aug 2020 12:15:29 +0300
To:     linux-fsdevel@vger.kernel.org,
        "viro@zeniv.linux.org.uk >> Al Viro" <viro@zeniv.linux.org.uk>
From:   "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Subject: timestamp_truncate() incorrect truncate
Message-ID: <5F2D1BB1.6000202@mcst.ru>
Date:   Fri, 7 Aug 2020 12:15:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20200807 notchecked
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

timestamp_truncate() truncates nsec to 0, if sec is 0 for nfs v3. There 
is a test:

$ cat ./t.c

#define _GNU_SOURCE

#include <fcntl.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

int
main (void)
{
   const char *fname = "./delme.log";
   int fd;
   struct stat sb;
   const struct timespec ts[2] = {{0, 199}, {0, 999}};

   unlink (fname);
   fd = open (fname, O_CREAT | O_TRUNC, 0660);

   if (futimens(fd, ts) != 0)
     {
       perror ("futimens()");
       return 1;
     }

   close (fd);

   stat (fname, &sb);

   printf ("atim: sec == %ld, nsec == %ld\n",
           (long) sb.st_atim.tv_sec,
           (long) sb.st_atim.tv_nsec);

   printf ("mtim: sec == %ld, nsec == %ld\n",
           (long) sb.st_mtim.tv_sec,
           (long) sb.st_mtim.tv_nsec);

   if (sb.st_atim.tv_sec != ts[0].tv_sec
       || sb.st_atim.tv_nsec != ts[0].tv_nsec
       || sb.st_mtim.tv_sec != ts[1].tv_sec
       || sb.st_mtim.tv_nsec != ts[1].tv_nsec)
     return 1;

   return 0;
}

(sec + nsec = nsec) is inside of interval, supported by nfs v3. Why nsec 
is truncated to 0?
