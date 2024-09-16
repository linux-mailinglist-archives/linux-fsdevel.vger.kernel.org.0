Return-Path: <linux-fsdevel+bounces-29484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990597A368
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B5DFB244AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EA015AADB;
	Mon, 16 Sep 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="hMZLfuz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C91598EE;
	Mon, 16 Sep 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495008; cv=none; b=Mr8UKBBoZlJUqmKnaw78UO6BKXeoFNSi5Lkd7PRgOzfg86gRxxkvOeli2bXuNFk6fmv+56tDKX1c9p0zXI6q90Plo+37XhpBWXEA660b5o8pCa5iwd9/UX7m1iCsd3Y3ino4pBer3/ZRGKuNsSJGM/jXTDy/jcNXt9ajkuYsLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495008; c=relaxed/simple;
	bh=T87qpgWUFMOH9vDZIIusulZhnKGgYdYoqiUWGJAD3JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0EPds3ZZJSnLglVw1LjiifZPYVNWFF30LrLRKSasuqOIEswqmv/hP5D57wT1M/pCFflwiRnAVRmug0GZssjwW3NLprm2jcNND4CQR0HPI3oQPVjI7EHZIHb+jZz2zILBlFIhOhWS/F20PASoclhk2Kqy9coSnbdfJtdw+e+ixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=hMZLfuz+; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A48569845;
	Mon, 16 Sep 2024 09:56:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495006; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eYDsY4wqAO9NUWwayzJIYghS8a27BSxppsolaWA5lxs=;
	b=hMZLfuz+nzJ0b6NMqN/03JZBQ3BFcQ4AI/0MLge1ZfqiOD2kbyf35nTCJBxIzbnPeiRDjE
	nxyk31w8mGG0xDkJTUYl5NJgnnHcxatIUOQE3L9ZAvMgK582501s7ggAxJxtJ/+Yb9wBwU
	siG/Xy6r+u0CCcZUhYDIQgr9yHsOvstInV+BzE7j3BGytCQN1Mc7AS5+fIDbevxDRLkW8W
	DPwjegcm9Zsrg+6VcIpzt7jyphg9tvoU4xBwY2MayUAIJt2v7CTocYDaRMdU8F668wH9u7
	h9+9JHR/tT7GhX7aqjrAz/0LI0QIMWqcDF4xXIA58gbGkS2A3orsyImH1dbabQ==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 04/24] erofs: add xattrs data structure in Rust
Date: Mon, 16 Sep 2024 21:56:14 +0800
Message-ID: <20240916135634.98554-5-toolmanp@tlmp.cc>
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

This patch introduces on-disk and runtime data structure of Extended
Attributes implementation in erofs_sys crate. This will be later used to
implement the op handler.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs        |  12 +++
 fs/erofs/rust/erofs_sys/xattrs.rs | 124 ++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/xattrs.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 2bd1381da5ab..6f3c12665ed6 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -25,4 +25,16 @@
 
 pub(crate) mod errnos;
 pub(crate) mod superblock;
+pub(crate) mod xattrs;
 pub(crate) use errnos::Errno;
+
+/// Helper macro to round up or down a number.
+#[macro_export]
+macro_rules! round {
+    (UP, $x: expr, $y: expr) => {
+        ($x + $y - 1) / $y * $y
+    };
+    (DOWN, $x: expr, $y: expr) => {
+        ($x / $y) * $y
+    };
+}
diff --git a/fs/erofs/rust/erofs_sys/xattrs.rs b/fs/erofs/rust/erofs_sys/xattrs.rs
new file mode 100644
index 000000000000..d1a110ef10dd
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/xattrs.rs
@@ -0,0 +1,124 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use alloc::vec::Vec;
+
+/// The header of the xattr entry index.
+/// This is used to describe the superblock's xattrs collection.
+#[derive(Clone, Copy)]
+#[repr(C)]
+pub(crate) struct XAttrSharedEntrySummary {
+    pub(crate) name_filter: u32,
+    pub(crate) shared_count: u8,
+    pub(crate) reserved: [u8; 7],
+}
+
+impl From<[u8; 12]> for XAttrSharedEntrySummary {
+    fn from(value: [u8; 12]) -> Self {
+        Self {
+            name_filter: u32::from_le_bytes([value[0], value[1], value[2], value[3]]),
+            shared_count: value[4],
+            reserved: value[5..12].try_into().unwrap(),
+        }
+    }
+}
+
+pub(crate) const XATTR_ENTRY_SUMMARY_BUF: [u8; 12] = [0u8; 12];
+
+/// Represented as a inmemory memory entry index header used by SuperBlockInfo.
+pub(crate) struct XAttrSharedEntries {
+    pub(crate) name_filter: u32,
+    pub(crate) shared_indexes: Vec<u32>,
+}
+
+/// Represents the name index for infixes or prefixes.
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct XattrNameIndex(u8);
+
+impl core::cmp::PartialEq<u8> for XattrNameIndex {
+    fn eq(&self, other: &u8) -> bool {
+        if self.0 & EROFS_XATTR_LONG_PREFIX != 0 {
+            self.0 & EROFS_XATTR_LONG_MASK == *other
+        } else {
+            self.0 == *other
+        }
+    }
+}
+
+impl XattrNameIndex {
+    pub(crate) fn is_long(&self) -> bool {
+        self.0 & EROFS_XATTR_LONG_PREFIX != 0
+    }
+}
+
+impl From<u8> for XattrNameIndex {
+    fn from(value: u8) -> Self {
+        Self(value)
+    }
+}
+
+#[allow(clippy::from_over_into)]
+impl Into<usize> for XattrNameIndex {
+    fn into(self) -> usize {
+        if self.0 & EROFS_XATTR_LONG_PREFIX != 0 {
+            (self.0 & EROFS_XATTR_LONG_MASK) as usize
+        } else {
+            self.0 as usize
+        }
+    }
+}
+
+/// This is on-disk representation of xattrs entry header.
+/// This is used to describe one extended attribute.
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct XAttrEntryHeader {
+    pub(crate) suffix_len: u8,
+    pub(crate) name_index: XattrNameIndex,
+    pub(crate) value_len: u16,
+}
+
+impl From<[u8; 4]> for XAttrEntryHeader {
+    fn from(value: [u8; 4]) -> Self {
+        Self {
+            suffix_len: value[0],
+            name_index: value[1].into(),
+            value_len: u16::from_le_bytes(value[2..4].try_into().unwrap()),
+        }
+    }
+}
+
+/// Xattr Common Infix holds the prefix index in the first byte and all the common infix data in
+/// the rest of the bytes.
+pub(crate) struct XAttrInfix(pub(crate) Vec<u8>);
+
+impl XAttrInfix {
+    fn prefix_index(&self) -> u8 {
+        self.0[0]
+    }
+    fn name(&self) -> &[u8] {
+        &self.0[1..]
+    }
+}
+
+pub(crate) const EROFS_XATTR_LONG_PREFIX: u8 = 0x80;
+pub(crate) const EROFS_XATTR_LONG_MASK: u8 = EROFS_XATTR_LONG_PREFIX - 1;
+
+/// Supported xattr prefixes
+pub(crate) const EROFS_XATTRS_PREFIXS: [&[u8]; 7] = [
+    b"",
+    b"user.",
+    b"system.posix_acl_access",
+    b"system.posix_acl_default",
+    b"trusted.",
+    b"",
+    b"security.",
+];
+
+/// Represents the value of an xattr entry or the size of it if the buffer is present in the query.
+#[derive(Debug)]
+pub(crate) enum XAttrValue {
+    Buffer(usize),
+    Vec(Vec<u8>),
+}
-- 
2.46.0


