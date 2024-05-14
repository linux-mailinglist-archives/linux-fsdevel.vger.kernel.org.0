Return-Path: <linux-fsdevel+bounces-19447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B068C570D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E252877D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E815E1EF;
	Tue, 14 May 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxPUAUgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9E15B0F9;
	Tue, 14 May 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692686; cv=none; b=Rjr3iAKSeijqcQRLkw3ssYSKlV+6NHE66eZgUqLajdXc7imMUevdS2wHcuUhpagEYAwSEC4nmmuyN18QwEnq+i1NjcIH4bMSroXqpwRmD+uGXpQZPS/DtqNtajsDvNKd+5/oOMPIKCZSog9w3K5qQNx6r4tUeQFkTubjyawixjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692686; c=relaxed/simple;
	bh=VXGbCQDnecMt6mt+aq4tlwfDABY1crJXoO0vieyH/ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rILrE3P/kR7nVOHjv7+VjnwEBjzP+fe0iG/JpI55qImcgGESBttmMt+fQTMjYq+E0Dg9wJyXVXsgXgvWm8jJ2ngVKaA9weH+i2LpVNDCJyI8xEO1eyftb0TeJE6/oRNShTb+UsFi0rDybyue1jX45c24Qin6Qcl9GSL/IsG8E58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxPUAUgy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed012c1afbso44539545ad.1;
        Tue, 14 May 2024 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692683; x=1716297483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znND3ftEI4hHOqwMzLtbBr8oQP+s8h6w3BvrEV2G89A=;
        b=AxPUAUgy2LX+p3RMpHOnWv1dQ8tZ613GjXg0HMfqppOV5sfdfU2tQH/JBOixRZaS3n
         W7i/crB77dK7wOONQ7UEm0yFvLqoWIMoiolCiaiwnRbVVsOfmujpuado+vFoJf8UujNQ
         +S8u5+2bwmzp5LLFRjukSLr7gsEflIgmowkkSt5wzNmQBiomRHTgHdBLjIDzWPe/4KoN
         /c+MTbbeqN4/IHst5uw5EkYQTxLyH0Q7osNzKtVP58sivaqDPdCbK120BcUrFsWNNgqm
         QUr6MX/eFPB5sczswDBbh2sjvLtkB1HUmR3B9fAEbZTu8xDTYLVwb83lArUhDtXv90cS
         IaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692683; x=1716297483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znND3ftEI4hHOqwMzLtbBr8oQP+s8h6w3BvrEV2G89A=;
        b=gDHARms4pkzazluu0cjkcJdH5/geim4Gqxn3U6Sffzamis48IRn/8wOQSGtNb0ffaJ
         vVq1fwAIdADGqHwFUaxEfL2FJjHrOA04mAACyPZhSbeZuMYL/dVNMQhIPmoAnre1LQ/S
         /xoSTBOimP53qe9dmXzMPUmNefqqIJT0jBWzRTuX76Ke9I/nyVQM03FZK5piLFgpqtpc
         RjDlrwRLQ06UTVpsrteDZGqn90NDgMP+sDTIRE2tk6CT5S3X/POEtptv6DhImOZYMFAw
         gAUbO/jSgkdxVYe/zN1lupkJJJdFzQnlGK9ckNgd5PLVqZJ7oYPoWiFa0GHvPy4cCiWE
         PyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwKy4s/mR5xOgbkIOF7fP76zuGqjmJlQStJoNekCtUsjWHBZyZyb2DMNDt0d5SxbCHDYI6lHTqQCGA24+ZknrLOv1TZleOtbEltirxh6GwsgD7JpVWMHBZ/D3ZddLu20SqSUbOAB2lF2xcBo7hJm7o67TIChXLnEDpR6bcARlBNL52zabazXid4WLr
X-Gm-Message-State: AOJu0YwAifTC21p2pGjo+UgbHuV2e4SQDk/fSWfFADfEGaQcYc/Snwpd
	ZWRNb9++/5zyQhqboLhuSsvHldamMtCAP3OVjcuYMlHuzrMBrz4n
X-Google-Smtp-Source: AGHT+IGoHGDX0jiy5IZ34a3V+2976VMs1A2S7Hst5FzQXDoIe4OCQK74KtUh8IFsgw3czxFbp9NZZQ==
X-Received: by 2002:a17:903:24d:b0:1e0:b60f:5de3 with SMTP id d9443c01a7336-1ef42d69b4fmr177636065ad.7.1715692683091;
        Tue, 14 May 2024 06:18:03 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:18:02 -0700 (PDT)
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
Subject: [RFC PATCH v2 24/30] rust: fs: allow per-inode data
Date: Tue, 14 May 2024 10:17:05 -0300
Message-Id: <20240514131711.379322-25-wedsonaf@gmail.com>
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

Allow Rust file systems to attach extra [typed] data to each inode. If
no data is needed, use the regular inode kmem_cache, otherwise we create
a new one.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c            |   7 +++
 rust/kernel/fs.rs         |  19 ++++--
 rust/kernel/fs/inode.rs   | 123 ++++++++++++++++++++++++++++++++++++--
 rust/kernel/mem_cache.rs  |   2 -
 samples/rust/rust_rofs.rs |  13 ++--
 5 files changed, 143 insertions(+), 21 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 6c6d18df055f..edf12868962c 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -266,6 +266,13 @@ struct folio *rust_helper_read_mapping_folio(struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(rust_helper_read_mapping_folio);
 
+void *rust_helper_alloc_inode_sb(struct super_block *sb,
+				 struct kmem_cache *cache, gfp_t gfp)
+{
+	return alloc_inode_sb(sb, cache, gfp);
+}
+EXPORT_SYMBOL_GPL(rust_helper_alloc_inode_sb);
+
 void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
 {
 	i_uid_write(inode, uid);
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 864aca24d12c..d64fe1a5812f 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -8,8 +8,8 @@
 
 use crate::error::{code::*, from_result, to_result, Error, Result};
 use crate::types::{ForeignOwnable, Opaque};
-use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
-use core::{ffi, marker::PhantomData, mem::ManuallyDrop, pin::Pin, ptr};
+use crate::{bindings, init::PinInit, mem_cache::MemCache, str::CStr, try_pin_init, ThisModule};
+use core::{ffi, marker::PhantomData, mem::size_of, mem::ManuallyDrop, pin::Pin, ptr};
 use dentry::DEntry;
 use inode::INode;
 use macros::{pin_data, pinned_drop};
@@ -39,6 +39,9 @@ pub trait FileSystem {
     /// Data associated with each file system instance (super-block).
     type Data: ForeignOwnable + Send + Sync;
 
+    /// Type of data associated with each inode.
+    type INodeData: Send + Sync;
+
     /// The name of the file system type.
     const NAME: &'static CStr;
 
@@ -109,6 +112,7 @@ pub struct Stat {
 
 impl FileSystem for UnspecifiedFS {
     type Data = ();
+    type INodeData = ();
     const NAME: &'static CStr = crate::c_str!("unspecified");
     const IS_UNSPECIFIED: bool = true;
     fn fill_super(_: &mut SuperBlock<Self, sb::New>, _: Option<inode::Mapper>) -> Result {
@@ -125,6 +129,7 @@ fn init_root(_: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
 pub struct Registration {
     #[pin]
     fs: Opaque<bindings::file_system_type>,
+    inode_cache: Option<MemCache>,
 }
 
 // SAFETY: `Registration` doesn't provide any `&self` methods, so it is safe to pass references
@@ -139,6 +144,7 @@ impl Registration {
     /// Creates the initialiser of a new file system registration.
     pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
+            inode_cache: INode::<T>::new_cache()?,
             fs <- Opaque::try_ffi_init(|fs_ptr: *mut bindings::file_system_type| {
                 // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is valid for write.
                 unsafe { fs_ptr.write(bindings::file_system_type::default()) };
@@ -284,8 +290,12 @@ impl<T: FileSystem + ?Sized> Tables<T> {
     }
 
     const SUPER_BLOCK: bindings::super_operations = bindings::super_operations {
-        alloc_inode: None,
-        destroy_inode: None,
+        alloc_inode: if size_of::<T::INodeData>() != 0 {
+            Some(INode::<T>::alloc_inode_callback)
+        } else {
+            None
+        },
+        destroy_inode: Some(INode::<T>::destroy_inode_callback),
         free_inode: None,
         dirty_inode: None,
         write_inode: None,
@@ -419,6 +429,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 /// struct MyFs;
 /// impl fs::FileSystem for MyFs {
 ///     type Data = ();
+///     type INodeData = ();
 ///     const NAME: &'static CStr = kernel::c_str!("myfs");
 ///     fn fill_super(_: &mut SuperBlock<Self, sb::New>, _: Option<Mapper>) -> Result {
 ///         todo!()
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index 5b3602362521..5230ff2fe0dd 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -13,9 +13,10 @@
 use crate::error::{code::*, from_err_ptr, Result};
 use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Lockable, Locked, Opaque};
 use crate::{
-    bindings, block, build_error, folio, folio::Folio, str::CStr, str::CString, time::Timespec,
+    bindings, block, build_error, container_of, folio, folio::Folio, mem_cache::MemCache,
+    str::CStr, str::CString, time::Timespec,
 };
-use core::mem::ManuallyDrop;
+use core::mem::{size_of, ManuallyDrop, MaybeUninit};
 use core::{cmp, marker::PhantomData, ops::Deref, ptr};
 use macros::vtable;
 
@@ -91,6 +92,18 @@ pub fn super_block(&self) -> &SuperBlock<T> {
         unsafe { SuperBlock::from_raw((*self.0.get()).i_sb) }
     }
 
+    /// Returns the data associated with the inode.
+    pub fn data(&self) -> &T::INodeData {
+        if T::IS_UNSPECIFIED {
+            crate::build_error!("inode data type is unspecified");
+        }
+        let outerp = container_of!(self.0.get(), WithData<T::INodeData>, inode);
+        // SAFETY: `self` is guaranteed to be valid by the existence of a shared reference
+        // (`&self`) to it. Additionally, we know `T::INodeData` is always initialised in an
+        // `INode`.
+        unsafe { &*(*outerp).data.as_ptr() }
+    }
+
     /// Returns the size of the inode contents.
     pub fn size(&self) -> Offset {
         // SAFETY: `self` is guaranteed to be valid by the existence of a shared reference.
@@ -182,6 +195,87 @@ pub unsafe fn for_each_page<U>(
 
         Ok(None)
     }
+
+    pub(crate) fn new_cache() -> Result<Option<MemCache>> {
+        Ok(if size_of::<T::INodeData>() == 0 {
+            None
+        } else {
+            Some(MemCache::try_new::<WithData<T::INodeData>>(
+                T::NAME,
+                Some(Self::inode_init_once_callback),
+            )?)
+        })
+    }
+
+    unsafe extern "C" fn inode_init_once_callback(outer_inode: *mut core::ffi::c_void) {
+        let ptr = outer_inode.cast::<WithData<T::INodeData>>();
+
+        // SAFETY: This is only used in `new`, so we know that we have a valid `inode::WithData`
+        // instance whose inode part can be initialised.
+        unsafe { bindings::inode_init_once(ptr::addr_of_mut!((*ptr).inode)) };
+    }
+
+    pub(crate) unsafe extern "C" fn alloc_inode_callback(
+        sb: *mut bindings::super_block,
+    ) -> *mut bindings::inode {
+        // SAFETY: The callback contract guarantees that `sb` is valid for read.
+        let super_type = unsafe { (*sb).s_type };
+
+        // SAFETY: This callback is only used in `Registration`, so `super_type` is necessarily
+        // embedded in a `Registration`, which is guaranteed to be valid because it has a
+        // superblock associated to it.
+        let reg = unsafe { &*container_of!(super_type, super::Registration, fs) };
+
+        // SAFETY: `sb` and `cache` are guaranteed to be valid by the callback contract and by
+        // the existence of a superblock respectively.
+        let ptr = unsafe {
+            bindings::alloc_inode_sb(sb, MemCache::ptr(&reg.inode_cache), bindings::GFP_KERNEL)
+        }
+        .cast::<WithData<T::INodeData>>();
+        if ptr.is_null() {
+            return ptr::null_mut();
+        }
+
+        // SAFETY: `ptr` was just allocated, so it is valid for dereferencing.
+        unsafe { ptr::addr_of_mut!((*ptr).inode) }
+    }
+
+    pub(crate) unsafe extern "C" fn destroy_inode_callback(inode: *mut bindings::inode) {
+        // SAFETY: By the C contract, `inode` is a valid pointer.
+        let is_bad = unsafe { bindings::is_bad_inode(inode) };
+
+        // SAFETY: The inode is guaranteed to be valid by the callback contract. Additionally, the
+        // superblock is also guaranteed to still be valid by the inode existence.
+        let super_type = unsafe { (*(*inode).i_sb).s_type };
+
+        // SAFETY: This callback is only used in `Registration`, so `super_type` is necessarily
+        // embedded in a `Registration`, which is guaranteed to be valid because it has a
+        // superblock associated to it.
+        let reg = unsafe { &*container_of!(super_type, super::Registration, fs) };
+        let ptr = container_of!(inode, WithData<T::INodeData>, inode).cast_mut();
+
+        if !is_bad {
+            // SAFETY: The code either initialises the data or marks the inode as bad. Since the
+            // inode is not bad, the data is initialised, and thus safe to drop.
+            unsafe { ptr::drop_in_place((*ptr).data.as_mut_ptr()) };
+        }
+
+        if size_of::<T::INodeData>() == 0 {
+            // SAFETY: When the size of `INodeData` is zero, we don't use a separate mem_cache, so
+            // it is allocated from the regular mem_cache, which is what `free_inode_nonrcu` uses
+            // to free the inode.
+            unsafe { bindings::free_inode_nonrcu(inode) };
+        } else {
+            // The callback contract guarantees that the inode was previously allocated via the
+            // `alloc_inode_callback` callback, so it is safe to free it back to the cache.
+            unsafe {
+                bindings::kmem_cache_free(
+                    MemCache::ptr(&reg.inode_cache),
+                    ptr.cast::<core::ffi::c_void>(),
+                )
+            };
+        }
+    }
 }
 
 impl<T: FileSystem + ?Sized, U: Deref<Target = INode<T>>> Locked<U, ReadSem> {
@@ -251,6 +345,11 @@ unsafe fn unlock(&self) {
     }
 }
 
+struct WithData<T> {
+    data: MaybeUninit<T>,
+    inode: bindings::inode,
+}
+
 /// An inode that is locked and hasn't been initialised yet.
 ///
 /// # Invariants
@@ -263,9 +362,18 @@ pub struct New<T: FileSystem + ?Sized>(
 
 impl<T: FileSystem + ?Sized> New<T> {
     /// Initialises the new inode with the given parameters.
-    pub fn init(mut self, params: Params) -> Result<ARef<INode<T>>> {
-        // SAFETY: This is a new inode, so it's safe to manipulate it mutably.
-        let inode = unsafe { self.0.as_mut() };
+    pub fn init(self, params: Params<T::INodeData>) -> Result<ARef<INode<T>>> {
+        let outerp = container_of!(self.0.as_ptr(), WithData<T::INodeData>, inode);
+
+        // SAFETY: This is a newly-created inode. No other references to it exist, so it is
+        // safe to mutably dereference it.
+        let outer = unsafe { &mut *outerp.cast_mut() };
+
+        // N.B. We must always write this to a newly allocated inode because the free callback
+        // expects the data to be initialised and drops it.
+        outer.data.write(params.value);
+
+        let inode = &mut outer.inode;
         let mode = match params.typ {
             Type::Dir => bindings::S_IFDIR,
             Type::Reg => {
@@ -404,7 +512,7 @@ pub enum Type {
 /// Required inode parameters.
 ///
 /// This is used when creating new inodes.
-pub struct Params {
+pub struct Params<T> {
     /// The access mode. It's a mask that grants execute (1), write (2) and read (4) access to
     /// everyone, the owner group, and the owner.
     pub mode: u16,
@@ -439,6 +547,9 @@ pub struct Params {
 
     /// Last access time.
     pub atime: Timespec,
+
+    /// Value to attach to this node.
+    pub value: T,
 }
 
 /// Represents inode operations.
diff --git a/rust/kernel/mem_cache.rs b/rust/kernel/mem_cache.rs
index e7e2720ff6cd..cbf1b7e75334 100644
--- a/rust/kernel/mem_cache.rs
+++ b/rust/kernel/mem_cache.rs
@@ -20,7 +20,6 @@ impl MemCache {
     /// Allocates a new `kmem_cache` for type `T`.
     ///
     /// `init` is called by the C code when entries are allocated.
-    #[allow(dead_code)]
     pub(crate) fn try_new<T>(
         name: &'static CStr,
         init: Option<unsafe extern "C" fn(*mut core::ffi::c_void)>,
@@ -43,7 +42,6 @@ pub(crate) fn try_new<T>(
     /// Returns the pointer to the `kmem_cache` instance, or null if it's `None`.
     ///
     /// This is a helper for functions like `alloc_inode_sb` where the cache is optional.
-    #[allow(dead_code)]
     pub(crate) fn ptr(c: &Option<Self>) -> *mut bindings::kmem_cache {
         match c {
             Some(m) => m.ptr.as_ptr(),
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index fea3360b6e7a..5b6c3f50adf4 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -93,12 +93,14 @@ fn iget(sb: &sb::SuperBlock<Self>, e: &'static Entry) -> Result<ARef<INode<Self>
             atime: UNIX_EPOCH,
             ctime: UNIX_EPOCH,
             mtime: UNIX_EPOCH,
+            value: e,
         })
     }
 }
 
 impl fs::FileSystem for RoFs {
     type Data = ();
+    type INodeData = &'static Entry;
     const NAME: &'static CStr = c_str!("rust_rofs");
 
     fn fill_super(sb: &mut sb::SuperBlock<Self, sb::New>, _: Option<inode::Mapper>) -> Result {
@@ -149,10 +151,7 @@ fn get_link<'a>(
             return Err(ECHILD);
         }
 
-        let name_buf = match inode.ino() {
-            3 => ENTRIES[3].contents,
-            _ => return Err(EINVAL),
-        };
+        let name_buf = inode.data().contents;
         let mut name = Box::new_slice(
             name_buf.len().checked_add(1).ok_or(ENOMEM)?,
             b'\0',
@@ -168,11 +167,7 @@ impl address_space::Operations for RoFs {
     type FileSystem = Self;
 
     fn read_folio(_: Option<&File<Self>>, mut folio: Locked<&Folio<PageCache<Self>>>) -> Result {
-        let data = match folio.inode().ino() {
-            2 => ENTRIES[2].contents,
-            _ => return Err(EINVAL),
-        };
-
+        let data = folio.inode().data().contents;
         let pos = usize::try_from(folio.pos()).unwrap_or(usize::MAX);
         let copied = if pos >= data.len() {
             0
-- 
2.34.1


