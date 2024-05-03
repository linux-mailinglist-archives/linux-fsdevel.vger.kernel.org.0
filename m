Return-Path: <linux-fsdevel+bounces-18671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0D8BB42C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 21:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C241C23B72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D3E15884C;
	Fri,  3 May 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kIk/pWhL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091032206E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764914; cv=none; b=lMsiTe4fdFBRBJ6e9nCvk8j1VHiwT7fnH24JjGRhZPkK+EoZCbP2B8kwC+of7zKiGffNEAszlDD5a2seTPDJmrR9zWQG7Xqvf2TVdikFrdiszDLVEWmp5htMZuR3hDEb6nYZphIBLNIy7QS5i2uLLnxEDMyqlJQC7L9Xp08GyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764914; c=relaxed/simple;
	bh=r8Nv21VrvCRT1FuqygB1ITanHjlHw4scuJdDnqqN7w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEOPUc3+Pyqx5LISKTTlITozz/3RcOL6qNJTEzbTwypE7pH334h0mbULmO04uQ6b58eeifnPZVdJcQb5KikCuurynM44gICTNQ5XJ61rdjYQswVWXceUHslXcfe8qdEOtt8oj7ULgnwHpzTHLKKVVw4yd+9KhKHVnphpJI+CDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kIk/pWhL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b432d0252cso20254a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 12:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714764911; x=1715369711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORetLTXl3HzmbjljZHEUgf3Mmr/eaSDx8Jozq/iEtsM=;
        b=kIk/pWhLLh24YCRYq99z9MlLqs5IGr1laqUoGKIcb/YeqEOpn34TV5+d0nSq/IzRDC
         op9OgzM/NDXqRj08cYtt1YQdMojR+dcKkjiZ44pL9uedK1vgPXZn+9GvR7nOh96Ial/e
         w1foGDzUo9hovPN6zEOoQ8hV7PafXmJf5vqDNjB1TTCdkKQ1wNb0I++90yfVMY+wDfwV
         f1CPg/rpax5507TL8k8Q6h1za4Fy58/KS1OQk74JpEnZaU7KCV+izDDhcdCaiBy8Aa+E
         jsvsm77j3EjNFgNTgRizpY3MtRLLAQpb5JGHoWZ5t8fqUsoXbY75SUYAhDzPyhkQxaZh
         D/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764911; x=1715369711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORetLTXl3HzmbjljZHEUgf3Mmr/eaSDx8Jozq/iEtsM=;
        b=ABsOBoc12aUoNyb6+T7/sz9MphD0X1yVaqIXzQXOGEz0BxIWZZZehNUyX4MLQIQ3U6
         T0kUgOImeYXmTdwZYLrl5OHtG7wV0Li0bmuc3x/PaWrIT4uflagIMNdWqFAXnLDaiF+f
         PCGkoaOsglj+3X0mlEc8We6d/ssywenjC5qtj5vR11CMTshd6Nyyb1dX9iSs0IooedlN
         TZX1vZlhe3sY6Dp5jiZEFfGX/ODrZSvu9KmneKCdwGeXTL7PLqTrUFPvwDxr8y1hKKE9
         f/rjSJe61RHO/dM7AoZ8gHaJ0sPmvD+9qx7UPprj8AXz3NzXq5BP+7TCkEewe3fufzRI
         j2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbTmR/dogSeNR+emNJ1H6F/EeYqqsfpkCmDD/3poDO4SIS8ujWqn0SZX110qVaU1IBsTgVq67CNKOtHn+dQXMqFRUL+f+jIXx3+rmheQ==
X-Gm-Message-State: AOJu0YwEWg2Mo5Xesq2Gz+9qz8A2OaiHzfg/zr9QbXFpFKNFX0lUz1c8
	neJDQp2au90t3TyUACrT34J8zzJLA6keMeDPMBmkcVeFSeQbpBXE0lxexkv6yxY=
X-Google-Smtp-Source: AGHT+IHPB1IZ4O2sSxiGYAZKvpeGjbdnZ2bAwpyCrMWAsjHJbfq5KyMCcWf/Ef7me/A0cgN11ffW+A==
X-Received: by 2002:aa7:880c:0:b0:6ec:ef1c:5c55 with SMTP id c12-20020aa7880c000000b006ecef1c5c55mr3736637pfo.2.1714764911345;
        Fri, 03 May 2024 12:35:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id gx14-20020a056a001e0e00b006f44be6cef2sm1664133pfb.114.2024.05.03.12.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:35:10 -0700 (PDT)
Message-ID: <d6285f19-01aa-49c8-8fef-4b5842136215@kernel.dk>
Date: Fri, 3 May 2024 13:35:09 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: get_file() unsafe under epoll (was Re: [syzbot] [fs?] [io-uring?]
 general protection fault in __ep_remove)
To: Kees Cook <keescook@chromium.org>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Laura Abbott <laura@labbott.name>
References: <0000000000002d631f0615918f1e@google.com>
 <7c41cf3c-2a71-4dbb-8f34-0337890906fc@gmail.com>
 <202405031110.6F47982593@keescook>
 <64b51cc5-9f5b-4160-83f2-6d62175418a2@kernel.dk>
 <202405031207.9D62DA4973@keescook>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202405031207.9D62DA4973@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 1:22 PM, Kees Cook wrote:
> On Fri, May 03, 2024 at 12:49:11PM -0600, Jens Axboe wrote:
>> On 5/3/24 12:26 PM, Kees Cook wrote:
>>> Thanks for doing this analysis! I suspect at least a start of a fix
>>> would be this:
>>>
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index 8fe5aa67b167..15e8f74ee0f2 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -267,9 +267,8 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>>>  
>>>  		if (events & EPOLLOUT) {
>>>  			/* Paired with fput in dma_buf_poll_cb */
>>> -			get_file(dmabuf->file);
>>> -
>>> -			if (!dma_buf_poll_add_cb(resv, true, dcb))
>>> +			if (!atomic_long_inc_not_zero(&dmabuf->file) &&
>>> +			    !dma_buf_poll_add_cb(resv, true, dcb))
>>>  				/* No callback queued, wake up any other waiters */
>>
>> Don't think this is sane at all. I'm assuming you meant:
>>
>> 	atomic_long_inc_not_zero(&dmabuf->file->f_count);
> 
> Oops, yes, sorry. I was typed from memory instead of copy/paste.

Figured :-)

>> but won't fly as you're not under RCU in the first place. And what
>> protects it from being long gone before you attempt this anyway? This is
>> sane way to attempt to fix it, it's completely opposite of what sane ref
>> handling should look like.
>>
>> Not sure what the best fix is here, seems like dma-buf should hold an
>> actual reference to the file upfront rather than just stash a pointer
>> and then later _hope_ that it can just grab a reference. That seems
>> pretty horrible, and the real source of the issue.
> 
> AFAICT, epoll just doesn't hold any references at all. It depends,
> I think, on eventpoll_release() (really eventpoll_release_file())
> synchronizing with epoll_wait() (but I don't see how this happens, and
> the race seems to be against ep_item_poll() ...?)
>
> I'm really confused about how eventpoll manages the lifetime of polled
> fds.

epoll doesn't hold any references, and it's got some ugly callback to
deal with that. It's not ideal, nor pretty, but that's how it currently
works. See eventpoll_release() and how it's called. This means that
epoll itself is supposedly safe from the file going away, even though it
doesn't hold a reference to it.

Except that in this case, the file is already gone by the time
eventpoll_release() is called. Which presumably is some interaction with
the somewhat suspicious file reference management that dma-buf is doing.
But I didn't look into that much, outside of noting it looks a bit
suspect.

>>> Due to this issue I've proposed fixing get_file() to detect pathological states:
>>> https://lore.kernel.org/lkml/20240502222252.work.690-kees@kernel.org/
>>
>> I don't think this would catch this case, as the memory could just be
>> garbage at this point.
> 
> It catches it just fine! :) I tested it against the published PoC.

Sure it _may_ catch the issue, but the memory may also just be garbage
at that point. Not saying it's a useless addition, outside of the usual
gripes of making the hot path slower, just that it won't catch all
cases. Which I guess is fine and expected.

> And for cases where further allocations have progressed far enough to
> corrupt the freed struct file and render the check pointless, nothing
> different has happened than what happens today. At least now we have a
> window to catch the situation across the time frame before it is both
> reallocated _and_ the contents at the f_count offset gets changed to
> non-zero.

Right.

-- 
Jens Axboe


