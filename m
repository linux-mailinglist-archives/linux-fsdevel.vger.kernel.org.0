Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DEB763D59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGZRLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjGZRLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:11:46 -0400
Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E161FC4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=10089; q=dns/txt;
  s=iport; t=1690391504; x=1691601104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TRWzNxjh1uYFqrfsbY1Jt0vK+xcFRJ/MMfLVEQAsNfg=;
  b=Ho0IwL7goILvth3HdWw6/zGK/r0mIKB0YgIhpTEQbSiqGL4CXrlByISt
   jEGR1nBxL1aq4ELKDB7OcQaXnF2if5s1cR+09YAZ8OyuX03q7+7JqfqKs
   0sZ1Hen48J2dq0sLNZOEUPMQWXLsC0GzZGE7vetFv79U+eijXJn6h74zY
   0=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="5874462"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:46:23 +0000
Received: from archlinux-cisco.cisco.com (dhcp-10-61-98-211.cisco.com [10.61.98.211])
        (authenticated bits=0)
        by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36QGjqTx022602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 16:46:22 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v2 07/10] samples: puzzlefs: populate the directory entries with the inodes from the puzzlefs metadata file
Date:   Wed, 26 Jul 2023 19:45:31 +0300
Message-ID: <20230726164535.230515-8-amiculas@cisco.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've used the same strategy as in try_new_populated_root_dentry from
rust/kernel/fs.rs, that is, recursively traverse the filesystem starting
from the root and create the necessary dentries. This is not ideal
because it creates all the dentries up front, but there are no rust
filesystem abstractions for implementing lookups yet.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/alloc/vec/mod.rs    |  17 +++++
 rust/kernel/fs.rs        |   4 +-
 samples/rust/puzzlefs.rs | 141 +++++++++++++++++++++++++++++----------
 3 files changed, 127 insertions(+), 35 deletions(-)

diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index e8344c77939e..b755cf0b936c 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -2499,6 +2499,15 @@ unsafe fn split_at_spare_mut_with_len(
     }
 }
 
+impl<T: Clone> Vec<T> {
+    /// Try to clone the vector using the global allocator
+    #[inline]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_clone(&self) -> Result<Self, TryReserveError> {
+        self.try_clone_in(Global)
+    }
+}
+
 impl<T: Clone, A: Allocator> Vec<T, A> {
     /// Resizes the `Vec` in-place so that `len` is equal to `new_len`.
     ///
@@ -2623,6 +2632,14 @@ pub fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveErr
         self.try_spec_extend(other.iter())
     }
 
+    /// Tries to clone the vector using the given allocator
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_clone_in(&self, allocator: A) -> Result<Self, TryReserveError> {
+        let mut new_vec = Vec::try_with_capacity_in(self.len(), allocator)?;
+        new_vec.try_extend_from_slice(&self)?;
+        Ok(new_vec)
+    }
+
     /// Copies elements from `src` range to the end of the vector.
     ///
     /// # Panics
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 10f90f78fc54..709b79fa0030 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -781,7 +781,9 @@ impl SuperParams {
 ///
 /// The superblock is a newly-created one and this is the only active pointer to it.
 pub struct NewSuperBlock<'a, T: Type + ?Sized, S = NeedsInit> {
-    sb: &'a mut SuperBlock<T>,
+    /// Pointer to the superblock; this fields is public so puzzlefs can call
+    /// try_new_dcache_dir_inode when populating the directory hierarchy
+    pub sb: &'a mut SuperBlock<T>,
 
     // This also forces `'a` to be invariant.
     _p: PhantomData<&'a mut &'a S>,
diff --git a/samples/rust/puzzlefs.rs b/samples/rust/puzzlefs.rs
index 8a64e0bd437d..1f0073716d91 100644
--- a/samples/rust/puzzlefs.rs
+++ b/samples/rust/puzzlefs.rs
@@ -6,16 +6,19 @@
 use kernel::mount::Vfsmount;
 use kernel::prelude::*;
 use kernel::{
-    c_str, file, fmt, fs,
+    c_str, file, fs,
     io_buffer::IoBufferWriter,
-    str::CString,
     sync::{Arc, ArcBorrow},
 };
 
 mod puzzle;
 // Required by the autogenerated '_capnp.rs' files
+use puzzle::inode::PuzzleFS;
+use puzzle::types::{Inode, InodeMode, MetadataBlob};
 use puzzle::{manifest_capnp, metadata_capnp};
 
+use kernel::fs::{DEntry, INodeParams, NeedsRoot, NewSuperBlock, RootDEntry};
+
 module_fs! {
     type: PuzzleFsModule,
     name: "puzzlefs",
@@ -27,7 +30,6 @@
 
 #[derive(Debug)]
 struct PuzzlefsInfo {
-    base_path: CString,
     vfs_mount: Arc<Vfsmount>,
 }
 
@@ -55,9 +57,81 @@ fn try_new() -> Result {
     }
 }
 
+fn puzzlefs_populate_dir(
+    sb: &NewSuperBlock<'_, PuzzleFsModule, NeedsRoot>,
+    pfs: &PuzzleFS,
+    parent: &DEntry<PuzzleFsModule>,
+    ino: u64,
+    name: &CStr,
+    recursion: usize,
+) -> Result {
+    if recursion == 0 {
+        return Err(E2BIG);
+    }
+
+    let inode = Arc::try_new(pfs.find_inode(ino).map_err(|_| EINVAL)?)?;
+    match &inode.mode {
+        InodeMode::File { chunks: _ } => {
+            let params = INodeParams {
+                mode: inode.permissions,
+                ino: inode.ino,
+                value: inode.clone(),
+            };
+            let creator = fs::file_creator::<_, FsFile>();
+            let inode = creator(sb, params)?;
+            sb.try_new_dentry(inode, parent, name)?;
+        }
+        InodeMode::Dir { dir_list } => {
+            let params = INodeParams {
+                mode: inode.permissions,
+                ino: inode.ino,
+                value: inode.clone(),
+            };
+
+            let new_dentry;
+            let new_parent = if name.as_bytes() != c_str!("").as_bytes() {
+                let dcache_inode = sb.sb.try_new_dcache_dir_inode(params)?;
+                new_dentry = sb.try_new_dentry(dcache_inode, parent, name)?;
+                &new_dentry
+            } else {
+                parent
+            };
+
+            for entry in &dir_list.entries {
+                let mut name = entry.name.try_clone()?;
+                // append NUL terminator
+                name.try_push(0)?;
+                let name = CStr::from_bytes_with_nul(&name)?;
+                puzzlefs_populate_dir(sb, pfs, new_parent, entry.ino, name, recursion - 1)?;
+            }
+        }
+        _ => todo!(),
+    }
+
+    Ok(())
+}
+
+/// Creates a new root dentry populated with the given entries.
+fn try_new_populated_root_puzzlefs_dentry(
+    sb: &NewSuperBlock<'_, PuzzleFsModule, NeedsRoot>,
+    pfs: &PuzzleFS,
+    root_value: <PuzzleFsModule as fs::Type>::INodeData,
+) -> Result<RootDEntry<PuzzleFsModule>> {
+    let root_inode = sb.sb.try_new_dcache_dir_inode(INodeParams {
+        mode: 0o755,
+        ino: root_value.ino,
+        value: root_value,
+    })?;
+    let root = sb.try_new_root_dentry(root_inode)?;
+    let ino = 1u64;
+    puzzlefs_populate_dir(sb, pfs, &root, ino, c_str!(""), 10)?;
+    Ok(root)
+}
+
 impl fs::Type for PuzzleFsModule {
     type Context = Self;
-    type INodeData = &'static [u8];
+    // this is Arc so it can be cloned in puzzlefs_populate_dir
+    type INodeData = Arc<Inode>;
     type Data = Box<PuzzlefsInfo>;
     const SUPER_TYPE: fs::Super = fs::Super::Independent;
     const NAME: &'static CStr = c_str!("puzzlefs");
@@ -65,41 +139,35 @@ impl fs::Type for PuzzleFsModule {
     const DCACHE_BASED: bool = true;
 
     fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<&fs::SuperBlock<Self>> {
-        let base_path = CString::try_from_fmt(fmt!("hello world"))?;
-        pr_info!("base_path {:?}\n", base_path);
         let vfs_mount = Vfsmount::new_private_mount(c_str!("/home/puzzlefs_oci"))?;
         pr_info!("vfs_mount {:?}\n", vfs_mount);
 
+        let arc_vfs_mount = Arc::try_new(vfs_mount)?;
+
         let sb = sb.init(
             Box::try_new(PuzzlefsInfo {
-                base_path,
-                vfs_mount: Arc::try_new(vfs_mount)?,
+                vfs_mount: arc_vfs_mount.clone(),
             })?,
             &fs::SuperParams {
                 magic: 0x72757374,
                 ..fs::SuperParams::DEFAULT
             },
         )?;
-        let root = sb.try_new_populated_root_dentry(
-            &[],
-            kernel::fs_entries![
-                file("test1", 0o600, "abc\n".as_bytes(), FsFile),
-                file("test2", 0o600, "def\n".as_bytes(), FsFile),
-                char("test3", 0o600, [].as_slice(), (10, 125)),
-                sock("test4", 0o755, [].as_slice()),
-                fifo("test5", 0o755, [].as_slice()),
-                block("test6", 0o755, [].as_slice(), (1, 1)),
-                dir(
-                    "dir1",
-                    0o755,
-                    [].as_slice(),
-                    [
-                        file("test1", 0o600, "abc\n".as_bytes(), FsFile),
-                        file("test2", 0o600, "def\n".as_bytes(), FsFile),
-                    ]
-                ),
-            ],
+
+        let file = file::RegularFile::from_path_in_root_mnt(
+            &arc_vfs_mount,
+            c_str!("997eed138af30d187e87d682dd2ae9f240fae78f668907a0519460b397c82467"),
+            file::flags::O_RDONLY.try_into().unwrap(),
+            0,
         )?;
+
+        // TODO: figure out how to go from WireFormatError to kernel::error::Error
+        let metadata = MetadataBlob::new(file).map_err(|_| EINVAL)?;
+
+        let mut puzzlefs = PuzzleFS::new(metadata).map_err(|_| EINVAL)?;
+        let root_inode = Arc::try_new(puzzlefs.find_inode(1).map_err(|_| EINVAL)?)?;
+
+        let root = try_new_populated_root_puzzlefs_dentry(&sb, &mut puzzlefs, root_inode)?;
         let sb = sb.init_root(root)?;
         Ok(sb)
     }
@@ -110,7 +178,7 @@ fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<&fs::SuperBl
 #[vtable]
 impl file::Operations for FsFile {
     // must be the same as INodeData
-    type OpenData = &'static [u8];
+    type OpenData = Arc<Inode>;
     type Filesystem = PuzzleFsModule;
     // this is an Arc because Data must be ForeignOwnable and the only implementors of it are Box,
     // Arc and (); we cannot pass a reference to read, so we share Vfsmount using and Arc
@@ -126,14 +194,19 @@ fn open(
 
     fn read(
         data: ArcBorrow<'_, Vfsmount>,
-        file: &file::File,
+        _file: &file::File,
         writer: &mut impl IoBufferWriter,
         offset: u64,
     ) -> Result<usize> {
-        file::read_from_slice(
-            file.inode::<PuzzleFsModule>().ok_or(EINVAL)?.fs_data(),
-            writer,
-            offset,
-        )
+        let mut buf = Vec::try_with_capacity(writer.len())?;
+        buf.try_resize(writer.len(), 0)?;
+        let file = file::RegularFile::from_path_in_root_mnt(
+            &data,
+            c_str!("data"),
+            file::flags::O_RDONLY.try_into().unwrap(),
+            0,
+        )?;
+        let nr_bytes_read = file.read_with_offset(&mut buf[..], offset)?;
+        file::read_from_slice(&buf[..nr_bytes_read], writer, 0)
     }
 }
-- 
2.41.0

