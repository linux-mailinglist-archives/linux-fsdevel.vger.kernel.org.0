Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89B623259
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKISXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiKISXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:23:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8152E36;
        Wed,  9 Nov 2022 10:23:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A4CFB81F6B;
        Wed,  9 Nov 2022 18:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059A4C433D6;
        Wed,  9 Nov 2022 18:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668018205;
        bh=OCN/MuPudOIiYGe+mfIe1J1IGzJ9644oGX0ZChz5SZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vK2nB1LHfXzK3JRxtXGLFhHHHQcY+HEOI3g8OUG8ASNJXP9bShpJeUaHQxTiCAcdH
         IVQgMDds0029AgTf21m07IVNr3xa9gLLEFsZYHxWntOMqYywWTC5Vvqj5oGvKjEKyB
         mchf5zVAgOTXB2lLbaonzgDcLqv7x0QjnOTAnwlaUONI+bzT2o7Lo+fbEXJi+9XAbz
         VSy/i9JD+zkt7aknl0l0gZukoaGMFs/vFU0A7RQ3uyRzo9SjDJMyQcSpDOf+8Lc54w
         ThDfxwdJu4LRGr1RJPfFoV7uVETLJyI68tGSEtptPevZNZ7txcWrOzgr9s+XTyVU17
         60rGVzbS8Jy0Q==
Date:   Wed, 9 Nov 2022 10:23:24 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Subject: [PATCH 16/14] fstest: regression test for writes racing with reclaim
 writeback
Message-ID: <Y2vwHNa8e23jwBNB@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166801774453.3992140.241667783932550826.stgit@magnolia>
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
does not end up corrupt and if the kernel log contains a log message
about the revalidation occurring.

NOTE: I'm not convinced that madvise actually causes the page to be
removed from the pagecache, which means that this is effectively a
functional test for the invalidation, not a corruption reproducer.
On the other hand, the functional test can be done quickly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/925     |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/925.out |    2 +
 2 files changed, 112 insertions(+)
 create mode 100755 tests/xfs/925
 create mode 100644 tests/xfs/925.out

diff --git a/tests/xfs/925 b/tests/xfs/925
new file mode 100755
index 0000000000..53699c0167
--- /dev/null
+++ b/tests/xfs/925
@@ -0,0 +1,110 @@
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
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+#_fixed_by_kernel_commit 5c665e5b5af6 "xfs: remove xfs_map_cow"
+_require_error_injection
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
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
+# Start a sentry to look for evidence of the XFS_ERRORTAG_REPORT logging.  If
+# we see that, we know we've forced writeback to revalidate a mapping.  The
+# test has been successful, so turn off the delay.
+sentryfile=$TEST_DIR/$seq.sentry
+wait_for_errortag() {
+	while [ -e "$sentryfile" ]; do
+		if _check_dmesg_for XFS_ERRTAG_WRITE_DELAY_MS; then
+			echo 0 > $knob
+			break;
+		fi
+		sleep 1
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
+# to drop the page cache.  XXX does that actually work?
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
+_check_dmesg_for XFS_ERRTAG_WRITE_DELAY_MS
+saw_delay=$?
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
+elif [ $saw_delay -ne 0 ]; then
+	# The files matched, but nothing got logged about the revalidation?
+	echo "Expected to hear about XFS_ERRTAG_WB_DELAY_MS?"
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
