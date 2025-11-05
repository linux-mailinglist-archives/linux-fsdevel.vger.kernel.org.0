Return-Path: <linux-fsdevel+bounces-67037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C6C338CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7794C3A7F23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902AE23D2B4;
	Wed,  5 Nov 2025 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXcLA0xn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6623BF9B;
	Wed,  5 Nov 2025 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303925; cv=none; b=GznKU54KqrTnGYJTX23CnE8tKrke0LrncJ3rQjdn3sJjpJFYyZ8HghLArsE0ZOVCIyEkpDLF6nfzR/vWsMEZ/BRZiAofYrqwmhmMx05rXGZf43yQuvez7TBGT2QxxPvIbNdcqYvv96lcbV9B7od4b8srcxm6KsYZdFDUcNKWwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303925; c=relaxed/simple;
	bh=NOXmAaiOr96MjPpi4ejXdVyRvorZS1rMM00+dgFNM3E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZluM5adb+nEFNBf9bTyAXQ20+YRuTmrt2N25QvN3yuAcbWYGEbEjRYbxTR69B18DVIIiqg/s2O94WHvuAXWj13o8zbOP5lKXagBE4O7MP8secc9CUE4ghcXsJp15IAxwGjR82Gcjiqh0H8v5LKriN3aekqnTZ6rVA17+NR84WhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXcLA0xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7F0C4CEF7;
	Wed,  5 Nov 2025 00:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303924;
	bh=NOXmAaiOr96MjPpi4ejXdVyRvorZS1rMM00+dgFNM3E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DXcLA0xnarG9Bx/5IWpRuK+FQ0oLmtGpSUvz4iq7vulWK1EI6MUwL6vV6dzQDXVXF
	 PQESFUZd968AIAPssK9O4YYR6P+qRzjGcDmXyiBSAchJsjh7jASOslexIqHyLNClPD
	 LP0Et4eeqpTI8iMdMZeABKTE8ywskVuerwlJjEf2cDp9wYBbW2DVO/PHv+Xsf+1KLz
	 BBrE0aKDvlCx2VFjtVjGVFsCeNbXtzaSlJ1K3l3ignC5b6dv51IHMQ90dvH/bEYP8y
	 rlofMyJ3JY6iF+Mx8rjMdEz6kjMZk1dfi9eaI2r+iC0Pd8/+0D/ZuYzguLkIuGUWls
	 zHQ5d57iZcINg==
Date: Tue, 04 Nov 2025 16:52:04 -0800
Subject: [PATCH 14/22] xfs: report media errors through healthmon
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230365996.1647136.2802369697217516949.stgit@frogsfrogsfrogs>
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

Now that we have hooks to report media errors, connect this to the
health monitor as well.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   15 +++++++++
 fs/xfs/xfs_healthmon.h |   12 +++++++
 fs/xfs/xfs_trace.h     |   57 ++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_healthmon.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_trace.c     |    1 +
 5 files changed, 160 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 677141a17605a4..0711007344e16d 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1014,6 +1014,11 @@ struct xfs_rtgroup_geometry {
 #define XFS_HEALTH_MONITOR_DOMAIN_INODE		(3)
 #define XFS_HEALTH_MONITOR_DOMAIN_RTGROUP	(4)
 
+/* disk events */
+#define XFS_HEALTH_MONITOR_DOMAIN_DATADEV	(5)
+#define XFS_HEALTH_MONITOR_DOMAIN_RTDEV		(6)
+#define XFS_HEALTH_MONITOR_DOMAIN_LOGDEV	(7)
+
 /* Health monitor event types */
 
 /* status of the monitor itself */
@@ -1031,6 +1036,9 @@ struct xfs_rtgroup_geometry {
 /* filesystem shutdown */
 #define XFS_HEALTH_MONITOR_TYPE_SHUTDOWN	(6)
 
+/* media errors */
+#define XFS_HEALTH_MONITOR_TYPE_MEDIA_ERROR	(7)
+
 /* lost events */
 struct xfs_health_monitor_lost {
 	__u64	count;
@@ -1071,6 +1079,12 @@ struct xfs_health_monitor_shutdown {
 	__u32	reasons;
 };
 
+/* disk media errors */
+struct xfs_health_monitor_media {
+	__u64	daddr;
+	__u64	bbcount;
+};
+
 struct xfs_health_monitor_event {
 	/* XFS_HEALTH_MONITOR_DOMAIN_* */
 	__u32	domain;
@@ -1092,6 +1106,7 @@ struct xfs_health_monitor_event {
 		struct xfs_health_monitor_group group;
 		struct xfs_health_monitor_inode inode;
 		struct xfs_health_monitor_shutdown shutdown;
+		struct xfs_health_monitor_media media;
 	} e;
 
 	/* zeroes */
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index a82a684bbc0e03..407c5e1f466726 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -19,6 +19,8 @@ enum xfs_healthmon_type {
 	XFS_HEALTHMON_CORRUPT,	/* fsck reported corruption */
 	XFS_HEALTHMON_HEALTHY,	/* fsck reported healthy structure */
 
+	/* media errors */
+	XFS_HEALTHMON_MEDIA_ERROR,
 };
 
 enum xfs_healthmon_domain {
@@ -29,6 +31,11 @@ enum xfs_healthmon_domain {
 	XFS_HEALTHMON_AG,	/* allocation group metadata */
 	XFS_HEALTHMON_INODE,	/* inode metadata */
 	XFS_HEALTHMON_RTGROUP,	/* realtime group metadata */
+
+	/* media errors */
+	XFS_HEALTHMON_DATADEV,
+	XFS_HEALTHMON_RTDEV,
+	XFS_HEALTHMON_LOGDEV,
 };
 
 struct xfs_healthmon_event {
@@ -66,6 +73,11 @@ struct xfs_healthmon_event {
 			uint32_t	gen;
 			xfs_ino_t	ino;
 		};
+		/* media errors */
+		struct {
+			xfs_daddr_t	daddr;
+			uint64_t	bbcount;
+		};
 	};
 };
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index b2b056ceb52f5c..79805ee9aa64f5 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -105,6 +105,7 @@ struct xfs_rtgroup;
 struct xfs_open_zone;
 struct xfs_healthmon_event;
 struct xfs_health_update_params;
+struct xfs_media_error_params;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -6110,6 +6111,12 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
 			__entry->ino = event->ino;
 			__entry->gen = event->gen;
 			break;
+		case XFS_HEALTHMON_DATADEV:
+		case XFS_HEALTHMON_LOGDEV:
+		case XFS_HEALTHMON_RTDEV:
+			__entry->offset = event->daddr;
+			__entry->length = event->bbcount;
+			break;
 		}
 	),
 	TP_printk("dev %d:%d type %s domain %s mask 0x%x ino 0x%llx gen 0x%x offset 0x%llx len 0x%llx group 0x%x lost %llu",
@@ -6198,6 +6205,56 @@ TRACE_EVENT(xfs_healthmon_metadata_hook,
 		  __entry->events,
 		  __entry->lost_prev)
 );
+
+#if defined(CONFIG_XFS_LIVE_HOOKS) && defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
+TRACE_EVENT(xfs_healthmon_media_error_hook,
+	TP_PROTO(const struct xfs_media_error_params *p,
+		 unsigned int events, unsigned long long lost_prev),
+	TP_ARGS(p, events, lost_prev),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(dev_t, error_dev)
+		__field(uint64_t, daddr)
+		__field(uint64_t, bbcount)
+		__field(int, pre_remove)
+		__field(unsigned int, events)
+		__field(unsigned long long, lost_prev)
+	),
+	TP_fast_assign(
+		struct xfs_mount	*mp = p->mp;
+		struct xfs_buftarg	*btp = NULL;
+
+		switch (p->fdev) {
+		case XFS_FAILED_DATADEV:
+			btp = mp->m_ddev_targp;
+			break;
+		case XFS_FAILED_LOGDEV:
+			btp = mp->m_logdev_targp;
+			break;
+		case XFS_FAILED_RTDEV:
+			btp = mp->m_rtdev_targp;
+			break;
+		}
+
+		__entry->dev = mp->m_super->s_dev;
+		if (btp)
+			__entry->error_dev = btp->bt_dev;
+		__entry->daddr = p->daddr;
+		__entry->bbcount = p->bbcount;
+		__entry->pre_remove = p->pre_remove;
+		__entry->events = events;
+		__entry->lost_prev = lost_prev;
+	),
+	TP_printk("dev %d:%d error_dev %d:%d daddr 0x%llx bbcount 0x%llx pre_remove? %d events %u lost_prev? %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  MAJOR(__entry->error_dev), MINOR(__entry->error_dev),
+		  __entry->daddr,
+		  __entry->bbcount,
+		  __entry->pre_remove,
+		  __entry->events,
+		  __entry->lost_prev)
+);
+#endif
 #endif /* CONFIG_XFS_HEALTH_MONITOR */
 
 #endif /* _TRACE_XFS_H */
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index f36d7fbfb1ca16..efc8ff554e42da 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -21,6 +21,7 @@
 #include "xfs_health.h"
 #include "xfs_healthmon.h"
 #include "xfs_fsops.h"
+#include "xfs_notify_failure.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -67,6 +68,7 @@ struct xfs_healthmon {
 	/* live update hooks */
 	struct xfs_shutdown_hook	shook;
 	struct xfs_health_hook		hhook;
+	struct xfs_media_error_hook	mhook;
 
 	/* filesystem mount, or NULL if we've unmounted */
 	struct xfs_mount		*mp;
@@ -518,6 +520,59 @@ xfs_healthmon_shutdown_hook(
 	return NOTIFY_DONE;
 }
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
+/* Add a media error event to the reporting queue. */
+STATIC int
+xfs_healthmon_media_error_hook(
+	struct notifier_block		*nb,
+	unsigned long			action,
+	void				*data)
+{
+	struct xfs_healthmon		*hm;
+	struct xfs_healthmon_event	*event;
+	struct xfs_media_error_params	*p = data;
+	enum xfs_healthmon_domain	domain = 0; /* shut up gcc */
+	int				error;
+
+	hm = container_of(nb, struct xfs_healthmon, mhook.error_hook.nb);
+
+	mutex_lock(&hm->lock);
+
+	trace_xfs_healthmon_media_error_hook(p, hm->events,
+			hm->lost_prev_event);
+
+	error = xfs_healthmon_start_live_update(hm);
+	if (error)
+		goto out_unlock;
+
+	switch (p->fdev) {
+	case XFS_FAILED_LOGDEV:
+		domain = XFS_HEALTHMON_LOGDEV;
+		break;
+	case XFS_FAILED_RTDEV:
+		domain = XFS_HEALTHMON_RTDEV;
+		break;
+	case XFS_FAILED_DATADEV:
+		domain = XFS_HEALTHMON_DATADEV;
+		break;
+	}
+
+	event = xfs_healthmon_alloc(hm, XFS_HEALTHMON_MEDIA_ERROR, domain);
+	if (!event)
+		goto out_unlock;
+
+	event->daddr = p->daddr;
+	event->bbcount = p->bbcount;
+	error = xfs_healthmon_push(hm, event);
+	if (error)
+		kfree(event);
+
+out_unlock:
+	mutex_unlock(&hm->lock);
+	return NOTIFY_DONE;
+}
+#endif
+
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -570,6 +625,9 @@ static const unsigned int domain_map[] = {
 	[XFS_HEALTHMON_AG]		= XFS_HEALTH_MONITOR_DOMAIN_AG,
 	[XFS_HEALTHMON_INODE]		= XFS_HEALTH_MONITOR_DOMAIN_INODE,
 	[XFS_HEALTHMON_RTGROUP]		= XFS_HEALTH_MONITOR_DOMAIN_RTGROUP,
+	[XFS_HEALTHMON_DATADEV]		= XFS_HEALTH_MONITOR_DOMAIN_DATADEV,
+	[XFS_HEALTHMON_RTDEV]		= XFS_HEALTH_MONITOR_DOMAIN_RTDEV,
+	[XFS_HEALTHMON_LOGDEV]		= XFS_HEALTH_MONITOR_DOMAIN_LOGDEV,
 };
 
 static const unsigned int type_map[] = {
@@ -580,6 +638,7 @@ static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_HEALTHY]		= XFS_HEALTH_MONITOR_TYPE_HEALTHY,
 	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
 	[XFS_HEALTHMON_SHUTDOWN]	= XFS_HEALTH_MONITOR_TYPE_SHUTDOWN,
+	[XFS_HEALTHMON_MEDIA_ERROR]	= XFS_HEALTH_MONITOR_TYPE_MEDIA_ERROR,
 };
 
 /* Render event as a V0 structure */
@@ -634,6 +693,12 @@ xfs_healthmon_format_v0(
 		hme.e.inode.ino = event->ino;
 		hme.e.inode.gen = event->gen;
 		break;
+	case XFS_HEALTHMON_DATADEV:
+	case XFS_HEALTHMON_LOGDEV:
+	case XFS_HEALTHMON_RTDEV:
+		hme.e.media.daddr = event->daddr;
+		hme.e.media.bbcount = event->bbcount;
+		break;
 	default:
 		break;
 	}
@@ -903,6 +968,7 @@ xfs_healthmon_detach_hooks(
 	 * through the health monitoring subsystem from xfs_fs_put_super, so
 	 * it is now time to detach the hooks.
 	 */
+	xfs_media_error_hook_del(hm->mp, &hm->mhook);
 	xfs_shutdown_hook_del(hm->mp, &hm->shook);
 	xfs_health_hook_del(hm->mp, &hm->hhook);
 	return;
@@ -1056,12 +1122,17 @@ xfs_ioc_health_monitor(
 	if (ret)
 		goto out_healthhook;
 
+	xfs_media_error_hook_setup(&hm->mhook, xfs_healthmon_media_error_hook);
+	ret = xfs_media_error_hook_add(mp, &hm->mhook);
+	if (ret)
+		goto out_shutdownhook;
+
 	/* Queue up the first event that lets the client know we're running. */
 	event = xfs_healthmon_alloc(hm, XFS_HEALTHMON_RUNNING,
 			XFS_HEALTHMON_MOUNT);
 	if (!event) {
 		ret = -ENOMEM;
-		goto out_shutdownhook;
+		goto out_mediahook;
 	}
 	__xfs_healthmon_push(hm, event);
 
@@ -1073,13 +1144,15 @@ xfs_ioc_health_monitor(
 			O_CLOEXEC | O_RDONLY);
 	if (fd < 0) {
 		ret = fd;
-		goto out_shutdownhook;
+		goto out_mediahook;
 	}
 
 	trace_xfs_healthmon_create(mp, hmo.flags, hmo.format);
 
 	return fd;
 
+out_mediahook:
+	xfs_media_error_hook_del(mp, &hm->mhook);
 out_shutdownhook:
 	xfs_shutdown_hook_del(mp, &hm->shook);
 out_healthhook:
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index d42b864a3837a2..08ddab700a6cd3 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -53,6 +53,7 @@
 #include "xfs_zone_priv.h"
 #include "xfs_health.h"
 #include "xfs_healthmon.h"
+#include "xfs_notify_failure.h"
 
 /*
  * We include this last to have the helpers above available for the trace


