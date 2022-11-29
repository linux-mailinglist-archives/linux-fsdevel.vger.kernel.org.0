Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D3563CAB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 22:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiK2Vzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 16:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiK2Vzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:55:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAF42A73E;
        Tue, 29 Nov 2022 13:55:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDE1F61929;
        Tue, 29 Nov 2022 21:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C47C433C1;
        Tue, 29 Nov 2022 21:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669758948;
        bh=qEkdvyF9EQok0uusEQI+qn66GMwF4lBJDqrpt2BMRqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4A4kPbr0L/rv2Xn8e+29Lj99GpJP1Ds9QsaAvrz88/BBzDm8LSW9vXcUHKJeohnH
         hP/0tZCi65kxFl0hgDWfU04KBo1TtxUEfNvZFPWZtqfaBmKi1Wx8Qy+F6uIysd/mUd
         ufCn6RtZl5HKF1M5FCfaNZMo5rSEuFMwFsH0i+qayEQPCoVQf0lIS4s9iQOEVeWaJO
         m2mf7D7msMIIEuuWaBgImliS2lO3Fin9mNsH5ODxnUg221lZE0MEBU48B8TwyGINC5
         KMI35ihlf/2rCmHA6irZJMaYtjIe4A41m0g0dgEGwuFDcq4kne66zb8y5Bkv0y3HPM
         fSzrV0K3FN/8w==
Date:   Tue, 29 Nov 2022 13:55:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fstests <fstests@vger.kernel.org>
Subject: [RFC PATCH] xfs: regression test for writes racing with reclaim
 writeback
Message-ID: <Y4Z/45QkWgn23oQw@magnolia>
References: <20221123055812.747923-1-david@fromorbit.com>
 <Y4U3dj5qvpKSQuNM@magnolia>
 <Y4VeuqfVBU4/x9aB@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4VeuqfVBU4/x9aB@magnolia>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

This test uses the new write delay debug knobs to set up a slow-moving
write racing with writeback of an unwritten block at the end of the
file range targetted by the slow write.  The test succeeds if the file
does not end up corrupt and if the ftrace log captures a message about
the revalidation occurring.

NOTE: I'm not convinced that madvise actually causes the page to be
removed from the pagecache, which means that this is effectively a
functional test for the invalidation, not a corruption reproducer.
On the other hand, the functional test can be done quickly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
This test has been adapted to use the tracepoints defined in the final
version of this patch.
---
 tests/xfs/925     |  127 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/925.out |    2 +
 2 files changed, 129 insertions(+)
 create mode 100755 tests/xfs/925
 create mode 100644 tests/xfs/925.out

diff --git a/tests/xfs/925 b/tests/xfs/925
new file mode 100755
index 0000000000..6503377c0f
--- /dev/null
+++ b/tests/xfs/925
@@ -0,0 +1,127 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Oracle.  All Rights Reserved.
+#
+# FS QA Test 925
+#
+# This is a regression test for a data corruption bug that existed in iomap's
+# buffered write routines.
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+# Import common functions.
+. ./common/inject
+. ./common/tracing
+
+# real QA test starts here
+_cleanup()
+{
+	_ftrace_cleanup
+	cd /
+	rm -r -f $tmp.* $sentryfile $tracefile
+}
+
+# Modify as appropriate.
+_supported_fs xfs
+_require_ftrace
+_require_error_injection
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+# This is a pagecache test, so try to disable fsdax mode.
+$XFS_IO_PROG -c 'chattr -x' $SCRATCH_MNT &> $seqres.full
+_require_pagecache_access $SCRATCH_MNT
+
+knob="$(_find_xfs_mountdev_errortag_knob $SCRATCH_DEV "write_delay_ms")"
+test -w "$knob" || _notrun "Kernel does not have write_delay_ms error injector"
+
+blocks=10
+blksz=$(get_page_size)
+filesz=$((blocks * blksz))
+dirty_offset=$(( filesz - 1 ))
+write_len=$(( ( (blocks - 1) * blksz) + 1 ))
+
+# Create a large file with a large unwritten range.
+$XFS_IO_PROG -f -c "falloc 0 $filesz" $SCRATCH_MNT/file >> $seqres.full
+
+# Write the same data to file.compare as we're about to do to file.  Do this
+# before slowing down writeback to avoid unnecessary delay.
+_pwrite_byte 0x58 $dirty_offset 1 $SCRATCH_MNT/file.compare >> $seqres.full
+_pwrite_byte 0x57 0 $write_len $SCRATCH_MNT/file.compare >> $seqres.full
+
+# Reinitialize the page cache for this file.
+_scratch_cycle_mount
+
+# Dirty the last page in the range and immediately set the write delay so that
+# any subsequent writes have to wait.
+$XFS_IO_PROG -c "pwrite -S 0x58 $dirty_offset 1" $SCRATCH_MNT/file >> $seqres.full
+write_delay=500
+echo $write_delay > $knob
+curval="$(cat $knob)"
+test "$curval" -eq $write_delay || echo "expected write_delay_ms == $write_delay"
+
+_ftrace_record_events 'xfs_iomap_invalid'
+
+# Start a sentry to look for evidence of the XFS_ERRORTAG_REPORT logging.  If
+# we see that, we know we've forced writeback to revalidate a mapping.  The
+# test has been successful, so turn off the delay.
+sentryfile=$TEST_DIR/$seq.sentry
+tracefile=$TEST_DIR/$seq.ftrace
+wait_for_errortag() {
+	while [ -e "$sentryfile" ]; do
+		_ftrace_dump | grep iomap_invalid >> "$tracefile"
+		if grep -q iomap_invalid "$tracefile"; then
+			echo 0 > $knob
+			_ftrace_ignore_events
+			break;
+		fi
+		sleep 0.5
+	done
+}
+touch $sentryfile
+wait_for_errortag &
+
+# Start thread 1 + writeback above
+($XFS_IO_PROG -c "pwrite -S 0x57 -b $write_len 0 $write_len" \
+	-c 'bmap -celpv' -c 'bmap -elpv' \
+	$SCRATCH_MNT/file >> $seqres.full; rm -f $sentryfile) &
+sleep 1
+
+# Start thread 2 to simulate reclaim writeback via sync_file_range and fadvise
+# to drop the page cache.
+#	-c "fadvise -d $dirty_offset 1" \
+dirty_pageoff=$((filesz - blksz))
+$XFS_IO_PROG -c "sync_range -a -w $dirty_pageoff $blksz" \
+	-c "mmap -r 0 $filesz" \
+	-c "madvise -d 0 $filesz" \
+	-c 'bmap -celpv' -c 'bmap -elpv' \
+	$SCRATCH_MNT/file >> $seqres.full
+wait
+rm -f $sentryfile
+
+cat "$tracefile" >> $seqres.full
+grep -q iomap_invalid "$tracefile"
+saw_invalidation=$?
+
+# Flush everything to disk.  If the bug manifests, then after the cycle,
+# file should have stale 0x58 in block 0 because we silently dropped a write.
+_scratch_cycle_mount
+
+if ! cmp -s $SCRATCH_MNT/file $SCRATCH_MNT/file.compare; then
+	echo file and file.compare do not match
+	$XFS_IO_PROG -c 'bmap -celpv' -c 'bmap -elpv' $SCRATCH_MNT/file >> $seqres.full
+	echo file.compare
+	od -tx1 -Ad -c $SCRATCH_MNT/file.compare
+	echo file
+	od -tx1 -Ad -c $SCRATCH_MNT/file
+elif [ $saw_invalidation -ne 0 ]; then
+	# The files matched, but nothing got logged about the revalidation?
+	echo "Expected to hear about write iomap invalidation?"
+fi
+
+echo Silence is golden
+status=0
+exit
diff --git a/tests/xfs/925.out b/tests/xfs/925.out
new file mode 100644
index 0000000000..95088ce8a5
--- /dev/null
+++ b/tests/xfs/925.out
@@ -0,0 +1,2 @@
+QA output created by 925
+Silence is golden
