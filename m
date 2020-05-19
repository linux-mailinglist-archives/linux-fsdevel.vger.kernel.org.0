Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0683B1DA32D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 23:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgESVDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 17:03:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:35417 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESVDL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 17:03:11 -0400
IronPort-SDR: Pvxv98GFp6DzoAGwB+APo+NcDwutFrRiJQ5wcCUh5e6+fkRw3+tzLPaL6MpIBccHAZOthQH9Cg
 dPA8dUrooG5Q==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 14:03:09 -0700
IronPort-SDR: 3RtozwuR9HUH34ZT37qT34YNIweXgxnd3IF6MhxN3YcdKiSykbWHp4cY9/kgHplTLc9C3T9BgZ
 dFlY2iVAiHvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="c'?scan'208";a="264442159"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2020 14:03:09 -0700
Received: from tjmaciei-mobl1.localnet (10.255.229.215) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 May 2020 14:03:09 -0700
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: fcntl(F_DUPFD) causing apparent file descriptor table corruption
Date:   Tue, 19 May 2020 14:03:03 -0700
Message-ID: <1645568.el9gB4U55B@tjmaciei-mobl1>
Organization: Intel Corporation
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart7613756.9Z4iiRFd73"
Content-Transfer-Encoding: 7Bit
X-Originating-IP: [10.255.229.215]
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--nextPart7613756.9Z4iiRFd73
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello Al & others

While doing something I shouldn't be doing in my code, I realised that my code 
stopped responding. Turns out that after some F_DUPFD forcing the file 
descriptor preposterously high, the low file descriptors become EBADF. 
Something must be wrong in expand_files, but I don't have the expertise to 
debug it. I'm hoping someone else will.

I've attached a testcase for it. It needs to be run as root. It's not threaded 
and it reproduces the problem 100% of the time on my stable kernel (5.6.13). 
This is not a security issue, since it affects only the calling process 
itself.

On my machine, /proc/sys/fs/nr_open is 1073741816 and I have 32 GB of RAM (if 
the problem is related to memory consumption).

The problem only occurs when growing the table.

strace shows something like:
fcntl(2, F_DUPFD, 1024)                 = 1024
close(1024)                             = 0
fcntl(2, F_DUPFD, 2048)                 = 2048
close(2048)                             = 0
fcntl(2, F_DUPFD, 4096)                 = 4096
close(4096)                             = 0
fcntl(2, F_DUPFD, 8192)                 = 8192
close(8192)                             = 0
fcntl(2, F_DUPFD, 16384)                = 16384
close(16384)                            = 0
fcntl(2, F_DUPFD, 32768)                = 32768
close(32768)                            = 0
fcntl(2, F_DUPFD, 65536)                = 65536
close(65536)                            = 0
fcntl(2, F_DUPFD, 131072)               = 131072
close(131072)                           = 0
fcntl(2, F_DUPFD, 262144)               = 262144
close(262144)                           = 0
fcntl(2, F_DUPFD, 524288)               = 524288
close(524288)                           = 0
fcntl(2, F_DUPFD, 1048576)              = 1048576
close(1048576)                          = 0
fcntl(2, F_DUPFD, 2097152)              = 2097152
close(2097152)                          = 0
fcntl(2, F_DUPFD, 4194304)              = 4194304
close(4194304)                          = 0
fcntl(2, F_DUPFD, 8388608)              = 8388608
close(8388608)                          = 0
fcntl(2, F_DUPFD, 16777216)             = 16777216
close(16777216)                         = 0
fcntl(2, F_DUPFD, 33554432)             = 33554432
close(33554432)                         = 0
fcntl(2, F_DUPFD, 67108864)             = 67108864
close(67108864)                         = 0
fcntl(2, F_DUPFD, 134217728)            = 134217728
close(134217728)                        = 0
fcntl(2, F_DUPFD, 536870912)            = 536870912
close(536870912)                        = 0
write(1, "success\n", 8)                = EBADF
-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel System Software Products

--nextPart7613756.9Z4iiRFd73
Content-Disposition: attachment; filename="dupfd-bug.c"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="dupfd-bug.c"

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <unistd.h>

void run_test(int maxfd)
{
    int srcfd = STDERR_FILENO;
    int minfd = 1024;

    /* Linux kernel expands the file descriptor table exponentially, so
     * keep requesting a minimum file descriptor exponentially. */
    for ( ; minfd < maxfd; minfd *= 2) {
        int fd;
        do {
            fd = fcntl(srcfd, F_DUPFD, minfd);
        } while (fd == -1 && errno == EINTR);

        if (fd == -1) {
            if (errno != EMFILE)
                perror("fcntl");
            return;
        }
        close(fd);
    }
}

int main(int argc, char **argv)
{
    struct rlimit lim;
    if (argc > 1) {
        lim.rlim_max = lim.rlim_cur = strtol(argv[1], NULL, 0);
    } else {
        int n;
        FILE *f = fopen("/proc/sys/fs/nr_open","r");
        if (!f) {
            perror("fopen");
            return EXIT_FAILURE;
        }
        if (fscanf(f, "%d", &n) != 1)
            return EXIT_FAILURE;
        fclose(f);
        lim.rlim_max = lim.rlim_cur = n;
    }

    if (setrlimit(RLIMIT_NOFILE, &lim) == -1) {
        perror("setrlimit");
        return EXIT_FAILURE;
    }

    run_test(lim.rlim_cur);

    static const char msg[] = "success\n";
    int ok1 = write(STDOUT_FILENO, msg, strlen(msg)) == strlen(msg);
    return ok1 ? EXIT_SUCCESS : 255;
}

--nextPart7613756.9Z4iiRFd73--
