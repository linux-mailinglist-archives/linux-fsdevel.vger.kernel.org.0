Return-Path: <linux-fsdevel+bounces-14908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B16881463
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 16:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F181C218DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870E053378;
	Wed, 20 Mar 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B54hz+RX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD202524B7;
	Wed, 20 Mar 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948030; cv=none; b=tbQsr9Vy3Jk4gLIUWR36Y8lS6PerF9juf1gwJPgc7weQpbsKJgBZDK9WUhfUPf/6uDLuBqM5rxbia9WHvD6Bq/+LdpnRrYu0UumqRWH/a78VaWrit+j5HfmW9epPq/xRHvcLXiDCqs7+OmCbUYxPDsoeILY3z+MJp85qxJ7ZP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948030; c=relaxed/simple;
	bh=5xhGYzjIhTvHnRe5USdUzKPZAEI/ek4ZOixku584Vr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAfWR1lSw16YkuE3nmBxz5b2DFgasT5/6yQE62B4/onMWoq8sfR3LOFkk5rFUbVj5/H6TPV9Wj/LiACqsyLHyMK1dxAALpXcOYoshfSjQS2P5+qcV+Y75I+EmUdF9za0Cy7A+S7q7Wsat2PJvH6ZsfN3KS5mynYJiyn+9tX+7S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B54hz+RX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0ADC43390;
	Wed, 20 Mar 2024 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948029;
	bh=5xhGYzjIhTvHnRe5USdUzKPZAEI/ek4ZOixku584Vr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B54hz+RX9R9nM2ThzIeqW44Ilda9ha3rkQY5+cgsmKWySQerscmW+xea38h3LA+4S
	 V24dpSBYgi1PWKL9kdRWZgLTXokC1gfjQ2SEhLXX6STIFuemLlqfj+uhcagv0+Dzl7
	 i79uJdVIO/sJfVgt49oDEfemED/ZbLMjpqxRtbAEujqcgms8k+wIBAOlbJtHN8Vgcc
	 UpywGJVRTk2/8U8sNqEGn1VVKfmrlTQsscHfWp9Zt+OlQEg0K+3omQzcoTWvjtVpPP
	 5HypfLt2GF+aBej85l92z0KEk0Tr6+lm+WzEt421d+td4T7x7DM4c8NmAM6mNHT7y7
	 /Vn37AVIUi7qw==
Date: Wed, 20 Mar 2024 16:20:20 +0100
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
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH v5 3/9] rust: file: add Rust abstraction for `struct file`
Message-ID: <20240320-wegziehen-teilhaben-86e071fa163c@brauner>
References: <20240209-alice-file-v5-0-a37886783025@google.com>
 <20240209-alice-file-v5-3-a37886783025@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209-alice-file-v5-3-a37886783025@google.com>

On Fri, Feb 09, 2024 at 11:18:16AM +0000, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> This abstraction makes it possible to manipulate the open files for a
> process. The new `File` struct wraps the C `struct file`. When accessing
> it using the smart pointer `ARef<File>`, the pointer will own a
> reference count to the file. When accessing it as `&File`, then the
> reference does not own a refcount, but the borrow checker will ensure
> that the reference count does not hit zero while the `&File` is live.
> 
> Since this is intended to manipulate the open files of a process, we
> introduce an `fget` constructor that corresponds to the C `fget`
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

Sorry, where's that method?

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
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  fs/file.c                       |   7 ++
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |   7 ++
>  rust/kernel/file.rs             | 254 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  5 files changed, 271 insertions(+)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 3b683b9101d8..f2eab5fcb87f 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1127,6 +1127,13 @@ EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
>   *
>   * The fput_needed flag returned by fget_light should be passed to the
>   * corresponding fput_light.
> + *
> + * (As an exception to rule 2, you can call filp_close between fget_light and
> + * fput_light provided that you capture a real refcount with get_file before
> + * the call to filp_close, and ensure that this real refcount is fput *after*
> + * the fput_light call.)
> + *
> + * See also the documentation in rust/kernel/file.rs.
>   */
>  static unsigned long __fget_light(unsigned int fd, fmode_t mask)
>  {
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 936651110c39..41fcd2905ed4 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -9,6 +9,8 @@
>  #include <kunit/test.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
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
> index 000000000000..cf8ebf619379
> --- /dev/null
> +++ b/rust/kernel/file.rs
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Files and file descriptors.
> +//!
> +//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h) and
> +//! [`include/linux/file.h`](srctree/include/linux/file.h)
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
> +    /// File is using nonblocking I/O.
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
> +/// This represents an open file rather than a file on a filesystem. Processes generally reference
> +/// open files using file descriptors. However, file descriptors are not the same as files. A file
> +/// descriptor is just an integer that corresponds to a file, and a single file may be referenced
> +/// by multiple file descriptors.
> +///
> +/// # Refcounting
> +///
> +/// Instances of this type are reference-counted. The reference count is incremented by the
> +/// `fget`/`get_file` functions and decremented by `fput`. The Rust type `ARef<File>` represents a
> +/// pointer that owns a reference count on the file.
> +///
> +/// Whenever a process opens a file descriptor (fd), it stores a pointer to the file in its `struct
> +/// files_struct`. This pointer owns a reference count to the file, ensuring the file isn't
> +/// prematurely deleted while the file descriptor is open. In Rust terminology, the pointers in
> +/// `struct files_struct` are `ARef<File>` pointers.
> +///
> +/// ## Light refcounts
> +///
> +/// Whenever a process has an fd to a file, it may use something called a "light refcount" as a
> +/// performance optimization. Light refcounts are acquired by calling `fdget` and released with
> +/// `fdput`. The idea behind light refcounts is that if the fd is not closed between the calls to
> +/// `fdget` and `fdput`, then the refcount cannot hit zero during that time, as the `struct
> +/// files_struct` holds a reference until the fd is closed. This means that it's safe to access the
> +/// file even if `fdget` does not increment the refcount.
> +///
> +/// The requirement that the fd is not closed during a light refcount applies globally across all
> +/// threads - not just on the thread using the light refcount. For this reason, light refcounts are
> +/// only used when the `struct files_struct` is not shared with other threads, since this ensures
> +/// that other unrelated threads cannot suddenly start using the fd and close it. Therefore,
> +/// calling `fdget` on a shared `struct files_struct` creates a normal refcount instead of a light
> +/// refcount.

When the fdget() calling task doesn't have a shared file descriptor
table fdget() will not increment the reference count, yes. This
also implies that you cannot have task A use fdget() and then pass
f.file to task B that holds on to it while A returns to userspace. It's
irrelevant that task A won't drop the reference count or that task B
won't drop the reference count. Because task A could return back to
userspace and immediately close the fd via a regular close() system call
at which point task B has a UAF. In other words a file that has been
gotten via fdget() can't be Send to another task without the Send
implying taking a reference to it.

> +///
> +/// Light reference counts must be released with `fdput` before the system call returns to
> +/// userspace. This means that if you wait until the current system call returns to userspace, then
> +/// all light refcounts that existed at the time have gone away.
> +///
> +/// ## Rust references
> +///
> +/// The reference type `&File` is similar to light refcounts:
> +///
> +/// * `&File` references don't own a reference count. They can only exist as long as the reference
> +///   count stays positive, and can only be created when there is some mechanism in place to ensure
> +///   this.
> +///
> +/// * The Rust borrow-checker normally ensures this by enforcing that the `ARef<File>` from which
> +///   a `&File` is created outlives the `&File`.

The section confuses me a little: Does the borrow-checker always ensure
that a &File stays valid or are there circumstances where it doesn't or
are you saying it doesn't enforce it?

> +///
> +/// * Using the unsafe [`File::from_ptr`] means that it is up to the caller to ensure that the
> +///   `&File` only exists while the reference count is positive.

What is this used for in binder? If it's not used don't add it.

> +///
> +/// * You can think of `fdget` as using an fd to look up an `ARef<File>` in the `struct

Could you explain why there isn't an explicit fdget() then and you have
that from_ptr() method?

> +///   files_struct` and create an `&File` from it. The "fd cannot be closed" rule is like the Rust
> +///   rule "the `ARef<File>` must outlive the `&File`".
> +///
> +/// # Invariants
> +///
> +/// * Instances of this type are refcounted using the `f_count` field.
> +/// * If an fd with active light refcounts is closed, then it must be the case that the file
> +///   refcount is positive until all light refcounts of the fd have been dropped.
> +/// * A light refcount must be dropped before returning to userspace.
> +#[repr(transparent)]
> +pub struct File(Opaque<bindings::file>);
> +
> +// SAFETY:
> +// - `File::dec_ref` can be called from any thread.
> +// - It is okay to send ownership of `struct file` across thread boundaries.
> +unsafe impl Send for File {}
> +
> +// SAFETY: All methods defined on `File` that take `&self` are safe to call even if other threads
> +// are concurrently accessing the same `struct file`, because those methods either access immutable
> +// properties or have proper synchronization to ensure that such accesses are safe.
> +unsafe impl Sync for File {}
> +
> +impl File {
> +    /// Constructs a new `struct file` wrapper from a file descriptor.
> +    ///
> +    /// The file descriptor belongs to the current process.
> +    pub fn fget(fd: u32) -> Result<ARef<Self>, BadFdError> {
> +        // SAFETY: FFI call, there are no requirements on `fd`.
> +        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
> +
> +        // SAFETY: `bindings::fget` either returns null or a valid pointer to a file, and we
> +        // checked for null above.
> +        //
> +        // INVARIANT: `bindings::fget` creates a refcount, and we pass ownership of the refcount to
> +        // the new `ARef<File>`.
> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> +    }
> +
> +    /// Creates a reference to a [`File`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at a valid file and that the file's refcount is
> +    /// positive for the duration of 'a.
> +    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
> +        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
> +        // duration of 'a. The cast is okay because `File` is `repr(transparent)`.
> +        //
> +        // INVARIANT: The safety requirements guarantee that the refcount does not hit zero during
> +        // 'a.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Returns a raw pointer to the inner C struct.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::file {
> +        self.0.get()
> +    }
> +
> +    /// Returns the flags associated with the file.
> +    ///
> +    /// The flags are a combination of the constants in [`flags`].
> +    pub fn flags(&self) -> u32 {
> +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
> +        //
> +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
> +        //
> +        // FIXME(read_once): Replace with `read_once` when available on the Rust side.
> +        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
> +    }
> +}
> +
> +// SAFETY: The type invariants guarantee that `File` is always ref-counted. This implementation
> +// makes `ARef<File>` own a normal refcount.
> +unsafe impl AlwaysRefCounted for File {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> +        unsafe { bindings::get_file(self.as_ptr()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<File>) {
> +        // SAFETY: To call this method, the caller passes us ownership of a normal refcount, so we
> +        // may drop it. The cast is okay since `File` has the same representation as `struct file`.
> +        unsafe { bindings::fput(obj.cast().as_ptr()) }
> +    }
> +}
> +
> +/// Represents the `EBADF` error code.
> +///
> +/// Used for methods that can only fail with `EBADF`.
> +#[derive(Copy, Clone, Eq, PartialEq)]
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
> index b89ecf4e97a0..9353dd713a20 100644
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
> 2.43.0.687.g38aa6559b0-goog
> 

