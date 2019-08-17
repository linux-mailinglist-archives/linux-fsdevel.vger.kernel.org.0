Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D32290C07
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 04:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHQCFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 22:05:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43692 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHQCFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:05:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7H243XR011062;
        Sat, 17 Aug 2019 02:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=HaT8jQwewItp7FDTL/t6pNw2r4NYEruEsMdvu+I1SYM=;
 b=PYV3CKdMspiNfgyrLFYecsCZcAHUQRCm9Njd7VvaMNPZqhEqhQjEEMUe1BoVFF02EBkk
 SSnzJPNs162VJNa9iV0cKsbdG0fX7whveTI8U64UYkPoNqOuUsU2bd7p6HM/jR7OS4F9
 TjqETxDYXpmYGUQhuerUPpfsLkgh/niLomJObL6sA2yqAZuJ2zrYuymoZ15/Y0FCAHbK
 B7DcRSII3Wg/VNQ9zrlY4i3LgcoPRc7h2KzPxVFosNqvCsyp2llsB/q605AHbDGALv9W
 tlpS7NGmGsMvp3bn3lpwSfCAO4sjk2EXptCi+86ALEunMwDTNJAX+cFdor/U/ZA4GVow 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u9nbu3cna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 02:05:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7H23db8140055;
        Sat, 17 Aug 2019 02:05:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ue6qcjg68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 02:05:33 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7H25VoB008500;
        Sat, 17 Aug 2019 02:05:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 19:05:31 -0700
Date:   Fri, 16 Aug 2019 19:05:29 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, akpm@linux-foundation.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        fstests <fstests@vger.kernel.org>
Subject: [PATCH v2 RFC 3/2] fstests: check that we can't write to swap files
Message-ID: <20190817020529.GG752159@magnolia>
References: <156588514105.111054.13645634739408399209.stgit@magnolia>
 <20190815163434.GA15186@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815163434.GA15186@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908170020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908170020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

While active, the media backing a swap file is leased to the kernel.
Userspace has no business writing to it.  Make sure we can't do this.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
v2: add tests for writable fds after swapon
---
 src/swapon.c          |  135 ++++++++++++++++++++++++++++++++++++++++++++++++-
 tests/generic/717     |   70 +++++++++++++++++++++++++
 tests/generic/717.out |   14 +++++
 tests/generic/718     |   55 ++++++++++++++++++++
 tests/generic/718.out |   12 ++++
 tests/generic/group   |    2 +
 6 files changed, 284 insertions(+), 4 deletions(-)
 create mode 100755 tests/generic/717
 create mode 100644 tests/generic/717.out
 create mode 100755 tests/generic/718
 create mode 100644 tests/generic/718.out

diff --git a/src/swapon.c b/src/swapon.c
index 0cb7108a..afaed405 100644
--- a/src/swapon.c
+++ b/src/swapon.c
@@ -3,22 +3,149 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <string.h>
 #include <sys/swap.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <signal.h>
+
+static void usage(const char *prog)
+{
+	fprintf(stderr, "usage: %s [-v verb] PATH\n", prog);
+	exit(EXIT_FAILURE);
+}
+
+enum verbs {
+	TEST_SWAPON = 0,
+	TEST_WRITE,
+	TEST_MWRITE_AFTER,
+	TEST_MWRITE_BEFORE_AND_MWRITE_AFTER,
+	TEST_MWRITE_BEFORE,
+	MAX_TEST_VERBS,
+};
+
+#define BUF_SIZE 262144
+static char buf[BUF_SIZE];
+
+static void handle_signal(int signal)
+{
+	fprintf(stderr, "Caught signal %d, terminating...\n", signal);
+	exit(EXIT_FAILURE);
+}
 
 int main(int argc, char **argv)
 {
-	int ret;
+	struct sigaction act = {
+		.sa_handler	= handle_signal,
+	};
+	enum verbs verb = TEST_SWAPON;
+	void *p;
+	ssize_t sz;
+	int fd = -1;
+	int ret, c;
+
+	memset(buf, 0x58, BUF_SIZE);
+
+	while ((c = getopt(argc, argv, "v:")) != -1) {
+		switch (c) {
+		case 'v':
+			verb = atoi(optarg);
+			if (verb < TEST_SWAPON || verb >= MAX_TEST_VERBS) {
+				fprintf(stderr, "Verbs must be 0-%d.\n",
+						MAX_TEST_VERBS - 1);
+				usage(argv[0]);
+			}
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
+	}
 
-	if (argc != 2) {
-		fprintf(stderr, "usage: %s PATH\n", argv[0]);
+	ret = sigaction(SIGSEGV, &act, NULL);
+	if (ret) {
+		perror("sigsegv action");
 		return EXIT_FAILURE;
 	}
 
-	ret = swapon(argv[1], 0);
+	ret = sigaction(SIGBUS, &act, NULL);
+	if (ret) {
+		perror("sigbus action");
+		return EXIT_FAILURE;
+	}
+
+	switch (verb) {
+	case TEST_WRITE:
+	case TEST_MWRITE_AFTER:
+	case TEST_MWRITE_BEFORE_AND_MWRITE_AFTER:
+	case TEST_MWRITE_BEFORE:
+		fd = open(argv[optind], O_RDWR);
+		if (fd < 0) {
+			perror(argv[optind]);
+			return EXIT_FAILURE;
+		}
+		break;
+	default:
+		break;
+	}
+
+	switch (verb) {
+	case TEST_MWRITE_BEFORE_AND_MWRITE_AFTER:
+	case TEST_MWRITE_BEFORE:
+		p = mmap(NULL, BUF_SIZE, PROT_WRITE | PROT_READ, MAP_SHARED,
+				fd, 65536);
+		if (p == MAP_FAILED) {
+			perror("mmap");
+			return EXIT_FAILURE;
+		}
+		memcpy(p, buf, BUF_SIZE);
+		break;
+	default:
+		break;
+	}
+
+	if (optind != argc - 1)
+		usage(argv[0]);
+
+	ret = swapon(argv[optind], 0);
 	if (ret) {
 		perror("swapon");
 		return EXIT_FAILURE;
 	}
 
+	switch (verb) {
+	case TEST_WRITE:
+		sz = pwrite(fd, buf, BUF_SIZE, 65536);
+		if (sz < 0) {
+			perror("pwrite");
+			return EXIT_FAILURE;
+		}
+		break;
+	case TEST_MWRITE_AFTER:
+		p = mmap(NULL, BUF_SIZE, PROT_WRITE | PROT_READ, MAP_SHARED,
+				fd, 65536);
+		if (p == MAP_FAILED) {
+			perror("mmap");
+			return EXIT_FAILURE;
+		}
+		/* fall through */
+	case TEST_MWRITE_BEFORE_AND_MWRITE_AFTER:
+		memcpy(p, buf, BUF_SIZE);
+		break;
+	default:
+		break;
+	}
+
+	if (fd >= 0) {
+		ret = fsync(fd);
+		if (ret)
+			perror("fsync");
+		ret = close(fd);
+		if (ret)
+			perror("close");
+	}
+
 	return EXIT_SUCCESS;
 }
diff --git a/tests/generic/717 b/tests/generic/717
new file mode 100755
index 00000000..92073dbb
--- /dev/null
+++ b/tests/generic/717
@@ -0,0 +1,70 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-newer
+# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
+#
+# FS QA Test No. 717
+#
+# Check that we can't modify a file that's an active swap file.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	swapoff $testfile
+	rm -rf $tmp.* $testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs generic
+_require_test_program swapon
+_require_scratch_swapfile
+
+rm -f $seqres.full
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+testfile=$SCRATCH_MNT/$seq.swap
+
+_format_swapfile $testfile 20m
+
+# Can you modify the swapfile via previously open file descriptors?
+for verb in 1 2 3 4; do
+	echo "verb $verb"
+	"$here/src/swapon" -v $verb $testfile
+	swapoff $testfile
+done
+
+# Now try writing with a new file descriptor.
+swapon $testfile 2>&1 | _filter_scratch
+
+# Can we write to it?
+$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $testfile
+$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $testfile
+$XFS_IO_PROG -c 'mmap -rw 64k 64k' -c 'mwrite -S 0x61 64k 64k' $testfile
+
+# Can we change the file size?
+$XFS_IO_PROG -c 'truncate 18m' $testfile
+
+# Can you fallocate the file?
+$XFS_IO_PROG -c 'falloc 0 32m' $testfile
+
+# We test that you can't reflink, dedupe, or copy_file_range into a swapfile
+# in other tests.
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/717.out b/tests/generic/717.out
new file mode 100644
index 00000000..59345ca1
--- /dev/null
+++ b/tests/generic/717.out
@@ -0,0 +1,14 @@
+QA output created by 717
+verb 1
+pwrite: Text file busy
+verb 2
+mmap: Text file busy
+verb 3
+Caught signal 7, terminating...
+verb 4
+pwrite: Text file busy
+pwrite: Text file busy
+mmap: Text file busy
+no mapped regions, try 'help mmap'
+ftruncate: Text file busy
+fallocate: Text file busy
diff --git a/tests/generic/718 b/tests/generic/718
new file mode 100755
index 00000000..504022e1
--- /dev/null
+++ b/tests/generic/718
@@ -0,0 +1,55 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-newer
+# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
+#
+# FS QA Test No. 718
+#
+# Check that we can't modify a block device that's an active swap device.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	swapoff $SCRATCH_DEV
+	rm -rf $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs generic
+_require_test_program swapon
+_require_scratch_nocheck
+
+rm -f $seqres.full
+
+$MKSWAP_PROG "$SCRATCH_DEV" >> $seqres.full
+
+# Can you modify the swap dev via previously open file descriptors?
+for verb in 1 2 3 4; do
+	echo "verb $verb"
+	"$here/src/swapon" -v $verb $SCRATCH_DEV
+	swapoff $SCRATCH_DEV
+done
+
+swapon $SCRATCH_DEV 2>&1 | _filter_scratch
+
+# Can we write to it?
+$XFS_IO_PROG -c 'pwrite -S 0x59 64k 64k' $SCRATCH_DEV
+$XFS_IO_PROG -d -c 'pwrite -S 0x60 64k 64k' $SCRATCH_DEV
+$XFS_IO_PROG -c 'mmap -rw 64k 64k' -c 'mwrite -S 0x61 64k 64k' $SCRATCH_DEV
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/718.out b/tests/generic/718.out
new file mode 100644
index 00000000..88d5cf3e
--- /dev/null
+++ b/tests/generic/718.out
@@ -0,0 +1,12 @@
+QA output created by 718
+verb 1
+pwrite: Text file busy
+verb 2
+mmap: Text file busy
+verb 3
+Caught signal 7, terminating...
+verb 4
+pwrite: Text file busy
+pwrite: Text file busy
+mmap: Text file busy
+no mapped regions, try 'help mmap'
diff --git a/tests/generic/group b/tests/generic/group
index 003fa963..c58d41e3 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -570,3 +570,5 @@
 565 auto quick copy_range
 715 auto quick rw
 716 auto quick rw
+717 auto quick rw swap
+718 auto quick rw swap
