Return-Path: <linux-fsdevel+bounces-65251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D251BFEA53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99023189CDDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC9CA6B;
	Thu, 23 Oct 2025 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVhtRj2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A294502A;
	Thu, 23 Oct 2025 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177714; cv=none; b=UcDyL8h3wZy3u73yHkABP0S3FTw9qmXR1kSn4t9AijV2U/e9aWKbm1E7z1Blqn9Szwbr9E3TE8RZ3gWr/uCWUN8Bld4JovHXwpdupxriVGGewyVpz5faV7nSgMLFytSiWyww5PITel2WbLfSERffpq9UXOSexArWN/vSHnDL308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177714; c=relaxed/simple;
	bh=wp9ojl7Flg8JEqO+/hKMitjFz3Fb26S6lRRXNozK8RI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oirYEMF/TlrwXCyRPJRjLbj78qskZnscuzprcVdGcH3rDt4rKEHmSbAxL8yOgCrR/e2a/xdq7AgOPk4tn+KBTSZ6/ihgo0LnoQbN4UpdITHToDwxPREmsx1XqcMy/4gLjG1GjfPcX6uQgGI6dL2Vm2tpWBpwbudRh8mZyC9wLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVhtRj2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6004AC4CEE7;
	Thu, 23 Oct 2025 00:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177714;
	bh=wp9ojl7Flg8JEqO+/hKMitjFz3Fb26S6lRRXNozK8RI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PVhtRj2bDSVaFDK8hUUUVu6iyrO6vRB3vENQJlpTDIco0N+/dPeggBUlqpQ0dYSXW
	 ZlXc/JSqYxbT/DDcHYRtju/4CsO/ql64stJ8QPmAxfgJbJzRg1QK1bjjCAXJQs/t5d
	 dJbP8kn/VVmXzw2woBDSQnyDesEOuHz9otpyKuEmGbkhnWrP7ABDEm/eNGYbyzLN5e
	 RbHPlxzgWd7ogMEgAgoafVHVauKhd9mbD/z4OblrvPW7sqRo2caaRcAyBmezPY/dnx
	 kWV1S52R/KN13m5NqAUSadAtM5iXwnttTukQ0cRxYPKf2rvmO8mP2zECn8ZcPM2na3
	 dGRsyGAhSpV/Q==
Date: Wed, 22 Oct 2025 17:01:53 -0700
Subject: [PATCH 05/19] xfs: create a filesystem shutdown hook
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744606.1025409.9450918422116007560.stgit@frogsfrogsfrogs>
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

Create a hook so that health monitoring can report filesystem shutdown
events to userspace.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsops.h |   14 +++++++++++++
 fs/xfs/xfs_mount.h |    3 +++
 fs/xfs/xfs_fsops.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_super.c |    1 +
 4 files changed, 75 insertions(+)


diff --git a/fs/xfs/xfs_fsops.h b/fs/xfs/xfs_fsops.h
index 9d23c361ef56e4..7f6f876de072b1 100644
--- a/fs/xfs/xfs_fsops.h
+++ b/fs/xfs/xfs_fsops.h
@@ -15,4 +15,18 @@ int xfs_fs_goingdown(struct xfs_mount *mp, uint32_t inflags);
 int xfs_fs_reserve_ag_blocks(struct xfs_mount *mp);
 void xfs_fs_unreserve_ag_blocks(struct xfs_mount *mp);
 
+#ifdef CONFIG_XFS_LIVE_HOOKS
+struct xfs_shutdown_hook {
+	struct xfs_hook			shutdown_hook;
+};
+
+void xfs_shutdown_hook_disable(void);
+void xfs_shutdown_hook_enable(void);
+
+int xfs_shutdown_hook_add(struct xfs_mount *mp, struct xfs_shutdown_hook *hook);
+void xfs_shutdown_hook_del(struct xfs_mount *mp, struct xfs_shutdown_hook *hook);
+void xfs_shutdown_hook_setup(struct xfs_shutdown_hook *hook,
+		notifier_fn_t mod_fn);
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
 #endif	/* __XFS_FSOPS_H__ */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index b810b01734d854..96c920ad5add13 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -347,6 +347,9 @@ typedef struct xfs_mount {
 
 	/* Hook to feed health events to a daemon. */
 	struct xfs_hooks	m_health_update_hooks;
+
+	/* Hook to feed shutdown events to a daemon. */
+	struct xfs_hooks	m_shutdown_hooks;
 } xfs_mount_t;
 
 #define M_IGEO(mp)		(&(mp)->m_ino_geo)
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 0ada735693945c..69918cd1ba1dbc 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -482,6 +482,61 @@ xfs_fs_goingdown(
 	return 0;
 }
 
+#ifdef CONFIG_XFS_LIVE_HOOKS
+DEFINE_STATIC_XFS_HOOK_SWITCH(xfs_shutdown_hooks_switch);
+
+void
+xfs_shutdown_hook_disable(void)
+{
+	xfs_hooks_switch_off(&xfs_shutdown_hooks_switch);
+}
+
+void
+xfs_shutdown_hook_enable(void)
+{
+	xfs_hooks_switch_on(&xfs_shutdown_hooks_switch);
+}
+
+/* Call downstream hooks for a filesystem shutdown. */
+static inline void
+xfs_shutdown_hook(
+	struct xfs_mount		*mp,
+	uint32_t			flags)
+{
+	if (xfs_hooks_switched_on(&xfs_shutdown_hooks_switch))
+		xfs_hooks_call(&mp->m_shutdown_hooks, flags, NULL);
+}
+
+/* Call the specified function during a shutdown update. */
+int
+xfs_shutdown_hook_add(
+	struct xfs_mount		*mp,
+	struct xfs_shutdown_hook	*hook)
+{
+	return xfs_hooks_add(&mp->m_shutdown_hooks, &hook->shutdown_hook);
+}
+
+/* Stop calling the specified function during a shutdown update. */
+void
+xfs_shutdown_hook_del(
+	struct xfs_mount		*mp,
+	struct xfs_shutdown_hook	*hook)
+{
+	xfs_hooks_del(&mp->m_shutdown_hooks, &hook->shutdown_hook);
+}
+
+/* Configure shutdown update hook functions. */
+void
+xfs_shutdown_hook_setup(
+	struct xfs_shutdown_hook	*hook,
+	notifier_fn_t			mod_fn)
+{
+	xfs_hook_setup(&hook->shutdown_hook, mod_fn);
+}
+#else
+# define xfs_shutdown_hook(...)		((void)0)
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
 /*
  * Force a shutdown of the filesystem instantly while keeping the filesystem
  * consistent. We don't do an unmount here; just shutdown the shop, make sure
@@ -540,6 +595,8 @@ xfs_do_force_shutdown(
 		"Please unmount the filesystem and rectify the problem(s)");
 	if (xfs_error_level >= XFS_ERRLEVEL_HIGH)
 		xfs_stack_trace();
+
+	xfs_shutdown_hook(mp, flags);
 }
 
 /*
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index cd3b7343b326a8..54dcc42c65c786 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2285,6 +2285,7 @@ xfs_init_fs_context(
 	mp->m_allocsize_log = 16; /* 64k */
 
 	xfs_hooks_init(&mp->m_dir_update_hooks);
+	xfs_hooks_init(&mp->m_shutdown_hooks);
 	xfs_hooks_init(&mp->m_health_update_hooks);
 
 	fc->s_fs_info = mp;


