Return-Path: <linux-fsdevel+bounces-26070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3129536A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B172880ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EDF1A76C0;
	Thu, 15 Aug 2024 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKTjWhUo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845201A256C;
	Thu, 15 Aug 2024 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734466; cv=none; b=BcL6gRNX0Q3yY2rmJRDbfw21Uy8o2CSIOO6dHJgE7+5D80F7X6zEOiTlH00Tc/YqCcLKItIu5MH0SR8oZDll2hFgyrpvMXhzTLUCHe8GHHGlYBE+RynJsLlwrkhoIpryD9sSmQyhzeG7YUO6p8YXpGpRXlSCu1nNSBqPRl/Yjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734466; c=relaxed/simple;
	bh=kZUvP4nzbg6phjn2v7MWFjDsuXHPZwCGV1OGE6l43T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoI2fUQNleUjAOq1FQXREkAFihuQLvRXUey6rl+O5D1gl8jC3wuj/m3wLMZsKHKUulKaSeZqKMe+sX/u/Bzgqy+ldHzkgFjnvp6OZt+8S6AW/6QrtFv5s2xTQMLZhcV+pfDx2CftZ5h++EXMNJjrLnxdqj4ESb1H2YlGK+ORyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKTjWhUo; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f00ad303aso1314527e87.2;
        Thu, 15 Aug 2024 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723734462; x=1724339262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8SNHJNcIoI942o94u3367Q/xCX1kW+hct2q4PcQPf8=;
        b=HKTjWhUor0lodMiv3N0e44Kij5fBClNnWC6/CREPvsxkJn9fJqaC1CxNxpWGUUt5hm
         f914hFn9mmNAkHKOJPklwt8th+hF2iyPuekzv3mtTj1WWLdc7QH3BZMRLwkiVJC6Rmhc
         MQqieRlfpd0OPV6mI0ynEo/t5FDEO9oE77XGWC/9Eg8IYWF2Xby5tDBAzemkkkF9swdI
         9Q81HjEOaFN2YejnbPLIvtKMf8eGsWq5BCFhL5vDINSPlST6DOQIAAhh7TjJuRsSv34I
         OUO04sIGfiI4cVDtZGULMbD3ESF+A/XN0+YcgaAZEKXn8wxFW8MZeBmKeCo2wbzrBd+3
         Hqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723734462; x=1724339262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8SNHJNcIoI942o94u3367Q/xCX1kW+hct2q4PcQPf8=;
        b=TpJGScKsrGm9ZndBgpWb5b6AbgFwElPHxeWpbBKfTeW5e6AEGLYcj2rydBlmja9b+W
         qjFPLqA5seO1BN10lqdGzKOYRiGFqEnp9+03UFtKiOwkpolJfz63hipdJ7gk7+O8jeRS
         5Cg77kQS2jA5RNubQ+A1ahyJfFY8w1xo1dXWArmXeAkwuDV6m/I41W0Vaq1n/pmv227R
         zgrqTgkTnhDsSAa5QZFDd+K1/lNIhnDrTtM055HJhgetKFwPM7XJQNYE5A5VlsmLaULc
         aw+j5wwIY2FlN572bPkBH7+JTodye0cx+QxZWvcgSDkMBmOUIgaocDkoEzwCsE8uNI9U
         HW+g==
X-Forwarded-Encrypted: i=1; AJvYcCW5kCqzraoozJyUxzyWWcN/0zelO3vN0E85pgulTSN9Ou5bu+nyWApCo7Nvb/TH98Vabb/jwNlF/hOzXVL2jM6Ih2Dk0tPogt3Oa5aTuaF1+7EOtIPAjGsjLoEL0aeeua6nkqGPJ6EqT0J5qw==
X-Gm-Message-State: AOJu0YwoPO0HEjJhQEPTGoued0zVqEkcxiNBoJtnt74xaE/Zr7ZNFiXj
	ek+MOEOq22Gtg9Fw2/2LkgbaW2QTYJ5ApB2eZ1mPr9zwzvRpp+0miDpnFce7GKTURCM/bBsblTU
	bcb0ctlccgaHBMVxBeckBR2ASD/w=
X-Google-Smtp-Source: AGHT+IFnuPqWOtDaNn2zQBGHE0JlZWDcrapJnEDM3aQoPyj49qqny15G/tNOSlkatwkYZDqUdZmCb4l0RZulA9wMhAA=
X-Received: by 2002:a05:6512:308d:b0:52e:9694:3f98 with SMTP id
 2adb3069b0e04-532eda81faemr4527712e87.27.1723734462016; Thu, 15 Aug 2024
 08:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com>
 <87ikwdtqiy.fsf@linux.intel.com> <44862ec7c85cdc19529e26f47176d0ecfc90d888.camel@kernel.org>
 <CAGudoHGZVBw3h_pHDaaSMeDgf3q_qn4wmkfOoG6y-CKN9sZLVQ@mail.gmail.com> <ZrKL2youCTmO3K0Q@tassilo>
In-Reply-To: <ZrKL2youCTmO3K0Q@tassilo>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 15 Aug 2024 17:07:29 +0200
Message-ID: <CAGudoHFxme+cPsm2BVsOjoy6UZzgEZZebkvDhp7=jkevSTyb-A@mail.gmail.com>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
To: Andi Kleen <ak@linux.intel.com>
Cc: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:47=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > Before I get to the vfs layer, there is a significant loss in the
> > memory allocator because of memcg -- it takes several irq off/on trips
> > for every alloc (needed to grab struct file *). I have a plan what to
> > do with it (handle stuff with local cmpxchg (note no lock prefix)),
> > which I'm trying to get around to. Apart from that you may note the
> > allocator fast path performs a 16-byte cmpxchg, which is again dog
> > slow and executes twice (once for the file obj, another time for the
> > namei buffer). Someone(tm) should patch it up and I have some vague
> > ideas, but 0 idea when I can take a serious stab.
>
> I just LBR sampled it on my skylake and it doesn't look
> particularly slow. You see the whole massive block including CMPXCHG16
> gets IPC 2.7, which is rather good. If you see lots of cycles on it it's =
likely
> a missing cache line.
>
>     kmem_cache_free:
>         ffffffff9944ce20                        nop %edi, %edx
>         ffffffff9944ce24                        nopl  %eax, (%rax,%rax,1)
>         ffffffff9944ce29                        pushq  %rbp
>         ffffffff9944ce2a                        mov %rdi, %rdx
>         ffffffff9944ce2d                        mov %rsp, %rbp
>         ffffffff9944ce30                        pushq  %r15
>         ffffffff9944ce32                        pushq  %r14
>         ffffffff9944ce34                        pushq  %r13
>         ffffffff9944ce36                        pushq  %r12
>         ffffffff9944ce38                        mov $0x80000000, %r12d
>         ffffffff9944ce3e                        pushq  %rbx
>         ffffffff9944ce3f                        mov %rsi, %rbx
>         ffffffff9944ce42                        and $0xfffffffffffffff0, =
%rsp
>         ffffffff9944ce46                        sub $0x10, %rsp
>         ffffffff9944ce4a                        movq  %gs:0x28, %rax
>         ffffffff9944ce53                        movq  %rax, 0x8(%rsp)
>         ffffffff9944ce58                        xor %eax, %eax
>         ffffffff9944ce5a                        add %rsi, %r12
>         ffffffff9944ce5d                        jb 0xffffffff9944d1ea
>         ffffffff9944ce63                        mov $0xffffffff80000000, =
%rax
>         ffffffff9944ce6a                        xor %r13d, %r13d
>         ffffffff9944ce6d                        subq  0x17b068c(%rip), %r=
ax
>         ffffffff9944ce74                        add %r12, %rax
>         ffffffff9944ce77                        shr $0xc, %rax
>         ffffffff9944ce7b                        shl $0x6, %rax
>         ffffffff9944ce7f                        addq  0x17b066a(%rip), %r=
ax
>         ffffffff9944ce86                        movq  0x8(%rax), %rcx
>         ffffffff9944ce8a                        test $0x1, %cl
>         ffffffff9944ce8d                        jnz 0xffffffff9944d15c
>         ffffffff9944ce93                        nopl  %eax, (%rax,%rax,1)
>         ffffffff9944ce98                        movq  (%rax), %rcx
>         ffffffff9944ce9b                        and $0x8, %ch
>         ffffffff9944ce9e                        jz 0xffffffff9944cfea
>         ffffffff9944cea4                        test %rax, %rax
>         ffffffff9944cea7                        jz 0xffffffff9944cfea
>         ffffffff9944cead                        movq  0x8(%rax), %r14
>         ffffffff9944ceb1                        test %r14, %r14
>         ffffffff9944ceb4                        jz 0xffffffff9944cfac
>         ffffffff9944ceba                        cmp %r14, %rdx
>         ffffffff9944cebd                        jnz 0xffffffff9944d165
>         ffffffff9944cec3                        test %r14, %r14
>         ffffffff9944cec6                        jz 0xffffffff9944cfac
>         ffffffff9944cecc                        movq  0x8(%rbp), %r15
>         ffffffff9944ced0                        nopl  %eax, (%rax,%rax,1)
>         ffffffff9944ced5                        movq  0x1fe5134(%rip), %r=
ax
>         ffffffff9944cedc                        test %r13, %r13
>         ffffffff9944cedf                        jnz 0xffffffff9944ceef
>         ffffffff9944cee1                        mov $0xffffffff80000000, =
%rax
>         ffffffff9944cee8                        subq  0x17b0611(%rip), %r=
ax
>         ffffffff9944ceef                        add %rax, %r12
>         ffffffff9944cef2                        shr $0xc, %r12
>         ffffffff9944cef6                        shl $0x6, %r12
>         ffffffff9944cefa                        addq  0x17b05ef(%rip), %r=
12
>         ffffffff9944cf01                        movq  0x8(%r12), %rax
>         ffffffff9944cf06                        mov %r12, %r13
>         ffffffff9944cf09                        test $0x1, %al
>         ffffffff9944cf0b                        jnz 0xffffffff9944d1b1
>         ffffffff9944cf11                        nopl  %eax, (%rax,%rax,1)
>         ffffffff9944cf16                        movq  (%r13), %rax
>         ffffffff9944cf1a                        movq  %rbx, (%rsp)
>         ffffffff9944cf1e                        test $0x8, %ah
>         ffffffff9944cf21                        mov $0x0, %eax
>         ffffffff9944cf26                        cmovz %rax, %r13
>         ffffffff9944cf2a                        data16 nop
>         ffffffff9944cf2c                        movq  0x38(%r13), %r8
>         ffffffff9944cf30                        cmp $0x3, %r8
>         ffffffff9944cf34                        jnbe 0xffffffff9944d1ca
>         ffffffff9944cf3a                        nopl  %eax, (%rax,%rax,1)
>         ffffffff9944cf3f                        movq  0x23d6f72(%rip), %r=
ax
>         ffffffff9944cf46                        mov %rbx, %rdx
>         ffffffff9944cf49                        sub %rax, %rdx
>         ffffffff9944cf4c                        cmp $0x1fffff, %rdx
>         ffffffff9944cf53                        jbe 0xffffffff9944d03a
>         ffffffff9944cf59                        movq  (%r14), %rax
>         ffffffff9944cf5c                        addq  %gs:0x66bccab4(%rip=
), %rax
>         ffffffff9944cf64                        movq  0x8(%rax), %rdx
>         ffffffff9944cf68                        cmpq  %r13, 0x10(%rax)
>         ffffffff9944cf6c                        jnz 0xffffffff9944d192
>         ffffffff9944cf72                        movl  0x28(%r14), %ecx
>         ffffffff9944cf76                        movq  (%rax), %rax
>         ffffffff9944cf79                        add %rbx, %rcx
>         ffffffff9944cf7c                        cmp %rbx, %rax
>         ffffffff9944cf7f                        jz 0xffffffff9944d1ba
>         ffffffff9944cf85                        movq  0xb8(%r14), %rsi
>         ffffffff9944cf8c                        mov %rcx, %rdi
>         ffffffff9944cf8f                        bswap %rdi
>         ffffffff9944cf92                        xor %rax, %rsi
>         ffffffff9944cf95                        xor %rdi, %rsi
>         ffffffff9944cf98                        movq  %rsi, (%rcx)
>         ffffffff9944cf9b                        leaq  0x2000(%rdx), %rcx
>         ffffffff9944cfa2                        movq  (%r14), %rsi
>         ffffffff9944cfa5                        cmpxchg16bx  %gs:(%rsi)
>         ffffffff9944cfaa                        jnz 0xffffffff9944cf59
>         ffffffff9944cfac                        movq  0x8(%rsp), %rax
>         ffffffff9944cfb1                        subq  %gs:0x28, %rax
>         ffffffff9944cfba                        jnz 0xffffffff9944d1fc
>         ffffffff9944cfc0                        leaq  -0x28(%rbp), %rsp
>         ffffffff9944cfc4                        popq  %rbx
>         ffffffff9944cfc5                        popq  %r12
>         ffffffff9944cfc7                        popq  %r13
>         ffffffff9944cfc9                        popq  %r14
>         ffffffff9944cfcb                        popq  %r15
>         ffffffff9944cfcd                        popq  %rbp
>         ffffffff9944cfce                        retq                     =
       # PRED 38 cycles [126] 2.74 IPC    <-------------

Sorry for late reply, my test box was temporarily unavailable and then
I forgot about this e-mail :)

I don't have a good scientific test(tm) and I don't think coming up
with one is warranted at the moment.

But to illustrate, I slapped together a test case for will-it-scale
where I either cmpxchg8 or 16 in a loop. No lock prefix on these.

On Sapphire Rapids I see well over twice the throughput for the 8-byte vari=
ant:

# ./cmpxchg8_processes
warmup
min:481465497 max:481465497 total:481465497
min:464439645 max:464439645 total:464439645
min:461884735 max:461884735 total:461884735
min:460850043 max:460850043 total:460850043
min:461066452 max:461066452 total:461066452
min:463984473 max:463984473 total:463984473
measurement
min:461317703 max:461317703 total:461317703
min:458608942 max:458608942 total:458608942
min:460846336 max:460846336 total:460846336
[snip]

# ./cmpxchg16b_processes
warmup
min:205207128 max:205207128 total:205207128
min:205010535 max:205010535 total:205010535
min:204877781 max:204877781 total:204877781
min:204163814 max:204163814 total:204163814
min:204392000 max:204392000 total:204392000
min:204094222 max:204094222 total:204094222
measurement
min:204243282 max:204243282 total:204243282
min:204136589 max:204136589 total:204136589
min:203504119 max:203504119 total:203504119

So I would say trying it out in a real alloc is worth looking at.

Of course the 16-byte variant is not used just for kicks, so going to
8 bytes is more involved than just replacing the instruction.

The current code follows the standard idea on how to deal with the ABA
problem -- apart from replacing a pointer you validate this is what
you thought by checking the counter in the same instruction.

I note that in the kernel we can do better, but I don't have have all
kinks worked out yet. The core idea builds on the fact that we can
cheaply detect a pending alloc on the same cpu and should a
conflicting free be executing from an interrupt, it can instead add
the returning buffer to a different list and the aba problem
disappears. Should the alloc fast path fail to find a free buffer, it
can disable interrupts an take a look at the fallback list.

--=20
Mateusz Guzik <mjguzik gmail.com>

