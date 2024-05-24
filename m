Return-Path: <linux-fsdevel+bounces-20124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A2B8CE880
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 18:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204821C213E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD0212EBC0;
	Fri, 24 May 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMEhoutq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792912E1CD;
	Fri, 24 May 2024 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567172; cv=none; b=iTZqGdkJm639zkP4Q8Ac9KwW5ANiKOmdr+6Q0iAGZFQJqx/xfqRxkqo0BMLkweIiwh4S7WaVm3uFYr06zi2V3k1isYdjJX7YfTXkWrdxalbgbJNq0q+OByOyIAT8jNoCnRUXXOnhsvUmdlkrRaqIlMu2TWf03tgxIwJydvnBG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567172; c=relaxed/simple;
	bh=zDIf2MqPrX1QD9RneQtDlvbTGMHdA8cyyJhczusGH0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4BouUx/8SfPybBKv6SucrhsSc0Nte7s+0ABg2nz7wfsQ+V1z9tP1ubvndBRUblx57BT4BrnLK23l1Gf88I4byQ1Ze4EFKgod80AMhot4vEeDbyUpoNisLiIjx1luERsFWZw/stx4RL2w7d8KqokkAhHI16OG4aSAjrvxnXWlZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMEhoutq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F79AC2BBFC;
	Fri, 24 May 2024 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716567171;
	bh=zDIf2MqPrX1QD9RneQtDlvbTGMHdA8cyyJhczusGH0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMEhoutqB27Td8HsZbHRYU/XL7cF5zDj8pvTHox+ZTF0UWsKbHRNcO/zL5s/CdKa0
	 KKcQXWnEOKCogDWLTkhaMordfJ2YXVI5oK6J3Lyscrr7UXiCU6Iyv3TZmFcTwfAw6N
	 dAxC9DVTRXzCGnr4h8zM+PN5NI5Ka6LBSa86ebtYoOWBgT5HMDpSpGqCLs7cmBLGn7
	 NU3ZLgx6f/SjsvN4X0so4eaivLQf1YwN4xe9Ct286WZaZChpLxy7985AOIAIkySuzH
	 t3khjAw4s1xLnpu5Xc6zPCZ1u+ulkfaZd2fCI0lpBKJ0tFNAOrb/hQwAiAXguMa3hr
	 btPVqTbbQ8loQ==
Date: Fri, 24 May 2024 18:12:43 +0200
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
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
Message-ID: <20240524-anhieb-bundesweit-e1b0227fd3ed@brauner>
References: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
 <20240517-alice-file-v6-3-b25bafdc9b97@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240517-alice-file-v6-3-b25bafdc9b97@google.com>

On Fri, May 17, 2024 at 09:30:36AM +0000, Alice Ryhl wrote:
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
> * `File::fget` returns a `Result<ARef<File>, BadFdError>`, which the
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
>  fs/file.c                       |   7 +
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |   7 +
>  rust/kernel/file.rs             | 330 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/types.rs            |   8 +
>  6 files changed, 355 insertions(+)
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
> index ddb5644d4fd9..541afef7ddc4 100644
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
> index 4c8b7b92a4f4..5545a00560d1 100644
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
> index 000000000000..ad881e67084c
> --- /dev/null
> +++ b/rust/kernel/file.rs
> @@ -0,0 +1,330 @@
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
> +use core::{marker::PhantomData, ptr};
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
> +/// Compile-time information for keeping track of how a [`File`] is shared.
> +///
> +/// The `fdget_pos` method can be used to access the file's position without taking `f_pos_lock`,
> +/// as long as the file is not shared with any other threads. During such calls to `fdget_pos`, the
> +/// file must remain non-shared, so it must not be possible to move the file to another thread. For
> +/// example, if the file is moved to another thread, then it could be passed to `fd_install`, at
> +/// which point the remote process could touch the file position.
> +///
> +/// The share mode only keeps track of whether there are active `fdget_pos` calls that did not take
> +/// the `f_pos_lock`, and does not keep track of `fdget` calls. This is okay because `fdget` does
> +/// not care about the refcount of the underlying `struct file`; as long as the entry in the
> +/// current thread's fd table does not get removed, it's okay to share the file. For example,
> +/// `fd_install`ing the `struct file` into another process is okay during an `fdget` call, because
> +/// the other process can't touch the fd table of the original process.
> +mod share_mode {
> +    /// Trait implemented by the two sharing modes that a file might have.
> +    pub trait FileShareMode {}
> +
> +    /// Represents a file for which there might be an active call to `fdget_pos` that did not take
> +    /// the `f_pos_lock` lock.
> +    pub enum MaybeFdgetPos {}
> +
> +    /// Represents a file for which it is known that all active calls to `fdget_pos` (if any) took
> +    /// the `f_pos_lock` lock.
> +    pub enum NoFdgetPos {}
> +
> +    impl FileShareMode for MaybeFdgetPos {}
> +    impl FileShareMode for NoFdgetPos {}
> +}
> +pub use self::share_mode::{FileShareMode, MaybeFdgetPos, NoFdgetPos};
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
> +/// Whenever a process opens a file descriptor (fd), it stores a pointer to the file in its fd
> +/// table (`struct files_struct`). This pointer owns a reference count to the file, ensuring the
> +/// file isn't prematurely deleted while the file descriptor is open. In Rust terminology, the
> +/// pointers in `struct files_struct` are `ARef<File>` pointers.
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
> +///
> +/// Light reference counts must be released with `fdput` before the system call returns to
> +/// userspace. This means that if you wait until the current system call returns to userspace, then
> +/// all light refcounts that existed at the time have gone away.

You obviously are aware of this but I'm just spelling it out. Iirc,
there will practically only ever be one light refcount per file.

For a light refcount to be used we know that the file descriptor table
isn't shared with any other task. So there are no threads that could
concurrently access the file descriptor table. We also know that the
file descriptor table cannot become shared while we're in system call
context because the caller can't create new threads and they can't
unshare the file descriptor table.

So there's only one fdget() caller (Yes, they could call fdget()
multiple times and then have to do fdput() multiple times but that's a
level of weirdness that we don't need to worry about.).

> +///
> +/// ### The file position
> +///
> +/// Each `struct file` has a position integer, which is protected by the `f_pos_lock` mutex.
> +/// However, if the `struct file` is not shared, then the kernel may avoid taking the lock as a
> +/// performance optimization.
> +///
> +/// The condition for avoiding the `f_pos_lock` mutex is different from the condition for using
> +/// `fdget`. With `fdget`, you may avoid incrementing the refcount as long as the current fd table
> +/// is not shared; it is okay if there are other fd tables that also reference the same `struct
> +/// file`. However, `fdget_pos` can only avoid taking the `f_pos_lock` if the entire `struct file`
> +/// is not shared, as different processes with an fd to the same `struct file` share the same
> +/// position.
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
> +///
> +/// * Using the unsafe [`File::from_ptr`] means that it is up to the caller to ensure that the
> +///   `&File` only exists while the reference count is positive.
> +///
> +/// * You can think of `fdget` as using an fd to look up an `ARef<File>` in the `struct
> +///   files_struct` and create an `&File` from it. The "fd cannot be closed" rule is like the Rust
> +///   rule "the `ARef<File>` must outlive the `&File`".
> +///
> +/// # Invariants
> +///
> +/// * All instances of this type are refcounted using the `f_count` field.
> +/// * If the file sharing mode is `MaybeFdgetPos`, then all active calls to `fdget_pos` that did
> +///   not take the `f_pos_lock` mutex must be on the same thread as this `File`.
> +/// * If the file sharing mode is `NoFdgetPos`, then there must not be active calls to `fdget_pos`
> +///   that did not take the `f_pos_lock` mutex.
> +#[repr(transparent)]
> +pub struct File<S: FileShareMode> {
> +    inner: Opaque<bindings::file>,
> +    _share_mode: PhantomData<S>,
> +}
> +
> +// SAFETY: This file is known to not have any local active `fdget_pos` calls, so it is safe to
> +// transfer it between threads.
> +unsafe impl Send for File<NoFdgetPos> {}
> +
> +// SAFETY: This file is known to not have any local active `fdget_pos` calls, so it is safe to
> +// access its methods from several threads in parallel.
> +unsafe impl Sync for File<NoFdgetPos> {}
> +
> +/// File methods that only exist under the [`MaybeFdgetPos`] sharing mode.
> +impl File<MaybeFdgetPos> {
> +    /// Constructs a new `struct file` wrapper from a file descriptor.
> +    ///
> +    /// The file descriptor belongs to the current process, and there might be active local calls
> +    /// to `fdget_pos`.
> +    pub fn fget(fd: u32) -> Result<ARef<File<MaybeFdgetPos>>, BadFdError> {
> +        // SAFETY: FFI call, there are no requirements on `fd`.
> +        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
> +
> +        // SAFETY: `bindings::fget` created a refcount, and we pass ownership of it to the `ARef`.
> +        //
> +        // INVARIANT: This file is in the fd table on this thread, so either all `fdget_pos` calls
> +        // are on this thread, or the file is shared, in which case `fdget_pos` calls took the
> +        // `f_pos_lock` mutex.
> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> +    }

I'm a little unclear how this is supposed to be used. What I
specifically struggle with is what function does one have to call to
translate from a file descriptor to a file? IOW, where are the actual
entry points for turning fds into files? That's what I want to see and
that's what we need to make this interface usable generically.

Because naively, what I'm looking for is a Rust version of fdget() and
fdget_pos() that give me back a File<MaybeFdget> or a
File<MaybeFdgetPos>.

And then those both implement a get_file() method so the caller can take
an explicit long-term reference to the file.

The fget() above is really confusing to me because it always takes a
reference on the file that's pointed to by the fd and then it returns a
MaybeFdgetPos because presumably you want to indicate that the file
descriptor may refer to a file that may or may not be referenced by
another thread via fdget()/fdget_pos() already.

So I've _skimmed_ the binder RFC and looked at:
20231101-rust-binder-v1-13-08ba9197f637@google.com
which states:

	Add support for sending fds over binder.

	Unlike the other object types, file descriptors are not translated until
	the transaction is actually received by the recipient. Until that
	happens, we store `u32::MAX` as the fd.

	Translating fds is done in a two-phase process. First, the file
	descriptors are allocated and written to the allocation. Then, once we
	have allocated all of them, we commit them to the files in question.
	Using this strategy, we are able to guarantee that we either send all of
	the fds, or none of them.

So I'm curious. How does the binder fd sending work exactly? Because I
feel that this is crucial to understand here. Some specific questions:

* When file descriptors are passed the reference to these files via
  fget() are taken _synchronously_, i.e., by the sending task, not the
  receiver? IOW, is binder_translate_fd() called in the context of the
  sender or the receiver. I assume it must be the sender because
  otherwise the sender and receiver must share a file descriptor table
  in order for the receiver to call fget().

* The receiving task then allocates new file descriptors and installs
  the received files into its file descriptor table?

And so basically, what I'm after here is that the binder_translate_fd()
that calls fget() is done in the context of the sender and we _know_
that the fds can't have light references. Because if they did it could
only be by the calling task but they don't since the calling task uses
fget() on them. And if the calling task is multi-threaded and another
thread has called fdget() or fdget_pos() we know that they have taken
their own reference because the file descriptor table is shared.

So why is that fget() in here returning a File<MaybeFdgetPos>? This
doesn't make sense to me at first glance.

> +
> +    /// Assume that there are no active `fdget_pos` calls that prevent us from sharing this file.
> +    ///
> +    /// This makes it safe to transfer this file to other threads. No checks are performed, and
> +    /// using it incorrectly may lead to a data race on the file position if the file is shared
> +    /// with another thread.
> +    ///
> +    /// This method is intended to be used together with [`File::fget`] when the caller knows
> +    /// statically that there are no `fdget_pos` calls on the current thread. For example, you
> +    /// might use it when calling `fget` from an ioctl, since ioctls usually do not touch the file
> +    /// position.
> +    ///
> +    /// # Safety
> +    ///
> +    /// There must not be any active `fdget_pos` calls on the current thread.
> +    pub unsafe fn assume_no_fdget_pos(me: ARef<Self>) -> ARef<File<NoFdgetPos>> {
> +        // INVARIANT: There are no `fdget_pos` calls on the current thread, and by the type
> +        // invariants, if there is a `fdget_pos` call on another thread, then it took the
> +        // `f_pos_lock` mutex.
> +        //
> +        // SAFETY: `File<MaybeFdgetPos>` and `File<NoFdgetPos>` have the same layout.
> +        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
> +    }
> +}
> +
> +/// File methods that exist under all sharing modes.
> +impl<S: FileShareMode> File<S> {
> +    /// Creates a reference to a [`File`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * The caller must ensure that `ptr` points at a valid file and that the file's refcount is
> +    ///   positive for the duration of 'a.
> +    /// * The caller must ensure that the requirements for using the chosen file sharing mode are
> +    ///   upheld.
> +    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File<S> {

I think I requested from_raw_file() in the last revision?

> +        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
> +        // duration of 'a. The cast is okay because `File` is `repr(transparent)`.
> +        //
> +        // INVARIANT: The safety requirements guarantee that the refcount does not hit zero during
> +        // 'a. The caller guarantees to uphold the requirements for the chosen sharing mode.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Returns a raw pointer to the inner C struct.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::file {

And that was supposed to be into_raw_file() or as_raw_file()?

> +        self.inner.get()
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
> +unsafe impl<S: FileShareMode> AlwaysRefCounted for File<S> {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> +        unsafe { bindings::get_file(self.as_ptr()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<File<S>>) {
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
> index 9a943d99c71a..c583fd27736d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -29,6 +29,7 @@
>  pub mod alloc;
>  mod build_assert;
>  pub mod error;
> +pub mod file;
>  pub mod init;
>  pub mod ioctl;
>  #[cfg(CONFIG_KUNIT)]
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 93734677cfe7..3ec2b12afbee 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -366,6 +366,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>              _p: PhantomData,
>          }
>      }
> +
> +    /// Convert this [`ARef`] into a raw pointer.
> +    ///
> +    /// The caller retains ownership of the refcount that this `ARef` used to own.
> +    pub fn into_raw(me: Self) -> NonNull<T> {
> +        let me = core::mem::ManuallyDrop::new(me);
> +        me.ptr
> +    }
>  }
>  
>  impl<T: AlwaysRefCounted> Clone for ARef<T> {
> 
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 

