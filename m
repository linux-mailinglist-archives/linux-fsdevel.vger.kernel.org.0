Return-Path: <linux-fsdevel+bounces-1618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2BA7DC66E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 07:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389731C20BDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CD41119F;
	Tue, 31 Oct 2023 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Weu+Sje7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2E107BF
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 06:18:54 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7FF138
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 23:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bl4dah7BQs/6YnfkabFDEWzWZVjNCLuF6CMXCZzSZsI=; b=Weu+Sje7XGwF2INx7HjfVq8+Yh
	OcAY1DcSjm1C3VSX+axwVy3PndGhEhU0/OKfaA1B0y+STfHaO01mNWAZTsK5TX1AXD5S9uQ/nC/8l
	UOpBM7mx8Oqf8gPXRD+/S4StkCCtgY5aaDh/hII1EdeEsK3WXE87P/YUtLEDBtucGr8FqoCYG24kX
	fuerAOTms32Ksy0vrqjPJT2yJzBv60lXUEA/P6i8UHlhXlyXUXTrQVjdPAePUrrfmHroQfy7OlErL
	Ln+3czKopwYPAc9dZly2g70d+lI1bhPtw8WhWDTKBZqUTtdB/nA/rB+74+tyTS3kLkdS10VgPlcMu
	ZxznQGTg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qxhzH-008L0D-05;
	Tue, 31 Oct 2023 06:12:27 +0000
Date: Tue, 31 Oct 2023 06:12:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231031061226.GC1957730@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <20231031001848.GX800259@ZenIV>
 <20231031015351.GA1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031015351.GA1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 31, 2023 at 01:53:51AM +0000, Al Viro wrote:

> Carving that series up will be interesting, though...

I think I have a sane carve-up; will post if it survives testing.

Cumulative diff follows:

diff --git a/fs/dcache.c b/fs/dcache.c
index 9f471fdb768b..213026d5b033 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -625,8 +625,6 @@ static void __dentry_kill(struct dentry *dentry)
 static struct dentry *__lock_parent(struct dentry *dentry)
 {
 	struct dentry *parent;
-	rcu_read_lock();
-	spin_unlock(&dentry->d_lock);
 again:
 	parent = READ_ONCE(dentry->d_parent);
 	spin_lock(&parent->d_lock);
@@ -642,7 +640,6 @@ static struct dentry *__lock_parent(struct dentry *dentry)
 		spin_unlock(&parent->d_lock);
 		goto again;
 	}
-	rcu_read_unlock();
 	if (parent != dentry)
 		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
 	else
@@ -657,7 +654,64 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 		return NULL;
 	if (likely(spin_trylock(&parent->d_lock)))
 		return parent;
-	return __lock_parent(dentry);
+	rcu_read_lock();
+	spin_unlock(&dentry->d_lock);
+	parent = __lock_parent(dentry);
+	rcu_read_unlock();
+	return parent;
+}
+
+/*
+ * Lock a dentry for feeding it to __dentry_kill().
+ * Called under rcu_read_lock() and dentry->d_lock; the former
+ * guarantees that nothing we access will be freed under us.
+ * Note that dentry is *not* protected from concurrent dentry_kill(),
+ * d_delete(), etc.
+ *
+ * Return false if dentry is busy.  Otherwise, return true and have
+ * that dentry's inode and parent both locked.
+ */
+
+static bool lock_for_kill(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	struct dentry *parent = dentry->d_parent;
+
+	if (unlikely(dentry->d_lockref.count))
+		return false;
+
+	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
+		goto slow;
+	if (dentry == parent)
+		return true;
+	if (likely(spin_trylock(&parent->d_lock)))
+		return true;
+
+	if (inode)
+		spin_unlock(&inode->i_lock);
+slow:
+	spin_unlock(&dentry->d_lock);
+
+	for (;;) {
+		if (inode)
+			spin_lock(&inode->i_lock);
+		parent = __lock_parent(dentry);
+		if (likely(inode == dentry->d_inode))
+			break;
+		if (inode)
+			spin_unlock(&inode->i_lock);
+		inode = dentry->d_inode;
+		spin_unlock(&dentry->d_lock);
+		if (parent)
+			spin_unlock(&parent->d_lock);
+	}
+	if (likely(!dentry->d_lockref.count))
+		return true;
+	if (inode)
+		spin_unlock(&inode->i_lock);
+	if (parent)
+		spin_unlock(&parent->d_lock);
+	return false;
 }
 
 static inline bool retain_dentry(struct dentry *dentry)
@@ -680,7 +734,6 @@ static inline bool retain_dentry(struct dentry *dentry)
 		return false;
 
 	/* retain; LRU fodder */
-	dentry->d_lockref.count--;
 	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
 		d_lru_add(dentry);
 	else if (unlikely(!(dentry->d_flags & DCACHE_REFERENCED)))
@@ -703,61 +756,12 @@ void d_mark_dontcache(struct inode *inode)
 }
 EXPORT_SYMBOL(d_mark_dontcache);
 
-/*
- * Finish off a dentry we've decided to kill.
- * dentry->d_lock must be held, returns with it unlocked.
- * Returns dentry requiring refcount drop, or NULL if we're done.
- */
-static struct dentry *dentry_kill(struct dentry *dentry)
-	__releases(dentry->d_lock)
-{
-	struct inode *inode = dentry->d_inode;
-	struct dentry *parent = NULL;
-
-	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
-		goto slow_positive;
-
-	if (!IS_ROOT(dentry)) {
-		parent = dentry->d_parent;
-		if (unlikely(!spin_trylock(&parent->d_lock))) {
-			parent = __lock_parent(dentry);
-			if (likely(inode || !dentry->d_inode))
-				goto got_locks;
-			/* negative that became positive */
-			if (parent)
-				spin_unlock(&parent->d_lock);
-			inode = dentry->d_inode;
-			goto slow_positive;
-		}
-	}
-	__dentry_kill(dentry);
-	return parent;
-
-slow_positive:
-	spin_unlock(&dentry->d_lock);
-	spin_lock(&inode->i_lock);
-	spin_lock(&dentry->d_lock);
-	parent = lock_parent(dentry);
-got_locks:
-	if (unlikely(dentry->d_lockref.count != 1)) {
-		dentry->d_lockref.count--;
-	} else if (likely(!retain_dentry(dentry))) {
-		__dentry_kill(dentry);
-		return parent;
-	}
-	/* we are keeping it, after all */
-	if (inode)
-		spin_unlock(&inode->i_lock);
-	if (parent)
-		spin_unlock(&parent->d_lock);
-	spin_unlock(&dentry->d_lock);
-	return NULL;
-}
-
 /*
  * Try to do a lockless dput(), and return whether that was successful.
  *
  * If unsuccessful, we return false, having already taken the dentry lock.
+ * In that case refcount is guaranteed to be zero and we have already
+ * decided that it's not worth keeping around.
  *
  * The caller needs to hold the RCU read lock, so that the dentry is
  * guaranteed to stay around even if the refcount goes down to zero!
@@ -768,15 +772,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	unsigned int d_flags;
 
 	/*
-	 * If we have a d_op->d_delete() operation, we sould not
-	 * let the dentry count go to zero, so use "put_or_lock".
-	 */
-	if (unlikely(dentry->d_flags & DCACHE_OP_DELETE))
-		return lockref_put_or_lock(&dentry->d_lockref);
-
-	/*
-	 * .. otherwise, we can try to just decrement the
-	 * lockref optimistically.
+	 * try to decrement the lockref optimistically.
 	 */
 	ret = lockref_put_return(&dentry->d_lockref);
 
@@ -787,12 +783,12 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	if (unlikely(ret < 0)) {
 		spin_lock(&dentry->d_lock);
-		if (dentry->d_lockref.count > 1) {
-			dentry->d_lockref.count--;
+		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
 			spin_unlock(&dentry->d_lock);
 			return true;
 		}
-		return false;
+		dentry->d_lockref.count--;
+		goto locked;
 	}
 
 	/*
@@ -830,7 +826,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	smp_rmb();
 	d_flags = READ_ONCE(dentry->d_flags);
-	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
+	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_OP_DELETE |
 			DCACHE_DISCONNECTED | DCACHE_DONTCACHE;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
@@ -850,17 +846,11 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * else could have killed it and marked it dead. Either way, we
 	 * don't need to do anything else.
 	 */
-	if (dentry->d_lockref.count) {
+locked:
+	if (dentry->d_lockref.count || retain_dentry(dentry)) {
 		spin_unlock(&dentry->d_lock);
 		return true;
 	}
-
-	/*
-	 * Re-get the reference we optimistically dropped. We hold the
-	 * lock, and we just tested that it was zero, so we can just
-	 * set it to 1.
-	 */
-	dentry->d_lockref.count = 1;
 	return false;
 }
 
@@ -903,29 +893,29 @@ void dput(struct dentry *dentry)
 		}
 
 		/* Slow case: now with the dentry lock held */
-		rcu_read_unlock();
-
-		if (likely(retain_dentry(dentry))) {
+		if (likely(lock_for_kill(dentry))) {
+			struct dentry *parent = dentry->d_parent;
+			rcu_read_unlock();
+			__dentry_kill(dentry);
+			if (dentry == parent)
+				return;
+			dentry = parent;
+		} else {
+			rcu_read_unlock();
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
-
-		dentry = dentry_kill(dentry);
 	}
 }
 EXPORT_SYMBOL(dput);
 
-static void __dput_to_list(struct dentry *dentry, struct list_head *list)
+static void to_shrink_list(struct dentry *dentry, struct list_head *list)
 __must_hold(&dentry->d_lock)
 {
-	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
-		/* let the owner of the list it's on deal with it */
-		--dentry->d_lockref.count;
-	} else {
+	if (!(dentry->d_flags & DCACHE_SHRINK_LIST)) {
 		if (dentry->d_flags & DCACHE_LRU_LIST)
 			d_lru_del(dentry);
-		if (!--dentry->d_lockref.count)
-			d_shrink_add(dentry, list);
+		d_shrink_add(dentry, list);
 	}
 }
 
@@ -937,8 +927,7 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 		return;
 	}
 	rcu_read_unlock();
-	if (!retain_dentry(dentry))
-		__dput_to_list(dentry, list);
+	to_shrink_list(dentry, list);
 	spin_unlock(&dentry->d_lock);
 }
 
@@ -1117,58 +1106,6 @@ void d_prune_aliases(struct inode *inode)
 }
 EXPORT_SYMBOL(d_prune_aliases);
 
-/*
- * Lock a dentry from shrink list.
- * Called under rcu_read_lock() and dentry->d_lock; the former
- * guarantees that nothing we access will be freed under us.
- * Note that dentry is *not* protected from concurrent dentry_kill(),
- * d_delete(), etc.
- *
- * Return false if dentry has been disrupted or grabbed, leaving
- * the caller to kick it off-list.  Otherwise, return true and have
- * that dentry's inode and parent both locked.
- */
-static bool shrink_lock_dentry(struct dentry *dentry)
-{
-	struct inode *inode;
-	struct dentry *parent;
-
-	if (dentry->d_lockref.count)
-		return false;
-
-	inode = dentry->d_inode;
-	if (inode && unlikely(!spin_trylock(&inode->i_lock))) {
-		spin_unlock(&dentry->d_lock);
-		spin_lock(&inode->i_lock);
-		spin_lock(&dentry->d_lock);
-		if (unlikely(dentry->d_lockref.count))
-			goto out;
-		/* changed inode means that somebody had grabbed it */
-		if (unlikely(inode != dentry->d_inode))
-			goto out;
-	}
-
-	parent = dentry->d_parent;
-	if (IS_ROOT(dentry) || likely(spin_trylock(&parent->d_lock)))
-		return true;
-
-	spin_unlock(&dentry->d_lock);
-	spin_lock(&parent->d_lock);
-	if (unlikely(parent != dentry->d_parent)) {
-		spin_unlock(&parent->d_lock);
-		spin_lock(&dentry->d_lock);
-		goto out;
-	}
-	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	if (likely(!dentry->d_lockref.count))
-		return true;
-	spin_unlock(&parent->d_lock);
-out:
-	if (inode)
-		spin_unlock(&inode->i_lock);
-	return false;
-}
-
 void shrink_dentry_list(struct list_head *list)
 {
 	while (!list_empty(list)) {
@@ -1177,12 +1114,11 @@ void shrink_dentry_list(struct list_head *list)
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
 		rcu_read_lock();
-		if (!shrink_lock_dentry(dentry)) {
+		if (!lock_for_kill(dentry)) {
 			bool can_free = false;
 			rcu_read_unlock();
 			d_shrink_del(dentry);
-			if (dentry->d_lockref.count < 0)
-				can_free = dentry->d_flags & DCACHE_MAY_FREE;
+			can_free = dentry->d_flags & DCACHE_MAY_FREE;
 			spin_unlock(&dentry->d_lock);
 			if (can_free)
 				dentry_free(dentry);
@@ -1191,8 +1127,8 @@ void shrink_dentry_list(struct list_head *list)
 		rcu_read_unlock();
 		d_shrink_del(dentry);
 		parent = dentry->d_parent;
-		if (parent != dentry)
-			__dput_to_list(parent, list);
+		if (parent != dentry && !--parent->d_lockref.count)
+			to_shrink_list(parent, list);
 		__dentry_kill(dentry);
 	}
 }
@@ -1632,14 +1568,15 @@ void shrink_dcache_parent(struct dentry *parent)
 		if (data.victim) {
 			struct dentry *parent;
 			spin_lock(&data.victim->d_lock);
-			if (!shrink_lock_dentry(data.victim)) {
+			if (!lock_for_kill(data.victim)) {
 				spin_unlock(&data.victim->d_lock);
 				rcu_read_unlock();
 			} else {
 				rcu_read_unlock();
 				parent = data.victim->d_parent;
-				if (parent != data.victim)
-					__dput_to_list(parent, &data.dispose);
+				if (parent != data.victim &&
+				    !--parent->d_lockref.count)
+					to_shrink_list(parent, &data.dispose);
 				__dentry_kill(data.victim);
 			}
 		}

