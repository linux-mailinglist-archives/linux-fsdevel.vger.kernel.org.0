Return-Path: <linux-fsdevel+bounces-29262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8E977584
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F392810D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799C71D54F8;
	Thu, 12 Sep 2024 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DUUUVGSJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47CB1D589B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183159; cv=none; b=Mgfr+/JOuvhUbsc3f1tvmiGLhTLLW8d8bYwUX/zGl8ZGXQiZDio04cIMLZudStZdiQGQ8/R2V8oN1rQOrb+s5HCxNoPSMnigDXLHEY0AB+oBWMe4VJePBwHt81thfHnVqAoqGKa9ayoqOqnlw4P35cIrLA+BxS7GVk8l78NXzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183159; c=relaxed/simple;
	bh=ZCc6FTZHXXW5kEZqA38vYAGz9VgfaN/GxxTy8XAnvcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je4hp531Zpvvr+EO5zknoDcHuT/MEGcJOTtU8pwb85MjJCH1OJBZaPA1E3Zu8AenMUQSID7liifoSzP+eEYs5IC80PQ+z0lY4UAFCHaa2Jhti4RMf4SoUs/8zjF9UfS6OCfkBEZAogyySzwRtWRuppjk4jV6HxnMsNRuV/botk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DUUUVGSJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so1075719a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183157; x=1726787957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVdPJDxrp4GQLJ67J34Jd5yxy8wiSM/nJ+ybt6ixXzo=;
        b=DUUUVGSJGBTql+WixzahFZhL8ihpHGfsJqas9Pj+0oS0PxS7ypfHkoU5MQkiWLUQKY
         2wwIscyfO/LIpl1hiUxuRaR9rm0eN3NkGBRvMiBdpQwvOfLvLDuN2fuSag3cOVnOgWoG
         zmsbkaXBNJ/jg2q6DZEts1yswfa+liB9yB0065dk8rPjPG5AH6BW/Eow90BYzFMSpDil
         gRYAfl3RaxhK3HU3fd3nr1pHqExf34fSMgp0fWmC+f1fEfmZoEduJiCuPY/OW0DoijoN
         8SeBIk/SmnZEJY5GIbIf/QqUoxedXsyjEJgzAmzbsiZynSk5w3gdWqF2KfDO7RhARMBo
         o5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183157; x=1726787957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVdPJDxrp4GQLJ67J34Jd5yxy8wiSM/nJ+ybt6ixXzo=;
        b=jHaQwMrI0/+Y3D/H96AoJzrarPDByAWjScsrrsOK9AH13cJtkvBrxSp0aUEa5UVK7m
         yuTPZyz2RMiF02TS49FstBnzQEDDZfpTs5yxzFyxzv+iP0E5sih+pC31PiD4Q8IxxqBi
         lz9PYNnIpj22oUyhPdZdZotqJcINlsdmBQ2ce/O7VoHs6xciIshFFjRm1h7MlCR1mTZY
         KencRpJ984px9EbOayz8FS2XW3VJw0Y1uQSI2AUpjQLxjo27kESyS+pBskB9rugdWQdx
         8T6DveGA47AwcgLEyGuzjKUdvpsnY37IlP20dnlqRvNBMxv+7JhDoXVKh4RbTrtFSphS
         Rabg==
X-Forwarded-Encrypted: i=1; AJvYcCV+pCOk9qKGa1C6qmF+7HpkCWWXic1zzutL8aqjd6Jg8zJZXYfc+mo5AdHnG5pM77oAMBWB6VCxhAQk1h9F@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPH7e0y9bplz8zcNdkl5lGewRKSf3DJUlDR2Dc1yJjBoKEotO
	Eg0GPzPBJ6u9GPc+/qKzdn7BZjHlxsBdaHc0mRqUX8kcwNwyutKmKS8l450f/YA=
X-Google-Smtp-Source: AGHT+IFa1E6JbsxaJrJsFmbVg23swDSS4CmQmqqMr+KiY/4/NtDGDjZvIx2bH3fN7YatZbXcXm2b+w==
X-Received: by 2002:a17:90a:684c:b0:2d3:d414:4511 with SMTP id 98e67ed59e1d1-2db9ffefa37mr4941681a91.24.1726183157074;
        Thu, 12 Sep 2024 16:19:17 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:19:16 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 30/30] kselftest/riscv: kselftest for user mode cfi
Date: Thu, 12 Sep 2024 16:16:49 -0700
Message-ID: <20240912231650.3740732-31-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
	  As of today kernel uses FOLL_FORCE when access happens to memory via
	  /proc/<pid>/mem. Not breaking that for shadow stack
	- signal test. Make sure signal delivery results in token creation on
      shadow stack and consumes (and verifies) token on sigreturn
    - shadow stack protection test. attempts to write using regular store
	  instruction on shadow stack memory must result in access faults

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/cfi/.gitignore  |   3 +
 tools/testing/selftests/riscv/cfi/Makefile    |  10 +
 .../testing/selftests/riscv/cfi/cfi_rv_test.h |  83 ++++
 .../selftests/riscv/cfi/riscv_cfi_test.c      |  82 ++++
 .../testing/selftests/riscv/cfi/shadowstack.c | 362 ++++++++++++++++++
 .../testing/selftests/riscv/cfi/shadowstack.h |  37 ++
 7 files changed, 578 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/cfi/.gitignore
 create mode 100644 tools/testing/selftests/riscv/cfi/Makefile
 create mode 100644 tools/testing/selftests/riscv/cfi/cfi_rv_test.h
 create mode 100644 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
 create mode 100644 tools/testing/selftests/riscv/cfi/shadowstack.c
 create mode 100644 tools/testing/selftests/riscv/cfi/shadowstack.h

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 7ce03d832b64..6e142fe004ab 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
+RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn cfi
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/cfi/.gitignore b/tools/testing/selftests/riscv/cfi/.gitignore
new file mode 100644
index 000000000000..ce7623f9da28
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/.gitignore
@@ -0,0 +1,3 @@
+cfitests
+riscv_cfi_test
+shadowstack
\ No newline at end of file
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
index 000000000000..fa1cf7183672
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef SELFTEST_RISCV_CFI_H
+#define SELFTEST_RISCV_CFI_H
+#include <stddef.h>
+#include <sys/types.h>
+#include "shadowstack.h"
+
+#define RISCV_CFI_SELFTEST_COUNT RISCV_SHADOW_STACK_TESTS
+
+#define CHILD_EXIT_CODE_SSWRITE		10
+#define CHILD_EXIT_CODE_SIG_TEST	11
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)		\
+({															\
+	register long _num  __asm__ ("a7") = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);		\
+	register long _arg5 __asm__ ("a4") = (long)(arg5);		\
+															\
+	__asm__ volatile (										\
+		"ecall\n"											\
+		: "+r"(_arg1)										\
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "r"(_num)											\
+		: "memory", "cc"									\
+	);														\
+	_arg1;													\
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)					\
+({															\
+	register long _num  __asm__ ("a7") = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
+															\
+	__asm__ volatile (										\
+		"ecall\n"											\
+		: "+r"(_arg1)										\
+		: "r"(_arg2), "r"(_arg3),							\
+		  "r"(_num)											\
+		: "memory", "cc"									\
+	);														\
+	_arg1;													\
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
+#define csr_read(csr)									\
+({														\
+	register unsigned long __v;							\
+	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)	\
+						  : "=r" (__v) :				\
+						  : "memory");					\
+	__v;												\
+})
+
+#define csr_write(csr, val)								\
+({														\
+	unsigned long __v = (unsigned long) (val);			\
+	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"	\
+						  : : "rK" (__v)				\
+						  : "memory");					\
+})
+
+#endif
diff --git a/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
new file mode 100644
index 000000000000..f22b3f0f24de
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../../kselftest.h"
+#include <signal.h>
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
+	struct ucontext *ctx = (struct ucontext *) uc;
+
+	if (si->si_code == SEGV_CPERR) {
+		printf("Control flow violation happened somewhere\n");
+		printf("pc where violation happened %lx\n", ctx->uc_mcontext.gregs[0]);
+		exit(-1);
+	}
+
+	printf("In sigsegv handler\n");
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
+		printf("registering signal handler for landing pad violation failed\n");
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
+	ksft_set_plan(RISCV_CFI_SELFTEST_COUNT);
+
+	ksft_print_msg("starting risc-v tests\n");
+
+	/*
+	 * Landing pad test. Not a lot of kernel changes to support landing
+	 * pad for user mode except lighting up a bit in senvcfg via a prctl
+	 * Enable landing pad through out the execution of test binary
+	 */
+	ret = my_syscall5(__NR_prctl, PR_GET_INDIR_BR_LP_STATUS, &lpad_status, 0, 0, 0);
+	if (ret)
+		ksft_exit_skip("Get landing pad status failed with %d\n", ret);
+
+	if (!(lpad_status & PR_INDIR_BR_LP_ENABLE))
+		ksft_exit_skip("landing pad is not enabled, should be enabled via glibc\n");
+
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
+	if (ret)
+		ksft_exit_skip("Get shadow stack failed with %d\n", ret);
+
+	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
+		ksft_exit_skip("shadow stack is not enabled, should be enabled via glibc\n");
+
+	if (!register_signal_handler())
+		ksft_exit_skip("registering signal handler for SIGSEGV failed\n");
+
+	ksft_print_msg("landing pad and shadow stack are enabled for binary\n");
+	ksft_print_msg("starting risc-v shadow stack tests\n");
+	execute_shadow_stack_tests();
+
+	ksft_finished();
+}
+
+#pragma GCC pop_options
diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.c b/tools/testing/selftests/riscv/cfi/shadowstack.c
new file mode 100644
index 000000000000..2f65eb970c44
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/shadowstack.c
@@ -0,0 +1,362 @@
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
+/* do not optimize shadow stack related test functions */
+#pragma GCC push_options
+#pragma GCC optimize("O0")
+
+void zar(void)
+{
+	unsigned long ssp = 0;
+
+	ssp = csr_read(CSR_SSP);
+	printf("inside %s and shadow stack ptr is %lx\n", __func__, ssp);
+}
+
+void bar(void)
+{
+	printf("inside %s\n", __func__);
+	zar();
+}
+
+void foo(void)
+{
+	printf("inside %s\n", __func__);
+	bar();
+}
+
+void zar_child(void)
+{
+	unsigned long ssp = 0;
+
+	ssp = csr_read(CSR_SSP);
+	printf("inside %s and shadow stack ptr is %lx\n", __func__, ssp);
+}
+
+void bar_child(void)
+{
+	printf("inside %s\n", __func__);
+	zar_child();
+}
+
+void foo_child(void)
+{
+	printf("inside %s\n", __func__);
+	bar_child();
+}
+
+typedef void (call_func_ptr)(void);
+/*
+ * call couple of functions to test push pop.
+ */
+int shadow_stack_call_tests(call_func_ptr fn_ptr, bool parent)
+{
+	if (parent)
+		printf("call test for parent\n");
+	else
+		printf("call test for child\n");
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
+	printf("exercising shadow stack fork test\n");
+
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
+	if (ret) {
+		printf("shadow stack get status prctl failed with errorcode %d\n", ret);
+		return false;
+	}
+
+	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
+		ksft_exit_skip("shadow stack is not enabled, should be enabled via glibc\n");
+
+	parent_pid = getpid();
+	pid = fork();
+
+	if (pid) {
+		printf("Parent pid %d and child pid %d\n", parent_pid, pid);
+		shadow_stack_call_tests(&foo, true);
+	} else
+		shadow_stack_call_tests(&foo_child, false);
+
+	if (pid) {
+		printf("waiting on child to finish\n");
+		wait(&child_status);
+	} else {
+		/* exit child gracefully */
+		exit(0);
+	}
+
+	if (pid && WIFSIGNALED(child_status)) {
+		printf("child faulted");
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
+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
+
+	if (((long) shdw_addr) <= 0) {
+		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
+		return false;
+	}
+
+	ret = munmap((void *) shdw_addr, SHADOW_STACK_ALLOC_SIZE);
+
+	if (ret) {
+		printf("munmap failed with error code %d\n", ret);
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
+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
+
+	if (((long) shdw_addr) <= 0) {
+		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
+		return false;
+	}
+
+	write_addr = (unsigned long *) shdw_addr;
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
+		printf("write suceeded\n");
+		return false;
+	}
+
+	/* if child reached here, then fail */
+	if (!pid) {
+		printf("child reached unreachable state\n");
+		return false;
+	}
+
+	/* if child exited via signal handler but not for write on ss */
+	if (WIFEXITED(child_status) &&
+		WEXITSTATUS(child_status) != CHILD_EXIT_CODE_SSWRITE) {
+		printf("child wasn't signaled for write on shadow stack\n");
+		return false;
+	}
+
+	ret = munmap(write_addr, SHADOW_STACK_ALLOC_SIZE);
+	if (ret) {
+		printf("munmap failed with error code %d\n", ret);
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
+		printf("reading shadow stack mem via gup failed\n");
+		return 1;
+	}
+
+	val = SS_MAGIC_WRITE_VAL;
+	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
+	if (write(mem_fd, &val, sizeof(val)) < 0) {
+		printf("writing shadow stack mem via gup failed\n");
+		return 1;
+	}
+
+	if (*shdw_addr != SS_MAGIC_WRITE_VAL) {
+		printf("GUP write to shadow stack memory didn't happen\n");
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
+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
+
+	if (((long) shdw_addr) <= 0) {
+		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
+		return false;
+	}
+
+	write_addr = (unsigned long *) shdw_addr;
+
+	fd = open("/proc/self/mem", O_RDWR);
+	if (fd == -1)
+		return false;
+
+	if (gup_tests(fd, write_addr)) {
+		printf("gup tests failed\n");
+		goto out;
+	}
+
+	ret = true;
+out:
+	if (shdw_addr && munmap(write_addr, SHADOW_STACK_ALLOC_SIZE)) {
+		printf("munmap failed with error code %d\n", ret);
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
+	printf("In sigusr1 handler\n");
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
+		printf("registering signal handler for SIGUSR1 failed\n");
+		return false;
+	}
+
+	return true;
+}
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
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
+	if (ret) {
+		printf("shadow stack get status prctl failed with errorcode %d\n", ret);
+		return false;
+	}
+
+	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
+		ksft_exit_skip("shadow stack is not enabled, should be enabled via glibc\n");
+
+	/* this should be caught by signal handler and do an exit */
+	if (!sigusr1_signal_test()) {
+		printf("registering sigusr1 handler failed\n");
+		exit(-1);
+	}
+
+	pid = fork();
+
+	if (pid == -1) {
+		printf("signal test: fork failed\n");
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
+			WEXITSTATUS(child_status) == 11);
+}
+
+int execute_shadow_stack_tests(void)
+{
+	int ret = 0;
+	unsigned long test_count = 0;
+	unsigned long shstk_status = 0;
+
+	printf("Executing RISC-V shadow stack self tests\n");
+
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &shstk_status, 0, 0, 0);
+
+	if (ret != 0)
+		ksft_exit_skip("Get shadow stack status failed with %d\n", ret);
+
+	/*
+	 * If we are here that means get shadow stack status succeeded and
+	 * thus shadow stack support is baked in the kernel.
+	 */
+	while (test_count < ARRAY_SIZE(shstk_tests)) {
+		ksft_test_result((*shstk_tests[test_count].t_func)(test_count, NULL),
+						 shstk_tests[test_count].name);
+		test_count++;
+	}
+
+	return 0;
+}
+
+#pragma GCC pop_options
diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.h b/tools/testing/selftests/riscv/cfi/shadowstack.h
new file mode 100644
index 000000000000..b43e74136a26
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/shadowstack.h
@@ -0,0 +1,37 @@
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
+int execute_shadow_stack_tests(void);
+
+#endif
-- 
2.45.0


