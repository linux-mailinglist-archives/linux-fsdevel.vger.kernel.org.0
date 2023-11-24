Return-Path: <linux-fsdevel+bounces-3617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED17F6C03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64681C20C78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34983EAC8;
	Fri, 24 Nov 2023 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o12XIxuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EAC10E0;
	Thu, 23 Nov 2023 22:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Qzlibb9AoLAQaGbIe1+8zosXOWVWkmGZQ83DbyqMmDA=; b=o12XIxuU1wolc8e5yxz5C6C3tE
	whL+UzcawRll5hxK/aQHw1674eMGsGvcYwoDisjxk4DR0hxES3S8Q86wF5MBDcQ4rurP+bWAbdt0u
	WDhSNEig2B5qXq6d74e8y29/6Qxj/JjqPXAIAWmY7B/etDZ7I/ZT676lXCA81gRh3N9wD/3oGtrBg
	HQ9tCEKE2AwAkFeSTM0DKLGRcaPD5ZFlvFqdywqmEguH+a+5LTSi+P/bTZMrwPunSClQMnMz7N3KM
	rGKA5YRW5tlMOCX91rgb2K5tCtiLT2SSEzylOEkxMdEl99wLAKZYRc7BWOdmZSCE7CXI+lCjDBIkO
	uU2fjcmw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PIg-002PvL-2N;
	Fri, 24 Nov 2023 06:04:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Date: Fri, 24 Nov 2023 06:04:21 +0000
Message-Id: <20231124060422.576198-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently we enter __dentry_kill() with parent (along with the victim
dentry and victim's inode) held locked.  Then we
	mark dentry refcount as dead
	call ->d_prune()
	remove dentry from hash
	remove it from the parent's list of children
	unlock the parent, don't need it from that point on
	detach dentry from inode, unlock dentry and drop the inode
(via ->d_iput())
	call ->d_release()
	regain the lock on dentry
	check if it's on a shrink list (in which case freeing its empty husk
has to be left to shrink_dentry_list()) or not (in which case we can free it
ourselves).  In the former case, mark it as an empty husk, so that
shrink_dentry_list() would know it can free the sucker.
	drop the lock on dentry
... and usually the caller proceeds to drop a reference on the parent,
possibly retaking the lock on it.

That is painful for a bunch of reasons, starting with the need to take locks
out of order, but not limited to that - the parent of positive dentry can
change if we drop its ->d_lock, so getting these locks has to be done with
care.  Moreover, as soon as dentry is out of the parent's list of children,
shrink_dcache_for_umount() won't see it anymore, making it appear as if
the parent is inexplicably busy.  We do work around that by having
shrink_dentry_list() decrement the parent's refcount first and put it on
shrink list to be evicted once we are done with __dentry_kill() of child,
but that may in some cases lead to ->d_iput() on child called after the
parent got killed.  That doesn't happen in cases where in-tree ->d_iput()
instances might want to look at the parent, but that's brittle as hell.

Solution: do removal from the parent's list of children in the very
end of __dentry_kill().  As the result, the callers do not need to
lock the parent and by the time we really need the parent locked,
dentry is negative and is guaranteed not to be moved around.

It does mean that ->d_prune() will be called with parent not locked.
It also means that we might see dentries in process of being torn
down while going through the parent's list of children; those dentries
will be unhashed, negative and with refcount marked dead.  In practice,
that's enough for in-tree code that looks through the list of children
to do the right thing as-is.  Out-of-tree code might need to be adjusted.

Calling conventions: __dentry_kill(dentry) is called with dentry->d_lock
held, along with ->i_lock of its inode (if any).  It either returns
the parent (locked, with refcount decremented to 0) or NULL (if there'd
been no parent or if refcount decrement for parent hadn't reached 0).

lock_for_kill() is adjusted for new requirements - it doesn't touch
the parent's ->d_lock at all.

Callers adjusted.  Note that for dput() we don't need to bother with
fast_dput() for the parent - we just need to check retain_dentry()
for it, since its ->d_lock is still held since the moment when
__dentry_kill() had taken it to remove the victim from the list of
children.

The kludge with early decrement of parent's refcount in
shrink_dentry_list() is no longer needed - shrink_dcache_for_umount()
sees the half-killed dentries in the list of children for as long
as they are pinning the parent.  They are easily recognized and
accounted for by select_collect(), so we know we are not done yet.

As the result, we always have the expected ordering for ->d_iput()/->d_release()
vs. __dentry_kill() of the parent, no exceptions.  Moreover, the current
rules for shrink lists (one must make sure that shrink_dcache_for_umount()
won't happen while any dentries from the superblock in question are on
any shrink lists) are gone - shrink_dcache_for_umount() will do the
right thing in all cases, taking such dentries out.  Their empty
husks (memory occupied by struct dentry itself + its external name,
if any) will remain on the shrink lists, but they are no obstacles
to filesystem shutdown.  And such husks will get freed as soon as
shrink_dentry_list() of the list they are on gets to them.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst |  17 ++++
 fs/dcache.c                           | 129 ++++++++++----------------
 2 files changed, 65 insertions(+), 81 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 3714efcb6f65..c15e4dffa8af 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1078,3 +1078,20 @@ by compiler.
 	->d_delete() instances are now called for dentries with ->d_lock held
 and refcount equal to 0.  They are not permitted to drop/regain ->d_lock.
 None of in-tree instances did anything of that sort.  Make sure yours do not...
+
+--
+
+**mandatory**
+
+	->d_prune() instances are now called without ->d_lock held on the parent.
+->d_lock on dentry itself is still held; if you need per-parent exclusions (none
+of the in-tree instances did), use your own spinlock.
+
+	->d_iput() and ->d_release() are called with victim dentry still in the
+list of parent's children.  It is still unhashed, marked killed, etc., just not
+removed from parent's ->d_children yet.
+
+	Anyone iterating through the list of children needs to be aware of the
+half-killed dentries that might be seen there; taking ->d_lock on those will
+see them negative, unhashed and with negative refcount, which means that most
+of the in-kernel users would've done the right thing anyway without any adjustment.
diff --git a/fs/dcache.c b/fs/dcache.c
index a3cc612a80d5..c795154ffa3a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -575,12 +575,10 @@ static inline void dentry_unlist(struct dentry *dentry)
 	}
 }
 
-static void __dentry_kill(struct dentry *dentry)
+static struct dentry *__dentry_kill(struct dentry *dentry)
 {
 	struct dentry *parent = NULL;
 	bool can_free = true;
-	if (!IS_ROOT(dentry))
-		parent = dentry->d_parent;
 
 	/*
 	 * The dentry is now unrecoverably dead to the world.
@@ -600,9 +598,6 @@ static void __dentry_kill(struct dentry *dentry)
 	}
 	/* if it was on the hash then remove it */
 	__d_drop(dentry);
-	dentry_unlist(dentry);
-	if (parent)
-		spin_unlock(&parent->d_lock);
 	if (dentry->d_inode)
 		dentry_unlink_inode(dentry);
 	else
@@ -611,7 +606,14 @@ static void __dentry_kill(struct dentry *dentry)
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
 
-	spin_lock(&dentry->d_lock);
+	cond_resched();
+	/* now that it's negative, ->d_parent is stable */
+	if (!IS_ROOT(dentry)) {
+		parent = dentry->d_parent;
+		spin_lock(&parent->d_lock);
+	}
+	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+	dentry_unlist(dentry);
 	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
 		dentry->d_flags |= DCACHE_MAY_FREE;
 		can_free = false;
@@ -619,31 +621,10 @@ static void __dentry_kill(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
-	cond_resched();
-}
-
-static struct dentry *__lock_parent(struct dentry *dentry)
-{
-	struct dentry *parent;
-again:
-	parent = READ_ONCE(dentry->d_parent);
-	spin_lock(&parent->d_lock);
-	/*
-	 * We can't blindly lock dentry until we are sure
-	 * that we won't violate the locking order.
-	 * Any changes of dentry->d_parent must have
-	 * been done with parent->d_lock held, so
-	 * spin_lock() above is enough of a barrier
-	 * for checking if it's still our child.
-	 */
-	if (unlikely(parent != dentry->d_parent)) {
+	if (parent && --parent->d_lockref.count) {
 		spin_unlock(&parent->d_lock);
-		goto again;
+		return NULL;
 	}
-	if (parent != dentry)
-		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	else
-		parent = NULL;
 	return parent;
 }
 
@@ -655,48 +636,32 @@ static struct dentry *__lock_parent(struct dentry *dentry)
  * d_delete(), etc.
  *
  * Return false if dentry is busy.  Otherwise, return true and have
- * that dentry's inode and parent both locked.
+ * that dentry's inode locked.
  */
 
 static bool lock_for_kill(struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	struct dentry *parent = dentry->d_parent;
 
 	if (unlikely(dentry->d_lockref.count))
 		return false;
 
-	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
-		goto slow;
-	if (dentry == parent)
-		return true;
-	if (likely(spin_trylock(&parent->d_lock)))
+	if (!inode || likely(spin_trylock(&inode->i_lock)))
 		return true;
 
-	if (inode)
-		spin_unlock(&inode->i_lock);
-slow:
-	spin_unlock(&dentry->d_lock);
-
-	for (;;) {
-		if (inode)
-			spin_lock(&inode->i_lock);
-		parent = __lock_parent(dentry);
+	do {
+		spin_unlock(&dentry->d_lock);
+		spin_lock(&inode->i_lock);
+		spin_lock(&dentry->d_lock);
 		if (likely(inode == dentry->d_inode))
 			break;
-		if (inode)
-			spin_unlock(&inode->i_lock);
+		spin_unlock(&inode->i_lock);
 		inode = dentry->d_inode;
-		spin_unlock(&dentry->d_lock);
-		if (parent)
-			spin_unlock(&parent->d_lock);
-	}
+	} while (inode);
 	if (likely(!dentry->d_lockref.count))
 		return true;
 	if (inode)
 		spin_unlock(&inode->i_lock);
-	if (parent)
-		spin_unlock(&parent->d_lock);
 	return false;
 }
 
@@ -869,29 +834,27 @@ static inline bool fast_dput(struct dentry *dentry)
  */
 void dput(struct dentry *dentry)
 {
-	while (dentry) {
-		might_sleep();
-
-		rcu_read_lock();
-		if (likely(fast_dput(dentry))) {
-			rcu_read_unlock();
+	if (!dentry)
+		return;
+	might_sleep();
+	rcu_read_lock();
+	if (likely(fast_dput(dentry))) {
+		rcu_read_unlock();
+		return;
+	}
+	while (lock_for_kill(dentry)) {
+		rcu_read_unlock();
+		dentry = __dentry_kill(dentry);
+		if (!dentry)
 			return;
-		}
-
-		/* Slow case: now with the dentry lock held */
-		if (likely(lock_for_kill(dentry))) {
-			struct dentry *parent = dentry->d_parent;
-			rcu_read_unlock();
-			__dentry_kill(dentry);
-			if (dentry == parent)
-				return;
-			dentry = parent;
-		} else {
-			rcu_read_unlock();
+		if (retain_dentry(dentry)) {
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
+	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(dput);
 
@@ -1091,12 +1054,16 @@ void d_prune_aliases(struct inode *inode)
 }
 EXPORT_SYMBOL(d_prune_aliases);
 
-static inline void shrink_kill(struct dentry *victim, struct list_head *list)
+static inline void shrink_kill(struct dentry *victim)
 {
-	struct dentry *parent = victim->d_parent;
-	if (parent != victim && !--parent->d_lockref.count)
-		to_shrink_list(parent, list);
-	__dentry_kill(victim);
+	do {
+		rcu_read_unlock();
+		victim = __dentry_kill(victim);
+		rcu_read_lock();
+	} while (victim && lock_for_kill(victim));
+	rcu_read_unlock();
+	if (victim)
+		spin_unlock(&victim->d_lock);
 }
 
 void shrink_dentry_list(struct list_head *list)
@@ -1117,9 +1084,8 @@ void shrink_dentry_list(struct list_head *list)
 				dentry_free(dentry);
 			continue;
 		}
-		rcu_read_unlock();
 		d_shrink_del(dentry);
-		shrink_kill(dentry, list);
+		shrink_kill(dentry);
 	}
 }
 
@@ -1478,6 +1444,8 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 	} else if (!dentry->d_lockref.count) {
 		to_shrink_list(dentry, &data->dispose);
 		data->found++;
+	} else if (dentry->d_lockref.count < 0) {
+		data->found++;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
@@ -1547,8 +1515,7 @@ void shrink_dcache_parent(struct dentry *parent)
 				spin_unlock(&data.victim->d_lock);
 				rcu_read_unlock();
 			} else {
-				rcu_read_unlock();
-				shrink_kill(data.victim, &data.dispose);
+				shrink_kill(data.victim);
 			}
 		}
 		if (!list_empty(&data.dispose))
-- 
2.39.2


