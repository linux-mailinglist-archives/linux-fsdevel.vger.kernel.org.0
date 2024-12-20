Return-Path: <linux-fsdevel+bounces-37914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D565C9F8CEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 07:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47230189187D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7397F189BB3;
	Fri, 20 Dec 2024 06:49:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B372A2594A7;
	Fri, 20 Dec 2024 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734677341; cv=none; b=DVdDiHqBysiWayeCnsQD+zU9WgixyyBotwISRwpYUBlqPapi5l+nxC0VQoqixwIU3CwIajxEjDIBsZp9A09QWGe/J6ofHNIiOychGImw1Muce0TVl5OBrbdIecWFMROCjjeIZHgtQGfpqgQFdT6kuJ7aXqnXFHgo2h+2uTelzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734677341; c=relaxed/simple;
	bh=l/tGMnVu+n4ceCuvpVFqTv8IH5Nh66iTW1mV771hK90=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D5iCFDvUZN+l3A63pgV2AMDnGEi9rv8ZQxUn41ysFpao2LFpNqed+QQAn8oMdy1RzbE2Pf+6FylSA8PQTmSpEGfjPQ/zPCSD5EEa+BXMDkxHL4V9ql15kLqYRdJryxiMqHDhQwObSuymdQSBk2vDEC1plaQujb3nrc7suLbtzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95211480;
	Thu, 19 Dec 2024 22:49:25 -0800 (PST)
Received: from [10.162.42.20] (K4MQJ0H1H2.blr.arm.com [10.162.42.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B863F3F58B;
	Thu, 19 Dec 2024 22:48:53 -0800 (PST)
Message-ID: <15ae90c0-6199-4bdf-a3ac-27e6b74c249d@arm.com>
Date: Fri, 20 Dec 2024 12:18:50 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
To: Wenchao Hao <haowenchao22@gmail.com>, Ryan Roberts
 <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Peter Xu <peterx@redhat.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
 <f2d58d57-df38-42eb-a00c-a993ca7299ba@arm.com>
 <31158c3e-bf1b-47e8-a41b-0417c538b62e@gmail.com>
 <500d1007-56f5-43cb-be9d-4a39fccc6e53@arm.com>
 <4169e59e-9015-4323-aae7-09bc8e513bbd@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <4169e59e-9015-4323-aae7-09bc8e513bbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 16/12/24 9:28 pm, Wenchao Hao wrote:
> On 2024/12/5 1:05, Ryan Roberts wrote:
>> On 04/12/2024 14:40, Wenchao Hao wrote:
>>> On 2024/12/3 22:42, Ryan Roberts wrote:
>>>> On 03/12/2024 14:17, David Hildenbrand wrote:
>>>>> On 03.12.24 14:49, Wenchao Hao wrote:
>>>>>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>>>>>> each VMA, but it does not include large pages smaller than PMD size.
>>>>>>
>>>>>> This patch adds the statistics of anonymous huge pages allocated by
>>>>>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>>>>>
>>>>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>>>>> ---
>>>>>>    fs/proc/task_mmu.c | 6 ++++++
>>>>>>    1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>>>> index 38a5a3e9cba2..b655011627d8 100644
>>>>>> --- a/fs/proc/task_mmu.c
>>>>>> +++ b/fs/proc/task_mmu.c
>>>>>> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss,
>>>>>> struct page *page,
>>>>>>            if (!folio_test_swapbacked(folio) && !dirty &&
>>>>>>                !folio_test_dirty(folio))
>>>>>>                mss->lazyfree += size;
>>>>>> +
>>>>>> +        /*
>>>>>> +         * Count large pages smaller than PMD size to anonymous_thp
>>>>>> +         */
>>>>>> +        if (!compound && PageHead(page) && folio_order(folio))
>>>>>> +            mss->anonymous_thp += folio_size(folio);
>>>>>>        }
>>>>>>          if (folio_test_ksm(folio))
>>>>>
>>>>> I think we decided to leave this (and /proc/meminfo) be one of the last
>>>>> interfaces where this is only concerned with PMD-sized ones:
>>>>>
>>>>> Documentation/admin-guide/mm/transhuge.rst:
>>>>>
>>>>> The number of PMD-sized anonymous transparent huge pages currently used by the
>>>>> system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>>>>> To identify what applications are using PMD-sized anonymous transparent huge
>>>>> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
>>>>> fields for each mapping. (Note that AnonHugePages only applies to traditional
>>>>> PMD-sized THP for historical reasons and should have been called
>>>>> AnonHugePmdMapped).
>>>>>
>>>> Agreed. If you need per-process metrics for mTHP, we have a python script at
>>>> tools/mm/thpmaps which does a fairly good job of parsing pagemap. --help gives
>>>> you all the options.
>>>>
>>> I tried this tool, and it is very powerful and practical IMO.
>>> However, thereare two disadvantages:
>>>
>>> - This tool is heavily dependent on Python and Python libraries.
>>>    After installing several libraries with the pip command, I was able to
>>>    get it running.
>> I think numpy is the only package it uses which is not in the standard library?
>> What other libraries did you need to install?
>>
> Yes, I just tested it on the standard version (Fedora), and that is indeed the case.
> Previously, I needed to install additional packages is because I removed some unused
> software from the old environment.
>
> Recently, I revisited and started using your tool again. It’s very useful, meeting
> my needs and even exceeding them. I am now testing with qemu to run a fedora, so
> it's easy to run it.
>
>>>    In practice, the environment we need to analyze may be a mobile or
>>>    embedded environment, where it is very difficult to deploy these
>>>    libraries.
>> Yes, I agree that's a problem, especially for Android. The script has proven
>> useful to me for debugging in a traditional Linux distro environment though.
>>
>>> - It seems that this tool only counts file-backed large pages? During
>> No; the tool counts file-backed and anon memory. But it reports it in separate
>> counters. See `thpmaps --help` for full details.
>>
>>>    the actual test, I mapped a region of anonymous pages and mapped it
>>>    as large pages, but the tool did not display those large pages.
>>>    Below is my test file(mTHP related sysfs interface is set to "always"
>>>    to make sure using large pages):
>> Which mTHP sizes did you enable? Depending on your value of SIZE and which mTHP
>> sizes are enabled, you may not have a correctly aligned region in p. So mTHP
>> would not be allocated. Best to over-allocate then explicitly align p to the
>> mTHP size, then fault it in.
>>
> I enabled 64k/128k/256k MTHP and have been studying, debugging, and changing
> parts of the khugepaged code to try merging standard pages into mTHP large
> pages. So, I wanted to use smap to observe the large page sizes in a process.

You can try my RFC khugepaged series for that ;)

>
>>> int main()
>>> {
>>>          int i;
>>>          char *c;
>>>          unsigned long *p;
>>>
>>>          p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> What is SIZE here?
>>
>>>          if (!p) {
>>>                  perror("fail to get memory");
>>>                  exit(-1);
>>>          }
>>>
>>>          c = (unsigned char *)p;
>>>
>>>          for (i = 0; i < SIZE / 8; i += 8)
>>>                  *(p + i) = 0xffff + i;
>> Err... what's your intent here? I think you're writting to 1 in every 8 longs?
>> Probably just write to the first byte of every page.
>>
> The data is fixed for the purpose of analyzing zram compression, so I filled
> some data here.
>
>> Thanks,
>> Ryan
>>
>>>          while (1)
>>>                  sleep(10);
>>>
>>>          return 0;
>>> }
>>>
>>> Thanks,
>>> wenchao
>>>
>

