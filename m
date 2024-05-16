Return-Path: <linux-fsdevel+bounces-19617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5C28C7CEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512821C231C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868415E5A7;
	Thu, 16 May 2024 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="QeEAS47O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D41586DB;
	Thu, 16 May 2024 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886328; cv=none; b=VpeRX2+8Y68W97H1DJzVB1FgZRForVf3dYAm2Y/l79aGXf03WOWWbQUuWzr2mxIKlqJRzXPUjfVcbiLzA4jtiF85+m71F3zvKTlSAdDKIPR8Eyvys7oBYfIju5QFpxIzzW0Hw6MHhhIArDkRc4XM0SP58Izx1Bbj5FpMtApnp50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886328; c=relaxed/simple;
	bh=ivMYgIYWIJYUOpRQp9sC48jKIyVBnsdndwyo/5V1fdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZY0qpLU8OBym6+EbGpX8HxS7uuEuHsWGWCteR4S6Cwx0VS2kosGGUshvfJmpgcwoodcooIHlDy+KkPSCfUDK2es3Lq8oXLdsN+Kaji7qNI2kbc1R1LpPHotJhedXd8GV9Sb9t6QCtODoYcE/j472f6MZfATKLT3RVw767mB7XGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=QeEAS47O; arc=none smtp.client-ip=173.38.203.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10222; q=dns/txt;
  s=iport; t=1715886326; x=1717095926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r1r9rd3KeEvtlJHyqBIHLSruG9tMof1Km6W29D4ICag=;
  b=QeEAS47ObBHz5ssKohIDUcnuIoi36QTrVGYGOTnnlgzy1lCZ1biXDbsB
   aImmhATQcpLfuo84Ot9yeKSkh057dQg7knAYNCqreT8x/UG9djRCjbHsF
   QgGCzm4M4J27gDedopZocUFcSBfv3l0gtIQz1Dy310Sjho2SCeMqUnRW+
   0=;
X-CSE-ConnectionGUID: RoOBx6bTTeS67jNRJTcCCg==
X-CSE-MsgGUID: SM4doMEZR8O+f5sjHbTXBQ==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="10016315"
Received: from aer-iport-nat.cisco.com (HELO aer-core-3.cisco.com) ([173.38.203.22])
  by aer-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:23 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-3.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4Nig017911
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:23 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Alice Ryhl <aliceryhl@google.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 18/22] rust: add improved version of `ForeignOwnable::borrow_mut`
Date: Thu, 16 May 2024 22:03:41 +0300
Message-Id: <20240516190345.957477-19-amiculas@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516190345.957477-1-amiculas@cisco.com>
References: <20240516190345.957477-1-amiculas@cisco.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.83.14, ams3-vpn-dhcp4879.cisco.com
X-Outbound-Node: aer-core-3.cisco.com

From: Alice Ryhl <aliceryhl@google.com>

Previously, the `ForeignOwnable` trait had a method called `borrow_mut`
that was intended to provide mutable access to the inner value. However,
the method accidentally made it possible to change the address of the
object being modified, which usually isn't what we want. (And when we
want that, it can be done by calling `from_foreign` and `into_foreign`,
like how the old `borrow_mut` was implemented.)

In this patch, we introduce an alternate definition of `borrow_mut` that
solves the previous problem. Conceptually, given a pointer type `P` that
implements `ForeignOwnable`, the `borrow_mut` method gives you the same
kind of access as an `&mut P` would, except that it does not let you
change the pointer `P` itself.

This is analogous to how the existing `borrow` method provides the same
kind of access to the inner value as an `&P`.

Note that for types like `Arc`, having an `&mut Arc<T>` only gives you
immutable access to the inner `T`. This is because mutable references
assume exclusive access, but there might be other handles to the same
reference counted value, so the access isn't exclusive. The `Arc` type
implements this by making `borrow_mut` return the same type as `borrow`.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20230710074642.683831-1-aliceryhl@google.com
Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/kernel/sync/arc.rs | 25 +++++++----
 rust/kernel/types.rs    | 93 ++++++++++++++++++++++++++++++-----------
 2 files changed, 86 insertions(+), 32 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3673496c2363..9023479281f0 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -356,26 +356,35 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
+    // Mutable access to the `Arc` does not give any extra abilities over
+    // immutable access.
+    type BorrowedMut<'a> = ArcBorrow<'a, T>;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr() as _
     }
 
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
+        // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
+        // holds a reference count increment that is transferrable to us.
+        unsafe { Self::from_inner(NonNull::new_unchecked(ptr as _)) }
+    }
+
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`.
-        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
+        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
 
-        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
-        // for the lifetime of the returned value.
+        // SAFETY: The safety requirements ensure that we will not give up our
+        // foreign-owned refcount while the `ArcBorrow` is still live.
         unsafe { ArcBorrow::new(inner) }
     }
 
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
-        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
-        // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
-        // holds a reference count increment that is transferrable to us.
-        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
+    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
+        // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
+        // requirements for `borrow`.
+        unsafe { Self::borrow(ptr) }
     }
 }
 
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 4d8f02671e0b..17b66d6187ae 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -20,31 +20,25 @@
 /// This trait is meant to be used in cases when Rust objects are stored in C objects and
 /// eventually "freed" back to Rust.
 pub trait ForeignOwnable: Sized {
-    /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
-    /// [`ForeignOwnable::from_foreign`].
+    /// Type used to immutably borrow a value that is currently foreign-owned.
     type Borrowed<'a>;
 
+    /// Type used to mutably borrow a value that is currently foreign-owned.
+    type BorrowedMut<'a>;
+
     /// Converts a Rust-owned object to a foreign-owned one.
     ///
     /// The foreign representation is a pointer to void.
     fn into_foreign(self) -> *const core::ffi::c_void;
 
-    /// Borrows a foreign-owned object.
-    ///
-    /// # Safety
-    ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
-
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
     /// # Safety
     ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] for
-    /// this object must have been dropped.
+    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and it
+    /// must not be passed to `from_foreign` more than once.
+    ///
+    /// [`into_foreign`]: Self::into_foreign
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
 
     /// Tries to convert a foreign-owned object back to a Rust-owned one.
@@ -65,40 +59,91 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
             unsafe { Some(Self::from_foreign(ptr)) }
         }
     }
+
+    /// Borrows a foreign-owned object immutably.
+    ///
+    /// This method provides a way to access a foreign-owned value from Rust immutably. It provides
+    /// you with exactly the same abilities as an `&Self` when the value is Rust-owned.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and if
+    /// the pointer is ever passed to [`from_foreign`], then that call must happen after the end of
+    /// the lifetime 'a.
+    ///
+    /// [`into_foreign`]: Self::into_foreign
+    /// [`from_foreign`]: Self::from_foreign
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
+
+    /// Borrows a foreign-owned object mutably.
+    ///
+    /// This method provides a way to access a foreign-owned value from Rust mutably. It provides
+    /// you with exactly the same abilities as an `&mut Self` when the value is Rust-owned, except
+    /// that this method does not let you swap the foreign-owned object for another. (That is, it
+    /// does not let you change the address of the void pointer that the foreign code is storing.)
+    ///
+    /// Note that for types like [`Arc`], an `&mut Arc<T>` only gives you immutable access to the
+    /// inner value, so this method also only provides immutable access in that case.
+    ///
+    /// In the case of `Box<T>`, this method gives you the ability to modify the inner `T`, but it
+    /// does not let you change the box itself. That is, you cannot change which allocation the box
+    /// points at.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and if
+    /// the pointer is ever passed to [`from_foreign`], then that call must happen after the end of
+    /// the lifetime 'a.
+    ///
+    /// The lifetime 'a must not overlap with the lifetime of any other call to [`borrow`] or
+    /// `borrow_mut` on the same object.
+    ///
+    /// [`into_foreign`]: Self::into_foreign
+    /// [`from_foreign`]: Self::from_foreign
+    /// [`borrow`]: Self::borrow
+    /// [`Arc`]: crate::sync::Arc
+    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> Self::BorrowedMut<'a>;
 }
 
 impl<T: 'static> ForeignOwnable for Box<T> {
     type Borrowed<'a> = &'a T;
+    type BorrowedMut<'a> = &'a mut T;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         Box::into_raw(self) as _
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
-        // SAFETY: The safety requirements for this function ensure that the object is still alive,
-        // so it is safe to dereference the raw pointer.
-        // The safety requirements of `from_foreign` also ensure that the object remains alive for
-        // the lifetime of the returned value.
-        unsafe { &*ptr.cast() }
-    }
-
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         unsafe { Box::from_raw(ptr as _) }
     }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+        // SAFETY: The safety requirements of this method ensure that the object remains alive and
+        // immutable for the duration of 'a.
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> &'a mut T {
+        // SAFETY: The safety requirements of this method ensure that the pointer is valid and that
+        // nothing else will access the value for the duration of 'a.
+        unsafe { &mut *ptr.cast_mut().cast() }
+    }
 }
 
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
+    type BorrowedMut<'a> = ();
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
-
     unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
+
+    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
+    unsafe fn borrow_mut<'a>(_: *const core::ffi::c_void) -> Self::BorrowedMut<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.
-- 
2.34.1


