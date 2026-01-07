Return-Path: <linux-fsdevel+bounces-72679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F043CFF74A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 19:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A52030010E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 18:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A2533AD98;
	Wed,  7 Jan 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnpYcOAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FEEAD24;
	Wed,  7 Jan 2026 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810084; cv=none; b=s0O9clfFiMPRcnxABXmINQVDBoNezpwREK/P8djPIwLxW3vl7WY7pqKw7Fj/4wPsuA0aB9V5RwPAXRrqeFDbhSOl7+beL3yY2/Na9AyQRHCwaSjJazhL8Hr2qJdf2zYfEHFj0w7ijFk4HyOvv4f/a6r5dHugmlSHzc7MW6zsw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810084; c=relaxed/simple;
	bh=K0mOaK6BrY9bp5EA2JCjimH1+UowvkU5HtroT5tTmeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BuK9Cja5gvSnCsBRpiOQB8sIwqv6wkQFXGqSJHHmWIexaUZyRoVR6nSqELJdMO8FK7plpUEL9mjs7yP7mJThptZRhjdfAc9TqR/jSeRd0mp8DsyLViccmREyTKzSsXn9dKsOqGtSAIzPWN8soocexwiYNeOgP9WipdPZvRtPpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnpYcOAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DF4C4CEF1;
	Wed,  7 Jan 2026 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767810083;
	bh=K0mOaK6BrY9bp5EA2JCjimH1+UowvkU5HtroT5tTmeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fnpYcOAFd1CAyjEFU/csaLKLhUVevIiWnhmwJZdEFp/zvUygqh33qZniJxvJBCYZJ
	 o+7xlLYJQdysc7eSo0234crmyas7izpzLskgTCEvsHSAlrDUSsCGj8TM/j1wVgaLZC
	 y8mWqukCK5fBsMvUd6I6TFl2XbYUsJZSCr30mJbUyJc6VedZ7BerKwt/L/KVdCkKPW
	 o6lIl6RBWc9+2qn2gkAsD7eqki0gO83LROGjROrlch9UcNlTVoIOngROYYfOMSQKQ4
	 Qp17m52Yq+or7B7UeMBUpKdETNeWLgfDHm7JBb9HnSR90pe9JZ1hs88oDq5XpiDHKz
	 zlCVkqCm6V7sg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
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
Subject: Re: [PATCH 4/5] rust: hrtimer: use READ_ONCE instead of read_volatile
In-Reply-To: <20260107.202245.559061117523678561.fujita.tomonori@gmail.com>
References: <87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
 <20260106.222826.2155269977755242640.fujita.tomonori@gmail.com>
 <87cy3livfk.fsf@t14s.mail-host-address-is-not-set>
 <WXFPsf9COQPV_obKoZg2bYwPL3k9TT0oBL3uxNppUFaIj5hxEX9UokzS_DJ5Kg5kXDzLrZ9ihALTZcf6ehljGw==@protonmail.internalid>
 <20260107.202245.559061117523678561.fujita.tomonori@gmail.com>
Date: Wed, 07 Jan 2026 19:21:11 +0100
Message-ID: <87ms2pgu7c.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> On Wed, 07 Jan 2026 11:11:43 +0100
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
>>
>>> On Tue, 06 Jan 2026 13:37:34 +0100
>>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>>
>>>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
>>>>
>>>>> On Thu, 01 Jan 2026 11:11:23 +0900 (JST)
>>>>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>>>>>
>>>>>> On Wed, 31 Dec 2025 12:22:28 +0000
>>>>>> Alice Ryhl <aliceryhl@google.com> wrote:
>>>>>>
>>>>>>> Using `READ_ONCE` is the correct way to read the `node.expires` field.
>>>>>>>
>>>>>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>>>>>> ---
>>>>>>>  rust/kernel/time/hrtimer.rs | 8 +++-----
>>>>>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>>>>>> index 856d2d929a00892dc8eaec63cebdf547817953d3..e2b7a26f8aade972356c3eb5f6489bcda3e2e849 100644
>>>>>>> --- a/rust/kernel/time/hrtimer.rs
>>>>>>> +++ b/rust/kernel/time/hrtimer.rs
>>>>>>> @@ -239,11 +239,9 @@ pub fn expires(&self) -> HrTimerInstant<T>
>>>>>>>          // - Timers cannot have negative ktime_t values as their expiration time.
>>>>>>>          // - There's no actual locking here, a racy read is fine and expected
>>>>>>>          unsafe {
>>>>>>> -            Instant::from_ktime(
>>>>>>> -                // This `read_volatile` is intended to correspond to a READ_ONCE call.
>>>>>>> -                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
>>>>>>> -                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
>>>>>>> -            )
>>>>>>> +            Instant::from_ktime(kernel::sync::READ_ONCE(
>>>>>>> +                &raw const (*c_timer_ptr).node.expires,
>>>>>>> +            ))
>>>>>>>          }
>>>>>>
>>>>>> Do we actually need READ_ONCE() here? I'm not sure but would it be
>>>>>> better to call the C-side API?
>>>>>>
>>>>>> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
>>>>>> index 67a36ccc3ec4..73162dea2a29 100644
>>>>>> --- a/rust/helpers/time.c
>>>>>> +++ b/rust/helpers/time.c
>>>>>> @@ -2,6 +2,7 @@
>>>>>>
>>>>>>  #include <linux/delay.h>
>>>>>>  #include <linux/ktime.h>
>>>>>> +#include <linux/hrtimer.h>
>>>>>>  #include <linux/timekeeping.h>
>>>>>>
>>>>>>  void rust_helper_fsleep(unsigned long usecs)
>>>>>> @@ -38,3 +39,8 @@ void rust_helper_udelay(unsigned long usec)
>>>>>>  {
>>>>>>  	udelay(usec);
>>>>>>  }
>>>>>> +
>>>>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>>>>>> +{
>>>>>> +	return timer->node.expires;
>>>>>> +}
>>>>>
>>>>> Sorry, of course this should be:
>>>>>
>>>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>>>>> +{
>>>>> +	return hrtimer_get_expires(timer);
>>>>> +}
>>>>>
>>>>
>>>> This is a potentially racy read. As far as I recall, we determined that
>>>> using read_once is the proper way to handle the situation.
>>>>
>>>> I do not think it makes a difference that the read is done by C code.
>>>
>>> What does "racy read" mean here?
>>>
>>> The C side doesn't use WRITE_ONCE() or READ_ONCE for node.expires. How
>>> would using READ_ONCE() on the Rust side make a difference?
>>
>> Data races like this are UB in Rust. As far as I understand, using this
>> READ_ONCE implementation or a relaxed atomic read would make the read
>> well defined. I am not aware if this is only the case if all writes to
>> the location from C also use atomic operations or WRITE_ONCE. @Boqun?
>
> The C side updates node.expires without WRITE_ONCE()/atomics so a
> Rust-side READ_ONCE() can still observe a torn value; I think that
> this is still a data race / UB from Rust's perspective.
>
> And since expires is 64-bit, WRITE_ONCE() on 32-bit architectures does
> not inherently guarantee tear-free stores either.
>
> I think that the expires() method should follow the same safety
> requirements as raw_forward(): it should only be considered safe when
> holding exclusive access to hrtimer or within the context of the timer
> callback. Under those conditions, it would be fine to call C's
> hrtimer_get_expires().

We can make it safe, please see my comment here [1].

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/r/87v7hdh9m4.fsf@t14s.mail-host-address-is-not-set


