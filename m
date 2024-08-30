Return-Path: <linux-fsdevel+bounces-28072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CDC96664E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB260B23E0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A8E1BA87D;
	Fri, 30 Aug 2024 15:57:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323011B790F;
	Fri, 30 Aug 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033465; cv=none; b=CqvTkGUEcv0Fu0Ifr0ylAPvN3A5kcmID9Q4V8Bf4aAYz3GxKHJwUnPHDgWefdMCTLP6xrMKoyJF4BXgivztoz5iEoQjKXzHx/9Uw2BgdHHmc7e+gkS6SOnJLXI9PSRl/nWLUQ2BAqBxn55dDoImsU5d3oqu5ibqQ0D+WfjziaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033465; c=relaxed/simple;
	bh=0w4ulQ4gcMEsE3ThfrWB+nL+4Z0DOw2p7OgH3/0aDS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWZORBnJWOfSu2i0mZef7wTkrrLAWssfu2ypKvD/PlMGS0JsjgqBY++e/gPWXM7uK/mYaT2vm1zuMSypVxWvSFIvJ7y7WumYLKCBXg3YRVu9+/p/zgu9hEj/c7ubma7llo0HGenS+PoOlfChSz08RBGXouHLZ4YthaJMAxBtdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WwN811cC2z9sSN;
	Fri, 30 Aug 2024 17:57:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yYeX1GWSo-jT; Fri, 30 Aug 2024 17:57:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WwN806Jpqz9sS7;
	Fri, 30 Aug 2024 17:57:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C71B58B799;
	Fri, 30 Aug 2024 17:57:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id lxFQRnFVCPTN; Fri, 30 Aug 2024 17:57:20 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AC4EB8B764;
	Fri, 30 Aug 2024 17:57:19 +0200 (CEST)
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
Subject: [PATCH v3 4/5] powerpc/vdso: Wire up getrandom() vDSO implementation on PPC32
Date: Fri, 30 Aug 2024 17:57:08 +0200
Message-ID: <e7e4c6d36cf98229850c333f113bcea909564501.1725031952.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1725031952.git.christophe.leroy@csgroup.eu>
References: <cover.1725031952.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725033425; l=17568; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=0w4ulQ4gcMEsE3ThfrWB+nL+4Z0DOw2p7OgH3/0aDS8=; b=+ceKvNzluBV2XXdigcJSSvbEPCI9JXmj4O5C6yvL0o9Orct4EXswhhFAS0MNcMX53AK5sAH2t 94n4l5gdkI0AwMHGqWE0SOonwovMQ9+pG43JOUhc17SsUzns00vAMrD
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

To be consistent with other VDSO functions, the function is called
__kernel_getrandom()

__arch_chacha20_blocks_nostack() fonction is implemented basically
with 32 bits operations. It performs 4 QUARTERROUND operations in
parallele. There are enough registers to avoid using the stack:

On input:
	r3: output bytes
	r4: 32-byte key input
	r5: 8-byte counter input/output
	r6: number of 64-byte blocks to write to output

During operation:
	stack: pointer to counter (r5) and non-volatile registers (r14-131)
	r0: counter of blocks (initialised with r6)
	r4: Value '4' after key has been read, used for indexing
	r5-r12: key
	r14-r15: block counter
	r16-r31: chacha state

At the end:
	r0, r6-r12: Zeroised
	r5, r14-r31: Restored

Performance on powerpc 885 (using kernel selftest):
	~# ./vdso_test_getrandom bench-single
	   vdso: 25000000 times in 62.938002291 seconds
	   libc: 25000000 times in 535.581916866 seconds
	syscall: 25000000 times in 531.525042806 seconds

Performance on powerpc 8321 (using kernel selftest):
	~# ./vdso_test_getrandom bench-single
	   vdso: 25000000 times in 16.899318858 seconds
	   libc: 25000000 times in 131.050596522 seconds
	syscall: 25000000 times in 129.794790389 seconds

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3:
- Preserve r13, implies saving r5 on stack
- Split PPC64 implementation out.
---
 arch/powerpc/Kconfig                         |   1 +
 arch/powerpc/include/asm/asm-compat.h        |   8 +
 arch/powerpc/include/asm/vdso/getrandom.h    |  54 +++++
 arch/powerpc/include/asm/vdso/vsyscall.h     |   6 +
 arch/powerpc/include/asm/vdso_datapage.h     |   2 +
 arch/powerpc/kernel/asm-offsets.c            |   1 +
 arch/powerpc/kernel/vdso/Makefile            |  12 +-
 arch/powerpc/kernel/vdso/getrandom.S         |  50 +++++
 arch/powerpc/kernel/vdso/vdso32.lds.S        |   1 +
 arch/powerpc/kernel/vdso/vgetrandom-chacha.S | 201 +++++++++++++++++++
 arch/powerpc/kernel/vdso/vgetrandom.c        |  14 ++
 tools/arch/powerpc/vdso                      |   1 +
 tools/testing/selftests/vDSO/Makefile        |   4 +
 13 files changed, 353 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/getrandom.h
 create mode 100644 arch/powerpc/kernel/vdso/getrandom.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom-chacha.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom.c
 create mode 120000 tools/arch/powerpc/vdso

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d7b09b064a8a..54b270ef18b1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -311,6 +311,7 @@ config PPC
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
+	select VDSO_GETRANDOM			if PPC32
 	#
 	# Please keep this list sorted alphabetically.
 	#
diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index b0b209c1df50..cce8c31b1b33 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -59,4 +59,12 @@
 
 #endif
 
+#ifdef __BIG_ENDIAN__
+#define LWZX_LE	stringify_in_c(lwbrx)
+#define STWX_LE	stringify_in_c(stwbrx)
+#else
+#define LWZX_LE	stringify_in_c(lwzx)
+#define STWX_LE	stringify_in_c(stwx)
+#endif
+
 #endif /* _ASM_POWERPC_ASM_COMPAT_H */
diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
new file mode 100644
index 000000000000..501d6bb14e8a
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/getrandom.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, CS GROUP France
+ */
+#ifndef _ASM_POWERPC_VDSO_GETRANDOM_H
+#define _ASM_POWERPC_VDSO_GETRANDOM_H
+
+#ifndef __ASSEMBLY__
+
+static __always_inline int do_syscall_3(const unsigned long _r0, const unsigned long _r3,
+					const unsigned long _r4, const unsigned long _r5)
+{
+	register long r0 asm("r0") = _r0;
+	register unsigned long r3 asm("r3") = _r3;
+	register unsigned long r4 asm("r4") = _r4;
+	register unsigned long r5 asm("r5") = _r5;
+	register int ret asm ("r3");
+
+	asm volatile(
+		"       sc\n"
+		"	bns+	1f\n"
+		"	neg	%0, %0\n"
+		"1:\n"
+	: "=r" (ret), "+r" (r4), "+r" (r5), "+r" (r0)
+	: "r" (r3)
+	: "memory", "r6", "r7", "r8", "r9", "r10", "r11", "r12", "cr0", "ctr");
+
+	return ret;
+}
+
+/**
+ * getrandom_syscall - Invoke the getrandom() syscall.
+ * @buffer:	Destination buffer to fill with random bytes.
+ * @len:	Size of @buffer in bytes.
+ * @flags:	Zero or more GRND_* flags.
+ * Returns:	The number of bytes written to @buffer, or a negative value indicating an error.
+ */
+static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
+{
+	return do_syscall_3(__NR_getrandom, (unsigned long)buffer,
+			    (unsigned long)len, (unsigned long)flags);
+}
+
+static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
+{
+	return NULL;
+}
+
+ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
+			     size_t opaque_len, const struct vdso_rng_data *vd);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_VDSO_GETRANDOM_H */
diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/asm/vdso/vsyscall.h
index 48cf23f1e273..92f480d8cc6d 100644
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -17,6 +17,12 @@ struct vdso_data *__arch_get_k_vdso_data(void)
 }
 #define __arch_get_k_vdso_data __arch_get_k_vdso_data
 
+static __always_inline
+struct vdso_rng_data *__arch_get_k_vdso_rng_data(void)
+{
+	return &vdso_data->rng_data;
+}
+
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index a585c8e538ff..e17500c5237e 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -83,6 +83,7 @@ struct vdso_arch_data {
 	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
 
 	struct vdso_data data[CS_BASES];
+	struct vdso_rng_data rng_data;
 };
 
 #else /* CONFIG_PPC64 */
@@ -95,6 +96,7 @@ struct vdso_arch_data {
 	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
 	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
 	struct vdso_data data[CS_BASES];
+	struct vdso_rng_data rng_data;
 };
 
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 23733282de4d..eedb2e04c785 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -335,6 +335,7 @@ int main(void)
 
 	/* datapage offsets for use by vdso */
 	OFFSET(VDSO_DATA_OFFSET, vdso_arch_data, data);
+	OFFSET(VDSO_RNG_DATA_OFFSET, vdso_arch_data, rng_data);
 	OFFSET(CFG_TB_TICKS_PER_SEC, vdso_arch_data, tb_ticks_per_sec);
 #ifdef CONFIG_PPC64
 	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_arch_data, icache_block_size);
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 67fe79d26fae..fa0b9b3b51af 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -8,6 +8,8 @@ include $(srctree)/lib/vdso/Makefile
 obj-vdso32 = sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32.o note-32.o getcpu-32.o
 obj-vdso64 = sigtramp64-64.o gettimeofday-64.o datapage-64.o cacheflush-64.o note-64.o getcpu-64.o
 
+obj-vdso32 += getrandom-32.o vgetrandom-chacha-32.o
+
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-32.o += -include $(c-gettimeofday-y)
 # Go prior to 1.16.x assumes r30 is not clobbered by any VDSO code. That used to be true
@@ -17,6 +19,10 @@ ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-64.o += -include $(c-gettimeofday-y) $(call cc-option, -ffixed-r30)
 endif
 
+ifneq ($(c-getrandom-y),)
+  CFLAGS_vgetrandom-32.o += -include $(c-getrandom-y)
+endif
+
 # Build rules
 
 ifdef CROSS32_COMPILE
@@ -25,7 +31,7 @@ else
     VDSOCC := $(CC)
 endif
 
-targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o
+targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o vgetrandom-32.o
 targets += crtsavres-32.o
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
 targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o
@@ -63,7 +69,7 @@ targets += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/crtsavres-32.o FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
 	$(call if_changed,vdso32ld_and_check)
 $(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o FORCE
 	$(call if_changed,vdso64ld_and_check)
@@ -75,6 +81,8 @@ $(obj)/crtsavres-32.o: %-32.o: $(srctree)/arch/powerpc/lib/crtsavres.S FORCE
 	$(call if_changed_dep,vdso32as)
 $(obj)/vgettimeofday-32.o: %-32.o: %.c FORCE
 	$(call if_changed_dep,vdso32cc)
+$(obj)/vgetrandom-32.o: %-32.o: %.c FORCE
+	$(call if_changed_dep,vdso32cc)
 $(obj-vdso64): %-64.o: %.S FORCE
 	$(call if_changed_dep,vdso64as)
 $(obj)/vgettimeofday-64.o: %-64.o: %.c FORCE
diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
new file mode 100644
index 000000000000..21773ef3fc1d
--- /dev/null
+++ b/arch/powerpc/kernel/vdso/getrandom.S
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Userland implementation of getrandom() for processes
+ * for use in the vDSO
+ *
+ * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, CS GROUP France
+ */
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+/*
+ * The macro sets two stack frames, one for the caller and one for the callee
+ * because there are no requirement for the caller to set a stack frame when
+ * calling VDSO so it may have omitted to set one, especially on PPC64
+ */
+
+.macro cvdso_call funct
+  .cfi_startproc
+	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
+  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
+	mflr		r0
+	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
+  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
+	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
+  .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
+	get_datapage	r8
+	addi		r8, r8, VDSO_RNG_DATA_OFFSET
+	bl		CFUNC(DOTSYM(\funct))
+	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
+	cmpwi		r3, 0
+	mtlr		r0
+	addi		r1, r1, 2 * PPC_MIN_STKFRM
+  .cfi_restore lr
+  .cfi_def_cfa_offset 0
+	crclr		so
+	bgelr+
+	crset		so
+	neg		r3, r3
+	blr
+  .cfi_endproc
+.endm
+
+	.text
+V_FUNCTION_BEGIN(__kernel_getrandom)
+	cvdso_call __c_kernel_getrandom
+V_FUNCTION_END(__kernel_getrandom)
diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso/vdso32.lds.S
index 8f57107000a2..7b41d5d256e8 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -130,6 +130,7 @@ VERSION
 #if defined(CONFIG_PPC64) || !defined(CONFIG_SMP)
 		__kernel_getcpu;
 #endif
+		__kernel_getrandom;
 
 	local: *;
 	};
diff --git a/arch/powerpc/kernel/vdso/vgetrandom-chacha.S b/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
new file mode 100644
index 000000000000..a3475b9e8c10
--- /dev/null
+++ b/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, CS GROUP France
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/ppc_asm.h>
+
+.macro quarterround4 a1 b1 c1 d1 a2 b2 c2 d2 a3 b3 c3 d3 a4 b4 c4 d4
+	add	\a1, \a1, \b1
+	add	\a2, \a2, \b2
+	add	\a3, \a3, \b3
+	add	\a4, \a4, \b4
+	xor	\d1, \d1, \a1
+	xor	\d2, \d2, \a2
+	xor	\d3, \d3, \a3
+	xor	\d4, \d4, \a4
+	rotlwi	\d1, \d1, 16
+	rotlwi	\d2, \d2, 16
+	rotlwi	\d3, \d3, 16
+	rotlwi	\d4, \d4, 16
+	add	\c1, \c1, \d1
+	add	\c2, \c2, \d2
+	add	\c3, \c3, \d3
+	add	\c4, \c4, \d4
+	xor	\b1, \b1, \c1
+	xor	\b2, \b2, \c2
+	xor	\b3, \b3, \c3
+	xor	\b4, \b4, \c4
+	rotlwi	\b1, \b1, 12
+	rotlwi	\b2, \b2, 12
+	rotlwi	\b3, \b3, 12
+	rotlwi	\b4, \b4, 12
+	add	\a1, \a1, \b1
+	add	\a2, \a2, \b2
+	add	\a3, \a3, \b3
+	add	\a4, \a4, \b4
+	xor	\d1, \d1, \a1
+	xor	\d2, \d2, \a2
+	xor	\d3, \d3, \a3
+	xor	\d4, \d4, \a4
+	rotlwi	\d1, \d1, 8
+	rotlwi	\d2, \d2, 8
+	rotlwi	\d3, \d3, 8
+	rotlwi	\d4, \d4, 8
+	add	\c1, \c1, \d1
+	add	\c2, \c2, \d2
+	add	\c3, \c3, \d3
+	add	\c4, \c4, \d4
+	xor	\b1, \b1, \c1
+	xor	\b2, \b2, \c2
+	xor	\b3, \b3, \c3
+	xor	\b4, \b4, \c4
+	rotlwi	\b1, \b1, 7
+	rotlwi	\b2, \b2, 7
+	rotlwi	\b3, \b3, 7
+	rotlwi	\b4, \b4, 7
+.endm
+
+#define QUARTERROUND4(a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4) \
+	quarterround4 16+a1 16+b1 16+c1 16+d1 16+a2 16+b2 16+c2 16+d2 \
+		      16+a3 16+b3 16+c3 16+d3 16+a4 16+b4 16+c4 16+d4
+
+/*
+ * Very basic 32 bits implementation of ChaCha20. Produces a given positive number
+ * of blocks of output with a nonce of 0, taking an input key and 8-byte
+ * counter. Importantly does not spill to the stack. Its arguments are:
+ *
+ *	r3: output bytes
+ *	r4: 32-byte key input
+ *	r5: 8-byte counter input/output (saved on stack)
+ *	r6: number of 64-byte blocks to write to output
+ *
+ *	r0: counter of blocks (initialised with r6)
+ *	r4: Value '4' after key has been read.
+ *	r5-r12: key
+ *	r14-r15: counter
+ *	r16-r31: state
+ */
+SYM_FUNC_START(__arch_chacha20_blocks_nostack)
+	stwu	r1, -96(r1)
+	stw	r5, 20(r1)
+	stmw	r14, 24(r1)
+	li	r31, 4
+	LWZX_LE	r14, 0, r5
+	LWZX_LE	r15, r31, r5
+	mr	r0, r6
+
+	lwz	r5, 0(r4)
+	lwz	r6, 4(r4)
+	lwz	r7, 8(r4)
+	lwz	r8, 12(r4)
+	lwz	r9, 16(r4)
+	lwz	r10, 20(r4)
+	lwz	r11, 24(r4)
+	lwz	r12, 28(r4)
+
+	li	r4, 4
+.Lblock:
+	li	r31, 10
+
+	lis	r16, 0x6170
+	lis	r17, 0x3320
+	lis	r18, 0x7962
+	lis	r19, 0x6b20
+	addi	r16, r16, 0x7865
+	addi	r17, r17, 0x646e
+	addi	r18, r18, 0x2d32
+	addi	r19, r19, 0x6574
+
+	mtctr	r31
+
+	mr	r20, r5
+	mr	r21, r6
+	mr	r22, r7
+	mr	r23, r8
+	mr	r24, r9
+	mr	r25, r10
+	mr	r26, r11
+	mr	r27, r12
+
+	mr	r28, r14
+	mr	r29, r15
+	li	r30, 0
+	li	r31, 0
+
+.Lpermute:
+	QUARTERROUND4( 0, 4, 8,12, 1, 5, 9,13, 2, 6,10,14, 3, 7,11,15)
+	QUARTERROUND4( 0, 5,10,15, 1, 6,11,12, 2, 7, 8,13, 3, 4, 9,14)
+
+	bdnz	.Lpermute
+
+	addis	r16, r16, 0x6170
+	addis	r17, r17, 0x3320
+	addis	r18, r18, 0x7962
+	addis	r19, r19, 0x6b20
+	addi	r16, r16, 0x7865
+	addi	r17, r17, 0x646e
+	addi	r18, r18, 0x2d32
+	addi	r19, r19, 0x6574
+
+	add	r20, r20, r5
+	add	r21, r21, r6
+	add	r22, r22, r7
+	add	r23, r23, r8
+	add	r24, r24, r9
+	add	r25, r25, r10
+	add	r26, r26, r11
+	add	r27, r27, r12
+
+	add	r28, r28, r14
+	add	r29, r29, r15
+
+	STWX_LE	r16, 0, r3
+	STWX_LE	r17, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r18, 0, r3
+	STWX_LE	r19, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r20, 0, r3
+	STWX_LE	r21, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r22, 0, r3
+	STWX_LE	r23, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r24, 0, r3
+	STWX_LE	r25, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r26, 0, r3
+	STWX_LE	r27, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r28, 0, r3
+	STWX_LE	r29, r4, r3
+	addi	r3, r3, 8
+	STWX_LE	r30, 0, r3
+	STWX_LE	r31, r4, r3
+	addi	r3, r3, 8
+
+	addic	r14, r14, 1
+	addze	r15, r15
+
+	subic.	r0, r0, 1	/* subi. can't use r0 as source */
+	bne	.Lblock
+
+	lwz	r5, 20(r1)
+	STWX_LE	r14, 0, r5
+	STWX_LE	r15, r4, r5
+
+	li	r6, 0
+	li	r7, 0
+	li	r8, 0
+	li	r9, 0
+	li	r10, 0
+	li	r11, 0
+	li	r12, 0
+
+	lmw	r14, 24(r1)
+	addi	r1, r1, 96
+	blr
+SYM_FUNC_END(__arch_chacha20_blocks_nostack)
diff --git a/arch/powerpc/kernel/vdso/vgetrandom.c b/arch/powerpc/kernel/vdso/vgetrandom.c
new file mode 100644
index 000000000000..5f855d45fb7b
--- /dev/null
+++ b/arch/powerpc/kernel/vdso/vgetrandom.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Powerpc userspace implementation of getrandom()
+ *
+ * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, CS GROUP France
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
+			     size_t opaque_len, const struct vdso_rng_data *vd)
+{
+	return __cvdso_getrandom_data(vd, buffer, len, flags, opaque_state, opaque_len);
+}
diff --git a/tools/arch/powerpc/vdso b/tools/arch/powerpc/vdso
new file mode 120000
index 000000000000..d31004bf8f55
--- /dev/null
+++ b/tools/arch/powerpc/vdso
@@ -0,0 +1 @@
+../../../arch/powerpc/kernel/vdso/
\ No newline at end of file
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index e21e78aae24d..e57dcefa1988 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -14,6 +14,10 @@ ifeq ($(uname_M),x86_64)
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 endif
+ifeq ($(ARCH),powerpc)
+TEST_GEN_PROGS += vdso_test_getrandom
+TEST_GEN_PROGS += vdso_test_chacha
+endif
 
 CFLAGS := -std=gnu99
 
-- 
2.44.0


