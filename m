Return-Path: <linux-fsdevel+bounces-65257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECDDBFEA7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65B714F1F68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063BE15E97;
	Thu, 23 Oct 2025 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkPCH9mx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3078C11;
	Thu, 23 Oct 2025 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177809; cv=none; b=jFe71L2oVv3XArNJHy4HfpVFSepIAXXXvyE6hEhbC02+pnY0LF+t9jP77Gs1v43Ud/qwZ9V+INOq9zks88dPaskPZMB8pXIQTZhuFWdi7zUYNhgdGDL0tTZifDGrArfh1W3CElMyVeDGlXeqkIBr7btKRmBrEjH7y5+/Av7NP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177809; c=relaxed/simple;
	bh=+Xwe7RIFNrAIBgRMvSbikZoBEkyNYAQtr+3J3HyAU58=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhT8YT4A2UjcQ/aOFsLflMbKk/8W+DONoF52cJhY7+ypIJVGUJvJJgo7LfvU0JECwAey0zkmNKFfdPpx4hnGC+dHJFE7cMAJtVAK3Up7X4BNhVCorcVHfOYmg+CzFnnWajOk30ANhd5eqBwjPC5bCgjVvhPRohDLn9N6AcDehwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkPCH9mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F23C4CEE7;
	Thu, 23 Oct 2025 00:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177809;
	bh=+Xwe7RIFNrAIBgRMvSbikZoBEkyNYAQtr+3J3HyAU58=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UkPCH9mx75L3uLlIs/gtvYPY8co1ykv2ZMI7L1APiXsg3scqGbewPKcySNF186zuk
	 BCeV52H+NcRW3e8jqKrkoMOCcFfUOpSeztBto51kD+fCeHs8QP1Zrma6Jiq6kkoDIv
	 Fe5YpFps33juXJHEgMfFDDDx/9UkAG5UcH4FYQJEt+8XcIzqZts9jTdRbTsNKUchQz
	 Uzro/362OGpH8TAZK3j+aljIXJDWDoZupJdFVoRHOlWRQzU1quolJXy4M32JSptaIU
	 BRAEnJMcvLFw9uLxocV5+ttTxDeU1qZOwQ0w2lMIh3BJ5du+2NfsJbKCU27HXjy18T
	 eZ/zeZx1q0z9g==
Date: Wed, 22 Oct 2025 17:03:27 -0700
Subject: [PATCH 11/19] xfs: create event queuing, formatting,
 and discovery infrastructure
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744738.1025409.11165275452234575607.stgit@frogsfrogsfrogs>
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

Create the basic infrastructure that we need to report health events to
userspace.  We need a compact form for recording critical information
about an event and queueing them; a means to notice that we've lost some
events; and a means to format the events into something that userspace
can handle.

Here, we've chosen json to export information to userspace.  The
structured key-value nature of json gives us enormous flexibility to
modify the schema of what we'll send to userspace because we can add new
keys at any time.  Userspace can use whatever json parsers are available
to consume the events and will not be confused by keys they don't
recognize.

Note that we do NOT allow sending json back to the kernel, nor is there
any intent to do that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h                  |   50 ++
 fs/xfs/xfs_healthmon.h                  |   29 +
 fs/xfs/xfs_linux.h                      |    3 
 fs/xfs/xfs_trace.h                      |  171 +++++++
 fs/xfs/libxfs/xfs_healthmon.schema.json |  129 +++++
 fs/xfs/xfs_healthmon.c                  |  728 +++++++++++++++++++++++++++++++
 fs/xfs/xfs_trace.c                      |    2 
 lib/seq_buf.c                           |    1 
 8 files changed, 1106 insertions(+), 7 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_healthmon.schema.json


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index dba7896f716092..4b642eea18b5ca 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1003,6 +1003,45 @@ struct xfs_rtgroup_geometry {
 #define XFS_RTGROUP_GEOM_SICK_RMAPBT	(1U << 3)  /* reverse mappings */
 #define XFS_RTGROUP_GEOM_SICK_REFCNTBT	(1U << 4)  /* reference counts */
 
+/* Health monitor event domains */
+
+/* affects the whole fs */
+#define XFS_HEALTH_MONITOR_DOMAIN_MOUNT		(0)
+
+/* Health monitor event types */
+
+/* status of the monitor itself */
+#define XFS_HEALTH_MONITOR_TYPE_RUNNING		(0)
+#define XFS_HEALTH_MONITOR_TYPE_LOST		(1)
+
+/* lost events */
+struct xfs_health_monitor_lost {
+	__u64	count;
+};
+
+struct xfs_health_monitor_event {
+	/* XFS_HEALTH_MONITOR_DOMAIN_* */
+	__u32	domain;
+
+	/* XFS_HEALTH_MONITOR_TYPE_* */
+	__u32	type;
+
+	/* Timestamp of the event, in nanoseconds since the Unix epoch */
+	__u64	time_ns;
+
+	/*
+	 * Details of the event.  The primary clients are written in python
+	 * and rust, so break this up because bindgen hates anonymous structs
+	 * and unions.
+	 */
+	union {
+		struct xfs_health_monitor_lost lost;
+	} e;
+
+	/* zeroes */
+	__u64	pad[2];
+};
+
 struct xfs_health_monitor {
 	__u64	flags;		/* flags */
 	__u8	format;		/* output format */
@@ -1010,6 +1049,17 @@ struct xfs_health_monitor {
 	__u64	pad2[2];	/* zeroes */
 };
 
+/* Return all health status events, not just deltas */
+#define XFS_HEALTH_MONITOR_VERBOSE	(1ULL << 0)
+
+#define XFS_HEALTH_MONITOR_ALL		(XFS_HEALTH_MONITOR_VERBOSE)
+
+/* Return events in a C structure */
+#define XFS_HEALTH_MONITOR_FMT_CSTRUCT	(0)
+
+/* Return events in JSON format */
+#define XFS_HEALTH_MONITOR_FMT_JSON	(1)
+
 /*
  * ioctl commands that are used by Linux filesystems
  */
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index 07126e39281a0c..ea2d6a327dfb16 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -6,6 +6,35 @@
 #ifndef __XFS_HEALTHMON_H__
 #define __XFS_HEALTHMON_H__
 
+enum xfs_healthmon_type {
+	XFS_HEALTHMON_RUNNING,	/* monitor running */
+	XFS_HEALTHMON_LOST,	/* message lost */
+};
+
+enum xfs_healthmon_domain {
+	XFS_HEALTHMON_MOUNT,	/* affects the whole fs */
+};
+
+struct xfs_healthmon_event {
+	struct xfs_healthmon_event	*next;
+
+	enum xfs_healthmon_type		type;
+	enum xfs_healthmon_domain	domain;
+
+	uint64_t			time_ns;
+
+	union {
+		/* lost events */
+		struct {
+			uint64_t	lostcount;
+		};
+		/* mount */
+		struct {
+			unsigned int	flags;
+		};
+	};
+};
+
 #ifdef CONFIG_XFS_HEALTH_MONITOR
 long xfs_ioc_health_monitor(struct xfs_mount *mp,
 		struct xfs_health_monitor __user *arg);
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 4dd747bdbccab2..e122db938cc06b 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -63,6 +63,9 @@ typedef __u32			xfs_nlink_t;
 #include <linux/xattr.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/debugfs.h>
+#ifdef CONFIG_XFS_HEALTH_MONITOR
+# include <linux/seq_buf.h>
+#endif
 
 #include <asm/page.h>
 #include <asm/div64.h>
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 79b8641880ab9d..17af5efee026c9 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -103,6 +103,8 @@ struct xfs_refcount_intent;
 struct xfs_metadir_update;
 struct xfs_rtgroup;
 struct xfs_open_zone;
+struct xfs_healthmon_event;
+struct xfs_health_update_params;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -5908,6 +5910,175 @@ DEFINE_EVENT(xfs_freeblocks_resv_class, name, \
 DEFINE_FREEBLOCKS_RESV_EVENT(xfs_freecounter_reserved);
 DEFINE_FREEBLOCKS_RESV_EVENT(xfs_freecounter_enospc);
 
+#ifdef CONFIG_XFS_HEALTH_MONITOR
+TRACE_EVENT(xfs_healthmon_lost_event,
+	TP_PROTO(const struct xfs_mount *mp, unsigned long long lost_prev),
+	TP_ARGS(mp, lost_prev),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long long, lost_prev)
+	),
+	TP_fast_assign(
+		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->lost_prev = lost_prev;
+	),
+	TP_printk("dev %d:%d lost_prev %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->lost_prev)
+);
+
+#define XFS_HEALTHMON_FLAGS_STRINGS \
+	{ XFS_HEALTH_MONITOR_VERBOSE,	"verbose" }
+#define XFS_HEALTHMON_FMT_STRINGS \
+	{ XFS_HEALTH_MONITOR_FMT_JSON,	"json" }, \
+	{ XFS_HEALTH_MONITOR_FMT_CSTRUCT,	"cstruct" }
+
+TRACE_EVENT(xfs_healthmon_create,
+	TP_PROTO(const struct xfs_mount *mp, u64 flags, u8 format),
+	TP_ARGS(mp, flags, format),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, flags)
+		__field(u8, format)
+	),
+	TP_fast_assign(
+		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->flags = flags;
+		__entry->format = format;
+	),
+	TP_printk("dev %d:%d flags %s format %s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_flags(__entry->flags, "|", XFS_HEALTHMON_FLAGS_STRINGS),
+		  __print_symbolic(__entry->format, XFS_HEALTHMON_FMT_STRINGS))
+);
+
+TRACE_EVENT(xfs_healthmon_copybuf,
+	TP_PROTO(const struct xfs_mount *mp, const struct iov_iter *iov,
+		 const struct seq_buf *seqbuf, size_t outpos),
+	TP_ARGS(mp, iov, seqbuf, outpos),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(size_t, seqbuf_size)
+		__field(size_t, seqbuf_len)
+		__field(size_t, outpos)
+		__field(size_t, to_copy)
+		__field(size_t, iter_count)
+	),
+	TP_fast_assign(
+		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->seqbuf_size = seqbuf->size;
+		__entry->seqbuf_len = seqbuf->len;
+		__entry->outpos = outpos;
+		__entry->to_copy = seqbuf->len - outpos;
+		__entry->iter_count = iov_iter_count(iov);
+	),
+	TP_printk("dev %d:%d seqsize %zu seqlen %zu out_pos %zu to_copy %zu iter_count %zu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->seqbuf_size,
+		  __entry->seqbuf_len,
+		  __entry->outpos,
+		  __entry->to_copy,
+		  __entry->iter_count)
+);
+
+DECLARE_EVENT_CLASS(xfs_healthmon_class,
+	TP_PROTO(const struct xfs_mount *mp, unsigned int events,
+		 unsigned long long lost_prev),
+	TP_ARGS(mp, events, lost_prev),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, events)
+		__field(unsigned long long, lost_prev)
+	),
+	TP_fast_assign(
+		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->events = events;
+		__entry->lost_prev = lost_prev;
+	),
+	TP_printk("dev %d:%d events %u lost_prev? %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->events,
+		  __entry->lost_prev)
+);
+#define DEFINE_HEALTHMON_EVENT(name) \
+DEFINE_EVENT(xfs_healthmon_class, name, \
+	TP_PROTO(const struct xfs_mount *mp, unsigned int events, \
+		 unsigned long long lost_prev), \
+	TP_ARGS(mp, events, lost_prev))
+DEFINE_HEALTHMON_EVENT(xfs_healthmon_read_start);
+DEFINE_HEALTHMON_EVENT(xfs_healthmon_read_finish);
+DEFINE_HEALTHMON_EVENT(xfs_healthmon_release);
+DEFINE_HEALTHMON_EVENT(xfs_healthmon_unmount);
+
+#define XFS_HEALTHMON_TYPE_STRINGS \
+	{ XFS_HEALTHMON_LOST,		"lost" }
+
+#define XFS_HEALTHMON_DOMAIN_STRINGS \
+	{ XFS_HEALTHMON_MOUNT,		"mount" }
+
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_LOST);
+
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_MOUNT);
+
+DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
+	TP_PROTO(const struct xfs_mount *mp, const struct xfs_healthmon_event *event),
+	TP_ARGS(mp, event),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, type)
+		__field(unsigned int, domain)
+		__field(unsigned int, mask)
+		__field(unsigned long long, ino)
+		__field(unsigned int, gen)
+		__field(unsigned int, group)
+		__field(unsigned long long, offset)
+		__field(unsigned long long, length)
+		__field(unsigned long long, lostcount)
+	),
+	TP_fast_assign(
+		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->type = event->type;
+		__entry->domain = event->domain;
+		__entry->mask = 0;
+		__entry->group = 0;
+		__entry->ino = 0;
+		__entry->gen = 0;
+		__entry->offset = 0;
+		__entry->length = 0;
+		__entry->lostcount = 0;
+		switch (__entry->domain) {
+		case XFS_HEALTHMON_MOUNT:
+			switch (__entry->type) {
+			case XFS_HEALTHMON_LOST:
+				__entry->lostcount = event->lostcount;
+				break;
+			}
+			break;
+		}
+	),
+	TP_printk("dev %d:%d type %s domain %s mask 0x%x ino 0x%llx gen 0x%x offset 0x%llx len 0x%llx group 0x%x lost %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_symbolic(__entry->type, XFS_HEALTHMON_TYPE_STRINGS),
+		  __print_symbolic(__entry->domain, XFS_HEALTHMON_DOMAIN_STRINGS),
+		  __entry->mask,
+		  __entry->ino,
+		  __entry->gen,
+		  __entry->offset,
+		  __entry->length,
+		  __entry->group,
+		  __entry->lostcount)
+);
+#define DEFINE_HEALTHMONEVENT_EVENT(name) \
+DEFINE_EVENT(xfs_healthmon_event_class, name, \
+	TP_PROTO(const struct xfs_mount *mp, const struct xfs_healthmon_event *event), \
+	TP_ARGS(mp, event))
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_push);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_pop);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_format);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_format_overflow);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_drop);
+#endif /* CONFIG_XFS_HEALTH_MONITOR */
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/xfs/libxfs/xfs_healthmon.schema.json b/fs/xfs/libxfs/xfs_healthmon.schema.json
new file mode 100644
index 00000000000000..68762738b04191
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_healthmon.schema.json
@@ -0,0 +1,129 @@
+{
+	"$comment": [
+		"SPDX-License-Identifier: GPL-2.0-or-later",
+		"Copyright (c) 2024-2025 Oracle.  All Rights Reserved.",
+		"Author: Darrick J. Wong <djwong@kernel.org>",
+		"",
+		"This schema file describes the format of the json objects",
+		"readable from the fd returned by the XFS_IOC_HEALTHMON",
+		"ioctl."
+	],
+
+	"$schema": "https://json-schema.org/draft/2020-12/schema",
+	"$id": "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/fs/xfs/libxfs/xfs_healthmon.schema.json",
+
+	"title": "XFS Health Monitoring Events",
+
+	"$comment": "Events must be one of the following types:",
+	"oneOf": [
+		{
+			"$ref": "#/$events/running"
+		},
+		{
+			"$ref": "#/$events/unmount"
+		},
+		{
+			"$ref": "#/$events/lost"
+		}
+	],
+
+	"$comment": "Simple data types are defined here.",
+	"$defs": {
+		"time_ns": {
+			"title": "Time of Event",
+			"description": "Timestamp of the event, in nanoseconds since the Unix epoch.",
+			"type": "integer"
+		},
+		"count": {
+			"title": "Count of events",
+			"description": "Number of events.",
+			"type": "integer",
+			"minimum": 1
+		}
+	},
+
+	"$comment": "Event types are defined here.",
+	"$events": {
+		"running": {
+			"title": "Health Monitoring Running",
+			"$comment": [
+				"The health monitor is actually running."
+			],
+			"type": "object",
+
+			"properties": {
+				"type": {
+					"const": "running"
+				},
+				"time_ns": {
+					"$ref": "#/$defs/time_ns"
+				},
+				"domain": {
+					"const": "mount"
+				}
+			},
+
+			"required": [
+				"type",
+				"time_ns",
+				"domain"
+			]
+		},
+		"unmount": {
+			"title": "Filesystem Unmounted",
+			"$comment": [
+				"The filesystem was unmounted."
+			],
+			"type": "object",
+
+			"properties": {
+				"type": {
+					"const": "unmount"
+				},
+				"time_ns": {
+					"$ref": "#/$defs/time_ns"
+				},
+				"domain": {
+					"const": "mount"
+				}
+			},
+
+			"required": [
+				"type",
+				"time_ns",
+				"domain"
+			]
+		},
+		"lost": {
+			"title": "Health Monitoring Events Lost",
+			"$comment": [
+				"Previous health monitoring events were",
+				"dropped due to memory allocation failures",
+				"or queue limits."
+			],
+			"type": "object",
+
+			"properties": {
+				"type": {
+					"const": "lost"
+				},
+				"count": {
+					"$ref": "#/$defs/count"
+				},
+				"time_ns": {
+					"$ref": "#/$defs/time_ns"
+				},
+				"domain": {
+					"const": "mount"
+				}
+			},
+
+			"required": [
+				"type",
+				"count",
+				"time_ns",
+				"domain"
+			]
+		}
+	}
+}
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 7b0d9f78b0a402..d5ca6ef8015c0e 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -40,12 +40,558 @@
  * so that the queueing and processing of the events do not pin the mount and
  * cannot slow down the main filesystem.  The healthmon object can exist past
  * the end of the filesystem mount.
+ *
+ * Please see the xfs_healthmon.schema.json file for a description of the
+ * format of the json events that are conveyed to userspace.
  */
 
+/* Allow this many events to build up in memory per healthmon fd. */
+#define XFS_HEALTHMON_MAX_EVENTS \
+		(32768 / sizeof(struct xfs_healthmon_event))
+
+struct flag_string {
+	unsigned int	mask;
+	const char	*str;
+};
+
 struct xfs_healthmon {
+	/* lock for mp and eventlist */
+	struct mutex			lock;
+
+	/* waiter for signalling the arrival of events */
+	struct wait_queue_head		wait;
+
+	/* list of event objects */
+	struct xfs_healthmon_event	*first_event;
+	struct xfs_healthmon_event	*last_event;
+
 	struct xfs_mount		*mp;
+
+	/* number of events */
+	unsigned int			events;
+
+	/*
+	 * Buffer for formatting events.  New buffer data are appended to the
+	 * end of the seqbuf, and outpos is used to determine where to start
+	 * a copy_iter.  Both are protected by inode_lock.
+	 */
+	struct seq_buf			outbuf;
+	size_t				outpos;
+
+	/* XFS_HEALTH_MONITOR_FMT_* */
+	uint8_t				format;
+
+	/* do we want all events? */
+	bool				verbose;
+
+	/* did we lose previous events? */
+	unsigned long long		lost_prev_event;
+
+	/* total counts of events observed and lost events */
+	unsigned long long		total_events;
+	unsigned long long		total_lost;
 };
 
+static inline void xfs_healthmon_bump_events(struct xfs_healthmon *hm)
+{
+	hm->events++;
+	hm->total_events++;
+}
+
+static inline void xfs_healthmon_bump_lost(struct xfs_healthmon *hm)
+{
+	hm->lost_prev_event++;
+	hm->total_lost++;
+}
+
+/* Remove an event from the head of the list. */
+static inline int
+xfs_healthmon_free_head(
+	struct xfs_healthmon		*hm,
+	struct xfs_healthmon_event	*event)
+{
+	struct xfs_healthmon_event	*head;
+
+	mutex_lock(&hm->lock);
+	head = hm->first_event;
+	if (head != event) {
+		ASSERT(hm->first_event == event);
+		mutex_unlock(&hm->lock);
+		return -EFSCORRUPTED;
+	}
+
+	if (hm->last_event == head)
+		hm->last_event = NULL;
+	hm->first_event = head->next;
+	hm->events--;
+	mutex_unlock(&hm->lock);
+
+	trace_xfs_healthmon_pop(hm->mp, head);
+	kfree(event);
+	return 0;
+}
+
+/* Push an event onto the end of the list. */
+static inline void
+__xfs_healthmon_push(
+	struct xfs_healthmon		*hm,
+	struct xfs_healthmon_event	*event)
+{
+	if (!hm->first_event)
+		hm->first_event = event;
+	if (hm->last_event)
+		hm->last_event->next = event;
+	hm->last_event = event;
+	event->next = NULL;
+	xfs_healthmon_bump_events(hm);
+	wake_up(&hm->wait);
+
+	trace_xfs_healthmon_push(hm->mp, event);
+}
+
+/* Push an event onto the end of the list if we're not full. */
+static inline int
+xfs_healthmon_push(
+	struct xfs_healthmon		*hm,
+	struct xfs_healthmon_event	*event)
+{
+	if (hm->events >= XFS_HEALTHMON_MAX_EVENTS) {
+		trace_xfs_healthmon_lost_event(hm->mp, hm->lost_prev_event);
+
+		xfs_healthmon_bump_lost(hm);
+		return -ENOMEM;
+	}
+
+	__xfs_healthmon_push(hm, event);
+	return 0;
+}
+
+/* Create a new event or record that we failed. */
+static struct xfs_healthmon_event *
+xfs_healthmon_alloc(
+	struct xfs_healthmon		*hm,
+	enum xfs_healthmon_type		type,
+	enum xfs_healthmon_domain	domain)
+{
+	struct timespec64		now;
+	struct xfs_healthmon_event	*event;
+
+	event = kzalloc(sizeof(*event), GFP_NOFS);
+	if (!event) {
+		trace_xfs_healthmon_lost_event(hm->mp, hm->lost_prev_event);
+
+		xfs_healthmon_bump_lost(hm);
+		return NULL;
+	}
+
+	event->type = type;
+	event->domain = domain;
+	ktime_get_coarse_real_ts64(&now);
+	event->time_ns = (now.tv_sec * NSEC_PER_SEC) + now.tv_nsec;
+
+	return event;
+}
+
+/*
+ * Before we accept an event notification from a live update hook, we need to
+ * clear out any previously lost events.
+ */
+static inline int
+xfs_healthmon_start_live_update(
+	struct xfs_healthmon		*hm)
+{
+	struct xfs_healthmon_event	*event;
+
+	/* If the queue is already full.... */
+	if (hm->events >= XFS_HEALTHMON_MAX_EVENTS) {
+		trace_xfs_healthmon_lost_event(hm->mp, hm->lost_prev_event);
+
+		if (hm->last_event &&
+		    hm->last_event->type == XFS_HEALTHMON_LOST) {
+			/*
+			 * ...and the last event notes lost events, then add
+			 * the number of events we already lost, plus one for
+			 * this event that we're about to lose.
+			 */
+			hm->last_event->lostcount += hm->lost_prev_event + 1;
+			hm->lost_prev_event = 0;
+		} else {
+			/*
+			 * ...try to create a new lost event.  Add the number
+			 * of events we previously lost, plus one for this
+			 * event.
+			 */
+			event = xfs_healthmon_alloc(hm, XFS_HEALTHMON_LOST,
+					XFS_HEALTHMON_MOUNT);
+			if (!event) {
+				xfs_healthmon_bump_lost(hm);
+				return -ENOMEM;
+			}
+			event->lostcount = hm->lost_prev_event + 1;
+			hm->lost_prev_event = 0;
+
+			__xfs_healthmon_push(hm, event);
+		}
+
+		return -ENOSPC;
+	}
+
+	/* If we lost an event in the past, but the queue isn't yet full... */
+	if (hm->lost_prev_event) {
+		/*
+		 * ...try to create a new lost event.  Add the number of events
+		 * we previously lost, plus one for this event.
+		 */
+		event = xfs_healthmon_alloc(hm, XFS_HEALTHMON_LOST,
+				XFS_HEALTHMON_MOUNT);
+		if (!event) {
+			xfs_healthmon_bump_lost(hm);
+			return -ENOMEM;
+		}
+		event->lostcount = hm->lost_prev_event;
+		hm->lost_prev_event = 0;
+
+		/*
+		 * If adding this lost event pushes us over the limit, we're
+		 * going to lose the current event.  Note that in the lost
+		 * event count too.
+		 */
+		if (hm->events == XFS_HEALTHMON_MAX_EVENTS - 1)
+			event->lostcount++;
+
+		__xfs_healthmon_push(hm, event);
+		if (hm->events >= XFS_HEALTHMON_MAX_EVENTS) {
+			trace_xfs_healthmon_lost_event(hm->mp,
+					hm->lost_prev_event);
+			return -ENOSPC;
+		}
+	}
+
+	/*
+	 * The queue is not full and it is not currently the case that events
+	 * were lost.
+	 */
+	return 0;
+}
+
+/* Render the health update type as a string. */
+STATIC const char *
+xfs_healthmon_typestring(
+	const struct xfs_healthmon_event	*event)
+{
+	static const char *type_strings[] = {
+		[XFS_HEALTHMON_RUNNING]		= "running",
+		[XFS_HEALTHMON_LOST]		= "lost",
+	};
+
+	if (event->type >= ARRAY_SIZE(type_strings))
+		return "?";
+
+	return type_strings[event->type];
+}
+
+/* Render the health domain as a string. */
+STATIC const char *
+xfs_healthmon_domstring(
+	const struct xfs_healthmon_event	*event)
+{
+	static const char *dom_strings[] = {
+		[XFS_HEALTHMON_MOUNT]		= "mount",
+	};
+
+	if (event->domain >= ARRAY_SIZE(dom_strings))
+		return "?";
+
+	return dom_strings[event->domain];
+}
+
+/* Convert a flags bitmap into a jsonable string. */
+static inline int
+xfs_healthmon_format_flags(
+	struct seq_buf			*outbuf,
+	const struct flag_string	*strings,
+	size_t				nr_strings,
+	unsigned int			flags)
+{
+	const struct flag_string	*p;
+	ssize_t				ret;
+	unsigned int			i;
+	bool				first = true;
+
+	for (i = 0, p = strings; i < nr_strings; i++, p++) {
+		if (!(p->mask & flags))
+			continue;
+
+		ret = seq_buf_printf(outbuf, "%s\"%s\"",
+				first ? "" : ", ", p->str);
+		if (ret < 0)
+			return ret;
+
+		first = false;
+		flags &= ~p->mask;
+	}
+
+	for (i = 0; flags != 0 && i < sizeof(flags) * NBBY; i++) {
+		if (!(flags & (1U << i)))
+			continue;
+
+		/* json doesn't support hexadecimal notation */
+		ret = seq_buf_printf(outbuf, "%s%u",
+				first ? "" : ", ", (1U << i));
+		if (ret < 0)
+			return ret;
+
+		first = false;
+	}
+
+	return 0;
+}
+
+/* Convert the event mask into a jsonable string. */
+static inline int
+__xfs_healthmon_format_mask(
+	struct seq_buf			*outbuf,
+	const char			*descr,
+	const struct flag_string	*strings,
+	size_t				nr_strings,
+	unsigned int			mask)
+{
+	ssize_t				ret;
+
+	ret = seq_buf_printf(outbuf, "  \"%s\":  [", descr);
+	if (ret < 0)
+		return ret;
+
+	ret = xfs_healthmon_format_flags(outbuf, strings, nr_strings, mask);
+	if (ret < 0)
+		return ret;
+
+	return seq_buf_printf(outbuf, "],\n");
+}
+
+#define xfs_healthmon_format_mask(o, d, s, m) \
+	__xfs_healthmon_format_mask((o), (d), (s), ARRAY_SIZE(s), (m))
+
+static inline void
+xfs_healthmon_reset_outbuf(
+	struct xfs_healthmon		*hm)
+{
+	hm->outpos = 0;
+	seq_buf_clear(&hm->outbuf);
+}
+
+/* Render lost event mask as a string set */
+static int
+xfs_healthmon_format_lost(
+	struct seq_buf			*outbuf,
+	const struct xfs_healthmon_event *event)
+{
+	return seq_buf_printf(outbuf, "  \"count\":      %llu,\n",
+			event->lostcount);
+}
+
+/*
+ * Format an event into json.  Returns 0 if we formatted the event.  If
+ * formatting the event overflows the buffer, returns -1 with the seqbuf len
+ * unchanged.
+ */
+STATIC int
+xfs_healthmon_format_json(
+	struct xfs_healthmon		*hm,
+	const struct xfs_healthmon_event *event)
+{
+	struct seq_buf			*outbuf = &hm->outbuf;
+	size_t				old_seqlen = outbuf->len;
+	int				ret;
+
+	trace_xfs_healthmon_format(hm->mp, event);
+
+	ret = seq_buf_printf(outbuf, "{\n");
+	if (ret < 0)
+		goto overrun;
+
+	ret = seq_buf_printf(outbuf, "  \"domain\":     \"%s\",\n",
+			xfs_healthmon_domstring(event));
+	if (ret < 0)
+		goto overrun;
+
+	ret = seq_buf_printf(outbuf, "  \"type\":       \"%s\",\n",
+			xfs_healthmon_typestring(event));
+	if (ret < 0)
+		goto overrun;
+
+	switch (event->domain) {
+	case XFS_HEALTHMON_MOUNT:
+		switch (event->type) {
+		case XFS_HEALTHMON_RUNNING:
+			/* nothing to format */
+			break;
+		case XFS_HEALTHMON_LOST:
+			ret = xfs_healthmon_format_lost(outbuf, event);
+			break;
+		default:
+			break;
+		}
+		break;
+	}
+	if (ret < 0)
+		goto overrun;
+
+	/* The last element in the json must not have a trailing comma. */
+	ret = seq_buf_printf(outbuf, "  \"time_ns\":    %llu\n",
+			event->time_ns);
+	if (ret < 0)
+		goto overrun;
+
+	ret = seq_buf_printf(outbuf, "}\n");
+	if (ret < 0)
+		goto overrun;
+
+	ASSERT(!seq_buf_has_overflowed(outbuf));
+	return 0;
+overrun:
+	/*
+	 * We overflowed the buffer and could not format the event.  Reset the
+	 * seqbuf and tell the caller not to delete the event.
+	 */
+	trace_xfs_healthmon_format_overflow(hm->mp, event);
+	outbuf->len = old_seqlen;
+	return -1;
+}
+
+static const unsigned int domain_map[] = {
+	[XFS_HEALTHMON_MOUNT]		= XFS_HEALTH_MONITOR_DOMAIN_MOUNT,
+};
+
+static const unsigned int type_map[] = {
+	[XFS_HEALTHMON_RUNNING]		= XFS_HEALTH_MONITOR_TYPE_RUNNING,
+	[XFS_HEALTHMON_LOST]		= XFS_HEALTH_MONITOR_TYPE_LOST,
+};
+
+/* Render event as a C structure */
+STATIC int
+xfs_healthmon_format_cstruct(
+	struct xfs_healthmon		*hm,
+	const struct xfs_healthmon_event *event)
+{
+	struct xfs_health_monitor_event	hme = {
+		.time_ns		= event->time_ns,
+	};
+	struct seq_buf			*outbuf = &hm->outbuf;
+	size_t				old_seqlen = outbuf->len;
+	int				ret;
+
+	trace_xfs_healthmon_format(hm->mp, event);
+
+	if (event->domain < 0 || event->domain >= ARRAY_SIZE(domain_map) ||
+	    event->type < 0   || event->type >= ARRAY_SIZE(type_map))
+		return -EFSCORRUPTED;
+
+	hme.domain = domain_map[event->domain];
+	hme.type = type_map[event->type];
+
+	/* fill in the event-specific details */
+	switch (event->domain) {
+	case XFS_HEALTHMON_MOUNT:
+		switch (event->type) {
+		case XFS_HEALTHMON_LOST:
+			hme.e.lost.count = event->lostcount;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	ret = seq_buf_putmem(outbuf, &hme, sizeof(hme));
+	if (ret < 0) {
+		/*
+		 * We overflowed the buffer and could not format the event.
+		 * Reset the seqbuf and tell the caller not to delete the
+		 * event.
+		 */
+		trace_xfs_healthmon_format_overflow(hm->mp, event);
+		outbuf->len = old_seqlen;
+		return -1;
+	}
+
+	ASSERT(!seq_buf_has_overflowed(outbuf));
+	return 0;
+}
+
+/* How many bytes are waiting in the outbuf to be copied? */
+static inline size_t
+xfs_healthmon_outbuf_bytes(
+	struct xfs_healthmon	*hm)
+{
+	unsigned int		used = seq_buf_used(&hm->outbuf);
+
+	if (used > hm->outpos)
+		return used - hm->outpos;
+	return 0;
+}
+
+/*
+ * Do we have something for userspace to do?  This can mean unmount events,
+ * events pending in the queue, or pending bytes in the outbuf.
+ */
+static inline bool
+xfs_healthmon_has_eventdata(
+	struct xfs_healthmon	*hm)
+{
+	return hm->events > 0 || xfs_healthmon_outbuf_bytes(hm) > 0;
+}
+
+/* Try to copy the rest of the outbuf to the iov iter. */
+STATIC ssize_t
+xfs_healthmon_copybuf(
+	struct xfs_healthmon	*hm,
+	struct iov_iter		*to)
+{
+	size_t			to_copy;
+	size_t			w = 0;
+
+	trace_xfs_healthmon_copybuf(hm->mp, to, &hm->outbuf, hm->outpos);
+
+	to_copy = xfs_healthmon_outbuf_bytes(hm);
+	if (to_copy) {
+		w = copy_to_iter(hm->outbuf.buffer + hm->outpos, to_copy, to);
+		if (!w)
+			return -EFAULT;
+
+		hm->outpos += w;
+	}
+
+	/*
+	 * Nothing left to copy?  Reset the seqbuf pointers and outbuf to the
+	 * start since there's no live data in the buffer.
+	 */
+	if (xfs_healthmon_outbuf_bytes(hm) == 0)
+		xfs_healthmon_reset_outbuf(hm);
+	return w;
+}
+
+/*
+ * See if there's an event waiting for us.  If the fs is no longer mounted,
+ * don't bother sending any more events.
+ */
+static inline struct xfs_healthmon_event *
+xfs_healthmon_peek(
+	struct xfs_healthmon	*hm)
+{
+	struct xfs_healthmon_event *event;
+
+	mutex_lock(&hm->lock);
+	if (hm->mp)
+		event = hm->first_event;
+	else
+		event = NULL;
+	mutex_unlock(&hm->lock);
+	return event;
+}
+
 /*
  * Convey queued event data to userspace.  First copy any remaining bytes in
  * the outbuf, then format the oldest event into the outbuf and copy that too.
@@ -55,7 +601,125 @@ xfs_healthmon_read_iter(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	return -EIO;
+	struct file		*file = iocb->ki_filp;
+	struct inode		*inode = file_inode(file);
+	struct xfs_healthmon	*hm = file->private_data;
+	struct xfs_healthmon_event *event;
+	size_t			copied = 0;
+	ssize_t			ret = 0;
+
+	/* Wait for data to become available */
+	if (!(file->f_flags & O_NONBLOCK)) {
+		ret = wait_event_interruptible(hm->wait,
+				xfs_healthmon_has_eventdata(hm));
+		if (ret)
+			return ret;
+	} else if (!xfs_healthmon_has_eventdata(hm)) {
+		return -EAGAIN;
+	}
+
+	/* Allocate formatting buffer up to 64k if necessary */
+	if (hm->outbuf.size == 0) {
+		void		*outbuf;
+		size_t		bufsize = min(65536, max(PAGE_SIZE,
+							 iov_iter_count(to)));
+
+		outbuf = kzalloc(bufsize, GFP_KERNEL);
+		if (!outbuf) {
+			bufsize = PAGE_SIZE;
+			outbuf = kzalloc(bufsize, GFP_KERNEL);
+			if (!outbuf)
+				return -ENOMEM;
+		}
+
+		inode_lock(inode);
+		if (hm->outbuf.size == 0) {
+			seq_buf_init(&hm->outbuf, outbuf, bufsize);
+			hm->outpos = 0;
+		} else {
+			kfree(outbuf);
+		}
+	} else {
+		inode_lock(inode);
+	}
+
+	trace_xfs_healthmon_read_start(hm->mp, hm->events, hm->lost_prev_event);
+
+	/*
+	 * If there's anything left in the seqbuf, copy that before formatting
+	 * more events.
+	 */
+	ret = xfs_healthmon_copybuf(hm, to);
+	if (ret < 0)
+		goto out_unlock;
+	copied += ret;
+
+	while (iov_iter_count(to) > 0) {
+		/* Format the next events into the outbuf until it's full. */
+		while ((event = xfs_healthmon_peek(hm)) != NULL) {
+			switch (hm->format) {
+			case XFS_HEALTH_MONITOR_FMT_JSON:
+				ret = xfs_healthmon_format_json(hm, event);
+				break;
+			case XFS_HEALTH_MONITOR_FMT_CSTRUCT:
+				ret = xfs_healthmon_format_cstruct(hm, event);
+				break;
+			default:
+				ret = -EINVAL;
+				goto out_unlock;
+			}
+			if (ret < 0)
+				break;
+			ret = xfs_healthmon_free_head(hm, event);
+			if (ret)
+				goto out_unlock;
+		}
+
+		/* Copy it to userspace */
+		ret = xfs_healthmon_copybuf(hm, to);
+		if (ret <= 0)
+			break;
+
+		copied += ret;
+	}
+
+out_unlock:
+	trace_xfs_healthmon_read_finish(hm->mp, hm->events, hm->lost_prev_event);
+	inode_unlock(inode);
+	return copied ?: ret;
+}
+
+/* Poll for available events. */
+STATIC __poll_t
+xfs_healthmon_poll(
+	struct file			*file,
+	struct poll_table_struct	*wait)
+{
+	struct xfs_healthmon		*hm = file->private_data;
+	__poll_t			mask = 0;
+
+	poll_wait(file, &hm->wait, wait);
+
+	if (xfs_healthmon_has_eventdata(hm))
+		mask |= EPOLLIN;
+	return mask;
+}
+
+/* Free all events */
+STATIC void
+xfs_healthmon_free_events(
+	struct xfs_healthmon		*hm)
+{
+	struct xfs_healthmon_event	*event, *next;
+
+	event = hm->first_event;
+	while (event != NULL) {
+		trace_xfs_healthmon_drop(hm->mp, event);
+		next = event->next;
+		kfree(event);
+		event = next;
+	}
+	hm->first_event = hm->last_event = NULL;
 }
 
 /* Free the health monitoring information. */
@@ -66,6 +730,14 @@ xfs_healthmon_release(
 {
 	struct xfs_healthmon	*hm = file->private_data;
 
+	trace_xfs_healthmon_release(hm->mp, hm->events, hm->lost_prev_event);
+
+	wake_up_all(&hm->wait);
+
+	mutex_destroy(&hm->lock);
+	xfs_healthmon_free_events(hm);
+	if (hm->outbuf.size)
+		kfree(hm->outbuf.buffer);
 	kfree(hm);
 
 	return 0;
@@ -76,9 +748,10 @@ static inline bool
 xfs_healthmon_validate(
 	const struct xfs_health_monitor	*hmo)
 {
-	if (hmo->flags)
+	if (hmo->flags & ~XFS_HEALTH_MONITOR_ALL)
 		return false;
-	if (hmo->format)
+	if (hmo->format != XFS_HEALTH_MONITOR_FMT_JSON &&
+	    hmo->format != XFS_HEALTH_MONITOR_FMT_CSTRUCT)
 		return false;
 	if (memchr_inv(&hmo->pad1, 0, sizeof(hmo->pad1)))
 		return false;
@@ -89,6 +762,19 @@ xfs_healthmon_validate(
 
 /* Emit some data about the health monitoring fd. */
 #ifdef CONFIG_PROC_FS
+static const char *
+xfs_healthmon_format_string(const struct xfs_healthmon *hm)
+{
+	switch (hm->format) {
+	case XFS_HEALTH_MONITOR_FMT_JSON:
+		return "json";
+	case XFS_HEALTH_MONITOR_FMT_CSTRUCT:
+		return "blob";
+	}
+
+	return "";
+}
+
 static void
 xfs_healthmon_show_fdinfo(
 	struct seq_file		*m,
@@ -96,8 +782,13 @@ xfs_healthmon_show_fdinfo(
 {
 	struct xfs_healthmon	*hm = file->private_data;
 
-	seq_printf(m, "state:\talive\ndev:\t%s\n",
-			hm->mp->m_super->s_id);
+	mutex_lock(&hm->lock);
+	seq_printf(m, "state:\talive\ndev:\t%s\nformat:\t%s\nevents:\t%llu\nlost:\t%llu\n",
+			hm->mp->m_super->s_id,
+			xfs_healthmon_format_string(hm),
+			hm->total_events,
+			hm->total_lost);
+	mutex_unlock(&hm->lock);
 }
 #endif
 
@@ -107,6 +798,7 @@ static const struct file_operations xfs_healthmon_fops = {
 	.show_fdinfo	= xfs_healthmon_show_fdinfo,
 #endif
 	.read_iter	= xfs_healthmon_read_iter,
+	.poll		= xfs_healthmon_poll,
 	.release	= xfs_healthmon_release,
 };
 
@@ -121,6 +813,7 @@ xfs_ioc_health_monitor(
 {
 	struct xfs_health_monitor	hmo;
 	struct xfs_healthmon		*hm;
+	struct xfs_healthmon_event	*event;
 	int				fd;
 	int				ret;
 
@@ -137,6 +830,23 @@ xfs_ioc_health_monitor(
 	if (!hm)
 		return -ENOMEM;
 	hm->mp = mp;
+	hm->format = hmo.format;
+
+	seq_buf_init(&hm->outbuf, NULL, 0);
+	mutex_init(&hm->lock);
+	init_waitqueue_head(&hm->wait);
+
+	if (hmo.flags & XFS_HEALTH_MONITOR_VERBOSE)
+		hm->verbose = true;
+
+	/* Queue up the first event that lets the client know we're running. */
+	event = xfs_healthmon_alloc(hm, XFS_HEALTHMON_RUNNING,
+			XFS_HEALTHMON_MOUNT);
+	if (!event) {
+		ret = -ENOMEM;
+		goto out_mutex;
+	}
+	__xfs_healthmon_push(hm, event);
 
 	/*
 	 * Create the anonymous file.  If it succeeds, the file owns hm and
@@ -146,12 +856,16 @@ xfs_ioc_health_monitor(
 			O_CLOEXEC | O_RDONLY);
 	if (fd < 0) {
 		ret = fd;
-		goto out_hm;
+		goto out_mutex;
 	}
 
+	trace_xfs_healthmon_create(mp, hmo.flags, hmo.format);
+
 	return fd;
 
-out_hm:
+out_mutex:
+	mutex_destroy(&hm->lock);
+	xfs_healthmon_free_events(hm);
 	kfree(hm);
 	return ret;
 }
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index a60556dbd172ee..d42b864a3837a2 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -51,6 +51,8 @@
 #include "xfs_rtgroup.h"
 #include "xfs_zone_alloc.h"
 #include "xfs_zone_priv.h"
+#include "xfs_health.h"
+#include "xfs_healthmon.h"
 
 /*
  * We include this last to have the helpers above available for the trace
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index f3f3436d60a940..f6a1fb46a1d6c9 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -245,6 +245,7 @@ int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_putmem);
 
 #define MAX_MEMHEX_BYTES	8U
 #define HEX_CHARS		(MAX_MEMHEX_BYTES*2 + 1)


