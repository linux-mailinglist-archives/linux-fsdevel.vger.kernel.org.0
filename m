Return-Path: <linux-fsdevel+bounces-73668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D4CD1E892
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D72B83022391
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819F0396D1E;
	Wed, 14 Jan 2026 11:47:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB7396B63;
	Wed, 14 Jan 2026 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391270; cv=none; b=s2crQgWNmUAvsc51O/VSbNa8E7MhDN0a6JMhaIuO6tmGjjkEr0GchyHTmFEG0n3J7OA1PNpxCa/z0xpJz/Pxxm8eQusjonBF+OuFkdbmvHJ06S4mrT7g+dAmyCbuPo6IuRwXluRm+pspa0vORxBf5v85zduI0W0K/VpyVH7SOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391270; c=relaxed/simple;
	bh=vUACGgHmNQmYY9fzmjU05P8Eou5F6psC41/zyArJWmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxWJWrIPhP60EQdJ/ESIZ550L43InDC7d7RXXNwkNk25fxf8p24w8L9tJlq6haU1FXF5+wRzK0avLRzquKQA2M9O9ydVBzXwR/sTnTcoXW6lNUl0ndk2ZyROKBtXu5Qfvb7bdC+5iEoYwMwmNPhCGKCUZB52YrvMNVTxLtWNtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CF09339;
	Wed, 14 Jan 2026 03:47:41 -0800 (PST)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA3DD3F59E;
	Wed, 14 Jan 2026 03:47:44 -0800 (PST)
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
Subject: [PATCH v2 07/17] firmware: arm_scmi: Use new Telemetry traces
Date: Wed, 14 Jan 2026 11:46:11 +0000
Message-ID: <20260114114638.2290765-8-cristian.marussi@arm.com>
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

Track failed SHMTI accesses and received notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/telemetry.c | 57 ++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/telemetry.c b/drivers/firmware/arm_scmi/telemetry.c
index 16bcdcdc1dc3..443e032a3553 100644
--- a/drivers/firmware/arm_scmi/telemetry.c
+++ b/drivers/firmware/arm_scmi/telemetry.c
@@ -25,6 +25,8 @@
 #include "protocols.h"
 #include "notify.h"
 
+#include <trace/events/scmi.h>
+
 /* Updated only after ALL the mandatory features for that version are merged */
 #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
 
@@ -1366,8 +1368,10 @@ static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
 
 	/* Check for spec compliance */
 	if (USE_LINE_TS(payld) || USE_BLK_TS(payld) ||
-	    DATA_INVALID(payld) || (PAYLD_ID(payld) != 0))
+	    DATA_INVALID(payld) || (PAYLD_ID(payld) != 0)) {
+		trace_scmi_tlm_access(0, "BLK_TS_INVALID", 0, 0);
 		return;
+	}
 
 	/* A BLK_TS descriptor MUST be returned: it is found or it is crated */
 	bts = scmi_telemetry_blkts_lookup(ti->ph->dev, &ti->xa_bts, payld);
@@ -1376,6 +1380,9 @@ static void scmi_telemetry_tdcf_blkts_parse(struct telemetry_info *ti,
 
 	/* Update the descriptor with the lastest TS*/
 	scmi_telemetry_blkts_update(shmti->last_magic, bts);
+
+	trace_scmi_tlm_collect(bts->last_ts, (u64)payld,
+			       bts->last_magic, "SHMTI_BLK_TS");
 }
 
 static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
@@ -1393,8 +1400,10 @@ static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
 	/* Is thi DE ID know ? */
 	tde = scmi_telemetry_tde_lookup(ti, de_id);
 	if (!tde) {
-		if (mode != SCAN_DISCOVERY)
+		if (mode != SCAN_DISCOVERY) {
+			trace_scmi_tlm_access(de_id, "DE_INVALID", 0, 0);
 			return;
+		}
 
 		/* In SCAN_DISCOVERY mode we allocate new DEs for unknown IDs */
 		tde = scmi_telemetry_tde_get(ti, de_id);
@@ -1462,6 +1471,8 @@ static void scmi_telemetry_tdcf_data_parse(struct telemetry_info *ti,
 		tde->last_ts = tstamp;
 	else
 		tde->last_ts = 0;
+
+	trace_scmi_tlm_collect(0, tde->de.info->id, tde->last_val, "SHMTI_DE_UPDT");
 }
 
 static int scmi_telemetry_tdcf_line_parse(struct telemetry_info *ti,
@@ -1507,8 +1518,10 @@ static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
 		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
 
 		startm = TDCF_START_SEQ_GET(tdcf);
-		if (IS_BAD_START_SEQ(startm))
+		if (IS_BAD_START_SEQ(startm)) {
+			trace_scmi_tlm_access(0, "MSEQ_BADSTART", startm, 0);
 			continue;
+		}
 
 		/* On a BAD_SEQ this will be updated on the next attempt */
 		shmti->last_magic = startm;
@@ -1520,18 +1533,25 @@ static int scmi_telemetry_shmti_scan(struct telemetry_info *ti,
 
 			used_qwords = scmi_telemetry_tdcf_line_parse(ti, next,
 								     shmti, mode);
-			if (qwords < used_qwords)
+			if (qwords < used_qwords) {
+				trace_scmi_tlm_access(PAYLD_ID(next),
+						      "BAD_QWORDS", startm, 0);
 				return -EINVAL;
+			}
 
 			next += used_qwords * 8;
 			qwords -= used_qwords;
 		}
 
 		endm = TDCF_END_SEQ_GET(eplg);
+		if (startm != endm)
+			trace_scmi_tlm_access(0, "MSEQ_MISMATCH", startm, endm);
 	} while (startm != endm && --retries);
 
-	if (startm != endm)
+	if (startm != endm) {
+		trace_scmi_tlm_access(0, "TDCF_SCAN_FAIL", startm, endm);
 		return -EPROTO;
+	}
 
 	return 0;
 }
@@ -1923,6 +1943,8 @@ static void scmi_telemetry_scan_update(struct telemetry_info *ti, u64 ts)
 			tde->last_ts = tstamp;
 		else
 			tde->last_ts = 0;
+
+		trace_scmi_tlm_collect(ts, tde->de.info->id, tde->last_val, "FC_UPDATE");
 	}
 }
 
@@ -2001,8 +2023,11 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
 		fsleep((SCMI_TLM_TDCF_MAX_RETRIES - retries) * 1000);
 
 		startm = TDCF_START_SEQ_GET(tdcf);
-		if (IS_BAD_START_SEQ(startm))
+		if (IS_BAD_START_SEQ(startm)) {
+			trace_scmi_tlm_access(tde->de.info->id, "MSEQ_BADSTART",
+					      startm, 0);
 			continue;
+		}
 
 		/* Has anything changed at all at the SHMTI level ? */
 		scoped_guard(mutex, &tde->mtx) {
@@ -2018,11 +2043,16 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
 		if (DATA_INVALID(payld))
 			return -EINVAL;
 
-		if (IS_BLK_TS(payld))
+		if (IS_BLK_TS(payld)) {
+			trace_scmi_tlm_access(tde->de.info->id,
+					      "BAD_DE_META", 0, 0);
 			return -EINVAL;
+		}
 
-		if (PAYLD_ID(payld) != tde->de.info->id)
+		if (PAYLD_ID(payld) != tde->de.info->id) {
+			trace_scmi_tlm_access(tde->de.info->id, "DE_INVALID", 0, 0);
 			return -EINVAL;
+		}
 
 		/* Data is always valid since NOT handling BLK TS lines here */
 		*val = LINE_DATA_GET(&payld->l);
@@ -2046,10 +2076,16 @@ static int scmi_telemetry_tdcf_de_parse(struct telemetry_de *tde,
 		}
 
 		endm = TDCF_END_SEQ_GET(tde->eplg);
+		if (startm != endm)
+			trace_scmi_tlm_access(tde->de.info->id, "MSEQ_MISMATCH",
+					      startm, endm);
 	} while (startm != endm && --retries);
 
-	if (startm != endm)
+	if (startm != endm) {
+		trace_scmi_tlm_access(tde->de.info->id, "TDCF_DE_FAIL",
+				      startm, endm);
 		return -EPROTO;
+	}
 
 	guard(mutex)(&tde->mtx);
 	tde->last_magic = startm;
@@ -2230,6 +2266,9 @@ scmi_telemetry_msg_payld_process(struct telemetry_info *ti,
 			tde->last_ts = LINE_TSTAMP_GET(&payld->tsl);
 		else
 			tde->last_ts = 0;
+
+		trace_scmi_tlm_collect(timestamp, tde->de.info->id, tde->last_val,
+				       "MESSAGE");
 	}
 }
 
-- 
2.52.0


