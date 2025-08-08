Return-Path: <linux-fsdevel+bounces-57043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88963B1E47D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 10:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618C518C1977
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCA262D27;
	Fri,  8 Aug 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HGQgjoOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013023.outbound.protection.outlook.com [40.107.44.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B61A00E7;
	Fri,  8 Aug 2025 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642238; cv=fail; b=s4aMPOsjTXWxJ6MT0sYr64HncoSj5fttIq6lzRuGgebXvz9kTrJ5jYYFg94q7TJcEKoOWnzUjB5dn9RBT5LlxVE20rtlNDCITBYIwzrB11NmDank9zufr1Wtl6K3lswIHKSAlLaw3SKm451ErJQ3Lk2yiQBRL3hKwKibg78tvgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642238; c=relaxed/simple;
	bh=xOiHvzEYqjlvm3Gmtzi2+NskAp2tKmbE8rFTdqNxK3o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JywjJC2Du4AY0fZtlNappspHrB59wWaOUdjjed+z/It7y7xPNayZndmvwzB4VNd91nkN4HpBvRH5gGZ5Mced+3CToabYI+Z8gG+28lnXRXlbF8QvHxOopgtP9425o8jI9uRivgioY8/0qKQDcfKdf7f8Do2LLXaDHEdL+pHtBFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HGQgjoOx; arc=fail smtp.client-ip=40.107.44.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLCuz86h8iKxPjEdRM8QIPyQZU45jl5+aIvPZ6dbokh7y9S9aGYJN7VNNY7XlQ2uKB174wdmkrOvn2r1e4peV05z8dW1B7cQgwCbwpN8l3sTBZnuIavFT5azEXlsqoc69rjqdqOhjpuY37iTxuhZyKaaYn+n99BJ2vJ5JlZrQDFHOLocXIvAQitfAFQqzX0jcGzgjAZhWJ0VXnzQrj57hiR+6VVsaSvkOPGSletkkL7uUiXeC3u3fIwIsysMETEP8lQlL8Flmtutrgw0RZyexFZv4rxRMxJ5WCnifRKS73FHoEyEAKIZm8a5DAwTZefOBuWxTSKOkx/LK6SEyQl1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HL6LtkkQGNZCnbSu4jztnDHtTwJZNxu5rMLfHu+9bw=;
 b=IOHJAbe0orR7kB7Tx4JOP7ymDCVr0Bf20FeKhmJxjOqVo/lInYOa7ZoWCOzqcbOJ0dwF8Dska3CaWjgQjv0OkVtZqMkuBHO8pVlDWFfPINUU/Q6hNh+78V2FAmQ45VlhYlTeuM2nzFDbua9293iUsw+I7SJqqh2m6VXYBXj/GAqu+bpXEc8+CqbeQ7eNMWeW+F1bmWSbQm6e+vOHjxUnNKUqPlUyvgG2FezxtN1Zjgp4rKA5cVpnZYRN0KERlQiArGjT6tiWG6NhILm4C5PSq+6XdYtbKdqE3CYVAWilBgIoyPi2X9J8/6BcR5ZbfkC1zQlhjtu1lvGWkLh/Urtt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HL6LtkkQGNZCnbSu4jztnDHtTwJZNxu5rMLfHu+9bw=;
 b=HGQgjoOx5i7LwNSITagSGWd7Gp2oELqGTEiRA3yhgkPeJK0hpiXDp3wh9ALwJ9UPCUFfWEkBpMCWQ9YRAxMJx5q4qJcXyUi1q2SfysuYmoc1cfsN6Ne3LvI02V6iff9mp/ZEDb2HDBCVoEndiF1EzaiOqu/chV7PGFSSnkXjF0EkoyYuDwUlZMMSJMFAAh6i/8BIGsXsuVHAV3r/SBb6F1A8g5omF6hQRGeJYQ3vpsA8tYnry63apv7+V+vk64IXrBp4g2VrVQXQJVym5BftB24g/j83rl09D2wJzsci5TKF8NhBLE1hG0wZM0uNXeJgx8XspAfGzorPMIcNhyY9Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEYPR06MB6564.apcprd06.prod.outlook.com (2603:1096:101:16c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 08:37:11 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 08:37:11 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: dlemoal@kernel.org,
	naohiro.aota@wdc.com
Cc: jth@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2] zonefs: correct some spelling mistakes
Date: Fri,  8 Aug 2025 16:37:01 +0800
Message-Id: <20250808083701.229364-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEYPR06MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ea5a13-ca12-4fe7-39c4-08ddd656c4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i/d8Ub/BGjuWM6rIvzPCWLgfHivkePJ9rqA5JtjjbDHci2M4+fD8dFKpO0uu?=
 =?us-ascii?Q?auQs/GO4PjNOtPbWBfJC8b+M+mdYAJeRHyJyAi1HtwBgPw3PcPMdHbmz7u/f?=
 =?us-ascii?Q?vt2B7GMbP0uZGxouemmgW1LQDmRvRrPG3WUqOlYx00Bqaje5rTyjc58hqELu?=
 =?us-ascii?Q?Pc2wLmsU9UQHpT18Na4W1E7hYpa3BJvE1p2j8gEOEmT8k8Ai3eaIFWPX4H78?=
 =?us-ascii?Q?3C+BncOSbLnbwTpnHECBVIqYZsJ9Hv5sHnr9rvXnT0ixcwuJvYhBoex6W2J0?=
 =?us-ascii?Q?nZOnb0rcD6jHZHVneWQqZVwT6K4uayD4Lni43Fg5xM/Dmy/uDsDnuKVBpmGI?=
 =?us-ascii?Q?5ZWM0pNhDmrj909Spsf9ejSqOrd8/By5OHJVHPGDx4U5pPVXiDRCU24S/LnS?=
 =?us-ascii?Q?jhlciPwllEyC2DKgy7CNcYOraR8zzQQKVS6WL1yhMQlU7ac8Ef/szhSLhlXZ?=
 =?us-ascii?Q?/Wo7dDjA6KlrVL+N4LY2hJA0v1uavgto+CoExF531lleiZpuHgtLnVIx1eQ3?=
 =?us-ascii?Q?8EQOI8+w2PDMjZvlIf3t+uAz8WISlYufAYLkLo5YdTgE7FdE1JGObOuVEppE?=
 =?us-ascii?Q?BRlF4gO83ervQp4fp4tYCgjh03emkzuFVofqXr6h+YJzX4nB5ngHKMSGAqnu?=
 =?us-ascii?Q?Gocmt8/Rpup0+nlwqGF+6omhUB0dGvj76cqpnA8+leCeYr8tlKFhL9sOzyZy?=
 =?us-ascii?Q?2gkdCbV4u70xhWbEQLLJM/dqNeaq1fSULxtB+GlYHGQOoBhxpYfclmxAU5WZ?=
 =?us-ascii?Q?7XxgvYQxaSY/o0Ixj27qWhX9G4vYgcA6dPb626FmgLOHB/9RpJtaNWyIMHb1?=
 =?us-ascii?Q?ka8kuCj0T5e3LwT3wo8qhcfHzOfWsnzlDKKSrkqdSUiwJo8GHg72ZrV9MYgw?=
 =?us-ascii?Q?kcEa9KLPkXpyRWur5IxOYM6ACNXPapiltU5ijqvKhzxxYAgjmp3BeJ5szhQD?=
 =?us-ascii?Q?sjYtyUruVC/IO6//1T1QKpo7aS5Bp01wf3nTDM6dgfE7YADbW4O+i8p6ROO6?=
 =?us-ascii?Q?MNbQWG0weAUGahR3IiGNoZ+wWPngrwX0dJXM6dHRIA60zL6Cj2ALnV6NlaA1?=
 =?us-ascii?Q?aSJHTavwc0AqJLcauor1VVsoypdCwYC+OI+O+DLmDiIp3Rio2YvvZgUwaehN?=
 =?us-ascii?Q?8Ths8/G4lqxjo9UFV4dbU9nLA25GeT9qv1OrjJQjhzCN2Vc2HwRHUwXyly4n?=
 =?us-ascii?Q?SrvXzZvL4WIdhMLrbUp8S6VXjmPMYy+OuEI3DAEjc8p8/kmBIei6dFxTeHhK?=
 =?us-ascii?Q?CGbm5SxH8Z5yNlzpBHohb027QfrwD0lU16nqn6GIzSXGVI0lzRxn5obNdoEi?=
 =?us-ascii?Q?F0jZ0Aqpp3nF862f7cLBK/LQxUuEJR08s6CzOAc0YiSDEkjY0WQTwL/KnSwp?=
 =?us-ascii?Q?mxn5Pt0+mKd97DOfh6ceC+dp0OsGHtwbvxKUk0RchT0rlFXpuTN/Pzg/Y/Rp?=
 =?us-ascii?Q?NjY3Vfga7zG5Munvfal6B6oUAn6zJWorSg6OaseK8uE8/A5HvFuGPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HW3oJ0nrbUxPlHVaYgL20Fpcu4640bv6vu9vtMr2QYLwfi4pKtcnuICMDCMo?=
 =?us-ascii?Q?mC2QXz78GA3omCoUPiQMYpSSGL8boQeGuo0quS0WElK8c9dge0rAuMwtICDX?=
 =?us-ascii?Q?ukzlXz8TkSo6vOQSm5HazTvC1oY22nhahK6HPcn7Dj+5hEGj0UH8XpgrFwUY?=
 =?us-ascii?Q?+kr00vtzFEIBRASI0wd51llngrMfyA78QKusQGATXi8GQazjSfnpQXJLi1fk?=
 =?us-ascii?Q?FZSI38TqcOk4Ky1cua8SE4jViIXw6Mv+qhG3vIuE3yWlecYZuzeDCM2fyghw?=
 =?us-ascii?Q?0Tco0vFy8Nv8Dggn4hkv/mRWJabFJ7fvfssvqaSg5qMyw7PkEXgq0jwAEbm/?=
 =?us-ascii?Q?KXmzlx6/8SNy9Belx6auPDo8I0MM2XlblWaBLsouQVnGSJz7Y7xm5Q7IKEDq?=
 =?us-ascii?Q?6xKKAxSzJEb7ucTo4E/rEerbtz3vzqmEnoHE/mH+TOZJMoSRvFV07jPqoBdP?=
 =?us-ascii?Q?cdrdmkJIl3AtucX0EMUnoDyhNSejlszABfbDWDHmUl2eXJq0meYVA/xFc58Y?=
 =?us-ascii?Q?2SlUKjLSrb5H+h1G8fKqTrLbr6MWgl9/n0O2ny3Mwe7Ah+yQuTbMUKzC+zri?=
 =?us-ascii?Q?kzluscv1bv7hDFlDg7AFZnBz9wDo/YQcx7LjI5E+uULl43WNTuoZXZgmE+eH?=
 =?us-ascii?Q?OH+0pFj+FtYk3vyNnvrU3L+0WmbBdWwYzsI9SS266gnXDXWJxNS5lSCvr1cF?=
 =?us-ascii?Q?cHKPLMFgbfw3nZsIIqwUAaOxoh3dwYWdgxM424tHcRTBFaTHmQPhho4bFb4E?=
 =?us-ascii?Q?vkCt9YZDEvDogoW4r9YvJAG3eMfd7x8iUzfB5tZFc8eOsc1CS2T8byaNOsdC?=
 =?us-ascii?Q?Sgd8keznFiF+VjRnIX932STV7jNWeJV4swRKvJtc0kwcg5SOp+mN2wIPJA2Z?=
 =?us-ascii?Q?neX60EBwCM1MgiXDGRPml6yaogy74FB7400ANIUx0zbbfhW+JpJhliQHVJmm?=
 =?us-ascii?Q?F8oLXL+FoY8jLpH3g+qI4tg5r5j3jhEX9XFu+j+LfhbjfMz6f5HTxgU5+wnq?=
 =?us-ascii?Q?lfC4VVIhCl4d/nIbf8AHM4H5jTpN1NoLKSJrXKt3L5lsHc4HmtY1r5pkheeT?=
 =?us-ascii?Q?BXdSAZDmAJUb6PIctjskVtHWms5X3jHQet8UfoyO2dgJUn/DqxQzjuz5FV6C?=
 =?us-ascii?Q?/ekcq9sNeiL8qDwWS/8gs3p6baAkuLkcwl3TBNAO1d0mp3dxnRj2NDin2mfA?=
 =?us-ascii?Q?esQeXrH79rmfRVwSgad3ZCVsgnHvcRVC4hpONURV2Q/zwa2qfngzcMl1ROSA?=
 =?us-ascii?Q?0sdQhTu+mF4Kcs41GqbiJxxHLbqT1wtXlBPUZNoU7UhFkIUYt61iVr6/lpKc?=
 =?us-ascii?Q?d36zS49ok0ipAoeQfHN7vQf3SUeweDHU5uba1MeUt/i1zWVMpKTF8z8Ja5IY?=
 =?us-ascii?Q?VNl37rKtVzaKbB6csObTLq7tyUmSaAhXgPDcCEdASJ8pU4uxxoOyvcxGEvkY?=
 =?us-ascii?Q?Qj7FqMjIRLWnggUtda+W+KDgd+9wU/f4ukf2US13lBhw2GFkcVHFBQvMBDtH?=
 =?us-ascii?Q?a+gPEUCDY8ZqWK47vL3LP4GOalhSQVxakzbmDUQM4ZFbpNz8jAGF1bS89zJJ?=
 =?us-ascii?Q?CPB1OMeF1ZqLFCx32QpyfFuHgqIDbXb8bUYTgsaB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ea5a13-ca12-4fe7-39c4-08ddd656c4ab
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 08:37:11.3508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhseEbiiSW9LIhkSRLvvr9B4h009aGNa6I2rLB+HDYbHD3nUOiP/rblFF5uYTy443fcZwjRmO+euIbqDaPzg2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6564

Trivial fix to spelling mistake in comment text.

(1) fix "unwriten"->"unwritten"
(2) fix "writen"->"written"

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/zonefs/file.c  | 2 +-
 fs/zonefs/super.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index fd3a5922f6c3..90e2ad8ee5f4 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -85,7 +85,7 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
 	/*
 	 * For conventional zones, all blocks are always mapped. For sequential
 	 * zones, all blocks after always mapped below the inode size (zone
-	 * write pointer) and unwriten beyond.
+	 * write pointer) and unwritten beyond.
 	 */
 	mutex_lock(&zi->i_truncate_mutex);
 	iomap->bdev = inode->i_sb->s_bdev;
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


