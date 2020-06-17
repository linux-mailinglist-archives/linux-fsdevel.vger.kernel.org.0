Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876EE1FCB08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 12:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFQKlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 06:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgFQKlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:41:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD6C061573;
        Wed, 17 Jun 2020 03:41:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jlVVK-00073K-BD; Wed, 17 Jun 2020 12:41:14 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] fs/namespace.c: use spinlock instead of busy loop
Date:   Wed, 17 Jun 2020 12:46:58 +0206
Message-Id: <20200617104058.14902-2-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200617104058.14902-1-john.ogness@linutronix.de>
References: <20200617104058.14902-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The MNT_WRITE_HOLD flag is used to manually implement a per-cpu
optimized rwsem using busy waiting. This implementation is a problem
on PREEMPT_RT because write_seqlock() on @mount_lock (i.e. taking a
spinlock) does not disable preemption. This allows a writer to
preempt a task that has set MNT_WRITE_HOLD and thus that writer will
live lock in __mnt_want_write() due to busy looping with preemption
disabled.

Reimplement the same semantics using per-cpu spinlocks. This
provides lockdep coverage and makes the code RT ready.

Since this reverts some of the optimization work of
  commit d3ef3d7351cc ("fs: mnt_want_write speedup")
lmbench lat_mmap tests were performed to verify that there is no
obvious performance degradation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Here is the detailed test information...

 TEST COMMAND
 lat_mmap -P $pval -W 32 -N 50 64m file

 OUTPUT FORMAT
 pval: avg std

 RESULTS (32 CPUs)
 No Forced Preemption
           BEFORE         AFTER
  1:   275.60  1.82   274.40  0.55
  2:   296.20  3.83   286.80  1.92
  4:   310.20  4.44   304.40  2.51
  8:   359.20  2.28   357.80  2.95
 16:   417.40  2.51   412.20  3.90
 32:   625.60  2.07   622.00  3.08
 64:  1202.60 15.87  1202.20  6.14

 No Forced Preemption, no PTI
           BEFORE         AFTER
  1:   278.00  2.12   274.40  1.52
  2:   301.00  3.67   289.80  6.06
  4:   333.40  7.73   303.80  2.39
  8:   389.80  3.56   351.80  3.42
 16:   425.00  3.46   408.20  4.87
 32:   606.00  1.22   605.60  1.82
 64:  1193.60  7.09  1184.80  4.27

 Voluntary Kernel Preemption
           BEFORE         AFTER
  1:   277.80  1.30   278.20  1.10
  2:   291.20  0.84   286.60  2.30
  4:   310.00  1.87   304.80  1.30
  8:   360.00  2.55   354.60  1.14
 16:   414.00  1.58   414.00  2.35
 32:   619.60  5.50   607.00  3.74
 64:  1224.00  8.40  1219.60  6.19

 Voluntary Kernel Preemption, no PTI
           BEFORE         AFTER
  1:   277.80  4.66   276.40  0.89
  2:   291.40  6.54   286.40  3.58
  4:   310.00  1.22   315.40  1.14
  8:   357.20  0.84   361.40  2.61
 16:   405.60  2.88   407.60  2.51
 32:   615.40  2.30   611.60  5.55
 64:  1219.80  9.91  1207.40 10.88

 Preemptible Kernel
           BEFORE         AFTER
  1:   283.80  0.45   286.80  0.84
  2:   293.40  2.51   294.40  3.51
  4:   318.20  1.30   315.60  1.95
  8:   367.00  0.71   363.00  1.22
 16:   416.20  1.64   413.20  4.87
 32:   628.80  2.28   617.40  2.97
 64:  1277.20  9.88  1254.20  4.87

 Preemptible Kernel, no PTI
           BEFORE         AFTER
  1:   283.00  1.73   288.40  1.67
  2:   305.80  2.05   297.00  3.24
  4:   321.40  4.34   318.60  2.79
  8:   370.20  2.39   366.40  2.70
 16:   413.20  3.11   412.40  2.41
 32:   616.40  2.61   620.20  2.05
 64:  1266.00  6.48  1255.80  3.90

 fs/mount.h     |   7 +++
 fs/namespace.c | 118 +++++++++++++++++++++++++++++++++----------------
 2 files changed, 86 insertions(+), 39 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index c7abb7b394d8..627e635cd7d1 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -28,6 +28,12 @@ struct mnt_namespace {
 struct mnt_pcp {
 	int mnt_count;
 	int mnt_writers;
+	/*
+	 * If holding multiple instances of this lock, they
+	 * must be ordered by cpu number.
+	 */
+	spinlock_t mnt_writers_lock;
+	struct lock_class_key mnt_writers_lock_key;
 };
 
 struct mountpoint {
@@ -51,6 +57,7 @@ struct mount {
 #else
 	int mnt_count;
 	int mnt_writers;
+	spinlock_t mnt_writers_lock;
 #endif
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
diff --git a/fs/namespace.c b/fs/namespace.c
index f30ed401cc6d..e292c91f966d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -177,6 +177,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 	struct mount *mnt = kmem_cache_zalloc(mnt_cache, GFP_KERNEL);
 	if (mnt) {
 		int err;
+		int cpu;
 
 		err = mnt_alloc_id(mnt);
 		if (err)
@@ -194,9 +195,21 @@ static struct mount *alloc_vfsmnt(const char *name)
 			goto out_free_devname;
 
 		this_cpu_add(mnt->mnt_pcp->mnt_count, 1);
+
+		for_each_possible_cpu(cpu) {
+			struct mnt_pcp *writer =
+					per_cpu_ptr(mnt->mnt_pcp, cpu);
+
+			lockdep_register_key(&writer->mnt_writers_lock_key);
+			spin_lock_init(&writer->mnt_writers_lock);
+			lockdep_set_class(&writer->mnt_writers_lock,
+					  &writer->mnt_writers_lock_key);
+		}
 #else
+		(void)cpu;
 		mnt->mnt_count = 1;
 		mnt->mnt_writers = 0;
+		spin_lock_init(&mnt->mnt_writers_lock);
 #endif
 
 		INIT_HLIST_NODE(&mnt->mnt_hash);
@@ -311,29 +324,26 @@ static int mnt_is_readonly(struct vfsmount *mnt)
 int __mnt_want_write(struct vfsmount *m)
 {
 	struct mount *mnt = real_mount(m);
+	spinlock_t *lock;
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
+#ifdef CONFIG_SMP
+	migrate_disable();
+	lock = &this_cpu_ptr(mnt->mnt_pcp)->mnt_writers_lock;
+#else
+	lock = &mnt->mnt_writers_lock;
+#endif
+
+	spin_lock(lock);
+	if (mnt_is_readonly(m))
 		ret = -EROFS;
-	}
-	preempt_enable();
+	else
+		mnt_inc_writers(mnt);
+	spin_unlock(lock);
+
+#ifdef CONFIG_SMP
+	migrate_enable();
+#endif
 
 	return ret;
 }
@@ -459,17 +469,39 @@ void mnt_drop_write_file(struct file *file)
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
 
+static void mnt_lock_writers(struct mount *mnt)
+{
+#ifdef CONFIG_SMP
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		spin_lock(&per_cpu_ptr(mnt->mnt_pcp,
+				       cpu)->mnt_writers_lock);
+	}
+#else
+	spin_lock(&mnt->mnt_writers_lock);
+#endif
+}
+
+static void mnt_unlock_writers(struct mount *mnt)
+{
+#ifdef CONFIG_SMP
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		spin_unlock(&per_cpu_ptr(mnt->mnt_pcp,
+					 cpu)->mnt_writers_lock);
+	}
+#else
+	spin_unlock(&mnt->mnt_writers_lock);
+#endif
+}
+
 static int mnt_make_readonly(struct mount *mnt)
 {
 	int ret = 0;
 
 	lock_mount_hash();
-	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
-	/*
-	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
-	 * should be visible before we do.
-	 */
-	smp_mb();
 
 	/*
 	 * With writers on hold, if this value is zero, then there are
@@ -482,21 +514,17 @@ static int mnt_make_readonly(struct mount *mnt)
 	 * sum up each counter, if we read a counter before it is incremented,
 	 * but then read another CPU's count which it has been subsequently
 	 * decremented from -- we would see more decrements than we should.
-	 * MNT_WRITE_HOLD protects against this scenario, because
-	 * mnt_want_write first increments count, then smp_mb, then spins on
-	 * MNT_WRITE_HOLD, so it can't be decremented by another CPU while
-	 * we're counting up here.
+	 * mnt_writers_lock protects against this scenario, because all CPUs
+	 * are prevented from incrementing the counter until the summation of
+	 * all CPU counters is complete.
 	 */
+	mnt_lock_writers(mnt);
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
+	mnt_unlock_writers(mnt);
+
 	unlock_mount_hash();
 	return ret;
 }
@@ -514,15 +542,15 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 	struct mount *mnt;
 	int err = 0;
 
-	/* Racy optimization.  Recheck the counter under MNT_WRITE_HOLD */
+	/* Racy optimization.  Recheck the counter under mnt_writers_lock. */
 	if (atomic_long_read(&sb->s_remove_count))
 		return -EBUSY;
 
 	lock_mount_hash();
 	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
 		if (!(mnt->mnt.mnt_flags & MNT_READONLY)) {
+			mnt_lock_writers(mnt);
 			mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
-			smp_mb();
 			if (mnt_get_writers(mnt) > 0) {
 				err = -EBUSY;
 				break;
@@ -537,8 +565,10 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 		smp_wmb();
 	}
 	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
-		if (mnt->mnt.mnt_flags & MNT_WRITE_HOLD)
+		if (mnt->mnt.mnt_flags & MNT_WRITE_HOLD) {
 			mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+			mnt_unlock_writers(mnt);
+		}
 	}
 	unlock_mount_hash();
 
@@ -1099,6 +1129,7 @@ static void cleanup_mnt(struct mount *mnt)
 {
 	struct hlist_node *p;
 	struct mount *m;
+	int cpu;
 	/*
 	 * The warning here probably indicates that somebody messed
 	 * up a mnt_want/drop_write() pair.  If this happens, the
@@ -1117,6 +1148,15 @@ static void cleanup_mnt(struct mount *mnt)
 	dput(mnt->mnt.mnt_root);
 	deactivate_super(mnt->mnt.mnt_sb);
 	mnt_free_id(mnt);
+#ifdef CONFIG_SMP
+	for_each_possible_cpu(cpu) {
+		struct mnt_pcp *writer = per_cpu_ptr(mnt->mnt_pcp, cpu);
+
+		lockdep_unregister_key(&writer->mnt_writers_lock_key);
+	}
+#else
+	(void)cpu;
+#endif
 	call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt);
 }
 
-- 
2.20.1

