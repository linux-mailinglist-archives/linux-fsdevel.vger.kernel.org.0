Return-Path: <linux-fsdevel+bounces-29485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E82497A372
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03141F248CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A7515B118;
	Mon, 16 Sep 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="h2GVWAST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350215AD96;
	Mon, 16 Sep 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495011; cv=none; b=oBKRJPFMkCd9djlkKKx/g5hQ/QOywSAyROIk4HE6zemSAZsEoB062OFhTruQcRXIvNTjINMzo2BEBjWZeTs+urrDjBuuVCZqfD4LiQ0QN8dy4lhHtoDH6dv+/kkydsflfycJb4c0Ad1PS28wajBBZj8kZl7Gd7GWq+uTU85csBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495011; c=relaxed/simple;
	bh=+GE0m90lwhlb9OljwVtEQsDCa+zy3VtJ1xGQMp1f3Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiC7jHtUnRY+vqz9NuQlC/4NSiswY6CTVdp1yQDDfucpN3CD0++AGQIuJXHh87A7/kNlw8Ptin6gsZqqdTbMA9QHfXDqWji0Y2SKGONV6iSaqW17n7JeAFdfOB25p0N9XZkf8OlCcF6eGVR5FNer/KIAl7hxFxwq9IThO6yPX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=h2GVWAST; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 142B66984E;
	Mon, 16 Sep 2024 09:56:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495008; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3lB7vMUDAoeBGlHx0db3VH42iw8zhtpQjBkF7LrP3EU=;
	b=h2GVWASTJojpiXbZ3KpUm3pheSuuyx/JanOK1t7Ybvtvqmp3+KVE1DHEHRd0TFyN9fhgMp
	eUGeq008fBE+5C6wnxcZwwHN4ZBKplzgWbF95ymWTg3duKL92DzWAWc9UQqApkWQvuIDeG
	gg2jXnIPZf3GVARjUk/HXee5uTZ+pwWgFF0XvcGOhX+a3z8grxTrGDfo1IlBv4JhszOb+L
	baOaTpLxv6kdiDcpeAXPDCvVeXliIEnvtZ8y43PCjjHeEu5g4qhZa8mM4IpiAr0KMLndQg
	Mj5u6MYFpRjxuY0Cd6hoVsshWsKiTe+Hb18JdsoOV0p+Lwa5JErTZ2bUO883uA==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 05/24] erofs: add inode data structure in Rust
Date: Mon, 16 Sep 2024 21:56:15 +0800
Message-ID: <20240916135634.98554-6-toolmanp@tlmp.cc>
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

This patch introduces the same on-disk erofs data structure
in rust and also introduces multiple helpers for inode i_format
and chunk_indexing and later can be used to implement map_blocks.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs       |   1 +
 fs/erofs/rust/erofs_sys/inode.rs | 291 +++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/inode.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 6f3c12665ed6..34267ec7772d 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -24,6 +24,7 @@
 pub(crate) type PosixResult<T> = Result<T, Errno>;
 
 pub(crate) mod errnos;
+pub(crate) mod inode;
 pub(crate) mod superblock;
 pub(crate) mod xattrs;
 pub(crate) use errnos::Errno;
diff --git a/fs/erofs/rust/erofs_sys/inode.rs b/fs/erofs/rust/erofs_sys/inode.rs
new file mode 100644
index 000000000000..1762023e97f8
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/inode.rs
@@ -0,0 +1,291 @@
+use super::xattrs::*;
+use super::*;
+use core::ffi::*;
+use core::mem::size_of;
+
+/// Represents the compact bitfield of the Erofs Inode format.
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub(crate) struct Format(u16);
+
+pub(crate) const INODE_VERSION_MASK: u16 = 0x1;
+pub(crate) const INODE_VERSION_BIT: u16 = 0;
+
+pub(crate) const INODE_LAYOUT_BIT: u16 = 1;
+pub(crate) const INODE_LAYOUT_MASK: u16 = 0x7;
+
+/// Helper macro to extract property from the bitfield.
+macro_rules! extract {
+    ($name: expr, $bit: expr, $mask: expr) => {
+        ($name >> $bit) & ($mask)
+    };
+}
+
+/// The Version of the Inode which represents whether this inode is extended or compact.
+/// Extended inodes have more infos about nlinks + mtime.
+/// This is documented in https://erofs.docs.kernel.org/en/latest/core_ondisk.html#inodes
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) enum Version {
+    Compat,
+    Extended,
+    Unknown,
+}
+
+/// Represents the data layout backed by the Inode.
+/// As Documented in https://erofs.docs.kernel.org/en/latest/core_ondisk.html#inode-data-layouts
+#[repr(C)]
+#[derive(Clone, Copy, PartialEq)]
+pub(crate) enum Layout {
+    FlatPlain,
+    CompressedFull,
+    FlatInline,
+    CompressedCompact,
+    Chunk,
+    Unknown,
+}
+
+#[repr(C)]
+#[allow(non_camel_case_types)]
+#[derive(Clone, Copy, Debug, PartialEq)]
+pub(crate) enum Type {
+    Regular,
+    Directory,
+    Link,
+    Character,
+    Block,
+    Fifo,
+    Socket,
+    Unknown,
+}
+
+/// This is format extracted from i_format bit representation.
+/// This includes various infos and specs about the inode.
+impl Format {
+    pub(crate) fn version(&self) -> Version {
+        match extract!(self.0, INODE_VERSION_BIT, INODE_VERSION_MASK) {
+            0 => Version::Compat,
+            1 => Version::Extended,
+            _ => Version::Unknown,
+        }
+    }
+
+    pub(crate) fn layout(&self) -> Layout {
+        match extract!(self.0, INODE_LAYOUT_BIT, INODE_LAYOUT_MASK) {
+            0 => Layout::FlatPlain,
+            1 => Layout::CompressedFull,
+            2 => Layout::FlatInline,
+            3 => Layout::CompressedCompact,
+            4 => Layout::Chunk,
+            _ => Layout::Unknown,
+        }
+    }
+}
+
+/// Represents the compact inode which resides on-disk.
+/// This is documented in https://erofs.docs.kernel.org/en/latest/core_ondisk.html#inodes
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct CompactInodeInfo {
+    pub(crate) i_format: Format,
+    pub(crate) i_xattr_icount: u16,
+    pub(crate) i_mode: u16,
+    pub(crate) i_nlink: u16,
+    pub(crate) i_size: u32,
+    pub(crate) i_reserved: [u8; 4],
+    pub(crate) i_u: [u8; 4],
+    pub(crate) i_ino: u32,
+    pub(crate) i_uid: u16,
+    pub(crate) i_gid: u16,
+    pub(crate) i_reserved2: [u8; 4],
+}
+
+/// Represents the extended inode which resides on-disk.
+/// This is documented in https://erofs.docs.kernel.org/en/latest/core_ondisk.html#inodes
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct ExtendedInodeInfo {
+    pub(crate) i_format: Format,
+    pub(crate) i_xattr_icount: u16,
+    pub(crate) i_mode: u16,
+    pub(crate) i_reserved: [u8; 2],
+    pub(crate) i_size: u64,
+    pub(crate) i_u: [u8; 4],
+    pub(crate) i_ino: u32,
+    pub(crate) i_uid: u32,
+    pub(crate) i_gid: u32,
+    pub(crate) i_mtime: u64,
+    pub(crate) i_mtime_nsec: u32,
+    pub(crate) i_nlink: u32,
+    pub(crate) i_reserved2: [u8; 16],
+}
+
+/// Represents the inode info which is either compact or extended.
+#[derive(Clone, Copy)]
+pub(crate) enum InodeInfo {
+    Extended(ExtendedInodeInfo),
+    Compact(CompactInodeInfo),
+}
+
+pub(crate) const CHUNK_BLKBITS_MASK: u16 = 0x1f;
+pub(crate) const CHUNK_FORMAT_INDEX_BIT: u16 = 0x20;
+
+/// Represents on-disk chunk index of the file backing inode.
+#[repr(C)]
+#[derive(Clone, Copy, Debug)]
+pub(crate) struct ChunkIndex {
+    pub(crate) advise: u16,
+    pub(crate) device_id: u16,
+    pub(crate) blkaddr: u32,
+}
+
+impl From<[u8; 8]> for ChunkIndex {
+    fn from(u: [u8; 8]) -> Self {
+        let advise = u16::from_le_bytes([u[0], u[1]]);
+        let device_id = u16::from_le_bytes([u[2], u[3]]);
+        let blkaddr = u32::from_le_bytes([u[4], u[5], u[6], u[7]]);
+        ChunkIndex {
+            advise,
+            device_id,
+            blkaddr,
+        }
+    }
+}
+
+/// Chunk format used for indicating the chunkbits and chunkindex.
+#[repr(C)]
+#[derive(Clone, Copy, Debug)]
+pub(crate) struct ChunkFormat(pub(crate) u16);
+
+impl ChunkFormat {
+    pub(crate) fn is_chunkindex(&self) -> bool {
+        self.0 & CHUNK_FORMAT_INDEX_BIT != 0
+    }
+    pub(crate) fn chunkbits(&self) -> u16 {
+        self.0 & CHUNK_BLKBITS_MASK
+    }
+}
+
+/// Represents the inode spec which is either data or device.
+#[derive(Clone, Copy, Debug)]
+#[repr(u32)]
+pub(crate) enum Spec {
+    Chunk(ChunkFormat),
+    RawBlk(u32),
+    Device(u32),
+    CompressedBlocks(u32),
+    Unknown,
+}
+
+/// Convert the spec from the format of the inode based on the layout.
+impl From<(&[u8; 4], Layout)> for Spec {
+    fn from(value: (&[u8; 4], Layout)) -> Self {
+        match value.1 {
+            Layout::FlatInline | Layout::FlatPlain => Spec::RawBlk(u32::from_le_bytes(*value.0)),
+            Layout::CompressedFull | Layout::CompressedCompact => {
+                Spec::CompressedBlocks(u32::from_le_bytes(*value.0))
+            }
+            Layout::Chunk => Self::Chunk(ChunkFormat(u16::from_le_bytes([value.0[0], value.0[1]]))),
+            // We don't support compressed inlines or compressed chunks currently.
+            _ => Spec::Unknown,
+        }
+    }
+}
+
+/// Helper functions for Inode Info.
+impl InodeInfo {
+    const S_IFMT: u16 = 0o170000;
+    const S_IFSOCK: u16 = 0o140000;
+    const S_IFLNK: u16 = 0o120000;
+    const S_IFREG: u16 = 0o100000;
+    const S_IFBLK: u16 = 0o60000;
+    const S_IFDIR: u16 = 0o40000;
+    const S_IFCHR: u16 = 0o20000;
+    const S_IFIFO: u16 = 0o10000;
+    const S_ISUID: u16 = 0o4000;
+    const S_ISGID: u16 = 0o2000;
+    const S_ISVTX: u16 = 0o1000;
+    pub(crate) fn ino(&self) -> u32 {
+        match self {
+            Self::Extended(extended) => extended.i_ino,
+            Self::Compact(compact) => compact.i_ino,
+        }
+    }
+
+    pub(crate) fn format(&self) -> Format {
+        match self {
+            Self::Extended(extended) => extended.i_format,
+            Self::Compact(compact) => compact.i_format,
+        }
+    }
+
+    pub(crate) fn file_size(&self) -> Off {
+        match self {
+            Self::Extended(extended) => extended.i_size,
+            Self::Compact(compact) => compact.i_size as u64,
+        }
+    }
+
+    pub(crate) fn inode_size(&self) -> Off {
+        match self {
+            Self::Extended(_) => 64,
+            Self::Compact(_) => 32,
+        }
+    }
+
+    pub(crate) fn spec(&self) -> Spec {
+        let mode = match self {
+            Self::Extended(extended) => extended.i_mode,
+            Self::Compact(compact) => compact.i_mode,
+        };
+
+        let u = match self {
+            Self::Extended(extended) => &extended.i_u,
+            Self::Compact(compact) => &compact.i_u,
+        };
+
+        match mode & 0o170000 {
+            0o40000 | 0o100000 | 0o120000 => Spec::from((u, self.format().layout())),
+            // We don't support device inodes currently.
+            _ => Spec::Unknown,
+        }
+    }
+
+    pub(crate) fn inode_type(&self) -> Type {
+        let mode = match self {
+            Self::Extended(extended) => extended.i_mode,
+            Self::Compact(compact) => compact.i_mode,
+        };
+        match mode & Self::S_IFMT {
+            Self::S_IFDIR => Type::Directory, // Directory
+            Self::S_IFREG => Type::Regular,   // Regular File
+            Self::S_IFLNK => Type::Link,      // Symbolic Link
+            Self::S_IFIFO => Type::Fifo,      // FIFO
+            Self::S_IFSOCK => Type::Socket,   // Socket
+            Self::S_IFBLK => Type::Block,     // Block
+            Self::S_IFCHR => Type::Character, // Character
+            _ => Type::Unknown,
+        }
+    }
+
+    pub(crate) fn xattr_size(&self) -> Off {
+        match self {
+            Self::Extended(extended) => {
+                size_of::<XAttrSharedEntrySummary>() as Off
+                    + (size_of::<c_int>() as Off) * (extended.i_xattr_icount as Off - 1)
+            }
+            Self::Compact(_) => 0,
+        }
+    }
+
+    pub(crate) fn xattr_count(&self) -> u16 {
+        match self {
+            Self::Extended(extended) => extended.i_xattr_icount,
+            Self::Compact(compact) => compact.i_xattr_icount,
+        }
+    }
+}
+
+pub(crate) type CompactInodeInfoBuf = [u8; size_of::<CompactInodeInfo>()];
+pub(crate) type ExtendedInodeInfoBuf = [u8; size_of::<ExtendedInodeInfo>()];
+pub(crate) const DEFAULT_INODE_BUF: ExtendedInodeInfoBuf = [0; size_of::<ExtendedInodeInfo>()];
-- 
2.46.0


