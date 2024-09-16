Return-Path: <linux-fsdevel+bounces-29494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F170F97A38A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225AE1C256DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE0A179654;
	Mon, 16 Sep 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="OhDZuHKS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83516B3AC;
	Mon, 16 Sep 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495028; cv=none; b=uZEHX5Tse1zaGkz+QBmK4P43cE8OioyEQ9XIQlEGRU7tbO3AShwkxCWk3CoOCc7qOM1OpF4wLHoPz5tyYvRuahrrJEJp6BESRHr7GjrTyK2lwzrUOFaNvJplxn92cK9wEinXZl1Zwl3u42e/MQI3RSRurO02l/uktH+URHo/dJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495028; c=relaxed/simple;
	bh=VzIhTohL0KjtxsZXTKcqDwxBOs3aanECzljxZVrJ7CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnQA6ZmTNGQ0zBpBSeT1kbkjV70reHVBS00KOuUSZcW+eKnWh/2aFJfUMwa6yA4fS+XTv1wRyxmkqva2YlNc+hfHsSuuzmFOWzrAOt3DWrF/u9TSautgzzf0ohj9GhbCsffKhhAwYHyi2caIBsgeaFuJPDHICLLIyzzrju7eKE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=OhDZuHKS; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9630369981;
	Mon, 16 Sep 2024 09:57:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495025; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=OlEgwvboFeWlv8zS3o2IBrRUjCWpIFBmMrHI8v0zFQI=;
	b=OhDZuHKSiJhuEfIz7ReFU6eFI5k+gYwPu8MhBCsYM0T+rbRh1gmc0xESMjiFWkMKIaETSE
	aeFmGCTipcRxNiqkaUFiBcrhcMp1evf73Hjpd0ch8pPOyiYhYktNJIX0eFU38Tes9ukbGz
	dJk391kNAqq8b+adb78FQt+O9/CMAY2FUShVMt/GxyRpy8vt+TQ7Qymfz3neRkBUKz+Elp
	EFOlAeF3mN2pPmnJzf6bKc1fSmCPQeIvXo3iBTbtPn35EhmJCQwvPTb7jyNupjdyAPVN8r
	Daw8vcQjXsI1uhZ7Izjwt45aelZ/hE2wUyBBlIUQELOydvanyHcIIkTQ+dDS1w==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 14/24] erofs: add block mapping capability in Rust
Date: Mon, 16 Sep 2024 21:56:24 +0800
Message-ID: <20240916135634.98554-15-toolmanp@tlmp.cc>
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

Implement block mapping in rust and implement map iterators
over Inode which will be used in data access.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/map.rs        |  54 +++++++++++
 fs/erofs/rust/erofs_sys/superblock.rs | 129 ++++++++++++++++++++++++++
 2 files changed, 183 insertions(+)

diff --git a/fs/erofs/rust/erofs_sys/map.rs b/fs/erofs/rust/erofs_sys/map.rs
index 757e8083c8f1..f56f31cefcd5 100644
--- a/fs/erofs/rust/erofs_sys/map.rs
+++ b/fs/erofs/rust/erofs_sys/map.rs
@@ -1,7 +1,10 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
+use super::inode::*;
+use super::superblock::*;
 use super::*;
+
 pub(crate) const MAP_MAPPED: u32 = 0x0001;
 pub(crate) const MAP_META: u32 = 0x0002;
 pub(crate) const MAP_ENCODED: u32 = 0x0004;
@@ -43,3 +46,54 @@ fn from(value: MapType) -> Self {
 }
 
 pub(crate) type MapResult = PosixResult<Map>;
+
+/// Iterates over the data map represented by an inode.
+pub(crate) struct MapIter<'a, 'b, FS, I>
+where
+    FS: FileSystem<I>,
+    I: Inode,
+{
+    fs: &'a FS,
+    inode: &'b I,
+    offset: Off,
+    len: Off,
+}
+
+impl<'a, 'b, FS, I> MapIter<'a, 'b, FS, I>
+where
+    FS: FileSystem<I>,
+    I: Inode,
+{
+    pub(crate) fn new(fs: &'a FS, inode: &'b I, offset: Off) -> Self {
+        Self {
+            fs,
+            inode,
+            offset,
+            len: inode.info().file_size(),
+        }
+    }
+}
+
+impl<'a, 'b, FS, I> Iterator for MapIter<'a, 'b, FS, I>
+where
+    FS: FileSystem<I>,
+    I: Inode,
+{
+    type Item = MapResult;
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.offset >= self.len {
+            None
+        } else {
+            let result = self.fs.map(self.inode, self.offset);
+            match result {
+                Ok(m) => {
+                    let accessor = self.fs.superblock().blk_access(m.physical.start);
+                    let len = m.physical.len.min(accessor.len);
+                    self.offset += len;
+                    Some(Ok(m))
+                }
+                Err(e) => Some(Err(e)),
+            }
+        }
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/superblock.rs b/fs/erofs/rust/erofs_sys/superblock.rs
index 940ab0b03a26..fc6b3cb00b18 100644
--- a/fs/erofs/rust/erofs_sys/superblock.rs
+++ b/fs/erofs/rust/erofs_sys/superblock.rs
@@ -8,8 +8,11 @@
 use super::data::*;
 use super::devices::*;
 use super::inode::*;
+use super::map::*;
 use super::*;
 
+use crate::round;
+
 /// The ondisk superblock structure.
 #[derive(Debug, Clone, Copy, Default)]
 #[repr(C)]
@@ -135,6 +138,10 @@ pub(crate) fn blk_round_up(&self, addr: Off) -> Blk {
     pub(crate) fn iloc(&self, nid: Nid) -> Off {
         self.blkpos(self.meta_blkaddr) + ((nid as Off) << (5 as Off))
     }
+    pub(crate) fn chunk_access(&self, format: ChunkFormat, address: Off) -> Accessor {
+        let chunkbits = format.chunkbits() + self.blkszbits as u16;
+        Accessor::new(address, chunkbits as Off)
+    }
 }
 
 pub(crate) trait FileSystem<I>
@@ -145,6 +152,128 @@ pub(crate) trait FileSystem<I>
     fn backend(&self) -> &dyn Backend;
     fn as_filesystem(&self) -> &dyn FileSystem<I>;
     fn device_info(&self) -> &DeviceInfo;
+    fn flatmap(&self, inode: &I, offset: Off, inline: bool) -> MapResult {
+        let sb = self.superblock();
+        let nblocks = sb.blk_round_up(inode.info().file_size());
+        let blkaddr = match inode.info().spec() {
+            Spec::RawBlk(blkaddr) => Ok(blkaddr),
+            _ => Err(EUCLEAN),
+        }?;
+
+        let lastblk = if inline { nblocks - 1 } else { nblocks };
+        if offset < sb.blkpos(lastblk) {
+            let len = inode.info().file_size().min(sb.blkpos(lastblk)) - offset;
+            Ok(Map {
+                logical: Segment { start: offset, len },
+                physical: Segment {
+                    start: sb.blkpos(blkaddr) + offset,
+                    len,
+                },
+                algorithm_format: 0,
+                device_id: 0,
+                map_type: MapType::Normal,
+            })
+        } else if inline {
+            let len = inode.info().file_size() - offset;
+            let accessor = sb.blk_access(offset);
+            Ok(Map {
+                logical: Segment { start: offset, len },
+                physical: Segment {
+                    start: sb.iloc(inode.nid())
+                        + inode.info().inode_size()
+                        + inode.info().xattr_size()
+                        + accessor.off,
+                    len,
+                },
+                algorithm_format: 0,
+                device_id: 0,
+                map_type: MapType::Meta,
+            })
+        } else {
+            Err(EUCLEAN)
+        }
+    }
+
+    fn chunk_map(&self, inode: &I, offset: Off) -> MapResult {
+        let sb = self.superblock();
+        let chunkformat = match inode.info().spec() {
+            Spec::Chunk(chunkformat) => Ok(chunkformat),
+            _ => Err(EUCLEAN),
+        }?;
+        let accessor = sb.chunk_access(chunkformat, offset);
+
+        if chunkformat.is_chunkindex() {
+            let unit = size_of::<ChunkIndex>() as Off;
+            let pos = round!(
+                UP,
+                self.superblock().iloc(inode.nid())
+                    + inode.info().inode_size()
+                    + inode.info().xattr_size()
+                    + unit * accessor.nr,
+                unit
+            );
+            let mut buf = [0u8; size_of::<ChunkIndex>()];
+            self.backend().fill(&mut buf, pos)?;
+            let chunk_index = ChunkIndex::from(buf);
+            if chunk_index.blkaddr == u32::MAX {
+                Err(EUCLEAN)
+            } else {
+                Ok(Map {
+                    logical: Segment {
+                        start: accessor.base + accessor.off,
+                        len: accessor.len,
+                    },
+                    physical: Segment {
+                        start: sb.blkpos(chunk_index.blkaddr) + accessor.off,
+                        len: accessor.len,
+                    },
+                    algorithm_format: 0,
+                    device_id: chunk_index.device_id & self.device_info().mask,
+                    map_type: MapType::Normal,
+                })
+            }
+        } else {
+            let unit = 4;
+            let pos = round!(
+                UP,
+                sb.iloc(inode.nid())
+                    + inode.info().inode_size()
+                    + inode.info().xattr_size()
+                    + unit * accessor.nr,
+                unit
+            );
+            let mut buf = [0u8; 4];
+            self.backend().fill(&mut buf, pos)?;
+            let blkaddr = u32::from_le_bytes(buf);
+            let len = accessor.len.min(inode.info().file_size() - offset);
+            if blkaddr == u32::MAX {
+                Err(EUCLEAN)
+            } else {
+                Ok(Map {
+                    logical: Segment {
+                        start: accessor.base + accessor.off,
+                        len,
+                    },
+                    physical: Segment {
+                        start: sb.blkpos(blkaddr) + accessor.off,
+                        len,
+                    },
+                    algorithm_format: 0,
+                    device_id: 0,
+                    map_type: MapType::Normal,
+                })
+            }
+        }
+    }
+
+    fn map(&self, inode: &I, offset: Off) -> MapResult {
+        match inode.info().format().layout() {
+            Layout::FlatInline => self.flatmap(inode, offset, true),
+            Layout::FlatPlain => self.flatmap(inode, offset, false),
+            Layout::Chunk => self.chunk_map(inode, offset),
+            _ => todo!(),
+        }
+    }
 }
 
 pub(crate) struct SuperblockInfo<I, C, T>
-- 
2.46.0


