Return-Path: <linux-fsdevel+bounces-29497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A44E97A390
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B208DB27949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED956188A0A;
	Mon, 16 Sep 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="hJzUu1+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D031865E8;
	Mon, 16 Sep 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495034; cv=none; b=hdXf4ZzqzWfp97Y2YwP4WwghtUVH97+JjXVCdEm2Js3jcRF25TDIInuMvoXSc6Y3COl6psDwCD/NarGYiqr2ODIkqRtwB8i1D4v6o71QsTXZ/oSUnSbDN/F7eO9p/WxM0Xjogr7dM4Is7NgBp0op2m66KADQ+2rxxTbDz2e4FxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495034; c=relaxed/simple;
	bh=6iXHljAK6tlqf4i2wUsDyPPM5fCbgqrUvGbagJ/EIHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvdAo5N+nsR8KZf/2E8GxlT/itF8ooAYSX6tGFQHliX3Z9SBabj0WMVPduAZlEk0v6p2qp3P5OWqThIr2GDc9PbY2GqcwY/T0YcrkBz/u5S1Tr7qoMtNdyMiA6yh0KRvqjlgEsKes2zPIWBGH1+n2qFi+lF9kGxZ+PaEEvz2ZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=hJzUu1+W; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A7FD69981;
	Mon, 16 Sep 2024 09:57:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495031; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9dEPmwLuzUR8D9sjyr8ry8zWG2H9N5ifoCez2qPa480=;
	b=hJzUu1+WiF2oeH1MPPXfSsbcCo9OHHH/SnagXtAeg1y9rjtkzc5ehMb33iZIBKPvHiINW3
	Yr1SxF780YgUOqJXxdmA7Ju72fzh1Rb+T8AY0FtJic+MJcdjZOLWaVCKTBcsQq3jD5piFO
	cePZNJAoVjcyi/80rNgB8m+7bnIeQ9d34jQVPdqz98KPSw2twyaY+/VZiQqzhmOsb8v07+
	hXe7CR8/Nch8ct/Ua/guKr7KFzGPB1DC8VsKiicYpUOwnUsnzwExF18ORlw7Hp0cBXnkXZ
	0AJuVvpWIrTSq15usiB2hYfQ0Hkpot9hEaiFA22Tt8cnxNx71n/1TdCu1bMaHA==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 17/24] erofs: introduce Rust SBI to C
Date: Mon, 16 Sep 2024 21:56:27 +0800
Message-ID: <20240916135634.98554-18-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916135634.98554-1-toolmanp@tlmp.cc>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch introduces Rust opaque superblock info to C as s_fs_info.
The original erofs_sb_info is embedded inside the rust opaque type and
reexported by rewriting the original EROFS_SB/EROFS_I_SB macros.

This patch also provides a prototype of KernelInode,
KernelInodeCollection so that the code can compile and it also
implements the Metabuf Data Source by hooking up the original metabuf
API defined in EROFS.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/Makefile            |  2 +-
 fs/erofs/internal.h          | 10 ++++++
 fs/erofs/rust/kinode.rs      | 49 ++++++++++++++++++++++++++
 fs/erofs/rust/ksources.rs    | 66 ++++++++++++++++++++++++++++++++++++
 fs/erofs/rust/ksuperblock.rs | 30 ++++++++++++++++
 fs/erofs/rust/mod.rs         |  3 ++
 fs/erofs/rust_bindings.h     | 12 +++++++
 fs/erofs/rust_helpers.c      | 31 +++++++++++++++++
 fs/erofs/rust_helpers.h      | 21 ++++++++++++
 fs/erofs/super.c             | 15 ++++++--
 fs/erofs/super_rs.rs         | 50 +++++++++++++++++++++++++++
 11 files changed, 285 insertions(+), 4 deletions(-)
 create mode 100644 fs/erofs/rust/kinode.rs
 create mode 100644 fs/erofs/rust/ksources.rs
 create mode 100644 fs/erofs/rust/ksuperblock.rs
 create mode 100644 fs/erofs/rust_bindings.h
 create mode 100644 fs/erofs/rust_helpers.c
 create mode 100644 fs/erofs/rust_helpers.h

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index fb46a2c7fb50..dfa03edbe29a 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,4 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
-erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o
+erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o rust_helpers.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8674a4cb9d39..18e67219fbc8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -20,6 +20,10 @@
 #include <linux/iomap.h>
 #include "erofs_fs.h"
 
+#ifdef CONFIG_EROFS_FS_RUST
+#include "rust_bindings.h"
+#endif
+
 /* redefine pr_fmt "erofs: " */
 #undef pr_fmt
 #define pr_fmt(fmt) "erofs: " fmt
@@ -178,8 +182,14 @@ struct erofs_sb_info {
 	char *domain_id;
 };
 
+#ifdef CONFIG_EROFS_FS_RUST
+#define EROFS_SB(sb) (*(struct erofs_sb_info **)(((void *)((sb)->s_fs_info)) + \
+		      EROFS_SB_INFO_OFFSET_RUST))
+#define EROFS_I_SB(inode) EROFS_SB((inode)->i_sb)
+#else
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
 #define EROFS_I_SB(inode) ((struct erofs_sb_info *)(inode)->i_sb->s_fs_info)
+#endif
 
 /* Mount flags set via mount options or defaults */
 #define EROFS_MOUNT_XATTR_USER		0x00000010
diff --git a/fs/erofs/rust/kinode.rs b/fs/erofs/rust/kinode.rs
new file mode 100644
index 000000000000..df6de40d0594
--- /dev/null
+++ b/fs/erofs/rust/kinode.rs
@@ -0,0 +1,49 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use core::ffi::c_void;
+use core::mem::MaybeUninit;
+use core::ptr::NonNull;
+
+use kernel::bindings::{inode, super_block};
+
+use super::erofs_sys::inode::*;
+use super::erofs_sys::superblock::*;
+use super::erofs_sys::*;
+
+#[repr(C)]
+pub(crate) struct KernelInode {
+    pub(crate) info: MaybeUninit<InodeInfo>,
+    pub(crate) nid: MaybeUninit<Nid>,
+    pub(crate) k_inode: MaybeUninit<inode>,
+    pub(crate) k_opaque: MaybeUninit<*mut c_void>,
+}
+
+impl Inode for KernelInode {
+    fn new(_sb: &SuperBlock, _info: InodeInfo, _nid: Nid) -> Self {
+        unimplemented!();
+    }
+    fn nid(&self) -> Nid {
+        unsafe { self.nid.assume_init() }
+    }
+    fn info(&self) -> &InodeInfo {
+        unsafe { self.info.assume_init_ref() }
+    }
+}
+
+pub(crate) struct KernelInodeCollection {
+    sb: NonNull<super_block>,
+}
+
+impl InodeCollection for KernelInodeCollection {
+    type I = KernelInode;
+    fn iget(&mut self, _nid: Nid, _f: &dyn FileSystem<Self::I>) -> PosixResult<&mut Self::I> {
+        unimplemented!();
+    }
+}
+
+impl KernelInodeCollection {
+    pub(crate) fn new(sb: NonNull<super_block>) -> Self {
+        Self { sb }
+    }
+}
diff --git a/fs/erofs/rust/ksources.rs b/fs/erofs/rust/ksources.rs
new file mode 100644
index 000000000000..08213e11239c
--- /dev/null
+++ b/fs/erofs/rust/ksources.rs
@@ -0,0 +1,66 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use core::ffi::*;
+use core::ptr::NonNull;
+
+use super::erofs_sys::data::*;
+use super::erofs_sys::errnos::*;
+use super::erofs_sys::*;
+
+use kernel::bindings::super_block;
+
+extern "C" {
+    #[link_name = "erofs_read_metabuf_rust_helper"]
+    pub(crate) fn read_metabuf(
+        sb: NonNull<c_void>,
+        sbi: NonNull<c_void>,
+        offset: c_ulonglong,
+    ) -> *mut c_void;
+    #[link_name = "erofs_put_metabuf_rust_helper"]
+    pub(crate) fn put_metabuf(addr: NonNull<c_void>);
+}
+
+fn try_read_metabuf(
+    sb: NonNull<super_block>,
+    sbi: NonNull<c_void>,
+    offset: c_ulonglong,
+) -> PosixResult<NonNull<c_void>> {
+    let ptr = unsafe { read_metabuf(sb.cast(), sbi.cast(), offset) };
+    if ptr.is_null() {
+        Err(Errno::ENOMEM)
+    } else if is_value_err(ptr) {
+        Err(Errno::from(ptr))
+    } else {
+        Ok(unsafe { NonNull::new_unchecked(ptr) })
+    }
+}
+
+pub(crate) struct MetabufSource {
+    sb: NonNull<super_block>,
+    opaque: NonNull<c_void>,
+}
+
+impl MetabufSource {
+    pub(crate) fn new(sb: NonNull<super_block>, opaque: NonNull<c_void>) -> Self {
+        Self { sb, opaque }
+    }
+}
+
+impl Source for MetabufSource {
+    fn fill(&self, data: &mut [u8], offset: Off) -> PosixResult<u64> {
+        self.as_buf(offset, data.len() as u64).map(|buf| {
+            data[..buf.content().len()].clone_from_slice(buf.content());
+            buf.content().len() as Off
+        })
+    }
+    fn as_buf<'a>(&'a self, offset: Off, len: Off) -> PosixResult<RefBuffer<'a>> {
+        try_read_metabuf(self.sb.clone(), self.opaque.clone(), offset).map(|ptr| {
+            let data: &'a [u8] =
+                unsafe { core::slice::from_raw_parts(ptr.as_ptr() as *const u8, len as usize) };
+            RefBuffer::new(data, 0, len as usize, |ptr| unsafe {
+                put_metabuf(NonNull::new_unchecked(ptr as *mut c_void))
+            })
+        })
+    }
+}
diff --git a/fs/erofs/rust/ksuperblock.rs b/fs/erofs/rust/ksuperblock.rs
new file mode 100644
index 000000000000..c1955fa136c6
--- /dev/null
+++ b/fs/erofs/rust/ksuperblock.rs
@@ -0,0 +1,30 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+use super::erofs_sys::superblock::*;
+use super::kinode::*;
+use alloc::boxed::Box;
+use core::{ffi::c_void, ptr::NonNull};
+use kernel::bindings::super_block;
+use kernel::types::ForeignOwnable;
+
+pub(crate) type KernelOpaque = NonNull<*mut c_void>;
+/// KernelSuperblockInfo defined by embedded Kernel Inode
+pub(crate) type KernelSuperblockInfo =
+    SuperblockInfo<KernelInode, KernelInodeCollection, KernelOpaque>;
+
+/// SAFETY:
+/// Cast the c_void back to KernelSuperblockInfo.
+/// This seems to be prune to some concurrency issues
+/// but the fact is that only KernelInodeCollection field can have mutability.
+/// However, it's backed by the original iget_locked5 and it's already preventing
+/// any concurrency issues. So it's safe to be casted mutable here even if it's not backed by
+/// Arc/Mutex instead of using generic method from Foreign Ownable which only provides
+/// immutable reference casting which is not enough.
+/// Since the pointer always live as long as this module exists, it's safe to declare it as static.
+pub(crate) fn erofs_sbi(sb: NonNull<super_block>) -> &'static mut KernelSuperblockInfo {
+    unsafe { &mut *(sb.as_ref().s_fs_info).cast::<KernelSuperblockInfo>() }
+}
+
+pub(crate) fn free_sbi(sb: NonNull<super_block>) {
+    unsafe { Box::<KernelSuperblockInfo>::from_foreign(sb.as_ref().s_fs_info) };
+}
diff --git a/fs/erofs/rust/mod.rs b/fs/erofs/rust/mod.rs
index e6c0731f2533..a8b66c95261c 100644
--- a/fs/erofs/rust/mod.rs
+++ b/fs/erofs/rust/mod.rs
@@ -2,3 +2,6 @@
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
 pub(crate) mod erofs_sys;
+pub(crate) mod kinode;
+pub(crate) mod ksources;
+pub(crate) mod ksuperblock;
diff --git a/fs/erofs/rust_bindings.h b/fs/erofs/rust_bindings.h
new file mode 100644
index 000000000000..9695c5ed5a7c
--- /dev/null
+++ b/fs/erofs/rust_bindings.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-later
+// EROFS Rust Bindings Before VFS Patch Sets for Rust
+
+#ifndef __EROFS_RUST_BINDINGS_H
+#define __EROFS_RUST_BINDINGS_H
+
+#include <linux/fs.h>
+
+extern const unsigned long EROFS_SB_INFO_OFFSET_RUST;
+extern void *erofs_alloc_sbi_rust(struct super_block *sb);
+extern void *erofs_free_sbi_rust(struct super_block *sb);
+#endif
diff --git a/fs/erofs/rust_helpers.c b/fs/erofs/rust_helpers.c
new file mode 100644
index 000000000000..5fdc158ed9ef
--- /dev/null
+++ b/fs/erofs/rust_helpers.c
@@ -0,0 +1,31 @@
+#include "rust_helpers.h"
+
+static void erofs_init_metabuf_rust_helper(struct erofs_buf *buf,
+					   struct super_block *sb,
+					   struct erofs_sb_info *sbi)
+{
+	if (erofs_is_fileio_mode(sbi))
+		buf->mapping = file_inode(sbi->fdev)->i_mapping;
+	else if (erofs_is_fscache_mode_rust_helper(sb, sbi))
+		buf->mapping = sbi->s_fscache->inode->i_mapping;
+	else
+		buf->mapping = sb->s_bdev->bd_mapping;
+}
+
+void *erofs_read_metabuf_rust_helper(struct super_block *sb,
+				     struct erofs_sb_info *sbi,
+				     erofs_off_t offset)
+{
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	erofs_init_metabuf_rust_helper(&buf, sb, sbi);
+	return erofs_bread(&buf, offset, EROFS_KMAP);
+}
+
+void erofs_put_metabuf_rust_helper(void *addr)
+{
+	erofs_put_metabuf(&(struct erofs_buf){
+		.base = addr,
+		.page = kmap_to_page(addr),
+		.kmap_type = EROFS_KMAP,
+	});
+}
diff --git a/fs/erofs/rust_helpers.h b/fs/erofs/rust_helpers.h
new file mode 100644
index 000000000000..158b21438314
--- /dev/null
+++ b/fs/erofs/rust_helpers.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-later
+// This is a helpers collection to dodge the missing macros or inline functions in bindgen
+
+#ifndef __EROFS_RUST_HELPERS_H
+#define __EROFS_RUST_HELPERS_H
+
+#include "internal.h"
+
+static inline bool erofs_is_fscache_mode_rust_helper(struct super_block *sb,
+						     struct erofs_sb_info *sbi)
+{
+	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
+	       !erofs_is_fileio_mode(sbi) && !sb->s_bdev;
+}
+
+void *erofs_read_metabuf_rust_helper(struct super_block *sb,
+				     struct erofs_sb_info *sbi,
+				     erofs_off_t offset);
+void erofs_put_metabuf_rust_helper(void *addr);
+
+#endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..61f138a7d8e2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -586,9 +586,12 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_sb_info *sbi;
 	int err;
-
+#ifdef CONFIG_EROFS_FS_RUST
+	sb->s_fs_info = erofs_alloc_sbi_rust(sb);
+#endif
+	sbi = EROFS_SB(sb);
 	sb->s_magic = EROFS_SUPER_MAGIC;
 	sb->s_flags |= SB_RDONLY | SB_NOATIME;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
@@ -809,7 +812,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
 
 static void erofs_kill_sb(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_sb_info *sbi;
+
+#ifdef CONFIG_EROFS_FS_RUST
+	sbi = erofs_free_sbi_rust(sb);
+#else
+	sbi = EROFS_SB(sb);
+#endif
 
 	if ((IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid) || sbi->fdev)
 		kill_anon_super(sb);
diff --git a/fs/erofs/super_rs.rs b/fs/erofs/super_rs.rs
index 4b8cbef507e3..7041f4011d4c 100644
--- a/fs/erofs/super_rs.rs
+++ b/fs/erofs/super_rs.rs
@@ -7,3 +7,53 @@
 #[allow(dead_code)]
 #[allow(missing_docs)]
 pub(crate) mod rust;
+
+use core::ffi::*;
+use core::mem::offset_of;
+use core::ptr::NonNull;
+use kernel::{bindings::super_block, types::ForeignOwnable};
+use rust::{
+    erofs_sys::{
+        alloc_helper::*,
+        data::backends::uncompressed::*,
+        superblock::{mem::*, *},
+        *,
+    },
+    kinode::*,
+    ksources::*,
+    ksuperblock::*,
+};
+
+fn try_alloc_sbi(sb: NonNull<super_block>) -> PosixResult<*const c_void> {
+    //  We have to use heap_alloc here to erase the signature of MemFileSystem
+    let sbi = heap_alloc(SuperblockInfo::new(
+        heap_alloc(KernelFileSystem::try_new(UncompressedBackend::new(
+            MetabufSource::new(sb, unsafe { NonNull::new_unchecked(sb.as_ref().s_fs_info) }),
+        ))?)?,
+        KernelInodeCollection::new(sb),
+        // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
+        unsafe { NonNull::new_unchecked(sb.as_ref().s_fs_info) },
+    ))?;
+    Ok(sbi.into_foreign())
+}
+/// Allocating a rust implementation of super_block_info c_void when calling from fill_super
+/// operations. Though we still need to embed original superblock info inside rust implementation
+/// for compatibility. This is left as it is for now.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_alloc_sbi_rust(sb: NonNull<super_block>) -> *const c_void {
+    try_alloc_sbi(sb).unwrap_or_else(|err| err.into())
+}
+
+/// Freeing a rust implementation of super_block_info c_void when calling from kill_super
+/// Returning the original c_void pointer for outer C code to free.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_free_sbi_rust(sb: NonNull<super_block>) -> *const c_void {
+    let opaque: *const c_void = erofs_sbi(sb).opaque.as_ptr().cast();
+    // This will be freed as it goes out of the scope.
+    free_sbi(sb);
+    opaque
+}
+
+/// Used as a hint offset to be exported so that EROFS_SB can find the correct the s_fs_info.
+#[no_mangle]
+pub static EROFS_SB_INFO_OFFSET_RUST: c_ulong = offset_of!(KernelSuperblockInfo, opaque) as c_ulong;
-- 
2.46.0


