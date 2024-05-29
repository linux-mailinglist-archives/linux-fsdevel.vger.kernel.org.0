Return-Path: <linux-fsdevel+bounces-20461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D081B8D3DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63D61C22EFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0B91A38D8;
	Wed, 29 May 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="AHyPGfDd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39A79F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005671; cv=fail; b=V9ocMpOIMW8MKaS4N74rHuNORk9ay7lymHBicTCGNdV6sdH7l1/FVI5nGu3XALf0H1LDNaGhZIju2eHVs+cfiuMdz98T1fZoKQUeQfbF2ocb9d/lZflC/MC2LfYVVEYuu0r7jSQ/yf1fqmqrn4K1UoNJxTP6/PBaXZCgO0ESJmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005671; c=relaxed/simple;
	bh=8+CjjG7OosZE5XSf+uanhNXvMtjmVw5S8JIc4d1HJOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ekG2NI336u7GgfpoYTNroYbEVuqasV9CYACLvKlB0af96TWXZh+tX1ShtyqqUccWOrEOoFNhonY2/qxajrhPyrPHO3GByyysetJgjhGPr9Kfon6AgUl42z2oas2RjJKd4gghJPB/YcuQv47FiV0a2Vc1L4LAtoZAwYEY65z0630=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=AHyPGfDd; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169]) by mx-outbound42-38.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca+oz6BUk7wuw+xHDboM1NiMN6RILdtCNtVgu5qRyEP7UCfd+u5qNReWlb/rxalAFQHeX1lmPuXvNAroogA5NMmyUCCuP0nGzx6vIVQveI/X9l3wSEZP1rDk6RT/zS8DzskcL1z/J1ccYHq8ZtDlWtfDnHouaRkLjV2PkJO6eybUxKVZn20jBOUmQwooo1umOtb1HRQV4uYdZKiEkvnP8YJIh4zHi45P0VJ24YhV0YhzGxImmXX9Viox+bOmcGv1a6+iPHpNRY5w9i4R312ImASVPrM2DS8m5Xai2r2GIZH2lQrltNW3ILEVbMoO/DQippoLnwm4na9kCZv5IAcyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erWeHlE34z5nFTynehSk7CTkJt6AlhU0HIM3Z++oz6A=;
 b=Wo25DO3km8rWAhmZgSYfcVYlcCnbBGk80kuYxoT3QtFO5TgGxWGOgBFeHIlmaA6uDMW6xP31u8axoCRClST7affhCDlmserT+LxHY6PUnUUKEnq/cCwp/2Rf1zCFq8C86FmJn5A8eggYbuv8+XOzFr3w0iDqDl+r7ujgUNt27mwT3OTcEbvmTBVasVNmHF12fsPZuevyouWkQGC16RM/8l0qgTfg2xjFtiaBE5stwFY3JH3wZQL5tSWl3bJ0W1Z6N3TQxgeaOvYU5LOFXe9oMrzrR9U/Ezf/A5nQfiQZtl/+++5mELXQoRAcjy+FNll1gQRWhpBaFUaig97ZJqpoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erWeHlE34z5nFTynehSk7CTkJt6AlhU0HIM3Z++oz6A=;
 b=AHyPGfDd96741EDMnt3hiju1EmvB4AL/wYuNfPEsCtBwanTjgv0na5rPazmHroxo+Ajt33tB2pGLZI+DPfDBvX6KkwD4TBQaaT5X/OEr/DRmQhut9tqWk1YcHuCbfYmD1eQvBURLJ0S1Fb7DobnUXsynkMjXJ0ZhtmeyOnu6TrY=
Received: from BN8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:408:c0::36)
 by MN0PR19MB6116.namprd19.prod.outlook.com (2603:10b6:208:383::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 18:01:00 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:c0:cafe::1c) by BN8PR15CA0023.outlook.office365.com
 (2603:10b6:408:c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31 via Frontend
 Transport; Wed, 29 May 2024 18:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:00:58 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 12D662B;
	Wed, 29 May 2024 18:00:56 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:43 +0200
Subject: [PATCH RFC v2 08/19] fuse: Add the queue configuration ioctl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-8-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=6109;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=8+CjjG7OosZE5XSf+uanhNXvMtjmVw5S8JIc4d1HJOw=;
 b=21TmzyP9Xo/y0AFbg/EKTEFwFtoNneIzi7B5zPXdGKXNCtqTCjQ4ie7i/ZCY6IoJHMFHZrOsb
 GdO4fd8rZLpBhS6AutMK+bOfYusk7/ssCzM+beDC2hQd8NdGIQph01C
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|MN0PR19MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 43de1859-d968-45e5-d731-08dc80094b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmR6QS9ZV0NyQi9jSFdTamNnZTRPaEIxVzB6aml3K1EyNWZJaThHNENET2Z2?=
 =?utf-8?B?SGplY2tRODBVbWZzY2Q3b2pmZnVTN3FKWkFtZFpkemF2YXdocWlDeFBvL1dl?=
 =?utf-8?B?ODkyMHlLeG5ieVRMUjVyUkVhUEY5bG54SnVVcXRMVVhQUThwNFQ0NDlocW1Z?=
 =?utf-8?B?SW5oZTROWUJUMVhubEtVQjhkN2F6QkEvdGVMbDR2RU5ma2QreGNuRnVjRmw1?=
 =?utf-8?B?blFhNGE5VnJFVlAxUHRnVUpCVTFFZ0t0ZTFEVFpTSHpFM1h6eXVLdzlHSS9x?=
 =?utf-8?B?cFlka0QxSWhPNmtKVGV2VE1teDkvTjZtck83WDZVZ0xiYTlBV0Y3ZUtJMFFW?=
 =?utf-8?B?MHgwNjB0NEZ2WGlWb0NMUTFtcDZaZWNGTXl1S3dkV05HUU5TdU5qdUYzNnRs?=
 =?utf-8?B?UHRaNlMwb0xFd2syOVV4TG1XOCtQM0tlTHhzRkp3anRLQzY5TlBNMUZxOENu?=
 =?utf-8?B?YWh1M0FnREJ6SGc3b1ZOcEFCVCs1T1cyMmR6ZzFJcTM3eGRac1pKbzRST2NL?=
 =?utf-8?B?QkxiMVI1M2dYV0IyM01RVitydmt3VDYvZ0pHVDlXN2xWcTk4OEJ0UlVVNlZr?=
 =?utf-8?B?aUp1RW8xRFlZYVVpeVh4NkJBYjE4Mk9TRDRKUCtmVnNpUWowN0pRR0lpbGVW?=
 =?utf-8?B?N2dleW9tRDAzc0VPTkJUcHJFbVdvVVZOYWpncUppL3NneVh5bWdRVDFpVzlF?=
 =?utf-8?B?R1U5QzE4RTBLYnB6Qk1EUm0ydFhUQ1RUYXd3Qkg0cUJtU29EYzJPRlBwRC9N?=
 =?utf-8?B?N01VOGZUbm9mQzYrWXBVUmFScjhRN1lWSjhzWGpzakRoY2EzaWcyZUx5U0pq?=
 =?utf-8?B?T2xCZ1gzY2ppUjBtM00vTWc2ZENXM0lrRklieVZSWUhOUzFCdGRvWmxFdm5U?=
 =?utf-8?B?WGoxTXNCK01vSDRBczZsTTczODNMREtsN20yMzU3ZEJyYzEybkJIYVVuM1k0?=
 =?utf-8?B?REZRWHd3UmhpY2JVTHlWbjNZNTdQUjlWanErTFkvcG1OQUV4UUhsWEhzT3BH?=
 =?utf-8?B?U2RrTnplUVhvV3JhbDV5cjZWakcvczNJMHl1SnEwNFh6c2xYbTcvR2JnZVhS?=
 =?utf-8?B?WmtQY2FkU0ZTWE92cEhDNGVyMC9HTldJbGMzYmtKQWo3S00wWXhtbnU1SDY0?=
 =?utf-8?B?Q1hPNFc2aXdLLzhZc0J0bytjNE81ZG9kUi9ndGxXV2ZxVHRtM2pGZ1JlNnpN?=
 =?utf-8?B?b1AyMVFEaFZ3TU5rUXZuZ1VXT0I2dUxENi81L2VPcjZIR3I3ZTRURklPdG9Y?=
 =?utf-8?B?YlZzK1hyRmlJazBXT1BSbEhiVUZnK3dwUHU3YWJ1d1IwYUhWTzl2WTBuY1lK?=
 =?utf-8?B?SzBQOGtERzZsczREYTBIMDFiNk9jWnJ2Q3kyTm45MDFURkE0Q0dSRHZHeVVz?=
 =?utf-8?B?TGtXeUZIQ0xIb0ZQeko0MTkrNytnTFNvWk1kWGRYRE1Dci9OdTF1Z3lNMFRC?=
 =?utf-8?B?T2xqMERmelczK3g5SVdXUS9sOStTaDM2Q0xUemFyYUN2bDI1bWovWkVzMnhX?=
 =?utf-8?B?WUxmNStsR1E0U2NPWmxJOEVVTXNseHVFUzhTdDFvazdZTnJsYUhPVzR2clFD?=
 =?utf-8?B?YmZjUmltZXdHdkh3OVJKR242bGpacGZubGFYVWdCV0wxaTJNcmJvY3MvNytP?=
 =?utf-8?B?K2ZoU0RlSmFjaDg5dEtUdExBUlJiaFJYeStlRWo4b2p4ZEVtNWZuaVhzRXV2?=
 =?utf-8?B?U1NXanRsSjIwTXZFRUhQU08wTTRPZHQ1T2swUUZ4bWZvdnc3c3NGL0psVFFp?=
 =?utf-8?B?ZDFGK2VFQmVURjVPSkQzaFFXTnJDNmFwUHdJYU8zYTRJUFRoZEs2ZThNYzl5?=
 =?utf-8?B?a0t4SXZ5UzB0KzM2TlkzS3RYWDBISUQ3WFMrd0RrczE1VHl1eDE1S29zNVVW?=
 =?utf-8?Q?MJxvmcEy32eL2?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s8dPYa1VK4ToZCwbnaWKvWeG8N3owbMIL1rsuvAZfkHU/p8tNEy7Ecvm84qXzYSyp28wIcD6VEgwjjM5dt9tqbrQRUpx3bi8CpqvX//riYhOtsg8BSHgJqKLJ/27NvlfWKgk2qwZvfLGJqXqMqwohvTdB+ZazakW2p2Z3sDBxLni/In9KP4cTB/ZqQ+hKSoMBkFsIVxldKBKax8dwYXodFTLee+MB8kZFqx3vVpcEK0URhKLaUS+fsubHAnDLr8v0wySwD4bS9km/FF1R3E8ckN+FcpTo6HCfmChUU0JQWb2y3f4RLz8QowuOcRfVR+SVOe1ON+ksht0vGqeRSllRMcLQbW/DAPNksUBxtL1up9Q60RMmQXX+g8b6BmS3ySzE+y8rkUIZGAm+YRAIjfkMTlZ0Z9qgMszTBxrkXB8wu5/+xUwwXxdJ1L86ox4C0E1q3uLJfCz25sHZPZizdDM60DKq7CF65Q2T8qwXhq9GKLSXRa8PJTXH2smxwoLl8iK8N+Gntk7bJFnP4VMiQcSlg8Dhr28SLqS7n3vxITBhOxD3Y7+9XDo/hn3nA5i44gmYAsB1UnY+Yu+Tzdq/nEaKxQYUcnMTJPTcb9iOUnAhV6g9Kni9G6GgcRUrXdCH47hl9ZWZXZCl30NekArBjJGRg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:00:58.0379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43de1859-d968-45e5-d731-08dc80094b1a
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6116
X-BESS-ID: 1717005662-110790-12644-44257-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.59.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYWFkZAVgZQMNUw0cDc0sI0xS
	jR0tIwJcXMxMTEzMLAxDQl2QjINFSqjQUAgLxdvkEAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan14-93.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c             | 10 +++++
 fs/fuse/dev_uring.c       | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h     | 18 +++++++++
 fs/fuse/fuse_i.h          |  3 ++
 include/uapi/linux/fuse.h | 26 +++++++++++++
 5 files changed, 152 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 349c1d16b0df..78c05516da7f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2395,6 +2395,12 @@ static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
 	if (res != 0)
 		return -EFAULT;
 
+	if (cfg.cmd == FUSE_URING_IOCTL_CMD_QUEUE_CFG) {
+		res = _fuse_dev_ioctl_clone(file, cfg.qconf.control_fd);
+		if (res != 0)
+			return res;
+	}
+
 	fud = fuse_get_dev(file);
 	if (fud == NULL)
 		return -ENODEV;
@@ -2424,6 +2430,10 @@ static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
 		if (res != 0)
 			return res;
 		break;
+		case FUSE_URING_IOCTL_CMD_QUEUE_CFG:
+			fud->uring_dev = 1;
+			res = fuse_uring_queue_cfg(fc->ring, &cfg.qconf);
+		break;
 	default:
 		res = -EINVAL;
 	}
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 9491bdaa5716..2c0ccb378908 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -144,6 +144,39 @@ static char *fuse_uring_alloc_queue_buf(int size, int node)
 	return buf ? buf : ERR_PTR(-ENOMEM);
 }
 
+/*
+ * mmaped allocated buffers, but does not know which queue that is for
+ * This ioctl uses the userspace address as key to identify the kernel address
+ * and assign it to the kernel side of the queue.
+ */
+static int fuse_uring_ioctl_mem_reg(struct fuse_ring *ring,
+				    struct fuse_ring_queue *queue,
+				    uint64_t uaddr)
+{
+	struct rb_node *node;
+	struct fuse_uring_mbuf *entry;
+	int tag;
+
+	node = rb_find((const void *)uaddr, &ring->mem_buf_map,
+		       fuse_uring_rb_tree_buf_cmp);
+	if (!node)
+		return -ENOENT;
+	entry = rb_entry(node, struct fuse_uring_mbuf, rb_node);
+
+	rb_erase(node, &ring->mem_buf_map);
+
+	queue->queue_req_buf = entry->kbuf;
+
+	for (tag = 0; tag < ring->queue_depth; tag++) {
+		struct fuse_ring_ent *ent = &queue->ring_ent[tag];
+
+		ent->rreq = entry->kbuf + tag * ring->req_buf_sz;
+	}
+
+	kfree(node);
+	return 0;
+}
+
 /**
  * fuse uring mmap, per ring qeuue.
  * Userpsace maps a kernel allocated ring/queue buffer. For numa awareness,
@@ -234,3 +267,65 @@ fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	return ret;
 }
+
+int fuse_uring_queue_cfg(struct fuse_ring *ring,
+			 struct fuse_ring_queue_config *qcfg)
+{
+	int tag;
+	struct fuse_ring_queue *queue;
+
+	if (qcfg->qid >= ring->nr_queues) {
+		pr_info("fuse ring queue config: qid=%u >= nr-queues=%zu\n",
+			qcfg->qid, ring->nr_queues);
+		return -EINVAL;
+	}
+	queue = fuse_uring_get_queue(ring, qcfg->qid);
+
+	if (queue->configured) {
+		pr_info("fuse ring qid=%u already configured!\n", queue->qid);
+		return -EALREADY;
+	}
+
+	mutex_lock(&ring->start_stop_lock);
+	fuse_uring_ioctl_mem_reg(ring, queue, qcfg->uaddr);
+	mutex_unlock(&ring->start_stop_lock);
+
+	queue->qid = qcfg->qid;
+	queue->ring = ring;
+	spin_lock_init(&queue->lock);
+	INIT_LIST_HEAD(&queue->sync_fuse_req_queue);
+	INIT_LIST_HEAD(&queue->async_fuse_req_queue);
+
+	INIT_LIST_HEAD(&queue->sync_ent_avail_queue);
+	INIT_LIST_HEAD(&queue->async_ent_avail_queue);
+
+	INIT_LIST_HEAD(&queue->ent_in_userspace);
+
+	for (tag = 0; tag < ring->queue_depth; tag++) {
+		struct fuse_ring_ent *ent = &queue->ring_ent[tag];
+
+		ent->queue = queue;
+		ent->tag = tag;
+		ent->fuse_req = NULL;
+
+		pr_devel("initialize qid=%d tag=%d queue=%p req=%p", qcfg->qid,
+			 tag, queue, ent);
+
+		ent->rreq->flags = 0;
+
+		ent->state = 0;
+		set_bit(FRRS_INIT, &ent->state);
+
+		INIT_LIST_HEAD(&ent->list);
+	}
+
+	queue->configured = 1;
+	ring->nr_queues_ioctl_init++;
+	if (ring->nr_queues_ioctl_init == ring->nr_queues) {
+		pr_devel("ring=%p nr-queues=%zu depth=%zu ioctl ready\n", ring,
+			 ring->nr_queues, ring->queue_depth);
+	}
+
+	return 0;
+}
+
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index c455ae0e729a..7a2f540d3ea5 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -16,6 +16,24 @@
 /* IORING_MAX_ENTRIES */
 #define FUSE_URING_MAX_QUEUE_DEPTH 32768
 
+enum fuse_ring_req_state {
+
+	/* request is basially initialized */
+	FRRS_INIT,
+
+	/* The ring request waits for a new fuse request */
+	FRRS_WAIT,
+
+	/* The ring req got assigned a fuse req */
+	FRRS_FUSE_REQ,
+
+	/* request is in or on the way to user space */
+	FRRS_USERSPACE,
+
+	/* request is released */
+	FRRS_FREED,
+};
+
 struct fuse_uring_mbuf {
 	struct rb_node rb_node;
 	void *kbuf; /* kernel allocated ring request buffer */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d2b058ccb677..fadc51a22bb9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -540,6 +540,9 @@ struct fuse_dev {
 
 	/** list entry on fc->devices */
 	struct list_head entry;
+
+	/** Is the device used for fuse-over-io-uring? */
+	unsigned int uring_dev : 1;
 };
 
 enum fuse_dax_mode {
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 00d0154ec2da..88d4078c4171 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1262,4 +1262,30 @@ struct fuse_supp_groups {
 /* The offset parameter is used to identify the request type */
 #define FUSE_URING_MMAP_OFF 0xf8000000ULL
 
+/**
+ * This structure mapped onto the
+ */
+struct fuse_ring_req {
+	union {
+		/* The first 4K are command data */
+		char ring_header[FUSE_RING_HEADER_BUF_SIZE];
+
+		struct {
+			uint64_t flags;
+
+			/* enum fuse_ring_buf_cmd */
+			uint32_t in_out_arg_len;
+			uint32_t padding;
+
+			/* kernel fills in, reads out */
+			union {
+				struct fuse_in_header in;
+				struct fuse_out_header out;
+			};
+		};
+	};
+
+	char in_out_arg[];
+};
+
 #endif /* _LINUX_FUSE_H */

-- 
2.40.1


