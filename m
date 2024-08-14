Return-Path: <linux-fsdevel+bounces-25937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA84952068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64F81F237E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BDB1BB69B;
	Wed, 14 Aug 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aPvYMOs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077501BA886
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654219; cv=none; b=tSxKtLazJ6EPmbTNfnftC9JUhW+VQXjbOZmQvwbdI2aPkPQNhzcZM3djnd+noVefesSl/OfCTx4MK9NzLD9SxXEw8x4Ww68ZO6pgduZg4FipqbtqBXiOwpq5/f8uXhbIF2fH3B1ITqSdXe3BZpI4ev+aZHKnqgr03H+x0LtG7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654219; c=relaxed/simple;
	bh=Vrwema0xFcBld6oC//DSwypTI0kbcyFn23o/KAGzSp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jy5tEHhYVLz+Cu0mJz9J3pynAeE4kJ2g0c6kitrwHa1D37G/VhE2BtkfXYlxfwXDW1js9KI4GLswIsmJBqh1SkbNHgVFQ0iBrXwf+lavt8tdT4qFYJdBLsEKChejlTSlB43XXosWZj8NWUw635s6BE6JCpwJFuHxR1fS81Xq6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aPvYMOs9; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39d19d0c6b6so35485ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723654216; x=1724259016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0YFDtBYwOmSYuxWwjwpQ3dIXITALL9SoN+FyAgYHQsE=;
        b=aPvYMOs9OLhljPsp3zyjUWq96b2NCxZcDZbQbVtBHLlp0wxwSYP6cfX8bQniYpY4zw
         FAoPQnFjUjWVKvHlA/4C/4e5ariAqFXUzcnM6qKsU3px3x43QPHaM77IWsfDPbKJFmK8
         HBsgZBoKzE59AUPqwXGdrHRxnADjzYNQpTh2eyxpz2lWd7WF046tZtDTkeeIWTsp6blu
         D9CUuuhZYR1JBTDhdtJl2eUEzBUwZkEGWufYL/7XqqLf3Zq6GoQd4JUI45M9kjIVxrbw
         E97suaobvHFeGgQwBTYXj/oGdYftMaq+U8SRTjZZWfpD/zY1yVSDPdjtBCks2beY3Zg5
         gNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654216; x=1724259016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YFDtBYwOmSYuxWwjwpQ3dIXITALL9SoN+FyAgYHQsE=;
        b=kY/tJ6kD4Sgb74cH2mZs8h/inJ8fjEruHVexMv47Jruq+3RO1H7A9gffnTDpDVZSJM
         d8azqEmy5OAlIAjFK+a043w6xUiltiU/vBwii+fV9GXlKH5oY1sYgKgSVQCp65dc1ixg
         0u/5f4X6Rm43hn+xx6V+ugHrsbZYOcI8cXqI9asDIqx3DLhO2F/f27gTIggU1rEQ0t3+
         nBb7C7uWZcim+E5lS4eTG98DrgOvGwoSwTAaHy576dCh8mSAVe63RLYRZwzI700Xsysc
         iEYyuK1G5NxFQrD+CBQne+o8T/2CrlBb9Kj1paDp5K5ncTVTpI/xpEdRWqJXZhBPDaNd
         EjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3tB8Ocb+53Uo7ysWqsDID37i4wldvoJp2IgdLaNZ7e3HqHpM/NQlpaF0cvX9ISBEz/6E5JTnePD0wfQKZ4/0PkfOymW9Z9MHrO7n28g==
X-Gm-Message-State: AOJu0Yy/rkRAclZ/Hec/MY/sGu4cgP5+8vvt8w5/URaa3SIM6HgCXYG7
	Dk51N6ObafK+FV1zrSTfsQ0oP3g2WxwBjsiCfy7FViC0mweiLLyTnOnRq0a6idY=
X-Google-Smtp-Source: AGHT+IFJ/MLg8CBevS/Vk7hL5sTp4+rQDH8qrLOVI0a4WaLDx+K/uAOK0wPjZlGyjPqdw3Opm832NQ==
X-Received: by 2002:a05:6e02:b23:b0:39a:f26b:3557 with SMTP id e9e14a558f8ab-39d124fe82amr25575385ab.5.1723654216018;
        Wed, 14 Aug 2024 09:50:16 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca769418e7sm3353505173.66.2024.08.14.09.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 09:50:15 -0700 (PDT)
Message-ID: <096fafc8-f3fa-42d2-a374-101d4facbe86@kernel.dk>
Date: Wed, 14 Aug 2024 10:50:14 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] eventfd: introduce ratelimited wakeup for
 non-semaphore eventfd
To: Wen Yang <wen.yang@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Dylan Yudaken <dylany@fb.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Paolo Bonzini <pbonzini@redhat.com>,
 Dave Young <dyoung@redhat.com>, kernel test robot <lkp@intel.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240811085954.17162-1-wen.yang@linux.dev>
 <w7ldxi4jcdizkefv7musjwxblwu66pg3rfteprfymqoxaev6by@ikvzlsncihbr>
 <f21b635e-3bd7-48c3-b257-dde1b9f49c6c@linux.dev>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f21b635e-3bd7-48c3-b257-dde1b9f49c6c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/24 10:15 AM, Wen Yang wrote:
> 
> 
> On 2024/8/11 18:26, Mateusz Guzik wrote:
>> On Sun, Aug 11, 2024 at 04:59:54PM +0800, Wen Yang wrote:
>>> For the NON-SEMAPHORE eventfd, a write (2) call adds the 8-byte integer
>>> value provided in its buffer to the counter, while a read (2) returns the
>>> 8-byte value containing the value and resetting the counter value to 0.
>>> Therefore, the accumulated value of multiple writes can be retrieved by a
>>> single read.
>>>
>>> However, the current situation is to immediately wake up the read thread
>>> after writing the NON-SEMAPHORE eventfd, which increases unnecessary CPU
>>> overhead. By introducing a configurable rate limiting mechanism in
>>> eventfd_write, these unnecessary wake-up operations are reduced.
>>>
>>>
>> [snip]
>>
>>>     # ./a.out  -p 2 -s 3
>>>     The original cpu usage is as follows:
>>> 09:53:38 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>> 09:53:40 PM    2   47.26    0.00   52.74    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>> 09:53:40 PM    3   44.72    0.00   55.28    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>
>>> 09:53:40 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>> 09:53:42 PM    2   45.73    0.00   54.27    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>> 09:53:42 PM    3   46.00    0.00   54.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>
>>> 09:53:42 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>> 09:53:44 PM    2   48.00    0.00   52.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>> 09:53:44 PM    3   45.50    0.00   54.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>
>>> Then enable the ratelimited wakeup, eg:
>>>     # ./a.out  -p 2 -s 3  -r1000 -c2
>>>
>>> Observing a decrease of over 20% in CPU utilization (CPU # 3, 54% ->30%), as shown below:
>>> 10:02:32 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>> 10:02:34 PM    2   53.00    0.00   47.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>> 10:02:34 PM    3   30.81    0.00   30.81    0.00    0.00    0.00    0.00    0.00    0.00   38.38
>>>
>>> 10:02:34 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>> 10:02:36 PM    2   48.50    0.00   51.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>> 10:02:36 PM    3   30.20    0.00   30.69    0.00    0.00    0.00    0.00    0.00    0.00   39.11
>>>
>>> 10:02:36 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>> 10:02:38 PM    2   45.00    0.00   55.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>> 10:02:38 PM    3   27.08    0.00   30.21    0.00    0.00    0.00    0.00    0.00    0.00   42.71
>>>
>>>
>>
>> Where are these stats from? Is this from your actual program you coded
>> the feature for?
>>
>> The program you inlined here does next to nothing in userspace and
>> unsurprisingly the entire thing is dominated by kernel time, regardless
>> of what event rate can be achieved.
>>
>> For example I got: /a.out -p 2 -s 3  5.34s user 60.85s system 99% cpu 66.19s (1:06.19) total
>>
>> Even so, looking at perf top shows me that a significant chunk is
>> contention stemming from calls to poll -- perhaps the overhead will
>> sufficiently go down if you epoll instead?
> 
> We have two threads here, one publishing and one subscribing, running
> on CPUs 2 and 3 respectively. If we further refine and collect
> performance data on CPU 2, we will find that a large amount of CPU is
> consumed on the spin lock of the wake-up logic of event write, for
> example:

This is hardly surprising - you've got probably the worst kind of
producer/consumer setup here, with the producer on one CPU, and the
consumer on another. You force this relationship by pinning both of
them. Then you have a queue in between, and locking that needs to be
acquired on both sides.

It's hard to come up with a WORSE way of doing that.

I'll have to agree with the notion that you're using the wrong tool for
the job, and hacking around it is not the right solution.

-- 
Jens Axboe


