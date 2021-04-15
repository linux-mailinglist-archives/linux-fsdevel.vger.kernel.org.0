Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9E3604AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 10:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhDOIoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 04:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhDOIoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:44:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E2C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 01:43:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t23so11700040pjy.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 01:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPbCvLLsrlHgBGPaJLHAbBrCHPjBJxppvtDHNdN9YHs=;
        b=J0B3onLFJdFbcJxwe+xZUL5B5n9Pw1gL+TZ7S2h8bjyKY4jT2SrMhZFG5sfvfRH5kV
         2fEomYqAa17BfkW2nYskClPcv01dLhOT/8VEUyn91nYpdyHmOzoKjHXqSzrxfJbnqR6K
         cJ9PI99rrduLc6JslUVoMNgDLrvxdA6Z8c2DdZXe1al8lkf2zF0DFOtU+N4ybXkreSHL
         I6HeE8Jky3R71lOB+yQ003L19gY3O4wjKxE4/o8/wM6WcsiTkSwyeGrIi+S5SRQtCVeX
         8p/OetTD87hBGyQaEkAE/wz3C1Tf+VJg4dUO9mUShrjVKEHCAe6+zzP4+jsnkgfqmwKt
         JHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPbCvLLsrlHgBGPaJLHAbBrCHPjBJxppvtDHNdN9YHs=;
        b=ipCAnV7x49+XOzdJ/ZVQXoU1J0tmKa3EsNmYMUgHrilgrtRDJMMmwMXHtXER0ZajM+
         kO1Cxd0R2vfsmP3ye9xmGihy5V+Z+9G9xeiK4qoVnb1Z16SrxCLY9avL/GkMQNVHZKWI
         YvWfrPjhL/P1HQPQPZGGnRcH9J3vZNBbP8k5R8rToFGhM7N7WFhrnP3+3i1WG7YFnNmz
         bf+G0hLEOSbEdUvmVDksj/EWrLNjUmFoSQLECrod9nQRzQ7+KWVeGYCf4dsWVGJO6pUq
         6mDPJcRXAIhSw7NCSTt7osLicyh1tue41a5pejRobrvJxn/ssV4oFZDKqUjacUMqd8qC
         +Ykg==
X-Gm-Message-State: AOAM532GMgi4gnDYEPtHBWwSt8a+8aGCCO9huv/yi2a9khxR+W5kNzB5
        6TXZxNYXHcXOKjICxdosmRREzw==
X-Google-Smtp-Source: ABdhPJw39Nqq95PLexiUDFEkQ/+Gn85dw7l440xmm5D8aSFIeNRmN2E7sOn9/AEATRdaZ7j9VteNrg==
X-Received: by 2002:a17:902:a9c7:b029:e8:de49:6a76 with SMTP id b7-20020a170902a9c7b02900e8de496a76mr2804257plr.63.1618476218713;
        Thu, 15 Apr 2021 01:43:38 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id e13sm1392365pgt.91.2021.04.15.01.43.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 01:43:38 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v20 7/9] mm: hugetlb: add a kernel parameter hugetlb_free_vmemmap
Date:   Thu, 15 Apr 2021 16:40:03 +0800
Message-Id: <20210415084005.25049-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210415084005.25049-1-songmuchun@bytedance.com>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
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
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++++++++
 Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
 arch/x86/mm/init_64.c                           |  8 ++++++--
 include/linux/hugetlb.h                         | 19 +++++++++++++++++++
 mm/hugetlb_vmemmap.c                            | 24 ++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3bf052d14504..9e655f5206ac 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1611,6 +1611,23 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugetlb_free_vmemmap=
+			[KNL] Reguires CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+			enabled.
+			Allows heavy hugetlb users to free up some more
+			memory (6 * PAGE_SIZE for each 2MB hugetlb page).
+			This feauture is not free though. Large page
+			tables are not used to back vmemmap pages which
+			can lead to a performance degradation for some
+			workloads. Also there will be memory allocation
+			required when hugetlb pages are freed from the
+			pool which can lead to corner cases under heavy
+			memory pressure.
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
index 65ea58527176..9d9d18d0c2a1 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -34,6 +34,7 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/bootmem_info.h>
+#include <linux/hugetlb.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1609,7 +1610,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
 	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
 
-	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
+	if ((is_hugetlb_free_vmemmap_enabled()  && !altmap) ||
+	    end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
 	else if (boot_cpu_has(X86_FEATURE_PSE))
 		err = vmemmap_populate_hugepages(start, end, node, altmap);
@@ -1637,6 +1639,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 	pmd_t *pmd;
 	unsigned int nr_pmd_pages;
 	struct page *page;
+	bool base_mapping = !boot_cpu_has(X86_FEATURE_PSE) ||
+			    is_hugetlb_free_vmemmap_enabled();
 
 	for (; addr < end; addr = next) {
 		pte_t *pte = NULL;
@@ -1662,7 +1666,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		}
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
-		if (!boot_cpu_has(X86_FEATURE_PSE)) {
+		if (base_mapping) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
 			pmd = pmd_offset(pud, addr);
 			if (pmd_none(*pmd))
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6e970a7d3480..4015cedacf91 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -894,6 +894,20 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
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
 
@@ -1047,6 +1061,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
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
index a897c7778246..3070e1465b1b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -168,6 +168,8 @@
  * (last) level. So this type of HugeTLB page can be optimized only when its
  * size of the struct page structs is greater than 2 pages.
  */
+#define pr_fmt(fmt)	"HugeTLB: " fmt
+
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -180,6 +182,28 @@
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

