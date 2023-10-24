Return-Path: <linux-fsdevel+bounces-1092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1827D5477
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3D1B2106B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0F2C859;
	Tue, 24 Oct 2023 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etLnl+IZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9727EC7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1ABC433CB;
	Tue, 24 Oct 2023 14:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159252;
	bh=+0FJM42wSRlrkZRX413gII31Xps3fFIfnfwjB6IUDfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=etLnl+IZf/lJQIDjpEDMIpDK/7FsMzOl3EfQoNi34wghhLY+uOzfMjPXBr9Yr4u5q
	 w3V3et3K6+LSObSEoMppvVjdsldExlEKKfY/aAuPwqF+mRBMtiLLP0TAhDGroA9sCx
	 /bnb4eWxRGZ1qhu0n+aU2/7UvlFRFcuDLeMhFEJVrXx7SPUs3zqAVSLe8+iL/03vu1
	 fpCfGgTwEKPZCbLyEH7huwZV+RWYbfq2OAt/096+1rSJSI8HkC/24naRLgE6+eRB5O
	 E0yS8iOuGh9R6drOxF9Ly0d1vQbc1X9n08IHWzG+nTjZJCHVOUM8Mb3UTyiCJ5iKM5
	 Te5pMxXQS8EOg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 16:53:44 +0200
Subject: [PATCH RFC 6/6] fs: add ->yield_devices()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-rework-v1-6-37a8aa697148@kernel.org>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
In-Reply-To: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=8696; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+0FJM42wSRlrkZRX413gII31Xps3fFIfnfwjB6IUDfs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSa3+qa1PvhoWvBrNKEORd2KYoxuKsxn95+bLXwhDL9nXPm
 XXz3saOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiXHmMDItKbkgrftn679Il6R3dV8
 4venGY70frzkfZFs7b9F3vqf5k+Kf0X7n3RM5fl7/vdMI8M5L+rZlWcy+5NebesfVngplypvEBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

and allow filesystems to mark devices as about to be released allowing
concurrent openers to wait until the device is reclaimable.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/super.c    | 12 ++++++++++++
 fs/super.c         | 51 ++++++++++++++++++++-------------------------------
 fs/xfs/xfs_super.c | 27 +++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 4 files changed, 60 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e94df97ea440..45f550801329 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1477,6 +1477,17 @@ static void ext4_shutdown(struct super_block *sb)
        ext4_force_shutdown(sb, EXT4_GOING_FLAGS_NOLOGFLUSH);
 }
 
+static void ext4_yield_devices(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = sb->s_fs_info;
+	struct bdev_handle *journal_bdev_handle =
+		sbi ? sbi->s_journal_bdev_handle : NULL;
+
+	if (journal_bdev_handle)
+		bdev_yield(journal_bdev_handle);
+	bdev_yield(sb->s_bdev_handle);
+}
+
 static void init_once(void *foo)
 {
 	struct ext4_inode_info *ei = foo;
@@ -1638,6 +1649,7 @@ static const struct super_operations ext4_sops = {
 	.statfs		= ext4_statfs,
 	.show_options	= ext4_show_options,
 	.shutdown	= ext4_shutdown,
+	.yield_devices	= ext4_yield_devices,
 #ifdef CONFIG_QUOTA
 	.quota_read	= ext4_quota_read,
 	.quota_write	= ext4_quota_write,
diff --git a/fs/super.c b/fs/super.c
index 4edde92d5e8f..7e24bbd65be2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -87,10 +87,10 @@ static inline bool wait_born(struct super_block *sb)
 
 	/*
 	 * Pairs with smp_store_release() in super_wake() and ensures
-	 * that we see SB_BORN or SB_DYING after we're woken.
+	 * that we see SB_BORN or SB_DEAD after we're woken.
 	 */
 	flags = smp_load_acquire(&sb->s_flags);
-	return flags & (SB_BORN | SB_DYING);
+	return flags & (SB_BORN | SB_DEAD);
 }
 
 /**
@@ -101,12 +101,12 @@ static inline bool wait_born(struct super_block *sb)
  * If the superblock has neither passed through vfs_get_tree() or
  * generic_shutdown_super() yet wait for it to happen. Either superblock
  * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
- * woken and we'll see SB_DYING.
+ * woken and we'll see SB_DEAD.
  *
  * The caller must have acquired a temporary reference on @sb->s_count.
  *
  * Return: The function returns true if SB_BORN was set and with
- *         s_umount held. The function returns false if SB_DYING was
+ *         s_umount held. The function returns false if SB_DEAD was
  *         set and without s_umount held.
  */
 static __must_check bool super_lock(struct super_block *sb, bool excl)
@@ -122,7 +122,7 @@ static __must_check bool super_lock(struct super_block *sb, bool excl)
 	 * @sb->s_root is NULL and @sb->s_active is 0. No one needs to
 	 * grab a reference to this. Tell them so.
 	 */
-	if (sb->s_flags & SB_DYING) {
+	if (sb->s_flags & SB_DEAD) {
 		super_unlock(sb, excl);
 		return false;
 	}
@@ -137,7 +137,7 @@ static __must_check bool super_lock(struct super_block *sb, bool excl)
 	wait_var_event(&sb->s_flags, wait_born(sb));
 
 	/*
-	 * Neither SB_BORN nor SB_DYING are ever unset so we never loop.
+	 * Neither SB_BORN nor SB_DEAD are ever unset so we never loop.
 	 * Just reacquire @sb->s_umount for the caller.
 	 */
 	goto relock;
@@ -439,18 +439,17 @@ void put_super(struct super_block *sb)
 
 static void kill_super_notify(struct super_block *sb)
 {
-	lockdep_assert_not_held(&sb->s_umount);
+	const struct super_operations *sop = sb->s_op;
 
-	/* already notified earlier */
-	if (sb->s_flags & SB_DEAD)
-		return;
+	lockdep_assert_held(&sb->s_umount);
+
+	/* Allow openers to wait for the devices to be cleaned up. */
+	if (sop->yield_devices)
+		sop->yield_devices(sb);
 
 	/*
 	 * Remove it from @fs_supers so it isn't found by new
-	 * sget{_fc}() walkers anymore. Any concurrent mounter still
-	 * managing to grab a temporary reference is guaranteed to
-	 * already see SB_DYING and will wait until we notify them about
-	 * SB_DEAD.
+	 * sget{_fc}() walkers anymore.
 	 */
 	spin_lock(&sb_lock);
 	hlist_del_init(&sb->s_instances);
@@ -459,7 +458,7 @@ static void kill_super_notify(struct super_block *sb)
 	/*
 	 * Let concurrent mounts know that this thing is really dead.
 	 * We don't need @sb->s_umount here as every concurrent caller
-	 * will see SB_DYING and either discard the superblock or wait
+	 * will see SB_DEAD and either discard the superblock or wait
 	 * for SB_DEAD.
 	 */
 	super_wake(sb, SB_DEAD);
@@ -483,8 +482,6 @@ void deactivate_locked_super(struct super_block *s)
 		unregister_shrinker(&s->s_shrink);
 		fs->kill_sb(s);
 
-		kill_super_notify(s);
-
 		/*
 		 * Since list_lru_destroy() may sleep, we cannot call it from
 		 * put_super(), where we hold the sb_lock. Therefore we destroy
@@ -583,7 +580,7 @@ static bool grab_super(struct super_block *sb)
 bool super_trylock_shared(struct super_block *sb)
 {
 	if (down_read_trylock(&sb->s_umount)) {
-		if (!(sb->s_flags & SB_DYING) && sb->s_root &&
+		if (!(sb->s_flags & SB_DEAD) && sb->s_root &&
 		    (sb->s_flags & SB_BORN))
 			return true;
 		super_unlock_shared(sb);
@@ -689,16 +686,9 @@ void generic_shutdown_super(struct super_block *sb)
 			spin_unlock(&sb->s_inode_list_lock);
 		}
 	}
-	/*
-	 * Broadcast to everyone that grabbed a temporary reference to this
-	 * superblock before we removed it from @fs_supers that the superblock
-	 * is dying. Every walker of @fs_supers outside of sget{_fc}() will now
-	 * discard this superblock and treat it as dead.
-	 *
-	 * We leave the superblock on @fs_supers so it can be found by
-	 * sget{_fc}() until we passed sb->kill_sb().
-	 */
-	super_wake(sb, SB_DYING);
+
+	kill_super_notify(sb);
+
 	super_unlock_excl(sb);
 	if (sb->s_bdi != &noop_backing_dev_info) {
 		if (sb->s_iflags & SB_I_PERSB_BDI)
@@ -790,7 +780,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	/*
 	 * Make the superblock visible on @super_blocks and @fs_supers.
 	 * It's in a nascent state and users should wait on SB_BORN or
-	 * SB_DYING to be set.
+	 * SB_DEAD to be set.
 	 */
 	list_add_tail(&s->s_list, &super_blocks);
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
@@ -906,7 +896,7 @@ static void __iterate_supers(void (*f)(struct super_block *))
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
 		/* Pairs with memory marrier in super_wake(). */
-		if (smp_load_acquire(&sb->s_flags) & SB_DYING)
+		if (smp_load_acquire(&sb->s_flags) & SB_DEAD)
 			continue;
 		sb->s_count++;
 		spin_unlock(&sb_lock);
@@ -1248,7 +1238,6 @@ void kill_anon_super(struct super_block *sb)
 {
 	dev_t dev = sb->s_dev;
 	generic_shutdown_super(sb);
-	kill_super_notify(sb);
 	free_anon_bdev(dev);
 }
 EXPORT_SYMBOL(kill_anon_super);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 84107d162e41..f7a0cb92c7c0 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1170,6 +1170,32 @@ xfs_fs_shutdown(
 	xfs_force_shutdown(XFS_M(sb), SHUTDOWN_DEVICE_REMOVED);
 }
 
+static void xfs_fs_bdev_yield(struct bdev_handle *handle,
+			      struct super_block *sb)
+{
+	if (handle != sb->s_bdev_handle)
+		bdev_yield(handle);
+}
+
+static void
+xfs_fs_yield_devices(
+	struct super_block *sb)
+{
+	struct xfs_mount	*mp = XFS_M(sb);
+
+	if (mp) {
+		if (mp->m_logdev_targp &&
+		    mp->m_logdev_targp != mp->m_ddev_targp)
+			xfs_fs_bdev_yield(mp->m_logdev_targp->bt_bdev_handle, sb);
+		if (mp->m_rtdev_targp)
+			xfs_fs_bdev_yield(mp->m_rtdev_targp->bt_bdev_handle, sb);
+		if (mp->m_ddev_targp)
+			xfs_fs_bdev_yield(mp->m_ddev_targp->bt_bdev_handle, sb);
+	}
+
+	bdev_yield(sb->s_bdev_handle);
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1184,6 +1210,7 @@ static const struct super_operations xfs_super_operations = {
 	.nr_cached_objects	= xfs_fs_nr_cached_objects,
 	.free_cached_objects	= xfs_fs_free_cached_objects,
 	.shutdown		= xfs_fs_shutdown,
+	.yield_devices		= xfs_fs_yield_devices,
 };
 
 static int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5174e821d451..f0278bf4ca03 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2026,6 +2026,7 @@ struct super_operations {
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
 	void (*shutdown)(struct super_block *sb);
+	void (*yield_devices)(struct super_block *sb);
 };
 
 /*

-- 
2.34.1


