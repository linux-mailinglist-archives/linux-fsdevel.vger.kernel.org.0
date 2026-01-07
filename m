Return-Path: <linux-fsdevel+bounces-72614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DA6CFDCDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 14:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 896CF300EF6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 13:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FF62236FD;
	Wed,  7 Jan 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaUnPCzz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBB2EA169
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790956; cv=none; b=Od+r+oFTfK4oU7mbGt1G1qVBnC6VyYmlgkVnuZHnT4xAeexLPgfXEsZl5XTozcYT1DPzjdD3d1ygXadaNBq7refvwos0JKU+vJ+DmP2ENOwyT8dm8ETaqSpdId6R/h6BFUcyBZ/MdDlb87YvNp1iwLQ83uSwqaY5CYvOwP5fUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790956; c=relaxed/simple;
	bh=bWSVV22jZh9coEv3ULigZXfiCNuesnPGhW14yA08Rbs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LvpvKFoj+IRLHiIHzf1+vq+qOYNclEEIJMINLpr/5GWfY2Sc6r+XPud/+sdWqr6TTcWC20RA5s/ef5JKPv2+05Vzy8k3RI3jLH6ifSgvykzPKVGDUua5u7yEHdYVhlYZ5oQMwkTImXazdzvBBp2yZOa6vEP02gE+xtCRRtkk/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaUnPCzz; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640d4f2f13dso1860696d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 05:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767790954; x=1768395754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVyX/saFSHkwOAT/HfR9J/XxoKvZtdkuCzZLxL4WCSA=;
        b=NaUnPCzzW/Fln5L4uwxePJLRJhddJX9UqPvnItJ7hlqspjrKAs5zY60cxbBrZTSdIK
         LGJIsrUfjUWcoGGDEvivK3s8/IiPVuQkn+rowPS4fLobSntSz5Bt00OiseUlIP9aLRGc
         JHqBB+3n63EaI19gCyvR3OFfvjHy2ZUDKHm59A0AUwSiq9vNDPk8wwfphHrS5dfEuZiM
         D6G/SKsprry3mn6XHvmPeqro9YZ2Oyi/RbZBD64/mtyVNgyptAOTU3wdpBukHp9CKKkX
         tr04G1JbVm67PWBWdJ+z+drIMI5G8ieB8MeS7mwjR/1WK4KUYyoxqmfUrSTord4TdKQZ
         vrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767790954; x=1768395754;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVyX/saFSHkwOAT/HfR9J/XxoKvZtdkuCzZLxL4WCSA=;
        b=YhVJYXoNqjToFcPjsHzMVx3rHAZQmVwfKTA+Wg/AZ01pfp6zREfYJeyJdFQsJOMrl9
         jy1NlXxU5+ua1UW7fL1vwkEzzMhBcyj+ypQvWyMtFidAae7yAgoOrT5MiyhxTnzjdl7n
         2hhUbdAKO36cS34QyEEkwSyx7dSIzjVXwY5F2MmSj/UbtqwL42YUFNTidBtenB3E3LGk
         CIgiqRYvf10cV7ZpPVu8Fal3EypSjuhBpZ0v9Zf5LnY4zQvob1ho6eIGle62NCnueIdF
         Ye3ffRf/D5qaeWuuM7sQ3VsBIDoCJziUzy8hM1DXzZga4jcJ8PyXRpnmrqYuDeSKsz9T
         qpCA==
X-Forwarded-Encrypted: i=1; AJvYcCV59VuW8s232mp6+Vq6J4dr6RPLLMPKEzOnvo/gSqmIeQl7W3LmJOM1p0WiTw1IPu32jbYcdJnF0AZyu+B0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0BTlf7llCKtPH4K69j818r5uCsQCmo1wSnWwA9sqcqADWskl
	Gzt8qiW2KPa5rcDXKjz6rviaffeBb9lKIPEmkSGYqnhu936DOw1a7o0LDdQACA==
X-Gm-Gg: AY/fxX5xCJRZaOaMrpBtMobl1M7xVYgcI3xC4h4B0gHZClANG4FaS2RUnjHJkD2cNR5
	IWq5bDtcx7uyJ1cKVcDwOVLCSz3h/6y4k/lIKW7/QkujRyUftTr65sOTOltwCaiC7eqb88QKgrX
	Qylbc7qhytylOyqJPesFq6cocktDNu86RGJjPUIZFdSVc60A/y2Sr/3ApzGknsT3mtu2EqnbAHB
	uFcoQ64NgmibLumRtDBQgVt1s3qN4Bs3YYRVSnxyyUlYSVuRPdZO4BnlhQzcCuiu63Jk8IcM9nL
	YLc5no7ejdGOkmIPQhxKtOq7Bqpl2/W5evhj8wRW6ZtViMx0Z7kjvyYScM3zj97X0cRiq9gJsIC
	h+RLEyVQ6vod0yzw7Af91xNuG6xcS4NYUCcQmYeqnLhE3hXEcQWPAo0WUrnS8zevTwiDouTgNIq
	vZrlhE9MkHBgOtaqIJqRn1L0blbPFOtIsGXScFnsX/CsDLq4MuzTGM6F1njxG1XLnwWNM=
X-Google-Smtp-Source: AGHT+IFka4564yGsxxmwys4Mn7+GTaVT5Y+gqGfi+/kEB3nv8HFKvSn2ve0Sd55L7DEx3kGPj6korQ==
X-Received: by 2002:a17:903:2291:b0:2a2:d2e8:9f25 with SMTP id d9443c01a7336-2a3ee47f0a8mr18571915ad.33.1767784973602;
        Wed, 07 Jan 2026 03:22:53 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88e3sm48170855ad.75.2026.01.07.03.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 03:22:53 -0800 (PST)
Date: Wed, 07 Jan 2026 20:22:45 +0900 (JST)
Message-Id: <20260107.202245.559061117523678561.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, aliceryhl@google.com, lyude@redhat.com,
 boqun.feng@gmail.com, will@kernel.org, peterz@infradead.org,
 richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
 catalin.marinas@arm.com, ojeda@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 dakr@kernel.org, mark.rutland@arm.com, frederic@kernel.org,
 tglx@linutronix.de, anna-maria@linutronix.de, jstultz@google.com,
 sboyd@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] rust: hrtimer: use READ_ONCE instead of
 read_volatile
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87cy3livfk.fsf@t14s.mail-host-address-is-not-set>
References: <87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
	<20260106.222826.2155269977755242640.fujita.tomonori@gmail.com>
	<87cy3livfk.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 07 Jan 2026 11:11:43 +0100
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
> 
>> On Tue, 06 Jan 2026 13:37:34 +0100
>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
>>> 
>>>> On Thu, 01 Jan 2026 11:11:23 +0900 (JST)
>>>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>>>>
>>>>> On Wed, 31 Dec 2025 12:22:28 +0000
>>>>> Alice Ryhl <aliceryhl@google.com> wrote:
>>>>>
>>>>>> Using `READ_ONCE` is the correct way to read the `node.expires` field.
>>>>>>
>>>>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>>>>> ---
>>>>>>  rust/kernel/time/hrtimer.rs | 8 +++-----
>>>>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>>>>> index 856d2d929a00892dc8eaec63cebdf547817953d3..e2b7a26f8aade972356c3eb5f6489bcda3e2e849 100644
>>>>>> --- a/rust/kernel/time/hrtimer.rs
>>>>>> +++ b/rust/kernel/time/hrtimer.rs
>>>>>> @@ -239,11 +239,9 @@ pub fn expires(&self) -> HrTimerInstant<T>
>>>>>>          // - Timers cannot have negative ktime_t values as their expiration time.
>>>>>>          // - There's no actual locking here, a racy read is fine and expected
>>>>>>          unsafe {
>>>>>> -            Instant::from_ktime(
>>>>>> -                // This `read_volatile` is intended to correspond to a READ_ONCE call.
>>>>>> -                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
>>>>>> -                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
>>>>>> -            )
>>>>>> +            Instant::from_ktime(kernel::sync::READ_ONCE(
>>>>>> +                &raw const (*c_timer_ptr).node.expires,
>>>>>> +            ))
>>>>>>          }
>>>>>
>>>>> Do we actually need READ_ONCE() here? I'm not sure but would it be
>>>>> better to call the C-side API?
>>>>>
>>>>> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
>>>>> index 67a36ccc3ec4..73162dea2a29 100644
>>>>> --- a/rust/helpers/time.c
>>>>> +++ b/rust/helpers/time.c
>>>>> @@ -2,6 +2,7 @@
>>>>>
>>>>>  #include <linux/delay.h>
>>>>>  #include <linux/ktime.h>
>>>>> +#include <linux/hrtimer.h>
>>>>>  #include <linux/timekeeping.h>
>>>>>
>>>>>  void rust_helper_fsleep(unsigned long usecs)
>>>>> @@ -38,3 +39,8 @@ void rust_helper_udelay(unsigned long usec)
>>>>>  {
>>>>>  	udelay(usec);
>>>>>  }
>>>>> +
>>>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>>>>> +{
>>>>> +	return timer->node.expires;
>>>>> +}
>>>>
>>>> Sorry, of course this should be:
>>>>
>>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>>>> +{
>>>> +	return hrtimer_get_expires(timer);
>>>> +}
>>>>
>>> 
>>> This is a potentially racy read. As far as I recall, we determined that
>>> using read_once is the proper way to handle the situation.
>>> 
>>> I do not think it makes a difference that the read is done by C code.
>>
>> What does "racy read" mean here?
>>
>> The C side doesn't use WRITE_ONCE() or READ_ONCE for node.expires. How
>> would using READ_ONCE() on the Rust side make a difference?
> 
> Data races like this are UB in Rust. As far as I understand, using this
> READ_ONCE implementation or a relaxed atomic read would make the read
> well defined. I am not aware if this is only the case if all writes to
> the location from C also use atomic operations or WRITE_ONCE. @Boqun?

The C side updates node.expires without WRITE_ONCE()/atomics so a
Rust-side READ_ONCE() can still observe a torn value; I think that
this is still a data race / UB from Rust's perspective.

And since expires is 64-bit, WRITE_ONCE() on 32-bit architectures does
not inherently guarantee tear-free stores either.

I think that the expires() method should follow the same safety
requirements as raw_forward(): it should only be considered safe when
holding exclusive access to hrtimer or within the context of the timer
callback. Under those conditions, it would be fine to call C's
hrtimer_get_expires().


