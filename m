Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8485D3ECE64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 08:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhHPGFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 02:05:32 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38883 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233477AbhHPGFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:05:24 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AOV8yt65SIuBaGD4ywAPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="112944888"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Aug 2021 14:04:47 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 4E47F4D0D4BB;
        Mon, 16 Aug 2021 14:04:43 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 16 Aug 2021 14:04:42 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 16 Aug 2021 14:04:41 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>
Subject: [PATCH v7 8/8] fs/xfs: Add dax dedupe support
Date:   Mon, 16 Aug 2021 14:03:59 +0800
Message-ID: <20210816060359.1442450-9-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4E47F4D0D4BB.A23D4
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c    |  2 +-
 fs/xfs/xfs_inode.c   | 57 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.h   |  1 +
 fs/xfs/xfs_reflink.c |  4 ++--
 4 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 226e3fbaf405..4765abfe777e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -846,7 +846,7 @@ xfs_wait_dax_page(
 	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
 }
 
-static int
+int
 xfs_break_dax_layouts(
 	struct inode		*inode,
 	bool			*retry)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 990b72ae3635..4b44d9d1e42a 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3727,6 +3727,59 @@ xfs_iolock_two_inodes_and_break_layout(
 	return 0;
 }
 
+static int
+xfs_mmaplock_two_inodes_and_break_dax_layout(
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2)
+{
+	int			error, attempts = 0;
+	bool			retry;
+	struct page		*page;
+	struct xfs_log_item	*lp;
+
+	if (ip1->i_ino > ip2->i_ino)
+		swap(ip1, ip2);
+
+again:
+	retry = false;
+	/* Lock the first inode */
+	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
+	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
+	if (error || retry) {
+		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
+		goto again;
+	}
+
+	if (ip1 == ip2)
+		return 0;
+
+	/* Nested lock the second inode */
+	lp = &ip1->i_itemp->ili_item;
+	if (lp && test_bit(XFS_LI_IN_AIL, &lp->li_flags)) {
+		if (!xfs_ilock_nowait(ip2,
+		    xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1))) {
+			xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
+			if ((++attempts % 5) == 0)
+				delay(1); /* Don't just spin the CPU */
+			goto again;
+		}
+	} else
+		xfs_ilock(ip2, xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1));
+	/*
+	 * We cannot use xfs_break_dax_layouts() directly here because it may
+	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
+	 * for this nested lock case.
+	 */
+	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
+	if (page && page_ref_count(page) != 1) {
+		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
+		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
+		goto again;
+	}
+
+	return 0;
+}
+
 /*
  * Lock two inodes so that userspace cannot initiate I/O via file syscalls or
  * mmap activity.
@@ -3741,6 +3794,10 @@ xfs_ilock2_io_mmap(
 	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
 	if (ret)
 		return ret;
+
+	if (IS_DAX(VFS_I(ip1)) && IS_DAX(VFS_I(ip2)))
+		return xfs_mmaplock_two_inodes_and_break_dax_layout(ip1, ip2);
+
 	if (ip1 == ip2)
 		xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
 	else
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 4b6703dbffb8..f1547330b087 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -456,6 +456,7 @@ enum xfs_prealloc_flags {
 
 int	xfs_update_prealloc_flags(struct xfs_inode *ip,
 				  enum xfs_prealloc_flags flags);
+int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 13e461cf2055..86c737c2baeb 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1327,8 +1327,8 @@ xfs_reflink_remap_prep(
 	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
 		goto out_unlock;
 
-	/* Don't share DAX file data for now. */
-	if (IS_DAX(inode_in) || IS_DAX(inode_out))
+	/* Don't share DAX file data with non-DAX file. */
+	if (IS_DAX(inode_in) != IS_DAX(inode_out))
 		goto out_unlock;
 
 	if (!IS_DAX(inode_in))
-- 
2.32.0



