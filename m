Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357DA2F937D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbhAQPUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 10:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbhAQPPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:15:07 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E07C061795
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 07:14:26 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q7so9335569pgm.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eriJkkL7fLLxATd22osz6+JQx60d8cBmS+HC2zuMsVY=;
        b=momL6MFk49e8UpFPXPurDl4ejJIdmDtiX6SKLsBAOdKpCQLeIwaGBPMaHEr2ULRj7N
         vP1IpCXFXvlB4XP1rR+0FA/G1imHRm8fAzrT+/bM0yGySjgr5EDhLd4PNdPu7MYC2ATX
         FtjqCU4STC7bpU/9vgT2J5FhsiEz2+yzrJXRPI80BdS//LyCOWepWeGSqKkXnN6mQnJw
         j5KHYeNfV1pCEmuephfUWYcY4+HlScp2zLO2ztjj44O06dTL7I+BR6uJmjLIrKXrYznK
         13w5/jV6XfeneoDN6gpgGc8X2a5284C+9N2/2OxkNqyAwVFUZjnsrbMBW26rpMlTRpko
         eF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eriJkkL7fLLxATd22osz6+JQx60d8cBmS+HC2zuMsVY=;
        b=Qni+PaONhS+VYgFwBe14tQml2no9hVWTJ6rOkOmTzCGN+Zrc+8UEi0ooSWDxFXzA8B
         JaGCFVc/elj5U1SUYqUCgSmY0tqPi2wFxps1JIXaCt1YL30wLWYUJVqUI+qcyVEi3a/f
         jxpAstLaT7VVUMVp8isILOWsQFuP6f0BHsdwU1q2jHE+IXnBgIsgR+RP3jUC62h3Wwkh
         UApe/vbjooOgJVgUAMrfLxV51xQ784rhOsc/TWrw3DTlhxaiNNlSBtbQttEHR4PTRLgG
         CQQcoZZbMXSxUBTko1SHr9Wl+EeULLwOwar0U+/P7HtPmYQHo6zW7O87cVDecz8/9F0o
         mwlA==
X-Gm-Message-State: AOAM530ht+6/ZgVSaVUvrQ5C48L4sWsiFwxh9BsyRnKQsZfIsl5UjZv8
        i0ornTsR9B3g8gldBiAhI4obfg==
X-Google-Smtp-Source: ABdhPJz3uiBcudD2MIn4mZIBdhsFabwzy+orYv2RfLJJ8jjcwimj0pEgEVaGzsFbzlxHpoxLEeCNSQ==
X-Received: by 2002:a63:3549:: with SMTP id c70mr22007739pga.361.1610896466134;
        Sun, 17 Jan 2021 07:14:26 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id i22sm9247915pjv.35.2021.01.17.07.14.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:14:25 -0800 (PST)
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
Subject: [PATCH v13 05/12] mm: hugetlb: allocate the vmemmap pages associated with each HugeTLB page
Date:   Sun, 17 Jan 2021 23:10:46 +0800
Message-Id: <20210117151053.24600-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210117151053.24600-1-songmuchun@bytedance.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
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
 mm/hugetlb_vmemmap.c | 15 ++++++++++
 mm/hugetlb_vmemmap.h |  5 ++++
 mm/sparse-vmemmap.c  | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 100 insertions(+), 1 deletion(-)

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
index ce4be1fa93c2..3b146d5949f3 100644
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
@@ -228,6 +234,75 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
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
+	/* See the comment in the vmemmap_remap_free(). */
+	BUG_ON(start - reuse != PAGE_SIZE);
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

