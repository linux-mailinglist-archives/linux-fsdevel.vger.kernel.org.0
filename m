Return-Path: <linux-fsdevel+bounces-4435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6E67FF672
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD9E1C20A1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425DF54FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FHTSlkLE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788B21A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=wb54kawzqrdgfcottrby6ge5au.protonmail; t=1701360799; x=1701619999;
	bh=sHSho2UpIOsMXx/tNC0gKMiBZVwFgRqI0HuIM+NLNeU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FHTSlkLEEUoJOyvs0Dd1pevPUNZob0se01kjNg9TYbJpNtO5B8VkDE6unM5VSEpTB
	 56zb7dVbQIMJRiyJSnKEEKEcjlUDwuBD28Vw4lx49R5NEcjYdsEUcTFXwxru1YSnd3
	 +taMKqNFYQGIjFOg2jdc7Bej7MYzVvvUwQvFQoE0DV0Sr4eMfvwLyWQk83PVEqtlSM
	 NO6xYVaf0KKuepA77A6wiLMA87EjTEkb7OYRtE15vQn6KuMXzo0VjcfkuKfhRLk68s
	 kd21+x1l0vGuQFkQgQ0jhb8qFHEiuKoobMnxxrcVIGokS+rlAK99tfZAoN5PalkmCL
	 jiGZEYQlhkbzQ==
Date: Thu, 30 Nov 2023 16:12:14 +0000
To: Theodore Ts'o <tytso@mit.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <25TYokAJ6urAw9GygDDgCcp2mDZT42AF6l8v_u5y-0XZONnHa9kr4Tz_zh30URNuaT-8Q0JnTXgZqeAiinxPEZqzS8StBKyjizZ9e5mysS8=@proton.me>
In-Reply-To: <20231130155846.GA534667@mit.edu>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-1-f81afe8c7261@google.com> <ksVe7fwt0AVWlCOtxIOb-g34okhYeBQUiXvpWLvqfxcyWXXuUuwWEIhUHigcAXJDFRCDr8drPYD1O1VTrDhaeZQ5mVxjCJqT32-2gHozHIo=@proton.me> <2023113041-bring-vagrancy-a417@gregkh> <2gTL0hxPpSCcVa7uvDLOLcjqd_sgtacZ_6XWaEANBH9Gnz72M1JDmjcWNO9Z7UbIeWNoNqx8y-lb3MAq75pEXL6EQEIED0XLxuHvqaQ9K-g=@proton.me> <20231130155846.GA534667@mit.edu>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/30/23 16:58, Theodore Ts'o wrote:
> On Thu, Nov 30, 2023 at 03:46:55PM +0000, Benno Lossin wrote:
>>>>> +    pub const O_APPEND: u32 =3D bindings::O_APPEND;
>>>>
>>>> Why do all of these constants begin with `O_`?
>>>
>>> Because that is how they are defined in the kernel in the C code.  Why
>>> would they not be the same here?
>>
>> Then why does the C side name them that way? Is it because `O_*` is
>> supposed to mean something, or is it done due to namespacing?
>=20
> It's because these sets of constants were flags passed to the open(2)
> system call, and so they are dictated by the POSIX specification.  So
> O_ means that they are a set of integer values which are used by
> open(2), and they are defined when userspace #include's the fcntl.h
> header file.  One could consider it be namespacing --- we need to
> distinguish these from other constants: MAY_APPEND, RWF_APPEND,
> ESCAPE_APPEND, STATX_ATTR_APPEND, BTRFS_INODE_APPEND.
>=20
> But it's also a convention that dates back for ***decades*** and if we
> want code to be understandable by kernel programmers, we need to obey
> standard kernel naming conventions.

I see, that makes a lot of sense. Thanks for the explanation.

>> In Rust we have namespacing, so we generally drop common prefixes.
>=20
> I don't know about Rust namespacing, but in other languages, how you
> have to especify namespaces tend to be ***far*** more verbose than
> just adding an O_ prefix.

In this case we already have the `flags` namespace, so I thought about
just dropping the `O_` prefix altogether.

--=20
Cheers,
Benno

