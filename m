Return-Path: <linux-fsdevel+bounces-19605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C4A8C7CD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3243D2833C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BCE15920B;
	Thu, 16 May 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ZHbCJ+XJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C0158D77;
	Thu, 16 May 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886272; cv=none; b=e+ufxdwX3I/GwA3G1hNabAlhoGE4yKSgNWKXXOEXn65/TO62O+q7K8O1Welkm+P3w5vJTYqC9xaRoX3h2oqLWYFtKtkZ0fzVe2+w8HPlG76yIYZ1SXatuRqSD0qqjilqitSsTSHhe59gyvc6V7WuS0SbwR5GMPA9Jq+vK7WnwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886272; c=relaxed/simple;
	bh=YVkKY+DVfu3Ns5YhZFxnBhlRk3J/PwOtX93n3BmC/r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNKOdhjSll4kayBYjVd+RwlxhHcTp+tERECLsTX2Pb7heCjzREbiN5SgzCh+7DqAFc9iBc7nMb61gqdHTbhdx/igjjynJ1y+BZqoIGgMPbYFkEz8S9eFXPT+6bFoXab43eRmQBPc8398qs2P4K4E12jRABlzpJzH9iOrdDmqBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ZHbCJ+XJ; arc=none smtp.client-ip=173.38.203.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3251; q=dns/txt; s=iport;
  t=1715886271; x=1717095871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+pfayBA377Ipl2qQGaCZtcT9bhjEsaDIsf91AaD2x7E=;
  b=ZHbCJ+XJHSms5kH0i4Px/dU5jPf2aFyMfpSdlDBfOX0G1R2HWtveJ3lu
   epg4ZTnecHPCu/rt7QHo6i/j98sxghOkaBU2w2nSHqvK8+eyFT16uUx8t
   i+VJ4pG/jRaLEtEKF/42xlVl3TYjFNZ+eyCwnDolqtArxV1eXARBYXW1d
   M=;
X-CSE-ConnectionGUID: IN3ktra0TnyQzrIlWsIUSA==
X-CSE-MsgGUID: MVb2X31TSLeouobFH9aTTA==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12379876"
Received: from aer-iport-nat.cisco.com (HELO aer-core-10.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:28 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-10.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4RKW101499
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:28 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 22/22] fs: puzzlefs: implement statfs for puzzlefs
Date: Thu, 16 May 2024 22:03:45 +0300
Message-Id: <20240516190345.957477-23-amiculas@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516190345.957477-1-amiculas@cisco.com>
References: <20240516190345.957477-1-amiculas@cisco.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.83.14, ams3-vpn-dhcp4879.cisco.com
X-Outbound-Node: aer-core-10.cisco.com

In order to use a filesystem as a lower filesystem in an overlay, it
must implement statfs.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 fs/puzzlefs/puzzle/inode.rs | 26 ++++++++++++++++++++++++--
 fs/puzzlefs/puzzlefs.rs     | 21 +++++++++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/fs/puzzlefs/puzzle/inode.rs b/fs/puzzlefs/puzzle/inode.rs
index 318edbdc5163..a34f1064b632 100644
--- a/fs/puzzlefs/puzzle/inode.rs
+++ b/fs/puzzlefs/puzzle/inode.rs
@@ -14,6 +14,8 @@
 pub(crate) struct PuzzleFS {
     pub(crate) oci: Image,
     layers: Vec<format::MetadataBlob>,
+    pub(crate) total_inodes: u64,
+    pub(crate) total_block_size: u64,
 }
 
 impl PuzzleFS {
@@ -22,13 +24,33 @@ pub(crate) fn open(oci_root_dir: &CStr, rootfs_path: &CStr) -> Result<PuzzleFS>
         let oci = Image::open(vfs_mount)?;
         let rootfs = oci.open_rootfs_blob(rootfs_path)?;
 
+        let mut total_block_size = 0;
+        let mut total_inodes: u64 = 0;
         let mut layers = Vec::new();
         for md in rootfs.metadatas.iter() {
             let digest = Digest::try_from(md)?;
-            layers.push(oci.open_metadata_blob(&digest)?, GFP_KERNEL)?;
+            let layer = oci.open_metadata_blob(&digest)?;
+
+            // This may take up too much time, but we need to implement statfs if we want to use
+            // puzzlefs as a lower filesystem in overlayfs
+            let inodes = layer.get_inode_vector()?;
+            total_inodes += u64::from(inodes.len());
+            for inode_number in 0..inodes.len() {
+                let inode = Inode::from_capnp(inodes.get(inode_number))?;
+                if let InodeMode::File { chunks } = inode.mode {
+                    total_block_size += chunks.iter().map(|chunk| chunk.len).sum::<u64>();
+                }
+            }
+
+            layers.push(layer, GFP_KERNEL)?;
         }
 
-        Ok(PuzzleFS { oci, layers })
+        Ok(PuzzleFS {
+            oci,
+            layers,
+            total_inodes,
+            total_block_size,
+        })
     }
 
     pub(crate) fn find_inode(&self, ino: u64) -> Result<Inode> {
diff --git a/fs/puzzlefs/puzzlefs.rs b/fs/puzzlefs/puzzlefs.rs
index 932f31917992..633f60983849 100644
--- a/fs/puzzlefs/puzzlefs.rs
+++ b/fs/puzzlefs/puzzlefs.rs
@@ -4,7 +4,7 @@
 
 use kernel::fs::{
     address_space, dentry, dentry::DEntry, file, file::DirEntryType, file::File, inode,
-    inode::INode, sb, Offset,
+    inode::INode, sb, Offset, Stat,
 };
 use kernel::prelude::*;
 use kernel::types::{ARef, Either, Locked};
@@ -23,6 +23,10 @@
     license: "GPL",
 }
 
+const PUZZLEFS_BSIZE: u64 = 1 << PUZZLEFS_BSIZE_BITS;
+const PUZZLEFS_BSIZE_BITS: u8 = 12;
+const PUZZLEFS_MAGIC: usize = 0x7a7a7570;
+
 fn mode_to_fs_type(inode: &Inode) -> Result<DirEntryType> {
     Ok(match inode.mode {
         InodeMode::File { .. } => DirEntryType::Reg,
@@ -156,7 +160,7 @@ fn fill_super(
         );
 
         let puzzlefs = puzzlefs?;
-        sb.set_magic(0x7a7a7570);
+        sb.set_magic(PUZZLEFS_MAGIC);
         Ok(Box::new(puzzlefs, GFP_KERNEL)?)
     }
 
@@ -194,6 +198,19 @@ fn read_xattr(
         }
         Err(ENODATA)
     }
+
+    fn statfs(dentry: &DEntry<Self>) -> Result<Stat> {
+        let puzzlefs = dentry.super_block().data();
+
+        Ok(Stat {
+            magic: PUZZLEFS_MAGIC,
+            namelen: isize::MAX,
+            bsize: PUZZLEFS_BSIZE as _,
+            // Round total_block_size up
+            blocks: (puzzlefs.total_block_size + PUZZLEFS_BSIZE - 1) / PUZZLEFS_BSIZE,
+            files: puzzlefs.total_inodes,
+        })
+    }
 }
 
 #[vtable]
-- 
2.34.1


