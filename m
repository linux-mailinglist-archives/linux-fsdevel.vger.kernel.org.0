Return-Path: <linux-fsdevel+bounces-47094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A1A98C00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FD1179368
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D801DEFDB;
	Wed, 23 Apr 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGkerWM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48081B040B;
	Wed, 23 Apr 2025 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416487; cv=none; b=c0T3qMhMXxXk2VDwvOWjrqGuPceo37X3UociIp5OkiJFoTlGn0DcB62J1Zjh1QOsvn7Xux9lYxeAbcMHCs2Nf7FNv+bgisCBSOx1wplT/0+YDyWrJzlWY2YfvcAASILsJyFaSpdPc0Jw7HW+Vl/EOVvP0P3fx2rZfs+FnwXrWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416487; c=relaxed/simple;
	bh=jlRN/tTw7Zp0eIq9osGcJ+spoV2f70e/V57vy6It0uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jzw+AxwsSyZVnC5uLQdRBumij07zNQ+Qb7+DsUuH8Pi3myJp21rxxOS/s7gc3mFDxne4vJs/yimJA16HsadSE4IP07XA7YK5bHH8IDpoizU+avud5T9t8yhoA6cx6H7gVrMJjsJWCwN5X4nuNo4+iUwSX0r/P/l8J/LP2zroXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGkerWM4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47691d82bfbso121821671cf.0;
        Wed, 23 Apr 2025 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745416483; x=1746021283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEvzGSgrG49q0bEAP8Rox67ehlzYDpSBzxCxazKaPJQ=;
        b=AGkerWM442lpijwXtWCkWnx0viCxXl6+fk/K/mQVPGp26MhHYg67pNw6mi6/o1nmfb
         QbMBa2s2Uo2Ws3xYR50YgnvEK/EF+sSwpooAYSMdxEREguSiAxNUlE/b6Hod40lUjiXt
         NeUzQRVXdAkgfVhTybWzbhgNcEQ2gsXTbaFfAR7nnym7wbFx50muQxSgsM4NvMDmwl3K
         fE6SlD3tVMyARC2FeNnjmErDUWEsdSJPBKWmKJy0evsBQPZj4vUDmfcBMiu+ZIkW5cN7
         YpGoBvP6bZXP7xiCsiap7wOIN0Ty2OTK9liOZNEsYvY7J04Z7pTMnKH5+PPMvDAh1LIA
         7u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745416483; x=1746021283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEvzGSgrG49q0bEAP8Rox67ehlzYDpSBzxCxazKaPJQ=;
        b=fNjXH4EJPwh6+srKAAEegvF5ZbORoivbPc7SRnMt61W8sD5waHjDZWl5XXiKUICGVn
         5s4MW2vWLWYfEhDDESbJMrBcY7Dy9HcsLayGq1dBjyen6BSCJ7AVULZNaaJTXlez5IaI
         oe34jYF4R8KZbzK40OcJAs0AUvNI6Mboti122Qj/22GDW+cC9NrcF0XhAj2q8rLj8D7s
         L8Tck3h48/xGDkrUq6cuEtvPeLo2VYKeAtf/b3wGOwxZwVbCqMoFtOUkeFD55HXq0I5r
         xfJtPhQKWqWnor3iES4hWYeipvXqihYFiGzJX+p7+0q/YPjic2YAlEwZhkGIh6AW+tQi
         BBzw==
X-Forwarded-Encrypted: i=1; AJvYcCUfby6n3cbjaebCSVp54zGfdu3zW4pcukln1aF7cbj5DVe47i7oZddY677YJwPbaptbdVVWfJ42L4iX@vger.kernel.org, AJvYcCWcFB0QLKbd6gqYzZaPCKh5gyFpZ/UUv1sfUlbxLIXSPSu2Gx2k63Kb6yQCrsTSuJj+UtRSWCwBWaXbXW5/pJo=@vger.kernel.org, AJvYcCWwITy6hDqydIX9wbJJMSRzHTLAM1nf7kGIXTNWWoiVd3XEH4tdFACqxIU/OyiF0/Y3UwGkItOzgCh+hco6@vger.kernel.org, AJvYcCXxdFJNxbjRdZ2etARU8PHOntvSYW0Y7Kchg3s1cjxGDI5GXi6K4xY3dHHr0jRQ/VIPCr6jYhE1bvDxw/nR@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTqAyho2jpPpQ5ZgvDkav7HfGeD7WswzGNft7lqDpdtGKNUCV
	5OSrMv359iTR9g5MfRQPLcSpsKnuDgNYoFcnlnNiC2MVLy1wS4PJWyTWCxXXtHQ=
X-Gm-Gg: ASbGncv/FAwyJgQGE5aELXxCbpuC3w3BoU4UdcPLrwHoiHQGpIYik4bidMui4sLm+O3
	4vK+mKlEWg8NVfJ/dJDJK+v1vX5IvEOx/fvpeE7c5id/RKuprAC52qTaWHJhSqrhhBjH1eIOQoJ
	07O9hdFH2Xsdxd2DV4yanwrYHFzJCWNhNxCv1nDew+i4JEMsOXr502PG/SyMqyAFFwsu7oGmDAh
	vPpuRIvDzneacitQ9XFtotTIfqeR8rXy2Dhx2Aa12N6uByomQsuEy0X8CV89FbOGvQr0/rsJSqC
	i4t1hdwu+j1JUBoT4q0x4/kiJaBcJ2/sW6Dkg2P2Ruch0rew7/GaBwq2N/2zViwzaL2LJtxmrXC
	obvgsj4h/67bBgh93twp1LrP22w+ifZYqVqTNkIiICAhn8cBLww==
X-Google-Smtp-Source: AGHT+IGlo13KlW/fEd4g5vPuYiTrdtt3LqipoGa/r/MhFsBhq+5EbrRbxxmfpvgrkzFV8RU2tB9Hsg==
X-Received: by 2002:ac8:57ce:0:b0:477:64dd:5765 with SMTP id d75a77b69052e-47aec4c359amr374309841cf.44.1745416483440;
        Wed, 23 Apr 2025 06:54:43 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e2b6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f7dsm68135461cf.74.2025.04.23.06.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:54:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Apr 2025 09:54:38 -0400
Subject: [PATCH v19 2/3] rust: xarray: Add an abstraction for XArray
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-rust-xarray-bindings-v19-2-83cdcf11c114@gmail.com>
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

`XArray` is an efficient sparse array of pointers. Add a Rust
abstraction for this type.

This implementation bounds the element type on `ForeignOwnable` and
requires explicit locking for all operations. Future work may leverage
RCU to enable lockless operation.

Inspired-by: Maíra Canal <mcanal@igalia.com>
Inspired-by: Asahi Lina <lina@asahilina.net>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/xarray.c           |  28 ++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/xarray.rs           | 275 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 311 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ab37e1d35c70..e0bcd130b494 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -37,6 +37,7 @@
 #include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 #include <trace/events/rust_sample.h>
 
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
@@ -55,3 +56,8 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
 const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
+
+const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
+
+const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
+const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 1e7c84df7252..80785b1e7a63 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -38,3 +38,4 @@
 #include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
+#include "xarray.c"
diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
new file mode 100644
index 000000000000..60b299f11451
--- /dev/null
+++ b/rust/helpers/xarray.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/xarray.h>
+
+int rust_helper_xa_err(void *entry)
+{
+	return xa_err(entry);
+}
+
+void rust_helper_xa_init_flags(struct xarray *xa, gfp_t flags)
+{
+	return xa_init_flags(xa, flags);
+}
+
+int rust_helper_xa_trylock(struct xarray *xa)
+{
+	return xa_trylock(xa);
+}
+
+void rust_helper_xa_lock(struct xarray *xa)
+{
+	return xa_lock(xa);
+}
+
+void rust_helper_xa_unlock(struct xarray *xa)
+{
+	return xa_unlock(xa);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index de07aadd1ff5..715fab6b1345 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -88,6 +88,7 @@
 pub mod types;
 pub mod uaccess;
 pub mod workqueue;
+pub mod xarray;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
new file mode 100644
index 000000000000..75719e7bb491
--- /dev/null
+++ b/rust/kernel/xarray.rs
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! XArray abstraction.
+//!
+//! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
+
+use crate::{
+    alloc, bindings, build_assert,
+    error::{Error, Result},
+    types::{ForeignOwnable, NotThreadSafe, Opaque},
+};
+use core::{iter, marker::PhantomData, mem, pin::Pin, ptr::NonNull};
+use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
+
+/// An array which efficiently maps sparse integer indices to owned objects.
+///
+/// This is similar to a [`crate::alloc::kvec::Vec<Option<T>>`], but more efficient when there are
+/// holes in the index space, and can be efficiently grown.
+///
+/// # Invariants
+///
+/// `self.xa` is always an initialized and valid [`bindings::xarray`] whose entries are either
+/// `XA_ZERO_ENTRY` or came from `T::into_foreign`.
+///
+/// # Examples
+///
+/// ```rust
+/// use kernel::alloc::KBox;
+/// use kernel::xarray::{AllocKind, XArray};
+///
+/// let xa = KBox::pin_init(XArray::new(AllocKind::Alloc1), GFP_KERNEL)?;
+///
+/// let dead = KBox::new(0xdead, GFP_KERNEL)?;
+/// let beef = KBox::new(0xbeef, GFP_KERNEL)?;
+///
+/// let mut guard = xa.lock();
+///
+/// assert_eq!(guard.get(0), None);
+///
+/// assert_eq!(guard.store(0, dead, GFP_KERNEL)?.as_deref(), None);
+/// assert_eq!(guard.get(0).copied(), Some(0xdead));
+///
+/// *guard.get_mut(0).unwrap() = 0xffff;
+/// assert_eq!(guard.get(0).copied(), Some(0xffff));
+///
+/// assert_eq!(guard.store(0, beef, GFP_KERNEL)?.as_deref().copied(), Some(0xffff));
+/// assert_eq!(guard.get(0).copied(), Some(0xbeef));
+///
+/// guard.remove(0);
+/// assert_eq!(guard.get(0), None);
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[pin_data(PinnedDrop)]
+pub struct XArray<T: ForeignOwnable> {
+    #[pin]
+    xa: Opaque<bindings::xarray>,
+    _p: PhantomData<T>,
+}
+
+#[pinned_drop]
+impl<T: ForeignOwnable> PinnedDrop for XArray<T> {
+    fn drop(self: Pin<&mut Self>) {
+        self.iter().for_each(|ptr| {
+            let ptr = ptr.as_ptr();
+            // SAFETY: `ptr` came from `T::into_foreign`.
+            //
+            // INVARIANT: we own the only reference to the array which is being dropped so the
+            // broken invariant is not observable on function exit.
+            drop(unsafe { T::from_foreign(ptr) })
+        });
+
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        unsafe { bindings::xa_destroy(self.xa.get()) };
+    }
+}
+
+/// Flags passed to [`XArray::new`] to configure the array's allocation tracking behavior.
+pub enum AllocKind {
+    /// Consider the first element to be at index 0.
+    Alloc,
+    /// Consider the first element to be at index 1.
+    Alloc1,
+}
+
+impl<T: ForeignOwnable> XArray<T> {
+    /// Creates a new initializer for this type.
+    pub fn new(kind: AllocKind) -> impl PinInit<Self> {
+        let flags = match kind {
+            AllocKind::Alloc => bindings::XA_FLAGS_ALLOC,
+            AllocKind::Alloc1 => bindings::XA_FLAGS_ALLOC1,
+        };
+        pin_init!(Self {
+            // SAFETY: `xa` is valid while the closure is called.
+            //
+            // INVARIANT: `xa` is initialized here to an empty, valid [`bindings::xarray`].
+            xa <- Opaque::ffi_init(|xa| unsafe {
+                bindings::xa_init_flags(xa, flags)
+            }),
+            _p: PhantomData,
+        })
+    }
+
+    fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
+        let mut index = 0;
+
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        iter::once(unsafe {
+            bindings::xa_find(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
+        })
+        .chain(iter::from_fn(move || {
+            // SAFETY: `self.xa` is always valid by the type invariant.
+            Some(unsafe {
+                bindings::xa_find_after(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
+            })
+        }))
+        .map_while(|ptr| NonNull::new(ptr.cast()))
+    }
+
+    /// Attempts to lock the [`XArray`] for exclusive access.
+    pub fn try_lock(&self) -> Option<Guard<'_, T>> {
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        if (unsafe { bindings::xa_trylock(self.xa.get()) } != 0) {
+            Some(Guard {
+                xa: self,
+                _not_send: NotThreadSafe,
+            })
+        } else {
+            None
+        }
+    }
+
+    /// Locks the [`XArray`] for exclusive access.
+    pub fn lock(&self) -> Guard<'_, T> {
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        unsafe { bindings::xa_lock(self.xa.get()) };
+
+        Guard {
+            xa: self,
+            _not_send: NotThreadSafe,
+        }
+    }
+}
+
+/// A lock guard.
+///
+/// The lock is unlocked when the guard goes out of scope.
+#[must_use = "the lock unlocks immediately when the guard is unused"]
+pub struct Guard<'a, T: ForeignOwnable> {
+    xa: &'a XArray<T>,
+    _not_send: NotThreadSafe,
+}
+
+impl<T: ForeignOwnable> Drop for Guard<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY:
+        // - `self.xa.xa` is always valid by the type invariant.
+        // - The caller holds the lock, so it is safe to unlock it.
+        unsafe { bindings::xa_unlock(self.xa.xa.get()) };
+    }
+}
+
+/// The error returned by [`store`](Guard::store).
+///
+/// Contains the underlying error and the value that was not stored.
+pub struct StoreError<T> {
+    /// The error that occurred.
+    pub error: Error,
+    /// The value that was not stored.
+    pub value: T,
+}
+
+impl<T> From<StoreError<T>> for Error {
+    fn from(value: StoreError<T>) -> Self {
+        value.error
+    }
+}
+
+impl<'a, T: ForeignOwnable> Guard<'a, T> {
+    fn load<F, U>(&self, index: usize, f: F) -> Option<U>
+    where
+        F: FnOnce(NonNull<T::PointedTo>) -> U,
+    {
+        // SAFETY: `self.xa.xa` is always valid by the type invariant.
+        let ptr = unsafe { bindings::xa_load(self.xa.xa.get(), index) };
+        let ptr = NonNull::new(ptr.cast())?;
+        Some(f(ptr))
+    }
+
+    /// Provides a reference to the element at the given index.
+    pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
+        self.load(index, |ptr| {
+            // SAFETY: `ptr` came from `T::into_foreign`.
+            unsafe { T::borrow(ptr.as_ptr()) }
+        })
+    }
+
+    /// Provides a mutable reference to the element at the given index.
+    pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
+        self.load(index, |ptr| {
+            // SAFETY: `ptr` came from `T::into_foreign`.
+            unsafe { T::borrow_mut(ptr.as_ptr()) }
+        })
+    }
+
+    /// Removes and returns the element at the given index.
+    pub fn remove(&mut self, index: usize) -> Option<T> {
+        // SAFETY:
+        // - `self.xa.xa` is always valid by the type invariant.
+        // - The caller holds the lock.
+        let ptr = unsafe { bindings::__xa_erase(self.xa.xa.get(), index) }.cast();
+        // SAFETY:
+        // - `ptr` is either NULL or came from `T::into_foreign`.
+        // - `&mut self` guarantees that the lifetimes of [`T::Borrowed`] and [`T::BorrowedMut`]
+        // borrowed from `self` have ended.
+        unsafe { T::try_from_foreign(ptr) }
+    }
+
+    /// Stores an element at the given index.
+    ///
+    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
+    ///
+    /// On success, returns the element which was previously at the given index.
+    ///
+    /// On failure, returns the element which was attempted to be stored.
+    pub fn store(
+        &mut self,
+        index: usize,
+        value: T,
+        gfp: alloc::Flags,
+    ) -> Result<Option<T>, StoreError<T>> {
+        build_assert!(
+            mem::align_of::<T::PointedTo>() >= 4,
+            "pointers stored in XArray must be 4-byte aligned"
+        );
+        let new = value.into_foreign();
+
+        let old = {
+            let new = new.cast();
+            // SAFETY:
+            // - `self.xa.xa` is always valid by the type invariant.
+            // - The caller holds the lock.
+            //
+            // INVARIANT: `new` came from `T::into_foreign`.
+            unsafe { bindings::__xa_store(self.xa.xa.get(), index, new, gfp.as_raw()) }
+        };
+
+        // SAFETY: `__xa_store` returns the old entry at this index on success or `xa_err` if an
+        // error happened.
+        let errno = unsafe { bindings::xa_err(old) };
+        if errno != 0 {
+            // SAFETY: `new` came from `T::into_foreign` and `__xa_store` does not take
+            // ownership of the value on error.
+            let value = unsafe { T::from_foreign(new) };
+            Err(StoreError {
+                value,
+                error: Error::from_errno(errno),
+            })
+        } else {
+            let old = old.cast();
+            // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.
+            //
+            // NB: `XA_ZERO_ENTRY` is never returned by functions belonging to the Normal XArray
+            // API; such entries present as `NULL`.
+            Ok(unsafe { T::try_from_foreign(old) })
+        }
+    }
+}
+
+// SAFETY: `XArray<T>` has no shared mutable state so it is `Send` iff `T` is `Send`.
+unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
+
+// SAFETY: `XArray<T>` serialises the interior mutability it provides so it is `Sync` iff `T` is
+// `Send`.
+unsafe impl<T: ForeignOwnable + Send> Sync for XArray<T> {}

-- 
2.49.0


