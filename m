Return-Path: <linux-fsdevel+bounces-9337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112F84015B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DAF1F228DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BED5576E;
	Mon, 29 Jan 2024 09:24:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2517054F93;
	Mon, 29 Jan 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520277; cv=none; b=J9BXUB33LQF1JwDZfYd07jKDDQuRkX40fW6XULlS0BxFvRPIGKFHNNJbT8JNSlUQTCmZSvjhReXDH71p5ThPLSF5W5ZtQpZV11P6XRw6590x2OngZnRDDcxb35ESxUnQ8QTYp209uLXy2vbj7wOOOYKdhdpNn7p5UAb9v+KXb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520277; c=relaxed/simple;
	bh=inmOTze7uKfZeWIoyGwST8hZ+d0IPucCCcqmZ34CTwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSaub6YEpF49Y5VZS9ojZ54+jfYWYJR0RoOmNL7zwrOEEX3548X0A/DVzQ6Y8bljG8NWn3su5xFC5PNHdYNCEeQs42ufOEA62JagMQM1tuhBjxfmWFHAaWU98o+SVJwDMQxTY4jCdkhyj99xI42nxdjfB6VdDw1DAmdqz5lUsfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 132871FB;
	Mon, 29 Jan 2024 01:25:18 -0800 (PST)
Received: from [10.162.42.11] (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B6393F762;
	Mon, 29 Jan 2024 01:24:23 -0800 (PST)
Message-ID: <0a71c87a-ae2c-4a61-8adb-3a51d6369b99@arm.com>
Date: Mon, 29 Jan 2024 14:54:20 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 06/35] mm: cma: Make CMA_ALLOC_SUCCESS/FAIL count
 the number of pages
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
 <20240125164256.4147-7-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-7-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 22:12, Alexandru Elisei wrote:
> The CMA_ALLOC_SUCCESS, respectively CMA_ALLOC_FAIL, are increased by one
> after each cma_alloc() function call. This is done even though cma_alloc()
> can allocate an arbitrary number of CMA pages. When looking at
> /proc/vmstat, the number of successful (or failed) cma_alloc() calls
> doesn't tell much with regards to how many CMA pages were allocated via
> cma_alloc() versus via the page allocator (regular allocation request or
> PCP lists refill).
> 
> This can also be rather confusing to a user who isn't familiar with the
> code, since the unit of measurement for nr_free_cma is the number of pages,
> but cma_alloc_success and cma_alloc_fail count the number of cma_alloc()
> function calls.
> 
> Let's make this consistent, and arguably more useful, by having
> CMA_ALLOC_SUCCESS count the number of successfully allocated CMA pages, and
> CMA_ALLOC_FAIL count the number of pages the cma_alloc() failed to
> allocate.
> 
> For users that wish to track the number of cma_alloc() calls, there are
> tracepoints for that already implemented.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  mm/cma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index f49c95f8ee37..dbf7fe8cb1bd 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -517,10 +517,10 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  	pr_debug("%s(): returned %p\n", __func__, page);
>  out:
>  	if (page) {
> -		count_vm_event(CMA_ALLOC_SUCCESS);
> +		count_vm_events(CMA_ALLOC_SUCCESS, count);
>  		cma_sysfs_account_success_pages(cma, count);
>  	} else {
> -		count_vm_event(CMA_ALLOC_FAIL);
> +		count_vm_events(CMA_ALLOC_FAIL, count);
>  		if (cma)
>  			cma_sysfs_account_fail_pages(cma, count);
>  	}

Without getting into the merits of this patch - which is actually trying to do
semantics change to /proc/vmstat, wondering how is this even related to this
particular series ? If required this could be debated on it's on separately.

