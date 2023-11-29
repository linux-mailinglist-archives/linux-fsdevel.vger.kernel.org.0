Return-Path: <linux-fsdevel+bounces-4220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9817FDD57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A380282581
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FB93B787
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhSCVNXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522A374DF;
	Wed, 29 Nov 2023 16:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED8FC433C8;
	Wed, 29 Nov 2023 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701274463;
	bh=uvJU3eH/XxZmi3lj0tA86wCTtEJNJwwsP4sFPa3oUOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhSCVNXGfk+Gcu/2TcZA43P3knbqsOAUiyui6bornKk0YxSWSG4rUYcUvaON/TQJ7
	 Ryh6FIcINp/e/9AODJttOsGnqP43WiV7ioP/w0m9OwNEBUnrr/zCAtIDPQF1Tsx60s
	 Zs/WRYlRItAyazwSoLQauC2onfOzqd3T3JlMjuLyMzwEDELNE+oUvE1NmkBapjA+bh
	 XzBTiv/W7gj9TbM4c/XAdDMLsDkInVVKt6OR/kyTzE+gMt98My/0vmS3V2SbQSnRQq
	 WnhDEgPflGwhxjk+PtuI510+uUe3zwTvpE2KZ/H22RFLJdyex+uTma+2RdoMqoMbRT
	 BbNMB0zeOxD8g==
Date: Wed, 29 Nov 2023 17:14:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
Message-ID: <20231129-zwiespalt-exakt-f1446d88a62a@brauner>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-4-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-alice-file-v1-4-f81afe8c7261@google.com>

On Wed, Nov 29, 2023 at 01:11:56PM +0000, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Allow for the creation of a file descriptor in two steps: first, we
> reserve a slot for it, then we commit or drop the reservation. The first
> step may fail (e.g., the current process ran out of available slots),
> but commit and drop never fail (and are mutually exclusive).
> 
> This is needed by Rust Binder when fds are sent from one process to
> another. It has to be a two-step process to properly handle the case
> where multiple fds are sent: The operation must fail or succeed
> atomically, which we achieve by first reserving the fds we need, and
> only installing the files once we have reserved enough fds to send the
> files.
> 
> Fd reservations assume that the value of `current` does not change
> between the call to get_unused_fd_flags and the call to fd_install (or
> put_unused_fd). By not implementing the Send trait, this abstraction
> ensures that the `FileDescriptorReservation` cannot be moved into a
> different process.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/file.rs | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> index f1f71c3d97e2..2186a6ea3f2f 100644
> --- a/rust/kernel/file.rs
> +++ b/rust/kernel/file.rs
> @@ -11,7 +11,7 @@
>      error::{code::*, Error, Result},
>      types::{ARef, AlwaysRefCounted, Opaque},
>  };
> -use core::ptr;
> +use core::{marker::PhantomData, ptr};
>  
>  /// Flags associated with a [`File`].
>  pub mod flags {
> @@ -180,6 +180,68 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>      }
>  }
>  
> +/// A file descriptor reservation.
> +///
> +/// This allows the creation of a file descriptor in two steps: first, we reserve a slot for it,
> +/// then we commit or drop the reservation. The first step may fail (e.g., the current process ran
> +/// out of available slots), but commit and drop never fail (and are mutually exclusive).
> +///
> +/// Dropping the reservation happens in the destructor of this type.
> +///
> +/// # Invariants
> +///
> +/// The fd stored in this struct must correspond to a reserved file descriptor of the current task.
> +pub struct FileDescriptorReservation {

Can we follow the traditional file terminology, i.e.,
get_unused_fd_flags() and fd_install()? At least at the beginning this
might be quite helpful instead of having to mentally map new() and
commit() onto the C functions.

> +    fd: u32,
> +    /// Prevent values of this type from being moved to a different task.
> +    ///
> +    /// This is necessary because the C FFI calls assume that `current` is set to the task that
> +    /// owns the fd in question.
> +    _not_send_sync: PhantomData<*mut ()>,

I don't fully understand this. Can you explain in a little more detail
what you mean by this and how this works?

> +}
> +
> +impl FileDescriptorReservation {
> +    /// Creates a new file descriptor reservation.
> +    pub fn new(flags: u32) -> Result<Self> {
> +        // SAFETY: FFI call, there are no safety requirements on `flags`.
> +        let fd: i32 = unsafe { bindings::get_unused_fd_flags(flags) };
> +        if fd < 0 {
> +            return Err(Error::from_errno(fd));
> +        }
> +        Ok(Self {
> +            fd: fd as _,

This is a cast to a u32?

> +            _not_send_sync: PhantomData,

Can you please draft a quick example how that return value would be
expected to be used by a caller? It's really not clear 

> +        })
> +    }
> +
> +    /// Returns the file descriptor number that was reserved.
> +    pub fn reserved_fd(&self) -> u32 {
> +        self.fd
> +    }
> +
> +    /// Commits the reservation.
> +    ///
> +    /// The previously reserved file descriptor is bound to `file`. This method consumes the
> +    /// [`FileDescriptorReservation`], so it will not be usable after this call.
> +    pub fn commit(self, file: ARef<File>) {
> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
> +        // guaranteed to have an owned ref count by its type invariants.
> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };

Why file.0.get()? Where did that come from?

> +
> +        // `fd_install` consumes both the file descriptor and the file reference, so we cannot run
> +        // the destructors.
> +        core::mem::forget(self);
> +        core::mem::forget(file);
> +    }
> +}
> +
> +impl Drop for FileDescriptorReservation {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.fd` was returned by a previous call to `get_unused_fd_flags`.
> +        unsafe { bindings::put_unused_fd(self.fd) };
> +    }
> +}
> +
>  /// Represents the `EBADF` error code.
>  ///
>  /// Used for methods that can only fail with `EBADF`.
> 
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 

