Return-Path: <linux-fsdevel+bounces-65250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB8BFEA4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F503A6135
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9423CA6B;
	Thu, 23 Oct 2025 00:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVK4Xm7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3BC14A9B;
	Thu, 23 Oct 2025 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177699; cv=none; b=JqdhrCiyy4mZ6S9WdO3Ao3shhvShLiGKQGEPOMC/Ojb/t+dzFH83MMyjxvLTPN3h//KA0b2v/4iuFQTfe9zIXyCSafryFvVQE7QJOgzL8onLHsAYHMc6v7LhKnTB2LyW/aRokyr0WMIXTNU9Ds1V/dMDVlIe29zYZG4kEbPIVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177699; c=relaxed/simple;
	bh=kOd0sTn3hyyXgYJi8EXi9Ob0rS2tCdRRSXdJqyjSqV4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igPYVPeu3TTKd44NYJtQavXuD9j+ozA0IZe3kW0dJO5KlqIqC7FQ7nDpSnUapLMdFm+oxxR2KNLVgVO95TjaSyChXhiVhslOtvDMx6wP0B6eilE24FVj+j6yiDgAbb6m8KGNHkui0KmtwEdjCuR462Fl7hp8nPOpnCMldmgy3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVK4Xm7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E62C4CEE7;
	Thu, 23 Oct 2025 00:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177698;
	bh=kOd0sTn3hyyXgYJi8EXi9Ob0rS2tCdRRSXdJqyjSqV4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kVK4Xm7d6GLicynTA5kpOm9PkL42OT7/n6ObqVrNMlPjFYqc6HH6tajzZHmJoIezz
	 ES874EZzLLpHrXZGTxgIg5sJ7eReqEUSf+kYUsgSTh20+cRd4/KplGx8RJfP5HkvIi
	 BPq59hEFhKYGRDrKAEE7qi4HI3wcVHiTxRRez8URj4YIym5IKk19C9hworyG7myyCO
	 nxq8N5ezVGn0N+m5ZJX99RbQDfvWBYOtiD8tmzrp8DVozjyInFPUTqWE9rbUY102Qa
	 xtvfX8oZNjd4VDsG4VSIlVrZzqOIsx/zLlbT5V/4wJGTLbcez2v5Ok7dl3XhTuYJfV
	 2zo7djy/ujLbg==
Date: Wed, 22 Oct 2025 17:01:38 -0700
Subject: [PATCH 04/19] xfs: create hooks for monitoring health updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744584.1025409.11809434893556811232.stgit@frogsfrogsfrogs>
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

Create hooks for monitoring health events.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_health.h |   47 ++++++++++
 fs/xfs/xfs_mount.h         |    3 +
 fs/xfs/xfs_health.c        |  202 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_super.c         |    1 
 4 files changed, 252 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_health.h b/fs/xfs/libxfs/xfs_health.h
index b31000f7190ce5..39fef33dedc6a8 100644
--- a/fs/xfs/libxfs/xfs_health.h
+++ b/fs/xfs/libxfs/xfs_health.h
@@ -289,4 +289,51 @@ void xfs_bulkstat_health(struct xfs_inode *ip, struct xfs_bulkstat *bs);
 #define xfs_metadata_is_sick(error) \
 	(unlikely((error) == -EFSCORRUPTED || (error) == -EFSBADCRC))
 
+/*
+ * Parameters for tracking health updates.  The enum below is passed as the
+ * hook function argument.
+ */
+enum xfs_health_update_type {
+	XFS_HEALTHUP_SICK = 1,	/* runtime corruption observed */
+	XFS_HEALTHUP_CORRUPT,	/* fsck reported corruption */
+	XFS_HEALTHUP_HEALTHY,	/* fsck reported healthy structure */
+	XFS_HEALTHUP_UNMOUNT,	/* filesystem is unmounting */
+};
+
+/* Where in the filesystem was the event observed? */
+enum xfs_health_update_domain {
+	XFS_HEALTHUP_FS = 1,	/* main filesystem */
+	XFS_HEALTHUP_AG,	/* allocation group */
+	XFS_HEALTHUP_INODE,	/* inode */
+	XFS_HEALTHUP_RTGROUP,	/* realtime group */
+};
+
+struct xfs_health_update_params {
+	/* XFS_HEALTHUP_INODE */
+	xfs_ino_t			ino;
+	uint32_t			gen;
+
+	/* XFS_HEALTHUP_AG/RTGROUP */
+	uint32_t			group;
+
+	/* XFS_SICK_* flags */
+	unsigned int			old_mask;
+	unsigned int			new_mask;
+
+	enum xfs_health_update_domain	domain;
+};
+
+#ifdef CONFIG_XFS_LIVE_HOOKS
+struct xfs_health_hook {
+	struct xfs_hook			health_hook;
+};
+
+void xfs_health_hook_disable(void);
+void xfs_health_hook_enable(void);
+
+int xfs_health_hook_add(struct xfs_mount *mp, struct xfs_health_hook *hook);
+void xfs_health_hook_del(struct xfs_mount *mp, struct xfs_health_hook *hook);
+void xfs_health_hook_setup(struct xfs_health_hook *hook, notifier_fn_t mod_fn);
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
 #endif	/* __XFS_HEALTH_H__ */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 8643d539bc4869..b810b01734d854 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -344,6 +344,9 @@ typedef struct xfs_mount {
 
 	/* Hook to feed dirent updates to an active online repair. */
 	struct xfs_hooks	m_dir_update_hooks;
+
+	/* Hook to feed health events to a daemon. */
+	struct xfs_hooks	m_health_update_hooks;
 } xfs_mount_t;
 
 #define M_IGEO(mp)		(&(mp)->m_ino_geo)
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index 7c541fb373d5b2..abf9460ae79953 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -20,6 +20,157 @@
 #include "xfs_quota_defs.h"
 #include "xfs_rtgroup.h"
 
+#ifdef CONFIG_XFS_LIVE_HOOKS
+/*
+ * Use a static key here to reduce the overhead of health updates.  If
+ * the compiler supports jump labels, the static branch will be replaced by a
+ * nop sled when there are no hook users.  Online fsck is currently the only
+ * caller, so this is a reasonable tradeoff.
+ *
+ * Note: Patching the kernel code requires taking the cpu hotplug lock.  Other
+ * parts of the kernel allocate memory with that lock held, which means that
+ * XFS callers cannot hold any locks that might be used by memory reclaim or
+ * writeback when calling the static_branch_{inc,dec} functions.
+ */
+DEFINE_STATIC_XFS_HOOK_SWITCH(xfs_health_hooks_switch);
+
+void
+xfs_health_hook_disable(void)
+{
+	xfs_hooks_switch_off(&xfs_health_hooks_switch);
+}
+
+void
+xfs_health_hook_enable(void)
+{
+	xfs_hooks_switch_on(&xfs_health_hooks_switch);
+}
+
+/* Call downstream hooks for a filesystem unmount health update. */
+static inline void
+xfs_health_unmount_hook(
+	struct xfs_mount		*mp)
+{
+	if (xfs_hooks_switched_on(&xfs_health_hooks_switch)) {
+		struct xfs_health_update_params	p = {
+			.domain		= XFS_HEALTHUP_FS,
+		};
+
+		xfs_hooks_call(&mp->m_health_update_hooks,
+				XFS_HEALTHUP_UNMOUNT, &p);
+	}
+}
+
+/* Call downstream hooks for a filesystem health update. */
+static inline void
+xfs_fs_health_update_hook(
+	struct xfs_mount		*mp,
+	enum xfs_health_update_type	op,
+	unsigned int			old_mask,
+	unsigned int			new_mask)
+{
+	if (xfs_hooks_switched_on(&xfs_health_hooks_switch)) {
+		struct xfs_health_update_params	p = {
+			.domain		= XFS_HEALTHUP_FS,
+			.old_mask	= old_mask,
+			.new_mask	= new_mask,
+		};
+
+		if (new_mask)
+			xfs_hooks_call(&mp->m_health_update_hooks, op, &p);
+	}
+}
+
+/* Call downstream hooks for a group health update. */
+static inline void
+xfs_group_health_update_hook(
+	struct xfs_group		*xg,
+	enum xfs_health_update_type	op,
+	unsigned int			old_mask,
+	unsigned int			new_mask)
+{
+	if (xfs_hooks_switched_on(&xfs_health_hooks_switch)) {
+		struct xfs_health_update_params	p = {
+			.old_mask	= old_mask,
+			.new_mask	= new_mask,
+			.group		= xg->xg_gno,
+		};
+		struct xfs_mount	*mp = xg->xg_mount;
+
+		switch (xg->xg_type) {
+		case XG_TYPE_AG:
+			p.domain = XFS_HEALTHUP_AG;
+			break;
+		case XG_TYPE_RTG:
+			p.domain = XFS_HEALTHUP_RTGROUP;
+			break;
+		default:
+			ASSERT(0);
+			return;
+		}
+
+		if (new_mask)
+			xfs_hooks_call(&mp->m_health_update_hooks, op, &p);
+	}
+}
+
+/* Call downstream hooks for an inode health update. */
+static inline void
+xfs_inode_health_update_hook(
+	struct xfs_inode		*ip,
+	enum xfs_health_update_type	op,
+	unsigned int			old_mask,
+	unsigned int			new_mask)
+{
+	if (xfs_hooks_switched_on(&xfs_health_hooks_switch)) {
+		struct xfs_health_update_params	p = {
+			.domain		= XFS_HEALTHUP_INODE,
+			.old_mask	= old_mask,
+			.new_mask	= new_mask,
+			.ino		= ip->i_ino,
+			.gen		= VFS_I(ip)->i_generation,
+		};
+		struct xfs_mount	*mp = ip->i_mount;
+
+		if (new_mask)
+			xfs_hooks_call(&mp->m_health_update_hooks, op, &p);
+	}
+}
+
+/* Call the specified function during a health update. */
+int
+xfs_health_hook_add(
+	struct xfs_mount	*mp,
+	struct xfs_health_hook	*hook)
+{
+	return xfs_hooks_add(&mp->m_health_update_hooks, &hook->health_hook);
+}
+
+/* Stop calling the specified function during a health update. */
+void
+xfs_health_hook_del(
+	struct xfs_mount	*mp,
+	struct xfs_health_hook	*hook)
+{
+	xfs_hooks_del(&mp->m_health_update_hooks, &hook->health_hook);
+}
+
+/* Configure health update hook functions. */
+void
+xfs_health_hook_setup(
+	struct xfs_health_hook	*hook,
+	notifier_fn_t		mod_fn)
+{
+	xfs_hook_setup(&hook->health_hook, mod_fn);
+}
+#else
+# define xfs_health_unmount_hook(...)			((void)0)
+# define xfs_fs_health_update_hook(a,b,o,n)		do {o = o;} while(0)
+# define xfs_rt_health_update_hook(a,b,o,n)		do {o = o;} while(0)
+# define xfs_group_health_update_hook(a,b,o,n)		do {o = o;} while(0)
+# define xfs_inode_health_update_hook(a,b,o,n)		do {o = o;} while(0)
+#endif /* CONFIG_XFS_LIVE_HOOKS */
+
 static void
 xfs_health_unmount_group(
 	struct xfs_group	*xg,
@@ -50,8 +201,10 @@ xfs_health_unmount(
 	unsigned int		checked = 0;
 	bool			warn = false;
 
-	if (xfs_is_shutdown(mp))
+	if (xfs_is_shutdown(mp)) {
+		xfs_health_unmount_hook(mp);
 		return;
+	}
 
 	/* Measure AG corruption levels. */
 	while ((pag = xfs_perag_next(mp, pag)))
@@ -97,6 +250,8 @@ xfs_health_unmount(
 		if (sick & XFS_SICK_FS_COUNTERS)
 			xfs_fs_mark_healthy(mp, XFS_SICK_FS_COUNTERS);
 	}
+
+	xfs_health_unmount_hook(mp);
 }
 
 /* Mark unhealthy per-fs metadata. */
@@ -105,12 +260,17 @@ xfs_fs_mark_sick(
 	struct xfs_mount	*mp,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_FS_ALL));
 	trace_xfs_fs_mark_sick(mp, mask);
 
 	spin_lock(&mp->m_sb_lock);
+	old_mask = mp->m_fs_sick;
 	mp->m_fs_sick |= mask;
 	spin_unlock(&mp->m_sb_lock);
+
+	xfs_fs_health_update_hook(mp, XFS_HEALTHUP_SICK, old_mask, mask);
 }
 
 /* Mark per-fs metadata as having been checked and found unhealthy by fsck. */
@@ -119,13 +279,18 @@ xfs_fs_mark_corrupt(
 	struct xfs_mount	*mp,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_FS_ALL));
 	trace_xfs_fs_mark_corrupt(mp, mask);
 
 	spin_lock(&mp->m_sb_lock);
+	old_mask = mp->m_fs_sick;
 	mp->m_fs_sick |= mask;
 	mp->m_fs_checked |= mask;
 	spin_unlock(&mp->m_sb_lock);
+
+	xfs_fs_health_update_hook(mp, XFS_HEALTHUP_CORRUPT, old_mask, mask);
 }
 
 /* Mark a per-fs metadata healed. */
@@ -134,15 +299,20 @@ xfs_fs_mark_healthy(
 	struct xfs_mount	*mp,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_FS_ALL));
 	trace_xfs_fs_mark_healthy(mp, mask);
 
 	spin_lock(&mp->m_sb_lock);
+	old_mask = mp->m_fs_sick;
 	mp->m_fs_sick &= ~mask;
 	if (!(mp->m_fs_sick & XFS_SICK_FS_PRIMARY))
 		mp->m_fs_sick &= ~XFS_SICK_FS_SECONDARY;
 	mp->m_fs_checked |= mask;
 	spin_unlock(&mp->m_sb_lock);
+
+	xfs_fs_health_update_hook(mp, XFS_HEALTHUP_HEALTHY, old_mask, mask);
 }
 
 /* Sample which per-fs metadata are unhealthy. */
@@ -192,12 +362,17 @@ xfs_group_mark_sick(
 	struct xfs_group	*xg,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	xfs_group_check_mask(xg, mask);
 	trace_xfs_group_mark_sick(xg, mask);
 
 	spin_lock(&xg->xg_state_lock);
+	old_mask = xg->xg_sick;
 	xg->xg_sick |= mask;
 	spin_unlock(&xg->xg_state_lock);
+
+	xfs_group_health_update_hook(xg, XFS_HEALTHUP_SICK, old_mask, mask);
 }
 
 /*
@@ -208,13 +383,18 @@ xfs_group_mark_corrupt(
 	struct xfs_group	*xg,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	xfs_group_check_mask(xg, mask);
 	trace_xfs_group_mark_corrupt(xg, mask);
 
 	spin_lock(&xg->xg_state_lock);
+	old_mask = xg->xg_sick;
 	xg->xg_sick |= mask;
 	xg->xg_checked |= mask;
 	spin_unlock(&xg->xg_state_lock);
+
+	xfs_group_health_update_hook(xg, XFS_HEALTHUP_CORRUPT, old_mask, mask);
 }
 
 /*
@@ -225,15 +405,20 @@ xfs_group_mark_healthy(
 	struct xfs_group	*xg,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	xfs_group_check_mask(xg, mask);
 	trace_xfs_group_mark_healthy(xg, mask);
 
 	spin_lock(&xg->xg_state_lock);
+	old_mask = xg->xg_sick;
 	xg->xg_sick &= ~mask;
 	if (!(xg->xg_sick & XFS_SICK_AG_PRIMARY))
 		xg->xg_sick &= ~XFS_SICK_AG_SECONDARY;
 	xg->xg_checked |= mask;
 	spin_unlock(&xg->xg_state_lock);
+
+	xfs_group_health_update_hook(xg, XFS_HEALTHUP_HEALTHY, old_mask, mask);
 }
 
 /* Sample which per-ag metadata are unhealthy. */
@@ -272,10 +457,13 @@ xfs_inode_mark_sick(
 	struct xfs_inode	*ip,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_INO_ALL));
 	trace_xfs_inode_mark_sick(ip, mask);
 
 	spin_lock(&ip->i_flags_lock);
+	old_mask = ip->i_sick;
 	ip->i_sick |= mask;
 	spin_unlock(&ip->i_flags_lock);
 
@@ -287,6 +475,8 @@ xfs_inode_mark_sick(
 	spin_lock(&VFS_I(ip)->i_lock);
 	VFS_I(ip)->i_state &= ~I_DONTCACHE;
 	spin_unlock(&VFS_I(ip)->i_lock);
+
+	xfs_inode_health_update_hook(ip, XFS_HEALTHUP_SICK, old_mask, mask);
 }
 
 /* Mark inode metadata as having been checked and found unhealthy by fsck. */
@@ -295,10 +485,13 @@ xfs_inode_mark_corrupt(
 	struct xfs_inode	*ip,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_INO_ALL));
 	trace_xfs_inode_mark_corrupt(ip, mask);
 
 	spin_lock(&ip->i_flags_lock);
+	old_mask = ip->i_sick;
 	ip->i_sick |= mask;
 	ip->i_checked |= mask;
 	spin_unlock(&ip->i_flags_lock);
@@ -311,6 +504,8 @@ xfs_inode_mark_corrupt(
 	spin_lock(&VFS_I(ip)->i_lock);
 	VFS_I(ip)->i_state &= ~I_DONTCACHE;
 	spin_unlock(&VFS_I(ip)->i_lock);
+
+	xfs_inode_health_update_hook(ip, XFS_HEALTHUP_CORRUPT, old_mask, mask);
 }
 
 /* Mark parts of an inode healed. */
@@ -319,15 +514,20 @@ xfs_inode_mark_healthy(
 	struct xfs_inode	*ip,
 	unsigned int		mask)
 {
+	unsigned int		old_mask;
+
 	ASSERT(!(mask & ~XFS_SICK_INO_ALL));
 	trace_xfs_inode_mark_healthy(ip, mask);
 
 	spin_lock(&ip->i_flags_lock);
+	old_mask = ip->i_sick;
 	ip->i_sick &= ~mask;
 	if (!(ip->i_sick & XFS_SICK_INO_PRIMARY))
 		ip->i_sick &= ~XFS_SICK_INO_SECONDARY;
 	ip->i_checked |= mask;
 	spin_unlock(&ip->i_flags_lock);
+
+	xfs_inode_health_update_hook(ip, XFS_HEALTHUP_HEALTHY, old_mask, mask);
 }
 
 /* Sample which parts of an inode are unhealthy. */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index abe229fa5aa4b6..cd3b7343b326a8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2285,6 +2285,7 @@ xfs_init_fs_context(
 	mp->m_allocsize_log = 16; /* 64k */
 
 	xfs_hooks_init(&mp->m_dir_update_hooks);
+	xfs_hooks_init(&mp->m_health_update_hooks);
 
 	fc->s_fs_info = mp;
 	fc->ops = &xfs_context_ops;


