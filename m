Return-Path: <linux-fsdevel+bounces-5307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C43380A12A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 11:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC38F1C20993
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336FD19BAF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I8k6VBAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4E426B6
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 01:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702028936; x=1702288136;
	bh=Bawo9UvUiYFZwwqwj4nCsOmcby28tsl+uygx4LyQTaM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=I8k6VBANTzBFF5ZhUWfNEVxom38cXearcALDU4DXky7Zl0LzrL8t+73th52hQv9Y5
	 Bi6En1AT65qRWVrEMWd6Y9WzCjFU65NBUgmXLQ6ye8w7n9YRwlzEA/JHeUZpinMu+d
	 koCCjJaEja6hTseWvjWrZrO+72WkJNpk+Sy1EnUuwAPwc9xDuCJY2938mGGPojsYBd
	 Fs9xUSOQVfLNRn2dsp2TUttXgXu8OQlNzgG3rmYom2uPC6qtkjo2qfdzn80BReGjge
	 SS85zIpAY1Kjl5iSnW1B/mFyzLAgvvm0m7SVAec7D+SSKbB/KzN3V5BEPxh56IiHmd
	 rruAPU/Jwr5Og==
Date: Fri, 08 Dec 2023 09:48:30 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <9q-gcPBFqAZ1mAEZ333ax8Y16e8foTXUWsMijcJyvMhBVu91g4cBo3xRVXVFJeMUW3_67bCukA-bfAzpCwXdbHqwEdciNa8UJBJaCL2q2nw=@proton.me>
In-Reply-To: <20231206-alice-file-v2-1-af617c0d9d94@google.com>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-1-af617c0d9d94@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/6/23 12:59, Alice Ryhl wrote:
> +impl File {
> +    /// Constructs a new `struct file` wrapper from a file descriptor.
> +    ///
> +    /// The file descriptor belongs to the current process.
> +    pub fn fget(fd: u32) -> Result<ARef<Self>, BadFdError> {
> +        // SAFETY: FFI call, there are no requirements on `fd`.
> +        let ptr =3D ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_=
or(BadFdError)?;
> +
> +        // SAFETY: `fget` either returns null or a valid pointer to a fi=
le, and we checked for null
> +        // above.

Since now both the Rust and C functions are called `fget`, I think you
should refer to `bindings::fget`.

> +        //
> +        // INVARIANT: `fget` increments the refcount before returning.
> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> +    }

[...]

> +// SAFETY: The type invariants guarantee that `File` is always ref-count=
ed.
> +unsafe impl AlwaysRefCounted for File {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
> +        unsafe { bindings::get_file(self.as_ptr()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s nonzero.
> +        unsafe { bindings::fput(obj.cast().as_ptr()) }

The comment should also justify the cast.

--=20
Cheers,
Benno

> +    }
> +}

