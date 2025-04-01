Return-Path: <linux-fsdevel+bounces-45427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED74A778F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30376166B02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7291F0E28;
	Tue,  1 Apr 2025 10:35:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F01E991D;
	Tue,  1 Apr 2025 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503757; cv=none; b=jlZl3DmBQJSOZRjBSN0oFGzEDVdPDOAmWLShebAgkkw8+9zkFnBdWl9EKvC1hzPT1qDyh536eoBWTlK0lnho5sP9EllhMYnaWCbWgQAcdYpXdU5rF+vmlZNzvZC/g/32g6kXaeRkEcf9xaSsceuoOcmhPYl8Hi9e7SAVLklZrI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503757; c=relaxed/simple;
	bh=5uiVJWVbZeC+vaSVUMHtKCW8WVqTMBUoBu1ByxgGADM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvHy6fsc+sOdeO1kLIbWQoaxuVqGP28f3WbEeUz4ZjhIRE89l5wJVZ07ktc3h4hGSWCcEeRiP6w8Lv4TW4hjJNEO6C4kxwuvJ9+jPCPgKYWbkyXVDNwIpkcqSYG8ZomPSUITVk5cVQExt84yzBOn+bsbQJvf468GYyKf9vQodCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D32B14BF;
	Tue,  1 Apr 2025 03:35:52 -0700 (PDT)
Received: from [10.1.28.189] (XHFQ2J9959.cambridge.arm.com [10.1.28.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75B433F63F;
	Tue,  1 Apr 2025 03:35:47 -0700 (PDT)
Message-ID: <76f5ba9b-1a8c-4973-89ce-14f504819da1@arm.com>
Date: Tue, 1 Apr 2025 11:35:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/filemap: Allow arch to request folio size for exec
 memory
Content-Language: en-GB
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250327160700.1147155-1-ryan.roberts@arm.com>
 <Z-WAbWfZzG1GA-4n@casper.infradead.org>
 <5131c7ad-cc37-44fc-8672-5866ecbef65b@arm.com>
 <Z-b1FmZ5nHzh5huL@casper.infradead.org>
 <ee11907a-5bd7-44ec-844c-8f10ff406b46@arm.com>
 <CAC_TJveU2v+EcokLKJVVZ8Xje2nYmmUg8bvCD8KO1oC5MgmWCA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAC_TJveU2v+EcokLKJVVZ8Xje2nYmmUg8bvCD8KO1oC5MgmWCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/04/2025 03:19, Kalesh Singh wrote:
> On Sat, Mar 29, 2025 at 3:08 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 28/03/2025 15:14, Matthew Wilcox wrote:
>>> On Thu, Mar 27, 2025 at 04:23:14PM -0400, Ryan Roberts wrote:
>>>> + Kalesh
>>>>
>>>> On 27/03/2025 12:44, Matthew Wilcox wrote:
>>>>> On Thu, Mar 27, 2025 at 04:06:58PM +0000, Ryan Roberts wrote:
>>>>>> So let's special-case the read(ahead) logic for executable mappings. The
>>>>>> trade-off is performance improvement (due to more efficient storage of
>>>>>> the translations in iTLB) vs potential read amplification (due to
>>>>>> reading too much data around the fault which won't be used), and the
>>>>>> latter is independent of base page size. I've chosen 64K folio size for
>>>>>> arm64 which benefits both the 4K and 16K base page size configs and
>>>>>> shouldn't lead to any read amplification in practice since the old
>>>>>> read-around path was (usually) reading blocks of 128K. I don't
>>>>>> anticipate any write amplification because text is always RO.
>>>>>
>>>>> Is there not also the potential for wasted memory due to ELF alignment?
>>>>
>>>> I think this is an orthogonal issue? My change isn't making that any worse.
>>>
>>> To a certain extent, it is.  If readahead was doing order-2 allocations
>>> before and is now doing order-4, you're tying up 0-12 extra pages which
>>> happen to be filled with zeroes due to being used to cache the contents
>>> of a hole.
>>
>> Well we would still have read them in before, nothing has changed there. But I
>> guess your point is more about reclaim? Because those pages are now contained in
>> a larger folio, if part of the folio is in use then all of it remains active.
>> Whereas before, if the folio was fully contained in the pad area and never
>> accessed, it would fall down the LRU quickly and get reclaimed.
>>
> 
> 
> Hi Ryan,
> 
> I agree this was happening before and we don't need to completely
> address it here. Though with the patch it's more likely that the holes
> will be cached. I'd like to minimize it if possible. Since this is for
> EXEC mappings, a simple check we could use is to limit this to the
> VM_EXEC vma.
> 
> + if (vm_flags & VM_EXEC) {
> + int order = arch_exec_folio_order();
> +
> + if (order >= 0 && ((end-address)*2) >= 1<<order) { /* Fault around case */

I think the intent of this extra check is to ensure the folio will be fully
contained within the exec vma? Assuming end is the VA of the end of the vma and
address is the VA of the fault, I don't think the maths are quite right? What's
the "*2" for? And you probably mean PAGE_SIZE<<order ? But this also doesn't
account for alignment; the folio will be aligned down to a natural boundary in
the file.

But more fundamentally, I thought I suggested reducing the VMA bounds to exclude
padding pages the other day at LSF/MM and you said you didn't want to do that
because you didn't want to end up with something else mapped in the gap? So
doesn't that mean the padding pages are part of the VMA and this check won't help?

> 
> For reference I found below (coincidentally? similar) distributions on
> my devices
> 
> == x86 Workstation ==
> 
> Total unique exec segments:   906
> 
> Exec segments >= 16 KB:   663 ( 73.18%)
> Exec segments >= 64 KB:   414 ( 45.70%)

What are those percentages? They don't add up to more than 100...

The numbers I included with the patch are caclulated based on actual mappings so
if we end up with a partially mapped 64K folio (because it runs off the end of
the VMA) it wouldn't have been counted as a 64K contiguous mapping. So I don't
think this type of change would change my numbers at all.

> 
> == arm64 Android Device ==
> 
> Total unique exec segments:   2171
> 
> Exec segments >= 16 KB:  1602 ( 73.79%)
> Exec segments >= 64 KB:   988 ( 45.51%)
> 
> Result were using the below script:
> 
> cat /proc/*/maps | grep 'r-xp' | \
> awk '
> BEGIN { OFS = "\t" }
> $NF ~ /^\// {
> path = $NF;
> split($1, addr, "-");
> size = strtonum("0x" addr[2]) - strtonum("0x" addr[1]);
> print size, path;
> }' | \
> sort -u | \
> awk '
> BEGIN {
> FS = "\t";
> total_segments = 0;
> segs_ge_16k = 0;
> segs_ge_64k = 0;
> }
> {
> total_segments++;
> size = $1;
> if (size >= 16384) segs_ge_16k++;
> if (size >= 65536) segs_ge_64k++;
> }
> END {
> if (total_segments > 0) {
> percent_gt_16k = (segs_ge_16k / total_segments) * 100;
> percent_gt_64k = (segs_ge_64k / total_segments) * 100;
> 
> printf "Total unique exec segments: %d\n", total_segments;
> printf "\n";
> printf "Exec segments >= 16 KB: %5d (%6.2f%%)\n", segs_ge_16k, percent_gt_16k;
> printf "Exec segments >= 64 KB: %5d (%6.2f%%)\n", segs_ge_64k, percent_gt_64k;
> } else {
> print "No executable segments found.";
> }
> }'
> 
>>>
>>>>> Kalesh talked about it in the MM BOF at the same time that Ted and I
>>>>> were discussing it in the FS BOF.  Some coordination required (like
>>>>> maybe Kalesh could have mentioned it to me rathere than assuming I'd be
>>>>> there?)
>>>>
>>>> I was at Kalesh's talk. David H suggested that a potential solution might be for
>>>> readahead to ask the fs where the next hole is and then truncate readahead to
>>>> avoid reading the hole. Given it's padding, nothing should directly fault it in
>>>> so it never ends up in the page cache. Not sure if you discussed anything like
>>>> that if you were talking in parallel?
>>>
>>> Ted said that he and Kalesh had talked about that solution.  I have a
>>> more bold solution in mind which lifts the ext4 extent cache to the
>>> VFS inode so that the readahead code can interrogate it.
>>>
> 
> Sorry about the hiccup in coordination, Matthew. It was my bad for not
> letting you know I planned to discuss it in the MM BoF. I'd like to
> hear Ted and your ideas on this when possible.
> 
> Thanks,
> Kalesh
> 
>>>> Anyway, I'm not sure if you're suggesting these changes need to be considered as
>>>> one somehow or if you're just mentioning it given it is loosely related? My view
>>>> is that this change is an improvement indepently and could go in much sooner.
>>>
>>> This is not a reason to delay this patch.  It's just a downside which
>>> should be mentioned in the commit message.
>>
>> Fair point; I'll add a paragraph about the potential reclaim issue.
>>
>>>
>>>>>> +static inline int arch_exec_folio_order(void)
>>>>>> +{
>>>>>> +  return -1;
>>>>>> +}
>>>>>
>>>>> This feels a bit fragile.  I often expect to be able to store an order
>>>>> in an unsigned int.  Why not return 0 instead?
>>>>
>>>> Well 0 is a valid order, no? I think we have had the "is order signed or
>>>> unsigned" argument before. get_order() returns a signed int :)
>>>
>>> But why not always return a valid order?  I don't think we need a
>>> sentinel.  The default value can be 0 to do what we do today.
>>>
>>
>> But a single order-0 folio is not what we do today. Note that my change as
>> currently implemented requests to read a *single* folio of the specified order.
>> And note that we only get the order we request to page_cache_ra_order() because
>> the size is limited to a single folio. If the size were bigger, that function
>> would actually expand the requested order by 2. (although the parameter is
>> called "new_order", it's actually interpretted as "old_order").
>>
>> The current behavior is effectively to read 128K in order-2 folios (with smaller
>> folios for boundary alignment).
>>
>> So I see a few options:

Matthew,

Did you have any thoughts on these options?

Thanks,
Ryan

>>
>>   - Continue to allow non-opted in arches to use the existing behaviour; in this
>> case we need a sentinel. This could be -1, UINT_MAX or 0. But in the latter case
>> you are preventing an opted-in arch from specifying that they want order-0 -
>> it's meaning is overridden.
>>
>>   - Force all arches to use the new approach with a default folio order (and
>> readahead size) of order-0. (The default can be overridden per-arch). Personally
>> I'd be nervous about making this change.
>>
>>   - Decouple the read size from the folio order size; continue to use the 128K
>> read size and only allow opting-in to a specific folio order. The default order
>> would be 2 (or 0). We would need to fix page_cache_async_ra() to call
>> page_cache_ra_order() with "order + 2" (the new order) and fix
>> page_cache_ra_order() to treat its order parameter as the *new* order.
>>
>> Perhaps we should do those fixes anyway (and then actually start with a folio
>> order of 0 - which I think you said in the past was your original intention?).
>>
>> Thanks,
>> Ryan
>>


