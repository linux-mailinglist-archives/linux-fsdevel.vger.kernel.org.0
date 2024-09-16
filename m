Return-Path: <linux-fsdevel+bounces-29477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B715897A339
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FD71C21553
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2091586DB;
	Mon, 16 Sep 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="RD9Zrmy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D624B156654;
	Mon, 16 Sep 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494978; cv=none; b=NUduzQALRRogn1uAQOEW0Jx86tzCpAsEykT4JPslwXYe9IUkija2/PM98WV6eQnHlIdXSD7kNvU0BQvy5cxTGuRPyK7pM/CN3lChF+C77RsBM6hS3Qn/76xWcnca8gS2278jdx7r6vFXwGhBOif1P1t6RzMfZhi0i+C6YHhNQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494978; c=relaxed/simple;
	bh=0c66dwnUGs7UBAhZ/nX2CQVs5yJOB4tBeg1XqoqkzKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1GYRr1pFkr4O1/0R1N6njnDolWo7WLk+WJ2cTKLLDzpO/PlmmpS7ZCTLXz+0whIPEVv337u/QWZhj10YxjdGlny5ocPYmxmG5yElxZC5UXEUmZhynC3GTmYWHfAqSLeP2BV6BGC/3Ae2om5fEcv0fqK4ycJKwyI0xIgNklhF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=RD9Zrmy4; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCD7C6997E;
	Mon, 16 Sep 2024 09:56:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494976; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RpwAvNBL1BrrWM3+ylO6h2C6ZxDk5XDbbYWzUi+PA6A=;
	b=RD9Zrmy4bnAEImb3l+5RmIvtBv7zzpA5277tsz28NEc29kpPHV2TkQFR0iP47WKY+05mGt
	uDA2J3GSyTW2VhipdhYWfkSQzSJeu+leX6EWumOqkYQH78h8dxxt1k0zdaOW5l60w7D3eR
	snDYYM+IoWKGgJKxfcW+CRv56yQY7095GKS72xgakamKZWssSuKp7rrTFGMRChcVmV4EV2
	iezGjTojz87rgiQ00RMiTA73/kk326M23WBZ+3X6QUxCbCS4ipne+siy3ua8QkXsZAKqAI
	OPWnpud6JYZLZfj8fF5wVBAvQwKqZQ9WsDVtloLalbjXSAxci6+P69wNpm4RQw==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 08/24] erofs: add device data structure in Rust
Date: Mon, 16 Sep 2024 21:55:25 +0800
Message-ID: <20240916135541.98096-9-toolmanp@tlmp.cc>
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

This patch introduce device data structure in Rust.
It can later support chunk based block maps.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs         |  1 +
 fs/erofs/rust/erofs_sys/devices.rs | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/devices.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 8cca2cd9b75f..f1a1e491caec 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -25,6 +25,7 @@
 
 pub(crate) mod alloc_helper;
 pub(crate) mod data;
+pub(crate) mod devices;
 pub(crate) mod errnos;
 pub(crate) mod inode;
 pub(crate) mod superblock;
diff --git a/fs/erofs/rust/erofs_sys/devices.rs b/fs/erofs/rust/erofs_sys/devices.rs
new file mode 100644
index 000000000000..097676ee8720
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/devices.rs
@@ -0,0 +1,28 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use alloc::vec::Vec;
+
+/// Device specification.
+#[derive(Copy, Clone, Debug)]
+pub(crate) struct DeviceSpec {
+    pub(crate) tags: [u8; 64],
+    pub(crate) blocks: u32,
+    pub(crate) mapped_blocks: u32,
+}
+
+/// Device slot.
+#[derive(Copy, Clone, Debug)]
+#[repr(C)]
+pub(crate) struct DeviceSlot {
+    tags: [u8; 64],
+    blocks: u32,
+    mapped_blocks: u32,
+    reserved: [u8; 56],
+}
+
+/// Device information.
+pub(crate) struct DeviceInfo {
+    pub(crate) mask: u16,
+    pub(crate) specs: Vec<DeviceSpec>,
+}
-- 
2.46.0


