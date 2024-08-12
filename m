Return-Path: <linux-fsdevel+bounces-25710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FFB94F63B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 20:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E392C1F22C9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7322F18953E;
	Mon, 12 Aug 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igGHXumV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBADC156;
	Mon, 12 Aug 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485776; cv=none; b=lyhyQPhZwcVRk1tC1uaTWB9PxvPs73RLNTOAK3ZFF2+Sl5Yt2mqWd2/tve1u6U6TzM6+YKFLoJD0TVifnUE8xolW0ewi7nIFHHFLhauPRu/Q6U1I2chMLSPNgEkJfup7EkNDRW54o9TKEdX162oLR5KxS6eOEwhvt0qIO5Bniqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485776; c=relaxed/simple;
	bh=KSt8cwVazExoS3ndzbTnhb2Eez4/grxHsi6vt2o8jUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQG5fnuLirCFRRYuhCiKaj0FCEYJJDIxFVQTxWmdxuEIZwf80SDzfSDJoBbxto8pPOhX/ZLVqz9jaLWg3wVY+5Tvx/VkUzro74qeOQUrIdoaXOTTnze60ZHbT2SIaoOOdksAlkPzXDlIBRKsYbwP3Uj/ib76wj/2nrkWHziYx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igGHXumV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd70ba6a15so33961165ad.0;
        Mon, 12 Aug 2024 11:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723485775; x=1724090575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbpdstgE1lVseiATTDd5O2kTI49ejr0wN43dv27ybfQ=;
        b=igGHXumVgicR8VGlNgdLeBXxUqqXDaAdK2jNdTjiZ1HLRVTefbExuAvmUWV920WM11
         K60YeymRnJJywNFTufqnd4kVHCH0drFFQ16m/uFas3VgfhXxXydsp/HEFI/2I2SKth64
         oQ1Jq4gaQGwh1VnDmGIiTEt+qtZqY3OtmqJ5ssoOC+xBfPipbF/VYq3K85igZAWOHlVB
         BhTeEa4ApHb1RxXENV/Wuzjur0Efne6S+s0gOhkLWhvp6mMRm+AJBL2AukN3PJY5Rp8g
         BqtPO7YPQ+4jsjgfN9nXiVqb9QgaGxw3kpSktxt2fvuorBZfMH2LUMPnr7wzeJnSpkpD
         4MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723485775; x=1724090575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbpdstgE1lVseiATTDd5O2kTI49ejr0wN43dv27ybfQ=;
        b=rg/+KUUCVg/Kj4pESlH4a3dM3rcm9DuPSWjA/0pnDikQs7s98IAzR2UCAX2Pj3//sN
         kwIBrFbjTuRXn8igg5GcCKWv1+U/H4T6Jcz77WxwOtW4IJc0YdFgnJu5Pb8B2YjUzHus
         qqYxirJqJDTzcwQKkTLMx0HyV9VoKR7qlgj8aHsjZo3feLKZLKS/D6QM//KViO0CFJKW
         e5qYvrsggP1SQtl0wocDkQ0L1DgM+zbogFQmISg0sOQdL0A9FE53P7Z4d1Lwfq3IK98i
         wkULaBH3mp5EeIi7NfhCWXDEFhwyMqNZx4lmUf3BiN9XeGNH9cC0gAjBiWhZoSJ931xs
         IrMg==
X-Forwarded-Encrypted: i=1; AJvYcCXdTGYo6UutFtfwQzkGxWEELMgPAkjQH+q+0y0oQfEEkWa/xslFQXTxFkFWRRkiClr8M+6Wvd8pbDOoa/Jn/cEDpe5oiMxZb/X7foHzTg==
X-Gm-Message-State: AOJu0YyUNyfkRiDIlYhdTQdhkRGhZk5itK4ANbiBWpcNJUb4YQT+Yo76
	/2CjCX8UJBm5o5A1tHe9Az0ONKD6nL21b8T9ENBhca0xpDyigIL4xhPgu6eYyKxIqo9vR8Y4oNx
	jY2Ct6R9Kd3we7Ctpq/1PsZpq7BE=
X-Google-Smtp-Source: AGHT+IEGbh48fsiAGvqrXeCYwMCoLpu+qOdw9YvfKVJzhOC5AbvZWfNOXxVDeB6ZfHrhkt6Nhw1YzVEbIVaLMEocOnc=
X-Received: by 2002:a17:903:22c4:b0:200:8d3f:bb65 with SMTP id
 d9443c01a7336-201ca12987cmr12851925ad.9.1723485774488; Mon, 12 Aug 2024
 11:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322195418.2160164-1-jcmvbkbc@gmail.com> <5b51975f-6d0b-413c-8b38-39a6a45e8821@westnet.com.au>
In-Reply-To: <5b51975f-6d0b-413c-8b38-39a6a45e8821@westnet.com.au>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 12 Aug 2024 11:02:42 -0700
Message-ID: <CAMo8Bf+RKVpYT309ystJKVHDqDaK4ZavGe3e-a_jvG7AOcqciw@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf_fdpic: fix /proc/<pid>/auxv
To: Greg Ungerer <gregungerer@westnet.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sun, Aug 11, 2024 at 7:26=E2=80=AFPM Greg Ungerer <gregungerer@westnet.c=
om.au> wrote:
> On 23/3/24 05:54, Max Filippov wrote:
> > Althought FDPIC linux kernel provides /proc/<pid>/auxv files they are
> > empty because there's no code that initializes mm->saved_auxv in the
> > FDPIC ELF loader.
> >
> > Synchronize FDPIC ELF aux vector setup with ELF. Replace entry-by-entry
> > aux vector copying to userspace with initialization of mm->saved_auxv
> > first and then copying it to userspace as a whole.
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>
> This is breaking ARM nommu builds supporting fdpic and elf binaries for m=
e.
>
> Tests I have for m68k and riscv nommu setups running elf binaries
> don't show any problems - I am only seeing this on ARM.
>
>
> ...
> Freeing unused kernel image (initmem) memory: 472K
> This architecture does not have kernel memory protection.
> Run /init as init process
> Internal error: Oops - undefined instruction: 0 [#1] ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: init Not tainted 6.10.0 #1
> Hardware name: ARM-Versatile (Device Tree Support)
> PC is at load_elf_fdpic_binary+0xb34/0xb80
> LR is at 0x0
> pc : [<00109ce8>]    lr : [<00000000>]    psr: 80000153
> sp : 00823e40  ip : 00000000  fp : 00b8fee4
> r10: 009c9b80  r9 : 00b8ff80  r8 : 009ee800
> r7 : 00000000  r6 : 009f7e80  r5 : 00b8fedc  r4 : 00b87000
> r3 : 00b8fed8  r2 : 00b8fee0  r1 : 00b87128  r0 : 00b8fef0
> Flags: Nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> Control: 00091176  Table: 00000000  DAC: 00000000
> Register r0 information: non-slab/vmalloc memory
> Register r1 information: slab/vmalloc mm_struct start 00b87000 pointer of=
fset 296 size 428
> Register r2 information: non-slab/vmalloc memory
> Register r3 information: non-slab/vmalloc memory
> Register r4 information: slab/vmalloc mm_struct start 00b87000 pointer of=
fset 0 size 428
> Register r5 information: non-slab/vmalloc memory
> Register r6 information: slab/vmalloc kmalloc-32 start 009f7e80 pointer o=
ffset 0 size 32
> Register r7 information: non-slab/vmalloc memory
> Register r8 information: slab/vmalloc kmalloc-512 start 009ee800 pointer =
offset 0 size 512
> Register r9 information: non-slab/vmalloc memory
> Register r10 information: slab/vmalloc kmalloc-128 start 009c9b80 pointer=
 offset 0 size 128
> Register r11 information: non-slab/vmalloc memory
> Register r12 information: non-slab/vmalloc memory
> Process init (pid: 1, stack limit =3D 0x(ptrval))
> Stack: (0x00823e40 to 0x00824000)
> 3e40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3e60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3e80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3ea0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3ec0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3ee0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3f00: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3f20: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3f40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3f60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3f80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3fa0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3fe0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> Call trace:
>   load_elf_fdpic_binary from bprm_execve+0x1b4/0x488
>   bprm_execve from kernel_execve+0x154/0x1e4
>   kernel_execve from kernel_init+0x4c/0x108
>   kernel_init from ret_from_fork+0x14/0x38
> Exception stack(0x00823fb0 to 0x00823ff8)
> 3fa0:                                     ???????? ???????? ???????? ????=
????
> 3fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????=
????
> 3fe0: ???????? ???????? ???????? ???????? ???????? ????????
> Code: bad PC value
> ---[ end trace 0000000000000000 ]---
> note: init[1] exited with irqs disabled
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=3D0=
x0000000b ]---
>
>
> The code around that PC is:
>
>    109cd0:       e2833ff1        add     r3, r3, #964    @ 0x3c4
>    109cd4:       e5933000        ldr     r3, [r3]
>    109cd8:       e5933328        ldr     r3, [r3, #808]  @ 0x328
>    109cdc:       e5933084        ldr     r3, [r3, #132]  @ 0x84
>    109ce0:       e5843034        str     r3, [r4, #52]   @ 0x34
>    109ce4:       eafffdbc        b       1093dc <load_elf_fdpic_binary+0x=
228>
>    109ce8:       e7f001f2        .word   0xe7f001f2
>    109cec:       eb09471d        bl      35b968 <__stack_chk_fail>
>    109cf0:       e59f0038        ldr     r0, [pc, #56]   @ 109d30 <load_e=
lf_fdpic_binary+0xb7c>
>    109cf4:       eb092f03        bl      355908 <_printk>
>    109cf8:       eafffdb7        b       1093dc <load_elf_fdpic_binary+0x=
228>
>
>
> Reverting just this change gets it working again.
>
> Any idea what might be going on?

Other than that the layout of the aux vector has slightly changed I don't
see anything. I can take a look at what's going on if you can share the
reproducer.

--=20
Thanks.
-- Max

