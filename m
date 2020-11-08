Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4DA2AAB92
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgKHOO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgKHOO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:14:58 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E2FC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:14:56 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g11so3249891pll.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qt8rSyxnY6ivqdXKrIuDFH2FNO7xD/1XUBAOOo28q3E=;
        b=Zv7w55D/QwZ4Fb0KWjH6xMndfPONJ425wcB6ctKB9PIuL4HW5e8j77Tgcsdd8sBt4a
         TChCoGjooOfvznw9ryLRGYGeqaqz/Cgd7Ot651qqZ4hjIrpNW3I/76kzm6wMfcN/7Ddy
         6mc39Xe3BDPLG2Be3Eb5zfqaiCLQ8LZfFCla06FaKFLwL6h1W5k/ST6HTL+EJMbbkNp3
         02mZEk5b9MWZOGeVLzXguPrRucoI2bCdH95wM+g5OXZpea7quuiDiY8/PcgUjsZfi0yD
         3kLpsNdZJyCDbyGh2GucV042je/YtVdjQdUFeSsv525r5f3FdaSaYfdvC2wH0my3vdh5
         fHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qt8rSyxnY6ivqdXKrIuDFH2FNO7xD/1XUBAOOo28q3E=;
        b=ezepu7FrhNj9Kcg/vSSJzA/zkTB1f8QisjkCUR8vYoTcVWO1CMozw2NZFtjKfwaqac
         3RE/7DsiFi5pBzqYNf1ltrfjBedaqLQAp63c6x6GB3V70eBw3zkymqROWkCfLLwBpHzp
         NHSIpnElHTKoIErDtoJlTj4rLBQuoE+gXqoFBdiIwKKNgZ+s+P5gutdpYkF2wjNE+hjq
         BzOWDFFZGMYG/rs4xPWsawF8q9dseABO97DiS4WzTzMXrGnbernXygyAlyhlPNxuid7x
         zDK+dWtSs1FuMWrWrVaoMeBlUrNYBGJWIGJUNB/FMWcWquzQYGEDBaRTc2rSdMZNgX6b
         /xqg==
X-Gm-Message-State: AOAM530iP+fTlOA2+Oj5p5YZNLiZObr0oPXld0jVFwh+WzF+sfW/jCHu
        i3IW8T77ysHhdhPg0EmqVZBIpg==
X-Google-Smtp-Source: ABdhPJziW7gkH63G6HMPp/eINNu8bOyx1G0bL2TJha3usgQPV3fodBmg/PyvAkln/Z6pfQFbDewzgw==
X-Received: by 2002:a17:902:59cd:b029:d6:7656:af1 with SMTP id d13-20020a17090259cdb02900d676560af1mr9077723plj.43.1604844896289;
        Sun, 08 Nov 2020 06:14:56 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:14:55 -0800 (PST)
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
Subject: [PATCH v3 19/21] mm/hugetlb: Merge pte to huge pmd only for gigantic page
Date:   Sun,  8 Nov 2020 22:11:11 +0800
Message-Id: <20201108141113.65450-20-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge pte to huge pmd if it has ever been split. Now only support
gigantic page which's vmemmap pages size is an integer multiple of
PMD_SIZE. This is the simplest case to handle.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/include/asm/hugetlb.h |   8 +++
 include/linux/hugetlb.h        |   8 +++
 mm/hugetlb.c                   | 108 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index c601fe042832..1de1c519a84a 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -12,6 +12,14 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
 {
 	return pmd_large(*pmd);
 }
+
+#define vmemmap_pmd_mkhuge vmemmap_pmd_mkhuge
+static inline pmd_t vmemmap_pmd_mkhuge(struct page *page)
+{
+	pte_t entry = pfn_pte(page_to_pfn(page), PAGE_KERNEL_LARGE);
+
+	return __pmd(pte_val(entry));
+}
 #endif
 
 #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f8ca4d251aa8..32abfb420731 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -605,6 +605,14 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
 }
 #endif
 
+#ifndef vmemmap_pmd_mkhuge
+#define vmemmap_pmd_mkhuge vmemmap_pmd_mkhuge
+static inline pmd_t vmemmap_pmd_mkhuge(struct page *page)
+{
+	return pmd_mkhuge(mk_pmd(page, PAGE_KERNEL));
+}
+#endif
+
 #ifndef VMEMMAP_HPAGE_SHIFT
 #define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c97a1d30fd9..52e56c3a9b72 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1708,6 +1708,63 @@ static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 	}
 }
 
+static void __replace_huge_page_pte_vmemmap(pte_t *ptep, unsigned long start,
+					    unsigned int nr, struct page *huge,
+					    struct list_head *free_pages)
+{
+	unsigned long addr;
+	unsigned long end = start + (nr << PAGE_SHIFT);
+	pgprot_t pgprot = PAGE_KERNEL;
+
+	for (addr = start; addr < end; addr += PAGE_SIZE, ptep++) {
+		struct page *page;
+		pte_t old = *ptep;
+		pte_t entry;
+
+		prepare_vmemmap_page(huge);
+
+		entry = mk_pte(huge++, pgprot);
+		VM_WARN_ON(!pte_present(old));
+		page = pte_page(old);
+		list_add(&page->lru, free_pages);
+
+		set_pte_at(&init_mm, addr, ptep, entry);
+	}
+}
+
+static void replace_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
+					  struct page *huge,
+					  struct list_head *free_pages)
+{
+	unsigned long end = start + VMEMMAP_HPAGE_SIZE;
+
+	flush_cache_vunmap(start, end);
+	__replace_huge_page_pte_vmemmap(pte_offset_kernel(pmd, start), start,
+					VMEMMAP_HPAGE_NR, huge, free_pages);
+	flush_tlb_kernel_range(start, end);
+}
+
+static pte_t *merge_vmemmap_pte(pmd_t *pmdp, unsigned long addr)
+{
+	pte_t *pte;
+	struct page *page;
+
+	pte = pte_offset_kernel(pmdp, addr);
+	page = pte_page(*pte);
+	set_pmd(pmdp, vmemmap_pmd_mkhuge(page));
+
+	return pte;
+}
+
+static void merge_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
+					struct page *huge,
+					struct list_head *free_pages)
+{
+	replace_huge_page_pmd_vmemmap(pmd, start, huge, free_pages);
+	pte_free_kernel(&init_mm, merge_vmemmap_pte(pmd, start));
+	flush_tlb_kernel_range(start, start + VMEMMAP_HPAGE_SIZE);
+}
+
 static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
 {
 	int i;
@@ -1721,6 +1778,15 @@ static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
 	}
 }
 
+static inline void dissolve_compound_page(struct page *page, unsigned int order)
+{
+	int i;
+	unsigned int nr_pages = 1 << order;
+
+	for (i = 1; i < nr_pages; i++)
+		set_page_refcounted(page + i);
+}
+
 static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 	pmd_t *pmd;
@@ -1738,10 +1804,48 @@ static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 				    __remap_huge_page_pte_vmemmap);
 	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd)) && pmd_split(pmd)) {
 		/*
-		 * Todo:
-		 * Merge pte to huge pmd if it has ever been split.
+		 * Merge pte to huge pmd if it has ever been split. Now only
+		 * support gigantic page which's vmemmap pages size is an
+		 * integer multiple of PMD_SIZE. This is the simplest case
+		 * to handle.
 		 */
 		clear_pmd_split(pmd);
+
+		if (IS_ALIGNED(vmemmap_pages_per_hpage(h), VMEMMAP_HPAGE_NR)) {
+			unsigned long addr = (unsigned long)head;
+			unsigned long end = addr +
+					    vmemmap_pages_size_per_hpage(h);
+
+			spin_unlock(ptl);
+
+			for (; addr < end; addr += VMEMMAP_HPAGE_SIZE) {
+				void *to;
+				struct page *page;
+
+				page = alloc_pages(GFP_VMEMMAP_PAGE & ~__GFP_NOFAIL,
+						   VMEMMAP_HPAGE_ORDER);
+				if (!page)
+					goto out;
+
+				dissolve_compound_page(page,
+						       VMEMMAP_HPAGE_ORDER);
+				to = page_to_virt(page);
+				memcpy(to, (void *)addr, VMEMMAP_HPAGE_SIZE);
+
+				/*
+				 * Make sure that any data that writes to the
+				 * @to is made visible to the physical page.
+				 */
+				flush_kernel_vmap_range(to, VMEMMAP_HPAGE_SIZE);
+
+				merge_huge_page_pmd_vmemmap(pmd++, addr, page,
+							    &remap_pages);
+			}
+
+out:
+			free_vmemmap_page_list(&remap_pages);
+			return;
+		}
 	}
 	spin_unlock(ptl);
 }
-- 
2.11.0

