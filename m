Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9359226A5D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIONDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgIONCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:02:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6736C061355
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so1674374pjd.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OOFE3ifzi+xdbou1BhqWX71JRgXgTkLEdNFFfTKs9Ws=;
        b=iM2XomGqOr6vav8SWts2kgwO4r/SIQ083A9ET2quErQScZx633RbxxWH96OcSipOCX
         etQ478kIKVl/JnnzUUXMu3YnhVVlfmFGIVtMHJq29YxXILuRzbyJ1uFWpeQceXlCD2jY
         2C8sffIHvnr9qXcW2LF2qZq5Pch7iEPoKVNf0iQN9oB65y8591n68j7Gx7P9aC+5oy5/
         0fARwEqyJb+m50XkT0C+gNc8xvY+Y6xGbV8aOdsEbsr459+QDdAm/301ctcQiofQjW0B
         CVN02/XUZPC62uuxxbvHTWp73+iVGDgOgq6+Ou7T5fY9BuvDRNA69A/2fWIPmUNlBxht
         6ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OOFE3ifzi+xdbou1BhqWX71JRgXgTkLEdNFFfTKs9Ws=;
        b=HHQtXayCPof+ZThPNPdvnNGYKrE2yG/4PmmNPC6Hkexa5gTyuqUBQ9TNd3JXM4cQzB
         qbRWHLJZQlhka6p2dO5/7McxGrmXmdxN0aR4qRwkGPoB5Plf6uebD4+7etViHPzjusIc
         2ZbwKYUaehotSDwpaZbQNZAYhRwgjRG1ljiSRQrYO9CcWeAZvPjtwyUDbo/wLQbBOm86
         yNwcP9vABJzLTg24XDZ3MvFvVk2W12Nh+MTatXyl7w09UfvFWAfpJYiv2hZ0erRZCgql
         dfLfYaLhp4yuSx+khZb/w/kBlQjRtBzbzTDSOMxr0LU5IK/MPadWNZa5CwchxATwUjar
         /9Cg==
X-Gm-Message-State: AOAM530gcUqBq1cOcJiEdjsLAq4GLu0li7g0Od3GCuGFFbhAMrhyr4yC
        a5nJIPfguQmt2LDi1EH4jo57oA==
X-Google-Smtp-Source: ABdhPJxUfGHzGSJNJof5A7RFUKJlSlo67Ou73YEyK8suZijN2KyyyGZq9MsiZY6eorIYIvYj8Hz5Qw==
X-Received: by 2002:a17:90a:d3c2:: with SMTP id d2mr4029408pjw.112.1600174934990;
        Tue, 15 Sep 2020 06:02:14 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:02:14 -0700 (PDT)
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
Subject: [RFC PATCH 13/24] mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb page
Date:   Tue, 15 Sep 2020 20:59:36 +0800
Message-Id: <20200915125947.26204-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we free a hugetlb page to the buddy, we should allocate the vmemmap
pages associated with it. We can do that in the __free_hugepage().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6b57a1183785..d0f09fe531fc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1299,6 +1299,7 @@ static void __free_hugepage(struct hstate *h, struct page *page);
 
 #define RESERVE_VMEMMAP_NR	2U
 #define RESERVE_VMEMMAP_SIZE	(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
+#define GFP_VMEMMAP_PAGE	(GFP_KERNEL | __GFP_NOFAIL | __GFP_MEMALLOC)
 
 #define page_huge_pte(page)	((page)->pmd_huge_pte)
 
@@ -1645,6 +1646,107 @@ static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	free_vmemmap_page_list(&free_pages);
 }
 
+static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
+					  unsigned long start,
+					  unsigned int nr_remap,
+					  struct list_head *remap_pages)
+{
+	void *from = (void *)page_private(reuse);
+	unsigned long addr, end = start + (nr_remap << PAGE_SHIFT);
+
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		void *to;
+		struct page *page;
+		pte_t entry, old = *ptep;
+
+		page = list_first_entry_or_null(remap_pages, struct page, lru);
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
+
+		entry = mk_pte(page, PAGE_KERNEL);
+		set_pte_at(&init_mm, addr, ptep++, entry);
+
+		VM_BUG_ON(!pte_present(old) || pte_page(old) != reuse);
+	}
+}
+
+static void __remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
+					  unsigned long addr,
+					  struct list_head *remap_pages)
+{
+	unsigned long next;
+	unsigned long start = addr + RESERVE_VMEMMAP_NR * PAGE_SIZE;
+	unsigned long end = addr + nr_vmemmap_size(h);
+	struct page *reuse = NULL;
+
+	addr = start;
+	do {
+		unsigned int nr_pages;
+		pte_t *ptep;
+
+		ptep = pte_offset_kernel(pmd, addr);
+		if (!reuse) {
+			reuse = pte_page(ptep[-1]);
+			set_page_private(reuse, addr - PAGE_SIZE);
+		}
+
+		next = vmemmap_hpage_addr_end(addr, end);
+		nr_pages = (next - addr) >> PAGE_SHIFT;
+		__remap_huge_page_pte_vmemmap(reuse, ptep, addr, nr_pages,
+					      remap_pages);
+	} while (pmd++, addr = next, addr != end);
+
+	flush_tlb_kernel_range(start, end);
+}
+
+static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
+{
+	int i;
+
+	for (i = 0; i < nr_free_vmemmap(h); i++) {
+		struct page *page;
+
+		/* This should not fail */
+		page = alloc_page(GFP_VMEMMAP_PAGE);
+		list_add_tail(&page->lru, list);
+	}
+}
+
+static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	pmd_t *pmd;
+	spinlock_t *ptl;
+	LIST_HEAD(remap_pages);
+
+	if (!nr_free_vmemmap(h))
+		return;
+
+	alloc_vmemmap_pages(h, &remap_pages);
+
+	pmd = vmemmap_to_pmd(head);
+	ptl = vmemmap_pmd_lockptr(pmd);
+
+	spin_lock(ptl);
+	__remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head,
+				      &remap_pages);
+	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd))) {
+		/*
+		 * Todo:
+		 * Merge pte to huge pmd if it has ever been split.
+		 */
+	}
+	spin_unlock(ptl);
+}
+
 /*
  * As update_and_free_page() is be called from a non-task context(and hold
  * hugetlb_lock), we can defer the actual freeing in a workqueue to prevent
@@ -1720,6 +1822,10 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
 
+static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
+
 static inline void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	__free_hugepage(h, page);
@@ -1752,6 +1858,8 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 {
 	int i;
 
+	alloc_huge_page_vmemmap(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
-- 
2.20.1

