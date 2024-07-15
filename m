Return-Path: <linux-fsdevel+bounces-23659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEAC930FB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65AD1F21C65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8821849CD;
	Mon, 15 Jul 2024 08:27:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589A218307B
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032044; cv=none; b=gdcdSxWozcjU3ZJrgGhZOmfqze+8Nc+dI+DWcLqGf17shdL0gN070QjWa1pZ6P9ueV7UGL7QHieztOKf+Ikcz0waro2t+LO+qXyAjxCwkJrglS/0AKSDb8p9KtO+vi4ezN/d6jfg6JiiUWXtSgI1OUPDuBac9a+rHEd5sZ57aC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032044; c=relaxed/simple;
	bh=em5jtF4QhA4E4JRAOJ2H+fjhFeLkqBHVfqnIxHbTi/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjnuG4YV7bWx70IAt/VZwgmf71nFpaaCJk8naHZHDj1eWWVEh0oHTa4CrgfStOQcbehfF9B2Ec5nb0ZSycli2pDZJxamKJqd6z48pzungamt1xSmz9xKUNBTShwbkphPpfktvHyNzly/ucuXpscLTdxBT6zSZ+tVs93d0tbMWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E188ADA7;
	Mon, 15 Jul 2024 01:27:46 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 538F93F73F;
	Mon, 15 Jul 2024 01:27:12 -0700 (PDT)
Message-ID: <3c655663-3407-4602-a958-c5382a6b3133@arm.com>
Date: Mon, 15 Jul 2024 13:57:10 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/29] arm64: context switch POR_EL0 register
To: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
 catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org,
 szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org, x86@kernel.org,
 kvmarm@lists.linux.dev
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-7-joey.gouly@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240503130147.1154804-7-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> POR_EL0 is a register that can be modified by userspace directly,
> so it must be context switched.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/cpufeature.h |  6 ++++++
>  arch/arm64/include/asm/processor.h  |  1 +
>  arch/arm64/include/asm/sysreg.h     |  3 +++
>  arch/arm64/kernel/process.c         | 28 ++++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 8b904a757bd3..d46aab23e06e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -832,6 +832,12 @@ static inline bool system_supports_lpa2(void)
>  	return cpus_have_final_cap(ARM64_HAS_LPA2);
>  }
>  
> +static inline bool system_supports_poe(void)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_POE) &&

CONFIG_ARM64_POE has not been defined/added until now ?

> +		alternative_has_cap_unlikely(ARM64_HAS_S1POE);
> +}
> +
>  int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>  bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>  
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index f77371232d8c..e6376f979273 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -184,6 +184,7 @@ struct thread_struct {
>  	u64			sctlr_user;
>  	u64			svcr;
>  	u64			tpidr2_el0;
> +	u64			por_el0;
>  };

As there going to be a new config i.e CONFIG_ARM64_POE, should not this
register be wrapped up with #ifdef CONFIG_ARM64_POE as well ? Similarly
access into p->thread.por_el0 should also be conditional on that config.

>  
>  static inline unsigned int thread_get_vl(struct thread_struct *thread,
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 9e8999592f3a..62c399811dbf 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -1064,6 +1064,9 @@
>  #define POE_RXW		UL(0x7)
>  #define POE_MASK	UL(0xf)
>  
> +/* Initial value for Permission Overlay Extension for EL0 */
> +#define POR_EL0_INIT	POE_RXW

The idea behind POE_RXW as the init value is to be all permissive ?

> +
>  #define ARM64_FEATURE_FIELD_BITS	4
>  
>  /* Defined for compatibility only, do not add new users. */
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 4ae31b7af6c3..0ffaca98bed6 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -271,12 +271,23 @@ static void flush_tagged_addr_state(void)
>  		clear_thread_flag(TIF_TAGGED_ADDR);
>  }
>  
> +static void flush_poe(void)
> +{
> +	if (!system_supports_poe())
> +		return;
> +
> +	write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> +	/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> +	isb();
> +}
> +
>  void flush_thread(void)
>  {
>  	fpsimd_flush_thread();
>  	tls_thread_flush();
>  	flush_ptrace_hw_breakpoint(current);
>  	flush_tagged_addr_state();
> +	flush_poe();
>  }
>  
>  void arch_release_task_struct(struct task_struct *tsk)
> @@ -371,6 +382,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  		if (system_supports_tpidr2())
>  			p->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
>  
> +		if (system_supports_poe())
> +			p->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> +
>  		if (stack_start) {
>  			if (is_compat_thread(task_thread_info(p)))
>  				childregs->compat_sp = stack_start;
> @@ -495,6 +509,19 @@ static void erratum_1418040_new_exec(void)
>  	preempt_enable();
>  }
>  
> +static void permission_overlay_switch(struct task_struct *next)
> +{
> +	if (!system_supports_poe())
> +		return;
> +
> +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> +	if (current->thread.por_el0 != next->thread.por_el0) {
> +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> +		isb();
> +	}
> +}
> +
>  /*
>   * __switch_to() checks current->thread.sctlr_user as an optimisation. Therefore
>   * this function must be called with preemption disabled and the update to
> @@ -530,6 +557,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	ssbs_thread_switch(next);
>  	erratum_1418040_thread_switch(next);
>  	ptrauth_thread_switch_user(next);
> +	permission_overlay_switch(next);
>  
>  	/*
>  	 * Complete any pending TLB or cache maintenance on this CPU in case

