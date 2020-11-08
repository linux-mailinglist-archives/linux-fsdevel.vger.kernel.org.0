Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7792AAB83
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgKHOOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgKHOOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:14:06 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0D2C0613D2
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:14:05 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id x13so5500572pfa.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5vsp5cz7nqeZvlEeefM8xntwOmhgYGvqoQNYkr0v5o=;
        b=crcDJvQ/SQIxjVMdesINeBHr8CEREO4/Sd0UyzZJptxHEuHnpmcD7QCeSGudjmxLXh
         SCAbltgvlJGxyIT9ELDZ+pRUB+zNZXXwtsI0BxcIq9cA9QTlgxRrkt45uJIM6gEEl/IT
         H1TNRv2Rs+HGAOswp0PNLJrcipFTGpihCmKjsXWBSYiq6/g0acp5Vip60DqtXgLi8GYv
         0rbcD4M+rQggzMYmboEtA63ObrfNkKCLFA0WQvSHceGOaOY1Vab7jqwWfpVM61p3W2bJ
         1xPJGMxkvpG4eFIxBzWbCpD5td6aN08rdy9mMD7847D1LzViKbqvWnbxhySlMwX+1ydI
         pOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5vsp5cz7nqeZvlEeefM8xntwOmhgYGvqoQNYkr0v5o=;
        b=TBDD/wlTdsJE4vfJBavvLgZ6jWDeMaJ1pUWFC3X6DRblk6VgbbGFyOe4U/g79Jiswl
         DBTu8X2wE2NL//gzLYkECKQiPFsfOaD04PkePsPIxRPz6St7edb/YGXczKeO5pxWQ3cc
         xSxxmPszRa4PvwS2MuL2CaKdbJD2vWK6bgZ8qtGK1kTRdhmn29kwl4edeT7AKRAzsdmu
         mhcStfS2X8ipLd3CdvnjSBd99BIabqEe9k7mKIz3ylTE9eUu2snBNVoXz3/Y6wzlXPDR
         nUXfdFOoQKQr2CSi/bxz+bK6owBM5RXcFnW0hDtDlaSc6BkRpi4s4z3/6Q9nlquk3bIA
         EEcQ==
X-Gm-Message-State: AOAM530uiF4yOwL37fxoNmcJvSnnKpJ7l++1MMRgVdLB5F4CjKIAiVIQ
        7K8BiwbWqdP4EtXPdPz3vpRJVA==
X-Google-Smtp-Source: ABdhPJyHSdHNLyD+JvJJ9n4ojdMe2eNz7H1OMTUv8Ux8jiTESj6P6wy2aULkhzIVqV2ACIhNbNGlsw==
X-Received: by 2002:a62:f245:0:b029:18b:df86:191c with SMTP id y5-20020a62f2450000b029018bdf86191cmr4765153pfl.35.1604844845284;
        Sun, 08 Nov 2020 06:14:05 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.13.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:14:04 -0800 (PST)
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
Subject: [PATCH v3 14/21] mm/hugetlb: Support freeing vmemmap pages of gigantic page
Date:   Sun,  8 Nov 2020 22:11:06 +0800
Message-Id: <20201108141113.65450-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The gigantic page is allocated by bootmem, if we want to free the
unused vmemmap pages. We also should allocate the page table. So
we also allocate page tables from bootmem.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index afb9b18771c4..f8ca4d251aa8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -506,6 +506,9 @@ struct hstate {
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	pte_t *vmemmap_pte;
+#endif
 };
 
 struct page *alloc_huge_page(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9b1ac52d9fdd..ec0d33d2c426 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1419,6 +1419,62 @@ static void vmemmap_pgtable_free(struct hstate *h, struct page *page)
 		pte_free_kernel(&init_mm, page_to_virt(pgtable));
 }
 
+static unsigned long __init gather_vmemmap_pgtable_prealloc(void)
+{
+	struct huge_bootmem_page *m, *tmp;
+	unsigned long nr_free = 0;
+
+	list_for_each_entry_safe(m, tmp, &huge_boot_pages, list) {
+		struct hstate *h = m->hstate;
+		unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+		unsigned int pgtable_size;
+
+		if (!nr)
+			continue;
+
+		pgtable_size = nr << PAGE_SHIFT;
+		m->vmemmap_pte = memblock_alloc_try_nid(pgtable_size,
+				PAGE_SIZE, 0, MEMBLOCK_ALLOC_ACCESSIBLE,
+				NUMA_NO_NODE);
+		if (!m->vmemmap_pte) {
+			nr_free++;
+			list_del(&m->list);
+			memblock_free_early(__pa(m), huge_page_size(h));
+		}
+	}
+
+	return nr_free;
+}
+
+static void __init gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+					       struct page *page)
+{
+	int i;
+	struct hstate *h = m->hstate;
+	unsigned long pte = (unsigned long)m->vmemmap_pte;
+	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+
+	if (!nr)
+		return;
+
+	vmemmap_pgtable_init(page);
+
+	for (i = 0; i < nr; i++, pte += PAGE_SIZE) {
+		pgtable_t pgtable = virt_to_page(pte);
+
+		__ClearPageReserved(pgtable);
+		vmemmap_pgtable_deposit(page, pgtable);
+	}
+
+	/*
+	 * If we had gigantic hugepages allocated at boot time, we need
+	 * to restore the 'stolen' pages to totalram_pages in order to
+	 * fix confusing memory reports from free(1) and another
+	 * side-effects, like CommitLimit going negative.
+	 */
+	adjust_managed_page_count(page, nr);
+}
+
 static void __init hugetlb_vmemmap_init(struct hstate *h)
 {
 	unsigned int order = huge_page_order(h);
@@ -1752,6 +1808,16 @@ static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
 {
 }
 
+static inline unsigned long gather_vmemmap_pgtable_prealloc(void)
+{
+	return 0;
+}
+
+static inline void gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+					       struct page *page)
+{
+}
+
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
@@ -3013,6 +3079,7 @@ static void __init gather_bootmem_prealloc(void)
 		WARN_ON(page_count(page) != 1);
 		prep_compound_huge_page(page, h->order);
 		WARN_ON(PageReserved(page));
+		gather_vmemmap_pgtable_init(m, page);
 		prep_new_huge_page(h, page, page_to_nid(page));
 		put_page(page); /* free it into the hugepage allocator */
 
@@ -3065,6 +3132,10 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 			break;
 		cond_resched();
 	}
+
+	if (hstate_is_gigantic(h))
+		i -= gather_vmemmap_pgtable_prealloc();
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
-- 
2.11.0

