Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104083F1FDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 20:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhHSS1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 14:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234126AbhHSS1X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:27:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9377601FE;
        Thu, 19 Aug 2021 18:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629397607;
        bh=IvrOdL4koyqt6e94qNCenAfCZMjyQFaKZkVroyVtZE8=;
        h=Date:From:To:Cc:Subject:From;
        b=OWrcTldj/jbofEX/WLXs4kIpfxEJnpAPR789wFXlg5Lc/Ya1cCBM6n7jLpJlObJ3F
         7lDBiuzJzNPbUGdHxotnbO1rfE5A7fw73NFQ4WBC2CIE3SWaieF0y2rnDZta+45J2p
         lgICaB5Jha1/dJa8/We0ih2wujjgbvfKm6ufEPy6a+u4hb+ZbrQsKOePtrPehKXDyM
         127JmIOf2jIuSHqc34M3YlBbP5svoKcTCo1pDYUB5KFQ1riELC1IJN2Ln40wJeqjBq
         wuS1M8FAdwH68+ETGEPU8vZXhTQneQ9SFoUo85PS70MgU6N/n7N64KwyDMxoLAOnTp
         cXHk8N93ReBXQ==
Date:   Thu, 19 Aug 2021 11:26:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     fstests <fstests@vger.kernel.org>
Cc:     Xu Yu <xuyu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riteshh@linux.ibm.com, tytso@mit.edu,
        gavin.dg@linux.alibaba.com, Christoph Hellwig <hch@infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] generic: test swapping process pages in and out of a swapfile
Message-ID: <20210819182646.GD12612@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

This test is intended to perform minimal spot-checking that we can swap
pages to a swapfile and recall them into memory without burning peoples'
machines to the ground.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 .gitignore               |    1 
 common/cgroup2           |    5 ++
 common/config            |    1 
 common/rc                |    4 -
 src/Makefile             |    2 -
 src/usemem_and_swapoff.c |  117 ++++++++++++++++++++++++++++++++++++++
 tests/generic/728        |  141 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/728.out    |    9 +++
 8 files changed, 276 insertions(+), 4 deletions(-)
 create mode 100644 src/usemem_and_swapoff.c
 create mode 100755 tests/generic/728
 create mode 100644 tests/generic/728.out

diff --git a/.gitignore b/.gitignore
index 2d72b064..23d6f37b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -166,6 +166,7 @@ tags
 /src/unwritten_mmap
 /src/unwritten_sync
 /src/usemem
+/src/usemem_and_swapoff
 /src/writemod
 /src/writev_on_pagefault
 /src/xfsctl
diff --git a/common/cgroup2 b/common/cgroup2
index 8833c9c8..df805a16 100644
--- a/common/cgroup2
+++ b/common/cgroup2
@@ -17,4 +17,9 @@ _require_cgroup2()
 	fi
 }
 
+_require_memcg()
+{
+	test -e "$CGROUP2_PATH/memory.stat" || _notrun "memcg required for test"
+}
+
 /bin/true
diff --git a/common/config b/common/config
index 9cb4ad71..e2870be0 100644
--- a/common/config
+++ b/common/config
@@ -272,6 +272,7 @@ export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
 export E2FSCK_PROG=$(type -P e2fsck)
 export TUNE2FS_PROG=$(type -P tune2fs)
 export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
+export SYSTEMD_RUN_PROG="$(type -P systemd-run)"
 
 # SELinux adds extra xattrs which can mess up our expected output.
 # So, mount with a context, and they won't be created.
diff --git a/common/rc b/common/rc
index a07b5ac3..081ed72f 100644
--- a/common/rc
+++ b/common/rc
@@ -2593,10 +2593,8 @@ _format_swapfile() {
 }
 
 _swapon_file() {
-	local fname="$1"
-
 	# Ignore permission complaints on filesystems that don't support perms
-	swapon "$fname" 2> >(grep -v "insecure permissions" >&2)
+	swapon "$@" 2> >(grep -v "insecure permissions" >&2)
 }
 
 # Check that the filesystem supports swapfiles
diff --git a/src/Makefile b/src/Makefile
index 884bd86a..82698279 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -31,7 +31,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
-	detached_mounts_propagation
+	detached_mounts_propagation usemem_and_swapoff
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py
diff --git a/src/usemem_and_swapoff.c b/src/usemem_and_swapoff.c
new file mode 100644
index 00000000..d86837da
--- /dev/null
+++ b/src/usemem_and_swapoff.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * Test program to try to force the VMM to swap pages in and out of memory.
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/swap.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+
+int main(int argc, char *argv[])
+{
+	struct rlimit rlim;
+	long long nr_bytes;
+	long pagesize;
+	char *p, *pstart, *pend;
+	int ret;
+
+	if (argc != 2 && argc != 4) {
+		printf("Usage: %s mem_in_bytes [swapfile1 swapfile2]\n",
+				argv[0]);
+		return 1;
+	}
+
+	pagesize = sysconf(_SC_PAGESIZE);
+	if (pagesize < 1) {
+		fprintf(stderr, "Cannot determine system page size.\n");
+		return 2;
+	}
+
+	errno = 0;
+	nr_bytes = strtol(argv[1], &p, 0);
+	if (errno) {
+		perror(argv[1]);
+		return 3;
+	}
+
+	printf("Allocating %llu memory.\n", nr_bytes);
+	fflush(stdout);
+
+	/* Allocate a large memory buffer. */
+	pstart = malloc(nr_bytes);
+	if (!pstart) {
+		perror("malloc");
+		return 4;
+	}
+	pend = pstart + nr_bytes;
+
+	printf("Dirtying memory.\n");
+	fflush(stdout);
+
+	/* Dirty the memory to force this program to be swapped out. */
+	for (p = pstart; p < pend; p += pagesize)
+		*p = 'X';
+
+	/*
+	 * If the caller does not provide any swapfile names, mlock the buffer
+	 * to test if memory usage enforcement actually works.
+	 */
+	if (argc == 2) {
+		printf("Now mlocking memory.\n");
+		fflush(stdout);
+
+		rlim.rlim_cur = RLIM_INFINITY;
+		rlim.rlim_max = RLIM_INFINITY;
+		ret = setrlimit(RLIMIT_MEMLOCK, &rlim);
+		if (ret) {
+			perror("setrlimit");
+		}
+
+		ret = mlock(pstart, nr_bytes);
+		if (ret) {
+			perror("mlock");
+			return 0;
+		}
+
+		printf("Should not have survived mlock!\n");
+		fflush(stdout);
+		return 6;
+	}
+
+	/*
+	 * Try to force the system to swap this program back into memory by
+	 * activating the second swapfile (at maximum priority) and
+	 * deactivating the first swapfile.
+	 */
+	printf("Now activating swapfile2.\n");
+	fflush(stdout);
+
+	ret = swapon(argv[3], SWAP_FLAG_PREFER | SWAP_FLAG_PRIO_MASK);
+	if (ret) {
+		perror("swapon");
+		return 7;
+	}
+
+	printf("Now deactivating swapfile1.\n");
+	fflush(stdout);
+
+	ret = swapoff(argv[2]);
+	if (ret) {
+		perror("swapoff");
+		return 8;
+	}
+
+	/* Dirty the memory again to ensure that we're still running. */
+	for (p = pstart; p < pend; p += pagesize)
+		*p = 'Y';
+
+	return 0;
+}
diff --git a/tests/generic/728 b/tests/generic/728
new file mode 100755
index 00000000..30fc5a9a
--- /dev/null
+++ b/tests/generic/728
@@ -0,0 +1,141 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Oracle.  All Rights Reserved.
+#
+# FS QA Test 728
+#
+# Test swapping process pages in and out of a swapfile.  Because we cannot
+# direct the virtual memory manager to flush pages to swap and do not wish to
+# spend a large amount of time flooding the system with dirty anonymous pages,
+# some trickery is employed here to speed things up.
+#
+# Specifically, this test employs the memory cgroup controller to run a modest
+# memory consuming process with an artificially low limit on the amount of
+# physical memory that it can use.  Combined with swap files configured with
+# maximum priority, the hope is that the mem-user process will get paged out
+# to the swapfile and some clever uses of swapon/swapoff will force it to be
+# paged back in.
+#
+# Note that we use systemd-run to configure the memory controller so that we
+# don't have to open-code all the cgroupv1 and cgroupv2 configuration logic in
+# the form of shell scripts.
+#
+. ./common/preamble
+_begin_fstest auto swap
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	test -n "$swapfile1" && swapoff $swapfile1 &> /dev/null
+	test -n "$swapfile2" && swapoff $swapfile2 &> /dev/null
+}
+
+. ./common/cgroup2
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch_swapfile
+_require_command "$SYSTEMD_RUN_PROG" systemd-run
+_require_test_program "usemem_and_swapoff"
+_require_memcg
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+swapfile1=$SCRATCH_MNT/swapfile1
+swapfile2=$SCRATCH_MNT/swapfile2
+_format_swapfile $swapfile1 100m >> $seqres.full
+_format_swapfile $swapfile2 100m >> $seqres.full
+
+# The maximum swap priority is 32767 as defined by the kernel swap flag mask.
+SWAP_FLAG_PRIO_MASK=32767	# 0x7ffff
+
+# Add the swapfile with the highest priority so that pages get sent here before
+# any other configured swap space.
+_swapon_file $swapfile1 -p $SWAP_FLAG_PRIO_MASK
+
+# Walk the swap list to make sure that our swapfile has the highest priority
+# to boost the chances that it will get used for /some/ swap activity.
+cat /proc/swaps >> $seqres.full
+saw_swapfile1=0
+saw_swapfile2=0
+while read fname type size used priority junk; do
+	test "$fname" = "Filename" && continue
+	if [ "$fname" -ef "$swapfile1" ]; then
+		test "$priority" -eq "$SWAP_FLAG_PRIO_MASK" || \
+			echo "swapfile1 has wrong priority $priority?"
+		saw_swapfile1=1
+		continue
+	fi
+	test "$fname" -ef "$swapfile2" && saw_swapfile2=1
+	test "$priority" -lt "$SWAP_FLAG_PRIO_MASK" || \
+		echo "$fname: swap at same priority as test swapfile, test may fail"
+done < /proc/swaps
+
+test "$saw_swapfile1" -gt 0 || \
+	echo "swapfile1 shold be present in /proc/swaps"
+test "$saw_swapfile2" -eq 0 || \
+	echo "swapfile2 should not be present in /proc/swaps"
+
+# Configure ourselves to run a test program in a specially crafted systemd
+# scope where DRAM usage is constrained to 10MB maximum.  The test program
+# will try to get itself swapped out to disk.
+runargs=(--quiet --scope --no-ask-password --same-dir -p MemoryMax=10M)
+cmdline="$here/src/usemem_and_swapoff $((50 * 1048576))"
+
+# The first time, the program allocates 50MB of space and dirties every page to
+# try to get the program swapped out to disk.  It will then try to mlock all
+# 50MB, which it shouldn't be able to do if the memory controller is doing its
+# job.  This is critical to test swapping the program back in.
+#
+# Note: The bash stdout/stderr redirection muddiness is needed to capture bash
+# complaining about the usemem_and_swapoff program being killed by the kernel.
+prog=( bash -c "$cmdline &> $tmp.prog" )
+( $SYSTEMD_RUN_PROG "${runargs[@]}" "${prog[@]}" &> $tmp.wrap ) ; ret=$?
+
+# Record the output of the first attempt.
+cat $tmp.prog | tee -a $seqres.full
+grep -q Killed $tmp.wrap || \
+	echo "mlock didn't cause OOM kill; memory limit enforcement might not be working"
+cat $tmp.wrap >> $seqres.full
+echo "return value $ret" >> $seqres.full
+
+# The second time, the program again allocates 50MB and dirties it.  However,
+# this time the program tries to enable swapfile2 and disable swapfile1, which
+# should result in the program being paged in from swapfile1 and paged out to
+# swapfile2.  The program should be able to continue accessing its memory.
+prog=( bash -c "$cmdline $swapfile1 $swapfile2 &> $tmp.prog" )
+( $SYSTEMD_RUN_PROG "${runargs[@]}" "${prog[@]}" &> $tmp.wrap ) ; ret=$?
+
+# Record the output of the second attempt.
+cat $tmp.prog | tee -a $seqres.full
+grep -q Killed $tmp.wrap && echo "swapfile swap should not have killed program"
+cat $tmp.wrap >> $seqres.full
+echo "return value $ret" >> $seqres.full
+
+# Make sure the final state of the swap devices is what we think it should be.
+cat /proc/swaps >> $seqres.full
+saw_swapfile1=0
+saw_swapfile2=0
+while read fname type size used priority junk; do
+	test "$fname" = "Filename" && continue
+	test "$fname" -ef "$swapfile1" && saw_swapfile1=1
+	if [ "$fname" -ef "$swapfile2" ]; then
+		test "$priority" -eq "$SWAP_FLAG_PRIO_MASK" || \
+			echo "swapfile2 has wrong priority $priority?"
+		saw_swapfile2=1
+		continue
+	fi
+done < /proc/swaps
+
+test "$saw_swapfile1" -eq 0 || \
+	echo "swapfile1 should not be present in /proc/swaps"
+test "$saw_swapfile2" -eq 1 || \
+	echo "swapfile2 should be present in /proc/swaps"
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/728.out b/tests/generic/728.out
new file mode 100644
index 00000000..26bdae14
--- /dev/null
+++ b/tests/generic/728.out
@@ -0,0 +1,9 @@
+QA output created by 728
+Allocating 52428800 memory.
+Dirtying memory.
+Now mlocking memory.
+Allocating 52428800 memory.
+Dirtying memory.
+Now activating swapfile2.
+Now deactivating swapfile1.
+Silence is golden
