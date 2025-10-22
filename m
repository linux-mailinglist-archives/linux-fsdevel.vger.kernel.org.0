Return-Path: <linux-fsdevel+bounces-65118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC8BFC966
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FCD1A62201
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5934EF09;
	Wed, 22 Oct 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyqiDjFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0535BDC8;
	Wed, 22 Oct 2025 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143556; cv=none; b=JSf9cRHpodFP8mLFqxfBU6aIkeyp0GCWGqpWYl1pQLkYfZh4x3MyGOqxTYiiPkJGz36cEIi+4jIeSnazLJOH6lUNEkGWx2x+/FUKy/8pat4Ql8m755rR/qUadJR7Msgkj4uTEXKXaSn29Ni6xGbKCdl8anOALnFW6B+FamB1BVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143556; c=relaxed/simple;
	bh=FjKY9QsB1XFo54VLaBgstN2S0XKDdqqOijiLBegPaAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBVFzV+M3o+rrdaECy3kxD9vn/wG8OU4PN2JsS2PFIR3P1CBtc+n6EPWSaM7sjrpUYCI9IzlNhlSBXvVnC7BWApXq/RoukK7AX8VY6+TRO5kpU/TIa+L6lvUpQE4I4tLFfpt7ve5n7r5Z1foepCukLDrSeWymuXHxKZ57vFhr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyqiDjFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B65C116B1;
	Wed, 22 Oct 2025 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143555;
	bh=FjKY9QsB1XFo54VLaBgstN2S0XKDdqqOijiLBegPaAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyqiDjFBytQpSgJmSXDgQFEKaGx0l3mo4PhCXT4AcKUhWmN8NRZEleYNrrwlqFzyj
	 QAFWdZsa+VJjvZWw7mzUn2DTIxBr8m0C6vKJ5mn/B6kdhlaHxf02tJkcfi8SZtfcFW
	 6K9CDC6+WDfZIZom+dJ5NiDFBa92kdktYWgincCQaFUL6D167dZwIhWjHRFTPo1R0E
	 t42xzirrz4UiVZHZBVsQeGIm89KB0wUeseROrUhXLBngKriMWXyvZUiN1nU+ivhypT
	 QnESxd1riZuEGXQfMs0lWUAuJVhDZZtZ9IRAQNcMXqilzt9Dx1dsqY32oOPU7dLhyX
	 iB+WnQ/gCcsOw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	mmaurer@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 07/10] rust: debugfs: support blobs from smart pointers
Date: Wed, 22 Oct 2025 16:30:41 +0200
Message-ID: <20251022143158.64475-8-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022143158.64475-1-dakr@kernel.org>
References: <20251022143158.64475-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend Rust debugfs binary support to allow exposing data stored in
common smart pointers and heap-allocated collections.

- Implement BinaryWriter for Box<T>, Pin<Box<T>>, Arc<T>, and Vec<T>.
- Introduce BinaryReaderMut for mutable binary access with outer locks.
- Implement BinaryReaderMut for Box<T>, Vec<T>, and base types.
- Update BinaryReader to delegate to BinaryReaderMut for Mutex<T>,
  Box<T>, Pin<Box<T>> and Arc<T>.

This enables debugfs files to directly expose or update data stored
inside heap-allocated, reference-counted, or lock-protected containers
without manual dereferencing or locking.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/debugfs.rs        |   2 +-
 rust/kernel/debugfs/traits.rs | 174 +++++++++++++++++++++++++++++++++-
 2 files changed, 173 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 95cd3376ecbe..d2bc7550d81e 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -21,7 +21,7 @@
 use core::ops::Deref;
 
 mod traits;
-pub use traits::{BinaryReader, BinaryWriter, Reader, Writer};
+pub use traits::{BinaryReader, BinaryReaderMut, BinaryWriter, Reader, Writer};
 
 mod callback_adapters;
 use callback_adapters::{FormatAdapter, NoWriter, WritableAdapter};
diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index bd38eb988d51..2c32ddf9826f 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -3,12 +3,15 @@
 
 //! Traits for rendering or updating values exported to DebugFS.
 
+use crate::alloc::Allocator;
 use crate::fs::file;
 use crate::prelude::*;
+use crate::sync::Arc;
 use crate::sync::Mutex;
 use crate::transmute::{AsBytes, FromBytes};
 use crate::uaccess::{UserSliceReader, UserSliceWriter};
 use core::fmt::{self, Debug, Formatter};
+use core::ops::{Deref, DerefMut};
 use core::str::FromStr;
 use core::sync::atomic::{
     AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, AtomicU32, AtomicU64,
@@ -79,6 +82,72 @@ fn write_to_slice(
     }
 }
 
+// Delegate for `Box<T, A>`: Support a `Box<T, A>` with no lock or an inner lock.
+impl<T, A> BinaryWriter for Box<T, A>
+where
+    T: BinaryWriter,
+    A: Allocator,
+{
+    fn write_to_slice(
+        &self,
+        writer: &mut UserSliceWriter,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        self.deref().write_to_slice(writer, offset)
+    }
+}
+
+// Delegate for `Pin<Box<T, A>>`: Support a `Pin<Box<T, A>>` with no lock or an inner lock.
+impl<T, A> BinaryWriter for Pin<Box<T, A>>
+where
+    T: BinaryWriter,
+    A: Allocator,
+{
+    fn write_to_slice(
+        &self,
+        writer: &mut UserSliceWriter,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        self.deref().write_to_slice(writer, offset)
+    }
+}
+
+// Delegate for `Arc<T>`: Support a `Arc<T>` with no lock or an inner lock.
+impl<T> BinaryWriter for Arc<T>
+where
+    T: BinaryWriter,
+{
+    fn write_to_slice(
+        &self,
+        writer: &mut UserSliceWriter,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        self.deref().write_to_slice(writer, offset)
+    }
+}
+
+// Delegate for `Vec<T, A>`.
+impl<T, A> BinaryWriter for Vec<T, A>
+where
+    T: AsBytes,
+    A: Allocator,
+{
+    fn write_to_slice(
+        &self,
+        writer: &mut UserSliceWriter,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        let slice = self.as_slice();
+
+        // SAFETY: `T: AsBytes` allows us to treat `&[T]` as `&[u8]`.
+        let buffer = unsafe {
+            core::slice::from_raw_parts(slice.as_ptr().cast(), core::mem::size_of_val(slice))
+        };
+
+        writer.write_slice_file(buffer, offset)
+    }
+}
+
 /// A trait for types that can be updated from a user slice.
 ///
 /// This works similarly to `FromStr`, but operates on a `UserSliceReader` rather than a &str.
@@ -107,6 +176,73 @@ fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
 }
 
 /// Trait for types that can be constructed from a binary representation.
+///
+/// See also [`BinaryReader`] for interior mutability.
+pub trait BinaryReaderMut {
+    /// Reads the binary form of `self` from `reader`.
+    ///
+    /// Same as [`BinaryReader::read_from_slice`], but takes a mutable reference.
+    ///
+    /// `offset` is the requested offset into the binary representation of `self`.
+    ///
+    /// On success, returns the number of bytes read from `reader`.
+    fn read_from_slice_mut(
+        &mut self,
+        reader: &mut UserSliceReader,
+        offset: &mut file::Offset,
+    ) -> Result<usize>;
+}
+
+// Base implementation for any `T: AsBytes + FromBytes`.
+impl<T: AsBytes + FromBytes> BinaryReaderMut for T {
+    fn read_from_slice_mut(
+        &mut self,
+        reader: &mut UserSliceReader,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        reader.read_slice_file(self.as_bytes_mut(), offset)
+    }
+}
+
+// Delegate for `Box<T, A>`: Support a `Box<T, A>` with an outer lock.
+impl<T: ?Sized + BinaryReaderMut, A: Allocator> BinaryReaderMut for Box<T, A> {
+    fn read_from_slice_mut(
+        &mut self,
+        reader: &mut UserSliceReader,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        self.deref_mut().read_from_slice_mut(reader, offset)
+    }
+}
+
+// Delegate for `Vec<T, A>`: Support a `Vec<T, A>` with an outer lock.
+impl<T, A> BinaryReaderMut for Vec<T, A>
+where
+    T: AsBytes + FromBytes,
+    A: Allocator,
+{
+    fn read_from_slice_mut(
+        &mut self,
+        reader: &mut UserSliceReader,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        let slice = self.as_mut_slice();
+
+        // SAFETY: `T: AsBytes + FromBytes` allows us to treat `&mut [T]` as `&mut [u8]`.
+        let buffer = unsafe {
+            core::slice::from_raw_parts_mut(
+                slice.as_mut_ptr().cast(),
+                core::mem::size_of_val(slice),
+            )
+        };
+
+        reader.read_slice_file(buffer, offset)
+    }
+}
+
+/// Trait for types that can be constructed from a binary representation.
+///
+/// See also [`BinaryReaderMut`] for the mutable version.
 pub trait BinaryReader {
     /// Reads the binary form of `self` from `reader`.
     ///
@@ -120,7 +256,8 @@ fn read_from_slice(
     ) -> Result<usize>;
 }
 
-impl<T: AsBytes + FromBytes> BinaryReader for Mutex<T> {
+// Delegate for `Mutex<T>`: Support a `T` with an outer `Mutex`.
+impl<T: BinaryReaderMut> BinaryReader for Mutex<T> {
     fn read_from_slice(
         &self,
         reader: &mut UserSliceReader,
@@ -128,7 +265,40 @@ fn read_from_slice(
     ) -> Result<usize> {
         let mut this = self.lock();
 
-        reader.read_slice_file(this.as_bytes_mut(), offset)
+        this.read_from_slice_mut(reader, offset)
+    }
+}
+
+// Delegate for `Box<T, A>`: Support a `Box<T, A>` with an inner lock.
+impl<T: ?Sized + BinaryReader, A: Allocator> BinaryReader for Box<T, A> {
+    fn read_from_slice(
+        &self,
+        reader: &mut UserSliceReader,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        self.deref().read_from_slice(reader, offset)
+    }
+}
+
+// Delegate for `Pin<Box<T, A>>`: Support a `Pin<Box<T, A>>` with an inner lock.
+impl<T: ?Sized + BinaryReader, A: Allocator> BinaryReader for Pin<Box<T, A>> {
+    fn read_from_slice(
+        &self,
+        reader: &mut UserSliceReader,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        self.deref().read_from_slice(reader, offset)
+    }
+}
+
+// Delegate for `Arc<T>`: Support an `Arc<T>` with an inner lock.
+impl<T: ?Sized + BinaryReader> BinaryReader for Arc<T> {
+    fn read_from_slice(
+        &self,
+        reader: &mut UserSliceReader,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        self.deref().read_from_slice(reader, offset)
     }
 }
 
-- 
2.51.0


