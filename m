Return-Path: <linux-fsdevel+bounces-74790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGZOF2V0cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:38:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 497AC5224F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1C934C4BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74844B666;
	Wed, 21 Jan 2026 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwKmpnVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530D426D3C;
	Wed, 21 Jan 2026 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977401; cv=none; b=ioww3IdenV4crvDLW9e+5DQBlRUoeabsPx6IZmgpxZWUUMuj082W7RMbyE5kZvDeftggcd6xz32VpGuNlgt6wG3sL1oFHO7bdXbGom9vQ5W5TzhtO3zK59JnTpO4oTRBeibmTabbCfk6KB8RSL1UJA4eW0Pc3+oJ6SC3P5uWDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977401; c=relaxed/simple;
	bh=qYbB+M44fRo4mQVwShCWkpYgHlamPxvrC9EzhnwDJFE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBpLa6VoOj/LO1mAxkRRR3mToOKQzmXXxKIUMRzLIVD2bIVipTg1Cy4ISYHXQ3yksmY/LEgW4u/r+rZB0aciPQPdt2VayH5ZhDHMAiaTFPJ4wm2Ar1bYkRAhsw3pw8lLcFb6daJhzQOUgTj7tPv7QhrhOQwRrxgZ7IoghrYnW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwKmpnVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6B3C116D0;
	Wed, 21 Jan 2026 06:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768977399;
	bh=qYbB+M44fRo4mQVwShCWkpYgHlamPxvrC9EzhnwDJFE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FwKmpnVCH1K7zAw7OJi0aizaUinzUlgjRnZSy/Vu+SUQdmY7/kG5RN1Vmjyx461Yn
	 s+HOuXRfOXSBDnnO9qAiSgZXBxUzqGEH+kVr9AdmwhNIgP+iIn48UjvVcm68wW52C3
	 +miMfbHawrgKJkRzp0p2u9tpYtrVMu7VgQDfFKyT9FawPpBU3wVfMqf0mJAzyp/7zw
	 P6qMil7P3ArnrUxV4G9TyZHvqoFJU7ZWwtrGiZuMe02FoucAecOF9kqO5li+61K5Kw
	 OACFTIEIKUUUsAVImqp/b9o4SLRbPihkf9w93CZYNMs62C+cwG5N3CnZmcPnwq51Tn
	 sxlWdAPVsSjWQ==
Date: Tue, 20 Jan 2026 22:36:38 -0800
Subject: [PATCH 07/11] xfs: convey externally discovered fsdax media errors to
 the health monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 hch@lst.de
Message-ID: <176897695176.202109.10086645159111410464.stgit@frogsfrogsfrogs>
In-Reply-To: <176897694953.202109.15171131238404759078.stgit@frogsfrogsfrogs>
References: <176897694953.202109.15171131238404759078.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74790-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lst.de:email]
X-Rspamd-Queue-Id: 497AC5224F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Darrick J. Wong <djwong@kernel.org>

Connect the fsdax media failure notification code to the health monitor
so that xfs can send events about that to the xfs_healer daemon.

Later on we'll add the ability for the xfs_scrub media scan (phase 6) to
report the errors that it finds to the kernel so that those are also
logged by xfs_healer.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_fs.h      |   15 ++++++++++
 fs/xfs/xfs_healthmon.h      |   16 ++++++++++
 fs/xfs/xfs_trace.h          |   38 +++++++++++++++++++++++++
 fs/xfs/xfs_healthmon.c      |   66 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_notify_failure.c |   17 ++++++++---
 fs/xfs/xfs_trace.c          |    1 +
 6 files changed, 148 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index c8f7011a7ef8ef..38aeb1b0d87b5e 100644
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
index 1f68b5d65a8edc..54536aac427813 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -79,6 +79,9 @@ enum xfs_healthmon_type {
 	XFS_HEALTHMON_SICK,	/* runtime corruption observed */
 	XFS_HEALTHMON_CORRUPT,	/* fsck reported corruption */
 	XFS_HEALTHMON_HEALTHY,	/* fsck reported healthy structure */
+
+	/* media errors */
+	XFS_HEALTHMON_MEDIA_ERROR,
 };
 
 enum xfs_healthmon_domain {
@@ -89,6 +92,11 @@ enum xfs_healthmon_domain {
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
@@ -126,6 +134,11 @@ struct xfs_healthmon_event {
 		struct {
 			unsigned int	flags;
 		};
+		/* media errors */
+		struct {
+			xfs_daddr_t	daddr;
+			uint64_t	bbcount;
+		};
 	};
 };
 
@@ -141,6 +154,9 @@ void xfs_healthmon_report_inode(struct xfs_inode *ip,
 
 void xfs_healthmon_report_shutdown(struct xfs_mount *mp, uint32_t flags);
 
+void xfs_healthmon_report_media(struct xfs_mount *mp, enum xfs_device fdev,
+		xfs_daddr_t daddr, uint64_t bbcount);
+
 long xfs_ioc_health_monitor(struct file *file,
 		struct xfs_health_monitor __user *arg);
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index ec99a6d3dd318c..fe7295a4e917ee 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6086,6 +6086,12 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
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
@@ -6228,6 +6234,38 @@ TRACE_EVENT(xfs_healthmon_report_shutdown,
 		  __print_flags(__entry->shutdown_flags, "|", XFS_SHUTDOWN_STRINGS))
 );
 
+#define XFS_DEVICE_STRINGS \
+	{ XFS_DEV_DATA,		"datadev" }, \
+	{ XFS_DEV_RT,		"rtdev" }, \
+	{ XFS_DEV_LOG,		"logdev" }
+
+TRACE_DEFINE_ENUM(XFS_DEV_DATA);
+TRACE_DEFINE_ENUM(XFS_DEV_RT);
+TRACE_DEFINE_ENUM(XFS_DEV_LOG);
+
+TRACE_EVENT(xfs_healthmon_report_media,
+	TP_PROTO(const struct xfs_healthmon *hm, enum xfs_device fdev,
+		 const struct xfs_healthmon_event *event),
+	TP_ARGS(hm, fdev, event),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, error_dev)
+		__field(uint64_t, daddr)
+		__field(uint64_t, bbcount)
+	),
+	TP_fast_assign(
+		__entry->dev = hm->dev;
+		__entry->error_dev = fdev;
+		__entry->daddr = event->daddr;
+		__entry->bbcount = event->bbcount;
+	),
+	TP_printk("dev %d:%d %s daddr 0x%llx bbcount 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_symbolic(__entry->error_dev, XFS_DEVICE_STRINGS),
+		  __entry->daddr,
+		  __entry->bbcount)
+);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 97f764e7954152..773bd4414d947a 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -21,6 +21,7 @@
 #include "xfs_health.h"
 #include "xfs_healthmon.h"
 #include "xfs_fsops.h"
+#include "xfs_notify_failure.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -208,6 +209,19 @@ xfs_healthmon_merge_events(
 		/* yes, we can race to shutdown */
 		existing->flags |= new->flags;
 		return true;
+
+	case XFS_HEALTHMON_MEDIA_ERROR:
+		/* physically adjacent errors can merge */
+		if (existing->daddr + existing->bbcount == new->daddr) {
+			existing->bbcount += new->bbcount;
+			return true;
+		}
+		if (new->daddr + new->bbcount == existing->daddr) {
+			existing->daddr = new->daddr;
+			existing->bbcount += new->bbcount;
+			return true;
+		}
+		return false;
 	}
 
 	return false;
@@ -522,6 +536,48 @@ xfs_healthmon_report_shutdown(
 	xfs_healthmon_put(hm);
 }
 
+static inline enum xfs_healthmon_domain
+media_error_domain(
+	enum xfs_device			fdev)
+{
+	switch (fdev) {
+	case XFS_DEV_DATA:
+		return XFS_HEALTHMON_DATADEV;
+	case XFS_DEV_LOG:
+		return XFS_HEALTHMON_LOGDEV;
+	case XFS_DEV_RT:
+		return XFS_HEALTHMON_RTDEV;
+	}
+
+	ASSERT(0);
+	return 0;
+}
+
+/* Add a media error event to the reporting queue. */
+void
+xfs_healthmon_report_media(
+	struct xfs_mount		*mp,
+	enum xfs_device			fdev,
+	xfs_daddr_t			daddr,
+	uint64_t			bbcount)
+{
+	struct xfs_healthmon_event	event = {
+		.type			= XFS_HEALTHMON_MEDIA_ERROR,
+		.domain			= media_error_domain(fdev),
+		.daddr			= daddr,
+		.bbcount		= bbcount,
+	};
+	struct xfs_healthmon		*hm = xfs_healthmon_get(mp);
+
+	if (!hm)
+		return;
+
+	trace_xfs_healthmon_report_media(hm, fdev, &event);
+
+	xfs_healthmon_push(hm, &event);
+	xfs_healthmon_put(hm);
+}
+
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -574,6 +630,9 @@ static const unsigned int domain_map[] = {
 	[XFS_HEALTHMON_AG]		= XFS_HEALTH_MONITOR_DOMAIN_AG,
 	[XFS_HEALTHMON_INODE]		= XFS_HEALTH_MONITOR_DOMAIN_INODE,
 	[XFS_HEALTHMON_RTGROUP]		= XFS_HEALTH_MONITOR_DOMAIN_RTGROUP,
+	[XFS_HEALTHMON_DATADEV]		= XFS_HEALTH_MONITOR_DOMAIN_DATADEV,
+	[XFS_HEALTHMON_RTDEV]		= XFS_HEALTH_MONITOR_DOMAIN_RTDEV,
+	[XFS_HEALTHMON_LOGDEV]		= XFS_HEALTH_MONITOR_DOMAIN_LOGDEV,
 };
 
 static const unsigned int type_map[] = {
@@ -584,6 +643,7 @@ static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_HEALTHY]		= XFS_HEALTH_MONITOR_TYPE_HEALTHY,
 	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
 	[XFS_HEALTHMON_SHUTDOWN]	= XFS_HEALTH_MONITOR_TYPE_SHUTDOWN,
+	[XFS_HEALTHMON_MEDIA_ERROR]	= XFS_HEALTH_MONITOR_TYPE_MEDIA_ERROR,
 };
 
 /* Render event as a V0 structure */
@@ -635,6 +695,12 @@ xfs_healthmon_format_v0(
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
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 6d5002413c2cb4..1edc4ddd10cdb2 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -22,6 +22,7 @@
 #include "xfs_notify_failure.h"
 #include "xfs_rtgroup.h"
 #include "xfs_rtrmap_btree.h"
+#include "xfs_healthmon.h"
 
 #include <linux/mm.h>
 #include <linux/dax.h>
@@ -219,6 +220,8 @@ xfs_dax_notify_logdev_failure(
 	if (error)
 		return error;
 
+	xfs_healthmon_report_media(mp, XFS_DEV_LOG, daddr, bblen);
+
 	/*
 	 * In the pre-remove case the failure notification is attempting to
 	 * trigger a force unmount.  The expectation is that the device is
@@ -252,16 +255,20 @@ xfs_dax_notify_dev_failure(
 	uint64_t		bblen;
 	struct xfs_group	*xg = NULL;
 
+	error = xfs_dax_translate_range(xfs_group_type_buftarg(mp, type),
+			offset, len, &daddr, &bblen);
+	if (error)
+		return error;
+
+	xfs_healthmon_report_media(mp,
+			type == XG_TYPE_RTG ?  XFS_DEV_RT : XFS_DEV_DATA,
+			daddr, bblen);
+
 	if (!xfs_has_rmapbt(mp)) {
 		xfs_debug(mp, "notify_failure() needs rmapbt enabled!");
 		return -EOPNOTSUPP;
 	}
 
-	error = xfs_dax_translate_range(xfs_group_type_buftarg(mp, type),
-			offset, len, &daddr, &bblen);
-	if (error)
-		return error;
-
 	if (type == XG_TYPE_RTG) {
 		start_bno = xfs_daddr_to_rtb(mp, daddr);
 		end_bno = xfs_daddr_to_rtb(mp, daddr + bblen - 1);
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


