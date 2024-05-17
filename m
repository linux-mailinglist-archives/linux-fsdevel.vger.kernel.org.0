Return-Path: <linux-fsdevel+bounces-19649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA258C8395
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FA2B20DC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA6E4F61D;
	Fri, 17 May 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgLNNGf7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE60482DB
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938312; cv=none; b=FgaQiVz5URVZbuwYskXTDt94wEiTmth25ySBpvIeQu0qFSzIKHCgvjeZUnH1xirSfhXCskG+Q7Ljl7707G9fZ31XFnIhel8Qb3h4Ya7uCKcv8urkLEXuEw7pBrP4yWmwReAIeHWg9cnHa+rxDsbElR3o9t8nIYl8iJ1TzREenxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938312; c=relaxed/simple;
	bh=XOAau41h79SEaI7Nj/mOmoZ8wOguBlwDCsuhfx+Kpbc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=duv1VBek+izR+z8HuZmlM69cBLSFTEV/bOYTzTUvO1c0cLfRUdn0gXnw7BosqVsb8nx/lGa13dkaFFYNTj13JxU8RZ6nnfMxbG0Idto70Mo1Y/q1uIiRe9vDUnDJTLM7XcEhsex8sXA9IBm99wR1wb0o0+1WfDoXTA8EMvw0N8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgLNNGf7; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2e41bd70238so83321461fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715938308; x=1716543108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=54+7w48bN142XNunx76ZJBiBYJSK94IsSx5K6yCS0Io=;
        b=lgLNNGf7i/s2E3PaB5sOCWY/FjDE5gQH1FmWCgaAd7cvzEq6UKtDgjPxW6E5d2y0sP
         cgpxZrjLFoaxIK3R+iJTQ5tDkUmZlFL3a+lL09Of9gnJC6YJDvJ+zd6K5hv0Gxeh2YgH
         VGUnt3n7RETtsjTBtK31Nnf3FGfv42/Pqxj7uIPzy14UEUtMC29NdEvclBEEixb8hzv2
         4+tS5ftAZ5IvvA9/ErwUr83P2Wiq1FlLEF1UvweYup+zJR1GRayMDIZQXh6TTq0IXazn
         dqqVBTuuK3+C/y+IOpZeD/puvutvwE21tl5be+Qzo9LNNryES9czUE0wIQGclNrLMolY
         9FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715938308; x=1716543108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54+7w48bN142XNunx76ZJBiBYJSK94IsSx5K6yCS0Io=;
        b=mLrgKyX2eKMxg+qlCwkkrCVQ8bADRmaZoJIsYDblDHgBdYbmc+5/RG2LCHdMIrj7Cm
         T5Zpw5KifONdL/aIaNbFX8Ha/3f4vxMjGNNnUYAVkm7VvgPzaw/gWz/9H6rr0XOiX3YJ
         pDGLq1OtP2Tcub4wLy7lOrTVec+1vgmSAPM1LZ0UCWqUMgmJ64jXGNboGlZ5+XLDyY4m
         WBEuwQnNJtDl3kYlcqBjKHh7RfMyXH+3ZkNl+rpyzJRpzrR8WQB0/4YVHCeazKpq3OPz
         Ur07BE/fIgdeSkYR/KPEjBbjkR+2+E7+erQPU85qldesQ2FfJN4My2El6/d1jXMlgvTu
         iamQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlaYyPUJo1tHGiMLytP9nG0hGeqalKAfoG1k9eM8ZFWGMdruac4I+UluQFjtqVXL4ysOwwKQ+mAmkt8Wtd3YkHbsJJECadqIvNhDdBtw==
X-Gm-Message-State: AOJu0Yz9z6Z5i0kjxCzigAZdvYlS7e17kMKV8CgBH0VdClJpP8rTk8FK
	PeuzLDca7Ti8ALReoZuUJJp+3PmcrtQx7LN2zhTPaKemO0OmF/Xo1eC02vZZVV4Wad4SFCiGMOy
	M6Tw254tVVvPc6w==
X-Google-Smtp-Source: AGHT+IFxZ2DSWJ10+HRpC2ta5p6oy24n7XHCBDLwKTlVcCPLVdE/6JrcGKRI8iQoSOebbzuvdNnthyCetAOaUKo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9ecf:0:b0:2d8:60d4:ecb3 with SMTP id
 38308e7fff4ca-2e5204b5612mr229161fa.10.1715938308124; Fri, 17 May 2024
 02:31:48 -0700 (PDT)
Date: Fri, 17 May 2024 09:30:41 +0000
In-Reply-To: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7273; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XOAau41h79SEaI7Nj/mOmoZ8wOguBlwDCsuhfx+Kpbc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmRyPoExsQoG4YzXp5MSYQe2fmraAFdC+SYGQv+
 5K4Ts7c+mSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZkcj6AAKCRAEWL7uWMY5
 Rv47D/9n6N6m45J8u19Z91U/a1IA22yap2br3pa7MZETikI6Op/H3Z6ZaQAF7C1dnDLujB8e937
 ltOUYZni7lIu+NW27kA8H3lc5UEmNYXKL11PLVie3RcBwFlx/lYhPGoRZ/YAUMs4LZ7vGqJzext
 4/A653BmagYfMaSYIH0NaCXiCpP7jDKp+FmHFqjXsvuoeHzEVu5vE+TU+E3sGVMdahbt/Eqaysm
 vli9iZp8IGVelaj81c8Bk11C272Cy1TfB2n1ziwh+cgyeDgfF94Ylbz0DMu0xrwYIEL7DwShq6i
 KccUSe0KNTiBcEH7G+sATsaRMeLAQ0eDzIoEyqS1UoVLq20AXGcztQEAuoMbneOReOolq+WTVuW
 Rw7AxkJ/X0cf+hOPzUD9bK4V3Wy8p16lPqB4eoCiZBMtfDp3f9qvElSCu+LpSo60MYBptliqkbZ
 uIYtaynLSYHDkhbe9pClG+X5O1I/qD0gMxb4V3dWI6TUMqUX+ZHhwagwXDL0DBD7m24WBXw7b6X
 URPyYcwr+WJB7qTAF9oGaaZtC3B6CPNBLlAn5DcQNN0/wFaAh8P9hb8lfNZ2OrdQ2h425GF0aYH
 cdCTjTT5jD57jD+GjykM3/fB318awOekHNjmbeXCNLSF1Pl3NJ1gt67/By+Tthd110nVZGfcVHY q7+Y3f0WfhwdOPw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240517-alice-file-v6-8-b25bafdc9b97@google.com>
Subject: [PATCH v6 8/8] rust: file: add abstraction for `poll_table`
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
index 000000000000..20b23d985cd4
--- /dev/null
+++ b/rust/kernel/sync/poll.rs
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Utilities for working with `struct poll_table`.
+
+use crate::{
+    bindings,
+    file::{File, NoFdgetPos},
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
+    pub fn register_wait(&mut self, file: &File<NoFdgetPos>, cv: &PollCondVar) {
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
2.45.0.rc1.225.g2a3ae87e7f-goog


