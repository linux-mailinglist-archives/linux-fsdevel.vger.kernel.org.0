Return-Path: <linux-fsdevel+bounces-46192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FA6A8416B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7EA4C3C0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA2281538;
	Thu, 10 Apr 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pVFHYrgW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EABA26FA40
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283083; cv=none; b=O3k2EvgKblMEoRMilVwT4PR6eJvb0gqQgHsrU66x0X0+GN10n81v6O0y5TSj4jt/FLksZOK5W+897VC+MhXouCNwsqkO+am3gGGJcLg4siBF/dbjKdoWQn9SV61dNayk+/q0kf8DRnwVt8OJaDHjzTSELRgflArsARdCyTtVUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283083; c=relaxed/simple;
	bh=kOlPkOa9RAWaHmxwXq9vXkGSssRFc7sUC8EQNbcnfPY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=AV7GgTzXfRu0a4QEN2vat+RjLDYUcLlUi+TGpEFDFvjB7Xte/Idq86Yazcc19Wqm7xkq8OXx0OqDnkjSGceKSMB2S3HxRGAzhMKIP4KWFgqSOBUQiCw6Y70GWqCRdGMT+EpKqafokv3DZ8nm4DsvQwjlL9yEEDh1DjgyPkCSExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pVFHYrgW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43eeb4e09b5so1046035e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1744283080; x=1744887880; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwTqTcXuZVwmB1gK8gAQzMNft2dcqvTwt7yn+4sQNuo=;
        b=pVFHYrgW6CsPBVfhDp8H0SHh07ORi0+k92JSM7WHod+l6GpALDm6Af/8R4cZodTjSI
         tJhmQC0ISSnfE51tew20VXscex2ugzAatyW+gaNQVdqFVsPCNEtL0hzsectLv90gFFtt
         oVuwwysWrn9jEcSsg7T6KkbCebzr4gntAQJheGXE5uqMjbzNUT2JWYiPhRLq9y69avjt
         blLUmxwM5ibExPlEoUUbX0wnvPL/rJd7iUzELewMF/309FFzjGxOdZqxZeMaqwE83MP6
         zgXi1m4nmEywod9fgORmfD+WzNDeuueMfkonfaKqfm00t7VTa2R1DFvAman71MpISxGx
         m5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744283080; x=1744887880;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwTqTcXuZVwmB1gK8gAQzMNft2dcqvTwt7yn+4sQNuo=;
        b=EzI+JsuFKCgg7Xbz/lBFgwkb2FjwbJCzTs6C1RQ27/6kegmqaKyRFn6asLoICqPhvM
         gTGmXNY+/9FJpH7o7aENqc7bQ1Laa/O9/E/JuvyYuEN43uWE3eDCZ9ECvehu8OJVj6dN
         qt/Md5oO+YijtG1jxlcYCNz8CSeGzQHva/Ueg98ScJztyBcL40BCksrcZ+g/w0Q3rIjM
         aXOX2nbN7Tbp/6BC6jXMRy0MTWLm6Otcx4FmYO4pE428nEI8BFyzQLmXW032/PiRr9Lg
         pD96j7Du5OlEnbocEjAh1gz1QgkqlNnQYDi8U56tKEQpmLzCKXbWqbCbNH91b2dmYl7G
         377w==
X-Forwarded-Encrypted: i=1; AJvYcCXTsYq2IdKwxjJpJRP6bPrPuFvXhetnUVcm1rfn/HdsSy2rZ2vd7/gbAeJ2/CmpBoLiq8yu8mG9E/erd2B3@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ86wK2kdYWWm75vhxOtrBTXaqTaprZCIVHeO64DieM/0f18t4
	P/3ICZN59E7f1TPcCrNSn0GIyyBlZrz43SVO/bwfP3F4afgEXBW8TpYlxy6xNJs=
X-Gm-Gg: ASbGnctmOWdRPoT1nQ6OMjS712CURaAbscUsFS6rDlb6FJvf5qIATuHjrl+EsYUB0rk
	o/ZyyRPpcHjklQQhHHjRtIhWOVum84+2VbmG5SikfwIiei2PmLj/YTvivL7wa3Gix96wTUTmWs1
	T7F/k5NYxvW1hmzZhU5kj10LG+BngbWN2rtP2e50t1H05B0cP3eWWvgN0DictMtuDTKtwee7VYZ
	fEYzjHcHxLnpae76R3V/6YvC9IgFl9CNtNdOhvMxSfE70NZzdK64wJXSv/kxvd8/c0lt8QGq5bl
	uKH+vAn89DjPLKAJ3P5GMbtR+2p2kenoEde8HMsST+RVuGQl
X-Google-Smtp-Source: AGHT+IFTHVjvMm7SI9zG+YTo6xP+VuwjrIfNbL14H9cY5sGUQSewGH6hwjaZZsvjM4ZfhfO2SM4RNA==
X-Received: by 2002:a05:6000:18ac:b0:39c:13fa:3e0 with SMTP id ffacd0b85a97d-39d87adcd02mr1983393f8f.9.1744283080239;
        Thu, 10 Apr 2025 04:04:40 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:7d22:13bb:e539:15ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89361186sm4476526f8f.14.2025.04.10.04.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 13:04:39 +0200
Message-Id: <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "Zong Li"
 <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov"
 <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Arnd Bergmann"
 <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>, "Eric Biederman"
 <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann Horn"
 <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v12 05/28] riscv: usercfi state for task and
 save/restore of CSR_SSP on trap entry/exit
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>

2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> @@ -62,6 +62,9 @@ struct thread_info {
>  	long			user_sp;	/* User stack pointer */
>  	int			cpu;
>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
> +#ifdef CONFIG_RISCV_USER_CFI
> +	struct cfi_status	user_cfi_state;
> +#endif

I don't think it makes sense to put all the data in thread_info.
kernel_ssp and user_ssp is more than enough and the rest can comfortably
live elsewhere in task_struct.

thread_info is supposed to be as small as possible -- just spanning
multiple cache-lines could be noticeable.

> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> @@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
> =20
>  	REG_L s0, TASK_TI_USER_SP(tp)
>  	csrrc s1, CSR_STATUS, t0
> +	/*
> +	 * If previous mode was U, capture shadow stack pointer and save it awa=
y
> +	 * Zero CSR_SSP at the same time for sanitization.
> +	 */
> +	ALTERNATIVE("nop; nop; nop; nop",
> +				__stringify(			\
> +				andi s2, s1, SR_SPP;	\
> +				bnez s2, skip_ssp_save;	\
> +				csrrw s2, CSR_SSP, x0;	\
> +				REG_S s2, TASK_TI_USER_SSP(tp); \
> +				skip_ssp_save:),
> +				0,
> +				RISCV_ISA_EXT_ZICFISS,
> +				CONFIG_RISCV_USER_CFI)

(I'd prefer this closer to the user_sp and kernel_sp swap, it's breaking
 the flow here.  We also already know if we've returned from userspace
 or not even without SR_SPP, but reusing the information might tangle
 the logic.)

>  	csrr s2, CSR_EPC
>  	csrr s3, CSR_TVAL
>  	csrr s4, CSR_CAUSE
> @@ -236,6 +250,18 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>  	csrw CSR_SCRATCH, tp
> +
> +	/*
> +	 * Going back to U mode, restore shadow stack pointer
> +	 */

Are we?  I think we can be just as well returning back to kernel-space.
Similar to how we can enter the exception handler from kernel-space.

> +	ALTERNATIVE("nop; nop",
> +				__stringify(					\
> +				REG_L s3, TASK_TI_USER_SSP(tp); \
> +				csrw CSR_SSP, s3),
> +				0,
> +				RISCV_ISA_EXT_ZICFISS,
> +				CONFIG_RISCV_USER_CFI)
> +

Thanks.

