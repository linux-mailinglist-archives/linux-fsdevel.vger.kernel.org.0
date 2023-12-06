Return-Path: <linux-fsdevel+bounces-4997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232E2806FFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DE51F21616
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEFD37176
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wDMV9Mes"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE62181
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 04:00:22 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d064f9e2a1so95645717b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 04:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701864021; x=1702468821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbE17RqH74sTr8G98jh3hq0E2+R+y1BNKFvou61O0+I=;
        b=wDMV9MeshFO6aZZl07J9DO/uXq2MCY576huZTrqxAhmU/tXsisul+3HkhGQYdxJ62y
         4fWQLYw26tux+uVog7c/RkcygPjdiIhXhRSBxEVPDjLzPdBpmjqGVAHKyvgxf8huCJ9b
         muSq8DjZ9CzTMy3e50sH7H4oew0d5DONSpE/G3iCn+O10DI91hAQ0SnsfOLFPWnNEMk/
         ic1MmWjX8ftYQZhZpUA0Z+OqkBO0rftHdaM4TOssNOg01vkYgYpDE7OAzeI1sOyb99/t
         JZ0lgeMAksHkzYijPvOyV/2uWaDyRbMZiQJ4ey9Nmcxyrf//rJWNEyhDupezS1Mkwcg0
         O3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864021; x=1702468821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbE17RqH74sTr8G98jh3hq0E2+R+y1BNKFvou61O0+I=;
        b=vcY4XXsR0fQHFEAJ3HESghwujWwo3HBuOuOLG7kMOdsh3Dcc4l1ZxepR2sshvhKYol
         t+lFkRvrYSd4SmElfE6uclihdt45BehXBslxcsXM5jr06Yp4P06TRYo7mVRotsBJF27+
         Rs7AQkCrUnagCeaKQ1edjqFrVNs0xXjm2Fd3aRJx7rhaYLypW4AabBux0QdNdpiedICX
         CX+XIkHWdOPIFdjmZ3t6qq2Sgpde3LSFz+o0tfr9lgUhESRBMexM/qHNPTtg1T9oRVU7
         xzOGrOMM92GaiadaImZK3Ep63Rm8XlkcWM/rwDHdyD+Th3Cj7LoaXjUh3bVb2Mm0GdhB
         IYzQ==
X-Gm-Message-State: AOJu0YxyH/58TFZ1vQrka6TA853eYEqYql5MQmg1nHOEOkx90R4qJ+UG
	DWnpzCOTkW14Xxl7zqLJ9J6l5asy3Q9E3Yk=
X-Google-Smtp-Source: AGHT+IFZCvODtOTMGqKTf2LP1GyZaL8gCaAllaeklYLrqzRuLzK7/6ELcPd548BgS0OBnodcOSDaIsvNGxSMrY8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:98d:b0:5d3:e8b8:e1fe with SMTP
 id ce13-20020a05690c098d00b005d3e8b8e1femr9234ywb.0.1701864021191; Wed, 06
 Dec 2023 04:00:21 -0800 (PST)
Date: Wed, 06 Dec 2023 11:59:52 +0000
In-Reply-To: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6796; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=EL7Hu6623848TCiQNxfsHyxyizMwk0mqsq7s9i/TwCw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcGI8P0hMAGaRy9KCnNF8/Rf30Q66IkTKoCZi8
 6ZTQpLf1gGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBiPAAKCRAEWL7uWMY5
 Rp9/EACTkUp06YLSWQxRsvx+FQYTA7HvD9AIkv0Yw5/edduRrb6jQNOg/JSS3OcufcC+IG+gzyL
 +22S87vRlsgE4lHkmAuhxbFu9Wq6Slfq4maIlUKoEAJODe4u0GkvirSVb2QmIGcG58twcs0TCT/
 8kxZ6QdBlqymny0WMWvz/8ifSG3yUPQ6BHCWzZWmp2iaFMSOR2+szQQaYWATPrMA62sB7a74BjG
 QZTu95IzdTFkNK9x2V3625cl/Z3uK6/AUb+XTyOsVtxfgcFJj7lsjr3syJUk7lv4uhOW598Sfaj
 2hgJlIckhdAMlg2CHb9i4MlfDKdxXP9XI+Jb6TbMNsVlH7UQQwli8uaQMX6vSBzjLmLYOKxh8Sj
 YELcYkL3nZHKB633At+X9T689xQSzmhKkigiHshCC9bbt4GnGCqUWYo+Sfgqk8BIKmkM2T9MZEA
 mjEwyuDR4GrvFfwqAcrlG/fqfOdVPxN+N5fbFz3NYPV9mtGnzKaJLrq+EVMm1zYaiKgitLk7rui
 wfIlzXX5V3r3IGg3PRN9+zQcW4RrTThXvruchNWaMyejdJDv9SEk7qUUxfV9lbUH+LeTmkKeyco
 xW6gRArDgBcrOeH+LDT/7+IlXPEYZ7ZLktHi0qGpW50qjVzv2E3JjY9D5YrPjTUTpzSpBRt2GjZ 6Usj49NJrkuHilA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-alice-file-v2-7-af617c0d9d94@google.com>
Subject: [PATCH v2 7/7] rust: file: add abstraction for `poll_table`
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
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The existing `CondVar` abstraction is a wrapper around `wait_list`, but
it does not support all use-cases of the C `wait_list` type. To be
specific, a `CondVar` cannot be registered with a `struct poll_table`.
This limitation has the advantage that you do not need to call
`synchronize_rcu` when destroying a `CondVar`.

However, we need the ability to register a `poll_table` with a
`wait_list` in Rust Binder. To enable this, introduce a type called
`PollCondVar`, which is like `CondVar` except that you can register a
`poll_table`. We also introduce `PollTable`, which is a safe wrapper
around `poll_table` that is intended to be used with `PollCondVar`.

The destructor of `PollCondVar` unconditionally calls `synchronize_rcu`
to ensure that the removal of epoll waiters has fully completed before
the `wait_list` is destroyed.

That said, `synchronize_rcu` is rather expensive and is not needed in
all cases: If we have never registered a `poll_table` with the
`wait_list`, then we don't need to call `synchronize_rcu`. (And this is
a common case in Binder - not all processes use Binder with epoll.) The
current implementation does not account for this, but if we find that it
is necessary to improve this, a future patch could change store a
boolean next to the `wait_list` to keep track of whether a `poll_table`
has ever been registered.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/bindings/lib.rs            |   1 +
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/poll.rs        | 103 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c8daee341df6..14f84aeef62d 100644
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
@@ -25,3 +26,4 @@
 const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
 const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
+const __poll_t BINDINGS_POLLFREE = POLLFREE;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 9bcbea04dac3..eeb291cc60db 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -51,3 +51,4 @@ mod bindings_helper {
 
 pub const GFP_KERNEL: gfp_t = BINDINGS_GFP_KERNEL;
 pub const __GFP_ZERO: gfp_t = BINDINGS___GFP_ZERO;
+pub const POLLFREE: __poll_t = BINDINGS_POLLFREE;
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
index 000000000000..e1dded9b7b9d
--- /dev/null
+++ b/rust/kernel/sync/poll.rs
@@ -0,0 +1,103 @@
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
+        $crate::file::PollCondVar::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+
+/// Wraps the kernel's `struct poll_table`.
+#[repr(transparent)]
+pub struct PollTable(Opaque<bindings::poll_table>);
+
+impl PollTable {
+    /// Creates a reference to a [`PollTable`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that for the duration of 'a, the pointer will point at a valid poll
+    /// table, and that it is only accessed via the returned reference.
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
+            // SAFETY: The pointers to `self` and `file` are valid because they are references.
+            //
+            // Before the wait list is destroyed, the destructor of `PollCondVar` will clear
+            // everything in the wait list, so the wait list is not used after it is freed.
+            unsafe { qproc(file.as_ptr() as _, cv.wait_list.get(), self.0.get()) };
+        }
+    }
+}
+
+/// A wrapper around [`CondVar`] that makes it usable with [`PollTable`].
+///
+/// # Invariant
+///
+/// If `needs_synchronize_rcu` is false, then there is nothing registered with `register_wait`.
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
+        // SAFETY: The pointer points at a valid wait list.
+        unsafe { bindings::__wake_up_pollfree(self.inner.wait_list.get()) };
+
+        // Wait for epoll items to be properly removed.
+        //
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::synchronize_rcu() };
+    }
+}

-- 
2.43.0.rc2.451.g8631bc7472-goog


