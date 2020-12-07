Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4342D0F27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgLGLeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgLGLef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:35 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02578C0613D1;
        Mon,  7 Dec 2020 03:34:20 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o5so8645987pgm.10;
        Mon, 07 Dec 2020 03:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydAF98InOXvLOUHWcQbefHcTxGQjuTY7EYp8f1Ij7rU=;
        b=CbIO/lKMhlmMybymchHGdjYBFjooSqYR87ZMJNCpzamSy0rqGGupNjGohNmWYyuuVF
         +xqHe0wJyPOa8tX4wGwI9xsV0mLlIIhWZv7yi7zuh1i+ZjbHzI7SroHpaRk8tPLHv8j9
         TY3DoXxPGxxbJvXcTFLjLpG9ptLpcORhfr4m/KQm4y0U00zVK1J9SxRLVrdKucZO6fgt
         Iq53lTb5pWIqLsYf0RPyKOtYavEZdCQ2SpdfqSEQDGGfienBvS0lHPdVmAi0he3F9oSM
         2qO8yJB8UNJ6tM0GvVovraZIBAc/ZtLNNhUmoqFgjDcE70JCp5Sfe/0KBwOp0Vx9h2oD
         SRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydAF98InOXvLOUHWcQbefHcTxGQjuTY7EYp8f1Ij7rU=;
        b=hSCCnYB9BxxeV4PRIJTgTA1Di8RkrUO7cZn4LF03PmElfyH32SFiyjuWBJw4Q+NMn0
         3Ny09qbrj6gTpeOSoUxxyOXVCeo09UYdni9JvyXwuaAsBzmacFJ0i8/XWkYQLcgpJjNQ
         zElw9pTVmyE4V1+M1ePvLv3RINVsu2UVVS8M8mumAYfRrzCXQwzXITKYXwYQhXQiATPe
         IyoBy5SKJKli7hZkF2kZVi0SP1xo8V4EW4lVZTH9ZeqZP9jdts9/XstmX4QnU+29e64F
         5zEDzNiu8ARxzk5jN2OO31x4qSPOjg0qI6nkRQeV4DW2a5JjFA4yuTe1/CyRd2mcox4w
         iueQ==
X-Gm-Message-State: AOAM531gsAfk0/jOPmRHpe2fkoVvYzX/KQC4+viDUs8SNFosNWGQYWGn
        zSxy0K8XwLJfbXJJvqGPAlU=
X-Google-Smtp-Source: ABdhPJzAC/Gy2AUUTW9sU9fx/7AU0/diRQdzJN4dFsjfTKyWiDt0U8rw4OyPNmxFkhpistj53GkGWw==
X-Received: by 2002:aa7:9244:0:b029:19a:b335:754b with SMTP id 4-20020aa792440000b029019ab335754bmr15898559pfp.29.1607340859523;
        Mon, 07 Dec 2020 03:34:19 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:19 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Haiwei Li <gerryhwli@tencent.com>
Subject: [RFC V2 12/37] dmem: introduce mempolicy support
Date:   Mon,  7 Dec 2020 19:31:05 +0800
Message-Id: <28718e3b8886b9ec3e4700c2d55a9629ca9fc27c.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/x86/include/asm/pgtable_types.h | 13 +++++++-
 fs/dmemfs/Kconfig                    |  3 ++
 include/linux/pgtable.h              |  7 ++++
 mm/Kconfig                           |  3 ++
 mm/dmem.c                            | 63 ++++++++++++++++++++++++++++++++++--
 7 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b8..9ccee76 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -73,6 +73,7 @@ config X86
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
+	select ARCH_HAS_PTE_DMEM		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_COPY_MC			if X86_64
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a02c672..dd4aff6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -452,6 +452,13 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
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
index 816b31c..ee4cae1 100644
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
index d2894a5..19ca391 100644
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
index 71125a4..9e65694 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1157,6 +1157,13 @@ static inline int pud_trans_unstable(pud_t *pud)
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
index 4dd8896..10fd7ff 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -794,6 +794,9 @@ config IDLE_PAGE_TRACKING
 config ARCH_HAS_PTE_DEVMAP
 	bool
 
+config ARCH_HAS_PTE_DMEM
+	bool
+
 config ZONE_DEVICE
 	bool "Device memory (pmem, HMM, etc...) hotplug support"
 	depends on MEMORY_HOTPLUG
diff --git a/mm/dmem.c b/mm/dmem.c
index 6992e57..2e61dbd 100644
--- a/mm/dmem.c
+++ b/mm/dmem.c
@@ -822,6 +822,56 @@ int dmem_alloc_init(unsigned long dpage_shift)
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
@@ -830,6 +880,9 @@ int dmem_alloc_init(unsigned long dpage_shift)
  *   @try_max: try to allocate @try_max dpages if possible
  *   @result_nr: allocated dpage number returned to the caller
  *
+ * This function allocates pages from dmem pool and applies a NUMA policy
+ * associated with the VMA.
+ *
  * Return the physical address of the first dpage allocated from dmem
  * pool, or 0 on failure. The allocated dpage number is filled into
  * @result_nr
@@ -839,13 +892,19 @@ int dmem_alloc_init(unsigned long dpage_shift)
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
1.8.3.1

