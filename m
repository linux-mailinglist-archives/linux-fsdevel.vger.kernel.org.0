Return-Path: <linux-fsdevel+bounces-72302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2676ECECD54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 06:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E3923001032
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 05:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8FE23D2B1;
	Thu,  1 Jan 2026 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjG6fn5c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F311DF755
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jan 2026 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767246964; cv=none; b=JoNnb/0x1Km13vW0jF3mLAAAKsKOTA9Ucbl/dES3TXhfARm7O9KXA5e0R9OgIuDp9FHZqTOjbdOTtMowG5h+N55atMn+s9h6gNsOI/g6k/UJgXTF1xt4kKWN3c6gYUMmW5u51zPJG6KBqRU/0hTifY+rLBlA952ya6TVY3P+rEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767246964; c=relaxed/simple;
	bh=zqVpYWQdHro+3wRtiOZg0xhuqehIzGXgU+1aXUuukAg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MvFAz9SEkSSOAYOZaZeljW6L8GM1E/VxYgDuLmKt4MzXLObX8aOIJcUH8ArpYzfN/8RdzD3TEP3HyVzr7Kkt6zzEBXNs5RgQUK2/RglODYq2T+GnPNoWVRSNlPD/pO8EuIprBJb5yPbTpZTn2isPRzXz5BiGBWhI6yIBrShea5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjG6fn5c; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5deb0b2f685so8627593137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 21:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767246962; x=1767851762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ndBc6CJ1CpfHe+6bNbyAqigINCzeTpSLc2ByqKZUc4=;
        b=GjG6fn5chKYEsI2XHveuaxMUS9LqPWdmgP/qxkkIrBMNRPlodvbt95elV8ZkjbltfG
         mweFzUiGwHfzjoF/dprEVF3O/LDQYQEfEnD2zatoqW2WdPgaNvbBGSae1n5LCcZ3zKm0
         Rr5te3QTB1Tbbg+/pss251hu6FF89RcB7Ro5j5dr50StziLU4w4aQQXbqGS3ZLnhG6Cp
         d4XmjsA9cGXzrsbtHr0AMhZJW0U6fxyjQeg188EZ2DQ9E+01XJLOmsbtBSevZDJNrHgr
         mIPpJ+Frc9xrYA4zVetRRaaSeH7IZddyFED5PcU4pY0rsrbqInCwqPGWQ+MSDfBgdtKX
         XLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767246962; x=1767851762;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ndBc6CJ1CpfHe+6bNbyAqigINCzeTpSLc2ByqKZUc4=;
        b=e0KgOJzF1D87tiYLFXYZUDHRb8AppzjADfDu6mlEIQi1Sibob958/GFHEaynk3kKUE
         +nmyS2rK37OFrxPFxrzhjUk1oIPhNTPbeE465AGA65qX7bFwnwCUeNIY1ba0/lPlwght
         CyiH3RwPDD8nLmnmXj78qB31tnqmrFneFh4MJr1zunP/5nIBnxtQso4TaTdbIcdSlKSc
         d59zLqEAbAMZLB3gtQrhFG48vMZWO76QdOG2HOKUN3hmgRqbinDEJth82DGjtdoT4nrh
         +YWAor6TMR+ry2F4WzLNTNpr8vUiNi1TfcmWF2EyJZKt02geVuudZI2CgPe2L2Kk57Sk
         o00w==
X-Forwarded-Encrypted: i=1; AJvYcCXFvm+I2/uuU1nz+cSGQKjDCrENS99tSUdiXLr/ucV8Y/MTpwGAHrzNY17F1fMVSYYd4SdHUbPltczuP4UN@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLdl+4b9J3Qi/axOugZ5D2xboi3UfhUUy895dNOxy+NU5/UmO
	O0xq56b3V1t8uBieYX+KDUxR4T7N4vay/hUdbM03shKckoM+tecsjoWxsHK3kg==
X-Gm-Gg: AY/fxX5QOmZpDTKVMEL9bN7VWFEXYGfNgMAqao3GKpIdtzPDoKSyhVuoC8AMYtDJtYS
	5ruTQDh7eq5X19/PEGccBGBcH3B5RCsd8bbCzuYUO12h+eUjYJrSUnzXh1Cs1uj3owgM/RN9XDy
	YcFQpJNJbx0hU9LkSS0B0ANKry1UEyGQcbdX31KJDEv9kSgUqCbHOctKQFKfHjvKL5OSihwVy+2
	okxrQqLD9rKkmUHM4V4oplHbUCZ91b13YmUIBqOl/Knz1N9J30AbRpx3vU7nr7u5/cjAJRliT0V
	hrAXN7OeOuA3krsbgop+61cUJrj9vvSMlwTufQQAQhjx+A/uBaMUe1IVn33WWu574sPqViPZ5Ss
	+C+/d1lKWNDR06OB347thsz4Q7Eteb6Z0jy36mWSLzRQ832Fx1Qp2ZdZCUdqBKMoIe00lh3zN9S
	lMJG+CpC4MqSv2zETAAeelhiOtTUTW6qNsG+aqy31qU8yekubev+2c3WWxEO8J9bouDR2f8zKyJ
	0ixDA==
X-Google-Smtp-Source: AGHT+IGPae3Q8jZNEse2CMCocxuwZFX5WX9+VfZ7NrPzlgaKICCczFjJjW7e1gwGah3gbqw68yccoA==
X-Received: by 2002:a17:902:ecc5:b0:2a0:e7e0:1d31 with SMTP id d9443c01a7336-2a2caab9181mr464445655ad.11.1767240030084;
        Wed, 31 Dec 2025 20:00:30 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c65d66sm334482605ad.20.2025.12.31.20.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 20:00:29 -0800 (PST)
Date: Thu, 01 Jan 2026 13:00:12 +0900 (JST)
Message-Id: <20260101.130012.2122315449079707392.fujita.tomonori@gmail.com>
To: fujita.tomonori@gmail.com
Cc: aliceryhl@google.com, lyude@redhat.com, a.hindborg@kernel.org,
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
In-Reply-To: <20260101.111123.1233018024195968460.fujita.tomonori@gmail.com>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
	<20251231-rwonce-v1-4-702a10b85278@google.com>
	<20260101.111123.1233018024195968460.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 01 Jan 2026 11:11:23 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Wed, 31 Dec 2025 12:22:28 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
>> Using `READ_ONCE` is the correct way to read the `node.expires` field.
>> 
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>>  rust/kernel/time/hrtimer.rs | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>> 
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index 856d2d929a00892dc8eaec63cebdf547817953d3..e2b7a26f8aade972356c3eb5f6489bcda3e2e849 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -239,11 +239,9 @@ pub fn expires(&self) -> HrTimerInstant<T>
>>          // - Timers cannot have negative ktime_t values as their expiration time.
>>          // - There's no actual locking here, a racy read is fine and expected
>>          unsafe {
>> -            Instant::from_ktime(
>> -                // This `read_volatile` is intended to correspond to a READ_ONCE call.
>> -                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
>> -                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
>> -            )
>> +            Instant::from_ktime(kernel::sync::READ_ONCE(
>> +                &raw const (*c_timer_ptr).node.expires,
>> +            ))
>>          }
> 
> Do we actually need READ_ONCE() here? I'm not sure but would it be
> better to call the C-side API?
> 
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> index 67a36ccc3ec4..73162dea2a29 100644
> --- a/rust/helpers/time.c
> +++ b/rust/helpers/time.c
> @@ -2,6 +2,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/ktime.h>
> +#include <linux/hrtimer.h>
>  #include <linux/timekeeping.h>
>  
>  void rust_helper_fsleep(unsigned long usecs)
> @@ -38,3 +39,8 @@ void rust_helper_udelay(unsigned long usec)
>  {
>  	udelay(usec);
>  }
> +
> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
> +{
> +	return timer->node.expires;
> +}

Sorry, of course this should be:

+__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
+{
+	return hrtimer_get_expires(timer);
+}

> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index 856d2d929a00..61e656a65216 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -237,14 +237,7 @@ pub fn expires(&self) -> HrTimerInstant<T>
>  
>          // SAFETY:
>          // - Timers cannot have negative ktime_t values as their expiration time.
> -        // - There's no actual locking here, a racy read is fine and expected
> -        unsafe {
> -            Instant::from_ktime(
> -                // This `read_volatile` is intended to correspond to a READ_ONCE call.
> -                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
> -                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
> -            )
> -        }
> +        unsafe { Instant::from_ktime(bindings::hrtimer_get_expires(c_timer_ptr)) }
>      }
>  }
>  
> 

