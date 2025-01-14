Return-Path: <linux-fsdevel+bounces-39101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38554A0FDB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 01:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8AD3A6553
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 00:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F7035964;
	Tue, 14 Jan 2025 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="guencE8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00522EE4
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736816205; cv=none; b=KaysyDshVXmcfDZQCe9m45ZRiEpfkajY/nydlVVrBTjV6KI+E0hkUW3KJvvD8n1qnfdWbwQfeLyMOlAomO13EkSwknEd4kelqV8wV9vzlW1+QNcnVVZxKUUgKt9d6nhYRpVUz6u9FXhiWQPnJ1sujhrrH774hv2tobUGigpHZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736816205; c=relaxed/simple;
	bh=mbMMMGj0HPNrPrzg0IrxMPfEvtvd+MynAML6oWELGrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5gEx93r/g5tVWECcWcqwL3mS+v7Z7zxScbk15Qonh92DFj4k6z5bhBqWN7AzGairtq76RP72NosYtfuFCyVx09SrVxidyA71ZaS7XSdh33ggOfLKdWd7anucyKyUAvx0dBFUdyS3qbmP/PH09IMWwDmLKGdjYFaTij+i2I4TBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=guencE8q; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9cee9d741so35450585ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 16:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736816202; x=1737421002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFRwrXz42i3Ex6VxVXT/+/UsrVhslXKijtqwvVA4fO8=;
        b=guencE8qnDxjKxHR0Uaree1nZJzSg1QHSMUIXFmemJj8Nu/a0KcvoYJxZJY2C/1vAX
         syHufFbT+kwwfMrPY/Y+ZvPN7x7S2PDBwJiultr6xKHFOXWyk9CSgSuf6ejcvBtHW3pZ
         6oLFPO6hUB/uRhz/cuHSfnZFOvyB77GT3vl+oxbDegdd6b0YfVm3AD6kWAEqBlDLdFi8
         fQ6IH3I3EWdD23FE9/Xbvzmc2upDZoST073oybA/lNZbkPMgq0SBPkT5ecAHnXvrp7L1
         jx8OIfBDeEYEMVsMY07oWXgTnQCzOfPuGKS1VVn4yPxN48wieVhIfax0ZByORWsphO43
         WKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736816202; x=1737421002;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFRwrXz42i3Ex6VxVXT/+/UsrVhslXKijtqwvVA4fO8=;
        b=qQkACbSen0JDLStipoTgOjnRTSX+mHJ2X+p/ovaMeQy66fOQH5KqnJTTfetMUm6911
         XLYGWNsFotHnVHu+rtpGY3HJRIL4FmtfgaBwZKR1SXXjZyCICwme3z+ZeWYTMN1yuiDc
         qVKeHgq9lSJ1fq8ctucExEw0AniX5lW3D/WJINKYbUlrq9XuTxlb2Xc+2V/iRbCn83bT
         tu3QaP2Lcq7rMw43HLAdUefwdaGMclSOm1btoF6ssG7Ye1/NLq5kBXSAZb0iv4uuMM2M
         jKILpaUhq9/ofT/F1l74xA7DgxElqiBT6kXOPqedFres1D16qBN6iiGyRahVNtaPEhRi
         5How==
X-Forwarded-Encrypted: i=1; AJvYcCXLY/kO1etkg4CN62LrzUam+a6upvLSIGJjx+X2It+6kZ1HMOa/DnA2W8vT4rxPCU3i1dGkp9BpXocaHthJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzwRv0Mnbk4o9dXve1lBJiTPyJDtYUKhyF7y4LNVfFsGfVA5Pfe
	reowDkZDxlqgIQLIlqPm8EkScXSxPDdGAc4jt4NkHbu1Pa36D/ZasIdJUbqQLWQ=
X-Gm-Gg: ASbGnctp9trDKb89Sd3ubYMBEiKYg1/lKlENptYgyymaML967hWnDarXGYqsEtkEtK2
	IG5dD01kJNJdvZ9PLfWLgJVwCxOdfkEAUWTjISJRS8M3xPBMzkbe7gIJvFCJ48SX2bAZIr+Iw1I
	2CPEtWPtmQ52MIUGiDRf19pntN38ZTKNRrPhGwOpeJbPGCTwdvbSV8hg6RWbTsImyU6YXIHDEJf
	bEIv0jBUGQvXGoedPpm0N7TyD+Wcg+45F0ZFCmQM8ZKRUl5204lCg==
X-Google-Smtp-Source: AGHT+IHfVig9z9X28a8RJmX8cXjlHvlOE8g17fwAl0H867Dl3tHMXc6GXh5dVP+DOBfwAE8WmycnJw==
X-Received: by 2002:a05:6e02:194c:b0:3a7:7ec0:a3dc with SMTP id e9e14a558f8ab-3ce3a88a2femr191007565ab.14.1736816202027;
        Mon, 13 Jan 2025 16:56:42 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b718bafsm3134733173.96.2025.01.13.16.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 16:56:41 -0800 (PST)
Message-ID: <010513c8-7c17-454f-b6e0-d03fe7795eb2@kernel.dk>
Date: Mon, 13 Jan 2025 17:56:40 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v8 0/12] Uncached buffered IO
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20250107193532.f8518eb71a469b023b6a9220@linux-foundation.org>
 <3cba2c9e-4136-4199-84a6-ddd6ad302875@kernel.dk>
 <20250113164650.5dfbc4f77c4b294bb004804c@linux-foundation.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250113164650.5dfbc4f77c4b294bb004804c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 5:46 PM, Andrew Morton wrote:
> On Mon, 13 Jan 2025 08:34:18 -0700 Jens Axboe <axboe@kernel.dk> wrote:
> 
>>>
>>
>> ...
>>
>>> Of course, we're doing something here which userspace could itself do:
>>> drop the pagecache after reading it (with appropriate chunk sizing) and
>>> for writes, sync the written area then invalidate it.  Possible
>>> added benefits from using separate threads for this.
>>>
>>> I suggest that diligence requires that we at least justify an in-kernel
>>> approach at this time, please.
>>
>> Conceptually yes. But you'd end up doing extra work to do it. Some of
>> that not so expensive, like system calls, and others more so, like LRU
>> manipulation. Outside of that, I do think it makes sense to expose as a
>> generic thing, rather than require applications needing to kick
>> writeback manually, reclaim manually, etc.
>>
>>> And there's a possible middle-ground implementation where the kernel
>>> itself kicks off threads to do the drop-behind just before the read or
>>> write syscall returns, which will probably be simpler.  Can we please
>>> describe why this also isn't acceptable?
>>
>> That's more of an implementation detail. I didn't test anything like
>> that, though we surely could. If it's better, there's no reason why it
>> can't just be changed to do that. My gut tells me you want the task/CPU
>> that just did the page cache additions to do the pruning to, that should
>> be more efficient than having a kworker or similar do it.
> 
> Well, gut might be wrong ;)

A gut this big is rarely wrong ;-)

> There may be benefit in using different CPUs to perform the dropbehind,
> rather than making the read() caller do this synchronously.
> 
> If I understand correctly, the write() dropbehind is performed at
> interrupt (write completion) time so that's already async.

It does, but we could actually get rid of that, at least when called via
io_uring. From the testing I've done, doing it inline it definitely
superior. Though it will depend on if you care about overall efficiency
or just sheer speed/overhead of the read/write itself.

-- 
Jens Axboe

