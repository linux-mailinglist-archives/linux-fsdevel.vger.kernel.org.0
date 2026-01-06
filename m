Return-Path: <linux-fsdevel+bounces-72423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB4CF6FF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8263F302629A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0EE309EEB;
	Tue,  6 Jan 2026 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHt3oEGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160672C0307;
	Tue,  6 Jan 2026 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683532; cv=none; b=O2dLGuE6qFnEsOC8CWE6naX8BIY24wK3JqHga5tZIv67fv5o7qcRFE5cOi8SOfgd00ofARK6xwpV+G45DgYU66T24JUYehjjFpA+LCG1HSKdIUB06pHqwhHOGqCA8OsVQJAnCHKt4Az2+uFnic9ovrXJTSkZD4d4KAaZUcZCdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683532; c=relaxed/simple;
	bh=SHBZAX/RBzLA2HuDsf/Cz0+BBPk/ZgiZsAyEEZfDYbU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUaA4GTwXCnzI8M9vGDj+0nWKuG3FEe8i0AR/h5ZoCIIJsDfwjvP615S4prruhxKcxTFE5DR9LF5hAnkK/uK4JEX9+c6BeMoiUJ43df/WpAeMYIl9mdRtIXOdtAwofUSSiJS75tMjgf5kGKlp1T3fvn2cSndXuaobaNGD8LQYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHt3oEGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D4AC116C6;
	Tue,  6 Jan 2026 07:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683531;
	bh=SHBZAX/RBzLA2HuDsf/Cz0+BBPk/ZgiZsAyEEZfDYbU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nHt3oEGcv66Z13660jEYn08mC73kd+AcBRs/9PGLljcEBSU5ibQ1vmzoTtYyRdHPl
	 HQSdvsiOxGkhpuzz4fZ/Qq3CsWMmcISolIrjDFCuiyJwAi8Tln5i0Wd/IylkOBfh5X
	 qQBn1NmYxAKKv2mbWnhrIkh+eCwOXOaT82s853eYl6BfzIhVol/oANe8PKEMbmidCF
	 58pjkQzuN91s7Sp0RC3fMBNGjCr6AzRzVZSbQhh7lBLPPlc3urc113EOYkptJrsXV1
	 kBSi6Slyydq1x/1OZUff9rDTR0z46oCTdFnvQvZl+HkJf73kX3RhiF60ZekXrT3ENc
	 6msrmC+O8yj0A==
Date: Mon, 05 Jan 2026 23:12:11 -0800
Subject: [PATCH 06/11] xfs: convey filesystem shutdown events to the health
 monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176766637377.774337.7062414022538883299.stgit@frogsfrogsfrogs>
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

Connect the filesystem shutdown code to the health monitor so that xfs
can send events about that to the xfs_healer daemon.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   18 ++++++++++++
 fs/xfs/xfs_healthmon.h |    7 ++++-
 fs/xfs/xfs_trace.h     |   23 +++++++++++++++-
 fs/xfs/xfs_fsops.c     |   15 +++++-----
 fs/xfs/xfs_healthmon.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+), 9 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index ae788d5eb3d398..2d6ba6060c09c8 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1028,6 +1028,9 @@ struct xfs_rtgroup_geometry {
 #define XFS_HEALTH_MONITOR_TYPE_CORRUPT		(4)
 #define XFS_HEALTH_MONITOR_TYPE_HEALTHY		(5)
 
+/* filesystem shutdown */
+#define XFS_HEALTH_MONITOR_TYPE_SHUTDOWN	(6)
+
 /* lost events */
 struct xfs_health_monitor_lost {
 	__u64	count;
@@ -1054,6 +1057,20 @@ struct xfs_health_monitor_inode {
 	__u64	ino;
 };
 
+/* shutdown reasons */
+#define XFS_HEALTH_SHUTDOWN_META_IO_ERROR	(1u << 0)
+#define XFS_HEALTH_SHUTDOWN_LOG_IO_ERROR	(1u << 1)
+#define XFS_HEALTH_SHUTDOWN_FORCE_UMOUNT	(1u << 2)
+#define XFS_HEALTH_SHUTDOWN_CORRUPT_INCORE	(1u << 3)
+#define XFS_HEALTH_SHUTDOWN_CORRUPT_ONDISK	(1u << 4)
+#define XFS_HEALTH_SHUTDOWN_DEVICE_REMOVED	(1u << 5)
+
+/* shutdown */
+struct xfs_health_monitor_shutdown {
+	/* XFS_HEALTH_SHUTDOWN_* flags */
+	__u32	reasons;
+};
+
 struct xfs_health_monitor_event {
 	/* XFS_HEALTH_MONITOR_DOMAIN_* */
 	__u32	domain;
@@ -1074,6 +1091,7 @@ struct xfs_health_monitor_event {
 		struct xfs_health_monitor_fs fs;
 		struct xfs_health_monitor_group group;
 		struct xfs_health_monitor_inode inode;
+		struct xfs_health_monitor_shutdown shutdown;
 	} e;
 
 	/* zeroes */
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index 4632fa873ec087..542e37069c6f56 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -69,6 +69,9 @@ enum xfs_healthmon_type {
 	XFS_HEALTHMON_LOST,	/* message lost */
 	XFS_HEALTHMON_UNMOUNT,	/* filesystem is unmounting */
 
+	/* filesystem shutdown */
+	XFS_HEALTHMON_SHUTDOWN,
+
 	/* metadata health events */
 	XFS_HEALTHMON_SICK,	/* runtime corruption observed */
 	XFS_HEALTHMON_CORRUPT,	/* fsck reported corruption */
@@ -98,7 +101,7 @@ struct xfs_healthmon_event {
 		struct {
 			uint64_t	lostcount;
 		};
-		/* mount */
+		/* shutdown */
 		struct {
 			unsigned int	flags;
 		};
@@ -133,6 +136,8 @@ void xfs_healthmon_report_inode(struct xfs_inode *ip,
 		enum xfs_healthmon_type type, unsigned int old_mask,
 		unsigned int new_mask);
 
+void xfs_healthmon_report_shutdown(struct xfs_mount *mp, uint32_t flags);
+
 long xfs_ioc_health_monitor(struct file *file,
 		struct xfs_health_monitor __user *arg);
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index debe9846418a04..ec99a6d3dd318c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6012,7 +6012,8 @@ DEFINE_HEALTHMON_EVENT(xfs_healthmon_report_unmount);
 	{ XFS_HEALTHMON_UNMOUNT,	"unmount" }, \
 	{ XFS_HEALTHMON_SICK,		"sick" }, \
 	{ XFS_HEALTHMON_CORRUPT,	"corrupt" }, \
-	{ XFS_HEALTHMON_HEALTHY,	"healthy" }
+	{ XFS_HEALTHMON_HEALTHY,	"healthy" }, \
+	{ XFS_HEALTHMON_SHUTDOWN,	"shutdown" }
 
 #define XFS_HEALTHMON_DOMAIN_STRINGS \
 	{ XFS_HEALTHMON_MOUNT,		"mount" }, \
@@ -6022,6 +6023,7 @@ DEFINE_HEALTHMON_EVENT(xfs_healthmon_report_unmount);
 	{ XFS_HEALTHMON_RTGROUP,	"rtgroup" }
 
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_LOST);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_SHUTDOWN);
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_UNMOUNT);
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_SICK);
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_CORRUPT);
@@ -6063,6 +6065,9 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
 		switch (__entry->domain) {
 		case XFS_HEALTHMON_MOUNT:
 			switch (__entry->type) {
+			case XFS_HEALTHMON_SHUTDOWN:
+				__entry->mask = event->flags;
+				break;
 			case XFS_HEALTHMON_LOST:
 				__entry->lostcount = event->lostcount;
 				break;
@@ -6207,6 +6212,22 @@ TRACE_EVENT(xfs_healthmon_report_inode,
 		  __entry->gen)
 );
 
+TRACE_EVENT(xfs_healthmon_report_shutdown,
+	TP_PROTO(const struct xfs_healthmon *hm, uint32_t shutdown_flags),
+	TP_ARGS(hm, shutdown_flags),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(uint32_t, shutdown_flags)
+	),
+	TP_fast_assign(
+		__entry->dev = hm->dev;
+		__entry->shutdown_flags = shutdown_flags;
+	),
+	TP_printk("dev %d:%d shutdown_flags %s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_flags(__entry->shutdown_flags, "|", XFS_SHUTDOWN_STRINGS))
+);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index b7c21f68edc78d..63be01a9443cb0 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -25,6 +25,7 @@
 #include "xfs_rtrmap_btree.h"
 #include "xfs_rtrefcount_btree.h"
 #include "xfs_metafile.h"
+#include "xfs_healthmon.h"
 
 #include <linux/fserror.h>
 
@@ -497,14 +498,13 @@ xfs_fs_goingdown(
  */
 void
 xfs_do_force_shutdown(
-	struct xfs_mount *mp,
-	uint32_t	flags,
-	char		*fname,
-	int		lnnum)
+	struct xfs_mount	*mp,
+	uint32_t		flags,
+	char			*fname,
+	int			lnnum)
 {
-	int		tag;
-	const char	*why;
-
+	int			tag;
+	const char		*why;
 
 	if (xfs_set_shutdown(mp)) {
 		xlog_shutdown_wait(mp->m_log);
@@ -544,6 +544,7 @@ xfs_do_force_shutdown(
 		xfs_stack_trace();
 
 	fserror_report_shutdown(mp->m_super, GFP_KERNEL);
+	xfs_healthmon_report_shutdown(mp, flags);
 }
 
 /*
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 3e95170b15572a..2077b50c41b1ab 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -20,6 +20,7 @@
 #include "xfs_rtgroup.h"
 #include "xfs_health.h"
 #include "xfs_healthmon.h"
+#include "xfs_fsops.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -241,6 +242,11 @@ xfs_healthmon_merge_events(
 			return false;
 		}
 		return false;
+
+	case XFS_HEALTHMON_SHUTDOWN:
+		/* yes, we can race to shutdown */
+		existing->flags |= new->flags;
+		return true;
 	}
 
 	return false;
@@ -558,6 +564,28 @@ xfs_healthmon_report_inode(
 	xfs_healthmon_put(hm);
 }
 
+/* Add a shutdown event to the reporting queue. */
+void
+xfs_healthmon_report_shutdown(
+	struct xfs_mount		*mp,
+	uint32_t			flags)
+{
+	struct xfs_healthmon_event	event = {
+		.type			= XFS_HEALTHMON_SHUTDOWN,
+		.domain			= XFS_HEALTHMON_MOUNT,
+		.flags			= flags,
+	};
+	struct xfs_healthmon		*hm = xfs_healthmon_get(mp);
+
+	if (!hm)
+		return;
+
+	trace_xfs_healthmon_report_shutdown(hm, flags);
+
+	xfs_healthmon_push(hm, &event);
+	xfs_healthmon_put(hm);
+}
+
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -566,6 +594,44 @@ xfs_healthmon_reset_outbuf(
 	hm->bufhead = 0;
 }
 
+struct flags_map {
+	unsigned int		in_mask;
+	unsigned int		out_mask;
+};
+
+static const struct flags_map shutdown_map[] = {
+	{ SHUTDOWN_META_IO_ERROR,	XFS_HEALTH_SHUTDOWN_META_IO_ERROR },
+	{ SHUTDOWN_LOG_IO_ERROR,	XFS_HEALTH_SHUTDOWN_LOG_IO_ERROR },
+	{ SHUTDOWN_FORCE_UMOUNT,	XFS_HEALTH_SHUTDOWN_FORCE_UMOUNT },
+	{ SHUTDOWN_CORRUPT_INCORE,	XFS_HEALTH_SHUTDOWN_CORRUPT_INCORE },
+	{ SHUTDOWN_CORRUPT_ONDISK,	XFS_HEALTH_SHUTDOWN_CORRUPT_ONDISK },
+	{ SHUTDOWN_DEVICE_REMOVED,	XFS_HEALTH_SHUTDOWN_DEVICE_REMOVED },
+};
+
+static inline unsigned int
+__map_flags(
+	const struct flags_map	*map,
+	size_t			array_len,
+	unsigned int		flags)
+{
+	const struct flags_map	*m;
+	unsigned int		ret = 0;
+
+	for (m = map; m < map + array_len; m++) {
+		if (flags & m->in_mask)
+			ret |= m->out_mask;
+	}
+
+	return ret;
+}
+
+#define map_flags(map, flags) __map_flags((map), ARRAY_SIZE(map), (flags))
+
+static inline unsigned int shutdown_mask(unsigned int in)
+{
+	return map_flags(shutdown_map, in);
+}
+
 static const unsigned int domain_map[] = {
 	[XFS_HEALTHMON_MOUNT]		= XFS_HEALTH_MONITOR_DOMAIN_MOUNT,
 	[XFS_HEALTHMON_FS]		= XFS_HEALTH_MONITOR_DOMAIN_FS,
@@ -581,6 +647,7 @@ static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_CORRUPT]		= XFS_HEALTH_MONITOR_TYPE_CORRUPT,
 	[XFS_HEALTHMON_HEALTHY]		= XFS_HEALTH_MONITOR_TYPE_HEALTHY,
 	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
+	[XFS_HEALTHMON_SHUTDOWN]	= XFS_HEALTH_MONITOR_TYPE_SHUTDOWN,
 };
 
 /* Render event as a V0 structure */
@@ -609,6 +676,9 @@ xfs_healthmon_format_v0(
 		case XFS_HEALTHMON_LOST:
 			hme.e.lost.count = event->lostcount;
 			break;
+		case XFS_HEALTHMON_SHUTDOWN:
+			hme.e.shutdown.reasons = shutdown_mask(event->flags);
+			break;
 		default:
 			break;
 		}


