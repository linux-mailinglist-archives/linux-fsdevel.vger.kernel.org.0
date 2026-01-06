Return-Path: <linux-fsdevel+bounces-72422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F8CF6FE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340D93021F92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BAD309F1C;
	Tue,  6 Jan 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIffApS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF5309EE5;
	Tue,  6 Jan 2026 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683516; cv=none; b=E6om3QXZHjnIDqgy0G4xgcL0ws7YnjLMLXfxhbWEIAM2sJGrmhVmgbxKlCOPSp7XWCsO4/rxpL5I6fru4ZC6CA4VAWnotQMoE04UZgdUTc845YEkZl2YPh/tH9EyF9Y6UGbxtrb2nPVkc7/xipxI9d2RAY45m1sTHRgKJrvhkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683516; c=relaxed/simple;
	bh=3CP6WLgQ1jHyx75zLlbK1/HuwhhH4oVt49Rz5Wpt/MI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8erB1xxuFLKGlZxgtRXF/nns0XNMjHBO8qAnX+QzBi/13sBQBPG7aBZhzJJBo/4SqobFfpbDH6Kp07yHwfrk4vjkhJHJX4vBiuu9Uedt4wR/Yvz/eZ6OnDpcnQj5YK9w1+7bSPOGAxMoZiy7KzRyOdf8ecRLxc8Ti7sDvzSWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIffApS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04845C116C6;
	Tue,  6 Jan 2026 07:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683516;
	bh=3CP6WLgQ1jHyx75zLlbK1/HuwhhH4oVt49Rz5Wpt/MI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aIffApS8Key/BF/VX0kVrSq2/nmjOPZOAO9C+ReR6j2m8JCsKJJrTyV08pZdhXV92
	 FTTJGHUQ1EwfeVEYpQ3iHNroz4/bnvuI0ttDhGmuI6g80pXyGT7Xxgyg2di5jX74/D
	 ZtTZR6DQ7u2zxbMtPfyZ/Q9FC2CDyDD0uCacgqlQHOvdy1S3f6g95sGnG1Cbfoq7Lf
	 1aSUmkmBGWg64bF5es+ub2LrXJYwcKuIEEiTC9lT2PfYnXPFSsrnSURIdXsKXtusON
	 y1F+BAb03R/F5gNGPU0w5ZtxRQf2OX+e5FbFcxpZZv4hn7In5RIEbWleCceT9PYDxm
	 fBbC72IHKO0ZQ==
Date: Mon, 05 Jan 2026 23:11:55 -0800
Subject: [PATCH 05/11] xfs: convey metadata health events to the health
 monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176766637355.774337.13910478335897021746.stgit@frogsfrogsfrogs>
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

Connect the filesystem metadata health event collection system to the
health monitor so that xfs can send events to xfs_healer as it collects
information.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h     |   35 +++++++++
 fs/xfs/libxfs/xfs_health.h |    5 +
 fs/xfs/xfs_healthmon.h     |   39 +++++++++
 fs/xfs/xfs_trace.h         |  130 +++++++++++++++++++++++++++++++-
 fs/xfs/xfs_health.c        |  123 ++++++++++++++++++++++++++++++
 fs/xfs/xfs_healthmon.c     |  181 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 511 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index d0a24eb56b3e0f..ae788d5eb3d398 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1008,6 +1008,12 @@ struct xfs_rtgroup_geometry {
 /* affects the whole fs */
 #define XFS_HEALTH_MONITOR_DOMAIN_MOUNT		(0)
 
+/* metadata health events */
+#define XFS_HEALTH_MONITOR_DOMAIN_FS		(1)
+#define XFS_HEALTH_MONITOR_DOMAIN_AG		(2)
+#define XFS_HEALTH_MONITOR_DOMAIN_INODE		(3)
+#define XFS_HEALTH_MONITOR_DOMAIN_RTGROUP	(4)
+
 /* Health monitor event types */
 
 /* status of the monitor itself */
@@ -1017,11 +1023,37 @@ struct xfs_rtgroup_geometry {
 /* filesystem was unmounted */
 #define XFS_HEALTH_MONITOR_TYPE_UNMOUNT		(2)
 
+/* metadata health events */
+#define XFS_HEALTH_MONITOR_TYPE_SICK		(3)
+#define XFS_HEALTH_MONITOR_TYPE_CORRUPT		(4)
+#define XFS_HEALTH_MONITOR_TYPE_HEALTHY		(5)
+
 /* lost events */
 struct xfs_health_monitor_lost {
 	__u64	count;
 };
 
+/* fs/rt metadata */
+struct xfs_health_monitor_fs {
+	/* XFS_FSOP_GEOM_SICK_* flags */
+	__u32	mask;
+};
+
+/* ag/rtgroup metadata */
+struct xfs_health_monitor_group {
+	/* XFS_{AG,RTGROUP}_SICK_* flags */
+	__u32	mask;
+	__u32	gno;
+};
+
+/* inode metadata */
+struct xfs_health_monitor_inode {
+	/* XFS_BS_SICK_* flags */
+	__u32	mask;
+	__u32	gen;
+	__u64	ino;
+};
+
 struct xfs_health_monitor_event {
 	/* XFS_HEALTH_MONITOR_DOMAIN_* */
 	__u32	domain;
@@ -1039,6 +1071,9 @@ struct xfs_health_monitor_event {
 	 */
 	union {
 		struct xfs_health_monitor_lost lost;
+		struct xfs_health_monitor_fs fs;
+		struct xfs_health_monitor_group group;
+		struct xfs_health_monitor_inode inode;
 	} e;
 
 	/* zeroes */
diff --git a/fs/xfs/libxfs/xfs_health.h b/fs/xfs/libxfs/xfs_health.h
index b31000f7190ce5..1d45cf5789e864 100644
--- a/fs/xfs/libxfs/xfs_health.h
+++ b/fs/xfs/libxfs/xfs_health.h
@@ -289,4 +289,9 @@ void xfs_bulkstat_health(struct xfs_inode *ip, struct xfs_bulkstat *bs);
 #define xfs_metadata_is_sick(error) \
 	(unlikely((error) == -EFSCORRUPTED || (error) == -EFSBADCRC))
 
+unsigned int xfs_healthmon_inode_mask(unsigned int sick_mask);
+unsigned int xfs_healthmon_rtgroup_mask(unsigned int sick_mask);
+unsigned int xfs_healthmon_perag_mask(unsigned int sick_mask);
+unsigned int xfs_healthmon_fs_mask(unsigned int sick_mask);
+
 #endif	/* __XFS_HEALTH_H__ */
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index 63e6c110bd378a..4632fa873ec087 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -68,10 +68,21 @@ enum xfs_healthmon_type {
 	XFS_HEALTHMON_RUNNING,	/* monitor running */
 	XFS_HEALTHMON_LOST,	/* message lost */
 	XFS_HEALTHMON_UNMOUNT,	/* filesystem is unmounting */
+
+	/* metadata health events */
+	XFS_HEALTHMON_SICK,	/* runtime corruption observed */
+	XFS_HEALTHMON_CORRUPT,	/* fsck reported corruption */
+	XFS_HEALTHMON_HEALTHY,	/* fsck reported healthy structure */
 };
 
 enum xfs_healthmon_domain {
 	XFS_HEALTHMON_MOUNT,	/* affects the whole fs */
+
+	/* metadata health events */
+	XFS_HEALTHMON_FS,	/* main filesystem metadata */
+	XFS_HEALTHMON_AG,	/* allocation group metadata */
+	XFS_HEALTHMON_INODE,	/* inode metadata */
+	XFS_HEALTHMON_RTGROUP,	/* realtime group metadata */
 };
 
 struct xfs_healthmon_event {
@@ -91,9 +102,37 @@ struct xfs_healthmon_event {
 		struct {
 			unsigned int	flags;
 		};
+		/* fs/rt metadata */
+		struct {
+			/* XFS_SICK_* flags */
+			unsigned int	fsmask;
+		};
+		/* ag/rtgroup metadata */
+		struct {
+			/* XFS_SICK_(AG|RG)* flags */
+			unsigned int	grpmask;
+			unsigned int	group;
+		};
+		/* inode metadata */
+		struct {
+			/* XFS_SICK_INO_* flags */
+			unsigned int	imask;
+			uint32_t	gen;
+			xfs_ino_t	ino;
+		};
 	};
 };
 
+void xfs_healthmon_report_fs(struct xfs_mount *mp,
+		enum xfs_healthmon_type type, unsigned int old_mask,
+		unsigned int new_mask);
+void xfs_healthmon_report_group(struct xfs_group *xg,
+		enum xfs_healthmon_type type, unsigned int old_mask,
+		unsigned int new_mask);
+void xfs_healthmon_report_inode(struct xfs_inode *ip,
+		enum xfs_healthmon_type type, unsigned int old_mask,
+		unsigned int new_mask);
+
 long xfs_ioc_health_monitor(struct file *file,
 		struct xfs_health_monitor __user *arg);
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 305cae8f497b43..debe9846418a04 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6009,15 +6009,29 @@ DEFINE_HEALTHMON_EVENT(xfs_healthmon_report_unmount);
 
 #define XFS_HEALTHMON_TYPE_STRINGS \
 	{ XFS_HEALTHMON_LOST,		"lost" }, \
-	{ XFS_HEALTHMON_UNMOUNT,	"unmount" }
+	{ XFS_HEALTHMON_UNMOUNT,	"unmount" }, \
+	{ XFS_HEALTHMON_SICK,		"sick" }, \
+	{ XFS_HEALTHMON_CORRUPT,	"corrupt" }, \
+	{ XFS_HEALTHMON_HEALTHY,	"healthy" }
 
 #define XFS_HEALTHMON_DOMAIN_STRINGS \
-	{ XFS_HEALTHMON_MOUNT,		"mount" }
+	{ XFS_HEALTHMON_MOUNT,		"mount" }, \
+	{ XFS_HEALTHMON_FS,		"fs" }, \
+	{ XFS_HEALTHMON_AG,		"ag" }, \
+	{ XFS_HEALTHMON_INODE,		"inode" }, \
+	{ XFS_HEALTHMON_RTGROUP,	"rtgroup" }
 
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_LOST);
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_UNMOUNT);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_SICK);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_CORRUPT);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_HEALTHY);
 
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_MOUNT);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_FS);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_AG);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_INODE);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_RTGROUP);
 
 DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
 	TP_PROTO(const struct xfs_healthmon *hm,
@@ -6054,6 +6068,19 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
 				break;
 			}
 			break;
+		case XFS_HEALTHMON_FS:
+			__entry->mask = event->fsmask;
+			break;
+		case XFS_HEALTHMON_AG:
+		case XFS_HEALTHMON_RTGROUP:
+			__entry->mask = event->grpmask;
+			__entry->group = event->group;
+			break;
+		case XFS_HEALTHMON_INODE:
+			__entry->mask = event->imask;
+			__entry->ino = event->ino;
+			__entry->gen = event->gen;
+			break;
 		}
 	),
 	TP_printk("dev %d:%d type %s domain %s mask 0x%x ino 0x%llx gen 0x%x offset 0x%llx len 0x%llx group 0x%x lost %llu",
@@ -6081,6 +6108,105 @@ DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_format_overflow);
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_drop);
 DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_merge);
 
+TRACE_EVENT(xfs_healthmon_report_fs,
+	TP_PROTO(const struct xfs_healthmon *hm,
+		 unsigned int old_mask, unsigned int new_mask,
+		 const struct xfs_healthmon_event *event),
+	TP_ARGS(hm, old_mask, new_mask, event),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, type)
+		__field(unsigned int, domain)
+		__field(unsigned int, old_mask)
+		__field(unsigned int, new_mask)
+		__field(unsigned int, fsmask)
+	),
+	TP_fast_assign(
+		__entry->dev = hm->dev;
+		__entry->type = event->type;
+		__entry->domain = event->domain;
+		__entry->old_mask = old_mask;
+		__entry->new_mask = new_mask;
+		__entry->fsmask = event->fsmask;
+	),
+	TP_printk("dev %d:%d type %s domain %s oldmask 0x%x newmask 0x%x fsmask 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_symbolic(__entry->type, XFS_HEALTHMON_TYPE_STRINGS),
+		  __print_symbolic(__entry->domain, XFS_HEALTHMON_DOMAIN_STRINGS),
+		  __entry->old_mask,
+		  __entry->new_mask,
+		  __entry->fsmask)
+);
+
+TRACE_EVENT(xfs_healthmon_report_group,
+	TP_PROTO(const struct xfs_healthmon *hm,
+		 unsigned int old_mask, unsigned int new_mask,
+		 const struct xfs_healthmon_event *event),
+	TP_ARGS(hm, old_mask, new_mask, event),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, type)
+		__field(unsigned int, domain)
+		__field(unsigned int, old_mask)
+		__field(unsigned int, new_mask)
+		__field(unsigned int, grpmask)
+		__field(unsigned int, group)
+	),
+	TP_fast_assign(
+		__entry->dev = hm->dev;
+		__entry->type = event->type;
+		__entry->domain = event->domain;
+		__entry->old_mask = old_mask;
+		__entry->new_mask = new_mask;
+		__entry->grpmask = event->grpmask;
+		__entry->group = event->group;
+	),
+	TP_printk("dev %d:%d type %s domain %s oldmask 0x%x newmask 0x%x grpmask 0x%x group 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_symbolic(__entry->type, XFS_HEALTHMON_TYPE_STRINGS),
+		  __print_symbolic(__entry->domain, XFS_HEALTHMON_DOMAIN_STRINGS),
+		  __entry->old_mask,
+		  __entry->new_mask,
+		  __entry->grpmask,
+		  __entry->group)
+);
+
+TRACE_EVENT(xfs_healthmon_report_inode,
+	TP_PROTO(const struct xfs_healthmon *hm,
+		 unsigned int old_mask, unsigned int new_mask,
+		 const struct xfs_healthmon_event *event),
+	TP_ARGS(hm, old_mask, new_mask, event),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, type)
+		__field(unsigned int, domain)
+		__field(unsigned int, old_mask)
+		__field(unsigned int, new_mask)
+		__field(unsigned int, imask)
+		__field(unsigned long long, ino)
+		__field(unsigned int, gen)
+	),
+	TP_fast_assign(
+		__entry->dev = hm->dev;
+		__entry->type = event->type;
+		__entry->domain = event->domain;
+		__entry->old_mask = old_mask;
+		__entry->new_mask = new_mask;
+		__entry->imask = event->imask;
+		__entry->ino = event->ino;
+		__entry->gen = event->gen;
+	),
+	TP_printk("dev %d:%d type %s domain %s oldmask 0x%x newmask 0x%x imask 0x%x ino 0x%llx gen 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_symbolic(__entry->type, XFS_HEALTHMON_TYPE_STRINGS),
+		  __print_symbolic(__entry->domain, XFS_HEALTHMON_DOMAIN_STRINGS),
+		  __entry->old_mask,
+		  __entry->new_mask,
+		  __entry->imask,
+		  __entry->ino,
+		  __entry->gen)
+);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index 3d50397f8f7c00..f243c06fd44762 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -108,14 +108,19 @@ xfs_fs_mark_sick(
 	struct xfs_mount	*mp,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_FS_ALL));
 	trace_xfs_fs_mark_sick(mp, mask);
 
 	spin_lock(&mp->m_sb_lock);
+	old_mask = mp->m_fs_sick;
 	mp->m_fs_sick |= mask;
 	spin_unlock(&mp->m_sb_lock);
 
 	fserror_report_metadata(mp->m_super, -EFSCORRUPTED, GFP_NOFS);
+	if (mask)
+		xfs_healthmon_report_fs(mp, XFS_HEALTHMON_SICK, old_mask, mask);
 }
 
 /* Mark per-fs metadata as having been checked and found unhealthy by fsck. */
@@ -124,15 +129,21 @@ xfs_fs_mark_corrupt(
 	struct xfs_mount	*mp,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_FS_ALL));
 	trace_xfs_fs_mark_corrupt(mp, mask);
 
 	spin_lock(&mp->m_sb_lock);
+	old_mask = mp->m_fs_sick;
 	mp->m_fs_sick |= mask;
 	mp->m_fs_checked |= mask;
 	spin_unlock(&mp->m_sb_lock);
 
 	fserror_report_metadata(mp->m_super, -EFSCORRUPTED, GFP_NOFS);
+	if (mask)
+		xfs_healthmon_report_fs(mp, XFS_HEALTHMON_CORRUPT, old_mask,
+				mask);
 }
 
 /* Mark a per-fs metadata healed. */
@@ -141,15 +152,22 @@ xfs_fs_mark_healthy(
 	struct xfs_mount	*mp,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_FS_ALL));
 	trace_xfs_fs_mark_healthy(mp, mask);
 
 	spin_lock(&mp->m_sb_lock);
+	old_mask = mp->m_fs_sick;
 	mp->m_fs_sick &= ~mask;
 	if (!(mp->m_fs_sick & XFS_SICK_FS_PRIMARY))
 		mp->m_fs_sick &= ~XFS_SICK_FS_SECONDARY;
 	mp->m_fs_checked |= mask;
 	spin_unlock(&mp->m_sb_lock);
+
+	if (mask)
+		xfs_healthmon_report_fs(mp, XFS_HEALTHMON_HEALTHY, old_mask,
+				mask);
 }
 
 /* Sample which per-fs metadata are unhealthy. */
@@ -199,14 +217,20 @@ xfs_group_mark_sick(
 	struct xfs_group	*xg,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	xfs_group_check_mask(xg, mask);
 	trace_xfs_group_mark_sick(xg, mask);
 
 	spin_lock(&xg->xg_state_lock);
+	old_mask = xg->xg_sick;
 	xg->xg_sick |= mask;
 	spin_unlock(&xg->xg_state_lock);
 
 	fserror_report_metadata(xg->xg_mount->m_super, -EFSCORRUPTED, GFP_NOFS);
+	if (mask)
+		xfs_healthmon_report_group(xg, XFS_HEALTHMON_SICK, old_mask,
+				mask);
 }
 
 /*
@@ -217,15 +241,21 @@ xfs_group_mark_corrupt(
 	struct xfs_group	*xg,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	xfs_group_check_mask(xg, mask);
 	trace_xfs_group_mark_corrupt(xg, mask);
 
 	spin_lock(&xg->xg_state_lock);
+	old_mask = xg->xg_sick;
 	xg->xg_sick |= mask;
 	xg->xg_checked |= mask;
 	spin_unlock(&xg->xg_state_lock);
 
 	fserror_report_metadata(xg->xg_mount->m_super, -EFSCORRUPTED, GFP_NOFS);
+	if (mask)
+		xfs_healthmon_report_group(xg, XFS_HEALTHMON_CORRUPT, old_mask,
+				mask);
 }
 
 /*
@@ -236,15 +266,22 @@ xfs_group_mark_healthy(
 	struct xfs_group	*xg,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	xfs_group_check_mask(xg, mask);
 	trace_xfs_group_mark_healthy(xg, mask);
 
 	spin_lock(&xg->xg_state_lock);
+	old_mask = xg->xg_sick;
 	xg->xg_sick &= ~mask;
 	if (!(xg->xg_sick & XFS_SICK_AG_PRIMARY))
 		xg->xg_sick &= ~XFS_SICK_AG_SECONDARY;
 	xg->xg_checked |= mask;
 	spin_unlock(&xg->xg_state_lock);
+
+	if (mask)
+		xfs_healthmon_report_group(xg, XFS_HEALTHMON_HEALTHY, old_mask,
+				mask);
 }
 
 /* Sample which per-ag metadata are unhealthy. */
@@ -283,10 +320,13 @@ xfs_inode_mark_sick(
 	struct xfs_inode	*ip,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_INO_ALL));
 	trace_xfs_inode_mark_sick(ip, mask);
 
 	spin_lock(&ip->i_flags_lock);
+	old_mask = ip->i_sick;
 	ip->i_sick |= mask;
 	spin_unlock(&ip->i_flags_lock);
 
@@ -300,6 +340,9 @@ xfs_inode_mark_sick(
 	spin_unlock(&VFS_I(ip)->i_lock);
 
 	fserror_report_file_metadata(VFS_I(ip), -EFSCORRUPTED, GFP_NOFS);
+	if (mask)
+		xfs_healthmon_report_inode(ip, XFS_HEALTHMON_SICK, old_mask,
+				mask);
 }
 
 /* Mark inode metadata as having been checked and found unhealthy by fsck. */
@@ -308,10 +351,13 @@ xfs_inode_mark_corrupt(
 	struct xfs_inode	*ip,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_INO_ALL));
 	trace_xfs_inode_mark_corrupt(ip, mask);
 
 	spin_lock(&ip->i_flags_lock);
+	old_mask = ip->i_sick;
 	ip->i_sick |= mask;
 	ip->i_checked |= mask;
 	spin_unlock(&ip->i_flags_lock);
@@ -326,6 +372,9 @@ xfs_inode_mark_corrupt(
 	spin_unlock(&VFS_I(ip)->i_lock);
 
 	fserror_report_file_metadata(VFS_I(ip), -EFSCORRUPTED, GFP_NOFS);
+	if (mask)
+		xfs_healthmon_report_inode(ip, XFS_HEALTHMON_CORRUPT, old_mask,
+				mask);
 }
 
 /* Mark parts of an inode healed. */
@@ -334,15 +383,22 @@ xfs_inode_mark_healthy(
 	struct xfs_inode	*ip,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_INO_ALL));
 	trace_xfs_inode_mark_healthy(ip, mask);
 
 	spin_lock(&ip->i_flags_lock);
+	old_mask = ip->i_sick;
 	ip->i_sick &= ~mask;
 	if (!(ip->i_sick & XFS_SICK_INO_PRIMARY))
 		ip->i_sick &= ~XFS_SICK_INO_SECONDARY;
 	ip->i_checked |= mask;
 	spin_unlock(&ip->i_flags_lock);
+
+	if (mask)
+		xfs_healthmon_report_inode(ip, XFS_HEALTHMON_HEALTHY, old_mask,
+				mask);
 }
 
 /* Sample which parts of an inode are unhealthy. */
@@ -422,6 +478,25 @@ xfs_fsop_geom_health(
 	}
 }
 
+/*
+ * Translate XFS_SICK_FS_* into XFS_FSOP_GEOM_SICK_* except for the rt free
+ * space codes, which are sent via the rtgroup events.
+ */
+unsigned int
+xfs_healthmon_fs_mask(
+	unsigned int			sick_mask)
+{
+	const struct ioctl_sick_map	*m;
+	unsigned int			ioctl_mask = 0;
+
+	for_each_sick_map(fs_map, m) {
+		if (sick_mask & m->sick_mask)
+			ioctl_mask |= m->ioctl_mask;
+	}
+
+	return ioctl_mask;
+}
+
 static const struct ioctl_sick_map ag_map[] = {
 	{ XFS_SICK_AG_SB,	XFS_AG_GEOM_SICK_SB },
 	{ XFS_SICK_AG_AGF,	XFS_AG_GEOM_SICK_AGF },
@@ -458,6 +533,22 @@ xfs_ag_geom_health(
 	}
 }
 
+/* Translate XFS_SICK_AG_* into XFS_AG_GEOM_SICK_*. */
+unsigned int
+xfs_healthmon_perag_mask(
+	unsigned int			sick_mask)
+{
+	const struct ioctl_sick_map	*m;
+	unsigned int			ioctl_mask = 0;
+
+	for_each_sick_map(ag_map, m) {
+		if (sick_mask & m->sick_mask)
+			ioctl_mask |= m->ioctl_mask;
+	}
+
+	return ioctl_mask;
+}
+
 static const struct ioctl_sick_map rtgroup_map[] = {
 	{ XFS_SICK_RG_SUPER,	XFS_RTGROUP_GEOM_SICK_SUPER },
 	{ XFS_SICK_RG_BITMAP,	XFS_RTGROUP_GEOM_SICK_BITMAP },
@@ -488,6 +579,22 @@ xfs_rtgroup_geom_health(
 	}
 }
 
+/* Translate XFS_SICK_RG_* into XFS_RTGROUP_GEOM_SICK_*. */
+unsigned int
+xfs_healthmon_rtgroup_mask(
+	unsigned int			sick_mask)
+{
+	const struct ioctl_sick_map	*m;
+	unsigned int			ioctl_mask = 0;
+
+	for_each_sick_map(rtgroup_map, m) {
+		if (sick_mask & m->sick_mask)
+			ioctl_mask |= m->ioctl_mask;
+	}
+
+	return ioctl_mask;
+}
+
 static const struct ioctl_sick_map ino_map[] = {
 	{ XFS_SICK_INO_CORE,	XFS_BS_SICK_INODE },
 	{ XFS_SICK_INO_BMBTD,	XFS_BS_SICK_BMBTD },
@@ -526,6 +633,22 @@ xfs_bulkstat_health(
 	}
 }
 
+/* Translate XFS_SICK_INO_* into XFS_BS_SICK_*. */
+unsigned int
+xfs_healthmon_inode_mask(
+	unsigned int			sick_mask)
+{
+	const struct ioctl_sick_map	*m;
+	unsigned int			ioctl_mask = 0;
+
+	for_each_sick_map(ino_map, m) {
+		if (sick_mask & m->sick_mask)
+			ioctl_mask |= m->ioctl_mask;
+	}
+
+	return ioctl_mask;
+}
+
 /* Mark a block mapping sick. */
 void
 xfs_bmap_mark_sick(
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 2a94f0a0bcd5c8..3e95170b15572a 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -18,6 +18,7 @@
 #include "xfs_da_btree.h"
 #include "xfs_quota_defs.h"
 #include "xfs_rtgroup.h"
+#include "xfs_health.h"
 #include "xfs_healthmon.h"
 
 #include <linux/anon_inodes.h>
@@ -213,6 +214,33 @@ xfs_healthmon_merge_events(
 	case XFS_HEALTHMON_LOST:
 		existing->lostcount += new->lostcount;
 		return true;
+
+	case XFS_HEALTHMON_SICK:
+	case XFS_HEALTHMON_CORRUPT:
+	case XFS_HEALTHMON_HEALTHY:
+		switch (existing->domain) {
+		case XFS_HEALTHMON_FS:
+			existing->fsmask |= new->fsmask;
+			return true;
+		case XFS_HEALTHMON_AG:
+		case XFS_HEALTHMON_RTGROUP:
+			if (existing->group == new->group){
+				existing->grpmask |= new->grpmask;
+				return true;
+			}
+			return false;
+		case XFS_HEALTHMON_INODE:
+			if (existing->ino == new->ino &&
+			    existing->gen == new->gen) {
+				existing->imask |= new->imask;
+				return true;
+			}
+			return false;
+		default:
+			ASSERT(0);
+			return false;
+		}
+		return false;
 	}
 
 	return false;
@@ -401,6 +429,135 @@ xfs_healthmon_unmount(
 	xfs_healthmon_put(hm);
 }
 
+/* Compute the reporting mask for non-unmount metadata health events. */
+static inline unsigned int
+metadata_event_mask(
+	struct xfs_healthmon		*hm,
+	enum xfs_healthmon_type		type,
+	unsigned int			old_mask,
+	unsigned int			new_mask)
+{
+	/* If we want all events, return all events. */
+	if (hm->verbose)
+		return new_mask;
+
+	switch (type) {
+	case XFS_HEALTHMON_SICK:
+		/* Always report runtime corruptions */
+		return new_mask;
+	case XFS_HEALTHMON_CORRUPT:
+		/* Only report new fsck errors */
+		return new_mask & ~old_mask;
+	case XFS_HEALTHMON_HEALTHY:
+		/* Only report healthy metadata that got fixed */
+		return new_mask & old_mask;
+	default:
+		ASSERT(0);
+		break;
+	}
+
+	return 0;
+}
+
+/* Report XFS_FS_SICK_* events to healthmon */
+void
+xfs_healthmon_report_fs(
+	struct xfs_mount		*mp,
+	enum xfs_healthmon_type		type,
+	unsigned int			old_mask,
+	unsigned int			new_mask)
+{
+	struct xfs_healthmon_event	event = {
+		.type			= type,
+		.domain			= XFS_HEALTHMON_FS,
+	};
+	struct xfs_healthmon		*hm = xfs_healthmon_get(mp);
+
+	if (!hm)
+		return;
+
+	event.fsmask = metadata_event_mask(hm, type, old_mask, new_mask) &
+			~XFS_SICK_FS_SECONDARY;
+	trace_xfs_healthmon_report_fs(hm, old_mask, new_mask, &event);
+
+	if (event.fsmask)
+		xfs_healthmon_push(hm, &event);
+
+	xfs_healthmon_put(hm);
+}
+
+/* Report XFS_SICK_(AG|RG)* flags to healthmon */
+void
+xfs_healthmon_report_group(
+	struct xfs_group		*xg,
+	enum xfs_healthmon_type		type,
+	unsigned int			old_mask,
+	unsigned int			new_mask)
+{
+	struct xfs_healthmon_event	event = {
+		.type			= type,
+		.group			= xg->xg_gno,
+	};
+	struct xfs_healthmon		*hm = xfs_healthmon_get(xg->xg_mount);
+
+	if (!hm)
+		return;
+
+	switch (xg->xg_type) {
+	case XG_TYPE_RTG:
+		event.domain = XFS_HEALTHMON_RTGROUP;
+		event.grpmask = metadata_event_mask(hm, type, old_mask,
+						    new_mask) &
+				~XFS_SICK_RG_SECONDARY;
+		break;
+	case XG_TYPE_AG:
+		event.domain = XFS_HEALTHMON_AG;
+		event.grpmask = metadata_event_mask(hm, type, old_mask,
+						    new_mask) &
+				~XFS_SICK_AG_SECONDARY;
+		break;
+	default:
+		ASSERT(0);
+		break;
+	}
+
+	trace_xfs_healthmon_report_group(hm, old_mask, new_mask, &event);
+
+	if (event.grpmask)
+		xfs_healthmon_push(hm, &event);
+
+	xfs_healthmon_put(hm);
+}
+
+/* Report XFS_SICK_INO_* flags to healthmon */
+void
+xfs_healthmon_report_inode(
+	struct xfs_inode		*ip,
+	enum xfs_healthmon_type		type,
+	unsigned int			old_mask,
+	unsigned int			new_mask)
+{
+	struct xfs_healthmon_event	event = {
+		.type			= type,
+		.domain			= XFS_HEALTHMON_INODE,
+		.ino			= ip->i_ino,
+		.gen			= VFS_I(ip)->i_generation,
+	};
+	struct xfs_healthmon		*hm = xfs_healthmon_get(ip->i_mount);
+
+	if (!hm)
+		return;
+
+	event.imask = metadata_event_mask(hm, type, old_mask, new_mask) &
+			~XFS_SICK_INO_SECONDARY;
+	trace_xfs_healthmon_report_inode(hm, old_mask, event.imask, &event);
+
+	if (event.imask)
+		xfs_healthmon_push(hm, &event);
+
+	xfs_healthmon_put(hm);
+}
+
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -411,11 +568,19 @@ xfs_healthmon_reset_outbuf(
 
 static const unsigned int domain_map[] = {
 	[XFS_HEALTHMON_MOUNT]		= XFS_HEALTH_MONITOR_DOMAIN_MOUNT,
+	[XFS_HEALTHMON_FS]		= XFS_HEALTH_MONITOR_DOMAIN_FS,
+	[XFS_HEALTHMON_AG]		= XFS_HEALTH_MONITOR_DOMAIN_AG,
+	[XFS_HEALTHMON_INODE]		= XFS_HEALTH_MONITOR_DOMAIN_INODE,
+	[XFS_HEALTHMON_RTGROUP]		= XFS_HEALTH_MONITOR_DOMAIN_RTGROUP,
 };
 
 static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_RUNNING]		= XFS_HEALTH_MONITOR_TYPE_RUNNING,
 	[XFS_HEALTHMON_LOST]		= XFS_HEALTH_MONITOR_TYPE_LOST,
+	[XFS_HEALTHMON_SICK]		= XFS_HEALTH_MONITOR_TYPE_SICK,
+	[XFS_HEALTHMON_CORRUPT]		= XFS_HEALTH_MONITOR_TYPE_CORRUPT,
+	[XFS_HEALTHMON_HEALTHY]		= XFS_HEALTH_MONITOR_TYPE_HEALTHY,
+	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
 };
 
 /* Render event as a V0 structure */
@@ -448,6 +613,22 @@ xfs_healthmon_format_v0(
 			break;
 		}
 		break;
+	case XFS_HEALTHMON_FS:
+		hme.e.fs.mask = xfs_healthmon_fs_mask(event->fsmask);
+		break;
+	case XFS_HEALTHMON_RTGROUP:
+		hme.e.group.mask = xfs_healthmon_rtgroup_mask(event->grpmask);
+		hme.e.group.gno = event->group;
+		break;
+	case XFS_HEALTHMON_AG:
+		hme.e.group.mask = xfs_healthmon_perag_mask(event->grpmask);
+		hme.e.group.gno = event->group;
+		break;
+	case XFS_HEALTHMON_INODE:
+		hme.e.inode.mask = xfs_healthmon_inode_mask(event->imask);
+		hme.e.inode.ino = event->ino;
+		hme.e.inode.gen = event->gen;
+		break;
 	default:
 		break;
 	}


