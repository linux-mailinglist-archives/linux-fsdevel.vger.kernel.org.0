Return-Path: <linux-fsdevel+bounces-11405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C085378E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662C528A8B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AEE5FF15;
	Tue, 13 Feb 2024 17:26:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1035F54E;
	Tue, 13 Feb 2024 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845197; cv=none; b=R1bYXXkVa4eSjI5bzrWNcIqyHTGQ7e5foFalkIsNMZLrsAbs1RpzkqLm2DcpwV3EbmMTRUQIIbK4tp+kFybwcvXJ+GDnNJHlbG3QjLbafVbjNFjtfzmxqnK6W/kt+dkTy4hYGkHi2Dx0Zs1o1BF8Y/RZHBhl8U7j6M5PmDwuNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845197; c=relaxed/simple;
	bh=R4W/x6sdikq9L5mixsfBJrQlDgWaZ0hlbKehGewQpgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bpv+ETvxc3uxOp4XmDz1Cw1ZpprtDQkn21HxeeumLOTto2Pwqc4ZcK9AdTuuAt1RoKaCGiTYqnsIVqcm1sTphAFRNZOgFzk8+0q3Tp/T7m2zYuNFIB+FzecHVP5kv7kvriGoBM9WcbuUF/jrm+6O2B42GsQCL+MpSZroLNydico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 724E71FB;
	Tue, 13 Feb 2024 09:27:15 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155943F5A1;
	Tue, 13 Feb 2024 09:26:27 -0800 (PST)
Message-ID: <b008bd2d-a189-481f-917d-bb045c43cb07@arm.com>
Date: Tue, 13 Feb 2024 17:26:26 +0000
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
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io,
 asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com,
 cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
 dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
 iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com,
 joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st,
 mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org,
 rdunlap@infradead.org, samuel@sholland.org, suravee.suthikulpanit@amd.com,
 sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
 tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org,
 yu-cheng.yu@intel.com, rientjes@google.com, bagasdotme@gmail.com,
 mkoutny@suse.com
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
 <20240207174102.1486130-2-pasha.tatashin@soleen.com>
 <8ce2cd7b-7702-45aa-b4c8-25a01c27ed83@arm.com>
 <CA+CK2bC=XyUhoSP9f0XBqEnQ-P5mMT2U=5dfzRSc9C=2b+bstQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CA+CK2bC=XyUhoSP9f0XBqEnQ-P5mMT2U=5dfzRSc9C=2b+bstQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/02/2024 2:21 am, Pasha Tatashin wrote:
[...]
>>> +/**
>>> + * iommu_alloc_pages_node - allocate a zeroed page of a given order from
>>> + * specific NUMA node.
>>> + * @nid: memory NUMA node id
>>> + * @gfp: buddy allocator flags
>>> + * @order: page order
>>> + *
>>> + * returns the virtual address of the allocated page
>>> + */
>>> +static inline void *iommu_alloc_pages_node(int nid, gfp_t gfp, int order)
>>> +{
>>> +     struct page *page = __iommu_alloc_pages_node(nid, gfp, order);
>>> +
>>> +     if (unlikely(!page))
>>> +             return NULL;
>>
>> As a general point I'd prefer to fold these checks into the accounting
>> function itself rather than repeat them all over.
> 
> For the free functions this saves a few cycles by not repeating this
> check again inside __free_pages(), to keep things symmetrical it makes
> sense to keep __iomu_free_account and __iomu_alloc_account the same.
> With the other clean-up there are not that many of these checks left.

__free_pages() doesn't accept NULL, so __iommu_free_pages() shouldn't 
need a check; free_pages() does, but correspondingly iommu_free_pages() 
needs its own check up-front to avoid virt_to_page(NULL); either way it 
means there are no callers of iommu_free_account() who should be passing 
NULL.

The VA-returning allocators of course need to avoid page_address(NULL), 
so I clearly made this comment in the wrong place to begin with, oops. 
In the end I guess that will leave __iommu_alloc_pages() as the only 
caller of iommu_alloc_account() who doesn't already need to handle their 
own NULL. OK, I'm convinced, apologies for having to bounce it off you 
to work it through :)

>>> + */
>>> +static inline void *iommu_alloc_page_node(int nid, gfp_t gfp)
>>> +{
>>> +     return iommu_alloc_pages_node(nid, gfp, 0);
>>> +}
>>
>> TBH I'm not entirely convinced that saving 4 characters per invocation
>> times 11 invocations makes this wrapper worthwhile :/
> 
> Let's keep them. After the clean-up that you suggested, there are
> fewer functions left in this file, but I think that it is cleaner to
> keep these remaining, as it is beneficial to easily distinguish when
> exactly one page is allocated vs when multiple are allocated via code
> search.

But is it, really? It's not at all obvious to me *why* it would be 
significantly interesting to distinguish fixed order-0 allocations from 
higher-order or variable-order (which may still be 0) ones. After all, 
there's no regular alloc_page_node() wrapper, yet plenty more callers of 
alloc_pages_node(..., 0) :/

Thanks,
Robin.

