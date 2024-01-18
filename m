Return-Path: <linux-fsdevel+bounces-8257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5B3831B95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973A71F23BB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9AE2D601;
	Thu, 18 Jan 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8vIBX4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC902D044
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588637; cv=none; b=dd5cI4x6ANZyuZDGsJWOSDsr0yF0yUChIAphGgXQvioGOzKZ5/meNxG+r653LKWZkfWMH1P0YC83y5f0ed3wPRM8xVBF1cgaL6RXUHYBwVdFipZuegFuq7yEXBr7pNKK5FxqreYm+ejxSMG0woqdawg9kipLL6OITEjo+rNEtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588637; c=relaxed/simple;
	bh=Wfr5zVjOG3UE709Szk8cKn0CtUNKm/A57P+u9YprkUk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Developer-Key:
	 X-Developer-Signature:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=CvYsU7+FYlrGf3zgFH1a7XfrxWxLIYM4DU1YJUb2i8wtPdCEU1kvA75pkpFzny2NBzX0fcd/+4pw/kA+YUcbkNxlvDgQ7VVRf3GxB9ssUyUifsKfeoc3yxhQNAS03njrxKrgfZ2QuupXs3c6uGqaYi1sDGedsM3Geg0QtU++gdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8vIBX4+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc221fad8c7so4973828276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 06:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705588635; x=1706193435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+blVL8ZBy6jqOBmqELtFpOeZUV9tKCkmfo+mU16u+CQ=;
        b=G8vIBX4+zMK7kB+v+5jRkLNgwGQbTO7+SLS+ps2TnX0IBsqfYqA0qpeEfNKs7QH1EK
         L4ME7Id53UVH7gLcZGc/tAeOq7bQ4KUw3mVZ9xTDXY6AG3Lamg+w5inam0f+X5Yy7iu9
         BwCiqLoISjERl6EcRmHmA8nvHYbN7He0HVcSCtwshF1tWFyzVj1n21eUzJtYkERdiGOW
         nHeVwRfM9SvJZoE+bqiHjsFB1ExxXTKgCg/j1Zir7ErGPZlKpw28SXDuon10BJPlEDhK
         dxUMtCIGjZKFlqiYeqcD7sJLyPj70q5jkZN7HGwR3JELhJi/ZL3mj08MbH5V9HCifcBe
         jo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588635; x=1706193435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+blVL8ZBy6jqOBmqELtFpOeZUV9tKCkmfo+mU16u+CQ=;
        b=gBIMnMXURpiD9aE+SnMfN29Qb9Tmp9JJ+hClWCUrr4Tb5rhihRwNZntfKXY0pbf+cF
         d3H0KsJsvGh+rq7FAxTCUyj2q/ZF/iAG9r3NAC54P0GiLPFBhPKy9u34LcDlqiXrXndo
         Ymyp++oZyVo5yzKk/s3Ju/aYTc+JoXb8YuNE77ioTdUqEj1QFbJpn6uhfW+pI6wfzqcQ
         jCZUVKDTPZAarcsUNVIclFitjad/QAtCPbfq+Yz6oHiq0Qb/PMETe1EiW5gvJ4qqkM2x
         70CVe50TlXEh5vKvPfkR4bD/7SvQxShantsWDuwvfi+GY8AdHtGM/afxCZEagQjD9i9Q
         vpyg==
X-Gm-Message-State: AOJu0YxfLTHbfDpnV/loJIfEqTXIBnhXK3GEhiEZbskhAHozbjhkK0CK
	BuHaxyNs5+3DifSEwaovoGHepp3ad1UdvOsYt/Tf9W0zTcl3iqt+6Q/XZZ+7/lX6dOfL0zrBmlK
	CJ6BS8diFE72m8g==
X-Google-Smtp-Source: AGHT+IFGfq3qRUUVFnxDR5EOj4wtoA0enHYKuoVAKwMvr3BgZK6gquRsAJl5Hu8oAjVwwLokiANxU7xlScrJE3M=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:abc1:0:b0:dbf:19f1:cebd with SMTP id
 v59-20020a25abc1000000b00dbf19f1cebdmr371231ybi.12.1705588634908; Thu, 18 Jan
 2024 06:37:14 -0800 (PST)
Date: Thu, 18 Jan 2024 14:36:49 +0000
In-Reply-To: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=13733; i=aliceryhl@google.com;
 h=from:subject; bh=Wfr5zVjOG3UE709Szk8cKn0CtUNKm/A57P+u9YprkUk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlqTHPtZXbCxpHNbaCYBy9CArf5mPIJ7e2rOqN0
 tlBygIEu3mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZakxzwAKCRAEWL7uWMY5
 RkLGD/967wZ0wgXtdAQJ/jfLlVeOB+mCOVoSxwIgfiWRxIXP2+hvDYfzUnW9Bt116lxL5YZlu3C
 odCoR2wfM6vUy3EOlccDohyspyLBdWbi6OVg30mXEeXPEwaWEV+nWhZOk7W7kIQuXi3s7fQPixh
 rxtBp4LRpPQ47yXvbgbOCrBXfL13Zsn2RCsdZxOedQtBZushemcSI1TNQLut2lvB5umi5oyWwgU
 7v88ZHgFtjENFPLn+UihunwI2h2m/zDiTrXhF1PxVJ4AaVNJmrL+KuXmPgRAauBJKzdSdLu0URI
 kXDsxX2u4waHhzZVBHKaEgJyL2uxPgv1Jtm7dqDFX0wFvM4O0a7FQHmYxH8A7qwmVpZPDooj4Fw
 HEwiQ78Ellr/1QWrLeLn8LfRMJCYHHvDD6tk5Pz+sAD/rZhnwB0q3GumT7hkXXMuZ2aHlOjnR6q
 WMGehYx3NsThbuUQ6xZK1V/ojmDFWTi4X3KDi2KOQ6N5DAqXkIazSKdN4yoWfLtR55eJXXle7Xg
 2LJrXOx5Qj3hozaAblwDC00CcIajFj17YtkjnDPEqrBwaYLYQKtHJKBViCv6RKhPLoemzniMJYz
 ZZa6FLIiCFy884Si0jczxU0CWJTnSjbDDBLrxRpQXUfHAR1Dc1gblmG/TxJqMGxdiKgPl+vBr9D 6cX89XlvsodY5FQ==
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118-alice-file-v3-8-9694b6f9580c@google.com>
Subject: [PATCH v3 8/9] rust: file: add `DeferredFdCloser`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

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
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |   8 ++
 rust/kernel/file.rs             | 180 +++++++++++++++++++++++++++++++-
 rust/kernel/task.rs             |  14 +++
 4 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 0499bbe3cdc5..6b5616499b6d 100644
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
index 4213d1af2c25..1a669e84dfe0 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -11,7 +11,8 @@
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
-use core::ptr;
+use alloc::boxed::Box;
+use core::{alloc::AllocError, mem, ptr};
 
 /// Flags associated with a [`File`].
 pub mod flags {
@@ -315,6 +316,183 @@ fn drop(&mut self) {
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
+/// # Invariants
+///
+/// If the `file` pointer is non-null, then it points at a `struct file` and owns a refcount to
+/// that file.
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
+            // INVARIANT: The `file` pointer is null, so the type invariant does not apply.
+            inner: Box::try_new(DeferredFdCloserInner {
+                twork: mem::MaybeUninit::uninit(),
+                file: core::ptr::null_mut(),
+            })?,
+        })
+    }
+
+    /// Schedule a task work that closes the file descriptor when this task returns to userspace.
+    ///
+    /// Fails if this is called from a context where we cannot run work when returning to
+    /// userspace. (E.g., from a kthread.)
+    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdCloseError> {
+        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
+
+        // In this method, we schedule the task work before closing the file. This is because
+        // scheduling a task work is fallible, and we need to know whether it will fail before we
+        // attempt to close the file.
+
+        // Task works are not available on kthreads.
+        let current = crate::current!();
+        if current.is_kthread() {
+            return Err(DeferredFdCloseError::TaskWorkUnavailable);
+        }
+
+        // Transfer ownership of the box's allocation to a raw pointer. This disables the
+        // destructor, so we must manually convert it back to a Box to drop it.
+        //
+        // Until we convert it back to a `Box`, there are no aliasing requirements on this
+        // pointer.
+        let inner = Box::into_raw(self.inner);
+
+        // The `callback_head` field is first in the struct, so this cast correctly gives us a
+        // pointer to the field.
+        let callback_head = inner.cast::<bindings::callback_head>();
+        // SAFETY: This pointer offset operation does not go out-of-bounds.
+        let file_field = unsafe { core::ptr::addr_of_mut!((*inner).file) };
+
+        let current = current.as_raw();
+
+        // SAFETY: This function currently has exclusive access to the `DeferredFdCloserInner`, so
+        // it is okay for us to perform unsynchronized writes to its `callback_head` field.
+        unsafe { bindings::init_task_work(callback_head, Some(Self::do_close_fd)) };
+
+        // SAFETY: This inserts the `DeferredFdCloserInner` into the task workqueue for the current
+        // task. If this operation is successful, then this transfers exclusive ownership of the
+        // `callback_head` field to the C side until it calls `do_close_fd`, and we don't touch or
+        // invalidate the field during that time.
+        //
+        // When the C side calls `do_close_fd`, the safety requirements of that method are
+        // satisfied because when a task work is executed, the callback is given ownership of the
+        // pointer.
+        //
+        // The file pointer is currently null. If it is changed to be non-null before `do_close_fd`
+        // is called, then that change happens due to the write at the end of this function, and
+        // that write has a safety comment that explains why the refcount can be dropped when
+        // `do_close_fd` runs.
+        let res = unsafe { bindings::task_work_add(current, callback_head, TWA_RESUME) };
+
+        if res != 0 {
+            // SAFETY: Scheduling the task work failed, so we still have ownership of the box, so
+            // we may destroy it.
+            unsafe { drop(Box::from_raw(inner)) };
+
+            return Err(DeferredFdCloseError::TaskWorkUnavailable);
+        }
+
+        // SAFETY: This is safe no matter what `fd` is. If the `fd` is valid (that is, if the
+        // pointer is non-null), then we call `filp_close` on the returned pointer as required by
+        // `close_fd_get_file`.
+        let file = unsafe { bindings::close_fd_get_file(fd) };
+        if file.is_null() {
+            // We don't clean up the task work since that might be expensive if the task work queue
+            // is long. Just let it execute and let it clean up for itself.
+            return Err(DeferredFdCloseError::BadFd);
+        }
+
+        // Acquire a refcount to the file.
+        //
+        // SAFETY: The `file` pointer points at a file with a non-zero refcount.
+        unsafe { bindings::get_file(file) };
+
+        // SAFETY: The `file` pointer is valid. Passing `current->files` as the file table to close
+        // it in is correct, since we just got the `fd` from `close_fd_get_file` which also uses
+        // `current->files`.
+        //
+        // This method closes the fd. There could be active light refcounts created from that fd,
+        // so we must ensure that the file has a positive refcount for the duration of those active
+        // light refcounts.
+        //
+        // Note: fl_owner_t is currently a void pointer.
+        unsafe { bindings::filp_close(file, (*current).files as bindings::fl_owner_t) };
+
+        // We update the file pointer that the task work is supposed to fput. This transfers
+        // ownership of our last refcount.
+        //
+        // INVARIANT: This changes the `file` field of a `DeferredFdCloserInner` from null to
+        // non-null. This doesn't break the type invariant for `DeferredFdCloserInner` because we
+        // still own a refcount to the file, so we can pass ownership of that refcount to the
+        // `DeferredFdCloserInner`.
+        //
+        // SAFETY: Task works are executed on the current thread right before we return to
+        // userspace, so this write is guaranteed to happen before `do_close_fd` is called, which
+        // means that a race is not possible here.
+        //
+        // When `do_close_fd` runs, it must be safe for it to `fput` the refcount. However, this is
+        // the case because all light refcounts that are associated with the fd we closed
+        // previously must be dropped when `do_close_fd`, since light refcounts must be dropped
+        // before returning to userspace.
+        unsafe { *file_field = file };
+
+        Ok(())
+    }
+
+    /// # Safety
+    ///
+    /// The provided pointer must point at the `twork` field of a `DeferredFdCloserInner` stored in
+    /// a `Box`, and the caller must pass exclusive ownership of that `Box`. Furthermore, if the
+    /// file pointer is non-null, then it must be okay to release the refcount by calling `fput`.
+    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head) {
+        // SAFETY: The caller just passed us ownership of this box.
+        let inner = unsafe { Box::from_raw(inner.cast::<DeferredFdCloserInner>()) };
+        if !inner.file.is_null() {
+            // SAFETY: By the type invariants, we own a refcount to this file, and the caller
+            // guarantees that dropping the refcount now is okay.
+            unsafe { bindings::fput(inner.file) };
+        }
+        // The allocation is freed when `inner` goes out of scope.
+    }
+}
+
+/// Represents a failure to close an fd in a deferred manner.
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum DeferredFdCloseError {
+    /// Closing the fd failed because we were unable to schedule a task work.
+    TaskWorkUnavailable,
+    /// Closing the fd failed because the fd does not exist.
+    BadFd,
+}
+
+impl From<DeferredFdCloseError> for Error {
+    fn from(err: DeferredFdCloseError) -> Error {
+        match err {
+            DeferredFdCloseError::TaskWorkUnavailable => ESRCH,
+            DeferredFdCloseError::BadFd => EBADF,
+        }
+    }
+}
+
 /// Represents the `EBADF` error code.
 ///
 /// Used for methods that can only fail with `EBADF`.
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 17c02370869b..a294fe9645fe 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -133,6 +133,12 @@ fn deref(&self) -> &Self::Target {
         }
     }
 
+    /// Returns a raw pointer to the task.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::task_struct {
+        self.0.get()
+    }
+
     /// Returns the group leader of the given task.
     pub fn group_leader(&self) -> &Task {
         // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
@@ -180,6 +186,14 @@ pub fn pid_in_current_ns(&self) -> Pid {
         unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
     }
 
+    /// Returns whether this task corresponds to a kernel thread.
+    pub fn is_kthread(&self) -> bool {
+        // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid. There
+        // are no further requirements to read the task's flags.
+        let flags = unsafe { (*self.0.get()).flags };
+        (flags & bindings::PF_KTHREAD) != 0
+    }
+
     /// Wakes up the task.
     pub fn wake_up(&self) {
         // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
-- 
2.43.0.381.gb435a96ce8-goog


