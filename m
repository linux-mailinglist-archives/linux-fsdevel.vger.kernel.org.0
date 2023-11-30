Return-Path: <linux-fsdevel+bounces-4461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C1B7FF9C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3984EB20DF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1425A0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="F/rnyW1t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACE210DB;
	Thu, 30 Nov 2023 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701364338; x=1701623538;
	bh=5XDJY6qrdLzFeHm8Cj9m7uNxrkuBz8SBGfRnamorYn0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F/rnyW1t+fVNykiiDP/o43MmFV6iXVkSn5siXpxdhZwP2zLlFfoQdeV3eiBt7wVz1
	 K8f8K8aXaWHZ63asa/Zeqt5qcpLqF4o41niAbLYz3se4efNEvNHa9GRhkeEHoyHp0x
	 RRmBKrVpsYBDDKZtRZCpWp0UvA6NQjZLLADR//Lc6/vtyWL/SgyoCPjgBogKbBqyey
	 7J+GU42Gb9LyVRGiJvORDLGoo0W6z5nezm4/72/0O57X6+BnRGdKFXCo3jk0PRDKfO
	 vvAxaqi7fq+xtIOA/V5lIdN/A5HFtMea3PG+0MLPevN3Z3d3h6Ky7dXvTQUWrOIGuG
	 rUd6YTBcUjJgw==
Date: Thu, 30 Nov 2023 17:12:01 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/7] rust: file: add `DeferredFdCloser`
Message-ID: <LNSA8EeuwLGDBzY1W8GaP1L6gucAPE_34myHWuyg3ziYuheiFLk3WfVBPppzwDZwoGVTCqL8EBjAaxsNshTY6AQq_sNtK9hmea7FeaNJuCo=@proton.me>
In-Reply-To: <20231129-alice-file-v1-6-f81afe8c7261@google.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-6-f81afe8c7261@google.com>
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
> +    /// Schedule a task work that closes the file descriptor when this t=
ask returns to userspace.
> +    pub fn close_fd(mut self, fd: u32) {
> +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
> +
> +        let file =3D unsafe { bindings::close_fd_get_file(fd) };
> +        if file.is_null() {
> +            // Nothing further to do. The allocation is freed by the des=
tructor of `self.inner`.
> +            return;
> +        }
> +
> +        self.inner.file =3D file;
> +
> +        // SAFETY: Since `DeferredFdCloserInner` is `#[repr(C)]`, castin=
g the pointers gives a
> +        // pointer to the `twork` field.
> +        let inner =3D Box::into_raw(self.inner) as *mut bindings::callba=
ck_head;

Here you can just use `.cast::<...>()`.

> +        // SAFETY: Getting a pointer to current is always safe.
> +        let current =3D unsafe { bindings::get_current() };
> +        // SAFETY: The `file` pointer points at a valid file.
> +        unsafe { bindings::get_file(file) };
> +        // SAFETY: Due to the above `get_file`, even if the current task=
 holds an `fdget` to
> +        // this file right now, the refcount will not drop to zero until=
 after it is released
> +        // with `fdput`. This is because when using `fdget`, you must al=
ways use `fdput` before
> +        // returning to userspace, and our task work runs after any `fdg=
et` users have returned
> +        // to userspace.
> +        //
> +        // Note: fl_owner_t is currently a void pointer.
> +        unsafe { bindings::filp_close(file, (*current).files as bindings=
::fl_owner_t) };
> +        // SAFETY: The `inner` pointer is compatible with the `do_close_=
fd` method.
> +        unsafe { bindings::init_task_work(inner, Some(Self::do_close_fd)=
) };
> +        // SAFETY: The `inner` pointer points at a valid and fully initi=
alized task work that is
> +        // ready to be scheduled.
> +        unsafe { bindings::task_work_add(current, inner, TWA_RESUME) };

I am a bit confused, when does `do_close_fd` actually run? Does
`TWA_RESUME` mean that `inner` is scheduled to run after the current
task has been completed?

> +    }
> +
> +    // SAFETY: This function is an implementation detail of `close_fd`, =
so its safety comments
> +    // should be read in extension of that method.
> +    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head=
) {
> +        // SAFETY: In `close_fd` we use this method together with a poin=
ter that originates from a
> +        // `Box<DeferredFdCloserInner>`, and we have just been given own=
ership of that allocation.
> +        let inner =3D unsafe { Box::from_raw(inner as *mut DeferredFdClo=
serInner) };

In order for this call to be sound, `inner` must be an exclusive
pointer (including any possible references into the `callback_head`).
Is this the case?

--=20
Cheers,
Benno

> +        // SAFETY: This drops a refcount we acquired in `close_fd`. Sinc=
e this callback runs in a
> +        // task work after we return to userspace, it is guaranteed that=
 the current thread doesn't
> +        // hold this file with `fdget`, as `fdget` must be released befo=
re returning to userspace.
> +        unsafe { bindings::fput(inner.file) };
> +        // Free the allocation.
> +        drop(inner);
> +    }
> +}
> +
>  /// Represents the `EBADF` error code.
>  ///
>  /// Used for methods that can only fail with `EBADF`.
>=20
> --
> 2.43.0.rc1.413.gea7ed67945-goog
> 

