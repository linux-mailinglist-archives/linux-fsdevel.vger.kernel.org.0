Return-Path: <linux-fsdevel+bounces-55072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E87B06B9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 04:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DE07B3244
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2475D272811;
	Wed, 16 Jul 2025 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DSjdlGhS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1FD265288
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631604; cv=none; b=qSAzqX1Ke7nIqrijkLKeZpYvrB+PE6vyFbyymhKSvt2yHtKlrkRo+a8BeiAt5o3UXE86vxXmfpvreHeAtc1IPSZ6Z3t3UYZPnis2hBBzBdIOGYZ/l1a8G6iSbLiBwLIyefmQ0Ay5s63R8TG3L5tb6am2V+sHdZ2rcAx3VagqvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631604; c=relaxed/simple;
	bh=TPISs9NBFDN53Y3aUroY0WGCUZDIWplP0R+8uYAH4bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQPh9ZIWxfKCwbdnFAygDRZLSkBFOxXvXXkB2j7OiH+/EzTyfEWah+6C9iUFM2OIRujHZRzTwuhV1BfKsQZTjV1es5Z06yU2nblYzTNHscY48LGs8n80wQA4XP4a7G6ljEXwATVGEpsoGT5kk50brm4YKAm8yE8UiZfMIJIQbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DSjdlGhS; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3df30d542caso26927295ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 19:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1752631601; x=1753236401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j+F9L1888D1/lTB0yjly7TVvzjMYjvETcZUaJXOGrM=;
        b=DSjdlGhSODTU8fT6Aw9TLtMH3N/iEdSvZKxeVopfidb1K6wf7w5EDQ9Ap3T3hXmmm3
         dbqTd+uHD6nWju+4hClirXyxT7tqwI1ClajTD27h2T+M20IeDnCBeUhVFFckars8M4Te
         0tyqlNrmqeFfY//U9hCdO1XKgFiZurvto1vcWpZNHJFyoOwzcuGTn3aA3Pg4q+ioYjea
         QaGfk09z9+T3438UoawbjtztZvyh8QXV+peewcAhO5zZyUQqPmyFm2ar2wVep5OrtEGB
         GIMv1tx/LjrNBhHkjj1FMJFbD9C7zVsllD0sUJNs4zVrAS8X21N0MXCyaXGODKcnluG2
         sv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752631601; x=1753236401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j+F9L1888D1/lTB0yjly7TVvzjMYjvETcZUaJXOGrM=;
        b=IENCOg31nEdyo1VJuzQIrNVhMwbPoKvLgXUwFEkMImKWmurPx0zn7oPbsXpb66rjTR
         ETSlx8D3aC6inYm22V2IcHZGimg+WR3j/PeeL4+LqcmKI+gSfguUv40xGgzBGH7elSYt
         BBKyYo69j7FgyC7ILVj539mCuIYxOJBSz2VyfVwVXW2XMMa22kxEtvEWkCNPzxU8qdDZ
         j+eCo+yXenz+EH6ndyLtI4lJUFx+2l8NiBh0NCiyjDbdHB+Xw7RQisdLRjhPWFxICj3A
         XKx54Lf4jdB4wUCaWgPw+3RSWw1YGrgp/j4aHNn6MYAsA3V3/aRlBvf+vuCEh1wb9wC0
         zq6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9vV6ivEhClTxntH4+rTnJ2aXMYcfMh/oW5MV20Wyix5+XfcC0mQOmontHSSIhqFz+f8Rzz4epxlCefVnV@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpXNIZM2ZVcsSaj9cA9Rm8ubEnqxQjrDjRc3UEHy+2r+j8X23
	MZmTc62cHj6NvTjC5Fk9VpHxHNekTkDDkYehqQAO1qjQkHcEkTHfT578pCPQYeNHBoj6MSmI6tQ
	SB2UGvKB/ZvIGDOlHSaDFNSwp4KpygAhDexjLdHg3dQ==
X-Gm-Gg: ASbGnctN/GDrzo+HL/qaVpSpFK676Jq6v6K2TF0z+pAuMOFf6GbJ9Qh+Ylgjg5cP/6I
	eGn5jovqKeH4ZJR3KgdRhgPdKWgMKbvvpyXDqayx7C1AB46LDprJ2lYunzVgKwEOwsYqjWZ3/xt
	bxKzR+eTpV1BgLYZUcMxAtd7k0EmHzvMv3qvZPffBu1H5tTJIgOTGhuroIraBt0PntKxvP/fys5
	2+coHhLJ4eR9oaATsgi
X-Google-Smtp-Source: AGHT+IH9/HXYsLu/DJVcgXHmyW23optDc6uoRoN2rcWn2HHkb7B7VzOcj2uDSKGa9qQvekhhenVwxhU+VuPhiZoGO+E=
X-Received: by 2002:a05:6e02:1aa3:b0:3df:3886:ad6e with SMTP id
 e9e14a558f8ab-3e282e65b61mr10740485ab.12.1752631601151; Tue, 15 Jul 2025
 19:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
 <20250604-v5_user_cfi_series-v17-15-4565c2cf869f@rivosinc.com>
 <CANXhq0pRXX_OMW2g2ui-k7Z_ZT+5a8Sra8oE28nBh5B9K2L5bQ@mail.gmail.com>
 <CANXhq0p3MVLMsr_r0RWMti476pT0EMx61PQArjo2fUauTdpXaQ@mail.gmail.com> <CAKC1njRNkSfb_0pUQoH0RwJQhWTsz9sdg_3o08w-NuSO5WypcA@mail.gmail.com>
In-Reply-To: <CAKC1njRNkSfb_0pUQoH0RwJQhWTsz9sdg_3o08w-NuSO5WypcA@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 16 Jul 2025 10:06:28 +0800
X-Gm-Features: Ac12FXxQabhbT3gOiwtrnSWdGCnuEDBYfeHbjfUOFZRTxM5oaqlSklQMtx6WBCk
Message-ID: <CANXhq0oZz=TTT=py=1BO3OZf45Wg=-bFyNpn+JRLNufHceLjcQ@mail.gmail.com>
Subject: Re: [PATCH v17 15/27] riscv/traps: Introduce software check exception
 and uprobe handling
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

On Wed, Jul 16, 2025 at 5:34=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Hi Zong,
>
>
> On Thu, Jun 19, 2025 at 7:16=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > On Mon, Jun 16, 2025 at 3:31=E2=80=AFPM Zong Li <zong.li@sifive.com> wr=
ote:
> > >
> > > On Thu, Jun 5, 2025 at 1:17=E2=80=AFAM Deepak Gupta <debug@rivosinc.c=
om> wrote:
> > > >
> > > > zicfiss / zicfilp introduces a new exception to priv isa `software =
check
> > > > exception` with cause code =3D 18. This patch implements software c=
heck
> > > > exception.
> > > >
> .....
>
> > > When a user mode CFI violation occurs, the ELP state should be 1, and
> > > the system traps into supervisor mode. During this trap, sstatus.SPEL=
P
> > > is set to 1, and the ELP state is reset to 0. If we don=E2=80=99t cle=
ar
> > > sstatus.SPELP, the ELP state will become 1 again after executing the
> > > sret instruction. As a result, the system might trigger another
> > > forward CFI violation upon executing the next instruction in the user
> > > program, unless it happens to be a lpad instruction.
> > >
> > > The previous patch was tested on QEMU, but QEMU does not set the
> > > sstatus.SPELP bit to 1 when a forward CFI violation occurs. Therefore=
,
> > > I suspect that QEMU might also require some fixes.
> >
> > Hi Deepak,
> > The issue with QEMU was that the sw-check exception bit in medeleg
> > couldn't be set. This has been fixed in the latest QEMU mainline. I
> > have re-tested the latest QEMU version, and it works.
>
> What was this issue, can you point me to the patch in mainline?

Hi Deepak
The issue was that my QEMU setup somehow missed the change of
`target/riscv/csr.c` in your following patch:
https://github.com/qemu/qemu/commit/6031102401ae8a69a87b20fbec2aae666625d96=
a
After I upgraded to the latest QEMU source, I found the kernel issue
if we didn't clear sstatus.SPELP in the handler
Thanks

>
> >
> > >
> > > Thanks
> > >
> > > > +
> > > > +       if (is_fcfi || is_bcfi) {
> > > > +               do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
> > > > +                             "Oops - control flow violation");
> > > > +               return true;
> > > > +       }
> > > > +
> > > > +       return false;
> > > > +}
> > > > +
> > > > +/*
> > > > + * software check exception is defined with risc-v cfi spec. Softw=
are check
> > > > + * exception is raised when:-
> > > > + * a) An indirect branch doesn't land on 4 byte aligned PC or `lpa=
d`
> > > > + *    instruction or `label` value programmed in `lpad` instr does=
n't
> > > > + *    match with value setup in `x7`. reported code in `xtval` is =
2.
> > > > + * b) `sspopchk` instruction finds a mismatch between top of shado=
w stack (ssp)
> > > > + *    and x1/x5. reported code in `xtval` is 3.
> > > > + */
> > > > +asmlinkage __visible __trap_section void do_trap_software_check(st=
ruct pt_regs *regs)
> > > > +{
> > > > +       if (user_mode(regs)) {
> > > > +               irqentry_enter_from_user_mode(regs);
> > > > +
> > > > +               /* not a cfi violation, then merge into flow of unk=
nown trap handler */
> > > > +               if (!handle_user_cfi_violation(regs))
> > > > +                       do_trap_unknown(regs);
> > > > +
> > > > +               irqentry_exit_to_user_mode(regs);
> > > > +       } else {
> > > > +               /* sw check exception coming from kernel is a bug i=
n kernel */
> > > > +               die(regs, "Kernel BUG");
> > > > +       }
> > > > +}
> > > > +
> > > >  #ifdef CONFIG_MMU
> > > >  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *re=
gs)
> > > >  {
> > > >
> > > > --
> > > > 2.43.0
> > > >

