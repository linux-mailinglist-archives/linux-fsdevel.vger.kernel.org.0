Return-Path: <linux-fsdevel+bounces-44002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF17A60AC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 09:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A74B19C08F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 08:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944BB193073;
	Fri, 14 Mar 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gf+2LMIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460618D621
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939675; cv=none; b=t0jhtuksLRbl80Xind8GzmEBDiA2ITSxlr/93qJljy+2gCphvcAb7iUAfYT5Bv5DojmUWU+uvvVWIDCELyR5OydX34A00+Cm9Uiwl5YFBAcsaTjug4TgzgCVVqG92ct2IyIjMdAVbPtKFJlA62gQ+1Gm0m8HILc7R5NWbtjnMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939675; c=relaxed/simple;
	bh=Etbi6F98AT3n4tz5ugc7NEcszkxH2N5a/f8wKpXu5ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsdarFNAivBF3WLhBXW7+Uc/FZsOZMV6oFqqHsQlF08vHnDVDllbzfdONBRFJpRsJ3mhaiWO8i3vhoJxsmlWWy36hK3fRItwMs+nTIOBu1nQEIU1Loa+pivELjM0hQLsc5AH3207hzBiKvvcYFyE/Y2GsisSk+BWE1MM5iALvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gf+2LMIV; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d45503af24so15786825ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741939671; x=1742544471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7ukpevJe2jiIFdzqhvG8S7e2Xjqm7krPdb5TyOjM2s=;
        b=gf+2LMIVScOPCc6rQrnuF/EHbgY5TVUQwFswvJisMI1kqn+UMa6QMMi2xP029Zd12j
         chGQtyTTgYoX/ixX1O2pG0RgJj0p7BcE3tNOfwqKfJ7R9zCSaXYt0IAX29rghX+8SWP6
         N9wNrMTNwoYtM3uHaahTdcPdrone5eWrT6MMDicNGYSbueBzXvdOKYb7OPdHhntY5glA
         mUA+kKNYbEdOQOlhcRG+zfLmKf4NobwZk7b6aOiN+G5+YpNp+D+kYwPtIaRrYBw/xW9N
         AYzQzX/g9AVgMI0xGPTS17luNs/OKr3xUng2kL65h7y3OPgroLU68ZFCHaN6zKYsULZ7
         v2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939671; x=1742544471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7ukpevJe2jiIFdzqhvG8S7e2Xjqm7krPdb5TyOjM2s=;
        b=Wa93NS94swuOQeearX0d84t9TlGzpPcQ0pl5fhlhoeqmut9atMTYW9uozJ4rGyJ9sD
         ESglbXeCDRIf/mB623McQDRM+2U9oYRw+Ux3j9qQH6k4+00wpt/HagY3JN4Cx6OV9P0H
         eq0bw+mnAtx8MDG7e8o4yWPwmTXiELjxpXlDdAFvRxirEJNmzoP4V2lO/hTmkHABzLp+
         SX/AUXvG5jl4MNWVKTdehq0/ujxRb4+DF/FX0QwE7wzbPDVcoJW6NpS2joYiw2PLU/t8
         BBkmIzS6yNRGweQuEBFn04+BOrrsUfQyhKTCuAJde8wFwaydyTTkz9+a+u9YEdW1Qmz2
         NXJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW52mdpWIqih0GkJ1QRPcGXIem73BZtnYXqYXBHV4kv0jzHUcf+sUmUCvEi5KuG0SksLYYcRei8VcsSMPoU@vger.kernel.org
X-Gm-Message-State: AOJu0YylzuSdYk5FDmbmurjZ2uxCuoz9AuE6xjUlOOdkfBcNBsTbLNCw
	dxYmQOwE/q9bWZ+uTOgoPwFw2a97P8qH9ow+W0n2z0TU6xfWlixDy0k2v2FOnZd3Z3J7xSUWQIm
	EJJwYTxTcgJA4o6PUCuRjzIo+Ah/qnhbktfnbsw==
X-Gm-Gg: ASbGncvy5qjJjq2UddRMiSPnfkx/ySlNQHUo2XM7pR5ZUlWuKSSDSHCQVx0FxQiOPFd
	1MSrO15nynRQCUSJKrPOgrOuxn3X02q/xhZjzMojyMSGGmI9nLIqPwV4i8pwpiFvpFiIXlfLR6W
	ccm66rM2Z9d+oGqvdhpU94mD+LK/El
X-Google-Smtp-Source: AGHT+IHdgq45LZqjy+3NwmGTXZvAbMtgeNn1I8mCbk9s10mr7tzeLDM/sKq48HvZGrkaXYXWMzwRJvzfglKbOM07y+8=
X-Received: by 2002:a05:6e02:3192:b0:3d0:19c6:c9e1 with SMTP id
 e9e14a558f8ab-3d483a1f70fmr13628715ab.13.1741939670703; Fri, 14 Mar 2025
 01:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-27-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-27-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:07:39 +0800
X-Gm-Features: AQ5f1Jq8OpjUYhLWiMetJf0nZsGks-mTy3t0g-i_vmiVVh3IsT-O-8UFm9jjm6k
Message-ID: <CANXhq0r5yjHcQEQ8KCe5UZJZDUuYZ6hYT4XZXQyPCNCSL2ZrEA@mail.gmail.com>
Subject: Re: [PATCH v11 27/27] kselftest/riscv: kselftest for user mode cfi
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 1:50=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Adds kselftest for RISC-V control flow integrity implementation for user
> mode. There is not a lot going on in kernel for enabling landing pad for
> user mode. cfi selftest are intended to be compiled with zicfilp and
> zicfiss enabled compiler. Thus kselftest simply checks if landing pad and
> shadow stack for the binary and process are enabled or not. selftest then
> register a signal handler for SIGSEGV. Any control flow violation are
> reported as SIGSEGV with si_code =3D SEGV_CPERR. Test will fail on receiv=
ing
> any SEGV_CPERR. Shadow stack part has more changes in kernel and thus the=
re
> are separate tests for that
>
> - Exercise `map_shadow_stack` syscall
> - `fork` test to make sure COW works for shadow stack pages
> - gup tests
>   Kernel uses FOLL_FORCE when access happens to memory via
>   /proc/<pid>/mem. Not breaking that for shadow stack.
> - signal test. Make sure signal delivery results in token creation on
>   shadow stack and consumes (and verifies) token on sigreturn
> - shadow stack protection test. attempts to write using regular store
>   instruction on shadow stack memory must result in access faults
>
> Test outut
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> """
> TAP version 13
> 1..5
>   This is to ensure shadow stack is indeed enabled and working
>   This is to ensure shadow stack is indeed enabled and working
> ok 1 shstk fork test
> ok 2 map shadow stack syscall
> ok 3 shadow stack gup tests
> ok 4 shadow stack signal tests
> ok 5 memory protections of shadow stack memory
> """
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  tools/testing/selftests/riscv/Makefile             |   2 +-
>  tools/testing/selftests/riscv/cfi/.gitignore       |   3 +
>  tools/testing/selftests/riscv/cfi/Makefile         |  10 +
>  tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  84 +++++
>  tools/testing/selftests/riscv/cfi/riscv_cfi_test.c |  78 +++++
>  tools/testing/selftests/riscv/cfi/shadowstack.c    | 375 +++++++++++++++=
++++++
>  tools/testing/selftests/riscv/cfi/shadowstack.h    |  37 ++
>  7 files changed, 588 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selft=
ests/riscv/Makefile
> index 099b8c1f46f8..5671b4405a12 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -5,7 +5,7 @@
>  ARCH ?=3D $(shell uname -m 2>/dev/null || echo not)
>
>  ifneq (,$(filter $(ARCH),riscv))
> -RISCV_SUBTARGETS ?=3D abi hwprobe mm sigreturn vector
> +RISCV_SUBTARGETS ?=3D abi hwprobe mm sigreturn vector cfi
>  else
>  RISCV_SUBTARGETS :=3D
>  endif
> diff --git a/tools/testing/selftests/riscv/cfi/.gitignore b/tools/testing=
/selftests/riscv/cfi/.gitignore
> new file mode 100644
> index 000000000000..82545863bac6
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/.gitignore
> @@ -0,0 +1,3 @@
> +cfitests
> +riscv_cfi_test
> +shadowstack
> diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/s=
elftests/riscv/cfi/Makefile
> new file mode 100644
> index 000000000000..b65f7ff38a32
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/Makefile
> @@ -0,0 +1,10 @@
> +CFLAGS +=3D -I$(top_srcdir)/tools/include
> +
> +CFLAGS +=3D -march=3Drv64gc_zicfilp_zicfiss
> +
> +TEST_GEN_PROGS :=3D cfitests
> +
> +include ../../lib.mk
> +
> +$(OUTPUT)/cfitests: riscv_cfi_test.c shadowstack.c
> +       $(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/cfi/cfi_rv_test.h b/tools/test=
ing/selftests/riscv/cfi/cfi_rv_test.h
> new file mode 100644
> index 000000000000..a9d5d6f8e29c
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef SELFTEST_RISCV_CFI_H
> +#define SELFTEST_RISCV_CFI_H
> +#include <stddef.h>
> +#include <sys/types.h>
> +#include "shadowstack.h"
> +
> +#define RISCV_CFI_SELFTEST_COUNT RISCV_SHADOW_STACK_TESTS

'RISCV_CFI_SELFTEST_COUNT' doesn't seems to be used anywhere

> +
> +#define CHILD_EXIT_CODE_SSWRITE                10
> +#define CHILD_EXIT_CODE_SIG_TEST       11
> +
> +#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                 \
> +({                                                                     \
> +       register long _num  __asm__ ("a7") =3D (num);                    =
 \
> +       register long _arg1 __asm__ ("a0") =3D (long)(arg1);             =
 \
> +       register long _arg2 __asm__ ("a1") =3D (long)(arg2);             =
 \
> +       register long _arg3 __asm__ ("a2") =3D (long)(arg3);             =
 \
> +       register long _arg4 __asm__ ("a3") =3D (long)(arg4);             =
 \
> +       register long _arg5 __asm__ ("a4") =3D (long)(arg5);             =
 \
> +                                                                       \
> +       __asm__ volatile(                                               \
> +               "ecall\n"                                               \
> +               : "+r"                                                  \
> +               (_arg1)                                                 \
> +               : "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),       \
> +                 "r"(_num)                                             \
> +               : "memory", "cc"                                        \
> +       );                                                              \
> +       _arg1;                                                          \
> +})
> +
> +#define my_syscall3(num, arg1, arg2, arg3)                             \
> +({                                                                     \
> +       register long _num  __asm__ ("a7") =3D (num);                    =
 \
> +       register long _arg1 __asm__ ("a0") =3D (long)(arg1);             =
 \
> +       register long _arg2 __asm__ ("a1") =3D (long)(arg2);             =
 \
> +       register long _arg3 __asm__ ("a2") =3D (long)(arg3);             =
 \
> +                                                                       \
> +       __asm__ volatile(                                               \
> +               "ecall\n"                                               \
> +               : "+r" (_arg1)                                          \
> +               : "r"(_arg2), "r"(_arg3),                               \
> +                 "r"(_num)                                             \
> +               : "memory", "cc"                                        \
> +       );                                                              \
> +       _arg1;                                                          \
> +})
> +
> +#ifndef __NR_prctl
> +#define __NR_prctl 167
> +#endif
> +
> +#ifndef __NR_map_shadow_stack
> +#define __NR_map_shadow_stack 453
> +#endif
> +
> +#define CSR_SSP 0x011
> +
> +#ifdef __ASSEMBLY__
> +#define __ASM_STR(x)    x
> +#else
> +#define __ASM_STR(x)    #x
> +#endif
> +
> +#define csr_read(csr)                                                  \
> +({                                                                     \
> +       register unsigned long __v;                                     \
> +       __asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)                \
> +                               : "=3Dr" (__v) :                         =
 \
> +                               : "memory");                            \
> +       __v;                                                            \
> +})
> +
> +#define csr_write(csr, val)                                            \
> +({                                                                     \
> +       unsigned long __v =3D (unsigned long)(val);                      =
 \
> +       __asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"             \
> +                               : : "rK" (__v)                          \
> +                               : "memory");                            \
> +})
> +
> +#endif
> diff --git a/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c b/tools/t=
esting/selftests/riscv/cfi/riscv_cfi_test.c
> new file mode 100644
> index 000000000000..cf33aa25cc73
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "../../kselftest.h"
> +#include <sys/signal.h>
> +#include <asm/ucontext.h>
> +#include <linux/prctl.h>
> +#include "cfi_rv_test.h"
> +
> +/* do not optimize cfi related test functions */
> +#pragma GCC push_options
> +#pragma GCC optimize("O0")
> +
> +void sigsegv_handler(int signum, siginfo_t *si, void *uc)
> +{
> +       struct ucontext *ctx =3D (struct ucontext *)uc;
> +
> +       if (si->si_code =3D=3D SEGV_CPERR) {
> +               ksft_print_msg("Control flow violation happened somewhere=
\n");
> +               ksft_print_msg("PC where violation happened %lx\n", ctx->=
uc_mcontext.gregs[0]);
> +               exit(-1);
> +       }
> +
> +       /* all other cases are expected to be of shadow stack write case =
*/
> +       exit(CHILD_EXIT_CODE_SSWRITE);
> +}
> +
> +bool register_signal_handler(void)
> +{
> +       struct sigaction sa =3D {};
> +
> +       sa.sa_sigaction =3D sigsegv_handler;
> +       sa.sa_flags =3D SA_SIGINFO;
> +       if (sigaction(SIGSEGV, &sa, NULL)) {
> +               ksft_print_msg("Registering signal handler for landing pa=
d violation failed\n");
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       int ret =3D 0;
> +       unsigned long lpad_status =3D 0, ss_status =3D 0;
> +
> +       ksft_print_header();
> +
> +       ksft_print_msg("Starting risc-v tests\n");
> +
> +       /*
> +        * Landing pad test. Not a lot of kernel changes to support landi=
ng
> +        * pad for user mode except lighting up a bit in senvcfg via a pr=
ctl
> +        * Enable landing pad through out the execution of test binary
> +        */
> +       ret =3D my_syscall5(__NR_prctl, PR_GET_INDIR_BR_LP_STATUS, &lpad_=
status, 0, 0, 0);
> +       if (ret)
> +               ksft_exit_fail_msg("Get landing pad status failed with %d=
\n", ret);
> +
> +       if (!(lpad_status & PR_INDIR_BR_LP_ENABLE))
> +               ksft_exit_fail_msg("Landing pad is not enabled, should be=
 enabled via glibc\n");
> +
> +       ret =3D my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_s=
tatus, 0, 0, 0);
> +       if (ret)
> +               ksft_exit_fail_msg("Get shadow stack failed with %d\n", r=
et);
> +
> +       if (!(ss_status & PR_SHADOW_STACK_ENABLE))
> +               ksft_exit_fail_msg("Shadow stack is not enabled, should b=
e enabled via glibc\n");
> +
> +       if (!register_signal_handler())
> +               ksft_exit_fail_msg("Registering signal handler for SIGSEG=
V failed\n");
> +
> +       ksft_print_msg("Landing pad and shadow stack are enabled for bina=
ry\n");
> +       execute_shadow_stack_tests();
> +
> +       return 0;
> +}
> +
> +#pragma GCC pop_options
> diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.c b/tools/test=
ing/selftests/riscv/cfi/shadowstack.c
> new file mode 100644
> index 000000000000..a0ef066e98ab
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/shadowstack.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "../../kselftest.h"
> +#include <sys/wait.h>
> +#include <signal.h>
> +#include <fcntl.h>
> +#include <asm-generic/unistd.h>
> +#include <sys/mman.h>
> +#include "shadowstack.h"
> +#include "cfi_rv_test.h"
> +
> +/* do not optimize shadow stack related test functions */
> +#pragma GCC push_options
> +#pragma GCC optimize("O0")
> +
> +void zar(void)
> +{
> +       unsigned long ssp =3D 0;
> +
> +       ssp =3D csr_read(CSR_SSP);
> +       ksft_print_msg("Spewing out shadow stack ptr: %lx\n"
> +                       "  This is to ensure shadow stack is indeed enabl=
ed and working\n",
> +                       ssp);
> +}
> +
> +void bar(void)
> +{
> +       zar();
> +}
> +
> +void foo(void)
> +{
> +       bar();
> +}
> +
> +void zar_child(void)
> +{
> +       unsigned long ssp =3D 0;
> +
> +       ssp =3D csr_read(CSR_SSP);
> +       ksft_print_msg("Spewing out shadow stack ptr: %lx\n"
> +                       "  This is to ensure shadow stack is indeed enabl=
ed and working\n",
> +                       ssp);
> +}
> +
> +void bar_child(void)
> +{
> +       zar_child();
> +}
> +
> +void foo_child(void)
> +{
> +       bar_child();
> +}
> +
> +typedef void (call_func_ptr)(void);
> +/*
> + * call couple of functions to test push pop.
> + */
> +int shadow_stack_call_tests(call_func_ptr fn_ptr, bool parent)
> +{
> +       ksft_print_msg("dummy calls for sspush and sspopchk in context of=
 %s\n",
> +                      parent ? "parent" : "child");
> +
> +       (fn_ptr)();
> +
> +       return 0;
> +}
> +
> +/* forks a thread, and ensure shadow stacks fork out */
> +bool shadow_stack_fork_test(unsigned long test_num, void *ctx)
> +{
> +       int pid =3D 0, child_status =3D 0, parent_pid =3D 0, ret =3D 0;
> +       unsigned long ss_status =3D 0;
> +
> +       ksft_print_msg("Exercising shadow stack fork test\n");
> +
> +       ret =3D my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_s=
tatus, 0, 0, 0);
> +       if (ret) {
> +               ksft_exit_skip("Shadow stack get status prctl failed with=
 errorcode %d\n", ret);
> +               return false;
> +       }
> +
> +       if (!(ss_status & PR_SHADOW_STACK_ENABLE))
> +               ksft_exit_skip("Shadow stack is not enabled, should be en=
abled via glibc\n");
> +
> +       parent_pid =3D getpid();
> +       pid =3D fork();
> +
> +       if (pid) {
> +               ksft_print_msg("Parent pid %d and child pid %d\n", parent=
_pid, pid);
> +               shadow_stack_call_tests(&foo, true);
> +       } else {
> +               shadow_stack_call_tests(&foo_child, false);
> +       }
> +
> +       if (pid) {
> +               ksft_print_msg("Waiting on child to finish\n");
> +               wait(&child_status);
> +       } else {
> +               /* exit child gracefully */
> +               exit(0);
> +       }
> +
> +       if (pid && WIFSIGNALED(child_status)) {
> +               ksft_print_msg("Child faulted, fork test failed\n");
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +/* exercise `map_shadow_stack`, pivot to it and call some functions to e=
nsure it works */
> +#define SHADOW_STACK_ALLOC_SIZE 4096
> +bool shadow_stack_map_test(unsigned long test_num, void *ctx)
> +{
> +       unsigned long shdw_addr;
> +       int ret =3D 0;
> +
> +       ksft_print_msg("Exercising shadow stack map test\n");
> +
> +       shdw_addr =3D my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STA=
CK_ALLOC_SIZE, 0);
> +
> +       if (((long)shdw_addr) <=3D 0) {
> +               ksft_print_msg("map_shadow_stack failed with error code %=
d\n",
> +                              (int)shdw_addr);
> +               return false;
> +       }
> +
> +       ret =3D munmap((void *)shdw_addr, SHADOW_STACK_ALLOC_SIZE);
> +
> +       if (ret) {
> +               ksft_print_msg("munmap failed with error code %d\n", ret)=
;
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +/*
> + * shadow stack protection tests. map a shadow stack and
> + * validate all memory protections work on it
> + */
> +bool shadow_stack_protection_test(unsigned long test_num, void *ctx)
> +{
> +       unsigned long shdw_addr;
> +       unsigned long *write_addr =3D NULL;
> +       int ret =3D 0, pid =3D 0, child_status =3D 0;
> +
> +       ksft_print_msg("Exercising shadow stack protection test (WPT)\n")=
;
> +
> +       shdw_addr =3D my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STA=
CK_ALLOC_SIZE, 0);
> +
> +       if (((long)shdw_addr) <=3D 0) {
> +               ksft_print_msg("map_shadow_stack failed with error code %=
d\n",
> +                              (int)shdw_addr);
> +               return false;
> +       }
> +
> +       write_addr =3D (unsigned long *)shdw_addr;
> +       pid =3D fork();
> +
> +       /* no child was created, return false */
> +       if (pid =3D=3D -1)
> +               return false;
> +
> +       /*
> +        * try to perform a store from child on shadow stack memory
> +        * it should result in SIGSEGV
> +        */
> +       if (!pid) {
> +               /* below write must lead to SIGSEGV */
> +               *write_addr =3D 0xdeadbeef;
> +       } else {
> +               wait(&child_status);
> +       }
> +
> +       /* test fail, if 0xdeadbeef present on shadow stack address */
> +       if (*write_addr =3D=3D 0xdeadbeef) {
> +               ksft_print_msg("Shadow stack WPT failed\n");
> +               return false;
> +       }
> +
> +       /* if child reached here, then fail */
> +       if (!pid) {
> +               ksft_print_msg("Shadow stack WPT failed: child reached un=
reachable state\n");
> +               return false;
> +       }
> +
> +       /* if child exited via signal handler but not for write on ss */
> +       if (WIFEXITED(child_status) &&
> +           WEXITSTATUS(child_status) !=3D CHILD_EXIT_CODE_SSWRITE) {
> +               ksft_print_msg("Shadow stack WPT failed: child wasn't sig=
naled for write\n");
> +               return false;
> +       }
> +
> +       ret =3D munmap(write_addr, SHADOW_STACK_ALLOC_SIZE);
> +       if (ret) {
> +               ksft_print_msg("Shadow stack WPT failed: munmap failed, e=
rror code %d\n",
> +                              ret);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +#define SS_MAGIC_WRITE_VAL 0xbeefdead
> +
> +int gup_tests(int mem_fd, unsigned long *shdw_addr)
> +{
> +       unsigned long val =3D 0;
> +
> +       lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
> +       if (read(mem_fd, &val, sizeof(val)) < 0) {
> +               ksft_print_msg("Reading shadow stack mem via gup failed\n=
");
> +               return 1;
> +       }
> +
> +       val =3D SS_MAGIC_WRITE_VAL;
> +       lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
> +       if (write(mem_fd, &val, sizeof(val)) < 0) {
> +               ksft_print_msg("Writing shadow stack mem via gup failed\n=
");
> +               return 1;
> +       }
> +
> +       if (*shdw_addr !=3D SS_MAGIC_WRITE_VAL) {
> +               ksft_print_msg("GUP write to shadow stack memory failed\n=
");
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +bool shadow_stack_gup_tests(unsigned long test_num, void *ctx)
> +{
> +       unsigned long shdw_addr =3D 0;
> +       unsigned long *write_addr =3D NULL;
> +       int fd =3D 0;
> +       bool ret =3D false;
> +
> +       ksft_print_msg("Exercising shadow stack gup tests\n");
> +       shdw_addr =3D my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STA=
CK_ALLOC_SIZE, 0);
> +
> +       if (((long)shdw_addr) <=3D 0) {
> +               ksft_print_msg("map_shadow_stack failed with error code %=
d\n", (int)shdw_addr);
> +               return false;
> +       }
> +
> +       write_addr =3D (unsigned long *)shdw_addr;
> +
> +       fd =3D open("/proc/self/mem", O_RDWR);
> +       if (fd =3D=3D -1)
> +               return false;
> +
> +       if (gup_tests(fd, write_addr)) {
> +               ksft_print_msg("gup tests failed\n");
> +               goto out;
> +       }
> +
> +       ret =3D true;
> +out:
> +       if (shdw_addr && munmap(write_addr, SHADOW_STACK_ALLOC_SIZE)) {
> +               ksft_print_msg("munmap failed with error code %d\n", ret)=
;
> +               ret =3D false;
> +       }
> +
> +       return ret;
> +}
> +
> +volatile bool break_loop;
> +
> +void sigusr1_handler(int signo)
> +{
> +       break_loop =3D true;
> +}
> +
> +bool sigusr1_signal_test(void)
> +{
> +       struct sigaction sa =3D {};
> +
> +       sa.sa_handler =3D sigusr1_handler;
> +       sa.sa_flags =3D 0;
> +       sigemptyset(&sa.sa_mask);
> +       if (sigaction(SIGUSR1, &sa, NULL)) {
> +               ksft_print_msg("Registering signal handler for SIGUSR1 fa=
iled\n");
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +/*
> + * shadow stack signal test. shadow stack must be enabled.
> + * register a signal, fork another thread which is waiting
> + * on signal. Send a signal from parent to child, verify
> + * that signal was received by child. If not test fails
> + */
> +bool shadow_stack_signal_test(unsigned long test_num, void *ctx)
> +{
> +       int pid =3D 0, child_status =3D 0, ret =3D 0;
> +       unsigned long ss_status =3D 0;
> +
> +       ksft_print_msg("Exercising shadow stack signal test\n");
> +
> +       ret =3D my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_s=
tatus, 0, 0, 0);
> +       if (ret) {
> +               ksft_print_msg("Shadow stack get status prctl failed with=
 errorcode %d\n", ret);
> +               return false;
> +       }
> +
> +       if (!(ss_status & PR_SHADOW_STACK_ENABLE))
> +               ksft_print_msg("Shadow stack is not enabled, should be en=
abled via glibc\n");
> +
> +       /* this should be caught by signal handler and do an exit */
> +       if (!sigusr1_signal_test()) {
> +               ksft_print_msg("Registering sigusr1 handler failed\n");
> +               exit(-1);
> +       }
> +
> +       pid =3D fork();
> +
> +       if (pid =3D=3D -1) {
> +               ksft_print_msg("Signal test: fork failed\n");
> +               goto out;
> +       }
> +
> +       if (pid =3D=3D 0) {
> +               while (!break_loop)
> +                       sleep(1);
> +
> +               exit(11);
> +               /* child shouldn't go beyond here */
> +       }
> +
> +       /* send SIGUSR1 to child */
> +       kill(pid, SIGUSR1);
> +       wait(&child_status);
> +
> +out:
> +
> +       return (WIFEXITED(child_status) &&
> +               WEXITSTATUS(child_status) =3D=3D 11);
> +}
> +
> +int execute_shadow_stack_tests(void)
> +{
> +       int ret =3D 0;
> +       unsigned long test_count =3D 0;
> +       unsigned long shstk_status =3D 0;
> +       bool test_pass =3D false;
> +
> +       ksft_print_msg("Executing RISC-V shadow stack self tests\n");
> +       ksft_set_plan(RISCV_SHADOW_STACK_TESTS);
> +
> +       ret =3D my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &shst=
k_status, 0, 0, 0);
> +
> +       if (ret !=3D 0)
> +               ksft_exit_fail_msg("Get shadow stack status failed with %=
d\n", ret);
> +
> +       /*
> +        * If we are here that means get shadow stack status succeeded an=
d
> +        * thus shadow stack support is baked in the kernel.
> +        */
> +       while (test_count < ARRAY_SIZE(shstk_tests)) {

I saw we have RISCV_SHADOW_STACK_TESTS for ARRAY_SIZE(shstk_tests),
perhaps we can use that macro.

> +               test_pass =3D (*shstk_tests[test_count].t_func)(test_coun=
t, NULL);
> +               ksft_test_result(test_pass, shstk_tests[test_count].name)=
;
> +               test_count++;
> +       }
> +
> +       ksft_finished();
> +
> +       return 0;
> +}
> +
> +#pragma GCC pop_options
> diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.h b/tools/test=
ing/selftests/riscv/cfi/shadowstack.h
> new file mode 100644
> index 000000000000..b43e74136a26
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/shadowstack.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef SELFTEST_SHADOWSTACK_TEST_H
> +#define SELFTEST_SHADOWSTACK_TEST_H
> +#include <stddef.h>
> +#include <linux/prctl.h>
> +
> +/*
> + * a cfi test returns true for success or false for fail
> + * takes a number for test number to index into array and void pointer.
> + */
> +typedef bool (*shstk_test_func)(unsigned long test_num, void *);
> +
> +struct shadow_stack_tests {
> +       char *name;
> +       shstk_test_func t_func;
> +};
> +
> +bool shadow_stack_fork_test(unsigned long test_num, void *ctx);
> +bool shadow_stack_map_test(unsigned long test_num, void *ctx);
> +bool shadow_stack_protection_test(unsigned long test_num, void *ctx);
> +bool shadow_stack_gup_tests(unsigned long test_num, void *ctx);
> +bool shadow_stack_signal_test(unsigned long test_num, void *ctx);
> +
> +static struct shadow_stack_tests shstk_tests[] =3D {
> +       { "shstk fork test\n", shadow_stack_fork_test },
> +       { "map shadow stack syscall\n", shadow_stack_map_test },
> +       { "shadow stack gup tests\n", shadow_stack_gup_tests },
> +       { "shadow stack signal tests\n", shadow_stack_signal_test},
> +       { "memory protections of shadow stack memory\n", shadow_stack_pro=
tection_test }
> +};
> +
> +#define RISCV_SHADOW_STACK_TESTS ARRAY_SIZE(shstk_tests)

I still got the following compile warning, maybe we can move them to
the shadowstack.c

shadowstack.h:25:34: warning: 'shstk_tests' defined but not used
[-Wunused-variable]
   25 | static struct shadow_stack_tests shstk_tests[] =3D {
      |                                  ^~~~~~~~~~~

> +
> +int execute_shadow_stack_tests(void);
> +
> +#endif
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

