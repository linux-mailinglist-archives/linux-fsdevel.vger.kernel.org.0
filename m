Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4887175B291
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGTP3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 11:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjGTP3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:29:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B402115
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 08:28:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c64ef5bde93so773685276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689866934; x=1690471734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tH3XEerZJwrZmU22bF8N/0qUJWteANYMAoh9Uhhjis=;
        b=iIbHUoHVCIkaKMm/BUsR4YwpCcAILtijBEEpiPzLGsxFloPgn0f7EOrpei60KDIcvk
         8t9TBzVqQs+AkQvHturJdtqihaNRMzMFCKXFW+yYzJtUuSGFzvt6b7X4xrQ742/qZmKU
         PvEKOBKF4OD/QkC7sV6V53SmlhclUJxyOXH9z0797NDGNgsxIgCVTE77X5wl3hBXbpX4
         CUYQc58iS7Vz7i0p4RGy5F1G9zOILpr96cQBOoIdxky3VX2EsWb49rl1/kluJqBrvrQt
         WqjWtykIW08YaMiVbMm4RK5QZ+3LafZMQodf7O1gjLNykfiDOSypoIOhwMpCer+173uW
         j3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866934; x=1690471734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tH3XEerZJwrZmU22bF8N/0qUJWteANYMAoh9Uhhjis=;
        b=i496Rw0Hy1MxIfReH0JxqsG+PRrg6llGFSyyCaRJijzu0fAwxzQ0r8ou/EGZYrWFbQ
         j6GsbwTBYf84NDH7j8gzcNDOc+a4Q6d4kxK4caqlt2xh1Zn+VeOL4JJBTV48FsIxoZs1
         HfeHUsHXTJHa8y+rX34IU0bNlE5l4EMUFtNso/f0I7o5lhdQR4hVW8tJ49Wv0frR2Yjd
         kHx/Otfr4nTPk+ATx84wNoW5c9Pg+6O1uaSxx/wQT7xQfW68i9D8lpxmpOCWcXYuI2LE
         LQmkkwInVJBmKkzCtB2SjAHCinlnWvTdnBAq6h6lYeoAQSpADG5x+0q31JNgsJjW/Wf/
         2y0A==
X-Gm-Message-State: ABy/qLa0P/POPv1Y55NJr5kvnNjkOeVNFKxqQxUbW5ZsaXXzM0BTPKe+
        15Q5ysirSUKkjwS53PUnVHJk9C0cd/OZHhc=
X-Google-Smtp-Source: APBJJlF6cATeLhYEkc+Kltokpd6Fuo8ex9iPNH0A4q6at8KTHctN4S63Ew8lL0snobh9IN2IF6MQLjmL7RBatPk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:2551:0:b0:c86:e7cf:4064 with SMTP id
 l78-20020a252551000000b00c86e7cf4064mr39916ybl.6.1689866934433; Thu, 20 Jul
 2023 08:28:54 -0700 (PDT)
Date:   Thu, 20 Jul 2023 15:28:19 +0000
In-Reply-To: <20230720152820.3566078-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230720152820.3566078-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720152820.3566078-5-aliceryhl@google.com>
Subject: [RFC PATCH v1 4/5] rust: file: add bindings for `poll_table`
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These bindings make it possible to register a `struct poll_table` with a
`CondVar` so that notifying the condition variable will mark a given
file as notified in the poll table.

This patch introduces a wrapper around `CondVar` (which is just a
wrapper around `wait_list`) rather than extending `CondVar` itself
because using the condition variable with poll tables makes it necessary
to use `POLLHUP | POLLFREE` to clear the wait list when the condition
variable is destroyed.

This is not necessary with the ordinary `CondVar` because all of its
methods will borrow the `CondVar` for longer than the duration in which
it enqueues something to the wait list. This is not the case when
registering a `PollTable`.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  2 +
 rust/bindings/lib.rs            |  1 +
 rust/kernel/file.rs             |  3 ++
 rust/kernel/file/poll_table.rs  | 93 +++++++++++++++++++++++++++++++++
 rust/kernel/sync/condvar.rs     |  2 +-
 5 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/file/poll_table.rs

diff --git a/rust/kernel/file/poll_table.rs b/rust/kernel/file/poll_table.rs
new file mode 100644
index 000000000000..d6d134355088
--- /dev/null
+++ b/rust/kernel/file/poll_table.rs
@@ -0,0 +1,93 @@
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
+    }
+}
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index ed353399c4e5..699ecac2db89 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -144,7 +144,7 @@ pub fn wait_uninterruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_,
     }
 
     /// Calls the kernel function to notify the appropriate number of threads with the given flags.
-    fn notify(&self, count: i32, flags: u32) {
+    pub(crate) fn notify(&self, count: i32, flags: u32) {
         // SAFETY: `wait_list` points to valid memory.
         unsafe {
             bindings::__wake_up(
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 8ddf8f04ae0f..7281264cbaa1 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -13,6 +13,9 @@
 };
 use core::{marker::PhantomData, ptr};
 
+mod poll_table;
+pub use self::poll_table::{PollCondVar, PollTable};
+
 /// Flags associated with a [`File`].
 pub mod flags {
     /// File is opened in append mode.
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index d89f0df93615..7d83e1a7a362 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/errname.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/poll.h>
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
@@ -19,3 +20,4 @@
 /* `bindgen` gets confused at certain things. */
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
-- 
2.41.0.255.g8b1d071c50-goog

