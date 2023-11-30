Return-Path: <linux-fsdevel+bounces-4420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784E7FF652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB85B20A2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EE854FA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bqW4S8AB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D460710DE;
	Thu, 30 Nov 2023 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701356545; x=1701615745;
	bh=uo2vqq/xcRDYM6o4gUKdCIhET5kcnBqayNRuV/1IFZY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bqW4S8ABCR3oUPVl1gnYRytnSkn8znO+ZjOvjkZXuN3fewQK/9el9fndFgKOY0Igh
	 soPaRM72dS+exH3qAMUp+teBMOiNFRjfzKtEBHMtD8f5BLG/FteB8PhalP+zdGE+Xz
	 cZkPHR5xpZeIUitKd3zrO9biSOIfu5xp8cdyLuqGKn4WpXH9zhOi/7HocLwu7wCItW
	 pbvA+B7SwXq57f0QQnePsuJKy3CVaxM391XEEtzi1kEpxmwZrGwiESzZMeI4CgtMn5
	 AoYsbTT2ZY/DbpwIdDEgGmpixtghJGotnDrmsukaH9atODdyP5gMsclqLBHVr8QMmg
	 K0fyn3KHoVRjQ==
Date: Thu, 30 Nov 2023 15:02:06 +0000
To: Matthew Wilcox <willy@infradead.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <gCUdcb9uUpv_4hv0AbhQ4V8q5t25Aia9QWHVS8rRmqi7sQHWKSY2ucSiYBmnej98lEWs3WB2oumjDts9reSos9UFkxxBWlAGUsJn51pXRaQ=@proton.me>
In-Reply-To: <ZWdVEk4QjbpTfnbn@casper.infradead.org>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-1-f81afe8c7261@google.com> <ZWdVEk4QjbpTfnbn@casper.infradead.org>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/29/23 16:13, Matthew Wilcox wrote:
> On Wed, Nov 29, 2023 at 12:51:07PM +0000, Alice Ryhl wrote:
>> This introduces a struct for the EBADF error type, rather than just
>> using the Error type directly. This has two advantages:
>> * `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
>>   compiler will represent as a single pointer, with null being an error.
>>   This is possible because the compiler understands that `BadFdError`
>>   has only one possible value, and it also understands that the
>>   `ARef<File>` smart pointer is guaranteed non-null.
>> * Additionally, we promise to users of the method that the method can
>>   only fail with EBADF, which means that they can rely on this promise
>>   without having to inspect its implementation.
>> That said, there are also two disadvantages:
>> * Defining additional error types involves boilerplate.
>> * The question mark operator will only utilize the `From` trait once,
>>   which prevents you from using the question mark operator on
>>   `BadFdError` in methods that return some third error type that the
>>   kernel `Error` is convertible into. (However, it works fine in methods
>>   that return `Error`.)
>=20
> I haven't looked at how Rust-for-Linux handles errors yet, but it's
> disappointing to see that it doesn't do something like the PTR_ERR /
> ERR_PTR / IS_ERR C thing under the hood.

In this case we are actually doing that: `ARef<T>` is a non-null pointer
to a `T` and since `BadFdError` is a unit struct (i.e. there exists only
a single value it can take) `Result<ARef<T>, BadFdError>` has the same
size as a pointer. This is because the Rust compiler represents the
`Err` variant as null.

We also do have support for `ERR_PTR`, but that requires `unsafe`, since
we do not know which kind of pointer the C side returned (was it an
`ARef<T>`, `&mut T`, `&T` etc.?) and can therefore only support `*mut T`.

--=20
Cheers,
Benno

