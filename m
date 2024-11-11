Return-Path: <linux-fsdevel+bounces-34259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 415CA9C4222
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79CF289548
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00801A0AE9;
	Mon, 11 Nov 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s2No07FL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9811780034
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339902; cv=none; b=KSn5VcobuwEqoZPMHvqq5+MVjzfBvUgDt1xX58/VkD1idAgudy27ExHVew2TOkyYmOM/f9YJkf1/IsxRULwBzv81QQioH7mHHD9NhATJnDB/Pq831apIjccCx0nvWIHx3MtGuqfzJNfwHGGx7QkuuFBnW/eNfKHA7v8B51e7U38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339902; c=relaxed/simple;
	bh=KnLBGBvGvsvrRKFv7EKCsTi7ZddTWTnnyXfZvw9Oesg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jDXgnDIksIalA9/MSJ4wSuH+pZ+C3Pf/nN+WKbYXeqKIG69vqfZLzhJCl/33w546z7QbTq9UFlFbH9Ks1VyclPVEzIK/4iccJDgBKy99xpvkZ71vyjxFDy8Y6tkc1KQ9ccok+g4ChFjhcU6Fi4SXuVAAwMP2H1mwE1XG7mJoJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s2No07FL; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-288d70788d6so1872295fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731339900; x=1731944700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73ssgFdf0K05DppDgVzWtVNKq9nJj5zv7roJuuuIx3g=;
        b=s2No07FLsCTy7k8dlNA6OF0hp9XwoidcKhpr4rpNQanpGxqEA0woHRCxd52ob/aPDS
         8kcEQNxI91t08/cd6sdofiZj56X5eoxgq4EWlPaevvF6viIs/lnQDDgKSLrX0WM5CYGM
         APerFDj1zc1ETLhckS+COGAiNwmxC1D5EnuHj5R8E50FQmepdtUFjkcRFzzZf/p78/Z9
         zI8k6DUbvWmgwcrscATz8jbZee5cvwuZSithIw9iMTByig8Vn3/enknzbAXsd24lpqLh
         +MdlN2jiYOHAlCrMUinBaWKUkmDBSPe3VqXeeisnzP4oAas6rJdHKx3yI441qtLDABkK
         H3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731339900; x=1731944700;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73ssgFdf0K05DppDgVzWtVNKq9nJj5zv7roJuuuIx3g=;
        b=uPeTf3Q4M+sgwfCyoz1X9k7d0GUGIuW9qtPHn1JRWJb2V4zinJwQiBX2XbG+RiXqtc
         UHCQ09HcuoBn5YKnbM/4gcyCdqWSVsnxbVKmMzDXcrC7Jt5WyqyrDEN1fuFYZiy4LkMC
         /B6+senNe74RqMKDR0cErvv86sBh8iVVLL24C2WcgP55ov1TC+XX0vdjSlC7fvML+Da4
         0GI5y3gzs3sJ6fZgCk0Ipl8MOVMibjGqAAz8yG/WJPWydmJSUz5rrCDnUEWvNYzFDiHI
         ZrVo1FJZOzhrsoYCiiW/P4qh4tNiAOsfdk5gr7prCxenz5FBQ6hYXEDU9iNB3+oE0pSG
         WQNA==
X-Forwarded-Encrypted: i=1; AJvYcCXMxSYbeJUi9duPN0+9XT/7AMUmDIkSTtdO5ULMyA/imaOutm4/FSNL9Xn6tK+w9wthXAPiPqDEtiR/U7zx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QEzmurRk+q0eqW5/lA9/RbfXR3A2XjvcVtaHbURN2NhcdM8r
	dcEAHJF7jNAVvMzZq2PsdzT1+R/+n23RRhlGmYUHpzIpId4/le7rTj9awZHZ4HuVNa4k9vmkZez
	pt1Y=
X-Google-Smtp-Source: AGHT+IGct0DwfdQWrfzr/2yAq/9rjCxV1evaxzSEQanMVwW7H3trOqI8hiKigcoXrAwQB+7/3SOOvg==
X-Received: by 2002:a05:6870:a78d:b0:277:c0a9:f00d with SMTP id 586e51a60fabf-295600015c6mr8021748fac.4.1731339899750;
        Mon, 11 Nov 2024 07:44:59 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546d1905csm2819313fac.29.2024.11.11.07.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:44:59 -0800 (PST)
Message-ID: <17b9b5e7-fdcd-4769-b429-a67ebd466c97@kernel.dk>
Date: Mon, 11 Nov 2024 08:44:58 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] fs: add read support for RWF_UNCACHED
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Metzmacher <metze@samba.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-9-axboe@kernel.dk>
 <dbcad551-bf66-406b-a6cd-b8047d1cbace@samba.org>
 <42d612bc-cd3e-46cf-b8d3-50b7c01a9b93@kernel.dk>
Content-Language: en-US
In-Reply-To: <42d612bc-cd3e-46cf-b8d3-50b7c01a9b93@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 7:10 AM, Jens Axboe wrote:
> On 11/11/24 6:04 AM, Stefan Metzmacher wrote:
>> Hi Jens,
>>
>>> If the same test case is run with RWF_UNCACHED set for the buffered read,
>>> the output looks as follows:
>>>
>>> Reading bs 65536, uncached 0
>>>    1s: 153144MB/sec
>>>    2s: 156760MB/sec
>>>    3s: 158110MB/sec
>>>    4s: 158009MB/sec
>>>    5s: 158043MB/sec
>>>    6s: 157638MB/sec
>>>    7s: 157999MB/sec
>>>    8s: 158024MB/sec
>>>    9s: 157764MB/sec
>>>   10s: 157477MB/sec
>>>   11s: 157417MB/sec
>>>   12s: 157455MB/sec
>>>   13s: 157233MB/sec
>>>   14s: 156692MB/sec
>>>
>>> which is just chugging along at ~155GB/sec of read performance. Looking
>>> at top, we see:
>>>
>>>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>>> 7961 root      20   0  267004      0      0 S  3180   0.0   5:37.95 uncached
>>> 8024 axboe     20   0   14292   4096      0 R   1.0   0.0   0:00.13 top
>>>
>>> where just the test app is using CPU, no reclaim is taking place outside
>>> of the main thread. Not only is performance 65% better, it's also using
>>> half the CPU to do it.
>>
>> Do you have numbers of similar code using O_DIRECT just to
>> see the impact of the memcpy from the page cache to the userspace
>> buffer...
> 
> I don't, but I can surely generate those. I didn't consider them that
> interesting for this comparison which is why I didn't do them, O_DIRECT
> reads for bigger blocks sizes (or even smaller block sizes, if using
> io_uring + registered buffers) will definitely have lower overhead than
> uncached and buffered IO. Copying 160GB/sec isn't free :-)
> 
> For writes it's a bit more complicated to do an apples to apples
> comparison, as uncached IO isn't synchronous like O_DIRECT is. It only
> kicks off the IO, doesn't wait for it.

Here's the read side - same test as above, using 64K reads:

  1s: 24947MB/sec
  2s: 24840MB/sec
  3s: 24666MB/sec
  4s: 24549MB/sec
  5s: 24575MB/sec
  6s: 24669MB/sec
  7s: 24611MB/sec
  8s: 24369MB/sec
  9s: 24261MB/sec
 10s: 24125MB/sec

which is in fact pretty depressing. As before, this is 32 threads, each
reading a file from separate XFS mount points, so 32 file systems in
total. If I bump the read size to 128K, then it's about 42GB/sec. 256K
gets you to 71-72GB/sec.

Just goes to show you, you need parallellism to get the best performance
out of the devices with O_DIRECT. If I run io_uring + dio + registered
buffers, I can get ~172GB/sec out of reading the same 32 files from 32
threads.

-- 
Jens Axboe

