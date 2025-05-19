Return-Path: <linux-fsdevel+bounces-49406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4649ABBEC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE923B7C7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA927990F;
	Mon, 19 May 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="vhLIj55Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC41F4717
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660363; cv=fail; b=h+k3S3LJFB1l+sppX3MNFrPBfKdHuJOCvRVQnKNvLwRec1zXQ3/nvposKpMTpeJpgJPDJKgRLMTglpL5LVqgmCbKRuZSdIL1iITZunVwaAVUs/xyaUIyX9v4qYPEUAmXkzl3I4BmaoOAflnMnbsQoHSv0rc1SMWxYXWxhjdwd6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660363; c=relaxed/simple;
	bh=LmbKVXcfYffG4rJHa/4zVuUKm2YfOVsBHJoVzVV90oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edmU9LsFebbayacg06Pvc53l9n1BWU8Zu8SH6mo1LSsj1Slg0JWdxIPFuO5TpFIGQdP/Aj8ktHr6LWllvd4T4Fy3H3EANdiabrUvxtXpIb1qvSkXGUmLlhQn5iykTwvppIKONDMrfhSC9BSE6+efkKgfeYA9LJQ0UG8AVJ+EwM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=vhLIj55Q; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgQTvyO6W6rhRiv4FJwboH4NHfQ9l1uR0HUHmUxLC7EA3jyKpIvGv/EmLcRbdCvJ97H0Mg+LeO6L2HXwVfHpsUjSv+9/0EzpfvrrPjPb6ZHRvaIvNfmukCaxdK74MocLJN5opytiKPDNAi85OnIzs3QZrWhMIn4qeVlczyJ1t3os9xRPF91gan8JEE36yRmti2P3qCZNKz+unvrsRa33bNH2VvpX4KN1yBPLE/gUfRmc61k8L3fy4uVMP8RGaofmscrQ8phOhlRmbihVff0nGb++OtcPHnCKPh9Gl4SKx9kHGLbBT1PJvHAcvxPivfu1Gv3SRqIU5yYNDrp8QeDzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXoy772ehaj8yabbXCGwQYpNl/db9iyYv5eQzqkNoEw=;
 b=iMF1009DMZi8anQxnkWPHEYTK/J2m6UAIQu6P1EHtnOZ4R/nLfShFhVUl8JKBzfFNmclek8lnPAtHwYzj1iGEtDMeWXAgK8fXi5raRh2kAJ0AbFCdspr/ocy1LE6p2hMbd+tTNfrP9JecSPZMcJ/eDgC0To96Y/tF7iMqmzCgUcLKLQCFZLxBJmjjWrIBIGoOrDBeN0/eis7599I59agc9bTQMM69PCAL8gMdrwlrhqlCMuWV0VFWTOrFSXY+98BSY5GXusERSLtBfnfZLVex25Xu27DscKmgjout8IPZcj4CFM2Ksbjus9QoR1nbmRJIxDuoj+LpDUN11zRfiGutw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXoy772ehaj8yabbXCGwQYpNl/db9iyYv5eQzqkNoEw=;
 b=vhLIj55Q9H1v2yQAvHuEaO504ex/jJOimO025eN66KUyd1x0NKG/4RJ9g3jd6IZp6o3hTzrj/+GHL03+2bb3noj8+kv6sLCgF7wETtwn7PHL+R3ZO2o/qf95AvWlsL0aJKfvDy1qUYpz4IVnTCmDFnw9M74W6HII+VcKDBmPwKHa4ID+J6PIAnSWRZ5rsAzbK05Ixe6njN+fqelMVdQwEK7ULdx5yvjpeAAusowmKD/REy+drGjECgf5ksHfXJP9YA9oL+aP43PKp83fpXpAXHOHQSSlsb5rZ87G0UWNBWTp4WepWD8FT4OQbPsN+ARUjsmcfyDqUPjxljm36xOyaw==
Received: from DM6PR21CA0002.namprd21.prod.outlook.com (2603:10b6:5:174::12)
 by SA1PR10MB6568.namprd10.prod.outlook.com (2603:10b6:806:2bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 13:12:38 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::84) by DM6PR21CA0002.outlook.office365.com
 (2603:10b6:5:174::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.7 via Frontend Transport; Mon,
 19 May 2025 13:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Mon, 19 May 2025 13:12:38 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 May 2025 06:12:37 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 19 May 2025 06:12:37 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 19 May 2025 06:12:37 -0700
Received: from se-jocke-lx.infinera.com (se-jocke-lx.infinera.com [10.210.73.25])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 77CEBF4039A;
	Mon, 19 May 2025 15:12:36 +0200 (CEST)
Received: by se-jocke-lx.infinera.com (Postfix, from userid 1001)
	id 700BE6006581; Mon, 19 May 2025 15:12:36 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <linux-fsdevel@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH v3] block: support mtd:<name> syntax for block devices
Date: Mon, 19 May 2025 15:11:10 +0200
Message-ID: <20250519131231.168976-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <5a3c759c-4aa9-4101-95c2-3d9dade8cb78@wdc.com>
References: <5a3c759c-4aa9-4101-95c2-3d9dade8cb78@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 May 2025 13:12:37.0495 (UTC) FILETIME=[B1359870:01DBC8BF]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SA1PR10MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bd254a-5bd9-4b24-fdb0-08dd96d6d46a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oUKdjCmLvj55GEMxLmWWYYCXbOk0ghxwQLCWrfVchBuR3fDLiYE8G9sRoGBs?=
 =?us-ascii?Q?434l1gQV5hfEBnOeqdLkrv38XUQzgJo2Qtv5XA0SxQ1LmJfUAzBKImDxGUFA?=
 =?us-ascii?Q?Y+XuuATQVH2GNApGX/+3ieKwaPubtSsWhbt9LKwUQ3QsBIz5dApZvfSObpfq?=
 =?us-ascii?Q?GG2ZC+mTB6WRBwVgyl293TPRtAuQO3VULrjIYdVQveQPwBmCCXZekrWm+rcH?=
 =?us-ascii?Q?pL3sVQdI0zec+wCjkFJSbkCft77OALpSEiSOA/p7RO2uNoY6OV3ePBLjR+t5?=
 =?us-ascii?Q?MSCUPj9DAEdGczCRW62RICb2ZeeN4ct+HmsbULEZd3+WyFdlwrpB80B4n4wf?=
 =?us-ascii?Q?pcdWyH9DU3FfR9uHXfo+CfVp6sJYHjNR4dZbOjpOkFKcLEBRFchFTTvB5Nc6?=
 =?us-ascii?Q?AXLLISu41oBAMxBd2MAcWcvxCoAhZm2NM/GAxAsnAiTsJcWb2MWFmET97zOw?=
 =?us-ascii?Q?tYFqt4Xw/0FyP5+cX2Es75Qr99TO8eIdw5QCwN7RenMXWB87IytO4ZWFoOfn?=
 =?us-ascii?Q?SCDC+2i4P8m4FEOh75wo8xPdUm3hxu5ZlwmG5axiB1UgCBGUFhnyE0+7S+gF?=
 =?us-ascii?Q?GBZ8c/5ngPMbNqyyqB10A9uGpuneGKkRTF2OmrYdYvPqzN2iBEbMK1CUF2MJ?=
 =?us-ascii?Q?Iy3LifKbt7JfA3rpc9QGzDG/IEt10L/q3vidCUfnMclSVVsAAIGb7wM8swds?=
 =?us-ascii?Q?jaWtUfqlHuYI5uvAkDOKUcmSW7lbbm6RYeyxw0kLU00y0qVhX+gp091k3D4b?=
 =?us-ascii?Q?ZrjqYSAjaapa93MyVDxa3Vu5MRRQrkntq/i4BBnC3J+9fx3AN5F8X+dKtQ7+?=
 =?us-ascii?Q?QdoX+boPur+lQ/FqHuOTPQlRoLEEptJWFve2ZSMeHIS+nHMNryjwIxexaSgp?=
 =?us-ascii?Q?YXLSq4vVkjCGQE8clSvCQRsiUF2iaH/xgmWUFbSaT87hrKXZP8N29GuDKDfH?=
 =?us-ascii?Q?FSRs2AsnxVYEXeR0lj/fU4MUK6GcDGrGZma6QmTPDxCRfTVOPEsQjXo2RewD?=
 =?us-ascii?Q?5M9k7ivZZe+nveCh5AonCihb11RuaIoCrDoAM2KEIK3a2vOCtlO6TfuxNS2k?=
 =?us-ascii?Q?FweExLiB2mg8UwG3fz4CqPBu9DoQa2nGzSDs7cYCimbrXlGwlWrbAJSBeCrq?=
 =?us-ascii?Q?Fjb07fu0UZTGQE5cOKDQRjyeb6RHQ2/pMjqmPodNIDOeYqfzwoR+K6+09mxo?=
 =?us-ascii?Q?HS25lgX2b6kc6P/Cz2Gqplq1wvY16HXSvE7F6TWsFbAo1nBy1y3WID00GgHr?=
 =?us-ascii?Q?uJM9TPe+MlMF1Esqs3EzdOcei2tYGVGRj4Wb2xoQqZ9lJGtJ6Ov0LxXI7G1S?=
 =?us-ascii?Q?fjBFcCMkeEhF/I/IVzTC6ZLq4y+BYJnb9C5qCrgfNQAaLgjGbOO15rkuBQsh?=
 =?us-ascii?Q?mdtxOQbtRsRp8FS7iFy4M/OmVbFYU0VL+q0YagPhrt0S3CvynA78G2+YEGTw?=
 =?us-ascii?Q?TpMGeCVMK1ZOtCt4VQoUbG1PHPYujOqfMasXK2qDStmT+dYjeYPvJrtpNZLo?=
 =?us-ascii?Q?Ei53/hUX1qu5K06fdlDjFynANZZV49LdhEbZ?=
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:12:38.6424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bd254a-5bd9-4b24-fdb0-08dd96d6d46a
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6568

This enables mounting, like JFFS2, MTD devices by "label":
   mount -t squashfs mtd:appfs /tmp
where mtd:appfs comes from:
 # >  cat /proc/mtd
dev:    size   erasesize  name
...
mtd22: 00750000 00010000 "appfs"

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 fs/super.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 97a17f9d9023..8c3aa2f05b42 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -37,6 +37,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
+#include <linux/mtd/mtd.h>
 #include "internal.h"
 
 static int thaw_super_locked(struct super_block *sb, enum freeze_holder who);
@@ -1595,6 +1596,30 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 }
 EXPORT_SYMBOL_GPL(setup_bdev_super);
 
+void translate_mtd_name(void)
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
+	}
+#endif
+}
+
 /**
  * get_tree_bdev_flags - Get a superblock based on a single block device
  * @fc: The filesystem context holding the parameters
@@ -1612,6 +1637,7 @@ int get_tree_bdev_flags(struct fs_context *fc,
 	if (!fc->source)
 		return invalf(fc, "No source specified");
 
+	translate_mtd_name();
 	error = lookup_bdev(fc->source, &dev);
 	if (error) {
 		if (!(flags & GET_TREE_BDEV_QUIET_LOOKUP))
-- 
2.49.0


