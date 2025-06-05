Return-Path: <linux-fsdevel+bounces-50692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F51ACE79D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 02:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB054175EA0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 00:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF488288D2;
	Thu,  5 Jun 2025 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UodMRz/H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E918C06;
	Thu,  5 Jun 2025 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749084513; cv=none; b=CI1raqkY4Pzhsj5rQJ37553UyGKseyusJge9FqEBOZ55dKbdorauSeDW2OiOwTJS7gGdrgDAW8thAKbzS3XQ01fluy0iODgABwgMDHcgu0b5SkdPjkJxqiG4nJiTzL9bmYi03Yc8H5yrZN1i9rxBi0bokIFRo7GLloJ/yO5YW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749084513; c=relaxed/simple;
	bh=spiNuMouzkosxKKAlHJ/LKnfR6O/EaZkfHwVp4bYclQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iloMX3MpV+uv8wg4DtIE4OCP5mjc7YJkapCWz8HjjwNP+ryhDLWkS3IsZI0ISIpO9pOItyhUu/i1Dbzb+ygsgfRW07alNwLT+C5/qGUfaGmqk2+5NKIzFDyUmEslJ3M2uTmtuXrIqJ80nyVNWcAPq6ZbTqktHSSA+gad3LeJIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UodMRz/H; arc=none smtp.client-ip=47.90.199.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749084492; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hoFzIfUZJ4wj8058GkOSPWGehDB1B6IcsKmHwslnUG0=;
	b=UodMRz/HOMIBX30RINyRFY2tD1EH1zPFYc2AwHaP0+L3+7NkM1Rj/uMBghFVnuLOHzd6KQGriFSxHvmuw/n366oV51rq4jUHR16hM0W7eaN42++G6GyE9Xf0LmVFtCTEfc8Xqkp2KEquxx/WQP+fdXikxQNUFeWsrldwj8xHa7g=
Received: from 192.168.43.81(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wd5p7oJ_1749084488 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Jun 2025 08:48:10 +0800
Message-ID: <985a92d4-e0d4-4164-88eb-dc7931e2c40c@linux.alibaba.com>
Date: Thu, 5 Jun 2025 08:48:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for users
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com,
 sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <72f0dc8c-def3-447c-b54e-c390705f8c26@linux.alibaba.com>
 <aD6vHzRhwyTxBqcl@tiehlicka>
 <ef2c9e13-cb38-4447-b595-f461f3f25432@linux.alibaba.com>
 <aD7OM5Mrg5jnEnBc@tiehlicka>
 <7307bb7a-7c45-43f7-b073-acd9e1389000@linux.alibaba.com>
 <aD8LKHfCca1wQ5pS@tiehlicka>
 <obfnlpvc4tmb6gbd4mw7h7jamp3kouyhnpl4cusetyctswznod@yr6dyrsbay6w>
 <250ec733-8b2d-4c56-858c-6aada9544a55@linux.alibaba.com>
 <1aa7c368-c37f-4b00-876c-dcf51a523c42@suse.cz>
 <d2b76402-7e1a-4b2d-892a-2e8ffe1a37a9@linux.alibaba.com>
 <nohu552nfqkfumrj3zc7akbdrq3bzwexle3i6weyta76dltppv@txizmvtg3swd>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <nohu552nfqkfumrj3zc7akbdrq3bzwexle3i6weyta76dltppv@txizmvtg3swd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/5 00:54, Shakeel Butt wrote:
> On Wed, Jun 04, 2025 at 10:16:18PM +0800, Baolin Wang wrote:
>>
>>
>> On 2025/6/4 21:46, Vlastimil Babka wrote:
>>> On 6/4/25 14:46, Baolin Wang wrote:
>>>>> Baolin, please run stress-ng command that stresses minor anon page
>>>>> faults in multiple threads and then run multiple bash scripts which cat
>>>>> /proc/pidof(stress-ng)/status. That should be how much the stress-ng
>>>>> process is impacted by the parallel status readers versus without them.
>>>>
>>>> Sure. Thanks Shakeel. I run the stress-ng with the 'stress-ng --fault 32
>>>> --perf -t 1m' command, while simultaneously running the following
>>>> scripts to read the /proc/pidof(stress-ng)/status for each thread.
>>>
>>> How many of those scripts?
>>
>> 1 script, but will start 32 threads to read each stress-ng thread's status
>> interface.
>>
>>>>    From the following data, I did not observe any obvious impact of this
>>>> patch on the stress-ng tests when repeatedly reading the
>>>> /proc/pidof(stress-ng)/status.
>>>>
>>>> w/o patch
>>>> stress-ng: info:  [6891]          3,993,235,331,584 CPU Cycles
>>>>             59.767 B/sec
>>>> stress-ng: info:  [6891]          1,472,101,565,760 Instructions
>>>>             22.033 B/sec (0.369 instr. per cycle)
>>>> stress-ng: info:  [6891]                 36,287,456 Page Faults Total
>>>>              0.543 M/sec
>>>> stress-ng: info:  [6891]                 36,287,456 Page Faults Minor
>>>>              0.543 M/sec
>>>>
>>>> w/ patch
>>>> stress-ng: info:  [6872]          4,018,592,975,968 CPU Cycles
>>>>             60.177 B/sec
>>>> stress-ng: info:  [6872]          1,484,856,150,976 Instructions
>>>>             22.235 B/sec (0.369 instr. per cycle)
>>>> stress-ng: info:  [6872]                 36,547,456 Page Faults Total
>>>>              0.547 M/sec
>>>> stress-ng: info:  [6872]                 36,547,456 Page Faults Minor
>>>>              0.547 M/sec
>>>>
>>>> =========================
>>>> #!/bin/bash
>>>>
>>>> # Get the PIDs of stress-ng processes
>>>> PIDS=$(pgrep stress-ng)
>>>>
>>>> # Loop through each PID and monitor /proc/[pid]/status
>>>> for PID in $PIDS; do
>>>>        while true; do
>>>>            cat /proc/$PID/status
>>>> 	usleep 100000
>>>
>>> Hm but this limits the reading to 10 per second? If we want to simulate an
>>> adversary process, it should be without the sleeps I think?
>>
>> OK. I drop the usleep, and I still can not see obvious impact.
>>
>> w/o patch:
>> stress-ng: info:  [6848]          4,399,219,085,152 CPU Cycles
>> 67.327 B/sec
>> stress-ng: info:  [6848]          1,616,524,844,832 Instructions
>> 24.740 B/sec (0.367 instr. per cycle)
>> stress-ng: info:  [6848]                 39,529,792 Page Faults Total
>> 0.605 M/sec
>> stress-ng: info:  [6848]                 39,529,792 Page Faults Minor
>> 0.605 M/sec
>>
>> w/patch:
>> stress-ng: info:  [2485]          4,462,440,381,856 CPU Cycles
>> 68.382 B/sec
>> stress-ng: info:  [2485]          1,615,101,503,296 Instructions
>> 24.750 B/sec (0.362 instr. per cycle)
>> stress-ng: info:  [2485]                 39,439,232 Page Faults Total
>> 0.604 M/sec
>> stress-ng: info:  [2485]                 39,439,232 Page Faults Minor
>> 0.604 M/sec
> 
> Is the above with 32 non-sleeping parallel reader scripts?

Yes.

