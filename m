Return-Path: <linux-fsdevel+bounces-64587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C697ABED77C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 20:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE9F189F255
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018225A324;
	Sat, 18 Oct 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4E5mcIso"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0217BED0
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810767; cv=none; b=iJjl55b5BvYNeQhNEmlV+2jDg9PNGDpBjWR0/nFANeJTRi4KLhnjGFyiY1HrP+MgnQVxo9lJoO5mnys7CPn0McFE71+pOFCb1DgCQDdFArvNKtYEXiKh7U842KBNV2Jv+4vAKWgDdPUUTDtaaIXd+hT0TZu67isn+8ED5B+Yr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810767; c=relaxed/simple;
	bh=P3uF3l/XnGsWbqVdpQ8R/BGDGmARvshsKgJRpDm9LXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f7uuB2FwwQy0cA0BXGSFs/NsNxXHmsi0y+3j6cXWNZzNlT2y3XhdIiy1mn7z35she3gjbmhn26fhM6I+PR1nqvFQ7eU0q3tZ50sKj0vwiVlqJJHe+uvoI4s+yKseiM4QVjYFAh01wJo6jI+M9q0njngzFjGmLn+TzfhYRMZzP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4E5mcIso; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-426ec5e9278so4363828f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760810763; x=1761415563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIeNY0iNrZAtVGi4QjZXC1U/h9Z3EWzRzEsUz0l7o4Q=;
        b=4E5mcIsodiTuslSFRUZtYQLJD1Z19KIVa4xkmfWUEL1IEyRV4F3gEnyhtp22Vc0tB7
         4aURrfhuobleSVh3k/0Za2H8602FN2hEPEb1uUcAU0xYngjelNbPBbzAtR0YCF1yY0xu
         93NqzzLcykvv3G4Vehry4ge+rIm/99plZd3n/1I8xfgCqpw7KJko+MZ1nWQXA3teJygp
         xY8fw+MssPqLu67BXi0hQV8iIkoyyugSZIRMp9JyxNjIaOltz35KNc08FjAAXZYMNiim
         HxzkvVyL0t4R+gTyvBrDMnc8T13ORymE15xROuJRCbh3a7EenAetLs/Y1p+KLMwvinLR
         /qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760810763; x=1761415563;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mIeNY0iNrZAtVGi4QjZXC1U/h9Z3EWzRzEsUz0l7o4Q=;
        b=h+8t788HUhQLzEMeHQS9aewnUSNFw9BtLpcIpRoUS+p3+NWqgCS5EXYz15bDGv0at3
         OqrO6+QZlaxV/kQuWysU/J7OybaqOcyAcSnMMRnL6kLRY1DBojtNWE7lJKsiKNzq6GIo
         nOqCwLPlZz9PdcvIj2Or63d+p2zMQ8ICOlNJF152jnNRlSzCcJ3YkxJdHLRehMECX7KY
         4q03NERoCIDQ986GWnrUn6mzoYuzAovhtFXJhgLYCSwiVhpftgM2GT5SgvaPYheJYXXV
         3B+8EBFGUMVsttdjQaVe14N21A6CFK423UQ6apuWIpOHU3o2kZBedwMSLyMkNgni7Sa5
         /Qbw==
X-Forwarded-Encrypted: i=1; AJvYcCV0hAifpi87QzPm4SdgWqBA8u8wlgJw377ohAPes9O3bu5woTN5KW2+rXoscjf2jCdQnG7G19KoGZZHKIxV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/iYKKQeWGvgux4BIWr6g7xT5HgUpij4xXBThzdUFD6P+yRqF
	J+txorzppANGKcFmg5f5Jwslm1n3nB9cEBfDCCxsWplpzKOKqXnLJQWrpPi+PhKDd9B6lMbkpB7
	9HMoVGtkL6j+7KZBsxw==
X-Google-Smtp-Source: AGHT+IE86l51ndhUWZTut8S5VUYLmxpG8Q56vJS6EWLJutJ8D7aftyVt8Ersf1ermaztwhw0XE4SaU4Q2OpXWvo=
X-Received: from wmg10.prod.google.com ([2002:a05:600c:22ca:b0:46f:aa50:d717])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310e:b0:471:14f5:1268 with SMTP id 5b1f17b1804b1-47117907a77mr59553635e9.25.1760810763098;
 Sat, 18 Oct 2025 11:06:03 -0700 (PDT)
Date: Sat, 18 Oct 2025 18:05:47 +0000
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251018180552.3616793-1-aliceryhl@google.com>
Subject: [PATCH v18 16/16] rust: replace `CStr` with `core::ffi::CStr`
From: Alice Ryhl <aliceryhl@google.com>
To: tamird@gmail.com
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org, airlied@gmail.com, 
	alex.gaynor@gmail.com, aliceryhl@google.com, arve@android.com, 
	axboe@kernel.dk, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, broonie@kernel.org, 
	cmllamas@google.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
	gary@garyguo.net, gregkh@linuxfoundation.org, jack@suse.cz, 
	joelagnelf@nvidia.com, justinstitt@google.com, kwilczynski@kernel.org, 
	leitao@debian.org, lgirdwood@gmail.com, linux-block@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, llvm@lists.linux.dev, longman@redhat.com, 
	lorenzo.stoakes@oracle.com, lossin@kernel.org, maco@android.com, 
	mcgrof@kernel.org, mingo@redhat.com, mmaurer@google.com, morbo@google.com, 
	mturquette@baylibre.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	nm@ti.com, ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, 
	russ.weight@linux.dev, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	simona@ffwll.ch, surenb@google.com, tkjos@android.com, tmgross@umich.edu, 
	urezki@gmail.com, vbabka@suse.cz, vireshk@kernel.org, viro@zeniv.linux.org.uk, 
	will@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Tamir Duberstein <tamird@gmail.com>

`kernel::ffi::CStr` was introduced in commit d126d2380131 ("rust: str:
add `CStr` type") in November 2022 as an upstreaming of earlier work
that was done in May 2021[0]. That earlier work, having predated the
inclusion of `CStr` in `core`, largely duplicated the implementation of
`std::ffi::CStr`.

`std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64 in
September 2022. Hence replace `kernel::str::CStr` with `core::ffi::CStr`
to reduce our custom code footprint, and retain needed custom
functionality through an extension trait.

Add `CStr` to `ffi` and the kernel prelude.

Link: https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f8e43=
f1d8d5c0860d98a23f [0]
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/stats.rs |   2 +-
 rust/ffi.rs                     |   2 +
 rust/kernel/debugfs/entry.rs    |   2 +-
 rust/kernel/device.rs           |   1 +
 rust/kernel/drm/ioctl.rs        |   4 +-
 rust/kernel/error.rs            |   2 +
 rust/kernel/firmware.rs         |   9 +-
 rust/kernel/prelude.rs          |   4 +-
 rust/kernel/seq_file.rs         |   2 +-
 rust/kernel/str.rs              | 395 ++++++++------------------------
 rust/kernel/sync/condvar.rs     |   2 +-
 rust/kernel/sync/lock.rs        |   2 +-
 rust/kernel/sync/lock/global.rs |   2 +-
 13 files changed, 114 insertions(+), 315 deletions(-)

diff --git a/drivers/android/binder/stats.rs b/drivers/android/binder/stats=
.rs
index 10c43679d5c3..037002651941 100644
--- a/drivers/android/binder/stats.rs
+++ b/drivers/android/binder/stats.rs
@@ -61,7 +61,7 @@ pub(crate) fn debug_print(&self, prefix: &str, m: &SeqFil=
e) {
=20
 mod strings {
     use core::str::from_utf8_unchecked;
-    use kernel::str::CStr;
+    use kernel::str::{CStr, CStrExt as _};
=20
     extern "C" {
         static binder_command_strings: [*const u8; super::BC_COUNT];
diff --git a/rust/ffi.rs b/rust/ffi.rs
index d60aad792af4..f961e9728f59 100644
--- a/rust/ffi.rs
+++ b/rust/ffi.rs
@@ -46,3 +46,5 @@ macro_rules! alias {
 }
=20
 pub use core::ffi::c_void;
+
+pub use core::ffi::CStr;
diff --git a/rust/kernel/debugfs/entry.rs b/rust/kernel/debugfs/entry.rs
index f99402cd3ba0..706cb7f73d6c 100644
--- a/rust/kernel/debugfs/entry.rs
+++ b/rust/kernel/debugfs/entry.rs
@@ -3,7 +3,7 @@
=20
 use crate::debugfs::file_ops::FileOps;
 use crate::ffi::c_void;
-use crate::str::CStr;
+use crate::str::{CStr, CStrExt as _};
 use crate::sync::Arc;
 use core::marker::PhantomData;
=20
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 1321e6f0b53c..0b13aa60b685 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -13,6 +13,7 @@
=20
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
+use crate::str::CStrExt as _;
=20
 pub mod property;
=20
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 69efbdb4c85a..cf328101dde4 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -156,7 +156,9 @@ macro_rules! declare_drm_ioctls {
                         Some($cmd)
                     },
                     flags: $flags,
-                    name: $crate::c_str!(::core::stringify!($cmd)).as_char=
_ptr(),
+                    name: $crate::str::as_char_ptr_in_const_context(
+                        $crate::c_str!(::core::stringify!($cmd)),
+                    ),
                 }
             ),*];
             ioctls
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 1c0e0e241daa..258b12afdcba 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -182,6 +182,8 @@ pub fn name(&self) -> Option<&'static CStr> {
         if ptr.is_null() {
             None
         } else {
+            use crate::str::CStrExt as _;
+
             // SAFETY: The string returned by `errname` is static and `NUL=
`-terminated.
             Some(unsafe { CStr::from_char_ptr(ptr) })
         }
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 94e6bb88b903..376e7e77453f 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -4,7 +4,14 @@
 //!
 //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.=
h)
=20
-use crate::{bindings, device::Device, error::Error, error::Result, ffi, st=
r::CStr};
+use crate::{
+    bindings,
+    device::Device,
+    error::Error,
+    error::Result,
+    ffi,
+    str::{CStr, CStrExt as _},
+};
 use core::ptr::NonNull;
=20
 /// # Invariants
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 26424ad7e989..33fa8404c5c6 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -19,7 +19,7 @@
=20
 pub use ::ffi::{
     c_char, c_int, c_long, c_longlong, c_schar, c_short, c_uchar, c_uint, =
c_ulong, c_ulonglong,
-    c_ushort, c_void,
+    c_ushort, c_void, CStr,
 };
=20
 pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec=
, Vec};
@@ -43,7 +43,7 @@
=20
 pub use super::error::{code::*, Error, Result};
=20
-pub use super::{str::CStr, ThisModule};
+pub use super::{str::CStrExt as _, ThisModule};
=20
 pub use super::init::InPlaceInit;
=20
diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 59fbfc2473f8..855e533813a6 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.=
h)
=20
-use crate::{bindings, c_str, fmt, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSafe,=
 types::Opaque};
=20
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 5c74e5f77601..da539e1f29d4 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -10,9 +10,11 @@
 };
 use core::{
     marker::PhantomData,
-    ops::{self, Deref, DerefMut, Index},
+    ops::{Deref, DerefMut, Index},
 };
=20
+pub use crate::prelude::CStr;
+
 /// Byte string without UTF-8 validity guarantee.
 #[repr(transparent)]
 pub struct BStr([u8]);
@@ -186,58 +188,17 @@ macro_rules! b_str {
 // - error[E0379]: functions in trait impls cannot be declared const
 #[inline]
 pub const fn as_char_ptr_in_const_context(c_str: &CStr) -> *const c_char {
-    c_str.0.as_ptr()
+    c_str.as_ptr().cast()
 }
=20
-/// Possible errors when using conversion functions in [`CStr`].
-#[derive(Debug, Clone, Copy)]
-pub enum CStrConvertError {
-    /// Supplied bytes contain an interior `NUL`.
-    InteriorNul,
-
-    /// Supplied bytes are not terminated by `NUL`.
-    NotNulTerminated,
-}
+mod private {
+    pub trait Sealed {}
=20
-impl From<CStrConvertError> for Error {
-    #[inline]
-    fn from(_: CStrConvertError) -> Error {
-        EINVAL
-    }
+    impl Sealed for super::CStr {}
 }
=20
-/// A string that is guaranteed to have exactly one `NUL` byte, which is a=
t the
-/// end.
-///
-/// Used for interoperability with kernel APIs that take C strings.
-#[repr(transparent)]
-pub struct CStr([u8]);
-
-impl CStr {
-    /// Returns the length of this string excluding `NUL`.
-    #[inline]
-    pub const fn len(&self) -> usize {
-        self.len_with_nul() - 1
-    }
-
-    /// Returns the length of this string with `NUL`.
-    #[inline]
-    pub const fn len_with_nul(&self) -> usize {
-        if self.0.is_empty() {
-            // SAFETY: This is one of the invariant of `CStr`.
-            // We add a `unreachable_unchecked` here to hint the optimizer=
 that
-            // the value returned from this function is non-zero.
-            unsafe { core::hint::unreachable_unchecked() };
-        }
-        self.0.len()
-    }
-
-    /// Returns `true` if the string only includes `NUL`.
-    #[inline]
-    pub const fn is_empty(&self) -> bool {
-        self.len() =3D=3D 0
-    }
-
+/// Extensions to [`CStr`].
+pub trait CStrExt: private::Sealed {
     /// Wraps a raw C string pointer.
     ///
     /// # Safety
@@ -245,54 +206,9 @@ pub const fn is_empty(&self) -> bool {
     /// `ptr` must be a valid pointer to a `NUL`-terminated C string, and =
it must
     /// last at least `'a`. When `CStr` is alive, the memory pointed by `p=
tr`
     /// must not be mutated.
-    #[inline]
-    pub unsafe fn from_char_ptr<'a>(ptr: *const c_char) -> &'a Self {
-        // SAFETY: The safety precondition guarantees `ptr` is a valid poi=
nter
-        // to a `NUL`-terminated C string.
-        let len =3D unsafe { bindings::strlen(ptr) } + 1;
-        // SAFETY: Lifetime guaranteed by the safety precondition.
-        let bytes =3D unsafe { core::slice::from_raw_parts(ptr.cast(), len=
) };
-        // SAFETY: As `len` is returned by `strlen`, `bytes` does not cont=
ain interior `NUL`.
-        // As we have added 1 to `len`, the last byte is known to be `NUL`=
.
-        unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
-    }
-
-    /// Creates a [`CStr`] from a `[u8]`.
-    ///
-    /// The provided slice must be `NUL`-terminated, does not contain any
-    /// interior `NUL` bytes.
-    pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrCo=
nvertError> {
-        if bytes.is_empty() {
-            return Err(CStrConvertError::NotNulTerminated);
-        }
-        if bytes[bytes.len() - 1] !=3D 0 {
-            return Err(CStrConvertError::NotNulTerminated);
-        }
-        let mut i =3D 0;
-        // `i + 1 < bytes.len()` allows LLVM to optimize away bounds check=
ing,
-        // while it couldn't optimize away bounds checks for `i < bytes.le=
n() - 1`.
-        while i + 1 < bytes.len() {
-            if bytes[i] =3D=3D 0 {
-                return Err(CStrConvertError::InteriorNul);
-            }
-            i +=3D 1;
-        }
-        // SAFETY: We just checked that all properties hold.
-        Ok(unsafe { Self::from_bytes_with_nul_unchecked(bytes) })
-    }
-
-    /// Creates a [`CStr`] from a `[u8]` without performing any additional
-    /// checks.
-    ///
-    /// # Safety
-    ///
-    /// `bytes` *must* end with a `NUL` byte, and should only have a singl=
e
-    /// `NUL` byte (or the string will be truncated).
-    #[inline]
-    pub const unsafe fn from_bytes_with_nul_unchecked(bytes: &[u8]) -> &CS=
tr {
-        // SAFETY: Properties of `bytes` guaranteed by the safety precondi=
tion.
-        unsafe { core::mem::transmute(bytes) }
-    }
+    // This function exists to paper over the fact that `CStr::from_ptr` t=
akes a `*const
+    // core::ffi::c_char` rather than a `*const crate::ffi::c_char`.
+    unsafe fn from_char_ptr<'a>(ptr: *const c_char) -> &'a Self;
=20
     /// Creates a mutable [`CStr`] from a `[u8]` without performing any
     /// additional checks.
@@ -301,99 +217,16 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Res=
ult<&Self, CStrConvertError
     ///
     /// `bytes` *must* end with a `NUL` byte, and should only have a singl=
e
     /// `NUL` byte (or the string will be truncated).
-    #[inline]
-    pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &=
mut CStr {
-        // SAFETY: Properties of `bytes` guaranteed by the safety precondi=
tion.
-        unsafe { &mut *(core::ptr::from_mut(bytes) as *mut CStr) }
-    }
+    unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut =
Self;
=20
     /// Returns a C pointer to the string.
-    ///
-    /// Using this function in a const context is deprecated in favor of
-    /// [`as_char_ptr_in_const_context`] in preparation for replacing `CSt=
r` with `core::ffi::CStr`
-    /// which does not have this method.
-    #[inline]
-    pub const fn as_char_ptr(&self) -> *const c_char {
-        as_char_ptr_in_const_context(self)
-    }
-
-    /// Convert the string to a byte slice without the trailing `NUL` byte=
.
-    #[inline]
-    pub fn to_bytes(&self) -> &[u8] {
-        &self.0[..self.len()]
-    }
-
-    /// Convert the string to a byte slice without the trailing `NUL` byte=
.
-    ///
-    /// This function is deprecated in favor of [`Self::to_bytes`] in prep=
aration for replacing
-    /// `CStr` with `core::ffi::CStr` which does not have this method.
-    #[inline]
-    pub fn as_bytes(&self) -> &[u8] {
-        self.to_bytes()
-    }
-
-    /// Convert the string to a byte slice containing the trailing `NUL` b=
yte.
-    #[inline]
-    pub const fn to_bytes_with_nul(&self) -> &[u8] {
-        &self.0
-    }
-
-    /// Convert the string to a byte slice containing the trailing `NUL` b=
yte.
-    ///
-    /// This function is deprecated in favor of [`Self::to_bytes_with_nul`=
] in preparation for
-    /// replacing `CStr` with `core::ffi::CStr` which does not have this m=
ethod.
-    #[inline]
-    pub const fn as_bytes_with_nul(&self) -> &[u8] {
-        self.to_bytes_with_nul()
-    }
-
-    /// Yields a [`&str`] slice if the [`CStr`] contains valid UTF-8.
-    ///
-    /// If the contents of the [`CStr`] are valid UTF-8 data, this
-    /// function will return the corresponding [`&str`] slice. Otherwise,
-    /// it will return an error with details of where UTF-8 validation fai=
led.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// # use kernel::str::CStr;
-    /// let cstr =3D CStr::from_bytes_with_nul(b"foo\0")?;
-    /// assert_eq!(cstr.to_str(), Ok("foo"));
-    /// # Ok::<(), kernel::error::Error>(())
-    /// ```
-    #[inline]
-    pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
-        core::str::from_utf8(self.as_bytes())
-    }
-
-    /// Unsafely convert this [`CStr`] into a [`&str`], without checking f=
or
-    /// valid UTF-8.
-    ///
-    /// # Safety
-    ///
-    /// The contents must be valid UTF-8.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// # use kernel::c_str;
-    /// # use kernel::str::CStr;
-    /// let bar =3D c_str!("=E3=83=84");
-    /// // SAFETY: String literals are guaranteed to be valid UTF-8
-    /// // by the Rust compiler.
-    /// assert_eq!(unsafe { bar.as_str_unchecked() }, "=E3=83=84");
-    /// ```
-    #[inline]
-    pub unsafe fn as_str_unchecked(&self) -> &str {
-        // SAFETY: TODO.
-        unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
-    }
+    // This function exists to paper over the fact that `CStr::as_ptr` ret=
urns a `*const
+    // core::ffi::c_char` rather than a `*const crate::ffi::c_char`.
+    fn as_char_ptr(&self) -> *const c_char;
=20
     /// Convert this [`CStr`] into a [`CString`] by allocating memory and
     /// copying over the string data.
-    pub fn to_cstring(&self) -> Result<CString, AllocError> {
-        CString::try_from(self)
-    }
+    fn to_cstring(&self) -> Result<CString, AllocError>;
=20
     /// Converts this [`CStr`] to its ASCII lower case equivalent in-place=
.
     ///
@@ -404,11 +237,7 @@ pub fn to_cstring(&self) -> Result<CString, AllocError=
> {
     /// [`to_ascii_lowercase()`].
     ///
     /// [`to_ascii_lowercase()`]: #method.to_ascii_lowercase
-    pub fn make_ascii_lowercase(&mut self) {
-        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
-        // string.
-        self.0.make_ascii_lowercase();
-    }
+    fn make_ascii_lowercase(&mut self);
=20
     /// Converts this [`CStr`] to its ASCII upper case equivalent in-place=
.
     ///
@@ -419,11 +248,7 @@ pub fn make_ascii_lowercase(&mut self) {
     /// [`to_ascii_uppercase()`].
     ///
     /// [`to_ascii_uppercase()`]: #method.to_ascii_uppercase
-    pub fn make_ascii_uppercase(&mut self) {
-        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
-        // string.
-        self.0.make_ascii_uppercase();
-    }
+    fn make_ascii_uppercase(&mut self);
=20
     /// Returns a copy of this [`CString`] where each character is mapped =
to its
     /// ASCII lower case equivalent.
@@ -434,13 +259,7 @@ pub fn make_ascii_uppercase(&mut self) {
     /// To lowercase the value in-place, use [`make_ascii_lowercase`].
     ///
     /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
-    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
-        let mut s =3D self.to_cstring()?;
-
-        s.make_ascii_lowercase();
-
-        Ok(s)
-    }
+    fn to_ascii_lowercase(&self) -> Result<CString, AllocError>;
=20
     /// Returns a copy of this [`CString`] where each character is mapped =
to its
     /// ASCII upper case equivalent.
@@ -451,13 +270,7 @@ pub fn to_ascii_lowercase(&self) -> Result<CString, Al=
locError> {
     /// To uppercase the value in-place, use [`make_ascii_uppercase`].
     ///
     /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
-    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
-        let mut s =3D self.to_cstring()?;
-
-        s.make_ascii_uppercase();
-
-        Ok(s)
-    }
+    fn to_ascii_uppercase(&self) -> Result<CString, AllocError>;
 }
=20
 impl fmt::Display for CStr {
@@ -490,98 +303,75 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Res=
ult {
     }
 }
=20
-impl fmt::Debug for CStr {
-    /// Formats printable ASCII characters with a double quote on either e=
nd, escaping the rest.
-    ///
-    /// ```
-    /// # use kernel::c_str;
-    /// # use kernel::prelude::fmt;
-    /// # use kernel::str::CStr;
-    /// # use kernel::str::CString;
-    /// let penguin =3D c_str!("=F0=9F=90=A7");
-    /// let s =3D CString::try_from_fmt(fmt!("{penguin:?}"))?;
-    /// assert_eq!(s.as_bytes_with_nul(), "\"\\xf0\\x9f\\x90\\xa7\"\0".as_=
bytes());
-    ///
-    /// // Embedded double quotes are escaped.
-    /// let ascii =3D c_str!("so \"cool\"");
-    /// let s =3D CString::try_from_fmt(fmt!("{ascii:?}"))?;
-    /// assert_eq!(s.as_bytes_with_nul(), "\"so \\\"cool\\\"\"\0".as_bytes=
());
-    /// # Ok::<(), kernel::error::Error>(())
-    /// ```
-    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        f.write_str("\"")?;
-        for &c in self.as_bytes() {
-            match c {
-                // Printable characters.
-                b'\"' =3D> f.write_str("\\\"")?,
-                0x20..=3D0x7e =3D> f.write_char(c as char)?,
-                _ =3D> write!(f, "\\x{c:02x}")?,
-            }
-        }
-        f.write_str("\"")
-    }
+/// Converts a mutable C string to a mutable byte slice.
+///
+/// # Safety
+///
+/// The caller must ensure that the slice ends in a NUL byte and contains =
no other NUL bytes before
+/// the borrow ends and the underlying [`CStr`] is used.
+unsafe fn to_bytes_mut(s: &mut CStr) -> &mut [u8] {
+    // SAFETY: the cast from `&CStr` to `&[u8]` is safe since `CStr` has t=
he same layout as `&[u8]`
+    // (this is technically not guaranteed, but we rely on it here). The p=
ointer dereference is
+    // safe since it comes from a mutable reference which is guaranteed to=
 be valid for writes.
+    unsafe { &mut *(core::ptr::from_mut(s) as *mut [u8]) }
 }
=20
-impl AsRef<BStr> for CStr {
+impl CStrExt for CStr {
     #[inline]
-    fn as_ref(&self) -> &BStr {
-        BStr::from_bytes(self.as_bytes())
+    unsafe fn from_char_ptr<'a>(ptr: *const c_char) -> &'a Self {
+        // SAFETY: The safety preconditions are the same as for `CStr::fro=
m_ptr`.
+        unsafe { CStr::from_ptr(ptr.cast()) }
     }
-}
=20
-impl Deref for CStr {
-    type Target =3D BStr;
+    #[inline]
+    unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut =
Self {
+        // SAFETY: the cast from `&[u8]` to `&CStr` is safe since the prop=
erties of `bytes` are
+        // guaranteed by the safety precondition and `CStr` has the same l=
ayout as `&[u8]` (this is
+        // technically not guaranteed, but we rely on it here). The pointe=
r dereference is safe
+        // since it comes from a mutable reference which is guaranteed to =
be valid for writes.
+        unsafe { &mut *(core::ptr::from_mut(bytes) as *mut CStr) }
+    }
=20
     #[inline]
-    fn deref(&self) -> &Self::Target {
-        self.as_ref()
+    fn as_char_ptr(&self) -> *const c_char {
+        self.as_ptr().cast()
+    }
+
+    fn to_cstring(&self) -> Result<CString, AllocError> {
+        CString::try_from(self)
     }
-}
=20
-impl Index<ops::RangeFrom<usize>> for CStr {
-    type Output =3D CStr;
+    fn make_ascii_lowercase(&mut self) {
+        // SAFETY: This doesn't introduce or remove NUL bytes in the C str=
ing.
+        unsafe { to_bytes_mut(self) }.make_ascii_lowercase();
+    }
=20
-    #[inline]
-    fn index(&self, index: ops::RangeFrom<usize>) -> &Self::Output {
-        // Delegate bounds checking to slice.
-        // Assign to _ to mute clippy's unnecessary operation warning.
-        let _ =3D &self.as_bytes()[index.start..];
-        // SAFETY: We just checked the bounds.
-        unsafe { Self::from_bytes_with_nul_unchecked(&self.0[index.start..=
]) }
+    fn make_ascii_uppercase(&mut self) {
+        // SAFETY: This doesn't introduce or remove NUL bytes in the C str=
ing.
+        unsafe { to_bytes_mut(self) }.make_ascii_uppercase();
     }
-}
=20
-impl Index<ops::RangeFull> for CStr {
-    type Output =3D CStr;
+    fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
+        let mut s =3D self.to_cstring()?;
=20
-    #[inline]
-    fn index(&self, _index: ops::RangeFull) -> &Self::Output {
-        self
+        s.make_ascii_lowercase();
+
+        Ok(s)
     }
-}
=20
-mod private {
-    use core::ops;
+    fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
+        let mut s =3D self.to_cstring()?;
=20
-    // Marker trait for index types that can be forward to `BStr`.
-    pub trait CStrIndex {}
+        s.make_ascii_uppercase();
=20
-    impl CStrIndex for usize {}
-    impl CStrIndex for ops::Range<usize> {}
-    impl CStrIndex for ops::RangeInclusive<usize> {}
-    impl CStrIndex for ops::RangeToInclusive<usize> {}
+        Ok(s)
+    }
 }
=20
-impl<Idx> Index<Idx> for CStr
-where
-    Idx: private::CStrIndex,
-    BStr: Index<Idx>,
-{
-    type Output =3D <BStr as Index<Idx>>::Output;
-
+impl AsRef<BStr> for CStr {
     #[inline]
-    fn index(&self, index: Idx) -> &Self::Output {
-        &self.as_ref()[index]
+    fn as_ref(&self) -> &BStr {
+        BStr::from_bytes(self.to_bytes())
     }
 }
=20
@@ -612,6 +402,13 @@ macro_rules! c_str {
 mod tests {
     use super::*;
=20
+    impl From<core::ffi::FromBytesWithNulError> for Error {
+        #[inline]
+        fn from(_: core::ffi::FromBytesWithNulError) -> Error {
+            EINVAL
+        }
+    }
+
     macro_rules! format {
         ($($f:tt)*) =3D> ({
             CString::try_from_fmt(fmt!($($f)*))?.to_str()?
@@ -634,40 +431,28 @@ macro_rules! format {
=20
     #[test]
     fn test_cstr_to_str() -> Result {
-        let good_bytes =3D b"\xf0\x9f\xa6\x80\0";
-        let checked_cstr =3D CStr::from_bytes_with_nul(good_bytes)?;
-        let checked_str =3D checked_cstr.to_str()?;
+        let cstr =3D c"\xf0\x9f\xa6\x80";
+        let checked_str =3D cstr.to_str()?;
         assert_eq!(checked_str, "=F0=9F=A6=80");
         Ok(())
     }
=20
     #[test]
     fn test_cstr_to_str_invalid_utf8() -> Result {
-        let bad_bytes =3D b"\xc3\x28\0";
-        let checked_cstr =3D CStr::from_bytes_with_nul(bad_bytes)?;
-        assert!(checked_cstr.to_str().is_err());
-        Ok(())
-    }
-
-    #[test]
-    fn test_cstr_as_str_unchecked() -> Result {
-        let good_bytes =3D b"\xf0\x9f\x90\xA7\0";
-        let checked_cstr =3D CStr::from_bytes_with_nul(good_bytes)?;
-        // SAFETY: The contents come from a string literal which contains =
valid UTF-8.
-        let unchecked_str =3D unsafe { checked_cstr.as_str_unchecked() };
-        assert_eq!(unchecked_str, "=F0=9F=90=A7");
+        let cstr =3D c"\xc3\x28";
+        assert!(cstr.to_str().is_err());
         Ok(())
     }
=20
     #[test]
     fn test_cstr_display() -> Result {
-        let hello_world =3D CStr::from_bytes_with_nul(b"hello, world!\0")?=
;
+        let hello_world =3D c"hello, world!";
         assert_eq!(format!("{hello_world}"), "hello, world!");
-        let non_printables =3D CStr::from_bytes_with_nul(b"\x01\x09\x0a\0"=
)?;
+        let non_printables =3D c"\x01\x09\x0a";
         assert_eq!(format!("{non_printables}"), "\\x01\\x09\\x0a");
-        let non_ascii =3D CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?;
+        let non_ascii =3D c"d\xe9j\xe0 vu";
         assert_eq!(format!("{non_ascii}"), "d\\xe9j\\xe0 vu");
-        let good_bytes =3D CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0"=
)?;
+        let good_bytes =3D c"\xf0\x9f\xa6\x80";
         assert_eq!(format!("{good_bytes}"), "\\xf0\\x9f\\xa6\\x80");
         Ok(())
     }
@@ -686,13 +471,13 @@ fn test_cstr_display_all_bytes() -> Result {
=20
     #[test]
     fn test_cstr_debug() -> Result {
-        let hello_world =3D CStr::from_bytes_with_nul(b"hello, world!\0")?=
;
+        let hello_world =3D c"hello, world!";
         assert_eq!(format!("{hello_world:?}"), "\"hello, world!\"");
-        let non_printables =3D CStr::from_bytes_with_nul(b"\x01\x09\x0a\0"=
)?;
-        assert_eq!(format!("{non_printables:?}"), "\"\\x01\\x09\\x0a\"");
-        let non_ascii =3D CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?;
+        let non_printables =3D c"\x01\x09\x0a";
+        assert_eq!(format!("{non_printables:?}"), "\"\\x01\\t\\n\"");
+        let non_ascii =3D c"d\xe9j\xe0 vu";
         assert_eq!(format!("{non_ascii:?}"), "\"d\\xe9j\\xe0 vu\"");
-        let good_bytes =3D CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0"=
)?;
+        let good_bytes =3D c"\xf0\x9f\xa6\x80";
         assert_eq!(format!("{good_bytes:?}"), "\"\\xf0\\x9f\\xa6\\x80\"");
         Ok(())
     }
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index c6ec64295c9f..a24e25a690ee 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -8,7 +8,7 @@
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{
     ffi::{c_int, c_long},
-    str::CStr,
+    str::{CStr, CStrExt as _},
     task::{
         MAX_SCHEDULE_TIMEOUT, TASK_FREEZABLE, TASK_INTERRUPTIBLE, TASK_NOR=
MAL, TASK_UNINTERRUPTIBLE,
     },
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 27202beef90c..5d7991e6d373 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,7 +7,7 @@
=20
 use super::LockClassKey;
 use crate::{
-    str::CStr,
+    str::{CStr, CStrExt as _},
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
 use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global=
.rs
index d65f94b5caf2..79d0ef7fda86 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -5,7 +5,7 @@
 //! Support for defining statics containing locks.
=20
 use crate::{
-    str::CStr,
+    str::{CStr, CStrExt as _},
     sync::lock::{Backend, Guard, Lock},
     sync::{LockClassKey, LockedBy},
     types::Opaque,
--=20
2.51.0.915.g61a8936c21-goog


