Return-Path: <linux-fsdevel+bounces-1588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0C7DC22B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 22:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B181C20B04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051901CFB1;
	Mon, 30 Oct 2023 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WKuJa6fH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9031CFA0
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 21:53:22 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD140F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 14:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5ngNPdSEAvv4WCsaQtVmrA5E3GRMtPWdw8rCprylRBU=; b=WKuJa6fHO8vxDy4KaTLouBq/is
	F5RyhzUMtEKGmn9e4ZuRniTh8d1eKEnvDo9vuuf2Z/huysbsB3xVfpHFb0BNJFuhyejRxaxAqIU/H
	rKGVtGRu6bbcQcbfkkjDBbrqDbpdxNzdiKCndZfJfwQILSwWpbyFNq95hHvxgig3ybnlXLlmcYvPj
	fdbUCNNkQe/XOxBuP5jhZCkNP9fimGPnYykbiVurbt1t8wG6eJ50G5Xy6p1vn1ZdaD/1EXzRbfhqq
	+iPrtdGcDwN690FZ5RwPth7h7nkN95gXxRAqju8hraOFWUZK+uB7omsx/Ajik5vqIhQaedtyqI0LD
	ctSBhAlg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qxaCB-0089EJ-03;
	Mon, 30 Oct 2023 21:53:15 +0000
Date: Mon, 30 Oct 2023 21:53:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231030215315.GA1941809@ZenIV>
References: <20231030003759.GW800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030003759.GW800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 30, 2023 at 12:37:59AM +0000, Al Viro wrote:
> 	Back in 2015 when fast_dput() got introduced, I'd been worried
> about ->d_delete() being exposed to dentries with zero refcount.
> To quote my reply to Linus back then,
> 
> "The only potential nastiness I can see here is that filesystem with
> ->d_delete() always returning 1 might be surprised by encountering
> a hashed dentry with zero d_count.  I can't recall anything actually
> sensitive to that, and there might very well be no such examples,
> but in principle it might be a problem.  Might be a good idea to check
> DCACHE_OP_DELETE before anything else..."
> 
> Looking at that again, that check was not a good idea.  Sure, ->d_delete()
> instances could, in theory, check d_count (as BUG_ON(d_count(dentry) != 1)
> or something equally useful) or, worse, drop and regain ->d_lock.
> The latter would be rather hard to pull off safely, but it is not
> impossible.  The thing is, none of the in-tree instances do anything of
> that sort and I don't see any valid reasons why anyone would want to.
> 
> And getting rid of that would, AFAICS, allow for much simpler rules
> around __dentry_kill() and friends - we could hold rcu_read_lock
> over the places where dentry_kill() drops/regains ->d_lock and
> that would allow
> 	* fast_dput() always decrementing refcount
> 	* retain_dentry() never modifying it
> 	* __dentry_kill() always called with refcount 0 (currently
> it gets 1 from dentry_kill() and 0 in all other cases)
> 
> Does anybody see any problems with something along the lines of the
> (untested) patch below?  It would need to be carved up (and accompanied
> by "thou shalt not play silly buggers with ->d_lockref in your
> ->d_delete() instances" in D/f/porting), obviously, but I would really
> like to get saner rules around refcount manipulations in there - as
> it is, trying to document them gets very annoying.
> 
> Comments?

After fixing a couple of brainos, it seems to work.  See below:

diff --git a/fs/dcache.c b/fs/dcache.c
index 9f471fdb768b..5e975a013508 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -680,7 +680,6 @@ static inline bool retain_dentry(struct dentry *dentry)
 		return false;
 
 	/* retain; LRU fodder */
-	dentry->d_lockref.count--;
 	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
 		d_lru_add(dentry);
 	else if (unlikely(!(dentry->d_flags & DCACHE_REFERENCED)))
@@ -709,7 +708,7 @@ EXPORT_SYMBOL(d_mark_dontcache);
  * Returns dentry requiring refcount drop, or NULL if we're done.
  */
 static struct dentry *dentry_kill(struct dentry *dentry)
-	__releases(dentry->d_lock)
+	__releases(dentry->d_lock) __releases(rcu)
 {
 	struct inode *inode = dentry->d_inode;
 	struct dentry *parent = NULL;
@@ -730,6 +729,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 			goto slow_positive;
 		}
 	}
+	rcu_read_unlock();
 	__dentry_kill(dentry);
 	return parent;
 
@@ -739,9 +739,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	spin_lock(&dentry->d_lock);
 	parent = lock_parent(dentry);
 got_locks:
-	if (unlikely(dentry->d_lockref.count != 1)) {
-		dentry->d_lockref.count--;
-	} else if (likely(!retain_dentry(dentry))) {
+	rcu_read_unlock();
+	if (likely(dentry->d_lockref.count == 0 && !retain_dentry(dentry))) {
 		__dentry_kill(dentry);
 		return parent;
 	}
@@ -768,15 +767,7 @@ static inline bool fast_dput(struct dentry *dentry)
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
 
@@ -787,8 +778,12 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	if (unlikely(ret < 0)) {
 		spin_lock(&dentry->d_lock);
-		if (dentry->d_lockref.count > 1) {
-			dentry->d_lockref.count--;
+		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
+			spin_unlock(&dentry->d_lock);
+			return true;
+		}
+		dentry->d_lockref.count--;
+		if (dentry->d_lockref.count) {
 			spin_unlock(&dentry->d_lock);
 			return true;
 		}
@@ -830,7 +825,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	smp_rmb();
 	d_flags = READ_ONCE(dentry->d_flags);
-	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
+	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_OP_DELETE |
 			DCACHE_DISCONNECTED | DCACHE_DONTCACHE;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
@@ -854,13 +849,6 @@ static inline bool fast_dput(struct dentry *dentry)
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
 
@@ -903,10 +891,9 @@ void dput(struct dentry *dentry)
 		}
 
 		/* Slow case: now with the dentry lock held */
-		rcu_read_unlock();
-
 		if (likely(retain_dentry(dentry))) {
 			spin_unlock(&dentry->d_lock);
+			rcu_read_unlock();
 			return;
 		}
 
@@ -918,14 +905,10 @@ EXPORT_SYMBOL(dput);
 static void __dput_to_list(struct dentry *dentry, struct list_head *list)
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
 
@@ -1191,7 +1174,7 @@ void shrink_dentry_list(struct list_head *list)
 		rcu_read_unlock();
 		d_shrink_del(dentry);
 		parent = dentry->d_parent;
-		if (parent != dentry)
+		if (parent != dentry && !--parent->d_lockref.count)
 			__dput_to_list(parent, list);
 		__dentry_kill(dentry);
 	}
@@ -1638,7 +1621,8 @@ void shrink_dcache_parent(struct dentry *parent)
 			} else {
 				rcu_read_unlock();
 				parent = data.victim->d_parent;
-				if (parent != data.victim)
+				if (parent != data.victim &&
+				    !--parent->d_lockref.count)
 					__dput_to_list(parent, &data.dispose);
 				__dentry_kill(data.victim);
 			}

