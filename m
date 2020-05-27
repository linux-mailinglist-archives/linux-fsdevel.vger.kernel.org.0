Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99D31E4EF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgE0ULx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 16:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgE0ULw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 16:11:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CFEC03E96E;
        Wed, 27 May 2020 13:11:52 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1je2Ob-0005ku-65; Wed, 27 May 2020 22:11:25 +0200
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
Subject: [PATCH v3 2/7] radix-tree: Use local_lock for protection
Date:   Wed, 27 May 2020 22:11:14 +0200
Message-Id: <20200527201119.1692513-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200527201119.1692513-1-bigeasy@linutronix.de>
References: <20200527201119.1692513-1-bigeasy@linutronix.de>
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
 include/linux/idr.h        |  2 +-
 include/linux/radix-tree.h | 11 ++++++++++-
 lib/radix-tree.c           | 20 +++++++++-----------
 3 files changed, 20 insertions(+), 13 deletions(-)

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
=20
 /**
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 63e62372443a5..c2a9f7c907273 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -16,11 +16,20 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
+#include <linux/local_lock.h>
=20
 /* Keep unconverted code working */
 #define radix_tree_root		xarray
 #define radix_tree_node		xa_node
=20
+struct radix_tree_preload {
+	local_lock_t lock;
+	unsigned nr;
+	/* nodes->parent points to next preallocated node */
+	struct radix_tree_node *nodes;
+};
+DECLARE_PER_CPU(struct radix_tree_preload, radix_tree_preloads);
+
 /*
  * The bottom two bits of the slot determine how the remaining bits in the
  * slot are interpreted:
@@ -245,7 +254,7 @@ int radix_tree_tagged(const struct radix_tree_root *, u=
nsigned int tag);
=20
 static inline void radix_tree_preload_end(void)
 {
-	preempt_enable();
+	local_unlock(&radix_tree_preloads.lock);
 }
=20
 void __rcu **idr_get_free(struct radix_tree_root *root,
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 2ee6ae3b0ade0..34e406fe561fe 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
 #include <linux/percpu.h>
+#include <linux/local_lock.h>
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
@@ -58,12 +58,10 @@ struct kmem_cache *radix_tree_node_cachep;
 /*
  * Per-cpu pool of preloaded nodes
  */
-struct radix_tree_preload {
-	unsigned nr;
-	/* nodes->parent points to next preallocated node */
-	struct radix_tree_node *nodes;
+DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) =3D {
+	.lock =3D INIT_LOCAL_LOCK(lock),
 };
-static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) =3D =
{ 0, };
+EXPORT_PER_CPU_SYMBOL_GPL(radix_tree_preloads);
=20
 static inline struct radix_tree_node *entry_to_node(void *ptr)
 {
@@ -332,14 +330,14 @@ static __must_check int __radix_tree_preload(gfp_t gf=
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
=20
--=20
2.27.0.rc0

