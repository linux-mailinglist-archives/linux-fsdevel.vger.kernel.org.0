Return-Path: <linux-fsdevel+bounces-73663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537FD1E827
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D155300A9B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A34C396B8B;
	Wed, 14 Jan 2026 11:47:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16E396B63;
	Wed, 14 Jan 2026 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391251; cv=none; b=FDOlGnbTzSKYAkNtgyq2RyA0W5Ruh/Rb0pGG7yYJ0PcR5OdTM6KCL6B/j0dHbk8CEbF49MNqwsLknawhpiivGQGGGN/MbLr8Oex/f1nBZdgLIpgb/FEWpbTAkfNKjM5FKuqUfRuiS3Jb2yEokXr6ZXSHD9W5gClnOUEmuRuH2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391251; c=relaxed/simple;
	bh=uV9vtkOJEybjNf/MnA9A4HVD1UKZz+XltZIp8k2sA3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrfFzMHmeJcIgvbGsbYT8JGsASHG5tUu2OH0RkbCpXuB9GOBrQ5j1XQVC5dOHf19TSiS4gqEi4KTboxKNBB5Nxs+Gexk8PLKfuugExesHwKrrrVYA975oo8qpKNYvxxBON7+ixVXaLmWgceuzTGexmvNJ7C4LI3Xwybsbb3eGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 001D11424;
	Wed, 14 Jan 2026 03:47:22 -0800 (PST)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 340A13F59E;
	Wed, 14 Jan 2026 03:47:25 -0800 (PST)
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
Subject: [PATCH v2 02/17] firmware: arm_scmi: Reduce the scope of protocols mutex
Date: Wed, 14 Jan 2026 11:46:06 +0000
Message-ID: <20260114114638.2290765-3-cristian.marussi@arm.com>
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

Currently the mutex dedicated to the protection of the list of registered
protocols is held during all the protocol initialization phase.

Such a wide locking region is not needed and causes problem when trying to
initialize notifications from within a protocol initialization routine.

Reduce the scope of the protocol mutex.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1-->v2
 - Fixed improper mixed usage of cleanup and goto constructs
---
 drivers/firmware/arm_scmi/driver.c | 50 ++++++++++++++----------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 7e5429eff35d..b198c58da1dd 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -17,6 +17,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/export.h>
@@ -2123,7 +2124,6 @@ static int scmi_protocol_version_negotiate(struct scmi_protocol_handle *ph)
  * all resources management is handled via a dedicated per-protocol devres
  * group.
  *
- * Context: Assumes to be called with @protocols_mtx already acquired.
  * Return: A reference to a freshly allocated and initialized protocol instance
  *	   or ERR_PTR on failure. On failure the @proto reference is at first
  *	   put using @scmi_protocol_put() before releasing all the devres group.
@@ -2162,8 +2162,10 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	if (ret)
 		goto clean;
 
-	ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1,
-			GFP_KERNEL);
+	/* Finally register the initialized protocol */
+	mutex_lock(&info->protocols_mtx);
+	ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1, GFP_KERNEL);
+	mutex_unlock(&info->protocols_mtx);
 	if (ret != proto->id)
 		goto clean;
 
@@ -2226,27 +2228,25 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 static struct scmi_protocol_instance * __must_check
 scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 {
-	struct scmi_protocol_instance *pi;
 	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol *proto;
 
-	mutex_lock(&info->protocols_mtx);
-	pi = idr_find(&info->protocols, protocol_id);
-
-	if (pi) {
-		refcount_inc(&pi->users);
-	} else {
-		const struct scmi_protocol *proto;
+	scoped_guard(mutex, &info->protocols_mtx) {
+		struct scmi_protocol_instance *pi;
 
-		/* Fails if protocol not registered on bus */
-		proto = scmi_protocol_get(protocol_id, &info->version);
-		if (proto)
-			pi = scmi_alloc_init_protocol_instance(info, proto);
-		else
-			pi = ERR_PTR(-EPROBE_DEFER);
+		pi = idr_find(&info->protocols, protocol_id);
+		if (pi) {
+			refcount_inc(&pi->users);
+			return pi;
+		}
 	}
-	mutex_unlock(&info->protocols_mtx);
 
-	return pi;
+	/* Fails if protocol not registered on bus */
+	proto = scmi_protocol_get(protocol_id, &info->version);
+	if (!proto)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return scmi_alloc_init_protocol_instance(info, proto);
 }
 
 /**
@@ -2277,10 +2277,11 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct scmi_protocol_instance *pi;
 
-	mutex_lock(&info->protocols_mtx);
-	pi = idr_find(&info->protocols, protocol_id);
-	if (WARN_ON(!pi))
-		goto out;
+	scoped_guard(mutex, &info->protocols_mtx) {
+		pi = idr_find(&info->protocols, protocol_id);
+		if (WARN_ON(!pi))
+			return;
+	}
 
 	if (refcount_dec_and_test(&pi->users)) {
 		void *gid = pi->gid;
@@ -2299,9 +2300,6 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
 		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
 			protocol_id);
 	}
-
-out:
-	mutex_unlock(&info->protocols_mtx);
 }
 
 void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
-- 
2.52.0


