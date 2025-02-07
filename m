Return-Path: <linux-fsdevel+bounces-41202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F1DA2C456
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87142188DE6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C474221D83;
	Fri,  7 Feb 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6ehmUwY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E121E0BA;
	Fri,  7 Feb 2025 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936738; cv=none; b=RzskNluetzsqgViI1UKVe9gQXkZvyyK2naAX3iC5UX0RnF+GkqQvkm6lVKa0xigL+hCHtLabDGFObfIfrfqdm6THMoEEzdMEwoYPeY6C7GrFBa9ALzN4er8AVWJoty4moROv1OsQVeY32DzHLPGJUnaeA+0DBLoE9HCMLeRvOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936738; c=relaxed/simple;
	bh=wR8pnBtDUB2DEgdGV6lmunID6mIemgcIxyviNi6lWwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UN1n5kSH0/feArd+XACCkCtRCCOZ9vuFyHpw67WHfD/3a5sTj9bzjJtJ+Y85on7TZ99u5loxCf3BBH815OWTqzxrfO1vD3BTYuAwYBHmhCC8Gt8KGQlLcn37cvjp8N9/JQWr6zBy4/RBcspUVKetwIY6P7/ayrTtCwfelEZCFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6ehmUwY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6f19a6c04so179713985a.0;
        Fri, 07 Feb 2025 05:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738936735; x=1739541535; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9E79CmCNh8SvzUJ4fLJra60rwytht1fQr8WNIy+YYw=;
        b=Z6ehmUwYmVMV+wTUXjg+i2tNPB1ZIH0HX7IyuVmhNtF37e46BDRyK6X31xoowT6Z3m
         K08JsiFX+docKvcq8ivH0jcCEiWtNcoenfKOHCw78+J9VRfzfGEy/jevp1oE1pJ8D7Ub
         VM+wB1WjQ9C6dkN9PFs7lzi72xRUoV4qjDgO9pKOsryNHfKUWQf52b+CMjTqZ6vurfsr
         qp41TyXy2Han6nYrrsdD8IIlCjPMECLzjjrdlDokHitTUoqVjLROeZ/Y4mfOVkiJW7cP
         1B6criEQonGq8UYIjyvWaBKdxAkiQabuiak9EVyNHcGnW31+CDc6GUst9woMqNYvuFq1
         70bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936735; x=1739541535;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9E79CmCNh8SvzUJ4fLJra60rwytht1fQr8WNIy+YYw=;
        b=nd2gf+zrU+mOc8m/eTBfZ5K3Yu8tn8vI6elasVpUGJyWuuzbCps9oNfLEE9msVL02c
         aMaiLahoGnyi1ujPpDRxfoYIZIKTURSbobiJbJMKD0nVAKtG68/iuwz3xJwc8NTr8QkI
         MdYQxTz0eCjBgvwiEbp0Dlxj53wCL+xNL+jUwu4sV8ruKSm0vtjXhvNydqHItX08qFii
         wtKTybsfsS7kPDatDfObuldPOigy0T9VRI6ZZWYz3sNWLDmjXjYBJk8wsI4t49QNC5QA
         P7PGIJ8rDeIwFsh8TY2q1CWnIujSeSkAmsAgJKSwXOqH1WltSRcd4obao1xeUdcyjwXr
         ID2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAqiHq9bl9DOoogumOBVLYTsAhqRDlTPTZV2n3EVLjB4+Cn61cBS1+ZPTp2E8FNJq3F/jyIUmhVy7Z0iMT+t0=@vger.kernel.org, AJvYcCVjkJJ/vsfJjDiNnWqMHfjDw4/EzTtAzerNcoHqUQPXTi5HOXpvCE+aCZAZk/H1REBDifs2Cjrazj1lyNe4@vger.kernel.org, AJvYcCWLLTQtMDevrS8ZnKhrpWzVdibQjpuJY7d2gTBsm5lZ4aARzxb0hM+vol/Vq6p2hpi9VjH05oEgVYzT@vger.kernel.org, AJvYcCWx+wuTjVEPaKWppOXorIqPmrQ/dMq/j6HiQj5IRtLGVK+TwBtZ6VEkzYSRCqCvFjKt7JCOWpDN+2Tl74Pv@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqTwZ+9uIH9xOtW77czaUoQVjTMUSHdqk4i6db9etTNKuF5mK
	I6g0KLalZafFI2xdrw/BN7P8mmEZ7dB9dWrWWoT4o/bpgnkFfPpw
X-Gm-Gg: ASbGncuXVU73nL4hYQno+NENe1nYevUtb7GK4KlYt81H3iP11gbgtzSyjZqLDpt6z3T
	u8ZMDyNiTc7u71JjLlS9Ob6HuLlvVlXqAE9eUkizsPgREnz32O4RIuHMt6bspijlfDkA19+yx/m
	oVXldYKhFWeLCvOpfwPciZtCpp/g7BjjaJvvVVwXdRRbYFpurwAihyFYphrzuX6oJvQBc6WECxc
	KrKUxm1E8ApY3QMZ6Cr30kpgbDO1xfhb6Q/ebcPLOnFYfPIripfLcvwitT8dz35XYDDSo9W3ove
	meawJmjVLeJnMYJHh4WqxdTQU3q/eLaJfzY=
X-Google-Smtp-Source: AGHT+IFouYnQAwtexoi6dP+OVGJx4v7bt2UWzUG67N9X0whECk67EvHRtaJOAjme7NVSrlm3zmSO3A==
X-Received: by 2002:a05:620a:2b99:b0:7bf:ff64:3378 with SMTP id af79cd13be357-7c047cad8a8mr540553285a.53.1738936735160;
        Fri, 07 Feb 2025 05:58:55 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e11d19sm191919685a.52.2025.02.07.05.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:58:54 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Feb 2025 08:58:26 -0500
Subject: [PATCH v16 3/4] rust: xarray: Add an abstraction for XArray
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-rust-xarray-bindings-v16-3-256b0cf936bd@gmail.com>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
In-Reply-To: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
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
 rust/kernel/alloc.rs            |   5 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/xarray.rs           | 276 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 317 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 55354e4dec14..249070b5abf9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -34,6 +34,7 @@
 #include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 #include <trace/events/rust_sample.h>
 
 /* `bindgen` gets confused at certain things. */
@@ -47,3 +48,8 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
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
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index fc9c9c41cd79..77840413598d 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -39,6 +39,11 @@
 pub struct Flags(u32);
 
 impl Flags {
+    /// Get a flags value with all bits unset.
+    pub fn empty() -> Self {
+        Self(0)
+    }
+
     /// Get the raw representation of this flag.
     pub(crate) fn as_raw(self) -> u32 {
         self.0
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911..abe419362c73 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -84,6 +84,7 @@
 pub mod types;
 pub mod uaccess;
 pub mod workqueue;
+pub mod xarray;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
new file mode 100644
index 000000000000..8115dd7b4dd0
--- /dev/null
+++ b/rust/kernel/xarray.rs
@@ -0,0 +1,276 @@
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
+    /// Creates a new [`XArray`].
+    pub fn new(kind: AllocKind) -> impl PinInit<Self> {
+        let flags = match kind {
+            AllocKind::Alloc => bindings::XA_FLAGS_ALLOC,
+            AllocKind::Alloc1 => bindings::XA_FLAGS_ALLOC1,
+        };
+        pin_init!(Self {
+            // SAFETY: `xa` is valid while the closure is called.
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
+        let StoreError { error, value: _ } = value;
+        error
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
+        // SAFETY: `self.xa.xa` is always valid by the type invariant.
+        //
+        // SAFETY: The caller holds the lock.
+        let ptr = unsafe { bindings::__xa_erase(self.xa.xa.get(), index) }.cast();
+        // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.
+        //
+        // SAFETY: `&mut self` guarantees that the lifetimes of [`T::Borrowed`] and
+        // [`T::BorrowedMut`] borrowed from `self` have ended.
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
+            // SAFETY: `self.xa.xa` is always valid by the type invariant.
+            //
+            // SAFETY: The caller holds the lock.
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


