Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF62D5288
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 05:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbgLJEFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 23:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732077AbgLJD7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:59:05 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44316C061794
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 19:58:27 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so2927389pgg.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 19:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obomzxnE3bCncBDby2KHXPfJo5W6LKoah6AySUf3aYM=;
        b=vhT/aQXhscWLU8RWIgAZpwoe2afu6ypDnHizDG2jgA9+NJD9NkG1y0r7/rcZOOiS6U
         DKjEOcHAHB/zkBqoAArEZGB5uA3shzNNSGFC50+P5f4xW5THx/lNRQeDxNkDRF8y1uxQ
         ttcDcNQ8d9YTB36I51fL6SyvJzZCUsryxx/1W+77k2JJ21KxiIOqKTsgLFJb9nz/5Txr
         fnc/xGBJqTakATJSQ4lESFicM1E7sc4WmJbAIGsvHRE7cKaG7rY9aBnO0B8womGdg8L0
         l6HdIwvN2oXa5Pw6d0dkymw4pGnNG8sC17Q6P1hlXo/JZliVS8f5LaVcS9GheQybpmPP
         jc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obomzxnE3bCncBDby2KHXPfJo5W6LKoah6AySUf3aYM=;
        b=JZsg9his/yBxHiMdh0vM2lbAHgwYIeJlaLHeIn376y3SbW1xo9mply+ahMY/9Ta+gG
         /M4x5Ai53QkzBphiU4gZouYjBhK193oLsUfiglWiDz7NGMI9AMqYH+FDT5CUgy14hIPI
         Ll5dc66TaYJ4LDGxrzrKaQJxUv3waiVh6c/5jjF+Krp8QmLy4stbz8ZfNhZHjizRWvIr
         QRSkiLVL+/Xn6cjYH7+QIliLv+3uQKGVGtbEV5rl8GvzZmlje/EF93j3+gc6VXGfX8VS
         8MugVeJun1XzQ8VgtTmDrzLYahy3BkRzBCBs/mEI4RYh2S8QuVxj5JYzm0M5/LAg1v6R
         uE/A==
X-Gm-Message-State: AOAM5310JTYjlp3i9qbh4IbSHM0whMPbEN46vSs+eZD0MWwQSuBvEH9P
        lMZOk4EbGtEtClCxiU2KOfsvAg==
X-Google-Smtp-Source: ABdhPJxJzgjYe9uxAnVkNO+3jrelGPFJ9IMaznePy22DO2pkNwKLR/8XCT+O/KxiJZUHNSXP001xFA==
X-Received: by 2002:a62:cec1:0:b029:19e:5605:36a0 with SMTP id y184-20020a62cec10000b029019e560536a0mr4929207pfg.27.1607572706811;
        Wed, 09 Dec 2020 19:58:26 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.85])
        by smtp.gmail.com with ESMTPSA id f33sm4266535pgl.83.2020.12.09.19.58.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:58:26 -0800 (PST)
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
Subject: [PATCH v8 06/12] mm/hugetlb: Allocate the vmemmap pages associated with each HugeTLB page
Date:   Thu, 10 Dec 2020 11:55:20 +0800
Message-Id: <20201210035526.38938-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201210035526.38938-1-songmuchun@bytedance.com>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c         |  2 ++
 mm/hugetlb_vmemmap.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++---
 mm/hugetlb_vmemmap.h |  5 +++
 3 files changed, 91 insertions(+), 5 deletions(-)

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
index d080488cde16..4587a0062808 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -169,6 +169,7 @@
 #define pr_fmt(fmt)	"HugeTLB vmemmap: " fmt
 
 #include <linux/bootmem_info.h>
+#include <linux/delay.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -181,6 +182,8 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 #define VMEMMAP_TAIL_PAGE_REUSE		-1
+#define GFP_VMEMMAP_PAGE		\
+	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_HIGH | __GFP_NOWARN)
 
 #ifndef VMEMMAP_HPAGE_SHIFT
 #define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
@@ -197,6 +200,11 @@
 	(__boundary - 1 < (end) - 1) ? __boundary : (end);		 \
 })
 
+typedef void (*vmemmap_remap_pte_func_t)(struct page *reuse, pte_t *pte,
+					 unsigned long start, unsigned long end,
+					 void *priv);
+
+
 static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
@@ -236,9 +244,39 @@ static pmd_t *vmemmap_to_pmd(unsigned long addr)
 	return pmd;
 }
 
+static void vmemmap_restore_pte_range(struct page *reuse, pte_t *pte,
+				      unsigned long start, unsigned long end,
+				      void *priv)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
+	void *from = page_to_virt(reuse);
+	unsigned long addr;
+	struct list_head *pages = priv;
+
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		void *to;
+		struct page *page;
+
+		VM_BUG_ON(pte_none(*pte) || pte_page(*pte) != reuse);
+
+		page = list_first_entry(pages, struct page, lru);
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
+		set_pte_at(&init_mm, addr, pte++, mk_pte(page, pgprot));
+	}
+}
+
 static void vmemmap_reuse_pte_range(struct page *reuse, pte_t *pte,
 				    unsigned long start, unsigned long end,
-				    struct list_head *vmemmap_pages)
+				    void *priv)
 {
 	/*
 	 * Make the tail pages are mapped with read-only to catch
@@ -247,6 +285,7 @@ static void vmemmap_reuse_pte_range(struct page *reuse, pte_t *pte,
 	pgprot_t pgprot = PAGE_KERNEL_RO;
 	pte_t entry = mk_pte(reuse, pgprot);
 	unsigned long addr;
+	struct list_head *pages = priv;
 
 	for (addr = start; addr < end; addr += PAGE_SIZE, pte++) {
 		struct page *page;
@@ -254,14 +293,14 @@ static void vmemmap_reuse_pte_range(struct page *reuse, pte_t *pte,
 		VM_BUG_ON(pte_none(*pte));
 
 		page = pte_page(*pte);
-		list_add(&page->lru, vmemmap_pages);
+		list_add(&page->lru, pages);
 
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
 }
 
 static void vmemmap_remap_range(unsigned long start, unsigned long end,
-				struct list_head *vmemmap_pages)
+				vmemmap_remap_pte_func_t func, void *priv)
 {
 	pmd_t *pmd;
 	unsigned long next, addr = start;
@@ -281,12 +320,52 @@ static void vmemmap_remap_range(unsigned long start, unsigned long end,
 			reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
 
 		next = vmemmap_hpage_addr_end(addr, end);
-		vmemmap_reuse_pte_range(reuse, pte, addr, next, vmemmap_pages);
+		func(reuse, pte, addr, next, priv);
 	} while (pmd++, addr = next, addr != end);
 
 	flush_tlb_kernel_range(start, end);
 }
 
+static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
+{
+	unsigned int nr = free_vmemmap_pages_per_hpage(h);
+
+	while (nr--) {
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
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	unsigned long start, end;
+	unsigned long vmemmap_addr = (unsigned long)head;
+	LIST_HEAD(vmemmap_pages);
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	alloc_vmemmap_pages(h, &vmemmap_pages);
+
+	start = vmemmap_addr + RESERVE_VMEMMAP_SIZE;
+	end = vmemmap_addr + vmemmap_pages_size_per_hpage(h);
+	vmemmap_remap_range(start, end, vmemmap_restore_pte_range,
+			    &vmemmap_pages);
+}
+
 /*
  * Free a vmemmap page. A vmemmap page can be allocated from the memblock
  * allocator or buddy allocator. If the PG_reserved flag is set, it means
@@ -322,7 +401,7 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	start = vmemmap_addr + RESERVE_VMEMMAP_SIZE;
 	end = vmemmap_addr + vmemmap_pages_size_per_hpage(h);
-	vmemmap_remap_range(start, end, &vmemmap_pages);
+	vmemmap_remap_range(start, end, vmemmap_reuse_pte_range, &vmemmap_pages);
 
 	free_vmemmap_page_list(&vmemmap_pages);
 }
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index bf22cd003acb..8fd57c49e230 100644
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
-- 
2.11.0

