Return-Path: <linux-fsdevel+bounces-37479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BEE9F2DE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 11:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FA31651A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA6202F9A;
	Mon, 16 Dec 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU9yAmyb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0FD202C37;
	Mon, 16 Dec 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343900; cv=none; b=QEyy60KbTKCSqHi0azTOcp6uphQGudZDqIH7QVsxFYfbNVKNZacrlg+LR/2PKS/lItJfK3bn2Zi9IapSMAiPiH5IfuJWBPlN9/XDc6dSWe+b/Im80cBdUNM8I63Z8ssI6X6LwgS8iqQH6+5VrpSzR7/Me93ZsBNfcuBqjPyzFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343900; c=relaxed/simple;
	bh=rerkDv4+3ixVJGqlsrEPNvGYbtkP0sOJsqUbWCAaK68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nq2pQac55EAsTRe8/ZuSElpqzLIQVvE5kcpsqINJj772vFihqSE02DbA4UqBmjWp1oMALUhkp+IhE4bCU0aYXFOBYy9Jaepn0nZv0d1yEcmqS3S0MqFkvQ7hAdEqx7eirwdQhK7u4VGwlSbVIi7Yp2vQ1ouzli8F8WK4NYpP6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU9yAmyb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725dc290c00so3763751b3a.0;
        Mon, 16 Dec 2024 02:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734343898; x=1734948698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+ixtMUrgX7I9rD5qvImPgp6IqifPuxLwfcX3hM//qc=;
        b=VU9yAmybm0sskcfNoQ0Q30POeXon5zfQAhCVK03eKlu7Lm4f8NqIYolFjwSUjUGwqa
         64NsuJqrruHPvAqx8O33+WBr7+hiNBkpCc8wMhvoXy93Xo3AwEVzIYyKUnMlxPZRnxHE
         waG3Ds5zsA1OzWLIZEzIVsPfFfTSGeu9rjIqYqCjpzroCDogIs0oH5T5iiKdnmNTzARf
         R+1ct7QF6dljhd5oAUPfB32ajrTGi2Ft/ifBBUrs7q8pt7XwMGnjZH9Ah8C9OL6Gu/fW
         /rKaXDOtxbpeBoNiSbkdgzLPjyaueT8Q9cCIsExWMcxGHSN04GlVuzrsfkbyqw+U3lKq
         vVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734343898; x=1734948698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+ixtMUrgX7I9rD5qvImPgp6IqifPuxLwfcX3hM//qc=;
        b=FVSUFScJZ+ECR+TxvrpIN0LYniX5HIJy1CnkXz8KtsSiREAVk6/WoCJ3+MhKn3XDtk
         7kZ37ewtS2VaDMdBq5eXCHlpCP9haS6x2/Pf4jjQr0kJYxYsfl01FrpTIHLZ9zaf8wca
         fVox3hQ/JU4R/i0BwyFh/5bimFzuzA+gSr9hLpOEnBS+XJClCkXNmumjpU9CC8EvYnpp
         Y8yloePnGb9nlnH/02B0vvxGXjGj2clrvdLB5cnyqQ0u+BUr/EMR289RskoT/c3BzF38
         Nf1fuVz0E20c4YLgqu6j/B0f8lMCKgNRWt/Sp5mH9aCLl8ME52PxaghSyRrsh6q7Mnq3
         0Y5g==
X-Forwarded-Encrypted: i=1; AJvYcCU2yvOqhtoN+orqFev+7bJDudHvO1OeEyMWYtKuCqUbd1Vkztz+vGzLkelambC4UYxsAItKndi+Yrqmog==@vger.kernel.org, AJvYcCU33C9oUmh3pNt2C5d/AF2JmKz55j89elgeGdYCftUkYI/lEW3swm/hWl7O7TyK27eDC0pcITeJcwe3@vger.kernel.org, AJvYcCUUUZsIZefUs3BYsyD0T9H/kHdloggMFc2olvXF71D2dhC7eu1twVlQ26aG7/4/ZkXLSx+aXa0KhQHc@vger.kernel.org, AJvYcCUotRoFq4Z1s48u8LYzA1zqIjHikXoy34bDifa45YRh1gBPCLTXdZ6DxO/7DzKu+txu6lVvMSBHl/xZ62cb@vger.kernel.org, AJvYcCVPHCS1Sw5pXOxak+lyqwt5LWnjrBYqiM2Wpx3FE1H14caq5Nd5cUvSjWy+3xVrjzEnanjaCDubOkG2rBx+xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRVxh9v/NktJRWypb/uSFzUHXxcGW/+IQw0i1rG5aZpqJlu5Y
	YAUtlvxv3n7yxFJYENqqBoXCvNr+J4y3tczqnDIdow8hoD2AhESZ
X-Gm-Gg: ASbGnctalaGf+cBY5ST9u26WoMVag4PYarq6PT2EftQKpuRGA4x8UQ8FNgxR0+u98Zg
	kPY1CSA3bIqGNMm6Ha/oaVCPUOqi5F68Q5luzFaggw8ecIrqplPGyUq+W/byEb69r6e3SFVKBHU
	yHSIlqw+/AVQ2/qIJVP7XW1qB7YWvDpVZszpv6RUJyNQrADD7pHDdxVI4JxX6WCQMfAK5330/Cy
	DCOzx0YXvbu7A3yApxH6EoktxFP2uM9TXzRUNphYhf4NGTHMKfeW8YKojFGEgg9oBP8f0WbCC/X
	dsOfkgnERA9o+stfLlzxa7A=
X-Google-Smtp-Source: AGHT+IGkvlAjtALOBMooHfO7cK9L9lvwDBwHCDIhwn8y88sRHLlwLffLXlgmsZ5Mm6dr710N1QQFRg==
X-Received: by 2002:a05:6a20:a11c:b0:1e1:e1c0:1c05 with SMTP id adf61e73a8af0-1e1e1c0202amr16720966637.9.1734343898208;
        Mon, 16 Dec 2024 02:11:38 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c3a513sm3824066a12.72.2024.12.16.02.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:11:37 -0800 (PST)
Message-ID: <554ff96b-5be5-46b0-ac8b-f178394856f3@gmail.com>
Date: Mon, 16 Dec 2024 19:11:33 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] netfs: Fix missing barriers by using
 clear_and_wake_up_bit()
To: David Howells <dhowells@redhat.com>, "Paul E. McKenney"
 <paulmck@kernel.org>
Cc: Christian Brauner <christian@brauner.io>,
 Max Kellermann <max.kellermann@ionos.com>, Ilya Dryomov
 <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>, Akira Yokosawa <akiyks@gmail.com>
References: <27fff669-bec4-4255-ba2f-4b154b474d97@gmail.com>
 <20241213135013.2964079-1-dhowells@redhat.com>
 <20241213135013.2964079-8-dhowells@redhat.com>
 <3332016.1734183881@warthog.procyon.org.uk>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <3332016.1734183881@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

David Howells wrote:
> [Adding Paul McKenney as he's the expert.]
> 
> Akira Yokosawa <akiyks@gmail.com> wrote:
> 
>> David Howells wrote:
>>> Use clear_and_wake_up_bit() rather than something like:
>>>
>>> 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
>>> 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
>>>
>>> as there needs to be a barrier inserted between which is present in
>>> clear_and_wake_up_bit().
>>
>> If I am reading the kernel-doc comment of clear_bit_unlock() [1, 2]:
>>
>>     This operation is atomic and provides release barrier semantics.
>>
>> correctly, there already seems to be a barrier which should be
>> good enough.
>>
>> [1]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.clear_bit_unlock
>> [2]: include/asm-generic/bitops/instrumented-lock.h
>>
>>>
>>> Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
>>> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
>>
>> So I'm not sure this fixes anything.
>>
>> What am I missing?
> 
> We may need two barriers.  You have three things to synchronise:
> 
>  (1) The stuff you did before unlocking.
> 
>  (2) The lock bit.
> 
>  (3) The task state.
> 
> clear_bit_unlock() interposes a release barrier between (1) and (2).
> 
> Neither clear_bit_unlock() nor wake_up_bit(), however, necessarily interpose a
> barrier between (2) and (3).

Got it!

I was confused because I compared kernel-doc comments of clear_bit_unlock()
and clear_and_wake_up_bit() only, without looking at latter's code.

clear_and_wake_up_bit() has this description in its kernel-doc:

 * The designated bit is cleared and any tasks waiting in wait_on_bit()
 * or similar will be woken.  This call has RELEASE semantics so that
 * any changes to memory made before this call are guaranteed to be visible
 * after the corresponding wait_on_bit() completes.

, without any mention of additional full barrier at your (3) above.

It might be worth mentioning it there.

Thoughts?

FWIW,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

>                               I'm not sure it entirely matters, but it seems
> that since we have a function that combines the two, we should probably use
> it - though, granted, it might not actually be a fix.

Looks like it should matter where smp_mb__after_atomic() is stronger than
a plain barrier().

Akira


