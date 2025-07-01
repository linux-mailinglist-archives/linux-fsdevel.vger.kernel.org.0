Return-Path: <linux-fsdevel+bounces-53537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B04A9AEFFC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D703217B85C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDD227F163;
	Tue,  1 Jul 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJFUKZAd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426327E04B;
	Tue,  1 Jul 2025 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387247; cv=none; b=tHKlMfvUzssWjiRcfqnQlC8mGLOxJPtEMjyW31xvljWznpxhYt2jQywcMdC5Idw6BiEVjQm/FUXYtQL8HhS7LtZyS+Hmc69FsRm0TOWu8csNU5+WMQc93gJMWFNJsY1JbTC/RIUyPG4TkGOFOn9WoaXrbeseJe9wEzneqkHLJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387247; c=relaxed/simple;
	bh=jojRZnleqPCP2n75PqJ21Lf6xcs4Lt4lOIu2vTR83hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VEeN6cgAmkFsJjcx7s1TOzO38xZXySuWYYr5mgTq1zfQvx/uuzpd5sr43y54sY1L3gnCLmKBF0b6ald75uYESPWjroJggHZQh3aJAEaNph3wmjqdmc0Z5yDsWiMTJsl6z1nqR6AUSsNwldEiC+RkHshfR2DUzYG4paCoXg+66b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJFUKZAd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a4323fe8caso22922041cf.2;
        Tue, 01 Jul 2025 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751387244; x=1751992044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRIP3sZ8XpmbMloGMu5iJhjGHLcDD0hWOMx3cgyxyPc=;
        b=ZJFUKZAdnNuxCbbKVfuuucUOi3npJmMGJxdbaRiM87nkkJy6SQRFv9l81HjVjLRVCI
         +6XYr8R6JGan+p2t0/v3oSusVWIx+rWUd0w9k1n++cKXDpgmvEY9RExdb8YuDtH1iXSo
         MUkCCDUaPVc+BzMXBftrDfnLjix+JAFayHpyWSRxuU9yrhEwyxyz1Fzi3BZ6/QOl26Fr
         3vuH3YdBpNRyYAIjHO2N8o1iPdEETW/1GCpNsoO44QdmnBr8pyjKmHPBZiyNH5wZs9c4
         FBwfJX8Owjj0jpe4u/qQL6cTbnee3s0N2UW8VXIwqft0McD5vVh2nrcGwDF7t1B08CbU
         EtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387244; x=1751992044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRIP3sZ8XpmbMloGMu5iJhjGHLcDD0hWOMx3cgyxyPc=;
        b=VaECnEUrIzFFdbowiTJnxnAJrPxREaP2YEzYB/tA3/paXXCg+b08rkSMZev6vh4Zie
         rR9lMWfNCWx+GMZUxoKO9oGNAbHgJ9JqlzBKQl0mbZs9VsxFaAlvq25IWYC2fgGWvMn8
         mrJlBH3rJVc5+O2GVz+Lc7Z0bgqY5BJMzN5evlemA1c7aoos+edafn20r6Z6wqkRpHFC
         rS54NfPnCNUvetEjBUUrpoMnE3B5kGFr/k5IfOxYne+6E0cz7l0m/r4imU3pUdXuhCI6
         BeUx1wV4dqWaytai7NGebm6zy+y4S49mr+PTSp/80NsFLcOyRajKPIyymz+QSnrhI1iI
         xzig==
X-Forwarded-Encrypted: i=1; AJvYcCWjeVGgf/zZ8KfEq32bfBzyGk+mqItbWSG8PZ7i1sNwZ3IHktWNx3bSluKIN0aCXdbvjHqbxqlvH+r6mr9N@vger.kernel.org, AJvYcCXMdHtjZy70O+Pgx3+NP+g8dwoeleTy4AxIrQDxg1F1Wri7KX7Zm4shzIWrs9ocs+tgFh+L7ZnuUAmRquWd@vger.kernel.org
X-Gm-Message-State: AOJu0YzDpUjJUVnbswsF1RAzJbNA1L0xSJiZdTGJaW1tmp/U4U/NL+Bi
	hN77UDaL4u+zoKh3eIJFLX2DZjiCERKF7SxbaWMTeViyKTqH/WYjJdyk
X-Gm-Gg: ASbGncsBAhVei25OsdYF2ldx6mi8U5Bih8COoV1xryA7Arwv+rC3UiwwqtW0O45GpKJ
	WRNTmxjFYaSAvCqr0a3bi9iI/eqPCyhB0hcD2qlaXduK17T4LvaGsENk50YUzGj1jGl6Y19YnD2
	Yn/N2EqlpTUS9WpeGZptTF4QXkz+wJlU4kekD0rmGj3wukgoiPkwRYWXLny/Xbs6OYL8KgOalDe
	Y2DwFogABuUF+BSOLALzd8xR8ovnuei3SCmc72StmG12P0aDRtxW59jdOze/w4GxmpLSwFTRkgA
	HHHlm2+ILrununh/0IaIHt6Cb14lTURHB+shEU4Qv/FmYr5AJT0uc06Kg34VfrvY1ITns+1+7KI
	7khZ92FIY4cJUb2BoASlMhxw1UqYkiUtG7EqgT5AqgXdNmA0rKJO8AWW9eOS3C8axpdSVxLaHFZ
	r4X8bq4RSA
X-Google-Smtp-Source: AGHT+IFALn/cE/vWx+m2W5lf0bpYEA8//NXPUM50VPRZIeiX5E8TGmoTgjPWgyXQITETkjC81YWoTA==
X-Received: by 2002:a05:622a:1c05:b0:4a6:f4ca:68e8 with SMTP id d75a77b69052e-4a82badaf1fmr74151131cf.48.1751387243727;
        Tue, 01 Jul 2025 09:27:23 -0700 (PDT)
Received: from a.1.b.d.0.e.7.9.6.4.2.0.b.3.4.b.0.0.1.1.e.f.b.5.1.4.0.4.0.0.6.2.ip6.arpa ([2600:4041:5bfe:1100:70ac:5fd8:4c25:89ec])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d530sm78032551cf.61.2025.07.01.09.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:27:23 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 01 Jul 2025 12:27:19 -0400
Subject: [PATCH 3/3] rust: xarray: add `insert` and `reserve`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-xarray-insert-reserve-v1-3-25df2b0d706a@gmail.com>
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
In-Reply-To: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751387238; l=20620;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jojRZnleqPCP2n75PqJ21Lf6xcs4Lt4lOIu2vTR83hw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEm6abl0/rc2Wkc4pUld5Dv0UunpYl5G1hhRUdnQpXLh0zjbjmhp5GHrwTTSYm6V2hdNqgVulsF
 lNDGjcJfcuQE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, which
are akin to `__xa_{alloc,insert}` in C.

Note that unlike `xa_reserve` which only ensures that memory is
allocated, the semantics of `Reservation` are stricter and require
precise management of the reservation. Indices which have been reserved
can still be overwritten with `Guard::store`, which allows for C-like
semantics if desired.

`__xa_cmpxchg_raw` is exported to facilitate the semantics described
above.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 include/linux/xarray.h |   2 +
 lib/xarray.c           |  28 +++-
 rust/helpers/xarray.c  |   5 +
 rust/kernel/xarray.rs  | 419 ++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 447 insertions(+), 7 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index be850174e802..64f2a5e06ceb 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -563,6 +563,8 @@ void *__xa_erase(struct xarray *, unsigned long index);
 void *__xa_store(struct xarray *, unsigned long index, void *entry, gfp_t);
 void *__xa_cmpxchg(struct xarray *, unsigned long index, void *old,
 		void *entry, gfp_t);
+void *__xa_cmpxchg_raw(struct xarray *, unsigned long index, void *old,
+		void *entry, gfp_t);
 int __must_check __xa_insert(struct xarray *, unsigned long index,
 		void *entry, gfp_t);
 int __must_check __xa_alloc(struct xarray *, u32 *id, void *entry,
diff --git a/lib/xarray.c b/lib/xarray.c
index 76dde3a1cacf..58202b6fbb59 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1738,9 +1738,6 @@ void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 }
 EXPORT_SYMBOL(xa_store);
 
-static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
-			void *old, void *entry, gfp_t gfp);
-
 /**
  * __xa_cmpxchg() - Conditionally replace an entry in the XArray.
  * @xa: XArray.
@@ -1767,7 +1764,29 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
 }
 EXPORT_SYMBOL(__xa_cmpxchg);
 
-static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
+/**
+ * __xa_cmpxchg_raw() - Conditionally replace an entry in the XArray.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @old: Old value to test against.
+ * @entry: New value to place in array.
+ * @gfp: Memory allocation flags.
+ *
+ * You must already be holding the xa_lock when calling this function.
+ * It will drop the lock if needed to allocate memory, and then reacquire
+ * it afterwards.
+ *
+ * If the entry at @index is the same as @old, replace it with @entry.
+ * If the return value is equal to @old, then the exchange was successful.
+ *
+ * This function is the same as __xa_cmpxchg() except that it does not coerce
+ * XA_ZERO_ENTRY to NULL on egress.
+ *
+ * Context: Any context.  Expects xa_lock to be held on entry.  May
+ * release and reacquire xa_lock if @gfp flags permit.
+ * Return: The old value at this index or xa_err() if an error happened.
+ */
+void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
 			void *old, void *entry, gfp_t gfp)
 {
 	XA_STATE(xas, xa, index);
@@ -1787,6 +1806,7 @@ static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
 
 	return xas_result(&xas, curr);
 }
+EXPORT_SYMBOL(__xa_cmpxchg_raw);
 
 /**
  * __xa_insert() - Store this entry in the XArray if no entry is present.
diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
index 60b299f11451..b6c078e6a343 100644
--- a/rust/helpers/xarray.c
+++ b/rust/helpers/xarray.c
@@ -2,6 +2,11 @@
 
 #include <linux/xarray.h>
 
+void *rust_helper_xa_zero_entry(void)
+{
+	return XA_ZERO_ENTRY;
+}
+
 int rust_helper_xa_err(void *entry)
 {
 	return xa_err(entry);
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index bbce54ec695c..87fa3259cdd7 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -9,7 +9,12 @@
     prelude::*,
     types::{ForeignOwnable, NotThreadSafe, Opaque},
 };
-use core::{iter, marker::PhantomData, mem, ptr::NonNull};
+use core::{
+    fmt, iter,
+    marker::PhantomData,
+    mem, ops,
+    ptr::{null_mut, NonNull},
+};
 
 /// An array which efficiently maps sparse integer indices to owned objects.
 ///
@@ -126,6 +131,19 @@ fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
         .map_while(|ptr| NonNull::new(ptr.cast()))
     }
 
+    fn with_guard<F, U>(&self, guard: Option<&mut Guard<'_, T>>, f: F) -> U
+    where
+        F: FnOnce(&mut Guard<'_, T>) -> U,
+    {
+        match guard {
+            None => f(&mut self.lock()),
+            Some(guard) => {
+                assert_eq!(guard.xa.xa.get(), self.xa.get());
+                f(guard)
+            }
+        }
+    }
+
     /// Attempts to lock the [`XArray`] for exclusive access.
     pub fn try_lock(&self) -> Option<Guard<'_, T>> {
         // SAFETY: `self.xa` is always valid by the type invariant.
@@ -172,6 +190,7 @@ fn drop(&mut self) {
 /// The error returned by [`store`](Guard::store).
 ///
 /// Contains the underlying error and the value that was not stored.
+#[derive(Debug)]
 pub struct StoreError<T> {
     /// The error that occurred.
     pub error: Error,
@@ -185,6 +204,11 @@ fn from(value: StoreError<T>) -> Self {
     }
 }
 
+fn to_usize(i: u32) -> usize {
+    i.try_into()
+        .unwrap_or_else(|_| build_error!("cannot convert u32 to usize"))
+}
+
 impl<'a, T: ForeignOwnable> Guard<'a, T> {
     fn load<F, U>(&self, index: usize, f: F) -> Option<U>
     where
@@ -219,7 +243,7 @@ pub fn remove(&mut self, index: usize) -> Option<T> {
         // - The caller holds the lock.
         let ptr = unsafe { bindings::__xa_erase(self.xa.xa.get(), index) }.cast();
         // SAFETY:
-        // - `ptr` is either NULL or came from `T::into_foreign`.
+        // - `ptr` is either `NULL` or came from `T::into_foreign`.
         // - `&mut self` guarantees that the lifetimes of [`T::Borrowed`] and [`T::BorrowedMut`]
         // borrowed from `self` have ended.
         unsafe { T::try_from_foreign(ptr) }
@@ -267,13 +291,272 @@ pub fn store(
             })
         } else {
             let old = old.cast();
-            // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.
+            // SAFETY: `ptr` is either `NULL` or came from `T::into_foreign`.
             //
             // NB: `XA_ZERO_ENTRY` is never returned by functions belonging to the Normal XArray
             // API; such entries present as `NULL`.
             Ok(unsafe { T::try_from_foreign(old) })
         }
     }
+
+    /// Stores an element at the given index if no entry is present.
+    ///
+    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
+    ///
+    /// On failure, returns the element which was attempted to be stored.
+    pub fn insert(
+        &mut self,
+        index: usize,
+        value: T,
+        gfp: alloc::Flags,
+    ) -> Result<(), StoreError<T>> {
+        build_assert!(
+            mem::align_of::<T::PointedTo>() >= 4,
+            "pointers stored in XArray must be 4-byte aligned"
+        );
+        let ptr = value.into_foreign();
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        //
+        // INVARIANT: `ptr` came from `T::into_foreign`.
+        match unsafe { bindings::__xa_insert(self.xa.xa.get(), index, ptr.cast(), gfp.as_raw()) } {
+            0 => Ok(()),
+            errno => {
+                // SAFETY: `ptr` came from `T::into_foreign` and `__xa_insert` does not take
+                // ownership of the value on error.
+                let value = unsafe { T::from_foreign(ptr) };
+                Err(StoreError {
+                    value,
+                    error: Error::from_errno(errno),
+                })
+            }
+        }
+    }
+
+    /// Wrapper around `__xa_alloc`.
+    ///
+    /// On success, takes ownership of pointers passed in `op`.
+    ///
+    /// On failure, ownership returns to the caller.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be `NULL` or have come from a previous call to `T::into_foreign`.
+    unsafe fn alloc(
+        &mut self,
+        limit: impl ops::RangeBounds<u32>,
+        ptr: *mut T::PointedTo,
+        gfp: alloc::Flags,
+    ) -> Result<usize> {
+        // NB: `xa_limit::{max,min}` are inclusive.
+        let limit = bindings::xa_limit {
+            max: match limit.end_bound() {
+                ops::Bound::Included(&end) => end,
+                ops::Bound::Excluded(&end) => end - 1,
+                ops::Bound::Unbounded => u32::MAX,
+            },
+            min: match limit.start_bound() {
+                ops::Bound::Included(&start) => start,
+                ops::Bound::Excluded(&start) => start + 1,
+                ops::Bound::Unbounded => 0,
+            },
+        };
+
+        let mut index = u32::MAX;
+
+        // SAFETY:
+        // - `self.xa` is always valid by the type invariant.
+        // - `self.xa` was initialized with `XA_FLAGS_ALLOC` or `XA_FLAGS_ALLOC1`.
+        //
+        // INVARIANT: `ptr` is either `NULL` or came from `T::into_foreign`.
+        match unsafe {
+            bindings::__xa_alloc(
+                self.xa.xa.get(),
+                &mut index,
+                ptr.cast(),
+                limit,
+                gfp.as_raw(),
+            )
+        } {
+            0 => Ok(to_usize(index)),
+            errno => Err(Error::from_errno(errno)),
+        }
+    }
+
+    /// Allocates an entry somewhere in the array.
+    ///
+    /// On success, returns the index at which the entry was stored.
+    ///
+    /// On failure, returns the entry which was attempted to be stored.
+    pub fn insert_limit(
+        &mut self,
+        limit: impl ops::RangeBounds<u32>,
+        value: T,
+        gfp: alloc::Flags,
+    ) -> Result<usize, StoreError<T>> {
+        build_assert!(
+            mem::align_of::<T::PointedTo>() >= 4,
+            "pointers stored in XArray must be 4-byte aligned"
+        );
+        let ptr = value.into_foreign();
+        // SAFETY: `ptr` came from `T::into_foreign`.
+        unsafe { self.alloc(limit, ptr, gfp) }.map_err(|error| {
+            // SAFETY: `ptr` came from `T::into_foreign` and `self.alloc` does not take ownership of
+            // the value on error.
+            let value = unsafe { T::from_foreign(ptr) };
+            StoreError { value, error }
+        })
+    }
+
+    /// Reserves an entry in the array.
+    pub fn reserve(&mut self, index: usize, gfp: alloc::Flags) -> Result<Reservation<'a, T>> {
+        // NB: `__xa_insert` internally coerces `NULL` to `XA_ZERO_ENTRY` on ingress.
+        let ptr = null_mut();
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        //
+        // INVARIANT: `ptr` is `NULL`.
+        match unsafe { bindings::__xa_insert(self.xa.xa.get(), index, ptr, gfp.as_raw()) } {
+            0 => Ok(Reservation { xa: self.xa, index }),
+            errno => Err(Error::from_errno(errno)),
+        }
+    }
+
+    /// Reserves an entry somewhere in the array.
+    pub fn reserve_limit(
+        &mut self,
+        limit: impl ops::RangeBounds<u32>,
+        gfp: alloc::Flags,
+    ) -> Result<Reservation<'a, T>> {
+        // NB: `__xa_alloc` internally coerces `NULL` to `XA_ZERO_ENTRY` on ingress.
+        let ptr = null_mut();
+        // SAFETY: `ptr` is `NULL`.
+        unsafe { self.alloc(limit, ptr, gfp) }.map(|index| Reservation { xa: self.xa, index })
+    }
+}
+
+/// A reserved slot in an array.
+///
+/// The slot is released when the reservation goes out of scope.
+///
+/// Note that the array lock *must not* be held when the reservation is filled or dropped as this
+/// will lead to deadlock. [`Reservation::fill_locked`] and [`Reservation::release_locked`] can be
+/// used in context where the array lock is held.
+#[must_use = "the reservation is released immediately when the reservation is unused"]
+pub struct Reservation<'a, T: ForeignOwnable> {
+    xa: &'a XArray<T>,
+    index: usize,
+}
+
+impl<T: ForeignOwnable> fmt::Debug for Reservation<'_, T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.debug_struct("Reservation")
+            .field("index", &self.index())
+            .finish()
+    }
+}
+
+impl<T: ForeignOwnable> Reservation<'_, T> {
+    /// Returns the index of the reservation.
+    pub fn index(&self) -> usize {
+        self.index
+    }
+
+    /// Replaces the reserved entry with the given entry.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be `NULL` or have come from a previous call to `T::into_foreign`.
+    unsafe fn replace(guard: &mut Guard<'_, T>, index: usize, ptr: *mut T::PointedTo) -> Result {
+        // SAFETY: `xa_zero_entry` wraps `XA_ZERO_ENTRY` which is always safe to use.
+        let old = unsafe { bindings::xa_zero_entry() };
+
+        // NB: `__xa_cmpxchg_raw` is used over `__xa_cmpxchg` because the latter coerces
+        // `XA_ZERO_ENTRY` to `NULL` on egress, which would prevent us from determining whether a
+        // replacement was made.
+        //
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        //
+        // INVARIANT: `ptr` is either `NULL` or came from `T::into_foreign` and `old` is
+        // `XA_ZERO_ENTRY`.
+        let ret =
+            unsafe { bindings::__xa_cmpxchg_raw(guard.xa.xa.get(), index, old, ptr.cast(), 0) };
+
+        // SAFETY: `__xa_cmpxchg_raw` returns the old entry at this index on success or `xa_err` if
+        // an error happened.
+        match unsafe { bindings::xa_err(ret) } {
+            0 => {
+                if ret == old {
+                    Ok(())
+                } else {
+                    Err(EBUSY)
+                }
+            }
+            errno => Err(Error::from_errno(errno)),
+        }
+    }
+
+    fn fill_inner(&self, guard: Option<&mut Guard<'_, T>>, value: T) -> Result<(), StoreError<T>> {
+        let Self { xa, index } = self;
+        let index = *index;
+
+        let ptr = value.into_foreign();
+        xa.with_guard(guard, |guard| {
+            // SAFETY: `ptr` came from `T::into_foreign`.
+            unsafe { Self::replace(guard, index, ptr) }
+        })
+        .map_err(|error| {
+            // SAFETY: `ptr` came from `T::into_foreign` and `Self::replace` does not take ownership
+            // of the value on error.
+            let value = unsafe { T::from_foreign(ptr) };
+            StoreError { value, error }
+        })
+    }
+
+    /// Fills the reservation.
+    pub fn fill(self, value: T) -> Result<(), StoreError<T>> {
+        let result = self.fill_inner(None, value);
+        mem::forget(self);
+        result
+    }
+
+    /// Fills the reservation without acquiring the array lock.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the passed guard locks a different array.
+    pub fn fill_locked(self, guard: &mut Guard<'_, T>, value: T) -> Result<(), StoreError<T>> {
+        let result = self.fill_inner(Some(guard), value);
+        mem::forget(self);
+        result
+    }
+
+    fn release_inner(&self, guard: Option<&mut Guard<'_, T>>) -> Result {
+        let Self { xa, index } = self;
+        let index = *index;
+
+        xa.with_guard(guard, |guard| {
+            let ptr = null_mut();
+            // SAFETY: `ptr` is `NULL`.
+            unsafe { Self::replace(guard, index, ptr) }
+        })
+    }
+
+    /// Releases the reservation without acquiring the array lock.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the passed guard locks a different array.
+    pub fn release_locked(self, guard: &mut Guard<'_, T>) -> Result {
+        let result = self.release_inner(Some(guard));
+        mem::forget(self);
+        result
+    }
+}
+
+impl<T: ForeignOwnable> Drop for Reservation<'_, T> {
+    fn drop(&mut self) {
+        // NB: Errors here are possible since `Guard::store` does not honor reservations.
+        let _: Result = self.release_inner(None);
+    }
 }
 
 // SAFETY: `XArray<T>` has no shared mutable state so it is `Send` iff `T` is `Send`.
@@ -282,3 +565,133 @@ unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
 // SAFETY: `XArray<T>` serialises the interior mutability it provides so it is `Sync` iff `T` is
 // `Send`.
 unsafe impl<T: ForeignOwnable + Send> Sync for XArray<T> {}
+
+#[macros::kunit_tests(rust_xarray_kunit)]
+mod tests {
+    use super::*;
+    use pin_init::stack_pin_init;
+
+    fn new_kbox<T>(value: T) -> Result<KBox<T>> {
+        KBox::new(value, GFP_KERNEL).map_err(Into::into)
+    }
+
+    #[test]
+    fn test_alloc_kind_alloc() -> Result {
+        test_alloc_kind(AllocKind::Alloc, 0)
+    }
+
+    #[test]
+    fn test_alloc_kind_alloc1() -> Result {
+        test_alloc_kind(AllocKind::Alloc1, 1)
+    }
+
+    fn test_alloc_kind(kind: AllocKind, expected_index: usize) -> Result {
+        stack_pin_init!(let xa = XArray::new(kind));
+        let mut guard = xa.lock();
+
+        let reservation = guard.reserve_limit(.., GFP_KERNEL)?;
+        assert_eq!(reservation.index(), expected_index);
+        reservation.release_locked(&mut guard)?;
+
+        let insertion = guard.insert_limit(.., new_kbox(0x1337)?, GFP_KERNEL);
+        assert!(insertion.is_ok());
+        let insertion_index = insertion.unwrap();
+        assert_eq!(insertion_index, expected_index);
+
+        Ok(())
+    }
+
+    const IDX: usize = 0x1337;
+
+    fn insert<T: ForeignOwnable>(guard: &mut Guard<'_, T>, value: T) -> Result<(), StoreError<T>> {
+        guard.insert(IDX, value, GFP_KERNEL)
+    }
+
+    fn reserve<'a, T: ForeignOwnable>(guard: &mut Guard<'a, T>) -> Result<Reservation<'a, T>> {
+        guard.reserve(IDX, GFP_KERNEL)
+    }
+
+    #[track_caller]
+    fn check_not_vacant<'a>(guard: &mut Guard<'a, KBox<usize>>) -> Result {
+        // Insertion fails.
+        {
+            let beef = new_kbox(0xbeef)?;
+            let ret = insert(guard, beef);
+            assert!(ret.is_err());
+            let StoreError { error, value } = ret.unwrap_err();
+            assert_eq!(error, EBUSY);
+            assert_eq!(*value, 0xbeef);
+        }
+
+        // Reservation fails.
+        {
+            let ret = reserve(guard);
+            assert!(ret.is_err());
+            assert_eq!(ret.unwrap_err(), EBUSY);
+        }
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_insert_and_reserve_interaction() -> Result {
+        stack_pin_init!(let xa = XArray::new(Default::default()));
+        let mut guard = xa.lock();
+
+        // Vacant.
+        assert_eq!(guard.get(IDX), None);
+
+        // Reservation succeeds.
+        let reservation = {
+            let ret = reserve(&mut guard);
+            assert!(ret.is_ok());
+            ret.unwrap()
+        };
+
+        // Reserved presents as vacant.
+        assert_eq!(guard.get(IDX), None);
+
+        check_not_vacant(&mut guard)?;
+
+        // Release reservation.
+        {
+            let ret = reservation.release_locked(&mut guard);
+            assert!(ret.is_ok());
+            let () = ret.unwrap();
+        }
+
+        // Vacant again.
+        assert_eq!(guard.get(IDX), None);
+
+        // Insert succeeds.
+        {
+            let dead = new_kbox(0xdead)?;
+            let ret = insert(&mut guard, dead);
+            assert!(ret.is_ok());
+            let () = ret.unwrap();
+        }
+
+        check_not_vacant(&mut guard)?;
+
+        // Remove.
+        assert_eq!(guard.remove(IDX).as_deref(), Some(&0xdead));
+
+        // Reserve and fill.
+        {
+            let beef = new_kbox(0xbeef)?;
+            let ret = reserve(&mut guard);
+            assert!(ret.is_ok());
+            let reservation = ret.unwrap();
+            let ret = reservation.fill_locked(&mut guard, beef);
+            assert!(ret.is_ok());
+            let () = ret.unwrap();
+        };
+
+        check_not_vacant(&mut guard)?;
+
+        // Remove.
+        assert_eq!(guard.remove(IDX).as_deref(), Some(&0xbeef));
+
+        Ok(())
+    }
+}

-- 
2.50.0


