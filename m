Return-Path: <linux-fsdevel+bounces-23147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F04927B10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 18:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6CBEB2219E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E501B29B4;
	Thu,  4 Jul 2024 16:23:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF441B29AC;
	Thu,  4 Jul 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110238; cv=none; b=enG2GjIEerl2oF9Q5RAaBAK61o9cMeMNVMzCBAAiO31yGg21XkQuou342C91Dz1GxEFNKYOglRI/ayXpwHBKCaGvHU1nlzHUYv2P1dPjyJLvkwylDf/4wS/GSSxVP6Lk/u19OWwZsqgdCZE8mpMGwjC9dwLlNbOXn03OAkAtlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110238; c=relaxed/simple;
	bh=UtL1heITcTwWfe8XxOhwZmht8CQevgoJ0LRWrx5WrWw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZMcyYob/KeQas7nCDtn8dAYgqS6kiAQaO1+wAnbJ54tGy0Z+F8x0KI7CtA4uSXFwTfFA649zXUOlK0oNJoX3MU+3nFHfQvPbQwjeWOKYitkMtbXRvL2TxzatkgVy0vxHaTx6aXbJ/zpcevo2WrPQIdv7nWiGITkDQ0wJN7eAiAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2431A367;
	Thu,  4 Jul 2024 09:24:20 -0700 (PDT)
Received: from [10.1.29.168] (XHFQ2J9959.cambridge.arm.com [10.1.29.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27F073F762;
	Thu,  4 Jul 2024 09:23:53 -0700 (PDT)
Message-ID: <bdde4008-60db-4717-a6b5-53d77ab76bdb@arm.com>
Date: Thu, 4 Jul 2024 17:23:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/filemap: Allow arch to request folio size for exec
 memory
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240215154059.2863126-1-ryan.roberts@arm.com>
 <Zc6mcDlcnOZIjqGm@dread.disaster.area>
 <58a67051-6d61-4d16-b073-266522907e05@arm.com>
In-Reply-To: <58a67051-6d61-4d16-b073-266522907e05@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

I'm reviving this thread, hoping to make some progress on this. I'd appreciate
your thoughts...


On 16/02/2024 11:18, Ryan Roberts wrote:
> Hi Dave,
> 
> Thanks for taking a look at this! Some comments below...
> 
> On 16/02/2024 00:04, Dave Chinner wrote:
>> On Thu, Feb 15, 2024 at 03:40:59PM +0000, Ryan Roberts wrote:
>>> Change the readahead config so that if it is being requested for an
>>> executable mapping, do a synchronous read of an arch-specified size in a
>>> naturally aligned manner.
>>>
>>> On arm64 if memory is physically contiguous and naturally aligned to the
>>> "contpte" size, we can use contpte mappings, which improves utilization
>>> of the TLB. When paired with the "multi-size THP" changes, this works
>>> well to reduce dTLB pressure. However iTLB pressure is still high due to
>>> executable mappings having a low liklihood of being in the required
>>> folio size and mapping alignment, even when the filesystem supports
>>> readahead into large folios (e.g. XFS).
>>>
>>> The reason for the low liklihood is that the current readahead algorithm
>>> starts with an order-2 folio and increases the folio order by 2 every
>>> time the readahead mark is hit. But most executable memory is faulted in
>>> fairly randomly and so the readahead mark is rarely hit and most
>>> executable folios remain order-2.
>>
>> Yup, this is a bug in the readahead code, and really has nothing to
>> do with executable files, mmap or the architecture.  We don't want
>> some magic new VM_EXEC min folio size per architecture thingy to be
>> set - we just want readahead to do the right thing.
> 
> It sounds like we agree that there is a bug but we don't agree on what the bug
> is? My view is that executable segments are accessed in a ~random manner and
> therefore readahead (as currently configured) is not very useful. But data may
> well be accessed more sequentially and therefore readahead is useful. Given both
> data and text can come from the same file, I don't think this can just be a
> mapping setting? (my understanding is that there is one "mapping" for the whole
> file?) So we need to look to VM_EXEC for that decision.

Additionally, what is "the right thing" in your view?

> 
>>
>> Indeed, we are already adding a mapping minimum folio order
>> directive to the address space to allow for filesystem block sizes
>> greater than PAGE_SIZE. That's the generic mechanism that this
>> functionality requires. See here:
>>
>> https://lore.kernel.org/linux-xfs/20240213093713.1753368-5-kernel@pankajraghav.com/
> 
> Great, I'm vaguely aware of this work, but haven't looked in detail. I'll go
> read it. But from your brief description, IIUC, this applies to the whole file,
> and is a constraint put in place by the filesystem? Applying to the whole file
> may make sense - that means more opportunity for contpte mappings for data pages
> too, although I guess this adds more scope for write amplificaiton because data
> tends to be writable, and text isn't. But for my use case, its not a hard
> constraint, its just a preference which can improve performance. And the
> filesystem is the wrong place to make the decision; its the arch that knows
> about the performacne opportunities with different block mapping sizes.

Having finally taken a proper look at this, I still have the same opinion. I
don't think this (hard) minimum folio order work is the right fit for what I'm
trying to achieve. I need a soft minimum that can still fall back to order-0 (or
the min mapping order), and ideally I want a different soft minimum to be
applied to different parts of the file (exec vs other).

I'm currently thinking about abandoning the arch hook and replacing with sysfs
ABI akin to the mTHP interface. The idea would be that for each size, you could
specify 'never', 'always', 'exec' or 'always+exec'. A maximum one size would be
allowed be marked as 'exec' at a time. The set of sizes marked 'always' would be
the ones considered in page_cache_ra_order(), with fallback to order-0 (or min
mapping order) still allowed. If a size is marked 'exec' then we would take
VM_EXEC path added by this patch and do sync read into folio of that size.

This obviously expands the scope somewhat, but I suspect having the ability to
control the folio orders that get allocated by the pagecache will also help
reduce large folio allocation failure due to fragmentation; if only a couple
folios sizes are in operation in a given system, you are more likely to be able
to reclaim the size that you need.

All just a thought experiment at the moment, and I'll obviously do some
prototyping and large folio allocation success rate measurements. I appreciate
that we don't want to add sysfs controls without good justification. But I
wonder if this could be a more pallatable solution to people, at least in principle?

Thanks,
Ryan

> 
> As a side note, concerns have been expressed about the possibility of physical
> memory fragmentation becoming problematic, meaning we degrade back to small
> folios over time with my mTHP work. The intuituon is that if the whole system is
> using a few folio sizes in ~equal quantities then we might be ok, but I don't
> have any data yet. Do you have any data on fragmentation? I guess this could be
> more concerning for your use case?
> 
>>
>> (Probably worth reading some of the other readahead mods in that
>> series and the discussion because readahead needs to ensure that it
>> fill entire high order folios in a single IO to avoid partial folio
>> up-to-date states from partial reads.)
>>
>> IOWs, it seems to me that we could use this proposed generic mapping
>> min order functionality when mmap() is run and VM_EXEC is set to set
>> the min order to, say, 64kB. Then the readahead code would simply do
>> the right thing, as would all other reads and writes to that
>> mapping.
> 
> Ahh yes, hooking into your new logic to set a min order based on VM_EXEC sounds
> perfect...
> 
>>
>> We could trigger this in the ->mmap() method of the filesystem so
>> that filesysetms that can use large folios can turn it on, whilst
>> other filesystems remain blissfully unaware of the functionality.
>> Filesystems could also do smarter things here, too. eg. enable PMD
>> alignment for large mapped files....
> 
> ...but I don't think the filesystem is the right place. The size preference
> should be driven by arch IMHO.
> 
> Thanks,
> Ryan
> 
>>
>> -Dave.
> 


