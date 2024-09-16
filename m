Return-Path: <linux-fsdevel+bounces-29489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6109297A37E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0ACFB25A4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33C315E5CC;
	Mon, 16 Sep 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="OI84jiwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7515CD4A;
	Mon, 16 Sep 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495018; cv=none; b=AohSeG95OCS2slzLcp6+nMudB5RxACvLNlMf3VenxJcyEHUesnE6+KcvkDHiE5CB95APv9p6EtcYYgo8W7UOJFvMAgY6cKIiXR6l2UoDK519b2sEmRAZYSS0gleHrh8Z22nPzVliqY1vnuuoi8dbPvUe8PJXk96gvDAJe1NNa8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495018; c=relaxed/simple;
	bh=C6bzJ0ahOVi4Lz5NDHXNa2g12EqOHhJgzseFPgoTZoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT/RfU86s52CG39tUb7OuStpSihueosk/sPG3SRf1ctvBWWCTFuL9jTyOojfkxl4eRKsMZa3brKHTerxAjOv/DZReIS6Zovww2ggCBN/uymnhsBv7QsbbWrpYHBDXogW1Q+y8FgQYk1Mk5V5dDfSwvA4EcJ8BMft8tmc39Kf25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=OI84jiwE; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2F7F6984E;
	Mon, 16 Sep 2024 09:56:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495016; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=CeM2RxQ3ayEheLUMCn9fl9h9UhYePHokORV1b9tMe8Y=;
	b=OI84jiwEAZ7ZEOLluM+fIqX1Srps1RtOtX3VqfVlm4NGXwfbaD373VS/xNCdDmM/hiGYDZ
	OHX/N0Vj2xsYcLKNElDkLkxxhMbOocc0YXu8NiK8WHl784LfdiZ3VeREs4qZgrGs6gcrCr
	5SQ4cQOXbMAAWxSGTv6DB9kQD61+qf/9K9eBUDSMatJxLDWSaO4VsSF76v9Rj5+M+tvaEZ
	uvJYeTYhvh+ddlt/XjZ447m9WCXe1xX/gZKjvoJKGVc4+fL9qq5n35kSNdvH/dj/Xrf2Ni
	xyAHcPUesRUNe95B9viv+6x83gLqH4DrrdC8RgHWYKqQZy13ntEZzFiynr/o2g==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 09/24] erofs: add continuous iterators in Rust
Date: Mon, 16 Sep 2024 21:56:19 +0800
Message-ID: <20240916135634.98554-10-toolmanp@tlmp.cc>
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

This patch adds a special iterator that is capable of iterating over a
memory region in the granularity of a common page. This can be later
used to read device buffer or fast symlink.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/data.rs               |  2 +
 fs/erofs/rust/erofs_sys/data/raw_iters.rs     |  6 ++
 .../rust/erofs_sys/data/raw_iters/ref_iter.rs | 68 +++++++++++++++++++
 .../rust/erofs_sys/data/raw_iters/traits.rs   | 13 ++++
 4 files changed, 89 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs

diff --git a/fs/erofs/rust/erofs_sys/data.rs b/fs/erofs/rust/erofs_sys/data.rs
index 284c8b1f3bd4..483f3204ce42 100644
--- a/fs/erofs/rust/erofs_sys/data.rs
+++ b/fs/erofs/rust/erofs_sys/data.rs
@@ -1,6 +1,8 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 pub(crate) mod backends;
+pub(crate) mod raw_iters;
+use super::superblock::*;
 use super::*;
 
 /// Represent some sort of generic data source. This cound be file, memory or even network.
diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters.rs b/fs/erofs/rust/erofs_sys/data/raw_iters.rs
new file mode 100644
index 000000000000..8f3bd250d252
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters.rs
@@ -0,0 +1,6 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+pub(crate) mod ref_iter;
+mod traits;
+pub(crate) use traits::*;
diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs b/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
new file mode 100644
index 000000000000..5aa2b7f44f3d
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
@@ -0,0 +1,68 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::super::*;
+use super::*;
+
+/// Continous Ref Buffer Iterator which iterates over a range of disk addresses within the
+/// the temp block size. Since the temp block is always the same size as page and it will not
+/// overflow.
+pub(crate) struct ContinuousRefIter<'a, B>
+where
+    B: Backend,
+{
+    sb: &'a SuperBlock,
+    backend: &'a B,
+    offset: Off,
+    len: Off,
+}
+
+impl<'a, B> ContinuousRefIter<'a, B>
+where
+    B: Backend,
+{
+    pub(crate) fn new(sb: &'a SuperBlock, backend: &'a B, offset: Off, len: Off) -> Self {
+        Self {
+            sb,
+            backend,
+            offset,
+            len,
+        }
+    }
+}
+
+impl<'a, B> Iterator for ContinuousRefIter<'a, B>
+where
+    B: Backend,
+{
+    type Item = PosixResult<RefBuffer<'a>>;
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.len == 0 {
+            return None;
+        }
+        let accessor = self.sb.blk_access(self.offset);
+        let len = accessor.len.min(self.len);
+        let result: Option<Self::Item> = self.backend.as_buf(self.offset, len).map_or_else(
+            |e| Some(Err(e)),
+            |buf| {
+                self.offset += len;
+                self.len -= len;
+                Some(Ok(buf))
+            },
+        );
+        result
+    }
+}
+
+impl<'a, B> ContinuousBufferIter<'a> for ContinuousRefIter<'a, B>
+where
+    B: Backend,
+{
+    fn advance_off(&mut self, offset: Off) {
+        self.offset += offset;
+        self.len -= offset
+    }
+    fn eof(&self) -> bool {
+        self.len == 0
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs b/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
new file mode 100644
index 000000000000..90b6a51658a9
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
@@ -0,0 +1,13 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::super::*;
+
+/// Represents a basic iterator over a range of bytes from data backends.
+/// Note that this is skippable and can be used to move the iterator's cursor forward.
+pub(crate) trait ContinuousBufferIter<'a>:
+    Iterator<Item = PosixResult<RefBuffer<'a>>>
+{
+    fn advance_off(&mut self, offset: Off);
+    fn eof(&self) -> bool;
+}
-- 
2.46.0


