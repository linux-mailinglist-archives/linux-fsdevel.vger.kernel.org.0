Return-Path: <linux-fsdevel+bounces-49427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB5ABC19D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 17:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F1C7AC851
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57883284B27;
	Mon, 19 May 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="XjGOjs0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E761D5AD4
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667098; cv=fail; b=VSogQ8cahO2d//pDvropclkL63KddLQGaFGDGrbIcPmssLsk4zVHgke87eAytlwxsUcBwFC5qtO+tYHgxDSY+Vm/2kCHGtQNw5TjgpyVPnoagxmchl84c+aXr0dsuBUswNUH/trmAazMj4nMr0N5+T4hyRlPdkGEAPpu2uKoXeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667098; c=relaxed/simple;
	bh=TSuaMdYNtvBcrvn+nVgslSkxjR7Ps3aU4o+BWlXTVUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHDGCTTh/srjaMxzLh1TaakD+P6KuR1HvCREdSfOonK6erF4GS6a6X8bkQvqoHa/+XW6LsmGhSP+50+Y5vESI6t1czxs1N3MG0Wos/oR0QHoYgeYoO1W86WN53rvoPGmJ7szJz+JJjISLpyqcBedE7lOPWQ58H3F68DnM92UUBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=XjGOjs0N; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7X/3WXd9N5GjV5DVqGsYLMnFIYcZG6f7vkDYbzY+k+lhPOUVp82NLSnhazdnnLnNfT6k8jzlXtPBe9tyjSMgrCGi3tTFEVBd79hCHPzEzpFI17OZKokx4CtSQpp7FXsN1TyAIS6/J6/C08ivheibjIYi0rQxv/eSndNOpHAxgGvB1jI8UDXauonT9MaR5Uo1ckLLfgY2duuIOiU82HurH5OmMmMQW5ZQgw1Oir25Qot/8Feo6EiFRFnp20xtIAJgA6s50BLn5nubRpvB+0mdHC6yB47po8siz5JiNOY1kT2UBJQP+F/x/vHbZoeIWTRb4ZaRyhcPh1Y4G/CNrTkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XHAaRx3KfmzNJ/QZMbPv9ufxcnBuXDuWqXnbxFtSEU=;
 b=vxnAruPLLi2Hyzx0XTAgLvtubwduUtp9Tl4FeY2i2HGYcSIlad+upb06+JCU+qZkkol+6LSqnD3HJ+ybvjTRgYzj+Wd2JfMtCeiLZuss91P7PmSfzX5nBjzJLF6E/9Kr77MDAPGHH7QvLxBwQGu1McWiSXouzyTTZJCJ7HUY9ehwNuWRFq6z/OpPRzeZ+MRmS1jNMjzvsdBBoAAorJqZ677NWBcdvBvvTy184fkjqRBOrQQ6tu+W8PzS7PM3VygEYg2hazb5Jqh79dMXxyBFxBB1CJCDlCa8C0AdBUQuo6JpjQ3YJ5BwUrg7rt5mxI5UeMWEbDEEButQWyHDrboC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XHAaRx3KfmzNJ/QZMbPv9ufxcnBuXDuWqXnbxFtSEU=;
 b=XjGOjs0NfVhrjrwo0QUWV4KZqwmQKKaCLrYkSBp8iqMjx5malnGBdrr41OYiZkY7VRoPI06TDoantAJZ71eapBaNJLrkYjMrX7tRj02poWKvBfArjFU+VM9GKr/B8F18Kpm5yp3FgdGswL/9xxSO8+zlxzMRmmMm3TVwlvmZyAXlYMHpNwx29fQfUqq/bMHrEUb5hmchU3byzm+w8LbFe4pL60TZuiq4ZDfOHPqCeJ++eV7hnX0pshKimKOtBDCafl2RdonFQqTUAgE3p8Q8+VXTV2MLzrfvxuZfBE5luYgUM/ixXtVI2D0edwo/i5aWSV4uXN9yDv9O0k5QNGF5/g==
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by SA6PR10MB8063.namprd10.prod.outlook.com (2603:10b6:806:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 15:04:54 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::d5) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Mon,
 19 May 2025 15:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 15:04:54 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 May 2025 08:04:52 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 19 May 2025 08:04:52 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 19 May 2025 08:04:52 -0700
Received: from se-jocke-lx.infinera.com (se-jocke-lx.infinera.com [10.210.73.25])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 862C7F40257;
	Mon, 19 May 2025 17:04:51 +0200 (CEST)
Received: by se-jocke-lx.infinera.com (Postfix, from userid 1001)
	id 72DE46006581; Mon, 19 May 2025 17:04:51 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <linux-fsdevel@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH v4] block: support mtd:<name> syntax for block devices
Date: Mon, 19 May 2025 17:03:50 +0200
Message-ID: <20250519150449.283536-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6e90a2be-a1a9-46fe-a3f3-bd702c547464@wdc.com>
References: <6e90a2be-a1a9-46fe-a3f3-bd702c547464@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 May 2025 15:04:52.0541 (UTC) FILETIME=[5F9C0ED0:01DBC8CF]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA6PR10MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 80887327-241e-4ba8-dc1e-08dd96e6830f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3edAGdYnO7uoZKpy2N2LpSuMpzx2CMmTkiZXRpPy4ptELJm6IGww1kEruvFb?=
 =?us-ascii?Q?kAHiaeInD6sYUyI1NCiFdtPkU8mfHlm8XdYzF4eBJAkRoMUqFUzLm3kO8UNL?=
 =?us-ascii?Q?5x6xQs3aXYZTO+1opxijvE7At3Yf1y+9xqitp4V5XABji2lnZ8wZ0l+w6AhC?=
 =?us-ascii?Q?A17woFXlgoQDRL3qxPKdponpQoI5ZsEQTXu0HnVO8pnQE49IpY9OIk6lCOuB?=
 =?us-ascii?Q?FBzJXQp0+ly3zfhRAW7U3Yhx+PqQKYBjeVwAikQWyOPXlrFHAVhrSMlNLe+O?=
 =?us-ascii?Q?1A0pq4kd/KexYkiL7Z2XYq/OZ4BJCUZr/TAzlpgqefjKK0MKGJP+nOinJK2y?=
 =?us-ascii?Q?ET2otZ7y1BOUYN8yQKLO0CdL6Z9M/HAXlZmU1wpUmZDpi2Uwz1bWPXgVgc+j?=
 =?us-ascii?Q?6JRNBUUo9f5EZY1PMg530YMYGC0IN1XggQG2MdWPC19/gWiBBmm4nbFTfcOM?=
 =?us-ascii?Q?2py68OC/k1i9ZBuD6vKK0IyABIED9loZb/Ej5jCaUeVZ3ZIz7azW2sjtm65w?=
 =?us-ascii?Q?Rg3bOnTGSr+zCeBmTUAAHV/XtfSbRYkeetfuGcnmtz+BupsFSvEuMzaYmjz0?=
 =?us-ascii?Q?ka2NmVAKhv09Gk/awx2lC2kc2zJVoJyztliWaP6mOtc2jH6/8ZDS/vY6QYVA?=
 =?us-ascii?Q?vnkv8KrlhSSkPofCjx4PZ8gNNTd7uz3YNFzRfnSSMGmbsgGG00TY88za5aXw?=
 =?us-ascii?Q?oeHUvOkwwDON+lc2Hqs45Es+jBsm+VrowOMAedDU5n5l3ETxREPnjVdx19d+?=
 =?us-ascii?Q?oUTxvl6q1AvWAQsOnclH55oAxi394NDPvd57IJ0Omaj1MNh/4M7XmTf4RFPn?=
 =?us-ascii?Q?LP9z3lqskURfxWgRI4JR6Py64vumbWI7zi7/kskVQN5Bmhk9KHHmGRJoArLV?=
 =?us-ascii?Q?ZEHIf054k1i/xzscPa0d3io4vm/x0yRrlEKg/2zEQc5Dkvl+XBjGO8h9kImY?=
 =?us-ascii?Q?6bitZG+tvU3vpPjHvAb3NYnKXIUsTH82A21eOullO7pdldu4d5A7/3+ca5N+?=
 =?us-ascii?Q?PTMZi+KrB832i1+ZQ/ENwXD46obUbrgWf8cspGT1Hs6HeHTRDjWHniZaHiD3?=
 =?us-ascii?Q?zFIIph/yf5SfNiKtrfXwUnkmjdEgMXemD7memxsnuPQoWadhbkse2eDPkIuD?=
 =?us-ascii?Q?plUQRAIlEQX6hJ10hhB8NCg5xalhYqZqoGfI4bGF8i8EPrxxx5iGS39cUzZ9?=
 =?us-ascii?Q?w4R9bcBMHaBWwcSxcUR1xFaCr40iTn7p8SI+rprIbdyM95/r1S3/peBHCRQo?=
 =?us-ascii?Q?6YNvHj0VbNiHjmLGHzyFYA4lQpZy6Ab7VJeeaU9AFBQERLQklEdtDadkDyZN?=
 =?us-ascii?Q?DR8QrcJqdAg15quWpoezcYyj5hVOfpC+AT4/GLbVPOWY9h6VRzrs6IhmO2x5?=
 =?us-ascii?Q?4ElSwPMZJc9mwefyk6bmh0dv+TKsj7w2/Hx7ipGmtLfuO3RQQmfffq2b0z32?=
 =?us-ascii?Q?/jngwidfqtM/ZUjPN0vvJSI2cHzhZ2c0T2yDkGZQb6cLyiC+fVi1Zqa27MGE?=
 =?us-ascii?Q?rZSXyzuQhKJEUlDO7nk4UgpuR6t9t44Mc5PC?=
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:04:54.0899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80887327-241e-4ba8-dc1e-08dd96e6830f
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8063

This enables mounting, like JFFS2, MTD devices by "label":
   mount -t squashfs mtd:appfs /tmp
where mtd:appfs comes from:
 # >  cat /proc/mtd
dev:    size   erasesize  name
...
mtd22: 00750000 00010000 "appfs"

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 fs/super.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 97a17f9d9023..df7a6cfa34d3 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -37,6 +37,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
+#include <linux/mtd/mtd.h>
 #include "internal.h"
 
 static int thaw_super_locked(struct super_block *sb, enum freeze_holder who);
@@ -1595,6 +1596,32 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 }
 EXPORT_SYMBOL_GPL(setup_bdev_super);
 
+static int translate_mtd_name(struct fs_context *fc)
+{
+#ifdef CONFIG_MTD_BLOCK
+	if (!strncmp(fc->source, "mtd:", 4)) {
+		struct mtd_info *mtd;
+		char *blk_source;
+
+		/* mount by MTD device name */
+		pr_debug("Block SB: name \"%s\"\n", fc->source);
+
+		mtd = get_mtd_device_nm(fc->source + 4);
+		if (IS_ERR(mtd))
+			return -EINVAL;
+		blk_source = kmalloc(20, GFP_KERNEL);
+		if (!blk_source)
+			return -ENOMEM;
+		sprintf(blk_source, "/dev/mtdblock%d", mtd->index);
+		kfree(fc->source);
+		fc->source = blk_source;
+		pr_debug("MTD device:%s found\n", fc->source);
+		return 0;
+	}
+#endif
+	return 0;
+}
+
 /**
  * get_tree_bdev_flags - Get a superblock based on a single block device
  * @fc: The filesystem context holding the parameters
@@ -1612,6 +1639,9 @@ int get_tree_bdev_flags(struct fs_context *fc,
 	if (!fc->source)
 		return invalf(fc, "No source specified");
 
+	error = translate_mtd_name(fc);
+	if (error)
+		return error;
 	error = lookup_bdev(fc->source, &dev);
 	if (error) {
 		if (!(flags & GET_TREE_BDEV_QUIET_LOOKUP))
-- 
2.49.0


