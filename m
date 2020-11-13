Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6E2B19D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 12:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgKMLQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 06:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgKMLDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:03:53 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A5C061A52
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:03:12 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id y22so4389857plr.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTBEkY0EWBbMy5iIzZRtsaqCivtCwTiUQlKtEZa+cOQ=;
        b=HXMyr8XazQ6oTzSEwqXN6zTDQfzwHhzhGI9vF9dhhvZ4EyuBVJKj33LuCIeBNL1WJO
         4i49MSS3mHAOPKlaowtPqF0hKSFYc4DeNeZ23+FxCSvgVL2UY1vA8cA1GIU1y2S+2ue9
         k6Iu3xWN0uVnmNNobJsIPiB+23J/BOF1qLmkb4JCArM4HrZPkL+KiAupM8r28sq2B8lh
         pp61KKhCKGP1P5j3i6Cxtv+tIxo76J3d8L52b65YJ6wPS5KYhdcV1Y5Jt8XOpRSYH3dL
         pDXGANFAs3AGL8HGfeynfn023qG7xQviy2/sFmuKnR6+Rm4EFS+fquD+urXexrFetu8+
         g+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTBEkY0EWBbMy5iIzZRtsaqCivtCwTiUQlKtEZa+cOQ=;
        b=uXS30YY56GXSDnn19G8O2gRkB16sF3AGdTTVbKmjjE0ky8BsMOZuV0frTHVrLTfYmo
         UnZpfFgYBiVRP38ax8Wg7PYiS+RjssM3jnGqhbSnkRMSBPvh/vPl9rgAPUt90tyvUYSA
         q3WJM2UfRs7IJ1EuhQexnO3uLg9Ik0VQCpMKWCrzhLeD3zRhBw2uavDPKKECDq94PO7t
         qccHQqyVw2JMpdQNb7M+fpfCPyJKMxz+1fVQH8bdMjp1YFEq2A8nLXoIm/tkWagftCHh
         60PcYtFcYa1SxdCr9sfaOPjiarGtNSmoGmL384mO61O1RcQpRkfjr8IallASXezuVOjh
         Rg5w==
X-Gm-Message-State: AOAM53150AD50InfEObHwWjqJUis6lZN+L0hfXOz2ZnUdNOD3H8h6gTV
        P2YAhZrmEAFuhs3D5r79TLzfew==
X-Google-Smtp-Source: ABdhPJzrYDT5xoZpsO3M+6yIguGxa3HMCUVuWgvEDjS67lXujwXi8LjnpKOLMdYhmMzRef8jrVTIfw==
X-Received: by 2002:a17:902:7487:b029:d6:c03b:bce4 with SMTP id h7-20020a1709027487b02900d6c03bbce4mr1570873pll.36.1605265392353;
        Fri, 13 Nov 2020 03:03:12 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:03:11 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 12/21] mm/hugetlb: Introduce remap_huge_page_pmd_vmemmap helper
Date:   Fri, 13 Nov 2020 18:59:43 +0800
Message-Id: <20201113105952.11638-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The __free_huge_page_pmd_vmemmap and __remap_huge_page_pmd_vmemmap are
almost the same code. So introduce remap_free_huge_page_pmd_vmemmap
helper to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 108 +++++++++++++++++++++------------------------------
 1 file changed, 45 insertions(+), 63 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 9918dc63c062..ae9dbfb682ab 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -221,6 +221,47 @@ static inline int freed_vmemmap_hpage_dec(struct page *page)
 	return atomic_dec_return_relaxed(&page->_mapcount) + 1;
 }
 
+static inline void free_vmemmap_page_list(struct list_head *list)
+{
+	struct page *page, *next;
+
+	list_for_each_entry_safe(page, next, list, lru) {
+		list_del(&page->lru);
+		free_vmemmap_page(page);
+	}
+}
+
+typedef void (*remap_pte_fn)(struct page *reuse, pte_t *ptep,
+			     unsigned long start, unsigned long end,
+			     struct list_head *pages);
+
+static void remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
+					unsigned long addr,
+					struct list_head *pages,
+					remap_pte_fn remap_fn)
+{
+	unsigned long next;
+	unsigned long start = addr + RESERVE_VMEMMAP_SIZE;
+	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
+	struct page *reuse = NULL;
+
+	flush_cache_vunmap(start, end);
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
+		remap_fn(reuse, ptep, addr, next, pages);
+	} while (pmd++, addr = next, addr != end);
+
+	flush_tlb_kernel_range(start, end);
+}
+
 static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 					  unsigned long start,
 					  unsigned long end,
@@ -255,31 +296,6 @@ static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 	}
 }
 
-static void __remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
-					  unsigned long addr,
-					  struct list_head *remap_pages)
-{
-	unsigned long next;
-	unsigned long start = addr + RESERVE_VMEMMAP_SIZE;
-	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
-	struct page *reuse = NULL;
-
-	addr = start;
-	do {
-		pte_t *ptep;
-
-		ptep = pte_offset_kernel(pmd, addr);
-		if (!reuse)
-			reuse = pte_page(ptep[TAIL_PAGE_REUSE]);
-
-		next = vmemmap_hpage_addr_end(addr, end);
-		__remap_huge_page_pte_vmemmap(reuse, ptep, addr, next,
-					      remap_pages);
-	} while (pmd++, addr = next, addr != end);
-
-	flush_tlb_kernel_range(start, end);
-}
-
 static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
 {
 	int i;
@@ -308,8 +324,8 @@ void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 	BUG_ON(!pmd);
 
 	ptl = vmemmap_pmd_lock(pmd);
-	__remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head,
-				      &remap_pages);
+	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &remap_pages,
+				    __remap_huge_page_pte_vmemmap);
 	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd))) {
 		/*
 		 * Todo:
@@ -319,16 +335,6 @@ void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 	spin_unlock(ptl);
 }
 
-static inline void free_vmemmap_page_list(struct list_head *list)
-{
-	struct page *page, *next;
-
-	list_for_each_entry_safe(page, next, list, lru) {
-		list_del(&page->lru);
-		free_vmemmap_page(page);
-	}
-}
-
 static void __free_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 					 unsigned long start,
 					 unsigned long end,
@@ -351,31 +357,6 @@ static void __free_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 	}
 }
 
-static void __free_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
-					 unsigned long addr,
-					 struct list_head *free_pages)
-{
-	unsigned long next;
-	unsigned long start = addr + RESERVE_VMEMMAP_SIZE;
-	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
-	struct page *reuse = NULL;
-
-	addr = start;
-	do {
-		pte_t *ptep;
-
-		ptep = pte_offset_kernel(pmd, addr);
-		if (!reuse)
-			reuse = pte_page(ptep[TAIL_PAGE_REUSE]);
-
-		next = vmemmap_hpage_addr_end(addr, end);
-		__free_huge_page_pte_vmemmap(reuse, ptep, addr, next,
-					     free_pages);
-	} while (pmd++, addr = next, addr != end);
-
-	flush_tlb_kernel_range(start, end);
-}
-
 static void split_vmemmap_pmd(pmd_t *pmd, pte_t *pte_p, unsigned long addr)
 {
 	int i;
@@ -434,7 +415,8 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	if (vmemmap_pmd_huge(pmd))
 		split_vmemmap_huge_page(head, pmd);
 
-	__free_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages);
+	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages,
+				    __free_huge_page_pte_vmemmap);
 	freed_vmemmap_hpage_inc(pmd_page(*pmd));
 	spin_unlock(ptl);
 
-- 
2.11.0

