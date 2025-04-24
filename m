Return-Path: <linux-fsdevel+bounces-47286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01268A9B5EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 20:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28C3175C3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97728EA77;
	Thu, 24 Apr 2025 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BrzPX+ns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266EE28B4E1
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517845; cv=none; b=REF9vROc7DkIo9knbqmlf62efVzhEUNh2XoS61IIWF3qc1EK18TWLHuJYXKe2i4nlcugMRqlLW1Dra3c0X4aw5smNy3+DpbrQnfbfI984HpY96QEpqQ6HB5DAb+SAe4+gs/CH3FbeujgTmlluzpnOAclaNuRUTQMR/nlNi7OQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517845; c=relaxed/simple;
	bh=uPn6plOz3AG5jrEfFpRZaDs6P0aP85UrPumlULvK+r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEZfw+HGaD6SK2ap55QVjPFqMQt5gC2q3iNb8N1olRFl1Fsl8ILz9uAydTMQnLvnJYJ39ZmmQaGhtLnCRD9v3aVGwC5GK/j7LeKWcFxzYhTKGwUFzKxgdb6wvHAoO0hQSpRgcfOIqsau2YnVQP8M8we7uiJ7Z54ouhY2FryUIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BrzPX+ns; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224191d92e4so15804725ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745517843; x=1746122643; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R+2ifGTP7Zuk1f3PGxpKoh8D1eRLE/ZHAefBGZIpiLo=;
        b=BrzPX+nsbBbhPpijNsceUyyDomfenzy/7GbMN64AroqKTxoylv2ovD6hn0CRWqBlxs
         ulrrWRaiMYzHEdGqjtf/3RqjjwY6kRG5bEvpPsloj2x6unflxrvd7OZeFcolPB3CVKBE
         eupWPZWQUEaGbsD7rKhdEueNm0qf1/qtRRW05uUzXnvTB3AKt5nuHzXOrHtTr5XnD6Ri
         jXZraAzv+36aPvl7LB8SMNA+JU/JJaS+pw30Qwz7cznpfAC76YlfziI4Qwx4v8iXAy2a
         O6FSsZL5LpnN3TihyjvB5S0s3dnYShOd4bWtKX7O65OT7pbg3b2/Gk0NB+qX7HIv4Jmr
         bHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745517843; x=1746122643;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+2ifGTP7Zuk1f3PGxpKoh8D1eRLE/ZHAefBGZIpiLo=;
        b=sax0FVBHpNMDnRbkucLTv2mLTz6D57Zp3h7Ih6gaHdtoeGQ3sNBazzX2g7gwM0YbZu
         gjqdWU/hOWVzZSIa5iLgNfC+xg9VKG/XMsw6nJURctFmFNVB6DxDOOXs8r5GXJZt8Zse
         Lk8FaZMmPlX4SjHn7uyu3c/fjh9xCuMwxRg29sbj0hDofIcOk2eJVZpBPISu/aRVKUjY
         3KkuIUS+Yis/Nl4eiyx90xnyWcNJkbnuofBnf2zVNCejCZlB4E9xcaFtsez0gOYO6eFo
         KUi7nQn++4iFGioJRx1ITNlTt1RZzuLiZ4kzOEPKBWj1XQhJvf6SG3wIFecrS8RH5/oX
         sGoA==
X-Forwarded-Encrypted: i=1; AJvYcCUBEV1ltBk7Ic/CdD341xCglRc03o/8psI6Z0EjIClOGwz+EMLWFs981F+Dh6HlndyT9fUyMtRDVGQdl0S9@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAU2ArVW3qQ8gJcbVYH/J6GwFiOu7lWuq1Zqak3Av23oxGSNR
	K9En3jvj3kEJQ6Q8QLtiS0IDIzZHOtL7gvo3Ei4Eadqp1RUq8YVeUh825TeZmIo=
X-Gm-Gg: ASbGncsPa0J+udgzn1p0YZbgSaBQimKERRl/jBJmVSjlw0X4y0nhB0hL1o2vm8ICs1z
	bn7Ime+6EtYtQ1pc86wigXqzlCddlPTcEFQxn1YU9R1Dkm3qFxn9cJoJZ8GOofUVc/bSLACSSZx
	sqhQU6tSYHHETMJq+6htq6GG9XAoC0Nlq+kETaHcm+l8EBs6pr+sbLrAnZIOfIE6W1MV0Xl3daF
	xFHtb58J4HJeGE+lrBczlWzASlg61zZSnCWiqdLrW8hzSs6E/Bu4LEOrhuUv4DIpkJ8h7FhtoPA
	eLQT7VN1dQvaOiGc6pE47ILITKNxt8sG/umEzGW2QhGFTnmp6W0WjVAIQKn2Vg==
X-Google-Smtp-Source: AGHT+IEwApZFffChVQ3IgP8GwvBv+BNm7qJFv/s7tyP4mivow/7aAesEdu2H5hIh83xgouvcI3whKA==
X-Received: by 2002:a17:902:cec8:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-22dbd46edccmr5459035ad.45.1745517843026;
        Thu, 24 Apr 2025 11:04:03 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f7ec0bb2sm1513897a12.18.2025.04.24.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:04:02 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:03:59 -0700
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
Message-ID: <aAp9D7txw8y9WL5m@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
 <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>
 <aAmEnK0vSgZZOORL@debug.ba.rivosinc.com>
 <D9EV1K8ZQQJR.20CRTYLQBN9UE@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9EV1K8ZQQJR.20CRTYLQBN9UE@ventanamicro.com>

On Thu, Apr 24, 2025 at 02:16:32PM +0200, Radim Krčmář wrote:
>2025-04-23T17:23:56-07:00, Deepak Gupta <debug@rivosinc.com>:
>> On Thu, Apr 10, 2025 at 01:04:39PM +0200, Radim Krčmář wrote:
>>>2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>>> @@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
>>>>
>>>>  	REG_L s0, TASK_TI_USER_SP(tp)
>>>>  	csrrc s1, CSR_STATUS, t0
>>>> +	/*
>>>> +	 * If previous mode was U, capture shadow stack pointer and save it away
>>>> +	 * Zero CSR_SSP at the same time for sanitization.
>>>> +	 */
>>>> +	ALTERNATIVE("nop; nop; nop; nop",
>>>> +				__stringify(			\
>>>> +				andi s2, s1, SR_SPP;	\
>>>> +				bnez s2, skip_ssp_save;	\
>>>> +				csrrw s2, CSR_SSP, x0;	\
>>>> +				REG_S s2, TASK_TI_USER_SSP(tp); \
>>>> +				skip_ssp_save:),
>>>> +				0,
>>>> +				RISCV_ISA_EXT_ZICFISS,
>>>> +				CONFIG_RISCV_USER_CFI)
>>>
>>>(I'd prefer this closer to the user_sp and kernel_sp swap, it's breaking
>>> the flow here.  We also already know if we've returned from userspace
>>> or not even without SR_SPP, but reusing the information might tangle
>>> the logic.)
>>
>> If CSR_SCRATCH was 0, then we would be coming from kernel else flow goes
>> to `.Lsave_context`. If we were coming from kernel mode, then eventually
>> flow merges to `.Lsave_context`.
>>
>> So we will be saving CSR_SSP on all kernel -- > kernel trap handling. That
>> would be unnecessary. IIRC, this was one of the first review comments in
>> early RFC series of these patch series (to not touch CSR_SSP un-necessarily)
>>
>> We can avoid that by ensuring when we branch by determining if we are coming
>> from user to something like `.Lsave_ssp` which eventually merges into
>> ".Lsave_context". And if we were coming from kernel then we would branch to
>> `.Lsave_context` and thus skipping ssp save logic. But # of branches it
>> introduces in early exception handling is equivalent to what current patches
>> do. So I don't see any value in doing that.
>>
>> Let me know if I am missing something.
>
>Right, it's hard to avoid the extra branches.
>
>I think we could modify the entry point (STVEC), so we start at
>different paths based on kernel/userspace trap and only jump once to the
>common code, like:
>
>  SYM_CODE_START(handle_exception_kernel)
>    /* kernel setup magic */
>    j handle_exception_common
>  SYM_CODE_START(handle_exception_user)
>    /* userspace setup magic */
>  handle_exception_common:

Hmm... This can be done. But then it would require to constantly modify `stvec`
When you're going back to user mode, you would have to write `stvec` with addr
of `handle_exception_user`. But then you can easily get a NMI. It can become
ugly. Needs much more thought and on first glance feels error prone.

Only if we have an extension that allows different trap address depending on
mode you're coming from (arm does that, right?, I think x86 FRED also does
that)
>
>This is not a suggestion for this series.  I would be perfectly happy
>with just a cleaner code.
>
>Would it be possible to hide the ALTERNATIVE ugliness behind a macro and
>move it outside the code block that saves pt_regs?

Sure, I'll do something about it.

>
>Thanks.

