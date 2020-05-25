Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144B71E0CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 13:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390148AbgEYLRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 07:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390073AbgEYLRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 07:17:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B5BC061A0E;
        Mon, 25 May 2020 04:17:53 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdB74-0007Ln-QO; Mon, 25 May 2020 13:17:46 +0200
Date:   Mon, 25 May 2020 13:17:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] radix-tree: Use local_lock for protection
Message-ID: <20200525111746.bufjnl7mo4ytwlap@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-3-bigeasy@linutronix.de>
 <20200525062954.GA3180782@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525062954.GA3180782@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-05-25 08:29:54 [+0200], Ingo Molnar wrote:
> Since upstream we are still mapping the local_lock primitives to
> preempt_disable()/preempt_enable(), I believe these uninlining changes should not be done
> in this patch, i.e. idr_preload_end() and radix_tree_preload_end() should stay inline.

That means we need to export the per-CPU struct radix_tree_preload in
order to access the ::lock from an inline function.

Something like this then:

diff --git a/include/linux/idr.h b/include/linux/idr.h
index ac6e946b6767b..3ade03e5c7af3 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -171,7 +171,7 @@ static inline bool idr_is_empty(const struct idr *idr)
  */
 static inline void idr_preload_end(void)
 {
-	preempt_enable();
+	local_unlock(&radix_tree_preloads.lock);
 }
 
 /**
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 63e62372443a5..1dcc43ac75aed 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -16,11 +16,20 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
+#include <linux/locallock.h>
 
 /* Keep unconverted code working */
 #define radix_tree_root		xarray
 #define radix_tree_node		xa_node
 
+struct radix_tree_preload {
+	struct local_lock lock;
+	unsigned nr;
+	/* nodes->parent points to next preallocated node */
+	struct radix_tree_node *nodes;
+};
+DECLARE_PER_CPU(struct radix_tree_preload, radix_tree_preloads);
+
 /*
  * The bottom two bits of the slot determine how the remaining bits in the
  * slot are interpreted:
@@ -245,7 +254,7 @@ int radix_tree_tagged(const struct radix_tree_root *, unsigned int tag);
 
 static inline void radix_tree_preload_end(void)
 {
-	preempt_enable();
+	local_unlock(&radix_tree_preloads.lock);
 }
 
 void __rcu **idr_get_free(struct radix_tree_root *root,
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 2ee6ae3b0ade0..1c46840b4f1d3 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
 #include <linux/percpu.h>
+#include <linux/locallock.h>
 #include <linux/preempt.h>		/* in_interrupt() */
 #include <linux/radix-tree.h>
 #include <linux/rcupdate.h>
@@ -27,7 +28,6 @@
 #include <linux/string.h>
 #include <linux/xarray.h>
 
-
 /*
  * Radix tree node cache.
  */
@@ -58,12 +58,10 @@ struct kmem_cache *radix_tree_node_cachep;
 /*
  * Per-cpu pool of preloaded nodes
  */
-struct radix_tree_preload {
-	unsigned nr;
-	/* nodes->parent points to next preallocated node */
-	struct radix_tree_node *nodes;
+DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = {
+	.lock = INIT_LOCAL_LOCK(lock),
 };
-static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
+EXPORT_PER_CPU_SYMBOL_GPL(radix_tree_preloads);
 
 static inline struct radix_tree_node *entry_to_node(void *ptr)
 {
@@ -332,14 +330,14 @@ static __must_check int __radix_tree_preload(gfp_t gfp_mask, unsigned nr)
 	 */
 	gfp_mask &= ~__GFP_ACCOUNT;
 
-	preempt_disable();
+	local_lock(&radix_tree_preloads.lock);
 	rtp = this_cpu_ptr(&radix_tree_preloads);
 	while (rtp->nr < nr) {
-		preempt_enable();
+		local_unlock(&radix_tree_preloads.lock);
 		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
 		if (node == NULL)
 			goto out;
-		preempt_disable();
+		local_lock(&radix_tree_preloads.lock);
 		rtp = this_cpu_ptr(&radix_tree_preloads);
 		if (rtp->nr < nr) {
 			node->parent = rtp->nodes;
@@ -381,7 +379,7 @@ int radix_tree_maybe_preload(gfp_t gfp_mask)
 	if (gfpflags_allow_blocking(gfp_mask))
 		return __radix_tree_preload(gfp_mask, RADIX_TREE_PRELOAD_SIZE);
 	/* Preloading doesn't help anything with this gfp mask, skip it */
-	preempt_disable();
+	local_lock(&radix_tree_preloads.lock);
 	return 0;
 }
 EXPORT_SYMBOL(radix_tree_maybe_preload);
@@ -1470,7 +1468,7 @@ EXPORT_SYMBOL(radix_tree_tagged);
 void idr_preload(gfp_t gfp_mask)
 {
 	if (__radix_tree_preload(gfp_mask, IDR_PRELOAD_SIZE))
-		preempt_disable();
+		local_lock(&radix_tree_preloads.lock);
 }
 EXPORT_SYMBOL(idr_preload);
 
-- 
2.27.0.rc0


> Thanks,
> 
> 	Ingo

Sebastian
