Return-Path: <linux-fsdevel+bounces-29495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E001B97A38C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1107E1C25930
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65DE17C99B;
	Mon, 16 Sep 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="g8obcaLK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741417A59D;
	Mon, 16 Sep 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495030; cv=none; b=thjR2MOLM3HjxNBdtsg4enkT+m5c7tfNlort3wF/NGlyp/tCmvotFMn43cCfFd0wz83G+WJOBbn9rq17ZkwJra+6U6ZT7ZzB6aO4h+gckfG4CRCOdIHBeuwD3N1VXZ3dqTewNZ6ZjgwrKL+aszZzJlA7Gx/BzUFyQkLWT8B8v08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495030; c=relaxed/simple;
	bh=YfrKy0P5t/PFVgfEJ9Oa8pP3m9ofPBgNKhmjzSJN120=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exFt98B2J/aU0CQ/WWi4ceuMGWOVG+PKSPnKHIrKKS4mvgMhHuXhUClZJ4brH3KmmXyoAFHWYV9MGFudE8ZjwIRI+cqrw5qP/nSiNDeLaqg9aFhN4zwudax1KCkJN10EGU9mwyY7nZsixpqxpOAFNiS+Q5Cp1XREb7s4QKwGgXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=g8obcaLK; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CD5769989;
	Mon, 16 Sep 2024 09:57:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495027; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bCX/VGnpSaFf2bcuOvskzF/4BX9NNeVk1l0oyYrgTyQ=;
	b=g8obcaLKn83twIxtsW1bMKexchJ/MixNaNHqV9/9wVbN1Tm0XJI+GQOH/h+dJ0gXl+uX7P
	7xEc4xBpK51y0PKnnS4/Ma7hE99UXXOx7ap0tAZcH9XaV3UtgfAojztOBAoCnvX/XThgaL
	MxKJNTvonxSeZQ4cikSnniS8pN4cmaMlU0svNBht1nckie5xXQMSKQfeKr4Q+ILgP6Nbpi
	7ZzdyLcmeRasnDv7/ROCWkaxoMufdke1WjhW5g8pTWWtQFc8Gou3JqwYHnM7Oer5rWrhgZ
	jD1dcmCu80OQR4cNzMMvsaFzmHW3FLjE+xnVgr7kC8EyxHAZt6ovnWDlORqLTQ==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 15/24] erofs: add iter methods in filesystem in Rust
Date: Mon, 16 Sep 2024 21:56:25 +0800
Message-ID: <20240916135634.98554-16-toolmanp@tlmp.cc>
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

Implement mapped iter that uses the MapIter and can yield data that is
backed by EROFS inode.

Implement continuous_iter and mapped_iter for filesystem which can
returns an iterator that yields raw data.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/data.rs               |  2 +
 .../rust/erofs_sys/data/raw_iters/ref_iter.rs | 63 +++++++++++++++++++
 .../rust/erofs_sys/data/raw_iters/traits.rs   |  4 ++
 fs/erofs/rust/erofs_sys/superblock.rs         | 13 ++++
 fs/erofs/rust/erofs_sys/superblock/mem.rs     | 22 +++++++
 5 files changed, 104 insertions(+)

diff --git a/fs/erofs/rust/erofs_sys/data.rs b/fs/erofs/rust/erofs_sys/data.rs
index 483f3204ce42..21630673c24e 100644
--- a/fs/erofs/rust/erofs_sys/data.rs
+++ b/fs/erofs/rust/erofs_sys/data.rs
@@ -2,6 +2,8 @@
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 pub(crate) mod backends;
 pub(crate) mod raw_iters;
+use super::inode::*;
+use super::map::*;
 use super::superblock::*;
 use super::*;
 
diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs b/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
index 5aa2b7f44f3d..d39c9523b628 100644
--- a/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
@@ -4,6 +4,69 @@
 use super::super::*;
 use super::*;
 
+pub(crate) struct RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: Backend,
+    I: Inode,
+{
+    sb: &'a SuperBlock,
+    backend: &'a B,
+    map_iter: MapIter<'a, 'b, FS, I>,
+}
+
+impl<'a, 'b, FS, B, I> RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: Backend,
+    I: Inode,
+{
+    pub(crate) fn new(
+        sb: &'a SuperBlock,
+        backend: &'a B,
+        map_iter: MapIter<'a, 'b, FS, I>,
+    ) -> Self {
+        Self {
+            sb,
+            backend,
+            map_iter,
+        }
+    }
+}
+
+impl<'a, 'b, FS, B, I> Iterator for RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: Backend,
+    I: Inode,
+{
+    type Item = PosixResult<RefBuffer<'a>>;
+    fn next(&mut self) -> Option<Self::Item> {
+        match self.map_iter.next() {
+            Some(map) => match map {
+                Ok(m) => {
+                    let accessor = self.sb.blk_access(m.physical.start);
+                    let len = m.physical.len.min(accessor.len);
+                    match self.backend.as_buf(m.physical.start, len) {
+                        Ok(buf) => Some(Ok(buf)),
+                        Err(e) => Some(Err(e)),
+                    }
+                }
+                Err(e) => Some(Err(e)),
+            },
+            None => None,
+        }
+    }
+}
+
+impl<'a, 'b, FS, B, I> BufferMapIter<'a> for RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: Backend,
+    I: Inode,
+{
+}
+
 /// Continous Ref Buffer Iterator which iterates over a range of disk addresses within the
 /// the temp block size. Since the temp block is always the same size as page and it will not
 /// overflow.
diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs b/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
index 90b6a51658a9..531e970cdb49 100644
--- a/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
@@ -3,6 +3,10 @@
 
 use super::super::*;
 
+/// Represents a basic iterator over a range of bytes from data backends.
+/// The access order is guided by the block maps from the filesystem.
+pub(crate) trait BufferMapIter<'a>: Iterator<Item = PosixResult<RefBuffer<'a>>> {}
+
 /// Represents a basic iterator over a range of bytes from data backends.
 /// Note that this is skippable and can be used to move the iterator's cursor forward.
 pub(crate) trait ContinuousBufferIter<'a>:
diff --git a/fs/erofs/rust/erofs_sys/superblock.rs b/fs/erofs/rust/erofs_sys/superblock.rs
index fc6b3cb00b18..f60657eff3d6 100644
--- a/fs/erofs/rust/erofs_sys/superblock.rs
+++ b/fs/erofs/rust/erofs_sys/superblock.rs
@@ -5,6 +5,7 @@
 use alloc::boxed::Box;
 use core::mem::size_of;
 
+use super::data::raw_iters::*;
 use super::data::*;
 use super::devices::*;
 use super::inode::*;
@@ -274,6 +275,18 @@ fn map(&self, inode: &I, offset: Off) -> MapResult {
             _ => todo!(),
         }
     }
+
+    fn mapped_iter<'b, 'a: 'b>(
+        &'a self,
+        inode: &'b I,
+        offset: Off,
+    ) -> PosixResult<Box<dyn BufferMapIter<'a> + 'b>>;
+
+    fn continuous_iter<'a>(
+        &'a self,
+        offset: Off,
+        len: Off,
+    ) -> PosixResult<Box<dyn ContinuousBufferIter<'a> + 'a>>;
 }
 
 pub(crate) struct SuperblockInfo<I, C, T>
diff --git a/fs/erofs/rust/erofs_sys/superblock/mem.rs b/fs/erofs/rust/erofs_sys/superblock/mem.rs
index 12bf797bd1e3..5756dc08744c 100644
--- a/fs/erofs/rust/erofs_sys/superblock/mem.rs
+++ b/fs/erofs/rust/erofs_sys/superblock/mem.rs
@@ -1,6 +1,7 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
+use super::alloc_helper::*;
 use super::data::raw_iters::ref_iter::*;
 use super::*;
 
@@ -33,6 +34,27 @@ fn as_filesystem(&self) -> &dyn FileSystem<I> {
         self
     }
 
+    fn mapped_iter<'b, 'a: 'b>(
+        &'a self,
+        inode: &'b I,
+        offset: Off,
+    ) -> PosixResult<Box<dyn BufferMapIter<'a> + 'b>> {
+        heap_alloc(RefMapIter::new(
+            &self.sb,
+            &self.backend,
+            MapIter::new(self, inode, offset),
+        ))
+        .map(|v| v as Box<dyn BufferMapIter<'a> + 'b>)
+    }
+    fn continuous_iter<'a>(
+        &'a self,
+        offset: Off,
+        len: Off,
+    ) -> PosixResult<Box<dyn ContinuousBufferIter<'a> + 'a>> {
+        heap_alloc(ContinuousRefIter::new(&self.sb, &self.backend, offset, len))
+            .map(|v| v as Box<dyn ContinuousBufferIter<'a> + 'a>)
+    }
+
     fn device_info(&self) -> &DeviceInfo {
         &self.device_info
     }
-- 
2.46.0


