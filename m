Return-Path: <linux-fsdevel+bounces-58748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD3CB31209
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D319D5688B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E892ECE94;
	Fri, 22 Aug 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="js8R/EZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD78221577
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852173; cv=none; b=nzff02c9W6BKM7/QWRab2plWUzQR3sfGUt0E2/3i2MkpI1yjTOjbk29fSji6IclCm1jgT70Xb1dtexQez83RgHxqpgZlhz1J8SbuZID+EBVt+hlYTFU/qEpJVDUzlsoD1xS+j6s5M8zNlcHCfdKuhizw+kMKag7a5hbiHURNR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852173; c=relaxed/simple;
	bh=ODBIitTzxUXBO94d3vvMB/FAJjjO9QEhgsDUttvZtao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZheWMl+Qa1C8Y5hgViOKp6UNxYGktl9Q5zlO0ns0QzR1EJkGKeqHGCbxobV5XNqQFncwB/HIpWWyEOMOPtxrpA+unfraeyBcFI4fjBihLMeqwjLL4xQnHC0nY4duAiI/64YGGbbHlOYeKTrAUsbW+D/cwKQYoapEMNIPsfeeEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=js8R/EZl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso13126565e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755852169; x=1756456969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cW8wBssRteKh9TtGxIze/nGUMED/N5ojfLHAnK9eV2g=;
        b=js8R/EZliGbfWbuPVaYf98qy56baqjD+sBbr61lwHBjhjdTjQTJ9BLMNRjuOHbOAp9
         jO00455bM3ED8wywsHp8WN5M4bIr8j4iAa61JFS5/BPJQ2bmSneG3cKUw7JLskHk3yh0
         dzc/tpM0Dwv8TNsC88BFd2kIOt0RtMZ6eS/55x8xanlAa9AcTzLeTs2cPSTjgicaUNvy
         mo3IoJR3vs3ewn6bymZof1u99TSBPsDyL2OKiAyMttEzy/aiVOzU6/wjSA9XwKxHGDqx
         8IKhEGt88OE5GOPvM/VfIRdo+BdidhWu3pAXBw7e1B8LAokOnfvgEBCFulX08Ibuw/eu
         QSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852169; x=1756456969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cW8wBssRteKh9TtGxIze/nGUMED/N5ojfLHAnK9eV2g=;
        b=eLxE9sAySU7Trje/pZV1psR/9uJu4k8s72ha6rw0lZidnK2k551l8awHwBxKXTqaei
         u/MS23EEp+4iPke/uJ3NGwDTGDnIvm+iuKQ3ivDdvvciNshEV04ZShS0WHHl1v0OJIYk
         zUYKmwbPLqT4TrBYs5vQYDk7tcHl0y5DCQ1920+xZ4Pap5CtDUOlN2rkVXxjbj8/Jca1
         LkFNknAPtcxPZQqua+W1zys+zGijtrxj43FSpkPkfkcs0gezrB9UpYhkwHEYsgAFY0T0
         rV+UG6bUI02SmZXnQyeL+M6t84hN+LAW0edFicCe/xqeSO6/+iMkaSLnruY9+JyIahfP
         pAGA==
X-Forwarded-Encrypted: i=1; AJvYcCWWN9kQPsyJoalUg+WFYg3HjqcS33oZSecQG891U1tFdDp+Fde7WRDh8TgI5hy7kps0D5SeQ2SCimsIKkjI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2qh2oIXKTAzKDGLwya6hvxUn9t7c1VUcmCBu+cPQRt+nKs5bi
	2ctIo5RfN2A4zEfenKsnTfk/lPRVDEk9GhteN20HVXZ+IZjhFoIVB9leUWD4hjZagaHJOXjhk6j
	/mWXxV2gEgTcWBOY1Fw==
X-Google-Smtp-Source: AGHT+IFrQckRHYDsKo694J6+s5vHo+fM7l4unH3LDECydbGtTUfVArVEqGHPJsJKikDK/LWckHfj2vsMKg5fvGY=
X-Received: from wmbhj9.prod.google.com ([2002:a05:600c:5289:b0:45a:29a8:a9e1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4705:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45b517d49d4mr17113005e9.24.1755852169617;
 Fri, 22 Aug 2025 01:42:49 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:42:33 +0000
In-Reply-To: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7578; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ODBIitTzxUXBO94d3vvMB/FAJjjO9QEhgsDUttvZtao=;
 b=kA0DAAoBBFi+7ljGOUYByyZiAGioLYWia6Humescx8Z7qQ5tXLsVR836qZwZTqB1jNauY2fUh
 YkCMwQAAQoAHRYhBIOSopRNZAcK8Ui9sgRYvu5YxjlGBQJoqC2FAAoJEARYvu5YxjlGHagP/2pM
 SHC18QWiyU1W0CnnbeOhCkbLq7Dc8kmWg9tVOqMP2/LROT6a98BkkiSOA1vgnZQf1PpP1eoNnrA
 ADtCA2rR7WeWHWORokmsnvwm4M4heTbTmAvYUgmRmiR1Fvv7hmsLmT93aIZ0HIpF+u5tQ7wy02Z
 6Tq3QiS4NK1t1SipWlY4P2XhS2o4dMW2JHdsG7znI56Mm0pBr2WJ1z1G6Ft95H9V0om/XgQAwfv
 ZKFCogeNAm+fB2O8uJLT2nwjYn704DETlLjcauE6xGHM6xTdJ7khdTZRo9t8EjjbMtHngf8+Tnc
 WAbJiBky43aJnPlI8fiaDrySQVmUsxpkRdF1efRUD4mauXTvL05+E6URO/6Asd3HU+HK+A5E7Vu
 jGdTLmcvp9hU43iISum5k4GlzaExNvmEQP7TQoC8jGHzXfdKsH41THXGKODhRkPRBqYK4hBTf9s
 kg2b3KCN62qAC/J053jjLwr25JtpbXQd6vOUzPQHtnL7fH+IO6jz5JebtbLkSCr1xEBS9/c6+Ki
 a+s0YHcg03w6ix74g5ch3rIY2GeKxNsA9AMz9nZhS8Qsye28SwuM1PAM+ZesqAHDQDB3BRjKr2e
 zRbTlxF8XaFgs5iOAP002Z8YACwEVmSz/d1ujPi/Soz3TtuOi9Rl6pShBrRZlK3lPiZHiWt47Ro DwH2F
X-Mailer: b4 0.14.2
Message-ID: <20250822-iov-iter-v5-2-6ce4819c2977@google.com>
Subject: [PATCH v5 2/5] rust: iov: add iov_iter abstractions for ITER_DEST
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
data_source is ITER_DEST. This will make Rust implementations of
fops->read_iter possible.

This series only has support for using existing IO vectors created by C
code. Additional abstractions will be needed to support the creation of
IO vectors in Rust code.

These abstractions make the assumption that `struct iov_iter` does not
have internal self-references, which implies that it is valid to move it
between different local variables.

This patch adds an IovIterDest struct that is very similar to the
IovIterSource from the previous patch. However, as the methods on the
two structs have very little overlap (just getting the length and
advance/revert), I do not think it is worth it to try and deduplicate
this logic.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/iov.rs | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
index 01f4b90ff8b494f0089cb756d6f64d34966c4b7d..43bae8923c4611927d3bfe747fdef69a1f73529c 100644
--- a/rust/kernel/iov.rs
+++ b/rust/kernel/iov.rs
@@ -16,6 +16,15 @@
 use core::{marker::PhantomData, mem::MaybeUninit, ptr, slice};
 
 const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
+const ITER_DEST: bool = bindings::ITER_DEST != 0;
+
+// Compile-time assertion for the above constants.
+const _: () = {
+    build_assert!(
+        ITER_SOURCE != ITER_DEST,
+        "ITER_DEST and ITER_SOURCE should be different."
+    );
+};
 
 /// An IO vector that acts as a source of data.
 ///
@@ -169,3 +178,137 @@ pub fn copy_from_iter_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> &mut [u8] {
         unsafe { slice::from_raw_parts_mut(out, len) }
     }
 }
+
+/// An IO vector that acts as a destination for data.
+///
+/// IO vectors support many different types of destinations. This includes both buffers in
+/// kernel-space and writing to userspace. It's possible that the destination buffer is mapped in a
+/// thread-local manner using e.g. `kmap_local_page()`, so this type is not `Send` to ensure that
+/// the mapping is written to the right context in that scenario.
+///
+/// # Invariants
+///
+/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_DEST`. For the duration of
+/// `'data`, it must be safe to write to this IO vector using the standard C methods for this
+/// purpose.
+#[repr(transparent)]
+pub struct IovIterDest<'data> {
+    iov: Opaque<bindings::iov_iter>,
+    /// Represent to the type system that this value contains a pointer to writable data it does
+    /// not own.
+    _source: PhantomData<&'data mut [u8]>,
+}
+
+impl<'data> IovIterDest<'data> {
+    /// Obtain an `IovIterDest` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The referenced `struct iov_iter` must be valid and must only be accessed through the
+    ///   returned reference for the duration of `'iov`.
+    /// * The referenced `struct iov_iter` must have `data_source` set to `ITER_DEST`.
+    /// * For the duration of `'data`, it must be safe to write to this IO vector using the
+    ///   standard C methods for this purpose.
+    #[track_caller]
+    #[inline]
+    pub unsafe fn from_raw<'iov>(ptr: *mut bindings::iov_iter) -> &'iov mut IovIterDest<'data> {
+        // SAFETY: The caller ensures that `ptr` is valid.
+        let data_source = unsafe { (*ptr).data_source };
+        assert_eq!(data_source, ITER_DEST);
+
+        // SAFETY: The caller ensures the type invariants for the right durations, and
+        // `IovIterSource` is layout compatible with `struct iov_iter`.
+        unsafe { &mut *ptr.cast::<IovIterDest<'data>>() }
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
+    /// memory could fail with EFAULT, which will be treated as the end of the IO vector.
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
+    /// userspace memory could fail with EFAULT, which will be treated as the end of the IO vector.
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
+    /// Write data to this IO vector.
+    ///
+    /// Returns the number of bytes that were written. If this is shorter than the provided slice,
+    /// then no more bytes can be written.
+    #[inline]
+    pub fn copy_to_iter(&mut self, input: &[u8]) -> usize {
+        // SAFETY:
+        // * By the type invariants, it is still valid to write to this IO vector.
+        // * `input` is valid for `input.len()` bytes.
+        unsafe { bindings::_copy_to_iter(input.as_ptr().cast(), input.len(), self.as_raw()) }
+    }
+
+    /// Utility for implementing `read_iter` given the full contents of the file.
+    ///
+    /// The full contents of the file being read from is represented by `contents`. This call will
+    /// write the appropriate sub-slice of `contents` and update the file position in `ppos` so
+    /// that the file will appear to contain `contents` even if takes multiple reads to read the
+    /// entire file.
+    #[inline]
+    pub fn simple_read_from_buffer(&mut self, ppos: &mut i64, contents: &[u8]) -> Result<usize> {
+        if *ppos < 0 {
+            return Err(EINVAL);
+        }
+        let Ok(pos) = usize::try_from(*ppos) else {
+            return Ok(0);
+        };
+        if pos >= contents.len() {
+            return Ok(0);
+        }
+
+        // BOUNDS: We just checked that `pos < contents.len()` above.
+        let num_written = self.copy_to_iter(&contents[pos..]);
+
+        // OVERFLOW: `pos+num_written <= contents.len() <= isize::MAX <= i64::MAX`.
+        *ppos = (pos + num_written) as i64;
+
+        Ok(num_written)
+    }
+}

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


