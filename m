Return-Path: <linux-fsdevel+bounces-29478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7AB97A33F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F681C21286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99CD158853;
	Mon, 16 Sep 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="CCH/7Wpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6781586FE;
	Mon, 16 Sep 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494980; cv=none; b=sMkU2FpdQR0zljTmJZcC4Q43LKN7hj/qaLJFaIbbHt5slDt7d7QwYJb7mpiNEtJxf0UDXCFdxrR7+HnHSoRau5J/vuFWjIn6Dj0mdMZVeA1+qXc+x3uXYaEsfU4Ue7UkaW5XkpyINR4xZ/nL69Rjf+niU9cbNN2SIuu/up1JosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494980; c=relaxed/simple;
	bh=C6bzJ0ahOVi4Lz5NDHXNa2g12EqOHhJgzseFPgoTZoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om5t4JTsgWz4KRQ8gRdn9BqHrpnlGMpvksBJEyhWcKkkYdtI62Tae9h65XJjVVmHRybyesx2zNGRoAoPCxvUwEbxuf1DWHyo+dNhtz8kMkfAg5aU16PJ5dND44iDKN1MUn9I/hQf0SFbPEdzNZTvr9j0UvlV9hdUOf+7vZP1VN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=CCH/7Wpl; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A972E6997D;
	Mon, 16 Sep 2024 09:56:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494977; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=CeM2RxQ3ayEheLUMCn9fl9h9UhYePHokORV1b9tMe8Y=;
	b=CCH/7WplQihI8IQSOeM+qSyheqlKc/+3ge+BVwwr3F5KemwNkoKCxNMRnQ5KEjxI4pHhEG
	Yp3l0ZbMtH6z/O9zF8Rc26nGuHUWn8bx19wkKPrt4BeXbonNQrPlz2DFpN7Q9YItP2rbj2
	q0bKdiKpmPkNoSNXo1wZlae5WbZLiFVfWLSkweVgwMI/m6ZJ2aDueAO/IUkcT+bEfDhNNG
	iAC0MfyYbPOKQX/767ZGpqgr2Cvkeb9Hykj33qkOFFhdAmX4ff24BsCfN/MMT1r1O/oCb5
	Abalb/CnbSKVm3eG06+rw6hM/nYxXm9ujXXKb34nWe2ZoiH2mDwYqR2uPTjBcQ==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 09/24] erofs: add continuous iterators in Rust
Date: Mon, 16 Sep 2024 21:55:26 +0800
Message-ID: <20240916135541.98096-10-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916135541.98096-1-toolmanp@tlmp.cc>
References: <20240916135541.98096-1-toolmanp@tlmp.cc>
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


