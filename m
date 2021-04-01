Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE52350B9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhDABKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhDABJd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:09:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9702361057;
        Thu,  1 Apr 2021 01:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239372;
        bh=fNgKVu+7+7Q7kv+mCrDKUEIBIvmyk5Z2U9dNLPOX4kM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tg/ZOB0439EVqVrgp6zsMwZPv6sPew6Fo6pS+SPwn8CTR2du0J0M/PSCLyJFEyKTV
         Y9yfco42kMDkyE1Yzrw7JS+uNQf8xFhGZFd9BM7XBD+G4buV4iGMol0ofNsFAEZl1t
         aJdeOhUSqlmrfNdTpsi0Qv7QrtnPbOgcCfg1EjrhzRr+zWwDf6EBhcTUR6MRITvglx
         wQMC2Z8Q/vMzVG9NR5Y1apeNWlfRaTCjCImLJ2FGMcQ1lK0b2rZEEiDskjZ4NW80C1
         F596WH0C3avchyi1YrF71iQ+tWYpeIxJImFTIv2QtPYrL5cOb3WV64oPfL5eVpWuZI
         C3t+GhZK0miYw==
Subject: [PATCH 08/18] xfs: add a ->xchg_file_range handler
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:31 -0700
Message-ID: <161723937168.3149451.17156038590992431745.stgit@magnolia>
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

Add a function to handle file range exchange requests from the vfs.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c      |   49 ++++++
 fs/xfs/xfs_inode.c     |   13 ++
 fs/xfs/xfs_inode.h     |    1 
 fs/xfs/xfs_trace.h     |    4 +
 fs/xfs/xfs_xchgrange.c |  379 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_xchgrange.h |   11 +
 6 files changed, 457 insertions(+)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a007ca0711d9..84a29d01c896 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -24,6 +24,7 @@
 #include "xfs_pnfs.h"
 #include "xfs_iomap.h"
 #include "xfs_reflink.h"
+#include "xfs_xchgrange.h"
 
 #include <linux/falloc.h>
 #include <linux/backing-dev.h>
@@ -1178,6 +1179,53 @@ xfs_file_remap_range(
 	return remapped > 0 ? remapped : ret;
 }
 
+STATIC int
+xfs_file_xchg_range(
+	struct file		*file1,
+	struct file		*file2,
+	struct file_xchg_range	*fxr)
+{
+	struct inode		*inode1 = file_inode(file1);
+	struct inode		*inode2 = file_inode(file2);
+	struct xfs_inode	*ip1 = XFS_I(inode1);
+	struct xfs_inode	*ip2 = XFS_I(inode2);
+	struct xfs_mount	*mp = ip1->i_mount;
+	unsigned int		priv_flags = 0;
+	int			ret;
+
+	if (XFS_FORCED_SHUTDOWN(mp))
+		return -EIO;
+
+	/* Update cmtime if the fd/inode don't forbid it. */
+	if (likely(!(file1->f_mode & FMODE_NOCMTIME) && !IS_NOCMTIME(inode1)))
+		priv_flags |= XFS_XCHG_RANGE_UPD_CMTIME1;
+	if (likely(!(file2->f_mode & FMODE_NOCMTIME) && !IS_NOCMTIME(inode2)))
+		priv_flags |= XFS_XCHG_RANGE_UPD_CMTIME2;
+
+	/* Lock both files against IO */
+	ret = xfs_ilock2_io_mmap(ip1, ip2);
+	if (ret)
+		return ret;
+
+	/* Prepare and then exchange file contents. */
+	ret = xfs_xchg_range_prep(file1, file2, fxr);
+	if (ret)
+		goto out_unlock;
+
+	trace_xfs_file_xchg_range(ip1, fxr->file1_offset, fxr->length, ip2,
+			fxr->file2_offset);
+
+	ret = xfs_xchg_range(ip1, ip2, fxr, priv_flags);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	xfs_iunlock2_io_mmap(ip1, ip2);
+	if (ret)
+		trace_xfs_file_xchg_range_error(ip2, ret, _RET_IP_);
+	return ret;
+}
+
 STATIC int
 xfs_file_open(
 	struct inode	*inode,
@@ -1443,6 +1491,7 @@ const struct file_operations xfs_file_operations = {
 	.fallocate	= xfs_file_fallocate,
 	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
+	.xchg_file_range = xfs_file_xchg_range,
 };
 
 const struct file_operations xfs_dir_file_operations = {
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 85287f764f4a..59706de3a9d0 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3838,3 +3838,16 @@ xfs_inode_count_blocks(
 	xfs_bmap_count_leaves(ifp, rblocks);
 	*dblocks = ip->i_d.di_nblocks - *rblocks;
 }
+
+/* Returns the size of fundamental allocation unit for a file, in bytes. */
+unsigned int
+xfs_inode_alloc_unitsize(
+	struct xfs_inode	*ip)
+{
+	unsigned int		blocks = 1;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		blocks = ip->i_mount->m_sb.sb_rextsize;
+
+	return XFS_FSB_TO_B(ip->i_mount, blocks);
+}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 1eebd5d03d01..81c7c695fb92 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -500,6 +500,7 @@ void xfs_end_io(struct work_struct *work);
 
 int xfs_ilock2_io_mmap(struct xfs_inode *ip1, struct xfs_inode *ip2);
 void xfs_iunlock2_io_mmap(struct xfs_inode *ip1, struct xfs_inode *ip2);
+unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
 
 void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index dc9cc3c67e58..f4e739e81594 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3319,6 +3319,10 @@ DEFINE_INODE_IREC_EVENT(xfs_reflink_cancel_cow);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap_piece);
 DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_rmap_error);
+
+/* swapext tracepoints */
+DEFINE_DOUBLE_IO_EVENT(xfs_file_xchg_range);
+DEFINE_INODE_ERROR_EVENT(xfs_file_xchg_range_error);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent2);
 DEFINE_ITRUNC_EVENT(xfs_swapext_update_inode_size);
diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
index 5e7098d5838e..877ef9f3eb64 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -13,8 +13,15 @@
 #include "xfs_defer.h"
 #include "xfs_inode.h"
 #include "xfs_trans.h"
+#include "xfs_quota.h"
+#include "xfs_bmap_util.h"
+#include "xfs_reflink.h"
+#include "xfs_trace.h"
 #include "xfs_swapext.h"
 #include "xfs_xchgrange.h"
+#include "xfs_sb.h"
+#include "xfs_icache.h"
+#include "xfs_log.h"
 
 /* Lock (and optionally join) two inodes for a file range exchange. */
 void
@@ -64,3 +71,375 @@ xfs_xchg_range_estimate(
 	xfs_xchg_range_iunlock(req->ip1, req->ip2);
 	return error;
 }
+
+/* Prepare two files to have their data exchanged. */
+int
+xfs_xchg_range_prep(
+	struct file		*file1,
+	struct file		*file2,
+	struct file_xchg_range	*fxr)
+{
+	struct xfs_inode	*ip1 = XFS_I(file_inode(file1));
+	struct xfs_inode	*ip2 = XFS_I(file_inode(file2));
+	int			ret;
+
+	/* Verify both files are either real-time or non-realtime */
+	if (XFS_IS_REALTIME_INODE(ip1) != XFS_IS_REALTIME_INODE(ip2))
+		return -EINVAL;
+
+	/*
+	 * The alignment checks in the VFS helpers cannot deal with allocation
+	 * units that are not powers of 2.  This can happen with the realtime
+	 * volume if the extent size is set.  Note that alignment checks are
+	 * skipped if FULL_FILES is set.
+	 */
+	if (!(fxr->flags & FILE_XCHG_RANGE_FULL_FILES) &&
+	    !is_power_of_2(xfs_inode_alloc_unitsize(ip2)))
+		return -EOPNOTSUPP;
+
+	ret = generic_xchg_file_range_prep(file1, file2, fxr,
+			xfs_inode_alloc_unitsize(ip2));
+	if (ret)
+		return ret;
+
+	/* Attach dquots to both inodes before changing block maps. */
+	ret = xfs_qm_dqattach(ip2);
+	if (ret)
+		return ret;
+	ret = xfs_qm_dqattach(ip1);
+	if (ret)
+		return ret;
+
+	/* Flush the relevant ranges of both files. */
+	ret = xfs_flush_unmap_range(ip2, fxr->file2_offset, fxr->length);
+	if (ret)
+		return ret;
+	return xfs_flush_unmap_range(ip1, fxr->file1_offset, fxr->length);
+}
+
+#define QRETRY_IP1	(0x1)
+#define QRETRY_IP2	(0x2)
+
+/*
+ * Obtain a quota reservation to make sure we don't hit EDQUOT.  We can skip
+ * this if quota enforcement is disabled or if both inodes' dquots are the
+ * same.  The qretry structure must be initialized to zeroes before the first
+ * call to this function.
+ */
+STATIC int
+xfs_xchg_range_reserve_quota(
+	struct xfs_trans		*tp,
+	const struct xfs_swapext_req	*req,
+	const struct xfs_swapext_res	*res,
+	unsigned int			*qretry)
+{
+	int64_t				ddelta, rdelta;
+	int				ip1_error = 0;
+	int				error;
+
+	/*
+	 * Don't bother with a quota reservation if we're not enforcing them
+	 * or the two inodes have the same dquots.
+	 */
+	if (!XFS_IS_QUOTA_ON(tp->t_mountp) || req->ip1 == req->ip2 ||
+	    (req->ip1->i_udquot == req->ip2->i_udquot &&
+	     req->ip1->i_gdquot == req->ip2->i_gdquot &&
+	     req->ip1->i_pdquot == req->ip2->i_pdquot))
+		return 0;
+
+	*qretry = 0;
+
+	/*
+	 * For each file, compute the net gain in the number of regular blocks
+	 * that will be mapped into that file and reserve that much quota.  The
+	 * quota counts must be able to absorb at least that much space.
+	 */
+	ddelta = res->ip2_bcount - res->ip1_bcount;
+	rdelta = res->ip2_rtbcount - res->ip1_rtbcount;
+	if (ddelta > 0 || rdelta > 0) {
+		error = xfs_trans_reserve_quota_nblks(tp, req->ip1,
+				ddelta > 0 ? ddelta : 0,
+				rdelta > 0 ? rdelta : 0,
+				false);
+		if (error == -EDQUOT || error == -ENOSPC) {
+			/*
+			 * Save this error and see what happens if we try to
+			 * reserve quota for ip2.  Then report both.
+			 */
+			*qretry |= QRETRY_IP1;
+			ip1_error = error;
+			error = 0;
+		}
+		if (error)
+			return error;
+	}
+	if (ddelta < 0 || rdelta < 0) {
+		error = xfs_trans_reserve_quota_nblks(tp, req->ip2,
+				ddelta < 0 ? -ddelta : 0,
+				rdelta < 0 ? -rdelta : 0,
+				false);
+		if (error == -EDQUOT || error == -ENOSPC)
+			*qretry |= QRETRY_IP2;
+		if (error)
+			return error;
+	}
+	if (ip1_error)
+		return ip1_error;
+
+	/*
+	 * For each file, forcibly reserve the gross gain in mapped blocks so
+	 * that we don't trip over any quota block reservation assertions.
+	 * We must reserve the gross gain because the quota code subtracts from
+	 * bcount the number of blocks that we unmap; it does not add that
+	 * quantity back to the quota block reservation.
+	 */
+	error = xfs_trans_reserve_quota_nblks(tp, req->ip1, res->ip1_bcount,
+			res->ip1_rtbcount, true);
+	if (error)
+		return error;
+
+	return xfs_trans_reserve_quota_nblks(tp, req->ip2, res->ip2_bcount,
+			res->ip2_rtbcount, true);
+}
+
+/*
+ * Get permission to use log-assisted atomic exchange of file extents.
+ *
+ * Callers must not be running any transactions, and they must release the
+ * permission either (1) by calling xlog_drop_incompat_feat when they're done,
+ * or (2) by setting XFS_TRANS_LOG_INCOMPAT on a transaction.
+ */
+STATIC int
+xfs_swapext_enable_log_assist(
+	struct xfs_mount	*mp,
+	bool			force,
+	bool			*enabled)
+{
+	int			error = 0;
+
+	/*
+	 * Protect ourselves from an idle log clearing the atomic swapext
+	 * log incompat feature bit.
+	 */
+	xlog_use_incompat_feat(mp->m_log);
+	*enabled = true;
+
+	/* Already enabled?  We're good to go. */
+	if (xfs_sb_version_hasatomicswap(&mp->m_sb))
+		return 0;
+
+	/*
+	 * If the caller doesn't /require/ log-assisted swapping, drop the
+	 * feature protection and exit.  They'll just have to use something
+	 * else.
+	 */
+	if (!force)
+		goto err;
+
+	/*
+	 * Caller requires log-assisted swapping but the fs feature set isn't
+	 * rich enough.  We have to bail out here.
+	 */
+	if (!xfs_sb_version_canatomicswap(&mp->m_sb)) {
+		error = -EOPNOTSUPP;
+		goto err;
+	}
+
+	/* Enable log-assisted extent swapping. */
+	xfs_warn(mp,
+ "EXPERIMENTAL atomic file range swap feature added. Use at your own risk!");
+	error = xfs_add_incompat_log_feature(mp,
+			XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP);
+	if (error)
+		goto err;
+	return 0;
+err:
+	xlog_drop_incompat_feat(mp->m_log);
+	*enabled = false;
+	return error;
+}
+
+/* Exchange the contents of two files. */
+int
+xfs_xchg_range(
+	struct xfs_inode		*ip1,
+	struct xfs_inode		*ip2,
+	const struct file_xchg_range	*fxr,
+	unsigned int			private_flags)
+{
+	struct xfs_swapext_req		req = {
+		.ip1			= ip1,
+		.ip2			= ip2,
+		.whichfork		= XFS_DATA_FORK,
+	};
+	struct xfs_swapext_res		res;
+	struct xfs_mount		*mp = ip1->i_mount;
+	struct xfs_trans		*tp;
+	loff_t				req_len;
+	unsigned int			qretry;
+	bool				retried = false;
+	bool				use_atomic = false;
+	int				error;
+
+	/* We don't support whole-fork swapping yet. */
+	if (!xfs_sb_version_canatomicswap(&mp->m_sb))
+		return -EOPNOTSUPP;
+
+	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF)
+		req.flags |= XFS_SWAPEXT_SET_SIZES;
+	if (fxr->flags & FILE_XCHG_RANGE_SKIP_FILE1_HOLES)
+		req.flags |= XFS_SWAPEXT_SKIP_FILE1_HOLES;
+
+	req.startoff1 = XFS_B_TO_FSBT(mp, fxr->file1_offset);
+	req.startoff2 = XFS_B_TO_FSBT(mp, fxr->file2_offset);
+
+	/*
+	 * Round the request length up to the nearest fundamental unit of
+	 * allocation.  The prep function already checked that the request
+	 * offsets and length in @fxr are safe to round up.
+	 */
+	req_len = round_up(fxr->length, xfs_inode_alloc_unitsize(ip2));
+	req.blockcount = XFS_B_TO_FSB(mp, req_len);
+
+	/*
+	 * Cancel CoW fork preallocations for the ranges of both files.  The
+	 * prep function should have flushed all the dirty data, so the only
+	 * extents remaining should be speculative.
+	 */
+	if (xfs_inode_has_cow_data(ip1)) {
+		error = xfs_reflink_cancel_cow_range(ip1, fxr->file1_offset,
+				fxr->length, true);
+		if (error)
+			return error;
+	}
+
+	if (xfs_inode_has_cow_data(ip2)) {
+		error = xfs_reflink_cancel_cow_range(ip2, fxr->file2_offset,
+				fxr->length, true);
+		if (error)
+			return error;
+	}
+
+	error = xfs_xchg_range_estimate(&req, &res);
+	if (error)
+		return error;
+
+	error = xfs_swapext_enable_log_assist(mp,
+			!(fxr->flags & FILE_XCHG_RANGE_NONATOMIC),
+			&use_atomic);
+	if (error)
+		return error;
+
+retry:
+	/* Allocate the transaction, lock the inodes, and join them. */
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, res.resblks, 0,
+			XFS_TRANS_RES_FDBLKS, &tp);
+	if (error)
+		goto out_unlock_feat;
+
+	xfs_xchg_range_ilock(tp, ip1, ip2);
+
+	trace_xfs_swap_extent_before(ip2, 0);
+	trace_xfs_swap_extent_before(ip1, 1);
+
+	/*
+	 * Do all of the inputs checking that we can only do once we've taken
+	 * both ILOCKs.
+	 */
+	error = generic_xchg_file_range_check_fresh(VFS_I(ip1), VFS_I(ip2),
+			fxr);
+	if (error)
+		goto out_trans_cancel;
+
+	error = xfs_swapext_check_extents(mp, &req);
+	if (error)
+		goto out_trans_cancel;
+
+	/*
+	 * Reserve ourselves some quota if any of them are in enforcing mode.
+	 * In theory we only need enough to satisfy the change in the number
+	 * of blocks between the two ranges being remapped.
+	 */
+	error = xfs_xchg_range_reserve_quota(tp, &req, &res, &qretry);
+	if ((error == -EDQUOT || error == -ENOSPC) && !retried) {
+		xfs_trans_cancel(tp);
+		xfs_xchg_range_iunlock(ip1, ip2);
+		if (qretry & QRETRY_IP1)
+			xfs_blockgc_free_quota(ip1, 0);
+		if (qretry & QRETRY_IP2)
+			xfs_blockgc_free_quota(ip2, 0);
+		retried = true;
+		goto retry;
+	}
+	if (error)
+		goto out_trans_cancel;
+
+	/* If we got this far on a dry run, all parameters are ok. */
+	if (fxr->flags & FILE_XCHG_RANGE_DRY_RUN)
+		goto out_trans_cancel;
+
+	/*
+	 * If we got permission to use the atomic extent swap feature, put the
+	 * transaction in charge of releasing that permission.
+	 */
+	if (use_atomic) {
+		tp->t_flags |= XFS_TRANS_LOG_INCOMPAT;
+		use_atomic = false;
+	}
+
+	/* Update the mtime and ctime of both files. */
+	if (private_flags & XFS_XCHG_RANGE_UPD_CMTIME1)
+		xfs_trans_ichgtime(tp, ip1,
+				XFS_ICHGTIME_MOD | XFS_ICHGTIME_CHG);
+	if (private_flags & XFS_XCHG_RANGE_UPD_CMTIME2)
+		xfs_trans_ichgtime(tp, ip2,
+				XFS_ICHGTIME_MOD | XFS_ICHGTIME_CHG);
+
+	/* Exchange the file contents by swapping the block mappings. */
+	error = xfs_swapext(&tp, &req);
+	if (error)
+		goto out_trans_cancel;
+
+	/*
+	 * If the caller wanted us to exchange the contents of two complete
+	 * files of unequal length, exchange the incore sizes now.  This should
+	 * be safe because we flushed both files' page caches and moved all the
+	 * post-eof extents, so there should not be anything to zero.
+	 */
+	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF) {
+		loff_t	temp;
+
+		temp = i_size_read(VFS_I(ip2));
+		i_size_write(VFS_I(ip2), i_size_read(VFS_I(ip1)));
+		i_size_write(VFS_I(ip1), temp);
+	}
+
+	/* Relog the inodes to keep transactions moving forward. */
+	xfs_trans_log_inode(tp, ip1, XFS_ILOG_CORE);
+	xfs_trans_log_inode(tp, ip2, XFS_ILOG_CORE);
+
+	/*
+	 * Force the log to persist metadata updates if the caller or the
+	 * administrator requires this.  The VFS prep function already flushed
+	 * the relevant parts of the page cache.
+	 */
+	if ((mp->m_flags & XFS_MOUNT_WSYNC) ||
+	    (fxr->flags & FILE_XCHG_RANGE_FSYNC))
+		xfs_trans_set_sync(tp);
+
+	error = xfs_trans_commit(tp);
+
+	trace_xfs_swap_extent_after(ip2, 0);
+	trace_xfs_swap_extent_after(ip1, 1);
+
+out_unlock:
+	xfs_xchg_range_iunlock(ip1, ip2);
+out_unlock_feat:
+	if (use_atomic)
+		xlog_drop_incompat_feat(mp->m_log);
+	return error;
+
+out_trans_cancel:
+	xfs_trans_cancel(tp);
+	goto out_unlock;
+}
diff --git a/fs/xfs/xfs_xchgrange.h b/fs/xfs/xfs_xchgrange.h
index ddda2bfb6f4b..cca297034689 100644
--- a/fs/xfs/xfs_xchgrange.h
+++ b/fs/xfs/xfs_xchgrange.h
@@ -15,5 +15,16 @@ void xfs_xchg_range_iunlock(struct xfs_inode *ip1, struct xfs_inode *ip2);
 
 int xfs_xchg_range_estimate(const struct xfs_swapext_req *req,
 		struct xfs_swapext_res *res);
+int xfs_xchg_range_prep(struct file *file1, struct file *file2,
+		struct file_xchg_range *fxr);
+
+/* Update ip1's change and mod time. */
+#define XFS_XCHG_RANGE_UPD_CMTIME1	(1 << 0)
+
+/* Update ip2's change and mod time. */
+#define XFS_XCHG_RANGE_UPD_CMTIME2	(1 << 1)
+
+int xfs_xchg_range(struct xfs_inode *ip1, struct xfs_inode *ip2,
+		const struct file_xchg_range *fxr, unsigned int private_flags);
 
 #endif /* __XFS_XCHGRANGE_H__ */

