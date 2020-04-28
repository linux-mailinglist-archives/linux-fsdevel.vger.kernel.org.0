Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2CE1BB2BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 02:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgD1AWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 20:22:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:25937 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgD1AWC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 20:22:02 -0400
IronPort-SDR: SF3QyLq5YT64BxRjhMkIBus8Oc1yRnHbHpcjUqk64jOWqoDnLPX9B49DCwLlEzEyMygy/3Rqpm
 gHAbsIxeJ9ZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 17:21:54 -0700
IronPort-SDR: Hq63tgAjB3f5Hpl2MxK6vDBrnRddUjyobkO3euXTviZ77LYTmNl1wB/azwRVOmuKmOwUr7j0pb
 FaNKIImWdCQQ==
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="458590536"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 17:21:53 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH V11 11/11] fs/xfs: Update xfs_ioctl_setattr_dax_invalidate()
Date:   Mon, 27 Apr 2020 17:21:42 -0700
Message-Id: <20200428002142.404144-12-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200428002142.404144-1-ira.weiny@intel.com>
References: <20200428002142.404144-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Because of the separation of FS_XFLAG_DAX from S_DAX and the delayed
setting of S_DAX, data invalidation no longer needs to happen when
FS_XFLAG_DAX is changed.

Change xfs_ioctl_setattr_dax_invalidate() to be
xfs_ioctl_dax_check_set_cache() and alter the code to reflect the new
functionality.

Furthermore, we no longer need the locking so we remove the join_flags
logic.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V10:
	adjust for renamed d_mark_dontcache() function

Changes from V9:
	Change name of function to xfs_ioctl_setattr_prepare_dax()

Changes from V8:
	Change name of function to xfs_ioctl_dax_check_set_cache()
	Update commit message
	Fix bit manipulations

Changes from V7:
	Use new flag_inode_dontcache()
	Skip don't cache if mount over ride is active.

Changes from v6:
	Fix completely broken implementation and update commit message.
	Use the new VFS layer I_DONTCACHE to facilitate inode eviction
	and S_DAX changing on drop_caches

Changes from v5:
	New patch
---
 fs/xfs/xfs_ioctl.c | 108 +++++++++------------------------------------
 1 file changed, 20 insertions(+), 88 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 104495ac187c..ff474f2c9acf 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1245,64 +1245,26 @@ xfs_ioctl_setattr_xflags(
 	return 0;
 }
 
-/*
- * If we are changing DAX flags, we have to ensure the file is clean and any
- * cached objects in the address space are invalidated and removed. This
- * requires us to lock out other IO and page faults similar to a truncate
- * operation. The locks need to be held until the transaction has been committed
- * so that the cache invalidation is atomic with respect to the DAX flag
- * manipulation.
- */
-static int
-xfs_ioctl_setattr_dax_invalidate(
+static void
+xfs_ioctl_setattr_prepare_dax(
 	struct xfs_inode	*ip,
-	struct fsxattr		*fa,
-	int			*join_flags)
+	struct fsxattr		*fa)
 {
-	struct inode		*inode = VFS_I(ip);
-	struct super_block	*sb = inode->i_sb;
-	int			error;
-
-	*join_flags = 0;
-
-	/*
-	 * It is only valid to set the DAX flag on regular files and
-	 * directories on filesystems where the block size is equal to the page
-	 * size. On directories it serves as an inherited hint so we don't
-	 * have to check the device for dax support or flush pagecache.
-	 */
-	if (fa->fsx_xflags & FS_XFLAG_DAX) {
-		struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
-
-		if (!bdev_dax_supported(target->bt_bdev, sb->s_blocksize))
-			return -EINVAL;
-	}
-
-	/* If the DAX state is not changing, we have nothing to do here. */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) && IS_DAX(inode))
-		return 0;
-	if (!(fa->fsx_xflags & FS_XFLAG_DAX) && !IS_DAX(inode))
-		return 0;
+	struct xfs_mount	*mp = ip->i_mount;
+	struct inode            *inode = VFS_I(ip);
 
 	if (S_ISDIR(inode->i_mode))
-		return 0;
-
-	/* lock, flush and invalidate mapping in preparation for flag change */
-	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
-	error = filemap_write_and_wait(inode->i_mapping);
-	if (error)
-		goto out_unlock;
-	error = invalidate_inode_pages2(inode->i_mapping);
-	if (error)
-		goto out_unlock;
-
-	*join_flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
-	return 0;
+		return;
 
-out_unlock:
-	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
-	return error;
+	if ((mp->m_flags & XFS_MOUNT_DAX_ALWAYS) ||
+	    (mp->m_flags & XFS_MOUNT_DAX_NEVER))
+		return;
 
+	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
+	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
+	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
+	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
+		d_mark_dontcache(inode);
 }
 
 /*
@@ -1310,17 +1272,10 @@ xfs_ioctl_setattr_dax_invalidate(
  * have permission to do so. On success, return a clean transaction and the
  * inode locked exclusively ready for further operation specific checks. On
  * failure, return an error without modifying or locking the inode.
- *
- * The inode might already be IO locked on call. If this is the case, it is
- * indicated in @join_flags and we take full responsibility for ensuring they
- * are unlocked from now on. Hence if we have an error here, we still have to
- * unlock them. Otherwise, once they are joined to the transaction, they will
- * be unlocked on commit/cancel.
  */
 static struct xfs_trans *
 xfs_ioctl_setattr_get_trans(
-	struct xfs_inode	*ip,
-	int			join_flags)
+	struct xfs_inode	*ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -1337,8 +1292,7 @@ xfs_ioctl_setattr_get_trans(
 		goto out_unlock;
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL | join_flags);
-	join_flags = 0;
+	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 
 	/*
 	 * CAP_FOWNER overrides the following restrictions:
@@ -1359,8 +1313,6 @@ xfs_ioctl_setattr_get_trans(
 out_cancel:
 	xfs_trans_cancel(tp);
 out_unlock:
-	if (join_flags)
-		xfs_iunlock(ip, join_flags);
 	return ERR_PTR(error);
 }
 
@@ -1486,7 +1438,6 @@ xfs_ioctl_setattr(
 	struct xfs_dquot	*pdqp = NULL;
 	struct xfs_dquot	*olddquot = NULL;
 	int			code;
-	int			join_flags = 0;
 
 	trace_xfs_ioctl_setattr(ip);
 
@@ -1510,18 +1461,9 @@ xfs_ioctl_setattr(
 			return code;
 	}
 
-	/*
-	 * Changing DAX config may require inode locking for mapping
-	 * invalidation. These need to be held all the way to transaction commit
-	 * or cancel time, so need to be passed through to
-	 * xfs_ioctl_setattr_get_trans() so it can apply them to the join call
-	 * appropriately.
-	 */
-	code = xfs_ioctl_setattr_dax_invalidate(ip, fa, &join_flags);
-	if (code)
-		goto error_free_dquots;
+	xfs_ioctl_setattr_prepare_dax(ip, fa);
 
-	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
+	tp = xfs_ioctl_setattr_get_trans(ip);
 	if (IS_ERR(tp)) {
 		code = PTR_ERR(tp);
 		goto error_free_dquots;
@@ -1651,7 +1593,6 @@ xfs_ioc_setxflags(
 	struct fsxattr		fa;
 	struct fsxattr		old_fa;
 	unsigned int		flags;
-	int			join_flags = 0;
 	int			error;
 
 	if (copy_from_user(&flags, arg, sizeof(flags)))
@@ -1668,18 +1609,9 @@ xfs_ioc_setxflags(
 	if (error)
 		return error;
 
-	/*
-	 * Changing DAX config may require inode locking for mapping
-	 * invalidation. These need to be held all the way to transaction commit
-	 * or cancel time, so need to be passed through to
-	 * xfs_ioctl_setattr_get_trans() so it can apply them to the join call
-	 * appropriately.
-	 */
-	error = xfs_ioctl_setattr_dax_invalidate(ip, &fa, &join_flags);
-	if (error)
-		goto out_drop_write;
+	xfs_ioctl_setattr_prepare_dax(ip, &fa);
 
-	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
+	tp = xfs_ioctl_setattr_get_trans(ip);
 	if (IS_ERR(tp)) {
 		error = PTR_ERR(tp);
 		goto out_drop_write;
-- 
2.25.1

