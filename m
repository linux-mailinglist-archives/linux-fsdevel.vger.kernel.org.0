Return-Path: <linux-fsdevel+bounces-37141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA2B9EE492
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 11:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF432282199
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 10:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6FC20B7F3;
	Thu, 12 Dec 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjzg3Wwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82789211470
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001043; cv=none; b=Ppm9Zb3hm3EfnFD71IqWBRxNm7j3ZhKBEELjlm78HCOuuALqniqDGHwOXuBJ+S+g1DxKlA4qHDYP9LLD9jjfI7L3ZW5btzXTvuUEbvycp4WGBwo5N7iGNRXUaT3ahvQMjUp4g6FT0lcJSwXEvRNc9wFGZRJmnnZqXS6/+87Yuno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001043; c=relaxed/simple;
	bh=kqBUJ8IPpYiBbYCDOw8RwS8+Bzk5ezNTinE0/3ra3mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyuGkahKJ/sSjRGvH9HdugZ8mGuKr7RSsJ+d1HdTPZBYEsM+aFpWASKuGTJp45ClrQRpmKu5XMwN4aQ3QHbyKVgb2GlX6Z0+lCbq3LWszbs+wlzEObMtut25466eKQW2TIQNgxXQPZdXL8ygr49Z3bBoo38vTfye2Phn7wr4Tfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjzg3Wwp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43621d27adeso3070545e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 02:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734001040; x=1734605840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUiEBGB8D7hAwnj+8uVhyxIlvzxjn3i3l3epEyBue2E=;
        b=sjzg3Wwp21DELtHkEp7dUhxLE5XJ/OvYDLlEADoyM+vKxOPPkMzVBFgKoaNN11A5Nm
         iCNB8U8PaBfu3d2985BS3j8N2xQSBTb1LE/tantaPX+ULPq7aVJTLRynxjyeiRD/Wqrj
         24o/ZjRqDKBtskXfiZk3q2HHfcgXlxRAPy/QprTtf50fbn+gQfYu18LRR1JYZFZiZt8i
         2jNqzseXRLYZhJYWHaxGh49ZYPG7Duwf5mNVd6TwMYLbEjzOdY8fTAkLWMBZ3h/T8tG6
         29tkUg7PWNs8QqEVNrhpOaifd32wOSMhD/06sHJB9mOCyjD7c7C5RG1wEt6sOHJpxVPv
         drpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001040; x=1734605840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUiEBGB8D7hAwnj+8uVhyxIlvzxjn3i3l3epEyBue2E=;
        b=sCd7bAa6Hju+BaY8LHkXAyppTFb0OUIA709ODa+33BPylf665mgz77V+ISwshBtHO6
         BOy5Q8eB6jsljtgM0xBeUUtrWZMK2tCpEJ+UQRcy+XnypzVWdQnZ+aGBDvWe+PZIfTE3
         FEPjYZ39YWVACGIouhtJvAEgOk3fqYoY9+ZyLQtHaK1dsrjdMKLvKl54LAoVLva0lR5L
         xqDIViSMD5qJNpFLuCLkzv+CSBoZZjXv2ozNh3KrwV+eXlMoFIPxWESoi4m0fKVQX+PE
         OJXx+MuDmI9kZ81HZEkc68+vJLW7qOM6+81OelaQConxAEEWkiZlZnbRWj3ngpY2Oy+E
         dlng==
X-Forwarded-Encrypted: i=1; AJvYcCVCP1beSlZ7C8ZINrGkCmPQ0WDcOe7oFxNCNUWE+hop2K48s0mNE4N3L3+trXyRjyOKxNzLLQHYYyjhwGJX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/iP045/3gFlb6Ug30CX6PRuz2vv0O1qFT86Bh4NKfQowcL8ml
	T7/vA7DdwQ615LOliGoJSI8KdT0HTUCD+hXP+fayC0C6Xtbd5iwEfsji9foqQD/khGPB8dhvOjd
	dqpehFZVUbdqPtjGbZlGvXnnN0NKTngHF0Pwo
X-Gm-Gg: ASbGncsJ8Pjfa+x1vYKgh95vAJ18KTcwHxzrTC1jHe1EllGsJxTSVME2QlplHI+opn8
	Ppv65aiHXO+ygDwLCcm2flB1zTTvtWESi9RF9FyGTGLEkVPh9yq8RhVmMvThTRGhtljCJ
X-Google-Smtp-Source: AGHT+IHao6ALD1+VhVR0D58hFf3KnDqeXTc7Koyx+3Ol/K2l0atIxOkHH+dbWo1PI+coepznjWTr/tJZvfMwOeTN9CI=
X-Received: by 2002:a05:6000:1887:b0:385:ef2f:9282 with SMTP id
 ffacd0b85a97d-3864ce4afa3mr4605808f8f.5.1734001039648; Thu, 12 Dec 2024
 02:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101060237.1185533-1-boqun.feng@gmail.com> <20241101060237.1185533-5-boqun.feng@gmail.com>
In-Reply-To: <20241101060237.1185533-5-boqun.feng@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 12 Dec 2024 11:57:07 +0100
Message-ID: <CAH5fLgjhQouU=kqVx7LET2yeWt6sKt-VO5PR5SnQ8doaG4ihuQ@mail.gmail.com>
Subject: Re: [RFC v2 04/13] rust: sync: atomic: Add generic atomics
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, lkmm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Trevor Gross <tmgross@umich.edu>, dakr@redhat.com, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:03=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
> added, currently `T` needs to be Send + Copy because these are the
> straightforward usages and all basic types support this. The trait
> `AllowAtomic` should be only ipmlemented inside atomic mod until the
> generic atomic framework is mature enough (unless the ipmlementer is a
> `#[repr(transparent)]` new type).
>
> `AtomicIpml` types are automatically `AllowAtomic`, and so far only
> basic operations load() and store() are introduced.

The ipml typo continues in this patch.

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic.rs         |   2 +
>  rust/kernel/sync/atomic/generic.rs | 253 +++++++++++++++++++++++++++++
>  2 files changed, 255 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/generic.rs
>
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index be2e8583595f..b791abc59b61 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -16,7 +16,9 @@
>  //!
>  //! [`LKMM`]: srctree/tools/memory-mode/
>
> +pub mod generic;
>  pub mod ops;
>  pub mod ordering;
>
> +pub use generic::Atomic;
>  pub use ordering::{Acquire, Full, Relaxed, Release};
> diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic=
/generic.rs
> new file mode 100644
> index 000000000000..204da38e2691
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic atomic primitives.
> +
> +use super::ops::*;
> +use super::ordering::*;
> +use crate::types::Opaque;
> +
> +/// A generic atomic variable.
> +///
> +/// `T` must impl [`AllowAtomic`], that is, an [`AtomicImpl`] has to be =
chosen.
> +///
> +/// # Invariants
> +///
> +/// Doing an atomic operation while holding a reference of [`Self`] won'=
t cause a data race, this
> +/// is guaranteed by the safety requirement of [`Self::from_ptr`] and th=
e extra safety requirement
> +/// of the usage on pointers returned by [`Self::as_ptr`].
> +#[repr(transparent)]
> +pub struct Atomic<T: AllowAtomic>(Opaque<T>);
> +
> +// SAFETY: `Atomic<T>` is safe to share among execution contexts because=
 all accesses are atomic.
> +unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}

Surely it should also be Send?

> +/// Atomics that support basic atomic operations.
> +///
> +/// TODO: Unless the `impl` is a `#[repr(transparet)]` new type of an ex=
isting [`AllowAtomic`], the
> +/// impl block should be only done in atomic mod. And currently only bas=
ic integer types can
> +/// implement this trait in atomic mod.

What's up with this TODO? Can't you just write an appropriate safety
requirement?

> +/// # Safety
> +///
> +/// [`Self`] must have the same size and alignment as [`Self::Repr`].
> +pub unsafe trait AllowAtomic: Sized + Send + Copy {
> +    /// The backing atomic implementation type.
> +    type Repr: AtomicImpl;
> +
> +    /// Converts into a [`Self::Repr`].
> +    fn into_repr(self) -> Self::Repr;
> +
> +    /// Converts from a [`Self::Repr`].
> +    fn from_repr(repr: Self::Repr) -> Self;

What do you need these methods for?

> +}
> +
> +// SAFETY: `T::Repr` is `Self` (i.e. `T`), so they have the same size an=
d alignment.
> +unsafe impl<T: AtomicImpl> AllowAtomic for T {
> +    type Repr =3D Self;
> +
> +    fn into_repr(self) -> Self::Repr {
> +        self
> +    }
> +
> +    fn from_repr(repr: Self::Repr) -> Self {
> +        repr
> +    }
> +}
> +
> +impl<T: AllowAtomic> Atomic<T> {
> +    /// Creates a new atomic.
> +    pub const fn new(v: T) -> Self {
> +        Self(Opaque::new(v))
> +    }
> +
> +    /// Creates a reference to [`Self`] from a pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `ptr` has to be a valid pointer.
> +    /// - `ptr` has to be valid for both reads and writes for the whole =
lifetime `'a`.
> +    /// - For the whole lifetime of '`a`, other accesses to the object c=
annot cause data races
> +    ///   (defined by [`LKMM`]) against atomic operations on the returne=
d reference.
> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    ///
> +    /// # Examples
> +    ///
> +    /// Using [`Atomic::from_ptr()`] combined with [`Atomic::load()`] or=
 [`Atomic::store()`] can
> +    /// achieve the same functionality as `READ_ONCE()`/`smp_load_acquir=
e()` or
> +    /// `WRITE_ONCE()`/`smp_store_release()` in C side:
> +    ///
> +    /// ```rust
> +    /// # use kernel::types::Opaque;
> +    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
> +    ///
> +    /// // Assume there is a C struct `Foo`.
> +    /// mod cbindings {
> +    ///     #[repr(C)]
> +    ///     pub(crate) struct foo { pub(crate) a: i32, pub(crate) b: i32=
 }
> +    /// }
> +    ///
> +    /// let tmp =3D Opaque::new(cbindings::foo { a: 1, b: 2});
> +    ///
> +    /// // struct foo *foo_ptr =3D ..;
> +    /// let foo_ptr =3D tmp.get();
> +    ///
> +    /// // SAFETY: `foo_ptr` is a valid pointer, and `.a` is inbound.
> +    /// let foo_a_ptr =3D unsafe { core::ptr::addr_of_mut!((*foo_ptr).a)=
 };
> +    ///
> +    /// // a =3D READ_ONCE(foo_ptr->a);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is a valid pointer for read, and all acce=
sses on it is atomic, so no
> +    /// // data race.
> +    /// let a =3D unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
> +    /// # assert_eq!(a, 1);
> +    ///
> +    /// // smp_store_release(&foo_ptr->a, 2);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is a valid pointer for write, and all acc=
esses on it is atomic, so no
> +    /// // data race.
> +    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
> +    /// ```
> +    ///
> +    /// However, this should be only used when communicating with C side=
 or manipulating a C struct.
> +    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
> +    where
> +        T: Sync,
> +    {
> +        // CAST: `T` is transparent to `Atomic<T>`.
> +        // SAFETY: Per function safety requirement, `ptr` is a valid poi=
nter and the object will
> +        // live long enough. It's safe to return a `&Atomic<T>` because =
function safety requirement
> +        // guarantees other accesses won't cause data races.
> +        unsafe { &*ptr.cast::<Self>() }
> +    }
> +
> +    /// Returns a pointer to the underlying atomic variable.
> +    ///
> +    /// Extra safety requirement on using the return pointer: the operat=
ions done via the pointer
> +    /// cannot cause data races defined by [`LKMM`].
> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    pub const fn as_ptr(&self) -> *mut T {
> +        self.0.get()
> +    }
> +
> +    /// Returns a mutable reference to the underlying atomic variable.
> +    ///
> +    /// This is safe because the mutable reference of the atomic variabl=
e guarantees the exclusive
> +    /// access.
> +    pub fn get_mut(&mut self) -> &mut T {
> +        // SAFETY: `self.as_ptr()` is a valid pointer to `T`, and the ob=
ject has already been
> +        // initialized. `&mut self` guarantees the exclusive access, so =
it's safe to reborrow
> +        // mutably.
> +        unsafe { &mut *self.as_ptr() }
> +    }
> +}
> +
> +impl<T: AllowAtomic> Atomic<T>
> +where
> +    T::Repr: AtomicHasBasicOps,
> +{
> +    /// Loads the value from the atomic variable.
> +    ///
> +    /// # Examples
> +    ///
> +    /// Simple usages:
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x =3D Atomic::new(42i32);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// let x =3D Atomic::new(42i64);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    /// ```
> +    ///
> +    /// Customized new types in [`Atomic`]:
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{generic::AllowAtomic, Atomic, Relaxed=
};
> +    ///
> +    /// #[derive(Clone, Copy)]
> +    /// #[repr(transparent)]
> +    /// struct NewType(u32);
> +    ///
> +    /// // SAFETY: `NewType` is transparent to `u32`, which has the same=
 size and alignment as
> +    /// // `i32`.
> +    /// unsafe impl AllowAtomic for NewType {
> +    ///     type Repr =3D i32;
> +    ///
> +    ///     fn into_repr(self) -> Self::Repr {
> +    ///         self.0 as i32
> +    ///     }
> +    ///
> +    ///     fn from_repr(repr: Self::Repr) -> Self {
> +    ///         NewType(repr as u32)
> +    ///     }
> +    /// }
> +    ///
> +    /// let n =3D Atomic::new(NewType(0));
> +    ///
> +    /// assert_eq!(0, n.load(Relaxed).0);
> +    /// ```
> +    #[inline(always)]
> +    pub fn load<Ordering: AcquireOrRelaxed>(&self, _: Ordering) -> T {
> +        let a =3D self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_read*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety re=
quirement of `AllocAtomic`,
> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a=
 valid pointer,
> +        //   - per the type invariants, the following atomic operation w=
on't cause data races.
> +        // - For extra safety requirement of usage on pointers returned =
by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        let v =3D unsafe {
> +            if Ordering::IS_RELAXED {
> +                T::Repr::atomic_read(a)
> +            } else {
> +                T::Repr::atomic_read_acquire(a)
> +            }
> +        };
> +
> +        T::from_repr(v)
> +    }
> +
> +    /// Stores a value to the atomic variable.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x =3D Atomic::new(42i32);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// x.store(43, Relaxed);
> +    ///
> +    /// assert_eq!(43, x.load(Relaxed));
> +    /// ```
> +    ///
> +    #[inline(always)]
> +    pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
> +        let v =3D T::into_repr(v);
> +        let a =3D self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_set*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety re=
quirement of `AllocAtomic`,
> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a=
 valid pointer,
> +        //   - per the type invariants, the following atomic operation w=
on't cause data races.
> +        // - For extra safety requirement of usage on pointers returned =
by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        unsafe {
> +            if Ordering::IS_RELAXED {
> +                T::Repr::atomic_set(a, v)
> +            } else {
> +                T::Repr::atomic_set_release(a, v)
> +            }
> +        };
> +    }
> +}
> --
> 2.45.2
>

