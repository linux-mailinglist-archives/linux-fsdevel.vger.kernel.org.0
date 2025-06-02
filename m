Return-Path: <linux-fsdevel+bounces-50289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C84ACAA1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C4A3B0049
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C684FAD;
	Mon,  2 Jun 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="J49V94wM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1C5BAF0
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748850702; cv=fail; b=lWqSUrc7RdwpOC1ssRVLFOp/87O46tbyjmMZxEkdfZ159DkTYkjhQ++XwmIVUUIzqO9ZrzzTvZM9n4eGef0gm74lRZjBpjC2DAZAXbe2J4+rtMUXXLW2uwSImr2MU+y4ZaYsFcpoJ9/EWmBo4zox3XTBjq6VepNqvB5GCtlvL60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748850702; c=relaxed/simple;
	bh=dJQb1jkybaqLtl7Brtd1p9+ik/oqqyjqVn8lF4x0gxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlC9O/CjJA8VfS4H2Rm0aXc/BArYKwos7bIVpAfTXokQy3/XWLD/eF92Z6baf7c9ZScSdvijzHfeCbRr/4Mo25WwrBkdLWFcQlWh5w8xMIsD+eEZB+94TlNvMacHSwqX2iuM97jxijBxAU3Uvqyv4V5tTO+ePhQlXphdVXMajwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=J49V94wM; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKE3jn9qtiG/1VdrfVh1Gm0h2xxpCl5SCv8Od0cbCTpeReMB/KslrMQCdKjCxITDGxFLAEhwFfm2OpwKY2Mxv7BB3BlU3EhoVedHNsqu05JayTSY14EL1gG7o34DWuu8nSYBQmCdOEa8+ci8X+4faEjPRVA8OAB/Z1iazAhH5EEEnW3NxmwDKvEsaSmKYOLH2SX1bnGQkhGd7D8F1mREweTyEGIC/PpuqxYkIKCxOB4jV/HlARWO6wvJlU3G/fDoDm9xiAWOLLDu3KhWt4YEEpQHk2IcIkxEGPJ//o50WB/UYsp5b/0G8lDz+XEEHolGMGn8l3cL1Clh+6+VabB/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMTis0W114PSQ3rg0hs1TXbp5r0KXYu2ZlBKpamkEp8=;
 b=ZjHHUbUaLTMQOZDTt5B7T9YfYfz5PxP7oB9nON5XKuLS6V9D3JBYjWwf/KAOZLRvdWBUieuHMi2QvX32AH7g878+qn5Eia4icDJfLQYhPg+xeNLQkyWpPYWRWISPMq7viGzTkD4oBPmaWddq66xRQfCweum6T/GCU9aX6TsP7zCAZIJOhwVaoQHoK+9fLYCWWaVNdW7rfcr4z3qcb8nTIYK1ROC2EW2qNc6S4A198pYxnicoPCxhRjcCV6tx4ctN3HX62ZgpyRmMW1zJmmvd5Z2UOGTleST/63t54aLJ7Q4x0YfqfP1H1dzWvocUQ+IaSzjhZNj9uEuo0rDwXfZG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMTis0W114PSQ3rg0hs1TXbp5r0KXYu2ZlBKpamkEp8=;
 b=J49V94wMuZW4Vp/znOfXW8fGsGpgTRAB0vvdo1qHmJDiZN9bS8e9lscupM0AXjIOji7mxAA0txihE3gg7uuc4M6YHALzLv7WQhKa5+3lHgSg3c8wHF4MTSk/cck3WXzKiwifBcvyKo9EvxKT559cnEMl3kygwHsVfWzFnw/L//e6AvirpFc8nagh1utphW7/zz3xWSf8EsZo00uWTDv4rhrwXTnFiG/sH0TuB8+lNakY14DNsJMZJgfJAEiso536ZPgnrsi7RmDULsYYAp9AFMUuv/3y9kdJKPDSt7M4KfwEfm5tjom9Ej+893W8WgNSfm8xpGjy8xHQsSZv3bx7oA==
Received: from MW4PR04CA0041.namprd04.prod.outlook.com (2603:10b6:303:6a::16)
 by DS4PPF67D158296.namprd10.prod.outlook.com (2603:10b6:f:fc00::d23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Mon, 2 Jun
 2025 07:51:38 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::4e) by MW4PR04CA0041.outlook.office365.com
 (2603:10b6:303:6a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Mon,
 2 Jun 2025 07:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.2 via Frontend Transport; Mon, 2 Jun 2025 07:51:38 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Jun 2025 00:51:37 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 2 Jun 2025 00:51:37 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 2 Jun 2025 00:51:37 -0700
Received: from se-jocke-lx.infinera.com (se-jocke-lx.infinera.com [10.210.73.25])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id A9F04F403D5
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:51:36 +0200 (CEST)
Received: by se-jocke-lx.infinera.com (Postfix, from userid 1001)
	id A0475600B581; Mon, 02 Jun 2025 09:51:36 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH v6] block: support mtd:<name> syntax for block devices
Date: Mon, 2 Jun 2025 09:50:40 +0200
Message-ID: <20250602075131.3042760-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <202505282035.6vfhJHYl-lkp@intel.com>
References: <202505282035.6vfhJHYl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 02 Jun 2025 07:51:37.0674 (UTC) FILETIME=[2B3EA2A0:01DBD393]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DS4PPF67D158296:EE_
X-MS-Office365-Filtering-Correlation-Id: 28575b37-109f-49ed-f1fb-08dda1aa4dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zIeiGquVeOH2XdmyZVuOf3spDl4s9PjDFfJLTHQ5ts6yDMy+lx4bFIYqsvir?=
 =?us-ascii?Q?SbpqlVPW/dJJJwwL6LcmrnqVSLDngu0p+bMmxPBNuYWb/irXPiBV4DZiSOIL?=
 =?us-ascii?Q?6XswpSM3HTvtPl88n4D233dqlC/2x/ZWsxZ6BYEFV/MRniFQKVzijKQfcE4d?=
 =?us-ascii?Q?Bj83TxyRYB+V76XdQA9Vdp97lGaTRX+k4Cc75eVTAWZM3snqvSbHKmh0/2mN?=
 =?us-ascii?Q?0l+SmrORddJjqyMiXPK+YVq8T8UjOGM5vTiD1e3b1k8oTVqhh9ciC4nY7Y7J?=
 =?us-ascii?Q?2s4h0sLoHgo8i5NmjkUcXeVZe0GwN6rreFSGp0J6FO7L+UciQLaMWAwBnRvR?=
 =?us-ascii?Q?+Vmi5i6On1Pn/keWQcTt8RithHrViCfrwbh6vVUotSojcT9D68XCzYLLLLON?=
 =?us-ascii?Q?oR0VZSqJJ0Rvt8Z7AhmxWQQFzswJuxbQUAel9DmUkVp8BB0uBLNBiYh41Sdg?=
 =?us-ascii?Q?llm3K3Og+O4W32op22odhWKxbno+eWSSIQdDfaEDFZjyfKHcIB08Xok4g0of?=
 =?us-ascii?Q?xn3P0h7rADbVPNDnows8MNU81hkk2inJ6/QjKuySmAnuLJQi2Yt335Oimnia?=
 =?us-ascii?Q?4og7jfBsnvxLBeRJPgTfWdYWB+59lFnkik1t/hZHq+Naijl0omHe7zBjN/7x?=
 =?us-ascii?Q?/X+EpPSldZzoiRxlDfmwN6IGRiM90k22ZyT2akL2gY+dfELS9Ng6L/td6zi7?=
 =?us-ascii?Q?h6A4Crglxa42RGssxWQvLrHxafTsf+L1IqPtNrmlRz+zYpJj1CAWxvI14+zX?=
 =?us-ascii?Q?cD5F76RTP2bjqUufx5uyAsR3YB9Ts3z4XVeWOpfdxSB9Ybm0olRZDde0KrVB?=
 =?us-ascii?Q?m5otB8UXda8/SFme1aUZDgD9Ad0WogawD3oK8E6G8dRHHXZazwkiKQT09yyl?=
 =?us-ascii?Q?hGZMrIADZjP+FhA6lR77QKR0xRG6I1Rb4sq6+zde01kB/ymCPHaPYKEjuoS8?=
 =?us-ascii?Q?WpvB36qaECULALY9Utt5GFhNIuR2aFb62OLFrvyp7SyGoNW/5RB13aVRQCyw?=
 =?us-ascii?Q?B0Ris8UehjqkJu6WrzpO0qLDrqZDKBZ8/fJqBnNdwcsXmFOkEd1zOBjiVQPI?=
 =?us-ascii?Q?W4LVwiVlPJH+URbNIiRJ3lgOO0hX0Xwn1iQ1jEENMK70yztxqsVEeH4kxT62?=
 =?us-ascii?Q?9LE7gEufOkB6fSuIXRTC7zkQKzBc+sBExSI5oB8zax8FMFe81IETEe7gUIqg?=
 =?us-ascii?Q?tBd3WpHUAil7yGdRRDOURF/5R1r1ECBMrs0k454oEWQPCJ6v5eVJar7NRGLS?=
 =?us-ascii?Q?rrTqWKRvpMohf0jmUeIBjWFD6WFAfLDSt3ue3b2z7UiWcW38GnITYc/eAYUA?=
 =?us-ascii?Q?TmvW1PjE0llx7xKLKYb/Pj6M2JeY0yWM5azpyffpLmcG/hwjoxnvzhOIIQIC?=
 =?us-ascii?Q?aao1nL6z0xb41+PjVTmOnuE1AwhgWHLaRS1kYSf26MfRSPOsYZiTqg09M/yH?=
 =?us-ascii?Q?ob/W6DF+5guWaXhE1TT+N6lvY6xSm+F1D8wTBj+IhhnhkIeSKNmwwDT5s5lL?=
 =?us-ascii?Q?B8rV5H0EKY/9Yt6tA94YWKjFRksF0/y2s9Ds?=
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 07:51:38.0320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28575b37-109f-49ed-f1fb-08dda1aa4dee
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF67D158296

This enables mounting, like JFFS2, MTD devices by "label":
   mount -t squashfs mtd:appfs /tmp
and cmdline argument:
   root=mtd:rootfs

where mtd:appfs comes from:
 # >  cat /proc/mtd
dev:    size   erasesize  name
 ...
mtd22: 00750000 00010000 "appfs"

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---

 - kernel test bot found white space issues, fix these.
 block/bdev.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 889ec6e002d7..0e53ce99481b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/blkpg.h>
 #include <linux/magic.h>
+#include <linux/mtd/mtd.h>
 #include <linux/buffer_head.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
@@ -1075,9 +1076,23 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 	dev_t dev;
 	int error;
 
-	error = lookup_bdev(path, &dev);
-	if (error)
-		return ERR_PTR(error);
+#ifdef CONFIG_MTD_BLOCK
+	if (!strncmp(path, "mtd:", 4)) {
+		struct mtd_info *mtd;
+
+		/* mount by MTD device name */
+		pr_debug("path name \"%s\"\n", path);
+		mtd = get_mtd_device_nm(path + 4);
+		if (IS_ERR(mtd))
+			return ERR_PTR(-EINVAL);
+		dev = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
+	} else
+#endif
+	{
+		error = lookup_bdev(path, &dev);
+		if (error)
+			return ERR_PTR(error);
+	}
 
 	file = bdev_file_open_by_dev(dev, mode, holder, hops);
 	if (!IS_ERR(file) && (mode & BLK_OPEN_WRITE)) {
-- 
2.49.0


