Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC675B28E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjGTP3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGTP27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:28:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE3C26BB
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 08:28:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-579dd7e77f5so8802477b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689866924; x=1690471724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGsQzpftUqu/kmuJWlaGnOlUm9YEsSfvHqOENO4D8dg=;
        b=HP4VC4yqfpbodAzQdaIPQ4nHY72QwI4xzaASWFSHnM+kJ/oVIJABmevzS7L4fyYt6u
         uod2tSIWVsovjnMAekiIbWj5Z08qROuyF2g0iu38AQHdWLp9uc/DhQPw2D1NORvQj8rV
         uva0LfWOLN7B+LKRWA9IWsmwQn8i3ANXZTuq8sB2F2XUzy3s5QLK0dgKqtQUdemy1mOg
         aYhL5pHQM2Ass9pi9bb1Y6ghGFIr1a/fzbGO3QUOVVsPHCkKnNHGrrFyZ/1q8z8TitC2
         WKQTAvs1luUmaoKYOZcHjv3dRyMXEE1AlN1K4jMm4difaM43OPe7/ud3XATXsI+YplQg
         ffNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866924; x=1690471724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGsQzpftUqu/kmuJWlaGnOlUm9YEsSfvHqOENO4D8dg=;
        b=KkJkjYxF/qhF4A2fu3e676K3bXxlpk9FA15q/mJD9IsyRmdOdeeVWrBNYJANiih8ZX
         ldzIZ+XXaxNtu0wA2lxEZj2y7A3PnO07hTFuRO3pTwm5reBT8IOXjb/H3RpsrIE5nN0U
         pnhhOeXF70ZzM1M86XMpFpYJQHLpdChz3WOIEckGD2RG9FWLJZEieIQLCITg/FPgzmRd
         11ESOAs6MxF0rWdXRp38cglF5jJsyJ2wdn7+B0Yg5oWL+Fk55Iyooaz1fnJT/HZfDbiU
         f/vczyiMqGwezAtRE98+hZSa9uTCMQG5dlD1HH64b/AOSluy63MglgjmsXMfLrNtVyg2
         fDJQ==
X-Gm-Message-State: ABy/qLYygI7T8+kprR+8ME6Duu3BsPA4McPMPM14Nh20ZnnmiIylbFeI
        EDDo/2RI6m1Qc4NrU3n39o1hxGFzIYmNRB8=
X-Google-Smtp-Source: APBJJlHO5O4cMxl3yvu0ac9SIsB/5yliMvkbEyAyJIsejZiEICgCkS5rSMuIcjDr5ooI5wJaXW6Biubwv7IbGS4=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:ab0e:0:b0:cc5:c7d6:ae13 with SMTP id
 u14-20020a25ab0e000000b00cc5c7d6ae13mr45030ybi.5.1689866923961; Thu, 20 Jul
 2023 08:28:43 -0700 (PDT)
Date:   Thu, 20 Jul 2023 15:28:16 +0000
In-Reply-To: <20230720152820.3566078-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230720152820.3566078-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720152820.3566078-2-aliceryhl@google.com>
Subject: [RFC PATCH v1 1/5] rust: file: add bindings for `struct file`
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

Using these bindings it becomes possible to access files from drivers
written in Rust. This patch only adds support for accessing the flags,
and for managing the refcount of the file.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Co-Developed-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Co-Developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
In this patch, I am defining an error type called `BadFdError`. I'd like
your thoughts on doing it this way vs just using the normal `Error`
type.

Pros:
 * The type system makes it clear that the function can only fail with
   EBADF, and that no other errors are possible.
 * Since the compiler knows that `ARef<Self>` cannot be null and that
   `BadFdError` has only one possible value, the return type of
   `File::from_fd` is represented as a pointer with null being an error.

Cons:
 * Defining additional error types involves boilerplate.
 * The return type becomes a tagged union, making it larger than a
   pointer.
 * The question mark operator will only utilize the `From` trait once,
   which prevents you from using the question mark operator on
   `BadFdError` in methods that return some third error type that the
   kernel `Error` is convertible into.

 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |   7 ++
 rust/kernel/file.rs             | 176 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 4 files changed, 186 insertions(+)
 create mode 100644 rust/kernel/file.rs

diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
new file mode 100644
index 000000000000..99657adf2472
--- /dev/null
+++ b/rust/kernel/file.rs
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Files and file descriptors.
+//!
+//! C headers: [`include/linux/fs.h`](../../../../include/linux/fs.h) and
+//! [`include/linux/file.h`](../../../../include/linux/file.h)
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
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_file` ensures that the
+/// allocation remains valid at least until the matching call to `fput`.
+#[repr(transparent)]
+pub struct File(Opaque<bindings::file>);
+
+// SAFETY: By design, the only way to access a `File` is via an immutable reference or an `ARef`.
+// This means that the only situation in which a `File` can be accessed mutably is when the
+// refcount drops to zero and the destructor runs. It is safe for that to happen on any thread, so
+// it is ok for this type to be `Send`.
+unsafe impl Send for File {}
+
+// SAFETY: It's OK to access `File` through shared references from other threads because we're
+// either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for File {}
+
+impl File {
+    /// Constructs a new `struct file` wrapper from a file descriptor.
+    ///
+    /// The file descriptor belongs to the current process.
+    pub fn from_fd(fd: u32) -> Result<ARef<Self>, BadFdError> {
+        // SAFETY: FFI call, there are no requirements on `fd`.
+        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
+
+        // SAFETY: `fget` increments the refcount before returning.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`File`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` points at a valid file and that its refcount does not
+    /// reach zero until after the end of the lifetime 'a.
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `File` type being transparent makes the cast ok.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the flags associated with the file.
+    ///
+    /// The flags are a combination of the constants in [`flags`].
+    pub fn flags(&self) -> u32 {
+        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
+        //
+        // This uses a volatile read because C code may be modifying this field in parallel using
+        // non-atomic unsynchronized writes. This corresponds to how the C macro READ_ONCE is
+        // implemented.
+        unsafe { core::ptr::addr_of!((*self.0.get()).f_flags).read_volatile() }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `File` is always ref-counted.
+unsafe impl AlwaysRefCounted for File {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_file(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::fput(obj.cast().as_ptr()) }
+    }
+}
+
+/// Represents the EBADF error code.
+///
+/// Used for methods that can only fail with EBADF.
+pub struct BadFdError;
+
+impl From<BadFdError> for Error {
+    fn from(_: BadFdError) -> Error {
+        EBADF
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 85b261209977..650bfffc1e6f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -32,6 +32,7 @@
 mod allocator;
 mod build_assert;
 pub mod error;
+pub mod file;
 pub mod init;
 pub mod ioctl;
 pub mod prelude;
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3e601ce2548d..c5b2cfd02bac 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,8 @@
  */
 
 #include <linux/errname.h>
+#include <linux/file.h>
+#include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index f946f2ea640a..072f7ef80ea5 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -24,6 +24,7 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
@@ -137,6 +138,12 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+struct file *rust_helper_get_file(struct file *f)
+{
+	return get_file(f);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_file);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
-- 
2.41.0.255.g8b1d071c50-goog

