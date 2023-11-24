Return-Path: <linux-fsdevel+bounces-3613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF617F6BFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88620280DA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD6C143;
	Fri, 24 Nov 2023 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pMK+8DGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7BD10E4;
	Thu, 23 Nov 2023 22:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZTI1Qwo+G2SSwx5I29IIozwFuuhO3zcAfifPRRRbv4c=; b=pMK+8DGc3l91GAadTOE1zrzKnq
	zBSy1c8Ve1eKn0IfyNP2xr/hlLI7/0qPDMf3yKL0X+JckDmIt233NBYO0YCau8XHwq0a+NNO0Arxq
	e1PJ0c2fZcBwgUQQDSjfTzaz5dbBkXCnr0vF3mtgsy11jXNsGwAIATRQRSiv4iNt3xJO5P0dafcWx
	RiDt/TJYGIACI0wom/+RG4A4HrsY5M8xugC0gUFQRQZCgLZk21Hc+Wu8XlbAj+pHzYUxQlArBAlNR
	by2znbYanwdhhc6YwEcEB8DkTydkFnshGXIX0iDHqLHFUgBTqgRtFSVZb95tNwUDKYUzM8wm89g3/
	cssAGSMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PIg-002PvR-2x;
	Fri, 24 Nov 2023 06:04:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/21] retain_dentry(): introduce a trimmed-down lockless variant
Date: Fri, 24 Nov 2023 06:04:22 +0000
Message-Id: <20231124060422.576198-21-viro@zeniv.linux.org.uk>
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

	fast_dput() contains a small piece of code, preceded by scary
comments about 5 times longer than it.	What is actually done there is
a trimmed-down subset of retain_dentry() - in some situations we can
tell that retain_dentry() would have returned true without ever needing
->d_lock and that's what that code checks.  If these checks come true
fast_dput() can declare that we are done, without bothering with ->d_lock;
otherwise it has to take the lock and do full variant of retain_dentry()
checks.

	Trimmed-down variant of the checks is hard to follow and
it's asking for trouble - if we ever decide to change the rules in
retain_dentry(), we'll have to remember to update that code.  It turns
out that an equivalent variant of these checks more obviously parallel
to retain_dentry() is not just possible, but easy to unify with
retain_dentry() itself, passing it a new boolean argument ('locked')
to distinguish between the full semantics and trimmed down one.

	Note that in lockless case true is returned only when locked
variant would have returned true without ever needing the lock; false
means "punt to the locking path and recheck there".

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 95 ++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c795154ffa3a..b212a65ed190 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -665,30 +665,57 @@ static bool lock_for_kill(struct dentry *dentry)
 	return false;
 }
 
-static inline bool retain_dentry(struct dentry *dentry)
+/*
+ * Decide if dentry is worth retaining.  Usually this is called with dentry
+ * locked; if not locked, we are more limited and might not be able to tell
+ * without a lock.  False in this case means "punt to locked path and recheck".
+ *
+ * In case we aren't locked, these predicates are not "stable". However, it is
+ * sufficient that at some point after we dropped the reference the dentry was
+ * hashed and the flags had the proper value. Other dentry users may have
+ * re-gotten a reference to the dentry and change that, but our work is done -
+ * we can leave the dentry around with a zero refcount.
+ */
+static inline bool retain_dentry(struct dentry *dentry, bool locked)
 {
-	WARN_ON(d_in_lookup(dentry));
+	unsigned int d_flags;
 
-	/* Unreachable? Get rid of it */
+	smp_rmb();
+	d_flags = READ_ONCE(dentry->d_flags);
+
+	// Unreachable? Nobody would be able to look it up, no point retaining
 	if (unlikely(d_unhashed(dentry)))
 		return false;
 
-	if (unlikely(dentry->d_flags & DCACHE_DISCONNECTED))
+	// Same if it's disconnected
+	if (unlikely(d_flags & DCACHE_DISCONNECTED))
 		return false;
 
-	if (unlikely(dentry->d_flags & DCACHE_OP_DELETE)) {
-		if (dentry->d_op->d_delete(dentry))
+	// ->d_delete() might tell us not to bother, but that requires
+	// ->d_lock; can't decide without it
+	if (unlikely(d_flags & DCACHE_OP_DELETE)) {
+		if (!locked || dentry->d_op->d_delete(dentry))
 			return false;
 	}
 
-	if (unlikely(dentry->d_flags & DCACHE_DONTCACHE))
+	// Explicitly told not to bother
+	if (unlikely(d_flags & DCACHE_DONTCACHE))
 		return false;
 
-	/* retain; LRU fodder */
-	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
+	// At this point it looks like we ought to keep it.  We also might
+	// need to do something - put it on LRU if it wasn't there already
+	// and mark it referenced if it was on LRU, but not marked yet.
+	// Unfortunately, both actions require ->d_lock, so in lockless
+	// case we'd have to punt rather than doing those.
+	if (unlikely(!(d_flags & DCACHE_LRU_LIST))) {
+		if (!locked)
+			return false;
 		d_lru_add(dentry);
-	else if (unlikely(!(dentry->d_flags & DCACHE_REFERENCED)))
+	} else if (unlikely(!(d_flags & DCACHE_REFERENCED))) {
+		if (!locked)
+			return false;
 		dentry->d_flags |= DCACHE_REFERENCED;
+	}
 	return true;
 }
 
@@ -720,7 +747,6 @@ EXPORT_SYMBOL(d_mark_dontcache);
 static inline bool fast_dput(struct dentry *dentry)
 {
 	int ret;
-	unsigned int d_flags;
 
 	/*
 	 * try to decrement the lockref optimistically.
@@ -749,45 +775,18 @@ static inline bool fast_dput(struct dentry *dentry)
 		return true;
 
 	/*
-	 * Careful, careful. The reference count went down
-	 * to zero, but we don't hold the dentry lock, so
-	 * somebody else could get it again, and do another
-	 * dput(), and we need to not race with that.
-	 *
-	 * However, there is a very special and common case
-	 * where we don't care, because there is nothing to
-	 * do: the dentry is still hashed, it does not have
-	 * a 'delete' op, and it's referenced and already on
-	 * the LRU list.
-	 *
-	 * NOTE! Since we aren't locked, these values are
-	 * not "stable". However, it is sufficient that at
-	 * some point after we dropped the reference the
-	 * dentry was hashed and the flags had the proper
-	 * value. Other dentry users may have re-gotten
-	 * a reference to the dentry and change that, but
-	 * our work is done - we can leave the dentry
-	 * around with a zero refcount.
-	 *
-	 * Nevertheless, there are two cases that we should kill
-	 * the dentry anyway.
-	 * 1. free disconnected dentries as soon as their refcount
-	 *    reached zero.
-	 * 2. free dentries if they should not be cached.
+	 * Can we decide that decrement of refcount is all we needed without
+	 * taking the lock?  There's a very common case when it's all we need -
+	 * dentry looks like it ought to be retained and there's nothing else
+	 * to do.
 	 */
-	smp_rmb();
-	d_flags = READ_ONCE(dentry->d_flags);
-	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_OP_DELETE |
-			DCACHE_DISCONNECTED | DCACHE_DONTCACHE;
-
-	/* Nothing to do? Dropping the reference was all we needed? */
-	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
+	if (retain_dentry(dentry, false))
 		return true;
 
 	/*
-	 * Not the fast normal case? Get the lock. We've already decremented
-	 * the refcount, but we'll need to re-check the situation after
-	 * getting the lock.
+	 * Either not worth retaining or we can't tell without the lock.
+	 * Get the lock, then.  We've already decremented the refcount to 0,
+	 * but we'll need to re-check the situation after getting the lock.
 	 */
 	spin_lock(&dentry->d_lock);
 
@@ -798,7 +797,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * don't need to do anything else.
 	 */
 locked:
-	if (dentry->d_lockref.count || retain_dentry(dentry)) {
+	if (dentry->d_lockref.count || retain_dentry(dentry, true)) {
 		spin_unlock(&dentry->d_lock);
 		return true;
 	}
@@ -847,7 +846,7 @@ void dput(struct dentry *dentry)
 		dentry = __dentry_kill(dentry);
 		if (!dentry)
 			return;
-		if (retain_dentry(dentry)) {
+		if (retain_dentry(dentry, true)) {
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
-- 
2.39.2


