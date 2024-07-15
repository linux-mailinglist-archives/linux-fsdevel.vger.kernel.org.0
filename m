Return-Path: <linux-fsdevel+bounces-23654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 081CF930F12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89937B20BAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC841836E6;
	Mon, 15 Jul 2024 07:48:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698D175A6
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029691; cv=none; b=d3VB5pre4pjajdSfqW5dQLvjxUhT29gsS5QPz7hNB2cWv1khyV2X86HQP1OqJVRyMzYc/BVxx45ebXagRZe2qDkygthXGlvz7orzNUSwpO8lYn0wrEfyNzbusgUkdSwrY2pYJ2e4ZjZkTFfMcbYYd4nS8JtDLpYAoIkKIF9cw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029691; c=relaxed/simple;
	bh=1pMkTE75Vkk2dD+G2zhGUTNEcvxrzQB8YvWAwtdPrmo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PDCFuUUyAxk4XM/YH7rSNHkt4hllRyWc2cwfNV/XDks4oeh63zPpxrv93Ga6X9al0aGlidl1nnJQKN+G1ngRkeE5NavlSabiyvQuxNeJr0TW4YkvCENP7FV9Z50T/0SmT1P+Mvgo/tqUe2FhOW03gs6FVE+Oy3JMnQNTtbTCefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E370FEC;
	Mon, 15 Jul 2024 00:48:35 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 734203F762;
	Mon, 15 Jul 2024 00:48:01 -0700 (PDT)
Message-ID: <cdd1a416-2b58-4583-9220-03988f22bece@arm.com>
Date: Mon, 15 Jul 2024 13:17:58 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 05/29] arm64: cpufeature: add Permission Overlay
 Extension cpucap
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
 <20240503130147.1154804-6-joey.gouly@arm.com>
Content-Language: en-US
In-Reply-To: <20240503130147.1154804-6-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> This indicates if the system supports POE. This is a CPUCAP_BOOT_CPU_FEATURE
> as the boot CPU will enable POE if it has it, so secondary CPUs must also
> have this feature.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 9 +++++++++
>  arch/arm64/tools/cpucaps       | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 56583677c1f2..2f3c2346e156 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2861,6 +2861,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_nv1,
>  		ARM64_CPUID_FIELDS_NEG(ID_AA64MMFR4_EL1, E2H0, NI_NV1)
>  	},
> +#ifdef CONFIG_ARM64_POE
> +	{
> +		.desc = "Stage-1 Permission Overlay Extension (S1POE)",
> +		.capability = ARM64_HAS_S1POE,
> +		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
> +		.matches = has_cpuid_feature,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1POE, IMP)
> +	},
> +#endif
>  	{},
>  };
>  
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 62b2838a231a..45f558fc0d87 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -45,6 +45,7 @@ HAS_MOPS
>  HAS_NESTED_VIRT
>  HAS_PAN
>  HAS_S1PIE
> +HAS_S1POE
>  HAS_RAS_EXTN
>  HAS_RNG
>  HAS_SB

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

