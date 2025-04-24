Return-Path: <linux-fsdevel+bounces-47146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C5AA99CE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 02:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5A31940CDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 00:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377712E5B;
	Thu, 24 Apr 2025 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GZA3w2dg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD72701C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454243; cv=none; b=pFFS43FD4prpyQzNUa3oCA7B6i6tjueoBAMIZ+nPztYT/MeOBJPd1UiBsySwXPaY4hMRZtMP0pOgFfDgIllrDfu5hZt7Y/bJf/qWEh2Kx+uQzrNXK3MBuWhpplGCRRRe4vFuFT7s1zkggkKU2n5Dti3O5JsRBKqhJ0kSva5HlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454243; c=relaxed/simple;
	bh=crPxcnf9+OekJ0yxWQkSZVs8fIhnC61OsBU4Yac1+T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knctQRua1MODyGx8rXJAQEYfQErENZV6k9mmMQsL3i72z3izGqKiI5B0OiGx4WmQbdNorn3vNahF+f1+zH271KYfDEjUdRqLMM1oNIHOREDYl31xwiLYhcgUVAHpzUwpDEmo6Q/JxBVoOr/O48RPNNd/qVUVVe0SrIIDBhQxwJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GZA3w2dg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227d6b530d8so4444585ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 17:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745454241; x=1746059041; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lGbM0o/TGPFqR3aQeqhm8zgtQt8YivoCdhsm3mycjoo=;
        b=GZA3w2dgGW8YMq0XVdH2+lQC+vKKLrrn7g6YoibqT5TiQDXC7ubvAqIzI+hVn9b796
         p+mtsu5ZtljLsBu24+nupMyIdZPqT+6R761m/fNAXtrFXOw9B3F0yRJ9AQJUiiGKvCZq
         wJ9ldSyDoYsHootW3/3GC9LXfqxE1wfQ0NFdhjLtZwRMW+VCr6kwjG6ofmkeUpCw60kR
         D6HKqAVZiBrdwJSbOg5B9jaM3D68GkVFaBhu3PWfEcjU5Nz9Quj5xcqXLA1CP53w17eg
         6DFHFfxMr0AkR9RFPPpm2+tlxxv7tPUGP8HcpPmSceHOatP/yfboxcHRf2guwmxHNQ14
         pzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745454241; x=1746059041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGbM0o/TGPFqR3aQeqhm8zgtQt8YivoCdhsm3mycjoo=;
        b=cXLKzmgj95+A7FogrBWs5JJYILLV661pYSeqHJ8jVzKFXiiUSyu7lX8gt0/tGIt4Su
         /laDf7KUSGlY5jbL7hSSPaBIAMhul++/5Up8iDUfyGNU62wBed4rupYCCmNRBbX2uYM/
         RGluTcUGLR6z7wCKrxQyxUu1rPpK2uDfmirZBCec93yV6M9rxgUMGhlLgSGsVWF5h/LO
         R+986Tk0asW3CABiBp6TpqP6yGBT7QvgoPbEU1MToC4i966iKFgbo8r9HkpMSh66aMVK
         uygUmB2jT3tz3kN1YVXBfMwS+8J5AmYzQD+Ov3lSZQKgjLRu0Um8UE8Cra8TLJCuU7Wr
         1pOw==
X-Forwarded-Encrypted: i=1; AJvYcCXt39ymDsazxh0XWYhCU04yhoPKmzyJqyj/2L1buhWzbO5Xt9vfI4IWpYJ2o1YHFAHIkDe0OuctojFZyaLH@vger.kernel.org
X-Gm-Message-State: AOJu0Yye9YLMqjb3Ct3+JsuWm5bNthkFdlx4Vw/m6WPkWouzY7VvWrKc
	s6IdvWBnQKuAtvPsfV1N90D94GiF2/WD40URCJZU35AUhTGqi3sKBtaP4SBDDPs=
X-Gm-Gg: ASbGncsMLvlnU3vYzJ1ncuaiZXwHicK0ccTTytc/GJepEYBldjft2mWAAbjn+yvquH6
	Dug6ap7SNjGQdLTXewLo83bHWG58uc2pNHUvw1WJUyefI8yllwN16iJmpA+O61EH6KkVdkqYCKG
	XeKb5+Kc8gsplK7VytgBuDlN+Q2ev9y4CohF4oUvewZkkaYy3Yo2gWteyM6T9zv09tcrBOtZCQp
	lvqTRjQzIXx2WW/8+c3e2OzdPb2VZB5h/cRBPTZoKRVet2YMtkLC2R+y+6U9S2nOHC30viIWqnz
	FN/Y/wSBUo0/MsijOt3JIZG9wmiWu263y+HXURUBqX7cw05tfiw=
X-Google-Smtp-Source: AGHT+IGyYV/yzfLVnA9w34LRw7jQyIRxTFaioHQFl6p52L2kjU27J0WT2xyCuQTG4x/GFtq73xmJJA==
X-Received: by 2002:a17:903:1103:b0:22c:3609:97ed with SMTP id d9443c01a7336-22db3c3a039mr6299555ad.30.1745454240827;
        Wed, 23 Apr 2025 17:24:00 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5103259sm672675ad.185.2025.04.23.17.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:24:00 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:23:56 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v12 05/28] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Message-ID: <aAmEnK0vSgZZOORL@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
 <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>

Sorry forgot to respond to rest of your comments on this thread.


On Thu, Apr 10, 2025 at 01:04:39PM +0200, Radim Krčmář wrote:
>2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>> @@ -62,6 +62,9 @@ struct thread_info {
>>  	long			user_sp;	/* User stack pointer */
>>  	int			cpu;
>>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>> +#ifdef CONFIG_RISCV_USER_CFI
>> +	struct cfi_status	user_cfi_state;
>> +#endif

<... snipped ...>

>
>
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> @@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
>>
>>  	REG_L s0, TASK_TI_USER_SP(tp)
>>  	csrrc s1, CSR_STATUS, t0
>> +	/*
>> +	 * If previous mode was U, capture shadow stack pointer and save it away
>> +	 * Zero CSR_SSP at the same time for sanitization.
>> +	 */
>> +	ALTERNATIVE("nop; nop; nop; nop",
>> +				__stringify(			\
>> +				andi s2, s1, SR_SPP;	\
>> +				bnez s2, skip_ssp_save;	\
>> +				csrrw s2, CSR_SSP, x0;	\
>> +				REG_S s2, TASK_TI_USER_SSP(tp); \
>> +				skip_ssp_save:),
>> +				0,
>> +				RISCV_ISA_EXT_ZICFISS,
>> +				CONFIG_RISCV_USER_CFI)
>
>(I'd prefer this closer to the user_sp and kernel_sp swap, it's breaking
> the flow here.  We also already know if we've returned from userspace
> or not even without SR_SPP, but reusing the information might tangle
> the logic.)

If CSR_SCRATCH was 0, then we would be coming from kernel else flow goes
to `.Lsave_context`. If we were coming from kernel mode, then eventually
flow merges to `.Lsave_context`.

So we will be saving CSR_SSP on all kernel -- > kernel trap handling. That
would be unnecessary. IIRC, this was one of the first review comments in
early RFC series of these patch series (to not touch CSR_SSP un-necessarily)

We can avoid that by ensuring when we branch by determining if we are coming
from user to something like `.Lsave_ssp` which eventually merges into
".Lsave_context". And if we were coming from kernel then we would branch to
`.Lsave_context` and thus skipping ssp save logic. But # of branches it
introduces in early exception handling is equivalent to what current patches
do. So I don't see any value in doing that.

Let me know if I am missing something.

>
>>  	csrr s2, CSR_EPC
>>  	csrr s3, CSR_TVAL
>>  	csrr s4, CSR_CAUSE
>> @@ -236,6 +250,18 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>>  	csrw CSR_SCRATCH, tp
>> +
>> +	/*
>> +	 * Going back to U mode, restore shadow stack pointer
>> +	 */
I can remove my comment because it's obvious.

>
>Are we?  I think we can be just as well returning back to kernel-space.
>Similar to how we can enter the exception handler from kernel-space.

Yes we are. See excerpt from `ret_from_exception` in `entry.S`

"""
SYM_CODE_START_NOALIGN(ret_from_exception)
	REG_L s0, PT_STATUS(sp)
#ifdef CONFIG_RISCV_M_MODE
	/* the MPP value is too large to be used as an immediate arg for addi */
	li t0, SR_MPP
	and s0, s0, t0
#else
	andi s0, s0, SR_SPP
#endif
	bnez s0, 1f

<... snipped ...>

	/*
	 * Going back to U mode, restore shadow stack pointer
	 */
	ALTERNATIVE("nops(2)",
				__stringify(			\
				REG_L s3, TASK_TI_USER_SSP(tp); \
				csrw CSR_SSP, s3),
				0,
				RISCV_ISA_EXT_ZICFISS,
				CONFIG_RISCV_USER_CFI)

1:
#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
	move a0, sp
	call riscv_v_context_nesting_end

<... snipped ...>

"""


>
>> +	ALTERNATIVE("nop; nop",
>> +				__stringify(					\
>> +				REG_L s3, TASK_TI_USER_SSP(tp); \
>> +				csrw CSR_SSP, s3),
>> +				0,
>> +				RISCV_ISA_EXT_ZICFISS,
>> +				CONFIG_RISCV_USER_CFI)
>> +
>
>Thanks.

