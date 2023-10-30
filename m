Return-Path: <linux-fsdevel+bounces-1515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FAB7DB1B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 01:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BEC28144E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 00:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F99F384;
	Mon, 30 Oct 2023 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a8WTS999"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF419E
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 00:38:08 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DD7BE
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Oct 2023 17:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HrJWKZ45dG0lkgbFbyBnhCIkE3A0nth2wAbWuHbjyTE=; b=a8WTS9998BYDxXR6e0HgQLscBl
	DOUdm0GcTOyxLNCcdOEtrCNUsPqCwH8r/Kkje553uToKpIa8N+umn1IcTUCLi4wj7+2nCHGXn/6Vw
	SdRVjX+6iyvC3dpnqDDF6dAsLPKwc9SiOiReBMRiM4lUJvs0hWy6goaE36FBqkJYbXGYB8O8jaGab
	7n1ydtn6bPJdgHF2A144JuHwB97mHv1/NyyFvehkF6cwmA/3sGOFoWdDukKLzbxUC8LTqq3/APkhm
	VgZH2iHPD/ZDxMWDWbLwXhLSEML8aNDzF+rd1RGQuF7ImE7Zh+LwTN1NNMsIA26EHmY6hceNxHiph
	7956QQnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qxGI3-007jF8-1P;
	Mon, 30 Oct 2023 00:37:59 +0000
Date: Mon, 30 Oct 2023 00:37:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231030003759.GW800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Back in 2015 when fast_dput() got introduced, I'd been worried
about ->d_delete() being exposed to dentries with zero refcount.
To quote my reply to Linus back then,

"The only potential nastiness I can see here is that filesystem with
->d_delete() always returning 1 might be surprised by encountering
a hashed dentry with zero d_count.  I can't recall anything actually
sensitive to that, and there might very well be no such examples,
but in principle it might be a problem.  Might be a good idea to check
DCACHE_OP_DELETE before anything else..."

Looking at that again, that check was not a good idea.  Sure, ->d_delete()
instances could, in theory, check d_count (as BUG_ON(d_count(dentry) != 1)
or something equally useful) or, worse, drop and regain ->d_lock.
The latter would be rather hard to pull off safely, but it is not
impossible.  The thing is, none of the in-tree instances do anything of
that sort and I don't see any valid reasons why anyone would want to.

And getting rid of that would, AFAICS, allow for much simpler rules
around __dentry_kill() and friends - we could hold rcu_read_lock
over the places where dentry_kill() drops/regains ->d_lock and
that would allow
	* fast_dput() always decrementing refcount
	* retain_dentry() never modifying it
	* __dentry_kill() always called with refcount 0 (currently
it gets 1 from dentry_kill() and 0 in all other cases)

Does anybody see any problems with something along the lines of the
(untested) patch below?  It would need to be carved up (and accompanied
by "thou shalt not play silly buggers with ->d_lockref in your
->d_delete() instances" in D/f/porting), obviously, but I would really
like to get saner rules around refcount manipulations in there - as
it is, trying to document them gets very annoying.

Comments?

diff --git a/fs/dcache.c b/fs/dcache.c
index 9f471fdb768b..af0e067f6982 100644
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
+	if (likely(dentry->d_lockref.count == 0 && !retain_dentry(dentry))) {
+		rcu_read_unlock();
 		__dentry_kill(dentry);
 		return parent;
 	}
@@ -751,6 +750,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	if (parent)
 		spin_unlock(&parent->d_lock);
 	spin_unlock(&dentry->d_lock);
+	rcu_read_unlock();
 	return NULL;
 }
 
@@ -768,15 +768,7 @@ static inline bool fast_dput(struct dentry *dentry)
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
+	 * decrement the lockref optimistically.
 	 */
 	ret = lockref_put_return(&dentry->d_lockref);
 
@@ -830,7 +822,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	smp_rmb();
 	d_flags = READ_ONCE(dentry->d_flags);
-	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
+	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_OP_DELETE |
 			DCACHE_DISCONNECTED | DCACHE_DONTCACHE;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
@@ -855,12 +847,6 @@ static inline bool fast_dput(struct dentry *dentry)
 		return true;
 	}
 
-	/*
-	 * Re-get the reference we optimistically dropped. We hold the
-	 * lock, and we just tested that it was zero, so we can just
-	 * set it to 1.
-	 */
-	dentry->d_lockref.count = 1;
 	return false;
 }
 
@@ -903,10 +889,9 @@ void dput(struct dentry *dentry)
 		}
 
 		/* Slow case: now with the dentry lock held */
-		rcu_read_unlock();
-
 		if (likely(retain_dentry(dentry))) {
 			spin_unlock(&dentry->d_lock);
+			rcu_read_unlock();
 			return;
 		}
 
@@ -918,14 +903,10 @@ EXPORT_SYMBOL(dput);
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
 
@@ -1191,7 +1172,7 @@ void shrink_dentry_list(struct list_head *list)
 		rcu_read_unlock();
 		d_shrink_del(dentry);
 		parent = dentry->d_parent;
-		if (parent != dentry)
+		if (parent != dentry && !--parent->d_lockref.count)
 			__dput_to_list(parent, list);
 		__dentry_kill(dentry);
 	}
@@ -1638,7 +1619,8 @@ void shrink_dcache_parent(struct dentry *parent)
 			} else {
 				rcu_read_unlock();
 				parent = data.victim->d_parent;
-				if (parent != data.victim)
+				if (parent != data.victim &&
+				    !--parent->d_lockref.count)
 					__dput_to_list(parent, &data.dispose);
 				__dentry_kill(data.victim);
 			}

