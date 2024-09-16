Return-Path: <linux-fsdevel+bounces-29498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B1897A392
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEDD1C25EB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87820188CB0;
	Mon, 16 Sep 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="B2bQYZ9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27528188017;
	Mon, 16 Sep 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495036; cv=none; b=ousqriap/SBqG6+cuBd9HKaktk4hg+9EdDlw9HwpbMzZEhN2uk09hmEY7YOMr0wSMzckYWZFuhqev6JoyOwrUWH/gbpYJaHS2n8lHS/6IMEAtKYp4IKddkkiwiFwolf+xcFX7addK0aJpwrH9Y0H99lCet83tFCz24zCIYQcBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495036; c=relaxed/simple;
	bh=OzFT3rPtlk61UGvleBzAz4/qOlkHVP0IYWbCKlZDrLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BL7FWiPbB405v7VbIteqsTDrPnHWMZhhaq6NQT6jUdQ7onwr0vhJ9n0wgwQP7bFfnX3eE0K0K1++EpJA760PVQCe8kvcu6zmcNjeTAbxTkHBGGGvNjOFT0BMtSAGYvp1O1Ltk61sxrwGKPXyYDCKzx4qnTRnFCzA/tqphyJLuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=B2bQYZ9Q; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56F7A69845;
	Mon, 16 Sep 2024 09:57:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495033; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=jPcHYzXLLC1yFU/qCQqga7ARoLByMqJwxrzsY3R4Kho=;
	b=B2bQYZ9QMRfXNJ53KJENNVh3g2BJuojQBnV3SzMkxgWlKIBEbSTLq1EWYLuXD8ccGgB0kR
	5Z/3pYlo2I/b4xota/3wQ6kMeL5DZGI4HO/kRt0oVpqnP1zWKGuc+7sGwcMIuCUDMDyMS6
	5Cy28SnN89zZSi3Mg4NTnfrX0oRDjY2oJahLa4G+likn++UUCNlZarGnfm5Fx5KPUtfOyX
	mVed3kTevO+60gsX3IqPnBDWuyuTGm3rnOOygEE2ECtQp1aARtny7ijJQHvbB5jBs8pWI2
	+0xNxlS05sGeOfDNvppWDtN2WoOpsXEEeRXcEcB0tyzu5+0EagITGtFFQi20/w==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 18/24] erofs: introduce iget alternative to C
Date: Mon, 16 Sep 2024 21:56:28 +0800
Message-ID: <20240916135634.98554-19-toolmanp@tlmp.cc>
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

This patch introduces iget and fast symlink alternative written in Rust.
After this patch, erofs_iget can be replaced with erofs_iget_rust.

Iget related test and set are lifted after this patch as
rust_helpers.c will also use it to port the iget_locked to Rust.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/Makefile        |  2 +-
 fs/erofs/inode.c         |  8 ++++--
 fs/erofs/inode_rs.rs     | 59 ++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h      | 33 ++++++++++++++++++++++
 fs/erofs/rust/kinode.rs  | 29 +++++++++++++++++---
 fs/erofs/rust_bindings.h | 12 ++++++++
 fs/erofs/rust_helpers.c  | 55 +++++++++++++++++++++++++++++++++++++
 fs/erofs/rust_helpers.h  |  4 ++-
 fs/erofs/super.c         | 34 ++++++++++++++++++-----
 9 files changed, 220 insertions(+), 16 deletions(-)
 create mode 100644 fs/erofs/inode_rs.rs

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index dfa03edbe29a..46de6f490ca2 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,4 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
-erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o rust_helpers.o
+erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o rust_helpers.o
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d2fd51fcebd2..b8467272a670 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -269,7 +269,7 @@ int erofs_fill_inode(struct inode *inode)
  * ino_t is 32-bits on 32-bit arch. We have to squash the 64-bit value down
  * so that it will fit.
  */
-static ino_t erofs_squash_ino(erofs_nid_t nid)
+ino_t erofs_squash_ino(erofs_nid_t nid)
 {
 	ino_t ino = (ino_t)nid;
 
@@ -278,12 +278,12 @@ static ino_t erofs_squash_ino(erofs_nid_t nid)
 	return ino;
 }
 
-static int erofs_iget5_eq(struct inode *inode, void *opaque)
+int erofs_iget5_eq(struct inode *inode, void *opaque)
 {
 	return EROFS_I(inode)->nid == *(erofs_nid_t *)opaque;
 }
 
-static int erofs_iget5_set(struct inode *inode, void *opaque)
+int erofs_iget5_set(struct inode *inode, void *opaque)
 {
 	const erofs_nid_t nid = *(erofs_nid_t *)opaque;
 
@@ -292,6 +292,7 @@ static int erofs_iget5_set(struct inode *inode, void *opaque)
 	return 0;
 }
 
+#ifndef CONFIG_EROFS_FS_RUST
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 {
 	struct inode *inode;
@@ -312,6 +313,7 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 	}
 	return inode;
 }
+#endif
 
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
diff --git a/fs/erofs/inode_rs.rs b/fs/erofs/inode_rs.rs
new file mode 100644
index 000000000000..5cca2ae581ac
--- /dev/null
+++ b/fs/erofs/inode_rs.rs
@@ -0,0 +1,59 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+//! EROFS Rust Kernel Module Helpers Implementation
+//! This is only for experimental purpose. Feedback is always welcome.
+
+#[allow(dead_code)]
+#[allow(missing_docs)]
+pub(crate) mod rust;
+
+use core::ffi::*;
+use core::mem::{offset_of, size_of};
+use core::ptr::NonNull;
+use kernel::bindings::{inode, super_block};
+use kernel::container_of;
+use rust::{
+    erofs_sys::{operations::*, *},
+    kinode::*,
+    ksuperblock::erofs_sbi,
+};
+
+/// Used as a size hint to be exported to kmem_caceh_create
+#[no_mangle]
+pub static EROFS_INODE_SIZE_RUST: c_uint = size_of::<KernelInode>() as c_uint;
+
+/// Used as a hint offset to be exported so EROFS_VFS_I to find the embedded the vfs inode.
+#[no_mangle]
+pub static EROFS_VFS_INODE_OFFSET_RUST: c_ulong = offset_of!(KernelInode, k_inode) as c_ulong;
+
+/// Used as a hint offset to be exported to EROFS_I to find the embedded c side erofs_inode.
+#[no_mangle]
+pub static EROFS_I_OFFSET_RUST: c_long =
+    offset_of!(KernelInode, k_opaque) as c_long - offset_of!(KernelInode, k_inode) as c_long;
+
+/// Exported as iget replacement
+#[no_mangle]
+pub unsafe extern "C" fn erofs_iget_rust(sb: NonNull<super_block>, nid: Nid) -> *mut c_void {
+    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
+    let sbi = erofs_sbi(sb);
+    read_inode(sbi.filesystem.as_ref(), &mut sbi.inodes, nid)
+        .map_or_else(|e| e.into(), |inode| inode.k_inode.as_mut_ptr().cast())
+}
+
+fn try_fill_inode(k_inode: NonNull<inode>, nid: Nid) -> PosixResult<()> {
+    // SAFETY: The super_block is initialized when the erofs_fill_inode_rust is called.
+    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });
+    // SAFETY: k_inode is a part of KernelInode.
+    let erofs_inode: &mut KernelInode = unsafe {
+        &mut *(container_of!(k_inode.as_ptr(), KernelInode, k_inode) as *mut KernelInode)
+    };
+    erofs_inode.info.write(sbi.filesystem.read_inode_info(nid)?);
+    erofs_inode.nid.write(nid);
+    Ok(())
+}
+/// Exported as fill_inode additional fill inode
+#[no_mangle]
+pub unsafe extern "C" fn erofs_fill_inode_rust(k_inode: NonNull<inode>, nid: Nid) -> c_int {
+    try_fill_inode(k_inode, nid).map_or_else(|e| i32::from(e) as c_int, |_| 0)
+}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 18e67219fbc8..42ce84783be7 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -306,10 +306,20 @@ struct erofs_inode {
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
 	/* the corresponding vfs inode */
+#ifndef CONFIG_EROFS_FS_RUST
 	struct inode vfs_inode;
+#endif
 };
 
+#ifdef CONFIG_EROFS_FS_RUST
+#define EROFS_I(ptr)	(*(struct erofs_inode **)(((void *)(ptr)) + \
+			 EROFS_I_OFFSET_RUST))
+#define EROFS_I_VFS(ptr) ((struct inode *)(((void *)(ptr)) + EROFS_VFS_INODE_OFFSET_RUST))
+#define EROFS_I_RUST(ptr) ((void *)(ptr) - EROFS_VFS_INODE_OFFSET_RUST)
+#else
 #define EROFS_I(ptr)	container_of(ptr, struct erofs_inode, vfs_inode)
+#define EROFS_I_VFS(ptr) (&((struct erofs_inode *)(ptr))->vfs_inode)
+#endif
 
 static inline erofs_off_t erofs_iloc(struct inode *inode)
 {
@@ -427,10 +437,18 @@ void erofs_onlinefolio_init(struct folio *folio);
 void erofs_onlinefolio_split(struct folio *folio);
 void erofs_onlinefolio_end(struct folio *folio, int err);
 int erofs_fill_inode(struct inode *inode);
+ino_t erofs_squash_ino(erofs_nid_t nid);
+int erofs_iget5_eq(struct inode *inode, void *opaque);
+int erofs_iget5_set(struct inode *inode, void *opaque);
+#ifdef CONFIG_EROFS_FS_RUST
+#define erofs_iget erofs_iget_rust
+#else
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
+#endif
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
 		  unsigned int query_flags);
+
 int erofs_namei(struct inode *dir, const struct qstr *name,
 		erofs_nid_t *nid, unsigned int *d_type);
 
@@ -538,6 +556,21 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
 static inline void erofs_fscache_submit_bio(struct bio *bio) {}
 #endif
 
+#ifdef CONFIG_EROFS_FS_RUST
+extern int erofs_init_rust(void);
+extern void erofs_destroy_rust(void);
+extern void erofs_init_inode_rust(struct inode *inode);
+extern void erofs_free_inode_rust(struct inode *inode);
+#else
+static inline int erofs_init_rust(void)
+{
+	return 0;
+}
+static inline void erofs_destroy_rust(void) {}
+static inline void erofs_init_inode_rust(struct inode *inode) {}
+static inline void erofs_free_inode_rust(struct inode *inode) {}
+#endif
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/rust/kinode.rs b/fs/erofs/rust/kinode.rs
index df6de40d0594..fac72bd8b6b3 100644
--- a/fs/erofs/rust/kinode.rs
+++ b/fs/erofs/rust/kinode.rs
@@ -1,16 +1,23 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
-use core::ffi::c_void;
+use core::ffi::*;
 use core::mem::MaybeUninit;
 use core::ptr::NonNull;
 
 use kernel::bindings::{inode, super_block};
+use kernel::container_of;
 
+use super::erofs_sys::errnos::*;
 use super::erofs_sys::inode::*;
 use super::erofs_sys::superblock::*;
 use super::erofs_sys::*;
 
+extern "C" {
+    #[link_name = "erofs_iget_locked_rust_helper"]
+    fn iget_locked(sb: NonNull<c_void>, nid: Nid) -> *mut c_void;
+}
+
 #[repr(C)]
 pub(crate) struct KernelInode {
     pub(crate) info: MaybeUninit<InodeInfo>,
@@ -21,7 +28,12 @@ pub(crate) struct KernelInode {
 
 impl Inode for KernelInode {
     fn new(_sb: &SuperBlock, _info: InodeInfo, _nid: Nid) -> Self {
-        unimplemented!();
+        Self {
+            info: MaybeUninit::uninit(),
+            nid: MaybeUninit::uninit(),
+            k_inode: MaybeUninit::uninit(),
+            k_opaque: MaybeUninit::uninit(),
+        }
     }
     fn nid(&self) -> Nid {
         unsafe { self.nid.assume_init() }
@@ -37,8 +49,17 @@ pub(crate) struct KernelInodeCollection {
 
 impl InodeCollection for KernelInodeCollection {
     type I = KernelInode;
-    fn iget(&mut self, _nid: Nid, _f: &dyn FileSystem<Self::I>) -> PosixResult<&mut Self::I> {
-        unimplemented!();
+    fn iget(&mut self, nid: Nid, _f: &dyn FileSystem<Self::I>) -> PosixResult<&mut Self::I> {
+        // SAFETY: iget_locked is safe to call here.
+        let k_inode = unsafe { iget_locked(self.sb.cast(), nid) };
+        if is_value_err(k_inode.cast()) {
+            return Err(Errno::from(k_inode as i32));
+        } else {
+            let erofs_inode: &mut KernelInode =
+                // SAFETY: iget_locked returns a valid pointer to a vfs inode and it's embedded in a KernelInode.
+                unsafe { &mut *(container_of!(k_inode, KernelInode, k_inode) as *mut KernelInode) };
+            return Ok(erofs_inode);
+        }
     }
 }
 
diff --git a/fs/erofs/rust_bindings.h b/fs/erofs/rust_bindings.h
index 9695c5ed5a7c..657f109dd6e7 100644
--- a/fs/erofs/rust_bindings.h
+++ b/fs/erofs/rust_bindings.h
@@ -6,7 +6,19 @@
 
 #include <linux/fs.h>
 
+
+typedef u64 erofs_nid_t;
+typedef u64 erofs_off_t;
+/* data type for filesystem-wide blocks number */
+typedef u32 erofs_blk_t;
+
 extern const unsigned long EROFS_SB_INFO_OFFSET_RUST;
+extern const unsigned int EROFS_INODE_SIZE_RUST;
+extern const unsigned long EROFS_VFS_INODE_OFFSET_RUST;
+extern const long EROFS_I_OFFSET_RUST;
+
 extern void *erofs_alloc_sbi_rust(struct super_block *sb);
 extern void *erofs_free_sbi_rust(struct super_block *sb);
+extern int erofs_iget5_eq_rust(struct inode *inode, void *opaque);
+extern struct inode *erofs_iget_rust(struct super_block *sb, erofs_nid_t nid);
 #endif
diff --git a/fs/erofs/rust_helpers.c b/fs/erofs/rust_helpers.c
index 5fdc158ed9ef..94e9153fc3ff 100644
--- a/fs/erofs/rust_helpers.c
+++ b/fs/erofs/rust_helpers.c
@@ -1,5 +1,7 @@
 #include "rust_helpers.h"
 
+static struct kmem_cache *erofs_inode_cachep __read_mostly;
+
 static void erofs_init_metabuf_rust_helper(struct erofs_buf *buf,
 					   struct super_block *sb,
 					   struct erofs_sb_info *sbi)
@@ -29,3 +31,56 @@ void erofs_put_metabuf_rust_helper(void *addr)
 		.kmap_type = EROFS_KMAP,
 	});
 }
+
+int erofs_init_rust(void)
+{
+	erofs_inode_cachep = kmem_cache_create("erofs_inode",
+					       sizeof(struct erofs_inode), 0,
+					       SLAB_RECLAIM_ACCOUNT, NULL);
+	if (!erofs_inode_cachep)
+		return -ENOMEM;
+	return 0;
+}
+
+void erofs_destroy_rust(void)
+{
+	if (erofs_inode_cachep)
+		kmem_cache_destroy(erofs_inode_cachep);
+}
+
+void erofs_init_inode_rust(struct inode *inode)
+{
+	EROFS_I(inode) = kmem_cache_alloc(erofs_inode_cachep, GFP_KERNEL);
+}
+
+void erofs_free_inode_rust(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	if (vi)
+		kmem_cache_free(erofs_inode_cachep, vi);
+}
+
+struct inode *erofs_iget_locked_rust_helper(struct super_block *sb, erofs_nid_t nid)
+{
+	struct inode *inode;
+	int err;
+
+	inode = iget5_locked(sb, erofs_squash_ino(nid), erofs_iget5_eq,
+			     erofs_iget5_set, &nid);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	err = erofs_fill_inode(inode);
+	if(err)
+		goto err_out;
+
+	err = erofs_fill_inode_rust(inode, nid);
+	if(err)
+		goto err_out;
+
+	return inode;
+err_out:
+	if (err)
+		iget_failed(inode);
+	return ERR_PTR(err);
+}
diff --git a/fs/erofs/rust_helpers.h b/fs/erofs/rust_helpers.h
index 158b21438314..5bcd452f6d82 100644
--- a/fs/erofs/rust_helpers.h
+++ b/fs/erofs/rust_helpers.h
@@ -17,5 +17,7 @@ void *erofs_read_metabuf_rust_helper(struct super_block *sb,
 				     struct erofs_sb_info *sbi,
 				     erofs_off_t offset);
 void erofs_put_metabuf_rust_helper(void *addr);
-
+extern int erofs_fill_inode_rust(struct inode *inode, erofs_nid_t nid);
+struct inode *erofs_iget_locked_rust_helper(struct super_block *sb,
+						   erofs_nid_t nid);
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 61f138a7d8e2..659502bdf5fe 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -81,22 +81,23 @@ static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 
 static void erofs_inode_init_once(void *ptr)
 {
-	struct erofs_inode *vi = ptr;
-
-	inode_init_once(&vi->vfs_inode);
+	inode_init_once(EROFS_I_VFS(ptr));
+	erofs_init_inode_rust(EROFS_I_VFS(ptr));
 }
 
 static struct inode *erofs_alloc_inode(struct super_block *sb)
 {
-	struct erofs_inode *vi =
+	void *ptr =
 		alloc_inode_sb(sb, erofs_inode_cachep, GFP_KERNEL);
 
-	if (!vi)
+	if (!ptr)
 		return NULL;
 
+#ifndef CONFIG_EROFS_FS_RUST
 	/* zero out everything except vfs_inode */
-	memset(vi, 0, offsetof(struct erofs_inode, vfs_inode));
-	return &vi->vfs_inode;
+	memset(ptr, 0, offsetof(struct erofs_inode, vfs_inode));
+#endif
+	return EROFS_I_VFS(ptr);
 }
 
 static void erofs_free_inode(struct inode *inode)
@@ -106,7 +107,12 @@ static void erofs_free_inode(struct inode *inode)
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
 	kfree(vi->xattr_shared_xattrs);
+	erofs_free_inode_rust(inode);
+#ifdef CONFIG_EROFS_FS_RUST
+	kmem_cache_free(erofs_inode_cachep, EROFS_I_RUST(inode));
+#else
 	kmem_cache_free(erofs_inode_cachep, vi);
+#endif
 }
 
 /* read variable-sized metadata, offset will be aligned by 4-byte */
@@ -871,13 +877,25 @@ static int __init erofs_module_init(void)
 
 	erofs_check_ondisk_layout_definitions();
 
+#ifndef CONFIG_EROFS_FS_RUST
 	erofs_inode_cachep = kmem_cache_create("erofs_inode",
 			sizeof(struct erofs_inode), 0,
 			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
 			erofs_inode_init_once);
+#else
+	erofs_inode_cachep = kmem_cache_create("erofs_inode_rust",
+			EROFS_INODE_SIZE_RUST, 0,
+			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
+			erofs_inode_init_once);
+#endif
+
 	if (!erofs_inode_cachep)
 		return -ENOMEM;
 
+	err = erofs_init_rust();
+	if(err)
+		goto rust_err;
+
 	err = erofs_init_shrinker();
 	if (err)
 		goto shrinker_err;
@@ -904,6 +922,8 @@ static int __init erofs_module_init(void)
 	erofs_exit_shrinker();
 shrinker_err:
 	kmem_cache_destroy(erofs_inode_cachep);
+rust_err:
+	erofs_destroy_rust();
 	return err;
 }
 
-- 
2.46.0


