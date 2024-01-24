Return-Path: <linux-fsdevel+bounces-8693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 170EB83A65D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D341F2B0BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0218636;
	Wed, 24 Jan 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hLKOyjLV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342518624;
	Wed, 24 Jan 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090877; cv=none; b=tAVtBN/Mp/VBvCL7etKyPVxKXbtoBak30oPtABqjFsc/YlS+ATqDT6oBwa/v0ybI2vlwDiTzTm8T0hzewDaWNETiDiO4XTjpNlX+OiqRybGiT1DZUvdCLbnGQ2HaDJ6E0Iui0Mkf3tdd5pylOQIbPl1tsVc1fgZzq1S/myhU1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090877; c=relaxed/simple;
	bh=aL/a4co3TwpDRjGVNeGMmp1wmNR972BLDxLJ4qWZqIc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+5tVH5kIUhIk4z+dDkvJzHVExCcZeZekbXCrlrq6vI+JLjspy4Ctu7wDxb+wLqArHe5NhOqrhS93smF0Wclb04HiTIx9S6zUPStLUuG2N0rgt+hBNqGV+E9QvoIJSDE6Cu1QoCNnVFzLpglgDr/3W5JkkdF/1JHsxpVLheybS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hLKOyjLV; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706090867; x=1706350067;
	bh=r286NmNLGtOoEjkp4oNKdRo5j35gCJsWTNX5/gVttkU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hLKOyjLVKYoxvgcVKstb5dGVsPWA+k7a/sMPwNlhMAapjyEwvryC/iqCEjDYj9pYx
	 5mja9PUorlz4jo9BE1TWi0s3Ax18cxo9NcyirX59B03n5fpoFnY782QAwU+gD75n5s
	 27uf/g8W7S4HtTt3obZciLaG7wC8+3mSCBwOhUqReqzG0aE77XaDEcuQrcrP/sOXNF
	 yCPVsXuLC1yqzftc8Ilpx9tEZaPLHaOQbXyAe6BNFDYbkZVcfrrDMTQSA25JFsO8DZ
	 VBXHaTS9PP8xTiuWDY5ZjJgQB+lRUXf4DbON9cMFv9A4hkG80kQ73/i+fHjapV1gUU
	 B9u5kVrK4BITg==
Date: Wed, 24 Jan 2024 10:07:40 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] rust: file: add `DeferredFdCloser`
Message-ID: <899fab69-e051-4d6b-bf6c-452779ed8190@proton.me>
In-Reply-To: <20240118-alice-file-v3-8-9694b6f9580c@google.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-8-9694b6f9580c@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.01.24 15:36, Alice Ryhl wrote:
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
> +        // Task works are not available on kthreads.
> +        let current =3D crate::current!();
> +        if current.is_kthread() {
> +            return Err(DeferredFdCloseError::TaskWorkUnavailable);
> +        }
> +
> +        // Transfer ownership of the box's allocation to a raw pointer. =
This disables the
> +        // destructor, so we must manually convert it back to a Box to d=
rop it.
> +        //
> +        // Until we convert it back to a `Box`, there are no aliasing re=
quirements on this
> +        // pointer.
> +        let inner =3D Box::into_raw(self.inner);
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
> +        let current =3D current.as_raw();
> +
> +        // SAFETY: This function currently has exclusive access to the `=
DeferredFdCloserInner`, so
> +        // it is okay for us to perform unsynchronized writes to its `ca=
llback_head` field.
> +        unsafe { bindings::init_task_work(callback_head, Some(Self::do_c=
lose_fd)) };
> +
> +        // SAFETY: This inserts the `DeferredFdCloserInner` into the tas=
k workqueue for the current
> +        // task. If this operation is successful, then this transfers ex=
clusive ownership of the
> +        // `callback_head` field to the C side until it calls `do_close_=
fd`, and we don't touch or
> +        // invalidate the field during that time.
> +        //
> +        // When the C side calls `do_close_fd`, the safety requirements =
of that method are
> +        // satisfied because when a task work is executed, the callback =
is given ownership of the
> +        // pointer.
> +        //
> +        // The file pointer is currently null. If it is changed to be no=
n-null before `do_close_fd`
> +        // is called, then that change happens due to the write at the e=
nd of this function, and
> +        // that write has a safety comment that explains why the refcoun=
t can be dropped when
> +        // `do_close_fd` runs.
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
> +        }
> +
> +        // SAFETY: This is safe no matter what `fd` is. If the `fd` is v=
alid (that is, if the
> +        // pointer is non-null), then we call `filp_close` on the return=
ed pointer as required by
> +        // `close_fd_get_file`.
> +        let file =3D unsafe { bindings::close_fd_get_file(fd) };
> +        if file.is_null() {
> +            // We don't clean up the task work since that might be expen=
sive if the task work queue
> +            // is long. Just let it execute and let it clean up for itse=
lf.
> +            return Err(DeferredFdCloseError::BadFd);
> +        }
> +
> +        // Acquire a refcount to the file.
> +        //
> +        // SAFETY: The `file` pointer points at a file with a non-zero r=
efcount.
> +        unsafe { bindings::get_file(file) };
> +
> +        // SAFETY: The `file` pointer is valid. Passing `current->files`=
 as the file table to close
> +        // it in is correct, since we just got the `fd` from `close_fd_g=
et_file` which also uses
> +        // `current->files`.
> +        //
> +        // This method closes the fd. There could be active light refcou=
nts created from that fd,
> +        // so we must ensure that the file has a positive refcount for t=
he duration of those active
> +        // light refcounts.

This doesn't seem to be part of the SAFETY comment, so maybe move
this comment above it?

> +        //
> +        // Note: fl_owner_t is currently a void pointer.
> +        unsafe { bindings::filp_close(file, (*current).files as bindings=
::fl_owner_t) };
> +
> +        // We update the file pointer that the task work is supposed to =
fput. This transfers
> +        // ownership of our last refcount.

I think it is very good that you mention how many refcounts you have
here, but I am missing that in the code above. IIRC `closed_fd_get_file`
acquires a refcount and `filp_close` consumes one.

> +        //
> +        // INVARIANT: This changes the `file` field of a `DeferredFdClos=
erInner` from null to
> +        // non-null. This doesn't break the type invariant for `Deferred=
FdCloserInner` because we
> +        // still own a refcount to the file, so we can pass ownership of=
 that refcount to the
> +        // `DeferredFdCloserInner`.
> +        //
> +        // SAFETY: Task works are executed on the current thread right b=
efore we return to
> +        // userspace, so this write is guaranteed to happen before `do_c=
lose_fd` is called, which
> +        // means that a race is not possible here.
> +        //
> +        // When `do_close_fd` runs, it must be safe for it to `fput` the=
 refcount. However, this is
> +        // the case because all light refcounts that are associated with=
 the fd we closed
> +        // previously must be dropped when `do_close_fd`, since light re=
fcounts must be dropped
> +        // before returning to userspace.

This also doesn't seem to be part of the SAFETY comment.

--=20
Cheers,
Benno

> +        unsafe { *file_field =3D file };
> +
> +        Ok(())
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// The provided pointer must point at the `twork` field of a `Defer=
redFdCloserInner` stored in
> +    /// a `Box`, and the caller must pass exclusive ownership of that `B=
ox`. Furthermore, if the
> +    /// file pointer is non-null, then it must be okay to release the re=
fcount by calling `fput`.
> +    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head=
) {
> +        // SAFETY: The caller just passed us ownership of this box.
> +        let inner =3D unsafe { Box::from_raw(inner.cast::<DeferredFdClos=
erInner>()) };
> +        if !inner.file.is_null() {
> +            // SAFETY: By the type invariants, we own a refcount to this=
 file, and the caller
> +            // guarantees that dropping the refcount now is okay.
> +            unsafe { bindings::fput(inner.file) };
> +        }
> +        // The allocation is freed when `inner` goes out of scope.
> +    }
> +}



