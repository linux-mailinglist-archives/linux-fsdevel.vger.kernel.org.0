Return-Path: <linux-fsdevel+bounces-72486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB6FCF8605
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 13:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4461D3030933
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F53329E53;
	Tue,  6 Jan 2026 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REzzIMiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6F256D;
	Tue,  6 Jan 2026 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767703071; cv=none; b=c/S5YR99APNzPwhu35tL2u2PiUXcgOW5S4DnlY9BUvgU2f1QlsRpdYQN/C1dIJvv5kItZv35hbIhNcd1dvUZ3FO8IXF/aZ8GH4MX+fwEpjeU/VQbx+BubgudG1T9MEGYL19v2EQ7OrYjVdXQNuqYBl3WoWxuVy/Ojv9q7z8FVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767703071; c=relaxed/simple;
	bh=hm9zTszigCDx9gXEHsPwQEmbW0HRLieX7v57e0V8bhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TuymiDMaESpoz7XyVGwEuwqOKblF8a1ivYv0XQFAxEhy2MciKSamctsTM68KnI6l7EH893vqFADYoJxNO8CC88o8Pr4oeYzwkZWSohUa2V+7sbdQbF7OpuvkTw+RvDIDmhOAmiLdLAFONIARuWONJRjyPph7z80/cLGuqHZYSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REzzIMiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A41C116C6;
	Tue,  6 Jan 2026 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767703070;
	bh=hm9zTszigCDx9gXEHsPwQEmbW0HRLieX7v57e0V8bhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=REzzIMiHLlAJ8/yX7SNtNUN34UI9sPJRaGpdk92DO+zLYJno2Yi7Pd4gD6O6eNRke
	 7aVNJxQGRk0pFIgebjhJZgYpA/yxeQG7V10i16poDvU0Y0JORkJLC0VHoEQyZYvJbn
	 Qs62maLF3+GbGq5mvC5TOyQx6hf7IaZtCtDL0GzQPoNYbZqwhl+9y7WGtaka52XZdW
	 7uMM5+OAhmjqspJ0AJXxpXtN/vjJUFi7K5oKqGB9K4XYM1g7amRHfipjlQAqgZdBi0
	 akH2hyYQFnXFyOAYlWAnkREJmQ92SKxUHavk2gbwuiX10Wc3Ibm3ymXS+cC8iKU3VZ
	 RU/xEGefwO3KQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, fujita.tomonori@gmail.com
Cc: aliceryhl@google.com, lyude@redhat.com, boqun.feng@gmail.com,
 will@kernel.org, peterz@infradead.org, richard.henderson@linaro.org,
 mattst88@gmail.com, linmag7@gmail.com, catalin.marinas@arm.com,
 ojeda@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, tmgross@umich.edu, dakr@kernel.org,
 mark.rutland@arm.com, frederic@kernel.org, tglx@linutronix.de,
 anna-maria@linutronix.de, jstultz@google.com, sboyd@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] rust: hrtimer: use READ_ONCE instead of read_volatile
In-Reply-To: <20260101.130012.2122315449079707392.fujita.tomonori@gmail.com>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231-rwonce-v1-4-702a10b85278@google.com>
 <20260101.111123.1233018024195968460.fujita.tomonori@gmail.com>
 <L2dmGLLYJbusZn9axfRubM0hIOSTuny2cW3uyUhOVGvck7lQxTzDe0Xxf8Hw2cLxICT8kdmNAE74e-LV7YrReg==@protonmail.internalid>
 <20260101.130012.2122315449079707392.fujita.tomonori@gmail.com>
Date: Tue, 06 Jan 2026 13:37:34 +0100
Message-ID: <87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> On Thu, 01 Jan 2026 11:11:23 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>
>> On Wed, 31 Dec 2025 12:22:28 +0000
>> Alice Ryhl <aliceryhl@google.com> wrote:
>>
>>> Using `READ_ONCE` is the correct way to read the `node.expires` field.
>>>
>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>> ---
>>>  rust/kernel/time/hrtimer.rs | 8 +++-----
>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>> index 856d2d929a00892dc8eaec63cebdf547817953d3..e2b7a26f8aade972356c3eb5f6489bcda3e2e849 100644
>>> --- a/rust/kernel/time/hrtimer.rs
>>> +++ b/rust/kernel/time/hrtimer.rs
>>> @@ -239,11 +239,9 @@ pub fn expires(&self) -> HrTimerInstant<T>
>>>          // - Timers cannot have negative ktime_t values as their expiration time.
>>>          // - There's no actual locking here, a racy read is fine and expected
>>>          unsafe {
>>> -            Instant::from_ktime(
>>> -                // This `read_volatile` is intended to correspond to a READ_ONCE call.
>>> -                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
>>> -                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
>>> -            )
>>> +            Instant::from_ktime(kernel::sync::READ_ONCE(
>>> +                &raw const (*c_timer_ptr).node.expires,
>>> +            ))
>>>          }
>>
>> Do we actually need READ_ONCE() here? I'm not sure but would it be
>> better to call the C-side API?
>>
>> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
>> index 67a36ccc3ec4..73162dea2a29 100644
>> --- a/rust/helpers/time.c
>> +++ b/rust/helpers/time.c
>> @@ -2,6 +2,7 @@
>>
>>  #include <linux/delay.h>
>>  #include <linux/ktime.h>
>> +#include <linux/hrtimer.h>
>>  #include <linux/timekeeping.h>
>>
>>  void rust_helper_fsleep(unsigned long usecs)
>> @@ -38,3 +39,8 @@ void rust_helper_udelay(unsigned long usec)
>>  {
>>  	udelay(usec);
>>  }
>> +
>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>> +{
>> +	return timer->node.expires;
>> +}
>
> Sorry, of course this should be:
>
> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
> +{
> +	return hrtimer_get_expires(timer);
> +}
>

This is a potentially racy read. As far as I recall, we determined that
using read_once is the proper way to handle the situation.

I do not think it makes a difference that the read is done by C code.


Best regards,
Andreas Hindborg


