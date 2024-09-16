Return-Path: <linux-fsdevel+bounces-29501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C3E97A398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD011F27ADA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF491917E0;
	Mon, 16 Sep 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="X5cUuPKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EBB18CC0A;
	Mon, 16 Sep 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495041; cv=none; b=NT+PD00yQwByg46apn6N03hSLm3yAqO62GhYe4ju1xjy9+FZM/s2xljgwRU6M+l0KfMsUve+9SxiEt5hfg+m1jPEKrOeukxZ4lglw64QulmRPpQWJm57HTLPWer2s7nFFcVZjsmWf9I0H3BmHjMBP+nkAkk4eae5uP+QTUQlsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495041; c=relaxed/simple;
	bh=P8reVC9LHn9Ss/NzZdNp07rUoCvE/rgeeNwx4HOeqnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjtF8aVBVfWzgYna1maCIRmk4VLogWMnrAb4G2EVePOxKfODM69jBiSodk4/hChV8a9mZyJ48U9WGbDB8AP/h3k9ERnMqZAq6SvL91TzX/Hp/vKDEMxNgjQ6z/ktrTyS0qOek8DW9ApTW5Z/cB1Wz9wYMgc2IAmaJehZ5+BISDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=X5cUuPKc; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 584C969839;
	Mon, 16 Sep 2024 09:57:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495039; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SF+isR41/QqrBfGfC6meT3Kg4eWEa6AIAKKhQ1hnyqE=;
	b=X5cUuPKcDAJD4qrkdbm0LQChHyRJrM+CjfZdi2pNiAo3Gu2Pbkbzoy2+ZgrhlD7ofI06mj
	blYOAEf2pYeemD0LXW0dKogk+HQaxnzrCt+pFL7ZMYsBWgy1bDVVrw+R4UTlgXG18IAIT0
	QRbBTNXXdkHc5dTL2oVYI/1RgPEYRt4oAbzo9+DfSQ4aNMPccOlygyOnfQPM5e3QAaSs8L
	5mrbOfVBY3lQiL15qkSsUCPmoNJ71ipLnZgDo/hFse/fb9t/BXtSixqvPCw+i0cMbk+pIg
	4imgAQxaMDCa/6rHNCewn5Uw3UcvIAe9dEz0QgMAI/PFjHEDSZtT4GX+V+OWTw==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 21/24] erofs: introduce erofs_map_blocks alternative to C
Date: Mon, 16 Sep 2024 21:56:31 +0800
Message-ID: <20240916135634.98554-22-toolmanp@tlmp.cc>
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

This patch introduces erofs_map_blocks alternative written in Rust,
which will be hooked inside the erofs_iomap_begin.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/Makefile        |  2 +-
 fs/erofs/data.c          |  5 ++++
 fs/erofs/data_rs.rs      | 63 ++++++++++++++++++++++++++++++++++++++++
 fs/erofs/rust_bindings.h |  4 +++
 4 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/data_rs.rs

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index e086487971b6..219ddca0642e 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,4 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
-erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o namei_rs.o dir_rs.o rust_helpers.o
+erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o namei_rs.o dir_rs.o data_rs.o rust_helpers.o
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 61debd799cf9..c9694661136b 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -293,7 +293,12 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_la = offset;
 	map.m_llen = length;
 
+#ifdef CONFIG_EROFS_FS_RUST
+	ret = erofs_map_blocks_rust(inode, &map);
+#else  
 	ret = erofs_map_blocks(inode, &map);
+#endif
+
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/erofs/data_rs.rs b/fs/erofs/data_rs.rs
new file mode 100644
index 000000000000..ac34a9dd2079
--- /dev/null
+++ b/fs/erofs/data_rs.rs
@@ -0,0 +1,63 @@
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
+use kernel::bindings::inode;
+use kernel::container_of;
+
+use rust::{erofs_sys::*, kinode::*, ksuperblock::*};
+
+#[repr(C)]
+struct ErofsBuf {
+    mapping: NonNull<c_void>,
+    page: NonNull<c_void>,
+    base: NonNull<c_void>,
+    kmap_type: c_int,
+}
+
+/// A helper sturct to map blocks for iomap_begin because iomap is not generated by bindgen
+#[repr(C)]
+pub struct ErofsMapBlocks {
+    buf: ErofsBuf,
+    pub(crate) m_pa: u64,
+    pub(crate) m_la: u64,
+    pub(crate) m_plen: u64,
+    pub(crate) m_llen: u64,
+    pub(crate) m_deviceid: u16,
+    pub(crate) m_flags: u32,
+}
+/// Exported as a replacement for erofs_map_blocks.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_map_blocks_rust(
+    k_inode: NonNull<inode>,
+    mut map: NonNull<ErofsMapBlocks>,
+) -> c_int {
+    // SAFETY: super_block and superblockinfo is always initialized in k_inode.
+    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });
+    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };
+    // SAFETY: The map is always initialized in the caller.
+    match sbi
+        .filesystem
+        .map(erofs_inode, unsafe { map.as_ref().m_la } as Off)
+    {
+        Ok(m) => unsafe {
+            map.as_mut().m_pa = m.physical.start;
+            map.as_mut().m_la = map.as_ref().m_la;
+            map.as_mut().m_plen = m.physical.len;
+            map.as_mut().m_llen = m.physical.len;
+            map.as_mut().m_deviceid = m.device_id;
+            map.as_mut().m_flags = m.map_type.into();
+            0
+        },
+        Err(e) => i32::from(e) as c_int,
+    }
+}
diff --git a/fs/erofs/rust_bindings.h b/fs/erofs/rust_bindings.h
index 8b71d65e2c0b..ad9aa75a7a2c 100644
--- a/fs/erofs/rust_bindings.h
+++ b/fs/erofs/rust_bindings.h
@@ -24,4 +24,8 @@ extern struct dentry *erofs_lookup_rust(struct inode *inode, struct dentry *dent
 			      unsigned int flags);
 extern struct dentry *erofs_get_parent_rust(struct dentry *dentry);
 extern int erofs_readdir_rust(struct file *file, struct dir_context *ctx);
+
+struct erofs_map_blocks;
+extern int erofs_map_blocks_rust(struct inode *inode,
+				 struct erofs_map_blocks *map);
 #endif
-- 
2.46.0


