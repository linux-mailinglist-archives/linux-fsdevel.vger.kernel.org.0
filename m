Return-Path: <linux-fsdevel+bounces-20253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498868D07EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43721F21E9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFD016A363;
	Mon, 27 May 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDyCYYpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9929716A36B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825922; cv=none; b=ZbxSEdgdNdran/pLSoMLXGxdr/pHBsAFYe5hf6QbZx6kdMtFWhNcT9BDPNjhJvzkWTCa56th9r8si09nJ3+Lf3wdcn5pagsdkX0jLk03QyW7a5XNZG96PxkrcSsvKFvTgHDuRrcGZNYwT/+t/VjEvrgRmjFoScWbjpXyvIZOcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825922; c=relaxed/simple;
	bh=Y8/RodRQMhdADgVqAzXVgqEC0A7U+PAVZ0Ny80dejYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jKabwg9bk0fKOSb7iZB4VYgT6jIFQBM+rZUtwjhYjS0tzXaR3fo6+kqB+fYCR6UBTM6b2zA/l+DE1Kq83MbikCrVLqU/QOpQ4VDeR0qNwOvVNo5csIbny2eow2OWJ7CWf3mEO24DVEuWbnL9OaDCB+1HPEqahpsucGL49kFIHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDyCYYpH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-629f8a71413so52159247b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716825917; x=1717430717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MG+PCZQ7Jpcpo0xV5x4+9OECcULf8pc8w3UlXB4VtDA=;
        b=KDyCYYpHYzXi6BHsyo8VijtoJfgdqHWbLz1OkHXvGhTLbkHXLhRSTauybAM+7pmLQV
         h/I3eIiSFf2Z98taAij9PLl94wTwkF7SKGDoehvUDmfWKQHcBgJDaA/+6NEOfcNQxiGI
         +FOoWBfGAmuJ2Cv6q1WVDsJuZBAjG9L8y5AOmk+xFmsMXqlfqrNPsWIH64CEOi/VO3Hx
         8kqx+KqwyfCIW3kZs0BzIGsFWaLj3AAE3sWb9UYkzgw0YZZT2SKvxMoyND1holaQwg9M
         /iHLL/pTMb0Xy0lhPdIO9IrO+XPs+gniivw47sCBUJWst+uMk46HChh4a31EXIQNhxQl
         SVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716825917; x=1717430717;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MG+PCZQ7Jpcpo0xV5x4+9OECcULf8pc8w3UlXB4VtDA=;
        b=UruRjIJYqet5NHfajHqfUIpUTIlfNp/Jl3aw4emNsB+QDp5hUagmrhd20/vkdKjcPX
         NVS0MHNSKx6rxIlswzQqf5prxmVq3esSmiq6zUxH8pfaVFRah67Ar0dUPpfcSaFZuYb0
         ZwhTZOTn3n5eOo5qmWBJvaYliba/oYbCw3Pf+TDPM0OSC0OSM0934hGfGWvxbe0iOdIF
         1RmugzfDxIwOAPTi811MQujLPFiBMpiA6BHeWBSyrbFoPoSNPrslMNo13hMwTedKdFOY
         MXUSDT6gDdcTGs0ffxB7kTSbbO5/vkAJnw0OX2e63z1Hv4jk6dla+W4dcTFdLAWUCwe7
         Wx5w==
X-Forwarded-Encrypted: i=1; AJvYcCUzNyJVao5RKZgre2PV0LCvJFPklwgfWTjOJHo9ZwkLYEm2HcCLcs+wZpKIXSJlQVlmsjuJW+mEzQnUMqwVdgZYA546U9H/ss5cbpNvQA==
X-Gm-Message-State: AOJu0YyccVsLo+jFJZSUvxGoyxTFBAMGzh3hHqRn7HTomNMXgI0MEbR8
	xuwKFFrQZFPrPzq7+nnOK17aIPMWyL9E7SNSbzpEhf2J0uS0v8ze9u4EZDS0UuPJunyTDIKrp7Y
	a+iEqVKpI65uEKg==
X-Google-Smtp-Source: AGHT+IG8krVcSoIZ5nJgOOfbF0rFJw6nSxO4pZPJMD10Xz9HwFVMG5gAxeVnd/M/+7L1KrlnCm2PIqWydBHMfaI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:fc3:b0:61b:e2e7:e127 with SMTP
 id 00721157ae682-62a08d74111mr30486647b3.1.1716825917626; Mon, 27 May 2024
 09:05:17 -0700 (PDT)
Date: Mon, 27 May 2024 16:05:14 +0000
In-Reply-To: <20240525-dompteur-darfst-79a1b275e7f3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240525-dompteur-darfst-79a1b275e7f3@brauner>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240527160514.3909734-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
From: Alice Ryhl <aliceryhl@google.com>
To: brauner@kernel.org
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com, 
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org, 
	yakoyoku@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Brauner <brauner@kernel.org> writes:
> On Fri, May 24, 2024 at 07:17:13PM +0000, Alice Ryhl wrote:
> > On Fri, May 24, 2024 at 6:12=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Fri, May 17, 2024 at 09:30:36AM +0000, Alice Ryhl wrote:
> > > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > >
> > > > This abstraction makes it possible to manipulate the open files for=
 a
> > > > process. The new `File` struct wraps the C `struct file`. When acce=
ssing
> > > > it using the smart pointer `ARef<File>`, the pointer will own a
> > > > reference count to the file. When accessing it as `&File`, then the
> > > > reference does not own a refcount, but the borrow checker will ensu=
re
> > > > that the reference count does not hit zero while the `&File` is liv=
e.
> > > >
> > > > Since this is intended to manipulate the open files of a process, w=
e
> > > > introduce an `fget` constructor that corresponds to the C `fget`
> > > > method. In future patches, it will become possible to create a new =
fd in
> > > > a process and bind it to a `File`. Rust Binder will use these to se=
nd
> > > > fds from one process to another.
> > > >
> > > > We also provide a method for accessing the file's flags. Rust Binde=
r
> > > > will use this to access the flags of the Binder fd to check whether=
 the
> > > > non-blocking flag is set, which affects what the Binder ioctl does.
> > > >
> > > > This introduces a struct for the EBADF error type, rather than just
> > > > using the Error type directly. This has two advantages:
> > > > * `File::fget` returns a `Result<ARef<File>, BadFdError>`, which th=
e
> > > >   compiler will represent as a single pointer, with null being an e=
rror.
> > > >   This is possible because the compiler understands that `BadFdErro=
r`
> > > >   has only one possible value, and it also understands that the
> > > >   `ARef<File>` smart pointer is guaranteed non-null.
> > > > * Additionally, we promise to users of the method that the method c=
an
> > > >   only fail with EBADF, which means that they can rely on this prom=
ise
> > > >   without having to inspect its implementation.
> > > > That said, there are also two disadvantages:
> > > > * Defining additional error types involves boilerplate.
> > > > * The question mark operator will only utilize the `From` trait onc=
e,
> > > >   which prevents you from using the question mark operator on
> > > >   `BadFdError` in methods that return some third error type that th=
e
> > > >   kernel `Error` is convertible into. (However, it works fine in me=
thods
> > > >   that return `Error`.)
> > > >
> > > > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > > Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > > > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > > > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > > > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > ---
> > > >  fs/file.c                       |   7 +
> > > >  rust/bindings/bindings_helper.h |   2 +
> > > >  rust/helpers.c                  |   7 +
> > > >  rust/kernel/file.rs             | 330 ++++++++++++++++++++++++++++=
++++++++++++
> > > >  rust/kernel/lib.rs              |   1 +
> > > >  rust/kernel/types.rs            |   8 +
> > > >  6 files changed, 355 insertions(+)
> > > >
> > > > diff --git a/fs/file.c b/fs/file.c
> > > > index 3b683b9101d8..f2eab5fcb87f 100644
> > > > --- a/fs/file.c
> > > > +++ b/fs/file.c
> > > > @@ -1127,6 +1127,13 @@ EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
> > > >   *
> > > >   * The fput_needed flag returned by fget_light should be passed to=
 the
> > > >   * corresponding fput_light.
> > > > + *
> > > > + * (As an exception to rule 2, you can call filp_close between fge=
t_light and
> > > > + * fput_light provided that you capture a real refcount with get_f=
ile before
> > > > + * the call to filp_close, and ensure that this real refcount is f=
put *after*
> > > > + * the fput_light call.)
> > > > + *
> > > > + * See also the documentation in rust/kernel/file.rs.
> > > >   */
> > > >  static unsigned long __fget_light(unsigned int fd, fmode_t mask)
> > > >  {
> > > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindin=
gs_helper.h
> > > > index ddb5644d4fd9..541afef7ddc4 100644
> > > > --- a/rust/bindings/bindings_helper.h
> > > > +++ b/rust/bindings/bindings_helper.h
> > > > @@ -9,6 +9,8 @@
> > > >  #include <kunit/test.h>
> > > >  #include <linux/errname.h>
> > > >  #include <linux/ethtool.h>
> > > > +#include <linux/file.h>
> > > > +#include <linux/fs.h>
> > > >  #include <linux/jiffies.h>
> > > >  #include <linux/mdio.h>
> > > >  #include <linux/phy.h>
> > > > diff --git a/rust/helpers.c b/rust/helpers.c
> > > > index 4c8b7b92a4f4..5545a00560d1 100644
> > > > --- a/rust/helpers.c
> > > > +++ b/rust/helpers.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include <linux/build_bug.h>
> > > >  #include <linux/err.h>
> > > >  #include <linux/errname.h>
> > > > +#include <linux/fs.h>
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/refcount.h>
> > > >  #include <linux/sched/signal.h>
> > > > @@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct wor=
k_struct *work, work_func_t func,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> > > >
> > > > +struct file *rust_helper_get_file(struct file *f)
> > > > +{
> > > > +     return get_file(f);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rust_helper_get_file);
> > > > +
> > > >  /*
> > > >   * `bindgen` binds the C `size_t` type as the Rust `usize` type, s=
o we can
> > > >   * use it in contexts where Rust expects a `usize` like slice (arr=
ay) indices.
> > > > diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> > > > new file mode 100644
> > > > index 000000000000..ad881e67084c
> > > > --- /dev/null
> > > > +++ b/rust/kernel/file.rs
> > > > @@ -0,0 +1,330 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +//! Files and file descriptors.
> > > > +//!
> > > > +//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h) =
and
> > > > +//! [`include/linux/file.h`](srctree/include/linux/file.h)
> > > > +
> > > > +use crate::{
> > > > +    bindings,
> > > > +    error::{code::*, Error, Result},
> > > > +    types::{ARef, AlwaysRefCounted, Opaque},
> > > > +};
> > > > +use core::{marker::PhantomData, ptr};
> > > > +
> > > > +/// Flags associated with a [`File`].
> > > > +pub mod flags {
> > > > +    /// File is opened in append mode.
> > > > +    pub const O_APPEND: u32 =3D bindings::O_APPEND;
> > > > +
> > > > +    /// Signal-driven I/O is enabled.
> > > > +    pub const O_ASYNC: u32 =3D bindings::FASYNC;
> > > > +
> > > > +    /// Close-on-exec flag is set.
> > > > +    pub const O_CLOEXEC: u32 =3D bindings::O_CLOEXEC;
> > > > +
> > > > +    /// File was created if it didn't already exist.
> > > > +    pub const O_CREAT: u32 =3D bindings::O_CREAT;
> > > > +
> > > > +    /// Direct I/O is enabled for this file.
> > > > +    pub const O_DIRECT: u32 =3D bindings::O_DIRECT;
> > > > +
> > > > +    /// File must be a directory.
> > > > +    pub const O_DIRECTORY: u32 =3D bindings::O_DIRECTORY;
> > > > +
> > > > +    /// Like [`O_SYNC`] except metadata is not synced.
> > > > +    pub const O_DSYNC: u32 =3D bindings::O_DSYNC;
> > > > +
> > > > +    /// Ensure that this file is created with the `open(2)` call.
> > > > +    pub const O_EXCL: u32 =3D bindings::O_EXCL;
> > > > +
> > > > +    /// Large file size enabled (`off64_t` over `off_t`).
> > > > +    pub const O_LARGEFILE: u32 =3D bindings::O_LARGEFILE;
> > > > +
> > > > +    /// Do not update the file last access time.
> > > > +    pub const O_NOATIME: u32 =3D bindings::O_NOATIME;
> > > > +
> > > > +    /// File should not be used as process's controlling terminal.
> > > > +    pub const O_NOCTTY: u32 =3D bindings::O_NOCTTY;
> > > > +
> > > > +    /// If basename of path is a symbolic link, fail open.
> > > > +    pub const O_NOFOLLOW: u32 =3D bindings::O_NOFOLLOW;
> > > > +
> > > > +    /// File is using nonblocking I/O.
> > > > +    pub const O_NONBLOCK: u32 =3D bindings::O_NONBLOCK;
> > > > +
> > > > +    /// File is using nonblocking I/O.
> > > > +    ///
> > > > +    /// This is effectively the same flag as [`O_NONBLOCK`] on all=
 architectures
> > > > +    /// except SPARC64.
> > > > +    pub const O_NDELAY: u32 =3D bindings::O_NDELAY;
> > > > +
> > > > +    /// Used to obtain a path file descriptor.
> > > > +    pub const O_PATH: u32 =3D bindings::O_PATH;
> > > > +
> > > > +    /// Write operations on this file will flush data and metadata=
.
> > > > +    pub const O_SYNC: u32 =3D bindings::O_SYNC;
> > > > +
> > > > +    /// This file is an unnamed temporary regular file.
> > > > +    pub const O_TMPFILE: u32 =3D bindings::O_TMPFILE;
> > > > +
> > > > +    /// File should be truncated to length 0.
> > > > +    pub const O_TRUNC: u32 =3D bindings::O_TRUNC;
> > > > +
> > > > +    /// Bitmask for access mode flags.
> > > > +    ///
> > > > +    /// # Examples
> > > > +    ///
> > > > +    /// ```
> > > > +    /// use kernel::file;
> > > > +    /// # fn do_something() {}
> > > > +    /// # let flags =3D 0;
> > > > +    /// if (flags & file::flags::O_ACCMODE) =3D=3D file::flags::O_=
RDONLY {
> > > > +    ///     do_something();
> > > > +    /// }
> > > > +    /// ```
> > > > +    pub const O_ACCMODE: u32 =3D bindings::O_ACCMODE;
> > > > +
> > > > +    /// File is read only.
> > > > +    pub const O_RDONLY: u32 =3D bindings::O_RDONLY;
> > > > +
> > > > +    /// File is write only.
> > > > +    pub const O_WRONLY: u32 =3D bindings::O_WRONLY;
> > > > +
> > > > +    /// File can be both read and written.
> > > > +    pub const O_RDWR: u32 =3D bindings::O_RDWR;
> > > > +}
> > > > +
> > > > +/// Compile-time information for keeping track of how a [`File`] i=
s shared.
> > > > +///
> > > > +/// The `fdget_pos` method can be used to access the file's positi=
on without taking `f_pos_lock`,
> > > > +/// as long as the file is not shared with any other threads. Duri=
ng such calls to `fdget_pos`, the
> > > > +/// file must remain non-shared, so it must not be possible to mov=
e the file to another thread. For
> > > > +/// example, if the file is moved to another thread, then it could=
 be passed to `fd_install`, at
> > > > +/// which point the remote process could touch the file position.
> > > > +///
> > > > +/// The share mode only keeps track of whether there are active `f=
dget_pos` calls that did not take
> > > > +/// the `f_pos_lock`, and does not keep track of `fdget` calls. Th=
is is okay because `fdget` does
> > > > +/// not care about the refcount of the underlying `struct file`; a=
s long as the entry in the
> > > > +/// current thread's fd table does not get removed, it's okay to s=
hare the file. For example,
> > > > +/// `fd_install`ing the `struct file` into another process is okay=
 during an `fdget` call, because
> > > > +/// the other process can't touch the fd table of the original pro=
cess.
> > > > +mod share_mode {
> > > > +    /// Trait implemented by the two sharing modes that a file mig=
ht have.
> > > > +    pub trait FileShareMode {}
> > > > +
> > > > +    /// Represents a file for which there might be an active call =
to `fdget_pos` that did not take
> > > > +    /// the `f_pos_lock` lock.
> > > > +    pub enum MaybeFdgetPos {}
> > > > +
> > > > +    /// Represents a file for which it is known that all active ca=
lls to `fdget_pos` (if any) took
> > > > +    /// the `f_pos_lock` lock.
> > > > +    pub enum NoFdgetPos {}
> > > > +
> > > > +    impl FileShareMode for MaybeFdgetPos {}
> > > > +    impl FileShareMode for NoFdgetPos {}
> > > > +}
> > > > +pub use self::share_mode::{FileShareMode, MaybeFdgetPos, NoFdgetPo=
s};
> > > > +
> > > > +/// Wraps the kernel's `struct file`.
> > > > +///
> > > > +/// This represents an open file rather than a file on a filesyste=
m. Processes generally reference
> > > > +/// open files using file descriptors. However, file descriptors a=
re not the same as files. A file
> > > > +/// descriptor is just an integer that corresponds to a file, and =
a single file may be referenced
> > > > +/// by multiple file descriptors.
> > > > +///
> > > > +/// # Refcounting
> > > > +///
> > > > +/// Instances of this type are reference-counted. The reference co=
unt is incremented by the
> > > > +/// `fget`/`get_file` functions and decremented by `fput`. The Rus=
t type `ARef<File>` represents a
> > > > +/// pointer that owns a reference count on the file.
> > > > +///
> > > > +/// Whenever a process opens a file descriptor (fd), it stores a p=
ointer to the file in its fd
> > > > +/// table (`struct files_struct`). This pointer owns a reference c=
ount to the file, ensuring the
> > > > +/// file isn't prematurely deleted while the file descriptor is op=
en. In Rust terminology, the
> > > > +/// pointers in `struct files_struct` are `ARef<File>` pointers.
> > > > +///
> > > > +/// ## Light refcounts
> > > > +///
> > > > +/// Whenever a process has an fd to a file, it may use something c=
alled a "light refcount" as a
> > > > +/// performance optimization. Light refcounts are acquired by call=
ing `fdget` and released with
> > > > +/// `fdput`. The idea behind light refcounts is that if the fd is =
not closed between the calls to
> > > > +/// `fdget` and `fdput`, then the refcount cannot hit zero during =
that time, as the `struct
> > > > +/// files_struct` holds a reference until the fd is closed. This m=
eans that it's safe to access the
> > > > +/// file even if `fdget` does not increment the refcount.
> > > > +///
> > > > +/// The requirement that the fd is not closed during a light refco=
unt applies globally across all
> > > > +/// threads - not just on the thread using the light refcount. For=
 this reason, light refcounts are
> > > > +/// only used when the `struct files_struct` is not shared with ot=
her threads, since this ensures
> > > > +/// that other unrelated threads cannot suddenly start using the f=
d and close it. Therefore,
> > > > +/// calling `fdget` on a shared `struct files_struct` creates a no=
rmal refcount instead of a light
> > > > +/// refcount.
> > > > +///
> > > > +/// Light reference counts must be released with `fdput` before th=
e system call returns to
> > > > +/// userspace. This means that if you wait until the current syste=
m call returns to userspace, then
> > > > +/// all light refcounts that existed at the time have gone away.
> > >
> > > You obviously are aware of this but I'm just spelling it out. Iirc,
> > > there will practically only ever be one light refcount per file.
> > >
> > > For a light refcount to be used we know that the file descriptor tabl=
e
> > > isn't shared with any other task. So there are no threads that could
> > > concurrently access the file descriptor table. We also know that the
> > > file descriptor table cannot become shared while we're in system call
> > > context because the caller can't create new threads and they can't
> > > unshare the file descriptor table.
> > >
> > > So there's only one fdget() caller (Yes, they could call fdget()
> > > multiple times and then have to do fdput() multiple times but that's =
a
> > > level of weirdness that we don't need to worry about.).
> >=20
> > Hmm. Is it not the case that different processes with different file
> > descriptor tables could reference the same underlying `struct file` and
> > both use light refcounts to do so, as long as each fd table is not
> > shared? So there could be multiple light refcounts to the same `struct
> > file` at the same time on different threads.
>=20
> That's correct.
> But I misread what you were trying to say then. I thought you were
> talking about multiple light references from the same thread which is
> rather rare and should only happen in system calls that take two fds.
>=20
> But what you're talking about is the same struct file being present in
> separate file descriptor tables and referenced multiple times from
> different threads so in that sense we have multiple light references.
> And that's obviously correct.
>=20
> >=20
> > And this does *not* apply to `fdget_pos`, which checks the refcount of
> > the `struct file` instead of the refcount of the fd table.
>=20
> I have only skimmed the replies down thread so far but I saw that this
> has mostly been clarified. The reference counting between fdget() and
> fdget_pos() is identical. fdget_pos() calls fdget() after all.
>=20
> What's different is that if the file is already shared among different
> processes then even if a light reference was taken by the caller because
> it doesn't share the file descriptor table fdget_pos() may still acquire
> the f_pos_lock because the struct file is referenced by multiple
> processes.
>=20
> IOW, you could have the same struct file in the file descriptor tables
> of 10 processes. So the f_count would be 10. Assume all of them
> concurrently call read(), then none of them will bump f_count because
> fdget() sees that the file descriptor tables aren't shared.
>=20
> But all 10 of them will serialize on f_pos_lock. So that's really
> separate from light refcounting. If you have to acquire f_pos_lock from
> within the same thread then fdget*() always take normal reference
> counts.

See my reply to Al Viro.
https://lore.kernel.org/r/20240527160356.3909000-1-aliceryhl@google.com

> > > > +///
> > > > +/// ### The file position
> > > > +///
> > > > +/// Each `struct file` has a position integer, which is protected =
by the `f_pos_lock` mutex.
> > > > +/// However, if the `struct file` is not shared, then the kernel m=
ay avoid taking the lock as a
> > > > +/// performance optimization.
> > > > +///
> > > > +/// The condition for avoiding the `f_pos_lock` mutex is different=
 from the condition for using
> > > > +/// `fdget`. With `fdget`, you may avoid incrementing the refcount=
 as long as the current fd table
> > > > +/// is not shared; it is okay if there are other fd tables that al=
so reference the same `struct
> > > > +/// file`. However, `fdget_pos` can only avoid taking the `f_pos_l=
ock` if the entire `struct file`
> > > > +/// is not shared, as different processes with an fd to the same `=
struct file` share the same
> > > > +/// position.
> > > > +///
> > > > +/// ## Rust references
> > > > +///
> > > > +/// The reference type `&File` is similar to light refcounts:
> > > > +///
> > > > +/// * `&File` references don't own a reference count. They can onl=
y exist as long as the reference
> > > > +///   count stays positive, and can only be created when there is =
some mechanism in place to ensure
> > > > +///   this.
> > > > +///
> > > > +/// * The Rust borrow-checker normally ensures this by enforcing t=
hat the `ARef<File>` from which
> > > > +///   a `&File` is created outlives the `&File`.
> > > > +///
> > > > +/// * Using the unsafe [`File::from_ptr`] means that it is up to t=
he caller to ensure that the
> > > > +///   `&File` only exists while the reference count is positive.
> > > > +///
> > > > +/// * You can think of `fdget` as using an fd to look up an `ARef<=
File>` in the `struct
> > > > +///   files_struct` and create an `&File` from it. The "fd cannot =
be closed" rule is like the Rust
> > > > +///   rule "the `ARef<File>` must outlive the `&File`".
> > > > +///
> > > > +/// # Invariants
> > > > +///
> > > > +/// * All instances of this type are refcounted using the `f_count=
` field.
> > > > +/// * If the file sharing mode is `MaybeFdgetPos`, then all active=
 calls to `fdget_pos` that did
> > > > +///   not take the `f_pos_lock` mutex must be on the same thread a=
s this `File`.
> > > > +/// * If the file sharing mode is `NoFdgetPos`, then there must no=
t be active calls to `fdget_pos`
> > > > +///   that did not take the `f_pos_lock` mutex.
> > > > +#[repr(transparent)]
> > > > +pub struct File<S: FileShareMode> {
> > > > +    inner: Opaque<bindings::file>,
> > > > +    _share_mode: PhantomData<S>,
> > > > +}
> > > > +
> > > > +// SAFETY: This file is known to not have any local active `fdget_=
pos` calls, so it is safe to
> > > > +// transfer it between threads.
> > > > +unsafe impl Send for File<NoFdgetPos> {}
> > > > +
> > > > +// SAFETY: This file is known to not have any local active `fdget_=
pos` calls, so it is safe to
> > > > +// access its methods from several threads in parallel.
> > > > +unsafe impl Sync for File<NoFdgetPos> {}
> > > > +
> > > > +/// File methods that only exist under the [`MaybeFdgetPos`] shari=
ng mode.
> > > > +impl File<MaybeFdgetPos> {
> > > > +    /// Constructs a new `struct file` wrapper from a file descrip=
tor.
> > > > +    ///
> > > > +    /// The file descriptor belongs to the current process, and th=
ere might be active local calls
> > > > +    /// to `fdget_pos`.
> > > > +    pub fn fget(fd: u32) -> Result<ARef<File<MaybeFdgetPos>>, BadF=
dError> {
> > > > +        // SAFETY: FFI call, there are no requirements on `fd`.
> > > > +        let ptr =3D ptr::NonNull::new(unsafe { bindings::fget(fd) =
}).ok_or(BadFdError)?;
> > > > +
> > > > +        // SAFETY: `bindings::fget` created a refcount, and we pas=
s ownership of it to the `ARef`.
> > > > +        //
> > > > +        // INVARIANT: This file is in the fd table on this thread,=
 so either all `fdget_pos` calls
> > > > +        // are on this thread, or the file is shared, in which cas=
e `fdget_pos` calls took the
> > > > +        // `f_pos_lock` mutex.
> > > > +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> > > > +    }
> > >
> > > I'm a little unclear how this is supposed to be used. What I
> > > specifically struggle with is what function does one have to call to
> > > translate from a file descriptor to a file? IOW, where are the actual
> > > entry points for turning fds into files? That's what I want to see an=
d
> > > that's what we need to make this interface usable generically.
> >=20
> > That is File::fget. It takes a file descriptor and returns a long-term
> > reference to a file.
>=20
> Ok.
>=20
> >=20
> > > Because naively, what I'm looking for is a Rust version of fdget() an=
d
> > > fdget_pos() that give me back a File<MaybeFdget> or a
> > > File<MaybeFdgetPos>.
> > >
> > > And then those both implement a get_file() method so the caller can t=
ake
> > > an explicit long-term reference to the file.
> >=20
> > Even if you call `get_file` to get a long-term reference from something
> > you have an fdget_pos reference to, that doesn't necessarily mean that
> > you can share that long-term reference with other threads. You would
> > need to release the fdget_pos reference first. For that reason, the
> > long-term reference returned by `get_file` would still need to have the
> > `File<MaybeFdgetPos>` type.
>=20
> So what you're getting at seems to be that some process has a private
> file descriptor table and an just opened @fd to a @file that isn't
> shared.
>=20
> 	fd =3D open("/my/file");
>=20
> and then let's say has a random ioctl(fd, SOMETHING_SOMETHING) that
> somehow does:
>=20
> 	struct fd fd =3D fdget_pos();
> 	if (!fd.file)
> 		return -EBADF;
>=20
> We know that process has used a light reference count and that it didn't
> acquire f_pos_lock.
>=20
> Your whole approach seems to assume that after something like this has
> happened the same process now offloads that struct file to another
> process that somehow ends up doing some other operation on the file that
> would also require f_pos_lock to be taken but it doesn't like a read or
> something.

Can we not have a data race even if the other process *does* take the
f_pos_lock mutex? The current thread did not take the mutex, so if the
current thread touches the file position after sending the file
reference, then that could race with the other process even if the
other process takes f_pos_lock.

> To share a file between multiple processes would normally always require
> that the process sends that file to another process. That process then
> install that fd into its file descriptor table and then later accesses
> that file via fdget() again. That's the standard way of doing it -
> binder does it that way too. And that's all perfectly fine.

And similarly, if the remote process installs the file, returns to
userspace, and then userspace calls back into the kernel, which enters
an fdget_pos scope and modifies the file position. Then this can also
race on the file position if the original process changes the file
position it after sending the file reference.

*That's* the data race that this is trying to prevent.

> What you would need for this to be a problem is for a process be sent a
> struct file from a process that is in the middle of an f_pos_lock scope
> and for the receiving process to immediately start doing stuff that
> would normally require f_pos_lock.
>=20
> Like, idk vfs_read(file, ...).
>=20
> If that's what this is about then yes, there's a close-to-zero but
> non-zero possibility that some really stupid code could end up doing
> something like this.
>=20
> Basically, that scenario doesn't exist (as I've mentioned before)
> currently. It only exists in a single instance and that's when
> pidfd_getfd() is used to steal a file from another task while that task
> is in the middle of an f_pos_lock section (I said it before we don't
> care about that because non-POSIX interface anyway and we have ptrace
> rights anyway. And iiuc that wouldn't even be preventable in your
> current scheme because you would need to have the information available
> that the struct file you're about to steal from the file descriptor
> table is currently within an f_pos_lock section.).
>=20
> Is it honestly worth encoding all that complexity into rust's file
> implementation itself right now? It's barely understandable to
> non-rust experts as it is right now. :)
>=20
> Imho, it would seem a lot more prudent to just have something simpler
> for now.

The purpose of the changes I've made are to prevent data races on the
file position. If we go back to what we had before, then the API does
not make it impossible for users of the API to cause such data races.

That is the tradeoff.

> > (But you could convert it to a `File<NoFdgetPos>` afterwards. The
> > `assume_no_fdget_pos` method performs that conversion.)
> >=20
> > As a sidenote, the reason that this patchset does not implement `fdget`
> > or `fdget_pos` is that Rust Binder does not use them. Like C Binder, it
>=20
> Yes, you mentioned.
>=20
> > just uses `fget` to immediately obtain a long-term reference. I was tol=
d
>=20
> Right and that's why I'm confused why that whole shared_state
> machinery is needed in the first place. Because binder does do it
> correctly:
>=20
> * sender registers a bunch of fds to use and takes fget() reference
>   All other processes that use the same file in their fdtable and rely
>   on fdget_pos() will see the elevated reference count and acquire
>   f_pos_lock.
> * receiver installs stuff into their fdtable
>   Receiver can now use fdget_pos() to do reads/writes. Everything's in
>   order as well.
>=20
> > that as an exception, Rust code can be merged *before* its user, but
> > that we couldn't merge Rust code with no upcoming user. However, I can
> > include implementations of `fdget` and `fdget_pos` in the next version
> > if you prefer that. After all, it seems rather likely that we will
> > eventually have a user for fdget.
> >=20
> > > The fget() above is really confusing to me because it always takes a
> > > reference on the file that's pointed to by the fd and then it returns=
 a
> > > MaybeFdgetPos because presumably you want to indicate that the file
> > > descriptor may refer to a file that may or may not be referenced by
> > > another thread via fdget()/fdget_pos() already.
> >=20
> > No, not another thread. It is because it may or may not be referenced b=
y
> > fdget_pos by *the same* thread already.
> >=20
> > Here's how I think of it: The `fget` method takes a file descriptor and
> > returns a long term reference (an ARef) to a `struct file`. It does not
> > return a file descriptor, since it doesn't store anywhere which fd it
> > came from.
> >=20
> > The `File::fget` method returns a `File<MaybeFdgetPos>` in case *the
> > same thread* is also using `fdget_pos` on the same file descriptor. It'=
s
> > okay if other threads are using `fdget_pos` because in that case the
> > file is already shared, so those other `fdget_pos` calls necessarily th=
e
> > f_pos_lock mutex.
> >=20
> > Note that since it forgets which fd and fd table it came from, calls to
> > `fdget` are actually not a problem for sending our long-term references
> > across threads. The `fdget` requirements only care about things that
> > touch the entry in the file descriptor table, such as closing the fd.
> > The `ARef<File>` type does not provide any methods that could lead to
> > that happening, so sharing it across threads is okay *even if* there is
> > an light reference. That's why I have an `MaybeFdgetPos` but no
> > `MaybeFdget`.
> >=20
> > > So I've _skimmed_ the binder RFC and looked at:
> > > 20231101-rust-binder-v1-13-08ba9197f637@google.com
> > > which states:
> > >
> > >         Add support for sending fds over binder.
> > >
> > >         Unlike the other object types, file descriptors are not trans=
lated until
> > >         the transaction is actually received by the recipient. Until =
that
> > >         happens, we store `u32::MAX` as the fd.
> > >
> > >         Translating fds is done in a two-phase process. First, the fi=
le
> > >         descriptors are allocated and written to the allocation. Then=
, once we
> > >         have allocated all of them, we commit them to the files in qu=
estion.
> > >         Using this strategy, we are able to guarantee that we either =
send all of
> > >         the fds, or none of them.
> > >
> > > So I'm curious. How does the binder fd sending work exactly? Because =
I
> > > feel that this is crucial to understand here. Some specific questions=
:
> > >
> > > * When file descriptors are passed the reference to these files via
> > >   fget() are taken _synchronously_, i.e., by the sending task, not th=
e
> > >   receiver? IOW, is binder_translate_fd() called in the context of th=
e
> > >   sender or the receiver. I assume it must be the sender because
> > >   otherwise the sender and receiver must share a file descriptor tabl=
e
> > >   in order for the receiver to call fget().
> >=20
> > binder_translate_fd is called in the context of the sender.
> >=20
> > > * The receiving task then allocates new file descriptors and installs
> > >   the received files into its file descriptor table?
> >=20
> > That happens in binder_apply_fd_fixups, which is called in the context
> > of the receiver.
>=20
> Yes, that's what I thought.
>=20
> >=20
> > I can see how the sentence "Until that happens, we store `u32::MAX` as
> > the fd." is really confusing here. What happens when you send a fd is
> > this:
> >=20
> > In the sender's ioctl:
> > 1. The sender wishes to send a byte array to the recipient. The sender
> >    tells the kernel that at specific offsets in this array, there are
> >    some file descriptors that it wishes to send.
> >=20
> > 2. The kernel copies the byte array directly into the recipient's
> >    address space. The offsets in the byte array with file descriptors
> >    are not copied - instead u32::MAX is written temporarily at those
> >    offsets.
> >=20
> > 3. For each fd being sent, the kernel uses fget to obtain a reference t=
o
> >    the underlying `struct file`. These pointers are stored in an array.
> >=20
> > In the receiver's ioctl:
> > 1. Go through the list of `struct file` pointers and create a
> >    `FileDescriptorReservation` for each.
> >=20
> > 2. Go through the list of `struct file` pointers again and `fd_install`
> >    them into the current thread's fd table. This is infallible due to
> >    the reservations we just made.
> >=20
> > 3. Finally, overwrite the u32::MAX values in the byte array with the
> >    actual file descriptors that the files were assigned.
> >=20
> > This is the same as how it works in C Binder.
>=20
> Yes, that all seems fine.
>=20
> >=20
> > > And so basically, what I'm after here is that the binder_translate_fd=
()
> > > that calls fget() is done in the context of the sender and we _know_
> > > that the fds can't have light references. Because if they did it coul=
d
> > > only be by the calling task but they don't since the calling task use=
s
> > > fget() on them. And if the calling task is multi-threaded and another
> > > thread has called fdget() or fdget_pos() we know that they have taken
> > > their own reference because the file descriptor table is shared.
> > >
> > > So why is that fget() in here returning a File<MaybeFdgetPos>? This
> > > doesn't make sense to me at first glance.
> >=20
> > Because when you call `File::fget`, then there could also be a differen=
t
> > call to `fdget_pos` on the same thread on the same file descriptor.
> >=20
> > 	fdget_pos(my_fd);
> > 	let my_file =3D File::fget(my_fd)?;
> > 	// oh no!
> > 	send_to_another_thread(my_file);
>=20
> Ok, that's basically my above example.
>=20
> >=20
> > In the above code, the file becomes shared even though `fdget_pos` migh=
t
> > not have taken the `f_pos_lock` mutex. That's not okay. We could end up
> > with a data race on the file position.
>=20
> But a race on f_pos isn't a memory safety issue it's just a POSIX
> ordering requirement.

Memory safety may be the wrong word, but data races *are* on the list of
things that Rust tries to prevent.

Alice

> > One of the primary design principles of Rust is that, if the user of ou=
r
> > API has *any* way of using it that could trigger a memory safety
> > problem, then we must be able to point at an unsafe block *in the user'=
s
> > code* that is at fault. This must be the case no matter how contrived
> > the use of the API is.
> >=20
> > As a corollary, if the user can trigger memory safety problems with our
> > API without using any unsafe blocks, then that is a bug in the API.
> > We cannot assign the blame to an unsafe block in the user's code, so th=
e
> > blame *must* lie with an unsafe block inside the API.
> >=20
> > So, to follow that design principle, I have designed the API in a way
> > that prevents the above data race. Concretely, because the
> > `File<MaybeFdgetPos>` type is not thread safe (or in Rust terms "is not
> > Send"), it's not possible to send values of that type across thread
> > boundaries. E.g., our `send_to_another_thread` would have a requirement
> > in its signature saying that it can only be called with types that are
> > thread safe, so calling it with a type that isn't results in a type
> > error.
> >=20
> >=20
> >=20
> > Now, what if you *want* to send it to another thread? Let's consider
> > Rust Binder, which needs to do exactly that. The relevant code in Rust
> > Binder would need to be updated to look like this:
> >=20
> > 	let file =3D File::fget(my_fd)?;
> > 	// SAFETY: We know that there are no active `fdget_pos` calls on
> > 	// the current thread, since this is an ioctl and we have not
> > 	// called `fdget_pos` inside the Binder driver.
> > 	let thread_safe_file =3D unsafe { file.assume_no_fdget_pos() };
> >=20
> > (search for File::from_fd in the RFC to find where this would go)
> >=20
> > The `assume_no_fdget_pos` call has no effect at runtime - it is purely =
a
> > compile-time thing to force the user to use unsafe to "promise" that
> > there aren't any `fdget_pos` calls on the same fd.
> >=20
> > If Rust Binder uses `assume_no_fdget_pos` and ends up triggering memory
> > unsafety because it sent a file to another thread, then we can point to
> > the unsafe block that calls `assume_no_fdget_pos` and say "that unsafe
> > block is at fault because it assumed that there was no `fdget_pos` call=
,
> > but that assumption was false."
> >=20
> > > > +    /// Assume that there are no active `fdget_pos` calls that pre=
vent us from sharing this file.
> > > > +    ///
> > > > +    /// This makes it safe to transfer this file to other threads.=
 No checks are performed, and
> > > > +    /// using it incorrectly may lead to a data race on the file p=
osition if the file is shared
> > > > +    /// with another thread.
> > > > +    ///
> > > > +    /// This method is intended to be used together with [`File::f=
get`] when the caller knows
> > > > +    /// statically that there are no `fdget_pos` calls on the curr=
ent thread. For example, you
> > > > +    /// might use it when calling `fget` from an ioctl, since ioct=
ls usually do not touch the file
> > > > +    /// position.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// There must not be any active `fdget_pos` calls on the curr=
ent thread.
> > > > +    pub unsafe fn assume_no_fdget_pos(me: ARef<Self>) -> ARef<File=
<NoFdgetPos>> {
> > > > +        // INVARIANT: There are no `fdget_pos` calls on the curren=
t thread, and by the type
> > > > +        // invariants, if there is a `fdget_pos` call on another t=
hread, then it took the
> > > > +        // `f_pos_lock` mutex.
> > > > +        //
> > > > +        // SAFETY: `File<MaybeFdgetPos>` and `File<NoFdgetPos>` ha=
ve the same layout.
> > > > +        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
> > > > +    }
> > > > +}
> > > > +
> > > > +/// File methods that exist under all sharing modes.
> > > > +impl<S: FileShareMode> File<S> {
> > > > +    /// Creates a reference to a [`File`] from a valid pointer.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// * The caller must ensure that `ptr` points at a valid file=
 and that the file's refcount is
> > > > +    ///   positive for the duration of 'a.
> > > > +    /// * The caller must ensure that the requirements for using t=
he chosen file sharing mode are
> > > > +    ///   upheld.
> > > > +    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a =
File<S> {
> > >
> > > I think I requested from_raw_file() in the last revision?
> >=20
> > Ah, yeah, I totally forgot about this. I'll make the change in the next
> > version.
> >=20
> > > > +    /// Returns a raw pointer to the inner C struct.
> > > > +    #[inline]
> > > > +    pub fn as_ptr(&self) -> *mut bindings::file {
> > >
> > > And that was supposed to be into_raw_file() or as_raw_file()?
> >=20
> > Per the Rust API guidelines [1], this should be `as_raw_file`. The
> > `into_*` prefix is for conversions that destroy the object you call it
> > on. (E.g., because it takes ownership of the underlying allocation or
> > refcount.)
> >=20
> > As always, thank you for the very detailed questions!
> >=20
> > Alice
> >=20
> > [1]: https://rust-lang.github.io/api-guidelines/naming.html#ad-hoc-conv=
ersions-follow-as_-to_-into_-conventions-c-conv


