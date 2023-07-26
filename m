Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B19763CEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjGZQsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGZQry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:47:54 -0400
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCB526AC
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5818; q=dns/txt; s=iport;
  t=1690390047; x=1691599647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UiFHWKZZEisCHqVroCxAGB1BlMOgs6ZoyHjOZIT/iNs=;
  b=k4AjeOYNfCWf5n5guEk9YI65FW4wQFjMV1GPMv0G2hoNzOvPpTe8P+u5
   qhz2kNxDIetBitZAUj1Nw1SUj12cYxKyPbqfbqrn54QUd2QwroNy8sHj1
   lbzdjs5kO1G0PX6MpAaw6wK9HGRK6BLwrfsEtz+Z5wFNzq3YVCyHW/ecf
   E=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="8416073"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:46:21 +0000
Received: from archlinux-cisco.cisco.com (dhcp-10-61-98-211.cisco.com [10.61.98.211])
        (authenticated bits=0)
        by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36QGjqTw022602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 16:46:21 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v2 06/10] rust: file: pass the filesystem context to the open function
Date:   Wed, 26 Jul 2023 19:45:30 +0300
Message-ID: <20230726164535.230515-7-amiculas@cisco.com>
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows us to create a Vfsmount structure and pass it to the read
callback.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/kernel/file.rs      | 17 +++++++++++++++--
 samples/rust/puzzlefs.rs | 40 +++++++++++++++++++++++++++++++++++-----
 samples/rust/rust_fs.rs  |  3 ++-
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index a3002c416dbb..af1eb1ee9267 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -457,9 +457,15 @@ impl<A: OpenAdapter<T::OpenData>, T: Operations> OperationsVtable<A, T> {
             // `fileref` never outlives this function, so it is guaranteed to be
             // valid.
             let fileref = unsafe { File::from_ptr(file) };
+
+            // SAFETY: into_foreign was called in fs::NewSuperBlock<..., NeedsInit>::init and
+            // it is valid until from_foreign will be called in fs::Tables::free_callback
+            let fs_info =
+                unsafe { <T::Filesystem as fs::Type>::Data::borrow((*(*inode).i_sb).s_fs_info) };
+
             // SAFETY: `arg` was previously returned by `A::convert` and must
             // be a valid non-null pointer.
-            let ptr = T::open(unsafe { &*arg }, fileref)?.into_foreign();
+            let ptr = T::open(fs_info, unsafe { &*arg }, fileref)?.into_foreign();
             // SAFETY: The C contract guarantees that `private_data` is available
             // for implementers of the file operations (no other C code accesses
             // it), so we know that there are no concurrent threads/CPUs accessing
@@ -930,10 +936,17 @@ pub trait Operations {
     /// The type of the context data passed to [`Operations::open`].
     type OpenData: Sync = ();
 
+    /// Data associated with each file system instance.
+    type Filesystem: fs::Type;
+
     /// Creates a new instance of this file.
     ///
     /// Corresponds to the `open` function pointer in `struct file_operations`.
-    fn open(context: &Self::OpenData, file: &File) -> Result<Self::Data>;
+    fn open(
+        fs_info: <<Self::Filesystem as fs::Type>::Data as ForeignOwnable>::Borrowed<'_>,
+        context: &Self::OpenData,
+        file: &File,
+    ) -> Result<Self::Data>;
 
     /// Cleans up after the last reference to the file goes away.
     ///
diff --git a/samples/rust/puzzlefs.rs b/samples/rust/puzzlefs.rs
index 9afd82745b64..8a64e0bd437d 100644
--- a/samples/rust/puzzlefs.rs
+++ b/samples/rust/puzzlefs.rs
@@ -3,8 +3,14 @@
 //! Rust file system sample.
 
 use kernel::module_fs;
+use kernel::mount::Vfsmount;
 use kernel::prelude::*;
-use kernel::{c_str, file, fs, io_buffer::IoBufferWriter};
+use kernel::{
+    c_str, file, fmt, fs,
+    io_buffer::IoBufferWriter,
+    str::CString,
+    sync::{Arc, ArcBorrow},
+};
 
 mod puzzle;
 // Required by the autogenerated '_capnp.rs' files
@@ -19,6 +25,12 @@
 
 struct PuzzleFsModule;
 
+#[derive(Debug)]
+struct PuzzlefsInfo {
+    base_path: CString,
+    vfs_mount: Arc<Vfsmount>,
+}
+
 #[vtable]
 impl fs::Context<Self> for PuzzleFsModule {
     type Data = ();
@@ -46,14 +58,23 @@ fn try_new() -> Result {
 impl fs::Type for PuzzleFsModule {
     type Context = Self;
     type INodeData = &'static [u8];
+    type Data = Box<PuzzlefsInfo>;
     const SUPER_TYPE: fs::Super = fs::Super::Independent;
     const NAME: &'static CStr = c_str!("puzzlefs");
     const FLAGS: i32 = fs::flags::USERNS_MOUNT;
     const DCACHE_BASED: bool = true;
 
     fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<&fs::SuperBlock<Self>> {
+        let base_path = CString::try_from_fmt(fmt!("hello world"))?;
+        pr_info!("base_path {:?}\n", base_path);
+        let vfs_mount = Vfsmount::new_private_mount(c_str!("/home/puzzlefs_oci"))?;
+        pr_info!("vfs_mount {:?}\n", vfs_mount);
+
         let sb = sb.init(
-            (),
+            Box::try_new(PuzzlefsInfo {
+                base_path,
+                vfs_mount: Arc::try_new(vfs_mount)?,
+            })?,
             &fs::SuperParams {
                 magic: 0x72757374,
                 ..fs::SuperParams::DEFAULT
@@ -88,14 +109,23 @@ fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<&fs::SuperBl
 
 #[vtable]
 impl file::Operations for FsFile {
+    // must be the same as INodeData
     type OpenData = &'static [u8];
+    type Filesystem = PuzzleFsModule;
+    // this is an Arc because Data must be ForeignOwnable and the only implementors of it are Box,
+    // Arc and (); we cannot pass a reference to read, so we share Vfsmount using and Arc
+    type Data = Arc<Vfsmount>;
 
-    fn open(_context: &Self::OpenData, _file: &file::File) -> Result<Self::Data> {
-        Ok(())
+    fn open(
+        fs_info: &PuzzlefsInfo,
+        _context: &Self::OpenData,
+        _file: &file::File,
+    ) -> Result<Self::Data> {
+        Ok(fs_info.vfs_mount.clone())
     }
 
     fn read(
-        _data: (),
+        data: ArcBorrow<'_, Vfsmount>,
         file: &file::File,
         writer: &mut impl IoBufferWriter,
         offset: u64,
diff --git a/samples/rust/rust_fs.rs b/samples/rust/rust_fs.rs
index 7527681ee024..c58ed1560e06 100644
--- a/samples/rust/rust_fs.rs
+++ b/samples/rust/rust_fs.rs
@@ -85,8 +85,9 @@ fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<&fs::SuperBl
 #[vtable]
 impl file::Operations for FsFile {
     type OpenData = &'static [u8];
+    type Filesystem = RustFs;
 
-    fn open(_context: &Self::OpenData, _file: &file::File) -> Result<Self::Data> {
+    fn open(_fs_info: (), _context: &Self::OpenData, _file: &file::File) -> Result<Self::Data> {
         Ok(())
     }
 
-- 
2.41.0

