Return-Path: <linux-fsdevel+bounces-25441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5BA94C27C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54EA1F23B9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126B18C925;
	Thu,  8 Aug 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsUZ2Bda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EA192B95
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133814; cv=none; b=ieaFlZhFpTVjYQhb8aRpo7eUsFU67h+nQrv9FqQ70K1mUjgzb0/ztGQIzsyvQbuge9MqMrEEPrOtwb2PGNvGiiED147eSB3ZKRhbtJdcSk0iHpYrhLBVd8w6A1sb6kczSnyhUThBEXOSeu39xnPt8dWKUBbjlBYXInGs5kO8wKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133814; c=relaxed/simple;
	bh=v6Li3ohO2P9VOUj0DUKsbg7ywLMTVrJwO8YEJkpqo/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GWLx8/vbSFuQtPZs6N6lcOtk9q2K5CSABLtIN6S618eluk96vGc6oy7YtnCTv9789Zk2Qd7w+jnDbk0Wx8rY0n0dBx1y+APzYsZToj+zqHF8pAu78Lx0cJnia//+F2tD2hR1JxtOUxqm9dcpEophm0crgpRBJwGH45rkgmqirtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsUZ2Bda; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-428fb72245bso6117855e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723133810; x=1723738610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+ey13UI9SszW+tMd43Q70Tf7NiOEY//3F7sxm3IBtc=;
        b=QsUZ2Bda26mX0n5V6qpxvXx0D4SuAbXmegggJ36kv61QYe/5hVBC7xOFgdBaVpEQ3b
         HKDjlBImH22TlKH/6ZW9uVPnqub0Y6yj+EM3AYdJdgb8yMxfEzYEbAac3xOAWuk94M3H
         eCOOHHAGu/dx4fkdU32F8XRstx7C1OELyLHJgajqMeXZumoi9N8NSImpIrDbkbv9eNx4
         EgzWeDBIj/PWVXWpiYza1AHz8tEYzgfcXT7a0bt6oJyVvHjc1C6XMGXtXTJnwf+4YLex
         wQhtIhhR99HW0+akqcT7nJMG2vUp42xhPQ2eXA+fyN48I1mRF9HHG0P7u4FVBZLG42jC
         YmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133810; x=1723738610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+ey13UI9SszW+tMd43Q70Tf7NiOEY//3F7sxm3IBtc=;
        b=NVLKAXUxzjrOIN/osnM/Pbq6tsqIkL+aSIazbz0aXJFYh5H+Pu7zuFU0li16P2LEbm
         WxGOW8biMPg76Ekyy52UBPR8oJLJGW9bGomshH5/ex7eDV5wd57HSKETzc+0zshQ+izX
         k8CoOUiRucoOBsxCUaPSQRzbEYyF2edGJ4/eH8fSXChUOtl/QYnTPeUUbi6mIwUVHhUL
         xqSwnDgLbNkVjsqTBtCTtIwcM5/FbSSp18pHTptj35hp5VBCGmNfT3TWqEOKTzTh52BX
         t2fNrLbX4XFtc92BW7bW2zyqH2uvfGgPtAfcCe7xHcQitR2pZdWQ+5tdrr2bJYi62DxW
         rBWg==
X-Forwarded-Encrypted: i=1; AJvYcCXWWnSZ9o1nyaOxzmbl90WkQR9Nh20JM0QQIStjxOTrgQ32cJZHu2qDH0RkdiB4O5ff4seSqHW+C2QwTiq4PMrpwMITMDfjmTYTIozwJw==
X-Gm-Message-State: AOJu0YwVHumcR2TB7vMHcQ3C0QyU0nUf0K32tS9OrlvS6ybQHx39VmGz
	qAuuRbzqrba4owucnHwv+z59Jj2XBA1VlqrcFF2Ib+tiJXtPI6rI/Oaky3iU1nMaRapu0GCd6dK
	iMNPIDFon3kdhmg==
X-Google-Smtp-Source: AGHT+IG2I4RPbnoStD3MOJX605BuNQcfc/hAKnnRNwDK+vapHNO4hCViNkB7px+DBGtKqt1lQ7RyR4EL9zrFG+4=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:35cb:b0:427:d8f1:e55c with SMTP
 id 5b1f17b1804b1-4290b7c929fmr615195e9.0.1723133809729; Thu, 08 Aug 2024
 09:16:49 -0700 (PDT)
Date: Thu, 08 Aug 2024 16:15:51 +0000
In-Reply-To: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7284; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=v6Li3ohO2P9VOUj0DUKsbg7ywLMTVrJwO8YEJkpqo/0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtO9ZEoaGDCW3sRjvgQ7wGSV9sVyQG7u0GIe30
 YObCCFtao2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrTvWQAKCRAEWL7uWMY5
 RpmxD/99GymF544SLDODAA4TSMZgcLCu1gRqElkJfapFS54UKp3EaE35FFBZueI80D0FO9iXE0p
 2cBEeLOSKLr3+Cip5ckUTz0ZFzEvnhP0PXWHmyoc39VyG70eMPWKKYXmc6UsY0z8jjAvHx2nqMg
 dmGOOSefvMKbOxJbRYFIcXv3sWwbpT2+vZ4fyn/WDtuFgxGgZ27keedNV3qlspeNdji9bm8exb7
 C60yHS7QIfgf8MriI/qvkHz40eaJvsD8mQV98YubdEessJmhONSxsQ3g4b72KS22CjH9CnAs8MF
 Ia0e9fSku2bVLfTayQWZcornYxeLkIaM9gapPDr+FVe2ug8BJEXvfqdrVm7rUzhU5IBJgeRK+Iv
 /KuB9MkgV3ZMsILLONf/Sg6KnJ+mgoTFHNwJH8ak59vl2/tepSVUJC4aGM0LPtyc+Q4OTNQ7Xtf
 W1HmgESjgxqskjJOEYHPJBGk3DXBdLxRWOX4ZkuSTpwk04e7fcxXvOch8lAVd1sHtvnHxZrkLxd
 N0qPYtvjV7TTemZWFJz4QlI7E+IQLIVlxuAbvjg7ylbt68qFhwF4FdwHQFXzGzFPOX3CqYMsZGj
 jNgQs2OsXbIbpilaAzYMpM3zwxD6226GBvH3LI1NwVpISg0lKLlwWU8SRV8OP+xbnvcE/aO0X+c zuE5dHeOasm+3mg==
X-Mailer: b4 0.13.0
Message-ID: <20240808-alice-file-v9-8-2cb7b934e0e1@google.com>
Subject: [PATCH v9 8/8] rust: file: add abstraction for `poll_table`
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
 rust/kernel/sync/poll.rs        | 121 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 73a133b92017..b5793142904d 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
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
index 000000000000..d5f17153b424
--- /dev/null
+++ b/rust/kernel/sync/poll.rs
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Utilities for working with `struct poll_table`.
+
+use crate::{
+    bindings,
+    fs::File,
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
2.46.0.rc2.264.g509ed76dc8-goog


