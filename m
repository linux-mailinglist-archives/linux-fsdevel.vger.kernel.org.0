Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E451DAFF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETKVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 06:21:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E01C061A0E;
        Wed, 20 May 2020 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=byLosyX8OkvGSnd/wUlp1r+QewPCabBxbFeDlkadP7M=; b=flAGazfRzeASVv+VOK57DI2L9r
        BnZGeYRyRqR/Homc0d9iMHyqn0avvFDpyI0y3bmjV3sVbyBmlBIqf+ZXp5sbRLEAbZgwr0IAoqFBh
        fhwUH4tahwxDUJKd52fydXH6kbno5GRcBqhw8ipMQ7sT4vZY6beVBDLUu60uID1O3CDBfQbXy3C2V
        UTX1IPCt9YOa3dU7ziEtloa1FlbteAGVjB06StFvCjkmSokFKp3x5MUQpjlQnzImO0k9pfZXJPoOZ
        vYmyUK6ezRWlu59XTf1TCSTkSj2Bq/CH9RZjxiKBi9hY5e0jyy7pTfLxV/e1t7moFQkj3Q3vehy38
        TDZqIlhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbLqb-0004Zd-CE; Wed, 20 May 2020 10:21:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA4CB30067C;
        Wed, 20 May 2020 12:21:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EDF025D60CB3; Wed, 20 May 2020 12:21:10 +0200 (CEST)
Date:   Wed, 20 May 2020 12:21:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] radix-tree: Use local_lock for protection
Message-ID: <20200520102110.GE317569@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519201912.1564477-3-bigeasy@linutronix.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 10:19:06PM +0200, Sebastian Andrzej Siewior wrote:
> @@ -64,6 +64,7 @@ struct radix_tree_preload {
>  	struct radix_tree_node *nodes;
>  };
>  static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
> +static DEFINE_LOCAL_LOCK(radix_tree_preloads_lock);
>  
>  static inline struct radix_tree_node *entry_to_node(void *ptr)
>  {

So I'm all with Andrew on the naming and pass-by-pointer thing, but
also, the above is pretty crap. You want the local_lock to be in the
structure you're actually protecting, and there really isn't anything
stopping you from doing that.

The below builds just fine and is ever so much more sensible.

--- a/include/linux/locallock_internal.h
+++ b/include/linux/locallock_internal.h
@@ -19,7 +19,7 @@ struct local_lock {
 # define LL_DEP_MAP_INIT(lockname)
 #endif
 
-#define INIT_LOCAL_LOCK(lockname)	LL_DEP_MAP_INIT(lockname)
+#define INIT_LOCAL_LOCK(lockname)	{ LL_DEP_MAP_INIT(lockname) }
 
 #define local_lock_lockdep_init(lock)				\
 do {								\
@@ -63,35 +63,35 @@ static inline void local_lock_release(st
 #define __local_lock(lock)					\
 	do {							\
 		preempt_disable();				\
-		local_lock_acquire(this_cpu_ptr(&(lock)));	\
+		local_lock_acquire(this_cpu_ptr(lock));		\
 	} while (0)
 
 #define __local_lock_irq(lock)					\
 	do {							\
 		local_irq_disable();				\
-		local_lock_acquire(this_cpu_ptr(&(lock)));	\
+		local_lock_acquire(this_cpu_ptr(lock));		\
 	} while (0)
 
 #define __local_lock_irqsave(lock, flags)			\
 	do {							\
 		local_irq_save(flags);				\
-		local_lock_acquire(this_cpu_ptr(&(lock)));	\
+		local_lock_acquire(this_cpu_ptr(lock));		\
 	} while (0)
 
 #define __local_unlock(lock)					\
 	do {							\
-		local_lock_release(this_cpu_ptr(&lock));	\
+		local_lock_release(this_cpu_ptr(lock));		\
 		preempt_enable();				\
 	} while (0)
 
 #define __local_unlock_irq(lock)				\
 	do {							\
-		local_lock_release(this_cpu_ptr(&lock));	\
+		local_lock_release(this_cpu_ptr(lock));		\
 		local_irq_enable();				\
 	} while (0)
 
 #define __local_unlock_irqrestore(lock, flags)			\
 	do {							\
-		local_lock_release(this_cpu_ptr(&lock));	\
+		local_lock_release(this_cpu_ptr(lock));		\
 		local_irq_restore(flags);			\
 	} while (0)
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -59,12 +59,14 @@ struct kmem_cache *radix_tree_node_cache
  * Per-cpu pool of preloaded nodes
  */
 struct radix_tree_preload {
+	struct local_lock lock;
 	unsigned nr;
 	/* nodes->parent points to next preallocated node */
 	struct radix_tree_node *nodes;
 };
-static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
-static DEFINE_LOCAL_LOCK(radix_tree_preloads_lock);
+static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) =
+	{ .lock = INIT_LOCAL_LOCK(lock),
+	  .nr = 0, };
 
 static inline struct radix_tree_node *entry_to_node(void *ptr)
 {
@@ -333,14 +335,14 @@ static __must_check int __radix_tree_pre
 	 */
 	gfp_mask &= ~__GFP_ACCOUNT;
 
-	local_lock(radix_tree_preloads_lock);
+	local_lock(&radix_tree_preloads.lock);
 	rtp = this_cpu_ptr(&radix_tree_preloads);
 	while (rtp->nr < nr) {
-		local_unlock(radix_tree_preloads_lock);
+		local_unlock(&radix_tree_preloads.lock);
 		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
 		if (node == NULL)
 			goto out;
-		local_lock(radix_tree_preloads_lock);
+		local_lock(&radix_tree_preloads.lock);
 		rtp = this_cpu_ptr(&radix_tree_preloads);
 		if (rtp->nr < nr) {
 			node->parent = rtp->nodes;
@@ -382,14 +384,14 @@ int radix_tree_maybe_preload(gfp_t gfp_m
 	if (gfpflags_allow_blocking(gfp_mask))
 		return __radix_tree_preload(gfp_mask, RADIX_TREE_PRELOAD_SIZE);
 	/* Preloading doesn't help anything with this gfp mask, skip it */
-	local_lock(radix_tree_preloads_lock);
+	local_lock(&radix_tree_preloads.lock);
 	return 0;
 }
 EXPORT_SYMBOL(radix_tree_maybe_preload);
 
 void radix_tree_preload_end(void)
 {
-	local_unlock(radix_tree_preloads_lock);
+	local_unlock(&radix_tree_preloads.lock);
 }
 EXPORT_SYMBOL(radix_tree_preload_end);
 
@@ -1477,13 +1479,13 @@ EXPORT_SYMBOL(radix_tree_tagged);
 void idr_preload(gfp_t gfp_mask)
 {
 	if (__radix_tree_preload(gfp_mask, IDR_PRELOAD_SIZE))
-		local_lock(radix_tree_preloads_lock);
+		local_lock(&radix_tree_preloads.lock);
 }
 EXPORT_SYMBOL(idr_preload);
 
 void idr_preload_end(void)
 {
-	local_unlock(radix_tree_preloads_lock);
+	local_unlock(&radix_tree_preloads.lock);
 }
 EXPORT_SYMBOL(idr_preload_end);
 
