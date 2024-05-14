Return-Path: <linux-fsdevel+bounces-19444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D312C8C5707
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45257B22E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871C15B145;
	Tue, 14 May 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDD7FM2+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5814158DC6;
	Tue, 14 May 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692683; cv=none; b=bRhkLNLHVK5EgXdFqLCIF1ElTgh+leRJc0mb0elR4ehG4kEnSllJqaDCxlJEtVR99He0yrKQaCkp3KM4hT7BAWDv1Vt9+85zZxwz9VyQQe4DqwBxu6i996pJCU9XYQRW1pMpYC6sKrJHv3gguw/0WVy7B5sa7si3fQ4oWVPu2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692683; c=relaxed/simple;
	bh=nqHJIwr5EZghdDpCfTkWNNMp7x4S2W1hE11AYrRKpTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=svKVPLAHWgdjSuBBP4QmZ7yPjp9U/qrmU13NQ9M2cKvbVOJyvcPhgC3pBhXgej4uFum42wZDURgWen8RBt3d46I15sV2V+Yry6QeKb5h2opVuFFHnH1aekPUp8fQmNjUe4fY1TH8aNTl1iW5PIOVUAPkNx2fFtptkDRJVE/Ki5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDD7FM2+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec41d82b8bso52518125ad.2;
        Tue, 14 May 2024 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692681; x=1716297481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQjruP9C1AriCa2NTVu4vY4iAh6hhbFru1ekZHix3gc=;
        b=VDD7FM2+gjtNrJJFm/DiF5Dlrey3m5D0IXcdOyJnZQa9zMAM0NOGRyq8vQlou20Xk5
         NWoEpJtN9UHTpyKa3thjpVr0sG8vxW5KJ+6adUO4JDhi9srT9px0iBlQqWyYhp86suJA
         OaCdhJTEz8W29IEUsyTPbxVMWCgFTT7tQAgLMoGc/03JLz+bB9Byx/GuWTBnCZZnVVJ9
         BuTtS6IrKhc6av7MnE9YBkqnq6adwDu5viZhnWdjh9SzVrCuScB1eU7488c2HQ7kGJof
         huejEaMnEotswN40uRid8UpqOgnJTElA9yEI3msJPmeMrwMaNrxRNa6foUgWuo/druZO
         HYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692681; x=1716297481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQjruP9C1AriCa2NTVu4vY4iAh6hhbFru1ekZHix3gc=;
        b=hG1cRtF8uR8CYOnsI6gyhZFnytogGEqRKiZqbbNM/kgr/XMmoh412OAD75QFTjNeGp
         5P9NtBasjt0aKj0jM/dADggMxam728cqRVnq/iRlypLq6x4lqyaX+WmpWv+HQoMOD8la
         /bxB0myqoJLO3aRnohljjjURE04nAIdJZQIFgTqP/IVbgmQBJmCu+rIxcjWHoSDw07vO
         D3FQV+llogFVCJH7XHziUSVjMJkeN34zy2PfPrsqfPw+DtOrJYOkBC/jptXs/dhoT6Hv
         tr5YDvgCm2UcdK10yvgIoGd4OsFwyYNvZHIJ5+vh1Z/aTuNHb7pfxjzdDvZV2aW7Zkez
         zKKA==
X-Forwarded-Encrypted: i=1; AJvYcCWbS+c0bmcnufj4Z253ZSozCe1eCBZADO7nkaXoULUePGoz5GHonvT5C5grqjnJVwi+3LF6116HoomQVNO3JOKrjyGJ5JIgsjHAfdHXFOMguQ2yiPKikQKzyZ8GqaxlCZJvMkyKEapuAJMoR5RMDa8+Xl8hZEMeiAc8vuy6wPflsKD6urZojZTNlq5y
X-Gm-Message-State: AOJu0YxpDooNfWx9iVw9mkR83yEoABU5AMIXP7z3vgcESBGxQDFkBJeK
	Yo1hKcOmO9UYOp6ruj+hYfj4SvneUdZcTPL50TsYcEsKTnH7gfku
X-Google-Smtp-Source: AGHT+IF0ccCnxDgMImegz6x0hQMqkVTDNZ3JGlK9EGVqqovM/HatpeSxdHFfozw6V8+PvA/W2iWdNw==
X-Received: by 2002:a17:902:e94e:b0:1e2:688e:597d with SMTP id d9443c01a7336-1ef43d29892mr188026885ad.21.1715692680921;
        Tue, 14 May 2024 06:18:00 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:18:00 -0700 (PDT)
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
Subject: [RFC PATCH v2 22/30] rust: fs: add per-superblock data
Date: Tue, 14 May 2024 10:17:03 -0300
Message-Id: <20240514131711.379322-23-wedsonaf@gmail.com>
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

Allow Rust file systems to associate [typed] data to super blocks when
they're created. Since we only have a pointer-sized field in which to
store the state, it must implement the `ForeignOwnable` trait.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs.rs         | 46 ++++++++++++++++++++++++++++---------
 rust/kernel/fs/sb.rs      | 48 +++++++++++++++++++++++++++++++++++----
 samples/rust/rust_rofs.rs |  3 ++-
 3 files changed, 81 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 51de73008857..387e87e3edaf 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -7,7 +7,7 @@
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
 
 use crate::error::{code::*, from_result, to_result, Error, Result};
-use crate::types::Opaque;
+use crate::types::{ForeignOwnable, Opaque};
 use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
 use core::{ffi, marker::PhantomData, mem::ManuallyDrop, pin::Pin, ptr};
 use dentry::DEntry;
@@ -31,6 +31,9 @@
 
 /// A file system type.
 pub trait FileSystem {
+    /// Data associated with each file system instance (super-block).
+    type Data: ForeignOwnable + Send + Sync;
+
     /// The name of the file system type.
     const NAME: &'static CStr;
 
@@ -40,8 +43,8 @@ pub trait FileSystem {
     #[doc(hidden)]
     const IS_UNSPECIFIED: bool = false;
 
-    /// Initialises the new superblock.
-    fn fill_super(sb: &mut SuperBlock<Self>) -> Result;
+    /// Initialises the new superblock and returns the data to attach to it.
+    fn fill_super(sb: &mut SuperBlock<Self, sb::New>) -> Result<Self::Data>;
 
     /// Initialises and returns the root inode of the given superblock.
     ///
@@ -94,9 +97,10 @@ pub struct Stat {
 pub struct UnspecifiedFS;
 
 impl FileSystem for UnspecifiedFS {
+    type Data = ();
     const NAME: &'static CStr = crate::c_str!("unspecified");
     const IS_UNSPECIFIED: bool = true;
-    fn fill_super(_: &mut SuperBlock<Self>) -> Result {
+    fn fill_super(_: &mut SuperBlock<Self, sb::New>) -> Result {
         Err(ENOTSUPP)
     }
 
@@ -134,7 +138,7 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
                 fs.owner = module.0;
                 fs.name = T::NAME.as_char_ptr();
                 fs.init_fs_context = Some(Self::init_fs_context_callback::<T>);
-                fs.kill_sb = Some(Self::kill_sb_callback);
+                fs.kill_sb = Some(Self::kill_sb_callback::<T>);
                 fs.fs_flags = 0;
 
                 // SAFETY: Pointers stored in `fs` are static so will live for as long as the
@@ -155,10 +159,22 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
         })
     }
 
-    unsafe extern "C" fn kill_sb_callback(sb_ptr: *mut bindings::super_block) {
+    unsafe extern "C" fn kill_sb_callback<T: FileSystem + ?Sized>(
+        sb_ptr: *mut bindings::super_block,
+    ) {
         // SAFETY: In `get_tree_callback` we always call `get_tree_nodev`, so `kill_anon_super` is
         // the appropriate function to call for cleanup.
         unsafe { bindings::kill_anon_super(sb_ptr) };
+
+        // SAFETY: The C API contract guarantees that `sb_ptr` is valid for read.
+        let ptr = unsafe { (*sb_ptr).s_fs_info };
+        if !ptr.is_null() {
+            // SAFETY: The only place where `s_fs_info` is assigned is `NewSuperBlock::init`, where
+            // it's initialised with the result of an `into_foreign` call. We checked above that
+            // `ptr` is non-null because it would be null if we never reached the point where we
+            // init the field.
+            unsafe { T::Data::from_foreign(ptr) };
+        }
     }
 }
 
@@ -205,12 +221,19 @@ impl<T: FileSystem + ?Sized> Tables<T> {
             sb.s_xattr = &Tables::<T>::XATTR_HANDLERS[0];
             sb.s_flags |= bindings::SB_RDONLY;
 
-            T::fill_super(new_sb)?;
+            let data = T::fill_super(new_sb)?;
+
+            // N.B.: Even on failure, `kill_sb` is called and frees the data.
+            sb.s_fs_info = data.into_foreign().cast_mut();
 
-            let root = T::init_root(new_sb)?;
+            // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
+            // newly-created (and initialised above) superblock. And we have just initialised
+            // `s_fs_info`.
+            let sb = unsafe { SuperBlock::from_raw(sb_ptr) };
+            let root = T::init_root(sb)?;
 
             // Reject root inode if it belongs to a different superblock.
-            if !ptr::eq(root.super_block(), new_sb) {
+            if !ptr::eq(root.super_block(), sb) {
                 return Err(EINVAL);
             }
 
@@ -346,7 +369,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///
 /// ```
 /// # mod module_fs_sample {
-/// use kernel::fs::{dentry, inode::INode, sb::SuperBlock, self};
+/// use kernel::fs::{dentry, inode::INode, sb, sb::SuperBlock, self};
 /// use kernel::prelude::*;
 ///
 /// kernel::module_fs! {
@@ -359,8 +382,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///
 /// struct MyFs;
 /// impl fs::FileSystem for MyFs {
+///     type Data = ();
 ///     const NAME: &'static CStr = kernel::c_str!("myfs");
-///     fn fill_super(_: &mut SuperBlock<Self>) -> Result {
+///     fn fill_super(_: &mut SuperBlock<Self, sb::New>) -> Result {
 ///         todo!()
 ///     }
 ///     fn init_root(_sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
diff --git a/rust/kernel/fs/sb.rs b/rust/kernel/fs/sb.rs
index fa10f3db5593..7c0c52e6da0a 100644
--- a/rust/kernel/fs/sb.rs
+++ b/rust/kernel/fs/sb.rs
@@ -10,19 +10,37 @@
 use super::FileSystem;
 use crate::bindings;
 use crate::error::{code::*, Result};
-use crate::types::{ARef, Either, Opaque};
+use crate::types::{ARef, Either, ForeignOwnable, Opaque};
 use core::{marker::PhantomData, ptr};
 
+/// A typestate for [`SuperBlock`] that indicates that it's a new one, so not fully initialized
+/// yet.
+pub struct New;
+
+/// A typestate for [`SuperBlock`] that indicates that it's ready to be used.
+pub struct Ready;
+
+// SAFETY: Instances of `SuperBlock<T, Ready>` are only created after initialising the data.
+unsafe impl DataInited for Ready {}
+
+/// Indicates that a superblock in this typestate has data initialized.
+///
+/// # Safety
+///
+/// Implementers must ensure that `s_fs_info` is properly initialised in this state.
+#[doc(hidden)]
+pub unsafe trait DataInited {}
+
 /// A file system super block.
 ///
 /// Wraps the kernel's `struct super_block`.
 #[repr(transparent)]
-pub struct SuperBlock<T: FileSystem + ?Sized>(
+pub struct SuperBlock<T: FileSystem + ?Sized, S = Ready>(
     pub(crate) Opaque<bindings::super_block>,
-    PhantomData<T>,
+    PhantomData<(S, T)>,
 );
 
-impl<T: FileSystem + ?Sized> SuperBlock<T> {
+impl<T: FileSystem + ?Sized, S> SuperBlock<T, S> {
     /// Creates a new superblock reference from the given raw pointer.
     ///
     /// # Safety
@@ -31,6 +49,7 @@ impl<T: FileSystem + ?Sized> SuperBlock<T> {
     ///
     /// * `ptr` is valid and remains so for the lifetime of the returned object.
     /// * `ptr` has the correct file system type, or `T` is [`super::UnspecifiedFS`].
+    /// * `ptr` in the right typestate.
     pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::super_block) -> &'a Self {
         // SAFETY: The safety requirements guarantee that the cast below is ok.
         unsafe { &*ptr.cast::<Self>() }
@@ -44,6 +63,7 @@ pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::super_block) -> &'a Self {
     ///
     /// * `ptr` is valid and remains so for the lifetime of the returned object.
     /// * `ptr` has the correct file system type, or `T` is [`super::UnspecifiedFS`].
+    /// * `ptr` in the right typestate.
     /// * `ptr` is the only active pointer to the superblock.
     pub(crate) unsafe fn from_raw_mut<'a>(ptr: *mut bindings::super_block) -> &'a mut Self {
         // SAFETY: The safety requirements guarantee that the cast below is ok.
@@ -55,7 +75,9 @@ pub fn rdonly(&self) -> bool {
         // SAFETY: `s_flags` only changes during init, so it is safe to read it.
         unsafe { (*self.0.get()).s_flags & bindings::SB_RDONLY != 0 }
     }
+}
 
+impl<T: FileSystem + ?Sized> SuperBlock<T, New> {
     /// Sets the magic number of the superblock.
     pub fn set_magic(&mut self, magic: usize) -> &mut Self {
         // SAFETY: This is a new superblock that is being initialised, so it's ok to write to its
@@ -63,8 +85,26 @@ pub fn set_magic(&mut self, magic: usize) -> &mut Self {
         unsafe { (*self.0.get()).s_magic = magic as core::ffi::c_ulong };
         self
     }
+}
+
+impl<T: FileSystem + ?Sized, S: DataInited> SuperBlock<T, S> {
+    /// Returns the data associated with the superblock.
+    pub fn data(&self) -> <T::Data as ForeignOwnable>::Borrowed<'_> {
+        if T::IS_UNSPECIFIED {
+            crate::build_error!("super block data type is unspecified");
+        }
+
+        // SAFETY: This method is only available if the typestate implements `DataInited`, whose
+        // safety requirements include `s_fs_info` being properly initialised.
+        let ptr = unsafe { (*self.0.get()).s_fs_info };
+        unsafe { T::Data::borrow(ptr) }
+    }
 
     /// Tries to get an existing inode or create a new one if it doesn't exist yet.
+    ///
+    /// This method is not callable from a superblock where data isn't inited yet because it would
+    /// allow one to get access to the uninited data via `inode::New::init()` ->
+    /// `INode::super_block()` -> `SuperBlock::data()`.
     pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<INode<T>>, inode::New<T>>> {
         // SAFETY: All superblock-related state needed by `iget_locked` is initialised by C code
         // before calling `fill_super_callback`, or by `fill_super_callback` itself before calling
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 7a09e2db878d..7027ca067f8f 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -98,9 +98,10 @@ fn iget(sb: &sb::SuperBlock<Self>, e: &'static Entry) -> Result<ARef<INode<Self>
 }
 
 impl fs::FileSystem for RoFs {
+    type Data = ();
     const NAME: &'static CStr = c_str!("rust_rofs");
 
-    fn fill_super(sb: &mut sb::SuperBlock<Self>) -> Result {
+    fn fill_super(sb: &mut sb::SuperBlock<Self, sb::New>) -> Result {
         sb.set_magic(0x52555354);
         Ok(())
     }
-- 
2.34.1


