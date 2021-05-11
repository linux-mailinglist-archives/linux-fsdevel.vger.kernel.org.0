Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C26379D81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 05:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhEKDLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 23:11:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41093 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230252AbhEKDLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 23:11:40 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A+lD4Rq1utQ0JgGlxWavvzAqjBFQkLtp133Aq?=
 =?us-ascii?q?2lEZdPRUGvb4qynIpoVj6faUskdoZJhOo6HiBEDtexzhHNtOkO0s1NSZLW/bUQ?=
 =?us-ascii?q?mTXeNfBOLZqlWKcUCTygce79YGT0EUMr3N5DZB4/oSmDPIdurI3uP3jJyAtKPP?=
 =?us-ascii?q?yWt3VwF2Z+VF5wd9MAySFUp7X2B9dOAEPavZ9sxavCChZHhSSsy6A0MOV+/Fq8?=
 =?us-ascii?q?aOu4nhZXc9dmMawTjLnTW186T7DhTd+h8fVglEybAk/XOAsyGR3NTZj82G?=
X-IronPort-AV: E=Sophos;i="5.82,290,1613404800"; 
   d="scan'208";a="108110580"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 May 2021 11:10:29 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 80FF94D0B8A5;
        Tue, 11 May 2021 11:10:26 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 11 May 2021 11:10:17 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 11 May 2021 11:10:14 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <viro@zeniv.linux.org.uk>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>
Subject: [PATCH v5 7/7] fs/xfs: Add dax dedupe support
Date:   Tue, 11 May 2021 11:09:33 +0800
Message-ID: <20210511030933.3080921-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 80FF94D0B8A5.A153C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce xfs_mmaplock_two_inodes_and_break_dax_layout() for dax files
who are going to be deduped.  After that, call compare range function
only when files are both DAX or not.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/xfs_file.c    |  2 +-
 fs/xfs/xfs_inode.c   | 66 +++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_inode.h   |  1 +
 fs/xfs/xfs_reflink.c |  4 +--
 4 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 38d8eca05aee..bd5002d38df4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -823,7 +823,7 @@ xfs_wait_dax_page(
 	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
 }
 
-static int
+int
 xfs_break_dax_layouts(
 	struct inode		*inode,
 	bool			*retry)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 0369eb22c1bb..0774b6e2b940 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3711,6 +3711,64 @@ xfs_iolock_two_inodes_and_break_layout(
 	return 0;
 }
 
+static int
+xfs_mmaplock_two_inodes_and_break_dax_layout(
+	struct inode		*src,
+	struct inode		*dest)
+{
+	int			error, attempts = 0;
+	bool			retry;
+	struct xfs_inode	*ip0, *ip1;
+	struct page		*page;
+	struct xfs_log_item	*lp;
+
+	if (src > dest)
+		swap(src, dest);
+	ip0 = XFS_I(src);
+	ip1 = XFS_I(dest);
+
+again:
+	retry = false;
+	/* Lock the first inode */
+	xfs_ilock(ip0, XFS_MMAPLOCK_EXCL);
+	error = xfs_break_dax_layouts(src, &retry);
+	if (error || retry) {
+		xfs_iunlock(ip0, XFS_MMAPLOCK_EXCL);
+		goto again;
+	}
+
+	if (src == dest)
+		return 0;
+
+	/* Nested lock the second inode */
+	lp = &ip0->i_itemp->ili_item;
+	if (lp && test_bit(XFS_LI_IN_AIL, &lp->li_flags)) {
+		if (!xfs_ilock_nowait(ip1,
+		    xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1))) {
+			xfs_iunlock(ip0, XFS_MMAPLOCK_EXCL);
+			if ((++attempts % 5) == 0)
+				delay(1); /* Don't just spin the CPU */
+			goto again;
+		}
+	} else
+		xfs_ilock(ip1, xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1));
+	/*
+	 * We cannot use xfs_break_dax_layouts() directly here because it may
+	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
+	 * for this nested lock case.
+	 */
+	page = dax_layout_busy_page(dest->i_mapping);
+	if (page) {
+		if (page_ref_count(page) != 1) {
+			xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
+			xfs_iunlock(ip0, XFS_MMAPLOCK_EXCL);
+			goto again;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Lock two inodes so that userspace cannot initiate I/O via file syscalls or
  * mmap activity.
@@ -3721,10 +3779,16 @@ xfs_ilock2_io_mmap(
 	struct xfs_inode	*ip2)
 {
 	int			ret;
+	struct inode		*ino1 = VFS_I(ip1);
+	struct inode		*ino2 = VFS_I(ip2);
 
-	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
+	ret = xfs_iolock_two_inodes_and_break_layout(ino1, ino2);
 	if (ret)
 		return ret;
+
+	if (IS_DAX(ino1) && IS_DAX(ino2))
+		return xfs_mmaplock_two_inodes_and_break_dax_layout(ino1, ino2);
+
 	if (ip1 == ip2)
 		xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
 	else
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index ca826cfba91c..2d0b344fb100 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -457,6 +457,7 @@ enum xfs_prealloc_flags {
 
 int	xfs_update_prealloc_flags(struct xfs_inode *ip,
 				  enum xfs_prealloc_flags flags);
+int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 9a780948dbd0..ff308304c5cd 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1324,8 +1324,8 @@ xfs_reflink_remap_prep(
 	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
 		goto out_unlock;
 
-	/* Don't share DAX file data for now. */
-	if (IS_DAX(inode_in) || IS_DAX(inode_out))
+	/* Don't share DAX file data with non-DAX file. */
+	if (IS_DAX(inode_in) != IS_DAX(inode_out))
 		goto out_unlock;
 
 	if (!IS_DAX(inode_in))
-- 
2.31.1



