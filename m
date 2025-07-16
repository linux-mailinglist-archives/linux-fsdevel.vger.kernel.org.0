Return-Path: <linux-fsdevel+bounces-55108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0574B06EFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDCF4E55F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A1528C01C;
	Wed, 16 Jul 2025 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="misSRJfn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5128BA9A
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651226; cv=none; b=BFCxPuuy9/pPeiQUTjmXVZiPXjwYMfZRypXbaTfSEmydIC7Uu8Zzq5pb3WVTCMg0TTrOyt2bWGAHcax7PCBTKzqA8TRg65APQ8cJwzkc5n7270OiDw58mKF5XpvSdexHHtAu0nzfwODLDQjGs8Zb9j64G3xnlrJLEenIyx4q5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651226; c=relaxed/simple;
	bh=J1fmkXzQhdy/B2HqE648pLqXswaIxo5hZ2X+m0elNBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tk8f9j4ctwXVRcO1eUBbEWlsRrBeU3uxacM7WivX97KZ/N+TV3l9BGQHh8X09LcOWDb7h2pXaK8Tis+zfn75SPeRvH8EImvc3IWZFfdS7X9jk4vFuBIn1iclwS3DgaMuOp/pvKzRetqWZcinFEEjMq9datJ3VuKufaWj794EBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=misSRJfn; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e740a09eae0so6326674276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752651224; x=1753256024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PW8oj8yyNVG5XPISXOtfA3n2P3zOnfj4By+Eha4u0hU=;
        b=misSRJfnE5w/pnaSiy1gvtx4w/fzsVlLI5ffuKbQa4C0hghm6aCyOH+Njhh0zrWR6V
         5Qad0PQGyyfcE6wSPlkg4UNmwMzUU81aYaqyX6mLGRalwxRDBBtxAaWE4ngJLO4tJ/P2
         Irl1oQ/q+xBDhXzGRfv2gzsTGtPKG5/oD+95gNnxODzG2IfLKoZxYW0iS5p7KeTEpSI7
         cwi8hB0jW7kFj+C3OpAB74HroXqQiFRiT7pkDEXPsKYw6S8qHq/KWtOB0l8ybcjOjm0d
         RVY5ljL2drR54iTwW5Ts6z+NiAP3DcrwRjJ1iO5hxNZGHHXjt7r2gKbCCWBwtlT2RG1X
         ea2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752651224; x=1753256024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PW8oj8yyNVG5XPISXOtfA3n2P3zOnfj4By+Eha4u0hU=;
        b=P9ebPZazYMyxJWsnkqBkiwnz5pwT7hDRiOh9jwSYJK+cfHVJjO67aiHNF3vCm/vYVm
         RG/RFt60gUpasgBzgRHcVbxf0R5e+eK+OWyVkYzdv0bU0HwIzmwH3Tn0HqIo/NZ6Z5AX
         2i3wrYHPfwnqMY3wrvDfwc5OA6wReoX+be1wYoCqOibOCJukNr4QpKP0QKtV++L6qOt5
         R8M/97zlriUx9ghSpFnVx+1aqY3BnS6XJcHlSN4XpYm2G1jEFFPklCFZmrdj6V0WHOuK
         VXsCgBZJp6yfsm4ebIpgfuIR6JAEFI6W6Mwi1cGLIFw1BxvlBQZ/xexBMkYoBNTiKoT4
         SjWg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Ypz8Z0r3WKJffbledZhCn6TkFFm6q4byIexDrlvqO5f57thcqMiOwg3fbcG4JzaYk6YdS1a56WFCqjLP@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfyqNw//oAhEYHJ64f0szeG4Pd7mckML5i9Y5CfulVhiLzqxw
	uWASjWKLWEzSoANUsd+dGEn8UTUQlfu+qfOSihYzabIKQMsek46x/vg2FhbGpx/BB9ef8eTUP7N
	+6RqrX7gYoOK0d3aGBr1ka9xt5Cvj4//HDcXUVLp2OA==
X-Gm-Gg: ASbGnctadCakvoEDxAI1cOMYlYA9TXdn81YJuRZCbguE+R1rA3b5qg8PGc8ZjZrQ/qF
	0mdAFw9TXLvCUiTWqhqFaVi50nLS1C7cB2M09IJZ7/jwkCkVNSq8+cCQoEFIJdLkhJ3YG35Knn3
	4ly3hdYsziovUK/mZzXUjZcZvhaj5aAA9GOY+S9vxkpyiMf3/nPytIvtITchIC1Fu6lBo0j5QIk
	OXyWusf
X-Google-Smtp-Source: AGHT+IEBFim0sebTg/GJVvyxJNrliMi5B8Z1CirXQugUtw/MAG7MtHjoXp3XBPYhkfJvHfUUj+zVmynVQDiKVlguiXc=
X-Received: by 2002:a05:690c:6d0b:b0:6fb:b1dd:a00d with SMTP id
 00721157ae682-7183516330bmr29836477b3.30.1752651223909; Wed, 16 Jul 2025
 00:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
 <20250604-v5_user_cfi_series-v17-15-4565c2cf869f@rivosinc.com>
 <CANXhq0pRXX_OMW2g2ui-k7Z_ZT+5a8Sra8oE28nBh5B9K2L5bQ@mail.gmail.com>
 <CANXhq0p3MVLMsr_r0RWMti476pT0EMx61PQArjo2fUauTdpXaQ@mail.gmail.com>
 <CAKC1njRNkSfb_0pUQoH0RwJQhWTsz9sdg_3o08w-NuSO5WypcA@mail.gmail.com> <CANXhq0oZz=TTT=py=1BO3OZf45Wg=-bFyNpn+JRLNufHceLjcQ@mail.gmail.com>
In-Reply-To: <CANXhq0oZz=TTT=py=1BO3OZf45Wg=-bFyNpn+JRLNufHceLjcQ@mail.gmail.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 16 Jul 2025 00:33:29 -0700
X-Gm-Features: Ac12FXyXP37ODEjfHSjK8_gGHbTe6nbCLu3r93joGlrq46qsQaqRghNBDnEKWgk
Message-ID: <CAKC1njRqox8_YNEhQJT8NRMjGuqpDt55ck6QVV2aNPLwTsaj5w@mail.gmail.com>
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

On Tue, Jul 15, 2025 at 7:06=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Wed, Jul 16, 2025 at 5:34=E2=80=AFAM Deepak Gupta <debug@rivosinc.com>=
 wrote:
> >
> > Hi Zong,
> >
> >
> > On Thu, Jun 19, 2025 at 7:16=E2=80=AFPM Zong Li <zong.li@sifive.com> wr=
ote:
> > >
> > > On Mon, Jun 16, 2025 at 3:31=E2=80=AFPM Zong Li <zong.li@sifive.com> =
wrote:
> > > >
> > > > On Thu, Jun 5, 2025 at 1:17=E2=80=AFAM Deepak Gupta <debug@rivosinc=
.com> wrote:
> > > > >
> > > > > zicfiss / zicfilp introduces a new exception to priv isa `softwar=
e check
> > > > > exception` with cause code =3D 18. This patch implements software=
 check
> > > > > exception.
> > > > >
> > .....
> >
> > > > When a user mode CFI violation occurs, the ELP state should be 1, a=
nd
> > > > the system traps into supervisor mode. During this trap, sstatus.SP=
ELP
> > > > is set to 1, and the ELP state is reset to 0. If we don=E2=80=99t c=
lear
> > > > sstatus.SPELP, the ELP state will become 1 again after executing th=
e
> > > > sret instruction. As a result, the system might trigger another
> > > > forward CFI violation upon executing the next instruction in the us=
er
> > > > program, unless it happens to be a lpad instruction.
> > > >
> > > > The previous patch was tested on QEMU, but QEMU does not set the
> > > > sstatus.SPELP bit to 1 when a forward CFI violation occurs. Therefo=
re,
> > > > I suspect that QEMU might also require some fixes.
> > >
> > > Hi Deepak,
> > > The issue with QEMU was that the sw-check exception bit in medeleg
> > > couldn't be set. This has been fixed in the latest QEMU mainline. I
> > > have re-tested the latest QEMU version, and it works.
> >
> > What was this issue, can you point me to the patch in mainline?
>
> Hi Deepak
> The issue was that my QEMU setup somehow missed the change of
> `target/riscv/csr.c` in your following patch:
> https://github.com/qemu/qemu/commit/6031102401ae8a69a87b20fbec2aae666625d=
96a
> After I upgraded to the latest QEMU source, I found the kernel issue
> if we didn't clear sstatus.SPELP in the handler
> Thanks

Aah ok, got it.

>
> >
> > >
> > > >
> > > > Thanks
> > > >
> > > > > +
> > > > > +       if (is_fcfi || is_bcfi) {
> > > > > +               do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->ep=
c,
> > > > > +                             "Oops - control flow violation");
> > > > > +               return true;
> > > > > +       }
> > > > > +
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * software check exception is defined with risc-v cfi spec. Sof=
tware check
> > > > > + * exception is raised when:-
> > > > > + * a) An indirect branch doesn't land on 4 byte aligned PC or `l=
pad`
> > > > > + *    instruction or `label` value programmed in `lpad` instr do=
esn't
> > > > > + *    match with value setup in `x7`. reported code in `xtval` i=
s 2.
> > > > > + * b) `sspopchk` instruction finds a mismatch between top of sha=
dow stack (ssp)
> > > > > + *    and x1/x5. reported code in `xtval` is 3.
> > > > > + */
> > > > > +asmlinkage __visible __trap_section void do_trap_software_check(=
struct pt_regs *regs)
> > > > > +{
> > > > > +       if (user_mode(regs)) {
> > > > > +               irqentry_enter_from_user_mode(regs);
> > > > > +
> > > > > +               /* not a cfi violation, then merge into flow of u=
nknown trap handler */
> > > > > +               if (!handle_user_cfi_violation(regs))
> > > > > +                       do_trap_unknown(regs);
> > > > > +
> > > > > +               irqentry_exit_to_user_mode(regs);
> > > > > +       } else {
> > > > > +               /* sw check exception coming from kernel is a bug=
 in kernel */
> > > > > +               die(regs, "Kernel BUG");
> > > > > +       }
> > > > > +}
> > > > > +
> > > > >  #ifdef CONFIG_MMU
> > > > >  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *=
regs)
> > > > >  {
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >

