Return-Path: <linux-fsdevel+bounces-42302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42319A400E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0067F426C78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6328254AEC;
	Fri, 21 Feb 2025 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R88BDILB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF90253F0D;
	Fri, 21 Feb 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169671; cv=none; b=nvkdCkj1PYrLHut0Y/Sbv56zd3tjW/nPe10WfrXQRzLsmZeopbQEgGoISRZ/r3GZrdEQ35wky0T1LaxoxTW8xngsUDHxqUC/GuJs9RjlWlf4UBOvtzRoKyDgblXMZAYRYHb6GTai5627Yj50mTMVbIOZp33YbRVjvmwdmKFPang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169671; c=relaxed/simple;
	bh=79VkQRszeTKai8h1oQJKIFbB9SETkGd3FPdSPispFCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ik+o3ht+4thyAmlk6b13tSiHY+rsSVf/5ZT7YMVcoLqDneeHwXP2b5g8mG+Q2aiYJSHbyTqWazfD5N8PjgKqaZ6+xhXOFwK9HDA/d9Q6LcfrFuGRsQ1WwUb4XM6bPR+wDK5mTNv1Bs9ilnFGzTqBr5xbhZaSpdu5D6qWI0AQ4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R88BDILB; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be8f28172dso175168085a.3;
        Fri, 21 Feb 2025 12:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169668; x=1740774468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFXvKkJUD37pdr/9jEL9ZkBZwOEHfbsPm8qU02bWGDg=;
        b=R88BDILBDw+41+FFWY32YP+KsbCgfBcDzkat+ljSpHRQzTdOkV5EOEOA4/FgoV3Yvs
         1W/3tMPy3omK4IZkO0flUhjjNuaduZ2Os9M3wCwJbQY4mfk/JTypiKLJGmWpispoQfQm
         nzyqZ4Dmhowvfy8HlZy70oPcdUKkqimAsV49YSM3FalUysNXFPY06Xcd/G/3Z4x0dWK6
         2K3EBC7IvbcNdqTmv1satDALr4zOLYKRB3OH5T5ecKxb+gnqek/mQucXw/bmtkXXA8l7
         D4UvQgUhVwcSHTHAbMBqwgw4alt5EEdqrmlSZOfgiBwl1OpCg4bbwKJHh+84oogWxf+W
         eoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169668; x=1740774468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFXvKkJUD37pdr/9jEL9ZkBZwOEHfbsPm8qU02bWGDg=;
        b=fqS/x4NFenYUUUdUXTzzXdvhL25sdrEsrCLRko5FOO35Ia4uBPgrNzuUNFx2hTqd6T
         tMu3Jo0VXeK+En5x7K1fz6zVzQm24sL0mkK9TxoA2cAXmj93gb6UfRk8luMd02xZi8tX
         /q1n9nDv58EwvSwi76URRsy/MivTxjhg0PMvMvpkv3UKc5kmBhm4fNtHggccHJ10n6Is
         +XXwbO4wcs+hfC5XcTJa6xddaR4oFh7C8vJTyIdNSp+3hFGCvD/2EtPYeJF/fVZ7Eer8
         v1cAyWZMBEwAYfORMpz+yqW5Pee8Tzq2nCmaLbcLqaK7Npq508ImDAMjOoHlEkuRey33
         A0uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBkTlzEsTN4AgRf1fXcNKU6SLe2Zhjt/r/qNajY2G0Tdr7rR13Le6sFjLVfRjR5ptWtLXkj9UKtKlY/PCGcyc=@vger.kernel.org, AJvYcCWi6FNGfVcRYrgxCs/S/53tR3nDzgZK8astfu0e6rdVCAMGfp5luycDxJ5lmbFBYsH1IH5cYLJKxw9lrP3E@vger.kernel.org, AJvYcCXSWMw3OurbwPAhLTYmCVqo/O4p5Gp9diqF/fvR9Z7d7D9F3Yb0cj0/crg6PiQDpVuZMdK17XwOFFVN@vger.kernel.org, AJvYcCXeKTXw5Zg1tW4AtvpuTKUG/0csWvsHf3HIBx9gFEtuXY5KH3RwMzKuBGzb+eA3Jit24cjV6yqCU9ObDqXQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2kZbx43IR7cp7/AlqYGrMM+/SLz0Bs1vUL5rb7ISWhgJ4FnAW
	Xb0O8S9JrGK5VzrjryVatDTyQrVvet3P/TiguPUuUlnJvnkIIaft
X-Gm-Gg: ASbGncsQe0Ek7JRt77NJu7CfvSvhiEe5AIPHrbzyf5ERgzgyM+apqfVdDhBuiNv+8py
	QQXwHS37BDqrxgVlTcLwtIHB6TUevVyUFanlIipKmahZesgWa0Xb+Za/E5pSIH3ffBOzxNE6pfp
	7lfE1qCh4lOJu+V2/4Y/0kgGxed3KnzIigo3bSzq8SUer1a2TPcPciRBINbxAIILINd0ImDU0I+
	djbzaXhQG29VlEhIv90DNmo3NLoaIrsYoMn4uIbKhimz1KOkFg+5V64hn+bDG+HiNfsW0vCn/uO
	2RiwYZPELGsgVdMSGdzIdqFvLOj8/N3dHYxnu7QPD+ZUtQwWWA==
X-Google-Smtp-Source: AGHT+IGG40wmJBIe3UfeV3nvKhEypy7SjBjMM7cZnhd8thtWl2fJLRx4zMaodX5KMlEP/uRKGtAM3Q==
X-Received: by 2002:a05:620a:2801:b0:7c0:b3cd:9bc7 with SMTP id af79cd13be357-7c0ceeeae37mr692165785a.3.1740169667560;
        Fri, 21 Feb 2025 12:27:47 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:880f:47d4:56c6:b852])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a99d363csm539224985a.70.2025.02.21.12.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:27:47 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 15:27:41 -0500
Subject: [PATCH v18 2/3] rust: xarray: Add an abstraction for XArray
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250221-rust-xarray-bindings-v18-2-cbabe5ddfc32@gmail.com>
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
 rust/kernel/xarray.rs           | 277 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 313 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f46cf3bb7069..18a40a83453d 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -35,6 +35,7 @@
 #include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 #include <trace/events/rust_sample.h>
 
 /* `bindgen` gets confused at certain things. */
@@ -48,3 +49,8 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
 const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
+
+const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
+
+const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
+const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be..6811f71f2cbb 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -35,3 +35,4 @@
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
index 398242f92a96..e6e49dcdcb4c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -85,6 +85,7 @@
 pub mod types;
 pub mod uaccess;
 pub mod workqueue;
+pub mod xarray;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
new file mode 100644
index 000000000000..58ea5cf8c314
--- /dev/null
+++ b/rust/kernel/xarray.rs
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! XArray abstraction.
+//!
+//! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
+
+use crate::{
+    alloc, bindings, build_assert,
+    error::{Error, Result},
+    init::PinInit,
+    pin_init,
+    types::{ForeignOwnable, NotThreadSafe, Opaque},
+};
+use core::{iter, marker::PhantomData, mem, pin::Pin, ptr::NonNull};
+use macros::{pin_data, pinned_drop};
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
+        self.error
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
2.48.1


