Return-Path: <linux-fsdevel+bounces-23653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D52930F0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FA41C21266
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 07:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274EF1836CB;
	Mon, 15 Jul 2024 07:47:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1AE13AD11
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029665; cv=none; b=HbhnewLD6Sn9wKRa7NsMUOxN1OA52L3o4YejQwUKtjGCFYHdcrLAL9/q+9RlvxPTjFHXLbpoSduy5F1FbJZBqK/gi+XCgdhjU6lQxUJycnFsR49+lyFis55qFkcxvuWx2TZqrhwbraFgs/GOSHo2WgdjPq6bmZcoiI6SsJYfL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029665; c=relaxed/simple;
	bh=I7seYVLChLDzy2ZoSFjTipjvojF80Bb/RljZUanzmDc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HMWpExR7KzWLq4N+0R6+/UVevz4v1l/vw2m6r37NSRmWX/HkXNnxznjpuATnJoTlMX7LC0CqiukQbBpe5MRceC5OdHEfMSzZtDT09XJgHzfkcrjUTpolaTGN5xaO+jJd7+poYNaXCzf0JZ3Honlm/p+cT+ubnO2xTJ8QYwsDSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 806EADA7;
	Mon, 15 Jul 2024 00:48:07 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88C73F762;
	Mon, 15 Jul 2024 00:47:33 -0700 (PDT)
Message-ID: <763279ea-7885-444c-9ca0-7a2cf7c7016d@arm.com>
Date: Mon, 15 Jul 2024 13:17:30 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 04/29] arm64: disable trapping of POR_EL0 to EL2
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
 <20240503130147.1154804-5-joey.gouly@arm.com>
Content-Language: en-US
In-Reply-To: <20240503130147.1154804-5-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> Allow EL0 or EL1 to access POR_EL0 without being trapped to EL2.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/el2_setup.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index b7afaa026842..df5614be4b70 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -184,12 +184,20 @@
>  .Lset_pie_fgt_\@:
>  	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
>  	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1PIE_SHIFT, #4
> -	cbz	x1, .Lset_fgt_\@
> +	cbz	x1, .Lset_poe_fgt_\@
>  
>  	/* Disable trapping of PIR_EL1 / PIRE0_EL1 */
>  	orr	x0, x0, #HFGxTR_EL2_nPIR_EL1
>  	orr	x0, x0, #HFGxTR_EL2_nPIRE0_EL1
>  
> +.Lset_poe_fgt_\@:
> +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1POE_SHIFT, #4
> +	cbz	x1, .Lset_fgt_\@
> +
> +	/* Disable trapping of POR_EL0 */
> +	orr	x0, x0, #HFGxTR_EL2_nPOR_EL0
> +
>  .Lset_fgt_\@:
>  	msr_s	SYS_HFGRTR_EL2, x0
>  	msr_s	SYS_HFGWTR_EL2, x0

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

