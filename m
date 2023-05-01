Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39D56F340C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjEAQ4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjEAQ4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:56:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4801FFD
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:55:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso5005561276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960126; x=1685552126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpAPHCELRqlGyXafm3HOq1DjysfSUkIp0lW71FhLJ+Q=;
        b=KndAV4afZjE7urj1LZ7Rf/o633ajiD8s+Zgf2L1Mk9XX6B/9PMd2nEUVnlftP7GrKt
         bWCCrfLe4oDbYF4trh5h6CFhIJwiPA+kfT/a0Y4OXyPznsVC8TV+5wilPJneaIud8ycS
         FrIUNz8/SFFMagOyadbcqEA0OzG1GIoTXbpA5wGATZUND86MP2J0BOIMLXyxPVqWZ9Wl
         hyCmq22BBXz06DX2ppJBr0xZldtvTeIUTTqyjK3oZrVhnhKWEQyYLcpCxTL3wMg/+F+S
         6FiOvawPLieCpVMV7STZbWNFOnrCi/8x9VUaf5jjtzPaRTlRCN5z85N54yndm8M1FUN8
         3eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960126; x=1685552126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpAPHCELRqlGyXafm3HOq1DjysfSUkIp0lW71FhLJ+Q=;
        b=VU0vR7fyqb7gSfrntcTNdGRERlxNtqyRQW4uioS0Px4fhcub7pEIwTBJ2jJSzj49XZ
         7vvivVRXkRQBv22kGODf8nq7tl/TQWNxlocIjuQVXMxdYvvgMez44qyXJC8nSOfbZ+/e
         9cuBxp+tnIHn+37TGSXyzq6SjbgveSFPn9arp4GxWDqoy5Ut/OfRFvCTu06PtGO8K5Fm
         2zjPb6TxhmP5WAzY9D+wlSU9K1W8pBKmr77kzQdJhvqPBDLGZsJVy5tvulEvQrK+9oRD
         cDaHvmUq4gCDqfYGRKjJ91K+obhtYGdoxDhTb4JYuUDMK+lN3966QeKdO00ILaD2AHX1
         KpHA==
X-Gm-Message-State: AC+VfDwWyf8o4h2CzFUOSR0rKijmS+Cy/TNxEIM9wZIfQtRFCNSaNVTP
        /RXk5l3lETD+Hncfa+ZItTgsnXPY65Y=
X-Google-Smtp-Source: ACHHUZ4pUE1v0mxDvosroh8JeD02p6+n+qSCw+OmLNamZIOJjtYT8dz59YYMSGTncMrJsAgRsN3jwHLs8Lw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:db10:0:b0:b9d:b2ef:1b1e with SMTP id
 g16-20020a25db10000000b00b9db2ef1b1emr2548037ybf.7.1682960126449; Mon, 01 May
 2023 09:55:26 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:18 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-9-surenb@google.com>
Subject: [PATCH 08/40] mm: introduce slabobj_ext to support slab object extensions
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently slab pages can store only vectors of obj_cgroup pointers in
page->memcg_data. Introduce slabobj_ext structure to allow more data
to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
to support current functionality while allowing to extend slabobj_ext
in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/memcontrol.h |  20 +++--
 include/linux/mm_types.h   |   4 +-
 init/Kconfig               |   4 +
 mm/kfence/core.c           |  14 ++--
 mm/kfence/kfence.h         |   4 +-
 mm/memcontrol.c            |  56 ++------------
 mm/page_owner.c            |   2 +-
 mm/slab.h                  | 148 +++++++++++++++++++++++++------------
 mm/slab_common.c           |  47 ++++++++++++
 9 files changed, 185 insertions(+), 114 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 222d7370134c..b9fd9732a52b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -339,8 +339,8 @@ struct mem_cgroup {
 extern struct mem_cgroup *root_mem_cgroup;
 
 enum page_memcg_data_flags {
-	/* page->memcg_data is a pointer to an objcgs vector */
-	MEMCG_DATA_OBJCGS = (1UL << 0),
+	/* page->memcg_data is a pointer to an slabobj_ext vector */
+	MEMCG_DATA_OBJEXTS = (1UL << 0),
 	/* page has been accounted as a non-slab kernel page */
 	MEMCG_DATA_KMEM = (1UL << 1),
 	/* the next bit after the last actual flag */
@@ -378,7 +378,7 @@ static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
 	unsigned long memcg_data = folio->memcg_data;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
 
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
@@ -399,7 +399,7 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
 	unsigned long memcg_data = folio->memcg_data;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
 
 	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
@@ -496,7 +496,7 @@ static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 	 */
 	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
 
-	if (memcg_data & MEMCG_DATA_OBJCGS)
+	if (memcg_data & MEMCG_DATA_OBJEXTS)
 		return NULL;
 
 	if (memcg_data & MEMCG_DATA_KMEM) {
@@ -542,7 +542,7 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 static inline bool folio_memcg_kmem(struct folio *folio)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
-	VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	return folio->memcg_data & MEMCG_DATA_KMEM;
 }
 
@@ -1606,6 +1606,14 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 }
 #endif /* CONFIG_MEMCG */
 
+/*
+ * Extended information for slab objects stored as an array in page->memcg_data
+ * if MEMCG_DATA_OBJEXTS is set.
+ */
+struct slabobj_ext {
+	struct obj_cgroup *objcg;
+} __aligned(8);
+
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
 	__mod_lruvec_kmem_state(p, idx, 1);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..e79303e1e30c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -194,7 +194,7 @@ struct page {
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
 	atomic_t _refcount;
 
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_SLAB_OBJ_EXT
 	unsigned long memcg_data;
 #endif
 
@@ -320,7 +320,7 @@ struct folio {
 			void *private;
 			atomic_t _mapcount;
 			atomic_t _refcount;
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_SLAB_OBJ_EXT
 			unsigned long memcg_data;
 #endif
 	/* private: the union with struct page is transitional */
diff --git a/init/Kconfig b/init/Kconfig
index 32c24950c4ce..44267919a2a2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -936,10 +936,14 @@ config CGROUP_FAVOR_DYNMODS
 
           Say N if unsure.
 
+config SLAB_OBJ_EXT
+	bool
+
 config MEMCG
 	bool "Memory controller"
 	select PAGE_COUNTER
 	select EVENTFD
+	select SLAB_OBJ_EXT
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index dad3c0eb70a0..aea6fa145080 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -590,9 +590,9 @@ static unsigned long kfence_init_pool(void)
 			continue;
 
 		__folio_set_slab(slab_folio(slab));
-#ifdef CONFIG_MEMCG
-		slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
-				   MEMCG_DATA_OBJCGS;
+#ifdef CONFIG_MEMCG_KMEM
+		slab->obj_exts = (unsigned long)&kfence_metadata[i / 2 - 1].obj_exts |
+				 MEMCG_DATA_OBJEXTS;
 #endif
 	}
 
@@ -634,8 +634,8 @@ static unsigned long kfence_init_pool(void)
 
 		if (!i || (i % 2))
 			continue;
-#ifdef CONFIG_MEMCG
-		slab->memcg_data = 0;
+#ifdef CONFIG_MEMCG_KMEM
+		slab->obj_exts = 0;
 #endif
 		__folio_clear_slab(slab_folio(slab));
 	}
@@ -1093,8 +1093,8 @@ void __kfence_free(void *addr)
 {
 	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
 
-#ifdef CONFIG_MEMCG
-	KFENCE_WARN_ON(meta->objcg);
+#ifdef CONFIG_MEMCG_KMEM
+	KFENCE_WARN_ON(meta->obj_exts.objcg);
 #endif
 	/*
 	 * If the objects of the cache are SLAB_TYPESAFE_BY_RCU, defer freeing
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 2aafc46a4aaf..8e0d76c4ea2a 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -97,8 +97,8 @@ struct kfence_metadata {
 	struct kfence_track free_track;
 	/* For updating alloc_covered on frees. */
 	u32 alloc_stack_hash;
-#ifdef CONFIG_MEMCG
-	struct obj_cgroup *objcg;
+#ifdef CONFIG_MEMCG_KMEM
+	struct slabobj_ext obj_exts;
 #endif
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e245a055..f2a7fe718117 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2892,13 +2892,6 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-/*
- * The allocated objcg pointers array is not accounted directly.
- * Moreover, it should not come from DMA buffer and is not readily
- * reclaimable. So those GFP bits should be masked off.
- */
-#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
-
 /*
  * mod_objcg_mlstate() may be called with irq enabled, so
  * mod_memcg_lruvec_state() should be used.
@@ -2917,62 +2910,27 @@ static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
-int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
-				 gfp_t gfp, bool new_slab)
-{
-	unsigned int objects = objs_per_slab(s, slab);
-	unsigned long memcg_data;
-	void *vec;
-
-	gfp &= ~OBJCGS_CLEAR_MASK;
-	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
-			   slab_nid(slab));
-	if (!vec)
-		return -ENOMEM;
-
-	memcg_data = (unsigned long) vec | MEMCG_DATA_OBJCGS;
-	if (new_slab) {
-		/*
-		 * If the slab is brand new and nobody can yet access its
-		 * memcg_data, no synchronization is required and memcg_data can
-		 * be simply assigned.
-		 */
-		slab->memcg_data = memcg_data;
-	} else if (cmpxchg(&slab->memcg_data, 0, memcg_data)) {
-		/*
-		 * If the slab is already in use, somebody can allocate and
-		 * assign obj_cgroups in parallel. In this case the existing
-		 * objcg vector should be reused.
-		 */
-		kfree(vec);
-		return 0;
-	}
-
-	kmemleak_not_leak(vec);
-	return 0;
-}
-
 static __always_inline
 struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 {
 	/*
 	 * Slab objects are accounted individually, not per-page.
 	 * Memcg membership data for each individual object is saved in
-	 * slab->memcg_data.
+	 * slab->obj_exts.
 	 */
 	if (folio_test_slab(folio)) {
-		struct obj_cgroup **objcgs;
+		struct slabobj_ext *obj_exts;
 		struct slab *slab;
 		unsigned int off;
 
 		slab = folio_slab(folio);
-		objcgs = slab_objcgs(slab);
-		if (!objcgs)
+		obj_exts = slab_obj_exts(slab);
+		if (!obj_exts)
 			return NULL;
 
 		off = obj_to_index(slab->slab_cache, slab, p);
-		if (objcgs[off])
-			return obj_cgroup_memcg(objcgs[off]);
+		if (obj_exts[off].objcg)
+			return obj_cgroup_memcg(obj_exts[off].objcg);
 
 		return NULL;
 	}
@@ -2980,7 +2938,7 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 	/*
 	 * folio_memcg_check() is used here, because in theory we can encounter
 	 * a folio where the slab flag has been cleared already, but
-	 * slab->memcg_data has not been freed yet
+	 * slab->obj_exts has not been freed yet
 	 * folio_memcg_check() will guarantee that a proper memory
 	 * cgroup pointer or NULL will be returned.
 	 */
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 31169b3e7f06..8b6086c666e6 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -372,7 +372,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 	if (!memcg_data)
 		goto out_unlock;
 
-	if (memcg_data & MEMCG_DATA_OBJCGS)
+	if (memcg_data & MEMCG_DATA_OBJEXTS)
 		ret += scnprintf(kbuf + ret, count - ret,
 				"Slab cache page\n");
 
diff --git a/mm/slab.h b/mm/slab.h
index f01ac256a8f5..25d14b3a7280 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -57,8 +57,8 @@ struct slab {
 #endif
 
 	atomic_t __page_refcount;
-#ifdef CONFIG_MEMCG
-	unsigned long memcg_data;
+#ifdef CONFIG_SLAB_OBJ_EXT
+	unsigned long obj_exts;
 #endif
 };
 
@@ -67,8 +67,8 @@ struct slab {
 SLAB_MATCH(flags, __page_flags);
 SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
 SLAB_MATCH(_refcount, __page_refcount);
-#ifdef CONFIG_MEMCG
-SLAB_MATCH(memcg_data, memcg_data);
+#ifdef CONFIG_SLAB_OBJ_EXT
+SLAB_MATCH(memcg_data, obj_exts);
 #endif
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
@@ -390,36 +390,106 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 	return false;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_SLAB_OBJ_EXT
+
 /*
- * slab_objcgs - get the object cgroups vector associated with a slab
+ * slab_obj_exts - get the pointer to the slab object extension vector
+ * associated with a slab.
  * @slab: a pointer to the slab struct
  *
- * Returns a pointer to the object cgroups vector associated with the slab,
+ * Returns a pointer to the object extension vector associated with the slab,
  * or NULL if no such vector has been associated yet.
  */
-static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
+static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 {
-	unsigned long memcg_data = READ_ONCE(slab->memcg_data);
+	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
 
-	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS),
+#ifdef CONFIG_MEMCG
+	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS),
 							slab_page(slab));
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, slab_page(slab));
+	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
 
-	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct slabobj_ext *)(obj_exts & ~MEMCG_DATA_FLAGS_MASK);
+#else
+	return (struct slabobj_ext *)obj_exts;
+#endif
 }
 
-int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
-				 gfp_t gfp, bool new_slab);
-void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
-		     enum node_stat_item idx, int nr);
+int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+			gfp_t gfp, bool new_slab);
 
-static inline void memcg_free_slab_cgroups(struct slab *slab)
+static inline bool need_slab_obj_ext(void)
 {
-	kfree(slab_objcgs(slab));
-	slab->memcg_data = 0;
+	/*
+	 * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditionally
+	 * inside memcg_slab_post_alloc_hook. No other users for now.
+	 */
+	return false;
 }
 
+static inline void free_slab_obj_exts(struct slab *slab)
+{
+	struct slabobj_ext *obj_exts;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return;
+
+	kfree(obj_exts);
+	slab->obj_exts = 0;
+}
+
+static inline struct slabobj_ext *
+prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+{
+	struct slab *slab;
+
+	if (!p)
+		return NULL;
+
+	if (!need_slab_obj_ext())
+		return NULL;
+
+	slab = virt_to_slab(p);
+	if (!slab_obj_exts(slab) &&
+	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
+		 "%s, %s: Failed to create slab extension vector!\n",
+		 __func__, s->name))
+		return NULL;
+
+	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
+}
+
+#else /* CONFIG_SLAB_OBJ_EXT */
+
+static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
+{
+	return NULL;
+}
+
+static inline int alloc_slab_obj_exts(struct slab *slab,
+				      struct kmem_cache *s, gfp_t gfp,
+				      bool new_slab)
+{
+	return 0;
+}
+
+static inline void free_slab_obj_exts(struct slab *slab)
+{
+}
+
+static inline struct slabobj_ext *
+prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_SLAB_OBJ_EXT */
+
+#ifdef CONFIG_MEMCG_KMEM
+void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
+		     enum node_stat_item idx, int nr);
+
 static inline size_t obj_full_size(struct kmem_cache *s)
 {
 	/*
@@ -487,16 +557,15 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 		if (likely(p[i])) {
 			slab = virt_to_slab(p[i]);
 
-			if (!slab_objcgs(slab) &&
-			    memcg_alloc_slab_cgroups(slab, s, flags,
-							 false)) {
+			if (!slab_obj_exts(slab) &&
+			    alloc_slab_obj_exts(slab, s, flags, false)) {
 				obj_cgroup_uncharge(objcg, obj_full_size(s));
 				continue;
 			}
 
 			off = obj_to_index(s, slab, p[i]);
 			obj_cgroup_get(objcg);
-			slab_objcgs(slab)[off] = objcg;
+			slab_obj_exts(slab)[off].objcg = objcg;
 			mod_objcg_state(objcg, slab_pgdat(slab),
 					cache_vmstat_idx(s), obj_full_size(s));
 		} else {
@@ -509,14 +578,14 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 					void **p, int objects)
 {
-	struct obj_cgroup **objcgs;
+	struct slabobj_ext *obj_exts;
 	int i;
 
 	if (!memcg_kmem_online())
 		return;
 
-	objcgs = slab_objcgs(slab);
-	if (!objcgs)
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
 		return;
 
 	for (i = 0; i < objects; i++) {
@@ -524,11 +593,11 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 		unsigned int off;
 
 		off = obj_to_index(s, slab, p[i]);
-		objcg = objcgs[off];
+		objcg = obj_exts[off].objcg;
 		if (!objcg)
 			continue;
 
-		objcgs[off] = NULL;
+		obj_exts[off].objcg = NULL;
 		obj_cgroup_uncharge(objcg, obj_full_size(s));
 		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
 				-obj_full_size(s));
@@ -537,27 +606,11 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 }
 
 #else /* CONFIG_MEMCG_KMEM */
-static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
-{
-	return NULL;
-}
-
 static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
 	return NULL;
 }
 
-static inline int memcg_alloc_slab_cgroups(struct slab *slab,
-					       struct kmem_cache *s, gfp_t gfp,
-					       bool new_slab)
-{
-	return 0;
-}
-
-static inline void memcg_free_slab_cgroups(struct slab *slab)
-{
-}
-
 static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 					     struct list_lru *lru,
 					     struct obj_cgroup **objcgp,
@@ -594,7 +647,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
 					 struct kmem_cache *s, gfp_t gfp)
 {
 	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
-		memcg_alloc_slab_cgroups(slab, s, gfp, true);
+		alloc_slab_obj_exts(slab, s, gfp, true);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
@@ -603,8 +656,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
 static __always_inline void unaccount_slab(struct slab *slab, int order,
 					   struct kmem_cache *s)
 {
-	if (memcg_kmem_online())
-		memcg_free_slab_cgroups(slab);
+	free_slab_obj_exts(slab);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
@@ -684,6 +736,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 					unsigned int orig_size)
 {
 	unsigned int zero_size = s->object_size;
+	struct slabobj_ext *obj_exts;
 	size_t i;
 
 	flags &= gfp_allowed_mask;
@@ -714,6 +767,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
 		kmsan_slab_alloc(s, p[i], flags);
+		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 607249785c07..f11cc072b01e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -204,6 +204,53 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 	return NULL;
 }
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+/*
+ * The allocated objcg pointers array is not accounted directly.
+ * Moreover, it should not come from DMA buffer and is not readily
+ * reclaimable. So those GFP bits should be masked off.
+ */
+#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
+
+int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+			gfp_t gfp, bool new_slab)
+{
+	unsigned int objects = objs_per_slab(s, slab);
+	unsigned long obj_exts;
+	void *vec;
+
+	gfp &= ~OBJCGS_CLEAR_MASK;
+	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
+			   slab_nid(slab));
+	if (!vec)
+		return -ENOMEM;
+
+	obj_exts = (unsigned long)vec;
+#ifdef CONFIG_MEMCG
+	obj_exts |= MEMCG_DATA_OBJEXTS;
+#endif
+	if (new_slab) {
+		/*
+		 * If the slab is brand new and nobody can yet access its
+		 * obj_exts, no synchronization is required and obj_exts can
+		 * be simply assigned.
+		 */
+		slab->obj_exts = obj_exts;
+	} else if (cmpxchg(&slab->obj_exts, 0, obj_exts)) {
+		/*
+		 * If the slab is already in use, somebody can allocate and
+		 * assign slabobj_exts in parallel. In this case the existing
+		 * objcg vector should be reused.
+		 */
+		kfree(vec);
+		return 0;
+	}
+
+	kmemleak_not_leak(vec);
+	return 0;
+}
+#endif /* CONFIG_SLAB_OBJ_EXT */
+
 static struct kmem_cache *create_cache(const char *name,
 		unsigned int object_size, unsigned int align,
 		slab_flags_t flags, unsigned int useroffset,
-- 
2.40.1.495.gc816e09b53d-goog

