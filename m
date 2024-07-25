Return-Path: <linux-fsdevel+bounces-24244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4BF93C422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B63285822
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAF19DFB6;
	Thu, 25 Jul 2024 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J24szGg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61419DF75
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917676; cv=none; b=YAcnsUpyOxYx2J8mO+WBLUyWJBFUZrWssRFgXWAX6RWYkhFj3+8xtbbeBeKDTLObS2jVy+9JrV0TxzKOf6cK1nqviSCTB8/m+tI5EeT9HxQ148uRZSDbTaRFsPhAXlCy56RFAlBc++NwEaOTh1VT1S2T9aooZATz3ZQEp5YWAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917676; c=relaxed/simple;
	bh=tZmP/exOJqVMU3pbXZPV0jYvSiyzlcGQQjEC7T9Sw+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fkxp8b90x15NUUHGEhHaqG9iYuPpcQ+/fhtgOtFzEAFN0wiV6XWSWMu3QfBbuVMt/eUexH8uN2AqcUCXFjLSL4X1WUObytGr5RQTv8Qw6TewAgcBkBqCPHvzD8FMcaxOpky1FKE7C28bsUtitsFKkx9YK7cxl2a51N6rS+prNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J24szGg9; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2ef315c6990so1592441fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721917671; x=1722522471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PtKhdfCpcsJ3ZgZBrn1gqMPcNc/frbhz/ZePW+P05s=;
        b=J24szGg9YvYMqZzctw8BZOyO1QrGjghHD4QXdNuB5JTXsFJxnZ74TwZIR4mZ+GZPdh
         CfXGJfebLlpdgywDVTbJ0M8ph8EmakRKzV1Bf++CEYApdiYb0dI2AMdNvID+lErEdUIM
         RQUPydoIWbKhotLzZkWDyZQD0SCiAZ+5T42AbmCszPBhmqRhWXJJ5rlGeRb6q8yId9Hw
         7yeu4HuGuQ9LXvNJSIIPG3VxL0YOuEEVitjUDtdJxgzvcVkCAOiy+RBsz8KNduPcGop5
         pQpKBZq1rppKPnb51kZpyHy866UmawDCHo9IPpzWgLXcgW4y2fQLP3X3Pd/dSREZR3XK
         EGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917671; x=1722522471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PtKhdfCpcsJ3ZgZBrn1gqMPcNc/frbhz/ZePW+P05s=;
        b=LEI9qawniCKPDrYVPhxsevNtFQd1M8x578WDSQ8Eni5ITDHU3AjSdKJqr6EeLUAjaM
         X6shnxnVxyh9UvU1Nj9xL/ktaekIQ3DqSRD8vhTwynDpMD3cAUbHFQp0fLl2Q9qh/yxg
         hd68/442xjlJwh71VApLzFe3aangiiTIrxZFE9ffFJT6I6fgkDFdyegVHhyuwFDaDPie
         HwoePcUINT+O1MC/r2IlqKsQV8KhpKwGYKZ5qalQt09frM+gT3B/rF/+AOqrE6JsDyvI
         ztG1QWhx6nLOhcBAvHXkuO1tdmDMmybl9Cjc4AAKmsq+kvpw4rmM5izpEDbtuqB+8lnI
         Q+qg==
X-Forwarded-Encrypted: i=1; AJvYcCUjBQlD73Pw8xKjLKPZ9TL97wyaQkSnNdgpRV7u/uKFrPvGMMMckINIPIDpuv/KSQItBEfD/CydDGTp6uLstudaWavcBGWKI32SLPEzmw==
X-Gm-Message-State: AOJu0YyE+kkvcci1UlL5Fm9Sw71cygOHiYpIniQ4I02xqc9liGV5My3Q
	UDqkYKH3AYHtVM/CDbWjekA0pEuQGinQzzkCXRakM+MU2i5OW7lmYXvBIXEPA3c/nD/mc5kUHhT
	ZzxHxnCNfFkCBsg==
X-Google-Smtp-Source: AGHT+IGhT+ddWmjsOetwaChqygUw9x0ZlLJk0+533sVWyFxzVDHmQgvQg5WpdkgxP6YMakF/7X6W0GNaGMtPW/Y=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:3318:0:b0:2ef:1c03:73ec with SMTP id
 38308e7fff4ca-2f03a3fa37fmr43881fa.0.1721917671216; Thu, 25 Jul 2024 07:27:51
 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:27:36 +0000
In-Reply-To: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=22113; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wtEVBL3hhHW8DgSuHsZi6E0p/49A2G8Ru/LhkgmYw0U=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmomDYvL/mRgqVHHGN2b4y1BxYsrJLirrVUSX9g
 /fUf9N+RwWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqJg2AAKCRAEWL7uWMY5
 RnqZD/98SbRs6khkB2NUmHwn17mx5ONXCpBpXbpEiswDgpJkTPTJuYuFB0mY7nKu/Xh+tKY2VQk
 whpmPMOKXUOu0oG73UjnvrTpTjtxdWxcKY3iOY0Do99CTz/30yzFWxTWuh7Zl8e8+2MLoBPIQJy
 KP8UjdIq2791nVuF0lgoDbxSGunmjsiXxI+NUuNPiVFk0cyPFdBhYzbe6NgjWpyxrvp+mUwVBjv
 HG+oU51lWGLMRRAIyWUMwD+j0XWMPE2N3rD6nGLDZFtMVO/N/AvVp5tfG1EnZHAqS6BG75QVu4a
 7OnYeCO08aFmxbvMzolyMHZfku+eG2slSCQSK9qCnAJ23gvzXGxxUp7DbNPXVg5lio001gjoyFe
 E1K22BbowaD4QhR9v82lQJLbfuYDXkOvgnnEVxD0KRLqHyRLdyKeIWQ39RMlz4+6L+3CYPDvPwt
 jmrongn6FQ7OJLzbT9mGMKf4y8JY+EHZdr5w/n7HbJhJzTCoYe1heyy3wPoUt+H/yfy/Ii8z5no
 WNFfpXMEE2nKmW+KJ7Ggv+sn3kZm5UgF/kgPF7jLhbV69Kd0oTNBEvmh943QN2QXo5i4BG787ow
 xA4KoFwoDgHYK2wBesd7sr63PwzPmx6+gr9cOcGs/z2JBIJIiZiklLwGi2QN8Q/VVSvXAF0jdJY nKL6XWJW1DHtT7g==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240725-alice-file-v8-3-55a2e80deaa8@google.com>
Subject: [PATCH v8 3/8] rust: file: add Rust abstraction for `struct file`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

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
* `File::fget` returns a `Result<ARef<File>, BadFdError>`, which the
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
 rust/kernel/fs.rs               |   8 +
 rust/kernel/fs/file.rs          | 375 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/types.rs            |   8 +
 7 files changed, 408 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index a3b72aa64f11..1d910f96ec2e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1127,6 +1127,13 @@ EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
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
index f2bafb10f181..e2d22f151ec9 100644
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
index 305f0577fae9..5ba1f6de0251 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -25,6 +25,7 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/mutex.h>
@@ -199,6 +200,12 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_krealloc);
 
+struct file *rust_helper_get_file(struct file *f)
+{
+	return get_file(f);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_file);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
new file mode 100644
index 000000000000..0121b38c59e6
--- /dev/null
+++ b/rust/kernel/fs.rs
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel file systems.
+//!
+//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
+
+pub mod file;
+pub use self::file::{File, LocalFile};
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
new file mode 100644
index 000000000000..f1a52814b2da
--- /dev/null
+++ b/rust/kernel/fs/file.rs
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
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
+    /// File is using nonblocking I/O.
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
+    /// use kernel::fs::file;
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
+/// Wraps the kernel's `struct file`. Thread safe.
+///
+/// This represents an open file rather than a file on a filesystem. Processes generally reference
+/// open files using file descriptors. However, file descriptors are not the same as files. A file
+/// descriptor is just an integer that corresponds to a file, and a single file may be referenced
+/// by multiple file descriptors.
+///
+/// # Refcounting
+///
+/// Instances of this type are reference-counted. The reference count is incremented by the
+/// `fget`/`get_file` functions and decremented by `fput`. The Rust type `ARef<File>` represents a
+/// pointer that owns a reference count on the file.
+///
+/// Whenever a process opens a file descriptor (fd), it stores a pointer to the file in its fd
+/// table (`struct files_struct`). This pointer owns a reference count to the file, ensuring the
+/// file isn't prematurely deleted while the file descriptor is open. In Rust terminology, the
+/// pointers in `struct files_struct` are `ARef<File>` pointers.
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
+/// ### The file position
+///
+/// Each `struct file` has a position integer, which is protected by the `f_pos_lock` mutex.
+/// However, if the `struct file` is not shared, then the kernel may avoid taking the lock as a
+/// performance optimization.
+///
+/// The condition for avoiding the `f_pos_lock` mutex is different from the condition for using
+/// `fdget`. With `fdget`, you may avoid incrementing the refcount as long as the current fd table
+/// is not shared; it is okay if there are other fd tables that also reference the same `struct
+/// file`. However, `fdget_pos` can only avoid taking the `f_pos_lock` if the entire `struct file`
+/// is not shared, as different processes with an fd to the same `struct file` share the same
+/// position.
+///
+/// To represent files that are not thread safe due to this optimization, the [`LocalFile`] type is
+/// used.
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
+/// * Using the unsafe [`File::from_raw_file`] means that it is up to the caller to ensure that the
+///   `&File` only exists while the reference count is positive.
+///
+/// * You can think of `fdget` as using an fd to look up an `ARef<File>` in the `struct
+///   files_struct` and create an `&File` from it. The "fd cannot be closed" rule is like the Rust
+///   rule "the `ARef<File>` must outlive the `&File`".
+///
+/// # Invariants
+///
+/// * All instances of this type are refcounted using the `f_count` field.
+/// * There must not be any active calls to `fdget_pos` on this file that did not take the
+///   `f_pos_lock` mutex.
+#[repr(transparent)]
+pub struct File {
+    inner: Opaque<bindings::file>,
+}
+
+/// Wraps the kernel's `struct file`. Not thread safe.
+///
+/// This type represents a file that is not known to be safe to transfer across thread boundaries.
+/// To obtain a thread-safe [`File`], use the [`assume_no_fdget_pos`] conversion.
+///
+/// See the documentation for [`File`] for more information.
+///
+/// # Invariants
+///
+/// * All instances of this type are refcounted using the `f_count` field.
+/// * If there is an active call to `fdget_pos` that did not take the `f_pos_lock` mutex, then it
+///   must be on the same thread as this `File`.
+///
+/// [`assume_no_fdget_pos`]: LocalFile::assume_no_fdget_pos
+pub struct LocalFile {
+    inner: Opaque<bindings::file>,
+}
+
+// SAFETY: This file is known to not have any active `fdget_pos` calls that did not take the
+// `f_pos_lock` mutex, so it is safe to transfer it between threads.
+unsafe impl Send for File {}
+
+// SAFETY: This file is known to not have any active `fdget_pos` calls that did not take the
+// `f_pos_lock` mutex, so it is safe to access its methods from several threads in parallel.
+unsafe impl Sync for File {}
+
+impl LocalFile {
+    /// Constructs a new `struct file` wrapper from a file descriptor.
+    ///
+    /// The file descriptor belongs to the current process, and there might be active local calls
+    /// to `fdget_pos` on the same file.
+    ///
+    /// To obtain an `ARef<File>`, use the [`assume_no_fdget_pos`] function to convert.
+    ///
+    /// [`assume_no_fdget_pos`]: LocalFile::assume_no_fdget_pos
+    #[inline]
+    pub fn fget(fd: u32) -> Result<ARef<LocalFile>, BadFdError> {
+        // SAFETY: FFI call, there are no requirements on `fd`.
+        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
+
+        // SAFETY: `bindings::fget` created a refcount, and we pass ownership of it to the `ARef`.
+        //
+        // INVARIANT: This file is in the fd table on this thread, so either all `fdget_pos` calls
+        // are on this thread, or the file is shared, in which case `fdget_pos` calls took the
+        // `f_pos_lock` mutex.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`LocalFile`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The caller must ensure that `ptr` points at a valid file and that the file's refcount is
+    ///   positive for the duration of 'a.
+    /// * The caller must ensure that if there is an active call to `fdget_pos` that did not take
+    ///   the `f_pos_lock` mutex, then that call is on the current thread.
+    #[inline]
+    pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a LocalFile {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of 'a. The cast is okay because `File` is `repr(transparent)`.
+        //
+        // INVARIANT: The caller guarantees that there are no problematic `fdget_pos` calls.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Assume that there are no active `fdget_pos` calls that prevent us from sharing this file.
+    ///
+    /// This makes it safe to transfer this file to other threads. No checks are performed, and
+    /// using it incorrectly may lead to a data race on the file position if the file is shared
+    /// with another thread.
+    ///
+    /// This method is intended to be used together with [`LocalFile::fget`] when the caller knows
+    /// statically that there are no `fdget_pos` calls on the current thread. For example, you
+    /// might use it when calling `fget` from an ioctl, since ioctls usually do not touch the file
+    /// position.
+    ///
+    /// # Safety
+    ///
+    /// There must not be any active `fdget_pos` calls on the current thread.
+    #[inline]
+    pub unsafe fn assume_no_fdget_pos(me: ARef<LocalFile>) -> ARef<File> {
+        // INVARIANT: There are no `fdget_pos` calls on the current thread, and by the type
+        // invariants, if there is a `fdget_pos` call on another thread, then it took the
+        // `f_pos_lock` mutex.
+        //
+        // SAFETY: `LocalFile` and `File` have the same layout.
+        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
+    }
+
+    /// Returns a raw pointer to the inner C struct.
+    #[inline]
+    pub fn as_ptr(&self) -> *mut bindings::file {
+        self.inner.get()
+    }
+
+    /// Returns the flags associated with the file.
+    ///
+    /// The flags are a combination of the constants in [`flags`].
+    #[inline]
+    pub fn flags(&self) -> u32 {
+        // This `read_volatile` is intended to correspond to a READ_ONCE call.
+        //
+        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
+        //
+        // FIXME(read_once): Replace with `read_once` when available on the Rust side.
+        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
+    }
+}
+
+impl File {
+    /// Creates a reference to a [`File`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The caller must ensure that `ptr` points at a valid file and that the file's refcount is
+    ///   positive for the duration of 'a.
+    /// * The caller must ensure that if there are active `fdget_pos` calls on this file, then they
+    ///   took the `f_pos_lock` mutex.
+    #[inline]
+    pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a File {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of 'a. The cast is okay because `File` is `repr(transparent)`.
+        //
+        // INVARIANT: The caller guarantees that there are no problematic `fdget_pos` calls.
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// Make LocalFile methods available on File.
+impl core::ops::Deref for File {
+    type Target = LocalFile;
+    #[inline]
+    fn deref(&self) -> &LocalFile {
+        // SAFETY: The caller provides a `&File`, and since it is a reference, it must point at a
+        // valid file for the desired duration.
+        //
+        // By the type invariants, there are no `fdget_pos` calls that did not take the
+        // `f_pos_lock` mutex.
+        unsafe { LocalFile::from_raw_file(self as *const File as *const bindings::file) }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `LocalFile` is always ref-counted. This implementation
+// makes `ARef<File>` own a normal refcount.
+unsafe impl AlwaysRefCounted for LocalFile {
+    #[inline]
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_file(self.as_ptr()) };
+    }
+
+    #[inline]
+    unsafe fn dec_ref(obj: ptr::NonNull<LocalFile>) {
+        // SAFETY: To call this method, the caller passes us ownership of a normal refcount, so we
+        // may drop it. The cast is okay since `File` has the same representation as `struct file`.
+        unsafe { bindings::fput(obj.cast().as_ptr()) }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `File` is always ref-counted. This implementation
+// makes `ARef<File>` own a normal refcount.
+unsafe impl AlwaysRefCounted for File {
+    #[inline]
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_file(self.as_ptr()) };
+    }
+
+    #[inline]
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
+    #[inline]
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
index 5d310e79485f..c364893e13a2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -29,6 +29,7 @@
 pub mod alloc;
 mod build_assert;
 pub mod error;
+pub mod fs;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index bb115d730ebb..cb3e178b2000 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -366,6 +366,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
             _p: PhantomData,
         }
     }
+
+    /// Convert this [`ARef`] into a raw pointer.
+    ///
+    /// The caller retains ownership of the refcount that this `ARef` used to own.
+    pub fn into_raw(me: Self) -> NonNull<T> {
+        let me = core::mem::ManuallyDrop::new(me);
+        me.ptr
+    }
 }
 
 impl<T: AlwaysRefCounted> Clone for ARef<T> {

-- 
2.45.2.1089.g2a221341d9-goog


