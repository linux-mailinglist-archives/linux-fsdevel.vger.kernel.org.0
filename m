Return-Path: <linux-fsdevel+bounces-19437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D688C56F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B551C222F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85B154C1E;
	Tue, 14 May 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOENLJ2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE921553B4;
	Tue, 14 May 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692676; cv=none; b=tPI5hMZstuCGLlpEtIjugI+kCigqaxOKOvzxyWG3nTAkKTW9/lme574nw+P0Qz6SJA0WYjNmgbb0QrRagw+SA+oGhc47HkJ1/1GsvigPR/4+jRioPgstKeDaV7y6ZdB+CzNtRusiT2c/dGTFf6BlFS3kdI52SBpNYNoslJn1mbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692676; c=relaxed/simple;
	bh=3Yd39esXT+u62EdLtna/vNE2HE8gT4z3hM3aUbO9QMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptL7nkuLFNtHw8hnL8TkwrOAXsGFkLVjCoGdqKSo+jvU6CvAteEMKsozrg7ByitPLMDBZXT8PiO0Dk+jxNvPLSm1IhP6LJaBEDI6j9eDq9k6hxcxy0JGryfMRJ9YgLOiNyqfL5OoLeHAGNWYkcIuOH8HmAE5Wsk/iRbKuJW4mQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOENLJ2e; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so32610405ad.1;
        Tue, 14 May 2024 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692674; x=1716297474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPU1PJsyXhU7+DXDV5zAoABFidh9cJJCkXkEr28GmXk=;
        b=UOENLJ2e5G41UFgCyrHk7D1T7fwgcmlLGBAqN0Be8TV+t6Jx/uncEHN2SV/6oBwKeL
         A/bTYQjUFQuqCMCxD39iK8sDJ57X7rEMF2w6TB7JtOlqGOBBdS+mBBugwLL87qKE9ZfS
         krhr4TfSaGJus8MM7e7EAiJYKWBzHCJ6ayRHXL1coR1TK31QGmCuu7OedysolxpsPDzL
         9TmodVv99jvulnnHw+YRmZHPwniXJ1mEnESorSgQVMvQgPBcU4amXzm54tVVjkwwtPM4
         koU+EvuKQNwru7CDhE+Yk3IZPBN+cd3Ry4nMpYfC4MMXCCN1b74KGrTDfJhx7DbjR1B3
         zuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692674; x=1716297474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPU1PJsyXhU7+DXDV5zAoABFidh9cJJCkXkEr28GmXk=;
        b=coSAHyXsyjNtIg8nlo9yXZnOp2QvoWQkSoBxTxVC118AZ3k1SxuYp/SxHls8Pjn2k9
         cg62Zn13n40dchVDEBNcD54VCVHaShr7ZDNuGlzdYRzo0DGorqZzoOCtPAYSQ+StD6IZ
         Fhhqbezls7mnZqQBpU43esfu9ZuTamKjuJNjt5QkF3owL1SlhkPe45jvBmiypZ4vcQIQ
         trmjjuv+JadhtWG4Fy8KRQtt15lIjEB9vmc1aVq23pjAE/95wNDB5rZ87+hd1LZ4SyoL
         jtua5xkpvihtNdZ+pulXyc/giOdEyo6pm3zHiiUuhqiujU1YfvFSSi+/OjHyhdRJ4VBe
         rudQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqW5ao4UM+C9234peLwu17Y77/8Xa43NNfNw7c087DP/7EmtA2NyyosiFTlUWcMT3P4JIRDuMk7aM+VXNSM02Aem8Lakt9u/UIpf6rbh8SNSkuPur4yJNqanMSN12IoHuPsjAh+VoOYVVl0bXuevezSbe0QBnFHFq/Gf7z91SvvDPolkLW+ytj7ujf
X-Gm-Message-State: AOJu0Yxq8qC6MxiOrIP4PXS71x/lr7XE32Q2efJ61MsiQ42PhA2bPO2h
	lcw6X4UxMRej58HLoJrgmJqRfVLVt568+TRzSCvHEWxLowAg1R1h
X-Google-Smtp-Source: AGHT+IGZgiXvKq66GWWkIsokJFEZ4y+wsWbeZwDVtxGtQYiDniSMBXMpzmoUlEnQkpk4DBvhoGWUiA==
X-Received: by 2002:a17:902:da8e:b0:1e4:48a6:968b with SMTP id d9443c01a7336-1ef43c0cf05mr141137145ad.13.1715692673747;
        Tue, 14 May 2024 06:17:53 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:53 -0700 (PDT)
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
Subject: [RFC PATCH v2 15/30] rust: fs: introduce `inode::Operations::lookup`
Date: Tue, 14 May 2024 10:16:56 -0300
Message-Id: <20240514131711.379322-16-wedsonaf@gmail.com>
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

Allow Rust file systems to create inodes that are children of a
directory inode when they're looked up by name.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/error.rs      |  1 -
 rust/kernel/fs/dentry.rs  |  1 -
 rust/kernel/fs/inode.rs   | 58 ++++++++++++++++++++++++-----
 samples/rust/rust_rofs.rs | 77 +++++++++++++++++++++++++++++----------
 4 files changed, 105 insertions(+), 32 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index bb13bd4a7fa6..15628d2fa3b2 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -129,7 +129,6 @@ pub fn to_errno(self) -> core::ffi::c_int {
     }
 
     /// Returns the error encoded as a pointer.
-    #[allow(dead_code)]
     pub(crate) fn to_ptr<T>(self) -> *mut T {
         // SAFETY: `self.0` is a valid error due to its invariant.
         unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
diff --git a/rust/kernel/fs/dentry.rs b/rust/kernel/fs/dentry.rs
index 6a36a48cd28b..c93debb70ea3 100644
--- a/rust/kernel/fs/dentry.rs
+++ b/rust/kernel/fs/dentry.rs
@@ -43,7 +43,6 @@ impl<T: FileSystem + ?Sized> DEntry<T> {
     ///
     /// * `ptr` must be valid for at least the lifetime of the returned reference.
     /// * `ptr` has the correct file system type, or `T` is [`super::UnspecifiedFS`].
-    #[allow(dead_code)]
     pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::dentry) -> &'a Self {
         // SAFETY: The safety requirements guarantee that the reference is and remains valid.
         unsafe { &*ptr.cast::<Self>() }
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index 3d65b917af0e..c314d036c87e 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -6,9 +6,9 @@
 //!
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
 
-use super::{file, sb::SuperBlock, FileSystem, Offset, UnspecifiedFS};
-use crate::error::Result;
-use crate::types::{ARef, AlwaysRefCounted, Lockable, Opaque};
+use super::{dentry, dentry::DEntry, file, sb::SuperBlock, FileSystem, Offset, UnspecifiedFS};
+use crate::error::{code::*, Result};
+use crate::types::{ARef, AlwaysRefCounted, Lockable, Locked, Opaque};
 use crate::{bindings, block, time::Timespec};
 use core::mem::ManuallyDrop;
 use core::{marker::PhantomData, ptr};
@@ -22,6 +22,14 @@
 pub trait Operations {
     /// File system that these operations are compatible with.
     type FileSystem: FileSystem + ?Sized;
+
+    /// Returns the inode corresponding to the directory entry with the given name.
+    fn lookup(
+        _parent: &Locked<&INode<Self::FileSystem>, ReadSem>,
+        _dentry: dentry::Unhashed<'_, Self::FileSystem>,
+    ) -> Result<Option<ARef<DEntry<Self::FileSystem>>>> {
+        Err(ENOTSUPP)
+    }
 }
 
 /// A node (inode) in the file index.
@@ -118,12 +126,7 @@ pub fn init(mut self, params: Params) -> Result<ARef<INode<T>>> {
         // SAFETY: This is a new inode, so it's safe to manipulate it mutably.
         let inode = unsafe { self.0.as_mut() };
         let mode = match params.typ {
-            Type::Dir => {
-                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
-                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
-
-                bindings::S_IFDIR
-            }
+            Type::Dir => bindings::S_IFDIR,
         };
 
         inode.i_mode = (params.mode & 0o777) | u16::try_from(mode)?;
@@ -148,6 +151,14 @@ pub fn init(mut self, params: Params) -> Result<ARef<INode<T>>> {
         Ok(unsafe { ARef::from_raw(manual.0.cast::<INode<T>>()) })
     }
 
+    /// Sets the inode operations on this new inode.
+    pub fn set_iops(&mut self, iops: Ops<T>) -> &mut Self {
+        // SAFETY: By the type invariants, it's ok to modify the inode.
+        let inode = unsafe { self.0.as_mut() };
+        inode.i_op = iops.0;
+        self
+    }
+
     /// Sets the file operations on this new inode.
     pub fn set_fops(&mut self, fops: file::Ops<T>) -> &mut Self {
         // SAFETY: By the type invariants, it's ok to modify the inode.
@@ -221,7 +232,11 @@ pub const fn new<U: Operations<FileSystem = T> + ?Sized>() -> Self {
         struct Table<T: Operations + ?Sized>(PhantomData<T>);
         impl<T: Operations + ?Sized> Table<T> {
             const TABLE: bindings::inode_operations = bindings::inode_operations {
-                lookup: None,
+                lookup: if T::HAS_LOOKUP {
+                    Some(Self::lookup_callback)
+                } else {
+                    None
+                },
                 get_link: None,
                 permission: None,
                 get_inode_acl: None,
@@ -247,6 +262,29 @@ impl<T: Operations + ?Sized> Table<T> {
                 fileattr_get: None,
                 get_offset_ctx: None,
             };
+
+            extern "C" fn lookup_callback(
+                parent_ptr: *mut bindings::inode,
+                dentry_ptr: *mut bindings::dentry,
+                _flags: u32,
+            ) -> *mut bindings::dentry {
+                // SAFETY: The C API guarantees that `parent_ptr` is a valid inode.
+                let parent = unsafe { INode::from_raw(parent_ptr) };
+
+                // SAFETY: The C API guarantees that `dentry_ptr` is a valid dentry.
+                let dentry = unsafe { DEntry::from_raw(dentry_ptr) };
+
+                // SAFETY: The C API guarantees that the inode's rw semaphore is locked at least in
+                // read mode. It does not expect callees to unlock it, so we make the locked object
+                // manually dropped to avoid unlocking it.
+                let locked = ManuallyDrop::new(unsafe { Locked::new(parent) });
+
+                match T::lookup(&locked, dentry::Unhashed(dentry)) {
+                    Err(e) => e.to_ptr(),
+                    Ok(None) => ptr::null_mut(),
+                    Ok(Some(ret)) => ManuallyDrop::new(ret).0.get(),
+                }
+            }
         }
         Self(&Table::<U>::TABLE, PhantomData)
     }
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index f4be5908369c..2a87e524e0e1 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -2,9 +2,11 @@
 
 //! Rust read-only file system sample.
 
-use kernel::fs::{dentry, file, file::File, inode, inode::INode, sb::SuperBlock, Offset};
+use kernel::fs::{
+    dentry, dentry::DEntry, file, file::File, inode, inode::INode, sb::SuperBlock, Offset,
+};
 use kernel::prelude::*;
-use kernel::{c_str, fs, time::UNIX_EPOCH, types::Either, types::Locked, user};
+use kernel::{c_str, fs, time::UNIX_EPOCH, types::ARef, types::Either, types::Locked, user};
 
 kernel::module_fs! {
     type: RoFs,
@@ -39,8 +41,36 @@ struct Entry {
 ];
 
 const DIR_FOPS: file::Ops<RoFs> = file::Ops::new::<RoFs>();
+const DIR_IOPS: inode::Ops<RoFs> = inode::Ops::new::<RoFs>();
 
 struct RoFs;
+
+impl RoFs {
+    fn iget(sb: &SuperBlock<Self>, e: &'static Entry) -> Result<ARef<INode<Self>>> {
+        let mut new = match sb.get_or_create_inode(e.ino)? {
+            Either::Left(existing) => return Ok(existing),
+            Either::Right(new) => new,
+        };
+
+        match e.etype {
+            inode::Type::Dir => new.set_iops(DIR_IOPS).set_fops(DIR_FOPS),
+        };
+
+        new.init(inode::Params {
+            typ: e.etype,
+            mode: 0o555,
+            size: ENTRIES.len().try_into()?,
+            blocks: 1,
+            nlink: 2,
+            uid: 0,
+            gid: 0,
+            atime: UNIX_EPOCH,
+            ctime: UNIX_EPOCH,
+            mtime: UNIX_EPOCH,
+        })
+    }
+}
+
 impl fs::FileSystem for RoFs {
     const NAME: &'static CStr = c_str!("rust_rofs");
 
@@ -50,28 +80,35 @@ fn fill_super(sb: &mut SuperBlock<Self>) -> Result {
     }
 
     fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
-        let inode = match sb.get_or_create_inode(1)? {
-            Either::Left(existing) => existing,
-            Either::Right(mut new) => {
-                new.set_fops(DIR_FOPS);
-                new.init(inode::Params {
-                    typ: inode::Type::Dir,
-                    mode: 0o555,
-                    size: ENTRIES.len().try_into()?,
-                    blocks: 1,
-                    nlink: 2,
-                    uid: 0,
-                    gid: 0,
-                    atime: UNIX_EPOCH,
-                    ctime: UNIX_EPOCH,
-                    mtime: UNIX_EPOCH,
-                })?
-            }
-        };
+        let inode = Self::iget(sb, &ENTRIES[0])?;
         dentry::Root::try_new(inode)
     }
 }
 
+#[vtable]
+impl inode::Operations for RoFs {
+    type FileSystem = Self;
+
+    fn lookup(
+        parent: &Locked<&INode<Self>, inode::ReadSem>,
+        dentry: dentry::Unhashed<'_, Self>,
+    ) -> Result<Option<ARef<DEntry<Self>>>> {
+        if parent.ino() != 1 {
+            return dentry.splice_alias(None);
+        }
+
+        let name = dentry.name();
+        for e in &ENTRIES {
+            if name == e.name {
+                let inode = Self::iget(parent.super_block(), e)?;
+                return dentry.splice_alias(Some(inode));
+            }
+        }
+
+        dentry.splice_alias(None)
+    }
+}
+
 #[vtable]
 impl file::Operations for RoFs {
     type FileSystem = Self;
-- 
2.34.1


