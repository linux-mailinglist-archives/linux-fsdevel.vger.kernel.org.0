Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6168032506C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 14:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhBYN1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 08:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhBYNZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:25:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2A7C061786
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 05:24:41 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u11so3166953plg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 05:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFQuqnVUoKnfyFr+9fo2kIEjjKQK0Vr5nrxBfWxS6AY=;
        b=PELL53dNEzEYffRw1w8Y0IkLxZgmNWXhAq+stau/ClqnTGWz5IzvNdQ8q2/CTwlLDX
         lHuG46gQ3UPstpYf4/TeztziUUZQP+UVfvCVVLZYicx7zzW95Zl5/cNkLmivs8UYP82D
         nM6WbrLd6wto2IJRTlbqhKXFfQX/TdnGU3wVZ/2ZjXcmSvajY2I5ESt4FznQVxqRc+NA
         dR//5tphB0iASPzAK8fD22jTF16LKav8dlW1eX/fGW/t9El39BYlBX23Ar8zgUBiigu+
         WLnRD3SvQC7O1tGhYh7dDvN+t24LwVARtTjL7heBdQrCFSAHUz+KRQYSpXw3pEYn/PsF
         EWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFQuqnVUoKnfyFr+9fo2kIEjjKQK0Vr5nrxBfWxS6AY=;
        b=g0F/bkIV4OSZ5ivmsh87ufI7en183euWr1MQMfih5dXz2UrLctVgUUgskB8Us+cydJ
         RqhBHKb4x6wtlCiDkw1/UCRgzc5G7gH+YH4gN6qqlVVBT21Vm1sOQeezWiRX487h84iY
         v86ihjeA88Vyoc9hT++8hR11XzohAaJhF7a7iGfu7Ub73JnI6/2ocOICxAN8zIFMcC5N
         Ly7hBg8pPxKlfc5Plv2VtoQiD0aPTJSMSSahG3CfWpaX18AVhYzhFCmcQ7klsh4UA/Y5
         3McgP/ezRqVKV8F54XYYsY3L77hzzsZ0CEuHdEzsGXDjvB6VGZdVYlOopahpMNb6rf58
         Dewg==
X-Gm-Message-State: AOAM532kANp09GnW/NAR2+ji4n7RsvQ4ea6Px8vnYfcUHOU4C4rJzSsN
        TbyZUX+KAjPENiNO840UqOc1MA==
X-Google-Smtp-Source: ABdhPJyv/I54FmjiTdLgK3npJmPPDrB2KuXLhLJs2ESgBQLP+0tO0uEj5Ci7bPhDqiViev7pjqvNhQ==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr3243191pjb.62.1614259480742;
        Thu, 25 Feb 2021 05:24:40 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id x190sm6424676pfx.166.2021.02.25.05.24.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 05:24:40 -0800 (PST)
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
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v17 6/9] mm: hugetlb: add a kernel parameter hugetlb_free_vmemmap
Date:   Thu, 25 Feb 2021 21:21:27 +0800
Message-Id: <20210225132130.26451-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210225132130.26451-1-songmuchun@bytedance.com>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a kernel parameter hugetlb_free_vmemmap to enable the feature of
freeing unused vmemmap pages associated with each hugetlb page on boot.

We disables PMD mapping of vmemmap pages for x86-64 arch when this
feature is enabled. Because vmemmap_remap_free() depends on vmemmap
being base page mapped.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
 Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
 arch/x86/mm/init_64.c                           |  8 ++++++--
 include/linux/hugetlb.h                         | 19 +++++++++++++++++++
 mm/hugetlb_vmemmap.c                            | 24 ++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..de91d54573c4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1557,6 +1557,20 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugetlb_free_vmemmap=
+			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
+			this controls freeing unused vmemmap pages associated
+			with each HugeTLB page. When this option is enabled,
+			we disable PMD/huge page mapping of vmemmap pages which
+			increase page table pages. So if a user/sysadmin only
+			uses a small number of HugeTLB pages (as a percentage
+			of system memory), they could end up using more memory
+			with hugetlb_free_vmemmap on as opposed to off.
+			Format: { on | off (default) }
+
+			on:  enable the feature
+			off: disable the feature
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: 0 | 1
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 6988895d09a8..8abaeb144e44 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -153,6 +153,9 @@ default_hugepagesz
 
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
+hugetlb_free_vmemmap
+	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
+	unused vmemmap pages associated with each HugeTLB page.
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0435bee2e172..39f88c5faadc 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -34,6 +34,7 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/bootmem_info.h>
+#include <linux/hugetlb.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1557,7 +1558,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
-	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
+	if ((is_hugetlb_free_vmemmap_enabled()  && !altmap) ||
+	    end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
 	else if (boot_cpu_has(X86_FEATURE_PSE))
 		err = vmemmap_populate_hugepages(start, end, node, altmap);
@@ -1585,6 +1587,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 	pmd_t *pmd;
 	unsigned int nr_pmd_pages;
 	struct page *page;
+	bool base_mapping = !boot_cpu_has(X86_FEATURE_PSE) ||
+			    is_hugetlb_free_vmemmap_enabled();
 
 	for (; addr < end; addr = next) {
 		pte_t *pte = NULL;
@@ -1610,7 +1614,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		}
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
-		if (!boot_cpu_has(X86_FEATURE_PSE)) {
+		if (base_mapping) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
 			pmd = pmd_offset(pud, addr);
 			if (pmd_none(*pmd))
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ce6533584eb7..78934e9aeab6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -852,6 +852,20 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
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
 
@@ -1005,6 +1019,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
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
index f7ab3d99250a..7807ed6678e0 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -169,6 +169,8 @@
  * (last) level. So this type of HugeTLB page can be optimized only when its
  * size of the struct page structs is greater than 2 pages.
  */
+#define pr_fmt(fmt)	"HugeTLB: " fmt
+
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -181,6 +183,28 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
+bool hugetlb_free_vmemmap_enabled;
+
+static int __init early_hugetlb_free_vmemmap_param(char *buf)
+{
+	/* We cannot optimize if a "struct page" crosses page boundaries. */
+	if ((!is_power_of_2(sizeof(struct page)))) {
+		pr_warn("cannot free vmemmap pages because \"struct page\" crosses page boundaries\n");
+		return 0;
+	}
+
+	if (!buf)
+		return -EINVAL;
+
+	if (!strcmp(buf, "on"))
+		hugetlb_free_vmemmap_enabled = true;
+	else if (strcmp(buf, "off"))
+		return -EINVAL;
+
+	return 0;
+}
+early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
+
 static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
 {
 	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
-- 
2.11.0

