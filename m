Return-Path: <linux-fsdevel+bounces-28089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996F5966A36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 22:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5342528410D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 20:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBE45016;
	Fri, 30 Aug 2024 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cqxanou1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364FEEC3
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725048526; cv=none; b=B5p/OG+gvcZ03dur4b4LBrGPiB5nOsBUSTrOZO7wQ6v5awxmcqbLQd01L34/G/siFzaz1K+Vv+HTW36i1Qm+t6ov+wjLdV3yWZOl4HjI21Bz5IrJIlU08Hja/kkQJmX3BODWZf6FJnf2xwh0pEMbSzRy5ry6j4S+s8ovAsKQa2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725048526; c=relaxed/simple;
	bh=i1zaQ22MSwMhD/GKla5q5Yi3GYvqp1n2mj93v8+pmmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3nR+y8qhGd44EvYZkNxhqhNevBidJ8SR/veES0yE7QLaMUAdKMViq3PsIXMw37yiNaNOuJu0n5Wh2AaskjV4y8ZOcLJiqxJhfuDAhZBfT6CAQ8tYPYi1kYRZHxtD+u8BSYEuQ9mvOydGlNNWpmP6Tr46Y9KVg6bzfpuS7UjPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cqxanou1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202376301e6so18599785ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725048523; x=1725653323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=489AVUSbdHyFDGygGjqjZnaA66BPov4NGSmWA8d7QYw=;
        b=cqxanou1Ve8XgUEm13NysG/y7k3PoEq5LuA+zmYrEacwRqEYor8GIkIe/I6+osRpB8
         xEa11TAbitT54XxfSRtrjJ88+d4TNudyyMA3kDPAarym4XQ1l96iZ8A5SC+s9lHll6DG
         8ygtwQp9KylIjBZnzZ9ohJOH4vT9vyxRJSAK4OAcoXb0sSlZdH7eojFtswZtQoqMuGzg
         u/VjmhIjWpjrVdguct2fwPAV9FKu61se2Hn/nF9NLvdgdccEW3Kxd0FfQ9rPet15kFkL
         FvGOQpAqTG2fnq1GqPYhEGP3bJ4W//iZ5innpg3m+/6qcZH4MkhGz3KogbHp+urawrJP
         YOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725048523; x=1725653323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=489AVUSbdHyFDGygGjqjZnaA66BPov4NGSmWA8d7QYw=;
        b=U/4FEzJ7UdrOQM1kZFQ2LQkSBCucFfUkVHbSQCht/qL/kX7PpvPFe2RMB4X8+DI51g
         7LUhNLTO//ESgAtq+5xgxEWxvI9lyy2ycrXyHzxQfj/xVVFmr9LH9+xRM+zgiUTrTlWl
         5rar9LMAs0Q+kZz7tMiF8tNyn2Hi+y6V0nVnyNM3odWVpuJwH4x+6NEMMfAFXLkLR28Y
         F8Z2ItdnTZRMDMiWMw39Nn5jqeggk+PVYWNUtJAd9KSzJF1iheFJRgJDoEwfq6m5zPv4
         B4ZKWjnt7EF5/HZdVdFekgyUFGlBzfcSnBtzo3I8qfsYP8yeqI9YOOZ7Er8eckj8nFRf
         QGQw==
X-Forwarded-Encrypted: i=1; AJvYcCUNpqKLt8xK4JIQ583cl2RJkdHfsLpOAUqG3yeJ9Ndb7vgvx+v1dkLaj05cuRCT0KqEtsfRS8eLRGZKkGF+@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7NyyluDl3BfrhFaovn9Q+KxBc69f40XAUuXUlHENwCAbuVSX
	Pxv9N7MJZWyaS/ZqVbGHnKyOABigB9+SoMVNa4GBRFKtziIWBZru9TB8vTvJCQQ=
X-Google-Smtp-Source: AGHT+IHJjQMCC2UwciVCHC+MfoHBORAQh2zVHGt7VEcTwTFf0JZJrXf3E7HIBTHExTAe2ugs6e5XuQ==
X-Received: by 2002:a17:903:32c1:b0:203:a12e:f8ca with SMTP id d9443c01a7336-2050c238252mr85586935ad.20.1725048522760;
        Fri, 30 Aug 2024 13:08:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205439a280csm2534765ad.13.2024.08.30.13.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 13:08:41 -0700 (PDT)
Message-ID: <da99afb7-ff6f-4fa4-bfdc-994e34125c33@kernel.dk>
Date: Fri, 30 Aug 2024 14:08:40 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/19] fuse: fuse-over-io-uring
To: Pavel Begunkov <asml.silence@gmail.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Josef Bacik <josef@toxicpanda.com>, Joanne Koong <joannelkoong@gmail.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <CAJfpegurSNV3Tw1oKWL1DgnR-tST-JxSAxvTuK2jirm+L-odeQ@mail.gmail.com>
 <99d13ae4-8250-4308-b86d-14abd1de2867@fastmail.fm>
 <CAJfpegu7VwDEBsUG_ERLsN58msXUC14jcxRT_FqL53xm8FKcdg@mail.gmail.com>
 <62ecc4cf-97c8-43e6-84a1-72feddf07d29@fastmail.fm>
 <CAJfpegsq06UZSPCDB=0Q3OPoH+c3is4A_d2oFven3Ebou8XPOw@mail.gmail.com>
 <0615e79d-9397-48eb-b89e-f0be1d814baf@ddn.com>
 <CAJfpeguMmTXJPzdnxe87hSBPO_Y8s33eCc_H5fEaznZYC-D8HA@mail.gmail.com>
 <3b74f850-c74c-49d0-be63-a806119cbfbd@ddn.com>
 <7d42edd3-3e3b-452b-b3bf-fb8179858e48@fastmail.fm>
 <093a3498-5558-4c65-84b0-2a046c1db72e@kernel.dk>
 <f5d10363-9ba0-4a1a-8aed-cad7adf59cd4@ddn.com>
 <3ca0e7d1-bb86-4963-aab7-6fc24950fe84@kernel.dk>
 <d2528a1c-3d7c-4124-953c-02e8e415529e@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d2528a1c-3d7c-4124-953c-02e8e415529e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/24 8:55 AM, Pavel Begunkov wrote:
> On 8/30/24 14:33, Jens Axboe wrote:
>> On 8/30/24 7:28 AM, Bernd Schubert wrote:
>>> On 8/30/24 15:12, Jens Axboe wrote:
>>>> On 8/29/24 4:32 PM, Bernd Schubert wrote:
>>>>> We probably need to call iov_iter_get_pages2() immediately
>>>>> on submitting the buffer from fuse server and not only when needed.
>>>>> I had planned to do that as optimization later on, I think
>>>>> it is also needed to avoid io_uring_cmd_complete_in_task().
>>>>
>>>> I think you do, but it's not really what's wrong here - fallback work is
>>>> being invoked as the ring is being torn down, either directly or because
>>>> the task is exiting. Your task_work should check if this is the case,
>>>> and just do -ECANCELED for this case rather than attempt to execute the
>>>> work. Most task_work doesn't do much outside of post a completion, but
>>>> yours seems complex in that attempts to map pages as well, for example.
>>>> In any case, regardless of whether you move the gup to the actual issue
>>>> side of things (which I think you should), then you'd want something
>>>> ala:
>>>>
>>>> if (req->task != current)
>>>>     don't issue, -ECANCELED
>>>>
>>>> in your task_work.nvme_uring_task_cb
>>>
>>> Thanks a lot for your help Jens! I'm a bit confused, doesn't this belong
>>> into __io_uring_cmd_do_in_task then? Because my task_work_cb function
>>> (passed to io_uring_cmd_complete_in_task) doesn't even have the request.
>>
>> Yeah it probably does, the uring_cmd case is a bit special is that it's
>> a set of helpers around task_work that can be consumed by eg fuse and
>> ublk. The existing users don't really do anything complicated on that
>> side, hence there's no real need to check. But since the ring/task is
>> going away, we should be able to generically do it in the helpers like
>> you did below.
> 
> That won't work, we should give commands an opportunity to clean up
> after themselves. I'm pretty sure it will break existing users.
> For now we can pass a flag to the callback, fuse would need to
> check it and fail. Compile tested only

Right, I did actually consider that yesterday and why I replied with the
fuse callback needing to do it, but then forgot... Since we can't do a
generic cleanup callback, it'll have to be done in the handler.

I do like making this generic and not needing individual task_work
handlers like this checking for some magic, so I like the flag addition.

-- 
Jens Axboe


