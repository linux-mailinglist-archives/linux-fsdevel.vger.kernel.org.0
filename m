Return-Path: <linux-fsdevel+bounces-4228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8EE7FDF73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607A4B209D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF38C5DF12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E02CAB0;
	Wed, 29 Nov 2023 08:48:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96AD0C15;
	Wed, 29 Nov 2023 08:49:40 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69D1A3F73F;
	Wed, 29 Nov 2023 08:48:47 -0800 (PST)
Message-ID: <52de3aca-41b1-471e-8f87-1a77de547510@arm.com>
Date: Wed, 29 Nov 2023 16:48:43 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] iommu/fsl: use page allocation function provided by
 iommu-pages.h
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com,
 alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev,
 baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org,
 corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
 heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
 jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 kevin.tian@intel.com, krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st,
 mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com,
 netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org,
 samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
 thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
 vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
 will@kernel.org, yu-cheng.yu@intel.com
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-9-pasha.tatashin@soleen.com>
 <1c6156de-c6c7-43a7-8c34-8239abee3978@arm.com>
 <CA+CK2bCOtwZxTUS60PHOQ3szXdCzau7OpopgFEbbC6a9Frxafg@mail.gmail.com>
 <20231128235037.GC1312390@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231128235037.GC1312390@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/11/2023 11:50 pm, Jason Gunthorpe wrote:
> On Tue, Nov 28, 2023 at 06:00:13PM -0500, Pasha Tatashin wrote:
>> On Tue, Nov 28, 2023 at 5:53 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
>>>> Convert iommu/fsl_pamu.c to use the new page allocation functions
>>>> provided in iommu-pages.h.
>>>
>>> Again, this is not a pagetable. This thing doesn't even *have* pagetables.
>>>
>>> Similar to patches #1 and #2 where you're lumping in configuration
>>> tables which belong to the IOMMU driver itself, as opposed to pagetables
>>> which effectively belong to an IOMMU domain's user. But then there are
>>> still drivers where you're *not* accounting similar configuration
>>> structures, so I really struggle to see how this metric is useful when
>>> it's so completely inconsistent in what it's counting :/
>>
>> The whole IOMMU subsystem allocates a significant amount of kernel
>> locked memory that we want to at least observe. The new field in
>> vmstat does just that: it reports ALL buddy allocator memory that
>> IOMMU allocates. However, for accounting purposes, I agree, we need to
>> do better, and separate at least iommu pagetables from the rest.
>>
>> We can separate the metric into two:
>> iommu pagetable only
>> iommu everything
>>
>> or into three:
>> iommu pagetable only
>> iommu dma
>> iommu everything
>>
>> What do you think?
> 
> I think I said this at LPC - if you want to have fine grained
> accounting of memory by owner you need to go talk to the cgroup people
> and come up with something generic. Adding ever open coded finer
> category breakdowns just for iommu doesn't make alot of sense.
> 
> You can make some argument that the pagetable memory should be counted
> because kvm counts it's shadow memory, but I wouldn't go into further
> detail than that with hand coded counters..

Right, pagetable memory is interesting since it's something that any 
random kernel user can indirectly allocate via iommu_domain_alloc() and 
iommu_map(), and some of those users may even be doing so on behalf of 
userspace. I have no objection to accounting and potentially applying 
limits to *that*.

Beyond that, though, there is nothing special about "the IOMMU 
subsystem". The amount of memory an IOMMU driver needs to allocate for 
itself in order to function is not of interest beyond curiosity, it just 
is what it is; limiting it would only break the IOMMU, and if a user 
thinks it's "too much", the only actionable thing that might help is to 
physically remove devices from the system. Similar for DMA buffers; it 
might be intriguing to account those, but it's not really an actionable 
metric - in the overwhelming majority of cases you can't simply tell a 
driver to allocate less than what it needs. And that is of course 
assuming if we were to account *all* DMA buffers, since whether they 
happen to have an IOMMU translation or not is irrelevant (we'd have 
already accounted the pagetables as pagetables if so).

I bet "the networking subsystem" also consumes significant memory on the 
same kind of big systems where IOMMU pagetables would be of any concern. 
I believe some of the some of the "serious" NICs can easily run up 
hundreds of megabytes if not gigabytes worth of queues, SKB pools, etc. 
- would you propose accounting those too?

Thanks,
Robin.

