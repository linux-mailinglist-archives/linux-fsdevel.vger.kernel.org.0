Return-Path: <linux-fsdevel+bounces-36493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ACB9E41C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 18:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745DB168317
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6929E227B8F;
	Wed,  4 Dec 2024 17:05:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13621D5BF;
	Wed,  4 Dec 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331952; cv=none; b=RVdLvML/4iuZ+D6efJuS6RhM2dwZe9qCYWnNDMw88ym9sNoRCNwAC1UkgruY6WZ6Dm7q98ULFO+nfavp7pYYo/lYjk3PSdQLIp5nD/IGZeE+m/dReTXQfgQP2KXCpfNezSKXzCjXtDigWe15v20lMVYb+Yxvr1aggAJGtGOSmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331952; c=relaxed/simple;
	bh=mpFZGbRrr9pVX1ORwf0kmi2JYrm8OZvYLsm98fDvXRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ww4Aj4+Et5c8vpjMUHFXBSYqoe0LCyAQd99TfbSQ/+NLuiW+TPFjDx9AJC5XqrserWMeqvEdNkRifThweSlklqI7+093sSMMsI0o0UUzzokOCveGeN+MmTAsu4i0/eO9ROi0VmyHxxapjgWywaOXqf97R99O+QmUBrXCV3+MCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2DE41063;
	Wed,  4 Dec 2024 09:06:16 -0800 (PST)
Received: from [10.1.31.170] (XHFQ2J9959.cambridge.arm.com [10.1.31.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2440C3F71E;
	Wed,  4 Dec 2024 09:05:47 -0800 (PST)
Message-ID: <500d1007-56f5-43cb-be9d-4a39fccc6e53@arm.com>
Date: Wed, 4 Dec 2024 17:05:45 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
To: Wenchao Hao <haowenchao22@gmail.com>, David Hildenbrand
 <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Peter Xu <peterx@redhat.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
 <f2d58d57-df38-42eb-a00c-a993ca7299ba@arm.com>
 <31158c3e-bf1b-47e8-a41b-0417c538b62e@gmail.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <31158c3e-bf1b-47e8-a41b-0417c538b62e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/12/2024 14:40, Wenchao Hao wrote:
> On 2024/12/3 22:42, Ryan Roberts wrote:
>> On 03/12/2024 14:17, David Hildenbrand wrote:
>>> On 03.12.24 14:49, Wenchao Hao wrote:
>>>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>>>> each VMA, but it does not include large pages smaller than PMD size.
>>>>
>>>> This patch adds the statistics of anonymous huge pages allocated by
>>>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>>>
>>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>>> ---
>>>>   fs/proc/task_mmu.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index 38a5a3e9cba2..b655011627d8 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss,
>>>> struct page *page,
>>>>           if (!folio_test_swapbacked(folio) && !dirty &&
>>>>               !folio_test_dirty(folio))
>>>>               mss->lazyfree += size;
>>>> +
>>>> +        /*
>>>> +         * Count large pages smaller than PMD size to anonymous_thp
>>>> +         */
>>>> +        if (!compound && PageHead(page) && folio_order(folio))
>>>> +            mss->anonymous_thp += folio_size(folio);
>>>>       }
>>>>         if (folio_test_ksm(folio))
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
>>>
>>
>> Agreed. If you need per-process metrics for mTHP, we have a python script at
>> tools/mm/thpmaps which does a fairly good job of parsing pagemap. --help gives
>> you all the options.
>>
> 
> I tried this tool, and it is very powerful and practical IMO.
> However, thereare two disadvantages:
> 
> - This tool is heavily dependent on Python and Python libraries.
>   After installing several libraries with the pip command, I was able to
>   get it running.

I think numpy is the only package it uses which is not in the standard library?
What other libraries did you need to install?

>   In practice, the environment we need to analyze may be a mobile or
>   embedded environment, where it is very difficult to deploy these
>   libraries.

Yes, I agree that's a problem, especially for Android. The script has proven
useful to me for debugging in a traditional Linux distro environment though.

> - It seems that this tool only counts file-backed large pages? During

No; the tool counts file-backed and anon memory. But it reports it in separate
counters. See `thpmaps --help` for full details.

>   the actual test, I mapped a region of anonymous pages and mapped it
>   as large pages, but the tool did not display those large pages.
>   Below is my test file(mTHP related sysfs interface is set to "always"
>   to make sure using large pages):

Which mTHP sizes did you enable? Depending on your value of SIZE and which mTHP
sizes are enabled, you may not have a correctly aligned region in p. So mTHP
would not be allocated. Best to over-allocate then explicitly align p to the
mTHP size, then fault it in.

> 
> int main()
> {
>         int i;
>         char *c;
>         unsigned long *p;
> 
>         p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

What is SIZE here?

>         if (!p) {
>                 perror("fail to get memory");
>                 exit(-1);
>         }
> 
>         c = (unsigned char *)p;
> 
>         for (i = 0; i < SIZE / 8; i += 8)
>                 *(p + i) = 0xffff + i;

Err... what's your intent here? I think you're writting to 1 in every 8 longs?
Probably just write to the first byte of every page.

Thanks,
Ryan

> 
>         while (1)
>                 sleep(10);
> 
>         return 0;
> }
> 
> Thanks,
> wenchao
> 


