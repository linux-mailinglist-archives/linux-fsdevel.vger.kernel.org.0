Return-Path: <linux-fsdevel+bounces-74789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIcoIFd0cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:38:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368252241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C3904C3E89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85144A727;
	Wed, 21 Jan 2026 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfrI+yTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B827449ED0;
	Wed, 21 Jan 2026 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977384; cv=none; b=l4Ng0LfzQyPNAccyb9f6ijfioowog5eyv4JiftZW6eixp6IzFJvz8uKCBdbQ1VScYuhSCQv9+t7d9jLMeHs7XMitEYFbq24+AgPfTgdQl7vllOXpsqEh2MPz/nMk9nqsPbRx266gFSZXm0eeO2ZZCuvG2l27lk6nkVIXp2cMOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977384; c=relaxed/simple;
	bh=Uj8hwLa/5dB3ORdcY+AELli73YZiy+TO+GNDJUZUqqE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYR44zuJg4BsZ/xbMXPJISQumZ2OT3XfAThizGi5J7Wd7RIJlZhqKew7Lj7AwDy0x9/RjNmlljhdCrWhI/KkJZ6WnKs5fHHUEcjqhReLD6y8D8/JJNtEUbwnvb460Rmv6Ad29sEjIocHcJQcscsjVbIkaIPn/fqmOlMYN34aZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfrI+yTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3757C116D0;
	Wed, 21 Jan 2026 06:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768977383;
	bh=Uj8hwLa/5dB3ORdcY+AELli73YZiy+TO+GNDJUZUqqE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QfrI+yTw+4FAe5PjdARaNHMasgVx23Enyhia1tuH8umSf2KHxyLvQXgdF4KKzOdZ0
	 OeZxFL9FcfDW8iDyLhIzxAf49jo9UbSEno+GmmDoaWjHbpnACeQlvhpIaTqnxmdheU
	 mJ3SwrJexeIbG6BWgM37V+ubic+aVEglmsXb+Ot8nfj6AAiHzzEbA1gPBOrLV6aFCi
	 vZ2+J6kzPtdnZMgNebxH8v33MMV/1Hk8yBAmcwrwvGLbmAuzu5irrLlHEj9+krWh3G
	 NoMaFiF4m7a+7V9yC60uTvvA6BPpk3ROlyubt3jhg75FVtyKZ/HmMxQ7Rs1hws+Qpt
	 C7aVPDcIe8C3g==
Date: Tue, 20 Jan 2026 22:36:23 -0800
Subject: [PATCH 06/11] xfs: convey filesystem shutdown events to the health
 monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 hch@lst.de
Message-ID: <176897695153.202109.10045181961938577201.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-74789-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lst.de:email]
X-Rspamd-Queue-Id: 6368252241
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Darrick J. Wong <djwong@kernel.org>

Connect the filesystem shutdown code to the health monitor so that xfs
can send events about that to the xfs_healer daemon.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


