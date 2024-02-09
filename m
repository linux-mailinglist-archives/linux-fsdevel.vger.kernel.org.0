Return-Path: <linux-fsdevel+bounces-10930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0728484F481
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A611F25E6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54B3F9EE;
	Fri,  9 Feb 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vP8IHFo3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C903771E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477560; cv=none; b=akRfNBhIkY3SI9T8yz4G7Q9C3Q4MX8T26GsG5MWfGIIAlt18eWvUpTbjFDiM0gLOKuL1FFW17aEFWcxss7JuVmK0huHIMj2vFaVdy/unywa/9pPjO663tu1tO0XzPuNyI/DfI3iWMg6UHBAGcV5OG7czAmY98g+eADcoW76jdpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477560; c=relaxed/simple;
	bh=1xxnjqk+SAwAyAAQTy8XinjcAaTXBrnKqLlMXwl2Prs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pyl8btkOLn3t6H/Y7hM7GXUE4B4NNwR86PKAU7XSScHSRJ6iV5CcZMndvRs4WUo7CqqUcpw5p3jY96JTGvTl/lCkIPY+vF3yiziDS0FcJyDrsmWLERhuRbFyECZe2olwvDcM4KRgZX1e0nfPgBV1bLI4fWlJPKlZrHRqUpYiT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vP8IHFo3; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-5117210e716so701081e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 03:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707477555; x=1708082355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/eEjy8EjBs/e5Jj34VUfUT2QjrL+J3wcm7XuKGrkuc=;
        b=vP8IHFo3fQea4cDR67Le8r9eqGLeLALz9ujrZDTivKBkx/22xGFdCPYBSZfv1NZA9b
         zUSeyTavWND1VX1W2mh1xCxVBWibp5No908fbEzQ4Lekg4lvcjl9jhwIIbEMHV1ey6CN
         LnnUxqLb1Aj2puBe0OYWxyUMpEIFtP7KK1Z6CP5cdz+pV6d9CRG2LKf/0s5hJRCdErnp
         8lTtBOAcvaxvtY1KaWEgHQq0Sjc6bK8+fl2lNR+mL6XcHoaN8E7r+wJPKcicfVAjgLim
         d8H7K0StyLoUfBkqRDB1+heL6CYuXlq++c8KtkTzNxAC/N4sspELuN4TpiYdsZIXd6E2
         fZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707477555; x=1708082355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/eEjy8EjBs/e5Jj34VUfUT2QjrL+J3wcm7XuKGrkuc=;
        b=sHyZ9ObyKYTQki0CmsKc63zkkoW3UZsJkuvW17M24WWtq+Sqyv45lrHXd04n8q2Tsq
         3p8Ne+3Fjfp/gTQC5VOxdrPV353zO/4bCCUu2dGqT2qslMnD44qRNmxe6Cs1FE9VzLGP
         Fvx/gb1h7YOJhSetNxbJJTWx3DBhh/4NNmwhxocpA6QamSzqO5GJyfW+IOrLQsFdXnAI
         WZmzpWFNrB5fNUvfkVyHwQabm5KclmRC0S35AT1nK1/cWhgaFVYAj451+MB7H7ocwyhR
         VQFSVzLjZTTrtE+TqWxSHeoQQn1QOZdLnFJmm655YO4+mir4hHBqq60uAbFu5y1HUlm+
         EK3A==
X-Forwarded-Encrypted: i=1; AJvYcCVvpK8ldsn9a9Is73WJ0rPCMe8axvA0rqAeqHSV9JFulwF9PpNc6opHUGP9QHzEoXQs72XgOu2ZBxo+KAiDUA3229nLAr4K8GqYK4l1CA==
X-Gm-Message-State: AOJu0Yyxofx5us6hCA7XxaB3afZpA+D6buKyR2nMGA/3dtPW2Dxvd1eo
	7VnMSfMv1JU4Aa1zxY8VxRQvnl5ljXmAJ4cgTv0AA/riUhnWsFlHiXxHjA5FLQCc5fGwz2YYvzk
	wTgXV8Uy/CJZngQ==
X-Google-Smtp-Source: AGHT+IGHe/7C6DC2nnibhEVSAtdSRtwXd3JHmLm1o6reeDCXpvPBw0DwRiDCoAKjn8WNP71vdK39mxG+PyciC1A=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:58e9:0:b0:511:6aed:81b0 with SMTP id
 v9-20020ac258e9000000b005116aed81b0mr1053lfo.1.1707477554973; Fri, 09 Feb
 2024 03:19:14 -0800 (PST)
Date: Fri, 09 Feb 2024 11:18:22 +0000
In-Reply-To: <20240209-alice-file-v5-0-a37886783025@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7156; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=1xxnjqk+SAwAyAAQTy8XinjcAaTXBrnKqLlMXwl2Prs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxgoVLbAi+A07gA4PEN5j4TTZreWWkynfVzDED
 d+aosnS5liJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcYKFQAKCRAEWL7uWMY5
 Rlt1EACSq7MgWC8Sbje5LSLlyb7hz89g6mUiwRJSmz5SRDBQYWSN8Tcr9Mf3f16t2orPZ9zXYk/
 ORVplPxsXG5fsDrzGXyze3TFzvYpgEbVnGIA8LSv1YU6vYZ5PVp7JsNLi4tgzgeMi2oP4yUcikn
 3xl7gbwD0P55oMysz0e01XanDYmbQYqcsDEskMdNkOeecytfOm9pvtfy9fU6yHfvcC/ncrJuzxM
 H58q3ymrF5dgJ1s8kPdk4gmsgIiPiLDBa322oab9d0vaxOu1MMxH/aA0pcGv4z9FgBhGYyTqUnT
 UayLsGa0B9ewQxGECeBmNnJ0CrRfkrG8DLSJbwlSLOd6yaepCz1frLpWtgcDngnzjQUe8KAv0lZ
 m7lOnjHtUM5EQTjDUT0IhDytoQMQvYpIfmryunDDs0Vdem2WC3WQ/cEYP6tv3VcvNGLzHlClLsf
 1mR4QYwWuVDVqr2V4bPZV13oaq5gn4rToNontwgVv0tCUfOUdTnQpcTXVvBX0+/MMoRu8r7Z6s1
 SwKALcMr3yk+jbTY5mynOhRqPpiT/RapVX7vZfF2xoUYwnxY8RGTAwdbAyio5sTpcGPRq2fvqLP
 DvDwq9+JR3C0P4+2JoDI9PPDE2BZy2jXcCMV6+u7rnPIVwZx/TZEbHAHVUGssn/7L0CRWCuvI5P pO9K71qEwt8invQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240209-alice-file-v5-9-a37886783025@google.com>
Subject: [PATCH v5 9/9] rust: file: add abstraction for `poll_table`
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
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/poll.rs        | 117 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)

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
2.43.0.687.g38aa6559b0-goog


