Return-Path: <linux-fsdevel+bounces-28073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD3966651
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBA81C24320
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5511BAEED;
	Fri, 30 Aug 2024 15:57:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C61B81CB;
	Fri, 30 Aug 2024 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033469; cv=none; b=LKfoKmRnb8SeSJVutKKAJC37QcUX20U8O8bBho2HC17Yktli+jNgkiA+2DU12HaFIuZ5BhWkKI2nzghooh+FarONtLL+sToFTc0dpOuVgjE/R8hboS3GOWEYfBjnzSa1MIMDPyWvk2J3OHxm+B8w+qmyg+mOqTZTYizRVOsP17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033469; c=relaxed/simple;
	bh=RZqSySqYFylmyuA5iRHusRb2CMpC6wGsXem6AUNbLuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6XEe2EMK6GJv01QDy0rrLxYVS1hoh4X53L2RQjUQVBiWSlctqy55oDHjkYkd/G5snT+yJp3pK5AvWK7wRk76Qo8GIExkvk0/iJjrVn1d7Op8Ekt0wS6QCG27xxfEShv7Uu/89S3LAI6pKkS7EE5rhluB+wnsEmYl+CqHb9H5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WwN820xV8z9sSS;
	Fri, 30 Aug 2024 17:57:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9BHKF7MYlO9x; Fri, 30 Aug 2024 17:57:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WwN816PBbz9sS7;
	Fri, 30 Aug 2024 17:57:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C6DEA8B764;
	Fri, 30 Aug 2024 17:57:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id uAS6-PSNHXJa; Fri, 30 Aug 2024 17:57:21 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C196F8B794;
	Fri, 30 Aug 2024 17:57:20 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <shuah@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v3 5/5] powerpc/vdso: Wire up getrandom() vDSO implementation on PPC64
Date: Fri, 30 Aug 2024 17:57:09 +0200
Message-ID: <8dacc4e43ca17ff5394474a38faf3d1ed04f1fe3.1725031952.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1725031952.git.christophe.leroy@csgroup.eu>
References: <cover.1725031952.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725033425; l=8227; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=RZqSySqYFylmyuA5iRHusRb2CMpC6wGsXem6AUNbLuM=; b=Q9SndYRLYnz+rNPgHPdAY1Q+AbqC22AyVLkdSzp8bpb0Yac03csS5glWQQ8l4Gs2G4Bzqnsah ijB2x73ukGrB9RVsjFHt49/QhhNSST/8oUlPNWjD5tn1AQUF4B7gX6v
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Extend getrandom() vDSO implementation to powerpc64.

Tested on QEMU on both ppc64_defconfig and ppc64le_defconfig.

The results are not precise as it is QEMU on an x86 laptop, but
no need to be precise to see the benefit.

~ # ./vdso_test_getrandom bench-single
   vdso: 25000000 times in 4.977777162 seconds
   libc: 25000000 times in 75.516749981 seconds
syscall: 25000000 times in 86.842242014 seconds

~ # ./vdso_test_getrandom bench-single
   vdso: 25000000 times in 6.473814156 seconds
   libc: 25000000 times in 73.875109463 seconds
syscall: 25000000 times in 71.805066229 seconds

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: New (split out of previous patch)
---
 arch/powerpc/Kconfig                         |  2 +-
 arch/powerpc/include/asm/mman.h              |  2 +-
 arch/powerpc/kernel/vdso/Makefile            | 10 +-
 arch/powerpc/kernel/vdso/getrandom.S         |  8 ++
 arch/powerpc/kernel/vdso/vdso64.lds.S        |  1 +
 arch/powerpc/kernel/vdso/vgetrandom-chacha.S | 98 ++++++++++++++++++++
 6 files changed, 116 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 54b270ef18b1..b45452ac4a73 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -311,7 +311,7 @@ config PPC
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
-	select VDSO_GETRANDOM			if PPC32
+	select VDSO_GETRANDOM
 	#
 	# Please keep this list sorted alphabetically.
 	#
diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 17a77d47ed6d..42a51a993d94 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -6,7 +6,7 @@
 
 #include <uapi/asm/mman.h>
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) && !defined(BUILD_VDSO)
 
 #include <asm/cputable.h>
 #include <linux/mm.h>
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index fa0b9b3b51af..56fb1633529a 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -9,6 +9,7 @@ obj-vdso32 = sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32.o not
 obj-vdso64 = sigtramp64-64.o gettimeofday-64.o datapage-64.o cacheflush-64.o note-64.o getcpu-64.o
 
 obj-vdso32 += getrandom-32.o vgetrandom-chacha-32.o
+obj-vdso64 += getrandom-64.o vgetrandom-chacha-64.o
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-32.o += -include $(c-gettimeofday-y)
@@ -21,6 +22,7 @@ endif
 
 ifneq ($(c-getrandom-y),)
   CFLAGS_vgetrandom-32.o += -include $(c-getrandom-y)
+  CFLAGS_vgetrandom-64.o += -include $(c-getrandom-y) $(call cc-option, -ffixed-r30)
 endif
 
 # Build rules
@@ -34,10 +36,10 @@ endif
 targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o vgetrandom-32.o
 targets += crtsavres-32.o
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
-targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o
+targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o vgetrandom-64.o
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 
-ccflags-y := -fno-common -fno-builtin
+ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO
 ccflags-y += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 ccflags-y += $(call cc-option, -fno-stack-protector)
 ccflags-y += -DDISABLE_BRANCH_PROFILING
@@ -71,7 +73,7 @@ CPPFLAGS_vdso64.lds += -P -C
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
 	$(call if_changed,vdso32ld_and_check)
-$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o FORCE
 	$(call if_changed,vdso64ld_and_check)
 
 # assembly rules for the .S files
@@ -87,6 +89,8 @@ $(obj-vdso64): %-64.o: %.S FORCE
 	$(call if_changed_dep,vdso64as)
 $(obj)/vgettimeofday-64.o: %-64.o: %.c FORCE
 	$(call if_changed_dep,cc_o_c)
+$(obj)/vgetrandom-64.o: %-64.o: %.c FORCE
+	$(call if_changed_dep,cc_o_c)
 
 # Generate VDSO offsets using helper script
 gen-vdso32sym := $(src)/gen_vdso32_offsets.sh
diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
index 21773ef3fc1d..a957cd2b2b03 100644
--- a/arch/powerpc/kernel/vdso/getrandom.S
+++ b/arch/powerpc/kernel/vdso/getrandom.S
@@ -27,10 +27,18 @@
   .cfi_adjust_cfa_offset PPC_MIN_STKFRM
 	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
   .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
+#ifdef __powerpc64__
+	PPC_STL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
+  .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
+#endif
 	get_datapage	r8
 	addi		r8, r8, VDSO_RNG_DATA_OFFSET
 	bl		CFUNC(DOTSYM(\funct))
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
+#ifdef __powerpc64__
+	PPC_LL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
+  .cfi_restore r2
+#endif
 	cmpwi		r3, 0
 	mtlr		r0
 	addi		r1, r1, 2 * PPC_MIN_STKFRM
diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso/vdso64.lds.S
index 400819258c06..9481e4b892ed 100644
--- a/arch/powerpc/kernel/vdso/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
@@ -123,6 +123,7 @@ VERSION
 		__kernel_sigtramp_rt64;
 		__kernel_getcpu;
 		__kernel_time;
+		__kernel_getrandom;
 
 	local: *;
 	};
diff --git a/arch/powerpc/kernel/vdso/vgetrandom-chacha.S b/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
index a3475b9e8c10..c9d4c5b38242 100644
--- a/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
+++ b/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
@@ -79,12 +79,59 @@
  *	r16-r31: state
  */
 SYM_FUNC_START(__arch_chacha20_blocks_nostack)
+#ifdef __powerpc64__
+	std	r5, -216(r1)
+
+	std	r14, -144(r1)
+	std	r15, -136(r1)
+	std	r16, -128(r1)
+	std	r17, -120(r1)
+	std	r18, -112(r1)
+	std	r19, -104(r1)
+	std	r20, -96(r1)
+	std	r21, -88(r1)
+	std	r22, -80(r1)
+	std	r23, -72(r1)
+	std	r24, -64(r1)
+	std	r25, -56(r1)
+	std	r26, -48(r1)
+	std	r27, -40(r1)
+	std	r28, -32(r1)
+	std	r29, -24(r1)
+	std	r30, -16(r1)
+	std	r31, -8(r1)
+#else
 	stwu	r1, -96(r1)
 	stw	r5, 20(r1)
+#if defined(CONFIG_CPU_BIG_ENDIAN)
 	stmw	r14, 24(r1)
+#else
+	stw	r14, 24(r1)
+	stw	r15, 28(r1)
+	stw	r16, 32(r1)
+	stw	r17, 36(r1)
+	stw	r18, 40(r1)
+	stw	r19, 44(r1)
+	stw	r20, 48(r1)
+	stw	r21, 52(r1)
+	stw	r22, 56(r1)
+	stw	r23, 60(r1)
+	stw	r24, 64(r1)
+	stw	r25, 68(r1)
+	stw	r26, 72(r1)
+	stw	r27, 76(r1)
+	stw	r28, 80(r1)
+	stw	r29, 84(r1)
+	stw	r30, 88(r1)
+	stw	r31, 92(r1)
+#endif
+#endif
 	li	r31, 4
 	LWZX_LE	r14, 0, r5
 	LWZX_LE	r15, r31, r5
+#ifdef __powerpc64__
+	rldimi	r14, r15, 32, 0
+#endif
 	mr	r0, r6
 
 	lwz	r5, 0(r4)
@@ -177,13 +224,22 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
 	STWX_LE	r31, r4, r3
 	addi	r3, r3, 8
 
+#ifdef __powerpc64__
+	addi	r14, r14, 1
+	srdi	r15, r14, 32
+#else
 	addic	r14, r14, 1
 	addze	r15, r15
+#endif
 
 	subic.	r0, r0, 1	/* subi. can't use r0 as source */
 	bne	.Lblock
 
+#ifdef __powerpc64__
+	ld	r5, -216(r1)
+#else
 	lwz	r5, 20(r1)
+#endif
 	STWX_LE	r14, 0, r5
 	STWX_LE	r15, r4, r5
 
@@ -195,7 +251,49 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
 	li	r11, 0
 	li	r12, 0
 
+#ifdef __powerpc64__
+	ld	r14, -144(r1)
+	ld	r15, -136(r1)
+	ld	r16, -128(r1)
+	ld	r17, -120(r1)
+	ld	r18, -112(r1)
+	ld	r19, -104(r1)
+	ld	r20, -96(r1)
+	ld	r21, -88(r1)
+	ld	r22, -80(r1)
+	ld	r23, -72(r1)
+	ld	r24, -64(r1)
+	ld	r25, -56(r1)
+	ld	r26, -48(r1)
+	ld	r27, -40(r1)
+	ld	r28, -32(r1)
+	ld	r29, -24(r1)
+	ld	r30, -16(r1)
+	ld	r31, -8(r1)
+#else
+#if defined(CONFIG_CPU_BIG_ENDIAN)
 	lmw	r14, 24(r1)
+#else
+	lwz	r14, 24(r1)
+	lwz	r15, 28(r1)
+	lwz	r16, 32(r1)
+	lwz	r17, 36(r1)
+	lwz	r18, 40(r1)
+	lwz	r19, 44(r1)
+	lwz	r20, 48(r1)
+	lwz	r21, 52(r1)
+	lwz	r22, 56(r1)
+	lwz	r23, 60(r1)
+	lwz	r24, 64(r1)
+	lwz	r25, 68(r1)
+	lwz	r26, 72(r1)
+	lwz	r27, 76(r1)
+	lwz	r28, 80(r1)
+	lwz	r29, 84(r1)
+	lwz	r30, 88(r1)
+	lwz	r31, 92(r1)
+#endif
 	addi	r1, r1, 96
+#endif
 	blr
 SYM_FUNC_END(__arch_chacha20_blocks_nostack)
-- 
2.44.0


