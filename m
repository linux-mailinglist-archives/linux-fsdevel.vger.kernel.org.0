Return-Path: <linux-fsdevel+bounces-50495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BFCACC903
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C89016A8E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3BF23956E;
	Tue,  3 Jun 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mdpV9532"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC71422DD;
	Tue,  3 Jun 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960575; cv=none; b=PTgpc5bAUEPO8ZON26VNqe1OZaPBUnHi5i4bb4bxMG3V1URIiOyAaXGF8jaVRLpXP2rAOrqSYbwWXuXKZO3ekiis8/2yS7ewU9W8KO1XR+lDwcfSSSDcsyR3RxG9nqeq5ZkIuQqYUA4wughyAX8Jy260KULgzRJO0OraNw4LBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960575; c=relaxed/simple;
	bh=k5kiH4wTvEIM+F+KJEkPN+o3gWZR/XkDPUA8tjO2p6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCxHhgfnubuOD/9JfxNfH+kDxCxu5k5g2AnL56oe2sjQmYsE25vM/k2oxYWrR3qNtInPtfWsCF/nS74x4PBOUFL1nhtdTD4aRVRtr+jCM8GMqrNQtDVsyAZmJnU+GonNqJtw5TYWdHCTPS/cKV3ejxXDO8bASjRWt6EgZwwIi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mdpV9532; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748960569; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=z5whc9aSlFZxs7dFMWRsS/E387L/NZNDlo8XTMs/rWM=;
	b=mdpV9532wz2KJgrLr7vIJgnoV8LxqIoU9hXNzJx4oSJM44HTGSUtB5Ctpwtp9BXltMXqo3YikDTpDMmcE02W+4v6ijw0Y/e3Ao2tKaxvWajcCmqWabsjEwK6ZqQf6IYTB/Sh0r65+KHdfpTl6pIWeUn4dHzQLzDb1BG+8t42KZw=
Received: from 30.171.150.78(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcvLrj1_1748960566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Jun 2025 22:22:47 +0800
Message-ID: <7307bb7a-7c45-43f7-b073-acd9e1389000@linux.alibaba.com>
Date: Tue, 3 Jun 2025 22:22:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for users
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, donettom@linux.ibm.com,
 aboorvad@linux.ibm.com, sj@kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
 <20250529205313.a1285b431bbec2c54d80266d@linux-foundation.org>
 <aDm1GCV8yToFG1cq@tiehlicka>
 <72f0dc8c-def3-447c-b54e-c390705f8c26@linux.alibaba.com>
 <aD6vHzRhwyTxBqcl@tiehlicka>
 <ef2c9e13-cb38-4447-b595-f461f3f25432@linux.alibaba.com>
 <aD7OM5Mrg5jnEnBc@tiehlicka>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aD7OM5Mrg5jnEnBc@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/3 18:28, Michal Hocko wrote:
> On Tue 03-06-25 16:32:35, Baolin Wang wrote:
>>
>>
>> On 2025/6/3 16:15, Michal Hocko wrote:
>>> On Tue 03-06-25 16:08:21, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2025/5/30 21:39, Michal Hocko wrote:
>>>>> On Thu 29-05-25 20:53:13, Andrew Morton wrote:
>>>>>> On Sat, 24 May 2025 09:59:53 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>>>
>>>>>>> On some large machines with a high number of CPUs running a 64K pagesize
>>>>>>> kernel, we found that the 'RES' field is always 0 displayed by the top
>>>>>>> command for some processes, which will cause a lot of confusion for users.
>>>>>>>
>>>>>>>        PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>>>>>>     875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>>>>>>>          1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
>>>>>>>
>>>>>>> The main reason is that the batch size of the percpu counter is quite large
>>>>>>> on these machines, caching a significant percpu value, since converting mm's
>>>>>>> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
>>>>>>> stats into percpu_counter"). Intuitively, the batch number should be optimized,
>>>>>>> but on some paths, performance may take precedence over statistical accuracy.
>>>>>>> Therefore, introducing a new interface to add the percpu statistical count
>>>>>>> and display it to users, which can remove the confusion. In addition, this
>>>>>>> change is not expected to be on a performance-critical path, so the modification
>>>>>>> should be acceptable.
>>>>>>>
>>>>>>> Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
>>>>>>
>>>>>> Three years ago.
>>>>>>
>>>>>>> Tested-by Donet Tom <donettom@linux.ibm.com>
>>>>>>> Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>>>>>> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>>>>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>>> Acked-by: SeongJae Park <sj@kernel.org>
>>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>
>>>>>> Thanks, I added cc:stable to this.
>>>>>
>>>>> I have only noticed this new posting now. I do not think this is a
>>>>> stable material. I am also not convinced that the impact of the pcp lock
>>>>> exposure to the userspace has been properly analyzed and documented in
>>>>> the changelog. I am not nacking the patch (yet) but I would like to see
>>>>> a serious analyses that this has been properly thought through.
>>>>
>>>> Good point. I did a quick measurement on my 32 cores Arm machine. I ran two
>>>> workloads, one is the 'top' command: top -d 1 (updating every second).
>>>> Another workload is kernel building (time make -j32).
>>>>
>>>>   From the following data, I did not see any significant impact of the patch
>>>> changes on the execution of the kernel building workload.
>>>
>>> I do not think this is really representative of an adverse workload. I
>>> believe you need to have a look which potentially sensitive kernel code
>>> paths run with the lock held how would a busy loop over affected proc
>>> files influence those in the worst case. Maybe there are none of such
>>> kernel code paths to really worry about. This should be a part of the
>>> changelog though.
>>
>> IMO, kernel code paths usually have batch caching to avoid lock contention,
>> so I think the impact on kernel code paths is not that obvious.
> 
> This is a very generic statement. Does this refer to the existing pcp
> locking usage in the kernel? Have you evaluated existing users?

Let me try to clarify further.

The 'mm->rss_stat' is updated by using add_mm_counter(), 
dec/inc_mm_counter(), which are all wrappers around 
percpu_counter_add_batch(). In percpu_counter_add_batch(), there is 
percpu batch caching to avoid 'fbc->lock' contention. This patch changes 
task_mem() and task_statm() to get the accurate mm counters under the 
'fbc->lock', but this will not exacerbate kernel 'mm->rss_stat' lock 
contention due to the the percpu batch caching of the mm counters.

You might argue that my test cases cannot demonstrate an actual lock 
contention, but they have already shown that there is no significant 
'fbc->lock' contention when the kernel updates 'mm->rss_stat'.

>> Therefore, I
>> also think it's hard to find an adverse workload.
>>
>> How about adding the following comments in the commit log?
>> "
>> I did a quick measurement on my 32 cores Arm machine. I ran two workloads,
>> one is the 'top' command: top -d 1 (updating every second). Another workload
>> is kernel building (time make -j32).
> 
> This test doesn't really do much to trigger an actual lock contention as
> already mentioned.
> 

