Return-Path: <linux-fsdevel+bounces-67029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84492C33851
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D834718C35C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2A23BCF7;
	Wed,  5 Nov 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO76dcdO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2E34D396;
	Wed,  5 Nov 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303803; cv=none; b=NC+SdDo82wQ7vEb/UEFDsGP5Fx8BDS08KWLF/3A3FPA34QZSdsa7QQcOLv3VZ5yo7599O9cOPbvhfO91fWxjsVS19dWdRpt6f1SNEOhYknrFPYG6ZmdGEYEe5kcIyG7CfqlfenWRuVIbLeujhoW4T5QlFGVmIVsgmBUqIqV5jtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303803; c=relaxed/simple;
	bh=7mT5rw9IeWYy+kbxB6BzGncbjkIAWDWu9O8vaCLXfs8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDP/QW1ou9QiW2FCaT2xjLKniTOheiNJKLZMBUwCUIFhwhHtgxTeAWAXXH6ZhUpawHCAbe4BTAqNeYdH1v4Or491Ol9+YtufZUJurCgQP1jPN+10pVvk6xA6TlwBz9W58PUaaSRbdVnqikvLUMqHqeHgLoxO2p9sngl0gG/a31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO76dcdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50CCC4CEF7;
	Wed,  5 Nov 2025 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303799;
	bh=7mT5rw9IeWYy+kbxB6BzGncbjkIAWDWu9O8vaCLXfs8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gO76dcdOUXW0g0AsnuOPh10C+4Tz9JZpYO+p1k209sTfeqd2+7K5xsnX/j7E3cet7
	 xEvh7+/exZD0B79tu+RLutcba1QHBEOXDY9TFoX1yo/9wptZthvk9gQfo/i4wKz/TH
	 3i2cY3lIESU80CcE9dICj1r0S6teLbWCA0ZvHrFaAXv3d1Q/L8gh9rdkfyriEdoRJ+
	 dG3vDIJPWMuzPbvnwNDWoMXALCTuIq7f+rbsLI8yXubFDm1bsKfDptXdKtJLxj3OwB
	 MjD9ScSXyzseGsZLotxH+J2sFwNQ4dBMH9Cq6TTe8L8tMTtGwX3caZX1G93FIq/K2u
	 2shtZNvMa8UwQ==
Date: Tue, 04 Nov 2025 16:49:59 -0800
Subject: [PATCH 06/22] xfs: create hooks for media errors
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230365818.1647136.10815004358122628091.stgit@frogsfrogsfrogs>
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

Set up a media error event hook so that we can send events to userspace.
Media errors are not expected to be frequent, so we don't have a static
key guarding them here either.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_mount.h          |    3 ++
 fs/xfs/xfs_notify_failure.h |   33 +++++++++++++++++++++
 fs/xfs/xfs_notify_failure.c |   68 ++++++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_super.c          |    1 +
 4 files changed, 100 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 2d4305d91a3cd9..0feb0fb685f51f 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -349,6 +349,9 @@ typedef struct xfs_mount {
 
 	/* Hook to feed shutdown events to a daemon. */
 	struct xfs_hooks	m_shutdown_hooks;
+
+	/* Hook to feed media error events to a daemon. */
+	struct xfs_hooks	m_media_error_hooks;
 } xfs_mount_t;
 
 #define M_IGEO(mp)		(&(mp)->m_ino_geo)
diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
index 8d08ec29dd2949..2695732ec20875 100644
--- a/fs/xfs/xfs_notify_failure.h
+++ b/fs/xfs/xfs_notify_failure.h
@@ -8,4 +8,37 @@
 
 extern const struct dax_holder_operations xfs_dax_holder_operations;
 
+enum xfs_failed_device {
+	XFS_FAILED_DATADEV,
+	XFS_FAILED_LOGDEV,
+	XFS_FAILED_RTDEV,
+};
+
+#if defined(CONFIG_XFS_LIVE_HOOKS) && defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_FS_DAX)
+struct xfs_media_error_params {
+	struct xfs_mount		*mp;
+	enum xfs_failed_device		fdev;
+	xfs_daddr_t			daddr;
+	uint64_t			bbcount;
+	bool				pre_remove;
+};
+
+struct xfs_media_error_hook {
+	struct xfs_hook			error_hook;
+};
+
+int xfs_media_error_hook_add(struct xfs_mount *mp,
+		struct xfs_media_error_hook *hook);
+void xfs_media_error_hook_del(struct xfs_mount *mp,
+		struct xfs_media_error_hook *hook);
+void xfs_media_error_hook_setup(struct xfs_media_error_hook *hook,
+		notifier_fn_t mod_fn);
+#else
+struct xfs_media_error_params { };
+struct xfs_media_error_hook { };
+# define xfs_media_error_hook_add(...)		(0)
+# define xfs_media_error_hook_del(...)		((void)0)
+# define xfs_media_error_hook_setup(...)	((void)0)
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
 #endif /* __XFS_NOTIFY_FAILURE_H__ */
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index b1767288994206..557f4bf3463dcb 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -27,6 +27,57 @@
 #include <linux/dax.h>
 #include <linux/fs.h>
 
+#ifdef CONFIG_XFS_LIVE_HOOKS
+/* Call downstream hooks for a media error. */
+static inline void
+xfs_media_error_hook(
+	struct xfs_mount		*mp,
+	enum xfs_failed_device		fdev,
+	xfs_daddr_t			daddr,
+	uint64_t			bbcount,
+	bool				pre_remove)
+{
+	struct xfs_media_error_params	p = {
+		.mp			= mp,
+		.fdev			= fdev,
+		.daddr			= daddr,
+		.bbcount		= bbcount,
+		.pre_remove		= pre_remove,
+	};
+
+	xfs_hooks_call(&mp->m_media_error_hooks, 0, &p);
+}
+
+/* Call the specified function during a media error. */
+int
+xfs_media_error_hook_add(
+	struct xfs_mount		*mp,
+	struct xfs_media_error_hook	*hook)
+{
+	return xfs_hooks_add(&mp->m_media_error_hooks, &hook->error_hook);
+}
+
+/* Stop calling the specified function during a media error. */
+void
+xfs_media_error_hook_del(
+	struct xfs_mount		*mp,
+	struct xfs_media_error_hook	*hook)
+{
+	xfs_hooks_del(&mp->m_media_error_hooks, &hook->error_hook);
+}
+
+/* Configure media error hook functions. */
+void
+xfs_media_error_hook_setup(
+	struct xfs_media_error_hook	*hook,
+	notifier_fn_t			mod_fn)
+{
+	xfs_hook_setup(&hook->error_hook, mod_fn);
+}
+#else
+# define xfs_media_error_hook(...)		((void)0)
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
 struct xfs_failure_info {
 	xfs_agblock_t		startblock;
 	xfs_extlen_t		blockcount;
@@ -215,6 +266,9 @@ xfs_dax_notify_logdev_failure(
 	if (error)
 		return error;
 
+	xfs_media_error_hook(mp, XFS_FAILED_LOGDEV, daddr, bblen,
+			mf_flags & MF_MEM_PRE_REMOVE);
+
 	/*
 	 * In the pre-remove case the failure notification is attempting to
 	 * trigger a force unmount.  The expectation is that the device is
@@ -248,16 +302,20 @@ xfs_dax_notify_dev_failure(
 	uint64_t		bblen;
 	struct xfs_group	*xg = NULL;
 
+	error = xfs_dax_translate_range(xfs_group_type_buftarg(mp, type),
+			offset, len, &daddr, &bblen);
+	if (error)
+		return error;
+
+	xfs_media_error_hook(mp, type == XG_TYPE_RTG ?
+			XFS_FAILED_RTDEV : XFS_FAILED_DATADEV,
+			daddr, bblen, mf_flags & MF_MEM_PRE_REMOVE);
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
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 599900b9b0dd63..fb72a4976e8570 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2293,6 +2293,7 @@ xfs_init_fs_context(
 	xfs_hooks_init(&mp->m_dir_update_hooks);
 	xfs_hooks_init(&mp->m_shutdown_hooks);
 	xfs_hooks_init(&mp->m_health_update_hooks);
+	xfs_hooks_init(&mp->m_media_error_hooks);
 
 	fc->s_fs_info = mp;
 	fc->ops = &xfs_context_ops;


