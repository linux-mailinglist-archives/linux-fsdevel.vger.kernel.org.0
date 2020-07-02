Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70721286A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGBPqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 11:46:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50964 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBPqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:46:51 -0400
Date:   Thu, 2 Jul 2020 17:46:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593704808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UraPfoW/nhw4twoV5dwe5FauZFFJ55AoO1CBfbzZ2IQ=;
        b=H93ZZHrD3aNmBwgz3rg9QjkpjwXCWqwHtvH4ELdvOyIbi1jkXmtaD0Xbt3SPL3k322i/Zp
        erCA7+d1cO+wplVV0vKLHvVxt6+tD3BHNT5IcNOc/14F/MncxZHOuWSjQfa3Y6aQriApA0
        WrGURn2T2SAOxqJlnrXtjNUKqgaFlUqZuGmrwNwexa8PT6JK1MCUTIOyFW1+wxcCC3KLls
        ecL+0NxRI8oiqj+e/5bzDaUWSXI3DvzQc7ETF+kteb2k48epZLbqJek2KLGzTUTReJ4pcD
        MjImBQMA+BxtawRkykifR6jFa+jGNAcweWGxGLENjLdpq8KM+Dh4f9KSDbKBVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593704808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UraPfoW/nhw4twoV5dwe5FauZFFJ55AoO1CBfbzZ2IQ=;
        b=3A9e/Z/wf8130z3mqhOavk/gYAfREQzo8uVeiwQwUysmfafGDaJnT8Lw1eavkK70JH5Vhy
        gQi0dE5wQWZq0TAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH v2] fs/namespace: use percpu_rw_semaphore for writer
 holding
Message-ID: <20200702154646.qkrzchuttrywvuud@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=46rom: John Ogness <john.ogness@linutronix.de>

The MNT_WRITE_HOLD flag is used to manually implement a rwsem. Remove
that flag and instead use a percpu_rw_semaphore, which effectively
provides the same functionality. This allows lockdep to be used for
the writer holding, allows CONFIG_PREEMPT to preempt held writers,
and simplifies the writer holding code.

Note that writer holding is now performed on a per super block basis
rather than a per mount basis.

Co-developed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Switch two percpu rwsem

TEST COMMAND
lat_mmap -P $pval -W 32 -N 50 64m file

On a 32 core Xeon.

OUTPUT FORMAT
pval: avg std

Preemptible Kernel
           BASE           RWS4
 1:   289.40  2.97   286.00  2.35
 2:   307.60  3.58   292.40  3.65
 4:   323.20  3.56   313.20  2.28
 8:   375.00  6.08   361.20  1.30
16:   412.40  1.34   413.00  2.83
32:   611.80  4.32   613.40  4.28
64:  1239.00  7.84  1251.00  9.30

Preemptible Kernel, no PTI
           BASE           RWS4
 1:   286.00  1.22   289.20  3.35
 2:   312.00  9.06   311.00  3.87
 4:   321.20  5.17   394.40  2.30
 8:   368.60  2.07   447.80  3.35
16:   411.40  2.41   476.40  1.14
32:   623.40  6.47   651.00  3.39
64:  1264.20  9.55  1292.60  2.51

Voluntary Kernel Preemption
           BASE           RWS4
 1:   285.80  1.48   283.40  5.94
 2:   303.40  3.78   303.60  3.21
 4:   315.20  7.29   309.80  3.49
 8:   361.40  2.30   361.00  7.00
16:   415.40  3.36   419.80  6.14
32:   606.60  5.13   612.80  5.40
64:  1211.40  7.27  1205.20  8.04

Voluntary Kernel Preemption, no PTI
           BASE           RWS4
 1:   281.60  2.51   293.80  3.03
 2:   295.00  3.81   321.00  5.96
 4:   312.20  2.77   372.40  8.73
 8:   359.20  0.45   424.40  1.82
16:   413.20  3.96   449.40  2.30
32:   623.20  5.36   635.80  1.64
64:  1212.00  6.63  1229.00  5.15

No Forced Preemption
           BASE           RWS4
 1:   273.80  0.45   275.40  0.55
 2:   291.60  7.20   285.60  1.82
 4:   310.60  4.22   302.20  1.79
 8:   362.40  3.05   350.20  1.30
16:   416.40  3.78   405.00  2.92
32:   626.20  2.28   611.80  1.30
64:  1215.80  3.83  1185.60 11.67

No Forced Preemption, no PTI
           BASE           RWS4
 1:   274.80  2.68   274.00  3.39
 2:   291.00  5.66   289.60  3.05
 4:   304.00  2.74   303.20  1.48
 8:   352.40  1.82   350.60  2.30
16:   408.40  0.89   406.20  2.49
32:   605.20  3.27   607.20  3.96
64:  1189.80  4.09  1194.40  1.82

 fs/mount.h            |  2 +
 fs/namespace.c        | 99 ++++++++++++++++---------------------------
 fs/super.c            |  2 +
 include/linux/fs.h    |  1 +
 include/linux/mount.h |  6 +--
 5 files changed, 44 insertions(+), 66 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index c7abb7b394d8e..67ef1f87b89fe 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -4,6 +4,7 @@
 #include <linux/poll.h>
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
+#include <linux/percpu-rwsem.h>
=20
 struct mnt_namespace {
 	atomic_t		count;
@@ -46,6 +47,7 @@ struct mount {
 		struct rcu_head mnt_rcu;
 		struct llist_node mnt_llist;
 	};
+	struct percpu_rw_semaphore mnt_writers_rws;
 #ifdef CONFIG_SMP
 	struct mnt_pcp __percpu *mnt_pcp;
 #else
diff --git a/fs/namespace.c b/fs/namespace.c
index f30ed401cc6d7..5275f73ce7443 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -311,30 +311,17 @@ static int mnt_is_readonly(struct vfsmount *mnt)
 int __mnt_want_write(struct vfsmount *m)
 {
 	struct mount *mnt =3D real_mount(m);
+	struct super_block *sb =3D m->mnt_sb;
 	int ret =3D 0;
=20
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
-		ret =3D -EROFS;
-	}
-	preempt_enable();
+	percpu_down_read(&sb->mnt_writers_rws);
=20
+	if (mnt_is_readonly(m))
+		ret =3D -EROFS;
+	else
+		mnt_inc_writers(mnt);
+
+	percpu_up_read(&sb->mnt_writers_rws);
 	return ret;
 }
=20
@@ -373,12 +360,14 @@ EXPORT_SYMBOL_GPL(mnt_want_write);
  */
 int mnt_clone_write(struct vfsmount *mnt)
 {
+	struct super_block *sb =3D mnt->mnt_sb;
+
 	/* superblock may be r/o */
 	if (__mnt_is_readonly(mnt))
 		return -EROFS;
-	preempt_disable();
+	percpu_down_read(&sb->mnt_writers_rws);
 	mnt_inc_writers(real_mount(mnt));
-	preempt_enable();
+	percpu_up_read(&sb->mnt_writers_rws);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mnt_clone_write);
@@ -427,9 +416,11 @@ EXPORT_SYMBOL_GPL(mnt_want_write_file);
  */
 void __mnt_drop_write(struct vfsmount *mnt)
 {
-	preempt_disable();
+	struct super_block *sb =3D mnt->mnt_sb;
+
+	percpu_down_read(&sb->mnt_writers_rws);
 	mnt_dec_writers(real_mount(mnt));
-	preempt_enable();
+	percpu_up_read(&sb->mnt_writers_rws);
 }
=20
 /**
@@ -459,53 +450,38 @@ void mnt_drop_write_file(struct file *file)
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
=20
-static int mnt_make_readonly(struct mount *mnt)
+static int mnt_make_readonly(struct super_block *sb, struct mount *mnt)
 {
 	int ret =3D 0;
=20
+	percpu_down_write(&sb->mnt_writers_rws);
 	lock_mount_hash();
-	mnt->mnt.mnt_flags |=3D MNT_WRITE_HOLD;
-	/*
-	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
-	 * should be visible before we do.
-	 */
-	smp_mb();
=20
 	/*
 	 * With writers on hold, if this value is zero, then there are
-	 * definitely no active writers (although held writers may subsequently
-	 * increment the count, they'll have to wait, and decrement it after
-	 * seeing MNT_READONLY).
+	 * definitely no active writers.
 	 *
 	 * It is OK to have counter incremented on one CPU and decremented on
-	 * another: the sum will add up correctly. The danger would be when we
-	 * sum up each counter, if we read a counter before it is incremented,
-	 * but then read another CPU's count which it has been subsequently
-	 * decremented from -- we would see more decrements than we should.
-	 * MNT_WRITE_HOLD protects against this scenario, because
-	 * mnt_want_write first increments count, then smp_mb, then spins on
-	 * MNT_WRITE_HOLD, so it can't be decremented by another CPU while
-	 * we're counting up here.
+	 * another: the sum will add up correctly. The rwsem ensures that the
+	 * counters are not modified once the writer lock is acquired.
 	 */
 	if (mnt_get_writers(mnt) > 0)
 		ret =3D -EBUSY;
 	else
 		mnt->mnt.mnt_flags |=3D MNT_READONLY;
-	/*
-	 * MNT_READONLY must become visible before ~MNT_WRITE_HOLD, so writers
-	 * that become unheld will see MNT_READONLY.
-	 */
-	smp_wmb();
-	mnt->mnt.mnt_flags &=3D ~MNT_WRITE_HOLD;
+
 	unlock_mount_hash();
+	percpu_up_write(&sb->mnt_writers_rws);
 	return ret;
 }
=20
-static int __mnt_unmake_readonly(struct mount *mnt)
+static int __mnt_unmake_readonly(struct super_block *sb, struct mount *mnt)
 {
+	percpu_down_write(&sb->mnt_writers_rws);
 	lock_mount_hash();
 	mnt->mnt.mnt_flags &=3D ~MNT_READONLY;
 	unlock_mount_hash();
+	percpu_up_write(&sb->mnt_writers_rws);
 	return 0;
 }
=20
@@ -514,15 +490,15 @@ int sb_prepare_remount_readonly(struct super_block *s=
b)
 	struct mount *mnt;
 	int err =3D 0;
=20
-	/* Racy optimization.  Recheck the counter under MNT_WRITE_HOLD */
+	/* Racy optimization.  Recheck the counter under mnt_writers_rws. */
 	if (atomic_long_read(&sb->s_remove_count))
 		return -EBUSY;
=20
+	percpu_down_write(&sb->mnt_writers_rws);
 	lock_mount_hash();
+
 	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
 		if (!(mnt->mnt.mnt_flags & MNT_READONLY)) {
-			mnt->mnt.mnt_flags |=3D MNT_WRITE_HOLD;
-			smp_mb();
 			if (mnt_get_writers(mnt) > 0) {
 				err =3D -EBUSY;
 				break;
@@ -536,11 +512,9 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 		sb->s_readonly_remount =3D 1;
 		smp_wmb();
 	}
-	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
-		if (mnt->mnt.mnt_flags & MNT_WRITE_HOLD)
-			mnt->mnt.mnt_flags &=3D ~MNT_WRITE_HOLD;
-	}
+
 	unlock_mount_hash();
+	percpu_up_write(&sb->mnt_writers_rws);
=20
 	return err;
 }
@@ -1052,7 +1026,7 @@ static struct mount *clone_mnt(struct mount *old, str=
uct dentry *root,
 	}
=20
 	mnt->mnt.mnt_flags =3D old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &=3D ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->mnt.mnt_flags &=3D ~(MNT_MARKED|MNT_INTERNAL);
=20
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_sb =3D sb;
@@ -2498,7 +2472,8 @@ static bool can_change_locked_flags(struct mount *mnt=
, unsigned int mnt_flags)
 	return true;
 }
=20
-static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
+static int change_mount_ro_state(struct super_block *sb,
+				 struct mount *mnt, unsigned int mnt_flags)
 {
 	bool readonly_request =3D (mnt_flags & MNT_READONLY);
=20
@@ -2506,9 +2481,9 @@ static int change_mount_ro_state(struct mount *mnt, u=
nsigned int mnt_flags)
 		return 0;
=20
 	if (readonly_request)
-		return mnt_make_readonly(mnt);
+		return mnt_make_readonly(sb, mnt);
=20
-	return __mnt_unmake_readonly(mnt);
+	return __mnt_unmake_readonly(sb, mnt);
 }
=20
 /*
@@ -2567,7 +2542,7 @@ static int do_reconfigure_mnt(struct path *path, unsi=
gned int mnt_flags)
 		return -EPERM;
=20
 	down_write(&sb->s_umount);
-	ret =3D change_mount_ro_state(mnt, mnt_flags);
+	ret =3D change_mount_ro_state(sb, mnt, mnt_flags);
 	if (ret =3D=3D 0)
 		set_mount_attributes(mnt, mnt_flags);
 	up_write(&sb->s_umount);
diff --git a/fs/super.c b/fs/super.c
index 904459b351199..5c70bc135ba27 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -210,6 +210,8 @@ static struct super_block *alloc_super(struct file_syst=
em_type *type, int flags,
 	INIT_LIST_HEAD(&s->s_mounts);
 	s->s_user_ns =3D get_user_ns(user_ns);
 	init_rwsem(&s->s_umount);
+	percpu_init_rwsem(&s->mnt_writers_rws);
+
 	lockdep_set_class(&s->s_umount, &type->s_umount_key);
 	/*
 	 * sget() can have s_umount recursion.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea74..2406e823a37df 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1464,6 +1464,7 @@ struct super_block {
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
+	struct percpu_rw_semaphore mnt_writers_rws;
 	struct block_device	*s_bdev;
 	struct backing_dev_info *s_bdi;
 	struct mtd_info		*s_mtd;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index de657bd211fa6..dce9bda5eeaa1 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -32,7 +32,6 @@ struct fs_context;
 #define MNT_READONLY	0x40	/* does the user want this to be r/o? */
=20
 #define MNT_SHRINKABLE	0x100
-#define MNT_WRITE_HOLD	0x200
=20
 #define MNT_SHARED	0x1000	/* if the vfsmount is a shared mount */
 #define MNT_UNBINDABLE	0x2000	/* if the vfsmount is a unbindable mount */
@@ -49,9 +48,8 @@ struct fs_context;
 				 | MNT_READONLY)
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
=20
-#define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
-			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | \
-			    MNT_CURSOR)
+#define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_INTERNAL | MNT_CURSOR | \
+			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED)
=20
 #define MNT_INTERNAL	0x4000
=20
--=20
2.27.0

