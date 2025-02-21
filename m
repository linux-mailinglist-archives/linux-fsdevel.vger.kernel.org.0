Return-Path: <linux-fsdevel+bounces-42301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF2A400DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069857016EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640BD253F27;
	Fri, 21 Feb 2025 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0MbRLjx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4079253358;
	Fri, 21 Feb 2025 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169668; cv=none; b=pJqJ9nmgp4Xa+Y9ewHzXADkRNr/LW9mQfgiPQ91SNPB2zK2V5leY++oZqlLRUjnJwTsFCkPjDOTlt352lIH/QfoYe2frbrPRj87KTBlCiacLymFhc7Ev/dQ46dHk10purV8fojbKjzo3xwTojNQ4AB1UltroS0Pn/77MoP5ZuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169668; c=relaxed/simple;
	bh=Utj1uL53bGcOISkDLGZ/dzP17TacBe++2ickX+Z4jao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATsrDMxW0getemXhIiqr49kvIkC0hyNNiGWL2yXqduil3a2fatIg14F6a/YIycadQtcFKJN3sk25iOcepBvb8840lwAPx6ZWUqK2Y4KPlkLAW2PyUxHY+8TMHrl/vBPuV5lTDKhbQPAaDAjoaZ/UivRDbNvcDFb1m4jWsLK+tCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0MbRLjx; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471f88518c8so14685391cf.0;
        Fri, 21 Feb 2025 12:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169665; x=1740774465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOOcp/qgQEHGFEfqObW1wtWughu2PPbbcKKF2dJjXy4=;
        b=L0MbRLjxNFCTY7tjExvgwd8xzuTyHRSOkxH8/n5xyky7f11vT962n6lhfIhnVNG7WJ
         9mk3Q3MmmJO7mX6ARsNS01uE2aGH/VDNt/JSfHdn8Oc9XVa+QOd3EbKRbL3ATeG7FHSM
         dcq9eLxnaPDETUPxxSCsKI9IjRqFjVE+eleiVJzKg7Ja27jgF5FByTBtpWc9LyzT7izB
         cIIV2Dd6H9DuvE/Fr1k7/VPlIz6AL6KW4DJi9V3VU/YYaNvP2d2aTyMisRpVKZQknBW+
         ppXsZoZqYvh2eOkb1QtRW4VYQJpYRqPhOSEl6cchX+BoYQ56+RZKgTzO7AMrBTGF+xxY
         jBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169665; x=1740774465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOOcp/qgQEHGFEfqObW1wtWughu2PPbbcKKF2dJjXy4=;
        b=qj0H2Wgkv1Cte8RloW2pQ6eah4pbmUTPzoTKNJGZ6ACwDsRGbEXRFa7a+twLBON0e0
         F7SILytHMzV9uu9NhBUJjgiStG/1jSgJXZ+diZvH+oQJr0iBkcYaiDgOJEa2D7ZwdrsW
         8JQIs9Z6HvJ2SDUf7C/C22c4mWmnn25fyohoXWz4fAIXNrCnf74UE0aOd7qPeHpcUbuF
         mlAe5b7bzR1N7SCzflJerr2ok+YII+EAeTRABWOsUm5rF7joLUI5wNjBTrzf3j+TqoQi
         p2M0em5FJZPyDf6SE8MJtVPHyxt8c4OvhO4lxHruZHpc0MS6A8oNfg0T9nHOcawkBw7+
         L23w==
X-Forwarded-Encrypted: i=1; AJvYcCUMYDsHfY6M0NpDUoG3TloTvlECIKynagKcyTvBv3wgXr0SO2wLCpHo4txg5JjT4prGD5o8x9eIt3sHx0IDh3o=@vger.kernel.org, AJvYcCUiIm8jvJF8jDJLpJ+KySl0spPx9wbMZnSmNoDuFonRGVmLh7BVK/FmQ259SdI0b2mMoOupmrhNQfXvvNUF@vger.kernel.org, AJvYcCX8TSPNmMC/hxUXg22jyM1X/nFEcmIxpW3/ncPdjjXbxuvJStR8ZaSIgi5fjDmrCqShBCnRiDt8Pf+q3PpT@vger.kernel.org, AJvYcCXoA7kNnfuknlWgDBUw6SMg/tGKkQxpjkJnqbr55MrCTeV9XnnvzCtcKEV4cBh3w/aj7rRzuB6RuDZ3@vger.kernel.org
X-Gm-Message-State: AOJu0YzUiQu9paGv8kBvptZV1ykwTgy2UYNr3ApiTIqBs28WgxBV2Knk
	I89J0UDQG8SjJxto/brGSpIG84TNmHDZ1p6rdvPIl7dCQZGCAZ+A
X-Gm-Gg: ASbGncv9DKO+bICoCuh7iwf+cmvOxzhI/iODCXNh6LDKbP7NkW3wP/tNjltw6NGxyjk
	Ca8qh/cz1y5Q0vd1K3bTdSt1VVPujqqlTxrepvz7gm14AqKTBUH90eKUXtvoap+1Qlk8L/Hy5tw
	OrOmMWUfDpLBGCNS5mr4+3mt0bJuyFDPBe6+vdmGOR+V+frh6cRLQqiw28PnzdZLda6tY7uyxpX
	HMW/w4SBh5bmqxhp52ExulR0nTOwG1uEKQx8G07O4V4FIoaB3pqB34jDz68lIbEeIWbN9hLEAIx
	SvSI7UFHf/dhetDtjKVTM9alfI3mGnK970r0aBh/xf3eLC7VLg==
X-Google-Smtp-Source: AGHT+IFJT1MCYvEC1pyF6PPIxsO1z6skF5DStTySr18N/0ko+53p6PSx7ER53iXMR9amFmjHfOkzLQ==
X-Received: by 2002:a05:620a:2791:b0:7c0:6ab0:a25 with SMTP id af79cd13be357-7c0cef106f2mr578885885a.28.1740169665344;
        Fri, 21 Feb 2025 12:27:45 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:880f:47d4:56c6:b852])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a99d363csm539224985a.70.2025.02.21.12.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:27:44 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 15:27:40 -0500
Subject: [PATCH v18 1/3] rust: types: add `ForeignOwnable::PointedTo`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-rust-xarray-bindings-v18-1-cbabe5ddfc32@gmail.com>
References: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
In-Reply-To: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tamir Duberstein <tamird@gmail.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
X-Mailer: b4 0.15-dev

Allow implementors to specify the foreign pointer type; this exposes
information about the pointed-to type such as its alignment.

This requires the trait to be `unsafe` since it is now possible for
implementors to break soundness by returning a misaligned pointer.

Encoding the pointer type in the trait (and avoiding pointer casts)
allows the compiler to check that implementors return the correct
pointer type. This is preferable to directly encoding the alignment in
the trait using a constant as the compiler would be unable to check it.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kbox.rs | 38 ++++++++++++++++++++------------------
 rust/kernel/miscdevice.rs | 10 +++++-----
 rust/kernel/pci.rs        |  2 +-
 rust/kernel/platform.rs   |  2 +-
 rust/kernel/sync/arc.rs   | 21 ++++++++++++---------
 rust/kernel/types.rs      | 46 +++++++++++++++++++++++++++++++---------------
 6 files changed, 70 insertions(+), 49 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index cb4ebea3b074..55529832db54 100644
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
 
-    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> &'a mut T {
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
 
-    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> Pin<&'a mut T> {
-        let ptr = ptr.cast();
+    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> Pin<&'a mut T> {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index e14433b2ab9d..463701adbfcd 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -231,7 +231,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     // fops_* methods in this file, which all correctly cast the private data to the new type.
     //
     // SAFETY: The open call of a file can access the private data.
-    unsafe { (*raw_file).private_data = ptr.into_foreign() };
+    unsafe { (*raw_file).private_data = ptr.into_foreign().cast() };
 
     0
 }
@@ -245,7 +245,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     file: *mut bindings::file,
 ) -> c_int {
     // SAFETY: The release call of a file owns the private data.
-    let private = unsafe { (*file).private_data };
+    let private = unsafe { (*file).private_data }.cast();
     // SAFETY: The release call of a file owns the private data.
     let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
 
@@ -266,7 +266,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     arg: c_ulong,
 ) -> c_long {
     // SAFETY: The ioctl call of a file can access the private data.
-    let private = unsafe { (*file).private_data };
+    let private = unsafe { (*file).private_data }.cast();
     // SAFETY: Ioctl calls can borrow the private data of the file.
     let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
@@ -291,7 +291,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     arg: c_ulong,
 ) -> c_long {
     // SAFETY: The compat ioctl call of a file can access the private data.
-    let private = unsafe { (*file).private_data };
+    let private = unsafe { (*file).private_data }.cast();
     // SAFETY: Ioctl calls can borrow the private data of the file.
     let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
@@ -315,7 +315,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     file: *mut bindings::file,
 ) {
     // SAFETY: The release call of a file owns the private data.
-    let private = unsafe { (*file).private_data };
+    let private = unsafe { (*file).private_data }.cast();
     // SAFETY: Ioctl calls can borrow the private data of the file.
     let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
     // SAFETY:
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4c98b5b9aa1e..e33e3373b84e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -86,7 +86,7 @@ extern "C" fn probe_callback(
     extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // SAFETY: The PCI bus only ever calls the remove callback with a valid pointer to a
         // `struct pci_dev`.
-        let ptr = unsafe { bindings::pci_get_drvdata(pdev) };
+        let ptr = unsafe { bindings::pci_get_drvdata(pdev) }.cast();
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 50e6b0421813..a956a39035b4 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -76,7 +76,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
 
     extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
         // SAFETY: `pdev` is a valid pointer to a `struct platform_device`.
-        let ptr = unsafe { bindings::platform_get_drvdata(pdev) };
+        let ptr = unsafe { bindings::platform_get_drvdata(pdev) }.cast();
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3cefda7a4372..dfe4abf82c25 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -140,9 +140,10 @@ pub struct Arc<T: ?Sized> {
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
@@ -342,18 +343,20 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
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
@@ -361,17 +364,17 @@ unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
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
 
-    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
         // requirements for `borrow`.
         unsafe { Self::borrow(ptr) }
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2bbaab83b9d6..55ddd50e8aaa 100644
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
2.48.1


