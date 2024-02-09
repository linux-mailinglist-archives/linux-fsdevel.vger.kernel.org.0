Return-Path: <linux-fsdevel+bounces-10924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E584F474
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1918A1C26690
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B213716A;
	Fri,  9 Feb 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKB5JHZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BD364C4
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477540; cv=none; b=DXYbPn9p2MJpAhtqfPJX2J3ygh4VcjVGfeyMz1czY+oZoQQvhmlbc9OqMWrOBpAxmZ/QxCBDdShSgfyifctdU7QiJwgdheaTFs3vTREaRL1Ur4MwjsF6rZFHxZKzH/uJ+L0ByK2hgL7zVQlYDgM8+mNnFGU0+wjeka+MtnuG8kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477540; c=relaxed/simple;
	bh=dVRJj3K1ZTxebz+jNk/ThYfsSj9RYrM0JXdUw2RpoVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=erSdymbL2U/RkmDoOhLGEeoC/UjeUD9NQme+PFZLtr2tz3J9xN69VjYM1GDUl7YQoroC4A4nDe5+h1q7Lk4JpTblmhk4cm7Zf6GNCrDG+A8qKcxfmUyZOPQNeTIaUoHjJC/eDyaiEgToV0033+pX5vC+8I/FGZZzN/3XCDCRUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKB5JHZl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604a1a44b56so13301587b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 03:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707477537; x=1708082337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxjKxa4m271sIt16a08H0uYuoD5D/IuZgZfG/a5xnr8=;
        b=DKB5JHZlZpBHu6o7/E3rWl2MRq/HuSyK2LZ2CW0D1w4Ezr005anXZM7IHYgIdpq44z
         0Ahk6Kq42nOyZ5vTJsgMZiU6nDp8BdS3EP8sZ0VErxS73J34aloof5BIFaizLzc1Jk/0
         tb1I97Fy4GjSqrUSDuid3UpGDP/GU91dF54DJUiLkbRE9+MMWkzSWiyUmKdX3WpDBY/Y
         7MWdmA53e907BDQbbYh1rhucj5Z7YkMNx/Dw2n0AsD9otJcyrO0Q1Apimsb+AD1YCgxD
         2wIosJCpxN/FjX2ViTTHeVof3bxGP+Jwf3ZDnNJ9OInDbCf3+k4S8OcEXhBDpTkK85ee
         ESYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707477537; x=1708082337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxjKxa4m271sIt16a08H0uYuoD5D/IuZgZfG/a5xnr8=;
        b=VYTUr8w6FaSWeiiNgVbNNwpKe5goqBn8fttQfPDxeIYiucRfsuaHnIo75EscqEV5t/
         6MWIBQmpHDaL7XwyM5/CjqJemTfAmT+vq5mnc/T0T8eUQFGQz038coNeKGuIYIrC43+v
         NzaLWnDyXKuc7XpdgKt4249sTvHewUXF+JFlWazfZEgmm1SOOv0IQlqo+Lk5tLbov/5B
         4KItMIn4jqqI9nm9LL3hVIhrD74XpEHz3Km/aK8CmUT8nuNA45z1EjMPjPJs/D7Eb+HG
         uJa39GSL6mTIhbHJ3Tp0UscFYWW9muc9njs5dLpmkp+34U0JA66CWrs77iNq+XbtdRpl
         P6fw==
X-Gm-Message-State: AOJu0Yx2sCdXrw6KRQvTlhiKerWSfyl+RCTEVoOEAqid+CP2Mox9wyFy
	7rr8UmeHQu/xWRedJ7++wT+HpKfJ7++hrOurIKAGA2ptAOMNkcJ+XIRsXfK3y5hj0/q6E5l28KP
	hyHwKaqWSw5gzxA==
X-Google-Smtp-Source: AGHT+IET7K9NQUlrpK1m7VYI2cS4gFJchciIy51LQTKf6kIxdIg6MVQrQhQh8l3OZqZxzjx+Dcw3o8iEPiQDhTc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:a00e:0:b0:602:d83f:bf36 with SMTP id
 x14-20020a81a00e000000b00602d83fbf36mr189436ywg.0.1707477537373; Fri, 09 Feb
 2024 03:18:57 -0800 (PST)
Date: Fri, 09 Feb 2024 11:18:16 +0000
In-Reply-To: <20240209-alice-file-v5-0-a37886783025@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15736; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=JueeAQ6jOG9u9/V4D1G7VhZ7At8WH2fyAHSp9eM4+Uc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxgoRhXhv59BmRspUw4G/kHb3dIZIzl3NYoaWs
 Kgydf6oOWiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcYKEQAKCRAEWL7uWMY5
 RpYBD/sGgzY+zdM3PKTstyQSOADI9/3FYUFjOIYto9VjsuVzrQ+UmRDT0XUv2zLtwenJ8gR0eBa
 88OQ9cHfo9o1rYgovE0z8KXEl0j7b6+jYTRq+uXdRbnLNqUK10rBPn2LYYSFp5f15/ZKaMYnx1z
 rtFWEafDaBuSxLXLJ3au+EMm9crCUA/MG+v4MYjQt39jh2f0nXUYhYnMNFctN8GkOn0j2nakA0h
 6k5hjvw43DGU6EgKncEQWygJAvziTz5t4ln+YRbwYdLtReMofrBS9N4aXIbHh665tvguH8hmjmc
 Mf1eidr+Ji+IC5ccSsKTimX9zxAgtAZ5ZB9yWunhXlOAsuhDVn4LXMGortbqkffV/JqwL3Zd4lN
 b4HAk85lbdgP8a8XZzo5gMMsmFnP18e0hKxEUOfhmVMcY6pfDCsS9lt01c7gqyOGBOeuHco4znI
 hzesDBQ5xaYjNYDtqxbJVkh8832v0vpDRCYfDJEO/mywfLl9HHv3kvVr2skFbemQ60KPywdidp3
 UfL7pFGOJQc/DogxQTyTxaj5YN8O5+f/dj9YKoDaLNUlK0hDxiTbT9t/2pXVNHuFjG2WczxF42z
 QBakwK54cN0GkyDK2gncNFCFIwdwn46llGGoYtF9Ayf0fNKIF5ahygLl61dUmnbS3fvohWTQvhq Wez1M+zI67JtqrA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240209-alice-file-v5-3-a37886783025@google.com>
Subject: [PATCH v5 3/9] rust: file: add Rust abstraction for `struct file`
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
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>
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
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 fs/file.c                       |   7 ++
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |   7 ++
 rust/kernel/file.rs             | 254 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 5 files changed, 271 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 3b683b9101d8..f2eab5fcb87f 100644
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
index 000000000000..cf8ebf619379
--- /dev/null
+++ b/rust/kernel/file.rs
@@ -0,0 +1,254 @@
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
+/// Wraps the kernel's `struct file`.
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
+// - It is okay to send ownership of `struct file` across thread boundaries.
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
+        // FIXME(read_once): Replace with `read_once` when available on the Rust side.
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
2.43.0.687.g38aa6559b0-goog


