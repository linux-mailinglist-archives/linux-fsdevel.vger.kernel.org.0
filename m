Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD52D5245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 04:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbgLJD7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 22:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732085AbgLJD7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:59:15 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7719BC0617B0
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 19:58:58 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e2so2967224pgi.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 19:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ho9Zg9QvjUq1JHHKHy6yyTf6b+naQpST0bQGW9vI8oA=;
        b=vKyk+eGuLRrZAzAIGDjVZmPrcpfeWeX7FBJ7tFH+4cRjC0xZ9tpGL8kgM8vzA67QYO
         6F9thdtjMq2JalT1cAcUnd7xuf2k/lMmwv32iQTEm8xfrxTwUympfOZBU7A9l8S380N+
         o5iZU869KXuFjnQ3G5DP280+e1BDpQZt8q81GF3FeOe3Fsc4IzDfg16UU1TyF4LFNoyV
         Uo3kHnV5hZ43lMtWYDg0pLLsCWhkVhENwQTm+Cej+xKY94jD4ywjBe+9C1YVoZ/MUR5F
         joRzBaNsRBASLa4wOtCsqu+boPJZSMxCzPFTALyPesq4MIQ7L1Z+uzp1NQUEdyZV4ERL
         QZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ho9Zg9QvjUq1JHHKHy6yyTf6b+naQpST0bQGW9vI8oA=;
        b=SiCDui+kIjgH1ln3cKFDSucg/kkC4F+gYavl/9t9DTM6ftjtHE5NmL51i+EePIVSgl
         Mc7xnqmzyB3Etcb5C0uQKbAn0gz+6kS4H4CFZjkIIVfJPAO+SCkaJeospzd2E6QVthfJ
         E8cvQFl3L4swXOe+Ua8WVsV1nEpTM0T/ok3fmE/8faZVHTZZ/Gj+Ak0Tr8/M1n7d7tRS
         EmpQFyy2OU6VsfMKfUGDT1GTOISmK9ZVMwt/wPjT93+m3koGBKcYbE1O5tXLGr4mm/zo
         +O6zVu3oSgg1RmBGQxE77f+3TykD1xStC6ErgfFAoZe1Ue4NM1n3DF/qOe+h0quGmccD
         4LoQ==
X-Gm-Message-State: AOAM531dXLy6RxFLsl+9dtMZ6d8/brfRhU5hJAIeriy3wuMUQ0g01OCs
        I0syA5CLo+ursw3JDo2jKt2smw==
X-Google-Smtp-Source: ABdhPJxpfiFa0EKN8j4Mfp+vsc5ziMNvAoHXlIU4XGCiGAbRU8uCHCpDync0hgrd5ouM0bia8Kzw4g==
X-Received: by 2002:a63:4c5d:: with SMTP id m29mr4991015pgl.368.1607572738074;
        Wed, 09 Dec 2020 19:58:58 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.85])
        by smtp.gmail.com with ESMTPSA id f33sm4266535pgl.83.2020.12.09.19.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:58:57 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v8 09/12] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
Date:   Thu, 10 Dec 2020 11:55:23 +0800
Message-Id: <20201210035526.38938-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201210035526.38938-1-songmuchun@bytedance.com>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
freeing unused vmemmap pages associated with each hugetlb page on boot.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
 arch/x86/mm/init_64.c                           |  8 ++++++--
 include/linux/hugetlb.h                         | 19 +++++++++++++++++++
 mm/hugetlb_vmemmap.c                            | 16 ++++++++++++++++
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3ae25630a223..9e6854f21d55 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1551,6 +1551,15 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugetlb_free_vmemmap=
+			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
+			this controls freeing unused vmemmap pages associated
+			with each HugeTLB page.
+			Format: { on | off (default) }
+
+			on:  enable the feature
+			off: disable the feature
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: 0 | 1
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index f7b1c7462991..6a8b57f6d3b7 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -145,6 +145,9 @@ default_hugepagesz
 
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
+hugetlb_free_vmemmap
+	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
+	unused vmemmap pages associated each HugeTLB page.
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0435bee2e172..fcdc020904a8 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -34,6 +34,7 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/bootmem_info.h>
+#include <linux/hugetlb.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1557,7 +1558,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
-	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
+	if (is_hugetlb_free_vmemmap_enabled())
+		err = vmemmap_populate_basepages(start, end, node, NULL);
+	else if (end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
 	else if (boot_cpu_has(X86_FEATURE_PSE))
 		err = vmemmap_populate_hugepages(start, end, node, altmap);
@@ -1610,7 +1613,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		}
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
-		if (!boot_cpu_has(X86_FEATURE_PSE)) {
+		if (!boot_cpu_has(X86_FEATURE_PSE) ||
+		    is_hugetlb_free_vmemmap_enabled()) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
 			pmd = pmd_offset(pud, addr);
 			if (pmd_none(*pmd))
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..7f47f0eeca3b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -770,6 +770,20 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+extern bool hugetlb_free_vmemmap_enabled;
+
+static inline bool is_hugetlb_free_vmemmap_enabled(void)
+{
+	return hugetlb_free_vmemmap_enabled;
+}
+#else
+static inline bool is_hugetlb_free_vmemmap_enabled(void)
+{
+	return false;
+}
+#endif
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -923,6 +937,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
 }
+
+static inline bool is_hugetlb_free_vmemmap_enabled(void)
+{
+	return false;
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4587a0062808..f0926b382338 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -204,6 +204,22 @@ typedef void (*vmemmap_remap_pte_func_t)(struct page *reuse, pte_t *pte,
 					 unsigned long start, unsigned long end,
 					 void *priv);
 
+bool hugetlb_free_vmemmap_enabled;
+
+static int __init early_hugetlb_free_vmemmap_param(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	/* We cannot optimize if a "struct page" crosses page boundaries. */
+	if (!strcmp(buf, "on"))
+		hugetlb_free_vmemmap_enabled = true;
+	else if (strcmp(buf, "off"))
+		return -EINVAL;
+
+	return 0;
+}
+early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
 
 static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
 {
-- 
2.11.0

