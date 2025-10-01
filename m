Return-Path: <linux-fsdevel+bounces-63151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C7BAFC58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 11:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8877A62FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA092D9792;
	Wed,  1 Oct 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="d5UfwiDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465D2D7DC3;
	Wed,  1 Oct 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309458; cv=none; b=GS2rSYVmaBL6ArAAn9GKCyyfcfuyj3jE5J9iQ4oK0d/2j4lti8kk7kPOFF4uvXxP4RHRQ8rLPilBqW5aD+XTy7srl06MK9qdl/KXqJzOD3KCQeu7Yy3PAobIQ6Me4dJin2qbRxZuUrU9OQOWE0NDEeO7dUAPrn0V3eJ3b28x51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309458; c=relaxed/simple;
	bh=5y4zcj1gcvZvNmKWuKMwTDLi8RpSjzPpgkNs3XB53Jw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOZQrqxVoHNuum2Ds83AlmqZ84xYX0N6ZTbea+rtlaq+OOCYcI0d4IpdB9X0J/41nNGCA/0+zvXud+Z2XZOPZma7Qpl6rs/xc+DS5q+bdYZWB5YxuoqDDT2mTNxh6Zh3FF9tvC3PHuoAOC6m0E9uq9QgDmQUlYWnVTLaFvzP24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=d5UfwiDU; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1759309444; x=1759568644;
	bh=FjV73AOvmni5qllqj0qFi4KSNxDrPzQBA0xgDZ9fnZI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=d5UfwiDUT5ymEQv/pDsAm+K1X8i543KkOtLNNXY7IW1hlbG/AIdHKo0THHcEhzjoh
	 y+dUfXdrHu4jXV5THsuDIW6IsgPtzA/ZDYkzBa1sP4B7YCujyIO6trc5G12qHfR4n5
	 veySkNvwXmCuhNtOgiAbEatzXByaH0yThVQ+ERKZsd7ztNt9Qv9B3FrQfv+IqoPBXE
	 mGZXCd3wZIdWFv3esm9S+e5ZxPxdyVY8YW/sMx7mAYFFfYSZK9PCkMOzesBxPHCXbF
	 9PyDdj40+yB5n6w1zQ8OqeCtdOHmV+q+5WU7bx/tcNoADVPB8Z7BIJZiCgHYpf4ZiN
	 5YptVjLSeD01Q==
Date: Wed, 01 Oct 2025 09:03:58 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v12 2/4] `AlwaysRefCounted` is renamed to `RefCounted`.
Message-ID: <20251001-unique-ref-v12-2-fa5c31f0c0c4@pm.me>
In-Reply-To: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me>
References: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 0b6ef3b8e154e0877a631c62412421623f34cbde
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`AlwaysRefCounted` will become a marker trait to indicate that it is
allowed to obtain an `ARef<T>` from a `&T`, which cannot be allowed for
types which are also Ownable.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Suggested-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/auxiliary.rs        |  7 +++++-
 rust/kernel/block/mq/request.rs | 14 +++++++-----
 rust/kernel/cred.rs             |  7 +++++-
 rust/kernel/device.rs           |  9 ++++++--
 rust/kernel/device/property.rs  |  7 +++++-
 rust/kernel/drm/device.rs       |  9 ++++++--
 rust/kernel/drm/gem/mod.rs      |  7 +++++-
 rust/kernel/fs/file.rs          | 13 ++++++++++--
 rust/kernel/mm.rs               | 12 +++++++++--
 rust/kernel/mm/mmput_async.rs   |  7 +++++-
 rust/kernel/opp.rs              |  7 +++++-
 rust/kernel/owned.rs            |  2 +-
 rust/kernel/pci.rs              |  7 +++++-
 rust/kernel/pid_namespace.rs    |  7 +++++-
 rust/kernel/platform.rs         |  7 +++++-
 rust/kernel/sync/aref.rs        | 47 ++++++++++++++++++++++++++-----------=
----
 rust/kernel/task.rs             |  7 +++++-
 rust/kernel/types.rs            |  2 +-
 18 files changed, 136 insertions(+), 42 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 4749fb6bffef34000d9029fecfd6553414feeae0..b5253521be1be7ded9727e596cb=
8402f9f9079a6 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -10,6 +10,7 @@
     driver,
     error::{from_result, to_result, Result},
     prelude::*,
+    sync::aref::{AlwaysRefCounted, RefCounted},
     types::Opaque,
     ThisModule,
 };
@@ -245,7 +246,7 @@ extern "C" fn release(dev: *mut bindings::device) {
 kernel::impl_device_context_into_aref!(Device);
=20
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the=
 refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -264,6 +265,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx=
> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a p=
ointer to a valid
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request=
.rs
index fefd394f064a7127dc9e4b6a246f6d11267ad247..6c074ca1d14e399e6505205cfd1=
9e702dbc4a914 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -8,6 +8,7 @@
     bindings,
     block::mq::Operations,
     error::Result,
+    sync::aref::RefCounted,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 use core::{
@@ -231,11 +232,10 @@ fn atomic_relaxed_op_unless(target: &AtomicU64, op: i=
mpl Fn(u64) -> u64, pred: u
         .is_ok()
 }
=20
-// SAFETY: All instances of `Request<T>` are reference counted. This
-// implementation of `AlwaysRefCounted` ensure that increments to the ref =
count
-// keeps the object alive in memory at least until a matching reference co=
unt
-// decrement is executed.
-unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
+// SAFETY: All instances of `Request<T>` are reference counted. This imple=
mentation of `RefCounted`
+// ensure that increments to the ref count keeps the object alive in memor=
y at least until a
+// matching reference count decrement is executed.
+unsafe impl<T: Operations> RefCounted for Request<T> {
     fn inc_ref(&self) {
         let refcount =3D &self.wrapper_ref().refcount();
=20
@@ -265,3 +265,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
         }
     }
 }
+
+// SAFETY: We currently do not implement `Ownable`, thus it is okay to obt=
ain an `ARef<Request>`
+// from a `&Request` (but this will change in the future).
+unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {}
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 2599f01e8b285f2106aefd27c315ae2aff25293c..d2b6a6b7430e8ee885706a894a2=
bd6b1b39e81cb 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -10,6 +10,7 @@
=20
 use crate::{
     bindings,
+    sync::aref::RefCounted,
     task::Kuid,
     types::{AlwaysRefCounted, Opaque},
 };
@@ -74,7 +75,7 @@ pub fn euid(&self) -> Kuid {
 }
=20
 // SAFETY: The type invariants guarantee that `Credential` is always ref-c=
ounted.
-unsafe impl AlwaysRefCounted for Credential {
+unsafe impl RefCounted for Credential {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
@@ -88,3 +89,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
         unsafe { bindings::put_cred(obj.cast().as_ptr()) };
     }
 }
+
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<Credential>` from a
+// `&Credential`.
+unsafe impl AlwaysRefCounted for Credential {}
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index b8613289de8e7cea3ad7e32ec088eedc28ebf723..b2e297db102f3cac4d719e5e8a0=
23bc022a88051 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,7 +6,8 @@
=20
 use crate::{
     bindings,
-    types::{ARef, ForeignOwnable, Opaque},
+    sync::aref::RefCounted,
+    types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
 };
 use core::{fmt, marker::PhantomData, ptr};
=20
@@ -292,7 +293,7 @@ pub fn fwnode(&self) -> Option<&property::FwNode> {
 kernel::impl_device_context_into_aref!(Device);
=20
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the=
 refcount is non-zero.
         unsafe { bindings::get_device(self.as_raw()) };
@@ -304,6 +305,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 // SAFETY: As by the type invariant `Device` can be sent to any thread.
 unsafe impl Send for Device {}
=20
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.r=
s
index 49ee12a906dbadbe932e207fc7a0d1d622125f5f..7f61caff2959bc1f70d61276ac4=
79f03f2565a41 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -13,6 +13,7 @@
     error::{to_result, Result},
     prelude::*,
     str::{CStr, CString},
+    sync::aref::{AlwaysRefCounted, RefCounted},
     types::{ARef, Opaque},
 };
=20
@@ -358,7 +359,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core=
::fmt::Result {
 }
=20
 // SAFETY: Instances of `FwNode` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for FwNode {
+unsafe impl RefCounted for FwNode {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the
         // refcount is non-zero.
@@ -372,6 +373,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<FwNode>` from a
+// `&FwNode`.
+unsafe impl AlwaysRefCounted for FwNode {}
+
 enum Node<'a> {
     Borrowed(&'a FwNode),
     Owned(ARef<FwNode>),
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 3bb7c83966cf2d2acfdf9053fc5b25ca7607da2b..0c0e57082d4a96981fa88a289fe=
e9c091a4d2ed5 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -10,7 +10,8 @@
     error::from_err_ptr,
     error::Result,
     prelude::*,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::aref::{AlwaysRefCounted, RefCounted},
+    types::{ARef, Opaque},
 };
 use core::{mem, ops::Deref, ptr, ptr::NonNull};
=20
@@ -182,7 +183,7 @@ fn deref(&self) -> &Self::Target {
=20
 // SAFETY: DRM device objects are always reference counted and the get/put=
 functions
 // satisfy the requirements.
-unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {
+unsafe impl<T: drm::Driver> RefCounted for Device<T> {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the=
 refcount is non-zero.
         unsafe { bindings::drm_dev_get(self.as_raw()) };
@@ -194,6 +195,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<Device>` from a
+// `&Device`.
+unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {}
+
 impl<T: drm::Driver> AsRef<device::Device> for Device<T> {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: `bindings::drm_device::dev` is valid as long as the DRM=
 device itself is valid,
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index b71821cfb5eaa00eb3a95646fa0a8b8a1ad0790b..8ef012f4fde4796013e86d5eef2=
b3077449ed984 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -10,6 +10,7 @@
     drm::driver::{AllocImpl, AllocOps},
     error::{to_result, Result},
     prelude::*,
+    sync::aref::RefCounted,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 use core::{mem, ops::Deref, ptr::NonNull};
@@ -55,7 +56,7 @@ pub trait IntoGEMObject: Sized + super::private::Sealed +=
 AlwaysRefCounted {
 }
=20
 // SAFETY: All gem objects are refcounted.
-unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
+unsafe impl<T: IntoGEMObject> RefCounted for T {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the=
 refcount is non-zero.
         unsafe { bindings::drm_gem_object_get(self.as_raw()) };
@@ -74,6 +75,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<T>` from a
+// `&T`.
+unsafe impl<T: IntoGEMObject> crate::types::AlwaysRefCounted for T {}
+
 /// Trait which must be implemented by drivers using base GEM objects.
 pub trait DriverObject: BaseDriverObject<Object<Self>> {
     /// Parent `Driver` for this object.
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 35fd5db35c465279acb3b88dc3c90c8f95d29cf4..7b457443774d127538053268f1d=
bb4f8254c66d2 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -11,6 +11,7 @@
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
+    sync::aref::RefCounted,
     types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use core::ptr;
@@ -190,7 +191,7 @@ unsafe impl Sync for File {}
=20
 // SAFETY: The type invariants guarantee that `File` is always ref-counted=
. This implementation
 // makes `ARef<File>` own a normal refcount.
-unsafe impl AlwaysRefCounted for File {
+unsafe impl RefCounted for File {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
@@ -205,6 +206,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<File>` from a
+// `&File`.
+unsafe impl AlwaysRefCounted for File {}
+
 /// Wraps the kernel's `struct file`. Not thread safe.
 ///
 /// This type represents a file that is not known to be safe to transfer a=
cross thread boundaries.
@@ -226,7 +231,7 @@ pub struct LocalFile {
=20
 // SAFETY: The type invariants guarantee that `LocalFile` is always ref-co=
unted. This implementation
 // makes `ARef<LocalFile>` own a normal refcount.
-unsafe impl AlwaysRefCounted for LocalFile {
+unsafe impl RefCounted for LocalFile {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
@@ -242,6 +247,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<LocalFile>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<LocalFile>` from a
+// `&LocalFile`.
+unsafe impl AlwaysRefCounted for LocalFile {}
+
 impl LocalFile {
     /// Constructs a new `struct file` wrapper from a file descriptor.
     ///
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 43f525c0d16ce87340ba4f991c45d4e82a050eae..dd9e3969e720662de0f032f1f66=
9ac37e64edc7d 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -13,6 +13,7 @@
=20
 use crate::{
     bindings,
+    sync::aref::RefCounted,
     types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use core::{ops::Deref, ptr::NonNull};
@@ -54,7 +55,7 @@ unsafe impl Send for Mm {}
 unsafe impl Sync for Mm {}
=20
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for Mm {
+unsafe impl RefCounted for Mm {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -68,6 +69,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<Mm>` from a `&Mm`.
+unsafe impl AlwaysRefCounted for Mm {}
+
 /// A wrapper for the kernel's `struct mm_struct`.
 ///
 /// This type is like [`Mm`], but with non-zero `mm_users`. It can only be=
 used when `mm_users` can
@@ -90,7 +94,7 @@ unsafe impl Send for MmWithUser {}
 unsafe impl Sync for MmWithUser {}
=20
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for MmWithUser {
+unsafe impl RefCounted for MmWithUser {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -104,6 +108,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<MmWithUser>` from a
+// `&MmWithUser`.
+unsafe impl AlwaysRefCounted for MmWithUser {}
+
 // Make all `Mm` methods available on `MmWithUser`.
 impl Deref for MmWithUser {
     type Target =3D Mm;
diff --git a/rust/kernel/mm/mmput_async.rs b/rust/kernel/mm/mmput_async.rs
index 9289e05f7a676b577e4edf45949c0fab6aacec14..aba4ce675c860e46e04b9535acc=
fb3d611ec28fe 100644
--- a/rust/kernel/mm/mmput_async.rs
+++ b/rust/kernel/mm/mmput_async.rs
@@ -10,6 +10,7 @@
 use crate::{
     bindings,
     mm::MmWithUser,
+    sync::aref::RefCounted,
     types::{ARef, AlwaysRefCounted},
 };
 use core::{ops::Deref, ptr::NonNull};
@@ -34,7 +35,7 @@ unsafe impl Send for MmWithUserAsync {}
 unsafe impl Sync for MmWithUserAsync {}
=20
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for MmWithUserAsync {
+unsafe impl RefCounted for MmWithUserAsync {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -48,6 +49,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<MmWithUserAsync>`
+// from a `&MmWithUserAsync`.
+unsafe impl AlwaysRefCounted for MmWithUserAsync {}
+
 // Make all `MmWithUser` methods available on `MmWithUserAsync`.
 impl Deref for MmWithUserAsync {
     type Target =3D MmWithUser;
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 08126035d2c66f849e4893ff2418d46d28bee84c..172dcfe5fd7be2110fdf08402a7=
e287c5d073cf4 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -16,6 +16,7 @@
     ffi::c_ulong,
     prelude::*,
     str::CString,
+    sync::aref::RefCounted,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
=20
@@ -1042,7 +1043,7 @@ unsafe impl Send for OPP {}
 unsafe impl Sync for OPP {}
=20
 /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounte=
d.
-unsafe impl AlwaysRefCounted for OPP {
+unsafe impl RefCounted for OPP {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
         unsafe { bindings::dev_pm_opp_get(self.0.get()) };
@@ -1054,6 +1055,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<OPP>` from an
+// `&OPP`.
+unsafe impl AlwaysRefCounted for OPP {}
+
 impl OPP {
     /// Creates an owned reference to a [`OPP`] from a valid pointer.
     ///
diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index 38f70a20fb965305d14836498a0e7ad73166c6c4..466b7ecda6d9f4f54852ca0b59b=
36ac882ab3f47 100644
--- a/rust/kernel/owned.rs
+++ b/rust/kernel/owned.rs
@@ -19,7 +19,7 @@
 ///
 /// Note: The underlying object is not required to provide internal refere=
nce counting, because it
 /// represents a unique, owned reference. If reference counting (on the Ru=
st side) is required,
-/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be impleme=
nted.
+/// [`RefCounted`](crate::types::RefCounted) should be implemented.
 ///
 /// # Safety
 ///
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b55310e7edbd512f9017b708ff9d7bd8..9d7861fc4b99ef67859296a400b=
ac87e1bafdd2a 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -13,6 +13,7 @@
     io::Io,
     io::IoRaw,
     str::CStr,
+    sync::aref::{AlwaysRefCounted, RefCounted},
     types::{ARef, Opaque},
     ThisModule,
 };
@@ -455,7 +456,7 @@ pub fn set_master(&self) {
 impl crate::dma::Device for Device<device::Core> {}
=20
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the=
 refcount is non-zero.
         unsafe { bindings::pci_dev_get(self.as_raw()) };
@@ -467,6 +468,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx=
> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a p=
ointer to a valid
diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
index 0e93808e4639b37dd77add5d79f64058dac7cb87..4f6a94540e33d73eb9f2faa416b=
ca66df3b66940 100644
--- a/rust/kernel/pid_namespace.rs
+++ b/rust/kernel/pid_namespace.rs
@@ -9,6 +9,7 @@
=20
 use crate::{
     bindings,
+    sync::aref::RefCounted,
     types::{AlwaysRefCounted, Opaque},
 };
 use core::ptr;
@@ -44,7 +45,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_name=
space) -> &'a Self {
 }
=20
 // SAFETY: Instances of `PidNamespace` are always reference-counted.
-unsafe impl AlwaysRefCounted for PidNamespace {
+unsafe impl RefCounted for PidNamespace {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
@@ -58,6 +59,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<PidNamespace>` from
+// a `&PidNamespace`.
+unsafe impl AlwaysRefCounted for PidNamespace {}
+
 // SAFETY:
 // - `PidNamespace::dec_ref` can be called from any thread.
 // - It is okay to send ownership of `PidNamespace` across thread boundari=
es.
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8f028c76f9fa6154f440b48921ba16573a9d3c54..75c382040e27e9f40bff6a66d35=
409318379133d 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -12,6 +12,7 @@
     io::{mem::IoRequest, Resource},
     of,
     prelude::*,
+    sync::aref::{AlwaysRefCounted, RefCounted},
     types::Opaque,
     ThisModule,
 };
@@ -292,7 +293,7 @@ pub fn io_request_by_name(&self, name: &CStr) -> Option=
<IoRequest<'_>> {
 impl crate::dma::Device for Device<device::Core> {}
=20
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the=
 refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -304,6 +305,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx=
> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a p=
ointer to a valid
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index f8085cfe50db0798c3cdadab35ac6e2826c315f9..e029b4c046449a6b0bb61bb6369=
ac26f9495b2ad 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -4,11 +4,9 @@
=20
 use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonNul=
l};
=20
-/// Types that are _always_ reference counted.
+/// Types that are internally reference counted.
 ///
 /// It allows such types to define their own custom ref increment and decr=
ement functions.
-/// Additionally, it allows users to convert from a shared reference `&T` =
to an owned reference
-/// [`ARef<T>`].
 ///
 /// This is usually implemented by wrappers to existing structures on the =
C side of the code. For
 /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to c=
reate reference-counted
@@ -25,9 +23,8 @@
 /// at least until matching decrements are performed.
 ///
 /// Implementers must also ensure that all instances are reference-counted=
. (Otherwise they
-/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_r=
ef`] keep the object
-/// alive.)
-pub unsafe trait AlwaysRefCounted {
+/// won't be able to honour the requirement that [`RefCounted::inc_ref`] k=
eep the object alive.)
+pub unsafe trait RefCounted {
     /// Increments the reference count on the object.
     fn inc_ref(&self);
=20
@@ -40,11 +37,27 @@ pub unsafe trait AlwaysRefCounted {
     /// Callers must ensure that there was a previous matching increment t=
o the reference count,
     /// and that the object is no longer used after its reference count is=
 decremented (as it may
     /// result in the object being freed), unless the caller owns another =
increment on the refcount
-    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
-    /// [`AlwaysRefCounted::dec_ref`] once).
+    /// (e.g., it calls [`RefCounted::inc_ref`] twice, then calls [`RefCou=
nted::dec_ref`] once).
     unsafe fn dec_ref(obj: NonNull<Self>);
 }
=20
+/// Always reference-counted type.
+///
+/// It allows to derive a counted reference [`ARef<T>`] from a `&T`.
+///
+/// This provides some convenience, but it allows "escaping" borrow checks=
 on `&T`. As it
+/// complicates attempts to ensure that a reference to T is unique, it is =
optional to provide for
+/// [`RefCounted`] types. See *Safety* below.
+///
+/// # Safety
+///
+/// Implementers must ensure that no safety invariants are violated by upg=
rading an `&T` to an
+/// [`ARef<T>`]. In particular that implies [`AlwaysRefCounted`] and [`cra=
te::types::Ownable`]
+/// cannot be implemented for the same type, as this would allow to violat=
e the uniqueness guarantee
+/// of [`crate::types::Owned<T>`] by derefencing it into an `&T` and obtai=
ning an [`ARef`] from
+/// that.
+pub unsafe trait AlwaysRefCounted: RefCounted {}
+
 /// An owned reference to an always-reference-counted object.
 ///
 /// The object's reference count is automatically decremented when an inst=
ance of [`ARef`] is
@@ -55,7 +68,7 @@ pub unsafe trait AlwaysRefCounted {
 ///
 /// The pointer stored in `ptr` is non-null and valid for the lifetime of =
the [`ARef`] instance. In
 /// particular, the [`ARef`] instance owns an increment on the underlying =
object's reference count.
-pub struct ARef<T: AlwaysRefCounted> {
+pub struct ARef<T: RefCounted> {
     ptr: NonNull<T>,
     _p: PhantomData<T>,
 }
@@ -64,16 +77,16 @@ pub struct ARef<T: AlwaysRefCounted> {
 // it effectively means sharing `&T` (which is safe because `T` is `Sync`)=
; additionally, it needs
 // `T` to be `Send` because any thread that has an `ARef<T>` may ultimatel=
y access `T` using a
 // mutable reference, for example, when the reference count reaches zero a=
nd `T` is dropped.
-unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
+unsafe impl<T: RefCounted + Sync + Send> Send for ARef<T> {}
=20
 // SAFETY: It is safe to send `&ARef<T>` to another thread when the underl=
ying `T` is `Sync`
 // because it effectively means sharing `&T` (which is safe because `T` is=
 `Sync`); additionally,
 // it needs `T` to be `Send` because any thread that has a `&ARef<T>` may =
clone it and get an
 // `ARef<T>` on that thread, so the thread may ultimately access `T` using=
 a mutable reference, for
 // example, when the reference count reaches zero and `T` is dropped.
-unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
+unsafe impl<T: RefCounted + Sync + Send> Sync for ARef<T> {}
=20
-impl<T: AlwaysRefCounted> ARef<T> {
+impl<T: RefCounted> ARef<T> {
     /// Creates a new instance of [`ARef`].
     ///
     /// It takes over an increment of the reference count on the underlyin=
g object.
@@ -102,12 +115,12 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// ```
     /// use core::ptr::NonNull;
-    /// use kernel::types::{ARef, AlwaysRefCounted};
+    /// use kernel::sync::aref::{ARef, RefCounted};
     ///
     /// struct Empty {}
     ///
     /// # // SAFETY: TODO.
-    /// unsafe impl AlwaysRefCounted for Empty {
+    /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
     /// }
@@ -125,7 +138,7 @@ pub fn into_raw(me: Self) -> NonNull<T> {
     }
 }
=20
-impl<T: AlwaysRefCounted> Clone for ARef<T> {
+impl<T: RefCounted> Clone for ARef<T> {
     fn clone(&self) -> Self {
         self.inc_ref();
         // SAFETY: We just incremented the refcount above.
@@ -133,7 +146,7 @@ fn clone(&self) -> Self {
     }
 }
=20
-impl<T: AlwaysRefCounted> Deref for ARef<T> {
+impl<T: RefCounted> Deref for ARef<T> {
     type Target =3D T;
=20
     fn deref(&self) -> &Self::Target {
@@ -150,7 +163,7 @@ fn from(b: &T) -> Self {
     }
 }
=20
-impl<T: AlwaysRefCounted> Drop for ARef<T> {
+impl<T: RefCounted> Drop for ARef<T> {
     fn drop(&mut self) {
         // SAFETY: The type invariants guarantee that the `ARef` owns the =
reference we're about to
         // decrement.
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 7d0935bc325cb8755f6878688d623d5d1da37225..ce20a91c3f9bf2ae94c3354b0ce=
66c8b3a26e616 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -9,6 +9,7 @@
     ffi::{c_int, c_long, c_uint},
     mm::MmWithUser,
     pid_namespace::PidNamespace,
+    sync::aref::{AlwaysRefCounted, RefCounted},
     types::{ARef, NotThreadSafe, Opaque},
 };
 use core::{
@@ -347,7 +348,7 @@ pub fn active_pid_ns(&self) -> Option<&PidNamespace> {
 }
=20
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
-unsafe impl crate::types::AlwaysRefCounted for Task {
+unsafe impl RefCounted for Task {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
@@ -361,6 +362,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `AR=
ef<Task>` from a
+// `&Task`.
+unsafe impl AlwaysRefCounted for Task {}
+
 impl Kuid {
     /// Get the current euid.
     #[inline]
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 7bc07c38cd6cb6abb59384e20a793f28633a9eac..8ef01393352bb2510524bf070ad=
4141147ed945f 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -13,7 +13,7 @@
=20
 pub use crate::owned::{Ownable, Owned};
=20
-pub use crate::sync::aref::{ARef, AlwaysRefCounted};
+pub use crate::sync::aref::{ARef, AlwaysRefCounted, RefCounted};
=20
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///

--=20
2.51.0



