Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061097A562A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 01:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjIRXTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 19:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRXTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:19:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB2999;
        Mon, 18 Sep 2023 16:19:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18D4C433C7;
        Mon, 18 Sep 2023 23:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695079185;
        bh=I/gQLzyHAMGpNPEq1NYGX8rh0f0JTnkhTQOsHXvb3d8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=SOlIvMjR0fMsbzEo91/hRydnijOpuZ4B4D9juFJEKV5tO51qbdd+Dvsw1xt+uI0sh
         inFdRgSyF/Q6wkkbq206qwXnmABhca/f2sdgef12AmAjbHW47sy7KYtb1FtFCcaM3Z
         XJVxpRjoN6x+wcB9NCd9V2DHxDaqWzyhvBUYO8uCbTyiiY+I87TfyfAVcweqJMC4cO
         usFLHG1ka5bCQbCJ3dQHUxAgjGwQ2mOQuugj6zVYO+7ruV5NU8Lks9OD1WyGfyNp2j
         RWB5lcgiVE1JEGdhZR7+9mBqUCMu1zllxhPu2BjaQl9U1vXpcmop4FTuRmi7PNfR0r
         2e6Rk9N5KPvFw==
Date:   Mon, 18 Sep 2023 16:19:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     ritesh.list@gmail.com, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 3/2] fstests: test FALLOC_FL_UNSHARE when pagecache is not
 loaded
Message-ID: <20230918231945.GC348018@frogsfrogsfrogs>
References: <169507871947.772278.5767091361086740046.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169507871947.772278.5767091361086740046.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a regression test for funsharing uncached files to ensure that we
actually manage the pagecache state correctly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/1936     |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/1936.out |    4 ++
 2 files changed, 92 insertions(+)
 create mode 100755 tests/xfs/1936
 create mode 100644 tests/xfs/1936.out

diff --git a/tests/xfs/1936 b/tests/xfs/1936
new file mode 100755
index 0000000000..bcf9b6b478
--- /dev/null
+++ b/tests/xfs/1936
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Oracle.  All Rights Reserved.
+#
+# FS QA Test 1936
+#
+# This is a regression test for the kernel commit noted below.  The stale
+# memory exposure can be exploited by creating a file with shared blocks,
+# evicting the page cache for that file, and then funshareing at least one
+# memory page's worth of data.  iomap will mark the page uptodate and dirty
+# without ever reading the ondisk contents.
+#
+. ./common/preamble
+_begin_fstest auto quick unshare clone
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.* $testdir
+}
+
+# real QA test starts here
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+. ./common/reflink
+
+_fixed_by_git_commit kernel XXXXXXXXXXXXX \
+	"iomap: don't skip reading in !uptodate folios when unsharing a range"
+
+# real QA test starts here
+_require_test_reflink
+_require_cp_reflink
+_require_xfs_io_command "funshare"
+
+testdir=$TEST_DIR/test-$seq
+rm -rf $testdir
+mkdir $testdir
+
+# Create a file that is at least four pages in size and aligned to the
+# file allocation unit size so that we don't trigger any unnecessary zeroing.
+pagesz=$(_get_page_size)
+alloc_unit=$(_get_file_block_size $TEST_DIR)
+filesz=$(( ( (4 * pagesz) + alloc_unit - 1) / alloc_unit * alloc_unit))
+
+echo "Create the original file and a clone"
+_pwrite_byte 0x61 0 $filesz $testdir/file2.chk >> $seqres.full
+_pwrite_byte 0x61 0 $filesz $testdir/file1 >> $seqres.full
+_cp_reflink $testdir/file1 $testdir/file2
+_cp_reflink $testdir/file1 $testdir/file3
+
+_test_cycle_mount
+
+cat $testdir/file3 > /dev/null
+
+echo "Funshare at least one pagecache page"
+$XFS_IO_PROG -c "funshare 0 $filesz" $testdir/file2
+$XFS_IO_PROG -c "funshare 0 $filesz" $testdir/file3
+_pwrite_byte 0x61 0 $filesz $testdir/file2.chk >> $seqres.full
+
+echo "Check contents"
+
+# file2 wasn't cached when it was unshared, but it should match
+if ! cmp -s $testdir/file2.chk $testdir/file2; then
+	echo "file2.chk does not match file2"
+
+	echo "file2.chk contents" >> $seqres.full
+	od -tx1 -Ad -c $testdir/file2.chk >> $seqres.full
+	echo "file2 contents" >> $seqres.full
+	od -tx1 -Ad -c $testdir/file2 >> $seqres.full
+	echo "end bad contents" >> $seqres.full
+fi
+
+# file3 was cached when it was unshared, and it should match
+if ! cmp -s $testdir/file2.chk $testdir/file3; then
+	echo "file2.chk does not match file3"
+
+	echo "file2.chk contents" >> $seqres.full
+	od -tx1 -Ad -c $testdir/file2.chk >> $seqres.full
+	echo "file3 contents" >> $seqres.full
+	od -tx1 -Ad -c $testdir/file3 >> $seqres.full
+	echo "end bad contents" >> $seqres.full
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/1936.out b/tests/xfs/1936.out
new file mode 100644
index 0000000000..c7c820ced5
--- /dev/null
+++ b/tests/xfs/1936.out
@@ -0,0 +1,4 @@
+QA output created by 1936
+Create the original file and a clone
+Funshare at least one pagecache page
+Check contents
