Return-Path: <linux-fsdevel+bounces-19426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB258C56DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824CF1F2338C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70097145FEB;
	Tue, 14 May 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn4KbQzw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B14145A17;
	Tue, 14 May 2024 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692663; cv=none; b=HM8k9MKJuv4BEUev6JlUeSPVS0hqHlI/qr6aIt1Iu1vJL6GoqSbpwrcJ/A6o3WBhDACEUu2HET2gRhCasgJlQd4Jb9cmW9K/jj6mON2wcnzZeklI6C5o/govY/AIlyM3vDY6Fs6oTzU2BJ2weTrALQGPNyZYrYL/7pRVejgirMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692663; c=relaxed/simple;
	bh=5xqavvGys7g3ABa54TtHy/alV4DqbS4d1zcSPFLukFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfRr71FhPkwC5c/jhYayLrRjY497Rxq4IRxyURui1AlHGwe8kHY7ZXyRG7pEm+R92bIAP4Ea2r8kC226YdQgrRoHkStIDnpBfKk03fGFuVMXUzcT/6JXJOIRn6HVAYxRc91NYzkg3y2/qgWZQUOTkN4pplGPdeNfUB4wqS4XGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn4KbQzw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee954e0aa6so43652085ad.3;
        Tue, 14 May 2024 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692661; x=1716297461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuesYbLbHeSB+zClXdY7SRve4n+ZWNY3LE5efcHNCmU=;
        b=fn4KbQzwop3ML1uO8VaAyV5hDFX054cKrJxvldzzOkexdiYby0nH3/78p/PB4XxPsk
         x0AGBR07Wox4K4rnE8nzjUZqxSNjWqUx2tF+2eYXX2LOxAqyqm8S6jfOT0yPNpBlT8/Y
         aNI3TLxGVIE6n6eQikMKgoQQ4FyBCfG83bCmr4U3c6O08aspUpBJ0OgaZfc/ZxVrqPwt
         6llWhu4Sn2HU4eWZge6ju7/NwfTFp5SI6qinOcpsavIzszGvsFyosfLyDoDiEuKfpTVw
         hdyfoc8VFzmhs5go+ytTVm/XsfEx/xWlLoVomnOoIMB/QXCW/ZHi/+yVB36J9cCs7UiB
         oHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692661; x=1716297461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuesYbLbHeSB+zClXdY7SRve4n+ZWNY3LE5efcHNCmU=;
        b=gb1SLcuJAI1cwB4nKFRkYfCWWnYHcQlODzE7J0O7PsK8k0/rnkkZq7s/25190FjkKH
         pRqrFc1kutKAGTxf/gyu6CDwdWRsGc4jS5A/N9uEfWmZJKJzqpUBIet4hknsegLmvkHE
         /+o7fjeWJE9IZNnwG0dvWkjXf4UJqWsc+n40kytYkO2atmglQvX3+je48XBAFLzYc4Wz
         FVwsxf800kTjNb5t75o1Z2kyOj+UIsFTKrC+HhCOnYNsF12nN5v3zuf5hIJlhI3klgiH
         ksdMzn4glLY3cIlfcwl8Q5QaoIgpiKwfW56Mm0Fz3rW7CcHctG+KJXOtMp4fSmvd7/+F
         3BwA==
X-Forwarded-Encrypted: i=1; AJvYcCVCZN9gkqw7pwBH4IKifazz1XuU0dftLUOe81UQq6d5p8wMF1k3J7wOPMdQjcsHkt/W/85tyq2HwWQ9y5tt40KTmo5CT4jS8qBq/8w82iZTggNnYRGPyvrs6sNXQHk8TQfUlZR1j34Hm7Uy8JSTj5I4NJvWtBYKYrrmDQBugeOHvwhXJYTVo9oNV5LJ
X-Gm-Message-State: AOJu0YzVaEYDXXgp3fjqlHlpHrxOihl6Bx28LptLuKcPDRYVO7QBoeWF
	6Qo9sQKhy5iEMP7A1VHVGSwYv4NTRHMukKTlLHsHHVfdV06BaDM7
X-Google-Smtp-Source: AGHT+IGNE2lcBVGmYnn4QqEQWv5ai9pgS+Z9r0Rn4/Vy1u42BrzI2Gvjdz2Ays8h3+bLqfOLbm2Rxg==
X-Received: by 2002:a17:903:41c2:b0:1e4:6e70:25d8 with SMTP id d9443c01a7336-1ef43d2e2c3mr155172775ad.13.1715692661366;
        Tue, 14 May 2024 06:17:41 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:41 -0700 (PDT)
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
Subject: [RFC PATCH v2 04/30] rust: fs: introduce `FileSystem::fill_super`
Date: Tue, 14 May 2024 10:16:45 -0300
Message-Id: <20240514131711.379322-5-wedsonaf@gmail.com>
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

Allow Rust file systems to initialise superblocks, which allows them
to be mounted (though they are still empty).

Some scaffolding code is added to create an empty directory as the root.
It is replaced by proper inode creation in a subsequent patch in this
series.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |   5 ++
 rust/kernel/fs.rs               | 147 ++++++++++++++++++++++++++++++--
 rust/kernel/fs/sb.rs            |  50 +++++++++++
 samples/rust/rust_rofs.rs       |   6 ++
 4 files changed, 202 insertions(+), 6 deletions(-)
 create mode 100644 rust/kernel/fs/sb.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1bef4dff3019..dabb5a787e0d 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,7 @@
 #include <linux/ethtool.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
@@ -32,3 +33,7 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 
 const slab_flags_t RUST_CONST_HELPER_SLAB_RECLAIM_ACCOUNT = SLAB_RECLAIM_ACCOUNT;
 const slab_flags_t RUST_CONST_HELPER_SLAB_ACCOUNT = SLAB_ACCOUNT;
+
+const unsigned long RUST_CONST_HELPER_SB_RDONLY = SB_RDONLY;
+
+const loff_t RUST_CONST_HELPER_MAX_LFS_FILESIZE = MAX_LFS_FILESIZE;
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index fb7a9b200b85..263b4b6186ae 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -6,16 +6,30 @@
 //!
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
 
-use crate::error::{code::*, from_result, to_result, Error};
+use crate::error::{code::*, from_result, to_result, Error, Result};
 use crate::types::Opaque;
 use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
 use core::{ffi, marker::PhantomData, pin::Pin};
 use macros::{pin_data, pinned_drop};
+use sb::SuperBlock;
+
+pub mod sb;
+
+/// The offset of a file in a file system.
+///
+/// This is C's `loff_t`.
+pub type Offset = i64;
+
+/// Maximum size of an inode.
+pub const MAX_LFS_FILESIZE: Offset = bindings::MAX_LFS_FILESIZE;
 
 /// A file system type.
 pub trait FileSystem {
     /// The name of the file system type.
     const NAME: &'static CStr;
+
+    /// Initialises the new superblock.
+    fn fill_super(sb: &mut SuperBlock<Self>) -> Result;
 }
 
 /// A registration of a file system.
@@ -46,7 +60,7 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
                 let fs = unsafe { &mut *fs_ptr };
                 fs.owner = module.0;
                 fs.name = T::NAME.as_char_ptr();
-                fs.init_fs_context = Some(Self::init_fs_context_callback);
+                fs.init_fs_context = Some(Self::init_fs_context_callback::<T>);
                 fs.kill_sb = Some(Self::kill_sb_callback);
                 fs.fs_flags = 0;
 
@@ -57,11 +71,22 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
         })
     }
 
-    unsafe extern "C" fn init_fs_context_callback(_fc: *mut bindings::fs_context) -> ffi::c_int {
-        from_result(|| Err(ENOTSUPP))
+    unsafe extern "C" fn init_fs_context_callback<T: FileSystem + ?Sized>(
+        fc_ptr: *mut bindings::fs_context,
+    ) -> ffi::c_int {
+        from_result(|| {
+            // SAFETY: The C callback API guarantees that `fc_ptr` is valid.
+            let fc = unsafe { &mut *fc_ptr };
+            fc.ops = &Tables::<T>::CONTEXT;
+            Ok(0)
+        })
     }
 
-    unsafe extern "C" fn kill_sb_callback(_sb_ptr: *mut bindings::super_block) {}
+    unsafe extern "C" fn kill_sb_callback(sb_ptr: *mut bindings::super_block) {
+        // SAFETY: In `get_tree_callback` we always call `get_tree_nodev`, so `kill_anon_super` is
+        // the appropriate function to call for cleanup.
+        unsafe { bindings::kill_anon_super(sb_ptr) };
+    }
 }
 
 #[pinned_drop]
@@ -74,6 +99,113 @@ fn drop(self: Pin<&mut Self>) {
     }
 }
 
+struct Tables<T: FileSystem + ?Sized>(T);
+impl<T: FileSystem + ?Sized> Tables<T> {
+    const CONTEXT: bindings::fs_context_operations = bindings::fs_context_operations {
+        free: None,
+        parse_param: None,
+        get_tree: Some(Self::get_tree_callback),
+        reconfigure: None,
+        parse_monolithic: None,
+        dup: None,
+    };
+
+    unsafe extern "C" fn get_tree_callback(fc: *mut bindings::fs_context) -> ffi::c_int {
+        // SAFETY: `fc` is valid per the callback contract. `fill_super_callback` also has
+        // the right type and is a valid callback.
+        unsafe { bindings::get_tree_nodev(fc, Some(Self::fill_super_callback)) }
+    }
+
+    unsafe extern "C" fn fill_super_callback(
+        sb_ptr: *mut bindings::super_block,
+        _fc: *mut bindings::fs_context,
+    ) -> ffi::c_int {
+        from_result(|| {
+            // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
+            // newly-created superblock.
+            let new_sb = unsafe { SuperBlock::from_raw_mut(sb_ptr) };
+
+            // SAFETY: The callback contract guarantees that `sb_ptr`, from which `new_sb` is
+            // derived, is valid for write.
+            let sb = unsafe { &mut *new_sb.0.get() };
+            sb.s_op = &Tables::<T>::SUPER_BLOCK;
+            sb.s_flags |= bindings::SB_RDONLY;
+
+            T::fill_super(new_sb)?;
+
+            // The following is scaffolding code that will be removed in a subsequent patch. It is
+            // needed to build a root dentry, otherwise core code will BUG().
+            // SAFETY: `sb` is the superblock being initialised, it is valid for read and write.
+            let inode = unsafe { bindings::new_inode(sb) };
+            if inode.is_null() {
+                return Err(ENOMEM);
+            }
+
+            // SAFETY: `inode` is valid for write.
+            unsafe { bindings::set_nlink(inode, 2) };
+
+            {
+                // SAFETY: This is a newly-created inode. No other references to it exist, so it is
+                // safe to mutably dereference it.
+                let inode = unsafe { &mut *inode };
+                inode.i_ino = 1;
+                inode.i_mode = (bindings::S_IFDIR | 0o755) as _;
+
+                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
+                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
+
+                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
+                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
+            }
+
+            // SAFETY: `d_make_root` requires that `inode` be valid and referenced, which is the
+            // case for this call.
+            //
+            // It takes over the inode, even on failure, so we don't need to clean it up.
+            let dentry = unsafe { bindings::d_make_root(inode) };
+            if dentry.is_null() {
+                return Err(ENOMEM);
+            }
+
+            sb.s_root = dentry;
+
+            Ok(0)
+        })
+    }
+
+    const SUPER_BLOCK: bindings::super_operations = bindings::super_operations {
+        alloc_inode: None,
+        destroy_inode: None,
+        free_inode: None,
+        dirty_inode: None,
+        write_inode: None,
+        drop_inode: None,
+        evict_inode: None,
+        put_super: None,
+        sync_fs: None,
+        freeze_super: None,
+        freeze_fs: None,
+        thaw_super: None,
+        unfreeze_fs: None,
+        statfs: None,
+        remount_fs: None,
+        umount_begin: None,
+        show_options: None,
+        show_devname: None,
+        show_path: None,
+        show_stats: None,
+        #[cfg(CONFIG_QUOTA)]
+        quota_read: None,
+        #[cfg(CONFIG_QUOTA)]
+        quota_write: None,
+        #[cfg(CONFIG_QUOTA)]
+        get_dquots: None,
+        nr_cached_objects: None,
+        free_cached_objects: None,
+        shutdown: None,
+    };
+}
+
 /// Kernel module that exposes a single file system implemented by `T`.
 #[pin_data]
 pub struct Module<T: FileSystem + ?Sized> {
@@ -100,7 +232,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 ///
 /// ```
 /// # mod module_fs_sample {
-/// use kernel::fs;
+/// use kernel::fs::{sb::SuperBlock, self};
 /// use kernel::prelude::*;
 ///
 /// kernel::module_fs! {
@@ -114,6 +246,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
 /// struct MyFs;
 /// impl fs::FileSystem for MyFs {
 ///     const NAME: &'static CStr = kernel::c_str!("myfs");
+///     fn fill_super(_: &mut SuperBlock<Self>) -> Result {
+///         todo!()
+///     }
 /// }
 /// # }
 /// ```
diff --git a/rust/kernel/fs/sb.rs b/rust/kernel/fs/sb.rs
new file mode 100644
index 000000000000..113d3c0d8148
--- /dev/null
+++ b/rust/kernel/fs/sb.rs
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File system super blocks.
+//!
+//! This module allows Rust code to use superblocks.
+//!
+//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
+
+use super::FileSystem;
+use crate::{bindings, types::Opaque};
+use core::marker::PhantomData;
+
+/// A file system super block.
+///
+/// Wraps the kernel's `struct super_block`.
+#[repr(transparent)]
+pub struct SuperBlock<T: FileSystem + ?Sized>(
+    pub(crate) Opaque<bindings::super_block>,
+    PhantomData<T>,
+);
+
+impl<T: FileSystem + ?Sized> SuperBlock<T> {
+    /// Creates a new superblock mutable reference from the given raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    ///
+    /// * `ptr` is valid and remains so for the lifetime of the returned object.
+    /// * `ptr` has the correct file system type.
+    /// * `ptr` is the only active pointer to the superblock.
+    pub(crate) unsafe fn from_raw_mut<'a>(ptr: *mut bindings::super_block) -> &'a mut Self {
+        // SAFETY: The safety requirements guarantee that the cast below is ok.
+        unsafe { &mut *ptr.cast::<Self>() }
+    }
+
+    /// Returns whether the superblock is mounted in read-only mode.
+    pub fn rdonly(&self) -> bool {
+        // SAFETY: `s_flags` only changes during init, so it is safe to read it.
+        unsafe { (*self.0.get()).s_flags & bindings::SB_RDONLY != 0 }
+    }
+
+    /// Sets the magic number of the superblock.
+    pub fn set_magic(&mut self, magic: usize) -> &mut Self {
+        // SAFETY: This is a new superblock that is being initialised, so it's ok to write to its
+        // fields.
+        unsafe { (*self.0.get()).s_magic = magic as core::ffi::c_ulong };
+        self
+    }
+}
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index d465b107a07d..022addf68891 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -2,6 +2,7 @@
 
 //! Rust read-only file system sample.
 
+use kernel::fs::sb;
 use kernel::prelude::*;
 use kernel::{c_str, fs};
 
@@ -16,4 +17,9 @@
 struct RoFs;
 impl fs::FileSystem for RoFs {
     const NAME: &'static CStr = c_str!("rust_rofs");
+
+    fn fill_super(sb: &mut sb::SuperBlock<Self>) -> Result {
+        sb.set_magic(0x52555354);
+        Ok(())
+    }
 }
-- 
2.34.1


