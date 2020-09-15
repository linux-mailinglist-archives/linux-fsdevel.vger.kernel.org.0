Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5326B884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIPAoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgIONBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:01:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4914C061354
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so1972675pgl.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7qZ2BwXX/ZVANEcHk8/fyjZQtNSlbjNG3JjBN1i9+E=;
        b=K0+TtRoQ0iBLsidzNfDucv/964bgNOsr/noRAqmDAfTjJMtaNxLaRm83+mJUhcr54j
         KNh3l/4HZdMPba82hDWu7cxPi3ZrtwGlBNyZkuZzQlmeC2t6B8VtRsi+raONTYolNT73
         7r1ueK3UAuXFx0RS7WTMb2XdbueEX7Tw/ZU/o9NUO6+BuP9cVlweh2dt23epZyI0f9RA
         qQjz5EuUOz4OYzz7lCZ4QYZzig1RqkoG0CzEJ06v/ZltzeXQqA8JkDNhKt7KQEHAvdf6
         F0RxAEaLFcwVHtW165J5QbIrtdb0RuRKnEuvQWLVc9AUWNBmGjZss5M7+PHZF2WAQPM0
         pLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7qZ2BwXX/ZVANEcHk8/fyjZQtNSlbjNG3JjBN1i9+E=;
        b=S52npAQ4zfcMSTBQ++Y66aSapUQ9t6sghFBlIh/9xvlgyz1GwFWTOLp6o4IeKqYRmE
         OpDgixoBiFbOp1FPZmUa36vxvoy1cgsHpmMQW44B7muWyggCWwJ63rES2FV5TpukxUlB
         s868udDt4ULGiDep1lS9vj9nFslAQpey97qXlyKmFCCjSjdhuSMR739QKqbJ23jLAn/U
         myeG+1nwV1O6modWq4scvL2tTH562T5/KCWfT3FHaoAjkF/8mreCTpQrm8/5yiU3SnZZ
         TikX4h04XN92s89Z7CZh7P5OloBM3d5k9yqPF/4/h74D8Kzldg6bXhbernQU0kZHNl/X
         7j2A==
X-Gm-Message-State: AOAM5324reuZ1I6Yj1MTOw6gINveBOZrFGt+426mbj06BU90GyLkJr1o
        y9wLO460APDqNqjJ3ac5p/taPQ==
X-Google-Smtp-Source: ABdhPJzwahGiSKr1NRGUl09d6iuN/pmblKyvvg/Fup+XIG5qhKQz4c4TIZOJ3KaUzNx9x8K8iv5qkA==
X-Received: by 2002:a63:cb0a:: with SMTP id p10mr15017791pgg.314.1600174867618;
        Tue, 15 Sep 2020 06:01:07 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.00.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:01:07 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 06/24] mm/hugetlb: Introduce pgtable allocation/freeing helpers
Date:   Tue, 15 Sep 2020 20:59:29 +0800
Message-Id: <20200915125947.26204-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On some architectures, the vmemmap areas use huge page mapping.
If we want to free the unused vmemmap pages, we have to split
the huge pmd firstly. So we should pre-allocate pgtable to split
huge pmd.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  17 ++++++
 mm/hugetlb.c            | 117 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index eed3dd3bd626..ace304a6196c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -593,6 +593,23 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 
 #include <asm/hugetlb.h>
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#ifndef arch_vmemmap_support_huge_mapping
+static inline bool arch_vmemmap_support_huge_mapping(void)
+{
+	return false;
+}
+#endif
+
+#ifndef VMEMMAP_HPAGE_SHIFT
+#define VMEMMAP_HPAGE_SHIFT		PMD_SHIFT
+#endif
+#define VMEMMAP_HPAGE_ORDER		(VMEMMAP_HPAGE_SHIFT - PAGE_SHIFT)
+#define VMEMMAP_HPAGE_NR		(1 << VMEMMAP_HPAGE_ORDER)
+#define VMEMMAP_HPAGE_SIZE		((1UL) << VMEMMAP_HPAGE_SHIFT)
+#define VMEMMAP_HPAGE_MASK		(~(VMEMMAP_HPAGE_SIZE - 1))
+#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
+
 #ifndef is_hugepage_only_range
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					unsigned long addr, unsigned long len)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f1b2b733b49b..d6ae9b6876be 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1295,11 +1295,108 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 #define RESERVE_VMEMMAP_NR	2U
 
+#define page_huge_pte(page)	((page)->pmd_huge_pte)
+
 static inline unsigned int nr_free_vmemmap(struct hstate *h)
 {
 	return h->nr_free_vmemmap_pages;
 }
 
+static inline unsigned int nr_vmemmap(struct hstate *h)
+{
+	return nr_free_vmemmap(h) + RESERVE_VMEMMAP_NR;
+}
+
+static inline unsigned long nr_vmemmap_size(struct hstate *h)
+{
+	return (unsigned long)nr_vmemmap(h) << PAGE_SHIFT;
+}
+
+static inline unsigned int nr_pgtable(struct hstate *h)
+{
+	unsigned long vmemmap_size = nr_vmemmap_size(h);
+
+	if (!arch_vmemmap_support_huge_mapping())
+		return 0;
+
+	/*
+	 * No need pre-allocate page tabels when there is no vmemmap pages
+	 * to free.
+	 */
+	if (!nr_free_vmemmap(h))
+		return 0;
+
+	return ALIGN(vmemmap_size, VMEMMAP_HPAGE_SIZE) >> VMEMMAP_HPAGE_SHIFT;
+}
+
+static inline void vmemmap_pgtable_init(struct page *page)
+{
+	page_huge_pte(page) = NULL;
+}
+
+static void vmemmap_pgtable_deposit(struct page *page, pte_t *pte_p)
+{
+	pgtable_t pgtable = virt_to_page(pte_p);
+
+	/* FIFO */
+	if (!page_huge_pte(page))
+		INIT_LIST_HEAD(&pgtable->lru);
+	else
+		list_add(&pgtable->lru, &page_huge_pte(page)->lru);
+	page_huge_pte(page) = pgtable;
+}
+
+static pte_t *vmemmap_pgtable_withdraw(struct page *page)
+{
+	pgtable_t pgtable;
+
+	/* FIFO */
+	pgtable = page_huge_pte(page);
+	if (unlikely(!pgtable))
+		return NULL;
+	page_huge_pte(page) = list_first_entry_or_null(&pgtable->lru,
+						       struct page, lru);
+	if (page_huge_pte(page))
+		list_del(&pgtable->lru);
+	return page_to_virt(pgtable);
+}
+
+static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
+{
+	int i;
+	pte_t *pte_p;
+	unsigned int nr = nr_pgtable(h);
+
+	if (!nr)
+		return 0;
+
+	vmemmap_pgtable_init(page);
+
+	for (i = 0; i < nr; i++) {
+		pte_p = pte_alloc_one_kernel(&init_mm);
+		if (!pte_p)
+			goto out;
+		vmemmap_pgtable_deposit(page, pte_p);
+	}
+
+	return 0;
+out:
+	while (i-- && (pte_p = vmemmap_pgtable_withdraw(page)))
+		pte_free_kernel(&init_mm, pte_p);
+	return -ENOMEM;
+}
+
+static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
+{
+	pte_t *pte_p;
+
+	if (!nr_pgtable(h))
+		return;
+
+	while ((pte_p = vmemmap_pgtable_withdraw(page)))
+		pte_free_kernel(&init_mm, pte_p);
+}
+
 static void __init hugetlb_vmemmap_init(struct hstate *h)
 {
 	unsigned int order = huge_page_order(h);
@@ -1323,6 +1420,15 @@ static void __init hugetlb_vmemmap_init(struct hstate *h)
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
 }
+
+static inline int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
+{
+	return 0;
+}
+
+static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
+{
+}
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
@@ -1531,6 +1637,9 @@ void free_huge_page(struct page *page)
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
+	/* Must be called before the initialization of @page->lru */
+	vmemmap_pgtable_free(h, page);
+
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	set_hugetlb_cgroup(page, NULL);
@@ -1783,6 +1892,14 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 	if (!page)
 		return NULL;
 
+	if (vmemmap_pgtable_prealloc(h, page)) {
+		if (hstate_is_gigantic(h))
+			free_gigantic_page(page, huge_page_order(h));
+		else
+			put_page(page);
+		return NULL;
+	}
+
 	if (hstate_is_gigantic(h))
 		prep_compound_gigantic_page(page, huge_page_order(h));
 	prep_new_huge_page(h, page, page_to_nid(page));
-- 
2.20.1

