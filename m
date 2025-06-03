Return-Path: <linux-fsdevel+bounces-50434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6378ACC23A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 10:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F6A16E344
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E56280CD6;
	Tue,  3 Jun 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tnEmvyvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE42C3271;
	Tue,  3 Jun 2025 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939570; cv=none; b=HiPbBu3Ur4qH87RAYxqhgyX956DYSX+wzypT63Z0BuDKN7sUhMholHlSXlD6SI9CMBLoHmTgG3wHCvYsZPQwCVO2LdfEzL8B+y9il5t+MuHOXQpV7ZlLfF5UfpSOCs6o3OAx9bfH2GqP6DxCkUdt+8ar5qsM7ijcEjXdDCtT2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939570; c=relaxed/simple;
	bh=/dBAN1usklnswkv7RkRecAqcoikOST1NgMuYR2v5O+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6t3j+9odKjeNzH8TZU3MOAFiqMcU455Zl5hONQBmPBWjOQh8+z0LdXnhHDBDN8M+hYMtp1Z+wxszolqLxXtnp0tvhsp8jZThYHyZe5BS5SR8Cg+r3Fb4QZ7EFGzQ7/47btdJVKLEqF/3R52lf1hHT+J7wnnudabD+oqBBZI0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tnEmvyvl; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748939558; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bIlFp1YkISi/JWhTh6BNTs1elacf5rCr0u2jnk6x4Dk=;
	b=tnEmvyvlDJohgpJ7M3uDyyv6i0fDyo12XruVl53GTUV2gnZg7mL6sPN3rozKJnvvKrYKdOvU8M5AgR2VgoHRp/pWzZ5l29begTjpJFPa9M79nEvVcPbeZUPFza8K0tEJLG9FGxeTgy5UKMWjXqZOahzYhfqQVvAmier9qzyRtME=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcnIfXx_1748939555 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Jun 2025 16:32:36 +0800
Message-ID: <ef2c9e13-cb38-4447-b595-f461f3f25432@linux.alibaba.com>
Date: Tue, 3 Jun 2025 16:32:35 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aD6vHzRhwyTxBqcl@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/3 16:15, Michal Hocko wrote:
> On Tue 03-06-25 16:08:21, Baolin Wang wrote:
>>
>>
>> On 2025/5/30 21:39, Michal Hocko wrote:
>>> On Thu 29-05-25 20:53:13, Andrew Morton wrote:
>>>> On Sat, 24 May 2025 09:59:53 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>>> On some large machines with a high number of CPUs running a 64K pagesize
>>>>> kernel, we found that the 'RES' field is always 0 displayed by the top
>>>>> command for some processes, which will cause a lot of confusion for users.
>>>>>
>>>>>       PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>>>>    875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>>>>>         1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
>>>>>
>>>>> The main reason is that the batch size of the percpu counter is quite large
>>>>> on these machines, caching a significant percpu value, since converting mm's
>>>>> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
>>>>> stats into percpu_counter"). Intuitively, the batch number should be optimized,
>>>>> but on some paths, performance may take precedence over statistical accuracy.
>>>>> Therefore, introducing a new interface to add the percpu statistical count
>>>>> and display it to users, which can remove the confusion. In addition, this
>>>>> change is not expected to be on a performance-critical path, so the modification
>>>>> should be acceptable.
>>>>>
>>>>> Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
>>>>
>>>> Three years ago.
>>>>
>>>>> Tested-by Donet Tom <donettom@linux.ibm.com>
>>>>> Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>>>> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>> Acked-by: SeongJae Park <sj@kernel.org>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>
>>>> Thanks, I added cc:stable to this.
>>>
>>> I have only noticed this new posting now. I do not think this is a
>>> stable material. I am also not convinced that the impact of the pcp lock
>>> exposure to the userspace has been properly analyzed and documented in
>>> the changelog. I am not nacking the patch (yet) but I would like to see
>>> a serious analyses that this has been properly thought through.
>>
>> Good point. I did a quick measurement on my 32 cores Arm machine. I ran two
>> workloads, one is the 'top' command: top -d 1 (updating every second).
>> Another workload is kernel building (time make -j32).
>>
>>  From the following data, I did not see any significant impact of the patch
>> changes on the execution of the kernel building workload.
> 
> I do not think this is really representative of an adverse workload. I
> believe you need to have a look which potentially sensitive kernel code
> paths run with the lock held how would a busy loop over affected proc
> files influence those in the worst case. Maybe there are none of such
> kernel code paths to really worry about. This should be a part of the
> changelog though.

IMO, kernel code paths usually have batch caching to avoid lock 
contention, so I think the impact on kernel code paths is not that 
obvious. Therefore, I also think it's hard to find an adverse workload.

How about adding the following comments in the commit log?
"
I did a quick measurement on my 32 cores Arm machine. I ran two 
workloads, one is the 'top' command: top -d 1 (updating every second). 
Another workload is kernel building (time make -j32).

 From the following data, I did not see any significant impact of the 
patch changes on the execution of the kernel building workload. In 
addition, kernel code paths usually have batch caching to avoid pcp lock 
contention, so I think the impact on kernel code paths is not that 
obvious even the pcp lock is exposed to the userspace.

w/o patch:
real    4m33.887s
user    118m24.153s
sys    9m51.402s

w/ patch:
real    4m34.495s
user    118m21.739s
sys    9m39.232s
"

