Return-Path: <linux-fsdevel+bounces-23661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AC593108E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390A6B22363
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D07187576;
	Mon, 15 Jul 2024 08:45:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCE4184102
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033131; cv=none; b=LdH3oYxI3EwrjhHsR4/kDdC/qg56wtKIKRxWOO11vY9d+LPUfX/kH9n7T1IVAlySucv7Rraho4zz9Kt1vRqB0oufBRTbpvzc/trtLJyKnqwQ8v5b8cDwb5d/E5dP7Jud+38tKjvTh3uc+jUI/P0bfGJ6hLwQNAG0iE1ev3khAWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033131; c=relaxed/simple;
	bh=FnkG2ICelvOZA+zCd94yZ2CzHMIQn4QlIwPQwvNLqlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAb2nhvlL+/5cDQ/y5BKFRLSit94vlrykpeIkd1k9js2tZPxGbG3ausDVntF/B8ttdsF1b9ynQhxnHwCLb6VgnU51KKr8nLFiAKMN2CDMDDworEDKRzc5ytZOYDdcDmt55VUX7YaHisWeqpvrJJj1e8Vm49BoMoXeotg9PMTzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C0CEDA7;
	Mon, 15 Jul 2024 01:45:54 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABD933F73F;
	Mon, 15 Jul 2024 01:45:20 -0700 (PDT)
Message-ID: <232f5d3d-8a85-4bc2-9076-f5cd4fb968a2@arm.com>
Date: Mon, 15 Jul 2024 14:15:17 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/29] KVM: arm64: use `at s1e1a` for POE
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
 <20240503130147.1154804-10-joey.gouly@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240503130147.1154804-10-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> FEAT_ATS1E1A introduces a new instruction: `at s1e1a`.
> This is an address translation, without permission checks.
> 
> POE allows read permissions to be removed from S1 by the guest.  This means
> that an `at` instruction could fail, and not get the IPA.
> 
> Switch to using `at s1e1a` so that KVM can get the IPA regardless of S1
> permissions.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kvm/hyp/include/hyp/fault.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/hyp/fault.h b/arch/arm64/kvm/hyp/include/hyp/fault.h
> index 487c06099d6f..17df94570f03 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/fault.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/fault.h
> @@ -14,6 +14,7 @@
>  
>  static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
>  {
> +	int ret;
>  	u64 par, tmp;
>  
>  	/*
> @@ -27,7 +28,9 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
>  	 * saved the guest context yet, and we may return early...
>  	 */
>  	par = read_sysreg_par();
> -	if (!__kvm_at(OP_AT_S1E1R, far))
> +	ret = system_supports_poe() ? __kvm_at(OP_AT_S1E1A, far) :
> +	                              __kvm_at(OP_AT_S1E1R, far);
> +	if (!ret)
>  		tmp = read_sysreg_par();
>  	else
>  		tmp = SYS_PAR_EL1_F; /* back to the guest */

Since the idea is to get the IPA, using OP_AT_S1E1A instead, makes sense
when POE is enabled.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

