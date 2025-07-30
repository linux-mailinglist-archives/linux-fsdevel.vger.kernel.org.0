Return-Path: <linux-fsdevel+bounces-56308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BB3B1571B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 03:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAB118A6B2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80C71DE8A8;
	Wed, 30 Jul 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YF/7rjbB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012051.outbound.protection.outlook.com [52.101.126.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FB1B0414;
	Wed, 30 Jul 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840242; cv=fail; b=pJZ9HCt9eX2JpVG065pb4+xmIJ65jMyKGtxJ+5dy00VYbYJPL87R4wt/4KbBjiKdAtmJmI5BJbyTw9+M3ktCB/3j01dXRwze1NzUkBUdZ8K72GtYm6cQF93x9rzN27EDvsDle6dVYmBEnHJzJuRPxblbsb5avkYYukVJN2JVex8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840242; c=relaxed/simple;
	bh=37kLVgeLQyxPuezIYcb7qTHPgsZqZAgdx2/WlEwdl7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CBrxFwf4u9CG3PvWedRQtnPwQSt0cFUoY3vOOaLVt/u50rWMRiy5JzkNiGBqTS6PLu6BKJltRFyuu7nnz99UaGzsQB7eVHPPtuAx8SH/vOTifcPWsJNFcPcIr0RE5K6Lf4MQai7Gp71c6UC6CK6+2hA0ZJbCxj1iX6IIiipD5sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YF/7rjbB; arc=fail smtp.client-ip=52.101.126.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xY17AoITnuXh7DWUsIO3QpxpY/gaxWYVNM7K107RmqCgmdv/aVncRkA4xWBeJUnUkrc4jGk20HBag0duMPy/DBmYsSxZQPoTTvS1dh0ePZtcnvIRtiDxGc8eWe7h6k/1eMy6jmLRIfY8d9Ufk9mPAVsf4rfBO2QCh2l9ew0dmE/vpOvBoFZoYvtjUGTXGFe0rsSyFRzxkMNrzWEd6X8e110bslZYP2OwtWfGbZaw/SGgqCbYJpjTd/br9dC74/byo1FFEmnofAeYxoP1mOmLD5k5yej3vhwCGUxkA7J7IIdpWUxgwxn4aQqKf5oykWdY1fb41oHI7/Rofra+klvuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMVZswrCELY0zwFT7OLNlAjOiVbky230+QAhNiyYh7U=;
 b=gCm0XQ5ZoDZPwQ2aOhTejswehMtMeo1ndmg8ngDr/AET7x+uAQJ9AhQyoT7uZDDLM51Do1s/7s7ZEGhg+urxfFXDZa44oF3M87I/2v4AkdFy3CBaAm+ZHewXIXCPFuFASmvZt8njIR8x9qklBXp1vCE14GuFGuprP7+u0uX1kMgU1jAnt6DpbV07rSRcCfMTz+NK7qlH9oX8S+A/9VbLhbWtfRtoVEtScNcZIxe7MmYAwGEIJdmdSSa+WvKt+qvq3v7xRa7ZtIYVcgugJ/EGU3TpF2d9v8bU8MF+tBS2oooyb0/bfmuPWYO2cGbPLjhTKsBS2Fz0k5Fw/RNT3uuEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMVZswrCELY0zwFT7OLNlAjOiVbky230+QAhNiyYh7U=;
 b=YF/7rjbBSflL1BuVnUIyQYYtn7QeflPMNezu0u4g+xoJ270HjzR3ooJXtR8SqGEkRhLkE+iZYVJ0L0ptepiGf0CpsvRLwo4iudU6q1N9yFgQds1VAC3nYgMjwoRFgLD8vJBYHYuXoKifVovBKGEYEiF1CQjN81lmAvA2htiJMcGyt4/cTTi5LjKL5pU3ovwC5WBjeWzK+oKIITuZSPoKty6HdYQTvsIDuUjj/NAfKXq+nDUsUIycufptsPT9KZwbG83zNj2BqVWGIrDTNdArvUA75T90n7gE/bkoYRZ8dKwfX6aoTK8+eplGSIjzL3NQ5DZOEZHAhU87JV2jO784cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 by SG2PR06MB5262.apcprd06.prod.outlook.com (2603:1096:4:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 01:50:38 +0000
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768]) by TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 01:50:38 +0000
From: Dai Junbing <daijunbing@vivo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Dai Junbing <daijunbing@vivo.com>
Subject: [PATCH v1 4/5] fuse: Add TASK_FREEZABLE to device read operations
Date: Wed, 30 Jul 2025 09:47:05 +0800
Message-Id: <20250730014708.1516-5-daijunbing@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250730014708.1516-1-daijunbing@vivo.com>
References: <20250730014708.1516-1-daijunbing@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0225.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::21) To TYSPR06MB6921.apcprd06.prod.outlook.com
 (2603:1096:400:468::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB6921:EE_|SG2PR06MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: c208ec2b-159a-4d71-5760-08ddcf0b7b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LdT+eiLtCzPAA1I7zcbb8lZ/pg88C+KYwRu4SDuIxzKzrtHuAc3citTkCtGX?=
 =?us-ascii?Q?8YkIytf63wnZTTT+39d96xIrNh2yBS8yndGWqJ6HwVhcbWcfnEB8hpbVhshI?=
 =?us-ascii?Q?PTp60ef3s9g3ahM92K3B4c1CTHbJTEiT+egVDdvtOaaewrzSCEewu7vAyCda?=
 =?us-ascii?Q?Ari5bVy/0KQcdXKJxRqncPNea7bGk0DxISfBBhmQlKKzyamkck23xPWSJTRe?=
 =?us-ascii?Q?xK6RvuMi+Gavzui7gIvCxjraAt0uguYPmHqHlPVv/c8Fnuv8qZ6PBX/v0ruw?=
 =?us-ascii?Q?cIulDdL2AFGsF9D7qquesJwWfjBmGuSNB1lUzFK/GxoG1JSC85QLzmGvP3le?=
 =?us-ascii?Q?+wWD/9jTChgoP9Kfxx8bU6++WPNbYm8I9ZaEBCoKS3D/5jRMY2MgIxygfTIh?=
 =?us-ascii?Q?jlNC1dyx7ryvoYVt1oGP7NZEw0g99rWdHBpmqTJJGDRWzGAK4PSUokbQ+3a4?=
 =?us-ascii?Q?XCTPfzzZ3OQ/nrGgUQyJAxg0yCOpqV61kMlYmZoPX0NDJ+MRaGJ3eOTzUlFJ?=
 =?us-ascii?Q?JjBgq6054qBSfAIED4CBv1HESl7y6ny+RChBo16s1oV20uOzBwqpcCRvU+cf?=
 =?us-ascii?Q?RR7P+v8sZFEOQyT0qjJI0q8fGq7U+1Wl2F+E+E6Omc7Lq4ctR+3GQecH3+b7?=
 =?us-ascii?Q?l7rAPrWzkQwCXhzqcX9CahL714h/4V9znbTEgCRhwvHnCNcEbtBq5ztuw0U2?=
 =?us-ascii?Q?zbf4SrPxHT7vfUYx++VmCBaWqdGlDohP1jqLE7iP6D1qhGH9otbKNMVglYvg?=
 =?us-ascii?Q?vu7JNCAhhfK5uqlawqUrkK9dDTTMx+2xWOdh69WzyT3YFC/YKL2ckHV937bH?=
 =?us-ascii?Q?iEQ9yv0V0xj3MS5NyOcXVok68+lLmkyBmuVWHrz+z8Q+YOVMWXjipfa20o2b?=
 =?us-ascii?Q?KEcsrBKT1oInT4f9Tw0OKgL/J7KxVyOmCUW8VGbary7UtPqDfMwjFzDVs6xA?=
 =?us-ascii?Q?1PSpnb7CZdv6BfYNaQeI/XWxtL807yMUtIVYydm/N4wXrOriNRw2bT7xf+Cq?=
 =?us-ascii?Q?RdHrYvOU9aoX5TqEOWBYAExu6vYRFFTK97L0hTvhUn8r8Fzb7zSE2M5n2Xum?=
 =?us-ascii?Q?Lu3oVZkoAUAqcoWefekbOWu12eUk94hvJma204Bu5rCXFFQY7gtYn2/K+Vpa?=
 =?us-ascii?Q?lBRVuQ4UwF7TjTABBGzYdfqCddcgq4mBpo1dCUAhu5nqVcYlbOnDmcwb/fGQ?=
 =?us-ascii?Q?YtFkDo5IQAW/Q7FV43SEpDxZ8eqdkkMfby0MA2F6DnVIlyxKinMkGCnH2RRR?=
 =?us-ascii?Q?eXICRHb6ghZpfoQPwXQO0tvNK0Nu67oTcWZVKHyP9HjWw8Sadg23p8L9A74W?=
 =?us-ascii?Q?uN1BIDtrYsl6DaiOjcfX8Vrg2ykHfgAc2G8jydDDdqaDIt0HULuN3viOuZqu?=
 =?us-ascii?Q?yvjHev7JNKL20RvxssF7b8UlpNnrCfJo+bqr3O+wzGEtsgo5K84QI0qSFo0k?=
 =?us-ascii?Q?8rBiT3jbtmR1ZGiqjdcKVVvbniwISS8y1olCHuxsiSdWjvMEwoUQmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6921.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yI1mrIY/tWsXTK2vxG2yI4MNoMjqfSsgBMI5j1eKgPwRNd6tS2ZoPtbbeZKO?=
 =?us-ascii?Q?ir2nXFtYZ12VJ7JQwGNAN6mrLuupYbg8WHbwl3SVBAC1Hb8HblyQwdR+LACD?=
 =?us-ascii?Q?Ws3RAKVQIISmjA4NPLS7V0tRm7bwMzsFOkZ3bL3L9dng4FgEVRdV2a7kuOlk?=
 =?us-ascii?Q?DG9e/xLl+mK5s/NgnymRppzeeMzaw9vFnlsLIgT1Fp0d0Eepm0J1VC2fAnVM?=
 =?us-ascii?Q?YZEA4QF7Rnp3FiolqR/y0sAUopt7WCPxnuTanIfTSFt7Y1YKK1ivk0hwCV1e?=
 =?us-ascii?Q?0iiCqe6um6t3PJsqYvS/yyfDdA0yzNWQ1w8c0y1OPO0cl0wjAk80obZoT79G?=
 =?us-ascii?Q?GMPJ+FsIPoQnw2Jd58M3YOu1e5m46EJM1WtQ7y8e08whPZy8OqbMUIaQUH43?=
 =?us-ascii?Q?YE0pPZXEzhSAOuAODcuGaX9TxpO5uu2xEMR6yEqv2RO7ZRT6g87eA55oIfTK?=
 =?us-ascii?Q?M7Yx0KtsOtg4EzVMc/+W2INaScndMxJ2tRMWu2iQPJ66pc6Lt6orEQrnFSAR?=
 =?us-ascii?Q?9ufpPQwg2sWOkz27weE7Dlk37yQsgauYhJEfuPpNhFTZgxBObRtC0bNbjuUP?=
 =?us-ascii?Q?4rH+TeB53qxMgdStFoqzmhD8eMROkj+SRObqBTHogCdeGX5aSt7Pm9+N8ZHv?=
 =?us-ascii?Q?8mqLZbeLjBhMPZ5uUa3kGChvsJU9yboIHdXg7EeeKRQzke8vj7L0kUvIeUoR?=
 =?us-ascii?Q?Jc9zpVXBbyeKD2fq6iFY+6mNnb7210BTW3t4LZtpw69dgGv3lvA3/JQg07Ha?=
 =?us-ascii?Q?1dMpHIoMXvzTE3c5jG41rekWJJgOQn4nXBjA+b1e6sptCqClOXWI+wgcM/Hd?=
 =?us-ascii?Q?Ueya5Dm6DTcP8obIYr3FyuFlp1SGuFnLIuSCvPxR4t6V4lGqPSY+ZILsRGj7?=
 =?us-ascii?Q?LQYbTf6oK88ah2ykJjOoHNyZ6UATI3+dHJgUuvqXpcoWoq4qrUYJdVhS2g22?=
 =?us-ascii?Q?wLXTEsujViy9+wEoCjLXxI+odZJ/iZrVfuRE6WKWzROV7Vco/ZLvx+lJgX6z?=
 =?us-ascii?Q?1B+oFwkylR3hjVJbNL7W5ROdzDHDBL9+AEPTpf/PmtDe2BYc0XmJ9G2dstc9?=
 =?us-ascii?Q?W1KedqNtnQunG/J9tcx/LF8qByO6MrXQsshnljAC6+j4irBv23NVqLSsoBPX?=
 =?us-ascii?Q?qKmQS/l0FvYn59kcmSEdF2AVYHhBxQb6jbc/xjpbsyYQk2e00aBJGX9RW7K5?=
 =?us-ascii?Q?7bsgOS+hesuIJ0PcCHdLbtJmzhPaYdIJYopDQCCaXKgm3ps3mdMh3Kt+u+J2?=
 =?us-ascii?Q?8yuBDvztpIpe1qwW/SfCNq0Ou8JoBfK7CaYXSq+d5r+2/tiORnNavJpfpb23?=
 =?us-ascii?Q?u2CiGgaaG5ELP9R68TtdD/FAuhzS4/D1VHbappIms2hQ5ghwrXAbGa0EYiak?=
 =?us-ascii?Q?ZTSFhFYftOt8ofySGDPTo4ydyxvu/cSdsZqF608+jHNZ0t1WLndSFPVk9jd6?=
 =?us-ascii?Q?TZJbOx+B4aj6qH9cKMGNNcCZYldadMIqPTiJA2lSHFEgEGC5cUzRxzFgnO8k?=
 =?us-ascii?Q?nGpOszA1/49wU8IQOdGU+mB4fAp/RaS48DiFbYyH92BPBFvSLsSwoRxsoAcB?=
 =?us-ascii?Q?rLhucgJlVFTqAfQmrWabD/Hrl/8Qx0pUyjNdNEhg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c208ec2b-159a-4d71-5760-08ddcf0b7b5f
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6921.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 01:50:38.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KbNOhMfGi3r7tN+FWXo9E2V6m2Dy/5RFAL/UQBKp/KDSMoI/Gp984lON5r42T+QH/uduja0GWkv9jhC37fahA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5262

Add the TASK_FREEZABLE flag when sleeping during FUSE device read
operations. This prevents premature wakeups during system suspend/resume
cycles, avoiding unnecessary wakeup overhead and power consumption.

During sleep in the FUSE device read path, no kernel locks are held.
Therefore, adding TASK_FREEZABLE is safe.

Signed-off-by: Dai Junbing <daijunbing@vivo.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049..b3dbd113e2e2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1418,7 +1418,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
 		if (file->f_flags & O_NONBLOCK)
 			return -EAGAIN;
-		err = wait_event_interruptible_exclusive(fiq->waitq,
+		err = wait_event_freezable_exclusive(fiq->waitq,
 				!fiq->connected || request_pending(fiq));
 		if (err)
 			return err;
-- 
2.25.1


