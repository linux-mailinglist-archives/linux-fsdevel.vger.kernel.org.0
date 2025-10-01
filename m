Return-Path: <linux-fsdevel+bounces-63150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85345BAFC40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 11:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30678179130
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 09:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7782D97BB;
	Wed,  1 Oct 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="L9sVTHvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB772D879B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309440; cv=none; b=g61/5AkKpNCkWJe32/fwWWTaAyIPZ16CWZIXkA4abXCcqEUDQgHphY/wZ+9Tlkp57xRgixI8dGc6VzNyWrbdZN1UD/IvQuN3M8dAvKXB3wBpN1KaBnXAzdsV5en+vymMEoP5jbfX1S1JikPkz8AIJsCkWkuKAp0YDI2Zn6L7y3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309440; c=relaxed/simple;
	bh=z63AlyB/Lgx2QP51GJZlyDIfxMw2+ee+9raPI6J+m4I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4dy3jX0EBkzDGIGQ6GGib/vIaSLuE0Eftn4oqzkMtGcqOB5HdCqj24iry2J4uD6UKqgDvgwCTfTeSY4Xix3d5Cdsf22hCe3PYD8i6+uDysmQptUNqQNEvs7XqavL5ESCefKDOtVN2FnKF8sFdku9aaVX6ZSujnMJUDJXVlDnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=L9sVTHvM; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1759309434; x=1759568634;
	bh=YoI0D4NsBDAriHqvQCNsBFedVGBNu9amEcT5uTdvatQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=L9sVTHvMw4CrqyW+CsE9JaQwJVAo1oLei/965QD0Gyr/xDd3x3VmDqqRNN3EFvHIk
	 qGvW/IOiRXZVGs8Zr2Uq8BIN3mik48n48AVNcQP1l+nVzynsk4SMgmHLXQlJNoTdfe
	 Cm4n60ytoVcTxx7SSgp/RinH/mV59nr4yshFcbU2mereAc5tJw964pisXmwPgf/OpG
	 13YwgYGTYP713AHIAY+4JhTjT/Bd+AT3oizcLDvUnAzlaBa1Rvg+88iwzhw/wXdIH7
	 aZAZT/Qt8P6F01QOBu/dt2/yIl1UIICk7e6k2xtccYTWmxRcfKqmu+Abj9W8qHHTwA
	 WlYhCb22qDDQw==
Date: Wed, 01 Oct 2025 09:03:46 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v12 1/4] rust: types: Add Ownable/Owned types
Message-ID: <20251001-unique-ref-v12-1-fa5c31f0c0c4@pm.me>
In-Reply-To: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me>
References: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 4c3d84e501b0f9cf1753def9896c6efd7ea89700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Asahi Lina <lina+kernel@asahilina.net>

By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
(typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
`AlwaysRefCounted`, this mechanism expects the reference to be unique
within Rust, and does not allow cloning.

Conceptually, this is similar to a `KBox<T>`, except that it delegates
resource management to the `T` instead of using a generic allocator.

[ om:
  - Split code into separate file and `pub use` it from types.rs.
  - Make from_raw() and into_raw() public.
  - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
  - Usage example/doctest for Ownable/Owned.
  - Fixes to documentation and commit message.
]

Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asah=
ilina.net/
Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/owned.rs     | 195 +++++++++++++++++++++++++++++++++++++++++++=
++++
 rust/kernel/sync/aref.rs |   5 ++
 rust/kernel/types.rs     |   2 +
 4 files changed, 203 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c0badf548025a57f946fa18bc73e3..3aea741f668b7d7a1a16e8e4537=
e5edba997259c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -92,6 +92,7 @@
 pub mod init;
 pub mod io;
 pub mod ioctl;
+pub mod owned;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
new file mode 100644
index 0000000000000000000000000000000000000000..38f70a20fb965305d14836498a0=
e7ad73166c6c4
--- /dev/null
+++ b/rust/kernel/owned.rs
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Unique reference types for objects with custom destructors. They shoul=
d be used for C-allocated
+//! objects which by API-contract are owned by Rust, but need to be freed =
through the C API.
+
+use core::{
+    marker::PhantomData,
+    mem::ManuallyDrop,
+    ops::{Deref, DerefMut},
+    pin::Pin,
+    ptr::NonNull,
+};
+
+/// Type allocated and destroyed on the C side, but owned by Rust.
+///
+/// Implementing this trait allows types to be wrapped in an [`Owned<Self>=
`]. Such types can
+/// define their own custom destructor function to be called when the [`Ow=
ned<Self>`] is
+/// dropped.
+///
+/// Note: The underlying object is not required to provide internal refere=
nce counting, because it
+/// represents a unique, owned reference. If reference counting (on the Ru=
st side) is required,
+/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be impleme=
nted.
+///
+/// # Safety
+///
+/// Implementers must ensure that the [`release()`](Self::release) functio=
n frees the underlying
+/// object in the correct way for a valid, owned object of this type.
+///
+/// # Examples
+///
+/// A minimal example implementation of [`Ownable`] and its usage with [`O=
wned`] looks like this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// use core::cell::Cell;
+/// use core::ptr::NonNull;
+/// use kernel::sync::global_lock;
+/// use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// use kernel::types::{Owned, Ownable};
+///
+/// // Let's count the allocations to see if freeing works.
+/// kernel::sync::global_lock! {
+///     // SAFETY: we call `init()` right below, before doing anything els=
e.
+///     unsafe(uninit) static FOO_ALLOC_COUNT: Mutex<usize> =3D 0;
+/// }
+/// // SAFETY: We call `init()` only once, here.
+/// unsafe { FOO_ALLOC_COUNT.init() };
+///
+/// struct Foo {
+/// }
+///
+/// impl Foo {
+///     fn new() -> Result<Owned<Self>, AllocError> {
+///         // We are just using a `KBox` here to handle the actual alloca=
tion, as our `Foo` is
+///         // not actually a C-allocated object.
+///         let result =3D KBox::new(
+///             Foo {},
+///             flags::GFP_KERNEL,
+///         )?;
+///         let result =3D NonNull::new(KBox::into_raw(result))
+///             .expect("Raw pointer to newly allocation KBox is null, thi=
s should never happen.");
+///         // Count new allocation
+///         *FOO_ALLOC_COUNT.lock() +=3D 1;
+///         // SAFETY: We just allocated the `Self`, thus it is valid and =
there cannot be any other
+///         // Rust references. Calling `into_raw()` makes us responsible =
for ownership and we won't
+///         // use the raw pointer anymore. Thus we can transfer ownership=
 to the `Owned`.
+///         Ok(unsafe { Owned::from_raw(result) })
+///     }
+/// }
+///
+/// // SAFETY: What out `release()` function does is safe of any valid `Se=
lf`.
+/// unsafe impl Ownable for Foo {
+///     unsafe fn release(this: NonNull<Self>) {
+///         // The `Foo` will be dropped when `KBox` goes out of scope.
+///         // SAFETY: The [`KBox<Self>`] is still alive. We can pass owne=
rship to the [`KBox`], as
+///         // by requirement on calling this function, the `Self` will no=
 longer be used by the
+///         // caller.
+///         unsafe { KBox::from_raw(this.as_ptr()) };
+///         // Count released allocation
+///         *FOO_ALLOC_COUNT.lock() -=3D 1;
+///     }
+/// }
+///
+/// {
+///    let foo =3D Foo::new().expect("Failed to allocate a Foo. This shoul=
dn't happen");
+///    assert!(*FOO_ALLOC_COUNT.lock() =3D=3D 1);
+/// }
+/// // `foo` is out of scope now, so we expect no live allocations.
+/// assert!(*FOO_ALLOC_COUNT.lock() =3D=3D 0);
+/// ```
+pub unsafe trait Ownable {
+    /// Releases the object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    /// - `this` points to a valid `Self`.
+    /// - `*this` is no longer referenced after this call.
+    unsafe fn release(this: NonNull<Self>);
+}
+
+/// An owned reference to an [`Ownable`] object.
+///
+/// The [`Ownable`] is automatically freed or released when an instance of=
 [`Owned`] is
+/// dropped.
+///
+/// # Invariants
+///
+/// - The [`Owned<T>`] has exclusive access to the instance of `T`.
+/// - The instance of `T` will stay alive at least as long as the [`Owned<=
T>`] is alive.
+pub struct Owned<T: Ownable> {
+    ptr: NonNull<T>,
+    _p: PhantomData<T>,
+}
+
+// SAFETY: It is safe to send an [`Owned<T>`] to another thread when the u=
nderlying `T` is [`Send`],
+// because of the ownership invariant. Sending an [`Owned<T>`] is equivale=
nt to sending the `T`.
+unsafe impl<T: Ownable + Send> Send for Owned<T> {}
+
+// SAFETY: It is safe to send [`&Owned<T>`] to another thread when the und=
erlying `T` is [`Sync`],
+// because of the ownership invariant. Sending an [`&Owned<T>`] is equival=
ent to sending the `&T`.
+unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
+
+impl<T: Ownable> Owned<T> {
+    /// Creates a new instance of [`Owned`].
+    ///
+    /// It takes over ownership of the underlying object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    /// - `ptr` points to a valid instance of `T`.
+    /// - Ownership of the underlying `T` can be transferred to the `Self<=
T>` (i.e. operations
+    ///   which require ownership will be safe).
+    /// - No other Rust references to the underlying object exist. This im=
plies that the underlying
+    ///   object is not accessed through `ptr` anymore after the function =
call (at least until the
+    ///   the `Self<T>` is dropped.
+    /// - The C code follows the usual shared reference requirements. That=
 is, the kernel will never
+    ///   mutate or free the underlying object (excluding interior mutabil=
ity that follows the usual
+    ///   rules) while Rust owns it.
+    /// - In case `T` implements [`Unpin`] the previous requirement is ext=
ended from shared to
+    ///   mutable reference requirements. That is, the kernel will not mut=
ate or free the underlying
+    ///   object and is okay with it being modified by Rust code.
+    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+        Self {
+            ptr,
+            _p: PhantomData,
+        }
+    }
+
+    /// Consumes the [`Owned`], returning a raw pointer.
+    ///
+    /// This function does not actually relinquish ownership of the object=
. After calling this
+    /// function, the caller is responsible for ownership previously manag=
ed
+    /// by the [`Owned`].
+    pub fn into_raw(me: Self) -> NonNull<T> {
+        ManuallyDrop::new(me).ptr
+    }
+
+    /// Get a pinned mutable reference to the data owned by this `Owned<T>=
`.
+    pub fn get_pin_mut(&mut self) -> Pin<&mut T> {
+        // SAFETY: The type invariants guarantee that the object is valid,=
 and that we can safely
+        // return a mutable reference to it.
+        let unpinned =3D unsafe { self.ptr.as_mut() };
+
+        // SAFETY: We never hand out unpinned mutable references to the da=
ta in
+        // `Self`, unless the contained type is `Unpin`.
+        unsafe { Pin::new_unchecked(unpinned) }
+    }
+}
+
+impl<T: Ownable> Deref for Owned<T> {
+    type Target =3D T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: Ownable + Unpin> DerefMut for Owned<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid,=
 and that we can safely
+        // return a mutable reference to it.
+        unsafe { self.ptr.as_mut() }
+    }
+}
+
+impl<T: Ownable> Drop for Owned<T> {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that the `Owned` owns the=
 object we're about to
+        // release.
+        unsafe { T::release(self.ptr) };
+    }
+}
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index dbd77bb68617cab786fe4a1168d697e30a6de299..f8085cfe50db0798c3cdadab35a=
c6e2826c315f9 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -14,6 +14,11 @@
 /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to c=
reate reference-counted
 /// instances of a type.
 ///
+/// Note: Implementing this trait allows types to be wrapped in an [`ARef<=
Self>`]. It requires an
+/// internal reference count and provides only shared references. If uniqu=
e references are required
+/// [`Ownable`](crate::types::Ownable) should be implemented which allows =
types to be wrapped in an
+/// [`Owned<Self>`](crate::types::Owned).
+///
 /// # Safety
 ///
 /// Implementers must ensure that increments to the reference count keep t=
he object alive in memory
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index dc0a02f5c3cfc532d1fa5f209b40dd79cbe0fb37..7bc07c38cd6cb6abb59384e20a7=
93f28633a9eac 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -11,6 +11,8 @@
 };
 use pin_init::{PinInit, Wrapper, Zeroable};
=20
+pub use crate::owned::{Ownable, Owned};
+
 pub use crate::sync::aref::{ARef, AlwaysRefCounted};
=20
 /// Used to transfer ownership to and from foreign (non-Rust) languages.

--=20
2.51.0



