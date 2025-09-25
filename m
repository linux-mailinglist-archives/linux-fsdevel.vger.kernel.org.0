Return-Path: <linux-fsdevel+bounces-62739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E80B9FA2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302563B438B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338DE27C842;
	Thu, 25 Sep 2025 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFxCDyNp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC527A931
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807790; cv=none; b=S2KcBWZCdYWnvkoqwRiURzuT/ANf9DPx9LTA0w0oHtZIwkxkz4sjejGpK+B1zijI3ZSt034WztnF7d4Sg4doY3pvlnKOazWLT9Ql1bujI3jUgRagrfiXWsc4N5ZN3bsbyeUlEsYE4mrNCZaQc1uVnj84/aeOKJSvkBOQtpfGCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807790; c=relaxed/simple;
	bh=lo6/DuevQdN2F/RgLUH3cR/iIKA6DNW579sKIqtC5y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evFkNBCQUYpA3gPj5lUuo7HYrFH6KjBT0nK5hPd5yBmywo1yBM2i3b956r549/F29gLypsijZvLz9KUauReHVGWJQMTCDGYigJjNdt1tivLrKMVB0wHogzRLYegSpG5Eq6XdiOGZ67y3preBDPi3b7i9Va0gkL5eXMuxW3FVShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFxCDyNp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-796d68804a0so9901556d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758807787; x=1759412587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDaFXK30eNb3R9D0/XAdGJM4bfjBNOvZs1PzSUs4otw=;
        b=JFxCDyNp+W/hSPgQFlCiLkx5dGEzDLOOWjaTyyZqxRHkY+ok0bNrNxT5+4I9y7GRXE
         zsRuv9ceQ6O0/ZEptIoulOzKDbfE6bdqQp/FqHE5Z5wrjeMy0bpyRPVUPzSuGbSMTv2+
         006DVm3ueoZn4YRzd/wXxjpK8DNhRqG5HtMU/NXvcAh07/FJgKbvrsluIve2zE/BQKaW
         2hLf8rlg+R7xosP8mep1a36lW67hnrpsdYSMivV7mZlKp8fJZlSq78kZPiiT9bv5OvFv
         a3oCYJacErI1grdBEyFqdUaB4UU5nW5Ik6/ZhNQmtEwqpey/fzdsicKwL56DwxB3JQvX
         9w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807787; x=1759412587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDaFXK30eNb3R9D0/XAdGJM4bfjBNOvZs1PzSUs4otw=;
        b=pO/XbL3H1eRhfjpbimMC0iEuPenCVwa9uCTWKoG32HQenLMi3PFyjEbWqFkzFeUDSK
         sXTQ1en38QqyhBY6Zh0DWl/F+sghDqKNGxm6qmgrEXO8jbRyhqFmhiESXfH5AKUm/ZUy
         HlSuu8iFvDcs6wUxJHjlcfhFWWTxK/W31znV86PCvoEML8BHquiM/CqaXqSKBjEKLlT9
         YkS4D/5X8w5ZKJPc0/wZxPb+mWtHfKCngywpT/569XttZScD8m4hJj6uM0DH4mi6V2XA
         T/xp0dc/LJbKl47dOJ5rBs8nJhXnH4aBWZvUy5wZrX/vGirkbmMwJoEnRbhAD32+C6n0
         7GKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHFXBk4viv2FTXG/KObEfHZNSDb74FTrkJD47BTZ8GaLsLdOcrAZNEfNRAC6v6go8Lx+/SFkWVqhvXzmMt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlzo4xFN9UpjvJO/HwvmguTb3ru/f/PeCxWxEk+1f1az40Zlwq
	HUyLPla5BJ5D7onOUiM7UXvdiZ2V6fc1TuFD44ixZC4sLh+6Zlyh1dwy
X-Gm-Gg: ASbGnctKiqdYD3BjgYL3oZbfOvYV279JG73OySr4Q0/NapxPP2AsOzmEgVKcPgNVdxf
	XzaPpwLgmFgHDKkuQW0ApTIMJ9YmtDX8vFsiQqtb4Ch7spfCPGvXS2r+SQdWWtA0tQChXvwICA1
	QqY8WHPkuYgB+VC8bL7n8cLtwGQdvIe5/H+MOET7kqX/OUKuxkD4YzPzlPccXMp6K+MD2QDqmCG
	5D7Ch4Ti2wo6nTeZlN21+iwN2Gtr8fEAZm4AdLTeDBBf8wX5qkSr+nn9smbZ9TTAGvE5gM9nvSL
	hFf2V8YfEhxV03opVw4Mnqd5UFWTts7eqJ0GjDk9jRTAFn9Ib1FllzoSlF2ue6fi4AV6lUrAmBM
	3uZ+92ps8k3uG0MJy7WfJQMBtkXjZTXUKAzUcWtJZIhu/7sifBQ5NKzCH08CdJqfWJi3w5gAL4s
	idTjKT6bZqFmDMqPZRRTcqhlGzjJDq/ghwvVbkrKbzl4mvfcUhin4ecU8cjTxejrjlJz9C+HVGZ
	kwjXxM=
X-Google-Smtp-Source: AGHT+IHrHEMiip8r8Jn2ygvJM3xuhaIvXIwlGj6DZVVT/EeGtX7LRCc1VG0VbLOsSpLMZ3nNfBJkWg==
X-Received: by 2002:ad4:5f07:0:b0:78d:304d:2cd with SMTP id 6a1803df08f44-7fc400b1c21mr48591346d6.49.1758807785366;
        Thu, 25 Sep 2025 06:43:05 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-800fa5f6dd7sm11852546d6.0.2025.09.25.06.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:43:04 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:42:54 -0400
Subject: [PATCH v16 3/3] rust: replace `CStr` with `core::ffi::CStr`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250925-cstr-core-v16-3-5cdcb3470ec2@gmail.com>
References: <20250925-cstr-core-v16-0-5cdcb3470ec2@gmail.com>
In-Reply-To: <20250925-cstr-core-v16-0-5cdcb3470ec2@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758807776; l=25735;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=lo6/DuevQdN2F/RgLUH3cR/iIKA6DNW579sKIqtC5y0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGOSVgbfQFgBBK1sTKXw49unThqPQREAQTbAwpwCMInDQ5kk/6iWOOdUZq57ZhyITIc8O/CMyTJ
 +lx4GYTjkJAE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

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

Link: https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f8e43f1d8d5c0860d98a23f [0]
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/ffi.rs                     |   2 +
 rust/kernel/device.rs           |   1 +
 rust/kernel/error.rs            |   2 +
 rust/kernel/firmware.rs         |   9 +-
 rust/kernel/prelude.rs          |   4 +-
 rust/kernel/seq_file.rs         |   2 +-
 rust/kernel/str.rs              | 395 +++++++++-------------------------------
 rust/kernel/sync/condvar.rs     |   2 +-
 rust/kernel/sync/lock.rs        |   2 +-
 rust/kernel/sync/lock/global.rs |   2 +-
 10 files changed, 109 insertions(+), 312 deletions(-)

diff --git a/rust/ffi.rs b/rust/ffi.rs
index d60aad792af4..f961e9728f59 100644
--- a/rust/ffi.rs
+++ b/rust/ffi.rs
@@ -46,3 +46,5 @@ macro_rules! alias {
 }
 
 pub use core::ffi::c_void;
+
+pub use core::ffi::CStr;
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 303af0ef9bf7..f3718da11871 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -12,6 +12,7 @@
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
+use crate::str::CStrExt as _;
 
 pub mod property;
 
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
             // SAFETY: The string returned by `errname` is static and `NUL`-terminated.
             Some(unsafe { CStr::from_char_ptr(ptr) })
         }
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 94e6bb88b903..376e7e77453f 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -4,7 +4,14 @@
 //!
 //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
 
-use crate::{bindings, device::Device, error::Error, error::Result, ffi, str::CStr};
+use crate::{
+    bindings,
+    device::Device,
+    error::Error,
+    error::Result,
+    ffi,
+    str::{CStr, CStrExt as _},
+};
 use core::ptr::NonNull;
 
 /// # Invariants
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 26424ad7e989..33fa8404c5c6 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -19,7 +19,7 @@
 
 pub use ::ffi::{
     c_char, c_int, c_long, c_longlong, c_schar, c_short, c_uchar, c_uint, c_ulong, c_ulonglong,
-    c_ushort, c_void,
+    c_ushort, c_void, CStr,
 };
 
 pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
@@ -43,7 +43,7 @@
 
 pub use super::error::{code::*, Error, Result};
 
-pub use super::{str::CStr, ThisModule};
+pub use super::{str::CStrExt as _, ThisModule};
 
 pub use super::init::InPlaceInit;
 
diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 59fbfc2473f8..855e533813a6 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, fmt, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 6c892550c0ba..624386cb07be 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,10 +4,12 @@
 
 use crate::alloc::{flags::*, AllocError, KVec};
 use crate::fmt::{self, Write};
-use core::ops::{self, Deref, DerefMut, Index};
+use core::ops::{Deref, DerefMut, Index};
 
 use crate::prelude::*;
 
+pub use crate::prelude::CStr;
+
 /// Byte string without UTF-8 validity guarantee.
 #[repr(transparent)]
 pub struct BStr([u8]);
@@ -181,58 +183,17 @@ macro_rules! b_str {
 // - error[E0379]: functions in trait impls cannot be declared const
 #[inline]
 pub const fn as_char_ptr_in_const_context(c_str: &CStr) -> *const c_char {
-    c_str.0.as_ptr()
+    c_str.as_ptr().cast()
 }
 
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
 
-impl From<CStrConvertError> for Error {
-    #[inline]
-    fn from(_: CStrConvertError) -> Error {
-        EINVAL
-    }
+    impl Sealed for super::CStr {}
 }
 
-/// A string that is guaranteed to have exactly one `NUL` byte, which is at the
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
-            // We add a `unreachable_unchecked` here to hint the optimizer that
-            // the value returned from this function is non-zero.
-            unsafe { core::hint::unreachable_unchecked() };
-        }
-        self.0.len()
-    }
-
-    /// Returns `true` if the string only includes `NUL`.
-    #[inline]
-    pub const fn is_empty(&self) -> bool {
-        self.len() == 0
-    }
-
+/// Extensions to [`CStr`].
+pub trait CStrExt: private::Sealed {
     /// Wraps a raw C string pointer.
     ///
     /// # Safety
@@ -240,54 +201,9 @@ pub const fn is_empty(&self) -> bool {
     /// `ptr` must be a valid pointer to a `NUL`-terminated C string, and it must
     /// last at least `'a`. When `CStr` is alive, the memory pointed by `ptr`
     /// must not be mutated.
-    #[inline]
-    pub unsafe fn from_char_ptr<'a>(ptr: *const c_char) -> &'a Self {
-        // SAFETY: The safety precondition guarantees `ptr` is a valid pointer
-        // to a `NUL`-terminated C string.
-        let len = unsafe { bindings::strlen(ptr) } + 1;
-        // SAFETY: Lifetime guaranteed by the safety precondition.
-        let bytes = unsafe { core::slice::from_raw_parts(ptr.cast(), len) };
-        // SAFETY: As `len` is returned by `strlen`, `bytes` does not contain interior `NUL`.
-        // As we have added 1 to `len`, the last byte is known to be `NUL`.
-        unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
-    }
-
-    /// Creates a [`CStr`] from a `[u8]`.
-    ///
-    /// The provided slice must be `NUL`-terminated, does not contain any
-    /// interior `NUL` bytes.
-    pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError> {
-        if bytes.is_empty() {
-            return Err(CStrConvertError::NotNulTerminated);
-        }
-        if bytes[bytes.len() - 1] != 0 {
-            return Err(CStrConvertError::NotNulTerminated);
-        }
-        let mut i = 0;
-        // `i + 1 < bytes.len()` allows LLVM to optimize away bounds checking,
-        // while it couldn't optimize away bounds checks for `i < bytes.len() - 1`.
-        while i + 1 < bytes.len() {
-            if bytes[i] == 0 {
-                return Err(CStrConvertError::InteriorNul);
-            }
-            i += 1;
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
-    /// `bytes` *must* end with a `NUL` byte, and should only have a single
-    /// `NUL` byte (or the string will be truncated).
-    #[inline]
-    pub const unsafe fn from_bytes_with_nul_unchecked(bytes: &[u8]) -> &CStr {
-        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
-        unsafe { core::mem::transmute(bytes) }
-    }
+    // This function exists to paper over the fact that `CStr::from_ptr` takes a `*const
+    // core::ffi::c_char` rather than a `*const crate::ffi::c_char`.
+    unsafe fn from_char_ptr<'a>(ptr: *const c_char) -> &'a Self;
 
     /// Creates a mutable [`CStr`] from a `[u8]` without performing any
     /// additional checks.
@@ -296,99 +212,16 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
     ///
     /// `bytes` *must* end with a `NUL` byte, and should only have a single
     /// `NUL` byte (or the string will be truncated).
-    #[inline]
-    pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
-        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
-        unsafe { &mut *(core::ptr::from_mut(bytes) as *mut CStr) }
-    }
+    unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut Self;
 
     /// Returns a C pointer to the string.
-    ///
-    /// Using this function in a const context is deprecated in favor of
-    /// [`as_char_ptr_in_const_context`] in preparation for replacing `CStr` with `core::ffi::CStr`
-    /// which does not have this method.
-    #[inline]
-    pub const fn as_char_ptr(&self) -> *const c_char {
-        as_char_ptr_in_const_context(self)
-    }
-
-    /// Convert the string to a byte slice without the trailing `NUL` byte.
-    #[inline]
-    pub fn to_bytes(&self) -> &[u8] {
-        &self.0[..self.len()]
-    }
-
-    /// Convert the string to a byte slice without the trailing `NUL` byte.
-    ///
-    /// This function is deprecated in favor of [`Self::to_bytes`] in preparation for replacing
-    /// `CStr` with `core::ffi::CStr` which does not have this method.
-    #[inline]
-    pub fn as_bytes(&self) -> &[u8] {
-        self.to_bytes()
-    }
-
-    /// Convert the string to a byte slice containing the trailing `NUL` byte.
-    #[inline]
-    pub const fn to_bytes_with_nul(&self) -> &[u8] {
-        &self.0
-    }
-
-    /// Convert the string to a byte slice containing the trailing `NUL` byte.
-    ///
-    /// This function is deprecated in favor of [`Self::to_bytes_with_nul`] in preparation for
-    /// replacing `CStr` with `core::ffi::CStr` which does not have this method.
-    #[inline]
-    pub const fn as_bytes_with_nul(&self) -> &[u8] {
-        self.to_bytes_with_nul()
-    }
-
-    /// Yields a [`&str`] slice if the [`CStr`] contains valid UTF-8.
-    ///
-    /// If the contents of the [`CStr`] are valid UTF-8 data, this
-    /// function will return the corresponding [`&str`] slice. Otherwise,
-    /// it will return an error with details of where UTF-8 validation failed.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// # use kernel::str::CStr;
-    /// let cstr = CStr::from_bytes_with_nul(b"foo\0")?;
-    /// assert_eq!(cstr.to_str(), Ok("foo"));
-    /// # Ok::<(), kernel::error::Error>(())
-    /// ```
-    #[inline]
-    pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
-        core::str::from_utf8(self.as_bytes())
-    }
-
-    /// Unsafely convert this [`CStr`] into a [`&str`], without checking for
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
-    /// let bar = c_str!("ツ");
-    /// // SAFETY: String literals are guaranteed to be valid UTF-8
-    /// // by the Rust compiler.
-    /// assert_eq!(unsafe { bar.as_str_unchecked() }, "ツ");
-    /// ```
-    #[inline]
-    pub unsafe fn as_str_unchecked(&self) -> &str {
-        // SAFETY: TODO.
-        unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
-    }
+    // This function exists to paper over the fact that `CStr::as_ptr` returns a `*const
+    // core::ffi::c_char` rather than a `*const crate::ffi::c_char`.
+    fn as_char_ptr(&self) -> *const c_char;
 
     /// Convert this [`CStr`] into a [`CString`] by allocating memory and
     /// copying over the string data.
-    pub fn to_cstring(&self) -> Result<CString, AllocError> {
-        CString::try_from(self)
-    }
+    fn to_cstring(&self) -> Result<CString, AllocError>;
 
     /// Converts this [`CStr`] to its ASCII lower case equivalent in-place.
     ///
@@ -399,11 +232,7 @@ pub fn to_cstring(&self) -> Result<CString, AllocError> {
     /// [`to_ascii_lowercase()`].
     ///
     /// [`to_ascii_lowercase()`]: #method.to_ascii_lowercase
-    pub fn make_ascii_lowercase(&mut self) {
-        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
-        // string.
-        self.0.make_ascii_lowercase();
-    }
+    fn make_ascii_lowercase(&mut self);
 
     /// Converts this [`CStr`] to its ASCII upper case equivalent in-place.
     ///
@@ -414,11 +243,7 @@ pub fn make_ascii_lowercase(&mut self) {
     /// [`to_ascii_uppercase()`].
     ///
     /// [`to_ascii_uppercase()`]: #method.to_ascii_uppercase
-    pub fn make_ascii_uppercase(&mut self) {
-        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
-        // string.
-        self.0.make_ascii_uppercase();
-    }
+    fn make_ascii_uppercase(&mut self);
 
     /// Returns a copy of this [`CString`] where each character is mapped to its
     /// ASCII lower case equivalent.
@@ -429,13 +254,7 @@ pub fn make_ascii_uppercase(&mut self) {
     /// To lowercase the value in-place, use [`make_ascii_lowercase`].
     ///
     /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
-    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
-        let mut s = self.to_cstring()?;
-
-        s.make_ascii_lowercase();
-
-        Ok(s)
-    }
+    fn to_ascii_lowercase(&self) -> Result<CString, AllocError>;
 
     /// Returns a copy of this [`CString`] where each character is mapped to its
     /// ASCII upper case equivalent.
@@ -446,13 +265,7 @@ pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
     /// To uppercase the value in-place, use [`make_ascii_uppercase`].
     ///
     /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
-    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
-        let mut s = self.to_cstring()?;
-
-        s.make_ascii_uppercase();
-
-        Ok(s)
-    }
+    fn to_ascii_uppercase(&self) -> Result<CString, AllocError>;
 }
 
 impl fmt::Display for CStr {
@@ -485,98 +298,75 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-impl fmt::Debug for CStr {
-    /// Formats printable ASCII characters with a double quote on either end, escaping the rest.
-    ///
-    /// ```
-    /// # use kernel::c_str;
-    /// # use kernel::prelude::fmt;
-    /// # use kernel::str::CStr;
-    /// # use kernel::str::CString;
-    /// let penguin = c_str!("🐧");
-    /// let s = CString::try_from_fmt(fmt!("{penguin:?}"))?;
-    /// assert_eq!(s.as_bytes_with_nul(), "\"\\xf0\\x9f\\x90\\xa7\"\0".as_bytes());
-    ///
-    /// // Embedded double quotes are escaped.
-    /// let ascii = c_str!("so \"cool\"");
-    /// let s = CString::try_from_fmt(fmt!("{ascii:?}"))?;
-    /// assert_eq!(s.as_bytes_with_nul(), "\"so \\\"cool\\\"\"\0".as_bytes());
-    /// # Ok::<(), kernel::error::Error>(())
-    /// ```
-    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        f.write_str("\"")?;
-        for &c in self.as_bytes() {
-            match c {
-                // Printable characters.
-                b'\"' => f.write_str("\\\"")?,
-                0x20..=0x7e => f.write_char(c as char)?,
-                _ => write!(f, "\\x{c:02x}")?,
-            }
-        }
-        f.write_str("\"")
-    }
+/// Converts a mutable C string to a mutable byte slice.
+///
+/// # Safety
+///
+/// The caller must ensure that the slice ends in a NUL byte and contains no other NUL bytes before
+/// the borrow ends and the underlying [`CStr`] is used.
+unsafe fn to_bytes_mut(s: &mut CStr) -> &mut [u8] {
+    // SAFETY: the cast from `&CStr` to `&[u8]` is safe since `CStr` has the same layout as `&[u8]`
+    // (this is technically not guaranteed, but we rely on it here). The pointer dereference is
+    // safe since it comes from a mutable reference which is guaranteed to be valid for writes.
+    unsafe { &mut *(core::ptr::from_mut(s) as *mut [u8]) }
 }
 
-impl AsRef<BStr> for CStr {
+impl CStrExt for CStr {
     #[inline]
-    fn as_ref(&self) -> &BStr {
-        BStr::from_bytes(self.as_bytes())
+    unsafe fn from_char_ptr<'a>(ptr: *const c_char) -> &'a Self {
+        // SAFETY: The safety preconditions are the same as for `CStr::from_ptr`.
+        unsafe { CStr::from_ptr(ptr.cast()) }
     }
-}
 
-impl Deref for CStr {
-    type Target = BStr;
+    #[inline]
+    unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut Self {
+        // SAFETY: the cast from `&[u8]` to `&CStr` is safe since the properties of `bytes` are
+        // guaranteed by the safety precondition and `CStr` has the same layout as `&[u8]` (this is
+        // technically not guaranteed, but we rely on it here). The pointer dereference is safe
+        // since it comes from a mutable reference which is guaranteed to be valid for writes.
+        unsafe { &mut *(core::ptr::from_mut(bytes) as *mut CStr) }
+    }
 
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
 
-impl Index<ops::RangeFrom<usize>> for CStr {
-    type Output = CStr;
+    fn make_ascii_lowercase(&mut self) {
+        // SAFETY: This doesn't introduce or remove NUL bytes in the C string.
+        unsafe { to_bytes_mut(self) }.make_ascii_lowercase();
+    }
 
-    #[inline]
-    fn index(&self, index: ops::RangeFrom<usize>) -> &Self::Output {
-        // Delegate bounds checking to slice.
-        // Assign to _ to mute clippy's unnecessary operation warning.
-        let _ = &self.as_bytes()[index.start..];
-        // SAFETY: We just checked the bounds.
-        unsafe { Self::from_bytes_with_nul_unchecked(&self.0[index.start..]) }
+    fn make_ascii_uppercase(&mut self) {
+        // SAFETY: This doesn't introduce or remove NUL bytes in the C string.
+        unsafe { to_bytes_mut(self) }.make_ascii_uppercase();
     }
-}
 
-impl Index<ops::RangeFull> for CStr {
-    type Output = CStr;
+    fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
+        let mut s = self.to_cstring()?;
 
-    #[inline]
-    fn index(&self, _index: ops::RangeFull) -> &Self::Output {
-        self
+        s.make_ascii_lowercase();
+
+        Ok(s)
     }
-}
 
-mod private {
-    use core::ops;
+    fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
+        let mut s = self.to_cstring()?;
 
-    // Marker trait for index types that can be forward to `BStr`.
-    pub trait CStrIndex {}
+        s.make_ascii_uppercase();
 
-    impl CStrIndex for usize {}
-    impl CStrIndex for ops::Range<usize> {}
-    impl CStrIndex for ops::RangeInclusive<usize> {}
-    impl CStrIndex for ops::RangeToInclusive<usize> {}
+        Ok(s)
+    }
 }
 
-impl<Idx> Index<Idx> for CStr
-where
-    Idx: private::CStrIndex,
-    BStr: Index<Idx>,
-{
-    type Output = <BStr as Index<Idx>>::Output;
-
+impl AsRef<BStr> for CStr {
     #[inline]
-    fn index(&self, index: Idx) -> &Self::Output {
-        &self.as_ref()[index]
+    fn as_ref(&self) -> &BStr {
+        BStr::from_bytes(self.to_bytes())
     }
 }
 
@@ -607,6 +397,13 @@ macro_rules! c_str {
 mod tests {
     use super::*;
 
+    impl From<core::ffi::FromBytesWithNulError> for Error {
+        #[inline]
+        fn from(_: core::ffi::FromBytesWithNulError) -> Error {
+            EINVAL
+        }
+    }
+
     macro_rules! format {
         ($($f:tt)*) => ({
             CString::try_from_fmt(fmt!($($f)*))?.to_str()?
@@ -629,40 +426,28 @@ macro_rules! format {
 
     #[test]
     fn test_cstr_to_str() -> Result {
-        let good_bytes = b"\xf0\x9f\xa6\x80\0";
-        let checked_cstr = CStr::from_bytes_with_nul(good_bytes)?;
-        let checked_str = checked_cstr.to_str()?;
+        let cstr = c"\xf0\x9f\xa6\x80";
+        let checked_str = cstr.to_str()?;
         assert_eq!(checked_str, "🦀");
         Ok(())
     }
 
     #[test]
     fn test_cstr_to_str_invalid_utf8() -> Result {
-        let bad_bytes = b"\xc3\x28\0";
-        let checked_cstr = CStr::from_bytes_with_nul(bad_bytes)?;
-        assert!(checked_cstr.to_str().is_err());
-        Ok(())
-    }
-
-    #[test]
-    fn test_cstr_as_str_unchecked() -> Result {
-        let good_bytes = b"\xf0\x9f\x90\xA7\0";
-        let checked_cstr = CStr::from_bytes_with_nul(good_bytes)?;
-        // SAFETY: The contents come from a string literal which contains valid UTF-8.
-        let unchecked_str = unsafe { checked_cstr.as_str_unchecked() };
-        assert_eq!(unchecked_str, "🐧");
+        let cstr = c"\xc3\x28";
+        assert!(cstr.to_str().is_err());
         Ok(())
     }
 
     #[test]
     fn test_cstr_display() -> Result {
-        let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0")?;
+        let hello_world = c"hello, world!";
         assert_eq!(format!("{hello_world}"), "hello, world!");
-        let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0")?;
+        let non_printables = c"\x01\x09\x0a";
         assert_eq!(format!("{non_printables}"), "\\x01\\x09\\x0a");
-        let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?;
+        let non_ascii = c"d\xe9j\xe0 vu";
         assert_eq!(format!("{non_ascii}"), "d\\xe9j\\xe0 vu");
-        let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0")?;
+        let good_bytes = c"\xf0\x9f\xa6\x80";
         assert_eq!(format!("{good_bytes}"), "\\xf0\\x9f\\xa6\\x80");
         Ok(())
     }
@@ -681,13 +466,13 @@ fn test_cstr_display_all_bytes() -> Result {
 
     #[test]
     fn test_cstr_debug() -> Result {
-        let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0")?;
+        let hello_world = c"hello, world!";
         assert_eq!(format!("{hello_world:?}"), "\"hello, world!\"");
-        let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0")?;
-        assert_eq!(format!("{non_printables:?}"), "\"\\x01\\x09\\x0a\"");
-        let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?;
+        let non_printables = c"\x01\x09\x0a";
+        assert_eq!(format!("{non_printables:?}"), "\"\\x01\\t\\n\"");
+        let non_ascii = c"d\xe9j\xe0 vu";
         assert_eq!(format!("{non_ascii:?}"), "\"d\\xe9j\\xe0 vu\"");
-        let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0")?;
+        let good_bytes = c"\xf0\x9f\xa6\x80";
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
         MAX_SCHEDULE_TIMEOUT, TASK_FREEZABLE, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE,
     },
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 27202beef90c..5d7991e6d373 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,7 +7,7 @@
 
 use super::LockClassKey;
 use crate::{
-    str::CStr,
+    str::{CStr, CStrExt as _},
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
 use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index d65f94b5caf2..79d0ef7fda86 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -5,7 +5,7 @@
 //! Support for defining statics containing locks.
 
 use crate::{
-    str::CStr,
+    str::{CStr, CStrExt as _},
     sync::lock::{Backend, Guard, Lock},
     sync::{LockClassKey, LockedBy},
     types::Opaque,

-- 
2.51.0


