Return-Path: <linux-fsdevel+bounces-29998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED74984BBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27151C2296F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B28136E01;
	Tue, 24 Sep 2024 19:45:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F381745;
	Tue, 24 Sep 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207151; cv=none; b=Q463iikwGn0AI00usZcaSqO50ocQ6j7A2SOoNdabsuMTAHE4e+5JrVd1N20brurFrq03dyTp/qTYak08osyNWxymOsVxtT+GDLsEACaRvPl+gpWtpYoVpq/vyHjiu16aSfperYFYZho3ftifewchxM40R1RwfUSC5wIxEh6Pwck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207151; c=relaxed/simple;
	bh=jWKwLv+2J0d1xEdUp2Lmub0PYsRpWtkBQXZQY8Gj50o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiiPyc3j4b+627w0LNDFOuaXiVqNcMMcovtgrNRqLwlqFy+2fQDrUiSOxRPmAd64CMajElFJhdIQXq/Mw0LayKxZ2t8XC2Z3lvY+qehXbzycuU1vVcuUGLf7v56dlPQD58tgZf9QiQiV6XOhIF7JfotfP2Mqk53nMRG8hAY/02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 3618AAED; Tue, 24 Sep 2024 14:45:40 -0500 (CDT)
Date: Tue, 24 Sep 2024 14:45:40 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v10 1/8] rust: types: add `NotThreadSafe`
Message-ID: <20240924194540.GA636453@mail.hallyn.com>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-1-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240915-alice-file-v10-1-88484f7a3dcf@google.com>

On Sun, Sep 15, 2024 at 02:31:27PM +0000, Alice Ryhl wrote:
> This introduces a new marker type for types that shouldn't be thread
> safe. By adding a field of this type to a struct, it becomes non-Send
> and non-Sync, which means that it cannot be accessed in any way from
> threads other than the one it was created on.
> 
> This is useful for APIs that require globals such as `current` to remain
> constant while the value exists.
> 
> We update two existing users in the Kernel to use this helper:
> 
>  * `Task::current()` - moving the return type of this value to a
>    different thread would not be safe as you can no longer be guaranteed
>    that the `current` pointer remains valid.
>  * Lock guards. Mutexes and spinlocks should be unlocked on the same
>    thread as where they were locked, so we enforce this using the Send
>    trait.

Hi,

this sounds useful, however from kernel side when I think thread-safe,
I think must not be used across a sleep.  Would something like ThreadLocked
or LockedToThread make sense?

(I could be way off base here...)

thanks,
-serge

> There are also additional users in later patches of this patchset. See
> [1] and [2] for the discussion that led to the introduction of this
> patch.
> 
> Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me/ [1]
> Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me/ [2]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/lock.rs | 13 +++++++++----
>  rust/kernel/task.rs      | 10 ++++++----
>  rust/kernel/types.rs     | 21 +++++++++++++++++++++
>  3 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f6c34ca4d819..d6e9bab114b8 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -6,8 +6,13 @@
>  //! spinlocks, raw spinlocks) to be provided with minimal effort.
>  
>  use super::LockClassKey;
> -use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
> -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
> +use crate::{
> +    init::PinInit,
> +    pin_init,
> +    str::CStr,
> +    types::{NotThreadSafe, Opaque, ScopeGuard},
> +};
> +use core::{cell::UnsafeCell, marker::PhantomPinned};
>  use macros::pin_data;
>  
>  pub mod mutex;
> @@ -139,7 +144,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
>  pub struct Guard<'a, T: ?Sized, B: Backend> {
>      pub(crate) lock: &'a Lock<T, B>,
>      pub(crate) state: B::GuardState,
> -    _not_send: PhantomData<*mut ()>,
> +    _not_send: NotThreadSafe,
>  }
>  
>  // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
> @@ -191,7 +196,7 @@ pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
>          Self {
>              lock,
>              state,
> -            _not_send: PhantomData,
> +            _not_send: NotThreadSafe,
>          }
>      }
>  }
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 55dff7e088bf..278c623de0c6 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -4,10 +4,12 @@
>  //!
>  //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
>  
> -use crate::types::Opaque;
> +use crate::{
> +    bindings,
> +    types::{NotThreadSafe, Opaque},
> +};
>  use core::{
>      ffi::{c_int, c_long, c_uint},
> -    marker::PhantomData,
>      ops::Deref,
>      ptr,
>  };
> @@ -106,7 +108,7 @@ impl Task {
>      pub unsafe fn current() -> impl Deref<Target = Task> {
>          struct TaskRef<'a> {
>              task: &'a Task,
> -            _not_send: PhantomData<*mut ()>,
> +            _not_send: NotThreadSafe,
>          }
>  
>          impl Deref for TaskRef<'_> {
> @@ -125,7 +127,7 @@ fn deref(&self) -> &Self::Target {
>              // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
>              // (where it could potentially outlive the caller).
>              task: unsafe { &*ptr.cast() },
> -            _not_send: PhantomData,
> +            _not_send: NotThreadSafe,
>          }
>      }
>  
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 9e7ca066355c..3238ffaab031 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -532,3 +532,24 @@ unsafe impl AsBytes for str {}
>  // does not have any uninitialized portions either.
>  unsafe impl<T: AsBytes> AsBytes for [T] {}
>  unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
> +
> +/// Zero-sized type to mark types not [`Send`].
> +///
> +/// Add this type as a field to your struct if your type should not be sent to a different task.
> +/// Since [`Send`] is an auto trait, adding a single field that is `!Send` will ensure that the
> +/// whole type is `!Send`.
> +///
> +/// If a type is `!Send` it is impossible to give control over an instance of the type to another
> +/// task. This is useful to include in types that store or reference task-local information. A file
> +/// descriptor is an example of such task-local information.
> +///
> +/// This type also makes the type `!Sync`, which prevents immutable access to the value from
> +/// several threads in parallel.
> +pub type NotThreadSafe = PhantomData<*mut ()>;
> +
> +/// Used to construct instances of type [`NotThreadSafe`] similar to how `PhantomData` is
> +/// constructed.
> +///
> +/// [`NotThreadSafe`]: type@NotThreadSafe
> +#[allow(non_upper_case_globals)]
> +pub const NotThreadSafe: NotThreadSafe = PhantomData;
> 
> -- 
> 2.46.0.662.g92d0881bb0-goog

