Return-Path: <linux-fsdevel+bounces-65117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A67BFCA05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28CF6E4183
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823734E772;
	Wed, 22 Oct 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4gx2cRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A534845B;
	Wed, 22 Oct 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143553; cv=none; b=hIDHMqyb4teQLBLwby7VVeAPkFzAMbBX9dRc0ioqJ6aSH3x+bcRj6rKm3v6f8O6HMq5HFODll18EDrD8vdRGM6wZmOV4y8Xv6QqDa1zjr+SpGowlATS8fbeTA2Ax4HIpPCY42MhWkwvap170Ds6y98Q9lnBJ28Ie86CUi2EBffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143553; c=relaxed/simple;
	bh=jIUKsgHWgrLlyXu1OVgX+9KLVjJmJ4i6rgyukKgCF4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDqZxeFYZlZPvwED8pJ9aRJ025+MZpwMrIui8UOcrIi4NOrTQRCH4TcNmTeOoUFRLSNwI3uRSrR0+SCar6GnjioPqq3EAAujOCKLp2msavxf5lNDr9usdi4Fsu5zolzgaE2vdClAJrtRmBKhQl7cEFVGkb5N29kow/npFZp+DYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4gx2cRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170B2C4CEE7;
	Wed, 22 Oct 2025 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143552;
	bh=jIUKsgHWgrLlyXu1OVgX+9KLVjJmJ4i6rgyukKgCF4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b4gx2cREU4BA8Hh3nmRxJdCBr0yUog3FQmrsrjlH3j9VVLT1ghcb5E/GSLUnMiGH+
	 lxKvgQpAzy6xP+lxvZOV4PqmP33OPajB6UtgaDyEneZZr8SuSbHtgslEUpfzYJiNF0
	 8VrL/LUQ11bcaRs63yCt9KKatbfiHbFAag++PajNiK8/O1NefHEio0kkOwECUaDGeC
	 l2p6iRH/Bw1OlsZ8hwUXVlJA+9ShfKg7tPxTYriOXDedbbRBTxfBBApgVdNOA2zo5g
	 IW5f1R0TJUGVG9r4jfJVwCwFEUd8nqO8jGcHRv+3rWh2Kkfr768SUmVAwyvfuAMuE2
	 /UKLjqeqki0dQ==
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
Subject: [PATCH v3 06/10] rust: debugfs: support for binary large objects
Date: Wed, 22 Oct 2025 16:30:40 +0200
Message-ID: <20251022143158.64475-7-dakr@kernel.org>
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

Introduce support for read-only, write-only, and read-write binary files
in Rust debugfs. This adds:

- BinaryWriter and BinaryReader traits for writing to and reading from
  user slices in binary form.
- New Dir methods: read_binary_file(), write_binary_file(),
  `read_write_binary_file`.
- Corresponding FileOps implementations: BinaryReadFile,
  BinaryWriteFile, BinaryReadWriteFile.

This allows kernel modules to expose arbitrary binary data through
debugfs, with proper support for offsets and partial reads/writes.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/debugfs.rs          |  66 ++++++++++++++-
 rust/kernel/debugfs/file_ops.rs | 146 +++++++++++++++++++++++++++++++-
 rust/kernel/debugfs/traits.rs   |  68 ++++++++++++++-
 3 files changed, 273 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 381c23b3dd83..95cd3376ecbe 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -21,12 +21,15 @@
 use core::ops::Deref;
 
 mod traits;
-pub use traits::{Reader, Writer};
+pub use traits::{BinaryReader, BinaryWriter, Reader, Writer};
 
 mod callback_adapters;
 use callback_adapters::{FormatAdapter, NoWriter, WritableAdapter};
 mod file_ops;
-use file_ops::{FileOps, ReadFile, ReadWriteFile, WriteFile};
+use file_ops::{
+    BinaryReadFile, BinaryReadWriteFile, BinaryWriteFile, FileOps, ReadFile, ReadWriteFile,
+    WriteFile,
+};
 #[cfg(CONFIG_DEBUG_FS)]
 mod entry;
 #[cfg(CONFIG_DEBUG_FS)]
@@ -150,6 +153,32 @@ pub fn read_only_file<'a, T, E: 'a>(
         self.create_file(name, data, file_ops)
     }
 
+    /// Creates a read-only binary file in this directory.
+    ///
+    /// The file's contents are produced by invoking [`BinaryWriter::write_to_slice`] on the value
+    /// initialized by `data`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::debugfs::Dir;
+    /// # use kernel::prelude::*;
+    /// # let dir = Dir::new(c_str!("my_debugfs_dir"));
+    /// let file = KBox::pin_init(dir.read_binary_file(c_str!("foo"), [0x1, 0x2]), GFP_KERNEL)?;
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn read_binary_file<'a, T, E: 'a>(
+        &'a self,
+        name: &'a CStr,
+        data: impl PinInit<T, E> + 'a,
+    ) -> impl PinInit<File<T>, E> + 'a
+    where
+        T: BinaryWriter + Send + Sync + 'static,
+    {
+        self.create_file(name, data, &T::FILE_OPS)
+    }
+
     /// Creates a read-only file in this directory, with contents from a callback.
     ///
     /// `f` must be a function item or a non-capturing closure.
@@ -206,6 +235,22 @@ pub fn read_write_file<'a, T, E: 'a>(
         self.create_file(name, data, file_ops)
     }
 
+    /// Creates a read-write binary file in this directory.
+    ///
+    /// Reading the file uses the [`BinaryWriter`] implementation.
+    /// Writing to the file uses the [`BinaryReader`] implementation.
+    pub fn read_write_binary_file<'a, T, E: 'a>(
+        &'a self,
+        name: &'a CStr,
+        data: impl PinInit<T, E> + 'a,
+    ) -> impl PinInit<File<T>, E> + 'a
+    where
+        T: BinaryWriter + BinaryReader + Send + Sync + 'static,
+    {
+        let file_ops = &<T as BinaryReadWriteFile<_>>::FILE_OPS;
+        self.create_file(name, data, file_ops)
+    }
+
     /// Creates a read-write file in this directory, with logic from callbacks.
     ///
     /// Reading from the file is handled by `f`. Writing to the file is handled by `w`.
@@ -248,6 +293,23 @@ pub fn write_only_file<'a, T, E: 'a>(
         self.create_file(name, data, &T::FILE_OPS)
     }
 
+    /// Creates a write-only binary file in this directory.
+    ///
+    /// The file owns its backing data. Writing to the file uses the [`BinaryReader`]
+    /// implementation.
+    ///
+    /// The file is removed when the returned [`File`] is dropped.
+    pub fn write_binary_file<'a, T, E: 'a>(
+        &'a self,
+        name: &'a CStr,
+        data: impl PinInit<T, E> + 'a,
+    ) -> impl PinInit<File<T>, E> + 'a
+    where
+        T: BinaryReader + Send + Sync + 'static,
+    {
+        self.create_file(name, data, &T::FILE_OPS)
+    }
+
     /// Creates a write-only file in this directory, with write logic from a callback.
     ///
     /// `w` must be a function item or a non-capturing closure.
diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_ops.rs
index 50fead17b6f3..ebdd2427d2ce 100644
--- a/rust/kernel/debugfs/file_ops.rs
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -1,13 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2025 Google LLC.
 
-use super::{Reader, Writer};
+use super::{BinaryReader, BinaryWriter, Reader, Writer};
 use crate::debugfs::callback_adapters::Adapter;
+use crate::fs::file;
 use crate::prelude::*;
 use crate::seq_file::SeqFile;
 use crate::seq_print;
 use crate::uaccess::UserSlice;
-use core::fmt::{Display, Formatter, Result};
+use core::fmt;
 use core::marker::PhantomData;
 
 #[cfg(CONFIG_DEBUG_FS)]
@@ -65,8 +66,8 @@ fn deref(&self) -> &Self::Target {
 
 struct WriterAdapter<T>(T);
 
-impl<'a, T: Writer> Display for WriterAdapter<&'a T> {
-    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+impl<'a, T: Writer> fmt::Display for WriterAdapter<&'a T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         self.0.write(f)
     }
 }
@@ -245,3 +246,140 @@ impl<T: Reader + Sync> WriteFile<T> for T {
         unsafe { FileOps::new(operations, 0o200) }
     };
 }
+
+extern "C" fn blob_read<T: BinaryWriter>(
+    file: *mut bindings::file,
+    buf: *mut c_char,
+    count: usize,
+    ppos: *mut bindings::loff_t,
+) -> isize {
+    // SAFETY:
+    // - `file` is a valid pointer to a `struct file`.
+    // - The type invariant of `FileOps` guarantees that `private_data` points to a valid `T`.
+    let this = unsafe { &*((*file).private_data.cast::<T>()) };
+
+    // SAFETY:
+    // `ppos` is a valid `file::Offset` pointer.
+    // We have exclusive access to `ppos`.
+    let pos = unsafe { file::Offset::from_raw(ppos) };
+
+    let mut writer = UserSlice::new(UserPtr::from_ptr(buf.cast()), count).writer();
+
+    let ret = || -> Result<isize> {
+        let written = this.write_to_slice(&mut writer, pos)?;
+
+        Ok(written.try_into()?)
+    }();
+
+    match ret {
+        Ok(n) => n,
+        Err(e) => e.to_errno() as isize,
+    }
+}
+
+/// Representation of [`FileOps`] for read only binary files.
+pub(crate) trait BinaryReadFile<T> {
+    const FILE_OPS: FileOps<T>;
+}
+
+impl<T: BinaryWriter + Sync> BinaryReadFile<T> for T {
+    const FILE_OPS: FileOps<T> = {
+        let operations = bindings::file_operations {
+            read: Some(blob_read::<T>),
+            llseek: Some(bindings::default_llseek),
+            open: Some(bindings::simple_open),
+            // SAFETY: `file_operations` supports zeroes in all fields.
+            ..unsafe { core::mem::zeroed() }
+        };
+
+        // SAFETY:
+        // - The private data of `struct inode` does always contain a pointer to a valid `T`.
+        // - `simple_open()` stores the `struct inode`'s private data in the private data of the
+        //   corresponding `struct file`.
+        // - `blob_read()` re-creates a reference to `T` from the `struct file`'s private data.
+        // - `default_llseek()` does not access the `struct file`'s private data.
+        unsafe { FileOps::new(operations, 0o400) }
+    };
+}
+
+extern "C" fn blob_write<T: BinaryReader>(
+    file: *mut bindings::file,
+    buf: *const c_char,
+    count: usize,
+    ppos: *mut bindings::loff_t,
+) -> isize {
+    // SAFETY:
+    // - `file` is a valid pointer to a `struct file`.
+    // - The type invariant of `FileOps` guarantees that `private_data` points to a valid `T`.
+    let this = unsafe { &*((*file).private_data.cast::<T>()) };
+
+    // SAFETY:
+    // `ppos` is a valid `file::Offset` pointer.
+    // We have exclusive access to `ppos`.
+    let pos = unsafe { file::Offset::from_raw(ppos) };
+
+    let mut reader = UserSlice::new(UserPtr::from_ptr(buf.cast_mut().cast()), count).reader();
+
+    let ret = || -> Result<isize> {
+        let read = this.read_from_slice(&mut reader, pos)?;
+
+        Ok(read.try_into()?)
+    }();
+
+    match ret {
+        Ok(n) => n,
+        Err(e) => e.to_errno() as isize,
+    }
+}
+
+/// Representation of [`FileOps`] for write only binary files.
+pub(crate) trait BinaryWriteFile<T> {
+    const FILE_OPS: FileOps<T>;
+}
+
+impl<T: BinaryReader + Sync> BinaryWriteFile<T> for T {
+    const FILE_OPS: FileOps<T> = {
+        let operations = bindings::file_operations {
+            write: Some(blob_write::<T>),
+            llseek: Some(bindings::default_llseek),
+            open: Some(bindings::simple_open),
+            // SAFETY: `file_operations` supports zeroes in all fields.
+            ..unsafe { core::mem::zeroed() }
+        };
+
+        // SAFETY:
+        // - The private data of `struct inode` does always contain a pointer to a valid `T`.
+        // - `simple_open()` stores the `struct inode`'s private data in the private data of the
+        //   corresponding `struct file`.
+        // - `blob_write()` re-creates a reference to `T` from the `struct file`'s private data.
+        // - `default_llseek()` does not access the `struct file`'s private data.
+        unsafe { FileOps::new(operations, 0o200) }
+    };
+}
+
+/// Representation of [`FileOps`] for read/write binary files.
+pub(crate) trait BinaryReadWriteFile<T> {
+    const FILE_OPS: FileOps<T>;
+}
+
+impl<T: BinaryWriter + BinaryReader + Sync> BinaryReadWriteFile<T> for T {
+    const FILE_OPS: FileOps<T> = {
+        let operations = bindings::file_operations {
+            read: Some(blob_read::<T>),
+            write: Some(blob_write::<T>),
+            llseek: Some(bindings::default_llseek),
+            open: Some(bindings::simple_open),
+            // SAFETY: `file_operations` supports zeroes in all fields.
+            ..unsafe { core::mem::zeroed() }
+        };
+
+        // SAFETY:
+        // - The private data of `struct inode` does always contain a pointer to a valid `T`.
+        // - `simple_open()` stores the `struct inode`'s private data in the private data of the
+        //   corresponding `struct file`.
+        // - `blob_read()` re-creates a reference to `T` from the `struct file`'s private data.
+        // - `blob_write()` re-creates a reference to `T` from the `struct file`'s private data.
+        // - `default_llseek()` does not access the `struct file`'s private data.
+        unsafe { FileOps::new(operations, 0o600) }
+    };
+}
diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index ab009eb254b3..bd38eb988d51 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -3,9 +3,11 @@
 
 //! Traits for rendering or updating values exported to DebugFS.
 
+use crate::fs::file;
 use crate::prelude::*;
 use crate::sync::Mutex;
-use crate::uaccess::UserSliceReader;
+use crate::transmute::{AsBytes, FromBytes};
+use crate::uaccess::{UserSliceReader, UserSliceWriter};
 use core::fmt::{self, Debug, Formatter};
 use core::str::FromStr;
 use core::sync::atomic::{
@@ -39,6 +41,44 @@ fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
     }
 }
 
+/// Trait for types that can be written out as binary.
+pub trait BinaryWriter {
+    /// Writes the binary form of `self` into `writer`.
+    ///
+    /// `offset` is the requested offset into the binary representation of `self`.
+    ///
+    /// On success, returns the number of bytes written in to `writer`.
+    fn write_to_slice(
+        &self,
+        writer: &mut UserSliceWriter,
+        offset: &mut file::Offset,
+    ) -> Result<usize>;
+}
+
+// Base implementation for any `T: AsBytes`.
+impl<T: AsBytes> BinaryWriter for T {
+    fn write_to_slice(
+        &self,
+        writer: &mut UserSliceWriter,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        writer.write_slice_file(self.as_bytes(), offset)
+    }
+}
+
+// Delegate for `Mutex<T>`: Support a `T` with an outer mutex.
+impl<T: BinaryWriter> BinaryWriter for Mutex<T> {
+    fn write_to_slice(
+        &self,
+        writer: &mut UserSliceWriter,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        let guard = self.lock();
+
+        guard.write_to_slice(writer, offset)
+    }
+}
+
 /// A trait for types that can be updated from a user slice.
 ///
 /// This works similarly to `FromStr`, but operates on a `UserSliceReader` rather than a &str.
@@ -66,6 +106,32 @@ fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
     }
 }
 
+/// Trait for types that can be constructed from a binary representation.
+pub trait BinaryReader {
+    /// Reads the binary form of `self` from `reader`.
+    ///
+    /// `offset` is the requested offset into the binary representation of `self`.
+    ///
+    /// On success, returns the number of bytes read from `reader`.
+    fn read_from_slice(
+        &self,
+        reader: &mut UserSliceReader,
+        offset: &mut file::Offset,
+    ) -> Result<usize>;
+}
+
+impl<T: AsBytes + FromBytes> BinaryReader for Mutex<T> {
+    fn read_from_slice(
+        &self,
+        reader: &mut UserSliceReader,
+        offset: &mut file::Offset,
+    ) -> Result<usize> {
+        let mut this = self.lock();
+
+        reader.read_slice_file(this.as_bytes_mut(), offset)
+    }
+}
+
 macro_rules! impl_reader_for_atomic {
     ($(($atomic_type:ty, $int_type:ty)),*) => {
         $(
-- 
2.51.0


