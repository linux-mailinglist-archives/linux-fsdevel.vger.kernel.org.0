Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7542EBF73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 15:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhAFOWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 09:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbhAFOWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:22:02 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201B5C061364
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 06:21:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id c132so2330956pga.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 06:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+NDPR45drEYxjrotG0Jf37UfWBT389Rp/ssQ93qu18=;
        b=A9flmtBd3jDEjnR5m4AfOp3nP7yGBrb/a5j4i5mW+QSQnRSnoHEkFQctM6uTxR+kI2
         1H388RDRITA3fNl0ZKDMQhI7b3MlEBomw2+U1rbvzzC2fq9DTMXbeVnBmYuhcWHb5Q6R
         5NNvFnjHm6ApGcjZmQwHfU6TE0N25lrvXlN9bO9fnTsmhSIvNafvJtZwCuy7wYTNz9ZO
         leRstqQSNSyRCdmzMr0sOlVVLiCOX9xa5jgPo5syzVYbVKMWoQm7g7ZCQ+aQB7KTP5Rd
         FALdsKq2EWIhc/vV+jHYLgdjAb/54/G5Gp+rdYUqrdgsd32R+VAD/tCfAUqW3CffPWhU
         97ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+NDPR45drEYxjrotG0Jf37UfWBT389Rp/ssQ93qu18=;
        b=KM32Wa9BkoDQF+PK9G33IfIjyi95l+eqvjXPrY7BcKpn3az6z5WjW770L4xFONFJad
         3UOWGSrD3DbtHqAVGbs4Wburocjjn85MLnZyDOh+mjxpb5jUIUSzzZu8flFiQX67JufI
         IbcCRoTNfQYY1KN+X6YhStPcqyLXEPqGjw4aKt5C1tZaJRwstm254VQJQD/h9f6/syZx
         LToGbrIHckGE5llw89R5SH8ZaCP/VjQbjCoWaOiYVJIBqiLTBsa133rxLgD9IzEEp3zP
         TwjZ/WOka9pwgeR4IeHkC9NTVqcRnvHHO0NrEQ12lIzHeY9ldnTe0xWF7wDpT9wXf/MM
         a8nw==
X-Gm-Message-State: AOAM531AaBUncTdRm6QxGOGUhPiMANbJOWHJiQHP6Gxw2VuXwdLYBWbX
        dWVXs6vn+f/pn8hM25vJUPsMmw==
X-Google-Smtp-Source: ABdhPJwqQLBpKcv80jA4+b44FVC2YiluU7y2POqYjHpq1b7YwPUBeTfZvnkkemgJZP7VHiNV1rUDPw==
X-Received: by 2002:a63:4a03:: with SMTP id x3mr4745482pga.270.1609942868719;
        Wed, 06 Jan 2021 06:21:08 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id a29sm2831730pfr.73.2021.01.06.06.20.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 06:21:08 -0800 (PST)
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
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v12 06/13] mm/hugetlb: Allocate the vmemmap pages associated with each HugeTLB page
Date:   Wed,  6 Jan 2021 22:19:24 +0800
Message-Id: <20210106141931.73931-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106141931.73931-1-songmuchun@bytedance.com>
References: <20210106141931.73931-1-songmuchun@bytedance.com>
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
 include/linux/mm.h   |  2 ++
 mm/hugetlb.c         |  2 ++
 mm/hugetlb_vmemmap.c | 15 +++++++++++
 mm/hugetlb_vmemmap.h |  5 ++++
 mm/sparse-vmemmap.c  | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f928994ed273..16b55d13b0ab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3007,6 +3007,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 
 void vmemmap_remap_free(unsigned long start, unsigned long end,
 			unsigned long reuse);
+void vmemmap_remap_alloc(unsigned long start, unsigned long end,
+			 unsigned long reuse);
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c165186ec2cf..d11c32fcdb38 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1326,6 +1326,8 @@ static void update_hpage_vmemmap_workfn(struct work_struct *work)
 		page->mapping = NULL;
 		h = page_hstate(page);
 
+		alloc_huge_page_vmemmap(h, page);
+
 		spin_lock(&hugetlb_lock);
 		__free_hugepage(h, page);
 		spin_unlock(&hugetlb_lock);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 19f1898aaede..6108ae80314f 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -183,6 +183,21 @@ static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
 	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
 }
 
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	unsigned long vmemmap_addr = (unsigned long)head;
+	unsigned long vmemmap_end, vmemmap_reuse;
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
+	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
+	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
+
+	vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse);
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
index 0e9c49a028b4..ed4702d5d664 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/pgtable.h>
 #include <linux/bootmem_info.h>
+#include <linux/delay.h>
 
 #include <asm/dma.h>
 #include <asm/pgalloc.h>
@@ -40,7 +41,8 @@
  * @remap_pte:		called for each non-empty PTE (lowest-level) entry.
  * @reuse_page:		the page which is reused for the tail vmemmap pages.
  * @reuse_addr:		the virtual address of the @reuse_page page.
- * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
+ * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
+ *			or is mapped from.
  */
 struct vmemmap_remap_walk {
 	void (*remap_pte)(pte_t *pte, unsigned long addr,
@@ -50,6 +52,10 @@ struct vmemmap_remap_walk {
 	struct list_head *vmemmap_pages;
 };
 
+/* The gfp mask of allocating vmemmap page */
+#define GFP_VMEMMAP_PAGE		\
+	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN | __GFP_THISNODE)
+
 static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 			      unsigned long end,
 			      struct vmemmap_remap_walk *walk)
@@ -212,6 +218,74 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
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
+static void alloc_vmemmap_page_list(struct list_head *list,
+				    unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		struct page *page;
+		int nid = page_to_nid((const void *)addr);
+
+retry:
+		page = alloc_pages_node(nid, GFP_VMEMMAP_PAGE, 0);
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
+ * vmemmap_remap_alloc - remap the vmemmap virtual address range [@start, end)
+ *			 to the page which is from the @vmemmap_pages
+ *			 respectively.
+ * @start:	start address of the vmemmap virtual address range.
+ * @end:	end address of the vmemmap virtual address range.
+ * @reuse:	reuse address.
+ */
+void vmemmap_remap_alloc(unsigned long start, unsigned long end,
+			 unsigned long reuse)
+{
+	LIST_HEAD(vmemmap_pages);
+	struct vmemmap_remap_walk walk = {
+		.remap_pte	= vmemmap_restore_pte,
+		.reuse_addr	= reuse,
+		.vmemmap_pages	= &vmemmap_pages,
+	};
+
+	might_sleep();
+
+	BUG_ON(start != reuse + PAGE_SIZE);
+
+	alloc_vmemmap_page_list(&vmemmap_pages, start, end);
+	vmemmap_remap_range(reuse, end, &walk);
+}
+
 /*
  * Allocate a block of memory to be used to back the virtual memory map
  * or to back the page tables that are used to create the mapping.
-- 
2.11.0

