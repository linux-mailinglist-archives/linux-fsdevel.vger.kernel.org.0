Return-Path: <linux-fsdevel+bounces-63153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C17BAFC88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F233C2492
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE922DF128;
	Wed,  1 Oct 2025 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="rKJ0zo80"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C12DE6ED;
	Wed,  1 Oct 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309482; cv=none; b=ejdWgYQSrgAomegTQPA3MHnRYAOVZck7HEVPgFPtg43/XFmIrbS++vmbnafJ0snCbdbVnsj5O9FCXhAzzdVhQkfC2iqyEeNvuq+YUFjfGRvz9eRuCxWi6c21DMUgfCNOrbGU0At8lS1/BTlcP+todygTSmBPbAlMWhZLCF4MDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309482; c=relaxed/simple;
	bh=wGzu/YJLmjjXeXLIWypdaKjxbslobXvvvheND7JZWhY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQH/xCbnsBNDbYU8iuD44L8tZkuYWQv1C4JJqpijUxgpftCYtiw5uvDqsEUn/v3gvfCYw6fW7qIS9iE1uJpilSSZNpcnmJ8WBLxnIEoKYJ0zVjTIeu2UoDrPDbIiwE548s5lj1NetMsYWQkSGV7rvsYIUzgpSv3g9bl9jAMP8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=rKJ0zo80; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1759309474; x=1759568674;
	bh=yp/Ky9qZB+Lu2rfaJfq2n9npeG17/rIKND2/1FJbPUU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rKJ0zo808K9+5xv+W+fbxwG7qVsIwuWt2mbyuJGFLiXXCoVZoeZVu3SLq6+wnhkS6
	 9zijPkbcHDElLMm9/Bee795eT9ukcv732jQW0DzyAcKr2VRZ1+2dtJnGpOLuFZrPqN
	 aPNucRfz0HQpb322WmUDY63i/Vgx6HMh7ngXDaU0QPiQuiwBDxzSCL6yPIZAFw1GeA
	 nDhkHM9HYJpYUij3nie0NTuQ1iweAHh3D6/dswrnS/XIriKSAwKVWOynLjJPuGuqOd
	 x3yAkCadMoBGsr2QK3jsBXIvGOJqiwutO+rPE/LLNa83zA4uTWVa6Oy2Ri/h1QqHs3
	 QzBkgjOw5SMzw==
Date: Wed, 01 Oct 2025 09:04:27 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v12 4/4] rust: Add `OwnableRefCounted`
Message-ID: <20251001-unique-ref-v12-4-fa5c31f0c0c4@pm.me>
In-Reply-To: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me>
References: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 273bbd2e0c664caf1e93c782e9d3dde288208540
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Types implementing one of these traits can safely convert between an
`ARef<T>` and an `Owned<T>`.

This is useful for types which generally are accessed through an `ARef`
but have methods which can only safely be called when the reference is
unique, like e.g. `block::mq::Request::end_ok()`.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/owned.rs     | 125 +++++++++++++++++++++++++++++++++++++++++++=
+++-
 rust/kernel/sync/aref.rs |  11 ++++-
 rust/kernel/types.rs     |   2 +-
 3 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index 466b7ecda6d9f4f54852ca0b59b36ac882ab3f47..ad38a4d378fa8fcf934f1c41cd9=
02d79a2c8baa5 100644
--- a/rust/kernel/owned.rs
+++ b/rust/kernel/owned.rs
@@ -3,6 +3,7 @@
 //! Unique reference types for objects with custom destructors. They shoul=
d be used for C-allocated
 //! objects which by API-contract are owned by Rust, but need to be freed =
through the C API.
=20
+use crate::sync::aref::{ARef, RefCounted};
 use core::{
     marker::PhantomData,
     mem::ManuallyDrop,
@@ -19,7 +20,8 @@
 ///
 /// Note: The underlying object is not required to provide internal refere=
nce counting, because it
 /// represents a unique, owned reference. If reference counting (on the Ru=
st side) is required,
-/// [`RefCounted`](crate::types::RefCounted) should be implemented.
+/// [`RefCounted`] should be implemented. [`OwnableRefCounted`] should be =
implemented if conversion
+/// between unique and shared (reference counted) ownership is needed.
 ///
 /// # Safety
 ///
@@ -193,3 +195,124 @@ fn drop(&mut self) {
         unsafe { T::release(self.ptr) };
     }
 }
+
+/// A trait for objects that can be wrapped in either one of the reference=
 types [`Owned`] and
+/// [`ARef`].
+///
+/// # Examples
+///
+/// A minimal example implementation of [`OwnableRefCounted`], [`Ownable`]=
 and its usage with
+/// [`ARef`] and [`Owned`] looks like this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// use core::cell::Cell;
+/// use core::ptr::NonNull;
+/// use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// use kernel::sync::aref::{ARef, RefCounted};
+/// use kernel::types::{Owned, Ownable, OwnableRefCounted};
+///
+/// // Example internally refcounted struct.
+/// //
+/// // # Invariants
+/// //
+/// // - `refcount` is always non-zero for a valid object.
+/// // - `refcount` is >1 if there are more then 1 Rust references to it.
+/// //
+/// struct Foo {
+///     refcount: Cell<usize>,
+/// }
+///
+/// impl Foo {
+///     fn new() -> Result<Owned<Self>, AllocError> {
+///         // We are just using a `KBox` here to handle the actual alloca=
tion, as our `Foo` is
+///         // not actually a C-allocated object.
+///         let result =3D KBox::new(
+///             Foo {
+///                 refcount: Cell::new(1),
+///             },
+///             flags::GFP_KERNEL,
+///         )?;
+///         let result =3D NonNull::new(KBox::into_raw(result))
+///             .expect("Raw pointer to newly allocation KBox is null, thi=
s should never happen.");
+///         // SAFETY: We just allocated the `Self`, thus it is valid and =
there cannot be any other
+///         // Rust references. Calling `into_raw()` makes us responsible =
for ownership and
+///         // we won't use the raw pointer anymore, thus we can transfer =
ownership to the `Owned`.
+///         Ok(unsafe { Owned::from_raw(result) })
+///     }
+/// }
+///
+/// // SAFETY: We increment and decrement each time the respective functio=
n is called and only free
+/// // the `Foo` when the refcount reaches zero.
+/// unsafe impl RefCounted for Foo {
+///     fn inc_ref(&self) {
+///         self.refcount.replace(self.refcount.get() + 1);
+///     }
+///
+///     unsafe fn dec_ref(this: NonNull<Self>) {
+///         // SAFETY: By requirement on calling this function, the refcou=
nt is non-zero,
+///         // implying the underlying object is valid.
+///         let refcount =3D unsafe { &this.as_ref().refcount };
+///         let new_refcount =3D refcount.get() - 1;
+///         if new_refcount =3D=3D 0 {
+///             // The `Foo` will be dropped when `KBox` goes out of scope=
.
+///             // SAFETY: The [`KBox<Foo>`] is still alive as the old ref=
count is 1. We can pass
+///             // ownership to the [`KBox`] as by requirement on calling =
this function,
+///             // the `Self` will no longer be used by the caller.
+///             unsafe { KBox::from_raw(this.as_ptr()) };
+///         } else {
+///             refcount.replace(new_refcount);
+///         }
+///     }
+/// }
+///
+/// impl OwnableRefCounted for Foo {
+///     fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<S=
elf>> {
+///         if this.refcount.get() =3D=3D 1 {
+///             // SAFETY: The `Foo` is still alive and has no other Rust =
references as the refcount
+///             // is 1.
+///             Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
+///         } else {
+///             Err(this)
+///         }
+///     }
+/// }
+///
+/// // SAFETY: What out `release()` function does is safe of any valid `Se=
lf`.
+/// unsafe impl Ownable for Foo {
+///     unsafe fn release(this: NonNull<Self>) {
+///         // SAFETY: Using `dec_ref()` from [`RefCounted`] to release is=
 okay, as the refcount is
+///         // always 1 for an [`Owned<Foo>`].
+///         unsafe{ Foo::dec_ref(this) };
+///     }
+/// }
+///
+/// let foo =3D Foo::new().expect("Failed to allocate a Foo. This shouldn'=
t happen");
+/// let mut foo =3D ARef::from(foo);
+/// {
+///     let bar =3D foo.clone();
+///     assert!(Owned::try_from(bar).is_err());
+/// }
+/// assert!(Owned::try_from(foo).is_ok());
+/// ```
+pub trait OwnableRefCounted: RefCounted + Ownable + Sized {
+    /// Checks if the [`ARef`] is unique and convert it to an [`Owned`] it=
 that is that case.
+    /// Otherwise it returns again an [`ARef`] to the same underlying obje=
ct.
+    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>=
>;
+
+    /// Converts the [`Owned`] into an [`ARef`].
+    fn into_shared(this: Owned<Self>) -> ARef<Self> {
+        // SAFETY: Safe by the requirements on implementing the trait.
+        unsafe { ARef::from_raw(Owned::into_raw(this)) }
+    }
+}
+
+impl<T: OwnableRefCounted> TryFrom<ARef<T>> for Owned<T> {
+    type Error =3D ARef<T>;
+    /// Tries to convert the [`ARef`] to an [`Owned`] by calling
+    /// [`try_from_shared()`](OwnableRefCounted::try_from_shared). In case=
 the [`ARef`] is not
+    /// unique, it returns again an [`ARef`] to the same underlying object=
.
+    fn try_from(b: ARef<T>) -> Result<Owned<T>, Self::Error> {
+        T::try_from_shared(b)
+    }
+}
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 97cfddd9ec2ad788a4a659f404a9b6790da08e29..605c56b3d634e048cdfe1524881=
ab1e2e76ae3a4 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -15,7 +15,10 @@
 /// Note: Implementing this trait allows types to be wrapped in an [`ARef<=
Self>`]. It requires an
 /// internal reference count and provides only shared references. If uniqu=
e references are required
 /// [`Ownable`](crate::types::Ownable) should be implemented which allows =
types to be wrapped in an
-/// [`Owned<Self>`](crate::types::Owned).
+/// [`Owned<Self>`](crate::types::Owned). Implementing the trait
+/// [`OwnableRefCounted`](crate::types::OwnableRefCounted) allows to conve=
rt between unique and
+/// shared references (i.e. [`Owned<Self>`](crate::types::Owned) and
+/// [`ARef<Self>`](crate::types::Owned)).
 ///
 /// # Safety
 ///
@@ -165,6 +168,12 @@ fn from(b: &T) -> Self {
     }
 }
=20
+impl<T: crate::types::OwnableRefCounted> From<crate::types::Owned<T>> for =
ARef<T> {
+    fn from(b: crate::types::Owned<T>) -> Self {
+        T::into_shared(b)
+    }
+}
+
 impl<T: RefCounted> Drop for ARef<T> {
     fn drop(&mut self) {
         // SAFETY: The type invariants guarantee that the `ARef` owns the =
reference we're about to
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 8ef01393352bb2510524bf070ad4141147ed945f..a9b72709d0d3c7fc58444a19fae=
896aed7506128 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -11,7 +11,7 @@
 };
 use pin_init::{PinInit, Wrapper, Zeroable};
=20
-pub use crate::owned::{Ownable, Owned};
+pub use crate::owned::{Ownable, OwnableRefCounted, Owned};
=20
 pub use crate::sync::aref::{ARef, AlwaysRefCounted, RefCounted};
=20

--=20
2.51.0



