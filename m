Return-Path: <linux-fsdevel+bounces-19440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15E88C56FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1D7B222B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62364158A34;
	Tue, 14 May 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dme5CEh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CEC1581F5;
	Tue, 14 May 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692679; cv=none; b=L1xwvxtdAbywUEYnYxLnr00vmMcBXAaB1Pqy6JmC318szP5F8SfK+t6vqvhmky1UUOfrmpX9rIYOs501PGXxLDHfDlUTSgnO6140cyNCaD42QGHzQ88HVuaNyz/pmkXqHmopGn6O0MPDmy/nmxjOKFBS90OSPHoMmzGUPkXjhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692679; c=relaxed/simple;
	bh=Mhw2NB5w8PjE8bdfQ9exSZQao0oZ/hV9IrJUXzE+2OI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ePirj/O2a+rWkyoyCZVqyYulAhxvIwfTmIhG9V0cb651w3sEZfmvPgOCz6EMdB3rjyeHbN39SLW1kFl+rP7BZb4TSyAlzJTlRz+kc5b1lFYdUlkf6A6CaRFBTWUsg2YCF1Swtsx/gTq0zHh+wiM3/SxHTw0RvctYRMllHEzbCHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dme5CEh2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso43597695ad.0;
        Tue, 14 May 2024 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692677; x=1716297477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8RGtd5B3kfKXLsTm7I/2Z3SzqH3F7mfyT0pCA+knV0=;
        b=dme5CEh2GhK4dYkNcV3srdrQYtF8VAlNacXsy1rrZBNwQgq2qkOT+Oip6euTsieL9r
         f/Z38xhCLO+zJoQe1KNahMnugfVzXl4nMlVwt+h6yWLwAZznIM0e9DPkWwcsKxV/awkY
         HKNGvxq8xvwC/4uQq7bXn+L4ueLNLuO/JnLbgR0Fr8TDKRz25QkyhKieqh90UFWE5uzS
         acdqpDvVk8zshhT9VcdGCsQFiYWY8E7dnYRr9rbaoyvsWxaSRVmUvHXBVK383zDpFj9o
         PNys+gzxwHfDemsPby0nayqpTB5SNkKyl6upvJH9XA5JX3Wg4Zrjem/xumZTsUbakhcI
         ArjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692677; x=1716297477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8RGtd5B3kfKXLsTm7I/2Z3SzqH3F7mfyT0pCA+knV0=;
        b=YuWAJeVvKmtUiC1E96aAthgWCb1QmMBZq+TXKjAA3PQCL9NBmxN1Mk5ZnqpMzsuUH6
         wjiLwP8JYRQLGee8Aig4cQ/a1tJdGeTKq07SyULPR7NyE0RHn4NNWcVqdqRPbYwnjVB0
         T4AO22pslni3OUYDDxwY2GrD+cDQJtLWSXK7QaUIlfhZFoktwO3W2ZADupUnfZy+74ZU
         OkuiBlNNXy5vNgPjpmPZB7GfIJX9BTysBzluKS4yLAHEzo5BZwi1DUd0Xf8mQc1ZAmhv
         Gf/Ym3p2+9kRzgl0AWkrhZ7BjlKQfalF1ilP/QVBizGrzTRyzQhJwJGOuN08KgGqTGcv
         5btg==
X-Forwarded-Encrypted: i=1; AJvYcCURa3xh0ptJ2tZa9E3sXkwQk+6JjDxCtglh3IF4sJ6/efdUukFSOFvcH1aqM2WTOmk3OVMLm8JuosropOMp8SmuEmZuFVSY/Y5gXuObB/KUmRWyyNXylwHjc7C0nKrjMXI9EoCzHXhje3X1FXtnoPhswd2S0yhdmI4IkePtN82FGBQF1Ijgq9FtrZjt
X-Gm-Message-State: AOJu0Yx0EiTzmStg982izKdhE4ugOmYJ+yaHeE6bFMpzAM65rlGUlm8R
	X7a511Mc5cNTsWvSpn2JgNaJoksqbgfkhZwQxF14KWHTdiI/cM0t
X-Google-Smtp-Source: AGHT+IEp91zv640NlP+Kp1bf1SwRXohBkiR0OHQL4DImncKJXCDlLG4u8+08GZfL3PzxjMY7j6RU/A==
X-Received: by 2002:a17:902:d485:b0:1e4:200e:9c2b with SMTP id d9443c01a7336-1ef43d15794mr172216745ad.21.1715692676651;
        Tue, 14 May 2024 06:17:56 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:56 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH v2 18/30] rust: fs: introduce `address_space::Operations::read_folio`
Date: Tue, 14 May 2024 10:16:59 -0300
Message-Id: <20240514131711.379322-19-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514131711.379322-1-wedsonaf@gmail.com>
References: <20240514131711.379322-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Allow Rust file systems to create regular file inodes backed by the page
cache. The contents of such files are read into folios via `read_folio`.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c                  |  6 +++
 rust/kernel/folio.rs            |  1 -
 rust/kernel/fs/address_space.rs | 40 ++++++++++++++++++--
 rust/kernel/fs/file.rs          |  7 ++++
 rust/kernel/fs/inode.rs         | 20 +++++++++-
 samples/rust/rust_rofs.rs       | 67 ++++++++++++++++++++++++++-------
 6 files changed, 122 insertions(+), 19 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index acff58e6caff..2db5df578df2 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -282,6 +282,12 @@ loff_t rust_helper_i_size_read(const struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(rust_helper_i_size_read);
 
+void rust_helper_mapping_set_large_folios(struct address_space *mapping)
+{
+	mapping_set_large_folios(mapping);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mapping_set_large_folios);
+
 unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
 				       unsigned long n)
 {
diff --git a/rust/kernel/folio.rs b/rust/kernel/folio.rs
index 20f51db920e4..077328b733e4 100644
--- a/rust/kernel/folio.rs
+++ b/rust/kernel/folio.rs
@@ -49,7 +49,6 @@ impl<S> Folio<S> {
     /// Callers must ensure that:
     /// * `ptr` is valid and remains so for the lifetime of the returned reference.
     /// * The folio has the right state.
-    #[allow(dead_code)]
     pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::folio) -> &'a Self {
         // SAFETY: The safety requirements guarantee that the cast below is ok.
         unsafe { &*ptr.cast::<Self>() }
diff --git a/rust/kernel/fs/address_space.rs b/rust/kernel/fs/address_space.rs
index 5b4fcb568f46..e539d690235b 100644
--- a/rust/kernel/fs/address_space.rs
+++ b/rust/kernel/fs/address_space.rs
@@ -6,8 +6,9 @@
 //!
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
 
-use super::FileSystem;
-use crate::bindings;
+use super::{file::File, FileSystem};
+use crate::error::{from_result, Result};
+use crate::{bindings, folio::Folio, folio::PageCache, types::Locked};
 use core::marker::PhantomData;
 use macros::vtable;
 
@@ -16,10 +17,15 @@
 pub trait Operations {
     /// File system that these operations are compatible with.
     type FileSystem: FileSystem + ?Sized;
+
+    /// Reads the contents of the inode into the given folio.
+    fn read_folio(
+        file: Option<&File<Self::FileSystem>>,
+        folio: Locked<&Folio<PageCache<Self::FileSystem>>>,
+    ) -> Result;
 }
 
 /// Represents address space operations.
-#[allow(dead_code)]
 pub struct Ops<T: FileSystem + ?Sized>(
     pub(crate) *const bindings::address_space_operations,
     pub(crate) PhantomData<T>,
@@ -32,7 +38,11 @@ pub const fn new<U: Operations<FileSystem = T> + ?Sized>() -> Self {
         impl<T: Operations + ?Sized> Table<T> {
             const TABLE: bindings::address_space_operations = bindings::address_space_operations {
                 writepage: None,
-                read_folio: None,
+                read_folio: if T::HAS_READ_FOLIO {
+                    Some(Self::read_folio_callback)
+                } else {
+                    None
+                },
                 writepages: None,
                 dirty_folio: None,
                 readahead: None,
@@ -52,6 +62,28 @@ impl<T: Operations + ?Sized> Table<T> {
                 swap_deactivate: None,
                 swap_rw: None,
             };
+
+            extern "C" fn read_folio_callback(
+                file_ptr: *mut bindings::file,
+                folio_ptr: *mut bindings::folio,
+            ) -> i32 {
+                from_result(|| {
+                    let file = if file_ptr.is_null() {
+                        None
+                    } else {
+                        // SAFETY: The C API guarantees that `file_ptr` is a valid file if non-null.
+                        Some(unsafe { File::from_raw(file_ptr) })
+                    };
+
+                    // SAFETY: The C API guarantees that `folio_ptr` is a valid folio.
+                    let folio = unsafe { Folio::from_raw(folio_ptr) };
+
+                    // SAFETY: The C contract guarantees that the folio is valid and locked, with
+                    // ownership of the lock transferred to the callee (this function).
+                    T::read_folio(file, unsafe { Locked::new(folio) })?;
+                    Ok(0)
+                })
+            }
         }
         Self(&Table::<U>::TABLE, PhantomData)
     }
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 2ba456a1eee1..0828676eae1c 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -355,6 +355,12 @@ fn read_dir(
 pub struct Ops<T: FileSystem + ?Sized>(pub(crate) *const bindings::file_operations, PhantomData<T>);
 
 impl<T: FileSystem + ?Sized> Ops<T> {
+    /// Returns file operations for page-cache-based ro files.
+    pub fn generic_ro_file() -> Self {
+        // SAFETY: This is a constant in C, it never changes.
+        Self(unsafe { &bindings::generic_ro_fops }, PhantomData)
+    }
+
     /// Creates file operations from a type that implements the [`Operations`] trait.
     pub const fn new<U: Operations<FileSystem = T> + ?Sized>() -> Self {
         struct Table<T: Operations + ?Sized>(PhantomData<T>);
@@ -516,6 +522,7 @@ impl From<inode::Type> for DirEntryType {
     fn from(value: inode::Type) -> Self {
         match value {
             inode::Type::Dir => DirEntryType::Dir,
+            inode::Type::Reg => DirEntryType::Reg,
         }
     }
 }
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index c314d036c87e..1a41c824d30d 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -6,7 +6,9 @@
 //!
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
 
-use super::{dentry, dentry::DEntry, file, sb::SuperBlock, FileSystem, Offset, UnspecifiedFS};
+use super::{
+    address_space, dentry, dentry::DEntry, file, sb::SuperBlock, FileSystem, Offset, UnspecifiedFS,
+};
 use crate::error::{code::*, Result};
 use crate::types::{ARef, AlwaysRefCounted, Lockable, Locked, Opaque};
 use crate::{bindings, block, time::Timespec};
@@ -127,6 +129,11 @@ pub fn init(mut self, params: Params) -> Result<ARef<INode<T>>> {
         let inode = unsafe { self.0.as_mut() };
         let mode = match params.typ {
             Type::Dir => bindings::S_IFDIR,
+            Type::Reg => {
+                // SAFETY: The `i_mapping` pointer doesn't change and is valid.
+                unsafe { bindings::mapping_set_large_folios(inode.i_mapping) };
+                bindings::S_IFREG
+            }
         };
 
         inode.i_mode = (params.mode & 0o777) | u16::try_from(mode)?;
@@ -166,6 +173,14 @@ pub fn set_fops(&mut self, fops: file::Ops<T>) -> &mut Self {
         inode.__bindgen_anon_3.i_fop = fops.0;
         self
     }
+
+    /// Sets the address space operations on this new inode.
+    pub fn set_aops(&mut self, aops: address_space::Ops<T>) -> &mut Self {
+        // SAFETY: By the type invariants, it's ok to modify the inode.
+        let inode = unsafe { self.0.as_mut() };
+        inode.i_data.a_ops = aops.0;
+        self
+    }
 }
 
 impl<T: FileSystem + ?Sized> Drop for New<T> {
@@ -181,6 +196,9 @@ fn drop(&mut self) {
 pub enum Type {
     /// Directory type.
     Dir,
+
+    /// Regular file type.
+    Reg,
 }
 
 /// Required inode parameters.
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 2a87e524e0e1..8005fd14b2e1 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -3,10 +3,11 @@
 //! Rust read-only file system sample.
 
 use kernel::fs::{
-    dentry, dentry::DEntry, file, file::File, inode, inode::INode, sb::SuperBlock, Offset,
+    address_space, dentry, dentry::DEntry, file, file::File, inode, inode::INode, sb, Offset,
 };
 use kernel::prelude::*;
-use kernel::{c_str, fs, time::UNIX_EPOCH, types::ARef, types::Either, types::Locked, user};
+use kernel::types::{ARef, Either, Locked};
+use kernel::{c_str, folio::Folio, folio::PageCache, fs, time::UNIX_EPOCH, user};
 
 kernel::module_fs! {
     type: RoFs,
@@ -20,6 +21,7 @@ struct Entry {
     name: &'static [u8],
     ino: u64,
     etype: inode::Type,
+    contents: &'static [u8],
 }
 
 const ENTRIES: [Entry; 3] = [
@@ -27,41 +29,53 @@ struct Entry {
         name: b".",
         ino: 1,
         etype: inode::Type::Dir,
+        contents: b"",
     },
     Entry {
         name: b"..",
         ino: 1,
         etype: inode::Type::Dir,
+        contents: b"",
     },
     Entry {
-        name: b"subdir",
+        name: b"test.txt",
         ino: 2,
-        etype: inode::Type::Dir,
+        etype: inode::Type::Reg,
+        contents: b"hello world\n",
     },
 ];
 
 const DIR_FOPS: file::Ops<RoFs> = file::Ops::new::<RoFs>();
 const DIR_IOPS: inode::Ops<RoFs> = inode::Ops::new::<RoFs>();
+const FILE_AOPS: address_space::Ops<RoFs> = address_space::Ops::new::<RoFs>();
 
 struct RoFs;
 
 impl RoFs {
-    fn iget(sb: &SuperBlock<Self>, e: &'static Entry) -> Result<ARef<INode<Self>>> {
+    fn iget(sb: &sb::SuperBlock<Self>, e: &'static Entry) -> Result<ARef<INode<Self>>> {
         let mut new = match sb.get_or_create_inode(e.ino)? {
             Either::Left(existing) => return Ok(existing),
             Either::Right(new) => new,
         };
 
-        match e.etype {
-            inode::Type::Dir => new.set_iops(DIR_IOPS).set_fops(DIR_FOPS),
+        let (mode, nlink, size) = match e.etype {
+            inode::Type::Dir => {
+                new.set_iops(DIR_IOPS).set_fops(DIR_FOPS);
+                (0o555, 2, ENTRIES.len().try_into()?)
+            }
+            inode::Type::Reg => {
+                new.set_fops(file::Ops::generic_ro_file())
+                    .set_aops(FILE_AOPS);
+                (0o444, 1, e.contents.len().try_into()?)
+            }
         };
 
         new.init(inode::Params {
             typ: e.etype,
-            mode: 0o555,
-            size: ENTRIES.len().try_into()?,
-            blocks: 1,
-            nlink: 2,
+            mode,
+            size,
+            blocks: (u64::try_from(size)? + 511) / 512,
+            nlink,
             uid: 0,
             gid: 0,
             atime: UNIX_EPOCH,
@@ -74,12 +88,12 @@ fn iget(sb: &SuperBlock<Self>, e: &'static Entry) -> Result<ARef<INode<Self>>> {
 impl fs::FileSystem for RoFs {
     const NAME: &'static CStr = c_str!("rust_rofs");
 
-    fn fill_super(sb: &mut SuperBlock<Self>) -> Result {
+    fn fill_super(sb: &mut sb::SuperBlock<Self>) -> Result {
         sb.set_magic(0x52555354);
         Ok(())
     }
 
-    fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
+    fn init_root(sb: &sb::SuperBlock<Self>) -> Result<dentry::Root<Self>> {
         let inode = Self::iget(sb, &ENTRIES[0])?;
         dentry::Root::try_new(inode)
     }
@@ -109,6 +123,33 @@ fn lookup(
     }
 }
 
+#[vtable]
+impl address_space::Operations for RoFs {
+    type FileSystem = Self;
+
+    fn read_folio(_: Option<&File<Self>>, mut folio: Locked<&Folio<PageCache<Self>>>) -> Result {
+        let data = match folio.inode().ino() {
+            2 => ENTRIES[2].contents,
+            _ => return Err(EINVAL),
+        };
+
+        let pos = usize::try_from(folio.pos()).unwrap_or(usize::MAX);
+        let copied = if pos >= data.len() {
+            0
+        } else {
+            let to_copy = core::cmp::min(data.len() - pos, folio.size());
+            folio.write(0, &data[pos..][..to_copy])?;
+            to_copy
+        };
+
+        folio.zero_out(copied, folio.size() - copied)?;
+        folio.mark_uptodate();
+        folio.flush_dcache();
+
+        Ok(())
+    }
+}
+
 #[vtable]
 impl file::Operations for RoFs {
     type FileSystem = Self;
-- 
2.34.1


