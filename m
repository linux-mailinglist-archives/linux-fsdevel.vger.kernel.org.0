Return-Path: <linux-fsdevel+bounces-9995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5008846E75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404CB28F22D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766EA1420A7;
	Fri,  2 Feb 2024 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDgxrgn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE81419A6
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871376; cv=none; b=gRzLIM0vgVqsCoSPnaLBcj6529Pi0s98k9jzSnFqTB0MNTniXCUs+cuEm9JNrEPavkVXM7R123zn+ijR5/E14JAhZMzJAq+82Ulw+93Nh1lod3DvYGMZbeMst/KF5xOoV8YAVjXWJw2A+s5Hm7fzs2p1RzVZMdlg2oqD5YrIvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871376; c=relaxed/simple;
	bh=/9E8jl2L0BIX668zHWJR7ToHHbaSj1Hq8IfbP9A+fIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pV77fANkS+PzBwFw/+ekK2sKKBd5I4XopT9DvlAI2RA4iRK8GMC+/tSsK7VLObyi0zzAeXdHx4F5+o82wQyA4CglNtq4XyPuYcrJ0ME4Bvchy1CV2fS+Y28QMKwbDp37WO60gRuBTGAl2ilij6Kc0w+pfgPMXqvqunnocn1yaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDgxrgn2; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-511393ca9efso265525e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871372; x=1707476172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/T3POnWw3qzAjUziQFt05EJyPrMhtND82GObaMSRXeI=;
        b=oDgxrgn2Oiu7po0wHn4a+p4ke9dei6b/0am+R/LY3cUQlngRKQYnjcDC8Hp7R/3nIM
         yLSwHIZx7BunaHUGQ66lOmxafX2OUj4nGTHiz3DO9T/EeQYC2rdbYEEHc91NdJ20TfTr
         UBcNRQ5LSpjAn8tEBe9PeCivkoZ3YP4q8l9vzJkvrEIZi8eT0hxyNuX03fGRQ5mJYK8W
         VraW3qqS1o6bgDwUZbMlYzQ/Xhf3a60knR8trVk2dyPafXWJ575yzbRPVlfCP6FH0I3h
         sVxIcZqkv9I9xz4PirmXIF7kgdDzE4nqFvW42D/SIsvQJrjIMKH9ayaQqwixUhQTIZt+
         E+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871372; x=1707476172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/T3POnWw3qzAjUziQFt05EJyPrMhtND82GObaMSRXeI=;
        b=FAH8bn2RmZZo7wu1u+++D5EI5QACTInTGy4yLd6Jv45kJjG0bqxqmaXdavf4y2BODQ
         zCyuFqsi8fO7LRTkZC13b4zSxNA5XKt7X6wNdajgchYLMRnFCOWYgXLTwHY5kE0n7AHc
         OhR/RbHckU9/43GadpdEIy1N4ncKUsHRL+giY7e9Ks8rjQ7Sy1PyZrDOB8yoUcBDIiFG
         ZDD5ekE9DRJim5AhNXzDTD9BXUkcdkLgrvBI07N2+zHez5HDwILwLoIcgotkuoo5x8/l
         +KM+ORrNX2QbxsiSqe+R5/Aa0YVpjm0vbNVz4NCrRVX1NhyWTPXdPiitRg8bL4VifqEu
         gVMQ==
X-Gm-Message-State: AOJu0YweZIgPcDRJw4k0LnTF9zAp7wEXSMlqlwwC2f+T2IOvm0kGNN8j
	1aQjQ+uilCCWwPpDtCVLBKkj8Y+avpfCU+sJXyr2vLWL2r1YTfCaTjlHev+I3AxLX6j5GPNE/MY
	0mHrPUbscZjwcBQ==
X-Google-Smtp-Source: AGHT+IFnB+VejAO7rn9uU/VIFtk4GElijkfB6w7nYhHAc9cL+yp8M3ywBdpLQZfk+YHM9K80cVbrvcFbPX/+kQE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3451:b0:511:b40:8202 with SMTP
 id j17-20020a056512345100b005110b408202mr1955lfr.13.1706871371849; Fri, 02
 Feb 2024 02:56:11 -0800 (PST)
Date: Fri,  2 Feb 2024 10:55:43 +0000
In-Reply-To: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7079; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/9E8jl2L0BIX668zHWJR7ToHHbaSj1Hq8IfbP9A+fIg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlvMjJeoAg3CjA+Q8HoANiJqIfHhAzETLQqjC3A
 qx9NpkZ3AmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbzIyQAKCRAEWL7uWMY5
 RlXoD/sGN5Q4XsAlugRqT0Wr/qujcbxi+PwWXhHAB2Om5c2Jh4e00/uxSkhy1Hf4OIVlqG8aigU
 Ajb+uW7ABF4dCChXejn/wWF5tJ5mn5DrVL/buuyXdsfSPaolQukZEjFN9FU+Bs7dOgCMvJXIK+V
 1gVwbxEg1jpJTso8gfhl9XV2/BSSdmINBdNmTafSuvCAtD/TIPAq4+JBXzK4xsfqNx7SXLArmCX
 WTnUy5BVZNSzk6bPNK5vyWNSmEC83ZBCkF0u/8gCtS8nJtMONJIozFMqO/XEMmbL8RQDwottXFp
 N+Cv7Lwv3yFWXLSB4CYWITqntU119Ck/Z9R3hT5r7cSQO6Fjh9c0lnLDNMGUVmHlOjuynpDsba/
 F9rO9YQQMyBqnSeVbPa0tD3kOVVPfdsfb9ni5R+nIEeL7ru0XOmA2KbWg5JMSK2Q1Rfz3WdAzWw
 yQXKkEwJWkLKrk89xLiP3pFhrjXB4II1Odk44sFxoeVgjQIJU+DCH75GGeCDQ7LX083MII7D78r
 gXjUJeWbCbxbwDWqnrTMTKQReUwzpLts51b7vV/cZVG6XE25kyHSlso0Oi2LSXjJlQTZy4aWkNS
 A6RJ+zsustodt8E4lBs9Q0cpXutnd1EZgNjgy5uRYpDkLcTpCzoSwdNWphWBVdIDV4LqTkehaXn SXwLTwkCDJmFXCQ==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202-alice-file-v4-9-fc9c2080663b@google.com>
Subject: [PATCH v4 9/9] rust: file: add abstraction for `poll_table`
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

The existing `CondVar` abstraction is a wrapper around
`wait_queue_head`, but it does not support all use-cases of the C
`wait_queue_head` type. To be specific, a `CondVar` cannot be registered
with a `struct poll_table`. This limitation has the advantage that you
do not need to call `synchronize_rcu` when destroying a `CondVar`.

However, we need the ability to register a `poll_table` with a
`wait_queue_head` in Rust Binder. To enable this, introduce a type
called `PollCondVar`, which is like `CondVar` except that you can
register a `poll_table`. We also introduce `PollTable`, which is a safe
wrapper around `poll_table` that is intended to be used with
`PollCondVar`.

The destructor of `PollCondVar` unconditionally calls `synchronize_rcu`
to ensure that the removal of epoll waiters has fully completed before
the `wait_queue_head` is destroyed.

That said, `synchronize_rcu` is rather expensive and is not needed in
all cases: If we have never registered a `poll_table` with the
`wait_queue_head`, then we don't need to call `synchronize_rcu`. (And
this is a common case in Binder - not all processes use Binder with
epoll.) The current implementation does not account for this, but if we
find that it is necessary to improve this, a future patch could store a
boolean next to the `wait_queue_head` to keep track of whether a
`poll_table` has ever been registered.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/poll.rs        | 117 ++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 rust/kernel/sync/poll.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f4d9d04333c0..c651d38e5dd6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -17,6 +17,7 @@
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
+#include <linux/poll.h>
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index c1fb10fc64f4..84b69e337a55 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@
 mod condvar;
 pub mod lock;
 mod locked_by;
+pub mod poll;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{CondVar, CondVarTimeoutResult};
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
new file mode 100644
index 000000000000..a0e4f3de109a
--- /dev/null
+++ b/rust/kernel/sync/poll.rs
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Utilities for working with `struct poll_table`.
+
+use crate::{
+    bindings,
+    file::File,
+    prelude::*,
+    sync::{CondVar, LockClassKey},
+    types::Opaque,
+};
+use core::ops::Deref;
+
+/// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
+#[macro_export]
+macro_rules! new_poll_condvar {
+    ($($name:literal)?) => {
+        $crate::sync::poll::PollCondVar::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+
+/// Wraps the kernel's `struct poll_table`.
+///
+/// # Invariants
+///
+/// This struct contains a valid `struct poll_table`.
+///
+/// For a `struct poll_table` to be valid, its `_qproc` function must follow the safety
+/// requirements of `_qproc` functions:
+///
+/// * The `_qproc` function is given permission to enqueue a waiter to the provided `poll_table`
+///   during the call. Once the waiter is removed and an rcu grace period has passed, it must no
+///   longer access the `wait_queue_head`.
+#[repr(transparent)]
+pub struct PollTable(Opaque<bindings::poll_table>);
+
+impl PollTable {
+    /// Creates a reference to a [`PollTable`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that for the duration of 'a, the pointer will point at a valid poll
+    /// table (as defined in the type invariants).
+    ///
+    /// The caller must also ensure that the `poll_table` is only accessed via the returned
+    /// reference for the duration of 'a.
+    pub unsafe fn from_ptr<'a>(ptr: *mut bindings::poll_table) -> &'a mut PollTable {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `PollTable` type being transparent makes the cast ok.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    fn get_qproc(&self) -> bindings::poll_queue_proc {
+        let ptr = self.0.get();
+        // SAFETY: The `ptr` is valid because it originates from a reference, and the `_qproc`
+        // field is not modified concurrently with this call since we have an immutable reference.
+        unsafe { (*ptr)._qproc }
+    }
+
+    /// Register this [`PollTable`] with the provided [`PollCondVar`], so that it can be notified
+    /// using the condition variable.
+    pub fn register_wait(&mut self, file: &File, cv: &PollCondVar) {
+        if let Some(qproc) = self.get_qproc() {
+            // SAFETY: The pointers to `file` and `self` need to be valid for the duration of this
+            // call to `qproc`, which they are because they are references.
+            //
+            // The `cv.wait_queue_head` pointer must be valid until an rcu grace period after the
+            // waiter is removed. The `PollCondVar` is pinned, so before `cv.wait_queue_head` can
+            // be destroyed, the destructor must run. That destructor first removes all waiters,
+            // and then waits for an rcu grace period. Therefore, `cv.wait_queue_head` is valid for
+            // long enough.
+            unsafe { qproc(file.as_ptr() as _, cv.wait_queue_head.get(), self.0.get()) };
+        }
+    }
+}
+
+/// A wrapper around [`CondVar`] that makes it usable with [`PollTable`].
+///
+/// [`CondVar`]: crate::sync::CondVar
+#[pin_data(PinnedDrop)]
+pub struct PollCondVar {
+    #[pin]
+    inner: CondVar,
+}
+
+impl PollCondVar {
+    /// Constructs a new condvar initialiser.
+    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+        pin_init!(Self {
+            inner <- CondVar::new(name, key),
+        })
+    }
+}
+
+// Make the `CondVar` methods callable on `PollCondVar`.
+impl Deref for PollCondVar {
+    type Target = CondVar;
+
+    fn deref(&self) -> &CondVar {
+        &self.inner
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for PollCondVar {
+    fn drop(self: Pin<&mut Self>) {
+        // Clear anything registered using `register_wait`.
+        //
+        // SAFETY: The pointer points at a valid `wait_queue_head`.
+        unsafe { bindings::__wake_up_pollfree(self.inner.wait_queue_head.get()) };
+
+        // Wait for epoll items to be properly removed.
+        //
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::synchronize_rcu() };
+    }
+}
-- 
2.43.0.594.gd9cf4e227d-goog


