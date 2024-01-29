Return-Path: <linux-fsdevel+bounces-9328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B1983FFEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E461F22F13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C553E1B;
	Mon, 29 Jan 2024 08:20:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB09553E07;
	Mon, 29 Jan 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516402; cv=none; b=MCwyoCcg2GrnIkI5wZq4dCbTNKZglF74qyh7PC65O9QaW8HRPOIUpGz9hJwJIva6897DP83edTYMZw4BXYy5wdHJ31HophgpQ7wSY965a6nZVIsmIVMEEFZW+8jNAGjd98BckJA6sjTbWpLMOcU5KNBP0+faHurRAy6ACuI2Y8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516402; c=relaxed/simple;
	bh=/lbhVQWmoDQHkZRgu7qWrmr97K4vg6zIU1je+zx3+Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIq6fIwg3Fxj8tfT7SdUyWL2WGReY+QsBXtkVsxpFNrzr63FcjXQReJ5EOJ3qCC81fKWqqVjR2QLlxwrAe85faNUM1dJYNPywGACwRvsEs5QhlOz3TLgSRhOizj0ullp2iaLodoiCRM9FfxN+7P0zvygQQhHLFp2hbJvNkxrTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 859F61FB;
	Mon, 29 Jan 2024 00:20:42 -0800 (PST)
Received: from [10.162.42.11] (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920AA3F762;
	Mon, 29 Jan 2024 00:19:47 -0800 (PST)
Message-ID: <8d1c6b04-105e-4fb2-b514-1c5dea0fcce6@arm.com>
Date: Mon, 29 Jan 2024 13:49:44 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 02/35] mm: page_alloc: Add an arch hook early in
 free_pages_prepare()
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
 <20240125164256.4147-3-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-3-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 22:12, Alexandru Elisei wrote:
> The arm64 MTE code uses the PG_arch_2 page flag, which it renames to
> PG_mte_tagged, to track if a page has been mapped with tagging enabled.
> That flag is cleared by free_pages_prepare() by doing:
> 
> 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> 
> When tag storage management is added, tag storage will be reserved for a
> page if and only if the page is mapped as tagged (the page flag
> PG_mte_tagged is set). When a page is freed, likewise, the code will have
> to look at the the page flags to determine if the page has tag storage
> reserved, which should also be freed.
> 
> For this purpose, add an arch_free_pages_prepare() hook that is called
> before that page flags are cleared. The function arch_free_page() has also
> been considered for this purpose, but it is called after the flags are
> cleared.

arch_free_pages_prepare() makes sense as a prologue to arch_free_page().  

s/arch_free_pages_prepare/arch_free_page_prepare to match similar functions.

> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> 
> Changes since rfc v2:
> 
> * Expanded commit message (David Hildenbrand).
> 
>  include/linux/pgtable.h | 4 ++++
>  mm/page_alloc.c         | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index f6d0e3513948..6d98d5fdd697 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -901,6 +901,10 @@ static inline void arch_do_swap_page(struct mm_struct *mm,
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_FREE_PAGES_PREPARE

I guess new __HAVE_ARCH_ constructs are not being added lately. Instead
something like '#ifndef arch_free_pages_prepare' might be better suited.

> +static inline void arch_free_pages_prepare(struct page *page, int order) { }
> +#endif
> +
>  #ifndef __HAVE_ARCH_UNMAP_ONE
>  /*
>   * Some architectures support metadata associated with a page. When a
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2c140abe5ee6..27282a1c82fe 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1092,6 +1092,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  
>  	trace_mm_page_free(page, order);
>  	kmsan_free_page(page, order);
> +	arch_free_pages_prepare(page, order);
>  
>  	if (memcg_kmem_online() && PageMemcgKmem(page))
>  		__memcg_kmem_uncharge_page(page, order);

