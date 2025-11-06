Return-Path: <linux-fsdevel+bounces-67290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C5DC3AB32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1A11A43216
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04304318139;
	Thu,  6 Nov 2025 11:50:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D2F2E8B8D;
	Thu,  6 Nov 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429809; cv=none; b=CEDxp/+DTz7FKLGMvFV3LUPTcPHATfhWX4csJ6F7SkkpugOmLEJAZl0zVFRgkknRtUgkEcLLy/QBIgANn1BUpTrvBjVweeS2D9r60ik/6fPi0X0ATfGOm9oin1lGAsoCLtkd4Lsr654qO9ZUhLBQwUAG7E8cLR5E3eOJnLygo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429809; c=relaxed/simple;
	bh=zuDbabfiUqTOLj4mSt5xh9aoc6FtrRisXd/DqchyYms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieJYoA36PDjKjl35b9G2uacDF5L6wEF2dSmw9P9L3nqxQHQBkK0ayBqQEpBxemacT4eHGYfivYKFbdsviZ0QCEMUDNyiRbO3e+QoNOsNviBIxwss7okcw7Ud2bl2yH/J+beQRjS/444bTi5xz+5f+rS9c9exg92TFgtKlj+dMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d2KmT0ydhz9sSr;
	Thu,  6 Nov 2025 12:32:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bllwWZEb595W; Thu,  6 Nov 2025 12:32:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d2KmM2TD3z9sSb;
	Thu,  6 Nov 2025 12:32:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 39C2A8B77E;
	Thu,  6 Nov 2025 12:32:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Rm11CGVHqN3L; Thu,  6 Nov 2025 12:32:19 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FF3E8B77B;
	Thu,  6 Nov 2025 12:32:18 +0100 (CET)
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
Subject: [PATCH v4 08/10] powerpc/32s: Fix segments setup when TASK_SIZE is not a multiple of 256M
Date: Thu,  6 Nov 2025 12:31:26 +0100
Message-ID: <7d9f082fcf743b91abf9530902ddc9b050b8c6d1.1762427933.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1762427933.git.christophe.leroy@csgroup.eu>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4823; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=zuDbabfiUqTOLj4mSt5xh9aoc6FtrRisXd/DqchyYms=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTytGs3valleN7uUpOxZP0twUuf2Vbv8lvUsFLgiLwTB /f+3svOHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAi0raMDCduZDiHHQtrCns2 52DKVaHJjpHCG5ZK7/mis8Tm6ky71jSGfzYRWfJf9zJcf2Ox8zF/mNSsPwnXl5yu4Dvyf+P1zZ6 iMhwA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

For book3s/32 it is assumed that TASK_SIZE is a multiple of 256 Mbytes,
but Kconfig allows any value for TASK_SIZE.

In all relevant calculations, align TASK_SIZE to the upper 256 Mbytes
boundary.

Also use ASM_CONST() in the definition of TASK_SIZE to ensure it is
seen as an unsigned constant.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h | 5 ++++-
 arch/powerpc/include/asm/task_size_32.h       | 2 +-
 arch/powerpc/kernel/asm-offsets.c             | 2 +-
 arch/powerpc/kernel/head_book3s_32.S          | 6 +++---
 arch/powerpc/mm/book3s32/mmu.c                | 2 +-
 arch/powerpc/mm/ptdump/segment_regs.c         | 2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 8435bf3cdabfa..387d370c8a358 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -192,12 +192,15 @@ extern s32 patch__hash_page_B, patch__hash_page_C;
 extern s32 patch__flush_hash_A0, patch__flush_hash_A1, patch__flush_hash_A2;
 extern s32 patch__flush_hash_B;
 
+#include <linux/sizes.h>
+#include <linux/align.h>
+
 #include <asm/reg.h>
 #include <asm/task_size_32.h>
 
 static __always_inline void update_user_segment(u32 n, u32 val)
 {
-	if (n << 28 < TASK_SIZE)
+	if (n << 28 < ALIGN(TASK_SIZE, SZ_256M))
 		mtsr(val + n * 0x111, n << 28);
 }
 
diff --git a/arch/powerpc/include/asm/task_size_32.h b/arch/powerpc/include/asm/task_size_32.h
index de7290ee770fb..30edc21f71fbd 100644
--- a/arch/powerpc/include/asm/task_size_32.h
+++ b/arch/powerpc/include/asm/task_size_32.h
@@ -6,7 +6,7 @@
 #error User TASK_SIZE overlaps with KERNEL_START address
 #endif
 
-#define TASK_SIZE (CONFIG_TASK_SIZE)
+#define TASK_SIZE ASM_CONST(CONFIG_TASK_SIZE)
 
 /*
  * This decides where the kernel will search for a free chunk of vm space during
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index a4bc80b30410a..46149f326fd42 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -331,7 +331,7 @@ int main(void)
 
 #ifndef CONFIG_PPC64
 	DEFINE(TASK_SIZE, TASK_SIZE);
-	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28);
+	DEFINE(NUM_USER_SEGMENTS, ALIGN(TASK_SIZE, SZ_256M) >> 28);
 #endif /* ! CONFIG_PPC64 */
 
 	/* datapage offsets for use by vdso */
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index cb2bca76be535..c1779455ea32f 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -420,7 +420,7 @@ InstructionTLBMiss:
 	lwz	r2,0(r2)		/* get pmd entry */
 #ifdef CONFIG_EXECMEM
 	rlwinm	r3, r0, 4, 0xf
-	subi	r3, r3, (TASK_SIZE >> 28) & 0xf
+	subi	r3, r3, NUM_USER_SEGMENTS
 #endif
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	InstructionAddressInvalid	/* return if no mapping */
@@ -475,7 +475,7 @@ DataLoadTLBMiss:
 	lwz	r2,0(r1)		/* get pmd entry */
 	rlwinm	r3, r0, 4, 0xf
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
-	subi	r3, r3, (TASK_SIZE >> 28) & 0xf
+	subi	r3, r3, NUM_USER_SEGMENTS
 	beq-	2f			/* bail if no mapping */
 1:	rlwimi	r2,r0,22,20,29		/* insert next 10 bits of address */
 	lwz	r2,0(r2)		/* get linux-style pte */
@@ -554,7 +554,7 @@ DataStoreTLBMiss:
 	lwz	r2,0(r1)		/* get pmd entry */
 	rlwinm	r3, r0, 4, 0xf
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
-	subi	r3, r3, (TASK_SIZE >> 28) & 0xf
+	subi	r3, r3, NUM_USER_SEGMENTS
 	beq-	2f			/* bail if no mapping */
 1:
 	rlwimi	r2,r0,22,20,29		/* insert next 10 bits of address */
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index c42ecdf94e48c..37eefc6786a72 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -225,7 +225,7 @@ int mmu_mark_initmem_nx(void)
 
 	BUILD_BUG_ON(ALIGN_DOWN(MODULES_VADDR, SZ_256M) < TASK_SIZE);
 
-	for (i = TASK_SIZE >> 28; i < 16; i++) {
+	for (i = ALIGN(TASK_SIZE, SZ_256M) >> 28; i < 16; i++) {
 		/* Do not set NX on VM space for modules */
 		if (is_module_segment(i << 28))
 			continue;
diff --git a/arch/powerpc/mm/ptdump/segment_regs.c b/arch/powerpc/mm/ptdump/segment_regs.c
index 9df3af8d481f1..c06704b18a2c8 100644
--- a/arch/powerpc/mm/ptdump/segment_regs.c
+++ b/arch/powerpc/mm/ptdump/segment_regs.c
@@ -31,7 +31,7 @@ static int sr_show(struct seq_file *m, void *v)
 	int i;
 
 	seq_puts(m, "---[ User Segments ]---\n");
-	for (i = 0; i < TASK_SIZE >> 28; i++)
+	for (i = 0; i < ALIGN(TASK_SIZE, SZ_256M) >> 28; i++)
 		seg_show(m, i);
 
 	seq_puts(m, "\n---[ Kernel Segments ]---\n");
-- 
2.49.0


