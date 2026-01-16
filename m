Return-Path: <linux-fsdevel+bounces-74058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F89D2C1DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 06:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C2E53027E2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 05:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84F2347FDE;
	Fri, 16 Jan 2026 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6naJ85T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E6D27B34D;
	Fri, 16 Jan 2026 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542294; cv=none; b=kosgQNchKy3SN83wmWbuSB18Vd5fD7Ud6SxAMPbyvT8I7Hx+oS2b1iDbohLqYvSJKTIOAMn2k2VSTivGwSJul0cIl79ZsgeH6qbou/fhTNhz+LNbTObAZES1LUGTSreE9yVwrlsJOCCrrWfyHTx0a45abudfKP9rspm+pzohbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542294; c=relaxed/simple;
	bh=+hucGAkk3/yj2U0I1aHtnh7j9FVG7qAtcRokBT16au0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOlWjtYxBa+TP8Z8p62wHsrNPEkDZ802K1ZHz0gOqU0v4ErSW8ObIbMpbky9LkhJhf8QaDuEv6cBD2l12vXQyK03mDO07tUCKrXWphfU7YxnmGC4umSeK/ErqxbqbPV16iL6qoQ2ZTs0Z5QnUm+0MtJw/3Z0vfeB+JM2kioxGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6naJ85T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC18C116C6;
	Fri, 16 Jan 2026 05:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768542294;
	bh=+hucGAkk3/yj2U0I1aHtnh7j9FVG7qAtcRokBT16au0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=L6naJ85TrIRdIDXdvJexKghQIZAJteOsc0HrEgLmAa3k3DHpmiPkyWo2xDMfuWO6/
	 T3fh64ZszSgtAswb0wi8LCB6cL0E+ipLercrEe+rmAmdAnlYyMN1wCEhn1xwt4bioX
	 AaH5PSqOXx3RvrPxmccZHJS3mvMrMgg44YHcPlgQjiftbw28a8EESFIhQkz2PXrCr4
	 akAjkC2SrUO1/qbRLXf5EnyuJWESaH2V3iueaYgSEf1BlMswzQGMjOjHOCwTQwx0Zz
	 /4e7EmaOmlVRz0SlcrXhICnRkXbrjIOSH13kEsWvC34MUlNtG13KJtPqRT6+a/9QgT
	 /nyhGV9Repf0A==
Date: Thu, 15 Jan 2026 21:44:53 -0800
Subject: [PATCH 11/11] xfs: add media verification ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de
Message-ID: <176852588776.2137143.7103003682733018282.stgit@frogsfrogsfrogs>
In-Reply-To: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
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
 fs/xfs/libxfs/xfs_fs.h    |   30 +++
 fs/xfs/xfs_trace.h        |   98 ++++++++++
 fs/xfs/xfs_verify_media.h |   13 +
 fs/xfs/Makefile           |    1 
 fs/xfs/xfs_ioctl.c        |    3 
 fs/xfs/xfs_verify_media.c |  459 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 604 insertions(+)
 create mode 100644 fs/xfs/xfs_verify_media.h
 create mode 100644 fs/xfs/xfs_verify_media.c


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index a01303c5de6ce6..d165de607d179e 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1160,6 +1160,34 @@ struct xfs_health_file_on_monitored_fs {
 	__u32		flags;	/* zero for now */
 };
 
+/* Verify the media of the underlying devices */
+struct xfs_verify_media {
+	__u32	me_dev;		/* I: XFS_DEV_{DATA,LOG,RT} */
+	__u32	me_flags;	/* I: XFS_VERIFY_MEDIA_* */
+
+	/*
+	 * IO: inclusive start of disk range to verify, in 512b blocks.
+	 * Will be adjusted upwards as media verification succeeds.
+	 */
+	__u64	me_start_daddr;
+
+	/*
+	 * IO: exclusive end of the disk range to verify, in 512b blocks.
+	 * Can be adjusted downwards to match device size.
+	 */
+	__u64	me_end_daddr;
+
+	__u32	me_ioerror;	/* O: I/O error (positive) */
+	__u32	me_max_io_size;	/* I: maximum IO size in bytes */
+
+	__u32	me_rest_us;	/* I: rest time between IOs, usecs */
+	__u32	me_pad;		/* zero */
+};
+
+#define XFS_VERIFY_MEDIA_REPORT	(1 << 0)	/* report to fsnotify */
+
+#define XFS_VERIFY_MEDIA_FLAGS	(XFS_VERIFY_MEDIA_REPORT)
+
 /*
  * ioctl commands that are used by Linux filesystems
  */
@@ -1202,6 +1230,8 @@ struct xfs_health_file_on_monitored_fs {
 #define XFS_IOC_HEALTH_MONITOR	_IOW ('X', 68, struct xfs_health_monitor)
 #define XFS_IOC_HEALTH_FD_ON_MONITORED_FS \
 				_IOW ('X', 69, struct xfs_health_file_on_monitored_fs)
+#define XFS_IOC_VERIFY_MEDIA	_IOWR('X', 70, struct xfs_verify_media)
+
 /*
  * ioctl commands that replace IRIX syssgi()'s
  */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 0cf4877753584f..3483461cf46255 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6320,6 +6320,104 @@ TRACE_EVENT(xfs_healthmon_report_file_ioerror,
 		  __entry->error)
 );
 
+TRACE_EVENT(xfs_verify_media,
+	TP_PROTO(const struct xfs_mount *mp, const struct xfs_verify_media *me,
+		 dev_t fdev, xfs_daddr_t daddr, uint64_t bbcount,
+		 const struct folio *folio),
+	TP_ARGS(mp, me, fdev, daddr, bbcount, folio),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(dev_t, fdev)
+		__field(xfs_daddr_t, start_daddr)
+		__field(xfs_daddr_t, end_daddr)
+		__field(unsigned int, flags)
+		__field(xfs_daddr_t, daddr)
+		__field(uint64_t, bbcount)
+		__field(unsigned int, bufsize)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_ddev_targp->bt_dev;
+		__entry->fdev = fdev;
+		__entry->start_daddr = me->me_start_daddr;
+		__entry->end_daddr = me->me_end_daddr;
+		__entry->flags = me->me_flags;
+		__entry->daddr = daddr;
+		__entry->bbcount = bbcount;
+		__entry->bufsize = folio_size(folio);
+	),
+	TP_printk("dev %d:%d fdev %d:%d start_daddr 0x%llx end_daddr 0x%llx flags 0x%x daddr 0x%llx bbcount 0x%llx bufsize 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  MAJOR(__entry->fdev), MINOR(__entry->fdev),
+		  __entry->start_daddr,
+		  __entry->end_daddr,
+		  __entry->flags,
+		  __entry->daddr,
+		  __entry->bbcount,
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
+		__entry->start_daddr = me->me_start_daddr;
+		__entry->end_daddr = me->me_end_daddr;
+		__entry->ioerror = me->me_ioerror;
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
+		 dev_t fdev, xfs_daddr_t daddr, uint64_t bbcount,
+		 blk_status_t status),
+	TP_ARGS(mp, me, fdev, daddr, bbcount, status),
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
+		__entry->start_daddr = me->me_start_daddr;
+		__entry->end_daddr = me->me_end_daddr;
+		__entry->flags = me->me_flags;
+		__entry->daddr = daddr;
+		__entry->bbcount = bbcount;
+		__entry->error = blk_status_to_errno(status);
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
diff --git a/fs/xfs/xfs_verify_media.h b/fs/xfs/xfs_verify_media.h
new file mode 100644
index 00000000000000..dc6eee9c88636b
--- /dev/null
+++ b/fs/xfs/xfs_verify_media.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_VERIFY_MEDIA_H__
+#define __XFS_VERIFY_MEDIA_H__
+
+struct xfs_verify_media;
+int xfs_ioc_verify_media(struct file *file,
+		struct xfs_verify_media __user *arg);
+
+#endif /* __XFS_VERIFY_MEDIA_H__ */
diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 1b7385e23b3463..9f7133e025768d 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -106,6 +106,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_symlink.o \
 				   xfs_sysfs.o \
 				   xfs_trans.o \
+				   xfs_verify_media.o \
 				   xfs_xattr.o
 
 # low-level transaction/log code
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index c04c41ca924e37..80a005999d2df3 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -42,6 +42,7 @@
 #include "xfs_handle.h"
 #include "xfs_rtgroup.h"
 #include "xfs_healthmon.h"
+#include "xfs_verify_media.h"
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
@@ -1422,6 +1423,8 @@ xfs_file_ioctl(
 
 	case XFS_IOC_HEALTH_MONITOR:
 		return xfs_ioc_health_monitor(filp, arg);
+	case XFS_IOC_VERIFY_MEDIA:
+		return xfs_ioc_verify_media(filp, arg);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/xfs/xfs_verify_media.c b/fs/xfs/xfs_verify_media.c
new file mode 100644
index 00000000000000..29f8cae5d7ee88
--- /dev/null
+++ b/fs/xfs/xfs_verify_media.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "xfs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_bit.h"
+#include "xfs_btree.h"
+#include "xfs_inode.h"
+#include "xfs_icache.h"
+#include "xfs_trans.h"
+#include "xfs_alloc.h"
+#include "xfs_ag.h"
+#include "xfs_rmap.h"
+#include "xfs_rmap_btree.h"
+#include "xfs_rtgroup.h"
+#include "xfs_rtrmap_btree.h"
+#include "xfs_health.h"
+#include "xfs_healthmon.h"
+#include "xfs_trace.h"
+#include "xfs_verify_media.h"
+
+#include <linux/fserror.h>
+
+struct xfs_group_data_lost {
+	xfs_agblock_t		startblock;
+	xfs_extlen_t		blockcount;
+};
+
+/* Report lost file data from rmap records */
+STATIC int
+xfs_verify_report_data_lost(
+	struct xfs_btree_cur		*cur,
+	const struct xfs_rmap_irec	*rec,
+	void				*data)
+{
+	struct xfs_mount		*mp = cur->bc_mp;
+	struct xfs_inode		*ip;
+	struct xfs_group_data_lost	*lost = data;
+	xfs_fileoff_t			fileoff = rec->rm_offset;
+	xfs_extlen_t			blocks = rec->rm_blockcount;
+	const bool			is_attr =
+			(rec->rm_flags & XFS_RMAP_ATTR_FORK);
+	const xfs_agblock_t		lost_end =
+			lost->startblock + lost->blockcount;
+	const xfs_agblock_t		rmap_end =
+			rec->rm_startblock + rec->rm_blockcount;
+	int				error = 0;
+
+	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner))
+	       return 0;
+
+	error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, 0, 0, &ip);
+	if (error)
+		return 0;
+
+	if (rec->rm_flags & XFS_RMAP_BMBT_BLOCK) {
+		xfs_bmap_mark_sick(ip, is_attr ? XFS_ATTR_FORK : XFS_DATA_FORK);
+		goto out_rele;
+	}
+
+	if (is_attr) {
+		xfs_inode_mark_sick(ip, XFS_SICK_INO_XATTR);
+		goto out_rele;
+	}
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
+out_rele:
+	xfs_irele(ip);
+	return 0;
+}
+
+/* Walk reverse mappings to look for all file data loss */
+STATIC int
+xfs_verify_report_losses(
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
+				xfs_verify_report_data_lost, &lost);
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
+/*
+ * Compute the desired verify IO size.
+ *
+ * To minimize command overhead, we'd like to create bios that are 1MB, though
+ * we allow the user to ask for a smaller size.
+ */
+STATIC unsigned int
+xfs_verify_iosize(
+	const struct xfs_verify_media	*me,
+	struct xfs_buftarg		*btp,
+	uint64_t			bbcount)
+{
+	unsigned int			iosize =
+			min_not_zero(SZ_1M, me->me_max_io_size);
+
+	BUILD_BUG_ON(BBSHIFT != SECTOR_SHIFT);
+	ASSERT(BBTOB(bbcount) >= bdev_logical_block_size(btp->bt_bdev));
+
+	return clamp(iosize, bdev_logical_block_size(btp->bt_bdev),
+			BBTOB(bbcount));
+}
+
+/* Allocate as much memory as we can get for verification buffer. */
+STATIC struct folio *
+xfs_verify_alloc_folio(
+	const unsigned int	iosize)
+{
+	unsigned int		order = get_order(iosize);
+
+	while (order > 0) {
+		struct folio	*folio =
+			folio_alloc(GFP_KERNEL | __GFP_NORETRY, order);
+
+		if (folio)
+			return folio;
+		order--;
+	}
+
+	return folio_alloc(GFP_KERNEL, 0);
+}
+
+/* Construct a bio for doing the verification. */
+STATIC struct bio *
+xfs_verify_bio_alloc(
+	struct xfs_buftarg	*btp,
+	xfs_daddr_t		daddr,
+	uint64_t		bbcount,
+	struct folio		*folio)
+{
+	struct bio		*bio;
+
+	bio = bio_alloc(btp->bt_bdev, 1, REQ_OP_READ, GFP_KERNEL);
+	if (!bio)
+		return NULL;
+
+	bio->bi_iter.bi_sector = daddr;
+	bio_add_folio_nofail(bio, folio,
+			min(bbcount << SECTOR_SHIFT, folio_size(folio)), 0);
+
+	return bio;
+}
+
+/* Report any kind of problem verifying media */
+STATIC void
+xfs_verify_media_error(
+	struct xfs_mount	*mp,
+	struct xfs_verify_media	*me,
+	struct xfs_buftarg	*btp,
+	xfs_daddr_t		daddr,
+	unsigned int		bio_bbcount,
+	blk_status_t		bio_status)
+{
+	trace_xfs_verify_media_error(mp, me, btp->bt_bdev->bd_dev, daddr,
+			bio_bbcount, bio_status);
+
+	/*
+	 * Pass any I/O error up to the caller if we didn't successfully verify
+	 * any bytes at all.
+	 */
+	if (me->me_start_daddr == daddr)
+		me->me_ioerror = -blk_status_to_errno(bio_status);
+
+	/*
+	 * PI validation failures, medium errors, or general IO errors are
+	 * treated as indicators of data loss.  Everything else are (hopefully)
+	 * transient errors and are not reported.
+	 */
+	switch (bio_status) {
+	case BLK_STS_PROTECTION:
+	case BLK_STS_IOERR:
+	case BLK_STS_MEDIUM:
+		break;
+	default:
+		return;
+	}
+
+	if (!(me->me_flags & XFS_VERIFY_MEDIA_REPORT))
+		return;
+
+	xfs_healthmon_report_media(mp, me->me_dev, daddr, bio_bbcount);
+
+	if (!xfs_has_rmapbt(mp))
+		return;
+
+	switch (me->me_dev) {
+	case XFS_DEV_DATA:
+		xfs_verify_report_losses(mp, XG_TYPE_AG, daddr, bio_bbcount);
+		break;
+	case XFS_DEV_RT:
+		xfs_verify_report_losses(mp, XG_TYPE_RTG, daddr, bio_bbcount);
+		break;
+	}
+}
+
+/* Verify the media of an xfs device by submitting read requests to the disk. */
+STATIC int
+xfs_verify_media(
+	struct xfs_mount	*mp,
+	struct xfs_verify_media	*me)
+{
+	struct xfs_buftarg	*btp = NULL;
+	struct folio		*folio;
+	xfs_daddr_t		daddr;
+	uint64_t		bbcount;
+	int			error = 0;
+
+	me->me_ioerror = 0;
+
+	switch (me->me_dev) {
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
+	 * If the caller told us to verify beyond the end of the disk, tell the
+	 * user exactly where that was.
+	 */
+	if (me->me_end_daddr > btp->bt_nr_sectors)
+		me->me_end_daddr = btp->bt_nr_sectors;
+
+	/* start and end have to be aligned to the lba size */
+	if (!IS_ALIGNED(BBTOB(me->me_start_daddr | me->me_end_daddr),
+			bdev_logical_block_size(btp->bt_bdev)))
+		return -EINVAL;
+
+	/*
+	 * end_daddr is the exclusive end of the range, so if start_daddr
+	 * reaches there (or beyond), there's no work to be done.
+	 */
+	if (me->me_start_daddr >= me->me_end_daddr)
+		return 0;
+
+	/*
+	 * There are three ranges involved here:
+	 *
+	 *  - [me->me_start_daddr, me->me_end_daddr) is the range that the
+	 *    user wants to verify.  end_daddr can be beyond the end of the
+	 *    disk; we'll constrain it to the end if necessary.
+	 *
+	 *  - [daddr, me->me_end_daddr) is the range that we have not yet
+	 *    verified.  We update daddr after each successful read.
+	 *    me->me_start_daddr is set to daddr before returning.
+	 *
+	 *  - [daddr, daddr + bio_bbcount) is the range that we're currently
+	 *    verifying.
+	 */
+	daddr = me->me_start_daddr;
+	bbcount = min_t(sector_t, me->me_end_daddr, btp->bt_nr_sectors) -
+			  me->me_start_daddr;
+
+	folio = xfs_verify_alloc_folio(xfs_verify_iosize(me, btp, bbcount));
+	if (!folio)
+		return -ENOMEM;
+
+	trace_xfs_verify_media(mp, me, btp->bt_bdev->bd_dev, daddr, bbcount,
+			folio);
+
+	while (bbcount > 0) {
+		struct bio	*bio;
+		unsigned int	bio_bbcount;
+		blk_status_t	bio_status;
+
+		bio = xfs_verify_bio_alloc(btp, daddr, bbcount, folio);
+		if (!bio) {
+			error = -ENOMEM;
+			break;
+		}
+
+		/*
+		 * Save the length of the bio before we submit it, because we
+		 * need the original daddr and length for reporting IO errors
+		 * if the bio fails.
+		 */
+		bio_bbcount = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+		submit_bio_wait(bio);
+		bio_status = bio->bi_status;
+		bio_put(bio);
+		if (bio_status != BLK_STS_OK) {
+			xfs_verify_media_error(mp, me, btp, daddr, bio_bbcount,
+					bio_status);
+			error = 0;
+			break;
+		}
+
+		daddr += bio_bbcount;
+		bbcount -= bio_bbcount;
+
+		if (bbcount == 0)
+			break;
+
+		if (me->me_rest_us) {
+			ktime_t	expires;
+
+			expires = ktime_add_ns(ktime_get(),
+					me->me_rest_us * 1000);
+			set_current_state(TASK_KILLABLE);
+			schedule_hrtimeout(&expires, HRTIMER_MODE_ABS);
+		}
+
+		if (fatal_signal_pending(current)) {
+			error = -EINTR;
+			break;
+		}
+
+		cond_resched();
+	}
+
+	folio_put(folio);
+
+	if (error)
+		return error;
+
+	/*
+	 * Advance start_daddr to the end of what we verified if there wasn't
+	 * an operational error.
+	 */
+	me->me_start_daddr = daddr;
+	trace_xfs_verify_media_end(mp, me, btp->bt_bdev->bd_dev);
+	return 0;
+}
+
+int
+xfs_ioc_verify_media(
+	struct file			*file,
+	struct xfs_verify_media __user	*arg)
+{
+	struct xfs_verify_media		me;
+	struct xfs_inode		*ip = XFS_I(file_inode(file));
+	struct xfs_mount		*mp = ip->i_mount;
+	int				error;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&me, arg, sizeof(me)))
+		return -EFAULT;
+
+	if (me.me_pad)
+		return -EINVAL;
+	if (me.me_flags & ~XFS_VERIFY_MEDIA_FLAGS)
+		return -EINVAL;
+
+	switch (me.me_dev) {
+	case XFS_DEV_DATA:
+	case XFS_DEV_LOG:
+	case XFS_DEV_RT:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	error = xfs_verify_media(mp, &me);
+	if (error)
+		return error;
+
+	if (copy_to_user(arg, &me, sizeof(me)))
+		return -EFAULT;
+
+	return 0;
+}


