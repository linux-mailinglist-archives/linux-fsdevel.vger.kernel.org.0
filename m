Return-Path: <linux-fsdevel+bounces-41207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEED6A2C53D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00A77A5D31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410323ED6B;
	Fri,  7 Feb 2025 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e2YY9F2A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DD023ED56
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938549; cv=none; b=rfyVr+FduOFs5IwFT81yujkMzwqdZbI7FTHeW6Vjk1Y3VQrtTk/aK/NrLnIbE0Ix+L/JQPrkshlm7gAAb+SMcwCdyUh5TdmKKxqsZskkbz9dyQilQJi2Txs05inenfGbOSY7IQmvv0TF2ZLD6QPTJK/ppGMDrq6uA1f566HSDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938549; c=relaxed/simple;
	bh=O93/SIp+NuGO2A6vL2yDSudFXUg0LMqzw/Tfy72BYZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJwwjUghjfZzLQV5xMHkEyPs89rUYGxoFimNTGbTMqJkzoDN7D2RIXAYqB6A0WL3rXBHE6wCQYVsL/pjsUoaYkxN3GVBx4DphX8tnb6t2r5VE81lWufXpIZ24KCxL4hfDgr2qkuxLBWwlNQgE1sVltudw/pDmg8YTNjOcYfORpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e2YY9F2A; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ce85545983so6241945ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 06:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738938547; x=1739543347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3gig7x9bnhHvNh4AiVNKuX5nWLrgutC+4TudriJZto=;
        b=e2YY9F2AKralTbI/wrbLfLQT9ZCqhWPF53wFUJLAyX+0rznkF8GIRRYlunoCLETVft
         WK4Pizm3Ey9BU4g71R+34Tu0LxzDajPCwLVt7HRSoShAbAJagv3UrugLfFUHn66dl2D/
         wKpyS5K4u6/w4PQL1p0AxS+EBeyyHCww6PyMqjN00c4lui0SePnXRowtP6nUjTnYv10N
         HrUA7d7utjMJXY+/PKVO2cRIT0ugKjn36GVo1aIOTOorHi/Yk7I1nvG0/iUvskfkaDLz
         YauYh0uGyZ/ijz0+scVJ2XI/83AL3clvo0k4USKJxfJWq1ptpS7lLbU4pfx9RkvAbmBV
         qFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738938547; x=1739543347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3gig7x9bnhHvNh4AiVNKuX5nWLrgutC+4TudriJZto=;
        b=O5UMWcW6ByfBexujemCfRkHHOOPPPKLL7/I8mpI2GH2MJxBrKi0PXgoczLT3C02Z1o
         8pK3cvv75PE51yru0b29/V4ipGSn4X8pVkn1pfm4Bm00UjI/1Nvpymt+WeMM0nNyLjry
         PewgMi8sLJZzpxy5pHNm7eBEIwIg27ffGO/44lFcQ0OixEXx5W8Gpl4r9lo8rOb8Ov30
         W57npfnR5WrvfohOCHR+V8l1AqeCVNW8GFf43+ndT6kSb7k1k14b3bvY545D6vWWdTXp
         zk6KbirPTX9saliI/sCBdOIGQyrcyRWcAy4IH5oHm6MTSSEOavM7afZ7fNDzDEgYwBsN
         attw==
X-Gm-Message-State: AOJu0Yx8KtEuk5ZfsdSoQJjCD/X4AXUc/tavRGFOCdPLVN/6K+3IFIMm
	o4/GHBtWXHM8IdqXQoVDZTczuQLlaG1dSPzXN2QiYJq2/lVxmQXe1ksY970xc+4=
X-Gm-Gg: ASbGncvb8TJe7k5Q9XJs11wxgwamjj3l9+kWgefOiQ2E68Y7z7Am289AOr9SNwjfFuw
	VRwWIWqoKJ8TDCy+d+qXZ4ya5p+2dQEUpNC63TKJltJXmm8ICv+77gvRFX0GBRFvixafXI6x7+D
	XCq+zDLIc9cgWlwvB2GAHS2feIFwe/cWzDdqiv4RXBCp30jJ5VTbmKiav3eZiZaNppo8d2IVRb3
	mzptxNB/IyQySi8qCxVd0W9PaNkJd1Xxh0ZF6ZEZ3AbQ6ZZmFQqgMDXcYrnEIx+syZNGCIv4XFe
	WTLkqoeWwgs=
X-Google-Smtp-Source: AGHT+IEwAJI3S0hfPThQqiAP8t1KRYC2JEvRae9KQP/9FEC5QGuz1qpTzFxtAeFnkmtqRmEGyAO6cA==
X-Received: by 2002:a05:6e02:18cd:b0:3d0:59e5:3c7b with SMTP id e9e14a558f8ab-3d05a6b2986mr68989095ab.8.1738938546976;
        Fri, 07 Feb 2025 06:29:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccfad0446sm764441173.95.2025.02.07.06.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 06:29:06 -0800 (PST)
Message-ID: <80a71fb3-7c87-42d0-9de7-afd35f92be51@kernel.dk>
Date: Fri, 7 Feb 2025 07:29:05 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] eventpoll: add ep_poll_queue() loop
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <20250204194814.393112-1-axboe@kernel.dk>
 <20250204194814.393112-6-axboe@kernel.dk>
 <618af8fc-6a35-4d6e-9ac7-5e6c33514b44@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <618af8fc-6a35-4d6e-9ac7-5e6c33514b44@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/25 5:28 AM, Pavel Begunkov wrote:
> On 2/4/25 19:46, Jens Axboe wrote:
>> If a wait_queue_entry is passed in to epoll_wait(), then utilize this
>> new helper for reaping events and/or adding to the epoll waitqueue
>> rather than calling the potentially sleeping ep_poll(). It works like
>> ep_poll(), except it doesn't block - it either returns the events that
>> are already available, or it adds the specified entry to the struct
>> eventpoll waitqueue to get a callback when events are triggered. It
>> returns -EIOCBQUEUED for that case.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   fs/eventpoll.c | 37 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> index ecaa5591f4be..a8be0c7110e4 100644
>> --- a/fs/eventpoll.c
>> +++ b/fs/eventpoll.c
>> @@ -2032,6 +2032,39 @@ static int ep_try_send_events(struct eventpoll *ep,
>>       return res;
>>   }
>>   +static int ep_poll_queue(struct eventpoll *ep,
>> +             struct epoll_event __user *events, int maxevents,
>> +             struct wait_queue_entry *wait)
>> +{
>> +    int res, eavail;
>> +
>> +    /* See ep_poll() for commentary */
>> +    eavail = ep_events_available(ep);
>> +    while (1) {
>> +        if (eavail) {
>> +            res = ep_try_send_events(ep, events, maxevents);
>> +            if (res)
>> +                return res;
>> +        }
>> +
>> +        eavail = ep_busy_loop(ep, true);
> 
> I have doubts we want to busy loop here even if it's just one iteration /
> nonblockinf. And there is already napi polling support in io_uring done
> from the right for io_uring users spot.

Yeah I did ponder that which is why it's passing in the timed_out == true
to just do a single loop. We could certainly get rid of that.

-- 
Jens Axboe


