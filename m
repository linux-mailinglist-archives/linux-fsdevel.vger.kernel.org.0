Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20622B19C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 12:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKMLOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 06:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgKMLGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:06:08 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0224AC061A4D
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:04:21 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 62so6796605pgg.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dnPV1b6uHWD2D+PaHlh5ehZyTbtQb+H242CmT/tu8g=;
        b=x4h4toznMW9myqfV4/4rtBvtB3x76JiQu2/IusbB/1Q3+xmDQkJKzs1TsHxWt/zxkF
         rYvDmGEcnfWEohs8dWmCxfpMQzt24NSGwNE/8jF+QNl7QAMOnnzgFAoAaNkOF+Gs7R5z
         ObcAsEEqtcE/KIQyrxRkTW1EBlAAjJm02KYO6I/NcZ0TuIKNyDrTkulq8q2o0zu76NJV
         RMlNYeE2QRpW39xbzGLuIaY4CIkMKnZTo3OHOMKlEdgEUMTm95kK/Tb+3b0ze2akmsxM
         KqtPCxok9SvhICziSupm5tLHqksj/uRJkxvuQyRQ3bddyhwUldhnUzZSBiFUz0yeyeGZ
         QrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dnPV1b6uHWD2D+PaHlh5ehZyTbtQb+H242CmT/tu8g=;
        b=svxC7TraAeWMDaJejcB7cNUlEhO/H6+nDkdeRJJdwkOIUSYYv4egUVj+vxCLsql6rU
         4wOP+UU2YDOEFwOi26cnQAVn+/unkUszSvRawQGEGKyo5BobCQwThvyE2hwzXQJuHUAf
         a47U7LQEs/MSDkUEj4JvtyfzvyixB3G3ilza0+zNK1uPkZhe3sgErRixeYObWsvnt6vY
         nAuTlRqbMuQzShj66mwHmkJB3zfLwqVVl0oIcZFhu4FrVwHdmRHfVPuY2exNoz+UsrAC
         QsYlbUFzYPm0PIyZYr23o6HjKs6g0CUykEHAaaHnxqim0PhFJI5fua9jrR/B67Cu+RTo
         y7RA==
X-Gm-Message-State: AOAM532GfUbMzjiwYfquZbW5D3HfMQ8ML3bjsRrSkjLMHRkqhK74e1my
        gSF1tuX15vzYkYGrEOPmWWTgPg==
X-Google-Smtp-Source: ABdhPJwej1GeIBlLpEuMCUF9hhhhxhMLbmKZpJvqWgyB4Wj77yK7vWxMgfdOWrnLEfwZC9Rr+9YU8w==
X-Received: by 2002:a63:cb51:: with SMTP id m17mr1607379pgi.337.1605265460592;
        Fri, 13 Nov 2020 03:04:20 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.04.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:04:19 -0800 (PST)
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
Subject: [PATCH v4 18/21] mm/hugetlb: Merge pte to huge pmd only for gigantic page
Date:   Fri, 13 Nov 2020 18:59:49 +0800
Message-Id: <20201113105952.11638-19-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
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
 mm/hugetlb_vmemmap.c           | 118 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 2 deletions(-)

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
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 1528b156920c..5c00826a98b3 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -118,6 +118,14 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
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
 static bool hugetlb_free_vmemmap_disabled __initdata;
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
@@ -386,6 +394,104 @@ static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
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
+static inline void dissolve_compound_page(struct page *page, unsigned int order)
+{
+	int i;
+	unsigned int nr_pages = 1 << order;
+
+	for (i = 1; i < nr_pages; i++)
+		set_page_count(page + i, 1);
+}
+
+static void merge_gigantic_page_vmemmap(struct hstate *h, struct page *head,
+					pmd_t *pmd)
+{
+	LIST_HEAD(free_pages);
+	unsigned long addr = (unsigned long)head;
+	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
+
+	for (; addr < end; addr += VMEMMAP_HPAGE_SIZE) {
+		void *to;
+		struct page *page;
+
+		page = alloc_pages(GFP_VMEMMAP_PAGE & ~__GFP_NOFAIL,
+				   VMEMMAP_HPAGE_ORDER);
+		if (!page)
+			goto out;
+
+		dissolve_compound_page(page, VMEMMAP_HPAGE_ORDER);
+		to = page_to_virt(page);
+		memcpy(to, (void *)addr, VMEMMAP_HPAGE_SIZE);
+
+		/*
+		 * Make sure that any data that writes to the
+		 * @to is made visible to the physical page.
+		 */
+		flush_kernel_vmap_range(to, VMEMMAP_HPAGE_SIZE);
+
+		merge_huge_page_pmd_vmemmap(pmd++, addr, page, &free_pages);
+	}
+out:
+	free_vmemmap_page_list(&free_pages);
+}
+
 static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
 {
 	int i;
@@ -418,10 +524,18 @@ void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
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
+			spin_unlock(ptl);
+			merge_gigantic_page_vmemmap(h, head, pmd);
+			return;
+		}
 	}
 	spin_unlock(ptl);
 }
-- 
2.11.0

