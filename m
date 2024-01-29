Return-Path: <linux-fsdevel+bounces-9330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7984008A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98C51F2693E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921D554BE0;
	Mon, 29 Jan 2024 08:44:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8CB54BCC;
	Mon, 29 Jan 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517874; cv=none; b=QK/A/pSlEnlnUDePUQUFRz5Flbr77eN/GZ4V3fUzOFw1CbYOgAUtmGld/ijoRHRDNOmHykaa9wYt0c+5C8eVPzJk1OyC3oeBE4NxdKIjwLVTYucFZ4nE0kV8qsxrmTM/c1yN1Y5Z5rLxEjSEqOayLnCewmVLStoqvdTKv8zS5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517874; c=relaxed/simple;
	bh=MjJD+Ju24rDZFA9W3lNsMnwl/3iRcy6XP1BuXxb2O30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns3ZiSjbFnoTOaXaI2ry+y6OAtZ8kTBOIuLlFC3l4FDUZamzebKSAS8211cPwltgkIvsfB92xoFXCkoMhhQWWbtIy5TFdS897/mz6xYl8iF9aYdNajt3HfaTJ6GHM9m6pmie12+5YyojBWWMRqvszwTBbMCGg1QSmxLsiGaFfOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11ED01FB;
	Mon, 29 Jan 2024 00:45:14 -0800 (PST)
Received: from [10.162.42.11] (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C240E3F762;
	Mon, 29 Jan 2024 00:44:19 -0800 (PST)
Message-ID: <a5f593c7-0e5f-46e9-a394-a2c0dad03c8f@arm.com>
Date: Mon, 29 Jan 2024 14:14:16 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 03/35] mm: page_alloc: Add an arch hook to filter
 MIGRATE_CMA allocations
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 mhiramat@kernel.org, rppt@kernel.org, hughd@google.com
Cc: pcc@google.com, steven.price@arm.com, vincenzo.frascino@arm.com,
 david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-4-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-4-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 22:12, Alexandru Elisei wrote:
> As an architecture might have specific requirements around the allocation
> of CMA pages, add an arch hook that can disable allocations from
> MIGRATE_CMA, if the allocation was otherwise allowed.
> 
> This will be used by arm64, which will put tag storage pages on the
> MIGRATE_CMA list, and tag storage pages cannot be tagged. The filter will
> be used to deny using MIGRATE_CMA for __GFP_TAGGED allocations.

Just wondering how allocation requests would be blocked for direct
alloc_contig_range() requests ?

> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  include/linux/pgtable.h | 7 +++++++
>  mm/page_alloc.c         | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 6d98d5fdd697..c5ddec6b5305 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -905,6 +905,13 @@ static inline void arch_do_swap_page(struct mm_struct *mm,
>  static inline void arch_free_pages_prepare(struct page *page, int order) { }
>  #endif
>  
> +#ifndef __HAVE_ARCH_ALLOC_CMA

Same as last patch i.e __HAVE_ARCH_ALLOC_CMA could be avoided via
a direct check on #ifndef arch_alloc_cma instead.

> +static inline bool arch_alloc_cma(gfp_t gfp)
> +{
> +	return true;
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_UNMAP_ONE
>  /*
>   * Some architectures support metadata associated with a page. When a
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 27282a1c82fe..a96d47a6393e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3157,7 +3157,8 @@ static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
>  						  unsigned int alloc_flags)
>  {
>  #ifdef CONFIG_CMA
> -	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> +	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE &&
> +	    arch_alloc_cma(gfp_mask))
>  		alloc_flags |= ALLOC_CMA;
>  #endif
>  	return alloc_flags;

