Return-Path: <linux-fsdevel+bounces-24051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AC1938BD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44DA1C209E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8356C168C20;
	Mon, 22 Jul 2024 09:16:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EADE25763
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639783; cv=none; b=PYueauVzoCp7itVkNeW8IXfNUYpe6xdy0jYdVQJTVC/lseVz8WmGAgoUr1rQTYJ49ytSANokSHpq/nuYyjWZTF5BTR9CpQT5NrtOwRF3RMOJ56kPTq6YWc8qNj/KtreCnpAKmy0Ja1Af1XlieDAPJviLdjk6Jcf/T8OphS2hN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639783; c=relaxed/simple;
	bh=7C/drCaoNFVEaUE441qDvzta0bNUQ/yAp+86vRAao00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDqiqlyYZPZYOlkErEwcDaUf9VmbPQ7T/aPnj/3W+8ynu7Y64gke9MWiHobbGz/xX0jMmRr6BgrkkzLVGfSbXWlUK+ZRY1NIl2y2putewOc2/AFDwJEzJxN+DNSqK0fyBJQseoCkgvee4UNCP89kpWsvBdYmu4FPPpO+GWC+pGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF5ADFEC;
	Mon, 22 Jul 2024 02:16:45 -0700 (PDT)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71F823F766;
	Mon, 22 Jul 2024 02:16:12 -0700 (PDT)
Message-ID: <3c385faa-bfe9-4731-8fdc-fa786f2160df@arm.com>
Date: Mon, 22 Jul 2024 14:46:09 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
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
 <20240503130147.1154804-19-joey.gouly@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240503130147.1154804-19-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++
>  arch/arm64/kernel/signal.c               | 52 ++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
> index 8a45b7a411e0..e4cba8a6c9a2 100644
> --- a/arch/arm64/include/uapi/asm/sigcontext.h
> +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> @@ -98,6 +98,13 @@ struct esr_context {
>  	__u64 esr;
>  };
>  
> +#define POE_MAGIC	0x504f4530
> +
> +struct poe_context {
> +	struct _aarch64_ctx head;
> +	__u64 por_el0;
> +};
> +
>  /*
>   * extra_context: describes extra space in the signal frame for
>   * additional structures that don't fit in sigcontext.__reserved[].
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 4a77f4976e11..077436a8bc10 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -63,6 +63,7 @@ struct rt_sigframe_user_layout {
>  	unsigned long fpmr_offset;
>  	unsigned long extra_offset;
>  	unsigned long end_offset;
> +	unsigned long poe_offset;
>  };
>  
>  #define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
> @@ -185,6 +186,8 @@ struct user_ctxs {
>  	u32 zt_size;
>  	struct fpmr_context __user *fpmr;
>  	u32 fpmr_size;
> +	struct poe_context __user *poe;
> +	u32 poe_size;
>  };
>  
>  static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
> @@ -258,6 +261,21 @@ static int restore_fpmr_context(struct user_ctxs *user)
>  	return err;
>  }
>  
> +static int restore_poe_context(struct user_ctxs *user)
> +{
> +	u64 por_el0;
> +	int err = 0;
> +
> +	if (user->poe_size != sizeof(*user->poe))
> +		return -EINVAL;
> +
> +	__get_user_error(por_el0, &(user->poe->por_el0), err);
> +	if (!err)
> +		write_sysreg_s(por_el0, SYS_POR_EL0);
> +
> +	return err;
> +}
> +
>  #ifdef CONFIG_ARM64_SVE
>  
>  static int preserve_sve_context(struct sve_context __user *ctx)
> @@ -621,6 +639,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
>  	user->za = NULL;
>  	user->zt = NULL;
>  	user->fpmr = NULL;
> +	user->poe = NULL;
>  
>  	if (!IS_ALIGNED((unsigned long)base, 16))
>  		goto invalid;
> @@ -671,6 +690,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
>  			/* ignore */
>  			break;
>  
> +		case POE_MAGIC:
> +			if (!system_supports_poe())
> +				goto invalid;
> +
> +			if (user->poe)
> +				goto invalid;
> +
> +			user->poe = (struct poe_context __user *)head;
> +			user->poe_size = size;
> +			break;
> +
>  		case SVE_MAGIC:
>  			if (!system_supports_sve() && !system_supports_sme())
>  				goto invalid;
> @@ -857,6 +887,9 @@ static int restore_sigframe(struct pt_regs *regs,
>  	if (err == 0 && system_supports_sme2() && user.zt)
>  		err = restore_zt_context(&user);
>  
> +	if (err == 0 && system_supports_poe() && user.poe)
> +		err = restore_poe_context(&user);
> +
>  	return err;
>  }
>  
> @@ -980,6 +1013,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
>  			return err;
>  	}
>  
> +	if (system_supports_poe()) {
> +		err = sigframe_alloc(user, &user->poe_offset,
> +				     sizeof(struct poe_context));
> +		if (err)
> +			return err;
> +	}
> +
>  	return sigframe_alloc_end(user);
>  }
>  
> @@ -1020,6 +1060,15 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
>  		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
>  	}
>  
> +	if (system_supports_poe() && err == 0 && user->poe_offset) {
> +		struct poe_context __user *poe_ctx =
> +			apply_user_offset(user, user->poe_offset);
> +
> +		__put_user_error(POE_MAGIC, &poe_ctx->head.magic, err);
> +		__put_user_error(sizeof(*poe_ctx), &poe_ctx->head.size, err);
> +		__put_user_error(read_sysreg_s(SYS_POR_EL0), &poe_ctx->por_el0, err);
> +	}
> +
>  	/* Scalable Vector Extension state (including streaming), if present */
>  	if ((system_supports_sve() || system_supports_sme()) &&
>  	    err == 0 && user->sve_offset) {
> @@ -1178,6 +1227,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>  		sme_smstop();
>  	}
>  
> +	if (system_supports_poe())
> +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> +
>  	if (ka->sa.sa_flags & SA_RESTORER)
>  		sigtramp = ka->sa.sa_restorer;
>  	else

