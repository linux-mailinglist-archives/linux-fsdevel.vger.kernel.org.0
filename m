Return-Path: <linux-fsdevel+bounces-30191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C77A98779D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B034287492
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2070115A86B;
	Thu, 26 Sep 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2ZvPxxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4A154C14;
	Thu, 26 Sep 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368568; cv=none; b=YQgWfb4Y6yoxhiJhR5PdQPOVNkSW2rm21ycTAEurAZ+hdvioyO/O8iRx1H2Z+lSv1vjd/T6NzrH6hcjmOkkV+cybQDcHkO/cB9yjdvOkGOGb8V/KFz16tNlW/ejxJU62iUv1UttWVx1lzAK3HC30pDqKCu0syG+rd8VOsfdsugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368568; c=relaxed/simple;
	bh=bgL1UW3o45G8aDELRgZ59CG7YYPVVb7KJWKR5UI9FQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAp0jNxVuBgbj7ESvk/XTRrsZ7xIRIt8UvzeY1LUnsb6V4lSwmy3mXqLDUaEfH8fvUlhsHdTXQm9IEugeeTvurkFASHP4tx+g+OauRoHMHWALdh9lCOen923ReoGNotpOFCXPSLc5cY9cYDErLZGmWcUvgZfxxNp1YQi2NjSJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2ZvPxxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A36AC4CEC5;
	Thu, 26 Sep 2024 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727368568;
	bh=bgL1UW3o45G8aDELRgZ59CG7YYPVVb7KJWKR5UI9FQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2ZvPxxOMW2lwQsRi3HyYDuaujztR38zEZHctTfnmJQi8gIE1Lh9DH6QW1BPXmrLl
	 cCu7RfFO49/s7GLVe2UpvUvprvhQR++LX4VbT0OjFZq4DWLe4qv9EMrYtpM38pLUuF
	 PffTP0c9izmNKcrW2BxkvjVSkM+RLkx6FoCVIojjcweKj5REw0IAQOR3fE8V+JnE55
	 trvCXWO+xVUi2ze+4qHoMLKRZPe2qwFlcpybh9eivSmkdSR3LdXCNOSQV27bfuUHHj
	 uDVHxsgHssvSZc8kc0l7fOfzKeJqDwdwYOnb4KppR55dwwlbj7VSbOzK8+oPWLAj6s
	 8y2fowQxne9kw==
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Bjoern Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve Hjonnevag <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: [PATCH] [RFC] rust: add PidNamespace wrapper
Date: Thu, 26 Sep 2024 18:35:46 +0200
Message-ID: <20240926-pocht-sittlich-87108178c093@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240926-bewundere-beseitigen-59808f199f82@brauner>
References: <20240926-bewundere-beseitigen-59808f199f82@brauner> <CAH5fLgixve=E5=ghc3maXVC+JdqkrPSDqKgJiYEJ9j_MD4GAzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10481; i=brauner@kernel.org; h=from:subject:message-id; bh=bgL1UW3o45G8aDELRgZ59CG7YYPVVb7KJWKR5UI9FQU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR97U3Jvz/zw8lTc9b9/SG01nS6xIqHbRdsphsd1rn5K 1lu72zv2I5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJHNnE8D/Vai4bc9cJw+cu jP9qjf1Xd/GUOHMnynQ/ObPcgvmzwTZGhr1rc9Q59b9yeM9KXqyjuFw80ny9ooG91Celvt/fBLd e4AcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Ok, so here's my feeble attempt at getting something going for wrapping
struct pid_namespace as struct pid_namespace indirectly came up in the
file abstraction thread.

The lifetime of a pid namespace is intimately tied to the lifetime of
task. The pid namespace of a task doesn't ever change. A
unshare(CLONE_NEWPID) or setns(fd_pidns/pidfd, CLONE_NEWPID) will not
change the task's pid namespace only the pid namespace of children
spawned by the task. This invariant is important to keep in mind.

After a task is reaped it will be detached from its associated struct
pids via __unhash_process(). This will also set task->thread_pid to
NULL.

In order to retrieve the pid namespace of a task task_active_pid_ns()
can be used. The helper works on both current and non-current taks but
the requirements are slightly different in both cases and it depends on
where the helper is called.

The rules for this are simple but difficult for me to translate into
Rust. If task_active_pid_ns() is called on current then no RCU locking
is needed as current is obviously alive. On the other hand calling
task_active_pid_ns() after release_task() would work but it would mean
task_active_pid_ns() will return NULL.

Calling task_active_pid_ns() on a non-current task, while valid, must be
under RCU or other protection mechanism as the task might be
release_task() and thus in __unhash_process().

Handling that in a single impl seemed cumbersome but that may just be
my lack of kernel Rust experience.

It would of course be possible to add an always refcounted PidNamespace
impl to Task but that would be pointless refcount bumping for the usual
case where the caller retrieves the pid namespace of current.

Instead I added a macro that gets the active pid namespace of current
and a task_get_pid_ns() impl that returns an Option<ARef<PidNamespace>>.
Returning an Option<ARef<PidNamespace>> forces the caller to make a
conscious decision instead of just silently translating a NULL to
current pid namespace when passed to e.g., task_tgid_nr_ns().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 rust/helpers/helpers.c       |  1 +
 rust/helpers/pid_namespace.c | 26 ++++++++++++++
 rust/kernel/lib.rs           |  1 +
 rust/kernel/pid_namespace.rs | 68 ++++++++++++++++++++++++++++++++++++
 rust/kernel/task.rs          | 56 +++++++++++++++++++++++++----
 5 files changed, 146 insertions(+), 6 deletions(-)
 create mode 100644 rust/helpers/pid_namespace.c
 create mode 100644 rust/kernel/pid_namespace.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 62022b18caf5..d553ad9361ce 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -17,6 +17,7 @@
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
+#include "pid_namespace.c"
 #include "rbtree.c"
 #include "refcount.c"
 #include "security.c"
diff --git a/rust/helpers/pid_namespace.c b/rust/helpers/pid_namespace.c
new file mode 100644
index 000000000000..f41482bdec9a
--- /dev/null
+++ b/rust/helpers/pid_namespace.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/pid_namespace.h>
+#include <linux/cleanup.h>
+
+struct pid_namespace *rust_helper_get_pid_ns(struct pid_namespace *ns)
+{
+	return get_pid_ns(ns);
+}
+
+void rust_helper_put_pid_ns(struct pid_namespace *ns)
+{
+	put_pid_ns(ns);
+}
+
+/* Get a reference on a task's pid namespace. */
+struct pid_namespace *rust_helper_task_get_pid_ns(struct task_struct *task)
+{
+	struct pid_namespace *pid_ns;
+
+	guard(rcu)();
+	pid_ns = task_active_pid_ns(task);
+	if (pid_ns)
+		get_pid_ns(pid_ns);
+	return pid_ns;
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ff7d88022c57..0e78ec9d06e0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,6 +44,7 @@
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
+pub mod pid_namespace;
 pub mod prelude;
 pub mod print;
 pub mod sizes;
diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
new file mode 100644
index 000000000000..cd12c21a68cb
--- /dev/null
+++ b/rust/kernel/pid_namespace.rs
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Pid namespaces.
+//!
+//! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pid_namespace.h) and
+//! [`include/linux/pid.h`](srctree/include/linux/pid.h)
+
+use crate::{
+    bindings,
+    types::{AlwaysRefCounted, Opaque},
+};
+use core::{
+    ptr,
+};
+
+/// Wraps the kernel's `struct pid_namespace`. Thread safe.
+///
+/// This structure represents the Rust abstraction for a C `struct pid_namespace`. This
+/// implementation abstracts the usage of an already existing C `struct pid_namespace` within Rust
+/// code that we get passed from the C side.
+#[repr(transparent)]
+pub struct PidNamespace {
+    inner: Opaque<bindings::pid_namespace>,
+}
+
+impl PidNamespace {
+    /// Returns a raw pointer to the inner C struct.
+    #[inline]
+    pub fn as_ptr(&self) -> *mut bindings::pid_namespace {
+        self.inner.get()
+    }
+
+    /// Creates a reference to a [`PidNamespace`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`PidNamespace`] reference.
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_namespace) -> &'a Self {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `PidNamespace` type being transparent makes the cast ok.
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: Instances of `PidNamespace` are always reference-counted.
+unsafe impl AlwaysRefCounted for PidNamespace {
+    #[inline]
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_pid_ns(self.as_ptr()) };
+    }
+
+    #[inline]
+    unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::put_pid_ns(obj.cast().as_ptr()) }
+    }
+}
+
+// SAFETY:
+// - `PidNamespace::dec_ref` can be called from any thread.
+// - It is okay to send ownership of `PidNamespace` across thread boundaries.
+unsafe impl Send for PidNamespace {}
+
+// SAFETY: It's OK to access `PidNamespace` through shared references from other threads because
+// we're either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for PidNamespace {}
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 1a36a9f19368..89a431dfac5d 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -6,7 +6,8 @@
 
 use crate::{
     bindings,
-    types::{NotThreadSafe, Opaque},
+    pid_namespace::PidNamespace,
+    types::{ARef, NotThreadSafe, Opaque},
 };
 use core::{
     cmp::{Eq, PartialEq},
@@ -36,6 +37,37 @@ macro_rules! current {
     };
 }
 
+/// Returns the currently running task's pid namespace.
+///
+/// The lifetime of `PidNamespace` is intimately tied to the lifetime of `Task`. The pid namespace
+/// of a `Task` doesn't ever change. A `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd,
+/// CLONE_NEWPID)` will not change the task's pid namespace. This invariant is important to keep in
+/// mind.
+///
+/// After a task is reaped it will be detached from its associated `struct pid`s via
+/// __unhash_process(). This will specifically set `task->thread_pid` to `NULL`.
+///
+/// In order to retrieve the pid namespace of a task `task_active_pid_ns()` can be used. The rules
+/// for this are simple but difficult for me to translate into Rust. If `task_active_pid_ns()` is
+/// called from `current` then no RCU locking is needed as current is obviously alive. However,
+/// calling `task_active_pid_ns()` on a non-`current` task, while valid, must be under RCU or other
+/// protection as the task might be in __unhash_process().
+///
+/// We could add an always refcounted `PidNamespace` impl to `Task` but that would be pointless
+/// refcount bumping for the usual case where the caller retrieves the pid namespace of `current`.
+///
+/// So I added a macro that gets the active pid namespace of `current` and a `task_get_pid_ns()`
+/// impl that returns an `ARef<PidNamespace>` or `None` if the pid namespace is `NULL`. Returning
+/// an `Option<ARef<PidNamespace>>` forces the caller to make a conscious decision what instead of
+/// just silently translating a `NULL` to `current`'s pid namespace.
+#[macro_export]
+macro_rules! current_pid_ns {
+    () => {
+        let ptr = current()
+        unsafe { PidNamespace::from_ptr(bindings::task_active_pid_ns(ptr)) }
+    };
+}
+
 /// Wraps the kernel's `struct task_struct`.
 ///
 /// # Invariants
@@ -182,11 +214,23 @@ pub fn signal_pending(&self) -> bool {
         unsafe { bindings::signal_pending(self.0.get()) != 0 }
     }
 
-    /// Returns the given task's pid in the current pid namespace.
-    pub fn pid_in_current_ns(&self) -> Pid {
-        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and passing a null
-        // pointer as the namespace is correct for using the current namespace.
-        unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
+    /// Returns task's pid namespace with elevated reference count
+    pub fn task_get_pid_ns(&self) -> Option<ARef<PidNamespace>> {
+        let ptr = unsafe { bindings::task_get_pid_ns(self.0.get()) };
+        if ptr.is_null() {
+            None
+        } else {
+            // SAFETY: `ptr` is valid by the safety requirements of this function. And we own a
+            // reference count via `task_get_pid_ns()`.
+            // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::pid_namespace`.
+            Some(unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr.cast::<PidNamespace>())) })
+        }
+    }
+
+    /// Returns the given task's pid in the provided pid namespace.
+    pub fn task_tgid_nr_ns(&self, pidns: &PidNamespace) -> Pid {
+        // SAFETY: We know that `self.0.get()` is valid by the type invariant.
+        unsafe { bindings::task_tgid_nr_ns(self.0.get(), pidns.as_ptr()) }
     }
 
     /// Wakes up the task.
-- 
2.45.2


