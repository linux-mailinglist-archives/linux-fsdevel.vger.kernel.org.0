Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C99041A8E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 08:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbhI1G0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 02:26:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6259 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235078AbhI1G0L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:26:11 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AM+p0O69uN1adIemA41NLDrUD+3+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUoigTwAzmNMWDzVaarcZmvzcth/O9608RxQ78XTyoNgSVdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4EfwWlTdhSMkj/jQF+CsULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OaefCDu7pTJliUqdFOpmZ2CFnoeMYQG++pfD3t?=
 =?us-ascii?q?J8PsCIjERKBuEgoqe37O/TvhEh8ItNsDnMYoT/HZ6wlnxAf8gB5KFXKTO4d5R2?=
 =?us-ascii?q?SwYh8ZSEPKYbM0cARJjbgvHZRJnOVoNDp862uCyiRHXdSNUqVeQja42+HTIigh?=
 =?us-ascii?q?w1qX9dtbYZLSiRc5VtkKDuiTK8gzRGB4dMNCA2Dyt6W+3i6nDkEvTXIMUCa39+?=
 =?us-ascii?q?OVmjUOewkQNBxAME1i2u/+0jgi5Qd03A0gV/Dc+6Ks/7kqmSvHjUBCi5n2JpBg?=
 =?us-ascii?q?RX5xXCeJSwAWMzLfEphaXHUAaQTNbLt8rrsk7QXotzFDht83oHztHorCTSGzb8?=
 =?us-ascii?q?raSsCP0PjIaa3IBDRLo5yNtD8LL+dl110yQCI04VvPdszE8IhmoqxjikcT0r+t?=
 =?us-ascii?q?7YRY36piG?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AViJ5daNsm6Qwg8BcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.85,328,1624291200"; 
   d="scan'208";a="115097021"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Sep 2021 14:24:04 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 3D3194D0DC7C;
        Tue, 28 Sep 2021 14:23:58 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Sep 2021 14:23:57 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Sep 2021 14:23:56 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <dan.j.williams@intel.com>, <djwong@kernel.org>, <hch@lst.de>,
        <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>
Subject: [PATCH v10 8/8] xfs: Add dax dedupe support
Date:   Tue, 28 Sep 2021 14:23:11 +0800
Message-ID: <20210928062311.4012070-9-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
References: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3D3194D0DC7C.A0ED8
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c    |  2 +-
 fs/xfs/xfs_inode.c   | 69 +++++++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_inode.h   |  1 +
 fs/xfs/xfs_reflink.c |  4 +--
 4 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index afde4fbefb6f..97d03bc25fda 100644
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
index a4f6f034fb81..8e03cca4ce61 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3790,6 +3790,50 @@ xfs_iolock_two_inodes_and_break_layout(
 	return 0;
 }
 
+static int
+xfs_mmaplock_two_inodes_and_break_dax_layout(
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2)
+{
+	int			error;
+	bool			retry;
+	struct page		*page;
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
+		if (error == 0 && retry)
+			goto again;
+		return error;
+	}
+
+	if (ip1 == ip2)
+		return 0;
+
+	/* Nested lock the second inode */
+	xfs_ilock(ip2, xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1));
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
@@ -3804,8 +3848,19 @@ xfs_ilock2_io_mmap(
 	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
 	if (ret)
 		return ret;
-	filemap_invalidate_lock_two(VFS_I(ip1)->i_mapping,
-				    VFS_I(ip2)->i_mapping);
+
+	if (IS_DAX(VFS_I(ip1)) && IS_DAX(VFS_I(ip2))) {
+		ret = xfs_mmaplock_two_inodes_and_break_dax_layout(ip1, ip2);
+		if (ret) {
+			inode_unlock(VFS_I(ip2));
+			if (ip1 != ip2)
+				inode_unlock(VFS_I(ip1));
+			return ret;
+		}
+	} else
+		filemap_invalidate_lock_two(VFS_I(ip1)->i_mapping,
+					    VFS_I(ip2)->i_mapping);
+
 	return 0;
 }
 
@@ -3815,8 +3870,14 @@ xfs_iunlock2_io_mmap(
 	struct xfs_inode	*ip1,
 	struct xfs_inode	*ip2)
 {
-	filemap_invalidate_unlock_two(VFS_I(ip1)->i_mapping,
-				      VFS_I(ip2)->i_mapping);
+	if (IS_DAX(VFS_I(ip1)) && IS_DAX(VFS_I(ip2))) {
+		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
+		if (ip1 != ip2)
+			xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
+	} else
+		filemap_invalidate_unlock_two(VFS_I(ip1)->i_mapping,
+					      VFS_I(ip2)->i_mapping);
+
 	inode_unlock(VFS_I(ip2));
 	if (ip1 != ip2)
 		inode_unlock(VFS_I(ip1));
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index b21b177832d1..f7e26fe31a26 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -472,6 +472,7 @@ enum xfs_prealloc_flags {
 
 int	xfs_update_prealloc_flags(struct xfs_inode *ip,
 				  enum xfs_prealloc_flags flags);
+int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 9d876e268734..3b99c9dfcf0d 100644
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
2.33.0



