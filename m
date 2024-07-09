Return-Path: <linux-fsdevel+bounces-23386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E95A292BAA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2665C1C22B87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576815B116;
	Tue,  9 Jul 2024 13:07:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B2158D8C
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530437; cv=none; b=hbkpG2CwyX53BuDGflbrEvOvRFGqYF+39UpNNuVKqVmi66U8EMoCrIvBvJmPGSWwBjsDJ654tTKxVwvE15pqtZRTT1v4RTqXZMK6aRmd7z/48V39C1U5GfHxNDoz77deA3ZIqlEXlBzvOZKFpfIpSa54ncOFKcUNEePeZi4LgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530437; c=relaxed/simple;
	bh=ts+OTxj0NDLFHdprkQBEl+8cWL4A6xT73CQjaSXBW04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ex8/kXwWPc3EGHVbSRwF2xFooh5skZeq2o91osrAnmKzRChLOLWwBzxEb/hsAIs/pgtpqu2tGpUJWommhr8D7b78yYSGbiUOoiT5c+Q/yg+sLje6jruPRWKcHHTiTj0Q25ykTa5tJsL4wXavpn2sLjEJ6ti8oql6cbILU2BD5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B393F1650;
	Tue,  9 Jul 2024 06:07:39 -0700 (PDT)
Received: from [10.44.160.75] (e126510-lin.lund.arm.com [10.44.160.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F1823F766;
	Tue,  9 Jul 2024 06:07:08 -0700 (PDT)
Message-ID: <18aee949-7e07-45e1-85c8-c990f017f305@arm.com>
Date: Tue, 9 Jul 2024 15:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
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
 <20240503130147.1154804-18-joey.gouly@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20240503130147.1154804-18-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 15:01, Joey Gouly wrote:
> @@ -267,6 +294,28 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
>  	return -1UL >> 8;
>  }
>  
> +/*
> + * We only want to enforce protection keys on the current process
> + * because we effectively have no access to POR_EL0 for other
> + * processes or any way to tell *which * POR_EL0 in a threaded
> + * process we could use.

I see that this comment is essentially copied from x86, but to me it
misses the main point. Even with only one thread in the target process
and a way to obtain its POR_EL0, it still wouldn't make sense to check
that value. If we take the case of a debugger accessing an inferior via
ptrace(), for instance, the kernel is asked to access some memory in
another mm. However, the debugger's POR_EL0 is tied to its own address
space, and the target's POR_EL0 is relevant to its own execution flow
only. In such situations, there is essentially no user context for the
access, so It fundamentally does not make sense to make checks based on
pkey/POE or similar restrictions to memory accesses (e.g. MTE).

Kevin

> + *
> + * So do not enforce things if the VMA is not from the current
> + * mm, or if we are in a kernel thread.
> + */
> +static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> +		bool write, bool execute, bool foreign)
> +{
> +	if (!arch_pkeys_enabled())
> +		return true;
> +
> +	/* allow access if the VMA is not one from this process */
> +	if (foreign || vma_is_foreign(vma))
> +		return true;
> +
> +	return por_el0_allows_pkey(vma_pkey(vma), write, execute);
> +}
> +


