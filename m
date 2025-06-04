Return-Path: <linux-fsdevel+bounces-50614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC7AACE00A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700B8189A480
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF00290BDA;
	Wed,  4 Jun 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vutKBtro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D50290094;
	Wed,  4 Jun 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046594; cv=none; b=tIyRQ17sYXjnxUIUwXOgf3DxUgDyMeYVS5ufK8QQcv5U/EETHPajz2BQzqi9cx5Tp2KjzgZWewUEiAgaR3c6EcUQFze2zcSJvrhCmnHFkTv0iGlP57PaYF54tocaQFILt2ULpAyw+ucz9gs3ch0pvG3lulu6l9xeLPLe3bXOrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046594; c=relaxed/simple;
	bh=QVGHxv5yv8Xa1quyiBjHI4r3pwDZnDe3cLJmy+ls+ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6ObLGg7MSWI3IjU/9cS02uShrrLxRf9jd1oDg8TDNiaYddZdrjOYgEO3bPZF4Plgu+SQxu5AP64p4Zz11TnFdpjsOjO02xbbNrevDni4u+tUkFMJfJSVO3jtYqwNjoAl+cHs7AWId2NjEjd2I76sVrSziIzIuVXcuA8WlcNDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vutKBtro; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749046581; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sl7zkIjY2EtL4gQUaLHHsUyVaTgNOPl8UyCODnHq/ts=;
	b=vutKBtro0b0lToHaUdzBqdVefNiQji7KMrNS9jtAh+jwlWKeLW29Qn6jN/MjBTugufHK9B8zbWdYn9oUCTBfW/HKgHXtHQnmUdVyn3GIeVBofNtof2xUOGoXq9SKMvH5ehLH9sbFvBblAxpnpoYgAQWTrU934YePJa7oF6j5v6I=
Received: from 192.168.0.105(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wd4ZSft_1749046579 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Jun 2025 22:16:19 +0800
Message-ID: <d2b76402-7e1a-4b2d-892a-2e8ffe1a37a9@linux.alibaba.com>
Date: Wed, 4 Jun 2025 22:16:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for users
To: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com,
 sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
 <250ec733-8b2d-4c56-858c-6aada9544a55@linux.alibaba.com>
 <1aa7c368-c37f-4b00-876c-dcf51a523c42@suse.cz>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1aa7c368-c37f-4b00-876c-dcf51a523c42@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/4 21:46, Vlastimil Babka wrote:
> On 6/4/25 14:46, Baolin Wang wrote:
>>> Baolin, please run stress-ng command that stresses minor anon page
>>> faults in multiple threads and then run multiple bash scripts which cat
>>> /proc/pidof(stress-ng)/status. That should be how much the stress-ng
>>> process is impacted by the parallel status readers versus without them.
>>
>> Sure. Thanks Shakeel. I run the stress-ng with the 'stress-ng --fault 32
>> --perf -t 1m' command, while simultaneously running the following
>> scripts to read the /proc/pidof(stress-ng)/status for each thread.
> 
> How many of those scripts?

1 script, but will start 32 threads to read each stress-ng thread's 
status interface.

>>   From the following data, I did not observe any obvious impact of this
>> patch on the stress-ng tests when repeatedly reading the
>> /proc/pidof(stress-ng)/status.
>>
>> w/o patch
>> stress-ng: info:  [6891]          3,993,235,331,584 CPU Cycles
>>            59.767 B/sec
>> stress-ng: info:  [6891]          1,472,101,565,760 Instructions
>>            22.033 B/sec (0.369 instr. per cycle)
>> stress-ng: info:  [6891]                 36,287,456 Page Faults Total
>>             0.543 M/sec
>> stress-ng: info:  [6891]                 36,287,456 Page Faults Minor
>>             0.543 M/sec
>>
>> w/ patch
>> stress-ng: info:  [6872]          4,018,592,975,968 CPU Cycles
>>            60.177 B/sec
>> stress-ng: info:  [6872]          1,484,856,150,976 Instructions
>>            22.235 B/sec (0.369 instr. per cycle)
>> stress-ng: info:  [6872]                 36,547,456 Page Faults Total
>>             0.547 M/sec
>> stress-ng: info:  [6872]                 36,547,456 Page Faults Minor
>>             0.547 M/sec
>>
>> =========================
>> #!/bin/bash
>>
>> # Get the PIDs of stress-ng processes
>> PIDS=$(pgrep stress-ng)
>>
>> # Loop through each PID and monitor /proc/[pid]/status
>> for PID in $PIDS; do
>>       while true; do
>>           cat /proc/$PID/status
>> 	usleep 100000
> 
> Hm but this limits the reading to 10 per second? If we want to simulate an
> adversary process, it should be without the sleeps I think?

OK. I drop the usleep, and I still can not see obvious impact.

w/o patch:
stress-ng: info:  [6848]          4,399,219,085,152 CPU Cycles 
          67.327 B/sec
stress-ng: info:  [6848]          1,616,524,844,832 Instructions 
          24.740 B/sec (0.367 instr. per cycle)
stress-ng: info:  [6848]                 39,529,792 Page Faults Total 
           0.605 M/sec
stress-ng: info:  [6848]                 39,529,792 Page Faults Minor 
           0.605 M/sec

w/patch:
stress-ng: info:  [2485]          4,462,440,381,856 CPU Cycles 
          68.382 B/sec
stress-ng: info:  [2485]          1,615,101,503,296 Instructions 
          24.750 B/sec (0.362 instr. per cycle)
stress-ng: info:  [2485]                 39,439,232 Page Faults Total 
           0.604 M/sec
stress-ng: info:  [2485]                 39,439,232 Page Faults Minor 
           0.604 M/sec

