Return-Path: <linux-fsdevel+bounces-25814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A19950C43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 20:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8DF1C223D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7E1A38E0;
	Tue, 13 Aug 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9kawjOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ECC1A38E3;
	Tue, 13 Aug 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573699; cv=none; b=TDQITPW4ohOQfa9NnI95Owdb533dRg86XATMF//5YQ3ikSAssC9MlzmgWJlIgcJNkdWYbNXM32oY+Qf5sFZnzuPp64pUEPYGt+CAaDOp2dT3+VFCs6hu/20sdgt3EjKtqyklVY8ryMixoky2FTm7P0oqm2v4wMMUs+d/KNv/XEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573699; c=relaxed/simple;
	bh=mIAZG5sUpFuawjYnCf8/ZwImzlvCWBC0p2D0x/RBjPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jdw04wqZ578IYVUjHJ76mLiZBAmSS1fB2+URKTC16aqGROQayXsiNXQo/wSfuvR4pKGFIV1HqjQY2FYPypkV12IaQ4EelZ3REvwn2Gz3GsHFAs2h5DOWUhW7hnBEdcHS1o75rLf2+CM1LD/09tRegewt6n7M6+q2Q7fvBUSbKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9kawjOS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso1205450a12.1;
        Tue, 13 Aug 2024 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723573697; x=1724178497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sh8DmLjcOJd1vt9t/pxgkMxZLl+WSspUiHI7GIGi7O4=;
        b=J9kawjOShgMoPgz5mm2PdqzPgKHseYvEei8t3bATk9If25rxaUj0g/bhaGRO2YhMh7
         z8SUnVULwTirjEIxcEkOsz3Be0HMHgE0OaFe4AalaL2sQHtuoBOpzgtYg6NJCvWjllOR
         Fw4yewuXq2HA9Dj25MVGcCyHdFI7mRV99JZFJeMssiEwxX54ItLBc1zIJ54Wgzr429pb
         H1/k+r454GdS6BOiEJBVO6ZKTlRFYoE1ijkOyEZj0D4zdZVOXhWbJWUA0YFcAYZm5/so
         RYbfxxMwYRkKYmH90ZGNVQ7K+7DLJZ39vcamVCXPv1HMaS7nbSjETmrnySDEIQrGzobi
         R7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573697; x=1724178497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sh8DmLjcOJd1vt9t/pxgkMxZLl+WSspUiHI7GIGi7O4=;
        b=i+MJMYEtDdnaMgNwWLu4raYaADO/Bg+ov832PbfSe2SqYuSpHZTrfuSxemkpywlOw7
         STjgpqRRlTpY0FQrs8AouNLj+PYMmNE04DzjFzUCcsoL5Ox5dDWojD0WTETC0x/mJXsq
         2Q7U5QbcJ8D/1ET4drTE7DJfAbv9nnfKzA3NSY4nXavA4x6iDAsM9HTe533rJNbbcbvc
         t/UZCWt32IHgApzLLHyjD3XdOobX7jLTDXJf2+R6xDfma3E7WgM/1ks6ZtJAqb7gRhL2
         A9Lo2xOR4tLuUfIoQb/udLRUZugtZ6F6PYLTHSyvW7LI8OPObqUvGZUorBIk9bocHfWl
         Eifg==
X-Forwarded-Encrypted: i=1; AJvYcCVnlT4BIqGalJ00vew7evf3icvxtlDAwO560y096GH/UEyujf44hIrP6bomGCHhMC6kQGg1UJ41zNPgPOQjq6k/HURkK9hIQvQGxbYP5Q==
X-Gm-Message-State: AOJu0YyPzy6y4dboWmycW1LMnGO8/dnRL/e2u0nxU4u59WjN4tsI19Pa
	h/SIhpz0qUpl9+klktFo1jneutFeQJD6Y+3xCk7TMpKu3UVpbrUrhjTOU4pNzl3jVDGJZqT/0wp
	0xk+7NHutikz8fOh9QjtNaIObdtw=
X-Google-Smtp-Source: AGHT+IFt3evYFb0030I+G4npVCD6fbwKD6SGrUAptKT7IfvrhGhjYCjzQ7C4kPzpXfABV4ARMDPt2WbtQxxHdGn16tQ=
X-Received: by 2002:a17:90b:4a01:b0:2c9:6f06:8009 with SMTP id
 98e67ed59e1d1-2d3aaa754femr481762a91.1.1723573697272; Tue, 13 Aug 2024
 11:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322195418.2160164-1-jcmvbkbc@gmail.com> <5b51975f-6d0b-413c-8b38-39a6a45e8821@westnet.com.au>
 <CAMo8Bf+RKVpYT309ystJKVHDqDaK4ZavGe3e-a_jvG7AOcqciw@mail.gmail.com> <a0293b2d-7a43-49b7-8146-c20fd4be262f@westnet.com.au>
In-Reply-To: <a0293b2d-7a43-49b7-8146-c20fd4be262f@westnet.com.au>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 13 Aug 2024 11:28:06 -0700
Message-ID: <CAMo8Bf+GWXxHVorNvE=UWQDXfRvLE1MsK-dRwh_aZrd=ARxm2w@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf_fdpic: fix /proc/<pid>/auxv
To: Greg Ungerer <gregungerer@westnet.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:53=E2=80=AFPM Greg Ungerer <gregungerer@westnet.c=
om.au> wrote:
> On 13/8/24 04:02, Max Filippov wrote:
> > On Sun, Aug 11, 2024 at 7:26=E2=80=AFPM Greg Ungerer <gregungerer@westn=
et.com.au> wrote:
> >> On 23/3/24 05:54, Max Filippov wrote:
> >>> Althought FDPIC linux kernel provides /proc/<pid>/auxv files they are
> >>> empty because there's no code that initializes mm->saved_auxv in the
> >>> FDPIC ELF loader.
> >>>
> >>> Synchronize FDPIC ELF aux vector setup with ELF. Replace entry-by-ent=
ry
> >>> aux vector copying to userspace with initialization of mm->saved_auxv
> >>> first and then copying it to userspace as a whole.
> >>>
> >>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> >>
> >> This is breaking ARM nommu builds supporting fdpic and elf binaries fo=
r me.
> >>
> >> Tests I have for m68k and riscv nommu setups running elf binaries
> >> don't show any problems - I am only seeing this on ARM.
> >>
> >>
> >> ...
> >> Freeing unused kernel image (initmem) memory: 472K
> >> This architecture does not have kernel memory protection.
> >> Run /init as init process
> >> Internal error: Oops - undefined instruction: 0 [#1] ARM
> >> Modules linked in:
> >> CPU: 0 PID: 1 Comm: init Not tainted 6.10.0 #1
> >> Hardware name: ARM-Versatile (Device Tree Support)
> >> PC is at load_elf_fdpic_binary+0xb34/0xb80
> >> LR is at 0x0
> >> pc : [<00109ce8>]    lr : [<00000000>]    psr: 80000153
> >> sp : 00823e40  ip : 00000000  fp : 00b8fee4
> >> r10: 009c9b80  r9 : 00b8ff80  r8 : 009ee800
> >> r7 : 00000000  r6 : 009f7e80  r5 : 00b8fedc  r4 : 00b87000
> >> r3 : 00b8fed8  r2 : 00b8fee0  r1 : 00b87128  r0 : 00b8fef0
> >> Flags: Nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> >> Control: 00091176  Table: 00000000  DAC: 00000000
> >> Register r0 information: non-slab/vmalloc memory
> >> Register r1 information: slab/vmalloc mm_struct start 00b87000 pointer=
 offset 296 size 428
> >> Register r2 information: non-slab/vmalloc memory
> >> Register r3 information: non-slab/vmalloc memory
> >> Register r4 information: slab/vmalloc mm_struct start 00b87000 pointer=
 offset 0 size 428
> >> Register r5 information: non-slab/vmalloc memory
> >> Register r6 information: slab/vmalloc kmalloc-32 start 009f7e80 pointe=
r offset 0 size 32
> >> Register r7 information: non-slab/vmalloc memory
> >> Register r8 information: slab/vmalloc kmalloc-512 start 009ee800 point=
er offset 0 size 512
> >> Register r9 information: non-slab/vmalloc memory
> >> Register r10 information: slab/vmalloc kmalloc-128 start 009c9b80 poin=
ter offset 0 size 128
> >> Register r11 information: non-slab/vmalloc memory
> >> Register r12 information: non-slab/vmalloc memory
> >> Process init (pid: 1, stack limit =3D 0x(ptrval))
> >> Stack: (0x00823e40 to 0x00824000)
> >> 3e40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3e60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3e80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3ea0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3ec0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3ee0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3f00: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3f20: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3f40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3f60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3f80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3fa0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3fe0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> Call trace:
> >>    load_elf_fdpic_binary from bprm_execve+0x1b4/0x488
> >>    bprm_execve from kernel_execve+0x154/0x1e4
> >>    kernel_execve from kernel_init+0x4c/0x108
> >>    kernel_init from ret_from_fork+0x14/0x38
> >> Exception stack(0x00823fb0 to 0x00823ff8)
> >> 3fa0:                                     ???????? ???????? ???????? ?=
???????
> >> 3fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ?=
???????
> >> 3fe0: ???????? ???????? ???????? ???????? ???????? ????????
> >> Code: bad PC value
> >> ---[ end trace 0000000000000000 ]---
> >> note: init[1] exited with irqs disabled
> >> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000=
00b
> >> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b ]---
> >>
> >>
> >> The code around that PC is:
> >>
> >>     109cd0:       e2833ff1        add     r3, r3, #964    @ 0x3c4
> >>     109cd4:       e5933000        ldr     r3, [r3]
> >>     109cd8:       e5933328        ldr     r3, [r3, #808]  @ 0x328
> >>     109cdc:       e5933084        ldr     r3, [r3, #132]  @ 0x84
> >>     109ce0:       e5843034        str     r3, [r4, #52]   @ 0x34
> >>     109ce4:       eafffdbc        b       1093dc <load_elf_fdpic_binar=
y+0x228>
> >>     109ce8:       e7f001f2        .word   0xe7f001f2
> >>     109cec:       eb09471d        bl      35b968 <__stack_chk_fail>
> >>     109cf0:       e59f0038        ldr     r0, [pc, #56]   @ 109d30 <lo=
ad_elf_fdpic_binary+0xb7c>
> >>     109cf4:       eb092f03        bl      355908 <_printk>
> >>     109cf8:       eafffdb7        b       1093dc <load_elf_fdpic_binar=
y+0x228>
> >>
> >>
> >> Reverting just this change gets it working again.
> >>
> >> Any idea what might be going on?
> >
> > Other than that the layout of the aux vector has slightly changed I don=
't
> > see anything. I can take a look at what's going on if you can share the
> > reproducer.
>
> I build the test binary using a simple script:
>
>    https://github.com/gregungerer/simple-linux/blob/master/build-armnommu=
-linux-uclibc-fdpic.sh
>
> Run the resulting vmlinux and devicetree under qemu as per comments at to=
p of that script.

Cool scripts, thanks. I was able to reproduce the issue, it's the
BUG_ON(csp !=3D sp);
from the create_elf_fdpic_tables() that causes it. I'm still trying
to figure out how that happens.

--=20
Thanks.
-- Max

