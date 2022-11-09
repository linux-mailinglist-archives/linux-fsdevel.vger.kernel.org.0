Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40BE623251
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKISWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKISWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:22:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E81286E4;
        Wed,  9 Nov 2022 10:22:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37A9061ADA;
        Wed,  9 Nov 2022 18:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9899EC433C1;
        Wed,  9 Nov 2022 18:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668018170;
        bh=zHBVstQ6JV42jZAWewgmlbN4FmGsSeImNrYbGP0eOjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GiNIuFoyZ9VAfJcguKhOR+yUsd2Z0vtNz6J2YkDpvGaZ0KyZZfuCXJUigpsz5cpsD
         mdn/4X5kuqHkZPFlyJZ0yYm1Vcbys40fwQpYafEHunia2JMcZH6z9wisfA3POeoIOS
         YQ023Pn/Pu3nMZcDj6fgrrOsf7VcHKsOBx/gdRzTtmAwwuxcysZ4lizx3Gp7lv0SRx
         nPhH4G+uzjGfr9cZl32JG6hYVahRuR7IL3tnYTEGz6Xw4o2Q9AeH0pInT67UwjxnMC
         yG7p66kTID7rjCh8VGfia3gBbS4xdWqZXl9gyZy2edzyTxTt6pwc+9yB2mdfhKC0UU
         R1TbCtRB2tMpQ==
Date:   Wed, 9 Nov 2022 10:22:50 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Subject: [PATCH 15/14] fstest: regression test for writeback corruption bug
Message-ID: <Y2vv+tdWVEStVpaO@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

This is a regression test for a data corruption bug that existed in XFS'
copy on write code between 4.9 and 4.19.  The root cause is a
concurrency bug wherein we would drop ILOCK_SHARED after querying the
CoW fork in xfs_map_cow and retake it before querying the data fork in
xfs_map_blocks.  See the test description for a lot more details.

Cc: Wengang Wang <wen.gang.wang@oracle.com>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/924     |  197 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/924.out |    2 +
 2 files changed, 199 insertions(+)
 create mode 100755 tests/xfs/924
 create mode 100644 tests/xfs/924.out

diff --git a/tests/xfs/924 b/tests/xfs/924
new file mode 100755
index 0000000000..486afefedd
--- /dev/null
+++ b/tests/xfs/924
@@ -0,0 +1,197 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Oracle.  All Rights Reserved.
+#
+# FS QA Test 924
+#
+# This is a regression test for a data corruption bug that existed in XFS' copy
+# on write code between 4.9 and 4.19.  The root cause is a concurrency bug
+# wherein we would drop ILOCK_SHARED after querying the CoW fork in xfs_map_cow
+# and retake it before querying the data fork in xfs_map_blocks.  If a second
+# thread changes the CoW fork mappings between the two calls, it's possible for
+# xfs_map_blocks to return a zero-block mapping, which results in writeback
+# being elided for that block.  Elided writeback of dirty data results in
+# silent loss of writes.
+#
+# Worse yet, kernels from that era still used buffer heads, which means that an
+# elided writeback leaves the page clean but the bufferheads dirty.  Due to a
+# naïve optimization in mark_buffer_dirty, the SetPageDirty call is elided if
+# the bufferhead is dirty, which means that a subsequent rewrite of the data
+# block will never result in the page being marked dirty, and all subsequent
+# writes are lost.
+#
+# It turns out that Christoph Hellwig unwittingly fixed the race in commit
+# 5c665e5b5af6 ("xfs: remove xfs_map_cow"), and no testcase was ever written.
+# Four years later, we hit it on a production 4.14 kernel.  This testcase
+# relies on a debugging knob that introduces artificial delays into writeback.
+#
+# Before the race, the file blocks 0-1 are not shared and blocks 2-5 are
+# shared.  There are no extents in CoW fork.
+#
+# Two threads race like this:
+#
+# Thread 1 (writeback block 0)     | Thread 2  (write to block 2)
+# ---------------------------------|--------------------------------
+#                                  |
+# 1. Check if block 0 in CoW fork  |
+#    from xfs_map_cow.             |
+#                                  |
+# 2. Block 0 not found in CoW      |
+#    fork; the block is considered |
+#    not shared.                   |
+#                                  |
+# 3. xfs_map_blocks looks up data  |
+#    fork to get a map covering    |
+#    block 0.                      |
+#                                  |
+# 4. It gets a data fork mapping   |
+#    for block 0 with length 2.    |
+#                                  |
+#                                  | 1. A buffered write to block 2 sees
+#                                  |    that it is a shared block and no
+#                                  |    extent covers block 2 in CoW fork.
+#                                  |
+#                                  |    It creates a new CoW fork mapping.
+#                                  |    Due to the cowextsize, the new
+#                                  |    extent starts at block 0 with
+#                                  |    length 128.
+#                                  |
+#                                  |
+# 5. It lookup CoW fork again to   |
+#    trim the map (0, 2) to a      |
+#    shared block boundary.        |
+#                                  |
+# 5a. It finds (0, 128) in CoW fork|
+# 5b. It trims the data fork map   |
+#     from (0, 1) to (0, 0) (!!!)  |
+#                                  |
+# 6. The xfs_imap_valid call after |
+#    the xfs_map_blocks call checks|
+#    if the mapping (0, 0) covers  |
+#    block 0.  The result is "NO". |
+#                                  |
+# 7. Since block 0 has no physical |
+#    block mapped, it's not added  |
+#    to the ioend.  This is the    |
+#    first problem.                |
+#                                  |
+# 8. xfs_add_to_ioend usually      |
+#    clears the bufferhead dirty   |
+#    flag  Because this is skipped,|
+#    we leave the page clean with  |
+#    the associated buffer head(s) |
+#    dirty (the second problem).   |
+#    Now the dirty state is        |
+#    inconsistent.
+#
+# On newer kernels, this is also a functionality test for the ifork sequence
+# counter because the writeback completions will change the data fork and force
+# revalidations of the wb mapping.
+#
+. ./common/preamble
+_begin_fstest auto quick clone
+
+# Import common functions.
+. ./common/reflink
+. ./common/inject
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_fixed_by_kernel_commit 5c665e5b5af6 "xfs: remove xfs_map_cow"
+_require_error_injection
+_require_scratch_reflink
+_require_cp_reflink
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+knob="$(_find_xfs_mountdev_errortag_knob $SCRATCH_DEV "wb_delay_ms")"
+test -w "$knob" || _notrun "Kernel does not have wb_delay_ms error injector"
+
+blksz=65536
+_require_congruent_file_oplen $SCRATCH_MNT $blksz
+
+# Make sure we have sufficient extent size to create speculative CoW
+# preallocations.
+$XFS_IO_PROG -c 'cowextsize 1m' $SCRATCH_MNT
+
+# Write out a file with the first two blocks unshared and the rest shared.
+_pwrite_byte 0x59 0 $((160 * blksz)) $SCRATCH_MNT/file >> $seqres.full
+_pwrite_byte 0x59 0 $((160 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
+sync
+
+_cp_reflink $SCRATCH_MNT/file $SCRATCH_MNT/file.reflink
+
+_pwrite_byte 0x58 0 $((2 * blksz)) $SCRATCH_MNT/file >> $seqres.full
+_pwrite_byte 0x58 0 $((2 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
+sync
+
+# Avoid creation of large folios on newer kernels by cycling the mount and
+# immediately writing to the page cache.
+_scratch_cycle_mount
+
+# Write the same data to file.compare as we're about to do to file.  Do this
+# before slowing down writeback to avoid unnecessary delay.
+_pwrite_byte 0x57 0 $((2 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
+_pwrite_byte 0x56 $((2 * blksz)) $((2 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
+sync
+
+# Introduce a half-second wait to each writeback block mapping call.  This
+# gives us a chance to race speculative cow prealloc with writeback.
+wb_delay=500
+echo $wb_delay > $knob
+curval="$(cat $knob)"
+test "$curval" -eq $wb_delay || echo "expected wb_delay_ms == $wb_delay"
+
+# Start thread 1 + writeback above
+$XFS_IO_PROG -c "pwrite -S 0x57 0 $((2 * blksz))" \
+	-c 'bmap -celpv' -c 'bmap -elpv' \
+	-c 'fsync' $SCRATCH_MNT/file >> $seqres.full &
+sleep 1
+
+# Start a sentry to look for evidence of the XFS_ERRORTAG_REPORT logging.  If
+# we see that, we know we've forced writeback to revalidate a mapping.  The
+# test has been successful, so turn off the delay.
+sentryfile=$TEST_DIR/$seq.sentry
+wait_for_errortag() {
+	while [ -e "$sentryfile" ]; do
+		if _check_dmesg_for XFS_ERRTAG_WB_DELAY_MS; then
+			echo 0 > $knob
+			break;
+		fi
+		sleep 1
+	done
+}
+touch $sentryfile
+wait_for_errortag &
+
+# Start thread 2 to create the cowextsize reservation
+$XFS_IO_PROG -c "pwrite -S 0x56 $((2 * blksz)) $((2 * blksz))" \
+	-c 'bmap -celpv' -c 'bmap -elpv' \
+	-c 'fsync' $SCRATCH_MNT/file >> $seqres.full
+rm -f $sentryfile
+
+_check_dmesg_for XFS_ERRTAG_WB_DELAY_MS
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
diff --git a/tests/xfs/924.out b/tests/xfs/924.out
new file mode 100644
index 0000000000..c6655da35a
--- /dev/null
+++ b/tests/xfs/924.out
@@ -0,0 +1,2 @@
+QA output created by 924
+Silence is golden
