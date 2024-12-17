Return-Path: <linux-fsdevel+bounces-37644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863419F4F75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 16:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1A018856D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F431F75B1;
	Tue, 17 Dec 2024 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro2jqnLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F21F755A;
	Tue, 17 Dec 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449314; cv=none; b=M712ERZAL5VgQ2T4YKVz75y6MegxmK7DZkeYxBwrAkZXdSDIjhF6Gpgggn2miLFx+LOld5X/ulGIvgHSJfXuzWLPeLonQl5mMZZxs6FDvmnuDqOiC56cpOBXJhkLSgPPI7b8OLnNsUdfuDrxpai3QhJye9oJyEJW+08jr+l/Kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449314; c=relaxed/simple;
	bh=IChPUjNCOrd55ODNSferCyjlIKM5gjzyDBdznTvyN8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8gsogF1klu6vbKqpc9Yoq6v44nN7YYh3uci2YarOeJFfKTG2sD5I/XhibDbUaNRQBgSlaoB2qKVLzD0kFNjSMFeKZRHNKSRhbexGVLLZ9asdeVUU765GBuGbP1TTaVJwm+pe6BzIECPuto6CzJR9jeEFVGx/pp+lGJF2f+VgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro2jqnLv; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8e8445219so47400166d6.0;
        Tue, 17 Dec 2024 07:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734449311; x=1735054111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejs/x3ur9LR2fjA8LMGeYXiF+falO/4YJI0BB2zkSsU=;
        b=Ro2jqnLvyoY5e941F6EhJRHSEZX+0tzt34qd4HDcEALyAWCqBqxpyGrhwKUKkChHAZ
         HO1+HfYkfyKAsQxj1u4gTsf/0AyF+kuCwlMrN8OBVpLNp8R+aTacU5YN2yPfTBUbnlum
         MWhqNGMCnkHKP0TcyuBrIl3JL3jJy5n2qmPcMJGZj8wd+uQQSd604QA2nKPjY3U07od8
         AgrvbuUSH8YOjwRGaBD/hBZMAjjY0FX6+N9hmZQ7UcbaI3Wu4TEEvsls33Cx9KhpyJHV
         tvmB1/TQ0QKOYTbpLIzEjLAGHLQdYyLv8zmhKuytARjSgeyC0N171lJEat77Iske3T4p
         OWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734449311; x=1735054111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejs/x3ur9LR2fjA8LMGeYXiF+falO/4YJI0BB2zkSsU=;
        b=Bz54zmd8fXljwyBC+HAfHWbrDCYBb+/wW2iaSrU4j8A3eozexQKRHK0GJAwweTMxWZ
         4iSPwybW0QDu5vwprARy8pbwmdq/3aiXVJunM8fv/EXUJWUFHWEm1xotoBAU2PPOSWF0
         8qrSFYf7EHkl/0k5hFu6bJXOwfLNNRkbIyCeMN9p7av1NSNUrQ1zNQVmC++358XEbeV+
         Ma71YtJVDGCbk7kl2ON1V479GJH6PJk+kveNVzsKrrk+cgW6O+RM5MX1FkPX4zTfC3La
         R0AJWzuVyfZMPirevQuEroJdPbT/QrsRnkFe/EJDmiZ7M+4Z2sEWa93UccIbBdRGvRdT
         yrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQar4Oe/GueNO/26arjE1dl8Ib813FAZHbSMRtSSYgeqbR4tuz7mwqJldhsp/90gXVZFmg1J+MxpdwaWU8@vger.kernel.org, AJvYcCV/ZotMfROzz/4DE0VyEtKrHlkzYD5Q5g9CbezV3xWKWHclpxR6zwXTNCKCRVHb1QG+lTuxKOl8+f/o8Nm0yfA=@vger.kernel.org, AJvYcCWaCRSPjA+hjDPeJ2wQmY8XywJesW227Es/yPXDY5JvxKg6YQkInMkN5Zv7fdCh6QKhcrfVtyiuyrADgadk@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/fIxja5DJIxFC3rncJAGSkIJABCU4ZHQXlQj8UFtlC/8hzII
	mfTn5ZxOiUfqzDMBfc4HW+GG0BeX4rwOr4CT4GNMOxM6Nj+vVbTDDTHexQNE
X-Gm-Gg: ASbGncssmAD53X0bqPFwNpP5/IbzbGvyrsVcAVMxZhOS2pYHuZh8O3R4NoyGhndFtWH
	6av/mWU3zz9vzoKrWQ7vRaJxbypFkIIs4ANt1rtfzKagbaoapn/L15Sic25zctBt2GoYDFCEZhH
	SW56hP82rQPXNne3hYALxmJusMeCydbxtveRmTFRKgQ6EtqjRfDCBAT/iaENGNcmSG2kGjnLVZT
	2cEOEZqeC6BmnQSOYGUZ2/ZHJA2fqPhmhxUEAgR9WJoXFebL91D714Ve2AietFNp+ouBUu4znUL
	S+brY5vpMrehTGsuoFotBxjOlxJ4eHBSCSJUiGFvd/RFV9sXBmSOcS+b1vRi
X-Google-Smtp-Source: AGHT+IH0T6eZM5HYflmM9i1/mjKcZm7XdiIftDPR5J+BlxvdRFQZJ0kj8K9zXWELvr8RXwkKYpxdsA==
X-Received: by 2002:ad4:5ca4:0:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6dc8e95fb73mr281639256d6.38.1734449310566;
        Tue, 17 Dec 2024 07:28:30 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:49e6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2ca057asm40250071cf.20.2024.12.17.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 07:28:29 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 17 Dec 2024 10:28:17 -0500
Subject: [PATCH v14 1/2] rust: types: add `ForeignOwnable::PointedTo`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-rust-xarray-bindings-v14-1-9fef3cefcb41@gmail.com>
References: <20241217-rust-xarray-bindings-v14-0-9fef3cefcb41@gmail.com>
In-Reply-To: <20241217-rust-xarray-bindings-v14-0-9fef3cefcb41@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Allow implementors to specify the foreign pointer type; this exposes
information about the pointed-to type such as its alignment.

This requires the trait to be `unsafe` since it is now possible for
implementors to break soundness by returning a misaligned pointer.

Encoding the pointer type in the trait (and avoiding pointer casts)
allows the compiler to check that implementors return the correct
pointer type. This is preferable to directly encoding the alignment in
the trait using a constant as the compiler would be unable to check it.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kbox.rs | 38 ++++++++++++++++++++------------------
 rust/kernel/miscdevice.rs |  6 +++---
 rust/kernel/sync/arc.rs   | 21 ++++++++++++---------
 rust/kernel/types.rs      | 46 +++++++++++++++++++++++++++++++---------------
 4 files changed, 66 insertions(+), 45 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 4ffc4e1b22b2b7c2ea8e8ed5b7f7a8534625249f..4e7a0ce9cc9c24f2e828f41e9105acc4048333d5 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -349,68 +349,70 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     }
 }
 
-impl<T: 'static, A> ForeignOwnable for Box<T, A>
+// SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
+unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
 where
     A: Allocator,
 {
+    type PointedTo = T;
     type Borrowed<'a> = &'a T;
     type BorrowedMut<'a> = &'a mut T;
 
-    fn into_foreign(self) -> *mut crate::ffi::c_void {
-        Box::into_raw(self).cast()
+    fn into_foreign(self) -> *mut Self::PointedTo {
+        Box::into_raw(self)
     }
 
-    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr.cast()) }
+        unsafe { Box::from_raw(ptr) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> &'a T {
+    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> &'a T {
         // SAFETY: The safety requirements of this method ensure that the object remains alive and
         // immutable for the duration of 'a.
-        unsafe { &*ptr.cast() }
+        unsafe { &*ptr }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut core::ffi::c_void) -> &'a mut T {
-        let ptr = ptr.cast();
+    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> &'a mut T {
         // SAFETY: The safety requirements of this method ensure that the pointer is valid and that
         // nothing else will access the value for the duration of 'a.
         unsafe { &mut *ptr }
     }
 }
 
-impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
+// SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
+unsafe impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 where
     A: Allocator,
 {
+    type PointedTo = T;
     type Borrowed<'a> = Pin<&'a T>;
     type BorrowedMut<'a> = Pin<&'a mut T>;
 
-    fn into_foreign(self) -> *mut crate::ffi::c_void {
+    fn into_foreign(self) -> *mut Self::PointedTo {
         // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }).cast()
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) })
     }
 
-    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr.cast())) }
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr)) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Pin<&'a T> {
+    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Pin<&'a T> {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
         // the lifetime of the returned value.
-        let r = unsafe { &*ptr.cast() };
+        let r = unsafe { &*ptr };
 
         // SAFETY: This pointer originates from a `Pin<Box<T>>`.
         unsafe { Pin::new_unchecked(r) }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut core::ffi::c_void) -> Pin<&'a mut T> {
-        let ptr = ptr.cast();
+    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> Pin<&'a mut T> {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index d159af7eadb54d87fae0d85a44d59a37b47f8210..c58b9625ee713380142d6b35b90c058171779394 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -189,7 +189,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     };
 
     // SAFETY: The open call of a file owns the private data.
-    unsafe { (*file).private_data = ptr.into_foreign() };
+    unsafe { (*file).private_data = ptr.into_foreign().cast() };
 
     0
 }
@@ -205,7 +205,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: The release call of a file owns the private data.
     let private = unsafe { (*file).private_data };
     // SAFETY: The release call of a file owns the private data.
-    let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
+    let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private.cast()) };
 
     T::release(ptr);
 
@@ -223,7 +223,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: The ioctl call of a file can access the private data.
     let private = unsafe { (*file).private_data };
     // SAFETY: Ioctl calls can borrow the private data of the file.
-    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private.cast()) };
 
     match T::ioctl(device, cmd, arg) {
         Ok(ret) => ret as c_long,
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index eb5cd8b360a3507a527978aaf96dbc3a80d4ae2c..8e29c332db86ae869d81f75de9c21fa73174de9a 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -130,9 +130,10 @@ pub struct Arc<T: ?Sized> {
     _p: PhantomData<ArcInner<T>>,
 }
 
+#[doc(hidden)]
 #[pin_data]
 #[repr(C)]
-struct ArcInner<T: ?Sized> {
+pub struct ArcInner<T: ?Sized> {
     refcount: Opaque<bindings::refcount_t>,
     data: T,
 }
@@ -330,18 +331,20 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
     }
 }
 
-impl<T: 'static> ForeignOwnable for Arc<T> {
+// SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
+unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
+    type PointedTo = ArcInner<T>;
     type Borrowed<'a> = ArcBorrow<'a, T>;
     type BorrowedMut<'a> = Self::Borrowed<'a>;
 
-    fn into_foreign(self) -> *mut crate::ffi::c_void {
-        ManuallyDrop::new(self).ptr.as_ptr().cast()
+    fn into_foreign(self) -> *mut Self::PointedTo {
+        ManuallyDrop::new(self).ptr.as_ptr()
     }
 
-    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
+        let inner = unsafe { NonNull::new_unchecked(ptr) };
 
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
@@ -349,17 +352,17 @@ unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
         unsafe { Self::from_inner(inner) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
+        let inner = unsafe { NonNull::new_unchecked(ptr) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
         unsafe { ArcBorrow::new(inner) }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
         // requirements for `borrow`.
         unsafe { Self::borrow(ptr) }
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 0dfaf45a755c7ce702027918e5fd3e97c407fda4..0cf93c293b884004a6ed64c2c09723efa7986270 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -18,7 +18,19 @@
 ///
 /// This trait is meant to be used in cases when Rust objects are stored in C objects and
 /// eventually "freed" back to Rust.
-pub trait ForeignOwnable: Sized {
+///
+/// # Safety
+///
+/// Implementers must ensure that [`into_foreign`] returns a pointer which meets the alignment
+/// requirements of [`PointedTo`].
+///
+/// [`into_foreign`]: Self::into_foreign
+/// [`PointedTo`]: Self::PointedTo
+pub unsafe trait ForeignOwnable: Sized {
+    /// Type used when the value is foreign-owned. In practical terms only defines the alignment of
+    /// the pointer.
+    type PointedTo;
+
     /// Type used to immutably borrow a value that is currently foreign-owned.
     type Borrowed<'a>;
 
@@ -27,16 +39,18 @@ pub trait ForeignOwnable: Sized {
 
     /// Converts a Rust-owned object to a foreign-owned one.
     ///
-    /// The foreign representation is a pointer to void. There are no guarantees for this pointer.
-    /// For example, it might be invalid, dangling or pointing to uninitialized memory. Using it in
-    /// any way except for [`from_foreign`], [`try_from_foreign`], [`borrow`], or [`borrow_mut`] can
-    /// result in undefined behavior.
+    /// # Guarantees
+    ///
+    /// The return value is guaranteed to be well-aligned, but there are no other guarantees for
+    /// this pointer. For example, it might be null, dangling, or point to uninitialized memory.
+    /// Using it in any way except for [`ForeignOwnable::from_foreign`], [`ForeignOwnable::borrow`],
+    /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
     ///
     /// [`from_foreign`]: Self::from_foreign
     /// [`try_from_foreign`]: Self::try_from_foreign
     /// [`borrow`]: Self::borrow
     /// [`borrow_mut`]: Self::borrow_mut
-    fn into_foreign(self) -> *mut crate::ffi::c_void;
+    fn into_foreign(self) -> *mut Self::PointedTo;
 
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
@@ -46,7 +60,7 @@ pub trait ForeignOwnable: Sized {
     /// must not be passed to `from_foreign` more than once.
     ///
     /// [`into_foreign`]: Self::into_foreign
-    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self;
+    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self;
 
     /// Tries to convert a foreign-owned object back to a Rust-owned one.
     ///
@@ -58,7 +72,7 @@ pub trait ForeignOwnable: Sized {
     /// `ptr` must either be null or satisfy the safety requirements for [`from_foreign`].
     ///
     /// [`from_foreign`]: Self::from_foreign
-    unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
+    unsafe fn try_from_foreign(ptr: *mut Self::PointedTo) -> Option<Self> {
         if ptr.is_null() {
             None
         } else {
@@ -81,7 +95,7 @@ unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
     ///
     /// [`into_foreign`]: Self::into_foreign
     /// [`from_foreign`]: Self::from_foreign
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Self::Borrowed<'a>;
+    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Self::Borrowed<'a>;
 
     /// Borrows a foreign-owned object mutably.
     ///
@@ -109,21 +123,23 @@ unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
     /// [`from_foreign`]: Self::from_foreign
     /// [`borrow`]: Self::borrow
     /// [`Arc`]: crate::sync::Arc
-    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> Self::BorrowedMut<'a>;
+    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> Self::BorrowedMut<'a>;
 }
 
-impl ForeignOwnable for () {
+// SAFETY: The `into_foreign` function returns a pointer that is dangling, but well-aligned.
+unsafe impl ForeignOwnable for () {
+    type PointedTo = ();
     type Borrowed<'a> = ();
     type BorrowedMut<'a> = ();
 
-    fn into_foreign(self) -> *mut crate::ffi::c_void {
+    fn into_foreign(self) -> *mut Self::PointedTo {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn from_foreign(_: *mut crate::ffi::c_void) -> Self {}
+    unsafe fn from_foreign(_: *mut Self::PointedTo) -> Self {}
 
-    unsafe fn borrow<'a>(_: *mut crate::ffi::c_void) -> Self::Borrowed<'a> {}
-    unsafe fn borrow_mut<'a>(_: *mut crate::ffi::c_void) -> Self::BorrowedMut<'a> {}
+    unsafe fn borrow<'a>(_: *mut Self::PointedTo) -> Self::Borrowed<'a> {}
+    unsafe fn borrow_mut<'a>(_: *mut Self::PointedTo) -> Self::BorrowedMut<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.

-- 
2.47.1


