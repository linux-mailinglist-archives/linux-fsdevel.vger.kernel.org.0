Return-Path: <linux-fsdevel+bounces-29504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7120497A3A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC8CB28A2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743B192D81;
	Mon, 16 Sep 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="OBq4tMd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175571925B6;
	Mon, 16 Sep 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495047; cv=none; b=usfwa/6ZbdVHRj4zs44cIR1bRLIa+OY8+cYL4OTNRX53rS1uIOmKPl7fuLkjXB62y9bTjtlXKN5l3hTZ3kGfQWILoBcelomv2Me6cxSRmSU6SH+7/kVEX2yxoGGJdmlfCi5Q0ta+mzXG08Laoxb6NEv3AuYjU6NpCrR7qsWej8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495047; c=relaxed/simple;
	bh=IbqHVfFbye38HXIk4ja/9ILQ7+ASn23iwfedn4kSYa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUtIRtGyeAcL+1jxGaculGf42yhK8ZTT+7K3lI4N+AQdEpnj24HKBBiXQdstyLBFcgPjfyhNvX5+bDdT8vNIN5lzd+XsaVXhkeyvsd9O2bDlL/57GCL5gQe2BNrvUEftgybQ272lSyAx5IqyGbkk6DhpZbvhhuouiScDafK536I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=OBq4tMd5; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B6EF6984F;
	Mon, 16 Sep 2024 09:57:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495045; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1pC3X6eZfUmCLid8GeSOP4AYR2slkMfkaqDKXR4//jw=;
	b=OBq4tMd5dYEC3VbRFlTrDgJ/lGksSk/7sMmAwQyZTzjoDd5wCgs9eVvUoWrXGTmzjl1gDa
	TeDBQH3Afx9YA958Hdk4c3RXefxejPxbat5ZHuSEHNhhSfQSgFu9EC6oB3j8f91y78BDo+
	AudCJOL23givZmhLYVNf/+WRgtxOGJ8hYdG+6PcUlex5iiIgm1aBqEUFuIK0MQtFM2AtB3
	axd12VcnG+Jx9Q7SA02HMmKWEpnx1oZ0au7byoIDk5fCKwr40CF6x1RpwhEtT6NTZlYm5D
	nEjXbsW8XwpE3XcSOicA6n0Cxj0XTGwa/1FU4hHB+3pVCxvNC0y3afs5M3yScg==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 24/24] erofs: introduce xattrs replacement to C
Date: Mon, 16 Sep 2024 21:56:34 +0800
Message-ID: <20240916135634.98554-25-toolmanp@tlmp.cc>
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

This patch introduces erofs_getxattr_rust and erofs_listxattr_rust to C
and can replace the original xattr logic entirely.

Note that the original acl implementation is tweaked with a lifted
function called erofs_getxattr_nobuf, so that difference of the calling
convention of Rust side code can be bridged.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/Makefile        |   3 ++
 fs/erofs/rust_bindings.h |   8 +++
 fs/erofs/xattr.c         |  31 +++++++++---
 fs/erofs/xattr.h         |   7 +++
 fs/erofs/xattr_rs.rs     | 106 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 148 insertions(+), 7 deletions(-)
 create mode 100644 fs/erofs/xattr_rs.rs

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 219ddca0642e..ad0650698f4b 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -10,3 +10,6 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
 erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o namei_rs.o dir_rs.o data_rs.o rust_helpers.o
+ifeq ($(CONFIG_EROFS_FS_XATTR),y)
+erofs-$(CONFIG_EROFS_FS_RUST) += xattr_rs.o
+endif
diff --git a/fs/erofs/rust_bindings.h b/fs/erofs/rust_bindings.h
index ad9aa75a7a2c..e5a879efd9e2 100644
--- a/fs/erofs/rust_bindings.h
+++ b/fs/erofs/rust_bindings.h
@@ -28,4 +28,12 @@ extern int erofs_readdir_rust(struct file *file, struct dir_context *ctx);
 struct erofs_map_blocks;
 extern int erofs_map_blocks_rust(struct inode *inode,
 				 struct erofs_map_blocks *map);
+extern int erofs_getxattr_rust(struct inode *inode, unsigned int flags,
+			       const char *name, void *buffer, size_t size);
+extern ssize_t erofs_listxattr_rust(struct dentry *dentry, char *buffer,
+			       size_t buffer_size);
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+extern int erofs_getxattr_nobuf_rust(struct inode *inode, int prefix,
+				 const char *name, char **value);
+#endif
 #endif
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a90d7d649739..0296c5809695 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -8,6 +8,7 @@
 #include <linux/xxhash.h>
 #include "xattr.h"
 
+#ifndef CONFIG_EROFS_FS_RUST
 struct erofs_xattr_iter {
 	struct super_block *sb;
 	struct erofs_buf buf;
@@ -122,6 +123,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	clear_and_wake_up_bit(EROFS_I_BL_XATTR_BIT, &vi->flags);
 	return ret;
 }
+#endif
 
 static bool erofs_xattr_user_list(struct dentry *dentry)
 {
@@ -175,6 +177,7 @@ const struct xattr_handler * const erofs_xattr_handlers[] = {
 	NULL,
 };
 
+#ifndef CONFIG_EROFS_FS_RUST
 static int erofs_xattr_copy_to_buffer(struct erofs_xattr_iter *it,
 				      unsigned int len)
 {
@@ -509,8 +512,28 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 		erofs_xattr_prefixes_cleanup(sb);
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
+#ifndef CONFIG_EROFS_FS_RUST
+static int erofs_getxattr_nobuf(struct inode *inode, int prefix,
+				 const char *name, char **value)
+{
+	int rc;
+	char *buf = NULL;
+	rc = erofs_getxattr(inode, prefix, name, NULL, 0);
+	if (rc > 0) {
+		buf = kmalloc(rc, GFP_KERNEL);
+		if (!value)
+			return ENOMEM;
+		rc = erofs_getxattr(inode, prefix, name, buf, rc);
+	}
+	*value = buf;
+	return rc;
+}
+#else
+#define erofs_getxattr_nobuf erofs_getxattr_nobuf_rust
+#endif
 struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 {
 	struct posix_acl *acl;
@@ -531,13 +554,7 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 		return ERR_PTR(-EINVAL);
 	}
 
-	rc = erofs_getxattr(inode, prefix, "", NULL, 0);
-	if (rc > 0) {
-		value = kmalloc(rc, GFP_KERNEL);
-		if (!value)
-			return ERR_PTR(-ENOMEM);
-		rc = erofs_getxattr(inode, prefix, "", value, rc);
-	}
+	rc = erofs_getxattr_nobuf(inode, prefix, "", &value);
 
 	if (rc == -ENOATTR)
 		acl = NULL;
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index b246cd0e135e..2b934c25e991 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -46,10 +46,17 @@ static inline const char *erofs_xattr_prefix(unsigned int idx,
 
 extern const struct xattr_handler * const erofs_xattr_handlers[];
 
+#ifdef CONFIG_EROFS_FS_RUST
+#define erofs_getxattr erofs_getxattr_rust
+#define erofs_listxattr erofs_listxattr_rust
+static inline int erofs_xattr_prefixes_init(struct super_block *sb) { return 0; }
+static inline void erofs_xattr_prefixes_cleanup(struct super_block *sb) {}
+#else
 int erofs_xattr_prefixes_init(struct super_block *sb);
 void erofs_xattr_prefixes_cleanup(struct super_block *sb);
 int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
 ssize_t erofs_listxattr(struct dentry *, char *, size_t);
+#endif
 #else
 static inline int erofs_xattr_prefixes_init(struct super_block *sb) { return 0; }
 static inline void erofs_xattr_prefixes_cleanup(struct super_block *sb) {}
diff --git a/fs/erofs/xattr_rs.rs b/fs/erofs/xattr_rs.rs
new file mode 100644
index 000000000000..9429507089f6
--- /dev/null
+++ b/fs/erofs/xattr_rs.rs
@@ -0,0 +1,106 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+//! EROFS Rust Kernel Module Helpers Implementation
+//! This is only for experimental purpose. Feedback is always welcome.
+
+#[allow(dead_code)]
+#[allow(missing_docs)]
+pub(crate) mod rust;
+use core::ffi::*;
+use core::ptr::NonNull;
+
+use kernel::bindings::{dentry, inode};
+use kernel::container_of;
+
+use rust::{erofs_sys::xattrs::*, kinode::*, ksuperblock::*};
+
+/// Used as a replacement for erofs_getattr.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_getxattr_rust(
+    k_inode: NonNull<inode>,
+    index: c_uint,
+    name: NonNull<u8>,
+    buffer: NonNull<u8>,
+    size: usize,
+) -> c_int {
+    // SAFETY: super_block and superblockinfo is always initialized in k_inode.
+    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });
+    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };
+    // SAFETY: buffer is always initialized in the caller and name is null terminated C string.
+    unsafe {
+        match sbi.filesystem.get_xattr(
+            erofs_inode,
+            index,
+            core::ffi::CStr::from_ptr(name.as_ptr().cast()).to_bytes(),
+            &mut Some(core::slice::from_raw_parts_mut(
+                buffer.as_ptr().cast(),
+                size,
+            )),
+        ) {
+            Ok(value) => match value {
+                XAttrValue::Buffer(x) => x as c_int,
+                _ => unreachable!(),
+            },
+            Err(e) => i32::from(e) as c_int,
+        }
+    }
+}
+
+/// Used as a replacement for erofs_getattr_nobuf.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_getxattr_nobuf_rust(
+    k_inode: NonNull<inode>,
+    index: u32,
+    name: NonNull<u8>,
+    mut value: NonNull<*mut u8>,
+) -> c_int {
+    // SAFETY: super_block and superblockinfo is always initialized in k_inode.
+    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });
+    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };
+    // SAFETY: buffer is always initialized in the caller and name is null terminated C string.
+    unsafe {
+        match sbi.filesystem.get_xattr(
+            erofs_inode,
+            index,
+            core::ffi::CStr::from_ptr(name.as_ptr().cast()).to_bytes(),
+            &mut None,
+        ) {
+            Ok(xattr_value) => match xattr_value {
+                XAttrValue::Vec(v) => {
+                    let rc = v.len() as c_int;
+                    *value.as_mut() = v.leak().as_mut_ptr().cast();
+                    rc
+                }
+
+                _ => unreachable!(),
+            },
+            Err(e) => i32::from(e) as c_int,
+        }
+    }
+}
+
+/// Used as a replacement for erofs_getattr.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_listxattr_rust(
+    dentry: NonNull<dentry>,
+    buffer: NonNull<u8>,
+    size: usize,
+) -> c_long {
+    // SAFETY: dentry is always initialized in the caller.
+    let k_inode = unsafe { dentry.as_ref().d_inode };
+    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called.
+    let erofs_inode = unsafe { &*container_of!(k_inode, KernelInode, k_inode) };
+    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
+    let sbi = erofs_sbi(unsafe { NonNull::new((*k_inode).i_sb).unwrap() });
+    match sbi.filesystem.list_xattrs(
+        erofs_inode,
+        // SAFETY: buffer is always initialized in the caller.
+        unsafe { core::slice::from_raw_parts_mut(buffer.as_ptr().cast(), size) },
+    ) {
+        Ok(value) => value as c_long,
+        Err(e) => i32::from(e) as c_long,
+    }
+}
-- 
2.46.0


