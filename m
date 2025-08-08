Return-Path: <linux-fsdevel+bounces-57036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEE1B1E320
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794F718A040D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 07:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC310248F67;
	Fri,  8 Aug 2025 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C2A60sDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012009.outbound.protection.outlook.com [52.101.126.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074A2459D7;
	Fri,  8 Aug 2025 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637327; cv=fail; b=foFn2dFGi0fVGudAyfrEGyGsjEbR/MB+nKwgJLjy7OhOV00d7ChCJpwZBEUMSJLl2lXNYOQ9BCW2R4R/S/28bKkRJHuDRED+j4dWy1b22JTSG+EoM8cDFp/dlY3dpTIZRUD+NhCJEjg4u5PZTCNxdqVvkcc+Pw+ZInr43Y4zmsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637327; c=relaxed/simple;
	bh=ipVeB1A9Fr3zgE+2bRGHj9MQbVVs6XiQt8GOhhDKFnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBY1s21fWYWkcOFMc1mcXo5Ujb95HTUtWusZ80+gwdmLmuJmTy8cfCPxFMYPDWCsHneoO1d3qJOuwHj/+izctnb5Y92I3ORBb37//sFxoCe+22lu+1NvKu1XZdOsqjUuDg3ZRGcyI0Z/vvVIw+8hthSfkvj26rZQ7ZgMAdFjVNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C2A60sDL; arc=fail smtp.client-ip=52.101.126.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTz88XzaHf9BDj+cm0edgX8ni9Jl4h7vMuxUbh+hecwBW6xUjHaezt4cQ5OJMffmoC3k0YHOE4Wyd6AGGJGlBVzzsRd07NIFceI52VURVk0hjX9+INDs4fl7mdhiLNNkwICVq7xRrtirBRFZl77tIfQyYqXSme8KxxNTDdTNSdQYzfWFCjjd0KE6pYfJPVeq6qoM3bR7aE27PUzG7oNXsG5+VpRZIN/GKC/YBp5On3FepTIe6LPOF6wq95BLu/H9dJVSdusXw9SfjsmTPryUoxKYJ7gp8MB7nrSLJ5ab4qQtiRqHbkdr81EmCqnb0PZyCJIKzVPkvTs7bCiEANSbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo/t/0yTfVgv3xK/iqm7LSSc6ZPLv4J0HIhqJsm0RUI=;
 b=gEWrgX0W0rU+xzXVjFfNEGxrPv5xvNhtciyakUB8Vh7nDXuHd4D0f+D6pbU1aY3Q3DYflmI0hKBAmDeDY5Wi5C9Pditoh83Sf0cUvduO9EcCPFRiEz0aC1x6L42ca8Z1LsE+4BEhqTBuW0GsxMmmykQHeWFue2RsNAujqhJnLf/utDSOcjhFauVrPUlG1gxaSUYwzuwPjpAkWGXVAb9q3W/u6tLiMRWMWpIwPMBvntDZN9eGKq4qDrxxhNyQBAnTh2ZQM1F3QwG0CqtWgsn27CzLB9MJ3Yzj0C/2T6clTfbhWDxbsrn6+hmtw6V9TTpbpRekuYY3l6rw/ssNIkrApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mo/t/0yTfVgv3xK/iqm7LSSc6ZPLv4J0HIhqJsm0RUI=;
 b=C2A60sDLT+whzBvKO5JsSyaIkB18vefIP/E2rRC9rwNWWH5LvTED+tpu4rT5Z9b9bo3rFmaFuS/fwOg6Xo94ot9CpNECFtZeuWujosAGV5iYqeYJ5IpnvC+JO4B5nv1qJWuWRdmCBgVS/gQ89wDug/IDYMXMSLnyX9q7TUabSwS5VgVXQffsgiIvO+FrSd5kJkwYsrKQS0Cz/lJdNtudo3oYKF39i+vGdftDkyHYjJ7eJbGkS4flLb6OEmjwG0p9KuwHqjpZTAnfA0ogDAYIVFcicB+MKIwqsQYFR2d/3ew99qHo3LPBcKeUMfOh8TSpeQ9qgu+RYFoOSe7CtOAYXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6463.apcprd06.prod.outlook.com (2603:1096:400:464::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 07:15:17 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 07:15:17 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-fsdevel@vger.kernel.org (open list:ZONEFS FILESYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 6/6] zonefs: fix "writen"->"written"
Date: Fri,  8 Aug 2025 15:14:58 +0800
Message-Id: <20250808071459.174087-7-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808071459.174087-1-zhao.xichao@vivo.com>
References: <20250808071459.174087-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2034b4-8e3f-4213-9272-08ddd64b53af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPEHLhSNy/9ifqIr33Os7RYqxT68ow8buktNjH5Jq5A9Q/IDWBKNWQk5sSo1?=
 =?us-ascii?Q?o0m0VBmKw1o8bxJQnWYTXkBpOyJ+K1KcifUODkZTHeEATPG8NwRtKc1toBeS?=
 =?us-ascii?Q?dc3E6z9aVvrEC9tceCJ8ytxKI4y9XF/+r4pDQv5YJ+mZ4TNa/87lE1sHnp/W?=
 =?us-ascii?Q?ylK85EkX7/tb7MfPtwVPJPPgoqDa7CzzxrloBC9UZtPZEb560CTrmqt25dAt?=
 =?us-ascii?Q?h370gV+12NdGUaa3K/tpWmq4q88JiHl2DvzARODyz44e+Zv54ugVdfgpI7ZJ?=
 =?us-ascii?Q?g2Lxh1eV6/mugRYq02OFsKqBJOuSH1Jhe1OLhiDlKGRZrH+wdRTBdbIglNbb?=
 =?us-ascii?Q?DjHg8H5CAjylHMSzUGsejWyegQQvRB0omOmvGrPZPwqQ7EZQaXM5rppn/kYg?=
 =?us-ascii?Q?MSJjyyUJH6uTlSiSeLzpb2iw1sMby1cRsVYXoCnWPLjpPjWXnYsAfXAceTMG?=
 =?us-ascii?Q?TLfthP+Nrjr648dQmCyh3hPK/HkhahNBvvGNM9v/6Jf2W8bjlUA8Lt8b6Vp+?=
 =?us-ascii?Q?uAbzddH4hItA2kVa4Fi2Q1xLgmKyrBF0P112Z60t+Oh05BXDNjCvhg3FuUYE?=
 =?us-ascii?Q?WiiL53IaeE6W9CKz9AWlvjV6TrMCKwC2FWQCtaDLU7vchIOdP8stlUZkNFHi?=
 =?us-ascii?Q?XY5IQ1UxsiYsMyG4rDU5IqPOUZ/B95vZAGpsFgoHjsNYRnCBJkzsM3n1iqKD?=
 =?us-ascii?Q?UzahHPANYZbLIygST+NSIcYep/hImG/q/veKucc9V/AnjXDX+BHw25j1A4AN?=
 =?us-ascii?Q?19VgQXXlAwqJshNQ0Zyx7sYHPjQRznFFU0GHS3Q51hwrjhRXlCcM3Dzix3L2?=
 =?us-ascii?Q?8lTCm36Dye2jyxPobvCrrv41TPcGp7zSIOyF3eJUyHmIHSDU2h+FFpvdSsop?=
 =?us-ascii?Q?zwlTduTLlHa0Ah98jLAlj+KxHyxmQ9yK7nLj74BimHAVGKxWo6UBVAOfEMPd?=
 =?us-ascii?Q?xFjjY/RRUkH55DNtRiHFPbxjXvegCTy5QINNdhLEgS43/rxoffhw102gdhlp?=
 =?us-ascii?Q?4yJ1/mCdkd0+KaUpgi2MasFNjThuV0+gf5ardOXqMICFy62VO2Xx/hnkTNIh?=
 =?us-ascii?Q?zfyuIJKWFBUoQMdVlyUNUfDefQyEmIK3WY/RI72j1CSzggK4bhhGCLhq+B5M?=
 =?us-ascii?Q?T0nkyBpRYoc8KN39xh4DICcPN2FfER6hsvttboqIwgZI0pZuJCX5YGTq6Vgn?=
 =?us-ascii?Q?KhpBo1XqLf6Oz15fVFA3/qpOe+44BYCuaD/9BxgmWB9A0nBgvJSy0F5vZ5dg?=
 =?us-ascii?Q?HaniFUuXFqCEOhoCbqssKNJNoIV09MLrtqt0wgFLSgTCbP2ZWQ2CKLV8o5VP?=
 =?us-ascii?Q?r4tD3Y0nlJi8Y+qsRc217zINuuP6pRHgeIOgLUULsYfzai2yrKmnPd1cUDhz?=
 =?us-ascii?Q?kM0D4/SbECF7eHpj5ZQHmV7okMiTrxxJ4G2SjnjDde5LpLBIClDB93Q+daGQ?=
 =?us-ascii?Q?4DKr+Dw11dZahk8/0QLb+5btI91hmvPa9VKD1iAQ0HMeor1GtPF13g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1WcPCiwXfoe2SebRYVGTMcZpOJNoXXSrseimY97b5keATsEbjjKRMgjNsXuV?=
 =?us-ascii?Q?Mk5QlZtxL2eFO4H2zJg9RxmMJwct8yrA5Yh/g6g+DW0mJGNibfT/PFKDytyr?=
 =?us-ascii?Q?nWtEcQwJ49LqBe8VxroUVBFfjpdMciqFO/ytxsgAj0NnV0osHqfwLCJGJWnx?=
 =?us-ascii?Q?CmfRCHV8W4yZGXaEF5k0n9rDHYqgVS7iULVWOk8N6J+QCL8mqCKcazlwyzHZ?=
 =?us-ascii?Q?J6CO3T/Qs4eChrFREBAK1J01ljbXslp4XGeS5T5w0y964ALNH6hTUulHsYGC?=
 =?us-ascii?Q?X3mKxV95P7hvCnI2uCVvnkN6MJ+m16vaCRoNMBucala5VYp6ynQaZ/HtYytP?=
 =?us-ascii?Q?EhFDE5oA670SoMLX6ZX6ODj9ItMMyftKwaMDdBB+feHjtaRGQkpRyzGiA91q?=
 =?us-ascii?Q?LqxK4XHN6BV1MHJzh+1C+vP9joU5G81eEcWhk76roj6Fv4JO8mhJ6nygZ0Mj?=
 =?us-ascii?Q?Y6oMS9n6j7p1ioWeKT/q6kMstUNdcfj048uE0PMqm8Dh38eUdpGSRK5/yd3W?=
 =?us-ascii?Q?MMf23NOl6kCiiSbyA8+IIcaVsHh1GdqXJ1mmoa8+D5ppm2MMlYqmvEdubnvv?=
 =?us-ascii?Q?/ewOex/IpgnW6J0YeQb7fVLKRSPtLLE3VvgqPVuIaCULUrp9Gzhbo2lYLyEx?=
 =?us-ascii?Q?ctfTXqOZZ9UX9Pe/K9iZbamR+QQVcB3M2NSavZu7KOC2EcgHnaaHEDbl/s/r?=
 =?us-ascii?Q?yOLpOh06Dih6KH9vVKazEKLk3NIz2Fg7JArRSio88VKhyJNf6nZ2STsyRl/Q?=
 =?us-ascii?Q?FQHFev+n/qsttm06xZVi2/TvHQI5+/0tqYCOiK/2MZzcW8NntohesoCEaBKt?=
 =?us-ascii?Q?GSkaPsrRMJbQdnuFsBG8Mo7YAL9I4fGGHTeIN+Il7wP9BF3keqNnQE9fqbbf?=
 =?us-ascii?Q?x22pxQSxLF/F2aJeRsmr3yUturHjSau3xE8jXo2w6c3gUlIaHtn+WRpYQzFB?=
 =?us-ascii?Q?kcgPDRLFiKT6fptlmhJAAynSKgAd2FS+W5vUnDTgrQNV1k4hbLVt1QIZNGQO?=
 =?us-ascii?Q?ZXhtHjboB24BLSg7FqUjWqtk3NV1TAqldJZ2G9qbAa0RxYrVd3oO0v1cv5LR?=
 =?us-ascii?Q?VXAL1WWoO4Piy0qnecJLzK3Qj8prSJFkkef6O31gmVSnqbjCd9VBJOzWzQrM?=
 =?us-ascii?Q?WvgeO0oT15xPo6Pc25ELqT21fijuKVq61iIH72/idEgzgCEPqt4aK4jfNC2s?=
 =?us-ascii?Q?TQ8kjth9pw+KceSlKuh0RL4wSOGss1h6ydCCbZxVwvcNt7srsfWKdLpmDmWE?=
 =?us-ascii?Q?u7o2rHDys+C6dX52o3Ng9Sx/NHSQClfz7PtmXlrbeB7HiXAoHj82py94Qlnl?=
 =?us-ascii?Q?I6ooteE8ffKtctfKQmWrKxENebQTvkKR3MyxNp9zOTiiYMqPm7F1VEtz8sXG?=
 =?us-ascii?Q?EJQoIkhtHxzC0Pe0KRPEiABi8YsIFEs7fC7UXt6zKW7tyhUmA0NvVcn2riso?=
 =?us-ascii?Q?/5AXJwW985tFHRP9S2MLdORqWCf50XRsGHgUFYuMdYNigJPVIM6Tc7q5Piaj?=
 =?us-ascii?Q?jwldcCjSBoT1TPlhYUjX7AFPYmPDPR5/azHUkPH4LCAs2G77nsI411YiOLH5?=
 =?us-ascii?Q?ozMixpi6Mpl7ILxwsgy6cKKCtRZg4wu3gkbj53Hx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2034b4-8e3f-4213-9272-08ddd64b53af
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:15:17.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YiX75aVW5HiQhH4luiXa8XCn2VRQORT76MToYckAtAeazUG4t/7JAWhF4MK/5sv7sglchmGYgwMUzuk6v/irA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6463

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/zonefs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 4dc7f967c861..70be0b3dda49 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -268,7 +268,7 @@ static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
 	 * Check the zone condition: if the zone is not "bad" (offline or
 	 * read-only), read errors are simply signaled to the IO issuer as long
 	 * as there is no inconsistency between the inode size and the amount of
-	 * data writen in the zone (data_size).
+	 * data written in the zone (data_size).
 	 */
 	data_size = zonefs_check_zone_condition(sb, z, zone);
 	isize = i_size_read(inode);
@@ -282,7 +282,7 @@ static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
 	 * For the latter case, the cause may be a write IO error or an external
 	 * action on the device. Two error patterns exist:
 	 * 1) The inode size is lower than the amount of data in the zone:
-	 *    a write operation partially failed and data was writen at the end
+	 *    a write operation partially failed and data was written at the end
 	 *    of the file. This can happen in the case of a large direct IO
 	 *    needing several BIOs and/or write requests to be processed.
 	 * 2) The inode size is larger than the amount of data in the zone:
-- 
2.34.1


