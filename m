Return-Path: <linux-fsdevel+bounces-15070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69116886B1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 12:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F415B284531
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900C3EA83;
	Fri, 22 Mar 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LvjO5h5G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2E2C18D
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105958; cv=none; b=Id/MikzAtlz+9HPuoOPOI9TqyzWd3b5CA7+n9X3wcJGANlLOfUoRiAnL/k7umXL4wS2az+snnq8Lw54pbeGCfw5TDoKToHUSL4Kg7uFP7jW9zWTNWeqPkumAZ9oDzJmRr0gsWoQDbC3gVJry3AcM5HqzKuvNFrjum/ZXLPNPHWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105958; c=relaxed/simple;
	bh=pL7XGfuQrvBIFhZjx+b4qvEY55H0D6drzjDhT+HAE0A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDh44koPiSereDLu2Bt2qm4czU/8a4kN2EDvaHgu03q9RIBKGqZMVaDvaDdzQtfTBqWs7hNZ9iMXHOubmshtUzqShQrEC51APlEhX/UBQvU1lrJHZZ4k8veyOPzM5WYP+EnB5boq7dQ3KSm08fH+5qj5LFtUKkyX0F49G8z/Jew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LvjO5h5G; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711105949; x=1711365149;
	bh=3OKqvzassCqyZXU0pcpOTji/2AT+E62EbjkKl8453JE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LvjO5h5GY53O78JIb6Q3mEW/44We+ruJZkwetNu3S7Dz48pYVy5931cbuBT2rKT9C
	 OfUbN4/I6q19zrNUv/3DYxhRetMh+r40eU/yKsH93SA+VGKFAEwXOy4PB5cLQ85sLn
	 0xQE+tskxYLEBmoXdOcWOnlg/MvHOXZ8n8Ia4ZqZAmNX7viTuJoJb3y20W+XWsSlb9
	 SS+Y6oKrtqf6VyezqoOFwgn2iUmdVbl6TSRbgx1CbYiDgkYwoexPaZy6cl4TZR3VPD
	 Dv1//kjf8DrXWFvhMM0QvRsUGX8zqIFlt/6gHeZRL4ZFyhOmbUE0btAXmmI4RTK8r6
	 gs6YPrlaLf6uw==
Date: Fri, 22 Mar 2024 11:12:00 +0000
To: =?utf-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Matthew Wilcox <willy@infradead.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v8 2/2] rust: xarray: Add an abstraction for XArray
Message-ID: <8af4aa57-b1c4-44e4-a281-24ed45bbc312@proton.me>
In-Reply-To: <20240309235927.168915-4-mcanal@igalia.com>
References: <20240309235927.168915-2-mcanal@igalia.com> <20240309235927.168915-4-mcanal@igalia.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/10/24 00:57, Ma=C3=ADra Canal wrote:

[...]

> +// Convenience impl for [`ForeignOwnable`] types whose [`Borrowed`] form
> +// implements [`Deref`].
> +impl<'a, T: ForeignOwnable> Deref for Guard<'a, T>
> +where
> +    T::Borrowed<'a>: Deref,
> +    for<'b> T::Borrowed<'b>: Into<&'b <T::Borrowed<'a> as Deref>::Target=
>,

I took a look at this again and it currently is not really helpful.
`ArcBorrow<'b, T>` does not implement `Into<&'b T>` and it never is
going to, since it is impossible due to Rust's orphan rules. We have two
options:
1. Remove this impl.
2. Create a `IntoRef` trait that does the job instead and implement it
    for `ArcBorrow`.

If you go for option 2, I think `IntoRef` should look like this:
     pub trait IntoRef<'a, T: ?Sized> {
         fn into_ref(self) -> &'a T;
     }

But this can also easily be done in a future patch, so feel free to
choose option 1.

> +{
> +    type Target =3D <T::Borrowed<'a> as Deref>::Target;
> +
> +    fn deref(&self) -> &Self::Target {
> +        self.borrow().into()
> +    }
> +}
> +
> +impl<'a, T: ForeignOwnable> Drop for Guard<'a, T> {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariant, we own the [`XArray`] lock, so=
 we must
> +        // unlock it here.

I think the "so we must unlock it here" part is unnecessary.

> +        unsafe { bindings::xa_unlock(self.1.xa.get()) };
> +    }
> +}

[...]

> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::xarray::{XArray, flags};
> +/// use kernel::sync::Arc;
> +///
> +/// struct Foo {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// let arr =3D Box::pin_init(XArray::<Arc<Foo>>::new(flags::ALLOC1))?;
> +///
> +/// let item =3D Arc::try_new(Foo { a : 1, b: 2 })?;
> +/// let index =3D arr.alloc(item)?;
> +///
> +/// if let Some(guard) =3D arr.get_locked(index) {
> +///     assert_eq!(guard.borrow().a, 1);
> +///     assert_eq!(guard.borrow().b, 2);
> +/// } else {
> +///     pr_info!("No value found in index {}", index);
> +/// }
> +///
> +/// let item =3D Arc::try_new(Foo { a : 3, b: 4 })?;
> +/// let index =3D arr.alloc(item)?;
> +///
> +/// if let Some(removed_data) =3D arr.remove(index) {
> +///     assert_eq!(removed_data.a, 3);
> +///     assert_eq!(removed_data.b, 4);
> +/// } else {
> +///     pr_info!("No value found in index {}", index);
> +/// }
> +/// # Ok::<(), Error>(())
> +/// ```

I think it would make more sense to move these examples into the
documentation of `XArray<T>` itself.

> +impl<T: ForeignOwnable> XArray<T> {
> +    /// Creates a new [`XArray`] with the given flags.
> +    pub fn new(flags: Flags) -> impl PinInit<Self> {
> +        pin_init!(Self {
> +            // SAFETY: `xa` is valid while the closure is called.
> +            xa <- Opaque::ffi_init(|xa| unsafe {
> +                bindings::xa_init_flags(xa, flags)
> +            }),
> +            _p: PhantomData,
> +        })
> +    }
> +
> +    /// Converts [`usize`] to `unsigned long`.
> +    fn to_index(i: usize) -> c_ulong {
> +        // The type is `unsigned long`, which is always the same as `usi=
ze` in
> +        // the kernel.
> +        build_assert!(mem::size_of::<usize>() =3D=3D mem::size_of::<c_ul=
ong>());
> +        i as c_ulong
> +    }
> +
> +    /// Replaces an entry with a new value, returning the old value (if =
any).
> +    pub fn replace(&self, index: usize, value: T) -> Result<Option<T>> {
> +        let new =3D value.into_foreign();
> +
> +        build_assert!(T::FOREIGN_ALIGN >=3D 4);

This looks good. Which unsafe function call required this again? I can't
find it in the safety comments below.

As I wrote in my mail to the first patch, `ForeignOwnable` needs to
guarantee that `T::FOREIGN_ALIGN` actually is the alignment of the
pointers returned by `into_foreign()`, so it must be an `unsafe` trait.

> +
> +        // SAFETY: `new` just came from [`into_foreign()`], and we dismi=
ss this guard
> +        // if the `xa_store` operation succeeds and takes ownership of t=
he pointer.
> +        let guard =3D ScopeGuard::new(|| unsafe {
> +            drop(T::from_foreign(new));
> +        });
> +
> +        // SAFETY: `self.xa` is always valid by the type invariant, and =
we are
> +        // storing a [`T::into_foreign()`] result which upholds the late=
r invariants.

The second part of this comment should be an `INVARIANT` comment
instead. So "INVARIANT: `new` came from [`T::into_foreign()`]."

> +        let old =3D unsafe {
> +            bindings::xa_store(
> +                self.xa.get(),
> +                Self::to_index(index),
> +                new.cast_mut(),
> +                bindings::GFP_KERNEL,
> +            )
> +        };
> +
> +        // SAFETY: `xa_store` returns the old entry at this index on suc=
cess or
> +        // a [`XArray`] result, which can be turn into an errno through =
`xa_err`.
> +        to_result(unsafe { bindings::xa_err(old) })?;
> +        guard.dismiss();
> +
> +        Ok(if old.is_null() {
> +            None
> +        } else {
> +            // SAFETY: The old value must have been stored by either thi=
s function or
> +            // `insert_between`, both of which ensure non-NULL entries a=
re valid
> +            // [`ForeignOwnable`] pointers.

This should be replaced by "by the type invariant of `Self`, `old` is
either NULL, or came from `T::into_foreign()`.".

> +            Some(unsafe { T::from_foreign(old) })
> +        })
> +    }

[...]

> +    /// Allocates a new index in the array, optionally storing a new val=
ue into
> +    /// it, with configurable bounds for the index range to allocate fro=
m.
> +    ///
> +    /// If `value` is [`None`], then the index is reserved from further =
allocation
> +    /// but remains free for storing a value into it.
> +    fn insert_between(&self, value: Option<T>, min: u32, max: u32) -> Re=
sult<usize> {
> +        let new =3D value.map_or(core::ptr::null(), |a| a.into_foreign()=
);
> +        let mut id: u32 =3D 0;
> +
> +        let guard =3D ScopeGuard::new(|| {
> +            if !new.is_null() {
> +                // SAFETY: If `new` is not NULL, it came from the [`Fore=
ignOwnable`]
> +                // we got from the caller.
> +                unsafe { drop(T::from_foreign(new)) };
> +            }
> +        });
> +
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        //
> +        // If this succeeds, it takes ownership of the passed `T` (if an=
y).
> +        // If it fails, we must drop the `T` again.
> +        let ret =3D unsafe {
> +            bindings::xa_alloc(
> +                self.xa.get(),
> +                &mut id,
> +                new.cast_mut(),
> +                bindings::xa_limit { min, max },
> +                bindings::GFP_KERNEL,
> +            )
> +        };

This function call is missing an INVARIANT comment stating that `new` is
either NULL or came from `T::into_foreign()`.

> +
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            guard.dismiss();
> +            Ok(id as usize)
> +        }
> +    }

[...]

> +// SAFETY: It is safe to send `XArray<T>` to another thread when the und=
erlying
> +// `T` is `Send` because XArray is thread-safe and all mutation operatio=
ns are
> +// internally locked. `T` must be `ForeignOwnable` because all pointers =
stored
> +// in the array are pointers obtained by calling `T::into_foreign` or ar=
e NULL
> +// pointers.
> +unsafe impl<T: Send + ForeignOwnable> Send for XArray<T> {}
> +//
> +// SAFETY: It is safe to send `&XArray<T>` to another thread when the un=
derlying
> +// `T` is `Sync` because it effectively means sharing `&T` (which is saf=
e because
> +// `T` is `Sync`). Additionally, `T` is `Send` because XArray is thread-=
safe and
> +// all mutation operations are internally locked. `T` must be `ForeignOw=
nable`
> +// because all pointers stored in the array are pointers obtained by cal=
ling
> +// `T::into_foreign` or are NULL pointers.
> +unsafe impl<T: Send + Sync + ForeignOwnable> Sync for XArray<T> {}

The part about "`T` must be `ForeignOwnable`..." is not needed here.

--=20
Cheers,
Benno

> --
> 2.43.0
>=20


