Return-Path: <linux-fsdevel+bounces-22786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9D91C1E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139621C21D79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B417D1BE25D;
	Fri, 28 Jun 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoNt/gRu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9771C68B7
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586679; cv=none; b=F5W/kFDKMjgML7GGI/rnUqStssUWt/nkPHycQA9zhdcaAWpkNKEkAVpSD1l1Wp1WdGLerxNxynKZwKHNh2pqMnZDqbdgV5ioHrXZlwT5s2PqcVwlQqm0MNn0IaeIbIACj2rQac3Wl8D6Urixa5b2Y2Nu3BAf/MqM1O+4+XDty1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586679; c=relaxed/simple;
	bh=LFVEzErzqQ1q40e9Ik4zdJmABvLJ02IJ5xrzhdx+PXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UrGOgZg1jt3Awm/qMuVU41aatNS0QSrAPZskV4HwrQehsLZAo/UrX1Q8gHJk6GXQkuqs5q3zYpUecYyuSpKdQYNiaivq79JrWRLDkR0YPihRddFZI3yXx5mpU96/V6rYNVIhqH06yFg3S8n01v20t6ygPvPccVxK5hYOmFeZnL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XoNt/gRu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e036440617fso566346276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719586675; x=1720191475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5+zgWJ9B94kDR/O8VwZ3ua2XMRwjFAGUwG5glPRAqU=;
        b=XoNt/gRu5zggLPr72MWG/eJZafR2eL0lEitaJKAs4w8gs7fQi1I5aggJBXfoB7mHar
         +QqQd/Un1pk9CRQ88zoqOyzW49nHskrEa/laLgFSbaneIT82EovDMe9IWKlOYs2B9JU4
         VUQtvwXiKc2o26NzFNO3aVjS8wVkhHojdyX03C17l/8ZJfX0smuJhbAHwfGqsxRK2BZd
         KYkQsWlsOZnw+S2PuXWwRauRSyEtNROsaovx9dsdj1TYELehrvJny1TDALnD/mrV+0jJ
         uMvjpL3ffCYYwVkEGvzS+NIgX76yxRDVzH680IaUz8RpXVgqgk7AL3szSYNE8F+4IGPs
         70Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586675; x=1720191475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5+zgWJ9B94kDR/O8VwZ3ua2XMRwjFAGUwG5glPRAqU=;
        b=iFjnnnfvSLUbNKsAEBgwogdZFbjCj8QGXfSkQDXx+/fY83WD3Vx2pZRM/ou8UhYEfK
         6hR5RYvA2BJoCJbDfxg8rWTb1TnVA2zxANS5LN3R8roJkLNRF74eTwlnBLFqJrkffiPX
         oRud51FlrOCXSun3zAiR8y2KqfMfkVhsYVJkneKgJCEqfy7zNsaJZyzbr/0accVBgPKN
         wGufya9WRVNaP9dIu7FaGdS2Y/kqHfwAcQxPMoFuOscxET1uzPKr0Xpxp1Z8gRMWwShN
         lWAWVpqp9PAggZJNeaVSxteYf4ELMJ7/JIerM96BrgudCkotM5L1/5loLEbVbzhATwpr
         Y5dw==
X-Forwarded-Encrypted: i=1; AJvYcCVbpotqToskGPso9woghRp0cFLlLKpoDuNAGjfbULpiyKBcJXwado+asrzwXmfO7vuGF+35CC2FCJXBKV0O59bYMvfgVmP9hylZ0HRGAw==
X-Gm-Message-State: AOJu0YwjzbtWYNiolKR9zoCRmbrJ8yyx5BIAQoSuCxUvtNHAGOcwFxpE
	NPvcZ1UlwDMXehhqTwlDiwVXmBVCe09DsANiwmDxJ2Ov6K63qZA8/HlMD33IvgK+PV/HO5zutRo
	wyye3L+zqx4f8/w==
X-Google-Smtp-Source: AGHT+IH1yUNkQMUavc8OS4Suuin/C8L91b71mgvTXxxkot66jc1d+CDf41sOEX3DF25EiLyonnSEPm0pUFKtKIw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1006:b0:e03:4bf0:b21e with SMTP
 id 3f1490d57ef6-e034bf0b50dmr362286276.1.1719586675354; Fri, 28 Jun 2024
 07:57:55 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:57:16 +0000
In-Reply-To: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=21643; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qVdBsDPrZIaWOXv+yX141pHKcTehsDvHW/vXiDQpPCk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfs9jW/FGnqCyVhc5lt/drZnDsdkwt8RDfX4x+
 C8pG/kPzXmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn7PYwAKCRAEWL7uWMY5
 RpWHD/4wI1b0drlSPe+yNJkP778UgiWe/8xPfoF8vWCtARJfwaICJi8m0hDx8wF5Dr4Rg+5QJkW
 E1QnmgJTsJKrargq577BfJgaGjsclKysPr6sM/SMlqbbMyacFsn5aIcSUWksctNoYnBqAzQAbqf
 S9UYTJqaAXbrjRjE9P85y95XDS+ysuph42H5eYiMebonpMJwUrfN97/twVIAU9wiXu6N1rbpwFn
 o1GYYVZUnCqKChlfoRwVr88ryYXdpBRjkV4A1WbRUIj9BSHfOHazPd4Vfeb1bPihR7oSWTVC/md
 6dwJj7Rttw33GLKcDTgYDwUpyjQstYY0Naw88ER1sNX4bqU/j1TyAaeLj9nE4MMIeKSLJmElgOg
 9YkWvlVqGoj7BQElVMeoJzYMGuAyKRixAR2V1g2VZiU8sF21lYXBhD8BoSplLyOt1HZOjlLWoHh
 UbT9ez6CoN4sEpuiG/tPYhU5Ri/AsLHUepEOJC6XLqGpPeBGA9+8scAAtoKLno+AzabRTxgSuPb
 oa/QE+WHFO1IbEvd2fB/5f1mmOjR1P0+8puf1OxLAckvscyLL29QmESxl2povTkvxwlRPxGxHBV
 AS+2NOTIH2QLK1PlTaOF0CbcLyFB2sskjB1kkYfmH4+UVt6aY2xJNaCPu7dVxo99VGGni3i6CRZ l+ItElUCzmbBjrg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-alice-file-v7-3-4d701f6335f3@google.com>
Subject: [PATCH v7 3/8] rust: file: add Rust abstraction for `struct file`
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
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
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
 rust/kernel/file.rs             | 373 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/types.rs            |   8 +
 6 files changed, 398 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 8076aef9c210..18840b5bf524 100644
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
index ddb5644d4fd9..541afef7ddc4 100644
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
index 2c37a0f5d7a8..e68025b53342 100644
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
@@ -165,6 +166,12 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
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
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
new file mode 100644
index 000000000000..08551bf5c625
--- /dev/null
+++ b/rust/kernel/file.rs
@@ -0,0 +1,373 @@
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
+/// * Using the unsafe [`File::from_ptr`] means that it is up to the caller to ensure that the
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
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a LocalFile {
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
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
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
+        unsafe { LocalFile::from_ptr(self as *const File as *const bindings::file) }
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
index fbd91a48ff8b..dba3415c1cee 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -29,6 +29,7 @@
 pub mod alloc;
 mod build_assert;
 pub mod error;
+pub mod file;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 93734677cfe7..3ec2b12afbee 100644
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
2.45.2.803.g4e1b14247a-goog


