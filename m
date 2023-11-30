Return-Path: <linux-fsdevel+bounces-4469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3627FF9D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40737B20E05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3AF5A0EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aoBbVk9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA40F10E6;
	Thu, 30 Nov 2023 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701366156; x=1701625356;
	bh=jHvQDQIsGh7IZyuZ4Z71fkUJ7lN6fsPyLlI85ioCOd4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aoBbVk9ACHHmxS9v/zNi4r1IrszVrrEk+96u5Vbtx6tteI/l/ac1n2/OtSshr4kLK
	 EtjFckFu529Q2h8xsOmq48yhhbDu+Sr3EX4FQVVtgyhDiXj0PXlhm9K+GWiJdS7VCW
	 ESJPd7VJ8D45YK2SLUCaIYtZryFEMHp+heEc/ds6S02yMmUwN+BM4Sz5rZ6AggisTi
	 9Vurh4mtyuMBwd2Qp8bdoizuqGa5xEUuoX0bx68Q//tiWARi7paf3A+CDovtRku+Za
	 uvcHJ7cGTuJdI7J7WbjXkbcg+dXM6rRi49cBqvwyNvF8/QilOGxuOScBWxA3hB/SF6
	 9xqIzvRSaRGiw==
Date: Thu, 30 Nov 2023 17:42:06 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] rust: file: add abstraction for `poll_table`
Message-ID: <bH_zaB8RmZZW2QrGBx1ud7-YfKmh6QvTU0jYKC0ns7jjoDkCWYnW3u1qX_YrN5P0VwsZGd7U5r8p-7DxH7pb4-6UUE0htwTkFNdDIYZb4os=@proton.me>
In-Reply-To: <20231129-alice-file-v1-7-f81afe8c7261@google.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-7-f81afe8c7261@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/29/23 14:12, Alice Ryhl wrote:
> diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> index 578ee307093f..35576678c993 100644
> --- a/rust/kernel/file.rs
> +++ b/rust/kernel/file.rs
> @@ -14,6 +14,9 @@
>  use alloc::boxed::Box;
>  use core::{alloc::AllocError, marker::PhantomData, mem, ptr};
>=20
> +mod poll_table;
> +pub use self::poll_table::{PollCondVar, PollTable};

I think it makes more sense to put it under `rust/kernel/sync/`.
> +    fn get_qproc(&self) -> bindings::poll_queue_proc {
> +        let ptr =3D self.0.get();
> +        // SAFETY: The `ptr` is valid because it originates from a refer=
ence, and the `_qproc`
> +        // field is not modified concurrently with this call.

What ensures this? Maybe use a type invariant?

> +        unsafe { (*ptr)._qproc }
> +    }

[...]

> +impl PollCondVar {
> +    /// Constructs a new condvar initialiser.
> +    #[allow(clippy::new_ret_no_self)]

This is no longer needed, as Gary fixed this, see [1].

[1]: https://github.com/rust-lang/rust-clippy/issues/7344

> +    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl =
PinInit<Self> {
> +        pin_init!(Self {
> +            inner <- CondVar::new(name, key),
> +        })
> +    }
> +}
> +
> +// Make the `CondVar` methods callable on `PollCondVar`.
> +impl Deref for PollCondVar {
> +    type Target =3D CondVar;
> +
> +    fn deref(&self) -> &CondVar {
> +        &self.inner
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for PollCondVar {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Clear anything registered using `register_wait`.
> +        self.inner.notify(1, bindings::POLLHUP | bindings::POLLFREE);

Isn't notifying only a single thread problematic, since a user could
misuse the `PollCondVar` (since all functions of `CondVar` are also
accessible) and also `.wait()` on the condvar? When dropping a
`PollCondVar` it might notify only the user `.wait()`, but not the
`PollTable`. Or am I missing something?

--=20
Cheers,
Benno

> +        // Wait for epoll items to be properly removed.
> +        //
> +        // SAFETY: Just an FFI call.
> +        unsafe { bindings::synchronize_rcu() };
> +    }
> +}

