Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4CB26B85C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgIPAm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgIONCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:02:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD2C061356
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so1860622pfg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqeab9EuD6rx+ThTnTknvhPa5CCnZBGF8qbz9+1B3Rg=;
        b=cTyfEBaT8uZv91AMd6inH0d/3b50kH2ZmfriY6M0AQFvZ20H8u04GHyk0YwSRO8Xwu
         R4/nW8u1J0ZffnhIDgmPhhScvMxPmPeMFf38jU1TDGXnTHT4ouHLjR1aZYj4a7ReYyh5
         FjXO7PRtC5txw6ftof7Jw8JcZY23SkpoxC0pPLU0Mxrt391VJBF7QfIoUD/ZmlLRhWEM
         nqav34uGU4Pj1ms1ixaKWy+RHtfMMHEBsau8aO59dXIqSUv+iHdW+YgjMcWv9PmN3lC2
         UsGWdWzBhDtojQgvyqKBYGV2aDJOnYmB4mXs9sE0DBDzgWQC09PLCA809Zqxc0TNgENI
         S5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqeab9EuD6rx+ThTnTknvhPa5CCnZBGF8qbz9+1B3Rg=;
        b=SpHEEbwu6ApTEShTjvwiCtjbrWx1EVIyILSbJhYmVouNFK7DWJ2UOGNaqcAccuozpS
         ukeiySDtkl6QLW0Z4h4+UTThphODP+ZktpLF71Aa37mZWtMRg11LlHLC9MzikCr5yTQA
         92EpSkIb5vO0ff0zlgAXdBdRZDCczI6EZf1FhJoDqmVZ04aC9xgut09wpazWwxbDq/zf
         Ynv+hX+HwsxNGQSl/xNWeFxgjaKNp8WlvrCNHHKeaQQUu7EQKPe4p3MjBPg+Fr4xC8o4
         V1y5mRu6crzgqQEskUkCKHcKmTJNuW2Y/1oroa52aTKIrAp3oi8B3KG3m0xd4qF9KZG3
         +Nvg==
X-Gm-Message-State: AOAM531d2NiQeFXQAwLbVotOfDvUQt6PPziESLveIWL9QTmhshuE4cJZ
        HFuzmpBTM8S7XaHESUWH4keNYg==
X-Google-Smtp-Source: ABdhPJxh7eBoOFLH3hJ5HKuuUOo/K5zM4KapOdf8UN2kqGT13hJ4/HNKAuLAmqUUqzdl5r9Y4jcljw==
X-Received: by 2002:aa7:8e54:0:b029:142:2501:34d2 with SMTP id d20-20020aa78e540000b0290142250134d2mr1722923pfr.43.1600174964466;
        Tue, 15 Sep 2020 06:02:44 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.02.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:02:44 -0700 (PDT)
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
Subject: [RFC PATCH 16/24] mm/hugetlb: Support freeing vmemmap pages of gigantic page
Date:   Tue, 15 Sep 2020 20:59:39 +0800
Message-Id: <20200915125947.26204-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The gigantic page is allocated by bootmem, if we want to free the
unused vmemmap pages. We also should allocate the page table. So
we also allocate page tables from bootmem.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 57 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2561af2ad901..e3aa192f1c39 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -506,6 +506,9 @@ struct hstate {
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	pte_t *vmemmap_pgtable;
+#endif
 };
 
 struct page *alloc_huge_page(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c42c27a12df2..7072b849af3d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1410,6 +1410,48 @@ static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
 		pte_free_kernel(&init_mm, pte_p);
 }
 
+static unsigned long __init gather_vmemmap_pgtable_prealloc(void)
+{
+	struct huge_bootmem_page *m, *tmp;
+	unsigned long nr_free = 0;
+
+	list_for_each_entry_safe(m, tmp, &huge_boot_pages, list) {
+		struct hstate *h = m->hstate;
+		unsigned int pgtable_size = nr_pgtable(h) << PAGE_SHIFT;
+
+		if (!pgtable_size)
+			continue;
+
+		m->vmemmap_pgtable = memblock_alloc_try_nid(pgtable_size,
+				PAGE_SIZE, 0, MEMBLOCK_ALLOC_ACCESSIBLE,
+				NUMA_NO_NODE);
+		if (!m->vmemmap_pgtable) {
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
+	unsigned long pgtable = (unsigned long)m->vmemmap_pgtable;
+	unsigned int nr = nr_pgtable(h);
+
+	if (!nr)
+		return;
+
+	vmemmap_pgtable_init(page);
+
+	for (i = 0; i < nr; i++, pgtable += PAGE_SIZE)
+		vmemmap_pgtable_deposit(page, (pte_t *)pgtable);
+}
+
 static void __init hugetlb_vmemmap_init(struct hstate *h)
 {
 	unsigned int order = huge_page_order(h);
@@ -1819,6 +1861,16 @@ static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
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
@@ -3080,6 +3132,7 @@ static void __init gather_bootmem_prealloc(void)
 		WARN_ON(page_count(page) != 1);
 		prep_compound_huge_page(page, h->order);
 		WARN_ON(PageReserved(page));
+		gather_vmemmap_pgtable_init(m, page);
 		prep_new_huge_page(h, page, page_to_nid(page));
 		put_page(page); /* free it into the hugepage allocator */
 
@@ -3132,6 +3185,10 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
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
2.20.1

