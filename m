Return-Path: <linux-fsdevel+bounces-73038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B5BD08B12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 11:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76D99306DA9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0D339714;
	Fri,  9 Jan 2026 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/S2tX9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5FA33859E;
	Fri,  9 Jan 2026 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955370; cv=none; b=fWaewg9khZBOhDT3DEP2NlCShgVb57bHzG5f2s8rJsl1MjUs4R2MpSu0Av526Zmf8lGCj5Rw2bBdlhlA002Lzx8f3S/+pKjAOzJNQDeSrghA4atHtbb2uGwyj4+AXISLrc0Wq0gQ5v7bwPRU8VJLJxmy0Kli2QPfqoYYsWfEhGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955370; c=relaxed/simple;
	bh=ljBAA3J/WyBhweINmujp9S/1yjKDZav9rqCw5O4UKzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YFKW0TW6azD5MQglwpc6O8s/QXFrY6uFchk+OO4sqJRafxVaeps4cn4ydrewOkAj/OWG6InNdEo2LmR2LE7GZzNkKuUJdGLhL8dXlvOcw4gSb/O4ShDtXQs84hYrf6fwDDWWZ9sH1GnhmZvavmKHcFJxXLwp++oAHo/98Kd48hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/S2tX9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B7DC4CEF1;
	Fri,  9 Jan 2026 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767955369;
	bh=ljBAA3J/WyBhweINmujp9S/1yjKDZav9rqCw5O4UKzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c/S2tX9ggeLMjU5FqyBho/saF86TCn5TDETCH/P1hBLTLCv3wC3DwnkpTTGkYWdIO
	 TVIiCiCvknT0dRKfTRDcSEBo2nK045Dl9f2ngT66a+T0YzDdPdwWMwQSvmJaKiJVj6
	 2Ku4w063zO+hyzVYLRFlPV8edkFUgNUcs7Aorp2PPT5StPI8iLJYvYy8j/tm9ZH6T9
	 FovjwJWxAcMtHxT0oSB/jEI7Qh4BevciqdxY3GmQLibGYROr+ovqfOnLpimRz85Cur
	 s32o9HRbcZw6R4lWW0qv5ANPOjwYf0xyI7tKoERmEmS7ya5F13CKTJk1rqIKCBWnR2
	 FqIuA2vBp0/eQ==
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
In-Reply-To: <20260109.111025.1944772328156797586.fujita.tomonori@gmail.com>
References: <WXFPsf9COQPV_obKoZg2bYwPL3k9TT0oBL3uxNppUFaIj5hxEX9UokzS_DJ5Kg5kXDzLrZ9ihALTZcf6ehljGw==@protonmail.internalid>
 <20260107.202245.559061117523678561.fujita.tomonori@gmail.com>
 <87ms2pgu7c.fsf@t14s.mail-host-address-is-not-set>
 <WYcxbOJ1udGdyPMUA8kKkahk7Ki9WxofI4h4jLV6blPUg_G6qoUP1C7FDkD_iU7Xd34u8HCn3nURARc1roTYxg==@protonmail.internalid>
 <20260109.111025.1944772328156797586.fujita.tomonori@gmail.com>
Date: Fri, 09 Jan 2026 11:42:38 +0100
Message-ID: <87ldi7f4o1.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> On Wed, 07 Jan 2026 19:21:11 +0100
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
>>
>>> On Wed, 07 Jan 2026 11:11:43 +0100
>>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>>
>>>> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
>>>>
>>>>> On Tue, 06 Jan 2026 13:37:34 +0100
>>>>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>>>>
>>>>>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
>>>>>>
>>>>>>> On Thu, 01 Jan 2026 11:11:23 +0900 (JST)
>>>>>>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>>>>>>>
>>>>>>>> On Wed, 31 Dec 2025 12:22:28 +0000
>>>>>>>> Alice Ryhl <aliceryhl@google.com> wrote:
>>>>>>>>
>>>>>>>>> Using `READ_ONCE` is the correct way to read the `node.expires` field.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>>>>>>>> ---
>>>>>>>>>  rust/kernel/time/hrtimer.rs | 8 +++-----
>>>>>>>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>>>>>>>> index 856d2d929a00892dc8eaec63cebdf547817953d3..e2b7a26f8aade972356c3eb5f6489bcda3e2e849 100644
>>>>>>>>> --- a/rust/kernel/time/hrtimer.rs
>>>>>>>>> +++ b/rust/kernel/time/hrtimer.rs
>>>>>>>>> @@ -239,11 +239,9 @@ pub fn expires(&self) -> HrTimerInstant<T>
>>>>>>>>>          // - Timers cannot have negative ktime_t values as their expiration time.
>>>>>>>>>          // - There's no actual locking here, a racy read is fine and expected
>>>>>>>>>          unsafe {
>>>>>>>>> -            Instant::from_ktime(
>>>>>>>>> -                // This `read_volatile` is intended to correspond to a READ_ONCE call.
>>>>>>>>> -                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
>>>>>>>>> -                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
>>>>>>>>> -            )
>>>>>>>>> +            Instant::from_ktime(kernel::sync::READ_ONCE(
>>>>>>>>> +                &raw const (*c_timer_ptr).node.expires,
>>>>>>>>> +            ))
>>>>>>>>>          }
>>>>>>>>
>>>>>>>> Do we actually need READ_ONCE() here? I'm not sure but would it be
>>>>>>>> better to call the C-side API?
>>>>>>>>
>>>>>>>> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
>>>>>>>> index 67a36ccc3ec4..73162dea2a29 100644
>>>>>>>> --- a/rust/helpers/time.c
>>>>>>>> +++ b/rust/helpers/time.c
>>>>>>>> @@ -2,6 +2,7 @@
>>>>>>>>
>>>>>>>>  #include <linux/delay.h>
>>>>>>>>  #include <linux/ktime.h>
>>>>>>>> +#include <linux/hrtimer.h>
>>>>>>>>  #include <linux/timekeeping.h>
>>>>>>>>
>>>>>>>>  void rust_helper_fsleep(unsigned long usecs)
>>>>>>>> @@ -38,3 +39,8 @@ void rust_helper_udelay(unsigned long usec)
>>>>>>>>  {
>>>>>>>>  	udelay(usec);
>>>>>>>>  }
>>>>>>>> +
>>>>>>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>>>>>>>> +{
>>>>>>>> +	return timer->node.expires;
>>>>>>>> +}
>>>>>>>
>>>>>>> Sorry, of course this should be:
>>>>>>>
>>>>>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>>>>>>> +{
>>>>>>> +	return hrtimer_get_expires(timer);
>>>>>>> +}
>>>>>>>
>>>>>>
>>>>>> This is a potentially racy read. As far as I recall, we determined that
>>>>>> using read_once is the proper way to handle the situation.
>>>>>>
>>>>>> I do not think it makes a difference that the read is done by C code.
>>>>>
>>>>> What does "racy read" mean here?
>>>>>
>>>>> The C side doesn't use WRITE_ONCE() or READ_ONCE for node.expires. How
>>>>> would using READ_ONCE() on the Rust side make a difference?
>>>>
>>>> Data races like this are UB in Rust. As far as I understand, using this
>>>> READ_ONCE implementation or a relaxed atomic read would make the read
>>>> well defined. I am not aware if this is only the case if all writes to
>>>> the location from C also use atomic operations or WRITE_ONCE. @Boqun?
>>>
>>> The C side updates node.expires without WRITE_ONCE()/atomics so a
>>> Rust-side READ_ONCE() can still observe a torn value; I think that
>>> this is still a data race / UB from Rust's perspective.
>>>
>>> And since expires is 64-bit, WRITE_ONCE() on 32-bit architectures does
>>> not inherently guarantee tear-free stores either.
>>>
>>> I think that the expires() method should follow the same safety
>>> requirements as raw_forward(): it should only be considered safe when
>>> holding exclusive access to hrtimer or within the context of the timer
>>> callback. Under those conditions, it would be fine to call C's
>>> hrtimer_get_expires().
>>
>> We can make it safe, please see my comment here [1].
>>
>> Best regards,
>> Andreas Hindborg
>>
>> [1] https://lore.kernel.org/r/87v7hdh9m4.fsf@t14s.mail-host-address-is-not-set
>
> I agree. My point was that expire() can be safe only under the same
> constraints as forward()/forward_now() so the API should require
> Pin<&mut Self> and expose it on HrTimerCallbackContext.

Do you want to send a patch?


Best regards,
Andreas Hindborg



