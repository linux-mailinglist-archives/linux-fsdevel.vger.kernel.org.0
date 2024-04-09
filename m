Return-Path: <linux-fsdevel+bounces-16475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65C289E34C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2984AB23AAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B6157A44;
	Tue,  9 Apr 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvS5lACJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34791157A51
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690674; cv=none; b=BYKojbQ3I9yHtuAPOobpH3gjdnVjk5Rm0/ZxvbMI/waOZcXQAZbrIaI2j2DlM0nnbYCWC9DmTk6pnUOHAfuLodqpmI8lqQybST1GUqQNVi812ymq8uSFiGwbax0eAg5tU/XANrXg31sHIZSNGj0DXnPvWsrwZ6Vw3M83bpOEp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690674; c=relaxed/simple;
	bh=mHS7+7SOJGpgEpvVdLTxHciXo/6JLTOh2rJC9kqTmfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcbcQfW9S3qLziYK8b2HIWGcdCX6hBVeAB2+pA7R4PXnU2R3P5K3o4d+Mh3tyfN79c38i47xlILKKMtYLhjZgOTMjM5z2nmPqv1VUXIaUsqoVVbejqYtLBnp3UTLzd5qmoNvZIcfjTvoyR/P0LC+r0Ta2QaKxXWq/zd9X+YbisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvS5lACJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sssR1z2Cns5/cDlwFg0C+rTVPaBVC9TbP1UmPuFLGM8=;
	b=gvS5lACJZdZpqZfNiE3gaqr/mcHpJ+XqP1aG4HpkfbuibyHPsy7u3EbBFZcv8HhBPAEdXT
	dM/OwrymA6tZlQVPquCgICU3salU+sz9ZmNeIsCspvsYTdUQAq2RZtS59hRdV1cV7jXcTw
	Im7KV92wDNgH2cndby3YdEwUgp6lTjo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-tXAOl0sKNr2RokYkQkyf6Q-1; Tue,
 09 Apr 2024 15:24:23 -0400
X-MC-Unique: tXAOl0sKNr2RokYkQkyf6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A202A3C025AD;
	Tue,  9 Apr 2024 19:24:22 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3405E40B4980;
	Tue,  9 Apr 2024 19:24:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: [PATCH v1 04/18] mm: track mapcount of large folios in single value
Date: Tue,  9 Apr 2024 21:22:47 +0200
Message-ID: <20240409192301.907377-5-david@redhat.com>
In-Reply-To: <20240409192301.907377-1-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Let's track the mapcount of large folios in a single value. The mapcount of
a large folio currently corresponds to the sum of the entire mapcount and
all page mapcounts.

This sum is what we actually want to know in folio_mapcount() and it is
also sufficient for implementing folio_mapped().

With PTE-mapped THP becoming more important and more widely used, we want
to avoid looping over all pages of a folio just to obtain the mapcount
of large folios. The comment "In the common case, avoid the loop when no
pages mapped by PTE" in folio_total_mapcount() does no longer hold for
mTHP that are always mapped by PTE.

Further, we are planning on using folio_mapcount() more
frequently, and might even want to remove page mapcounts for large
folios in some kernel configs. Therefore, allow for reading the mapcount of
large folios efficiently and atomically without looping over any pages.

Maintain the mapcount also for hugetlb pages for simplicity. Use the new
mapcount to implement folio_mapcount() and folio_mapped(). Make
page_mapped() simply call folio_mapped(). We can now get rid of
folio_large_is_mapped().

_nr_pages_mapped is now only used in rmap code and for debugging
purposes. Keep folio_nr_pages_mapped() around, but document that its use
should be limited to rmap internals and debugging purposes.

This change implies one additional atomic add/sub whenever
mapping/unmapping (parts of) a large folio.

As we now batch RMAP operations for PTE-mapped THP during fork(),
during unmap/zap, and when PTE-remapping a PMD-mapped THP, and we adjust
the large mapcount for a PTE batch only once, the added overhead in the
common case is small. Only when unmapping individual pages of a large folio
(e.g., during COW), the overhead might be bigger in comparison, but it's
essentially one additional atomic operation.

Note that before the new mapcount would overflow, already our refcount
would overflow: each mapping requires a folio reference. Extend the
focumentation of folio_mapcount().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/transhuge.rst | 12 +++++-----
 include/linux/mm.h             | 44 ++++++++++++++++------------------
 include/linux/mm_types.h       |  5 ++--
 include/linux/rmap.h           | 10 ++++++++
 mm/debug.c                     |  3 ++-
 mm/hugetlb.c                   |  4 ++--
 mm/internal.h                  |  3 +++
 mm/khugepaged.c                |  2 +-
 mm/page_alloc.c                |  4 ++++
 mm/rmap.c                      | 34 +++++++++-----------------
 10 files changed, 62 insertions(+), 59 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index 93c9239b9ebe..1ba0ad63246c 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -116,14 +116,14 @@ pages:
     succeeds on tail pages.
 
   - map/unmap of a PMD entry for the whole THP increment/decrement
-    folio->_entire_mapcount and also increment/decrement
-    folio->_nr_pages_mapped by ENTIRELY_MAPPED when _entire_mapcount
-    goes from -1 to 0 or 0 to -1.
+    folio->_entire_mapcount, increment/decrement folio->_large_mapcount
+    and also increment/decrement folio->_nr_pages_mapped by ENTIRELY_MAPPED
+    when _entire_mapcount goes from -1 to 0 or 0 to -1.
 
   - map/unmap of individual pages with PTE entry increment/decrement
-    page->_mapcount and also increment/decrement folio->_nr_pages_mapped
-    when page->_mapcount goes from -1 to 0 or 0 to -1 as this counts
-    the number of pages mapped by PTE.
+    page->_mapcount, increment/decrement folio->_large_mapcount and also
+    increment/decrement folio->_nr_pages_mapped when page->_mapcount goes
+    from -1 to 0 or 0 to -1 as this counts the number of pages mapped by PTE.
 
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0fb8a40f82dd..1862a216af15 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1239,16 +1239,26 @@ static inline int page_mapcount(struct page *page)
 	return mapcount;
 }
 
-int folio_total_mapcount(const struct folio *folio);
+static inline int folio_large_mapcount(const struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_large(folio), folio);
+	return atomic_read(&folio->_large_mapcount) + 1;
+}
 
 /**
- * folio_mapcount() - Calculate the number of mappings of this folio.
+ * folio_mapcount() - Number of mappings of this folio.
  * @folio: The folio.
  *
- * A large folio tracks both how many times the entire folio is mapped,
- * and how many times each individual page in the folio is mapped.
- * This function calculates the total number of times the folio is
- * mapped.
+ * The folio mapcount corresponds to the number of present user page table
+ * entries that reference any part of a folio. Each such present user page
+ * table entry must be paired with exactly on folio reference.
+ *
+ * For ordindary folios, each user page table entry (PTE/PMD/PUD/...) counts
+ * exactly once.
+ *
+ * For hugetlb folios, each abstracted "hugetlb" user page table entry that
+ * references the entire folio counts exactly once, even when such special
+ * page table entries are comprised of multiple ordinary page table entries.
  *
  * Return: The number of times this folio is mapped.
  */
@@ -1256,17 +1266,7 @@ static inline int folio_mapcount(const struct folio *folio)
 {
 	if (likely(!folio_test_large(folio)))
 		return atomic_read(&folio->_mapcount) + 1;
-	return folio_total_mapcount(folio);
-}
-
-static inline bool folio_large_is_mapped(const struct folio *folio)
-{
-	/*
-	 * Reading _entire_mapcount below could be omitted if hugetlb
-	 * participated in incrementing nr_pages_mapped when compound mapped.
-	 */
-	return atomic_read(&folio->_nr_pages_mapped) > 0 ||
-		atomic_read(&folio->_entire_mapcount) >= 0;
+	return folio_large_mapcount(folio);
 }
 
 /**
@@ -1275,11 +1275,9 @@ static inline bool folio_large_is_mapped(const struct folio *folio)
  *
  * Return: True if any page in this folio is referenced by user page tables.
  */
-static inline bool folio_mapped(struct folio *folio)
+static inline bool folio_mapped(const struct folio *folio)
 {
-	if (likely(!folio_test_large(folio)))
-		return atomic_read(&folio->_mapcount) >= 0;
-	return folio_large_is_mapped(folio);
+	return folio_mapcount(folio) >= 1;
 }
 
 /*
@@ -1289,9 +1287,7 @@ static inline bool folio_mapped(struct folio *folio)
  */
 static inline bool page_mapped(const struct page *page)
 {
-	if (likely(!PageCompound(page)))
-		return atomic_read(&page->_mapcount) >= 0;
-	return folio_large_is_mapped(page_folio(page));
+	return folio_mapped(page_folio(page));
 }
 
 static inline struct page *virt_to_head_page(const void *x)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4260c595a79d..c432add95913 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -289,7 +289,8 @@ typedef struct {
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
- * @_nr_pages_mapped: Do not use directly, call folio_mapcount().
+ * @_large_mapcount: Do not use directly, call folio_mapcount().
+ * @_nr_pages_mapped: Do not use outside of rmap and debug code.
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
@@ -348,8 +349,8 @@ struct folio {
 		struct {
 			unsigned long _flags_1;
 			unsigned long _head_1;
-			unsigned long _folio_avail;
 	/* public: */
+			atomic_t _large_mapcount;
 			atomic_t _entire_mapcount;
 			atomic_t _nr_pages_mapped;
 			atomic_t _pincount;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 327f1ca5a487..0f906dc6d280 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -273,6 +273,7 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 		ClearPageAnonExclusive(&folio->page);
 	}
 	atomic_inc(&folio->_entire_mapcount);
+	atomic_inc(&folio->_large_mapcount);
 	return 0;
 }
 
@@ -306,6 +307,7 @@ static inline void hugetlb_add_file_rmap(struct folio *folio)
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
 	atomic_inc(&folio->_entire_mapcount);
+	atomic_inc(&folio->_large_mapcount);
 }
 
 static inline void hugetlb_remove_rmap(struct folio *folio)
@@ -313,11 +315,14 @@ static inline void hugetlb_remove_rmap(struct folio *folio)
 	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 
 	atomic_dec(&folio->_entire_mapcount);
+	atomic_dec(&folio->_large_mapcount);
 }
 
 static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		struct page *page, int nr_pages, enum rmap_level level)
 {
+	const int orig_nr_pages = nr_pages;
+
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
 	switch (level) {
@@ -330,9 +335,11 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		do {
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
+		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
 		atomic_inc(&folio->_entire_mapcount);
+		atomic_inc(&folio->_large_mapcount);
 		break;
 	}
 }
@@ -382,6 +389,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *src_vma,
 		enum rmap_level level)
 {
+	const int orig_nr_pages = nr_pages;
 	bool maybe_pinned;
 	int i;
 
@@ -423,6 +431,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 				ClearPageAnonExclusive(page);
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
+		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
 		if (PageAnonExclusive(page)) {
@@ -431,6 +440,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 			ClearPageAnonExclusive(page);
 		}
 		atomic_inc(&folio->_entire_mapcount);
+		atomic_inc(&folio->_large_mapcount);
 		break;
 	}
 	return 0;
diff --git a/mm/debug.c b/mm/debug.c
index b71186f1fb0b..d064db42af54 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -68,8 +68,9 @@ static void __dump_folio(struct folio *folio, struct page *page,
 			folio_ref_count(folio), mapcount, mapping,
 			folio->index + idx, pfn);
 	if (folio_test_large(folio)) {
-		pr_warn("head: order:%u entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
+		pr_warn("head: order:%u mapcount:%d entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
 				folio_order(folio),
+				folio_mapcount(folio),
 				folio_entire_mapcount(folio),
 				folio_nr_pages_mapped(folio),
 				atomic_read(&folio->_pincount));
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 454900c84b30..a8536349de13 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1517,7 +1517,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
 	struct page *p;
 
 	atomic_set(&folio->_entire_mapcount, 0);
-	atomic_set(&folio->_nr_pages_mapped, 0);
+	atomic_set(&folio->_large_mapcount, 0);
 	atomic_set(&folio->_pincount, 0);
 
 	for (i = 1; i < nr_pages; i++) {
@@ -2120,7 +2120,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 	/* we rely on prep_new_hugetlb_folio to set the hugetlb flag */
 	folio_set_order(folio, order);
 	atomic_set(&folio->_entire_mapcount, -1);
-	atomic_set(&folio->_nr_pages_mapped, 0);
+	atomic_set(&folio->_large_mapcount, -1);
 	atomic_set(&folio->_pincount, 0);
 	return true;
 
diff --git a/mm/internal.h b/mm/internal.h
index 9d3250b4a08a..51fa6246769c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -72,6 +72,8 @@ void page_writeback_init(void);
 /*
  * How many individual pages have an elevated _mapcount.  Excludes
  * the folio's entire_mapcount.
+ *
+ * Don't use this function outside of debugging code.
  */
 static inline int folio_nr_pages_mapped(const struct folio *folio)
 {
@@ -610,6 +612,7 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	struct folio *folio = (struct folio *)page;
 
 	folio_set_order(folio, order);
+	atomic_set(&folio->_large_mapcount, -1);
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
 	atomic_set(&folio->_pincount, 0);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 89e2624fb3ff..2f73d2aa9ae8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1358,7 +1358,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * Check if the page has any GUP (or other external) pins.
 		 *
 		 * Here the check may be racy:
-		 * it may see total_mapcount > refcount in some cases?
+		 * it may see folio_mapcount() > folio_ref_count().
 		 * But such case is ephemeral we could always retry collapse
 		 * later.  However it may report false positive if the page
 		 * has excessive GUP pins (i.e. 512).  Anyway the same check
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index adbb7e6e0c72..393366d4a704 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -941,6 +941,10 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero entire_mapcount");
 			goto out;
 		}
+		if (unlikely(folio_large_mapcount(folio))) {
+			bad_page(page, "nonzero large_mapcount");
+			goto out;
+		}
 		if (unlikely(atomic_read(&folio->_nr_pages_mapped))) {
 			bad_page(page, "nonzero nr_pages_mapped");
 			goto out;
diff --git a/mm/rmap.c b/mm/rmap.c
index 4bde6d60db6c..2608c40dffad 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1138,34 +1138,12 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 	return page_vma_mkclean_one(&pvmw);
 }
 
-int folio_total_mapcount(const struct folio *folio)
-{
-	int mapcount = folio_entire_mapcount(folio);
-	int nr_pages;
-	int i;
-
-	/* In the common case, avoid the loop when no pages mapped by PTE */
-	if (folio_nr_pages_mapped(folio) == 0)
-		return mapcount;
-	/*
-	 * Add all the PTE mappings of those pages mapped by PTE.
-	 * Limit the loop to folio_nr_pages_mapped()?
-	 * Perhaps: given all the raciness, that may be a good or a bad idea.
-	 */
-	nr_pages = folio_nr_pages(folio);
-	for (i = 0; i < nr_pages; i++)
-		mapcount += atomic_read(&folio_page(folio, i)->_mapcount);
-
-	/* But each of those _mapcounts was based on -1 */
-	mapcount += nr_pages;
-	return mapcount;
-}
-
 static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		struct page *page, int nr_pages, enum rmap_level level,
 		int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
+	const int orig_nr_pages = nr_pages;
 	int first, nr = 0;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
@@ -1185,6 +1163,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 					nr++;
 			}
 		} while (page++, --nr_pages > 0);
+		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
@@ -1201,6 +1180,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 				nr = 0;
 			}
 		}
+		atomic_inc(&folio->_large_mapcount);
 		break;
 	}
 	return nr;
@@ -1436,10 +1416,14 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 			SetPageAnonExclusive(page);
 		}
 
+		/* increment count (starts at -1) */
+		atomic_set(&folio->_large_mapcount, nr - 1);
 		atomic_set(&folio->_nr_pages_mapped, nr);
 	} else {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
+		/* increment count (starts at -1) */
+		atomic_set(&folio->_large_mapcount, 0);
 		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		SetPageAnonExclusive(&folio->page);
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
@@ -1522,6 +1506,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			break;
 		}
 
+		atomic_sub(nr_pages, &folio->_large_mapcount);
 		do {
 			last = atomic_add_negative(-1, &page->_mapcount);
 			if (last) {
@@ -1532,6 +1517,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		} while (page++, --nr_pages > 0);
 		break;
 	case RMAP_LEVEL_PMD:
+		atomic_dec(&folio->_large_mapcount);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
@@ -2714,6 +2700,7 @@ void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 	atomic_inc(&folio->_entire_mapcount);
+	atomic_inc(&folio->_large_mapcount);
 	if (flags & RMAP_EXCLUSIVE)
 		SetPageAnonExclusive(&folio->page);
 	VM_WARN_ON_FOLIO(folio_entire_mapcount(folio) > 1 &&
@@ -2728,6 +2715,7 @@ void hugetlb_add_new_anon_rmap(struct folio *folio,
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	/* increment count (starts at -1) */
 	atomic_set(&folio->_entire_mapcount, 0);
+	atomic_set(&folio->_large_mapcount, 0);
 	folio_clear_hugetlb_restore_reserve(folio);
 	__folio_set_anon(folio, vma, address, true);
 	SetPageAnonExclusive(&folio->page);
-- 
2.44.0


