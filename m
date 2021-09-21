Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4B413D77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 00:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhIUWWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 18:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhIUWWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:22:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B4FC061574;
        Tue, 21 Sep 2021 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pvLN95VPWUgoqDAJHBd1gtIpJW6KmIbM0QlEGJtyYkg=; b=dFoql8Ztpfxx0o4klhr4Tg2cHK
        qQEElobBDALjhA79xcVdSgts5jM7u85FJiqyOpRuiRbk18EGpdC6w5x/xl9w5non9wl4+dHMYYACh
        aluCB53ZweSVLl6/BMA6m5vkHeDMlsET8YEGEfo++cJLwx96ccpYQ2/EaKyBvPtJE1g0qJBFXZdzt
        KPlP4hHLo6YuHdRD2nvmiZX/ShPq0WlRi+LMgWNoTJXxZ5BExPwHTsPmwRUUptg6g0b2lrHDtf2pa
        slUpI+sqU4Kk2uUP8NzuHGHetbQ5uKvqZFsvx953g4U9SfnUB9eW4rQ1+peAahyD6UmIkYa7cxDl2
        lMEwV1kQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSo6G-004EYV-MT; Tue, 21 Sep 2021 22:19:00 +0000
Date:   Tue, 21 Sep 2021 23:18:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUpaTBJ/Jhz15S6a@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUpKbWDYqRB6eBV+@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:11:09PM -0400, Kent Overstreet wrote:
> On Tue, Sep 21, 2021 at 09:38:54PM +0100, Matthew Wilcox wrote:
> > On Tue, Sep 21, 2021 at 03:47:29PM -0400, Johannes Weiner wrote:
> > > and so the justification for replacing page with folio *below* those
> > > entry points to address tailpage confusion becomes nil: there is no
> > > confusion. Move the anon bits to anon_page and leave the shared bits
> > > in page. That's 912 lines of swap_state.c we could mostly leave alone.
> > 
> > Your argument seems to be based on "minimising churn".  Which is certainly
> > a goal that one could have, but I think in this case is actually harmful.
> > There are hundreds, maybe thousands, of functions throughout the kernel
> > (certainly throughout filesystems) which assume that a struct page is
> > PAGE_SIZE bytes.  Yes, every single one of them is buggy to assume that,
> > but tracking them all down is a never-ending task as new ones will be
> > added as fast as they can be removed.
> 
> Yet it's only file backed pages that are actually changing in behaviour right
> now - folios don't _have_ to be the tool to fix that elsewhere, for anon, for
> network pools, for slab.

The point (I think) Johannes is making is that some of the patches in
this series touch code paths which are used by both anon and file pages.
And it's those he's objecting to.

> > If you want to try your hand at splitting out anon_folio from folio
> > later, be my guest.  I've just finished splitting out 'slab' from page,
> > and I'll post it later.  I don't think that splitting anon_folio from
> > folio is worth doing, but will not stand in your way.  I do think that
> > splitting tail pages from non-tail pages is worthwhile, and that's what
> > this patchset does.
> 
> Eesh, we can and should hold ourselves to a higher standard in our technical
> discussions.
> 
> Let's not let past misfourtune (and yes, folios missing 5.15 _was_ unfortunate
> and shouldn't have happened) colour our perceptions and keep us from having
> productive working relationships going forward. The points Johannes is bringing
> up are valid and pertinent and deserve to be discussed.
> 
> If you're still trying to sell folios as the be all, end all solution for
> anything using compound pages, I think you should be willing to make the
> argument that that really is the _right_ solution - not just that it was the one
> easiest for you to implement.

Starting from the principle that the type of a pointer should never be
wrong, GUP can convert from a PTE to a struct page.  We need a name for
the head page that GUP converts to, and my choice for that name is folio.
A folio needs a refcount, a lock bit and a dirty bit.

By the way, I think I see a path to:

struct page {
	unsigned long compound_head;
};

which will reduce the overhead of struct page from 64 bytes to 8.
That should solve one of Johannes' problems.

> Actual code might make this discussion more concrete and clearer. Could you post
> your slab conversion?

It's a bit big and deserves to be split into multiple patches.
It's on top of folio-5.15.  It also only really works for SLUB right
now; CONFIG_SLAB doesn't compile yet.  It does pass xfstests with
CONFIG_SLUB ;-)

I'm not entirely convinced I've done the right thing with
page_memcg_check().  There's probably other things wrong with it,
I was banging it out during gaps between sessions at Plumbers.

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ddeaba947eb3..5f3d2efeb88b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -981,7 +981,7 @@ static void __meminit free_pagetable(struct page *page, int order)
 	if (PageReserved(page)) {
 		__ClearPageReserved(page);
 
-		magic = (unsigned long)page->freelist;
+		magic = page->index;
 		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
 			while (nr_pages--)
 				put_page_bootmem(page++);
diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 2bc8b1f69c93..cc35d010fa94 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -30,7 +30,7 @@ void put_page_bootmem(struct page *page);
  */
 static inline void free_bootmem_page(struct page *page)
 {
-	unsigned long magic = (unsigned long)page->freelist;
+	unsigned long magic = page->index;
 
 	/*
 	 * The reserve_bootmem_region sets the reserved flag on bootmem
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index dd874a1ee862..59c860295618 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -188,11 +188,11 @@ static __always_inline size_t kasan_metadata_size(struct kmem_cache *cache)
 	return 0;
 }
 
-void __kasan_poison_slab(struct page *page);
-static __always_inline void kasan_poison_slab(struct page *page)
+void __kasan_poison_slab(struct slab *slab);
+static __always_inline void kasan_poison_slab(struct slab *slab)
 {
 	if (kasan_enabled())
-		__kasan_poison_slab(page);
+		__kasan_poison_slab(slab);
 }
 
 void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
@@ -317,7 +317,7 @@ static inline void kasan_cache_create(struct kmem_cache *cache,
 				      slab_flags_t *flags) {}
 static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
-static inline void kasan_poison_slab(struct page *page) {}
+static inline void kasan_poison_slab(struct slab *slab) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
 					void *object) {}
 static inline void kasan_poison_object_data(struct kmem_cache *cache,
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 562b27167c9e..1c0b3b95bdd7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -546,41 +546,39 @@ static inline bool folio_memcg_kmem(struct folio *folio)
 }
 
 /*
- * page_objcgs - get the object cgroups vector associated with a page
- * @page: a pointer to the page struct
+ * slab_objcgs - get the object cgroups vector associated with a slab
+ * @slab: a pointer to the slab struct
  *
- * Returns a pointer to the object cgroups vector associated with the page,
- * or NULL. This function assumes that the page is known to have an
- * associated object cgroups vector. It's not safe to call this function
- * against pages, which might have an associated memory cgroup: e.g.
- * kernel stack pages.
+ * Returns a pointer to the object cgroups vector associated with the slab,
+ * or NULL. This function assumes that the slab is known to have an
+ * associated object cgroups vector.
  */
-static inline struct obj_cgroup **page_objcgs(struct page *page)
+static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
 {
-	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+	unsigned long memcg_data = READ_ONCE(slab->memcg_data);
 
-	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS), page);
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
+	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS), &slab->page);
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, &slab->page);
 
 	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
 /*
- * page_objcgs_check - get the object cgroups vector associated with a page
- * @page: a pointer to the page struct
+ * slab_objcgs_check - get the object cgroups vector associated with a slab
+ * @slab: a pointer to the slab struct
  *
- * Returns a pointer to the object cgroups vector associated with the page,
- * or NULL. This function is safe to use if the page can be directly associated
+ * Returns a pointer to the object cgroups vector associated with the slab,
+ * or NULL. This function is safe to use if the slab can be directly associated
  * with a memory cgroup.
  */
-static inline struct obj_cgroup **page_objcgs_check(struct page *page)
+static inline struct obj_cgroup **slab_objcgs_check(struct slab *slab)
 {
-	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+	unsigned long memcg_data = READ_ONCE(slab->memcg_data);
 
 	if (!memcg_data || !(memcg_data & MEMCG_DATA_OBJCGS))
 		return NULL;
 
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, &slab->page);
 
 	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
@@ -591,12 +589,12 @@ static inline bool folio_memcg_kmem(struct folio *folio)
 	return false;
 }
 
-static inline struct obj_cgroup **page_objcgs(struct page *page)
+static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
 {
 	return NULL;
 }
 
-static inline struct obj_cgroup **page_objcgs_check(struct page *page)
+static inline struct obj_cgroup **slab_objcgs_check(struct slab *slab)
 {
 	return NULL;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1066afc9a06d..6db4d64ebe6d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -109,33 +109,6 @@ struct page {
 			 */
 			unsigned long dma_addr[2];
 		};
-		struct {	/* slab, slob and slub */
-			union {
-				struct list_head slab_list;
-				struct {	/* Partial pages */
-					struct page *next;
-#ifdef CONFIG_64BIT
-					int pages;	/* Nr of pages left */
-					int pobjects;	/* Approximate count */
-#else
-					short int pages;
-					short int pobjects;
-#endif
-				};
-			};
-			struct kmem_cache *slab_cache; /* not slob */
-			/* Double-word boundary */
-			void *freelist;		/* first free object */
-			union {
-				void *s_mem;	/* slab: first object */
-				unsigned long counters;		/* SLUB */
-				struct {			/* SLUB */
-					unsigned inuse:16;
-					unsigned objects:15;
-					unsigned frozen:1;
-				};
-			};
-		};
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 
@@ -199,9 +172,6 @@ struct page {
 		 * which are currently stored here.
 		 */
 		unsigned int page_type;
-
-		unsigned int active;		/* SLAB */
-		int units;			/* SLOB */
 	};
 
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
@@ -231,6 +201,59 @@ struct page {
 #endif
 } _struct_page_alignment;
 
+struct slab {
+	union {
+		struct {
+			unsigned long flags;
+			union {
+				struct list_head slab_list;
+				struct {	/* Partial pages */
+					struct slab *next;
+#ifdef CONFIG_64BIT
+					int slabs;	/* Nr of slabs left */
+					int pobjects;	/* Approximate count */
+#else
+					short int slabs;
+					short int pobjects;
+#endif
+				};
+			};
+			struct kmem_cache *slab_cache; /* not slob */
+			/* Double-word boundary */
+			void *freelist;		/* first free object */
+			union {
+				void *s_mem;	/* slab: first object */
+				unsigned long counters;		/* SLUB */
+				struct {			/* SLUB */
+					unsigned inuse:16;
+					unsigned objects:15;
+					unsigned frozen:1;
+				};
+			};
+
+			union {
+				unsigned int active;		/* SLAB */
+				int units;			/* SLOB */
+			};
+			atomic_t _refcount;
+#ifdef CONFIG_MEMCG
+			unsigned long memcg_data;
+#endif
+		};
+		struct page page;
+	};
+};
+
+#define SLAB_MATCH(pg, sl)						\
+	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
+SLAB_MATCH(flags, flags);
+SLAB_MATCH(compound_head, slab_list);
+SLAB_MATCH(_refcount, _refcount);
+#ifdef CONFIG_MEMCG
+SLAB_MATCH(memcg_data, memcg_data);
+#endif
+#undef SLAB_MATCH
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b48bc214fe89..a21d14fec973 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -167,6 +167,8 @@ enum pageflags {
 	/* Remapped by swiotlb-xen. */
 	PG_xen_remapped = PG_owner_priv_1,
 
+	/* SLAB / SLUB / SLOB */
+	PG_pfmemalloc = PG_active,
 	/* SLOB */
 	PG_slob_free = PG_private,
 
@@ -193,6 +195,25 @@ static inline unsigned long _compound_head(const struct page *page)
 
 #define compound_head(page)	((typeof(page))_compound_head(page))
 
+/**
+ * page_slab - Converts from page to slab.
+ * @p: The page.
+ *
+ * This function cannot be called on a NULL pointer.  It can be called
+ * on a non-slab page; the caller should check is_slab() to be sure
+ * that the slab really is a slab.
+ *
+ * Return: The slab which contains this page.
+ */
+#define page_slab(p)		(_Generic((p),				\
+	const struct page *:	(const struct slab *)_compound_head(p), \
+	struct page *:		(struct slab *)_compound_head(p)))
+
+static inline bool is_slab(struct slab *slab)
+{
+	return test_bit(PG_slab, &slab->flags);
+}
+
 /**
  * page_folio - Converts from page to folio.
  * @p: The page.
@@ -921,34 +942,6 @@ extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
 
-/*
- * If network-based swap is enabled, sl*b must keep track of whether pages
- * were allocated from pfmemalloc reserves.
- */
-static inline int PageSlabPfmemalloc(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageSlab(page), page);
-	return PageActive(page);
-}
-
-static inline void SetPageSlabPfmemalloc(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageSlab(page), page);
-	SetPageActive(page);
-}
-
-static inline void __ClearPageSlabPfmemalloc(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageSlab(page), page);
-	__ClearPageActive(page);
-}
-
-static inline void ClearPageSlabPfmemalloc(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageSlab(page), page);
-	ClearPageActive(page);
-}
-
 #ifdef CONFIG_MMU
 #define __PG_MLOCKED		(1UL << PG_mlocked)
 #else
diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index 3aa5e1e73ab6..f1bfcb10f5e0 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -87,11 +87,11 @@ struct kmem_cache {
 	struct kmem_cache_node *node[MAX_NUMNODES];
 };
 
-static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
+static inline void *nearest_obj(struct kmem_cache *cache, struct slab *slab,
 				void *x)
 {
-	void *object = x - (x - page->s_mem) % cache->size;
-	void *last_object = page->s_mem + (cache->num - 1) * cache->size;
+	void *object = x - (x - slab->s_mem) % cache->size;
+	void *last_object = slab->s_mem + (cache->num - 1) * cache->size;
 
 	if (unlikely(object > last_object))
 		return last_object;
@@ -106,16 +106,16 @@ static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
  *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
  */
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct page *page, void *obj)
+					const struct slab *slab, void *obj)
 {
-	u32 offset = (obj - page->s_mem);
+	u32 offset = (obj - slab->s_mem);
 	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
 }
 
-static inline int objs_per_slab_page(const struct kmem_cache *cache,
-				     const struct page *page)
+static inline int objs_per_slab(const struct kmem_cache *cache,
+				     const struct slab *slab)
 {
-	if (is_kfence_address(page_address(page)))
+	if (is_kfence_address(slab_address(slab)))
 		return 1;
 	return cache->num;
 }
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index dcde82a4434c..7394c959dc5f 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -43,9 +43,9 @@ enum stat_item {
 struct kmem_cache_cpu {
 	void **freelist;	/* Pointer to next available object */
 	unsigned long tid;	/* Globally unique transaction id */
-	struct page *page;	/* The slab from which we are allocating */
+	struct slab *slab;	/* The slab from which we are allocating */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
-	struct page *partial;	/* Partially allocated frozen slabs */
+	struct slab *partial;	/* Partially allocated frozen slabs */
 #endif
 #ifdef CONFIG_SLUB_STATS
 	unsigned stat[NR_SLUB_STAT_ITEMS];
@@ -159,16 +159,16 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
 }
 #endif
 
-void object_err(struct kmem_cache *s, struct page *page,
+void object_err(struct kmem_cache *s, struct slab *slab,
 		u8 *object, char *reason);
 
 void *fixup_red_left(struct kmem_cache *s, void *p);
 
-static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
+static inline void *nearest_obj(struct kmem_cache *cache, struct slab *slab,
 				void *x) {
-	void *object = x - (x - page_address(page)) % cache->size;
-	void *last_object = page_address(page) +
-		(page->objects - 1) * cache->size;
+	void *object = x - (x - slab_address(slab)) % cache->size;
+	void *last_object = slab_address(slab) +
+		(slab->objects - 1) * cache->size;
 	void *result = (unlikely(object > last_object)) ? last_object : object;
 
 	result = fixup_red_left(cache, result);
@@ -184,16 +184,16 @@ static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
 }
 
 static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct page *page, void *obj)
+					const struct slab *slab, void *obj)
 {
 	if (is_kfence_address(obj))
 		return 0;
-	return __obj_to_index(cache, page_address(page), obj);
+	return __obj_to_index(cache, slab_address(slab), obj);
 }
 
-static inline int objs_per_slab_page(const struct kmem_cache *cache,
-				     const struct page *page)
+static inline int objs_per_slab(const struct kmem_cache *cache,
+				     const struct slab *slab)
 {
-	return page->objects;
+	return slab->objects;
 }
 #endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 5b152dba7344..cf8f62c59b0a 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -15,7 +15,7 @@
 
 void get_page_bootmem(unsigned long info, struct page *page, unsigned long type)
 {
-	page->freelist = (void *)type;
+	page->index = type;
 	SetPagePrivate(page);
 	set_page_private(page, info);
 	page_ref_inc(page);
@@ -23,14 +23,13 @@ void get_page_bootmem(unsigned long info, struct page *page, unsigned long type)
 
 void put_page_bootmem(struct page *page)
 {
-	unsigned long type;
+	unsigned long type = page->index;
 
-	type = (unsigned long) page->freelist;
 	BUG_ON(type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
 	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
 
 	if (page_ref_dec_return(page) == 1) {
-		page->freelist = NULL;
+		page->index = 0;
 		ClearPagePrivate(page);
 		set_page_private(page, 0);
 		INIT_LIST_HEAD(&page->lru);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2baf121fb8c5..a8b9a7822b9f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -247,8 +247,9 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 }
 #endif
 
-void __kasan_poison_slab(struct page *page)
+void __kasan_poison_slab(struct slab *slab)
 {
+	struct page *page = &slab->page;
 	unsigned long i;
 
 	for (i = 0; i < compound_nr(page); i++)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c954fda9d7f4..c21b9a63fb4a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2842,16 +2842,16 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
  */
 #define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
 
-int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
+int memcg_alloc_slab_obj_cgroups(struct slab *slab, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page)
 {
-	unsigned int objects = objs_per_slab_page(s, page);
+	unsigned int objects = objs_per_slab(s, slab);
 	unsigned long memcg_data;
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
-			   page_to_nid(page));
+			   slab_nid(slab));
 	if (!vec)
 		return -ENOMEM;
 
@@ -2862,8 +2862,8 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 		 * it's memcg_data, no synchronization is required and
 		 * memcg_data can be simply assigned.
 		 */
-		page->memcg_data = memcg_data;
-	} else if (cmpxchg(&page->memcg_data, 0, memcg_data)) {
+		slab->memcg_data = memcg_data;
+	} else if (cmpxchg(&slab->memcg_data, 0, memcg_data)) {
 		/*
 		 * If the slab page is already in use, somebody can allocate
 		 * and assign obj_cgroups in parallel. In this case the existing
@@ -2891,38 +2891,39 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
  */
 struct mem_cgroup *mem_cgroup_from_obj(void *p)
 {
-	struct page *page;
+	struct slab *slab;
 
 	if (mem_cgroup_disabled())
 		return NULL;
 
-	page = virt_to_head_page(p);
+	slab = virt_to_slab(p);
 
 	/*
 	 * Slab objects are accounted individually, not per-page.
 	 * Memcg membership data for each individual object is saved in
-	 * the page->obj_cgroups.
+	 * the slab->obj_cgroups.
 	 */
-	if (page_objcgs_check(page)) {
+	if (slab_objcgs_check(slab)) {
 		struct obj_cgroup *objcg;
 		unsigned int off;
 
-		off = obj_to_index(page->slab_cache, page, p);
-		objcg = page_objcgs(page)[off];
+		off = obj_to_index(slab->slab_cache, slab, p);
+		objcg = slab_objcgs(slab)[off];
 		if (objcg)
 			return obj_cgroup_memcg(objcg);
 
 		return NULL;
 	}
 
+	/* I am pretty sure this is wrong */
 	/*
-	 * page_memcg_check() is used here, because page_has_obj_cgroups()
+	 * page_memcg_check() is used here, because slab_has_obj_cgroups()
 	 * check above could fail because the object cgroups vector wasn't set
 	 * at that moment, but it can be set concurrently.
-	 * page_memcg_check(page) will guarantee that a proper memory
+	 * page_memcg_check() will guarantee that a proper memory
 	 * cgroup pointer or NULL will be returned.
 	 */
-	return page_memcg_check(page);
+	return page_memcg_check(&slab->page);
 }
 
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
diff --git a/mm/slab.h b/mm/slab.h
index f997fd5e42c8..1c6311fd7060 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -5,6 +5,69 @@
  * Internal slab definitions
  */
 
+static inline void *slab_address(const struct slab *slab)
+{
+	return page_address(&slab->page);
+}
+
+static inline struct pglist_data *slab_pgdat(const struct slab *slab)
+{
+	return page_pgdat(&slab->page);
+}
+
+static inline int slab_nid(const struct slab *slab)
+{
+	return page_to_nid(&slab->page);
+}
+
+static inline struct slab *virt_to_slab(const void *addr)
+{
+	struct page *page = virt_to_page(addr);
+
+	return page_slab(page);
+}
+
+static inline bool SlabMulti(const struct slab *slab)
+{
+	return test_bit(PG_head, &slab->flags);
+}
+
+static inline int slab_order(const struct slab *slab)
+{
+	if (!SlabMulti(slab))
+		return 0;
+	return (&slab->page)[1].compound_order;
+}
+
+static inline size_t slab_size(const struct slab *slab)
+{
+	return PAGE_SIZE << slab_order(slab);
+}
+
+/*
+ * If network-based swap is enabled, sl*b must keep track of whether pages
+ * were allocated from pfmemalloc reserves.
+ */
+static inline bool SlabPfmemalloc(const struct slab *slab)
+{
+	return test_bit(PG_pfmemalloc, &slab->flags);
+}
+
+static inline void SetSlabPfmemalloc(struct slab *slab)
+{
+	set_bit(PG_pfmemalloc, &slab->flags);
+}
+
+static inline void __ClearSlabPfmemalloc(struct slab *slab)
+{
+	__clear_bit(PG_pfmemalloc, &slab->flags);
+}
+
+static inline void ClearSlabPfmemalloc(struct slab *slab)
+{
+	clear_bit(PG_pfmemalloc, &slab->flags);
+}
+
 #ifdef CONFIG_SLOB
 /*
  * Common fields provided in kmem_cache by all slab allocators
@@ -245,15 +308,15 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
+int memcg_alloc_slab_obj_cgroups(struct slab *slab, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page);
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr);
 
-static inline void memcg_free_page_obj_cgroups(struct page *page)
+static inline void memcg_free_slab_obj_cgroups(struct slab *slab)
 {
-	kfree(page_objcgs(page));
-	page->memcg_data = 0;
+	kfree(slab_objcgs(slab));
+	slab->memcg_data = 0;
 }
 
 static inline size_t obj_full_size(struct kmem_cache *s)
@@ -298,7 +361,7 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      gfp_t flags, size_t size,
 					      void **p)
 {
-	struct page *page;
+	struct slab *slab;
 	unsigned long off;
 	size_t i;
 
@@ -307,19 +370,19 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 
 	for (i = 0; i < size; i++) {
 		if (likely(p[i])) {
-			page = virt_to_head_page(p[i]);
+			slab = virt_to_slab(p[i]);
 
-			if (!page_objcgs(page) &&
-			    memcg_alloc_page_obj_cgroups(page, s, flags,
+			if (!slab_objcgs(slab) &&
+			    memcg_alloc_slab_obj_cgroups(slab, s, flags,
 							 false)) {
 				obj_cgroup_uncharge(objcg, obj_full_size(s));
 				continue;
 			}
 
-			off = obj_to_index(s, page, p[i]);
+			off = obj_to_index(s, slab, p[i]);
 			obj_cgroup_get(objcg);
-			page_objcgs(page)[off] = objcg;
-			mod_objcg_state(objcg, page_pgdat(page),
+			slab_objcgs(slab)[off] = objcg;
+			mod_objcg_state(objcg, slab_pgdat(slab),
 					cache_vmstat_idx(s), obj_full_size(s));
 		} else {
 			obj_cgroup_uncharge(objcg, obj_full_size(s));
@@ -334,7 +397,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
 	struct kmem_cache *s;
 	struct obj_cgroup **objcgs;
 	struct obj_cgroup *objcg;
-	struct page *page;
+	struct slab *slab;
 	unsigned int off;
 	int i;
 
@@ -345,24 +408,24 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
 		if (unlikely(!p[i]))
 			continue;
 
-		page = virt_to_head_page(p[i]);
-		objcgs = page_objcgs(page);
+		slab = virt_to_slab(p[i]);
+		objcgs = slab_objcgs(slab);
 		if (!objcgs)
 			continue;
 
 		if (!s_orig)
-			s = page->slab_cache;
+			s = slab->slab_cache;
 		else
 			s = s_orig;
 
-		off = obj_to_index(s, page, p[i]);
+		off = obj_to_index(s, slab, p[i]);
 		objcg = objcgs[off];
 		if (!objcg)
 			continue;
 
 		objcgs[off] = NULL;
 		obj_cgroup_uncharge(objcg, obj_full_size(s));
-		mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
+		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
 				-obj_full_size(s));
 		obj_cgroup_put(objcg);
 	}
@@ -374,14 +437,14 @@ static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 	return NULL;
 }
 
-static inline int memcg_alloc_page_obj_cgroups(struct page *page,
+static inline int memcg_alloc_slab_obj_cgroups(struct slab *slab,
 					       struct kmem_cache *s, gfp_t gfp,
 					       bool new_page)
 {
 	return 0;
 }
 
-static inline void memcg_free_page_obj_cgroups(struct page *page)
+static inline void memcg_free_slab_obj_cgroups(struct slab *slab)
 {
 }
 
@@ -407,33 +470,33 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s,
 
 static inline struct kmem_cache *virt_to_cache(const void *obj)
 {
-	struct page *page;
+	struct slab *slab;
 
-	page = virt_to_head_page(obj);
-	if (WARN_ONCE(!PageSlab(page), "%s: Object is not a Slab page!\n",
+	slab = virt_to_slab(obj);
+	if (WARN_ONCE(!is_slab(slab), "%s: Object is not a Slab page!\n",
 					__func__))
 		return NULL;
-	return page->slab_cache;
+	return slab->slab_cache;
 }
 
-static __always_inline void account_slab_page(struct page *page, int order,
+static __always_inline void account_slab(struct slab *slab, int order,
 					      struct kmem_cache *s,
 					      gfp_t gfp)
 {
 	if (memcg_kmem_enabled() && (s->flags & SLAB_ACCOUNT))
-		memcg_alloc_page_obj_cgroups(page, s, gfp, true);
+		memcg_alloc_slab_obj_cgroups(slab, s, gfp, true);
 
-	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
+	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
 }
 
-static __always_inline void unaccount_slab_page(struct page *page, int order,
+static __always_inline void unaccount_slab(struct slab *slab, int order,
 						struct kmem_cache *s)
 {
 	if (memcg_kmem_enabled())
-		memcg_free_page_obj_cgroups(page);
+		memcg_free_slab_obj_cgroups(slab);
 
-	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
+	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
 }
 
@@ -635,7 +698,7 @@ static inline void debugfs_slab_release(struct kmem_cache *s) { }
 #define KS_ADDRS_COUNT 16
 struct kmem_obj_info {
 	void *kp_ptr;
-	struct page *kp_page;
+	struct slab *kp_slab;
 	void *kp_objp;
 	unsigned long kp_data_offset;
 	struct kmem_cache *kp_slab_cache;
@@ -643,7 +706,7 @@ struct kmem_obj_info {
 	void *kp_stack[KS_ADDRS_COUNT];
 	void *kp_free_stack[KS_ADDRS_COUNT];
 };
-void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page);
+void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
 #endif
 
 #endif /* MM_SLAB_H */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1c673c323baf..d0d843cb7cf1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -585,18 +585,18 @@ void kmem_dump_obj(void *object)
 {
 	char *cp = IS_ENABLED(CONFIG_MMU) ? "" : "/vmalloc";
 	int i;
-	struct page *page;
+	struct slab *slab;
 	unsigned long ptroffset;
 	struct kmem_obj_info kp = { };
 
 	if (WARN_ON_ONCE(!virt_addr_valid(object)))
 		return;
-	page = virt_to_head_page(object);
-	if (WARN_ON_ONCE(!PageSlab(page))) {
+	slab = virt_to_slab(object);
+	if (WARN_ON_ONCE(!is_slab(slab))) {
 		pr_cont(" non-slab memory.\n");
 		return;
 	}
-	kmem_obj_info(&kp, object, page);
+	kmem_obj_info(&kp, object, slab);
 	if (kp.kp_slab_cache)
 		pr_cont(" slab%s %s", cp, kp.kp_slab_cache->name);
 	else
diff --git a/mm/slub.c b/mm/slub.c
index 090fa14628f9..c3b84bd61400 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -47,7 +47,7 @@
  * Lock order:
  *   1. slab_mutex (Global Mutex)
  *   2. node->list_lock
- *   3. slab_lock(page) (Only on some arches and for debugging)
+ *   3. slab_lock(slab) (Only on some arches and for debugging)
  *
  *   slab_mutex
  *
@@ -56,17 +56,17 @@
  *
  *   The slab_lock is only used for debugging and on arches that do not
  *   have the ability to do a cmpxchg_double. It only protects:
- *	A. page->freelist	-> List of object free in a page
- *	B. page->inuse		-> Number of objects in use
- *	C. page->objects	-> Number of objects in page
- *	D. page->frozen		-> frozen state
+ *	A. slab->freelist	-> List of object free in a slab
+ *	B. slab->inuse		-> Number of objects in use
+ *	C. slab->objects	-> Number of objects in slab
+ *	D. slab->frozen		-> frozen state
  *
  *   If a slab is frozen then it is exempt from list management. It is not
  *   on any list except per cpu partial list. The processor that froze the
- *   slab is the one who can perform list operations on the page. Other
+ *   slab is the one who can perform list operations on the slab. Other
  *   processors may put objects onto the freelist but the processor that
  *   froze the slab is the only one that can retrieve the objects from the
- *   page's freelist.
+ *   slab's freelist.
  *
  *   The list_lock protects the partial and full list on each node and
  *   the partial slab counter. If taken then no new slabs may be added or
@@ -94,10 +94,10 @@
  * cannot scan all objects.
  *
  * Slabs are freed when they become empty. Teardown and setup is
- * minimal so we rely on the page allocators per cpu caches for
+ * minimal so we rely on the slab allocators per cpu caches for
  * fast frees and allocs.
  *
- * page->frozen		The slab is frozen and exempt from list processing.
+ * slab->frozen		The slab is frozen and exempt from list processing.
  * 			This means that the slab is dedicated to a purpose
  * 			such as satisfying allocations for a specific
  * 			processor. Objects may be freed in the slab while
@@ -192,7 +192,7 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 
 #define OO_SHIFT	16
 #define OO_MASK		((1 << OO_SHIFT) - 1)
-#define MAX_OBJS_PER_PAGE	32767 /* since page.objects is u15 */
+#define MAX_OBJS_PER_PAGE	32767 /* since slab.objects is u15 */
 
 /* Internal SLUB flags */
 /* Poison object */
@@ -357,22 +357,20 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 }
 
 /*
- * Per slab locking using the pagelock
+ * Per slab locking using the slablock
  */
-static __always_inline void slab_lock(struct page *page)
+static __always_inline void slab_lock(struct slab *slab)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
-	bit_spin_lock(PG_locked, &page->flags);
+	bit_spin_lock(PG_locked, &slab->flags);
 }
 
-static __always_inline void slab_unlock(struct page *page)
+static __always_inline void slab_unlock(struct slab *slab)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
-	__bit_spin_unlock(PG_locked, &page->flags);
+	__bit_spin_unlock(PG_locked, &slab->flags);
 }
 
 /* Interrupts must be disabled (for the fallback code to work right) */
-static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
+static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
@@ -381,22 +379,22 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
 	if (s->flags & __CMPXCHG_DOUBLE) {
-		if (cmpxchg_double(&page->freelist, &page->counters,
+		if (cmpxchg_double(&slab->freelist, &slab->counters,
 				   freelist_old, counters_old,
 				   freelist_new, counters_new))
 			return true;
 	} else
 #endif
 	{
-		slab_lock(page);
-		if (page->freelist == freelist_old &&
-					page->counters == counters_old) {
-			page->freelist = freelist_new;
-			page->counters = counters_new;
-			slab_unlock(page);
+		slab_lock(slab);
+		if (slab->freelist == freelist_old &&
+					slab->counters == counters_old) {
+			slab->freelist = freelist_new;
+			slab->counters = counters_new;
+			slab_unlock(slab);
 			return true;
 		}
-		slab_unlock(page);
+		slab_unlock(slab);
 	}
 
 	cpu_relax();
@@ -409,7 +407,7 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page
 	return false;
 }
 
-static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
+static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
@@ -417,7 +415,7 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
 	if (s->flags & __CMPXCHG_DOUBLE) {
-		if (cmpxchg_double(&page->freelist, &page->counters,
+		if (cmpxchg_double(&slab->freelist, &slab->counters,
 				   freelist_old, counters_old,
 				   freelist_new, counters_new))
 			return true;
@@ -427,16 +425,16 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 		unsigned long flags;
 
 		local_irq_save(flags);
-		slab_lock(page);
-		if (page->freelist == freelist_old &&
-					page->counters == counters_old) {
-			page->freelist = freelist_new;
-			page->counters = counters_new;
-			slab_unlock(page);
+		slab_lock(slab);
+		if (slab->freelist == freelist_old &&
+					slab->counters == counters_old) {
+			slab->freelist = freelist_new;
+			slab->counters = counters_new;
+			slab_unlock(slab);
 			local_irq_restore(flags);
 			return true;
 		}
-		slab_unlock(page);
+		slab_unlock(slab);
 		local_irq_restore(flags);
 	}
 
@@ -475,24 +473,24 @@ static inline bool slab_add_kunit_errors(void) { return false; }
 #endif
 
 /*
- * Determine a map of object in use on a page.
+ * Determine a map of object in use on a slab.
  *
- * Node listlock must be held to guarantee that the page does
+ * Node listlock must be held to guarantee that the slab does
  * not vanish from under us.
  */
-static unsigned long *get_map(struct kmem_cache *s, struct page *page)
+static unsigned long *get_map(struct kmem_cache *s, struct slab *slab)
 	__acquires(&object_map_lock)
 {
 	void *p;
-	void *addr = page_address(page);
+	void *addr = slab_address(slab);
 
 	VM_BUG_ON(!irqs_disabled());
 
 	spin_lock(&object_map_lock);
 
-	bitmap_zero(object_map, page->objects);
+	bitmap_zero(object_map, slab->objects);
 
-	for (p = page->freelist; p; p = get_freepointer(s, p))
+	for (p = slab->freelist; p; p = get_freepointer(s, p))
 		set_bit(__obj_to_index(s, addr, p), object_map);
 
 	return object_map;
@@ -552,19 +550,19 @@ static inline void metadata_access_disable(void)
  * Object debugging
  */
 
-/* Verify that a pointer has an address that is valid within a slab page */
+/* Verify that a pointer has an address that is valid within a slab */
 static inline int check_valid_pointer(struct kmem_cache *s,
-				struct page *page, void *object)
+				struct slab *slab, void *object)
 {
 	void *base;
 
 	if (!object)
 		return 1;
 
-	base = page_address(page);
+	base = slab_address(slab);
 	object = kasan_reset_tag(object);
 	object = restore_red_left(s, object);
-	if (object < base || object >= base + page->objects * s->size ||
+	if (object < base || object >= base + slab->objects * s->size ||
 		(object - base) % s->size) {
 		return 0;
 	}
@@ -675,11 +673,11 @@ void print_tracking(struct kmem_cache *s, void *object)
 	print_track("Freed", get_track(s, object, TRACK_FREE), pr_time);
 }
 
-static void print_page_info(struct page *page)
+static void print_slab_info(struct slab *slab)
 {
 	pr_err("Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
-	       page, page->objects, page->inuse, page->freelist,
-	       page->flags, &page->flags);
+	       slab, slab->objects, slab->inuse, slab->freelist,
+	       slab->flags, &slab->flags);
 
 }
 
@@ -713,12 +711,12 @@ static void slab_fix(struct kmem_cache *s, char *fmt, ...)
 	va_end(args);
 }
 
-static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
+static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 			       void **freelist, void *nextfree)
 {
 	if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
-	    !check_valid_pointer(s, page, nextfree) && freelist) {
-		object_err(s, page, *freelist, "Freechain corrupt");
+	    !check_valid_pointer(s, slab, nextfree) && freelist) {
+		object_err(s, slab, *freelist, "Freechain corrupt");
 		*freelist = NULL;
 		slab_fix(s, "Isolate corrupted freechain");
 		return true;
@@ -727,14 +725,14 @@ static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
 	return false;
 }
 
-static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
+static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 {
 	unsigned int off;	/* Offset of last byte */
-	u8 *addr = page_address(page);
+	u8 *addr = slab_address(slab);
 
 	print_tracking(s, p);
 
-	print_page_info(page);
+	print_slab_info(slab);
 
 	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
 	       p, p - addr, get_freepointer(s, p));
@@ -766,18 +764,18 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 	dump_stack();
 }
 
-void object_err(struct kmem_cache *s, struct page *page,
+void object_err(struct kmem_cache *s, struct slab *slab,
 			u8 *object, char *reason)
 {
 	if (slab_add_kunit_errors())
 		return;
 
 	slab_bug(s, "%s", reason);
-	print_trailer(s, page, object);
+	print_trailer(s, slab, object);
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
-static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
+static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 			const char *fmt, ...)
 {
 	va_list args;
@@ -790,7 +788,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
 	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 	slab_bug(s, "%s", buf);
-	print_page_info(page);
+	print_slab_info(slab);
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
@@ -818,13 +816,13 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 	memset(from, data, to - from);
 }
 
-static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
+static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
 			u8 *object, char *what,
 			u8 *start, unsigned int value, unsigned int bytes)
 {
 	u8 *fault;
 	u8 *end;
-	u8 *addr = page_address(page);
+	u8 *addr = slab_address(slab);
 
 	metadata_access_enable();
 	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
@@ -843,7 +841,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
 					fault, end - 1, fault - addr,
 					fault[0], value);
-	print_trailer(s, page, object);
+	print_trailer(s, slab, object);
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 skip_bug_print:
@@ -889,7 +887,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
  * may be used with merged slabcaches.
  */
 
-static int check_pad_bytes(struct kmem_cache *s, struct page *page, u8 *p)
+static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 {
 	unsigned long off = get_info_end(s);	/* The end of info */
 
@@ -902,12 +900,12 @@ static int check_pad_bytes(struct kmem_cache *s, struct page *page, u8 *p)
 	if (size_from_object(s) == off)
 		return 1;
 
-	return check_bytes_and_report(s, page, p, "Object padding",
+	return check_bytes_and_report(s, slab, p, "Object padding",
 			p + off, POISON_INUSE, size_from_object(s) - off);
 }
 
-/* Check the pad bytes at the end of a slab page */
-static int slab_pad_check(struct kmem_cache *s, struct page *page)
+/* Check the pad bytes at the end of a slab */
+static int slab_pad_check(struct kmem_cache *s, struct slab *slab)
 {
 	u8 *start;
 	u8 *fault;
@@ -919,8 +917,8 @@ static int slab_pad_check(struct kmem_cache *s, struct page *page)
 	if (!(s->flags & SLAB_POISON))
 		return 1;
 
-	start = page_address(page);
-	length = page_size(page);
+	start = slab_address(slab);
+	length = slab_size(slab);
 	end = start + length;
 	remainder = length % s->size;
 	if (!remainder)
@@ -935,7 +933,7 @@ static int slab_pad_check(struct kmem_cache *s, struct page *page)
 	while (end > fault && end[-1] == POISON_INUSE)
 		end--;
 
-	slab_err(s, page, "Padding overwritten. 0x%p-0x%p @offset=%tu",
+	slab_err(s, slab, "Padding overwritten. 0x%p-0x%p @offset=%tu",
 			fault, end - 1, fault - start);
 	print_section(KERN_ERR, "Padding ", pad, remainder);
 
@@ -943,23 +941,23 @@ static int slab_pad_check(struct kmem_cache *s, struct page *page)
 	return 0;
 }
 
-static int check_object(struct kmem_cache *s, struct page *page,
+static int check_object(struct kmem_cache *s, struct slab *slab,
 					void *object, u8 val)
 {
 	u8 *p = object;
 	u8 *endobject = object + s->object_size;
 
 	if (s->flags & SLAB_RED_ZONE) {
-		if (!check_bytes_and_report(s, page, object, "Left Redzone",
+		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
 			object - s->red_left_pad, val, s->red_left_pad))
 			return 0;
 
-		if (!check_bytes_and_report(s, page, object, "Right Redzone",
+		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
 			endobject, val, s->inuse - s->object_size))
 			return 0;
 	} else {
 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
-			check_bytes_and_report(s, page, p, "Alignment padding",
+			check_bytes_and_report(s, slab, p, "Alignment padding",
 				endobject, POISON_INUSE,
 				s->inuse - s->object_size);
 		}
@@ -967,15 +965,15 @@ static int check_object(struct kmem_cache *s, struct page *page,
 
 	if (s->flags & SLAB_POISON) {
 		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON) &&
-			(!check_bytes_and_report(s, page, p, "Poison", p,
+			(!check_bytes_and_report(s, slab, p, "Poison", p,
 					POISON_FREE, s->object_size - 1) ||
-			 !check_bytes_and_report(s, page, p, "End Poison",
+			 !check_bytes_and_report(s, slab, p, "End Poison",
 				p + s->object_size - 1, POISON_END, 1)))
 			return 0;
 		/*
 		 * check_pad_bytes cleans up on its own.
 		 */
-		check_pad_bytes(s, page, p);
+		check_pad_bytes(s, slab, p);
 	}
 
 	if (!freeptr_outside_object(s) && val == SLUB_RED_ACTIVE)
@@ -986,8 +984,8 @@ static int check_object(struct kmem_cache *s, struct page *page,
 		return 1;
 
 	/* Check free pointer validity */
-	if (!check_valid_pointer(s, page, get_freepointer(s, p))) {
-		object_err(s, page, p, "Freepointer corrupt");
+	if (!check_valid_pointer(s, slab, get_freepointer(s, p))) {
+		object_err(s, slab, p, "Freepointer corrupt");
 		/*
 		 * No choice but to zap it and thus lose the remainder
 		 * of the free objects in this slab. May cause
@@ -999,57 +997,57 @@ static int check_object(struct kmem_cache *s, struct page *page,
 	return 1;
 }
 
-static int check_slab(struct kmem_cache *s, struct page *page)
+static int check_slab(struct kmem_cache *s, struct slab *slab)
 {
 	int maxobj;
 
 	VM_BUG_ON(!irqs_disabled());
 
-	if (!PageSlab(page)) {
-		slab_err(s, page, "Not a valid slab page");
+	if (!is_slab(slab)) {
+		slab_err(s, slab, "Not a valid slab slab");
 		return 0;
 	}
 
-	maxobj = order_objects(compound_order(page), s->size);
-	if (page->objects > maxobj) {
-		slab_err(s, page, "objects %u > max %u",
-			page->objects, maxobj);
+	maxobj = order_objects(slab_order(slab), s->size);
+	if (slab->objects > maxobj) {
+		slab_err(s, slab, "objects %u > max %u",
+			slab->objects, maxobj);
 		return 0;
 	}
-	if (page->inuse > page->objects) {
-		slab_err(s, page, "inuse %u > max %u",
-			page->inuse, page->objects);
+	if (slab->inuse > slab->objects) {
+		slab_err(s, slab, "inuse %u > max %u",
+			slab->inuse, slab->objects);
 		return 0;
 	}
 	/* Slab_pad_check fixes things up after itself */
-	slab_pad_check(s, page);
+	slab_pad_check(s, slab);
 	return 1;
 }
 
 /*
- * Determine if a certain object on a page is on the freelist. Must hold the
+ * Determine if a certain object on a slab is on the freelist. Must hold the
  * slab lock to guarantee that the chains are in a consistent state.
  */
-static int on_freelist(struct kmem_cache *s, struct page *page, void *search)
+static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
 {
 	int nr = 0;
 	void *fp;
 	void *object = NULL;
 	int max_objects;
 
-	fp = page->freelist;
-	while (fp && nr <= page->objects) {
+	fp = slab->freelist;
+	while (fp && nr <= slab->objects) {
 		if (fp == search)
 			return 1;
-		if (!check_valid_pointer(s, page, fp)) {
+		if (!check_valid_pointer(s, slab, fp)) {
 			if (object) {
-				object_err(s, page, object,
+				object_err(s, slab, object,
 					"Freechain corrupt");
 				set_freepointer(s, object, NULL);
 			} else {
-				slab_err(s, page, "Freepointer corrupt");
-				page->freelist = NULL;
-				page->inuse = page->objects;
+				slab_err(s, slab, "Freepointer corrupt");
+				slab->freelist = NULL;
+				slab->inuse = slab->objects;
 				slab_fix(s, "Freelist cleared");
 				return 0;
 			}
@@ -1060,34 +1058,34 @@ static int on_freelist(struct kmem_cache *s, struct page *page, void *search)
 		nr++;
 	}
 
-	max_objects = order_objects(compound_order(page), s->size);
+	max_objects = order_objects(slab_order(slab), s->size);
 	if (max_objects > MAX_OBJS_PER_PAGE)
 		max_objects = MAX_OBJS_PER_PAGE;
 
-	if (page->objects != max_objects) {
-		slab_err(s, page, "Wrong number of objects. Found %d but should be %d",
-			 page->objects, max_objects);
-		page->objects = max_objects;
+	if (slab->objects != max_objects) {
+		slab_err(s, slab, "Wrong number of objects. Found %d but should be %d",
+			 slab->objects, max_objects);
+		slab->objects = max_objects;
 		slab_fix(s, "Number of objects adjusted");
 	}
-	if (page->inuse != page->objects - nr) {
-		slab_err(s, page, "Wrong object count. Counter is %d but counted were %d",
-			 page->inuse, page->objects - nr);
-		page->inuse = page->objects - nr;
+	if (slab->inuse != slab->objects - nr) {
+		slab_err(s, slab, "Wrong object count. Counter is %d but counted were %d",
+			 slab->inuse, slab->objects - nr);
+		slab->inuse = slab->objects - nr;
 		slab_fix(s, "Object count adjusted");
 	}
 	return search == NULL;
 }
 
-static void trace(struct kmem_cache *s, struct page *page, void *object,
+static void trace(struct kmem_cache *s, struct slab *slab, void *object,
 								int alloc)
 {
 	if (s->flags & SLAB_TRACE) {
 		pr_info("TRACE %s %s 0x%p inuse=%d fp=0x%p\n",
 			s->name,
 			alloc ? "alloc" : "free",
-			object, page->inuse,
-			page->freelist);
+			object, slab->inuse,
+			slab->freelist);
 
 		if (!alloc)
 			print_section(KERN_INFO, "Object ", (void *)object,
@@ -1101,22 +1099,22 @@ static void trace(struct kmem_cache *s, struct page *page, void *object,
  * Tracking of fully allocated slabs for debugging purposes.
  */
 static void add_full(struct kmem_cache *s,
-	struct kmem_cache_node *n, struct page *page)
+	struct kmem_cache_node *n, struct slab *slab)
 {
 	if (!(s->flags & SLAB_STORE_USER))
 		return;
 
 	lockdep_assert_held(&n->list_lock);
-	list_add(&page->slab_list, &n->full);
+	list_add(&slab->slab_list, &n->full);
 }
 
-static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct page *page)
+static void remove_full(struct kmem_cache *s, struct kmem_cache_node *n, struct slab *slab)
 {
 	if (!(s->flags & SLAB_STORE_USER))
 		return;
 
 	lockdep_assert_held(&n->list_lock);
-	list_del(&page->slab_list);
+	list_del(&slab->slab_list);
 }
 
 /* Tracking of the number of slabs for debugging purposes */
@@ -1156,7 +1154,7 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
 }
 
 /* Object debug checks for alloc/free paths */
-static void setup_object_debug(struct kmem_cache *s, struct page *page,
+static void setup_object_debug(struct kmem_cache *s, struct slab *slab,
 								void *object)
 {
 	if (!kmem_cache_debug_flags(s, SLAB_STORE_USER|SLAB_RED_ZONE|__OBJECT_POISON))
@@ -1167,90 +1165,90 @@ static void setup_object_debug(struct kmem_cache *s, struct page *page,
 }
 
 static
-void setup_page_debug(struct kmem_cache *s, struct page *page, void *addr)
+void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr)
 {
 	if (!kmem_cache_debug_flags(s, SLAB_POISON))
 		return;
 
 	metadata_access_enable();
-	memset(kasan_reset_tag(addr), POISON_INUSE, page_size(page));
+	memset(kasan_reset_tag(addr), POISON_INUSE, slab_size(slab));
 	metadata_access_disable();
 }
 
 static inline int alloc_consistency_checks(struct kmem_cache *s,
-					struct page *page, void *object)
+					struct slab *slab, void *object)
 {
-	if (!check_slab(s, page))
+	if (!check_slab(s, slab))
 		return 0;
 
-	if (!check_valid_pointer(s, page, object)) {
-		object_err(s, page, object, "Freelist Pointer check fails");
+	if (!check_valid_pointer(s, slab, object)) {
+		object_err(s, slab, object, "Freelist Pointer check fails");
 		return 0;
 	}
 
-	if (!check_object(s, page, object, SLUB_RED_INACTIVE))
+	if (!check_object(s, slab, object, SLUB_RED_INACTIVE))
 		return 0;
 
 	return 1;
 }
 
 static noinline int alloc_debug_processing(struct kmem_cache *s,
-					struct page *page,
+					struct slab *slab,
 					void *object, unsigned long addr)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!alloc_consistency_checks(s, page, object))
+		if (!alloc_consistency_checks(s, slab, object))
 			goto bad;
 	}
 
 	/* Success perform special debug activities for allocs */
 	if (s->flags & SLAB_STORE_USER)
 		set_track(s, object, TRACK_ALLOC, addr);
-	trace(s, page, object, 1);
+	trace(s, slab, object, 1);
 	init_object(s, object, SLUB_RED_ACTIVE);
 	return 1;
 
 bad:
-	if (PageSlab(page)) {
+	if (is_slab(slab)) {
 		/*
-		 * If this is a slab page then lets do the best we can
+		 * If this is a slab then lets do the best we can
 		 * to avoid issues in the future. Marking all objects
 		 * as used avoids touching the remaining objects.
 		 */
 		slab_fix(s, "Marking all objects used");
-		page->inuse = page->objects;
-		page->freelist = NULL;
+		slab->inuse = slab->objects;
+		slab->freelist = NULL;
 	}
 	return 0;
 }
 
 static inline int free_consistency_checks(struct kmem_cache *s,
-		struct page *page, void *object, unsigned long addr)
+		struct slab *slab, void *object, unsigned long addr)
 {
-	if (!check_valid_pointer(s, page, object)) {
-		slab_err(s, page, "Invalid object pointer 0x%p", object);
+	if (!check_valid_pointer(s, slab, object)) {
+		slab_err(s, slab, "Invalid object pointer 0x%p", object);
 		return 0;
 	}
 
-	if (on_freelist(s, page, object)) {
-		object_err(s, page, object, "Object already free");
+	if (on_freelist(s, slab, object)) {
+		object_err(s, slab, object, "Object already free");
 		return 0;
 	}
 
-	if (!check_object(s, page, object, SLUB_RED_ACTIVE))
+	if (!check_object(s, slab, object, SLUB_RED_ACTIVE))
 		return 0;
 
-	if (unlikely(s != page->slab_cache)) {
-		if (!PageSlab(page)) {
-			slab_err(s, page, "Attempt to free object(0x%p) outside of slab",
+	if (unlikely(s != slab->slab_cache)) {
+		if (!is_slab(slab)) {
+			slab_err(s, slab, "Attempt to free object(0x%p) outside of slab",
 				 object);
-		} else if (!page->slab_cache) {
+		} else if (!slab->slab_cache) {
 			pr_err("SLUB <none>: no slab for object 0x%p.\n",
 			       object);
 			dump_stack();
 		} else
-			object_err(s, page, object,
-					"page slab pointer corrupt.");
+			object_err(s, slab, object,
+					"slab slab pointer corrupt.");
 		return 0;
 	}
 	return 1;
@@ -1258,21 +1256,21 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 
 /* Supports checking bulk free of a constructed freelist */
 static noinline int free_debug_processing(
-	struct kmem_cache *s, struct page *page,
+	struct kmem_cache *s, struct slab *slab,
 	void *head, void *tail, int bulk_cnt,
 	unsigned long addr)
 {
-	struct kmem_cache_node *n = get_node(s, page_to_nid(page));
+	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
 	void *object = head;
 	int cnt = 0;
 	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&n->list_lock, flags);
-	slab_lock(page);
+	slab_lock(slab);
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!check_slab(s, page))
+		if (!check_slab(s, slab))
 			goto out;
 	}
 
@@ -1280,13 +1278,13 @@ static noinline int free_debug_processing(
 	cnt++;
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!free_consistency_checks(s, page, object, addr))
+		if (!free_consistency_checks(s, slab, object, addr))
 			goto out;
 	}
 
 	if (s->flags & SLAB_STORE_USER)
 		set_track(s, object, TRACK_FREE, addr);
-	trace(s, page, object, 0);
+	trace(s, slab, object, 0);
 	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
 	init_object(s, object, SLUB_RED_INACTIVE);
 
@@ -1299,10 +1297,10 @@ static noinline int free_debug_processing(
 
 out:
 	if (cnt != bulk_cnt)
-		slab_err(s, page, "Bulk freelist count(%d) invalid(%d)\n",
+		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
 			 bulk_cnt, cnt);
 
-	slab_unlock(page);
+	slab_unlock(slab);
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	if (!ret)
 		slab_fix(s, "Object at 0x%p not freed", object);
@@ -1514,26 +1512,26 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 }
 #else /* !CONFIG_SLUB_DEBUG */
 static inline void setup_object_debug(struct kmem_cache *s,
-			struct page *page, void *object) {}
+			struct slab *slab, void *object) {}
 static inline
-void setup_page_debug(struct kmem_cache *s, struct page *page, void *addr) {}
+void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
 static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct page *page, void *object, unsigned long addr) { return 0; }
+	struct slab *slab, void *object, unsigned long addr) { return 0; }
 
 static inline int free_debug_processing(
-	struct kmem_cache *s, struct page *page,
+	struct kmem_cache *s, struct slab *slab,
 	void *head, void *tail, int bulk_cnt,
 	unsigned long addr) { return 0; }
 
-static inline int slab_pad_check(struct kmem_cache *s, struct page *page)
+static inline int slab_pad_check(struct kmem_cache *s, struct slab *slab)
 			{ return 1; }
-static inline int check_object(struct kmem_cache *s, struct page *page,
+static inline int check_object(struct kmem_cache *s, struct slab *slab,
 			void *object, u8 val) { return 1; }
 static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
-					struct page *page) {}
+					struct slab *slab) {}
 static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
-					struct page *page) {}
+					struct slab *slab) {}
 slab_flags_t kmem_cache_flags(unsigned int object_size,
 	slab_flags_t flags, const char *name)
 {
@@ -1552,7 +1550,7 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node,
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
 
-static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
+static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 			       void **freelist, void *nextfree)
 {
 	return false;
@@ -1662,10 +1660,10 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 	return *head != NULL;
 }
 
-static void *setup_object(struct kmem_cache *s, struct page *page,
+static void *setup_object(struct kmem_cache *s, struct slab *slab,
 				void *object)
 {
-	setup_object_debug(s, page, object);
+	setup_object_debug(s, slab, object);
 	object = kasan_init_slab_obj(s, object);
 	if (unlikely(s->ctor)) {
 		kasan_unpoison_object_data(s, object);
@@ -1678,18 +1676,25 @@ static void *setup_object(struct kmem_cache *s, struct page *page,
 /*
  * Slab allocation and freeing
  */
-static inline struct page *alloc_slab_page(struct kmem_cache *s,
+static inline struct slab *alloc_slab(struct kmem_cache *s,
 		gfp_t flags, int node, struct kmem_cache_order_objects oo)
 {
 	struct page *page;
+	struct slab *slab;
 	unsigned int order = oo_order(oo);
 
 	if (node == NUMA_NO_NODE)
 		page = alloc_pages(flags, order);
 	else
 		page = __alloc_pages_node(node, flags, order);
+	if (!page)
+		return NULL;
 
-	return page;
+	__SetPageSlab(page);
+	slab = (struct slab *)page;
+	if (page_is_pfmemalloc(page))
+		SetSlabPfmemalloc(slab);
+	return slab;
 }
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
@@ -1710,7 +1715,7 @@ static int init_cache_random_seq(struct kmem_cache *s)
 		return err;
 	}
 
-	/* Transform to an offset on the set of pages */
+	/* Transform to an offset on the set of slabs */
 	if (s->random_seq) {
 		unsigned int i;
 
@@ -1734,54 +1739,54 @@ static void __init init_freelist_randomization(void)
 }
 
 /* Get the next entry on the pre-computed freelist randomized */
-static void *next_freelist_entry(struct kmem_cache *s, struct page *page,
+static void *next_freelist_entry(struct kmem_cache *s, struct slab *slab,
 				unsigned long *pos, void *start,
-				unsigned long page_limit,
+				unsigned long slab_limit,
 				unsigned long freelist_count)
 {
 	unsigned int idx;
 
 	/*
-	 * If the target page allocation failed, the number of objects on the
-	 * page might be smaller than the usual size defined by the cache.
+	 * If the target slab allocation failed, the number of objects on the
+	 * slab might be smaller than the usual size defined by the cache.
 	 */
 	do {
 		idx = s->random_seq[*pos];
 		*pos += 1;
 		if (*pos >= freelist_count)
 			*pos = 0;
-	} while (unlikely(idx >= page_limit));
+	} while (unlikely(idx >= slab_limit));
 
 	return (char *)start + idx;
 }
 
 /* Shuffle the single linked freelist based on a random pre-computed sequence */
-static bool shuffle_freelist(struct kmem_cache *s, struct page *page)
+static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 {
 	void *start;
 	void *cur;
 	void *next;
-	unsigned long idx, pos, page_limit, freelist_count;
+	unsigned long idx, pos, slab_limit, freelist_count;
 
-	if (page->objects < 2 || !s->random_seq)
+	if (slab->objects < 2 || !s->random_seq)
 		return false;
 
 	freelist_count = oo_objects(s->oo);
 	pos = get_random_int() % freelist_count;
 
-	page_limit = page->objects * s->size;
-	start = fixup_red_left(s, page_address(page));
+	slab_limit = slab->objects * s->size;
+	start = fixup_red_left(s, slab_address(slab));
 
 	/* First entry is used as the base of the freelist */
-	cur = next_freelist_entry(s, page, &pos, start, page_limit,
+	cur = next_freelist_entry(s, slab, &pos, start, slab_limit,
 				freelist_count);
-	cur = setup_object(s, page, cur);
-	page->freelist = cur;
+	cur = setup_object(s, slab, cur);
+	slab->freelist = cur;
 
-	for (idx = 1; idx < page->objects; idx++) {
-		next = next_freelist_entry(s, page, &pos, start, page_limit,
+	for (idx = 1; idx < slab->objects; idx++) {
+		next = next_freelist_entry(s, slab, &pos, start, slab_limit,
 			freelist_count);
-		next = setup_object(s, page, next);
+		next = setup_object(s, slab, next);
 		set_freepointer(s, cur, next);
 		cur = next;
 	}
@@ -1795,15 +1800,15 @@ static inline int init_cache_random_seq(struct kmem_cache *s)
 	return 0;
 }
 static inline void init_freelist_randomization(void) { }
-static inline bool shuffle_freelist(struct kmem_cache *s, struct page *page)
+static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 {
 	return false;
 }
 #endif /* CONFIG_SLAB_FREELIST_RANDOM */
 
-static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
+static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
-	struct page *page;
+	struct slab *slab;
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
 	void *start, *p, *next;
@@ -1825,65 +1830,62 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
 		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~(__GFP_RECLAIM|__GFP_NOFAIL);
 
-	page = alloc_slab_page(s, alloc_gfp, node, oo);
-	if (unlikely(!page)) {
+	slab = alloc_slab(s, alloc_gfp, node, oo);
+	if (unlikely(!slab)) {
 		oo = s->min;
 		alloc_gfp = flags;
 		/*
 		 * Allocation may have failed due to fragmentation.
 		 * Try a lower order alloc if possible
 		 */
-		page = alloc_slab_page(s, alloc_gfp, node, oo);
-		if (unlikely(!page))
+		slab = alloc_slab(s, alloc_gfp, node, oo);
+		if (unlikely(!slab))
 			goto out;
 		stat(s, ORDER_FALLBACK);
 	}
 
-	page->objects = oo_objects(oo);
+	slab->objects = oo_objects(oo);
 
-	account_slab_page(page, oo_order(oo), s, flags);
+	account_slab(slab, oo_order(oo), s, flags);
 
-	page->slab_cache = s;
-	__SetPageSlab(page);
-	if (page_is_pfmemalloc(page))
-		SetPageSlabPfmemalloc(page);
+	slab->slab_cache = s;
 
-	kasan_poison_slab(page);
+	kasan_poison_slab(slab);
 
-	start = page_address(page);
+	start = slab_address(slab);
 
-	setup_page_debug(s, page, start);
+	setup_slab_debug(s, slab, start);
 
-	shuffle = shuffle_freelist(s, page);
+	shuffle = shuffle_freelist(s, slab);
 
 	if (!shuffle) {
 		start = fixup_red_left(s, start);
-		start = setup_object(s, page, start);
-		page->freelist = start;
-		for (idx = 0, p = start; idx < page->objects - 1; idx++) {
+		start = setup_object(s, slab, start);
+		slab->freelist = start;
+		for (idx = 0, p = start; idx < slab->objects - 1; idx++) {
 			next = p + s->size;
-			next = setup_object(s, page, next);
+			next = setup_object(s, slab, next);
 			set_freepointer(s, p, next);
 			p = next;
 		}
 		set_freepointer(s, p, NULL);
 	}
 
-	page->inuse = page->objects;
-	page->frozen = 1;
+	slab->inuse = slab->objects;
+	slab->frozen = 1;
 
 out:
 	if (gfpflags_allow_blocking(flags))
 		local_irq_disable();
-	if (!page)
+	if (!slab)
 		return NULL;
 
-	inc_slabs_node(s, page_to_nid(page), page->objects);
+	inc_slabs_node(s, slab_nid(slab), slab->objects);
 
-	return page;
+	return slab;
 }
 
-static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
+static struct slab *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);
@@ -1892,76 +1894,77 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
 }
 
-static void __free_slab(struct kmem_cache *s, struct page *page)
+static void __free_slab(struct kmem_cache *s, struct slab *slab)
 {
-	int order = compound_order(page);
-	int pages = 1 << order;
+	struct page *page = &slab->page;
+	int order = slab_order(slab);
+	int slabs = 1 << order;
 
 	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
 		void *p;
 
-		slab_pad_check(s, page);
-		for_each_object(p, s, page_address(page),
-						page->objects)
-			check_object(s, page, p, SLUB_RED_INACTIVE);
+		slab_pad_check(s, slab);
+		for_each_object(p, s, slab_address(slab),
+						slab->objects)
+			check_object(s, slab, p, SLUB_RED_INACTIVE);
 	}
 
-	__ClearPageSlabPfmemalloc(page);
+	__ClearSlabPfmemalloc(slab);
 	__ClearPageSlab(page);
-	/* In union with page->mapping where page allocator expects NULL */
-	page->slab_cache = NULL;
+	page->mapping = NULL;
 	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += pages;
-	unaccount_slab_page(page, order, s);
-	__free_pages(page, order);
+		current->reclaim_state->reclaimed_slab += slabs;
+	unaccount_slab(slab, order, s);
+	put_page(page);
 }
 
 static void rcu_free_slab(struct rcu_head *h)
 {
 	struct page *page = container_of(h, struct page, rcu_head);
+	struct slab *slab = (struct slab *)page;
 
-	__free_slab(page->slab_cache, page);
+	__free_slab(slab->slab_cache, slab);
 }
 
-static void free_slab(struct kmem_cache *s, struct page *page)
+static void free_slab(struct kmem_cache *s, struct slab *slab)
 {
 	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU)) {
-		call_rcu(&page->rcu_head, rcu_free_slab);
+		call_rcu(&slab->page.rcu_head, rcu_free_slab);
 	} else
-		__free_slab(s, page);
+		__free_slab(s, slab);
 }
 
-static void discard_slab(struct kmem_cache *s, struct page *page)
+static void discard_slab(struct kmem_cache *s, struct slab *slab)
 {
-	dec_slabs_node(s, page_to_nid(page), page->objects);
-	free_slab(s, page);
+	dec_slabs_node(s, slab_nid(slab), slab->objects);
+	free_slab(s, slab);
 }
 
 /*
  * Management of partially allocated slabs.
  */
 static inline void
-__add_partial(struct kmem_cache_node *n, struct page *page, int tail)
+__add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
 {
 	n->nr_partial++;
 	if (tail == DEACTIVATE_TO_TAIL)
-		list_add_tail(&page->slab_list, &n->partial);
+		list_add_tail(&slab->slab_list, &n->partial);
 	else
-		list_add(&page->slab_list, &n->partial);
+		list_add(&slab->slab_list, &n->partial);
 }
 
 static inline void add_partial(struct kmem_cache_node *n,
-				struct page *page, int tail)
+				struct slab *slab, int tail)
 {
 	lockdep_assert_held(&n->list_lock);
-	__add_partial(n, page, tail);
+	__add_partial(n, slab, tail);
 }
 
 static inline void remove_partial(struct kmem_cache_node *n,
-					struct page *page)
+					struct slab *slab)
 {
 	lockdep_assert_held(&n->list_lock);
-	list_del(&page->slab_list);
+	list_del(&slab->slab_list);
 	n->nr_partial--;
 }
 
@@ -1972,12 +1975,12 @@ static inline void remove_partial(struct kmem_cache_node *n,
  * Returns a list of objects or NULL if it fails.
  */
 static inline void *acquire_slab(struct kmem_cache *s,
-		struct kmem_cache_node *n, struct page *page,
+		struct kmem_cache_node *n, struct slab *slab,
 		int mode, int *objects)
 {
 	void *freelist;
 	unsigned long counters;
-	struct page new;
+	struct slab new;
 
 	lockdep_assert_held(&n->list_lock);
 
@@ -1986,12 +1989,12 @@ static inline void *acquire_slab(struct kmem_cache *s,
 	 * The old freelist is the list of objects for the
 	 * per cpu allocation list.
 	 */
-	freelist = page->freelist;
-	counters = page->counters;
+	freelist = slab->freelist;
+	counters = slab->counters;
 	new.counters = counters;
 	*objects = new.objects - new.inuse;
 	if (mode) {
-		new.inuse = page->objects;
+		new.inuse = slab->objects;
 		new.freelist = NULL;
 	} else {
 		new.freelist = freelist;
@@ -2000,19 +2003,19 @@ static inline void *acquire_slab(struct kmem_cache *s,
 	VM_BUG_ON(new.frozen);
 	new.frozen = 1;
 
-	if (!__cmpxchg_double_slab(s, page,
+	if (!__cmpxchg_double_slab(s, slab,
 			freelist, counters,
 			new.freelist, new.counters,
 			"acquire_slab"))
 		return NULL;
 
-	remove_partial(n, page);
+	remove_partial(n, slab);
 	WARN_ON(!freelist);
 	return freelist;
 }
 
-static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain);
-static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags);
+static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain);
+static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
 
 /*
  * Try to allocate a partial slab from a specific node.
@@ -2020,7 +2023,7 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags);
 static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 				struct kmem_cache_cpu *c, gfp_t flags)
 {
-	struct page *page, *page2;
+	struct slab *slab, *slab2;
 	void *object = NULL;
 	unsigned int available = 0;
 	int objects;
@@ -2035,23 +2038,23 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 		return NULL;
 
 	spin_lock(&n->list_lock);
-	list_for_each_entry_safe(page, page2, &n->partial, slab_list) {
+	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
 		void *t;
 
-		if (!pfmemalloc_match(page, flags))
+		if (!pfmemalloc_match(slab, flags))
 			continue;
 
-		t = acquire_slab(s, n, page, object == NULL, &objects);
+		t = acquire_slab(s, n, slab, object == NULL, &objects);
 		if (!t)
 			break;
 
 		available += objects;
 		if (!object) {
-			c->page = page;
+			c->slab = slab;
 			stat(s, ALLOC_FROM_PARTIAL);
 			object = t;
 		} else {
-			put_cpu_partial(s, page, 0);
+			put_cpu_partial(s, slab, 0);
 			stat(s, CPU_PARTIAL_NODE);
 		}
 		if (!kmem_cache_has_cpu_partial(s)
@@ -2064,7 +2067,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 }
 
 /*
- * Get a page from somewhere. Search in increasing NUMA distances.
+ * Get a slab from somewhere. Search in increasing NUMA distances.
  */
 static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 		struct kmem_cache_cpu *c)
@@ -2128,7 +2131,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 }
 
 /*
- * Get a partial page, lock it and return it.
+ * Get a partial slab, lock it and return it.
  */
 static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
 		struct kmem_cache_cpu *c)
@@ -2218,19 +2221,19 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 /*
  * Remove the cpu slab
  */
-static void deactivate_slab(struct kmem_cache *s, struct page *page,
+static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 				void *freelist, struct kmem_cache_cpu *c)
 {
 	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
-	struct kmem_cache_node *n = get_node(s, page_to_nid(page));
+	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
 	int lock = 0, free_delta = 0;
 	enum slab_modes l = M_NONE, m = M_NONE;
 	void *nextfree, *freelist_iter, *freelist_tail;
 	int tail = DEACTIVATE_TO_HEAD;
-	struct page new;
-	struct page old;
+	struct slab new;
+	struct slab old;
 
-	if (page->freelist) {
+	if (slab->freelist) {
 		stat(s, DEACTIVATE_REMOTE_FREES);
 		tail = DEACTIVATE_TO_TAIL;
 	}
@@ -2249,7 +2252,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 		 * 'freelist_iter' is already corrupted.  So isolate all objects
 		 * starting at 'freelist_iter' by skipping them.
 		 */
-		if (freelist_corrupted(s, page, &freelist_iter, nextfree))
+		if (freelist_corrupted(s, slab, &freelist_iter, nextfree))
 			break;
 
 		freelist_tail = freelist_iter;
@@ -2259,25 +2262,25 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	}
 
 	/*
-	 * Stage two: Unfreeze the page while splicing the per-cpu
-	 * freelist to the head of page's freelist.
+	 * Stage two: Unfreeze the slab while splicing the per-cpu
+	 * freelist to the head of slab's freelist.
 	 *
-	 * Ensure that the page is unfrozen while the list presence
+	 * Ensure that the slab is unfrozen while the list presence
 	 * reflects the actual number of objects during unfreeze.
 	 *
 	 * We setup the list membership and then perform a cmpxchg
-	 * with the count. If there is a mismatch then the page
-	 * is not unfrozen but the page is on the wrong list.
+	 * with the count. If there is a mismatch then the slab
+	 * is not unfrozen but the slab is on the wrong list.
 	 *
 	 * Then we restart the process which may have to remove
-	 * the page from the list that we just put it on again
+	 * the slab from the list that we just put it on again
 	 * because the number of objects in the slab may have
 	 * changed.
 	 */
 redo:
 
-	old.freelist = READ_ONCE(page->freelist);
-	old.counters = READ_ONCE(page->counters);
+	old.freelist = READ_ONCE(slab->freelist);
+	old.counters = READ_ONCE(slab->counters);
 	VM_BUG_ON(!old.frozen);
 
 	/* Determine target state of the slab */
@@ -2299,7 +2302,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			lock = 1;
 			/*
 			 * Taking the spinlock removes the possibility
-			 * that acquire_slab() will see a slab page that
+			 * that acquire_slab() will see a slab slab that
 			 * is frozen
 			 */
 			spin_lock(&n->list_lock);
@@ -2319,18 +2322,18 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 
 	if (l != m) {
 		if (l == M_PARTIAL)
-			remove_partial(n, page);
+			remove_partial(n, slab);
 		else if (l == M_FULL)
-			remove_full(s, n, page);
+			remove_full(s, n, slab);
 
 		if (m == M_PARTIAL)
-			add_partial(n, page, tail);
+			add_partial(n, slab, tail);
 		else if (m == M_FULL)
-			add_full(s, n, page);
+			add_full(s, n, slab);
 	}
 
 	l = m;
-	if (!__cmpxchg_double_slab(s, page,
+	if (!__cmpxchg_double_slab(s, slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab"))
@@ -2345,11 +2348,11 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 		stat(s, DEACTIVATE_FULL);
 	else if (m == M_FREE) {
 		stat(s, DEACTIVATE_EMPTY);
-		discard_slab(s, page);
+		discard_slab(s, slab);
 		stat(s, FREE_SLAB);
 	}
 
-	c->page = NULL;
+	c->slab = NULL;
 	c->freelist = NULL;
 }
 
@@ -2365,15 +2368,15 @@ static void unfreeze_partials(struct kmem_cache *s,
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
-	struct page *page, *discard_page = NULL;
+	struct slab *slab, *next_slab = NULL;
 
-	while ((page = slub_percpu_partial(c))) {
-		struct page new;
-		struct page old;
+	while ((slab = slub_percpu_partial(c))) {
+		struct slab new;
+		struct slab old;
 
-		slub_set_percpu_partial(c, page);
+		slub_set_percpu_partial(c, slab);
 
-		n2 = get_node(s, page_to_nid(page));
+		n2 = get_node(s, slab_nid(slab));
 		if (n != n2) {
 			if (n)
 				spin_unlock(&n->list_lock);
@@ -2384,8 +2387,8 @@ static void unfreeze_partials(struct kmem_cache *s,
 
 		do {
 
-			old.freelist = page->freelist;
-			old.counters = page->counters;
+			old.freelist = slab->freelist;
+			old.counters = slab->counters;
 			VM_BUG_ON(!old.frozen);
 
 			new.counters = old.counters;
@@ -2393,16 +2396,16 @@ static void unfreeze_partials(struct kmem_cache *s,
 
 			new.frozen = 0;
 
-		} while (!__cmpxchg_double_slab(s, page,
+		} while (!__cmpxchg_double_slab(s, slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab"));
 
 		if (unlikely(!new.inuse && n->nr_partial >= s->min_partial)) {
-			page->next = discard_page;
-			discard_page = page;
+			slab->next = next_slab;
+			next_slab = slab;
 		} else {
-			add_partial(n, page, DEACTIVATE_TO_TAIL);
+			add_partial(n, slab, DEACTIVATE_TO_TAIL);
 			stat(s, FREE_ADD_PARTIAL);
 		}
 	}
@@ -2410,40 +2413,40 @@ static void unfreeze_partials(struct kmem_cache *s,
 	if (n)
 		spin_unlock(&n->list_lock);
 
-	while (discard_page) {
-		page = discard_page;
-		discard_page = discard_page->next;
+	while (next_slab) {
+		slab = next_slab;
+		next_slab = next_slab->next;
 
 		stat(s, DEACTIVATE_EMPTY);
-		discard_slab(s, page);
+		discard_slab(s, slab);
 		stat(s, FREE_SLAB);
 	}
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
 /*
- * Put a page that was just frozen (in __slab_free|get_partial_node) into a
- * partial page slot if available.
+ * Put a slab that was just frozen (in __slab_free|get_partial_node) into a
+ * partial slab slot if available.
  *
  * If we did not find a slot then simply move all the partials to the
  * per node partial list.
  */
-static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
+static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
-	struct page *oldpage;
-	int pages;
+	struct slab *oldslab;
+	int slabs;
 	int pobjects;
 
 	preempt_disable();
 	do {
-		pages = 0;
+		slabs = 0;
 		pobjects = 0;
-		oldpage = this_cpu_read(s->cpu_slab->partial);
+		oldslab = this_cpu_read(s->cpu_slab->partial);
 
-		if (oldpage) {
-			pobjects = oldpage->pobjects;
-			pages = oldpage->pages;
+		if (oldslab) {
+			pobjects = oldslab->pobjects;
+			slabs = oldslab->slabs;
 			if (drain && pobjects > slub_cpu_partial(s)) {
 				unsigned long flags;
 				/*
@@ -2453,22 +2456,22 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 				local_irq_save(flags);
 				unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
 				local_irq_restore(flags);
-				oldpage = NULL;
+				oldslab = NULL;
 				pobjects = 0;
-				pages = 0;
+				slabs = 0;
 				stat(s, CPU_PARTIAL_DRAIN);
 			}
 		}
 
-		pages++;
-		pobjects += page->objects - page->inuse;
+		slabs++;
+		pobjects += slab->objects - slab->inuse;
 
-		page->pages = pages;
-		page->pobjects = pobjects;
-		page->next = oldpage;
+		slab->slabs = slabs;
+		slab->pobjects = pobjects;
+		slab->next = oldslab;
 
-	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
-								!= oldpage);
+	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldslab, slab)
+								!= oldslab);
 	if (unlikely(!slub_cpu_partial(s))) {
 		unsigned long flags;
 
@@ -2483,7 +2486,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 {
 	stat(s, CPUSLAB_FLUSH);
-	deactivate_slab(s, c->page, c->freelist, c);
+	deactivate_slab(s, c->slab, c->freelist, c);
 
 	c->tid = next_tid(c->tid);
 }
@@ -2497,7 +2500,7 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
-	if (c->page)
+	if (c->slab)
 		flush_slab(s, c);
 
 	unfreeze_partials(s, c);
@@ -2515,7 +2518,7 @@ static bool has_cpu_slab(int cpu, void *info)
 	struct kmem_cache *s = info;
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
-	return c->page || slub_percpu_partial(c);
+	return c->slab || slub_percpu_partial(c);
 }
 
 static void flush_all(struct kmem_cache *s)
@@ -2546,19 +2549,19 @@ static int slub_cpu_dead(unsigned int cpu)
  * Check if the objects in a per cpu structure fit numa
  * locality expectations.
  */
-static inline int node_match(struct page *page, int node)
+static inline int node_match(struct slab *slab, int node)
 {
 #ifdef CONFIG_NUMA
-	if (node != NUMA_NO_NODE && page_to_nid(page) != node)
+	if (node != NUMA_NO_NODE && slab_nid(slab) != node)
 		return 0;
 #endif
 	return 1;
 }
 
 #ifdef CONFIG_SLUB_DEBUG
-static int count_free(struct page *page)
+static int count_free(struct slab *slab)
 {
-	return page->objects - page->inuse;
+	return slab->objects - slab->inuse;
 }
 
 static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
@@ -2569,15 +2572,15 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 
 #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
 static unsigned long count_partial(struct kmem_cache_node *n,
-					int (*get_count)(struct page *))
+					int (*get_count)(struct slab *))
 {
 	unsigned long flags;
 	unsigned long x = 0;
-	struct page *page;
+	struct slab *slab;
 
 	spin_lock_irqsave(&n->list_lock, flags);
-	list_for_each_entry(page, &n->partial, slab_list)
-		x += get_count(page);
+	list_for_each_entry(slab, &n->partial, slab_list)
+		x += get_count(slab);
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return x;
 }
@@ -2625,7 +2628,7 @@ static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
 {
 	void *freelist;
 	struct kmem_cache_cpu *c = *pc;
-	struct page *page;
+	struct slab *slab;
 
 	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
 
@@ -2634,62 +2637,62 @@ static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
 	if (freelist)
 		return freelist;
 
-	page = new_slab(s, flags, node);
-	if (page) {
+	slab = new_slab(s, flags, node);
+	if (slab) {
 		c = raw_cpu_ptr(s->cpu_slab);
-		if (c->page)
+		if (c->slab)
 			flush_slab(s, c);
 
 		/*
-		 * No other reference to the page yet so we can
+		 * No other reference to the slab yet so we can
 		 * muck around with it freely without cmpxchg
 		 */
-		freelist = page->freelist;
-		page->freelist = NULL;
+		freelist = slab->freelist;
+		slab->freelist = NULL;
 
 		stat(s, ALLOC_SLAB);
-		c->page = page;
+		c->slab = slab;
 		*pc = c;
 	}
 
 	return freelist;
 }
 
-static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags)
+static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags)
 {
-	if (unlikely(PageSlabPfmemalloc(page)))
+	if (unlikely(SlabPfmemalloc(slab)))
 		return gfp_pfmemalloc_allowed(gfpflags);
 
 	return true;
 }
 
 /*
- * Check the page->freelist of a page and either transfer the freelist to the
- * per cpu freelist or deactivate the page.
+ * Check the slab->freelist of a slab and either transfer the freelist to the
+ * per cpu freelist or deactivate the slab.
  *
- * The page is still frozen if the return value is not NULL.
+ * The slab is still frozen if the return value is not NULL.
  *
- * If this function returns NULL then the page has been unfrozen.
+ * If this function returns NULL then the slab has been unfrozen.
  *
  * This function must be called with interrupt disabled.
  */
-static inline void *get_freelist(struct kmem_cache *s, struct page *page)
+static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 {
-	struct page new;
+	struct slab new;
 	unsigned long counters;
 	void *freelist;
 
 	do {
-		freelist = page->freelist;
-		counters = page->counters;
+		freelist = slab->freelist;
+		counters = slab->counters;
 
 		new.counters = counters;
 		VM_BUG_ON(!new.frozen);
 
-		new.inuse = page->objects;
+		new.inuse = slab->objects;
 		new.frozen = freelist != NULL;
 
-	} while (!__cmpxchg_double_slab(s, page,
+	} while (!__cmpxchg_double_slab(s, slab,
 		freelist, counters,
 		NULL, new.counters,
 		"get_freelist"));
@@ -2711,7 +2714,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct page *page)
  *
  * And if we were unable to get a new slab from the partial slab lists then
  * we need to allocate a new slab. This is the slowest path since it involves
- * a call to the page allocator and the setup of a new slab.
+ * a call to the slab allocator and the setup of a new slab.
  *
  * Version of __slab_alloc to use when we know that interrupts are
  * already disabled (which is the case for bulk allocation).
@@ -2720,12 +2723,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			  unsigned long addr, struct kmem_cache_cpu *c)
 {
 	void *freelist;
-	struct page *page;
+	struct slab *slab;
 
 	stat(s, ALLOC_SLOWPATH);
 
-	page = c->page;
-	if (!page) {
+	slab = c->slab;
+	if (!slab) {
 		/*
 		 * if the node is not online or has no normal memory, just
 		 * ignore the node constraint
@@ -2737,7 +2740,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 redo:
 
-	if (unlikely(!node_match(page, node))) {
+	if (unlikely(!node_match(slab, node))) {
 		/*
 		 * same as above but node_match() being false already
 		 * implies node != NUMA_NO_NODE
@@ -2747,18 +2750,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto redo;
 		} else {
 			stat(s, ALLOC_NODE_MISMATCH);
-			deactivate_slab(s, page, c->freelist, c);
+			deactivate_slab(s, slab, c->freelist, c);
 			goto new_slab;
 		}
 	}
 
 	/*
-	 * By rights, we should be searching for a slab page that was
+	 * By rights, we should be searching for a slab slab that was
 	 * PFMEMALLOC but right now, we are losing the pfmemalloc
-	 * information when the page leaves the per-cpu allocator
+	 * information when the slab leaves the per-cpu allocator
 	 */
-	if (unlikely(!pfmemalloc_match(page, gfpflags))) {
-		deactivate_slab(s, page, c->freelist, c);
+	if (unlikely(!pfmemalloc_match(slab, gfpflags))) {
+		deactivate_slab(s, slab, c->freelist, c);
 		goto new_slab;
 	}
 
@@ -2767,10 +2770,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (freelist)
 		goto load_freelist;
 
-	freelist = get_freelist(s, page);
+	freelist = get_freelist(s, slab);
 
 	if (!freelist) {
-		c->page = NULL;
+		c->slab = NULL;
 		stat(s, DEACTIVATE_BYPASS);
 		goto new_slab;
 	}
@@ -2780,10 +2783,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 load_freelist:
 	/*
 	 * freelist is pointing to the list of objects to be used.
-	 * page is pointing to the page from which the objects are obtained.
-	 * That page must be frozen for per cpu allocations to work.
+	 * slab is pointing to the slab from which the objects are obtained.
+	 * That slab must be frozen for per cpu allocations to work.
 	 */
-	VM_BUG_ON(!c->page->frozen);
+	VM_BUG_ON(!c->slab->frozen);
 	c->freelist = get_freepointer(s, freelist);
 	c->tid = next_tid(c->tid);
 	return freelist;
@@ -2791,8 +2794,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 new_slab:
 
 	if (slub_percpu_partial(c)) {
-		page = c->page = slub_percpu_partial(c);
-		slub_set_percpu_partial(c, page);
+		slab = c->slab = slub_percpu_partial(c);
+		slub_set_percpu_partial(c, slab);
 		stat(s, CPU_PARTIAL_ALLOC);
 		goto redo;
 	}
@@ -2804,16 +2807,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		return NULL;
 	}
 
-	page = c->page;
-	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(page, gfpflags)))
+	slab = c->slab;
+	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(slab, gfpflags)))
 		goto load_freelist;
 
 	/* Only entered in the debug case */
 	if (kmem_cache_debug(s) &&
-			!alloc_debug_processing(s, page, freelist, addr))
+			!alloc_debug_processing(s, slab, freelist, addr))
 		goto new_slab;	/* Slab failed checks. Next slab needed */
 
-	deactivate_slab(s, page, get_freepointer(s, freelist), c);
+	deactivate_slab(s, slab, get_freepointer(s, freelist), c);
 	return freelist;
 }
 
@@ -2869,7 +2872,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 {
 	void *object;
 	struct kmem_cache_cpu *c;
-	struct page *page;
+	struct slab *slab;
 	unsigned long tid;
 	struct obj_cgroup *objcg = NULL;
 	bool init = false;
@@ -2902,9 +2905,9 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	/*
 	 * Irqless object alloc/free algorithm used here depends on sequence
 	 * of fetching cpu_slab's data. tid should be fetched before anything
-	 * on c to guarantee that object and page associated with previous tid
+	 * on c to guarantee that object and slab associated with previous tid
 	 * won't be used with current tid. If we fetch tid first, object and
-	 * page could be one associated with next tid and our alloc/free
+	 * slab could be one associated with next tid and our alloc/free
 	 * request will be failed. In this case, we will retry. So, no problem.
 	 */
 	barrier();
@@ -2917,8 +2920,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	 */
 
 	object = c->freelist;
-	page = c->page;
-	if (unlikely(!object || !page || !node_match(page, node))) {
+	slab = c->slab;
+	if (unlikely(!object || !slab || !node_match(slab, node))) {
 		object = __slab_alloc(s, gfpflags, node, addr, c);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
@@ -3020,17 +3023,17 @@ EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
  * have a longer lifetime than the cpu slabs in most processing loads.
  *
  * So we still attempt to reduce cache line usage. Just take the slab
- * lock and free the item. If there is no additional partial page
+ * lock and free the item. If there is no additional partial slab
  * handling required then we can return immediately.
  */
-static void __slab_free(struct kmem_cache *s, struct page *page,
+static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			void *head, void *tail, int cnt,
 			unsigned long addr)
 
 {
 	void *prior;
 	int was_frozen;
-	struct page new;
+	struct slab new;
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
 	unsigned long flags;
@@ -3041,7 +3044,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 		return;
 
 	if (kmem_cache_debug(s) &&
-	    !free_debug_processing(s, page, head, tail, cnt, addr))
+	    !free_debug_processing(s, slab, head, tail, cnt, addr))
 		return;
 
 	do {
@@ -3049,8 +3052,8 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 			spin_unlock_irqrestore(&n->list_lock, flags);
 			n = NULL;
 		}
-		prior = page->freelist;
-		counters = page->counters;
+		prior = slab->freelist;
+		counters = slab->counters;
 		set_freepointer(s, tail, prior);
 		new.counters = counters;
 		was_frozen = new.frozen;
@@ -3069,7 +3072,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 
 			} else { /* Needs to be taken off a list */
 
-				n = get_node(s, page_to_nid(page));
+				n = get_node(s, slab_nid(slab));
 				/*
 				 * Speculatively acquire the list_lock.
 				 * If the cmpxchg does not succeed then we may
@@ -3083,7 +3086,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 			}
 		}
 
-	} while (!cmpxchg_double_slab(s, page,
+	} while (!cmpxchg_double_slab(s, slab,
 		prior, counters,
 		head, new.counters,
 		"__slab_free"));
@@ -3098,10 +3101,10 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 			stat(s, FREE_FROZEN);
 		} else if (new.frozen) {
 			/*
-			 * If we just froze the page then put it onto the
+			 * If we just froze the slab then put it onto the
 			 * per cpu partial list.
 			 */
-			put_cpu_partial(s, page, 1);
+			put_cpu_partial(s, slab, 1);
 			stat(s, CPU_PARTIAL_FREE);
 		}
 
@@ -3116,8 +3119,8 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 	 * then add it.
 	 */
 	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
-		remove_full(s, n, page);
-		add_partial(n, page, DEACTIVATE_TO_TAIL);
+		remove_full(s, n, slab);
+		add_partial(n, slab, DEACTIVATE_TO_TAIL);
 		stat(s, FREE_ADD_PARTIAL);
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
@@ -3128,16 +3131,16 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 		/*
 		 * Slab on the partial list.
 		 */
-		remove_partial(n, page);
+		remove_partial(n, slab);
 		stat(s, FREE_REMOVE_PARTIAL);
 	} else {
 		/* Slab must be on the full list */
-		remove_full(s, n, page);
+		remove_full(s, n, slab);
 	}
 
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	stat(s, FREE_SLAB);
-	discard_slab(s, page);
+	discard_slab(s, slab);
 }
 
 /*
@@ -3152,11 +3155,11 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
  * with all sorts of special processing.
  *
  * Bulk free of a freelist with several objects (all pointing to the
- * same page) possible by specifying head and tail ptr, plus objects
+ * same slab) possible by specifying head and tail ptr, plus objects
  * count (cnt). Bulk free indicated by tail pointer being set.
  */
 static __always_inline void do_slab_free(struct kmem_cache *s,
-				struct page *page, void *head, void *tail,
+				struct slab *slab, void *head, void *tail,
 				int cnt, unsigned long addr)
 {
 	void *tail_obj = tail ? : head;
@@ -3180,7 +3183,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	/* Same with comment on barrier() in slab_alloc_node() */
 	barrier();
 
-	if (likely(page == c->page)) {
+	if (likely(slab == c->slab)) {
 		void **freelist = READ_ONCE(c->freelist);
 
 		set_freepointer(s, tail_obj, freelist);
@@ -3195,11 +3198,11 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 		}
 		stat(s, FREE_FASTPATH);
 	} else
-		__slab_free(s, page, head, tail_obj, cnt, addr);
+		__slab_free(s, slab, head, tail_obj, cnt, addr);
 
 }
 
-static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
+static __always_inline void slab_free(struct kmem_cache *s, struct slab *slab,
 				      void *head, void *tail, int cnt,
 				      unsigned long addr)
 {
@@ -3208,13 +3211,13 @@ static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
 	 * to remove objects, whose reuse must be delayed.
 	 */
 	if (slab_free_freelist_hook(s, &head, &tail))
-		do_slab_free(s, page, head, tail, cnt, addr);
+		do_slab_free(s, slab, head, tail, cnt, addr);
 }
 
 #ifdef CONFIG_KASAN_GENERIC
 void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 {
-	do_slab_free(cache, virt_to_head_page(x), x, NULL, 1, addr);
+	do_slab_free(cache, virt_to_slab(x), x, NULL, 1, addr);
 }
 #endif
 
@@ -3223,13 +3226,13 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 	s = cache_from_obj(s, x);
 	if (!s)
 		return;
-	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
+	slab_free(s, virt_to_slab(x), x, NULL, 1, _RET_IP_);
 	trace_kmem_cache_free(_RET_IP_, x, s->name);
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
 struct detached_freelist {
-	struct page *page;
+	struct slab *slab;
 	void *tail;
 	void *freelist;
 	int cnt;
@@ -3239,8 +3242,8 @@ struct detached_freelist {
 /*
  * This function progressively scans the array with free objects (with
  * a limited look ahead) and extract objects belonging to the same
- * page.  It builds a detached freelist directly within the given
- * page/objects.  This can happen without any need for
+ * slab.  It builds a detached freelist directly within the given
+ * slab/objects.  This can happen without any need for
  * synchronization, because the objects are owned by running process.
  * The freelist is build up as a single linked list in the objects.
  * The idea is, that this detached freelist can then be bulk
@@ -3255,10 +3258,10 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	size_t first_skipped_index = 0;
 	int lookahead = 3;
 	void *object;
-	struct page *page;
+	struct slab *slab;
 
 	/* Always re-init detached_freelist */
-	df->page = NULL;
+	df->slab = NULL;
 
 	do {
 		object = p[--size];
@@ -3268,18 +3271,18 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	if (!object)
 		return 0;
 
-	page = virt_to_head_page(object);
+	slab = virt_to_slab(object);
 	if (!s) {
 		/* Handle kalloc'ed objects */
-		if (unlikely(!PageSlab(page))) {
-			BUG_ON(!PageCompound(page));
+		if (unlikely(!is_slab(slab))) {
+			BUG_ON(!SlabMulti(slab));
 			kfree_hook(object);
-			__free_pages(page, compound_order(page));
+			put_page(&slab->page);
 			p[size] = NULL; /* mark object processed */
 			return size;
 		}
 		/* Derive kmem_cache from object */
-		df->s = page->slab_cache;
+		df->s = slab->slab_cache;
 	} else {
 		df->s = cache_from_obj(s, object); /* Support for memcg */
 	}
@@ -3292,7 +3295,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	}
 
 	/* Start new detached freelist */
-	df->page = page;
+	df->slab = slab;
 	set_freepointer(df->s, object, NULL);
 	df->tail = object;
 	df->freelist = object;
@@ -3304,8 +3307,8 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 		if (!object)
 			continue; /* Skip processed objects */
 
-		/* df->page is always set at this point */
-		if (df->page == virt_to_head_page(object)) {
+		/* df->slab is always set at this point */
+		if (df->slab == virt_to_slab(object)) {
 			/* Opportunity build freelist */
 			set_freepointer(df->s, object, df->freelist);
 			df->freelist = object;
@@ -3337,10 +3340,10 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 		struct detached_freelist df;
 
 		size = build_detached_freelist(s, size, p, &df);
-		if (!df.page)
+		if (!df.slab)
 			continue;
 
-		slab_free(df.s, df.page, df.freelist, df.tail, df.cnt, _RET_IP_);
+		slab_free(df.s, df.slab, df.freelist, df.tail, df.cnt, _RET_IP_);
 	} while (likely(size));
 }
 EXPORT_SYMBOL(kmem_cache_free_bulk);
@@ -3435,7 +3438,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_bulk);
  */
 
 /*
- * Minimum / Maximum order of slab pages. This influences locking overhead
+ * Minimum / Maximum order of slab slabs. This influences locking overhead
  * and slab fragmentation. A higher order reduces the number of partial slabs
  * and increases the number of allocations possible without having to
  * take the list_lock.
@@ -3449,7 +3452,7 @@ static unsigned int slub_min_objects;
  *
  * The order of allocation has significant impact on performance and other
  * system components. Generally order 0 allocations should be preferred since
- * order 0 does not cause fragmentation in the page allocator. Larger objects
+ * order 0 does not cause fragmentation in the slab allocator. Larger objects
  * be problematic to put into order 0 slabs because there may be too much
  * unused space left. We go to a higher order if more than 1/16th of the slab
  * would be wasted.
@@ -3461,15 +3464,15 @@ static unsigned int slub_min_objects;
  *
  * slub_max_order specifies the order where we begin to stop considering the
  * number of objects in a slab as critical. If we reach slub_max_order then
- * we try to keep the page order as low as possible. So we accept more waste
- * of space in favor of a small page order.
+ * we try to keep the slab order as low as possible. So we accept more waste
+ * of space in favor of a small slab order.
  *
  * Higher order allocations also allow the placement of more objects in a
  * slab and thereby reduce object handling overhead. If the user has
  * requested a higher minimum order then we start with that one instead of
  * the smallest order which will fit the object.
  */
-static inline unsigned int slab_order(unsigned int size,
+static inline unsigned int calc_slab_order(unsigned int size,
 		unsigned int min_objects, unsigned int max_order,
 		unsigned int fract_leftover)
 {
@@ -3533,7 +3536,7 @@ static inline int calculate_order(unsigned int size)
 
 		fraction = 16;
 		while (fraction >= 4) {
-			order = slab_order(size, min_objects,
+			order = calc_slab_order(size, min_objects,
 					slub_max_order, fraction);
 			if (order <= slub_max_order)
 				return order;
@@ -3546,14 +3549,14 @@ static inline int calculate_order(unsigned int size)
 	 * We were unable to place multiple objects in a slab. Now
 	 * lets see if we can place a single object there.
 	 */
-	order = slab_order(size, 1, slub_max_order, 1);
+	order = calc_slab_order(size, 1, slub_max_order, 1);
 	if (order <= slub_max_order)
 		return order;
 
 	/*
 	 * Doh this slab cannot be placed using slub_max_order.
 	 */
-	order = slab_order(size, 1, MAX_ORDER, 1);
+	order = calc_slab_order(size, 1, MAX_ORDER, 1);
 	if (order < MAX_ORDER)
 		return order;
 	return -ENOSYS;
@@ -3605,38 +3608,38 @@ static struct kmem_cache *kmem_cache_node;
  */
 static void early_kmem_cache_node_alloc(int node)
 {
-	struct page *page;
+	struct slab *slab;
 	struct kmem_cache_node *n;
 
 	BUG_ON(kmem_cache_node->size < sizeof(struct kmem_cache_node));
 
-	page = new_slab(kmem_cache_node, GFP_NOWAIT, node);
+	slab = new_slab(kmem_cache_node, GFP_NOWAIT, node);
 
-	BUG_ON(!page);
-	if (page_to_nid(page) != node) {
+	BUG_ON(!slab);
+	if (slab_nid(slab) != node) {
 		pr_err("SLUB: Unable to allocate memory from node %d\n", node);
 		pr_err("SLUB: Allocating a useless per node structure in order to be able to continue\n");
 	}
 
-	n = page->freelist;
+	n = slab->freelist;
 	BUG_ON(!n);
 #ifdef CONFIG_SLUB_DEBUG
 	init_object(kmem_cache_node, n, SLUB_RED_ACTIVE);
 	init_tracking(kmem_cache_node, n);
 #endif
 	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL, false);
-	page->freelist = get_freepointer(kmem_cache_node, n);
-	page->inuse = 1;
-	page->frozen = 0;
+	slab->freelist = get_freepointer(kmem_cache_node, n);
+	slab->inuse = 1;
+	slab->frozen = 0;
 	kmem_cache_node->node[node] = n;
 	init_kmem_cache_node(n);
-	inc_slabs_node(kmem_cache_node, node, page->objects);
+	inc_slabs_node(kmem_cache_node, node, slab->objects);
 
 	/*
 	 * No locks need to be taken here as it has just been
 	 * initialized and there is no concurrent access.
 	 */
-	__add_partial(n, page, DEACTIVATE_TO_HEAD);
+	__add_partial(n, slab, DEACTIVATE_TO_HEAD);
 }
 
 static void free_kmem_cache_nodes(struct kmem_cache *s)
@@ -3894,8 +3897,8 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 #endif
 
 	/*
-	 * The larger the object size is, the more pages we want on the partial
-	 * list to avoid pounding the page allocator excessively.
+	 * The larger the object size is, the more slabs we want on the partial
+	 * list to avoid pounding the slab allocator excessively.
 	 */
 	set_min_partial(s, ilog2(s->size) / 2);
 
@@ -3922,19 +3925,19 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	return -EINVAL;
 }
 
-static void list_slab_objects(struct kmem_cache *s, struct page *page,
+static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
 			      const char *text)
 {
 #ifdef CONFIG_SLUB_DEBUG
-	void *addr = page_address(page);
+	void *addr = slab_address(slab);
 	unsigned long *map;
 	void *p;
 
-	slab_err(s, page, text, s->name);
-	slab_lock(page);
+	slab_err(s, slab, text, s->name);
+	slab_lock(slab);
 
-	map = get_map(s, page);
-	for_each_object(p, s, addr, page->objects) {
+	map = get_map(s, slab);
+	for_each_object(p, s, addr, slab->objects) {
 
 		if (!test_bit(__obj_to_index(s, addr, p), map)) {
 			pr_err("Object 0x%p @offset=%tu\n", p, p - addr);
@@ -3942,7 +3945,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 		}
 	}
 	put_map(map);
-	slab_unlock(page);
+	slab_unlock(slab);
 #endif
 }
 
@@ -3954,23 +3957,23 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 {
 	LIST_HEAD(discard);
-	struct page *page, *h;
+	struct slab *slab, *h;
 
 	BUG_ON(irqs_disabled());
 	spin_lock_irq(&n->list_lock);
-	list_for_each_entry_safe(page, h, &n->partial, slab_list) {
-		if (!page->inuse) {
-			remove_partial(n, page);
-			list_add(&page->slab_list, &discard);
+	list_for_each_entry_safe(slab, h, &n->partial, slab_list) {
+		if (!slab->inuse) {
+			remove_partial(n, slab);
+			list_add(&slab->slab_list, &discard);
 		} else {
-			list_slab_objects(s, page,
+			list_slab_objects(s, slab,
 			  "Objects remaining in %s on __kmem_cache_shutdown()");
 		}
 	}
 	spin_unlock_irq(&n->list_lock);
 
-	list_for_each_entry_safe(page, h, &discard, slab_list)
-		discard_slab(s, page);
+	list_for_each_entry_safe(slab, h, &discard, slab_list)
+		discard_slab(s, slab);
 }
 
 bool __kmem_cache_empty(struct kmem_cache *s)
@@ -4003,31 +4006,31 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 }
 
 #ifdef CONFIG_PRINTK
-void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
+void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
 	void *base;
 	int __maybe_unused i;
 	unsigned int objnr;
 	void *objp;
 	void *objp0;
-	struct kmem_cache *s = page->slab_cache;
+	struct kmem_cache *s = slab->slab_cache;
 	struct track __maybe_unused *trackp;
 
 	kpp->kp_ptr = object;
-	kpp->kp_page = page;
+	kpp->kp_slab = slab;
 	kpp->kp_slab_cache = s;
-	base = page_address(page);
+	base = slab_address(slab);
 	objp0 = kasan_reset_tag(object);
 #ifdef CONFIG_SLUB_DEBUG
 	objp = restore_red_left(s, objp0);
 #else
 	objp = objp0;
 #endif
-	objnr = obj_to_index(s, page, objp);
+	objnr = obj_to_index(s, slab, objp);
 	kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);
 	objp = base + s->size * objnr;
 	kpp->kp_objp = objp;
-	if (WARN_ON_ONCE(objp < base || objp >= base + page->objects * s->size || (objp - base) % s->size) ||
+	if (WARN_ON_ONCE(objp < base || objp >= base + slab->objects * s->size || (objp - base) % s->size) ||
 	    !(s->flags & SLAB_STORE_USER))
 		return;
 #ifdef CONFIG_SLUB_DEBUG
@@ -4115,8 +4118,8 @@ static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	unsigned int order = get_order(size);
 
 	flags |= __GFP_COMP;
-	page = alloc_pages_node(node, flags, order);
-	if (page) {
+	slab = alloc_pages_node(node, flags, order);
+	if (slab) {
 		ptr = page_address(page);
 		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
 				      PAGE_SIZE << order);
@@ -4165,7 +4168,7 @@ EXPORT_SYMBOL(__kmalloc_node);
  * Returns NULL if check passes, otherwise const char * to name of cache
  * to indicate an error.
  */
-void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
+void __check_heap_object(const void *ptr, unsigned long n, struct slab *slab,
 			 bool to_user)
 {
 	struct kmem_cache *s;
@@ -4176,18 +4179,18 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 	ptr = kasan_reset_tag(ptr);
 
 	/* Find object and usable object size. */
-	s = page->slab_cache;
+	s = slab->slab_cache;
 
 	/* Reject impossible pointers. */
-	if (ptr < page_address(page))
-		usercopy_abort("SLUB object not in SLUB page?!", NULL,
+	if (ptr < slab_address(slab))
+		usercopy_abort("SLUB object not in SLUB slab?!", NULL,
 			       to_user, 0, n);
 
 	/* Find offset within object. */
 	if (is_kfence)
 		offset = ptr - kfence_object_start(ptr);
 	else
-		offset = (ptr - page_address(page)) % s->size;
+		offset = (ptr - slab_address(slab)) % s->size;
 
 	/* Adjust for redzone and reject if within the redzone. */
 	if (!is_kfence && kmem_cache_debug_flags(s, SLAB_RED_ZONE)) {
@@ -4222,25 +4225,25 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 
 size_t __ksize(const void *object)
 {
-	struct page *page;
+	struct slab *slab;
 
 	if (unlikely(object == ZERO_SIZE_PTR))
 		return 0;
 
-	page = virt_to_head_page(object);
+	slab = virt_to_slab(object);
 
-	if (unlikely(!PageSlab(page))) {
-		WARN_ON(!PageCompound(page));
-		return page_size(page);
+	if (unlikely(!is_slab(slab))) {
+		WARN_ON(!SlabMulti(slab));
+		return slab_size(slab);
 	}
 
-	return slab_ksize(page->slab_cache);
+	return slab_ksize(slab->slab_cache);
 }
 EXPORT_SYMBOL(__ksize);
 
 void kfree(const void *x)
 {
-	struct page *page;
+	struct slab *slab;
 	void *object = (void *)x;
 
 	trace_kfree(_RET_IP_, x);
@@ -4248,18 +4251,19 @@ void kfree(const void *x)
 	if (unlikely(ZERO_OR_NULL_PTR(x)))
 		return;
 
-	page = virt_to_head_page(x);
-	if (unlikely(!PageSlab(page))) {
-		unsigned int order = compound_order(page);
+	slab = virt_to_slab(x);
+	if (unlikely(!is_slab(slab))) {
+		unsigned int order = slab_order(slab);
+		struct page *page = &slab->page;
 
-		BUG_ON(!PageCompound(page));
+		BUG_ON(!SlabMulti(slab));
 		kfree_hook(object);
 		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
 				      -(PAGE_SIZE << order));
-		__free_pages(page, order);
+		put_page(page);
 		return;
 	}
-	slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
+	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);
 }
 EXPORT_SYMBOL(kfree);
 
@@ -4279,8 +4283,8 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	int node;
 	int i;
 	struct kmem_cache_node *n;
-	struct page *page;
-	struct page *t;
+	struct slab *slab;
+	struct slab *t;
 	struct list_head discard;
 	struct list_head promote[SHRINK_PROMOTE_MAX];
 	unsigned long flags;
@@ -4298,22 +4302,22 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 		 * Build lists of slabs to discard or promote.
 		 *
 		 * Note that concurrent frees may occur while we hold the
-		 * list_lock. page->inuse here is the upper limit.
+		 * list_lock. slab->inuse here is the upper limit.
 		 */
-		list_for_each_entry_safe(page, t, &n->partial, slab_list) {
-			int free = page->objects - page->inuse;
+		list_for_each_entry_safe(slab, t, &n->partial, slab_list) {
+			int free = slab->objects - slab->inuse;
 
-			/* Do not reread page->inuse */
+			/* Do not reread slab->inuse */
 			barrier();
 
 			/* We do not keep full slabs on the list */
 			BUG_ON(free <= 0);
 
-			if (free == page->objects) {
-				list_move(&page->slab_list, &discard);
+			if (free == slab->objects) {
+				list_move(&slab->slab_list, &discard);
 				n->nr_partial--;
 			} else if (free <= SHRINK_PROMOTE_MAX)
-				list_move(&page->slab_list, promote + free - 1);
+				list_move(&slab->slab_list, promote + free - 1);
 		}
 
 		/*
@@ -4326,8 +4330,8 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 		spin_unlock_irqrestore(&n->list_lock, flags);
 
 		/* Release empty slabs */
-		list_for_each_entry_safe(page, t, &discard, slab_list)
-			discard_slab(s, page);
+		list_for_each_entry_safe(slab, t, &discard, slab_list)
+			discard_slab(s, slab);
 
 		if (slabs_node(s, node))
 			ret = 1;
@@ -4461,7 +4465,7 @@ static struct notifier_block slab_memory_callback_nb = {
 
 /*
  * Used for early kmem_cache structures that were allocated using
- * the page allocator. Allocate them properly then fix up the pointers
+ * the slab allocator. Allocate them properly then fix up the pointers
  * that may be pointing to the wrong kmem_cache structure.
  */
 
@@ -4480,7 +4484,7 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 	 */
 	__flush_cpu_slab(s, smp_processor_id());
 	for_each_kmem_cache_node(s, node, n) {
-		struct page *p;
+		struct slab *p;
 
 		list_for_each_entry(p, &n->partial, slab_list)
 			p->slab_cache = s;
@@ -4656,54 +4660,54 @@ EXPORT_SYMBOL(__kmalloc_node_track_caller);
 #endif
 
 #ifdef CONFIG_SYSFS
-static int count_inuse(struct page *page)
+static int count_inuse(struct slab *slab)
 {
-	return page->inuse;
+	return slab->inuse;
 }
 
-static int count_total(struct page *page)
+static int count_total(struct slab *slab)
 {
-	return page->objects;
+	return slab->objects;
 }
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
-static void validate_slab(struct kmem_cache *s, struct page *page)
+static void validate_slab(struct kmem_cache *s, struct slab *slab)
 {
 	void *p;
-	void *addr = page_address(page);
+	void *addr = slab_address(slab);
 	unsigned long *map;
 
-	slab_lock(page);
+	slab_lock(slab);
 
-	if (!check_slab(s, page) || !on_freelist(s, page, NULL))
+	if (!check_slab(s, slab) || !on_freelist(s, slab, NULL))
 		goto unlock;
 
 	/* Now we know that a valid freelist exists */
-	map = get_map(s, page);
-	for_each_object(p, s, addr, page->objects) {
+	map = get_map(s, slab);
+	for_each_object(p, s, addr, slab->objects) {
 		u8 val = test_bit(__obj_to_index(s, addr, p), map) ?
 			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
 
-		if (!check_object(s, page, p, val))
+		if (!check_object(s, slab, p, val))
 			break;
 	}
 	put_map(map);
 unlock:
-	slab_unlock(page);
+	slab_unlock(slab);
 }
 
 static int validate_slab_node(struct kmem_cache *s,
 		struct kmem_cache_node *n)
 {
 	unsigned long count = 0;
-	struct page *page;
+	struct slab *slab;
 	unsigned long flags;
 
 	spin_lock_irqsave(&n->list_lock, flags);
 
-	list_for_each_entry(page, &n->partial, slab_list) {
-		validate_slab(s, page);
+	list_for_each_entry(slab, &n->partial, slab_list) {
+		validate_slab(s, slab);
 		count++;
 	}
 	if (count != n->nr_partial) {
@@ -4715,8 +4719,8 @@ static int validate_slab_node(struct kmem_cache *s,
 	if (!(s->flags & SLAB_STORE_USER))
 		goto out;
 
-	list_for_each_entry(page, &n->full, slab_list) {
-		validate_slab(s, page);
+	list_for_each_entry(slab, &n->full, slab_list) {
+		validate_slab(s, slab);
 		count++;
 	}
 	if (count != atomic_long_read(&n->nr_slabs)) {
@@ -4838,7 +4842,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 				cpumask_set_cpu(track->cpu,
 						to_cpumask(l->cpus));
 			}
-			node_set(page_to_nid(virt_to_page(track)), l->nodes);
+			node_set(slab_nid(virt_to_slab(track)), l->nodes);
 			return 1;
 		}
 
@@ -4869,19 +4873,19 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 	cpumask_clear(to_cpumask(l->cpus));
 	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
 	nodes_clear(l->nodes);
-	node_set(page_to_nid(virt_to_page(track)), l->nodes);
+	node_set(slab_nid(virt_to_slab(track)), l->nodes);
 	return 1;
 }
 
 static void process_slab(struct loc_track *t, struct kmem_cache *s,
-		struct page *page, enum track_item alloc)
+		struct slab *slab, enum track_item alloc)
 {
-	void *addr = page_address(page);
+	void *addr = slab_address(slab);
 	void *p;
 	unsigned long *map;
 
-	map = get_map(s, page);
-	for_each_object(p, s, addr, page->objects)
+	map = get_map(s, slab);
+	for_each_object(p, s, addr, slab->objects)
 		if (!test_bit(__obj_to_index(s, addr, p), map))
 			add_location(t, s, get_track(s, p, alloc));
 	put_map(map);
@@ -4924,32 +4928,32 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 			struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab,
 							       cpu);
 			int node;
-			struct page *page;
+			struct slab *slab;
 
-			page = READ_ONCE(c->page);
-			if (!page)
+			slab = READ_ONCE(c->slab);
+			if (!slab)
 				continue;
 
-			node = page_to_nid(page);
+			node = slab_nid(slab);
 			if (flags & SO_TOTAL)
-				x = page->objects;
+				x = slab->objects;
 			else if (flags & SO_OBJECTS)
-				x = page->inuse;
+				x = slab->inuse;
 			else
 				x = 1;
 
 			total += x;
 			nodes[node] += x;
 
-			page = slub_percpu_partial_read_once(c);
-			if (page) {
-				node = page_to_nid(page);
+			slab = slub_percpu_partial_read_once(c);
+			if (slab) {
+				node = slab_nid(slab);
 				if (flags & SO_TOTAL)
 					WARN_ON_ONCE(1);
 				else if (flags & SO_OBJECTS)
 					WARN_ON_ONCE(1);
 				else
-					x = page->pages;
+					x = slab->slabs;
 				total += x;
 				nodes[node] += x;
 			}
@@ -5146,31 +5150,31 @@ SLAB_ATTR_RO(objects_partial);
 static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 {
 	int objects = 0;
-	int pages = 0;
+	int slabs = 0;
 	int cpu;
 	int len = 0;
 
 	for_each_online_cpu(cpu) {
-		struct page *page;
+		struct slab *slab;
 
-		page = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
+		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
 
-		if (page) {
-			pages += page->pages;
-			objects += page->pobjects;
+		if (slab) {
+			slabs += slab->slabs;
+			objects += slab->pobjects;
 		}
 	}
 
-	len += sysfs_emit_at(buf, len, "%d(%d)", objects, pages);
+	len += sysfs_emit_at(buf, len, "%d(%d)", objects, slabs);
 
 #ifdef CONFIG_SMP
 	for_each_online_cpu(cpu) {
-		struct page *page;
+		struct slab *slab;
 
-		page = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
-		if (page)
+		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
+		if (slab)
 			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
-					     cpu, page->pobjects, page->pages);
+					     cpu, slab->pobjects, slab->slabs);
 	}
 #endif
 	len += sysfs_emit_at(buf, len, "\n");
@@ -5825,16 +5829,16 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 
 	for_each_kmem_cache_node(s, node, n) {
 		unsigned long flags;
-		struct page *page;
+		struct slab *slab;
 
 		if (!atomic_long_read(&n->nr_slabs))
 			continue;
 
 		spin_lock_irqsave(&n->list_lock, flags);
-		list_for_each_entry(page, &n->partial, slab_list)
-			process_slab(t, s, page, alloc);
-		list_for_each_entry(page, &n->full, slab_list)
-			process_slab(t, s, page, alloc);
+		list_for_each_entry(slab, &n->partial, slab_list)
+			process_slab(t, s, slab, alloc);
+		list_for_each_entry(slab, &n->full, slab_list)
+			process_slab(t, s, slab, alloc);
 		spin_unlock_irqrestore(&n->list_lock, flags);
 	}
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 6326cdf36c4f..2b1099c986c6 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -750,7 +750,7 @@ static void free_map_bootmem(struct page *memmap)
 		>> PAGE_SHIFT;
 
 	for (i = 0; i < nr_pages; i++, page++) {
-		magic = (unsigned long) page->freelist;
+		magic = page->index;
 
 		BUG_ON(magic == NODE_INFO);
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 68e8831068f4..0661dc09e11b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -17,7 +17,7 @@
  *
  * Usage of struct page fields:
  *	page->private: points to zspage
- *	page->freelist(index): links together all component pages of a zspage
+ *	page->index: links together all component pages of a zspage
  *		For the huge page, this is always 0, so we use this field
  *		to store handle.
  *	page->units: first object offset in a subpage of zspage
@@ -827,7 +827,7 @@ static struct page *get_next_page(struct page *page)
 	if (unlikely(PageHugeObject(page)))
 		return NULL;
 
-	return page->freelist;
+	return (struct page *)page->index;
 }
 
 /**
@@ -901,7 +901,7 @@ static void reset_page(struct page *page)
 	set_page_private(page, 0);
 	page_mapcount_reset(page);
 	ClearPageHugeObject(page);
-	page->freelist = NULL;
+	page->index = 0;
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -1027,7 +1027,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 
 	/*
 	 * Allocate individual pages and link them together as:
-	 * 1. all pages are linked together using page->freelist
+	 * 1. all pages are linked together using page->index
 	 * 2. each sub-page point to zspage using page->private
 	 *
 	 * we set PG_private to identify the first page (i.e. no other sub-page
@@ -1036,7 +1036,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 	for (i = 0; i < nr_pages; i++) {
 		page = pages[i];
 		set_page_private(page, (unsigned long)zspage);
-		page->freelist = NULL;
+		page->index = 0;
 		if (i == 0) {
 			zspage->first_page = page;
 			SetPagePrivate(page);
@@ -1044,7 +1044,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 					class->pages_per_zspage == 1))
 				SetPageHugeObject(page);
 		} else {
-			prev_page->freelist = page;
+			prev_page->index = (unsigned long)page;
 		}
 		prev_page = page;
 	}
