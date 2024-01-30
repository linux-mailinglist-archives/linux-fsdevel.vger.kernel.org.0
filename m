Return-Path: <linux-fsdevel+bounces-9489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928E3841B91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 06:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562F0289D68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 05:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ADF381D1;
	Tue, 30 Jan 2024 05:51:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA9381B6;
	Tue, 30 Jan 2024 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706593876; cv=none; b=XtENmQdl9Y2IlUsMdRubQggyKpR9I9yfn7cqE2sWYtI+rbCTJ54ubJ9pugVPnTrY65hhkBCxDqfztf+SSDBgMj3SKdhQl1d63xN+Ewxiar2tjD8CNd1lBzGoOAI+1kxn7PESm7XgQ6XQ4c7pmr+jQ9k9Aw6Zpqi4pkPYqo1z45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706593876; c=relaxed/simple;
	bh=8K9UnuvMcRu/4phSXWdkX2JClt3ysuFpTGp94GiiMvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTF6bWCJ5ght04NB6+fL4TUw6mw/tjYIThNu6T+AN/vHyeeCmPTrk1sYuAm3rHa3vUa40inIRJjgRyIjYbRc3yn8zLC7VmC5zatoOLKxRME7C83guQq2fGqCBlyGxTXLCrM0zMyzci4aDxUMmaRBg9as/eZe1M8tQlMLl30hLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B643DA7;
	Mon, 29 Jan 2024 21:51:57 -0800 (PST)
Received: from [10.163.41.110] (unknown [10.163.41.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F9903F762;
	Mon, 29 Jan 2024 21:51:00 -0800 (PST)
Message-ID: <830691cf-cb96-443e-b6eb-2adfe2edd587@arm.com>
Date: Tue, 30 Jan 2024 11:20:56 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 09/35] mm: cma: Introduce cma_remove_mem()
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
 <20240125164256.4147-10-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-10-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 22:12, Alexandru Elisei wrote:
> Memory is added to CMA with cma_declare_contiguous_nid() and
> cma_init_reserved_mem(). This memory is then put on the MIGRATE_CMA list in
> cma_init_reserved_areas(), where the page allocator can make use of it.

cma_declare_contiguous_nid() reserves memory in memblock and marks the
for subsequent CMA usage, where as cma_init_reserved_areas() activates
these memory areas through init_cma_reserved_pageblock(). Standard page
allocator only receives these memory via free_reserved_page() - only if
the page block activation fails.

> 
> If a device manages multiple CMA areas, and there's an error when one of
> the areas is added to CMA, there is no mechanism for the device to prevent

What kind of error ? init_cma_reserved_pageblock() fails ? But that will
not happen until cma_init_reserved_areas().

> the rest of the areas, which were added before the error occured, from
> being later added to the MIGRATE_CMA list.

Why is this mechanism required ? cma_init_reserved_areas() scans over all
CMA areas and try and activate each of them sequentially. Why is not this
sufficient ?

> 
> Add cma_remove_mem() which allows a previously reserved CMA area to be
> removed and thus it cannot be used by the page allocator.

Successfully activated CMA areas do not get used by the buddy allocator.

> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> 
> Changes since rfc v2:
> 
> * New patch.
> 
>  include/linux/cma.h |  1 +
>  mm/cma.c            | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index e32559da6942..787cbec1702e 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -48,6 +48,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  					unsigned int order_per_bit,
>  					const char *name,
>  					struct cma **res_cma);
> +extern void cma_remove_mem(struct cma **res_cma);
>  extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
>  			      bool no_warn);
>  extern int cma_alloc_range(struct cma *cma, unsigned long start, unsigned long count,
> diff --git a/mm/cma.c b/mm/cma.c
> index 4a0f68b9443b..2881bab12b01 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -147,8 +147,12 @@ static int __init cma_init_reserved_areas(void)
>  {
>  	int i;
>  
> -	for (i = 0; i < cma_area_count; i++)
> +	for (i = 0; i < cma_area_count; i++) {
> +		/* Region was removed. */
> +		if (!cma_areas[i].count)
> +			continue;

Skip previously added CMA area (now zeroed out) ?

>  		cma_activate_area(&cma_areas[i]);
> +	}
>  
>  	return 0;
>  }

cma_init_reserved_areas() gets called via core_initcall(). Some how
platform/device needs to call cma_remove_mem() before core_initcall()
gets called ? This might be time sensitive.

> @@ -216,6 +220,30 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  	return 0;
>  }
>  
> +/**
> + * cma_remove_mem() - remove cma area
> + * @res_cma: Pointer to the cma region.
> + *
> + * This function removes a cma region created with cma_init_reserved_mem(). The
> + * ->count is set to 0.
> + */
> +void __init cma_remove_mem(struct cma **res_cma)
> +{
> +	struct cma *cma;
> +
> +	if (WARN_ON_ONCE(!res_cma || !(*res_cma)))
> +		return;
> +
> +	cma = *res_cma;
> +	if (WARN_ON_ONCE(!cma->count))
> +		return;
> +
> +	totalcma_pages -= cma->count;
> +	cma->count = 0;
> +
> +	*res_cma = NULL;
> +}
> +
>  /**
>   * cma_declare_contiguous_nid() - reserve custom contiguous area
>   * @base: Base address of the reserved area optional, use 0 for any

But first please do explain what are the errors device or platform might
see on a previously marked CMA area so that removing them on way becomes
necessary preventing their activation via cma_init_reserved_areas().

