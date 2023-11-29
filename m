Return-Path: <linux-fsdevel+bounces-4236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4207FDF81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB938B20AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2795DF02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jErP8aZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAF1DDC9;
	Wed, 29 Nov 2023 17:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0472C433C8;
	Wed, 29 Nov 2023 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701277623;
	bh=8ovlfa1jt1/2RsMv84ug7kOY4w3Kdl7fxXEWpoiPyc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jErP8aZipGQn9AL7a6Rn8uXDKqUA8Rm4FqEXzQxdBb6lBkRgjYSmfK7tJOcjqN/qI
	 u2WrnBagL9Oc3neXQegD84MgB7PD9Dp+OaEg4ZzuGkIgGHPdzKh5wBRDvw6foLc5iv
	 NvT9Kyxq3yx961wAEJos3jdxxNqJdZoDm/YLEN01nWmwKGnqLcg8I/UQLjRkDIWIj1
	 hmPoYaUOvwWaZxjMlm0YfXJhcOJq7EZM6AzuAwzk0STykpAabVtPiaeYFsrDyXrWmk
	 A3RZ/TXG+A4/YEz3d+cickXh2zA2jgrYTw+ArcqBVSzIJCoStEmX/dbaRVub6spb5Y
	 /rpfbS+BgXnOQ==
Date: Wed, 29 Nov 2023 18:06:55 +0100
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
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <20231129-geleckt-verebben-04ea0c08a53c@brauner>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-alice-file-v1-1-f81afe8c7261@google.com>

On Wed, Nov 29, 2023 at 12:51:07PM +0000, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> This abstraction makes it possible to manipulate the open files for a
> process. The new `File` struct wraps the C `struct file`. When accessing
> it using the smart pointer `ARef<File>`, the pointer will own a
> reference count to the file. When accessing it as `&File`, then the
> reference does not own a refcount, but the borrow checker will ensure
> that the reference count does not hit zero while the `&File` is live.

Could you explain this in more details please? Ideally with some C and
how that translates to your Rust wrappers, please. Sorry, this is going
to be a long journey...

> 
> Since this is intended to manipulate the open files of a process, we
> introduce a `from_fd` constructor that corresponds to the C `fget`
> method. In future patches, it will become possible to create a new fd in
> a process and bind it to a `File`. Rust Binder will use these to send
> fds from one process to another.
> 
> We also provide a method for accessing the file's flags. Rust Binder
> will use this to access the flags of the Binder fd to check whether the
> non-blocking flag is set, which affects what the Binder ioctl does.
> 
> This introduces a struct for the EBADF error type, rather than just
> using the Error type directly. This has two advantages:
> * `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
>   compiler will represent as a single pointer, with null being an error.
>   This is possible because the compiler understands that `BadFdError`
>   has only one possible value, and it also understands that the
>   `ARef<File>` smart pointer is guaranteed non-null.
> * Additionally, we promise to users of the method that the method can
>   only fail with EBADF, which means that they can rely on this promise
>   without having to inspect its implementation.
> That said, there are also two disadvantages:
> * Defining additional error types involves boilerplate.
> * The question mark operator will only utilize the `From` trait once,
>   which prevents you from using the question mark operator on
>   `BadFdError` in methods that return some third error type that the
>   kernel `Error` is convertible into. (However, it works fine in methods
>   that return `Error`.)
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |   7 ++
>  rust/kernel/file.rs             | 182 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  4 files changed, 192 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 85f013ed4ca4..beed3ef1fbc3 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -8,6 +8,8 @@
>  
>  #include <kunit/test.h>
>  #include <linux/errname.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 70e59efd92bc..03141a3608a4 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -25,6 +25,7 @@
>  #include <linux/build_bug.h>
>  #include <linux/err.h>
>  #include <linux/errname.h>
> +#include <linux/fs.h>
>  #include <linux/mutex.h>
>  #include <linux/refcount.h>
>  #include <linux/sched/signal.h>
> @@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
>  
> +struct file *rust_helper_get_file(struct file *f)
> +{
> +	return get_file(f);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_get_file);
> +
>  /*
>   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
>   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> new file mode 100644
> index 000000000000..ee4ec8b919af
> --- /dev/null
> +++ b/rust/kernel/file.rs
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Files and file descriptors.
> +//!
> +//! C headers: [`include/linux/fs.h`](../../../../include/linux/fs.h) and
> +//! [`include/linux/file.h`](../../../../include/linux/file.h)
> +
> +use crate::{
> +    bindings,
> +    error::{code::*, Error, Result},
> +    types::{ARef, AlwaysRefCounted, Opaque},
> +};
> +use core::ptr;
> +
> +/// Flags associated with a [`File`].
> +pub mod flags {
> +    /// File is opened in append mode.
> +    pub const O_APPEND: u32 = bindings::O_APPEND;
> +
> +    /// Signal-driven I/O is enabled.
> +    pub const O_ASYNC: u32 = bindings::FASYNC;
> +
> +    /// Close-on-exec flag is set.
> +    pub const O_CLOEXEC: u32 = bindings::O_CLOEXEC;
> +
> +    /// File was created if it didn't already exist.
> +    pub const O_CREAT: u32 = bindings::O_CREAT;
> +
> +    /// Direct I/O is enabled for this file.
> +    pub const O_DIRECT: u32 = bindings::O_DIRECT;
> +
> +    /// File must be a directory.
> +    pub const O_DIRECTORY: u32 = bindings::O_DIRECTORY;
> +
> +    /// Like [`O_SYNC`] except metadata is not synced.
> +    pub const O_DSYNC: u32 = bindings::O_DSYNC;
> +
> +    /// Ensure that this file is created with the `open(2)` call.
> +    pub const O_EXCL: u32 = bindings::O_EXCL;
> +
> +    /// Large file size enabled (`off64_t` over `off_t`).
> +    pub const O_LARGEFILE: u32 = bindings::O_LARGEFILE;
> +
> +    /// Do not update the file last access time.
> +    pub const O_NOATIME: u32 = bindings::O_NOATIME;
> +
> +    /// File should not be used as process's controlling terminal.
> +    pub const O_NOCTTY: u32 = bindings::O_NOCTTY;
> +
> +    /// If basename of path is a symbolic link, fail open.
> +    pub const O_NOFOLLOW: u32 = bindings::O_NOFOLLOW;
> +
> +    /// File is using nonblocking I/O.
> +    pub const O_NONBLOCK: u32 = bindings::O_NONBLOCK;
> +
> +    /// Also known as `O_NDELAY`.
> +    ///
> +    /// This is effectively the same flag as [`O_NONBLOCK`] on all architectures
> +    /// except SPARC64.
> +    pub const O_NDELAY: u32 = bindings::O_NDELAY;
> +
> +    /// Used to obtain a path file descriptor.
> +    pub const O_PATH: u32 = bindings::O_PATH;
> +
> +    /// Write operations on this file will flush data and metadata.
> +    pub const O_SYNC: u32 = bindings::O_SYNC;
> +
> +    /// This file is an unnamed temporary regular file.
> +    pub const O_TMPFILE: u32 = bindings::O_TMPFILE;
> +
> +    /// File should be truncated to length 0.
> +    pub const O_TRUNC: u32 = bindings::O_TRUNC;
> +
> +    /// Bitmask for access mode flags.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::file;
> +    /// # fn do_something() {}
> +    /// # let flags = 0;
> +    /// if (flags & file::flags::O_ACCMODE) == file::flags::O_RDONLY {
> +    ///     do_something();
> +    /// }
> +    /// ```
> +    pub const O_ACCMODE: u32 = bindings::O_ACCMODE;
> +
> +    /// File is read only.
> +    pub const O_RDONLY: u32 = bindings::O_RDONLY;
> +
> +    /// File is write only.
> +    pub const O_WRONLY: u32 = bindings::O_WRONLY;
> +
> +    /// File can be both read and written.
> +    pub const O_RDWR: u32 = bindings::O_RDWR;
> +}
> +
> +/// Wraps the kernel's `struct file`.
> +///
> +/// # Invariants
> +///
> +/// Instances of this type are always ref-counted, that is, a call to `get_file` ensures that the
> +/// allocation remains valid at least until the matching call to `fput`.
> +#[repr(transparent)]
> +pub struct File(Opaque<bindings::file>);
> +
> +// SAFETY: By design, the only way to access a `File` is via an immutable reference or an `ARef`.
> +// This means that the only situation in which a `File` can be accessed mutably is when the
> +// refcount drops to zero and the destructor runs. It is safe for that to happen on any thread, so
> +// it is ok for this type to be `Send`.
> +unsafe impl Send for File {}
> +
> +// SAFETY: It's OK to access `File` through shared references from other threads because we're
> +// either accessing properties that don't change or that are properly synchronised by C code.

Uhm, what guarantees are you talking about specifically, please?
Examples would help.

> +unsafe impl Sync for File {}
> +
> +impl File {
> +    /// Constructs a new `struct file` wrapper from a file descriptor.
> +    ///
> +    /// The file descriptor belongs to the current process.
> +    pub fn from_fd(fd: u32) -> Result<ARef<Self>, BadFdError> {
> +        // SAFETY: FFI call, there are no requirements on `fd`.
> +        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
> +
> +        // INVARIANT: `fget` increments the refcount before returning.
> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> +    }

I think this is really misnamed.

File reference counting has two modes. For simplicity let's ignore
fdget_pos() for now:

(1) fdget()
    Return file either with or without an increased reference count.
    If the fdtable was shared increment reference count, if not don't
    increment refernce count.
(2) fget()
    Always increase refcount.

Your File implementation currently only deals with (2). And this
terminology is terribly important as far as I'm concerned. This wants to
be fget() and not from_fd(). The latter tells me nothing. I feel we
really need to try and mirror the current naming closely. Not
religiously ofc but core stuff such as this really benefits from having
an almost 1:1 mapping between C names and Rust names, I think.
Especially in the beginning.

> +
> +    /// Creates a reference to a [`File`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at a valid file and that its refcount does not
> +    /// reach zero during the lifetime 'a.
> +    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
> +        // INVARIANT: The safety requirements guarantee that the refcount does not hit zero during
> +        // 'a. The cast is okay because `File` is `repr(transparent)`.
> +        unsafe { &*ptr.cast() }
> +    }

How does that work and what is this used for? It's required that a
caller has called from_fd()/fget() first before from_ptr() can be used?

Can you show how this would be used in an example, please? Unless you
hold file_lock it is now invalid to access fields in struct file just
with rcu lock held for example. Which is why returning a pointer without
holding a reference seems dodgy. I'm probably just missing context.

> +
> +    /// Returns the flags associated with the file.
> +    ///
> +    /// The flags are a combination of the constants in [`flags`].
> +    pub fn flags(&self) -> u32 {
> +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
> +        //
> +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.

I really need to understand what you mean by shared reference. At least
in the current C implementation you can't share a reference without
another task as the other task might fput() behind you and then you're
hosed. That's why we have the fdget() logic.

> +        //
> +        // TODO: Replace with `read_once` when available on the Rust side.
> +        unsafe { core::ptr::addr_of!((*self.0.get()).f_flags).read_volatile() }
> +    }
> +}
> +
> +// SAFETY: The type invariants guarantee that `File` is always ref-counted.
> +unsafe impl AlwaysRefCounted for File {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> +        unsafe { bindings::get_file(self.0.get()) };
> +    }

Why inc_ref() and not just get_file()?

> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> +        unsafe { bindings::fput(obj.cast().as_ptr()) }
> +    }

Ok, so this makes me think that from_ptr() requires you to have called
from_fd()/fget() first which would be good.

> +}
> +
> +/// Represents the `EBADF` error code.
> +///
> +/// Used for methods that can only fail with `EBADF`.
> +pub struct BadFdError;
> +
> +impl From<BadFdError> for Error {
> +    fn from(_: BadFdError) -> Error {
> +        EBADF
> +    }
> +}
> +
> +impl core::fmt::Debug for BadFdError {
> +    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
> +        f.pad("EBADF")
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e6aff80b521f..ce9abceab784 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -34,6 +34,7 @@
>  mod allocator;
>  mod build_assert;
>  pub mod error;
> +pub mod file;
>  pub mod init;
>  pub mod ioctl;
>  #[cfg(CONFIG_KUNIT)]
> 
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 

