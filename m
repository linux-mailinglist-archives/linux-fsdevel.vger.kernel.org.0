Return-Path: <linux-fsdevel+bounces-9989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CACC846E68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7111C236B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8CE13E236;
	Fri,  2 Feb 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wk18TbdO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858313D4E4
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871358; cv=none; b=smcQ5dtKOWHJ/GHom9l6oV2BO4HL5E5NnwQPOXWHGYo3/nMJPH7uKIu84wQCxfNYYQ1ccQd1POGqzF29K/UxfEh+4k0T6P5hnllki+6WJjGd/3SfGAF6i628DH+y3iSsGjfa3FMwLkjkVkgclUttVpp4r51dwXK1vtQ4pAnpvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871358; c=relaxed/simple;
	bh=OK6nCgH+RyE9t7EW8698kuFkSaxikkJxGDMbdUM44M8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TJNV1fFTQcQgCZi9w0hDvm0YbjAcZ7CTDPZkCl54aU4FDQY1/JWKlVLlCHApZtctfdoO3NMEI37rmeJbHorTCe1rJU4Sy3vPpzluzk6I4L+x7Kr8UZZfv0BDjASF3XHkcUzUtPF5xtfad0KDDZSkrkSxJ4k3HjQ/tI5TNpXR+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wk18TbdO; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-5111c8cc4e5so1648337e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871355; x=1707476155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wv9nx/hg++Pfxe9omwezAG39k+nXIE0TtJhZJnwGio=;
        b=Wk18TbdOyW0VJM07TyBd3yHnF1rczWomLAFsvVUTjoPdJ7zq3ej9b/h7zoMMdb1q0i
         vbYkEdZ1F4Eh5dVlgWUX1wtR9A9iLocUtXWLZ8PDy4iVc9iadCOX5WOjLwpN4KlAJ+Vi
         h5vC0tZnJRU4wPlRGRaVkLCTc+WMJOKrjdPG3F4wV/PQJWjZ6AoXDJQ1CfH7G7kHd2Dm
         eZ1JwipRv0XQrCTXI3zib4ds5K/nV7rE/5DJ1qorlbdy6e+M4kBcmmGsFV5MUrE5F/XN
         excGYtX3tcDgQxwjUx96ISN3P1tyT2jCYD725TbuX0bLVucf3i3fAyWdRBGpseQwCdz8
         zyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871355; x=1707476155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wv9nx/hg++Pfxe9omwezAG39k+nXIE0TtJhZJnwGio=;
        b=itv5aOEMfMr8sOb0lXqmPTxJ5cfpvVKQUJbN1mmf7SKDSOZToa/IJT+lXUESUhR27H
         elJ6U5qCCetA+IpGsgkZIIvS76gdSdjDhYznUS/NhictDU6VTyJX6zFfoEV8PGt+H5lt
         hd/KUvrN6YU6uWHdHikZJY9JAK/MsZnkjcCwrnM4CAu4iEM3Q+uyVEvNSgtsVQoV2zdQ
         TA7juWdXIN2v1x73RGKgxi90LNvfBdQ8m+Q4TmYCWwauZJ5Zkig6f61qRpf1MLX9yQK0
         iWKeCpqrxBAHAThNfpxYTzaLkSQmugBQrm03ucb4gxQwktc2lKyL/tnaFMzM2eQs9Ylk
         G/xw==
X-Gm-Message-State: AOJu0YxfvaZ4Adjr+ImWjmEvs+SjtsmdkxGhSIXAFg3UpUk+mue4y+ED
	rfanhh47QzNLUS4CWlo54MhgGxilNImYzH8sAGNEO9d/Ls1fE7DEm8lHduZW0ebbyv1EsIC4sS5
	78ZFIkEsBGRFXqA==
X-Google-Smtp-Source: AGHT+IGC1TPs2lTBjyn7k4jDUZOljagG2wgOGJ9ahbhxr/Jmghf/7g1n7+2EQ7AmzdmclSa2r1CuRwFjJCEV5gw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:5e28:0:b0:511:1afb:db4e with SMTP id
 o8-20020ac25e28000000b005111afbdb4emr6094lfg.1.1706871354618; Fri, 02 Feb
 2024 02:55:54 -0800 (PST)
Date: Fri,  2 Feb 2024 10:55:37 +0000
In-Reply-To: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15836; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Y5frGCIgjDFoW7XzeCBNv5ty3pcNGFQjMN/M3VqKY78=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlvMjJm1MjNjNhozhIhF5gOkylEenZy+uL0IMf4
 3IyMk0DpU2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbzIyQAKCRAEWL7uWMY5
 RnWMD/9Bi7eGuJMxqK4PLS2zJPtmSpFQoWK1kDx5RE17sw377z8k58z70xadV1VOF8/sNUnJvkG
 c3yiIFhIwlSgfw4jnl4kK+tw25xRNDDwewgdPfbsIeJfTydwrB4Q2X/fQOw9NNvc0qhWHUyFENd
 8/li+N0srpxJge0c7v+1oiczvDZ+psG7Xy3N6mrXhKYvXPZ2mlPti+xk1JUCs+nkDF1EKFzOzLv
 LolcWEd7B+gQrjTziZlPUFgRKmus1Ffhv/v2bCePQIF04/4ENxO1bLBLltMpz9G+VfI8Kh45RGC
 wPNraGZB8uQ3EH9Q/cfgYEUMjjm8Fn6XzLYrED4vrL7ST78j+ERIpv3AwJTm2LlF7y4DNlAJNbS
 i9neKiss7Nek7wG6KR2qN5YLH53CY1Sp98tthCsB2bcRtK+QZ9Lc6cDtiYqdO880bh4OT/qizYQ
 pSdBwtc7Wsn3hxOz4+teMTW7ggR4nhslXRd4wvhnyYVAK0lscGu2za9Em3Xeh7BHZrGuGr6DtG/
 lnpD97R7SnsaSyyc3chT0gVc05QjKV5vTDAdnrZxBcMfQ2yaQq8UBpxgb7R1fsk4ov8Z88DEnIS
 g/LFlc83Qkl0pQsJZybbtIjYtxiU8o4ve8uMdr4QV2ehS9Oo50cyKmByPMEwv5blyJB3y4mvVNt 7maRZHSqOKeg7Wg==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202-alice-file-v4-3-fc9c2080663b@google.com>
Subject: [PATCH v4 3/9] rust: file: add Rust abstraction for `struct file`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Wedson Almeida Filho <wedsonaf@gmail.com>

This abstraction makes it possible to manipulate the open files for a
process. The new `File` struct wraps the C `struct file`. When accessing
it using the smart pointer `ARef<File>`, the pointer will own a
reference count to the file. When accessing it as `&File`, then the
reference does not own a refcount, but the borrow checker will ensure
that the reference count does not hit zero while the `&File` is live.

Since this is intended to manipulate the open files of a process, we
introduce an `fget` constructor that corresponds to the C `fget`
method. In future patches, it will become possible to create a new fd in
a process and bind it to a `File`. Rust Binder will use these to send
fds from one process to another.

We also provide a method for accessing the file's flags. Rust Binder
will use this to access the flags of the Binder fd to check whether the
non-blocking flag is set, which affects what the Binder ioctl does.

This introduces a struct for the EBADF error type, rather than just
using the Error type directly. This has two advantages:
* `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
  compiler will represent as a single pointer, with null being an error.
  This is possible because the compiler understands that `BadFdError`
  has only one possible value, and it also understands that the
  `ARef<File>` smart pointer is guaranteed non-null.
* Additionally, we promise to users of the method that the method can
  only fail with EBADF, which means that they can rely on this promise
  without having to inspect its implementation.
That said, there are also two disadvantages:
* Defining additional error types involves boilerplate.
* The question mark operator will only utilize the `From` trait once,
  which prevents you from using the question mark operator on
  `BadFdError` in methods that return some third error type that the
  kernel `Error` is convertible into. (However, it works fine in methods
  that return `Error`.)

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 fs/file.c                       |   7 +
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |   7 +
 rust/kernel/file.rs             | 249 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 5 files changed, 266 insertions(+)
 create mode 100644 rust/kernel/file.rs

diff --git a/fs/file.c b/fs/file.c
index 3b683b9101d8..f2eab5fcb87f 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1115,18 +1115,25 @@ EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
  *
  * You can use this instead of fget if you satisfy all of the following
  * conditions:
  * 1) You must call fput_light before exiting the syscall and returning control
  *    to userspace (i.e. you cannot remember the returned struct file * after
  *    returning to userspace).
  * 2) You must not call filp_close on the returned struct file * in between
  *    calls to fget_light and fput_light.
  * 3) You must not clone the current task in between the calls to fget_light
  *    and fput_light.
  *
  * The fput_needed flag returned by fget_light should be passed to the
  * corresponding fput_light.
+ *
+ * (As an exception to rule 2, you can call filp_close between fget_light and
+ * fput_light provided that you capture a real refcount with get_file before
+ * the call to filp_close, and ensure that this real refcount is fput *after*
+ * the fput_light call.)
+ *
+ * See also the documentation in rust/kernel/file.rs.
  */
 static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 {
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 936651110c39..41fcd2905ed4 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -9,6 +9,8 @@
 #include <kunit/test.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
+#include <linux/file.h>
+#include <linux/fs.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..03141a3608a4 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -25,6 +25,7 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
@@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 }
 EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
 
+struct file *rust_helper_get_file(struct file *f)
+{
+	return get_file(f);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_file);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
new file mode 100644
index 000000000000..0d6ef32009c6
--- /dev/null
+++ b/rust/kernel/file.rs
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Files and file descriptors.
+//!
+//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h) and
+//! [`include/linux/file.h`](srctree/include/linux/file.h)
+
+use crate::{
+    bindings,
+    error::{code::*, Error, Result},
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+use core::ptr;
+
+/// Flags associated with a [`File`].
+pub mod flags {
+    /// File is opened in append mode.
+    pub const O_APPEND: u32 = bindings::O_APPEND;
+
+    /// Signal-driven I/O is enabled.
+    pub const O_ASYNC: u32 = bindings::FASYNC;
+
+    /// Close-on-exec flag is set.
+    pub const O_CLOEXEC: u32 = bindings::O_CLOEXEC;
+
+    /// File was created if it didn't already exist.
+    pub const O_CREAT: u32 = bindings::O_CREAT;
+
+    /// Direct I/O is enabled for this file.
+    pub const O_DIRECT: u32 = bindings::O_DIRECT;
+
+    /// File must be a directory.
+    pub const O_DIRECTORY: u32 = bindings::O_DIRECTORY;
+
+    /// Like [`O_SYNC`] except metadata is not synced.
+    pub const O_DSYNC: u32 = bindings::O_DSYNC;
+
+    /// Ensure that this file is created with the `open(2)` call.
+    pub const O_EXCL: u32 = bindings::O_EXCL;
+
+    /// Large file size enabled (`off64_t` over `off_t`).
+    pub const O_LARGEFILE: u32 = bindings::O_LARGEFILE;
+
+    /// Do not update the file last access time.
+    pub const O_NOATIME: u32 = bindings::O_NOATIME;
+
+    /// File should not be used as process's controlling terminal.
+    pub const O_NOCTTY: u32 = bindings::O_NOCTTY;
+
+    /// If basename of path is a symbolic link, fail open.
+    pub const O_NOFOLLOW: u32 = bindings::O_NOFOLLOW;
+
+    /// File is using nonblocking I/O.
+    pub const O_NONBLOCK: u32 = bindings::O_NONBLOCK;
+
+    /// Also known as `O_NDELAY`.
+    ///
+    /// This is effectively the same flag as [`O_NONBLOCK`] on all architectures
+    /// except SPARC64.
+    pub const O_NDELAY: u32 = bindings::O_NDELAY;
+
+    /// Used to obtain a path file descriptor.
+    pub const O_PATH: u32 = bindings::O_PATH;
+
+    /// Write operations on this file will flush data and metadata.
+    pub const O_SYNC: u32 = bindings::O_SYNC;
+
+    /// This file is an unnamed temporary regular file.
+    pub const O_TMPFILE: u32 = bindings::O_TMPFILE;
+
+    /// File should be truncated to length 0.
+    pub const O_TRUNC: u32 = bindings::O_TRUNC;
+
+    /// Bitmask for access mode flags.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::file;
+    /// # fn do_something() {}
+    /// # let flags = 0;
+    /// if (flags & file::flags::O_ACCMODE) == file::flags::O_RDONLY {
+    ///     do_something();
+    /// }
+    /// ```
+    pub const O_ACCMODE: u32 = bindings::O_ACCMODE;
+
+    /// File is read only.
+    pub const O_RDONLY: u32 = bindings::O_RDONLY;
+
+    /// File is write only.
+    pub const O_WRONLY: u32 = bindings::O_WRONLY;
+
+    /// File can be both read and written.
+    pub const O_RDWR: u32 = bindings::O_RDWR;
+}
+
+/// Wraps the kernel's `struct file`.
+///
+/// # Refcounting
+///
+/// Instances of this type are reference-counted. The reference count is incremented by the
+/// `fget`/`get_file` functions and decremented by `fput`. The Rust type `ARef<File>` represents a
+/// pointer that owns a reference count on the file.
+///
+/// Whenever a process opens a file descriptor (fd), it stores a pointer to the file in its `struct
+/// files_struct`. This pointer owns a reference count to the file, ensuring the file isn't
+/// prematurely deleted while the file descriptor is open. In Rust terminology, the pointers in
+/// `struct files_struct` are `ARef<File>` pointers.
+///
+/// ## Light refcounts
+///
+/// Whenever a process has an fd to a file, it may use something called a "light refcount" as a
+/// performance optimization. Light refcounts are acquired by calling `fdget` and released with
+/// `fdput`. The idea behind light refcounts is that if the fd is not closed between the calls to
+/// `fdget` and `fdput`, then the refcount cannot hit zero during that time, as the `struct
+/// files_struct` holds a reference until the fd is closed. This means that it's safe to access the
+/// file even if `fdget` does not increment the refcount.
+///
+/// The requirement that the fd is not closed during a light refcount applies globally across all
+/// threads - not just on the thread using the light refcount. For this reason, light refcounts are
+/// only used when the `struct files_struct` is not shared with other threads, since this ensures
+/// that other unrelated threads cannot suddenly start using the fd and close it. Therefore,
+/// calling `fdget` on a shared `struct files_struct` creates a normal refcount instead of a light
+/// refcount.
+///
+/// Light reference counts must be released with `fdput` before the system call returns to
+/// userspace. This means that if you wait until the current system call returns to userspace, then
+/// all light refcounts that existed at the time have gone away.
+///
+/// ## Rust references
+///
+/// The reference type `&File` is similar to light refcounts:
+///
+/// * `&File` references don't own a reference count. They can only exist as long as the reference
+///   count stays positive, and can only be created when there is some mechanism in place to ensure
+///   this.
+///
+/// * The Rust borrow-checker normally ensures this by enforcing that the `ARef<File>` from which
+///   a `&File` is created outlives the `&File`.
+///
+/// * Using the unsafe [`File::from_ptr`] means that it is up to the caller to ensure that the
+///   `&File` only exists while the reference count is positive.
+///
+/// * You can think of `fdget` as using an fd to look up an `ARef<File>` in the `struct
+///   files_struct` and create an `&File` from it. The "fd cannot be closed" rule is like the Rust
+///   rule "the `ARef<File>` must outlive the `&File`".
+///
+/// # Invariants
+///
+/// * Instances of this type are refcounted using the `f_count` field.
+/// * If an fd with active light refcounts is closed, then it must be the case that the file
+///   refcount is positive until all light refcounts of the fd have been dropped.
+/// * A light refcount must be dropped before returning to userspace.
+#[repr(transparent)]
+pub struct File(Opaque<bindings::file>);
+
+// SAFETY:
+// - `File::dec_ref` can be called from any thread.
+// - It is okay to send ownership of `File` across thread boundaries.
+unsafe impl Send for File {}
+
+// SAFETY: All methods defined on `File` that take `&self` are safe to call even if other threads
+// are concurrently accessing the same `struct file`, because those methods either access immutable
+// properties or have proper synchronization to ensure that such accesses are safe.
+unsafe impl Sync for File {}
+
+impl File {
+    /// Constructs a new `struct file` wrapper from a file descriptor.
+    ///
+    /// The file descriptor belongs to the current process.
+    pub fn fget(fd: u32) -> Result<ARef<Self>, BadFdError> {
+        // SAFETY: FFI call, there are no requirements on `fd`.
+        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
+
+        // SAFETY: `bindings::fget` either returns null or a valid pointer to a file, and we
+        // checked for null above.
+        //
+        // INVARIANT: `bindings::fget` creates a refcount, and we pass ownership of the refcount to
+        // the new `ARef<File>`.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`File`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` points at a valid file and that the file's refcount is
+    /// positive for the duration of 'a.
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of 'a. The cast is okay because `File` is `repr(transparent)`.
+        //
+        // INVARIANT: The safety requirements guarantee that the refcount does not hit zero during
+        // 'a.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns a raw pointer to the inner C struct.
+    #[inline]
+    pub fn as_ptr(&self) -> *mut bindings::file {
+        self.0.get()
+    }
+
+    /// Returns the flags associated with the file.
+    ///
+    /// The flags are a combination of the constants in [`flags`].
+    pub fn flags(&self) -> u32 {
+        // This `read_volatile` is intended to correspond to a READ_ONCE call.
+        //
+        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
+        //
+        // TODO: Replace with `read_once` when available on the Rust side.
+        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `File` is always ref-counted. This implementation
+// makes `ARef<File>` own a normal refcount.
+unsafe impl AlwaysRefCounted for File {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_file(self.as_ptr()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<File>) {
+        // SAFETY: To call this method, the caller passes us ownership of a normal refcount, so we
+        // may drop it. The cast is okay since `File` has the same representation as `struct file`.
+        unsafe { bindings::fput(obj.cast().as_ptr()) }
+    }
+}
+
+/// Represents the `EBADF` error code.
+///
+/// Used for methods that can only fail with `EBADF`.
+#[derive(Copy, Clone, Eq, PartialEq)]
+pub struct BadFdError;
+
+impl From<BadFdError> for Error {
+    fn from(_: BadFdError) -> Error {
+        EBADF
+    }
+}
+
+impl core::fmt::Debug for BadFdError {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        f.pad("EBADF")
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b89ecf4e97a0..9353dd713a20 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,7 @@
 mod allocator;
 mod build_assert;
 pub mod error;
+pub mod file;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
-- 
2.43.0.594.gd9cf4e227d-goog


