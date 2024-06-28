Return-Path: <linux-fsdevel+bounces-22791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C71E91C1F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 17:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3751C23CD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AA1CCCB9;
	Fri, 28 Jun 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvcPvfRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44371CCCA6
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586693; cv=none; b=rVkFfGexB7ZyNqUyDToeUd9uBNWMWRbkvV+3IItuEW7cFqpN1H5SneOcaobOb9K9Tsci13hPhgzX0jzuGqkohZyPY1DE0b51oIeh43guoFjQDID4Aatx63IJyEAguXHP8ehX5mjgOP4irs5DHRVbZeuwHIPWYZ1bBmOTnzjiBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586693; c=relaxed/simple;
	bh=oKaGHDnrqupViuRXMtll5RU9jzG83pkROJGpqrjmWrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPOSNVQW0qpUa1XMsOwMFqbudDUG13rMpprPpFkl2YxM3SoU33s11Gt3tXVY75jCN7RSIoz2KzPp9n9maFjJXp0GWeW1Yh/hUwxP57ImHFMvfq3Fxvz/+pxg0IaAkaVNPkKezoZb1YHPrB7sjCV/JP1xFtn7brZ/lg/4DrT+Phk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qvcPvfRS; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2ee4ab40417so11709781fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719586690; x=1720191490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv4X5HCz0mHAJhrblLEwF6K15PPfNYph9fKqj4QrWqA=;
        b=qvcPvfRSMZHMGaVMxxkj69X+yuoqeJWAI+mGkTPa3zjMYnJRvUQiy9Yx0x2i/ZfUp7
         fmKpQKOLTFkBvDlJhcYqPWyHpaSEvA7vVOb1y31t9m9eghhvzz0neL2jBKIxG1vBouMS
         iTLZndCRzUUSs5cJtXqaE1myx/Qx+J4sWvcJ+XPiz08TIi7H84PMT1hYy7Y9sv7pPNTE
         /UYMSdx0gRz7hfydHi8E6UiReNWcIC3sf+0XnG6WCxCdqLYJ9YQX1/E8BI0z+eAEic5X
         OnBd2lcVETf+M03naRgbHods9uuCUJomUwmhlc33z8p2RUFE7ifEdKXxiJgefQs1rJ7j
         6wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586690; x=1720191490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv4X5HCz0mHAJhrblLEwF6K15PPfNYph9fKqj4QrWqA=;
        b=F58ZezXvtGIBdSHJMhx3OstKADCv724ijREPEL//e4/6Lr9jQLc8w6D8qOBaDQ2YgQ
         OPSY8g4kztPGloPWlY/+jmYta+4+1EgXqdV7VYoyb8RWoqT3i/QeVR3me3asysLNZWOE
         45WCQGwSl03EARCCKAu2edVlj2aondO6WvzD2cMaGERWN4Gs9CBBTuztj7aFtidLDTcH
         2mA4HFMRexIQkIXvQHADA49F6J2ZmvFihtMfRaKxGj3dUIfNsetJRNgBz1SRi0ocwhIV
         /kAl+ulXPMd6v78ZK8QAVfp/SN0X1h2lmoZ/buz8dQzoxQZu7dieRHkfQ13qC0CuWyLX
         p81A==
X-Forwarded-Encrypted: i=1; AJvYcCUWWAwIxNCKC4zicg/0yQ+zcf0SP02BpI9UyDj5ikbG7vulastW2CB63UzH7cLxszk3r7e3eTKaFtFflfyl6dbv3a1VSuLlv8hWraDctw==
X-Gm-Message-State: AOJu0YzTw2IyG45WhvUXlJfB3/tfzRExeSWg1sdyDunItOpXw9f9UwtN
	Jp1eX+tdsQ3s2dLwZjVOl9KC/EKHyYXBYVC3lAAKXxBy0L2SRb2DDjBvfMG3NoajzDpOYp35jUd
	jf/1DN9DGDSBoeQ==
X-Google-Smtp-Source: AGHT+IHrh51dp+IDMj1N+uGSI5q7qASDiH0RqVC1DTBBvwhd4ZRgb9b4M4bqJYgnfjp9iyg4L7GoysM5bKSqcvc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3b98:b0:52c:c4c0:bb99 with SMTP
 id 2adb3069b0e04-52e7b92f044mr2478e87.3.1719586689755; Fri, 28 Jun 2024
 07:58:09 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:57:21 +0000
In-Reply-To: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7243; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=oKaGHDnrqupViuRXMtll5RU9jzG83pkROJGpqrjmWrM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfs9nSDHlXxRQ4/wfPEvlXip4lzgzsEBJhWdPu
 I457Q+oqseJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn7PZwAKCRAEWL7uWMY5
 Rs82EAC6UrQk8yKkBP4loWFJW8n8xcTs0iouXEAwED5SSNuYAZPD0P/xfHYvog8Gw+HFYS/8Ssy
 PKwUZSWLkGTJnkAkrZ7O3VgE/OAJiTBQaq1fMvPuIVv6vg+gV5p1uVI/RqTPcisr+FtLnV9G2hJ
 yin7IJ6dMMzeqFJ56N9fLYCKimvZx1mLyeIhXcc3Gd+sXzWJTOFMWYupGqSt110uG21aMgH7Hn8
 6iEw+VN8un2ZIjo74zP7P67/2oXQzVd1h+6E2HgSouiwkX6o/M2EKxrjdgwdo/RQdEaXDSHiAtn
 5VleuVyu2hC/wWVdtMY93gO7u+SY05l6vCstDmYfNZ5IV4wVgcdTz+F0xJv7lv6NCrdBLed3r5i
 hexPfASokTaNw8SeC0Q7SPoOAOr+2Qb6q9KC9M6JSSpn7HzsMLjFtkt/WVk4kzdqmvX8FkJq3z3
 BQWrJ/+tohrkTRpKfsdQzLw9q/JGDtmsFuPPblrDZ9bH9oiUQoRLQviiIEKWfQO5lz8J4iPx9fs
 nZKl/RDpCKd2TwPD6+DwKL0FaXol07Yj4vydFGgJRreW84V2a/TKitOR4cUMBtLKV9pHmm7Tj8y
 x5+aAJgQleouvmKhsPMoFz39T8/Wqrow6PyXJGAz7WY022CT70KrpZIzk66XjAhtDPkc3K9DYrh BxqaLe1CO6m3Xlw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-alice-file-v7-8-4d701f6335f3@google.com>
Subject: [PATCH v7 8/8] rust: file: add abstraction for `poll_table`
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

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/poll.rs        | 119 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2a758930fc74..b423d5cb6826 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -16,6 +16,7 @@
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
+#include <linux/poll.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..bae4a5179c72 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@
 mod condvar;
 pub mod lock;
 mod locked_by;
+pub mod poll;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
new file mode 100644
index 000000000000..586b660df423
--- /dev/null
+++ b/rust/kernel/sync/poll.rs
@@ -0,0 +1,119 @@
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
+        $crate::sync::poll::PollCondVar::new(
+            $crate::optional_name!($($name)?), $crate::static_lock_class!()
+        )
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
2.45.2.803.g4e1b14247a-goog


