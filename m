Return-Path: <linux-fsdevel+bounces-72421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F962CF6FD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E2EF301D5C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E27309EF7;
	Tue,  6 Jan 2026 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glf1NEq6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCCF277C96;
	Tue,  6 Jan 2026 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683500; cv=none; b=kS7MxaZBKQd6QMyCd9zpdQWMVmpZhrCsCB9FIIpTHlPH2tKsTv0U0CVF6JYPEIkB2oF9+R1F8RB+KOKkz0/f8QZsqFoNdy8uU9bwsWRa4mVl1LKVoSpEBMu253nRcpCA5OThKt7JuvqsAslLoDHL9fy4NEVSHh3XW2vtYVTW278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683500; c=relaxed/simple;
	bh=47DfBaJiZCXf0+azHJcmKsuRkzo6/cS1Z7gPwMT9ZHE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/ieI+QZo1NERGlhNa9J/zogMArwGfUBwk7fJ79rwGXsGnigb98wFkdUB+D4iF191mNz3usqs8+lbve7ek4Efgb5FkmSBRXwiiPI3JHuUBxBEb4gwBhBx08EpINi7EGfBkJls0BC/obmwheRoGupf6yYjxjVy0hLugSPU2VCJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glf1NEq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53558C116C6;
	Tue,  6 Jan 2026 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683500;
	bh=47DfBaJiZCXf0+azHJcmKsuRkzo6/cS1Z7gPwMT9ZHE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Glf1NEq60bkwMe2xvTmc7t4Dtk65QvjnaSDOZkK8za4/+WxXtT8pM1qTWl8FIcpD/
	 ryE4zVJiAwwBBiJ6oVOp+LeeRd/L3UU+JRdhsjjScn/aqsppabDbNyur9ddf8a/yfP
	 8ltmtv4G2FdvKOM6WPhpCnrzUV5uL0ktFqEMPJhYP0SDKt1DGc0XiRmRHuFRwCV76X
	 qCkX+clpgm1FFz8VPgLhTBP/KFfwDtGLWBjXmxcJihYdSRjRcO3DZcJ3S8F9DRGCyz
	 boCM9v8066W6piwCp91eRMWlFvfaQJW44V/AOdDjjmZBmHVg3yiOylCOBSzz9QO/8n
	 Yc4e03qW+5Sxw==
Date: Mon, 05 Jan 2026 23:11:39 -0800
Subject: [PATCH 04/11] xfs: convey filesystem unmount events to the health
 monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176766637333.774337.13825109439227352874.stgit@frogsfrogsfrogs>
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

In xfs_healthmon_unmount, send events to xfs_healer so that it knows
that nothing further can be done for the filesystem.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |    3 +++
 fs/xfs/xfs_healthmon.h |    1 +
 fs/xfs/xfs_trace.h     |    6 +++++-
 fs/xfs/xfs_healthmon.c |   34 +++++++++++++++++++++++++++++++++-
 4 files changed, 42 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index dfca42b2c31192..d0a24eb56b3e0f 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1014,6 +1014,9 @@ struct xfs_rtgroup_geometry {
 #define XFS_HEALTH_MONITOR_TYPE_RUNNING		(0)
 #define XFS_HEALTH_MONITOR_TYPE_LOST		(1)
 
+/* filesystem was unmounted */
+#define XFS_HEALTH_MONITOR_TYPE_UNMOUNT		(2)
+
 /* lost events */
 struct xfs_health_monitor_lost {
 	__u64	count;
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index 600f8a3e52196d..63e6c110bd378a 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -67,6 +67,7 @@ void xfs_healthmon_unmount(struct xfs_mount *mp);
 enum xfs_healthmon_type {
 	XFS_HEALTHMON_RUNNING,	/* monitor running */
 	XFS_HEALTHMON_LOST,	/* message lost */
+	XFS_HEALTHMON_UNMOUNT,	/* filesystem is unmounting */
 };
 
 enum xfs_healthmon_domain {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 04727470b3b410..305cae8f497b43 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6005,14 +6005,18 @@ DEFINE_HEALTHMON_EVENT(xfs_healthmon_read_start);
 DEFINE_HEALTHMON_EVENT(xfs_healthmon_read_finish);
 DEFINE_HEALTHMON_EVENT(xfs_healthmon_release);
 DEFINE_HEALTHMON_EVENT(xfs_healthmon_detach);
+DEFINE_HEALTHMON_EVENT(xfs_healthmon_report_unmount);
 
 #define XFS_HEALTHMON_TYPE_STRINGS \
-	{ XFS_HEALTHMON_LOST,		"lost" }
+	{ XFS_HEALTHMON_LOST,		"lost" }, \
+	{ XFS_HEALTHMON_UNMOUNT,	"unmount" }
 
 #define XFS_HEALTHMON_DOMAIN_STRINGS \
 	{ XFS_HEALTHMON_MOUNT,		"mount" }
 
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_LOST);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_UNMOUNT);
+
 TRACE_DEFINE_ENUM(XFS_HEALTHMON_MOUNT);
 
 DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 799e0687ae3263..2a94f0a0bcd5c8 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -206,6 +206,7 @@ xfs_healthmon_merge_events(
 
 	switch (existing->type) {
 	case XFS_HEALTHMON_RUNNING:
+	case XFS_HEALTHMON_UNMOUNT:
 		/* should only ever be one of these events anyway */
 		return false;
 
@@ -355,16 +356,47 @@ xfs_healthmon_push(
 	return error;
 }
 
-/* Detach the xfs mount from this healthmon instance. */
+/*
+ * Report that the filesystem is being unmounted, then detach the xfs mount
+ * from this healthmon instance.
+ */
 void
 xfs_healthmon_unmount(
 	struct xfs_mount		*mp)
 {
 	struct xfs_healthmon		*hm = xfs_healthmon_get(mp);
+	struct xfs_healthmon_event	*event;
 
 	if (!hm)
 		return;
 
+	event = kzalloc(sizeof(struct xfs_healthmon_event), GFP_NOFS);
+	mutex_lock(&hm->lock);
+
+	trace_xfs_healthmon_report_unmount(hm);
+
+	if (event) {
+		/*
+		 * Insert the unmount notification at the start of the event
+		 * queue so that userspace knows the filesystem went away as
+		 * soon as possible.  There's nothing actionable for userspace
+		 * after an unmount.
+		 */
+		event->type = XFS_HEALTHMON_UNMOUNT;
+		event->domain = XFS_HEALTHMON_MOUNT;
+
+		__xfs_healthmon_insert(hm, event);
+	} else {
+		/*
+		 * Wake up the reader directly in case we didn't have enough
+		 * memory to queue the unmount event.  The filesystem is about
+		 * to go away so we don't care about reporting previously lost
+		 * events.
+		 */
+		wake_up(&hm->wait);
+	}
+	mutex_unlock(&hm->lock);
+
 	xfs_healthmon_detach(hm);
 	xfs_healthmon_put(hm);
 }


