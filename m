Return-Path: <linux-fsdevel+bounces-9299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB55583FDD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 06:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BD01F220BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5CE45973;
	Mon, 29 Jan 2024 05:49:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C111B45943;
	Mon, 29 Jan 2024 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706507357; cv=none; b=If9cq3lKCaIBvsaUYDibtUaHaf2U/vYuWKfDQfGhCR37vnAfU0iJbnY05xvNhBy6HNVJmsCPirJDsh5B3W8DKipsDx/rY7+XZPRW/1PNvTsScH5ZcEFkVU170FPI5NZB6vlC5RLs6mh7TMbAjqFkBORvGEDxOC+cIlnAzny5PBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706507357; c=relaxed/simple;
	bh=AWasQUbqZiM/R0+/2rSO2QGaQHNgdhLqIuFAfqceT2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMwUGNQwK7EUOgXhydjWcXXXzdJFcu5QneUZB3XMzqWV1bPblIHMUnxi4NUA7z6k0TjLyyxMMy6rGHVQifw0inOXC+APG2tEllKkE73ejX78JCIWAYjR9XFOVM7WoWqMsNSvGY5sKkF3z8bEcZkyP21RpbjoHo6sfXVer6Pu/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 958931FB;
	Sun, 28 Jan 2024 21:49:57 -0800 (PST)
Received: from [10.162.42.11] (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FAE33F5A1;
	Sun, 28 Jan 2024 21:49:02 -0800 (PST)
Message-ID: <de0c74b3-0c7d-4f21-8454-659e8b616ea7@arm.com>
Date: Mon, 29 Jan 2024 11:18:59 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 01/35] mm: page_alloc: Add gfp_flags parameter to
 arch_alloc_page()
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
 <20240125164256.4147-2-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-2-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/25/24 22:12, Alexandru Elisei wrote:
> Extend the usefulness of arch_alloc_page() by adding the gfp_flags
> parameter.

Although the change here is harmless in itself, it will definitely benefit
from some additional context explaining the rationale, taking into account
why-how arch_alloc_page() got added particularly for s390 platform and how
it's going to be used in the present proposal.

> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> 
> Changes since rfc v2:
> 
> * New patch.
> 
>  arch/s390/include/asm/page.h | 2 +-
>  arch/s390/mm/page-states.c   | 2 +-
>  include/linux/gfp.h          | 2 +-
>  mm/page_alloc.c              | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
> index 73b9c3bf377f..859f0958c574 100644
> --- a/arch/s390/include/asm/page.h
> +++ b/arch/s390/include/asm/page.h
> @@ -163,7 +163,7 @@ static inline int page_reset_referenced(unsigned long addr)
>  
>  struct page;
>  void arch_free_page(struct page *page, int order);
> -void arch_alloc_page(struct page *page, int order);
> +void arch_alloc_page(struct page *page, int order, gfp_t gfp_flags);
>  
>  static inline int devmem_is_allowed(unsigned long pfn)
>  {
> diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
> index 01f9b39e65f5..b986c8b158e3 100644
> --- a/arch/s390/mm/page-states.c
> +++ b/arch/s390/mm/page-states.c
> @@ -21,7 +21,7 @@ void arch_free_page(struct page *page, int order)
>  	__set_page_unused(page_to_virt(page), 1UL << order);
>  }
>  
> -void arch_alloc_page(struct page *page, int order)
> +void arch_alloc_page(struct page *page, int order, gfp_t gfp_flags)
>  {
>  	if (!cmma_flag)
>  		return;
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index de292a007138..9e8aa3d144db 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -172,7 +172,7 @@ static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>  static inline void arch_free_page(struct page *page, int order) { }
>  #endif
>  #ifndef HAVE_ARCH_ALLOC_PAGE
> -static inline void arch_alloc_page(struct page *page, int order) { }
> +static inline void arch_alloc_page(struct page *page, int order, gfp_t gfp_flags) { }
>  #endif
>  
>  struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 150d4f23b010..2c140abe5ee6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1485,7 +1485,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	set_page_private(page, 0);
>  	set_page_refcounted(page);
>  
> -	arch_alloc_page(page, order);
> +	arch_alloc_page(page, order, gfp_flags);
>  	debug_pagealloc_map_pages(page, 1 << order);
>  
>  	/*

Otherwise LGTM.

