Return-Path: <linux-fsdevel+bounces-9994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DAD846E73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F5F1C261BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EFB140785;
	Fri,  2 Feb 2024 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yq5LugfC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0C14199A
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871374; cv=none; b=OFWlHJ5YNBg0r7abigNpaWM9rcPm/FhrrNj3XSDC8h26b42hGab7/50zDCpdIpOIGFo+4yMIo2U6Gc03abmBCUdb4HAulq+QZRNbNuSsCNaGNun1T8vIY/0eVdUz9hN9kX4K40kCj9Pfu7nNgP3fV8sqZcEljhzGsVw/xfhSLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871374; c=relaxed/simple;
	bh=LqQ8OwVxbPzdUo+kW5koCQz+OcHsDol7M6Fn5Cd5nIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q0w8SdMS/xLVp1OQXxhmR8+uMiu9JGa3j49Tx/As7CYfWPgYMubcC8VVHqx4o/YnAr2mHhjbQfiwsFc0o86/Ij3GJwEQrptadH4fQ3sKVaUe3DOLVFfpcf56NFLqQcH5OfF4Jf4wZG38fBOVFcQFSRwUzlfaXVMIWbFVHIEAyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yq5LugfC; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-5113a1131b5so270139e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871369; x=1707476169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7OJTEzfCPkXm3kKAnpxteFoSUxuxzJgtxMaImG0Qms=;
        b=yq5LugfCIHQoAQC5LRupsMt8csMYLmTSoj78FqqPMnY7l2lhNqTU849fJPR4LSdc9g
         dfQhSKRY8yjjEgJu2ot+YFS2TIeLkvGJ1Dj0MPvIRCI30h8AJbC2ygPbj/O//9dK77aL
         a5NdndxgQpa+i7k67ed0CmDTb8bsUmmbdxhBE8k5udTw9C5IN9ZrIZ6NKovT6PtpsMdP
         j4VEcexQaPx8taK6COS0D+ZT9iwQk9FUXnxjlcaX6nFR/npIJ964k9Rkk09PIru8tvya
         ErrZXnibXVzT1gtkGUMVoy1q/NP4JIY4RMBHgNZ51u95ZbOmoOTKnpIMFWPc4YmvwjSS
         e4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871369; x=1707476169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7OJTEzfCPkXm3kKAnpxteFoSUxuxzJgtxMaImG0Qms=;
        b=NOxnkpjRpbudOHPXQhvhKRPS4W60l0ACL8AzCqUXQYUz3pPjpUaoeolNXDpt5EmV9/
         nk7LebxWbe8eG1Oj265dph+cOjfiUFi7rDQCIcY3RJXbaDQc/MDGy/O3ArfEBdVSgr7q
         oatnRXytvtAVRBz2+H6qhMELUoiWvLuEIvk4T46+20q7xlM4ANYidkCYF1ul8Dkzxvx8
         Sfye6Kj3M92FccLDeH4FFy5JHVwsCLVrgi9K5zK1D2P4ScGzu47/rbhcQIIbRGITDKZQ
         SrzKqraPFqrm2p0+pBLfKRxej8eZT1ghTR2kCmneamh8tbXINg2PR+i/ukYnnsTQmGg/
         XefA==
X-Gm-Message-State: AOJu0Yz+dwr7se2W0Ky19tFcMS2v2uCEPLtMqtRNN8KLZdADaw1GTQcG
	FVCVcaaPdQYNDyDc989YIbk05i06NqY+dvJmqT4w/UwtU8UNi7LJpf2lP/Z7SLhOdxN++XcWAPB
	xhVM9/Tj+k1tvHg==
X-Google-Smtp-Source: AGHT+IHl2A+z7ztqDv/6faXsj4zkkSD90Q+J6hrcS/FXTJpETMQAUqpL1HeQsrivDk5EhsZmeCyqLzpbCF/3Jl4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:368d:b0:511:1c91:268 with SMTP
 id d13-20020a056512368d00b005111c910268mr6391lfs.0.1706871369140; Fri, 02 Feb
 2024 02:56:09 -0800 (PST)
Date: Fri,  2 Feb 2024 10:55:42 +0000
In-Reply-To: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=14091; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=LqQ8OwVxbPzdUo+kW5koCQz+OcHsDol7M6Fn5Cd5nIc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlvMjJO6KBh5YtYnqNShkLgwJE3tMy6AH4i0YjI
 lWYfgu+5YuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbzIyQAKCRAEWL7uWMY5
 RuoNEAChUCKS58KFezVriwOkb55q37x1VRoxUOixTV7Bik5/BUQTGEhzyMGqZ5TFq0NwLDh8aW+
 I4X0vFzqV3dOD66lrSs7oXghQX2cEu9FZvaJHC0lfOgeWxQcTw9npoXorq6Mv2xWBkqFqCidmxa
 HeH/XhxR7F9vcJtOxXWlKl5XW1EFtTiAdOiVa3NvMsSX4pwzUui3H2BAeumrcS5H37aKvVwsnf+
 fH2yyv+Tl8IRW6W8+s7PX2U0ZLNlT6pt7abrMiVtPPj4XeuhNFnVSEir9vELjSICDuFRFJNqwZ1
 DXBW5N1o/tcVC7bSKVSpYYmUqkQUgW6hPn7sz6Per759+832a+GdfhGLxqF20hZ2RbkbzIu10qQ
 sn6I85HxxvUHeDpcBwrxv/GdSZYL/gPgSAj/FQnbvkqf9DyTpEBHNLKGNMNaw9QZYZQiS4AM2pL
 eG/Fta9DYPiNonOqrsP98lFApmR7XpkIfzNsuNxiUtwmlcftZjJCIBwzSj8A16c2XH1FIWFeCES
 9DqdUQIMgQK0o8ozhtcWrrRl+SsbaIJGExwYQa0Hzdxt+ZgV1y/T3vQ8r3MC5yJkkW4S5si4i7c
 Vgl8NjyrOv2WksDWQkm8sEw8k4bJPwxV1RoIcjWHxu5BbfREa0AsB6ge/8ZhdBYLlvu9lKU2XKp dN5GkK+WXgZymPg==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202-alice-file-v4-8-fc9c2080663b@google.com>
Subject: [PATCH v4 8/9] rust: file: add `DeferredFdCloser`
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
 rust/kernel/file.rs             | 184 +++++++++++++++++++++++++++++++-
 rust/kernel/task.rs             |  14 +++
 4 files changed, 207 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4194b057ef6b..f4d9d04333c0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
+#include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/jiffies.h>
@@ -21,6 +22,7 @@
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
index 2004270a661c..e7628c574b57 100644
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
@@ -313,6 +314,187 @@ fn drop(&mut self) {
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
+        // This removes the fd from the fd table in `current`. The file is not fully closed until
+        // `filp_close` is called. We are given ownership of one refcount to the file.
+        //
+        // SAFETY: This is safe no matter what `fd` is. If the `fd` is valid (that is, if the
+        // pointer is non-null), then we call `filp_close` on the returned pointer as required by
+        // `file_close_fd`.
+        let file = unsafe { bindings::file_close_fd(fd) };
+        if file.is_null() {
+            // We don't clean up the task work since that might be expensive if the task work queue
+            // is long. Just let it execute and let it clean up for itself.
+            return Err(DeferredFdCloseError::BadFd);
+        }
+
+        // Acquire a second refcount to the file.
+        //
+        // SAFETY: The `file` pointer points at a file with a non-zero refcount.
+        unsafe { bindings::get_file(file) };
+
+        // This method closes the fd, consuming one of our two refcounts. There could be active
+        // light refcounts created from that fd, so we must ensure that the file has a positive
+        // refcount for the duration of those active light refcounts. We do that by holding on to
+        // the second refcount until the current task returns to userspace.
+        //
+        // SAFETY: The `file` pointer is valid. Passing `current->files` as the file table to close
+        // it in is correct, since we just got the `fd` from `file_close_fd` which also uses
+        // `current->files`.
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
+        // When `do_close_fd` runs, it must be safe for it to `fput` the refcount. However, this is
+        // the case because all light refcounts that are associated with the fd we closed
+        // previously must be dropped when `do_close_fd`, since light refcounts must be dropped
+        // before returning to userspace.
+        //
+        // SAFETY: Task works are executed on the current thread right before we return to
+        // userspace, so this write is guaranteed to happen before `do_close_fd` is called, which
+        // means that a race is not possible here.
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
index 7d59cf69ea8a..438e467fb145 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -145,6 +145,12 @@ pub unsafe fn current() -> impl Deref<Target = Task> {
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
@@ -192,6 +198,14 @@ pub fn pid_in_current_ns(&self) -> Pid {
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
2.43.0.594.gd9cf4e227d-goog


