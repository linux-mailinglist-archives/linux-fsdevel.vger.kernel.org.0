Return-Path: <linux-fsdevel+bounces-20152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1773A8CEEC8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 13:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917F21F21112
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 11:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34083CF4E;
	Sat, 25 May 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Piwu36B0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E64B660;
	Sat, 25 May 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638038; cv=none; b=qYwZ1c/FpkdUiMKRjScSWJ59PgxpRiixAx/6hzttYGllyfXc6ddDOclJPYixCIfDZk4nmMCSbID6FZqrhdITNCmQwVay+wt8dVMVCKt+s5UZYsAZnMJOKsVyp0VzOyEv+FFm/IIxsd1/qU9Gz8jdsKNTy0HLFToL/EfqblZ94Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638038; c=relaxed/simple;
	bh=iffO3tGrRnH2Mjp2Mx8aBI94e5YrL+GUBGqMm/x9HY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db8gMnGzPw0/CpQ2uRzoBbqKYDF1RJQ/VLx0XWVE0eVvn8Nz0LcOvGLevrqMoH4nHll8wsXTixz4aZy7Ryzt+bxNhbJjDifHrWAdDmvEiBfVNXDBggurYQKxdXwPuDn5qsLXWLtAOoQ5tKLZUrE5JgJxOz4Aj+vQDMKThvcMh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Piwu36B0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2F0C2BD11;
	Sat, 25 May 2024 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716638037;
	bh=iffO3tGrRnH2Mjp2Mx8aBI94e5YrL+GUBGqMm/x9HY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Piwu36B0Ah/xr/Ig09HnNZqF4bthUF9Mb64hdSTKR/fCEQJf1rTqnGhTAnJv8r03L
	 dIor2EqqKOTUVhWD5m2ir7+I6JMsI47PXm+RlKISE2Pjy1owKyeJI/Z6xaGSgPUFBH
	 Yb7HLP0m1ZfprBeIeZumYXWylPMMnpqMamlS+WitzKsKlnyLS8qa5z4WuPW2aSE3s/
	 n6uvyr1t6bIjPq+GA1mcDlxruQ9X6AdYCfbBD03ytA2TRothsM3z/aKqQnsCQiIj5G
	 BLqy88E7bOG33pcr7y+bTnI6v8mrMYWj8OfxpB3CySzmnuklTW9ZhS+Rm/X48zB4zy
	 Yjhkn8cRJzdSw==
Date: Sat, 25 May 2024 13:53:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org, yakoyoku@gmail.com
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
Message-ID: <20240525-dompteur-darfst-79a1b275e7f3@brauner>
References: <20240524-anhieb-bundesweit-e1b0227fd3ed@brauner>
 <20240524191714.2950286-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240524191714.2950286-1-aliceryhl@google.com>

On Fri, May 24, 2024 at 07:17:13PM +0000, Alice Ryhl wrote:
> On Fri, May 24, 2024 at 6:12 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, May 17, 2024 at 09:30:36AM +0000, Alice Ryhl wrote:
> > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > >
> > > This abstraction makes it possible to manipulate the open files for a
> > > process. The new `File` struct wraps the C `struct file`. When accessing
> > > it using the smart pointer `ARef<File>`, the pointer will own a
> > > reference count to the file. When accessing it as `&File`, then the
> > > reference does not own a refcount, but the borrow checker will ensure
> > > that the reference count does not hit zero while the `&File` is live.
> > >
> > > Since this is intended to manipulate the open files of a process, we
> > > introduce an `fget` constructor that corresponds to the C `fget`
> > > method. In future patches, it will become possible to create a new fd in
> > > a process and bind it to a `File`. Rust Binder will use these to send
> > > fds from one process to another.
> > >
> > > We also provide a method for accessing the file's flags. Rust Binder
> > > will use this to access the flags of the Binder fd to check whether the
> > > non-blocking flag is set, which affects what the Binder ioctl does.
> > >
> > > This introduces a struct for the EBADF error type, rather than just
> > > using the Error type directly. This has two advantages:
> > > * `File::fget` returns a `Result<ARef<File>, BadFdError>`, which the
> > >   compiler will represent as a single pointer, with null being an error.
> > >   This is possible because the compiler understands that `BadFdError`
> > >   has only one possible value, and it also understands that the
> > >   `ARef<File>` smart pointer is guaranteed non-null.
> > > * Additionally, we promise to users of the method that the method can
> > >   only fail with EBADF, which means that they can rely on this promise
> > >   without having to inspect its implementation.
> > > That said, there are also two disadvantages:
> > > * Defining additional error types involves boilerplate.
> > > * The question mark operator will only utilize the `From` trait once,
> > >   which prevents you from using the question mark operator on
> > >   `BadFdError` in methods that return some third error type that the
> > >   kernel `Error` is convertible into. (However, it works fine in methods
> > >   that return `Error`.)
> > >
> > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > >  fs/file.c                       |   7 +
> > >  rust/bindings/bindings_helper.h |   2 +
> > >  rust/helpers.c                  |   7 +
> > >  rust/kernel/file.rs             | 330 ++++++++++++++++++++++++++++++++++++++++
> > >  rust/kernel/lib.rs              |   1 +
> > >  rust/kernel/types.rs            |   8 +
> > >  6 files changed, 355 insertions(+)
> > >
> > > diff --git a/fs/file.c b/fs/file.c
> > > index 3b683b9101d8..f2eab5fcb87f 100644
> > > --- a/fs/file.c
> > > +++ b/fs/file.c
> > > @@ -1127,6 +1127,13 @@ EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
> > >   *
> > >   * The fput_needed flag returned by fget_light should be passed to the
> > >   * corresponding fput_light.
> > > + *
> > > + * (As an exception to rule 2, you can call filp_close between fget_light and
> > > + * fput_light provided that you capture a real refcount with get_file before
> > > + * the call to filp_close, and ensure that this real refcount is fput *after*
> > > + * the fput_light call.)
> > > + *
> > > + * See also the documentation in rust/kernel/file.rs.
> > >   */
> > >  static unsigned long __fget_light(unsigned int fd, fmode_t mask)
> > >  {
> > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > > index ddb5644d4fd9..541afef7ddc4 100644
> > > --- a/rust/bindings/bindings_helper.h
> > > +++ b/rust/bindings/bindings_helper.h
> > > @@ -9,6 +9,8 @@
> > >  #include <kunit/test.h>
> > >  #include <linux/errname.h>
> > >  #include <linux/ethtool.h>
> > > +#include <linux/file.h>
> > > +#include <linux/fs.h>
> > >  #include <linux/jiffies.h>
> > >  #include <linux/mdio.h>
> > >  #include <linux/phy.h>
> > > diff --git a/rust/helpers.c b/rust/helpers.c
> > > index 4c8b7b92a4f4..5545a00560d1 100644
> > > --- a/rust/helpers.c
> > > +++ b/rust/helpers.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/build_bug.h>
> > >  #include <linux/err.h>
> > >  #include <linux/errname.h>
> > > +#include <linux/fs.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/refcount.h>
> > >  #include <linux/sched/signal.h>
> > > @@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
> > >  }
> > >  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> > >
> > > +struct file *rust_helper_get_file(struct file *f)
> > > +{
> > > +     return get_file(f);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_get_file);
> > > +
> > >  /*
> > >   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
> > >   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> > > diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> > > new file mode 100644
> > > index 000000000000..ad881e67084c
> > > --- /dev/null
> > > +++ b/rust/kernel/file.rs
> > > @@ -0,0 +1,330 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Files and file descriptors.
> > > +//!
> > > +//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h) and
> > > +//! [`include/linux/file.h`](srctree/include/linux/file.h)
> > > +
> > > +use crate::{
> > > +    bindings,
> > > +    error::{code::*, Error, Result},
> > > +    types::{ARef, AlwaysRefCounted, Opaque},
> > > +};
> > > +use core::{marker::PhantomData, ptr};
> > > +
> > > +/// Flags associated with a [`File`].
> > > +pub mod flags {
> > > +    /// File is opened in append mode.
> > > +    pub const O_APPEND: u32 = bindings::O_APPEND;
> > > +
> > > +    /// Signal-driven I/O is enabled.
> > > +    pub const O_ASYNC: u32 = bindings::FASYNC;
> > > +
> > > +    /// Close-on-exec flag is set.
> > > +    pub const O_CLOEXEC: u32 = bindings::O_CLOEXEC;
> > > +
> > > +    /// File was created if it didn't already exist.
> > > +    pub const O_CREAT: u32 = bindings::O_CREAT;
> > > +
> > > +    /// Direct I/O is enabled for this file.
> > > +    pub const O_DIRECT: u32 = bindings::O_DIRECT;
> > > +
> > > +    /// File must be a directory.
> > > +    pub const O_DIRECTORY: u32 = bindings::O_DIRECTORY;
> > > +
> > > +    /// Like [`O_SYNC`] except metadata is not synced.
> > > +    pub const O_DSYNC: u32 = bindings::O_DSYNC;
> > > +
> > > +    /// Ensure that this file is created with the `open(2)` call.
> > > +    pub const O_EXCL: u32 = bindings::O_EXCL;
> > > +
> > > +    /// Large file size enabled (`off64_t` over `off_t`).
> > > +    pub const O_LARGEFILE: u32 = bindings::O_LARGEFILE;
> > > +
> > > +    /// Do not update the file last access time.
> > > +    pub const O_NOATIME: u32 = bindings::O_NOATIME;
> > > +
> > > +    /// File should not be used as process's controlling terminal.
> > > +    pub const O_NOCTTY: u32 = bindings::O_NOCTTY;
> > > +
> > > +    /// If basename of path is a symbolic link, fail open.
> > > +    pub const O_NOFOLLOW: u32 = bindings::O_NOFOLLOW;
> > > +
> > > +    /// File is using nonblocking I/O.
> > > +    pub const O_NONBLOCK: u32 = bindings::O_NONBLOCK;
> > > +
> > > +    /// File is using nonblocking I/O.
> > > +    ///
> > > +    /// This is effectively the same flag as [`O_NONBLOCK`] on all architectures
> > > +    /// except SPARC64.
> > > +    pub const O_NDELAY: u32 = bindings::O_NDELAY;
> > > +
> > > +    /// Used to obtain a path file descriptor.
> > > +    pub const O_PATH: u32 = bindings::O_PATH;
> > > +
> > > +    /// Write operations on this file will flush data and metadata.
> > > +    pub const O_SYNC: u32 = bindings::O_SYNC;
> > > +
> > > +    /// This file is an unnamed temporary regular file.
> > > +    pub const O_TMPFILE: u32 = bindings::O_TMPFILE;
> > > +
> > > +    /// File should be truncated to length 0.
> > > +    pub const O_TRUNC: u32 = bindings::O_TRUNC;
> > > +
> > > +    /// Bitmask for access mode flags.
> > > +    ///
> > > +    /// # Examples
> > > +    ///
> > > +    /// ```
> > > +    /// use kernel::file;
> > > +    /// # fn do_something() {}
> > > +    /// # let flags = 0;
> > > +    /// if (flags & file::flags::O_ACCMODE) == file::flags::O_RDONLY {
> > > +    ///     do_something();
> > > +    /// }
> > > +    /// ```
> > > +    pub const O_ACCMODE: u32 = bindings::O_ACCMODE;
> > > +
> > > +    /// File is read only.
> > > +    pub const O_RDONLY: u32 = bindings::O_RDONLY;
> > > +
> > > +    /// File is write only.
> > > +    pub const O_WRONLY: u32 = bindings::O_WRONLY;
> > > +
> > > +    /// File can be both read and written.
> > > +    pub const O_RDWR: u32 = bindings::O_RDWR;
> > > +}
> > > +
> > > +/// Compile-time information for keeping track of how a [`File`] is shared.
> > > +///
> > > +/// The `fdget_pos` method can be used to access the file's position without taking `f_pos_lock`,
> > > +/// as long as the file is not shared with any other threads. During such calls to `fdget_pos`, the
> > > +/// file must remain non-shared, so it must not be possible to move the file to another thread. For
> > > +/// example, if the file is moved to another thread, then it could be passed to `fd_install`, at
> > > +/// which point the remote process could touch the file position.
> > > +///
> > > +/// The share mode only keeps track of whether there are active `fdget_pos` calls that did not take
> > > +/// the `f_pos_lock`, and does not keep track of `fdget` calls. This is okay because `fdget` does
> > > +/// not care about the refcount of the underlying `struct file`; as long as the entry in the
> > > +/// current thread's fd table does not get removed, it's okay to share the file. For example,
> > > +/// `fd_install`ing the `struct file` into another process is okay during an `fdget` call, because
> > > +/// the other process can't touch the fd table of the original process.
> > > +mod share_mode {
> > > +    /// Trait implemented by the two sharing modes that a file might have.
> > > +    pub trait FileShareMode {}
> > > +
> > > +    /// Represents a file for which there might be an active call to `fdget_pos` that did not take
> > > +    /// the `f_pos_lock` lock.
> > > +    pub enum MaybeFdgetPos {}
> > > +
> > > +    /// Represents a file for which it is known that all active calls to `fdget_pos` (if any) took
> > > +    /// the `f_pos_lock` lock.
> > > +    pub enum NoFdgetPos {}
> > > +
> > > +    impl FileShareMode for MaybeFdgetPos {}
> > > +    impl FileShareMode for NoFdgetPos {}
> > > +}
> > > +pub use self::share_mode::{FileShareMode, MaybeFdgetPos, NoFdgetPos};
> > > +
> > > +/// Wraps the kernel's `struct file`.
> > > +///
> > > +/// This represents an open file rather than a file on a filesystem. Processes generally reference
> > > +/// open files using file descriptors. However, file descriptors are not the same as files. A file
> > > +/// descriptor is just an integer that corresponds to a file, and a single file may be referenced
> > > +/// by multiple file descriptors.
> > > +///
> > > +/// # Refcounting
> > > +///
> > > +/// Instances of this type are reference-counted. The reference count is incremented by the
> > > +/// `fget`/`get_file` functions and decremented by `fput`. The Rust type `ARef<File>` represents a
> > > +/// pointer that owns a reference count on the file.
> > > +///
> > > +/// Whenever a process opens a file descriptor (fd), it stores a pointer to the file in its fd
> > > +/// table (`struct files_struct`). This pointer owns a reference count to the file, ensuring the
> > > +/// file isn't prematurely deleted while the file descriptor is open. In Rust terminology, the
> > > +/// pointers in `struct files_struct` are `ARef<File>` pointers.
> > > +///
> > > +/// ## Light refcounts
> > > +///
> > > +/// Whenever a process has an fd to a file, it may use something called a "light refcount" as a
> > > +/// performance optimization. Light refcounts are acquired by calling `fdget` and released with
> > > +/// `fdput`. The idea behind light refcounts is that if the fd is not closed between the calls to
> > > +/// `fdget` and `fdput`, then the refcount cannot hit zero during that time, as the `struct
> > > +/// files_struct` holds a reference until the fd is closed. This means that it's safe to access the
> > > +/// file even if `fdget` does not increment the refcount.
> > > +///
> > > +/// The requirement that the fd is not closed during a light refcount applies globally across all
> > > +/// threads - not just on the thread using the light refcount. For this reason, light refcounts are
> > > +/// only used when the `struct files_struct` is not shared with other threads, since this ensures
> > > +/// that other unrelated threads cannot suddenly start using the fd and close it. Therefore,
> > > +/// calling `fdget` on a shared `struct files_struct` creates a normal refcount instead of a light
> > > +/// refcount.
> > > +///
> > > +/// Light reference counts must be released with `fdput` before the system call returns to
> > > +/// userspace. This means that if you wait until the current system call returns to userspace, then
> > > +/// all light refcounts that existed at the time have gone away.
> >
> > You obviously are aware of this but I'm just spelling it out. Iirc,
> > there will practically only ever be one light refcount per file.
> >
> > For a light refcount to be used we know that the file descriptor table
> > isn't shared with any other task. So there are no threads that could
> > concurrently access the file descriptor table. We also know that the
> > file descriptor table cannot become shared while we're in system call
> > context because the caller can't create new threads and they can't
> > unshare the file descriptor table.
> >
> > So there's only one fdget() caller (Yes, they could call fdget()
> > multiple times and then have to do fdput() multiple times but that's a
> > level of weirdness that we don't need to worry about.).
> 
> Hmm. Is it not the case that different processes with different file
> descriptor tables could reference the same underlying `struct file` and
> both use light refcounts to do so, as long as each fd table is not
> shared? So there could be multiple light refcounts to the same `struct
> file` at the same time on different threads.

That's correct.
But I misread what you were trying to say then. I thought you were
talking about multiple light references from the same thread which is
rather rare and should only happen in system calls that take two fds.

But what you're talking about is the same struct file being present in
separate file descriptor tables and referenced multiple times from
different threads so in that sense we have multiple light references.
And that's obviously correct.

> 
> And this does *not* apply to `fdget_pos`, which checks the refcount of
> the `struct file` instead of the refcount of the fd table.

I have only skimmed the replies down thread so far but I saw that this
has mostly been clarified. The reference counting between fdget() and
fdget_pos() is identical. fdget_pos() calls fdget() after all.

What's different is that if the file is already shared among different
processes then even if a light reference was taken by the caller because
it doesn't share the file descriptor table fdget_pos() may still acquire
the f_pos_lock because the struct file is referenced by multiple
processes.

IOW, you could have the same struct file in the file descriptor tables
of 10 processes. So the f_count would be 10. Assume all of them
concurrently call read(), then none of them will bump f_count because
fdget() sees that the file descriptor tables aren't shared.

But all 10 of them will serialize on f_pos_lock. So that's really
separate from light refcounting. If you have to acquire f_pos_lock from
within the same thread then fdget*() always take normal reference
counts.

> 
> > > +///
> > > +/// ### The file position
> > > +///
> > > +/// Each `struct file` has a position integer, which is protected by the `f_pos_lock` mutex.
> > > +/// However, if the `struct file` is not shared, then the kernel may avoid taking the lock as a
> > > +/// performance optimization.
> > > +///
> > > +/// The condition for avoiding the `f_pos_lock` mutex is different from the condition for using
> > > +/// `fdget`. With `fdget`, you may avoid incrementing the refcount as long as the current fd table
> > > +/// is not shared; it is okay if there are other fd tables that also reference the same `struct
> > > +/// file`. However, `fdget_pos` can only avoid taking the `f_pos_lock` if the entire `struct file`
> > > +/// is not shared, as different processes with an fd to the same `struct file` share the same
> > > +/// position.
> > > +///
> > > +/// ## Rust references
> > > +///
> > > +/// The reference type `&File` is similar to light refcounts:
> > > +///
> > > +/// * `&File` references don't own a reference count. They can only exist as long as the reference
> > > +///   count stays positive, and can only be created when there is some mechanism in place to ensure
> > > +///   this.
> > > +///
> > > +/// * The Rust borrow-checker normally ensures this by enforcing that the `ARef<File>` from which
> > > +///   a `&File` is created outlives the `&File`.
> > > +///
> > > +/// * Using the unsafe [`File::from_ptr`] means that it is up to the caller to ensure that the
> > > +///   `&File` only exists while the reference count is positive.
> > > +///
> > > +/// * You can think of `fdget` as using an fd to look up an `ARef<File>` in the `struct
> > > +///   files_struct` and create an `&File` from it. The "fd cannot be closed" rule is like the Rust
> > > +///   rule "the `ARef<File>` must outlive the `&File`".
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// * All instances of this type are refcounted using the `f_count` field.
> > > +/// * If the file sharing mode is `MaybeFdgetPos`, then all active calls to `fdget_pos` that did
> > > +///   not take the `f_pos_lock` mutex must be on the same thread as this `File`.
> > > +/// * If the file sharing mode is `NoFdgetPos`, then there must not be active calls to `fdget_pos`
> > > +///   that did not take the `f_pos_lock` mutex.
> > > +#[repr(transparent)]
> > > +pub struct File<S: FileShareMode> {
> > > +    inner: Opaque<bindings::file>,
> > > +    _share_mode: PhantomData<S>,
> > > +}
> > > +
> > > +// SAFETY: This file is known to not have any local active `fdget_pos` calls, so it is safe to
> > > +// transfer it between threads.
> > > +unsafe impl Send for File<NoFdgetPos> {}
> > > +
> > > +// SAFETY: This file is known to not have any local active `fdget_pos` calls, so it is safe to
> > > +// access its methods from several threads in parallel.
> > > +unsafe impl Sync for File<NoFdgetPos> {}
> > > +
> > > +/// File methods that only exist under the [`MaybeFdgetPos`] sharing mode.
> > > +impl File<MaybeFdgetPos> {
> > > +    /// Constructs a new `struct file` wrapper from a file descriptor.
> > > +    ///
> > > +    /// The file descriptor belongs to the current process, and there might be active local calls
> > > +    /// to `fdget_pos`.
> > > +    pub fn fget(fd: u32) -> Result<ARef<File<MaybeFdgetPos>>, BadFdError> {
> > > +        // SAFETY: FFI call, there are no requirements on `fd`.
> > > +        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
> > > +
> > > +        // SAFETY: `bindings::fget` created a refcount, and we pass ownership of it to the `ARef`.
> > > +        //
> > > +        // INVARIANT: This file is in the fd table on this thread, so either all `fdget_pos` calls
> > > +        // are on this thread, or the file is shared, in which case `fdget_pos` calls took the
> > > +        // `f_pos_lock` mutex.
> > > +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> > > +    }
> >
> > I'm a little unclear how this is supposed to be used. What I
> > specifically struggle with is what function does one have to call to
> > translate from a file descriptor to a file? IOW, where are the actual
> > entry points for turning fds into files? That's what I want to see and
> > that's what we need to make this interface usable generically.
> 
> That is File::fget. It takes a file descriptor and returns a long-term
> reference to a file.

Ok.

> 
> > Because naively, what I'm looking for is a Rust version of fdget() and
> > fdget_pos() that give me back a File<MaybeFdget> or a
> > File<MaybeFdgetPos>.
> >
> > And then those both implement a get_file() method so the caller can take
> > an explicit long-term reference to the file.
> 
> Even if you call `get_file` to get a long-term reference from something
> you have an fdget_pos reference to, that doesn't necessarily mean that
> you can share that long-term reference with other threads. You would
> need to release the fdget_pos reference first. For that reason, the
> long-term reference returned by `get_file` would still need to have the
> `File<MaybeFdgetPos>` type.

So what you're getting at seems to be that some process has a private
file descriptor table and an just opened @fd to a @file that isn't
shared.

	fd = open("/my/file");

and then let's say has a random ioctl(fd, SOMETHING_SOMETHING) that
somehow does:

	struct fd fd = fdget_pos();
	if (!fd.file)
		return -EBADF;

We know that process has used a light reference count and that it didn't
acquire f_pos_lock.

Your whole approach seems to assume that after something like this has
happened the same process now offloads that struct file to another
process that somehow ends up doing some other operation on the file that
would also require f_pos_lock to be taken but it doesn't like a read or
something.

To share a file between multiple processes would normally always require
that the process sends that file to another process. That process then
install that fd into its file descriptor table and then later accesses
that file via fdget() again. That's the standard way of doing it -
binder does it that way too. And that's all perfectly fine.

What you would need for this to be a problem is for a process be sent a
struct file from a process that is in the middle of an f_pos_lock scope
and for the receiving process to immediately start doing stuff that
would normally require f_pos_lock.

Like, idk vfs_read(file, ...).

If that's what this is about then yes, there's a close-to-zero but
non-zero possibility that some really stupid code could end up doing
something like this.

Basically, that scenario doesn't exist (as I've mentioned before)
currently. It only exists in a single instance and that's when
pidfd_getfd() is used to steal a file from another task while that task
is in the middle of an f_pos_lock section (I said it before we don't
care about that because non-POSIX interface anyway and we have ptrace
rights anyway. And iiuc that wouldn't even be preventable in your
current scheme because you would need to have the information available
that the struct file you're about to steal from the file descriptor
table is currently within an f_pos_lock section.).

Is it honestly worth encoding all that complexity into rust's file
implementation itself right now? It's barely understandable to
non-rust experts as it is right now. :)

Imho, it would seem a lot more prudent to just have something simpler
for now.

> 
> (But you could convert it to a `File<NoFdgetPos>` afterwards. The
> `assume_no_fdget_pos` method performs that conversion.)
> 
> As a sidenote, the reason that this patchset does not implement `fdget`
> or `fdget_pos` is that Rust Binder does not use them. Like C Binder, it

Yes, you mentioned.

> just uses `fget` to immediately obtain a long-term reference. I was told

Right and that's why I'm confused why that whole shared_state
machinery is needed in the first place. Because binder does do it
correctly:

* sender registers a bunch of fds to use and takes fget() reference
  All other processes that use the same file in their fdtable and rely
  on fdget_pos() will see the elevated reference count and acquire
  f_pos_lock.
* receiver installs stuff into their fdtable
  Receiver can now use fdget_pos() to do reads/writes. Everything's in
  order as well.

> that as an exception, Rust code can be merged *before* its user, but
> that we couldn't merge Rust code with no upcoming user. However, I can
> include implementations of `fdget` and `fdget_pos` in the next version
> if you prefer that. After all, it seems rather likely that we will
> eventually have a user for fdget.
> 
> > The fget() above is really confusing to me because it always takes a
> > reference on the file that's pointed to by the fd and then it returns a
> > MaybeFdgetPos because presumably you want to indicate that the file
> > descriptor may refer to a file that may or may not be referenced by
> > another thread via fdget()/fdget_pos() already.
> 
> No, not another thread. It is because it may or may not be referenced by
> fdget_pos by *the same* thread already.
> 
> Here's how I think of it: The `fget` method takes a file descriptor and
> returns a long term reference (an ARef) to a `struct file`. It does not
> return a file descriptor, since it doesn't store anywhere which fd it
> came from.
> 
> The `File::fget` method returns a `File<MaybeFdgetPos>` in case *the
> same thread* is also using `fdget_pos` on the same file descriptor. It's
> okay if other threads are using `fdget_pos` because in that case the
> file is already shared, so those other `fdget_pos` calls necessarily the
> f_pos_lock mutex.
> 
> Note that since it forgets which fd and fd table it came from, calls to
> `fdget` are actually not a problem for sending our long-term references
> across threads. The `fdget` requirements only care about things that
> touch the entry in the file descriptor table, such as closing the fd.
> The `ARef<File>` type does not provide any methods that could lead to
> that happening, so sharing it across threads is okay *even if* there is
> an light reference. That's why I have an `MaybeFdgetPos` but no
> `MaybeFdget`.
> 
> > So I've _skimmed_ the binder RFC and looked at:
> > 20231101-rust-binder-v1-13-08ba9197f637@google.com
> > which states:
> >
> >         Add support for sending fds over binder.
> >
> >         Unlike the other object types, file descriptors are not translated until
> >         the transaction is actually received by the recipient. Until that
> >         happens, we store `u32::MAX` as the fd.
> >
> >         Translating fds is done in a two-phase process. First, the file
> >         descriptors are allocated and written to the allocation. Then, once we
> >         have allocated all of them, we commit them to the files in question.
> >         Using this strategy, we are able to guarantee that we either send all of
> >         the fds, or none of them.
> >
> > So I'm curious. How does the binder fd sending work exactly? Because I
> > feel that this is crucial to understand here. Some specific questions:
> >
> > * When file descriptors are passed the reference to these files via
> >   fget() are taken _synchronously_, i.e., by the sending task, not the
> >   receiver? IOW, is binder_translate_fd() called in the context of the
> >   sender or the receiver. I assume it must be the sender because
> >   otherwise the sender and receiver must share a file descriptor table
> >   in order for the receiver to call fget().
> 
> binder_translate_fd is called in the context of the sender.
> 
> > * The receiving task then allocates new file descriptors and installs
> >   the received files into its file descriptor table?
> 
> That happens in binder_apply_fd_fixups, which is called in the context
> of the receiver.

Yes, that's what I thought.

> 
> I can see how the sentence "Until that happens, we store `u32::MAX` as
> the fd." is really confusing here. What happens when you send a fd is
> this:
> 
> In the sender's ioctl:
> 1. The sender wishes to send a byte array to the recipient. The sender
>    tells the kernel that at specific offsets in this array, there are
>    some file descriptors that it wishes to send.
> 
> 2. The kernel copies the byte array directly into the recipient's
>    address space. The offsets in the byte array with file descriptors
>    are not copied - instead u32::MAX is written temporarily at those
>    offsets.
> 
> 3. For each fd being sent, the kernel uses fget to obtain a reference to
>    the underlying `struct file`. These pointers are stored in an array.
> 
> In the receiver's ioctl:
> 1. Go through the list of `struct file` pointers and create a
>    `FileDescriptorReservation` for each.
> 
> 2. Go through the list of `struct file` pointers again and `fd_install`
>    them into the current thread's fd table. This is infallible due to
>    the reservations we just made.
> 
> 3. Finally, overwrite the u32::MAX values in the byte array with the
>    actual file descriptors that the files were assigned.
> 
> This is the same as how it works in C Binder.

Yes, that all seems fine.

> 
> > And so basically, what I'm after here is that the binder_translate_fd()
> > that calls fget() is done in the context of the sender and we _know_
> > that the fds can't have light references. Because if they did it could
> > only be by the calling task but they don't since the calling task uses
> > fget() on them. And if the calling task is multi-threaded and another
> > thread has called fdget() or fdget_pos() we know that they have taken
> > their own reference because the file descriptor table is shared.
> >
> > So why is that fget() in here returning a File<MaybeFdgetPos>? This
> > doesn't make sense to me at first glance.
> 
> Because when you call `File::fget`, then there could also be a different
> call to `fdget_pos` on the same thread on the same file descriptor.
> 
> 	fdget_pos(my_fd);
> 	let my_file = File::fget(my_fd)?;
> 	// oh no!
> 	send_to_another_thread(my_file);

Ok, that's basically my above example.

> 
> In the above code, the file becomes shared even though `fdget_pos` might
> not have taken the `f_pos_lock` mutex. That's not okay. We could end up
> with a data race on the file position.

But a race on f_pos isn't a memory safety issue it's just a POSIX
ordering requirement.

> 
> One of the primary design principles of Rust is that, if the user of our
> API has *any* way of using it that could trigger a memory safety
> problem, then we must be able to point at an unsafe block *in the user's
> code* that is at fault. This must be the case no matter how contrived
> the use of the API is.
> 
> As a corollary, if the user can trigger memory safety problems with our
> API without using any unsafe blocks, then that is a bug in the API.
> We cannot assign the blame to an unsafe block in the user's code, so the
> blame *must* lie with an unsafe block inside the API.
> 
> So, to follow that design principle, I have designed the API in a way
> that prevents the above data race. Concretely, because the
> `File<MaybeFdgetPos>` type is not thread safe (or in Rust terms "is not
> Send"), it's not possible to send values of that type across thread
> boundaries. E.g., our `send_to_another_thread` would have a requirement
> in its signature saying that it can only be called with types that are
> thread safe, so calling it with a type that isn't results in a type
> error.
> 
> 
> 
> Now, what if you *want* to send it to another thread? Let's consider
> Rust Binder, which needs to do exactly that. The relevant code in Rust
> Binder would need to be updated to look like this:
> 
> 	let file = File::fget(my_fd)?;
> 	// SAFETY: We know that there are no active `fdget_pos` calls on
> 	// the current thread, since this is an ioctl and we have not
> 	// called `fdget_pos` inside the Binder driver.
> 	let thread_safe_file = unsafe { file.assume_no_fdget_pos() };
> 
> (search for File::from_fd in the RFC to find where this would go)
> 
> The `assume_no_fdget_pos` call has no effect at runtime - it is purely a
> compile-time thing to force the user to use unsafe to "promise" that
> there aren't any `fdget_pos` calls on the same fd.
> 
> If Rust Binder uses `assume_no_fdget_pos` and ends up triggering memory
> unsafety because it sent a file to another thread, then we can point to
> the unsafe block that calls `assume_no_fdget_pos` and say "that unsafe
> block is at fault because it assumed that there was no `fdget_pos` call,
> but that assumption was false."
> 
> > > +    /// Assume that there are no active `fdget_pos` calls that prevent us from sharing this file.
> > > +    ///
> > > +    /// This makes it safe to transfer this file to other threads. No checks are performed, and
> > > +    /// using it incorrectly may lead to a data race on the file position if the file is shared
> > > +    /// with another thread.
> > > +    ///
> > > +    /// This method is intended to be used together with [`File::fget`] when the caller knows
> > > +    /// statically that there are no `fdget_pos` calls on the current thread. For example, you
> > > +    /// might use it when calling `fget` from an ioctl, since ioctls usually do not touch the file
> > > +    /// position.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// There must not be any active `fdget_pos` calls on the current thread.
> > > +    pub unsafe fn assume_no_fdget_pos(me: ARef<Self>) -> ARef<File<NoFdgetPos>> {
> > > +        // INVARIANT: There are no `fdget_pos` calls on the current thread, and by the type
> > > +        // invariants, if there is a `fdget_pos` call on another thread, then it took the
> > > +        // `f_pos_lock` mutex.
> > > +        //
> > > +        // SAFETY: `File<MaybeFdgetPos>` and `File<NoFdgetPos>` have the same layout.
> > > +        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
> > > +    }
> > > +}
> > > +
> > > +/// File methods that exist under all sharing modes.
> > > +impl<S: FileShareMode> File<S> {
> > > +    /// Creates a reference to a [`File`] from a valid pointer.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// * The caller must ensure that `ptr` points at a valid file and that the file's refcount is
> > > +    ///   positive for the duration of 'a.
> > > +    /// * The caller must ensure that the requirements for using the chosen file sharing mode are
> > > +    ///   upheld.
> > > +    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File<S> {
> >
> > I think I requested from_raw_file() in the last revision?
> 
> Ah, yeah, I totally forgot about this. I'll make the change in the next
> version.
> 
> > > +    /// Returns a raw pointer to the inner C struct.
> > > +    #[inline]
> > > +    pub fn as_ptr(&self) -> *mut bindings::file {
> >
> > And that was supposed to be into_raw_file() or as_raw_file()?
> 
> Per the Rust API guidelines [1], this should be `as_raw_file`. The
> `into_*` prefix is for conversions that destroy the object you call it
> on. (E.g., because it takes ownership of the underlying allocation or
> refcount.)
> 
> As always, thank you for the very detailed questions!
> 
> Alice
> 
> [1]: https://rust-lang.github.io/api-guidelines/naming.html#ad-hoc-conversions-follow-as_-to_-into_-conventions-c-conv

