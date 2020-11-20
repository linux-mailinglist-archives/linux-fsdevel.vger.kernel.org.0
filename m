Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EF02BA28D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 07:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgKTGr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 01:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgKTGr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:47:56 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB8C061A04
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:47:56 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 62so6479094pgg.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iceBPaQt02dZVydXdfu8Z74PD0dATJP+BLl41c9vKHU=;
        b=zqYQ8zq+KGjONa5xXaxh1Cizv0zHOcPwll+/EnQLF3uDtTXOMzgoAt8zYMkw3/Byhg
         qNNNvuQx9dgYaVxLdcy2agYVjh9us53tRfZg+JgLPrNjOhTIukAbuGGSmukQ1G84XCet
         zR+PnyYpBpXDggqqQz2n2NlnePxyUoyCCAm6saqrVT3LggXkSqkcjdb3YCIA+MKHrhGl
         B1tlDflcmDn7G6SgrcHxVRW0LYo0/WOPNHO5vlC0A0ld7iMs+FBL/birywemvak77h3Q
         Q9jNdJJiVNCYiiUoDeL5JsxjuDFYlSeaboyXCZ2LmZnr/h6axGSUkngzFC2igBUaxEqi
         urWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iceBPaQt02dZVydXdfu8Z74PD0dATJP+BLl41c9vKHU=;
        b=s4NVOlkfsY8rbH9S039VAZwGbnc3frx0wPfh/nJn/yrGTzn6kprSHKCIUXmDKiZihp
         nXQ3YcX56hJpsa4Go10O9lr934d52G5ZcYRX6lQHpW/Yl8SxDEHCK5Dgv/MO3Towbl29
         iy3WDrGVqj7FXllUOwXt3qlPP9acD36NzxjiDron2xqcEiMKKvKcVv9GE8AVmuVyQDCh
         JOVydhlOD2aW/oSmeB4XfcRc2GsIrQGRVtPKGq1kqdnwl9HIJfaRE162YsgxtmaZu0oH
         rBalvGn7w06X9g11RSoHYV+yqKiY+XCZZQHKCqQAlRC3jmqzdyta9d2SxvvdBX1akqa1
         wrPQ==
X-Gm-Message-State: AOAM532y4Bvspz0MuO992Dtw3jY8j/6j+GKWMfktbrKCIcJiyez7EMGo
        6Js5s1AtrgZQ09Vg4d321FCP7w==
X-Google-Smtp-Source: ABdhPJwLLBPH98amlvEq9aU2cWlfLONjOmDPxpfXjkJQZsa142xhIgPM7fFlephFAKAAy1Zk2y7XTQ==
X-Received: by 2002:a62:5406:0:b029:18c:8dac:4a99 with SMTP id i6-20020a6254060000b029018c8dac4a99mr12507984pfb.19.1605854876174;
        Thu, 19 Nov 2020 22:47:56 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.47.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:47:55 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 11/21] mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb page
Date:   Fri, 20 Nov 2020 14:43:15 +0800
Message-Id: <20201120064325.34492-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we free a hugetlb page to the buddy, we should allocate the vmemmap
pages associated with it. We can do that in the __free_hugepage().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         |   2 ++
 mm/hugetlb_vmemmap.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h |   5 +++
 3 files changed, 107 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4aabf12aca9b..ba927ae7f9bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1382,6 +1382,8 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 {
 	int i;
 
+	alloc_huge_page_vmemmap(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index eda7e3a0b67c..361c4174e222 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -117,6 +117,8 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 #define TAIL_PAGE_REUSE			-1
+#define GFP_VMEMMAP_PAGE		\
+	(GFP_KERNEL | __GFP_NOFAIL | __GFP_MEMALLOC)
 
 #ifndef VMEMMAP_HPAGE_SHIFT
 #define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
@@ -250,6 +252,104 @@ static inline int freed_vmemmap_hpage_dec(struct page *page)
 	return atomic_dec_return_relaxed(&page->_mapcount) + 1;
 }
 
+static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
+					  unsigned long start,
+					  unsigned long end,
+					  struct list_head *remap_pages)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
+	void *from = page_to_virt(reuse);
+	unsigned long addr;
+
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		void *to;
+		struct page *page;
+		pte_t entry, old = *ptep;
+
+		page = list_first_entry_or_null(remap_pages, struct page, lru);
+		list_del(&page->lru);
+		to = page_to_virt(page);
+		copy_page(to, from);
+
+		/*
+		 * Make sure that any data that writes to the @to is made
+		 * visible to the physical page.
+		 */
+		flush_kernel_vmap_range(to, PAGE_SIZE);
+
+		prepare_vmemmap_page(page);
+
+		entry = mk_pte(page, pgprot);
+		set_pte_at(&init_mm, addr, ptep++, entry);
+
+		VM_BUG_ON(!pte_present(old) || pte_page(old) != reuse);
+	}
+}
+
+static void __remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
+					  unsigned long addr,
+					  struct list_head *remap_pages)
+{
+	unsigned long next;
+	unsigned long start = addr + RESERVE_VMEMMAP_SIZE;
+	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
+	struct page *reuse = NULL;
+
+	addr = start;
+	do {
+		pte_t *ptep;
+
+		ptep = pte_offset_kernel(pmd, addr);
+		if (!reuse)
+			reuse = pte_page(ptep[TAIL_PAGE_REUSE]);
+
+		next = vmemmap_hpage_addr_end(addr, end);
+		__remap_huge_page_pte_vmemmap(reuse, ptep, addr, next,
+					      remap_pages);
+	} while (pmd++, addr = next, addr != end);
+
+	flush_tlb_kernel_range(start, end);
+}
+
+static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
+{
+	int i;
+
+	for (i = 0; i < free_vmemmap_pages_per_hpage(h); i++) {
+		struct page *page;
+
+		/* This should not fail */
+		page = alloc_page(GFP_VMEMMAP_PAGE);
+		list_add_tail(&page->lru, list);
+	}
+}
+
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	pmd_t *pmd;
+	spinlock_t *ptl;
+	LIST_HEAD(remap_pages);
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	alloc_vmemmap_pages(h, &remap_pages);
+
+	pmd = vmemmap_to_pmd((unsigned long)head);
+	BUG_ON(!pmd);
+
+	ptl = vmemmap_pmd_lock(pmd);
+	__remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head,
+				      &remap_pages);
+	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd))) {
+		/*
+		 * Todo:
+		 * Merge pte to huge pmd if it has ever been split.
+		 */
+	}
+	spin_unlock(ptl);
+}
+
 static inline void free_vmemmap_page_list(struct list_head *list)
 {
 	struct page *page, *next;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 4175b44f88bc..6dfa7ed6f88a 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -14,6 +14,7 @@
 void __init hugetlb_vmemmap_init(struct hstate *h);
 int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page);
 void vmemmap_pgtable_free(struct page *page);
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
@@ -34,6 +35,10 @@ static inline void vmemmap_pgtable_free(struct page *page)
 {
 }
 
+static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
+
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
-- 
2.11.0

