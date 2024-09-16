Return-Path: <linux-fsdevel+bounces-29503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5F097A39D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE9E1F28092
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B3192B80;
	Mon, 16 Sep 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="fKGjqmd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303BD192589;
	Mon, 16 Sep 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495046; cv=none; b=CTN78x3NbQhBm1AsjIgvVM38fzM5lSWvHGHZJ1h+IadmrVIqyiQQCfFm0FV025qGh2PBc2GjoP7Il2gBxfvyegQJAZA+sc158EyB9PpFKkpXUFg6+lGCe7tphHAOylS/959+HjikbOl+M2XiRo2EUP3Antx3pHpRlLKXXmtBjlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495046; c=relaxed/simple;
	bh=7DhpC3v/3K+OOvs0Ee6iKzIQkx7FoXxDfepESWYQ9uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0T2FvyT9xXtnVL7IYIMLrQJdMe+zH/jV13eZhz4Tp86WMKA3Bpolw8dEmWmlF7VbMruo+j93EcE35eB6KIXzOo+GYHnmBi3CJlXRPCekfcwJ5IIrD1g6IqBaltXhIFbw0qQ47fsVPQzgQld7Qfl4oT4H/68R90oy32x1nV2baQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=fKGjqmd+; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 561F569848;
	Mon, 16 Sep 2024 09:57:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495043; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=zlfk2yVyXop5WdEA16RsoMhaE54MNmJqzOSetL+7z4A=;
	b=fKGjqmd+H0YGLTKH12je9r6EFTAdm+p96HRgadUd7QQmZjwntWblUGYIdIVSycNZ0Dntvw
	04B30JssSY01wVuEXuSZe3c5YHseypnyeV4f61UiRhsvghp8y/3GYPlALSfLETAnAL4Cs7
	3VopXQjsQbZCkndT8ZbgZA5OZATgIrBIp37RtnuRksV+NNLSYI5kV0lyq2mUs1r2cg0dM2
	3eJpUiWmkeNgcCTfx0LAq2qEOqLVoV3hTh3S3eZSO11zzkhhTRuws9yStiZ882x4srUXjF
	ke2oPQPZDLX6eeBA+43a9lYCtH2VnF3ntPe/a6R/qXjEFM+FJ+YxS0PX0hkmkg==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 23/24] erofs: implement xattrs operations in Rust
Date: Mon, 16 Sep 2024 21:56:33 +0800
Message-ID: <20240916135634.98554-24-toolmanp@tlmp.cc>
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

This patch adds xattrs for erofs_sys crate and will later be used to
implement xattr handler in Rust.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode_rs.rs                      |   7 +-
 fs/erofs/rust/erofs_sys/inode.rs          |   1 +
 fs/erofs/rust/erofs_sys/operations.rs     |  27 ++++
 fs/erofs/rust/erofs_sys/superblock.rs     | 141 +++++++++++++++++++++
 fs/erofs/rust/erofs_sys/superblock/mem.rs |  13 +-
 fs/erofs/rust/erofs_sys/xattrs.rs         | 148 ++++++++++++++++++++++
 fs/erofs/rust/kinode.rs                   |   6 +
 7 files changed, 341 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/inode_rs.rs b/fs/erofs/inode_rs.rs
index 5cca2ae581ac..a79d1157b910 100644
--- a/fs/erofs/inode_rs.rs
+++ b/fs/erofs/inode_rs.rs
@@ -48,8 +48,13 @@ fn try_fill_inode(k_inode: NonNull<inode>, nid: Nid) -> PosixResult<()> {
     let erofs_inode: &mut KernelInode = unsafe {
         &mut *(container_of!(k_inode.as_ptr(), KernelInode, k_inode) as *mut KernelInode)
     };
-    erofs_inode.info.write(sbi.filesystem.read_inode_info(nid)?);
+    let info = sbi.filesystem.read_inode_info(nid)?;
     erofs_inode.nid.write(nid);
+    erofs_inode.shared_entries.write(
+        sbi.filesystem
+            .read_inode_xattrs_shared_entries(nid, &info)?,
+    );
+    erofs_inode.info.write(info);
     Ok(())
 }
 /// Exported as fill_inode additional fill inode
diff --git a/fs/erofs/rust/erofs_sys/inode.rs b/fs/erofs/rust/erofs_sys/inode.rs
index 1ecd6147a126..eb3c2144cad8 100644
--- a/fs/erofs/rust/erofs_sys/inode.rs
+++ b/fs/erofs/rust/erofs_sys/inode.rs
@@ -299,6 +299,7 @@ pub(crate) trait Inode: Sized {
     fn new(_sb: &SuperBlock, info: InodeInfo, nid: Nid) -> Self;
     fn info(&self) -> &InodeInfo;
     fn nid(&self) -> Nid;
+    fn xattrs_shared_entries(&self) -> &XAttrSharedEntries;
 }
 
 /// Represents the error which occurs when trying to convert the inode.
diff --git a/fs/erofs/rust/erofs_sys/operations.rs b/fs/erofs/rust/erofs_sys/operations.rs
index 070ba20908a2..292bfbc7b72c 100644
--- a/fs/erofs/rust/erofs_sys/operations.rs
+++ b/fs/erofs/rust/erofs_sys/operations.rs
@@ -1,9 +1,16 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
+use super::alloc_helper::*;
+use super::data::raw_iters::*;
+use super::data::*;
 use super::inode::*;
 use super::superblock::*;
+use super::xattrs::*;
 use super::*;
+use alloc::vec::Vec;
+
+use crate::round;
 
 pub(crate) fn read_inode<'a, I, C>(
     filesystem: &'a dyn FileSystem<I>,
@@ -33,3 +40,23 @@ pub(crate) fn dir_lookup<'a, I, C>(
             read_inode(filesystem, collection, nid)
         })
 }
+
+pub(crate) fn get_xattr_infixes<'a>(
+    iter: &mut (dyn ContinuousBufferIter<'a> + 'a),
+) -> PosixResult<Vec<XAttrInfix>> {
+    let mut result: Vec<XAttrInfix> = Vec::new();
+    for data in iter {
+        let buffer = data?;
+        let buf = buffer.content();
+        let len = buf.len();
+        let mut cur: usize = 0;
+        while cur <= len {
+            let mut infix: Vec<u8> = Vec::new();
+            let size = u16::from_le_bytes([buf[cur], buf[cur + 1]]) as usize;
+            extend_from_slice(&mut infix, &buf[cur + 2..cur + 2 + size])?;
+            push_vec(&mut result, XAttrInfix(infix))?;
+            cur = round!(UP, cur + 2 + size, 4);
+        }
+    }
+    Ok(result)
+}
diff --git a/fs/erofs/rust/erofs_sys/superblock.rs b/fs/erofs/rust/erofs_sys/superblock.rs
index 403ffdeb4573..6ea59058446e 100644
--- a/fs/erofs/rust/erofs_sys/superblock.rs
+++ b/fs/erofs/rust/erofs_sys/superblock.rs
@@ -3,14 +3,17 @@
 
 pub(crate) mod mem;
 use alloc::boxed::Box;
+use alloc::vec::Vec;
 use core::mem::size_of;
 
+use super::alloc_helper::*;
 use super::data::raw_iters::*;
 use super::data::*;
 use super::devices::*;
 use super::dir::*;
 use super::inode::*;
 use super::map::*;
+use super::xattrs::*;
 use super::*;
 
 use crate::round;
@@ -346,6 +349,144 @@ fn fill_dentries(
         }
         Ok(())
     }
+    // Extended attributes goes here.
+    fn xattr_infixes(&self) -> &Vec<XAttrInfix>;
+    // Currently we eagerly initialized all xattrs;
+    fn read_inode_xattrs_shared_entries(
+        &self,
+        nid: Nid,
+        info: &InodeInfo,
+    ) -> PosixResult<XAttrSharedEntries> {
+        let sb = self.superblock();
+        let mut offset = sb.iloc(nid) + info.inode_size();
+        let mut buf = XATTR_ENTRY_SUMMARY_BUF;
+        let mut indexes: Vec<u32> = Vec::new();
+        self.backend().fill(&mut buf, offset)?;
+
+        let header: XAttrSharedEntrySummary = XAttrSharedEntrySummary::from(buf);
+        offset += size_of::<XAttrSharedEntrySummary>() as Off;
+        for buf in self.continuous_iter(offset, (header.shared_count << 2) as Off)? {
+            let data = buf?;
+            extend_from_slice(&mut indexes, unsafe {
+                core::slice::from_raw_parts(
+                    data.content().as_ptr().cast(),
+                    data.content().len() >> 2,
+                )
+            })?;
+        }
+
+        Ok(XAttrSharedEntries {
+            name_filter: header.name_filter,
+            shared_indexes: indexes,
+        })
+    }
+    fn get_xattr(
+        &self,
+        inode: &I,
+        index: u32,
+        name: &[u8],
+        buffer: &mut Option<&mut [u8]>,
+    ) -> PosixResult<XAttrValue> {
+        let sb = self.superblock();
+        let shared_count = inode.xattrs_shared_entries().shared_indexes.len();
+        let inline_offset = sb.iloc(inode.nid())
+            + inode.info().inode_size() as Off
+            + size_of::<XAttrSharedEntrySummary>() as Off
+            + 4 * shared_count as Off;
+
+        let inline_len = inode.info().xattr_size()
+            - size_of::<XAttrSharedEntrySummary>() as Off
+            - shared_count as Off * 4;
+
+        if let Some(mut inline_provider) =
+            SkippableContinuousIter::try_new(self.continuous_iter(inline_offset, inline_len)?)?
+        {
+            while !inline_provider.eof() {
+                let header = inline_provider.get_entry_header()?;
+                match inline_provider.query_xattr_value(
+                    self.xattr_infixes(),
+                    &header,
+                    name,
+                    index,
+                    buffer,
+                ) {
+                    Ok(value) => return Ok(value),
+                    Err(e) => {
+                        if e != ENODATA {
+                            return Err(e);
+                        }
+                    }
+                }
+            }
+        }
+
+        for entry_index in inode.xattrs_shared_entries().shared_indexes.iter() {
+            let mut shared_provider = SkippableContinuousIter::try_new(self.continuous_iter(
+                sb.blkpos(self.superblock().xattr_blkaddr) + (*entry_index as Off) * 4,
+                u64::MAX,
+            )?)?
+            .unwrap();
+            let header = shared_provider.get_entry_header()?;
+            match shared_provider.query_xattr_value(
+                self.xattr_infixes(),
+                &header,
+                name,
+                index,
+                buffer,
+            ) {
+                Ok(value) => return Ok(value),
+                Err(e) => {
+                    if e != ENODATA {
+                        return Err(e);
+                    }
+                }
+            }
+        }
+
+        Err(ENODATA)
+    }
+
+    fn list_xattrs(&self, inode: &I, buffer: &mut [u8]) -> PosixResult<usize> {
+        let sb = self.superblock();
+        let shared_count = inode.xattrs_shared_entries().shared_indexes.len();
+        let inline_offset = sb.iloc(inode.nid())
+            + inode.info().inode_size() as Off
+            + size_of::<XAttrSharedEntrySummary>() as Off
+            + shared_count as Off * 4;
+        let mut offset = 0;
+        let inline_len = inode.info().xattr_size()
+            - size_of::<XAttrSharedEntrySummary>() as Off
+            - shared_count as Off * 4;
+
+        if let Some(mut inline_provider) =
+            SkippableContinuousIter::try_new(self.continuous_iter(inline_offset, inline_len)?)?
+        {
+            while !inline_provider.eof() {
+                let header = inline_provider.get_entry_header()?;
+                offset += inline_provider.get_xattr_key(
+                    self.xattr_infixes(),
+                    &header,
+                    &mut buffer[offset..],
+                )?;
+                inline_provider.skip_xattr_value(&header)?;
+            }
+        }
+
+        for index in inode.xattrs_shared_entries().shared_indexes.iter() {
+            let mut shared_provider = SkippableContinuousIter::try_new(self.continuous_iter(
+                sb.blkpos(self.superblock().xattr_blkaddr) + (*index as Off) * 4,
+                u64::MAX,
+            )?)?
+            .unwrap();
+            let header = shared_provider.get_entry_header()?;
+            offset += shared_provider.get_xattr_key(
+                self.xattr_infixes(),
+                &header,
+                &mut buffer[offset..],
+            )?;
+        }
+        Ok(offset)
+    }
 }
 
 pub(crate) struct SuperblockInfo<I, C, T>
diff --git a/fs/erofs/rust/erofs_sys/superblock/mem.rs b/fs/erofs/rust/erofs_sys/superblock/mem.rs
index 5756dc08744c..c8af3cb5e56e 100644
--- a/fs/erofs/rust/erofs_sys/superblock/mem.rs
+++ b/fs/erofs/rust/erofs_sys/superblock/mem.rs
@@ -1,8 +1,8 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
-use super::alloc_helper::*;
 use super::data::raw_iters::ref_iter::*;
+use super::operations::*;
 use super::*;
 
 // Memory Mapped Device/File so we need to have some external lifetime on the backend trait.
@@ -16,6 +16,7 @@ pub(crate) struct KernelFileSystem<B>
     backend: B,
     sb: SuperBlock,
     device_info: DeviceInfo,
+    infixes: Vec<XAttrInfix>,
 }
 
 impl<I, B> FileSystem<I> for KernelFileSystem<B>
@@ -58,6 +59,9 @@ fn continuous_iter<'a>(
     fn device_info(&self) -> &DeviceInfo {
         &self.device_info
     }
+    fn xattr_infixes(&self) -> &Vec<XAttrInfix> {
+        &self.infixes
+    }
 }
 
 impl<B> KernelFileSystem<B>
@@ -68,6 +72,12 @@ pub(crate) fn try_new(backend: B) -> PosixResult<Self> {
         let mut buf = SUPERBLOCK_EMPTY_BUF;
         backend.fill(&mut buf, EROFS_SUPER_OFFSET)?;
         let sb: SuperBlock = buf.into();
+        let infixes = get_xattr_infixes(&mut ContinuousRefIter::new(
+            &sb,
+            &backend,
+            sb.xattr_prefix_start as Off,
+            sb.xattr_prefix_count as Off * 4,
+        ))?;
         let device_info = get_device_infos(&mut ContinuousRefIter::new(
             &sb,
             &backend,
@@ -78,6 +88,7 @@ pub(crate) fn try_new(backend: B) -> PosixResult<Self> {
             backend,
             sb,
             device_info,
+            infixes,
         })
     }
 }
diff --git a/fs/erofs/rust/erofs_sys/xattrs.rs b/fs/erofs/rust/erofs_sys/xattrs.rs
index d1a110ef10dd..c97640731562 100644
--- a/fs/erofs/rust/erofs_sys/xattrs.rs
+++ b/fs/erofs/rust/erofs_sys/xattrs.rs
@@ -1,7 +1,13 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
+use super::alloc_helper::*;
+use super::data::raw_iters::*;
+use super::*;
+use crate::round;
+
 use alloc::vec::Vec;
+use core::mem::size_of;
 
 /// The header of the xattr entry index.
 /// This is used to describe the superblock's xattrs collection.
@@ -122,3 +128,145 @@ pub(crate) enum XAttrValue {
     Buffer(usize),
     Vec(Vec<u8>),
 }
+
+/// An iterator to read xattrs by comparing the entry's name one by one and reads its value
+/// correspondingly.
+pub(crate) trait XAttrEntriesProvider {
+    fn get_entry_header(&mut self) -> PosixResult<XAttrEntryHeader>;
+    fn get_xattr_key(
+        &mut self,
+        pfs: &[XAttrInfix],
+        header: &XAttrEntryHeader,
+        buffer: &mut [u8],
+    ) -> PosixResult<usize>;
+    fn query_xattr_value(
+        &mut self,
+        pfs: &[XAttrInfix],
+        header: &XAttrEntryHeader,
+        name: &[u8],
+        index: u32,
+        buffer: &mut Option<&mut [u8]>,
+    ) -> PosixResult<XAttrValue>;
+    fn skip_xattr_value(&mut self, header: &XAttrEntryHeader) -> PosixResult<()>;
+}
+impl<'a> XAttrEntriesProvider for SkippableContinuousIter<'a> {
+    fn get_entry_header(&mut self) -> PosixResult<XAttrEntryHeader> {
+        let mut buf: [u8; 4] = [0; 4];
+        self.read(&mut buf).map(|_| XAttrEntryHeader::from(buf))
+    }
+
+    fn get_xattr_key(
+        &mut self,
+        ifs: &[XAttrInfix],
+        header: &XAttrEntryHeader,
+        buffer: &mut [u8],
+    ) -> PosixResult<usize> {
+        let mut cur = if header.name_index.is_long() {
+            let if_index: usize = header.name_index.into();
+            let infix: &XAttrInfix = ifs.get(if_index).unwrap();
+
+            let pf_index = infix.prefix_index();
+            let prefix = EROFS_XATTRS_PREFIXS[pf_index as usize];
+            let plen = prefix.len();
+
+            buffer[..plen].copy_from_slice(&prefix[..plen]);
+            buffer[plen..infix.name().len() + plen].copy_from_slice(infix.name());
+
+            plen + infix.name().len()
+        } else {
+            let pf_index: usize = header.name_index.into();
+            let prefix = EROFS_XATTRS_PREFIXS[pf_index];
+            let plen = prefix.len();
+            buffer[..plen].copy_from_slice(&prefix[..plen]);
+            plen
+        };
+
+        self.read(&mut buffer[cur..cur + header.suffix_len as usize])?;
+        cur += header.suffix_len as usize;
+        buffer[cur] = b'\0';
+        Ok(cur + 1)
+    }
+
+    fn query_xattr_value(
+        &mut self,
+        ifs: &[XAttrInfix],
+        header: &XAttrEntryHeader,
+        name: &[u8],
+        index: u32,
+        buffer: &mut Option<&mut [u8]>,
+    ) -> PosixResult<XAttrValue> {
+        let xattr_size = round!(
+            UP,
+            header.suffix_len as Off + header.value_len as Off,
+            size_of::<XAttrEntryHeader>() as Off
+        );
+
+        let cur = if header.name_index.is_long() {
+            let if_index: usize = header.name_index.into();
+
+            if if_index >= ifs.len() {
+                return Err(ENODATA);
+            }
+
+            let infix = ifs.get(if_index).unwrap();
+            let ilen = infix.name().len();
+
+            let pf_index = infix.prefix_index();
+
+            if pf_index >= EROFS_XATTRS_PREFIXS.len() as u8 {
+                return Err(ENODATA);
+            }
+
+            if index != pf_index as u32
+                || name.len() != ilen + header.suffix_len as usize
+                || name[..ilen] != *infix.name()
+            {
+                return Err(ENODATA);
+            }
+            ilen
+        } else {
+            let pf_index: usize = header.name_index.into();
+            if pf_index >= EROFS_XATTRS_PREFIXS.len() {
+                return Err(ENODATA);
+            }
+
+            if pf_index != index as usize || header.suffix_len as usize != name.len() {
+                return Err(ENODATA);
+            }
+            0
+        };
+
+        match self.try_cmp(&name[cur..]) {
+            Ok(()) => match buffer.as_mut() {
+                Some(b) => {
+                    if b.len() < header.value_len as usize {
+                        return Err(ERANGE);
+                    }
+                    self.read(&mut b[..header.value_len as usize])?;
+                    Ok(XAttrValue::Buffer(header.value_len as usize))
+                }
+                None => {
+                    let mut b: Vec<u8> = vec_with_capacity(header.value_len as usize)?;
+                    self.read(&mut b)?;
+                    Ok(XAttrValue::Vec(b))
+                }
+            },
+            Err(skip_err) => match skip_err {
+                SkipCmpError::NotEqual(nvalue) => {
+                    self.skip(xattr_size - nvalue)?;
+                    Err(ENODATA)
+                }
+                SkipCmpError::PosixError(e) => Err(e),
+            },
+        }
+    }
+    fn skip_xattr_value(&mut self, header: &XAttrEntryHeader) -> PosixResult<()> {
+        self.skip(
+            round!(
+                UP,
+                header.suffix_len as Off + header.value_len as Off,
+                size_of::<XAttrEntryHeader>() as Off
+            ) - header.suffix_len as Off,
+        )
+    }
+}
diff --git a/fs/erofs/rust/kinode.rs b/fs/erofs/rust/kinode.rs
index fac72bd8b6b3..a4bea228ddc0 100644
--- a/fs/erofs/rust/kinode.rs
+++ b/fs/erofs/rust/kinode.rs
@@ -11,6 +11,7 @@
 use super::erofs_sys::errnos::*;
 use super::erofs_sys::inode::*;
 use super::erofs_sys::superblock::*;
+use super::erofs_sys::xattrs::*;
 use super::erofs_sys::*;
 
 extern "C" {
@@ -22,6 +23,7 @@
 pub(crate) struct KernelInode {
     pub(crate) info: MaybeUninit<InodeInfo>,
     pub(crate) nid: MaybeUninit<Nid>,
+    pub(crate) shared_entries: MaybeUninit<XAttrSharedEntries>,
     pub(crate) k_inode: MaybeUninit<inode>,
     pub(crate) k_opaque: MaybeUninit<*mut c_void>,
 }
@@ -31,6 +33,7 @@ fn new(_sb: &SuperBlock, _info: InodeInfo, _nid: Nid) -> Self {
         Self {
             info: MaybeUninit::uninit(),
             nid: MaybeUninit::uninit(),
+            shared_entries: MaybeUninit::uninit(),
             k_inode: MaybeUninit::uninit(),
             k_opaque: MaybeUninit::uninit(),
         }
@@ -41,6 +44,9 @@ fn nid(&self) -> Nid {
     fn info(&self) -> &InodeInfo {
         unsafe { self.info.assume_init_ref() }
     }
+    fn xattrs_shared_entries(&self) -> &XAttrSharedEntries {
+        unsafe { self.shared_entries.assume_init_ref() }
+    }
 }
 
 pub(crate) struct KernelInodeCollection {
-- 
2.46.0


