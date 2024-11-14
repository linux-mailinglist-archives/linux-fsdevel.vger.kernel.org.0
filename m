Return-Path: <linux-fsdevel+bounces-34714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2809C7FF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 02:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA44282E55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28ED1E3DF2;
	Thu, 14 Nov 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kc3Pr9L4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC4225A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547507; cv=none; b=g+U3YM+OK44yItZLRq4CPdw73sqjPgcJn6XsdDzjLV99vLsRoGODuqFjYxVbcMkkVXI5FDbGDkRYvU8pY7XRG/Y3ph59INIzn9ykktEWFiBy0kS09b/x1FrUWJO0MH4KB3U9rIxNh8dk5Uf6VXD9hlw+4YqpTG7GZJlU3dOAa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547507; c=relaxed/simple;
	bh=KuTm9w2zxcDezkdUUDDcRZEA8jG2I3LDnWFoZ2iSzow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4ce1KcnqUK8jvxyJmp8R83uILELc4JxQ2nMhbt324cnfnx2jcb1OV0wB6dfx5r+PxiH/OTBzDVbdAnS/0WgBkh6wfbbiS9SVGPYyzZo1WTGMcdGI8AONxwIvVsV/rQBvjQJuphYEdj/UGnT9HgMIgZ0doq2eEDN2W/6aUy5px4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kc3Pr9L4; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e60d3adecbso37454b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 17:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731547504; x=1732152304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7tgZBsjLXLWa/QitrFWyk7TGNAjpHhq1mYxI46BDfkY=;
        b=kc3Pr9L4U/mCNeeKgyr1pVx7bTPwK/iiUuB3bCqSVPR8yQnGmxnNcSzGBXynbBOKJI
         rIs2ETYzVDryfh2Vnngj+AEUu+H+TEucLsxmMWEpzw9GjdV48lOu/cxU1SDBIoUGhvzG
         kjtS9dLIU6PslaSlg771p3hgjgGCFYXtBElCzn0OxVpzed4M8W5WgNg6Wn5x0/K9d5sW
         Diz8zOtxP3F+Xwk3AG8YTKXk/K149yBDUO+pTa7Qv7UQ1pJtZ1ncPCkAUI/nV/oZEt4s
         aoUcUgxvJtncGsen981ef/fzcM40I/hlTCfUOfEQPvfHI9OigpQ3h5W3cIYQEKsV95X7
         gGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731547504; x=1732152304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tgZBsjLXLWa/QitrFWyk7TGNAjpHhq1mYxI46BDfkY=;
        b=V2VDRsuFHOkEssdpAijG3Q4hKoUhlyukN6B8EQXwx3aczWeJ74I7atPMZ3yNvGhkFf
         xKm05tR3R8l/A/C9txjGQtkzZF8W1x2g3tm2I6eGhfY+IKtxFA1fuvJTEoiV0Exbcpq3
         bvPZeOPVw9l+PEpj4O/gf1XaLfpvlPC40vCuqOdAsXf0wYRlOdt1rZEAG9J44qxhnxLB
         7YijS//Hlo421BM9hFbW/R5azsCaGULswZUOhEL6eeCrzHbVm2ZoD0CYh1p/Doq+DXQ1
         uvDN1qMFv074mdDjgz6jPLUYyWYKAtTNj0/7f9qnMXH2qFk4K+t+gHtqnJpVFBr88vMq
         MLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHS124OJs6MxsdRKmU8LUFQhN8RQcRMhuSuHzBEiap3M3AoZxt81q5SeXWAC48MVbhbZbzn1WpyFGo5CbB@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcWZpFx8V88UJ9jbOkuA08xcsFaou1No14ks+f2004qZqr+4h
	KBRKGhRitXH7JjYcSnAy73Nt7mRikBao7IIKVNyMVCp0vnNYrX15SYZQP6dY7hQ=
X-Google-Smtp-Source: AGHT+IFYV+lyD6AUZ64wWkmaKdb2jE8s1l+YlxE25IyFaRji6Gg+al5X5KNPM0lWiRmirmHIFmzF1w==
X-Received: by 2002:a05:6808:2222:b0:3e6:22f:ea48 with SMTP id 5614622812f47-3e7b7bdede7mr481448b6e.28.1731547504098;
        Wed, 13 Nov 2024 17:25:04 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5bcad0sm11125410a12.32.2024.11.13.17.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 17:25:03 -0800 (PST)
Date: Wed, 13 Nov 2024 17:25:00 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Nick Hu <nick.hu@sifive.com>
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
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH v8 24/29] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Message-ID: <ZzVRbCZP9N4Os8Bj@debug.ba.rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
 <20241111-v5_user_cfi_series-v8-24-dce14aa30207@rivosinc.com>
 <CAKddAkCCVjNHUinPWtOiK8Ki_ZkdoUCawfv1-+0B69J_1aJv5Q@mail.gmail.com>
 <ZzVNKvCu4MOs7O5z@debug.ba.rivosinc.com>
 <CAKddAkDbGYeONaksq6fzLzx47BHZo3Ar7Sog3MOgf7Y+Birovw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKddAkDbGYeONaksq6fzLzx47BHZo3Ar7Sog3MOgf7Y+Birovw@mail.gmail.com>

On Thu, Nov 14, 2024 at 09:20:14AM +0800, Nick Hu wrote:
>Hi Deepak
>
>On Thu, Nov 14, 2024 at 9:06 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Thu, Nov 14, 2024 at 12:13:38AM +0800, Nick Hu wrote:
>> >Hi Deepak
>> >
>> >On Tue, Nov 12, 2024 at 5:08 AM Deepak Gupta <debug@rivosinc.com> wrote:
>> >>
>> >> Kernel will have to perform shadow stack operations on user shadow stack.
>> >> Like during signal delivery and sigreturn, shadow stack token must be
>> >> created and validated respectively. Thus shadow stack access for kernel
>> >> must be enabled.
>> >>
>> >> In future when kernel shadow stacks are enabled for linux kernel, it must
>> >> be enabled as early as possible for better coverage and prevent imbalance
>> >> between regular stack and shadow stack. After `relocate_enable_mmu` has
>> >> been done, this is as early as possible it can enabled.
>> >>
>> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> >> ---
>> >>  arch/riscv/kernel/asm-offsets.c |  4 ++++
>> >>  arch/riscv/kernel/head.S        | 12 ++++++++++++
>> >>  2 files changed, 16 insertions(+)
>> >>
>> >> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>> >> index 766bd33f10cb..a22ab8a41672 100644
>> >> --- a/arch/riscv/kernel/asm-offsets.c
>> >> +++ b/arch/riscv/kernel/asm-offsets.c
>> >> @@ -517,4 +517,8 @@ void asm_offsets(void)
>> >>         DEFINE(FREGS_A6,            offsetof(struct ftrace_regs, a6));
>> >>         DEFINE(FREGS_A7,            offsetof(struct ftrace_regs, a7));
>> >>  #endif
>> >> +       DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
>> >> +       DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
>> >> +       DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
>> >> +       DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
>> >>  }
>> >> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> >> index 356d5397b2a2..6244408ca917 100644
>> >> --- a/arch/riscv/kernel/head.S
>> >> +++ b/arch/riscv/kernel/head.S
>> >> @@ -164,6 +164,12 @@ secondary_start_sbi:
>> >>         call relocate_enable_mmu
>> >>  #endif
>> >>         call .Lsetup_trap_vector
>> >> +       li a7, SBI_EXT_FWFT
>> >> +       li a6, SBI_EXT_FWFT_SET
>> >> +       li a0, SBI_FWFT_SHADOW_STACK
>> >> +       li a1, 1 /* enable supervisor to access shadow stack access */
>> >> +       li a2, SBI_FWFT_SET_FLAG_LOCK
>> >> +       ecall
>> >>         scs_load_current
>> >>         call smp_callin
>> >>  #endif /* CONFIG_SMP */
>> >> @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
>> >>         la tp, init_task
>> >>         la sp, init_thread_union + THREAD_SIZE
>> >>         addi sp, sp, -PT_SIZE_ON_STACK
>> >> +       li a7, SBI_EXT_FWFT
>> >> +       li a6, SBI_EXT_FWFT_SET
>> >> +       li a0, SBI_FWFT_SHADOW_STACK
>> >> +       li a1, 1 /* enable supervisor to access shadow stack access */
>> >> +       li a2, SBI_FWFT_SET_FLAG_LOCK
>> >> +       ecall
>> >>         scs_load_current
>> >>
>> >>  #ifdef CONFIG_KASAN
>> >>
>> >> --
>> >> 2.45.0
>> >>
>> >Should we clear the SBI_FWFT_SET_FLAG_LOCK before the cpu hotplug
>> >otherwise the menvcfg.sse won't be set by the fwft set sbi call when
>> >the hotplug cpu back to kernel?
>>
>> Hmm...
>>
>> An incoming hotplug CPU has no features setup on it.
>> I see that `sbi_cpu_start` will supply `secondary_start_sbi` as start
>> up code for incoming CPU. `secondary_start_sbi` is in head.S which converges
>> in `.Lsecondary_start_common`. And thus hotplugged CPU should be
>> issuing shadow stack set FWFT sbi as well.
>>
>> Am I missing something ?
>>
>This is the correct flow. However the opensbi will deny it due to the
>SBI_FWFT_SET_FLAG_LOCK already being set.
>So the menvcfg.sse will not set by this flow.
>
>if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
>                return SBI_EDENIED;
>

hmm... Why?

`conf` is pointing to per-hart state in firmware.

On this incoming cpu, opensbi (or equivalent) firmware must have
ensured that this per-hart state doesn't have lock set.

Am I missing something?

>Regards,
>Nick
>> >
>> >Regards,
>> >Nick
>> >>
>> >> _______________________________________________
>> >> linux-riscv mailing list
>> >> linux-riscv@lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/linux-riscv

