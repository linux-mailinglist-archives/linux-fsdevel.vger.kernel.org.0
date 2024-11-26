Return-Path: <linux-fsdevel+bounces-35891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8AF9D95FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAAF283FEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BBB1CDA19;
	Tue, 26 Nov 2024 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHdf6/gQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FE7DA68;
	Tue, 26 Nov 2024 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619321; cv=none; b=nN1dtNHtTyz+1BrpJDfX8/TVFBePE1LqPnvtlUJtBvhF3rwlOX9YtEwz7+ZyaJivQaU+SKJ5fxz+W7NBVMcDddn+yeVxBI2H3wE3YOXOYJQ5puST5uqspVwnYapaBGJ9TToSDtrWWcnfrdlSoy7NB9BiefgQdYTAkXR4+n8TH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619321; c=relaxed/simple;
	bh=DXnaZfRqjb2Yy4H23KuLL3ov6bGMfwJvHd8KzLRFJSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8XN7dRI4agGKm2hxrccdULHlXGZyEOTzt2lqcu0wu+zihInobPzoflrx5n6we2nhVMcSxeKDkMCG1UEwuNeuOh5792C+YTxgmi43wYBbAbMNRX9sHjT3U+4+/9DchdF2fgF3yNlgFGJ7keKWvvjsBcfpwJ3CimsvIzrY8SD8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHdf6/gQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B45C4CECF;
	Tue, 26 Nov 2024 11:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732619320;
	bh=DXnaZfRqjb2Yy4H23KuLL3ov6bGMfwJvHd8KzLRFJSY=;
	h=From:To:Cc:Subject:Date:From;
	b=jHdf6/gQ92iEPePXpTk9lomfn5pIjhzO9dB33k0QlJyOmcwXa4+qRA0bSLQ1vHPl1
	 vsH1UM1K08eSKX1+WU3TAkYOpa6fjSF3EU6IBaLMkzxwtsmodtpwzdM33RqMilQRPQ
	 uAjkwtzlySygNYb0CN+3ICnWmlcMAag1oLimg0Lv4qw5HC89a3/VE1cRfwNjGWeogL
	 DMYQAHo6oL+JTAB3bnTrRRCUY4Z+P+kZP8ii735gNTuP5mmKqFFasl3u99Nxq6tjNU
	 5ZmunV+HO667bzq1T4ze3P9CMrChfdLNKb+qwhvxGYcNsVrNvo9vXWo5OhNLr8TQ3/
	 Zf0jprt6KOazw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust bindings for pid namespaces
Date: Tue, 26 Nov 2024 12:08:27 +0100
Message-ID: <20241126-vfs-rust-3af24a3dd7c0@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14295; i=brauner@kernel.org; h=from:subject:message-id; bh=DXnaZfRqjb2Yy4H23KuLL3ov6bGMfwJvHd8KzLRFJSY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7rtGpW3HlS572xwVsNz2OL5mb7Bz82SWws6nK87hjn /Ldxz8jOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi7M7wh8siMI63R/yDwWn9 5ye4Xr9ZrSCzennqiezH/s3LxGbVzWb4Xzb14LoVgRUTPhdM6Mn5WbDtfvG8G0EezOs0xSu23Iw o5wYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains my Rust bindings for pid namespaces needed for various
rust drivers. Here's a description of the basic C semantics and how they
are mapped to Rust.

The pid namespace of a task doesn't ever change once the task is alive.
A unshare(CLONE_NEWPID) or setns(fd_pidns/pidfd, CLONE_NEWPID) will not
have an effect on the calling task's pid namespace. It will only effect
the pid namespace of children created by the calling task. This
invariant guarantees that after having acquired a reference to a task's
pid namespace it will remain unchanged.

When a task has exited and been reaped release_task() will be called.
This will set the pid namespace of the task to NULL. So retrieving the
pid namespace of a task that is dead will return NULL. Note, that
neither holding the RCU lock nor holding a reference count to the
task will prevent release_task() from being called.

In order to retrieve the pid namespace of a task the
task_active_pid_ns() function can be used. There are two cases to
consider:

(1) retrieving the pid namespace of the current task
(2) retrieving the pid namespace of a non-current task

>From system call context retrieving the pid namespace for case (1) is
always safe and requires neither RCU locking nor a reference count to be
held. Retrieving the pid namespace after release_task() for current will
return NULL but no codepath like that is exposed to Rust.

Retrieving the pid namespace from system call context for (2) requires
RCU protection. Accessing a pid namespace outside of RCU protection
requires a reference count that must've been acquired while holding the
RCU lock. Note that accessing a non-current task means NULL can be
returned as the non-current task could have already passed through
release_task().

To retrieve (1) the current_pid_ns!() macro should be used. It ensures
that the returned pid namespace cannot outlive the calling scope. The
associated current_pid_ns() function should not be called directly as it
could be abused to created an unbounded lifetime for the pid namespace.
The current_pid_ns!() macro allows Rust to handle the common case of
accessing current's pid namespace without RCU protection and without
having to acquire a reference count.

For (2) the task_get_pid_ns() method must be used. This will always
acquire a reference on the pid namespace and will return an Option to
force the caller to explicitly handle the case where pid namespace is
None. Something that tends to be forgotten when doing the equivalent
operation in C.

Missing RCU primitives make it difficult to perform operations that are
otherwise safe without holding a reference count as long as RCU
protection is guaranteed. But it is not important currently. But we do
want it in the future.

Note for (2) the required RCU protection around calling
task_active_pid_ns() synchronizes against putting the last reference of
the associated struct pid of task->thread_pid. The struct pid stored in
that field is used to retrieve the pid namespace of the caller. When
release_task() is called task->thread_pid will be NULLed and put_pid()
on said struct pid will be delayed in free_pid() via call_rcu() allowing
everyone with an RCU protected access to the struct pid acquired from
task->thread_pid to finish.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

There'll be a merge conflict that should be resolved as below. The diff
looks huge but the resolution hopefully shouldn't be complicated. I also
pushed the following branch:

gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs rust-v6.13.pid_namespace

Where you can just steal the rust/kernel/task.rs file from. Otherwise
this is the merge diff:

diff --cc rust/kernel/task.rs
index 080599075875,4b8c59a82746..5120dddaf916
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@@ -145,17 -156,102 +156,108 @@@ impl Task
          }
      }

 +    /// Returns a raw pointer to the task.
 +    #[inline]
 +    pub fn as_ptr(&self) -> *mut bindings::task_struct {
 +        self.0.get()
 +    }
 +
+     /// Returns a PidNamespace reference for the currently executing task's/thread's pid namespace.
+     ///
+     /// This function can be used to create an unbounded lifetime by e.g., storing the returned
+     /// PidNamespace in a global variable which would be a bug. So the recommended way to get the
+     /// current task's/thread's pid namespace is to use the [`current_pid_ns`] macro because it is
+     /// safe.
+     ///
+     /// # Safety
+     ///
+     /// Callers must ensure that the returned object doesn't outlive the current task/thread.
+     pub unsafe fn current_pid_ns() -> impl Deref<Target = PidNamespace> {
+         struct PidNamespaceRef<'a> {
+             task: &'a PidNamespace,
+             _not_send: NotThreadSafe,
+         }
+
+         impl Deref for PidNamespaceRef<'_> {
+             type Target = PidNamespace;
+
+             fn deref(&self) -> &Self::Target {
+                 self.task
+             }
+         }
+
+         // The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
+         //
+         // The `PidNamespace` of a `Task` doesn't ever change once the `Task` is alive. A
+         // `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)` will not have an effect
+         // on the calling `Task`'s pid namespace. It will only effect the pid namespace of children
+         // created by the calling `Task`. This invariant guarantees that after having acquired a
+         // reference to a `Task`'s pid namespace it will remain unchanged.
+         //
+         // When a task has exited and been reaped `release_task()` will be called. This will set
+         // the `PidNamespace` of the task to `NULL`. So retrieving the `PidNamespace` of a task
+         // that is dead will return `NULL`. Note, that neither holding the RCU lock nor holding a
+         // referencing count to
+         // the `Task` will prevent `release_task()` being called.
+         //
+         // In order to retrieve the `PidNamespace` of a `Task` the `task_active_pid_ns()` function
+         // can be used. There are two cases to consider:
+         //
+         // (1) retrieving the `PidNamespace` of the `current` task
+         // (2) retrieving the `PidNamespace` of a non-`current` task
+         //
+         // From system call context retrieving the `PidNamespace` for case (1) is always safe and
+         // requires neither RCU locking nor a reference count to be held. Retrieving the
+         // `PidNamespace` after `release_task()` for current will return `NULL` but no codepath
+         // like that is exposed to Rust.
+         //
+         // Retrieving the `PidNamespace` from system call context for (2) requires RCU protection.
+         // Accessing `PidNamespace` outside of RCU protection requires a reference count that
+         // must've been acquired while holding the RCU lock. Note that accessing a non-`current`
+         // task means `NULL` can be returned as the non-`current` task could have already passed
+         // through `release_task()`.
+         //
+         // To retrieve (1) the `current_pid_ns!()` macro should be used which ensure that the
+         // returned `PidNamespace` cannot outlive the calling scope. The associated
+         // `current_pid_ns()` function should not be called directly as it could be abused to
+         // created an unbounded lifetime for `PidNamespace`. The `current_pid_ns!()` macro allows
+         // Rust to handle the common case of accessing `current`'s `PidNamespace` without RCU
+         // protection and without having to acquire a reference count.
+         //
+         // For (2) the `task_get_pid_ns()` method must be used. This will always acquire a
+         // reference on `PidNamespace` and will return an `Option` to force the caller to
+         // explicitly handle the case where `PidNamespace` is `None`, something that tends to be
+         // forgotten when doing the equivalent operation in `C`. Missing RCU primitives make it
+         // difficult to perform operations that are otherwise safe without holding a reference
+         // count as long as RCU protection is guaranteed. But it is not important currently. But we
+         // do want it in the future.
+         //
+         // Note for (2) the required RCU protection around calling `task_active_pid_ns()`
+         // synchronizes against putting the last reference of the associated `struct pid` of
+         // `task->thread_pid`. The `struct pid` stored in that field is used to retrieve the
+         // `PidNamespace` of the caller. When `release_task()` is called `task->thread_pid` will be
+         // `NULL`ed and `put_pid()` on said `struct pid` will be delayed in `free_pid()` via
+         // `call_rcu()` allowing everyone with an RCU protected access to the `struct pid` acquired
+         // from `task->thread_pid` to finish.
+         //
+         // SAFETY: The current task's pid namespace is valid as long as the current task is running.
+         let pidns = unsafe { bindings::task_active_pid_ns(Task::current_raw()) };
+         PidNamespaceRef {
+             // SAFETY: If the current thread is still running, the current task and its associated
+             // pid namespace are valid. `PidNamespaceRef` is not `Send`, so we know it cannot be
+             // transferred to another thread (where it could potentially outlive the current
+             // `Task`). The caller needs to ensure that the PidNamespaceRef doesn't outlive the
+             // current task/thread.
+             task: unsafe { PidNamespace::from_ptr(pidns) },
+             _not_send: NotThreadSafe,
+         }
+     }
+
      /// Returns the group leader of the given task.
      pub fn group_leader(&self) -> &Task {
 -        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
 -        // have a valid `group_leader`.
 -        let ptr = unsafe { *ptr::addr_of!((*self.0.get()).group_leader) };
 +        // SAFETY: The group leader of a task never changes after initialization, so reading this
 +        // field is not a data race.
 +        let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };

          // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
          // and given that a task has a reference to its group leader, we know it must be valid for
@@@ -184,15 -280,36 +286,36 @@@

      /// Determines whether the given task has pending signals.
      pub fn signal_pending(&self) -> bool {
 -        // SAFETY: By the type invariant, we know that `self.0` is valid.
 -        unsafe { bindings::signal_pending(self.0.get()) != 0 }
 +        // SAFETY: It's always safe to call `signal_pending` on a valid task.
 +        unsafe { bindings::signal_pending(self.as_ptr()) != 0 }
      }

-     /// Returns the given task's pid in the current pid namespace.
-     pub fn pid_in_current_ns(&self) -> Pid {
-         // SAFETY: It's valid to pass a null pointer as the namespace (defaults to current
-         // namespace). The task pointer is also valid.
-         unsafe { bindings::task_tgid_nr_ns(self.as_ptr(), ptr::null_mut()) }
+     /// Returns task's pid namespace with elevated reference count
+     pub fn get_pid_ns(&self) -> Option<ARef<PidNamespace>> {
+         // SAFETY: By the type invariant, we know that `self.0` is valid.
+         let ptr = unsafe { bindings::task_get_pid_ns(self.0.get()) };
+         if ptr.is_null() {
+             None
+         } else {
+             // SAFETY: `ptr` is valid by the safety requirements of this function. And we own a
+             // reference count via `task_get_pid_ns()`.
+             // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::pid_namespace`.
+             Some(unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr.cast::<PidNamespace>())) })
+         }
+     }
+
+     /// Returns the given task's pid in the provided pid namespace.
+     #[doc(alias = "task_tgid_nr_ns")]
+     pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>) -> Pid {
+         let pidns = match pidns {
+             Some(pidns) => pidns.as_ptr(),
+             None => core::ptr::null_mut(),
+         };
+         // SAFETY: By the type invariant, we know that `self.0` is valid. We received a valid
+         // PidNamespace that we can use as a pointer or we received an empty PidNamespace and
+         // thus pass a null pointer. The underlying C function is safe to be used with NULL
+         // pointers.
+         unsafe { bindings::task_tgid_nr_ns(self.0.get(), pidns) }
      }

      /// Wakes up the task.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 22018a5a54a3d353bf0fee7364b2b8018ed4c5a6:

  rust: add seqfile abstraction (2024-10-08 14:32:39 +0200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.rust.pid_namespace

for you to fetch changes up to e0020ba6cbcbfbaaa50c3d4b610c7caa36459624:

  rust: add PidNamespace (2024-10-08 15:44:36 +0200)

----------------------------------------------------------------
vfs-6.13.rust.pid_namespace

----------------------------------------------------------------
Christian Brauner (1):
      rust: add PidNamespace

 rust/helpers/helpers.c       |   1 +
 rust/helpers/pid_namespace.c |  26 +++++++++
 rust/kernel/lib.rs           |   1 +
 rust/kernel/pid_namespace.rs |  68 ++++++++++++++++++++++
 rust/kernel/task.rs          | 135 +++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 225 insertions(+), 6 deletions(-)
 create mode 100644 rust/helpers/pid_namespace.c
 create mode 100644 rust/kernel/pid_namespace.rs

