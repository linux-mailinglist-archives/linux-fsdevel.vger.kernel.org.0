Return-Path: <linux-fsdevel+bounces-74787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ3sGAN0cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:36:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6C52202
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9160C6A1585
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7C44A73B;
	Wed, 21 Jan 2026 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdOUWMdt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF28449ED4;
	Wed, 21 Jan 2026 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977354; cv=none; b=LMDpb35gSRr+kIebq9LLgvubF7zqNCC4AJ1Tdqw1aNMtWoSX2KReg0T28UTdCqxIgFoxXzDZKTAYg1280QWqX/ae9ezBl2KwwReobJPlB+2oeogZEOztlQ8zfQJVDVB0BJElG0JSXHvyxj6VIIz9QQj7bt/r5iM+8og3Qo9gwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977354; c=relaxed/simple;
	bh=tVedddgNbwymSS/FXonk+BiOHDR1RfE29N01dNGM7Rw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moxKSGIbuDxyZ6WD2WEJ59cKLMNL2hCTD8iGNE+JQ+MASZSTBZdnGPZmc3kyBN8A3y1KWtk0xW0q08mIJmCzWKHwMplzGDqzR0ZkkLEgLAsUV+XFDbquPWJfMklJFUh+brsYtiUEtX6tu0ZrE0TRtASOl09MjWqqp7umc6xD5KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdOUWMdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746A3C116D0;
	Wed, 21 Jan 2026 06:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768977352;
	bh=tVedddgNbwymSS/FXonk+BiOHDR1RfE29N01dNGM7Rw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VdOUWMdtVuGDkihvYwpH0jIKfA1tEqM2N8KRLobfdsQWp9PtZcr1vR20Ipos7egvX
	 dOPOlyaCWzwxWUJK16F4LaJh6Cr+B8kk/gq3zFzkEJ0TkNjZJsP1q/Pp7TGYRnKHZN
	 Ux4SiEe9V/1UnX+Ohixf+p+OMIzerUbZlSwU25y0M6AfrrE88kXw5T4mASQS0TKcmd
	 BZN0u81y12ewN5ZOsV9tJ98Dunq/LOVywqhWkoN2tUM3ocxBwp/I0UiIt1+NT6ZPf6
	 zqoywU5SBdo6/ZbLpDQuLRBbIm34RQH9KjPJdCrMSW+S0Y/AX4tCsamX4SVx1OTizR
	 zi3pyBZg9c3Qg==
Date: Tue, 20 Jan 2026 22:35:52 -0800
Subject: [PATCH 04/11] xfs: convey filesystem unmount events to the health
 monitor
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 hch@lst.de
Message-ID: <176897695109.202109.4575023987864031679.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-74787-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C2B6C52202
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Darrick J. Wong <djwong@kernel.org>

In xfs_healthmon_unmount, send events to xfs_healer so that it knows
that nothing further can be done for the filesystem.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


