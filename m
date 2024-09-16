Return-Path: <linux-fsdevel+bounces-29499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0332797A394
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2879A1C2608E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794918A956;
	Mon, 16 Sep 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="JAJ4mD6Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0E189503;
	Mon, 16 Sep 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495038; cv=none; b=pjQRdf+vzZqM0JRQJyd7sj1DhSsCFSpA2yJnmlIeSXW4bMaYPRsGSwUu6DToDr2B/GWIGIKies1x/oa4ZT79xqAzJocpgVbIvTGonQAZOtuUMB+mnRpTI2LXX7eV5VNUmITPPhdwS7E67d5+Gv4Def98e50QDYyk/Qkxvfsb+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495038; c=relaxed/simple;
	bh=hlsNrrmS5LmffHkBX0DY0nyvuVIEAppvHs0rSr/LvwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj2Ucjj1Il5W/qt6hH8H+/dLI5bmpo4pq9KUqbwcDI8cJoEMWzVaareDvS5IKlJjO1NdbqYrASdxGWxtlKcSsCzyXn8a2zPWdEKODq6zgy5vsoMmsaB8nEwu7skkW7h7mYZaHTPqYIGutR+VipJeMenS9UKh0WvsrMbPJ6Xkz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=JAJ4mD6Y; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41C9B69988;
	Mon, 16 Sep 2024 09:57:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495035; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wch3FBTJC/bfytZ3iSboViHurbJ2bB+wmP7ljpFHKFU=;
	b=JAJ4mD6Y6Dz95HshWm2ZSD8lfpBJTL8YO+qZvc6z6pWLLcAayJcjvOqvAZ7DSODgg1RgQc
	ulM5shkDbh8AgRooTD35bJBgF+Uy2vhjqyq483jOhgeOZruvduGSyzLXRquBzadKyq/tvC
	Ya2JL42DKCXPN8vGkZa0NoRvWahIqemXs8weQq6S90d6Na4+dqhn+Y0hqtJNPAvksQcJbZ
	wqCTmbIlhY2WVrzzTlo2bmv+hswA9svhKXfpP3brGDVigu8wuftqOodhRHkIstiSdBCXvH
	oQRACxgsPBmL+zDXAOu4+sBPFEMypa/XBMn0r6GIJmyy6G4pXLse+Hue6vN8Vg==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Date: Mon, 16 Sep 2024 21:56:29 +0800
Message-ID: <20240916135634.98554-20-toolmanp@tlmp.cc>
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

This patch introduces erofs_lookup_rust and erofs_get_parent_rust
written in Rust as an alternative to the original namei.c.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/Makefile        |  2 +-
 fs/erofs/internal.h      |  2 ++
 fs/erofs/namei.c         |  2 ++
 fs/erofs/namei_rs.rs     | 56 ++++++++++++++++++++++++++++++++++++++++
 fs/erofs/rust_bindings.h |  4 ++-
 fs/erofs/super.c         |  2 ++
 6 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 fs/erofs/namei_rs.rs

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 46de6f490ca2..0f748f3e0ff6 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,4 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
-erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o rust_helpers.o
+erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o namei_rs.o rust_helpers.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 42ce84783be7..1d9dfae285d5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -442,6 +442,8 @@ int erofs_iget5_eq(struct inode *inode, void *opaque);
 int erofs_iget5_set(struct inode *inode, void *opaque);
 #ifdef CONFIG_EROFS_FS_RUST
 #define erofs_iget erofs_iget_rust
+#define erofs_get_parent erofs_get_parent_rust
+#define erofs_lookup erofs_lookup_rust
 #else
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 #endif
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index c94d0c1608a8..f657d475c4a1 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -7,6 +7,7 @@
 #include "xattr.h"
 #include <trace/events/erofs.h>
 
+#ifndef CONFIG_EROFS_FS_RUST
 struct erofs_qstr {
 	const unsigned char *name;
 	const unsigned char *end;
@@ -214,6 +215,7 @@ static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = erofs_iget(dir->i_sb, nid);
 	return d_splice_alias(inode, dentry);
 }
+#endif
 
 const struct inode_operations erofs_dir_iops = {
 	.lookup = erofs_lookup,
diff --git a/fs/erofs/namei_rs.rs b/fs/erofs/namei_rs.rs
new file mode 100644
index 000000000000..d73a0a7bee1e
--- /dev/null
+++ b/fs/erofs/namei_rs.rs
@@ -0,0 +1,56 @@
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
+use kernel::bindings::{d_obtain_alias, d_splice_alias, dentry, inode};
+use kernel::container_of;
+
+use rust::{erofs_sys::operations::*, kinode::*, ksuperblock::*};
+
+/// Lookup function for dentry-inode lookup replacement.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_lookup_rust(
+    k_inode: NonNull<inode>,
+    dentry: NonNull<dentry>,
+    _flags: c_uint,
+) -> *mut c_void {
+    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };
+    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
+    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });
+    // SAFETY: this is backed by qstr which is c representation of a valid slice.
+    let name = unsafe {
+        core::str::from_utf8_unchecked(core::slice::from_raw_parts(
+            dentry.as_ref().d_name.name,
+            dentry.as_ref().d_name.__bindgen_anon_1.__bindgen_anon_1.len as usize,
+        ))
+    };
+    let k_inode: *mut inode =
+        dir_lookup(sbi.filesystem.as_ref(), &mut sbi.inodes, erofs_inode, name)
+            .map_or(core::ptr::null_mut(), |result| result.k_inode.as_mut_ptr());
+
+    // SAFETY: We are sure that the inner k_inode has already been initialized.
+    unsafe { d_splice_alias(k_inode, dentry.as_ptr()).cast() }
+}
+
+/// Exported as a replacement of erofs_get_parent.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_get_parent_rust(child: NonNull<dentry>) -> *mut c_void {
+    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let k_inode = unsafe { child.as_ref().d_inode };
+    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
+    let sbi = erofs_sbi(unsafe { NonNull::new((*k_inode).i_sb).unwrap() }); // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let inode = unsafe { &*container_of!(k_inode, KernelInode, k_inode) };
+    let k_inode: *mut inode = dir_lookup(sbi.filesystem.as_ref(), &mut sbi.inodes, inode, "..")
+        .map_or(core::ptr::null_mut(), |result| result.k_inode.as_mut_ptr());
+    // SAFETY: We are sure that the inner k_inode has already been initialized
+    unsafe { d_obtain_alias(k_inode).cast() }
+}
diff --git a/fs/erofs/rust_bindings.h b/fs/erofs/rust_bindings.h
index 657f109dd6e7..b35014aa5cae 100644
--- a/fs/erofs/rust_bindings.h
+++ b/fs/erofs/rust_bindings.h
@@ -6,7 +6,6 @@
 
 #include <linux/fs.h>
 
-
 typedef u64 erofs_nid_t;
 typedef u64 erofs_off_t;
 /* data type for filesystem-wide blocks number */
@@ -21,4 +20,7 @@ extern void *erofs_alloc_sbi_rust(struct super_block *sb);
 extern void *erofs_free_sbi_rust(struct super_block *sb);
 extern int erofs_iget5_eq_rust(struct inode *inode, void *opaque);
 extern struct inode *erofs_iget_rust(struct super_block *sb, erofs_nid_t nid);
+extern struct dentry *erofs_lookup_rust(struct inode *inode, struct dentry *dentry,
+			      unsigned int flags);
+extern struct dentry *erofs_get_parent_rust(struct dentry *dentry);
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 659502bdf5fe..d49c804acf3d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -554,6 +554,7 @@ static struct dentry *erofs_fh_to_parent(struct super_block *sb,
 				    erofs_nfs_get_inode);
 }
 
+#ifndef CONFIG_EROFS_FS_RUST
 static struct dentry *erofs_get_parent(struct dentry *child)
 {
 	erofs_nid_t nid;
@@ -565,6 +566,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
 		return ERR_PTR(err);
 	return d_obtain_alias(erofs_iget(child->d_sb, nid));
 }
+#endif
 
 static const struct export_operations erofs_export_ops = {
 	.encode_fh = generic_encode_ino32_fh,
-- 
2.46.0


