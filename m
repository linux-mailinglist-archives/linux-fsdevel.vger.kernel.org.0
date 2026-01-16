Return-Path: <linux-fsdevel+bounces-74051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B85D2C176
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 06:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B4B3027D84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 05:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A865347BAF;
	Fri, 16 Jan 2026 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gdlftks8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3532F5485;
	Fri, 16 Jan 2026 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542184; cv=none; b=cspJLGmYYL+rHwLLLq/igJ22hCKzWhqqoTAa2rxzH2KmfUQSSJk3GpODIkNqySCg7XhP+ciMnFLtzWH1z+KEO8jy4WXa1+ybHsYDU3rfkmQRVfkacxRZuLmg/W4n/Mto68CBjFcmjmYV9x5A0ydbmtNCuPBgUcDvdd8xay/tSvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542184; c=relaxed/simple;
	bh=8snCcpETQzfjuoCwP8ANhUrRMj2ky31iIZ+HAobM0t4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVpk3c6AQSvBjXVKpWWywdU/7x/YCj7SBd6j/UhvEIYYIrur+xv7ll9Iwdl/+cw3vGzpLPW3jtAeE7FwE46bmflYC2VNdkDo90s6gYyzJx/b+lZcCGcoST96jq4Iaa6rKczHNQKMGgCT+Y0xXvkcouEA+Nx9QDktMVY8Y9LgDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gdlftks8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F796C116C6;
	Fri, 16 Jan 2026 05:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768542184;
	bh=8snCcpETQzfjuoCwP8ANhUrRMj2ky31iIZ+HAobM0t4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Gdlftks8aBYCjl/M9Ya9GOanVP++haPgQ9d72UA8LTw9lhUnnXTrsoM1ct4qoTwdL
	 1nlsqF4zwwwxC72C2DH0iapD3x8CezL1bqKY7WsS6Icg8ruCvU3N/CkQDXFTFclOz6
	 GGTzpivB63Itqu7GF+ykM4YKm7Tc1Fcwr1vzP+11nYigh9Tu1C2jALj/MZP61NeTTy
	 D9stOeyJv32zznVms9p72TezjAyc39tpsKg13+wYxL0EQMh5zCoJSS+TqqrN1dyCIX
	 +U0Bv3kuN9TAxd/xIxrA00S0kRMd+6I+PsQrP6QbhuHTWXwfvfPtaFTVeJ4Cdw4tE9
	 NcwjJylk4g6bw==
Date: Thu, 15 Jan 2026 21:43:03 -0800
Subject: [PATCH 04/11] xfs: convey filesystem unmount events to the health
 monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de
Message-ID: <176852588626.2137143.5311489734226892176.stgit@frogsfrogsfrogs>
In-Reply-To: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
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
 fs/xfs/xfs_healthmon.h |    4 ++++
 fs/xfs/xfs_trace.h     |    6 +++++-
 fs/xfs/xfs_healthmon.c |   32 +++++++++++++++++++++++++++++++-
 4 files changed, 43 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 22b86bc888de5a..59de6ab69fb319 100644
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
index 554ec62125449b..3044bb46485d7e 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -34,6 +34,9 @@ struct xfs_healthmon {
 	struct xfs_healthmon_event	*first_event;
 	struct xfs_healthmon_event	*last_event;
 
+	/* preallocated event for unmount */
+	struct xfs_healthmon_event	*unmount_event;
+
 	/* number of events in the list */
 	unsigned int			events;
 
@@ -67,6 +70,7 @@ void xfs_healthmon_unmount(struct xfs_mount *mp);
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
index f1c6782f5e3915..c218838e6e59f4 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -90,6 +90,7 @@ xfs_healthmon_put(
 			kfree(event);
 		}
 
+		kfree(hm->unmount_event);
 		kfree(hm->buffer);
 		mutex_destroy(&hm->lock);
 		kfree_rcu_mightsleep(hm);
@@ -166,6 +167,7 @@ xfs_healthmon_merge_events(
 
 	switch (existing->type) {
 	case XFS_HEALTHMON_RUNNING:
+	case XFS_HEALTHMON_UNMOUNT:
 		/* should only ever be one of these events anyway */
 		return false;
 
@@ -307,7 +309,10 @@ xfs_healthmon_push(
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
@@ -317,6 +322,17 @@ xfs_healthmon_unmount(
 	if (!hm)
 		return;
 
+	trace_xfs_healthmon_report_unmount(hm);
+
+	/*
+	 * Insert the unmount notification at the start of the event queue so
+	 * that userspace knows the filesystem went away as soon as possible.
+	 * There's nothing actionable for userspace after an unmount.  Once
+	 * we've inserted the unmount event, hm no longer owns that event.
+	 */
+	__xfs_healthmon_insert(hm, hm->unmount_event);
+	hm->unmount_event = NULL;
+
 	xfs_healthmon_detach(hm);
 	xfs_healthmon_put(hm);
 }
@@ -713,6 +729,20 @@ xfs_ioc_health_monitor(
 	running_event->domain = XFS_HEALTHMON_MOUNT;
 	__xfs_healthmon_insert(hm, running_event);
 
+	/*
+	 * Preallocate the unmount event so that we can't fail to notify the
+	 * filesystem later.  This is key for triggering fast exit of the
+	 * xfs_healer daemon.
+	 */
+	hm->unmount_event = kzalloc(sizeof(struct xfs_healthmon_event),
+			GFP_NOFS);
+	if (!hm->unmount_event) {
+		ret = -ENOMEM;
+		goto out_hm;
+	}
+	hm->unmount_event->type = XFS_HEALTHMON_UNMOUNT;
+	hm->unmount_event->domain = XFS_HEALTHMON_MOUNT;
+
 	/*
 	 * Try to attach this health monitor to the xfs_mount.  The monitor is
 	 * considered live and will receive events if this succeeds.


