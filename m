Return-Path: <linux-fsdevel+bounces-23146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC24927A95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 17:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E161F26D71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9111B1433;
	Thu,  4 Jul 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="s37utGms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745C1ACE67
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108554; cv=none; b=tgn7HwVpufdvCG7MOt5QLFNW2ermBYd6QfRSpe9xNdNB9vqrT7Dd/xFamX8OaCt8KeS3b/kKPNcaOiR6RJMRXmzDJAokxHR7wow97Qu1Vm43EWmZ7RNJ4uvcAzDi3Jl5aotx2wJS1EAPzYBM2nUg4KkSyhp2EeaKut5+xsfwSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108554; c=relaxed/simple;
	bh=NQBXm07UgisIZcKAKlLXrr/ih/lhjv1PKO0rzT0aANo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHFDIzomNV0MX7TJRUeLrNnulyYm+Ajh88sIBCMl5oG4Z4jQv4BoJF8pdyyE5Vn2CyLXMuHlEfJJsAwgKGKLapEh+VnaZooNx84UvOtahl6WAQAV8KeRyAfgCmrCcCSs1FgtWV0WzcxdyuJin0BUVOl2uzIt/xNz6qojduue5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=s37utGms; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1720108544; x=1720367744;
	bh=Vf4EBtRpfOHSJIVm4HDyh243ysNrpJBCZq4+gPHvMd4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=s37utGmsss6uYVMBve8RQDmW6zdTAvNMYJlSxy08MuzSzWOiDQfQtzHFfK24z6aaN
	 00NDFx/gVvZO3EBvPgrZ/8A4K3h8QS16ekEZDoOfFqMdoCZ0SGoUZLcPsD5ZEs1HMf
	 SO8wkm0IL/qLTqUsPzh/mZk1LHV5rOviwESptHlO3iBoorud4FwMz4oEjQkuqQHZMC
	 73yBxgM35/Me6HNOKXdQ0g6bZ97BhOQkQzb4eWu/FttbmfzU4NpaHM2E96B6pOi6U7
	 TxCUhzSf0o6xxJuyKCVReGiIk4hB9LnX5LHdfE3v1QKvVSSvwP/vT1Og0splqw2CZi
	 6MNivvW0e4jVg==
Date: Thu, 04 Jul 2024 15:55:37 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, Martin Rodriguez
	Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v7 1/8] rust: types: add `NotThreadSafe`
Message-ID: <0GQUdWtJ1sJSw0JSoR4NqDUt9vO2S3G9Y2JqaHX_8BW5O0FB3lfHXwC1mbYNgSBh4t1MIFFyocJGyKUgB7CnJsZK_TvRnL1R61TOsLV1gb0=@protonmail.com>
In-Reply-To: <20240628-alice-file-v7-1-4d701f6335f3@google.com>
References: <20240628-alice-file-v7-0-4d701f6335f3@google.com> <20240628-alice-file-v7-1-4d701f6335f3@google.com>
Feedback-ID: 27884398:user:proton
X-Pm-Message-ID: a9fcff4144967cc27072678e1f6fdc577680704a
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> This introduces a new marker type for types that shouldn't be thread
> safe. By adding a field of this type to a struct, it becomes non-Send
> and non-Sync, which means that it cannot be accessed in any way from
> threads other than the one it was created on.
>=20
> This is useful for APIs that require globals such as `current` to remain
> constant while the value exists.
>=20
> We update two existing users in the Kernel to use this helper:
>=20
>  * `Task::current()` - moving the return type of this value to a
>    different thread would not be safe as you can no longer be guaranteed
>    that the `current` pointer remains valid.
>  * Lock guards. Mutexes and spinlocks should be unlocked on the same
>    thread as where they were locked, so we enforce this using the Send
>    trait.
>=20
> There are also additional users in later patches of this patchset. See
> [1] and [2] for the discussion that led to the introduction of this
> patch.
>=20
> Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQf=
WIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=3D@pro=
ton.me/ [1]
> Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQf=
WIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=3D@pro=
ton.me/ [2]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/lock.rs | 13 +++++++++----
>  rust/kernel/task.rs      | 10 ++++++----
>  rust/kernel/types.rs     | 18 ++++++++++++++++++
>  3 files changed, 33 insertions(+), 8 deletions(-)
>=20
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f6c34ca4d819..d6e9bab114b8 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -6,8 +6,13 @@
>  //! spinlocks, raw spinlocks) to be provided with minimal effort.
>=20
>  use super::LockClassKey;
> -use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::Sc=
opeGuard};
> -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned}=
;
> +use crate::{
> +    init::PinInit,
> +    pin_init,
> +    str::CStr,
> +    types::{NotThreadSafe, Opaque, ScopeGuard},
> +};
> +use core::{cell::UnsafeCell, marker::PhantomPinned};
>  use macros::pin_data;
>=20
>  pub mod mutex;
> @@ -139,7 +144,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
>  pub struct Guard<'a, T: ?Sized, B: Backend> {
>      pub(crate) lock: &'a Lock<T, B>,
>      pub(crate) state: B::GuardState,
> -    _not_send: PhantomData<*mut ()>,
> +    _not_send: NotThreadSafe,
>  }
>=20
>  // SAFETY: `Guard` is sync when the data protected by the lock is also s=
ync.
> @@ -191,7 +196,7 @@ pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state:=
 B::GuardState) -> Self {
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
>=20
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
>      pub unsafe fn current() -> impl Deref<Target =3D Task> {
>          struct TaskRef<'a> {
>              task: &'a Task,
> -            _not_send: PhantomData<*mut ()>,
> +            _not_send: NotThreadSafe,
>          }
>=20
>          impl Deref for TaskRef<'_> {
> @@ -125,7 +127,7 @@ fn deref(&self) -> &Self::Target {
>              // that `TaskRef` is not `Send`, we know it cannot be transf=
erred to another thread
>              // (where it could potentially outlive the caller).
>              task: unsafe { &*ptr.cast() },
> -            _not_send: PhantomData,
> +            _not_send: NotThreadSafe,
>          }
>      }
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 2e7c9008621f..93734677cfe7 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -409,3 +409,21 @@ pub enum Either<L, R> {
>      /// Constructs an instance of [`Either`] containing a value of type =
`R`.
>      Right(R),
>  }
> +
> +/// Zero-sized type to mark types not [`Send`].
> +///
> +/// Add this type as a field to your struct if your type should not be s=
ent to a different task.
> +/// Since [`Send`] is an auto trait, adding a single field that is `!Sen=
d` will ensure that the
> +/// whole type is `!Send`.
> +///
> +/// If a type is `!Send` it is impossible to give control over an instan=
ce of the type to another
> +/// task. This is useful to include in types that store or reference tas=
k-local information. A file
> +/// descriptor is an example of such task-local information.
> +pub type NotThreadSafe =3D PhantomData<*mut ()>;

This also makes the type not Sync. For mutex guards it should be fine to
be Sync if the wrapped type is Sync. Mutex guards not being Sync is
pre-existing, so not something to fix in this patch. NotThreadSafe should
probably document that it also markes a type as not Sync though.

(For those not familiar with the difference, Send indicates that ownership
of a value can be transferred to another thread, while Sync indicates that
a value can be accessed from another thread through a shared reference,
but not necessarily dropped from said thread.)

Having a dedicated type for this makes things clearer.

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
with the docs updated to mention Sync.

> +
> +/// Used to construct instances of type [`NotThreadSafe`] similar to how=
 `PhantomData` is
> +/// constructed.
> +///
> +/// [`NotThreadSafe`]: type@NotThreadSafe
> +#[allow(non_upper_case_globals)]
> +pub const NotThreadSafe: NotThreadSafe =3D PhantomData;
>=20
> --
> 2.45.2.803.g4e1b14247a-goog

