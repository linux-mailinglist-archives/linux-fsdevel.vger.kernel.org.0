Return-Path: <linux-fsdevel+bounces-67291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C802AC3AB3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 12:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0963B1A4775D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 11:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738531A7FA;
	Thu,  6 Nov 2025 11:50:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB73195FB;
	Thu,  6 Nov 2025 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429814; cv=none; b=kqQ0pausPLIp2rUhDBorGm7iP8eHunoJRuUJmc7N8gGiLeCmGt/x/yyJVI6Z8/pi6D9ptMoKTBoSEexGhAUjvLnQbZQhqgsD9faWfLx80ulYdUqmH3V5yOYapcrMLWS+mJGVI55XTJNs0/KdzoOYsvXXy0y3e3uYy4BgwBOBeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429814; c=relaxed/simple;
	bh=Im9UZffnD6V0KfkjwdG+DCiJql6cfGfj6sEhY/Erl40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnifTKMcpp7dXZy4WsKleCtYxYqWj8S7K2nN4hmr1p5zHORNb/pL4QELV1Jaisa7tfCubAqVCW5n3C0V3u8phR2TCY7sX/PLVOr0HuQKW8FGa+Fp0pRWEFj2pFdKZdGPC8KSCph9Poc9d5pDxRQJCjXdN79brTwxrDyAfjYIY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d2KmV0yffz9sSs;
	Thu,  6 Nov 2025 12:32:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1nW23pXeJc1z; Thu,  6 Nov 2025 12:32:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d2KmN0dwfz9sSm;
	Thu,  6 Nov 2025 12:32:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F27D38B77E;
	Thu,  6 Nov 2025 12:32:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id aCVQquw64jeA; Thu,  6 Nov 2025 12:32:19 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A1EA8B773;
	Thu,  6 Nov 2025 12:32:19 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Andre Almeida" <andrealmeid@igalia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 09/10] powerpc/32: Automatically adapt TASK_SIZE based on constraints
Date: Thu,  6 Nov 2025 12:31:27 +0100
Message-ID: <bf7eea8abe68826424eb5cdc73596b881ef2523b.1762427933.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1762427933.git.christophe.leroy@csgroup.eu>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6170; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=Im9UZffnD6V0KfkjwdG+DCiJql6cfGfj6sEhY/Erl40=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTytGufSjN8YPOiI6rmU7zZb61+yz+nMuR/19d6hi36f mXq1X/cHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAiW8wZGb6Gnd6h8TPC2rgo cKLR47jFHLenPVje7Gs10abnf9mC9bwM/8zsZXu+5XC6SQsyC8tu1/ngfX966yfn1+oLvzXVVzz ZygwA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

At the time being, TASK_SIZE can be customized by the user via Kconfig
but it is not possible to check all constraints in Kconfig. Impossible
setups are detected at compile time with BUILD_BUG() but that leads
to build failure when setting crazy values. It is not a problem on its
own because the user will usually either use the default value or set
a well thought value. However build robots generate crazy random
configs that lead to build failures, and build robots see it as a
regression every time a patch adds such a constraint.

So instead of failing the build when the custom TASK_SIZE is too
big, just adjust it to the maximum possible value matching the setup.

Several architectures already calculate TASK_SIZE based on other
parameters and options.

In order to do so, move MODULES_VADDR calculation into task_size_32.h
and ensure that:
- On book3s/32, userspace and module area have their own segments (256M)
- On 8xx, userspace has its own full PGDIR entries (4M)

Then TASK_SIZE is guaranteed to be correct so remove related
BUILD_BUG()s.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                         |  3 +--
 arch/powerpc/include/asm/book3s/32/pgtable.h |  4 ---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  4 ---
 arch/powerpc/include/asm/task_size_32.h      | 26 ++++++++++++++++++++
 arch/powerpc/mm/book3s32/mmu.c               |  2 --
 arch/powerpc/mm/mem.c                        |  2 --
 arch/powerpc/mm/nohash/8xx.c                 |  2 --
 7 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e24f4d88885ae..10a8d4a5fea1f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1292,9 +1292,8 @@ config TASK_SIZE_BOOL
 	  Say N here unless you know what you are doing.
 
 config TASK_SIZE
-	hex "Size of user task space" if TASK_SIZE_BOOL
+	hex "Size of maximum user task space" if TASK_SIZE_BOOL
 	default "0x80000000" if PPC_8xx
-	default "0xb0000000" if PPC_BOOK3S_32 && EXECMEM
 	default "0xc0000000"
 
 config MODULES_SIZE_BOOL
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 87dcca962be78..41ae404d0b7a6 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -195,10 +195,6 @@ void unmap_kernel_page(unsigned long va);
 #define VMALLOC_END	ioremap_bot
 #endif
 
-#define MODULES_END	ALIGN_DOWN(PAGE_OFFSET, SZ_256M)
-#define MODULES_SIZE	(CONFIG_MODULES_SIZE * SZ_1M)
-#define MODULES_VADDR	(MODULES_END - MODULES_SIZE)
-
 #ifndef __ASSEMBLER__
 #include <linux/sched.h>
 #include <linux/threads.h>
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index f19115db8072f..74ad32e1588cf 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -170,10 +170,6 @@
 
 #define mmu_linear_psize	MMU_PAGE_8M
 
-#define MODULES_END	PAGE_OFFSET
-#define MODULES_SIZE	(CONFIG_MODULES_SIZE * SZ_1M)
-#define MODULES_VADDR	(MODULES_END - MODULES_SIZE)
-
 #ifndef __ASSEMBLER__
 
 #include <linux/mmdebug.h>
diff --git a/arch/powerpc/include/asm/task_size_32.h b/arch/powerpc/include/asm/task_size_32.h
index 30edc21f71fbd..42a64bbd1964f 100644
--- a/arch/powerpc/include/asm/task_size_32.h
+++ b/arch/powerpc/include/asm/task_size_32.h
@@ -2,11 +2,37 @@
 #ifndef _ASM_POWERPC_TASK_SIZE_32_H
 #define _ASM_POWERPC_TASK_SIZE_32_H
 
+#include <linux/sizes.h>
+
 #if CONFIG_TASK_SIZE > CONFIG_KERNEL_START
 #error User TASK_SIZE overlaps with KERNEL_START address
 #endif
 
+#ifdef CONFIG_PPC_8xx
+#define MODULES_END	ASM_CONST(CONFIG_PAGE_OFFSET)
+#define MODULES_SIZE	(CONFIG_MODULES_SIZE * SZ_1M)
+#define MODULES_VADDR	(MODULES_END - MODULES_SIZE)
+#define MODULES_BASE	(MODULES_VADDR & ~(UL(SZ_4M) - 1))
+#define USER_TOP	MODULES_BASE
+#endif
+
+#ifdef CONFIG_PPC_BOOK3S_32
+#define MODULES_END	(ASM_CONST(CONFIG_PAGE_OFFSET) & ~(UL(SZ_256M) - 1))
+#define MODULES_SIZE	(CONFIG_MODULES_SIZE * SZ_1M)
+#define MODULES_VADDR	(MODULES_END - MODULES_SIZE)
+#define MODULES_BASE	(MODULES_VADDR & ~(UL(SZ_256M) - 1))
+#define USER_TOP	MODULES_BASE
+#endif
+
+#ifndef USER_TOP
+#define USER_TOP	ASM_CONST(CONFIG_PAGE_OFFSET)
+#endif
+
+#if CONFIG_TASK_SIZE < USER_TOP
 #define TASK_SIZE ASM_CONST(CONFIG_TASK_SIZE)
+#else
+#define TASK_SIZE USER_TOP
+#endif
 
 /*
  * This decides where the kernel will search for a free chunk of vm space during
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 37eefc6786a72..07660e8badbda 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -223,8 +223,6 @@ int mmu_mark_initmem_nx(void)
 
 	update_bats();
 
-	BUILD_BUG_ON(ALIGN_DOWN(MODULES_VADDR, SZ_256M) < TASK_SIZE);
-
 	for (i = ALIGN(TASK_SIZE, SZ_256M) >> 28; i < 16; i++) {
 		/* Do not set NX on VM space for modules */
 		if (is_module_segment(i << 28))
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 3ddbfdbfa9413..bc0f1a9eb0bc0 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -401,8 +401,6 @@ struct execmem_info __init *execmem_arch_setup(void)
 #ifdef MODULES_VADDR
 	unsigned long limit = (unsigned long)_etext - SZ_32M;
 
-	BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
-
 	/* First try within 32M limit from _etext to avoid branch trampolines */
 	if (MODULES_VADDR < PAGE_OFFSET && MODULES_END > limit) {
 		start = limit;
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index ab1505cf42bf5..a9d3f4729eada 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -209,8 +209,6 @@ void __init setup_initial_memory_limit(phys_addr_t first_memblock_base,
 
 	/* 8xx can only access 32MB at the moment */
 	memblock_set_current_limit(min_t(u64, first_memblock_size, SZ_32M));
-
-	BUILD_BUG_ON(ALIGN_DOWN(MODULES_VADDR, PGDIR_SIZE) < TASK_SIZE);
 }
 
 int pud_clear_huge(pud_t *pud)
-- 
2.49.0


