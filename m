Return-Path: <linux-fsdevel+bounces-60345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C902BB4552B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 12:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D7D5C168B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B50307481;
	Fri,  5 Sep 2025 10:44:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507822D5C6C;
	Fri,  5 Sep 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069050; cv=none; b=j+QmcJ/yclz0Tquidk6eHmh0tQ3Lb628avh3so4Ijqd5ZpBVyLk3c/TxsOVD2bvmOOSA4G1i30nRfYLWQE8nHQkRzc95SopIGjJnUuQKg31jPIHyEHtCM+FVTAtnRmEExOUcr4bXGQJENMDTGMXN41S+BN38bqEhi08JXUT4ORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069050; c=relaxed/simple;
	bh=mNGPZb7JEnkwhjCeRTp1DqZulu7skr107FW/+l9Fbok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VxY9oy2TEZ36fI57slkEJDoOx13dyJaJtMZ04rI9tlY6txZIjlsg/JUUgt0V3LHZKZWmI8b+li9YgJojsbXojfVLcIgHbeUOuTaYvOmSrezezsQrDDP0RewNoZSjDqEzLcuOz3GlCW+5CBQIBYAi/VMxAT/+6GOjFBgIBlIz2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowABnwaNMvbpoocLNAA--.50311S6;
	Fri, 05 Sep 2025 18:37:02 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v9 4/5] riscv: mm: Add soft-dirty page tracking support
Date: Fri,  5 Sep 2025 18:36:50 +0800
Message-Id: <20250905103651.489197-5-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905103651.489197-1-zhangchunyan@iscas.ac.cn>
References: <20250905103651.489197-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnwaNMvbpoocLNAA--.50311S6
X-Coremail-Antispam: 1UD129KBjvJXoW3WFW5WFyUWry8tryfuw4rKrg_yoW7GFyxpF
	Z5GFyrZ390yFn3KayftrsIgrWYvws3WayUWr9xCa1kJFWUG3yUXr90grW3AryrJFWkAa4f
	urZ3tr45CrW7Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmjb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI
	1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IUnq-e5UUUUU==
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiBwkQB2i6oq1plwAAs6

The Svrsw60t59b extension allows to free the PTE reserved bits 60 and 59
for software, this patch uses bit 59 for soft-dirty.

To add swap PTE soft-dirty tracking, we borrow bit 3 which is available
for swap PTEs on RISC-V systems.

Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 arch/riscv/Kconfig                    |  1 +
 arch/riscv/include/asm/pgtable-bits.h | 19 +++++++
 arch/riscv/include/asm/pgtable.h      | 73 ++++++++++++++++++++++++++-
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d99df67cc7a4..53b73e4bdf3f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -141,6 +141,7 @@ config RISCV
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SOFT_DIRTY if 64BIT && MMU && RISCV_ISA_SVRSW60T59B
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index 179bd4afece4..8ffe81bf66d2 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -19,6 +19,25 @@
 #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
 
 #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
+
+#ifdef CONFIG_MEM_SOFT_DIRTY
+
+/* ext_svrsw60t59b: bit 59 for software dirty tracking */
+#define _PAGE_SOFT_DIRTY						\
+	((riscv_has_extension_unlikely(RISCV_ISA_EXT_SVRSW60T59B)) ?	\
+	 (1UL << 59) : 0)
+/*
+ * Bit 3 is always zero for swap entry computation, so we
+ * can borrow it for swap page soft-dirty tracking.
+ */
+#define _PAGE_SWP_SOFT_DIRTY						\
+	((riscv_has_extension_unlikely(RISCV_ISA_EXT_SVRSW60T59B)) ?	\
+	 _PAGE_EXEC : 0)
+#else
+#define _PAGE_SOFT_DIRTY	0
+#define _PAGE_SWP_SOFT_DIRTY	0
+#endif /* CONFIG_MEM_SOFT_DIRTY */
+
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 91697fbf1f90..b2d00d129d81 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -427,7 +427,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_DIRTY);
+	return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
@@ -455,6 +455,40 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+#define pte_soft_dirty_available()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVRSW60T59B)
+
+static inline bool pte_soft_dirty(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_mksoft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_clear_soft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_SOFT_DIRTY));
+}
+
+static inline bool pte_swp_soft_dirty(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_SWP_SOFT_DIRTY);
+}
+
+static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
+}
+
+static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_SWP_SOFT_DIRTY));
+}
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define pte_leaf_size(pte)	(pte_napot(pte) ?				\
 					napot_cont_size(napot_cont_order(pte)) :\
@@ -802,6 +836,40 @@ static inline pud_t pud_mkspecial(pud_t pud)
 }
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline bool pmd_soft_dirty(pmd_t pmd)
+{
+	return pte_soft_dirty(pmd_pte(pmd));
+}
+
+static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
+{
+	return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
+{
+	return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
+}
+
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+static inline bool pmd_swp_soft_dirty(pmd_t pmd)
+{
+	return pte_swp_soft_dirty(pmd_pte(pmd));
+}
+
+static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
+{
+	return pte_pmd(pte_swp_mksoft_dirty(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
+{
+	return pte_pmd(pte_swp_clear_soft_dirty(pmd_pte(pmd)));
+}
+#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
@@ -983,7 +1051,8 @@ static inline pud_t pud_modify(pud_t pud, pgprot_t newprot)
  *
  * Format of swap PTE:
  *	bit            0:	_PAGE_PRESENT (zero)
- *	bit       1 to 3:       _PAGE_LEAF (zero)
+ *	bit       1 to 2:	(zero)
+ *	bit            3:	_PAGE_SWP_SOFT_DIRTY
  *	bit            5:	_PAGE_PROT_NONE (zero)
  *	bit            6:	exclusive marker
  *	bits      7 to 11:	swap type
-- 
2.34.1


