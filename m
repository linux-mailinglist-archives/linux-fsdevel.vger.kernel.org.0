Return-Path: <linux-fsdevel+bounces-70695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55507CA4BD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 18:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3803A30AAD66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E02F8BDC;
	Thu,  4 Dec 2025 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TS5lSMNY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Or66t7hy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75112FC860
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868754; cv=none; b=a5lg40lCxpUltnMZOGnQ1vTwSXxwskINjDFPFQRuyHR1o+HdlRghF+TD8OagDFi2yytBzKZaRu+0kJgfHK3F1bDlh7vhDcpljwNLZj59WwaiUkUlGL3TXj254uOURbmV3yshgao/JM7pM26/mnCRRh92zr3y+JFktke1eTh6pUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868754; c=relaxed/simple;
	bh=tbhl1hB6Go7cKeEzi9fq0ksxVXWeewQm1ULfbDi4zC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyF+z8JC5ox3zlNTNmv0lpNjH7nLaaXnf7wXGgstQOqeZ9rl0U8uwahOTygHTgc8dXFV/K2sas4xvfU2UvqacmEj06eNRCGwfaNxWAERJ+lBugDJyIEJ9pu6FxyP0gWYKZmNWo4t5EiHpR0Sslbyc5Ks5NMN77vk6NUfwb6aJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TS5lSMNY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Or66t7hy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764868751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbhl1hB6Go7cKeEzi9fq0ksxVXWeewQm1ULfbDi4zC4=;
	b=TS5lSMNYD35/wAmr4rMYBl+UllFP4mLh2L185PF1q4woIPAbSZsz8L1x5lqeq9LaYONq2W
	01NQ8rgBBbkU0xhqnI1dzbvhxlTa0QsnUf8EX8feBKyKLCfptQF6NGNYArP9WJjkwe2l4e
	Y7GMbbyrKy7gIYf/Q3PibphGczpFohQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-QhXKt2FYN9OhjrneHBgFnQ-1; Thu, 04 Dec 2025 12:19:10 -0500
X-MC-Unique: QhXKt2FYN9OhjrneHBgFnQ-1
X-Mimecast-MFC-AGG-ID: QhXKt2FYN9OhjrneHBgFnQ_1764868750
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9351ea95712so1764030241.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 09:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764868750; x=1765473550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbhl1hB6Go7cKeEzi9fq0ksxVXWeewQm1ULfbDi4zC4=;
        b=Or66t7hyxTXeQtzi9Re8PxU7hESsDH3cXRqvMkdxRRRXjpurI5JYyajyGqhO00PDIp
         ulvX7ENQ1rGpknurVtL8DIbJnTfB5K8QatZFVUE6Q/kfR23z2/Oabjoa8FSusKJZvHhL
         lqKTMUZ78zwBzQUSsUjQsgF4F/B61JlDAQzVSpT273FJQNgtni6vQig4ROVfSpMhFi9Y
         d/n5oiqHnO9/tgjJ/tkYy1pB/YH+pLKjnmYlmiu36snNsLra6KhcpjckdFj1bK41PEbs
         bQP7f778Bmv9fn28aV0f8HqGs8OGxDRfHXQ7gj8QDzByUG1bNaHG7XyHfAWFBL5NV9fP
         tNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868750; x=1765473550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tbhl1hB6Go7cKeEzi9fq0ksxVXWeewQm1ULfbDi4zC4=;
        b=ZFZ4A0BczbtmsV+zner/wiixNE9/Gyq7cJq2JPFWjwr/9kMjDqmCLELJM7W/51Y219
         Za5wZ0mlYZWEWYezfg7oebDm2qaZSh4ftOmSwxVZC0l1WIpYf2fOtzCOP5CrxEsLD51G
         UywS3iKZgiTmILvX1+XjA2ZPhOC0QLua54+uvIuLF4MWqlYMVGWRy76hDGCKTfxajDFy
         ZcSF4vsdHZFjqAoR1M07dhH/U9qNDUE8VPRuP/CD+AUX85N1e2t/7BSZ0VCirRLrdVGm
         tPurTHFkYiYUHdUo5BzNqlIiVPUoij0n7/4eaykk+q62WGSJx6/0/naFu8OrLdw8qWZC
         qqYg==
X-Forwarded-Encrypted: i=1; AJvYcCVZSyoq3syyNlY4lorY5rVQVpkdK5s8zjQfT6SflhEv3RE0DP9PjN1yzbQEdJriUI22sVYAwoKOzLrNXn3t@vger.kernel.org
X-Gm-Message-State: AOJu0YwkYZD9rw4R26K8NR+AglBhymKmGmVfEfT0eTbbAn7KIFAQPQpZ
	CRkzB/cxXQTy3mdMFbGbRNnDdT0oqgvLwJ+rFTZQbK6NLI4BGRlKM9OTqKbB6q14FA54oobLgjq
	54xNv5zIR6Dn6BKy6jv+7Xq3k4/pDKJcDbLbG999J8hVtnwUkAdbZalxLCMFClp9Zt2rj0Hdd1P
	iwDsIxfWYUeYxXiGa6GMhPV+KLCeezDYDIj5WvCZe/Fg==
X-Gm-Gg: ASbGncuxqO0D8KGmZi47kDqBsU99c1kHY3yZpKI2UCMDvMrZ1V9Ke7Hs5e7sht9qQkR
	2Ah//FAk4G2iHvxy4FklL1HpelDMaOVFRiaGYtRMphEcU4jLOaeJ9SFu1moDl2K0JZlLfclxt3a
	ULxVzCOJl5tv8yNHo5j8fb5dwTybZ1lIbczPNCtbqvNw1Hy0w+CQg11x5VSm3/iWjdO/T7QnLDA
	QE=
X-Received: by 2002:a05:6122:219e:b0:55b:d85:5073 with SMTP id 71dfb90a1353d-55e69d33928mr1380191e0c.4.1764868750231;
        Thu, 04 Dec 2025 09:19:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeIB0YNcpJAiGx/GNuObvXw/sfsBoL+Pu7iwpKlscfZjHDAR4upRzogd+N3zgiWodvzIxUpcfLPOjZg7ZeO+k=
X-Received: by 2002:a05:6122:219e:b0:55b:d85:5073 with SMTP id
 71dfb90a1353d-55e69d33928mr1380133e0c.4.1764868749828; Thu, 04 Dec 2025
 09:19:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
 <20251112-v5_user_cfi_series-v23-24-b55691eacf4f@rivosinc.com> <20251204175055-fefb76ff-2ff2-48b8-b92c-3d3ce33ec9f5@linutronix.de>
In-Reply-To: <20251204175055-fefb76ff-2ff2-48b8-b92c-3d3ce33ec9f5@linutronix.de>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Thu, 4 Dec 2025 12:18:57 -0500
X-Gm-Features: AWmQ_bn9PjdtETVMsD9KORY8lffIPeFGUkSijG0lA3xh-eP2WvDjQUg18Xtxf3s
Message-ID: <CABe3_aH6wRzKt+f8RyG+0mN0Kyu2eASRn4URxgU4R-zEmdwBgA@mail.gmail.com>
Subject: Re: [PATCH v23 24/28] arch/riscv: dual vdso creation logic and select
 vdso based on hw
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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

On Thu, Dec 4, 2025 at 12:04=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Wed, Nov 12, 2025 at 04:43:22PM -0800, Deepak Gupta via B4 Relay wrote=
:
> > From: Deepak Gupta <debug@rivosinc.com>
> >
> > Shadow stack instructions are taken from zimop (mandated on RVA23).
> > Any hardware prior to RVA23 profile will fault on shadow stack instruct=
ion.
> > Any userspace with shadow stack instruction in it will fault on such
> > hardware. Thus such userspace can't be brought onto such a hardware.
> >
> > It's not known how userspace will respond to such binary fragmentation.
> > However in order to keep kernel portable across such different hardware=
,
> > `arch/riscv/kernel/vdso_cfi` is created which has logic (Makefile) to
> > compile `arch/riscv/kernel/vdso` sources with cfi flags and then change=
s
> > in `arch/riscv/kernel/vdso.c` for selecting appropriate vdso depending
> > on whether underlying hardware(cpu) implements zimop extension. Offset
> > of vdso symbols will change due to having two different vdso binaries,
> > there is added logic to include new generated vdso offset header and
> > dynamically select offset (like for rt_sigreturn).
>
> If the used vDSO variant only depends on the hardware and nothing else,
> why not use alternative patching and avoid the complexity?
> I see that RISCV_ALTERNATIVE depends on !XIP_KERNEL but the vDSO code is
> moved to dynamically allocated memory in any case, so it is patchable.

These instructions are emitted by the toolchain in the C code, so a
traditional approach with alternatives is not exactly feasible. Maybe
you could do it by scan the binary for them, but that sounds dubious.

>
> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > Acked-by: Charles Mirabile <cmirabil@redhat.com>
>
> (...)
>


