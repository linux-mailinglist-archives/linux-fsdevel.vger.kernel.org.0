Return-Path: <linux-fsdevel+bounces-29363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52602978907
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 21:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA3A285394
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB061487C5;
	Fri, 13 Sep 2024 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfnARFIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383C12FB0A;
	Fri, 13 Sep 2024 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256164; cv=none; b=UOGkN2yo1THla/N+qcNQNwwGc0H3loQFTUHgfUzpeK/1WodwmD7BJeFGJKUEJcLDQhv02p2Bpexkg/t/Dj7RFpbJbJwcOPLZ0qaRRieISYSrCkL3G52eUDYfzJJh0TJxL8lm31M48piz+RdGk/3KlVmem1ynhyeOw+dTWWW8nH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256164; c=relaxed/simple;
	bh=UdHQBWDMc71bE8Iy55dArrd3rCWm3VHJo00yp68l710=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HC+7sItT6v/mkekRbGkXsB6wDSOWawRMJ1PBpeB7STqvhMa/gQHq5ask2OTbn8v/W0lO6GRGthzhod2YKo4iy+SxPAuMOgW5UpBz7Vu7oFZmzkZ50YDf4W+goFj3f/P7Qax++lYqQmilduuorGPdVY+bhcEQCC7xq49BIop1ibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfnARFIH; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1a9dc3efc1so1455916276.2;
        Fri, 13 Sep 2024 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726256162; x=1726860962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3U+IHR6pDMRbfhHaDLoFAFxaYoo4zOVYQxFvK1iMreQ=;
        b=EfnARFIHcg+YhL+Q8aiMFlzxhgiKN3Cc/f0qBcwh99IumqFRWTDN9uWw9nIfUg0LHv
         Py6p/zmdrEo/aJuEalbxUqZGo2cU4Fdn278Sh8Xs5553tPUQ9ok+bYjxGttv6yogcQgq
         9BrtoX8DbsqclI4PoZJ/LGOGLiRD9ZxCEx5I7ZeZXfhjpqZvJMjEH2laurGYKtr9KWCx
         HUmQmn7Gh7vRS4RzBT3ildYVDOLylLL5QhM5ZYdyOw15LqnXWZIabTatfPju6R1ulJN3
         4pQFn3Todz7MHCxncAzcVF9WufMSNX9umnbGxGZJK28ny7T+kCiVkVOjUnjcfCpRowfU
         EulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726256162; x=1726860962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3U+IHR6pDMRbfhHaDLoFAFxaYoo4zOVYQxFvK1iMreQ=;
        b=tHVgwenVRZfN0Xxk2M85iR4ucR0NCLBwl21S2sSGBu7HAj0dB3F2JaW6J+NBUWydP4
         qzsU3c5AAuTgLpvhQzq+4cOJRCj0dOp6LvFsOREUb36b0Cc1xRfrPXyeY9MLziE6FB2r
         uTltXYPaOF4UIIb+W4QleVL3tAs6jExn6r9bLKKRLAu8PzPxuioPC0Y1QAxdIPg/85Zw
         Q4Z2A09Cu/gPJaiJjT1Va1JDBM6K6IGnVIDEwDDO6mTGhsoIfv4SCuYrNjINGIu3d0s3
         hn2gGtPR3rDkmzT3YVFMeWuGQWVGEl7TFlmy7WdWdeM07jmKqzsr4EoEs2/tgn7oAihT
         +DHg==
X-Forwarded-Encrypted: i=1; AJvYcCU1KfSzRJCaQqOAcuLaNjRU/3y/1TgARWy53Dbwoj17oBk93iwuTpFgNwrM7/8rzV58ZkmW6DZfIX733ykYl4Al@vger.kernel.org, AJvYcCU6iTHy6GB4N4uFsyhJsBbicpn60jF4str2BrnN/lGTb8y196rPMRw0xnSoCPbIk+XOb8pxHkYRzZII8XSBSQ==@vger.kernel.org, AJvYcCUXPc8lc3/TRXo7SZ1DUVGHwH/ZVTcesuS3yMUNe17u3+cPh4BFE+hkBPVGPfB1DKslpiMkBZuF7pMV62eW@vger.kernel.org, AJvYcCVFS/2tDU7FCSt1S2vYaAp8esAX57JAtXZ7w66Fdu6Y+E2vIlKFgQJCeUl6xPy9tj6pBuwG3gheID4Mog==@vger.kernel.org, AJvYcCW81wrYJkdYqIj2k9IolEkLDcHYdnGAkDYvbzAnyJKFmdYP5+M2Ucadp9b1YeTJprUtPiu4UgkRed5s@vger.kernel.org, AJvYcCW9nvZ956xzeYuD/h1qtg980ZQ73vDi4X2PNG6/hycSYeZb3fTkPVzj9EpAzRpEsNmHNJxFZpObQBXk@vger.kernel.org
X-Gm-Message-State: AOJu0YypdvwQIPGYoD1o2e5F4QioDOkvouiRIvVwDHesTgqThWBFGx0N
	F0kJ5PbN9ria22WQ16m0+9J+ohZaMi4X0kpZSDQMi2rE4RADQNw46aNGb3MRVk7njENXgbmNnv4
	CyaxXOgBdtbuVWLZpSa4h50sABIo=
X-Google-Smtp-Source: AGHT+IGt2176DfmuLWxLHRhUxP0ghtikgtAQtBs9a9ck/J1CfxjCxtNDV3zRVrMU5j3a8AABIjT1IH6bzLR1lWVcy+0=
X-Received: by 2002:a05:6902:15c7:b0:e1d:1dee:eeeb with SMTP id
 3f1490d57ef6-e1daff7cac4mr2967353276.22.1726256161483; Fri, 13 Sep 2024
 12:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912231650.3740732-1-debug@rivosinc.com> <20240912231650.3740732-22-debug@rivosinc.com>
In-Reply-To: <20240912231650.3740732-22-debug@rivosinc.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Fri, 13 Sep 2024 21:35:50 +0200
Message-ID: <CAFTtA3NA+OwZv5hJU3EWjuNHNjA3fQzPC+sX84Nb9YyJXdENSA@mail.gmail.com>
Subject: Re: [PATCH v4 21/30] riscv/traps: Introduce software check exception
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, palmer@sifive.com, conor@kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, quic_zhonhan@quicinc.com, zong.li@sifive.com, 
	zev@bewilderbeest.net, david@redhat.com, peterz@infradead.org, 
	catalin.marinas@arm.com, broonie@kernel.org, dave.hansen@linux.intel.com, 
	atishp@rivosinc.com, bjorn@rivosinc.com, namcaov@gmail.com, 
	usama.anjum@collabora.com, guoren@kernel.org, alx@kernel.org, 
	jszhang@kernel.org, hpa@zytor.com, puranjay@kernel.org, shuah@kernel.org, 
	sorear@fastmail.com, costa.shul@redhat.com, robh@kernel.org, 
	antonb@tenstorrent.com, quic_bjorande@quicinc.com, lorenzo.stoakes@oracle.com, 
	corbet@lwn.net, dawei.li@shingroup.cn, anup@brainfault.org, deller@gmx.de, 
	x86@kernel.org, andrii@kernel.org, willy@infradead.org, kees@kernel.org, 
	mingo@redhat.com, libang.li@antgroup.com, samitolvanen@google.com, 
	greentime.hu@sifive.com, osalvador@suse.de, ajones@ventanamicro.com, 
	revest@chromium.org, ancientmodern4@gmail.com, aou@eecs.berkeley.edu, 
	jerry.shih@sifive.com, alexghiti@rivosinc.com, arnd@arndb.de, 
	yang.lee@linux.alibaba.com, charlie@rivosinc.com, bgray@linux.ibm.com, 
	Liam.Howlett@oracle.com, leobras@redhat.com, songshuaishuai@tinylab.org, 
	xiao.w.wang@intel.com, bp@alien8.de, cuiyunhui@bytedance.com, 
	mchitale@ventanamicro.com, cleger@rivosinc.com, tglx@linutronix.de, 
	krzk+dt@kernel.org, vbabka@suse.cz, brauner@kernel.org, bhe@redhat.com, 
	ke.zhao@shingroup.cn, oleg@redhat.com, samuel.holland@sifive.com, 
	ben.dooks@codethink.co.uk, evan@rivosinc.com, palmer@dabbelt.com, 
	ebiederm@xmission.com, andy.chiu@sifive.com, schwab@suse.de, 
	akpm@linux-foundation.org, sameo@rivosinc.com, tanzhasanwork@gmail.com, 
	rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deepak

Deepak Gupta <debug@rivosinc.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=882:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> zicfiss / zicfilp introduces a new exception to priv isa `software check
> exception` with cause code =3D 18. This patch implements software check
> exception.
>
> Additionally it implements a cfi violation handler which checks for code
> in xtval. If xtval=3D2, it means that sw check exception happened because=
 of
> an indirect branch not landing on 4 byte aligned PC or not landing on
> `lpad` instruction or label value embedded in `lpad` not matching label
> value setup in `x7`. If xtval=3D3, it means that sw check exception happe=
ned
> because of mismatch between link register (x1 or x5) and top of shadow
> stack (on execution of `sspopchk`).
>
> In case of cfi violation, SIGSEGV is raised with code=3DSEGV_CPERR.
> SEGV_CPERR was introduced by x86 shadow stack patches.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/asm-prototypes.h |  1 +
>  arch/riscv/include/asm/entry-common.h   |  2 ++
>  arch/riscv/kernel/entry.S               |  3 ++
>  arch/riscv/kernel/traps.c               | 38 +++++++++++++++++++++++++
>  4 files changed, 44 insertions(+)
>
> diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include=
/asm/asm-prototypes.h
> index cd627ec289f1..5a27cefd7805 100644
> --- a/arch/riscv/include/asm/asm-prototypes.h
> +++ b/arch/riscv/include/asm/asm-prototypes.h
> @@ -51,6 +51,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
>  DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
>  DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
>  DECLARE_DO_ERROR_INFO(do_trap_break);
> +DECLARE_DO_ERROR_INFO(do_trap_software_check);
>
>  asmlinkage void handle_bad_stack(struct pt_regs *regs);
>  asmlinkage void do_page_fault(struct pt_regs *regs);
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/a=
sm/entry-common.h
> index 2293e535f865..4068c7e5452a 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -39,4 +39,6 @@ static inline int handle_misaligned_store(struct pt_reg=
s *regs)
>  }
>  #endif
>
> +bool handle_user_cfi_violation(struct pt_regs *regs);
> +
>  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index ca9203e6d76d..2ec75ba864a8 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -384,6 +384,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
>         RISCV_PTR do_page_fault   /* load page fault */
>         RISCV_PTR do_trap_unknown
>         RISCV_PTR do_page_fault   /* store page fault */
> +       RISCV_PTR do_trap_unknown /* cause=3D16 */
> +       RISCV_PTR do_trap_unknown /* cause=3D17 */
> +       RISCV_PTR do_trap_software_check /* cause=3D18 is sw check except=
ion */
>  SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
>
>  #ifndef CONFIG_MMU
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 51ebfd23e007..32d1453bed72 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -354,6 +354,44 @@ void do_trap_ecall_u(struct pt_regs *regs)
>
>  }
>
> +#define CFI_TVAL_FCFI_CODE     2
> +#define CFI_TVAL_BCFI_CODE     3
> +/* handle cfi violations */
> +bool handle_user_cfi_violation(struct pt_regs *regs)
> +{
> +       bool ret =3D false;
> +       unsigned long tval =3D csr_read(CSR_TVAL);
> +
> +       if (((tval =3D=3D CFI_TVAL_FCFI_CODE) && cpu_supports_indirect_br=
_lp_instr()) ||
> +               ((tval =3D=3D CFI_TVAL_BCFI_CODE) && cpu_supports_shadow_=
stack())) {
> +               do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
> +                                         "Oops - control flow violation"=
);
> +               ret =3D true;
> +       }
> +
> +       return ret;
> +}
> +/*
> + * software check exception is defined with risc-v cfi spec. Software ch=
eck
> + * exception is raised when:-
> + * a) An indirect branch doesn't land on 4 byte aligned PC or `lpad`
> + *    instruction or `label` value programmed in `lpad` instr doesn't
> + *    match with value setup in `x7`. reported code in `xtval` is 2.
> + * b) `sspopchk` instruction finds a mismatch between top of shadow stac=
k (ssp)
> + *    and x1/x5. reported code in `xtval` is 3.
> + */

It seems like this trap handler does not follow generic entry. This
can cause problems as signal delivery is done in
irqentry_exit_to_user_mode(). Please reference the commit f0bddf50586d
("riscv: entry: Convert to generic entry") for more information.

> +asmlinkage __visible __trap_section void do_trap_software_check(struct p=
t_regs *regs)
> +{
> +       if (user_mode(regs)) {
> +               /* not a cfi violation, then merge into flow of unknown t=
rap handler */
> +               if (!handle_user_cfi_violation(regs))
> +                       do_trap_unknown(regs);
> +       } else {
> +               /* sw check exception coming from kernel is a bug in kern=
el */
> +               die(regs, "Kernel BUG");
> +       }
> +}
> +
>  #ifdef CONFIG_MMU
>  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>  {
> --
> 2.45.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Cheers,
Andy

