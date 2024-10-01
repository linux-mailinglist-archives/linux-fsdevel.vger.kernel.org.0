Return-Path: <linux-fsdevel+bounces-30510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64D98BFB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64891C23FD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0B1C9EAC;
	Tue,  1 Oct 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5QpoU4Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41D1C9DC0;
	Tue,  1 Oct 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792249; cv=none; b=bB8NOonbFEtik1VpVZgPd5BVz6BgGElngxSa5I4Ub25TAJY0aFZbaNh/3pjzPLo8hkQtK4OcTWfDJvpLFJCUMn5RmmM7Mr07b2dlyLZ8qggeyWLzNrG2qljZ3QJVy7uEEMnvHZmiVgtWZwZzu7RePgybsZR9mEwPNCZdTySZRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792249; c=relaxed/simple;
	bh=LxDZDkrgmDWo7qrhRbl0JPaSpU0x3Di3t4XseVep2dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTpPodjURHWI+8jOwHm30j3ph5NWkC3G5R1nV08vRq87ThhVqhxNz5Y2J16gc5lYc5lhzJCRZEkfP70bLlni/q4PUouxB9atudCe1lKTlX+4akiOUTGirOUJz6ZjPmZueA7e3HlNIXkxXyD3LJqo43kTRr2LiFxLyBQVoitEE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5QpoU4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BE2C4CEC6;
	Tue,  1 Oct 2024 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727792249;
	bh=LxDZDkrgmDWo7qrhRbl0JPaSpU0x3Di3t4XseVep2dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5QpoU4ZYGB46IfvkqjL53xN9YfMlv31IyIc3LtEwNBFJRonkqoKJ7MgBedXp8uPV
	 PfWZDbkcqp7qmMnzr+spsDtak348SLYM70iADK6Vm3ywjDgnhCRYINi6RuYEk6iVKa
	 HM/1RpNX9FG+2lMnHmqB1FG/RCyBI1+Bo64FEkpd1GRyh4Yq1Xk74wFbpSwvWJ/uSR
	 QUI3kTtMizZ35edM7v7hwr3UKi9AkQL/Y7EeGbov3aydBJsw8tSiYNOEyMH/PR+l8/
	 pbO90LYL5uYXvCqjSJsVqVZp1XR/EK0s+IbBhwP6CBcFm3Ko8uI+O+HDIz6m/bPoZd
	 DidBu9zbYFaUg==
Date: Tue, 1 Oct 2024 16:17:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Bjoern Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve Hjonnevag <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v2] rust: add PidNamespace
Message-ID: <20241001-sowie-zufall-d1e1421ba00f@brauner>
References: <20240926-pocht-sittlich-87108178c093@brauner>
 <20241001-brauner-rust-pid_namespace-v2-1-37eac8d93e75@kernel.org>
 <CAH5fLghaj+mjL63vw7DKCMg3NSaqU3qwd0byXKksG65mdOA2bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghaj+mjL63vw7DKCMg3NSaqU3qwd0byXKksG65mdOA2bA@mail.gmail.com>

On Tue, Oct 01, 2024 at 12:26:27PM GMT, Alice Ryhl wrote:
> On Tue, Oct 1, 2024 at 11:44 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
> >
> > The `PidNamespace` of a `Task` doesn't ever change once the `Task` is
> > alive. A `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)`
> > will not have an effect on the calling `Task`'s pid namespace. It will
> > only effect the pid namespace of children created by the calling `Task`.
> > This invariant guarantees that after having acquired a reference to a
> > `Task`'s pid namespace it will remain unchanged.
> >
> > When a task has exited and been reaped `release_task()` will be called.
> > This will set the `PidNamespace` of the task to `NULL`. So retrieving
> > the `PidNamespace` of a task that is dead will return `NULL`. Note, that
> > neither holding the RCU lock nor holding a referencing count to the
> > `Task` will prevent `release_task()` being called.
> >
> > In order to retrieve the `PidNamespace` of a `Task` the
> > `task_active_pid_ns()` function can be used. There are two cases to
> > consider:
> >
> > (1) retrieving the `PidNamespace` of the `current` task (2) retrieving
> > the `PidNamespace` of a non-`current` task
> >
> > From system call context retrieving the `PidNamespace` for case (1) is
> > always safe and requires neither RCU locking nor a reference count to be
> > held. Retrieving the `PidNamespace` after `release_task()` for current
> > will return `NULL` but no codepath like that is exposed to Rust.
> >
> > Retrieving the `PidNamespace` from system call context for (2) requires
> > RCU protection. Accessing `PidNamespace` outside of RCU protection
> > requires a reference count that must've been acquired while holding the
> > RCU lock. Note that accessing a non-`current` task means `NULL` can be
> > returned as the non-`current` task could have already passed through
> > `release_task()`.
> >
> > To retrieve (1) the `current_pid_ns!()` macro should be used which
> > ensure that the returned `PidNamespace` cannot outlive the calling
> > scope. The associated `current_pid_ns()` function should not be called
> > directly as it could be abused to created an unbounded lifetime for
> > `PidNamespace`. The `current_pid_ns!()` macro allows Rust to handle the
> > common case of accessing `current`'s `PidNamespace` without RCU
> > protection and without having to acquire a reference count.
> >
> > For (2) the `task_get_pid_ns()` method must be used. This will always
> > acquire a reference on `PidNamespace` and will return an `Option` to
> > force the caller to explicitly handle the case where `PidNamespace` is
> > `None`, something that tends to be forgotten when doing the equivalent
> > operation in `C`. Missing RCU primitives make it difficult to perform
> > operations that are otherwise safe without holding a reference count as
> > long as RCU protection is guaranteed. But it is not important currently.
> > But we do want it in the future.
> >
> > Note for (2) the required RCU protection around calling
> > `task_active_pid_ns()` synchronizes against putting the last reference
> > of the associated `struct pid` of `task->thread_pid`. The `struct pid`
> > stored in that field is used to retrieve the `PidNamespace` of the
> > caller. When `release_task()` is called `task->thread_pid` will be
> > `NULL`ed and `put_pid()` on said `struct pid` will be delayed in
> > `free_pid()` via `call_rcu()` allowing everyone with an RCU protected
> > access to the `struct pid` acquired from `task->thread_pid` to finish.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Overall looks good to me, but a few comments below.
> 
> Also, I think it would be fine to send the next version without it
> being a reply to the file bindings thread.
> 
> >  rust/helpers/helpers.c       |   1 +
> >  rust/helpers/pid_namespace.c |  26 ++++++++++
> >  rust/kernel/lib.rs           |   1 +
> >  rust/kernel/pid_namespace.rs |  70 +++++++++++++++++++++++++
> >  rust/kernel/task.rs          | 119 ++++++++++++++++++++++++++++++++++++++++---
> >  5 files changed, 211 insertions(+), 6 deletions(-)
> >
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 62022b18caf5ec17231fd0e7be1234592d1146e3..d553ad9361ce17950d505c3b372a568730020e2f 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -17,6 +17,7 @@
> >  #include "kunit.c"
> >  #include "mutex.c"
> >  #include "page.c"
> > +#include "pid_namespace.c"
> >  #include "rbtree.c"
> >  #include "refcount.c"
> >  #include "security.c"
> > diff --git a/rust/helpers/pid_namespace.c b/rust/helpers/pid_namespace.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..f41482bdec9a7c4e84b81ec141027fbd65251230
> > --- /dev/null
> > +++ b/rust/helpers/pid_namespace.c
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/pid_namespace.h>
> > +#include <linux/cleanup.h>
> > +
> > +struct pid_namespace *rust_helper_get_pid_ns(struct pid_namespace *ns)
> > +{
> > +       return get_pid_ns(ns);
> > +}
> > +
> > +void rust_helper_put_pid_ns(struct pid_namespace *ns)
> > +{
> > +       put_pid_ns(ns);
> > +}
> > +
> > +/* Get a reference on a task's pid namespace. */
> > +struct pid_namespace *rust_helper_task_get_pid_ns(struct task_struct *task)
> > +{
> > +       struct pid_namespace *pid_ns;
> > +
> > +       guard(rcu)();
> > +       pid_ns = task_active_pid_ns(task);
> > +       if (pid_ns)
> > +               get_pid_ns(pid_ns);
> > +       return pid_ns;
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index ff7d88022c57ca232dc028066dfa062f3fc84d1c..0e78ec9d06e0199dfafc40988a2ae86cd5df949c 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -44,6 +44,7 @@
> >  #[cfg(CONFIG_NET)]
> >  pub mod net;
> >  pub mod page;
> > +pub mod pid_namespace;
> >  pub mod prelude;
> >  pub mod print;
> >  pub mod sizes;
> > diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..9a0509e802b4939ad853a802ee6d069a5f00c9df
> > --- /dev/null
> > +++ b/rust/kernel/pid_namespace.rs
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
> > +
> > +//! Pid namespaces.
> > +//!
> > +//! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pid_namespace.h) and
> > +//! [`include/linux/pid.h`](srctree/include/linux/pid.h)
> > +
> > +use crate::{
> > +    bindings,
> > +    types::{AlwaysRefCounted, Opaque},
> > +};
> > +use core::{
> > +    ptr,
> > +};
> 
> This doesn't pass the rustfmt check.

Ok. Why does it pass the build then? Seems like it should just fail the build.

> 
> $ rustfmt --check rust/kernel/pid_namespace.rs
> Diff in /home/aliceryhl/rust-for-linux/rust/kernel/pid_namespace.rs:11:
>      bindings,
>      types::{AlwaysRefCounted, Opaque},
>  };
> -use core::{
> -    ptr,
> -};
> +use core::ptr;
> 
>  /// Wraps the kernel's `struct pid_namespace`. Thread safe.
>  ///
> 
> > +    /// Returns a PidNamespace reference for the currently executing task's/thread's pid namespace.
> > +    ///
> > +    /// This function can be used to create an unbounded lifetime by e.g., storing the returned
> > +    /// PidNamespace in a global variable which would be a bug. So the recommended way to get the
> > +    /// current task's/thread's pid namespace is to use the [`current_pid_ns`] macro because it is
> > +    /// safe.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that the returned object doesn't outlive the current task/thread.
> > +    pub unsafe fn current_pid_ns() -> impl Deref<Target = PidNamespace> {
> > +        struct PidNamespaceRef<'a> {
> > +            task: &'a PidNamespace,
> > +            _not_send: NotThreadSafe,
> > +        }
> > +
> > +        impl Deref for PidNamespaceRef<'_> {
> > +            type Target = PidNamespace;
> > +
> > +            fn deref(&self) -> &Self::Target {
> > +                self.task
> > +            }
> > +        }
> > +
> > +        let pidns = unsafe { bindings::task_active_pid_ns(Task::current_raw()) };
> > +        PidNamespaceRef {
> > +            // SAFETY: If the current thread is still running, the current task and its associated
> > +            // pid namespace are valid. Given that `PidNamespaceRef` is not `Send`, we know it
> > +            // cannot be transferred to another thread (where it could potentially outlive the
> > +            // current `Task`).
> > +            task: unsafe { &*pidns.cast() },
> 
> This could use `PidNamespace::from_ptr` instead of the cast.

Ok.

> Also, the safety comment about it not being Send seems incomplete. The
> real reason it's okay is that the caller must ensure that the
> PidNamespaceRef doesn't outlive the current task/thread.

Right, but that already documented at the top of the function.

> 
> > +    /// Returns the given task's pid in the provided pid namespace.
> > +    pub fn task_tgid_nr_ns(&self, pidns: &PidNamespace) -> Pid {
> > +        // SAFETY: We know that `self.0.get()` is valid by the type invariant.
> > +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), pidns.as_ptr()) }
> >      }
> 
> The underlying C function accepts null pointers for the namespace. We
> could do the same by accepting `pidns: Option<&PidNamespace>`.

Seems fine.

