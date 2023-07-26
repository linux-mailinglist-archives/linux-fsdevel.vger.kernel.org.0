Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446DD763D0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGZQ57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjGZQ54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:57:56 -0400
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08F1E42
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6458; q=dns/txt; s=iport;
  t=1690390675; x=1691600275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cIBpQFptALxQEDeNXQIlMjNYdYD99mepAG1JGqIXFp8=;
  b=SYq4YXMnDGrU7gRPKHuCkwF1z4E7FIIL0QUkDGIAqg2Pp5Q0xqdDTM+O
   J3ZJbD7aD3mOiAitwibKZFrqkJ57jutSAmFuGCPlAkxKnop4JvF3OXjwS
   VaPekMmpFKRntVfv7LdovDZ7KV0OrQwlblOrWpcVTkfDiiYKjMgw1DVTe
   E=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="8416074"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:46:24 +0000
Received: from archlinux-cisco.cisco.com (dhcp-10-61-98-211.cisco.com [10.61.98.211])
        (authenticated bits=0)
        by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36QGjqU0022602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 16:46:24 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v2 08/10] rust: puzzlefs: read the puzzlefs image manifest instead of an individual metadata layer
Date:   Wed, 26 Jul 2023 19:45:32 +0300
Message-ID: <20230726164535.230515-9-amiculas@cisco.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726164535.230515-1-amiculas@cisco.com>
References: <20230726164535.230515-1-amiculas@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas
X-Outbound-SMTP-Client: 10.61.98.211, dhcp-10-61-98-211.cisco.com
X-Outbound-Node: aer-core-7.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The puzzlefs image manifest is the file referenced by index.json and it
contains the array of metadata layers that describe the puzzlefs image.
This file represents the root of the puzzlefs filesystem since we can't
parse json files. When this filesystem is mounted, usermode will need to
read the tag from index.json, find the corresponding puzzlefs image
manifest and pass it to the kernel module.

Due to the lack of BTreeMap in the kernel, only image manifests without
fs verity information are supported for now.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 samples/rust/puzzle.rs       |  1 +
 samples/rust/puzzle/inode.rs | 22 ++++++++++++----
 samples/rust/puzzle/oci.rs   | 51 ++++++++++++++++++++++++++++++++++++
 samples/rust/puzzlefs.rs     | 23 ++++++++--------
 4 files changed, 80 insertions(+), 17 deletions(-)
 create mode 100644 samples/rust/puzzle/oci.rs

diff --git a/samples/rust/puzzle.rs b/samples/rust/puzzle.rs
index a809cddfb817..e74a248c39ff 100644
--- a/samples/rust/puzzle.rs
+++ b/samples/rust/puzzle.rs
@@ -2,3 +2,4 @@
 pub(crate) mod types;
 pub(crate) use types::{manifest_capnp, metadata_capnp};
 pub(crate) mod inode;
+pub(crate) mod oci;
diff --git a/samples/rust/puzzle/inode.rs b/samples/rust/puzzle/inode.rs
index d792f661aa00..f63cdbc1eac4 100644
--- a/samples/rust/puzzle/inode.rs
+++ b/samples/rust/puzzle/inode.rs
@@ -3,20 +3,32 @@
 
 use crate::puzzle::error::Result;
 use crate::puzzle::error::WireFormatError;
+use crate::puzzle::oci::Image;
 use crate::puzzle::types as format;
-use crate::puzzle::types::{Inode, InodeMode, MetadataBlob};
+use crate::puzzle::types::{Digest, Inode, InodeMode};
 use alloc::vec::Vec;
+use kernel::mount::Vfsmount;
 use kernel::prelude::ENOENT;
+use kernel::str::CStr;
+use kernel::sync::Arc;
 
 pub(crate) struct PuzzleFS {
+    pub(crate) oci: Image,
     layers: Vec<format::MetadataBlob>,
 }
 
 impl PuzzleFS {
-    pub(crate) fn new(md: MetadataBlob) -> Result<Self> {
-        let mut v = Vec::new();
-        v.try_push(md)?;
-        Ok(PuzzleFS { layers: v })
+    pub(crate) fn open(vfsmount: Arc<Vfsmount>, rootfs_path: &CStr) -> Result<PuzzleFS> {
+        let oci = Image::open(vfsmount)?;
+        let rootfs = oci.open_rootfs_blob(rootfs_path)?;
+
+        let mut layers = Vec::new();
+        for md in rootfs.metadatas.iter() {
+            let digest = Digest::try_from(md)?;
+            layers.try_push(oci.open_metadata_blob(&digest)?)?;
+        }
+
+        Ok(PuzzleFS { oci, layers })
     }
 
     pub(crate) fn find_inode(&self, ino: u64) -> Result<Inode> {
diff --git a/samples/rust/puzzle/oci.rs b/samples/rust/puzzle/oci.rs
new file mode 100644
index 000000000000..becb2b868450
--- /dev/null
+++ b/samples/rust/puzzle/oci.rs
@@ -0,0 +1,51 @@
+use crate::puzzle::error::Result;
+use crate::puzzle::types::{Digest, MetadataBlob, Rootfs};
+use kernel::c_str;
+use kernel::file;
+use kernel::file::RegularFile;
+use kernel::mount::Vfsmount;
+use kernel::pr_info;
+use kernel::str::{CStr, CString};
+use kernel::sync::Arc;
+
+pub(crate) struct Image {
+    vfs_mount: Arc<Vfsmount>,
+}
+
+impl Image {
+    pub(crate) fn open(vfsmount: Arc<Vfsmount>) -> Result<Self> {
+        Ok(Image {
+            vfs_mount: vfsmount,
+        })
+    }
+
+    pub(crate) fn blob_path_relative(&self) -> &CStr {
+        c_str!("blobs/sha256")
+    }
+
+    fn open_raw_blob(&self, digest: &Digest) -> Result<RegularFile> {
+        let filename =
+            CString::try_from_fmt(format_args!("{}/{digest}", self.blob_path_relative()))?;
+        pr_info!("trying to open {:?}\n", &filename);
+
+        let file = RegularFile::from_path_in_root_mnt(
+            &self.vfs_mount,
+            &filename,
+            file::flags::O_RDONLY.try_into().unwrap(),
+            0,
+        )?;
+
+        Ok(file)
+    }
+
+    pub(crate) fn open_metadata_blob(&self, digest: &Digest) -> Result<MetadataBlob> {
+        let f = self.open_raw_blob(digest)?;
+        MetadataBlob::new(f)
+    }
+
+    pub(crate) fn open_rootfs_blob(&self, path: &CStr) -> Result<Rootfs> {
+        let digest = Digest::try_from(path)?;
+        let rootfs = Rootfs::open(self.open_raw_blob(&digest)?)?;
+        Ok(rootfs)
+    }
+}
diff --git a/samples/rust/puzzlefs.rs b/samples/rust/puzzlefs.rs
index 1f0073716d91..76dc59403db3 100644
--- a/samples/rust/puzzlefs.rs
+++ b/samples/rust/puzzlefs.rs
@@ -14,7 +14,7 @@
 mod puzzle;
 // Required by the autogenerated '_capnp.rs' files
 use puzzle::inode::PuzzleFS;
-use puzzle::types::{Inode, InodeMode, MetadataBlob};
+use puzzle::types::{Inode, InodeMode};
 use puzzle::{manifest_capnp, metadata_capnp};
 
 use kernel::fs::{DEntry, INodeParams, NeedsRoot, NewSuperBlock, RootDEntry};
@@ -69,7 +69,7 @@ fn puzzlefs_populate_dir(
         return Err(E2BIG);
     }
 
-    let inode = Arc::try_new(pfs.find_inode(ino).map_err(|_| EINVAL)?)?;
+    let inode = Arc::try_new(pfs.find_inode(ino)?)?;
     match &inode.mode {
         InodeMode::File { chunks: _ } => {
             let params = INodeParams {
@@ -154,18 +154,17 @@ fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<&fs::SuperBl
             },
         )?;
 
-        let file = file::RegularFile::from_path_in_root_mnt(
-            &arc_vfs_mount,
-            c_str!("997eed138af30d187e87d682dd2ae9f240fae78f668907a0519460b397c82467"),
-            file::flags::O_RDONLY.try_into().unwrap(),
-            0,
-        )?;
+        let puzzlefs = PuzzleFS::open(
+            arc_vfs_mount,
+            c_str!("2d6602d678140540dc7e96de652a76a8b16e8aca190bae141297bcffdcae901b"),
+        );
 
-        // TODO: figure out how to go from WireFormatError to kernel::error::Error
-        let metadata = MetadataBlob::new(file).map_err(|_| EINVAL)?;
+        if let Err(ref e) = puzzlefs {
+            pr_info!("error opening puzzlefs {e}\n");
+        }
 
-        let mut puzzlefs = PuzzleFS::new(metadata).map_err(|_| EINVAL)?;
-        let root_inode = Arc::try_new(puzzlefs.find_inode(1).map_err(|_| EINVAL)?)?;
+        let mut puzzlefs = puzzlefs?;
+        let root_inode = Arc::try_new(puzzlefs.find_inode(1)?)?;
 
         let root = try_new_populated_root_puzzlefs_dentry(&sb, &mut puzzlefs, root_inode)?;
         let sb = sb.init_root(root)?;
-- 
2.41.0

