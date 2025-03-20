Return-Path: <linux-fsdevel+bounces-44661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2006A6B12A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 23:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86D2189D50E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A0B22A7E5;
	Thu, 20 Mar 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VoOM3OEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993022A7E8
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510582; cv=none; b=g9L5ymVeN+NQUT1wEnSMNQNE9Kxd/OCgoCjniOIkT21Jk5eSPbAXvU2qiBtmPSlLyhgcBLvhhpSAzBiXFF4UYq4Pr892lwdYzas+nfEp3QzRTR4Smum/KolRih6uFI3NnU6wfFxU9EhkTmFTZYAFegUU0L4Nk6HWPepvczGZ7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510582; c=relaxed/simple;
	bh=jHUyecYfqBSkuj/RyiebN9WzmLHzCNiNfUukvDXyi9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txTt3ebs+NlOACrRL5Bjatb1XexyRMO6Kv7akg8xXnySWFG889YJpVNKnTAE23UCNEel3slZaws5K1SLMeBTX8GPAe+RBvDGe0DbAedbOoqdHaF+i5fOfqDcxOtSZp8LvqTop61i4xg/NctZpeQ3j5WMWhF1tHgHRysEL9bGUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VoOM3OEI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fece18b3c8so12200947b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742510578; x=1743115378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn+4G/BZfte1kQZajpdgC3z6H+wA6NVBYYf22eoImB8=;
        b=VoOM3OEIlvD+S6M3S0KQmAPSCcZez/wVYCZrtShBQa7ZLMuzjPOjNkbvdO7RILoAbc
         D1FRkGbtJ1Us224W+vCenCJHZJyKifdtRRQBJ2Z9K6Il8SIqiOQWZ/znECJKKNXALsVS
         TtRrUng1d6ZAj+NkDUav9LhvupLpk8VdX2UjzvTLkcoYav5uHKObhQHiOv2k/AYDQ2Dn
         4bnX6j+rhk2fDd1QvC1kLtqSUL6vCMmUZhVucILCxSWWMj1g4QjCOT9cMQdn3DjLKELe
         leYH56s3W8QGPzGxOu4z4jG9kDXCtRpZiJTlb427FuJ5htQGGRX+ZPvRfJqcCGGTPVe8
         bCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510578; x=1743115378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn+4G/BZfte1kQZajpdgC3z6H+wA6NVBYYf22eoImB8=;
        b=tffTovVy/E6zOvjrUHIp4Eqm9hR3z8u1yAhfBTbSvAM/n5qzBIFu3RdQMZ/kr04Xof
         WPgIzYPGqJBqDRZ6FMs2sFvC20AIPp4xNc1Ihx9HBduR1l2sy6YrQV0YW7NNmtpOm5t5
         9VxLFKfA9O/uObm7oAcQtW+hFiiRQAdqDuuT4+xT8YmccU/XYeWtLRj0FNuZuPbncDGJ
         0n3u0YuiuI/KMWys59uSi5ntSZUW1YrUv63uGv9udaNtgKe06JO+WzLGm/zHaQuOwmAi
         8z/NUlzvV6Lm1vdHND8WJ/NBvpEqjxC06hNjvIOzJa7Uz4d+OaXOozD7745DYEMeu8GO
         q5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCV++GpsT70kCSffn10Bce3cketCx/i3/SnoctNG8+2ULYKhr+KjSlys6HwBaFCSvR98+LOmTRrvPZccnaEu@vger.kernel.org
X-Gm-Message-State: AOJu0YwDb/TtYz4T0ExBLAoYouyjpuJFqCtDUi/GrrcU2wblEE5vvH5L
	0sd6PPAUcCNjgiKt8EQXyjZCv0XmoBsmdjRMyLz8rvRoHG83BaD8iEI7gIqa6NBmlJF9tF6qAE/
	Oem9aQg7unXWO8y+bwk4psewGSdgh3ohzFjPKRg==
X-Gm-Gg: ASbGncslO0e0jSYALR7YuliAvo+5WIsdh395ttM9WHYHTPdqvh1HSIqLYITIERgeAQq
	PK0hkijiDv+WBADiss9pg6bdFELSgoyOhD0l3q2ux2VIql557lc4JEF2ykwoy/sG9VHItKAFS6H
	04NqrB5WOxzLNgKPaYApyqFVdOrpY=
X-Google-Smtp-Source: AGHT+IGmYWppAb1TiIqTjy/w+R69Tu+tZXikOvPPA4dXCqNye2klzCsCnnoPJTKEOwtSTNPJ9gWuo2HlZH9leRcscHA=
X-Received: by 2002:a05:690c:64c8:b0:6f4:8207:c68d with SMTP id
 00721157ae682-700babfd564mr17209397b3.3.1742510578457; Thu, 20 Mar 2025
 15:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-22-e51202b53138@rivosinc.com> <D8LFQYX4EHF8.2AJ01XL34WK0W@ventanamicro.com>
In-Reply-To: <D8LFQYX4EHF8.2AJ01XL34WK0W@ventanamicro.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 20 Mar 2025 15:42:44 -0700
X-Gm-Features: AQ5f1Jo-nHEMu5qFdaTum9uSomYqo-G7mLCiMbL1c8nby8c7DsEke_Gukp9eNFU
Message-ID: <CAKC1njTyiaBkmHvAM8VT_MG4Cdch=H9P8r3C-m-=QQEuzyrRNA@mail.gmail.com>
Subject: Re: [PATCH v12 22/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
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
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	Zong Li <zong.li@sifive.com>, linux-riscv <linux-riscv-bounces@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 3:10=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcma=
r@ventanamicro.com> wrote:
>
> 2025-03-14T14:39:41-07:00, Deepak Gupta <debug@rivosinc.com>:
> > Kernel will have to perform shadow stack operations on user shadow stac=
k.
> > Like during signal delivery and sigreturn, shadow stack token must be
> > created and validated respectively. Thus shadow stack access for kernel
> > must be enabled.
>
> Why can't kernel access the user shadow stack through an aliased WR
> mapping?

It can, although that opens up a can of worms. If this alternating
mapping is user mode
then ensuring that another threat in userspace can't write to this
address in this window
of signal handling. A kernel alternate mapping can be created, but
that can lead to all
sorts of requirements of ensuring the page is pinned down. IIRC, It
has been debated
on x86 shadow stack merge time as well on how a flaky alias mapping approac=
h can
become and weaken the threat model it is supposed to protect against.

Simply using `ssamoswap` is simple and serves the purpose. Enabling shadow =
stack
access for the kernel doesn't have any adverse effect on the kernel.

>
> > In future when kernel shadow stacks are enabled for linux kernel, it mu=
st
> > be enabled as early as possible for better coverage and prevent imbalan=
ce
> > between regular stack and shadow stack. After `relocate_enable_mmu` has
> > been done, this is as early as possible it can enabled.
> >
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > ---
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
> >       la tp, init_task
> >       la sp, init_thread_union + THREAD_SIZE
> >       addi sp, sp, -PT_SIZE_ON_STACK
> > +     li a7, SBI_EXT_FWFT
> > +     li a6, SBI_EXT_FWFT_SET
> > +     li a0, SBI_FWFT_SHADOW_STACK
> > +     li a1, 1 /* enable supervisor to access shadow stack access */
> > +     li a2, SBI_FWFT_SET_FLAG_LOCK
> > +     ecall
>
> I think the ecall can fail even on machines that have Zicfiss, so it
> would be good to disable user shadow stack if that happens.

