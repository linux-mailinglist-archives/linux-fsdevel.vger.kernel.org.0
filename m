Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D00E659ED5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiL3Xwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiL3Xwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:52:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857CA10055;
        Fri, 30 Dec 2022 15:52:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C8F61B98;
        Fri, 30 Dec 2022 23:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68146C433EF;
        Fri, 30 Dec 2022 23:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444349;
        bh=NeqfzQouOBkOBZfwE9K4phTCrJafqp+G6WzpwGGIxVI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=U0bujZLLKi6ScJU9r2kO1NtF7YRCQiacr/XIDyLr5bCtjp+q1DVMtGj4kV57yIAE7
         dXVJo6kNvP1plnKxA8q5ByoRwgFA5vyzTRFnjujgnYTPt31DCaVrW3+MhMqr9V1TGa
         Ido+8ByA+BBLA0x0SZtU6W4Q/QrsIUi0sLLMV9jkV6G0qYCb2MotAC/Ko1XoZBdm1F
         lVycU1HeCn3ejyn3urDedPUiCnWI8auUAAjcqKv1i8NeFVH3nFZeS/9NfUnx0DZXcP
         HUuVXjwAxsH1jWZh12ah8jE32iF5rW4R/+SOweRHwSbGV7StacR26LcpIbdN+Nm+KJ
         B6WEwz/RrhQrA==
Subject: [PATCH 09/21] xfs: add a ->xchg_file_range handler
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:56 -0800
Message-ID: <167243843654.699466.3274644860168881046.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a function to handle file range exchange requests from the vfs.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |    1 
 fs/xfs/xfs_file.c      |   70 +++++++++
 fs/xfs/xfs_mount.h     |    5 +
 fs/xfs/xfs_trace.c     |    1 
 fs/xfs/xfs_trace.h     |  120 +++++++++++++++
 fs/xfs/xfs_xchgrange.c |  375 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_xchgrange.h |   23 +++
 7 files changed, 594 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 8621534b749b..d587015aec0e 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -28,6 +28,7 @@
 #include "xfs_icache.h"
 #include "xfs_iomap.h"
 #include "xfs_reflink.h"
+#include "xfs_swapext.h"
 
 /* Kernel only BMAP related definitions and functions */
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 78323574021c..b4629c8aa6b7 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -24,6 +24,7 @@
 #include "xfs_pnfs.h"
 #include "xfs_iomap.h"
 #include "xfs_reflink.h"
+#include "xfs_xchgrange.h"
 
 #include <linux/dax.h>
 #include <linux/falloc.h>
@@ -1150,6 +1151,74 @@ xfs_file_remap_range(
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
+			!(fxr->flags & FILE_XCHG_RANGE_NONATOMIC),
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
+	error = generic_xchg_file_range_finish(file1, file2);
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
 STATIC int
 xfs_file_open(
 	struct inode	*inode,
@@ -1439,6 +1508,7 @@ const struct file_operations xfs_file_operations = {
 	.fallocate	= xfs_file_fallocate,
 	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
+	.xchg_file_range = xfs_file_xchg_range,
 };
 
 const struct file_operations xfs_dir_file_operations = {
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 7c48a2b70f6f..3b2601ab954d 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -399,6 +399,8 @@ __XFS_HAS_FEAT(nouuid, NOUUID)
 #define XFS_OPSTATE_WARNED_SHRINK	8
 /* Kernel has logged a warning about logged xattr updates being used. */
 #define XFS_OPSTATE_WARNED_LARP		9
+/* Kernel has logged a warning about extent swapping being used on this fs. */
+#define XFS_OPSTATE_WARNED_SWAPEXT	10
 
 #define __XFS_IS_OPSTATE(name, NAME) \
 static inline bool xfs_is_ ## name (struct xfs_mount *mp) \
@@ -438,7 +440,8 @@ xfs_should_warn(struct xfs_mount *mp, long nr)
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
index 9ebaa5ffe504..6841f04ee38d 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3763,10 +3763,130 @@ DEFINE_INODE_IREC_EVENT(xfs_reflink_cancel_cow);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap_piece);
 DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_rmap_error);
+
+/* swapext tracepoints */
+DEFINE_INODE_ERROR_EVENT(xfs_file_xchg_range_error);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent2);
 DEFINE_ITRUNC_EVENT(xfs_swapext_update_inode_size);
 
+#define FIEXCHANGE_FLAGS_STRS \
+	{ FILE_XCHG_RANGE_NONATOMIC,		"NONATOMIC" }, \
+	{ FILE_XCHG_RANGE_FILE2_FRESH,		"F2_FRESH" }, \
+	{ FILE_XCHG_RANGE_FULL_FILES,		"FULL" }, \
+	{ FILE_XCHG_RANGE_TO_EOF,		"TO_EOF" }, \
+	{ FILE_XCHG_RANGE_FSYNC	,		"FSYNC" }, \
+	{ FILE_XCHG_RANGE_DRY_RUN,		"DRY_RUN" }, \
+	{ FILE_XCHG_RANGE_SKIP_FILE1_HOLES,	"SKIP_F1_HOLES" }
+
+/* file exchange-range tracepoint class */
+DECLARE_EVENT_CLASS(xfs_xchg_range_class,
+	TP_PROTO(struct xfs_inode *ip1, const struct file_xchg_range *fxr,
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
+		   __print_flags(__entry->vflags, "|", FIEXCHANGE_FLAGS_STRS),
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
+	TP_PROTO(struct xfs_inode *ip1, const struct file_xchg_range *fxr, \
+		 struct xfs_inode *ip2, unsigned int xchg_flags), \
+	TP_ARGS(ip1, fxr, ip2, xchg_flags))
+DEFINE_XCHG_RANGE_EVENT(xfs_xchg_range_prep);
+DEFINE_XCHG_RANGE_EVENT(xfs_xchg_range_flush);
+DEFINE_XCHG_RANGE_EVENT(xfs_xchg_range);
+
+TRACE_EVENT(xfs_xchg_range_freshness,
+	TP_PROTO(struct xfs_inode *ip2, const struct file_xchg_range *fxr),
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
index 0dba5078c9f7..9966938134c0 100644
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
@@ -63,3 +70,371 @@ xfs_xchg_range_estimate(
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
+	if (!(fxr->flags & FILE_XCHG_RANGE_FULL_FILES) &&
+	    !is_power_of_2(xfs_inode_alloc_unitsize(ip2)))
+		return -EOPNOTSUPP;
+
+	error = generic_xchg_file_range_prep(file1, file2, fxr,
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
+	const struct file_xchg_range	*fxr,
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
+	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF)
+		req.req_flags |= XFS_SWAP_REQ_SET_SIZES;
+	if (fxr->flags & FILE_XCHG_RANGE_SKIP_FILE1_HOLES)
+		req.req_flags |= XFS_SWAP_REQ_SKIP_INO1_HOLES;
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
+	if (fxr->flags & FILE_XCHG_RANGE_FILE2_FRESH)
+		trace_xfs_xchg_range_freshness(ip2, fxr);
+
+	/*
+	 * Now that we've excluded all other inode metadata changes by taking
+	 * the ILOCK, repeat the freshness check.
+	 */
+	error = generic_xchg_file_range_check_fresh(VFS_I(ip2), fxr);
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
+	if (fxr->flags & FILE_XCHG_RANGE_DRY_RUN)
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
+	if (xfs_has_wsync(mp) || (fxr->flags & FILE_XCHG_RANGE_FSYNC))
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
+	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF) {
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
index 89320a354efa..a0e64408784a 100644
--- a/fs/xfs/xfs_xchgrange.h
+++ b/fs/xfs/xfs_xchgrange.h
@@ -14,4 +14,27 @@ void xfs_xchg_range_iunlock(struct xfs_inode *ip1, struct xfs_inode *ip2);
 
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
+		const struct file_xchg_range *fxr, unsigned int xchg_flags);
+int xfs_xchg_range_prep(struct file *file1, struct file *file2,
+		struct file_xchg_range *fxr);
+
 #endif /* __XFS_XCHGRANGE_H__ */

