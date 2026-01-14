Return-Path: <linux-fsdevel+bounces-73666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 891CBD1E842
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC1CC301A223
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528F397AA6;
	Wed, 14 Jan 2026 11:47:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E6E395263;
	Wed, 14 Jan 2026 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391258; cv=none; b=kiezfaHEd57Tjpg1BivHS5f2aNyrPrc/knt1KYz+Du/8LMHIsLl4frkK+nl5ErMz+ZnpTudfrsRajxSPSHDP2/ca9bLxP1kIhS2YSOT/jaj7GvYfHMp92nxakN5nmKjpCfKd3ZsyjaUMxntZ7DS2J+WRqL/AqRcLatyHXrXOZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391258; c=relaxed/simple;
	bh=dUcNvpWFfrmBTMkcoYTsFq6XSacuMpXHDicNGslXPwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enmeIV7a5EWdOa0Y6E4ObCo68Ygl6T3+201Q5nx1XFbRy63Yyd2QOGVymAymKxpd15rx2eauLP0lVRnzJehYaQDtZajNOgaBSBOmnMq4ESqqkMPQcAoNKXnVDYuG64L/klzpkmwxa7xbqfJd3NXkrZN063VyfxQY96dBvrh4i5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2C79497;
	Wed, 14 Jan 2026 03:47:29 -0800 (PST)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6C8D3F59E;
	Wed, 14 Jan 2026 03:47:32 -0800 (PST)
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
Subject: [PATCH v2 04/17] uapi: Add ARM SCMI definitions
Date: Wed, 14 Jan 2026 11:46:08 +0000
Message-ID: <20260114114638.2290765-5-cristian.marussi@arm.com>
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

Add a number of structures and ioctls definitions used by the ARM
SCMI Telemetry protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
 - Added proper __counted_by marks
 - Fixed a few dox comments
 - Renamed reserved[] fields to pad[]
---
 MAINTAINERS               |   1 +
 include/uapi/linux/scmi.h | 287 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 288 insertions(+)
 create mode 100644 include/uapi/linux/scmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 12f49de7fe03..1c0ccaddc3f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25392,6 +25392,7 @@ F:	drivers/regulator/scmi-regulator.c
 F:	drivers/reset/reset-scmi.c
 F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
+F:	include/uapi/linux/scmi.h
 F:	include/uapi/linux/virtio_scmi.h
 
 SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX Extension Message Protocol drivers
diff --git a/include/uapi/linux/scmi.h b/include/uapi/linux/scmi.h
new file mode 100644
index 000000000000..e4e9939a1bf8
--- /dev/null
+++ b/include/uapi/linux/scmi.h
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2026 ARM Ltd.
+ */
+#ifndef _UAPI_LINUX_SCMI_H
+#define _UAPI_LINUX_SCMI_H
+
+/*
+ * Userspace interface SCMI Telemetry
+ */
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define SCMI_TLM_DE_IMPL_MAX_DWORDS	4
+
+#define SCMI_TLM_GRP_INVALID            0xFFFFFFFF
+
+/**
+ * scmi_tlm_base_info - Basic info about an instance
+ *
+ * @version: SCMI Telemetry protocol version
+ * @de_impl_version: SCMI Telemetry DE implementation revision
+ * @num_de: Number of defined DEs
+ * @num_groups Number of defined DEs groups
+ * @num_intervals: Number of update intervals available (instance-level)
+ * @flags: Instance specific feature-support bitmap
+ *
+ * Used by:
+ *	RO - SCMI_TLM_GET_INFO
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_base_info {
+	__u32 version;
+	__u32 de_impl_version[SCMI_TLM_DE_IMPL_MAX_DWORDS];
+	__u32 num_des;
+	__u32 num_groups;
+	__u32 num_intervals;
+	__u32 flags;
+#define SCMI_TLM_CAN_RESET	(1 << 0)
+};
+
+/**
+ * scmi_tlm_config  - Whole instance or group configuration
+ *
+ * @enable: Enable/Disable Telemetry for the whole instance or the group.
+ * @t_enable: Enable/Disable timestamping for all the DEs belonging to a group.
+ * @pad: Padding fields to enforce alignment.
+ * @current_update_interval: Get/Set currently active update interval for the
+ *			     whole instance or a group.
+ *
+ * Used by:
+ *	RO - SCMI_TLM_GET_CFG
+ *	WO - SCMI_TLM_SET_CFG
+ *
+ * Supported by:
+ *	control/
+ *	groups/<N>/control
+ */
+struct scmi_tlm_config {
+	__u8 enable;
+	__u8 t_enable;
+	__u8 pad[2];
+	__u32 current_update_interval;
+};
+
+/**
+ * scmi_tlm_intervals  - Update intervals descriptor
+ *
+ * @discrete: Flag to indicate the nature of the intervals described in
+ *	      @update_intervals.
+ *	      When 'false' @update_intervals is a triplet: min/max/step
+ * @pad: Padding fields to enforce alignment.
+ * @num: Number of entries of @update_intervals
+ * @update_intervals: A variably-sized array containing the update intervals
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_INTRVS
+ *
+ * Supported by:
+ *	control/
+ *	groups/<N>/control
+ */
+struct scmi_tlm_intervals {
+	__u8 discrete;
+	__u8 pad[3];
+	__u32 num;
+#define SCMI_TLM_UPDATE_INTVL_SEGMENT_LOW	0
+#define SCMI_TLM_UPDATE_INTVL_SEGMENT_HIGH	1
+#define SCMI_TLM_UPDATE_INTVL_SEGMENT_STEP	2
+	__u32 update_intervals[] __counted_by(num);
+};
+
+/**
+ * scmi_tlm_de_config  - DE configuration
+ *
+ * @id: Identifier of the DE to act upon (ignored by SCMI_TLM_SET_ALL_CFG)
+ * @enable: A boolean to enable/disable the DE
+ * @t_enable: A boolean to enable/disable the timestamp for this DE
+ *	      (if supported)
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_CFG
+ *	RW - SCMI_TLM_SET_DE_CFG
+ *	WO - SCMI_TLM_SET_ALL_CFG
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_de_config {
+	__u32 id;
+	__u32 enable;
+	__u32 t_enable;
+};
+
+/**
+ * scmi_tlm_de_info  - DE Descriptor
+ *
+ * @id: DE identifier
+ * @grp_id: Identifier of the group which this DE belongs to; reported as
+ *	    SCMI_TLM_GRP_INVALID when not part of any group
+ * @data_sz: DE data size in bytes
+ * @type: DE type
+ * @unit: DE unit of measurements
+ * @unit_exp: Power-of-10 multiplier for DE unit
+ * @tstamp_exp: Power-of-10 multiplier for DE timestamp (if supported)
+ * @instance_id: DE instance ID
+ * @compo_instance_id: DE component instance ID
+ * @compo_type: Type of component which is associated to this DE
+ * @persistent: Data value for this DE survives reboot (non-cold ones)
+ * @name: Optional name of this DE
+ *
+ * Used to get the full description of a DE: it reflects DE Descriptors
+ * definitions in 3.12.4.6.
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_INFO
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_de_info {
+	__u32 id;
+	__u32 grp_id;
+	__u32 data_sz;
+	__u32 type;
+	__u32 unit;
+	__s32 unit_exp;
+	__s32 tstamp_exp;
+	__u32 instance_id;
+	__u32 compo_instance_id;
+	__u32 compo_type;
+	__u32 persistent;
+	__u8 name[16];
+};
+
+/**
+ * scmi_tlm_des_list  - List of all defined DEs
+ *
+ * @num_des: Number of entries in @des
+ * @des: An array containing descriptors for all defined DEs
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_LIST
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_des_list {
+	__u32 num_des;
+	struct scmi_tlm_de_info des[] __counted_by(num_des);
+};
+
+/**
+ * scmi_tlm_de_sample - A DE reading
+ *
+ * @id: DE identifier
+ * @tstamp: DE reading timestamp (equal 0 is NOT supported)
+ * @val: Reading of the DE data value
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_VALUE
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_de_sample {
+	__u32 id;
+	__u64 tstamp;
+	__u64 val;
+};
+
+/**
+ * scmi_tlm_data_read - Bulk read of multiple DEs
+ *
+ * @num_samples: Number of entries returned in @samples
+ * @samples: An array of samples containing an entry for each DE that was
+ *	     enabled when the single sample read request was issued.
+ *
+ * Used by:
+ *	RW - SCMI_TLM_SINGLE_SAMPLE
+ *	RW - SCMI_TLM_BULK_READ
+ *
+ * Supported by:
+ *	control/
+ *	groups/<N>/control
+ */
+struct scmi_tlm_data_read {
+	__u32 num_samples;
+	struct scmi_tlm_de_sample samples[] __counted_by(num_samples);
+};
+
+/**
+ * scmi_tlm_grp_info  - DE-group descriptor
+ *
+ * @id: Group ID number
+ * @num_des: Number of DEs part of this group
+ * @num_intervals: Number of update intervals supported. Zero if group does not
+ *		   support per-group update interval configuration.
+ *
+ * Used by:
+ *	RO - SCMI_TLM_GET_GRP_INFO
+ *
+ * Supported by:
+ *	groups/<N>control/
+ */
+struct scmi_tlm_grp_info {
+	__u32 id;
+	__u32 num_des;
+	__u32 num_intervals;
+};
+
+/**
+ * scmi_tlm_grps_list  - DE-groups List
+ *
+ * @num_grps: Number of entries returned in @grps
+ * @grps: An array containing descriptors for all defined DE Groups
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_GRP_LIST
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_grps_list {
+	__u32 num_grps;
+	struct scmi_tlm_grp_info grps[] __counted_by(num_grps);
+};
+
+/**
+ * scmi_tlm_grp_desc  - Group descriptor
+ *
+ * @num_des: Number of DEs part of this group
+ * @composing_des: An array containing the DE IDs that belongs to this group.
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_GRP_DESC
+ *
+ * Supported by:
+ *	groups/<N>control/
+ */
+struct scmi_tlm_grp_desc {
+	__u32 num_des;
+	__u32 composing_des[] __counted_by(num_des);
+};
+
+#define SCMI 0xF1
+
+#define SCMI_TLM_GET_INFO	_IOR(SCMI,  0x00, struct scmi_tlm_base_info)
+#define SCMI_TLM_GET_CFG	_IOR(SCMI,  0x01, struct scmi_tlm_config)
+#define SCMI_TLM_SET_CFG	_IOW(SCMI,  0x02, struct scmi_tlm_config)
+#define SCMI_TLM_GET_INTRVS	_IOWR(SCMI, 0x03, struct scmi_tlm_intervals)
+#define SCMI_TLM_GET_DE_CFG	_IOWR(SCMI, 0x04, struct scmi_tlm_de_config)
+#define SCMI_TLM_SET_DE_CFG	_IOWR(SCMI, 0x05, struct scmi_tlm_de_config)
+#define SCMI_TLM_GET_DE_INFO	_IOWR(SCMI, 0x06, struct scmi_tlm_de_info)
+#define SCMI_TLM_GET_DE_LIST	_IOWR(SCMI, 0x07, struct scmi_tlm_des_list)
+#define SCMI_TLM_GET_DE_VALUE	_IOWR(SCMI, 0x08, struct scmi_tlm_de_sample)
+#define SCMI_TLM_SET_ALL_CFG	_IOW(SCMI,  0x09, struct scmi_tlm_de_config)
+#define SCMI_TLM_GET_GRP_LIST	_IOWR(SCMI, 0x0A, struct scmi_tlm_grps_list)
+#define SCMI_TLM_GET_GRP_INFO	_IOR(SCMI,  0x0B, struct scmi_tlm_grp_info)
+#define SCMI_TLM_GET_GRP_DESC	_IOWR(SCMI, 0x0C, struct scmi_tlm_grp_desc)
+#define SCMI_TLM_SINGLE_SAMPLE	_IOWR(SCMI, 0x0D, struct scmi_tlm_data_read)
+#define SCMI_TLM_BULK_READ	_IOWR(SCMI, 0x0E, struct scmi_tlm_data_read)
+
+#endif /* _UAPI_LINUX_SCMI_H */
-- 
2.52.0


