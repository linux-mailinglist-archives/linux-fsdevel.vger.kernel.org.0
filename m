Return-Path: <linux-fsdevel+bounces-23745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5DD9323D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 12:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B8028204E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 10:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733EC25761;
	Tue, 16 Jul 2024 10:22:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59DAC8F3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125329; cv=none; b=qLdCy6LooEhvy3wcgdxkGB/krVzYwVMYUssuU+FQlFbV2dJGlTcLu73mQDqFgSl5Fj1UJjEg+TxvvUuLjX4o+JCrDlB2C6eeA8bnKOBSV5d6S+QzeuyI5+rxPezv3RNjjP57Kvc/DDKzANcuWKZiFs1w4bBYIv8spYodaXe55gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125329; c=relaxed/simple;
	bh=t+LQ8fq7LszoziQBN+lTS5E+76k/2oGTec0nGQVKd6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beqrv2Fd3HbdrNzJrBVjsBQBndyPtGC/5WXndNQHoDkXODX1OdD6+HaY78OILqmIrSv//niXv9NQEOhmtlPEFr821crP6b/lZ4mqMNEJhIkP5tnrw8DXA6DjeRxAVT+gCPUXQ/KUj1F3xbgX0AFk3DrAza611tcBLQNAUk/E1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78BB31063;
	Tue, 16 Jul 2024 03:22:32 -0700 (PDT)
Received: from [10.163.52.225] (unknown [10.163.52.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 012EF3F762;
	Tue, 16 Jul 2024 03:21:58 -0700 (PDT)
Message-ID: <ca5de643-dcf3-4a24-ba99-b05066c95dca@arm.com>
Date: Tue, 16 Jul 2024 15:51:55 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/29] arm64: add pte_access_permitted_no_overlay()
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
 <20240503130147.1154804-17-joey.gouly@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240503130147.1154804-17-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 18:31, Joey Gouly wrote:
> We do not want take POE into account when clearing the MTE tags.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/include/asm/pgtable.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 5c970a9cca67..2449e4e27ea6 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -160,8 +160,10 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>   * not set) must return false. PROT_NONE mappings do not have the
>   * PTE_VALID bit set.
>   */
> -#define pte_access_permitted(pte, write) \
> +#define pte_access_permitted_no_overlay(pte, write) \
>  	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && (!(write) || pte_write(pte)))
> +#define pte_access_permitted(pte, write) \
> +	pte_access_permitted_no_overlay(pte, write)
>  #define pmd_access_permitted(pmd, write) \
>  	(pte_access_permitted(pmd_pte(pmd), (write)))
>  #define pud_access_permitted(pud, write) \
> @@ -348,10 +350,11 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
>  	/*
>  	 * If the PTE would provide user space access to the tags associated
>  	 * with it then ensure that the MTE tags are synchronised.  Although
> -	 * pte_access_permitted() returns false for exec only mappings, they
> -	 * don't expose tags (instruction fetches don't check tags).
> +	 * pte_access_permitted_no_overlay() returns false for exec only
> +	 * mappings, they don't expose tags (instruction fetches don't check
> +	 * tags).
>  	 */
> -	if (system_supports_mte() && pte_access_permitted(pte, false) &&
> +	if (system_supports_mte() && pte_access_permitted_no_overlay(pte, false) &&
>  	    !pte_special(pte) && pte_tagged(pte))
>  		mte_sync_tags(pte, nr_pages);
>  }

