Return-Path: <linux-fsdevel+bounces-52689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C8AE5DBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3DF1BC01CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 07:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D579252906;
	Tue, 24 Jun 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g7RhFYcE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9C2550C2
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750185; cv=none; b=iTLIAmNWumva6GqQVeL/Id5swNJEj5Fgtp8mXCqtWrJIRmk44j/bkujUHr23gwXRAqVknlUWFMqKqxWdMMhWg+mtdlVVi3ilxULZc4sHS/W65NxEstqJa3DCBm86yFMmYZSKW7MlT6DR5maJTGkePVRydox2zhWGRSh/iYsfoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750185; c=relaxed/simple;
	bh=Wyq1CNHwEFonTvgEGs3phKEvj+/XcFZS7wIpql7BYKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRJjnyFio+keMcp3wnHniXoBYUrw4qSmDgaf8QB66WRzMAnjBOkCEoJJ2DKO1SoXnv0ZbefVa6pE9pE1ClU0KAp5RaVwngZdZKch7ld9/cjYzrLZnZc58OqBRA8kxjR5DZ1xU6yxH64DeDOV++2Es+yBJc1d8OVLdPL3oIFULGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=g7RhFYcE; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-874a68f6516so10572539f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1750750182; x=1751354982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCAx15zg9RW4K8KXkbEJeib3OebKP7rlI+yhk9VbeJ8=;
        b=g7RhFYcETIITTAYrvlhLzgtlg7o1L+MKGm6irxR1dB5I1zWQXSU78DRvKf9dnybGKW
         W5VhVey+okW4hkNVH6RkYnvFAnb7MDcU1WVa+rQx8pHHnmtZKW8mfYOEPTWjGySAD/5m
         Zno6UAUJRZt6di18Le2mUCgNxJuT6GxCNbzT/xkdEduakjQ5y+qeRljEhj6QxBiaLeJ3
         iWoHRa+icwrizZpxSfrh2bmbM93x/jN1ulSr1zEdzaH5blSqXi1/lOXTdX8FC5WFz5jc
         IduRX0M8FnpVZ8wy24vxwsDN5Al8XMvfo0KDx60ZuckOd/4d9ScPoRtDQOqBJOdXlHCh
         k9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750750182; x=1751354982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCAx15zg9RW4K8KXkbEJeib3OebKP7rlI+yhk9VbeJ8=;
        b=WOxhiOt+N+E6RzxFfmrdLBFySJtwtWLmQOalOov9BjQKDKhNLa8nw7XY/dCWEwydyB
         65zgH0YhfahanhkpxvWMoaBJ79nmJMpM9WxQo0RKHWWT8lqv5zK7il8bcHJ5oXemqQ29
         Vi32sjvT1PbfTSmdsfn6Sp7fssdAmACPA29Ip4DSl/SHbI1hieiBOsyO/a5dOatw0FfU
         rlJPDJrbUDbExsPhmsFWIz++MkBBVVXEDT4OuIMZrvofOgIqEmCWigf+JaKIYt6r6UV4
         y42w3NciNJ5RwFGUcdPRaEKAAgVb6phIAyWxfmkCCS+u5FnH5odPa1NhrcsmtlV9HZ9x
         ch8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc4kZVR3d9HTx9tNYieJ6lOsH+1/DXscvUGkwmUUO94BLXOnFk03PovBaeDnvLad4iFFdTOb3M+q11DUcP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90MosCLdLsNmhXv1IzHQDyf44as4nM7lkgy6rt1s/f7K6Gdst
	WRTssbLYEdWZPKIbxwk+xyzBskJibLABnoht7L6g0tXeLFLyZKA/UZZqYOM8uVKOKPMtYyZKi9S
	4bQh5fwsS89whyAJi8EKEpQjLDzLC0c+6c6zSq9vg2g==
X-Gm-Gg: ASbGncvYq18Ft8u7UBXd42G5vE/yui8/3qGu9uGnBahOApaikC55rxwZGnsIqBO2kDT
	KDwt1eApYCVYNfSDYfqSaIlG/v14fmj1ZLTEBOjNrQmG4yjmbEzmAz2owA8BP7npkxukDNiXvWO
	FoZZ6U1Zf6DXvw4IG/dX2QFQTKz+yoiv/SwEfUkRm3IzHMJQ==
X-Google-Smtp-Source: AGHT+IH6hRbPz4KJd4uHusg55uzqEZNbIEEtPoBg2Di8b55LbLqgN3m0kaio6V1nAiVuXSaR5cp2kjghUWOHqxTA20U=
X-Received: by 2002:a05:6e02:19c8:b0:3dd:a3e4:2def with SMTP id
 e9e14a558f8ab-3de38cbfe5cmr169073095ab.16.1750750181761; Tue, 24 Jun 2025
 00:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com> <20250604-v5_user_cfi_series-v17-23-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-23-4565c2cf869f@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 24 Jun 2025 15:29:23 +0800
X-Gm-Features: AX0GCFtqo33kUwQ41tFem8GGyjdAkGeTRdsf_5aqfLZF6MkgxmnaqyzxPU27Aco
Message-ID: <CANXhq0qy_0Lth1a-aZ+dd5p+HXKRpbgsc522v9_kqP1Ve67J2w@mail.gmail.com>
Subject: Re: [PATCH v17 23/27] arch/riscv: compile vdso with landing pad
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
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 1:17=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> From: Jim Shu <jim.shu@sifive.com>
>
> user mode tasks compiled with zicfilp may call indirectly into vdso (like
> hwprobe indirect calls). Add landing pad compile support in vdso. vdso
> with landing pad in it will be nop for tasks which have not enabled
> landing pad.
> This patch allows to run user mode tasks with cfi eanbled and do no harm.
>
> Future work can be done on this to do below
>  - labeled landing pad on vdso functions (whenever labeling support shows
>    up in gnu-toolchain)
>  - emit shadow stack instructions only in vdso compiled objects as part o=
f
>    kernel compile.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/Makefile                   |  5 +++-
>  arch/riscv/include/asm/assembler.h    | 44 +++++++++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/vdso/Makefile       |  6 +++++
>  arch/riscv/kernel/vdso/flush_icache.S |  4 ++++
>  arch/riscv/kernel/vdso/getcpu.S       |  4 ++++
>  arch/riscv/kernel/vdso/rt_sigreturn.S |  4 ++++
>  arch/riscv/kernel/vdso/sys_hwprobe.S  |  4 ++++
>  7 files changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 539d2aef5cab..c2dd09bb9db3 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -88,9 +88,12 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) :=3D $(riscv=
-march-y)_zacas
>  # Check if the toolchain supports Zabha
>  riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) :=3D $(riscv-march-y)_zabha
>
> +KBUILD_BASE_ISA =3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/(=
rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> +export KBUILD_BASE_ISA
> +
>  # Remove F,D,V from isa string for all. Keep extensions between "fd" and=
 "v" by
>  # matching non-v and non-multi-letter extensions out with the filter ([^=
v_]*)
> -KBUILD_CFLAGS +=3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/(r=
v32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> +KBUILD_CFLAGS +=3D $(KBUILD_BASE_ISA)
>
>  KBUILD_AFLAGS +=3D -march=3D$(riscv-march-y)
>
> diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/=
assembler.h
> index 44b1457d3e95..a058ea5e9c58 100644
> --- a/arch/riscv/include/asm/assembler.h
> +++ b/arch/riscv/include/asm/assembler.h
> @@ -80,3 +80,47 @@
>         .endm
>
>  #endif /* __ASM_ASSEMBLER_H */
> +
> +#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen =3D=3D 64)
> +.macro vdso_lpad
> +lpad 0
> +.endm
> +#else
> +.macro vdso_lpad
> +.endm
> +#endif
> +
> +/*
> + * This macro emits a program property note section identifying
> + * architecture features which require special handling, mainly for
> + * use in assembly files included in the VDSO.
> + */
> +#define NT_GNU_PROPERTY_TYPE_0  5
> +#define GNU_PROPERTY_RISCV_FEATURE_1_AND 0xc0000000
> +
> +#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP      (1U << 0)
> +#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFISS      (1U << 1)
> +
> +#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen =3D=3D 64)
> +#define GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT \
> +       (GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP)
> +#endif
> +
> +#ifdef GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT
> +.macro emit_riscv_feature_1_and, feat =3D GNU_PROPERTY_RISCV_FEATURE_1_D=
EFAULT
> +       .pushsection .note.gnu.property, "a"
> +       .p2align        3
> +       .word           4
> +       .word           16
> +       .word           NT_GNU_PROPERTY_TYPE_0
> +       .asciz          "GNU"
> +       .word           GNU_PROPERTY_RISCV_FEATURE_1_AND
> +       .word           4
> +       .word           \feat
> +       .word           0
> +       .popsection
> +.endm
> +#else
> +.macro emit_riscv_feature_1_and, feat =3D 0
> +.endm
> +#endif
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index ad73607abc28..441c5431d27e 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -13,12 +13,18 @@ vdso-syms +=3D flush_icache
>  vdso-syms +=3D hwprobe
>  vdso-syms +=3D sys_hwprobe
>
> +ifdef CONFIG_RISCV_USER_CFI
> +LPAD_MARCH =3D _zicfilp_zicfiss -fcf-protection=3Dfull

Hi Deepak,
I guess we only want to generate landing pad instructions in vdso, if
so, the -fcf-protection should be set to branch instead of full.
(i.e., -fcf-protection=3Dbranch).

> +endif
> +
>  # Files to link into the vdso
>  obj-vdso =3D $(patsubst %, %.o, $(vdso-syms)) note.o
>
>  ccflags-y :=3D -fno-stack-protector
>  ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
>  ccflags-y +=3D -fno-builtin
> +ccflags-y +=3D $(KBUILD_BASE_ISA)$(LPAD_MARCH)
> +asflags-y +=3D $(KBUILD_BASE_ISA)$(LPAD_MARCH)
>
>  ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o +=3D -fPIC -include $(c-gettimeofday-y)
> diff --git a/arch/riscv/kernel/vdso/flush_icache.S b/arch/riscv/kernel/vd=
so/flush_icache.S
> index 8f884227e8bc..e4c56970905e 100644
> --- a/arch/riscv/kernel/vdso/flush_icache.S
> +++ b/arch/riscv/kernel/vdso/flush_icache.S
> @@ -5,11 +5,13 @@
>
>  #include <linux/linkage.h>
>  #include <asm/unistd.h>
> +#include <asm/assembler.h>
>
>         .text
>  /* int __vdso_flush_icache(void *start, void *end, unsigned long flags);=
 */
>  SYM_FUNC_START(__vdso_flush_icache)
>         .cfi_startproc
> +       vdso_lpad
>  #ifdef CONFIG_SMP
>         li a7, __NR_riscv_flush_icache
>         ecall
> @@ -20,3 +22,5 @@ SYM_FUNC_START(__vdso_flush_icache)
>         ret
>         .cfi_endproc
>  SYM_FUNC_END(__vdso_flush_icache)
> +
> +emit_riscv_feature_1_and
> diff --git a/arch/riscv/kernel/vdso/getcpu.S b/arch/riscv/kernel/vdso/get=
cpu.S
> index 9c1bd531907f..5c1ecc4e1465 100644
> --- a/arch/riscv/kernel/vdso/getcpu.S
> +++ b/arch/riscv/kernel/vdso/getcpu.S
> @@ -5,14 +5,18 @@
>
>  #include <linux/linkage.h>
>  #include <asm/unistd.h>
> +#include <asm/assembler.h>
>
>         .text
>  /* int __vdso_getcpu(unsigned *cpu, unsigned *node, void *unused); */
>  SYM_FUNC_START(__vdso_getcpu)
>         .cfi_startproc
> +       vdso_lpad
>         /* For now, just do the syscall. */
>         li a7, __NR_getcpu
>         ecall
>         ret
>         .cfi_endproc
>  SYM_FUNC_END(__vdso_getcpu)
> +
> +emit_riscv_feature_1_and
> diff --git a/arch/riscv/kernel/vdso/rt_sigreturn.S b/arch/riscv/kernel/vd=
so/rt_sigreturn.S
> index 3dc022aa8931..e82987dc3739 100644
> --- a/arch/riscv/kernel/vdso/rt_sigreturn.S
> +++ b/arch/riscv/kernel/vdso/rt_sigreturn.S
> @@ -5,12 +5,16 @@
>
>  #include <linux/linkage.h>
>  #include <asm/unistd.h>
> +#include <asm/assembler.h>
>
>         .text
>  SYM_FUNC_START(__vdso_rt_sigreturn)
>         .cfi_startproc
>         .cfi_signal_frame
> +       vdso_lpad
>         li a7, __NR_rt_sigreturn
>         ecall
>         .cfi_endproc
>  SYM_FUNC_END(__vdso_rt_sigreturn)
> +
> +emit_riscv_feature_1_and
> diff --git a/arch/riscv/kernel/vdso/sys_hwprobe.S b/arch/riscv/kernel/vds=
o/sys_hwprobe.S
> index 77e57f830521..f1694451a60c 100644
> --- a/arch/riscv/kernel/vdso/sys_hwprobe.S
> +++ b/arch/riscv/kernel/vdso/sys_hwprobe.S
> @@ -3,13 +3,17 @@
>
>  #include <linux/linkage.h>
>  #include <asm/unistd.h>
> +#include <asm/assembler.h>
>
>  .text
>  SYM_FUNC_START(riscv_hwprobe)
>         .cfi_startproc
> +       vdso_lpad
>         li a7, __NR_riscv_hwprobe
>         ecall
>         ret
>
>         .cfi_endproc
>  SYM_FUNC_END(riscv_hwprobe)
> +
> +emit_riscv_feature_1_and
>
> --
> 2.43.0
>

