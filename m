Return-Path: <linux-fsdevel+bounces-29479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4BB97A342
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B161286273
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFCB158A04;
	Mon, 16 Sep 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="JG0YywNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EBF156654;
	Mon, 16 Sep 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494981; cv=none; b=LXumfHqSiH6NmjyKMc59pi+8sGDcmpGk7UKeCEgD2e1yM1kbV08LWX1FHrSA3Lys0GJ/APCGApQLpoNcboNjZhZiFSNTYOW/3Wju77XXi0l+zu0O4jZ46akfAlClwopA+8r3DZPsDjZpkthG0nBJPm9f/rem246gL+g50ZgaVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494981; c=relaxed/simple;
	bh=C1ZrNRNACCjWx55UqgSqRNkayTakd+sKpVAO9zBzvsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hsh7Og7ZyG8gxvrYW0RkT2ywQxXjN6QwzGr3exVzVz6eoSKy4G/+JIQywANkdCjzUddcwQGmkPmZRIG8c90S1CxHhBcQLx1KdApXsKijbasvVoc6iNrlCWYXiHAOZwzeBRqvvYY+B7+wp1SVtzrt/73F8p1396QGWXTL1S7wPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=JG0YywNm; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76EE76997F;
	Mon, 16 Sep 2024 09:56:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494979; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TBJTDvYko+/iIPJGn9oa9UFP8352ieqw0qlVnvGk9ME=;
	b=JG0YywNmLao0k+8IkcmVMo1Tn7rk9cAoA/a1PrlMTUK/v/hLtORzSDc9yFLe7400qUxPlC
	MkjpSLGmtgq6XCcw9gcFCrKWn+V2JM0xqTm2dcI0+qnF9aS40Q9WIHJrZHXdygoyTaaQ8Z
	P95rw7havM9mbyYDXxu4/7K/TSXLT3MumjiadDjOaUe/ObcxklMdAsEUpcYDmp48F6vgWi
	vKVKIMQ6OHP2Vh8abqjXykdcWiiFMC7u84n8ED/9mBPaJKwXmNfPDSg83VAEA8mZjKzDZC
	JNgvi6SCATgor+5JvNps3qtIWoLk9cBufJZtCr0SDVwo0dtiE9IrmeddrLPMLA==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 10/24] erofs: add device_infos implementation in Rust
Date: Mon, 16 Sep 2024 21:55:27 +0800
Message-ID: <20240916135541.98096-11-toolmanp@tlmp.cc>
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

Add device_infos implementation in rust. It will later be used
to be put inside the SuperblockInfo. This mask and spec can later
be used to chunk-based image file block mapping.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/devices.rs | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/erofs/rust/erofs_sys/devices.rs b/fs/erofs/rust/erofs_sys/devices.rs
index 097676ee8720..7495164c7bd0 100644
--- a/fs/erofs/rust/erofs_sys/devices.rs
+++ b/fs/erofs/rust/erofs_sys/devices.rs
@@ -1,6 +1,10 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
+use super::alloc_helper::*;
+use super::data::raw_iters::*;
+use super::data::*;
+use super::*;
 use alloc::vec::Vec;
 
 /// Device specification.
@@ -21,8 +25,51 @@ pub(crate) struct DeviceSlot {
     reserved: [u8; 56],
 }
 
+impl From<[u8; 128]> for DeviceSlot {
+    fn from(data: [u8; 128]) -> Self {
+        Self {
+            tags: data[0..64].try_into().unwrap(),
+            blocks: u32::from_le_bytes([data[64], data[65], data[66], data[67]]),
+            mapped_blocks: u32::from_le_bytes([data[68], data[69], data[70], data[71]]),
+            reserved: data[72..128].try_into().unwrap(),
+        }
+    }
+}
+
 /// Device information.
 pub(crate) struct DeviceInfo {
     pub(crate) mask: u16,
     pub(crate) specs: Vec<DeviceSpec>,
 }
+
+pub(crate) fn get_device_infos<'a>(
+    iter: &mut (dyn ContinuousBufferIter<'a> + 'a),
+) -> PosixResult<DeviceInfo> {
+    let mut specs = Vec::new();
+    for data in iter {
+        let buffer = data?;
+        let mut cur: usize = 0;
+        let len = buffer.content().len();
+        while cur + 128 <= len {
+            let slot_data: [u8; 128] = buffer.content()[cur..cur + 128].try_into().unwrap();
+            let slot = DeviceSlot::from(slot_data);
+            cur += 128;
+            push_vec(
+                &mut specs,
+                DeviceSpec {
+                    tags: slot.tags,
+                    blocks: slot.blocks,
+                    mapped_blocks: slot.mapped_blocks,
+                },
+            )?;
+        }
+    }
+
+    let mask = if specs.is_empty() {
+        0
+    } else {
+        (1 << (specs.len().ilog2() + 1)) - 1
+    };
+
+    Ok(DeviceInfo { mask, specs })
+}
-- 
2.46.0


