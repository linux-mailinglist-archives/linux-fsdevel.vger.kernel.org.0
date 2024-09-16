Return-Path: <linux-fsdevel+bounces-29490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C39497A37F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C14B25BD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD6D15FA72;
	Mon, 16 Sep 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="XH3Ah7t4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306B15DBD5;
	Mon, 16 Sep 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495019; cv=none; b=OxlZ0lP6tdks5EOD6jE3OJqXKeOokZ+oWPckfLhPE9VFE+xS+A0nvRNOt2w31zIM8Ic05VDGCXzb/08n9VlVBOhSXc2WzE6eO72SM5VfJ5KTkhSzG81Qn4iY4nVlAcoZzhQ+mmoxx0BioFV/0wTjGNRDCvzf8GwJoNh4UUmZhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495019; c=relaxed/simple;
	bh=C1ZrNRNACCjWx55UqgSqRNkayTakd+sKpVAO9zBzvsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJiENmube0xBvHem3HvNBUe8QGEn3X0RK7f+LXEsCQ17nUwHhnsadSM/pJALmj4F79LogF1FN1yd+IVN5LW48jaauvMSlBZvKsraKYKkiG7Svx2zd9AK2ltpAmA8W2J1ifJGJAOmsKugzjvM9l8M8W/EthcHZtYr4ldzL3vmEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=XH3Ah7t4; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8826697C4;
	Mon, 16 Sep 2024 09:56:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495017; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TBJTDvYko+/iIPJGn9oa9UFP8352ieqw0qlVnvGk9ME=;
	b=XH3Ah7t4SBLcqo+8KnSh3HxrmkPHlBuTAmP7b3h1yVUBwKksZ+Ubxa+W/3dK8WnR4GYFaL
	fBCj01ajrvkvrX08TAB+rwGc3lzQOezj1NI79z0vMMGUJEwwQ+6JxMT1zql4dCuUD1+xSw
	qI7Wmb8+Jyi+AP/kSlIrKORBBr2mQDOefsvGjp3DK3MWPdi7fu1UboTPapiwZiZQ25hgF8
	aYe8WwCKZ3wOx+zqwq2vMNlaA8q0ldf3rwl8aiGiwQ4AKIGttuOZjn6mhE3QEfT51kJGdB
	cNsjRcklTvhCC9480oSqXyWn7Z7wLyCQR4JjeKroaq8Cg2hZK2UfxOP0StKvZg==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 10/24] erofs: add device_infos implementation in Rust
Date: Mon, 16 Sep 2024 21:56:20 +0800
Message-ID: <20240916135634.98554-11-toolmanp@tlmp.cc>
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


