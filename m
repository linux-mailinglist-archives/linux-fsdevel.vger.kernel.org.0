Return-Path: <linux-fsdevel+bounces-4196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628F47FD990
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D70D28265D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C739432189
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYuOv5Zj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D43C10D0
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 05:12:38 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf86963ecso99698827b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 05:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701263557; x=1701868357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXjNNXUM6pnjCl+pZVw51JBLkEWhDl2ninKP9/3jCWk=;
        b=oYuOv5ZjXM2gp+/9ZyBoFqjtsRiuviJsdaBfN9uJXwB4StI7ZGoTrDcMDOn2xOgSgh
         HNsH4oc9LS0WsSXKknQhklnYgz2UZ88tdyOkfFScREW6TzUERdcrpcbFf3cV8ZY3HXhf
         7CXUw2pahhGExQF6Hbt/m1Eq7O1F51bK/nv8H/0gxCyx3f/1kH2XHHxYvTpM0qQIRrF1
         SZGGd4wr3n5yO7uNGPObDqo6xYZZ+qdgN147MQ+yk6XdVbbkUIxcpRxTTxvq/w5eI1Te
         wADhTTSIVRetrumwd2sczVTGMcyUyfUYw9caaTi3bEDAu6Zwu7NGZlZW0yNJHTimGC95
         ixEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263557; x=1701868357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXjNNXUM6pnjCl+pZVw51JBLkEWhDl2ninKP9/3jCWk=;
        b=VB07qLMWpHEuk1hOwZblBJivsFqeFtB6vSGOHxAA7sVeSy9qTI2jJQi1PkF2zHeF71
         aiCM14StVRtJYlrrMR8ePjgWSEIT7mldAYjcpnqzgd+VGrOEpNEJJv56U1hLKpQEAbGg
         BvZ4joqJRLk3T5xbP7fgWW0NLHb8aIs8jpPEReduZ6jk+4mqtiqgd1dBbZXQ/3OlCebw
         HMcqv1sWev5HubGezkyC9yOICcqrfVpNYZOQNnV+3QCBjTT6M1gKZG5jX3MGkMMvWMZ7
         sTUb02dbKULkbnly4a7U9PHh+/ZaP4ujdQVfqWSzNTP+Of5YBy9IJiABxj4PmcmZnwoS
         e+Vg==
X-Gm-Message-State: AOJu0YxN5wjN65oQU5YN1FISv96mZgMlD4GMUa7NGm5fJmlXIFHgk4V4
	zc+LhgkjUPO8+AicXjYcNzkfFQWWvCjiD6s=
X-Google-Smtp-Source: AGHT+IGZ/DrVd6szNZuraGj6OJEwLI9AdSB0/YtOT+pXPvBEUA8z9WVNI5YOCH1nSunvGf16rHqPlCJprjA2dyY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:4283:b0:5ca:8688:a088 with SMTP
 id gj3-20020a05690c428300b005ca8688a088mr458584ywb.9.1701263557556; Wed, 29
 Nov 2023 05:12:37 -0800 (PST)
Date: Wed, 29 Nov 2023 13:12:32 +0000
In-Reply-To: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7762; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wm4v/CZhyQkEj/WgGp9wB8kmjgTXL9eNiFeuaaFW8cA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlZzMyIu8t9+uRKkvsDVwPd7WtQJgdkH8MOJ0Kt
 /e6KpAU/aCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZWczMgAKCRAEWL7uWMY5
 Ro5vD/wLbe54Jjz/IxjFEJCY0ktIiNyNy2iSlK3mOLv/fhrdrJHbYqss5c6VmUWo2BVovvV9ZOi
 02pYVCtMyM87CZg41oeeU13aB+Loz49/Ht3Adb9Vdj2vKcStC27h+CI+2V6bqPgle81kalHY2X8
 qpxHvRaaweKd1sJ59O0fOo+UOvG+fOFnA3WaVNgsRAPgNChRKMsIkj/3GlHauCNLDmghNkJv/ho
 qjHocDdWkJc9tVY8c0/w3EYPBafgwJiyE4kkPqRlpe3m5jFh3k3lnxZwtERUU/OE79r4y9hdPaG
 b5PbLvscC5kvAkB3v4oLZnZOV9OrZ3Y1oKkJHWDaJ1XLe+JyD49E3SlH1yhSufvbK+GdG4aXrva
 SeWHVm5sC08bY0Cb8AsI65fKo9uepAkESCSnjI5y3LpUR3Jd9ENQ/h3O7bcCcnZZwfNX73E4q9G
 jUmnwetQEx78xh+PgST7eZv6RFEQazDEgYsrJrrgnPpXsquMvW8vNR+jPyXUoSh7c3V7dZ3JaQ3
 Zd4wHG/Ic7Urzz6+C4BSwvNL4myhbdDOLqxqHigs/4CZQJiUMSA+6T+inDgXrjtdI3RVEGKEgEt
 R03VOXCt0B2c3mep5G0kHp4eOwVGUp/6jbU/428pk2pK/crQwzg8fmf6dZbIkEcAtRq2lL455N6 KOu7FHxEUjoKpcQ==
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129-alice-file-v1-6-f81afe8c7261@google.com>
Subject: [PATCH 6/7] rust: file: add `DeferredFdCloser`
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
Cc: Alice Ryhl <aliceryhl@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

To close an fd from kernel space, we could call `ksys_close`. However,
if we do this to an fd that is held using `fdget`, then we may trigger a
use-after-free. Introduce a helper that can be used to close an fd even
if the fd is currently held with `fdget`. This is done by grabbing an
extra refcount to the file and dropping it in a task work once we return
to userspace.

This is necessary for Rust Binder because otherwise the user might try
to have Binder close its fd for /dev/binder, which would cause problems
as this happens inside an ioctl on /dev/binder, and ioctls hold the fd
using `fdget`.

Additional motivation can be found in commit 80cd795630d6 ("binder: fix
use-after-free due to ksys_close() during fdget()") and in the comments
on `binder_do_fd_close`.

If there is some way to detect whether an fd is currently held with
`fdget`, then this could be optimized to skip the allocation and task
work when this is not the case. Another possible optimization would be
to combine several fds into a single task work, since this is used with
fd arrays that might hold several fds.

That said, it might not be necessary to optimize it, because Rust Binder
has two ways to send fds: BINDER_TYPE_FD and BINDER_TYPE_FDA. With
BINDER_TYPE_FD, it is userspace's responsibility to close the fd, so
this mechanism is used only by BINDER_TYPE_FDA, but fd arrays are used
rarely these days.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  2 +
 rust/helpers.c                  |  8 ++++
 rust/kernel/file.rs             | 84 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 700f01840188..c8daee341df6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -9,6 +9,7 @@
 #include <kunit/test.h>
 #include <linux/cred.h>
 #include <linux/errname.h>
+#include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/pid_namespace.h>
@@ -17,6 +18,7 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/task_work.h>
 #include <linux/workqueue.h>
 
 /* `bindgen` gets confused at certain things. */
diff --git a/rust/helpers.c b/rust/helpers.c
index 58e3a9dff349..d146bbf25aec 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -32,6 +32,7 @@
 #include <linux/sched/signal.h>
 #include <linux/security.h>
 #include <linux/spinlock.h>
+#include <linux/task_work.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
@@ -243,6 +244,13 @@ void rust_helper_security_release_secctx(char *secdata, u32 seclen)
 EXPORT_SYMBOL_GPL(rust_helper_security_release_secctx);
 #endif
 
+void rust_helper_init_task_work(struct callback_head *twork,
+				task_work_func_t func)
+{
+	init_task_work(twork, func);
+}
+EXPORT_SYMBOL_GPL(rust_helper_init_task_work);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 2186a6ea3f2f..578ee307093f 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -11,7 +11,8 @@
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::{marker::PhantomData, ptr};
+use alloc::boxed::Box;
+use core::{alloc::AllocError, marker::PhantomData, mem, ptr};
 
 /// Flags associated with a [`File`].
 pub mod flags {
@@ -242,6 +243,87 @@ fn drop(&mut self) {
     }
 }
 
+/// Helper used for closing file descriptors in a way that is safe even if the file is currently
+/// held using `fdget`.
+///
+/// Additional motivation can be found in commit 80cd795630d6 ("binder: fix use-after-free due to
+/// ksys_close() during fdget()") and in the comments on `binder_do_fd_close`.
+pub struct DeferredFdCloser {
+    inner: Box<DeferredFdCloserInner>,
+}
+
+/// SAFETY: This just holds an allocation with no real content, so there's no safety issue with
+/// moving it across threads.
+unsafe impl Send for DeferredFdCloser {}
+unsafe impl Sync for DeferredFdCloser {}
+
+#[repr(C)]
+struct DeferredFdCloserInner {
+    twork: mem::MaybeUninit<bindings::callback_head>,
+    file: *mut bindings::file,
+}
+
+impl DeferredFdCloser {
+    /// Create a new [`DeferredFdCloser`].
+    pub fn new() -> Result<Self, AllocError> {
+        Ok(Self {
+            inner: Box::try_new(DeferredFdCloserInner {
+                twork: mem::MaybeUninit::uninit(),
+                file: core::ptr::null_mut(),
+            })?,
+        })
+    }
+
+    /// Schedule a task work that closes the file descriptor when this task returns to userspace.
+    pub fn close_fd(mut self, fd: u32) {
+        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
+
+        let file = unsafe { bindings::close_fd_get_file(fd) };
+        if file.is_null() {
+            // Nothing further to do. The allocation is freed by the destructor of `self.inner`.
+            return;
+        }
+
+        self.inner.file = file;
+
+        // SAFETY: Since `DeferredFdCloserInner` is `#[repr(C)]`, casting the pointers gives a
+        // pointer to the `twork` field.
+        let inner = Box::into_raw(self.inner) as *mut bindings::callback_head;
+
+        // SAFETY: Getting a pointer to current is always safe.
+        let current = unsafe { bindings::get_current() };
+        // SAFETY: The `file` pointer points at a valid file.
+        unsafe { bindings::get_file(file) };
+        // SAFETY: Due to the above `get_file`, even if the current task holds an `fdget` to
+        // this file right now, the refcount will not drop to zero until after it is released
+        // with `fdput`. This is because when using `fdget`, you must always use `fdput` before
+        // returning to userspace, and our task work runs after any `fdget` users have returned
+        // to userspace.
+        //
+        // Note: fl_owner_t is currently a void pointer.
+        unsafe { bindings::filp_close(file, (*current).files as bindings::fl_owner_t) };
+        // SAFETY: The `inner` pointer is compatible with the `do_close_fd` method.
+        unsafe { bindings::init_task_work(inner, Some(Self::do_close_fd)) };
+        // SAFETY: The `inner` pointer points at a valid and fully initialized task work that is
+        // ready to be scheduled.
+        unsafe { bindings::task_work_add(current, inner, TWA_RESUME) };
+    }
+
+    // SAFETY: This function is an implementation detail of `close_fd`, so its safety comments
+    // should be read in extension of that method.
+    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head) {
+        // SAFETY: In `close_fd` we use this method together with a pointer that originates from a
+        // `Box<DeferredFdCloserInner>`, and we have just been given ownership of that allocation.
+        let inner = unsafe { Box::from_raw(inner as *mut DeferredFdCloserInner) };
+        // SAFETY: This drops a refcount we acquired in `close_fd`. Since this callback runs in a
+        // task work after we return to userspace, it is guaranteed that the current thread doesn't
+        // hold this file with `fdget`, as `fdget` must be released before returning to userspace.
+        unsafe { bindings::fput(inner.file) };
+        // Free the allocation.
+        drop(inner);
+    }
+}
+
 /// Represents the `EBADF` error code.
 ///
 /// Used for methods that can only fail with `EBADF`.

-- 
2.43.0.rc1.413.gea7ed67945-goog


