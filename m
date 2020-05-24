Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58C91E0389
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 23:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbgEXV6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 17:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbgEXV6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 17:58:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC238C061A0E;
        Sun, 24 May 2020 14:58:17 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jcycv-0007Zv-DF; Sun, 24 May 2020 23:57:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/7] radix-tree: Use local_lock for protection
Date:   Sun, 24 May 2020 23:57:34 +0200
Message-Id: <20200524215739.551568-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200524215739.551568-1-bigeasy@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The radix-tree and idr preload mechanisms use preempt_disable() to protect
the complete operation between xxx_preload() and xxx_preload_end().

As the code inside the preempt disabled section acquires regular spinlocks,
which are converted to 'sleeping' spinlocks on a PREEMPT_RT kernel and
eventually calls into a memory allocator, this conflicts with the RT
semantics.

Convert it to a local_lock which allows RT kernels to substitute them with
a real per CPU lock. On non RT kernels this maps to preempt_disable() as
before, but provides also lockdep coverage of the critical region.
No functional change.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/idr.h        |  5 +----
 include/linux/radix-tree.h |  6 +-----
 lib/radix-tree.c           | 29 ++++++++++++++++++++++-------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index ac6e946b6767b..839da8f2f6f13 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -169,10 +169,7 @@ static inline bool idr_is_empty(const struct idr *idr)
  * Each idr_preload() should be matched with an invocation of this
  * function.  See idr_preload() for details.
  */
-static inline void idr_preload_end(void)
-{
-	preempt_enable();
-}
+void idr_preload_end(void);
=20
 /**
  * idr_for_each_entry() - Iterate over an IDR's elements of a given type.
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 63e62372443a5..040b1fd0ab940 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -226,6 +226,7 @@ unsigned int radix_tree_gang_lookup(const struct radix_=
tree_root *,
 			unsigned int max_items);
 int radix_tree_preload(gfp_t gfp_mask);
 int radix_tree_maybe_preload(gfp_t gfp_mask);
+void radix_tree_preload_end(void);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *,
 			unsigned long index, unsigned int tag);
@@ -243,11 +244,6 @@ unsigned int radix_tree_gang_lookup_tag_slot(const str=
uct radix_tree_root *,
 		unsigned int max_items, unsigned int tag);
 int radix_tree_tagged(const struct radix_tree_root *, unsigned int tag);
=20
-static inline void radix_tree_preload_end(void)
-{
-	preempt_enable();
-}
-
 void __rcu **idr_get_free(struct radix_tree_root *root,
 			      struct radix_tree_iter *iter, gfp_t gfp,
 			      unsigned long max);
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 2ee6ae3b0ade0..609aeb900b550 100644
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
=20
-
 /*
  * Radix tree node cache.
  */
@@ -59,11 +59,14 @@ struct kmem_cache *radix_tree_node_cachep;
  * Per-cpu pool of preloaded nodes
  */
 struct radix_tree_preload {
+	struct local_lock lock;
 	unsigned nr;
 	/* nodes->parent points to next preallocated node */
 	struct radix_tree_node *nodes;
 };
-static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) =3D =
{ 0, };
+static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) =3D
+	{ .lock =3D INIT_LOCAL_LOCK(lock),
+	  .nr =3D 0, };
=20
 static inline struct radix_tree_node *entry_to_node(void *ptr)
 {
@@ -332,14 +335,14 @@ static __must_check int __radix_tree_preload(gfp_t gf=
p_mask, unsigned nr)
 	 */
 	gfp_mask &=3D ~__GFP_ACCOUNT;
=20
-	preempt_disable();
+	local_lock(&radix_tree_preloads.lock);
 	rtp =3D this_cpu_ptr(&radix_tree_preloads);
 	while (rtp->nr < nr) {
-		preempt_enable();
+		local_unlock(&radix_tree_preloads.lock);
 		node =3D kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
 		if (node =3D=3D NULL)
 			goto out;
-		preempt_disable();
+		local_lock(&radix_tree_preloads.lock);
 		rtp =3D this_cpu_ptr(&radix_tree_preloads);
 		if (rtp->nr < nr) {
 			node->parent =3D rtp->nodes;
@@ -381,11 +384,17 @@ int radix_tree_maybe_preload(gfp_t gfp_mask)
 	if (gfpflags_allow_blocking(gfp_mask))
 		return __radix_tree_preload(gfp_mask, RADIX_TREE_PRELOAD_SIZE);
 	/* Preloading doesn't help anything with this gfp mask, skip it */
-	preempt_disable();
+	local_lock(&radix_tree_preloads.lock);
 	return 0;
 }
 EXPORT_SYMBOL(radix_tree_maybe_preload);
=20
+void radix_tree_preload_end(void)
+{
+	local_unlock(&radix_tree_preloads.lock);
+}
+EXPORT_SYMBOL(radix_tree_preload_end);
+
 static unsigned radix_tree_load_root(const struct radix_tree_root *root,
 		struct radix_tree_node **nodep, unsigned long *maxindex)
 {
@@ -1470,10 +1479,16 @@ EXPORT_SYMBOL(radix_tree_tagged);
 void idr_preload(gfp_t gfp_mask)
 {
 	if (__radix_tree_preload(gfp_mask, IDR_PRELOAD_SIZE))
-		preempt_disable();
+		local_lock(&radix_tree_preloads.lock);
 }
 EXPORT_SYMBOL(idr_preload);
=20
+void idr_preload_end(void)
+{
+	local_unlock(&radix_tree_preloads.lock);
+}
+EXPORT_SYMBOL(idr_preload_end);
+
 void __rcu **idr_get_free(struct radix_tree_root *root,
 			      struct radix_tree_iter *iter, gfp_t gfp,
 			      unsigned long max)
--=20
2.27.0.rc0

