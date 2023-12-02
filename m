Return-Path: <linux-fsdevel+bounces-4680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A83801C35
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE1E1C208FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89824168A4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ICKWZrBO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC1BF1;
	Sat,  2 Dec 2023 02:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701512213; x=1701771413;
	bh=EUYoWzRb2VtFg0qFU9eJFRQEz1z2lKS3+4nXPhxD9cc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ICKWZrBOiGZPy9i9e5mo+Xc0KA0Pgfj8HHU9nqvqiwdvXZAxbLc4NwpLv8IDz86Od
	 Sd+6gz0BfDUaC/V/rFYJ8WMmaqjLbg0dS7eus4ygZDQdugCkiK25SiMJcp8NXudLfs
	 5XKpsTTuloyw+ryvqsNjLAHNZpSA6WDshKGfMefYMF0ExT7ichsjE+IwBNMYEqsTSY
	 5YsX/soqXn6/LhJU1kbnWHArxDOmXKRTCt3G9yTeP1R0CcdhzsztDStDX+XUDPhoVm
	 UzK5zs/bwI38TYvNYq8LvVwvcLE+5+h4PHD9a9pULzylc31agMoZUskJWrqjH+fGLI
	 eIDK4+9uEiYsA==
Date: Sat, 02 Dec 2023 10:16:36 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 6/7] rust: file: add `DeferredFdCloser`
Message-ID: <bUU6jGtJ7KdkuVp8UPORb0cmDoU6sRjc1iVRMfgO34u5ySo44Z5MXrnYgE6pfQDFu4-V5CBAuhS8uZDoEA6CsIiLUiWJedNZ2CTf9cRATfQ=@proton.me>
In-Reply-To: <20231201113538.2202170-1-aliceryhl@google.com>
References: <LNSA8EeuwLGDBzY1W8GaP1L6gucAPE_34myHWuyg3ziYuheiFLk3WfVBPppzwDZwoGVTCqL8EBjAaxsNshTY6AQq_sNtK9hmea7FeaNJuCo=@proton.me> <20231201113538.2202170-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/1/23 12:35, Alice Ryhl wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>>> +        // SAFETY: The `inner` pointer points at a valid and fully ini=
tialized task work that is
>>> +        // ready to be scheduled.
>>> +        unsafe { bindings::task_work_add(current, inner, TWA_RESUME) }=
;
>>
>> I am a bit confused, when does `do_close_fd` actually run? Does
>> `TWA_RESUME` mean that `inner` is scheduled to run after the current
>> task has been completed?
>=20
> When the current syscall returns to userspace.

What happens when I use `DeferredFdCloser` outside of a syscall? Will
it never run? Maybe add some documentation about that?

>>> +    // SAFETY: This function is an implementation detail of `close_fd`=
, so its safety comments
>>> +    // should be read in extension of that method.
>>> +    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_he=
ad) {
>>> +        // SAFETY: In `close_fd` we use this method together with a po=
inter that originates from a
>>> +        // `Box<DeferredFdCloserInner>`, and we have just been given o=
wnership of that allocation.
>>> +        let inner =3D unsafe { Box::from_raw(inner as *mut DeferredFdC=
loserInner) };
>>
>> In order for this call to be sound, `inner` must be an exclusive
>> pointer (including any possible references into the `callback_head`).
>> Is this the case?
>=20
> Yes, when this is called, it's been removed from the linked list of task
> work. That's why we can kfree it.

Please add this to the SAFETY comment.

--=20
Cheers,
Benno

