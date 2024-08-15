Return-Path: <linux-fsdevel+bounces-26068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22816953648
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64BE284C72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCDA1A08DD;
	Thu, 15 Aug 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OVF0g6vc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A322C1A00CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733634; cv=none; b=sRcI+IE+6l+LPWpWtZ2w3K4Pw6pLuAfOj9JBq85NUvuSG9O5ZsckHJagF42ew82HL08QUezwS7QZVvcQMd0LfZLUgcJWEBeZggI3SIgo+UIDEC1A+45Rgr1H9CuVYXa6wvkRsjXJdA105O9KbT9RlPMe3G9e/UNLJ5x5dnAzryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733634; c=relaxed/simple;
	bh=qQvDl/fJ+RiCLCjUUrxw1SWiTp9F0TJ4HgA2+x86/z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gm+mycSERkguouVbL5jaqo6Exx39jqZURePiJXAUpdxICywGR9jGriqNUdujpNsFUj3t2Ih78H9Qm1zaxNZlGhn3uMR8gDoBra8e9mJjHmpBlAP64j6r5rP15NRa4RZ5uI0PA2DO5LQBPcjx/DS2w8R1kUI0TazJ34SqFLsMjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OVF0g6vc; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e53da45-0892-42dc-b837-4b25640762d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723733629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DraNZK5Ky/kwB6d6eSDBIZZ1zkb63f/vRfsT6Gn8yZ8=;
	b=OVF0g6vcrjeJ3hmsSBaX5VY1roqQBJXK5+jjMPUpxxGtbm+dWx3l2nn15yYUE2ysGEtQI3
	p7wcruJLKIa07K0ohc1HWbI4sSjj17wN2S4n8GpENZ0fY7bpir/XkmYSapPGL0i4Hu781w
	OdOkX00dJvC6YGfqrHatGnTdrvvkXV4=
Date: Thu, 15 Aug 2024 22:53:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2] eventfd: introduce ratelimited wakeup for
 non-semaphore eventfd
To: Jens Axboe <axboe@kernel.dk>, Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Dylan Yudaken <dylany@fb.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Paolo Bonzini <pbonzini@redhat.com>,
 Dave Young <dyoung@redhat.com>, kernel test robot <lkp@intel.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240811085954.17162-1-wen.yang@linux.dev>
 <w7ldxi4jcdizkefv7musjwxblwu66pg3rfteprfymqoxaev6by@ikvzlsncihbr>
 <f21b635e-3bd7-48c3-b257-dde1b9f49c6c@linux.dev>
 <096fafc8-f3fa-42d2-a374-101d4facbe86@kernel.dk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <096fafc8-f3fa-42d2-a374-101d4facbe86@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/8/15 00:50, Jens Axboe wrote:
> On 8/14/24 10:15 AM, Wen Yang wrote:
>>
>>
>> On 2024/8/11 18:26, Mateusz Guzik wrote:
>>> On Sun, Aug 11, 2024 at 04:59:54PM +0800, Wen Yang wrote:
>>>> For the NON-SEMAPHORE eventfd, a write (2) call adds the 8-byte integer
>>>> value provided in its buffer to the counter, while a read (2) returns the
>>>> 8-byte value containing the value and resetting the counter value to 0.
>>>> Therefore, the accumulated value of multiple writes can be retrieved by a
>>>> single read.
>>>>
>>>> However, the current situation is to immediately wake up the read thread
>>>> after writing the NON-SEMAPHORE eventfd, which increases unnecessary CPU
>>>> overhead. By introducing a configurable rate limiting mechanism in
>>>> eventfd_write, these unnecessary wake-up operations are reduced.
>>>>
>>>>
>>> [snip]
>>>
>>>>      # ./a.out  -p 2 -s 3
>>>>      The original cpu usage is as follows:
>>>> 09:53:38 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 09:53:40 PM    2   47.26    0.00   52.74    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 09:53:40 PM    3   44.72    0.00   55.28    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>>
>>>> 09:53:40 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 09:53:42 PM    2   45.73    0.00   54.27    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 09:53:42 PM    3   46.00    0.00   54.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>>
>>>> 09:53:42 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 09:53:44 PM    2   48.00    0.00   52.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 09:53:44 PM    3   45.50    0.00   54.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>>
>>>> Then enable the ratelimited wakeup, eg:
>>>>      # ./a.out  -p 2 -s 3  -r1000 -c2
>>>>
>>>> Observing a decrease of over 20% in CPU utilization (CPU # 3, 54% ->30%), as shown below:
>>>> 10:02:32 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 10:02:34 PM    2   53.00    0.00   47.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 10:02:34 PM    3   30.81    0.00   30.81    0.00    0.00    0.00    0.00    0.00    0.00   38.38
>>>>
>>>> 10:02:34 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 10:02:36 PM    2   48.50    0.00   51.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 10:02:36 PM    3   30.20    0.00   30.69    0.00    0.00    0.00    0.00    0.00    0.00   39.11
>>>>
>>>> 10:02:36 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 10:02:38 PM    2   45.00    0.00   55.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 10:02:38 PM    3   27.08    0.00   30.21    0.00    0.00    0.00    0.00    0.00    0.00   42.71
>>>>
>>>>
>>>
>>> Where are these stats from? Is this from your actual program you coded
>>> the feature for?
>>>
>>> The program you inlined here does next to nothing in userspace and
>>> unsurprisingly the entire thing is dominated by kernel time, regardless
>>> of what event rate can be achieved.
>>>
>>> For example I got: /a.out -p 2 -s 3  5.34s user 60.85s system 99% cpu 66.19s (1:06.19) total
>>>
>>> Even so, looking at perf top shows me that a significant chunk is
>>> contention stemming from calls to poll -- perhaps the overhead will
>>> sufficiently go down if you epoll instead?
>>
>> We have two threads here, one publishing and one subscribing, running
>> on CPUs 2 and 3 respectively. If we further refine and collect
>> performance data on CPU 2, we will find that a large amount of CPU is
>> consumed on the spin lock of the wake-up logic of event write, for
>> example:
> 
> This is hardly surprising - you've got probably the worst kind of
> producer/consumer setup here, with the producer on one CPU, and the
> consumer on another. You force this relationship by pinning both of
> them. Then you have a queue in between, and locking that needs to be
> acquired on both sides.
> 

Thank you for pointing it out.
We bind the CPU here to highlight this issue.
In fact, setting cpumask to -1 still remains the same:

  ./a.out  -p -1 -s -1

      9.27%  [kernel]       [k] _raw_spin_lock_irq
      6.23%  [kernel]       [k] vfs_write

And another test program using libzmq also did not bind the CPU:
https://github.com/taskset/tests/blob/master/src/test.c

We can indeed solve this problem in user mode by using methods such as 
shared memory, periodic data reading, atomic variables, etc. instead of 
eventfd.

But since eventfd has already provided *NON-SEMAPHORE* , could you also 
guide us to further utilize it and make it more comprehensive?

Especially linux is increasingly being used in automotive scenarios.

--
Best wishes,
Wen


