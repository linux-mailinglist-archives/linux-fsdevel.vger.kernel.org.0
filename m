Return-Path: <linux-fsdevel+bounces-26776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFA95B9B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4D41C23798
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584681CCED6;
	Thu, 22 Aug 2024 15:13:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170171CCB43;
	Thu, 22 Aug 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339600; cv=none; b=MDptdtiMsE+e48XsPGvrJQjkD9c2DUCEz0X56gGWybGfM8BjG3kNfpH6RzmGgYu5NCmj3eyinATvRrwXE8tj14hpBj0lbxEnZdYOMllrSjuGbhEuTeK3w4VkbCGN1PCyiXFLxqCHP8bUgy7/kbc/biVa0JxEvVE3QxzBELG9z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339600; c=relaxed/simple;
	bh=kJ8JPMqX9w15unR1Rior31i3tQ8L6LnxgM6jYki1HTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JGYQZihFYjX4lNY2OxzVDng0Xn4G4LLl9winUrgO0lu2mJO1NQsv9HRcH5HqcbQ/rAH5cPxXBwiwo7niqd9W8VkqC6YAh8+/+1WdBN8N81YEbrXxsxE2cMVueUXYX3y0WMxg0OV1+xGwYgCrY6KfD1lrvASb9pVNmsZDkzDnpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDD7215DB;
	Thu, 22 Aug 2024 08:13:42 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFB313F58B;
	Thu, 22 Aug 2024 08:13:12 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 26/30] selftests: mm: make protection_keys test work on arm64
Date: Thu, 22 Aug 2024 16:11:09 +0100
Message-Id: <20240822151113.1479789-27-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822151113.1479789-1-joey.gouly@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The encoding of the pkey register differs on arm64, than on x86/ppc. On those
platforms, a bit in the register is used to disable permissions, for arm64, a
bit enabled in the register indicates that the permission is allowed.

This drops two asserts of the form:
	 assert(read_pkey_reg() <= orig_pkey_reg);
Because on arm64 this doesn't hold, due to the encoding.

The pkey must be reset to both access allow and write allow in the signal
handler. pkey_access_allow() works currently for PowerPC as the
PKEY_DISABLE_ACCESS and PKEY_DISABLE_WRITE have overlapping bits set.

Access to the uc_mcontext is abstracted, as arm64 has a different structure.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 .../arm64/signal/testcases/testcases.h        |   3 +
 tools/testing/selftests/mm/Makefile           |   2 +-
 tools/testing/selftests/mm/pkey-arm64.h       | 139 ++++++++++++++++++
 tools/testing/selftests/mm/pkey-helpers.h     |   8 +
 tools/testing/selftests/mm/pkey-powerpc.h     |   2 +
 tools/testing/selftests/mm/pkey-x86.h         |   2 +
 tools/testing/selftests/mm/protection_keys.c  | 103 +++++++++++--
 7 files changed, 247 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey-arm64.h

diff --git tools/testing/selftests/arm64/signal/testcases/testcases.h tools/testing/selftests/arm64/signal/testcases/testcases.h
index 3185e6875694..9872b8912714 100644
--- tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -26,6 +26,9 @@
 #define HDR_SZ \
 	sizeof(struct _aarch64_ctx)
 
+#define GET_UC_RESV_HEAD(uc) \
+	(struct _aarch64_ctx *)(&(uc->uc_mcontext.__reserved))
+
 #define GET_SF_RESV_HEAD(sf) \
 	(struct _aarch64_ctx *)(&(sf).uc.uc_mcontext.__reserved)
 
diff --git tools/testing/selftests/mm/Makefile tools/testing/selftests/mm/Makefile
index cfad627e8d94..5f2ca591c956 100644
--- tools/testing/selftests/mm/Makefile
+++ tools/testing/selftests/mm/Makefile
@@ -106,7 +106,7 @@ TEST_GEN_FILES += $(BINARIES_64)
 endif
 else
 
-ifneq (,$(findstring $(ARCH),powerpc))
+ifneq (,$(filter $(ARCH),arm64 powerpc))
 TEST_GEN_FILES += protection_keys
 endif
 
diff --git tools/testing/selftests/mm/pkey-arm64.h tools/testing/selftests/mm/pkey-arm64.h
new file mode 100644
index 000000000000..580e1b0bb38e
--- /dev/null
+++ tools/testing/selftests/mm/pkey-arm64.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Arm Ltd.
+ */
+
+#ifndef _PKEYS_ARM64_H
+#define _PKEYS_ARM64_H
+
+#include "vm_util.h"
+/* for signal frame parsing */
+#include "../arm64/signal/testcases/testcases.h"
+
+#ifndef SYS_mprotect_key
+# define SYS_mprotect_key	288
+#endif
+#ifndef SYS_pkey_alloc
+# define SYS_pkey_alloc		289
+# define SYS_pkey_free		290
+#endif
+#define MCONTEXT_IP(mc)		mc.pc
+#define MCONTEXT_TRAPNO(mc)	-1
+
+#define PKEY_MASK		0xf
+
+#define POE_NONE		0x0
+#define POE_X			0x2
+#define POE_RX			0x3
+#define POE_RWX			0x7
+
+#define NR_PKEYS		8
+#define NR_RESERVED_PKEYS	1 /* pkey-0 */
+
+#define PKEY_ALLOW_ALL		0x77777777
+
+#define PKEY_BITS_PER_PKEY	4
+#define PAGE_SIZE		sysconf(_SC_PAGESIZE)
+#undef HPAGE_SIZE
+#define HPAGE_SIZE		default_huge_page_size()
+
+/* 4-byte instructions * 16384 = 64K page */
+#define __page_o_noops() asm(".rept 16384 ; nop; .endr")
+
+static inline u64 __read_pkey_reg(void)
+{
+	u64 pkey_reg = 0;
+
+	// POR_EL0
+	asm volatile("mrs %0, S3_3_c10_c2_4" : "=r" (pkey_reg));
+
+	return pkey_reg;
+}
+
+static inline void __write_pkey_reg(u64 pkey_reg)
+{
+	u64 por = pkey_reg;
+
+	dprintf4("%s() changing %016llx to %016llx\n",
+			 __func__, __read_pkey_reg(), pkey_reg);
+
+	// POR_EL0
+	asm volatile("msr S3_3_c10_c2_4, %0\nisb" :: "r" (por) :);
+
+	dprintf4("%s() pkey register after changing %016llx to %016llx\n",
+			__func__, __read_pkey_reg(), pkey_reg);
+}
+
+static inline int cpu_has_pkeys(void)
+{
+	/* No simple way to determine this */
+	return 1;
+}
+
+static inline u32 pkey_bit_position(int pkey)
+{
+	return pkey * PKEY_BITS_PER_PKEY;
+}
+
+static inline int get_arch_reserved_keys(void)
+{
+	return NR_RESERVED_PKEYS;
+}
+
+void expect_fault_on_read_execonly_key(void *p1, int pkey)
+{
+}
+
+void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+{
+	return PTR_ERR_ENOTSUP;
+}
+
+#define set_pkey_bits	set_pkey_bits
+static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
+{
+	u32 shift = pkey_bit_position(pkey);
+	u64 new_val = POE_RWX;
+
+	/* mask out bits from pkey in old value */
+	reg &= ~((u64)PKEY_MASK << shift);
+
+	if (flags & PKEY_DISABLE_ACCESS)
+		new_val = POE_X;
+	else if (flags & PKEY_DISABLE_WRITE)
+		new_val = POE_RX;
+
+	/* OR in new bits for pkey */
+	reg |= new_val << shift;
+
+	return reg;
+}
+
+#define get_pkey_bits	get_pkey_bits
+static inline u64 get_pkey_bits(u64 reg, int pkey)
+{
+	u32 shift = pkey_bit_position(pkey);
+	/*
+	 * shift down the relevant bits to the lowest four, then
+	 * mask off all the other higher bits
+	 */
+	u32 perm = (reg >> shift) & PKEY_MASK;
+
+	if (perm == POE_X)
+		return PKEY_DISABLE_ACCESS;
+	if (perm == POE_RX)
+		return PKEY_DISABLE_WRITE;
+	return 0;
+}
+
+static void aarch64_write_signal_pkey(ucontext_t *uctxt, u64 pkey)
+{
+	struct _aarch64_ctx *ctx = GET_UC_RESV_HEAD(uctxt);
+	struct poe_context *poe_ctx =
+		(struct poe_context *) get_header(ctx, POE_MAGIC,
+						sizeof(uctxt->uc_mcontext), NULL);
+	if (poe_ctx)
+		poe_ctx->por_el0 = pkey;
+}
+
+#endif /* _PKEYS_ARM64_H */
diff --git tools/testing/selftests/mm/pkey-helpers.h tools/testing/selftests/mm/pkey-helpers.h
index 1af3156a9db8..15608350fc01 100644
--- tools/testing/selftests/mm/pkey-helpers.h
+++ tools/testing/selftests/mm/pkey-helpers.h
@@ -91,12 +91,17 @@ void record_pkey_malloc(void *ptr, long size, int prot);
 #include "pkey-x86.h"
 #elif defined(__powerpc64__) /* arch */
 #include "pkey-powerpc.h"
+#elif defined(__aarch64__) /* arch */
+#include "pkey-arm64.h"
 #else /* arch */
 #error Architecture not supported
 #endif /* arch */
 
+#ifndef PKEY_MASK
 #define PKEY_MASK	(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
+#endif
 
+#ifndef set_pkey_bits
 static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
 {
 	u32 shift = pkey_bit_position(pkey);
@@ -106,7 +111,9 @@ static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
 	reg |= (flags & PKEY_MASK) << shift;
 	return reg;
 }
+#endif
 
+#ifndef get_pkey_bits
 static inline u64 get_pkey_bits(u64 reg, int pkey)
 {
 	u32 shift = pkey_bit_position(pkey);
@@ -116,6 +123,7 @@ static inline u64 get_pkey_bits(u64 reg, int pkey)
 	 */
 	return ((reg >> shift) & PKEY_MASK);
 }
+#endif
 
 extern u64 shadow_pkey_reg;
 
diff --git tools/testing/selftests/mm/pkey-powerpc.h tools/testing/selftests/mm/pkey-powerpc.h
index 6275d0f474b3..3d0c0bdae5bc 100644
--- tools/testing/selftests/mm/pkey-powerpc.h
+++ tools/testing/selftests/mm/pkey-powerpc.h
@@ -8,6 +8,8 @@
 # define SYS_pkey_free		385
 #endif
 #define REG_IP_IDX		PT_NIP
+#define MCONTEXT_IP(mc)		mc.gp_regs[REG_IP_IDX]
+#define MCONTEXT_TRAPNO(mc)	mc.gp_regs[REG_TRAPNO]
 #define REG_TRAPNO		PT_TRAP
 #define MCONTEXT_FPREGS
 #define gregs			gp_regs
diff --git tools/testing/selftests/mm/pkey-x86.h tools/testing/selftests/mm/pkey-x86.h
index b9170a26bfcb..5f28e26a2511 100644
--- tools/testing/selftests/mm/pkey-x86.h
+++ tools/testing/selftests/mm/pkey-x86.h
@@ -15,6 +15,8 @@
 
 #endif
 
+#define MCONTEXT_IP(mc)		mc.gregs[REG_IP_IDX]
+#define MCONTEXT_TRAPNO(mc)	mc.gregs[REG_TRAPNO]
 #define MCONTEXT_FPREGS
 
 #ifndef PKEY_DISABLE_ACCESS
diff --git tools/testing/selftests/mm/protection_keys.c tools/testing/selftests/mm/protection_keys.c
index 4337106a985e..0789981b72b9 100644
--- tools/testing/selftests/mm/protection_keys.c
+++ tools/testing/selftests/mm/protection_keys.c
@@ -147,7 +147,7 @@ void abort_hooks(void)
  * will then fault, which makes sure that the fault code handles
  * execute-only memory properly.
  */
-#ifdef __powerpc64__
+#if defined(__powerpc64__) || defined(__aarch64__)
 /* This way, both 4K and 64K alignment are maintained */
 __attribute__((__aligned__(65536)))
 #else
@@ -212,7 +212,6 @@ void pkey_disable_set(int pkey, int flags)
 	unsigned long syscall_flags = 0;
 	int ret;
 	int pkey_rights;
-	u64 orig_pkey_reg = read_pkey_reg();
 
 	dprintf1("START->%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
@@ -242,8 +241,6 @@ void pkey_disable_set(int pkey, int flags)
 
 	dprintf1("%s(%d) pkey_reg: 0x%016llx\n",
 		__func__, pkey, read_pkey_reg());
-	if (flags)
-		pkey_assert(read_pkey_reg() >= orig_pkey_reg);
 	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
 }
@@ -253,7 +250,6 @@ void pkey_disable_clear(int pkey, int flags)
 	unsigned long syscall_flags = 0;
 	int ret;
 	int pkey_rights = hw_pkey_get(pkey, syscall_flags);
-	u64 orig_pkey_reg = read_pkey_reg();
 
 	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
 
@@ -273,8 +269,6 @@ void pkey_disable_clear(int pkey, int flags)
 
 	dprintf1("%s(%d) pkey_reg: 0x%016llx\n", __func__,
 			pkey, read_pkey_reg());
-	if (flags)
-		assert(read_pkey_reg() <= orig_pkey_reg);
 }
 
 void pkey_write_allow(int pkey)
@@ -330,8 +324,8 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 			__func__, __LINE__,
 			__read_pkey_reg(), shadow_pkey_reg);
 
-	trapno = uctxt->uc_mcontext.gregs[REG_TRAPNO];
-	ip = uctxt->uc_mcontext.gregs[REG_IP_IDX];
+	trapno = MCONTEXT_TRAPNO(uctxt->uc_mcontext);
+	ip = MCONTEXT_IP(uctxt->uc_mcontext);
 #ifdef MCONTEXT_FPREGS
 	fpregs = (char *) uctxt->uc_mcontext.fpregs;
 #endif
@@ -395,6 +389,8 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 #elif defined(__powerpc64__) /* arch */
 	/* restore access and let the faulting instruction continue */
 	pkey_access_allow(siginfo_pkey);
+#elif defined(__aarch64__)
+	aarch64_write_signal_pkey(uctxt, PKEY_ALLOW_ALL);
 #endif /* arch */
 	pkey_faults++;
 	dprintf1("<<<<==================================================\n");
@@ -908,7 +904,9 @@ void expected_pkey_fault(int pkey)
 	 * test program continue.  We now have to restore it.
 	 */
 	if (__read_pkey_reg() != 0)
-#else /* arch */
+#elif defined(__aarch64__)
+	if (__read_pkey_reg() != PKEY_ALLOW_ALL)
+#else
 	if (__read_pkey_reg() != shadow_pkey_reg)
 #endif /* arch */
 		pkey_assert(0);
@@ -1498,6 +1496,11 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	lots_o_noops_around_write(&scratch);
 	do_not_expect_pkey_fault("executing on PROT_EXEC memory");
 	expect_fault_on_read_execonly_key(p1, pkey);
+
+	// Reset back to PROT_EXEC | PROT_READ for architectures that support
+	// non-PKEY execute-only permissions.
+	ret = mprotect_pkey(p1, PAGE_SIZE, PROT_EXEC | PROT_READ, (u64)pkey);
+	pkey_assert(!ret);
 }
 
 void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
@@ -1671,6 +1674,84 @@ void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
 }
 #endif
 
+#if defined(__aarch64__)
+void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
+{
+	pid_t child;
+	int status, ret;
+	struct iovec iov;
+	u64 trace_pkey;
+	/* Just a random pkey value.. */
+	u64 new_pkey = (POE_X << PKEY_BITS_PER_PKEY * 2) |
+			(POE_NONE << PKEY_BITS_PER_PKEY) |
+			POE_RWX;
+
+	child = fork();
+	pkey_assert(child >= 0);
+	dprintf3("[%d] fork() ret: %d\n", getpid(), child);
+	if (!child) {
+		ptrace(PTRACE_TRACEME, 0, 0, 0);
+
+		/* Stop and allow the tracer to modify PKRU directly */
+		raise(SIGSTOP);
+
+		/*
+		 * need __read_pkey_reg() version so we do not do shadow_pkey_reg
+		 * checking
+		 */
+		if (__read_pkey_reg() != new_pkey)
+			exit(1);
+
+		raise(SIGSTOP);
+
+		exit(0);
+	}
+
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
+
+	iov.iov_base = &trace_pkey;
+	iov.iov_len = 8;
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_ARM_POE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(trace_pkey == read_pkey_reg());
+
+	trace_pkey = new_pkey;
+
+	ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_ARM_POE, &iov);
+	pkey_assert(ret == 0);
+
+	/* Test that the modification is visible in ptrace before any execution */
+	memset(&trace_pkey, 0, sizeof(trace_pkey));
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_ARM_POE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(trace_pkey == new_pkey);
+
+	/* Execute the tracee */
+	ret = ptrace(PTRACE_CONT, child, 0, 0);
+	pkey_assert(ret == 0);
+
+	/* Test that the tracee saw the PKRU value change */
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
+
+	/* Test that the modification is visible in ptrace after execution */
+	memset(&trace_pkey, 0, sizeof(trace_pkey));
+	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_ARM_POE, &iov);
+	pkey_assert(ret == 0);
+	pkey_assert(trace_pkey == new_pkey);
+
+	ret = ptrace(PTRACE_CONT, child, 0, 0);
+	pkey_assert(ret == 0);
+	pkey_assert(child == waitpid(child, &status, 0));
+	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
+	pkey_assert(WIFEXITED(status));
+	pkey_assert(WEXITSTATUS(status) == 0);
+}
+#endif
+
 void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 {
 	int size = PAGE_SIZE;
@@ -1706,7 +1787,7 @@ void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_pkey_syscalls_bad_args,
 	test_pkey_alloc_exhaust,
 	test_pkey_alloc_free_attach_pkey0,
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
 	test_ptrace_modifies_pkru,
 #endif
 };
-- 
2.25.1


