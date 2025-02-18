Return-Path: <linux-fsdevel+bounces-42000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF7A3A047
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 15:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCCC175C7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E226E657;
	Tue, 18 Feb 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3qp6dbP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4B26D5DA;
	Tue, 18 Feb 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889475; cv=none; b=BozO4FimSdOjdyf7FHm+273S6cc7TODY3wyzbUmmiuzeNY0h+BjieS/+Xgvdl2NuzE696pAs1TlKTr+f7lyDp5Rj+vSkPiT0v3nE6GeBEQ8ioyQDdSc/RfpFu+zFQh6CWdzObYJbP/iuRVIH4VRtWd0qxELqHOtNePHnQE90Nz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889475; c=relaxed/simple;
	bh=gKIwIAMUk680WuMqJJeTzqc522zJd9bKepYyrQS3lq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CReqZ0gxbk2g7fDOcW1H+zUHwK8T1rzOeqyFlqX2ktlL39zRzWAV+FFIWuparxFMzlS+d7ErxvM78IrTdYOpViKFYuqbG9GLVTIX7qGkRvC6B42fD0ZuZJECsBtq4Mssedzt9QYhsNF0yzKnqn9dqfM3l5s3PlwO3LtIN9+7kRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3qp6dbP; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471f88518c8so9049251cf.0;
        Tue, 18 Feb 2025 06:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739889471; x=1740494271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBZQ4vW8YsCOYlmddtvM37kczHY1oS2be8hh2FPySu4=;
        b=J3qp6dbPDtfy0SnWSvhsYnVcCgp2+17ZjWa3nR/6uZcbLVqU8TEmaqnvcrj/cK1/hL
         0KkEEKbhiE7pBMS7ucT0BRuovV1NasxQLsjrIYtGcqx0JmA05PztchZPMevUpul4xYRz
         Ir/bLEmmRLB/UF8fpov0IeHFd6dpf4YvzoVgsme5NjK17WDWirqm7iQizHalJNdtXuw+
         4pXp/74iFVusFkVSdElPB4sC/aHIjD/e9DoP4GzinOZ6p1nK8vLgm0lI8EOE0LzKbrOK
         ml3qai4ToGrLa9JZFwo6bPlR/eAr/kXE6I4eRe0YQHWgYxkNqjHUrPIaAqCDex1UvTtZ
         yrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889471; x=1740494271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBZQ4vW8YsCOYlmddtvM37kczHY1oS2be8hh2FPySu4=;
        b=BUuSb+iV3sqncxYKSQQYV88Tt1RJbbq4ZD0ZNe7kziMkbCpqbW0QRaibQLzUaNgzXp
         QZUgthKLwwMCrX9SPcwpzEjHP6US5El1T5LV2/hFqDsQSKTqPgBhmg8axfCiPFztebLL
         Zkqm1qKYnuwL1InBrs0T+5XrK7Ahhy+BRRGtHLpHvYbtqnewqvGrKAfREzBbFNi5euXx
         6OQSBV+fikJ5vvpzI1/pCCNAwcH4Q29lS3RFDYQ3HiPYgmr/dOMcIdb5q8SLE5Irf6Hj
         xppjiz7pLOEsKlaqM4qcYinCpl7TKSPqYtdNGctNXPkK8h/k3r9U1s0CYxbnB980ZeMC
         3B9w==
X-Forwarded-Encrypted: i=1; AJvYcCUUuO1hnCnbVE+vLgU3cVOS9NAnISCh3JYWcxEBxRVvIU5wSsLawZsA/8s6OkF1nxyh4djeTccMykvY@vger.kernel.org, AJvYcCUjuLLL6bjx6CwJbYuY9EC0eFo/Kdj/CegsxU/ST/caCMjAQU55jnZJ126+QWa2tGun18OW8ikm+iQyop9x@vger.kernel.org, AJvYcCVA+SNDTGY93eNJamD3GUa04iLx0LzGYMQ1ow5dV7zHFR6/su1hcE9hU2X0RkVlS27Eo22gnv//j0af3lZw@vger.kernel.org, AJvYcCWwRfLz4vLKkc2++cRWlerz81RClLmUof0PyliFBBoNymZ9Qjg2h8SU91LcVBj0EpojU38+r3/dwSD5UkntgNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBE30bTiPCmvo5Z7fJioxY+c/Z9NJ4pZs2Io42pcUayLzxhG8
	FvAZHKpwhEETBjECWVUMdHb4h/M8eGUlJl3xhHCU3QzcDkLuNcwi
X-Gm-Gg: ASbGnctnaMdrrRtNkVmjNPoXEKQ2DKNx+tpn6Dgww4nQXL49yuBjLd3/aD5rpwRQrjk
	ct8Lktnu0J3iJznF7lgK2IyDVbCqO94r2eApX1eQ4/Kk3KP9D9jsILWhDhu5Cyfke0HyeJcCfjZ
	7g3tKbGxTgR4EbQ8INww/FNdngOXvZCpEJWztZaXf4to4QuKGZcZ6cfIRkwMBQRrObyapTi29Y3
	KQ2o9lDdGssMzbqFnKasUWfOxNWO9O/1h84DpblLx98P6rbMw2PzXT54ItXc3l9zdcCIjK/ktdd
	e7RpMbjK48PeLM+DsCUXcffiiCawNPYJY/LmuCg=
X-Google-Smtp-Source: AGHT+IHBuyM+BnBQ4vecoZCyLVazsNY5qPbV+henTzUM2Ez6D34niKWI2ML/CSvE7hC7MSLsCiPktw==
X-Received: by 2002:a05:622a:6a01:b0:471:efd1:af19 with SMTP id d75a77b69052e-471efd1b0f0mr76637701cf.0.1739889471422;
        Tue, 18 Feb 2025 06:37:51 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:283f:a857:19c2:7622])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471ef0a5943sm24409281cf.51.2025.02.18.06.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:37:50 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Feb 2025 09:37:43 -0500
Subject: [PATCH v17 1/3] rust: types: add `ForeignOwnable::PointedTo`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-rust-xarray-bindings-v17-1-f3a99196e538@gmail.com>
References: <20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com>
In-Reply-To: <20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com>
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


