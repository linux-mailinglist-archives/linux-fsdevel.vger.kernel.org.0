Return-Path: <linux-fsdevel+bounces-72428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD5CF6FED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31BA1301D615
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ED2309F04;
	Tue,  6 Jan 2026 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/7rgQsL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E43F2C0307;
	Tue,  6 Jan 2026 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683610; cv=none; b=NEHPHs4Sk/OJTXs/nukZ8CLzrTpw5w7z9gxXqg/1wydGJv8nkjVCLvP53eT48DdsnSrfm4rozp6dcWNUqwQKbskAEZvrBXm0cAJHUd6/xj50bnyyOV8g/RRHFqrLYZMFkjIQg7JcGYshAcBsMxkKCcZUD7Thp8mExsyYfte7wE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683610; c=relaxed/simple;
	bh=g4CfscPmliFKcKJWyZ9sjmlme3HPLbXV0nUITeuhNYY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqhYiJeFjgA9rCLydJB19v2vStzDAnOriok78otzdA2CX8G62mEmCPcrt3S9SDmebnXtqTaODf32Jdm307+hz9zTKOFtlZ4E6GPO0/hcrdh6Y1McyR/kQTZvpuuh4sIZQRsymjcpFx4nsC8YOUF7rOiSUa+CUTxKZeAbku/bu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/7rgQsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1406C116C6;
	Tue,  6 Jan 2026 07:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683609;
	bh=g4CfscPmliFKcKJWyZ9sjmlme3HPLbXV0nUITeuhNYY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=k/7rgQsLE7j38RyDH6n1lTd2qaxSXNh2QWzJy5d2I00eIV7EaOTMY3WeOOxEQQFr3
	 9xdOLDt2thZC/dPDYGJL3Jzg2XKDy0dHiP4QOu/dvOO8i6/uNr2/7LSHrTmc+j7/WT
	 SNEPoqMoj+hrJSC36aR4XEcw67tGKMtPvY+6/GQGKcW+DcvH+TMKZmDV8pyq3Mnn0p
	 OT1YynMQVzvPxJp/SSFIhxNrq5vlJwokvUG1XEQoU2OV2g7zPg4OCv5Y+11B4sCwYj
	 4SDEOwMTQBNM19RLubso7rvGgcnD5pck0jO+dWZirt9nLE3NUAqOCEJ3J1ak9akgE5
	 Ixv4OeS5TBiVA==
Date: Mon, 05 Jan 2026 23:13:29 -0800
Subject: [PATCH 11/11] xfs: add media error reporting ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176766637485.774337.16716764027357885673.stgit@frogsfrogsfrogs>
In-Reply-To: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a new privileged ioctl so that xfs_scrub can report the media errors
that it finds to the kernel for further processing.  Ideally this would
be done by the kernel, but the kernel doesn't (yet) support initiating
verification reads.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h      |   18 ++++
 fs/xfs/xfs_notify_failure.h |    4 +
 fs/xfs/Makefile             |    6 -
 fs/xfs/xfs_ioctl.c          |    3 +
 fs/xfs/xfs_notify_failure.c |  178 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 204 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index f2a7736f4fc0bc..64c1ca05530251 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1161,6 +1161,21 @@ struct xfs_health_file_on_monitored_fs {
 	__u32		flags;	/* zero for now */
 };
 
+/* Report a media error to the kernel */
+struct xfs_media_error_report {
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
@@ -1203,6 +1218,9 @@ struct xfs_health_file_on_monitored_fs {
 #define XFS_IOC_HEALTH_MONITOR	_IOW ('X', 68, struct xfs_health_monitor)
 #define XFS_IOC_HEALTH_FD_ON_MONITORED_FS \
 				_IOW ('X', 69, struct xfs_health_file_on_monitored_fs)
+#define XFS_IOC_REPORT_MEDIA_ERROR \
+				_IOW ('X', 70, struct xfs_media_error_report)
+
 /*
  * ioctl commands that replace IRIX syssgi()'s
  */
diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
index 8d08ec29dd2949..49d9deda292ca4 100644
--- a/fs/xfs/xfs_notify_failure.h
+++ b/fs/xfs/xfs_notify_failure.h
@@ -8,4 +8,8 @@
 
 extern const struct dax_holder_operations xfs_dax_holder_operations;
 
+struct xfs_media_error_report;
+int xfs_ioc_report_media_error(struct file *file,
+		struct xfs_media_error_report __user *arg);
+
 #endif /* __XFS_NOTIFY_FAILURE_H__ */
diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 1b7385e23b3463..a879d1d2155ed7 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -99,6 +99,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_message.o \
 				   xfs_mount.o \
 				   xfs_mru_cache.o \
+				   xfs_notify_failure.o \
 				   xfs_pwork.o \
 				   xfs_reflink.o \
 				   xfs_stats.o \
@@ -149,11 +150,6 @@ xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
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
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index c04c41ca924e37..5fa00249cef018 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -42,6 +42,7 @@
 #include "xfs_handle.h"
 #include "xfs_rtgroup.h"
 #include "xfs_healthmon.h"
+#include "xfs_notify_failure.h"
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
@@ -1422,6 +1423,8 @@ xfs_file_ioctl(
 
 	case XFS_IOC_HEALTH_MONITOR:
 		return xfs_ioc_health_monitor(filp, arg);
+	case XFS_IOC_REPORT_MEDIA_ERROR:
+		return xfs_ioc_report_media_error(filp, arg);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 1edc4ddd10cdb2..48a43e98615481 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -29,6 +29,7 @@
 #include <linux/fs.h>
 #include <linux/fserror.h>
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
 struct xfs_failure_info {
 	xfs_agblock_t		startblock;
 	xfs_extlen_t		blockcount;
@@ -395,3 +396,180 @@ xfs_dax_notify_failure(
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
+	fserror_report_data_lost(VFS_I(ip), XFS_FSB_TO_B(mp, fileoff),
+			XFS_FSB_TO_B(mp, blocks), GFP_NOFS);
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
+xfs_ioc_report_media_error(
+	struct file			*file,
+	struct xfs_media_error_report __user *arg)
+{
+	struct xfs_media_error_report	me;
+	struct xfs_inode		*ip = XFS_I(file_inode(file));
+	struct xfs_mount		*mp = ip->i_mount;
+	enum xfs_device			fdev;
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
+		fdev = XFS_DEV_DATA;
+		type = XG_TYPE_AG;
+		break;
+	case XFS_MEDIA_ERROR_RTDEV:
+		fdev = XFS_DEV_RT;
+		type = XG_TYPE_RTG;
+		break;
+	case XFS_MEDIA_ERROR_LOGDEV:
+		fdev = XFS_DEV_LOG;
+		type = -1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	xfs_healthmon_report_media(mp, fdev, me.daddr, me.bbcount);
+
+	if (xfs_has_rmapbt(mp) && fdev != XFS_DEV_LOG)
+		return xfs_report_data_lost(mp, type, me.daddr, me.bbcount);
+
+	return 0;
+}


