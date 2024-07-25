Return-Path: <linux-fsdevel+bounces-24255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E2393C6BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322651C22113
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236919D07A;
	Thu, 25 Jul 2024 15:46:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1DC18028
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922410; cv=none; b=FB17qU5/Zai1EqL4g9am3tC/3W17UTVhv9pzyjda1t0e/JsQbzb3wi8JNDtrOLMozmcJVlJqN30CDnRoCAqtaFxuG077lNgLsh930qM+T5Yjn2IthNo5OHxmv4NHviC6Jnisg7K74SHeIl7pjVPnqeNrBhyU3oWbuOmEXigbnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922410; c=relaxed/simple;
	bh=QySE1k+j48N1zcKz4Su6fuR31Gl9vRm0LjtVqvlNuxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/XRx4oczcW02Q2XMUP7TR5mVmCzK6Prxm1lzqS5RF+S3QFltTc7s9l8bHON1SfGwmPNJ4mqAe3jHETuRCIv23CA0VZZ92v2yY9JuoL+9N2v8/JQpskSSFxjj97vaWWHJH+kulghB9NMsGDG5ConPTk3bxIKguC5IfkXhR/BsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 587921476;
	Thu, 25 Jul 2024 08:47:12 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F4C63F766;
	Thu, 25 Jul 2024 08:46:43 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:46:40 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 06/29] arm64: context switch POR_EL0 register
Message-ID: <ZqJzYGyqd82EgQ17@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-7-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-7-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:24PM +0100, Joey Gouly wrote:
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

[...]

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

See my comment on permission_overlay_switch(), below.  However, exec is
slower path code, so including the ISB may be better here than leaving
it for the caller to worry about.

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

Was POR_EL0 ever reset to something sensible at all?  Does it matter?

(I couldn't find this, but may have missed it.)

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

Do we really need an extra ISB slap in the middle of context switch?

(i.e., should any uaccess ever happen until context switch is completed,
and so can we coalesce this ISB with a later one?)

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

[...]

Cheers
---Dave

