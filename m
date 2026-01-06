Return-Path: <linux-fsdevel+bounces-72425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB8CF7008
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D418C30754F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD3C309EE9;
	Tue,  6 Jan 2026 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5hQJm7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A982C0307;
	Tue,  6 Jan 2026 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683563; cv=none; b=SpDmt4E+cRGduy6+gBoY1T0II35RWrYwCEXO7DVxTTYPN4FuEreFQM14U4uPkqsdbkocNdRfXwUfiwaa3ZDtbcwOqP/hFuqxe6DsNM7QLVFCLt8NjUJFaalC0/xVxmtvxce5HZeqKAPVwspmWI/s4ronM82I3G8DzHQH7/uvdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683563; c=relaxed/simple;
	bh=caOpKRZP7Z6VXcOk4ThnnuXclfdN7VaBrC0SgJxCKqI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXreDNATpcPKdb7wxy/obcwWNbJnhuUqlGLUDFFSB6wgOhgcUdTW+49mpW1fzPN24tmrPaz1H2djHMjZa4ENkY+C009+l3FLXdmabkUqpZlhhtAkZHob7Oj+y9kMTPtPpPowZUtjn1DS3c9G9oSy3wwHuOhZgdZXI8VB9P2iHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5hQJm7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB43C116C6;
	Tue,  6 Jan 2026 07:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683563;
	bh=caOpKRZP7Z6VXcOk4ThnnuXclfdN7VaBrC0SgJxCKqI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Z5hQJm7Mv2frT6+C7FfOtIZRvWb3S1tsuqJvdBcZIiP2n8EnLbxD4XZmNZF8d1NVi
	 HIn/gBWZxkon/1X87TRkk50+v8c+dY4O1nbUC4YmvalpXE5UMS7XtAl7x1bgE62Wv6
	 RI10Cwj5dI774TUNV3+aFaPuDHsueOoMibTVOSZJc320WEdpN1jiWxgN2EJSv5tRHG
	 4YNzKEm4cn1Z0TzzySjihB6YmG870/79X+txx1oo1KDRsOheNLfix8rgMktQVBXLEY
	 Ml21QHsSVT/R3MN1busANBZSyi8ogM3xc6kHXwVGeOkR1BRpkwxv/E+uHdw0Af9Mgr
	 1KaEN2Sd3uBAw==
Date: Mon, 05 Jan 2026 23:12:42 -0800
Subject: [PATCH 08/11] xfs: convey file I/O errors to the health monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176766637421.774337.94510884010750487.stgit@frogsfrogsfrogs>
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

Connect the fserror reporting to the health monitor so that xfs can send
events about file I/O errors to the xfs_healer daemon.  These events are
entirely informational because xfs cannot regenerate user data, so
hopefully the fsnotify I/O error event gets noticed by the relevant
management systems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   24 ++++++++++++++
 fs/xfs/xfs_healthmon.h |   21 ++++++++++++
 fs/xfs/xfs_trace.h     |   54 ++++++++++++++++++++++++++++++
 fs/xfs/xfs_healthmon.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_super.c     |   12 +++++++
 fs/xfs/xfs_trace.c     |    2 +
 6 files changed, 198 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 486677c79b8608..ff160a5665601b 100644
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
@@ -1039,6 +1042,17 @@ struct xfs_rtgroup_geometry {
 /* media errors */
 #define XFS_HEALTH_MONITOR_TYPE_MEDIA_ERROR	(7)
 
+/* pagecache I/O to a file range failed */
+#define XFS_HEALTH_MONITOR_TYPE_BUFREAD		(8)
+#define XFS_HEALTH_MONITOR_TYPE_BUFWRITE	(9)
+
+/* direct I/O to a file range failed */
+#define XFS_HEALTH_MONITOR_TYPE_DIOREAD		(10)
+#define XFS_HEALTH_MONITOR_TYPE_DIOWRITE	(11)
+
+/* out of band media error reported for a file range */
+#define XFS_HEALTH_MONITOR_TYPE_DATALOST	(12)
+
 /* lost events */
 struct xfs_health_monitor_lost {
 	__u64	count;
@@ -1079,6 +1093,15 @@ struct xfs_health_monitor_shutdown {
 	__u32	reasons;
 };
 
+/* file range events */
+struct xfs_health_monitor_filerange {
+	__u64	pos;
+	__u64	len;
+	__u64	ino;
+	__u32	gen;
+	__u32	error;
+};
+
 /* disk media errors */
 struct xfs_health_monitor_media {
 	__u64	daddr;
@@ -1107,6 +1130,7 @@ struct xfs_health_monitor_event {
 		struct xfs_health_monitor_inode inode;
 		struct xfs_health_monitor_shutdown shutdown;
 		struct xfs_health_monitor_media media;
+		struct xfs_health_monitor_filerange filerange;
 	} e;
 
 	/* zeroes */
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index cbf1e98bde3d00..215290ade011d5 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -79,6 +79,13 @@ enum xfs_healthmon_type {
 
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
@@ -94,6 +101,9 @@ enum xfs_healthmon_domain {
 	XFS_HEALTHMON_DATADEV,
 	XFS_HEALTHMON_RTDEV,
 	XFS_HEALTHMON_LOGDEV,
+
+	/* file range events */
+	XFS_HEALTHMON_FILERANGE,
 };
 
 struct xfs_healthmon_event {
@@ -136,6 +146,14 @@ struct xfs_healthmon_event {
 			xfs_daddr_t	daddr;
 			uint64_t	bbcount;
 		};
+		/* file range events */
+		struct {
+			xfs_ino_t	fino;
+			loff_t		fpos;
+			uint64_t	flen;
+			uint32_t	fgen;
+			int		error;
+		};
 	};
 };
 
@@ -154,6 +172,9 @@ void xfs_healthmon_report_shutdown(struct xfs_mount *mp, uint32_t flags);
 void xfs_healthmon_report_media(struct xfs_mount *mp, enum xfs_device fdev,
 		xfs_daddr_t daddr, uint64_t bbcount);
 
+void xfs_healthmon_report_file_ioerror(struct xfs_inode *ip,
+		const struct fserror_event *p);
+
 long xfs_ioc_health_monitor(struct file *file,
 		struct xfs_health_monitor __user *arg);
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index fe7295a4e917ee..0cf4877753584f 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -105,6 +105,7 @@ struct xfs_rtgroup;
 struct xfs_open_zone;
 struct xfs_healthmon_event;
 struct xfs_healthmon;
+struct fserror_event;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -6092,6 +6093,12 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
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
@@ -6266,6 +6273,53 @@ TRACE_EVENT(xfs_healthmon_report_media,
 		  __entry->bbcount)
 );
 
+#define FS_ERROR_STRINGS \
+	{ FSERR_BUFFERED_READ,		"buffered_read" }, \
+	{ FSERR_BUFFERED_WRITE,		"buffered_write" }, \
+	{ FSERR_DIRECTIO_READ,		"directio_read" }, \
+	{ FSERR_DIRECTIO_WRITE,		"directio_write" }, \
+	{ FSERR_DATA_LOST,		"data_lost" }, \
+	{ FSERR_METADATA,		"metadata" }
+
+TRACE_DEFINE_ENUM(FSERR_BUFFERED_READ);
+TRACE_DEFINE_ENUM(FSERR_BUFFERED_WRITE);
+TRACE_DEFINE_ENUM(FSERR_DIRECTIO_READ);
+TRACE_DEFINE_ENUM(FSERR_DIRECTIO_WRITE);
+TRACE_DEFINE_ENUM(FSERR_DATA_LOST);
+TRACE_DEFINE_ENUM(FSERR_METADATA);
+
+TRACE_EVENT(xfs_healthmon_report_file_ioerror,
+	TP_PROTO(const struct xfs_healthmon *hm,
+		 const struct fserror_event *p),
+	TP_ARGS(hm, p),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, type)
+		__field(unsigned long long, ino)
+		__field(unsigned int, gen)
+		__field(long long, pos)
+		__field(unsigned long long, len)
+		__field(int, error)
+	),
+	TP_fast_assign(
+		__entry->dev = hm->dev;
+		__entry->type = p->type;
+		__entry->ino = XFS_I(p->inode)->i_ino;
+		__entry->gen = p->inode->i_generation;
+		__entry->pos = p->pos;
+		__entry->len = p->len;
+		__entry->error = p->error;
+	),
+	TP_printk("dev %d:%d ino 0x%llx gen 0x%x op %s pos 0x%llx bytecount 0x%llx error %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->gen,
+		  __print_symbolic(__entry->type, FS_ERROR_STRINGS),
+		  __entry->pos,
+		  __entry->len,
+		  __entry->error)
+);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 8cf685b1dda1c2..4e785c0120ccfb 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -22,10 +22,12 @@
 #include "xfs_healthmon.h"
 #include "xfs_fsops.h"
 #include "xfs_notify_failure.h"
+#include "xfs_file.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
 #include <linux/poll.h>
+#include <linux/fserror.h>
 
 /*
  * Live Health Monitoring
@@ -261,6 +263,27 @@ xfs_healthmon_merge_events(
 			return true;
 		}
 		return false;
+
+	case XFS_HEALTHMON_BUFREAD:
+	case XFS_HEALTHMON_BUFWRITE:
+	case XFS_HEALTHMON_DIOREAD:
+	case XFS_HEALTHMON_DIOWRITE:
+	case XFS_HEALTHMON_DATALOST:
+		/* logically adjacent file ranges can merge */
+		if (existing->fino != new->fino || existing->fgen != new->fgen)
+			return false;
+
+		if (existing->fpos + existing->flen == new->fpos) {
+			existing->flen += new->flen;
+			return true;
+		}
+
+		if (new->fpos + new->flen == existing->fpos) {
+			existing->fpos = new->fpos;
+			existing->flen += new->flen;
+			return true;
+		}
+		return false;
 	}
 
 	return false;
@@ -642,6 +665,55 @@ xfs_healthmon_report_media(
 	xfs_healthmon_put(hm);
 }
 
+static inline enum xfs_healthmon_type file_ioerr_type(enum fserror_type action)
+{
+	switch (action) {
+	case FSERR_BUFFERED_READ:
+		return XFS_HEALTHMON_BUFREAD;
+	case FSERR_BUFFERED_WRITE:
+		return XFS_HEALTHMON_BUFWRITE;
+	case FSERR_DIRECTIO_READ:
+		return XFS_HEALTHMON_DIOREAD;
+	case FSERR_DIRECTIO_WRITE:
+		return XFS_HEALTHMON_DIOWRITE;
+	case FSERR_DATA_LOST:
+		return XFS_HEALTHMON_DATALOST;
+	case FSERR_METADATA:
+		/* filtered out by xfs_fs_report_error */
+		break;
+	}
+
+	ASSERT(0);
+	return -1;
+}
+
+/* Add a file io error event to the reporting queue. */
+void
+xfs_healthmon_report_file_ioerror(
+	struct xfs_inode		*ip,
+	const struct fserror_event	*p)
+{
+	struct xfs_healthmon_event	event = {
+		.type			= file_ioerr_type(p->type),
+		.domain			= XFS_HEALTHMON_FILERANGE,
+		.fino			= ip->i_ino,
+		.fgen			= VFS_I(ip)->i_generation,
+		.fpos			= p->pos,
+		.flen			= p->len,
+		/* send positive error number to userspace */
+		.error			= -p->error,
+	};
+	struct xfs_healthmon		*hm = xfs_healthmon_get(ip->i_mount);
+
+	if (!hm)
+		return;
+
+	trace_xfs_healthmon_report_file_ioerror(hm, p);
+
+	xfs_healthmon_push(hm, &event);
+	xfs_healthmon_put(hm);
+}
+
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -697,6 +769,7 @@ static const unsigned int domain_map[] = {
 	[XFS_HEALTHMON_DATADEV]		= XFS_HEALTH_MONITOR_DOMAIN_DATADEV,
 	[XFS_HEALTHMON_RTDEV]		= XFS_HEALTH_MONITOR_DOMAIN_RTDEV,
 	[XFS_HEALTHMON_LOGDEV]		= XFS_HEALTH_MONITOR_DOMAIN_LOGDEV,
+	[XFS_HEALTHMON_FILERANGE]	= XFS_HEALTH_MONITOR_DOMAIN_FILERANGE,
 };
 
 static const unsigned int type_map[] = {
@@ -708,6 +781,11 @@ static const unsigned int type_map[] = {
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
@@ -765,6 +843,13 @@ xfs_healthmon_format_v0(
 		hme.e.media.daddr = event->daddr;
 		hme.e.media.bbcount = event->bbcount;
 		break;
+	case XFS_HEALTHMON_FILERANGE:
+		hme.e.filerange.ino = event->fino;
+		hme.e.filerange.gen = event->fgen;
+		hme.e.filerange.pos = event->fpos;
+		hme.e.filerange.len = event->flen;
+		hme.e.filerange.error = abs(event->error);
+		break;
 	default:
 		break;
 	}
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bc71aa9dcee8d6..d0cef9ce6b8992 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -47,12 +47,14 @@
 #include "xfs_parent.h"
 #include "xfs_rtalloc.h"
 #include "xfs_zone_alloc.h"
+#include "xfs_healthmon.h"
 #include "scrub/stats.h"
 #include "scrub/rcbag_btree.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fserror.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -1301,6 +1303,15 @@ xfs_fs_show_stats(
 	return 0;
 }
 
+static void
+xfs_fs_report_error(
+	const struct fserror_event	*event)
+{
+	/* healthmon already knows about non-inode and metadata errors */
+	if (event->inode && event->type != FSERR_METADATA)
+		xfs_healthmon_report_file_ioerror(XFS_I(event->inode), event);
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1317,6 +1328,7 @@ static const struct super_operations xfs_super_operations = {
 	.free_cached_objects	= xfs_fs_free_cached_objects,
 	.shutdown		= xfs_fs_shutdown,
 	.show_stats		= xfs_fs_show_stats,
+	.report_error		= xfs_fs_report_error,
 };
 
 static int
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index 08ddab700a6cd3..3ae449646eb9b2 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -54,6 +54,8 @@
 #include "xfs_health.h"
 #include "xfs_healthmon.h"
 #include "xfs_notify_failure.h"
+#include "xfs_file.h"
+#include <linux/fserror.h>
 
 /*
  * We include this last to have the helpers above available for the trace


