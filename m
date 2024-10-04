Return-Path: <linux-fsdevel+bounces-31014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05141990F67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 21:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5588E1F22943
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311771DDA17;
	Fri,  4 Oct 2024 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0h1obPzv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B401DDA1F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068395; cv=none; b=ZTIOGXM/W7j4zQB1ABmN1pfSPon7UuYRxdKojilTTtthfglF+P9WV+D0DkDDnj8+6sdGN4o7SYuwk5+rzX/Eup41Z422wchLaDflMgtOYyLLlTjMV26PRmgtguf0uUKdqtoKAJnOpBWHh0bYLF+q7tgceQ5ZB1ph/lqN90/Ul28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068395; c=relaxed/simple;
	bh=qId7QrGu4eAX0rjyGXRgBJjg+FJe588dwC/h3V9Spvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl00pzmTJkDD1UOJWxKbRGJWF4MBM1gcEX8DAlG+6HD1gACX09Oc6bOcYhx6ZhnYT08FqxVeSnVoem6BHxenLVyw/yIngFfTPbZ+xwpdwqn1OG5x02m+J707HkmaxEpeEwkZ5oPlEn0ZxCqqyZ3nl3o5emDKmw6YdwzAOcxQuKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0h1obPzv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b9b35c7c3so25825145ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2024 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728068391; x=1728673191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxVDupioOAHgYm0omZMyX3FVywjjySfIoyGy7p70cqg=;
        b=0h1obPzvbIctMgdH9eCXUT1LZ3Tc4c/AK0VJt2IWH0eTA56KBseDqZpY8288jaHP82
         xjKHxEfWffFx3f5SJZCnc+peM7koBBMq9t+Pg9X5qWStbk6qXuFFcXtBNoJsMI3QjBf5
         hf9RpBf+cK6IuONdP4VzlMx1LQPPT8VHKuBUGkss41JYJ+3BBDRorlGv+IGyLEWT9+s3
         8+p0GZ02x/ZyewWzupAv0M8H3r99H0s/yQh+Ad2mWaEbNh/Xg6kZSmlsMjax0nUFeSBI
         33INh1rSYdNIrNj+ii893tTq2jg5m8RgxqS+fhQqTGKyeT5H+8e2kUwnxpYDtjRQGfuV
         9VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728068391; x=1728673191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxVDupioOAHgYm0omZMyX3FVywjjySfIoyGy7p70cqg=;
        b=Fjt8AxBNT2dN0OsOohXLT/vnNJ+U3libo3Z3G8leWQBnzTCn0woRB9HhUyZdbkVQDl
         60uzlzRRcUc8seSHHUzmfAU0y4DJ8mbYZiGSffDQGwtHprdMe9ZqMWsI02ItrNcAa/nQ
         cCUdxKjJpL7I6hH52PMEPUqiHOhRNjRm+Yfd+dplHfpxlflm1W2KvcBIZlWSVxYsv8yL
         1M/syEr3pKBvKJGHQWHYsH+lYb8UWoUKiIzNeg2EkFEUUqN0rzMvhDZr+hijUn12UfiS
         XxicG3yQZJTs5/aKIDsDVEVIIBp+8L+YlJV4aATVLN4BOj7EKaxcfY9aY72q7nCNZSNs
         PiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoG+RqzCa1n7LPml8yqFguH87QZY9qwiE27j/JGmnDzZbYRY1YBsCU/39Pq3WgzBFSpVrSyzVQBL6MYDVf@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbVw3TRWXg7CFCrI4cvhAmrnqUvd06IlY9kidWYpkvpRIXc+R
	R4J98Eozr3waLN6PESEDuovrnbJJBoKxBaQFQ9rrD3/WQoVQvMTiw/jBDdPGvTA=
X-Google-Smtp-Source: AGHT+IEXYwpUjKYsnNjwlUU2Xj0ktPcpuLP6e6TyTUHI59CKR0kWcRl/0khQiME4tlWe22XHX7ePdQ==
X-Received: by 2002:a17:902:f54c:b0:20b:b238:9d02 with SMTP id d9443c01a7336-20bfe05f3bbmr2544905ad.33.1728068391261;
        Fri, 04 Oct 2024 11:59:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138d0b71sm1839145ad.97.2024.10.04.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 11:59:50 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:59:47 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 33/33] kselftest/riscv: kselftest for user mode cfi
Message-ID: <ZwA7I7sY8RFNIHXn@debug.ba.rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-33-3ba65b6e550f@rivosinc.com>
 <fdf602e9-a8b1-4f62-9e26-bb62a7202d22@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fdf602e9-a8b1-4f62-9e26-bb62a7202d22@linuxfoundation.org>

On Wed, Oct 02, 2024 at 05:18:36PM -0600, Shuah Khan wrote:
>On 10/1/24 10:06, Deepak Gupta wrote:
>>Adds kselftest for RISC-V control flow integrity implementation for user
>>mode. There is not a lot going on in kernel for enabling landing pad for
>>user mode. cfi selftest are intended to be compiled with zicfilp and
>>zicfiss enabled compiler. Thus kselftest simply checks if landing pad and
>>shadow stack for the binary and process are enabled or not. selftest then
>>register a signal handler for SIGSEGV. Any control flow violation are
>>reported as SIGSEGV with si_code = SEGV_CPERR. Test will fail on receiving
>>any SEGV_CPERR. Shadow stack part has more changes in kernel and thus there
>>are separate tests for that
>>	- Exercise `map_shadow_stack` syscall
>>	- `fork` test to make sure COW works for shadow stack pages
>>	- gup tests
>>	  As of today kernel uses FOLL_FORCE when access happens to memory via
>>	  /proc/<pid>/mem. Not breaking that for shadow stack
>>	- signal test. Make sure signal delivery results in token creation on
>>       shadow stack and consumes (and verifies) token on sigreturn
>>     - shadow stack protection test. attempts to write using regular store
>>	  instruction on shadow stack memory must result in access faults
>>
>
>Include test output here

Will do that in next rev.

>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>
>I gave up in the middle. Please send v2 with the following things
>fixed:
>
>- Alignment problems in defines. I pointed out a couple.A

I am sorry, I thought I fixed it. My bad, will fix it and check before sending.

>- Too many debug messages. These make the test report hard to read.
>  Take a look at printf() closely and get rid of debug messages.
>- Combine messages. I highlighted a few.
>- Start messages with capital letter
>- Think about messages that can give user information. I highlighted
>  a few.

Thanks. I'll take that into account in next rev.

>
>>---
>>  tools/testing/selftests/riscv/Makefile             |   2 +-
>>  tools/testing/selftests/riscv/cfi/.gitignore       |   3 +
>>  tools/testing/selftests/riscv/cfi/Makefile         |  10 +
>>  tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  83 +++++
>>  tools/testing/selftests/riscv/cfi/riscv_cfi_test.c |  82 +++++
>>  tools/testing/selftests/riscv/cfi/shadowstack.c    | 362 +++++++++++++++++++++
>>  tools/testing/selftests/riscv/cfi/shadowstack.h    |  37 +++
>>  7 files changed, 578 insertions(+), 1 deletion(-)
>>
>>diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
>>index 7ce03d832b64..6e142fe004ab 100644
>>--- a/tools/testing/selftests/riscv/Makefile
>>+++ b/tools/testing/selftests/riscv/Makefile
>>@@ -5,7 +5,7 @@
>>  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>>  ifneq (,$(filter $(ARCH),riscv))
>>-RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
>>+RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn cfi
>>  else
>>  RISCV_SUBTARGETS :=
>>  endif
>>diff --git a/tools/testing/selftests/riscv/cfi/.gitignore b/tools/testing/selftests/riscv/cfi/.gitignore
>>new file mode 100644
>>index 000000000000..ce7623f9da28
>>--- /dev/null
>>+++ b/tools/testing/selftests/riscv/cfi/.gitignore
>>@@ -0,0 +1,3 @@
>>+cfitests
>>+riscv_cfi_test
>>+shadowstack
>>\ No newline at end of file
>
>The above look odd to me.

Noted and will fix.

>
>>diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
>>new file mode 100644
>>index 000000000000..b65f7ff38a32
>>--- /dev/null
>>+++ b/tools/testing/selftests/riscv/cfi/Makefile
>>@@ -0,0 +1,10 @@
>>+CFLAGS += -I$(top_srcdir)/tools/include
>>+
>>+CFLAGS += -march=rv64gc_zicfilp_zicfiss
>>+
>>+TEST_GEN_PROGS := cfitests
>>+
>>+include ../../lib.mk
>>+
>>+$(OUTPUT)/cfitests: riscv_cfi_test.c shadowstack.c
>>+	$(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
>>diff --git a/tools/testing/selftests/riscv/cfi/cfi_rv_test.h b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
>>new file mode 100644
>>index 000000000000..fa1cf7183672
>>--- /dev/null
>>+++ b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
>>@@ -0,0 +1,83 @@
>>+/* SPDX-License-Identifier: GPL-2.0-only */
>>+
>>+#ifndef SELFTEST_RISCV_CFI_H
>>+#define SELFTEST_RISCV_CFI_H
>>+#include <stddef.h>
>>+#include <sys/types.h>
>>+#include "shadowstack.h"
>>+
>>+#define RISCV_CFI_SELFTEST_COUNT RISCV_SHADOW_STACK_TESTS
>>+
>>+#define CHILD_EXIT_CODE_SSWRITE		10
>>+#define CHILD_EXIT_CODE_SIG_TEST	11
>
>Align these defines please.
>
>>+
>>+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)		\
>>+({															\
>>+	register long _num  __asm__ ("a7") = (num);				\
>>+	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
>>+	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
>>+	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
>>+	register long _arg4 __asm__ ("a3") = (long)(arg4);		\
>>+	register long _arg5 __asm__ ("a4") = (long)(arg5);		\
>>+															\
>>+	__asm__ volatile (										\
>>+		"ecall\n"											\
>>+		: "+r"(_arg1)										\
>>+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
>>+		  "r"(_num)											> +		: "memory", "cc"									\
>>+	);														\
>>+	_arg1;													\
>>+})
>>+
>
>This is so hard to read. Can you align the tabs for "\"
>
>
>>+#define my_syscall3(num, arg1, arg2, arg3)					\
>>+({															\
>>+	register long _num  __asm__ ("a7") = (num);				\
>>+	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
>>+	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
>>+	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
>>+															\
>>+	__asm__ volatile (										\
>>+		"ecall\n"											\
>>+		: "+r"(_arg1)										\
>>+		: "r"(_arg2), "r"(_arg3),							\
>>+		  "r"(_num)											\
>>+		: "memory", "cc"									\
>>+	);														\
>>+	_arg1;													\
>>+})
>>+
>
>Same here.
>
>>+#ifndef __NR_prctl
>>+#define __NR_prctl 167
>>+#endif
>>+
>>+#ifndef __NR_map_shadow_stack
>>+#define __NR_map_shadow_stack 453
>
>Why do we need to define these? Shouldn't including
>asm-generic/unistd.h sufficient?
>
>>+#endif
>>+
>>+#define CSR_SSP 0x011
>>+
>>+#ifdef __ASSEMBLY__
>>+#define __ASM_STR(x)    x
>>+#else
>>+#define __ASM_STR(x)    #x
>>+#endif
>>+
>>+#define csr_read(csr)									\
>>+({														\
>>+	register unsigned long __v;							\
>>+	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)	\
>>+						  : "=r" (__v) :				\
>>+						  : "memory");					\
>>+	__v;												\
>>+})
>>+
>>+#define csr_write(csr, val)								\
>>+({														\
>>+	unsigned long __v = (unsigned long) (val);			\
>>+	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"	\
>>+						  : : "rK" (__v)				\
>>+						  : "memory");					\
>>+})
>>+
>
>Please fix alignment in the entire file. This is very difficult to read.
>
>>+#endif
>>diff --git a/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
>>new file mode 100644
>>index 000000000000..f22b3f0f24de
>>--- /dev/null
>>+++ b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
>>@@ -0,0 +1,82 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+
>>+#include "../../kselftest.h"
>>+#include <signal.h>
>>+#include <asm/ucontext.h>
>>+#include <linux/prctl.h>
>>+#include "cfi_rv_test.h"
>>+
>>+/* do not optimize cfi related test functions */
>>+#pragma GCC push_options
>>+#pragma GCC optimize("O0")
>>+
>>+void sigsegv_handler(int signum, siginfo_t *si, void *uc)
>>+{
>>+	struct ucontext *ctx = (struct ucontext *) uc;
>>+
>>+	if (si->si_code == SEGV_CPERR) {
>>+		printf("Control flow violation happened somewhere\n");
>>+		printf("pc where violation happened %lx\n", ctx->uc_mcontext.gregs[0]);
>
>Why do you need two print statements, collapse them.
>
>>+		exit(-1);
>>+	}
>>+
>>+	printf("In sigsegv handler\n");
>
>Remove this - looks like debug message.
>
>>+	/* all other cases are expected to be of shadow stack write case */
>>+	exit(CHILD_EXIT_CODE_SSWRITE);
>>+}
>>+
>>+bool register_signal_handler(void)
>>+{
>>+	struct sigaction sa = {};
>>+
>>+	sa.sa_sigaction = sigsegv_handler;
>>+	sa.sa_flags = SA_SIGINFO;
>>+	if (sigaction(SIGSEGV, &sa, NULL)) {
>>+		printf("registering signal handler for landing pad violation failed\n");
>
>Include strerror() to get the system error message.
>
>>+		return false;
>>+	}
>>+
>>+	return true;
>>+}
>>+
>>+int main(int argc, char *argv[])
>>+{
>>+	int ret = 0;
>>+	unsigned long lpad_status = 0, ss_status = 0;
>>+
>>+	ksft_print_header();
>>+
>>+	ksft_set_plan(RISCV_CFI_SELFTEST_COUNT);
>>+
>>+	ksft_print_msg("starting risc-v tests\n");
>
>Starting instead of starting.
>
>>+
>>+	/*
>>+	 * Landing pad test. Not a lot of kernel changes to support landing
>>+	 * pad for user mode except lighting up a bit in senvcfg via a prctl
>>+	 * Enable landing pad through out the execution of test binary
>>+	 */
>>+	ret = my_syscall5(__NR_prctl, PR_GET_INDIR_BR_LP_STATUS, &lpad_status, 0, 0, 0);
>>+	if (ret)
>>+		ksft_exit_skip("Get landing pad status failed with %d\n", ret);
>
>Does this mean __NR_prctl isn't fully supported? It would informative if
>the message says that instead "Get landing pad status failed"
>
>>+
>>+	if (!(lpad_status & PR_INDIR_BR_LP_ENABLE))
>>+		ksft_exit_skip("landing pad is not enabled, should be enabled via glibc\n");
>
>Landing insteads of landing. Use concistent upper case for starting
>messages that go into test report.
>
>>+
>
>
>>+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
>>+	if (ret)
>>+		ksft_exit_skip("Get shadow stack failed with %d\n", ret);
>
>Same here. Make this informative - what does this mean? What should
>user do when they see this message?
>
>>+
>>+	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
>>+		ksft_exit_skip("shadow stack is not enabled, should be enabled via glibc\n");
>
>Shadow
>
>>+
>>+	if (!register_signal_handler())
>>+		ksft_exit_skip("registering signal handler for SIGSEGV failed\n");
>
>Registerting
>
>>+
>>+	ksft_print_msg("landing pad and shadow stack are enabled for binary\n");
>>+	ksft_print_msg("starting risc-v shadow stack tests\n");
>
>Do you need the above messages? Collapse them if you really need them
>in the report.
>
>>+	execute_shadow_stack_tests();
>>+
>>+	ksft_finished();
>>+}
>>+
>>+#pragma GCC pop_options
>>diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.c b/tools/testing/selftests/riscv/cfi/shadowstack.c
>>new file mode 100644
>>index 000000000000..2f65eb970c44
>>--- /dev/null
>>+++ b/tools/testing/selftests/riscv/cfi/shadowstack.c
>>@@ -0,0 +1,362 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+
>>+#include "../../kselftest.h"
>>+#include <sys/wait.h>
>>+#include <signal.h>
>>+#include <fcntl.h>
>>+#include <asm-generic/unistd.h>
>>+#include <sys/mman.h>
>>+#include "shadowstack.h"
>>+#include "cfi_rv_test.h"
>>+
>>+/* do not optimize shadow stack related test functions */
>>+#pragma GCC push_options
>>+#pragma GCC optimize("O0")
>>+
>>+void zar(void)
>>+{
>>+	unsigned long ssp = 0;
>>+
>>+	ssp = csr_read(CSR_SSP);
>>+	printf("inside %s and shadow stack ptr is %lx\n", __func__, ssp);
>
>Debug message? get rid of it.
>
>>+}
>>+
>>+void bar(void)
>>+{
>>+	printf("inside %s\n", __func__);
>
>Same here - debug messages make report hard to read.
>
>>+	zar();
>>+}
>>+
>>+void foo(void)
>>+{
>>+	printf("inside %s\n", __func__);
>>+	bar();
>>+}
>>+
>>+void zar_child(void)
>>+{
>>+	unsigned long ssp = 0;
>>+
>>+	ssp = csr_read(CSR_SSP);
>>+	printf("inside %s and shadow stack ptr is %lx\n", __func__, ssp);
>>+}
>>+
>>+void bar_child(void)
>>+{
>>+	printf("inside %s\n", __func__);
>>+	zar_child();
>>+}
>>+
>>+void foo_child(void)
>>+{
>>+	printf("inside %s\n", __func__);
>>+	bar_child();
>>+}
>>+
>>+typedef void (call_func_ptr)(void);
>>+/*
>>+ * call couple of functions to test push pop.
>>+ */
>>+int shadow_stack_call_tests(call_func_ptr fn_ptr, bool parent)
>>+{
>>+	if (parent)
>>+		printf("call test for parent\n");
>>+	else
>>+		printf("call test for child\n");
>>+
>>+	(fn_ptr)();
>>+
>>+	return 0;
>>+}
>>+
>>+/* forks a thread, and ensure shadow stacks fork out */
>>+bool shadow_stack_fork_test(unsigned long test_num, void *ctx)
>>+{
>>+	int pid = 0, child_status = 0, parent_pid = 0, ret = 0;
>>+	unsigned long ss_status = 0;
>>+
>>+	printf("exercising shadow stack fork test\n");
>>+
>>+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
>>+	if (ret) {
>>+		printf("shadow stack get status prctl failed with errorcode %d\n", ret);
>>+		return false;
>>+	}
>>+
>>+	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
>>+		ksft_exit_skip("shadow stack is not enabled, should be enabled via glibc\n");
>>+
>>+	parent_pid = getpid();
>>+	pid = fork();
>>+
>>+	if (pid) {
>>+		printf("Parent pid %d and child pid %d\n", parent_pid, pid);
>>+		shadow_stack_call_tests(&foo, true);
>>+	} else
>>+		shadow_stack_call_tests(&foo_child, false);
>>+
>>+	if (pid) {
>>+		printf("waiting on child to finish\n");
>>+		wait(&child_status);
>>+	} else {
>>+		/* exit child gracefully */
>>+		exit(0);
>>+	}
>>+
>>+	if (pid && WIFSIGNALED(child_status)) {
>>+		printf("child faulted");
>>+		return false;
>>+	}
>>+
>>+	return true;
>>+}
>>+
>>+/* exercise `map_shadow_stack`, pivot to it and call some functions to ensure it works */
>>+#define SHADOW_STACK_ALLOC_SIZE 4096
>>+bool shadow_stack_map_test(unsigned long test_num, void *ctx)
>>+{
>>+	unsigned long shdw_addr;
>>+	int ret = 0;
>>+
>>+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
>>+
>>+	if (((long) shdw_addr) <= 0) {
>>+		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
>>+		return false;
>>+	}
>>+
>>+	ret = munmap((void *) shdw_addr, SHADOW_STACK_ALLOC_SIZE);
>>+
>>+	if (ret) {
>>+		printf("munmap failed with error code %d\n", ret);
>>+		return false;
>>+	}
>>+
>>+	return true;
>>+}
>>+
>>+/*
>>+ * shadow stack protection tests. map a shadow stack and
>>+ * validate all memory protections work on it
>>+ */
>>+bool shadow_stack_protection_test(unsigned long test_num, void *ctx)
>>+{
>>+	unsigned long shdw_addr;
>>+	unsigned long *write_addr = NULL;
>>+	int ret = 0, pid = 0, child_status = 0;
>>+
>>+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
>>+
>>+	if (((long) shdw_addr) <= 0) {
>>+		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
>>+		return false;
>>+	}
>>+
>>+	write_addr = (unsigned long *) shdw_addr;
>>+	pid = fork();
>>+
>>+	/* no child was created, return false */
>>+	if (pid == -1)
>>+		return false;
>>+
>>+	/*
>>+	 * try to perform a store from child on shadow stack memory
>>+	 * it should result in SIGSEGV
>>+	 */
>>+	if (!pid) {
>>+		/* below write must lead to SIGSEGV */
>>+		*write_addr = 0xdeadbeef;
>>+	} else {
>>+		wait(&child_status);
>>+	}
>>+
>>+	/* test fail, if 0xdeadbeef present on shadow stack address */
>>+	if (*write_addr == 0xdeadbeef) {
>>+		printf("write suceeded\n");
>>+		return false;
>>+	}
>>+
>>+	/* if child reached here, then fail */
>>+	if (!pid) {
>>+		printf("child reached unreachable state\n");
>>+		return false;
>>+	}
>>+
>>+	/* if child exited via signal handler but not for write on ss */
>>+	if (WIFEXITED(child_status) &&
>>+		WEXITSTATUS(child_status) != CHILD_EXIT_CODE_SSWRITE) {
>>+		printf("child wasn't signaled for write on shadow stack\n");
>>+		return false;
>>+	}
>>+
>>+	ret = munmap(write_addr, SHADOW_STACK_ALLOC_SIZE);
>>+	if (ret) {
>>+		printf("munmap failed with error code %d\n", ret);
>>+		return false;
>>+	}
>>+
>>+	return true;
>>+}
>>+
>>+#define SS_MAGIC_WRITE_VAL 0xbeefdead
>>+
>>+int gup_tests(int mem_fd, unsigned long *shdw_addr)
>>+{
>>+	unsigned long val = 0;
>>+
>>+	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
>>+	if (read(mem_fd, &val, sizeof(val)) < 0) {
>>+		printf("reading shadow stack mem via gup failed\n");
>>+		return 1;
>>+	}
>>+
>>+	val = SS_MAGIC_WRITE_VAL;
>>+	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
>>+	if (write(mem_fd, &val, sizeof(val)) < 0) {
>>+		printf("writing shadow stack mem via gup failed\n");
>>+		return 1;
>>+	}
>>+
>>+	if (*shdw_addr != SS_MAGIC_WRITE_VAL) {
>>+		printf("GUP write to shadow stack memory didn't happen\n");
>>+		return 1;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+bool shadow_stack_gup_tests(unsigned long test_num, void *ctx)
>>+{
>>+	unsigned long shdw_addr = 0;
>>+	unsigned long *write_addr = NULL;
>>+	int fd = 0;
>>+	bool ret = false;
>>+
>>+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
>>+
>>+	if (((long) shdw_addr) <= 0) {
>>+		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
>>+		return false;
>>+	}
>>+
>>+	write_addr = (unsigned long *) shdw_addr;
>>+
>>+	fd = open("/proc/self/mem", O_RDWR);
>>+	if (fd == -1)
>>+		return false;
>>+
>>+	if (gup_tests(fd, write_addr)) {
>>+		printf("gup tests failed\n");
>>+		goto out;
>>+	}
>>+
>>+	ret = true;
>>+out:
>>+	if (shdw_addr && munmap(write_addr, SHADOW_STACK_ALLOC_SIZE)) {
>>+		printf("munmap failed with error code %d\n", ret);
>>+		ret = false;
>>+	}
>>+
>>+	return ret;
>>+}
>>+
>>+volatile bool break_loop;
>>+
>>+void sigusr1_handler(int signo)
>>+{
>>+	printf("In sigusr1 handler\n");
>>+	break_loop = true;
>>+}
>>+
>>+bool sigusr1_signal_test(void)
>>+{
>>+	struct sigaction sa = {};
>>+
>>+	sa.sa_handler = sigusr1_handler;
>>+	sa.sa_flags = 0;
>>+	sigemptyset(&sa.sa_mask);
>>+	if (sigaction(SIGUSR1, &sa, NULL)) {
>>+		printf("registering signal handler for SIGUSR1 failed\n");
>>+		return false;
>>+	}
>>+
>>+	return true;
>>+}
>>+/*
>>+ * shadow stack signal test. shadow stack must be enabled.
>>+ * register a signal, fork another thread which is waiting
>>+ * on signal. Send a signal from parent to child, verify
>>+ * that signal was received by child. If not test fails
>>+ */
>>+bool shadow_stack_signal_test(unsigned long test_num, void *ctx)
>>+{
>>+	int pid = 0, child_status = 0, ret = 0;
>>+	unsigned long ss_status = 0;
>>+
>>+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
>>+	if (ret) {
>>+		printf("shadow stack get status prctl failed with errorcode %d\n", ret);
>>+		return false;
>>+	}
>>+
>>+	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
>>+		ksft_exit_skip("shadow stack is not enabled, should be enabled via glibc\n");
>>+
>>+	/* this should be caught by signal handler and do an exit */
>>+	if (!sigusr1_signal_test()) {
>>+		printf("registering sigusr1 handler failed\n");
>>+		exit(-1);
>>+	}
>>+
>>+	pid = fork();
>>+
>>+	if (pid == -1) {
>>+		printf("signal test: fork failed\n");
>>+		goto out;
>>+	}
>>+
>>+	if (pid == 0) {
>>+		while (!break_loop)
>>+			sleep(1);
>>+
>>+		exit(11);
>>+		/* child shouldn't go beyond here */
>>+	}
>>+
>>+	/* send SIGUSR1 to child */
>>+	kill(pid, SIGUSR1);
>>+	wait(&child_status);
>>+
>>+out:
>>+
>>+	return (WIFEXITED(child_status) &&
>>+			WEXITSTATUS(child_status) == 11);
>>+}
>>+
>>+int execute_shadow_stack_tests(void)
>>+{
>>+	int ret = 0;
>>+	unsigned long test_count = 0;
>>+	unsigned long shstk_status = 0;
>>+
>>+	printf("Executing RISC-V shadow stack self tests\n");
>>+
>>+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &shstk_status, 0, 0, 0);
>>+
>>+	if (ret != 0)
>>+		ksft_exit_skip("Get shadow stack status failed with %d\n", ret);
>>+
>>+	/*
>>+	 * If we are here that means get shadow stack status succeeded and
>>+	 * thus shadow stack support is baked in the kernel.
>>+	 */
>>+	while (test_count < ARRAY_SIZE(shstk_tests)) {
>>+		ksft_test_result((*shstk_tests[test_count].t_func)(test_count, NULL),
>>+						 shstk_tests[test_count].name);
>>+		test_count++;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+#pragma GCC pop_options
>>diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.h b/tools/testing/selftests/riscv/cfi/shadowstack.h
>>new file mode 100644
>>index 000000000000..b43e74136a26
>>--- /dev/null
>>+++ b/tools/testing/selftests/riscv/cfi/shadowstack.h
>>@@ -0,0 +1,37 @@
>>+/* SPDX-License-Identifier: GPL-2.0-only */
>>+
>>+#ifndef SELFTEST_SHADOWSTACK_TEST_H
>>+#define SELFTEST_SHADOWSTACK_TEST_H
>>+#include <stddef.h>
>>+#include <linux/prctl.h>
>>+
>>+/*
>>+ * a cfi test returns true for success or false for fail
>>+ * takes a number for test number to index into array and void pointer.
>>+ */
>>+typedef bool (*shstk_test_func)(unsigned long test_num, void *);
>>+
>>+struct shadow_stack_tests {
>>+	char *name;
>>+	shstk_test_func t_func;
>>+};
>>+
>>+bool shadow_stack_fork_test(unsigned long test_num, void *ctx);
>>+bool shadow_stack_map_test(unsigned long test_num, void *ctx);
>>+bool shadow_stack_protection_test(unsigned long test_num, void *ctx);
>>+bool shadow_stack_gup_tests(unsigned long test_num, void *ctx);
>>+bool shadow_stack_signal_test(unsigned long test_num, void *ctx);
>>+
>>+static struct shadow_stack_tests shstk_tests[] = {
>>+	{ "shstk fork test\n", shadow_stack_fork_test },
>>+	{ "map shadow stack syscall\n", shadow_stack_map_test },
>>+	{ "shadow stack gup tests\n", shadow_stack_gup_tests },
>>+	{ "shadow stack signal tests\n", shadow_stack_signal_test},
>>+	{ "memory protections of shadow stack memory\n", shadow_stack_protection_test }
>>+};
>>+
>>+#define RISCV_SHADOW_STACK_TESTS ARRAY_SIZE(shstk_tests)
>>+
>>+int execute_shadow_stack_tests(void);
>>+
>>+#endif
>>
>
>thanks,
>-- Shuah

