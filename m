Return-Path: <linux-fsdevel+bounces-25436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F9394C271
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A3A1F252FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3D191F62;
	Thu,  8 Aug 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujKVvFNu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F51917D3
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133800; cv=none; b=j7z3d6jsWOc/uF3mjB/FY8J9bbkRvFvKcBLn1smKSUH3FU5A2tDqPmimhjYNfRvmf+4F/iloaNhBuQoEtdSVEcfOjimATGRUkC51TUl1034R35Ysx3syP8R8jDH+4dmzXTCZJvXNs5+JO8l4Q/sQv7Nkv7Czah7C9PtE+E44ONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133800; c=relaxed/simple;
	bh=1vMIdUZrcluEyiRiidfiHirkYBIo8Lix67mHNvOXu6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cENpp+kgzRwjWNwLANn6FaIM6Ho3YHb1KDY2o7WsQSA0bewd+XhHUrrosl9vD0z8/H107AKkd0+EsjUGW7THy1k8JYfD88FV6feRTOz6GXVPQAx2TpyH5Gpra4/1alwdGBndhfAL4a7gQuJszY9fIlGBk0YU5KKyj0xUg3XgSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujKVvFNu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-666010fb35cso18508227b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 09:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723133797; x=1723738597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XPJz0RvqVtGQ0s1/Et3DXHfI74Fp+uTO4G4SSGMpQc=;
        b=ujKVvFNucsFwY/zaiuylMgeJgQmOg9GP7rYSliEnavUQVc9bS3s2/mXebT5si1Gcu+
         3nyFKW1O3P4oyRUiT9T1V4weLzt4jkBDRAjscPlMg4PA5F6Bo+Bz8reeLxYUn1XUrf5A
         32/BtFbqzHa3FQZBtDoTVkG/dM+1M/NxrepVpzPYePn8jS4srqAIPvsepmKsGbLGx6wi
         ojTLAYMEBD5Vt7Zev9qJrxgespSrPqOPZiRmlQkGiAt6Hb4175wm0kOmcF/BHeJ0fEkV
         YZlkKpbuKY/pb+hFrYiavi66yp9MAiJp4eRbRuJtP42lHdsigy2GtWlG81deoN7XOuQ/
         +BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133797; x=1723738597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XPJz0RvqVtGQ0s1/Et3DXHfI74Fp+uTO4G4SSGMpQc=;
        b=XdXcRHy2vv+3JHq8295vjErZ7pDoQfS6hUe5unPPnE6PFSL5I8aC6/r387VZdDtHTO
         uJQiSN6/dXw7AjiWq2o80Yi/b1ELFzyrNB6WtiugOB6XmV1lOREL6jMLlv1YxUgkmfql
         kN833LXNdQadBHTqg7HYKHf616MNpP9R+qH0j1DxDashkuq+YmdKGnWwfTPba+wiTEwC
         xSgDRns2B4k59sWMDqLKi+3uhfPKBnXw/FJX2Y0Suo+aJ0xSaYxosCMaVOLHcpyu3ZqQ
         ZfSfXNalAsfE2QcObRVb5o0utfmZzEtjatg+xhNTvPM0jmnj3G1k3X/eY2I8bzoiuqZ0
         O0Og==
X-Forwarded-Encrypted: i=1; AJvYcCWtd0/mgwkoNH1wXNRDT7kusclwMHlEY+Qx97hkx3Lbdf6Y/essP8EeISTnf448wBZs18N2ZsR/Bo8KPhVhf7DR8+5yNOiTOoldfjjsKA==
X-Gm-Message-State: AOJu0YxWytY4AbSXdFVJNTRuHOfXOWuJwLi17SIbHWDxH5ylTeduS/wU
	MX12goq5gAVIxwOk8m0G93nvBBsuabg+P7ZxL11Sdu+0dKx/IMLLtNsk3c0n9bUIkItHFAP8p4D
	tPExXJqoScbIakQ==
X-Google-Smtp-Source: AGHT+IHUz767KQcpBOtZNxtFKAoUTa/PamO0iQ+5xE9bAJ6TM11xSajERyKwyV0jx6oCLFQ7vn/8N3bCocaDsa0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a0d:ff44:0:b0:68e:edf4:7b42 with SMTP id
 00721157ae682-69c0e17e20bmr1269207b3.2.1723133796674; Thu, 08 Aug 2024
 09:16:36 -0700 (PDT)
Date: Thu, 08 Aug 2024 16:15:46 +0000
In-Reply-To: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=22225; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XP+THKic0jAdNWiD3Ihji1EQOowajiTB27FHNKM103w=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtO9WCz89/Vj3rRho3KbMtMZ7mKxWeA2S5aCdT
 VmTbGSXKBmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrTvVgAKCRAEWL7uWMY5
 Rh0SEAC1saEvVdZ1ckQD233dl/rjwXS1JeXFjuqGV/QxtxHc2WOxMEAEPuygVEducrgWbcA7J1z
 fLCHftEcAPJpYPeOaTTl9mLAO5Z7z7QNgxYkGSI1ielfZdZyfPr3XFjrO89DFe+0yGwHqSVk2eJ
 Q314fLCcNEtV2IahDcVpKWX6SvhXu9s/w2TgcSGrZiHvygC3vBPKigy+DXqVi6WkAT0SWHgsDsp
 eMSLzqqKaG8hn6wueXaCO0MWg8KRGgL1Y9wkEd5MmJu3s6F1h/1GS9ktld2y74mSWYWvn4A7TPv
 jfnI63MnBrg15cBByPdZUesQfM2b6AekS2+KspIjTAr7/tm8glVJP1ik0rbhwDf03/CRh9DO34+
 tos0EyRf7wbK398a5Xqqh/++RhBidKi+6L+2wuz4PWafdDvaBdge4dBdhsjSVcUef0RZ4MuEeU8
 eEi2N+LeORhbr8PtEmeNnhiUMY75aR+9FuF/Zzg83CaIpVe6haaaCaXmvr+sLmCvaXJ97fjRzVF
 GDIUkfo65BHaVJ/B1tGv5RrEPclpAU2RGMCFUbioKLqQ3mJNMmvCqMAV971NEJ5NazsfYcET9qh
 HZMu2pocg5jonMqdwV6BU64qvqayAo7Emw5hnXW7CRzxzZG9JA32yErM2Y2isGxk9gDYvkDDRba 7/ejfoU6Zy5hobg==
X-Mailer: b4 0.13.0
Message-ID: <20240808-alice-file-v9-3-2cb7b934e0e1@google.com>
Subject: [PATCH v9 3/8] rust: file: add Rust abstraction for `struct file`
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
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
index a11e59b5d602..53df370c4fd4 100644
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
index b940a5777330..550a4a46d413 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,7 +12,9 @@
 #include <linux/blkdev.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
+#include <linux/file.h>
 #include <linux/firmware.h>
+#include <linux/fs.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 92d3c03ae1bd..80021b0a7c63 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/mutex.h>
@@ -200,6 +201,12 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
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
index 000000000000..6adb7a7199ec
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
+// SAFETY: This file is known to not have any active `fdget_pos` calls that did not take the
+// `f_pos_lock` mutex, so it is safe to transfer it between threads.
+unsafe impl Send for File {}
+
+// SAFETY: This file is known to not have any active `fdget_pos` calls that did not take the
+// `f_pos_lock` mutex, so it is safe to access its methods from several threads in parallel.
+unsafe impl Sync for File {}
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
+///   must be on the same thread as this file.
+///
+/// [`assume_no_fdget_pos`]: LocalFile::assume_no_fdget_pos
+pub struct LocalFile {
+    inner: Opaque<bindings::file>,
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
index 274bdc1b0a82..61e0dd4ded78 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,7 @@
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
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
2.46.0.rc2.264.g509ed76dc8-goog


