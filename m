Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF28711C68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbjEZBR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjEZBR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585F7D8;
        Thu, 25 May 2023 18:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D11DE64C28;
        Fri, 26 May 2023 01:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2DCC433EF;
        Fri, 26 May 2023 01:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063872;
        bh=oa4w1cywOGvVNNzDCWCZ9txhxk50suaJVfrsfJ9v9+o=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=dBl1emSagkk+I3h71o9PlP51/QhkUhmSNoAFP8dch9QvMDxrdjJp+mOFlfFWisKxj
         xgxeKiH6k8xzYNlRH1WRPZtmuyXXEIBcGjqc6xySQqqAQh5Zk/nQ4+2snL7dsKEzkm
         EatFpCbxzYmc9Gm7oK45g+X91K6Zg0rL9OKXs+KThiBb3UyhMHvWqXZ0ecZSZu5Qq/
         1k03iKoX5vq/9SlTbU11Be+gNHLxtQm6zgxNUx5pZUjO90TK6qcntiyt35BDn8wAkm
         ml0/+oWpxu2Xl1YWfZTqcEz4E+l70sbAV/yGGh6+fFz+e55yPCpyuC+VOV1QEEKKU/
         KJP8oS6fs8XJw==
Date:   Thu, 25 May 2023 18:17:51 -0700
Subject: [PATCH 13/25] xfs: bind the xfs-specific extent swape code to the
 vfs-generic file exchange code
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065168.3734442.6599280372308460658.stgit@frogsfrogsfrogs>
In-Reply-To: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
References: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

So far we've constructed the top half of file range exchange which
deals with VFS-level objects; and the bottom half of extent swapping,
which deals with file mappings in XFS data structures.  We still need to
glue the two pieces together so do that now.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |    1 
 fs/xfs/xfs_mount.h     |    5 -
 fs/xfs/xfs_trace.c     |    1 
 fs/xfs/xfs_trace.h     |  120 +++++++++++++
 fs/xfs/xfs_xchgrange.c |  449 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_xchgrange.h |   28 +++
 6 files changed, 602 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 4790f35341e0..2ef726036ce3 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -28,6 +28,7 @@
 #include "xfs_icache.h"
 #include "xfs_iomap.h"
 #include "xfs_reflink.h"
+#include "xfs_swapext.h"
 
 /* Kernel only BMAP related definitions and functions */
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index f007f19d16d7..4e29ebf767a0 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -401,6 +401,8 @@ __XFS_HAS_FEAT(nouuid, NOUUID)
 #define XFS_OPSTATE_WARNED_SHRINK	8
 /* Kernel has logged a warning about logged xattr updates being used. */
 #define XFS_OPSTATE_WARNED_LARP		9
+/* Kernel has logged a warning about extent swapping being used on this fs. */
+#define XFS_OPSTATE_WARNED_SWAPEXT	10
 
 #define __XFS_IS_OPSTATE(name, NAME) \
 static inline bool xfs_is_ ## name (struct xfs_mount *mp) \
@@ -440,7 +442,8 @@ xfs_should_warn(struct xfs_mount *mp, long nr)
 	{ (1UL << XFS_OPSTATE_BLOCKGC_ENABLED),		"blockgc" }, \
 	{ (1UL << XFS_OPSTATE_WARNED_SCRUB),		"wscrub" }, \
 	{ (1UL << XFS_OPSTATE_WARNED_SHRINK),		"wshrink" }, \
-	{ (1UL << XFS_OPSTATE_WARNED_LARP),		"wlarp" }
+	{ (1UL << XFS_OPSTATE_WARNED_LARP),		"wlarp" }, \
+	{ (1UL << XFS_OPSTATE_WARNED_SWAPEXT),		"wswapext" }
 
 /*
  * Max and min values for mount-option defined I/O
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index b43b973f0e10..e38814f4380c 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -41,6 +41,7 @@
 #include "xfs_btree_mem.h"
 #include "xfs_bmap.h"
 #include "xfs_swapext.h"
+#include "xfs_xchgrange.h"
 
 /*
  * We include this last to have the helpers above available for the trace
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 8e9cb02ca5be..c7c3227494b0 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3771,11 +3771,131 @@ DEFINE_INODE_IREC_EVENT(xfs_reflink_cancel_cow);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap_piece);
 DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_rmap_error);
+
+/* swapext tracepoints */
+DEFINE_INODE_ERROR_EVENT(xfs_file_xchg_range_error);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1_skip);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent2);
 DEFINE_ITRUNC_EVENT(xfs_swapext_update_inode_size);
 
+#define XFS_EXCH_RANGE_FLAGS_STRS \
+	{ XFS_EXCH_RANGE_NONATOMIC,	"NONATOMIC" }, \
+	{ XFS_EXCH_RANGE_FILE2_FRESH,	"F2_FRESH" }, \
+	{ XFS_EXCH_RANGE_FULL_FILES,	"FULL" }, \
+	{ XFS_EXCH_RANGE_TO_EOF,	"TO_EOF" }, \
+	{ XFS_EXCH_RANGE_FSYNC	,	"FSYNC" }, \
+	{ XFS_EXCH_RANGE_DRY_RUN,	"DRY_RUN" }, \
+	{ XFS_EXCH_RANGE_FILE1_WRITTEN,	"F1_WRITTEN" }
+
+/* file exchange-range tracepoint class */
+DECLARE_EVENT_CLASS(xfs_xchg_range_class,
+	TP_PROTO(struct xfs_inode *ip1, const struct xfs_exch_range *fxr,
+		 struct xfs_inode *ip2, unsigned int xchg_flags),
+	TP_ARGS(ip1, fxr, ip2, xchg_flags),
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
+		__field(unsigned long long, vflags)
+		__field(unsigned int, xflags)
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
+		__entry->vflags = fxr->flags;
+		__entry->xflags = xchg_flags;
+	),
+	TP_printk("dev %d:%d vfs_flags %s xchg_flags %s bytecount 0x%llx "
+		  "ino1 0x%llx isize 0x%llx disize 0x%llx pos 0x%llx -> "
+		  "ino2 0x%llx isize 0x%llx disize 0x%llx pos 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		   __print_flags(__entry->vflags, "|", XFS_EXCH_RANGE_FLAGS_STRS),
+		   __print_flags(__entry->xflags, "|", XCHG_RANGE_FLAGS_STRS),
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
+#define DEFINE_XCHG_RANGE_EVENT(name)	\
+DEFINE_EVENT(xfs_xchg_range_class, name,	\
+	TP_PROTO(struct xfs_inode *ip1, const struct xfs_exch_range *fxr, \
+		 struct xfs_inode *ip2, unsigned int xchg_flags), \
+	TP_ARGS(ip1, fxr, ip2, xchg_flags))
+DEFINE_XCHG_RANGE_EVENT(xfs_xchg_range_prep);
+DEFINE_XCHG_RANGE_EVENT(xfs_xchg_range_flush);
+DEFINE_XCHG_RANGE_EVENT(xfs_xchg_range);
+
+TRACE_EVENT(xfs_xchg_range_freshness,
+	TP_PROTO(struct xfs_inode *ip2, const struct xfs_exch_range *fxr),
+	TP_ARGS(ip2, fxr),
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
+		__entry->dev = VFS_I(ip2)->i_sb->s_dev;
+		__entry->ip2_ino = ip2->i_ino;
+		__entry->ip2_mtime = VFS_I(ip2)->i_mtime.tv_sec;
+		__entry->ip2_ctime = VFS_I(ip2)->i_ctime.tv_sec;
+		__entry->ip2_mtime_nsec = VFS_I(ip2)->i_mtime.tv_nsec;
+		__entry->ip2_ctime_nsec = VFS_I(ip2)->i_ctime.tv_nsec;
+
+		__entry->file2_ino = fxr->file2_ino;
+		__entry->file2_mtime = fxr->file2_mtime;
+		__entry->file2_ctime = fxr->file2_ctime;
+		__entry->file2_mtime_nsec = fxr->file2_mtime_nsec;
+		__entry->file2_ctime_nsec = fxr->file2_ctime_nsec;
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
 /* fsmap traces */
 DECLARE_EVENT_CLASS(xfs_fsmap_class,
 	TP_PROTO(struct xfs_mount *mp, u32 keydev, xfs_agnumber_t agno,
diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
index 965f8bfc3f59..c9075e72ab51 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -12,8 +12,15 @@
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
 #include <linux/fsnotify.h>
 
 /*
@@ -317,7 +324,7 @@ __xfs_exch_range(
 	if (ret)
 		return ret;
 
-	ret = -EOPNOTSUPP; /* XXX call out to xfs code */
+	ret = xfs_file_xchg_range(file1, file2, fxr);
 	if (ret)
 		return ret;
 
@@ -344,6 +351,78 @@ xfs_exch_range(
 
 /* XFS-specific parts of XFS_IOC_EXCHANGE_RANGE */
 
+/*
+ * Exchanging ranges as a file operation.  This is the binding between the
+ * VFS-level concepts and the XFS-specific implementation.
+ */
+int
+xfs_file_xchg_range(
+	struct file		*file1,
+	struct file		*file2,
+	struct xfs_exch_range	*fxr)
+{
+	struct inode		*inode1 = file_inode(file1);
+	struct inode		*inode2 = file_inode(file2);
+	struct xfs_inode	*ip1 = XFS_I(inode1);
+	struct xfs_inode	*ip2 = XFS_I(inode2);
+	struct xfs_mount	*mp = ip1->i_mount;
+	unsigned int		priv_flags = 0;
+	bool			use_logging = false;
+	int			error;
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	/* Update cmtime if the fd/inode don't forbid it. */
+	if (likely(!(file1->f_mode & FMODE_NOCMTIME) && !IS_NOCMTIME(inode1)))
+		priv_flags |= XFS_XCHG_RANGE_UPD_CMTIME1;
+	if (likely(!(file2->f_mode & FMODE_NOCMTIME) && !IS_NOCMTIME(inode2)))
+		priv_flags |= XFS_XCHG_RANGE_UPD_CMTIME2;
+
+	/* Lock both files against IO */
+	error = xfs_ilock2_io_mmap(ip1, ip2);
+	if (error)
+		goto out_err;
+
+	/* Prepare and then exchange file contents. */
+	error = xfs_xchg_range_prep(file1, file2, fxr);
+	if (error)
+		goto out_unlock;
+
+	/* Get permission to use log-assisted file content swaps. */
+	error = xfs_xchg_range_grab_log_assist(mp,
+			!(fxr->flags & XFS_EXCH_RANGE_NONATOMIC),
+			&use_logging);
+	if (error)
+		goto out_unlock;
+	if (use_logging)
+		priv_flags |= XFS_XCHG_RANGE_LOGGED;
+
+	error = xfs_xchg_range(ip1, ip2, fxr, priv_flags);
+	if (error)
+		goto out_drop_feat;
+
+	/*
+	 * Finish the exchange by removing special file privileges like any
+	 * other file write would do.  This may involve turning on support for
+	 * logged xattrs if either file has security capabilities, which means
+	 * xfs_xchg_range_grab_log_assist before xfs_attr_grab_log_assist.
+	 */
+	error = xfs_exch_range_finish(file1, file2);
+	if (error)
+		goto out_drop_feat;
+
+out_drop_feat:
+	if (use_logging)
+		xfs_xchg_range_rele_log_assist(mp);
+out_unlock:
+	xfs_iunlock2_io_mmap(ip1, ip2);
+out_err:
+	if (error)
+		trace_xfs_file_xchg_range_error(ip2, error, _RET_IP_);
+	return error;
+}
+
 /* Lock (and optionally join) two inodes for a file range exchange. */
 void
 xfs_xchg_range_ilock(
@@ -391,3 +470,371 @@ xfs_xchg_range_estimate(
 	xfs_xchg_range_iunlock(req->ip1, req->ip2);
 	return error;
 }
+
+/* Prepare two files to have their data exchanged. */
+int
+xfs_xchg_range_prep(
+	struct file		*file1,
+	struct file		*file2,
+	struct xfs_exch_range	*fxr)
+{
+	struct xfs_inode	*ip1 = XFS_I(file_inode(file1));
+	struct xfs_inode	*ip2 = XFS_I(file_inode(file2));
+	int			error;
+
+	trace_xfs_xchg_range_prep(ip1, fxr, ip2, 0);
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
+	if (!(fxr->flags & XFS_EXCH_RANGE_FULL_FILES) &&
+	    !is_power_of_2(xfs_inode_alloc_unitsize(ip2)))
+		return -EOPNOTSUPP;
+
+	error = xfs_exch_range_prep(file1, file2, fxr,
+			xfs_inode_alloc_unitsize(ip2));
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
+	trace_xfs_xchg_range_flush(ip1, fxr, ip2, 0);
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
+	return 0;
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
+/*
+ * Get permission to use log-assisted atomic exchange of file extents.
+ *
+ * Callers must hold the IOLOCK and MMAPLOCK of both files.  They must not be
+ * running any transactions or hold any ILOCKS.  If @use_logging is set after a
+ * successful return, callers must call xfs_xchg_range_rele_log_assist after
+ * the exchange is completed.
+ */
+int
+xfs_xchg_range_grab_log_assist(
+	struct xfs_mount	*mp,
+	bool			force,
+	bool			*use_logging)
+{
+	int			error = 0;
+
+	/*
+	 * Protect ourselves from an idle log clearing the atomic swapext
+	 * log incompat feature bit.
+	 */
+	xlog_use_incompat_feat(mp->m_log, XLOG_INCOMPAT_FEAT_SWAPEXT);
+	*use_logging = true;
+
+	/*
+	 * If log-assisted swapping is already enabled, the caller can use the
+	 * log assisted swap functions with the log-incompat reference we got.
+	 */
+	if (xfs_sb_version_haslogswapext(&mp->m_sb))
+		return 0;
+
+	/*
+	 * If the caller doesn't /require/ log-assisted swapping, drop the
+	 * log-incompat feature protection and exit.  The caller cannot use
+	 * log assisted swapping.
+	 */
+	if (!force)
+		goto drop_incompat;
+
+	/*
+	 * Caller requires log-assisted swapping but the fs feature set isn't
+	 * rich enough to support it.  Bail out.
+	 */
+	if (!xfs_swapext_supported(mp)) {
+		error = -EOPNOTSUPP;
+		goto drop_incompat;
+	}
+
+	error = xfs_add_incompat_log_feature(mp,
+			XFS_SB_FEAT_INCOMPAT_LOG_SWAPEXT);
+	if (error)
+		goto drop_incompat;
+
+	xfs_warn_mount(mp, XFS_OPSTATE_WARNED_SWAPEXT,
+ "EXPERIMENTAL atomic file range swap feature in use. Use at your own risk!");
+
+	return 0;
+drop_incompat:
+	xlog_drop_incompat_feat(mp->m_log, XLOG_INCOMPAT_FEAT_SWAPEXT);
+	*use_logging = false;
+	return error;
+}
+
+/* Release permission to use log-assisted extent swapping. */
+void
+xfs_xchg_range_rele_log_assist(
+	struct xfs_mount	*mp)
+{
+	xlog_drop_incompat_feat(mp->m_log, XLOG_INCOMPAT_FEAT_SWAPEXT);
+}
+
+/* Exchange the contents of two files. */
+int
+xfs_xchg_range(
+	struct xfs_inode		*ip1,
+	struct xfs_inode		*ip2,
+	const struct xfs_exch_range	*fxr,
+	unsigned int			xchg_flags)
+{
+	struct xfs_mount		*mp = ip1->i_mount;
+	struct xfs_swapext_req		req = {
+		.ip1			= ip1,
+		.ip2			= ip2,
+		.whichfork		= XFS_DATA_FORK,
+		.startoff1		= XFS_B_TO_FSBT(mp, fxr->file1_offset),
+		.startoff2		= XFS_B_TO_FSBT(mp, fxr->file2_offset),
+		.blockcount		= XFS_B_TO_FSB(mp, fxr->length),
+	};
+	struct xfs_trans		*tp;
+	unsigned int			qretry;
+	bool				retried = false;
+	int				error;
+
+	trace_xfs_xchg_range(ip1, fxr, ip2, xchg_flags);
+
+	/*
+	 * This function only supports using log intent items (SXI items if
+	 * atomic exchange is required, or BUI items if not) to exchange file
+	 * data.  The legacy whole-fork swap will be ported in a later patch.
+	 */
+	if (!(xchg_flags & XFS_XCHG_RANGE_LOGGED) && !xfs_swapext_supported(mp))
+		return -EOPNOTSUPP;
+
+	if (fxr->flags & XFS_EXCH_RANGE_TO_EOF)
+		req.req_flags |= XFS_SWAP_REQ_SET_SIZES;
+	if (fxr->flags & XFS_EXCH_RANGE_FILE1_WRITTEN)
+		req.req_flags |= XFS_SWAP_REQ_INO1_WRITTEN;
+	if (xchg_flags & XFS_XCHG_RANGE_LOGGED)
+		req.req_flags |= XFS_SWAP_REQ_LOGGED;
+
+	error = xfs_xchg_range_estimate(&req);
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
+	xfs_xchg_range_ilock(tp, ip1, ip2);
+
+	trace_xfs_swap_extent_before(ip2, 0);
+	trace_xfs_swap_extent_before(ip1, 1);
+
+	if (fxr->flags & XFS_EXCH_RANGE_FILE2_FRESH)
+		trace_xfs_xchg_range_freshness(ip2, fxr);
+
+	/*
+	 * Now that we've excluded all other inode metadata changes by taking
+	 * the ILOCK, repeat the freshness check.
+	 */
+	error = xfs_exch_range_check_fresh(VFS_I(ip2), fxr);
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
+	error = xfs_xchg_range_reserve_quota(tp, &req, &qretry);
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
+	if (fxr->flags & XFS_EXCH_RANGE_DRY_RUN)
+		goto out_trans_cancel;
+
+	/* Update the mtime and ctime of both files. */
+	if (xchg_flags & XFS_XCHG_RANGE_UPD_CMTIME1)
+		xfs_trans_ichgtime(tp, ip1,
+				XFS_ICHGTIME_MOD | XFS_ICHGTIME_CHG);
+	if (xchg_flags & XFS_XCHG_RANGE_UPD_CMTIME2)
+		xfs_trans_ichgtime(tp, ip2,
+				XFS_ICHGTIME_MOD | XFS_ICHGTIME_CHG);
+
+	xfs_swapext(tp, &req);
+
+	/*
+	 * Force the log to persist metadata updates if the caller or the
+	 * administrator requires this.  The VFS prep function already flushed
+	 * the relevant parts of the page cache.
+	 */
+	if (xfs_has_wsync(mp) || (fxr->flags & XFS_EXCH_RANGE_FSYNC))
+		xfs_trans_set_sync(tp);
+
+	error = xfs_trans_commit(tp);
+
+	trace_xfs_swap_extent_after(ip2, 0);
+	trace_xfs_swap_extent_after(ip1, 1);
+
+	if (error)
+		goto out_unlock;
+
+	/*
+	 * If the caller wanted us to exchange the contents of two complete
+	 * files of unequal length, exchange the incore sizes now.  This should
+	 * be safe because we flushed both files' page caches, moved all the
+	 * extents, and updated the ondisk sizes.
+	 */
+	if (fxr->flags & XFS_EXCH_RANGE_TO_EOF) {
+		loff_t	temp;
+
+		temp = i_size_read(VFS_I(ip2));
+		i_size_write(VFS_I(ip2), i_size_read(VFS_I(ip1)));
+		i_size_write(VFS_I(ip1), temp);
+	}
+
+out_unlock:
+	xfs_xchg_range_iunlock(ip1, ip2);
+	return error;
+
+out_trans_cancel:
+	xfs_trans_cancel(tp);
+	goto out_unlock;
+}
diff --git a/fs/xfs/xfs_xchgrange.h b/fs/xfs/xfs_xchgrange.h
index 3870e78f4807..1f79f16e4a95 100644
--- a/fs/xfs/xfs_xchgrange.h
+++ b/fs/xfs/xfs_xchgrange.h
@@ -15,6 +15,11 @@ int xfs_exch_range_finish(struct file *file1, struct file *file2);
 int xfs_exch_range(struct file *file1, struct file *file2,
 		struct xfs_exch_range *fxr);
 
+/* Binding between the generic VFS and the XFS-specific file exchange */
+
+int xfs_file_xchg_range(struct file *file1, struct file *file2,
+		struct xfs_exch_range *fxr);
+
 /* XFS-specific parts of file exchanges */
 
 struct xfs_swapext_req;
@@ -25,4 +30,27 @@ void xfs_xchg_range_iunlock(struct xfs_inode *ip1, struct xfs_inode *ip2);
 
 int xfs_xchg_range_estimate(struct xfs_swapext_req *req);
 
+int xfs_xchg_range_grab_log_assist(struct xfs_mount *mp, bool force,
+		bool *use_logging);
+void xfs_xchg_range_rele_log_assist(struct xfs_mount *mp);
+
+/* Caller has permission to use log intent items for the exchange operation. */
+#define XFS_XCHG_RANGE_LOGGED		(1U << 0)
+
+/* Update ip1's change and mod time. */
+#define XFS_XCHG_RANGE_UPD_CMTIME1	(1U << 1)
+
+/* Update ip2's change and mod time. */
+#define XFS_XCHG_RANGE_UPD_CMTIME2	(1U << 2)
+
+#define XCHG_RANGE_FLAGS_STRS \
+	{ XFS_XCHG_RANGE_LOGGED,		"LOGGED" }, \
+	{ XFS_XCHG_RANGE_UPD_CMTIME1,		"UPD_CMTIME1" }, \
+	{ XFS_XCHG_RANGE_UPD_CMTIME2,		"UPD_CMTIME2" }
+
+int xfs_xchg_range(struct xfs_inode *ip1, struct xfs_inode *ip2,
+		const struct xfs_exch_range *fxr, unsigned int xchg_flags);
+int xfs_xchg_range_prep(struct file *file1, struct file *file2,
+		struct xfs_exch_range *fxr);
+
 #endif /* __XFS_XCHGRANGE_H__ */

