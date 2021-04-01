Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50CF350BB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhDABKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232994AbhDABKG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:10:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFA5461059;
        Thu,  1 Apr 2021 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239406;
        bh=qjX4D2r8vm1epGEFFfAaMXw2vhqSUWw1+YOqNpRDG7U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mCA5wsA78AXvZ7K1nL7GFsjVN9AiSjW9/0mK27NUEz+iAPODinVpb8eUc+mShr5r1
         TJaTrMGKED3SKErik6pi/iAxgk/XMIuVoCBKwcDk3OdZbZgS+a/qDZ6UbA/F/I0JeQ
         HM2Nl1bFoSWsv2HG0XvAYHBJqyuyMDVX40/0Oz5d1FqtWqtqug9rJK023yaotZy7IE
         y+pH5NtyBp15zWI3gURhVR4z9mxnG8uPctlzIeiPuAkRlIw2f4Ujhewj6Rk8eZ1G2s
         +J2Wd5VusYH7WG4UExwMmrRvfcf+UQ9T3OJWFzXpYRzVW2IFbpX1sb0lepZ+pWMKh7
         qSJzCSL4j+l2Q==
Subject: [PATCH 14/18] xfs: remove old swap extents implementation
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:10:04 -0700
Message-ID: <161723940486.3149451.4591778057292598188.stgit@magnolia>
In-Reply-To: <161723932606.3149451.12366114306150243052.stgit@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Migrate the old XFS_IOC_SWAPEXT implementation to use our shiny new one.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |  463 ------------------------------------------------
 fs/xfs/xfs_bmap_util.h |    7 -
 fs/xfs/xfs_ioctl.c     |  102 +++--------
 fs/xfs/xfs_ioctl.h     |    4 
 fs/xfs/xfs_ioctl32.c   |    8 -
 fs/xfs/xfs_xchgrange.c |  273 ++++++++++++++++++++++++++++
 6 files changed, 306 insertions(+), 551 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 94f1d0d685fe..44f5c3ce02dd 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1238,466 +1238,3 @@ xfs_insert_file_space(
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-
-/*
- * We need to check that the format of the data fork in the temporary inode is
- * valid for the target inode before doing the swap. This is not a problem with
- * attr1 because of the fixed fork offset, but attr2 has a dynamically sized
- * data fork depending on the space the attribute fork is taking so we can get
- * invalid formats on the target inode.
- *
- * E.g. target has space for 7 extents in extent format, temp inode only has
- * space for 6.  If we defragment down to 7 extents, then the tmp format is a
- * btree, but when swapped it needs to be in extent format. Hence we can't just
- * blindly swap data forks on attr2 filesystems.
- *
- * Note that we check the swap in both directions so that we don't end up with
- * a corrupt temporary inode, either.
- *
- * Note that fixing the way xfs_fsr sets up the attribute fork in the source
- * inode will prevent this situation from occurring, so all we do here is
- * reject and log the attempt. basically we are putting the responsibility on
- * userspace to get this right.
- */
-int
-xfs_swap_extents_check_format(
-	struct xfs_inode	*ip,	/* target inode */
-	struct xfs_inode	*tip)	/* tmp inode */
-{
-	struct xfs_ifork	*ifp = &ip->i_df;
-	struct xfs_ifork	*tifp = &tip->i_df;
-
-	/* User/group/project quota ids must match if quotas are enforced. */
-	if (XFS_IS_QUOTA_ON(ip->i_mount) &&
-	    (!uid_eq(VFS_I(ip)->i_uid, VFS_I(tip)->i_uid) ||
-	     !gid_eq(VFS_I(ip)->i_gid, VFS_I(tip)->i_gid) ||
-	     ip->i_d.di_projid != tip->i_d.di_projid))
-		return -EINVAL;
-
-	/* Should never get a local format */
-	if (ifp->if_format == XFS_DINODE_FMT_LOCAL ||
-	    tifp->if_format == XFS_DINODE_FMT_LOCAL)
-		return -EINVAL;
-
-	/*
-	 * if the target inode has less extents that then temporary inode then
-	 * why did userspace call us?
-	 */
-	if (ifp->if_nextents < tifp->if_nextents)
-		return -EINVAL;
-
-	/*
-	 * If we have to use the (expensive) rmap swap method, we can
-	 * handle any number of extents and any format.
-	 */
-	if (xfs_sb_version_hasrmapbt(&ip->i_mount->m_sb))
-		return 0;
-
-	/*
-	 * if the target inode is in extent form and the temp inode is in btree
-	 * form then we will end up with the target inode in the wrong format
-	 * as we already know there are less extents in the temp inode.
-	 */
-	if (ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
-	    tifp->if_format == XFS_DINODE_FMT_BTREE)
-		return -EINVAL;
-
-	/* Check temp in extent form to max in target */
-	if (tifp->if_format == XFS_DINODE_FMT_EXTENTS &&
-	    tifp->if_nextents > XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK))
-		return -EINVAL;
-
-	/* Check target in extent form to max in temp */
-	if (ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
-	    ifp->if_nextents > XFS_IFORK_MAXEXT(tip, XFS_DATA_FORK))
-		return -EINVAL;
-
-	/*
-	 * If we are in a btree format, check that the temp root block will fit
-	 * in the target and that it has enough extents to be in btree format
-	 * in the target.
-	 *
-	 * Note that we have to be careful to allow btree->extent conversions
-	 * (a common defrag case) which will occur when the temp inode is in
-	 * extent format...
-	 */
-	if (tifp->if_format == XFS_DINODE_FMT_BTREE) {
-		if (XFS_IFORK_Q(ip) &&
-		    XFS_BMAP_BMDR_SPACE(tifp->if_broot) > XFS_IFORK_BOFF(ip))
-			return -EINVAL;
-		if (tifp->if_nextents <= XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK))
-			return -EINVAL;
-	}
-
-	/* Reciprocal target->temp btree format checks */
-	if (ifp->if_format == XFS_DINODE_FMT_BTREE) {
-		if (XFS_IFORK_Q(tip) &&
-		    XFS_BMAP_BMDR_SPACE(ip->i_df.if_broot) > XFS_IFORK_BOFF(tip))
-			return -EINVAL;
-		if (ifp->if_nextents <= XFS_IFORK_MAXEXT(tip, XFS_DATA_FORK))
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
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
-/*
- * Fix up the owners of the bmbt blocks to refer to the current inode. The
- * change owner scan attempts to order all modified buffers in the current
- * transaction. In the event of ordered buffer failure, the offending buffer is
- * physically logged as a fallback and the scan returns -EAGAIN. We must roll
- * the transaction in this case to replenish the fallback log reservation and
- * restart the scan. This process repeats until the scan completes.
- */
-static int
-xfs_swap_change_owner(
-	struct xfs_trans	**tpp,
-	struct xfs_inode	*ip,
-	struct xfs_inode	*tmpip)
-{
-	int			error;
-	struct xfs_trans	*tp = *tpp;
-
-	do {
-		error = xfs_bmbt_change_owner(tp, ip, XFS_DATA_FORK, ip->i_ino,
-					      NULL);
-		/* success or fatal error */
-		if (error != -EAGAIN)
-			break;
-
-		error = xfs_trans_roll(tpp);
-		if (error)
-			break;
-		tp = *tpp;
-
-		/*
-		 * Redirty both inodes so they can relog and keep the log tail
-		 * moving forward.
-		 */
-		xfs_trans_ijoin(tp, ip, 0);
-		xfs_trans_ijoin(tp, tmpip, 0);
-		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
-		xfs_trans_log_inode(tp, tmpip, XFS_ILOG_CORE);
-	} while (true);
-
-	return error;
-}
-
-/* Swap the extents of two files by swapping data forks. */
-int
-xfs_swap_extent_forks(
-	struct xfs_trans	**tpp,
-	struct xfs_swapext_req	*req)
-{
-	struct xfs_inode	*ip = req->ip1;
-	struct xfs_inode	*tip = req->ip2;
-	xfs_filblks_t		aforkblks = 0;
-	xfs_filblks_t		taforkblks = 0;
-	xfs_extnum_t		junk;
-	uint64_t		tmp;
-	unsigned int		reflink_state;
-	int			src_log_flags = XFS_ILOG_CORE;
-	int			target_log_flags = XFS_ILOG_CORE;
-	int			error;
-
-	reflink_state = xfs_swapext_reflink_prep(req);
-
-	/*
-	 * Count the number of extended attribute blocks
-	 */
-	if (XFS_IFORK_Q(ip) && ip->i_afp->if_nextents > 0 &&
-	    ip->i_afp->if_format != XFS_DINODE_FMT_LOCAL) {
-		error = xfs_bmap_count_blocks(*tpp, ip, XFS_ATTR_FORK, &junk,
-				&aforkblks);
-		if (error)
-			return error;
-	}
-	if (XFS_IFORK_Q(tip) && tip->i_afp->if_nextents > 0 &&
-	    tip->i_afp->if_format != XFS_DINODE_FMT_LOCAL) {
-		error = xfs_bmap_count_blocks(*tpp, tip, XFS_ATTR_FORK, &junk,
-				&taforkblks);
-		if (error)
-			return error;
-	}
-
-	/*
-	 * Btree format (v3) inodes have the inode number stamped in the bmbt
-	 * block headers. We can't start changing the bmbt blocks until the
-	 * inode owner change is logged so recovery does the right thing in the
-	 * event of a crash. Set the owner change log flags now and leave the
-	 * bmbt scan as the last step.
-	 */
-	if (xfs_sb_version_has_v3inode(&ip->i_mount->m_sb)) {
-		if (ip->i_df.if_format == XFS_DINODE_FMT_BTREE)
-			target_log_flags |= XFS_ILOG_DOWNER;
-		if (tip->i_df.if_format == XFS_DINODE_FMT_BTREE)
-			src_log_flags |= XFS_ILOG_DOWNER;
-	}
-
-	/*
-	 * Swap the data forks of the inodes
-	 */
-	swap(ip->i_df, tip->i_df);
-
-	/*
-	 * Fix the on-disk inode values
-	 */
-	tmp = (uint64_t)ip->i_d.di_nblocks;
-	ip->i_d.di_nblocks = tip->i_d.di_nblocks - taforkblks + aforkblks;
-	tip->i_d.di_nblocks = tmp + taforkblks - aforkblks;
-
-	/*
-	 * The extents in the source inode could still contain speculative
-	 * preallocation beyond EOF (e.g. the file is open but not modified
-	 * while defrag is in progress). In that case, we need to copy over the
-	 * number of delalloc blocks the data fork in the source inode is
-	 * tracking beyond EOF so that when the fork is truncated away when the
-	 * temporary inode is unlinked we don't underrun the i_delayed_blks
-	 * counter on that inode.
-	 */
-	ASSERT(tip->i_delayed_blks == 0);
-	tip->i_delayed_blks = ip->i_delayed_blks;
-	ip->i_delayed_blks = 0;
-
-	switch (ip->i_df.if_format) {
-	case XFS_DINODE_FMT_EXTENTS:
-		src_log_flags |= XFS_ILOG_DEXT;
-		break;
-	case XFS_DINODE_FMT_BTREE:
-		ASSERT(!xfs_sb_version_has_v3inode(&ip->i_mount->m_sb) ||
-		       (src_log_flags & XFS_ILOG_DOWNER));
-		src_log_flags |= XFS_ILOG_DBROOT;
-		break;
-	}
-
-	switch (tip->i_df.if_format) {
-	case XFS_DINODE_FMT_EXTENTS:
-		target_log_flags |= XFS_ILOG_DEXT;
-		break;
-	case XFS_DINODE_FMT_BTREE:
-		target_log_flags |= XFS_ILOG_DBROOT;
-		ASSERT(!xfs_sb_version_has_v3inode(&ip->i_mount->m_sb) ||
-		       (target_log_flags & XFS_ILOG_DOWNER));
-		break;
-	}
-
-	xfs_swapext_reflink_finish(*tpp, req, reflink_state);
-
-	xfs_trans_log_inode(*tpp, ip,  src_log_flags);
-	xfs_trans_log_inode(*tpp, tip, target_log_flags);
-
-	/*
-	 * The extent forks have been swapped, but crc=1,rmapbt=0 filesystems
-	 * have inode number owner values in the bmbt blocks that still refer to
-	 * the old inode. Scan each bmbt to fix up the owner values with the
-	 * inode number of the current inode.
-	 */
-	if (src_log_flags & XFS_ILOG_DOWNER) {
-		error = xfs_swap_change_owner(tpp, ip, tip);
-		if (error)
-			return error;
-	}
-	if (target_log_flags & XFS_ILOG_DOWNER) {
-		error = xfs_swap_change_owner(tpp, tip, ip);
-		if (error)
-			return error;
-	}
-
-	return 0;
-}
-
-int
-xfs_swap_extents(
-	struct xfs_inode	*ip,	/* target inode */
-	struct xfs_inode	*tip,	/* tmp inode */
-	struct xfs_swapext	*sxp)
-{
-	struct xfs_swapext_req	req = {
-		.ip1		= ip,
-		.ip2		= tip,
-		.whichfork	= XFS_DATA_FORK,
-	};
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
-	struct xfs_bstat	*sbp = &sxp->sx_stat;
-	int			error = 0;
-	int			lock_flags;
-	int			resblks = 0;
-	unsigned int		flags = 0;
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
-		int		w = XFS_DATA_FORK;
-		uint32_t	ipnext = ip->i_df.if_nextents;
-		uint32_t	tipnext	= tip->i_df.if_nextents;
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
-		 * If either inode straddles a bmapbt block allocation boundary,
-		 * the rmapbt algorithm triggers repeated allocs and frees as
-		 * extents are remapped. This can exhaust the block reservation
-		 * prematurely and cause shutdown. Return freed blocks to the
-		 * transaction reservation to counter this behavior.
-		 */
-		flags |= XFS_TRANS_RES_FDBLKS;
-	}
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0, flags,
-				&tp);
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
-	req.blockcount = XFS_B_TO_FSB(ip->i_mount, i_size_read(VFS_I(ip)));
-	if (xfs_sb_version_hasrmapbt(&mp->m_sb))
-		error = xfs_swapext(&tp, &req);
-	else
-		error = xfs_swap_extent_forks(&tp, &req);
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
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index de3173e64f47..cebdd492fa85 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -66,13 +66,6 @@ int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
 bool	xfs_can_free_eofblocks(struct xfs_inode *ip, bool force);
 int	xfs_free_eofblocks(struct xfs_inode *ip);
 
-int	xfs_swap_extents(struct xfs_inode *ip, struct xfs_inode *tip,
-			 struct xfs_swapext *sx);
-
-struct xfs_swapext_req;
-int xfs_swap_extent_forks(struct xfs_trans **tpp, struct xfs_swapext_req *req);
-int xfs_swap_extents_check_format(struct xfs_inode *ip, struct xfs_inode *tip);
-
 xfs_daddr_t xfs_fsb_to_db(struct xfs_inode *ip, xfs_fsblock_t fsb);
 
 xfs_extnum_t xfs_bmap_count_leaves(struct xfs_ifork *ifp, xfs_filblks_t *count);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index ac3192a433f9..1d808a68b50f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1870,81 +1870,43 @@ xfs_ioc_scrub_metadata(
 
 int
 xfs_ioc_swapext(
-	xfs_swapext_t	*sxp)
+	struct xfs_swapext	*sxp)
 {
-	xfs_inode_t     *ip, *tip;
-	struct fd	f, tmp;
-	int		error = 0;
+	struct file_xchg_range	fxr = { 0 };
+	struct fd		fd2, fd1;
+	int			error = 0;
 
-	/* Pull information for the target fd */
-	f = fdget((int)sxp->sx_fdtarget);
-	if (!f.file) {
-		error = -EINVAL;
-		goto out;
-	}
-
-	if (!(f.file->f_mode & FMODE_WRITE) ||
-	    !(f.file->f_mode & FMODE_READ) ||
-	    (f.file->f_flags & O_APPEND)) {
-		error = -EBADF;
-		goto out_put_file;
-	}
+	fd2 = fdget((int)sxp->sx_fdtarget);
+	if (!fd2.file)
+		return -EINVAL;
 
-	tmp = fdget((int)sxp->sx_fdtmp);
-	if (!tmp.file) {
+	fd1 = fdget((int)sxp->sx_fdtmp);
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
+	fxr.file1_fd = sxp->sx_fdtmp;
+	fxr.length = sxp->sx_length;
+	fxr.flags = FILE_XCHG_RANGE_NONATOMIC | FILE_XCHG_RANGE_FILE2_FRESH |
+		    FILE_XCHG_RANGE_FULL_FILES;
+	fxr.file2_ino = sxp->sx_stat.bs_ino;
+	fxr.file2_mtime = sxp->sx_stat.bs_mtime.tv_sec;
+	fxr.file2_ctime = sxp->sx_stat.bs_ctime.tv_sec;
+	fxr.file2_mtime_nsec = sxp->sx_stat.bs_mtime.tv_nsec;
+	fxr.file2_ctime_nsec = sxp->sx_stat.bs_ctime.tv_nsec;
 
-	if (IS_SWAPFILE(file_inode(f.file)) ||
-	    IS_SWAPFILE(file_inode(tmp.file))) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
+	error = vfs_xchg_file_range(fd1.file, fd2.file, &fxr);
 
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
 
@@ -2197,14 +2159,10 @@ xfs_file_ioctl(
 	case XFS_IOC_SWAPEXT: {
 		struct xfs_swapext	sxp;
 
-		if (copy_from_user(&sxp, arg, sizeof(xfs_swapext_t)))
+		if (copy_from_user(&sxp, arg, sizeof(struct xfs_swapext)))
 			return -EFAULT;
-		error = mnt_want_write_file(filp);
-		if (error)
-			return error;
-		error = xfs_ioc_swapext(&sxp);
-		mnt_drop_write_file(filp);
-		return error;
+
+		return xfs_ioc_swapext(&sxp);
 	}
 
 	case XFS_IOC_FSCOUNTS: {
diff --git a/fs/xfs/xfs_ioctl.h b/fs/xfs/xfs_ioctl.h
index bab6a5a92407..98c4ff127b0d 100644
--- a/fs/xfs/xfs_ioctl.h
+++ b/fs/xfs/xfs_ioctl.h
@@ -16,9 +16,7 @@ xfs_ioc_space(
 	struct file		*filp,
 	xfs_flock64_t		*bf);
 
-int
-xfs_ioc_swapext(
-	xfs_swapext_t	*sxp);
+int xfs_ioc_swapext(struct xfs_swapext *sxp);
 
 extern int
 xfs_find_handle(
diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index 33c09ec8e6c0..63186e0063ad 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -498,12 +498,8 @@ xfs_file_compat_ioctl(
 				   offsetof(struct xfs_swapext, sx_stat)) ||
 		    xfs_ioctl32_bstat_copyin(&sxp.sx_stat, &sxu->sx_stat))
 			return -EFAULT;
-		error = mnt_want_write_file(filp);
-		if (error)
-			return error;
-		error = xfs_ioc_swapext(&sxp);
-		mnt_drop_write_file(filp);
-		return error;
+
+		return xfs_ioc_swapext(&sxp);
 	}
 	case XFS_IOC_FSBULKSTAT_32:
 	case XFS_IOC_FSBULKSTAT_SINGLE_32:
diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
index ef74965198c6..395ab886ebe5 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -2,6 +2,11 @@
 /*
  * Copyright (C) 2021 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * The xfs_swap_extent_* functions are:
+ * Copyright (c) 2000-2006 Silicon Graphics, Inc.
+ * Copyright (c) 2012 Red Hat, Inc.
+ * All Rights Reserved.
  */
 #include "xfs.h"
 #include "xfs_fs.h"
@@ -15,6 +20,7 @@
 #include "xfs_trans.h"
 #include "xfs_quota.h"
 #include "xfs_bmap_util.h"
+#include "xfs_bmap_btree.h"
 #include "xfs_reflink.h"
 #include "xfs_trace.h"
 #include "xfs_swapext.h"
@@ -72,6 +78,273 @@ xfs_xchg_range_estimate(
 	return error;
 }
 
+/*
+ * We need to check that the format of the data fork in the temporary inode is
+ * valid for the target inode before doing the swap. This is not a problem with
+ * attr1 because of the fixed fork offset, but attr2 has a dynamically sized
+ * data fork depending on the space the attribute fork is taking so we can get
+ * invalid formats on the target inode.
+ *
+ * E.g. target has space for 7 extents in extent format, temp inode only has
+ * space for 6.  If we defragment down to 7 extents, then the tmp format is a
+ * btree, but when swapped it needs to be in extent format. Hence we can't just
+ * blindly swap data forks on attr2 filesystems.
+ *
+ * Note that we check the swap in both directions so that we don't end up with
+ * a corrupt temporary inode, either.
+ *
+ * Note that fixing the way xfs_fsr sets up the attribute fork in the source
+ * inode will prevent this situation from occurring, so all we do here is
+ * reject and log the attempt. basically we are putting the responsibility on
+ * userspace to get this right.
+ */
+STATIC int
+xfs_swap_extents_check_format(
+	struct xfs_inode	*ip,	/* target inode */
+	struct xfs_inode	*tip)	/* tmp inode */
+{
+	struct xfs_ifork	*ifp = &ip->i_df;
+	struct xfs_ifork	*tifp = &tip->i_df;
+
+	/* User/group/project quota ids must match if quotas are enforced. */
+	if (XFS_IS_QUOTA_ON(ip->i_mount) &&
+	    (!uid_eq(VFS_I(ip)->i_uid, VFS_I(tip)->i_uid) ||
+	     !gid_eq(VFS_I(ip)->i_gid, VFS_I(tip)->i_gid) ||
+	     ip->i_d.di_projid != tip->i_d.di_projid))
+		return -EINVAL;
+
+	/* Should never get a local format */
+	if (ifp->if_format == XFS_DINODE_FMT_LOCAL ||
+	    tifp->if_format == XFS_DINODE_FMT_LOCAL)
+		return -EINVAL;
+
+	/*
+	 * if the target inode has less extents that then temporary inode then
+	 * why did userspace call us?
+	 */
+	if (ifp->if_nextents < tifp->if_nextents)
+		return -EINVAL;
+
+	/*
+	 * If we have to use the (expensive) rmap swap method, we can
+	 * handle any number of extents and any format.
+	 */
+	if (xfs_sb_version_hasrmapbt(&ip->i_mount->m_sb))
+		return 0;
+
+	/*
+	 * if the target inode is in extent form and the temp inode is in btree
+	 * form then we will end up with the target inode in the wrong format
+	 * as we already know there are less extents in the temp inode.
+	 */
+	if (ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
+	    tifp->if_format == XFS_DINODE_FMT_BTREE)
+		return -EINVAL;
+
+	/* Check temp in extent form to max in target */
+	if (tifp->if_format == XFS_DINODE_FMT_EXTENTS &&
+	    tifp->if_nextents > XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK))
+		return -EINVAL;
+
+	/* Check target in extent form to max in temp */
+	if (ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
+	    ifp->if_nextents > XFS_IFORK_MAXEXT(tip, XFS_DATA_FORK))
+		return -EINVAL;
+
+	/*
+	 * If we are in a btree format, check that the temp root block will fit
+	 * in the target and that it has enough extents to be in btree format
+	 * in the target.
+	 *
+	 * Note that we have to be careful to allow btree->extent conversions
+	 * (a common defrag case) which will occur when the temp inode is in
+	 * extent format...
+	 */
+	if (tifp->if_format == XFS_DINODE_FMT_BTREE) {
+		if (XFS_IFORK_Q(ip) &&
+		    XFS_BMAP_BMDR_SPACE(tifp->if_broot) > XFS_IFORK_BOFF(ip))
+			return -EINVAL;
+		if (tifp->if_nextents <= XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK))
+			return -EINVAL;
+	}
+
+	/* Reciprocal target->temp btree format checks */
+	if (ifp->if_format == XFS_DINODE_FMT_BTREE) {
+		if (XFS_IFORK_Q(tip) &&
+		    XFS_BMAP_BMDR_SPACE(ip->i_df.if_broot) > XFS_IFORK_BOFF(tip))
+			return -EINVAL;
+		if (ifp->if_nextents <= XFS_IFORK_MAXEXT(tip, XFS_DATA_FORK))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Fix up the owners of the bmbt blocks to refer to the current inode. The
+ * change owner scan attempts to order all modified buffers in the current
+ * transaction. In the event of ordered buffer failure, the offending buffer is
+ * physically logged as a fallback and the scan returns -EAGAIN. We must roll
+ * the transaction in this case to replenish the fallback log reservation and
+ * restart the scan. This process repeats until the scan completes.
+ */
+STATIC int
+xfs_swap_change_owner(
+	struct xfs_trans	**tpp,
+	struct xfs_inode	*ip,
+	struct xfs_inode	*tmpip)
+{
+	int			error;
+	struct xfs_trans	*tp = *tpp;
+
+	do {
+		error = xfs_bmbt_change_owner(tp, ip, XFS_DATA_FORK, ip->i_ino,
+					      NULL);
+		/* success or fatal error */
+		if (error != -EAGAIN)
+			break;
+
+		error = xfs_trans_roll(tpp);
+		if (error)
+			break;
+		tp = *tpp;
+
+		/*
+		 * Redirty both inodes so they can relog and keep the log tail
+		 * moving forward.
+		 */
+		xfs_trans_ijoin(tp, ip, 0);
+		xfs_trans_ijoin(tp, tmpip, 0);
+		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+		xfs_trans_log_inode(tp, tmpip, XFS_ILOG_CORE);
+	} while (true);
+
+	return error;
+}
+
+/* Swap the extents of two files by swapping data forks. */
+STATIC int
+xfs_swap_extent_forks(
+	struct xfs_trans	**tpp,
+	struct xfs_swapext_req	*req)
+{
+	struct xfs_inode	*ip = req->ip2; /* target inode */
+	struct xfs_inode	*tip = req->ip1; /* tmp inode */
+	xfs_filblks_t		aforkblks = 0;
+	xfs_filblks_t		taforkblks = 0;
+	xfs_extnum_t		junk;
+	uint64_t		tmp;
+	unsigned int		reflink_state;
+	int			src_log_flags = XFS_ILOG_CORE;
+	int			target_log_flags = XFS_ILOG_CORE;
+	int			error;
+
+	reflink_state = xfs_swapext_reflink_prep(req);
+
+	/*
+	 * Count the number of extended attribute blocks
+	 */
+	if (XFS_IFORK_Q(ip) && ip->i_afp->if_nextents > 0 &&
+	    ip->i_afp->if_format != XFS_DINODE_FMT_LOCAL) {
+		error = xfs_bmap_count_blocks(*tpp, ip, XFS_ATTR_FORK, &junk,
+				&aforkblks);
+		if (error)
+			return error;
+	}
+	if (XFS_IFORK_Q(tip) && tip->i_afp->if_nextents > 0 &&
+	    tip->i_afp->if_format != XFS_DINODE_FMT_LOCAL) {
+		error = xfs_bmap_count_blocks(*tpp, tip, XFS_ATTR_FORK, &junk,
+				&taforkblks);
+		if (error)
+			return error;
+	}
+
+	/*
+	 * Btree format (v3) inodes have the inode number stamped in the bmbt
+	 * block headers. We can't start changing the bmbt blocks until the
+	 * inode owner change is logged so recovery does the right thing in the
+	 * event of a crash. Set the owner change log flags now and leave the
+	 * bmbt scan as the last step.
+	 */
+	if (xfs_sb_version_has_v3inode(&ip->i_mount->m_sb)) {
+		if (ip->i_df.if_format == XFS_DINODE_FMT_BTREE)
+			target_log_flags |= XFS_ILOG_DOWNER;
+		if (tip->i_df.if_format == XFS_DINODE_FMT_BTREE)
+			src_log_flags |= XFS_ILOG_DOWNER;
+	}
+
+	/*
+	 * Swap the data forks of the inodes
+	 */
+	swap(ip->i_df, tip->i_df);
+
+	/*
+	 * Fix the on-disk inode values
+	 */
+	tmp = (uint64_t)ip->i_d.di_nblocks;
+	ip->i_d.di_nblocks = tip->i_d.di_nblocks - taforkblks + aforkblks;
+	tip->i_d.di_nblocks = tmp + taforkblks - aforkblks;
+
+	/*
+	 * The extents in the source inode could still contain speculative
+	 * preallocation beyond EOF (e.g. the file is open but not modified
+	 * while defrag is in progress). In that case, we need to copy over the
+	 * number of delalloc blocks the data fork in the source inode is
+	 * tracking beyond EOF so that when the fork is truncated away when the
+	 * temporary inode is unlinked we don't underrun the i_delayed_blks
+	 * counter on that inode.
+	 */
+	ASSERT(tip->i_delayed_blks == 0);
+	tip->i_delayed_blks = ip->i_delayed_blks;
+	ip->i_delayed_blks = 0;
+
+	switch (ip->i_df.if_format) {
+	case XFS_DINODE_FMT_EXTENTS:
+		src_log_flags |= XFS_ILOG_DEXT;
+		break;
+	case XFS_DINODE_FMT_BTREE:
+		ASSERT(!xfs_sb_version_has_v3inode(&ip->i_mount->m_sb) ||
+		       (src_log_flags & XFS_ILOG_DOWNER));
+		src_log_flags |= XFS_ILOG_DBROOT;
+		break;
+	}
+
+	switch (tip->i_df.if_format) {
+	case XFS_DINODE_FMT_EXTENTS:
+		target_log_flags |= XFS_ILOG_DEXT;
+		break;
+	case XFS_DINODE_FMT_BTREE:
+		target_log_flags |= XFS_ILOG_DBROOT;
+		ASSERT(!xfs_sb_version_has_v3inode(&ip->i_mount->m_sb) ||
+		       (target_log_flags & XFS_ILOG_DOWNER));
+		break;
+	}
+
+	xfs_swapext_reflink_finish(*tpp, req, reflink_state);
+
+	xfs_trans_log_inode(*tpp, ip,  src_log_flags);
+	xfs_trans_log_inode(*tpp, tip, target_log_flags);
+
+	/*
+	 * The extent forks have been swapped, but crc=1,rmapbt=0 filesystems
+	 * have inode number owner values in the bmbt blocks that still refer to
+	 * the old inode. Scan each bmbt to fix up the owner values with the
+	 * inode number of the current inode.
+	 */
+	if (src_log_flags & XFS_ILOG_DOWNER) {
+		error = xfs_swap_change_owner(tpp, ip, tip);
+		if (error)
+			return error;
+	}
+	if (target_log_flags & XFS_ILOG_DOWNER) {
+		error = xfs_swap_change_owner(tpp, tip, ip);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
 /* Prepare two files to have their data exchanged. */
 int
 xfs_xchg_range_prep(

