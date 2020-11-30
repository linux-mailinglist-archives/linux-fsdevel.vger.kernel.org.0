Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD0A2C87BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgK3PVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgK3PVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:21:43 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9731DC061A49
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:03 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id l11so6668773plt.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GJFpo+N04VqrewLjKp497y8U/hKK302CXBHn7zde7rI=;
        b=KHj6urA7j1PhhYBctDr/dZ2Y8+YdAZv4Scnb4CDja0LAt97BQSSAuzY01M8UHt0M6B
         D7wYUPj87q3dODiwYx/yDEjxrYrzsGH9XNp8UvtXG2EKFEL4MPvtbsX0aBwXGwg9myO/
         1zEvElFKGBPVTxxY07QXI5nNlF71M291SU64zE026lgD155JPixh96/+5m3h8Dt8+Rj+
         +RxpzVljged5iaxILF3K1X2K/xKRIkT6mND652JE8GhjQQUhQ+ftSBN9t4E5LKK86sXm
         Oa8ssYo22OoQkQ/+8qes4F8asp/9svJgjt4bukIttRevzagDAs+uN04DlpjWXLcSp2pb
         cvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GJFpo+N04VqrewLjKp497y8U/hKK302CXBHn7zde7rI=;
        b=tCMSQXzpvc0cL/8j33iKHdZ3BIyDCRLByjz7MJ5QfRv9hms8CdtmnGiXa2DiX0AMbo
         t92q6IoprMLpxViJwq1FaRCfmlRGV1yjZRvzc7SO4goFLMoHR3NPoQ9Qx1ViP+juDadM
         yBwKMasDnhK1gZHULfTYcDTrecsSHDy4kf7MouThp4trAyGYBaua90rBBgdAS6urdkyW
         GJRzmYrtvdrGmniw2qXvFnqkE9uYU8uKlhnGnpyUD8vCtj3DINlntYX58LJsw4Nwnve4
         i37IN6mgxp1j2c2W212aHjOTw9OhKxa43+60mb6wTQb37mRONxCfF3dpgI+xaYPd2S0A
         NCIw==
X-Gm-Message-State: AOAM531A5RjXkk6iuS1qraQeR9NfsPjEmW1Py19heAiWnMz2I4k68YG8
        soYU+hpNY97BdyzTFDgdpZt52Q==
X-Google-Smtp-Source: ABdhPJyxyjfnLNNhfGWHO3IAw/j3oVwIH6eKTJibyAajhJkdBkpv3vkc/jD3PRaax5IuIkX+VB5dMQ==
X-Received: by 2002:a17:90a:8412:: with SMTP id j18mr27244952pjn.124.1606749663162;
        Mon, 30 Nov 2020 07:21:03 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.20.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:21:02 -0800 (PST)
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
Subject: [PATCH v7 10/15] mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb page
Date:   Mon, 30 Nov 2020 23:18:33 +0800
Message-Id: <20201130151838.11208-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we free a hugetlb page to the buddy, we should allocate the vmemmap
pages associated with it. We can do that in the __free_hugepage().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         |  2 ++
 mm/hugetlb_vmemmap.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++---
 mm/hugetlb_vmemmap.h |  5 +++
 3 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5131ae3d2245..ebe35532d432 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1381,6 +1381,8 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 {
 	int i;
 
+	alloc_huge_page_vmemmap(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index af42fad1f131..a3714db7f400 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -95,6 +95,7 @@
 #define pr_fmt(fmt)	"HugeTLB vmemmap: " fmt
 
 #include <linux/bootmem_info.h>
+#include <linux/delay.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -108,6 +109,8 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 #define VMEMMAP_TAIL_PAGE_REUSE		-1
+#define GFP_VMEMMAP_PAGE		\
+	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_HIGH)
 
 #ifndef VMEMMAP_HPAGE_SHIFT
 #define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
@@ -124,6 +127,11 @@
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
@@ -163,9 +171,40 @@ static pmd_t *vmemmap_to_pmd(unsigned long addr)
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
+		prepare_vmemmap_page(page);
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
@@ -174,6 +213,7 @@ static void vmemmap_reuse_pte_range(struct page *reuse, pte_t *pte,
 	pgprot_t pgprot = PAGE_KERNEL_RO;
 	pte_t entry = mk_pte(reuse, pgprot);
 	unsigned long addr;
+	struct list_head *pages = priv;
 
 	for (addr = start; addr < end; addr += PAGE_SIZE, pte++) {
 		struct page *page;
@@ -181,14 +221,14 @@ static void vmemmap_reuse_pte_range(struct page *reuse, pte_t *pte,
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
@@ -208,12 +248,52 @@ static void vmemmap_remap_range(unsigned long start, unsigned long end,
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
 static inline void free_vmemmap_page_list(struct list_head *list)
 {
 	struct page *page, *next;
@@ -235,7 +315,7 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	start = vmemmap_addr + RESERVE_VMEMMAP_SIZE;
 	end = vmemmap_addr + vmemmap_pages_size_per_hpage(h);
-	vmemmap_remap_range(start, end, &vmemmap_pages);
+	vmemmap_remap_range(start, end, vmemmap_reuse_pte_range, &vmemmap_pages);
 
 	free_vmemmap_page_list(&vmemmap_pages);
 }
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 293897b9f1d8..7887095488f4 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,6 +12,7 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 void __init hugetlb_vmemmap_init(struct hstate *h);
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
@@ -23,6 +24,10 @@ static inline void hugetlb_vmemmap_init(struct hstate *h)
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

