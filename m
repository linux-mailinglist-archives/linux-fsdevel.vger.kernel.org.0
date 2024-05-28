Return-Path: <linux-fsdevel+bounces-20308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ACC8D14CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 08:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0EA1C221FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA3F6F079;
	Tue, 28 May 2024 06:57:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1456F062
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879428; cv=none; b=PrUoWmSAieZOYTa3d8q1JH4QLyepmxHkgvRd4xuJGppxJ3PpN6ncj/AgREccXFDBMw9ZULgMkkCdA2L+W9/fhz9TrkC9oaaYiIP/kH0IMMuDn+/OzanPYzxLQVI5xm7u800ziG/kuOHpBNbsACLpI1XkFSNahoQ8K7MswPLk5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879428; c=relaxed/simple;
	bh=x3RnDu7FS0yETf0PyFpTvtyfVJ4/2lY97V3xrfYdUf8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Je7TT2TVClUxJHXGNdI+Z5a0bxi12KJyswTVV4a8Bb/iQFUDIxMQ8Z8ZuWzAsZtk9Kr3UBV1HWr2eg8vUfRAqRnMT0F0b3iYNKiJ4Fl/ZhbHa/rBwquYDr9A2yhDIszT33yJRYV3qqXWENjuFEWH0P3/HkW2YQmzpvcss006RvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B57FF150C;
	Mon, 27 May 2024 23:57:29 -0700 (PDT)
Received: from [10.162.40.16] (a077841.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B67F3F792;
	Mon, 27 May 2024 23:56:57 -0700 (PDT)
Message-ID: <229bd367-466e-4bf9-9627-24d2d0821ff4@arm.com>
Date: Tue, 28 May 2024 12:26:54 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>
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
In-Reply-To: <20240503130147.1154804-19-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> ---
>   arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++
>   arch/arm64/kernel/signal.c               | 52 ++++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
> index 8a45b7a411e0..e4cba8a6c9a2 100644
> --- a/arch/arm64/include/uapi/asm/sigcontext.h
> +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> @@ -98,6 +98,13 @@ struct esr_context {
>   	__u64 esr;
>   };
>   
> +#define POE_MAGIC	0x504f4530
> +
> +struct poe_context {
> +	struct _aarch64_ctx head;
> +	__u64 por_el0;
> +};

There is a comment section in the beginning which mentions the size
of the context frame structure and subsequent reduction in the
reserved range. So this new context description can be added there.
Although looks like it is broken for za, zt and fpmr context.

> +
>   /*
>    * extra_context: describes extra space in the signal frame for
>    * additional structures that don't fit in sigcontext.__reserved[].
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 4a77f4976e11..077436a8bc10 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -63,6 +63,7 @@ struct rt_sigframe_user_layout {
>   	unsigned long fpmr_offset;
>   	unsigned long extra_offset;
>   	unsigned long end_offset;
> +	unsigned long poe_offset;

For consistency this can be added after fpmr_offset.

Thanks,
Amit

>   };
>   
>   #define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
> @@ -185,6 +186,8 @@ struct user_ctxs {
>   	u32 zt_size;
>   	struct fpmr_context __user *fpmr;
>   	u32 fpmr_size;
> +	struct poe_context __user *poe;

