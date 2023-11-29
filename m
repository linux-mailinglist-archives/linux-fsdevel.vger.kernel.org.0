Return-Path: <linux-fsdevel+bounces-4222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DFA7FDD59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D881C20995
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C83B78E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCZSiTDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896837159;
	Wed, 29 Nov 2023 16:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81749C433C7;
	Wed, 29 Nov 2023 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701275316;
	bh=f7sE6c3E0+0jgF8zsKAYtcZCuTU2f+uzjGyuSGgxOH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCZSiTDyQ0iGnQdck4efPrXzsrTNKQ1H5tPeHWVoTCbRQyL/EbNmuDQBZ+Iuvh0q2
	 N71o3u6LZCemEAXckzdwbTOXYeI3tlqmGDPWdj8dwykxjB3XybyamPa6GvgoMChY6K
	 Zved9ThdmAgbDcIyagmjEqFxa/fQepqmwYsXDv4oTvb6CKfkxSJ62gfz5L/BDM2xg1
	 3zdsGc0d0a6XImk+sTE0NK3Az6CuEgciGsdz5NePmr4QKF9ToPhzRqKG1pawRYohhM
	 xTZLiKLUX82Ln4v6koKdpxuIfbT/ePxyU/D0QIbV2QrfLTD96mKFFK/rik8svYPgKI
	 fHzU9gTJ6mZBA==
Date: Wed, 29 Nov 2023 17:28:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231129-etappen-knapp-08e2e3af539f@brauner>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-alice-file-v1-5-f81afe8c7261@google.com>

On Wed, Nov 29, 2023 at 01:12:17PM +0000, Alice Ryhl wrote:
> Adds a wrapper around `kuid_t` called `Kuid`. This allows us to define
> various operations on kuids such as equality and current_euid. It also
> lets us provide conversions from kuid into userspace values.
> 
> Rust Binder needs these operations because it needs to compare kuids for
> equality, and it needs to tell userspace about the pid and uid of
> incoming transactions.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers.c                  | 45 ++++++++++++++++++++++++++
>  rust/kernel/cred.rs             |  5 +--
>  rust/kernel/task.rs             | 71 ++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 119 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 81b13a953eae..700f01840188 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>  #include <linux/errname.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/pid_namespace.h>
>  #include <linux/security.h>
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index fd633d9db79a..58e3a9dff349 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>  
> +kuid_t rust_helper_task_uid(struct task_struct *task)
> +{
> +	return task_uid(task);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_task_uid);
> +
> +kuid_t rust_helper_task_euid(struct task_struct *task)
> +{
> +	return task_euid(task);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_task_euid);
> +
> +#ifndef CONFIG_USER_NS
> +uid_t rust_helper_from_kuid(struct user_namespace *to, kuid_t uid)
> +{
> +	return from_kuid(to, uid);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_from_kuid);
> +#endif /* CONFIG_USER_NS */
> +
> +bool rust_helper_uid_eq(kuid_t left, kuid_t right)
> +{
> +	return uid_eq(left, right);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_uid_eq);
> +
> +kuid_t rust_helper_current_euid(void)
> +{
> +	return current_euid();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_current_euid);
> +
> +struct user_namespace *rust_helper_current_user_ns(void)
> +{
> +	return current_user_ns();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_current_user_ns);
> +
> +pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
> +				  struct pid_namespace *ns)
> +{
> +	return task_tgid_nr_ns(tsk, ns);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_task_tgid_nr_ns);

I'm a bit puzzled by all these rust_helper_*() calls. Can you explain
why they are needed? Because they are/can be static inlines and that
somehow doesn't work?

> +
>  struct kunit *rust_helper_kunit_get_current_test(void)
>  {
>  	return kunit_get_current_test();
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
> index 3794937b5294..fbc749788bfa 100644
> --- a/rust/kernel/cred.rs
> +++ b/rust/kernel/cred.rs
> @@ -8,6 +8,7 @@
>  
>  use crate::{
>      bindings,
> +    task::Kuid,
>      types::{AlwaysRefCounted, Opaque},
>  };
>  
> @@ -52,9 +53,9 @@ pub fn get_secid(&self) -> u32 {
>      }
>  
>      /// Returns the effective UID of the given credential.
> -    pub fn euid(&self) -> bindings::kuid_t {
> +    pub fn euid(&self) -> Kuid {
>          // SAFETY: By the type invariant, we know that `self.0` is valid.
> -        unsafe { (*self.0.get()).euid }
> +        Kuid::from_raw(unsafe { (*self.0.get()).euid })
>      }
>  }
>  
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index b2299bc7ac1f..1a27b968a907 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -5,7 +5,12 @@
>  //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
>  
>  use crate::{bindings, types::Opaque};
> -use core::{marker::PhantomData, ops::Deref, ptr};
> +use core::{
> +    cmp::{Eq, PartialEq},
> +    marker::PhantomData,
> +    ops::Deref,
> +    ptr,
> +};
>  
>  /// Returns the currently running task.
>  #[macro_export]
> @@ -78,6 +83,12 @@ unsafe impl Sync for Task {}
>  /// The type of process identifiers (PIDs).
>  type Pid = bindings::pid_t;
>  
> +/// The type of user identifiers (UIDs).
> +#[derive(Copy, Clone)]
> +pub struct Kuid {
> +    kuid: bindings::kuid_t,
> +}
> +
>  impl Task {
>      /// Returns a task reference for the currently executing task/thread.
>      ///
> @@ -132,12 +143,34 @@ pub fn pid(&self) -> Pid {
>          unsafe { *ptr::addr_of!((*self.0.get()).pid) }
>      }
>  
> +    /// Returns the UID of the given task.
> +    pub fn uid(&self) -> Kuid {
> +        // SAFETY: By the type invariant, we know that `self.0` is valid.
> +        Kuid::from_raw(unsafe { bindings::task_uid(self.0.get()) })
> +    }
> +
> +    /// Returns the effective UID of the given task.
> +    pub fn euid(&self) -> Kuid {
> +        // SAFETY: By the type invariant, we know that `self.0` is valid.
> +        Kuid::from_raw(unsafe { bindings::task_euid(self.0.get()) })
> +    }
> +
>      /// Determines whether the given task has pending signals.
>      pub fn signal_pending(&self) -> bool {
>          // SAFETY: By the type invariant, we know that `self.0` is valid.
>          unsafe { bindings::signal_pending(self.0.get()) != 0 }
>      }
>  
> +    /// Returns the given task's pid in the current pid namespace.
> +    pub fn pid_in_current_ns(&self) -> Pid {
> +        // SAFETY: We know that `self.0.get()` is valid by the type invariant. The rest is just FFI
> +        // calls.
> +        unsafe {
> +            let namespace = bindings::task_active_pid_ns(bindings::get_current());
> +            bindings::task_tgid_nr_ns(self.0.get(), namespace)
> +        }
> +    }
> +
>      /// Wakes up the task.
>      pub fn wake_up(&self) {
>          // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
> @@ -147,6 +180,42 @@ pub fn wake_up(&self) {
>      }
>  }
>  
> +impl Kuid {
> +    /// Get the current euid.
> +    pub fn current_euid() -> Kuid {
> +        // SAFETY: Just an FFI call.
> +        Self {
> +            kuid: unsafe { bindings::current_euid() },
> +        }
> +    }
> +
> +    /// Create a `Kuid` given the raw C type.
> +    pub fn from_raw(kuid: bindings::kuid_t) -> Self {
> +        Self { kuid }
> +    }
> +
> +    /// Turn this kuid into the raw C type.
> +    pub fn into_raw(self) -> bindings::kuid_t {
> +        self.kuid
> +    }
> +
> +    /// Converts this kernel UID into a UID that userspace understands. Uses the namespace of the
> +    /// current task.
> +    pub fn into_uid_in_current_ns(self) -> bindings::uid_t {

Hm, I wouldn't special-case this. Just expose from_kuid() and let it
take a namespace argument, no? You don't need to provide bindings for
namespaces ofc.

> +        // SAFETY: Just an FFI call.
> +        unsafe { bindings::from_kuid(bindings::current_user_ns(), self.kuid) }
> +    }
> +}
> +
> +impl PartialEq for Kuid {
> +    fn eq(&self, other: &Kuid) -> bool {
> +        // SAFETY: Just an FFI call.
> +        unsafe { bindings::uid_eq(self.kuid, other.kuid) }
> +    }
> +}
> +
> +impl Eq for Kuid {}

Do you need that?

> +
>  // SAFETY: The type invariants guarantee that `Task` is always ref-counted.
>  unsafe impl crate::types::AlwaysRefCounted for Task {
>      fn inc_ref(&self) {
> 
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 

