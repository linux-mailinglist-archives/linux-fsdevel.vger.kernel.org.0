Return-Path: <linux-fsdevel+bounces-48263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F04AAC990
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A70E1B66B0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E7F283FC9;
	Tue,  6 May 2025 15:31:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708F92836B0;
	Tue,  6 May 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545489; cv=none; b=AvyIah3SWqjF5slcsvP7Jhbd8bald7XZ5RspNUvg6By9scgCjzTst8NTmOJlJE8hrLKdmiQXFGxY76k7X9WGwx3T6ihxpEXkVBhavBoeRWbvaQR1pcd7SRH4VwGb5TryOmfhmDm8aUYq/PP/na81qzUvFk/XwgQXZythhwQFspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545489; c=relaxed/simple;
	bh=UrNXyeYl+V8x0w7EUFiAgiCKNWcCDzs5i+6RQbj5SPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qd8zl0vHuOu5GcOi8v41xuILeGCak0O7NiDHTeBjFDey2umQMIWyWSOOeRn2ZPAbBmfEiHXOZGc1h+E87eQfm/NxHvFfm+tw5BGmeYBR//z/k+jQdo2k3wDqNTjsib9aFR6bfIelZOCRYF6P3hHRNX5y6nxw01VcF+FEdPLI0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C46B7339;
	Tue,  6 May 2025 08:31:16 -0700 (PDT)
Received: from [10.1.29.178] (XHFQ2J9959.cambridge.arm.com [10.1.29.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D80E03F58B;
	Tue,  6 May 2025 08:31:23 -0700 (PDT)
Message-ID: <2e32bae4-aa94-4620-8df5-c135d846b107@arm.com>
Date: Tue, 6 May 2025 16:31:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/5] mm/readahead: Terminate async readahead on
 natural boundary
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-3-ryan.roberts@arm.com>
 <3myknukhnrtdb4y5i6ewcgpubg2fopxc35ii6a4oy5ffgn7xdf@uileryotgd7z>
 <67wws7qs5v3poq6sefrrt4dgdn4ejh52mg5x7ycbxqvrfdvow3@zraqczowrvrl>
 <cbfad787-fcb8-43ce-8fd9-e9495116534d@arm.com>
 <mq7vno6v7mrrquya4kogseej4fasfyq574ersgdxdhateho7md@bvmy6y4ccgyz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <mq7vno6v7mrrquya4kogseej4fasfyq574ersgdxdhateho7md@bvmy6y4ccgyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2025 12:29, Jan Kara wrote:
> On Tue 06-05-25 10:28:11, Ryan Roberts wrote:
>> On 05/05/2025 10:37, Jan Kara wrote:
>>> On Mon 05-05-25 11:13:26, Jan Kara wrote:
>>>> On Wed 30-04-25 15:59:15, Ryan Roberts wrote:
>>>>> Previously asynchonous readahead would read ra_pages (usually 128K)
>>>>> directly after the end of the synchonous readahead and given the
>>>>> synchronous readahead portion had no alignment guarantees (beyond page
>>>>> boundaries) it is possible (and likely) that the end of the initial 128K
>>>>> region would not fall on a natural boundary for the folio size being
>>>>> used. Therefore smaller folios were used to align down to the required
>>>>> boundary, both at the end of the previous readahead block and at the
>>>>> start of the new one.
>>>>>
>>>>> In the worst cases, this can result in never properly ramping up the
>>>>> folio size, and instead getting stuck oscillating between order-0, -1
>>>>> and -2 folios. The next readahead will try to use folios whose order is
>>>>> +2 bigger than the folio that had the readahead marker. But because of
>>>>> the alignment requirements, that folio (the first one in the readahead
>>>>> block) can end up being order-0 in some cases.
>>>>>
>>>>> There will be 2 modifications to solve this issue:
>>>>>
>>>>> 1) Calculate the readahead size so the end is aligned to a folio
>>>>>    boundary. This prevents needing to allocate small folios to align
>>>>>    down at the end of the window and fixes the oscillation problem.
>>>>>
>>>>> 2) Remember the "preferred folio order" in the ra state instead of
>>>>>    inferring it from the folio with the readahead marker. This solves
>>>>>    the slow ramp up problem (discussed in a subsequent patch).
>>>>>
>>>>> This patch addresses (1) only. A subsequent patch will address (2).
>>>>>
>>>>> Worked example:
>>>>>
>>>>> The following shows the previous pathalogical behaviour when the initial
>>>>> synchronous readahead is unaligned. We start reading at page 17 in the
>>>>> file and read sequentially from there. I'm showing a dump of the pages
>>>>> in the page cache just after we read the first page of the folio with
>>>>> the readahead marker.
>>>
>>> <snip>
>>>
>>>> Looks good. When I was reading this code some time ago, I also felt we
>>>> should rather do some rounding instead of creating small folios so thanks
>>>> for working on this. Feel free to add:
>>>>
>>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>
>>> But now I've also remembered why what you do here isn't an obvious win.
>>> There are storage devices (mostly RAID arrays) where optimum read size
>>> isn't a power of 2. Think for example a RAID-0 device composed from three
>>> disks. It will have max_pages something like 384 (512k * 3). Suppose we are
>>> on x86 and max_order is 9. Then previously (if we were lucky with
>>> alignment) we were alternating between order 7 and order 8 pages in the
>>> page cache and do optimally sized IOs od 1536k. 
>>
>> Sorry I'm struggling to follow some of this, perhaps my superficial
>> understanding of all the readahead subtleties is starting to show...
>>
>> How is the 384 figure provided? I'd guess that comes from bdi->io_pages, and
>> bdi->ra_pages would remain the usual 32 (128K)?
> 
> Sorry, I have been probably too brief in my previous message :)
> bdi->ra_pages is actually set based on optimal IO size reported by the
> hardware (see blk_apply_bdi_limits() and how its callers are filling in
> lim->io_opt). The 128K you speak about is just a last-resort value if
> hardware doesn't provide one. And some storage devices do report optimal IO
> size that is not power of two.

Ahh, got it - thanks for the education!

> 
> Also note that bdi->ra_pages can be tuned in sysfs and a lot of users
> actually do this (usually from their udev rules). We don't have to perform
> well when some odd value gets set but you definitely cannot assume
> bdi->ra_pages is 128K :).
> 
>> In which case, for mmap, won't
>> we continue to be limited by ra_pages and will never get beyond order-5? (for
>> mmap req_size is always set to ra_pages IIRC, so ractl_max_pages() always just
>> returns ra_pages). Or perhaps ra_pages is set to 384 somewhere, but I'm not
>> spotting it in the code...
>>
>> I guess you are also implicitly teaching me something about how the block layer
>> works here too... if there are 2 read requests for an order-7 and order-8, then
>> the block layer will merge those to a single read (upto the 384 optimal size?)
> 
> Correct. In fact readahead code will already perform this merging when
> submitting the IO.
> 
>> but if there are 2 reads of order-8 then it won't merge because it would be
>> bigger than the optimal size and it won't split the second one at the optimal
>> size either? Have I inferred that correctly?
> 
> With the code as you modify it, you would round down ra->size from 384 to
> 256 and submit only one 1MB sized IO (with one order-8 page). And this will
> cause regression in read throughput for such devices because they now don't
> get buffer large enough to run at full speed.

Ahha, yes, thanks - now it's clicking.

> 
>>> Now you will allocate all
>>> folios of order 8 (nice) but reads will be just 1024k and you'll see
>>> noticeable drop in read throughput (not nice). Note that this is not just a
>>> theoretical example but a real case we have hit when doing performance
>>> testing of servers and for which I was tweaking readahead code in the past.
>>>
>>> So I think we need to tweak this logic a bit. Perhaps we should round_down
>>> end to the minimum alignment dictated by 'order' and maxpages? Like:
>>>
>>> 1 << min(order, ffs(max_pages) + PAGE_SHIFT - 1)
>>
>> Sorry I'm staring at this and struggling to understand the "PAGE_SHIFT -
>> 1" part?
> 
> My bad. It should have been:
> 
> 1 << min(order, ffs(max_pages) - 1)
> 
>> I think what you are suggesting is that the patch becomes something like
>> this:
>>
>> ---8<---
>> +	end = ra->start + ra->size;
>> +	aligned_end = round_down(end, 1UL << min(order, ilog2(max_pages)));
> 
> Not quite. ilog2() returns the most significant bit set but we really want
> to align to the least significant bit set. So when max_pages is 384, we
> want to align to at most order-7 (aligning the end more does not make sense
> when you want to do IO 384 pages large). That's why I'm using ffs() and not
> ilog2().

Yep got it now.

> 
>> +	if (aligned_end > ra->start)
>> +		ra->size -= end - aligned_end;
>> +	ra->async_size = ra->size;
>> ---8<---
>>
>> So if max_pages=384, then aligned_end will be aligned down to a maximum
>> of the previous 1MB boundary?
> 
> No, it needs to be aligned only to previous 512K boundary because we want
> to do IOs 3*512K large.
> 
> Hope things are a bit clearer now :)

Yes, much!

Thanks,
Ryan

> 
> 								Honza


