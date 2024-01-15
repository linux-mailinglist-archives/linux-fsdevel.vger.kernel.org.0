Return-Path: <linux-fsdevel+bounces-7930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0D782D609
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 10:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5CA1C2152E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224E2D308;
	Mon, 15 Jan 2024 09:33:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9473ABE74;
	Mon, 15 Jan 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F10B72F4;
	Mon, 15 Jan 2024 01:34:24 -0800 (PST)
Received: from [10.57.76.47] (unknown [10.57.76.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E5F53F6C4;
	Mon, 15 Jan 2024 01:33:36 -0800 (PST)
Message-ID: <398fdb16-b8c5-4d02-bb5d-d4c9b8f9bf89@arm.com>
Date: Mon, 15 Jan 2024 09:33:35 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] mm/filemap: Allow arch to request folio size for
 exec memory
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20240111154106.3692206-1-ryan.roberts@arm.com>
 <CAGsJ_4xPgmgt57sw2c5==bPN+YL23zn=hZweu8u2ceWei7+q4g@mail.gmail.com>
 <654df189-e472-4a75-b2be-6faa8ba18a08@arm.com>
 <CAGsJ_4zyK4kSF4XYWwLTLN8816KL+u=p6WhyEsRu8PMnQTNRUg@mail.gmail.com>
 <CAGsJ_4y8ovLPp51NcrhTXTAE0DZvSPYTJs8nu6-ny_ierLx-pw@mail.gmail.com>
 <ZaHFbJ2Osd/tpPqN@casper.infradead.org>
 <CAGsJ_4wZzjprAs42LMw8s8C_iz4v7m6fiO7-7nBS2BxkU9u8QA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wZzjprAs42LMw8s8C_iz4v7m6fiO7-7nBS2BxkU9u8QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/01/2024 00:11, Barry Song wrote:
> On Sat, Jan 13, 2024 at 12:04 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Sat, Jan 13, 2024 at 11:54:23AM +1300, Barry Song wrote:
>>>>> Perhaps an alternative would be to double ra->size and set ra->async_size to
>>>>> (ra->size / 2)? That would ensure we always have 64K aligned blocks but would
>>>>> give us an async portion so readahead can still happen.
>>>>
>>>> this might be worth to try as PMD is exactly doing this because async
>>>> can decrease
>>>> the latency of subsequent page faults.
>>>>
>>>> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>         /* Use the readahead code, even if readahead is disabled */
>>>>         if (vm_flags & VM_HUGEPAGE) {
>>>>                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>>>>                 ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
>>>>                 ra->size = HPAGE_PMD_NR;
>>>>                 /*
>>>>                  * Fetch two PMD folios, so we get the chance to actually
>>>>                  * readahead, unless we've been told not to.
>>>>                  */
>>>>                 if (!(vm_flags & VM_RAND_READ))
>>>>                         ra->size *= 2;
>>>>                 ra->async_size = HPAGE_PMD_NR;
>>>>                 page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
>>>>                 return fpin;
>>>>         }
>>>> #endif
>>>>
>>>
>>> BTW, rather than simply always reading backwards,  we did something very
>>> "ugly" to simulate "read-around" for CONT-PTE exec before[1]
>>>
>>> if page faults happen in the first half of cont-pte, we read this 64KiB
>>> and its previous 64KiB. otherwise, we read it and its next 64KiB.

I actually tried something very similar to this while prototyping. I found that
it was about 10% less effective at getting text into 64K folios as the approach
I posted. I didn't investigate why, as I came to the conclusion that text
unlikely benefits from readahead anyway.

>>
>> I don't think that makes sense.  The CPU executes instructions forwards,
>> not "around".  I honestly think we should treat text as "random access"
>> because function A calls function B and functions A and B might well be
>> very far apart from each other.  The only time I see you actually
>> getting "readahead" hits is if a function is split across two pages (for
>> whatever size of page), but that's a false hit!  The function is not,
>> generally, 64kB long, so doing readahead is no more likely to bring in
>> the next page of text that we want than reading any other random page.
>>
> 
> it seems you are in favor of Ryan's modification even for filesystems
> which don't support large mapping?
> 
>> Unless somebody finds the GNU Rope source code from 1998, or recreates it:
>> https://lwn.net/1998/1029/als/rope.html
>> Then we might actually have some locality.
>>
>> Did you actually benchmark what you did?  Is there really some locality
>> between the code at offset 256-288kB in the file and then in the range
>> 192kB-256kB?
> 
> I really didn't have benchmark data, at that point I was like,
> instinctively didn’t
> want to break the logic of read-around, so made the code just that.
> The info your provide makes me re-think if the read-around code is necessary,
> thanks!

As a quick experiment, I modified my thpmaps script to collect data *only* for
executable mappings. This is run *without* my change:

| File-backed exec folios |    Speedometer | Kernel Compile |
|=========================|================|================|
|file-thp-aligned-16kB    |            56% |            46% |
|file-thp-aligned-32kB    |             2% |             3% |
|file-thp-aligned-64kB    |             4% |             5% |
|file-thp-unaligned-16kB  |             0% |             3% |
|file-thp-unaligned-128kB |             2% |             0% |
|file-thp-partial         |             0% |             0% |

It's implied that the rest of the memory (up to 100%) is small (single page)
folios. I think the only reason we would see small folios is if we would
otherwise run off the end of the file?

If so, then I think any text in folios > 16K is a rough proxy for how effective
readahead is for text: Not very.

Intuitively, I agree with Matthew that readahead doesn't make much sense for
text, and this rough data seems to agree.


> 
> was using filesystems without large-mapping support but worked around
> the problem by
> 1. preparing 16*n normals pages
> 2. insert normal pages into xa
> 3. let filesystem read 16 normal pages
> 4. after all IO completion, transform 16 pages into mTHP and reinsert
> mTHP to xa

I had a go at something like this too, but was doing it in the dynamic loader
and having it do MADV_COLLAPSE to generate PMD-sized THPs for the text. I
actaully found this to be even faster for the use cases I was measuring. But of
course its using more memory due to the 2M page size, and I expect it is slowing
down app load time because it is potentially reading in a lot more text than is
actually faulting. Ultimately I think the better strategy is to make the
filesystems large folio capable.

> 
> that was very painful and finally made no improvement probably because
> of due to various sync overhead. so  ran away and didn't dig more data.
> 
> Thanks
> Barry


