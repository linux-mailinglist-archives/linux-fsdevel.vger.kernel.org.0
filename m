Return-Path: <linux-fsdevel+bounces-4197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B225F7FD991
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42019B20DF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A531B3218B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yyMkw3fs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5510E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 05:12:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1ed4b268dso23166897b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 05:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701263576; x=1701868376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2TJvklCbtLuSIRISVkztiSuoID32+GR+rmccCeVWR2o=;
        b=yyMkw3fs3nCpiUgL74Y5jRHnMmomVutRby/ghwGhq4Gkw58skLQ2rwODjfxuzvjtxh
         /2+HUkKnPrkRmID8QX1DwCt8V/cY9JbQ0Ph1RwgZovVr7lP6nI0POj1QE+I5jT/g1G1a
         NBHcsUxNDf4K3XTI2csPy9HAAM/AslnjR/oulmSMCgXSuGouEhH9kWrylmhTrAlZ6ruX
         EH9XVi7fXiJdWeAnipKR2gab60D+JdT94gMB8odYLEh+rRU/qhMR/g8r888tRgyzS7VS
         mDu46XfM4iE2cRImj/kH09pa5S3hBZU+fw0q+R9zqI3hPM9bXZdbH1UDJl7nIWOw1GDC
         tkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263576; x=1701868376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TJvklCbtLuSIRISVkztiSuoID32+GR+rmccCeVWR2o=;
        b=isA4aOGPqpSm5rgOG5uc3j/hDJrsT+srTPm3O0zibX1szwPge3wikLXcn3Yb0Q9NYi
         BShT/if5U31hoR+FXqlRZi19zNbxwAmy3ElAjqEbkhvLXlJ+g0A+Xf/cudYhtcCjqERU
         EJr8caC06WQQSydkwEn9+lwtWIHi4TfLlBi5/ZGZadbXczaFSr3aIS9/dfRP/JMvz/M1
         5l1gH4G/i9j0XK/leYXLA7Ft+BPIxOniazxj6TJNLXxPewzG1Bf5ACBpLsXpSIk1U7f5
         7fPkor0JxqcmQPBQmYXJuwXIGrH9vZRrYCM+yXQS2b9OtgbZGqkS0OQdIqkuyABGrpyr
         lFyA==
X-Gm-Message-State: AOJu0YywEDI/8BggljsYAEU2NhVKKNNdUvUZejJliFXWdK8EkjjeilM5
	990zIuCIEGN+Jam0Jm0hJ41gZTZSPe3MKo8=
X-Google-Smtp-Source: AGHT+IHUFKaHKKii09g7HUyZ+EjCiaihzyYW1lpvxVTE4olOwMBv+jZ8c8SCt3BB6Rr4low3G2iWwC8XUzaw9rs=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:2e8a:b0:5ce:dff:f7a1 with SMTP
 id eu10-20020a05690c2e8a00b005ce0dfff7a1mr500330ywb.9.1701263575877; Wed, 29
 Nov 2023 05:12:55 -0800 (PST)
Date: Wed, 29 Nov 2023 13:12:51 +0000
In-Reply-To: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7830; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Gna2rPaAZxwA3tXNNtoQj3C864OEwyg6zxPLG5MwViQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlZzMyNVW1q4O9x1ivonWXMf7fKKfIjphoYoxIq
 mVR7gYG5H6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZWczMgAKCRAEWL7uWMY5
 RsYmEACB9dMvCwDxJCJalR1hGrue8xlQCBRcKrXTmHgBJhJdUEPuY8WwazY0nvqF41fdD1T0Feh
 fBnee05Jy/wyLTSgeHvIKz4HU6SEaP4f2yOQQVd4twNWC+VWA9GIHMZ52S1MbruEK8Q7HZeuCdD
 hbJX1NSY0BVN9gudouy7gUMq6m3zTyaEaZRoB1/AbeQlfljl0rUy9kpTjIsXnrvuTw4qVdQBR2H
 ExFbiPpchpnXUe+fJrEDMvUnDtsGeStmEZ3EcxLJlzEMWNsqyanO0J1z0ZabT4QMlYl9w47mvzD
 IaOLMoJyN3PtTvaQKVmuWwO04xL7zmGXfqBbWAmOOWIuk5fu589MQ9qHjkTMB3ADt7U1BDICsgc
 rVNhfCSct2b7x8NAJ2WAJoqPmtDqBhYGcGCBduAVMmMwvRuP9Fx3ak9Grxjh1kpweqX8zD+qLEo
 fZK3w/eO4d3bWoNMfM320BDi3SFnrseBsjhDLaHjcyVSW8VQrzRUVFSYCvagYx81Xxl6vBHVRhW
 G842WeGHLaauNvonNZDijcHR9UoTiIKGSXcNCzyKo5Fmwv6onzWjh56nAb03cyW7zJv6X9F8l+Z
 dXrsL+OkE25KjYX/wY2Ff/v9EmLtEJ1uwrL5PbRh+zAguNPIAQtlyiV9DMqhPEWpXnYwXCALXpn 8YEVL4srVGhjErQ==
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129-alice-file-v1-7-f81afe8c7261@google.com>
Subject: [PATCH 7/7] rust: file: add abstraction for `poll_table`
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

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
That said, `synchronize_rcu` is rather expensive and is not needed in
all cases: If we have never registered a `poll_table` with the
`wait_list`, then we don't need to call `synchronize_rcu`. (And this is
a common case in Binder - not all processes use Binder with epoll.) The
current implementation does not account for this, but we could change it
to store a boolean next to the `wait_list` to keep track of whether a
`poll_table` has ever been registered. It is up to discussion whether
this is desireable.

It is not clear to me whether we can implement the above without storing
an extra boolean. We could check whether the `wait_list` is empty, but
it is not clear that this is sufficient. Perhaps someone knows the
answer? If a `poll_table` has previously been registered with a
`wait_list`, is it the case that we can kfree the `wait_list` after
observing that the `wait_list` is empty without waiting for an rcu grace
period?

 rust/bindings/bindings_helper.h |  2 +
 rust/bindings/lib.rs            |  1 +
 rust/kernel/file.rs             |  3 ++
 rust/kernel/file/poll_table.rs  | 97 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/condvar.rs     |  2 +-
 5 files changed, 104 insertions(+), 1 deletion(-)

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
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 578ee307093f..35576678c993 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -14,6 +14,9 @@
 use alloc::boxed::Box;
 use core::{alloc::AllocError, marker::PhantomData, mem, ptr};
 
+mod poll_table;
+pub use self::poll_table::{PollCondVar, PollTable};
+
 /// Flags associated with a [`File`].
 pub mod flags {
     /// File is opened in append mode.
diff --git a/rust/kernel/file/poll_table.rs b/rust/kernel/file/poll_table.rs
new file mode 100644
index 000000000000..a26b64df0106
--- /dev/null
+++ b/rust/kernel/file/poll_table.rs
@@ -0,0 +1,97 @@
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
+        // field is not modified concurrently with this call.
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
+            unsafe { qproc(file.0.get() as _, cv.wait_list.get(), self.0.get()) };
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
+    #[allow(clippy::new_ret_no_self)]
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
+        self.inner.notify(1, bindings::POLLHUP | bindings::POLLFREE);
+        // Wait for epoll items to be properly removed.
+        //
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::synchronize_rcu() };
+    }
+}
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index b679b6f6dbeb..2d276a013ec8 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -143,7 +143,7 @@ pub fn wait_uninterruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_,
     }
 
     /// Calls the kernel function to notify the appropriate number of threads with the given flags.
-    fn notify(&self, count: i32, flags: u32) {
+    pub(crate) fn notify(&self, count: i32, flags: u32) {
         // SAFETY: `wait_list` points to valid memory.
         unsafe {
             bindings::__wake_up(

-- 
2.43.0.rc1.413.gea7ed67945-goog


