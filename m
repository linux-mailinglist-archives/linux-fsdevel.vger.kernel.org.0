Return-Path: <linux-fsdevel+bounces-30465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2E498B88C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEB82833BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC019F125;
	Tue,  1 Oct 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFOcjblv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F919D09A;
	Tue,  1 Oct 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775840; cv=none; b=IgOP2gQ4ExO7bbKg4t6U0JrRh46P4o4k/eqBuE3cwN14GXmcChEmQAXvQXuhRpuwt1FKicpBdej5LBj7RzJJJjTDxmwrlYOJTFBH3xBlc7ELD5rMwCC/hgl0ttIoE/x/9wMQZ7+wK7uIpg7QrAicDm8szDORDHTyNFGzL6MeUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775840; c=relaxed/simple;
	bh=uj5oNmhAMFqzhBu4zy4d81VXmoeA+EM3YxPzO67wjRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=GXIRhx3z4WknjGCOE/laYv321pDnCpfuL5yTqCu2dAidJw98FtiFTBqo9m3QAr7uMXBhji/Q2KA80LbwO5qNKOHdAvRc/k3VR7ezOPTTjW/l93zVV7q9kp0eMOCw263+wCSEKskUwOMrjVV5NipSlk7u/EdSCetY098ZunZc5d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFOcjblv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3454AC4CEC6;
	Tue,  1 Oct 2024 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727775839;
	bh=uj5oNmhAMFqzhBu4zy4d81VXmoeA+EM3YxPzO67wjRQ=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:From;
	b=uFOcjblv4JeBknahQfM2mTuDiNASKDXvhea3a0tCm/CLVY3lYezig5O3Zwn7n0lfW
	 5XIOdH56b2rP8jgJvu9ZNR8ibkXAnXkIkymkWkk4xS0+ucqB1GmAovSQoXdXlb5c3y
	 rWajF0Zi2ZFwRiTlBY/gwoyLhBJtLY9JxkCFfkbnfmsGbybmaNshuBuEjbupdDQx0j
	 t+G/XQGQIDbpeUl5QnGXnq7j4qCJP1ihLmZBAbXWXZxgQ8bD6/qvi1/Z9axnra0jFz
	 Vjn9fj24cUnn40GIbzF10SZHYM0xz1uDIJISCmTWDhKGftpbRhEop5FxHGIvRT3+6G
	 kxPr1XvTZ2rSw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 01 Oct 2024 11:43:42 +0200
Subject: [PATCH v2] rust: add PidNamespace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-brauner-rust-pid_namespace-v2-1-37eac8d93e75@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE3E+2YC/y2OQQqDMBREr1KybiSJtSZd9R5FSozf5oONkh+lR
 bx7jXT5YObNrIwgIhC7nVYWYUHCMeygzifmvA0v4NjtzJRQFymE5G20c4DI40yJT9g9g30DTdY
 Br1QrnFFOl5Vhu2CK0OPnkD+anVtLkPvB+axceiqypehxgJz3SGmM3+PLInPrmBVGXfk0Op84Y
 UoDOs91LYWWtXbClPf/JdZs2/YDL1JSKdEAAAA=
X-Change-ID: 20241001-brauner-rust-pid_namespace-52b0c92c8359
In-Reply-To: <20240926-pocht-sittlich-87108178c093@brauner>
References: <20240926-pocht-sittlich-87108178c093@brauner>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15946; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uj5oNmhAMFqzhBu4zy4d81VXmoeA+EM3YxPzO67wjRQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9PhIh3CS+MOFYwBX1JdoXVze2Lu5b0zeBQ/MKk8w3a
 5UcwRaHjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImcFGL4X70gesPNhbmL33TJ
 MB9PES7+cvHJgZtvrEqe3TFIqLNQ/s/IcIFrk4r48QWJHqVTjRRWfGvOn6C05NOqS/xtJxxL11V
 4sgEA
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
 rust/helpers/helpers.c       |   1 +
 rust/helpers/pid_namespace.c |  26 ++++++++++
 rust/kernel/lib.rs           |   1 +
 rust/kernel/pid_namespace.rs |  70 +++++++++++++++++++++++++
 rust/kernel/task.rs          | 119 ++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 211 insertions(+), 6 deletions(-)

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
index 0000000000000000000000000000000000000000..9a0509e802b4939ad853a802ee6d069a5f00c9df
--- /dev/null
+++ b/rust/kernel/pid_namespace.rs
@@ -0,0 +1,70 @@
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
index 1a36a9f193685393e7211793b6e6dd7576af8bfd..92603cdb543d9617f1f7d092edb87ccb66c9f0c1 100644
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
@@ -36,6 +37,65 @@ macro_rules! current {
     };
 }
 
+/// Returns the currently running task's pid namespace.
+///
+/// The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
+///
+/// The `PidNamespace` of a `Task` doesn't ever change once the `Task` is alive. A
+/// `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)` will not have an effect on the
+/// calling `Task`'s pid namespace. It will only effect the pid namespace of children created by
+/// the calling `Task`. This invariant guarantees that after having acquired a reference to a
+/// `Task`'s pid namespace it will remain unchanged.
+///
+/// When a task has exited and been reaped `release_task()` will be called. This will set the
+/// `PidNamespace` of the task to `NULL`. So retrieving the `PidNamespace` of a task that is dead
+/// will return `NULL`. Note, that neither holding the RCU lock nor holding a referencing count to
+/// the `Task` will prevent `release_task()` being called.
+///
+/// In order to retrieve the `PidNamespace` of a `Task` the `task_active_pid_ns()` function can be
+/// used. There are two cases to consider:
+///
+/// (1) retrieving the `PidNamespace` of the `current` task
+/// (2) retrieving the `PidNamespace` of a non-`current` task
+///
+/// From system call context retrieving the `PidNamespace` for case (1) is always safe and requires
+/// neither RCU locking nor a reference count to be held. Retrieving the `PidNamespace` after
+/// `release_task()` for current will return `NULL` but no codepath like that is exposed to Rust.
+///
+/// Retrieving the `PidNamespace` from system call context for (2) requires RCU protection.
+/// Accessing `PidNamespace` outside of RCU protection requires a reference count that must've been
+/// acquired while holding the RCU lock. Note that accessing a non-`current` task means `NULL` can
+/// be returned as the non-`current` task could have already passed through `release_task()`.
+///
+/// To retrieve (1) the `current_pid_ns!()` macro should be used which ensure that the returned
+/// `PidNamespace` cannot outlive the calling scope. The associated `current_pid_ns()` function
+/// should not be called directly as it could be abused to created an unbounded lifetime for
+/// `PidNamespace`. The `current_pid_ns!()` macro allows Rust to handle the common case of
+/// accessing `current`'s `PidNamespace` without RCU protection and without having to acquire a
+/// reference count.
+///
+/// For (2) the `task_get_pid_ns()` method must be used. This will always acquire a reference on
+/// `PidNamespace` and will return an `Option` to force the caller to explicitly handle the case
+/// where `PidNamespace` is `None`, something that tends to be forgotten when doing the equivalent
+/// operation in `C`. Missing RCU primitives make it difficult to perform operations that are
+/// otherwise safe without holding a reference count as long as RCU protection is guaranteed. But
+/// it is not important currently. But we do want it in the future.
+///
+/// Note for (2) the required RCU protection around calling `task_active_pid_ns()` synchronizes
+/// against putting the last reference of the associated `struct pid` of `task->thread_pid`.
+/// The `struct pid` stored in that field is used to retrieve the `PidNamespace` of the caller.
+/// When `release_task()` is called `task->thread_pid` will be `NULL`ed and `put_pid()` on said
+/// `struct pid` will be delayed in `free_pid()` via `call_rcu()` allowing everyone with an RCU
+/// protected access to the `struct pid` acquired from `task->thread_pid` to finish.
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
@@ -145,6 +205,41 @@ fn deref(&self) -> &Self::Target {
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
+        let pidns = unsafe { bindings::task_active_pid_ns(Task::current_raw()) };
+        PidNamespaceRef {
+            // SAFETY: If the current thread is still running, the current task and its associated
+            // pid namespace are valid. Given that `PidNamespaceRef` is not `Send`, we know it
+            // cannot be transferred to another thread (where it could potentially outlive the
+            // current `Task`).
+            task: unsafe { &*pidns.cast() },
+            _not_send: NotThreadSafe,
+        }
+    }
+
     /// Returns the group leader of the given task.
     pub fn group_leader(&self) -> &Task {
         // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
@@ -182,11 +277,23 @@ pub fn signal_pending(&self) -> bool {
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

---
base-commit: e9980e40804730de33c1563d9ac74d5b51591ec0
change-id: 20241001-brauner-rust-pid_namespace-52b0c92c8359


