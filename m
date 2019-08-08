Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2AC85ADA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 08:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfHHGcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 02:32:21 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49557 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHGcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:32:21 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B4C8060004;
        Thu,  8 Aug 2019 06:32:14 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v6 13/14] mips: Use generic mmap top-down layout and brk randomization
Date:   Thu,  8 Aug 2019 02:17:55 -0400
Message-Id: <20190808061756.19712-14-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808061756.19712-1-alex@ghiti.fr>
References: <20190808061756.19712-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mips uses a top-down layout by default that exactly fits the generic
functions, so get rid of arch specific code and use the generic version
by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.

As ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT selects ARCH_HAS_ELF_RANDOMIZE,
use the generic version of arch_randomize_brk since it also fits.

Note that this commit also removes the possibility for mips to have elf
randomization and no MMU: without MMU, the security added by randomization
is worth nothing.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Acked-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/mips/Kconfig                 |  2 +-
 arch/mips/include/asm/processor.h |  5 --
 arch/mips/mm/mmap.c               | 96 -------------------------------
 3 files changed, 1 insertion(+), 102 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d50fafd7bf3a..4e85d7d2cf1a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -5,7 +5,6 @@ config MIPS
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_CLOCKSOURCE_DATA
-	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_SUPPORTS_UPROBES
@@ -13,6 +12,7 @@ config MIPS
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index aca909bd7841..fba18d4a9190 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -29,11 +29,6 @@
 
 extern unsigned int vced_count, vcei_count;
 
-/*
- * MIPS does have an arch_pick_mmap_layout()
- */
-#define HAVE_ARCH_PICK_MMAP_LAYOUT 1
-
 #ifdef CONFIG_32BIT
 #ifdef CONFIG_KVM_GUEST
 /* User space process size is limited to 1GB in KVM Guest Mode */
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index d5106c26ac6a..00fe90c6db3e 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -16,49 +16,10 @@
 #include <linux/random.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
-#include <linux/sizes.h>
-#include <linux/compat.h>
 
 unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
 EXPORT_SYMBOL(shm_align_mask);
 
-/* gap between mmap and stack */
-#define MIN_GAP		(128*1024*1024UL)
-#define MAX_GAP		((STACK_TOP)/6*5)
-#define STACK_RND_MASK	(0x7ff >> (PAGE_SHIFT - 12))
-
-static int mmap_is_legacy(struct rlimit *rlim_stack)
-{
-	if (current->personality & ADDR_COMPAT_LAYOUT)
-		return 1;
-
-	if (rlim_stack->rlim_cur == RLIM_INFINITY)
-		return 1;
-
-	return sysctl_legacy_va_layout;
-}
-
-static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
-{
-	unsigned long gap = rlim_stack->rlim_cur;
-	unsigned long pad = stack_guard_gap;
-
-	/* Account for stack randomization if necessary */
-	if (current->flags & PF_RANDOMIZE)
-		pad += (STACK_RND_MASK << PAGE_SHIFT);
-
-	/* Values close to RLIM_INFINITY can overflow. */
-	if (gap + pad > gap)
-		gap += pad;
-
-	if (gap < MIN_GAP)
-		gap = MIN_GAP;
-	else if (gap > MAX_GAP)
-		gap = MAX_GAP;
-
-	return PAGE_ALIGN(STACK_TOP - gap - rnd);
-}
-
 #define COLOUR_ALIGN(addr, pgoff)				\
 	((((addr) + shm_align_mask) & ~shm_align_mask) +	\
 	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
@@ -156,63 +117,6 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 			addr0, len, pgoff, flags, DOWN);
 }
 
-unsigned long arch_mmap_rnd(void)
-{
-	unsigned long rnd;
-
-#ifdef CONFIG_COMPAT
-	if (TASK_IS_32BIT_ADDR)
-		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
-	else
-#endif /* CONFIG_COMPAT */
-		rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
-
-	return rnd << PAGE_SHIFT;
-}
-
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
-{
-	unsigned long random_factor = 0UL;
-
-	if (current->flags & PF_RANDOMIZE)
-		random_factor = arch_mmap_rnd();
-
-	if (mmap_is_legacy(rlim_stack)) {
-		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-		mm->get_unmapped_area = arch_get_unmapped_area;
-	} else {
-		mm->mmap_base = mmap_base(random_factor, rlim_stack);
-		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
-	}
-}
-
-static inline unsigned long brk_rnd(void)
-{
-	unsigned long rnd = get_random_long();
-
-	rnd = rnd << PAGE_SHIFT;
-	/* 32MB for 32bit, 1GB for 64bit */
-	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
-		rnd = rnd & (SZ_32M - 1);
-	else
-		rnd = rnd & (SZ_1G - 1);
-
-	return rnd;
-}
-
-unsigned long arch_randomize_brk(struct mm_struct *mm)
-{
-	unsigned long base = mm->brk;
-	unsigned long ret;
-
-	ret = PAGE_ALIGN(base + brk_rnd());
-
-	if (ret < mm->brk)
-		return mm->brk;
-
-	return ret;
-}
-
 bool __virt_addr_valid(const volatile void *kaddr)
 {
 	unsigned long vaddr = (unsigned long)kaddr;
-- 
2.20.1

