Return-Path: <linux-fsdevel+bounces-9339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97EF8401BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686801F21770
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7057893;
	Mon, 29 Jan 2024 09:31:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58257883;
	Mon, 29 Jan 2024 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520700; cv=none; b=iH57SxyfVNy+Acjqo9SJ+AsB5Ct6HJSaIr49+KBtLkYIy+LwHintaHKX9hD2G7KsSb/XOQzRcRBQwz37+E5ZNNQIFwfVOU8znE7wiY9qozdR00OX52PkP6lIe1CrkChoAb7QD4k8yFYLaxKi+/0Icu8c/ETl2bJ4kZB4+dzTGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520700; c=relaxed/simple;
	bh=f2nIjWzHpvckZF6FW2rjgzqK/Kl1yzYIbEFzQnXuNCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tb6krhIrK2z6N46a9G3woQa5q/2t8iuBCtd4wAkfDZ1VkKFOgfbck/8/0q0zR7isjP9hE1oVVr5CFx9gpT2eoCblm+fn0bkVbLOcv2AFnxEWhwqJUOdGyakFHRciWxK5BthS7By8Q0MKyVegIZERIvUQrPYefi1dPOrQFcQizxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0F771FB;
	Mon, 29 Jan 2024 01:32:21 -0800 (PST)
Received: from [10.162.42.11] (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DA1E3F762;
	Mon, 29 Jan 2024 01:31:26 -0800 (PST)
Message-ID: <545bb7bd-31c7-4166-9f81-778b82ece6d4@arm.com>
Date: Mon, 29 Jan 2024 15:01:24 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 07/35] mm: cma: Add CMA_RELEASE_{SUCCESS,FAIL}
 events
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
 <20240125164256.4147-8-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-8-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 22:12, Alexandru Elisei wrote:
> Similar to the two events that relate to CMA allocations, add the
> CMA_RELEASE_SUCCESS and CMA_RELEASE_FAIL events that count when CMA pages
> are freed.

How is this is going to be beneficial towards analyzing CMA alloc/release
behaviour - particularly with respect to this series. OR just adding this
from parity perspective with CMA alloc side counters ? Regardless this
CMA change too could be discussed separately.

> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> 
> Changes since rfc v2:
> 
> * New patch.
> 
>  include/linux/vm_event_item.h | 2 ++
>  mm/cma.c                      | 6 +++++-
>  mm/vmstat.c                   | 2 ++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 747943bc8cc2..aba5c5bf8127 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -83,6 +83,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_CMA
>  		CMA_ALLOC_SUCCESS,
>  		CMA_ALLOC_FAIL,
> +		CMA_RELEASE_SUCCESS,
> +		CMA_RELEASE_FAIL,
>  #endif
>  		UNEVICTABLE_PGCULLED,	/* culled to noreclaim list */
>  		UNEVICTABLE_PGSCANNED,	/* scanned for reclaimability */
> diff --git a/mm/cma.c b/mm/cma.c
> index dbf7fe8cb1bd..543bb6b3be8e 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -562,8 +562,10 @@ bool cma_release(struct cma *cma, const struct page *pages,
>  {
>  	unsigned long pfn;
>  
> -	if (!cma_pages_valid(cma, pages, count))
> +	if (!cma_pages_valid(cma, pages, count)) {
> +		count_vm_events(CMA_RELEASE_FAIL, count);
>  		return false;
> +	}
>  
>  	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
>  
> @@ -575,6 +577,8 @@ bool cma_release(struct cma *cma, const struct page *pages,
>  	cma_clear_bitmap(cma, pfn, count);
>  	trace_cma_release(cma->name, pfn, pages, count);
>  
> +	count_vm_events(CMA_RELEASE_SUCCESS, count);
> +
>  	return true;
>  }
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index db79935e4a54..eebfd5c6c723 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1340,6 +1340,8 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_CMA
>  	"cma_alloc_success",
>  	"cma_alloc_fail",
> +	"cma_release_success",
> +	"cma_release_fail",
>  #endif
>  	"unevictable_pgs_culled",
>  	"unevictable_pgs_scanned",

