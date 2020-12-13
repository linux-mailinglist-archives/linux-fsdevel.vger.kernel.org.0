Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446EA2D8E5C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 16:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437261AbgLMPs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 10:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437277AbgLMPsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:48:24 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BBEC0617A6
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:44 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 11so10433756pfu.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jOWKhnPQ+qrTNz0SqXogpNl+v7yCmMPDPD5D2VmKboE=;
        b=THyq/mtn+bzbLFokRHWPa1f2o2xqQZeczJ/U+QdkvOAq8gB8PBn4kFsffFl3P2UkPW
         TeSe8pQn6E8b91J6f2P5/xMSQlMwZ86a8SIDJkKex8JwmFWqRKk9DQchk7/753x7RPwq
         LIPgXj69AYrX+c/SsFUNoDAYlruEYeiZheVUr3dzZGX3VdhSnpKTGIGdSJYM+6/bO3Jf
         ErAOC0nruxKXi/Zos98v/qWNvDBPbe5XjLHdBmA98JBnDEdCTiZBweWcetbSvg7e4gKQ
         OMKf2sGkxjUACChWwQIkkgeo6+PEoSf+qfisbfAl5Xq1X2cnOwQOTabiJ7znvE74ttjD
         qoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jOWKhnPQ+qrTNz0SqXogpNl+v7yCmMPDPD5D2VmKboE=;
        b=I9B0qRQYdAo6p7S2gKwmvJnX+cub6wGnpLu9izCvmhvYpxbpXegK2dz85Hvg/aZeZ5
         Fxg8HM1tND7P1/Hr0WI948bYJ7XxJM/KnnQHaEp+Kc6cC3Y8VbR3bUhGIh4GDB0nnMsR
         dgFX26vxyZ+xYmzTnaGVF38ejBWs6l11AtB/CMddALCvqq6Jxk3bPHGm0hD+huexlotN
         sw2jGliShpKzZMltKwuk+C/+qYS/ryok95AN2zPdAoaBXn+yGaq7ehknaxHhoszylvPv
         laPnNu0OZbttdFi95LYO6jY7FTNNmSkF6+QKwg4x6pnKNgEhlis/CtIBd8/OozXUxVJG
         syTQ==
X-Gm-Message-State: AOAM531cA05e/p71n2mufUJ9wk24NgJnmpcZoaJr6Emgp2yiJ4BRZciN
        ot5GpQqNugGFPwnJV3YZZLpTdg==
X-Google-Smtp-Source: ABdhPJwecuU0NsgiWUQQAQ7ypbXC+vvtzXl2omUhQe6yFTXFbUpfQaCfb4T//jUJ3a0R4Yj9SjuDzA==
X-Received: by 2002:a63:805:: with SMTP id 5mr20405179pgi.160.1607874464156;
        Sun, 13 Dec 2020 07:47:44 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id e24sm13113753pjt.16.2020.12.13.07.47.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2020 07:47:43 -0800 (PST)
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
Subject: [PATCH v9 08/11] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
Date:   Sun, 13 Dec 2020 23:45:31 +0800
Message-Id: <20201213154534.54826-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201213154534.54826-1-songmuchun@bytedance.com>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
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
index f7b1c7462991..3a23c2377acc 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -145,6 +145,9 @@ default_hugepagesz
 
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
+hugetlb_free_vmemmap
+	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
+	unused vmemmap pages associated with each HugeTLB page.
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0435bee2e172..1bce5f20e6ca 100644
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
+	if (is_hugetlb_free_vmemmap_enabled() ||
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
index 02201c2e3dfa..64ad929cac61 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -180,6 +180,22 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
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
+
 static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
 {
 	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
-- 
2.11.0

