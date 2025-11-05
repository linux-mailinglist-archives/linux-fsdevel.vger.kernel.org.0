Return-Path: <linux-fsdevel+bounces-67028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B62C3384B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E7218C35D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB6823B63E;
	Wed,  5 Nov 2025 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWHBNEFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3334D396;
	Wed,  5 Nov 2025 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303784; cv=none; b=Vh1Onr5++Qnt02UlgPapZ+ww+ApZOju/womYm4x5UXaOCnrIsDjG8PEK0n3BnZYp58fTkweOG+aiN7NYNiPmVVOCsaU6LZhXdFxN4/isKXFMuIUAh9WXBYACCrjKeDmHrqkmuUeAZK+DrZb5QwG1G7LI2yEKuNNZr0ZNFbdcB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303784; c=relaxed/simple;
	bh=OqEXg6t3/yteQ6Nu8pcBhhz6FzHf+jgDoGTiR9/N2nM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwIvQWxicxyWWOdu5APBPCkc4ylszl0VV2bDxZmshcqj+rMIZRVTeBs3+MuFBA5euyXsUeUOf5BTwpHDTwmguaF9hMO5VsePECwbIFI28jVnv60wc03wxEXIoUh76HucdKBz7NCflHHExOU+qI0h73x6UJnzLorAlRtdPmeo+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWHBNEFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AB5C4CEF7;
	Wed,  5 Nov 2025 00:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303784;
	bh=OqEXg6t3/yteQ6Nu8pcBhhz6FzHf+jgDoGTiR9/N2nM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RWHBNEFZINM9VjbzNUbNzA19uTEQ8eoSr5My0FMw3/BkOE1M12mkQg9bYMDfecmIr
	 uL9EguncRfBnlBmVuEekXg2+h5mymEyq+7Z/tSmrEVYUANnQq14jyqmWCTrejFwYzW
	 zhhZkOliB2c550dIDT9g3Y/a9vZh7IyRtEEwEHQMsHweq5Our22oridRYeMw6BMxdX
	 nkqMXghxVFjk3cgYuNvB/ywW4fi0QEfV/QIt8CscwusjTE/iGvLFSWSISFfEKCyEDT
	 JLw+ui/v/W98MFWyOG+UKgdh0AH3Ijk0fPxkEMCXqMNU7BJ4F1je59cnlgmxVTjmWd
	 RoboS8mjaLRMw==
Date: Tue, 04 Nov 2025 16:49:43 -0800
Subject: [PATCH 05/22] xfs: create a filesystem shutdown hook
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230365796.1647136.15603405106693786745.stgit@frogsfrogsfrogs>
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

Create a hook so that health monitoring can report filesystem shutdown
events to userspace.  Shutdowns should be infrequent, so we don't bother
with a static key here.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsops.h |   11 +++++++++++
 fs/xfs/xfs_mount.h |    3 +++
 fs/xfs/xfs_fsops.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_super.c |    1 +
 4 files changed, 57 insertions(+)


diff --git a/fs/xfs/xfs_fsops.h b/fs/xfs/xfs_fsops.h
index 9d23c361ef56e4..ea5561b8580574 100644
--- a/fs/xfs/xfs_fsops.h
+++ b/fs/xfs/xfs_fsops.h
@@ -15,4 +15,15 @@ int xfs_fs_goingdown(struct xfs_mount *mp, uint32_t inflags);
 int xfs_fs_reserve_ag_blocks(struct xfs_mount *mp);
 void xfs_fs_unreserve_ag_blocks(struct xfs_mount *mp);
 
+#ifdef CONFIG_XFS_LIVE_HOOKS
+struct xfs_shutdown_hook {
+	struct xfs_hook			shutdown_hook;
+};
+
+int xfs_shutdown_hook_add(struct xfs_mount *mp, struct xfs_shutdown_hook *hook);
+void xfs_shutdown_hook_del(struct xfs_mount *mp, struct xfs_shutdown_hook *hook);
+void xfs_shutdown_hook_setup(struct xfs_shutdown_hook *hook,
+		notifier_fn_t mod_fn);
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
 #endif	/* __XFS_FSOPS_H__ */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 3f20baaf9cc226..2d4305d91a3cd9 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -346,6 +346,9 @@ typedef struct xfs_mount {
 
 	/* Hook to feed health events to a daemon. */
 	struct xfs_hooks	m_health_update_hooks;
+
+	/* Hook to feed shutdown events to a daemon. */
+	struct xfs_hooks	m_shutdown_hooks;
 } xfs_mount_t;
 
 #define M_IGEO(mp)		(&(mp)->m_ino_geo)
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 0ada735693945c..26ed16e67410d7 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -482,6 +482,46 @@ xfs_fs_goingdown(
 	return 0;
 }
 
+#ifdef CONFIG_XFS_LIVE_HOOKS
+/* Call downstream hooks for a filesystem shutdown. */
+static inline void
+xfs_shutdown_hook(
+	struct xfs_mount		*mp,
+	uint32_t			flags)
+{
+	xfs_hooks_call(&mp->m_shutdown_hooks, flags, NULL);
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
@@ -540,6 +580,8 @@ xfs_do_force_shutdown(
 		"Please unmount the filesystem and rectify the problem(s)");
 	if (xfs_error_level >= XFS_ERRLEVEL_HIGH)
 		xfs_stack_trace();
+
+	xfs_shutdown_hook(mp, flags);
 }
 
 /*
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 84cbba0ab698aa..599900b9b0dd63 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2291,6 +2291,7 @@ xfs_init_fs_context(
 	mp->m_allocsize_log = 16; /* 64k */
 
 	xfs_hooks_init(&mp->m_dir_update_hooks);
+	xfs_hooks_init(&mp->m_shutdown_hooks);
 	xfs_hooks_init(&mp->m_health_update_hooks);
 
 	fc->s_fs_info = mp;


