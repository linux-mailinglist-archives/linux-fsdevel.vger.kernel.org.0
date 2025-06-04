Return-Path: <linux-fsdevel+bounces-50608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64864ACDE44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 14:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57ED1895A7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C05028EA69;
	Wed,  4 Jun 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aP0TCoLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA5624DCF9;
	Wed,  4 Jun 2025 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749041182; cv=none; b=q1Cf6aWsDm6XwxWtgduowmcGfsabd/eVyOuQzG37NjkvH++W2fsIvkJaMISJkexGSQHenLpZm6YLMaO2F2ySLH0UEQXlNzHnPED2YHmSGJ6lS5moXD/Jo9zMYVcHgkfTjSHbBxGtMhEd+vxJTyqck1TfuXVr/n5+N++w1eBgOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749041182; c=relaxed/simple;
	bh=Jj5d5qdiuvNZV+1ZocrmbCC3IGMI4hi5uTm1a75PdYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwL/+vmV4ukHF9K92UCm0D3SLo9HRT1DOa1VuGVkUCylwwAn2ayGSIOmRRcMIU01FVCPsji+cYxBBRXJ+iiRC0WumLo79YQOZQPJy7nZ0hH+0LBfCFVEd/9XelBmyx3wEwQs7t2A+zlddg9/nTutf87PJoLqRVnMb9GD2DG0ED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aP0TCoLo; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749041169; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TPLFxmuO1Q5FsFGt4jj6PdsNEZVTzIdznxUKQp9Xs4o=;
	b=aP0TCoLo+hrHR3m6LmEXykmRNzuv/qqlwIe5N2b5VaP8UvceZeIJbqYYVB9Uu4b+vuF4fJl/nwseLLtQ2/arykUp/7v5SQsGKSFKKp8y+LYXegJZP8hgEKCxZ6LleiYaTqMSjDjQBKnXOqT0wT2ZiKk4id1q2LaKmtjnysy90ng=
Received: from 30.121.8.237(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wd4RjKR_1749041167 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Jun 2025 20:46:07 +0800
Message-ID: <250ec733-8b2d-4c56-858c-6aada9544a55@linux.alibaba.com>
Date: Wed, 4 Jun 2025 20:46:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for users
To: Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, donettom@linux.ibm.com,
 aboorvad@linux.ibm.com, sj@kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
 <20250529205313.a1285b431bbec2c54d80266d@linux-foundation.org>
 <aDm1GCV8yToFG1cq@tiehlicka>
 <72f0dc8c-def3-447c-b54e-c390705f8c26@linux.alibaba.com>
 <aD6vHzRhwyTxBqcl@tiehlicka>
 <ef2c9e13-cb38-4447-b595-f461f3f25432@linux.alibaba.com>
 <aD7OM5Mrg5jnEnBc@tiehlicka>
 <7307bb7a-7c45-43f7-b073-acd9e1389000@linux.alibaba.com>
 <aD8LKHfCca1wQ5pS@tiehlicka>
 <obfnlpvc4tmb6gbd4mw7h7jamp3kouyhnpl4cusetyctswznod@yr6dyrsbay6w>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <obfnlpvc4tmb6gbd4mw7h7jamp3kouyhnpl4cusetyctswznod@yr6dyrsbay6w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/4 01:29, Shakeel Butt wrote:
> On Tue, Jun 03, 2025 at 04:48:08PM +0200, Michal Hocko wrote:
>> On Tue 03-06-25 22:22:46, Baolin Wang wrote:
>>> Let me try to clarify further.
>>>
>>> The 'mm->rss_stat' is updated by using add_mm_counter(),
>>> dec/inc_mm_counter(), which are all wrappers around
>>> percpu_counter_add_batch(). In percpu_counter_add_batch(), there is percpu
>>> batch caching to avoid 'fbc->lock' contention.
>>
>> OK, this is exactly the line of argument I was looking for. If _all_
>> updates done in the kernel are using batching and therefore the lock is
>> only held every N (percpu_counter_batch) updates then a risk of locking
>> contention would be decreased. This is worth having a note in the
>> changelog.

OK.

>>> This patch changes task_mem()
>>> and task_statm() to get the accurate mm counters under the 'fbc->lock', but
>>> this will not exacerbate kernel 'mm->rss_stat' lock contention due to the
>>> the percpu batch caching of the mm counters.
>>>
>>> You might argue that my test cases cannot demonstrate an actual lock
>>> contention, but they have already shown that there is no significant
>>> 'fbc->lock' contention when the kernel updates 'mm->rss_stat'.
>>
>> I was arguing that `top -d 1' doesn't really represent a potential
>> adverse usage. These proc files are generally readable so I would be
>> expecting something like busy loop read while process tries to update
>> counters to see the worst case scenario. If that is barely visible then
>> we can conclude a normal use wouldn't even notice.

OK.

> Baolin, please run stress-ng command that stresses minor anon page
> faults in multiple threads and then run multiple bash scripts which cat
> /proc/pidof(stress-ng)/status. That should be how much the stress-ng
> process is impacted by the parallel status readers versus without them.

Sure. Thanks Shakeel. I run the stress-ng with the 'stress-ng --fault 32 
--perf -t 1m' command, while simultaneously running the following 
scripts to read the /proc/pidof(stress-ng)/status for each thread.

 From the following data, I did not observe any obvious impact of this 
patch on the stress-ng tests when repeatedly reading the 
/proc/pidof(stress-ng)/status.

w/o patch
stress-ng: info:  [6891]          3,993,235,331,584 CPU Cycles 
          59.767 B/sec
stress-ng: info:  [6891]          1,472,101,565,760 Instructions 
          22.033 B/sec (0.369 instr. per cycle)
stress-ng: info:  [6891]                 36,287,456 Page Faults Total 
           0.543 M/sec
stress-ng: info:  [6891]                 36,287,456 Page Faults Minor 
           0.543 M/sec

w/ patch
stress-ng: info:  [6872]          4,018,592,975,968 CPU Cycles 
          60.177 B/sec
stress-ng: info:  [6872]          1,484,856,150,976 Instructions 
          22.235 B/sec (0.369 instr. per cycle)
stress-ng: info:  [6872]                 36,547,456 Page Faults Total 
           0.547 M/sec
stress-ng: info:  [6872]                 36,547,456 Page Faults Minor 
           0.547 M/sec

=========================
#!/bin/bash

# Get the PIDs of stress-ng processes
PIDS=$(pgrep stress-ng)

# Loop through each PID and monitor /proc/[pid]/status
for PID in $PIDS; do
     while true; do
         cat /proc/$PID/status
	usleep 100000
     done &
done

