Return-Path: <linux-fsdevel+bounces-11844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE2857B60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 12:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023881F20F2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE959B60;
	Fri, 16 Feb 2024 11:18:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D4558AA7;
	Fri, 16 Feb 2024 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082314; cv=none; b=qZraVFBDNPPoeyilQcWYlWiRhlupMk8iBBmqwqnJoGyW9N+OfsykmMokhL4CURsDtIeyfPCCHOX3z6Rgzdec+YGBtblAupILPL4ulQ9/ng4YIQUx4z0edJUOZ3IZ/CQ1SOiYp2WU6xC+oPhVDP/jp03R9867OJHKCaigwDCrIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082314; c=relaxed/simple;
	bh=Kq1IJBQVf+kdbuVgTva05BjXKCMAbwrFjoxYlv2wTbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4ihqnNA9MDRrksmCJhv+5x+a8XL0D/veQ2Hv5rhEVccH2BGdqn2rPDURry8HL3A3+d0kUOluzv2684Ci9fuSVQgILFlyYc18RUE7i4/2anS6lgiY4ak/Fpwy/mtcTWDRxNZG8rmxxrwOdrm7ClIqa2485O9/4RwvvkTjEkqIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EDEE1FB;
	Fri, 16 Feb 2024 03:19:11 -0800 (PST)
Received: from [192.168.68.110] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABDD73F766;
	Fri, 16 Feb 2024 03:18:28 -0800 (PST)
Message-ID: <58a67051-6d61-4d16-b073-266522907e05@arm.com>
Date: Fri, 16 Feb 2024 11:18:27 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zc6mcDlcnOZIjqGm@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

Thanks for taking a look at this! Some comments below...

On 16/02/2024 00:04, Dave Chinner wrote:
> On Thu, Feb 15, 2024 at 03:40:59PM +0000, Ryan Roberts wrote:
>> Change the readahead config so that if it is being requested for an
>> executable mapping, do a synchronous read of an arch-specified size in a
>> naturally aligned manner.
>>
>> On arm64 if memory is physically contiguous and naturally aligned to the
>> "contpte" size, we can use contpte mappings, which improves utilization
>> of the TLB. When paired with the "multi-size THP" changes, this works
>> well to reduce dTLB pressure. However iTLB pressure is still high due to
>> executable mappings having a low liklihood of being in the required
>> folio size and mapping alignment, even when the filesystem supports
>> readahead into large folios (e.g. XFS).
>>
>> The reason for the low liklihood is that the current readahead algorithm
>> starts with an order-2 folio and increases the folio order by 2 every
>> time the readahead mark is hit. But most executable memory is faulted in
>> fairly randomly and so the readahead mark is rarely hit and most
>> executable folios remain order-2.
> 
> Yup, this is a bug in the readahead code, and really has nothing to
> do with executable files, mmap or the architecture.  We don't want
> some magic new VM_EXEC min folio size per architecture thingy to be
> set - we just want readahead to do the right thing.

It sounds like we agree that there is a bug but we don't agree on what the bug
is? My view is that executable segments are accessed in a ~random manner and
therefore readahead (as currently configured) is not very useful. But data may
well be accessed more sequentially and therefore readahead is useful. Given both
data and text can come from the same file, I don't think this can just be a
mapping setting? (my understanding is that there is one "mapping" for the whole
file?) So we need to look to VM_EXEC for that decision.

> 
> Indeed, we are already adding a mapping minimum folio order
> directive to the address space to allow for filesystem block sizes
> greater than PAGE_SIZE. That's the generic mechanism that this
> functionality requires. See here:
> 
> https://lore.kernel.org/linux-xfs/20240213093713.1753368-5-kernel@pankajraghav.com/

Great, I'm vaguely aware of this work, but haven't looked in detail. I'll go
read it. But from your brief description, IIUC, this applies to the whole file,
and is a constraint put in place by the filesystem? Applying to the whole file
may make sense - that means more opportunity for contpte mappings for data pages
too, although I guess this adds more scope for write amplificaiton because data
tends to be writable, and text isn't. But for my use case, its not a hard
constraint, its just a preference which can improve performance. And the
filesystem is the wrong place to make the decision; its the arch that knows
about the performacne opportunities with different block mapping sizes.

As a side note, concerns have been expressed about the possibility of physical
memory fragmentation becoming problematic, meaning we degrade back to small
folios over time with my mTHP work. The intuituon is that if the whole system is
using a few folio sizes in ~equal quantities then we might be ok, but I don't
have any data yet. Do you have any data on fragmentation? I guess this could be
more concerning for your use case?

> 
> (Probably worth reading some of the other readahead mods in that
> series and the discussion because readahead needs to ensure that it
> fill entire high order folios in a single IO to avoid partial folio
> up-to-date states from partial reads.)
> 
> IOWs, it seems to me that we could use this proposed generic mapping
> min order functionality when mmap() is run and VM_EXEC is set to set
> the min order to, say, 64kB. Then the readahead code would simply do
> the right thing, as would all other reads and writes to that
> mapping.

Ahh yes, hooking into your new logic to set a min order based on VM_EXEC sounds
perfect...

> 
> We could trigger this in the ->mmap() method of the filesystem so
> that filesysetms that can use large folios can turn it on, whilst
> other filesystems remain blissfully unaware of the functionality.
> Filesystems could also do smarter things here, too. eg. enable PMD
> alignment for large mapped files....

...but I don't think the filesystem is the right place. The size preference
should be driven by arch IMHO.

Thanks,
Ryan

> 
> -Dave.


