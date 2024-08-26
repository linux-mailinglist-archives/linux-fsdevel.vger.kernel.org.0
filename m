Return-Path: <linux-fsdevel+bounces-27127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6195ECC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 11:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0151C2161F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBCF13DDB6;
	Mon, 26 Aug 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XA5UqHD+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071.outbound.protection.outlook.com [40.107.215.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FB84A4D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663365; cv=fail; b=inUmq5eL8o2+ndRBgOU5tw1CypOSpfXploIkpSe3Vqsm9cZjaNoY3KFeQyYnSC6pYHg5lfS1loYe0883cV/2OMIYjSKcfhzGiO5uHGNhTU9YhOWFyxSC67nv+sTuc6yErpN2XtD9ZqODP47w45m4BDYAqQbygd5tddGtY1uF2B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663365; c=relaxed/simple;
	bh=rRIrhcDcCmtiOOA47XwotRav+M01kz+dJqF/+1lfYfY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=POVCQhtUsWHIIWFOFf376ZNv19Y5WiduCQRKcgF2OatA5vk86Wp8TiXo0c5wtjA+gi8KokmTY91BJejp1RORhLLj7fyNyj0dCeJGD81WLONCqKFSTYiBxd0DFiPG3DQ5Qgrm6J2z2DLdwg7pICrdgODtItRwRNI1brKATpTNsxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XA5UqHD+; arc=fail smtp.client-ip=40.107.215.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgcunT00BOhgYsogAOHGwrTrtF10hSAHOZn0FpZ99d9IMMqjX2wjs7xDMniAsEiQBrtKeQh1T6D9ROmPNLby2hgf71zrjrXJrwz5Mkd2p55RNj7LpopD427X+4+Hz8jx7EHOXtxeoc6mmV4RaGJDSZbjPtRjcljqmwIclXVGdGWhV+xo8+5VI9bArsixSA63b0dRlam2jQJvotxsdIDRJubs6gG2eG5WmSo55PcQ7/RoD5xtZ3yopsxQtSt2tqoiRzBgOv+9Z4yfPT5W3B2QbJjN+KI4YIk9+lAdI+baTXm9shD3B/JLiMNpqdIpPx/KSGtl7QJEfR/1QjuoJvwiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBQLtu+umr0EyUPvH9hSR6BhpufnryJIVhA/s8m7zrQ=;
 b=udp/sWKctDSwCr/ja8CWTXLAJA8zNTJUIB8T/Gg6LWUZCp3a5y9Zzb23pW6Pl1EAoiO4/sdCY8v7CTVATx2v6JE3v7W0xYdwPwCa0/xpQ1raxcgF/B8tfJYRxZltJBi379SCGsTKbLqnfj0y6mptHioTMC2V2agbctkahhBqGwzdgmRQxeN0pJ3Qs+swmzu0ZwhpF70CIAdh+LRkwBU8i7ryJxwtncIs4BCHim5h3yvcle5RJ8rSOzCxrbIAWqRepsjVrtVFfld1oVFN/rU6ee+ki2bX2gDAPmIsP1RVcDIKg4xjFalHRfwrV7CUyonodeW9a+2ON4IdJ0/zPG38jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBQLtu+umr0EyUPvH9hSR6BhpufnryJIVhA/s8m7zrQ=;
 b=XA5UqHD+5wRHILpH9i8zVsMsUFBFwyIdAhOLDxrLydcnyzDGcbJPteLmH4Y2gTsCaN68QMo9S7YZeV3CoPmcysyQxDuk2Ha/fsl1uWIAfsugw0cHnaGRoZd1v90Ymw+pedilTjzNjAdYU7z9NNq88Klxp1UVGU1b66VhzbFc8KmIUKB1cNeF5XWisIxZjcgLbwbq+gw4dn4fRkfWI9uG9M2OmoA5ac9SfA2JVToVP7SeHefBcuf2EsIEwyuPLYw9MNeUQDGKbgxHBhvMxxF6A3v3gyE/Gi5TYX0+/MS7nzO+CF2FQFD5JgEKQKkb3Ekw4ZmkugYvAbPfTzw+Ml6+SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEZPR06MB5763.apcprd06.prod.outlook.com (2603:1096:101:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 09:09:17 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 09:09:17 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] fs: proc: Fix error checking for d_hash_and_lookup()
Date: Mon, 26 Aug 2024 17:08:02 +0800
Message-Id: <20240826090802.2358591-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEZPR06MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 3710c400-4478-4936-f0ee-08dcc5aec2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rmnEQspUpobzu9gf6aoC72Ht0KPXIg40CPpHtlq2AVVr96LtfCnRVdGM0TbX?=
 =?us-ascii?Q?A9liLprliGT2Q0HoYS/uiZElK1PogMyXLcwSRipNNeshMqaRO4Dm+7l0n8l7?=
 =?us-ascii?Q?maagtklRKXyRaQRtFpjeghHqutx8OW7WcSoGzyW+t+LGUBAJd1mtnceeFuKq?=
 =?us-ascii?Q?wKbvo7IC5zik8ybkY1I6HGExN+flr3M8cqRqPmP4b08B2sCcBfilSyOqBlRz?=
 =?us-ascii?Q?U+sEWsclCzIfFDCJDqNh4avEq4fj0W01AY2+MV4Hxcraz7myW3aWbpsH8CUj?=
 =?us-ascii?Q?2Cz2UBUrAYPUqkNC/M0wJG3jA3dWl0SN4OsYhfMsTN1x0muN6sk66GHarENG?=
 =?us-ascii?Q?oih9EuSibg1+hwvdIPURlVOQeD6YHl8AyUC0pjHqKGPfAEqYI63K6ke60+8I?=
 =?us-ascii?Q?J4e4A2QfW7klM2+mZzQ9fAE0CG75IXjSfsouLsyHZOqQsJpPd1C8Bnd2uYf9?=
 =?us-ascii?Q?Pt257Eg5M3JiHNENY3hVITgFqazAL1TKnN8JxPXxGitiB5gJzN0XNBaIW+jY?=
 =?us-ascii?Q?4k3gbYTIWl6+AzuDHcnyVtXPmZqW3XY+rpq0yyQitHMIL/uoUIvFJeX4e/+8?=
 =?us-ascii?Q?aTtDy8XxQeM63himllx6un2wBZuKYiz8rbkGt5WV8ndEezim4Gp2z0IxGebh?=
 =?us-ascii?Q?lYhAsiE5pBqvisYrqCxQBy5mqGhU+BdbdahNw4YBhKNtLmMuE6AbY+F6lDGS?=
 =?us-ascii?Q?G7EDylc+qE4pIdp8X6N6BVevSauOEqKL2tEEt8jFe+SzrOxKX+7SCPQ+9A0a?=
 =?us-ascii?Q?cPOqaWtGVivBPWLoA+JPhZUXiLGtrnjp8XwKJLxZd81yqLgSTLJCxwVoN56X?=
 =?us-ascii?Q?NomD2XVhHeuG81gaQKah4lCJWgJw1psHsagRje4pQjGDf9Q+tOpWk6CRypOm?=
 =?us-ascii?Q?ANc1Bv3iNXZdkAuuBiYhfjixIh1tCUy9A1uGbCJugY4+W0GAVp8cZsQR3J3v?=
 =?us-ascii?Q?9VrDD165mxrrb1Avj3Vk4r5Oesj+Y+RXZivCug1jJ4IswuiuZcAMX6zUsaDr?=
 =?us-ascii?Q?6stzTxLA/KTe37iVrp/+Sie6EFsQoAXuR7uK6OGA9NkY7pIAGCNCFoLxSy1d?=
 =?us-ascii?Q?OAgV228eq2FMcLX1TigJqschcLlvLnJVO0OYhkB8YM/cjBk8Rx12ZXG5dzsp?=
 =?us-ascii?Q?GTv5VWDL1QfEfgRaHD49n7g8nQ9e36Bdk7j3Ac4c7t2mCLyM9WRcILU2qD58?=
 =?us-ascii?Q?YVoKMz1U+mm5a+2p1IHU1kF3472P86nCvSao5FvPWx3Ebx5Jv5Kt3OA7xJiX?=
 =?us-ascii?Q?9cle51FEW1K+8k5AVH6n1Kxq++6O7+LsQF9lMQSKb5L+cck6887khZBGDpKj?=
 =?us-ascii?Q?yIxbO4eZGwYMn4bGB1ge2KUGCrw52Q6fyyOEGx4mp+1JbsGD7V137PxU+7nd?=
 =?us-ascii?Q?t+L6RSQFDnWerO9PldWfZm5kYbZXk3HFW2Gf04tELLf/Uj98ZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4/m7FONCbzlMB2xkngCnbqvx0khrEwGhFdrl9HpDgT7O8Wv+bDG4uCu0N6rZ?=
 =?us-ascii?Q?1GaxcC8GXf1oLQyJbOZ2b5ZmNDWDCSK4ZfZXDelXMDw21ydKZBUQorBZAfkz?=
 =?us-ascii?Q?amTsjS5vRY0sgtSZPpyXebkQMMtI/74E2B6ABexp8WfSor8LKteLP9fuW4wO?=
 =?us-ascii?Q?DMMAqjfmz5f7eBFaWAHqgiDb+jme0qkK9m711oU4N7MNPyxKskxdFo9Czk41?=
 =?us-ascii?Q?aR10QgbGKwgWFL6NfPLqPhLgd4kRue4dv7EmqUHN67xj7sMKSNoeLGwJDgmn?=
 =?us-ascii?Q?GvvAr/1VQTv/MDT8JdE1XAuBfnFxs3lJ3bMLueqij9lhMH4/FqXN/hB+EVxI?=
 =?us-ascii?Q?5aVVwG3ZD9aIxSXg2OrCJVsDbK8J3ZPUFvBoDGf7Vbx3y1Lw3RAnEN50A4uK?=
 =?us-ascii?Q?pGFuYe9Jg7CZ9MmJgMhTmDLCESAOLexw3gNDkEy6lxdQOM1WTMcSAXXnq3ey?=
 =?us-ascii?Q?aLyKXxpkh7IpIzuZLbFClN6keJ9UwLwm4i5ioBvxJ1UvmrOBFfKH8XAndYQF?=
 =?us-ascii?Q?rjU1ebzyAM6HcaAfA55YVpFJCSHHq+nwBAd2RHSSTBYM7BxN37bgcdctHjML?=
 =?us-ascii?Q?h44hUhL85fV0eNJi3y5CHAA2L/ta0NwZ2n1iM22sWjCZH1gC75cbCjFVuUSQ?=
 =?us-ascii?Q?goabJZiSQaeNaxTg+H9L3kVcFZ6EjlYY6lLFWtvHxxhAaD6RdnVoikwQQ7cq?=
 =?us-ascii?Q?a6MCM2NpY2sfzJI8oorZLjJRrK/SWGWNUJeeiPAN2Qnw5v6NxNnAlgHaG0Ql?=
 =?us-ascii?Q?rZO3DytR4pmMuE20nidBVlIpJEK5vtL9K1Hk6Ml0+VfPBoGJcTI/ds/Tg8s5?=
 =?us-ascii?Q?Yj78OkhO5IQ6aVoUdtCJL+OGe01FbuK2dRpxCjJIppEr860ttHJejHYL/Ahp?=
 =?us-ascii?Q?8922bCZTFmpuZ/YWX91x7MTV9ekKwjerliM6K1uEjeuP62yaloAxup0c4JA9?=
 =?us-ascii?Q?ePSPsHQfHLcaEg03YD9Nd0VDEV+H22ewjbIimz6PiUKcwJnec25ITyYbSxZd?=
 =?us-ascii?Q?ib9OvGYThUkacZ6xNv8J3zcJ+yMfcBWEdzyB0iblPH3ZOQZn3rzV+iEUGB2x?=
 =?us-ascii?Q?yjrjMIDPa33dwOsR2FBOE+XLnpTk7EjhRQ+Pt5hoH5DDP0zcbkwq9UYzR8pQ?=
 =?us-ascii?Q?6p5m2ol/qNZYPURt7aEuv2WxXNRzOnjoLO7JZ2Es2yKh/HObg6zYgdKPe9yd?=
 =?us-ascii?Q?wfjmCLP3RfAgKek4sP4McGjmfQ/fSbgZavOXi+m6Ie9jbGMdH04xJwxYj/mI?=
 =?us-ascii?Q?yNs11HIAcFnYN53nI9BSSj2SGfswv9Dc1VpnWC8t8eab0uSI+BaOXJsNkiYd?=
 =?us-ascii?Q?/pFVjzz8SQbswvPdQ+9Rex1q7loUZu/VuweiH2F2L0jCf0YIIywvKVU75clP?=
 =?us-ascii?Q?fifLnJhN4DicaWb67MPN9/P7QTvVpYeWNIp5/QIYzTj/JycyolSd6jREcp+U?=
 =?us-ascii?Q?rdPSZhOydZMwghSa66kSwZWu2QSBI+hWS/sic0Tv9KEyB+JibJtamkd06VrX?=
 =?us-ascii?Q?q8cXLO3GNz6Tm4eQdgj1zafjCx65xflYCYpROurt2EnJMsd2NjNvkcWRtz+4?=
 =?us-ascii?Q?qKtkYm5DBpWXvuXagKsZdpyZEDOXbsihgdngOWeK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3710c400-4478-4936-f0ee-08dcc5aec2ea
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 09:09:17.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8Xxsm+MkbsD6z9q6lThxHDgwMP7Y7+V4QuWbQH+35nbbukYyTA1Bzrr2GntPblcJpFe+WSygc+8bIVljbAoJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5763

The d_hash_and_lookup() function returns either an error pointer or NULL.

It might be more appropriate to check error using IS_ERR_OR_NULL().

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f83d41bf155d..e08b36dd4766 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2123,7 +2123,7 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	ino_t ino = 1;
 
 	child = d_hash_and_lookup(dir, &qname);
-	if (!child) {
+	if (IS_ERR_OR_NULL(child)) {
 		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 		child = d_alloc_parallel(dir, &qname, &wq);
 		if (IS_ERR(child))
-- 
2.34.1


