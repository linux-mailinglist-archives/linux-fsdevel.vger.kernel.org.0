Return-Path: <linux-fsdevel+bounces-1397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1747D9F7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0A7B217DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF05A3C07F;
	Fri, 27 Oct 2023 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7813B7AA
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:09:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EC0BC0;
	Fri, 27 Oct 2023 11:09:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C48A81424;
	Fri, 27 Oct 2023 11:10:07 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0278A3F64C;
	Fri, 27 Oct 2023 11:09:23 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 09/24] arm64: define VM_PKEY_BIT* for arm64
Date: Fri, 27 Oct 2023 19:08:35 +0100
Message-Id: <20231027180850.1068089-10-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027180850.1068089-1-joey.gouly@arm.com>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the VM_PKEY_BIT* values for arm64, and convert them into the arm64
specific pgprot values.

Move the current values for x86 and PPC into arch/*.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mman.h   |  8 +++++++-
 arch/arm64/include/asm/page.h   | 10 ++++++++++
 arch/arm64/mm/mmap.c            |  9 +++++++++
 arch/powerpc/include/asm/page.h | 11 +++++++++++
 arch/x86/include/asm/page.h     | 10 ++++++++++
 fs/proc/task_mmu.c              |  2 ++
 include/linux/mm.h              | 13 -------------
 7 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..ecb2d18dc4d7 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -7,7 +7,7 @@
 #include <uapi/asm/mman.h>
 
 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
-	unsigned long pkey __always_unused)
+	unsigned long pkey)
 {
 	unsigned long ret = 0;
 
@@ -17,6 +17,12 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 	if (system_supports_mte() && (prot & PROT_MTE))
 		ret |= VM_MTE;
 
+#if defined(CONFIG_ARCH_HAS_PKEYS)
+	ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
+	ret |= pkey & 0x2 ? VM_PKEY_BIT1 : 0;
+	ret |= pkey & 0x4 ? VM_PKEY_BIT2 : 0;
+#endif
+
 	return ret;
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 2312e6ee595f..aabfda2516d2 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -49,6 +49,16 @@ int pfn_is_map_memory(unsigned long pfn);
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_DATA_FLAGS_TSK_EXEC | VM_MTE_ALLOWED)
 
+#if defined(CONFIG_ARCH_HAS_PKEYS)
+/* A protection key is a 3-bit value */
+# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_2
+# define VM_PKEY_BIT0	VM_HIGH_ARCH_2
+# define VM_PKEY_BIT1	VM_HIGH_ARCH_3
+# define VM_PKEY_BIT2	VM_HIGH_ARCH_4
+# define VM_PKEY_BIT3	0
+# define VM_PKEY_BIT4	0
+#endif
+
 #include <asm-generic/getorder.h>
 
 #endif
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 8f5b7ce857ed..df4ece982375 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -98,6 +98,15 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)
 	if (vm_flags & VM_MTE)
 		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
 
+#ifdef CONFIG_ARCH_HAS_PKEYS
+	if (vm_flags & VM_PKEY_BIT0)
+		prot |= PTE_PO_IDX_0;
+	if (vm_flags & VM_PKEY_BIT1)
+		prot |= PTE_PO_IDX_1;
+	if (vm_flags & VM_PKEY_BIT2)
+		prot |= PTE_PO_IDX_2;
+#endif
+
 	return __pgprot(prot);
 }
 EXPORT_SYMBOL(vm_get_page_prot);
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index e5fcc79b5bfb..a5e75ec333ad 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -330,6 +330,17 @@ static inline unsigned long kaslr_offset(void)
 }
 
 #include <asm-generic/memory_model.h>
+
+#if defined(CONFIG_ARCH_HAS_PKEYS)
+# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
+/* A protection key is a 5-bit value */
+# define VM_PKEY_BIT0	VM_HIGH_ARCH_0
+# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
+# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
+# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
+# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
+#endif /* CONFIG_ARCH_HAS_PKEYS */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PAGE_H */
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index d18e5c332cb9..b770db1a21e7 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -87,5 +87,15 @@ static __always_inline u64 __is_canonical_address(u64 vaddr, u8 vaddr_bits)
 
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
+#if defined(CONFIG_ARCH_HAS_PKEYS)
+# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
+/* A protection key is a 4-bit value */
+# define VM_PKEY_BIT0	VM_HIGH_ARCH_0
+# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
+# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
+# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
+# define VM_PKEY_BIT4	0
+#endif /* CONFIG_ARCH_HAS_PKEYS */
+
 #endif	/* __KERNEL__ */
 #endif /* _ASM_X86_PAGE_H */
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3dd5be96691b..fcd94a39bb30 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -689,7 +689,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT0)]	= "",
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
+#if VM_PKEY_BIT3
 		[ilog2(VM_PKEY_BIT3)]	= "",
+#endif
 #if VM_PKEY_BIT4
 		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..84ee022bf43e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -328,19 +328,6 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
-#ifdef CONFIG_ARCH_HAS_PKEYS
-# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
-# define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
-# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
-# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
-# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
-#ifdef CONFIG_PPC
-# define VM_PKEY_BIT4  VM_HIGH_ARCH_4
-#else
-# define VM_PKEY_BIT4  0
-#endif
-#endif /* CONFIG_ARCH_HAS_PKEYS */
-
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 /*
  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
-- 
2.25.1


