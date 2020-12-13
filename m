Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACD22D8E67
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 16:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437233AbgLMPsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 10:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437189AbgLMPr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:47:57 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC04C061794
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:12 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w5so9998806pgj.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/UY5+OXSNu8UfWeK3zWQcCdNSo4BtWiu6jtKlnHjBTk=;
        b=LpAJVwR/AtggCqh/HXEik7Fba5T4Y6khxFO9MSPDtvERvZGNkivS9ssxSzNXB68M6D
         LFzC4Rp9m6K1zYfnvXonVSXPgrAGyxd6aQDgtrkcL/ceiM3zLlP/HfkIUAQl1+jexRgK
         JtN+fW1/mVS9pn+8N/7lY8FOmwlnU90l3QIe0/i9Hs6bI2PlyYPmLOd0GAbBtIE1Inia
         hhBBLFqYc+SyDJroyrqnSgdYKb9uW7rxq5iZo890nyI0gpQ+ugjwdwMr7D67HOPMmSP0
         cwKveCzzJy1w6jZS8moYumSCwE26oSvlz4g+otowjL+AhCC/2k/1Dw55i78lLVRYhHLz
         ykZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/UY5+OXSNu8UfWeK3zWQcCdNSo4BtWiu6jtKlnHjBTk=;
        b=Q9FBhYqZi0YEiUCe7HQJbpsZv0gNnHh2rraVaUQyKImtYhpoi+6I8MFyRvPChpq8f9
         hyO3FiYAsmps452U4SUiacN1Xu5LGB+SS/h0Z/Ox8T1+t1FN3EEemhGeAasje8gybQuG
         ufSSQtPXAZ6CqnK+p/PbtZDuZdTx7Fer7mvncazzr+3Ckx3O1BQJjKuQaonOnUoe4Kw9
         YlMRLV/ceYMSNcHDT41Q3YH8c7c4dc8XE8+Zc4CHSeWnma9Tlkqh0s5mhX24tD320jAG
         YCSG6sqJE7iBXq57mz1ltMYuIAKLQWPzIsdZj0gW1Zgy8mdu/UZMIGtIq3zjJJOOJ3sN
         COSA==
X-Gm-Message-State: AOAM532Q2Mg/7wGf/HAibIFSJQ1peTCr1gBcJ9A4cBXFDDDuYHVoaqg+
        Qn7GENF2TYMSlaigHxUyj4b75w==
X-Google-Smtp-Source: ABdhPJx6ttNBb9hxOAX4RE8YcdzTHLfEAk2T0tGCYa/oYq7cwR27rBr9hx1rfU4gzkFNS8XHcpWfRw==
X-Received: by 2002:aa7:9055:0:b029:19e:4bf4:c6bc with SMTP id n21-20020aa790550000b029019e4bf4c6bcmr20125543pfo.58.1607874432387;
        Sun, 13 Dec 2020 07:47:12 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id e24sm13113753pjt.16.2020.12.13.07.47.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2020 07:47:11 -0800 (PST)
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
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v9 05/11] mm/hugetlb: Allocate the vmemmap pages associated with each HugeTLB page
Date:   Sun, 13 Dec 2020 23:45:28 +0800
Message-Id: <20201213154534.54826-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201213154534.54826-1-songmuchun@bytedance.com>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we free a HugeTLB page to the buddy allocator, we should allocate the
vmemmap pages associated with it. We can do that in the __free_hugepage()
before freeing it to buddy.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h   |  1 +
 mm/hugetlb.c         |  2 ++
 mm/hugetlb_vmemmap.c | 11 +++++++++
 mm/hugetlb_vmemmap.h |  5 ++++
 mm/sparse-vmemmap.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ab02e405a979..5b8dc36e4d20 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3006,6 +3006,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 #endif
 
 void vmemmap_remap_reuse(unsigned long start, unsigned long size);
+void vmemmap_remap_restore(unsigned long start, unsigned long size);
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0ff9b90e524f..542e6cb81321 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1362,6 +1362,8 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 {
 	int i;
 
+	alloc_huge_page_vmemmap(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6d4e77a2b6c7..02201c2e3dfa 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -185,6 +185,17 @@ static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
 	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
 }
 
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	unsigned long vmemmap_addr = (unsigned long)head;
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	vmemmap_remap_restore(vmemmap_addr + RESERVE_VMEMMAP_SIZE,
+			      free_vmemmap_pages_size_per_hpage(h));
+}
+
 void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 	unsigned long vmemmap_addr = (unsigned long)head;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 01f8637adbe0..b2c8d2f11d48 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -11,6 +11,7 @@
 #include <linux/hugetlb.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
 /*
@@ -25,6 +26,10 @@ static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 	return 0;
 }
 #else
+static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
+
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 78c527617e8d..ffcf092c92ed 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/pgtable.h>
 #include <linux/bootmem_info.h>
+#include <linux/delay.h>
 
 #include <asm/dma.h>
 #include <asm/pgalloc.h>
@@ -39,7 +40,8 @@
  *
  * @rmap_pte:		called for each non-empty PTE (lowest-level) entry.
  * @reuse:		the page which is reused for the tail vmemmap pages.
- * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
+ * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
+ *			or is mapped from.
  */
 struct vmemmap_rmap_walk {
 	void (*rmap_pte)(pte_t *pte, unsigned long addr,
@@ -54,6 +56,9 @@ struct vmemmap_rmap_walk {
  */
 #define VMEMMAP_TAIL_PAGE_REUSE		-1
 
+/* The gfp mask of allocating vmemmap page */
+#define GFP_VMEMMAP_PAGE	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN)
+
 static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 			      unsigned long end, struct vmemmap_rmap_walk *walk)
 {
@@ -200,6 +205,68 @@ void vmemmap_remap_reuse(unsigned long start, unsigned long size)
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+static void vmemmap_remap_restore_pte(pte_t *pte, unsigned long addr,
+				      struct vmemmap_rmap_walk *walk)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
+	struct page *page;
+	void *to;
+
+	BUG_ON(pte_page(*pte) != walk->reuse);
+
+	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
+	list_del(&page->lru);
+	to = page_to_virt(page);
+	copy_page(to, page_to_virt(walk->reuse));
+
+	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+}
+
+static void alloc_vmemmap_page_list(struct list_head *list,
+				    unsigned long nr_pages)
+{
+	while (nr_pages--) {
+		struct page *page;
+
+retry:
+		page = alloc_page(GFP_VMEMMAP_PAGE);
+		if (unlikely(!page)) {
+			msleep(100);
+			/*
+			 * We should retry infinitely, because we cannot
+			 * handle allocation failures. Once we allocate
+			 * vmemmap pages successfully, then we can free
+			 * a HugeTLB page.
+			 */
+			goto retry;
+		}
+		list_add_tail(&page->lru, list);
+	}
+}
+
+/**
+ * vmemmap_remap_restore - remap the vmemmap virtual address range
+ *                         [start, start + size) to the page respectively
+ *                         which from the @vmemmap_pages
+ * @start:	start address of the vmemmap virtual address range
+ * @end:	size of the vmemmap virtual address range
+ */
+void vmemmap_remap_restore(unsigned long start, unsigned long size)
+{
+	LIST_HEAD(vmemmap_pages);
+	unsigned long end = start + size;
+
+	struct vmemmap_rmap_walk walk = {
+		.rmap_pte	= vmemmap_remap_restore_pte,
+		.vmemmap_pages	= &vmemmap_pages,
+	};
+
+	might_sleep();
+
+	alloc_vmemmap_page_list(&vmemmap_pages, size >> PAGE_SHIFT);
+	vmemmap_remap_range(start, end, &walk);
+}
+
 /*
  * Allocate a block of memory to be used to back the virtual memory map
  * or to back the page tables that are used to create the mapping.
-- 
2.11.0

