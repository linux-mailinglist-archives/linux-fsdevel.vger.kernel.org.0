Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59271780A89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 12:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357656AbjHRKzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 06:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376459AbjHRKya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F3E121
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 03:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79AAA649BC
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 10:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9276C433CA;
        Fri, 18 Aug 2023 10:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356066;
        bh=pvKy3Sd8oErnn8eSYs5zBxMrkelpuSCZOFCJh/fHbRI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gKYPP1u1qDKY+YlORw4F9CQiwPeAIOlLkuN9ythX2iojBJYrBBvjM0TD5VlYGnEJp
         jt1AqMvu/5Fp8x/8lsi+FCn/ESBrkfureelrKX8HwXbQlSmw5HUmksP8V7Nu8T7c+D
         p6HEQU8P7ZivIZ4XcC8qNym1exFoKzrK0p1lIt8C+/0IUNlZnoQ6SplRZMw5MZWMlQ
         en9s4rCg6nKQVtd9JF8tElSd51QKRRBfQ7/KtlpZPyDANmdMcn/ziWjUg7RBNH6nuC
         JCrbmpxfWLG+3AMef7hbG2PcOf1oybKTPbeEFLf1YLbYuOCdwFjW4oksoVfQdn6tk7
         SqeYvXmD8LmwQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 18 Aug 2023 12:54:17 +0200
Subject: [PATCH v2 3/4] super: wait for nascent superblocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-vfs-super-fixes-v3-v2-3-cdab45934983@kernel.org>
References: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
In-Reply-To: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=14799; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pvKy3Sd8oErnn8eSYs5zBxMrkelpuSCZOFCJh/fHbRI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTc973zLq5QnoOrPnv3wtMpj740f77+VFfaSPJiQhbb+u26
 b1yedpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk15/hr5x8ZYaYtudKke+hh+dfcg
 pzf6HPe89CZAJTCMMjVuXACQz/y9/WWaxNv3hEookpp7qt6dTX+QvX5SwQNPlb87ZuJys7MwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recent patches experiment with making it possible to allocate a new
superblock before opening the relevant block device. Naturally this has
intricate side-effects that we get to learn about while developing this.

Superblock allocators such as sget{_fc}() return with s_umount of the
new superblock held and lock ordering currently requires that block
level locks such as bdev_lock and open_mutex rank above s_umount.

Before aca740cecbe5 ("fs: open block device after superblock creation")
ordering was guaranteed to be correct as block devices were opened prior
to superblock allocation and thus s_umount wasn't held. But now s_umount
must be dropped before opening block devices to avoid locking
violations.

This has consequences. The main one being that iterators over
@super_blocks and @fs_supers that grab a temporary reference to the
superblock can now also grab s_umount before the caller has managed to
open block devices and called fill_super(). So whereas before such
iterators or concurrent mounts would have simply slept on s_umount until
SB_BORN was set or the superblock was discard due to initalization
failure they can now needlessly spin through sget{_fc}().

If the caller is sleeping on bdev_lock or open_mutex one caller waiting
on SB_BORN will always spin somewhere and potentially this can go on for
quite a while.

It should be possible to drop s_umount while allowing iterators to wait
on a nascent superblock to either be born or discarded. This patch
implements a wait_var_event() mechanism allowing iterators to sleep
until they are woken when the superblock is born or discarded.

This also allows us to avoid relooping through @fs_supers and
@super_blocks if a superblock isn't yet born or dying.

Link: aca740cecbe5 ("fs: open block device after superblock creation")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 198 +++++++++++++++++++++++++++++++++++++++--------------
 include/linux/fs.h |   1 +
 2 files changed, 148 insertions(+), 51 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index ba5d813c5804..52e7b4153035 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -50,7 +50,7 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 	"sb_internal",
 };
 
-static inline void super_lock(struct super_block *sb, bool excl)
+static inline void __super_lock(struct super_block *sb, bool excl)
 {
 	if (excl)
 		down_write(&sb->s_umount);
@@ -66,14 +66,9 @@ static inline void super_unlock(struct super_block *sb, bool excl)
 		up_read(&sb->s_umount);
 }
 
-static inline void super_lock_excl(struct super_block *sb)
+static inline void __super_lock_excl(struct super_block *sb)
 {
-	super_lock(sb, true);
-}
-
-static inline void super_lock_shared(struct super_block *sb)
-{
-	super_lock(sb, false);
+	__super_lock(sb, true);
 }
 
 static inline void super_unlock_excl(struct super_block *sb)
@@ -86,6 +81,94 @@ static inline void super_unlock_shared(struct super_block *sb)
 	super_unlock(sb, false);
 }
 
+static inline bool wait_born(struct super_block *sb)
+{
+	unsigned int flags;
+
+	/*
+	 * Pairs with smp_store_release() in super_wake() and ensures
+	 * that we see SB_BORN or SB_DYING after we're woken.
+	 */
+	flags = smp_load_acquire(&sb->s_flags);
+	return flags & (SB_BORN | SB_DYING);
+}
+
+/**
+ * super_lock - wait for superblock to become ready
+ * @sb: superblock to wait for
+ * @excl: whether exclusive access is required
+ *
+ * If the superblock has neither passed through vfs_get_tree() or
+ * generic_shutdown_super() yet wait for it to happen. Either superblock
+ * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
+ * woken and we'll see SB_DYING.
+ *
+ * The caller must have acquired a temporary reference on @sb->s_count.
+ *
+ * Return: This returns true if SB_BORN was set, false if SB_DYING was
+ *         set. The function acquires s_umount and returns with it held.
+ */
+static bool super_lock(struct super_block *sb, bool excl)
+{
+
+	lockdep_assert_not_held(&sb->s_umount);
+
+relock:
+	__super_lock(sb, excl);
+
+	/*
+	 * Has gone through generic_shutdown_super() in the meantime.
+	 * @sb->s_root is NULL and @sb->s_active is 0. No one needs to
+	 * grab a reference to this. Tell them so.
+	 */
+	if (sb->s_flags & SB_DYING)
+		return false;
+
+	/* Has called ->get_tree() successfully. */
+	if (sb->s_flags & SB_BORN)
+		return true;
+
+	super_unlock(sb, excl);
+
+	/* wait until the superblock is ready or dying */
+	wait_var_event(&sb->s_flags, wait_born(sb));
+
+	/*
+	 * Neither SB_BORN nor SB_DYING are ever unset so we never loop.
+	 * Just reacquire @sb->s_umount for the caller.
+	 */
+	goto relock;
+}
+
+/* wait and acquire read-side of @sb->s_umount */
+static inline bool super_lock_shared(struct super_block *sb)
+{
+	return super_lock(sb, false);
+}
+
+/* wait and acquire write-side of @sb->s_umount */
+static inline bool super_lock_excl(struct super_block *sb)
+{
+	return super_lock(sb, true);
+}
+
+/* wake waiters */
+#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING)
+static void super_wake(struct super_block *sb, unsigned int flag)
+{
+	unsigned int flags = sb->s_flags;
+
+	WARN_ON_ONCE((flag & ~SUPER_WAKE_FLAGS));
+	WARN_ON_ONCE(hweight32(flag & SUPER_WAKE_FLAGS) > 1);
+
+	/*
+	 * Pairs with smp_load_acquire() in super_lock() and
+	 * ensures that @flag is set before we wake anyone.
+	 */
+	smp_store_release(&sb->s_flags, flags | flag);
+	wake_up_var(&sb->s_flags);
+}
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
@@ -393,7 +476,7 @@ EXPORT_SYMBOL(deactivate_locked_super);
 void deactivate_super(struct super_block *s)
 {
 	if (!atomic_add_unless(&s->s_active, -1, 1)) {
-		super_lock_excl(s);
+		__super_lock_excl(s);
 		deactivate_locked_super(s);
 	}
 }
@@ -415,10 +498,12 @@ EXPORT_SYMBOL(deactivate_super);
  */
 static int grab_super(struct super_block *s) __releases(sb_lock)
 {
+	bool born;
+
 	s->s_count++;
 	spin_unlock(&sb_lock);
-	super_lock_excl(s);
-	if ((s->s_flags & SB_BORN) && atomic_inc_not_zero(&s->s_active)) {
+	born = super_lock_excl(s);
+	if (born && atomic_inc_not_zero(&s->s_active)) {
 		put_super(s);
 		return 1;
 	}
@@ -447,8 +532,8 @@ static int grab_super(struct super_block *s) __releases(sb_lock)
 bool super_trylock_shared(struct super_block *sb)
 {
 	if (down_read_trylock(&sb->s_umount)) {
-		if (!hlist_unhashed(&sb->s_instances) &&
-		    sb->s_root && (sb->s_flags & SB_BORN))
+		if (!(sb->s_flags & SB_DYING) && sb->s_root &&
+		    (sb->s_flags & SB_BORN))
 			return true;
 		super_unlock_shared(sb);
 	}
@@ -475,7 +560,7 @@ bool super_trylock_shared(struct super_block *sb)
 void retire_super(struct super_block *sb)
 {
 	WARN_ON(!sb->s_bdev);
-	super_lock_excl(sb);
+	__super_lock_excl(sb);
 	if (sb->s_iflags & SB_I_PERSB_BDI) {
 		bdi_unregister(sb->s_bdi);
 		sb->s_iflags &= ~SB_I_PERSB_BDI;
@@ -557,6 +642,13 @@ void generic_shutdown_super(struct super_block *sb)
 	/* should be initialized for __put_super_and_need_restart() */
 	hlist_del_init(&sb->s_instances);
 	spin_unlock(&sb_lock);
+	/*
+	 * Broadcast to everyone that grabbed a temporary reference to this
+	 * superblock before we removed it from @fs_supers that the superblock
+	 * is dying. Every walker of @fs_supers outside of sget{_fc}() will now
+	 * discard this superblock and treat it as dead.
+	 */
+	super_wake(sb, SB_DYING);
 	super_unlock_excl(sb);
 	if (sb->s_bdi != &noop_backing_dev_info) {
 		if (sb->s_iflags & SB_I_PERSB_BDI)
@@ -631,6 +723,11 @@ struct super_block *sget_fc(struct fs_context *fc,
 	s->s_type = fc->fs_type;
 	s->s_iflags |= fc->s_iflags;
 	strscpy(s->s_id, s->s_type->name, sizeof(s->s_id));
+	/*
+	 * Make the superblock visible on @super_blocks and @fs_supers.
+	 * It's in a nascent state and users should wait on SB_BORN or
+	 * SB_DYING to be set.
+	 */
 	list_add_tail(&s->s_list, &super_blocks);
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
 	spin_unlock(&sb_lock);
@@ -740,7 +837,8 @@ static void __iterate_supers(void (*f)(struct super_block *))
 
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (hlist_unhashed(&sb->s_instances))
+		/* Pairs with smp_store_release() in super_wake(). */
+		if (smp_load_acquire(&sb->s_flags) & SB_DYING)
 			continue;
 		sb->s_count++;
 		spin_unlock(&sb_lock);
@@ -770,13 +868,13 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (hlist_unhashed(&sb->s_instances))
-			continue;
+		bool born;
+
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		super_lock_shared(sb);
-		if (sb->s_root && (sb->s_flags & SB_BORN))
+		born = super_lock_shared(sb);
+		if (born && sb->s_root)
 			f(sb, arg);
 		super_unlock_shared(sb);
 
@@ -806,11 +904,13 @@ void iterate_supers_type(struct file_system_type *type,
 
 	spin_lock(&sb_lock);
 	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
+		bool born;
+
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		super_lock_shared(sb);
-		if (sb->s_root && (sb->s_flags & SB_BORN))
+		born = super_lock_shared(sb);
+		if (born && sb->s_root)
 			f(sb, arg);
 		super_unlock_shared(sb);
 
@@ -841,14 +941,11 @@ struct super_block *get_active_super(struct block_device *bdev)
 	if (!bdev)
 		return NULL;
 
-restart:
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (hlist_unhashed(&sb->s_instances))
-			continue;
 		if (sb->s_bdev == bdev) {
 			if (!grab_super(sb))
-				goto restart;
+				return NULL;
 			super_unlock_excl(sb);
 			return sb;
 		}
@@ -862,22 +959,21 @@ struct super_block *user_get_super(dev_t dev, bool excl)
 	struct super_block *sb;
 
 	spin_lock(&sb_lock);
-rescan:
 	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (hlist_unhashed(&sb->s_instances))
-			continue;
 		if (sb->s_dev ==  dev) {
+			bool born;
+
 			sb->s_count++;
 			spin_unlock(&sb_lock);
-			super_lock(sb, excl);
 			/* still alive? */
-			if (sb->s_root && (sb->s_flags & SB_BORN))
+			born = super_lock(sb, excl);
+			if (born && sb->s_root)
 				return sb;
 			super_unlock(sb, excl);
 			/* nope, got unmounted */
 			spin_lock(&sb_lock);
 			__put_super(sb);
-			goto rescan;
+			break;
 		}
 	}
 	spin_unlock(&sb_lock);
@@ -921,7 +1017,7 @@ int reconfigure_super(struct fs_context *fc)
 		if (!hlist_empty(&sb->s_pins)) {
 			super_unlock_excl(sb);
 			group_pin_kill(&sb->s_pins);
-			super_lock_excl(sb);
+			__super_lock_excl(sb);
 			if (!sb->s_root)
 				return 0;
 			if (sb->s_writers.frozen != SB_UNFROZEN)
@@ -984,9 +1080,9 @@ int reconfigure_super(struct fs_context *fc)
 
 static void do_emergency_remount_callback(struct super_block *sb)
 {
-	super_lock_excl(sb);
-	if (sb->s_root && sb->s_bdev && (sb->s_flags & SB_BORN) &&
-	    !sb_rdonly(sb)) {
+	bool born = super_lock_excl(sb);
+
+	if (born && sb->s_root && sb->s_bdev && !sb_rdonly(sb)) {
 		struct fs_context *fc;
 
 		fc = fs_context_for_reconfigure(sb->s_root,
@@ -1020,8 +1116,9 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb)
 {
-	super_lock_excl(sb);
-	if (sb->s_root && sb->s_flags & SB_BORN) {
+	bool born = super_lock_excl(sb);
+
+	if (born && sb->s_root) {
 		emergency_thaw_bdev(sb);
 		thaw_super_locked(sb);
 	} else {
@@ -1212,9 +1309,9 @@ EXPORT_SYMBOL(get_tree_keyed);
  */
 static bool super_lock_shared_active(struct super_block *sb)
 {
-	super_lock_shared(sb);
-	if (!sb->s_root ||
-	    (sb->s_flags & (SB_ACTIVE | SB_BORN)) != (SB_ACTIVE | SB_BORN)) {
+	bool born = super_lock_shared(sb);
+
+	if (!born || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
 		super_unlock_shared(sb);
 		return false;
 	}
@@ -1374,7 +1471,7 @@ int get_tree_bdev(struct fs_context *fc,
 		 */
 		super_unlock_excl(s);
 		error = setup_bdev_super(s, fc->sb_flags, fc);
-		super_lock_excl(s);
+		__super_lock_excl(s);
 		if (!error)
 			error = fill_super(s, fc);
 		if (error) {
@@ -1426,7 +1523,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 		 */
 		super_unlock_excl(s);
 		error = setup_bdev_super(s, flags, NULL);
-		super_lock_excl(s);
+		__super_lock_excl(s);
 		if (!error)
 			error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
 		if (error) {
@@ -1566,13 +1663,12 @@ int vfs_get_tree(struct fs_context *fc)
 	WARN_ON(!sb->s_bdi);
 
 	/*
-	 * Write barrier is for super_cache_count(). We place it before setting
-	 * SB_BORN as the data dependency between the two functions is the
-	 * superblock structure contents that we just set up, not the SB_BORN
-	 * flag.
+	 * super_wake() contains a smp_store_release() which also takes care of
+	 * ordering for super_cache_count(). We place it before setting SB_BORN
+	 * as the data dependency between the two functions is the superblock
+	 * structure contents that we just set up, not the SB_BORN flag.
 	 */
-	smp_wmb();
-	sb->s_flags |= SB_BORN;
+	super_wake(sb, SB_BORN);
 
 	error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
 	if (unlikely(error)) {
@@ -1715,7 +1811,7 @@ int freeze_super(struct super_block *sb)
 	int ret;
 
 	atomic_inc(&sb->s_active);
-	super_lock_excl(sb);
+	__super_lock_excl(sb);
 	if (sb->s_writers.frozen != SB_UNFROZEN) {
 		deactivate_locked_super(sb);
 		return -EBUSY;
@@ -1737,7 +1833,7 @@ int freeze_super(struct super_block *sb)
 	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
 	super_unlock_excl(sb);
 	sb_wait_write(sb, SB_FREEZE_WRITE);
-	super_lock_excl(sb);
+	__super_lock_excl(sb);
 
 	/* Now we go and block page faults... */
 	sb->s_writers.frozen = SB_FREEZE_PAGEFAULT;
@@ -1820,7 +1916,7 @@ static int thaw_super_locked(struct super_block *sb)
  */
 int thaw_super(struct super_block *sb)
 {
-	super_lock_excl(sb);
+	__super_lock_excl(sb);
 	return thaw_super_locked(sb);
 }
 EXPORT_SYMBOL(thaw_super);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 14b5777a24a0..173672645156 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1095,6 +1095,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
 
 /* These sb flags are internal to the kernel */
+#define SB_DYING        BIT(24)
 #define SB_SUBMOUNT     BIT(26)
 #define SB_FORCE        BIT(27)
 #define SB_NOSEC        BIT(28)

-- 
2.34.1

