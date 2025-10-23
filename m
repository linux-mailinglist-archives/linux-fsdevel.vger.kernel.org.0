Return-Path: <linux-fsdevel+bounces-65260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC09BFEA93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492E6189BBCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52BA927;
	Thu, 23 Oct 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1VPkrYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DBA1FDA;
	Thu, 23 Oct 2025 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177856; cv=none; b=hSyzBzE1dVXFqx19ihBKxLdLqC8Nnhllci6aYBu+kuLYWfOE4uXZMZem7kKaYzJtNSnwxjkcuPmROaEvcigQwgyXDN4ZFySgWk/ZBQv9m+Sq+QR6evbvllivY2J7JjqSmIzWFLRIo39hUROMNWdEBOtIE1T4S9b40Fx2EbdpH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177856; c=relaxed/simple;
	bh=2qKzmtX85WkPpTKFj9BPiLXFZd9iRdQUSiUPnvXS6yM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtuuWMykDFIV0AuJ8y6Y6+Jg4DcVIkdHhItkuZTc2VzvRkv1okBBnCeEpGbWVbadeYkeHFWYgMtXV5gdJ1dV63QH8jQDtYl9GD6xBT/I6vf1oNJvO/CTDDsZO0j1IAwanlibTz/kzRWhCmtaeLzK8fQt7IOZJKVUzzRL8tDcj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1VPkrYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECD6C4CEE7;
	Thu, 23 Oct 2025 00:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177856;
	bh=2qKzmtX85WkPpTKFj9BPiLXFZd9iRdQUSiUPnvXS6yM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=u1VPkrYjgH4k8qrb1qnsxLnHfeqi3vJZYVXKhmDywhLnUnHxC2EVaDdCzfzslUcuQ
	 ROHAWWLh5gAXbv3VMsMAc6k6xjOgke6ixRUzfypBHxdKpwDju+DzcvGpogC/6aenRE
	 eWnrExsutdHsWPPX05q+FAztJK+242gXQe3U9jEzgd7yNPqBXRRsOp0H3lzsbtommg
	 NYNRK1AjjhFqtWduGXiquqkt0ctT2sBixpzQ6pDI1dBnUer/16WQRL99TSPi9rTTzu
	 z+4ihB3zdMeQS15DxWgMQc8ocb8jl75BDT1/yIDeJlVwgaO6J/5vlmf8wvQB0PuL4U
	 U80xvMXfuWFFw==
Date: Wed, 22 Oct 2025 17:04:15 -0700
Subject: [PATCH 14/19] xfs: report media errors through healthmon
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744805.1025409.9824521193352979910.stgit@frogsfrogsfrogs>
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

Now that we have hooks to report media errors, connect this to the
health monitor as well.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h                  |   15 ++++
 fs/xfs/xfs_healthmon.h                  |   12 ++++
 fs/xfs/xfs_trace.h                      |   57 +++++++++++++++++
 fs/xfs/libxfs/xfs_healthmon.schema.json |   65 +++++++++++++++++++
 fs/xfs/xfs_healthmon.c                  |  106 ++++++++++++++++++++++++++++++-
 fs/xfs/xfs_trace.c                      |    1 
 6 files changed, 254 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 918362a7294f27..a551b1d5d0db58 100644
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
index e39138293c2782..11d70e3792493a 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -105,6 +105,7 @@ struct xfs_rtgroup;
 struct xfs_open_zone;
 struct xfs_healthmon_event;
 struct xfs_health_update_params;
+struct xfs_media_error_params;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -6111,6 +6112,12 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
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
@@ -6199,6 +6206,56 @@ TRACE_EVENT(xfs_healthmon_metadata_hook,
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
diff --git a/fs/xfs/libxfs/xfs_healthmon.schema.json b/fs/xfs/libxfs/xfs_healthmon.schema.json
index 1657ccc482edff..d3b537a040cb83 100644
--- a/fs/xfs/libxfs/xfs_healthmon.schema.json
+++ b/fs/xfs/libxfs/xfs_healthmon.schema.json
@@ -39,6 +39,9 @@
 		},
 		{
 			"$ref": "#/$events/shutdown"
+		},
+		{
+			"$ref": "#/$events/media_error"
 		}
 	],
 
@@ -75,6 +78,31 @@
 		"i_generation": {
 			"description": "Inode generation number",
 			"type": "integer"
+		},
+		"storage_devs": {
+			"description": "Storage devices in a filesystem",
+			"_comment": [
+				"One of:",
+				"",
+				" * datadev: filesystem device",
+				" * logdev:  external log device",
+				" * rtdev:   realtime volume"
+			],
+			"enum": [
+				"datadev",
+				"logdev",
+				"rtdev"
+			]
+		},
+		"xfs_daddr_t": {
+			"description": "Storage device address, in units of 512-byte blocks",
+			"type": "integer",
+			"minimum": 0
+		},
+		"bbcount": {
+			"description": "Storage space length, in units of 512-byte blocks",
+			"type": "integer",
+			"minimum": 1
 		}
 	},
 
@@ -501,6 +529,43 @@
 				"domain",
 				"reasons"
 			]
+		},
+		"media_error": {
+			"title": "Media Error",
+			"description": [
+				"A storage device reported a media error.",
+				"The domain element tells us which storage",
+				"device reported the media failure.  The",
+				"daddr and bbcount elements tell us where",
+				"inside that device the failure was observed."
+			],
+			"type": "object",
+
+			"properties": {
+				"type": {
+					"const": "media"
+				},
+				"time_ns": {
+					"$ref": "#/$defs/time_ns"
+				},
+				"domain": {
+					"$ref": "#/$defs/storage_devs"
+				},
+				"daddr": {
+					"$ref": "#/$defs/xfs_daddr_t"
+				},
+				"bbcount": {
+					"$ref": "#/$defs/bbcount"
+				}
+			},
+
+			"required": [
+				"type",
+				"time_ns",
+				"domain",
+				"daddr",
+				"bbcount"
+			]
 		}
 	}
 }
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 76de516708e8f9..52b8be8eb7a11b 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -21,6 +21,7 @@
 #include "xfs_health.h"
 #include "xfs_healthmon.h"
 #include "xfs_fsops.h"
+#include "xfs_notify_failure.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -70,6 +71,7 @@ struct xfs_healthmon {
 	/* live update hooks */
 	struct xfs_shutdown_hook	shook;
 	struct xfs_health_hook		hhook;
+	struct xfs_media_error_hook	mhook;
 
 	/* filesystem mount, or NULL if we've unmounted */
 	struct xfs_mount		*mp;
@@ -521,6 +523,59 @@ xfs_healthmon_shutdown_hook(
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
 /* Render the health update type as a string. */
 STATIC const char *
 xfs_healthmon_typestring(
@@ -534,6 +589,7 @@ xfs_healthmon_typestring(
 		[XFS_HEALTHMON_SICK]		= "sick",
 		[XFS_HEALTHMON_CORRUPT]		= "corrupt",
 		[XFS_HEALTHMON_HEALTHY]		= "healthy",
+		[XFS_HEALTHMON_MEDIA_ERROR]	= "media",
 	};
 
 	if (event->type >= ARRAY_SIZE(type_strings))
@@ -553,6 +609,9 @@ xfs_healthmon_domstring(
 		[XFS_HEALTHMON_AG]		= "perag",
 		[XFS_HEALTHMON_INODE]		= "inode",
 		[XFS_HEALTHMON_RTGROUP]		= "rtgroup",
+		[XFS_HEALTHMON_DATADEV]		= "datadev",
+		[XFS_HEALTHMON_LOGDEV]		= "logdev",
+		[XFS_HEALTHMON_RTDEV]		= "rtdev",
 	};
 
 	if (event->domain >= ARRAY_SIZE(dom_strings))
@@ -759,6 +818,23 @@ xfs_healthmon_format_shutdown(
 			event->flags);
 }
 
+/* Render media error as a string set */
+static int
+xfs_healthmon_format_media_error(
+	struct seq_buf			*outbuf,
+	const struct xfs_healthmon_event *event)
+{
+	ssize_t				ret;
+
+	ret = seq_buf_printf(outbuf, "  \"daddr\":      %llu,\n",
+			event->daddr);
+	if (ret < 0)
+		return ret;
+
+	return seq_buf_printf(outbuf, "  \"bbcount\":    %llu,\n",
+			event->bbcount);
+}
+
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -835,6 +911,11 @@ xfs_healthmon_format_json(
 	case XFS_HEALTHMON_INODE:
 		ret = xfs_healthmon_format_inode(outbuf, event);
 		break;
+	case XFS_HEALTHMON_DATADEV:
+	case XFS_HEALTHMON_LOGDEV:
+	case XFS_HEALTHMON_RTDEV:
+		ret = xfs_healthmon_format_media_error(outbuf, event);
+		break;
 	}
 	if (ret < 0)
 		goto overrun;
@@ -905,6 +986,9 @@ static const unsigned int domain_map[] = {
 	[XFS_HEALTHMON_AG]		= XFS_HEALTH_MONITOR_DOMAIN_AG,
 	[XFS_HEALTHMON_INODE]		= XFS_HEALTH_MONITOR_DOMAIN_INODE,
 	[XFS_HEALTHMON_RTGROUP]		= XFS_HEALTH_MONITOR_DOMAIN_RTGROUP,
+	[XFS_HEALTHMON_DATADEV]		= XFS_HEALTH_MONITOR_DOMAIN_DATADEV,
+	[XFS_HEALTHMON_RTDEV]		= XFS_HEALTH_MONITOR_DOMAIN_RTDEV,
+	[XFS_HEALTHMON_LOGDEV]		= XFS_HEALTH_MONITOR_DOMAIN_LOGDEV,
 };
 
 static const unsigned int type_map[] = {
@@ -915,6 +999,7 @@ static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_HEALTHY]		= XFS_HEALTH_MONITOR_TYPE_HEALTHY,
 	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
 	[XFS_HEALTHMON_SHUTDOWN]	= XFS_HEALTH_MONITOR_TYPE_SHUTDOWN,
+	[XFS_HEALTHMON_MEDIA_ERROR]	= XFS_HEALTH_MONITOR_TYPE_MEDIA_ERROR,
 };
 
 /* Render event as a C structure */
@@ -969,6 +1054,12 @@ xfs_healthmon_format_cstruct(
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
@@ -1241,6 +1332,7 @@ xfs_healthmon_detach_hooks(
 	 * through the health monitoring subsystem from xfs_fs_put_super, so
 	 * it is now time to detach the hooks.
 	 */
+	xfs_media_error_hook_del(hm->mp, &hm->mhook);
 	xfs_shutdown_hook_del(hm->mp, &hm->shook);
 	xfs_health_hook_del(hm->mp, &hm->hhook);
 	return;
@@ -1262,6 +1354,7 @@ xfs_healthmon_release(
 	wake_up_all(&hm->wait);
 
 	iterate_supers_type(hm->fstyp, xfs_healthmon_detach_hooks, hm);
+	xfs_media_error_hook_disable();
 	xfs_shutdown_hook_disable();
 	xfs_health_hook_disable();
 
@@ -1387,6 +1480,7 @@ xfs_ioc_health_monitor(
 	/* Enable hooks to receive events, generally. */
 	xfs_health_hook_enable();
 	xfs_shutdown_hook_enable();
+	xfs_media_error_hook_enable();
 
 	/* Attach specific event hooks to this monitor. */
 	xfs_health_hook_setup(&hm->hhook, xfs_healthmon_metadata_hook);
@@ -1399,12 +1493,17 @@ xfs_ioc_health_monitor(
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
 
@@ -1416,18 +1515,21 @@ xfs_ioc_health_monitor(
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
 	xfs_health_hook_del(mp, &hm->hhook);
 out_hooks:
+	xfs_media_error_hook_disable();
 	xfs_health_hook_disable();
 	xfs_shutdown_hook_disable();
 	mutex_destroy(&hm->lock);
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


