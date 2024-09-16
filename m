Return-Path: <linux-fsdevel+bounces-29486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491B97A377
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F531C234E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F9B15B143;
	Mon, 16 Sep 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="hYA3YLAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D615B0F4;
	Mon, 16 Sep 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495012; cv=none; b=Hwaj8ezTxt5IhdkJ+NFOLNE2t7yIysoKwzUl9qLIRLLhm24D8ntUcxgbnbGDd2BJQCJ5EI3d0wMc0l504NGb7hSyRurIVStN6S4cpvvHDKdWMccG4dq5ouejfKtfDbZ2HfRUTq4QtOYGCF05Rdwt0blDwBPuFX6si1Q9zFhWr3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495012; c=relaxed/simple;
	bh=nfHK1i9ph1376F4QA3EYzyMqATO930veypDKTSAKBl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6/kqnubb0suw2PX8g5Vd0mrvYfCXLbpUwu363n/7u1V2/YZMOZjL0tVz5xby45zDRmYUnmRoPMPohxDnsdWb6GVSBCYPlErjudTNe+VjidekaRcwMzxOkfvdEN6FTS5BxSK62avA508fZDZgBo7OJ6IVZDcgkcLl9v2FwGubX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=hYA3YLAk; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0652F698D9;
	Mon, 16 Sep 2024 09:56:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495010; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=fUBtB1guKBDyxePSsjzX2NyUyWv+dPs0ZXuq7FSRkmE=;
	b=hYA3YLAkGlfGNv/YjBVf4oINn07DQc3ryRFl4VhpDnrr268EyrbbQwq3nScNcWl/lTLpCV
	sIneI5zNeXEbBT1RHindRWghQsNWkOduHtBUjELOArq/fRqh05I0eYuCd+ConAUC3+Cur/
	V9on9OFM7by6VA9r6e+0CiQ2pqw7hNTDw2ejivQ8nZkqca29/K+50uFeO+59pg0azjc45y
	x/4xqKbVSXeFDMPj+ZI5gnulA1qGKDbK1FSdH8gfuCOhO9p9dLLV+T1MHsaMuSI51Orc+k
	ZUpEWSINDnW/xapVt8YxlBpq3mlTF+2T73Rj0Z+UChcyVuqtZ5OAAVmvVpoSWg==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 06/24] erofs: add alloc_helper in Rust
Date: Mon, 16 Sep 2024 21:56:16 +0800
Message-ID: <20240916135634.98554-7-toolmanp@tlmp.cc>
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


