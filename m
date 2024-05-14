Return-Path: <linux-fsdevel+bounces-19427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934B8C56E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF061C21C11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752441465A7;
	Tue, 14 May 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hurjez/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80E145FE5;
	Tue, 14 May 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692665; cv=none; b=bCk8DLB1XOH2wIcmoOFCSFRnzWNX9+OLu3CzMpRI3M/1Ld0/bPvHxjq5oIh70kzQNuqQlRlcQfMBHlE9CYHelVpN0hsPQUetsD34hXLEUbKLJt8R3UEOwHtGigqkL9M+6fzzECp2rWMTcIiHxkdxyM8uQdzOlP17vgaJSLnKtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692665; c=relaxed/simple;
	bh=RZNTYnBFblAGe2jSYR7GVo5fVOthNmES7NcxVvRDXm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAXd0ZzSsgx1b9vnr2CWkti7Sd7dQPJZ/yPfrOfDczqXE9CUkFUYPeB2fpTzvzAv6BjqA5ta38jbV4lgsGVK/SL/Y6sEcvYWVEExVAePcegbwuqtqa23MJoHqguqnoRWDTihFTdlDsM/LwL1h1ozGU/WEapfU/hrstMe35/AYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hurjez/h; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e651a9f3ffso31087485ad.1;
        Tue, 14 May 2024 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692663; x=1716297463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHtb+LC/c7u+3DtN2ygh96hbKct7H/SXE7wrRgiAkgI=;
        b=hurjez/h4SZgnGwOm1OziTBfrde0x09OFLG8Zno4e9/SeCbM6Aox2FlmkQrvLbVC3i
         4IrKVNINsG4g8eb84r3/r5fVdGmGAnRAzF56T9IA8798MvxT2FxnyhRs3bMsdKrH1fwq
         colNujtymEeXt5bjbu0seaOhbjH5FcsaO/0L5J+EC9gCq72qoiNQZij7mglLugffAjNR
         0cn847eonRSd7IfTizSr2sEe8OlLhq7UfckzQ8lZQreTiQqyQOEO3yf5KDeVBySYRvi2
         p4fo4BU3pfidAp60HN5rX/oYmMvgODQeSDX9Bmy2lX4nwjCnpDVecSodJiEoTmYCUdLl
         b4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692663; x=1716297463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHtb+LC/c7u+3DtN2ygh96hbKct7H/SXE7wrRgiAkgI=;
        b=feQLy4cvzmM31exCeK+1I4quF6qAlji6rT/RnAp2VH4+I3IgWFXBxRS4x5Hx5m2/0t
         fL1wXTjO5esq5l8vG4f5ZngfVxHkQoo8E0FHCxBQlOKiPbCpUQcdJcxauHvxtau2InTI
         9XNL1LqLAJoujt+p6o5Z90trtdqbF9i7v/HWEAH4pbMAkXgmIw32kfDz+ZTH02T/DDB4
         kzXh9w2ZqJAu7AQ1gdkvhlkX+upr1oD6gJujejX01pUP3zkVe6BcdJWp9qtYa0dMATgt
         eea7gKqgpY2I+knFNFoSFK2Rt+lChA8bZp1CVYjTIWygFp/+XI7LN8mCGHY7r8DOgHHq
         /d9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/HS1XeU3ajk2i08h8YUSdGMqdbKWT+Oc6Jd9axnM2MZWm4KdRYq7kXTk4KM3bUmNBeBuihinqeE+Zk5kSrZLz0m1AwwiUAxpA5wweJyC1YbpYYBSDrjAbJoRGON4D3EEls4lUlKU7sMxPuU3hk8GXqoIGYTKMSS+GJfNWgg2aTNr5i1wfiZkJqEi
X-Gm-Message-State: AOJu0YyrrEADmVgr8gsB2tRoANLQre4ApnMBcrmh9wSP58HYEf9WYida
	S5F6RJu0/9bCYLZMRQx+PoqQywg+60KV4c2TClRSR3in6ZVAPg21
X-Google-Smtp-Source: AGHT+IGoEMUcg1atFweFeaUt1I3jjzgOSm6DZ4vKImCmjNmsu+1JQNchOGR2w5pz1lr1zfC9UWBWXA==
X-Received: by 2002:a17:903:2782:b0:1e3:f012:568d with SMTP id d9443c01a7336-1ef43d1ae15mr112197365ad.15.1715692663533;
        Tue, 14 May 2024 06:17:43 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:43 -0700 (PDT)
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
Subject: [RFC PATCH v2 05/30] rust: fs: introduce `INode<T>`
Date: Tue, 14 May 2024 10:16:46 -0300
Message-Id: <20240514131711.379322-6-wedsonaf@gmail.com>
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

Allow Rust file systems to handle typed and ref-counted inodes.

This is in preparation for creating new inodes (for example, to create
the root inode of a new superblock), which comes in the next patch in
the series.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c          |  7 ++++
 rust/kernel/block.rs    |  9 +++++
 rust/kernel/fs.rs       | 20 +++++++++++
 rust/kernel/fs/inode.rs | 78 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/fs/sb.rs    | 15 +++++++-
 5 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/fs/inode.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 318e3e85dddd..c697c1c4c9d7 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -164,6 +164,13 @@ struct file *rust_helper_get_file(struct file *f)
 }
 EXPORT_SYMBOL_GPL(rust_helper_get_file);
 
+
+loff_t rust_helper_i_size_read(const struct inode *inode)
+{
+	return i_size_read(inode);
+}
+EXPORT_SYMBOL_GPL(rust_helper_i_size_read);
+
 unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
 				       unsigned long n)
 {
diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 38d2a3089ae7..868623d7c873 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -5,6 +5,7 @@
 //! C headers: [`include/linux/blk_types.h`](../../include/linux/blk_types.h)
 
 use crate::bindings;
+use crate::fs::inode::INode;
 use crate::types::Opaque;
 
 /// The type used for indexing onto a disc or disc partition.
@@ -35,4 +36,12 @@ pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::block_device) -> &'a Self
         // SAFETY: The safety requirements guarantee that the cast below is ok.
         unsafe { &*ptr.cast::<Self>() }
     }
+
+    /// Returns the inode associated with this block device.
+    pub fn inode(&self) -> &INode {
+        // SAFETY: `bd_inode` is never reassigned.
+        let ptr = unsafe { (*self.0.get()).bd_inode };
+        // SAFET: `ptr` is valid as long as the block device remains valid as well.
+        unsafe { INode::from_raw(ptr) }
+    }
 }
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 263b4b6186ae..89dcd5537830 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -13,6 +13,7 @@
 use macros::{pin_data, pinned_drop};
 use sb::SuperBlock;
 
+pub mod inode;
 pub mod sb;
 
 /// The offset of a file in a file system.
@@ -28,10 +29,29 @@ pub trait FileSystem {
     /// The name of the file system type.
     const NAME: &'static CStr;
 
+    /// Determines if an implementation doesn't specify the required types.
+    ///
+    /// This is meant for internal use only.
+    #[doc(hidden)]
+    const IS_UNSPECIFIED: bool = false;
+
     /// Initialises the new superblock.
     fn fill_super(sb: &mut SuperBlock<Self>) -> Result;
 }
 
+/// A file system that is unspecified.
+///
+/// Attempting to get super-block or inode data from it will result in a build error.
+pub struct UnspecifiedFS;
+
+impl FileSystem for UnspecifiedFS {
+    const NAME: &'static CStr = crate::c_str!("unspecified");
+    const IS_UNSPECIFIED: bool = true;
+    fn fill_super(_: &mut SuperBlock<Self>) -> Result {
+        Err(ENOTSUPP)
+    }
+}
+
 /// A registration of a file system.
 #[pin_data(PinnedDrop)]
 pub struct Registration {
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
new file mode 100644
index 000000000000..bcb9c8ce59a9
--- /dev/null
+++ b/rust/kernel/fs/inode.rs
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File system inodes.
+//!
+//! This module allows Rust code to implement inodes.
+//!
+//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
+
+use super::{sb::SuperBlock, FileSystem, Offset, UnspecifiedFS};
+use crate::bindings;
+use crate::types::{AlwaysRefCounted, Opaque};
+use core::{marker::PhantomData, ptr};
+
+/// The number of an inode.
+pub type Ino = u64;
+
+/// A node (inode) in the file index.
+///
+/// Wraps the kernel's `struct inode`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `ihold` ensures that the
+/// allocation remains valid at least until the matching call to `iput`.
+#[repr(transparent)]
+pub struct INode<T: FileSystem + ?Sized = UnspecifiedFS>(
+    pub(crate) Opaque<bindings::inode>,
+    PhantomData<T>,
+);
+
+impl<T: FileSystem + ?Sized> INode<T> {
+    /// Creates a new inode reference from the given raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    ///
+    /// * `ptr` is valid and remains so for the lifetime of the returned object.
+    /// * `ptr` has the correct file system type, or `T` is [`super::UnspecifiedFS`].
+    #[allow(dead_code)]
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::inode) -> &'a Self {
+        // SAFETY: The safety requirements guarantee that the cast below is ok.
+        unsafe { &*ptr.cast::<Self>() }
+    }
+
+    /// Returns the number of the inode.
+    pub fn ino(&self) -> Ino {
+        // SAFETY: `i_ino` is immutable, and `self` is guaranteed to be valid by the existence of a
+        // shared reference (&self) to it.
+        unsafe { (*self.0.get()).i_ino }
+    }
+
+    /// Returns the super-block that owns the inode.
+    pub fn super_block(&self) -> &SuperBlock<T> {
+        // SAFETY: `i_sb` is immutable, and `self` is guaranteed to be valid by the existence of a
+        // shared reference (&self) to it.
+        unsafe { SuperBlock::from_raw((*self.0.get()).i_sb) }
+    }
+
+    /// Returns the size of the inode contents.
+    pub fn size(&self) -> Offset {
+        // SAFETY: `self` is guaranteed to be valid by the existence of a shared reference.
+        unsafe { bindings::i_size_read(self.0.get()) }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `INode` is always ref-counted.
+unsafe impl<T: FileSystem + ?Sized> AlwaysRefCounted for INode<T> {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::ihold(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::iput(obj.as_ref().0.get()) }
+    }
+}
diff --git a/rust/kernel/fs/sb.rs b/rust/kernel/fs/sb.rs
index 113d3c0d8148..f48e0e2695fa 100644
--- a/rust/kernel/fs/sb.rs
+++ b/rust/kernel/fs/sb.rs
@@ -20,6 +20,19 @@ pub struct SuperBlock<T: FileSystem + ?Sized>(
 );
 
 impl<T: FileSystem + ?Sized> SuperBlock<T> {
+    /// Creates a new superblock reference from the given raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    ///
+    /// * `ptr` is valid and remains so for the lifetime of the returned object.
+    /// * `ptr` has the correct file system type, or `T` is [`super::UnspecifiedFS`].
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::super_block) -> &'a Self {
+        // SAFETY: The safety requirements guarantee that the cast below is ok.
+        unsafe { &*ptr.cast::<Self>() }
+    }
+
     /// Creates a new superblock mutable reference from the given raw pointer.
     ///
     /// # Safety
@@ -27,7 +40,7 @@ impl<T: FileSystem + ?Sized> SuperBlock<T> {
     /// Callers must ensure that:
     ///
     /// * `ptr` is valid and remains so for the lifetime of the returned object.
-    /// * `ptr` has the correct file system type.
+    /// * `ptr` has the correct file system type, or `T` is [`super::UnspecifiedFS`].
     /// * `ptr` is the only active pointer to the superblock.
     pub(crate) unsafe fn from_raw_mut<'a>(ptr: *mut bindings::super_block) -> &'a mut Self {
         // SAFETY: The safety requirements guarantee that the cast below is ok.
-- 
2.34.1


