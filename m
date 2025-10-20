Return-Path: <linux-fsdevel+bounces-64785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E2BF3E6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E72B4FE4B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D482F49F0;
	Mon, 20 Oct 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1llUyLf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650EE2F3C27;
	Mon, 20 Oct 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999283; cv=none; b=dzXa9PnDqV72qiYyYaR535CrevobIgYfih54VDLf9+uZ0LhOJ4dhKYeNX+93Z7X+b8Ex/UsARzufq0oP/hfe+kwDEH6NdRwajyF+MNm2ZcYqW+RgF9/FYmKCPlPFhVwYcfm2Yq28aROG2l+kE2Pm7QAsjmO59O/pM4h5tp8PdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999283; c=relaxed/simple;
	bh=+XQCKNX8uKxXpCrI5r0y7bL1E8D1OXDv9kFYN+kdML4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqz+uopPfCYnE7tRoqJxMyI9PLgC4T3x8t/aDc6/YXw8e6PHJvHv+jDvOQeckbJvZ4yM5NhQXFYii0aH6RZ6ZL9Cw1z+789LcNan5bRsHMWXdU0hbgdbnDWdnz2/scfsJVDTolExaYdWATbjzvxM4z4wVWvWR6jbNGL8DGqHc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1llUyLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD193C4CEFB;
	Mon, 20 Oct 2025 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999283;
	bh=+XQCKNX8uKxXpCrI5r0y7bL1E8D1OXDv9kFYN+kdML4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1llUyLfoBcp4X8IX7jt8YzS7yocenn8tpIbNlqKPEg59bO6LMnrC/xTJ5t50EL6q
	 Xxh/Lq2U529Q5qwImcnvtDsYKBTjNiK7PZ2nJMAWrSHMAPJwrcb/QTel4vagrhlZhh
	 c9n/fv72DDpdMhdV/1ovCkP3ZjRj6GvhoN5YEyL+HsSsJFqY7Az724I6C+/hU56o/V
	 jew4ezjFmExoOb+bHeniNMnCcGpUNPKBsrb7/CE3agRgQD89EQflm9nII30fovCzlm
	 fv2sZbi8iUizeJqeuSLZujlpo/KroVTstcR/zbp0/E5FQREwcDs6wQHYsWNQdoS/QT
	 KcUUIeuBNU/Fw==
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
Subject: [PATCH v2 5/8] rust: debugfs: support blobs from smart pointers
Date: Tue, 21 Oct 2025 00:26:17 +0200
Message-ID: <20251020222722.240473-6-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222722.240473-1-dakr@kernel.org>
References: <20251020222722.240473-1-dakr@kernel.org>
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

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/debugfs.rs        |   2 +-
 rust/kernel/debugfs/traits.rs | 148 +++++++++++++++++++++++++++++++++-
 2 files changed, 147 insertions(+), 3 deletions(-)

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
index 5f80ce77bf17..c1adf4d9f270 100644
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
@@ -51,12 +54,14 @@ pub trait BinaryWriter {
     fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize>;
 }
 
+// Base implementation for any `T: AsBytes`.
 impl<T: AsBytes> BinaryWriter for T {
     fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
         writer.write_slice_partial(self.as_bytes(), offset)
     }
 }
 
+// Delegate for `Mutex<T>`: Support a `T` with an outer mutex.
 impl<T: BinaryWriter> BinaryWriter for Mutex<T> {
     fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
         let guard = self.lock();
@@ -65,6 +70,56 @@ fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) ->
     }
 }
 
+// Delegate for `Box<T, A>`: Support a `Box<T, A>` with no lock or an inner lock.
+impl<T, A> BinaryWriter for Box<T, A>
+where
+    T: BinaryWriter,
+    A: Allocator,
+{
+    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
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
+    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
+        self.deref().write_to_slice(writer, offset)
+    }
+}
+
+// Delegate for `Arc<T>`: Support a `Arc<T>` with no lock or an inner lock.
+impl<T> BinaryWriter for Arc<T>
+where
+    T: BinaryWriter,
+{
+    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
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
+    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file::Offset) -> Result<usize> {
+        let slice = self.as_slice();
+
+        // SAFETY: `T: AsBytes` allows us to treat `&[T]` as `&[u8]`.
+        let buffer = unsafe {
+            core::slice::from_raw_parts(slice.as_ptr().cast(), core::mem::size_of_val(slice))
+        };
+
+        writer.write_slice_partial(buffer, offset)
+    }
+}
+
 /// A trait for types that can be updated from a user slice.
 ///
 /// This works similarly to `FromStr`, but operates on a `UserSliceReader` rather than a &str.
@@ -93,6 +148,73 @@ fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
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
+        offset: file::Offset,
+    ) -> Result<usize>;
+}
+
+// Base implementation for any `T: AsBytes + FromBytes`.
+impl<T: AsBytes + FromBytes> BinaryReaderMut for T {
+    fn read_from_slice_mut(
+        &mut self,
+        reader: &mut UserSliceReader,
+        offset: file::Offset,
+    ) -> Result<usize> {
+        reader.read_slice_partial(self.as_bytes_mut(), offset)
+    }
+}
+
+// Delegate for `Box<T, A>`: Support a `Box<T, A>` with an outer lock.
+impl<T: ?Sized + BinaryReaderMut, A: Allocator> BinaryReaderMut for Box<T, A> {
+    fn read_from_slice_mut(
+        &mut self,
+        reader: &mut UserSliceReader,
+        offset: file::Offset,
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
+        offset: file::Offset,
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
+        reader.read_slice_partial(buffer, offset)
+    }
+}
+
+/// Trait for types that can be constructed from a binary representation.
+///
+/// See also [`BinaryReaderMut`] for the mutable version.
 pub trait BinaryReader {
     /// Reads the binary form of `self` from `reader`.
     ///
@@ -102,11 +224,33 @@ pub trait BinaryReader {
     fn read_from_slice(&self, reader: &mut UserSliceReader, offset: file::Offset) -> Result<usize>;
 }
 
-impl<T: AsBytes + FromBytes> BinaryReader for Mutex<T> {
+// Delegate for `Mutex<T>`: Support a `T` with an outer `Mutex`.
+impl<T: BinaryReaderMut> BinaryReader for Mutex<T> {
     fn read_from_slice(&self, reader: &mut UserSliceReader, offset: file::Offset) -> Result<usize> {
         let mut this = self.lock();
 
-        reader.read_slice_partial(this.as_bytes_mut(), offset)
+        this.read_from_slice_mut(reader, offset)
+    }
+}
+
+// Delegate for `Box<T, A>`: Support a `Box<T, A>` with an inner lock.
+impl<T: ?Sized + BinaryReader, A: Allocator> BinaryReader for Box<T, A> {
+    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: file::Offset) -> Result<usize> {
+        self.deref().read_from_slice(reader, offset)
+    }
+}
+
+// Delegate for `Pin<Box<T, A>>`: Support a `Pin<Box<T, A>>` with an inner lock.
+impl<T: ?Sized + BinaryReader, A: Allocator> BinaryReader for Pin<Box<T, A>> {
+    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: file::Offset) -> Result<usize> {
+        self.deref().read_from_slice(reader, offset)
+    }
+}
+
+// Delegate for `Arc<T>`: Support an `Arc<T>` with an inner lock.
+impl<T: ?Sized + BinaryReader> BinaryReader for Arc<T> {
+    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: file::Offset) -> Result<usize> {
+        self.deref().read_from_slice(reader, offset)
     }
 }
 
-- 
2.51.0


