Return-Path: <linux-fsdevel+bounces-19443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540F8C5704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C271F228FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4320E15AAD3;
	Tue, 14 May 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5rfFb63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C7158D71;
	Tue, 14 May 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692682; cv=none; b=cbQG2e9MUBUSRovx38h+l3QinPxhcFFnzrvL8D5moC6UVb0UYVegxKljq+LN0XO4Mmdl05l33aD6IgWD0dqH/Rn3+inbwm4/YNoL6RsK5ydFy3HM8lfFXo6AJzSR/Eo8lLHMIjiRaHnRijHJRapUaSoFHX8bqCZhCSh6fX58hOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692682; c=relaxed/simple;
	bh=RywbUaAT/EYW5MpK30YcRz29IPNhRSI+g/oBxyh8h1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lwv/Uj0pvYYBABx5Z9Daj8bztWqGdArK/tBwX87QmeKL+hS6GCghEIB8BLa4HM4wfYxKL4JhdgVQfjSu1hTLtTfT40rkSNw9pbsHhLUARaNc38O6r+rUgWKkgiV4xvEvkgN/kAWXrOi31cnvRP48LeBQ00I+ppXNGGGvFR3jjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5rfFb63; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ed835f3c3cso48641165ad.3;
        Tue, 14 May 2024 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692680; x=1716297480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLqaimEXO3VdUIpcOo6tJgmfUsLAFcxXUsmbWwkqX78=;
        b=H5rfFb63y7MKUvxtVJn9BTTv8Irby+l0QEvHU4HksBEsBK+3s4jTRgG/mEbN4tOYjY
         m1Xz5xP11oCw0DVek+6tmPEilZC41IqLboqA9oNgwh5qk3leFaSDtEXCCY/RXB1b9rce
         5FdDrKmbmO/UwrxKqfpia7NPe01qXO2QIYf6k/YKoAsPjoG2V3DVvnnsCF0jZSrZZnWv
         7WrTH84E4bbDh8SEy3SBdsKNnhcZ9xDl5sT3WTDBv7wSBuynwalV9Ks2GgPg0LMxJG7O
         i7YbKm7fgPmJkmmwgm/ySUt8ObvuCkmtH4YNS+XkgpfCcQAwB6jFEkIfXIuXcEwWPUyj
         Qnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692680; x=1716297480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLqaimEXO3VdUIpcOo6tJgmfUsLAFcxXUsmbWwkqX78=;
        b=k9JWG6IVqxZaztj+rh6sN4RYfW5aJoJN0BkEwRR1VKPjP0dBJ2M+rKFYKVk1PWC8k0
         RiLhZAUNbsMpC/Eoqke6d6BAyaBoyEjwfBT7cAP3wU7Kbg6kOwSWijG2A/2S/rcjGKwE
         /lX1ooWZAUENmiXs91D4Sv38o/GeBEa7yhtyOsQZ0idaFp6eLOc30tDYkCdo7TQ7Gocy
         AdND1UFs8ZEBwmh8VZtEpw0+5U9vv5DulXCszBhp85PYUxGWlVn5LyZ6h3s+08nR/fWi
         zPdXq3Eiih8VX3c8Q4ABaQwCC0gACtbkOmnNI/vsYDsrrZXOeZ/Qf6mtEfHktz90VLnS
         pOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnEwdDEF11XDZ11KNq+tBU2Q7KSSiblJ7Z0FOYeOX7JE5L5xUfbIZF0Y7Pg2o1t7K52K0oARHVTrMw3/qaVTeqfPahMqCJ9CAWQx3HtH4pHZrmHJb2dVAhOdsiG07JXnj9QtCm2QQTDSu/2xmkK0z9yN35S48wlhsW4jhlUBo5ExupkTDT0KntMzfS
X-Gm-Message-State: AOJu0Yy/K/x+Ce7bRs7c4U+r7zpm9yJf+oolOdbLQshBQGetWh1wjpdA
	h+lt9KdFYQZm+zAWWOI9CAfAUjtYhVyYfQljVfOphkTopgl3YGKW
X-Google-Smtp-Source: AGHT+IEqPomU5IXx8ghDZu5aqnLcgRuh9JWmg6bIGejvgyfZYgEwnB3eJghqcnMJ3KiY0LiyUV67FA==
X-Received: by 2002:a17:902:a514:b0:1ed:8d7c:d58e with SMTP id d9443c01a7336-1ef43e2836emr134109465ad.29.1715692680017;
        Tue, 14 May 2024 06:18:00 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:59 -0700 (PDT)
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
Subject: [RFC PATCH v2 21/30] rust: fs: introduce more inode types
Date: Tue, 14 May 2024 10:17:02 -0300
Message-Id: <20240514131711.379322-22-wedsonaf@gmail.com>
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

Allow Rust file system modules to create inodes that are symlinks,
pipes, sockets, char devices and block devices (in addition to the
already-supported directories and regular files).

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c            |  13 ++++
 rust/kernel/fs/file.rs    |   5 ++
 rust/kernel/fs/inode.rs   | 131 +++++++++++++++++++++++++++++++++++++-
 samples/rust/rust_rofs.rs |  43 ++++++++++++-
 4 files changed, 187 insertions(+), 5 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 2db5df578df2..360a1d38ac19 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -288,6 +288,12 @@ void rust_helper_mapping_set_large_folios(struct address_space *mapping)
 }
 EXPORT_SYMBOL_GPL(rust_helper_mapping_set_large_folios);
 
+unsigned int rust_helper_MKDEV(unsigned int major, unsigned int minor)
+{
+	return MKDEV(major, minor);
+}
+EXPORT_SYMBOL_GPL(rust_helper_MKDEV);
+
 unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
 				       unsigned long n)
 {
@@ -307,6 +313,13 @@ void rust_helper_inode_unlock_shared(struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(rust_helper_inode_unlock_shared);
 
+void rust_helper_set_delayed_call(struct delayed_call *call,
+				  void (*fn)(void *), void *arg)
+{
+	set_delayed_call(call, fn, arg);
+}
+EXPORT_SYMBOL_GPL(rust_helper_set_delayed_call);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 0828676eae1c..a819724b75f8 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -521,8 +521,13 @@ pub enum DirEntryType {
 impl From<inode::Type> for DirEntryType {
     fn from(value: inode::Type) -> Self {
         match value {
+            inode::Type::Fifo => DirEntryType::Fifo,
+            inode::Type::Chr(_, _) => DirEntryType::Chr,
             inode::Type::Dir => DirEntryType::Dir,
+            inode::Type::Blk(_, _) => DirEntryType::Blk,
             inode::Type::Reg => DirEntryType::Reg,
+            inode::Type::Lnk => DirEntryType::Lnk,
+            inode::Type::Sock => DirEntryType::Sock,
         }
     }
 }
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index 1a41c824d30d..75b68d697a6e 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -10,8 +10,8 @@
     address_space, dentry, dentry::DEntry, file, sb::SuperBlock, FileSystem, Offset, UnspecifiedFS,
 };
 use crate::error::{code::*, Result};
-use crate::types::{ARef, AlwaysRefCounted, Lockable, Locked, Opaque};
-use crate::{bindings, block, time::Timespec};
+use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Lockable, Locked, Opaque};
+use crate::{bindings, block, str::CStr, str::CString, time::Timespec};
 use core::mem::ManuallyDrop;
 use core::{marker::PhantomData, ptr};
 use macros::vtable;
@@ -25,6 +25,18 @@ pub trait Operations {
     /// File system that these operations are compatible with.
     type FileSystem: FileSystem + ?Sized;
 
+    /// Returns the string that represents the name of the file a symbolic link inode points to.
+    ///
+    /// When `dentry` is `None`, `get_link` is called with the RCU read-side lock held, so it may
+    /// not sleep. Implementations must return `Err(ECHILD)` for it to be called again without
+    /// holding the RCU lock.
+    fn get_link<'a>(
+        _dentry: Option<&DEntry<Self::FileSystem>>,
+        _inode: &'a INode<Self::FileSystem>,
+    ) -> Result<Either<CString, &'a CStr>> {
+        Err(ENOTSUPP)
+    }
+
     /// Returns the inode corresponding to the directory entry with the given name.
     fn lookup(
         _parent: &Locked<&INode<Self::FileSystem>, ReadSem>,
@@ -134,6 +146,52 @@ pub fn init(mut self, params: Params) -> Result<ARef<INode<T>>> {
                 unsafe { bindings::mapping_set_large_folios(inode.i_mapping) };
                 bindings::S_IFREG
             }
+            Type::Lnk => {
+                // If we are using `page_get_link`, we need to prevent the use of high mem.
+                if !inode.i_op.is_null() {
+                    // SAFETY: We just checked that `i_op` is non-null, and we always just set it
+                    // to valid values.
+                    if unsafe {
+                        (*inode.i_op).get_link == bindings::page_symlink_inode_operations.get_link
+                    } {
+                        // SAFETY: `inode` is valid for write as it's a new inode.
+                        unsafe { bindings::inode_nohighmem(inode) };
+                    }
+                }
+                bindings::S_IFLNK
+            }
+            Type::Fifo => {
+                // SAFETY: `inode` is valid for write as it's a new inode.
+                unsafe { bindings::init_special_inode(inode, bindings::S_IFIFO as _, 0) };
+                bindings::S_IFIFO
+            }
+            Type::Sock => {
+                // SAFETY: `inode` is valid for write as it's a new inode.
+                unsafe { bindings::init_special_inode(inode, bindings::S_IFSOCK as _, 0) };
+                bindings::S_IFSOCK
+            }
+            Type::Chr(major, minor) => {
+                // SAFETY: `inode` is valid for write as it's a new inode.
+                unsafe {
+                    bindings::init_special_inode(
+                        inode,
+                        bindings::S_IFCHR as _,
+                        bindings::MKDEV(major, minor & bindings::MINORMASK),
+                    )
+                };
+                bindings::S_IFCHR
+            }
+            Type::Blk(major, minor) => {
+                // SAFETY: `inode` is valid for write as it's a new inode.
+                unsafe {
+                    bindings::init_special_inode(
+                        inode,
+                        bindings::S_IFBLK as _,
+                        bindings::MKDEV(major, minor & bindings::MINORMASK),
+                    )
+                };
+                bindings::S_IFBLK
+            }
         };
 
         inode.i_mode = (params.mode & 0o777) | u16::try_from(mode)?;
@@ -194,11 +252,26 @@ fn drop(&mut self) {
 /// The type of an inode.
 #[derive(Copy, Clone)]
 pub enum Type {
+    /// Named pipe (first-in, first-out) type.
+    Fifo,
+
+    /// Character device type.
+    Chr(u32, u32),
+
     /// Directory type.
     Dir,
 
+    /// Block device type.
+    Blk(u32, u32),
+
     /// Regular file type.
     Reg,
+
+    /// Symbolic link type.
+    Lnk,
+
+    /// Named unix-domain socket type.
+    Sock,
 }
 
 /// Required inode parameters.
@@ -245,6 +318,15 @@ pub struct Params {
 pub struct Ops<T: FileSystem + ?Sized>(*const bindings::inode_operations, PhantomData<T>);
 
 impl<T: FileSystem + ?Sized> Ops<T> {
+    /// Returns inode operations for symbolic links that are stored in a single page.
+    pub fn page_symlink_inode() -> Self {
+        // SAFETY: This is a constant in C, it never changes.
+        Self(
+            unsafe { &bindings::page_symlink_inode_operations },
+            PhantomData,
+        )
+    }
+
     /// Creates the inode operations from a type that implements the [`Operations`] trait.
     pub const fn new<U: Operations<FileSystem = T> + ?Sized>() -> Self {
         struct Table<T: Operations + ?Sized>(PhantomData<T>);
@@ -255,7 +337,11 @@ impl<T: Operations + ?Sized> Table<T> {
                 } else {
                     None
                 },
-                get_link: None,
+                get_link: if T::HAS_GET_LINK {
+                    Some(Self::get_link_callback)
+                } else {
+                    None
+                },
                 permission: None,
                 get_inode_acl: None,
                 readlink: None,
@@ -303,6 +389,45 @@ extern "C" fn lookup_callback(
                     Ok(Some(ret)) => ManuallyDrop::new(ret).0.get(),
                 }
             }
+
+            extern "C" fn get_link_callback(
+                dentry_ptr: *mut bindings::dentry,
+                inode_ptr: *mut bindings::inode,
+                delayed_call: *mut bindings::delayed_call,
+            ) -> *const core::ffi::c_char {
+                extern "C" fn drop_cstring(ptr: *mut core::ffi::c_void) {
+                    // SAFETY: The argument came from a previous call to `into_foreign` below.
+                    unsafe { CString::from_foreign(ptr) };
+                }
+
+                let dentry = if dentry_ptr.is_null() {
+                    None
+                } else {
+                    // SAFETY: The C API guarantees that `dentry_ptr` is a valid dentry when it's
+                    // non-null.
+                    Some(unsafe { DEntry::from_raw(dentry_ptr) })
+                };
+
+                // SAFETY: The C API guarantees that `parent_ptr` is a valid inode.
+                let inode = unsafe { INode::from_raw(inode_ptr) };
+
+                match T::get_link(dentry, inode) {
+                    Err(e) => e.to_ptr::<core::ffi::c_char>(),
+                    Ok(Either::Right(str)) => str.as_char_ptr(),
+                    Ok(Either::Left(str)) => {
+                        let ptr = str.into_foreign();
+                        unsafe {
+                            bindings::set_delayed_call(
+                                delayed_call,
+                                Some(drop_cstring),
+                                ptr.cast_mut(),
+                            )
+                        };
+
+                        ptr.cast::<core::ffi::c_char>()
+                    }
+                }
+            }
         }
         Self(&Table::<U>::TABLE, PhantomData)
     }
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 8005fd14b2e1..7a09e2db878d 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -7,7 +7,7 @@
 };
 use kernel::prelude::*;
 use kernel::types::{ARef, Either, Locked};
-use kernel::{c_str, folio::Folio, folio::PageCache, fs, time::UNIX_EPOCH, user};
+use kernel::{c_str, folio::Folio, folio::PageCache, fs, str::CString, time::UNIX_EPOCH, user};
 
 kernel::module_fs! {
     type: RoFs,
@@ -24,7 +24,7 @@ struct Entry {
     contents: &'static [u8],
 }
 
-const ENTRIES: [Entry; 3] = [
+const ENTRIES: [Entry; 4] = [
     Entry {
         name: b".",
         ino: 1,
@@ -43,11 +43,18 @@ struct Entry {
         etype: inode::Type::Reg,
         contents: b"hello world\n",
     },
+    Entry {
+        name: b"link.txt",
+        ino: 3,
+        etype: inode::Type::Lnk,
+        contents: b"./test.txt",
+    },
 ];
 
 const DIR_FOPS: file::Ops<RoFs> = file::Ops::new::<RoFs>();
 const DIR_IOPS: inode::Ops<RoFs> = inode::Ops::new::<RoFs>();
 const FILE_AOPS: address_space::Ops<RoFs> = address_space::Ops::new::<RoFs>();
+const LNK_IOPS: inode::Ops<RoFs> = inode::Ops::new::<Link>();
 
 struct RoFs;
 
@@ -68,6 +75,11 @@ fn iget(sb: &sb::SuperBlock<Self>, e: &'static Entry) -> Result<ARef<INode<Self>
                     .set_aops(FILE_AOPS);
                 (0o444, 1, e.contents.len().try_into()?)
             }
+            inode::Type::Lnk => {
+                new.set_iops(LNK_IOPS);
+                (0o444, 1, e.contents.len().try_into()?)
+            }
+            _ => return Err(ENOENT),
         };
 
         new.init(inode::Params {
@@ -123,6 +135,33 @@ fn lookup(
     }
 }
 
+struct Link;
+#[vtable]
+impl inode::Operations for Link {
+    type FileSystem = RoFs;
+
+    fn get_link<'a>(
+        dentry: Option<&DEntry<RoFs>>,
+        inode: &'a INode<RoFs>,
+    ) -> Result<Either<CString, &'a CStr>> {
+        if dentry.is_none() {
+            return Err(ECHILD);
+        }
+
+        let name_buf = match inode.ino() {
+            3 => ENTRIES[3].contents,
+            _ => return Err(EINVAL),
+        };
+        let mut name = Box::new_slice(
+            name_buf.len().checked_add(1).ok_or(ENOMEM)?,
+            b'\0',
+            GFP_NOFS,
+        )?;
+        name[..name_buf.len()].copy_from_slice(name_buf);
+        Ok(Either::Left(name.try_into()?))
+    }
+}
+
 #[vtable]
 impl address_space::Operations for RoFs {
     type FileSystem = Self;
-- 
2.34.1


