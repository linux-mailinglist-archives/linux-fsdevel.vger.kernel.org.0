Return-Path: <linux-fsdevel+bounces-44082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 862C7A61F34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B49B7A67C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB6A205E3E;
	Fri, 14 Mar 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YAasErPG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA921D5B4
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988445; cv=none; b=r+1v1agOt2wKbb+uDuY/GmHYGyqyARc1Ff2k3EqoyzNhFulAe9OStYlUwZDC7PwHnMnQ9c7pJwWrrToTlSR0gRO78egoAvtf0fnZpp8LxKIkk7CDRLHbhdtZAgt7VvJl5aeCLLl8ZeQZ1pL9b1gn2OcyV32wcVel5BVrk9q20tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988445; c=relaxed/simple;
	bh=aDJDtSNVxJhQklms4uNlj3ySQS4OH8t+GvORqHNcI/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+2UT4MZC2Y9LqzXrn1+3sd2xVJTg12b+ZMzDm7rP0Ho0+5Gxnx6kKPcJJBvgXaX7+wbB/gjZ0IxorlVWlKdgJyhNO4uJQPvsqe1I/cgjmcuJ3HlKHrPGoxui5PZytbytQEBQaev0McFxEJCb5IkbMchNxk3O1zNMBMT8BDte2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YAasErPG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22409077c06so66622815ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988442; x=1742593242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmfcaIG2+ZxQBL2rW8bdYIb6OkoBiSfoVoV6JRsGlDE=;
        b=YAasErPG/6t0+lIfyndPpjjyIKK69eKsqDoyAkk4iciRFlIe+JysxHr3RFeqQu3Ipl
         Urv5A/Gd73LDFWcQDjiaxYQk/h3OV/p511Qa15GEr17gf2/+1exZEKPD8cIzU0atOyu3
         +bpKT8EPTNybUmdscbY/CTsnp0XVYZIuIVFzrFAzhqV9v2rkT0+KSmDbuTdMzP64xWwd
         9N2hXo249Ugj/9lFSmfrUaDanHUlACRsJ9omnMlMVy5OXiP+W07PoC6/wZm1pyFxNu/2
         uNGRh/JNag4jSmy/A8VTEq9hevXdujIEOKmkS7avdzqJXHyRr6ju5/8drDnxdemb4oHo
         h5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988442; x=1742593242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmfcaIG2+ZxQBL2rW8bdYIb6OkoBiSfoVoV6JRsGlDE=;
        b=WJ+9V0gRge96S5dlTkhE7/tyofCLnjdzfqeeF8ZUeMpmr4nobanx3w7ipo32TSj3uY
         ZcoCT0+kyBBzMyBsFlulzb2oKmela3kUi+RpUo9xmZYbjzkaKmtte9l85sjlRcWk/Z/5
         gwb9Vo7JctvToHMXo6yXhdPwR43eJZNQJ6kJw1yW/UcxROGEj30sU/bXAaaaGAMIhjt2
         gQv6ZPjQvhZrHeMe/E8uhX51ARqwN/mMXrQysVGSVLkTlRFu28GlPHMqT9tM7Cx4GL+1
         V4/VhXG/n9CWCTTv25W43V1yPwR0ZrSlkEWX8IgVy85eiOvTm1zmCMX8rZksp31ECKZU
         KPfw==
X-Forwarded-Encrypted: i=1; AJvYcCUqzIq2gSDJNhRWyejwgW2Gnf7Pls8RKpEeAFodo1XWoa3aBfdvP875wxnE80RiDqNV6GZgTsFjKI98n4Ej@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo28s9hTxKeHy/Klmd2/iaN9iv8Bvw8ylQ342dk4+8/QEg4q8H
	8MxRiw97QYZb0eGUbn3rATxW8VHnUDKeLgcPDlgwRwMzjbusB+O+7ElVAQY5guQ=
X-Gm-Gg: ASbGncvNJdrl6OlJaz41UxBJMU7hIVC2wlMwAm0qKAFSvJFk8D0Crm/9KxvDeR/L3v9
	qzGOlmSiK7ZuIo9e/SeVe7DhLc7ro47aaYSlsZI/lMQylyzrEpbuY0PtU6woP1QOIjQK7+LBe3K
	31zAcQ4AQxFlapeq378gAs2YbfLKpeIumypH8tVulEqwUWBgdIENOOuFwquMa1AVQSXyh5eyluK
	6HvTkLqFyFxTkGIfU4JuguARGXpWxv40MC5+EBOsmGo5GO9iSFs/nLAIq27kxW2RNoTTUVI5fxL
	bAfzs9wgAX3VUlHtZCVEeBrP2MAy0wAcsV/jFISiZhPU7pkceKSXQ/k=
X-Google-Smtp-Source: AGHT+IE/Z8vCidWa22GabdcVyMtBUcBNFMuQ7kyBxtmbMBnahHWy+xRZHQk35AiDOY5DS3SuGw5AFw==
X-Received: by 2002:a17:903:19ed:b0:224:26f5:9c1e with SMTP id d9443c01a7336-225e0a15b4dmr54069005ad.2.1741988441930;
        Fri, 14 Mar 2025 14:40:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:40:41 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:47 -0700
Subject: [PATCH v12 28/28] kselftest/riscv: kselftest for user mode cfi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-28-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Adds kselftest for RISC-V control flow integrity implementation for user
mode. There is not a lot going on in kernel for enabling landing pad for
user mode. cfi selftest are intended to be compiled with zicfilp and
zicfiss enabled compiler. Thus kselftest simply checks if landing pad and
shadow stack for the binary and process are enabled or not. selftest then
register a signal handler for SIGSEGV. Any control flow violation are
reported as SIGSEGV with si_code = SEGV_CPERR. Test will fail on receiving
any SEGV_CPERR. Shadow stack part has more changes in kernel and thus there
are separate tests for that

- Exercise `map_shadow_stack` syscall
- `fork` test to make sure COW works for shadow stack pages
- gup tests
  Kernel uses FOLL_FORCE when access happens to memory via
  /proc/<pid>/mem. Not breaking that for shadow stack.
- signal test. Make sure signal delivery results in token creation on
  shadow stack and consumes (and verifies) token on sigreturn
- shadow stack protection test. attempts to write using regular store
  instruction on shadow stack memory must result in access faults

Test outut
==========

"""
TAP version 13
1..5
  This is to ensure shadow stack is indeed enabled and working
  This is to ensure shadow stack is indeed enabled and working
ok 1 shstk fork test
ok 2 map shadow stack syscall
ok 3 shadow stack gup tests
ok 4 shadow stack signal tests
ok 5 memory protections of shadow stack memory
"""

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 tools/testing/selftests/riscv/Makefile             |   2 +-
 tools/testing/selftests/riscv/cfi/.gitignore       |   3 +
 tools/testing/selftests/riscv/cfi/Makefile         |  10 +
 tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  82 +++++
 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c |  78 +++++
 tools/testing/selftests/riscv/cfi/shadowstack.c    | 385 +++++++++++++++++++++
 tools/testing/selftests/riscv/cfi/shadowstack.h    |  27 ++
 7 files changed, 586 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 099b8c1f46f8..5671b4405a12 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector
+RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector cfi
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/cfi/.gitignore b/tools/testing/selftests/riscv/cfi/.gitignore
new file mode 100644
index 000000000000..82545863bac6
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/.gitignore
@@ -0,0 +1,3 @@
+cfitests
+riscv_cfi_test
+shadowstack
diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
new file mode 100644
index 000000000000..b65f7ff38a32
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/Makefile
@@ -0,0 +1,10 @@
+CFLAGS += -I$(top_srcdir)/tools/include
+
+CFLAGS += -march=rv64gc_zicfilp_zicfiss
+
+TEST_GEN_PROGS := cfitests
+
+include ../../lib.mk
+
+$(OUTPUT)/cfitests: riscv_cfi_test.c shadowstack.c
+	$(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/cfi/cfi_rv_test.h b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
new file mode 100644
index 000000000000..1c8043f2b778
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef SELFTEST_RISCV_CFI_H
+#define SELFTEST_RISCV_CFI_H
+#include <stddef.h>
+#include <sys/types.h>
+#include "shadowstack.h"
+
+#define CHILD_EXIT_CODE_SSWRITE		10
+#define CHILD_EXIT_CODE_SIG_TEST	11
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)			\
+({									\
+	register long _num  __asm__ ("a7") = (num);			\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);		\
+	register long _arg5 __asm__ ("a4") = (long)(arg5);		\
+									\
+	__asm__ volatile(						\
+		"ecall\n"						\
+		: "+r"							\
+		(_arg1)							\
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "r"(_num)						\
+		: "memory", "cc"					\
+	);								\
+	_arg1;								\
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)				\
+({									\
+	register long _num  __asm__ ("a7") = (num);			\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
+									\
+	__asm__ volatile(						\
+		"ecall\n"						\
+		: "+r" (_arg1)						\
+		: "r"(_arg2), "r"(_arg3),				\
+		  "r"(_num)						\
+		: "memory", "cc"					\
+	);								\
+	_arg1;								\
+})
+
+#ifndef __NR_prctl
+#define __NR_prctl 167
+#endif
+
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack 453
+#endif
+
+#define CSR_SSP 0x011
+
+#ifdef __ASSEMBLY__
+#define __ASM_STR(x)    x
+#else
+#define __ASM_STR(x)    #x
+#endif
+
+#define csr_read(csr)							\
+({									\
+	register unsigned long __v;					\
+	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)		\
+				: "=r" (__v) :				\
+				: "memory");				\
+	__v;								\
+})
+
+#define csr_write(csr, val)						\
+({									\
+	unsigned long __v = (unsigned long)(val);			\
+	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"		\
+				: : "rK" (__v)				\
+				: "memory");				\
+})
+
+#endif
diff --git a/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
new file mode 100644
index 000000000000..cf33aa25cc73
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../../kselftest.h"
+#include <sys/signal.h>
+#include <asm/ucontext.h>
+#include <linux/prctl.h>
+#include "cfi_rv_test.h"
+
+/* do not optimize cfi related test functions */
+#pragma GCC push_options
+#pragma GCC optimize("O0")
+
+void sigsegv_handler(int signum, siginfo_t *si, void *uc)
+{
+	struct ucontext *ctx = (struct ucontext *)uc;
+
+	if (si->si_code == SEGV_CPERR) {
+		ksft_print_msg("Control flow violation happened somewhere\n");
+		ksft_print_msg("PC where violation happened %lx\n", ctx->uc_mcontext.gregs[0]);
+		exit(-1);
+	}
+
+	/* all other cases are expected to be of shadow stack write case */
+	exit(CHILD_EXIT_CODE_SSWRITE);
+}
+
+bool register_signal_handler(void)
+{
+	struct sigaction sa = {};
+
+	sa.sa_sigaction = sigsegv_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGSEGV, &sa, NULL)) {
+		ksft_print_msg("Registering signal handler for landing pad violation failed\n");
+		return false;
+	}
+
+	return true;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+	unsigned long lpad_status = 0, ss_status = 0;
+
+	ksft_print_header();
+
+	ksft_print_msg("Starting risc-v tests\n");
+
+	/*
+	 * Landing pad test. Not a lot of kernel changes to support landing
+	 * pad for user mode except lighting up a bit in senvcfg via a prctl
+	 * Enable landing pad through out the execution of test binary
+	 */
+	ret = my_syscall5(__NR_prctl, PR_GET_INDIR_BR_LP_STATUS, &lpad_status, 0, 0, 0);
+	if (ret)
+		ksft_exit_fail_msg("Get landing pad status failed with %d\n", ret);
+
+	if (!(lpad_status & PR_INDIR_BR_LP_ENABLE))
+		ksft_exit_fail_msg("Landing pad is not enabled, should be enabled via glibc\n");
+
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
+	if (ret)
+		ksft_exit_fail_msg("Get shadow stack failed with %d\n", ret);
+
+	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
+		ksft_exit_fail_msg("Shadow stack is not enabled, should be enabled via glibc\n");
+
+	if (!register_signal_handler())
+		ksft_exit_fail_msg("Registering signal handler for SIGSEGV failed\n");
+
+	ksft_print_msg("Landing pad and shadow stack are enabled for binary\n");
+	execute_shadow_stack_tests();
+
+	return 0;
+}
+
+#pragma GCC pop_options
diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.c b/tools/testing/selftests/riscv/cfi/shadowstack.c
new file mode 100644
index 000000000000..53387dbd9cf5
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/shadowstack.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../../kselftest.h"
+#include <sys/wait.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <asm-generic/unistd.h>
+#include <sys/mman.h>
+#include "shadowstack.h"
+#include "cfi_rv_test.h"
+
+static struct shadow_stack_tests shstk_tests[] = {
+	{ "shstk fork test\n", shadow_stack_fork_test },
+	{ "map shadow stack syscall\n", shadow_stack_map_test },
+	{ "shadow stack gup tests\n", shadow_stack_gup_tests },
+	{ "shadow stack signal tests\n", shadow_stack_signal_test},
+	{ "memory protections of shadow stack memory\n", shadow_stack_protection_test }
+};
+
+#define RISCV_SHADOW_STACK_TESTS ARRAY_SIZE(shstk_tests)
+
+/* do not optimize shadow stack related test functions */
+#pragma GCC push_options
+#pragma GCC optimize("O0")
+
+void zar(void)
+{
+	unsigned long ssp = 0;
+
+	ssp = csr_read(CSR_SSP);
+	ksft_print_msg("Spewing out shadow stack ptr: %lx\n"
+			"  This is to ensure shadow stack is indeed enabled and working\n",
+			ssp);
+}
+
+void bar(void)
+{
+	zar();
+}
+
+void foo(void)
+{
+	bar();
+}
+
+void zar_child(void)
+{
+	unsigned long ssp = 0;
+
+	ssp = csr_read(CSR_SSP);
+	ksft_print_msg("Spewing out shadow stack ptr: %lx\n"
+			"  This is to ensure shadow stack is indeed enabled and working\n",
+			ssp);
+}
+
+void bar_child(void)
+{
+	zar_child();
+}
+
+void foo_child(void)
+{
+	bar_child();
+}
+
+typedef void (call_func_ptr)(void);
+/*
+ * call couple of functions to test push pop.
+ */
+int shadow_stack_call_tests(call_func_ptr fn_ptr, bool parent)
+{
+	ksft_print_msg("dummy calls for sspush and sspopchk in context of %s\n",
+		       parent ? "parent" : "child");
+
+	(fn_ptr)();
+
+	return 0;
+}
+
+/* forks a thread, and ensure shadow stacks fork out */
+bool shadow_stack_fork_test(unsigned long test_num, void *ctx)
+{
+	int pid = 0, child_status = 0, parent_pid = 0, ret = 0;
+	unsigned long ss_status = 0;
+
+	ksft_print_msg("Exercising shadow stack fork test\n");
+
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
+	if (ret) {
+		ksft_exit_skip("Shadow stack get status prctl failed with errorcode %d\n", ret);
+		return false;
+	}
+
+	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
+		ksft_exit_skip("Shadow stack is not enabled, should be enabled via glibc\n");
+
+	parent_pid = getpid();
+	pid = fork();
+
+	if (pid) {
+		ksft_print_msg("Parent pid %d and child pid %d\n", parent_pid, pid);
+		shadow_stack_call_tests(&foo, true);
+	} else {
+		shadow_stack_call_tests(&foo_child, false);
+	}
+
+	if (pid) {
+		ksft_print_msg("Waiting on child to finish\n");
+		wait(&child_status);
+	} else {
+		/* exit child gracefully */
+		exit(0);
+	}
+
+	if (pid && WIFSIGNALED(child_status)) {
+		ksft_print_msg("Child faulted, fork test failed\n");
+		return false;
+	}
+
+	return true;
+}
+
+/* exercise `map_shadow_stack`, pivot to it and call some functions to ensure it works */
+#define SHADOW_STACK_ALLOC_SIZE 4096
+bool shadow_stack_map_test(unsigned long test_num, void *ctx)
+{
+	unsigned long shdw_addr;
+	int ret = 0;
+
+	ksft_print_msg("Exercising shadow stack map test\n");
+
+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
+
+	if (((long)shdw_addr) <= 0) {
+		ksft_print_msg("map_shadow_stack failed with error code %d\n",
+			       (int)shdw_addr);
+		return false;
+	}
+
+	ret = munmap((void *)shdw_addr, SHADOW_STACK_ALLOC_SIZE);
+
+	if (ret) {
+		ksft_print_msg("munmap failed with error code %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * shadow stack protection tests. map a shadow stack and
+ * validate all memory protections work on it
+ */
+bool shadow_stack_protection_test(unsigned long test_num, void *ctx)
+{
+	unsigned long shdw_addr;
+	unsigned long *write_addr = NULL;
+	int ret = 0, pid = 0, child_status = 0;
+
+	ksft_print_msg("Exercising shadow stack protection test (WPT)\n");
+
+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
+
+	if (((long)shdw_addr) <= 0) {
+		ksft_print_msg("map_shadow_stack failed with error code %d\n",
+			       (int)shdw_addr);
+		return false;
+	}
+
+	write_addr = (unsigned long *)shdw_addr;
+	pid = fork();
+
+	/* no child was created, return false */
+	if (pid == -1)
+		return false;
+
+	/*
+	 * try to perform a store from child on shadow stack memory
+	 * it should result in SIGSEGV
+	 */
+	if (!pid) {
+		/* below write must lead to SIGSEGV */
+		*write_addr = 0xdeadbeef;
+	} else {
+		wait(&child_status);
+	}
+
+	/* test fail, if 0xdeadbeef present on shadow stack address */
+	if (*write_addr == 0xdeadbeef) {
+		ksft_print_msg("Shadow stack WPT failed\n");
+		return false;
+	}
+
+	/* if child reached here, then fail */
+	if (!pid) {
+		ksft_print_msg("Shadow stack WPT failed: child reached unreachable state\n");
+		return false;
+	}
+
+	/* if child exited via signal handler but not for write on ss */
+	if (WIFEXITED(child_status) &&
+	    WEXITSTATUS(child_status) != CHILD_EXIT_CODE_SSWRITE) {
+		ksft_print_msg("Shadow stack WPT failed: child wasn't signaled for write\n");
+		return false;
+	}
+
+	ret = munmap(write_addr, SHADOW_STACK_ALLOC_SIZE);
+	if (ret) {
+		ksft_print_msg("Shadow stack WPT failed: munmap failed, error code %d\n",
+			       ret);
+		return false;
+	}
+
+	return true;
+}
+
+#define SS_MAGIC_WRITE_VAL 0xbeefdead
+
+int gup_tests(int mem_fd, unsigned long *shdw_addr)
+{
+	unsigned long val = 0;
+
+	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
+	if (read(mem_fd, &val, sizeof(val)) < 0) {
+		ksft_print_msg("Reading shadow stack mem via gup failed\n");
+		return 1;
+	}
+
+	val = SS_MAGIC_WRITE_VAL;
+	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
+	if (write(mem_fd, &val, sizeof(val)) < 0) {
+		ksft_print_msg("Writing shadow stack mem via gup failed\n");
+		return 1;
+	}
+
+	if (*shdw_addr != SS_MAGIC_WRITE_VAL) {
+		ksft_print_msg("GUP write to shadow stack memory failed\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+bool shadow_stack_gup_tests(unsigned long test_num, void *ctx)
+{
+	unsigned long shdw_addr = 0;
+	unsigned long *write_addr = NULL;
+	int fd = 0;
+	bool ret = false;
+
+	ksft_print_msg("Exercising shadow stack gup tests\n");
+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
+
+	if (((long)shdw_addr) <= 0) {
+		ksft_print_msg("map_shadow_stack failed with error code %d\n", (int)shdw_addr);
+		return false;
+	}
+
+	write_addr = (unsigned long *)shdw_addr;
+
+	fd = open("/proc/self/mem", O_RDWR);
+	if (fd == -1)
+		return false;
+
+	if (gup_tests(fd, write_addr)) {
+		ksft_print_msg("gup tests failed\n");
+		goto out;
+	}
+
+	ret = true;
+out:
+	if (shdw_addr && munmap(write_addr, SHADOW_STACK_ALLOC_SIZE)) {
+		ksft_print_msg("munmap failed with error code %d\n", ret);
+		ret = false;
+	}
+
+	return ret;
+}
+
+volatile bool break_loop;
+
+void sigusr1_handler(int signo)
+{
+	break_loop = true;
+}
+
+bool sigusr1_signal_test(void)
+{
+	struct sigaction sa = {};
+
+	sa.sa_handler = sigusr1_handler;
+	sa.sa_flags = 0;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL)) {
+		ksft_print_msg("Registering signal handler for SIGUSR1 failed\n");
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * shadow stack signal test. shadow stack must be enabled.
+ * register a signal, fork another thread which is waiting
+ * on signal. Send a signal from parent to child, verify
+ * that signal was received by child. If not test fails
+ */
+bool shadow_stack_signal_test(unsigned long test_num, void *ctx)
+{
+	int pid = 0, child_status = 0, ret = 0;
+	unsigned long ss_status = 0;
+
+	ksft_print_msg("Exercising shadow stack signal test\n");
+
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
+	if (ret) {
+		ksft_print_msg("Shadow stack get status prctl failed with errorcode %d\n", ret);
+		return false;
+	}
+
+	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
+		ksft_print_msg("Shadow stack is not enabled, should be enabled via glibc\n");
+
+	/* this should be caught by signal handler and do an exit */
+	if (!sigusr1_signal_test()) {
+		ksft_print_msg("Registering sigusr1 handler failed\n");
+		exit(-1);
+	}
+
+	pid = fork();
+
+	if (pid == -1) {
+		ksft_print_msg("Signal test: fork failed\n");
+		goto out;
+	}
+
+	if (pid == 0) {
+		while (!break_loop)
+			sleep(1);
+
+		exit(11);
+		/* child shouldn't go beyond here */
+	}
+
+	/* send SIGUSR1 to child */
+	kill(pid, SIGUSR1);
+	wait(&child_status);
+
+out:
+
+	return (WIFEXITED(child_status) &&
+		WEXITSTATUS(child_status) == 11);
+}
+
+int execute_shadow_stack_tests(void)
+{
+	int ret = 0;
+	unsigned long test_count = 0;
+	unsigned long shstk_status = 0;
+	bool test_pass = false;
+
+	ksft_print_msg("Executing RISC-V shadow stack self tests\n");
+	ksft_set_plan(RISCV_SHADOW_STACK_TESTS);
+
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &shstk_status, 0, 0, 0);
+
+	if (ret != 0)
+		ksft_exit_fail_msg("Get shadow stack status failed with %d\n", ret);
+
+	/*
+	 * If we are here that means get shadow stack status succeeded and
+	 * thus shadow stack support is baked in the kernel.
+	 */
+	while (test_count < RISCV_SHADOW_STACK_TESTS) {
+		test_pass = (*shstk_tests[test_count].t_func)(test_count, NULL);
+		ksft_test_result(test_pass, shstk_tests[test_count].name);
+		test_count++;
+	}
+
+	ksft_finished();
+
+	return 0;
+}
+
+#pragma GCC pop_options
diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.h b/tools/testing/selftests/riscv/cfi/shadowstack.h
new file mode 100644
index 000000000000..0be510167de3
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/shadowstack.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef SELFTEST_SHADOWSTACK_TEST_H
+#define SELFTEST_SHADOWSTACK_TEST_H
+#include <stddef.h>
+#include <linux/prctl.h>
+
+/*
+ * a cfi test returns true for success or false for fail
+ * takes a number for test number to index into array and void pointer.
+ */
+typedef bool (*shstk_test_func)(unsigned long test_num, void *);
+
+struct shadow_stack_tests {
+	char *name;
+	shstk_test_func t_func;
+};
+
+bool shadow_stack_fork_test(unsigned long test_num, void *ctx);
+bool shadow_stack_map_test(unsigned long test_num, void *ctx);
+bool shadow_stack_protection_test(unsigned long test_num, void *ctx);
+bool shadow_stack_gup_tests(unsigned long test_num, void *ctx);
+bool shadow_stack_signal_test(unsigned long test_num, void *ctx);
+
+int execute_shadow_stack_tests(void);
+
+#endif

-- 
2.34.1


