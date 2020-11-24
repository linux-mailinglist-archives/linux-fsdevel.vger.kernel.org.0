Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412D12C2256
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgKXJ6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbgKXJ6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:58:38 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2447DC0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:58:38 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id x24so5717237pfn.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFwyQlsscT2RBnxHWArfuTVJVgRwj0xOpsgIKb91Ge0=;
        b=XDYX4dXdNWF3Fzn1dtGBYeifCfGEgb75fiQL65NrdLEisMD4Yjgdvk+N3BLItujm2a
         5JfBNhqze5ZmKNgmb89doGH/AVnWBc3oYcTwUB6v9/vBFfJ+eGIGaXWtcCtPNocKonY2
         kf0Pe5l2R4v/U84HUg8jxCoLkeTAsG9C5UtfLckgc3/SHCik32CyJ9ErPu/2B2AeXp4B
         37/TibIqva5tDvTnGJQ/Z26Box1IlLx/ZpK1cfdoD4kyV4mfV+Y2JmlmdIqDhize0RU1
         lABC0IrCkGG5KdoT+6mSWOtT9BbVzcXez3Iupgxa9K82Kav6b5abq0J0W1KWZHEjaDTA
         JPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFwyQlsscT2RBnxHWArfuTVJVgRwj0xOpsgIKb91Ge0=;
        b=SMoP5SUjnbQ8QV5NCfaatpMGxGIaPNnaOs5HaVAAUUy+d5T+De8DUX7haUxg4MCM08
         XThL5leQdO9xIgYYEguM7/oh9Ktg4uq9/ii0Q6EbzzY/DLzJsL2PxNQx4jDASKS2OKTr
         ohcAFFBSlPpuf91KxjBSsmubt44fOdmpKYCAqMTTSAL3v+pRpVaN6g/AtFgYcD3z298o
         DGOMFaVzmPOjdrEQ6WCpyzKFRNUS2C/pL2QrNpjdbY6M5enqO/8zVTj9BGKt0Qsa2uON
         h4TvdGqHJiE8sNYNp6E1Ad2Vzm5orA4T4Ox/9TM6cZm6ppef7k77aldlYiVIakqXm3yw
         Bx0w==
X-Gm-Message-State: AOAM5316escBIqt/GirPYrh3v3Ib+LxotFdyHAfXRpyg9f0xYn2SHULn
        SQb84i/SD1D20z3nuWYX51q8Ww==
X-Google-Smtp-Source: ABdhPJxo20c2KFbIHjZgWLrl89GNL9t8kpfDAKmq+mis09TlkPg6pRW/DaEm5NbaUDzC6/ruk91INQ==
X-Received: by 2002:a17:90b:3781:: with SMTP id mz1mr3959844pjb.229.1606211917751;
        Tue, 24 Nov 2020 01:58:37 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.58.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:58:37 -0800 (PST)
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
Subject: [PATCH v6 11/16] mm/hugetlb: Introduce remap_huge_page_pmd_vmemmap helper
Date:   Tue, 24 Nov 2020 17:52:54 +0800
Message-Id: <20201124095259.58755-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
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
 mm/hugetlb_vmemmap.c | 87 +++++++++++++++++++++-------------------------------
 1 file changed, 35 insertions(+), 52 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index d6a1b06c1322..509ca451e232 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -127,6 +127,10 @@
 	(__boundary - 1 < (end) - 1) ? __boundary : (end);		 \
 })
 
+typedef void (*vmemmap_pte_remap_func_t)(struct page *reuse, pte_t *ptep,
+					 unsigned long start, unsigned long end,
+					 void *priv);
+
 static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
@@ -162,21 +166,42 @@ static pmd_t *vmemmap_to_pmd(unsigned long page)
 	return pmd_offset(pud, page);
 }
 
+static void remap_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
+					unsigned long end,
+					vmemmap_pte_remap_func_t fn, void *priv)
+{
+	unsigned long next, addr = start;
+	struct page *reuse = NULL;
+
+	do {
+		pte_t *ptep;
+
+		ptep = pte_offset_kernel(pmd, addr);
+		if (!reuse)
+			reuse = pte_page(ptep[TAIL_PAGE_REUSE]);
+
+		next = vmemmap_hpage_addr_end(addr, end);
+		fn(reuse, ptep, addr, next, priv);
+	} while (pmd++, addr = next, addr != end);
+
+	flush_tlb_kernel_range(start, end);
+}
+
 static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 					  unsigned long start,
-					  unsigned long end,
-					  struct list_head *remap_pages)
+					  unsigned long end, void *priv)
 {
 	pgprot_t pgprot = PAGE_KERNEL;
 	void *from = page_to_virt(reuse);
 	unsigned long addr;
+	struct list_head *pages = priv;
 
 	for (addr = start; addr < end; addr += PAGE_SIZE) {
 		void *to;
 		struct page *page;
 		pte_t entry, old = *ptep;
 
-		page = list_first_entry(remap_pages, struct page, lru);
+		page = list_first_entry(pages, struct page, lru);
 		list_del(&page->lru);
 		to = page_to_virt(page);
 		copy_page(to, from);
@@ -196,28 +221,6 @@ static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 	}
 }
 
-static void __remap_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
-					  unsigned long end,
-					  struct list_head *vmemmap_pages)
-{
-	unsigned long next, addr = start;
-	struct page *reuse = NULL;
-
-	do {
-		pte_t *ptep;
-
-		ptep = pte_offset_kernel(pmd, addr);
-		if (!reuse)
-			reuse = pte_page(ptep[TAIL_PAGE_REUSE]);
-
-		next = vmemmap_hpage_addr_end(addr, end);
-		__remap_huge_page_pte_vmemmap(reuse, ptep, addr, next,
-					      vmemmap_pages);
-	} while (pmd++, addr = next, addr != end);
-
-	flush_tlb_kernel_range(start, end);
-}
-
 static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
 {
 	unsigned int nr = free_vmemmap_pages_per_hpage(h);
@@ -258,7 +261,8 @@ void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	start = vmemmap_addr + RESERVE_VMEMMAP_SIZE;
 	end = vmemmap_addr + vmemmap_pages_size_per_hpage(h);
-	__remap_huge_page_pmd_vmemmap(pmd, start, end, &map_pages);
+	remap_huge_page_pmd_vmemmap(pmd, start, end,
+				    __remap_huge_page_pte_vmemmap, &map_pages);
 }
 
 static inline void free_vmemmap_page_list(struct list_head *list)
@@ -273,13 +277,13 @@ static inline void free_vmemmap_page_list(struct list_head *list)
 
 static void __free_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 					 unsigned long start,
-					 unsigned long end,
-					 struct list_head *free_pages)
+					 unsigned long end, void *priv)
 {
 	/* Make the tail pages are mapped read-only. */
 	pgprot_t pgprot = PAGE_KERNEL_RO;
 	pte_t entry = mk_pte(reuse, pgprot);
 	unsigned long addr;
+	struct list_head *pages = priv;
 
 	for (addr = start; addr < end; addr += PAGE_SIZE, ptep++) {
 		struct page *page;
@@ -287,34 +291,12 @@ static void __free_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 
 		VM_WARN_ON(!pte_present(old));
 		page = pte_page(old);
-		list_add(&page->lru, free_pages);
+		list_add(&page->lru, pages);
 
 		set_pte_at(&init_mm, addr, ptep, entry);
 	}
 }
 
-static void __free_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
-					 unsigned long end,
-					 struct list_head *vmemmap_pages)
-{
-	unsigned long next, addr = start;
-	struct page *reuse = NULL;
-
-	do {
-		pte_t *ptep;
-
-		ptep = pte_offset_kernel(pmd, addr);
-		if (!reuse)
-			reuse = pte_page(ptep[TAIL_PAGE_REUSE]);
-
-		next = vmemmap_hpage_addr_end(addr, end);
-		__free_huge_page_pte_vmemmap(reuse, ptep, addr, next,
-					     vmemmap_pages);
-	} while (pmd++, addr = next, addr != end);
-
-	flush_tlb_kernel_range(start, end);
-}
-
 void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 	pmd_t *pmd;
@@ -330,7 +312,8 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	start = vmemmap_addr + RESERVE_VMEMMAP_SIZE;
 	end = vmemmap_addr + vmemmap_pages_size_per_hpage(h);
-	__free_huge_page_pmd_vmemmap(pmd, start, end, &free_pages);
+	remap_huge_page_pmd_vmemmap(pmd, start, end,
+				    __free_huge_page_pte_vmemmap, &free_pages);
 	free_vmemmap_page_list(&free_pages);
 }
 
-- 
2.11.0

