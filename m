Return-Path: <linux-fsdevel+bounces-30673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9420898D24A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAF4B22324
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C86200101;
	Wed,  2 Oct 2024 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxxnzJ5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D90198A1A;
	Wed,  2 Oct 2024 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869105; cv=none; b=erkJpzcXFyM6PBMpEujUW5Fd902TVWjuWJzBnFP9diNBg4EXfKiFuu79Z4tAS/MFgfb6dU2IOfmomSnqRCaDvbtxu85ShqIIV3nFv/iz39d/g5AdYvNWZrBS5wo7BzBBaKk3lPGJBj3+PCTcgjtUTuSGs2krb0++VaKqwur2hbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869105; c=relaxed/simple;
	bh=s0A5BPnHq5SP98CNoAPnXBl9lWapo1mcp8KUftSfKU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iWbkGROKOmpOQhN8xStehW3NzB1I+/q3/4DyF1CSXhQbKJbzD7E6H8NJefvWaUb8s+sBbgRQsk4T19feMWFVUW5iCTBUcUC/wsTtdBWjkOvN5brGwNJ13iBOAZjryEDbmMkBuI0bQ35pjRpGF1azxqCeNF1dccKzYItsX75z4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxxnzJ5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FBBC4CEC5;
	Wed,  2 Oct 2024 11:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727869104;
	bh=s0A5BPnHq5SP98CNoAPnXBl9lWapo1mcp8KUftSfKU8=;
	h=From:Date:Subject:To:Cc:From;
	b=PxxnzJ5DXWlyTzn5Nu5m02TxiAdy8UmL3PUvKu+7y8CJK567SQyMIywKQrGLJorV6
	 10K4PeAbhLSKUG6jxtbNur/Qgi1d0XDWWYE5SrhRvhkbG1szok5M6cGp83W4mvvKEt
	 mKHHBgj59wxSXcp5KLf5oQDB5Ih7QhCgEmnYZqMMjeu3s+YfpxZ4PvLWfqmBjN3cey
	 LLSdRekJaJ5edIdgqW+ipwjyhExQThItyArnqPdO9R/NiqA/W+zPGQt8SZSdxWVS1z
	 cCI8BLyXMDKKUw1E20Q5sgXlar3dqgDsUTfqsAxnW4NxB73pwmzgyW8O2zeJRy/CBb
	 15ZXBYzc5dvYw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Oct 2024 13:38:10 +0200
Subject: [PATCH v5] rust: add PidNamespace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-brauner-rust-pid_namespace-v5-1-a90e70d44fde@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKEw/WYC/43O3UrEMBAF4FdZcm1Kfm3q1b6HyJJOpttgTUuSL
 StL392kiiiCenlgzjfnRhJGj4k8HG4k4uqTn0MJ+u5AYLThjNS7kolgQnHGOO2jvQSMNF5Spot
 3p2BfMC0WkGrRM+gEGKk7UoAl4uCvO/74VHJvE9Z+gLGS65CaqjSDn7Dejz7lOb7uW1ZeW/tb1
 ol7uswwZpp8zpOHkZqWM8NbA6yTx49JpP5YxWfvr7mroJzKFi0Y10ls9fEZY8CpmeP53ZL/t2S
 xnIVBCyZ7y+UPS321xK+WqpYwTGkHrVTmm7Vt2xsqQIxdtQEAAA==
X-Change-ID: 20241001-brauner-rust-pid_namespace-52b0c92c8359
To: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, 
 Bjoern Roy Baron <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Arve Hjonnevag <arve@android.com>, Todd Kjos <tkjos@android.com>, 
 Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, 
 Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Daniel Xu <dxu@dxuuu.xyz>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=17824; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s0A5BPnHq5SP98CNoAPnXBl9lWapo1mcp8KUftSfKU8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9NVhpdX23y7LSqFurg3fGTr0YPL/5kOpapg/rRE5Kx
 zbckBbY2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARkRyGvwIubx655c1zuXW/
 d9q/I+e2fM5rOPlH33RV9UK7ffn1loKMDF+mZ+0LWKZdJ3T4JsvNOL2zZ88+VXmj+j9zsckXlYt
 KEzgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.

The `PidNamespace` of a `Task` doesn't ever change once the `Task` is
alive. A `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)`
will not have an effect on the calling `Task`'s pid namespace. It will
only effect the pid namespace of children created by the calling `Task`.
This invariant guarantees that after having acquired a reference to a
`Task`'s pid namespace it will remain unchanged.

When a task has exited and been reaped `release_task()` will be called.
This will set the `PidNamespace` of the task to `NULL`. So retrieving
the `PidNamespace` of a task that is dead will return `NULL`. Note, that
neither holding the RCU lock nor holding a referencing count to the
`Task` will prevent `release_task()` being called.

In order to retrieve the `PidNamespace` of a `Task` the
`task_active_pid_ns()` function can be used. There are two cases to
consider:

(1) retrieving the `PidNamespace` of the `current` task (2) retrieving
the `PidNamespace` of a non-`current` task

From system call context retrieving the `PidNamespace` for case (1) is
always safe and requires neither RCU locking nor a reference count to be
held. Retrieving the `PidNamespace` after `release_task()` for current
will return `NULL` but no codepath like that is exposed to Rust.

Retrieving the `PidNamespace` from system call context for (2) requires
RCU protection. Accessing `PidNamespace` outside of RCU protection
requires a reference count that must've been acquired while holding the
RCU lock. Note that accessing a non-`current` task means `NULL` can be
returned as the non-`current` task could have already passed through
`release_task()`.

To retrieve (1) the `current_pid_ns!()` macro should be used which
ensure that the returned `PidNamespace` cannot outlive the calling
scope. The associated `current_pid_ns()` function should not be called
directly as it could be abused to created an unbounded lifetime for
`PidNamespace`. The `current_pid_ns!()` macro allows Rust to handle the
common case of accessing `current`'s `PidNamespace` without RCU
protection and without having to acquire a reference count.

For (2) the `task_get_pid_ns()` method must be used. This will always
acquire a reference on `PidNamespace` and will return an `Option` to
force the caller to explicitly handle the case where `PidNamespace` is
`None`, something that tends to be forgotten when doing the equivalent
operation in `C`. Missing RCU primitives make it difficult to perform
operations that are otherwise safe without holding a reference count as
long as RCU protection is guaranteed. But it is not important currently.
But we do want it in the future.

Note for (2) the required RCU protection around calling
`task_active_pid_ns()` synchronizes against putting the last reference
of the associated `struct pid` of `task->thread_pid`. The `struct pid`
stored in that field is used to retrieve the `PidNamespace` of the
caller. When `release_task()` is called `task->thread_pid` will be
`NULL`ed and `put_pid()` on said `struct pid` will be delayed in
`free_pid()` via `call_rcu()` allowing everyone with an RCU protected
access to the `struct pid` acquired from `task->thread_pid` to finish.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v5:
- Add missing SAFETY comments.
- Link to v4: https://lore.kernel.org/r/20241002-brauner-rust-pid_namespace-v4-1-d28045dc7348@kernel.org

Changes in v4:
- Drop "task_" prefix from methods on Task.
- Move comment block from current_pid_ns!() macro to current_pid_ns() method.
- Link to v3: https://lore.kernel.org/r/20241001-brauner-rust-pid_namespace-v3-1-dacf5203ba13@kernel.org

Changes in v3:
- Use PidNamespace::from_ptr() in current_pid_ns().
- Allow None aka NULL to be used with task_tgid_nr_ns().
- Expand on SAFETY in PidNamespaceRef.
- Link to v2: https://lore.kernel.org/r/20241001-brauner-rust-pid_namespace-v2-1-37eac8d93e75@kernel.org
---
 rust/helpers/helpers.c       |   1 +
 rust/helpers/pid_namespace.c |  26 +++++++++
 rust/kernel/lib.rs           |   1 +
 rust/kernel/pid_namespace.rs |  68 ++++++++++++++++++++++
 rust/kernel/task.rs          | 135 +++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 225 insertions(+), 6 deletions(-)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 62022b18caf5ec17231fd0e7be1234592d1146e3..d553ad9361ce17950d505c3b372a568730020e2f 100644
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
index 0000000000000000000000000000000000000000..f41482bdec9a7c4e84b81ec141027fbd65251230
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
index ff7d88022c57ca232dc028066dfa062f3fc84d1c..0e78ec9d06e0199dfafc40988a2ae86cd5df949c 100644
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
index 0000000000000000000000000000000000000000..0e93808e4639b37dd77add5d79f64058dac7cb87
--- /dev/null
+++ b/rust/kernel/pid_namespace.rs
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
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
+use core::ptr;
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
index 1a36a9f193685393e7211793b6e6dd7576af8bfd..d762cdd263573feed6e969830e5e2956638fdc48 100644
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
@@ -36,6 +37,16 @@ macro_rules! current {
     };
 }
 
+/// Returns the currently running task's pid namespace.
+#[macro_export]
+macro_rules! current_pid_ns {
+    () => {
+        // SAFETY: Deref + addr-of below create a temporary `PidNamespaceRef` that cannot outlive
+        // the caller.
+        unsafe { &*$crate::task::Task::current_pid_ns() }
+    };
+}
+
 /// Wraps the kernel's `struct task_struct`.
 ///
 /// # Invariants
@@ -145,6 +156,97 @@ fn deref(&self) -> &Self::Target {
         }
     }
 
+    /// Returns a PidNamespace reference for the currently executing task's/thread's pid namespace.
+    ///
+    /// This function can be used to create an unbounded lifetime by e.g., storing the returned
+    /// PidNamespace in a global variable which would be a bug. So the recommended way to get the
+    /// current task's/thread's pid namespace is to use the [`current_pid_ns`] macro because it is
+    /// safe.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the returned object doesn't outlive the current task/thread.
+    pub unsafe fn current_pid_ns() -> impl Deref<Target = PidNamespace> {
+        struct PidNamespaceRef<'a> {
+            task: &'a PidNamespace,
+            _not_send: NotThreadSafe,
+        }
+
+        impl Deref for PidNamespaceRef<'_> {
+            type Target = PidNamespace;
+
+            fn deref(&self) -> &Self::Target {
+                self.task
+            }
+        }
+
+        // The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
+        //
+        // The `PidNamespace` of a `Task` doesn't ever change once the `Task` is alive. A
+        // `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)` will not have an effect
+        // on the calling `Task`'s pid namespace. It will only effect the pid namespace of children
+        // created by the calling `Task`. This invariant guarantees that after having acquired a
+        // reference to a `Task`'s pid namespace it will remain unchanged.
+        //
+        // When a task has exited and been reaped `release_task()` will be called. This will set
+        // the `PidNamespace` of the task to `NULL`. So retrieving the `PidNamespace` of a task
+        // that is dead will return `NULL`. Note, that neither holding the RCU lock nor holding a
+        // referencing count to
+        // the `Task` will prevent `release_task()` being called.
+        //
+        // In order to retrieve the `PidNamespace` of a `Task` the `task_active_pid_ns()` function
+        // can be used. There are two cases to consider:
+        //
+        // (1) retrieving the `PidNamespace` of the `current` task
+        // (2) retrieving the `PidNamespace` of a non-`current` task
+        //
+        // From system call context retrieving the `PidNamespace` for case (1) is always safe and
+        // requires neither RCU locking nor a reference count to be held. Retrieving the
+        // `PidNamespace` after `release_task()` for current will return `NULL` but no codepath
+        // like that is exposed to Rust.
+        //
+        // Retrieving the `PidNamespace` from system call context for (2) requires RCU protection.
+        // Accessing `PidNamespace` outside of RCU protection requires a reference count that
+        // must've been acquired while holding the RCU lock. Note that accessing a non-`current`
+        // task means `NULL` can be returned as the non-`current` task could have already passed
+        // through `release_task()`.
+        //
+        // To retrieve (1) the `current_pid_ns!()` macro should be used which ensure that the
+        // returned `PidNamespace` cannot outlive the calling scope. The associated
+        // `current_pid_ns()` function should not be called directly as it could be abused to
+        // created an unbounded lifetime for `PidNamespace`. The `current_pid_ns!()` macro allows
+        // Rust to handle the common case of accessing `current`'s `PidNamespace` without RCU
+        // protection and without having to acquire a reference count.
+        //
+        // For (2) the `task_get_pid_ns()` method must be used. This will always acquire a
+        // reference on `PidNamespace` and will return an `Option` to force the caller to
+        // explicitly handle the case where `PidNamespace` is `None`, something that tends to be
+        // forgotten when doing the equivalent operation in `C`. Missing RCU primitives make it
+        // difficult to perform operations that are otherwise safe without holding a reference
+        // count as long as RCU protection is guaranteed. But it is not important currently. But we
+        // do want it in the future.
+        //
+        // Note for (2) the required RCU protection around calling `task_active_pid_ns()`
+        // synchronizes against putting the last reference of the associated `struct pid` of
+        // `task->thread_pid`. The `struct pid` stored in that field is used to retrieve the
+        // `PidNamespace` of the caller. When `release_task()` is called `task->thread_pid` will be
+        // `NULL`ed and `put_pid()` on said `struct pid` will be delayed in `free_pid()` via
+        // `call_rcu()` allowing everyone with an RCU protected access to the `struct pid` acquired
+        // from `task->thread_pid` to finish.
+        //
+        // SAFETY: The current task's pid namespace is valid as long as the current task is running.
+        let pidns = unsafe { bindings::task_active_pid_ns(Task::current_raw()) };
+        PidNamespaceRef {
+            // SAFETY: If the current thread is still running, the current task and its associated
+            // pid namespace are valid. `PidNamespaceRef` is not `Send`, so we know it cannot be
+            // transferred to another thread (where it could potentially outlive the current
+            // `Task`). The caller needs to ensure that the PidNamespaceRef doesn't outlive the
+            // current task/thread.
+            task: unsafe { &*PidNamespace::from_ptr(pidns) },
+            _not_send: NotThreadSafe,
+        }
+    }
+
     /// Returns the group leader of the given task.
     pub fn group_leader(&self) -> &Task {
         // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
@@ -182,11 +284,32 @@ pub fn signal_pending(&self) -> bool {
         unsafe { bindings::signal_pending(self.0.get()) != 0 }
     }
 
-    /// Returns the given task's pid in the current pid namespace.
-    pub fn pid_in_current_ns(&self) -> Pid {
-        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and passing a null
-        // pointer as the namespace is correct for using the current namespace.
-        unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
+    /// Returns task's pid namespace with elevated reference count
+    pub fn get_pid_ns(&self) -> Option<ARef<PidNamespace>> {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
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
+    #[doc(alias = "task_tgid_nr_ns")]
+    pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>) -> Pid {
+        match pidns {
+            // SAFETY: By the type invariant, we know that `self.0` is valid. We received a valid
+            // PidNamespace that we can use as a pointer.
+            Some(pidns) => unsafe { bindings::task_tgid_nr_ns(self.0.get(), pidns.as_ptr()) },
+            // SAFETY: By the type invariant, we know that `self.0` is valid. We received an empty
+            // PidNamespace and thus pass a null pointer. The underlying C function is safe to be
+            // used with NULL pointers.
+            None => unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) },
+        }
     }
 
     /// Wakes up the task.

---
base-commit: e9980e40804730de33c1563d9ac74d5b51591ec0
change-id: 20241001-brauner-rust-pid_namespace-52b0c92c8359


