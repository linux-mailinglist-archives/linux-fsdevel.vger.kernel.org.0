Return-Path: <linux-fsdevel+bounces-19445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288178C5709
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAA21F230A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6FE15CD5C;
	Tue, 14 May 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwqIuUQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D415A49F;
	Tue, 14 May 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692685; cv=none; b=brggDZ8pmidKKJHpWuYdGnxOiyh3JfvC/MWYX7/MPBUUwWfrgF2m8ohDuJlGvD5QGcdiTxNANsDMzXkOPIj80RvEYNQsUIqGT+QBMKN0iodA4dGgm/hmNcLSKsTB0zR88CTZH/NNl5XV8fgajHkxJ3b4rXaZhxvU3MRQ+J3rEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692685; c=relaxed/simple;
	bh=ZhtDkz8UOLR97RnukFHRGunVhnN/R3NSPvjQ2sWx2GY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gluVMDletcJ+XO2zaRpjvlb1gtonYGAL8093WtwI/7znWULRhbes12ZW0Ai//mQuSt9EwuUyDH0vOJbXay3jAb1ErwmWS7BTJvrLsBdgB5/ND2itClSgPR+HIesgABR01GU3ns4o354LX/6fYghZSRWOMApfuP+6YybX3EEsXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwqIuUQp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eecc71311eso46832195ad.3;
        Tue, 14 May 2024 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692682; x=1716297482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp5gsASxdoGRSDEZiV9AJvmVQW1l9r+kB3byBBeTAfE=;
        b=QwqIuUQpnGU0SDqhEasWd+lmj0W6Bse/Pk7zNmUSBJvSd/oBgSs4GOKSY0jdKV4hAF
         xqS3el6OC6j21QxKb26RdfqLY8C06a2DdQUd5oYk65htl3P86DJh1iJZIExSMAGpvwp+
         UPx5SA5QqjDKzBesDPVDi/fc6M0wiJ4hE/fCTLSEeKlQRVnHmRle3vKVXc7xr3mvB57u
         10+bccPHsw8niQDto4FTkMUxyqzqju27jaoBhiDyjGbynKjL1PurCQqV/yjM+K9zECvI
         BU2pVGZ9fUTDJgzBEsaiD7EuGgqnOiJUn6D8TPYBt63DxkhqZyMPW+yQv7glJN/6a+23
         kD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692682; x=1716297482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp5gsASxdoGRSDEZiV9AJvmVQW1l9r+kB3byBBeTAfE=;
        b=d5Ax0SJRQdtA4MdIE4fqyMsUGqucsXmCckkAybwyeOHujY6IJum8ZJQbJUPNOKFqkG
         GlXu7TZUJOMpBeIdV49RANtL4KSf3lQHIw5R7F3EUiNDw1Q5lrJOOAK+cXotwhMr8B1V
         sXTXAOctvWbr8iSymRg2OS3SZxRGkiMrKrUzJCkkQVkXu6R6MmnNXzCVZwoYxi7+Pymx
         NcUo25c54lkbX6t9ExMtlivabH1jxghWns100beb3IV6cCcJjGMAvTSaOgbvuJKIyYta
         j878DvL6voHI+TsSC6brODAOWpxHkkNzSEQvc3JOh5HBjEsuhX2x673Fte+G+XDuJOiW
         //Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX00398ULyGkMV25u9ub7MyrXxRA9YboffNCywQARu/nqIQKegMkzcDSVSlZRrbBiUH0zWjkNDL/8n6THVlo4RniCmq4uRv0sK45XPzTpxlZqkiTOqOFVgefF05aRIx0vl6kl2+2rheb5HfQZX07sBRl6h1DSe6L3aT2i8geMoHTGMEdWlylY+WE0ov
X-Gm-Message-State: AOJu0YzddBV5xJ6J0+RoSG2zVQY9vaCm55iJMC6SSW3usuhrmkSexuyC
	9rxH2WeZKDtU1Z5hsqX4Kqkb3K4uhQTQOw3W0Vwja3tvtEQ+PIo9
X-Google-Smtp-Source: AGHT+IGpWRC30NXviFcJi/80gURNQ5j0Zh8nsXZ8artk0J4li4OHh4Nga5gTbj1YVpehDxLjszrvnQ==
X-Received: by 2002:a17:902:8c96:b0:1eb:fc2:1eed with SMTP id d9443c01a7336-1ef43e27b96mr155157355ad.41.1715692682065;
        Tue, 14 May 2024 06:18:02 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:18:01 -0700 (PDT)
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
Subject: [RFC PATCH v2 23/30] rust: fs: allow file systems backed by a block device
Date: Tue, 14 May 2024 10:17:04 -0300
Message-Id: <20240514131711.379322-24-wedsonaf@gmail.com>
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

Allow Rust file systems that are backed by block devices (in addition to
in-memory ones).

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c            |  14 +++
 rust/kernel/block.rs      |   1 -
 rust/kernel/fs.rs         |  60 ++++++++---
 rust/kernel/fs/inode.rs   | 221 +++++++++++++++++++++++++++++++++++++-
 rust/kernel/fs/sb.rs      |  49 ++++++++-
 samples/rust/rust_rofs.rs |   2 +-
 6 files changed, 328 insertions(+), 19 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 360a1d38ac19..6c6d18df055f 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -21,6 +21,7 @@
  */
 
 #include <kunit/test-bug.h>
+#include <linux/blkdev.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/cacheflush.h>
@@ -258,6 +259,13 @@ void rust_helper_kunmap_local(const void *vaddr)
 }
 EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
 
+struct folio *rust_helper_read_mapping_folio(struct address_space *mapping,
+					     pgoff_t index, struct file *file)
+{
+	return read_mapping_folio(mapping, index, file);
+}
+EXPORT_SYMBOL_GPL(rust_helper_read_mapping_folio);
+
 void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
 {
 	i_uid_write(inode, uid);
@@ -294,6 +302,12 @@ unsigned int rust_helper_MKDEV(unsigned int major, unsigned int minor)
 }
 EXPORT_SYMBOL_GPL(rust_helper_MKDEV);
 
+sector_t rust_helper_bdev_nr_sectors(struct block_device *bdev)
+{
+	return bdev_nr_sectors(bdev);
+}
+EXPORT_SYMBOL_GPL(rust_helper_bdev_nr_sectors);
+
 unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
 				       unsigned long n)
 {
diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 868623d7c873..4d669bd5dce9 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -31,7 +31,6 @@ impl Device {
     ///
     /// Callers must ensure that `ptr` is valid and remains so for the lifetime of the returned
     /// object.
-    #[allow(dead_code)]
     pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::block_device) -> &'a Self {
         // SAFETY: The safety requirements guarantee that the cast below is ok.
         unsafe { &*ptr.cast::<Self>() }
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 387e87e3edaf..864aca24d12c 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -26,6 +26,11 @@
 /// This is C's `loff_t`.
 pub type Offset = i64;
 
+/// An index into the page cache.
+///
+/// This is C's `pgoff_t`.
+pub type PageOffset = usize;
+
 /// Maximum size of an inode.
 pub const MAX_LFS_FILESIZE: Offset = bindings::MAX_LFS_FILESIZE;
 
@@ -37,6 +42,9 @@ pub trait FileSystem {
     /// The name of the file system type.
     const NAME: &'static CStr;
 
+    /// Determines how superblocks for this file system type are keyed.
+    const SUPER_TYPE: sb::Type = sb::Type::Independent;
+
     /// Determines if an implementation doesn't specify the required types.
     ///
     /// This is meant for internal use only.
@@ -44,7 +52,10 @@ pub trait FileSystem {
     const IS_UNSPECIFIED: bool = false;
 
     /// Initialises the new superblock and returns the data to attach to it.
-    fn fill_super(sb: &mut SuperBlock<Self, sb::New>) -> Result<Self::Data>;
+    fn fill_super(
+        sb: &mut SuperBlock<Self, sb::New>,
+        mapper: Option<inode::Mapper>,
+    ) -> Result<Self::Data>;
 
     /// Initialises and returns the root inode of the given superblock.
     ///
@@ -100,7 +111,7 @@ impl FileSystem for UnspecifiedFS {
     type Data = ();
     const NAME: &'static CStr = crate::c_str!("unspecified");
     const IS_UNSPECIFIED: bool = true;
-    fn fill_super(_: &mut SuperBlock<Self, sb::New>) -> Result {
+    fn fill_super(_: &mut SuperBlock<Self, sb::New>, _: Option<inode::Mapper>) -> Result {
         Err(ENOTSUPP)
     }
 
@@ -139,7 +150,9 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
                 fs.name = T::NAME.as_char_ptr();
                 fs.init_fs_context = Some(Self::init_fs_context_callback::<T>);
                 fs.kill_sb = Some(Self::kill_sb_callback::<T>);
-                fs.fs_flags = 0;
+                fs.fs_flags = if let sb::Type::BlockDev = T::SUPER_TYPE {
+                    bindings::FS_REQUIRES_DEV as i32
+                } else { 0 };
 
                 // SAFETY: Pointers stored in `fs` are static so will live for as long as the
                 // registration is active (it is undone in `drop`).
@@ -162,9 +175,16 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
     unsafe extern "C" fn kill_sb_callback<T: FileSystem + ?Sized>(
         sb_ptr: *mut bindings::super_block,
     ) {
-        // SAFETY: In `get_tree_callback` we always call `get_tree_nodev`, so `kill_anon_super` is
-        // the appropriate function to call for cleanup.
-        unsafe { bindings::kill_anon_super(sb_ptr) };
+        match T::SUPER_TYPE {
+            // SAFETY: In `get_tree_callback` we always call `get_tree_bdev` for
+            // `sb::Type::BlockDev`, so `kill_block_super` is the appropriate function to call
+            // for cleanup.
+            sb::Type::BlockDev => unsafe { bindings::kill_block_super(sb_ptr) },
+            // SAFETY: In `get_tree_callback` we always call `get_tree_nodev` for
+            // `sb::Type::Independent`, so `kill_anon_super` is the appropriate function to call
+            // for cleanup.
+            sb::Type::Independent => unsafe { bindings::kill_anon_super(sb_ptr) },
+        }
 
         // SAFETY: The C API contract guarantees that `sb_ptr` is valid for read.
         let ptr = unsafe { (*sb_ptr).s_fs_info };
@@ -200,9 +220,18 @@ impl<T: FileSystem + ?Sized> Tables<T> {
     };
 
     unsafe extern "C" fn get_tree_callback(fc: *mut bindings::fs_context) -> ffi::c_int {
-        // SAFETY: `fc` is valid per the callback contract. `fill_super_callback` also has
-        // the right type and is a valid callback.
-        unsafe { bindings::get_tree_nodev(fc, Some(Self::fill_super_callback)) }
+        match T::SUPER_TYPE {
+            // SAFETY: `fc` is valid per the callback contract. `fill_super_callback` also has
+            // the right type and is a valid callback.
+            sb::Type::BlockDev => unsafe {
+                bindings::get_tree_bdev(fc, Some(Self::fill_super_callback))
+            },
+            // SAFETY: `fc` is valid per the callback contract. `fill_super_callback` also has
+            // the right type and is a valid callback.
+            sb::Type::Independent => unsafe {
+                bindings::get_tree_nodev(fc, Some(Self::fill_super_callback))
+            },
+        }
     }
 
     unsafe extern "C" fn fill_super_callback(
@@ -221,7 +250,14 @@ impl<T: FileSystem + ?Sized> Tables<T> {
             sb.s_xattr = &Tables::<T>::XATTR_HANDLERS[0];
             sb.s_flags |= bindings::SB_RDONLY;
 
-            let data = T::fill_super(new_sb)?;
+            let mapper = if matches!(T::SUPER_TYPE, sb::Type::BlockDev) {
+                // SAFETY: This is the only mapper created for this inode, so it is unique.
+                Some(unsafe { new_sb.bdev().inode().mapper() })
+            } else {
+                None
+            };
+
+            let data = T::fill_super(new_sb, mapper)?;
 
             // N.B.: Even on failure, `kill_sb` is called and frees the data.
             sb.s_fs_info = data.into_foreign().cast_mut();
@@ -369,7 +405,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///
 /// ```
 /// # mod module_fs_sample {
-/// use kernel::fs::{dentry, inode::INode, sb, sb::SuperBlock, self};
+/// use kernel::fs::{dentry, inode::INode, inode::Mapper, sb, sb::SuperBlock, self};
 /// use kernel::prelude::*;
 ///
 /// kernel::module_fs! {
@@ -384,7 +420,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 /// impl fs::FileSystem for MyFs {
 ///     type Data = ();
 ///     const NAME: &'static CStr = kernel::c_str!("myfs");
-///     fn fill_super(_: &mut SuperBlock<Self, sb::New>) -> Result {
+///     fn fill_super(_: &mut SuperBlock<Self, sb::New>, _: Option<Mapper>) -> Result {
 ///         todo!()
 ///     }
 ///     fn init_root(_sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index 75b68d697a6e..5b3602362521 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -7,13 +7,16 @@
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
 
 use super::{
-    address_space, dentry, dentry::DEntry, file, sb::SuperBlock, FileSystem, Offset, UnspecifiedFS,
+    address_space, dentry, dentry::DEntry, file, sb::SuperBlock, FileSystem, Offset, PageOffset,
+    UnspecifiedFS,
 };
-use crate::error::{code::*, Result};
+use crate::error::{code::*, from_err_ptr, Result};
 use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Lockable, Locked, Opaque};
-use crate::{bindings, block, str::CStr, str::CString, time::Timespec};
+use crate::{
+    bindings, block, build_error, folio, folio::Folio, str::CStr, str::CString, time::Timespec,
+};
 use core::mem::ManuallyDrop;
-use core::{marker::PhantomData, ptr};
+use core::{cmp, marker::PhantomData, ops::Deref, ptr};
 use macros::vtable;
 
 /// The number of an inode.
@@ -93,6 +96,129 @@ pub fn size(&self) -> Offset {
         // SAFETY: `self` is guaranteed to be valid by the existence of a shared reference.
         unsafe { bindings::i_size_read(self.0.get()) }
     }
+
+    /// Returns a mapper for this inode.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that mappers are unique for a given inode and range. For inodes that
+    /// back a block device, a mapper is always created when the filesystem is mounted; so callers
+    /// in such situations must ensure that that mapper is never used.
+    pub unsafe fn mapper(&self) -> Mapper<T> {
+        Mapper {
+            inode: self.into(),
+            begin: 0,
+            end: Offset::MAX,
+        }
+    }
+
+    /// Returns a mapped folio at the given offset.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that there are no concurrent mutable mappings of the folio.
+    pub unsafe fn mapped_folio(
+        &self,
+        offset: Offset,
+    ) -> Result<folio::Mapped<'_, folio::PageCache<T>>> {
+        let page_index = offset >> bindings::PAGE_SHIFT;
+        let page_offset = offset & ((bindings::PAGE_SIZE - 1) as Offset);
+        let folio = self.read_mapping_folio(page_index.try_into()?)?;
+
+        // SAFETY: The safety requirements guarantee that there are no concurrent mutable mappings
+        // of the folio.
+        unsafe { Folio::map_owned(folio, page_offset.try_into()?) }
+    }
+
+    /// Returns the folio at the given page index.
+    pub fn read_mapping_folio(
+        &self,
+        index: PageOffset,
+    ) -> Result<ARef<Folio<folio::PageCache<T>>>> {
+        let folio = from_err_ptr(unsafe {
+            bindings::read_mapping_folio(
+                (*self.0.get()).i_mapping,
+                index.try_into()?,
+                ptr::null_mut(),
+            )
+        })?;
+        let ptr = ptr::NonNull::new(folio)
+            .ok_or(EIO)?
+            .cast::<Folio<folio::PageCache<T>>>();
+        // SAFETY: The folio returned by read_mapping_folio has had its refcount incremented.
+        Ok(unsafe { ARef::from_raw(ptr) })
+    }
+
+    /// Iterate over the given range, one folio at a time.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that there are no concurrent mutable mappings of the folio.
+    pub unsafe fn for_each_page<U>(
+        &self,
+        first: Offset,
+        len: Offset,
+        mut cb: impl FnMut(&[u8]) -> Result<Option<U>>,
+    ) -> Result<Option<U>> {
+        if first >= self.size() {
+            return Ok(None);
+        }
+        let mut remain = cmp::min(len, self.size() - first);
+        first.checked_add(remain).ok_or(EIO)?;
+
+        let mut next = first;
+        while remain > 0 {
+            // SAFETY: The safety requirements of this function satisfy those of `mapped_folio`.
+            let data = unsafe { self.mapped_folio(next)? };
+            let avail = cmp::min(data.len(), remain.try_into().unwrap_or(usize::MAX));
+            let ret = cb(&data[..avail])?;
+            if ret.is_some() {
+                return Ok(ret);
+            }
+
+            next += avail as Offset;
+            remain -= avail as Offset;
+        }
+
+        Ok(None)
+    }
+}
+
+impl<T: FileSystem + ?Sized, U: Deref<Target = INode<T>>> Locked<U, ReadSem> {
+    /// Returns a mapped folio at the given offset.
+    // TODO: This conflicts with Locked<Folio>::write. Once we settle on a way to handle reading
+    // the contents of certain inodes (e.g., directories, links), then we switch to that and
+    // remove this.
+    pub fn mapped_folio<'a>(
+        &'a self,
+        offset: Offset,
+    ) -> Result<folio::Mapped<'a, folio::PageCache<T>>>
+    where
+        T: 'a,
+    {
+        if T::IS_UNSPECIFIED {
+            build_error!("unspecified file systems cannot safely map folios");
+        }
+
+        // SAFETY: The inode is locked in read mode, so it's ok to map its contents.
+        unsafe { self.deref().mapped_folio(offset) }
+    }
+
+    /// Iterate over the given range, one folio at a time.
+    // TODO: This has the same issue as mapped_folio above.
+    pub fn for_each_page<V>(
+        &self,
+        first: Offset,
+        len: Offset,
+        cb: impl FnMut(&[u8]) -> Result<Option<V>>,
+    ) -> Result<Option<V>> {
+        if T::IS_UNSPECIFIED {
+            build_error!("unspecified file systems cannot safely map folios");
+        }
+
+        // SAFETY: The inode is locked in read mode, so it's ok to map its contents.
+        unsafe { self.deref().for_each_page(first, len, cb) }
+    }
 }
 
 // SAFETY: The type invariants guarantee that `INode` is always ref-counted.
@@ -111,6 +237,7 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
 /// Indicates that the an inode's rw semapahore is locked in read (shared) mode.
 pub struct ReadSem;
 
+// SAFETY: `raw_lock` calls `inode_lock_shared` which locks the inode in shared mode.
 unsafe impl<T: FileSystem + ?Sized> Lockable<ReadSem> for INode<T> {
     fn raw_lock(&self) {
         // SAFETY: Since there's a reference to the inode, it must be valid.
@@ -432,3 +559,89 @@ extern "C" fn drop_cstring(ptr: *mut core::ffi::c_void) {
         Self(&Table::<U>::TABLE, PhantomData)
     }
 }
+
+/// Allows mapping the contents of the inode.
+///
+/// # Invariants
+///
+/// Mappers are unique per range per inode.
+pub struct Mapper<T: FileSystem + ?Sized = UnspecifiedFS> {
+    inode: ARef<INode<T>>,
+    begin: Offset,
+    end: Offset,
+}
+
+// SAFETY: All inode and folio operations are safe from any thread.
+unsafe impl<T: FileSystem + ?Sized> Send for Mapper<T> {}
+
+// SAFETY: All inode and folio operations are safe from any thread.
+unsafe impl<T: FileSystem + ?Sized> Sync for Mapper<T> {}
+
+impl<T: FileSystem + ?Sized> Mapper<T> {
+    /// Splits the mapper into two ranges.
+    ///
+    /// The first range is from the beginning of `self` up to and including `offset - 1`. The
+    /// second range is from `offset` to the end of `self`.
+    pub fn split_at(mut self, offset: Offset) -> (Self, Self) {
+        let inode = self.inode.clone();
+        if offset <= self.begin {
+            (
+                Self {
+                    inode,
+                    begin: offset,
+                    end: offset,
+                },
+                self,
+            )
+        } else if offset >= self.end {
+            (
+                self,
+                Self {
+                    inode,
+                    begin: offset,
+                    end: offset,
+                },
+            )
+        } else {
+            let end = self.end;
+            self.end = offset;
+            (
+                self,
+                Self {
+                    inode,
+                    begin: offset,
+                    end,
+                },
+            )
+        }
+    }
+
+    /// Returns a mapped folio at the given offset.
+    pub fn mapped_folio(&self, offset: Offset) -> Result<folio::Mapped<'_, folio::PageCache<T>>> {
+        if offset < self.begin || offset >= self.end {
+            return Err(ERANGE);
+        }
+
+        // SAFETY: By the type invariant, there are no other mutable mappings of the folio.
+        let mut map = unsafe { self.inode.mapped_folio(offset) }?;
+        map.cap_len((self.end - offset).try_into()?);
+        Ok(map)
+    }
+
+    /// Iterate over the given range, one folio at a time.
+    pub fn for_each_page<U>(
+        &self,
+        first: Offset,
+        len: Offset,
+        cb: impl FnMut(&[u8]) -> Result<Option<U>>,
+    ) -> Result<Option<U>> {
+        if first < self.begin || first >= self.end {
+            return Err(ERANGE);
+        }
+
+        let actual_len = cmp::min(len, self.end - first);
+
+        // SAFETY: By the type invariant, there are no other mutable mappings of the folio.
+        unsafe { self.inode.for_each_page(first, actual_len, cb) }
+    }
+}
diff --git a/rust/kernel/fs/sb.rs b/rust/kernel/fs/sb.rs
index 7c0c52e6da0a..93c7b2770163 100644
--- a/rust/kernel/fs/sb.rs
+++ b/rust/kernel/fs/sb.rs
@@ -8,11 +8,22 @@
 
 use super::inode::{self, INode, Ino};
 use super::FileSystem;
-use crate::bindings;
 use crate::error::{code::*, Result};
 use crate::types::{ARef, Either, ForeignOwnable, Opaque};
+use crate::{bindings, block, build_error};
 use core::{marker::PhantomData, ptr};
 
+/// Type of superblock keying.
+///
+/// It determines how C's `fs_context_operations::get_tree` is implemented.
+pub enum Type {
+    /// Multiple independent superblocks may exist.
+    Independent,
+
+    /// Uses a block device.
+    BlockDev,
+}
+
 /// A typestate for [`SuperBlock`] that indicates that it's a new one, so not fully initialized
 /// yet.
 pub struct New;
@@ -75,6 +86,28 @@ pub fn rdonly(&self) -> bool {
         // SAFETY: `s_flags` only changes during init, so it is safe to read it.
         unsafe { (*self.0.get()).s_flags & bindings::SB_RDONLY != 0 }
     }
+
+    /// Returns the block device associated with the superblock.
+    pub fn bdev(&self) -> &block::Device {
+        if !matches!(T::SUPER_TYPE, Type::BlockDev) {
+            build_error!("bdev is only available in blockdev superblocks");
+        }
+
+        // SAFETY: The superblock is valid and given that it's a blockdev superblock it must have a
+        // valid `s_bdev` that remains valid while the superblock (`self`) is valid.
+        unsafe { block::Device::from_raw((*self.0.get()).s_bdev) }
+    }
+
+    /// Returns the number of sectors in the underlying block device.
+    pub fn sector_count(&self) -> block::Sector {
+        if !matches!(T::SUPER_TYPE, Type::BlockDev) {
+            build_error!("sector_count is only available in blockdev superblocks");
+        }
+
+        // SAFETY: The superblock is valid and given that it's a blockdev superblock it must have a
+        // valid `s_bdev`.
+        unsafe { bindings::bdev_nr_sectors((*self.0.get()).s_bdev) }
+    }
 }
 
 impl<T: FileSystem + ?Sized> SuperBlock<T, New> {
@@ -85,6 +118,20 @@ pub fn set_magic(&mut self, magic: usize) -> &mut Self {
         unsafe { (*self.0.get()).s_magic = magic as core::ffi::c_ulong };
         self
     }
+
+    /// Sets the device blocksize, subjected to the minimum accepted by the device.
+    ///
+    /// Returns the actual value set.
+    pub fn min_blocksize(&mut self, size: i32) -> i32 {
+        if !matches!(T::SUPER_TYPE, Type::BlockDev) {
+            build_error!("min_blocksize is only available in blockdev superblocks");
+        }
+
+        // SAFETY: This a new superblock that is being initialised, so it it's ok to set the block
+        // size. Additionally, we've checked that this is the superblock is backed by a block
+        // device, so it is also valid.
+        unsafe { bindings::sb_min_blocksize(self.0.get(), size) }
+    }
 }
 
 impl<T: FileSystem + ?Sized, S: DataInited> SuperBlock<T, S> {
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 7027ca067f8f..fea3360b6e7a 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -101,7 +101,7 @@ impl fs::FileSystem for RoFs {
     type Data = ();
     const NAME: &'static CStr = c_str!("rust_rofs");
 
-    fn fill_super(sb: &mut sb::SuperBlock<Self, sb::New>) -> Result {
+    fn fill_super(sb: &mut sb::SuperBlock<Self, sb::New>, _: Option<inode::Mapper>) -> Result {
         sb.set_magic(0x52555354);
         Ok(())
     }
-- 
2.34.1


