Return-Path: <linux-fsdevel+bounces-28242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB6696870E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311BA1C20B50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE53205E38;
	Mon,  2 Sep 2024 12:05:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B758205E22;
	Mon,  2 Sep 2024 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278707; cv=none; b=uD1Nk/xHF3Vbjoor0bklCuf/ozBsjz7lHqIugfrNyO4fC+XJUYFOo+XwXpqag271vl1n0MO9Y6nQIp8+q1NzMXFLoLoRky3kVtSWWGFGdc/cJDLdtaGhjU0KUOuvKIqf5ONpysmHK94YNUM9+uxriWyVKOZdtD4CT7xj0G5v4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278707; c=relaxed/simple;
	bh=IXPGw+3+3XEXiFlp3gnlha1PDe0YPRC+LuMT1LSHgnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8ipGoBlNWnp3FBfkOdwhkwiacWlcdZfG1h53KCHfxwzyLGDGnuWJVm154NOIsx8/FxzmHNyc1lm1V57WMAXo66T4GMHcnECQekFyqMmHPoUmjDOALCDDnoTFag32emNxHuICz2+8LxfJre5Zo+9nqGwKcLmSLBIePgAND3ckLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wy6rL0yyRz9sSW;
	Mon,  2 Sep 2024 14:04:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zbZGXrJ3WgZC; Mon,  2 Sep 2024 14:04:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wy6rK4GMZz9sST;
	Mon,  2 Sep 2024 14:04:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 810B38B76D;
	Mon,  2 Sep 2024 14:04:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xbKUmFcjcP7M; Mon,  2 Sep 2024 14:04:49 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6879E8B763;
	Mon,  2 Sep 2024 14:04:48 +0200 (CEST)
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
Subject: [PATCH v4 4/5] powerpc/vdso: Wire up getrandom() vDSO implementation on PPC32
Date: Mon,  2 Sep 2024 14:04:41 +0200
Message-ID: <ec4d2919836a9f3a7791c2540ee79067396d701b.1725278148.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1725278148.git.christophe.leroy@csgroup.eu>
References: <cover.1725278148.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725278679; l=18162; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=IXPGw+3+3XEXiFlp3gnlha1PDe0YPRC+LuMT1LSHgnI=; b=7E+u0UM1zpxQbC66vsGa5O1e8aLDKdDu+IiZdQkHJ446Nx4P73MWK5KhufRfFMu6ugnJ1kFZp KpJoUinqNAeDlc6SagT2bPpZbbJverqwwY2fxKZDv0E0vbZEsn+Ls5J
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

This first patch adds support for PPC32. As selftests cannot easily
be generated only for PPC32, and because the following patch brings
support for PPC64 anyway, this patch opts out all code in
__arch_chacha20_blocks_nostack() so that vdso_test_chacha will not
fail to compile and will not crash on PPC64/PPC64LE, allthough the
selftest itself will fail. This patch also adds a dummy
__kernel_getrandom() function that returns ENOSYS on PPC64 so that
vdso_test_getrandom returns KSFT_SKIP instead of KSFT_FAIL.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4:
- Counter has native byte order
- Fix selftest build on ppc64le until implemented.
- On ppc64, for now implement __kernel_getrandom to return ENOSYS error
- Use stwbrx directly, not compat macro.

v3:
- Preserve r13, implies saving r5 on stack
- Split PPC64 implementation out.
---
 arch/powerpc/Kconfig                         |   1 +
 arch/powerpc/include/asm/vdso/getrandom.h    |  54 +++++
 arch/powerpc/include/asm/vdso/vsyscall.h     |   6 +
 arch/powerpc/include/asm/vdso_datapage.h     |   2 +
 arch/powerpc/kernel/asm-offsets.c            |   1 +
 arch/powerpc/kernel/vdso/Makefile            |  13 +-
 arch/powerpc/kernel/vdso/getrandom.S         |  58 ++++++
 arch/powerpc/kernel/vdso/vdso32.lds.S        |   1 +
 arch/powerpc/kernel/vdso/vdso64.lds.S        |   1 +
 arch/powerpc/kernel/vdso/vgetrandom-chacha.S | 207 +++++++++++++++++++
 arch/powerpc/kernel/vdso/vgetrandom.c        |  16 ++
 tools/testing/selftests/vDSO/Makefile        |   2 +-
 12 files changed, 359 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/getrandom.h
 create mode 100644 arch/powerpc/kernel/vdso/getrandom.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom-chacha.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom.c

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
index 67fe79d26fae..af3ba61b022e 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -8,6 +8,9 @@ include $(srctree)/lib/vdso/Makefile
 obj-vdso32 = sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32.o note-32.o getcpu-32.o
 obj-vdso64 = sigtramp64-64.o gettimeofday-64.o datapage-64.o cacheflush-64.o note-64.o getcpu-64.o
 
+obj-vdso32 += getrandom-32.o vgetrandom-chacha-32.o
+obj-vdso64 += getrandom-64.o
+
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-32.o += -include $(c-gettimeofday-y)
 # Go prior to 1.16.x assumes r30 is not clobbered by any VDSO code. That used to be true
@@ -17,6 +20,10 @@ ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-64.o += -include $(c-gettimeofday-y) $(call cc-option, -ffixed-r30)
 endif
 
+ifneq ($(c-getrandom-y),)
+  CFLAGS_vgetrandom-32.o += -include $(c-getrandom-y)
+endif
+
 # Build rules
 
 ifdef CROSS32_COMPILE
@@ -25,7 +32,7 @@ else
     VDSOCC := $(CC)
 endif
 
-targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o
+targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o vgetrandom-32.o
 targets += crtsavres-32.o
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
 targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o
@@ -63,7 +70,7 @@ targets += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/crtsavres-32.o FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
 	$(call if_changed,vdso32ld_and_check)
 $(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o FORCE
 	$(call if_changed,vdso64ld_and_check)
@@ -75,6 +82,8 @@ $(obj)/crtsavres-32.o: %-32.o: $(srctree)/arch/powerpc/lib/crtsavres.S FORCE
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
index 000000000000..7db51c0635a5
--- /dev/null
+++ b/arch/powerpc/kernel/vdso/getrandom.S
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Userland implementation of getrandom() for processes
+ * for use in the vDSO
+ *
+ * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, CS GROUP France
+ */
+#include <linux/errno.h>
+
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
+#ifdef CONFIG_PPC64
+	li	r3, ENOSYS
+	crset	so
+	blr
+#else
+	cvdso_call __c_kernel_getrandom
+#endif
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
new file mode 100644
index 000000000000..17a2f586223a
--- /dev/null
+++ b/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
@@ -0,0 +1,207 @@
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
+#ifdef __powerpc64__
+	blr
+#else
+	stwu	r1, -96(r1)
+	stw	r5, 20(r1)
+	stmw	r14, 24(r1)
+
+	lwz	r14, 0(r5)
+	lwz	r15, 4(r5)
+	mr	r0, r6
+	subi	r3, r3, 4
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
+	stwbrx	r16, r4, r3
+	addi	r3, r3, 8
+	stwbrx	r17, 0, r3
+	stwbrx	r18, r4, r3
+	addi	r3, r3, 8
+	stwbrx	r19, 0, r3
+	stwbrx	r20, r4, r3
+	addi	r3, r3, 8
+	stwbrx	r21, 0, r3
+	stwbrx	r22, r4, r3
+	addi	r3, r3, 8
+	stwbrx	r23, 0, r3
+	stwbrx	r24, r4, r3
+	addi	r3, r3, 8
+	stwbrx	r25, 0, r3
+	stwbrx	r26, r4, r3
+	addi	r3, r3, 8
+	stwbrx	r27, 0, r3
+	stwbrx	r28, r4, r3
+	addi	r3, r3, 8
+	stwbrx	r29, 0, r3
+	stwbrx	r30, r4, r3
+	addi	r3, r3, 8
+	stwbrx	r31, 0, r3
+
+	subic.	r0, r0, 1	/* subi. can't use r0 as source */
+
+	addic	r14, r14, 1
+	addze	r15, r15
+
+	bne	.Lblock
+
+	lwz	r5, 20(r1)
+	stw	r14, 0(r5)
+	stw	r15, 4(r5)
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
+#endif
+SYM_FUNC_END(__arch_chacha20_blocks_nostack)
diff --git a/arch/powerpc/kernel/vdso/vgetrandom.c b/arch/powerpc/kernel/vdso/vgetrandom.c
new file mode 100644
index 000000000000..923330845b2c
--- /dev/null
+++ b/arch/powerpc/kernel/vdso/vgetrandom.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Powerpc userspace implementation of getrandom()
+ *
+ * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, CS GROUP France
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+#ifndef CONFIG_PPC64
+ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
+			     size_t opaque_len, const struct vdso_rng_data *vd)
+{
+	return __cvdso_getrandom_data(vd, buffer, len, flags, opaque_state, opaque_len);
+}
+#endif
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 04930125035e..853e669d8643 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -9,7 +9,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += vdso_test_correctness
-ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86 x86_64 loongarch))
+ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86 x86_64 loongarch powerpc))
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 endif
-- 
2.44.0


