Return-Path: <linux-fsdevel+bounces-49213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D1AB964C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 08:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921784E5F07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 06:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948A1220F5C;
	Fri, 16 May 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="olaBI4V5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8B1361
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378413; cv=fail; b=RRlvCJSSffdjleR5idPChGCw/EN97Shb7wyOwJM4UNhWEIT08kUO+a+DRDBCQFu8FIZjnNh7r7vnjUqR0TglPBxGDnLQoWpQa8JHcUGTy3O0lbT2DiGJatlzH5C8bVFksO84Gk2XoE1+PtrMGsA5qqIeyux6KJigXvTob0T3yTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378413; c=relaxed/simple;
	bh=Dvl/UT9d2OTnm+CTg2LCBAcsXhqaA+xObP9tCMHmICA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cdJPo0wYDiDLS1xsxyFaOI8jbfLps91JwJ6fyoZqQq/LYMISGWxXT3W1AWSgvnosLGyW8/uRsvmfdTZtbIxosBifs6SxjCKMq9JVhMIsiThtoDSN16jpKdK0DkIyEj0XORQvk1qIkuG6ardBrOdL62+GEoQ1B6fdGxvcf3oeO0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=olaBI4V5; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCTR9imgf1AioCTaATznfMoibYzFv5CD1x6L6gcgzQhJMsqiSKoJr8O40/8ZeljP6mYZIwq3pTMyowG3O8L5wh4NAR2SRVSIPuDUOgtseq9R7s/hHL78lItbBtA+//8WeAo6OZf7nn67vcmJIgRSvEUmUW6saNEizAHoIJPiXzM0or12rK5WxTkSMf+hu2lTYek2V6EU80+Bzh0QwdelaU7MI+TsefrvxP3uXYf7vtw+y4KzqXT4Yxxgammb8pH2p45pt1mTv2iY4bwQIvOl+KOGfWVJBB3o+mpvav47JofwI/nvbrZP103CPFiv3zqXwuobH8upXiY+pKf/X3sosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOh6ZTXmU945Smv9JJauD54ULPGEM0T3wIoTJDtZqWQ=;
 b=CXCXN6XrIYiOYplTJmjRINFpTYHiLFI8xK0mHOmE1MG7twsq+Xjcwxvh79WaqDjmmWA1VqTxlHAcKbiaduWDjqjTHUhYO3Him+9XBNwkRRgBpuSA7W9M8IKq6v96O/SW40ZVTxuoaCeL4RxWA4I0hrX99eaE3XV6se8Jz+nnStnkuAMgfTzgKxvehdZ8oe6biMioaORd6dK24bEMFY3/pSTYmyFL3UpQvt76Nmv0a3FMdfgQWLJWtUaHshTRrSQnaJe7OwItAfLWjS/EDYTNpabOmhqJr6KEw6jT7iPiR8bXWIjQWjpg8qfM3lt6FUJ4l3oXcdbaOpCFBmL/Xg+CZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOh6ZTXmU945Smv9JJauD54ULPGEM0T3wIoTJDtZqWQ=;
 b=olaBI4V5/S9HApF2ZWarD7WZqQ93KKKFibhdbeI14Cv+nUq1LnXwPcdp9OJamRfgJ7p2ZRpE6GH5AUfkt3lTTkZgF+WbAlGBunvJOz5sHOIVto6RKjfyH3YryzfXaReegUScYeGTAbpxl1zlillP8FhtxyuumBha/eQ85UoRi/24uomUpcUXw0ukcFXkLG2xNV8kF/NPhkBcPk3mcO9DMR0Whpvc2rlM9VOZ17zD8S/tvLK5JIYta1sEveBrS0Y4hX1xzniohpNm4FmDn0Vyeq/73A4YxRVcwgifdkzcNjUrUDg7lvx1Eifk7R0mTwTrdkdFErY6q7oCYn5LI6IqBQ==
Received: from BN7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:408:34::20)
 by DM4PR10MB6037.namprd10.prod.outlook.com (2603:10b6:8:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.31; Fri, 16 May 2025 06:53:27 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::3e) by BN7PR06CA0043.outlook.office365.com
 (2603:10b6:408:34::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 16 May 2025 06:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 06:53:25 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 May 2025 23:53:24 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 15 May 2025 23:53:24 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 15 May 2025 23:53:24 -0700
Received: from se-jocke-lx.infinera.com (se-jocke-lx.infinera.com [10.210.73.25])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id CD08EF403A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 08:53:23 +0200 (CEST)
Received: by se-jocke-lx.infinera.com (Postfix, from userid 1001)
	id BC64660067D2; Fri, 16 May 2025 08:53:23 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH] block: support mtd:<name> syntax for block devices
Date: Fri, 16 May 2025 08:51:56 +0200
Message-ID: <20250516065321.2697563-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 May 2025 06:53:24.0833 (UTC) FILETIME=[3853A510:01DBC62F]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM4PR10MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 866801ef-939a-425d-54b7-08dd94465b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KeW9iLO3YW6pow8LWwIZBfLFnOl13QJ7+vkZ+VE3rSeu88i0J+mWAoHVkOeJ?=
 =?us-ascii?Q?ygnBNHCoqrgk0AU1eWhSLbJxpYsoZgVURxC14dBzpbmoGe94i1hSLYJfoCDw?=
 =?us-ascii?Q?EjnwJ3I6nDjaXWo9hhPO1dT73tGwn6bP61otTGzLIgPbx6WNgtSJij/BZW8x?=
 =?us-ascii?Q?IdNMFVi418GCGS76urxKr+4kWSafoHQFko20v1+cNn7X2DNlp7UnPifom0vP?=
 =?us-ascii?Q?Ab0js3NM4m1vG9UABFWqqvQbtONFPkr6orE48kFF+ZZSyO340XYh1UccHrsF?=
 =?us-ascii?Q?6jgdyLTUgnhsxvGcuBY6fS5FYf0y32LzdR+xUBr1A7IAu5w/elyVHDkcwTeW?=
 =?us-ascii?Q?j20ztJJDjXdpr5+9NAkJsaPjBaaiIPKT3LUTZMeATFwsmFwJbrXsTuELf+k8?=
 =?us-ascii?Q?3NjWBzbtkoHDYWMt5FoR6eTs8DMGtRPLRr4fpqEbcOQeQTKHdt3KruAKK1Hl?=
 =?us-ascii?Q?UG60XNcihvm2/VE8peXb6ZtPQDD4c0nK3A9+qVbVEMFSn74r/ciy2u5FsSoO?=
 =?us-ascii?Q?OmA438ScBgxoTOn6eiPI4dRtxphsKyV+Wd6nw82FF51/cGEp5wogDoSOkq5L?=
 =?us-ascii?Q?F5zJxzQzSBVfEOrBqCudit27oupAu+rOTO8/bwl7s9HlPGEpPZQ4oxZxpKVp?=
 =?us-ascii?Q?DvJAJ65xJyAGWmbmNNnXaLOcTWVCJpBYMohj0CWgZeahtpP2sI9zchCfcmgM?=
 =?us-ascii?Q?tg47gARWJAvDE4xHs4/jxfrbWqmD3KSvuXDl6Y6deIScm9MnGclnNCv9LNm1?=
 =?us-ascii?Q?szoLsJ7ZnK76jcShvfFmBJ/wmEMCECkPrPkPlfA1Td1lZBEr9PJLZSV4zDtq?=
 =?us-ascii?Q?Ovk4pKBJTFPGxVRJr7n9R2q7zvU03YTO8WmWvRKIYhVHKOsDRSUnWBdXyAnu?=
 =?us-ascii?Q?kLTKuOi/71UyR3DCG+yRLH0vAhg0HZNYNt9v/q+sOxIk4Ski7nCBzGk+arhl?=
 =?us-ascii?Q?DxXR8IoS6cI9P3hi5FFpaWDFmC52HNUbNPiMIw2WKvE9HPz3Cs3t4HJ94LdG?=
 =?us-ascii?Q?OFP27ut5+93RkQfWOfxS5oq8DyYCENVt93xEHMavdZ9zet7BAN0KwjVuiU6y?=
 =?us-ascii?Q?qHqeMv6s/en5ZJwuBphk3ETLIU0wUAX92nTzhxcM4ENIkdPnniNxOxyxVUC2?=
 =?us-ascii?Q?S+8ydkdR2I5+pvHIZTpkM+W6pLf78LKBeoEFIPJAE5QbWYwEONOqZYdG1l4Z?=
 =?us-ascii?Q?X6Futm1lOPbEqp5owdesFpqLU4MDfnxYNnQX7OmvY96Q2WBfXYhATjUXFtfo?=
 =?us-ascii?Q?EK3/1MCH2FXo8qOsZZxCvb0FrcmL/fyaoX0RcDUHwItKYwxeiYDn83xVRM0C?=
 =?us-ascii?Q?I4bB0Xe98sn9wX2Up1lTeWnlilLE+y0AIV0fjuMEZgzJD/xpKb3pxzDKhTJi?=
 =?us-ascii?Q?4BRGQl4qG9DaJdagW+3zSTuNqVj4wE2nRN6Y4PO31jojewLeaQ/7jQifNo2d?=
 =?us-ascii?Q?ywqMxULp8AhpMY4Z1jxvEhbMwDSwgiN4ZG+Dr6Z9z3vVdILrSn0nfdpIX0Nf?=
 =?us-ascii?Q?a8EsE6N2e66RGJVdCruMLZ65oCng4KGGEGnA?=
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 06:53:25.8783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866801ef-939a-425d-54b7-08dd94465b82
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6037

This is the same name scheme JFFS2 and UBI uses.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 fs/super.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 97a17f9d9023..e603236b3ad8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -37,6 +37,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
+#include <linux/mtd/mtd.h>
 #include "internal.h"
 
 static int thaw_super_locked(struct super_block *sb, enum freeze_holder who);
@@ -1612,6 +1613,26 @@ int get_tree_bdev_flags(struct fs_context *fc,
 	if (!fc->source)
 		return invalf(fc, "No source specified");
 
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
+	}
+#endif
 	error = lookup_bdev(fc->source, &dev);
 	if (error) {
 		if (!(flags & GET_TREE_BDEV_QUIET_LOOKUP))
-- 
2.49.0


