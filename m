Return-Path: <linux-fsdevel+bounces-52341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95925AE2101
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 19:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144464A362C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5654F28ECEA;
	Fri, 20 Jun 2025 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sbXO9h/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6585F2253FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750440800; cv=none; b=A1S02qWU4ErYzpTSLEt861cZJaflDtNYtReDoePqPclLCjmUILpoSdUHkgKKQC7M+DHHLDhTG4Z0TMLmGREp2+cWzjMzbltZRjhmQPI2uL7fLFd68xkBbJHS7rsPktAx7noEbyNu0xiryDgGXjteWKDJYVIsZSueL2s3oOt2FJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750440800; c=relaxed/simple;
	bh=lf3rt/J5Q2TSc3Spn1FYOaKS+rgsq15oINCH4ECAlI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rv1Smk+aJOOkd7kbY8CLO/oQQglnoZTpLz4Fx+BrITJKG/nNRAWlwVvB0P9j/HSc7iEWY3Air+kaygBq3U8iEdUjOhj1zQNF0oeHcf8bruoK1+fV/LOjdom4/Q4YwkCnS3Ssq9YpUAKqL2bg5amLhZ8Yz9jgZxPhgWTRUCpXrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sbXO9h/h; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e3e0415a7so19836657b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1750440796; x=1751045596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2abC0SFXgIr7+KzY0H72u6hUC8EwRyPuKIwDFbrFdvA=;
        b=sbXO9h/hiAXmk4XFcOY2XU0c9Mk7nxYXsgNEvYm2HrVOxYi1Hep7MrDaTsoFHlYr6i
         Gei/wtQVmpSGm4PAUU/ewYPL9Pnbp/hE1V4druBXDnbJPCS0QqcLbWoPh60yxTEk1dbP
         gvSOYMgpwy8WRa7oiV72urdSEeaqdMUUcBh4ZUOCQrphSS0aM/+3UO67dcvNPgJloRxj
         Mth7rJbXdjfxrfXErKDtIQG2xSU7EJ0OvCMnCx8POkB7LOOign5A5KpC7Ks/BLVKxHZI
         xy7Oe9mkaQRNtXADj0j1pUbjDhRa4Uh9d5Cjt9SmjyO8d+aVygkEMda2Osmka44QxdBF
         Aimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750440796; x=1751045596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2abC0SFXgIr7+KzY0H72u6hUC8EwRyPuKIwDFbrFdvA=;
        b=UMfnfBttp+8lHskEAb3hOGOW4kMJn/1vHiEgpn4k4uFE+OZjgFjMjRfGji1Dt5o6h9
         SMlMgq4w1Rl3CaerHNN7hGrYPTBduwIJdtZIZPnFuVki9ZZDji5QmAPNzbFv1nT5IVsb
         mJSmM7aCGPYhIqYSCllqsvoPs/3GcEVbeaMmHYHseFLcscExycxRAkIJzkIetL14AZtT
         acEXCZ6XkymL5LXxe3B7RTrO5hmhflE00NQBegPe8BUg2XVCz/gU9UqV1N7+MPVn7HXc
         C75oMNvD85T8d2Z9hW4Q1c0HLXRxuOsVSF9KFYQ3rNy3/reKwrwuJF+FXnR8hCvKZLe8
         cZlA==
X-Forwarded-Encrypted: i=1; AJvYcCXYC4vov750jN9lXsELpwTQi3Dz7UQnyJk8Ut3Jv55jRrPZPP2N2t2Gdc/cYSuSFEWFmRgqsjLnyQymdrlT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42z0efE9SZseZdyxubBRgBgxNePqGMf+EvBVz9Igl1VEPxX/9
	/HQozWsDHgKzBVrL02cXSj9DK6zFsSBEKxtWzjUnykrp4LBH1Wl37BqLgEEGIMysmI1x71VVC2c
	5p8Do/+yMTIUIltHbilMOPMaEw+dlIyckMcbtaFyKCA==
X-Gm-Gg: ASbGnctMgMxEyEQOSlzXvj5Dwbp4w2jRsAiCMlovjsJDM1RwCOJC299cPKgdwulV/lK
	R7ZqvbhVgMiq0VqG/nkNmlogZjGtf663itsU6UD0albQMrlFHHFHsZFl6j+0YvXH9K7iub8oGMA
	sz6TxMrfeLHNyXSHs9G53wYdRGOsdTXUSFbulMqeqLyBnZ
X-Google-Smtp-Source: AGHT+IEkgLARqA2KXW+VjQvrt/iHwV+xr0H31M/s+eB4pqd94Voek7Ap4g7bsttqbn0aTqp01MS+cbE/e4BYHevU73o=
X-Received: by 2002:a05:690c:931c:10b0:712:c5f7:1ee9 with SMTP id
 00721157ae682-712ca34ede8mr29381827b3.8.1750440796260; Fri, 20 Jun 2025
 10:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
 <20250604-v5_user_cfi_series-v17-15-4565c2cf869f@rivosinc.com>
 <CANXhq0pRXX_OMW2g2ui-k7Z_ZT+5a8Sra8oE28nBh5B9K2L5bQ@mail.gmail.com> <CANXhq0p3MVLMsr_r0RWMti476pT0EMx61PQArjo2fUauTdpXaQ@mail.gmail.com>
In-Reply-To: <CANXhq0p3MVLMsr_r0RWMti476pT0EMx61PQArjo2fUauTdpXaQ@mail.gmail.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 20 Jun 2025 10:33:05 -0700
X-Gm-Features: Ac12FXwTNfjkf9IENg9kQWer4J0SFv3v73bubAYv2TNOJ9tzM24JcaWhs9j55A8
Message-ID: <CAKC1njRNatM6bj7+bCbMcwv7UoEfKSTQTGOnFSxuGLoephw0+A@mail.gmail.com>
Subject: Re: [PATCH v17 15/27] riscv/traps: Introduce software check exception
 and uprobe handling
To: Zong Li <zong.li@sifive.com>
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

On Thu, Jun 19, 2025 at 7:16=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Jun 16, 2025 at 3:31=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > On Thu, Jun 5, 2025 at 1:17=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> > >
> > > zicfiss / zicfilp introduces a new exception to priv isa `software ch=
eck
> > > exception` with cause code =3D 18. This patch implements software che=
ck
> > > exception.
> > >
> > > Additionally it implements a cfi violation handler which checks for c=
ode
> > > in xtval. If xtval=3D2, it means that sw check exception happened bec=
ause of
> > > an indirect branch not landing on 4 byte aligned PC or not landing on
> > > `lpad` instruction or label value embedded in `lpad` not matching lab=
el
> > > value setup in `x7`. If xtval=3D3, it means that sw check exception h=
appened
> > > because of mismatch between link register (x1 or x5) and top of shado=
w
> > > stack (on execution of `sspopchk`).
> > >
> > > In case of cfi violation, SIGSEGV is raised with code=3DSEGV_CPERR.
> > > SEGV_CPERR was introduced by x86 shadow stack patches.
> > >
> > > To keep uprobes working, handle the uprobe event first before reporti=
ng
> > > the CFI violation in software-check exception handler. Because when t=
he
> > > landing pad is activated, if the uprobe point is set at the lpad
> > > instruction at the beginning of a function, the system triggers a sof=
tware
> > > -check exception instead of an ebreak exception due to the exception
> > > priority, then uprobe can't work successfully.
> > >
> > > Co-developed-by: Zong Li <zong.li@sifive.com>
> > > Reviewed-by: Zong Li <zong.li@sifive.com>
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/asm-prototypes.h |  1 +
> > >  arch/riscv/include/asm/entry-common.h   |  2 ++
> > >  arch/riscv/kernel/entry.S               |  3 ++
> > >  arch/riscv/kernel/traps.c               | 51 +++++++++++++++++++++++=
++++++++++
> > >  4 files changed, 57 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/inc=
lude/asm/asm-prototypes.h
> > > index cd627ec289f1..5a27cefd7805 100644
> > > --- a/arch/riscv/include/asm/asm-prototypes.h
> > > +++ b/arch/riscv/include/asm/asm-prototypes.h
> > > @@ -51,6 +51,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
> > >  DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
> > >  DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
> > >  DECLARE_DO_ERROR_INFO(do_trap_break);
> > > +DECLARE_DO_ERROR_INFO(do_trap_software_check);
> > >
> > >  asmlinkage void handle_bad_stack(struct pt_regs *regs);
> > >  asmlinkage void do_page_fault(struct pt_regs *regs);
> > > diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/inclu=
de/asm/entry-common.h
> > > index b28ccc6cdeea..34ed149af5d1 100644
> > > --- a/arch/riscv/include/asm/entry-common.h
> > > +++ b/arch/riscv/include/asm/entry-common.h
> > > @@ -40,4 +40,6 @@ static inline int handle_misaligned_store(struct pt=
_regs *regs)
> > >  }
> > >  #endif
> > >
> > > +bool handle_user_cfi_violation(struct pt_regs *regs);
> > > +
> > >  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > > index 978115567bca..8d25837a9384 100644
> > > --- a/arch/riscv/kernel/entry.S
> > > +++ b/arch/riscv/kernel/entry.S
> > > @@ -474,6 +474,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
> > >         RISCV_PTR do_page_fault   /* load page fault */
> > >         RISCV_PTR do_trap_unknown
> > >         RISCV_PTR do_page_fault   /* store page fault */
> > > +       RISCV_PTR do_trap_unknown /* cause=3D16 */
> > > +       RISCV_PTR do_trap_unknown /* cause=3D17 */
> > > +       RISCV_PTR do_trap_software_check /* cause=3D18 is sw check ex=
ception */
> > >  SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end=
)
> > >
> > >  #ifndef CONFIG_MMU
> > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > > index 8ff8e8b36524..64388370e1ad 100644
> > > --- a/arch/riscv/kernel/traps.c
> > > +++ b/arch/riscv/kernel/traps.c
> > > @@ -354,6 +354,57 @@ void do_trap_ecall_u(struct pt_regs *regs)
> > >
> > >  }
> > >
> > > +#define CFI_TVAL_FCFI_CODE     2
> > > +#define CFI_TVAL_BCFI_CODE     3
> > > +/* handle cfi violations */
> > > +bool handle_user_cfi_violation(struct pt_regs *regs)
> > > +{
> > > +       unsigned long tval =3D csr_read(CSR_TVAL);
> > > +       bool is_fcfi =3D (tval =3D=3D CFI_TVAL_FCFI_CODE && cpu_suppo=
rts_indirect_br_lp_instr());
> > > +       bool is_bcfi =3D (tval =3D=3D CFI_TVAL_BCFI_CODE && cpu_suppo=
rts_shadow_stack());
> > > +
> > > +       /*
> > > +        * Handle uprobe event first. The probe point can be a valid =
target
> > > +        * of indirect jumps or calls, in this case, forward cfi viol=
ation
> > > +        * will be triggered instead of breakpoint exception.
> > > +        */
> > > +       if (is_fcfi && probe_breakpoint_handler(regs))
> > > +               return true;
> >
> > Hi  Deepak,
> > Sorry for missing something earlier. I think we would like to clear
> > sstatus.SPELP in the uprobe handling case. For example:
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index c2ea999c1167..e8492bb57e09 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -349,8 +349,10 @@ bool handle_user_cfi_violation(struct pt_regs *reg=
s)
> >         bool is_fcfi =3D (tval =3D=3D CFI_TVAL_FCFI_CODE &&
> > cpu_supports_indirect_br_lp_instr());
> >         bool is_bcfi =3D (tval =3D=3D CFI_TVAL_BCFI_CODE &&
> > cpu_supports_shadow_stack());
> >
> > -       if (is_fcfi && probe_breakpoint_handler(regs))
> > +       if (is_fcfi && probe_breakpoint_handler(regs)) {
> > +               regs->status =3D regs->status & ~SR_ELP;
> >                 return true;
> > +       }

Make sense. I'll pick it up in the next version. Thanks.

> >
> >         if (is_fcfi || is_bcfi) {
> >                 do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
> >
> >
> > When a user mode CFI violation occurs, the ELP state should be 1, and
> > the system traps into supervisor mode. During this trap, sstatus.SPELP
> > is set to 1, and the ELP state is reset to 0. If we don=E2=80=99t clear
> > sstatus.SPELP, the ELP state will become 1 again after executing the
> > sret instruction. As a result, the system might trigger another
> > forward CFI violation upon executing the next instruction in the user
> > program, unless it happens to be a lpad instruction.
> >
> > The previous patch was tested on QEMU, but QEMU does not set the
> > sstatus.SPELP bit to 1 when a forward CFI violation occurs. Therefore,
> > I suspect that QEMU might also require some fixes.
>
> Hi Deepak,
> The issue with QEMU was that the sw-check exception bit in medeleg
> couldn't be set. This has been fixed in the latest QEMU mainline. I
> have re-tested the latest QEMU version, and it works.

Thanks for the fix.

>
> >
> > Thanks
> >
> > > +
> > > +       if (is_fcfi || is_bcfi) {
> > > +               do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
> > > +                             "Oops - control flow violation");
> > > +               return true;
> > > +       }
> > > +
> > > +       return false;
> > > +}
> > > +
> > > +/*
> > > + * software check exception is defined with risc-v cfi spec. Softwar=
e check
> > > + * exception is raised when:-
> > > + * a) An indirect branch doesn't land on 4 byte aligned PC or `lpad`
> > > + *    instruction or `label` value programmed in `lpad` instr doesn'=
t
> > > + *    match with value setup in `x7`. reported code in `xtval` is 2.
> > > + * b) `sspopchk` instruction finds a mismatch between top of shadow =
stack (ssp)
> > > + *    and x1/x5. reported code in `xtval` is 3.
> > > + */
> > > +asmlinkage __visible __trap_section void do_trap_software_check(stru=
ct pt_regs *regs)
> > > +{
> > > +       if (user_mode(regs)) {
> > > +               irqentry_enter_from_user_mode(regs);
> > > +
> > > +               /* not a cfi violation, then merge into flow of unkno=
wn trap handler */
> > > +               if (!handle_user_cfi_violation(regs))
> > > +                       do_trap_unknown(regs);
> > > +
> > > +               irqentry_exit_to_user_mode(regs);
> > > +       } else {
> > > +               /* sw check exception coming from kernel is a bug in =
kernel */
> > > +               die(regs, "Kernel BUG");
> > > +       }
> > > +}
> > > +
> > >  #ifdef CONFIG_MMU
> > >  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs=
)
> > >  {
> > >
> > > --
> > > 2.43.0
> > >

