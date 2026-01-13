Return-Path: <linux-fsdevel+bounces-73354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F5AD1611F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 227C83063923
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD822D4C3;
	Tue, 13 Jan 2026 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ18/fqX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF040157480;
	Tue, 13 Jan 2026 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264526; cv=none; b=PBVCc5CVPZ+T72P6IExRQDnbES5dS2yVf63u9MD9Jl8JcuMeKKKUimvVbk/OCrhSautDzO0I5+jwSxL6Ik+l1HYGFcy4lSnKl2MGFd1Kd5Y6RTTWG7pn8soY8kHvP5iLe1duNEVIZ+tV3RCP8FO+FuBTOIezC5p1QOCnKDlIYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264526; c=relaxed/simple;
	bh=qhIqwdItVlOl2AAhpdsx+6UeKbQOXSD5X2dV9ttJfpA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzIx8CJRDc6EuX9REe3eEVe72XHmiT8yaoq6/tPFhB9/+5WG51KG6zRuoWAP+AyCq1/lFnmNFM7rE5QIJz1AuKlRlV/+eXHbwDRwcGsC57evdYqNgzNajtF2vmGzR+X3RQwJUDE5koVhQgphvxWH7pPPxcfxvkwQNUx1qra1cyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ18/fqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6A8C116D0;
	Tue, 13 Jan 2026 00:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264526;
	bh=qhIqwdItVlOl2AAhpdsx+6UeKbQOXSD5X2dV9ttJfpA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UJ18/fqXVod2HrtxNVdKCl/hzr0DZnr+kOZcSSL7yjeXK+BHLMkKK2DdMN4mdU7vJ
	 c4QM/+kevpuqtC3c4Ch8PQ+flmghh7E8Uw+j4fSt25blZbGlCQATqaUD1+whXapyFT
	 RlM3V4q07JOsiAM7pi6zTbSyfLzPWMe+JTDkscuuyHHL7V/GbLm/TJ/aWgoP6ofbmL
	 psY+2YgrGjhS35wW9lL/sxJG//1gVRWnVMN0mgy/59SFQQGtTJeiSkt3BuzRBrrwGV
	 ZiNBQPwxLGT13Rheu1XaCOGiZR2KXzxOinLZ7zR5HX0GC5dI8fWY5VbV9VP1GWZvYA
	 d9WgiPvqkrAMg==
Date: Mon, 12 Jan 2026 16:35:25 -0800
Subject: [PATCH 11/11] xfs: add media verification ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176826412941.3493441.8359506127711497025.stgit@frogsfrogsfrogs>
In-Reply-To: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a new privileged ioctl so that xfs_scrub can ask the kernel to
verify the media of the devices backing an xfs filesystem, and have any
resulting media errors reported to fsnotify and xfs_healer.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h      |   27 +++
 fs/xfs/xfs_notify_failure.h |    4 
 fs/xfs/xfs_trace.h          |   97 +++++++++++
 fs/xfs/Makefile             |    6 -
 fs/xfs/xfs_ioctl.c          |    3 
 fs/xfs/xfs_notify_failure.c |  375 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 507 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index a01303c5de6ce6..10fd94e3b9f5b4 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1160,6 +1160,31 @@ struct xfs_health_file_on_monitored_fs {
 	__u32		flags;	/* zero for now */
 };
 
+/* Verify the media of the underlying devices */
+struct xfs_verify_media {
+	__u32	dev;		/* I: XFS_VERIFY_*DEV */
+	__u32	flags;		/* I: all other XFS_VERIFY_* */
+
+	/* IO: inclusive start of disk range to verify, in 512b blocks */
+	__u64	start_daddr;
+	/*
+	 * I: exclusive end of the disk range to verify, in 512b blocks
+	 * or XFS_VERIFY_TO_EOD to verify to the end of the device
+	 */
+	__u64	end_daddr;
+
+	__u32	ioerror;	/* O: I/O error (positive) */
+	__u32	pad;		/* zero */
+};
+
+#define XFS_VERIFY_DATADEV	(1)	/* data device */
+#define XFS_VERIFY_LOGDEV	(2)	/* external log device */
+#define XFS_VERIFY_RTDEV	(3)	/* realtime device */
+
+#define XFS_VERIFY_TO_EOD	(~0ULL)	/* end of disk */
+
+#define XFS_VERIFY_REPORT_ERRORS (1 << 0)	/* report to fsnotify */
+
 /*
  * ioctl commands that are used by Linux filesystems
  */
@@ -1202,6 +1227,8 @@ struct xfs_health_file_on_monitored_fs {
 #define XFS_IOC_HEALTH_MONITOR	_IOW ('X', 68, struct xfs_health_monitor)
 #define XFS_IOC_HEALTH_FD_ON_MONITORED_FS \
 				_IOW ('X', 69, struct xfs_health_file_on_monitored_fs)
+#define XFS_IOC_VERIFY_MEDIA	_IOWR('X', 70, struct xfs_verify_media)
+
 /*
  * ioctl commands that replace IRIX syssgi()'s
  */
diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
index 8d08ec29dd2949..042d78a2979c60 100644
--- a/fs/xfs/xfs_notify_failure.h
+++ b/fs/xfs/xfs_notify_failure.h
@@ -8,4 +8,8 @@
 
 extern const struct dax_holder_operations xfs_dax_holder_operations;
 
+struct xfs_verify_media;
+int xfs_ioc_verify_media(struct file *file,
+		struct xfs_verify_media __user *arg);
+
 #endif /* __XFS_NOTIFY_FAILURE_H__ */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 0cf4877753584f..9ab97f93119198 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6320,6 +6320,103 @@ TRACE_EVENT(xfs_healthmon_report_file_ioerror,
 		  __entry->error)
 );
 
+TRACE_EVENT(xfs_verify_media,
+	TP_PROTO(const struct xfs_mount *mp, const struct xfs_verify_media *me,
+		 dev_t fdev, xfs_daddr_t bio_daddr, uint64_t bio_bbcount,
+		 unsigned int bufsize),
+	TP_ARGS(mp, me, fdev, bio_daddr, bio_bbcount, bufsize),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(dev_t, fdev)
+		__field(xfs_daddr_t, start_daddr)
+		__field(xfs_daddr_t, end_daddr)
+		__field(unsigned int, flags)
+		__field(xfs_daddr_t, bio_daddr)
+		__field(uint64_t, bio_bbcount)
+		__field(unsigned int, bufsize)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_ddev_targp->bt_dev;
+		__entry->fdev = fdev;
+		__entry->start_daddr = me->start_daddr;
+		__entry->end_daddr = me->end_daddr;
+		__entry->flags = me->flags;
+		__entry->bio_daddr = bio_daddr;
+		__entry->bio_bbcount = bio_bbcount;
+		__entry->bufsize = bufsize;
+	),
+	TP_printk("dev %d:%d fdev %d:%d start_daddr 0x%llx end_daddr 0x%llx flags 0x%x bio_daddr 0x%llx bio_bbcount 0x%llx bufsize 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  MAJOR(__entry->fdev), MINOR(__entry->fdev),
+		  __entry->start_daddr,
+		  __entry->end_daddr,
+		  __entry->flags,
+		  __entry->bio_daddr,
+		  __entry->bio_bbcount,
+		  __entry->bufsize)
+);
+
+TRACE_EVENT(xfs_verify_media_end,
+	TP_PROTO(const struct xfs_mount *mp, const struct xfs_verify_media *me,
+		 dev_t fdev),
+	TP_ARGS(mp, me, fdev),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(dev_t, fdev)
+		__field(xfs_daddr_t, start_daddr)
+		__field(xfs_daddr_t, end_daddr)
+		__field(int, ioerror)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_ddev_targp->bt_dev;
+		__entry->fdev = fdev;
+		__entry->start_daddr = me->start_daddr;
+		__entry->end_daddr = me->end_daddr;
+		__entry->ioerror = me->ioerror;
+	),
+	TP_printk("dev %d:%d fdev %d:%d start_daddr 0x%llx end_daddr 0x%llx ioerror %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  MAJOR(__entry->fdev), MINOR(__entry->fdev),
+		  __entry->start_daddr,
+		  __entry->end_daddr,
+		  __entry->ioerror)
+);
+
+TRACE_EVENT(xfs_verify_media_error,
+	TP_PROTO(const struct xfs_mount *mp, const struct xfs_verify_media *me,
+		 dev_t fdev, xfs_daddr_t daddr, uint64_t bbcount, int error),
+	TP_ARGS(mp, me, fdev, daddr, bbcount, error),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(dev_t, fdev)
+		__field(xfs_daddr_t, start_daddr)
+		__field(xfs_daddr_t, end_daddr)
+		__field(unsigned int, flags)
+		__field(xfs_daddr_t, daddr)
+		__field(uint64_t, bbcount)
+		__field(int, error)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_ddev_targp->bt_dev;
+		__entry->fdev = fdev;
+		__entry->start_daddr = me->start_daddr;
+		__entry->end_daddr = me->end_daddr;
+		__entry->flags = me->flags;
+		__entry->daddr = daddr;
+		__entry->bbcount = bbcount;
+		__entry->error = error;
+	),
+	TP_printk("dev %d:%d fdev %d:%d start_daddr 0x%llx end_daddr 0x%llx flags 0x%x daddr 0x%llx bbcount 0x%llx error %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  MAJOR(__entry->fdev), MINOR(__entry->fdev),
+		  __entry->start_daddr,
+		  __entry->end_daddr,
+		  __entry->flags,
+		  __entry->daddr,
+		  __entry->bbcount,
+		  __entry->error)
+);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
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
index c04c41ca924e37..b74b9e0f023bf8 100644
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
+	case XFS_IOC_VERIFY_MEDIA:
+		return xfs_ioc_verify_media(filp, arg);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 1edc4ddd10cdb2..5ef4109cc062d2 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -23,12 +23,14 @@
 #include "xfs_rtgroup.h"
 #include "xfs_rtrmap_btree.h"
 #include "xfs_healthmon.h"
+#include "xfs_trace.h"
 
 #include <linux/mm.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
 #include <linux/fserror.h>
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
 struct xfs_failure_info {
 	xfs_agblock_t		startblock;
 	xfs_extlen_t		blockcount;
@@ -395,3 +397,376 @@ xfs_dax_notify_failure(
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
+/* Verify the media of an xfs device by submitting read requests to the disk. */
+static int
+xfs_verify_media(
+	struct xfs_mount	*mp,
+	enum xfs_device		fdev,
+	struct xfs_verify_media	*me)
+{
+	struct blk_plug		plug;
+	struct xfs_buftarg	*btp = NULL;
+	struct bio		*bio = NULL;
+	struct folio		*folio;
+	xfs_daddr_t		new_start_daddr = me->start_daddr;
+	xfs_daddr_t		bio_daddr;
+	uint64_t		bio_bbcount;
+	const unsigned int	iosize = BIO_MAX_VECS << PAGE_SHIFT;
+	unsigned int		bufsize = iosize;
+	unsigned int		bio_submitted = 0;
+	enum xfs_group_type	group;
+	int			error = 0;
+
+	me->ioerror = 0;
+
+	switch (fdev) {
+	case XFS_DEV_DATA:
+		btp = mp->m_ddev_targp;
+		break;
+	case XFS_DEV_LOG:
+		if (mp->m_logdev_targp->bt_bdev != mp->m_ddev_targp->bt_bdev)
+			btp = mp->m_logdev_targp;
+		break;
+	case XFS_DEV_RT:
+		btp = mp->m_rtdev_targp;
+		break;
+	}
+	if (!btp)
+		return -ENODEV;
+
+	/*
+	 * If the caller told us to verify to EOD, tell the user exactly where
+	 * that was.
+	 */
+	if (me->end_daddr == XFS_VERIFY_TO_EOD)
+		me->end_daddr = btp->bt_nr_sectors;
+
+	if (me->start_daddr > me->end_daddr)
+		return 0;
+
+	/* We've already hit EOD, so advance to the end */
+	if (me->start_daddr >= btp->bt_nr_sectors) {
+		me->start_daddr = me->end_daddr;
+		return 0;
+	}
+
+	bio_daddr = me->start_daddr;
+	bio_bbcount = min_t(sector_t, me->end_daddr, btp->bt_nr_sectors) -
+			  me->start_daddr;
+
+	/*
+	 * There are three ranges involved here:
+	 *
+	 *  - [me->start_daddr, me->end_daddr) is the range that the user wants
+	 *    to verify.  If me->end_daddr is XFS_VERIFY_TO_EOD then that means
+	 *    to verify to the end of the disk.
+	 *
+	 *  - [new_start_daddr, me->end_daddr) is the range that we have not
+	 *    yet verified.  We update new_start_daddr after each successful
+	 *    read.  me->start_daddr is set to new_start_daddr before
+	 *    returning.
+	 *
+	 *  - [bio_daddr, bio_daddr + bio_bbcount) is the range of the next
+	 *    read bio(s) that we'll submit.
+	 *
+	 * Try to create bios of maximal size, whether we allocate one large
+	 * folio of that size, or a single page.
+	 */
+	if ((bufsize >> SECTOR_SHIFT) > bio_bbcount)
+		bufsize = bio_bbcount << SECTOR_SHIFT;
+
+	folio = folio_alloc(GFP_KERNEL, get_order(bufsize));
+	if (!folio)
+		folio = folio_alloc(GFP_KERNEL, 0);
+	if (!folio)
+		return -ENOMEM;
+	bufsize = folio_size(folio);
+
+	trace_xfs_verify_media(mp, me, btp->bt_bdev->bd_dev, bio_daddr,
+			bio_bbcount, bufsize);
+
+	blk_start_plug(&plug);
+	while (bio_bbcount > 0) {
+		unsigned int		nr_sects =
+			min_t(sector_t, bio_bbcount, iosize >> SECTOR_SHIFT);
+		const unsigned int	nr_vecs =
+			howmany(nr_sects << SECTOR_SHIFT, bufsize);
+		unsigned int		i;
+
+		bio = blk_next_bio(bio, btp->bt_bdev, nr_vecs, REQ_OP_READ,
+				GFP_KERNEL);
+		if (!bio) {
+			error = -ENOMEM;
+			goto out_folio;
+		}
+		bio->bi_iter.bi_sector = bio_daddr;
+
+		for (i = 0; i < nr_vecs; i++) {
+			unsigned int	vec_sects =
+				min(nr_sects, bufsize >> SECTOR_SHIFT);
+
+			bio_add_folio_nofail(bio, folio,
+					vec_sects << SECTOR_SHIFT, 0);
+
+			bio_daddr += vec_sects;
+			bio_bbcount -= vec_sects;
+			bio_submitted += vec_sects;
+		}
+
+		/* Don't let too many IOs accumulate */
+		if (bio_submitted > SZ_256M >> SECTOR_SHIFT) {
+			blk_finish_plug(&plug);
+			error = submit_bio_wait(bio);
+			if (error)
+				goto media_error;
+			bio_put(bio);
+			bio = NULL;
+
+			if (fatal_signal_pending(current)) {
+				error = -EINTR;
+				goto out_folio;
+			}
+
+			cond_resched();
+			new_start_daddr += bio_submitted;
+			bio_submitted = 0;
+			blk_start_plug(&plug);
+		}
+
+	}
+	blk_finish_plug(&plug);
+
+	/* Finish up a partially constructed bio if there is one */
+	if (!bio)
+		goto out_folio;
+
+	error = submit_bio_wait(bio);
+	if (error)
+		goto media_error;
+
+	new_start_daddr += bio_submitted;
+
+out_bio:
+	bio_put(bio);
+out_folio:
+	folio_put(folio);
+	if (!error) {
+		/*
+		 * Advance start_daddr to the end of what we verified if there
+		 * wasn't an operational error; or to end_daddr if we reached
+		 * the end of the disk.
+		 */
+		me->start_daddr = new_start_daddr;
+		if (me->start_daddr >= btp->bt_nr_sectors)
+			me->start_daddr = me->end_daddr;
+	}
+
+	trace_xfs_verify_media_end(mp, me, btp->bt_bdev->bd_dev);
+	return error;
+
+media_error:
+	trace_xfs_verify_media_error(mp, me, btp->bt_bdev->bd_dev,
+			new_start_daddr, bio_submitted, error);
+
+	/* Only report the I/O error if we didn't verify any bytes at all. */
+	if (me->start_daddr == new_start_daddr)
+		me->ioerror = -error;
+	error = 0;
+
+	if (!(me->flags & XFS_VERIFY_REPORT_ERRORS))
+		goto out_bio;
+
+	xfs_healthmon_report_media(mp, fdev, new_start_daddr, bio_submitted);
+
+	if (!xfs_has_rmapbt(mp))
+		goto out_bio;
+
+	switch (fdev) {
+	case XFS_DEV_DATA:
+		group = XG_TYPE_AG;
+		break;
+	case XFS_DEV_RT:
+		group = XG_TYPE_RTG;
+		break;
+	default:
+		goto out_bio;
+	}
+
+	xfs_report_data_lost(mp, group, new_start_daddr, bio_submitted);
+	goto out_bio;
+}
+
+#define XFS_VALID_VERIFY_MEDIA_FLAGS	(XFS_VERIFY_REPORT_ERRORS)
+int
+xfs_ioc_verify_media(
+	struct file			*file,
+	struct xfs_verify_media __user	*arg)
+{
+	struct xfs_verify_media		me;
+	struct xfs_inode		*ip = XFS_I(file_inode(file));
+	struct xfs_mount		*mp = ip->i_mount;
+	enum xfs_device			fdev;
+	int				error;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&me, arg, sizeof(me)))
+		return -EFAULT;
+
+	if (me.pad)
+		return -EINVAL;
+	if (me.flags & ~XFS_VALID_VERIFY_MEDIA_FLAGS)
+		return -EINVAL;
+
+	switch (me.dev) {
+	case XFS_VERIFY_DATADEV:
+		fdev = XFS_DEV_DATA;
+		break;
+	case XFS_VERIFY_RTDEV:
+		fdev = XFS_DEV_RT;
+		break;
+	case XFS_VERIFY_LOGDEV:
+		fdev = XFS_DEV_LOG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	error = xfs_verify_media(mp, fdev, &me);
+	if (error)
+		return error;
+
+	if (copy_to_user(arg, &me, sizeof(me)))
+		return -EFAULT;
+
+	return 0;
+}


