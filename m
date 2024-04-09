Return-Path: <linux-fsdevel+bounces-16397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B67689D124
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E16285AEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C3B54BFD;
	Tue,  9 Apr 2024 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAcqiAwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C14EB46;
	Tue,  9 Apr 2024 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633765; cv=none; b=KUwPeRyH9xgO6Mx6W1YH+MpAAr52KWB7enKsp9oeSdpGBplo3Ga1GZ+/G3ZKcpIxihL0cberER0YNyQrfaqzIwfzPCPGtKc4T+b3dEqfnOQyRI0Q9fG1KgVAfNJkkC8gy/qjI0oaPxTnYF9v6ScHYEXzOB8K5WDTwzIpD5Obimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633765; c=relaxed/simple;
	bh=JQjTn6hFlZNHPUPix0RuRA5eYZXxR+BZL8gQMV46UjQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYI8ntOUDpnMK5Ts2t3PtqcVT+Djp5hnTCoVcFncW1HVNsBMS1kyVu6FAtIm8HCR6zDoJGhaVcLQPa7vzYDHNy6c462XinwtYKt7gKw4WLz+GBZPfwXO+n+rGGzII7P5rtZrKfojB4PGqLeGPBg0Np19HaAoUPooyLmJiJ5xNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAcqiAwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185D5C433F1;
	Tue,  9 Apr 2024 03:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633765;
	bh=JQjTn6hFlZNHPUPix0RuRA5eYZXxR+BZL8gQMV46UjQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rAcqiAwmg2o1qDR3gPyGMrYr4iFRkc+W0Ve3eSiE02I8EGejXk+lIDlvMHZOOXrmA
	 ipnOy2wbvkK8Cm6gIMg6m2q9nZ0gL51drV2yefnpm/G0kRbws4kMhMCxgi/HMyp14m
	 gYLEiRuCCtZhPEXS4kd5cQw3msJ8XVWnXY10VD/Anp5ekvK1b9nfVrLxYyn9FXuFkn
	 rLEQg5H/nhSN2ww9jTICW7hs4opFUYzpGa2Zn1ByoL8JLWR9v/aBE1EfdDNOj8fHkk
	 i02TTn4YM+YMykSJ+3xKhojTORRvjf8JS4G5ksYcO8iAQa2Ozkb+ycZwEeUVi/PM3B
	 //achHpZyrmrg==
Date: Mon, 08 Apr 2024 20:36:04 -0700
Subject: [PATCH 06/14] xfs: bind together the front and back ends of the file
 range exchange code
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <171263348564.2978056.4044359563518643318.stgit@frogsfrogsfrogs>
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

So far, we've constructed the front end of the file range exchange code
that does all the checking; and the back end of the file mapping
exchange code that actually does the work.  Glue these two pieces
together so that we can turn on the functionality.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_exchrange.c |  334 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h     |    5 +
 fs/xfs/xfs_trace.c     |    1 
 fs/xfs/xfs_trace.h     |  163 +++++++++++++++++++++++
 4 files changed, 501 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index 6dab81fab72fb..6ecbd9d4c9363 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -12,8 +12,15 @@
 #include "xfs_defer.h"
 #include "xfs_inode.h"
 #include "xfs_trans.h"
+#include "xfs_quota.h"
+#include "xfs_bmap_util.h"
+#include "xfs_reflink.h"
+#include "xfs_trace.h"
 #include "xfs_exchrange.h"
 #include "xfs_exchmaps.h"
+#include "xfs_sb.h"
+#include "xfs_icache.h"
+#include "xfs_log.h"
 #include <linux/fsnotify.h>
 
 /* Lock (and optionally join) two inodes for a file range exchange. */
@@ -64,6 +71,207 @@ xfs_exchrange_estimate(
 	return error;
 }
 
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
+xfs_exchrange_reserve_quota(
+	struct xfs_trans		*tp,
+	const struct xfs_exchmaps_req	*req,
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
+	ddelta = req->ip2_bcount - req->ip1_bcount;
+	rdelta = req->ip2_rtbcount - req->ip1_rtbcount;
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
+	error = xfs_trans_reserve_quota_nblks(tp, req->ip1, req->ip1_bcount,
+			req->ip1_rtbcount, true);
+	if (error)
+		return error;
+
+	return xfs_trans_reserve_quota_nblks(tp, req->ip2, req->ip2_bcount,
+			req->ip2_rtbcount, true);
+}
+
+/* Exchange the mappings (and hence the contents) of two files' forks. */
+STATIC int
+xfs_exchrange_mappings(
+	const struct xfs_exchrange	*fxr,
+	struct xfs_inode		*ip1,
+	struct xfs_inode		*ip2)
+{
+	struct xfs_mount		*mp = ip1->i_mount;
+	struct xfs_exchmaps_req		req = {
+		.ip1			= ip1,
+		.ip2			= ip2,
+		.startoff1		= XFS_B_TO_FSBT(mp, fxr->file1_offset),
+		.startoff2		= XFS_B_TO_FSBT(mp, fxr->file2_offset),
+		.blockcount		= XFS_B_TO_FSB(mp, fxr->length),
+	};
+	struct xfs_trans		*tp;
+	unsigned int			qretry;
+	bool				retried = false;
+	int				error;
+
+	trace_xfs_exchrange_mappings(fxr, ip1, ip2);
+
+	if (fxr->flags & XFS_EXCHANGE_RANGE_TO_EOF)
+		req.flags |= XFS_EXCHMAPS_SET_SIZES;
+	if (fxr->flags & XFS_EXCHANGE_RANGE_FILE1_WRITTEN)
+		req.flags |= XFS_EXCHMAPS_INO1_WRITTEN;
+
+	error = xfs_exchrange_estimate(&req);
+	if (error)
+		return error;
+
+retry:
+	/* Allocate the transaction, lock the inodes, and join them. */
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, req.resblks, 0,
+			XFS_TRANS_RES_FDBLKS, &tp);
+	if (error)
+		return error;
+
+	xfs_exchrange_ilock(tp, ip1, ip2);
+
+	trace_xfs_exchrange_before(ip2, 2);
+	trace_xfs_exchrange_before(ip1, 1);
+
+	error = xfs_exchmaps_check_forks(mp, &req);
+	if (error)
+		goto out_trans_cancel;
+
+	/*
+	 * Reserve ourselves some quota if any of them are in enforcing mode.
+	 * In theory we only need enough to satisfy the change in the number
+	 * of blocks between the two ranges being remapped.
+	 */
+	error = xfs_exchrange_reserve_quota(tp, &req, &qretry);
+	if ((error == -EDQUOT || error == -ENOSPC) && !retried) {
+		xfs_trans_cancel(tp);
+		xfs_exchrange_iunlock(ip1, ip2);
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
+	if (fxr->flags & XFS_EXCHANGE_RANGE_DRY_RUN)
+		goto out_trans_cancel;
+
+	/* Update the mtime and ctime of both files. */
+	if (fxr->flags & __XFS_EXCHANGE_RANGE_UPD_CMTIME1)
+		xfs_trans_ichgtime(tp, ip1, XFS_ICHGTIME_MOD | XFS_ICHGTIME_CHG);
+	if (fxr->flags & __XFS_EXCHANGE_RANGE_UPD_CMTIME2)
+		xfs_trans_ichgtime(tp, ip2, XFS_ICHGTIME_MOD | XFS_ICHGTIME_CHG);
+
+	xfs_exchange_mappings(tp, &req);
+
+	/*
+	 * Force the log to persist metadata updates if the caller or the
+	 * administrator requires this.  The generic prep function already
+	 * flushed the relevant parts of the page cache.
+	 */
+	if (xfs_has_wsync(mp) || (fxr->flags & XFS_EXCHANGE_RANGE_DSYNC))
+		xfs_trans_set_sync(tp);
+
+	error = xfs_trans_commit(tp);
+
+	trace_xfs_exchrange_after(ip2, 2);
+	trace_xfs_exchrange_after(ip1, 1);
+
+	if (error)
+		goto out_unlock;
+
+	/*
+	 * If the caller wanted us to exchange the contents of two complete
+	 * files of unequal length, exchange the incore sizes now.  This should
+	 * be safe because we flushed both files' page caches, exchanged all
+	 * the mappings, and updated the ondisk sizes.
+	 */
+	if (fxr->flags & XFS_EXCHANGE_RANGE_TO_EOF) {
+		loff_t	temp;
+
+		temp = i_size_read(VFS_I(ip2));
+		i_size_write(VFS_I(ip2), i_size_read(VFS_I(ip1)));
+		i_size_write(VFS_I(ip1), temp);
+	}
+
+out_unlock:
+	xfs_exchrange_iunlock(ip1, ip2);
+	return error;
+
+out_trans_cancel:
+	xfs_trans_cancel(tp);
+	goto out_unlock;
+}
+
 /*
  * Generic code for exchanging ranges of two files via XFS_IOC_EXCHANGE_RANGE.
  * This part deals with struct file objects and byte ranges and does not deal
@@ -287,6 +495,130 @@ xfs_exchange_range_finish(
 	return file_remove_privs(fxr->file2);
 }
 
+/* Prepare two files to have their data exchanged. */
+STATIC int
+xfs_exchrange_prep(
+	struct xfs_exchrange	*fxr,
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2)
+{
+	unsigned int		alloc_unit = xfs_inode_alloc_unitsize(ip2);
+	int			error;
+
+	trace_xfs_exchrange_prep(fxr, ip1, ip2);
+
+	/* Verify both files are either real-time or non-realtime */
+	if (XFS_IS_REALTIME_INODE(ip1) != XFS_IS_REALTIME_INODE(ip2))
+		return -EINVAL;
+
+	/*
+	 * The alignment checks in the generic helpers cannot deal with
+	 * allocation units that are not powers of 2.  This can happen with the
+	 * realtime volume if the extent size is set.
+	 */
+	if (!is_power_of_2(alloc_unit))
+		return -EOPNOTSUPP;
+
+	error = xfs_exchange_range_prep(fxr, alloc_unit);
+	if (error || fxr->length == 0)
+		return error;
+
+	/* Attach dquots to both inodes before changing block maps. */
+	error = xfs_qm_dqattach(ip2);
+	if (error)
+		return error;
+	error = xfs_qm_dqattach(ip1);
+	if (error)
+		return error;
+
+	trace_xfs_exchrange_flush(fxr, ip1, ip2);
+
+	/* Flush the relevant ranges of both files. */
+	error = xfs_flush_unmap_range(ip2, fxr->file2_offset, fxr->length);
+	if (error)
+		return error;
+	error = xfs_flush_unmap_range(ip1, fxr->file1_offset, fxr->length);
+	if (error)
+		return error;
+
+	/*
+	 * Cancel CoW fork preallocations for the ranges of both files.  The
+	 * prep function should have flushed all the dirty data, so the only
+	 * CoW mappings remaining should be speculative.
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
+	return 0;
+}
+
+/*
+ * Exchange contents of files.  This is the binding between the generic
+ * file-level concepts and the XFS inode-specific implementation.
+ */
+STATIC int
+xfs_exchrange_contents(
+	struct xfs_exchrange	*fxr)
+{
+	struct inode		*inode1 = file_inode(fxr->file1);
+	struct inode		*inode2 = file_inode(fxr->file2);
+	struct xfs_inode	*ip1 = XFS_I(inode1);
+	struct xfs_inode	*ip2 = XFS_I(inode2);
+	struct xfs_mount	*mp = ip1->i_mount;
+	int			error;
+
+	if (!xfs_has_exchange_range(mp))
+		return -EOPNOTSUPP;
+
+	if (fxr->flags & ~(XFS_EXCHANGE_RANGE_ALL_FLAGS |
+			   XFS_EXCHANGE_RANGE_PRIV_FLAGS))
+		return -EINVAL;
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	/* Lock both files against IO */
+	error = xfs_ilock2_io_mmap(ip1, ip2);
+	if (error)
+		goto out_err;
+
+	/* Prepare and then exchange file contents. */
+	error = xfs_exchrange_prep(fxr, ip1, ip2);
+	if (error)
+		goto out_unlock;
+
+	error = xfs_exchrange_mappings(fxr, ip1, ip2);
+	if (error)
+		goto out_unlock;
+
+	/*
+	 * Finish the exchange by removing special file privileges like any
+	 * other file write would do.  This may involve turning on support for
+	 * logged xattrs if either file has security capabilities.
+	 */
+	error = xfs_exchange_range_finish(fxr);
+	if (error)
+		goto out_unlock;
+
+out_unlock:
+	xfs_iunlock2_io_mmap(ip1, ip2);
+out_err:
+	if (error)
+		trace_xfs_exchrange_error(ip2, error, _RET_IP_);
+	return error;
+}
+
 /* Exchange parts of two files. */
 int
 xfs_exchange_range(
@@ -341,7 +673,7 @@ xfs_exchange_range(
 		fxr->flags |= __XFS_EXCHANGE_RANGE_UPD_CMTIME2;
 
 	file_start_write(fxr->file2);
-	ret = -EOPNOTSUPP; /* XXX call out to lower level code */
+	ret = xfs_exchrange_contents(fxr);
 	file_end_write(fxr->file2);
 	if (ret)
 		return ret;
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index c7b1d7b853ebc..7c02435c91b74 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -424,6 +424,8 @@ __XFS_HAS_FEAT(nouuid, NOUUID)
 #define XFS_OPSTATE_QUOTACHECK_RUNNING	10
 /* Do we want to clear log incompat flags? */
 #define XFS_OPSTATE_UNSET_LOG_INCOMPAT	11
+/* Kernel has logged a warning about logged file mapping exchanges being used. */
+#define XFS_OPSTATE_WARNED_EXCHMAPS	12
 
 #define __XFS_IS_OPSTATE(name, NAME) \
 static inline bool xfs_is_ ## name (struct xfs_mount *mp) \
@@ -471,7 +473,8 @@ xfs_should_warn(struct xfs_mount *mp, long nr)
 	{ (1UL << XFS_OPSTATE_WARNED_SHRINK),		"wshrink" }, \
 	{ (1UL << XFS_OPSTATE_WARNED_LARP),		"wlarp" }, \
 	{ (1UL << XFS_OPSTATE_QUOTACHECK_RUNNING),	"quotacheck" }, \
-	{ (1UL << XFS_OPSTATE_UNSET_LOG_INCOMPAT),	"unset_log_incompat" }
+	{ (1UL << XFS_OPSTATE_UNSET_LOG_INCOMPAT),	"unset_log_incompat" }, \
+	{ (1UL << XFS_OPSTATE_WARNED_EXCHMAPS),		"wexchmaps" }
 
 /*
  * Max and min values for mount-option defined I/O
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index 9f38e69f1ce40..cf92a3bd56c79 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -40,6 +40,7 @@
 #include "xfs_btree_mem.h"
 #include "xfs_bmap.h"
 #include "xfs_exchmaps.h"
+#include "xfs_exchrange.h"
 
 /*
  * We include this last to have the helpers above available for the trace
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 7c17d1f80fec3..e18480109e08c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -84,6 +84,7 @@ struct xfs_btree_ops;
 struct xfs_bmap_intent;
 struct xfs_exchmaps_intent;
 struct xfs_exchmaps_req;
+struct xfs_exchrange;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -4785,6 +4786,168 @@ DEFINE_INODE_IREC_EVENT(xfs_exchmaps_mapping1);
 DEFINE_INODE_IREC_EVENT(xfs_exchmaps_mapping2);
 DEFINE_ITRUNC_EVENT(xfs_exchmaps_update_inode_size);
 
+#define XFS_EXCHRANGE_INODES \
+	{ 1,	"file1" }, \
+	{ 2,	"file2" }
+
+DECLARE_EVENT_CLASS(xfs_exchrange_inode_class,
+	TP_PROTO(struct xfs_inode *ip, int whichfile),
+	TP_ARGS(ip, whichfile),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(int, whichfile)
+		__field(xfs_ino_t, ino)
+		__field(int, format)
+		__field(xfs_extnum_t, nex)
+		__field(int, broot_size)
+		__field(int, fork_off)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->whichfile = whichfile;
+		__entry->ino = ip->i_ino;
+		__entry->format = ip->i_df.if_format;
+		__entry->nex = ip->i_df.if_nextents;
+		__entry->fork_off = xfs_inode_fork_boff(ip);
+	),
+	TP_printk("dev %d:%d ino 0x%llx whichfile %s format %s num_extents %llu forkoff 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __print_symbolic(__entry->whichfile, XFS_EXCHRANGE_INODES),
+		  __print_symbolic(__entry->format, XFS_INODE_FORMAT_STR),
+		  __entry->nex,
+		  __entry->fork_off)
+)
+
+#define DEFINE_EXCHRANGE_INODE_EVENT(name) \
+DEFINE_EVENT(xfs_exchrange_inode_class, name, \
+	TP_PROTO(struct xfs_inode *ip, int whichfile), \
+	TP_ARGS(ip, whichfile))
+
+DEFINE_EXCHRANGE_INODE_EVENT(xfs_exchrange_before);
+DEFINE_EXCHRANGE_INODE_EVENT(xfs_exchrange_after);
+DEFINE_INODE_ERROR_EVENT(xfs_exchrange_error);
+
+#define XFS_EXCHANGE_RANGE_FLAGS_STRS \
+	{ XFS_EXCHANGE_RANGE_TO_EOF,		"TO_EOF" }, \
+	{ XFS_EXCHANGE_RANGE_DSYNC	,	"DSYNC" }, \
+	{ XFS_EXCHANGE_RANGE_DRY_RUN,		"DRY_RUN" }, \
+	{ XFS_EXCHANGE_RANGE_FILE1_WRITTEN,	"F1_WRITTEN" }, \
+	{ __XFS_EXCHANGE_RANGE_UPD_CMTIME1,	"CMTIME1" }, \
+	{ __XFS_EXCHANGE_RANGE_UPD_CMTIME2,	"CMTIME2" }
+
+/* file exchange-range tracepoint class */
+DECLARE_EVENT_CLASS(xfs_exchrange_class,
+	TP_PROTO(const struct xfs_exchrange *fxr, struct xfs_inode *ip1,
+		 struct xfs_inode *ip2),
+	TP_ARGS(fxr, ip1, ip2),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ip1_ino)
+		__field(loff_t, ip1_isize)
+		__field(loff_t, ip1_disize)
+		__field(xfs_ino_t, ip2_ino)
+		__field(loff_t, ip2_isize)
+		__field(loff_t, ip2_disize)
+
+		__field(loff_t, file1_offset)
+		__field(loff_t, file2_offset)
+		__field(unsigned long long, length)
+		__field(unsigned long long, flags)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip1)->i_sb->s_dev;
+		__entry->ip1_ino = ip1->i_ino;
+		__entry->ip1_isize = VFS_I(ip1)->i_size;
+		__entry->ip1_disize = ip1->i_disk_size;
+		__entry->ip2_ino = ip2->i_ino;
+		__entry->ip2_isize = VFS_I(ip2)->i_size;
+		__entry->ip2_disize = ip2->i_disk_size;
+
+		__entry->file1_offset = fxr->file1_offset;
+		__entry->file2_offset = fxr->file2_offset;
+		__entry->length = fxr->length;
+		__entry->flags = fxr->flags;
+	),
+	TP_printk("dev %d:%d flags %s bytecount 0x%llx "
+		  "ino1 0x%llx isize 0x%llx disize 0x%llx pos 0x%llx -> "
+		  "ino2 0x%llx isize 0x%llx disize 0x%llx pos 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		   __print_flags_u64(__entry->flags, "|", XFS_EXCHANGE_RANGE_FLAGS_STRS),
+		  __entry->length,
+		  __entry->ip1_ino,
+		  __entry->ip1_isize,
+		  __entry->ip1_disize,
+		  __entry->file1_offset,
+		  __entry->ip2_ino,
+		  __entry->ip2_isize,
+		  __entry->ip2_disize,
+		  __entry->file2_offset)
+)
+
+#define DEFINE_EXCHRANGE_EVENT(name)	\
+DEFINE_EVENT(xfs_exchrange_class, name,	\
+	TP_PROTO(const struct xfs_exchrange *fxr, struct xfs_inode *ip1, \
+		 struct xfs_inode *ip2), \
+	TP_ARGS(fxr, ip1, ip2))
+DEFINE_EXCHRANGE_EVENT(xfs_exchrange_prep);
+DEFINE_EXCHRANGE_EVENT(xfs_exchrange_flush);
+DEFINE_EXCHRANGE_EVENT(xfs_exchrange_mappings);
+
+TRACE_EVENT(xfs_exchrange_freshness,
+	TP_PROTO(const struct xfs_exchrange *fxr, struct xfs_inode *ip2),
+	TP_ARGS(fxr, ip2),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ip2_ino)
+		__field(long long, ip2_mtime)
+		__field(long long, ip2_ctime)
+		__field(int, ip2_mtime_nsec)
+		__field(int, ip2_ctime_nsec)
+
+		__field(xfs_ino_t, file2_ino)
+		__field(long long, file2_mtime)
+		__field(long long, file2_ctime)
+		__field(int, file2_mtime_nsec)
+		__field(int, file2_ctime_nsec)
+	),
+	TP_fast_assign(
+		struct timespec64	ts64;
+		struct inode		*inode2 = VFS_I(ip2);
+
+		__entry->dev = inode2->i_sb->s_dev;
+		__entry->ip2_ino = ip2->i_ino;
+
+		ts64 = inode_get_ctime(inode2);
+		__entry->ip2_ctime = ts64.tv_sec;
+		__entry->ip2_ctime_nsec = ts64.tv_nsec;
+
+		ts64 = inode_get_mtime(inode2);
+		__entry->ip2_mtime = ts64.tv_sec;
+		__entry->ip2_mtime_nsec = ts64.tv_nsec;
+
+		__entry->file2_ino = fxr->file2_ino;
+		__entry->file2_mtime = fxr->file2_mtime.tv_sec;
+		__entry->file2_ctime = fxr->file2_ctime.tv_sec;
+		__entry->file2_mtime_nsec = fxr->file2_mtime.tv_nsec;
+		__entry->file2_ctime_nsec = fxr->file2_ctime.tv_nsec;
+	),
+	TP_printk("dev %d:%d "
+		  "ino 0x%llx mtime %lld:%d ctime %lld:%d -> "
+		  "file 0x%llx mtime %lld:%d ctime %lld:%d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ip2_ino,
+		  __entry->ip2_mtime,
+		  __entry->ip2_mtime_nsec,
+		  __entry->ip2_ctime,
+		  __entry->ip2_ctime_nsec,
+		  __entry->file2_ino,
+		  __entry->file2_mtime,
+		  __entry->file2_mtime_nsec,
+		  __entry->file2_ctime,
+		  __entry->file2_ctime_nsec)
+);
+
 TRACE_EVENT(xfs_exchmaps_overhead,
 	TP_PROTO(struct xfs_mount *mp, unsigned long long bmbt_blocks,
 		 unsigned long long rmapbt_blocks),


