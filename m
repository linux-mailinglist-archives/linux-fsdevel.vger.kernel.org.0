Return-Path: <linux-fsdevel+bounces-44973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E18A6FC91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1123A8FBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CAA267B62;
	Tue, 25 Mar 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKT4xQjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1069E55B;
	Tue, 25 Mar 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905220; cv=none; b=bN3lGgCm+4EgU86V0yR61wZT2uEW4IRzcUZ51c0RSEbZczPdl+hOq7oyRnuEewNo5sMkjjAa8I1dWgKxCGorMVFSeoZgxUiA3RscaVUCojQtEHtEzaFlwGCSQkr/d/rgO4t2m5O3l9gDEH0Wn8TCwOa7Ne3kULxu4nv9S2acwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905220; c=relaxed/simple;
	bh=mr+aCskDI8FnVUv97AkI1nVng2udAHyoEjzxRXN+v3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbad9ic/MXANFABBexvxCoM+ANXhHZU/j8aMMZJVK/6EWcNz66AAtqnQ+0xWGifj1r8TptGxkCcLjRffy7nqHW6+XOAKM1S9mE7nKRiseMmE4/QyOXBZNwdCMgXMwljeKZLr8wb04N2VA3o8RN+pWN+/kveZT8U9PCHSqq1NIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKT4xQjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053F9C4CEE4;
	Tue, 25 Mar 2025 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905220;
	bh=mr+aCskDI8FnVUv97AkI1nVng2udAHyoEjzxRXN+v3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKT4xQjPJQDbTJK65nUQN6bTlb4n5iwqfpuEAE6mLf8dAZrJ5VsB3GWoUzEs58E5m
	 iMizoEMYPrRGr9I9IExEu0dkMxh2lwWdwiU8cQrGLp/9IxIvatPcMnB6r59Ome97cF
	 uYUpybpm5G2SdSWA950lwKaUjdu4uSPk8vVJyxswo86EjYCwzXNyg1oC7PK2ZwrxqZ
	 5Ak7U8tdChp1b8q6i6FAyhIRwxkbJOB3cMtlwyQM8AN2FFP2jxeEj2xAWq2b4vLhof
	 izkyv+oDHImICCaizrUJhFftLkYPZMa+4qOxRPhbdPved6Vlj6q5hjhJ00b8lfBzPG
	 ImwwWKfE+IQLg==
From: guoren@kernel.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	oleg@redhat.com,
	kees@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	mark.rutland@arm.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	edumazet@google.com,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn,
	jiawei@iscas.ac.cn,
	wuwei2016@iscas.ac.cn,
	drew@pdp7.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com,
	wefu@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	guoren@kernel.org,
	xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn,
	leobras@redhat.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn
Cc: ardb@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFC PATCH V3 15/43] rv64ilp32_abi: riscv: mm: Adapt MMU_SV39 for 2GiB address space
Date: Tue, 25 Mar 2025 08:15:56 -0400
Message-Id: <20250325121624.523258-16-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>
References: <20250325121624.523258-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

The RV64ILP32 ABI has two independent 2GiB address space for
kernel and user.

There is no sv32 mmu mode support in xlen=64 ISA. This commit
enables MMU_SV39 for RV64ILP32 to satisfy the user & kernel 2GiB
mapping requirements. The Sv39 is the mandatory MMU mode when
rv64 satp != bare, so we needn't care about Sv48 & Sv57.

2GiB virtual userspace memory layout (u64lp64 ABI):
55555000-5560c000 r-xp 00000000 fe:00 17         /bin/busybox
5560c000-5560f000 r--p 000b7000 fe:00 17         /bin/busybox
5560f000-55610000 rw-p 000ba000 fe:00 17         /bin/busybox
55610000-55631000 rw-p 00000000 00:00 0          [heap]
77e69000-77e6b000 rw-p 00000000 00:00 0
77e6b000-77fba000 r-xp 00000000 fe:00 140        /lib/libc.so.6
77fba000-77fbd000 r--p 0014f000 fe:00 140        /lib/libc.so.6
77fbd000-77fbf000 rw-p 00152000 fe:00 140        /lib/libc.so.6
77fbf000-77fcb000 rw-p 00000000 00:00 0
77fcb000-77fd5000 r-xp 00000000 fe:00 148        /lib/libresolv.so.2
77fd5000-77fd6000 r--p 0000a000 fe:00 148        /lib/libresolv.so.2
77fd6000-77fd7000 rw-p 0000b000 fe:00 148        /lib/libresolv.so.2
77fd7000-77fd9000 rw-p 00000000 00:00 0
77fd9000-77fdb000 r--p 00000000 00:00 0          [vvar]
77fdb000-77fdc000 r-xp 00000000 00:00 0          [vdso]
77fdc000-77ffc000 r-xp 00000000 fe:00 135        /lib/ld-linux-riscv64-lp64d.so.1
77ffc000-77ffe000 r--p 0001f000 fe:00 135        /lib/ld-linux-riscv64-lp64d.so.1
77ffe000-78000000 rw-p 00021000 fe:00 135        /lib/ld-linux-riscv64-lp64d.so.1
7ffdf000-80000000 rw-p 00000000 00:00 0          [stack]

2GiB virtual kernel memory layout:
       fixmap : 0x90a00000 - 0x90ffffff   (6144 kB)
       pci io : 0x91000000 - 0x91ffffff   (  16 MB)
      vmemmap : 0x92000000 - 0x93ffffff   (  32 MB)
      vmalloc : 0x94000000 - 0xb3ffffff   ( 512 MB)
      modules : 0xb4000000 - 0xb7ffffff   (  64 MB)
       lowmem : 0xc0000000 - 0xc7ffffff   ( 128 MB)
        kasan : 0x80000000 - 0x8fffffff   ( 256 MB)
       kernel : 0xb8000000 - 0xbfffffff   ( 128 MB)

For satp=sv39, introduce a double mapping to make the sign-extended
virtual address identical to the zero-extended virtual address:

   +--------+      +---------+      +--------+
   |        |   +--| 511:PUD1|      |        |
   |        |   |  +---------+      |        |
   |        |   |  | 510:PUD0|--+   |        |
   |        |   |  +---------+  |   |        |
   |        |   |  |         |  |   |        |
   |        |   |  |         |  |   |        |
   |        |   |  |         |  |   |        |
   |        |   |  | INVALID |  |   |        |
   |        |   |  |         |  |   |        |
   |  ....  |   |  |         |  |   |  ....  |
   |        |   |  |         |  |   |        |
   |        |   |  +---------+  |   |        |
   |        |   +--|  3:PUD1 |  |   |        |
   |        |   |  +---------+  |   |        |
   |        |   |  |  2:PUD0 |--+   |        |
   |        |   |  +---------+  |   |        |
   |        |   |  |1:USR_PUD|  |   |        |
   |        |   |  +---------+  |   |        |
   |        |   |  |0:USR_PUD|  |   |        |
   +--------+<--+  +---------+  +-->+--------+
      PUD1         ^   PGD             PUD0
      1GB          |   4GB             1GB
                   |
                   +----------+
                   | Sv39 PGDP|
                   +----------+
                       SATP

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/Kconfig                  |  2 +-
 arch/riscv/include/asm/page.h       | 23 ++++++-----
 arch/riscv/include/asm/pgtable-64.h | 55 ++++++++++++++------------
 arch/riscv/include/asm/pgtable.h    | 60 ++++++++++++++++++++++++-----
 arch/riscv/include/asm/processor.h  |  2 +-
 arch/riscv/kernel/cpu.c             |  4 +-
 arch/riscv/mm/fault.c               | 10 ++---
 arch/riscv/mm/init.c                | 55 ++++++++++++++++++--------
 arch/riscv/mm/pageattr.c            |  4 +-
 arch/riscv/mm/pgtable.c             |  2 +-
 10 files changed, 145 insertions(+), 72 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 884235cf4092..9469cdc51ba4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -293,7 +293,7 @@ config PAGE_OFFSET
 	hex
 	default 0x80000000 if !MMU && RISCV_M_MODE
 	default 0x80200000 if !MMU
-	default 0xc0000000 if 32BIT
+	default 0xc0000000 if 32BIT || ABI_RV64ILP32
 	default 0xff60000000000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 125f5ecd9565..45091a9de0d4 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -24,7 +24,7 @@
  * When not using MMU this corresponds to the first free page in
  * physical memory (aligned on a page boundary).
  */
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 #ifdef CONFIG_MMU
 #define PAGE_OFFSET		kernel_map.page_offset
 #else
@@ -38,7 +38,7 @@
 #define PAGE_OFFSET_L3		_AC(0xffffffd600000000, UL)
 #else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
-#endif /* CONFIG_64BIT */
+#endif /* BITS_PER_LONG == 64 */
 
 #ifndef __ASSEMBLY__
 
@@ -56,19 +56,24 @@ void clear_page(void *page);
 /*
  * Use struct definitions to apply C type checking
  */
+#if CONFIG_PGTABLE_LEVELS > 2
+typedef	u64 ptval_t;
+#else
+typedef	ulong ptval_t;
+#endif
 
 /* Page Global Directory entry */
 typedef struct {
-	unsigned long pgd;
+	ptval_t pgd;
 } pgd_t;
 
 /* Page Table entry */
 typedef struct {
-	unsigned long pte;
+	ptval_t pte;
 } pte_t;
 
 typedef struct {
-	unsigned long pgprot;
+	ptval_t pgprot;
 } pgprot_t;
 
 typedef struct page *pgtable_t;
@@ -81,13 +86,13 @@ typedef struct page *pgtable_t;
 #define __pgd(x)	((pgd_t) { (x) })
 #define __pgprot(x)	((pgprot_t) { (x) })
 
-#ifdef CONFIG_64BIT
-#define PTE_FMT "%016lx"
+#if CONFIG_PGTABLE_LEVELS > 2
+#define PTE_FMT "%016llx"
 #else
 #define PTE_FMT "%08lx"
 #endif
 
-#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
+#if (CONFIG_PGTABLE_LEVELS > 2) && defined(CONFIG_MMU)
 /*
  * We override this value as its generic definition uses __pa too early in
  * the boot process (before kernel_map.va_pa_offset is set).
@@ -128,7 +133,7 @@ extern unsigned long vmemmap_start_pfn;
 	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
 
 #define is_linear_mapping(x)	\
-	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
+	((x) >= PAGE_OFFSET && ((BITS_PER_LONG == 32) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
 
 #ifndef CONFIG_DEBUG_VIRTUAL
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 0897dd99ab8d..401c012d0b66 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -19,7 +19,12 @@ extern bool pgtable_l5_enabled;
 #define PGDIR_SHIFT     (pgtable_l5_enabled ? PGDIR_SHIFT_L5 : \
 		(pgtable_l4_enabled ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
 /* Size of region mapped by a page global directory */
+#if BITS_PER_LONG == 64
 #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
+#else
+#define PGDIR_SIZE      (_AC(1, ULL) << PGDIR_SHIFT)
+#endif
+
 #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
 
 /* p4d is folded into pgd in case of 4-level page table */
@@ -28,7 +33,7 @@ extern bool pgtable_l5_enabled;
 #define P4D_SHIFT_L5   39
 #define P4D_SHIFT      (pgtable_l5_enabled ? P4D_SHIFT_L5 : \
 		(pgtable_l4_enabled ? P4D_SHIFT_L4 : P4D_SHIFT_L3))
-#define P4D_SIZE       (_AC(1, UL) << P4D_SHIFT)
+#define P4D_SIZE       (_AC(1, ULL) << P4D_SHIFT)
 #define P4D_MASK       (~(P4D_SIZE - 1))
 
 /* pud is folded into pgd in case of 3-level page table */
@@ -43,7 +48,7 @@ extern bool pgtable_l5_enabled;
 
 /* Page 4th Directory entry */
 typedef struct {
-	unsigned long p4d;
+	u64 p4d;
 } p4d_t;
 
 #define p4d_val(x)	((x).p4d)
@@ -52,7 +57,7 @@ typedef struct {
 
 /* Page Upper Directory entry */
 typedef struct {
-	unsigned long pud;
+	u64 pud;
 } pud_t;
 
 #define pud_val(x)      ((x).pud)
@@ -61,7 +66,7 @@ typedef struct {
 
 /* Page Middle Directory entry */
 typedef struct {
-	unsigned long pmd;
+	u64 pmd;
 } pmd_t;
 
 #define pmd_val(x)      ((x).pmd)
@@ -74,7 +79,7 @@ typedef struct {
  * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
  *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
  */
-#define _PAGE_PFN_MASK  GENMASK(53, 10)
+#define _PAGE_PFN_MASK  GENMASK_ULL(53, 10)
 
 /*
  * [63] Svnapot definitions:
@@ -82,7 +87,7 @@ typedef struct {
  * 1 Svnapot enabled
  */
 #define _PAGE_NAPOT_SHIFT	63
-#define _PAGE_NAPOT		BIT(_PAGE_NAPOT_SHIFT)
+#define _PAGE_NAPOT		BIT_ULL(_PAGE_NAPOT_SHIFT)
 /*
  * Only 64KB (order 4) napot ptes supported.
  */
@@ -100,9 +105,9 @@ enum napot_cont_order {
 #define napot_cont_order(val)	(__builtin_ctzl((val.pte >> _PAGE_PFN_SHIFT) << 1))
 
 #define napot_cont_shift(order)	((order) + PAGE_SHIFT)
-#define napot_cont_size(order)	BIT(napot_cont_shift(order))
+#define napot_cont_size(order)	BIT_ULL(napot_cont_shift(order))
 #define napot_cont_mask(order)	(~(napot_cont_size(order) - 1UL))
-#define napot_pte_num(order)	BIT(order)
+#define napot_pte_num(order)	BIT_ULL(order)
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define HUGE_MAX_HSTATE		(2 + (NAPOT_ORDER_MAX - NAPOT_CONT_ORDER_BASE))
@@ -118,8 +123,8 @@ enum napot_cont_order {
  *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
  *  11 - Rsvd   Reserved for future standard use
  */
-#define _PAGE_NOCACHE_SVPBMT	(1UL << 61)
-#define _PAGE_IO_SVPBMT		(1UL << 62)
+#define _PAGE_NOCACHE_SVPBMT	(1ULL << 61)
+#define _PAGE_IO_SVPBMT		(1ULL << 62)
 #define _PAGE_MTMASK_SVPBMT	(_PAGE_NOCACHE_SVPBMT | _PAGE_IO_SVPBMT)
 
 /*
@@ -133,10 +138,10 @@ enum napot_cont_order {
  * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-trustable
  * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
  */
-#define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
-#define _PAGE_NOCACHE_THEAD	((1UL << 61) | (1UL << 60))
-#define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
-#define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
+#define _PAGE_PMA_THEAD		((1ULL << 62) | (1ULL << 61) | (1ULL << 60))
+#define _PAGE_NOCACHE_THEAD	((1ULL << 61) | (1ULL << 60))
+#define _PAGE_IO_THEAD		((1ULL << 63) | (1ULL << 60))
+#define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1ULL << 59))
 
 static inline u64 riscv_page_mtmask(void)
 {
@@ -167,7 +172,7 @@ static inline u64 riscv_page_io(void)
 #define _PAGE_MTMASK		riscv_page_mtmask()
 
 /* Set of bits to preserve across pte_modify() */
-#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
+#define _PAGE_CHG_MASK  (~(u64)(_PAGE_PRESENT | _PAGE_READ |	\
 					  _PAGE_WRITE | _PAGE_EXEC |	\
 					  _PAGE_USER | _PAGE_GLOBAL |	\
 					  _PAGE_MTMASK))
@@ -208,12 +213,12 @@ static inline void pud_clear(pud_t *pudp)
 	set_pud(pudp, __pud(0));
 }
 
-static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
+static inline pud_t pfn_pud(u64 pfn, pgprot_t prot)
 {
 	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
 
-static inline unsigned long _pud_pfn(pud_t pud)
+static inline u64 _pud_pfn(pud_t pud)
 {
 	return __page_val_to_pfn(pud_val(pud));
 }
@@ -248,16 +253,16 @@ static inline bool mm_pud_folded(struct mm_struct *mm)
 
 #define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
 
-static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
+static inline pmd_t pfn_pmd(u64 pfn, pgprot_t prot)
 {
-	unsigned long prot_val = pgprot_val(prot);
+	u64 prot_val = pgprot_val(prot);
 
 	ALT_THEAD_PMA(prot_val);
 
 	return __pmd((pfn << _PAGE_PFN_SHIFT) | prot_val);
 }
 
-static inline unsigned long _pmd_pfn(pmd_t pmd)
+static inline u64 _pmd_pfn(pmd_t pmd)
 {
 	return __page_val_to_pfn(pmd_val(pmd));
 }
@@ -265,13 +270,13 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
 
 #define pmd_ERROR(e) \
-	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
+	pr_err("%s:%d: bad pmd " PTE_FMT ".\n", __FILE__, __LINE__, pmd_val(e))
 
 #define pud_ERROR(e)   \
-	pr_err("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
+	pr_err("%s:%d: bad pud " PTE_FMT ".\n", __FILE__, __LINE__, pud_val(e))
 
 #define p4d_ERROR(e)   \
-	pr_err("%s:%d: bad p4d %016lx.\n", __FILE__, __LINE__, p4d_val(e))
+	pr_err("%s:%d: bad p4d " PTE_FMT ".\n", __FILE__, __LINE__, p4d_val(e))
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
@@ -311,12 +316,12 @@ static inline void p4d_clear(p4d_t *p4d)
 		set_p4d(p4d, __p4d(0));
 }
 
-static inline p4d_t pfn_p4d(unsigned long pfn, pgprot_t prot)
+static inline p4d_t pfn_p4d(u64 pfn, pgprot_t prot)
 {
 	return __p4d((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
 
-static inline unsigned long _p4d_pfn(p4d_t p4d)
+static inline u64 _p4d_pfn(p4d_t p4d)
 {
 	return __page_val_to_pfn(p4d_val(p4d));
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 050fdc49b5ad..5f1b48cb3311 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -9,6 +9,7 @@
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
 
+#include <asm/bitsperlong.h>
 #include <asm/pgtable-bits.h>
 
 #ifndef CONFIG_MMU
@@ -19,8 +20,13 @@
 #define ADDRESS_SPACE_END	(UL(-1))
 
 #ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 /* Leave 2GB for kernel and BPF at the end of the address space */
 #define KERNEL_LINK_ADDR	(ADDRESS_SPACE_END - SZ_2G + 1)
+#elif BITS_PER_LONG == 32
+/* Leave 64MB for kernel and BPF below PAGE_OFFSET  */
+#define KERNEL_LINK_ADDR	(PAGE_OFFSET - SZ_64M)
+#endif
 #else
 #define KERNEL_LINK_ADDR	PAGE_OFFSET
 #endif
@@ -34,31 +40,45 @@
  * Half of the kernel address space (1/4 of the entries of the page global
  * directory) is for the direct mapping.
  */
+#if (BITS_PER_LONG == 32) && (CONFIG_PGTABLE_LEVELS > 2)
+#define KERN_VIRT_SIZE          (PTRS_PER_PGD * PMD_SIZE)
+#else
 #define KERN_VIRT_SIZE          ((PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
+#endif
 
 #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
+#if defined(CONFIG_64BIT) && (BITS_PER_LONG == 32)
+#define VMALLOC_END      MODULES_LOWEST_VADDR
+#else
 #define VMALLOC_END      PAGE_OFFSET
-#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+#endif
+#define VMALLOC_START    (VMALLOC_END - VMALLOC_SIZE)
 
 #define BPF_JIT_REGION_SIZE	(SZ_128M)
-#ifdef CONFIG_64BIT
 #define BPF_JIT_REGION_START	(BPF_JIT_REGION_END - BPF_JIT_REGION_SIZE)
+#if BITS_PER_LONG == 64
 #define BPF_JIT_REGION_END	(MODULES_END)
 #else
-#define BPF_JIT_REGION_START	(PAGE_OFFSET - BPF_JIT_REGION_SIZE)
 #define BPF_JIT_REGION_END	(VMALLOC_END)
 #endif
 
 /* Modules always live before the kernel */
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 /* This is used to define the end of the KASAN shadow region */
 #define MODULES_LOWEST_VADDR	(KERNEL_LINK_ADDR - SZ_2G)
 #define MODULES_VADDR		(PFN_ALIGN((unsigned long)&_end) - SZ_2G)
 #define MODULES_END		(PFN_ALIGN((unsigned long)&_start))
 #else
+#ifdef CONFIG_64BIT
+#define MODULES_LOWEST_VADDR	(KERNEL_LINK_ADDR - SZ_64M)
+#define MODULES_VADDR		MODULES_LOWEST_VADDR
+#define MODULES_END		KERNEL_LINK_ADDR
+#else
+#define MODULES_LOWEST_VADDR	VMALLOC_START
 #define MODULES_VADDR		VMALLOC_START
 #define MODULES_END		VMALLOC_END
 #endif
+#endif
 
 /*
  * Roughly size the vmemmap space to be large enough to fit enough
@@ -66,7 +86,7 @@
  * position vmemmap directly below the VMALLOC region.
  */
 #define VA_BITS_SV32 32
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && (BITS_PER_LONG == 64)
 #define VA_BITS_SV39 39
 #define VA_BITS_SV48 48
 #define VA_BITS_SV57 57
@@ -126,9 +146,14 @@
 
 #define MMAP_VA_BITS_64 ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
 #define MMAP_MIN_VA_BITS_64 (VA_BITS_SV39)
+#if BITS_PER_LONG == 64
 #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_64)
 #define MMAP_MIN_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_MIN_VA_BITS_64)
 #else
+#define MMAP_VA_BITS		VA_BITS_SV32
+#define MMAP_MIN_VA_BITS	VA_BITS_SV32
+#endif
+#else
 #include <asm/pgtable-32.h>
 #endif /* CONFIG_64BIT */
 
@@ -252,7 +277,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
 {
-	unsigned long prot_val = pgprot_val(prot);
+	ptval_t prot_val = pgprot_val(prot);
 
 	ALT_THEAD_PMA(prot_val);
 
@@ -591,7 +616,11 @@ extern int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long a
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address, pte_t *ptep)
 {
+#if CONFIG_PGTABLE_LEVELS > 2
+	pte_t pte = __pte(atomic64_xchg((atomic64_t *)ptep, 0));
+#else
 	pte_t pte = __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
+#endif
 
 	page_table_check_pte_clear(mm, pte);
 
@@ -602,7 +631,11 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
+#if CONFIG_PGTABLE_LEVELS > 2
+	atomic64_and(~(u64)_PAGE_WRITE, (atomic64_t *)ptep);
+#else
 	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+#endif
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
@@ -636,7 +669,7 @@ static inline pgprot_t pgprot_nx(pgprot_t _prot)
 #define pgprot_noncached pgprot_noncached
 static inline pgprot_t pgprot_noncached(pgprot_t _prot)
 {
-	unsigned long prot = pgprot_val(_prot);
+	ptval_t prot = pgprot_val(_prot);
 
 	prot &= ~_PAGE_MTMASK;
 	prot |= _PAGE_IO;
@@ -647,7 +680,7 @@ static inline pgprot_t pgprot_noncached(pgprot_t _prot)
 #define pgprot_writecombine pgprot_writecombine
 static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 {
-	unsigned long prot = pgprot_val(_prot);
+	ptval_t prot = pgprot_val(_prot);
 
 	prot &= ~_PAGE_MTMASK;
 	prot |= _PAGE_NOCACHE;
@@ -905,8 +938,12 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * and give the kernel the other (upper) half.
  */
 #ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 #define KERN_VIRT_START	(-(BIT(VA_BITS)) + TASK_SIZE)
 #else
+#define KERN_VIRT_START	TASK_SIZE_32
+#endif
+#else
 #define KERN_VIRT_START	FIXADDR_START
 #endif
 
@@ -915,6 +952,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  * Task size is:
  * -        0x9fc00000	(~2.5GB) for RV32.
+ * -        0x80000000	(   2GB) for RV32_COMPAT & RV64ILP32
  * -      0x4000000000	( 256GB) for RV64 using SV39 mmu
  * -    0x800000000000	( 128TB) for RV64 using SV48 mmu
  * - 0x100000000000000	(  64PB) for RV64 using SV57 mmu
@@ -928,15 +966,19 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
 #define TASK_SIZE_MAX	LONG_MAX
+#define TASK_SIZE_32	_AC(0x80000000, UL)
 
+#if BITS_PER_LONG == 64
 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
 #define TASK_SIZE	(is_compat_task() ? \
 			 TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE	TASK_SIZE_64
 #endif
 
+#else
+#define TASK_SIZE	TASK_SIZE_32
+#endif
 #else
 #define TASK_SIZE	FIXADDR_START
 #endif
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index ca57a650c3d2..9f4e0be595fd 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -24,7 +24,7 @@
 	base;							\
 })
 
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE_64
 #else
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index f6b13e9f5e6c..ce1440c63606 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -291,9 +291,9 @@ static void print_mmu(struct seq_file *f)
 	const char *sv_type;
 
 #ifdef CONFIG_MMU
-#if defined(CONFIG_32BIT)
+#if CONFIG_PGTABLE_LEVELS == 2
 	sv_type = "sv32";
-#elif defined(CONFIG_64BIT)
+#else
 	if (pgtable_l5_enabled)
 		sv_type = "sv57";
 	else if (pgtable_l4_enabled)
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index fcc23350610e..1e854e9633b3 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -40,25 +40,25 @@ static void show_pte(unsigned long addr)
 
 	pgdp = pgd_offset(mm, addr);
 	pgd = pgdp_get(pgdp);
-	pr_alert("[%016lx] pgd=%016lx", addr, pgd_val(pgd));
+	pr_alert("[%016lx] pgd=" REG_FMT, addr, pgd_val(pgd));
 	if (pgd_none(pgd) || pgd_bad(pgd) || pgd_leaf(pgd))
 		goto out;
 
 	p4dp = p4d_offset(pgdp, addr);
 	p4d = p4dp_get(p4dp);
-	pr_cont(", p4d=%016lx", p4d_val(p4d));
+	pr_cont(", p4d=" REG_FMT, p4d_val(p4d));
 	if (p4d_none(p4d) || p4d_bad(p4d) || p4d_leaf(p4d))
 		goto out;
 
 	pudp = pud_offset(p4dp, addr);
 	pud = pudp_get(pudp);
-	pr_cont(", pud=%016lx", pud_val(pud));
+	pr_cont(", pud=" REG_FMT, pud_val(pud));
 	if (pud_none(pud) || pud_bad(pud) || pud_leaf(pud))
 		goto out;
 
 	pmdp = pmd_offset(pudp, addr);
 	pmd = pmdp_get(pmdp);
-	pr_cont(", pmd=%016lx", pmd_val(pmd));
+	pr_cont(", pmd=" REG_FMT, pmd_val(pmd));
 	if (pmd_none(pmd) || pmd_bad(pmd) || pmd_leaf(pmd))
 		goto out;
 
@@ -67,7 +67,7 @@ static void show_pte(unsigned long addr)
 		goto out;
 
 	pte = ptep_get(ptep);
-	pr_cont(", pte=%016lx", pte_val(pte));
+	pr_cont(", pte=" REG_FMT, pte_val(pte));
 	pte_unmap(ptep);
 out:
 	pr_cont("\n");
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 15b2eda4c364..3cdbb033860e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -46,16 +46,20 @@ EXPORT_SYMBOL(kernel_map);
 #define kernel_map	(*(struct kernel_mapping *)XIP_FIXUP(&kernel_map))
 #endif
 
-#ifdef CONFIG_64BIT
+#if CONFIG_PGTABLE_LEVELS > 2
+#if BITS_PER_LONG == 64
 u64 satp_mode __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL) ? SATP_MODE_57 : SATP_MODE_39;
 #else
+u64 satp_mode __ro_after_init = SATP_MODE_39;
+#endif
+#else
 u64 satp_mode __ro_after_init = SATP_MODE_32;
 #endif
 EXPORT_SYMBOL(satp_mode);
 
 #ifdef CONFIG_64BIT
-bool pgtable_l4_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
-bool pgtable_l5_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
+bool pgtable_l4_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL) && (BITS_PER_LONG == 64);
+bool pgtable_l5_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL) && (BITS_PER_LONG == 64);
 EXPORT_SYMBOL(pgtable_l4_enabled);
 EXPORT_SYMBOL(pgtable_l5_enabled);
 #endif
@@ -117,7 +121,7 @@ static inline void print_mlg(char *name, unsigned long b, unsigned long t)
 		   (((t) - (b)) >> LOG2_SZ_1G));
 }
 
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 static inline void print_mlt(char *name, unsigned long b, unsigned long t)
 {
 	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld TB)\n", name, b, t,
@@ -131,7 +135,7 @@ static inline void print_ml(char *name, unsigned long b, unsigned long t)
 {
 	unsigned long diff = t - b;
 
-	if (IS_ENABLED(CONFIG_64BIT) && (diff >> LOG2_SZ_1T) >= 10)
+	if ((BITS_PER_LONG == 64) && (diff >> LOG2_SZ_1T) >= 10)
 		print_mlt(name, b, t);
 	else if ((diff >> LOG2_SZ_1G) >= 10)
 		print_mlg(name, b, t);
@@ -164,7 +168,9 @@ static void __init print_vm_layout(void)
 #endif
 
 		print_ml("kernel", (unsigned long)kernel_map.virt_addr,
-			 (unsigned long)ADDRESS_SPACE_END);
+			 (BITS_PER_LONG == 64) ?
+			 (unsigned long)ADDRESS_SPACE_END :
+			 (unsigned long)PAGE_OFFSET);
 	}
 }
 #else
@@ -173,7 +179,8 @@ static void print_vm_layout(void) { }
 
 void __init mem_init(void)
 {
-	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit);
+	bool swiotlb = (BITS_PER_LONG == 32) ? false:
+		       (max_pfn > PFN_DOWN(dma32_phys_limit));
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
 #endif /* CONFIG_FLATMEM */
@@ -319,7 +326,7 @@ static void __init setup_bootmem(void)
 		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
 
 	dma_contiguous_reserve(dma32_phys_limit);
-	if (IS_ENABLED(CONFIG_64BIT))
+	if (BITS_PER_LONG == 64)
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 }
 
@@ -685,16 +692,26 @@ void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa, phy
 	pgd_next_t *nextp;
 	phys_addr_t next_phys;
 	uintptr_t pgd_idx = pgd_index(va);
+#if (CONFIG_PGTABLE_LEVELS > 2) && (BITS_PER_LONG == 32)
+	uintptr_t pgd_idh = pgd_index(sign_extend64((u64)va, 31));
+#endif
 
 	if (sz == PGDIR_SIZE) {
-		if (pgd_val(pgdp[pgd_idx]) == 0)
+		if (pgd_val(pgdp[pgd_idx]) == 0) {
 			pgdp[pgd_idx] = pfn_pgd(PFN_DOWN(pa), prot);
+#if (CONFIG_PGTABLE_LEVELS > 2) && (BITS_PER_LONG == 32)
+			pgdp[pgd_idh] = pfn_pgd(PFN_DOWN(pa), prot);
+#endif
+		}
 		return;
 	}
 
 	if (pgd_val(pgdp[pgd_idx]) == 0) {
 		next_phys = alloc_pgd_next(va);
 		pgdp[pgd_idx] = pfn_pgd(PFN_DOWN(next_phys), PAGE_TABLE);
+#if (CONFIG_PGTABLE_LEVELS > 2) && (BITS_PER_LONG == 32)
+		pgdp[pgd_idh] = pfn_pgd(PFN_DOWN(next_phys), PAGE_TABLE);
+#endif
 		nextp = get_pgd_next_virt(next_phys);
 		memset(nextp, 0, PAGE_SIZE);
 	} else {
@@ -775,7 +792,7 @@ static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 }
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
-#if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
+#if (BITS_PER_LONG == 64) && !defined(CONFIG_XIP_KERNEL)
 u64 __pi_set_satp_mode_from_cmdline(uintptr_t dtb_pa);
 
 static void __init disable_pgtable_l5(void)
@@ -981,8 +998,8 @@ static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
 	/* Make sure the fdt fixmap address is always aligned on PMD size */
 	BUILD_BUG_ON(FIX_FDT % (PMD_SIZE / PAGE_SIZE));
 
-	/* In 32-bit only, the fdt lies in its own PGD */
-	if (!IS_ENABLED(CONFIG_64BIT)) {
+	/* In Sv32 only, the fdt lies in its own PGD */
+	if (CONFIG_PGTABLE_LEVELS == 2) {
 		create_pgd_mapping(early_pg_dir, fix_fdt_va,
 				   pa, MAX_FDT_SIZE, PAGE_KERNEL);
 	} else {
@@ -1108,7 +1125,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.virt_addr = KERNEL_LINK_ADDR + kernel_map.virt_offset;
 
 #ifdef CONFIG_XIP_KERNEL
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 	kernel_map.page_offset = PAGE_OFFSET_L3;
 #else
 	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
@@ -1133,7 +1150,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 #endif
 
-#if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
+#if (BITS_PER_LONG == 64) && !defined(CONFIG_XIP_KERNEL)
 	set_satp_mode(dtb_pa);
 	set_mmap_rnd_bits_max();
 #endif
@@ -1164,7 +1181,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 * The last 4K bytes of the addressable memory can not be mapped because
 	 * of IS_ERR_VALUE macro.
 	 */
+#if BITS_PER_LONG == 64
 	BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
+#else
+	BUG_ON((kernel_map.virt_addr + kernel_map.size) > PAGE_OFFSET - SZ_4K);
+#endif
 #endif
 
 #ifdef CONFIG_RELOCATABLE
@@ -1246,7 +1267,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	fix_bmap_epmd = fixmap_pmd[pmd_index(__fix_to_virt(FIX_BTMAP_END))];
 	if (pmd_val(fix_bmap_spmd) != pmd_val(fix_bmap_epmd)) {
 		WARN_ON(1);
-		pr_warn("fixmap btmap start [%08lx] != end [%08lx]\n",
+		pr_warn("fixmap btmap start [" PTE_FMT "] != end [" PTE_FMT "]\n",
 			pmd_val(fix_bmap_spmd), pmd_val(fix_bmap_epmd));
 		pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
 			fix_to_virt(FIX_BTMAP_BEGIN));
@@ -1336,7 +1357,7 @@ static void __init create_linear_mapping_page_table(void)
 static void __init setup_vm_final(void)
 {
 	/* Setup swapper PGD for fixmap */
-#if !defined(CONFIG_64BIT)
+#if CONFIG_PGTABLE_LEVELS == 2
 	/*
 	 * In 32-bit, the device tree lies in a pgd entry, so it must be copied
 	 * directly in swapper_pg_dir in addition to the pgd entry that points
@@ -1354,7 +1375,7 @@ static void __init setup_vm_final(void)
 	create_linear_mapping_page_table();
 
 	/* Map the kernel */
-	if (IS_ENABLED(CONFIG_64BIT))
+	if (CONFIG_PGTABLE_LEVELS > 2)
 		create_kernel_page_table(swapper_pg_dir, false);
 
 #ifdef CONFIG_KASAN
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index d815448758a1..45927f713cb9 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -15,10 +15,10 @@ struct pageattr_masks {
 	pgprot_t clear_mask;
 };
 
-static unsigned long set_pageattr_masks(unsigned long val, struct mm_walk *walk)
+static unsigned long set_pageattr_masks(ptval_t val, struct mm_walk *walk)
 {
 	struct pageattr_masks *masks = walk->private;
-	unsigned long new_val = val;
+	ptval_t new_val = val;
 
 	new_val &= ~(pgprot_val(masks->clear_mask));
 	new_val |= (pgprot_val(masks->set_mask));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 4ae67324f992..564679b4c48e 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -37,7 +37,7 @@ int ptep_test_and_clear_young(struct vm_area_struct *vma,
 {
 	if (!pte_young(ptep_get(ptep)))
 		return 0;
-	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep));
+	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, (unsigned long *)&pte_val(*ptep));
 }
 EXPORT_SYMBOL_GPL(ptep_test_and_clear_young);
 
-- 
2.40.1


