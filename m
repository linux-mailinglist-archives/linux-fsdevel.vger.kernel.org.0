Return-Path: <linux-fsdevel+bounces-24250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3CB93C44C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B884B20B30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9CC19D069;
	Thu, 25 Jul 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rmmqq1Ci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF513DDB8;
	Thu, 25 Jul 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918255; cv=none; b=tE37Oo5cF8mttBCDIjTJgSDzTNiY5U6jDu1/XylqipaCX1JTIaSw1el80ikQ/CkM1PZ440+HIcjZ3bj9jRH81zDBx0F1pupiWvj/npPivoR54CfmIWqptV14nt1iS+oAgv6FjEUmDSJAQK5LPC+h5cxhzuixNikkdC6UGk5259I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918255; c=relaxed/simple;
	bh=jsKLe1xfJkO7kNI862YjLgzfKiNT8Bh+4bl/90ow/D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn1jZMjGbLqc+dXUZRecRQ0B0P4+HnaPooPc/cejT6oEyS2ZJQ4W5K2lwT5a5BadtRw0rdgrZ5JWA2TBxO/UjG9poHp9Wmj7yLbMCjrptH+w4eIruFLtF+2wE97GZ+9Odt+FWLc0NNPDDifUoqZm5N+PVjVXy/7XoC2AAGuyhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rmmqq1Ci; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=L7B4J3xfdz2Y6tZKoIVkSSXHyah9IYkeN+4fghJY3iE=; b=Rmmqq1CiqxGeNspuQMxERRfFPc
	OTR5qILQnYfTfksJ6bzZAIR3nKtqysigmp2T/k/YC6vkAaL9+HNhGQTQvCDKTCx9mKJOgN7OfX1ve
	ebin00wmz2oSg8PLZJJtfeu8xEM6GtEwaPE2y2gk8rcl8970cMd7qTF1riN1uZ4mGPV2fS1Hom9FV
	8PrhpUtOZYRHRyt8FqYG21dYJFOQufMAY0T1+Y7qoBBgKEUeW9Sp/qbFZ/QtWMGMMdd6bc0ahYBed
	gBJOUgLTq3deARf0t4MlOP/HadV00aoqgG43YJakBS4NHTwt3DcoyowogJBPHjwVFs2eb+IOKCUeP
	wRJjO5sA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWzam-0000000914G-2mCn;
	Thu, 25 Jul 2024 14:37:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 939F630037B; Thu, 25 Jul 2024 16:37:14 +0200 (CEST)
Date: Thu, 25 Jul 2024 16:37:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
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
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v8 1/8] rust: types: add `NotThreadSafe`
Message-ID: <20240725143714.GI13387@noisy.programming.kicks-ass.net>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
 <20240725-alice-file-v8-1-55a2e80deaa8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725-alice-file-v8-1-55a2e80deaa8@google.com>

On Thu, Jul 25, 2024 at 02:27:34PM +0000, Alice Ryhl wrote:
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
> 
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

As per always for not being able to read rust; how does this extend to
get_task_struct()? Once you've taken a reference on current, you should
be free to pass it along to whomever.

