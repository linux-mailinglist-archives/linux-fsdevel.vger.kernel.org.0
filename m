Return-Path: <linux-fsdevel+bounces-29488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799AC97A37B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABAF21C24BD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85CA15CD55;
	Mon, 16 Sep 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="gntO7RG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F015C128;
	Mon, 16 Sep 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495016; cv=none; b=boYl/+neym6MGFtvdaq2Ym361Md9g9nmma9FtvG68PPtnNR85UzVRkRvNyhFiu+9C6D10s52K4dAXU1TVxco6VBiFInGySy3YZDZMIh20lV1LlwFooOI0JQQb0AJVC+Xn0agvrsKNssr6UnALxVg88iorvNddxFrv/IUw9fh7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495016; c=relaxed/simple;
	bh=0c66dwnUGs7UBAhZ/nX2CQVs5yJOB4tBeg1XqoqkzKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRFsmY+zPPURyWhXLeysYX+dPvsEuGBZJNWvvgADUZgRDxOhnKyevPd15eGblgnwZhQ79uLirzoNAvX0pDMir0tihZ11eVOrPMD1M6gMlPES0I1ETf8a0NjnRfMGPjo0SDRpcv2A+qJaR9WCPtSo4Xz72pfH+s22zlQlVYXK8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=gntO7RG+; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D356F697C4;
	Mon, 16 Sep 2024 09:56:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495014; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RpwAvNBL1BrrWM3+ylO6h2C6ZxDk5XDbbYWzUi+PA6A=;
	b=gntO7RG+naT7UAbmN9YrOU7lFOnX6O7m9wdBElz71oXY/SvrFQPdgeh91hNsJqCtn6pwy4
	50ZUtxmlhVTf5oHnbw9y3C35Twg+2gajp9ksrcy777rB/12VpaL3VeI1voDg2npj+iyKUP
	uZT1Bt+vRqHJft7wmTCzNk6IW9qlTpu/oUGSFnEBM2Z+2YDAbQc9pFBxtn/nqVS1PDSMHG
	VRUdsVTxGTiUZ9I5Tc5kEbPwyBGnhzauQanUdZXaQB8xpL53OheHsEcVQIFviGCznCDSX9
	8iv9jVzAoYzTupEffpGl6bB0lSLXlJbrLfjayGtXQYCJT6jEEi4JozVGHjRHyg==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 08/24] erofs: add device data structure in Rust
Date: Mon, 16 Sep 2024 21:56:18 +0800
Message-ID: <20240916135634.98554-9-toolmanp@tlmp.cc>
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


