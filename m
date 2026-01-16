Return-Path: <linux-fsdevel+bounces-74053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA85AD2C193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 06:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7D09302177C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 05:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746C347BC1;
	Fri, 16 Jan 2026 05:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISmKIxSS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CAE33F8A4;
	Fri, 16 Jan 2026 05:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542216; cv=none; b=tedk+nV4su5mlsEUH8gkOBKnSIplmjoU12rhNLaNzAbXKc9T7hq1tJpi+C+TGjvyDjTAEEeC3636Dz+3IoC1QKNORgQfx1CeKNg3c4cRUXGXGLZaQkljPI8LVfJUBpjU+YlIQQMknC6jBLwbl2MJ5Pag+Ycu8qVzWJWXiC6RnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542216; c=relaxed/simple;
	bh=0Xk9zheMly7Gg7VRbAPqTM3wipkgWQgVRIvtl3521YQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+zejr8Ui5/BilHtP7ElApyTxmna/h02N75ReheXAXVlyFCC2us+dvyaxcmA76eomf1XeBor1J6dLjeG95ZFKUKqgjGfb0x7ediYDfMZQsS0t4rnTfqq0ZNn1XmUH82MTMNw3sD6MQZEjs8b36yDKm51pFa+k53BqK2MdAyb63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISmKIxSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC9DC116C6;
	Fri, 16 Jan 2026 05:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768542215;
	bh=0Xk9zheMly7Gg7VRbAPqTM3wipkgWQgVRIvtl3521YQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ISmKIxSSdWovJrniV+dmjo7SUb6AxJFiAWZ4JepeEdW1luZrLaxWDDNSRjTVUxIVw
	 nLj2HhE9CtorDmmNWH/PTnVscFKlFMQb6wK4bTrT9MX2nRlCXrnIckgZJoy8EL7+ez
	 IvO2Agw5zLRqPyvYRUEsVkTvIY1QqEMJULz4PFSPuUQatct4drHOK9GWxa86GrIPMZ
	 qSvxxnCsYEVKCwWnW51Lv924HcFeKrR8n6koPQGICS0IUcG0Is4hFioRmGzv1vuw2C
	 1bXwOV0l54BIFaK/ahx8rSn+psWZimV7jqBBxVatjdFxXZZJBYS81sMqHgAysiNSyP
	 vJlO/HN/AO2pA==
Date: Thu, 15 Jan 2026 21:43:35 -0800
Subject: [PATCH 06/11] xfs: convey filesystem shutdown events to the health
 monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de
Message-ID: <176852588670.2137143.7251435441992863871.stgit@frogsfrogsfrogs>
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

Connect the filesystem shutdown code to the health monitor so that xfs
can send events about that to the xfs_healer daemon.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   18 ++++++++++++
 fs/xfs/xfs_healthmon.h |    9 ++++++
 fs/xfs/xfs_trace.h     |   23 +++++++++++++++-
 fs/xfs/xfs_fsops.c     |    2 +
 fs/xfs/xfs_healthmon.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 04e1dcf61257d0..c8f7011a7ef8ef 100644
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
index 121e5942639524..1f68b5d65a8edc 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -72,6 +72,9 @@ enum xfs_healthmon_type {
 	XFS_HEALTHMON_LOST,	/* message lost */
 	XFS_HEALTHMON_UNMOUNT,	/* filesystem is unmounting */
 
+	/* filesystem shutdown */
+	XFS_HEALTHMON_SHUTDOWN,
+
 	/* metadata health events */
 	XFS_HEALTHMON_SICK,	/* runtime corruption observed */
 	XFS_HEALTHMON_CORRUPT,	/* fsck reported corruption */
@@ -119,6 +122,10 @@ struct xfs_healthmon_event {
 			uint32_t	gen;
 			xfs_ino_t	ino;
 		};
+		/* shutdown */
+		struct {
+			unsigned int	flags;
+		};
 	};
 };
 
@@ -132,6 +139,8 @@ void xfs_healthmon_report_inode(struct xfs_inode *ip,
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
index b7c21f68edc78d..368173bf8a4091 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -25,6 +25,7 @@
 #include "xfs_rtrmap_btree.h"
 #include "xfs_rtrefcount_btree.h"
 #include "xfs_metafile.h"
+#include "xfs_healthmon.h"
 
 #include <linux/fserror.h>
 
@@ -544,6 +545,7 @@ xfs_do_force_shutdown(
 		xfs_stack_trace();
 
 	fserror_report_shutdown(mp->m_super, GFP_KERNEL);
+	xfs_healthmon_report_shutdown(mp, flags);
 }
 
 /*
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 0039a79822e86a..97f764e7954152 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -20,6 +20,7 @@
 #include "xfs_rtgroup.h"
 #include "xfs_health.h"
 #include "xfs_healthmon.h"
+#include "xfs_fsops.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -202,6 +203,11 @@ xfs_healthmon_merge_events(
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
@@ -494,6 +500,28 @@ xfs_healthmon_report_inode(
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
@@ -502,6 +530,44 @@ xfs_healthmon_reset_outbuf(
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
@@ -517,6 +583,7 @@ static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_CORRUPT]		= XFS_HEALTH_MONITOR_TYPE_CORRUPT,
 	[XFS_HEALTHMON_HEALTHY]		= XFS_HEALTH_MONITOR_TYPE_HEALTHY,
 	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
+	[XFS_HEALTHMON_SHUTDOWN]	= XFS_HEALTH_MONITOR_TYPE_SHUTDOWN,
 };
 
 /* Render event as a V0 structure */
@@ -545,6 +612,9 @@ xfs_healthmon_format_v0(
 		case XFS_HEALTHMON_LOST:
 			hme.e.lost.count = event->lostcount;
 			break;
+		case XFS_HEALTHMON_SHUTDOWN:
+			hme.e.shutdown.reasons = shutdown_mask(event->flags);
+			break;
 		default:
 			break;
 		}


