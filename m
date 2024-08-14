Return-Path: <linux-fsdevel+bounces-25932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D673E951F9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928F5282F98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3D1B86EF;
	Wed, 14 Aug 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ET4IDp+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1D1B3F0F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652157; cv=none; b=Qpzc5RJCoscv9bDt8j+JM4Q+I9L5rHPeH/X3UYZIFvx51fRysTWuG+doPjZBStzEh42ENGtSHI0grlFj9u18j3WJFLW27vRYVgsVpX63Areqvm5Zi6sdttHG2btY1QorMkfUf+uhLaYhzj8Fm9nkuNS6EaLWCfKMcGjHSv5HQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652157; c=relaxed/simple;
	bh=3mXr/6h6lT95ur+dscFgm9tZkCxglKXqx5l9umpgz7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ih5Rc0X3ddZpP5QpcpDRFOSwhD9Lbo2nkYi/TgGME1S36WIfSfB4sXpO2Ffa6t4ecDPwSERapKSyg05IGYCE1fG7AoS91SVmophuRfZH7O6dCDQgrs+zEbfk4wIb6zZ/CM3DOW543hiLybtK6URHVOgFkfmyEc8BofV9I/WRvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ET4IDp+3; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f21b635e-3bd7-48c3-b257-dde1b9f49c6c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723652153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfSA6DWqUV6iEzUz38Yd8F3h1Wfcr8ykatb0DJro06A=;
	b=ET4IDp+3z8YnwfSgfouUmDUX2Ajs8uytSGcauLb+Pt7qJDi0vHNOnXL4qb8sSQOHI4xwvT
	GiWe9GqPAvuZOA8bhPJxPzKoADmwVMmbRqkybIH28hgW7asvfZjoDCbhQJKBO8NIxGFVp+
	x1Sqc7P2MgjEU5MIPS5anLCAcDqiyrg=
Date: Thu, 15 Aug 2024 00:15:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2] eventfd: introduce ratelimited wakeup for
 non-semaphore eventfd
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Dylan Yudaken <dylany@fb.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, Dave Young <dyoung@redhat.com>,
 kernel test robot <lkp@intel.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240811085954.17162-1-wen.yang@linux.dev>
 <w7ldxi4jcdizkefv7musjwxblwu66pg3rfteprfymqoxaev6by@ikvzlsncihbr>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <w7ldxi4jcdizkefv7musjwxblwu66pg3rfteprfymqoxaev6by@ikvzlsncihbr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/8/11 18:26, Mateusz Guzik wrote:
> On Sun, Aug 11, 2024 at 04:59:54PM +0800, Wen Yang wrote:
>> For the NON-SEMAPHORE eventfd, a write (2) call adds the 8-byte integer
>> value provided in its buffer to the counter, while a read (2) returns the
>> 8-byte value containing the value and resetting the counter value to 0.
>> Therefore, the accumulated value of multiple writes can be retrieved by a
>> single read.
>>
>> However, the current situation is to immediately wake up the read thread
>> after writing the NON-SEMAPHORE eventfd, which increases unnecessary CPU
>> overhead. By introducing a configurable rate limiting mechanism in
>> eventfd_write, these unnecessary wake-up operations are reduced.
>>
>>
> [snip]
> 
>> 	# ./a.out  -p 2 -s 3
>> 	The original cpu usage is as follows:
>> 09:53:38 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>> 09:53:40 PM    2   47.26    0.00   52.74    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>> 09:53:40 PM    3   44.72    0.00   55.28    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>
>> 09:53:40 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>> 09:53:42 PM    2   45.73    0.00   54.27    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>> 09:53:42 PM    3   46.00    0.00   54.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>
>> 09:53:42 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>> 09:53:44 PM    2   48.00    0.00   52.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>> 09:53:44 PM    3   45.50    0.00   54.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>
>> Then enable the ratelimited wakeup, eg:
>> 	# ./a.out  -p 2 -s 3  -r1000 -c2
>>
>> Observing a decrease of over 20% in CPU utilization (CPU # 3, 54% ->30%), as shown below:
>> 10:02:32 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>> 10:02:34 PM    2   53.00    0.00   47.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>> 10:02:34 PM    3   30.81    0.00   30.81    0.00    0.00    0.00    0.00    0.00    0.00   38.38
>>
>> 10:02:34 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>> 10:02:36 PM    2   48.50    0.00   51.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>> 10:02:36 PM    3   30.20    0.00   30.69    0.00    0.00    0.00    0.00    0.00    0.00   39.11
>>
>> 10:02:36 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>> 10:02:38 PM    2   45.00    0.00   55.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>> 10:02:38 PM    3   27.08    0.00   30.21    0.00    0.00    0.00    0.00    0.00    0.00   42.71
>>
>>
> 
> Where are these stats from? Is this from your actual program you coded
> the feature for?
> 
> The program you inlined here does next to nothing in userspace and
> unsurprisingly the entire thing is dominated by kernel time, regardless
> of what event rate can be achieved.
> 
> For example I got: /a.out -p 2 -s 3  5.34s user 60.85s system 99% cpu 66.19s (1:06.19) total
> 
> Even so, looking at perf top shows me that a significant chunk is
> contention stemming from calls to poll -- perhaps the overhead will
> sufficiently go down if you epoll instead?

We have two threads here, one publishing and one subscribing, running on 
CPUs 2 and 3 respectively. If we further refine and collect performance 
data on CPU 2, we will find that a large amount of CPU is consumed on 
the spin lock of the wake-up logic of event write, for example:

  # perf top  -C 2  -e cycles:k

     65.80%  [kernel]       [k] do_syscall_64
     14.71%  [kernel]       [k] _raw_spin_unlock_irq
      7.54%  [kernel]       [k] __fget_light
      4.52%  [kernel]       [k] ksys_write
      1.94%  [kernel]       [k] vfs_write
      1.43%  [kernel]       [k] _copy_from_user
      0.87%  [kernel]       [k] common_file_perm
      0.61%  [kernel]       [k] aa_file_perm
      0.46%  [kernel]       [k] eventfd_write


One of its call stacks:

|--6.39%--vfs_write
|           --5.46%--eventfd_write
|                      --4.73%--_raw_spin_unlock_irq


>  > I think the idea is pretty dodgey. If the consumer program can tolerate
> some delay in event processing, this probably can be massaged entirely in
> userspace.
> 
> If your real program has the wake up rate so high that it constitutes a
> tangible problem I wonder if eventfd is even the right primitive to use
> -- perhaps something built around shared memory and futexes would do the
> trick significantly better?

Thank you for your feedback.

This demo comes from the real world: the test vehicle has sensors with 
multiple cycles (such as 1ms, 5ms, 10ms, etc.), and due to the large 
number of sensors, data is reported at all times. The publisher reported 
data through libzmq and went to the write logic of eventfd, frequently 
waking up the receiver. We collected flame graph and observed that a 
significant amount of CPU was consumed in this path: eventfd_write -> 
_raw_spin_unlock_irq.

We did modify a lot of code in user mode on the test vehicle to avoid 
this issue, such as not using wake-up, not using eventfd, the publisher 
writing shared memory directly, the receiver periodically extracting the 
content of shared memory, and so on.

However, since the eventfd mechanism of the kernel provides two 
different attributes, EFD_SEMAPHORE and EFD_NONSEMAPHORE, should we 
utilize both of them instead of default to only using EFD_SEMAPHORE?

By utilizing EFD_NONSEMAPHORE on the write side, it is indeed possible 
to avoid the problem of frequently waking up the read side process.

Since last year, in my spare time, I have released multiple versions of 
patches and received some feedback, such as:

https://lkml.org/lkml/2023/1/29/228
https://lkml.org/lkml/2023/4/16/149
https://lkml.org/lkml/2024/5/19/135


Fortunately, some small optimization patches around EFD_SEMAPHORE have 
already entered the mainline kernel, such as:

eventfd: add a BUILD_BUG_ON() to ensure consistency between 
EFD_SEMAPHORE and the uapi
eventfd: prevent underflow for eventfd semaphores
eventfd: show the EFD_SEMAPHORE flag in fdinfo


Looking forward to the final resolution of this issue, and we welcome 
your further suggestions.

--
Best wishes,
Wen




