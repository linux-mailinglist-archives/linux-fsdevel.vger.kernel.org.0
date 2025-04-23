Return-Path: <linux-fsdevel+bounces-47093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F03AA98BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6437A69C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4651C7019;
	Wed, 23 Apr 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk7JPWQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091A1AAA1A;
	Wed, 23 Apr 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416486; cv=none; b=rtWCQvGb4fWInn3TSx1Y68aVFoTAdaoFP2/rSqrYym291Gu9BaqshIOaIgzJx40z8OJAcIOVZMmHw7ifl9VZ6uE56OnbTjC19+StX2594pN9olkz3HSkhaGRAoiCSom2oshz2Y2tkWcH/GmIHhNBZTwwGL76K3cuB5COXxQTpuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416486; c=relaxed/simple;
	bh=AMTM4qZdVSX9qdAs1aNQ2SNVc1SJP5H7BhlwiU9J9zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQcqLne8hVns6NA9XFslSdUXC9JkKcCjnsTM8rTZWFbkTdH/A6XMVCU48hOZ7iZ9KFxByBeylCLWfzol4WNQzdgaykmT7uP8vhtoQyDuSRu6Vh/v6+SRcaEps7Oi0cf6v8JLntzmg65+zSmnsdfh+AU29vFmRgBzFf+6OgpKEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk7JPWQd; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4769f3e19a9so44027281cf.0;
        Wed, 23 Apr 2025 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745416482; x=1746021282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AmSNur/UL24mftigbhQbeOIeLWMBjX1lRgQ75bgFcc=;
        b=Lk7JPWQd9HzP0i1fhTDOA2XV9Ra9Cuz7F08vYKpF5uhZEdV84tmDULI2usbWGlB0Nc
         9Ons+nzU8IMKtvhg8hq+QW/cQa76cPtzCwd4z0XEqlmCg6AQ2ociJGm4X4PEx/sY7Y/A
         ksI7PkDH7t541+MbdJiQkKZpfXHdd/5o9Sw7CpSBKedUJjy2nq4siAYvGc439T0oYSRQ
         CSa0byCMldFEKlscEFMWRwe9nRDkiaMYMrw4VAbRV4KTRgh/gpW/7WK2SzcQWH/a1SGn
         XoGWaq02evgoqPHzzd2c64B0O2bmIioBJzlAW6L7g1PMqJn+WrTr/FfiAS4vMBcSwLa2
         B+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745416482; x=1746021282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AmSNur/UL24mftigbhQbeOIeLWMBjX1lRgQ75bgFcc=;
        b=hRXIVfc6EIn10l+RMM2aFWs0WBYNpyPc1YQQOXrFEgSREXajgixABjejxfLJeCwBmT
         9xraPbY0RWWgrnsDGPtlwtDF/uYSMuROvGZCJXnbbgFL/SM6EFQtFakqk2aKpx5QQkfS
         IZ6Z9XDA2pyIFnUvuFNpVqj86dd+Hd70dwdmNfEKNs/h2CEyhNikwkbOUMxKzRL8DaRH
         uwVZYeemeqhMYsqN6NjVmDACL8VnPuA16NtPtLi/qTkPW1vx5joz11/tS2MPwozG7nBv
         H/lbhRJLxo7JG36R89t/Fq1wAwfhSMluMhh+DskjcTahEPiLPv6XnJkWaEDjR7cVkpSK
         UfoA==
X-Forwarded-Encrypted: i=1; AJvYcCV5/TmthHHkqh5mZQD/ny364rmO8gjz3Zv2xxMg5Q4tQm23zlQon3/hnI3a0SGGsXszFSaEXIMYWNSk684yPgQ=@vger.kernel.org, AJvYcCW0XtJDGkAyzYWNDVbhn1qVAtDhXzzoCQ2hr70HnVa5dVIV/mJXveNkUy8EA72O+hQVTWP37J6eGW1l@vger.kernel.org, AJvYcCWAAZxIe8bmf47R3F51ialhgLSFNLn3FW+7Vem0hpkEu/t03l1OuBx0MfaSndia+AZBrGimq/6CU+NCqvED@vger.kernel.org, AJvYcCWnRResTjK70eooxqo4dQO8ta11G0/wgWouGpOVJGPNzSGYixw9NlWxpw8gYYRaNnqSHzpLQ9Cp8ShwyJNc@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+PaHTo19EjZm9Fpnpnof4FWVIZfmeCN39bq1XK1t2rLmZfWu
	751vCYXDPUW4pczEHlJi5rOSc75l8ba6ljWMcu0uNur5ybH9oCRK
X-Gm-Gg: ASbGncsaeyCrrTaovd8HRdTggV8CphiLScHPc/7kW9v5rlZE6+BqeMHqtrhNqwFATpR
	xABbLVCn9sjxE9eIApiIctagEAA4X9uu68YGN+7a2IHan7qUqQzroY1ka791ayImbd7uHRayNIl
	nFn/WAVJI/0s8cqDK+VnDNZYT9HNnKH04B2DC+QY5pn0B4I0MBo4xlcpthUPZSLGwFNinVYAKrr
	j9H5aOeyY4PxyyPvauyay80i0N0VyExrbcfVdqGQiBxMfKJdojosWNANlVt+nytRFbl9hG7QSYF
	jEL0SWRNfDoPm/8nNwQfsk2UxppHctXEvNUBk6VViGXx37Ne0MaM5H4+CR6RAhePsaS5c4Glgzt
	VxTsp0ZIFpisPptD2aXOMwZ56M52zrV9rxX4MQ1WNtsHhUc848Q==
X-Google-Smtp-Source: AGHT+IE1y1QPyvGpmyb3lIJTBSCxfBsc6daYJBUZFuovod4HdUmjRrXqjjdo2BNdS2IOcHkLeprrNQ==
X-Received: by 2002:a05:622a:24f:b0:476:b764:e315 with SMTP id d75a77b69052e-47aec4dd531mr308911601cf.52.1745416481279;
        Wed, 23 Apr 2025 06:54:41 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e2b6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f7dsm68135461cf.74.2025.04.23.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:54:40 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Apr 2025 09:54:37 -0400
Subject: [PATCH v19 1/3] rust: types: add `ForeignOwnable::PointedTo`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-rust-xarray-bindings-v19-1-83cdcf11c114@gmail.com>
References: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
In-Reply-To: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
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
index b77d32f3a58b..6aa88b01e84d 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -360,68 +360,70 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
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
index fa9ecc42602a..b4c5f74de23d 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -200,7 +200,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         // type.
         //
         // SAFETY: The open call of a file can access the private data.
-        unsafe { (*raw_file).private_data = ptr.into_foreign() };
+        unsafe { (*raw_file).private_data = ptr.into_foreign().cast() };
 
         0
     }
@@ -211,7 +211,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     /// must be associated with a `MiscDeviceRegistration<T>`.
     unsafe extern "C" fn release(_inode: *mut bindings::inode, file: *mut bindings::file) -> c_int {
         // SAFETY: The release call of a file owns the private data.
-        let private = unsafe { (*file).private_data };
+        let private = unsafe { (*file).private_data }.cast();
         // SAFETY: The release call of a file owns the private data.
         let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
 
@@ -228,7 +228,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
     unsafe extern "C" fn ioctl(file: *mut bindings::file, cmd: c_uint, arg: c_ulong) -> c_long {
         // SAFETY: The ioctl call of a file can access the private data.
-        let private = unsafe { (*file).private_data };
+        let private = unsafe { (*file).private_data }.cast();
         // SAFETY: Ioctl calls can borrow the private data of the file.
         let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
@@ -253,7 +253,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         arg: c_ulong,
     ) -> c_long {
         // SAFETY: The compat ioctl call of a file can access the private data.
-        let private = unsafe { (*file).private_data };
+        let private = unsafe { (*file).private_data }.cast();
         // SAFETY: Ioctl calls can borrow the private data of the file.
         let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
@@ -274,7 +274,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     /// - `seq_file` must be a valid `struct seq_file` that we can write to.
     unsafe extern "C" fn show_fdinfo(seq_file: *mut bindings::seq_file, file: *mut bindings::file) {
         // SAFETY: The release call of a file owns the private data.
-        let private = unsafe { (*file).private_data };
+        let private = unsafe { (*file).private_data }.cast();
         // SAFETY: Ioctl calls can borrow the private data of the file.
         let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
         // SAFETY:
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c97d6d470b28..3aeb1250c27f 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -89,7 +89,7 @@ extern "C" fn probe_callback(
     extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // SAFETY: The PCI bus only ever calls the remove callback with a valid pointer to a
         // `struct pci_dev`.
-        let ptr = unsafe { bindings::pci_get_drvdata(pdev) };
+        let ptr = unsafe { bindings::pci_get_drvdata(pdev) }.cast();
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 4917cb34e2fe..fd4a494f30e8 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -80,7 +80,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
 
     extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
         // SAFETY: `pdev` is a valid pointer to a `struct platform_device`.
-        let ptr = unsafe { bindings::platform_get_drvdata(pdev) };
+        let ptr = unsafe { bindings::platform_get_drvdata(pdev) }.cast();
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 8484c814609a..a42c164e577a 100644
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
@@ -371,18 +372,20 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
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
@@ -390,17 +393,17 @@ unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
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
index 9d0471afc964..86562e738eac 100644
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
2.49.0


