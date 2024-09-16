Return-Path: <linux-fsdevel+bounces-29475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F2097A331
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1011C221B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6341215853B;
	Mon, 16 Sep 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="mGxKwz3A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12B1581F2;
	Mon, 16 Sep 2024 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494974; cv=none; b=cgTpZF83+OcjD012/TFkIyUDt/olSSaWpHAPFUfBFwmEEgrFwXQyl+W4LxEXHFBga2idKvMu8diAIuyxjyHCGJy8FPF5YH2j8KBox0glggORyev+Ya72kVt2PAQ8Qz+EtWVRq3CxfPJ8+CPrMjd4xr0LXb4qjKgW2NHtrjJq5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494974; c=relaxed/simple;
	bh=nfHK1i9ph1376F4QA3EYzyMqATO930veypDKTSAKBl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1WRy+2m+iQ5mYDExgR2hLNofpphKKALhxZnRKami7ebGj0Z1bJp2o7YEBhlLBzWUtaGFq1midRg7EcJbKd6OxeQysEP3fxAbgbMFWn3+JbGBbQtktb8PPtc5QMQyLVxG9EK9QCek5Xn67xzzg5+qlWc45VPHg/PTlIBZoJn9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=mGxKwz3A; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7E2B6997C;
	Mon, 16 Sep 2024 09:56:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494971; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=fUBtB1guKBDyxePSsjzX2NyUyWv+dPs0ZXuq7FSRkmE=;
	b=mGxKwz3AdeaXEa+Zwv4zhcj0QPfvTzlnGjWzfjlWezQsRbE3bBoPx8/ftT/tdocBSMQ0fo
	LrFdFTZhsKHD4yaMuCHZTS5/ybTGly29AEwBdu/fikJDE7js+xJscqfqZQraDGnnqtOyn9
	JT4PHznx8/VKrZWoOMUin0TMDGF1dJXkk5AbGRHWKH6E1wLwglj4xm27jLAM0tDXwZN0tB
	85UzIuav1PuFzzBtLnF2Erfe3QQUzzCuqKjIUcXwazk1h58EJuxI0czudN6KA7IX3yOiTC
	bZQKi1P7XCNt7KmCcd9tbyvpKk0J/V9DbachkuYvPEiux2UDmPU7osSPjvDBEg==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 06/24] erofs: add alloc_helper in Rust
Date: Mon, 16 Sep 2024 21:55:23 +0800
Message-ID: <20240916135541.98096-7-toolmanp@tlmp.cc>
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

In normal rust, heap related operations are infallible meaning
that they do not throw errors and Rust will panic in usermode instead.
However in kernel, it will throw AllocError this module helps to
bridge the gaps and returns Errno universally.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs              |  1 +
 fs/erofs/rust/erofs_sys/alloc_helper.rs | 35 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/alloc_helper.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 34267ec7772d..c6fd7f78ac97 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -23,6 +23,7 @@
 /// to avoid naming conflicts.
 pub(crate) type PosixResult<T> = Result<T, Errno>;
 
+pub(crate) mod alloc_helper;
 pub(crate) mod errnos;
 pub(crate) mod inode;
 pub(crate) mod superblock;
diff --git a/fs/erofs/rust/erofs_sys/alloc_helper.rs b/fs/erofs/rust/erofs_sys/alloc_helper.rs
new file mode 100644
index 000000000000..05ef2018d379
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/alloc_helper.rs
@@ -0,0 +1,35 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+/// This module provides helper functions for the alloc crate
+/// Note that in linux kernel, the allocation is fallible however in userland it is not.
+/// Since most of the functions depend on infallible allocation, here we provide helper functions
+/// so that most of codes don't need to be changed.
+
+#[cfg(CONFIG_EROFS_FS = "y")]
+use kernel::prelude::*;
+
+#[cfg(not(CONFIG_EROFS_FS = "y"))]
+use alloc::vec;
+
+use super::*;
+use alloc::boxed::Box;
+use alloc::vec::Vec;
+
+pub(crate) fn push_vec<T>(v: &mut Vec<T>, value: T) -> PosixResult<()> {
+    v.push(value, GFP_KERNEL)
+        .map_or_else(|_| Err(Errno::ENOMEM), |_| Ok(()))
+}
+
+pub(crate) fn extend_from_slice<T: Clone>(v: &mut Vec<T>, slice: &[T]) -> PosixResult<()> {
+    v.extend_from_slice(slice, GFP_KERNEL)
+        .map_or_else(|_| Err(Errno::ENOMEM), |_| Ok(()))
+}
+
+pub(crate) fn heap_alloc<T>(value: T) -> PosixResult<Box<T>> {
+    Box::new(value, GFP_KERNEL).map_or_else(|_| Err(Errno::ENOMEM), |v| Ok(v))
+}
+
+pub(crate) fn vec_with_capacity<T: Default + Clone>(capacity: usize) -> PosixResult<Vec<T>> {
+    Vec::with_capacity(capacity, GFP_KERNEL).map_or_else(|_| Err(Errno::ENOMEM), |v| Ok(v))
+}
-- 
2.46.0


