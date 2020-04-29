Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A071BD285
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgD2CqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:46:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39268 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgD2CqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:46:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2hqAH121547;
        Wed, 29 Apr 2020 02:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/2GeUgKrIIN71/twzFoc+FClZ+Db9erexpTZyKWzEXE=;
 b=F2mM/KgEc+bwzEtRFpHtfJwNeySnQuyd9NOj+fU9UqbZGMxl0rIS2KyCFuP8UIYEALlQ
 IYELJauzcw/MrAU2ZCCbYepGfMp3tHo+BF73e0XObNNxibWPAPvw/KxaFlgYHtN8BY5x
 MYA8MrEf3ap+FfBdZvVGiejq4BkulX5PkRG0TUgRunTzog33e712mj43n+nqnsOvGktR
 9Gy/nSDy51x2xp76o4RWFRr0atAaVfUr3QKWwMTfXcMN7b9pSBthTEkW18VtWewKqH24
 yGWkTP7MSiW6vdVWvgXXqYm3qIFs8/fSY8U29PbC2WH2bAD7y2jZ+P58mAEflsASf06j Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30p2p08p44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:46:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2ghPu071631;
        Wed, 29 Apr 2020 02:46:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30mxphp536-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:46:07 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03T2k60f004090;
        Wed, 29 Apr 2020 02:46:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:46:06 -0700
Subject: [PATCH 17/18] xfs: remove old swap extents implementation
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:46:05 -0700
Message-ID: <158812836551.168506.6339048941371563780.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=3 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Migrate the old XFS_IOC_SWAPEXT implementation to use our shiny new one.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |  193 ------------------------------------------------
 fs/xfs/xfs_bmap_util.h |    2 
 fs/xfs/xfs_ioctl.c     |  108 ++++++++-------------------
 3 files changed, 32 insertions(+), 271 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 639b42b1d568..df373107e782 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1334,23 +1334,6 @@ xfs_swap_extents_check_format(
 	return 0;
 }
 
-static int
-xfs_swap_extent_flush(
-	struct xfs_inode	*ip)
-{
-	int	error;
-
-	error = filemap_write_and_wait(VFS_I(ip)->i_mapping);
-	if (error)
-		return error;
-	truncate_pagecache_range(VFS_I(ip), 0, -1);
-
-	/* Verify O_DIRECT for ftmp */
-	if (VFS_I(ip)->i_mapping->nrpages)
-		return -EINVAL;
-	return 0;
-}
-
 /*
  * Fix up the owners of the bmbt blocks to refer to the current inode. The
  * change owner scan attempts to order all modified buffers in the current
@@ -1519,181 +1502,6 @@ xfs_swap_extent_forks(
 	return 0;
 }
 
-int
-xfs_swap_extents(
-	struct xfs_inode	*ip,	/* target inode */
-	struct xfs_inode	*tip,	/* tmp inode */
-	struct xfs_swapext	*sxp)
-{
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
-	struct xfs_bstat	*sbp = &sxp->sx_stat;
-	int			error = 0;
-	int			lock_flags;
-	int			resblks = 0;
-
-	/*
-	 * Lock the inodes against other IO, page faults and truncate to
-	 * begin with.  Then we can ensure the inodes are flushed and have no
-	 * page cache safely. Once we have done this we can take the ilocks and
-	 * do the rest of the checks.
-	 */
-	lock_two_nondirectories(VFS_I(ip), VFS_I(tip));
-	lock_flags = XFS_MMAPLOCK_EXCL;
-	xfs_lock_two_inodes(ip, XFS_MMAPLOCK_EXCL, tip, XFS_MMAPLOCK_EXCL);
-
-	/* Verify that both files have the same format */
-	if ((VFS_I(ip)->i_mode & S_IFMT) != (VFS_I(tip)->i_mode & S_IFMT)) {
-		error = -EINVAL;
-		goto out_unlock;
-	}
-
-	/* Verify both files are either real-time or non-realtime */
-	if (XFS_IS_REALTIME_INODE(ip) != XFS_IS_REALTIME_INODE(tip)) {
-		error = -EINVAL;
-		goto out_unlock;
-	}
-
-	error = xfs_qm_dqattach(ip);
-	if (error)
-		goto out_unlock;
-
-	error = xfs_qm_dqattach(tip);
-	if (error)
-		goto out_unlock;
-
-	error = xfs_swap_extent_flush(ip);
-	if (error)
-		goto out_unlock;
-	error = xfs_swap_extent_flush(tip);
-	if (error)
-		goto out_unlock;
-
-	if (xfs_inode_has_cow_data(tip)) {
-		error = xfs_reflink_cancel_cow_range(tip, 0, NULLFILEOFF, true);
-		if (error)
-			goto out_unlock;
-	}
-
-	/*
-	 * Extent "swapping" with rmap requires a permanent reservation and
-	 * a block reservation because it's really just a remap operation
-	 * performed with log redo items!
-	 */
-	if (xfs_sb_version_hasrmapbt(&mp->m_sb)) {
-		int		w	= XFS_DATA_FORK;
-		uint32_t	ipnext	= XFS_IFORK_NEXTENTS(ip, w);
-		uint32_t	tipnext	= XFS_IFORK_NEXTENTS(tip, w);
-
-		/*
-		 * Conceptually this shouldn't affect the shape of either bmbt,
-		 * but since we atomically move extents one by one, we reserve
-		 * enough space to rebuild both trees.
-		 */
-		resblks = XFS_SWAP_RMAP_SPACE_RES(mp, ipnext, w);
-		resblks +=  XFS_SWAP_RMAP_SPACE_RES(mp, tipnext, w);
-
-		/*
-		 * Handle the corner case where either inode might straddle the
-		 * btree format boundary. If so, the inode could bounce between
-		 * btree <-> extent format on unmap -> remap cycles, freeing and
-		 * allocating a bmapbt block each time.
-		 */
-		if (ipnext == (XFS_IFORK_MAXEXT(ip, w) + 1))
-			resblks += XFS_IFORK_MAXEXT(ip, w);
-		if (tipnext == (XFS_IFORK_MAXEXT(tip, w) + 1))
-			resblks += XFS_IFORK_MAXEXT(tip, w);
-	}
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0, 0, &tp);
-	if (error)
-		goto out_unlock;
-
-	/*
-	 * Lock and join the inodes to the tansaction so that transaction commit
-	 * or cancel will unlock the inodes from this point onwards.
-	 */
-	xfs_lock_two_inodes(ip, XFS_ILOCK_EXCL, tip, XFS_ILOCK_EXCL);
-	lock_flags |= XFS_ILOCK_EXCL;
-	xfs_trans_ijoin(tp, ip, 0);
-	xfs_trans_ijoin(tp, tip, 0);
-
-
-	/* Verify all data are being swapped */
-	if (sxp->sx_offset != 0 ||
-	    sxp->sx_length != ip->i_d.di_size ||
-	    sxp->sx_length != tip->i_d.di_size) {
-		error = -EFAULT;
-		goto out_trans_cancel;
-	}
-
-	trace_xfs_swap_extent_before(ip, 0);
-	trace_xfs_swap_extent_before(tip, 1);
-
-	/* check inode formats now that data is flushed */
-	error = xfs_swap_extents_check_format(ip, tip);
-	if (error) {
-		xfs_notice(mp,
-		    "%s: inode 0x%llx format is incompatible for exchanging.",
-				__func__, ip->i_ino);
-		goto out_trans_cancel;
-	}
-
-	/*
-	 * Compare the current change & modify times with that
-	 * passed in.  If they differ, we abort this swap.
-	 * This is the mechanism used to ensure the calling
-	 * process that the file was not changed out from
-	 * under it.
-	 */
-	if ((sbp->bs_ctime.tv_sec != VFS_I(ip)->i_ctime.tv_sec) ||
-	    (sbp->bs_ctime.tv_nsec != VFS_I(ip)->i_ctime.tv_nsec) ||
-	    (sbp->bs_mtime.tv_sec != VFS_I(ip)->i_mtime.tv_sec) ||
-	    (sbp->bs_mtime.tv_nsec != VFS_I(ip)->i_mtime.tv_nsec)) {
-		error = -EBUSY;
-		goto out_trans_cancel;
-	}
-
-	/*
-	 * Note the trickiness in setting the log flags - we set the owner log
-	 * flag on the opposite inode (i.e. the inode we are setting the new
-	 * owner to be) because once we swap the forks and log that, log
-	 * recovery is going to see the fork as owned by the swapped inode,
-	 * not the pre-swapped inodes.
-	 */
-	if (xfs_sb_version_hasrmapbt(&mp->m_sb))
-		error = xfs_swapext_deferred_bmap(&tp, ip, tip, XFS_DATA_FORK,
-				0, 0, XFS_B_TO_FSB(ip->i_mount,
-						   i_size_read(VFS_I(ip))), 0);
-	else
-		error = xfs_swap_extent_forks(&tp, ip, tip);
-	if (error) {
-		trace_xfs_swap_extent_error(ip, error, _THIS_IP_);
-		goto out_trans_cancel;
-	}
-
-	/*
-	 * If this is a synchronous mount, make sure that the
-	 * transaction goes to disk before returning to the user.
-	 */
-	if (mp->m_flags & XFS_MOUNT_WSYNC)
-		xfs_trans_set_sync(tp);
-
-	error = xfs_trans_commit(tp);
-
-	trace_xfs_swap_extent_after(ip, 0);
-	trace_xfs_swap_extent_after(tip, 1);
-
-out_unlock:
-	xfs_iunlock(ip, lock_flags);
-	xfs_iunlock(tip, lock_flags);
-	unlock_two_nondirectories(VFS_I(ip), VFS_I(tip));
-	return error;
-
-out_trans_cancel:
-	xfs_trans_cancel(tp);
-	goto out_unlock;
-}
-
 /* Prepare two files to have their data swapped. */
 int
 xfs_swap_range_prep(
@@ -2061,4 +1869,3 @@ xfs_swap_range(
 	xfs_trans_cancel(tp);
 	goto out_unlock;
 }
-
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index d3444a63bbd7..e0712c274dd2 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -66,8 +66,6 @@ int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
 bool	xfs_can_free_eofblocks(struct xfs_inode *ip, bool force);
 int	xfs_free_eofblocks(struct xfs_inode *ip);
 
-int	xfs_swap_extents(struct xfs_inode *ip, struct xfs_inode *tip,
-			 struct xfs_swapext *sx);
 int	xfs_swap_range_prep(struct file *file1, struct file *file2,
 			    struct file_swap_range *fsr);
 int	xfs_swap_range(struct xfs_inode *ip1, struct xfs_inode *ip2,
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 274423ba3bb5..f93de4f7a944 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1864,81 +1864,47 @@ xfs_ioc_scrub_metadata(
 
 int
 xfs_ioc_swapext(
-	xfs_swapext_t	*sxp)
+	struct xfs_swapext	__user *arg)
 {
-	xfs_inode_t     *ip, *tip;
-	struct fd	f, tmp;
-	int		error = 0;
+	struct xfs_swapext	sx;
+	struct file_swap_range	fsr = { 0 };
+	struct fd		fd2, fd1;
+	int			error = 0;
 
-	/* Pull information for the target fd */
-	f = fdget((int)sxp->sx_fdtarget);
-	if (!f.file) {
-		error = -EINVAL;
-		goto out;
-	}
+	if (copy_from_user(&sx, arg, sizeof(struct xfs_swapext)))
+		return -EFAULT;
 
-	if (!(f.file->f_mode & FMODE_WRITE) ||
-	    !(f.file->f_mode & FMODE_READ) ||
-	    (f.file->f_flags & O_APPEND)) {
-		error = -EBADF;
-		goto out_put_file;
-	}
+	fd2 = fdget((int)sx.sx_fdtarget);
+	if (!fd2.file)
+		return -EINVAL;
 
-	tmp = fdget((int)sxp->sx_fdtmp);
-	if (!tmp.file) {
+	fd1 = fdget((int)sx.sx_fdtmp);
+	if (!fd1.file) {
 		error = -EINVAL;
-		goto out_put_file;
+		goto dest_fdput;
 	}
 
-	if (!(tmp.file->f_mode & FMODE_WRITE) ||
-	    !(tmp.file->f_mode & FMODE_READ) ||
-	    (tmp.file->f_flags & O_APPEND)) {
-		error = -EBADF;
-		goto out_put_tmp_file;
-	}
+	fsr.file1_fd = sx.sx_fdtmp;
+	fsr.length = sx.sx_length;
+	fsr.flags = FILE_SWAP_RANGE_NONATOMIC | FILE_SWAP_RANGE_FILE2_FRESH |
+		    FILE_SWAP_RANGE_FULL_FILES;
+	fsr.file2_ino = sx.sx_stat.bs_ino;
+	fsr.file2_mtime = sx.sx_stat.bs_mtime.tv_sec;
+	fsr.file2_ctime = sx.sx_stat.bs_ctime.tv_sec;
+	fsr.file2_mtime_nsec = sx.sx_stat.bs_mtime.tv_nsec;
+	fsr.file2_ctime_nsec = sx.sx_stat.bs_ctime.tv_nsec;
 
-	if (IS_SWAPFILE(file_inode(f.file)) ||
-	    IS_SWAPFILE(file_inode(tmp.file))) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
+	error = vfs_swap_file_range(fd1.file, fd2.file, &fsr);
 
 	/*
-	 * We need to ensure that the fds passed in point to XFS inodes
-	 * before we cast and access them as XFS structures as we have no
-	 * control over what the user passes us here.
+	 * The old implementation returned EFAULT if the swap range was not
+	 * the entirety of both files.
 	 */
-	if (f.file->f_op != &xfs_file_operations ||
-	    tmp.file->f_op != &xfs_file_operations) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
-
-	ip = XFS_I(file_inode(f.file));
-	tip = XFS_I(file_inode(tmp.file));
-
-	if (ip->i_mount != tip->i_mount) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
-
-	if (ip->i_ino == tip->i_ino) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
-
-	if (XFS_FORCED_SHUTDOWN(ip->i_mount)) {
-		error = -EIO;
-		goto out_put_tmp_file;
-	}
-
-	error = xfs_swap_extents(ip, tip, sxp);
-
- out_put_tmp_file:
-	fdput(tmp);
- out_put_file:
-	fdput(f);
- out:
+	if (error == -EDOM)
+		error = -EFAULT;
+	fdput(fd1);
+dest_fdput:
+	fdput(fd2);
 	return error;
 }
 
@@ -2183,18 +2149,8 @@ xfs_file_ioctl(
 	case XFS_IOC_ATTRMULTI_BY_HANDLE:
 		return xfs_attrmulti_by_handle(filp, arg);
 
-	case XFS_IOC_SWAPEXT: {
-		struct xfs_swapext	sxp;
-
-		if (copy_from_user(&sxp, arg, sizeof(xfs_swapext_t)))
-			return -EFAULT;
-		error = mnt_want_write_file(filp);
-		if (error)
-			return error;
-		error = xfs_ioc_swapext(&sxp);
-		mnt_drop_write_file(filp);
-		return error;
-	}
+	case XFS_IOC_SWAPEXT:
+		return xfs_ioc_swapext(arg);
 
 	case XFS_IOC_FSCOUNTS: {
 		xfs_fsop_counts_t out;

