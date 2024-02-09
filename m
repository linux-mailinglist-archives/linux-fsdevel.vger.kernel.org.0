Return-Path: <linux-fsdevel+bounces-10956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A61284F621
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97ED1F247C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3ED3C47B;
	Fri,  9 Feb 2024 13:44:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9163C1E487;
	Fri,  9 Feb 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486273; cv=none; b=rOzSdRK74HWJATeBOOsmLIRQibFEhUQqG5AWZLhcfy6x0AvhSM1R8f07LUnNGoXQOWhIB1u+9+iogqcPn9o9rxbt0JzOjEHlY7iRsqzqrE+gnDnWHeydw+4GnnY3JLlVsyfgHnJsbR3Z3pUMlLrdghFMFdaY1Nid6mFqnCSKnMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486273; c=relaxed/simple;
	bh=IgoMaZM9kw0Wpb/KvMD5/2YbdK7ysD6H6KO4z/h6t3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GRwhBcmNdbztbLvfU4ZBAvyrnWm9cP5u4UEQPreprYqaBW+cgY+zOqdsjzj9AcFQAyCiQoj3omwYDhuxhpdOS3P8/lCGKFogKNLE4K4pfeNY7pGrzVapY1BLHIMgAZfYrMdEa8cms1ab+/3Yn7L2VOFOCPpqNBKac98e442OQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D9BDA7;
	Fri,  9 Feb 2024 05:45:09 -0800 (PST)
Received: from [10.57.47.119] (unknown [10.57.47.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0283F762;
	Fri,  9 Feb 2024 05:44:21 -0800 (PST)
Message-ID: <8ce2cd7b-7702-45aa-b4c8-25a01c27ed83@arm.com>
Date: Fri, 9 Feb 2024 13:44:20 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] iommu/vt-d: add wrapper functions for page
 allocations
Content-Language: en-GB
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev,
 baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org,
 corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
 heiko@sntech.de, iommu@lists.linux.dev, jernej.skrabec@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, krzysztof.kozlowski@linaro.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 lizefan.x@bytedance.com, marcan@marcan.st, mhiramat@kernel.org,
 m.szyprowski@samsung.com, paulmck@kernel.org, rdunlap@infradead.org,
 samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
 thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
 vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com,
 rientjes@google.com, bagasdotme@gmail.com, mkoutny@suse.com
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
 <20240207174102.1486130-2-pasha.tatashin@soleen.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240207174102.1486130-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-07 5:40 pm, Pasha Tatashin wrote:
[...]> diff --git a/drivers/iommu/iommu-pages.h 
b/drivers/iommu/iommu-pages.h
> new file mode 100644
> index 000000000000..c412d0aaa399
> --- /dev/null
> +++ b/drivers/iommu/iommu-pages.h
> @@ -0,0 +1,204 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +#ifndef __IOMMU_PAGES_H
> +#define __IOMMU_PAGES_H
> +
> +#include <linux/vmstat.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +
> +/*
> + * All page allocation that are performed in the IOMMU subsystem must use one of

"All page allocations" is too broad; As before, this is only about 
pagetable allocations, or I guess for the full nuance, allocations of 
pagetables and other per-iommu_domain configuration structures which are 
reasonable to report as "pagetables" to userspace.

> + * the functions below.  This is necessary for the proper accounting as IOMMU
> + * state can be rather large, i.e. multiple gigabytes in size.
> + */
> +
> +/**
> + * __iommu_alloc_pages_node - allocate a zeroed page of a given order from
> + * specific NUMA node.
> + * @nid: memory NUMA node id
> + * @gfp: buddy allocator flags
> + * @order: page order
> + *
> + * returns the head struct page of the allocated page.
> + */
> +static inline struct page *__iommu_alloc_pages_node(int nid, gfp_t gfp,
> +						    int order)
> +{
> +	struct page *page;
> +
> +	page = alloc_pages_node(nid, gfp | __GFP_ZERO, order);
> +	if (unlikely(!page))
> +		return NULL;
> +
> +	return page;
> +}

All 3 invocations of this only use the returned struct page to trivially 
derive page_address(), so we really don't need it; just clean up these 
callsites a bit more.

> +
> +/**
> + * __iommu_alloc_pages - allocate a zeroed page of a given order.
> + * @gfp: buddy allocator flags
> + * @order: page order
> + *
> + * returns the head struct page of the allocated page.
> + */
> +static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
> +{
> +	struct page *page;
> +
> +	page = alloc_pages(gfp | __GFP_ZERO, order);
> +	if (unlikely(!page))
> +		return NULL;
> +
> +	return page;
> +}

Same for the single invocation of this one.

> +
> +/**
> + * __iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
> + * @nid: memory NUMA node id
> + * @gfp: buddy allocator flags
> + *
> + * returns the struct page of the allocated page.
> + */
> +static inline struct page *__iommu_alloc_page_node(int nid, gfp_t gfp)
> +{
> +	return __iommu_alloc_pages_node(nid, gfp, 0);
> +}

There are no users of this at all.

> +
> +/**
> + * __iommu_alloc_page - allocate a zeroed page
> + * @gfp: buddy allocator flags
> + *
> + * returns the struct page of the allocated page.
> + */
> +static inline struct page *__iommu_alloc_page(gfp_t gfp)
> +{
> +	return __iommu_alloc_pages(gfp, 0);
> +}
> +
> +/**
> + * __iommu_free_pages - free page of a given order
> + * @page: head struct page of the page
> + * @order: page order
> + */
> +static inline void __iommu_free_pages(struct page *page, int order)
> +{
> +	if (!page)
> +		return;
> +
> +	__free_pages(page, order);
> +}
> +
> +/**
> + * __iommu_free_page - free page
> + * @page: struct page of the page
> + */
> +static inline void __iommu_free_page(struct page *page)
> +{
> +	__iommu_free_pages(page, 0);
> +}

Beyond one more trivial Intel cleanup for __iommu_alloc_pages(), these 3 
are then only used by tegra-smmu, so honestly I'd be inclined to just 
open-code there page_address()/virt_to_page() conversions as appropriate 
there (once again I think the whole thing could in fact be refactored to 
not use struct pages at all because all it's ever ultimately doing with 
them is page_address(), but that would be a bigger job so definitely 
out-of-scope for this series).

> +
> +/**
> + * iommu_alloc_pages_node - allocate a zeroed page of a given order from
> + * specific NUMA node.
> + * @nid: memory NUMA node id
> + * @gfp: buddy allocator flags
> + * @order: page order
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_pages_node(int nid, gfp_t gfp, int order)
> +{
> +	struct page *page = __iommu_alloc_pages_node(nid, gfp, order);
> +
> +	if (unlikely(!page))
> +		return NULL;

As a general point I'd prefer to fold these checks into the accounting 
function itself rather than repeat them all over.

> +
> +	return page_address(page);
> +}
> +
> +/**
> + * iommu_alloc_pages - allocate a zeroed page of a given order
> + * @gfp: buddy allocator flags
> + * @order: page order
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_pages(gfp_t gfp, int order)
> +{
> +	struct page *page = __iommu_alloc_pages(gfp, order);
> +
> +	if (unlikely(!page))
> +		return NULL;
> +
> +	return page_address(page);
> +}
> +
> +/**
> + * iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
> + * @nid: memory NUMA node id
> + * @gfp: buddy allocator flags
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_page_node(int nid, gfp_t gfp)
> +{
> +	return iommu_alloc_pages_node(nid, gfp, 0);
> +}

TBH I'm not entirely convinced that saving 4 characters per invocation 
times 11 invocations makes this wrapper worthwhile :/

> +
> +/**
> + * iommu_alloc_page - allocate a zeroed page
> + * @gfp: buddy allocator flags
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_page(gfp_t gfp)
> +{
> +	return iommu_alloc_pages(gfp, 0);
> +}
> +
> +/**
> + * iommu_free_pages - free page of a given order
> + * @virt: virtual address of the page to be freed.
> + * @order: page order
> + */
> +static inline void iommu_free_pages(void *virt, int order)
> +{
> +	if (!virt)
> +		return;
> +
> +	__iommu_free_pages(virt_to_page(virt), order);
> +}
> +
> +/**
> + * iommu_free_page - free page
> + * @virt: virtual address of the page to be freed.
> + */
> +static inline void iommu_free_page(void *virt)
> +{
> +	iommu_free_pages(virt, 0);
> +}
> +
> +/**
> + * iommu_free_pages_list - free a list of pages.
> + * @page: the head of the lru list to be freed.
> + *
> + * There are no locking requirement for these pages, as they are going to be
> + * put on a free list as soon as refcount reaches 0. Pages are put on this LRU
> + * list once they are removed from the IOMMU page tables. However, they can
> + * still be access through debugfs.
> + */
> +static inline void iommu_free_pages_list(struct list_head *page)

Nit: I'd be inclined to call this iommu_put_pages_list for consistency.

> +{
> +	while (!list_empty(page)) {
> +		struct page *p = list_entry(page->prev, struct page, lru);
> +
> +		list_del(&p->lru);
> +		put_page(p);
> +	}
> +}

I realise now you've also missed the common freelist freeing sites in 
iommu-dma.

Thanks,
Robin.

> +
> +#endif	/* __IOMMU_PAGES_H */

