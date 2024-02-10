Return-Path: <linux-fsdevel+bounces-11042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC081850365
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 08:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F7BB22626
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B297D3611A;
	Sat, 10 Feb 2024 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="hrwvuHYD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305633CF1
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551271; cv=none; b=ZoGjtg/vpsCZUa831JIeZ6rF8XeoatLrbfdjy2bBLdeFJkeahMoEAayg5zbUc9V4p46q3TbcO11ynerOyQ6OEU5ZAFvMRqQYphHZjCXz2061EEx5qDl+vYE8Og9gGdwuXaNPutZGLky4GEIC9VmIpiAwN7P8hI8Q5Q94L2cXKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551271; c=relaxed/simple;
	bh=chO51V/LiVlQrZFz8Yp4F5+/IQFky+ClMZ+UJWLCM+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZg+60VhlK4gcOysoL7TCnHLzW4rGBVogY5gZi6nHdkwlCPsx1G/+AYoV7cb4mIkipts2o25ACK7ADB8foflRLWxTKwsKSMQMPE3PQc2iEKJSL6c8zvBGonubM+kAJa9FhKObY24PGJkqYdyP9KxtZdV8nH6nCqycOr1cKXzf8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=hrwvuHYD; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc755832968so1059257276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 23:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707551268; x=1708156068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XxK0vLWSAEM3fQwJd+Bl8pWBGoyJY9yNdJebIRXYZg=;
        b=hrwvuHYDeIDmeGeBaC871RGeo65aYFFqUrzpDHiaOCT9Q+IycsSzhK5l1HQgjzxh7B
         o0L6gXxJe4IkmiOngh4qO9hYN4YYFt5dZuPwmrQceRPE2FHvqoxdQxlty8xV/0CJQi57
         QVHxRs4UteoYbNimr+ri2pNKjYSXhA1ZdiMHaLQGIsZnpNnPilmsNK/oKZ4oWCfLgqTk
         /958xBmZlnPf9ijAa3AqHJV/oqcNGHAkuHlqVQrZ4Ecf0BcltlDnDc0AQEC89fiksKzf
         RQpqODQH4rpjQTuQggvcDf4zq8FZimjuZlMeK8EpxVsZG8tCNkm7i7k8n21T+HQkAuk/
         36Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551268; x=1708156068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XxK0vLWSAEM3fQwJd+Bl8pWBGoyJY9yNdJebIRXYZg=;
        b=BPK3xy0MedxOb7JpeCDSW4y/hcex6rNkL2VKZCvDV+arkkl9b/WgLpYNLoCjCteI1h
         TK+35yz/1diYSR9qsjaNAhIh7XQZDhmzthy3bV0l/0xK2l5Vo4bb1QoBql2IlWCmRTrS
         ikCMW2fnf1P2ZBkYQKB1NCdBbtOK5D7j1EJUsmNlWBInZfb5xXbmkkmFrG6WUjLYlBfK
         RX/buDMee3FcZf7d7ftX+VeQ3uMfDGRLgLFju6TaH0NOsbjYRb5sUsNRDdY+xrhjeaam
         2iMUzQC5N7t0pVfGxIx/6t1EE1IKhTbzgqNq8E2VKTEpuJYGYBslQ3pqPlH404TIB56E
         iLGw==
X-Gm-Message-State: AOJu0YzPUckCY+i7yii9AgBA/dkB6BQ7lPOcv2A0pAWGCmDd0zfZ5xyf
	3wsffOokoSxo/xEyEE6/erVCg3gEZMRm5fGJgUZn1kXxm3oV9JNa0owU5B5ju8SYzMqCRt8O5vl
	RjfN5BEou384rFu2vx+w8HvSKK/wULSUJzujeFQ==
X-Google-Smtp-Source: AGHT+IEz2EdCnZvBlvyPdFqg0UZlZ5Z5/xrnzn99i2xzWSfAFtMRSGSSARjH1Xangl3cV2Duw6t/FafLkcxVPLsSTUg=
X-Received: by 2002:a25:ab6b:0:b0:dc6:be1f:6d98 with SMTP id
 u98-20020a25ab6b000000b00dc6be1f6d98mr1200713ybi.16.1707551267713; Fri, 09
 Feb 2024 23:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com> <20240209-alice-file-v5-8-a37886783025@google.com>
In-Reply-To: <20240209-alice-file-v5-8-a37886783025@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 10 Feb 2024 01:47:36 -0600
Message-ID: <CALNs47vrm+kh=xH=57TWPuxXb_HL+ws2GqOmMFA3O4xLGS6yoQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] rust: file: add `DeferredFdCloser`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:22=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> To close an fd from kernel space, we could call `ksys_close`. However,
> if we do this to an fd that is held using `fdget`, then we may trigger a
> use-after-free. Introduce a helper that can be used to close an fd even
> if the fd is currently held with `fdget`. This is done by grabbing an
> extra refcount to the file and dropping it in a task work once we return
> to userspace.
>
> This is necessary for Rust Binder because otherwise the user might try
> to have Binder close its fd for /dev/binder, which would cause problems
> as this happens inside an ioctl on /dev/binder, and ioctls hold the fd
> using `fdget`.
>
> Additional motivation can be found in commit 80cd795630d6 ("binder: fix
> use-after-free due to ksys_close() during fdget()") and in the comments
> on `binder_do_fd_close`.
>
> If there is some way to detect whether an fd is currently held with
> `fdget`, then this could be optimized to skip the allocation and task
> work when this is not the case. Another possible optimization would be
> to combine several fds into a single task work, since this is used with
> fd arrays that might hold several fds.
>
> That said, it might not be necessary to optimize it, because Rust Binder
> has two ways to send fds: BINDER_TYPE_FD and BINDER_TYPE_FDA. With
> BINDER_TYPE_FD, it is userspace's responsibility to close the fd, so
> this mechanism is used only by BINDER_TYPE_FDA, but fd arrays are used
> rarely these days.
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Trevor Gross <tmgross@umich.edu>

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
> +        // This removes the fd from the fd table in `current`. The file =
is not fully closed until
> +        // `filp_close` is called. We are given ownership of one refcoun=
t to the file.
> +        //
> +        // SAFETY: This is safe no matter what `fd` is. If the `fd` is v=
alid (that is, if the
> +        // pointer is non-null), then we call `filp_close` on the return=
ed pointer as required by
> +        // `file_close_fd`.
> +        let file =3D unsafe { bindings::file_close_fd(fd) };
> +        if file.is_null() {
> +            // We don't clean up the task work since that might be expen=
sive if the task work queue
> +            // is long. Just let it execute and let it clean up for itse=
lf.
> +            return Err(DeferredFdCloseError::BadFd);
> +        }
> +
> +        // Acquire a second refcount to the file.
> +        //
> +        // SAFETY: The `file` pointer points at a file with a non-zero r=
efcount.
> +        unsafe { bindings::get_file(file) };
> +
> +        // This method closes the fd, consuming one of our two refcounts=
. There could be active
> +        // light refcounts created from that fd, so we must ensure that =
the file has a positive
> +        // refcount for the duration of those active light refcounts. We=
 do that by holding on to
> +        // the second refcount until the current task returns to userspa=
ce.
> +        //
> +        // SAFETY: The `file` pointer is valid. Passing `current->files`=
 as the file table to close
> +        // it in is correct, since we just got the `fd` from `file_close=
_fd` which also uses
> +        // `current->files`.
> +        //
> +        // Note: fl_owner_t is currently a void pointer.
> +        unsafe { bindings::filp_close(file, (*current).files as bindings=
::fl_owner_t) };
> +
> +        // We update the file pointer that the task work is supposed to =
fput. This transfers
> +        // ownership of our last refcount.
> +        //
> +        // INVARIANT: This changes the `file` field of a `DeferredFdClos=
erInner` from null to
> +        // non-null. This doesn't break the type invariant for `Deferred=
FdCloserInner` because we
> +        // still own a refcount to the file, so we can pass ownership of=
 that refcount to the
> +        // `DeferredFdCloserInner`.
> +        //
> +        // When `do_close_fd` runs, it must be safe for it to `fput` the=
 refcount. However, this is
> +        // the case because all light refcounts that are associated with=
 the fd we closed
> +        // previously must be dropped when `do_close_fd`, since light re=
fcounts must be dropped
> +        // before returning to userspace.
> +        //
> +        // SAFETY: Task works are executed on the current thread right b=
efore we return to
> +        // userspace, so this write is guaranteed to happen before `do_c=
lose_fd` is called, which
> +        // means that a race is not possible here.
> +        unsafe { *file_field =3D file };
> +
> +        Ok(())
> +    }

This documentation is quite a work of art :)

