Return-Path: <linux-fsdevel+bounces-5356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BFA80AC38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697381C20A13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C328C4CB27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AunkrxB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FDC93
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ixvrilbdlnczzba4dtnifmhobu.protonmail; t=1702057148; x=1702316348;
	bh=HY9Md4VHLYQT5RpanAdJRLZSL23/aGNw4oFWZPZrWZg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AunkrxB1GjMKQMft60KVeeD1E0BRxc4RbOJeL56qlByAizAea7/v01nZmsdEnQwWK
	 1kOzObe2JVU16Whu9xn03azaQAmOh4KzAnPA1O2f6mPVbH1yRupswNHYGEL/VVzgoU
	 WPhNLURfbPFTKDUTLhPIFZcfK6DIOufo+fXUZB9lmpabKkuAyXqqwTLRzNntoPN5jl
	 ft5a+v5z+a0qy4KIStgL7RXLCcBwAU2qa0yXy9cUUyK2UURBjtkEbKD2D7/w/hJfSD
	 DhcckwiAV4aHPbj8UBNAaPSbiwyl3qk1AIJ6fOSGkYElhI+zduseym2AbPJLAU7T34
	 Ii3g5STYKFycQ==
Date: Fri, 08 Dec 2023 17:39:01 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] rust: file: add `DeferredFdCloser`
Message-ID: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me>
In-Reply-To: <20231206-alice-file-v2-6-af617c0d9d94@google.com>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-6-af617c0d9d94@google.com>
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
> +    /// Schedule a task work that closes the file descriptor when this t=
ask returns to userspace.
> +    ///
> +    /// Fails if this is called from a context where we cannot run work =
when returning to
> +    /// userspace. (E.g., from a kthread.)
> +    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdCloseError> {
> +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
> +
> +        // In this method, we schedule the task work before closing the =
file. This is because
> +        // scheduling a task work is fallible, and we need to know wheth=
er it will fail before we
> +        // attempt to close the file.
> +
> +        // SAFETY: Getting a pointer to current is always safe.
> +        let current =3D unsafe { bindings::get_current() };
> +
> +        // SAFETY: Accessing the `flags` field of `current` is always sa=
fe.
> +        let is_kthread =3D (unsafe { (*current).flags } & bindings::PF_K=
THREAD) !=3D 0;

Since Boqun brought to my attention that we already have a wrapper for
`get_current()`, how about you use it here as well?

> +        if is_kthread {
> +            return Err(DeferredFdCloseError::TaskWorkUnavailable);
> +        }
> +
> +        // This disables the destructor of the box, so the allocation is=
 not cleaned up
> +        // automatically below.
> +        let inner =3D Box::into_raw(self.inner);

Importantly this also lifts the uniqueness requirement (maybe add this
to the comment?).

> +
> +        // The `callback_head` field is first in the struct, so this cas=
t correctly gives us a
> +        // pointer to the field.
> +        let callback_head =3D inner.cast::<bindings::callback_head>();
> +        // SAFETY: This pointer offset operation does not go out-of-boun=
ds.
> +        let file_field =3D unsafe { core::ptr::addr_of_mut!((*inner).fil=
e) };
> +
> +        // SAFETY: The `callback_head` pointer is compatible with the `d=
o_close_fd` method.

Also, `callback_head` is valid, since it is derived from...

> +        unsafe { bindings::init_task_work(callback_head, Some(Self::do_c=
lose_fd)) };
> +        // SAFETY: The `callback_head` pointer points at a valid and ful=
ly initialized task work
> +        // that is ready to be scheduled.
> +        //
> +        // If the task work gets scheduled as-is, then it will be a no-o=
p. However, we will update
> +        // the file pointer below to tell it which file to fput.
> +        let res =3D unsafe { bindings::task_work_add(current, callback_h=
ead, TWA_RESUME) };
> +
> +        if res !=3D 0 {
> +            // SAFETY: Scheduling the task work failed, so we still have=
 ownership of the box, so
> +            // we may destroy it.
> +            unsafe { drop(Box::from_raw(inner)) };
> +
> +            return Err(DeferredFdCloseError::TaskWorkUnavailable);

Just curious, what could make the `task_work_add` call fail? I imagine
an OOM situation, but is that all?

> +        }
> +
> +        // SAFETY: Just an FFI call. This is safe no matter what `fd` is=
.

I took a look at the C code and there I found this comment:

    /*
     * variant of close_fd that gets a ref on the file for later fput.
     * The caller must ensure that filp_close() called on the file.
     */

And while you do call `filp_close` later, this seems like a safety
requirement to me.
Also, you do not call it when `file` is null, which I imagine to be
fine, but I do not know that since the C comment does not cover that
case.

> +        let file =3D unsafe { bindings::close_fd_get_file(fd) };
> +        if file.is_null() {
> +            // We don't clean up the task work since that might be expen=
sive if the task work queue
> +            // is long. Just let it execute and let it clean up for itse=
lf.
> +            return Err(DeferredFdCloseError::BadFd);
> +        }
> +
> +        // SAFETY: The `file` pointer points at a valid file.
> +        unsafe { bindings::get_file(file) };
> +
> +        // SAFETY: Due to the above `get_file`, even if the current task=
 holds an `fdget` to
> +        // this file right now, the refcount will not drop to zero until=
 after it is released
> +        // with `fdput`. This is because when using `fdget`, you must al=
ways use `fdput` before

Shouldn't this be "the refcount will not drop to zero until after it is
released with `fput`."?

Why is this the SAFETY comment for `filp_close`? I am not understanding
the requirement on that function that needs this. This seems more a
justification for accessing `file` inside `do_close_fd`. In which case I
think it would be better to make it a type invariant of
`DeferredFdCloserInner`.

> +        // returning to userspace, and our task work runs after any `fdg=
et` users have returned
> +        // to userspace.
> +        //
> +        // Note: fl_owner_t is currently a void pointer.
> +        unsafe { bindings::filp_close(file, (*current).files as bindings=
::fl_owner_t) };
> +
> +        // We update the file pointer that the task work is supposed to =
fput.
> +        //
> +        // SAFETY: Task works are executed on the current thread once we=
 return to userspace, so
> +        // this write is guaranteed to happen before `do_close_fd` is ca=
lled, which means that a
> +        // race is not possible here.
> +        //
> +        // It's okay to pass this pointer to the task work, since we jus=
t acquired a refcount with
> +        // the previous call to `get_file`. Furthermore, the refcount wi=
ll not drop to zero during
> +        // an `fdget` call, since we defer the `fput` until after return=
ing to userspace.
> +        unsafe { *file_field =3D file };

A synchronization question: who guarantees that this write is actually
available to the cpu that executes `do_close_fd`? Is there some
synchronization run when returning to userspace?

> +
> +        Ok(())
> +    }
> +
> +    // SAFETY: This function is an implementation detail of `close_fd`, =
so its safety comments
> +    // should be read in extension of that method.

Why not use this?:
- `inner` is a valid pointer to the `callback_head` field of a valid
  `DeferredFdCloserInner`.
- `inner` has exclusive access to the pointee and owns the allocation.
- `inner` originates from a call to `Box::into_raw`.

> +    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head=
) {
> +        // SAFETY: In `close_fd` we use this method together with a poin=
ter that originates from a
> +        // `Box<DeferredFdCloserInner>`, and we have just been given own=
ership of that allocation.
> +        let inner =3D unsafe { Box::from_raw(inner as *mut DeferredFdClo=
serInner) };

Use `.cast()`.

> +        if !inner.file.is_null() {
> +            // SAFETY: This drops a refcount we acquired in `close_fd`. =
Since this callback runs in
> +            // a task work after we return to userspace, it is guarantee=
d that the current thread
> +            // doesn't hold this file with `fdget`, as `fdget` must be r=
eleased before returning to
> +            // userspace.
> +            unsafe { bindings::fput(inner.file) };
> +        }
> +        // Free the allocation.
> +        drop(inner);
> +    }
> +}
> +
> +/// Represents a failure to close an fd in a deferred manner.
> +#[derive(Copy, Clone, Eq, PartialEq)]
> +pub enum DeferredFdCloseError {
> +    /// Closing the fd failed because we were unable to schedule a task =
work.
> +    TaskWorkUnavailable,
> +    /// Closing the fd failed because the fd does not exist.
> +    BadFd,
> +}
> +
> +impl From<DeferredFdCloseError> for Error {
> +    fn from(err: DeferredFdCloseError) -> Error {
> +        match err {
> +            DeferredFdCloseError::TaskWorkUnavailable =3D> ESRCH,

This error reads "No such process", I am not sure if that is the best
way to express the problem in that situation. I took a quick look at the
other error codes, but could not find a better fit. Do you have any
better ideas? Or is this the error that C binder uses?

--=20
Cheers,
Benno

> +            DeferredFdCloseError::BadFd =3D> EBADF,
> +        }
> +    }
> +}

