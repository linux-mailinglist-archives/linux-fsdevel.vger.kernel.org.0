Return-Path: <linux-fsdevel+bounces-72516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B8DCF8F11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 16:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2C6030060FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A42F33344A;
	Tue,  6 Jan 2026 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npFFM1G1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D59332ECD
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711736; cv=none; b=Bodeyv478w8Qnb2ft3v+1hq9E2rDIc0HwF3iVnLJ0bt7iahEXkL6eMRCNUNM9n5w7W+UUZzpyON15VEL3q4SrhNwTu9c/YdL3bgGftSByuj17W6oTL0gvtdTpAN0U6sZrkppAsDSXVcDFodmsc+VzzrOv/ZYvNXDin9qQDqbVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711736; c=relaxed/simple;
	bh=25iRmSFuwL+D8roq4uypOGpDklg8NTNbR1SXb2hshR4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ODtCtbN4Uipd1r2TXLw3+Sj+wn3w0Z51AjKPs4nb95+Iy9Xn4ywdjdRqSaANmMwCo4854++qQwTxKlL8wk/djflzaKhusrNmSItz06ZcuNANB3Uay2BN14aDLQzQqRiADAhQ+G820Hvk04ZUdCNU+EDOpHAGTEYbsEWrPIhz6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npFFM1G1; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3ec96ee3dabso745681fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 07:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711734; x=1768316534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKsffwDmTb+4r5jC/ROuThttSG8MjIGG/prpPNSIElc=;
        b=npFFM1G1fI/u8e1CnEz0z2QU7wkaHKabUdi8VcjsafQYLPTo+4y1boEoI5ajemUIOV
         mMNF5WFWoMsC+3sfM8Jef0PpGjR1OaXsZMalL7I0kcTG/2MzImQ/4UeCgjuyWETm3KER
         uBj9Dbdfpo6Ujwo97SIKp/13sb/Ebbn3h0A9VGHdvl5/5r0KNwX47r/UunZcFJn4LXRb
         QxujxhWoDDyeTZnnJEiR1qHjcnY479hEigOueUJ6sQJPUOHE78yFipCUiwaJozNLDimB
         5Ue82LfxHa8IrJLVaXkO/KFB6jGZMR7uQYhC4mW1U18A5n3JeyDOYJfDVqOWf8qak8ke
         rE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711734; x=1768316534;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKsffwDmTb+4r5jC/ROuThttSG8MjIGG/prpPNSIElc=;
        b=i+VrzglzlMqSCF5bwiEFvrSvhF7cJaYQJ547Hui1w9LIO3e8XUsyyE0q9qVYPre9h5
         wC9v4QfKVCtbZI9ryAYUwSbkv+0+Cw1XyggRi2ZynAfi0dCEyeptONIKVuXThoobipZS
         zEyyMwYyOjSmjQ/k5+IyBcEdDTF5Aq2xPMR8iy5TdSIcMtUEYKHFBD1pmjYU8yuE+mi/
         SDTmAZZfQzudrY83BhCr1r/ZHkG9/49RJkVERcdIesIDwqZ8JoIzAgtLHnJB3oLEt2GQ
         uxmWM+xfae70T+FpyngDvcdiDS5NVhdxCqxJDA/LDzkVXtKjeSKDP/ZIP8Ubdd4JwmTt
         Uqkw==
X-Forwarded-Encrypted: i=1; AJvYcCVStQDBfLpl+ujPnYaw4o/0PnXYMlsEyQxKptlbj3FsP7AjqHmZOxEsQh2AWo1zjdvLa29YcxSNyn9wYjA9@vger.kernel.org
X-Gm-Message-State: AOJu0YxrSFb7mL+6B9N2VThhyAZbvhq/ByMdFapPQsKPUpZH4qdMpQCh
	hlvNDzvzXvkxQ+ec/Lee87zRS5n2vosZg2TUny5YtNAuXTO1XXltlhEVZNIZag==
X-Gm-Gg: AY/fxX6lOQq+jYpceJnuEdTlzy8/LKW2GLEKikE0ho1i/gZqRrCB6f/Nit6UmcibHrp
	E7zbcJsuW9kGpE59HS1em2XgDom28dwQj5lGFXNHlVp0NXCpIoW3qQAWMk85TeMciYqzPYxyJRM
	cRhotO8XBS3+8rC+LSvfP0xP1uCUcpyz2i3Xbj0BDdBmbrm+s5Zbxig0eJzuk7XgEO+rK10wecG
	B5Qi9N5Wy+JI4Uofb+hAePN6fkbTOb9lu42N0ZGC1TF+IWh8fbup6liZUsMEsioBRIAQVZP9sjg
	ih/sH0SpzmdrwNnGOkxKt+dvcriSJfaC9vtv+KHrKuni5m9HRE06/zB1IikxeOZzy220w3qJ8RY
	ho+xFlCygWTcL+RH5LMhAC6cb5SctqBATkFqnegvXISlbTdlmXzDIke4I7CdYAd+NGwtfo/ljAR
	Wj86FHZ0goRV8uHFEXu7t8MFQr8+5EaPZ9b1IPwn6GCQXi1TD+xinzdly3/Xx3VZru/fM=
X-Google-Smtp-Source: AGHT+IH/kVjMXJLsPqWXcn8kSZ3ELVQYHHdFG6UtOJC68eA3mthYgJwMef8DW8mEX3Opv7mL8wv7Fw==
X-Received: by 2002:a17:90a:c888:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-34f5f35d5e2mr2098780a91.36.1767706121439;
        Tue, 06 Jan 2026 05:28:41 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7b19ebsm2356135a91.3.2026.01.06.05.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 05:28:41 -0800 (PST)
Date: Tue, 06 Jan 2026 22:28:26 +0900 (JST)
Message-Id: <20260106.222826.2155269977755242640.fujita.tomonori@gmail.com>
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
In-Reply-To: <87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
References: <L2dmGLLYJbusZn9axfRubM0hIOSTuny2cW3uyUhOVGvck7lQxTzDe0Xxf8Hw2cLxICT8kdmNAE74e-LV7YrReg==@protonmail.internalid>
	<20260101.130012.2122315449079707392.fujita.tomonori@gmail.com>
	<87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 06 Jan 2026 13:37:34 +0100
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
> 
>> On Thu, 01 Jan 2026 11:11:23 +0900 (JST)
>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>>
>>> On Wed, 31 Dec 2025 12:22:28 +0000
>>> Alice Ryhl <aliceryhl@google.com> wrote:
>>>
>>>> Using `READ_ONCE` is the correct way to read the `node.expires` field.
>>>>
>>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>>> ---
>>>>  rust/kernel/time/hrtimer.rs | 8 +++-----
>>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>>> index 856d2d929a00892dc8eaec63cebdf547817953d3..e2b7a26f8aade972356c3eb5f6489bcda3e2e849 100644
>>>> --- a/rust/kernel/time/hrtimer.rs
>>>> +++ b/rust/kernel/time/hrtimer.rs
>>>> @@ -239,11 +239,9 @@ pub fn expires(&self) -> HrTimerInstant<T>
>>>>          // - Timers cannot have negative ktime_t values as their expiration time.
>>>>          // - There's no actual locking here, a racy read is fine and expected
>>>>          unsafe {
>>>> -            Instant::from_ktime(
>>>> -                // This `read_volatile` is intended to correspond to a READ_ONCE call.
>>>> -                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
>>>> -                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
>>>> -            )
>>>> +            Instant::from_ktime(kernel::sync::READ_ONCE(
>>>> +                &raw const (*c_timer_ptr).node.expires,
>>>> +            ))
>>>>          }
>>>
>>> Do we actually need READ_ONCE() here? I'm not sure but would it be
>>> better to call the C-side API?
>>>
>>> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
>>> index 67a36ccc3ec4..73162dea2a29 100644
>>> --- a/rust/helpers/time.c
>>> +++ b/rust/helpers/time.c
>>> @@ -2,6 +2,7 @@
>>>
>>>  #include <linux/delay.h>
>>>  #include <linux/ktime.h>
>>> +#include <linux/hrtimer.h>
>>>  #include <linux/timekeeping.h>
>>>
>>>  void rust_helper_fsleep(unsigned long usecs)
>>> @@ -38,3 +39,8 @@ void rust_helper_udelay(unsigned long usec)
>>>  {
>>>  	udelay(usec);
>>>  }
>>> +
>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>>> +{
>>> +	return timer->node.expires;
>>> +}
>>
>> Sorry, of course this should be:
>>
>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
>> +{
>> +	return hrtimer_get_expires(timer);
>> +}
>>
> 
> This is a potentially racy read. As far as I recall, we determined that
> using read_once is the proper way to handle the situation.
> 
> I do not think it makes a difference that the read is done by C code.

What does "racy read" mean here?

The C side doesn't use WRITE_ONCE() or READ_ONCE for node.expires. How
would using READ_ONCE() on the Rust side make a difference?


