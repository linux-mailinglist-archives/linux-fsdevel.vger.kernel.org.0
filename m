Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED20029902B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782651AbgJZOzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:55:10 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50967 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782647AbgJZOzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:55:07 -0400
Received: by mail-pj1-f67.google.com with SMTP id p21so3378651pju.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78xBg2WQCdWNruCWqKGQQsJIrYM1oGRx7tRHfiiJXdU=;
        b=JPX/rAC3IF6SKYvKDugHvIsCP8mDgq0zMSJnz5AUn9TDccBnPZFBTTNVW19xJK8PQ3
         tlVk5jFoLW/gh8CaaLoJO9uJ/Mnl14McW/wMP8MU7r0LeBbJV4DRCZYE4o/h+VC8hAyc
         KkfSsvj4ce+LbKGniw4RqRkGoG5KUyRX+PbAFM12uFtS41ti+6zq3eKGPVthrdK+Lan0
         amcr6IRMrKPMMmmYsDHfSDIK4gCZ0u1LkVkLoZBTc9kHaPEtohVsiaq2WWOZImlDMjYP
         aVRruxY7rMZ6D+a33oOg4qNcP5BBhIlkTnQ5b3pacXRyVY7XfQKP1w4ls10xQoktF2NT
         0wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78xBg2WQCdWNruCWqKGQQsJIrYM1oGRx7tRHfiiJXdU=;
        b=FLfFdxw1sptuNGJmOUpnd+UcIjt/KR17gcBCDAj8UbFmNMYXr7kiYDwlJmXgBku/la
         fmTCrDvcomo1+NzpD5hoTUmnkiV60omFM9FlxST9VJVa8gTwU+G6Arjli8SRSaf/nZXh
         JO24ClPb2h35iKPBJ/tyAoU73kmIP+UFmTcmEm/TDUY9Vm37b0l93YFURkcl+cliFCTx
         EcPCpdb4NqJWF9vCDbPHHSCp2JKuWfejTg9+tqgbWdz6yl2zbmWHLwDOPl8OZrNeXEvJ
         Zjf8ryYNckI+d5LE6VcYKEyyg+dt4bV5sMrwVmu3jeUZoozUviaWfFd34/rkuiPnKSWn
         dCNQ==
X-Gm-Message-State: AOAM530VXCXi9VfDM6SeeCT3EXUlBTV+9ZsYnss/1gEshELp0jcj+PbG
        BRJYSNuyzG99DSG/dL9JD4RhlQ==
X-Google-Smtp-Source: ABdhPJyk16ToaVS77jraO6/oXaFjUrRguY4X1F5jVMSbJnR3yqUDKHckul5kXm7Xbd7MSxOXEjmiKw==
X-Received: by 2002:a17:90a:6683:: with SMTP id m3mr21108784pjj.225.1603724105538;
        Mon, 26 Oct 2020 07:55:05 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.54.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:55:04 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 12/19] mm/hugetlb: Support freeing vmemmap pages of gigantic page
Date:   Mon, 26 Oct 2020 22:51:07 +0800
Message-Id: <20201026145114.59424-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c            | 57 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 919f47d77117..695d3041ae7d 100644
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
index f75b93fb4c07..d98b55ad1a90 100644
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
@@ -1778,6 +1820,16 @@ static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
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
@@ -3039,6 +3091,7 @@ static void __init gather_bootmem_prealloc(void)
 		WARN_ON(page_count(page) != 1);
 		prep_compound_huge_page(page, h->order);
 		WARN_ON(PageReserved(page));
+		gather_vmemmap_pgtable_init(m, page);
 		prep_new_huge_page(h, page, page_to_nid(page));
 		put_page(page); /* free it into the hugepage allocator */
 
@@ -3091,6 +3144,10 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
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

