Return-Path: <linux-fsdevel+bounces-28834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F3396ED1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 10:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A04B249B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 08:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2D14BF8A;
	Fri,  6 Sep 2024 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="VwT3cBJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0452714A61A;
	Fri,  6 Sep 2024 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609955; cv=fail; b=ZxPy4Zm+woIw6hO2LWjDLWPSLRpuHyCAl9izb7xr/ImsKKzvD/qGAFYXwZLm0ejGIrUVcv4cKvP9lkTGBpK8u9frMPiU1vzz7aHrH1yYkr6+IUq4Y1T4ljjstZDGDFxCiDhOqfg0eEC56ctuZUnOwzfThpCCuDLDRPIcvAU8MZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609955; c=relaxed/simple;
	bh=a0wmq2SAWRehjq0Wt7wJMLdsH0h0Ii1CuPoFRCKB09Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ACdmyiFd1syIzUq/njOzXi7yQfovtsGY6uGpP+4OlCVJP3B74Pfj8rKVA5cA8CJFUS5RqWOh6HvgSZ0Xm4dOz0VgEqzZrIyj4yb5ptrhB5Yqkd9apnWOAvsXdhnP4dm+xBXOGi88Jg/VypFpgADAHykoKnqdSUFo2Pal4YhylGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=VwT3cBJR; arc=fail smtp.client-ip=40.107.117.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sD4+QTDmhR7dk1RJaGqwzr0r6QHbX5GJF6aVjDUqJeGf9NM4Llkrt5f+a0klRUQ8qYxaav8ijdbT2ey6h+eFrnM2hXg1G9mlrMZHIT4O7dI4KIytcw5ncxjzXzzHX+xCxKREYKtCkw0gk4cyPadwxDH19zd2laOlMbiwvPMWDJxvI0bVs2hLcH1PVpgdPAtvZWUr0FRtS9kQ+iEbNyRURvVADBaq4wQHTnfP/QjaHkeGKhqA3qoLcKBkmrHNwy7dCZhRlYovqyVtnnVMgX94sIbm56RgH/INcgsCBLPKs6MPDKaodKdv5dfU56+kmlXqo+rQHra8y5EYfU0X2BW7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+OIR6AWe8p2W2fsUfWGLOPJMYgugfQ+9Xs8aBn3Nw8=;
 b=Ju250GVDQjtCwmnq2ht3M70ZD3OJgHiCuaf8krGdGhPBLCB+9xAfJ7E69bYWIt4EukWvKhzwnowdJr/Lih+1sNByPP5Bwmeovvi16A62j8uliiJLkzSYUMT8EYS1hWZ7I6XRiYH5qOBloKIysr1uB+3aqDAauNzeB5/KnQB88AtetbThiIuLAU8UHCREPRQBz1f/iZd5y9NmBlcY8E9+T8ujB0bozqjFUBRKx+q/8DCqooPuxEevC/OMq967OIcAseIAQqIem5VakGo4zQT6IE1sbomUVfVAomlcgf1+G3Kfwc8MoAEh/JyvT/sa0RFoNudVLx/raAJ1SUlL/n37Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=zeniv.linux.org.uk smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+OIR6AWe8p2W2fsUfWGLOPJMYgugfQ+9Xs8aBn3Nw8=;
 b=VwT3cBJRv4v2q1xO5jmYW+ShIiZMjdoNfFLmSFyOx9LTiT/HZBomkXUelsP1jHDxH2tika5Sn1AXm3KLuKxKqBWzvZq6gRwpSbtpCtfJsDLKt5pdntOFSUvBIYVnZXmVI7RkBAF//fDjB+iaLRrCehMzZCXCBGrbbt1KHJ1X41I=
Received: from KL1PR01CA0088.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::28) by SEZPR02MB6988.apcprd02.prod.outlook.com
 (2603:1096:101:19e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 08:05:50 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:820:2:cafe::87) by KL1PR01CA0088.outlook.office365.com
 (2603:1096:820:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 08:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 08:05:49 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 16:05:48 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Hailong Liu
	<hailong.liu@oppo.com>
Subject: [PATCH] seq_file: replace kzalloc() with kvzalloc()
Date: Fri, 6 Sep 2024 16:00:47 +0800
Message-ID: <20240906080047.21409-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|SEZPR02MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f6c97c-eed7-4d98-b988-08dcce4ab849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5B7ri+O0h9RgcKjdKhRfsgqVQGT6SaoUsxohL8TpHrmVTRNYhVQwBdJuqaWU?=
 =?us-ascii?Q?S2okn0n3lTb/VfCdn4BHv92sRZhZaiis7W30/YDI8/lgMguU9S6tymD0Jva2?=
 =?us-ascii?Q?s845G/gqbngDmkLiewPiaZ/vaiDNmK9G7Wf4C00xUuE5tj9FShNJSpEtRAtY?=
 =?us-ascii?Q?RxZ0ntZFLLYGjxCtnJeyUY3bwkf8lA73FVcFuIwNa6Ri6TknfFOfq52Syp+r?=
 =?us-ascii?Q?YNtaekpJyUCONki8eUumQzyZjx3MAOuqnAIF3WT3XtSeAmzKww2Br9Qo/hys?=
 =?us-ascii?Q?ICTb6O0g+tuPyWK0jjYkAAYbSP5tT8Ytk5Mjn/xyEjiK6Axmhll7ipr9QrvF?=
 =?us-ascii?Q?PiOKknG6Wy73Bg1AKIjZ1Au1hK4fAHbCOhgzy48StoyTWeB2YrLOuuHYaNQT?=
 =?us-ascii?Q?xDWp4MGT+nacKMJ5PDmz5DzwjtqsSwsXzIgF1KZiz9Zw1YrWpfHxQVHnIkUL?=
 =?us-ascii?Q?RPP9BmbKFSv2k1TziHHFaSv84+jgRqbqTNly5h6Xx5h8hcXUYvE/AV2zwwVL?=
 =?us-ascii?Q?GVz295y6cRVOUZfMRfdNyWgg507y9lp9h3zOl+tDyP7Spu6ATXhz7j5MLR1X?=
 =?us-ascii?Q?RyGZz5rtAqubLMCJO7lPoo3406nB/S6Sh/rK/1ABMavQZKgu3irCMaq8x/Ys?=
 =?us-ascii?Q?kd+kzLeB427xR8x2c0M65WljcAU60/oV+8rya4tTArAxhSbwtzlIKp+qHSo9?=
 =?us-ascii?Q?Xqp/VfjCzjd54oeFWB68Hjw8yCQkRLg22TBHzZOHnfiOpgIBQ4fuFGAR3Q0n?=
 =?us-ascii?Q?3ZkaeHO5oQDHyP2IuAQ+Rg7LHWyoHfOZBQ/Mnbl7yZz75UtlcGSilHogOUSv?=
 =?us-ascii?Q?oyu0JGYmzgqh62iKKwUfNd/tN4N2srPtiUTK42PQH7NmQ+YMg1gi7VFt5Eqa?=
 =?us-ascii?Q?T4Oq4rLDuQn7cRPjRQQau8T2RnQ6P0lwQlvn+wYTkr+JjMS2sOlU3exww/P9?=
 =?us-ascii?Q?wglDmGMw1Vxp/pp7IFhiHCyxs3wWOu3vuWZtBCZNy+4jd+l9QRhHzFZZr9g9?=
 =?us-ascii?Q?bn4UBiqkcBeNkgkd07uTw5ZV80yffS7jdzc38KjkBuzS26H2OzmcXd7+6qt4?=
 =?us-ascii?Q?KN5CR+tNjaFlXWnATq3YxfolDw3NmqaNSdJCiqNRjSjxH+RA0RA1SO9lDTA7?=
 =?us-ascii?Q?z+0BkqQO2uBx7L7R3Lo8Eb/oHH3AFeJDSAbrNr3qAOLS8rN3xBnksdCMUwPr?=
 =?us-ascii?Q?xK3YboS2HlHk+pBi9MipJISN6JkUOvTmIn1ZhBVO160XNL8ykEqncGubCsdL?=
 =?us-ascii?Q?tNfuTlXPOOpTisVXDY1oGrMgYdKWIELo4/Bmol2sFBiFatrFKZhsWz0JH0pM?=
 =?us-ascii?Q?ocPGGGWk7x6SVkyxw/qxtl17KcZARgjvi9pTxKnDIty8M5Kx4MY5N/Z9zSV2?=
 =?us-ascii?Q?29ccLLXW0dt8fhl0HWYwpX8gO6/97ggz4mJ5+BWEHj2rx/oTEnSu5cGqiUnW?=
 =?us-ascii?Q?slemgs/tYStvne4BHxhyOmJ1sbUXrtym?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 08:05:49.2946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f6c97c-eed7-4d98-b988-08dcce4ab849
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6988

__seq_open_private() uses kzalloc() to allocate a private buffer. However,
the size of the buffer might be greater than order-3, which may cause
allocation failure. To address this issue, use kvzalloc instead.

Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
---
 fs/seq_file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index e676c8b0cf5d..cf23143bbb65 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -621,7 +621,7 @@ int seq_release_private(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = file->private_data;
 
-	kfree(seq->private);
+	kvfree(seq->private);
 	seq->private = NULL;
 	return seq_release(inode, file);
 }
@@ -634,7 +634,7 @@ void *__seq_open_private(struct file *f, const struct seq_operations *ops,
 	void *private;
 	struct seq_file *seq;
 
-	private = kzalloc(psize, GFP_KERNEL_ACCOUNT);
+	private = kvzalloc(psize, GFP_KERNEL_ACCOUNT);
 	if (private == NULL)
 		goto out;
 
@@ -647,7 +647,7 @@ void *__seq_open_private(struct file *f, const struct seq_operations *ops,
 	return private;
 
 out_free:
-	kfree(private);
+	kvfree(private);
 out:
 	return NULL;
 }
-- 
2.30.0


