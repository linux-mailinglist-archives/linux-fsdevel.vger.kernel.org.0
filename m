Return-Path: <linux-fsdevel+bounces-1303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6327D8E9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50812B21383
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C328F4F;
	Fri, 27 Oct 2023 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE398F43
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:25:10 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EF51B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 23:25:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA08267373; Fri, 27 Oct 2023 08:25:01 +0200 (CEST)
Date: Fri, 27 Oct 2023 08:25:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] fs: massage locking helpers
Message-ID: <20231027062501.GA9028@lst.de>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org> <20231024-vfs-super-freeze-v2-1-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-1-599c19f4faac@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 24, 2023 at 03:01:07PM +0200, Christian Brauner wrote:
> Multiple people have balked at the the fact that
> super_lock{_shared,_excluse}() return booleans and even if they return
> false hold s_umount. So let's change them to only hold s_umount when
> true is returned and change the code accordingly.

With the fix suggested by Jan this looks good an a huge improvement:

Reviewed-by: Christoph Hellwig <hch@lst.de>

That being said, I find the {,__}super_{,un}lock{,_excl} helpers still
confusing as hell.

I'd prefer to remove the __super_lock and super_unlock and wrapping
the loking calls is just horrible confusing, and instead of just
looking at a trivial say:

	down_write(&sb->s_umount)

I now have to chase through two levels on indirections to figure out
what is going on, not helped by the boolean flag that is just
passed as true/false instead of clearly documenting what it does.

Below is what I'd do (on top of the whole series):

 - remove all wrappers
 - rename super_lock to lock_ready_super
 - add an enum telling if it locks exclusive or shared

I could probably live with 2 helpers taking/releasing s_umount
based on the same enum if we really want, but preferable only
for the case that actually handle both case.   But I think just
open coding them is easier to understand.

---
diff --git a/fs/super.c b/fs/super.c
index b26b302f870d24..b8ea32c7cd03e6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -50,37 +50,6 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 	"sb_internal",
 };
 
-static inline void __super_lock(struct super_block *sb, bool excl)
-{
-	if (excl)
-		down_write(&sb->s_umount);
-	else
-		down_read(&sb->s_umount);
-}
-
-static inline void super_unlock(struct super_block *sb, bool excl)
-{
-	if (excl)
-		up_write(&sb->s_umount);
-	else
-		up_read(&sb->s_umount);
-}
-
-static inline void __super_lock_excl(struct super_block *sb)
-{
-	__super_lock(sb, true);
-}
-
-static inline void super_unlock_excl(struct super_block *sb)
-{
-	super_unlock(sb, true);
-}
-
-static inline void super_unlock_shared(struct super_block *sb)
-{
-	super_unlock(sb, false);
-}
-
 static inline bool wait_born(struct super_block *sb)
 {
 	unsigned int flags;
@@ -93,10 +62,15 @@ static inline bool wait_born(struct super_block *sb)
 	return flags & (SB_BORN | SB_DYING);
 }
 
+enum lock_super_mode {
+	LOCK_SUPER_SHARED,
+	LOCK_SUPER_EXCL,
+};
+
 /**
- * super_lock - wait for superblock to become ready and lock it
+ * lock_ready_super - wait for superblock to become ready and lock it
  * @sb: superblock to wait for
- * @excl: whether exclusive access is required
+ * @mode: whether exclusive access is required
  *
  * If the superblock has neither passed through vfs_get_tree() or
  * generic_shutdown_super() yet wait for it to happen. Either superblock
@@ -109,29 +83,37 @@ static inline bool wait_born(struct super_block *sb)
  *         s_umount held. The function returns false if SB_DYING was
  *         set and without s_umount held.
  */
-static __must_check bool super_lock(struct super_block *sb, bool excl)
+static __must_check bool lock_ready_super(struct super_block *sb,
+		enum lock_super_mode mode)
 {
+	bool is_dying;
 
 	lockdep_assert_not_held(&sb->s_umount);
 
 relock:
-	__super_lock(sb, excl);
+	if (mode == LOCK_SUPER_EXCL)
+		down_write(&sb->s_umount);
+	else
+		down_read(&sb->s_umount);
+
+	/* Has called ->get_tree() successfully. */
+	if ((sb->s_flags & (SB_BORN | SB_DYING)) == SB_BORN)
+		return true;
 
 	/*
 	 * Has gone through generic_shutdown_super() in the meantime.
 	 * @sb->s_root is NULL and @sb->s_active is 0. No one needs to
 	 * grab a reference to this. Tell them so.
 	 */
-	if (sb->s_flags & SB_DYING) {
-		super_unlock(sb, excl);
-		return false;
-	}
+	is_dying = sb->s_flags & SB_DYING;
 
-	/* Has called ->get_tree() successfully. */
-	if (sb->s_flags & SB_BORN)
-		return true;
+	if (mode == LOCK_SUPER_EXCL)
+		up_write(&sb->s_umount);
+	else
+		up_read(&sb->s_umount);
 
-	super_unlock(sb, excl);
+	if (is_dying)
+		return false;
 
 	/* wait until the superblock is ready or dying */
 	wait_var_event(&sb->s_flags, wait_born(sb));
@@ -143,18 +125,6 @@ static __must_check bool super_lock(struct super_block *sb, bool excl)
 	goto relock;
 }
 
-/* wait and try to acquire read-side of @sb->s_umount */
-static inline bool super_lock_shared(struct super_block *sb)
-{
-	return super_lock(sb, false);
-}
-
-/* wait and try to acquire write-side of @sb->s_umount */
-static inline bool super_lock_excl(struct super_block *sb)
-{
-	return super_lock(sb, true);
-}
-
 /* wake waiters */
 #define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING | SB_DEAD)
 static void super_wake(struct super_block *sb, unsigned int flag)
@@ -163,7 +133,7 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	WARN_ON_ONCE(hweight32(flag & SUPER_WAKE_FLAGS) > 1);
 
 	/*
-	 * Pairs with smp_load_acquire() in super_lock() to make sure
+	 * Pairs with smp_load_acquire() in lock_ready_super() to make sure
 	 * all initializations in the superblock are seen by the user
 	 * seeing SB_BORN sent.
 	 */
@@ -237,7 +207,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 		freed += sb->s_op->free_cached_objects(sb, sc);
 	}
 
-	super_unlock_shared(sb);
+	up_read(&sb->s_umount);
 	return freed;
 }
 
@@ -303,7 +273,7 @@ static void destroy_unused_super(struct super_block *s)
 {
 	if (!s)
 		return;
-	super_unlock_excl(s);
+	up_write(&s->s_umount);
 	list_lru_destroy(&s->s_dentry_lru);
 	list_lru_destroy(&s->s_inode_lru);
 	security_sb_free(s);
@@ -496,7 +466,7 @@ void deactivate_locked_super(struct super_block *s)
 		put_filesystem(fs);
 		put_super(s);
 	} else {
-		super_unlock_excl(s);
+		up_write(&s->s_umount);
 	}
 }
 
@@ -513,7 +483,7 @@ EXPORT_SYMBOL(deactivate_locked_super);
 void deactivate_super(struct super_block *s)
 {
 	if (!atomic_add_unless(&s->s_active, -1, 1)) {
-		__super_lock_excl(s);
+		down_write(&s->s_umount);
 		deactivate_locked_super(s);
 	}
 }
@@ -550,13 +520,13 @@ static bool grab_super(struct super_block *sb)
 
 	sb->s_count++;
 	spin_unlock(&sb_lock);
-	locked = super_lock_excl(sb);
+	locked = lock_ready_super(sb, LOCK_SUPER_EXCL);
 	if (locked) {
 		if (atomic_inc_not_zero(&sb->s_active)) {
 			put_super(sb);
 			return true;
 		}
-		super_unlock_excl(sb);
+		up_write(&sb->s_umount);
 	}
 	wait_var_event(&sb->s_flags, wait_dead(sb));
 	put_super(sb);
@@ -586,7 +556,7 @@ bool super_trylock_shared(struct super_block *sb)
 		if (!(sb->s_flags & SB_DYING) && sb->s_root &&
 		    (sb->s_flags & SB_BORN))
 			return true;
-		super_unlock_shared(sb);
+		up_read(&sb->s_umount);
 	}
 
 	return false;
@@ -611,13 +581,13 @@ bool super_trylock_shared(struct super_block *sb)
 void retire_super(struct super_block *sb)
 {
 	WARN_ON(!sb->s_bdev);
-	__super_lock_excl(sb);
+	down_write(&sb->s_umount);
 	if (sb->s_iflags & SB_I_PERSB_BDI) {
 		bdi_unregister(sb->s_bdi);
 		sb->s_iflags &= ~SB_I_PERSB_BDI;
 	}
 	sb->s_iflags |= SB_I_RETIRED;
-	super_unlock_excl(sb);
+	up_write(&sb->s_umount);
 }
 EXPORT_SYMBOL(retire_super);
 
@@ -699,7 +669,7 @@ void generic_shutdown_super(struct super_block *sb)
 	 * sget{_fc}() until we passed sb->kill_sb().
 	 */
 	super_wake(sb, SB_DYING);
-	super_unlock_excl(sb);
+	up_write(&sb->s_umount);
 	if (sb->s_bdi != &noop_backing_dev_info) {
 		if (sb->s_iflags & SB_I_PERSB_BDI)
 			bdi_unregister(sb->s_bdi);
@@ -886,7 +856,7 @@ EXPORT_SYMBOL(sget);
 
 void drop_super(struct super_block *sb)
 {
-	super_unlock_shared(sb);
+	up_read(&sb->s_umount);
 	put_super(sb);
 }
 
@@ -894,7 +864,7 @@ EXPORT_SYMBOL(drop_super);
 
 void drop_super_exclusive(struct super_block *sb)
 {
-	super_unlock_excl(sb);
+	up_write(&sb->s_umount);
 	put_super(sb);
 }
 EXPORT_SYMBOL(drop_super_exclusive);
@@ -941,11 +911,11 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		locked = super_lock_shared(sb);
+		locked = lock_ready_super(sb, LOCK_SUPER_SHARED);
 		if (locked) {
 			if (sb->s_root)
 				f(sb, arg);
-			super_unlock_shared(sb);
+			up_read(&sb->s_umount);
 		}
 
 		spin_lock(&sb_lock);
@@ -979,11 +949,11 @@ void iterate_supers_type(struct file_system_type *type,
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		locked = super_lock_shared(sb);
+		locked = lock_ready_super(sb, LOCK_SUPER_SHARED);
 		if (locked) {
 			if (sb->s_root)
 				f(sb, arg);
-			super_unlock_shared(sb);
+			up_read(&sb->s_umount);
 		}
 
 		spin_lock(&sb_lock);
@@ -1010,11 +980,14 @@ struct super_block *user_get_super(dev_t dev, bool excl)
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			/* still alive? */
-			locked = super_lock(sb, excl);
+			locked = lock_ready_super(sb, excl);
 			if (locked) {
 				if (sb->s_root)
 					return sb;
-				super_unlock(sb, excl);
+				if (excl)
+					up_write(&sb->s_umount);
+				else
+					up_read(&sb->s_umount);
 			}
 			/* nope, got unmounted */
 			spin_lock(&sb_lock);
@@ -1061,9 +1034,9 @@ int reconfigure_super(struct fs_context *fc)
 
 	if (remount_ro) {
 		if (!hlist_empty(&sb->s_pins)) {
-			super_unlock_excl(sb);
+			up_write(&sb->s_umount);
 			group_pin_kill(&sb->s_pins);
-			__super_lock_excl(sb);
+			down_write(&sb->s_umount);
 			if (!sb->s_root)
 				return 0;
 			if (sb->s_writers.frozen != SB_UNFROZEN)
@@ -1126,7 +1099,7 @@ int reconfigure_super(struct fs_context *fc)
 
 static void do_emergency_remount_callback(struct super_block *sb)
 {
-	bool locked = super_lock_excl(sb);
+	bool locked = lock_ready_super(sb, LOCK_SUPER_EXCL);
 
 	if (locked && sb->s_root && sb->s_bdev && !sb_rdonly(sb)) {
 		struct fs_context *fc;
@@ -1140,7 +1113,7 @@ static void do_emergency_remount_callback(struct super_block *sb)
 		}
 	}
 	if (locked)
-		super_unlock_excl(sb);
+		up_write(&sb->s_umount);
 }
 
 static void do_emergency_remount(struct work_struct *work)
@@ -1163,7 +1136,7 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb)
 {
-	bool locked = super_lock_excl(sb);
+	bool locked = lock_ready_super(sb, LOCK_SUPER_EXCL);
 
 	if (locked && sb->s_root) {
 		if (IS_ENABLED(CONFIG_BLOCK))
@@ -1173,7 +1146,7 @@ static void do_thaw_all_callback(struct super_block *sb)
 		return;
 	}
 	if (locked)
-		super_unlock_excl(sb);
+		up_write(&sb->s_umount);
 }
 
 static void do_thaw_all(struct work_struct *work)
@@ -1394,7 +1367,7 @@ static struct super_block *bdev_super_lock(struct block_device *bdev, bool excl)
 
 	mutex_unlock(&bdev->bd_holder_lock);
 
-	locked = super_lock(sb, excl);
+	locked = lock_ready_super(sb, excl);
 	put_super(sb);
 	if (!locked)
 		return NULL;
@@ -1418,7 +1391,7 @@ static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
 		return NULL;
 
 	if (!sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
-		super_unlock_shared(sb);
+		up_read(&sb->s_umount);
 		return NULL;
 	}
 
@@ -1440,7 +1413,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 	if (sb->s_op->shutdown)
 		sb->s_op->shutdown(sb);
 
-	super_unlock_shared(sb);
+	up_read(&sb->s_umount);
 }
 
 static void fs_bdev_sync(struct block_device *bdev)
@@ -1451,7 +1424,7 @@ static void fs_bdev_sync(struct block_device *bdev)
 	if (!sb)
 		return;
 	sync_filesystem(sb);
-	super_unlock_shared(sb);
+	up_read(&sb->s_umount);
 }
 
 static struct super_block *get_bdev_super(struct block_device *bdev)
@@ -1462,7 +1435,7 @@ static struct super_block *get_bdev_super(struct block_device *bdev)
 	sb = bdev_super_lock(bdev, true);
 	if (sb) {
 		active = atomic_inc_not_zero(&sb->s_active);
-		super_unlock_excl(sb);
+		up_write(&sb->s_umount);
 	}
 	if (!active)
 		return NULL;
@@ -1619,9 +1592,9 @@ int get_tree_bdev(struct fs_context *fc,
 		 * bdev_mark_dead()). It is safe because we have active sb
 		 * reference and SB_BORN is not set yet.
 		 */
-		super_unlock_excl(s);
+		up_write(&s->s_umount);
 		error = setup_bdev_super(s, fc->sb_flags, fc);
-		__super_lock_excl(s);
+		down_write(&s->s_umount);
 		if (!error)
 			error = fill_super(s, fc);
 		if (error) {
@@ -1671,9 +1644,9 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 		 * bdev_mark_dead()). It is safe because we have active sb
 		 * reference and SB_BORN is not set yet.
 		 */
-		super_unlock_excl(s);
+		up_write(&s->s_umount);
 		error = setup_bdev_super(s, flags, NULL);
-		__super_lock_excl(s);
+		down_write(&s->s_umount);
 		if (!error)
 			error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
 		if (error) {
@@ -1990,7 +1963,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 {
 	int ret;
 
-	if (!super_lock_excl(sb)) {
+	if (!lock_ready_super(sb, LOCK_SUPER_EXCL)) {
 		WARN_ON_ONCE("Dying superblock while freezing!");
 		return -EINVAL;
 	}
@@ -2010,7 +1983,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		 * freeze and assign the active ref to the freeze.
 		 */
 		sb->s_writers.freeze_holders |= who;
-		super_unlock_excl(sb);
+		up_write(&sb->s_umount);
 		return 0;
 	}
 
@@ -2025,7 +1998,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	}
 
 	if (!(sb->s_flags & SB_BORN)) {
-		super_unlock_excl(sb);
+		up_write(&sb->s_umount);
 		return 0;	/* sic - it's "nothing to do" */
 	}
 
@@ -2034,15 +2007,15 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		sb->s_writers.freeze_holders |= who;
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 		wake_up_var(&sb->s_writers.frozen);
-		super_unlock_excl(sb);
+		up_write(&sb->s_umount);
 		return 0;
 	}
 
 	sb->s_writers.frozen = SB_FREEZE_WRITE;
 	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
-	super_unlock_excl(sb);
+	up_write(&sb->s_umount);
 	sb_wait_write(sb, SB_FREEZE_WRITE);
-	if (!super_lock_excl(sb)) {
+	if (!lock_ready_super(sb, LOCK_SUPER_EXCL)) {
 		WARN_ON_ONCE("Dying superblock while freezing!");
 		return -EINVAL;
 	}
@@ -2085,7 +2058,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 	wake_up_var(&sb->s_writers.frozen);
 	lockdep_sb_freeze_release(sb);
-	super_unlock_excl(sb);
+	up_write(&sb->s_umount);
 	return 0;
 }
 EXPORT_SYMBOL(freeze_super);
@@ -2102,7 +2075,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 
 	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
 		if (!(sb->s_writers.freeze_holders & who)) {
-			super_unlock_excl(sb);
+			up_write(&sb->s_umount);
 			return -EINVAL;
 		}
 
@@ -2117,7 +2090,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 			return 0;
 		}
 	} else {
-		super_unlock_excl(sb);
+		up_write(&sb->s_umount);
 		return -EINVAL;
 	}
 
@@ -2135,7 +2108,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 		if (error) {
 			printk(KERN_ERR "VFS:Filesystem thaw failed\n");
 			lockdep_sb_freeze_release(sb);
-			super_unlock_excl(sb);
+			up_write(&sb->s_umount);
 			return error;
 		}
 	}
@@ -2163,7 +2136,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
  */
 int thaw_super(struct super_block *sb, enum freeze_holder who)
 {
-	if (!super_lock_excl(sb)) {
+	if (!lock_ready_super(sb, LOCK_SUPER_EXCL)) {
 		WARN_ON_ONCE("Dying superblock while thawing!");
 		return -EINVAL;
 	}

