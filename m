Return-Path: <linux-fsdevel+bounces-19429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2F18C56E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D3C1F22D87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B27147C79;
	Tue, 14 May 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9zodidV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D01465B1;
	Tue, 14 May 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692668; cv=none; b=pngYHNj7lO3uiPwyP8ZFz6gkXongHxLQ0dfPaWGMFuBgPfQw5l2gx5JSa2QuYWap7JdQKEvjjX1ittMy9r6LoFsLe/j/CExTX62gTVw9UWZnP2g/Hk1dBBk3c5vXxAR9k1vMrXJAIlblf0EYI6ECIZtu0po4BfEQUcmiwmhNcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692668; c=relaxed/simple;
	bh=96ZscxFcekwLOU1G/Ob62zVtXDhnn2IgCI17Vhgumoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pd7bVmAF8yXnNTOVOJ+nDkDJfUF//71r/QkDCZS0sz1ev1/M5hKlFKcsHgmFoMnnj7yWhAO5P4py+/xgW9b70EZ6LuAxJvQt8yHpxthOFNg+7PbXAzh06KY7AuUDveqcaNDwCaN9p9AbHyRvfpT549WZto1NuGkbiks940GJ+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9zodidV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1edfc57ac0cso44971395ad.3;
        Tue, 14 May 2024 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692666; x=1716297466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOZvxCrC9Itj0+EN+G6LfcoJOefBPRrAg+vdgGoRsY4=;
        b=K9zodidVLgIpRMccRRzZUClO5LAvknM7h/RX2zX+b253d8TQs3Cs7sTxlFF6o0JyTP
         dzj12QBckS4CtfecrKk6wapvYTtUQ2ucWdDThql2d4xi/UFUfXcz6Kr6Dh2RJKmGVUxW
         QOXXYEUwO0EGfHh37L15M/xNSZUDL1TCJzIYc6IBk6wzGgLUQFUtn7aaJ5CIz5gre5nW
         gZZ+i+BLsDYM7+kVuhFy+sokSOM0kezahnxxRM1u3sYAUTH8xZP+hejQtYRkIGj71doh
         w1+Yo6Kom2bbxnEAUoI2Og9hBIrs3dSVeYhgayh6WzFySK3YN0zw2KAttawFTCIh2yvj
         HAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692666; x=1716297466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOZvxCrC9Itj0+EN+G6LfcoJOefBPRrAg+vdgGoRsY4=;
        b=nxVgst9HXj8As6a2JilO4OZ6Gk4EIwrkFf8n1mHJja83tZxtxYSGwdQbUg1lIz5vNx
         WkP4dvhO1e1bpPFMHJopIiNfmPCKyWnpHemZ8jXs6PTLLVEx1pwG6N6KqG/NCpQHWhik
         /lGD3ErZrrjyECyXQxwF1lVIRm+ggJtiCS1wQWSOQEJn2Tm0COoLhHjm+aeniRmGfuDK
         H8evdLDG0tT9XZbZE6OjQ7/ckx9MGI1HLkhWkX5oiuzE3u3+Fwws9WgKBa55l/vZyP3o
         sDr+5lO1oqX7F8XeuRjkLjMJukBrNLSSf12AKgAGbN1jGOgbkAak1YiFQxqm5m5CB6il
         hONw==
X-Forwarded-Encrypted: i=1; AJvYcCXPuKweJ+qbWCKJ9eoK0Acw61Ki005I25Y1MWOK2WtHN0u6A0pUesUWSgxh9H87mnfWfEnjotpWtRdmiPDpEv9qcTZgWAAmtbJ7zSKIkqC2YM69FsSD6tifrVjWe+4fm6ebI1sPmdQpzS0g7yfMJ6uyw88a47Z/qquP12Jb4WovPDrt8LfzLMgklyba
X-Gm-Message-State: AOJu0YzN13I59dcqvA7rbmuc7yO7hT1dgJ2MAK1txrHI5Ltx9XF//lxk
	DYRHvd8JrUtKdua4m9zUVSrNiEbXajmFPEjfmN6+wWRaB/wDgE7B
X-Google-Smtp-Source: AGHT+IGyeBYMGLQBdDwZ1lWpcvuan3YvNcfX8WBE9Omp5M7OJ7qekVSXOf7kKkcIZstZ6T6aYUGr+A==
X-Received: by 2002:a17:902:9a95:b0:1e4:7adf:b855 with SMTP id d9443c01a7336-1ef43e23223mr109980805ad.35.1715692665874;
        Tue, 14 May 2024 06:17:45 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:45 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/30] rust: fs: introduce `FileSystem::init_root`
Date: Tue, 14 May 2024 10:16:48 -0300
Message-Id: <20240514131711.379322-8-wedsonaf@gmail.com>
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

Allow Rust file systems to specify their root directory. Also allow them
to create (and do cache lookups of) directory inodes. (More types of
inodes are added in subsequent patches in the series.)

The `inode::New` type ensures that a new inode is properly initialised
before it is marked so. It also facilitates error paths by automatically
marking inodes as failed if they're not properly initialised.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c            |  11 ++++
 rust/kernel/fs.rs         |  56 ++++++++-----------
 rust/kernel/fs/inode.rs   | 111 +++++++++++++++++++++++++++++++++++++-
 rust/kernel/fs/sb.rs      |  48 ++++++++++++++++-
 samples/rust/rust_rofs.rs |  25 +++++++--
 5 files changed, 211 insertions(+), 40 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index c7fe6917251e..87301e1ace65 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -164,6 +164,17 @@ struct file *rust_helper_get_file(struct file *f)
 }
 EXPORT_SYMBOL_GPL(rust_helper_get_file);
 
+void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
+{
+	i_uid_write(inode, uid);
+}
+EXPORT_SYMBOL_GPL(rust_helper_i_uid_write);
+
+void rust_helper_i_gid_write(struct inode *inode, gid_t gid)
+{
+	i_gid_write(inode, gid);
+}
+EXPORT_SYMBOL_GPL(rust_helper_i_gid_write);
 
 struct dentry *rust_helper_dget(struct dentry *dentry)
 {
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 4f07da71e1ec..f32c2f89f781 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -9,7 +9,7 @@
 use crate::error::{code::*, from_result, to_result, Error, Result};
 use crate::types::Opaque;
 use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
-use core::{ffi, marker::PhantomData, pin::Pin};
+use core::{ffi, marker::PhantomData, mem::ManuallyDrop, pin::Pin, ptr};
 use macros::{pin_data, pinned_drop};
 use sb::SuperBlock;
 
@@ -38,6 +38,12 @@ pub trait FileSystem {
 
     /// Initialises the new superblock.
     fn fill_super(sb: &mut SuperBlock<Self>) -> Result;
+
+    /// Initialises and returns the root inode of the given superblock.
+    ///
+    /// This is called during initialisation of a superblock after [`FileSystem::fill_super`] has
+    /// completed successfully.
+    fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>>;
 }
 
 /// A file system that is unspecified.
@@ -51,6 +57,10 @@ impl FileSystem for UnspecifiedFS {
     fn fill_super(_: &mut SuperBlock<Self>) -> Result {
         Err(ENOTSUPP)
     }
+
+    fn init_root(_: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
+        Err(ENOTSUPP)
+    }
 }
 
 /// A registration of a file system.
@@ -154,41 +164,18 @@ impl<T: FileSystem + ?Sized> Tables<T> {
 
             T::fill_super(new_sb)?;
 
-            // The following is scaffolding code that will be removed in a subsequent patch. It is
-            // needed to build a root dentry, otherwise core code will BUG().
-            // SAFETY: `sb` is the superblock being initialised, it is valid for read and write.
-            let inode = unsafe { bindings::new_inode(sb) };
-            if inode.is_null() {
-                return Err(ENOMEM);
-            }
-
-            // SAFETY: `inode` is valid for write.
-            unsafe { bindings::set_nlink(inode, 2) };
+            let root = T::init_root(new_sb)?;
 
-            {
-                // SAFETY: This is a newly-created inode. No other references to it exist, so it is
-                // safe to mutably dereference it.
-                let inode = unsafe { &mut *inode };
-                inode.i_ino = 1;
-                inode.i_mode = (bindings::S_IFDIR | 0o755) as _;
-
-                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
-                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
-
-                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
-                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
+            // Reject root inode if it belongs to a different superblock.
+            if !ptr::eq(root.super_block(), new_sb) {
+                return Err(EINVAL);
             }
 
-            // SAFETY: `d_make_root` requires that `inode` be valid and referenced, which is the
-            // case for this call.
-            //
-            // It takes over the inode, even on failure, so we don't need to clean it up.
-            let dentry = unsafe { bindings::d_make_root(inode) };
-            if dentry.is_null() {
-                return Err(ENOMEM);
-            }
+            let dentry = ManuallyDrop::new(root).0.get();
 
-            sb.s_root = dentry;
+            // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
+            // newly-created (and initialised above) superblock.
+            unsafe { (*sb_ptr).s_root = dentry };
 
             Ok(0)
         })
@@ -253,7 +240,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///
 /// ```
 /// # mod module_fs_sample {
-/// use kernel::fs::{sb::SuperBlock, self};
+/// use kernel::fs::{dentry, inode::INode, sb::SuperBlock, self};
 /// use kernel::prelude::*;
 ///
 /// kernel::module_fs! {
@@ -270,6 +257,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///     fn fill_super(_: &mut SuperBlock<Self>) -> Result {
 ///         todo!()
 ///     }
+///     fn init_root(_sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
+///         todo!()
+///     }
 /// }
 /// # }
 /// ```
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index bcb9c8ce59a9..4ccbb4145918 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -7,8 +7,10 @@
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
 
 use super::{sb::SuperBlock, FileSystem, Offset, UnspecifiedFS};
-use crate::bindings;
-use crate::types::{AlwaysRefCounted, Opaque};
+use crate::error::Result;
+use crate::types::{ARef, AlwaysRefCounted, Opaque};
+use crate::{bindings, block, time::Timespec};
+use core::mem::ManuallyDrop;
 use core::{marker::PhantomData, ptr};
 
 /// The number of an inode.
@@ -76,3 +78,108 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
         unsafe { bindings::iput(obj.as_ref().0.get()) }
     }
 }
+
+/// An inode that is locked and hasn't been initialised yet.
+///
+/// # Invariants
+///
+/// The inode is a new one, locked, and valid for write.
+pub struct New<T: FileSystem + ?Sized>(
+    pub(crate) ptr::NonNull<bindings::inode>,
+    pub(crate) PhantomData<T>,
+);
+
+impl<T: FileSystem + ?Sized> New<T> {
+    /// Initialises the new inode with the given parameters.
+    pub fn init(mut self, params: Params) -> Result<ARef<INode<T>>> {
+        // SAFETY: This is a new inode, so it's safe to manipulate it mutably.
+        let inode = unsafe { self.0.as_mut() };
+        let mode = match params.typ {
+            Type::Dir => {
+                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
+                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
+
+                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
+                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
+
+                bindings::S_IFDIR
+            }
+        };
+
+        inode.i_mode = (params.mode & 0o777) | u16::try_from(mode)?;
+        inode.i_size = params.size;
+        inode.i_blocks = params.blocks;
+
+        inode.__i_ctime = params.ctime.into();
+        inode.__i_mtime = params.mtime.into();
+        inode.__i_atime = params.atime.into();
+
+        // SAFETY: inode is a new inode, so it is valid for write.
+        unsafe {
+            bindings::set_nlink(inode, params.nlink);
+            bindings::i_uid_write(inode, params.uid);
+            bindings::i_gid_write(inode, params.gid);
+            bindings::unlock_new_inode(inode);
+        }
+
+        let manual = ManuallyDrop::new(self);
+        // SAFETY: We transferred ownership of the refcount to `ARef` by preventing `drop` from
+        // being called with the `ManuallyDrop` instance created above.
+        Ok(unsafe { ARef::from_raw(manual.0.cast::<INode<T>>()) })
+    }
+}
+
+impl<T: FileSystem + ?Sized> Drop for New<T> {
+    fn drop(&mut self) {
+        // SAFETY: The new inode failed to be turned into an initialised inode, so it's safe (and
+        // in fact required) to call `iget_failed` on it.
+        unsafe { bindings::iget_failed(self.0.as_ptr()) };
+    }
+}
+
+/// The type of an inode.
+#[derive(Copy, Clone)]
+pub enum Type {
+    /// Directory type.
+    Dir,
+}
+
+/// Required inode parameters.
+///
+/// This is used when creating new inodes.
+pub struct Params {
+    /// The access mode. It's a mask that grants execute (1), write (2) and read (4) access to
+    /// everyone, the owner group, and the owner.
+    pub mode: u16,
+
+    /// Type of inode.
+    ///
+    /// Also carries additional per-type data.
+    pub typ: Type,
+
+    /// Size of the contents of the inode.
+    ///
+    /// Its maximum value is [`super::MAX_LFS_FILESIZE`].
+    pub size: Offset,
+
+    /// Number of blocks.
+    pub blocks: block::Count,
+
+    /// Number of links to the inode.
+    pub nlink: u32,
+
+    /// User id.
+    pub uid: u32,
+
+    /// Group id.
+    pub gid: u32,
+
+    /// Creation time.
+    pub ctime: Timespec,
+
+    /// Last modification time.
+    pub mtime: Timespec,
+
+    /// Last access time.
+    pub atime: Timespec,
+}
diff --git a/rust/kernel/fs/sb.rs b/rust/kernel/fs/sb.rs
index f48e0e2695fa..fa10f3db5593 100644
--- a/rust/kernel/fs/sb.rs
+++ b/rust/kernel/fs/sb.rs
@@ -6,9 +6,12 @@
 //!
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
 
+use super::inode::{self, INode, Ino};
 use super::FileSystem;
-use crate::{bindings, types::Opaque};
-use core::marker::PhantomData;
+use crate::bindings;
+use crate::error::{code::*, Result};
+use crate::types::{ARef, Either, Opaque};
+use core::{marker::PhantomData, ptr};
 
 /// A file system super block.
 ///
@@ -60,4 +63,45 @@ pub fn set_magic(&mut self, magic: usize) -> &mut Self {
         unsafe { (*self.0.get()).s_magic = magic as core::ffi::c_ulong };
         self
     }
+
+    /// Tries to get an existing inode or create a new one if it doesn't exist yet.
+    pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<INode<T>>, inode::New<T>>> {
+        // SAFETY: All superblock-related state needed by `iget_locked` is initialised by C code
+        // before calling `fill_super_callback`, or by `fill_super_callback` itself before calling
+        // `super_params`, which is the first function to see a new superblock.
+        let inode =
+            ptr::NonNull::new(unsafe { bindings::iget_locked(self.0.get(), ino) }).ok_or(ENOMEM)?;
+
+        // SAFETY: `inode` is a valid pointer returned by `iget_locked`.
+        unsafe { bindings::spin_lock(ptr::addr_of_mut!((*inode.as_ptr()).i_lock)) };
+
+        // SAFETY: `inode` is valid and was locked by the previous lock.
+        let state = unsafe { *ptr::addr_of!((*inode.as_ptr()).i_state) };
+
+        // SAFETY: `inode` is a valid pointer returned by `iget_locked`.
+        unsafe { bindings::spin_unlock(ptr::addr_of_mut!((*inode.as_ptr()).i_lock)) };
+
+        if state & u64::from(bindings::I_NEW) == 0 {
+            // The inode is cached. Just return it.
+            //
+            // SAFETY: `inode` had its refcount incremented by `iget_locked`; this increment is now
+            // owned by `ARef`.
+            Ok(Either::Left(unsafe { ARef::from_raw(inode.cast()) }))
+        } else {
+            // SAFETY: The new inode is valid but not fully initialised yet, so it's ok to create a
+            // `inode::New`.
+            Ok(Either::Right(inode::New(inode, PhantomData)))
+        }
+    }
+
+    /// Creates an inode with the given inode number.
+    ///
+    /// Fails with `EEXIST` if an inode with the given number already exists.
+    pub fn create_inode(&self, ino: Ino) -> Result<inode::New<T>> {
+        if let Either::Right(new) = self.get_or_create_inode(ino)? {
+            Ok(new)
+        } else {
+            Err(EEXIST)
+        }
+    }
 }
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 022addf68891..d32c4645ebe8 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -2,9 +2,9 @@
 
 //! Rust read-only file system sample.
 
-use kernel::fs::sb;
+use kernel::fs::{dentry, inode, sb::SuperBlock};
 use kernel::prelude::*;
-use kernel::{c_str, fs};
+use kernel::{c_str, fs, time::UNIX_EPOCH, types::Either};
 
 kernel::module_fs! {
     type: RoFs,
@@ -18,8 +18,27 @@
 impl fs::FileSystem for RoFs {
     const NAME: &'static CStr = c_str!("rust_rofs");
 
-    fn fill_super(sb: &mut sb::SuperBlock<Self>) -> Result {
+    fn fill_super(sb: &mut SuperBlock<Self>) -> Result {
         sb.set_magic(0x52555354);
         Ok(())
     }
+
+    fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
+        let inode = match sb.get_or_create_inode(1)? {
+            Either::Left(existing) => existing,
+            Either::Right(new) => new.init(inode::Params {
+                typ: inode::Type::Dir,
+                mode: 0o555,
+                size: 1,
+                blocks: 1,
+                nlink: 2,
+                uid: 0,
+                gid: 0,
+                atime: UNIX_EPOCH,
+                ctime: UNIX_EPOCH,
+                mtime: UNIX_EPOCH,
+            })?,
+        };
+        dentry::Root::try_new(inode)
+    }
 }
-- 
2.34.1


