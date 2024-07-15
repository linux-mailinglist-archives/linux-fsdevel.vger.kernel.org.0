Return-Path: <linux-fsdevel+bounces-23660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC15930FE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 10:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F2E1C21181
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E871849E1;
	Mon, 15 Jul 2024 08:36:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEB013AD16
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032597; cv=none; b=jUapdAFcxVZRDJO2X9oyJCu/20s/T/nAwJRFVzQBJqlwj30Sk3RnXQni4g8eWhqu1F7apeJvmxkHwFI7Ex9zotJRwupS0j5+Mpci2MQgtogiHfjLwTRpOjKrLfJ9SeB2eU3IAZp4aK+19Ld+WvY/JmSib8iwZXh++IoF716qEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032597; c=relaxed/simple;
	bh=QDXXHwp4Bn8wZX+9ZWPKdP0qyb/qIHEd3mli5XN3Egg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhXFoVNk8fI15+BMt4wTafvaar3a4ej0bMxy9SH2q1qjlZTImpKcT/mLJnPb6YgCCrpW6SHIXqFsyWll4x8MUFQKHVvccUNftSQGqtUJ/+ZzDznYuuDc/QNwl5aHtXk6Qt2BK9gbE2d+8rJKeW0z2Sk1YyhpQJTECm0NhqEQkXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 256A8DA7;
	Mon, 15 Jul 2024 01:37:01 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C89A3F73F;
	Mon, 15 Jul 2024 01:36:27 -0700 (PDT)
Message-ID: <82a5acea-0a06-437e-b246-ae2874c3493e@arm.com>
Date: Mon, 15 Jul 2024 14:06:24 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/29] KVM: arm64: make kvm_at() take an OP_AT_*
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
 <20240503130147.1154804-9-joey.gouly@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240503130147.1154804-9-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> To allow using newer instructions that current assemblers don't know about,
> replace the `at` instruction with the underlying SYS instruction.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_asm.h       | 3 ++-
>  arch/arm64/kvm/hyp/include/hyp/fault.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 24b5e6b23417..ce65fd0f01b0 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -10,6 +10,7 @@
>  #include <asm/hyp_image.h>
>  #include <asm/insn.h>
>  #include <asm/virt.h>
> +#include <asm/sysreg.h>
>  
>  #define ARM_EXIT_WITH_SERROR_BIT  31
>  #define ARM_EXCEPTION_CODE(x)	  ((x) & ~(1U << ARM_EXIT_WITH_SERROR_BIT))
> @@ -261,7 +262,7 @@ extern u64 __kvm_get_mdcr_el2(void);
>  	asm volatile(							\
>  	"	mrs	%1, spsr_el2\n"					\
>  	"	mrs	%2, elr_el2\n"					\
> -	"1:	at	"at_op", %3\n"					\
> +	"1:	" __msr_s(at_op, "%3") "\n"				\
>  	"	isb\n"							\
>  	"	b	9f\n"						\
>  	"2:	msr	spsr_el2, %1\n"					\
> diff --git a/arch/arm64/kvm/hyp/include/hyp/fault.h b/arch/arm64/kvm/hyp/include/hyp/fault.h
> index 9e13c1bc2ad5..487c06099d6f 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/fault.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/fault.h
> @@ -27,7 +27,7 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
>  	 * saved the guest context yet, and we may return early...
>  	 */
>  	par = read_sysreg_par();
> -	if (!__kvm_at("s1e1r", far))
> +	if (!__kvm_at(OP_AT_S1E1R, far))
>  		tmp = read_sysreg_par();
>  	else
>  		tmp = SYS_PAR_EL1_F; /* back to the guest */

I guess this patch has already been included in a different series now.

https://lore.kernel.org/all/20240625133508.259829-6-maz@kernel.org/

