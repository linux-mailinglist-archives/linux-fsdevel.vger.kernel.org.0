Return-Path: <linux-fsdevel+bounces-67038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE03EC338A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B90074F7383
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A0F2417C6;
	Wed,  5 Nov 2025 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Navi/hGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10423E35E;
	Wed,  5 Nov 2025 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303940; cv=none; b=UPyesKaZIo/sCMC9BA0lbhquQPKJU+JduMujzzKFfuxRFcLj75hOHoQAD4kxIsmMk0vB6jedDoebRtPoXXcVk8bDUSMemDgX/pZI6TKMeQ0SAMFa65BIIlhZyE0o8GryW9kzkSGTXsiKQSXyRX7Hc9hu5H29hjwWRC0SwyQmNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303940; c=relaxed/simple;
	bh=ccWJ7ZHmyKrdhbGWUUP66iSoEuT3r0z/A0AvnV7HAdU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feItUUnN7EAlpL5X5FJ4z1k5XbUezRW7giUm1e0Edv5FzHHM6ILPTdsh3sHU4zUYxNWmq5PT2Jt0nfYOf3x92Cu1MpMHnxc4b5APtL+v9fN798yJIBI7YZAwwtqkqKaFLKZw4m5iNYRvidoNz/F4sDB9yFF73PzREc3ISN5EdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Navi/hGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EE5C4CEF7;
	Wed,  5 Nov 2025 00:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303940;
	bh=ccWJ7ZHmyKrdhbGWUUP66iSoEuT3r0z/A0AvnV7HAdU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Navi/hGuZNJV7OzPKaKQvp/T9MqPuRUTCN5lE+Trr71S7M2lV9DEPTQJpbr/qY26o
	 W5XVXMAdL90qidflN8sr9u31zHmAMpZeORAHIODhZ8Iqsn+Bm06T9vDLNOWyfwKP7l
	 W3/lkDgZF9c2+MZ6tvVVPEilwuCb8gse+lKd3rc9v8JdP3Oxcz+VsvX/my+psR/k6y
	 LKGoB/xKuXz6Tq8ZLhRDZyNot3bqvLLcccR8ayNpDszuC7LAayEKZezAQ447GXu1rj
	 EYxsHseB36RJuItx3A6nH7Z8BmWdv1AEzdmSp2o0nYoWFwAHFlA71NIfDLLc6i0tXM
	 Dnxad6YW3BXoQ==
Date: Tue, 04 Nov 2025 16:52:19 -0800
Subject: [PATCH 15/22] xfs: report file io errors through healthmon
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230366018.1647136.3897563318662656465.stgit@frogsfrogsfrogs>
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

Set up a file io error event hook so that we can send events about read
errors, writeback errors, and directio errors to userspace.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   19 +++++++++
 fs/xfs/xfs_healthmon.h |   17 ++++++++
 fs/xfs/xfs_trace.h     |   59 +++++++++++++++++++++++++++++
 fs/xfs/xfs_healthmon.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_trace.c     |    1 
 5 files changed, 192 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 0711007344e16d..a96f11d9bd9c64 100644
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
@@ -1039,6 +1042,13 @@ struct xfs_rtgroup_geometry {
 /* media errors */
 #define XFS_HEALTH_MONITOR_TYPE_MEDIA_ERROR	(7)
 
+/* file range events */
+#define XFS_HEALTH_MONITOR_TYPE_BUFREAD		(8)
+#define XFS_HEALTH_MONITOR_TYPE_BUFWRITE	(9)
+#define XFS_HEALTH_MONITOR_TYPE_DIOREAD		(10)
+#define XFS_HEALTH_MONITOR_TYPE_DIOWRITE	(11)
+#define XFS_HEALTH_MONITOR_TYPE_DATALOST	(12)
+
 /* lost events */
 struct xfs_health_monitor_lost {
 	__u64	count;
@@ -1079,6 +1089,14 @@ struct xfs_health_monitor_shutdown {
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
@@ -1107,6 +1125,7 @@ struct xfs_health_monitor_event {
 		struct xfs_health_monitor_inode inode;
 		struct xfs_health_monitor_shutdown shutdown;
 		struct xfs_health_monitor_media media;
+		struct xfs_health_monitor_filerange filerange;
 	} e;
 
 	/* zeroes */
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index 407c5e1f466726..1ce49197262b1c 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -21,6 +21,13 @@ enum xfs_healthmon_type {
 
 	/* media errors */
 	XFS_HEALTHMON_MEDIA_ERROR,
+
+	/* file range events */
+	XFS_HEALTHMON_BUFREAD,
+	XFS_HEALTHMON_BUFWRITE,
+	XFS_HEALTHMON_DIOREAD,
+	XFS_HEALTHMON_DIOWRITE,
+	XFS_HEALTHMON_DATALOST,
 };
 
 enum xfs_healthmon_domain {
@@ -36,6 +43,9 @@ enum xfs_healthmon_domain {
 	XFS_HEALTHMON_DATADEV,
 	XFS_HEALTHMON_RTDEV,
 	XFS_HEALTHMON_LOGDEV,
+
+	/* file range events */
+	XFS_HEALTHMON_FILERANGE,
 };
 
 struct xfs_healthmon_event {
@@ -78,6 +88,13 @@ struct xfs_healthmon_event {
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
index 79805ee9aa64f5..d1836583d4dfbb 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -106,6 +106,7 @@ struct xfs_open_zone;
 struct xfs_healthmon_event;
 struct xfs_health_update_params;
 struct xfs_media_error_params;
+struct xfs_file_ioerror_params;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -6117,6 +6118,12 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
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
@@ -6255,6 +6262,58 @@ TRACE_EVENT(xfs_healthmon_media_error_hook,
 		  __entry->lost_prev)
 );
 #endif
+
+#define XFS_FILE_IOERROR_STRINGS \
+	{ XFS_FILE_IOERROR_BUFFERED_READ,	"readahead" }, \
+	{ XFS_FILE_IOERROR_BUFFERED_WRITE,	"writeback" }, \
+	{ XFS_FILE_IOERROR_DIRECT_READ,		"directio_read" }, \
+	{ XFS_FILE_IOERROR_DIRECT_WRITE,	"directio_write" }, \
+	{ XFS_FILE_IOERROR_DATA_LOST,		"datalost" }
+
+
+TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_BUFFERED_READ);
+TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_BUFFERED_WRITE);
+TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_DIRECT_READ);
+TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_DIRECT_WRITE);
+TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_DATA_LOST);
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
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index efc8ff554e42da..31c2f6f43cf474 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -22,6 +22,7 @@
 #include "xfs_healthmon.h"
 #include "xfs_fsops.h"
 #include "xfs_notify_failure.h"
+#include "xfs_file.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -69,6 +70,7 @@ struct xfs_healthmon {
 	struct xfs_shutdown_hook	shook;
 	struct xfs_health_hook		hhook;
 	struct xfs_media_error_hook	mhook;
+	struct xfs_file_ioerror_hook	fhook;
 
 	/* filesystem mount, or NULL if we've unmounted */
 	struct xfs_mount		*mp;
@@ -573,6 +575,77 @@ xfs_healthmon_media_error_hook(
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
+	case XFS_FILE_IOERROR_DATA_LOST:
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
+	case XFS_FILE_IOERROR_DATA_LOST:
+		type = XFS_HEALTHMON_DATALOST;
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
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -628,6 +701,7 @@ static const unsigned int domain_map[] = {
 	[XFS_HEALTHMON_DATADEV]		= XFS_HEALTH_MONITOR_DOMAIN_DATADEV,
 	[XFS_HEALTHMON_RTDEV]		= XFS_HEALTH_MONITOR_DOMAIN_RTDEV,
 	[XFS_HEALTHMON_LOGDEV]		= XFS_HEALTH_MONITOR_DOMAIN_LOGDEV,
+	[XFS_HEALTHMON_FILERANGE]	= XFS_HEALTH_MONITOR_DOMAIN_FILERANGE,
 };
 
 static const unsigned int type_map[] = {
@@ -639,6 +713,11 @@ static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
 	[XFS_HEALTHMON_SHUTDOWN]	= XFS_HEALTH_MONITOR_TYPE_SHUTDOWN,
 	[XFS_HEALTHMON_MEDIA_ERROR]	= XFS_HEALTH_MONITOR_TYPE_MEDIA_ERROR,
+	[XFS_HEALTHMON_BUFREAD]		= XFS_HEALTH_MONITOR_TYPE_BUFREAD,
+	[XFS_HEALTHMON_BUFWRITE]	= XFS_HEALTH_MONITOR_TYPE_BUFWRITE,
+	[XFS_HEALTHMON_DIOREAD]		= XFS_HEALTH_MONITOR_TYPE_DIOREAD,
+	[XFS_HEALTHMON_DIOWRITE]	= XFS_HEALTH_MONITOR_TYPE_DIOWRITE,
+	[XFS_HEALTHMON_DATALOST]	= XFS_HEALTH_MONITOR_TYPE_DATALOST,
 };
 
 /* Render event as a V0 structure */
@@ -699,6 +778,12 @@ xfs_healthmon_format_v0(
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
@@ -968,6 +1053,7 @@ xfs_healthmon_detach_hooks(
 	 * through the health monitoring subsystem from xfs_fs_put_super, so
 	 * it is now time to detach the hooks.
 	 */
+	xfs_file_ioerror_hook_del(hm->mp, &hm->fhook);
 	xfs_media_error_hook_del(hm->mp, &hm->mhook);
 	xfs_shutdown_hook_del(hm->mp, &hm->shook);
 	xfs_health_hook_del(hm->mp, &hm->hhook);
@@ -1127,12 +1213,18 @@ xfs_ioc_health_monitor(
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
 
@@ -1144,13 +1236,15 @@ xfs_ioc_health_monitor(
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


