Return-Path: <linux-fsdevel+bounces-19448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C658C5710
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2668B221C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517815EFAD;
	Tue, 14 May 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOQoRym4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B380E144D10;
	Tue, 14 May 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692687; cv=none; b=lA8iYRTXJZC8FemlJHmgimmUEZAuAZLOZdGTjpQsO7Ux+20kFMiOo9hHn7y2I3fnlgMeFZhU7HGZjvAAxd6XjT9o04uVkJgkTGDmwBfDQvQMbkkI0b1ZBFhA+uNE30QiUs4+na2y/AdhqdrT0P9V6NX4LUW0QKNbG15r4iPPiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692687; c=relaxed/simple;
	bh=oKKKcGDsAVvN6kc943QPv5br805N5TRJBcdskzMsU2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNP4BYaPjwO2mqk6jCGahMD1b/3VGoIRDU6AnUiGySaPz3bgqbL+0YGJEatSgGJbhevHGNcoWrh7wTZffqHmYQi+oPq5JOtJ5iZ8BC1g9AGKZ+EKRSAEHORa9qHAxpjoB+QQTbkUEzZa8mj+iIsMtQ1eOQdGXDrVBESD9ipk4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOQoRym4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ee5235f5c9so42975755ad.2;
        Tue, 14 May 2024 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692685; x=1716297485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCzmFrau90TAwq/dSawTTHAfKetirw11Aj2X0VbDWSo=;
        b=MOQoRym492aak6kagIkmueyBwfOgg9QeDTKADLggivmRedN7RTUzPInSaAxh7OzRfa
         1nn+T3Gf9a9hymGXzuywC78gRYTRt3RF7huLb290WkD27WroXAf/kubQ2LTer0Z6GzJD
         hYIrxNDCli4/uTPnYacVxqypjIDRsPG34zUHlVtaw42BmLpbWpUvg26ANH6le8x/iHFI
         P7Zhv7Wcfbh6pipJGkddm2kvMpEOKv9zAdQscenSyASfb2XMptrXhTYXSIO854ECaKo2
         WgC2F8aWPsKZAAtRdxHZap08yzD0K4dVQgw30HandVICmlQ3pxn80mrXN+4aOlbXZbS9
         JDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692685; x=1716297485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCzmFrau90TAwq/dSawTTHAfKetirw11Aj2X0VbDWSo=;
        b=uqjxDWCCCQh4w0z0GS7mwwJ3cAXoB4lJ1TKXXWaezUiUsI8ttRZ6F0RQiDlMHr/Y7O
         qxUYTMI4yOz1nL2H+xFuq6mV2lcQns1b4EqcX003ayHg1FeL7AEWqN9f3FFtXsJG2CLO
         WuAw4aygdSNpEhUS/By2NL8MgnDLWwD0APZ1SbCEF66q8IaPRflpsgmo+6SEc/H2CQ/X
         qqd+FGuSExBOKR0ub9f04NUwQqaZvGGti1cR0Ws+hwLVn4CVK4FF6UybG92PzOTrc3Ot
         FDVjU7ruAYZ5DUoVw+hJu2CQTZir5LfZtBiwP9qJNK517BVDnRqNmLTn8e22znh6419V
         bggw==
X-Forwarded-Encrypted: i=1; AJvYcCXk8DnqLGd5ch46vSD35AnbMNxJ//oJRgp8edZmZ8GCYEOMVJvWb8jSeQIUCZlrBvJQhysVrSgWpklTvu+F47lWI7SEDHnm2HPkdJqRftlJ0lP+53LN4G9zuKqxEaWnEYncdx7J8dVNEecWCaZEscn07vOy3+rv9BGw5AvauR+gX9+qdvbGqoxlQmjm
X-Gm-Message-State: AOJu0Ywn3JheqrSR28mlj/ACX1aBGIF+u1ndpwp+i73VbJhCpNkyNxZQ
	uB9f25/R5/LSWwr3avjtsoug4TpicrRjTq+UecT/02k37+NtBR1m
X-Google-Smtp-Source: AGHT+IG3EsvAG0GsoCpOHzO+54+s+5hzgq3h/bNRZnn4zxAFrlD5PruuV+7qgLd5a3qyV5z5YZpO1Q==
X-Received: by 2002:a17:903:32cd:b0:1ee:b0db:e74a with SMTP id d9443c01a7336-1ef43e28493mr164341695ad.40.1715692684914;
        Tue, 14 May 2024 06:18:04 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:18:04 -0700 (PDT)
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
Subject: [RFC PATCH v2 26/30] rust: fs: allow populating i_lnk
Date: Tue, 14 May 2024 10:17:07 -0300
Message-Id: <20240514131711.379322-27-wedsonaf@gmail.com>
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

Allow Rust file systems to store a string that represents the
destination of a symbolic link inode in the inode itself.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs/file.rs    |  6 ++---
 rust/kernel/fs/inode.rs   | 32 +++++++++++++++++++++----
 samples/rust/rust_rofs.rs | 50 ++++++++++++---------------------------
 3 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index a819724b75f8..9db70eff1169 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -518,15 +518,15 @@ pub enum DirEntryType {
     Wht = bindings::DT_WHT,
 }
 
-impl From<inode::Type> for DirEntryType {
-    fn from(value: inode::Type) -> Self {
+impl From<&inode::Type> for DirEntryType {
+    fn from(value: &inode::Type) -> Self {
         match value {
             inode::Type::Fifo => DirEntryType::Fifo,
             inode::Type::Chr(_, _) => DirEntryType::Chr,
             inode::Type::Dir => DirEntryType::Dir,
             inode::Type::Blk(_, _) => DirEntryType::Blk,
             inode::Type::Reg => DirEntryType::Reg,
-            inode::Type::Lnk => DirEntryType::Lnk,
+            inode::Type::Lnk(_) => DirEntryType::Lnk,
             inode::Type::Sock => DirEntryType::Sock,
         }
     }
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index 5230ff2fe0dd..b2b7d000080e 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -7,8 +7,8 @@
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
 
 use super::{
-    address_space, dentry, dentry::DEntry, file, sb::SuperBlock, FileSystem, Offset, PageOffset,
-    UnspecifiedFS,
+    address_space, dentry, dentry::DEntry, file, mode, sb::SuperBlock, FileSystem, Offset,
+    PageOffset, UnspecifiedFS,
 };
 use crate::error::{code::*, from_err_ptr, Result};
 use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Lockable, Locked, Opaque};
@@ -255,6 +255,17 @@ pub(crate) fn new_cache() -> Result<Option<MemCache>> {
         let ptr = container_of!(inode, WithData<T::INodeData>, inode).cast_mut();
 
         if !is_bad {
+            // SAFETY: The API contract guarantees that `inode` is valid.
+            if unsafe { (*inode).i_mode & mode::S_IFMT == mode::S_IFLNK } {
+                // SAFETY: We just checked that the inode is a link.
+                let lnk = unsafe { (*inode).__bindgen_anon_4.i_link };
+                if !lnk.is_null() {
+                    // SAFETY: This value is on link inode are only populated from with the result
+                    // of `CString::into_foreign`.
+                    unsafe { CString::from_foreign(lnk.cast::<core::ffi::c_void>()) };
+                }
+            }
+
             // SAFETY: The code either initialises the data or marks the inode as bad. Since the
             // inode is not bad, the data is initialised, and thus safe to drop.
             unsafe { ptr::drop_in_place((*ptr).data.as_mut_ptr()) };
@@ -381,7 +392,7 @@ pub fn init(self, params: Params<T::INodeData>) -> Result<ARef<INode<T>>> {
                 unsafe { bindings::mapping_set_large_folios(inode.i_mapping) };
                 bindings::S_IFREG
             }
-            Type::Lnk => {
+            Type::Lnk(str) => {
                 // If we are using `page_get_link`, we need to prevent the use of high mem.
                 if !inode.i_op.is_null() {
                     // SAFETY: We just checked that `i_op` is non-null, and we always just set it
@@ -393,6 +404,9 @@ pub fn init(self, params: Params<T::INodeData>) -> Result<ARef<INode<T>>> {
                         unsafe { bindings::inode_nohighmem(inode) };
                     }
                 }
+                if let Some(s) = str {
+                    inode.__bindgen_anon_4.i_link = s.into_foreign().cast::<i8>().cast_mut();
+                }
                 bindings::S_IFLNK
             }
             Type::Fifo => {
@@ -485,7 +499,6 @@ fn drop(&mut self) {
 }
 
 /// The type of an inode.
-#[derive(Copy, Clone)]
 pub enum Type {
     /// Named pipe (first-in, first-out) type.
     Fifo,
@@ -503,7 +516,7 @@ pub enum Type {
     Reg,
 
     /// Symbolic link type.
-    Lnk,
+    Lnk(Option<CString>),
 
     /// Named unix-domain socket type.
     Sock,
@@ -565,6 +578,15 @@ pub fn page_symlink_inode() -> Self {
         )
     }
 
+    /// Returns inode operations for symbolic links that are stored in the `i_lnk` field.
+    pub fn simple_symlink_inode() -> Self {
+        // SAFETY: This is a constant in C, it never changes.
+        Self(
+            unsafe { &bindings::simple_symlink_inode_operations },
+            PhantomData,
+        )
+    }
+
     /// Creates the inode operations from a type that implements the [`Operations`] trait.
     pub const fn new<U: Operations<FileSystem = T> + ?Sized>() -> Self {
         struct Table<T: Operations + ?Sized>(PhantomData<T>);
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 5b6c3f50adf4..5d0d1936459d 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -7,7 +7,7 @@
 };
 use kernel::prelude::*;
 use kernel::types::{ARef, Either, Locked};
-use kernel::{c_str, folio::Folio, folio::PageCache, fs, str::CString, time::UNIX_EPOCH, user};
+use kernel::{c_str, folio::Folio, folio::PageCache, fs, time::UNIX_EPOCH, user};
 
 kernel::module_fs! {
     type: RoFs,
@@ -46,7 +46,7 @@ struct Entry {
     Entry {
         name: b"link.txt",
         ino: 3,
-        etype: inode::Type::Lnk,
+        etype: inode::Type::Lnk(None),
         contents: b"./test.txt",
     },
 ];
@@ -54,7 +54,6 @@ struct Entry {
 const DIR_FOPS: file::Ops<RoFs> = file::Ops::new::<RoFs>();
 const DIR_IOPS: inode::Ops<RoFs> = inode::Ops::new::<RoFs>();
 const FILE_AOPS: address_space::Ops<RoFs> = address_space::Ops::new::<RoFs>();
-const LNK_IOPS: inode::Ops<RoFs> = inode::Ops::new::<Link>();
 
 struct RoFs;
 
@@ -65,25 +64,30 @@ fn iget(sb: &sb::SuperBlock<Self>, e: &'static Entry) -> Result<ARef<INode<Self>
             Either::Right(new) => new,
         };
 
-        let (mode, nlink, size) = match e.etype {
+        let (mode, nlink, size, typ) = match e.etype {
             inode::Type::Dir => {
                 new.set_iops(DIR_IOPS).set_fops(DIR_FOPS);
-                (0o555, 2, ENTRIES.len().try_into()?)
+                (0o555, 2, ENTRIES.len().try_into()?, inode::Type::Dir)
             }
             inode::Type::Reg => {
                 new.set_fops(file::Ops::generic_ro_file())
                     .set_aops(FILE_AOPS);
-                (0o444, 1, e.contents.len().try_into()?)
+                (0o444, 1, e.contents.len().try_into()?, inode::Type::Reg)
             }
-            inode::Type::Lnk => {
-                new.set_iops(LNK_IOPS);
-                (0o444, 1, e.contents.len().try_into()?)
+            inode::Type::Lnk(_) => {
+                new.set_iops(inode::Ops::simple_symlink_inode());
+                (
+                    0o444,
+                    1,
+                    e.contents.len().try_into()?,
+                    inode::Type::Lnk(Some(e.contents.try_into()?)),
+                )
             }
             _ => return Err(ENOENT),
         };
 
         new.init(inode::Params {
-            typ: e.etype,
+            typ,
             mode,
             size,
             blocks: (u64::try_from(size)? + 511) / 512,
@@ -138,30 +142,6 @@ fn lookup(
     }
 }
 
-struct Link;
-#[vtable]
-impl inode::Operations for Link {
-    type FileSystem = RoFs;
-
-    fn get_link<'a>(
-        dentry: Option<&DEntry<RoFs>>,
-        inode: &'a INode<RoFs>,
-    ) -> Result<Either<CString, &'a CStr>> {
-        if dentry.is_none() {
-            return Err(ECHILD);
-        }
-
-        let name_buf = inode.data().contents;
-        let mut name = Box::new_slice(
-            name_buf.len().checked_add(1).ok_or(ENOMEM)?,
-            b'\0',
-            GFP_NOFS,
-        )?;
-        name[..name_buf.len()].copy_from_slice(name_buf);
-        Ok(Either::Left(name.try_into()?))
-    }
-}
-
 #[vtable]
 impl address_space::Operations for RoFs {
     type FileSystem = Self;
@@ -212,7 +192,7 @@ fn read_dir(
         }
 
         for e in ENTRIES.iter().skip(pos.try_into()?) {
-            if !emitter.emit(1, e.name, e.ino, e.etype.into()) {
+            if !emitter.emit(1, e.name, e.ino, (&e.etype).into()) {
                 break;
             }
         }
-- 
2.34.1


