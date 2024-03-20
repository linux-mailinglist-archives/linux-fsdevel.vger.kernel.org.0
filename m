Return-Path: <linux-fsdevel+bounces-14900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3373288133C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 15:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91DD4B22F49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90C744C9B;
	Wed, 20 Mar 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnOehN3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85A2628D;
	Wed, 20 Mar 2024 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944527; cv=none; b=egfRzDjmKFunaWY62u+46F126FRyt5LD//f0X2HpyFZRtO3LPQx1onDe3lGd2jyygDUuLZ1DYB9qJVFKSNCnYoBN8xvFJJT5A95QW7/R/XWj0Y7bwCaUYjfX578dq4nusFDskfAWbVm6LxBE+rWlN55ekObXmkzTh/kpgI8k0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944527; c=relaxed/simple;
	bh=YeiTVtpHC2NPLqJdgcme5WeBzb4ywOWTrrfGUMyIySg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQDy4fkRP/dU3zGo4SaTzW4QKfPxdBGutZcq0eo0T25EQ/BF8sNrujj6V1RN1Kb3Ojvblbxl9Y9K0ZObOjcEXKY3EmIUfhm62/YDTGLDTRgqzH4YcwpKF6PoS4f8SEeLYoU51hXGl4Bww7NW3ecTQ63wPZyixo2h/hsxrhf/fL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnOehN3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA54C433F1;
	Wed, 20 Mar 2024 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710944526;
	bh=YeiTVtpHC2NPLqJdgcme5WeBzb4ywOWTrrfGUMyIySg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnOehN3b/wnZSMRQ2j/r1qmFplJ4uAOfyVZdB440PnrJ7/kg5FWXPsA71E7SwyhQP
	 +Y+TalNw0s1ODvvbHrcRv7ElvKRmG+qbIRo55HOipMetgy+z2Qw40dnBVVeikz9dxx
	 bGjWV1ZSDZxWgtW5C7iKh6CnNPnfH1y0Hl7GkopIeh20C/WY+RdAQFyrqb/TAlb9rH
	 GOIbjgrUDOEfgnqK99gYBa2kTGHqxSG46BdMtRI6hOh+yfosV/x1U047/fNOGaAwPR
	 SPhqMVSDnMVRaw1t8oDJfjvGb/ptgF/15b7x5nhwaoaOBfo6axehvgzfmP/jss7hYd
	 KMwnoQarXpLLg==
Date: Wed, 20 Mar 2024 15:21:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v5 8/9] rust: file: add `DeferredFdCloser`
Message-ID: <20240320-massieren-lackschaden-9b30825babec@brauner>
References: <20240209-alice-file-v5-0-a37886783025@google.com>
 <20240209-alice-file-v5-8-a37886783025@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209-alice-file-v5-8-a37886783025@google.com>

On Fri, Feb 09, 2024 at 11:18:21AM +0000, Alice Ryhl wrote:
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
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |   8 ++
>  rust/kernel/file.rs             | 184 +++++++++++++++++++++++++++++++++++++++-
>  rust/kernel/task.rs             |  14 +++
>  4 files changed, 207 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 4194b057ef6b..f4d9d04333c0 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,6 +10,7 @@
>  #include <linux/cred.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> +#include <linux/fdtable.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/jiffies.h>
> @@ -21,6 +22,7 @@
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/task_work.h>
>  #include <linux/workqueue.h>
>  
>  /* `bindgen` gets confused at certain things. */
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 58e3a9dff349..d146bbf25aec 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -32,6 +32,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/security.h>
>  #include <linux/spinlock.h>
> +#include <linux/task_work.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  
> @@ -243,6 +244,13 @@ void rust_helper_security_release_secctx(char *secdata, u32 seclen)
>  EXPORT_SYMBOL_GPL(rust_helper_security_release_secctx);
>  #endif
>  
> +void rust_helper_init_task_work(struct callback_head *twork,
> +				task_work_func_t func)
> +{
> +	init_task_work(twork, func);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_init_task_work);
> +
>  /*
>   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
>   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> index fb903b7f23fe..8902f490ccc8 100644
> --- a/rust/kernel/file.rs
> +++ b/rust/kernel/file.rs
> @@ -11,7 +11,8 @@
>      error::{code::*, Error, Result},
>      types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
>  };
> -use core::ptr;
> +use alloc::boxed::Box;
> +use core::{alloc::AllocError, mem, ptr};
>  
>  /// Flags associated with a [`File`].
>  pub mod flags {
> @@ -318,6 +319,187 @@ fn drop(&mut self) {
>      }
>  }
>  
> +/// Helper used for closing file descriptors in a way that is safe even if the file is currently
> +/// held using `fdget`.
> +///
> +/// Additional motivation can be found in commit 80cd795630d6 ("binder: fix use-after-free due to
> +/// ksys_close() during fdget()") and in the comments on `binder_do_fd_close`.
> +pub struct DeferredFdCloser {
> +    inner: Box<DeferredFdCloserInner>,
> +}
> +
> +/// SAFETY: This just holds an allocation with no real content, so there's no safety issue with
> +/// moving it across threads.
> +unsafe impl Send for DeferredFdCloser {}
> +unsafe impl Sync for DeferredFdCloser {}
> +
> +/// # Invariants
> +///
> +/// If the `file` pointer is non-null, then it points at a `struct file` and owns a refcount to
> +/// that file.
> +#[repr(C)]
> +struct DeferredFdCloserInner {
> +    twork: mem::MaybeUninit<bindings::callback_head>,
> +    file: *mut bindings::file,
> +}
> +
> +impl DeferredFdCloser {

So the explicitly deferred close is due to how binder works so it's not
much of a general purpose interface as I don't recall having other
codepaths with similar problems. So this should live in the binder
specific rust code imo.

> +    /// Create a new [`DeferredFdCloser`].
> +    pub fn new() -> Result<Self, AllocError> {
> +        Ok(Self {
> +            // INVARIANT: The `file` pointer is null, so the type invariant does not apply.
> +            inner: Box::try_new(DeferredFdCloserInner {
> +                twork: mem::MaybeUninit::uninit(),
> +                file: core::ptr::null_mut(),
> +            })?,
> +        })
> +    }
> +
> +    /// Schedule a task work that closes the file descriptor when this task returns to userspace.
> +    ///
> +    /// Fails if this is called from a context where we cannot run work when returning to
> +    /// userspace. (E.g., from a kthread.)
> +    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdCloseError> {
> +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
> +
> +        // In this method, we schedule the task work before closing the file. This is because
> +        // scheduling a task work is fallible, and we need to know whether it will fail before we
> +        // attempt to close the file.
> +
> +        // Task works are not available on kthreads.
> +        let current = crate::current!();
> +        if current.is_kthread() {
> +            return Err(DeferredFdCloseError::TaskWorkUnavailable);
> +        }
> +
> +        // Transfer ownership of the box's allocation to a raw pointer. This disables the
> +        // destructor, so we must manually convert it back to a Box to drop it.
> +        //
> +        // Until we convert it back to a `Box`, there are no aliasing requirements on this
> +        // pointer.
> +        let inner = Box::into_raw(self.inner);
> +
> +        // The `callback_head` field is first in the struct, so this cast correctly gives us a
> +        // pointer to the field.
> +        let callback_head = inner.cast::<bindings::callback_head>();
> +        // SAFETY: This pointer offset operation does not go out-of-bounds.
> +        let file_field = unsafe { core::ptr::addr_of_mut!((*inner).file) };
> +
> +        let current = current.as_raw();
> +
> +        // SAFETY: This function currently has exclusive access to the `DeferredFdCloserInner`, so
> +        // it is okay for us to perform unsynchronized writes to its `callback_head` field.
> +        unsafe { bindings::init_task_work(callback_head, Some(Self::do_close_fd)) };
> +
> +        // SAFETY: This inserts the `DeferredFdCloserInner` into the task workqueue for the current
> +        // task. If this operation is successful, then this transfers exclusive ownership of the
> +        // `callback_head` field to the C side until it calls `do_close_fd`, and we don't touch or
> +        // invalidate the field during that time.
> +        //
> +        // When the C side calls `do_close_fd`, the safety requirements of that method are
> +        // satisfied because when a task work is executed, the callback is given ownership of the
> +        // pointer.
> +        //
> +        // The file pointer is currently null. If it is changed to be non-null before `do_close_fd`
> +        // is called, then that change happens due to the write at the end of this function, and
> +        // that write has a safety comment that explains why the refcount can be dropped when
> +        // `do_close_fd` runs.
> +        let res = unsafe { bindings::task_work_add(current, callback_head, TWA_RESUME) };
> +
> +        if res != 0 {
> +            // SAFETY: Scheduling the task work failed, so we still have ownership of the box, so
> +            // we may destroy it.
> +            unsafe { drop(Box::from_raw(inner)) };
> +
> +            return Err(DeferredFdCloseError::TaskWorkUnavailable);
> +        }
> +
> +        // This removes the fd from the fd table in `current`. The file is not fully closed until
> +        // `filp_close` is called. We are given ownership of one refcount to the file.
> +        //
> +        // SAFETY: This is safe no matter what `fd` is. If the `fd` is valid (that is, if the
> +        // pointer is non-null), then we call `filp_close` on the returned pointer as required by
> +        // `file_close_fd`.
> +        let file = unsafe { bindings::file_close_fd(fd) };
> +        if file.is_null() {
> +            // We don't clean up the task work since that might be expensive if the task work queue
> +            // is long. Just let it execute and let it clean up for itself.
> +            return Err(DeferredFdCloseError::BadFd);
> +        }
> +
> +        // Acquire a second refcount to the file.
> +        //
> +        // SAFETY: The `file` pointer points at a file with a non-zero refcount.
> +        unsafe { bindings::get_file(file) };
> +
> +        // This method closes the fd, consuming one of our two refcounts. There could be active
> +        // light refcounts created from that fd, so we must ensure that the file has a positive
> +        // refcount for the duration of those active light refcounts. We do that by holding on to
> +        // the second refcount until the current task returns to userspace.
> +        //
> +        // SAFETY: The `file` pointer is valid. Passing `current->files` as the file table to close
> +        // it in is correct, since we just got the `fd` from `file_close_fd` which also uses
> +        // `current->files`.
> +        //
> +        // Note: fl_owner_t is currently a void pointer.
> +        unsafe { bindings::filp_close(file, (*current).files as bindings::fl_owner_t) };
> +
> +        // We update the file pointer that the task work is supposed to fput. This transfers
> +        // ownership of our last refcount.
> +        //
> +        // INVARIANT: This changes the `file` field of a `DeferredFdCloserInner` from null to
> +        // non-null. This doesn't break the type invariant for `DeferredFdCloserInner` because we
> +        // still own a refcount to the file, so we can pass ownership of that refcount to the
> +        // `DeferredFdCloserInner`.
> +        //
> +        // When `do_close_fd` runs, it must be safe for it to `fput` the refcount. However, this is
> +        // the case because all light refcounts that are associated with the fd we closed
> +        // previously must be dropped when `do_close_fd`, since light refcounts must be dropped
> +        // before returning to userspace.
> +        //
> +        // SAFETY: Task works are executed on the current thread right before we return to
> +        // userspace, so this write is guaranteed to happen before `do_close_fd` is called, which
> +        // means that a race is not possible here.
> +        unsafe { *file_field = file };
> +
> +        Ok(())
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// The provided pointer must point at the `twork` field of a `DeferredFdCloserInner` stored in
> +    /// a `Box`, and the caller must pass exclusive ownership of that `Box`. Furthermore, if the
> +    /// file pointer is non-null, then it must be okay to release the refcount by calling `fput`.
> +    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head) {
> +        // SAFETY: The caller just passed us ownership of this box.
> +        let inner = unsafe { Box::from_raw(inner.cast::<DeferredFdCloserInner>()) };
> +        if !inner.file.is_null() {
> +            // SAFETY: By the type invariants, we own a refcount to this file, and the caller
> +            // guarantees that dropping the refcount now is okay.
> +            unsafe { bindings::fput(inner.file) };
> +        }
> +        // The allocation is freed when `inner` goes out of scope.
> +    }
> +}
> +
> +/// Represents a failure to close an fd in a deferred manner.
> +#[derive(Copy, Clone, Debug, Eq, PartialEq)]
> +pub enum DeferredFdCloseError {
> +    /// Closing the fd failed because we were unable to schedule a task work.
> +    TaskWorkUnavailable,
> +    /// Closing the fd failed because the fd does not exist.
> +    BadFd,
> +}
> +
> +impl From<DeferredFdCloseError> for Error {
> +    fn from(err: DeferredFdCloseError) -> Error {
> +        match err {
> +            DeferredFdCloseError::TaskWorkUnavailable => ESRCH,
> +            DeferredFdCloseError::BadFd => EBADF,
> +        }
> +    }
> +}
> +
>  /// Represents the `EBADF` error code.
>  ///
>  /// Used for methods that can only fail with `EBADF`.
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index f46ea3ba9e8e..6adcd8ffcfde 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -145,6 +145,12 @@ fn deref(&self) -> &Self::Target {
>          }
>      }
>  
> +    /// Returns a raw pointer to the task.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::task_struct {
> +        self.0.get()
> +    }
> +
>      /// Returns the group leader of the given task.
>      pub fn group_leader(&self) -> &Task {
>          // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> @@ -189,6 +195,14 @@ pub fn pid_in_current_ns(&self) -> Pid {
>          unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
>      }
>  
> +    /// Returns whether this task corresponds to a kernel thread.
> +    pub fn is_kthread(&self) -> bool {
> +        // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid. There
> +        // are no further requirements to read the task's flags.
> +        let flags = unsafe { (*self.0.get()).flags };
> +        (flags & bindings::PF_KTHREAD) != 0
> +    }
> +
>      /// Wakes up the task.
>      pub fn wake_up(&self) {
>          // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
> 
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

