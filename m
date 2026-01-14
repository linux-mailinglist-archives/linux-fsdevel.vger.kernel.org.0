Return-Path: <linux-fsdevel+bounces-73675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E73D1E909
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 421EF30B62C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E62397AAF;
	Wed, 14 Jan 2026 11:48:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B104399A47;
	Wed, 14 Jan 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391293; cv=none; b=ZZRFcAeBkLbCT5oOSpsaEMGZFTneiBkpM2T/NVkk7ARuEa4psi6yEuwUFnSfruzW5dZGTkvf0Zt3Y73Er+GzuO6I4MdWQuP+k8lifoA9KhNfDkZoeks6PnfaARr4Yc6UfY1dAse3b1OG+01DAd1UK+4kpLCnQN3Jp/S4TKVEpFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391293; c=relaxed/simple;
	bh=roNAJnkVEbqMeo26MUqjkgkOgd6VucBPugu8dfXkMJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrDWOM1p0XsRFLe/0xDXHVeRevZmfMRTLVNOtCvyZY5gYwWcCL2tWB0rl7ljgY7NTUske+4D+CCPIREtglmg+4wfiQyn0WY2Ne9pLY3hp01+dMwS1kjjavxFBfVQnYlxXVDPuhc1V7Q8Mj6CwJEc7IQE1oJ4ZjiK5BOX5MUbZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F9A7497;
	Wed, 14 Jan 2026 03:48:04 -0800 (PST)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69873F59E;
	Wed, 14 Jan 2026 03:48:07 -0800 (PST)
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
Subject: [PATCH v2 13/17] fs/stlmfs: Document alternative topological view
Date: Wed, 14 Jan 2026 11:46:17 +0000
Message-ID: <20260114114638.2290765-14-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114114638.2290765-1-cristian.marussi@arm.com>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The human readable interface presents an alternative view based on the
discovered topological relations between the DEs.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/filesystems/stlmfs.rst | 72 ++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/filesystems/stlmfs.rst b/Documentation/filesystems/stlmfs.rst
index 5c23f7e5f12c..cc9585f77ba5 100644
--- a/Documentation/filesystems/stlmfs.rst
+++ b/Documentation/filesystems/stlmfs.rst
@@ -112,6 +112,7 @@ the following directory structure::
 	|-- all_des_enable
 	|-- all_des_tstamp_enable
 	|-- available_update_intervals_ms
+	|-- components/
 	|-- control
 	|-- current_update_interval_ms
 	|-- de_implementation_version
@@ -202,6 +203,77 @@ values, as in::
 	|-- intervals_discrete
 	`-- tstamp_enable
 
+components/
+-----------
+
+An alternative topological view of the des/ directory based on the topology
+relationship information described in des/ ::
+
+	components/
+	├── cpu
+	│   ├── 0
+	│   │   ├── celsius
+	│   │   │   └── 0
+	│   │   │       └── 0x00000001 -> ../../../../../des/0x00000001
+	│   │   └── cycles
+	│   │       ├── 0
+	│   │       │   └── 0x00001010 -> ../../../../../des/0x00001010
+	│   │       └── 1
+	│   │           └── 0x00002020 -> ../../../../../des/0x00002020
+	│   ├── 1
+	│   │   └── celsius
+	│   │       └── 0
+	│   │           └── 0x00000002 -> ../../../../../des/0x00000002
+	│   └── 2
+	│       └── celsius
+	│           └── 0
+	│               └── 0x00000003 -> ../../../../../des/0x00000003
+	├── interconnnect
+	│   └── 0
+	│       └── hertz
+	│           └── 0
+	│               ├── 0x0000A008 -> ../../../../../des/0x0000A008
+	│               └── 0x0000A00B -> ../../../../../des/0x0000A00B
+	├── mem_cntrl
+	│   └── 0
+	│       ├── bps
+	│       │   └── 0
+	│       │       └── 0x0000A00A -> ../../../../../des/0x0000A00A
+	│       ├── celsius
+	│       │   └── 0
+	│       │       └── 0x0000A007 -> ../../../../../des/0x0000A007
+	│       └── joules
+	│           └── 0
+	│               └── 0x0000A002 -> ../../../../../des/0x0000A002
+	├── periph
+	│   ├── 0
+	│   │   └── messages
+	│   │       └── 0
+	│   │           └── 0x00000016 -> ../../../../../des/0x00000016
+	│   ├── 1
+	│   │  	└── messages
+	│   │       └── 0
+	│   │           └── 0x00000017 -> ../../../../../des/0x00000017
+	│   └── 2
+	│       └── messages
+	│           └── 0
+	│               └── 0x00000018 -> ../../../../../des/0x00000018
+	└── unspec
+	└── 0
+	├── celsius
+	│   └── 0
+	│       └── 0x0000A005 -> ../../../../../des/0x0000A005
+	├── counts
+	│   └── 0
+	│       └── 0x0000A00C -> ../../../../../des/0x0000A00C
+	├── joules
+	│   └── 0
+	│      	├── 0x0000A000 -> ../../../../../des/0x0000A000
+	│       └── 0x0000A001 -> ../../../../../des/0x0000A001
+	└── state
+	└── 0
+	└── 0x0000A010 -> ../../../../../des/0x0000A010
+
 Alternative Binary Interfaces - Special files
 =============================================
 
-- 
2.52.0


