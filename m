Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43C3604AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhDOInt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhDOInt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:43:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0A9C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 01:43:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w8so9329210plg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTPTnY6NeJQvZKmKVO+kIbZcpfm00iBbyz1WYHe7v+A=;
        b=kAlrOi8bs4wWtaEuj8opZaJJhynBDf6fsM1iTcqaqDSWatsB966pyrTWd/NWToPwfO
         Gt0QSmra2Si9tY2R4wm2dmqBa0tCOyuyN9nefrdycArUtx9kZPLS2FtrWk/A30l31D4f
         Ly8uSyMIZQiQygamqJlQTkXfZF/5KpOgvjOM1E+SYZzVb7mSAJZktiZCJLY/ftVNNLzS
         29LyGeQaOM0JKPFpYEpic7+c0WqGTzOe1Inw/uPhqbRByW7oZnV+6JIpUL395tNjBulM
         vj98CAQGoUL49/RvPIwybK+LLofq6DwVnQPu7iqs9dWBWmrZIsy1hpogry38bz86GugZ
         kTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTPTnY6NeJQvZKmKVO+kIbZcpfm00iBbyz1WYHe7v+A=;
        b=p/G7zOQIJjXLW+gWEVdHuS7dbpJgvCrYRTfnY1sgOFBp4sA9g3xlVNLgk+VR9hdG2E
         QSDSCWUYc26xHPpP5YxVQ996Ys1R+NTqCthnpBSPQTRVbuljbhx4PAudWiyMwPjBmMCm
         CeOPx9MWJ1/eN9kaKZGK17j31cXNkz4stUp6vvbdwhmJgmGG3cToB/8ViofZC9Xm60qk
         f9H6hwdKyXIky0weqHPbxx74MQ5dQ+3fB3wwwIITF0q7yGtsmipOn7qkkfzamP9WQBpy
         jlD/CoEZ4+S97jCf0zC+ZmLp9m8OZO+O7SLYP3j8ZOkggHs/IX6NNmb2OjNZAjm6OnY8
         fDXg==
X-Gm-Message-State: AOAM531ezUmha3g1L6H0lR6m+DEhYyzNT+uADX14S3z4vvrPl5KTC3Ib
        6oSn7C8YsfJR2gG4kPqVFyL3Ig==
X-Google-Smtp-Source: ABdhPJw25WKJ8yBbWSNnEBTLe/NyMDQdWzOzxyKZo7pYxj2TtjVdBqGQW2xdq3PD+fP4xiMuG87+EA==
X-Received: by 2002:a17:90a:990a:: with SMTP id b10mr2678601pjp.178.1618476206497;
        Thu, 15 Apr 2021 01:43:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id e13sm1392365pgt.91.2021.04.15.01.43.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 01:43:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v20 6/9] mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page
Date:   Thu, 15 Apr 2021 16:40:02 +0800
Message-Id: <20210415084005.25049-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210415084005.25049-1-songmuchun@bytedance.com>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
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
---
 Documentation/admin-guide/mm/hugetlbpage.rst    |  8 +++
 Documentation/admin-guide/mm/memory-hotplug.rst | 13 ++++
 include/linux/hugetlb.h                         |  3 +
 include/linux/mm.h                              |  2 +
 mm/hugetlb.c                                    | 85 ++++++++++++++++++++-----
 mm/hugetlb_vmemmap.c                            | 34 ++++++++++
 mm/hugetlb_vmemmap.h                            |  6 ++
 mm/sparse-vmemmap.c                             | 75 +++++++++++++++++++++-
 8 files changed, 210 insertions(+), 16 deletions(-)

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
index 05d51d2d8beb..c6bae2d77160 100644
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
 .. note::
    Techniques that rely on long-term pinnings of memory (especially, RDMA and
    vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0abed7e766b8..6e970a7d3480 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -525,6 +525,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  *	code knows it has only reference.  All other examinations and
  *	modifications require hugetlb_lock.
  * HPG_freed - Set when page is on the free lists.
+ * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
  *	Synchronization: hugetlb_lock held for examination and modification.
  */
 enum hugetlb_page_flags {
@@ -532,6 +533,7 @@ enum hugetlb_page_flags {
 	HPG_migratable,
 	HPG_temporary,
 	HPG_freed,
+	HPG_vmemmap_optimized,
 	__NR_HPAGEFLAGS,
 };
 
@@ -577,6 +579,7 @@ HPAGEFLAG(RestoreReserve, restore_reserve)
 HPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
+HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a4d160ddb749..d0854828bb9c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3048,6 +3048,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 
 void vmemmap_remap_free(unsigned long start, unsigned long end,
 			unsigned long reuse);
+int vmemmap_remap_alloc(unsigned long start, unsigned long end,
+			unsigned long reuse, gfp_t gfp_mask);
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eeb8f5480170..1c37f0098e00 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1376,6 +1376,34 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	h->nr_huge_pages_node[nid]--;
 }
 
+static void add_hugetlb_page(struct hstate *h, struct page *page,
+			     bool adjust_surplus)
+{
+	int nid = page_to_nid(page);
+
+	lockdep_assert_held(&hugetlb_lock);
+
+	INIT_LIST_HEAD(&page->lru);
+	h->nr_huge_pages++;
+	h->nr_huge_pages_node[nid]++;
+
+	if (adjust_surplus) {
+		h->surplus_huge_pages++;
+		h->surplus_huge_pages_node[nid]++;
+	}
+
+	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
+
+	/*
+	 * The refcount can possibly be increased by memory-failure or
+	 * soft_offline handlers.
+	 */
+	if (likely(put_page_testzero(page))) {
+		arch_clear_hugepage_flags(page);
+		enqueue_huge_page(h, page);
+	}
+}
+
 static void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
@@ -1384,6 +1412,18 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
+	if (alloc_huge_page_vmemmap(h, page)) {
+		spin_lock_irq(&hugetlb_lock);
+		/*
+		 * If we cannot allocate vmemmap pages, just refuse to free the
+		 * page and put the page back on the hugetlb free list and treat
+		 * as a surplus page.
+		 */
+		add_hugetlb_page(h, page, true);
+		spin_unlock_irq(&hugetlb_lock);
+		return;
+	}
+
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1444,7 +1484,7 @@ static inline void flush_free_hpage_work(struct hstate *h)
 static void update_and_free_page(struct hstate *h, struct page *page,
 				 bool atomic)
 {
-	if (!free_vmemmap_pages_per_hpage(h) || !atomic) {
+	if (!HPageVmemmapOptimized(page) || !atomic) {
 		__update_and_free_page(h, page);
 		return;
 	}
@@ -1790,10 +1830,14 @@ static struct page *remove_pool_huge_page(struct hstate *h,
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
@@ -1835,19 +1879,30 @@ int dissolve_free_huge_page(struct page *page)
 			goto retry;
 		}
 
-		/*
-		 * Move PageHWPoison flag from head page to the raw error page,
-		 * which makes any subpages rather than the error page reusable.
-		 */
-		if (PageHWPoison(head) && page != head) {
-			SetPageHWPoison(page);
-			ClearPageHWPoison(head);
-		}
 		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
 		spin_unlock_irq(&hugetlb_lock);
-		update_and_free_page(h, head, false);
-		return 0;
+
+		rc = alloc_huge_page_vmemmap(h, page);
+		if (!rc) {
+			/*
+			 * Move PageHWPoison flag from head page to the raw
+			 * error page, which makes any subpages rather than
+			 * the error page reusable.
+			 */
+			if (PageHWPoison(head) && page != head) {
+				SetPageHWPoison(page);
+				ClearPageHWPoison(head);
+			}
+			update_and_free_page(h, head, false);
+		} else {
+			spin_lock_irq(&hugetlb_lock);
+			add_hugetlb_page(h, page, false);
+			h->max_huge_pages++;
+			spin_unlock_irq(&hugetlb_lock);
+		}
+
+		return rc;
 	}
 out:
 	spin_unlock_irq(&hugetlb_lock);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index cb28c5b6c9ff..a897c7778246 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -185,6 +185,38 @@ static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
 	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
 }
 
+/*
+ * Previously discarded vmemmap pages will be allocated and remapping
+ * after this function returns zero.
+ */
+int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	int ret;
+	unsigned long vmemmap_addr = (unsigned long)head;
+	unsigned long vmemmap_end, vmemmap_reuse;
+
+	if (!HPageVmemmapOptimized(head))
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
+	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
+				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
+
+	if (!ret)
+		ClearHPageVmemmapOptimized(head);
+
+	return ret;
+}
+
 void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 	unsigned long vmemmap_addr = (unsigned long)head;
@@ -203,4 +235,6 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
 	 */
 	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
+
+	SetHPageVmemmapOptimized(head);
 }
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 01f8637adbe0..a37771b0b82a 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -11,6 +11,7 @@
 #include <linux/hugetlb.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
 /*
@@ -25,6 +26,11 @@ static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 	return 0;
 }
 #else
+static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	return 0;
+}
+
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
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

