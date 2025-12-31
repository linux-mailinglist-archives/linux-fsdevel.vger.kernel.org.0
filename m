Return-Path: <linux-fsdevel+bounces-72289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A02DCEBF8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 13:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B52E2304A12C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71B3322A1F;
	Wed, 31 Dec 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STagWI6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F33322B76
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183763; cv=none; b=G2kjuZnCBhpagRcBumgSgQvzsMLuzG3ooXr22/diO60mq3L0D9zN8U4rRXJsy1exkIOW2EXVy1rafMmQdipFMbagA9g/AtFiHcCLsVmAKgxWP4+O/a0dfttzI5ym9J9Fzau1B5DqIGL00hAgoUsmqhP5NoDjdUxroOEWosj/PoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183763; c=relaxed/simple;
	bh=xEInC3fu2akfjyTzgU6ASYK4Ti9C0Fwxb+5tsaoSXWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D3GgT7WW9X0nnVwIy71ui6h+ONbtBQNvl0QC8g0taXV09TEyGQOzVaqMxIy7tVqXEeJP/dySvVcbmo9IcnyQrtYtVyBiXsIpLUaXBKajJ5zp9yPaSLzvUmCgUv6t9uskuaQMZy7/F3O9jraAO2TrgUD7aGIWY07bd7Aryff1A6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STagWI6n; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4325b81081aso5808601f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 04:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767183759; x=1767788559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wY+MioUEzLGTu451Qf335kX3GDWJpHFtljbNWqzcaPs=;
        b=STagWI6nlkE1Fe1kiEkmTx4MFJJa88tmaE3Ce2E6MWedolcOH0TmpGnS1sC31YOfVo
         L27CTh+4mOiAoS/TktjWTHIzQZnkLChgWXJrrkgsyKXSN52YW8OAQ4YMjOKk/D39URNl
         KCD6g7INvr+fwY9JoZwXE6bQkPM0oO75gRt3P/L/3KfhF1LMPYYMSug9nhp8HQ1L1ZC0
         cOCEOpxN2368VuRrqg68g2E6vmPksPr4ae/XmgQFpoTgunDo/7PiW7cHOhR+bYx3mB+f
         upTamGGgp2rt3VfIpEOjG2L69JhuuWHSYTJTV8JnXHxoipSjxmbr2NBT5DRUiIWSJyLA
         5sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183759; x=1767788559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY+MioUEzLGTu451Qf335kX3GDWJpHFtljbNWqzcaPs=;
        b=YkWvvR2NcsRf3/h/Fwew7G/aR7oOc0Rg6SdmnXqBXwgbOyzW9tNZQxLwlkmPxfqCYl
         k0b0mMFn/dIMlNXish7HEKoQ6vtbaxrGAfxDUkhC8O7UwTQxOaV6HRTod8BTUzk/Cs6t
         yCNeZTqG7vEWItatTWuPXCwn9y1NKJVget3208ISTtqyFV5hUkxx1xzr1J8HWooTr9X3
         KeTUUGBAx5Dat/9qaxxdt/m7roAE+55SPDjbFvbd/uWeAU3t4K4+voS92r97SwbTgg7Y
         T9V711SOcb6Mwj6OEikqE+L8qIQA/MgelJy8bsQhEyAVhy6CHns8EEnOOWJWfNKKjYhW
         7r3A==
X-Forwarded-Encrypted: i=1; AJvYcCVD6kFtR3eNN+jOyRcnc4nHiM4x73w+Zo+ZFDw2cjKo2GZsgYG6rjQGBlsg0r3mq7EBDYhIjzZCMfBYBvOb@vger.kernel.org
X-Gm-Message-State: AOJu0YzaXtiqi0qmZ1gcglmu7GxJTpTKdW0NdHBlFrbeQm/F0jXNUXgY
	+g39gvY9Z5ytRDbtIUANDlMBKk19pyFisfw4S67soffSU5gL0h4tLpi/dwkGc7QNBeDx3CYsWUB
	Y/8VDeZ5f3dhhro7Mog==
X-Google-Smtp-Source: AGHT+IEitYbwlxMWnTamAVtk40AR4WQ2RNUYZFRzIPAOaqn/Hd7ztALmxDa49nVO+fS0C8mDnzEVsTtIzFsZHnI=
X-Received: from wrbez4.prod.google.com ([2002:a05:6000:2504:b0:430:2785:456])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:178c:b0:431:104:6daf with SMTP id ffacd0b85a97d-4324e709ab3mr53524517f8f.54.1767183759209;
 Wed, 31 Dec 2025 04:22:39 -0800 (PST)
Date: Wed, 31 Dec 2025 12:22:26 +0000
In-Reply-To: <20251231-rwonce-v1-0-702a10b85278@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10427; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=xEInC3fu2akfjyTzgU6ASYK4Ti9C0Fwxb+5tsaoSXWY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpVRWL8JXFNz2YiOAabCoqI+IEhQm+4iN4Cw2GP
 8bBpof1XGuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVUViwAKCRAEWL7uWMY5
 Rp/5EAC37oMUwkvFIuBMb1J8TrahAvBfS7wmSDGExhSeTS/0tTlOAmgS6ra79WgITGRX0Z73b37
 VO2XL36+LYeSzqZTthJ22W0gB0MXJn4KoMYL6mm25GNEUrDj8DvsczCDT3tlvxmfQjkQWbFXh35
 IfM2dzl5IImt4EdlyZWMwjc7CxqCcfnzUk/fkfSJdU9z6wFdNCVwkuxQoPYP3oM/V+QdWhXrtFV
 z+pMFdXoRaY3ptvtVPH4yEDd2GcgpTSd+e77NhR7xeeZo2qIKh3f47WGJHbGMblg9YIqkMt7GdA
 0isxcCJxtTG5l4KWZdXOZ8plZiHVSAKrLCqasMPXvy3bhHxmtQum+kluiC8TDROyN351r6GHyaZ
 mCVDGtbeoCrgHumlhCy8HcNkcE2W1QFAM1Z84rTVhp3G5x6O3ah+W8nKlZRF1YwX8D6rX0rkNMi
 +G2vN9bYtKEFLG7JeA/9lV5ysIWX2N+dM5ZyauD5lzCXVJgsReYKyvNyYD2UgXqBpq8X2X6805X
 7REv3jxoGcSlaMd5ANOKwFWO+Cj5Ef2y6ZxmUWJs6BinfW0ndgLlFI+Y0bmA9wAzyAEFyGOWm2q
 6x4WLaSet0wlWDMy+P1vDdIRjA6DIbGPmrorx3yrAFojNztMSvFoTrQXuXbX68QTFJv1cL7R+Ex wRxItByaQGdKzfg==
X-Mailer: b4 0.14.2
Message-ID: <20251231-rwonce-v1-2-702a10b85278@google.com>
Subject: [PATCH 2/5] rust: sync: add READ_ONCE and WRITE_ONCE
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

There are currently a few places in the kernel where we use volatile
reads when we really should be using `READ_ONCE`. To make it possible to
replace these with proper `READ_ONCE` calls, introduce a Rust version of
`READ_ONCE`.

I've written the code to use Rust's volatile ops directly when possible.
This results in a small amount of code duplication, but I think it makes
sense for READ_ONCE and WRITE_ONCE to be implemented in pure Rust when
possible. Otherwise they would unconditionally be a function call unless
you have a system where you can perform cross-language inlining.

I considered these functions in the bindings crate instead of kernel
crate. I actually think it would make a lot of sense. But it implies
some annoying complications on old compilers since the #![feature()]
invocations in kernel/lib.rs do not apply in the bindings crate.

For now, we do not support using READ_ONCE on compound types even if
they have the right size. This can be added later.

This fails checkpatch due to a misordered MAINTAINERS entry, but this is
a pre-existing problem.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 MAINTAINERS                |   2 +
 rust/helpers/helpers.c     |   1 +
 rust/helpers/rwonce.c      |  34 ++++++++
 rust/kernel/sync.rs        |   2 +
 rust/kernel/sync/rwonce.rs | 188 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 227 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12f49de7fe036c2439c00f9f4c67b2219d72a4c3..1d0cae158fe2cc7d99b6a64c11176b635e2d14e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4117,9 +4117,11 @@ F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
 F:	include/linux/refcount.h
 F:	scripts/atomic/
+F:	rust/helpers/rwonce.c
 F:	rust/kernel/sync/atomic.rs
 F:	rust/kernel/sync/atomic/
 F:	rust/kernel/sync/refcount.rs
+F:	rust/kernel/sync/rwonce.rs
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 79c72762ad9c4b473971e6210c9577860d2e2b08..28b79ca7844fb744e5ad128238824921c055ec82 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -48,6 +48,7 @@
 #include "rcu.c"
 #include "refcount.c"
 #include "regulator.c"
+#include "rwonce.c"
 #include "scatterlist.c"
 #include "security.c"
 #include "signal.c"
diff --git a/rust/helpers/rwonce.c b/rust/helpers/rwonce.c
new file mode 100644
index 0000000000000000000000000000000000000000..55c621678cd632e728cb925b6a4a2e34e2fc4884
--- /dev/null
+++ b/rust/helpers/rwonce.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2025 Google LLC.
+ */
+
+#ifdef CONFIG_ARCH_USE_CUSTOM_READ_ONCE
+
+__rust_helper u8 rust_helper_read_once_1(const u8 *ptr)
+{
+	return READ_ONCE(*ptr);
+}
+
+__rust_helper u16 rust_helper_read_once_2(const u16 *ptr)
+{
+	return READ_ONCE(*ptr);
+}
+
+__rust_helper u32 rust_helper_read_once_4(const u32 *ptr)
+{
+	return READ_ONCE(*ptr);
+}
+
+__rust_helper u64 rust_helper_read_once_8(const u64 *ptr)
+{
+	return READ_ONCE(*ptr);
+}
+
+__rust_helper void *rust_helper_read_once_ptr(void * const *ptr)
+{
+	return READ_ONCE(*ptr);
+}
+
+#endif
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 5df87e2bd212e192b8a67644bd99f05b9d4afd75..a5bf7bdc3fa8a044786eafae39fe8844aeeef057 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -20,6 +20,7 @@
 pub mod poll;
 pub mod rcu;
 mod refcount;
+pub mod rwonce;
 mod set_once;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
@@ -30,6 +31,7 @@
 pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
 pub use locked_by::LockedBy;
 pub use refcount::Refcount;
+pub use rwonce::{READ_ONCE, WRITE_ONCE};
 pub use set_once::SetOnce;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
diff --git a/rust/kernel/sync/rwonce.rs b/rust/kernel/sync/rwonce.rs
new file mode 100644
index 0000000000000000000000000000000000000000..a1660e43c9ef94011812d1816713cf031a73de1d
--- /dev/null
+++ b/rust/kernel/sync/rwonce.rs
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Rust version of the raw `READ_ONCE`/`WRITE_ONCE` functions.
+//!
+//! C header: [`include/asm-generic/rwonce.h`](srctree/include/asm-generic/rwonce.h)
+
+/// Read the pointer once.
+///
+/// # Safety
+///
+/// It must be safe to `READ_ONCE` the `ptr` with this type.
+#[inline(always)]
+#[must_use]
+#[track_caller]
+#[expect(non_snake_case)]
+pub unsafe fn READ_ONCE<T: RwOnceType>(ptr: *const T) -> T {
+    // SAFETY: It's safe to read `ptr` once with this type.
+    unsafe { T::read_once(ptr) }
+}
+
+/// Write the pointer once.
+///
+/// # Safety
+///
+/// It must be safe to `WRITE_ONCE` the `ptr` with this type.
+#[inline(always)]
+#[track_caller]
+#[expect(non_snake_case)]
+pub unsafe fn WRITE_ONCE<T: RwOnceType>(ptr: *mut T, val: T) {
+    // SAFETY: It's safe to write `ptr` once with this type.
+    unsafe { T::write_once(ptr, val) };
+}
+
+/// This module contains the generic implementations.
+#[expect(clippy::undocumented_unsafe_blocks)]
+#[expect(clippy::missing_safety_doc)]
+mod rwonce_generic_impl {
+    use core::ffi::c_void;
+    #[allow(unused_imports)]
+    use core::ptr::{read_volatile, write_volatile};
+
+    #[inline(always)]
+    #[track_caller]
+    #[cfg(not(CONFIG_ARCH_USE_CUSTOM_READ_ONCE))]
+    pub(super) unsafe fn read_once_1(ptr: *const u8) -> u8 {
+        unsafe { read_volatile::<u8>(ptr) }
+    }
+
+    #[inline(always)]
+    #[track_caller]
+    #[cfg(not(CONFIG_ARCH_USE_CUSTOM_READ_ONCE))]
+    pub(super) unsafe fn read_once_2(ptr: *const u16) -> u16 {
+        unsafe { read_volatile::<u16>(ptr) }
+    }
+
+    #[inline(always)]
+    #[track_caller]
+    #[cfg(not(CONFIG_ARCH_USE_CUSTOM_READ_ONCE))]
+    pub(super) unsafe fn read_once_4(ptr: *const u32) -> u32 {
+        unsafe { read_volatile::<u32>(ptr) }
+    }
+
+    #[inline(always)]
+    #[track_caller]
+    #[cfg(not(CONFIG_ARCH_USE_CUSTOM_READ_ONCE))]
+    pub(super) unsafe fn read_once_8(ptr: *const u64) -> u64 {
+        unsafe { read_volatile::<u64>(ptr) }
+    }
+
+    #[inline(always)]
+    #[track_caller]
+    #[cfg(not(CONFIG_ARCH_USE_CUSTOM_READ_ONCE))]
+    pub(super) unsafe fn read_once_ptr(ptr: *const *mut c_void) -> *mut c_void {
+        unsafe { read_volatile::<*mut c_void>(ptr) }
+    }
+
+    #[inline(always)]
+    #[track_caller]
+    pub(super) unsafe fn write_once_1(ptr: *mut u8, val: u8) {
+        unsafe { write_volatile::<u8>(ptr, val) }
+    }
+
+    #[inline(always)]
+    #[track_caller]
+    pub(super) unsafe fn write_once_2(ptr: *mut u16, val: u16) {
+        unsafe { write_volatile::<u16>(ptr, val) }
+    }
+
+    #[inline(always)]
+    #[track_caller]
+    pub(super) unsafe fn write_once_4(ptr: *mut u32, val: u32) {
+        unsafe { write_volatile::<u32>(ptr, val) }
+    }
+
+    #[inline(always)]
+    #[track_caller]
+    pub(super) unsafe fn write_once_8(ptr: *mut u64, val: u64) {
+        unsafe { write_volatile::<u64>(ptr, val) }
+    }
+
+    #[inline(always)]
+    #[track_caller]
+    pub(super) unsafe fn write_once_ptr(ptr: *mut *mut c_void, val: *mut c_void) {
+        unsafe { write_volatile::<*mut c_void>(ptr, val) }
+    }
+}
+use rwonce_generic_impl::*;
+
+#[cfg(CONFIG_ARCH_USE_CUSTOM_READ_ONCE)]
+use bindings::{read_once_1, read_once_2, read_once_4, read_once_8, read_once_ptr};
+
+/// Rust trait for types that may be used with `READ_ONCE`/`WRITE_ONCE`.
+///
+/// This serves a similar purpose to the `compiletime_assert_rwonce_type` macro in the C header.
+pub trait RwOnceType {
+    /// The `READ_ONCE` for this type.
+    ///
+    /// # Safety
+    ///
+    /// It must be safe to `READ_ONCE` the `ptr` with this type.
+    unsafe fn read_once(ptr: *const Self) -> Self;
+
+    /// The `WRITE_ONCE` for this type.
+    ///
+    /// # Safety
+    ///
+    /// It must be safe to `WRITE_ONCE` the `ptr` with this type.
+    unsafe fn write_once(ptr: *mut Self, val: Self);
+}
+
+macro_rules! impl_rw_once_type {
+    ($($t:ty, $read:ident, $write:ident $(, <$u:ident>)?;)*) => {$(
+        #[allow(unknown_lints, reason = "unnecessary_transmutes is unknown prior to MSRV 1.88.0")]
+        #[allow(unnecessary_transmutes)]
+        #[allow(clippy::missing_transmute_annotations)]
+        #[allow(clippy::useless_transmute)]
+        impl$(<$u>)? RwOnceType for $t {
+            #[inline(always)]
+            #[track_caller]
+            unsafe fn read_once(ptr: *const Self) -> Self {
+                // SAFETY: The caller ensures we can `READ_ONCE`.
+                //
+                // Note that `transmute` fails to compile if the two types are of different sizes.
+                unsafe { core::mem::transmute($read(ptr.cast())) }
+            }
+
+            #[inline(always)]
+            #[track_caller]
+            unsafe fn write_once(ptr: *mut Self, val: Self) {
+                // SAFETY: The caller ensures we can `WRITE_ONCE`.
+                unsafe { $write(ptr.cast(), core::mem::transmute(val)) };
+            }
+        }
+    )*}
+}
+
+// These macros determine which types may be used with rwonce, and which helper function should be
+// used if so.
+//
+// Note that `core::mem::transmute` fails the build if the source and target type have different
+// sizes, so picking the wrong helper should lead to a build error.
+
+impl_rw_once_type! {
+    u8,   read_once_1, write_once_1;
+    i8,   read_once_1, write_once_1;
+    u16,  read_once_2, write_once_2;
+    i16,  read_once_2, write_once_2;
+    u32,  read_once_4, write_once_4;
+    i32,  read_once_4, write_once_4;
+    u64,  read_once_8, write_once_8;
+    i64,  read_once_8, write_once_8;
+    *mut T, read_once_ptr, write_once_ptr, <T>;
+    *const T, read_once_ptr, write_once_ptr, <T>;
+}
+
+#[cfg(target_pointer_width = "32")]
+impl_rw_once_type! {
+    usize, read_once_4, write_once_4;
+    isize, read_once_4, write_once_4;
+}
+
+#[cfg(target_pointer_width = "64")]
+impl_rw_once_type! {
+    usize, read_once_8, write_once_8;
+    isize, read_once_8, write_once_8;
+}

-- 
2.52.0.351.gbe84eed79e-goog


