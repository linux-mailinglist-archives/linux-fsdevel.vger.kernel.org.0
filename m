Return-Path: <linux-fsdevel+bounces-28286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29652968E5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 21:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D602B28455C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BF12101AD;
	Mon,  2 Sep 2024 19:18:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5A205E32;
	Mon,  2 Sep 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725304681; cv=none; b=kEoaQkuIPmZpE6jOcFaPKM5lYnx7QxsKY3xo5+jsvx4GShsfRaY0SySyFCN8T6E99/YOnuOfulg33huOHfT3oPeoM6HY1B8wviAyKG8teFCsJdSpdKyVBRRyyyWnC8OEqTceR57FG6cvW4Dyb/jeUIkmDIrSikhvfJ85VdOdWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725304681; c=relaxed/simple;
	bh=xbDuNHEVSgTiEw/Liyuq45MtggWGoEGt/trt9xHuM1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fr7nC1HfDupaZAfHW78Bjqi3rp9x1Uz+nbTHPIzbkmjRt4CjUGO6fdNo6mY/5tCzjeXHxs2izWMhAHL6PTL3iiKqSTx207eBr99p44SRbxRjbSFyZDzbQzMYXab9XOmqKHESQT7vwGjpOOs4SA5e7bMfGCn8JK8/h1kxU7WEl+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WyJRf4MJSz9sSR;
	Mon,  2 Sep 2024 21:17:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c5B4YHpbNwri; Mon,  2 Sep 2024 21:17:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WyJRf3BJyz9sS7;
	Mon,  2 Sep 2024 21:17:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FE818B770;
	Mon,  2 Sep 2024 21:17:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id EOvVB3ttp4eK; Mon,  2 Sep 2024 21:17:34 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 453628B76E;
	Mon,  2 Sep 2024 21:17:33 +0200 (CEST)
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
Subject: [PATCH v5 4/5] powerpc/vdso: Wire up getrandom() vDSO implementation on VDSO32
Date: Mon,  2 Sep 2024 21:17:21 +0200
Message-ID: <1f49c2ce009f8b007ab0676fb41187b2d54f28b2.1725304404.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1725304404.git.christophe.leroy@csgroup.eu>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725304638; l=21940; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=xbDuNHEVSgTiEw/Liyuq45MtggWGoEGt/trt9xHuM1g=; b=dRiLD2TS6tNlmghNU52c0Hz3SB7iR8Mt88SF+73lIjwUGUl8F1kCEcTlkLn2AZO+SvVORdwzQ TwJHn+k+gUzDOjimGzXkuBk6gZT969KjU1qp0DlBfKKnQFd5CHCZjml
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

This first patch adds support for VDSO32. As selftests cannot easily
be generated only for VDSO32, and because the following patch brings
support for VDSO64 anyway, this patch opts out all code in
__arch_chacha20_blocks_nostack() so that vdso_test_chacha will not
fail to compile and will not crash on PPC64/PPC64LE, allthough the
selftest itself will fail.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5:
- Add back vdso symlink that vanished in v4 after a rebase back and forth with rejected patch "selftests: vDSO: Do not rely on $ARCH for vdso_test_getrandom && vdso_test_chacha"
- Set meaningfull names to registers and constants in chacha assembly
- Add 32 bits LE logic in this patch as well allthought it is only usefull for ppc64le.
- Remove the temporary ppc64 __kernel_getrandom added in v4, selftest will return KSFT_FAIL until following patch, not a big issue.
- Move the -DBUILD_VDSO logic in patch 3 to allow build VDSO32 on ppc64.

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
 arch/powerpc/include/asm/mman.h              |   2 +-
 arch/powerpc/include/asm/vdso/getrandom.h    |  54 ++++
 arch/powerpc/include/asm/vdso/vsyscall.h     |   6 +
 arch/powerpc/include/asm/vdso_datapage.h     |   2 +
 arch/powerpc/kernel/asm-offsets.c            |   1 +
 arch/powerpc/kernel/vdso/Makefile            |  14 +-
 arch/powerpc/kernel/vdso/getrandom.S         |  50 +++
 arch/powerpc/kernel/vdso/vdso32.lds.S        |   1 +
 arch/powerpc/kernel/vdso/vgetrandom-chacha.S | 312 +++++++++++++++++++
 arch/powerpc/kernel/vdso/vgetrandom.c        |  14 +
 tools/arch/powerpc/vdso                      |   1 +
 tools/testing/selftests/vDSO/Makefile        |   2 +-
 13 files changed, 455 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/getrandom.h
 create mode 100644 arch/powerpc/kernel/vdso/getrandom.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom-chacha.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom.c
 create mode 120000 tools/arch/powerpc/vdso

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d7b09b064a8a..e500a59ddecc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -311,6 +311,7 @@ config PPC
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
+	select VDSO_GETRANDOM			if VDSO32
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
index 67fe79d26fae..7a4a935406d8 100644
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
@@ -25,13 +31,13 @@ else
     VDSOCC := $(CC)
 endif
 
-targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o
+targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o vgetrandom-32.o
 targets += crtsavres-32.o
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
 targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 
-ccflags-y := -fno-common -fno-builtin
+ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO
 ccflags-y += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 ccflags-y += $(call cc-option, -fno-stack-protector)
 ccflags-y += -DDISABLE_BRANCH_PROFILING
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
index 000000000000..ac85788205cb
--- /dev/null
+++ b/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
@@ -0,0 +1,312 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, CS GROUP France
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/ppc_asm.h>
+
+#define	dst_bytes	r3
+#define	key		r4
+#define	counter		r5
+#define	nblocks		r6
+
+#define	idx_r0		r0
+#define	val4		r4
+
+#define	const0		0x61707865
+#define	const1		0x3320646e
+#define	const2		0x79622d32
+#define	const3		0x6b206574
+
+#define	key0		r5
+#define	key1		r6
+#define	key2		r7
+#define	key3		r8
+#define	key4		r9
+#define	key5		r10
+#define	key6		r11
+#define	key7		r12
+
+#define	counter0	r14
+#define	counter1	r15
+
+#define	state0		r16
+#define	state1		r17
+#define	state2		r18
+#define	state3		r19
+#define	state4		r20
+#define	state5		r21
+#define	state6		r22
+#define	state7		r23
+#define	state8		r24
+#define	state9		r25
+#define	state10		r26
+#define	state11		r27
+#define	state12		r28
+#define	state13		r29
+#define	state14		r30
+#define	state15		r31
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
+	quarterround4 state##a1 state##b1 state##c1 state##d1 \
+		      state##a2 state##b2 state##c2 state##d2 \
+		      state##a3 state##b3 state##c3 state##d3 \
+		      state##a4 state##b4 state##c4 state##d4
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
+#else
+	stwu	r1, -96(r1)
+	stw	counter, 20(r1)
+#ifdef __BIG_ENDIAN__
+	stmw	r14, 24(r1)
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
+
+	lwz	counter0, 0(counter)
+	lwz	counter1, 4(counter)
+	mr	idx_r0, nblocks
+	subi	dst_bytes, dst_bytes, 4
+
+	lwz	key0, 0(key)
+	lwz	key1, 4(key)
+	lwz	key2, 8(key)
+	lwz	key3, 12(key)
+	lwz	key4, 16(key)
+	lwz	key5, 20(key)
+	lwz	key6, 24(key)
+	lwz	key7, 28(key)
+
+	li	val4, 4
+.Lblock:
+	li	r31, 10
+
+	lis	state0, const0@ha
+	lis	state1, const1@ha
+	lis	state2, const2@ha
+	lis	state3, const3@ha
+	addi	state0, state0, const0@l
+	addi	state1, state1, const1@l
+	addi	state2, state2, const2@l
+	addi	state3, state3, const3@l
+
+	mtctr	r31
+
+	mr	state4, key0
+	mr	state5, key1
+	mr	state6, key2
+	mr	state7, key3
+	mr	state8, key4
+	mr	state9, key5
+	mr	state10, key6
+	mr	state11, key7
+
+	mr	state12, counter0
+	mr	state13, counter1
+
+	li	state14, 0
+	li	state15, 0
+
+.Lpermute:
+	QUARTERROUND4( 0, 4, 8,12, 1, 5, 9,13, 2, 6,10,14, 3, 7,11,15)
+	QUARTERROUND4( 0, 5,10,15, 1, 6,11,12, 2, 7, 8,13, 3, 4, 9,14)
+
+	bdnz	.Lpermute
+
+	addis	state0, state0, const0@ha
+	addis	state1, state1, const1@ha
+	addis	state2, state2, const2@ha
+	addis	state3, state3, const3@ha
+	addi	state0, state0, const0@l
+	addi	state1, state1, const1@l
+	addi	state2, state2, const2@l
+	addi	state3, state3, const3@l
+
+	add	state4, state4, key0
+	add	state5, state5, key1
+	add	state6, state6, key2
+	add	state7, state7, key3
+	add	state8, state8, key4
+	add	state9, state9, key5
+	add	state10, state10, key6
+	add	state11, state11, key7
+
+	add	state12, state12, counter0
+	add	state13, state13, counter1
+
+#ifdef __BIG_ENDIAN__
+	stwbrx	state0, val4, dst_bytes
+	addi	dst_bytes, dst_bytes, 8
+	stwbrx	state1, 0, dst_bytes
+	stwbrx	state2, val4, dst_bytes
+	addi	dst_bytes, dst_bytes, 8
+	stwbrx	state3, 0, dst_bytes
+	stwbrx	state4, val4, dst_bytes
+	addi	dst_bytes, dst_bytes, 8
+	stwbrx	state5, 0, dst_bytes
+	stwbrx	state6, val4, dst_bytes
+	addi	dst_bytes, dst_bytes, 8
+	stwbrx	state7, 0, dst_bytes
+	stwbrx	state8, val4, dst_bytes
+	addi	dst_bytes, dst_bytes, 8
+	stwbrx	state9, 0, dst_bytes
+	stwbrx	state10, val4, dst_bytes
+	addi	dst_bytes, dst_bytes, 8
+	stwbrx	state11, 0, dst_bytes
+	stwbrx	state12, val4, dst_bytes
+	addi	dst_bytes, dst_bytes, 8
+	stwbrx	state13, 0, dst_bytes
+	stwbrx	state14, val4, dst_bytes
+	addi	dst_bytes, dst_bytes, 8
+	stwbrx	state15, 0, dst_bytes
+#else
+	stw	state0, 4(dst_bytes)
+	stw	state1, 8(dst_bytes)
+	stw	state2, 12(dst_bytes)
+	stw	state3, 16(dst_bytes)
+	stw	state4, 20(dst_bytes)
+	stw	state5, 24(dst_bytes)
+	stw	state6, 28(dst_bytes)
+	stw	state7, 32(dst_bytes)
+	stw	state8, 36(dst_bytes)
+	stw	state9, 40(dst_bytes)
+	stw	state10, 44(dst_bytes)
+	stw	state11, 48(dst_bytes)
+	stw	state12, 52(dst_bytes)
+	stw	state13, 56(dst_bytes)
+	stw	state14, 60(dst_bytes)
+	stwu	state15, 64(dst_bytes)
+#endif
+
+	subic.	idx_r0, idx_r0, 1	/* subi. can't use r0 as source */
+
+	addic	counter0, counter0, 1
+	addze	counter1, counter1
+
+	bne	.Lblock
+
+	lwz	counter, 20(r1)
+	stw	counter0, 0(counter)
+	stw	counter1, 4(counter)
+
+	li	r6, 0
+	li	r7, 0
+	li	r8, 0
+	li	r9, 0
+	li	r10, 0
+	li	r11, 0
+	li	r12, 0
+
+#ifdef __BIG_ENDIAN__
+	lmw	r14, 24(r1)
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
+	addi	r1, r1, 96
+#endif	/* __powerpc64__ */
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
index 000000000000..4e676d1d1cb4
--- /dev/null
+++ b/tools/arch/powerpc/vdso
@@ -0,0 +1 @@
+../../../arch/powerpc/kernel/vdso
\ No newline at end of file
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


