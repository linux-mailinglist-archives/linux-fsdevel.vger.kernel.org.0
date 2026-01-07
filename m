Return-Path: <linux-fsdevel+bounces-72605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D4CFD2CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 11:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0C6F305F83A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8483A32ED34;
	Wed,  7 Jan 2026 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBursUu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7532E730;
	Wed,  7 Jan 2026 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780716; cv=none; b=S/UQJR4zS0Ta2obtlyyz1k2USRHM+lWmyrz1Ri/jc+iQ8t5hHRM//gXUVoYk+HLWZmb4uC6qp8OYRbgBuwTG+ev0NoDOF1ZsJMSf5BNS9/0457hD/YO14BktnYTrt+PVYgZ1G1OrNS8yLsyX19Jzu3wAnvAhr4az/pzxvFsQYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780716; c=relaxed/simple;
	bh=089y2IDoSCjwqehlq3MO4nDE6Ee9AOzoaarffxPZP/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bNZtTtCVRkdcSJ7pdpSeS9EgcbBGs/Yj5UICKE520qFL/HvP3R8XVJeitJnk/PKOseztE5jcxMQo35dUwPvRxVBVuUYlzzF8IIj+XmoiLQmAM33hlzFUMvIdKYM5mcKF6T5iRIFgY/0/S72GXUzlSPG0E0UpPsZrVCpX/7Qv1P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBursUu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0F1C4CEF7;
	Wed,  7 Jan 2026 10:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767780715;
	bh=089y2IDoSCjwqehlq3MO4nDE6Ee9AOzoaarffxPZP/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YBursUu1NUOpLsViKALRQCFu+cSwuV4OxKTINf6fkb6mUbGc6nvmhTWHuh6spFkzE
	 INghZ7oIQgn06bdINirmASKob38X3/FQsHUos8z/Xn7bcthvscIJcqUbPb3+FjL+/U
	 3E0fqmhrcfTO4rKTfv3QtJ1pWum/y/w2qVsra9MuD5zoB4rtYP8x1nFK6NOwu5If1Z
	 653EBTSVQm8E2YTO/WNT33ONMhyv8e2vPKCOryv86s6+Ui7EaThW7NvnjO40Mq30Mg
	 RDQLbFljrB5dGEyE5k0viEwo1r1OMiZ91h+5c1rSEtbeaKWG7VRciDGTveaSCpCJ+T
	 IGfPZNStfJXeA==
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
In-Reply-To: <20260106.222826.2155269977755242640.fujita.tomonori@gmail.com>
References: <L2dmGLLYJbusZn9axfRubM0hIOSTuny2cW3uyUhOVGvck7lQxTzDe0Xxf8Hw2cLxICT8kdmNAE74e-LV7YrReg==@protonmail.internalid>
 <20260101.130012.2122315449079707392.fujita.tomonori@gmail.com>
 <87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
 <20260106.222826.2155269977755242640.fujita.tomonori@gmail.com>
Date: Wed, 07 Jan 2026 11:11:43 +0100
Message-ID: <87cy3livfk.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> On Tue, 06 Jan 2026 13:37:34 +0100
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
>> 
>>> On Thu, 01 Jan 2026 11:11:23 +0900 (JST)
>>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>>>
>>>> On Wed, 31 Dec 2025 12:22:28 +0000
>>>> Alice Ryhl <aliceryhl@google.com> wrote:
>>>>
>>>>> Using `READ_ONCE` is the correct way to read the `node.expires` field.
>>>>>
>>>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>>>> ---
>>>>>  rust/kernel/time/hrtimer.rs | 8 +++-----
>>>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>>>> index 856d2d929a00892dc8eaec63cebdf547817953d3..e2b7a26f8aade972356c3eb5f6489bcda3e2e849 100644
>>>>> --- a/rust/kernel/time/hrtimer.rs
>>>>> +++ b/rust/kernel/time/hrtimer.rs
>>>>> @@ -239,11 +239,9 @@ pub fn expires(&self) -> HrTimerInstant<T>
>>>>>          // - Timers cannot have negative ktime_t values as their expiration time.
>>>>>          // - There's no actual locking here, a racy read is fine and expected
>>>>>          unsafe {
>>>>> -            Instant::from_ktime(
>>>>> -                // This `read_volatile` is intended to correspond to a READ_ONCE call.
>>>>> -                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
>>>>> -                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
>>>>> -            )
>>>>> +            Instant::from_ktime(kernel::sync::READ_ONCE(
>>>>> +                &raw const (*c_timer_ptr).node.expires,
>>>>> +            ))
>>>>>          }
>>>>
>>>> Do we actually need READ_ONCE() here? I'm not sure but would it be
>>>> better to call the C-side API?
>>>>
>>>> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
>>>> index 67a36ccc3ec4..73162dea2a29 100644
>>>> --- a/rust/helpers/time.c
>>>> +++ b/rust/helpers/time.c
>>>> @@ -2,6 +2,7 @@
>>>>
>>>>  #include <linux/delay.h>
>>>>  #include <linux/ktime.h>
>>>> +#include <linux/hrtimer.h>
>>>>  #include <linux/timekeeping.h>
>>>>
>>>>  void rust_helper_fsleep(unsigned long usecs)
>>>> @@ -38,3 +39,8 @@ void rust_helper_udelay(unsigned long usec)
>>>>  {
>>>>  	udelay(usec);
>>>>  }
>>>> +
>>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>>>> +{
>>>> +	return timer->node.expires;
>>>> +}
>>>
>>> Sorry, of course this should be:
>>>
>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>>> +{
>>> +	return hrtimer_get_expires(timer);
>>> +}
>>>
>> 
>> This is a potentially racy read. As far as I recall, we determined that
>> using read_once is the proper way to handle the situation.
>> 
>> I do not think it makes a difference that the read is done by C code.
>
> What does "racy read" mean here?
>
> The C side doesn't use WRITE_ONCE() or READ_ONCE for node.expires. How
> would using READ_ONCE() on the Rust side make a difference?

Data races like this are UB in Rust. As far as I understand, using this
READ_ONCE implementation or a relaxed atomic read would make the read
well defined. I am not aware if this is only the case if all writes to
the location from C also use atomic operations or WRITE_ONCE. @Boqun?


Best regards,
Andreas Hindborg



