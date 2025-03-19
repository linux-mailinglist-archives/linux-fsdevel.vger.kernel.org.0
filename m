Return-Path: <linux-fsdevel+bounces-44471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07431A6982A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 19:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A59419C2DC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB0620DD63;
	Wed, 19 Mar 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rY4aAwr7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60FC20C480
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409454; cv=none; b=c7+c1s1SzqXxxP0b8PtCTawXg8MtacOTSEZsmvZ3QAJ3FNU3YqYF+dUA/EWkx1WZoKh0F9METfMPrBz4Wgl9Hj6s1NTfARr6ETr0AHC/K8DhnNFawnQfzVQ/06otrXO05aI+d2sPgjsmmsJdWn7WLDeCTrAnzpPU9olloZQwv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409454; c=relaxed/simple;
	bh=Kfa8G/vNjaGYGNW0JEQ3dlKDH4NKHYZbxfNqGPSjPo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V+IA6ovyzYB6fhnsyxSw49nw1tLt8I/bKVzLoCxDviPepuRH5qQ4Mqfc6M//AcUareeXBST97M2v23HN1frhiz6N3Lbyt1fUeZ/8gwXD2Yzqc4Gyt6d81FI3pYoLDqoOZO7gSUdP6fyfecYhwvv8keb67aJIfXHrgEqgby/vP0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rY4aAwr7; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85517db52a2so76452539f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 11:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742409452; x=1743014252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOU2TrWkWar/3vjS2cdu6jloemO8+tWZ3XM9RPU5SBM=;
        b=rY4aAwr7MzroRirr+3kEnWfq9zhfrbVCQVhgq+OcvrjnPB2546k1DLITEOxdeavOYw
         J/xv7QmLV2guZ0GpbEcemzbnmVSzjYkDJp7PgXCwo5dtCEP9UuXjcb92T5Tttx71t1H1
         vkfVxatNPm6NRhDBdTWuTkdv0Jhw9U5pV20pDh8fdhJgHZvsd+6p9fXwMCdyBG012J9O
         OPzVwQY96LHOn9KtXYAUmlwMV9Sc6NMvEM0w8bq+6QAk62DCCQEuqNgLJbLJ25CBaHfx
         TKswsw1IPaW6VXT+b/mKN4vDGNsyA8ro3GgbgUEb30mw5dK9HB11bEQDcBGCkR9s0FYE
         OFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409452; x=1743014252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOU2TrWkWar/3vjS2cdu6jloemO8+tWZ3XM9RPU5SBM=;
        b=nPUeKKZO7wk9O83xZvbTiAg1InSw9clS6ZBiSMfqhWlxRFO6VCQs1C4QscWn7u0iWR
         fIAentKGavNdQYA9Dl75H7jZbHnEHjri4dNBo1bpxwI3S6yVJz1w7dWY/KyZ7ew3tuDm
         oDvb+nSBZGLtjWviMbvRxn7YsYZZ/uMdrkPT+rX6vopLEnVNZH5eN9ZT22WxU1AW/Wwj
         v3w9AhK3KRmAsBd+oBFJtU/jj5NkUlZdCjM9mrC42SL2ErMdnfhI6wwlAdRe8L1mR6cN
         l+ZBZEL/i0Outa5YZt5e7aC2HzEqAWCk2QkUqUIezmeYz1rIdBMGiAuqSttyv0Sf6NKz
         U65g==
X-Forwarded-Encrypted: i=1; AJvYcCVVCtFSG0Odu2ov98y2gJcJyCCVdPlkR38ob8iAu64P/kqfitEXZhzRLxXitTYrCMKIAKr4oIicwgWN6B8C@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+/2quPR5mqV6R9Z8wGnwTWWN+V98G83eSgossq6ehiY+qsTB
	TzujLGQcWA20r0NtnMt4F9fkH+rDHESBbWT7LMjFqGxbhphhCF+BNoL1JAj1l8k=
X-Gm-Gg: ASbGncv6LbCB6ex/eCzRoyEz6Nu7u7hQtRH66zLxGVrS4KWvMmMvjnvDC4oU9gNOAEK
	rSyZOK3wf8ZtpcBdr0f9NBTg0dnFrmurBFU5NXuQsT88Bez9VrZLfAmkNfHf1x33dSwTSwdl3bm
	v03I+T/Eb/v71CXRfn2wv2QJwseOPU6vxLJeqfNVwntwN6TL4ymU+h41vM4UDJrQ0iWbRhnUYwH
	KcuvdToizkmeo9Jyhycl9z0l5VMHvUwLn2TCBXA/D5VXysnizh+G3pSmXf6MppmIIxkdM7UkCpe
	65i2tmzZiByzTd/7hpqo215ym6Or7ldSKpzmrM3+hOq4Q+jYodI=
X-Google-Smtp-Source: AGHT+IECcYnfpxvlC0iwBwA5lQBypcp+EaJg23jC62c//8nQymJPnN/mdYzW4CY8JWkJ1PAm8TMlJw==
X-Received: by 2002:a05:6602:3587:b0:85d:a69f:371d with SMTP id ca18e2360f4ac-85e137b6f82mr529954939f.4.1742409451617;
        Wed, 19 Mar 2025 11:37:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263702081sm3364488173.14.2025.03.19.11.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 11:37:31 -0700 (PDT)
Message-ID: <dc3ebb86-f4b2-443a-9b0d-f5470fd773f1@kernel.dk>
Date: Wed, 19 Mar 2025 12:37:29 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 11:45 AM, Joe Damato wrote:
> On Wed, Mar 19, 2025 at 11:20:50AM -0600, Jens Axboe wrote:
>> On 3/19/25 11:04 AM, Joe Damato wrote:
>>> On Wed, Mar 19, 2025 at 10:07:27AM -0600, Jens Axboe wrote:
>>>> On 3/19/25 9:32 AM, Joe Damato wrote:
>>>>> On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
>>>>>> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
>>>>>>> One way to fix this is to add zerocopy notifications to sendfile similar
>>>>>>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
>>>>>>> extensive work done by Pavel [1].
>>>>>>
>>>>>> What is a "zerocopy notification" 
>>>>>
>>>>> See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
>>>>> sendmsg and passes MSG_ZEROCOPY a completion notification is added
>>>>> to the error queue. The user app can poll for these to find out when
>>>>> the TX has completed and the buffer it passed to the kernel can be
>>>>> overwritten.
>>>>>
>>>>> My series provides the same functionality via splice and sendfile2.
>>>>>
>>>>> [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
>>>>>
>>>>>> and why aren't you simply plugging this into io_uring and generate
>>>>>> a CQE so that it works like all other asynchronous operations?
>>>>>
>>>>> I linked to the iouring work that Pavel did in the cover letter.
>>>>> Please take a look.
>>>>>
>>>>> That work refactored the internals of how zerocopy completion
>>>>> notifications are wired up, allowing other pieces of code to use the
>>>>> same infrastructure and extend it, if needed.
>>>>>
>>>>> My series is using the same internals that iouring (and others) use
>>>>> to generate zerocopy completion notifications. Unlike iouring,
>>>>> though, I don't need a fully customized implementation with a new
>>>>> user API for harvesting completion events; I can use the existing
>>>>> mechanism already in the kernel that user apps already use for
>>>>> sendmsg (the error queue, as explained above and in the
>>>>> MSG_ZEROCOPY documentation).
>>>>
>>>> The error queue is arguably a work-around for _not_ having a delivery
>>>> mechanism that works with a sync syscall in the first place. The main
>>>> question here imho would be "why add a whole new syscall etc when
>>>> there's already an existing way to do accomplish this, with
>>>> free-to-reuse notifications". If the answer is "because splice", then it
>>>> would seem saner to plumb up those bits only. Would be much simpler
>>>> too...
>>>
>>> I may be misunderstanding your comment, but my response would be:
>>>
>>>   There are existing apps which use sendfile today unsafely and
>>>   it would be very nice to have a safe sendfile equivalent. Converting
>>>   existing apps to using iouring (if I understood your suggestion?)
>>>   would be significantly more work compared to calling sendfile2 and
>>>   adding code to check the error queue.
>>
>> It's really not, if you just want to use it as a sync kind of thing. If
>> you want to have multiple things in flight etc, yeah it could be more
>> work, you'd also get better performance that way. And you could use
>> things like registered buffers for either of them, which again would
>> likely make it more efficient.
> 
> I haven't argued that performance would be better using sendfile2
> compared to iouring, just that existing apps which already use
> sendfile (but do so unsafely) would probably be more likely to use a
> safe alternative with existing examples of how to harvest completion
> notifications vs something more complex, like wrapping iouring.

Sure and I get that, just not sure it'd be worth doing on the kernel
side for such (fairly) weak reasoning. The performance benefit is just a
side note in that if you did do it this way, you'd potentially be able
to run it more efficiently too. And regardless what people do or use
now, they are generally always interested in that aspect.

>> If you just use it as a sync thing, it'd be pretty trivial to just wrap
>> a my_sendfile_foo() in a submit_and_wait operation, which issues and
>> waits on the completion in a single syscall. And if you want to wait on
>> the notification too, you could even do that in the same syscall and
>> wait on 2 CQEs. That'd be a downright trivial way to provide a sync way
>> of doing the same thing.
> 
> I don't disagree; I just don't know if app developers:
>   a.) know that this is possible to do, and
>   b.) know how to do it

Writing that wrapper would be not even a screenful of code. Yes maybe
they don't know how to do it now, but it's _really_ trivial to do. It'd
take me roughly 1 min to do that, would be happy to help out with that
side so it could go into a commit or man page or whatever.

> In general: it does seem a bit odd to me that there isn't a safe
> sendfile syscall in Linux that uses existing completion notification
> mechanisms.

Pretty natural, I think. sendfile(2) predates that by quite a bit, and
the last real change to sendfile was using splice underneath. Which I
did, and that was probably almost 20 years ago at this point...

I do think it makes sense to have a sendfile that's both fast and
efficient, and can be used sanely with buffer reuse without relying on
odd heuristics.

>>> I would also argue that there are likely user apps out there that
>>> use both sendmsg MSG_ZEROCOPY for certain writes (for data in
>>> memory) and also use sendfile (for data on disk). One example would
>>> be a reverse proxy that might write HTTP headers to clients via
>>> sendmsg but transmit the response body with sendfile.
>>>
>>> For those apps, the code to check the error queue already exists for
>>> sendmsg + MSG_ZEROCOPY, so swapping in sendfile2 seems like an easy
>>> way to ensure safe sendfile usage.
>>
>> Sure that is certainly possible. I didn't say that wasn't the case,
>> rather that the error queue approach is a work-around in the first place
>> for not having some kind of async notification mechanism for when it's
>> free to reuse.
> 
> Of course, I certainly agree that the error queue is a work around.
> But it works, app use it, and its fairly well known. I don't see any
> reason, other than historical context, why sendmsg can use this
> mechanism, splice can, but sendfile shouldn't?

My argument would be the same as for other features - if you can do it
simpler this other way, why not consider that? The end result would be
the same, you can do fast sendfile() with sane buffer reuse. But the
kernel side would be simpler, which is always a kernel main goal for
those of us that have to maintain it.

Just adding sendfile2() works in the sense that it's an easier drop in
replacement for an app, though the error queue side does mean it needs
to change anyway - it's not just replacing one syscall with another. And
if we want to be lazy, sure that's fine. I just don't think it's the
best way to do it when we literally have a mechanism that's designed for
this and works with reuse already with normal send zc (and receive side
too, in the next kernel).

-- 
Jens Axboe

