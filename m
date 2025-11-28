Return-Path: <linux-fsdevel+bounces-70182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C031BC92E20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 19:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C86754E3393
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41389333754;
	Fri, 28 Nov 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="cQMWT3gX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC525487C;
	Fri, 28 Nov 2025 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764353290; cv=pass; b=ngelhNR13B89nik0NWSzZiVeIPJ56+7kODg/TU5l8yw7T6qgw/7abTY0XXIEjjieEhKEqEWssPDBVPV60MYkoKN/EmEOw6Lu+YHJHd/xtQYk8I0GTcEMjuJHZBUSgPrTnfGXSEIbDbpVo/u1Hsygw5P85TjfpqRuVKKNogJntxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764353290; c=relaxed/simple;
	bh=1IOmn5zMIOoJIKH2+9kJqRMZHEuUrVDmT9SeQuZ9Qho=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Te8C9L/pGwJ+pLcNXM2bPElfV67YOBTOu1bF8w5hEvrj3fPwuiINGwIvWJIE7XumHAHLSeQMlz/k6YqbybiGvGkq3aFq7RaV2zXWMbYk3PE6cBP0Whv+yD82CZghPm/mO1ZRxsSzCbjumpUTprlxNyACJY3TU0c+RtPC0FmLNZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=cQMWT3gX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764353224; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RtG3ndtV6UjdVmNEugxfkY/hNqTZyTalZN9NIiBwE13LjiiQGrfVvqMIlCMsp2cR2P2V3BZjxj7axPKgJYr0fDdbSPxN1GTBWASZjGJdnONZS/yezjkw7I+//rihzgbrikAiSqC0HZUafMyQak5Jd2CE5YoCDUpLUmhT/Bwk/ls=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764353224; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7hCtVdIpYmvpIaG2Tepwl9t2OZhg+JztbnabjHdsDXw=; 
	b=j1uXW3P5csnn5xBO8uGG/CYg16oq3me8gSQnLQlVJw5JE02U+XwW4CcPu0JMcCgNqtIU2mo2h22ckClb0Jn1u9EElgTUDqT6AtpOVux93CVzTAVQxFiCCkw700f5K+85rR3/6OM9haHQvh01rQ+nxQr11SX9m5R4Brfuh/mGa0Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764353224;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=7hCtVdIpYmvpIaG2Tepwl9t2OZhg+JztbnabjHdsDXw=;
	b=cQMWT3gX69SgMPgVmoZ3O2F61xD0U8uLT41OSthjMpSgkT6ymH/aampfZQsduSSJ
	Mnh+iUhoZu+90ceDRcdZMCKNINIP8yBhJvbThj8X8Y41Uz621+skz9GV68ZLyGGmayr
	QO5jhfvm8In7Rn6Yhul0L9K3CuiAYR5Tg8wuvLZg=
Received: by mx.zohomail.com with SMTPS id 1764353222335519.628984308173;
	Fri, 28 Nov 2025 10:07:02 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v13 4/4] rust: Add `OwnableRefCounted`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251117-unique-ref-v13-4-b5b243df1250@pm.me>
Date: Fri, 28 Nov 2025 15:06:42 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Benno Lossin <lossin@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>,
 Asahi Lina <lina+kernel@asahilina.net>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org,
 linux-security-module@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5A7C4C9-1504-439C-B4FF-C28482AF7444@collabora.com>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-4-b5b243df1250@pm.me>
To: Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Oliver,

> On 17 Nov 2025, at 07:08, Oliver Mangold <oliver.mangold@pm.me> wrote:
>=20
> Types implementing one of these traits can safely convert between an
> `ARef<T>` and an `Owned<T>`.
>=20
> This is useful for types which generally are accessed through an =
`ARef`
> but have methods which can only safely be called when the reference is
> unique, like e.g. `block::mq::Request::end_ok()`.
>=20
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/owned.rs     | 138 =
++++++++++++++++++++++++++++++++++++++++++++---
> rust/kernel/sync/aref.rs |  11 +++-
> rust/kernel/types.rs     |   2 +-
> 3 files changed, 141 insertions(+), 10 deletions(-)
>=20
> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index a26747cbc13b..26ab2b00ada0 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs
> @@ -5,6 +5,7 @@
> //! These pointer types are useful for C-allocated objects which by =
API-contract
> //! are owned by Rust, but need to be freed through the C API.
>=20
> +use crate::sync::aref::{ARef, RefCounted};
> use core::{
>     mem::ManuallyDrop,
>     ops::{Deref, DerefMut},
> @@ -14,14 +15,16 @@
>=20
> /// Type allocated and destroyed on the C side, but owned by Rust.
> ///
> -/// Implementing this trait allows types to be referenced via the =
[`Owned<Self>`] pointer type. This
> -/// is useful when it is desirable to tie the lifetime of the =
reference to an owned object, rather
> -/// than pass around a bare reference. [`Ownable`] types can define =
custom drop logic that is
> -/// executed when the owned reference [`Owned<Self>`] pointing to the =
object is dropped.
> +/// Implementing this trait allows types to be referenced via the =
[`Owned<Self>`] pointer type.
> +///  - This is useful when it is desirable to tie the lifetime of an =
object reference to an owned
> +///    object, rather than pass around a bare reference.
> +///  - [`Ownable`] types can define custom drop logic that is =
executed when the owned reference
> +///    of type [`Owned<_>`] pointing to the object is dropped.
> ///
> /// Note: The underlying object is not required to provide internal =
reference counting, because it
> /// represents a unique, owned reference. If reference counting (on =
the Rust side) is required,
> -/// [`RefCounted`](crate::types::RefCounted) should be implemented.
> +/// [`RefCounted`] should be implemented. [`OwnableRefCounted`] =
should be implemented if conversion
> +/// between unique and shared (reference counted) ownership is =
needed.
> ///
> /// # Safety
> ///
> @@ -143,9 +146,7 @@ impl<T: Ownable> Owned<T> {
>     ///   mutable reference requirements. That is, the kernel will not =
mutate or free the underlying
>     ///   object and is okay with it being modified by Rust code.
>     pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> -        Self {
> -            ptr,
> -        }
> +        Self { ptr }
>     }

Unrelated change?

>=20
>     /// Consumes the [`Owned`], returning a raw pointer.
> @@ -193,3 +194,124 @@ fn drop(&mut self) {
>         unsafe { T::release(self.ptr) };
>     }
> }
> +
> +/// A trait for objects that can be wrapped in either one of the =
reference types [`Owned`] and
> +/// [`ARef`].
> +///
> +/// # Examples
> +///
> +/// A minimal example implementation of [`OwnableRefCounted`], =
[`Ownable`] and its usage with
> +/// [`ARef`] and [`Owned`] looks like this:
> +///
> +/// ```
> +/// # #![expect(clippy::disallowed_names)]
> +/// # use core::cell::Cell;
> +/// # use core::ptr::NonNull;
> +/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
> +/// # use kernel::sync::aref::{ARef, RefCounted};
> +/// # use kernel::types::{Owned, Ownable, OwnableRefCounted};
> +///
> +/// // Example internally refcounted struct.

nit: IMHO the wording could improve ^

> +/// //
> +/// // # Invariants
> +/// //
> +/// // - `refcount` is always non-zero for a valid object.
> +/// // - `refcount` is >1 if there are more than 1 Rust reference to =
it.
> +/// //
> +/// struct Foo {
> +///     refcount: Cell<usize>,
> +/// }
> +///
> +/// impl Foo {
> +///     fn new() -> Result<Owned<Self>, AllocError> {
> +///         // We are just using a `KBox` here to handle the actual =
allocation, as our `Foo` is
> +///         // not actually a C-allocated object.
> +///         let result =3D KBox::new(
> +///             Foo {
> +///                 refcount: Cell::new(1),
> +///             },
> +///             flags::GFP_KERNEL,
> +///         )?;
> +///         let result =3D NonNull::new(KBox::into_raw(result))
> +///             .expect("Raw pointer to newly allocation KBox is =
null, this should never happen.");
> +///         // SAFETY: We just allocated the `Self`, thus it is valid =
and there cannot be any other
> +///         // Rust references. Calling `into_raw()` makes us =
responsible for ownership and
> +///         // we won't use the raw pointer anymore, thus we can =
transfer ownership to the `Owned`.
> +///         Ok(unsafe { Owned::from_raw(result) })
> +///     }
> +/// }
> +///
> +/// // SAFETY: We increment and decrement each time the respective =
function is called and only free
> +/// // the `Foo` when the refcount reaches zero.
> +/// unsafe impl RefCounted for Foo {
> +///     fn inc_ref(&self) {
> +///         self.refcount.replace(self.refcount.get() + 1);
> +///     }
> +///
> +///     unsafe fn dec_ref(this: NonNull<Self>) {
> +///         // SAFETY: By requirement on calling this function, the =
refcount is non-zero,
> +///         // implying the underlying object is valid.
> +///         let refcount =3D unsafe { &this.as_ref().refcount };
> +///         let new_refcount =3D refcount.get() - 1;
> +///         if new_refcount =3D=3D 0 {
> +///             // The `Foo` will be dropped when `KBox` goes out of =
scope.
> +///             // SAFETY: The [`KBox<Foo>`] is still alive as the =
old refcount is 1. We can pass
> +///             // ownership to the [`KBox`] as by requirement on =
calling this function,
> +///             // the `Self` will no longer be used by the caller.
> +///             unsafe { KBox::from_raw(this.as_ptr()) };
> +///         } else {
> +///             refcount.replace(new_refcount);
> +///         }
> +///     }
> +/// }
> +///
> +/// impl OwnableRefCounted for Foo {
> +///     fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, =
ARef<Self>> {
> +///         if this.refcount.get() =3D=3D 1 {
> +///             // SAFETY: The `Foo` is still alive and has no other =
Rust references as the refcount
> +///             // is 1.
> +///             Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
> +///         } else {
> +///             Err(this)
> +///         }
> +///     }
> +/// }
> +///

We wouldn=E2=80=99t need this implementation if we added a =
=E2=80=9Crefcount()=E2=80=9D
member to this trait. This lets you abstract away this logic for all
implementors, which has the massive upside of making sure we hardcode =
(and thus
enforce) the refcount =3D=3D 1 check.


> +/// // SAFETY: This implementation of `release()` is safe for any =
valid `Self`.
> +/// unsafe impl Ownable for Foo {
> +///     unsafe fn release(this: NonNull<Self>) {
> +///         // SAFETY: Using `dec_ref()` from [`RefCounted`] to =
release is okay, as the refcount is
> +///         // always 1 for an [`Owned<Foo>`].
> +///         unsafe{ Foo::dec_ref(this) };
> +///     }
> +/// }
> +///
> +/// let foo =3D Foo::new().expect("Failed to allocate a Foo. This =
shouldn't happen");

All these =E2=80=9Cexpects()=E2=80=9D and custom error strings would go =
away if you
place this behind a fictional function that returns Result.

> +/// let mut foo =3D ARef::from(foo);
> +/// {
> +///     let bar =3D foo.clone();
> +///     assert!(Owned::try_from(bar).is_err());
> +/// }
> +/// assert!(Owned::try_from(foo).is_ok());
> +/// ```
> +pub trait OwnableRefCounted: RefCounted + Ownable + Sized {
> +    /// Checks if the [`ARef`] is unique and convert it to an =
[`Owned`] it that is that case.
> +    /// Otherwise it returns again an [`ARef`] to the same underlying =
object.
> +    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, =
ARef<Self>>;

Again, this method can go way if we add a method to expose the refcount.

> +
> +    /// Converts the [`Owned`] into an [`ARef`].
> +    fn into_shared(this: Owned<Self>) -> ARef<Self> {
> +        // SAFETY: Safe by the requirements on implementing the =
trait.
> +        unsafe { ARef::from_raw(Owned::into_raw(this)) }
> +    }
> +}
> +
> +impl<T: OwnableRefCounted> TryFrom<ARef<T>> for Owned<T> {
> +    type Error =3D ARef<T>;
> +    /// Tries to convert the [`ARef`] to an [`Owned`] by calling
> +    /// [`try_from_shared()`](OwnableRefCounted::try_from_shared). In =
case the [`ARef`] is not
> +    /// unique, it returns again an [`ARef`] to the same underlying =
object.
> +    fn try_from(b: ARef<T>) -> Result<Owned<T>, Self::Error> {
> +        T::try_from_shared(b)
> +    }
> +}
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 937dcf6ed5de..2dbffe2ed1b8 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -30,7 +30,10 @@
> /// Note: Implementing this trait allows types to be wrapped in an =
[`ARef<Self>`]. It requires an
> /// internal reference count and provides only shared references. If =
unique references are required
> /// [`Ownable`](crate::types::Ownable) should be implemented which =
allows types to be wrapped in an
> -/// [`Owned<Self>`](crate::types::Owned).
> +/// [`Owned<Self>`](crate::types::Owned). Implementing the trait
> +/// [`OwnableRefCounted`](crate::types::OwnableRefCounted) allows to =
convert between unique and
> +/// shared references (i.e. [`Owned<Self>`](crate::types::Owned) and
> +/// [`ARef<Self>`](crate::types::Owned)).
> ///
> /// # Safety
> ///
> @@ -180,6 +183,12 @@ fn from(b: &T) -> Self {
>     }
> }
>=20
> +impl<T: crate::types::OwnableRefCounted> From<crate::types::Owned<T>> =
for ARef<T> {
> +    fn from(b: crate::types::Owned<T>) -> Self {
> +        T::into_shared(b)
> +    }
> +}
> +

Not sure why we=E2=80=99re using fully-qualified names here if we can =
import them, but your call.

> impl<T: RefCounted> Drop for ARef<T> {
>     fn drop(&mut self) {
>         // SAFETY: The type invariants guarantee that the `ARef` owns =
the reference we're about to
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 8ef01393352b..a9b72709d0d3 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -11,7 +11,7 @@
> };
> use pin_init::{PinInit, Wrapper, Zeroable};
>=20
> -pub use crate::owned::{Ownable, Owned};
> +pub use crate::owned::{Ownable, OwnableRefCounted, Owned};
>=20
> pub use crate::sync::aref::{ARef, AlwaysRefCounted, RefCounted};
>=20
>=20
> --=20
> 2.51.2
>=20
>=20
>=20

=E2=80=94 Daniel=

