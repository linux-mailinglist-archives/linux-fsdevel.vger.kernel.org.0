Return-Path: <linux-fsdevel+bounces-29492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF897A385
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F5D1F266EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDB31684A2;
	Mon, 16 Sep 2024 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="JzgW3RT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4001662F7;
	Mon, 16 Sep 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495023; cv=none; b=vCImqFP9q0CiTTYTK5CsdNLXhZXrWu2gX2KIwy84Ypt3xJ8turF+6OFfzLN3l62/8fOW2uqRoOh6dAtGGHC2EYRehqnDyoo2n2M2TnJtYL0LvBvf4CdphjZ7IX/6RpYksgw2BBe+0UTyWaeHqdcE3K/1VzHDdQwu8aDv/ql+Xk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495023; c=relaxed/simple;
	bh=r1kk9No5ipZSuvASJgNj7Q/8wv6E1PJMOtbpvnAfHEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyhOlCTXA5zqCdZrR4+S9kkL3iHM03LYV8ND8sQeeXrX76dh2ecjIsCJSi1P1wy6IB0Gcv+rzu5hddq66RqOUHUDNrC2EvMP9W8wD9QOLlfzhXuEmQx4wapKPNmpSZox81GZin4gfh++JYi+Pr5GKnM45+d3bXxW2w2p+Lcac7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=JzgW3RT9; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76A4A697C4;
	Mon, 16 Sep 2024 09:57:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495021; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aIuZG5PEljHDXPUlgWsVRtI4LVnRy+jfg4KsDBMADu4=;
	b=JzgW3RT9D4Z5Zx0GeV99WrpnWZLJKf6cD4UwQVruHRKjSt1IWDApdXssW522GAGu85TKJE
	szMUzWXMfWY4d+6AlArsH21f89D7DGFxIvxS/ynohg2VJN7VbuRLb3s9z6GsTSDB9k9tyY
	SxKljzY3Y8TrYD8aWuprNrCBpCZ6u5Ph/OdJ3hcLwdUnBO2mN6/rjkCh95g2TIXSUJIoQd
	QtMVozhUxBW1K0sVzTjCtcYV1bQz0R9qzMPS6+GcsCH5guI40E/ucfP7+HzmeppU8W5pDA
	nEfyy0mEsmcOhPs3p0CpuD1N6FYdbonSJ4n1spG/+ncP73znZUy0DRoF4cblwg==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 12/24] erofs: add directory entry data structure in Rust
Date: Mon, 16 Sep 2024 21:56:22 +0800
Message-ID: <20240916135634.98554-13-toolmanp@tlmp.cc>
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

This patch adds DirentDesc and DirCollection in Rust.
It will later be used as helper to read_dir and lookup operations.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs     |  1 +
 fs/erofs/rust/erofs_sys/dir.rs | 98 ++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/dir.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 15ed65866097..65dc563986c3 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -26,6 +26,7 @@
 pub(crate) mod alloc_helper;
 pub(crate) mod data;
 pub(crate) mod devices;
+pub(crate) mod dir;
 pub(crate) mod errnos;
 pub(crate) mod inode;
 pub(crate) mod map;
diff --git a/fs/erofs/rust/erofs_sys/dir.rs b/fs/erofs/rust/erofs_sys/dir.rs
new file mode 100644
index 000000000000..d4255582b7c0
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/dir.rs
@@ -0,0 +1,98 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+/// On-disk Directory Descriptor Format for EROFS
+/// Documented on [EROFS Directory](https://erofs.docs.kernel.org/en/latest/core_ondisk.html#directories)
+use core::mem::size_of;
+
+#[repr(C, packed)]
+#[derive(Debug, Clone, Copy)]
+pub(crate) struct DirentDesc {
+    pub(crate) nid: u64,
+    pub(crate) nameoff: u16,
+    pub(crate) file_type: u8,
+    pub(crate) reserved: u8,
+}
+
+/// In memory representation of a real directory entry.
+#[derive(Debug, Clone, Copy)]
+pub(crate) struct Dirent<'a> {
+    pub(crate) desc: DirentDesc,
+    pub(crate) name: &'a [u8],
+}
+
+impl From<[u8; size_of::<DirentDesc>()]> for DirentDesc {
+    fn from(data: [u8; size_of::<DirentDesc>()]) -> Self {
+        Self {
+            nid: u64::from_le_bytes([
+                data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7],
+            ]),
+            nameoff: u16::from_le_bytes([data[8], data[9]]),
+            file_type: data[10],
+            reserved: data[11],
+        }
+    }
+}
+
+/// Create a collection of directory entries from a buffer.
+/// This is a helper struct to iterate over directory entries.
+pub(crate) struct DirCollection<'a> {
+    data: &'a [u8],
+    offset: usize,
+    total: usize,
+}
+
+impl<'a> DirCollection<'a> {
+    pub(crate) fn new(buffer: &'a [u8]) -> Self {
+        let desc: &DirentDesc = unsafe { &*(buffer.as_ptr() as *const DirentDesc) };
+        Self {
+            data: buffer,
+            offset: 0,
+            total: desc.nameoff as usize / core::mem::size_of::<DirentDesc>(),
+        }
+    }
+    pub(crate) fn dirent(&self, index: usize) -> Option<Dirent<'a>> {
+        let descs: &'a [[u8; size_of::<DirentDesc>()]] =
+            unsafe { core::slice::from_raw_parts(self.data.as_ptr().cast(), self.total) };
+        if index >= self.total {
+            None
+        } else if index == self.total - 1 {
+            let desc = DirentDesc::from(descs[index]);
+            let len = self.data.len() - desc.nameoff as usize;
+            Some(Dirent {
+                desc,
+                name: &self.data[desc.nameoff as usize..(desc.nameoff as usize) + len],
+            })
+        } else {
+            let desc = DirentDesc::from(descs[index]);
+            let next_desc = DirentDesc::from(descs[index + 1]);
+            let len = (next_desc.nameoff - desc.nameoff) as usize;
+            Some(Dirent {
+                desc,
+                name: &self.data[desc.nameoff as usize..(desc.nameoff as usize) + len],
+            })
+        }
+    }
+    pub(crate) fn skip_dir(&mut self, offset: usize) {
+        self.offset += offset;
+    }
+    pub(crate) fn total(&self) -> usize {
+        self.total
+    }
+}
+
+impl<'a> Iterator for DirCollection<'a> {
+    type Item = Dirent<'a>;
+    fn next(&mut self) -> Option<Self::Item> {
+        self.dirent(self.offset).map(|x| {
+            self.offset += 1;
+            x
+        })
+    }
+}
+
+impl<'a> Dirent<'a> {
+    pub(crate) fn dirname(&self) -> &'a [u8] {
+        self.name
+    }
+}
-- 
2.46.0


