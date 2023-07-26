Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FD8763CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGZQsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjGZQry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:47:54 -0400
Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7028A26BC
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=238319; q=dns/txt;
  s=iport; t=1690390040; x=1691599640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pFuOAESAfN43fwj6WZNfdzqL/BfA1Hwzuk0CPiGbHU4=;
  b=epSiQN1fwYwJEKAmjky1sQWsICDVkSsWzI16G2A8+NqtRCF1HjhNMLa3
   bt+t+sArRca8n0EBpTGCHkmToSNYeS2cpEB/b4Fx3bHeag8EhG9ziwjGc
   D+fNJ4oKC3lPQzoa8bJdXVLfJjJB43eR03bBstt9qagnBz4Ry6qAMRl+4
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="5874461"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:46:16 +0000
Received: from archlinux-cisco.cisco.com (dhcp-10-61-98-211.cisco.com [10.61.98.211])
        (authenticated bits=0)
        by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36QGjqTv022602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 16:46:15 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v2 05/10] samples: puzzlefs: add basic deserializing support for the puzzlefs metadata
Date:   Wed, 26 Jul 2023 19:45:29 +0300
Message-ID: <20230726164535.230515-6-amiculas@cisco.com>
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Puzzlefs uses capnproto for storing the filesystem metadata, defined in
manifest.capnp and metadata.capnp. The files manifest_capnp.rs and
metadata_capnp.rs were generated with (Cap'n Proto version 0.10.4):
```
capnp compile -orust manifest.capnp
capnp compile -orust metadata.capnp
```
, formatted with rustfmt and I have also added the following lines:
```
```
to avoid warnings.

Ideally, manifest_capnp.rs and metadata_capnp.rs should be automatically
generated at build time. However, this means the capnp binary becomes a
dependency for the build and I didn't want this. Besides, the metadata
schemas are not expected to change frequently, so it's acceptable to
manually regenerate the two rust files when this happens.

The code is adapted from the puzzlefs FUSE driver [1]. The data
structures required for the filesystem metadata are defined in types.rs.
Each structure has a `from_capnp` method used to convert between the
capnp memory layout and the native Rust structures.  This leaves room
for improvement [2].

The deserializing code also uses `NoAllocBufferSegments` which is not
yet merged in capnproto-rust upstream [3]. When a new release is
published, then we'll be able to use capnproto-rust in the kernel with
only a few patches to it.

inode.rs implements the PuzzleFS structure which contains a list of
metadata layers.

Link: https://github.com/project-machine/puzzlefs [1]
Link: https://lore.kernel.org/rust-for-linux/ZI3ZnFk2uELYFX0R@moria.home.lan/ [2]
Link: https://github.com/capnproto/capnproto-rust/pull/423 [3]

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/kernel/error.rs                        |    2 +-
 samples/rust/puzzle.rs                      |    4 +
 samples/rust/puzzle/error.rs                |  106 +
 samples/rust/puzzle/inode.rs                |   36 +
 samples/rust/puzzle/types.rs                |  340 ++
 samples/rust/puzzle/types/manifest.capnp    |   15 +
 samples/rust/puzzle/types/manifest_capnp.rs |  773 ++++
 samples/rust/puzzle/types/metadata.capnp    |   69 +
 samples/rust/puzzle/types/metadata_capnp.rs | 4458 +++++++++++++++++++
 samples/rust/puzzlefs.rs                    |    4 +
 10 files changed, 5806 insertions(+), 1 deletion(-)
 create mode 100644 samples/rust/puzzle.rs
 create mode 100644 samples/rust/puzzle/error.rs
 create mode 100644 samples/rust/puzzle/inode.rs
 create mode 100644 samples/rust/puzzle/types.rs
 create mode 100644 samples/rust/puzzle/types/manifest.capnp
 create mode 100644 samples/rust/puzzle/types/manifest_capnp.rs
 create mode 100644 samples/rust/puzzle/types/metadata.capnp
 create mode 100644 samples/rust/puzzle/types/metadata_capnp.rs

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index e061c83f806a..7d25046a61b8 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -99,7 +99,7 @@ impl Error {
     ///
     /// It is a bug to pass an out-of-range `errno`. `EINVAL` would
     /// be returned in such a case.
-    pub(crate) fn from_errno(errno: core::ffi::c_int) -> Error {
+    pub fn from_errno(errno: core::ffi::c_int) -> Error {
         if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
             // TODO: Make it a `WARN_ONCE` once available.
             crate::pr_warn!(
diff --git a/samples/rust/puzzle.rs b/samples/rust/puzzle.rs
new file mode 100644
index 000000000000..a809cddfb817
--- /dev/null
+++ b/samples/rust/puzzle.rs
@@ -0,0 +1,4 @@
+pub(crate) mod error;
+pub(crate) mod types;
+pub(crate) use types::{manifest_capnp, metadata_capnp};
+pub(crate) mod inode;
diff --git a/samples/rust/puzzle/error.rs b/samples/rust/puzzle/error.rs
new file mode 100644
index 000000000000..d0a8112776aa
--- /dev/null
+++ b/samples/rust/puzzle/error.rs
@@ -0,0 +1,106 @@
+use alloc::collections::TryReserveError;
+use core::ffi::c_int;
+use core::fmt::{self, Display};
+use kernel::prelude::EINVAL;
+
+pub(crate) enum WireFormatError {
+    InvalidSerializedData,
+    KernelError(kernel::error::Error),
+    TryReserveError(TryReserveError),
+    CapnpError(capnp::Error),
+    FromIntError(core::num::TryFromIntError),
+    FromSliceError(core::array::TryFromSliceError),
+    HexError(hex::FromHexError),
+}
+
+impl WireFormatError {
+    pub(crate) fn to_errno(&self) -> c_int {
+        match self {
+            WireFormatError::InvalidSerializedData => kernel::error::Error::to_errno(EINVAL),
+            WireFormatError::KernelError(e) => kernel::error::Error::to_errno(*e),
+            WireFormatError::TryReserveError(_) => kernel::error::Error::to_errno(EINVAL),
+            WireFormatError::CapnpError(_) => kernel::error::Error::to_errno(EINVAL),
+            WireFormatError::FromIntError(_) => kernel::error::Error::to_errno(EINVAL),
+            WireFormatError::FromSliceError(_) => kernel::error::Error::to_errno(EINVAL),
+            WireFormatError::HexError(_) => kernel::error::Error::to_errno(EINVAL),
+        }
+    }
+
+    pub(crate) fn from_errno(errno: kernel::error::Error) -> Self {
+        Self::KernelError(errno)
+    }
+}
+
+impl Display for WireFormatError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match self {
+            WireFormatError::InvalidSerializedData => f.write_str("invalid serialized data"),
+            WireFormatError::KernelError(e) => {
+                f.write_fmt(format_args!("Kernel error {}", e.to_errno()))
+            }
+            WireFormatError::TryReserveError(_) => f.write_str("TryReserveError"),
+            WireFormatError::CapnpError(_) => f.write_str("Capnp error"),
+            WireFormatError::FromIntError(_) => f.write_str("TryFromIntError"),
+            WireFormatError::FromSliceError(_) => f.write_str("TryFromSliceError"),
+            WireFormatError::HexError(_) => f.write_str("HexError"),
+        }
+    }
+}
+
+pub(crate) type Result<T> = kernel::error::Result<T, WireFormatError>;
+
+// TODO figure out how to use thiserror
+#[allow(unused_qualifications)]
+impl core::convert::From<kernel::error::Error> for WireFormatError {
+    #[allow(deprecated)]
+    fn from(source: kernel::error::Error) -> Self {
+        WireFormatError::KernelError(source)
+    }
+}
+
+#[allow(unused_qualifications)]
+impl core::convert::From<TryReserveError> for WireFormatError {
+    #[allow(deprecated)]
+    fn from(source: TryReserveError) -> Self {
+        WireFormatError::TryReserveError(source)
+    }
+}
+
+#[allow(unused_qualifications)]
+impl core::convert::From<capnp::Error> for WireFormatError {
+    #[allow(deprecated)]
+    fn from(source: capnp::Error) -> Self {
+        WireFormatError::CapnpError(source)
+    }
+}
+
+#[allow(unused_qualifications)]
+impl core::convert::From<core::array::TryFromSliceError> for WireFormatError {
+    #[allow(deprecated)]
+    fn from(source: core::array::TryFromSliceError) -> Self {
+        WireFormatError::FromSliceError(source)
+    }
+}
+
+#[allow(unused_qualifications)]
+impl core::convert::From<core::num::TryFromIntError> for WireFormatError {
+    #[allow(deprecated)]
+    fn from(source: core::num::TryFromIntError) -> Self {
+        WireFormatError::FromIntError(source)
+    }
+}
+
+impl core::convert::From<hex::FromHexError> for WireFormatError {
+    #[allow(deprecated)]
+    fn from(source: hex::FromHexError) -> Self {
+        WireFormatError::HexError(source)
+    }
+}
+
+#[allow(unused_qualifications)]
+impl core::convert::From<WireFormatError> for kernel::error::Error {
+    #[allow(deprecated)]
+    fn from(source: WireFormatError) -> Self {
+        kernel::error::Error::from_errno(source.to_errno())
+    }
+}
diff --git a/samples/rust/puzzle/inode.rs b/samples/rust/puzzle/inode.rs
new file mode 100644
index 000000000000..d792f661aa00
--- /dev/null
+++ b/samples/rust/puzzle/inode.rs
@@ -0,0 +1,36 @@
+// This contents of this file is taken from puzzlefs.rs (the userspace implementation)
+// It is named inode.rs instead puzzlefs.rs since the root of this kernel module already has that name
+
+use crate::puzzle::error::Result;
+use crate::puzzle::error::WireFormatError;
+use crate::puzzle::types as format;
+use crate::puzzle::types::{Inode, InodeMode, MetadataBlob};
+use alloc::vec::Vec;
+use kernel::prelude::ENOENT;
+
+pub(crate) struct PuzzleFS {
+    layers: Vec<format::MetadataBlob>,
+}
+
+impl PuzzleFS {
+    pub(crate) fn new(md: MetadataBlob) -> Result<Self> {
+        let mut v = Vec::new();
+        v.try_push(md)?;
+        Ok(PuzzleFS { layers: v })
+    }
+
+    pub(crate) fn find_inode(&self, ino: u64) -> Result<Inode> {
+        for layer in self.layers.iter() {
+            if let Some(inode) = layer.find_inode(ino)? {
+                let inode = Inode::from_capnp(inode)?;
+                if let InodeMode::Wht = inode.mode {
+                    // TODO: seems like this should really be an Option.
+                    return Err(WireFormatError::from_errno(ENOENT));
+                }
+                return Ok(inode);
+            }
+        }
+
+        Err(WireFormatError::from_errno(ENOENT))
+    }
+}
diff --git a/samples/rust/puzzle/types.rs b/samples/rust/puzzle/types.rs
new file mode 100644
index 000000000000..559be491bf78
--- /dev/null
+++ b/samples/rust/puzzle/types.rs
@@ -0,0 +1,340 @@
+use crate::puzzle::error::Result;
+use crate::puzzle::error::WireFormatError;
+use alloc::vec::Vec;
+use capnp::{message, serialize};
+use core::fmt;
+use hex::{encode_hex_iter, FromHexError};
+use kernel::file;
+use kernel::str::CStr;
+
+pub(crate) mod manifest_capnp;
+pub(crate) mod metadata_capnp;
+
+pub(crate) const SHA256_BLOCK_SIZE: usize = 32;
+
+#[derive(Debug)]
+pub(crate) struct Rootfs {
+    pub(crate) metadatas: Vec<BlobRef>,
+    #[allow(dead_code)]
+    pub(crate) manifest_version: u64,
+}
+
+impl Rootfs {
+    pub(crate) fn open(file: file::RegularFile) -> Result<Rootfs> {
+        let manifest_buffer = file.read_to_end()?;
+        let message_reader = serialize::read_message_from_flat_slice_no_alloc(
+            &mut &manifest_buffer[..],
+            ::capnp::message::ReaderOptions::new(),
+        )?;
+        let rootfs = message_reader.get_root::<crate::manifest_capnp::rootfs::Reader<'_>>()?;
+        Self::from_capnp(rootfs)
+    }
+
+    pub(crate) fn from_capnp(reader: crate::manifest_capnp::rootfs::Reader<'_>) -> Result<Self> {
+        let metadatas = reader.get_metadatas()?;
+
+        let mut metadata_vec = Vec::new();
+        for blobref in metadatas.iter() {
+            metadata_vec.try_push(BlobRef::from_capnp(blobref)?)?;
+        }
+
+        Ok(Rootfs {
+            metadatas: metadata_vec,
+            manifest_version: reader.get_manifest_version(),
+        })
+    }
+}
+
+// TODO: should this be an ociv1 digest and include size and media type?
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub(crate) struct BlobRef {
+    pub(crate) digest: [u8; SHA256_BLOCK_SIZE],
+    pub(crate) offset: u64,
+    pub(crate) compressed: bool,
+}
+
+impl BlobRef {
+    pub(crate) fn from_capnp(reader: metadata_capnp::blob_ref::Reader<'_>) -> Result<Self> {
+        let digest = reader.get_digest()?;
+        Ok(BlobRef {
+            digest: digest.try_into()?,
+            offset: reader.get_offset(),
+            compressed: reader.get_compressed(),
+        })
+    }
+}
+
+#[derive(Debug, PartialEq, Eq)]
+pub(crate) struct DirEnt {
+    pub(crate) ino: Ino,
+    pub(crate) name: Vec<u8>,
+}
+
+#[derive(Debug, PartialEq, Eq)]
+pub(crate) struct DirList {
+    // TODO: flags instead?
+    pub(crate) look_below: bool,
+    pub(crate) entries: Vec<DirEnt>,
+}
+
+#[derive(Debug, PartialEq, Eq)]
+pub(crate) struct FileChunk {
+    pub(crate) blob: BlobRef,
+    pub(crate) len: u64,
+}
+
+pub(crate) type Ino = u64;
+
+impl FileChunk {
+    pub(crate) fn from_capnp(reader: metadata_capnp::file_chunk::Reader<'_>) -> Result<Self> {
+        let len = reader.get_len();
+        let blob = BlobRef::from_capnp(reader.get_blob()?)?;
+
+        Ok(FileChunk { blob, len })
+    }
+}
+
+#[derive(Debug, PartialEq, Eq)]
+pub(crate) struct Inode {
+    pub(crate) ino: Ino,
+    pub(crate) mode: InodeMode,
+    pub(crate) uid: u32,
+    pub(crate) gid: u32,
+    pub(crate) permissions: u16,
+    pub(crate) additional: Option<InodeAdditional>,
+}
+
+impl Inode {
+    pub(crate) fn from_capnp(reader: metadata_capnp::inode::Reader<'_>) -> Result<Self> {
+        Ok(Inode {
+            ino: reader.get_ino(),
+            mode: InodeMode::from_capnp(reader.get_mode())?,
+            uid: reader.get_uid(),
+            gid: reader.get_gid(),
+            permissions: reader.get_permissions(),
+            additional: InodeAdditional::from_capnp(reader.get_additional()?)?,
+        })
+    }
+}
+
+#[derive(Debug, PartialEq, Eq)]
+pub(crate) enum InodeMode {
+    Unknown,
+    Fifo,
+    Chr { major: u64, minor: u64 },
+    Dir { dir_list: DirList },
+    Blk { major: u64, minor: u64 },
+    File { chunks: Vec<FileChunk> },
+    Lnk,
+    Sock,
+    Wht,
+}
+
+impl InodeMode {
+    fn from_capnp(reader: metadata_capnp::inode::mode::Reader<'_>) -> Result<Self> {
+        match reader.which() {
+            Ok(metadata_capnp::inode::mode::Unknown(())) => Ok(InodeMode::Unknown),
+            Ok(metadata_capnp::inode::mode::Fifo(())) => Ok(InodeMode::Fifo),
+            Ok(metadata_capnp::inode::mode::Lnk(())) => Ok(InodeMode::Lnk),
+            Ok(metadata_capnp::inode::mode::Sock(())) => Ok(InodeMode::Sock),
+            Ok(metadata_capnp::inode::mode::Wht(())) => Ok(InodeMode::Wht),
+            Ok(metadata_capnp::inode::mode::Chr(reader)) => {
+                let r = reader?;
+                Ok(InodeMode::Chr {
+                    major: r.get_major(),
+                    minor: r.get_minor(),
+                })
+            }
+            Ok(metadata_capnp::inode::mode::Blk(reader)) => {
+                let r = reader?;
+                Ok(InodeMode::Blk {
+                    major: r.get_major(),
+                    minor: r.get_minor(),
+                })
+            }
+            Ok(metadata_capnp::inode::mode::File(reader)) => {
+                let r = reader?;
+                let mut chunks = Vec::new();
+                for chunk in r.get_chunks()?.iter() {
+                    chunks.try_push(FileChunk::from_capnp(chunk)?)?;
+                }
+
+                Ok(InodeMode::File { chunks })
+            }
+            Ok(metadata_capnp::inode::mode::Dir(reader)) => {
+                let r = reader?;
+                let mut entries = Vec::new();
+                for entry in r.get_entries()?.iter() {
+                    let ino = entry.get_ino();
+                    let dir_entry = Vec::from_iter_fallible(entry.get_name()?.iter().cloned())?;
+                    entries.try_push(DirEnt {
+                        ino,
+                        name: dir_entry,
+                    })?;
+                }
+                let look_below = r.get_look_below();
+                Ok(InodeMode::Dir {
+                    dir_list: DirList {
+                        look_below,
+                        entries,
+                    },
+                })
+            }
+            Err(::capnp::NotInSchema(_e)) => Err(WireFormatError::InvalidSerializedData),
+        }
+    }
+}
+
+#[derive(Debug, PartialEq, Eq)]
+pub(crate) struct InodeAdditional {
+    pub(crate) xattrs: Vec<Xattr>,
+    pub(crate) symlink_target: Option<Vec<u8>>,
+}
+
+impl InodeAdditional {
+    pub(crate) fn from_capnp(
+        reader: metadata_capnp::inode_additional::Reader<'_>,
+    ) -> Result<Option<Self>> {
+        if !(reader.has_xattrs() || reader.has_symlink_target()) {
+            return Ok(None);
+        }
+
+        let mut xattrs = Vec::new();
+        if reader.has_xattrs() {
+            for capnp_xattr in reader.get_xattrs()? {
+                let xattr = Xattr::from_capnp(capnp_xattr)?;
+                xattrs.try_push(xattr)?;
+            }
+        }
+
+        let symlink_target = if reader.has_symlink_target() {
+            Some(Vec::from_iter_fallible(
+                reader.get_symlink_target()?.iter().cloned(),
+            )?)
+        } else {
+            None
+        };
+
+        Ok(Some(InodeAdditional {
+            xattrs,
+            symlink_target,
+        }))
+    }
+}
+
+#[derive(Debug, PartialEq, Eq)]
+pub(crate) struct Xattr {
+    pub(crate) key: Vec<u8>,
+    pub(crate) val: Vec<u8>,
+}
+
+impl Xattr {
+    pub(crate) fn from_capnp(reader: metadata_capnp::xattr::Reader<'_>) -> Result<Self> {
+        let key = Vec::from_iter_fallible(reader.get_key()?.iter().cloned())?;
+        let val = Vec::from_iter_fallible(reader.get_val()?.iter().cloned())?;
+        Ok(Xattr { key, val })
+    }
+}
+
+pub(crate) struct MetadataBlob {
+    reader: message::TypedReader<
+        ::capnp::serialize::NoAllocBufferSegments<Vec<u8>>,
+        metadata_capnp::inode_vector::Owned,
+    >,
+}
+
+impl MetadataBlob {
+    pub(crate) fn new(f: file::RegularFile) -> Result<MetadataBlob> {
+        // We know the loaded message is safe, so we're allowing unlimited reads.
+        let unlimited_reads = message::ReaderOptions {
+            traversal_limit_in_words: None,
+            nesting_limit: 64,
+        };
+        let metadata_buffer = f.read_to_end()?;
+        let segments =
+            ::capnp::serialize::NoAllocBufferSegments::try_new(metadata_buffer, unlimited_reads)?;
+        let reader = message::Reader::new(segments, unlimited_reads).into_typed();
+
+        Ok(MetadataBlob { reader })
+    }
+
+    pub(crate) fn get_inode_vector(
+        &self,
+    ) -> ::capnp::Result<::capnp::struct_list::Reader<'_, metadata_capnp::inode::Owned>> {
+        self.reader.get()?.get_inodes()
+    }
+
+    pub(crate) fn find_inode(&self, ino: Ino) -> Result<Option<metadata_capnp::inode::Reader<'_>>> {
+        let mut left = 0;
+        let inodes = self.get_inode_vector()?;
+        let mut right = inodes.len() - 1;
+
+        while left <= right {
+            let mid = left + (right - left) / 2;
+            let i = inodes.get(mid);
+
+            if i.get_ino() == ino {
+                return Ok(Some(i));
+            }
+
+            if i.get_ino() < ino {
+                left = mid + 1;
+            } else {
+                // don't underflow...
+                if mid == 0 {
+                    break;
+                }
+                right = mid - 1;
+            };
+        }
+
+        Ok(None)
+    }
+}
+
+#[derive(Debug, Clone, PartialEq, Eq)]
+pub(crate) struct Digest([u8; SHA256_BLOCK_SIZE]);
+
+impl Digest {
+    pub(crate) fn underlying(&self) -> [u8; SHA256_BLOCK_SIZE] {
+        let mut dest = [0_u8; SHA256_BLOCK_SIZE];
+        dest.copy_from_slice(&self.0);
+        dest
+    }
+}
+
+impl fmt::Display for Digest {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let mut hex_string =
+            Vec::from_iter_fallible(encode_hex_iter(&self.underlying())).map_err(|_| fmt::Error)?;
+        // append NUL character
+        hex_string.try_push(0).map_err(|_| fmt::Error)?;
+        let hex_string = CStr::from_bytes_with_nul(&hex_string).map_err(|_| fmt::Error)?;
+        write!(f, "{}", hex_string)
+    }
+}
+
+impl TryFrom<&CStr> for Digest {
+    type Error = FromHexError;
+    fn try_from(s: &CStr) -> kernel::error::Result<Self, Self::Error> {
+        let digest = hex::decode(s)?;
+        let digest: [u8; SHA256_BLOCK_SIZE] = digest
+            .try_into()
+            .map_err(|_| FromHexError::InvalidStringLength)?;
+        Ok(Digest(digest))
+    }
+}
+
+impl TryFrom<BlobRef> for Digest {
+    type Error = WireFormatError;
+    fn try_from(v: BlobRef) -> kernel::error::Result<Self, Self::Error> {
+        Ok(Digest(v.digest))
+    }
+}
+
+impl TryFrom<&BlobRef> for Digest {
+    type Error = WireFormatError;
+    fn try_from(v: &BlobRef) -> kernel::error::Result<Self, Self::Error> {
+        Ok(Digest(v.digest))
+    }
+}
diff --git a/samples/rust/puzzle/types/manifest.capnp b/samples/rust/puzzle/types/manifest.capnp
new file mode 100644
index 000000000000..24d8a6f1fe19
--- /dev/null
+++ b/samples/rust/puzzle/types/manifest.capnp
@@ -0,0 +1,15 @@
+@0xe0b6d460b1f22bb5;
+
+using Metadata = import "metadata.capnp";
+
+struct VerityData {
+        digest@0: Data;
+        verity@1: Data;
+}
+
+struct Rootfs {
+        metadatas@0: List(Metadata.BlobRef);
+        fsVerityData@1: List(VerityData);
+        manifestVersion@2: UInt64;
+}
+
diff --git a/samples/rust/puzzle/types/manifest_capnp.rs b/samples/rust/puzzle/types/manifest_capnp.rs
new file mode 100644
index 000000000000..9ea37abfadae
--- /dev/null
+++ b/samples/rust/puzzle/types/manifest_capnp.rs
@@ -0,0 +1,773 @@
+// @generated by the capnpc-rust plugin to the Cap'n Proto schema compiler.
+// DO NOT EDIT.
+// source: manifest.capnp
+#![allow(unreachable_pub)]
+#![allow(dead_code)]
+pub mod verity_data {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_digest(self) -> ::capnp::Result<::capnp::data::Reader<'a>> {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_digest(&self) -> bool {
+            !self.reader.get_pointer_field(0).is_null()
+        }
+        #[inline]
+        pub fn get_verity(self) -> ::capnp::Result<::capnp::data::Reader<'a>> {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(1),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_verity(&self) -> bool {
+            !self.reader.get_pointer_field(1).is_null()
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 0,
+                pointers: 2,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_digest(self) -> ::capnp::Result<::capnp::data::Builder<'a>> {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_digest(&mut self, value: ::capnp::data::Reader<'_>) {
+            self.builder.reborrow().get_pointer_field(0).set_data(value);
+        }
+        #[inline]
+        pub fn init_digest(self, size: u32) -> ::capnp::data::Builder<'a> {
+            self.builder.get_pointer_field(0).init_data(size)
+        }
+        #[inline]
+        pub fn has_digest(&self) -> bool {
+            !self.builder.is_pointer_field_null(0)
+        }
+        #[inline]
+        pub fn get_verity(self) -> ::capnp::Result<::capnp::data::Builder<'a>> {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(1),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_verity(&mut self, value: ::capnp::data::Reader<'_>) {
+            self.builder.reborrow().get_pointer_field(1).set_data(value);
+        }
+        #[inline]
+        pub fn init_verity(self, size: u32) -> ::capnp::data::Builder<'a> {
+            self.builder.get_pointer_field(1).init_data(size)
+        }
+        #[inline]
+        pub fn has_verity(&self) -> bool {
+            !self.builder.is_pointer_field_null(1)
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 48] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(255, 223, 52, 143, 102, 148, 140, 205),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(181, 43, 242, 177, 96, 212, 182, 224),
+            ::capnp::word(2, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 210, 0, 0, 0),
+            ::capnp::word(33, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 119, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 97, 110, 105, 102, 101, 115, 116),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 86),
+            ::capnp::word(101, 114, 105, 116, 121, 68, 97, 116),
+            ::capnp::word(97, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(8, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(41, 0, 0, 0, 58, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(36, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(48, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(45, 0, 0, 0, 58, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(40, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(52, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(100, 105, 103, 101, 115, 116, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(118, 101, 114, 105, 116, 121, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+                0 => <::capnp::data::Owned as ::capnp::introspect::Introspect>::introspect(),
+                1 => <::capnp::data::Owned as ::capnp::introspect::Introspect>::introspect(),
+                _ => panic!("invalid field index {}", index),
+            }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0xcd8c_9466_8f34_dfff;
+    }
+}
+
+pub mod rootfs {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_metadatas(
+            self,
+        ) -> ::capnp::Result<::capnp::struct_list::Reader<'a, crate::metadata_capnp::blob_ref::Owned>>
+        {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_metadatas(&self) -> bool {
+            !self.reader.get_pointer_field(0).is_null()
+        }
+        #[inline]
+        pub fn get_fs_verity_data(
+            self,
+        ) -> ::capnp::Result<
+            ::capnp::struct_list::Reader<'a, crate::manifest_capnp::verity_data::Owned>,
+        > {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(1),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_fs_verity_data(&self) -> bool {
+            !self.reader.get_pointer_field(1).is_null()
+        }
+        #[inline]
+        pub fn get_manifest_version(self) -> u64 {
+            self.reader.get_data_field::<u64>(0)
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 1,
+                pointers: 2,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_metadatas(
+            self,
+        ) -> ::capnp::Result<
+            ::capnp::struct_list::Builder<'a, crate::metadata_capnp::blob_ref::Owned>,
+        > {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_metadatas(
+            &mut self,
+            value: ::capnp::struct_list::Reader<'a, crate::metadata_capnp::blob_ref::Owned>,
+        ) -> ::capnp::Result<()> {
+            ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                self.builder.reborrow().get_pointer_field(0),
+                value,
+                false,
+            )
+        }
+        #[inline]
+        pub fn init_metadatas(
+            self,
+            size: u32,
+        ) -> ::capnp::struct_list::Builder<'a, crate::metadata_capnp::blob_ref::Owned> {
+            ::capnp::traits::FromPointerBuilder::init_pointer(
+                self.builder.get_pointer_field(0),
+                size,
+            )
+        }
+        #[inline]
+        pub fn has_metadatas(&self) -> bool {
+            !self.builder.is_pointer_field_null(0)
+        }
+        #[inline]
+        pub fn get_fs_verity_data(
+            self,
+        ) -> ::capnp::Result<
+            ::capnp::struct_list::Builder<'a, crate::manifest_capnp::verity_data::Owned>,
+        > {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(1),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_fs_verity_data(
+            &mut self,
+            value: ::capnp::struct_list::Reader<'a, crate::manifest_capnp::verity_data::Owned>,
+        ) -> ::capnp::Result<()> {
+            ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                self.builder.reborrow().get_pointer_field(1),
+                value,
+                false,
+            )
+        }
+        #[inline]
+        pub fn init_fs_verity_data(
+            self,
+            size: u32,
+        ) -> ::capnp::struct_list::Builder<'a, crate::manifest_capnp::verity_data::Owned> {
+            ::capnp::traits::FromPointerBuilder::init_pointer(
+                self.builder.get_pointer_field(1),
+                size,
+            )
+        }
+        #[inline]
+        pub fn has_fs_verity_data(&self) -> bool {
+            !self.builder.is_pointer_field_null(1)
+        }
+        #[inline]
+        pub fn get_manifest_version(self) -> u64 {
+            self.builder.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn set_manifest_version(&mut self, value: u64) {
+            self.builder.set_data_field::<u64>(0, value);
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 73] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(216, 230, 154, 208, 49, 166, 59, 237),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(181, 43, 242, 177, 96, 212, 182, 224),
+            ::capnp::word(2, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 178, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(25, 0, 0, 0, 175, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 97, 110, 105, 102, 101, 115, 116),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 82),
+            ::capnp::word(111, 111, 116, 102, 115, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(12, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(69, 0, 0, 0, 82, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(68, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(96, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(93, 0, 0, 0, 106, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(92, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(120, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(2, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 2, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(117, 0, 0, 0, 130, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(116, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(128, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(115, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(70, 64, 38, 97, 160, 43, 222, 175),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(102, 115, 86, 101, 114, 105, 116, 121),
+            ::capnp::word(68, 97, 116, 97, 0, 0, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(255, 223, 52, 143, 102, 148, 140, 205),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 97, 110, 105, 102, 101, 115, 116),
+            ::capnp::word(86, 101, 114, 115, 105, 111, 110, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+        0 => <::capnp::struct_list::Owned<crate::metadata_capnp::blob_ref::Owned> as ::capnp::introspect::Introspect>::introspect(),
+        1 => <::capnp::struct_list::Owned<crate::manifest_capnp::verity_data::Owned> as ::capnp::introspect::Introspect>::introspect(),
+        2 => <u64 as ::capnp::introspect::Introspect>::introspect(),
+        _ => panic!("invalid field index {}", index),
+      }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1, 2];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0xed3b_a631_d09a_e6d8;
+    }
+}
diff --git a/samples/rust/puzzle/types/metadata.capnp b/samples/rust/puzzle/types/metadata.capnp
new file mode 100644
index 000000000000..a37bae703c72
--- /dev/null
+++ b/samples/rust/puzzle/types/metadata.capnp
@@ -0,0 +1,69 @@
+@0x84ae5e6e88b7cbb7;
+
+struct Chr {
+    major@0: UInt64;
+    minor@1: UInt64;
+}
+
+struct DirEntry {
+    ino@0: UInt64;
+    name@1: Data;
+}
+
+struct Dir {
+    entries@0: List(DirEntry);
+    lookBelow@1: Bool;
+}
+
+struct Blk {
+    major@0: UInt64;
+    minor@1: UInt64;
+}
+
+struct FileChunk {
+    blob@0: BlobRef;
+    len@1: UInt64;
+}
+
+struct File {
+    chunks@0: List(FileChunk);
+}
+
+struct BlobRef {
+    digest@0: Data;
+    offset@1: UInt64;
+    compressed@2: Bool;
+}
+
+struct Xattr {
+    key@0: Data;
+    val@1: Data;
+}
+
+struct InodeAdditional {
+    xattrs@0: List(Xattr);
+    symlinkTarget@1: Data;
+}
+
+struct Inode {
+    ino@0: UInt64;
+    mode: union {
+          unknown@1: Void;
+          fifo@2: Void;
+          chr@3: Chr;
+          dir@4: Dir;
+          blk@5: Blk;
+          file@6: File;
+          lnk@7: Void;
+          sock@8: Void;
+          wht@9: Void;
+      }
+    uid@10: UInt32;
+    gid@11: UInt32;
+    permissions@12: UInt16;
+    additional@13: InodeAdditional;
+}
+
+struct InodeVector {
+    inodes@0: List(Inode);
+}
diff --git a/samples/rust/puzzle/types/metadata_capnp.rs b/samples/rust/puzzle/types/metadata_capnp.rs
new file mode 100644
index 000000000000..a56254cbafd8
--- /dev/null
+++ b/samples/rust/puzzle/types/metadata_capnp.rs
@@ -0,0 +1,4458 @@
+// @generated by the capnpc-rust plugin to the Cap'n Proto schema compiler.
+// DO NOT EDIT.
+// source: metadata.capnp
+#![allow(unreachable_pub)]
+#![allow(dead_code)]
+pub mod chr {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_major(self) -> u64 {
+            self.reader.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn get_minor(self) -> u64 {
+            self.reader.get_data_field::<u64>(1)
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 2,
+                pointers: 0,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_major(self) -> u64 {
+            self.builder.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn set_major(&mut self, value: u64) {
+            self.builder.set_data_field::<u64>(0, value);
+        }
+        #[inline]
+        pub fn get_minor(self) -> u64 {
+            self.builder.get_data_field::<u64>(1)
+        }
+        #[inline]
+        pub fn set_minor(&mut self, value: u64) {
+            self.builder.set_data_field::<u64>(1, value);
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 47] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(112, 90, 179, 204, 206, 228, 254, 162),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 2, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(0, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 154, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(25, 0, 0, 0, 119, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 67),
+            ::capnp::word(104, 114, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(8, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(41, 0, 0, 0, 50, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(36, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(48, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(45, 0, 0, 0, 50, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(40, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(52, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(109, 97, 106, 111, 114, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 105, 110, 111, 114, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+                0 => <u64 as ::capnp::introspect::Introspect>::introspect(),
+                1 => <u64 as ::capnp::introspect::Introspect>::introspect(),
+                _ => panic!("invalid field index {}", index),
+            }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0xa2fe_e4ce_ccb3_5a70;
+    }
+}
+
+pub mod dir_entry {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_ino(self) -> u64 {
+            self.reader.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn get_name(self) -> ::capnp::Result<::capnp::data::Reader<'a>> {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_name(&self) -> bool {
+            !self.reader.get_pointer_field(0).is_null()
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 1,
+                pointers: 1,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_ino(self) -> u64 {
+            self.builder.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn set_ino(&mut self, value: u64) {
+            self.builder.set_data_field::<u64>(0, value);
+        }
+        #[inline]
+        pub fn get_name(self) -> ::capnp::Result<::capnp::data::Builder<'a>> {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_name(&mut self, value: ::capnp::data::Reader<'_>) {
+            self.builder.reborrow().get_pointer_field(0).set_data(value);
+        }
+        #[inline]
+        pub fn init_name(self, size: u32) -> ::capnp::data::Builder<'a> {
+            self.builder.get_pointer_field(0).init_data(size)
+        }
+        #[inline]
+        pub fn has_name(&self) -> bool {
+            !self.builder.is_pointer_field_null(0)
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 47] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(229, 236, 93, 69, 176, 175, 227, 153),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(1, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 194, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(25, 0, 0, 0, 119, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 68),
+            ::capnp::word(105, 114, 69, 110, 116, 114, 121, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(8, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(41, 0, 0, 0, 34, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(36, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(48, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(45, 0, 0, 0, 42, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(40, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(52, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(105, 110, 111, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(110, 97, 109, 101, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+                0 => <u64 as ::capnp::introspect::Introspect>::introspect(),
+                1 => <::capnp::data::Owned as ::capnp::introspect::Introspect>::introspect(),
+                _ => panic!("invalid field index {}", index),
+            }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0x99e3_afb0_455d_ece5;
+    }
+}
+
+pub mod dir {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_entries(
+            self,
+        ) -> ::capnp::Result<
+            ::capnp::struct_list::Reader<'a, crate::metadata_capnp::dir_entry::Owned>,
+        > {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_entries(&self) -> bool {
+            !self.reader.get_pointer_field(0).is_null()
+        }
+        #[inline]
+        pub fn get_look_below(self) -> bool {
+            self.reader.get_bool_field(0)
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 1,
+                pointers: 1,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_entries(
+            self,
+        ) -> ::capnp::Result<
+            ::capnp::struct_list::Builder<'a, crate::metadata_capnp::dir_entry::Owned>,
+        > {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_entries(
+            &mut self,
+            value: ::capnp::struct_list::Reader<'a, crate::metadata_capnp::dir_entry::Owned>,
+        ) -> ::capnp::Result<()> {
+            ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                self.builder.reborrow().get_pointer_field(0),
+                value,
+                false,
+            )
+        }
+        #[inline]
+        pub fn init_entries(
+            self,
+            size: u32,
+        ) -> ::capnp::struct_list::Builder<'a, crate::metadata_capnp::dir_entry::Owned> {
+            ::capnp::traits::FromPointerBuilder::init_pointer(
+                self.builder.get_pointer_field(0),
+                size,
+            )
+        }
+        #[inline]
+        pub fn has_entries(&self) -> bool {
+            !self.builder.is_pointer_field_null(0)
+        }
+        #[inline]
+        pub fn get_look_below(self) -> bool {
+            self.builder.get_bool_field(0)
+        }
+        #[inline]
+        pub fn set_look_below(&mut self, value: bool) {
+            self.builder.set_bool_field(0, value);
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 52] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(4, 150, 39, 131, 249, 197, 58, 163),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(1, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 154, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(25, 0, 0, 0, 119, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 68),
+            ::capnp::word(105, 114, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(8, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(41, 0, 0, 0, 66, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(36, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(64, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(61, 0, 0, 0, 82, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(60, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(72, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(101, 110, 116, 114, 105, 101, 115, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(229, 236, 93, 69, 176, 175, 227, 153),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(108, 111, 111, 107, 66, 101, 108, 111),
+            ::capnp::word(119, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(1, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(1, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+        0 => <::capnp::struct_list::Owned<crate::metadata_capnp::dir_entry::Owned> as ::capnp::introspect::Introspect>::introspect(),
+        1 => <bool as ::capnp::introspect::Introspect>::introspect(),
+        _ => panic!("invalid field index {}", index),
+      }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0xa33a_c5f9_8327_9604;
+    }
+}
+
+pub mod blk {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_major(self) -> u64 {
+            self.reader.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn get_minor(self) -> u64 {
+            self.reader.get_data_field::<u64>(1)
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 2,
+                pointers: 0,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_major(self) -> u64 {
+            self.builder.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn set_major(&mut self, value: u64) {
+            self.builder.set_data_field::<u64>(0, value);
+        }
+        #[inline]
+        pub fn get_minor(self) -> u64 {
+            self.builder.get_data_field::<u64>(1)
+        }
+        #[inline]
+        pub fn set_minor(&mut self, value: u64) {
+            self.builder.set_data_field::<u64>(1, value);
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 47] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(105, 137, 149, 129, 43, 27, 209, 242),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 2, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(0, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 154, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(25, 0, 0, 0, 119, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 66),
+            ::capnp::word(108, 107, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(8, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(41, 0, 0, 0, 50, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(36, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(48, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(45, 0, 0, 0, 50, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(40, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(52, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(109, 97, 106, 111, 114, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 105, 110, 111, 114, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+                0 => <u64 as ::capnp::introspect::Introspect>::introspect(),
+                1 => <u64 as ::capnp::introspect::Introspect>::introspect(),
+                _ => panic!("invalid field index {}", index),
+            }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0xf2d1_1b2b_8195_8969;
+    }
+}
+
+pub mod file_chunk {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_blob(self) -> ::capnp::Result<crate::metadata_capnp::blob_ref::Reader<'a>> {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_blob(&self) -> bool {
+            !self.reader.get_pointer_field(0).is_null()
+        }
+        #[inline]
+        pub fn get_len(self) -> u64 {
+            self.reader.get_data_field::<u64>(0)
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 1,
+                pointers: 1,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_blob(self) -> ::capnp::Result<crate::metadata_capnp::blob_ref::Builder<'a>> {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_blob(
+            &mut self,
+            value: crate::metadata_capnp::blob_ref::Reader<'_>,
+        ) -> ::capnp::Result<()> {
+            ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                self.builder.reborrow().get_pointer_field(0),
+                value,
+                false,
+            )
+        }
+        #[inline]
+        pub fn init_blob(self) -> crate::metadata_capnp::blob_ref::Builder<'a> {
+            ::capnp::traits::FromPointerBuilder::init_pointer(self.builder.get_pointer_field(0), 0)
+        }
+        #[inline]
+        pub fn has_blob(&self) -> bool {
+            !self.builder.is_pointer_field_null(0)
+        }
+        #[inline]
+        pub fn get_len(self) -> u64 {
+            self.builder.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn set_len(&mut self, value: u64) {
+            self.builder.set_data_field::<u64>(0, value);
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {
+        pub fn get_blob(&self) -> crate::metadata_capnp::blob_ref::Pipeline {
+            ::capnp::capability::FromTypelessPipeline::new(self._typeless.get_pointer_field(0))
+        }
+    }
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 48] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(210, 21, 210, 230, 255, 156, 237, 140),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(1, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 202, 0, 0, 0),
+            ::capnp::word(33, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 119, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 70),
+            ::capnp::word(105, 108, 101, 67, 104, 117, 110, 107),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(8, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(41, 0, 0, 0, 42, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(36, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(48, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(45, 0, 0, 0, 34, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(40, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(52, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(98, 108, 111, 98, 0, 0, 0, 0),
+            ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(70, 64, 38, 97, 160, 43, 222, 175),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(108, 101, 110, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+        0 => <crate::metadata_capnp::blob_ref::Owned as ::capnp::introspect::Introspect>::introspect(),
+        1 => <u64 as ::capnp::introspect::Introspect>::introspect(),
+        _ => panic!("invalid field index {}", index),
+      }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0x8ced_9cff_e6d2_15d2;
+    }
+}
+
+pub mod file {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_chunks(
+            self,
+        ) -> ::capnp::Result<
+            ::capnp::struct_list::Reader<'a, crate::metadata_capnp::file_chunk::Owned>,
+        > {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_chunks(&self) -> bool {
+            !self.reader.get_pointer_field(0).is_null()
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 0,
+                pointers: 1,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_chunks(
+            self,
+        ) -> ::capnp::Result<
+            ::capnp::struct_list::Builder<'a, crate::metadata_capnp::file_chunk::Owned>,
+        > {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_chunks(
+            &mut self,
+            value: ::capnp::struct_list::Reader<'a, crate::metadata_capnp::file_chunk::Owned>,
+        ) -> ::capnp::Result<()> {
+            ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                self.builder.reborrow().get_pointer_field(0),
+                value,
+                false,
+            )
+        }
+        #[inline]
+        pub fn init_chunks(
+            self,
+            size: u32,
+        ) -> ::capnp::struct_list::Builder<'a, crate::metadata_capnp::file_chunk::Owned> {
+            ::capnp::traits::FromPointerBuilder::init_pointer(
+                self.builder.get_pointer_field(0),
+                size,
+            )
+        }
+        #[inline]
+        pub fn has_chunks(&self) -> bool {
+            !self.builder.is_pointer_field_null(0)
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 36] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(212, 62, 195, 177, 129, 127, 161, 252),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(1, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 162, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(25, 0, 0, 0, 63, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 70),
+            ::capnp::word(105, 108, 101, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(4, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 58, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(8, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(36, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(99, 104, 117, 110, 107, 115, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(210, 21, 210, 230, 255, 156, 237, 140),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+        0 => <::capnp::struct_list::Owned<crate::metadata_capnp::file_chunk::Owned> as ::capnp::introspect::Introspect>::introspect(),
+        _ => panic!("invalid field index {}", index),
+      }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0xfca1_7f81_b1c3_3ed4;
+    }
+}
+
+pub mod blob_ref {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_digest(self) -> ::capnp::Result<::capnp::data::Reader<'a>> {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_digest(&self) -> bool {
+            !self.reader.get_pointer_field(0).is_null()
+        }
+        #[inline]
+        pub fn get_offset(self) -> u64 {
+            self.reader.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn get_compressed(self) -> bool {
+            self.reader.get_bool_field(64)
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 2,
+                pointers: 1,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_digest(self) -> ::capnp::Result<::capnp::data::Builder<'a>> {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_digest(&mut self, value: ::capnp::data::Reader<'_>) {
+            self.builder.reborrow().get_pointer_field(0).set_data(value);
+        }
+        #[inline]
+        pub fn init_digest(self, size: u32) -> ::capnp::data::Builder<'a> {
+            self.builder.get_pointer_field(0).init_data(size)
+        }
+        #[inline]
+        pub fn has_digest(&self) -> bool {
+            !self.builder.is_pointer_field_null(0)
+        }
+        #[inline]
+        pub fn get_offset(self) -> u64 {
+            self.builder.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn set_offset(&mut self, value: u64) {
+            self.builder.set_data_field::<u64>(0, value);
+        }
+        #[inline]
+        pub fn get_compressed(self) -> bool {
+            self.builder.get_bool_field(64)
+        }
+        #[inline]
+        pub fn set_compressed(&mut self, value: bool) {
+            self.builder.set_bool_field(64, value);
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 63] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(70, 64, 38, 97, 160, 43, 222, 175),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 2, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(1, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 186, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(25, 0, 0, 0, 175, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 66),
+            ::capnp::word(108, 111, 98, 82, 101, 102, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(12, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(69, 0, 0, 0, 58, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(64, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(76, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(73, 0, 0, 0, 58, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(68, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(80, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(2, 0, 0, 0, 64, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 2, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(77, 0, 0, 0, 90, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(76, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(88, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(100, 105, 103, 101, 115, 116, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(111, 102, 102, 115, 101, 116, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(99, 111, 109, 112, 114, 101, 115, 115),
+            ::capnp::word(101, 100, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(1, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(1, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+                0 => <::capnp::data::Owned as ::capnp::introspect::Introspect>::introspect(),
+                1 => <u64 as ::capnp::introspect::Introspect>::introspect(),
+                2 => <bool as ::capnp::introspect::Introspect>::introspect(),
+                _ => panic!("invalid field index {}", index),
+            }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1, 2];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0xafde_2ba0_6126_4046;
+    }
+}
+
+pub mod xattr {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_key(self) -> ::capnp::Result<::capnp::data::Reader<'a>> {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_key(&self) -> bool {
+            !self.reader.get_pointer_field(0).is_null()
+        }
+        #[inline]
+        pub fn get_val(self) -> ::capnp::Result<::capnp::data::Reader<'a>> {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(1),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_val(&self) -> bool {
+            !self.reader.get_pointer_field(1).is_null()
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 0,
+                pointers: 2,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_key(self) -> ::capnp::Result<::capnp::data::Builder<'a>> {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_key(&mut self, value: ::capnp::data::Reader<'_>) {
+            self.builder.reborrow().get_pointer_field(0).set_data(value);
+        }
+        #[inline]
+        pub fn init_key(self, size: u32) -> ::capnp::data::Builder<'a> {
+            self.builder.get_pointer_field(0).init_data(size)
+        }
+        #[inline]
+        pub fn has_key(&self) -> bool {
+            !self.builder.is_pointer_field_null(0)
+        }
+        #[inline]
+        pub fn get_val(self) -> ::capnp::Result<::capnp::data::Builder<'a>> {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(1),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_val(&mut self, value: ::capnp::data::Reader<'_>) {
+            self.builder.reborrow().get_pointer_field(1).set_data(value);
+        }
+        #[inline]
+        pub fn init_val(self, size: u32) -> ::capnp::data::Builder<'a> {
+            self.builder.get_pointer_field(1).init_data(size)
+        }
+        #[inline]
+        pub fn has_val(&self) -> bool {
+            !self.builder.is_pointer_field_null(1)
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 47] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(64, 205, 159, 7, 194, 75, 43, 217),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(2, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 170, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(25, 0, 0, 0, 119, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 88),
+            ::capnp::word(97, 116, 116, 114, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(8, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(41, 0, 0, 0, 34, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(36, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(48, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(45, 0, 0, 0, 34, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(40, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(52, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(107, 101, 121, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(118, 97, 108, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+                0 => <::capnp::data::Owned as ::capnp::introspect::Introspect>::introspect(),
+                1 => <::capnp::data::Owned as ::capnp::introspect::Introspect>::introspect(),
+                _ => panic!("invalid field index {}", index),
+            }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0xd92b_4bc2_079f_cd40;
+    }
+}
+
+pub mod inode_additional {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_xattrs(
+            self,
+        ) -> ::capnp::Result<::capnp::struct_list::Reader<'a, crate::metadata_capnp::xattr::Owned>>
+        {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_xattrs(&self) -> bool {
+            !self.reader.get_pointer_field(0).is_null()
+        }
+        #[inline]
+        pub fn get_symlink_target(self) -> ::capnp::Result<::capnp::data::Reader<'a>> {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(1),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_symlink_target(&self) -> bool {
+            !self.reader.get_pointer_field(1).is_null()
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 0,
+                pointers: 2,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_xattrs(
+            self,
+        ) -> ::capnp::Result<::capnp::struct_list::Builder<'a, crate::metadata_capnp::xattr::Owned>>
+        {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_xattrs(
+            &mut self,
+            value: ::capnp::struct_list::Reader<'a, crate::metadata_capnp::xattr::Owned>,
+        ) -> ::capnp::Result<()> {
+            ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                self.builder.reborrow().get_pointer_field(0),
+                value,
+                false,
+            )
+        }
+        #[inline]
+        pub fn init_xattrs(
+            self,
+            size: u32,
+        ) -> ::capnp::struct_list::Builder<'a, crate::metadata_capnp::xattr::Owned> {
+            ::capnp::traits::FromPointerBuilder::init_pointer(
+                self.builder.get_pointer_field(0),
+                size,
+            )
+        }
+        #[inline]
+        pub fn has_xattrs(&self) -> bool {
+            !self.builder.is_pointer_field_null(0)
+        }
+        #[inline]
+        pub fn get_symlink_target(self) -> ::capnp::Result<::capnp::data::Builder<'a>> {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(1),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_symlink_target(&mut self, value: ::capnp::data::Reader<'_>) {
+            self.builder.reborrow().get_pointer_field(1).set_data(value);
+        }
+        #[inline]
+        pub fn init_symlink_target(self, size: u32) -> ::capnp::data::Builder<'a> {
+            self.builder.get_pointer_field(1).init_data(size)
+        }
+        #[inline]
+        pub fn has_symlink_target(&self) -> bool {
+            !self.builder.is_pointer_field_null(1)
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 53] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(211, 144, 125, 86, 42, 166, 175, 153),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(2, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 250, 0, 0, 0),
+            ::capnp::word(33, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 119, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 73),
+            ::capnp::word(110, 111, 100, 101, 65, 100, 100, 105),
+            ::capnp::word(116, 105, 111, 110, 97, 108, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(8, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(41, 0, 0, 0, 58, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(36, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(64, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(61, 0, 0, 0, 114, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(60, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(72, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(120, 97, 116, 116, 114, 115, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(64, 205, 159, 7, 194, 75, 43, 217),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(115, 121, 109, 108, 105, 110, 107, 84),
+            ::capnp::word(97, 114, 103, 101, 116, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+        0 => <::capnp::struct_list::Owned<crate::metadata_capnp::xattr::Owned> as ::capnp::introspect::Introspect>::introspect(),
+        1 => <::capnp::data::Owned as ::capnp::introspect::Introspect>::introspect(),
+        _ => panic!("invalid field index {}", index),
+      }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0x99af_a62a_567d_90d3;
+    }
+}
+
+pub mod inode {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_ino(self) -> u64 {
+            self.reader.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn get_mode(self) -> crate::metadata_capnp::inode::mode::Reader<'a> {
+            self.reader.into()
+        }
+        #[inline]
+        pub fn get_uid(self) -> u32 {
+            self.reader.get_data_field::<u32>(3)
+        }
+        #[inline]
+        pub fn get_gid(self) -> u32 {
+            self.reader.get_data_field::<u32>(4)
+        }
+        #[inline]
+        pub fn get_permissions(self) -> u16 {
+            self.reader.get_data_field::<u16>(5)
+        }
+        #[inline]
+        pub fn get_additional(
+            self,
+        ) -> ::capnp::Result<crate::metadata_capnp::inode_additional::Reader<'a>> {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(1),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_additional(&self) -> bool {
+            !self.reader.get_pointer_field(1).is_null()
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 3,
+                pointers: 2,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_ino(self) -> u64 {
+            self.builder.get_data_field::<u64>(0)
+        }
+        #[inline]
+        pub fn set_ino(&mut self, value: u64) {
+            self.builder.set_data_field::<u64>(0, value);
+        }
+        #[inline]
+        pub fn get_mode(self) -> crate::metadata_capnp::inode::mode::Builder<'a> {
+            self.builder.into()
+        }
+        #[inline]
+        pub fn init_mode(mut self) -> crate::metadata_capnp::inode::mode::Builder<'a> {
+            self.builder.set_data_field::<u16>(4, 0);
+            self.builder.reborrow().get_pointer_field(0).clear();
+            self.builder.into()
+        }
+        #[inline]
+        pub fn get_uid(self) -> u32 {
+            self.builder.get_data_field::<u32>(3)
+        }
+        #[inline]
+        pub fn set_uid(&mut self, value: u32) {
+            self.builder.set_data_field::<u32>(3, value);
+        }
+        #[inline]
+        pub fn get_gid(self) -> u32 {
+            self.builder.get_data_field::<u32>(4)
+        }
+        #[inline]
+        pub fn set_gid(&mut self, value: u32) {
+            self.builder.set_data_field::<u32>(4, value);
+        }
+        #[inline]
+        pub fn get_permissions(self) -> u16 {
+            self.builder.get_data_field::<u16>(5)
+        }
+        #[inline]
+        pub fn set_permissions(&mut self, value: u16) {
+            self.builder.set_data_field::<u16>(5, value);
+        }
+        #[inline]
+        pub fn get_additional(
+            self,
+        ) -> ::capnp::Result<crate::metadata_capnp::inode_additional::Builder<'a>> {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(1),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_additional(
+            &mut self,
+            value: crate::metadata_capnp::inode_additional::Reader<'_>,
+        ) -> ::capnp::Result<()> {
+            ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                self.builder.reborrow().get_pointer_field(1),
+                value,
+                false,
+            )
+        }
+        #[inline]
+        pub fn init_additional(self) -> crate::metadata_capnp::inode_additional::Builder<'a> {
+            ::capnp::traits::FromPointerBuilder::init_pointer(self.builder.get_pointer_field(1), 0)
+        }
+        #[inline]
+        pub fn has_additional(&self) -> bool {
+            !self.builder.is_pointer_field_null(1)
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {
+        pub fn get_mode(&self) -> crate::metadata_capnp::inode::mode::Pipeline {
+            ::capnp::capability::FromTypelessPipeline::new(self._typeless.noop())
+        }
+        pub fn get_additional(&self) -> crate::metadata_capnp::inode_additional::Pipeline {
+            ::capnp::capability::FromTypelessPipeline::new(self._typeless.get_pointer_field(1))
+        }
+    }
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 102] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(161, 114, 128, 2, 173, 206, 117, 185),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 3, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(2, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 170, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(25, 0, 0, 0, 87, 1, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 73),
+            ::capnp::word(110, 111, 100, 101, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(24, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(153, 0, 0, 0, 34, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(148, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(160, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(1, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(1, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(54, 46, 90, 92, 135, 239, 140, 194),
+            ::capnp::word(157, 0, 0, 0, 42, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(2, 0, 0, 0, 3, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 10, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(133, 0, 0, 0, 34, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(128, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(140, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(3, 0, 0, 0, 4, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 11, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(137, 0, 0, 0, 34, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(132, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(144, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(4, 0, 0, 0, 5, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 12, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(141, 0, 0, 0, 98, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(140, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(152, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(5, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 13, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(149, 0, 0, 0, 90, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(148, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(160, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(105, 110, 111, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(9, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 111, 100, 101, 0, 0, 0, 0),
+            ::capnp::word(117, 105, 100, 0, 0, 0, 0, 0),
+            ::capnp::word(8, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(8, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(103, 105, 100, 0, 0, 0, 0, 0),
+            ::capnp::word(8, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(8, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(112, 101, 114, 109, 105, 115, 115, 105),
+            ::capnp::word(111, 110, 115, 0, 0, 0, 0, 0),
+            ::capnp::word(7, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(7, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(97, 100, 100, 105, 116, 105, 111, 110),
+            ::capnp::word(97, 108, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(211, 144, 125, 86, 42, 166, 175, 153),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+        0 => <u64 as ::capnp::introspect::Introspect>::introspect(),
+        1 => <crate::metadata_capnp::inode::mode::Owned as ::capnp::introspect::Introspect>::introspect(),
+        2 => <u32 as ::capnp::introspect::Introspect>::introspect(),
+        3 => <u32 as ::capnp::introspect::Introspect>::introspect(),
+        4 => <u16 as ::capnp::introspect::Introspect>::introspect(),
+        5 => <crate::metadata_capnp::inode_additional::Owned as ::capnp::introspect::Introspect>::introspect(),
+        _ => panic!("invalid field index {}", index),
+      }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0, 1, 2, 3, 4, 5];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0xb975_cead_0280_72a1;
+    }
+
+    pub mod mode {
+        pub use self::Which::{Blk, Chr, Dir, Fifo, File, Lnk, Sock, Unknown, Wht};
+
+        #[derive(Copy, Clone)]
+        pub struct Owned(());
+        impl ::capnp::introspect::Introspect for Owned {
+            fn introspect() -> ::capnp::introspect::Type {
+                ::capnp::introspect::TypeVariant::Struct(
+                    ::capnp::introspect::RawBrandedStructSchema {
+                        generic: &_private::RAW_SCHEMA,
+                        field_types: _private::get_field_types,
+                        annotation_types: _private::get_annotation_types,
+                    },
+                )
+                .into()
+            }
+        }
+        impl ::capnp::traits::Owned for Owned {
+            type Reader<'a> = Reader<'a>;
+            type Builder<'a> = Builder<'a>;
+        }
+        impl ::capnp::traits::OwnedStruct for Owned {
+            type Reader<'a> = Reader<'a>;
+            type Builder<'a> = Builder<'a>;
+        }
+        #[cfg(feature = "alloc")]
+        impl ::capnp::traits::Pipelined for Owned {
+            type Pipeline = Pipeline;
+        }
+
+        pub struct Reader<'a> {
+            reader: ::capnp::private::layout::StructReader<'a>,
+        }
+        impl<'a> ::core::marker::Copy for Reader<'a> {}
+        impl<'a> ::core::clone::Clone for Reader<'a> {
+            fn clone(&self) -> Self {
+                *self
+            }
+        }
+
+        impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+            const TYPE_ID: u64 = _private::TYPE_ID;
+        }
+        impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+            fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+                Self { reader }
+            }
+        }
+
+        #[cfg(feature = "alloc")]
+        impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+            fn from(reader: Reader<'a>) -> Self {
+                Self::Struct(::capnp::dynamic_struct::Reader::new(
+                    reader.reader,
+                    ::capnp::schema::StructSchema::new(
+                        ::capnp::introspect::RawBrandedStructSchema {
+                            generic: &_private::RAW_SCHEMA,
+                            field_types: _private::get_field_types,
+                            annotation_types: _private::get_annotation_types,
+                        },
+                    ),
+                ))
+            }
+        }
+
+        #[cfg(feature = "alloc")]
+        impl<'a> ::core::fmt::Debug for Reader<'a> {
+            fn fmt(
+                &self,
+                f: &mut ::core::fmt::Formatter<'_>,
+            ) -> ::core::result::Result<(), ::core::fmt::Error> {
+                core::fmt::Debug::fmt(
+                    &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                    f,
+                )
+            }
+        }
+
+        impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+            fn get_from_pointer(
+                reader: &::capnp::private::layout::PointerReader<'a>,
+                default: ::core::option::Option<&'a [::capnp::Word]>,
+            ) -> ::capnp::Result<Self> {
+                ::core::result::Result::Ok(reader.get_struct(default)?.into())
+            }
+        }
+
+        impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+            fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+                self.reader
+            }
+        }
+
+        #[cfg(feature = "alloc")]
+        impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+            fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+                self.reader
+                    .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+            }
+        }
+
+        impl<'a> Reader<'a> {
+            pub fn reborrow(&self) -> Reader<'_> {
+                Self { ..*self }
+            }
+
+            pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+                self.reader.total_size()
+            }
+            #[inline]
+            pub fn has_chr(&self) -> bool {
+                if self.reader.get_data_field::<u16>(4) != 2 {
+                    return false;
+                }
+                !self.reader.get_pointer_field(0).is_null()
+            }
+            #[inline]
+            pub fn has_dir(&self) -> bool {
+                if self.reader.get_data_field::<u16>(4) != 3 {
+                    return false;
+                }
+                !self.reader.get_pointer_field(0).is_null()
+            }
+            #[inline]
+            pub fn has_blk(&self) -> bool {
+                if self.reader.get_data_field::<u16>(4) != 4 {
+                    return false;
+                }
+                !self.reader.get_pointer_field(0).is_null()
+            }
+            #[inline]
+            pub fn has_file(&self) -> bool {
+                if self.reader.get_data_field::<u16>(4) != 5 {
+                    return false;
+                }
+                !self.reader.get_pointer_field(0).is_null()
+            }
+            #[inline]
+            pub fn which(self) -> ::core::result::Result<WhichReader<'a>, ::capnp::NotInSchema> {
+                match self.reader.get_data_field::<u16>(4) {
+                    0 => ::core::result::Result::Ok(Unknown(())),
+                    1 => ::core::result::Result::Ok(Fifo(())),
+                    2 => ::core::result::Result::Ok(Chr(
+                        ::capnp::traits::FromPointerReader::get_from_pointer(
+                            &self.reader.get_pointer_field(0),
+                            ::core::option::Option::None,
+                        ),
+                    )),
+                    3 => ::core::result::Result::Ok(Dir(
+                        ::capnp::traits::FromPointerReader::get_from_pointer(
+                            &self.reader.get_pointer_field(0),
+                            ::core::option::Option::None,
+                        ),
+                    )),
+                    4 => ::core::result::Result::Ok(Blk(
+                        ::capnp::traits::FromPointerReader::get_from_pointer(
+                            &self.reader.get_pointer_field(0),
+                            ::core::option::Option::None,
+                        ),
+                    )),
+                    5 => ::core::result::Result::Ok(File(
+                        ::capnp::traits::FromPointerReader::get_from_pointer(
+                            &self.reader.get_pointer_field(0),
+                            ::core::option::Option::None,
+                        ),
+                    )),
+                    6 => ::core::result::Result::Ok(Lnk(())),
+                    7 => ::core::result::Result::Ok(Sock(())),
+                    8 => ::core::result::Result::Ok(Wht(())),
+                    x => ::core::result::Result::Err(::capnp::NotInSchema(x)),
+                }
+            }
+        }
+
+        pub struct Builder<'a> {
+            builder: ::capnp::private::layout::StructBuilder<'a>,
+        }
+        impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+            const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+                ::capnp::private::layout::StructSize {
+                    data: 3,
+                    pointers: 2,
+                };
+        }
+        impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+            const TYPE_ID: u64 = _private::TYPE_ID;
+        }
+        impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+            fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+                Self { builder }
+            }
+        }
+
+        #[cfg(feature = "alloc")]
+        impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+            fn from(builder: Builder<'a>) -> Self {
+                Self::Struct(::capnp::dynamic_struct::Builder::new(
+                    builder.builder,
+                    ::capnp::schema::StructSchema::new(
+                        ::capnp::introspect::RawBrandedStructSchema {
+                            generic: &_private::RAW_SCHEMA,
+                            field_types: _private::get_field_types,
+                            annotation_types: _private::get_annotation_types,
+                        },
+                    ),
+                ))
+            }
+        }
+
+        #[cfg(feature = "alloc")]
+        impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+            fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+                self.builder
+                    .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+            }
+        }
+
+        impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+            fn init_pointer(
+                builder: ::capnp::private::layout::PointerBuilder<'a>,
+                _size: u32,
+            ) -> Self {
+                builder
+                    .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                    .into()
+            }
+            fn get_from_pointer(
+                builder: ::capnp::private::layout::PointerBuilder<'a>,
+                default: ::core::option::Option<&'a [::capnp::Word]>,
+            ) -> ::capnp::Result<Self> {
+                ::core::result::Result::Ok(
+                    builder
+                        .get_struct(
+                            <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                            default,
+                        )?
+                        .into(),
+                )
+            }
+        }
+
+        impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+            fn set_pointer_builder(
+                mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+                value: Self,
+                canonicalize: bool,
+            ) -> ::capnp::Result<()> {
+                pointer.set_struct(&value.reader, canonicalize)
+            }
+        }
+
+        impl<'a> Builder<'a> {
+            pub fn into_reader(self) -> Reader<'a> {
+                self.builder.into_reader().into()
+            }
+            pub fn reborrow(&mut self) -> Builder<'_> {
+                Builder {
+                    builder: self.builder.reborrow(),
+                }
+            }
+            pub fn reborrow_as_reader(&self) -> Reader<'_> {
+                self.builder.as_reader().into()
+            }
+
+            pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+                self.builder.as_reader().total_size()
+            }
+            #[inline]
+            pub fn set_unknown(&mut self, _value: ()) {
+                self.builder.set_data_field::<u16>(4, 0);
+            }
+            #[inline]
+            pub fn set_fifo(&mut self, _value: ()) {
+                self.builder.set_data_field::<u16>(4, 1);
+            }
+            #[inline]
+            pub fn set_chr(
+                &mut self,
+                value: crate::metadata_capnp::chr::Reader<'_>,
+            ) -> ::capnp::Result<()> {
+                self.builder.set_data_field::<u16>(4, 2);
+                ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                    self.builder.reborrow().get_pointer_field(0),
+                    value,
+                    false,
+                )
+            }
+            #[inline]
+            pub fn init_chr(self) -> crate::metadata_capnp::chr::Builder<'a> {
+                self.builder.set_data_field::<u16>(4, 2);
+                ::capnp::traits::FromPointerBuilder::init_pointer(
+                    self.builder.get_pointer_field(0),
+                    0,
+                )
+            }
+            #[inline]
+            pub fn has_chr(&self) -> bool {
+                if self.builder.get_data_field::<u16>(4) != 2 {
+                    return false;
+                }
+                !self.builder.is_pointer_field_null(0)
+            }
+            #[inline]
+            pub fn set_dir(
+                &mut self,
+                value: crate::metadata_capnp::dir::Reader<'_>,
+            ) -> ::capnp::Result<()> {
+                self.builder.set_data_field::<u16>(4, 3);
+                ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                    self.builder.reborrow().get_pointer_field(0),
+                    value,
+                    false,
+                )
+            }
+            #[inline]
+            pub fn init_dir(self) -> crate::metadata_capnp::dir::Builder<'a> {
+                self.builder.set_data_field::<u16>(4, 3);
+                ::capnp::traits::FromPointerBuilder::init_pointer(
+                    self.builder.get_pointer_field(0),
+                    0,
+                )
+            }
+            #[inline]
+            pub fn has_dir(&self) -> bool {
+                if self.builder.get_data_field::<u16>(4) != 3 {
+                    return false;
+                }
+                !self.builder.is_pointer_field_null(0)
+            }
+            #[inline]
+            pub fn set_blk(
+                &mut self,
+                value: crate::metadata_capnp::blk::Reader<'_>,
+            ) -> ::capnp::Result<()> {
+                self.builder.set_data_field::<u16>(4, 4);
+                ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                    self.builder.reborrow().get_pointer_field(0),
+                    value,
+                    false,
+                )
+            }
+            #[inline]
+            pub fn init_blk(self) -> crate::metadata_capnp::blk::Builder<'a> {
+                self.builder.set_data_field::<u16>(4, 4);
+                ::capnp::traits::FromPointerBuilder::init_pointer(
+                    self.builder.get_pointer_field(0),
+                    0,
+                )
+            }
+            #[inline]
+            pub fn has_blk(&self) -> bool {
+                if self.builder.get_data_field::<u16>(4) != 4 {
+                    return false;
+                }
+                !self.builder.is_pointer_field_null(0)
+            }
+            #[inline]
+            pub fn set_file(
+                &mut self,
+                value: crate::metadata_capnp::file::Reader<'_>,
+            ) -> ::capnp::Result<()> {
+                self.builder.set_data_field::<u16>(4, 5);
+                ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                    self.builder.reborrow().get_pointer_field(0),
+                    value,
+                    false,
+                )
+            }
+            #[inline]
+            pub fn init_file(self) -> crate::metadata_capnp::file::Builder<'a> {
+                self.builder.set_data_field::<u16>(4, 5);
+                ::capnp::traits::FromPointerBuilder::init_pointer(
+                    self.builder.get_pointer_field(0),
+                    0,
+                )
+            }
+            #[inline]
+            pub fn has_file(&self) -> bool {
+                if self.builder.get_data_field::<u16>(4) != 5 {
+                    return false;
+                }
+                !self.builder.is_pointer_field_null(0)
+            }
+            #[inline]
+            pub fn set_lnk(&mut self, _value: ()) {
+                self.builder.set_data_field::<u16>(4, 6);
+            }
+            #[inline]
+            pub fn set_sock(&mut self, _value: ()) {
+                self.builder.set_data_field::<u16>(4, 7);
+            }
+            #[inline]
+            pub fn set_wht(&mut self, _value: ()) {
+                self.builder.set_data_field::<u16>(4, 8);
+            }
+            #[inline]
+            pub fn which(self) -> ::core::result::Result<WhichBuilder<'a>, ::capnp::NotInSchema> {
+                match self.builder.get_data_field::<u16>(4) {
+                    0 => ::core::result::Result::Ok(Unknown(())),
+                    1 => ::core::result::Result::Ok(Fifo(())),
+                    2 => ::core::result::Result::Ok(Chr(
+                        ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                            self.builder.get_pointer_field(0),
+                            ::core::option::Option::None,
+                        ),
+                    )),
+                    3 => ::core::result::Result::Ok(Dir(
+                        ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                            self.builder.get_pointer_field(0),
+                            ::core::option::Option::None,
+                        ),
+                    )),
+                    4 => ::core::result::Result::Ok(Blk(
+                        ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                            self.builder.get_pointer_field(0),
+                            ::core::option::Option::None,
+                        ),
+                    )),
+                    5 => ::core::result::Result::Ok(File(
+                        ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                            self.builder.get_pointer_field(0),
+                            ::core::option::Option::None,
+                        ),
+                    )),
+                    6 => ::core::result::Result::Ok(Lnk(())),
+                    7 => ::core::result::Result::Ok(Sock(())),
+                    8 => ::core::result::Result::Ok(Wht(())),
+                    x => ::core::result::Result::Err(::capnp::NotInSchema(x)),
+                }
+            }
+        }
+
+        #[cfg(feature = "alloc")]
+        pub struct Pipeline {
+            _typeless: ::capnp::any_pointer::Pipeline,
+        }
+        #[cfg(feature = "alloc")]
+        impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+            fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+                Self {
+                    _typeless: typeless,
+                }
+            }
+        }
+        #[cfg(feature = "alloc")]
+        impl Pipeline {}
+        mod _private {
+            pub static ENCODED_NODE: [::capnp::Word; 152] = [
+                ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+                ::capnp::word(54, 46, 90, 92, 135, 239, 140, 194),
+                ::capnp::word(21, 0, 0, 0, 1, 0, 3, 0),
+                ::capnp::word(161, 114, 128, 2, 173, 206, 117, 185),
+                ::capnp::word(2, 0, 7, 0, 1, 0, 9, 0),
+                ::capnp::word(4, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(21, 0, 0, 0, 210, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(25, 0, 0, 0, 255, 1, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+                ::capnp::word(46, 99, 97, 112, 110, 112, 58, 73),
+                ::capnp::word(110, 111, 100, 101, 46, 109, 111, 100),
+                ::capnp::word(101, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(36, 0, 0, 0, 3, 0, 4, 0),
+                ::capnp::word(0, 0, 255, 255, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 1, 0, 1, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(237, 0, 0, 0, 66, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(232, 0, 0, 0, 3, 0, 1, 0),
+                ::capnp::word(244, 0, 0, 0, 2, 0, 1, 0),
+                ::capnp::word(1, 0, 254, 255, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 1, 0, 2, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(241, 0, 0, 0, 42, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(236, 0, 0, 0, 3, 0, 1, 0),
+                ::capnp::word(248, 0, 0, 0, 2, 0, 1, 0),
+                ::capnp::word(2, 0, 253, 255, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 1, 0, 3, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(245, 0, 0, 0, 34, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(240, 0, 0, 0, 3, 0, 1, 0),
+                ::capnp::word(252, 0, 0, 0, 2, 0, 1, 0),
+                ::capnp::word(3, 0, 252, 255, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 1, 0, 4, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(249, 0, 0, 0, 34, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(244, 0, 0, 0, 3, 0, 1, 0),
+                ::capnp::word(0, 1, 0, 0, 2, 0, 1, 0),
+                ::capnp::word(4, 0, 251, 255, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 1, 0, 5, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(253, 0, 0, 0, 34, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(248, 0, 0, 0, 3, 0, 1, 0),
+                ::capnp::word(4, 1, 0, 0, 2, 0, 1, 0),
+                ::capnp::word(5, 0, 250, 255, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 1, 0, 6, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(1, 1, 0, 0, 42, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(252, 0, 0, 0, 3, 0, 1, 0),
+                ::capnp::word(8, 1, 0, 0, 2, 0, 1, 0),
+                ::capnp::word(6, 0, 249, 255, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 1, 0, 7, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(5, 1, 0, 0, 34, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 1, 0, 0, 3, 0, 1, 0),
+                ::capnp::word(12, 1, 0, 0, 2, 0, 1, 0),
+                ::capnp::word(7, 0, 248, 255, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 1, 0, 8, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(9, 1, 0, 0, 42, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(4, 1, 0, 0, 3, 0, 1, 0),
+                ::capnp::word(16, 1, 0, 0, 2, 0, 1, 0),
+                ::capnp::word(8, 0, 247, 255, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 1, 0, 9, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(13, 1, 0, 0, 34, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(8, 1, 0, 0, 3, 0, 1, 0),
+                ::capnp::word(20, 1, 0, 0, 2, 0, 1, 0),
+                ::capnp::word(117, 110, 107, 110, 111, 119, 110, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(102, 105, 102, 111, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(99, 104, 114, 0, 0, 0, 0, 0),
+                ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(112, 90, 179, 204, 206, 228, 254, 162),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(100, 105, 114, 0, 0, 0, 0, 0),
+                ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(4, 150, 39, 131, 249, 197, 58, 163),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(98, 108, 107, 0, 0, 0, 0, 0),
+                ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(105, 137, 149, 129, 43, 27, 209, 242),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(102, 105, 108, 101, 0, 0, 0, 0),
+                ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(212, 62, 195, 177, 129, 127, 161, 252),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(108, 110, 107, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(115, 111, 99, 107, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(119, 104, 116, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+                ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ];
+            pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+                match index {
+          0 => <() as ::capnp::introspect::Introspect>::introspect(),
+          1 => <() as ::capnp::introspect::Introspect>::introspect(),
+          2 => <crate::metadata_capnp::chr::Owned as ::capnp::introspect::Introspect>::introspect(),
+          3 => <crate::metadata_capnp::dir::Owned as ::capnp::introspect::Introspect>::introspect(),
+          4 => <crate::metadata_capnp::blk::Owned as ::capnp::introspect::Introspect>::introspect(),
+          5 => <crate::metadata_capnp::file::Owned as ::capnp::introspect::Introspect>::introspect(),
+          6 => <() as ::capnp::introspect::Introspect>::introspect(),
+          7 => <() as ::capnp::introspect::Introspect>::introspect(),
+          8 => <() as ::capnp::introspect::Introspect>::introspect(),
+          _ => panic!("invalid field index {}", index),
+        }
+            }
+            pub fn get_annotation_types(
+                child_index: Option<u16>,
+                index: u32,
+            ) -> ::capnp::introspect::Type {
+                panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+            }
+            pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+                ::capnp::introspect::RawStructSchema {
+                    encoded_node: &ENCODED_NODE,
+                    nonunion_members: NONUNION_MEMBERS,
+                    members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+                };
+            pub static NONUNION_MEMBERS: &[u16] = &[];
+            pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[0, 1, 2, 3, 4, 5, 6, 7, 8];
+            pub const TYPE_ID: u64 = 0xc28c_ef87_5c5a_2e36;
+        }
+        pub enum Which<A0, A1, A2, A3> {
+            Unknown(()),
+            Fifo(()),
+            Chr(A0),
+            Dir(A1),
+            Blk(A2),
+            File(A3),
+            Lnk(()),
+            Sock(()),
+            Wht(()),
+        }
+        pub type WhichReader<'a> = Which<
+            ::capnp::Result<crate::metadata_capnp::chr::Reader<'a>>,
+            ::capnp::Result<crate::metadata_capnp::dir::Reader<'a>>,
+            ::capnp::Result<crate::metadata_capnp::blk::Reader<'a>>,
+            ::capnp::Result<crate::metadata_capnp::file::Reader<'a>>,
+        >;
+        pub type WhichBuilder<'a> = Which<
+            ::capnp::Result<crate::metadata_capnp::chr::Builder<'a>>,
+            ::capnp::Result<crate::metadata_capnp::dir::Builder<'a>>,
+            ::capnp::Result<crate::metadata_capnp::blk::Builder<'a>>,
+            ::capnp::Result<crate::metadata_capnp::file::Builder<'a>>,
+        >;
+    }
+}
+
+pub mod inode_vector {
+    #[derive(Copy, Clone)]
+    pub struct Owned(());
+    impl ::capnp::introspect::Introspect for Owned {
+        fn introspect() -> ::capnp::introspect::Type {
+            ::capnp::introspect::TypeVariant::Struct(::capnp::introspect::RawBrandedStructSchema {
+                generic: &_private::RAW_SCHEMA,
+                field_types: _private::get_field_types,
+                annotation_types: _private::get_annotation_types,
+            })
+            .into()
+        }
+    }
+    impl ::capnp::traits::Owned for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    impl ::capnp::traits::OwnedStruct for Owned {
+        type Reader<'a> = Reader<'a>;
+        type Builder<'a> = Builder<'a>;
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::traits::Pipelined for Owned {
+        type Pipeline = Pipeline;
+    }
+
+    pub struct Reader<'a> {
+        reader: ::capnp::private::layout::StructReader<'a>,
+    }
+    impl<'a> ::core::marker::Copy for Reader<'a> {}
+    impl<'a> ::core::clone::Clone for Reader<'a> {
+        fn clone(&self) -> Self {
+            *self
+        }
+    }
+
+    impl<'a> ::capnp::traits::HasTypeId for Reader<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructReader<'a>> for Reader<'a> {
+        fn from(reader: ::capnp::private::layout::StructReader<'a>) -> Self {
+            Self { reader }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Reader<'a>> for ::capnp::dynamic_value::Reader<'a> {
+        fn from(reader: Reader<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Reader::new(
+                reader.reader,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::fmt::Debug for Reader<'a> {
+        fn fmt(
+            &self,
+            f: &mut ::core::fmt::Formatter<'_>,
+        ) -> ::core::result::Result<(), ::core::fmt::Error> {
+            core::fmt::Debug::fmt(
+                &::core::convert::Into::<::capnp::dynamic_value::Reader<'_>>::into(*self),
+                f,
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerReader<'a> for Reader<'a> {
+        fn get_from_pointer(
+            reader: &::capnp::private::layout::PointerReader<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(reader.get_struct(default)?.into())
+        }
+    }
+
+    impl<'a> ::capnp::traits::IntoInternalStructReader<'a> for Reader<'a> {
+        fn into_internal_struct_reader(self) -> ::capnp::private::layout::StructReader<'a> {
+            self.reader
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::Imbue<'a> for Reader<'a> {
+        fn imbue(&mut self, cap_table: &'a ::capnp::private::layout::CapTable) {
+            self.reader
+                .imbue(::capnp::private::layout::CapTableReader::Plain(cap_table))
+        }
+    }
+
+    impl<'a> Reader<'a> {
+        pub fn reborrow(&self) -> Reader<'_> {
+            Self { ..*self }
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.reader.total_size()
+        }
+        #[inline]
+        pub fn get_inodes(
+            self,
+        ) -> ::capnp::Result<::capnp::struct_list::Reader<'a, crate::metadata_capnp::inode::Owned>>
+        {
+            ::capnp::traits::FromPointerReader::get_from_pointer(
+                &self.reader.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn has_inodes(&self) -> bool {
+            !self.reader.get_pointer_field(0).is_null()
+        }
+    }
+
+    pub struct Builder<'a> {
+        builder: ::capnp::private::layout::StructBuilder<'a>,
+    }
+    impl<'a> ::capnp::traits::HasStructSize for Builder<'a> {
+        const STRUCT_SIZE: ::capnp::private::layout::StructSize =
+            ::capnp::private::layout::StructSize {
+                data: 0,
+                pointers: 1,
+            };
+    }
+    impl<'a> ::capnp::traits::HasTypeId for Builder<'a> {
+        const TYPE_ID: u64 = _private::TYPE_ID;
+    }
+    impl<'a> ::core::convert::From<::capnp::private::layout::StructBuilder<'a>> for Builder<'a> {
+        fn from(builder: ::capnp::private::layout::StructBuilder<'a>) -> Self {
+            Self { builder }
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::core::convert::From<Builder<'a>> for ::capnp::dynamic_value::Builder<'a> {
+        fn from(builder: Builder<'a>) -> Self {
+            Self::Struct(::capnp::dynamic_struct::Builder::new(
+                builder.builder,
+                ::capnp::schema::StructSchema::new(::capnp::introspect::RawBrandedStructSchema {
+                    generic: &_private::RAW_SCHEMA,
+                    field_types: _private::get_field_types,
+                    annotation_types: _private::get_annotation_types,
+                }),
+            ))
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    impl<'a> ::capnp::traits::ImbueMut<'a> for Builder<'a> {
+        fn imbue_mut(&mut self, cap_table: &'a mut ::capnp::private::layout::CapTable) {
+            self.builder
+                .imbue(::capnp::private::layout::CapTableBuilder::Plain(cap_table))
+        }
+    }
+
+    impl<'a> ::capnp::traits::FromPointerBuilder<'a> for Builder<'a> {
+        fn init_pointer(builder: ::capnp::private::layout::PointerBuilder<'a>, _size: u32) -> Self {
+            builder
+                .init_struct(<Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE)
+                .into()
+        }
+        fn get_from_pointer(
+            builder: ::capnp::private::layout::PointerBuilder<'a>,
+            default: ::core::option::Option<&'a [::capnp::Word]>,
+        ) -> ::capnp::Result<Self> {
+            ::core::result::Result::Ok(
+                builder
+                    .get_struct(
+                        <Self as ::capnp::traits::HasStructSize>::STRUCT_SIZE,
+                        default,
+                    )?
+                    .into(),
+            )
+        }
+    }
+
+    impl<'a> ::capnp::traits::SetPointerBuilder for Reader<'a> {
+        fn set_pointer_builder(
+            mut pointer: ::capnp::private::layout::PointerBuilder<'_>,
+            value: Self,
+            canonicalize: bool,
+        ) -> ::capnp::Result<()> {
+            pointer.set_struct(&value.reader, canonicalize)
+        }
+    }
+
+    impl<'a> Builder<'a> {
+        pub fn into_reader(self) -> Reader<'a> {
+            self.builder.into_reader().into()
+        }
+        pub fn reborrow(&mut self) -> Builder<'_> {
+            Builder {
+                builder: self.builder.reborrow(),
+            }
+        }
+        pub fn reborrow_as_reader(&self) -> Reader<'_> {
+            self.builder.as_reader().into()
+        }
+
+        pub fn total_size(&self) -> ::capnp::Result<::capnp::MessageSize> {
+            self.builder.as_reader().total_size()
+        }
+        #[inline]
+        pub fn get_inodes(
+            self,
+        ) -> ::capnp::Result<::capnp::struct_list::Builder<'a, crate::metadata_capnp::inode::Owned>>
+        {
+            ::capnp::traits::FromPointerBuilder::get_from_pointer(
+                self.builder.get_pointer_field(0),
+                ::core::option::Option::None,
+            )
+        }
+        #[inline]
+        pub fn set_inodes(
+            &mut self,
+            value: ::capnp::struct_list::Reader<'a, crate::metadata_capnp::inode::Owned>,
+        ) -> ::capnp::Result<()> {
+            ::capnp::traits::SetPointerBuilder::set_pointer_builder(
+                self.builder.reborrow().get_pointer_field(0),
+                value,
+                false,
+            )
+        }
+        #[inline]
+        pub fn init_inodes(
+            self,
+            size: u32,
+        ) -> ::capnp::struct_list::Builder<'a, crate::metadata_capnp::inode::Owned> {
+            ::capnp::traits::FromPointerBuilder::init_pointer(
+                self.builder.get_pointer_field(0),
+                size,
+            )
+        }
+        #[inline]
+        pub fn has_inodes(&self) -> bool {
+            !self.builder.is_pointer_field_null(0)
+        }
+    }
+
+    #[cfg(feature = "alloc")]
+    pub struct Pipeline {
+        _typeless: ::capnp::any_pointer::Pipeline,
+    }
+    #[cfg(feature = "alloc")]
+    impl ::capnp::capability::FromTypelessPipeline for Pipeline {
+        fn new(typeless: ::capnp::any_pointer::Pipeline) -> Self {
+            Self {
+                _typeless: typeless,
+            }
+        }
+    }
+    #[cfg(feature = "alloc")]
+    impl Pipeline {}
+    mod _private {
+        pub static ENCODED_NODE: [::capnp::Word; 37] = [
+            ::capnp::word(0, 0, 0, 0, 5, 0, 6, 0),
+            ::capnp::word(35, 20, 59, 240, 58, 227, 99, 162),
+            ::capnp::word(15, 0, 0, 0, 1, 0, 0, 0),
+            ::capnp::word(183, 203, 183, 136, 110, 94, 174, 132),
+            ::capnp::word(1, 0, 7, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(21, 0, 0, 0, 218, 0, 0, 0),
+            ::capnp::word(33, 0, 0, 0, 7, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(29, 0, 0, 0, 63, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(109, 101, 116, 97, 100, 97, 116, 97),
+            ::capnp::word(46, 99, 97, 112, 110, 112, 58, 73),
+            ::capnp::word(110, 111, 100, 101, 86, 101, 99, 116),
+            ::capnp::word(111, 114, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 1, 0, 1, 0),
+            ::capnp::word(4, 0, 0, 0, 3, 0, 4, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 1, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(13, 0, 0, 0, 58, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(8, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(36, 0, 0, 0, 2, 0, 1, 0),
+            ::capnp::word(105, 110, 111, 100, 101, 115, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 3, 0, 1, 0),
+            ::capnp::word(16, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(161, 114, 128, 2, 173, 206, 117, 185),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(14, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+            ::capnp::word(0, 0, 0, 0, 0, 0, 0, 0),
+        ];
+        pub fn get_field_types(index: u16) -> ::capnp::introspect::Type {
+            match index {
+        0 => <::capnp::struct_list::Owned<crate::metadata_capnp::inode::Owned> as ::capnp::introspect::Introspect>::introspect(),
+        _ => panic!("invalid field index {}", index),
+      }
+        }
+        pub fn get_annotation_types(
+            child_index: Option<u16>,
+            index: u32,
+        ) -> ::capnp::introspect::Type {
+            panic!("invalid annotation indices ({:?}, {}) ", child_index, index)
+        }
+        pub static RAW_SCHEMA: ::capnp::introspect::RawStructSchema =
+            ::capnp::introspect::RawStructSchema {
+                encoded_node: &ENCODED_NODE,
+                nonunion_members: NONUNION_MEMBERS,
+                members_by_discriminant: MEMBERS_BY_DISCRIMINANT,
+            };
+        pub static NONUNION_MEMBERS: &[u16] = &[0];
+        pub static MEMBERS_BY_DISCRIMINANT: &[u16] = &[];
+        pub const TYPE_ID: u64 = 0xa263_e33a_f03b_1423;
+    }
+}
diff --git a/samples/rust/puzzlefs.rs b/samples/rust/puzzlefs.rs
index 0cf42762e81a..9afd82745b64 100644
--- a/samples/rust/puzzlefs.rs
+++ b/samples/rust/puzzlefs.rs
@@ -6,6 +6,10 @@
 use kernel::prelude::*;
 use kernel::{c_str, file, fs, io_buffer::IoBufferWriter};
 
+mod puzzle;
+// Required by the autogenerated '_capnp.rs' files
+use puzzle::{manifest_capnp, metadata_capnp};
+
 module_fs! {
     type: PuzzleFsModule,
     name: "puzzlefs",
-- 
2.41.0

