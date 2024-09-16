Return-Path: <linux-fsdevel+bounces-29496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EBA97A38E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF3E1F26FDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C7416B3AC;
	Mon, 16 Sep 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="ZXh9ANSe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA717B514;
	Mon, 16 Sep 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495031; cv=none; b=svgrGTsjpv0XG5LcIzWnBysHtDkPAmZboNGmJ9xtuLvtBE2whBQbu6BJNP//Bm/0MfRdqiLY+4p7IM2uzN0U/I42FZLgOzOs8MP+qSaoypuLClPe1SXduLuNJSawDriePXcu+nnfYnlHsCbDdIVem7nwOCtJYcdneR4+W+UmSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495031; c=relaxed/simple;
	bh=jUiK35jhCNKwNtLZmWNbheSdEs1dR8byw40iyQ24itA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmW8ozwXHi/U2rPKQtcEzjd1UNEQF+BmrtoNeNY+onX1BQj0huV8J+jVoKsmeSbg+j4PzaUiVrjUFEZ5Q07NlAL7NLKwOOnJXvSlJxFK6AxyGztRgRqnBWvGJAdreKQ0WWbU6hDVJ37in0FhCHdTKX1szBCccMZqPb/ivkosuIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=ZXh9ANSe; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7576069845;
	Mon, 16 Sep 2024 09:57:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495029; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=IJeFyOgl8nOrg6bU4FPruU0g/Xx5Ar0E77i2j4pU4gE=;
	b=ZXh9ANSeQAemFI4eZL3sOh1Z2/r3EKl6hlzBLpgjMPgsxzAe+kNNa64a9MdPQqqYmHRJsl
	3mBfx2PEAAQLsqHMGWmquqyme73AJoHHVz5iaVNcAYIqdRqV9a7B/kuw8mNrEFOkuRo5Zh
	rHWXcuY1hgx0yHt4EXAbSnG1tWurs72jBfpkJmHx6EI4we2UTFs+gunmnMG+DkvI3pBqUx
	zxoOFTdsPOxVTivfHCHMiacs26ZpzMZDkcjFGCxqvnZAjNp1vHPBaTdLo+qCF9om8mL6WW
	pTt3MbFU9KdB++Cq1L41srGGKE0GIpVdsXkZaAd70XTtDaTC2QFnVqocbpQpJw==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 16/24] erofs: implement dir and inode operations in Rust
Date: Mon, 16 Sep 2024 21:56:26 +0800
Message-ID: <20240916135634.98554-17-toolmanp@tlmp.cc>
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

Implement dir ops and inode ops in Rust.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs            |  1 +
 fs/erofs/rust/erofs_sys/data.rs       |  4 ++
 fs/erofs/rust/erofs_sys/operations.rs | 35 ++++++++++++++++
 fs/erofs/rust/erofs_sys/superblock.rs | 59 +++++++++++++++++++++++++++
 4 files changed, 99 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/operations.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 20c0aa81a800..8c08ac347b2b 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -30,6 +30,7 @@
 pub(crate) mod errnos;
 pub(crate) mod inode;
 pub(crate) mod map;
+pub(crate) mod operations;
 pub(crate) mod superblock;
 pub(crate) mod xattrs;
 pub(crate) use errnos::{Errno, Errno::*};
diff --git a/fs/erofs/rust/erofs_sys/data.rs b/fs/erofs/rust/erofs_sys/data.rs
index 21630673c24e..67bb66ce9efb 100644
--- a/fs/erofs/rust/erofs_sys/data.rs
+++ b/fs/erofs/rust/erofs_sys/data.rs
@@ -2,6 +2,7 @@
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 pub(crate) mod backends;
 pub(crate) mod raw_iters;
+use super::dir::*;
 use super::inode::*;
 use super::map::*;
 use super::superblock::*;
@@ -26,6 +27,9 @@ pub(crate) trait Backend {
 /// DirEntries.
 pub(crate) trait Buffer {
     fn content(&self) -> &[u8];
+    fn iter_dir(&self) -> DirCollection<'_> {
+        DirCollection::new(self.content())
+    }
 }
 
 /// Represents a buffer that holds a reference to a slice of data that
diff --git a/fs/erofs/rust/erofs_sys/operations.rs b/fs/erofs/rust/erofs_sys/operations.rs
new file mode 100644
index 000000000000..070ba20908a2
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/operations.rs
@@ -0,0 +1,35 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::inode::*;
+use super::superblock::*;
+use super::*;
+
+pub(crate) fn read_inode<'a, I, C>(
+    filesystem: &'a dyn FileSystem<I>,
+    collection: &'a mut C,
+    nid: Nid,
+) -> PosixResult<&'a mut I>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    collection.iget(nid, filesystem)
+}
+
+pub(crate) fn dir_lookup<'a, I, C>(
+    filesystem: &'a dyn FileSystem<I>,
+    collection: &'a mut C,
+    inode: &I,
+    name: &str,
+) -> PosixResult<&'a mut I>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    filesystem
+        .find_nid(inode, name)?
+        .map_or(Err(Errno::ENOENT), |nid| {
+            read_inode(filesystem, collection, nid)
+        })
+}
diff --git a/fs/erofs/rust/erofs_sys/superblock.rs b/fs/erofs/rust/erofs_sys/superblock.rs
index f60657eff3d6..403ffdeb4573 100644
--- a/fs/erofs/rust/erofs_sys/superblock.rs
+++ b/fs/erofs/rust/erofs_sys/superblock.rs
@@ -8,6 +8,7 @@
 use super::data::raw_iters::*;
 use super::data::*;
 use super::devices::*;
+use super::dir::*;
 use super::inode::*;
 use super::map::*;
 use super::*;
@@ -287,6 +288,64 @@ fn continuous_iter<'a>(
         offset: Off,
         len: Off,
     ) -> PosixResult<Box<dyn ContinuousBufferIter<'a> + 'a>>;
+
+    // Inode related goes here.
+    fn read_inode_info(&self, nid: Nid) -> PosixResult<InodeInfo> {
+        (self.as_filesystem(), nid).try_into()
+    }
+
+    fn find_nid(&self, inode: &I, name: &str) -> PosixResult<Option<Nid>> {
+        for buf in self.mapped_iter(inode, 0)? {
+            for dirent in buf?.iter_dir() {
+                if dirent.dirname() == name.as_bytes() {
+                    return Ok(Some(dirent.desc.nid));
+                }
+            }
+        }
+        Ok(None)
+    }
+
+    // Readdir related goes here.
+    fn fill_dentries(
+        &self,
+        inode: &I,
+        offset: Off,
+        emitter: &mut dyn FnMut(Dirent<'_>, Off),
+    ) -> PosixResult<()> {
+        let sb = self.superblock();
+        let accessor = sb.blk_access(offset);
+        if offset > inode.info().file_size() {
+            return Err(EUCLEAN);
+        }
+
+        let map_offset = round!(DOWN, offset, sb.blksz());
+        let blk_offset = round!(UP, accessor.off, size_of::<DirentDesc>() as Off);
+
+        let mut map_iter = self.mapped_iter(inode, map_offset)?;
+        let first_buf = map_iter.next().unwrap()?;
+        let mut collection = first_buf.iter_dir();
+
+        let mut pos: Off = map_offset + blk_offset;
+
+        if blk_offset as usize / size_of::<DirentDesc>() <= collection.total() {
+            collection.skip_dir(blk_offset as usize / size_of::<DirentDesc>());
+            for dirent in collection {
+                emitter(dirent, pos);
+                pos += size_of::<DirentDesc>() as Off;
+            }
+        }
+
+        pos = round!(UP, pos, sb.blksz());
+
+        for buf in map_iter {
+            for dirent in buf?.iter_dir() {
+                emitter(dirent, pos);
+                pos += size_of::<DirentDesc>() as Off;
+            }
+            pos = round!(UP, pos, sb.blksz());
+        }
+        Ok(())
+    }
 }
 
 pub(crate) struct SuperblockInfo<I, C, T>
-- 
2.46.0


