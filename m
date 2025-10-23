Return-Path: <linux-fsdevel+bounces-65261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD93BFEA9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1610B3A2FED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A48022615;
	Thu, 23 Oct 2025 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFJDI/Ww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5915F256D;
	Thu, 23 Oct 2025 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177872; cv=none; b=U9siMvTU3BTwPR3XOVzkBvXIWplmAcv8zZ8UG23ixSlq+mDkzGYrHWGveS2JXEeqeLQ+3LCy0lxVSqnaWR+v2IcAlGPabDDKoq1mh3BKDoJN0tlQv1xKOHcScbHrmG4XxZzN19uxmiIz8m1YNTmTn8Vak7e+zy2nC5EwX2moSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177872; c=relaxed/simple;
	bh=EIW25vfAIiTqTvFNtx5invbD/L9lBawAccl2hYsJS20=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i15vuTdQLfMN02OL+7cZ8ox5wbD9//y3bhZJFVhULgot6NsdEjIUvzs/+ppra6/dyxyCXblcOOEYikPBoKAkodiYO3hac+FAB2ytxbJ70e6QlP2fXPgzhHWs+TMhKCUNlQdae/zXXMtG6/IYl+Pkhh82LZiHINwsszCnDhIsoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFJDI/Ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAFBC4CEFF;
	Thu, 23 Oct 2025 00:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177871;
	bh=EIW25vfAIiTqTvFNtx5invbD/L9lBawAccl2hYsJS20=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oFJDI/WwyUHfANU9vLZJLmINeWlFGJA1Xk/7mLkoups2rXzgvlmXhEkoIWO0S0Wr7
	 iv60Hawe+uZ82fmTRDR2j6gLQkjwhmtKy+mreUbb+pUiETc6QCET237k9lPeJv01kl
	 vTxoGGtsdtZsbRi4P6QF1vsFuSWRbbcQyIIr8IvcR/3fStnXiRszAWNOXmxmI6nP6V
	 bijgbSQk5xzN8YysTdAdZwA8HvlIi/JT8adGsp7NGq6QHnFX1f8oK7wvHvfuSKmBPN
	 1ess0gYIK8nRyYXsU5iW3U0YcI1aKo7ymnD+FqOuv2Kw9ddPL9mddZjxvrqWScX5Wy
	 j67Bj5jkEjVZQ==
Date: Wed, 22 Oct 2025 17:04:31 -0700
Subject: [PATCH 15/19] xfs: report file io errors through healthmon
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744827.1025409.3830090657080637637.stgit@frogsfrogsfrogs>
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

Set up a file io error event hook so that we can send events about read
errors, writeback errors, and directio errors to userspace.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h                  |   18 ++++
 fs/xfs/xfs_healthmon.h                  |   16 ++++
 fs/xfs/xfs_trace.h                      |   56 +++++++++++++
 fs/xfs/libxfs/xfs_healthmon.schema.json |   77 ++++++++++++++++++
 fs/xfs/xfs_healthmon.c                  |  131 +++++++++++++++++++++++++++++++
 fs/xfs/xfs_trace.c                      |    1 
 6 files changed, 297 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index a551b1d5d0db58..87e915baa875d6 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1019,6 +1019,9 @@ struct xfs_rtgroup_geometry {
 #define XFS_HEALTH_MONITOR_DOMAIN_RTDEV		(6)
 #define XFS_HEALTH_MONITOR_DOMAIN_LOGDEV	(7)
 
+/* file range events */
+#define XFS_HEALTH_MONITOR_DOMAIN_FILERANGE	(8)
+
 /* Health monitor event types */
 
 /* status of the monitor itself */
@@ -1039,6 +1042,12 @@ struct xfs_rtgroup_geometry {
 /* media errors */
 #define XFS_HEALTH_MONITOR_TYPE_MEDIA_ERROR	(7)
 
+/* file range events */
+#define XFS_HEALTH_MONITOR_TYPE_BUFREAD		(8)
+#define XFS_HEALTH_MONITOR_TYPE_BUFWRITE	(9)
+#define XFS_HEALTH_MONITOR_TYPE_DIOREAD		(10)
+#define XFS_HEALTH_MONITOR_TYPE_DIOWRITE	(11)
+
 /* lost events */
 struct xfs_health_monitor_lost {
 	__u64	count;
@@ -1079,6 +1088,14 @@ struct xfs_health_monitor_shutdown {
 	__u32	reasons;
 };
 
+/* file range events */
+struct xfs_health_monitor_filerange {
+	__u64	pos;
+	__u64	len;
+	__u64	ino;
+	__u32	gen;
+};
+
 /* disk media errors */
 struct xfs_health_monitor_media {
 	__u64	daddr;
@@ -1107,6 +1124,7 @@ struct xfs_health_monitor_event {
 		struct xfs_health_monitor_inode inode;
 		struct xfs_health_monitor_shutdown shutdown;
 		struct xfs_health_monitor_media media;
+		struct xfs_health_monitor_filerange filerange;
 	} e;
 
 	/* zeroes */
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index 407c5e1f466726..421b46f97df482 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -21,6 +21,12 @@ enum xfs_healthmon_type {
 
 	/* media errors */
 	XFS_HEALTHMON_MEDIA_ERROR,
+
+	/* file range events */
+	XFS_HEALTHMON_BUFREAD,
+	XFS_HEALTHMON_BUFWRITE,
+	XFS_HEALTHMON_DIOREAD,
+	XFS_HEALTHMON_DIOWRITE,
 };
 
 enum xfs_healthmon_domain {
@@ -36,6 +42,9 @@ enum xfs_healthmon_domain {
 	XFS_HEALTHMON_DATADEV,
 	XFS_HEALTHMON_RTDEV,
 	XFS_HEALTHMON_LOGDEV,
+
+	/* file range events */
+	XFS_HEALTHMON_FILERANGE,
 };
 
 struct xfs_healthmon_event {
@@ -78,6 +87,13 @@ struct xfs_healthmon_event {
 			xfs_daddr_t	daddr;
 			uint64_t	bbcount;
 		};
+		/* file range events */
+		struct {
+			xfs_ino_t	fino;
+			loff_t		fpos;
+			uint64_t	flen;
+			uint32_t	fgen;
+		};
 	};
 };
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 11d70e3792493a..b23f3c41db1c03 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -106,6 +106,7 @@ struct xfs_open_zone;
 struct xfs_healthmon_event;
 struct xfs_health_update_params;
 struct xfs_media_error_params;
+struct xfs_file_ioerror_params;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -6118,6 +6119,12 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
 			__entry->offset = event->daddr;
 			__entry->length = event->bbcount;
 			break;
+		case XFS_HEALTHMON_FILERANGE:
+			__entry->ino = event->fino;
+			__entry->gen = event->fgen;
+			__entry->offset = event->fpos;
+			__entry->length = event->flen;
+			break;
 		}
 	),
 	TP_printk("dev %d:%d type %s domain %s mask 0x%x ino 0x%llx gen 0x%x offset 0x%llx len 0x%llx group 0x%x lost %llu",
@@ -6256,6 +6263,55 @@ TRACE_EVENT(xfs_healthmon_media_error_hook,
 		  __entry->lost_prev)
 );
 #endif
+
+#define XFS_FILE_IOERROR_STRINGS \
+	{ XFS_FILE_IOERROR_BUFFERED_READ,	"readahead" }, \
+	{ XFS_FILE_IOERROR_BUFFERED_WRITE,	"writeback" }, \
+	{ XFS_FILE_IOERROR_DIRECT_READ,		"directio_read" }, \
+	{ XFS_FILE_IOERROR_DIRECT_WRITE,	"directio_write" }
+
+TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_BUFFERED_READ);
+TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_BUFFERED_WRITE);
+TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_DIRECT_READ);
+TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_DIRECT_WRITE);
+
+TRACE_EVENT(xfs_healthmon_file_ioerror_hook,
+	TP_PROTO(const struct xfs_mount *mp,
+		 unsigned long action,
+		 const struct xfs_file_ioerror_params *p,
+		 unsigned int events, unsigned long long lost_prev),
+	TP_ARGS(mp, action, p, events, lost_prev),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(dev_t, error_dev)
+		__field(unsigned long, action)
+		__field(unsigned long long, ino)
+		__field(unsigned int, gen)
+		__field(long long, pos)
+		__field(unsigned long long, len)
+		__field(unsigned int, events)
+		__field(unsigned long long, lost_prev)
+	),
+	TP_fast_assign(
+		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->action = action;
+		__entry->ino = p->ino;
+		__entry->gen = p->gen;
+		__entry->pos = p->pos;
+		__entry->len = p->len;
+		__entry->events = events;
+		__entry->lost_prev = lost_prev;
+	),
+	TP_printk("dev %d:%d ino 0x%llx gen 0x%x op %s pos 0x%llx bytecount 0x%llx events %u lost_prev? %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->gen,
+		  __print_symbolic(__entry->action, XFS_FILE_IOERROR_STRINGS),
+		  __entry->pos,
+		  __entry->len,
+		  __entry->events,
+		  __entry->lost_prev)
+);
 #endif /* CONFIG_XFS_HEALTH_MONITOR */
 
 #endif /* _TRACE_XFS_H */
diff --git a/fs/xfs/libxfs/xfs_healthmon.schema.json b/fs/xfs/libxfs/xfs_healthmon.schema.json
index d3b537a040cb83..fb696dfbbfd044 100644
--- a/fs/xfs/libxfs/xfs_healthmon.schema.json
+++ b/fs/xfs/libxfs/xfs_healthmon.schema.json
@@ -42,6 +42,9 @@
 		},
 		{
 			"$ref": "#/$events/media_error"
+		},
+		{
+			"$ref": "#/$events/file_ioerror"
 		}
 	],
 
@@ -79,6 +82,16 @@
 			"description": "Inode generation number",
 			"type": "integer"
 		},
+		"off_t": {
+			"description": "File position, in bytes",
+			"type": "integer",
+			"minimum": 0
+		},
+		"size_t": {
+			"description": "File operation length, in bytes",
+			"type": "integer",
+			"minimum": 1
+		},
 		"storage_devs": {
 			"description": "Storage devices in a filesystem",
 			"_comment": [
@@ -260,6 +273,26 @@
 		}
 	},
 
+	"$comment": "File IO event data are defined here.",
+	"$fileio": {
+		"types": {
+			"description": [
+				"File I/O operations.  One of:",
+				"",
+				" * readahead: reads into the page cache.",
+				" * writeback: writeback of dirty page cache.",
+				" * directio_read:   O_DIRECT reads.",
+				" * directio_owrite: O_DIRECT writes."
+			],
+			"enum": [
+				"readahead",
+				"writeback",
+				"directio_read",
+				"directio_write"
+			]
+		}
+	},
+
 	"$comment": "Event types are defined here.",
 	"$events": {
 		"running": {
@@ -566,6 +599,50 @@
 				"daddr",
 				"bbcount"
 			]
+		},
+		"file_ioerror": {
+			"title": "File I/O error",
+			"description": [
+				"A read or a write to a file failed.  The",
+				"inode, generation, pos, and len fields",
+				"describe the range of the file that is",
+				"affected."
+			],
+			"type": "object",
+
+			"properties": {
+				"type": {
+					"$ref": "#/$fileio/types"
+				},
+				"time_ns": {
+					"$ref": "#/$defs/time_ns"
+				},
+				"domain": {
+					"const": "filerange"
+				},
+				"inumber": {
+					"$ref": "#/$defs/xfs_ino_t"
+				},
+				"generation": {
+					"$ref": "#/$defs/i_generation"
+				},
+				"pos": {
+					"$ref": "#/$defs/off_t"
+				},
+				"length": {
+					"$ref": "#/$defs/size_t"
+				}
+			},
+
+			"required": [
+				"type",
+				"time_ns",
+				"domain",
+				"inumber",
+				"generation",
+				"pos",
+				"length"
+			]
 		}
 	}
 }
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 52b8be8eb7a11b..74ffb7c4af078c 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -22,6 +22,7 @@
 #include "xfs_healthmon.h"
 #include "xfs_fsops.h"
 #include "xfs_notify_failure.h"
+#include "xfs_file.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -72,6 +73,7 @@ struct xfs_healthmon {
 	struct xfs_shutdown_hook	shook;
 	struct xfs_health_hook		hhook;
 	struct xfs_media_error_hook	mhook;
+	struct xfs_file_ioerror_hook	fhook;
 
 	/* filesystem mount, or NULL if we've unmounted */
 	struct xfs_mount		*mp;
@@ -576,6 +578,73 @@ xfs_healthmon_media_error_hook(
 }
 #endif
 
+/* Add a file io error event to the reporting queue. */
+STATIC int
+xfs_healthmon_file_ioerror_hook(
+	struct notifier_block		*nb,
+	unsigned long			action,
+	void				*data)
+{
+	struct xfs_healthmon		*hm;
+	struct xfs_healthmon_event	*event;
+	struct xfs_file_ioerror_params	*p = data;
+	enum xfs_healthmon_type		type = 0;
+	int				error;
+
+	hm = container_of(nb, struct xfs_healthmon, fhook.ioerror_hook.nb);
+
+	switch (action) {
+	case XFS_FILE_IOERROR_BUFFERED_READ:
+	case XFS_FILE_IOERROR_BUFFERED_WRITE:
+	case XFS_FILE_IOERROR_DIRECT_READ:
+	case XFS_FILE_IOERROR_DIRECT_WRITE:
+		break;
+	default:
+		ASSERT(0);
+		return NOTIFY_DONE;
+	}
+
+	mutex_lock(&hm->lock);
+
+	trace_xfs_healthmon_file_ioerror_hook(hm->mp, action, p, hm->events,
+			hm->lost_prev_event);
+
+	error = xfs_healthmon_start_live_update(hm);
+	if (error)
+		goto out_unlock;
+
+	switch (action) {
+	case XFS_FILE_IOERROR_BUFFERED_READ:
+		type = XFS_HEALTHMON_BUFREAD;
+		break;
+	case XFS_FILE_IOERROR_BUFFERED_WRITE:
+		type = XFS_HEALTHMON_BUFWRITE;
+		break;
+	case XFS_FILE_IOERROR_DIRECT_READ:
+		type = XFS_HEALTHMON_DIOREAD;
+		break;
+	case XFS_FILE_IOERROR_DIRECT_WRITE:
+		type = XFS_HEALTHMON_DIOWRITE;
+		break;
+	}
+
+	event = xfs_healthmon_alloc(hm, type, XFS_HEALTHMON_FILERANGE);
+	if (!event)
+		goto out_unlock;
+
+	event->fino = p->ino;
+	event->fgen = p->gen;
+	event->fpos = p->pos;
+	event->flen = p->len;
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
@@ -590,6 +659,10 @@ xfs_healthmon_typestring(
 		[XFS_HEALTHMON_CORRUPT]		= "corrupt",
 		[XFS_HEALTHMON_HEALTHY]		= "healthy",
 		[XFS_HEALTHMON_MEDIA_ERROR]	= "media",
+		[XFS_HEALTHMON_BUFREAD]		= "readahead",
+		[XFS_HEALTHMON_BUFWRITE]	= "writeback",
+		[XFS_HEALTHMON_DIOREAD]		= "directio_read",
+		[XFS_HEALTHMON_DIOWRITE]	= "directio_write",
 	};
 
 	if (event->type >= ARRAY_SIZE(type_strings))
@@ -612,6 +685,7 @@ xfs_healthmon_domstring(
 		[XFS_HEALTHMON_DATADEV]		= "datadev",
 		[XFS_HEALTHMON_LOGDEV]		= "logdev",
 		[XFS_HEALTHMON_RTDEV]		= "rtdev",
+		[XFS_HEALTHMON_FILERANGE]	= "filerange",
 	};
 
 	if (event->domain >= ARRAY_SIZE(dom_strings))
@@ -835,6 +909,33 @@ xfs_healthmon_format_media_error(
 			event->bbcount);
 }
 
+/* Render file range events as a string set */
+static int
+xfs_healthmon_format_filerange(
+	struct seq_buf			*outbuf,
+	const struct xfs_healthmon_event *event)
+{
+	ssize_t				ret;
+
+	ret = seq_buf_printf(outbuf, "  \"inumber\":    %llu,\n",
+			event->fino);
+	if (ret < 0)
+		return ret;
+
+	ret = seq_buf_printf(outbuf, "  \"generation\": %u,\n",
+			event->fgen);
+	if (ret < 0)
+		return ret;
+
+	ret = seq_buf_printf(outbuf, "  \"pos\":        %llu,\n",
+			event->fpos);
+	if (ret < 0)
+		return ret;
+
+	return seq_buf_printf(outbuf, "  \"length\":     %llu,\n",
+			event->flen);
+}
+
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -916,6 +1017,9 @@ xfs_healthmon_format_json(
 	case XFS_HEALTHMON_RTDEV:
 		ret = xfs_healthmon_format_media_error(outbuf, event);
 		break;
+	case XFS_HEALTHMON_FILERANGE:
+		ret = xfs_healthmon_format_filerange(outbuf, event);
+		break;
 	}
 	if (ret < 0)
 		goto overrun;
@@ -989,6 +1093,7 @@ static const unsigned int domain_map[] = {
 	[XFS_HEALTHMON_DATADEV]		= XFS_HEALTH_MONITOR_DOMAIN_DATADEV,
 	[XFS_HEALTHMON_RTDEV]		= XFS_HEALTH_MONITOR_DOMAIN_RTDEV,
 	[XFS_HEALTHMON_LOGDEV]		= XFS_HEALTH_MONITOR_DOMAIN_LOGDEV,
+	[XFS_HEALTHMON_FILERANGE]	= XFS_HEALTH_MONITOR_DOMAIN_FILERANGE,
 };
 
 static const unsigned int type_map[] = {
@@ -1000,6 +1105,10 @@ static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
 	[XFS_HEALTHMON_SHUTDOWN]	= XFS_HEALTH_MONITOR_TYPE_SHUTDOWN,
 	[XFS_HEALTHMON_MEDIA_ERROR]	= XFS_HEALTH_MONITOR_TYPE_MEDIA_ERROR,
+	[XFS_HEALTHMON_BUFREAD]		= XFS_HEALTH_MONITOR_TYPE_BUFREAD,
+	[XFS_HEALTHMON_BUFWRITE]	= XFS_HEALTH_MONITOR_TYPE_BUFWRITE,
+	[XFS_HEALTHMON_DIOREAD]		= XFS_HEALTH_MONITOR_TYPE_DIOREAD,
+	[XFS_HEALTHMON_DIOWRITE]	= XFS_HEALTH_MONITOR_TYPE_DIOWRITE,
 };
 
 /* Render event as a C structure */
@@ -1060,6 +1169,12 @@ xfs_healthmon_format_cstruct(
 		hme.e.media.daddr = event->daddr;
 		hme.e.media.bbcount = event->bbcount;
 		break;
+	case XFS_HEALTHMON_FILERANGE:
+		hme.e.filerange.ino = event->fino;
+		hme.e.filerange.gen = event->fgen;
+		hme.e.filerange.pos = event->fpos;
+		hme.e.filerange.len = event->flen;
+		break;
 	default:
 		break;
 	}
@@ -1332,6 +1447,7 @@ xfs_healthmon_detach_hooks(
 	 * through the health monitoring subsystem from xfs_fs_put_super, so
 	 * it is now time to detach the hooks.
 	 */
+	xfs_file_ioerror_hook_del(hm->mp, &hm->fhook);
 	xfs_media_error_hook_del(hm->mp, &hm->mhook);
 	xfs_shutdown_hook_del(hm->mp, &hm->shook);
 	xfs_health_hook_del(hm->mp, &hm->hhook);
@@ -1354,6 +1470,7 @@ xfs_healthmon_release(
 	wake_up_all(&hm->wait);
 
 	iterate_supers_type(hm->fstyp, xfs_healthmon_detach_hooks, hm);
+	xfs_file_ioerror_hook_disable();
 	xfs_media_error_hook_disable();
 	xfs_shutdown_hook_disable();
 	xfs_health_hook_disable();
@@ -1481,6 +1598,7 @@ xfs_ioc_health_monitor(
 	xfs_health_hook_enable();
 	xfs_shutdown_hook_enable();
 	xfs_media_error_hook_enable();
+	xfs_file_ioerror_hook_enable();
 
 	/* Attach specific event hooks to this monitor. */
 	xfs_health_hook_setup(&hm->hhook, xfs_healthmon_metadata_hook);
@@ -1498,12 +1616,18 @@ xfs_ioc_health_monitor(
 	if (ret)
 		goto out_shutdownhook;
 
+	xfs_file_ioerror_hook_setup(&hm->fhook,
+			xfs_healthmon_file_ioerror_hook);
+	ret = xfs_file_ioerror_hook_add(mp, &hm->fhook);
+	if (ret)
+		goto out_mediahook;
+
 	/* Queue up the first event that lets the client know we're running. */
 	event = xfs_healthmon_alloc(hm, XFS_HEALTHMON_RUNNING,
 			XFS_HEALTHMON_MOUNT);
 	if (!event) {
 		ret = -ENOMEM;
-		goto out_mediahook;
+		goto out_ioerrhook;
 	}
 	__xfs_healthmon_push(hm, event);
 
@@ -1515,13 +1639,15 @@ xfs_ioc_health_monitor(
 			O_CLOEXEC | O_RDONLY);
 	if (fd < 0) {
 		ret = fd;
-		goto out_mediahook;
+		goto out_ioerrhook;
 	}
 
 	trace_xfs_healthmon_create(mp, hmo.flags, hmo.format);
 
 	return fd;
 
+out_ioerrhook:
+	xfs_file_ioerror_hook_del(mp, &hm->fhook);
 out_mediahook:
 	xfs_media_error_hook_del(mp, &hm->mhook);
 out_shutdownhook:
@@ -1529,6 +1655,7 @@ xfs_ioc_health_monitor(
 out_healthhook:
 	xfs_health_hook_del(mp, &hm->hhook);
 out_hooks:
+	xfs_file_ioerror_hook_disable();
 	xfs_media_error_hook_disable();
 	xfs_health_hook_disable();
 	xfs_shutdown_hook_disable();
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index 08ddab700a6cd3..eb35015c091570 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -54,6 +54,7 @@
 #include "xfs_health.h"
 #include "xfs_healthmon.h"
 #include "xfs_notify_failure.h"
+#include "xfs_file.h"
 
 /*
  * We include this last to have the helpers above available for the trace


