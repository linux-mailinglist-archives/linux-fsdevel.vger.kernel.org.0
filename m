Return-Path: <linux-fsdevel+bounces-65252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC8BFEA5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41EFF4F35CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C682C181;
	Thu, 23 Oct 2025 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcmdZQql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807DA95E;
	Thu, 23 Oct 2025 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177730; cv=none; b=b32OjaMy/dz2gn2kAtQxVwvSnF84mnFRUW35fzzkt3MkJ4x1jABfzPmYLlvXiIWT5dtOKwgGOrOVM6ndBvMtL5HswpKeSNl4EsVYoOcV3MwiWTQMUcIVnGD7waCfvynWKodnKScFI5wucp2Wwq1EoWLn4oXkFwj3ZhftzrOCzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177730; c=relaxed/simple;
	bh=7bRqVstcvhjHgDUFfe5Vbxf+vPRzr8tuW19I9punMHc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0mCBY99YE8WY+oWK41mJ/Lg5UyHPfBWjDFMAkqVyxF3lvk2oYdcPT39+bcxOiD4x8V4RQbgQyxQZ7zpGvSG8UNzmyTV1cM5YgWXSlAK4KYRklpycgNyfDhfs50evHgCBj9Qgo6Iiira/RKBgdz/xK9XeM7hZU/dbQV3gylIm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcmdZQql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD1EC4CEE7;
	Thu, 23 Oct 2025 00:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177730;
	bh=7bRqVstcvhjHgDUFfe5Vbxf+vPRzr8tuW19I9punMHc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UcmdZQqlV0PxqZw/3fFaAN9cu9EmDbqF7ffrFgl3ugZHcyMB1Z05BmGzdNNlpRbZB
	 P1cACjeVWZZzszhIg3oxzKhiEgp+se3jMH6y7Hw6hRmppUo2Fgx+NMqB/2sTqSKGSL
	 Oqjh348nAjKA60DoAApbvIz0On31ZeyXVLDNeKagsuMhJOkxzIc6S1/NKWT0b3CjEp
	 Z90dcdg+rZt3uFzPLx8SzGKwv/PGY86lwEJ97IYkLwfrKeNqj84fUo0XcKdurdiy3N
	 OK40iYINF/0Bx/FoeztfnDyzU7DNR08KB1YxQFuMLUAiSLcMfuGZCk+p74K2T5pXjs
	 B/jBuxABiaCWw==
Date: Wed, 22 Oct 2025 17:02:09 -0700
Subject: [PATCH 06/19] xfs: create hooks for media errors
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744628.1025409.4552701818347907367.stgit@frogsfrogsfrogs>
In-Reply-To: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
References: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
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

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_mount.h          |    3 ++
 fs/xfs/xfs_notify_failure.h |   38 +++++++++++++++++++
 fs/xfs/xfs_notify_failure.c |   84 ++++++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_super.c          |    1 +
 4 files changed, 121 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 96c920ad5add13..0907714c9d6f21 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -350,6 +350,9 @@ typedef struct xfs_mount {
 
 	/* Hook to feed shutdown events to a daemon. */
 	struct xfs_hooks	m_shutdown_hooks;
+
+	/* Hook to feed media error events to a daemon. */
+	struct xfs_hooks	m_media_error_hooks;
 } xfs_mount_t;
 
 #define M_IGEO(mp)		(&(mp)->m_ino_geo)
diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
index 8d08ec29dd2949..528317ff24320a 100644
--- a/fs/xfs/xfs_notify_failure.h
+++ b/fs/xfs/xfs_notify_failure.h
@@ -8,4 +8,42 @@
 
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
+void xfs_media_error_hook_disable(void);
+void xfs_media_error_hook_enable(void);
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
+# define xfs_media_error_hook_disable()		((void)0)
+# define xfs_media_error_hook_enable()		((void)0)
+# define xfs_media_error_hook_add(...)		(0)
+# define xfs_media_error_hook_del(...)		((void)0)
+# define xfs_media_error_hook_setup(...)	((void)0)
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
 #endif /* __XFS_NOTIFY_FAILURE_H__ */
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index b1767288994206..2098ff452a3b87 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -27,6 +27,73 @@
 #include <linux/dax.h>
 #include <linux/fs.h>
 
+#ifdef CONFIG_XFS_LIVE_HOOKS
+DEFINE_STATIC_XFS_HOOK_SWITCH(xfs_media_error_hooks_switch);
+
+void
+xfs_media_error_hook_disable(void)
+{
+	xfs_hooks_switch_off(&xfs_media_error_hooks_switch);
+}
+
+void
+xfs_media_error_hook_enable(void)
+{
+	xfs_hooks_switch_on(&xfs_media_error_hooks_switch);
+}
+
+/* Call downstream hooks for a media error. */
+static inline void
+xfs_media_error_hook(
+	struct xfs_mount		*mp,
+	enum xfs_failed_device		fdev,
+	xfs_daddr_t			daddr,
+	uint64_t			bbcount,
+	bool				pre_remove)
+{
+	if (xfs_hooks_switched_on(&xfs_media_error_hooks_switch)) {
+		struct xfs_media_error_params p = {
+			.mp		= mp,
+			.fdev		= fdev,
+			.daddr		= daddr,
+			.bbcount	= bbcount,
+			.pre_remove	= pre_remove,
+		};
+
+		xfs_hooks_call(&mp->m_media_error_hooks, 0, &p);
+	}
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
@@ -215,6 +282,9 @@ xfs_dax_notify_logdev_failure(
 	if (error)
 		return error;
 
+	xfs_media_error_hook(mp, XFS_FAILED_LOGDEV, daddr, bblen,
+			mf_flags & MF_MEM_PRE_REMOVE);
+
 	/*
 	 * In the pre-remove case the failure notification is attempting to
 	 * trigger a force unmount.  The expectation is that the device is
@@ -248,16 +318,20 @@ xfs_dax_notify_dev_failure(
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
index 54dcc42c65c786..51f8db95e717a8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2287,6 +2287,7 @@ xfs_init_fs_context(
 	xfs_hooks_init(&mp->m_dir_update_hooks);
 	xfs_hooks_init(&mp->m_shutdown_hooks);
 	xfs_hooks_init(&mp->m_health_update_hooks);
+	xfs_hooks_init(&mp->m_media_error_hooks);
 
 	fc->s_fs_info = mp;
 	fc->ops = &xfs_context_ops;


