Return-Path: <linux-fsdevel+bounces-35954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B389DA1D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 06:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73740B2269D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 05:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD8F145B07;
	Wed, 27 Nov 2024 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v2Ut/Ie0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC613CFA5;
	Wed, 27 Nov 2024 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686516; cv=fail; b=L25TwVLEhuDgx7P46k/3LJQ7bbyH9FoWbmMRDtB1T+kukVy3dL7U+vDI1rqvX1LMnEFuJhcyU1CJz9ZG8n4opsZ3eJCoofF+DoL6rsFxkygXPaDWgqNXroaAqJs0sBsibHBZXxvu2knyRovh5Hec5sw01B4GP1krQ/f7BycSWZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686516; c=relaxed/simple;
	bh=Jq9GyLsbmhf0E4AdbtjbClU+NXZAKeKhBPg9uGWKYw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsr/s3nvgEBTJsW1ZYD3weY6GoJxuQQn2A799vOtjy1OyjpEo1I9wpTsSrqA9V4334dZU2mxo72Oj0j/yeWxDI+Tpt0X0ssGRBwW8ES0q2iCwJF5JXDWc0RKTUjRxqpQLh0wfkjzuKwZf3Y0C5Edpq0E5j3ncQ81W0BOjfTLpdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v2Ut/Ie0; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flKorirD8/GBQS/+EuMxtA2oFJ79MYBAwVV0hPVamv9ActuAevIYO3xl0Prg5uqc1qXgggLBkHnpH1xhiC4PMMqJwEoRL1J/ZQfTSLE1mQZ1mjwphgHxvj0ABt7nE42hzF57AUyFvKEMu9Lxs0Q7iq4gDymTNTN5JGDYkFravjgEYGYFnuMjC5O97KvWDpsMByPvtIQa7aw2aCQvUSME/iTrNDiUzAHyNOXdQ3PX0Pzss2/irnFBZV8rWxMkk5xy6QAXMDGYwt3q0nbWUtDSofmL8Au7yvJHDn9yvcvrLG4D8BzFsiVV8Fa6JHSlqWudt4i0I6Rdf6fr77Ujj+N3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52GXtxbgPZDYGiSzCy2z3eNOxOPwtwkTj6mpZG710AA=;
 b=iwQGrX6XY4hY7SCosUaU0ouPDzta9/bZksgvcCJVG0V4YYd2W/546jL9OCNRoI2T1XHWPQjP++FS8hcWNMQm+D4y5sb5O01W6/t8cV7EftOpBeFGUlgE48FkqPDd1/A7830I7FX/fLkScOYLJKsEq+QSA3jqHyk1ujYagCFtWOmwoxllo3FesLETb6jCGSG9aLoXxFDXNF4kZcYtV8SChgrqZdds/FTJoR/lwypisb/5/pID61Tso07Pi4NLN6Vu/uhU7gfZITOejB8RmNo/DSa2lRRZFfdbKBVaONmo0FLN1W0M0P8Izl+DAEPmdF7gwRmkHruJzMCcw9y+f0QcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52GXtxbgPZDYGiSzCy2z3eNOxOPwtwkTj6mpZG710AA=;
 b=v2Ut/Ie0eurqrVUJwKsxTjalur46BqPYbuO9QiRsPA6zmR/zHqEWsR0evymekwKid1f0JOedYqPE6lrB/oVn1stcz26XGFffEeDVFcYXLb0FLVwwcA0DMop83yeJvXRiSHrcTFp2wWlSNI48ibLZ/B+FUTVOh+aPeBuVXMCVa2U=
Received: from MW4PR04CA0223.namprd04.prod.outlook.com (2603:10b6:303:87::18)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Wed, 27 Nov
 2024 05:48:29 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::d9) by MW4PR04CA0223.outlook.office365.com
 (2603:10b6:303:87::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Wed,
 27 Nov 2024 05:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 05:48:28 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 23:48:22 -0600
From: Bharata B Rao <bharata@amd.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <nikunj@amd.com>, <willy@infradead.org>, <vbabka@suse.cz>,
	<david@redhat.com>, <akpm@linux-foundation.org>, <yuzhao@google.com>,
	<mjguzik@gmail.com>, <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <joshdon@google.com>, <clm@meta.com>,
	Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 1/1] block/ioctl: Add an ioctl to enable large folios for block buffered IO path
Date: Wed, 27 Nov 2024 11:17:37 +0530
Message-ID: <20241127054737.33351-2-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127054737.33351-1-bharata@amd.com>
References: <20241127054737.33351-1-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a54189-ff83-4cd6-d561-08dd0ea71e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OPGsxL+FfzQhlmDxWhzEL9jbs2Z6hnxcYkFPCrb0ecwaUdKTx5fzk86wo7Ex?=
 =?us-ascii?Q?a9J1RIzZ2XGXvz1B7OfnkeH9niQQbToe0fRx5Ne5VAtB+RA3Tre84ICiLy4F?=
 =?us-ascii?Q?iTfKShqNg88DUOxokN07isIgZsNDyRVU1H4kVpHTGg7QX3+jSLAE6bUMRvpf?=
 =?us-ascii?Q?lxg/OoV34/06mbvO7eYrfJoxGl3zPe87jXDDDWsdOZN1VEthknJvuekQ4Vbv?=
 =?us-ascii?Q?35btKnGr02HmIT3x2vdmc3VvBQfn9SHNmh0M1TZtn5UqGozJA7uTKprYKAdO?=
 =?us-ascii?Q?A+qqeVbOrqViu20oV7wp0RnlNpfJltCHS5rCEKPT4v1hFsddKN+gMp/VldaH?=
 =?us-ascii?Q?K1hFKZD2OiDlVJpoXiLiane+5zye4wiJlpDBDzmtphuZ1KIK0p6tW8OwZDKH?=
 =?us-ascii?Q?FoRV9W5yX5KP4kGPcz9vaGIvyOWSq7vtE0G0M5iYNqYdK1HwWDWTkDOHLHko?=
 =?us-ascii?Q?LD4JvKN91BVvtnxTd3wAuHWBOTew3EjF0zp8j+V3mfECQbcGPGJOVVd5+GBT?=
 =?us-ascii?Q?yTrgdOyAAS4/ydCimZEciHsinAE77ZJWkbeGJ1i1ypxlsGp1mbG/DC3Q1f2m?=
 =?us-ascii?Q?TibhkP0G3+GZIxtxH6BqeDag941G6QTmiNPGFGhFfiKYkMt950+3FfshRuCl?=
 =?us-ascii?Q?jrsiMv6y+lOwzVjKgeOcoKYMsq1sFjqu+ZpwfzUfUXJN/spN2L9FyZU5iMPm?=
 =?us-ascii?Q?HzLGEoIjSW7DQJ+BFGcQm9j8VzhHk2kAcz0bMC8IqNMZUHxM0joHLPS/fvkI?=
 =?us-ascii?Q?7gCFr4hkegUqXSP8JAUdtj46KM5Aop/cZNcybx4dfFfSJX8Qn3osAuef4k9f?=
 =?us-ascii?Q?ykue/W8x64G3Zki63O6FUOyDIxnTUG76tuBFpfNBDm4d1aFkqj3HAfZGPWr2?=
 =?us-ascii?Q?eu2oBwJH2ArhBctZYxLkP0MXYZi3/EM5kBXsEy69aKkM2123/pTrOwnPKgU9?=
 =?us-ascii?Q?hnN11Wxd0OfSe+9W8u0NwFxuLm3CKVvhnqpmi+afERkq/S+ZP8smECSCJdYu?=
 =?us-ascii?Q?gL7OPmPUtrpwccWL19JPAr0rPyab58wmUs8pWGI0HYKBb2YTtFgsQb5ZG3Jv?=
 =?us-ascii?Q?sKj67pqP6lTl86MYJrcpKICGaZpDseg3RPhqxUBO/gdzrz5o+Tf+R0B8JnG3?=
 =?us-ascii?Q?kypPnbcovHxNv6v9NslXmdoiH+2You7LSS5tTLqDLnhH3Zws0kupyhP2KZr2?=
 =?us-ascii?Q?5ffDrYHH4ktZI2RvjtpeVA0Bev7/piyCKu2dlyIGwiD4sNAoYVBmSqdlh8QN?=
 =?us-ascii?Q?5jQ0tHu/DosdXDcHttf798eYA0N92K0hvO1/RWyQ45isTjK3Jci7kH8v/q3h?=
 =?us-ascii?Q?mZ3fERapdXUbQ3ev26ozeqAZutFZrxLnHoIcAPLEXUpNhABDYMiy3PlP/AEX?=
 =?us-ascii?Q?4zBSFUijLWrE4buaflRkNcSO8qc4eTna8MFtdqRnkVdlsDYHTSbOWaKcOQjN?=
 =?us-ascii?Q?KhyWsRz61PYgQQLTWB6q4j6D0aitGuSW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 05:48:28.2973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a54189-ff83-4cd6-d561-08dd0ea71e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355

In order to experiment using large folios for block devices read/write
operations, expose an ioctl that userspace can selectively use on the
raw block devices.

For the write path, this forces iomap layer to provision large
folios (via iomap_file_buffered_write()).

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 block/ioctl.c           | 8 ++++++++
 include/uapi/linux/fs.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 6554b728bae6..6af26a08ef34 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -548,6 +548,12 @@ static int blkdev_bszset(struct file *file, blk_mode_t mode,
 	return ret;
 }
 
+static int blkdev_set_large_folio(struct block_device *bdev)
+{
+	mapping_set_large_folios(bdev->bd_mapping);
+	return 0;
+}
+
 /*
  * Common commands that are handled the same way on native and compat
  * user space. Note the separate arg/argp parameters that are needed
@@ -632,6 +638,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return blkdev_pr_preempt(bdev, mode, argp, true);
 	case IOC_PR_CLEAR:
 		return blkdev_pr_clear(bdev, mode, argp);
+	case BLKSETLFOLIO:
+		return blkdev_set_large_folio(bdev);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..5c8a326b68a1 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -203,6 +203,8 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+#define BLKSETLFOLIO _IO(0x12, 129)
+
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.34.1


