Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59D33AEBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 10:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCOJ1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 05:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhCOJ1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:27:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFD7C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 02:27:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a8so8480854plp.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyHfqAIZLhrT0oCSnpDGn99/WbkxHK6FrGf+RKUyWk0=;
        b=x1DwkcphMcCiItUFNcV57RePeAyPh5bxPZbvyZsP4nwhSbXM7feXYwbfeI+czsVU3s
         3ZC9vTnyGHbYhDI4QS3yTwOgBzkS6nWCGIGUesNnMod2fqLT2ZqWVgXKxzlCsA4j0LJ0
         gQpOjXQp/IXXMIUCpvxmJAy2TaGf0IR4XnhXJUMs+mYkHbEsz1l63UlQmrzsnf+09xFZ
         ELHMbW5OoqyBZyJTlqBUDzrhWGtqiPDLSAPEChQrJz3JDtxG+wqp93gs7GhemzyBss29
         iRCfN2Jhscy+1MVDgKqyLxgq2KkXTy/tiB761mk0KY+6oJHpYmmdHHc09sRUza/vtrd8
         AKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyHfqAIZLhrT0oCSnpDGn99/WbkxHK6FrGf+RKUyWk0=;
        b=sIJUAPObT3sqQsLTIgXVmywUZazHBkQ/psugYvWJ6aHXhy+NDD1gU3mBlNnsk79enS
         oN1mKN8jBmyif6Z7RRZmn4Wo39Kp2LT0HZW7ahHYWsDn94z4vDvAJeRI0I8+DeEnyl6e
         8UqnDViHPdZ4Gaubk9Sb8De55JlnqCGzrmuZO3J9wY1q994+oBTSmHJvHi1XvUFl5rOL
         FCIRdL6qO8bSlYOS9fIbVHvAO77/cOxQkULaRMA/GumpZOuD6izSqdLczHAi5xOu8qMT
         ii8d+Pz0nAigpHSTGMGbJZKEpiTXw34Hhd9MbrswTCFzFed418opgkWXPCOkLpZn9BNE
         OdYw==
X-Gm-Message-State: AOAM533mi65rfmW8Tc7//5UA/BS2FeqqB07u1uX3aBhm17fjaWTBBRhb
        sbcAx2moP5OvYWC8w/mWhIuJXw==
X-Google-Smtp-Source: ABdhPJzhFc7oT3umqMxqMXjzrzBgwPzmc9Kp3ONht/7EVhLCS86Bp445Ifs88zpQgldMuLWcWIA+vg==
X-Received: by 2002:a17:90b:20c:: with SMTP id fy12mr11847034pjb.41.1615800423715;
        Mon, 15 Mar 2021 02:27:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id gm10sm10607883pjb.4.2021.03.15.02.26.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:27:03 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v19 5/8] mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page
Date:   Mon, 15 Mar 2021 17:20:12 +0800
Message-Id: <20210315092015.35396-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210315092015.35396-1-songmuchun@bytedance.com>
References: <20210315092015.35396-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we free a HugeTLB page to the buddy allocator, we need to allocate
the vmemmap pages associated with it. However, we may not be able to
allocate the vmemmap pages when the system is under memory pressure. In
this case, we just refuse to free the HugeTLB page. This changes behavior
in some corner cases as listed below:

 1) Failing to free a huge page triggered by the user (decrease nr_pages).

    User needs to try again later.

 2) Failing to free a surplus huge page when freed by the application.

    Try again later when freeing a huge page next time.

 3) Failing to dissolve a free huge page on ZONE_MOVABLE via
    offline_pages().

    This can happen when we have plenty of ZONE_MOVABLE memory, but
    not enough kernel memory to allocate vmemmmap pages.  We may even
    be able to migrate huge page contents, but will not be able to
    dissolve the source huge page.  This will prevent an offline
    operation and is unfortunate as memory offlining is expected to
    succeed on movable zones.  Users that depend on memory hotplug
    to succeed for movable zones should carefully consider whether the
    memory savings gained from this feature are worth the risk of
    possibly not being able to offline memory in certain situations.

 4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
    alloc_contig_range() - once we have that handling in place. Mainly
    affects CMA and virtio-mem.

    Similar to 3). virito-mem will handle migration errors gracefully.
    CMA might be able to fallback on other free areas within the CMA
    region.

Vmemmap pages are allocated from the page freeing context. In order for
those allocations to be not disruptive (e.g. trigger oom killer)
__GFP_NORETRY is used. hugetlb_lock is dropped for the allocation
because a non sleeping allocation would be too fragile and it could fail
too easily under memory pressure. GFP_ATOMIC or other modes to access
memory reserves is not used because we want to prevent consuming
reserves under heavy hugetlb freeing.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 Documentation/admin-guide/mm/hugetlbpage.rst    |  8 +++
 Documentation/admin-guide/mm/memory-hotplug.rst | 13 +++++
 include/linux/mm.h                              |  2 +
 mm/hugetlb.c                                    | 76 ++++++++++++++++++++-----
 mm/hugetlb_vmemmap.c                            | 43 +++++++++-----
 mm/hugetlb_vmemmap.h                            | 23 ++++++++
 mm/sparse-vmemmap.c                             | 75 +++++++++++++++++++++++-
 7 files changed, 211 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index f7b1c7462991..6988895d09a8 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -60,6 +60,10 @@ HugePages_Surp
         the pool above the value in ``/proc/sys/vm/nr_hugepages``. The
         maximum number of surplus huge pages is controlled by
         ``/proc/sys/vm/nr_overcommit_hugepages``.
+	Note: When the feature of freeing unused vmemmap pages associated
+	with each hugetlb page is enabled, the number of surplus huge pages
+	may be temporarily larger than the maximum number of surplus huge
+	pages when the system is under memory pressure.
 Hugepagesize
 	is the default hugepage size (in Kb).
 Hugetlb
@@ -80,6 +84,10 @@ returned to the huge page pool when freed by a task.  A user with root
 privileges can dynamically allocate more or free some persistent huge pages
 by increasing or decreasing the value of ``nr_hugepages``.
 
+Note: When the feature of freeing unused vmemmap pages associated with each
+hugetlb page is enabled, we can fail to free the huge pages triggered by
+the user when ths system is under memory pressure.  Please try again later.
+
 Pages that are used as huge pages are reserved inside the kernel and cannot
 be used for other purposes.  Huge pages cannot be swapped out under
 memory pressure.
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 5307f90738aa..05b2316983d6 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -357,6 +357,19 @@ creates ZONE_MOVABLE as following.
    Unfortunately, there is no information to show which memory block belongs
    to ZONE_MOVABLE. This is TBD.
 
+   Memory offlining can fail when dissolving a free huge page on ZONE_MOVABLE
+   and the feature of freeing unused vmemmap pages associated with each hugetlb
+   page is enabled.
+
+   This can happen when we have plenty of ZONE_MOVABLE memory, but not enough
+   kernel memory to allocate vmemmmap pages.  We may even be able to migrate
+   huge page contents, but will not be able to dissolve the source huge page.
+   This will prevent an offline operation and is unfortunate as memory offlining
+   is expected to succeed on movable zones.  Users that depend on memory hotplug
+   to succeed for movable zones should carefully consider whether the memory
+   savings gained from this feature are worth the risk of possibly not being
+   able to offline memory in certain situations.
+
 .. _memory_hotplug_how_to_offline_memory:
 
 How to offline memory
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4ddfc31f21c6..77693c944a36 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2973,6 +2973,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 
 void vmemmap_remap_free(unsigned long start, unsigned long end,
 			unsigned long reuse);
+int vmemmap_remap_alloc(unsigned long start, unsigned long end,
+			unsigned long reuse, gfp_t gfp_mask);
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 43fed6785322..e42b19337a8f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1304,16 +1304,53 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
-static void update_and_free_page(struct hstate *h, struct page *page)
+static int update_and_free_page_surplus(struct hstate *h, struct page *page,
+					bool acct_surplus)
+	__releases(&hugetlb_lock) __acquires(&hugetlb_lock)
 {
 	int i;
 	struct page *subpage = page;
+	int nid = page_to_nid(page);
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
-		return;
+		return 0;
 
 	h->nr_huge_pages--;
-	h->nr_huge_pages_node[page_to_nid(page)]--;
+	h->nr_huge_pages_node[nid]--;
+
+	/*
+	 * If the vmemmap pages associated with the HugeTLB page can be
+	 * optimized, we might block in alloc_huge_page_vmemmap(), so
+	 * drop the hugetlb_lock.
+	 */
+	if (free_vmemmap_pages_per_hpage(h))
+		spin_unlock(&hugetlb_lock);
+
+	if (alloc_huge_page_vmemmap(h, page)) {
+		spin_lock(&hugetlb_lock);
+		INIT_LIST_HEAD(&page->lru);
+		h->nr_huge_pages++;
+		h->nr_huge_pages_node[nid]++;
+
+		/*
+		 * If we cannot allocate vmemmap pages, just refuse to free the
+		 * page and put the page back on the hugetlb free list and treat
+		 * as a surplus page.
+		 */
+		if (acct_surplus) {
+			h->surplus_huge_pages++;
+			h->surplus_huge_pages_node[nid]++;
+		}
+
+		arch_clear_hugepage_flags(page);
+		enqueue_huge_page(h, page);
+
+		return -ENOMEM;
+	}
+
+	if (free_vmemmap_pages_per_hpage(h))
+		spin_lock(&hugetlb_lock);
+
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1337,6 +1374,13 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
+
+	return 0;
+}
+
+static inline int update_and_free_page(struct hstate *h, struct page *page)
+{
+	return update_and_free_page_surplus(h, page, true);
 }
 
 struct hstate *size_to_hstate(unsigned long size)
@@ -1404,9 +1448,9 @@ static void __free_huge_page(struct page *page)
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		list_del(&page->lru);
-		update_and_free_page(h, page);
 		h->surplus_huge_pages--;
 		h->surplus_huge_pages_node[nid]--;
+		update_and_free_page(h, page);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
@@ -1447,7 +1491,7 @@ void free_huge_page(struct page *page)
 	/*
 	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
 	 */
-	if (!in_task()) {
+	if (in_atomic()) {
 		/*
 		 * Only call schedule_work() if hpage_freelist is previously
 		 * empty. Otherwise, schedule_work() had been called but the
@@ -1693,14 +1737,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 				list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
 			list_del(&page->lru);
+			ClearHPageFreed(page);
 			h->free_huge_pages--;
 			h->free_huge_pages_node[node]--;
 			if (acct_surplus) {
 				h->surplus_huge_pages--;
 				h->surplus_huge_pages_node[node]--;
 			}
-			update_and_free_page(h, page);
-			ret = 1;
+			ret = !update_and_free_page(h, page);
 			break;
 		}
 	}
@@ -1713,10 +1757,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
  * nothing for in-use hugepages and non-hugepages.
  * This function returns values like below:
  *
- *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
- *          (allocated or reserved.)
- *       0: successfully dissolved free hugepages or the page is not a
- *          hugepage (considered as already dissolved)
+ *  -ENOMEM: failed to allocate vmemmap pages to free the freed hugepages
+ *           when the system is under memory pressure and the feature of
+ *           freeing unused vmemmap pages associated with each hugetlb page
+ *           is enabled.
+ *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-use
+ *           (allocated or reserved.)
+ *       0:  successfully dissolved free hugepages or the page is not a
+ *           hugepage (considered as already dissolved)
  */
 int dissolve_free_huge_page(struct page *page)
 {
@@ -1768,11 +1816,13 @@ int dissolve_free_huge_page(struct page *page)
 			ClearPageHWPoison(head);
 		}
 		list_del(&head->lru);
+		ClearHPageFreed(page);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 		h->max_huge_pages--;
-		update_and_free_page(h, head);
-		rc = 0;
+		rc = update_and_free_page_surplus(h, head, false);
+		if (rc)
+			h->max_huge_pages++;
 	}
 out:
 	spin_unlock(&hugetlb_lock);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 0209b736e0b4..0e6835264da3 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -18,10 +18,9 @@
  * 4096 base pages. For each base page, there is a corresponding page struct.
  *
  * Within the HugeTLB subsystem, only the first 4 page structs are used to
- * contain unique information about a HugeTLB page. HUGETLB_CGROUP_MIN_ORDER
- * provides this upper limit. The only 'useful' information in the remaining
- * page structs is the compound_head field, and this field is the same for all
- * tail pages.
+ * contain unique information about a HugeTLB page. __NR_USED_SUBPAGE provides
+ * this upper limit. The only 'useful' information in the remaining page structs
+ * is the compound_head field, and this field is the same for all tail pages.
  *
  * By removing redundant page structs for HugeTLB pages, memory can be returned
  * to the buddy allocator for other uses.
@@ -181,21 +180,35 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
-/*
- * How many vmemmap pages associated with a HugeTLB page that can be freed
- * to the buddy allocator.
- *
- * Todo: Returns zero for now, which means the feature is disabled. We will
- * enable it once all the infrastructure is there.
- */
-static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
 {
-	return 0;
+	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
 }
 
-static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
+/*
+ * Previously discarded vmemmap pages will be allocated and remapping
+ * after this function returns.
+ */
+int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
-	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
+	unsigned long vmemmap_addr = (unsigned long)head;
+	unsigned long vmemmap_end, vmemmap_reuse;
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return 0;
+
+	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
+	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
+	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
+	/*
+	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
+	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
+	 * the range is mapped to the page which @vmemmap_reuse is mapped to.
+	 * When a HugeTLB page is freed to the buddy allocator, previously
+	 * discarded vmemmap pages must be allocated and remapping.
+	 */
+	return vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
+				   GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
 }
 
 void free_huge_page_vmemmap(struct hstate *h, struct page *head)
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 6923f03534d5..a37771b0b82a 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -11,10 +11,33 @@
 #include <linux/hugetlb.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+
+/*
+ * How many vmemmap pages associated with a HugeTLB page that can be freed
+ * to the buddy allocator.
+ *
+ * Todo: Returns zero for now, which means the feature is disabled. We will
+ * enable it once all the infrastructure is there.
+ */
+static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return 0;
+}
 #else
+static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	return 0;
+}
+
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
+
+static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return 0;
+}
 #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 7d40b5bd7046..693de0aec7a8 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -40,7 +40,8 @@
  * @remap_pte:		called for each lowest-level entry (PTE).
  * @reuse_page:		the page which is reused for the tail vmemmap pages.
  * @reuse_addr:		the virtual address of the @reuse_page page.
- * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
+ * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
+ *			or is mapped from.
  */
 struct vmemmap_remap_walk {
 	void (*remap_pte)(pte_t *pte, unsigned long addr,
@@ -224,6 +225,78 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
+				struct vmemmap_remap_walk *walk)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
+	struct page *page;
+	void *to;
+
+	BUG_ON(pte_page(*pte) != walk->reuse_page);
+
+	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
+	list_del(&page->lru);
+	to = page_to_virt(page);
+	copy_page(to, (void *)walk->reuse_addr);
+
+	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+}
+
+static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
+				   gfp_t gfp_mask, struct list_head *list)
+{
+	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
+	int nid = page_to_nid((struct page *)start);
+	struct page *page, *next;
+
+	while (nr_pages--) {
+		page = alloc_pages_node(nid, gfp_mask, 0);
+		if (!page)
+			goto out;
+		list_add_tail(&page->lru, list);
+	}
+
+	return 0;
+out:
+	list_for_each_entry_safe(page, next, list, lru)
+		__free_pages(page, 0);
+	return -ENOMEM;
+}
+
+/**
+ * vmemmap_remap_alloc - remap the vmemmap virtual address range [@start, end)
+ *			 to the page which is from the @vmemmap_pages
+ *			 respectively.
+ * @start:	start address of the vmemmap virtual address range that we want
+ *		to remap.
+ * @end:	end address of the vmemmap virtual address range that we want to
+ *		remap.
+ * @reuse:	reuse address.
+ * @gpf_mask:	GFP flag for allocating vmemmap pages.
+ */
+int vmemmap_remap_alloc(unsigned long start, unsigned long end,
+			unsigned long reuse, gfp_t gfp_mask)
+{
+	LIST_HEAD(vmemmap_pages);
+	struct vmemmap_remap_walk walk = {
+		.remap_pte	= vmemmap_restore_pte,
+		.reuse_addr	= reuse,
+		.vmemmap_pages	= &vmemmap_pages,
+	};
+
+	/* See the comment in the vmemmap_remap_free(). */
+	BUG_ON(start - reuse != PAGE_SIZE);
+
+	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
+
+	if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
+		return -ENOMEM;
+
+	vmemmap_remap_range(reuse, end, &walk);
+
+	return 0;
+}
+
 /*
  * Allocate a block of memory to be used to back the virtual memory map
  * or to back the page tables that are used to create the mapping.
-- 
2.11.0

