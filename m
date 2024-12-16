Return-Path: <linux-fsdevel+bounces-37503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A809C9F351F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1872169442
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472214A4DE;
	Mon, 16 Dec 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXQ+OJDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25F53E23;
	Mon, 16 Dec 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364730; cv=none; b=UvH29/KRZVT4U++u1pwtKqaovfnnmY8ymu/tyYB1LMEQrLt9amv8lDp9zypIVaT3kJfs6/C6hVXM0Oi4sa6Hcv6bphQpQXcm+39hgZ67ToOnWBuZ08dPAvwEzAIi/DQH4d6uesjanZyeDtouG/b1vPt8/s4XkaJQ+ABgYh/808E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364730; c=relaxed/simple;
	bh=vJZgWVzD4jhJrBb5M6sIe8BOzPIYfwBS46TYCF/Mxno=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QeZ/hfBRaN8rp3cZQ3Jeca9Z2vYdqTFEsH6y1+nHhYg75wI/r0Qc0oB4gNA2dISwJf9rsYTeymSvSUaVTSRuDf6TKcRsRwivX6vdpiosUjUJEtNIxOwWT4eun3e03n+ZwpTtIvsWXqBjLyVk3trJPgBST+zqcaXwmIvP3HyP9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXQ+OJDV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2161eb94cceso28646735ad.2;
        Mon, 16 Dec 2024 07:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734364728; x=1734969528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C7xBZw5Ddpwe0w4iMihNpgYksKYHlA1ZTg6HO2/bz00=;
        b=OXQ+OJDVXfiXK428JqVlGn7YCydHILMVz5t9asZA6fk73YIZIXbd1QMpA5dzfjVDpb
         QtWrEtnn/P1FJZ+Noh7pwH7VK+0ydlVeb2dHXdeQ0Ox1wpNP6mh98SV8l9U+JrurYkz0
         Z4a5htonB23I/LrD5tDENujKHOzmVWqu4ENoS8Fxb7+nRojCAKWLHV/+aeqOZgBA50XV
         odYhnQiGQFE5rN79uMr9Gv98zrieRAr9FuJMtukUaI/07Ax7VjpiODCm1y8DZj7IZvg1
         rQGUtMci2PiDDcLChucSShn6Fp8M9oaWmqDKJ6IiHhLeiAW1KTtCi8I6QgZ+YL6+3zy7
         2h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364728; x=1734969528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7xBZw5Ddpwe0w4iMihNpgYksKYHlA1ZTg6HO2/bz00=;
        b=KGWB0bbTbJaUzXRP6aIgPEKjCLrIxfROCMDI/E0MfEOfN0CO/CpFcf9HmMFSJjVVLN
         lwJCvrYcl086TpF/EWAkrquvwSEj47oCpIyY8TOzD+dpbSeGt/jAZCGiAp3+FWiV/CE2
         rjT/mZrJxP08Vi28xjWlczUlKq8tXqy9+Z6GRaJCo3E8+/TY/hzOcsuRBUo1UFOq7KBn
         dq9yF7wqMqN6F8OMJ+zfIacl4UP/1ED++cyWQoBDmSkkUdebhn+T4EwRGweV2nF8EUw+
         s/R0/eqB2OYMehZbsk1rVJ2sSNBs+iPWi7pvDmBE3DSoUlGc1L5lbOL3YBw1SY5TBaP9
         hH2A==
X-Forwarded-Encrypted: i=1; AJvYcCUCLZOG/BnVbPd7JZNJoRWWV4HlAdQgI/vwOHKCjBP6J7QVd+4vFkTGF+46k2KcCJOhAB87F9YDkOsJWRsI@vger.kernel.org, AJvYcCXYhB1sNfhi1Q5IFrDn/bcfNosdxO2RcYzwMvwMBU09kQP8HvHU6JX5uER3HqjbJKU8PYdaIxS57Vhncl2I@vger.kernel.org
X-Gm-Message-State: AOJu0YyRWhn/KViJzfFH31eRGK7psN7Uyv+FSiCvvAYEogw8tP6Vgbtz
	vgcy3nIZocPfHGPnpiowE5XnCZdUcGSZj4UQ73Sw6yxaFOlZSX4t
X-Gm-Gg: ASbGncumBo9kc/jLuDb8+NwVcVPW+JHww868kiUa4ynkRXz0eStWViCeObps/Cq8FQd
	QZWX0SE7dvlnfbV4gLo6kBEV6+ApWsjVYiOh5QPth46UtXJczEAsPJjmTWlYhubKChajNJnDxxt
	H21wfXkCafi/srPVghBklsb/i1geczUR8bFRzUCo1Nmj34Jp8su041LyWoSLWYRCdoDuG+HrrY1
	jDRx9+bY/ANhEUdBiidMQHqwwOQQNr2hVusPSOgtnbwyQgmhecLJo/4NXJ1oH/ZPbkE56vBfg==
X-Google-Smtp-Source: AGHT+IEOsfNZcb3SZHyfo1RNEKahDpjpWH1lNU+f8wfMbfmQFVCZdc+JZ+F4SsmzX7wba+7PFtgNEQ==
X-Received: by 2002:a17:90b:5206:b0:2ee:b4d4:78 with SMTP id 98e67ed59e1d1-2f2d7f81d59mr61298a91.24.1734364728337;
        Mon, 16 Dec 2024 07:58:48 -0800 (PST)
Received: from [10.234.7.32] ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc6a53sm8345726a91.51.2024.12.16.07.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 07:58:48 -0800 (PST)
Message-ID: <4169e59e-9015-4323-aae7-09bc8e513bbd@gmail.com>
Date: Mon, 16 Dec 2024 23:58:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand
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
 <500d1007-56f5-43cb-be9d-4a39fccc6e53@arm.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <500d1007-56f5-43cb-be9d-4a39fccc6e53@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/12/5 1:05, Ryan Roberts wrote:
> On 04/12/2024 14:40, Wenchao Hao wrote:
>> On 2024/12/3 22:42, Ryan Roberts wrote:
>>> On 03/12/2024 14:17, David Hildenbrand wrote:
>>>> On 03.12.24 14:49, Wenchao Hao wrote:
>>>>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>>>>> each VMA, but it does not include large pages smaller than PMD size.
>>>>>
>>>>> This patch adds the statistics of anonymous huge pages allocated by
>>>>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>>>>
>>>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>>>> ---
>>>>>   fs/proc/task_mmu.c | 6 ++++++
>>>>>   1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>>> index 38a5a3e9cba2..b655011627d8 100644
>>>>> --- a/fs/proc/task_mmu.c
>>>>> +++ b/fs/proc/task_mmu.c
>>>>> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss,
>>>>> struct page *page,
>>>>>           if (!folio_test_swapbacked(folio) && !dirty &&
>>>>>               !folio_test_dirty(folio))
>>>>>               mss->lazyfree += size;
>>>>> +
>>>>> +        /*
>>>>> +         * Count large pages smaller than PMD size to anonymous_thp
>>>>> +         */
>>>>> +        if (!compound && PageHead(page) && folio_order(folio))
>>>>> +            mss->anonymous_thp += folio_size(folio);
>>>>>       }
>>>>>         if (folio_test_ksm(folio))
>>>>
>>>>
>>>> I think we decided to leave this (and /proc/meminfo) be one of the last
>>>> interfaces where this is only concerned with PMD-sized ones:
>>>>
>>>> Documentation/admin-guide/mm/transhuge.rst:
>>>>
>>>> The number of PMD-sized anonymous transparent huge pages currently used by the
>>>> system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>>>> To identify what applications are using PMD-sized anonymous transparent huge
>>>> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
>>>> fields for each mapping. (Note that AnonHugePages only applies to traditional
>>>> PMD-sized THP for historical reasons and should have been called
>>>> AnonHugePmdMapped).
>>>>
>>>
>>> Agreed. If you need per-process metrics for mTHP, we have a python script at
>>> tools/mm/thpmaps which does a fairly good job of parsing pagemap. --help gives
>>> you all the options.
>>>
>>
>> I tried this tool, and it is very powerful and practical IMO.
>> However, thereare two disadvantages:
>>
>> - This tool is heavily dependent on Python and Python libraries.
>>   After installing several libraries with the pip command, I was able to
>>   get it running.
> 
> I think numpy is the only package it uses which is not in the standard library?
> What other libraries did you need to install?
> 

Yes, I just tested it on the standard version (Fedora), and that is indeed the case.
Previously, I needed to install additional packages is because I removed some unused
software from the old environment.

Recently, I revisited and started using your tool again. It’s very useful, meeting
my needs and even exceeding them. I am now testing with qemu to run a fedora, so
it's easy to run it.

>>   In practice, the environment we need to analyze may be a mobile or
>>   embedded environment, where it is very difficult to deploy these
>>   libraries.
> 
> Yes, I agree that's a problem, especially for Android. The script has proven
> useful to me for debugging in a traditional Linux distro environment though.
> 
>> - It seems that this tool only counts file-backed large pages? During
> 
> No; the tool counts file-backed and anon memory. But it reports it in separate
> counters. See `thpmaps --help` for full details.
> 
>>   the actual test, I mapped a region of anonymous pages and mapped it
>>   as large pages, but the tool did not display those large pages.
>>   Below is my test file(mTHP related sysfs interface is set to "always"
>>   to make sure using large pages):
> 
> Which mTHP sizes did you enable? Depending on your value of SIZE and which mTHP
> sizes are enabled, you may not have a correctly aligned region in p. So mTHP
> would not be allocated. Best to over-allocate then explicitly align p to the
> mTHP size, then fault it in.
> 

I enabled 64k/128k/256k MTHP and have been studying, debugging, and changing
parts of the khugepaged code to try merging standard pages into mTHP large
pages. So, I wanted to use smap to observe the large page sizes in a process.

>>
>> int main()
>> {
>>         int i;
>>         char *c;
>>         unsigned long *p;
>>
>>         p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
> What is SIZE here?
> 
>>         if (!p) {
>>                 perror("fail to get memory");
>>                 exit(-1);
>>         }
>>
>>         c = (unsigned char *)p;
>>
>>         for (i = 0; i < SIZE / 8; i += 8)
>>                 *(p + i) = 0xffff + i;
> 
> Err... what's your intent here? I think you're writting to 1 in every 8 longs?
> Probably just write to the first byte of every page.
> 

The data is fixed for the purpose of analyzing zram compression, so I filled
some data here.

> Thanks,
> Ryan
> 
>>
>>         while (1)
>>                 sleep(10);
>>
>>         return 0;
>> }
>>
>> Thanks,
>> wenchao
>>
> 


