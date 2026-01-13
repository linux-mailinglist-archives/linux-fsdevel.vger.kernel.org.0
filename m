Return-Path: <linux-fsdevel+bounces-73347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1762ED160EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBAB73013BD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EAB22B8BD;
	Tue, 13 Jan 2026 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHpweQ8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26781157480;
	Tue, 13 Jan 2026 00:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264417; cv=none; b=cSzdIUMgIOJeH7m29XKm4ZR6aurgezgw4Gb8+T4C/AnJZ8or/NSRziGVw7Ef1JBoloMdmh68M/FSXJQt1qn33V2vS+YPM1BkLUfqJJrb4pTH/BW1HR2b1qz8uYyDw93vwS/i2GlSOGUChgWHtddyd5bKBt7zm5iIOpTELBQIddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264417; c=relaxed/simple;
	bh=wmNAkeYIbXEP3fOk0EDcxp+WGpHscmFeyjeTF7UbWNQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JR1vP9IbJgUK5Ur61QAy4x2ZFE5Os6IX+mX6XEDz6spg4Bmve6X8nvvcl1hUqVAiGUPGI9u0Zxa0Xi3+513x7pHPHk6ABpn5vk4Rb0KsvFDWeurnkF3wAB+fGYYm/8YK1YUhSHUcjoF8hOkpmANPH84tu0UvHcHtx1msM2PYC0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHpweQ8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB8DC116D0;
	Tue, 13 Jan 2026 00:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264416;
	bh=wmNAkeYIbXEP3fOk0EDcxp+WGpHscmFeyjeTF7UbWNQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mHpweQ8clCzMj6U2KXZEF5HGTYMpB6fFr6ENq6+yh4YGfIfCJ4sIy4VytNMZau8xs
	 s7UkDcmzz03HGgfeNUiWIkFFZZUWRT7aT7Oa5QrM4iyROBzoP/4441H1NIOG7EtGde
	 vEoyfuluz7ziWE/jbuEflDYxL2b+2e73nnbBIvi6EYhL/haNga3PwEHM0uWA8nnvPr
	 z3I0Ly27K0omxijtCgfkHS+c3ZMzJ+DpPtYubg4UhKRXZN5lX5rOD/xwhAxT50AQsE
	 Db2q81C+dndaXOxxKMAkWffORtayRHk0DU3Gety2hM5EaeOHJlEtI5GRPzbgSUBtF3
	 qoSxVGD4JldhQ==
Date: Mon, 12 Jan 2026 16:33:36 -0800
Subject: [PATCH 04/11] xfs: convey filesystem unmount events to the health
 monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176826412793.3493441.11061369088553154286.stgit@frogsfrogsfrogs>
In-Reply-To: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
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
index f1c6782f5e3915..122e5a4d8e24cb 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -166,6 +166,7 @@ xfs_healthmon_merge_events(
 
 	switch (existing->type) {
 	case XFS_HEALTHMON_RUNNING:
+	case XFS_HEALTHMON_UNMOUNT:
 		/* should only ever be one of these events anyway */
 		return false;
 
@@ -307,16 +308,47 @@ xfs_healthmon_push(
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


