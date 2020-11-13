Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBF2B198F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgKMLFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 06:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgKMLDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:03:38 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEEFC061A53
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:03:01 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f38so6830171pgm.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hlk7aVv3IqJJByqDA178uIBNh5+nIvTl7+bGApMXbLg=;
        b=A25SWB3K4oQ5j6N7N3wG52EulpSl7eeETmRdl+oeRg8MWFXbginsuTEmzlcJaReKCl
         xSCANPJ9pyQdc2vmBngtteY0TcEFjSQVTca1fr0dSIN020tiuDONowJ0mxbGSKAkEchi
         02Qv+QBkVPwr0xl5LEwKAdf1tFa6WRNQ8+H62XDCdytWmsnZDgFpKOY8D0VJ9+/bVPd6
         /ernKziU9EP6mwnBZ6cbKRczbhncU77f5sUubUrQOEucEdhInvkbm7TaPjO/eZSQjgQo
         RGC0izznVN0ivukoMRvsWxTCcrLptfZbhOSoAqyLqxV9iJKR6/tWoPdKOnwyP9exlN75
         3wUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hlk7aVv3IqJJByqDA178uIBNh5+nIvTl7+bGApMXbLg=;
        b=LZ6yGWxT6pSISMVNWZ6Xn7sub7ZphvbPSyZ+Si2kdyvdkaGw1ZowEwsZ/99uOhIT6R
         Yh4g0xun7Qb7VDX+FWslNkcr1g30oDrSCFXHjFDo6DixNMPASkA5/8+za03nFmg2Fu6Q
         jCs4fb1zqAT4gpI20PZ3vRqAKjWeuV7KZaCD+pw8fi0d3oQU6Tuub6QtA4GvA9WVA/TZ
         +MTaD1aHMKPyAHK6fsOidzJypl9GrtAelhO27CyeOO65QVimXvIy4R9jJzXooZPionOb
         q5qKIlW9xmeI+bmksUfpA0E5c5BgB287enkWBoIfxorOJMgDkywiUgTfcuFBjqkVe3f8
         bEqQ==
X-Gm-Message-State: AOAM533EkWY80RxOXqnbcSa+631I/Vaq2zSsKAOHMfQcL3eSfAXqa66k
        AD7wD6nPnmzVKqOBDGdNt7dHUg==
X-Google-Smtp-Source: ABdhPJxWFjUKKO5zEewfas6kEkbcVL3DLFn6RolpO74n5YA9HNm/WK9m82qwu/Od8O9RjaITfVus1A==
X-Received: by 2002:a17:90a:4dc3:: with SMTP id r3mr2359489pjl.155.1605265381285;
        Fri, 13 Nov 2020 03:03:01 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:03:00 -0800 (PST)
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
Subject: [PATCH v4 11/21] mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb page
Date:   Fri, 13 Nov 2020 18:59:42 +0800
Message-Id: <20201113105952.11638-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we free a hugetlb page to the buddy, we should allocate the vmemmap
pages associated with it. We can do that in the __free_hugepage().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         |   2 ++
 mm/hugetlb_vmemmap.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h |   5 +++
 3 files changed, 107 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4aabf12aca9b..ba927ae7f9bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1382,6 +1382,8 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 {
 	int i;
 
+	alloc_huge_page_vmemmap(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index e6fca02b57b2..9918dc63c062 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -89,6 +89,8 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 #define TAIL_PAGE_REUSE			-1
+#define GFP_VMEMMAP_PAGE		\
+	(GFP_KERNEL | __GFP_NOFAIL | __GFP_MEMALLOC)
 
 #ifndef VMEMMAP_HPAGE_SHIFT
 #define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
@@ -219,6 +221,104 @@ static inline int freed_vmemmap_hpage_dec(struct page *page)
 	return atomic_dec_return_relaxed(&page->_mapcount) + 1;
 }
 
+static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
+					  unsigned long start,
+					  unsigned long end,
+					  struct list_head *remap_pages)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
+	void *from = page_to_virt(reuse);
+	unsigned long addr;
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
+		entry = mk_pte(page, pgprot);
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
+	unsigned long start = addr + RESERVE_VMEMMAP_SIZE;
+	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
+	struct page *reuse = NULL;
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
+		__remap_huge_page_pte_vmemmap(reuse, ptep, addr, next,
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
+	for (i = 0; i < free_vmemmap_pages_per_hpage(h); i++) {
+		struct page *page;
+
+		/* This should not fail */
+		page = alloc_page(GFP_VMEMMAP_PAGE);
+		list_add_tail(&page->lru, list);
+	}
+}
+
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	pmd_t *pmd;
+	spinlock_t *ptl;
+	LIST_HEAD(remap_pages);
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	alloc_vmemmap_pages(h, &remap_pages);
+
+	pmd = vmemmap_to_pmd((unsigned long)head);
+	BUG_ON(!pmd);
+
+	ptl = vmemmap_pmd_lock(pmd);
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
 static inline void free_vmemmap_page_list(struct list_head *list)
 {
 	struct page *page, *next;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index a23fb1375859..a5054f310528 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -15,6 +15,7 @@
 void __init hugetlb_vmemmap_init(struct hstate *h);
 int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page);
 void vmemmap_pgtable_free(struct page *page);
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
@@ -35,6 +36,10 @@ static inline void vmemmap_pgtable_free(struct page *page)
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

