Return-Path: <linux-fsdevel+bounces-9623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632FA843699
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1730F1F2882A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 06:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE23E49D;
	Wed, 31 Jan 2024 06:24:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA093F8C7;
	Wed, 31 Jan 2024 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682273; cv=none; b=Ba5O+mAcerI/js1cdBQBIc27u3S9eRKCu+xfQKvLDI2/Xsdkh52zoSVrZxeVUKSps1q6kNzEMD1sYpzQi1w9Ipjc7Ym1WwvYswFK4eZZT+924uithDYjhm3LTFPe6wdRJ0ELjL2FPI9RwQDJB8LBv6TqCLIM8X34eDTqueEzCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682273; c=relaxed/simple;
	bh=Uiy2jl+TmsXsize8jHqdUqySPdi0wRe5XPyM63wYQ+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiJDIuHjX5w41KA+00TboYRpUhV8PKoetK0ZPIcf3iD0w24S+AR29uSE1pe66v4ae2lFddhNuHLwtIP/fO+xChI3UFY5jzAP4IW2L6Oijxq56gZW70WFZd5d4ZZ+cWmJlc8RE9uRqW32kB4XA+i/CWjNookkV6HcTBrDnKLv/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95BCDA7;
	Tue, 30 Jan 2024 22:25:13 -0800 (PST)
Received: from [10.163.41.195] (unknown [10.163.41.195])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 307963F738;
	Tue, 30 Jan 2024 22:24:18 -0800 (PST)
Message-ID: <d22f63a0-f6de-44e1-874b-24d707907858@arm.com>
Date: Wed, 31 Jan 2024 11:54:17 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 08/35] mm: cma: Introduce cma_alloc_range()
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
 maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
 pcc@google.com, steven.price@arm.com, vincenzo.frascino@arm.com,
 david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-9-alexandru.elisei@arm.com>
 <61a3dbb7-25b6-4f49-aa70-9a8aaeb53365@arm.com> <ZbjfEzlNgprdxfxX@raptor>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZbjfEzlNgprdxfxX@raptor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/30/24 17:05, Alexandru Elisei wrote:
> Hi,
> 
> On Tue, Jan 30, 2024 at 10:50:00AM +0530, Anshuman Khandual wrote:
>>
>> On 1/25/24 22:12, Alexandru Elisei wrote:
>>> Today, cma_alloc() is used to allocate a contiguous memory region. The
>>> function allows the caller to specify the number of pages to allocate, but
>>> not the starting address. cma_alloc() will walk over the entire CMA region
>>> trying to allocate the first available range of the specified size.
>>>
>>> Introduce cma_alloc_range(), which makes CMA more versatile by allowing the
>>> caller to specify a particular range in the CMA region, defined by the
>>> start pfn and the size.
>>>
>>> arm64 will make use of this function when tag storage management will be
>>> implemented: cma_alloc_range() will be used to reserve the tag storage
>>> associated with a tagged page.
>> Basically, you would like to pass on a preferred start address and the
>> allocation could just fail if a contig range is not available from such
>> a starting address ?
>>
>> Then why not just change cma_alloc() to take a new argument 'start_pfn'.
>> Why create a new but almost similar allocator ?
> I tried doing that, and I gave up because:
> 
> - It made cma_alloc() even more complex and hard to follow.
> 
> - What value should 'start_pfn' be to tell cma_alloc() that it should be
>   ignored? Or, to put it another way, what pfn number is invalid on **all**
>   platforms that Linux supports?
> 
> I can give it another go if we can come up with an invalid value for
> 'start_pfn'.

Something negative might work. How about -1/-1UL ? A quick search gives
some instances such as ...

git grep "pfn == -1"

mm/mm_init.c:   if (*start_pfn == -1UL)
mm/vmscan.c:            if (pfn == -1)
mm/vmscan.c:            if (pfn == -1)
mm/vmscan.c:            if (pfn == -1)
tools/testing/selftests/mm/hugepage-vmemmap.c:  if (pfn == -1UL) {

Could not -1UL be abstracted as common macro MM_INVALID_PFN to be used in
such scenarios including here ?

> 
>> But then I am wondering why this could not be done in the arm64 platform
>> code itself operating on a CMA area reserved just for tag storage. Unless
>> this new allocator has other usage beyond MTE, this could be implemented
>> in the platform itself.
> I had the same idea in the previous iteration, David Hildenbrand suggested
> this approach [1].
> 
> [1] https://lore.kernel.org/linux-fsdevel/2aafd53f-af1f-45f3-a08c-d11962254315@redhat.com/

There are two different cma_alloc() proposals here - including the next
patch i.e mm: cma: Fast track allocating memory when the pages are free

1) Augment cma_alloc() or add cma_alloc_range() with start_pfn parameter
2) Speed up cma_alloc() for small allocation requests when pages are free

The second one if separated out from this series could be considered on
its own as it will help all existing cma_alloc() callers. The first one
definitely needs an use case as provided in this series.

