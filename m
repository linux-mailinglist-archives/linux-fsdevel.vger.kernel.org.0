Return-Path: <linux-fsdevel+bounces-24262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5473693C6F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9D0283E4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC8F339A0;
	Thu, 25 Jul 2024 16:00:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EEF12B7F
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923256; cv=none; b=C7zuVd/v58I2KTTA7Q6akR7aCcODs5f47xRbXn862oCgbR2zD7F+HKY9WgzQz7z2zSKsByXuMV+hBSBYZ/k2c7crfyGjibez587xUpEieKuYKGxpf35BNQYHBVjOtnG19kqJ/9hzDlMRkE3fi3CsNQxuAF70npnBBjJegaug0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923256; c=relaxed/simple;
	bh=TIEKHFaz9h3n7ZVaIVsc1ClLElqSNhgoiLNhRj1L2zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEyntzFx+k3fgXV+x7VFlY0QFIkSEcr1Sj0vg0a4x6/he7BlVHk8g+bALTGjogywKdHfak4rN65EN88fhuXKwO585fBK3w9xYwyYLUipYT5SPra8u49FVXJLiOQfeHqCzuatdhDekF2zDTlBSQcFrTPBXkPk2u4n64P57sYPs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA2BC1476;
	Thu, 25 Jul 2024 09:01:19 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FAA33F5A1;
	Thu, 25 Jul 2024 09:00:51 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:00:49 +0100
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
Subject: Re: [PATCH v4 19/29] arm64: enable PKEY support for CPUs with S1POE
Message-ID: <ZqJ2sVQ/iIe42XXF@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-20-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-20-joey.gouly@arm.com>

Hi,

On Fri, May 03, 2024 at 02:01:37PM +0100, Joey Gouly wrote:
> Now that PKEYs support has been implemented, enable it for CPUs that
> support S1POE.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/pkeys.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
> index a284508a4d02..3ea928ec94c0 100644
> --- a/arch/arm64/include/asm/pkeys.h
> +++ b/arch/arm64/include/asm/pkeys.h
> @@ -17,7 +17,7 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  
>  static inline bool arch_pkeys_enabled(void)
>  {
> -	return false;
> +	return system_supports_poe();
>  }

Nit: maybe push this later in the series, at least to after the POE/PIE
patch, since pkeys won't work right otherwise on PIE-enabled platforms?

(I know it makes no difference without final Kconfig update, but it
feels more logical.)

[...]

Cheers
---Dave

