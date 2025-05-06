Return-Path: <linux-fsdevel+bounces-48261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C7AAC912
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 17:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EA21C06DBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B0A28313A;
	Tue,  6 May 2025 15:06:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8983E198A08;
	Tue,  6 May 2025 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543989; cv=none; b=qhs6noCOVO1vVpElxAkbAJIt0Z6BKJxHAMHj0PeVsWos7pyZ4GptXePeq9BmHH6HmtvU7i1KOLlagtrxZyekWaFpZ2FIsYPukYP2dzIjUFLIhoL2/7o7roId/6l9ScIWNvWKBNQxdiKqhanhYzXIlf51pV/CDwBaB8cXvrgr8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543989; c=relaxed/simple;
	bh=7bNdS1i9+vkYuxnUFivUGESM1y2DIHExk6zpg9CpGWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb+6CqOClN1A+b/jQSirEmOzMksjZHM9hNWp0RYC6kPdnAfTEqVtJuNnmCcfpWWJsYJGyLo7P6v0vcqY8PKhzHZcuSF9rR+Ah2Oge+2vJB2AmhAM0hUvwvgms98hx0dyM05RuMzK0D9R6ZbG7ANOcahRzvxKDiYHh1a8JMB4t7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D9FB339;
	Tue,  6 May 2025 08:06:16 -0700 (PDT)
Received: from [10.1.29.178] (XHFQ2J9959.cambridge.arm.com [10.1.29.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C0A93F58B;
	Tue,  6 May 2025 08:06:23 -0700 (PDT)
Message-ID: <a844139c-9c85-4ba1-b49e-5bd719e55a9e@arm.com>
Date: Tue, 6 May 2025 16:06:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/5] mm/readahead: Store folio order in struct
 file_ra_state
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Dave Chinner <david@fromorbit.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-5-ryan.roberts@arm.com>
 <c8f78fd6-c1fb-4884-b370-cb6b03e573b6@redhat.com>
 <2b1ea3d9-6c9b-4700-ae21-5f65565a995a@arm.com>
 <5ea287f0-24cb-4ad4-8448-6e397fbf1ec8@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <5ea287f0-24cb-4ad4-8448-6e397fbf1ec8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/05/2025 15:24, David Hildenbrand wrote:
> On 06.05.25 12:03, Ryan Roberts wrote:
>> On 05/05/2025 11:08, David Hildenbrand wrote:
>>> On 30.04.25 16:59, Ryan Roberts wrote:
>>>> Previously the folio order of the previous readahead request was
>>>> inferred from the folio who's readahead marker was hit. But due to the
>>>> way we have to round to non-natural boundaries sometimes, this first
>>>> folio in the readahead block is often smaller than the preferred order
>>>> for that request. This means that for cases where the initial sync
>>>> readahead is poorly aligned, the folio order will ramp up much more
>>>> slowly.
>>>>
>>>> So instead, let's store the order in struct file_ra_state so we are not
>>>> affected by any required alignment. We previously made enough room in
>>>> the struct for a 16 order field. This should be plenty big enough since
>>>> we are limited to MAX_PAGECACHE_ORDER anyway, which is certainly never
>>>> larger than ~20.
>>>>
>>>> Since we now pass order in struct file_ra_state, page_cache_ra_order()
>>>> no longer needs it's new_order parameter, so let's remove that.
>>>>
>>>> Worked example:
>>>>
>>>> Here we are touching pages 17-256 sequentially just as we did in the
>>>> previous commit, but now that we are remembering the preferred order
>>>> explicitly, we no longer have the slow ramp up problem. Note
>>>> specifically that we no longer have 2 rounds (2x ~128K) of order-2
>>>> folios:
>>>>
>>>> TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
>>>> -----  ----------  ----------  ----------  -------  -------  -----  -----  --
>>>> HOLE   0x00000000  0x00001000        4096        0        1      1
>>>> FOLIO  0x00001000  0x00002000        4096        1        2      1      0
>>>> FOLIO  0x00002000  0x00003000        4096        2        3      1      0
>>>> FOLIO  0x00003000  0x00004000        4096        3        4      1      0
>>>> FOLIO  0x00004000  0x00005000        4096        4        5      1      0
>>>> FOLIO  0x00005000  0x00006000        4096        5        6      1      0
>>>> FOLIO  0x00006000  0x00007000        4096        6        7      1      0
>>>> FOLIO  0x00007000  0x00008000        4096        7        8      1      0
>>>> FOLIO  0x00008000  0x00009000        4096        8        9      1      0
>>>> FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
>>>> FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
>>>> FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
>>>> FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
>>>> FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
>>>> FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
>>>> FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
>>>> FOLIO  0x00010000  0x00011000        4096       16       17      1      0
>>>> FOLIO  0x00011000  0x00012000        4096       17       18      1      0
>>>> FOLIO  0x00012000  0x00013000        4096       18       19      1      0
>>>> FOLIO  0x00013000  0x00014000        4096       19       20      1      0
>>>> FOLIO  0x00014000  0x00015000        4096       20       21      1      0
>>>> FOLIO  0x00015000  0x00016000        4096       21       22      1      0
>>>> FOLIO  0x00016000  0x00017000        4096       22       23      1      0
>>>> FOLIO  0x00017000  0x00018000        4096       23       24      1      0
>>>> FOLIO  0x00018000  0x00019000        4096       24       25      1      0
>>>> FOLIO  0x00019000  0x0001a000        4096       25       26      1      0
>>>> FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
>>>> FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
>>>> FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
>>>> FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
>>>> FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
>>>> FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
>>>> FOLIO  0x00020000  0x00021000        4096       32       33      1      0
>>>> FOLIO  0x00021000  0x00022000        4096       33       34      1      0
>>>> FOLIO  0x00022000  0x00024000        8192       34       36      2      1
>>>> FOLIO  0x00024000  0x00028000       16384       36       40      4      2
>>>> FOLIO  0x00028000  0x0002c000       16384       40       44      4      2
>>>> FOLIO  0x0002c000  0x00030000       16384       44       48      4      2
>>>> FOLIO  0x00030000  0x00034000       16384       48       52      4      2
>>>> FOLIO  0x00034000  0x00038000       16384       52       56      4      2
>>>> FOLIO  0x00038000  0x0003c000       16384       56       60      4      2
>>>> FOLIO  0x0003c000  0x00040000       16384       60       64      4      2
>>>> FOLIO  0x00040000  0x00050000       65536       64       80     16      4
>>>> FOLIO  0x00050000  0x00060000       65536       80       96     16      4
>>>> FOLIO  0x00060000  0x00080000      131072       96      128     32      5
>>>> FOLIO  0x00080000  0x000a0000      131072      128      160     32      5
>>>> FOLIO  0x000a0000  0x000c0000      131072      160      192     32      5
>>>> FOLIO  0x000c0000  0x000e0000      131072      192      224     32      5
>>>> FOLIO  0x000e0000  0x00100000      131072      224      256     32      5
>>>> FOLIO  0x00100000  0x00120000      131072      256      288     32      5
>>>> FOLIO  0x00120000  0x00140000      131072      288      320     32      5  Y
>>>> HOLE   0x00140000  0x00800000     7077888      320     2048   1728
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>    include/linux/fs.h |  2 ++
>>>>    mm/filemap.c       |  6 ++++--
>>>>    mm/internal.h      |  3 +--
>>>>    mm/readahead.c     | 18 +++++++++++-------
>>>>    4 files changed, 18 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index 44362bef0010..cde482a7270a 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -1031,6 +1031,7 @@ struct fown_struct {
>>>>     *      and so were/are genuinely "ahead".  Start next readahead when
>>>>     *      the first of these pages is accessed.
>>>>     * @ra_pages: Maximum size of a readahead request, copied from the bdi.
>>>> + * @order: Preferred folio order used for most recent readahead.
>>>
>>> Looking at other members, and how it relates to the other members, should we
>>> call this something like "ra_prev_order" / "prev_ra_order" to distinguish it
>>> from !ra members and indicate the "most recent" semantics similar to "prev_pos"?
>>
>> As you know, I'm crap at naming, but...
>>
>> start, size, async_size and order make up the parameters for the "most recent"
>> readahead request. Where "most recent" includes "current" once passed into
>> page_cache_ra_order(). The others don't include "ra" or "prev" in their name so
>> wasn't sure it was necessary here.
>>
>> ra_pages is a bit different; that's not part of the request, it's a (dynamic)
>> ceiling to use when creating requests.
>>
>> Personally I'd leave it as is, but no strong opinion.
> 
> I'm fine with it staying that way; I was merely trying to make sense of it all ...
> 
> 
> ... maybe a better description of the parameters might make the semantics easier
> to grasp.
> 
> ""most recent" includes "current" once passed into page_cache_ra_order()"
> 
> is *really* hard to digest :)
> 
>>
>>>
>>> Just a thought while digging through this patch ...
>>>
>>> ...
>>>
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -3222,7 +3222,8 @@ static struct file *do_sync_mmap_readahead(struct
>>>> vm_fault *vmf)
>>>>            if (!(vm_flags & VM_RAND_READ))
>>>>                ra->size *= 2;
>>>>            ra->async_size = HPAGE_PMD_NR;
>>>> -        page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
>>>> +        ra->order = HPAGE_PMD_ORDER;
>>>> +        page_cache_ra_order(&ractl, ra);
>>>>            return fpin;
>>>>        }
>>>>    #endif
>>>> @@ -3258,8 +3259,9 @@ static struct file *do_sync_mmap_readahead(struct
>>>> vm_fault *vmf)
>>>>        ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>>>>        ra->size = ra->ra_pages;
>>>>        ra->async_size = ra->ra_pages / 4;
>>>> +    ra->order = 0;
>>>>        ractl._index = ra->start;
>>>> -    page_cache_ra_order(&ractl, ra, 0);
>>>> +    page_cache_ra_order(&ractl, ra);
>>>>        return fpin;
>>>>    }
>>>
>>> Why not let page_cache_ra_order() consume the order and update ra->order (or
>>> however it will be called :) ) internally?
>>
>> You mean continue to pass new_order as a parameter to page_cache_ra_order()? The
>> reason I did it the way I'm doing it is because I thought it would be weird for
>> the caller of page_cache_ra_order() to set up all the parameters (start, size,
>> async_size) of the request except for order...
> 
> Agreed. As above, I think we might do better with the description of these
> parameters in general ...
> 
> or even document how page_cache_ra_order() acts on these inputs?

OK let me try to work something up for the next version...



