Return-Path: <linux-fsdevel+bounces-16990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9E8A5E96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D88B221B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA8D15920B;
	Mon, 15 Apr 2024 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX6b9rI7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0853C156974;
	Mon, 15 Apr 2024 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224543; cv=none; b=Sce5HlUoSFW1x0UbUj36u3sgg+dpF3L94xQo/oikiUIFvx+IuwGkm8rs8AMoolU548VLyo7NyzI+gDH7A4cnJF9NNjgYoQv8z/MDjJjagUd3pIPgoDTEiJWSo78qZyP698xXz4WzPYy3e30vqEafCizSxPsYdkYG+RNSKmvxy9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224543; c=relaxed/simple;
	bh=vIjsogSzRkMiJxgxVub12DFvG5ZNGZrAj2KJ0f3Qpto=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIa7n7btmX8tJvw2p5LR3ijQZypkrycVr0ia9TuZufcL3Y/DSK0eLMhAlCRHRJaJaUxfX/lOu7Foq8g+1WiKBWyt8RNM4EF1KJZIG051wnWPIwGn3+lPsPdTO/lX8h/CpE/W1JjpvOUK5Zn2bLmvqz73PHaBlxiys6TpO3tcNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX6b9rI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B5C113CC;
	Mon, 15 Apr 2024 23:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224542;
	bh=vIjsogSzRkMiJxgxVub12DFvG5ZNGZrAj2KJ0f3Qpto=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oX6b9rI7A+KhqfowpS3pAvLWScKQI3MNJhgpuLpaMOHiwvKHeR9y1ttY680Yh4Wh6
	 ze7WWjG1UiahIwrGu+VHWSsJQGP3DjIPstf5Nu6kan9uSLtKEK8DafRTC2o1T0ikEy
	 u7+aPwjqDfOcxti2J0rGzEhe3AjUv8CeVjqqCAIIM+6BrqI0vq6WQPS6WBB5c1Glf0
	 09tC9qtNDrOaVXMaZMYFu01CdzXiHB1+NolNBh1HVVIynYgZGAUcsdX94dZCVDrIMb
	 i5hpBPkNth6cU+q/n5nRZyR34sbZkKLsDKNUH6xS2sKnpReb3zg27Lb29a1bd82lvd
	 PhGfRueCMC75g==
Date: Mon, 15 Apr 2024 16:42:22 -0700
Subject: [PATCH 06/15] xfs: bind together the front and back ends of the file
 range exchange code
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322381323.87355.434928131252083087.stgit@frogsfrogsfrogs>
In-Reply-To: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
References: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_exchrange.c |  334 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_trace.c     |    1 
 fs/xfs/xfs_trace.h     |  109 ++++++++++++++++
 3 files changed, 443 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index 35351b973521..0fc95e6471cb 100644
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
 static int
 xfs_exchange_range(
@@ -341,7 +673,7 @@ xfs_exchange_range(
 		fxr->flags |= __XFS_EXCHANGE_RANGE_UPD_CMTIME2;
 
 	file_start_write(fxr->file2);
-	ret = -EOPNOTSUPP; /* XXX call out to lower level code */
+	ret = xfs_exchrange_contents(fxr);
 	file_end_write(fxr->file2);
 	if (ret)
 		return ret;
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index 9f38e69f1ce4..cf92a3bd56c7 100644
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
index 7c17d1f80fec..729e728c2076 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -84,6 +84,7 @@ struct xfs_btree_ops;
 struct xfs_bmap_intent;
 struct xfs_exchmaps_intent;
 struct xfs_exchmaps_req;
+struct xfs_exchrange;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -4785,6 +4786,114 @@ DEFINE_INODE_IREC_EVENT(xfs_exchmaps_mapping1);
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
 TRACE_EVENT(xfs_exchmaps_overhead,
 	TP_PROTO(struct xfs_mount *mp, unsigned long long bmbt_blocks,
 		 unsigned long long rmapbt_blocks),


