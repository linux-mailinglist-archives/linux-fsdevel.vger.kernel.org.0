Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B742C87C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgK3PWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgK3PWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:22:14 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111DAC061A4D
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:34 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so10579374pfq.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uAWDXQwYXr/1aCA31hwWf+QRlR0Z8Bp/qA0gUfIqaP4=;
        b=aV7GysItfxBitRlELh0Lv6jlkvz57vYMuIN54sZdeGB+hbArj3GEKOin4tCaSXHhz3
         ZYzkH+LchdPCjGMAClXf5LMgJjC5/lWBMsMItuc1b3fxflD0F7n5qQYReoSxlTBAYV22
         W2X64PM179gbzbDNpHYffMAg6ZPhH9RSvOx4Q6jtyMiboAW1smgcT8mCwzTDySCnYkFE
         Indp/cbmDPnyovt+fkf3oSGfQLfmmbEC7OkpvFrFtv0YEJYvFh1dXkMJt/2jGXUMRnEz
         ZtiilbWWvKd6+UghNSEoPP6V4RHdWFoPRGfW6JNSlb0CDWttf8xcQFNwyT1c7DMVIYOC
         tNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uAWDXQwYXr/1aCA31hwWf+QRlR0Z8Bp/qA0gUfIqaP4=;
        b=cEb4flvdcNLRBcz3H/9LLtej4ObneXKFMABSqnn5ShLtF0Xmtc9JGaEAzDuPCnJjDy
         q0iH0WCWQUei8+ggfpr3HP0aeksjkhfsgOYLd/yynAesKmGLWf/09mwXs/XnoZt/EA7D
         Dfh/Dy/eUzRuljuXoCUvgOD9Isum4NDCIucZmLr6wWG7jzziqutysCdh4eNzv2IL7ibk
         Of3kHHovD24x0Dhh1Msald53m+2YG5now4JYZYPZcBJ0L0VOyd4fMZ8oW9iNqndKLTKa
         0Uho4m9+vQqyJv2oHsUEuTNuEi9Pi5FuFTujGqZZcDWyoaZCHP3Zzn9aZPMVaxxtQRZV
         ohEA==
X-Gm-Message-State: AOAM532Uq0/THyuIzsLWEVALvPLzwzcHmlcIZbzMZXLz1jLNCE3wdaEG
        CAcRphZuIl9EfiV5fsXvUnsPrA==
X-Google-Smtp-Source: ABdhPJwQwgDdrGtTg81N8+Pbm6MVRhMRIZHdAUtrWtOgFwn1gHuBWRWacRqFs0rUPnywFmQnuBN0tQ==
X-Received: by 2002:a62:5b05:0:b029:197:fafb:50f3 with SMTP id p5-20020a625b050000b0290197fafb50f3mr19221940pfb.76.1606749693584;
        Mon, 30 Nov 2020 07:21:33 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.21.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:21:33 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 13/15] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
Date:   Mon, 30 Nov 2020 23:18:36 +0800
Message-Id: <20201130151838.11208-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
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
 arch/x86/mm/init_64.c                           |  5 +++--
 include/linux/hugetlb.h                         | 19 +++++++++++++++++++
 mm/hugetlb_vmemmap.c                            | 18 +++++++++++++++++-
 5 files changed, 51 insertions(+), 3 deletions(-)

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
index 155cb06a6961..fcdc020904a8 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -34,6 +34,7 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/bootmem_info.h>
+#include <linux/hugetlb.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1557,7 +1558,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
-	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP))
+	if (is_hugetlb_free_vmemmap_enabled())
 		err = vmemmap_populate_basepages(start, end, node, NULL);
 	else if (end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
@@ -1613,7 +1614,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
 		if (!boot_cpu_has(X86_FEATURE_PSE) ||
-		    IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)) {
+		    is_hugetlb_free_vmemmap_enabled()) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
 			pmd = pmd_offset(pud, addr);
 			if (pmd_none(*pmd))
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4efeccb7192c..66d82ae7b712 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -773,6 +773,20 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
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
 
@@ -926,6 +940,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
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
index a3714db7f400..ebc710d148e4 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -131,6 +131,21 @@ typedef void (*vmemmap_remap_pte_func_t)(struct page *reuse, pte_t *pte,
 					 unsigned long start, unsigned long end,
 					 void *priv);
 
+bool hugetlb_free_vmemmap_enabled;
+
+static int __init early_hugetlb_free_vmemmap_param(char *buf)
+{
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
 
 static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
 {
@@ -325,7 +340,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int nr_pages = pages_per_huge_page(h);
 	unsigned int vmemmap_pages;
 
-	if (!is_power_of_2(sizeof(struct page))) {
+	if (!is_power_of_2(sizeof(struct page)) ||
+	    !hugetlb_free_vmemmap_enabled) {
 		pr_info("disable freeing vmemmap pages for %s\n", h->name);
 		return;
 	}
-- 
2.11.0

