Return-Path: <linux-fsdevel+bounces-58747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC269B31205
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F0B1CC7070
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53D92ECD12;
	Fri, 22 Aug 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbJ3fk7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31D2EBDC9
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852172; cv=none; b=cMWfPXhk0w4WzEo8klNOjPAmknmF/dI3Qv7oq87MHgv58rtaLDSjEOw0RdirBr+A60m6FBCvcdKVulddxPZHCJl0ZAVBI3hl5yprK96WEkTPwA5ETsPGUta0hE3XwjzyL2tJXL8hb7Rq6M8I6OZBrZXrfwn/tE7dWJvS5Rv/jVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852172; c=relaxed/simple;
	bh=in5mD66dF6MWhJFhTOWar9Vd/EkPs7Wos8Q4bTZR/Uw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vvr3E96d0cF5R6XpzAdR+WREwP9ChtHV9jtGU+CrOiP78zQDDGL+gaPIt0DqMQxSOs3TVyW/VCCY7eqcDiNR8Ng9rJfYrtQBRQWawqQqZ+/hAQ1os3TWkxlhTst7Gpp1o3OLElwBAnO8ej02OwdxjNDttTWM28ByV8oW+IXNi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rbJ3fk7E; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0071c1so8845555e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755852168; x=1756456968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DDkpJcAPlE9LIu6Ir4cHL/5Mh0mGhXKda2sSeyuNZGU=;
        b=rbJ3fk7EEesZMyWmDdBwsuMINSteB4sysS9TqU6xmDCjVFkr6vX9Z2wdOllC50AddP
         +z87TwKSixwzuRSl4kWZWlwTQM+TpjyAx6d4IAqKWSv2De0zbEKiIYtN/hHWyIMbejOh
         HtV2vHcuIUyO8it0vAvUH5Jmd8VurKWmzz6HPvzoM3JU65aTbVbJdgN+wQBQEVK/3fXS
         LBsNNFEU6iGtg5hsXI6SHX6Ttz8h3ziQ9Irkq15zQiWUqqG5ow5D9KNTEStRrKQ2kg2f
         mpN01qEOzwkE+ut1oURpor0L9nYD/OCFazKAK6pU4T5qMwlUDiAAGltcjVOrrQ5J1P/m
         +c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852168; x=1756456968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDkpJcAPlE9LIu6Ir4cHL/5Mh0mGhXKda2sSeyuNZGU=;
        b=B2GT7elQ3RACfuUOmqFzyB50PivodNh8vwL1Q/1GkV1JQPyjhkvu0LvJhzARBcCwbs
         mYwGv3JuqKkJLUUP/jBXbPZN29TWGIxNc+z3xOq5257WrK6dIh+pQyL4cSUldTC+sLvW
         rdE2q6T8aIqAy2a4Hv4V84alsQtuaTTriCfWULM4hCObs3Y+y86G9N4MPu8ts2rtm4EL
         eV4EDt+JPoZ6uwNm5NwOP/pXtjeI+DXLzgkwRtwNx8bspPCsFqseoitNIt3V6sc7i3UD
         LGBct1GENQYN9h/sFz2XA5uH1/hgZbWaFAq+iFNr9FEPrJm2PdZmft7rDHWDeJQdTv+l
         W7bg==
X-Forwarded-Encrypted: i=1; AJvYcCXs/UMmA3R2BZSuogAlQ6KjmA0Ptm/QhvASukpMCKS5HKUTkEHam8ABnUg8UbaVdeDvuGt/7Wc2k475qf4R@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4gwcYTzI2iPtuufCeTVCx8yK6xzo7NImEQpIsUA4wta6uot7
	3pHvuL/50PVk3PZYd5P/hKiW1z1TVPImppwxIYGy0oXzhWv8esiL67397bFVBxKFclP5VKxG/vJ
	D9H/B0xYWndfyE3ri5g==
X-Google-Smtp-Source: AGHT+IHieDBnpYGPhS67rf2immtvBi64zMak8Dg1tvpotMZwHEiKosyrEMG2JuFJ23cpjKzqAfYVaIKwsvo9eWg=
X-Received: from wmti4.prod.google.com ([2002:a05:600c:8b84:b0:459:8c48:6c34])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fcd:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-45b517cfe71mr20458965e9.17.1755852168517;
 Fri, 22 Aug 2025 01:42:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:42:32 +0000
In-Reply-To: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8638; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=in5mD66dF6MWhJFhTOWar9Vd/EkPs7Wos8Q4bTZR/Uw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoqC2F22YR29+Ubnecs5fZRxU0+A+AJdwXcwKsQ
 eZ0iB4pWlmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKgthQAKCRAEWL7uWMY5
 RlGdD/kBn5yX8w7kpqATUgaD9ysh5C16EdeBS8XFLIF8wArSA0+fmcK/8Y22neUFqc1llH/H0nX
 7yp3G7ZkR/tMxusJEUoinP+wnr+zOX1dxi+hvcpwwE9agyX1DWQOrNotk/UFeZaXjE8Bt/ZTO8N
 xxRu49PsgOjfj+I3SS/V8DXOkmC//03VLf5RqPaouORGQ58PaoWzB+2ZDGDi9S9H46goqXYTqHE
 jsZGpJHc67/VZdX1/+IWxt9iGRgXQGeTId8vtzj7LfdeCkbmvZDCqF34pNTaesvxAHWKl6PlQ6m
 5Jk/+/8jxp7yI2kqO6vBEVJefeGaxW2F1/M/PbiTPthCBKLI5EtJcsg/BUFgv236pWNW2V15x09
 jrFX0gqqkFMDIULTHGTEAcGKkRbEWEr2PF3vZHmYitP7TWABpEpDgSJDaswL+I0Gu4abj8tIi39
 xfG61HCKxcTZeYsVnunAIXQV0rlgBEjrgtvu3odywpdN0vFRuY2YAgu/tmJDxYzTVbV4qxfDWuR
 KUKJHl6cVouQgY43rp/Y/VDtthw87yu69hYoJ2ngXCDSTPIXO+cKOGHCCwBEguIuWv1DveiJB3D
 WYb5aVhf4cM0gnFJZbKkvNhC70nk5ZMVul7MS0PnzpHPXmuKJMaWvYs2CAPwFMsapP/r4BxSvE3 3vkAJGdDn1lXmiQ==
X-Mailer: b4 0.14.2
Message-ID: <20250822-iov-iter-v5-1-6ce4819c2977@google.com>
Subject: [PATCH v5 1/5] rust: iov: add iov_iter abstractions for ITER_SOURCE
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

This adds abstractions for the iov_iter type in the case where
data_source is ITER_SOURCE. This will make Rust implementations of
fops->write_iter possible.

This series only has support for using existing IO vectors created by C
code. Additional abstractions will be needed to support the creation of
IO vectors in Rust code.

These abstractions make the assumption that `struct iov_iter` does not
have internal self-references, which implies that it is valid to move it
between different local variables.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/iov.rs | 171 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 2 files changed, 172 insertions(+)

diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
new file mode 100644
index 0000000000000000000000000000000000000000..01f4b90ff8b494f0089cb756d6f64d34966c4b7d
--- /dev/null
+++ b/rust/kernel/iov.rs
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! IO vectors.
+//!
+//! C headers: [`include/linux/iov_iter.h`](srctree/include/linux/iov_iter.h),
+//! [`include/linux/uio.h`](srctree/include/linux/uio.h)
+
+use crate::{
+    alloc::{Allocator, Flags},
+    bindings,
+    prelude::*,
+    types::Opaque,
+};
+use core::{marker::PhantomData, mem::MaybeUninit, ptr, slice};
+
+const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
+
+/// An IO vector that acts as a source of data.
+///
+/// The data may come from many different sources. This includes both things in kernel-space and
+/// reading from userspace. It's not necessarily the case that the data source is immutable, so
+/// rewinding the IO vector to read the same data twice is not guaranteed to result in the same
+/// bytes. It's also possible that the data source is mapped in a thread-local manner using e.g.
+/// `kmap_local_page()`, so this type is not `Send` to ensure that the mapping is read from the
+/// right context in that scenario.
+///
+/// # Invariants
+///
+/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_SOURCE`. For the duration
+/// of `'data`, it must be safe to read from this IO vector using the standard C methods for this
+/// purpose.
+#[repr(transparent)]
+pub struct IovIterSource<'data> {
+    iov: Opaque<bindings::iov_iter>,
+    /// Represent to the type system that this value contains a pointer to readable data it does
+    /// not own.
+    _source: PhantomData<&'data [u8]>,
+}
+
+impl<'data> IovIterSource<'data> {
+    /// Obtain an `IovIterSource` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The referenced `struct iov_iter` must be valid and must only be accessed through the
+    ///   returned reference for the duration of `'iov`.
+    /// * The referenced `struct iov_iter` must have `data_source` set to `ITER_SOURCE`.
+    /// * For the duration of `'data`, it must be safe to read from this IO vector using the
+    ///   standard C methods for this purpose.
+    #[track_caller]
+    #[inline]
+    pub unsafe fn from_raw<'iov>(ptr: *mut bindings::iov_iter) -> &'iov mut IovIterSource<'data> {
+        // SAFETY: The caller ensures that `ptr` is valid.
+        let data_source = unsafe { (*ptr).data_source };
+        assert_eq!(data_source, ITER_SOURCE);
+
+        // SAFETY: The caller ensures the type invariants for the right durations, and
+        // `IovIterSource` is layout compatible with `struct iov_iter`.
+        unsafe { &mut *ptr.cast::<IovIterSource<'data>>() }
+    }
+
+    /// Access this as a raw `struct iov_iter`.
+    #[inline]
+    pub fn as_raw(&mut self) -> *mut bindings::iov_iter {
+        self.iov.get()
+    }
+
+    /// Returns the number of bytes available in this IO vector.
+    ///
+    /// Note that this may overestimate the number of bytes. For example, reading from userspace
+    /// memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
+    #[inline]
+    pub fn len(&self) -> usize {
+        // SAFETY: We have shared access to this IO vector, so we can read its `count` field.
+        unsafe {
+            (*self.iov.get())
+                .__bindgen_anon_1
+                .__bindgen_anon_1
+                .as_ref()
+                .count
+        }
+    }
+
+    /// Returns whether there are any bytes left in this IO vector.
+    ///
+    /// This may return `true` even if there are no more bytes available. For example, reading from
+    /// userspace memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
+    #[inline]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Advance this IO vector by `bytes` bytes.
+    ///
+    /// If `bytes` is larger than the size of this IO vector, it is advanced to the end.
+    #[inline]
+    pub fn advance(&mut self, bytes: usize) {
+        // SAFETY: By the type invariants, `self.iov` is a valid IO vector.
+        unsafe { bindings::iov_iter_advance(self.as_raw(), bytes) };
+    }
+
+    /// Advance this IO vector backwards by `bytes` bytes.
+    ///
+    /// # Safety
+    ///
+    /// The IO vector must not be reverted to before its beginning.
+    #[inline]
+    pub unsafe fn revert(&mut self, bytes: usize) {
+        // SAFETY: By the type invariants, `self.iov` is a valid IO vector, and the caller
+        // ensures that `bytes` is in bounds.
+        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
+    }
+
+    /// Read data from this IO vector.
+    ///
+    /// Returns the number of bytes that have been copied.
+    #[inline]
+    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
+        // SAFETY: `Self::copy_from_iter_raw` guarantees that it will not write any uninitialized
+        // bytes in the provided buffer, so `out` is still a valid `u8` slice after this call.
+        let out = unsafe { &mut *(ptr::from_mut(out) as *mut [MaybeUninit<u8>]) };
+
+        self.copy_from_iter_raw(out).len()
+    }
+
+    /// Read data from this IO vector and append it to a vector.
+    ///
+    /// Returns the number of bytes that have been copied.
+    #[inline]
+    pub fn copy_from_iter_vec<A: Allocator>(
+        &mut self,
+        out: &mut Vec<u8, A>,
+        flags: Flags,
+    ) -> Result<usize> {
+        out.reserve(self.len(), flags)?;
+        let len = self.copy_from_iter_raw(out.spare_capacity_mut()).len();
+        // SAFETY:
+        // - `len` is the length of a subslice of the spare capacity, so `len` is at most the
+        //   length of the spare capacity.
+        // - `Self::copy_from_iter_raw` guarantees that the first `len` bytes of the spare capacity
+        //   have been initialized.
+        unsafe { out.inc_len(len) };
+        Ok(len)
+    }
+
+    /// Read data from this IO vector into potentially uninitialized memory.
+    ///
+    /// Returns the sub-slice of the output that has been initialized. If the returned slice is
+    /// shorter than the input buffer, then the entire IO vector has been read.
+    ///
+    /// This will never write uninitialized bytes to the provided buffer.
+    #[inline]
+    pub fn copy_from_iter_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> &mut [u8] {
+        let capacity = out.len();
+        let out = out.as_mut_ptr().cast::<u8>();
+
+        // GUARANTEES: The C API guarantees that it does not write uninitialized bytes to the
+        // provided buffer.
+        // SAFETY:
+        // * By the type invariants, it is still valid to read from this IO vector.
+        // * `out` is valid for writing for `capacity` bytes because it comes from a slice of
+        //   that length.
+        let len = unsafe { bindings::_copy_from_iter(out.cast(), capacity, self.as_raw()) };
+
+        // SAFETY: The underlying C api guarantees that initialized bytes have been written to the
+        // first `len` bytes of the spare capacity.
+        unsafe { slice::from_raw_parts_mut(out, len) }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c0badf548025a57f946fa18bc73e3..99dbb7b2812e018ac45989487816ce020f38aa61 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -92,6 +92,7 @@
 pub mod init;
 pub mod io;
 pub mod ioctl;
+pub mod iov;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


