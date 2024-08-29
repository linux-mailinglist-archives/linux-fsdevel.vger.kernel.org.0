Return-Path: <linux-fsdevel+bounces-27919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA20964C79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9384B2738C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19DF1BAEEF;
	Thu, 29 Aug 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6st3mUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110E1B78E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950780; cv=none; b=fVIwXtQbiFHwxxv/9Ie/86acUMyYyrSH3l2MeZJayxhX408I6RBJj6xaCROfRULQ+CeqdbhblLRWf7DOqsND2cezd+cAVflF1jHlEK3wj8tX3HkLoI6E2KDDpVzlTUVIrYRE9qqtd4m4p4wowHh5rKSeHV50UApnRFeRh+pFOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950780; c=relaxed/simple;
	bh=K/LffPhHgsVkQ8Hmirto/gEaeHVv422Lba8I+gXg09M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbgJXzZmBtb+5aUyGp74r9QZhfDIfIEnroGqdnGn/p5kkOYdteWX6IRUvtPhptPXqeZ4eLkehGlPCf49stHzGBN1xzdkWWyJ+xAOyMAJyNh+wDEW277tJMUCNasWbRQh8EWI550KmjneXczCs9qN4jJlAJV9IuqWPX+/nms4NQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6st3mUV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=up1+iyu0HvtZL5E+EXssaXi/TIZa1G2RQW1zOiYjenc=;
	b=U6st3mUVFaGagzTpIbDBUJ1wLcggrYpsvyWW8bSAw9eACFltxARznfBEL7zzm8dWnDamF3
	ZJmsncJutyb5vr/dyCFx/XROTRFcBG7L/IFeLDAkiiw26puNQFe5+geU6xydSuMASpWzC+
	5UIxo3Rmd1LVspjpfZokHl6qo4ioAJI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-1KRbKMh9NyG_mK90LyPUkA-1; Thu,
 29 Aug 2024 12:59:30 -0400
X-MC-Unique: 1KRbKMh9NyG_mK90LyPUkA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2DEC195420D;
	Thu, 29 Aug 2024 16:59:27 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD5A51955F66;
	Thu, 29 Aug 2024 16:59:17 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1 17/17] mm: stop maintaining the per-page mapcount of large folios (CONFIG_NO_PAGE_MAPCOUNT)
Date: Thu, 29 Aug 2024 18:56:20 +0200
Message-ID: <20240829165627.2256514-18-david@redhat.com>
In-Reply-To: <20240829165627.2256514-1-david@redhat.com>
References: <20240829165627.2256514-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Everything is in place to stop using the per-page mapcounts in large
folios with CONFIG_NO_PAGE_MAPCOUNT: the mapcount of tail pages will always
be logically 0 (-1 value), just like it currently is for hugetlb folios
already, and the page mapcount of the head page is either 0 (-1 value)
or contains a page type (e.g., hugetlb).

Maintaining _nr_pages_mapped without per-page mapcounts is impossible,
so that one also has to go with CONFIG_NO_PAGE_MAPCOUNT.

There are two remaining implications:

(1) Per-node, per-cgroup and per-lruvec stats of "NR_ANON_MAPPED"
    ("mapped anonymous memory") and "NR_FILE_MAPPED"
    ("mapped file memory"):

    As soon as any page of the folio is mapped -- folio_mapped() -- we
    now account the complete folio as mapped. Once the last page is
    unmapped -- !folio_mapped() -- we account the complete folio as
    unmapped.

    This implies that ...

    * "AnonPages" and "Mapped" in /proc/meminfo and
      /sys/devices/system/node/*/meminfo
    * cgroup v2: "anon" and "file_mapped" in "memory.stat" and
      "memory.numa_stat"
    * cgroup v1: "rss" and "mapped_file" in "memory.stat" and
      "memory.numa_stat

    ... can now appear higher than before. But note that these folios do
    consume that memory, simply not all pages are actually currently
    mapped.

    It's worth nothing that other accounting in the kernel (esp. cgroup
    charging on allocation) is not affected by this change.

    [why oh why is "anon" called "rss" in cgroup v1]

 (2) Detecting partial mappings

     Detecting whether anon THP are partially mapped gets a bit more
     unreliable. As long as a single MM maps such a large folio
     ("exclusively mapped"), we can reliably detect it. Especially before
     fork() / after a short-lived child process quit, we will detect
     partial mappings reliably, which is the common case.

     In essence, if the average per-page mapcount in an anon THP is < 1,
     we know for sure that we have a partial mapping.

     However, as soon as multiple MMs are involved, we might miss detecting
     partial mappings: this might be relevant with long-lived child
     processes. If we have a fully-mapped anon folio before fork(), once
     our child processes and our parent all unmap (zap/COW) the same pages
     (but not the complete folio), we might not detect the partial mapping.
     However, once the child processes quit we would detect the partial
     mapping.

     How relevant this case is in practice remains to be seen.
     Swapout/migration will likely mitigate this.

     In the future, RMAP walkers should check for that for "mapped shared"
     anon folios, and flag them for deferred-splitting.

There are a couple of remaining per-page mapcount users we won't
touch for now:

 (1) __dump_folio(): we'll tackle that separately later. For now, it
     will always read effective mapcount of "0" for pages in large folios.

 (2) include/trace/events/page_ref.h: we should rework the whole
     handling to be folio-aware and simply trace folio_mapcount(). Let's
     leave it around for now, might still be helpful to trace the raw
     page mapcount value (e.g., including the page type).

 (3) mm/mm_init.c: to initialize the mapcount/type field to -1. Will be
     required until we decoupled type+mapcount (e.g., moving it into
     "struct folio"), and until we initialize the type+mapcount when
     allocating a folio.

 (4) mm/page_alloc.c: to sanity-check that the mapcount/type field is -1
     when a page gets freed. We could probably remove at least the tail
     page mapcount check in non-debug environments.

Some added ifdefery seems unavoidable for now: at least it's mostly
limited to the rmap add/remove core primitives.

Extend documentation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../admin-guide/cgroup-v1/memory.rst          |  4 ++
 Documentation/admin-guide/cgroup-v2.rst       | 10 ++-
 Documentation/filesystems/proc.rst            | 10 ++-
 Documentation/mm/transhuge.rst                | 31 +++++++---
 include/linux/mm_types.h                      |  4 ++
 include/linux/rmap.h                          | 10 ++-
 mm/internal.h                                 | 21 +++++--
 mm/page_alloc.c                               |  2 +
 mm/rmap.c                                     | 61 +++++++++++++++++++
 9 files changed, 133 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 270501db9f4e8..2e2bbf944eea9 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -615,6 +615,10 @@ memory.stat file includes following statistics:
 
 	'rss + mapped_file" will give you resident set size of cgroup.
 
+	Note that some kernel configurations might account complete larger
+	allocations (e.g., THP) towards 'rss' and 'mapped_file', even if
+	only some, but not all that memory is mapped.
+
 	(Note: file and shmem may be shared among other cgroups. In that case,
 	mapped_file is accounted only when the memory cgroup is owner of page
 	cache.)
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index e25e8b2698b95..039bdf49854f3 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1429,7 +1429,10 @@ The following nested keys are defined.
 
 	  anon
 		Amount of memory used in anonymous mappings such as
-		brk(), sbrk(), and mmap(MAP_ANONYMOUS)
+		brk(), sbrk(), and mmap(MAP_ANONYMOUS). Note that
+		some kernel configurations might account complete larger
+		allocations (e.g., THP) if only some, but not all the
+		memory of such an allocation is mapped anymore.
 
 	  file
 		Amount of memory used to cache filesystem data,
@@ -1472,7 +1475,10 @@ The following nested keys are defined.
 		Amount of application memory swapped out to zswap.
 
 	  file_mapped
-		Amount of cached filesystem data mapped with mmap()
+		Amount of cached filesystem data mapped with mmap(). Note
+		that some kernel configurations might account complete
+		larger allocations (e.g., THP) if only some, but not
+		not all the memory of such an allocation is mapped.
 
 	  file_dirty
 		Amount of cached filesystem data that was modified but
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 7cbab4135f244..c6d6474738577 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1148,9 +1148,15 @@ Dirty
 Writeback
               Memory which is actively being written back to the disk
 AnonPages
-              Non-file backed pages mapped into userspace page tables
+              Non-file backed pages mapped into userspace page tables. Note that
+              some kernel configurations might consider all pages part of a
+              larger allocation (e.g., THP) as "mapped", as soon as a single
+              page is mapped.
 Mapped
-              files which have been mmapped, such as libraries
+              files which have been mmapped, such as libraries. Note that some
+              kernel configurations might consider all pages part of a larger
+              allocation (e.g., THP) as "mapped", as soon as a single page is
+              mapped.
 Shmem
               Total memory used by shared memory (shmem) and tmpfs
 KReclaimable
diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index 0ee58108a4d14..0d34f3ac13d8c 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -116,23 +116,28 @@ pages:
     succeeds on tail pages.
 
   - map/unmap of a PMD entry for the whole THP increment/decrement
-    folio->_entire_mapcount, increment/decrement folio->_large_mapcount
-    and also increment/decrement folio->_nr_pages_mapped by ENTIRELY_MAPPED
-    when _entire_mapcount goes from -1 to 0 or 0 to -1.
+    folio->_entire_mapcount and folio->_large_mapcount.
 
     With CONFIG_MM_ID, we also maintain the two slots for tracking MM
     owners (MM ID and corresponding mapcount), and the current status
     ("mapped shared" vs. "mapped exclusively").
 
+    With CONFIG_PAGE_MAPCOUNT, we also increment/decrement
+    folio->_nr_pages_mapped by ENTIRELY_MAPPED when _entire_mapcount goes
+    from -1 to 0 or 0 to -1.
+
   - map/unmap of individual pages with PTE entry increment/decrement
-    page->_mapcount, increment/decrement folio->_large_mapcount and also
-    increment/decrement folio->_nr_pages_mapped when page->_mapcount goes
-    from -1 to 0 or 0 to -1 as this counts the number of pages mapped by PTE.
+    folio->_large_mapcount.
 
     With CONFIG_MM_ID, we also maintain the two slots for tracking MM
     owners (MM ID and corresponding mapcount), and the current status
     ("mapped shared" vs. "mapped exclusively").
 
+    With CONFIG_PAGE_MAPCOUNT, we also increment/decrement
+    page->_mapcount and increment/decrement folio->_nr_pages_mapped when
+    page->_mapcount goes from -1 to 0 or 0 to -1 as this counts the number
+    of pages mapped by PTE.
+
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
 structures. It can be done easily for refcounts taken by page table
@@ -159,8 +164,8 @@ clear where references should go after split: it will stay on the head page.
 Note that split_huge_pmd() doesn't have any limitations on refcounting:
 pmd can be split at any point and never fails.
 
-Partial unmap and deferred_split_folio()
-========================================
+Partial unmap and deferred_split_folio() (anon THP only)
+========================================================
 
 Unmapping part of THP (with munmap() or other way) is not going to free
 memory immediately. Instead, we detect that a subpage of THP is not in use
@@ -175,3 +180,13 @@ a THP crosses a VMA boundary.
 The function deferred_split_folio() is used to queue a folio for splitting.
 The splitting itself will happen when we get memory pressure via shrinker
 interface.
+
+With CONFIG_PAGE_MAPCOUNT, we reliably detect partial mappings based on
+folio->_nr_pages_mapped.
+
+With CONFIG_NO_PAGE_MAPCOUNT, we detect partial mappings based on the
+average per-page mapcount in a THP: if the average is < 1, an anon THP is
+certainly partially mapped. As long as only a single process maps a THP,
+this detection is reliable. With long-running child processes, there can
+be scenarios where partial mappings can currently not be detected, and
+might need asynchronous detection during memory reclaim in the future.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6d27856686439..2adf1839bcb0d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -378,7 +378,11 @@ struct folio {
 				struct {
 					atomic_t _large_mapcount;
 					atomic_t _entire_mapcount;
+#ifdef CONFIG_PAGE_MAPCOUNT
 					atomic_t _nr_pages_mapped;
+#else /* !CONFIG_PAGE_MAPCOUNT */
+					int _unused_1;
+#endif /* !CONFIG_PAGE_MAPCOUNT */
 					atomic_t _pincount;
 #ifdef CONFIG_MM_ID
 					int _mm0_mapcount;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index ff2a16864deed..345d93636b2b1 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -219,7 +219,7 @@ static __always_inline void folio_set_large_mapcount(struct folio *folio,
 	VM_WARN_ON_ONCE(folio->_mm1_mapcount >= 0);
 }
 
-static __always_inline void folio_add_large_mapcount(struct folio *folio,
+static __always_inline int folio_add_large_mapcount(struct folio *folio,
 		int diff, struct vm_area_struct *vma)
 {
 	const unsigned int mm_id = vma->vm_mm->mm_id;
@@ -264,11 +264,12 @@ static __always_inline void folio_add_large_mapcount(struct folio *folio,
 		folio_clear_large_mapped_exclusively(folio);
 	}
 	folio_unlock_large_mapcount_data(folio);
+	return mapcount_val + 1;
 }
 #define folio_inc_large_mapcount(folio, vma) \
 	folio_add_large_mapcount(folio, 1, vma)
 
-static __always_inline void folio_sub_large_mapcount(struct folio *folio,
+static __always_inline int folio_sub_large_mapcount(struct folio *folio,
 		int diff, struct vm_area_struct *vma)
 {
 	const unsigned int mm_id = vma->vm_mm->mm_id;
@@ -294,6 +295,7 @@ static __always_inline void folio_sub_large_mapcount(struct folio *folio,
 	    folio->_mm1_mapcount == mapcount_val)
 		folio_set_large_mapped_exclusively(folio);
 	folio_unlock_large_mapcount_data(folio);
+	return mapcount_val + 1;
 }
 #define folio_dec_large_mapcount(folio, vma) \
 	folio_sub_large_mapcount(folio, 1, vma)
@@ -493,9 +495,11 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 			break;
 		}
 
+#ifdef CONFIG_PAGE_MAPCOUNT
 		do {
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
+#endif
 		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
 	case RMAP_LEVEL_PMD:
@@ -592,7 +596,9 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		do {
 			if (PageAnonExclusive(page))
 				ClearPageAnonExclusive(page);
+#ifdef CONFIG_PAGE_MAPCOUNT
 			atomic_inc(&page->_mapcount);
+#endif
 		} while (page++, --nr_pages > 0);
 		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
diff --git a/mm/internal.h b/mm/internal.h
index da38c747c73d4..9fb78ce3c2eb3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -60,6 +60,13 @@ struct folio_batch;
 
 void page_writeback_init(void);
 
+/*
+ * Flags passed to __show_mem() and show_free_areas() to suppress output in
+ * various contexts.
+ */
+#define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
+
+#ifdef CONFIG_PAGE_MAPCOUNT
 /*
  * If a 16GB hugetlb folio were mapped by PTEs of all of its 4kB pages,
  * its nr_pages_mapped would be 0x400000: choose the ENTIRELY_MAPPED bit
@@ -69,12 +76,6 @@ void page_writeback_init(void);
 #define ENTIRELY_MAPPED		0x800000
 #define FOLIO_PAGES_MAPPED	(ENTIRELY_MAPPED - 1)
 
-/*
- * Flags passed to __show_mem() and show_free_areas() to suppress output in
- * various contexts.
- */
-#define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
-
 /*
  * How many individual pages have an elevated _mapcount.  Excludes
  * the folio's entire_mapcount.
@@ -85,6 +86,12 @@ static inline int folio_nr_pages_mapped(const struct folio *folio)
 {
 	return atomic_read(&folio->_nr_pages_mapped) & FOLIO_PAGES_MAPPED;
 }
+#else /* !CONFIG_PAGE_MAPCOUNT */
+static inline int folio_nr_pages_mapped(const struct folio *folio)
+{
+	return -1;
+}
+#endif /* !CONFIG_PAGE_MAPCOUNT */
 
 /*
  * Retrieve the first entry of a folio based on a provided entry within the
@@ -663,7 +670,9 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	folio_set_order(folio, order);
 	atomic_set(&folio->_large_mapcount, -1);
 	atomic_set(&folio->_entire_mapcount, -1);
+#ifdef CONFIG_PAGE_MAPCOUNT
 	atomic_set(&folio->_nr_pages_mapped, 0);
+#endif /* CONFIG_PAGE_MAPCOUNT */
 	atomic_set(&folio->_pincount, 0);
 #ifdef CONFIG_MM_ID
 	folio->_mm0_mapcount = -1;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c81f29e29b82d..bdb57540cdffa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -951,10 +951,12 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero large_mapcount");
 			goto out;
 		}
+#ifdef CONFIG_PAGE_MAPCOUNT
 		if (unlikely(atomic_read(&folio->_nr_pages_mapped))) {
 			bad_page(page, "nonzero nr_pages_mapped");
 			goto out;
 		}
+#endif
 		if (unlikely(atomic_read(&folio->_pincount))) {
 			bad_page(page, "nonzero pincount");
 			goto out;
diff --git a/mm/rmap.c b/mm/rmap.c
index 226b188499f91..888394ff9dd5b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1156,7 +1156,9 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level, int *nr_pmdmapped)
 {
+#ifdef CONFIG_PAGE_MAPCOUNT
 	atomic_t *mapped = &folio->_nr_pages_mapped;
+#endif /* CONFIG_PAGE_MAPCOUNT */
 	const int orig_nr_pages = nr_pages;
 	int first = 0, nr = 0;
 
@@ -1169,6 +1171,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 			break;
 		}
 
+#ifdef CONFIG_PAGE_MAPCOUNT
 		do {
 			first += atomic_inc_and_test(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
@@ -1178,9 +1181,18 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 			nr = first;
 
 		folio_add_large_mapcount(folio, orig_nr_pages, vma);
+#else /* !CONFIG_PAGE_MAPCOUNT */
+		nr = folio_add_large_mapcount(folio, orig_nr_pages, vma);
+		if (nr == orig_nr_pages)
+			/* Was completely unmapped. */
+			nr = folio_large_nr_pages(folio);
+		else
+			nr = 0;
+#endif /* CONFIG_PAGE_MAPCOUNT */
 		break;
 	case RMAP_LEVEL_PMD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
+#ifdef CONFIG_PAGE_MAPCOUNT
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
@@ -1195,6 +1207,16 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 			}
 		}
 		folio_inc_large_mapcount(folio, vma);
+#else /* !CONFIG_PAGE_MAPCOUNT */
+		if (first)
+			*nr_pmdmapped = folio_large_nr_pages(folio);
+		nr = folio_inc_large_mapcount(folio, vma);
+		if (nr == 1)
+			/* Was completely unmapped. */
+			nr = folio_large_nr_pages(folio);
+		else
+			nr = 0;
+#endif /* CONFIG_PAGE_MAPCOUNT */
 		break;
 	}
 	return nr;
@@ -1332,6 +1354,7 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 			break;
 		}
 	}
+#ifdef CONFIG_PAGE_MAPCOUNT
 	for (i = 0; i < nr_pages; i++) {
 		struct page *cur_page = page + i;
 
@@ -1341,6 +1364,10 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 				   folio_entire_mapcount(folio) > 1)) &&
 				 PageAnonExclusive(cur_page), folio);
 	}
+#else /* !CONFIG_PAGE_MAPCOUNT */
+	VM_WARN_ON_FOLIO(!folio_test_large(folio) && PageAnonExclusive(page) &&
+			 atomic_read(&folio->_mapcount) > 0, folio);
+#endif /* !CONFIG_PAGE_MAPCOUNT */
 
 	/*
 	 * For large folio, only mlock it if it's fully mapped to VMA. It's
@@ -1445,19 +1472,25 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 			struct page *page = folio_page(folio, i);
 
 			/* increment count (starts at -1) */
+#ifdef CONFIG_PAGE_MAPCOUNT
 			atomic_set(&page->_mapcount, 0);
+#endif /* CONFIG_PAGE_MAPCOUNT */
 			if (exclusive)
 				SetPageAnonExclusive(page);
 		}
 
 		folio_set_large_mapcount(folio, nr, vma);
+#ifdef CONFIG_PAGE_MAPCOUNT
 		atomic_set(&folio->_nr_pages_mapped, nr);
+#endif /* CONFIG_PAGE_MAPCOUNT */
 	} else {
 		nr = folio_large_nr_pages(folio);
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
 		folio_set_large_mapcount(folio, 1, vma);
+#ifdef CONFIG_PAGE_MAPCOUNT
 		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
+#endif /* CONFIG_PAGE_MAPCOUNT */
 		if (exclusive)
 			SetPageAnonExclusive(&folio->page);
 		nr_pmdmapped = nr;
@@ -1527,7 +1560,9 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
 {
+#ifdef CONFIG_PAGE_MAPCOUNT
 	atomic_t *mapped = &folio->_nr_pages_mapped;
+#endif /* CONFIG_PAGE_MAPCOUNT */
 	int last = 0, nr = 0, nr_pmdmapped = 0;
 	bool partially_mapped = false;
 
@@ -1540,6 +1575,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			break;
 		}
 
+#ifdef CONFIG_PAGE_MAPCOUNT
 		folio_sub_large_mapcount(folio, nr_pages, vma);
 		do {
 			last += atomic_add_negative(-1, &page->_mapcount);
@@ -1550,8 +1586,20 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			nr = last;
 
 		partially_mapped = nr && atomic_read(mapped);
+#else /* !CONFIG_PAGE_MAPCOUNT */
+		nr = folio_sub_large_mapcount(folio, nr_pages, vma);
+		if (!nr) {
+			/* Now completely unmapped. */
+			nr = folio_nr_pages(folio);
+		} else {
+			partially_mapped = nr < folio_large_nr_pages(folio) &&
+					   !folio_entire_mapcount(folio);
+			nr = 0;
+		}
+#endif /* !CONFIG_PAGE_MAPCOUNT */
 		break;
 	case RMAP_LEVEL_PMD:
+#ifdef CONFIG_PAGE_MAPCOUNT
 		folio_dec_large_mapcount(folio, vma);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
@@ -1569,6 +1617,19 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		}
 
 		partially_mapped = nr && nr < nr_pmdmapped;
+#else /* !CONFIG_PAGE_MAPCOUNT */
+		last = atomic_add_negative(-1, &folio->_entire_mapcount);
+		if (last)
+			nr_pmdmapped = folio_large_nr_pages(folio);
+		nr = folio_dec_large_mapcount(folio, vma);
+		if (!nr) {
+			/* Now completely unmapped. */
+			nr = folio_large_nr_pages(folio);
+		} else {
+			partially_mapped = last && nr < folio_large_nr_pages(folio);
+			nr = 0;
+		}
+#endif /* !CONFIG_PAGE_MAPCOUNT */
 		break;
 	}
 
-- 
2.46.0


