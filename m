Return-Path: <linux-fsdevel+bounces-19433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F8F8C56EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832552837FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB7F1552E7;
	Tue, 14 May 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWl1wlB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3814F135;
	Tue, 14 May 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692672; cv=none; b=s+IPEWT+yiM/tKxYIb2ZlzbzmVabf/Jy/e4a2cJ1ShOr+mEqGsWbYLDSJSeFAiyvYSmXImltprE0a4Q1MljdfmkIdcBphF8Ikbp91Q7t6JXwqS6SZR2mEPhRBbU2F4HIG9+R4D9Cx8czb1Us5pnuSYrpPWjAPzXcpFkfW8K1XUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692672; c=relaxed/simple;
	bh=lvShv7o989WUL7BP6s6yJWWP7E2ugWSm7FrWqYQBpeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fxf5g01J6/xk/JGRGxamoXK9WfUIO6t9FDmUOk8eqAQIh2hTnkXMMz+jQKdd3sN7awU7/SDGo7hZf781etYjvG83Xl7YpLp6kwq2HHzkdAjeiJun4LIDQbLZUN+iMNyb1K9N6tAahknmksjd2LRujPBv+5WWelGaVQQCNPcuX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWl1wlB5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so32609735ad.1;
        Tue, 14 May 2024 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692670; x=1716297470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcsGyGuiqU3jPIGnlfpE9jCbCuDL1CH0W6DIoxyhi2A=;
        b=SWl1wlB5EJjAq+/vJrzDtX0Rib5ssvlRR/larl2ycSS6EnlRMxNL+zSmvSW/XAWlmy
         DUCEIt3XkT7Sg4AsEfd6WPcS6TjDH/xyWsJwqXX7dbvR1Y0l8R4lD4Z9Z5AjC5qU6hDm
         +G1HbEcMu8xQxl5qnyETLfdkTmTiA5l6Pukh/lvbi6c5oprWhuCV1wO6RUC3vSADSPMP
         6uRAC1pSkR0MbDNN6pD+OY2zogZJG3zq0PLo6HrOW9mixMnPyQzx2km+06dU+fJB64PU
         owqDms/KLjDN8ujtOiFY5I2XrzOUJzGDaeaBLpSV8ymRDkkSGT6ulfYkh0j0mYqCP+eq
         Rfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692670; x=1716297470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcsGyGuiqU3jPIGnlfpE9jCbCuDL1CH0W6DIoxyhi2A=;
        b=qoIR7nr0qjuyiXzaukj0NawEi4oL0gnKHJRwylHFzILYyTw1re/ke2GRiocUuSmBZ0
         jyKKzdvdBS0yihBXJHASXA6QRcAqMxjBzG2exeVl8a8JSs2iaMRVddcujcRWaGqUALfi
         7g0NyL1MaYTxpKOHnVs+a5MOGyohXZgZF20ag0pNm98YbW4Jg3R6ZDuUBI8Noa/CcgbO
         S2rnyUEddaPjrOhu7yJS4MxldY5xqZMQC/IYK0s2QN5AJif5L+bIzRRyMZ6hvI+P5UgM
         27skWZ7yYxqYUbfQQv+uqvNk0ZgVSBTnTuRxIBKSwD2NpTQv8UHJTRUOAa/Nejyzdzqk
         YKWA==
X-Forwarded-Encrypted: i=1; AJvYcCXvSuw0qvSYV7wYRvadR1ad9WDSoGKJu7BVkVYyJAie+N3+qBJ7wp1QX/+v8izkeN6c8eUHiiwYbDBihL3J+9EQ5FApuV4eWHLYLuLwTLgk2l3NK/2MCf+IuedD7XsY+2Q2PBqiB/QvRzsGokAkjyL8ZGEMlFHaCHOkIpMN8q1M3gjvY2FEqL0OlFaY
X-Gm-Message-State: AOJu0YyU8CdKsklR3lKpIKg36WPGO6NxAL3nsbp1d2Y8EK4jlUQNqN3g
	DXHCgoGn7kCE6ne5gcPL38SgL+CQgkr3LK946R0JYh6lnqOe1JrA
X-Google-Smtp-Source: AGHT+IGMv4o2rW6xKOQ5T8ig/4Rd5TSPWGzO+2tpLor2HW7gD3KrbE+1N7SdAEt/p3VRvshAcpZEew==
X-Received: by 2002:a17:902:650d:b0:1eb:5c0f:6e78 with SMTP id d9443c01a7336-1ef43c0cf75mr111764415ad.11.1715692669968;
        Tue, 14 May 2024 06:17:49 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:49 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/30] rust: fs: introduce `file::Operations::read_dir`
Date: Tue, 14 May 2024 10:16:52 -0300
Message-Id: <20240514131711.379322-12-wedsonaf@gmail.com>
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

Allows Rust file systems to report the contents of their directory
inodes. The reported entries cannot be opened yet.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c            |  12 +++
 rust/kernel/fs/file.rs    | 176 ++++++++++++++++++++++++++++++++++++--
 rust/kernel/fs/inode.rs   |  31 +++++--
 samples/rust/rust_rofs.rs |  85 +++++++++++++++---
 4 files changed, 279 insertions(+), 25 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 87301e1ace65..deb2d21f3096 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -195,6 +195,18 @@ unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
 }
 EXPORT_SYMBOL_GPL(rust_helper_copy_to_user);
 
+void rust_helper_inode_lock_shared(struct inode *inode)
+{
+	inode_lock_shared(inode);
+}
+EXPORT_SYMBOL_GPL(rust_helper_inode_lock_shared);
+
+void rust_helper_inode_unlock_shared(struct inode *inode)
+{
+	inode_unlock_shared(inode);
+}
+EXPORT_SYMBOL_GPL(rust_helper_inode_unlock_shared);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 67dd3ecf7d98..6d61723f440d 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -7,13 +7,13 @@
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h) and
 //! [`include/linux/file.h`](srctree/include/linux/file.h)
 
-use super::{dentry::DEntry, inode::INode, FileSystem, UnspecifiedFS};
+use super::{dentry::DEntry, inode, inode::INode, inode::Ino, FileSystem, Offset, UnspecifiedFS};
 use crate::{
     bindings,
-    error::{code::*, Error, Result},
-    types::{ARef, AlwaysRefCounted, Opaque},
+    error::{code::*, from_result, Error, Result},
+    types::{ARef, AlwaysRefCounted, Locked, Opaque},
 };
-use core::{marker::PhantomData, ptr};
+use core::{marker::PhantomData, mem::ManuallyDrop, ptr};
 use macros::vtable;
 
 /// Flags associated with a [`File`].
@@ -275,10 +275,20 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 pub trait Operations {
     /// File system that these operations are compatible with.
     type FileSystem: FileSystem + ?Sized;
+
+    /// Reads directory entries from directory files.
+    ///
+    /// [`DirEmitter::pos`] holds the current position of the directory reader.
+    fn read_dir(
+        _file: &File<Self::FileSystem>,
+        _inode: &Locked<&INode<Self::FileSystem>, inode::ReadSem>,
+        _emitter: &mut DirEmitter,
+    ) -> Result {
+        Err(EINVAL)
+    }
 }
 
 /// Represents file operations.
-#[allow(dead_code)]
 pub struct Ops<T: FileSystem + ?Sized>(pub(crate) *const bindings::file_operations, PhantomData<T>);
 
 impl<T: FileSystem + ?Sized> Ops<T> {
@@ -294,7 +304,11 @@ impl<T: Operations + ?Sized> Table<T> {
                 read_iter: None,
                 write_iter: None,
                 iopoll: None,
-                iterate_shared: None,
+                iterate_shared: if T::HAS_READ_DIR {
+                    Some(Self::read_dir_callback)
+                } else {
+                    None
+                },
                 poll: None,
                 unlocked_ioctl: None,
                 compat_ioctl: None,
@@ -321,7 +335,157 @@ impl<T: Operations + ?Sized> Table<T> {
                 uring_cmd: None,
                 uring_cmd_iopoll: None,
             };
+
+            unsafe extern "C" fn read_dir_callback(
+                file_ptr: *mut bindings::file,
+                ctx_ptr: *mut bindings::dir_context,
+            ) -> core::ffi::c_int {
+                from_result(|| {
+                    // SAFETY: The C API guarantees that `file` is valid for the duration of the
+                    // callback. Since this callback is specifically for filesystem T, we know `T`
+                    // is the right filesystem.
+                    let file = unsafe { File::from_raw(file_ptr) };
+
+                    // SAFETY: The C API guarantees that this is the only reference to the
+                    // `dir_context` instance.
+                    let emitter = unsafe { &mut *ctx_ptr.cast::<DirEmitter>() };
+                    let orig_pos = emitter.pos();
+
+                    // SAFETY: The C API guarantees that the inode's rw semaphore is locked in read
+                    // mode. It does not expect callees to unlock it, so we make the locked object
+                    // manually dropped to avoid unlocking it.
+                    let locked = ManuallyDrop::new(unsafe { Locked::new(file.inode()) });
+
+                    // Call the module implementation. We ignore errors if directory entries have
+                    // been succesfully emitted: this is because we want users to see them before
+                    // the error.
+                    match T::read_dir(file, &locked, emitter) {
+                        Ok(_) => Ok(0),
+                        Err(e) => {
+                            if emitter.pos() == orig_pos {
+                                Err(e)
+                            } else {
+                                Ok(0)
+                            }
+                        }
+                    }
+                })
+            }
         }
         Self(&Table::<U>::TABLE, PhantomData)
     }
 }
+
+/// The types of directory entries reported by [`Operations::read_dir`].
+#[repr(u32)]
+#[derive(Copy, Clone)]
+pub enum DirEntryType {
+    /// Unknown type.
+    Unknown = bindings::DT_UNKNOWN,
+
+    /// Named pipe (first-in, first-out) type.
+    Fifo = bindings::DT_FIFO,
+
+    /// Character device type.
+    Chr = bindings::DT_CHR,
+
+    /// Directory type.
+    Dir = bindings::DT_DIR,
+
+    /// Block device type.
+    Blk = bindings::DT_BLK,
+
+    /// Regular file type.
+    Reg = bindings::DT_REG,
+
+    /// Symbolic link type.
+    Lnk = bindings::DT_LNK,
+
+    /// Named unix-domain socket type.
+    Sock = bindings::DT_SOCK,
+
+    /// White-out type.
+    Wht = bindings::DT_WHT,
+}
+
+impl From<inode::Type> for DirEntryType {
+    fn from(value: inode::Type) -> Self {
+        match value {
+            inode::Type::Dir => DirEntryType::Dir,
+        }
+    }
+}
+
+impl TryFrom<u32> for DirEntryType {
+    type Error = crate::error::Error;
+
+    fn try_from(v: u32) -> Result<Self> {
+        match v {
+            v if v == Self::Unknown as u32 => Ok(Self::Unknown),
+            v if v == Self::Fifo as u32 => Ok(Self::Fifo),
+            v if v == Self::Chr as u32 => Ok(Self::Chr),
+            v if v == Self::Dir as u32 => Ok(Self::Dir),
+            v if v == Self::Blk as u32 => Ok(Self::Blk),
+            v if v == Self::Reg as u32 => Ok(Self::Reg),
+            v if v == Self::Lnk as u32 => Ok(Self::Lnk),
+            v if v == Self::Sock as u32 => Ok(Self::Sock),
+            v if v == Self::Wht as u32 => Ok(Self::Wht),
+            _ => Err(EDOM),
+        }
+    }
+}
+
+/// Directory entry emitter.
+///
+/// This is used in [`Operations::read_dir`] implementations to report the directory entry.
+#[repr(transparent)]
+pub struct DirEmitter(bindings::dir_context);
+
+impl DirEmitter {
+    /// Returns the current position of the emitter.
+    pub fn pos(&self) -> Offset {
+        self.0.pos
+    }
+
+    /// Emits a directory entry.
+    ///
+    /// `pos_inc` is the number with which to increment the current position on success.
+    ///
+    /// `name` is the name of the entry.
+    ///
+    /// `ino` is the inode number of the entry.
+    ///
+    /// `etype` is the type of the entry.
+    ///
+    /// Returns `false` when the entry could not be emitted, possibly because the user-provided
+    /// buffer is full.
+    pub fn emit(&mut self, pos_inc: Offset, name: &[u8], ino: Ino, etype: DirEntryType) -> bool {
+        let Ok(name_len) = i32::try_from(name.len()) else {
+            return false;
+        };
+
+        let Some(actor) = self.0.actor else {
+            return false;
+        };
+
+        let Some(new_pos) = self.0.pos.checked_add(pos_inc) else {
+            return false;
+        };
+
+        // SAFETY: `name` is valid at least for the duration of the `actor` call.
+        let ret = unsafe {
+            actor(
+                &mut self.0,
+                name.as_ptr().cast::<i8>(),
+                name_len,
+                self.0.pos,
+                ino,
+                etype as _,
+            )
+        };
+        if ret {
+            self.0.pos = new_pos;
+        }
+        ret
+    }
+}
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index 11df493314ea..d84d8d2f7076 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -6,9 +6,9 @@
 //!
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
 
-use super::{sb::SuperBlock, FileSystem, Offset, UnspecifiedFS};
+use super::{file, sb::SuperBlock, FileSystem, Offset, UnspecifiedFS};
 use crate::error::Result;
-use crate::types::{ARef, AlwaysRefCounted, Opaque};
+use crate::types::{ARef, AlwaysRefCounted, Lockable, Opaque};
 use crate::{bindings, block, time::Timespec};
 use core::mem::ManuallyDrop;
 use core::{marker::PhantomData, ptr};
@@ -78,6 +78,22 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+/// Indicates that the an inode's rw semapahore is locked in read (shared) mode.
+pub struct ReadSem;
+
+unsafe impl<T: FileSystem + ?Sized> Lockable<ReadSem> for INode<T> {
+    fn raw_lock(&self) {
+        // SAFETY: Since there's a reference to the inode, it must be valid.
+        unsafe { bindings::inode_lock_shared(self.0.get()) };
+    }
+
+    unsafe fn unlock(&self) {
+        // SAFETY: Since there's a reference to the inode, it must be valid. Additionally, the
+        // safety requirements of this functino require that the inode be locked in read mode.
+        unsafe { bindings::inode_unlock_shared(self.0.get()) };
+    }
+}
+
 /// An inode that is locked and hasn't been initialised yet.
 ///
 /// # Invariants
@@ -95,9 +111,6 @@ pub fn init(mut self, params: Params) -> Result<ARef<INode<T>>> {
         let inode = unsafe { self.0.as_mut() };
         let mode = match params.typ {
             Type::Dir => {
-                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
-                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
-
                 // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
                 inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
 
@@ -126,6 +139,14 @@ pub fn init(mut self, params: Params) -> Result<ARef<INode<T>>> {
         // being called with the `ManuallyDrop` instance created above.
         Ok(unsafe { ARef::from_raw(manual.0.cast::<INode<T>>()) })
     }
+
+    /// Sets the file operations on this new inode.
+    pub fn set_fops(&mut self, fops: file::Ops<T>) -> &mut Self {
+        // SAFETY: By the type invariants, it's ok to modify the inode.
+        let inode = unsafe { self.0.as_mut() };
+        inode.__bindgen_anon_3.i_fop = fops.0;
+        self
+    }
 }
 
 impl<T: FileSystem + ?Sized> Drop for New<T> {
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index d32c4645ebe8..9da01346d8f8 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -2,9 +2,9 @@
 
 //! Rust read-only file system sample.
 
-use kernel::fs::{dentry, inode, sb::SuperBlock};
+use kernel::fs::{dentry, file, file::File, inode, inode::INode, sb::SuperBlock};
 use kernel::prelude::*;
-use kernel::{c_str, fs, time::UNIX_EPOCH, types::Either};
+use kernel::{c_str, fs, time::UNIX_EPOCH, types::Either, types::Locked};
 
 kernel::module_fs! {
     type: RoFs,
@@ -14,6 +14,32 @@
     license: "GPL",
 }
 
+struct Entry {
+    name: &'static [u8],
+    ino: u64,
+    etype: inode::Type,
+}
+
+const ENTRIES: [Entry; 3] = [
+    Entry {
+        name: b".",
+        ino: 1,
+        etype: inode::Type::Dir,
+    },
+    Entry {
+        name: b"..",
+        ino: 1,
+        etype: inode::Type::Dir,
+    },
+    Entry {
+        name: b"subdir",
+        ino: 2,
+        etype: inode::Type::Dir,
+    },
+];
+
+const DIR_FOPS: file::Ops<RoFs> = file::Ops::new::<RoFs>();
+
 struct RoFs;
 impl fs::FileSystem for RoFs {
     const NAME: &'static CStr = c_str!("rust_rofs");
@@ -26,19 +52,50 @@ fn fill_super(sb: &mut SuperBlock<Self>) -> Result {
     fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
         let inode = match sb.get_or_create_inode(1)? {
             Either::Left(existing) => existing,
-            Either::Right(new) => new.init(inode::Params {
-                typ: inode::Type::Dir,
-                mode: 0o555,
-                size: 1,
-                blocks: 1,
-                nlink: 2,
-                uid: 0,
-                gid: 0,
-                atime: UNIX_EPOCH,
-                ctime: UNIX_EPOCH,
-                mtime: UNIX_EPOCH,
-            })?,
+            Either::Right(mut new) => {
+                new.set_fops(DIR_FOPS);
+                new.init(inode::Params {
+                    typ: inode::Type::Dir,
+                    mode: 0o555,
+                    size: ENTRIES.len().try_into()?,
+                    blocks: 1,
+                    nlink: 2,
+                    uid: 0,
+                    gid: 0,
+                    atime: UNIX_EPOCH,
+                    ctime: UNIX_EPOCH,
+                    mtime: UNIX_EPOCH,
+                })?
+            }
         };
         dentry::Root::try_new(inode)
     }
 }
+
+#[vtable]
+impl file::Operations for RoFs {
+    type FileSystem = Self;
+
+    fn read_dir(
+        _file: &File<Self>,
+        inode: &Locked<&INode<Self>, inode::ReadSem>,
+        emitter: &mut file::DirEmitter,
+    ) -> Result {
+        if inode.ino() != 1 {
+            return Ok(());
+        }
+
+        let pos = emitter.pos();
+        if pos >= ENTRIES.len().try_into()? {
+            return Ok(());
+        }
+
+        for e in ENTRIES.iter().skip(pos.try_into()?) {
+            if !emitter.emit(1, e.name, e.ino, e.etype.into()) {
+                break;
+            }
+        }
+
+        Ok(())
+    }
+}
-- 
2.34.1


