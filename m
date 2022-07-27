Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112455825DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 13:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiG0LtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiG0LtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:49:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4584AD76
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 04:49:13 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658922552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyjTnpv2RVelFnCEX6pHt5pzPjSU90B+hL5osGhj+Vc=;
        b=XMq05kgNEkR9LR1BErUzhQ+5t4VmDv6RiS0KbJAYA6IZGOGvnce7uKi39SHtge61693nzk
        40bO+P9FbsmpDPXmVnaN+bn7nXlCBreGoZyuMQ7CqsuhQ5utcvWmeO0kx93bCoqD/pjtQD
        7Ie//Lb1xZjTugbxahmJx0L2Bhi3ZdFBWXke60S8ok0N+gw7YfkL+ce9w3cT94TF/8XEsM
        wAcDGISmnK0mxp52XUmaKJpQtHga/i9BawBnQFcFV6dH/PhViKMqYL71noE8Bl5vXwB1a9
        AAKT4QBDzhGIoDAh7tP99KvSrpS0kNNzLSnZ8KupSx6heYKIL9yNKUSjpO3yFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658922552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyjTnpv2RVelFnCEX6pHt5pzPjSU90B+hL5osGhj+Vc=;
        b=g5WSONi6tQyKSKNDLWLnfX7XY3bAyfKYVWI3Zvc3BhAeIpu//av6TDk8GMZ5mjY+TyhbVU
        7VgAfVmrSbKNtGDA==
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/4 v2] fs/dcache: Move the wakeup from __d_lookup_done() to the caller.
Date:   Wed, 27 Jul 2022 13:49:03 +0200
Message-Id: <20220727114904.130761-4-bigeasy@linutronix.de>
In-Reply-To: <20220727114904.130761-1-bigeasy@linutronix.de>
References: <20220727114904.130761-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__d_lookup_done() wakes waiters on dentry->d_wait.  On PREEMPT_RT we are
not allowed to do that with preemption disabled, since the wakeup
acquired wait_queue_head::lock, which is a "sleeping" spinlock on RT.

Calling it under dentry->d_lock is not a problem, since that is also a
"sleeping" spinlock on the same configs.  Unfortunately, two of its
callers (__d_add() and __d_move()) are holding more than just ->d_lock
and that needs to be dealt with.

The key observation is that wakeup can be moved to any point before
dropping ->d_lock.

As a first step to solve this, move the wake up outside of the
hlist_bl_lock() held section.

This is safe because:

Waiters get inserted into ->d_wait only after they'd taken ->d_lock
and observed DCACHE_PAR_LOOKUP in flags.  As long as they are
woken up (and evicted from the queue) between the moment __d_lookup_done()
has removed DCACHE_PAR_LOOKUP and dropping ->d_lock, we are safe,
since the waitqueue ->d_wait points to won't get destroyed without
having __d_lookup_done(dentry) called (under ->d_lock).

->d_wait is set only by d_alloc_parallel() and only in case when
it returns a freshly allocated in-lookup dentry.  Whenever that happens,
we are guaranteed that __d_lookup_done() will be called for resulting
dentry (under ->d_lock) before the wq in question gets destroyed.

With two exceptions wq lives in call frame of the caller of
d_alloc_parallel() and we have an explicit d_lookup_done() on the
resulting in-lookup dentry before we leave that frame.

One of those exceptions is nfs_call_unlink(), where wq is embedded into
(dynamically allocated) struct nfs_unlinkdata.  It is destroyed in
nfs_async_unlink_release() after an explicit d_lookup_done() on the
dentry wq went into.

Remaining exception is d_add_ci(). There wq is what we'd found in
->d_wait of d_add_ci() argument. Callers of d_add_ci() are two
instances of ->d_lookup() and they must have been given an in-lookup
dentry.  Which means that they'd been called by __lookup_slow() or
lookup_open(), with wq in the call frame of one of those.

Result of d_alloc_parallel() in d_add_ci() is fed to
d_splice_alias(), which either returns non-NULL (and d_add_ci() does
d_lookup_done()) or feeds dentry to __d_add() that will do
__d_lookup_done() under ->d_lock.  That concludes the analysis.

Let __d_lookup_unhash():

  1) Lock the lookup hash and clear DCACHE_PAR_LOOKUP
  2) Unhash the dentry
  3) Retrieve and clear dentry::d_wait
  4) Unlock the hash and return the retrieved waitqueue head pointer
  5) Let the caller handle the wake up.
  6) Rename __d_lookup_done() to __d_lookup_unhash_wake() to enforce
     build failures for OOT code that used __d_lookup_done() and is not
     aware of the new return value.

This does not yet solve the PREEMPT_RT problem completely because
preemption is still disabled due to i_dir_seq being held for write. This
will be addressed in subsequent steps.

An alternative solution would be to switch the waitqueue to a simple
waitqueue, but aside of Linus not being a fan of them, moving the wake up
closer to the place where dentry::lock is unlocked reduces lock contention
time for the woken up waiter.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20220613140712.77932-3-bigeasy@linutronix.de
---
 fs/dcache.c            |   35 ++++++++++++++++++++++++++++-------
 include/linux/dcache.h |    9 +++------
 2 files changed, 31 insertions(+), 13 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2712,32 +2712,51 @@ struct dentry *d_alloc_parallel(struct d
 }
 EXPORT_SYMBOL(d_alloc_parallel);
=20
-void __d_lookup_done(struct dentry *dentry)
+/*
+ * - Unhash the dentry
+ * - Retrieve and clear the waitqueue head in dentry
+ * - Return the waitqueue head
+ */
+static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 {
-	struct hlist_bl_head *b =3D in_lookup_hash(dentry->d_parent,
-						 dentry->d_name.hash);
+	wait_queue_head_t *d_wait;
+	struct hlist_bl_head *b;
+
+	lockdep_assert_held(&dentry->d_lock);
+
+	b =3D in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
 	hlist_bl_lock(b);
 	dentry->d_flags &=3D ~DCACHE_PAR_LOOKUP;
 	__hlist_bl_del(&dentry->d_u.d_in_lookup_hash);
-	wake_up_all(dentry->d_wait);
+	d_wait =3D dentry->d_wait;
 	dentry->d_wait =3D NULL;
 	hlist_bl_unlock(b);
 	INIT_HLIST_NODE(&dentry->d_u.d_alias);
 	INIT_LIST_HEAD(&dentry->d_lru);
+	return d_wait;
+}
+
+void __d_lookup_unhash_wake(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	wake_up_all(__d_lookup_unhash(dentry));
+	spin_unlock(&dentry->d_lock);
 }
-EXPORT_SYMBOL(__d_lookup_done);
+EXPORT_SYMBOL(__d_lookup_unhash_wake);
=20
 /* inode->i_lock held if inode is non-NULL */
=20
 static inline void __d_add(struct dentry *dentry, struct inode *inode)
 {
+	wait_queue_head_t *d_wait;
 	struct inode *dir =3D NULL;
 	unsigned n;
 	spin_lock(&dentry->d_lock);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir =3D dentry->d_parent->d_inode;
 		n =3D start_dir_add(dir);
-		__d_lookup_done(dentry);
+		d_wait =3D __d_lookup_unhash(dentry);
+		wake_up_all(d_wait);
 	}
 	if (inode) {
 		unsigned add_flags =3D d_flags_for_inode(inode);
@@ -2896,6 +2915,7 @@ static void __d_move(struct dentry *dent
 		     bool exchange)
 {
 	struct dentry *old_parent, *p;
+	wait_queue_head_t *d_wait;
 	struct inode *dir =3D NULL;
 	unsigned n;
=20
@@ -2926,7 +2946,8 @@ static void __d_move(struct dentry *dent
 	if (unlikely(d_in_lookup(target))) {
 		dir =3D target->d_parent->d_inode;
 		n =3D start_dir_add(dir);
-		__d_lookup_done(target);
+		d_wait =3D __d_lookup_unhash(target);
+		wake_up_all(d_wait);
 	}
=20
 	write_seqcount_begin(&dentry->d_seq);
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -349,7 +349,7 @@ static inline void dont_mount(struct den
 	spin_unlock(&dentry->d_lock);
 }
=20
-extern void __d_lookup_done(struct dentry *);
+extern void __d_lookup_unhash_wake(struct dentry *dentry);
=20
 static inline int d_in_lookup(const struct dentry *dentry)
 {
@@ -358,11 +358,8 @@ static inline int d_in_lookup(const stru
=20
 static inline void d_lookup_done(struct dentry *dentry)
 {
-	if (unlikely(d_in_lookup(dentry))) {
-		spin_lock(&dentry->d_lock);
-		__d_lookup_done(dentry);
-		spin_unlock(&dentry->d_lock);
-	}
+	if (unlikely(d_in_lookup(dentry)))
+		__d_lookup_unhash_wake(dentry);
 }
=20
 extern void dput(struct dentry *);
