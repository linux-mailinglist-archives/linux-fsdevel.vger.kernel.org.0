Return-Path: <linux-fsdevel+bounces-68700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6808FC63769
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 953EA359034
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F99328B6F;
	Mon, 17 Nov 2025 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Qn7dAqA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B1D2836B5;
	Mon, 17 Nov 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374083; cv=none; b=g2qlj/QnblfFlIo4+SNnq4cyMvPHw5Es0qRRnoM1zoZlgy1Lkj4XhwCK81mtOy+WvIpCBWcbhxmd+H75SfuI9jOogzZ/8MW7fv+GJFhp/nN5/tzAG1Ew57J7fzgkxvaQintm6c/bkV5N9Z5fVRVGFFHICuPXbhEqQzZGp9HAHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374083; c=relaxed/simple;
	bh=jpZk5fdr1FbGTvcXwuUgzLRFyktIVmKm8f+PST5zOQo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nst/AzyqqAftXftVbSKAPtIw+U7nqCTR9qVYZKlvC0mXxEj4UES9FeOeZ1FdKxipWXC1tI4R1RAKLfTtiHoXPENR1Vt8f5e/NUHT8BcF3SARskPePObcmXRztxpe1Kv5VyRIhK+SRnEnHU8xFqWgr+pHzj/q7iAnGg63YgH44ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Qn7dAqA1; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1763374068; x=1763633268;
	bh=czMapTTCi4R5TdphetRyqbsHUXkni8fdPMga8WOjbnA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Qn7dAqA1Fk/vZhqzzn2hVb+PVIas1wPPNkJCguSp9CyDPoJcv+6uy9Jx09BN7jyzK
	 TnqpELafm1PuS8HnBk96S6goDycgwPL9pRfFm29WbKEOQNqSDV++iX3TcKGTk3rrC6
	 C1n2aTrJ5YRxAbhBfNqku+sfdqHj4JqxInK2CNyCqFrdKrqep3nDGzPa7h27R5l9oU
	 d6AREmrBJeDnQfu3dZ+mF7acJ6sjYsf6yKJOVJLQxHsdLDnWAAFbfcc3vV4PYT1DIi
	 IMw2JJKgvxl0jKgAJWNJnIUsHG7Ho/SWl46ijf6rDDRZIwfj8oGgLvJwNUcBAXB/3j
	 V+/pwerYLoOdA==
Date: Mon, 17 Nov 2025 10:07:40 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-security-module@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v13 1/4] rust: types: Add Ownable/Owned types
Message-ID: <20251117-unique-ref-v13-1-b5b243df1250@pm.me>
In-Reply-To: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: c32f140374452e2c3a0e74d2725b9b299ac8643f
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
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/owned.rs     | 195 +++++++++++++++++++++++++++++++++++++++++++=
++++
 rust/kernel/sync/aref.rs |   5 ++
 rust/kernel/types.rs     |   2 +
 4 files changed, 203 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe7888..e0ee04330dd0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -112,6 +112,7 @@
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
+pub mod owned;
 pub mod page;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
new file mode 100644
index 000000000000..a2cdd2cb8a10
--- /dev/null
+++ b/rust/kernel/owned.rs
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Unique owned pointer types for objects with custom drop logic.
+//!
+//! These pointer types are useful for C-allocated objects which by API-co=
ntract
+//! are owned by Rust, but need to be freed through the C API.
+
+use core::{
+    mem::ManuallyDrop,
+    ops::{Deref, DerefMut},
+    pin::Pin,
+    ptr::NonNull,
+};
+
+/// Type allocated and destroyed on the C side, but owned by Rust.
+///
+/// Implementing this trait allows types to be referenced via the [`Owned<=
Self>`] pointer type. This
+/// is useful when it is desirable to tie the lifetime of the reference to=
 an owned object, rather
+/// than pass around a bare reference. [`Ownable`] types can define custom=
 drop logic that is
+/// executed when the owned reference [`Owned<Self>`] pointing to the obje=
ct is dropped.
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
+/// # use core::cell::Cell;
+/// # use core::ptr::NonNull;
+/// # use kernel::sync::global_lock;
+/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// # use kernel::types::{Owned, Ownable};
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
+    /// - `*this` is no longer used after this call.
+    unsafe fn release(this: NonNull<Self>);
+}
+
+/// An owned reference to an owned `T`.
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
index 0d24a0432015..e175aefe8615 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -29,6 +29,11 @@
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
index dc0a02f5c3cf..7bc07c38cd6c 100644
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
2.51.2



