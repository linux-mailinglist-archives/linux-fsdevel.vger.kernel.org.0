Return-Path: <linux-fsdevel+bounces-67036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2666C33896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA0154F526A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89F323EAA1;
	Wed,  5 Nov 2025 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB852BfZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37923ABB9;
	Wed,  5 Nov 2025 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303909; cv=none; b=X5UfThcMMl6Dios1lyLdkX1CvcdHFepNmEseAiB0+c9igD6gZfcez2hOz7zIYW/W/hIxFPCCZVX5/bnBOoLRE1I4AqL6jRWEBQzYeQqsqM+XX/brGzhfotpKXjKhCaYINO/QgyGRZpVG/RMfiRZj3Jboxia0R2tBJsUgt/zbkcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303909; c=relaxed/simple;
	bh=44IOtXOyScgdCwOgz/Ih03tc9stQQmpwvIGsfot7Y5s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGjcvCTcttQOAwfD43jYSbeKMYjSNuGqxNojodwGnaWgFOAJg1ucarGvakAmoR04xuApOxcd1sSk3DhU22b+s8kxPa8ge2VHIINX5FwxQghHRMgAF02pmbE1pPO55N3mkn60njub/xHekaHf/pu7wcyw1nZ7dFkqbNV1ATAILAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB852BfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2650DC116D0;
	Wed,  5 Nov 2025 00:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303909;
	bh=44IOtXOyScgdCwOgz/Ih03tc9stQQmpwvIGsfot7Y5s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NB852BfZkGmHw8K875KZxEBHXzEehVSM1bCel9DMy+mx1c5rHBZlKHSSn0l9yLi/H
	 sZvdF0cjM+navXyN6vDwqg4Wga9g0DggRcQjtpqYWLrUh53uC/4QXUhR1GMDuikuQ3
	 VoToZk3AIzGMbBLHq9k8iDLBDMEYhTVgcufq8cigDEN7lyP6QckNBhlGiXLhpIhHit
	 TtDm1DUYfKNsb6KW3RJCylwUZWmFU2zrE18MpiV/5XVrBos0BQ3rvA4REkbec9tUhH
	 S9hPRG30qq7PCPqr8CX5HoYnytxjf7Vbx/R5c5WN8ywEpAU/CnXoz44Kwu4/ZIeDl7
	 Q9Mr6UG9CfEZw==
Date: Tue, 04 Nov 2025 16:51:48 -0800
Subject: [PATCH 13/22] xfs: report shutdown events through healthmon
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230365973.1647136.13239874141612781194.stgit@frogsfrogsfrogs>
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

Set up a shutdown hook so that we can send notifications to userspace.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   18 +++++++++
 fs/xfs/xfs_healthmon.h |    5 ++-
 fs/xfs/xfs_trace.h     |   28 ++++++++++++++
 fs/xfs/xfs_healthmon.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 141 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 2ad45351ac0ea6..677141a17605a4 100644
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
index 051599f8433ed6..b2b056ceb52f5c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6009,8 +6009,32 @@ DEFINE_HEALTHMON_EVENT(xfs_healthmon_read_finish);
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
@@ -6024,6 +6048,7 @@ DEFINE_HEALTHMON_EVENT(xfs_healthmon_unmount);
 	{ XFS_HEALTHMON_RTGROUP,	"rtgroup" }
 
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_LOST);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_SHUTDOWN);
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_UNMOUNT);
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_SICK);
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_CORRUPT);
@@ -6064,6 +6089,9 @@ DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
 		switch (__entry->domain) {
 		case XFS_HEALTHMON_MOUNT:
 			switch (__entry->type) {
+			case XFS_HEALTHMON_SHUTDOWN:
+				__entry->mask = event->flags;
+				break;
 			case XFS_HEALTHMON_LOST:
 				__entry->lostcount = event->lostcount;
 				break;
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index d1474e6b9ab544..f36d7fbfb1ca16 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -20,6 +20,7 @@
 #include "xfs_rtgroup.h"
 #include "xfs_health.h"
 #include "xfs_healthmon.h"
+#include "xfs_fsops.h"
 
 #include <linux/anon_inodes.h>
 #include <linux/eventpoll.h>
@@ -64,6 +65,7 @@ struct xfs_healthmon {
 	struct xfs_healthmon_event	*last_event;
 
 	/* live update hooks */
+	struct xfs_shutdown_hook	shook;
 	struct xfs_health_hook		hhook;
 
 	/* filesystem mount, or NULL if we've unmounted */
@@ -479,6 +481,43 @@ xfs_healthmon_metadata_hook(
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
 static inline void
 xfs_healthmon_reset_outbuf(
 	struct xfs_healthmon		*hm)
@@ -487,6 +526,44 @@ xfs_healthmon_reset_outbuf(
 	seq_buf_clear(&hm->outbuf);
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
@@ -502,6 +579,7 @@ static const unsigned int type_map[] = {
 	[XFS_HEALTHMON_CORRUPT]		= XFS_HEALTH_MONITOR_TYPE_CORRUPT,
 	[XFS_HEALTHMON_HEALTHY]		= XFS_HEALTH_MONITOR_TYPE_HEALTHY,
 	[XFS_HEALTHMON_UNMOUNT]		= XFS_HEALTH_MONITOR_TYPE_UNMOUNT,
+	[XFS_HEALTHMON_SHUTDOWN]	= XFS_HEALTH_MONITOR_TYPE_SHUTDOWN,
 };
 
 /* Render event as a V0 structure */
@@ -533,6 +611,9 @@ xfs_healthmon_format_v0(
 		case XFS_HEALTHMON_LOST:
 			hme.e.lost.count = event->lostcount;
 			break;
+		case XFS_HEALTHMON_SHUTDOWN:
+			hme.e.shutdown.reasons = shutdown_mask(event->flags);
+			break;
 		default:
 			break;
 		}
@@ -822,6 +903,7 @@ xfs_healthmon_detach_hooks(
 	 * through the health monitoring subsystem from xfs_fs_put_super, so
 	 * it is now time to detach the hooks.
 	 */
+	xfs_shutdown_hook_del(hm->mp, &hm->shook);
 	xfs_health_hook_del(hm->mp, &hm->hhook);
 	return;
 
@@ -969,12 +1051,17 @@ xfs_ioc_health_monitor(
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
 
@@ -986,13 +1073,15 @@ xfs_ioc_health_monitor(
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


