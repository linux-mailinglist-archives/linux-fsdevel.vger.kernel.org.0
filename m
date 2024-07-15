Return-Path: <linux-fsdevel+bounces-23665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACFB9310F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071202835AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B57A186297;
	Mon, 15 Jul 2024 09:13:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008C186E20
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034828; cv=none; b=BdyklugH5eFrqAKo+DOR/PcaZfbvg/dWwba5DlRu9kMEOCcnRA+TjZK2HuJlTSXAZe9G00SZJiN0serfS0coy0S33xuPxSxHDhXNZf0jp2cWJYF+a+b58iUITcRZulVnZmfYSu17yIqo2eMw0BSbJhQ5Fhp1ZxdXfB8GxGLnF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034828; c=relaxed/simple;
	bh=uKKsCy3XqPPs0ziZrTk3HoUUPsLvw8Kfwi7oxfL07d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBAOzqwvdR75RDKEFMlBKKNRNatI53rYjO+/9+byEuy/jnSfeFU3cf/VwgrbtHAZf1TxWxK6UeRr972RjXc8GPGoZL844M06MWIQQng+vc4p1Zm/7W1c9J9Jbdk++67O6u/YXKcYLgxoRzNDMZJRIYBKJ7pVnPP1gv+ft9zMuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE003DA7;
	Mon, 15 Jul 2024 02:14:09 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 622603F73F;
	Mon, 15 Jul 2024 02:13:27 -0700 (PDT)
Message-ID: <850c93dd-7cbe-4904-910e-a389884655d9@arm.com>
Date: Mon, 15 Jul 2024 14:43:24 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/29] arm64: enable the Permission Overlay Extension
 for EL0
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
 <20240503130147.1154804-11-joey.gouly@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240503130147.1154804-11-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> Expose a HWCAP and ID_AA64MMFR3_EL1_S1POE to userspace, so they can be used to
> check if the CPU supports the feature.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
> 
> This takes the last bit of HWCAP2, is this fine? What can we do about more features in the future?
> 
> 
>  Documentation/arch/arm64/elf_hwcaps.rst |  2 ++
>  arch/arm64/include/asm/hwcap.h          |  1 +
>  arch/arm64/include/uapi/asm/hwcap.h     |  1 +
>  arch/arm64/kernel/cpufeature.c          | 14 ++++++++++++++
>  arch/arm64/kernel/cpuinfo.c             |  1 +
>  5 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
> index 448c1664879b..694f67fa07d1 100644
> --- a/Documentation/arch/arm64/elf_hwcaps.rst
> +++ b/Documentation/arch/arm64/elf_hwcaps.rst
> @@ -365,6 +365,8 @@ HWCAP2_SME_SF8DP2
>  HWCAP2_SME_SF8DP4
>      Functionality implied by ID_AA64SMFR0_EL1.SF8DP4 == 0b1.
>  
> +HWCAP2_POE
> +    Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
>  
>  4. Unused AT_HWCAP bits
>  -----------------------
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 4edd3b61df11..a775adddecf2 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -157,6 +157,7 @@
>  #define KERNEL_HWCAP_SME_SF8FMA		__khwcap2_feature(SME_SF8FMA)
>  #define KERNEL_HWCAP_SME_SF8DP4		__khwcap2_feature(SME_SF8DP4)
>  #define KERNEL_HWCAP_SME_SF8DP2		__khwcap2_feature(SME_SF8DP2)
> +#define KERNEL_HWCAP_POE		__khwcap2_feature(POE)
>  
>  /*
>   * This yields a mask that user programs can use to figure out what
> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> index 285610e626f5..055381b2c615 100644
> --- a/arch/arm64/include/uapi/asm/hwcap.h
> +++ b/arch/arm64/include/uapi/asm/hwcap.h
> @@ -122,5 +122,6 @@
>  #define HWCAP2_SME_SF8FMA	(1UL << 60)
>  #define HWCAP2_SME_SF8DP4	(1UL << 61)
>  #define HWCAP2_SME_SF8DP2	(1UL << 62)
> +#define HWCAP2_POE		(1UL << 63)
>  
>  #endif /* _UAPI__ASM_HWCAP_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 2f3c2346e156..8c02aae9db11 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -465,6 +465,8 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_aa64mmfr3[] = {
> +	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_POE),
> +		       FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR3_EL1_S1POE_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR3_EL1_S1PIE_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR3_EL1_TCRX_SHIFT, 4, 0),
>  	ARM64_FTR_END,
> @@ -2339,6 +2341,14 @@ static void cpu_enable_mops(const struct arm64_cpu_capabilities *__unused)
>  	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_MSCEn);
>  }
>  
> +#ifdef CONFIG_ARM64_POE
> +static void cpu_enable_poe(const struct arm64_cpu_capabilities *__unused)
> +{
> +	sysreg_clear_set(REG_TCR2_EL1, 0, TCR2_EL1x_E0POE);
> +	sysreg_clear_set(CPACR_EL1, 0, CPACR_ELx_E0POE);
> +}
> +#endif
> +
>  /* Internal helper functions to match cpu capability type */
>  static bool
>  cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
> @@ -2867,6 +2877,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.capability = ARM64_HAS_S1POE,
>  		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
>  		.matches = has_cpuid_feature,
> +		.cpu_enable = cpu_enable_poe,
>  		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1POE, IMP)
>  	},
>  #endif
> @@ -3034,6 +3045,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>  	HWCAP_CAP(ID_AA64FPFR0_EL1, F8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8DP2),
>  	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E4M3, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E4M3),
>  	HWCAP_CAP(ID_AA64FPFR0_EL1, F8E5M2, IMP, CAP_HWCAP, KERNEL_HWCAP_F8E5M2),
> +#ifdef CONFIG_ARM64_POE
> +	HWCAP_CAP(ID_AA64MMFR3_EL1, S1POE, IMP, CAP_HWCAP, KERNEL_HWCAP_POE),
> +#endif
>  	{},
>  };
>  
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 09eeaa24d456..b9db812082b3 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -143,6 +143,7 @@ static const char *const hwcap_str[] = {
>  	[KERNEL_HWCAP_SME_SF8FMA]	= "smesf8fma",
>  	[KERNEL_HWCAP_SME_SF8DP4]	= "smesf8dp4",
>  	[KERNEL_HWCAP_SME_SF8DP2]	= "smesf8dp2",
> +	[KERNEL_HWCAP_POE]		= "poe",
>  };
>  
>  #ifdef CONFIG_COMPAT

This LGTM but as Joey mentioned earlier, what happens when another new
feature gets added later which needs to be exposed to userspace, add
HWCAP3 ?

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

