Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360ED77F473
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350014AbjHQKsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350005AbjHQKsB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11FD2D5A
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 03:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54F726297A
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 10:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A906EC433C9;
        Thu, 17 Aug 2023 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692269278;
        bh=DG3KyEsgYnQ6Lsb8x85rAWB6N47XZCDHjFyh260y7l4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=tuvtlZk3/Bae48fTjtCmznwPFFEXazkxrNWiehudPguxMuUU5soDkWkup+2sb4ccs
         Ta7qvOL842fwacH9TB28T1q0am9dPaza8Jl8EtQFdj1MpvGB9Y1RnWr/cwgh4wd6JJ
         392MVg49OwFwaa4mkLAnbYWINO6DqDj9PO+MZ/3xuAyC3QrkQH+UndcNdcVw8T4f4Q
         ygkd5TX+DSudMfzU6i663UyC/YORzSiFZ8KD6aLa1qBfhdrAx0ohOhMxPtzqM8aVXX
         QwQc+HpSNP+bs1ZQWnEKoq9Kh2I4McKZy7zl6F2Y9nosegBi0X+lOUKMXRrSGCXua4
         BGk1LFSRiZDBA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Thu, 17 Aug 2023 12:47:43 +0200
Subject: [PATCH 2/3] super: wait for nascent superblocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-vfs-super-fixes-v3-v1-2-06ddeca7059b@kernel.org>
References: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
In-Reply-To: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
To:     Jan Kara <jack@suse.com>, Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=10239; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DG3KyEsgYnQ6Lsb8x85rAWB6N47XZCDHjFyh260y7l4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTc/XWL45QPm6XUkS3L1YrN3gk8XjlDqatGObj6c0dKzOcF
 Cw3TO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyPIvhn3pfxwnJe3Gmy5+KKSSWXm
 T0nV3f/1FC5W5C4uHip/83aDD84b/+6rpaw94YAePXYtVxNr4Vc1ONojZ/bGeNUz1joyHFBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recent patches experiment with making it possible to allocate a new
superblock before opening the relevant block device. Naturally this has
intricate side-effects that we get to learn about while developing this.

Superblock allocators such as sget{_fc}() return with s_umount of the
new superblock held and ock ordering currently requires that block level
locks such as bdev_lock and open_mutex rank above s_umount.

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
on SB_BORN will always spin somewhere potentially this can go on for
quite a while.

It should be possible to drop s_umount while allowing iterators to wait
on a nascent superblock to either be born or discarded. This patch
implements a wait_var_event() mechanism allowing iterators to sleep
until they are woken when the superblock is born or discarded.

This should also allows us to avoid relooping through @fs_supers and
@super_blocks if a superblock isn't yet born or dying.

Link: aca740cecbe5 ("fs: open block device after superblock creation")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 146 +++++++++++++++++++++++++++++++++++++++++++++--------
 include/linux/fs.h |   1 +
 2 files changed, 125 insertions(+), 22 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 878675921bdc..55bf495763d9 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -86,6 +86,89 @@ static inline void super_unlock_read(struct super_block *sb)
 	super_unlock(sb, false);
 }
 
+static inline bool wait_born(struct super_block *sb)
+{
+	unsigned int flags;
+
+	/*
+	 * Pairs with smp_store_release() in super_wake() and ensure
+	 * that we see SB_BORN or SB_DYING after we're woken.
+	 */
+	flags = smp_load_acquire(&sb->s_flags);
+	return flags & (SB_BORN | SB_DYING);
+}
+
+/**
+ * super_wait - wait for superblock to become ready
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
+ * Return: true if SB_BORN was set, false if SB_DYING was set.
+ */
+static bool super_wait(struct super_block *sb, bool excl)
+{
+
+	lockdep_assert_not_held(&sb->s_umount);
+
+relock:
+	super_lock(sb, excl);
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
+static inline bool super_wait_read(struct super_block *sb)
+{
+	return super_wait(sb, false);
+}
+
+/* wait and acquire write-side of @sb->s_umount */
+static inline bool super_wait_write(struct super_block *sb)
+{
+	return super_wait(sb, true);
+}
+
+/* wake waiters */
+static void super_wake(struct super_block *sb, unsigned int flag)
+{
+	unsigned int flags = sb->s_flags;
+
+	/*
+	 * Pairs with smp_load_acquire() in super_wait() and ensure that
+	 * we @flag is set before we wake anyone.
+	 */
+	smp_store_release(&sb->s_flags, flags | flag);
+	wake_up_var(&sb->s_flags);
+}
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
@@ -415,10 +498,12 @@ EXPORT_SYMBOL(deactivate_super);
  */
 static int grab_super(struct super_block *s) __releases(sb_lock)
 {
+	bool born;
+
 	s->s_count++;
 	spin_unlock(&sb_lock);
-	super_lock_write(s);
-	if ((s->s_flags & SB_BORN) && atomic_inc_not_zero(&s->s_active)) {
+	born = super_wait_write(s);
+	if (born && atomic_inc_not_zero(&s->s_active)) {
 		put_super(s);
 		return 1;
 	}
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
 	super_unlock_write(sb);
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
@@ -770,13 +867,15 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
+		bool born;
+
 		if (hlist_unhashed(&sb->s_instances))
 			continue;
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		super_lock_read(sb);
-		if (sb->s_root && (sb->s_flags & SB_BORN))
+		born = super_wait_read(sb);
+		if (born && sb->s_root)
 			f(sb, arg);
 		super_unlock_read(sb);
 
@@ -806,11 +905,13 @@ void iterate_supers_type(struct file_system_type *type,
 
 	spin_lock(&sb_lock);
 	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
+		bool born;
+
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		super_lock_read(sb);
-		if (sb->s_root && (sb->s_flags & SB_BORN))
+		born = super_wait_read(sb);
+		if (born && sb->s_root)
 			f(sb, arg);
 		super_unlock_read(sb);
 
@@ -841,15 +942,14 @@ struct super_block *get_active_super(struct block_device *bdev)
 	if (!bdev)
 		return NULL;
 
-restart:
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
 		if (hlist_unhashed(&sb->s_instances))
 			continue;
 		if (sb->s_bdev == bdev) {
 			if (!grab_super(sb))
-				goto restart;
-			super_unlock_write(sb);
+				return NULL;
+                        super_unlock_write(sb);
 			return sb;
 		}
 	}
@@ -862,22 +962,23 @@ struct super_block *user_get_super(dev_t dev, bool excl)
 	struct super_block *sb;
 
 	spin_lock(&sb_lock);
-rescan:
 	list_for_each_entry(sb, &super_blocks, s_list) {
 		if (hlist_unhashed(&sb->s_instances))
 			continue;
 		if (sb->s_dev ==  dev) {
+			bool born;
+
 			sb->s_count++;
 			spin_unlock(&sb_lock);
-			super_lock(sb, excl);
 			/* still alive? */
-			if (sb->s_root && (sb->s_flags & SB_BORN))
+			born = super_wait(sb, excl);
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
@@ -984,9 +1085,9 @@ int reconfigure_super(struct fs_context *fc)
 
 static void do_emergency_remount_callback(struct super_block *sb)
 {
-	super_lock_write(sb);
-	if (sb->s_root && sb->s_bdev && (sb->s_flags & SB_BORN) &&
-	    !sb_rdonly(sb)) {
+	bool born = super_wait_write(sb);
+
+	if (born && sb->s_root && sb->s_bdev && !sb_rdonly(sb)) {
 		struct fs_context *fc;
 
 		fc = fs_context_for_reconfigure(sb->s_root,
@@ -1020,8 +1121,9 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb)
 {
-	super_lock_write(sb);
-	if (sb->s_root && sb->s_flags & SB_BORN) {
+	bool born = super_wait_write(sb);
+
+	if (born && sb->s_root) {
 		emergency_thaw_bdev(sb);
 		thaw_super_locked(sb);
 	} else {
@@ -1212,9 +1314,9 @@ EXPORT_SYMBOL(get_tree_keyed);
  */
 static bool lock_active_super(struct super_block *sb)
 {
-	super_lock_read(sb);
-	if (!sb->s_root ||
-	    (sb->s_flags & (SB_ACTIVE | SB_BORN)) != (SB_ACTIVE | SB_BORN)) {
+	bool born = super_wait_read(sb);
+
+	if (!born || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
 		super_unlock_read(sb);
 		return false;
 	}
@@ -1572,7 +1674,7 @@ int vfs_get_tree(struct fs_context *fc)
 	 * flag.
 	 */
 	smp_wmb();
-	sb->s_flags |= SB_BORN;
+	super_wake(sb, SB_BORN);
 
 	error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
 	if (unlikely(error)) {
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

