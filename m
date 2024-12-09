Return-Path: <linux-fsdevel+bounces-36756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B129E8FB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C36280F30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745582165FE;
	Mon,  9 Dec 2024 10:07:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0044314658C;
	Mon,  9 Dec 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738860; cv=none; b=oN+SOr/MmxBirUnHBGNbAWSfr2Vmlezb6VM8X/QHtVQaU9flm54+41YgrM4tqU/2CK04UnKTDZ9EKsl8GTtmZObpelvd9PbWXRC0lBlb6xIWq+0J4K5argK7Gv/QBmn4/zuIrBWdapOyF0sqOISNcCj07UXav1PYZNcNFBPXMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738860; c=relaxed/simple;
	bh=NS4SkXQXvhw/MTtqbZVk8vVyXJmPcL4Vj6W+p5byDwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEVttL5BHNiz0NunUS7UFA/h546Zwq8hYUk3hE5zsLImHx7JfzDlGq5VRkZvfFfAXCvzrFIxNlnStWVf7l+nyB1CpiRncSGiuh7wj6V7uVmT+4a9jLr5UEmMsTaVfvo/ZMjt+j/wsDYW3IAutLcVyvaXuZwRyrf9BzgTVw4mXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14A96113E;
	Mon,  9 Dec 2024 02:08:03 -0800 (PST)
Received: from [10.57.91.200] (unknown [10.57.91.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36493F720;
	Mon,  9 Dec 2024 02:07:32 -0800 (PST)
Message-ID: <822306e2-43bf-48cb-9556-e9834c883bad@arm.com>
Date: Mon, 9 Dec 2024 10:07:31 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Wenchao Hao
 <haowenchao22@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Peter Xu <peterx@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
 <CABzRoyZOJJKWyx4Aj0CQ17Om3wZPixJYMgZ24VSVQ5BRh2EdJw@mail.gmail.com>
 <CAGsJ_4z_nQXrnjWFODhhNPW4Q0KjeF+p+bXL5D0=CxskWo1_Jg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4z_nQXrnjWFODhhNPW4Q0KjeF+p+bXL5D0=CxskWo1_Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/12/2024 06:06, Barry Song wrote:
> On Fri, Dec 6, 2024 at 7:16 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> On Tue, Dec 3, 2024 at 10:17 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 03.12.24 14:49, Wenchao Hao wrote:
>>>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>>>> each VMA, but it does not include large pages smaller than PMD size.
>>>>
>>>> This patch adds the statistics of anonymous huge pages allocated by
>>>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>>>
>>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>>> ---
>>>>   fs/proc/task_mmu.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index 38a5a3e9cba2..b655011627d8 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>>>               if (!folio_test_swapbacked(folio) && !dirty &&
>>>>                   !folio_test_dirty(folio))
>>>>                       mss->lazyfree += size;
>>>> +
>>>> +             /*
>>>> +              * Count large pages smaller than PMD size to anonymous_thp
>>>> +              */
>>>> +             if (!compound && PageHead(page) && folio_order(folio))
>>>> +                     mss->anonymous_thp += folio_size(folio);
>>>>       }
>>>>
>>>>       if (folio_test_ksm(folio))
>>>
>>>
>>> I think we decided to leave this (and /proc/meminfo) be one of the last
>>> interfaces where this is only concerned with PMD-sized ones:
>>>
>>> Documentation/admin-guide/mm/transhuge.rst:
>>>
>>> The number of PMD-sized anonymous transparent huge pages currently used by the
>>> system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>>> To identify what applications are using PMD-sized anonymous transparent huge
>>> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
>>> fields for each mapping. (Note that AnonHugePages only applies to traditional
>>> PMD-sized THP for historical reasons and should have been called
>>> AnonHugePmdMapped).
>>
>> Yeah, I think we need to keep AnonHugePages unchanged within these interfaces
>> due to historical reasons ;)
>>
>> Perhaps, there might be another way to count all THP allocated for each process.
> 
> My point is that counting the THP allocations per process doesn't seem
> as important
> when compared to the overall system's status. We already have
> interfaces to track
> the following:
> 
> * The number of mTHPs allocated or fallback events;
> * The total number of anonymous mTHP folios in the system.
> * The total number of partially unmapped mTHP folios in the system.

I think an important missing piece here is "what percentage of memory that could
be mTHP is allocated as mTHP?" The script gives you that, which I think is useful.

> 
> To me, knowing the details for each process doesn’t seem particularly
> critical for
> profiling.  To be honest, I don't see a need for this at all, except perhaps for
> debugging to verify if mTHP is present.
> 
> If feasible, we could explore converting Ryan's Python script into a native
> C program. I believe this would be more than sufficient for embedded systems
> and Android.

Agreed. The kernel already fundamentally provides all the required info via
pagemap, kpageflags and smaps. So don't think we need to add anything new to the
kernel.

Thanks,
Ryan


> 
>>
>> Thanks,
>> Lance
>>
>>
>>>
>>>
>>>
>>> --
>>> Cheers,
>>>
>>> David / dhildenb
> 
> Thanks
> Barry


