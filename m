Return-Path: <linux-fsdevel+bounces-57341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B59B209BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AD8620E91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263332DE6FB;
	Mon, 11 Aug 2025 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5ndaBL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E91DF982;
	Mon, 11 Aug 2025 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917842; cv=none; b=eiEBfV6+XFf67sgCi4mymuk7yeBIV1ioY/gtFmyS6YhiA/lJz+RcD6c0Vtql7v38qYtwRO2E73X3xmbhkOw5k+bbw4xmRXuzd7+kGFVyOmmnP3f4I+0JL3GSQEphp5RPQq+geKt7KEBhXkhB11Dd5TlWkAxrxbejXYQQpwV0568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917842; c=relaxed/simple;
	bh=JqsWD5bk4E8luSPxUqELcm4wL46+4Aq0GhUG2Q2UMM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7TbPrPSheG0NO6MGKZZ3GZ7v+jhuLjol2CriCB0Nx1mekinGOV4/omxrxathtdyrNF9g1FatOjz6u9FFsRcA+Ec01y5XahjPbKQSwFJmnTDiOuiYrAx5HMWkqmVf18eFFDl91mooNgZWGSzNvDASuiv5gZUYmgrg04Xl95bclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5ndaBL/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso36762221fa.3;
        Mon, 11 Aug 2025 06:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754917835; x=1755522635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wjRZSeJyNW+5ttKbH2ZBkdz8rcwxf8fIlvPdNpBzzA=;
        b=K5ndaBL/QW+dPMou3QeOrEZ8Jr+Z1BYGRQUjEyGnv0pbsVaqLAR6U0MMZ6rsfya2RA
         n4+lgd1in9cpKjHCmoSSk3TGV8xgsyJOvLRELan3mfXdTazMItZR/BFiApaKeE/ygmVs
         UB0usNio2yqjiiwq4A31oOsWBTebFXtJiAl1RxsLdPwg796oQ022Dzy9sKxn9al2t0Ov
         jPept44jhso3QOUtaAkdkHS8tKru/tXvwls6dpztQj8Wwz+2iYNtiuPtlqkMR+oFjEFv
         wje/NDwgB9DDVZeS+1cqrrzHrSISeuyfvSOZ0CCYBJt5iU9iauTPd3vl5bm5N2ElFcz5
         2y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917835; x=1755522635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wjRZSeJyNW+5ttKbH2ZBkdz8rcwxf8fIlvPdNpBzzA=;
        b=im2FlLrpeZKh0lgMQwCiuaoo3FHLAtMuA3Inz9XNB73l5VKVJ8B0dY+02iqn+P6kDt
         ozpRilEP+jp158Di7WUmm47fMqulF4lVQssG6DS7Ink23gURdR6nND8LBCwLvaVCjzwP
         Jtz1AX0zioW25ZDNEl/9ZfXHOsnDVpXgfojCCrLjWgtrz2WETG7zM61b1YxOIGxymD5e
         MN9ZX8jYNle80SuSvhMhttpOVaALpw179euenVa6m9BmApcd2kPmlmL3bPSSytf9x07J
         WM4VeI+Zu/9eyJmmlKe5ua0xpfipIxJohzaB3gvH1inhJEwnbPzvESj6dA0LLLysYK4P
         aWKw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Lra65ml1mUJ2PMdGsLOKTEsVZyqh5MU5XiBnMe8YHtdBOWWNhJECmLOo3yX7QL5/P0SRLpAVpXzzRJ0O@vger.kernel.org, AJvYcCVay+Ym329abjTn/D1146mgVZqEcpFQORhywJpwBn6xmiR3AlhM7uXoxpYK6iMsiZV3kKEKG5luQ4btGkKi@vger.kernel.org, AJvYcCXTgdt5P/GcUXkXJBV2rzweUYBWsYwIhlq26UkXWmQyCpJOPwyQy0kxCyRvm2O9/X8zd5YbqWpFHUJsdUh+U/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/o9HMfNeQ9YzdY38JJtlpaq3SR/08MQ+lCoy2IyNDngu+NiEN
	mszVko2vbiPeYV80I7eKDCbZqYiNsTUt3T9nT9a2neDRaCjExzoGEa6k7BZR76bsd4jcFyFZG5p
	Euvl3ofIzPRD3ue/MoztSS2QPonjWzC8=
X-Gm-Gg: ASbGncutAM625UjVRlUhW4p+GbURmYpEAl3FSDHCXGimp74aMTRC5WHv81KY7D08HyK
	ameujSBcff8D1YdfC7yzHXHQSUXt+yH9kqig4dGCoNJjP0jWcXdDrPFNnU3D7BXdUEAVP/EhplI
	EhosLqvwbS10CIw0z3J/DMab9qEkqUb/YsrcGqdmv5Qv4GMGITAoXhK+yiKVSYtPiP0VlSRo32Z
	IhgPZN6
X-Google-Smtp-Source: AGHT+IFhwguXrETFSYk+GfysPq0bG0/CaAaeZ+uytQzxymu/tLCMjbyfNZAPxhd33JJ1OuI89/lKq6V8bKcMzG4UQ/Y=
X-Received: by 2002:a2e:b8d6:0:b0:330:d981:1755 with SMTP id
 38308e7fff4ca-333a210d629mr32639241fa.6.1754917834576; Mon, 11 Aug 2025
 06:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
 <20250713-xarray-insert-reserve-v2-3-b939645808a2@gmail.com> <aJnojv8AWj2isnit@arm.com>
In-Reply-To: <aJnojv8AWj2isnit@arm.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 11 Aug 2025 09:09:56 -0400
X-Gm-Features: Ac12FXxsjq3gMeUfH06sJFBwF4JoZUe97Vj4GSS1AIW6BuPCHKoW2IveFFO1_ac
Message-ID: <CAJ-ks9=BU2jfT-MPzxDcXrZj7uQkKbVm6WhzGiJsM_628b2kmg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rust: xarray: add `insert` and `reserve`
To: Beata Michalska <beata.michalska@arm.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 8:57=E2=80=AFAM Beata Michalska <beata.michalska@ar=
m.com> wrote:
>
> Hi Tamir,
>
> Apologies for such a late drop.

Hi Beata, no worries, thanks for your review.

>
> On Sun, Jul 13, 2025 at 08:05:49AM -0400, Tamir Duberstein wrote:
> > Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, whic=
h
> > are akin to `__xa_{alloc,insert}` in C.
> >
> > Note that unlike `xa_reserve` which only ensures that memory is
> > allocated, the semantics of `Reservation` are stricter and require
> > precise management of the reservation. Indices which have been reserved
> > can still be overwritten with `Guard::store`, which allows for C-like
> > semantics if desired.
> >
> > `__xa_cmpxchg_raw` is exported to facilitate the semantics described
> > above.
> >
> > Tested-by: Janne Grunau <j@jannau.net>
> > Reviewed-by: Janne Grunau <j@jannau.net>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  include/linux/xarray.h |   2 +
> >  lib/xarray.c           |  28 ++-
> >  rust/helpers/xarray.c  |   5 +
> >  rust/kernel/xarray.rs  | 494 +++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  4 files changed, 512 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> > index be850174e802..64f2a5e06ceb 100644
> > --- a/include/linux/xarray.h
> > +++ b/include/linux/xarray.h
> > @@ -563,6 +563,8 @@ void *__xa_erase(struct xarray *, unsigned long ind=
ex);
> >  void *__xa_store(struct xarray *, unsigned long index, void *entry, gf=
p_t);
> >  void *__xa_cmpxchg(struct xarray *, unsigned long index, void *old,
> >               void *entry, gfp_t);
> > +void *__xa_cmpxchg_raw(struct xarray *, unsigned long index, void *old=
,
> > +             void *entry, gfp_t);
> >  int __must_check __xa_insert(struct xarray *, unsigned long index,
> >               void *entry, gfp_t);
> >  int __must_check __xa_alloc(struct xarray *, u32 *id, void *entry,
> > diff --git a/lib/xarray.c b/lib/xarray.c
> > index 76dde3a1cacf..58202b6fbb59 100644
> > --- a/lib/xarray.c
> > +++ b/lib/xarray.c
> > @@ -1738,9 +1738,6 @@ void *xa_store(struct xarray *xa, unsigned long i=
ndex, void *entry, gfp_t gfp)
> >  }
> >  EXPORT_SYMBOL(xa_store);
> >
> > -static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long =
index,
> > -                     void *old, void *entry, gfp_t gfp);
> > -
> >  /**
> >   * __xa_cmpxchg() - Conditionally replace an entry in the XArray.
> >   * @xa: XArray.
> > @@ -1767,7 +1764,29 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned l=
ong index,
> >  }
> >  EXPORT_SYMBOL(__xa_cmpxchg);
> >
> > -static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long =
index,
> > +/**
> > + * __xa_cmpxchg_raw() - Conditionally replace an entry in the XArray.
> > + * @xa: XArray.
> > + * @index: Index into array.
> > + * @old: Old value to test against.
> > + * @entry: New value to place in array.
> > + * @gfp: Memory allocation flags.
> > + *
> > + * You must already be holding the xa_lock when calling this function.
> > + * It will drop the lock if needed to allocate memory, and then reacqu=
ire
> > + * it afterwards.
> > + *
> > + * If the entry at @index is the same as @old, replace it with @entry.
> > + * If the return value is equal to @old, then the exchange was success=
ful.
> > + *
> > + * This function is the same as __xa_cmpxchg() except that it does not=
 coerce
> > + * XA_ZERO_ENTRY to NULL on egress.
> > + *
> > + * Context: Any context.  Expects xa_lock to be held on entry.  May
> > + * release and reacquire xa_lock if @gfp flags permit.
> > + * Return: The old value at this index or xa_err() if an error happene=
d.
> > + */
> > +void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
> >                       void *old, void *entry, gfp_t gfp)
> >  {
> >       XA_STATE(xas, xa, index);
> > @@ -1787,6 +1806,7 @@ static inline void *__xa_cmpxchg_raw(struct xarra=
y *xa, unsigned long index,
> >
> >       return xas_result(&xas, curr);
> >  }
> > +EXPORT_SYMBOL(__xa_cmpxchg_raw);
> >
> >  /**
> >   * __xa_insert() - Store this entry in the XArray if no entry is prese=
nt.
> > diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
> > index 60b299f11451..b6c078e6a343 100644
> > --- a/rust/helpers/xarray.c
> > +++ b/rust/helpers/xarray.c
> > @@ -2,6 +2,11 @@
> >
> >  #include <linux/xarray.h>
> >
> > +void *rust_helper_xa_zero_entry(void)
> > +{
> > +     return XA_ZERO_ENTRY;
> > +}
> > +
> >  int rust_helper_xa_err(void *entry)
> >  {
> >       return xa_err(entry);
> > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > index 101f61c0362d..a43414bb4d7e 100644
> > --- a/rust/kernel/xarray.rs
> > +++ b/rust/kernel/xarray.rs
> > @@ -9,7 +9,12 @@
> >      prelude::*,
> >      types::{ForeignOwnable, NotThreadSafe, Opaque},
> >  };
> > -use core::{iter, marker::PhantomData, mem, ptr::NonNull};
> > +use core::{
> > +    fmt, iter,
> > +    marker::PhantomData,
> > +    mem, ops,
> > +    ptr::{null_mut, NonNull},
> > +};
> >
> >  /// An array which efficiently maps sparse integer indices to owned ob=
jects.
> >  ///
> > @@ -25,29 +30,81 @@
> >  ///
> >  /// ```rust
> >  /// # use kernel::alloc::KBox;
> > -/// # use kernel::xarray::XArray;
> > +/// # use kernel::xarray::{StoreError, XArray};
> >  /// # use pin_init::stack_pin_init;
> >  ///
> >  /// stack_pin_init!(let xa =3D XArray::new(Default::default()));
> >  ///
> >  /// let dead =3D KBox::new(0xdead, GFP_KERNEL)?;
> >  /// let beef =3D KBox::new(0xbeef, GFP_KERNEL)?;
> > +/// let leet =3D KBox::new(0x1337, GFP_KERNEL)?;
> > +///
> > +/// let mut guard =3D xa.lock();
> > +///
> > +/// let index =3D guard.insert_limit(.., dead, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(guard.get(index), Some(&0xdead));
> > +///
> > +/// let beef =3D {
> > +///     let ret =3D guard.insert(index, beef, GFP_KERNEL);
> > +///     assert!(ret.is_err());
> > +///     let StoreError { value, error } =3D ret.unwrap_err();
> > +///     assert_eq!(error, EBUSY);
> > +///     value
> > +/// };
> > +///
> > +/// let reservation =3D guard.reserve_limit(.., GFP_KERNEL);
> > +/// assert!(reservation.is_ok());
> > +/// let reservation1 =3D reservation.unwrap();
> > +/// let reservation =3D guard.reserve_limit(.., GFP_KERNEL);
> > +/// assert!(reservation.is_ok());
> > +/// let reservation2 =3D reservation.unwrap();
> > +///
> > +/// assert_eq!(reservation1.index(), index + 1);
> > +/// assert_eq!(reservation2.index(), index + 2);
> > +///
> > +/// let dead =3D {
> > +///     let ret =3D guard.remove(index);
> > +///     assert!(ret.is_some());
> > +///     ret.unwrap()
> > +/// };
> > +/// assert_eq!(*dead, 0xdead);
> > +///
> > +/// drop(guard); // Reservations can outlive the guard.
> > +///
> > +/// let () =3D reservation1.fill(dead)?;
> > +///
> > +/// let index =3D reservation2.index();
> >  ///
> >  /// let mut guard =3D xa.lock();
> >  ///
> > -/// assert_eq!(guard.get(0), None);
> > +/// let beef =3D {
> > +///     let ret =3D guard.insert(index, beef, GFP_KERNEL);
> > +///     assert!(ret.is_err());
> > +///     let StoreError { value, error } =3D ret.unwrap_err();
> > +///     assert_eq!(error, EBUSY);
> > +///     value
> > +/// };
> >  ///
> > -/// assert_eq!(guard.store(0, dead, GFP_KERNEL)?.as_deref(), None);
> > -/// assert_eq!(guard.get(0).copied(), Some(0xdead));
> > +/// // `store` ignores reservations.
> > +/// {
> > +///    let ret =3D guard.store(index, beef, GFP_KERNEL);
> > +///    assert!(ret.is_ok());
> > +///    assert_eq!(ret.unwrap().as_deref(), None);
> > +/// }
> >  ///
> > -/// *guard.get_mut(0).unwrap() =3D 0xffff;
> > -/// assert_eq!(guard.get(0).copied(), Some(0xffff));
> > +/// assert_eq!(guard.get(index), Some(&0xbeef));
> >  ///
> > -/// assert_eq!(guard.store(0, beef, GFP_KERNEL)?.as_deref().copied(), =
Some(0xffff));
> > -/// assert_eq!(guard.get(0).copied(), Some(0xbeef));
> > +/// // We trampled the reservation above, so filling should fail.
> > +/// let leet =3D {
> > +///    let ret =3D reservation2.fill_locked(&mut guard, leet);
> > +///    assert!(ret.is_err());
> > +///    let StoreError { value, error } =3D ret.unwrap_err();
> > +///    assert_eq!(error, EBUSY);
> > +///    value
> > +/// };
> >  ///
> > -/// guard.remove(0);
> > -/// assert_eq!(guard.get(0), None);
> > +/// assert_eq!(guard.get(index), Some(&0xbeef));
> >  ///
> >  /// # Ok::<(), Error>(())
> >  /// ```
> > @@ -126,6 +183,19 @@ fn iter(&self) -> impl Iterator<Item =3D NonNull<T=
::PointedTo>> + '_ {
> >          .map_while(|ptr| NonNull::new(ptr.cast()))
> >      }
> >
> > +    fn with_guard<F, U>(&self, guard: Option<&mut Guard<'_, T>>, f: F)=
 -> U
> > +    where
> > +        F: FnOnce(&mut Guard<'_, T>) -> U,
> > +    {
> > +        match guard {
> > +            None =3D> f(&mut self.lock()),
> > +            Some(guard) =3D> {
> > +                assert_eq!(guard.xa.xa.get(), self.xa.get());
> > +                f(guard)
> > +            }
> > +        }
> > +    }
> > +
> >      /// Attempts to lock the [`XArray`] for exclusive access.
> >      pub fn try_lock(&self) -> Option<Guard<'_, T>> {
> >          // SAFETY: `self.xa` is always valid by the type invariant.
> > @@ -172,6 +242,7 @@ fn drop(&mut self) {
> >  /// The error returned by [`store`](Guard::store).
> >  ///
> >  /// Contains the underlying error and the value that was not stored.
> > +#[derive(Debug)]
> >  pub struct StoreError<T> {
> >      /// The error that occurred.
> >      pub error: Error,
> > @@ -185,6 +256,11 @@ fn from(value: StoreError<T>) -> Self {
> >      }
> >  }
> >
> > +fn to_usize(i: u32) -> usize {
> > +    i.try_into()
> > +        .unwrap_or_else(|_| build_error!("cannot convert u32 to usize"=
))
> > +}
> > +
> >  impl<'a, T: ForeignOwnable> Guard<'a, T> {
> >      fn load<F, U>(&self, index: usize, f: F) -> Option<U>
> >      where
> > @@ -219,7 +295,7 @@ pub fn remove(&mut self, index: usize) -> Option<T>=
 {
> >          // - The caller holds the lock.
> >          let ptr =3D unsafe { bindings::__xa_erase(self.xa.xa.get(), in=
dex) }.cast();
> >          // SAFETY:
> > -        // - `ptr` is either NULL or came from `T::into_foreign`.
> > +        // - `ptr` is either `NULL` or came from `T::into_foreign`.
> >          // - `&mut self` guarantees that the lifetimes of [`T::Borrowe=
d`] and [`T::BorrowedMut`]
> >          // borrowed from `self` have ended.
> >          unsafe { T::try_from_foreign(ptr) }
> > @@ -267,13 +343,272 @@ pub fn store(
> >              })
> >          } else {
> >              let old =3D old.cast();
> > -            // SAFETY: `ptr` is either NULL or came from `T::into_fore=
ign`.
> > +            // SAFETY: `ptr` is either `NULL` or came from `T::into_fo=
reign`.
> >              //
> >              // NB: `XA_ZERO_ENTRY` is never returned by functions belo=
nging to the Normal XArray
> >              // API; such entries present as `NULL`.
> >              Ok(unsafe { T::try_from_foreign(old) })
> >          }
> >      }
> > +
> > +    /// Stores an element at the given index if no entry is present.
> > +    ///
> > +    /// May drop the lock if needed to allocate memory, and then reacq=
uire it afterwards.
> > +    ///
> > +    /// On failure, returns the element which was attempted to be stor=
ed.
> > +    pub fn insert(
> > +        &mut self,
> > +        index: usize,
> > +        value: T,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<(), StoreError<T>> {
> > +        build_assert!(
> > +            mem::align_of::<T::PointedTo>() >=3D 4,
> > +            "pointers stored in XArray must be 4-byte aligned"
> > +        );
> > +        let ptr =3D value.into_foreign();
> > +        // SAFETY: `self.xa` is always valid by the type invariant.
> > +        //
> > +        // INVARIANT: `ptr` came from `T::into_foreign`.
> > +        match unsafe { bindings::__xa_insert(self.xa.xa.get(), index, =
ptr.cast(), gfp.as_raw()) } {
> > +            0 =3D> Ok(()),
> > +            errno =3D> {
> > +                // SAFETY: `ptr` came from `T::into_foreign` and `__xa=
_insert` does not take
> > +                // ownership of the value on error.
> > +                let value =3D unsafe { T::from_foreign(ptr) };
> > +                Err(StoreError {
> > +                    value,
> > +                    error: Error::from_errno(errno),
> > +                })
> > +            }
> > +        }
> > +    }
> > +
> > +    /// Stores an element somewhere in the given range of indices.
> > +    ///
> > +    /// On success, takes ownership of `ptr`.
> > +    ///
> > +    /// On failure, ownership returns to the caller.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must be `NULL` or have come from a previous call to `T::=
into_foreign`.
> > +    unsafe fn alloc(
> > +        &mut self,
> > +        limit: impl ops::RangeBounds<u32>,
> > +        ptr: *mut T::PointedTo,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<usize> {
> > +        // NB: `xa_limit::{max,min}` are inclusive.
> > +        let limit =3D bindings::xa_limit {
> > +            max: match limit.end_bound() {
> > +                ops::Bound::Included(&end) =3D> end,
> > +                ops::Bound::Excluded(&end) =3D> end - 1,
> > +                ops::Bound::Unbounded =3D> u32::MAX,
> > +            },
> > +            min: match limit.start_bound() {
> > +                ops::Bound::Included(&start) =3D> start,
> > +                ops::Bound::Excluded(&start) =3D> start + 1,
> > +                ops::Bound::Unbounded =3D> 0,
> > +            },
> > +        };
> > +
> > +        let mut index =3D u32::MAX;
> > +
> > +        // SAFETY:
> > +        // - `self.xa` is always valid by the type invariant.
> > +        // - `self.xa` was initialized with `XA_FLAGS_ALLOC` or `XA_FL=
AGS_ALLOC1`.
> > +        //
> > +        // INVARIANT: `ptr` is either `NULL` or came from `T::into_for=
eign`.
> > +        match unsafe {
> > +            bindings::__xa_alloc(
> > +                self.xa.xa.get(),
> > +                &mut index,
> > +                ptr.cast(),
> > +                limit,
> > +                gfp.as_raw(),
> > +            )
> > +        } {
> > +            0 =3D> Ok(to_usize(index)),
> > +            errno =3D> Err(Error::from_errno(errno)),
> > +        }
> > +    }
> > +
> > +    /// Allocates an entry somewhere in the array.
> > +    ///
> > +    /// On success, returns the index at which the entry was stored.
> > +    ///
> > +    /// On failure, returns the entry which was attempted to be stored=
.
> > +    pub fn insert_limit(
> > +        &mut self,
> > +        limit: impl ops::RangeBounds<u32>,
> > +        value: T,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<usize, StoreError<T>> {
> > +        build_assert!(
> > +            mem::align_of::<T::PointedTo>() >=3D 4,
> > +            "pointers stored in XArray must be 4-byte aligned"
> > +        );
> > +        let ptr =3D value.into_foreign();
> > +        // SAFETY: `ptr` came from `T::into_foreign`.
> > +        unsafe { self.alloc(limit, ptr, gfp) }.map_err(|error| {
> > +            // SAFETY: `ptr` came from `T::into_foreign` and `self.all=
oc` does not take ownership of
> > +            // the value on error.
> > +            let value =3D unsafe { T::from_foreign(ptr) };
> > +            StoreError { value, error }
> > +        })
> > +    }
> > +
> > +    /// Reserves an entry in the array.
> > +    pub fn reserve(&mut self, index: usize, gfp: alloc::Flags) -> Resu=
lt<Reservation<'a, T>> {
> > +        // NB: `__xa_insert` internally coerces `NULL` to `XA_ZERO_ENT=
RY` on ingress.
> > +        let ptr =3D null_mut();
> > +        // SAFETY: `self.xa` is always valid by the type invariant.
> > +        //
> > +        // INVARIANT: `ptr` is `NULL`.
> > +        match unsafe { bindings::__xa_insert(self.xa.xa.get(), index, =
ptr, gfp.as_raw()) } {
> > +            0 =3D> Ok(Reservation { xa: self.xa, index }),
> > +            errno =3D> Err(Error::from_errno(errno)),
> > +        }
> > +    }
> > +
> > +    /// Reserves an entry somewhere in the array.
> > +    pub fn reserve_limit(
> > +        &mut self,
> > +        limit: impl ops::RangeBounds<u32>,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<Reservation<'a, T>> {
> > +        // NB: `__xa_alloc` internally coerces `NULL` to `XA_ZERO_ENTR=
Y` on ingress.
> > +        let ptr =3D null_mut();
> > +        // SAFETY: `ptr` is `NULL`.
> > +        unsafe { self.alloc(limit, ptr, gfp) }.map(|index| Reservation=
 { xa: self.xa, index })
> > +    }
> > +}
> > +
> > +/// A reserved slot in an array.
> > +///
> > +/// The slot is released when the reservation goes out of scope.
> > +///
> > +/// Note that the array lock *must not* be held when the reservation i=
s filled or dropped as this
> > +/// will lead to deadlock. [`Reservation::fill_locked`] and [`Reservat=
ion::release_locked`] can be
> > +/// used in context where the array lock is held.
> > +#[must_use =3D "the reservation is released immediately when the reser=
vation is unused"]
> > +pub struct Reservation<'a, T: ForeignOwnable> {
> > +    xa: &'a XArray<T>,
> > +    index: usize,
> > +}
> > +
> > +impl<T: ForeignOwnable> fmt::Debug for Reservation<'_, T> {
> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> > +        f.debug_struct("Reservation")
> > +            .field("index", &self.index())
> > +            .finish()
> > +    }
> > +}
> > +
> > +impl<T: ForeignOwnable> Reservation<'_, T> {
> > +    /// Returns the index of the reservation.
> > +    pub fn index(&self) -> usize {
> > +        self.index
> > +    }
> > +
> > +    /// Replaces the reserved entry with the given entry.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must be `NULL` or have come from a previous call to `T::=
into_foreign`.
> > +    unsafe fn replace(guard: &mut Guard<'_, T>, index: usize, ptr: *mu=
t T::PointedTo) -> Result {
> > +        // SAFETY: `xa_zero_entry` wraps `XA_ZERO_ENTRY` which is alwa=
ys safe to use.
> > +        let old =3D unsafe { bindings::xa_zero_entry() };
> > +
> > +        // NB: `__xa_cmpxchg_raw` is used over `__xa_cmpxchg` because =
the latter coerces
> > +        // `XA_ZERO_ENTRY` to `NULL` on egress, which would prevent us=
 from determining whether a
> > +        // replacement was made.
> > +        //
> > +        // SAFETY: `self.xa` is always valid by the type invariant.
> > +        //
> > +        // INVARIANT: `ptr` is either `NULL` or came from `T::into_for=
eign` and `old` is
> > +        // `XA_ZERO_ENTRY`.
> > +        let ret =3D
> > +            unsafe { bindings::__xa_cmpxchg_raw(guard.xa.xa.get(), ind=
ex, old, ptr.cast(), 0) };
> > +
> > +        // SAFETY: `__xa_cmpxchg_raw` returns the old entry at this in=
dex on success or `xa_err` if
> > +        // an error happened.
> > +        match unsafe { bindings::xa_err(ret) } {
> > +            0 =3D> {
> > +                if ret =3D=3D old {
> > +                    Ok(())
> > +                } else {
> > +                    Err(EBUSY)
> > +                }
> > +            }
> > +            errno =3D> Err(Error::from_errno(errno)),
> > +        }
> > +    }
> > +
> > +    fn fill_inner(&self, guard: Option<&mut Guard<'_, T>>, value: T) -=
> Result<(), StoreError<T>> {
> > +        let Self { xa, index } =3D self;
> > +        let index =3D *index;
> > +
> > +        let ptr =3D value.into_foreign();
> > +        xa.with_guard(guard, |guard| {
> > +            // SAFETY: `ptr` came from `T::into_foreign`.
> > +            unsafe { Self::replace(guard, index, ptr) }
> > +        })
> > +        .map_err(|error| {
> > +            // SAFETY: `ptr` came from `T::into_foreign` and `Self::re=
place` does not take ownership
> > +            // of the value on error.
> > +            let value =3D unsafe { T::from_foreign(ptr) };
> > +            StoreError { value, error }
> > +        })
> > +    }
> > +
> > +    /// Fills the reservation.
> > +    pub fn fill(self, value: T) -> Result<(), StoreError<T>> {
> > +        let result =3D self.fill_inner(None, value);
> > +        mem::forget(self);
> > +        result
> > +    }
> > +
> > +    /// Fills the reservation without acquiring the array lock.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if the passed guard locks a different array.
> > +    pub fn fill_locked(self, guard: &mut Guard<'_, T>, value: T) -> Re=
sult<(), StoreError<T>> {
> > +        let result =3D self.fill_inner(Some(guard), value);
> > +        mem::forget(self);
> > +        result
> > +    }
> > +
> > +    fn release_inner(&self, guard: Option<&mut Guard<'_, T>>) -> Resul=
t {
> > +        let Self { xa, index } =3D self;
> > +        let index =3D *index;
> > +
> > +        xa.with_guard(guard, |guard| {
> > +            let ptr =3D null_mut();
> > +            // SAFETY: `ptr` is `NULL`.
> > +            unsafe { Self::replace(guard, index, ptr) }
> > +        })
> > +    }
> > +
> > +    /// Releases the reservation without acquiring the array lock.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if the passed guard locks a different array.
> > +    pub fn release_locked(self, guard: &mut Guard<'_, T>) -> Result {
> > +        let result =3D self.release_inner(Some(guard));
> > +        mem::forget(self);
> > +        result
> > +    }
> > +}
> > +
> > +impl<T: ForeignOwnable> Drop for Reservation<'_, T> {
> > +    fn drop(&mut self) {
> > +        // NB: Errors here are possible since `Guard::store` does not =
honor reservations.
> > +        let _: Result =3D self.release_inner(None);
> This seems bit risky as one can drop the reservation while still holding =
the
> lock?

Yes, that's true. The only way to avoid it would be to make the
reservation borrowed from the guard, but that would exclude usage
patterns where the caller wants to reserve and fulfill in different
critical sections.

Do you have a specific suggestion?

> > +    }
> >  }
> >
> >  // SAFETY: `XArray<T>` has no shared mutable state so it is `Send` iff=
 `T` is `Send`.
> > @@ -282,3 +617,136 @@ unsafe impl<T: ForeignOwnable + Send> Send for XA=
rray<T> {}
> >  // SAFETY: `XArray<T>` serialises the interior mutability it provides =
so it is `Sync` iff `T` is
> >  // `Send`.
> >  unsafe impl<T: ForeignOwnable + Send> Sync for XArray<T> {}
> > +
> > +#[macros::kunit_tests(rust_xarray_kunit)]
> > +mod tests {
> > +    use super::*;
> > +    use pin_init::stack_pin_init;
> > +
> > +    fn new_kbox<T>(value: T) -> Result<KBox<T>> {
> > +        KBox::new(value, GFP_KERNEL).map_err(Into::into)
> I believe this should be GFP_ATOMIC as it is being called while holding t=
he xa
> lock.

I'm not sure what you mean - this function can be called in any
context, and besides: it is test-only code.

>
> Otherwise:
>
> Tested-By: Beata Michalska <beata.michalska@arm.com>

Thanks!
Tamir

>
> ---
> BR
> Beata
> > +    }
> > +
> > +    #[test]
> > +    fn test_alloc_kind_alloc() -> Result {
> > +        test_alloc_kind(AllocKind::Alloc, 0)
> > +    }
> > +
> > +    #[test]
> > +    fn test_alloc_kind_alloc1() -> Result {
> > +        test_alloc_kind(AllocKind::Alloc1, 1)
> > +    }
> > +
> > +    fn test_alloc_kind(kind: AllocKind, expected_index: usize) -> Resu=
lt {
> > +        stack_pin_init!(let xa =3D XArray::new(kind));
> > +        let mut guard =3D xa.lock();
> > +
> > +        let reservation =3D guard.reserve_limit(.., GFP_KERNEL)?;
> > +        assert_eq!(reservation.index(), expected_index);
> > +        reservation.release_locked(&mut guard)?;
> > +
> > +        let insertion =3D guard.insert_limit(.., new_kbox(0x1337)?, GF=
P_KERNEL);
> > +        assert!(insertion.is_ok());
> > +        let insertion_index =3D insertion.unwrap();
> > +        assert_eq!(insertion_index, expected_index);
> > +
> > +        Ok(())
> > +    }
> > +
> > +    #[test]
> > +    fn test_insert_and_reserve_interaction() -> Result {
> > +        const IDX: usize =3D 0x1337;
> > +
> > +        fn insert<T: ForeignOwnable>(
> > +            guard: &mut Guard<'_, T>,
> > +            value: T,
> > +        ) -> Result<(), StoreError<T>> {
> > +            guard.insert(IDX, value, GFP_KERNEL)
> > +        }
> > +
> > +        fn reserve<'a, T: ForeignOwnable>(guard: &mut Guard<'a, T>) ->=
 Result<Reservation<'a, T>> {
> > +            guard.reserve(IDX, GFP_KERNEL)
> > +        }
> > +
> > +        #[track_caller]
> > +        fn check_not_vacant<'a>(guard: &mut Guard<'a, KBox<usize>>) ->=
 Result {
> > +            // Insertion fails.
> > +            {
> > +                let beef =3D new_kbox(0xbeef)?;
> > +                let ret =3D insert(guard, beef);
> > +                assert!(ret.is_err());
> > +                let StoreError { error, value } =3D ret.unwrap_err();
> > +                assert_eq!(error, EBUSY);
> > +                assert_eq!(*value, 0xbeef);
> > +            }
> > +
> > +            // Reservation fails.
> > +            {
> > +                let ret =3D reserve(guard);
> > +                assert!(ret.is_err());
> > +                assert_eq!(ret.unwrap_err(), EBUSY);
> > +            }
> > +
> > +            Ok(())
> > +        }
> > +
> > +        stack_pin_init!(let xa =3D XArray::new(Default::default()));
> > +        let mut guard =3D xa.lock();
> > +
> > +        // Vacant.
> > +        assert_eq!(guard.get(IDX), None);
> > +
> > +        // Reservation succeeds.
> > +        let reservation =3D {
> > +            let ret =3D reserve(&mut guard);
> > +            assert!(ret.is_ok());
> > +            ret.unwrap()
> > +        };
> > +
> > +        // Reserved presents as vacant.
> > +        assert_eq!(guard.get(IDX), None);
> > +
> > +        check_not_vacant(&mut guard)?;
> > +
> > +        // Release reservation.
> > +        {
> > +            let ret =3D reservation.release_locked(&mut guard);
> > +            assert!(ret.is_ok());
> > +            let () =3D ret.unwrap();
> > +        }
> > +
> > +        // Vacant again.
> > +        assert_eq!(guard.get(IDX), None);
> > +
> > +        // Insert succeeds.
> > +        {
> > +            let dead =3D new_kbox(0xdead)?;
> > +            let ret =3D insert(&mut guard, dead);
> > +            assert!(ret.is_ok());
> > +            let () =3D ret.unwrap();
> > +        }
> > +
> > +        check_not_vacant(&mut guard)?;
> > +
> > +        // Remove.
> > +        assert_eq!(guard.remove(IDX).as_deref(), Some(&0xdead));
> > +
> > +        // Reserve and fill.
> > +        {
> > +            let beef =3D new_kbox(0xbeef)?;
> > +            let ret =3D reserve(&mut guard);
> > +            assert!(ret.is_ok());
> > +            let reservation =3D ret.unwrap();
> > +            let ret =3D reservation.fill_locked(&mut guard, beef);
> > +            assert!(ret.is_ok());
> > +            let () =3D ret.unwrap();
> > +        };
> > +
> > +        check_not_vacant(&mut guard)?;
> > +
> > +        // Remove.
> > +        assert_eq!(guard.remove(IDX).as_deref(), Some(&0xbeef));
> > +
> > +        Ok(())
> > +    }
> > +}
> >
> > --
> > 2.50.1
> >
> >

