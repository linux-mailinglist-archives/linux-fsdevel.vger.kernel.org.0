Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC15C287009
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgJHHyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgJHHyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E574C0613D2;
        Thu,  8 Oct 2020 00:54:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y20so2350798pll.12;
        Thu, 08 Oct 2020 00:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RcgMyRpYCMFPKKfeQGBLX4f9whd1oMvUnXei2mI75rM=;
        b=l8Ra7EksFBkM7aXJFPrA2eB3Xq6pYyiOaYXhMElfS3EIROnXctXddcVbTpovgAd9GT
         JXVolSyYuXt7B85Zx26ehB6xnboOlS+fMVLj3sz+vnFdiTJcz896cYCldVaJVNWQ7X1M
         NC/53HhkjRP00ZeAw3CNfU6HUxuemiqjcLxXynmIa8HNsMgaOaSGxCgNYGNmxluT1P/q
         sz3olzOcFf0tTibaHXgbGIxy3qYF/5fKbGiuIz3TSyLdNlh1eDCXgf1kqGYm5LezKRFE
         VeZ3haQMKU1mxBsxZCJvqoNVa75YuSXMi5uZTDU1+NF7mAr6WMvjG5zZvX5mAQOlndw4
         5uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RcgMyRpYCMFPKKfeQGBLX4f9whd1oMvUnXei2mI75rM=;
        b=g9kMlp04OfUER+TGVyCzwHjg6iyEDSBhY0jZcC4Y+CrDTjlBm45fJJ3kgX3tilnAlI
         BpUYfgkNuI1O8DaFAfNvsEy6CjL572AgbgziB3SzQPLgYgrnU0VMgk8OJctY0pj1Jfi8
         FVXyEbhtPNnS+yi8nWm2++CGN1Vx5HcUwt1mi5FjozoKrtUfKfHuG9aRB0EN/pa5N1AJ
         kb8gley00OUWdf7NJO7LZnhBiuN1yPcvlgI7aL09b/D7hQm7JBWrXNYuXIKTwGLv9ohB
         JVjCYP07v2mGoYR5wKkGhcEmtwxLmZx7/mRRC9PMURTDvYMSlX04HhnJVWKjeVRgiiy/
         w4zw==
X-Gm-Message-State: AOAM530mYhdtSm1D/F3srPcj16f2EjIAQwZ/mKx+Nc1t9B36aNiD4juC
        wAerGJEOmg2ATXHCmqQiS74=
X-Google-Smtp-Source: ABdhPJywCdHXkBPuQ18NYaJDK8Gmg6c0dxeop4xWSXCznUS07DUepLINsWQt1Z3SQMFam5b8lu+S5w==
X-Received: by 2002:a17:902:d888:b029:d0:cb2d:f274 with SMTP id b8-20020a170902d888b02900d0cb2df274mr6276533plz.13.1602143679895;
        Thu, 08 Oct 2020 00:54:39 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:54:39 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Haiwei Li <gerryhwli@tencent.com>
Subject: [PATCH 12/35] dmem: introduce mempolicy support
Date:   Thu,  8 Oct 2020 15:54:02 +0800
Message-Id: <1fce243b3bcd347c951a0991a6daf0645d441e4d.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

It adds mempolicy support for dmem to allocates memory
from mempolicy specified nodes.

Signed-off-by: Haiwei Li   <gerryhwli@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/pgtable.h       |  7 ++++
 arch/x86/include/asm/pgtable_types.h | 13 +++++-
 fs/dmemfs/Kconfig                    |  3 ++
 include/linux/pgtable.h              |  7 ++++
 mm/Kconfig                           |  3 ++
 mm/dmem.c                            | 63 +++++++++++++++++++++++++++-
 7 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..86f3139edfc7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -73,6 +73,7 @@ config X86
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
+	select ARCH_HAS_PTE_DMEM		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_UACCESS_MCSAFE		if X86_64 && X86_MCE
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b836138ce852..ea4554a728bc 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -453,6 +453,13 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_DEVMAP);
 }
 
+#ifdef CONFIG_ARCH_HAS_PTE_DMEM
+static inline pmd_t pmd_mkdmem(pmd_t pmd)
+{
+	return pmd_set_flags(pmd, _PAGE_SPECIAL | _PAGE_DMEM);
+}
+#endif
+
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_PSE);
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 816b31c68550..ee4cae110f5c 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -23,6 +23,15 @@
 #define _PAGE_BIT_SOFTW2	10	/* " */
 #define _PAGE_BIT_SOFTW3	11	/* " */
 #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
+#define _PAGE_BIT_DMEM		57	/* Flag used to indicate dmem pmd.
+					 * Since _PAGE_BIT_SPECIAL is defined
+					 * same as _PAGE_BIT_CPA_TEST, we can
+					 * not only use _PAGE_BIT_SPECIAL, so
+					 * add _PAGE_BIT_DMEM to help
+					 * indicate it. Since dmem pte will
+					 * never be splitting, setting
+					 * _PAGE_BIT_SPECIAL for pte is enough.
+					 */
 #define _PAGE_BIT_SOFTW4	58	/* available for programmer */
 #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
 #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
@@ -112,9 +121,11 @@
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_NX	(_AT(pteval_t, 1) << _PAGE_BIT_NX)
 #define _PAGE_DEVMAP	(_AT(u64, 1) << _PAGE_BIT_DEVMAP)
+#define _PAGE_DMEM	(_AT(u64, 1) << _PAGE_BIT_DMEM)
 #else
 #define _PAGE_NX	(_AT(pteval_t, 0))
 #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
+#define _PAGE_DMEM	(_AT(pteval_t, 0))
 #endif
 
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
@@ -128,7 +139,7 @@
 #define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
 			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
 			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |  \
-			 _PAGE_UFFD_WP)
+			 _PAGE_UFFD_WP | _PAGE_DMEM)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
 
 /*
diff --git a/fs/dmemfs/Kconfig b/fs/dmemfs/Kconfig
index d2894a513de0..19ca3914da39 100644
--- a/fs/dmemfs/Kconfig
+++ b/fs/dmemfs/Kconfig
@@ -1,5 +1,8 @@
 config DMEM_FS
 	tristate "Direct Memory filesystem support"
+	depends on DMEM
+	depends on TRANSPARENT_HUGEPAGE
+	depends on ARCH_HAS_PTE_DMEM
 	help
 	  dmemfs (Direct Memory filesystem) is device memory or reserved
 	  memory based filesystem. This kind of memory is special as it
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8cbc2e795d5..45d4c4a3e519 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1129,6 +1129,13 @@ static inline int pud_trans_unstable(pud_t *pud)
 #endif
 }
 
+#ifndef CONFIG_ARCH_HAS_PTE_DMEM
+static inline pmd_t pmd_mkdmem(pmd_t pmd)
+{
+	return pmd;
+}
+#endif
+
 #ifndef pmd_read_atomic
 static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index 8a67c8933a42..09d1b1551a44 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -795,6 +795,9 @@ config IDLE_PAGE_TRACKING
 config ARCH_HAS_PTE_DEVMAP
 	bool
 
+config ARCH_HAS_PTE_DMEM
+	bool
+
 config ZONE_DEVICE
 	bool "Device memory (pmem, HMM, etc...) hotplug support"
 	depends on MEMORY_HOTPLUG
diff --git a/mm/dmem.c b/mm/dmem.c
index 6992e57d5df0..2e61dbddbc62 100644
--- a/mm/dmem.c
+++ b/mm/dmem.c
@@ -822,6 +822,56 @@ dmem_alloc_pages_nodemask(int nid, nodemask_t *nodemask, unsigned int try_max,
 }
 EXPORT_SYMBOL(dmem_alloc_pages_nodemask);
 
+/* Return a nodelist indicated for current node representing a mempolicy */
+static int *policy_nodelist(struct mempolicy *policy)
+{
+	int nd = numa_node_id();
+
+	switch (policy->mode) {
+	case MPOL_PREFERRED:
+		if (!(policy->flags & MPOL_F_LOCAL))
+			nd = policy->v.preferred_node;
+		break;
+	case MPOL_BIND:
+		if (unlikely(!node_isset(nd, policy->v.nodes)))
+			nd = first_node(policy->v.nodes);
+		break;
+	default:
+		WARN_ON(1);
+	}
+	return dmem_nodelist(nd);
+}
+
+static nodemask_t *dmem_policy_nodemask(struct mempolicy *policy)
+{
+	if (unlikely(policy->mode == MPOL_BIND) &&
+			cpuset_nodemask_valid_mems_allowed(&policy->v.nodes))
+		return &policy->v.nodes;
+
+	return NULL;
+}
+
+static void
+get_mempolicy_nlist_and_nmask(struct mempolicy *pol,
+			      struct vm_area_struct *vma, unsigned long addr,
+			      int **nl, nodemask_t **nmask)
+{
+	if (pol->mode == MPOL_INTERLEAVE) {
+		unsigned int nid;
+
+		/*
+		 * we use dpage_shift to interleave numa nodes although
+		 * multiple dpages may be allocated
+		 */
+		nid = interleave_nid(pol, vma, addr, dmem_pool.dpage_shift);
+		*nl = dmem_nodelist(nid);
+		*nmask = NULL;
+	} else {
+		*nl = policy_nodelist(pol);
+		*nmask = dmem_policy_nodemask(pol);
+	}
+}
+
 /*
  * dmem_alloc_pages_vma - Allocate pages for a VMA.
  *
@@ -830,6 +880,9 @@ EXPORT_SYMBOL(dmem_alloc_pages_nodemask);
  *   @try_max: try to allocate @try_max dpages if possible
  *   @result_nr: allocated dpage number returned to the caller
  *
+ * This function allocates pages from dmem pool and applies a NUMA policy
+ * associated with the VMA.
+ *
  * Return the physical address of the first dpage allocated from dmem
  * pool, or 0 on failure. The allocated dpage number is filled into
  * @result_nr
@@ -839,13 +892,19 @@ dmem_alloc_pages_vma(struct vm_area_struct *vma, unsigned long addr,
 		     unsigned int try_max, unsigned int *result_nr)
 {
 	phys_addr_t phys_addr;
+	struct mempolicy *pol;
 	int *nl;
+	nodemask_t *nmask;
 	unsigned int cpuset_mems_cookie;
 
 retry_cpuset:
-	nl = dmem_nodelist(numa_node_id());
+	pol = get_vma_policy(vma, addr);
+	cpuset_mems_cookie = read_mems_allowed_begin();
+
+	get_mempolicy_nlist_and_nmask(pol, vma, addr, &nl, &nmask);
+	mpol_cond_put(pol);
 
-	phys_addr = dmem_alloc_pages_from_nodelist(nl, NULL, try_max,
+	phys_addr = dmem_alloc_pages_from_nodelist(nl, nmask, try_max,
 						   result_nr);
 	if (unlikely(!phys_addr && read_mems_allowed_retry(cpuset_mems_cookie)))
 		goto retry_cpuset;
-- 
2.28.0

