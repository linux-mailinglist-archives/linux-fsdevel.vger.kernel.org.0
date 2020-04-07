Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3811A13AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 20:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgDGSat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 14:30:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:36381 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgDGSaf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:30:35 -0400
IronPort-SDR: j5IhG7fYhbByoeqcXttuuxNpMG/ypeaODCQfp98dGLpf3OwgNa6LpfK/v+3hKNOVXvBB5fptjA
 6wYBKs2ozZlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:34 -0700
IronPort-SDR: 9CgLI9gALlNksBZpu6X8qKwa2BnIeTSL1P1jqaD08fRG2bHyodnlG+IdAtbglxJiAboKTlAIpH
 a5IwvomZnQzw==
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="297018539"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:30:33 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V6 7/8] fs/xfs: Change xfs_ioctl_setattr_dax_invalidate() to xfs_ioctl_dax_check()
Date:   Tue,  7 Apr 2020 11:29:57 -0700
Message-Id: <20200407182958.568475-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407182958.568475-1-ira.weiny@intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

We only support changing FS_XFLAG_DAX on directories.  Files get their
flag from the parent directory on creation only.  So no data
invalidation needs to happen.

Alter the xfs_ioctl_setattr_dax_invalidate() to be
xfs_ioctl_dax_check().

This also allows use to remove the join_flags logic.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v5:
	New patch
---
 fs/xfs/xfs_ioctl.c | 91 +++++-----------------------------------------
 1 file changed, 10 insertions(+), 81 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index c6cd92ef4a05..5472faab7c4f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1145,63 +1145,18 @@ xfs_ioctl_setattr_xflags(
 }
 
 /*
- * If we are changing DAX flags, we have to ensure the file is clean and any
- * cached objects in the address space are invalidated and removed. This
- * requires us to lock out other IO and page faults similar to a truncate
- * operation. The locks need to be held until the transaction has been committed
- * so that the cache invalidation is atomic with respect to the DAX flag
- * manipulation.
+ * Only directories are allowed to change dax flags
  */
 static int
 xfs_ioctl_setattr_dax_invalidate(
-	struct xfs_inode	*ip,
-	struct fsxattr		*fa,
-	int			*join_flags)
+	struct xfs_inode	*ip)
 {
 	struct inode		*inode = VFS_I(ip);
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
-
-	if (S_ISDIR(inode->i_mode))
-		return 0;
 
-	/* lock, flush and invalidate mapping in preparation for flag change */
-	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
-	error = filemap_write_and_wait(inode->i_mapping);
-	if (error)
-		goto out_unlock;
-	error = invalidate_inode_pages2(inode->i_mapping);
-	if (error)
-		goto out_unlock;
+	if (!S_ISDIR(inode->i_mode))
+		return -EINVAL;
 
-	*join_flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
 	return 0;
-
-out_unlock:
-	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
-	return error;
-
 }
 
 /*
@@ -1209,17 +1164,10 @@ xfs_ioctl_setattr_dax_invalidate(
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
@@ -1236,8 +1184,7 @@ xfs_ioctl_setattr_get_trans(
 		goto out_unlock;
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL | join_flags);
-	join_flags = 0;
+	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 
 	/*
 	 * CAP_FOWNER overrides the following restrictions:
@@ -1258,8 +1205,6 @@ xfs_ioctl_setattr_get_trans(
 out_cancel:
 	xfs_trans_cancel(tp);
 out_unlock:
-	if (join_flags)
-		xfs_iunlock(ip, join_flags);
 	return ERR_PTR(error);
 }
 
@@ -1386,7 +1331,6 @@ xfs_ioctl_setattr(
 	struct xfs_dquot	*pdqp = NULL;
 	struct xfs_dquot	*olddquot = NULL;
 	int			code;
-	int			join_flags = 0;
 
 	trace_xfs_ioctl_setattr(ip);
 
@@ -1410,18 +1354,11 @@ xfs_ioctl_setattr(
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
+	code = xfs_ioctl_setattr_dax_invalidate(ip);
 	if (code)
 		goto error_free_dquots;
 
-	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
+	tp = xfs_ioctl_setattr_get_trans(ip);
 	if (IS_ERR(tp)) {
 		code = PTR_ERR(tp);
 		goto error_free_dquots;
@@ -1552,7 +1489,6 @@ xfs_ioc_setxflags(
 	struct fsxattr		fa;
 	struct fsxattr		old_fa;
 	unsigned int		flags;
-	int			join_flags = 0;
 	int			error;
 
 	if (copy_from_user(&flags, arg, sizeof(flags)))
@@ -1569,18 +1505,11 @@ xfs_ioc_setxflags(
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
+	error = xfs_ioctl_setattr_dax_invalidate(ip);
 	if (error)
 		goto out_drop_write;
 
-	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
+	tp = xfs_ioctl_setattr_get_trans(ip);
 	if (IS_ERR(tp)) {
 		error = PTR_ERR(tp);
 		goto out_drop_write;
-- 
2.25.1

