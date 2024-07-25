Return-Path: <linux-fsdevel+bounces-24258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E9C93C6CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 17:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2644E1C223C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF819D895;
	Thu, 25 Jul 2024 15:49:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178419B3E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922599; cv=none; b=PYNm8ptVaXD1LgKmlX+N/16q5aVjwTFu+Bo1TBIR0QrPzSC9DfRErpA/He4SmjjnGnQ6eUG4vlaGBHA4N1Y6deWAvD/8ZkIbR2NoyG25i9AccfNYQX23M2EI30e0herfPqgzJfmW4j+MVzd8nF7jJPVCSRy6zbIQXlUVUBJGugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922599; c=relaxed/simple;
	bh=qCzoPP2QZGT+8Cqt31qQeXI6cs3p5Mhxua30kcExp6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi+EK8CtWTVRPUBWxSg6eqm2QwL10yKw/WcnqR+F/OEitCu+9f95XxdaDu2ojgF3fsf7t8OlGrk5sq/Tn/kJiNmkehd09obh1N+zPFhczH/8V3qBUAaZtdkQBkl1PLJGtRdbGHKUA50qDPdUd2xkoF+2RNIYaN81EERAYrI2ra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C05D41476;
	Thu, 25 Jul 2024 08:50:22 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FEB03F5A1;
	Thu, 25 Jul 2024 08:49:53 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:49:50 +0100
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
Subject: Re: [PATCH v4 13/29] arm64: convert protection key into vm_flags and
 pgprot values
Message-ID: <ZqJ0HqR4IbNrgX5y@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-14-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-14-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:31PM +0100, Joey Gouly wrote:
> Modify arch_calc_vm_prot_bits() and vm_get_page_prot() such that the pkey
> value is set in the vm_flags and then into the pgprot value.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/mman.h | 8 +++++++-
>  arch/arm64/mm/mmap.c          | 9 +++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 5966ee4a6154..ecb2d18dc4d7 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -7,7 +7,7 @@
>  #include <uapi/asm/mman.h>
>  
>  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> -	unsigned long pkey __always_unused)
> +	unsigned long pkey)
>  {
>  	unsigned long ret = 0;
>  
> @@ -17,6 +17,12 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>  	if (system_supports_mte() && (prot & PROT_MTE))
>  		ret |= VM_MTE;
>  
> +#if defined(CONFIG_ARCH_HAS_PKEYS)
> +	ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
> +	ret |= pkey & 0x2 ? VM_PKEY_BIT1 : 0;
> +	ret |= pkey & 0x4 ? VM_PKEY_BIT2 : 0;

Out of interest, is this as bad as it looks or does the compiler turn
it into a shift and mask?


> +#endif
> +
>  	return ret;
>  }
>  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index 642bdf908b22..86eda6bc7893 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -102,6 +102,15 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)
>  	if (vm_flags & VM_MTE)
>  		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
>  
> +#ifdef CONFIG_ARCH_HAS_PKEYS
> +	if (vm_flags & VM_PKEY_BIT0)
> +		prot |= PTE_PO_IDX_0;
> +	if (vm_flags & VM_PKEY_BIT1)
> +		prot |= PTE_PO_IDX_1;
> +	if (vm_flags & VM_PKEY_BIT2)
> +		prot |= PTE_PO_IDX_2;
> +#endif
> +

Ditto.  At least we only have three bits to cope with either way.

I'm guessing that these functions are not super-hot path.

[...]

Cheers
---Dave

