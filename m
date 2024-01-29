Return-Path: <linux-fsdevel+bounces-9332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C278400CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5612281AC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D454F8D;
	Mon, 29 Jan 2024 09:01:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B1B54BEC;
	Mon, 29 Jan 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518900; cv=none; b=ZXNdP/L7fG7wYCT3DUjhmVYNJ4Ss1RUUx4YOk6nlLzZHBNWBr3d13lD8pDicgE+g0kCXI7oIDrm7ZTbV8R73BvJdIeXrKz/9o5qt5vZIMf1GQuc51VgHQgwcwuFFZ0oMmsQlGfO4tLcl/P5OU4YKU34y1xQiAMH4EcQWPLVYtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518900; c=relaxed/simple;
	bh=NjN9E54AVBkTjoChmDcx3fbIsw+sShP0t24cgP7LPCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9O60f+Z8l8TUVOA94BVTqR/etwfI6gSPGEW12P/eHABT+VXtdqQ/IpAdX3jjG5B4dY8zheU6wmgzjlm1IUHX0sxYW2zfcRU15rNYNB4D2XxSlr54WbfmzKrTLQgjTOjB25KrflsBiQaWlsrIXAAtJVQDkoZ/QW1+iU77DkZlys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE03D1FB;
	Mon, 29 Jan 2024 01:02:20 -0800 (PST)
Received: from [10.162.42.11] (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E8013F762;
	Mon, 29 Jan 2024 01:01:25 -0800 (PST)
Message-ID: <966a1a84-76dc-40da-bde2-251d2a81ee31@arm.com>
Date: Mon, 29 Jan 2024 14:31:23 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 04/35] mm: page_alloc: Partially revert "mm:
 page_alloc: remove stale CMA guard code"
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
 <20240125164256.4147-5-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-5-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 22:12, Alexandru Elisei wrote:
> The patch f945116e4e19 ("mm: page_alloc: remove stale CMA guard code")
> removed the CMA filter when allocating from the MIGRATE_MOVABLE pcp list
> because CMA is always allowed when __GFP_MOVABLE is set.
> 
> With the introduction of the arch_alloc_cma() function, the above is not
> true anymore, so bring back the filter.

This makes sense as arch_alloc_cma() now might prevent ALLOC_CMA being
assigned to alloc_flags in gfp_to_alloc_flags_cma().

> 
> This is a partially revert because the stale comment remains removed.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  mm/page_alloc.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a96d47a6393e..0fa34bcfb1af 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2897,10 +2897,17 @@ struct page *rmqueue(struct zone *preferred_zone,
>  	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>  
>  	if (likely(pcp_allowed_order(order))) {
> -		page = rmqueue_pcplist(preferred_zone, zone, order,
> -				       migratetype, alloc_flags);
> -		if (likely(page))
> -			goto out;
> +		/*
> +		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
> +		 * we need to skip it when CMA area isn't allowed.
> +		 */
> +		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> +				migratetype != MIGRATE_MOVABLE) {
> +			page = rmqueue_pcplist(preferred_zone, zone, order,
> +					migratetype, alloc_flags);
> +			if (likely(page))
> +				goto out;
> +		}
>  	}
>  
>  	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,

