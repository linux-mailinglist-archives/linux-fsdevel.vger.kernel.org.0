Return-Path: <linux-fsdevel+bounces-49801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F78AC2CE3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 03:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA027ABA22
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 01:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78601DFD86;
	Sat, 24 May 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PoQq9TbW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4BC127E18;
	Sat, 24 May 2025 01:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049895; cv=none; b=Hhrj9gcWaMoxYqwWo8wdwrLOHoQwUxLElIvdqDonSMGk5Hvmtp1bH1D9I0lxIJjpsKnHuPTwoEUbzwsWvGq8u2CLpIoM7JcLu/fs1KX96Kg7KxGDKweo4/3Wh/T4u5WGPnyy68iPLldczILmayWTXOzto5x6SI4VOX+yshOoSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049895; c=relaxed/simple;
	bh=h4rD/7gqAjKhxjE14JthcVzwphPAyrPyYn/PgY8UTrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pa72+IufflTlRpziubdPKKRRjVIuTeU6EsDsMoX7bx+HpXeOJkAoOeYdnIm3aA6G1it6aaWGkDA0u/pkbIoyzWw24xGx7iu6ohM2K7kW524xepLBSQg1zyWspt7oY5UUtJCPCiUE8DMMmH5MuaJrnKxXh5RFnrC4kP0eVRkTbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PoQq9TbW; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748049882; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kURdILkIqYXjN86J/Vi1nRzrLORAbMvg48iqJVcrqJs=;
	b=PoQq9TbWUgsL72um0UPytedpqWhURksEdD/SOl889JUo4ZZORFbLjZMlBmR2ipdK9rwy9jccp2GatGCb4W2GcFTOncn1N9GsBPg2byZarg3L/kGmecy3LU+uaK/hzfSPm/UKaDyNMTLBVtTNUNEi+7HPLhxoowtYv/cLa3Trv50=
Received: from 30.171.233.170(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbcABvS_1748049880 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 24 May 2025 09:24:41 +0800
Message-ID: <6d6dcad5-169f-4bfc-91be-c620fef811e4@linux.alibaba.com>
Date: Sat, 24 May 2025 09:24:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: fix the inaccurate memory statistics issue for
 users
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 david@redhat.com, shakeel.butt@linux.dev
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
 <ea0963e4b497efb46c2c8e62a30463747cd25bf9.camel@linux.ibm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ea0963e4b497efb46c2c8e62a30463747cd25bf9.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/23 18:14, Aboorva Devarajan wrote:
> On Fri, 2025-05-23 at 11:16 +0800, Baolin Wang wrote:
>> On some large machines with a high number of CPUs running a 64K kernel,
>> we found that the 'RES' field is always 0 displayed by the top command
>> for some processes, which will cause a lot of confusion for users.
>>
>>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>   875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>>        1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
>>
>> The main reason is that the batch size of the percpu counter is quite large
>> on these machines, caching a significant percpu value, since converting mm's
>> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
>> stats into percpu_counter"). Intuitively, the batch number should be optimized,
>> but on some paths, performance may take precedence over statistical accuracy.
>> Therefore, introducing a new interface to add the percpu statistical count
>> and display it to users, which can remove the confusion. In addition, this
>> change is not expected to be on a performance-critical path, so the modification
>> should be acceptable.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   fs/proc/task_mmu.c | 14 +++++++-------
>>   include/linux/mm.h |  5 +++++
>>   2 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index b9e4fbbdf6e6..f629e6526935 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -36,9 +36,9 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>>   	unsigned long text, lib, swap, anon, file, shmem;
>>   	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
>>   
>> -	anon = get_mm_counter(mm, MM_ANONPAGES);
>> -	file = get_mm_counter(mm, MM_FILEPAGES);
>> -	shmem = get_mm_counter(mm, MM_SHMEMPAGES);
>> +	anon = get_mm_counter_sum(mm, MM_ANONPAGES);
>> +	file = get_mm_counter_sum(mm, MM_FILEPAGES);
>> +	shmem = get_mm_counter_sum(mm, MM_SHMEMPAGES);
>>   
>>   	/*
>>   	 * Note: to minimize their overhead, mm maintains hiwater_vm and
>> @@ -59,7 +59,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>>   	text = min(text, mm->exec_vm << PAGE_SHIFT);
>>   	lib = (mm->exec_vm << PAGE_SHIFT) - text;
>>   
>> -	swap = get_mm_counter(mm, MM_SWAPENTS);
>> +	swap = get_mm_counter_sum(mm, MM_SWAPENTS);
>>   	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
>>   	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
>>   	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
>> @@ -92,12 +92,12 @@ unsigned long task_statm(struct mm_struct *mm,
>>   			 unsigned long *shared, unsigned long *text,
>>   			 unsigned long *data, unsigned long *resident)
>>   {
>> -	*shared = get_mm_counter(mm, MM_FILEPAGES) +
>> -			get_mm_counter(mm, MM_SHMEMPAGES);
>> +	*shared = get_mm_counter_sum(mm, MM_FILEPAGES) +
>> +			get_mm_counter_sum(mm, MM_SHMEMPAGES);
>>   	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
>>   								>> PAGE_SHIFT;
>>   	*data = mm->data_vm + mm->stack_vm;
>> -	*resident = *shared + get_mm_counter(mm, MM_ANONPAGES);
>> +	*resident = *shared + get_mm_counter_sum(mm, MM_ANONPAGES);
>>   	return mm->total_vm;
>>   }
>>   
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 185424858f23..15ec5cfe9515 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2568,6 +2568,11 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
>>   	return percpu_counter_read_positive(&mm->rss_stat[member]);
>>   }
>>   
>> +static inline unsigned long get_mm_counter_sum(struct mm_struct *mm, int member)
>> +{
>> +	return percpu_counter_sum_positive(&mm->rss_stat[member]);
>> +}
>> +
>>   void mm_trace_rss_stat(struct mm_struct *mm, int member);
>>   
>>   static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
> 
> Hi Baolin,
> 
> This patch looks good to me. We observed a similar issue where the
> generic mm selftest split_huge_page_test failed due to outdated RssAnon
> values reported in /proc/[pid]/status.
> 
> ...
> 
> Without Patch:
> 
> # ./split_huge_page_test
> TAP version 13
> 1..34
> Bail out! No RssAnon is allocated before split
> # Planned tests != run tests (34 != 0)
> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> ...
> 
> With Patch:
> 
> # ./split_huge_page_test
> # ./split_huge_page_test
> TAP version 13
> 1..34
> ...
> # Totals: pass:11 fail:0 xfail:0 xpass:0 skip:23 error:0
> 
> ...
> 
> While this change may introduce some lock contention, it only affects
> the task_mem function which is invoked only when reading
> /proc/[pid]/status. Since this is not on a performance critical path,
> it will be good to have this change in order to get accurate memory
> stats.

Agree.

> 
> This fix resolves the issue we've seen with split_huge_page_test.
> 
> Thanks!
> 
> 
> Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> 

Thanks for reviewing and testing.

