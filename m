Return-Path: <linux-fsdevel+bounces-44003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EFEA60AD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 09:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361E516E062
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D360F194A75;
	Fri, 14 Mar 2025 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fe0OlAGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34508191F66
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939840; cv=none; b=MUNbAWZCUnZqWLATejRUw8/7/JEH1HRMywNL1hsitMcHzYcl5SLDoInHZavtJIcIdSMkID5ps0MEuEYkYjAmn75QWshY7Y2HUWa76NHF4y0n0o+eENGxxYu94SwgiZvqjdi8BPW1G55SoeCNjGK6QBXbFAZC+1QoLho+O1kCwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939840; c=relaxed/simple;
	bh=J9W/tM13EIIllauoi40EROSVBNfzNEqDPKfRn8QEwgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVgIcRm74t40EhQptUMgSAabmiShUCXT8XYiIog6RFRLgqnS5ux5L8Ptg6IHbNjMpFi0oQZWDafQeUl1sGh7m7rYvrtG+BuTsW4piioijh9mpq4SWiXT16cdqMiR657c4U264Nbt0Dy8bLfoZMQAetHJqqE6N+FvEThlWxlBaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fe0OlAGT; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d4496a34cdso7018885ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 01:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741939837; x=1742544637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maat8Z8CQlIo/YQgvM5joGb0bwlzNNQQ5lvrvmfPTnE=;
        b=fe0OlAGTebdWN4bzy2YgTdfPZeIIO7KNRRYxxCOviK0+S0bjWrvi7Ut9dJn8EcRxGn
         RueVgr5L3kwoz/uvFocUPLqjthpmyiBRA8saSc5DWE3/kfEhG8xafDoilDdLj5Uga8VV
         A+Ge32/bvLiH2w1hOeU8lgHYWveVoAi+Kj91NHwf37glXcWf/nAVXxoVp70tdxOySLCB
         JS97qcCQXwDZ/uTjuNx5A6+8ej6FTElh+isMqXjM/U5WMLYfGGK6VsRJbUeUSDthOf74
         NZMj+QApaQpMOmHHpiv8QZg0gvrV/DdTr0ToV7Mqk6v7Ip+A88sZZzxt8IdQahf9CIA9
         +bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939837; x=1742544637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maat8Z8CQlIo/YQgvM5joGb0bwlzNNQQ5lvrvmfPTnE=;
        b=BMAFvqNotZpYtuPPrfBusx38o76WYOE6v9edaKuDfTBUt7uKri96Jo791qU6BUHf2j
         AcNbqPSpSh6nX1SivloEGLf1ONiU5FYvi9QywcR6+0q824pXmjgepV7eCgGaHSRrm+ZG
         ArtoAB8Gvk4li2X8m0ZpHHoQNrYGG7mMyYBG5HfGR8ajYl0Rm0QEbGXTLPZVnnztG88N
         sb1/UStQGma7JAY5ABFxLAFhM8zHkGF4rThx8R8i2VlLKrG8rak8Sz2GTBsEQ5yyHkix
         4+A3l8pGL8TEFsiSWwXR+cPXPgDEA8VETi+yGjye7yqHBHd/gvxIbFKqfHtsoO//2yU3
         VJGA==
X-Forwarded-Encrypted: i=1; AJvYcCWxfukyvL28e5ep5zfmqm3wTWptsuZexLcAvuDAQRVx+EwkJMqIQK+kBCDSFBBL3uAQd1UYPqxjSiM2ASV/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3u+DZ4iPrQWcTyddRZHU1LZYhUZq6NiDOpUxXhSZmDBK4WLWx
	NyM+Ox263N9T1lk2sBzQ4ev0voMikRO0w4OxeC0hwhTG7V5rmMOTtoG4FnOey9oBpean4jkOhev
	rTEPl6rW2/l/KuvTCxpESuvj/IbRBrn8j59qGaQ==
X-Gm-Gg: ASbGncsfCqBTbGuVqPP+RPKs/Q5RznxAixX03usXLYtg2rhPns8qptx3vPOMmfZBkd7
	RCDLph8NxhI6Hi04Aw8kmOX33vZ4eeg1Y3UhrAwJtjDY/Ofm9FVzL1cQW3zlV/gvzAOWUQwKHKG
	OPS+pWbPSegT5WVIFh1/2wnzQ8t/Z0mU+O5NGA6ag=
X-Google-Smtp-Source: AGHT+IEr06JJWPIe++RWZprx7+sk0G4gmp805oxABOzSJgVtajhlGN2WM+TyYd1zsyGazHwiZ0K31rleVVMRVGbr6R4=
X-Received: by 2002:a92:c246:0:b0:3d4:3ab3:5574 with SMTP id
 e9e14a558f8ab-3d4839feb6emr12608625ab.3.1741939837275; Fri, 14 Mar 2025
 01:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-3-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-3-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:10:24 +0800
X-Gm-Features: AQ5f1JpIIk67nxD8XYVlg0yQoGLERm_fNClgnrJ71NE6nAneEkcJbes_9dfQWtA
Message-ID: <CANXhq0p22tsMUBffV4rTu+Txf0ugmpUmUQZWf2EX00Qxhvq2_Q@mail.gmail.com>
Subject: Re: [PATCH v11 03/27] riscv: zicfiss / zicfilp enumeration
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

On Mon, Mar 10, 2025 at 11:42=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> This patch adds support for detecting zicfiss and zicfilp. zicfiss and
> zicfilp stands for unprivleged integer spec extension for shadow stack
> and branch tracking on indirect branches, respectively.
>
> This patch looks for zicfiss and zicfilp in device tree and accordinlgy
> lights up bit in cpu feature bitmap. Furthermore this patch adds detectio=
n
> utility functions to return whether shadow stack or landing pads are
> supported by cpu.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h | 13 +++++++++++++
>  arch/riscv/include/asm/hwcap.h      |  2 ++
>  arch/riscv/include/asm/processor.h  |  1 +
>  arch/riscv/kernel/cpufeature.c      | 13 +++++++++++++
>  4 files changed, 29 insertions(+)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 569140d6e639..69007b8100ca 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -12,6 +12,7 @@
>  #include <linux/kconfig.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/threads.h>
> +#include <linux/smp.h>
>  #include <asm/hwcap.h>
>  #include <asm/cpufeature-macros.h>
>
> @@ -137,4 +138,16 @@ static __always_inline bool riscv_cpu_has_extension_=
unlikely(int cpu, const unsi
>         return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>  }
>
> +static inline bool cpu_supports_shadow_stack(void)
> +{
> +       return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
> +               riscv_cpu_has_extension_unlikely(smp_processor_id(), RISC=
V_ISA_EXT_ZICFISS));
> +}
> +
> +static inline bool cpu_supports_indirect_br_lp_instr(void)
> +{
> +       return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
> +               riscv_cpu_has_extension_unlikely(smp_processor_id(), RISC=
V_ISA_EXT_ZICFILP));
> +}
> +
>  #endif
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 869da082252a..2dc4232bdb3e 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -100,6 +100,8 @@
>  #define RISCV_ISA_EXT_ZICCRSE          91
>  #define RISCV_ISA_EXT_SVADE            92
>  #define RISCV_ISA_EXT_SVADU            93
> +#define RISCV_ISA_EXT_ZICFILP          94
> +#define RISCV_ISA_EXT_ZICFISS          95
>
>  #define RISCV_ISA_EXT_XLINUXENVCFG     127
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index 5f56eb9d114a..e3aba3336e63 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -13,6 +13,7 @@
>  #include <vdso/processor.h>
>
>  #include <asm/ptrace.h>
> +#include <asm/hwcap.h>
>
>  #define arch_get_mmap_end(addr, len, flags)                    \
>  ({                                                             \
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index c6ba750536c3..82065cc55822 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -150,6 +150,15 @@ static int riscv_ext_svadu_validate(const struct ris=
cv_isa_ext_data *data,
>         return 0;
>  }
>
> +static int riscv_cfi_validate(const struct riscv_isa_ext_data *data,
> +                             const unsigned long *isa_bitmap)
> +{
> +       if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  static const unsigned int riscv_zk_bundled_exts[] =3D {
>         RISCV_ISA_EXT_ZBKB,
>         RISCV_ISA_EXT_ZBKC,
> @@ -333,6 +342,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D =
{
>         __RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, r=
iscv_xlinuxenvcfg_exts,
>                                           riscv_ext_zicboz_validate),
>         __RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
> +       __RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP,=
 riscv_xlinuxenvcfg_exts,
> +                                         riscv_cfi_validate),
> +       __RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfiss, RISCV_ISA_EXT_ZICFISS,=
 riscv_xlinuxenvcfg_exts,
> +                                         riscv_cfi_validate),
>         __RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>         __RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>         __RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
>

LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>

> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

