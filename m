Return-Path: <linux-fsdevel+bounces-5539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319BD80D3A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB20281BC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63824D5BE;
	Mon, 11 Dec 2023 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QOMLP798"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79A79B;
	Mon, 11 Dec 2023 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702315384; x=1702574584;
	bh=/rZLzYJBaNvf1TixCBPqcPr/wHvkKBLCKXDInXV6jXM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QOMLP798rh8Ht/uoaKBkguKqxImlKkrv9WLEjZd7hhELp1G83vMN34Gfhbb4TVcPH
	 OmDPhlf6Y2M9HWbDYwLf8bCYtR6C65t+Oxunr2ARPlYFSFv1X0OlXxo67P2Z9pYm/v
	 OKGEZBGOcXjmO7vAHloPOcAtKiqjhQ6/OZIPk6SW9rJtZ0Ow1CGDG6tlZJzuely5Ic
	 7ek2Kdun1OhNS3kgGrPIyqE0gVZjm9z+KX0OYnXTOszle8HXNGDHDUqd0YNfLuWVrj
	 AmzC9T2rfGDs/2GYcqiFJLY+Wkmlcfx91Yo8TwmohWPkks2L1ffgK6ZoOrMYrD/7RV
	 u2oV3TxqmhyhA==
Date: Mon, 11 Dec 2023 17:23:00 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH v2 6/7] rust: file: add `DeferredFdCloser`
Message-ID: <DNn_nN0MKmn9OoY7Gjn4fCUcwKD6ijDZyDXVHvouEa2w0o2yiXeRox3EUfAcbfoWqx0I24-8HqqzONjuTQIVxu2cfAoNQpUFJygPtQNXPM4=@proton.me>
In-Reply-To: <20231211153440.4162899-1-aliceryhl@google.com>
References: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me> <20231211153440.4162899-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/11/23 16:34, Alice Ryhl wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>> On 12/6/23 12:59, Alice Ryhl wrote:
>>> +    /// Schedule a task work that closes the file descriptor when this=
 task returns to userspace.
>>> +    ///
>>> +    /// Fails if this is called from a context where we cannot run wor=
k when returning to
>>> +    /// userspace. (E.g., from a kthread.)
>>> +    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdCloseError>=
 {
>>> +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
>>> +
>>> +        // In this method, we schedule the task work before closing th=
e file. This is because
>>> +        // scheduling a task work is fallible, and we need to know whe=
ther it will fail before we
>>> +        // attempt to close the file.
>>> +
>>> +        // SAFETY: Getting a pointer to current is always safe.
>>> +        let current =3D unsafe { bindings::get_current() };
>>> +
>>> +        // SAFETY: Accessing the `flags` field of `current` is always =
safe.
>>> +        let is_kthread =3D (unsafe { (*current).flags } & bindings::PF=
_KTHREAD) !=3D 0;
>>
>> Since Boqun brought to my attention that we already have a wrapper for
>> `get_current()`, how about you use it here as well?
>=20
> I can use the wrapper, but it seems simpler to not go through a
> reference when we just need a raw pointer.
>=20
> Perhaps we should have a safe `Task::current_raw` function that just
> returns a raw pointer? It can still be safe.

Sure, that would work.

Just thought that it is annoying having to write the safety
requirements of that again and again.

[...]

>>> +        unsafe { bindings::init_task_work(callback_head, Some(Self::do=
_close_fd)) };
>>> +        // SAFETY: The `callback_head` pointer points at a valid and f=
ully initialized task work
>>> +        // that is ready to be scheduled.
>>> +        //
>>> +        // If the task work gets scheduled as-is, then it will be a no=
-op. However, we will update
>>> +        // the file pointer below to tell it which file to fput.
>>> +        let res =3D unsafe { bindings::task_work_add(current, callback=
_head, TWA_RESUME) };
>>> +
>>> +        if res !=3D 0 {
>>> +            // SAFETY: Scheduling the task work failed, so we still ha=
ve ownership of the box, so
>>> +            // we may destroy it.
>>> +            unsafe { drop(Box::from_raw(inner)) };
>>> +
>>> +            return Err(DeferredFdCloseError::TaskWorkUnavailable);
>>
>> Just curious, what could make the `task_work_add` call fail? I imagine
>> an OOM situation, but is that all?
>=20
> Actually, no, this doesn't fail in OOM situations since we pass it an
> allocation for its linked list. It fails only when the current task is
> exiting and wont run task work again.

Interesting, is there some way to check for this aside from calling
`task_work_add`?

>>> +        }
>>> +
>>> +        // SAFETY: Just an FFI call. This is safe no matter what `fd` =
is.
>>
>> I took a look at the C code and there I found this comment:
>>
>>     /*
>>      * variant of close_fd that gets a ref on the file for later fput.
>>      * The caller must ensure that filp_close() called on the file.
>>      */
>>
>> And while you do call `filp_close` later, this seems like a safety
>> requirement to me.
>=20
> I'll mention this.
>=20
>> Also, you do not call it when `file` is null, which I imagine to be
>> fine, but I do not know that since the C comment does not cover that
>> case.
>=20
> Null pointer means that the fd doesn't exist, and it's correct to do
> nothing in that case.

I would also mention that in a comment (or the SAFETY comment).

>>> +        let file =3D unsafe { bindings::close_fd_get_file(fd) };
>>> +        if file.is_null() {
>>> +            // We don't clean up the task work since that might be exp=
ensive if the task work queue
>>> +            // is long. Just let it execute and let it clean up for it=
self.
>>> +            return Err(DeferredFdCloseError::BadFd);
>>> +        }
>>> +
>>> +        // SAFETY: The `file` pointer points at a valid file.
>>> +        unsafe { bindings::get_file(file) };
>>> +
>>> +        // SAFETY: Due to the above `get_file`, even if the current ta=
sk holds an `fdget` to
>>> +        // this file right now, the refcount will not drop to zero unt=
il after it is released
>>> +        // with `fdput`. This is because when using `fdget`, you must =
always use `fdput` before
>>
>> Shouldn't this be "the refcount will not drop to zero until after it is
>> released with `fput`."?
>>
>> Why is this the SAFETY comment for `filp_close`? I am not understanding
>> the requirement on that function that needs this. This seems more a
>> justification for accessing `file` inside `do_close_fd`. In which case I
>> think it would be better to make it a type invariant of
>> `DeferredFdCloserInner`.
>=20
> It's because `filp_close` decreases the refcount for the file, and doing
> that is not always safe even if you have a refcount to the file. To drop
> the refcount, at least one of the two following must be the case:
>=20
> * If the refcount decreases to a non-zero value, then it is okay.
> * If there are no users of `fdget` on the file, then it is okay.

I see, that makes sense. Is this written down somewhere? Or how does one
know about this?

> In this case, we are in the first case, as we own two refcounts.
>=20
> I'll clarify the safety comment in v3.
>=20
>>> +        // returning to userspace, and our task work runs after any `f=
dget` users have returned
>>> +        // to userspace.
>>> +        //
>>> +        // Note: fl_owner_t is currently a void pointer.
>>> +        unsafe { bindings::filp_close(file, (*current).files as bindin=
gs::fl_owner_t) };
>>> +
>>> +        // We update the file pointer that the task work is supposed t=
o fput.
>>> +        //
>>> +        // SAFETY: Task works are executed on the current thread once =
we return to userspace, so
>>> +        // this write is guaranteed to happen before `do_close_fd` is =
called, which means that a
>>> +        // race is not possible here.
>>> +        //
>>> +        // It's okay to pass this pointer to the task work, since we j=
ust acquired a refcount with
>>> +        // the previous call to `get_file`. Furthermore, the refcount =
will not drop to zero during
>>> +        // an `fdget` call, since we defer the `fput` until after retu=
rning to userspace.
>>> +        unsafe { *file_field =3D file };
>>
>> A synchronization question: who guarantees that this write is actually
>> available to the cpu that executes `do_close_fd`? Is there some
>> synchronization run when returning to userspace?
>=20
> It's on the same thread, so it's just a sequenced-before relation.
>=20
> It's not like an interrupt. It runs after the syscall invocation has
> exited, but before it does the actual return-to-userspace stuff.

Reasonable, can you also put this in a comment?

[...]

>>> +        if !inner.file.is_null() {
>>> +            // SAFETY: This drops a refcount we acquired in `close_fd`=
. Since this callback runs in
>>> +            // a task work after we return to userspace, it is guarant=
eed that the current thread
>>> +            // doesn't hold this file with `fdget`, as `fdget` must be=
 released before returning to
>>> +            // userspace.
>>> +            unsafe { bindings::fput(inner.file) };
>>> +        }
>>> +        // Free the allocation.
>>> +        drop(inner);
>>> +    }
>>> +}
>>> +
>>> +/// Represents a failure to close an fd in a deferred manner.
>>> +#[derive(Copy, Clone, Eq, PartialEq)]
>>> +pub enum DeferredFdCloseError {
>>> +    /// Closing the fd failed because we were unable to schedule a tas=
k work.
>>> +    TaskWorkUnavailable,
>>> +    /// Closing the fd failed because the fd does not exist.
>>> +    BadFd,
>>> +}
>>> +
>>> +impl From<DeferredFdCloseError> for Error {
>>> +    fn from(err: DeferredFdCloseError) -> Error {
>>> +        match err {
>>> +            DeferredFdCloseError::TaskWorkUnavailable =3D> ESRCH,
>>
>> This error reads "No such process", I am not sure if that is the best
>> way to express the problem in that situation. I took a quick look at the
>> other error codes, but could not find a better fit. Do you have any
>> better ideas? Or is this the error that C binder uses?
>=20
> This is the error code that task_work_add returns. (It can't happen in
> Binder.)
>=20
> And I do think that it is a reasonable choice, because the error only
> happens if you're calling the method from a context that has no
> userspace process associated with it.

I see.

What do you think of making the Rust error more descriptive? So instead
of implementing `Debug` like you currently do, you print
   =20
    $error ($variant)

where $error =3D Error::from(*self) and $variant is the name of the
variant?

This is more of a general suggestion, I don't think that this error type
in particular warrants this. But in general with Rust we do have the
option to have good error messages for every error while maintaining
efficient error values.

--=20
Cheers,
Benno

