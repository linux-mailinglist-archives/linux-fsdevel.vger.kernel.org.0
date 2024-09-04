Return-Path: <linux-fsdevel+bounces-28585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F8496C3D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E461C21DAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3116B1E00A6;
	Wed,  4 Sep 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oMuHfgBx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02047796
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466577; cv=none; b=TvjR+05oC4SNgPYRF9mxf0J/TD/RS/rRFc5q0yzOcrYSRHP+J1Ms2EkIxMoR6d/Xm2GN4rE/UivCobSJoWxxPHrVMU1JQeuxaFLawq0GYsIIN+e4fgRULs/i0XKxbylDH21xLbsEUZTyV1j72GomW5k1GiEyRb1ksHjeI2lVOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466577; c=relaxed/simple;
	bh=Qva6/ze/rZH+z/fDILbLuJ9WAN+dkI0b9YYDqLsRn24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYJbyuBPmbnh7frHLd28rzMoThnr2dAiBGkEbhNv6AhVlvzsEWCOeIoGkoEpjcs1eVufq9c+iowmX91BA2ycyKwK2KhLz0Alq7Ktqxb+6D+GkhyruWVvHRLEMLyj27pJe9fvTffGGzDfdxCy2gETo3FMUE7ZulqvncSYDsX2qVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oMuHfgBx; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82a763b2752so47908639f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725466574; x=1726071374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+J74dpZOe0qglY1Is4ITBdB66vGR2CXWrdnXihJmvI=;
        b=oMuHfgBxvL1/GNgWjoDvhV4gAZh3pyEvl8doycxV+CXQrx2J+nZwN4Rs8Sz9gIoTHL
         L5q37AmJMYhZuOuwVZBPH4K6GCoxvTd9kk8qkLk7cUDi2c8wRIa00qVx+LXKN8b1CBj2
         IaEwJZpycpUsi10/gkn4/hCn6PjmRbEnZaQ8apAgrBZ4AD/blVq1fJCdb3RpKdOsyWYX
         xn9SpyWabJVBAhMKxLeapj5eohR3KWI0anqTBgxrhM21uaeZ7wmPWtiGN7wFucR+ZKCA
         Nwqis26zH+MTAtARZc6b5Cf8g/xUIGZ4jyHjFiK6n+jFeYgWLSJGr58OSEkMHd7lLiow
         RnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466574; x=1726071374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+J74dpZOe0qglY1Is4ITBdB66vGR2CXWrdnXihJmvI=;
        b=QXOc0mff8JtIQdq0NTQe87KVx04zRHcPQ9fvwxmTioI4qTmWx13aoCVT6NcpczmkaX
         VYjtZnbfcf2Rgv/bNDO2YMzFnHB4SdAsTeylpb6k91deRahQoOFX3m6xNzD0auqqYwVc
         Xwq1EptPToV6IjKKg6GZxrwyBUpMrqaA88PoS03vsLrCAN3lNa9p4S3FCJPZiRtWoo4+
         10w1Hjl0aQ2lNl+T8XwwpX6E5WVY3nSFE9fGu63GcrO0M/A9wSidUjjbZCtkv9lVXYVc
         79m+DRfNX9vKWleC+2z76jwdgeXh8Bgs7akRnKMWt7CmFEaBXBgJctxRHanP3GMbTv4+
         Wb3w==
X-Gm-Message-State: AOJu0YxnNJrF+8qhFkIZWpDny6uyArgvKzI4VvUdMuanFA/AuAqw+GgV
	Mv/7Bzho7xMcYVPtADAJDdl6lFv4j2h1ZEM5+CeMpN9IFx3RLx8Tz85T/guZMgU=
X-Google-Smtp-Source: AGHT+IG9U4Ip3j5Y8v0z1wTdtzzvzrRBosYRyc6wTkUlmyRx/GQrxmcgZkW8i4B+CnZHTZW+uwVLsg==
X-Received: by 2002:a05:6602:6c04:b0:81f:b53b:728d with SMTP id ca18e2360f4ac-82a37503513mr1452628939f.6.1725466574195;
        Wed, 04 Sep 2024 09:16:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2ee8559sm3164905173.174.2024.09.04.09.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:16:13 -0700 (PDT)
Message-ID: <cd1e8d26-a0f0-49f2-ac27-428d26713cc1@kernel.dk>
Date: Wed, 4 Sep 2024 10:16:11 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 17/17] fuse: {uring} Pin the user buffer
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Pavel Begunkov <asml.silence@gmail.com>, bernd@fastmail.fm
Cc: linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Amir Goldstein <amir73il@gmail.com>
References: <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-0-9207f7391444@ddn.com>
 <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-17-9207f7391444@ddn.com>
 <9a0e31ff-06ad-4065-8218-84b9206fc8a5@kernel.dk>
 <6c336a8f-4a91-4236-9431-9d0123b38796@fastmail.fm>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6c336a8f-4a91-4236-9431-9d0123b38796@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 10:08 AM, Bernd Schubert wrote:
> Hi Jens,
> 
> thanks for your help.
> 
> On 9/4/24 17:47, Jens Axboe wrote:
>> On 9/1/24 7:37 AM, Bernd Schubert wrote:
>>> This is to allow copying into the buffer from the application
>>> without the need to copy in ring context (and with that,
>>> the need that the ring task is active in kernel space).
>>>
>>> Also absolutely needed for now to avoid this teardown issue
>>
>> I'm fine using these helpers, but they are absolutely not needed to
>> avoid that teardown issue - well they may help because it's already
>> mapped, but it's really the fault of your handler from attempting to map
>> in user pages from when it's teardown/fallback task_work. If invoked and
>> the ring is dying or not in the right task (as per the patch from
>> Pavel), then just cleanup and return -ECANCELED.
> 
> As I had posted on Friday/Saturday, it didn't work. I had added a 
> debug pr_info into Pavels patch, somehow it didn't trigger on PF_EXITING 
> and I didn't further debug it yet as I was working on the pin anyway.
> And since Monday occupied with other work...

Then there's something wrong with that patch, as it definitely should
work. How did you reproduce the teardown crash? I'll take a look here.

That said, it may indeed be the better approach to pin upfront. I just
want to make sure it's not done as a bug fix for something that should
not be happening.

> For this series it is needed to avoid kernel crashes. If we can can fix 
> patch 15 and 16, the better. Although we will still later on need it as
> optimization.

Yeah exactly, didn't see this before typing the above :-)

>>> +/*
>>> + * Copy from memmap.c, should be exported
>>> + */
>>> +static void io_pages_free(struct page ***pages, int npages)
>>> +{
>>> +	struct page **page_array = *pages;
>>> +
>>> +	if (!page_array)
>>> +		return;
>>> +
>>> +	unpin_user_pages(page_array, npages);
>>> +	kvfree(page_array);
>>> +	*pages = NULL;
>>> +}
>>
>> I noticed this and the mapping helper being copied before seeing the
>> comments - just export them from memmap.c and use those rather than
>> copying in the code. Add that as a prep patch.
> 
> No issue to do that either. The hard part is then to get it through
> different branches. I had removed the big optimization of 
> __wake_up_on_current_cpu in this series, because it needs another
> export.

It's not that hard, just split it out in the next patch and I'll be
happy to ack/review it so it can go in with the other patches rather
than needing to go in separately.

-- 
Jens Axboe


