Return-Path: <linux-fsdevel+bounces-8258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F1831B97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA3E287948
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3FF2D62C;
	Thu, 18 Jan 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZEAkGfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C43F2D609
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588640; cv=none; b=o2RSwwyN6vUmpkEnLEU3h3mH28OKCTxqlHSoL5ppbXfWH1PXFitC0PpbujK9Ep3j1eMwlYq92qryZTMYxHZEHbwINSG0WzN/oecTu3Pgz5MtYTyAlbMlri66Jg6ln/ipgLlXZk+Q9nvj6jxbU/9fdsMOfYVVREq8o7FKRmGxYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588640; c=relaxed/simple;
	bh=U0kbF9n+OCIj5nAmZ8f74BVmM+kgojhD1k4K8VuFoB4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Developer-Key:
	 X-Developer-Signature:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=kOKtt/Y4kZ9uGhBkzkM0s6Skc34pvjHMiRb8YsD9D++sGZEreD0RKe09BeqQWTxEAgeEOrQFGKEWmgMhK2/EoG0KnZ5sEfXVrj/hDEUu/Go0GnSz/zx1MtogtVXEb7pxYGOKyUBobbI0k2dc9punHvFPNkOJMoNbqrP+scbJoWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZEAkGfp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f53b4554b6so191595707b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 06:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705588637; x=1706193437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Im2eze6BefJj1h9/utHPCxEpN5HThewTotaQF/gyF20=;
        b=wZEAkGfpuMjRpE1+6dwYHA+yS/JnPH7iFnZnfvjWaWkUW1l768E5XywiBfavFs/lZk
         nv0lTuqPwlOLIuyIBnC01KE0C/uQIEIhamisNIoghYFbfDiMpOrcJBAUIPxESCkynsfO
         WV7FVk4H0Fc8MTDwnOvIxuRaqyvlA4jiSNtpRU2vaClN+AWxeqLjqYefdA+FZtL87m0y
         5DbKU5canLqyi7gm9a/ylAKeDWfcy+nChbGWSbGirLR7YMieI5uE7H4SQHG1g4NRXwwM
         3dZ1o7/cw8QZBt8rRG/myVS2KFzp5hhiwjLCKe/xFtrUhZFSFi5OK0ELk30cCuMO0doB
         2Xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588637; x=1706193437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Im2eze6BefJj1h9/utHPCxEpN5HThewTotaQF/gyF20=;
        b=L3X/Nu19eSR32abWec3vFv6qRcb4oyePYHAaikHHZWEopG78qljtAmnhEFJX9bJ2C4
         r0oA3DbB7C+rTwy0ezfMrCHquzSYiqHXJZGBvGkLHVHtSiZ5/Z2GGIg78LUwVw3XQurC
         1TYRID4KAC/bgh9lPqLAeJBzlAZVshiK/0JY2AoMXXWs/BXUYHzJnqqPuh5GvVtmi+wu
         RRhxgHx7/ovRuAhi9SC9XjJ2BPebgVaCNXS0PGhaa+WMfvFYTu+GySeuqfuPvAESuyna
         KFm26Prrw3C10evOlmKmwVUqObIA9LQniq1HyG5fy5NN8XhCb/BFbC+Mv8+qXkHU7WXA
         h0MA==
X-Gm-Message-State: AOJu0YxYnFcdxAQQ7aGqavs4fns8nGxvYvvDePHcM3w+/9H3zI4ZO1Bu
	i5X6HriBPVE2YMs++deOyE8H6T7LNdMkZawIQTwzhAYgNgKtQDgkjjYZLSQuHRZIPCDqywEljeG
	8h4KUpRghSj6jqg==
X-Google-Smtp-Source: AGHT+IH8ayeG+LimUUCtLX40cJjApi/UJmZ4hNnhw+B525FrsPAuQeOvYvvRlowVtsQKqAev3yzVGqS/cnakdkA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:ab11:0:b0:dc2:5273:53f9 with SMTP id
 u17-20020a25ab11000000b00dc2527353f9mr38278ybi.1.1705588637528; Thu, 18 Jan
 2024 06:37:17 -0800 (PST)
Date: Thu, 18 Jan 2024 14:36:50 +0000
In-Reply-To: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6894; i=aliceryhl@google.com;
 h=from:subject; bh=U0kbF9n+OCIj5nAmZ8f74BVmM+kgojhD1k4K8VuFoB4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlqTHP1B0f9FEveRyGvHFIpDR82qIOZvzI0h0Dh
 +gXrFTQQkOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZakxzwAKCRAEWL7uWMY5
 RvAlEACEQG3zoHHCnyU+9ljr+4eCS0WAPem8ctmmonLTjsvGstWq9lFCCdBAc/0DMdLauRdTUGO
 mHtCVk6tZMWBOKyBNSxNiAzLV+v5Q5gIREOwh3hYLXvxVg3Xns/JeAdhXpxdtFEF9zuieO7vjAq
 BpHCxnuaPL/YFHFyYnDBo8bUZ5VhK0pzsM1ske9YQ5PEhyrx+geH9bzzDHl4JmCtrHltrtP/sLz
 Cn3TmAkW4th4USkhTxFxBHbGrHsgi+LayvLtYCHhWrUM99d6VtV5AAU8MTbGP3zV1X6P4sQPYS/
 ki3ChcPczJBFP5GEesM6QsMz0lPLngu57/jHKArSkrZ2fkU2JEFfbaAJlfoVxmd6ngxDxLJH193
 Sbi1M3sOqyR02eiJHybU6vJUqpZoPFHloMC8S5vPWKNcVFAngUB5jEXtaW2KiRV4QgccDTIwBxY
 jgLAO2yzUx6E3+Xp4Qtm3qhegaMr0SEQs+wWlxcLtddbi1COkAAJ1ebrc+vVCN6ro3RWLcW7Aox
 GzUFpnuqAT5U0ZvQ3bPCiM49MoOdUmujk/D2O84TfLkFMYdJ2k0uFl/FuCnMKwoxB6ann9NOgY3
 OLLnq4SgOImxiGcRCl23sNk+opYWTejwCXcq7Wiz9+qceQQ0Hitu7SZOODb/2uLDRXSeAow/eJU O2Sr+4iWJpdKUvw==
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118-alice-file-v3-9-9694b6f9580c@google.com>
Subject: [PATCH v3 9/9] rust: file: add abstraction for `poll_table`
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
 rust/kernel/sync/poll.rs        | 113 ++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 rust/kernel/sync/poll.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 6b5616499b6d..56c1471fc03c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,6 +13,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/pid_namespace.h>
+#include <linux/poll.h>
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index d219ee518eff..84726f80c406 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@
 mod condvar;
 pub mod lock;
 mod locked_by;
+pub mod poll;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::CondVar;
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
new file mode 100644
index 000000000000..157341a69854
--- /dev/null
+++ b/rust/kernel/sync/poll.rs
@@ -0,0 +1,113 @@
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
+/// requirements of `_qproc` functions. It must ensure that when the waiter is removed and a rcu
+/// grace period has passed, it must no longer access the `wait_queue_head`.
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
+            // The `cv.wait_list` pointer must be valid until an rcu grace period after the waiter
+            // is removed. The `PollCondVar` is pinned, so before `cv.wait_list` can be destroyed,
+            // the destructor must run. That destructor first removes all waiters, and then waits
+            // for an rcu grace period. Therefore, `cv.wait_list` is valid for long enough.
+            unsafe { qproc(file.as_ptr() as _, cv.wait_list.get(), self.0.get()) };
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
+        unsafe { bindings::__wake_up_pollfree(self.inner.wait_list.get()) };
+
+        // Wait for epoll items to be properly removed.
+        //
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::synchronize_rcu() };
+    }
+}
-- 
2.43.0.381.gb435a96ce8-goog


