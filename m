Return-Path: <linux-fsdevel+bounces-48208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35849AABF83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF831BC7A5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F724EA8F;
	Tue,  6 May 2025 09:28:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D18D264612;
	Tue,  6 May 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523700; cv=none; b=ma91WYm+USYAMwNrxCTXIlMKEwuEwMgnCJeSS2gMmoXD6/y2uRjMmJbgk4EOv7DoFGxboh27opGJ7Ud5xCzXMS/XA40cq0fRtE4x1cG+EklmISqqRb7Agz8RG9857yGKlOF0pFULlyZXPrx/j4Es+v6FsaEWswamuTMFMOlc49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523700; c=relaxed/simple;
	bh=TWekJb4qyZYdtgSAdCv7eys08bG+0J5r4JLeErttUz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOGoD82BsXImlb7jRFaW3/DN2NHax0Qy2Ho0phGJms/9Qj7t43nWtd+f5fZ0EQp28n1M5U9MENGnjAbcRyQBM1pA+Sohayow9NCRxnIcCTlp1qmZWF/n/dFXcfE6dX013hGTVnV2BhkCLbtT26fCq8VFti3cYIqv0eO7IO+qu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0A28113E;
	Tue,  6 May 2025 02:28:06 -0700 (PDT)
Received: from [10.57.93.118] (unknown [10.57.93.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 754B53F5A1;
	Tue,  6 May 2025 02:28:13 -0700 (PDT)
Message-ID: <cbfad787-fcb8-43ce-8fd9-e9495116534d@arm.com>
Date: Tue, 6 May 2025 10:28:11 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <67wws7qs5v3poq6sefrrt4dgdn4ejh52mg5x7ycbxqvrfdvow3@zraqczowrvrl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2025 10:37, Jan Kara wrote:
> On Mon 05-05-25 11:13:26, Jan Kara wrote:
>> On Wed 30-04-25 15:59:15, Ryan Roberts wrote:
>>> Previously asynchonous readahead would read ra_pages (usually 128K)
>>> directly after the end of the synchonous readahead and given the
>>> synchronous readahead portion had no alignment guarantees (beyond page
>>> boundaries) it is possible (and likely) that the end of the initial 128K
>>> region would not fall on a natural boundary for the folio size being
>>> used. Therefore smaller folios were used to align down to the required
>>> boundary, both at the end of the previous readahead block and at the
>>> start of the new one.
>>>
>>> In the worst cases, this can result in never properly ramping up the
>>> folio size, and instead getting stuck oscillating between order-0, -1
>>> and -2 folios. The next readahead will try to use folios whose order is
>>> +2 bigger than the folio that had the readahead marker. But because of
>>> the alignment requirements, that folio (the first one in the readahead
>>> block) can end up being order-0 in some cases.
>>>
>>> There will be 2 modifications to solve this issue:
>>>
>>> 1) Calculate the readahead size so the end is aligned to a folio
>>>    boundary. This prevents needing to allocate small folios to align
>>>    down at the end of the window and fixes the oscillation problem.
>>>
>>> 2) Remember the "preferred folio order" in the ra state instead of
>>>    inferring it from the folio with the readahead marker. This solves
>>>    the slow ramp up problem (discussed in a subsequent patch).
>>>
>>> This patch addresses (1) only. A subsequent patch will address (2).
>>>
>>> Worked example:
>>>
>>> The following shows the previous pathalogical behaviour when the initial
>>> synchronous readahead is unaligned. We start reading at page 17 in the
>>> file and read sequentially from there. I'm showing a dump of the pages
>>> in the page cache just after we read the first page of the folio with
>>> the readahead marker.
> 
> <snip>
> 
>> Looks good. When I was reading this code some time ago, I also felt we
>> should rather do some rounding instead of creating small folios so thanks
>> for working on this. Feel free to add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> But now I've also remembered why what you do here isn't an obvious win.
> There are storage devices (mostly RAID arrays) where optimum read size
> isn't a power of 2. Think for example a RAID-0 device composed from three
> disks. It will have max_pages something like 384 (512k * 3). Suppose we are
> on x86 and max_order is 9. Then previously (if we were lucky with
> alignment) we were alternating between order 7 and order 8 pages in the
> page cache and do optimally sized IOs od 1536k. 

Sorry I'm struggling to follow some of this, perhaps my superficial
understanding of all the readahead subtleties is starting to show...

How is the 384 figure provided? I'd guess that comes from bdi->io_pages, and
bdi->ra_pages would remain the usual 32 (128K)? In which case, for mmap, won't
we continue to be limited by ra_pages and will never get beyond order-5? (for
mmap req_size is always set to ra_pages IIRC, so ractl_max_pages() always just
returns ra_pages). Or perhaps ra_pages is set to 384 somewhere, but I'm not
spotting it in the code...

I guess you are also implicitly teaching me something about how the block layer
works here too... if there are 2 read requests for an order-7 and order-8, then
the block layer will merge those to a single read (upto the 384 optimal size?)
but if there are 2 reads of order-8 then it won't merge because it would be
bigger than the optimal size and it won't split the second one at the optimal
size either? Have I inferred that correctly?

> Now you will allocate all
> folios of order 8 (nice) but reads will be just 1024k and you'll see
> noticeable drop in read throughput (not nice). Note that this is not just a
> theoretical example but a real case we have hit when doing performance
> testing of servers and for which I was tweaking readahead code in the past.
> 
> So I think we need to tweak this logic a bit. Perhaps we should round_down
> end to the minimum alignment dictated by 'order' and maxpages? Like:
> 
> 1 << min(order, ffs(max_pages) + PAGE_SHIFT - 1)

Sorry I'm staring at this and struggling to understand the "PAGE_SHIFT - 1" part?

I think what you are suggesting is that the patch becomes something like this:

---8<---
+	end = ra->start + ra->size;
+	aligned_end = round_down(end, 1UL << min(order, ilog2(max_pages)));
+	if (aligned_end > ra->start)
+		ra->size -= end - aligned_end;
+	ra->async_size = ra->size;
---8<---

So if max_pages=384, then aligned_end will be aligned down to a maximum of the
previous 1MB boundary?

Thanks,
Ryan

> 
> If you set badly aligned readahead size manually, you will get small pages
> in the page cache but that's just you being stupid. In practice, hardware
> induced readahead size need not be powers of 2 but they are *sane* :).
> 
> 								Honza
> 
>>> diff --git a/mm/readahead.c b/mm/readahead.c
>>> index 8bb316f5a842..82f9f623f2d7 100644
>>> --- a/mm/readahead.c
>>> +++ b/mm/readahead.c
>>> @@ -625,7 +625,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
>>>  	unsigned long max_pages;
>>>  	struct file_ra_state *ra = ractl->ra;
>>>  	pgoff_t index = readahead_index(ractl);
>>> -	pgoff_t expected, start;
>>> +	pgoff_t expected, start, end, aligned_end;
>>>  	unsigned int order = folio_order(folio);
>>>  
>>>  	/* no readahead */
>>> @@ -657,7 +657,6 @@ void page_cache_async_ra(struct readahead_control *ractl,
>>>  		 * the readahead window.
>>>  		 */
>>>  		ra->size = max(ra->size, get_next_ra_size(ra, max_pages));
>>> -		ra->async_size = ra->size;
>>>  		goto readit;
>>>  	}
>>>  
>>> @@ -678,9 +677,13 @@ void page_cache_async_ra(struct readahead_control *ractl,
>>>  	ra->size = start - index;	/* old async_size */
>>>  	ra->size += req_count;
>>>  	ra->size = get_next_ra_size(ra, max_pages);
>>> -	ra->async_size = ra->size;
>>>  readit:
>>>  	order += 2;
>>> +	end = ra->start + ra->size;
>>> +	aligned_end = round_down(end, 1UL << order);
>>> +	if (aligned_end > ra->start)
>>> +		ra->size -= end - aligned_end;
>>> +	ra->async_size = ra->size;
>>>  	ractl->_index = ra->start;
>>>  	page_cache_ra_order(ractl, ra, order);
>>>  }
>>> -- 
>>> 2.43.0
>>>
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR


