Return-Path: <linux-fsdevel+bounces-2694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B422F7E7932
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 07:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B0B1C20DB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 06:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BF263B7;
	Fri, 10 Nov 2023 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UtlknFro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492115693
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 06:22:09 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9D46E93
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0UJfUwHaUUdUrDTLFfnRaq4/WugNCOc8B0fOb6sCQD8=; b=UtlknFroQ1o2OmIqI4K2BhqaYx
	6Bf/dZ3INTc1XjhMlspgqAKXDoPaY6aDJG+8YwuBuzASfsQTSXK8mhyXT7sIeLjMpopCnzh6p5BZB
	zyznT4H5gvaTmdIQEbx83yU4toCMA0sCcDVsKJPmaAkwggTDbLL7Eex3Yjjrx1opKfMCRtGNAHcuy
	L88mDsKkeafDT66BpWqJiEUzN0NjR6FA20Lq1nEZkOvrkyJ7fF7g6/MUR4KZ+U+kRVX6AUVun/9+J
	/BTqyb3ObC+k/bqvGGoBen+WUt7iFkLiYl41EPcmmwHSyOFvqf3WRc7ZJE/OIXJ6a/ODzQwJvnp+a
	I11KWYPg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1J0b-00DjbK-0y;
	Fri, 10 Nov 2023 04:20:41 +0000
Date: Fri, 10 Nov 2023 04:20:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
Message-ID: <20231110042041.GL1957730@ZenIV>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101181910.GH1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 01, 2023 at 06:19:10PM +0000, Al Viro wrote:
 
> gcc-12 on x86 turns the series of ifs into
>         movl    %edi, %eax
> 	andl    $32832, %eax
> 	cmpl    $32832, %eax
> 	jne     .L17
> 	andl    $168, %edi
> 	jne     .L17
> instead of combining that into
>         andl    $33000, %edi
> 	cmpl    $32832, %edi
> 	jne     .L17
> 
> OTOH, that's not much of pessimization...  Up to you.

	FWIW, on top of current #work.dcache2 the following delta might be worth
looking into.  Not sure if it's less confusing that way, though - I'd been staring
at that place for too long.  Code generation is slightly suboptimal with recent
gcc, but only marginally so.

diff --git a/fs/dcache.c b/fs/dcache.c
index bd57b9a08894..9e1486db64a7 100644
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

