Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18633F100F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 03:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhHSBoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 21:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234194AbhHSBoC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 21:44:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 257D3610A6;
        Thu, 19 Aug 2021 01:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629337407;
        bh=GC3zQLwOCTXI1Hy8arlkjDvFnmMVXirkECLD9NWUEK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bhr/l2gh1DWFy643i6FLr5pk+Lfa1MGvmI3G1CV5wpNoFsP29zKcOoQVo6bz0yetv
         QOK6EWOvg4y1LgXvpXKj341N2p04UZ6df2EWFj02+0+lpXv29wbWy4Gz3i7qTEKeLt
         yD4CWmV5Xck5zmkcy8nlMSWyekzFI7gjgDz3ZrEunvLtIjPQzSvPJAL1QuHbzooS0j
         g7v8ZxrpodgVfmr3y2eIKWmAeQWrjr/VDJtBZ9yaHAieiBF/bzP76ZNnEZL/rdgt3B
         bWe2USL7Aq7ja1h5jZt9tDT0IjsGzTDDsj28KmbZ6dme8DjPeBtIePW6BP2e8iwN+B
         z9Lq45wygPGaQ==
Date:   Wed, 18 Aug 2021 18:43:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Xu Yu <xuyu@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, riteshh@linux.ibm.com, tytso@mit.edu,
        gavin.dg@linux.alibaba.com, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: [PATCH] generic: add swapfile maxpages regression test
Message-ID: <20210819014326.GC12597@magnolia>
References: <db99c25a8e2a662046e498fd13e5f0c35364164a.1629286473.git.xuyu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db99c25a8e2a662046e498fd13e5f0c35364164a.1629286473.git.xuyu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add regression test for "mm/swap: consider max pages in
iomap_swapfile_add_extent".

Cc: Gang Deng <gavin.dg@linux.alibaba.com>
Cc: Xu Yu <xuyu@linux.alibaba.com>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/generic/727     |   62 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/727.out |    2 ++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/generic/727
 create mode 100644 tests/generic/727.out

diff --git a/tests/generic/727 b/tests/generic/727
new file mode 100755
index 00000000..a546ad51
--- /dev/null
+++ b/tests/generic/727
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Oracle.  All Rights Reserved.
+#
+# FS QA Test 727
+#
+# Regression test for "mm/swap: consider max pages in iomap_swapfile_add_extent"
+
+# Xu Yu found that the iomap swapfile activation code failed to constrain
+# itself to activating however many swap pages that the mm asked us for.  This
+# is an deviation in behavior from the classic swapfile code.  It also leads to
+# kernel memory corruption if the swapfile is cleverly constructed.
+#
+. ./common/preamble
+_begin_fstest auto swap
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	test -n "$swapfile" && swapoff $swapfile &> /dev/null
+}
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch_swapfile
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+# Assuming we're not borrowing a FAT16 partition from Windows 3.1, we need an
+# unlikely enough name that we can grep /proc/swaps for this.
+swapfile=$SCRATCH_MNT/386spart.par
+_format_swapfile $swapfile 1m >> $seqres.full
+
+swapfile_pages() {
+	local swapfile="$1"
+
+	grep "$swapfile" /proc/swaps | awk '{print $3}'
+}
+
+_swapon_file $swapfile
+before_pages=$(swapfile_pages "$swapfile")
+swapoff $swapfile
+
+# Extend the length of the swapfile but do not rewrite the header.
+# The subsequent swapon should set up 1MB worth of pages, not 2MB.
+$XFS_IO_PROG -f -c 'pwrite 1m 1m' $swapfile >> $seqres.full
+
+_swapon_file $swapfile
+after_pages=$(swapfile_pages "$swapfile")
+swapoff $swapfile
+
+# Both swapon attempts should have found the same number of pages.
+test "$before_pages" -eq "$after_pages" || \
+	echo "swapon added $after_pages pages, expected $before_pages"
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/727.out b/tests/generic/727.out
new file mode 100644
index 00000000..2de2b4b2
--- /dev/null
+++ b/tests/generic/727.out
@@ -0,0 +1,2 @@
+QA output created by 727
+Silence is golden
