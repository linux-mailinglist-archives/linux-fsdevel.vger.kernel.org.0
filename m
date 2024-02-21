Return-Path: <linux-fsdevel+bounces-12320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E785E7BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189221C235FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6EC86646;
	Wed, 21 Feb 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xF3R2F0k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF508663F
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544476; cv=none; b=jW1AG6GnnBNIZxoXtyPtMtyzqBcynBHiwcOm316U1fQPIoeKaRcex0wuYmGR2TSA6+y3nFi30+H2Vers6uyt8XY5kdJ8YS1ZM32CYkOdd8dlOnglJoaCjvrqcziN68AdX6KMyB2KzAkYKCJAxKUXdEHgqwTh2SAkrMjOE7FENMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544476; c=relaxed/simple;
	bh=Q89OYd+WcafB3vakvYzPFO7RUfr006gBiXzi0QlLCfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eUsO5ap6RUDlDepGrU3PTopa5Bem+QxdFs26nJwgkfBYsVGO9Jh00YMSeV5QsAUgMAEQtIYGb4MiByUNIPtwfr3a+oC9hHybr5wyiN4Ezfe/GFeU/fCBM3vX3cxQJIoqzoOrETwxSx1xYCvrNxtTQHjf6N4Wx3AxZAJNRH58Pw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xF3R2F0k; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso76002276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544472; x=1709149272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxhfLGit1QGZvv88CDz2b9TMcGpnJbteJyGythFonXg=;
        b=xF3R2F0kirUOWC1TAPmON22Vr3u7vHMv/Rvakla6YqnEsE2UdIJBpc+I1sFvmD3ZtK
         bFQyPe5mSYrpxNwYT/1sQI35t2eOpXfiz7M6x25DqkBhQbPH0fbU+hWLJIJLPfo/Xt2N
         CwwWiJ09M3RTVUCL1gICtx5IDCo9KE/U2aN2L3bftVjwl9xieuOPeJBoIfKa4GhdLwp3
         +J2kLafsB9PaaeQ+1w+4mO2rytPoHCBdT8yEvkP6zFkceMYN183SP3cMyhn5frQe16Ws
         +XUFxoCr091tz/wXMTPsAT7pz8h0N4LEosH7cbZAZ72iARu+cFbzxbB1fxt9qQUO4JVy
         cYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544472; x=1709149272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxhfLGit1QGZvv88CDz2b9TMcGpnJbteJyGythFonXg=;
        b=HkhfyHDmkx0Q3V0qpQuTPTmfP4kKN16bUaqENZw1Ie1+p9eGkbpCoL5xfZyPGykX4E
         0Wg1PTNrvIsb9+hMwIFyoRTAH0N/KYDLGlmt5cW4A6jIRYJf++fCwXcQDSgjiTp+yTkU
         OspnzHbi088V8StoMyDeDHdwvHTsfXlojIKrJL5waLsTo5AYXk8qdtCamAZYLeh8JRmr
         BVeU8SLVHvdmZQj9tCM+Pn1nR/rmwhSc1G0OOGY2bJz+KtXovOd5YnhEp81tQLVgJo/Z
         +RmpSWd8xhTfF3ef9+xmxRZ6nzH2ywBzW6xnkYea6EM0NR/8IDm9JyiPOvHIRGgrJGIm
         yObw==
X-Forwarded-Encrypted: i=1; AJvYcCWTs/pr0sCTDuFmUUfBnim02nXKaVNxGPGeK0ethr5zV9IwWczyh0QNgWyQwyFrh0rFattm/jOQq/7GE/Gp2MfgC47lUWTFjUHbg70wyw==
X-Gm-Message-State: AOJu0YxUdTOmltphCMrB28uz7SwoYsmL3v2RYQ++ue9f+W8bWF4Lvg+5
	OFED4VO4dmNMp6mARKlIxSh2+eU/CVTctOjzyojYbsGSly+MrWA/afN0pr/d+MoLWNLnKWfU6/d
	zUA==
X-Google-Smtp-Source: AGHT+IFHcVmtqPOIGTS9q5X2yZq2RumAgxDeMWYEbPcJp3ccn54KA7yETMVtGjEab6EzCxk/TJs7FGlLDMQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:124b:b0:dc7:7655:46ce with SMTP id
 t11-20020a056902124b00b00dc7765546cemr24975ybu.2.1708544472027; Wed, 21 Feb
 2024 11:41:12 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:20 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-8-surenb@google.com>
Subject: [PATCH v4 07/36] mm: introduce slabobj_ext to support slab object extensions
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently slab pages can store only vectors of obj_cgroup pointers in
page->memcg_data. Introduce slabobj_ext structure to allow more data
to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
to support current functionality while allowing to extend slabobj_ext
in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/memcontrol.h |  20 +++++--
 include/linux/mm_types.h   |   4 +-
 init/Kconfig               |   4 ++
 mm/kfence/core.c           |  14 ++---
 mm/kfence/kfence.h         |   4 +-
 mm/memcontrol.c            |  56 +++----------------
 mm/page_owner.c            |   2 +-
 mm/slab.h                  |  62 +++++++++++++--------
 mm/slub.c                  | 109 +++++++++++++++++++++++++++----------
 9 files changed, 156 insertions(+), 119 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20ff87f8e001..eb1dc181e412 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -348,8 +348,8 @@ struct mem_cgroup {
 extern struct mem_cgroup *root_mem_cgroup;
 
 enum page_memcg_data_flags {
-	/* page->memcg_data is a pointer to an objcgs vector */
-	MEMCG_DATA_OBJCGS = (1UL << 0),
+	/* page->memcg_data is a pointer to an slabobj_ext vector */
+	MEMCG_DATA_OBJEXTS = (1UL << 0),
 	/* page has been accounted as a non-slab kernel page */
 	MEMCG_DATA_KMEM = (1UL << 1),
 	/* the next bit after the last actual flag */
@@ -387,7 +387,7 @@ static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
 	unsigned long memcg_data = folio->memcg_data;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
 
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
@@ -408,7 +408,7 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
 	unsigned long memcg_data = folio->memcg_data;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
 
 	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
@@ -505,7 +505,7 @@ static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 	 */
 	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
 
-	if (memcg_data & MEMCG_DATA_OBJCGS)
+	if (memcg_data & MEMCG_DATA_OBJEXTS)
 		return NULL;
 
 	if (memcg_data & MEMCG_DATA_KMEM) {
@@ -551,7 +551,7 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 static inline bool folio_memcg_kmem(struct folio *folio)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
-	VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	return folio->memcg_data & MEMCG_DATA_KMEM;
 }
 
@@ -1633,6 +1633,14 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
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
index 8b611e13153e..9ff97f4e74c5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -169,7 +169,7 @@ struct page {
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
 	atomic_t _refcount;
 
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_SLAB_OBJ_EXT
 	unsigned long memcg_data;
 #endif
 
@@ -306,7 +306,7 @@ struct folio {
 			};
 			atomic_t _mapcount;
 			atomic_t _refcount;
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_SLAB_OBJ_EXT
 			unsigned long memcg_data;
 #endif
 #if defined(WANT_PAGE_VIRTUAL)
diff --git a/init/Kconfig b/init/Kconfig
index 8426d59cc634..fe5f5e75bd3f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -929,6 +929,9 @@ config NUMA_BALANCING_DEFAULT_ENABLED
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.
 
+config SLAB_OBJ_EXT
+	bool
+
 menuconfig CGROUPS
 	bool "Control Group support"
 	select KERNFS
@@ -962,6 +965,7 @@ config MEMCG
 	bool "Memory controller"
 	select PAGE_COUNTER
 	select EVENTFD
+	select SLAB_OBJ_EXT
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 8350f5c06f2e..964b8482275b 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -595,9 +595,9 @@ static unsigned long kfence_init_pool(void)
 			continue;
 
 		__folio_set_slab(slab_folio(slab));
-#ifdef CONFIG_MEMCG
-		slab->memcg_data = (unsigned long)&kfence_metadata_init[i / 2 - 1].objcg |
-				   MEMCG_DATA_OBJCGS;
+#ifdef CONFIG_MEMCG_KMEM
+		slab->obj_exts = (unsigned long)&kfence_metadata_init[i / 2 - 1].obj_exts |
+				 MEMCG_DATA_OBJEXTS;
 #endif
 	}
 
@@ -645,8 +645,8 @@ static unsigned long kfence_init_pool(void)
 
 		if (!i || (i % 2))
 			continue;
-#ifdef CONFIG_MEMCG
-		slab->memcg_data = 0;
+#ifdef CONFIG_MEMCG_KMEM
+		slab->obj_exts = 0;
 #endif
 		__folio_clear_slab(slab_folio(slab));
 	}
@@ -1139,8 +1139,8 @@ void __kfence_free(void *addr)
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
index f46fbb03062b..084f5f36e8e7 100644
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
index 1ed40f9d3a27..7021639d2a6f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2977,13 +2977,6 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-/*
- * The allocated objcg pointers array is not accounted directly.
- * Moreover, it should not come from DMA buffer and is not readily
- * reclaimable. So those GFP bits should be masked off.
- */
-#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
-				 __GFP_ACCOUNT | __GFP_NOFAIL)
 
 /*
  * mod_objcg_mlstate() may be called with irq enabled, so
@@ -3003,62 +2996,27 @@ static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
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
@@ -3066,7 +3024,7 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 	/*
 	 * folio_memcg_check() is used here, because in theory we can encounter
 	 * a folio where the slab flag has been cleared already, but
-	 * slab->memcg_data has not been freed yet
+	 * slab->obj_exts has not been freed yet
 	 * folio_memcg_check() will guarantee that a proper memory
 	 * cgroup pointer or NULL will be returned.
 	 */
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 5634e5d890f8..262aa7d25f40 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -377,7 +377,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 	if (!memcg_data)
 		goto out_unlock;
 
-	if (memcg_data & MEMCG_DATA_OBJCGS)
+	if (memcg_data & MEMCG_DATA_OBJEXTS)
 		ret += scnprintf(kbuf + ret, count - ret,
 				"Slab cache page\n");
 
diff --git a/mm/slab.h b/mm/slab.h
index 54deeb0428c6..7f19b0a2acd8 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -87,8 +87,8 @@ struct slab {
 	unsigned int __unused;
 
 	atomic_t __page_refcount;
-#ifdef CONFIG_MEMCG
-	unsigned long memcg_data;
+#ifdef CONFIG_SLAB_OBJ_EXT
+	unsigned long obj_exts;
 #endif
 };
 
@@ -97,8 +97,8 @@ struct slab {
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
@@ -541,42 +541,60 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
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
-#else /* CONFIG_MEMCG_KMEM */
-static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
+int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+			gfp_t gfp, bool new_slab);
+
+#else /* CONFIG_SLAB_OBJ_EXT */
+
+static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 {
 	return NULL;
 }
 
-static inline int memcg_alloc_slab_cgroups(struct slab *slab,
-					       struct kmem_cache *s, gfp_t gfp,
-					       bool new_slab)
+static inline int alloc_slab_obj_exts(struct slab *slab,
+				      struct kmem_cache *s, gfp_t gfp,
+				      bool new_slab)
 {
 	return 0;
 }
-#endif /* CONFIG_MEMCG_KMEM */
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
+#endif
 
 size_t __ksize(const void *objp);
 
diff --git a/mm/slub.c b/mm/slub.c
index d31b03a8d9d5..76fb600fbc80 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -683,10 +683,10 @@ static inline bool __slab_update_freelist(struct kmem_cache *s, struct slab *sla
 
 	if (s->flags & __CMPXCHG_DOUBLE) {
 		ret = __update_freelist_fast(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
+					    freelist_new, counters_new);
 	} else {
 		ret = __update_freelist_slow(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
+					    freelist_new, counters_new);
 	}
 	if (likely(ret))
 		return true;
@@ -710,13 +710,13 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
 
 	if (s->flags & __CMPXCHG_DOUBLE) {
 		ret = __update_freelist_fast(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
+					    freelist_new, counters_new);
 	} else {
 		unsigned long flags;
 
 		local_irq_save(flags);
 		ret = __update_freelist_slow(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
+					     freelist_new, counters_new);
 		local_irq_restore(flags);
 	}
 	if (likely(ret))
@@ -1881,13 +1881,72 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
-static inline void memcg_free_slab_cgroups(struct slab *slab)
+#ifdef CONFIG_SLAB_OBJ_EXT
+
+/*
+ * The allocated objcg pointers array is not accounted directly.
+ * Moreover, it should not come from DMA buffer and is not readily
+ * reclaimable. So those GFP bits should be masked off.
+ */
+#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
+				__GFP_ACCOUNT | __GFP_NOFAIL)
+
+int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+			gfp_t gfp, bool new_slab)
 {
-	kfree(slab_objcgs(slab));
-	slab->memcg_data = 0;
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
+#else /* CONFIG_SLAB_OBJ_EXT */
+static inline void free_slab_obj_exts(struct slab *slab)
+{
+}
+#endif /* CONFIG_SLAB_OBJ_EXT */
+
+#ifdef CONFIG_MEMCG_KMEM
 static inline size_t obj_full_size(struct kmem_cache *s)
 {
 	/*
@@ -1966,15 +2025,15 @@ static void __memcg_slab_post_alloc_hook(struct kmem_cache *s,
 		if (likely(p[i])) {
 			slab = virt_to_slab(p[i]);
 
-			if (!slab_objcgs(slab) &&
-			    memcg_alloc_slab_cgroups(slab, s, flags, false)) {
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
@@ -1995,18 +2054,18 @@ void memcg_slab_post_alloc_hook(struct kmem_cache *s, struct obj_cgroup *objcg,
 
 static void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 				   void **p, int objects,
-				   struct obj_cgroup **objcgs)
+				   struct slabobj_ext *obj_exts)
 {
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
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
@@ -2018,16 +2077,16 @@ static __fastpath_inline
 void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			  int objects)
 {
-	struct obj_cgroup **objcgs;
+	struct slabobj_ext *obj_exts;
 
 	if (!memcg_kmem_online())
 		return;
 
-	objcgs = slab_objcgs(slab);
-	if (likely(!objcgs))
+	obj_exts = slab_obj_exts(slab);
+	if (likely(!obj_exts))
 		return;
 
-	__memcg_slab_free_hook(s, slab, p, objects, objcgs);
+	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
 }
 
 static inline
@@ -2038,15 +2097,6 @@ void memcg_slab_alloc_error_hook(struct kmem_cache *s, int objects,
 		obj_cgroup_uncharge(objcg, objects * obj_full_size(s));
 }
 #else /* CONFIG_MEMCG_KMEM */
-static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
-{
-	return NULL;
-}
-
-static inline void memcg_free_slab_cgroups(struct slab *slab)
-{
-}
-
 static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 					     struct list_lru *lru,
 					     struct obj_cgroup **objcgp,
@@ -2314,7 +2364,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
 					 struct kmem_cache *s, gfp_t gfp)
 {
 	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
-		memcg_alloc_slab_cgroups(slab, s, gfp, true);
+		alloc_slab_obj_exts(slab, s, gfp, true);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
@@ -2323,8 +2373,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
 static __always_inline void unaccount_slab(struct slab *slab, int order,
 					   struct kmem_cache *s)
 {
-	if (memcg_kmem_online())
-		memcg_free_slab_cgroups(slab);
+	free_slab_obj_exts(slab);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
-- 
2.44.0.rc0.258.g7320e95886-goog


