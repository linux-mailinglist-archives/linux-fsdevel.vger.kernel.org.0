Return-Path: <linux-fsdevel+bounces-31282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21EB99407F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 10:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56479286588
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033B1FEFC3;
	Tue,  8 Oct 2024 07:15:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD056208A7;
	Tue,  8 Oct 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371752; cv=none; b=kRmxn1q8eKzshqq4buVPBdiL9T5+RRz3YdAdaVCeqOwmNSLCJ8hKRnQEWwn7X3OkKWnLEZESzLTYbuwPrkmQ/ZJQyqq8ISHak4/ll7MSFQOD7G96hPHG1R0+MkOm/Sb70+gS/K3hQHccVEgOezWCHX4W4JUdgdc7C5SN+jl0bMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371752; c=relaxed/simple;
	bh=oi/8zp+0aSjNDBG76jA78EC8mE4ZPQHPRYOB5TypZ+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhO0/UMPAHjRw6/KP0ZuIMYmhTIBWdd7SDC2nfSEqSUyqBe3MUx0CMRnPs9aUWbopp1DOy7gpnfetW0Fu/z8ohBn4EZJFY5R/YXdQuTtmWGGTbFCNF3Whvv3/Bn8a9C2AJkCGv+n/LP+YWoXz83gJ5Mg/SQ4kyfyCM3dv6zMt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C747DDA7;
	Tue,  8 Oct 2024 00:16:19 -0700 (PDT)
Received: from [10.163.38.160] (unknown [10.163.38.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0C1A3F640;
	Tue,  8 Oct 2024 00:15:45 -0700 (PDT)
Message-ID: <e563980c-9ae9-478e-89a3-819c7dadf85b@arm.com>
Date: Tue, 8 Oct 2024 12:45:42 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] arm64: Support AT_HWCAP3
To: Mark Brown <broonie@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Yury Khrustalev <yury.khrustalev@arm.com>,
 Wilco Dijkstra <wilco.dijkstra@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
 <20241004-arm64-elf-hwcap3-v2-2-799d1daad8b0@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241004-arm64-elf-hwcap3-v2-2-799d1daad8b0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/5/24 01:56, Mark Brown wrote:
> We have filled all 64 bits of AT_HWCAP2 so in order to support discovery of
> further features provide the framework to use the already defined AT_HWCAP3
> for further CPU features.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/arch/arm64/elf_hwcaps.rst | 6 +++---
>  arch/arm64/include/asm/cpufeature.h     | 3 ++-
>  arch/arm64/include/asm/hwcap.h          | 6 +++++-
>  arch/arm64/include/uapi/asm/hwcap.h     | 4 ++++
>  arch/arm64/kernel/cpufeature.c          | 6 ++++++
>  5 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
> index 694f67fa07d196816b1292e896ebe6a1b599c125..dc1b11d6d1122bba928b054cd1874aad5073e05c 100644
> --- a/Documentation/arch/arm64/elf_hwcaps.rst
> +++ b/Documentation/arch/arm64/elf_hwcaps.rst
> @@ -16,9 +16,9 @@ architected discovery mechanism available to userspace code at EL0. The
>  kernel exposes the presence of these features to userspace through a set
>  of flags called hwcaps, exposed in the auxiliary vector.
>  
> -Userspace software can test for features by acquiring the AT_HWCAP or
> -AT_HWCAP2 entry of the auxiliary vector, and testing whether the relevant
> -flags are set, e.g.::
> +Userspace software can test for features by acquiring the AT_HWCAP,
> +AT_HWCAP2 or AT_HWCAP3 entry of the auxiliary vector, and testing
> +whether the relevant flags are set, e.g.::
>  
>  	bool floating_point_is_present(void)
>  	{
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 3d261cc123c1e22ac7bc9cfcde463624c76b2084..38e7d1a44ea38ab0a06a6f22824ae023b128721b 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -12,7 +12,7 @@
>  #include <asm/hwcap.h>
>  #include <asm/sysreg.h>
>  
> -#define MAX_CPU_FEATURES	128
> +#define MAX_CPU_FEATURES	192
>  #define cpu_feature(x)		KERNEL_HWCAP_ ## x
>  
>  #define ARM64_SW_FEATURE_OVERRIDE_NOKASLR	0
> @@ -438,6 +438,7 @@ void cpu_set_feature(unsigned int num);
>  bool cpu_have_feature(unsigned int num);
>  unsigned long cpu_get_elf_hwcap(void);
>  unsigned long cpu_get_elf_hwcap2(void);
> +unsigned long cpu_get_elf_hwcap3(void);
>  
>  #define cpu_set_named_feature(name) cpu_set_feature(cpu_feature(name))
>  #define cpu_have_named_feature(name) cpu_have_feature(cpu_feature(name))
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index a775adddecf25633e87d58fb9ac9e6293beac1b3..3b5c50df419ee94193a4d9e3a47516eb0739e89a 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -159,17 +159,21 @@
>  #define KERNEL_HWCAP_SME_SF8DP2		__khwcap2_feature(SME_SF8DP2)
>  #define KERNEL_HWCAP_POE		__khwcap2_feature(POE)
>  
> +#define __khwcap3_feature(x)		(const_ilog2(HWCAP3_ ## x) + 128)
> +
>  /*
>   * This yields a mask that user programs can use to figure out what
>   * instruction set this cpu supports.
>   */
>  #define ELF_HWCAP		cpu_get_elf_hwcap()
>  #define ELF_HWCAP2		cpu_get_elf_hwcap2()
> +#define ELF_HWCAP3		cpu_get_elf_hwcap3()
>  
>  #ifdef CONFIG_COMPAT
>  #define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
>  #define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
> -extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
> +#define COMPAT_ELF_HWCAP3	(compat_elf_hwcap3)
> +extern unsigned int compat_elf_hwcap, compat_elf_hwcap2, compat_elf_hwcap3;
>  #endif
>  
>  enum {
> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> index 055381b2c61595361c2d57d38be936c2dfeaa195..3dd4a53a438a14bfb41882b2ab15bdd7ce617475 100644
> --- a/arch/arm64/include/uapi/asm/hwcap.h
> +++ b/arch/arm64/include/uapi/asm/hwcap.h
> @@ -124,4 +124,8 @@
>  #define HWCAP2_SME_SF8DP2	(1UL << 62)
>  #define HWCAP2_POE		(1UL << 63)
>  
> +/*
> + * HWCAP3 flags - for AT_HWCAP3
> + */
> +
>  #endif /* _UAPI__ASM_HWCAP_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 718728a85430fad5151b73fa213a510efac3f834..7221636b790709b153b49126e00246cc3032a7bc 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -103,6 +103,7 @@ static DECLARE_BITMAP(elf_hwcap, MAX_CPU_FEATURES) __read_mostly;
>  				 COMPAT_HWCAP_LPAE)
>  unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
>  unsigned int compat_elf_hwcap2 __read_mostly;
> +unsigned int compat_elf_hwcap3 __read_mostly;
>  #endif
>  
>  DECLARE_BITMAP(system_cpucaps, ARM64_NCAPS);
> @@ -3499,6 +3500,11 @@ unsigned long cpu_get_elf_hwcap2(void)
>  	return elf_hwcap[1];
>  }
>  
> +unsigned long cpu_get_elf_hwcap3(void)
> +{
> +	return elf_hwcap[2];
> +}
> +
>  static void __init setup_boot_cpu_capabilities(void)
>  {
>  	/*
> 

LGTM, but just curious do you have a upcoming feature to be added
in AT_HWCAP3 soon ?

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

