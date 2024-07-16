Return-Path: <linux-fsdevel+bounces-23746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FA0932436
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 12:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FE11C21B72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966FD198A37;
	Tue, 16 Jul 2024 10:36:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB571953A8
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126175; cv=none; b=CNbZ+IbXnAmr8ZpE3MbgwURfbT8FOf3FtEUsdj6DwDPmHgPEfIfiHnoD0BuQBHrvA+Lf6naui0Bq4sRlbhKOdVaBK59G1Bo7dViOplYn83AUU3EvDcz/z+MEQ5gkz5L9ojaL4CCDw7NrA2Di7HcydkSMzkldoC8Los2WJFnyf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126175; c=relaxed/simple;
	bh=KRSa0BhlKQ/tEsjk+fQJm+8hQhGAQBdAYm7XOsn8hmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WU95NvFKE9JR+pbKV/luuBtujX0K1J5Feg0zbI6kSkcoN6vOpWTE1PLFDWEUJeyL3u8QCGoaxg6zO8ZS0AAiBlf+gEmWlCP4xzNV5q/EwCAHk6ElX8Wvb+sYTz1i7ZbaHEwsKhNur3RQVPLsMr2rGqz7wC2bp1tr26QrNtw6DYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 217271063;
	Tue, 16 Jul 2024 03:36:38 -0700 (PDT)
Received: from [10.163.52.225] (unknown [10.163.52.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58F713F762;
	Tue, 16 Jul 2024 03:36:00 -0700 (PDT)
Message-ID: <30ee6b2d-f66b-45c5-9c18-2b6ddaafda33@arm.com>
Date: Tue, 16 Jul 2024 16:05:56 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/29] arm64/ptrace: add support for FEAT_POE
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
 <20240503130147.1154804-22-joey.gouly@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240503130147.1154804-22-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> Add a regset for POE containing POR_EL0.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/kernel/ptrace.c | 46 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/elf.h   |  1 +
>  2 files changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 0d022599eb61..b756578aeaee 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1440,6 +1440,39 @@ static int tagged_addr_ctrl_set(struct task_struct *target, const struct
>  }
>  #endif
>  
> +#ifdef CONFIG_ARM64_POE
> +static int poe_get(struct task_struct *target,
> +		   const struct user_regset *regset,
> +		   struct membuf to)
> +{
> +	if (!system_supports_poe())
> +		return -EINVAL;
> +
> +	return membuf_write(&to, &target->thread.por_el0,
> +			    sizeof(target->thread.por_el0));
> +}
> +
> +static int poe_set(struct task_struct *target, const struct
> +		   user_regset *regset, unsigned int pos,
> +		   unsigned int count, const void *kbuf, const
> +		   void __user *ubuf)
> +{
> +	int ret;
> +	long ctrl;
> +
> +	if (!system_supports_poe())
> +		return -EINVAL;
> +
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ctrl, 0, -1);
> +	if (ret)
> +		return ret;
> +
> +	target->thread.por_el0 = ctrl;
> +
> +	return 0;
> +}
> +#endif
> +
>  enum aarch64_regset {
>  	REGSET_GPR,
>  	REGSET_FPR,
> @@ -1469,6 +1502,9 @@ enum aarch64_regset {
>  #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
>  	REGSET_TAGGED_ADDR_CTRL,
>  #endif
> +#ifdef CONFIG_ARM64_POE
> +	REGSET_POE
> +#endif
>  };
>  
>  static const struct user_regset aarch64_regsets[] = {
> @@ -1628,6 +1664,16 @@ static const struct user_regset aarch64_regsets[] = {
>  		.set = tagged_addr_ctrl_set,
>  	},
>  #endif
> +#ifdef CONFIG_ARM64_POE
> +	[REGSET_POE] = {
> +		.core_note_type = NT_ARM_POE,
> +		.n = 1,
> +		.size = sizeof(long),
> +		.align = sizeof(long),
> +		.regset_get = poe_get,
> +		.set = poe_set,
> +	},
> +#endif
>  };
>  
>  static const struct user_regset_view user_aarch64_view = {
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b54b313bcf07..81762ff3c99e 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -441,6 +441,7 @@ typedef struct elf64_shdr {
>  #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
>  #define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
>  #define NT_ARM_FPMR	0x40e		/* ARM floating point mode register */
> +#define NT_ARM_POE	0x40f		/* ARM POE registers */
>  #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
>  #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
>  #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */

