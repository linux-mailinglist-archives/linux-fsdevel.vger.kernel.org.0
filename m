Return-Path: <linux-fsdevel+bounces-64349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30423BE2286
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD87858115B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D53054F6;
	Thu, 16 Oct 2025 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hdceqGFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD5281370
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603543; cv=none; b=MAsc6Z+3JVgzhFYQrnz/Mo9aGTyq+zMOdag1Wg6nV0NhfFtcU4z7VAR8GTZqrJKykS6T7Lg27P5/P182bToBYfMsqDiosPd6R+ZFJ5emzEsw0fkQMfAbwm4aHXunIV7xJXO0aWHIY1aE/n47sfEy/zUkF27YKDCL/HcIXJsOMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603543; c=relaxed/simple;
	bh=QDgfIhSA3WyFqLshlxgldAn9dZcKTZLfDbE2aYR+imI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtN2iKskHBGYd04hbYEWf8W393/9cDRuTaoAgaYms/Wk9ERWFyOWACvlrA6VXltNTEfLnEoB4Zh0lTMlDrHQwKnt9ZIWmngEhR3idGp5oCi1cCsMucOA4GDnXyL1K85tFsDLik6WFe777s6ijzgogxynNzvrUfIsNuLfrZS+Sjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hdceqGFv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so1045044a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760603539; x=1761208339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGUnawecL83edOGjPf+u6bC7T95P7jfXKCNsQBzg0rA=;
        b=hdceqGFvUUiIxztyD835C7aM5J336GrnRcWKLtuyCq5IGw4WO5eJXEe8BhxkjqyZ6j
         xr8jNR7LCsBDceW5Ghlj+0Rzc3t7pRxPcjHM0C3jg7UvwY8O8HXQ27qFHDfV0VM0iLC9
         i8Bo8o06zP+3JCNYdHEaxAwb634fLZKxxtzlgrDIRzqi80luQO5Pgkj+ObfcOY8scj9c
         YW81+y4BArHpayOh5QKKSAKpVxm7m3rQsErWPYzGx5oAIIqrTdjRLErk9ceus78mEwrb
         60A9Yjuk0SD7bYXMmojXboJ0vr7yUxhNOObkteI++hZb+8ttQ3WI0RRhlcd/GDFHSmt1
         dlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603540; x=1761208340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGUnawecL83edOGjPf+u6bC7T95P7jfXKCNsQBzg0rA=;
        b=wtT7ONxIidovWX3/SbGmoHWG1kegp5kcrTpYcUS7MogRmCFxgkCjz3EN3HSfDdYmVM
         0CuC5V4nWG8MCOAOqAuKYn1DKSyAHbE+Zr9klQptWV4PfHjf/Micpwv2H3vysTv3JNsI
         wUK0AhZG9mGkiOb+0CPBNQg9/9uS6c7R5DLoex/r9Q8aNs231M2JPOot2I4RqA7c33OD
         fowtqDYEwtrsxKEScpDDVLaF6Td9WpXUp/tTbTGu7okm1OGfvf/KXKNkrTK2fQYqrLEv
         ZicBgyKddy3+Ufgao1c+HdD57kVLh2fZ20KBxT3q+goAtwwXvAC7PXSG3av0xQnd7jgU
         7VdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdHK9ISA2/rY1MGDycnGHYn4IcyAXDffPxBAdCJSzLq+y8YWsNS3Eii4F1ssWPElmr9zAITdeKXxQu5Aci@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXMThGh+UeS+cwtS5+qKRNUGNvfIDfqPBn2YXevAfNP6IuODr
	u4NLpOdadlqGHm7XuvidM9scXBgtBGICKS9IgmSm3j7FzkGnL1CZKPyvdndybB+05SFhSTFh0JP
	g5xGYCuXw3ScRNS5NSUaw/je++TJmi+zseOXLIc0wfg==
X-Gm-Gg: ASbGncupf+gccJ3f5GFei4XySpwXq8+2S78N765hLk7FZGpH2BAB792Osvi4aoRpWfN
	npJCVvngoI9nXgpjKzwgwLJkx/IyZT+Y1h2jFxA6GbNLuDMYSc1kgMP/BgLC4uXynNC1BU46g1q
	lYIZy10Ybkoh+juPTHie9gIs5KG2U4xgwvmrmDnfwB7+th68pAk/f6t0QuQbJ6aesO8Z5zTPIjS
	DfIuLQnf6sfR9MXjz8I8WJz4LaUf/p528Yc6fKFUjBoBH0ZDlXwkxO81xQ4hb471hAVRCY76g==
X-Google-Smtp-Source: AGHT+IFHq55tnkrijYl7UmxNSZkHg8MUK7rL86Qec+QFny2Jj+Nqgl6hHNvXTQ4ak+tVR4IZPuR8dIifQEuqb6CMGOw=
X-Received: by 2002:a05:6402:2706:b0:63c:1066:8bec with SMTP id
 4fb4d7f45d1cf-63c10668e2bmr685991a12.35.1760603539325; Thu, 16 Oct 2025
 01:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com> <20251013-v5_user_cfi_series-v20-24-b9de4be9912e@rivosinc.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-24-b9de4be9912e@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 16 Oct 2025 16:32:08 +0800
X-Gm-Features: AS18NWDdABXVeVU4BxVD4PUOdUQ6DbOXUTRdVQ9iYOyQ5bKOkgL4sYwtV7PCBF4
Message-ID: <CANXhq0rVGisy33n6gB-P8B0ALiB2LqqYbKsSqgJLCNNRecP9TA@mail.gmail.com>
Subject: Re: [PATCH v20 24/28] arch/riscv: dual vdso creation logic and select
 vdso based on hw
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
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
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

On Tue, Oct 14, 2025 at 5:57=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Shadow stack instructions are taken from zimop (mandated on RVA23).
> Any hardware prior to RVA23 profile will fault on shado stack instruction=
.

I notice that there is a typo for shado"w" stack instruction.

> Any userspace with shadow stack instruction in it will fault on such
> hardware. Thus such userspace can't be brought onto such a hardware.
>
> It's not known how userspace will respond to such binary fragmentation.
> However in order to keep kernel portable across such different hardware,
> `arch/riscv/kernel/vdso_cfi` is created which has logic (Makefile) to
> compile `arch/riscv/kernel/vdso` sources with cfi flags and then changes
> in `arch/riscv/kernel/vdso.c` for selecting appropriate vdso depending
> on whether underlying hardware(cpu) implements zimop extension. Offset
> of vdso symbols will change due to having two different vdso binaries,
> there is added logic to include new generated vdso offset header and
> dynamically select offset (like for rt_sigreturn).
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/Makefile                        |  3 +++
>  arch/riscv/include/asm/vdso.h              |  7 ++++++-
>  arch/riscv/kernel/Makefile                 |  1 +
>  arch/riscv/kernel/vdso.c                   |  7 +++++++
>  arch/riscv/kernel/vdso/Makefile            | 29 ++++++++++++++++++++----=
-----
>  arch/riscv/kernel/vdso/gen_vdso_offsets.sh |  4 +++-
>  arch/riscv/kernel/vdso_cfi/Makefile        | 25 ++++++++++++++++++++++++=
+
>  arch/riscv/kernel/vdso_cfi/vdso-cfi.S      | 11 +++++++++++
>  8 files changed, 76 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index f60c2de0ca08..b74b63da16a7 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -176,6 +176,8 @@ ifeq ($(CONFIG_MMU),y)
>  prepare: vdso_prepare
>  vdso_prepare: prepare0
>         $(Q)$(MAKE) $(build)=3Darch/riscv/kernel/vdso include/generated/v=
dso-offsets.h
> +       $(if $(CONFIG_RISCV_USER_CFI),$(Q)$(MAKE) \
> +               $(build)=3Darch/riscv/kernel/vdso_cfi include/generated/v=
dso-cfi-offsets.h)
>         $(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
>                 $(build)=3Darch/riscv/kernel/compat_vdso include/generate=
d/compat_vdso-offsets.h)
>
> @@ -183,6 +185,7 @@ endif
>  endif
>
>  vdso-install-y                 +=3D arch/riscv/kernel/vdso/vdso.so.dbg
> +vdso-install-$(CONFIG_RISCV_USER_CFI)  +=3D arch/riscv/kernel/vdso_cfi/v=
dso-cfi.so.dbg
>  vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/compat=
_vdso.so.dbg
>
>  BOOT_TARGETS :=3D Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lz=
o Image.zst Image.xz loader loader.bin xipImage vmlinuz.efi
> diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.=
h
> index f80357fe24d1..3fc8f72b8bfb 100644
> --- a/arch/riscv/include/asm/vdso.h
> +++ b/arch/riscv/include/asm/vdso.h
> @@ -18,9 +18,13 @@
>
>  #ifndef __ASSEMBLER__
>  #include <generated/vdso-offsets.h>
> +#include <generated/vdso-cfi-offsets.h>
>
>  #define VDSO_SYMBOL(base, name)                                         =
               \
> -       (void __user *)((unsigned long)(base) + __vdso_##name##_offset)
> +       ((IS_ENABLED(CONFIG_RISCV_USER_CFI) &&                           =
       \
> +         riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) ?           =
       \
> +         (void __user *)((unsigned long)(base) + __vdso_##name##_cfi_off=
set) : \
> +         (void __user *)((unsigned long)(base) + __vdso_##name##_offset)=
)
>
>  #ifdef CONFIG_COMPAT
>  #include <generated/compat_vdso-offsets.h>
> @@ -33,6 +37,7 @@ extern char compat_vdso_start[], compat_vdso_end[];
>  #endif /* CONFIG_COMPAT */
>
>  extern char vdso_start[], vdso_end[];
> +extern char vdso_cfi_start[], vdso_cfi_end[];
>
>  #endif /* !__ASSEMBLER__ */
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 2d0e0dcedbd3..9026400cba10 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -72,6 +72,7 @@ obj-y +=3D vendor_extensions/
>  obj-y  +=3D probes/
>  obj-y  +=3D tests/
>  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> +obj-$(CONFIG_RISCV_USER_CFI) +=3D vdso_cfi/
>
>  obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o
>  obj-$(CONFIG_RISCV_MISALIGNED) +=3D unaligned_access_speed.o
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index 3a8e038b10a2..bf080e519101 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -98,6 +98,13 @@ static struct __vdso_info compat_vdso_info __ro_after_=
init =3D {
>
>  static int __init vdso_init(void)
>  {
> +       /* Hart implements zimop, expose cfi compiled vdso */
> +       if (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
> +               riscv_has_extension_unlikely(RISCV_ISA_EXT_ZIMOP)) {
> +               vdso_info.vdso_code_start =3D vdso_cfi_start;
> +               vdso_info.vdso_code_end =3D vdso_cfi_end;
> +       }
> +
>         __vdso_init(&vdso_info);
>  #ifdef CONFIG_COMPAT
>         __vdso_init(&compat_vdso_info);
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index 272f1d837a80..a842dc034571 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -20,6 +20,10 @@ endif
>  ifdef VDSO_CFI_BUILD
>  CFI_MARCH =3D _zicfilp_zicfiss
>  CFI_FULL =3D -fcf-protection=3Dfull
> +CFI_SUFFIX =3D -cfi
> +OFFSET_SUFFIX =3D _cfi
> +ccflags-y +=3D -DVDSO_CFI=3D1
> +asflags-y +=3D -DVDSO_CFI=3D1
>  endif
>
>  # Files to link into the vdso
> @@ -48,13 +52,20 @@ endif
>  CFLAGS_hwprobe.o +=3D -fPIC
>
>  # Build rules
> -targets :=3D $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
> +vdso_offsets :=3D vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),)-offsets.h
> +vdso_o :=3D vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).o
> +vdso_so :=3D vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).so
> +vdso_so_dbg :=3D vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).so.dbg
> +vdso_lds :=3D vdso.lds
> +
> +targets :=3D $(obj-vdso) $(vdso_so) $(vdso_so_dbg) $(vdso_lds)
> +
>  obj-vdso :=3D $(addprefix $(obj)/, $(obj-vdso))
>
> -obj-y +=3D vdso.o
> -CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
> +obj-y +=3D vdso$(if $(VDSO_CFI_BUILD),$(CFI_SUFFIX),).o
> +CPPFLAGS_$(vdso_lds) +=3D -P -C -U$(ARCH)
>  ifneq ($(filter vgettimeofday, $(vdso-syms)),)
> -CPPFLAGS_vdso.lds +=3D -DHAS_VGETTIMEOFDAY
> +CPPFLAGS_$(vdso_lds) +=3D -DHAS_VGETTIMEOFDAY
>  endif
>
>  # Disable -pg to prevent insert call site
> @@ -63,12 +74,12 @@ CFLAGS_REMOVE_getrandom.o =3D $(CC_FLAGS_FTRACE) $(CC=
_FLAGS_SCS)
>  CFLAGS_REMOVE_hwprobe.o =3D $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>
>  # Force dependency
> -$(obj)/vdso.o: $(obj)/vdso.so
> +$(obj)/$(vdso_o): $(obj)/$(vdso_so)
>
>  # link rule for the .so file, .lds has to be first
> -$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
> +$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) FORCE
>         $(call if_changed,vdsold_and_check)
> -LDFLAGS_vdso.so.dbg =3D -shared -soname=3Dlinux-vdso.so.1 \
> +LDFLAGS_$(vdso_so_dbg) =3D -shared -soname=3Dlinux-vdso.so.1 \
>         --build-id=3Dsha1 --eh-frame-hdr
>
>  # strip rule for the .so file
> @@ -79,9 +90,9 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
>  # Generate VDSO offsets using helper script
>  gen-vdsosym :=3D $(src)/gen_vdso_offsets.sh
>  quiet_cmd_vdsosym =3D VDSOSYM $@
> -       cmd_vdsosym =3D $(NM) $< | $(gen-vdsosym) | LC_ALL=3DC sort > $@
> +       cmd_vdsosym =3D $(NM) $< | $(gen-vdsosym) $(OFFSET_SUFFIX) | LC_A=
LL=3DC sort > $@
>
> -include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
> +include/generated/$(vdso_offsets): $(obj)/$(vdso_so_dbg) FORCE
>         $(call if_changed,vdsosym)
>
>  # actual build commands
> diff --git a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh b/arch/riscv/kern=
el/vdso/gen_vdso_offsets.sh
> index c2e5613f3495..bd5d5afaaa14 100755
> --- a/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
> +++ b/arch/riscv/kernel/vdso/gen_vdso_offsets.sh
> @@ -2,4 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  LC_ALL=3DC
> -sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#defin=
e \2_offset\t0x\1/p'
> +SUFFIX=3D${1:-""}
> +sed -n -e \
> +'s/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define \2'$SUFF=
IX'_offset\t0x\1/p'
> diff --git a/arch/riscv/kernel/vdso_cfi/Makefile b/arch/riscv/kernel/vdso=
_cfi/Makefile
> new file mode 100644
> index 000000000000..8ebd190782b0
> --- /dev/null
> +++ b/arch/riscv/kernel/vdso_cfi/Makefile
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# RISC-V VDSO CFI Makefile
> +# This Makefile builds the VDSO with CFI support when CONFIG_RISCV_USER_=
CFI is enabled
> +
> +# setting VDSO_CFI_BUILD triggers build for vdso differently
> +VDSO_CFI_BUILD :=3D 1
> +
> +# Set the source directory to the main vdso directory
> +src :=3D $(srctree)/arch/riscv/kernel/vdso
> +
> +# Copy all .S and .c files from vdso directory to vdso_cfi object build =
directory
> +vdso_c_sources :=3D $(wildcard $(src)/*.c)
> +vdso_S_sources :=3D $(wildcard $(src)/*.S)
> +vdso_c_objects :=3D $(addprefix $(obj)/, $(notdir $(vdso_c_sources)))
> +vdso_S_objects :=3D $(addprefix $(obj)/, $(notdir $(vdso_S_sources)))
> +
> +$(vdso_S_objects): $(obj)/%.S: $(src)/%.S
> +       $(Q)cp $< $@
> +
> +$(vdso_c_objects): $(obj)/%.c: $(src)/%.c
> +       $(Q)cp $< $@
> +
> +# Include the main VDSO Makefile which contains all the build rules and =
sources
> +# The VDSO_CFI_BUILD variable will be passed to it to enable CFI compila=
tion
> +include $(src)/Makefile
> diff --git a/arch/riscv/kernel/vdso_cfi/vdso-cfi.S b/arch/riscv/kernel/vd=
so_cfi/vdso-cfi.S
> new file mode 100644
> index 000000000000..d426f6accb35
> --- /dev/null
> +++ b/arch/riscv/kernel/vdso_cfi/vdso-cfi.S
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2025 Rivos, Inc
> + */
> +
> +#define        vdso_start      vdso_cfi_start
> +#define        vdso_end        vdso_cfi_end
> +
> +#define __VDSO_PATH "arch/riscv/kernel/vdso_cfi/vdso-cfi.so"
> +
> +#include "../vdso/vdso.S"
>
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

