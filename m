Return-Path: <linux-fsdevel+bounces-67041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FBBC338EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EF94654D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DF623D7F3;
	Wed,  5 Nov 2025 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3Jfbq3x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DF23BF9B;
	Wed,  5 Nov 2025 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303987; cv=none; b=Se82+QhAxLvAta4XXD0GXjiIo7dg9v4EufSVo9oIM2qIoK+CwQ+Nx8pv4C+KofUWDU04e2A9o3AU/wk8maP8XuUPeMzakVt97k7PYBZw2SrFYIEo/jUkfyUyp5DYMs6dd4nefJIIb91kasS6Owwo3Rqo/wDOZkoKwvEXwFFxCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303987; c=relaxed/simple;
	bh=CBb/Sb8OnTT4tKvBqN3jAhNMqmHKn746t5nlOzxsCz0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMLo391Uqxhm6fgbHiAIY1fFluXnzDjhItbELzxRGfS+m7DCeeS+3M+lT4nKYS759bVmtnH5t176YjCLBOFah2eLjXZ4cShKU+br49On5ABilIe2/ytS+D08cU2A0RNjtlyr3vYlQDcm8oWMM1Vl/+CyRwj/4oesjmcX3mmsNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3Jfbq3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51548C4CEF7;
	Wed,  5 Nov 2025 00:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303987;
	bh=CBb/Sb8OnTT4tKvBqN3jAhNMqmHKn746t5nlOzxsCz0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=m3Jfbq3xXdHTdOL7oI9fwBU8/HEdVVmYA1OyXKJt98ISxGeZOqYoLscJHP1ncX39R
	 4hJtwwScNgyKhz7xZnv9U9eOMkjYj7VJcMX1E2vWAaqqdkOfonTtwlGYOxnUW2FTS5
	 wy7+TjD020tEE4sbxW2G6c+c9IG4OMvSolOBE+rbtW6XOyohQPVh5mDDdOyzcSI+U2
	 sYov34d9wcEUBKyhcE8LcjrBGdfFa9ftqbtioTw/CljwV8JTa+PxpagvgZ5vARErGl
	 ooxhkcMqwWtEQeh+kpGmGuEWDVxGZ1PzHaBkb+OXxOCq6hlnYnuS/IL6jYMz13JeFl
	 pdB89F4DhRcLg==
Date: Tue, 04 Nov 2025 16:53:06 -0800
Subject: [PATCH 18/22] xfs: add media error reporting ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230366083.1647136.17815957428625707316.stgit@frogsfrogsfrogs>
In-Reply-To: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a new privileged ioctl so that xfs_scrub can report media errors to
the kernel for further processing.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h      |   16 ++++
 fs/xfs/xfs_notify_failure.h |    8 ++
 fs/xfs/xfs_trace.h          |    2 
 fs/xfs/Makefile             |    6 -
 fs/xfs/xfs_healthmon.c      |    2 
 fs/xfs/xfs_ioctl.c          |    3 +
 fs/xfs/xfs_notify_failure.c |  187 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 213 insertions(+), 11 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 2b82535196cdb0..65fcc94ed9b40c 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1156,6 +1156,21 @@ struct xfs_health_samefs {
 	__u32		flags;	/* zero for now */
 };
 
+/* Report a media error */
+struct xfs_media_error {
+	__u64	flags;		/* flags */
+	__u64	daddr;		/* disk address of range */
+	__u64	bbcount;	/* length, in 512b blocks */
+	__u64	pad;		/* zero */
+};
+
+#define XFS_MEDIA_ERROR_DATADEV	(1)	/* data device */
+#define XFS_MEDIA_ERROR_LOGDEV	(2)	/* external log device */
+#define XFS_MEDIA_ERROR_RTDEV	(3)	/* realtime device */
+
+/* bottom byte of flags is the device code */
+#define XFS_MEDIA_ERROR_DEVMASK	(0xFF)
+
 /*
  * ioctl commands that are used by Linux filesystems
  */
@@ -1197,6 +1212,7 @@ struct xfs_health_samefs {
 #define XFS_IOC_RTGROUP_GEOMETRY _IOWR('X', 65, struct xfs_rtgroup_geometry)
 #define XFS_IOC_HEALTH_MONITOR	_IOW ('X', 68, struct xfs_health_monitor)
 #define XFS_IOC_HEALTH_SAMEFS	_IOW ('X', 69, struct xfs_health_samefs)
+#define XFS_IOC_MEDIA_ERROR	_IOW ('X', 70, struct xfs_media_error)
 
 /*
  * ioctl commands that replace IRIX syssgi()'s
diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
index 2695732ec20875..279f9329a4d5f3 100644
--- a/fs/xfs/xfs_notify_failure.h
+++ b/fs/xfs/xfs_notify_failure.h
@@ -6,7 +6,9 @@
 #ifndef __XFS_NOTIFY_FAILURE_H__
 #define __XFS_NOTIFY_FAILURE_H__
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
 extern const struct dax_holder_operations xfs_dax_holder_operations;
+#endif
 
 enum xfs_failed_device {
 	XFS_FAILED_DATADEV,
@@ -14,7 +16,7 @@ enum xfs_failed_device {
 	XFS_FAILED_RTDEV,
 };
 
-#if defined(CONFIG_XFS_LIVE_HOOKS) && defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
+#if defined(CONFIG_XFS_LIVE_HOOKS)
 struct xfs_media_error_params {
 	struct xfs_mount		*mp;
 	enum xfs_failed_device		fdev;
@@ -41,4 +43,8 @@ struct xfs_media_error_hook { };
 # define xfs_media_error_hook_setup(...)	((void)0)
 #endif /* CONFIG_XFS_LIVE_HOOKS */
 
+struct xfs_media_error;
+int xfs_ioc_media_error(struct xfs_mount *mp,
+		struct xfs_media_error __user *arg);
+
 #endif /* __XFS_NOTIFY_FAILURE_H__ */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index d1836583d4dfbb..e5d95add53d347 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6213,7 +6213,6 @@ TRACE_EVENT(xfs_healthmon_metadata_hook,
 		  __entry->lost_prev)
 );
 
-#if defined(CONFIG_XFS_LIVE_HOOKS) && defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
 TRACE_EVENT(xfs_healthmon_media_error_hook,
 	TP_PROTO(const struct xfs_media_error_params *p,
 		 unsigned int events, unsigned long long lost_prev),
@@ -6261,7 +6260,6 @@ TRACE_EVENT(xfs_healthmon_media_error_hook,
 		  __entry->events,
 		  __entry->lost_prev)
 );
-#endif
 
 #define XFS_FILE_IOERROR_STRINGS \
 	{ XFS_FILE_IOERROR_BUFFERED_READ,	"readahead" }, \
diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index d4e9070a9326ba..2279cb0b874814 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -98,6 +98,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_message.o \
 				   xfs_mount.o \
 				   xfs_mru_cache.o \
+				   xfs_notify_failure.o \
 				   xfs_pwork.o \
 				   xfs_reflink.o \
 				   xfs_stats.o \
@@ -148,11 +149,6 @@ xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
 xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
 xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
 
-# notify failure
-ifeq ($(CONFIG_MEMORY_FAILURE),y)
-xfs-$(CONFIG_FS_DAX)		+= xfs_notify_failure.o
-endif
-
 xfs-$(CONFIG_XFS_DRAIN_INTENTS)	+= xfs_drain.o
 xfs-$(CONFIG_XFS_LIVE_HOOKS)	+= xfs_hooks.o
 xfs-$(CONFIG_XFS_MEMORY_BUFS)	+= xfs_buf_mem.o
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 9752b058978995..e5715f52f4b218 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -523,7 +523,6 @@ xfs_healthmon_shutdown_hook(
 	return NOTIFY_DONE;
 }
 
-#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
 /* Add a media error event to the reporting queue. */
 STATIC int
 xfs_healthmon_media_error_hook(
@@ -574,7 +573,6 @@ xfs_healthmon_media_error_hook(
 	mutex_unlock(&hm->lock);
 	return NOTIFY_DONE;
 }
-#endif
 
 /* Add a file io error event to the reporting queue. */
 STATIC int
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 08998d84554f09..7a80a6ad4b2d99 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -42,6 +42,7 @@
 #include "xfs_handle.h"
 #include "xfs_rtgroup.h"
 #include "xfs_healthmon.h"
+#include "xfs_notify_failure.h"
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
@@ -1424,6 +1425,8 @@ xfs_file_ioctl(
 
 	case XFS_IOC_HEALTH_MONITOR:
 		return xfs_ioc_health_monitor(mp, arg);
+	case XFS_IOC_MEDIA_ERROR:
+		return xfs_ioc_media_error(mp, arg);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 8766d83385ddad..bf6e1865d5c3a5 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -76,9 +76,19 @@ xfs_media_error_hook_setup(
 	xfs_hook_setup(&hook->error_hook, mod_fn);
 }
 #else
-# define xfs_media_error_hook(...)		((void)0)
+static inline void
+xfs_media_error_hook(
+	struct xfs_mount		*mp,
+	enum xfs_failed_device		fdev,
+	xfs_daddr_t			daddr,
+	uint64_t			bbcount,
+	bool				pre_remove)
+{
+	/* empty */
+}
 #endif /* CONFIG_XFS_LIVE_HOOKS */
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
 struct xfs_failure_info {
 	xfs_agblock_t		startblock;
 	xfs_extlen_t		blockcount;
@@ -447,3 +457,178 @@ xfs_dax_notify_failure(
 const struct dax_holder_operations xfs_dax_holder_operations = {
 	.notify_failure		= xfs_dax_notify_failure,
 };
+#endif /* CONFIG_MEMORY_FAILURE && CONFIG_FS_DAX */
+
+struct xfs_group_data_lost {
+	xfs_agblock_t		startblock;
+	xfs_extlen_t		blockcount;
+};
+
+static int
+xfs_report_one_data_lost(
+	struct xfs_btree_cur		*cur,
+	const struct xfs_rmap_irec	*rec,
+	void				*data)
+{
+	struct xfs_mount		*mp = cur->bc_mp;
+	struct xfs_inode		*ip;
+	struct xfs_group_data_lost	*lost = data;
+	xfs_fileoff_t			fileoff = rec->rm_offset;
+	xfs_extlen_t			blocks = rec->rm_blockcount;
+	const xfs_agblock_t		lost_end =
+			lost->startblock + lost->blockcount;
+	const xfs_agblock_t		rmap_end =
+			rec->rm_startblock + rec->rm_blockcount;
+	int				error = 0;
+
+	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
+	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK)))
+		return 0;
+
+	error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, 0, 0, &ip);
+	if (error)
+		return 0;
+
+	if (lost->startblock > rec->rm_startblock) {
+		fileoff += lost->startblock - rec->rm_startblock;
+		blocks -= lost->startblock - rec->rm_startblock;
+	}
+	if (rmap_end > lost_end)
+		blocks -= rmap_end - lost_end;
+
+	xfs_inode_media_error(ip, XFS_FSB_TO_B(mp, fileoff),
+			XFS_FSB_TO_B(mp, blocks));
+
+	xfs_irele(ip);
+	return 0;
+}
+
+static int
+xfs_report_data_lost(
+	struct xfs_mount	*mp,
+	enum xfs_group_type	type,
+	xfs_daddr_t		daddr,
+	u64			bblen)
+{
+	struct xfs_group	*xg = NULL;
+	struct xfs_trans	*tp;
+	xfs_fsblock_t		start_bno, end_bno;
+	uint32_t		start_gno, end_gno;
+	int			error;
+
+	if (type == XG_TYPE_RTG) {
+		start_bno = xfs_daddr_to_rtb(mp, daddr);
+		end_bno = xfs_daddr_to_rtb(mp, daddr + bblen - 1);
+	} else {
+		start_bno = XFS_DADDR_TO_FSB(mp, daddr);
+		end_bno = XFS_DADDR_TO_FSB(mp, daddr + bblen - 1);
+	}
+
+	tp = xfs_trans_alloc_empty(mp);
+	start_gno = xfs_fsb_to_gno(mp, start_bno, type);
+	end_gno = xfs_fsb_to_gno(mp, end_bno, type);
+	while ((xg = xfs_group_next_range(mp, xg, start_gno, end_gno, type))) {
+		struct xfs_buf		*agf_bp = NULL;
+		struct xfs_rtgroup	*rtg = NULL;
+		struct xfs_btree_cur	*cur;
+		struct xfs_rmap_irec	ri_low = { };
+		struct xfs_rmap_irec	ri_high;
+		struct xfs_group_data_lost lost;
+
+		if (type == XG_TYPE_AG) {
+			struct xfs_perag	*pag = to_perag(xg);
+
+			error = xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
+			if (error) {
+				xfs_perag_put(pag);
+				break;
+			}
+
+			cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, pag);
+		} else {
+			rtg = to_rtg(xg);
+			xfs_rtgroup_lock(rtg, XFS_RTGLOCK_RMAP);
+			cur = xfs_rtrmapbt_init_cursor(tp, rtg);
+		}
+
+		/*
+		 * Set the rmap range from ri_low to ri_high, which represents
+		 * a [start, end] where we looking for the files or metadata.
+		 */
+		memset(&ri_high, 0xFF, sizeof(ri_high));
+		if (xg->xg_gno == start_gno)
+			ri_low.rm_startblock =
+				xfs_fsb_to_gbno(mp, start_bno, type);
+		if (xg->xg_gno == end_gno)
+			ri_high.rm_startblock =
+				xfs_fsb_to_gbno(mp, end_bno, type);
+
+		lost.startblock = ri_low.rm_startblock;
+		lost.blockcount = min(xg->xg_block_count,
+				      ri_high.rm_startblock + 1) -
+							ri_low.rm_startblock;
+
+		error = xfs_rmap_query_range(cur, &ri_low, &ri_high,
+				xfs_report_one_data_lost, &lost);
+		xfs_btree_del_cursor(cur, error);
+		if (agf_bp)
+			xfs_trans_brelse(tp, agf_bp);
+		if (rtg)
+			xfs_rtgroup_unlock(rtg, XFS_RTGLOCK_RMAP);
+		if (error) {
+			xfs_group_put(xg);
+			break;
+		}
+	}
+
+	xfs_trans_cancel(tp);
+	return 0;
+}
+
+#define XFS_VALID_MEDIA_ERROR_FLAGS	(XFS_MEDIA_ERROR_DATADEV | \
+					 XFS_MEDIA_ERROR_LOGDEV | \
+					 XFS_MEDIA_ERROR_RTDEV)
+int
+xfs_ioc_media_error(
+	struct xfs_mount		*mp,
+	struct xfs_media_error __user	*arg)
+{
+	struct xfs_media_error		me;
+	enum xfs_failed_device		fdev;
+	enum xfs_group_type		type;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&me, arg, sizeof(me)))
+		return -EFAULT;
+
+	if (me.pad)
+		return -EINVAL;
+	if (me.flags & ~XFS_VALID_MEDIA_ERROR_FLAGS)
+		return -EINVAL;
+
+	switch (me.flags & XFS_MEDIA_ERROR_DEVMASK) {
+	case XFS_MEDIA_ERROR_DATADEV:
+		fdev = XFS_FAILED_DATADEV;
+		type = XG_TYPE_AG;
+		break;
+	case XFS_MEDIA_ERROR_LOGDEV:
+		fdev = XFS_FAILED_LOGDEV;
+		type = -1;
+		break;
+	case XFS_MEDIA_ERROR_RTDEV:
+		fdev = XFS_FAILED_RTDEV;
+		type = XG_TYPE_RTG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	xfs_media_error_hook(mp, fdev, me.daddr, me.bbcount, false);
+
+	if (xfs_has_rmapbt(mp) && fdev != XFS_FAILED_LOGDEV)
+		return xfs_report_data_lost(mp, type, me.daddr, me.bbcount);
+
+	return 0;
+}


