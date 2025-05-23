Return-Path: <linux-fsdevel+bounces-49739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7FCAC1C94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 07:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCD1A27758
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 05:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B86221D83;
	Fri, 23 May 2025 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZnK36+Lc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C272C2E0;
	Fri, 23 May 2025 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747979272; cv=none; b=kLbJV021bFh1hENVsEwaf4Nl214sNEpnmQaqnEsYYXgNMjqKfRft8/LY33APdLGxjVD6jdAQdtbcEXJbInxprSovF+DP5DctYP/uQOMicu5cMk+EadabBUh9/DaVThFuGJHip3MvF0pHL0fgmxXm2wloFwudNKn+LYLiGV82LQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747979272; c=relaxed/simple;
	bh=fjUhrAGhfAJu6i7kxDjT51kWYN7IRuDDwWWGpn5oG2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9QbBb7HQ5g25InGr3BZcA4PDQWBWw/a0lR/qXbrzmB/Bb2PBzXMyc9JG5UCVLKIKxRuc84wjoS9GpIKlgnyfOv7dHRe66r3+GjCsenh7OIYKnKL2/+mAULT4PDPKUHLjGttXaJNAAMZ4YTnuTeGDIbwVZHW6kucHCC+tXikI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZnK36+Lc; arc=none smtp.client-ip=47.90.199.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747979250; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N0FYBJTz4x5AnUByavGB9voFSl9Kgb9EFlBcYE2WEJc=;
	b=ZnK36+Lcatoj+RM1Q01wXRkXb4MoV4pUyJqKbMhqw33roakpm8t25kdNXCPZj+cBS6V7K3R5U6mxOZsYmLoFrOw/NhXXdInxn+grRHCLXFIJtyy8gsXTcbfc1ApsKs0XsRmkdqfPdR1VRoS1fYEj0FIUFNZI1y4JHN3udqOZ8cQ=
Received: from 30.74.144.180(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbZAkgN_1747979248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 May 2025 13:47:29 +0800
Message-ID: <eb7e85f3-90d5-428c-a93a-7e54ade1479c@linux.alibaba.com>
Date: Fri, 23 May 2025 13:47:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: fix the inaccurate memory statistics issue for
 users
To: Donet Tom <donettom@linux.ibm.com>, akpm@linux-foundation.org,
 david@redhat.com, shakeelb@google.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
 <ac3b8c16-1f2b-4f2f-8bcd-ef8da8544a20@linux.ibm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ac3b8c16-1f2b-4f2f-8bcd-ef8da8544a20@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/23 13:25, Donet Tom wrote:
> 
> On 5/23/25 8:46 AM, Baolin Wang wrote:
>> On some large machines with a high number of CPUs running a 64K kernel,
>> we found that the 'RES' field is always 0 displayed by the top command
>> for some processes, which will cause a lot of confusion for users.
>>
>>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     
>> TIME+ COMMAND
>>   875525 root      20   0   12480      0      0 R   0.3   0.0   
>> 0:00.08 top
>>        1 root      20   0  172800      0      0 S   0.0   0.0   
>> 0:04.52 systemd
>>
>> The main reason is that the batch size of the percpu counter is quite 
>> large
>> on these machines, caching a significant percpu value, since 
>> converting mm's
>> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert 
>> mm's rss
>> stats into percpu_counter"). Intuitively, the batch number should be 
>> optimized,
>> but on some paths, performance may take precedence over statistical 
>> accuracy.
>> Therefore, introducing a new interface to add the percpu statistical 
>> count
>> and display it to users, which can remove the confusion. In addition, 
>> this
>> change is not expected to be on a performance-critical path, so the 
>> modification
>> should be acceptable.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   fs/proc/task_mmu.c | 14 +++++++-------
>>   include/linux/mm.h |  5 +++++
>>   2 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index b9e4fbbdf6e6..f629e6526935 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -36,9 +36,9 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>>       unsigned long text, lib, swap, anon, file, shmem;
>>       unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
>> -    anon = get_mm_counter(mm, MM_ANONPAGES);
>> -    file = get_mm_counter(mm, MM_FILEPAGES);
>> -    shmem = get_mm_counter(mm, MM_SHMEMPAGES);
>> +    anon = get_mm_counter_sum(mm, MM_ANONPAGES);
> 
> 
> Hi Baolin Wang,
> 
> We also observed the same issue where the RSS value in /proc/PID/status
> was 0 on machines with a high number of CPUs. With this patch, the issue
> got fixedl

Yes, we also observed this issue.

> Rss value without this patch
> ----------------------------
>   # cat /proc/87406/status
> .....
> VmRSS:           0 kB
> RssAnon:           0 kB
> RssFile:           0 k
> 
> 
> Rss values with this patch
> --------------------------
>   # cat /proc/3055/status
> VmRSS:        2176 kB
> RssAnon:         512 kB
> RssFile:        1664 kB
> RssShmem:           0 kB
> 
> Tested-by Donet Tom <donettom@linux.ibm.com>

Thanks for testing.

