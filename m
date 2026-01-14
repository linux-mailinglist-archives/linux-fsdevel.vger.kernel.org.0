Return-Path: <linux-fsdevel+bounces-73664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430ED1E871
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B927A3015DC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF99396D1E;
	Wed, 14 Jan 2026 11:47:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C9396B7B;
	Wed, 14 Jan 2026 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391253; cv=none; b=JVaVX4vigzY6l4KvPtv9wr2YByF893W9/4ptVEXR4kePaQqnBBlpuKgklSwnf9k9ggqkJEcsNdwjRZKFtz/teyHc66QDKAeJ6YYVe0D5H++qC2e11rPzdjsAUzs+/1rIhGdpA44ZIfAW9QWvVyKsxSN8jy8SHcid9pXkO31Q3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391253; c=relaxed/simple;
	bh=/76nAyObaQ5FpN+crLyZke6FddrHAlBATqCNYda0n8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj8KQtIWpINa7UX8tsQPXVqGObBZjnVhAZgvja7i5idUsiZR0Rq/GCzbGYqOmgXRuIiAeS2Nm4a/i/trCfGBtHeJNY10MpRhQSWEy+daxHbgOya2zrmIDBWy81WqBpZC8V+85BrOEEvJHXGfcZ2YwFEvqKq41J1fJY8tFsUtAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 222DE497;
	Wed, 14 Jan 2026 03:47:18 -0800 (PST)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56B503F59E;
	Wed, 14 Jan 2026 03:47:21 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	jonathan.cameron@huawei.com,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 01/17] firmware: arm_scmi: Define a common SCMI_MAX_PROTOCOLS value
Date: Wed, 14 Jan 2026 11:46:05 +0000
Message-ID: <20260114114638.2290765-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114114638.2290765-1-cristian.marussi@arm.com>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a common definition of SCMI_MAX_PROTOCOLS and use it all over the
SCMI stack.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/notify.c | 4 +---
 include/linux/scmi_protocol.h      | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index dee9f238f6fd..78e9e27dc9ec 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -94,8 +94,6 @@
 #include "common.h"
 #include "notify.h"
 
-#define SCMI_MAX_PROTO		256
-
 #define PROTO_ID_MASK		GENMASK(31, 24)
 #define EVT_ID_MASK		GENMASK(23, 16)
 #define SRC_ID_MASK		GENMASK(15, 0)
@@ -1673,7 +1671,7 @@ int scmi_notification_init(struct scmi_handle *handle)
 	ni->gid = gid;
 	ni->handle = handle;
 
-	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
+	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTOCOLS,
 						sizeof(char *), GFP_KERNEL);
 	if (!ni->registered_protocols)
 		goto err;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index aafaac1496b0..c6efe4f371ac 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -926,8 +926,11 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_VOLTAGE = 0x17,
 	SCMI_PROTOCOL_POWERCAP = 0x18,
 	SCMI_PROTOCOL_PINCTRL = 0x19,
+	SCMI_PROTOCOL_LAST = 0x7f,
 };
 
+#define SCMI_MAX_PROTOCOLS	256
+
 enum scmi_system_events {
 	SCMI_SYSTEM_SHUTDOWN,
 	SCMI_SYSTEM_COLDRESET,
-- 
2.52.0


