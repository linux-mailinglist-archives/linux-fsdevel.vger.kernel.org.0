Return-Path: <linux-fsdevel+bounces-29491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F9297A384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E675A1C251C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D88165F1D;
	Mon, 16 Sep 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="CFSckmI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54199161311;
	Mon, 16 Sep 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495021; cv=none; b=GnQC4X4oW5Bi5IotDC9Klg/J+Q9kPbdGJEsqY+JWKaHri5xA85fzXTVxOq8VW9p6CVmFaNGMe3dq1Ad8kSBP5pjhaGqBc5D2dlp1fMrcp+IVRI98nPgf2dCTO+BN7aIVWANpHePb2UnGQ/wita1FmUz0m4KDbXhT4iN1Za7z27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495021; c=relaxed/simple;
	bh=zTenHNDq1t83FwjgBfBRxwlMMD2Xhmw6ZkqOIIf8dik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3rWgRXU8qbRkNKNX5tQAyL13erKjvPz4QOX5WZEzarRzdtp2qg2hK92jjD+xu9syzqBXR6UhsRYQY5PQw/1OpfD3qpSRijuCm+q7kkgbWQZULolPdwusy/M0jM3l/KJr7P6PCW/rTrI0xyRkimHDP2p78O8pgqjwNzNvseZLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=CFSckmI4; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93C2F69845;
	Mon, 16 Sep 2024 09:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495019; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=F4hCBD/QFnbrfenytYFFJtYuvUkCDWy+jx5tXlowPUM=;
	b=CFSckmI4MUIPR9slBm8hO8DjCiZn8m3HjPaYgOVerbk8DEmUgIw9uVE85dm47JHVK0OQRI
	7MYVXmNEFJPIsUqwcQSjbSDy9kw0KiMRFJI3H8Sz5YX+L+ej0GwV0nO3CoNFUn3k5VxnSK
	8qCd3dKrDlY0aHo/90jKK/JJPfpi9WEFuS6Fy7eBnf38yI19S8LRwlIX6JVJJdAEHoKHDN
	WxP4HdUszJkuV08+XnKywMarGNMRm+QUOaaHev8dWlo5IcOJ8vIVc95+MfymXlzX/NKIvu
	K74GHUrHa3tW2dGbB7fbdK7GPji0+dCARhAzmPwA7yOy8HCN76mzygKk7gA5YA==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 11/24] erofs: add map data structure in Rust
Date: Mon, 16 Sep 2024 21:56:21 +0800
Message-ID: <20240916135634.98554-12-toolmanp@tlmp.cc>
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

This patch introduce core map flags and runtime map data structure
in Rust. This will later be used to do iomapping.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs     |  1 +
 fs/erofs/rust/erofs_sys/map.rs | 45 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/map.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index f1a1e491caec..15ed65866097 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -28,6 +28,7 @@
 pub(crate) mod devices;
 pub(crate) mod errnos;
 pub(crate) mod inode;
+pub(crate) mod map;
 pub(crate) mod superblock;
 pub(crate) mod xattrs;
 pub(crate) use errnos::Errno;
diff --git a/fs/erofs/rust/erofs_sys/map.rs b/fs/erofs/rust/erofs_sys/map.rs
new file mode 100644
index 000000000000..757e8083c8f1
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/map.rs
@@ -0,0 +1,45 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::*;
+pub(crate) const MAP_MAPPED: u32 = 0x0001;
+pub(crate) const MAP_META: u32 = 0x0002;
+pub(crate) const MAP_ENCODED: u32 = 0x0004;
+pub(crate) const MAP_FULL_MAPPED: u32 = 0x0008;
+pub(crate) const MAP_FRAGMENT: u32 = 0x0010;
+pub(crate) const MAP_PARTIAL_REF: u32 = 0x0020;
+
+#[derive(Debug, Default)]
+#[repr(C)]
+pub(crate) struct Segment {
+    pub(crate) start: Off,
+    pub(crate) len: Off,
+}
+
+#[derive(Debug, Default)]
+#[repr(C)]
+pub(crate) struct Map {
+    pub(crate) logical: Segment,
+    pub(crate) physical: Segment,
+    pub(crate) device_id: u16,
+    pub(crate) algorithm_format: u16,
+    pub(crate) map_type: MapType,
+}
+
+#[derive(Debug, Default)]
+pub(crate) enum MapType {
+    Meta,
+    #[default]
+    Normal,
+}
+
+impl From<MapType> for u32 {
+    fn from(value: MapType) -> Self {
+        match value {
+            MapType::Meta => MAP_META | MAP_MAPPED,
+            MapType::Normal => MAP_MAPPED,
+        }
+    }
+}
+
+pub(crate) type MapResult = PosixResult<Map>;
-- 
2.46.0


