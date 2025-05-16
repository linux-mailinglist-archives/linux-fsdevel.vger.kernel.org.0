Return-Path: <linux-fsdevel+bounces-49216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBAAB96DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 09:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0522C1BC419D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FDA22B5AD;
	Fri, 16 May 2025 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="h84Gc7Zu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94619CC3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381786; cv=fail; b=upCDExJMEl7+R7BjomSGn3rk/tochr8NJmhkUccBB0+Poj1G6TppcucufIkUmwDaHMMzunlYTCRf6jomsLb8NP8+n0Sa75/PG9nhBTyzyCMAziwOYbk2Uglz2S28qW+HChrf2LImxljAE9Xvcq/KD+ZnYp0Bz84gZxeZD7UQevc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381786; c=relaxed/simple;
	bh=waonvTcZLzdKKZMnC+JdG1D7bWWlH30pFo3P0nBYwvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMLrqiTrWVan7KugMOdh7dO5dZ0mbeQlMbxJpRqWGI80Q2cEyg5x6oSU4ItD+U+z5eHQqxZV/RjDLZ0UVE/sh/LHhykM9iOsaveJ4d2WGEe51pcr5g4V1uEiCoZfYTQ1Bi7kIYc2C2rGV8Tu0Cpw9h0ID0rx/7aIJN+gQszufOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=h84Gc7Zu; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4KB1ITmfGMi+jfVbmCfkNd+sR/ydT85o9AWQWay2741QA2eHLSU5/gFRyWMffBJE2NmKRigAWZGL3+VX8FCG/AL8EV1SzUEjjnvS+yreoJRb3IpWmBWZ4rmnHOUFDcxhmtAX7ROvVFOAhFPord6DBgiCZ0aCHUmI+eyCNT/fvRe3bKlRjzosEzveHrKK9ybZ25lqO4EH/HXdN2bBfbKWgpg5ewVURkTPRSJBppnEv/uRpDzste6UegNZ0PnmmmM++UQwRbnlnebg1uSNt+LXLkrCFRcYUwC50WTUqzimBfMQ9jCiIOWndGUjofwShEKBOzZaeKC2deBA+SHFb5e5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2DnUmoSdBW4mSEgqVGMryupXIBLFMfwj1IqdEak62U=;
 b=SxE3L0qBXxjcsGiCJTlywgNoZcBUVO/0Lx4q8eGlWrOa/gNNXNlxOzEGQrRO8CujwfWqbVOT1KcbcL4U6+nWuuLjtyaFLsWVDYuj2d3c4SAUpJcfbwy2ddwRkHVWNqr2Vqa5L5gP49nnV4U3eobLinEjyXrO1RvwV8aBCCtBna+XA8Fp8p+TdWSeKK3NrgtoHzc5ubAPpbTVB/iucAg83gtHKr4DmNPdsUmF2RlkoaisntIBDVQIAsfyDivSRGKV7wFPXUOlAGyN7dNgadGjqaHE7DFz7tK9eWw93BOua7DQ0LCyJeYFebmn1pjnWmaTmSOWkwLtSlp+xbu5N8Fwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2DnUmoSdBW4mSEgqVGMryupXIBLFMfwj1IqdEak62U=;
 b=h84Gc7ZuRnaglrWQ2GF7Fcd2sgRgaTB9u7tjnOgfj5ivlZk52iYtVGjIedEkGuH0sdpUoLV+7iBVSyccuzugrIVlgcbrL5COrHeTeDE88gv7l+bAY008ybpXWTan4ejEAri5zO3zFQ8v3AtGNR0rnhNEL0g8OfqBHrAbh+dSnf1pk4iUodlkXUfAZjGY6FiCrYw16NUJ2N0G1fbHbAgoIXuMwXr+musQGrCU2mm9p3+FYtYu3SM+UhXQDbln5t+WnAl/pjCJ1XPq30Ki0c2n1oJVl8WS/GErFUO2QOg/+9ijT3yE5vrWU798vYqYcODV8CSeum5wmB9YJJhDbne7Sg==
Received: from DM6PR02CA0147.namprd02.prod.outlook.com (2603:10b6:5:332::14)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 07:49:37 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::8c) by DM6PR02CA0147.outlook.office365.com
 (2603:10b6:5:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.19 via Frontend Transport; Fri,
 16 May 2025 07:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 07:49:34 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 00:49:34 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 16 May 2025 00:49:34 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 16 May 2025 00:49:33 -0700
Received: from se-jocke-lx.infinera.com (se-jocke-lx.infinera.com [10.210.73.25])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 3E103F403A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 09:49:33 +0200 (CEST)
Received: by se-jocke-lx.infinera.com (Postfix, from userid 1001)
	id 2ACB0600A081; Fri, 16 May 2025 09:49:33 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH v2] block: support mtd:<name> syntax for block devices
Date: Fri, 16 May 2025 09:47:55 +0200
Message-ID: <20250516074929.2740708-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <c0ecfadc57d7e595cad87eeab8dff4d0119989ad.camel@nokia.com>
References: <c0ecfadc57d7e595cad87eeab8dff4d0119989ad.camel@nokia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 May 2025 07:49:34.0258 (UTC) FILETIME=[10A91920:01DBC637]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: e186e1c8-0f99-4d8f-9154-08dd944e3399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YsquWdG2Bb5b/fzWQf2XtsEPO4HSH04d6y44O06+C4RWUImVXtSnLPyrTQQr?=
 =?us-ascii?Q?nY+WLm7En900UmCz960h2WYn5EN4Hvgjmu6IVJLnlO1g3Ga/r68NH0XJTsSW?=
 =?us-ascii?Q?zLg/uYLBbFw9DV5HaiWK80DlZ/Coz8z46dxK3zgLZJOvAVHvSpSbjrKIH50g?=
 =?us-ascii?Q?al8ani2a6t0BSuVirw9jA0/p/Ay+Jp7GnOIHnmxwrYu5Og+l1gBJ/Xb3rZ2e?=
 =?us-ascii?Q?CbGJ5C2OO3ohxKpNRiUUjwei9eX/qEgglqlGznz5eZjmlhKfCc8Px/Y3FltP?=
 =?us-ascii?Q?edrHotJ8v/q7Ws8zL9aWxs8wkM9SY1fOn9lUwHNsCOdUwV85NRgo/t2SfbPB?=
 =?us-ascii?Q?aiPklVvlVY/J44tE7xZI9jdrOm5+mqqRNp6QuJdh4e3AoHhHmtd+B11QN4W1?=
 =?us-ascii?Q?2jb9+doHy4gczZkowXsc4dY80Rqv7vQ3ot71k/ZbgbGzNGW03dhl+xMSc0f1?=
 =?us-ascii?Q?1BnzSL89ZSgaJ7EVG+sb+19Kh/B/REkd/QeCvOX83mLo8H2PYgrgDTAU9P95?=
 =?us-ascii?Q?Csg70PQzZgdmINoXmUlfcFprOkEASmHO6g/Ixb0jNM1nkLH6uJH/PNUhzqmQ?=
 =?us-ascii?Q?zzMZm4bVef183TThYGPKubjAqXp+GjUV0CSgilESVA4Gk+dlaiZ7fGeR9O9E?=
 =?us-ascii?Q?aKRNjEXLYLy1kMe33GHpN+WF3Uh1TCPnTZ2VpovTVkiLV/3Bkvkz/wFPeTcE?=
 =?us-ascii?Q?EFttOc1f8SZEGRZ5sL688lOxXc6yd/0P8u57n4qrLhUPHIndHQGR5BPnk4oT?=
 =?us-ascii?Q?2+W0MwCYlv1JrvaAycbOUbVsI1J+WG1nwGl9TN1eFdt2DtkblAorLNngLX9X?=
 =?us-ascii?Q?lQfptHkVO00GmfrwSjnY6G50tvj/DqbAq3CKCvL8ILLgIZ2d38LyN7J3TH6z?=
 =?us-ascii?Q?o7mfeXt0GvlTikCBButNT9yzgUym2JidCj2URlOUD5N2oBQLDWqmeuQzD76u?=
 =?us-ascii?Q?v4Tp82bUXDxxt7d/HxM50QrnMr6iLyc/5wjg849Okxyua/Wj8csLJXT+1Nyh?=
 =?us-ascii?Q?vGfcBk40TnvTZiy8C4f1+z/dumP5P2aavDioQYmEbJkeyd2YvYajt+1V8XKU?=
 =?us-ascii?Q?ru2oM8WV327DbQ8Dv1ukbWW+20PoE2OCIvgUegryrRnPJCPapQjl7qS832Xu?=
 =?us-ascii?Q?ehlxNOEZqaaXtDKsYJ4RQFnpGX3GXHztRkmGAOgOJKZhqaTJ0vVRW5xf8IsB?=
 =?us-ascii?Q?kcsLLWSm4mcOQZX7WHUPXcnhCbkTfNCvcD32oP6MeJXCN59ysaLcnuFkSwNR?=
 =?us-ascii?Q?pwxzDWtZAseskB+Dkwb2EDCTHHhkznYR2TlOAMMy/MN7oi7jhg139p+OHAcT?=
 =?us-ascii?Q?Suh6YZhpF+af9qJ1QWTrKrfsYhISKN1ghoBx57RpwZHehobQ76S+0wCowEqU?=
 =?us-ascii?Q?ZBjrPn6x3SgbEeGGy2Gj2yINhhyLsqX7MkbBHheYuNKi6YvhxIRRvgrKmuur?=
 =?us-ascii?Q?BJXzKNpFT2aM7enImGlctQgCjMOV6TItmDgpYHJIOsQH7FUlzHWIW6NFdPrn?=
 =?us-ascii?Q?qJf9sy9mjFg+YK19aRxSpdySqPItRQA9o0Er?=
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 07:49:34.9873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e186e1c8-0f99-4d8f-9154-08dd944e3399
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089

This enables mounting, like JFFS2, MTD devices by "label":
   mount -t squashfs mtd:appfs /tmp
where mtd:appfs comes from:
 # >  cat /proc/mtd
dev:    size   erasesize  name
...
mtd22: 00750000 00010000 "appfs"

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


