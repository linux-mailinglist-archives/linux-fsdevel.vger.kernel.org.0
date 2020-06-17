Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB791FCD19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 14:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgFQMJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 08:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgFQMJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:09:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E2C061573;
        Wed, 17 Jun 2020 05:09:46 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlWso-0000I0-Hh; Wed, 17 Jun 2020 14:09:36 +0200
Date:   Wed, 17 Jun 2020 14:09:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] fs/namespace.c: use spinlock instead of busy loop
Message-ID: <20200617120934.di3hiswezojpy3ft@linutronix.de>
References: <20200617104058.14902-1-john.ogness@linutronix.de>
 <20200617104058.14902-2-john.ogness@linutronix.de>
 <20200617112719.GI2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617112719.GI2531@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-17 13:27:19 [+0200], Peter Zijlstra wrote:
> Why can't you use a regular percpu-rwsem for this?

This is the percpu-rwsem version. The lock is per struct super_block not
per mount point. This is due to the restriction in
sb_prepare_remount_readonly().

diff --git a/fs/mount.h b/fs/mount.h
index 711a4093e475..344fae9931b5 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -4,6 +4,7 @@
 #include <linux/poll.h>
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
+#include <linux/percpu-rwsem.h>
 
 struct mnt_namespace {
 	atomic_t		count;
@@ -40,6 +41,7 @@ struct mount {
 		struct rcu_head mnt_rcu;
 		struct llist_node mnt_llist;
 	};
+	struct percpu_rw_semaphore mnt_writers_rws;
 #ifdef CONFIG_SMP
 	struct mnt_pcp __percpu *mnt_pcp;
 #else
diff --git a/fs/namespace.c b/fs/namespace.c
index a28e4db075ed..cc05c922d7d6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -311,30 +311,17 @@ static int mnt_is_readonly(struct vfsmount *mnt)
 int __mnt_want_write(struct vfsmount *m)
 {
 	struct mount *mnt = real_mount(m);
+	struct super_block *sb = m->mnt_sb;
 	int ret = 0;
 
-	preempt_disable();
-	mnt_inc_writers(mnt);
-	/*
-	 * The store to mnt_inc_writers must be visible before we pass
-	 * MNT_WRITE_HOLD loop below, so that the slowpath can see our
-	 * incremented count after it has set MNT_WRITE_HOLD.
-	 */
-	smp_mb();
-	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD)
-		cpu_relax();
-	/*
-	 * After the slowpath clears MNT_WRITE_HOLD, mnt_is_readonly will
-	 * be set to match its requirements. So we must not load that until
-	 * MNT_WRITE_HOLD is cleared.
-	 */
-	smp_rmb();
-	if (mnt_is_readonly(m)) {
-		mnt_dec_writers(mnt);
+	percpu_down_read(&sb->mnt_writers_rws);
+
+	if (mnt_is_readonly(m))
 		ret = -EROFS;
-	}
-	preempt_enable();
+	else
+		mnt_inc_writers(mnt);
 
+	percpu_up_read(&sb->mnt_writers_rws);
 	return ret;
 }
 
@@ -459,53 +446,30 @@ void mnt_drop_write_file(struct file *file)
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
 
-static int mnt_make_readonly(struct mount *mnt)
+static int mnt_make_readonly(struct super_block *sb, struct mount *mnt)
 {
 	int ret = 0;
 
+	percpu_down_write(&sb->mnt_writers_rws);
 	lock_mount_hash();
-	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
-	/*
-	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
-	 * should be visible before we do.
-	 */
-	smp_mb();
 
-	/*
-	 * With writers on hold, if this value is zero, then there are
-	 * definitely no active writers (although held writers may subsequently
-	 * increment the count, they'll have to wait, and decrement it after
-	 * seeing MNT_READONLY).
-	 *
-	 * It is OK to have counter incremented on one CPU and decremented on
-	 * another: the sum will add up correctly. The danger would be when we
-	 * sum up each counter, if we read a counter before it is incremented,
-	 * but then read another CPU's count which it has been subsequently
-	 * decremented from -- we would see more decrements than we should.
-	 * MNT_WRITE_HOLD protects against this scenario, because
-	 * mnt_want_write first increments count, then smp_mb, then spins on
-	 * MNT_WRITE_HOLD, so it can't be decremented by another CPU while
-	 * we're counting up here.
-	 */
 	if (mnt_get_writers(mnt) > 0)
 		ret = -EBUSY;
 	else
 		mnt->mnt.mnt_flags |= MNT_READONLY;
-	/*
-	 * MNT_READONLY must become visible before ~MNT_WRITE_HOLD, so writers
-	 * that become unheld will see MNT_READONLY.
-	 */
-	smp_wmb();
-	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+
 	unlock_mount_hash();
+	percpu_up_write(&sb->mnt_writers_rws);
 	return ret;
 }
 
-static int __mnt_unmake_readonly(struct mount *mnt)
+static int __mnt_unmake_readonly(struct super_block *sb, struct mount *mnt)
 {
+	percpu_down_write(&sb->mnt_writers_rws);
 	lock_mount_hash();
 	mnt->mnt.mnt_flags &= ~MNT_READONLY;
 	unlock_mount_hash();
+	percpu_up_write(&sb->mnt_writers_rws);
 	return 0;
 }
 
@@ -514,21 +478,22 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 	struct mount *mnt;
 	int err = 0;
 
-	/* Racy optimization.  Recheck the counter under MNT_WRITE_HOLD */
+	/* Racy optimization.  Recheck the counter under mnt_writers_rws. */
 	if (atomic_long_read(&sb->s_remove_count))
 		return -EBUSY;
 
+	percpu_down_write(&sb->mnt_writers_rws);
 	lock_mount_hash();
+
 	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
 		if (!(mnt->mnt.mnt_flags & MNT_READONLY)) {
-			mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
-			smp_mb();
 			if (mnt_get_writers(mnt) > 0) {
 				err = -EBUSY;
 				break;
 			}
 		}
 	}
+
 	if (!err && atomic_long_read(&sb->s_remove_count))
 		err = -EBUSY;
 
@@ -536,11 +501,9 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 		sb->s_readonly_remount = 1;
 		smp_wmb();
 	}
-	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
-		if (mnt->mnt.mnt_flags & MNT_WRITE_HOLD)
-			mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
-	}
+
 	unlock_mount_hash();
+	percpu_up_write(&sb->mnt_writers_rws);
 
 	return err;
 }
@@ -1036,7 +999,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->mnt.mnt_flags &= ~(MNT_MARKED|MNT_INTERNAL);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_sb = sb;
@@ -2440,7 +2403,8 @@ static bool can_change_locked_flags(struct mount *mnt, unsigned int mnt_flags)
 	return true;
 }
 
-static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
+static int change_mount_ro_state(struct super_block *sb,
+				 struct mount *mnt, unsigned int mnt_flags)
 {
 	bool readonly_request = (mnt_flags & MNT_READONLY);
 
@@ -2448,9 +2412,9 @@ static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
 		return 0;
 
 	if (readonly_request)
-		return mnt_make_readonly(mnt);
+		return mnt_make_readonly(sb, mnt);
 
-	return __mnt_unmake_readonly(mnt);
+	return __mnt_unmake_readonly(sb, mnt);
 }
 
 /*
@@ -2509,7 +2473,7 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 		return -EPERM;
 
 	down_write(&sb->s_umount);
-	ret = change_mount_ro_state(mnt, mnt_flags);
+	ret = change_mount_ro_state(sb, mnt, mnt_flags);
 	if (ret == 0)
 		set_mount_attributes(mnt, mnt_flags);
 	up_write(&sb->s_umount);
diff --git a/fs/super.c b/fs/super.c
index a288cd60d2ae..b6036e5fbe8d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -210,6 +210,8 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	INIT_LIST_HEAD(&s->s_mounts);
 	s->s_user_ns = get_user_ns(user_ns);
 	init_rwsem(&s->s_umount);
+	percpu_init_rwsem(&s->mnt_writers_rws);
+
 	lockdep_set_class(&s->s_umount, &type->s_umount_key);
 	/*
 	 * sget() can have s_umount recursion.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 45cc10cdf6dd..cc259b7c4ee8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1458,6 +1458,7 @@ struct super_block {
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
+	struct percpu_rw_semaphore mnt_writers_rws;
 	struct block_device	*s_bdev;
 	struct backing_dev_info *s_bdi;
 	struct mtd_info		*s_mtd;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index bf8cc4108b8f..8daf217108e8 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -32,7 +32,6 @@ struct fs_context;
 #define MNT_READONLY	0x40	/* does the user want this to be r/o? */
 
 #define MNT_SHRINKABLE	0x100
-#define MNT_WRITE_HOLD	0x200
 
 #define MNT_SHARED	0x1000	/* if the vfsmount is a shared mount */
 #define MNT_UNBINDABLE	0x2000	/* if the vfsmount is a unbindable mount */
@@ -49,7 +48,7 @@ struct fs_context;
 				 | MNT_READONLY)
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
 
-#define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
+#define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_INTERNAL | \
 			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED)
 
 #define MNT_INTERNAL	0x4000
-- 
2.27.0

