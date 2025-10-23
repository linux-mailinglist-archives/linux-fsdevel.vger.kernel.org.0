Return-Path: <linux-fsdevel+bounces-65259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DBBBFEA8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CED294F97B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5888228373;
	Thu, 23 Oct 2025 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYCLq0ZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6479F2;
	Thu, 23 Oct 2025 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177840; cv=none; b=oahMagJ5PltJKTPQTFM3OVfb5XqDtBHZ4wKA3qs0vknKTlcJa6H/hJVxA79VnFcquy7fm4QqzccW8EejTyZV3lAYLMsNGdL/0QWlT2HKBGWgOgTXMQci9+TgpKusMNdyrKO1oBh3bz/kQGLWIqxgzQXyRrsJY13y28aE4pfWnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177840; c=relaxed/simple;
	bh=7AJ6IMSTELrHobwWNUiz39XKyYlSPTuTwUVtr4XH/7Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3sKwqCTMHPpFQlbGFvD/Os6T5OSYmud5jdJSBsIgRUMOlRIMVLbftJ4Emit9CfA7x/A2b4XxGVa/ovPdr9Pq872P54p4uEjj26pyDYWR4FC3BvoWDytRR4y1k/8E+hBCYSUpS7aM9MJHy9QZxKoRzhR/JizN3k8HdnLDo764ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYCLq0ZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CBBC4CEE7;
	Thu, 23 Oct 2025 00:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177840;
	bh=7AJ6IMSTELrHobwWNUiz39XKyYlSPTuTwUVtr4XH/7Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qYCLq0ZVOAidp7W/E9QpdB48cbywDfS03yqGTIK1l73XFOTCIiAYjBpdnVNUKcGRu
	 SPhQbTTbvcvcaiQC1kTaV9AktpoAGNhUJhRVJpw/Zl430+JMZV412awLY3jWTc6h6G
	 Pya6tczu4iUhONDWB+W4B6rEPudA5k4zSMd5jrM28gyMRvz/kDiaIfhud43IbgFE+5
	 6leTnOdumMmjznLbr3YYbOKqpYORjrL22qzfr5S9a1KQ+WYT79d5LzQguwLMgInm/V
	 8GBbwC/wa8FY87VbfIPbq3IeBYOYIUMW6gu6w2Ls3PjHTz0P6WBVtHLZko9vfpzY16
	 Z1TtMyR+M4E8Q==
Date: Wed, 22 Oct 2025 17:04:00 -0700
Subject: [PATCH 13/19] xfs: report shutdown events through healthmon
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744783.1025409.6589243500564810135.stgit@frogsfrogsfrogs>
In-Reply-To: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
References: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Set up a shutdown hook so that we can send notifications to userspace.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h                  |   18 +++++
 fs/xfs/xfs_healthmon.h                  |    5 +
 fs/xfs/xfs_trace.h                      |   28 +++++++
 fs/xfs/libxfs/xfs_healthmon.schema.json |   62 ++++++++++++++++
 fs/xfs/xfs_healthmon.c                  |  119 ++++++++++++++++++++++++++++++-
 5 files changed, 229 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 358abe98776d69..918362a7294f27 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1028,6 +1028,9 @@ struct xfs_rtgroup_geometry {
 /* filesystem was unmounted */
 #define XFS_HEALTH_MONITOR_TYPE_UNMOUNT		(5)
 
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
index 3f3ba16d5af56a..a82a684bbc0e03 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -11,6 +11,9 @@ enum xfs_healthmon_type {
 	XFS_HEALTHMON_LOST,	/* message lost */
 	XFS_HEALTHMON_UNMOUNT,	/* filesystem is unmounting */
 
+	/* filesystem shutdown */
+	XFS_HEALTHMON_SHUTDOWN,
+
 	/* metadata health events */
 	XFS_HEALTHMON_SICK,	/* runtime corruption observed */
 	XFS_HEALTHMON_CORRUPT,	/* fsck reported corruption */
@@ -41,7 +44,7 @@ struct xfs_healthmon_event {
 		struct {
 			uint64_t	lostcount;
 		};
-		/* mount */
+		/* shutdown */
 		struct {
 			unsigned int	flags;
 		};
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index df09c225e13c2e..e39138293c2782 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6010,8 +6010,32 @@ DEFINE_HEALTHMON_EVENT(xfs_healthmon_read_finish);
 DEFINE_HEALTHMON_EVENT(xfs_healthmon_release);
 DEFINE_HEALTHMON_EVENT(xfs_healthmon_unmount);
 
+TRACE_EVENT(xfs_healthmon_shutdown_hook,
+	TP_PROTO(const struct xfs_mount *mp, uint32_t shutdown_flags,
+		 unsigned int events, unsigned long long lost_prev),
+	TP_ARGS(mp, shutdown_flags, events, lost_prev),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(uint32_t, shutdown_flags)
+		__field(unsigned int, events)
+		__field(unsigned long long, lost_prev)
+	),
+	TP_fast_assign(
+		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->shutdown_flags = shutdown_flags;
+		__entry->events = events;
+		__entry->lost_prev = lost_prev;
+	),
+	TP_printk("dev %d:%d shutdown_flags %s events %u lost_prev? %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_flags(__entry->shutdown_flags, "|", XFS_SHUTDOWN_STRINGS),
+		  __entry->events,
+		  __entry->lost_prev)
+);
+
 #define XFS_HEALTHMON_TYPE_STRINGS \
 	{ XFS_HEALTHMON_LOST,		"lost" }, \
+	{ XFS_HEALTHMON_SHUTDOWN,	"shutdown" }, \
 	{ XFS_HEALTHMON_UNMOUNT,	"unmount" }, \
 	{ XFS_HEALTHMON_SICK,		"sick" }, \
 	{ XFS_HEALTHMON_CORRUPT,	"corrupt" }, \
@@ -6025,6 +6049,7 @@ DEFINE_HEALTHMON_EVENT(xfs_healthmon_unmount);
 	{ XFS_HEALTHMON_RTGROUP,	"rtgroup" }
 
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_LOST);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_SHUTDOWN);
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_UNMOUNT);
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_SICK);
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_CORRUPT);
@@ -6065,6 +6090,9 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
 		switch (__entry->domain) {
 		case XFS_HEALTHMON_MOUNT:
 			switch (__entry->type) {
+			case XFS_HEALTHMON_SHUTDOWN:
+				__entry->mask = event->flags;
+				break;
 			case XFS_HEALTHMON_LOST:
 				__entry->lostcount = event->lostcount;
 				break;
diff --git a/fs/xfs/libxfs/xfs_healthmon.schema.json b/fs/xfs/libxfs/xfs_healthmon.schema.json
index dd78f1b71d587b..1657ccc482edff 100644
--- a/fs/xfs/libxfs/xfs_healthmon.schema.json
+++ b/fs/xfs/libxfs/xfs_healthmon.schema.json
@@ -36,6 +36,9 @@
 		},
 		{
 			"$ref": "#/$events/inode_metadata"
+		},
+		{
+			"$ref": "#/$events/shutdown"
 		}
 	],
 
@@ -204,6 +207,31 @@
 		}
 	},
 
+	"$comment": "Shutdown event data are defined here.",
+	"$shutdown": {
+		"reason": {
+			"description": [
+				"Reason for a filesystem to shut down.",
+				"Options include:",
+				"",
+				" * corrupt_incore: in-memory corruption",
+				" * corrupt_ondisk: on-disk corruption",
+				" * device_removed: device removed",
+				" * force_umount:   userspace asked for it",
+				" * log_ioerr:      log write IO error",
+				" * meta_ioerr:     metadata writeback IO error"
+			],
+			"enum": [
+				"corrupt_incore",
+				"corrupt_ondisk",
+				"device_removed",
+				"force_umount",
+				"log_ioerr",
+				"meta_ioerr"
+			]
+		}
+	},
+
 	"$comment": "Event types are defined here.",
 	"$events": {
 		"running": {
@@ -439,6 +467,40 @@
 				"generation",
 				"structures"
 			]
+		},
+		"shutdown": {
+			"title": "Abnormal Shutdown Event",
+			"description": [
+				"The filesystem went offline due to",
+				"unrecoverable errors."
+			],
+			"type": "object",
+
+			"properties": {
+				"type": {
+					"const": "shutdown"
+				},
+				"time_ns": {
+					"$ref": "#/$defs/time_ns"
+				},
+				"domain": {
+					"const": "mount"
+				},
+				"reasons": {
+					"type": "array",
+					"items": {
+						"$ref": "#/$shutdown/reason"
+					},
+					"minItems": 1
+				}
+			},
+
+			"required": [
+				"type",
+				"time_ns",
+				"domain",
+				"reasons"
+			]
 		}
 	}
 }
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 05c67fe40f2bac..76de516708e8f9 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -20,6 +20,7 @@
 #include "xfs_rtgroup.h"
 #include "xfs_health.h"
 #include "xfs_healthmon.h"
+#include "xfs_fsops.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -67,6 +68,7 @@ struct xfs_healthmon {
 	struct xfs_healthmon_event	*last_event;
 
 	/* live update hooks */
+	struct xfs_shutdown_hook	shook;
 	struct xfs_health_hook		hhook;
 
 	/* filesystem mount, or NULL if we've unmounted */
@@ -482,6 +484,43 @@ xfs_healthmon_metadata_hook(
 	goto out_unlock;
 }
 
+/* Add a shutdown event to the reporting queue. */
+STATIC int
+xfs_healthmon_shutdown_hook(
+	struct notifier_block		*nb,
+	unsigned long			action,
+	void				*data)
+{
+	struct xfs_healthmon		*hm;
+	struct xfs_healthmon_event	*event;
+	int				error;
+
+	hm = container_of(nb, struct xfs_healthmon, shook.shutdown_hook.nb);
+
+	mutex_lock(&hm->lock);
+
+	trace_xfs_healthmon_shutdown_hook(hm->mp, action, hm->events,
+			hm->lost_prev_event);
+
+	error = xfs_healthmon_start_live_update(hm);
+	if (error)
+		goto out_unlock;
+
+	event = xfs_healthmon_alloc(hm, XFS_HEALTHMON_SHUTDOWN,
+			XFS_HEALTHMON_MOUNT);
+	if (!event)
+		goto out_unlock;
+
+	event->flags = action;
+	error = xfs_healthmon_push(hm, event);
+	if (error)
+		kfree(event);
+
+out_unlock:
+	mutex_unlock(&hm->lock);
+	return NOTIFY_DONE;
+}
+
 /* Render the health update type as a string. */
 STATIC const char *
 xfs_healthmon_typestring(
@@ -490,6 +529,7 @@ xfs_healthmon_typestring(
 	static const char *type_strings[] = {
 		[XFS_HEALTHMON_RUNNING]		= "running",
 		[XFS_HEALTHMON_LOST]		= "lost",
+		[XFS_HEALTHMON_SHUTDOWN]	= "shutdown",
 		[XFS_HEALTHMON_UNMOUNT]		= "unmount",
 		[XFS_HEALTHMON_SICK]		= "sick",
 		[XFS_HEALTHMON_CORRUPT]		= "corrupt",
@@ -700,6 +740,25 @@ xfs_healthmon_format_inode(
 			event->gen);
 }
 
+/* Render shutdown mask as a string set */
+static int
+xfs_healthmon_format_shutdown(
+	struct seq_buf			*outbuf,
+	const struct xfs_healthmon_event *event)
+{
+	static const struct flag_string	mask_strings[] = {
+		{ SHUTDOWN_META_IO_ERROR,	"meta_ioerr" },
+		{ SHUTDOWN_LOG_IO_ERROR,	"log_ioerr" },
+		{ SHUTDOWN_FORCE_UMOUNT,	"force_umount" },
+		{ SHUTDOWN_CORRUPT_INCORE,	"corrupt_incore" },
+		{ SHUTDOWN_CORRUPT_ONDISK,	"corrupt_ondisk" },
+		{ SHUTDOWN_DEVICE_REMOVED,	"device_removed" },
+	};
+
+	return xfs_healthmon_format_mask(outbuf, "reasons", mask_strings,
+			event->flags);
+}
+
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -757,6 +816,9 @@ xfs_healthmon_format_json(
 		case XFS_HEALTHMON_LOST:
 			ret = xfs_healthmon_format_lost(outbuf, event);
 			break;
+		case XFS_HEALTHMON_SHUTDOWN:
+			ret = xfs_healthmon_format_shutdown(outbuf, event);
+			break;
 		default:
 			break;
 		}
@@ -799,6 +861,44 @@ xfs_healthmon_format_json(
 	return -1;
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
@@ -814,6 +914,7 @@ static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_CORRUPT]		= XFS_HEALTH_MONITOR_TYPE_CORRUPT,
 	[XFS_HEALTHMON_HEALTHY]		= XFS_HEALTH_MONITOR_TYPE_HEALTHY,
 	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
+	[XFS_HEALTHMON_SHUTDOWN]	= XFS_HEALTH_MONITOR_TYPE_SHUTDOWN,
 };
 
 /* Render event as a C structure */
@@ -845,6 +946,9 @@ xfs_healthmon_format_cstruct(
 		case XFS_HEALTHMON_LOST:
 			hme.e.lost.count = event->lostcount;
 			break;
+		case XFS_HEALTHMON_SHUTDOWN:
+			hme.e.shutdown.reasons = shutdown_mask(event->flags);
+			break;
 		default:
 			break;
 		}
@@ -1137,6 +1241,7 @@ xfs_healthmon_detach_hooks(
 	 * through the health monitoring subsystem from xfs_fs_put_super, so
 	 * it is now time to detach the hooks.
 	 */
+	xfs_shutdown_hook_del(hm->mp, &hm->shook);
 	xfs_health_hook_del(hm->mp, &hm->hhook);
 	return;
 
@@ -1157,6 +1262,7 @@ xfs_healthmon_release(
 	wake_up_all(&hm->wait);
 
 	iterate_supers_type(hm->fstyp, xfs_healthmon_detach_hooks, hm);
+	xfs_shutdown_hook_disable();
 	xfs_health_hook_disable();
 
 	mutex_destroy(&hm->lock);
@@ -1280,6 +1386,7 @@ xfs_ioc_health_monitor(
 
 	/* Enable hooks to receive events, generally. */
 	xfs_health_hook_enable();
+	xfs_shutdown_hook_enable();
 
 	/* Attach specific event hooks to this monitor. */
 	xfs_health_hook_setup(&hm->hhook, xfs_healthmon_metadata_hook);
@@ -1287,12 +1394,17 @@ xfs_ioc_health_monitor(
 	if (ret)
 		goto out_hooks;
 
+	xfs_shutdown_hook_setup(&hm->shook, xfs_healthmon_shutdown_hook);
+	ret = xfs_shutdown_hook_add(mp, &hm->shook);
+	if (ret)
+		goto out_healthhook;
+
 	/* Queue up the first event that lets the client know we're running. */
 	event = xfs_healthmon_alloc(hm, XFS_HEALTHMON_RUNNING,
 			XFS_HEALTHMON_MOUNT);
 	if (!event) {
 		ret = -ENOMEM;
-		goto out_healthhook;
+		goto out_shutdownhook;
 	}
 	__xfs_healthmon_push(hm, event);
 
@@ -1304,17 +1416,20 @@ xfs_ioc_health_monitor(
 			O_CLOEXEC | O_RDONLY);
 	if (fd < 0) {
 		ret = fd;
-		goto out_healthhook;
+		goto out_shutdownhook;
 	}
 
 	trace_xfs_healthmon_create(mp, hmo.flags, hmo.format);
 
 	return fd;
 
+out_shutdownhook:
+	xfs_shutdown_hook_del(mp, &hm->shook);
 out_healthhook:
 	xfs_health_hook_del(mp, &hm->hhook);
 out_hooks:
 	xfs_health_hook_disable();
+	xfs_shutdown_hook_disable();
 	mutex_destroy(&hm->lock);
 	xfs_healthmon_free_events(hm);
 	kfree(hm);


