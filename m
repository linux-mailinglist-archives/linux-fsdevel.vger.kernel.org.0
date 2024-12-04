Return-Path: <linux-fsdevel+bounces-36494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154D99E41CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 18:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6DD1631C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733A1A8F8E;
	Wed,  4 Dec 2024 17:08:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF621A8F85;
	Wed,  4 Dec 2024 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332080; cv=none; b=aw5AxmBBX5C+o4RrP/e9jcHEViyyK4sXhBWzXU7DYIl2Azw+WnpwaFjGRZ+67UnV6GPSlYJY+QHIWj+5xyF0Sr8AsyjQMyUw/moAdwcUW3lBx8zctZETTkp8OWVMHp+IDtJFwQj3XQ1rc5jePZriDAbNmB9gzfYIDlZrvEsUm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332080; c=relaxed/simple;
	bh=9MTY6TxMvbh9KZNhLYcEFlackh7HBg5HuBnSWkvOkuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UBqO7Ckyyc4WQJRMvkf6iE6t+jPNH80u7RBpeGJpPLt3ENGOngWUKym9C9xLBk2Wxnw560xJyxY/lZA6gQVQYLew6Q0gI3SW0qPMhOjBefbyWPzXfjdVQCgmoxggHjKhQGCrG++EDw8mH7refYA4YKg23t3IBrGvFO18ir0Fa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E2931063;
	Wed,  4 Dec 2024 09:08:25 -0800 (PST)
Received: from [10.1.31.170] (XHFQ2J9959.cambridge.arm.com [10.1.31.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 432F93F71E;
	Wed,  4 Dec 2024 09:07:55 -0800 (PST)
Message-ID: <b4205df7-e15f-4daf-bf12-720c73e15fa2@arm.com>
Date: Wed, 4 Dec 2024 17:07:53 +0000
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
To: Wenchao Hao <haowenchao22@gmail.com>, David Hildenbrand
 <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Peter Xu <peterx@redhat.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Dev Jain <dev.jain@arm.com>
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
 <e6199ca4-1f87-4ec5-b886-11482b082931@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e6199ca4-1f87-4ec5-b886-11482b082931@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+ Dev Jain

On 04/12/2024 14:30, Wenchao Hao wrote:
> On 2024/12/3 22:17, David Hildenbrand wrote:
>> On 03.12.24 14:49, Wenchao Hao wrote:
>>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>>> each VMA, but it does not include large pages smaller than PMD size.
>>>
>>> This patch adds the statistics of anonymous huge pages allocated by
>>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>>
>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>> ---
>>>   fs/proc/task_mmu.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 38a5a3e9cba2..b655011627d8 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>>           if (!folio_test_swapbacked(folio) && !dirty &&
>>>               !folio_test_dirty(folio))
>>>               mss->lazyfree += size;
>>> +
>>> +        /*
>>> +         * Count large pages smaller than PMD size to anonymous_thp
>>> +         */
>>> +        if (!compound && PageHead(page) && folio_order(folio))
>>> +            mss->anonymous_thp += folio_size(folio);
>>>       }
>>>         if (folio_test_ksm(folio))
>>
>>
>> I think we decided to leave this (and /proc/meminfo) be one of the last
>> interfaces where this is only concerned with PMD-sized ones:
>>
> 
> Could you explain why?
> 
> When analyzing the impact of mTHP on performance, we need to understand
> how many pages in the process are actually present as large pages.
> By comparing this value with the actual memory usage of the process,
> we can analyze the large page allocation success rate of the process,
> and further investigate the situation of khugepaged. If the actual

Note that khugepaged does not yet support collapse to mTHP sizes. Dev Jain
(CCed) is working on an implementation for that now. If you are planning to look
at this area, you might want to chat first.

> proportion of large pages is low, the performance of the process may
> be affected, which could be directly reflected in the high number of
> TLB misses and page faults.
> 
> However, currently, only PMD-sized large pages are being counted, 
> which is insufficient.
> 
>> Documentation/admin-guide/mm/transhuge.rst:
>>
>> The number of PMD-sized anonymous transparent huge pages currently used by the
>> system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>> To identify what applications are using PMD-sized anonymous transparent huge
>> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
>> fields for each mapping. (Note that AnonHugePages only applies to traditional
>> PMD-sized THP for historical reasons and should have been called
>> AnonHugePmdMapped).
>>
> 
> Maybe rename this field, then AnonHugePages contains huge page of mTHP?
> 
> Thanks,
> wenchao
> 
>>
>>
> 


