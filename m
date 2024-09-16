Return-Path: <linux-fsdevel+bounces-29476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB0497A336
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BBA1F22E81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14538158550;
	Mon, 16 Sep 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="lWj1RcoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C315852E;
	Mon, 16 Sep 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494976; cv=none; b=QUf1XNww2hnnBUTWKBS+p6MOfTSuvK7srWuriBYkHeOR6qmRiJ+3kkBJ3FsxJWZ/vrKQbwFQpq51gLJ0QW5f3k4qmvX86QdpQ/OPSP25OTaYyq+ovQkpYnX5PvvwD+7rId1Ag7TVXYhm3sOPBlNkp2ohi7XmXUXVVs/yIoK+V60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494976; c=relaxed/simple;
	bh=H9qZQ6sPOX6lomGbiY5NWabke+KIbETnJDwauhJvUys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPzDVI3kFiWwUKhKRyJFV4tfMyrZS97JlPtLEQzShRCyv3vpRzfvFCYr6PyKeiGD0HUhmMgT6B2Ea81PEoTjVpOBoN4B7pKXne0b0as4DlDXDl7qB0JJGMTsOe/I/lXzFe7efuKj2r5UZDPuJo0J1tgo5tyv3cwyWTLICEbyX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=lWj1RcoQ; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D8A26997B;
	Mon, 16 Sep 2024 09:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494973; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RkMMOXQTsmanQe52UgGZbvf6dLNC+ICFQfOIzTuSzMo=;
	b=lWj1RcoQuWBLQcg52cSVUJlekfGYmj3eyjhUX1zRLg5iPFQua2BXf+5dlwA0+Lc8jXT9+y
	mhEoRsnJaaH9X7lCI38wRpiDni2rp/BQJ5lwFewaK/pvR610KrpNG/NUkgNhKcmNYCJmAp
	b1pfLeNHdJMtbkMKxyFkG6Rqxab08HRTEfs423n/2xiL/Zoa/un+P7GvIXjqp/YPsL1b35
	+0j+IVX4g+2Xdb3m3fIQytqD5IHifDEru+0sCOsNgHPAmP2NBWUf0vUkqvFNw3paqDEIKs
	FNQAp23to/z/F9G43nJebIYU2LBl0ZXgWAeJaOH/rF0yRVy7SO6iIz8jfifnAw==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 07/24] erofs: add data abstraction in Rust
Date: Mon, 16 Sep 2024 21:55:24 +0800
Message-ID: <20240916135541.98096-8-toolmanp@tlmp.cc>
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

Introduce Buffer, Source, Backend traits.

Implement Uncompressed Backend and RefBuffer to be
used in future data operations.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs                    |  1 +
 fs/erofs/rust/erofs_sys/data.rs               | 62 +++++++++++++++++++
 fs/erofs/rust/erofs_sys/data/backends.rs      |  4 ++
 .../erofs_sys/data/backends/uncompressed.rs   | 39 ++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/data.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/backends.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/backends/uncompressed.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index c6fd7f78ac97..8cca2cd9b75f 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -24,6 +24,7 @@
 pub(crate) type PosixResult<T> = Result<T, Errno>;
 
 pub(crate) mod alloc_helper;
+pub(crate) mod data;
 pub(crate) mod errnos;
 pub(crate) mod inode;
 pub(crate) mod superblock;
diff --git a/fs/erofs/rust/erofs_sys/data.rs b/fs/erofs/rust/erofs_sys/data.rs
new file mode 100644
index 000000000000..284c8b1f3bd4
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data.rs
@@ -0,0 +1,62 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+pub(crate) mod backends;
+use super::*;
+
+/// Represent some sort of generic data source. This cound be file, memory or even network.
+/// Note that users should never use this directly please use backends instead.
+pub(crate) trait Source {
+    fn fill(&self, data: &mut [u8], offset: Off) -> PosixResult<u64>;
+    fn as_buf<'a>(&'a self, offset: Off, len: Off) -> PosixResult<RefBuffer<'a>>;
+}
+
+/// Represents a generic data access backend that is backed by some sort of data source.
+/// This often has temporary buffers to decompress the data from the data source.
+/// The method signatures are the same as those of the Source trait.
+pub(crate) trait Backend {
+    fn fill(&self, data: &mut [u8], offset: Off) -> PosixResult<u64>;
+    fn as_buf<'a>(&'a self, offset: Off, len: Off) -> PosixResult<RefBuffer<'a>>;
+}
+
+/// Represents a buffer trait which can yield its internal reference or be casted as an iterator of
+/// DirEntries.
+pub(crate) trait Buffer {
+    fn content(&self) -> &[u8];
+}
+
+/// Represents a buffer that holds a reference to a slice of data that
+/// is borrowed from the thin air.
+pub(crate) struct RefBuffer<'a> {
+    buf: &'a [u8],
+    start: usize,
+    len: usize,
+    put_buf: fn(*mut core::ffi::c_void),
+}
+
+impl<'a> Buffer for RefBuffer<'a> {
+    fn content(&self) -> &[u8] {
+        &self.buf[self.start..self.start + self.len]
+    }
+}
+
+impl<'a> RefBuffer<'a> {
+    pub(crate) fn new(
+        buf: &'a [u8],
+        start: usize,
+        len: usize,
+        put_buf: fn(*mut core::ffi::c_void),
+    ) -> Self {
+        Self {
+            buf,
+            start,
+            len,
+            put_buf,
+        }
+    }
+}
+
+impl<'a> Drop for RefBuffer<'a> {
+    fn drop(&mut self) {
+        (self.put_buf)(self.buf.as_ptr() as *mut core::ffi::c_void)
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/data/backends.rs b/fs/erofs/rust/erofs_sys/data/backends.rs
new file mode 100644
index 000000000000..3249f1af8be7
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/backends.rs
@@ -0,0 +1,4 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+pub(crate) mod uncompressed;
diff --git a/fs/erofs/rust/erofs_sys/data/backends/uncompressed.rs b/fs/erofs/rust/erofs_sys/data/backends/uncompressed.rs
new file mode 100644
index 000000000000..c1b1a60258f8
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/backends/uncompressed.rs
@@ -0,0 +1,39 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::super::*;
+
+pub(crate) struct UncompressedBackend<T>
+where
+    T: Source,
+{
+    source: T,
+}
+
+impl<T> Backend for UncompressedBackend<T>
+where
+    T: Source,
+{
+    fn fill(&self, data: &mut [u8], offset: Off) -> PosixResult<u64> {
+        self.source.fill(data, offset)
+    }
+
+    fn as_buf<'a>(&'a self, offset: Off, len: Off) -> PosixResult<RefBuffer<'a>> {
+        self.source.as_buf(offset, len)
+    }
+}
+
+impl<T: Source> UncompressedBackend<T> {
+    pub(crate) fn new(source: T) -> Self {
+        Self { source }
+    }
+}
+
+impl<T> From<T> for UncompressedBackend<T>
+where
+    T: Source,
+{
+    fn from(value: T) -> Self {
+        Self::new(value)
+    }
+}
-- 
2.46.0


