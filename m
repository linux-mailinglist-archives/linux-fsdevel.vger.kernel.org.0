Return-Path: <linux-fsdevel+bounces-57044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87724B1E482
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 10:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E40A566DB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1994D263F49;
	Fri,  8 Aug 2025 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LTpcwMdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013061.outbound.protection.outlook.com [40.107.44.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254214A06;
	Fri,  8 Aug 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642332; cv=fail; b=msL02UQtHGOhdhuH4hD1H0Xh7yr103y0jJb8BAYSK2Z7eBqtDuU7laAPI6i85C0j5578e1OovqT07WCknArJhpTk8GWfjYFEO5gJTnzOoy1LMW+C7y/YbhbBPfLDy2mEyRFTkp4AaiCC2JUyNzGIVYuTNCuWNwwyZh5N2O44yCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642332; c=relaxed/simple;
	bh=sc6mvQCPhDlXsylyqdsui4cv/CWMJd0NF765AOOOjPo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L0FHG1JieRIHL8e+9Gf1hWxWpA+bwx5Wp1+vbAhU+eyIrl64CjVllD6QPy58GrLSCGsybRPXTdUVkqmIgSlPH4rcJbkIjiUVeRf8nVnJSqMhj3n24w3NiZJCtT/uvU6/7Qf9cE8S4HGzzoksiznq1KS8ZI6sGZ7BS7ejDgwJZkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LTpcwMdc; arc=fail smtp.client-ip=40.107.44.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFhNPy1DdJEbhUPqRJiVz6Xaup1bY20HgtFthBxVA9sXsjjQFUNoD2N9NtlzjKSOf/hupVaUr4AsHEOiVC1ZN6FSpXGDaQ4F0qQwwbGP1dZ6eHbp2cVgpac03wQiyehCLhp+azuogDb0EwjJCZrocLdtgEnnjLRgNE4as8vPJL0crxawbCluOcfKLUBkYAJJ0z+7dx5UH38DqG7+e9AUs1P3zXcdkLuxv4BbDFa5VXRq92GNlr6DCsgXGchnrly+XKzuwnta9tOMCFOCIprmJk1uce3Znc8QQ1lzJR8rL3JycU90VOmqC7BZVsRf67yrWe6MwND/IySpMwE6mGZAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZxE10TZy2HFNHhCZRE+JLB+wf35rwSu0t/X+DKZw3Y=;
 b=j67/pN7nDWKLD7WkIVpeGowdenbc4d4RTtAt/4jgOFmcl9X3xfinDCZBaYlyTxZLTc5s8XFp/q5CUYEVJQty1uA+7F/SOSRecyi9j8e6bVwEbE5I8CYLMCrQ91F+dvRZv9/tD07a5EdcA/DU6BbWPiaP3rxSiIvHdlnDw+aY8QtSzB+Bu9EG6lqnvdMzxxR98Bhgx06qEtsFo8tBEy05g6J55mn1WBhhThQ0yhxLt5ttIJnLCJ78Eri8Hf4tbaDPKwE7rNykUkhARd5/ryk9iCIEc0w6mxZs3KaQ3+d60caYmF99gBHOIwrSvKqa9Z3lFfloDMnJWABZcBB/qzK5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZxE10TZy2HFNHhCZRE+JLB+wf35rwSu0t/X+DKZw3Y=;
 b=LTpcwMdc9nGAD7JSeOGAlBA6axyA+PgVvYjqmTpl7nbgviOFIJnNuyWbRrvUyDg/BYWbrOJRA4ocX2phwT7uXZ7aOEajg6UOW5jQf8b9+2e/p7wTuI636jZZY2aJURFfgXOamVFA1TR/MoPmSzRC+zvU0AFybczd0kcazp54+zQhdNpDpPtPYip1BwuW52OfoD/9+NJb45Gtrs08lLKKS4S7uTo3Itm31ib+ozn/QpexKUlGfDtJWqmGKbaQfJ/4ANaHdldLZVNYMC94QKUuPPH1aXvvBLst7UQZYokgxEfUQq7/PqrMGUttvJ1hav9cJOq2l+nOEnruzOqZ9xnpRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SI2PR06MB4994.apcprd06.prod.outlook.com (2603:1096:4:1a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 08:38:44 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 08:38:44 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2] fs: fix "writen"->"written"
Date: Fri,  8 Aug 2025 16:37:58 +0800
Message-Id: <20250808083758.229563-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SI2PR06MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: ad669268-2d61-4886-adda-08ddd656fc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gc9z0+ESUCT8nmZtiyGbK1JIUtsQoxbmaDmPf9xUg18tD+s1FuWsaxpLJ+vm?=
 =?us-ascii?Q?W5kCn6JWf0ZBJ0sbOvXB7idUIkVD2j9qaBpzyZUl2jMU1Ob02lQASGoNfnur?=
 =?us-ascii?Q?UJUqF4vXyKUyoKFDPQ60FXbfe92NrAPdIOnRxtKiXdOBC++J+aI4fDkiCtLk?=
 =?us-ascii?Q?CxhlWH/z65/FIHITGeV0/xyl0rNFtRGtKYTRgM47lOkYJbArMvJeqgwo3CCY?=
 =?us-ascii?Q?by+qke9q9zEnFxsd1D4ISi3vqItbA4bdrXTSc/X/FWsboNlrMn/qXMBPQJNN?=
 =?us-ascii?Q?rcfDXJbvOFLLFuDU4veJV+GYv9iAfyEehZJYPsWi6dKXOr5H7Kvd4CjfVxk3?=
 =?us-ascii?Q?PUCG5VTkayPkBieX0gRDm+mFOYi5lLymxbQLRVY/NzoM7UNGm3UxP0bmS5vk?=
 =?us-ascii?Q?AdZnFPnlPARVb1w+P5VbqwNHeBnIi2mf30HLiuA56+A+3W6Q2S6fwCl7BJJF?=
 =?us-ascii?Q?PuCetOd2uS4Qnum654ysYP0mlTMUwrtuhHifahY/C2UDkUWCSpIyDZq5ih1J?=
 =?us-ascii?Q?BANyujF3R9i2EN6gCQcFE/n3kmP1zf+TV5m/4JYnXLAi/EIBXR5VZM2DAiW/?=
 =?us-ascii?Q?deGlS2wYZ190YmtNBt6MaJpg7L/T/RF395dCE0heLGzmDP7+imYkJytQr90P?=
 =?us-ascii?Q?4ht3GDS6krXuflcUiBHnhQ4PuBb5WQZr2STaxBYGp355fAEjv7pj2IzhTOqO?=
 =?us-ascii?Q?1gc+8p+f1pyAiVLqehMdAweVahJuXYd+d5dwREc7kLwKtuHASUTejF8QQFDz?=
 =?us-ascii?Q?RleDw8XZt99WaC/1SBkccI3s75IXji5vn1fUa8lgRV5qwiirbqCIw4F6Pawc?=
 =?us-ascii?Q?CTRwoRnmD0QsgOX5VQA3/ARRiR3s3vhQeRGznsCnFCsuRccKqE9CZqm0QetT?=
 =?us-ascii?Q?uW9fiBghHupUedbcNkvw83oRFMrbu7p+Hq0SW8XSs9YL8Fcn9i8L0tppNMiF?=
 =?us-ascii?Q?znmLVYHjJvSjUibzXNc4vCHwPE+tNk+W/r73eQcx188rW+yA09xV0GmsNODr?=
 =?us-ascii?Q?l9RwW9E7yaiflZIlLK5aHxqoopCSGPZyZfQoZ+ZQZfg/XKsawcVR00VKgCH6?=
 =?us-ascii?Q?sNFFhyoZB7orM5SAid/rdFh0/0+ewVF3KSpjMUtY9L912KJV56kNeKPFHR5Q?=
 =?us-ascii?Q?rA9a2C0vbaGHiaFYbOrcV0XwNouXAtviZPqkcgrref5oZH2IEqpHVb3I/PqP?=
 =?us-ascii?Q?xnlCJ5038xlURuDeXWdx7ER712zh7tLzhvVAkkYUIIdYhW1c+YHzxpPdENJC?=
 =?us-ascii?Q?D4sFkCwl6vXlPkT7WYBnWWapbNFEQNRzkkkc+GU2giWU1DxI/Y6hfocYPUdH?=
 =?us-ascii?Q?9otCkqVVlQzDDDYgifM1zBn8XWXTm83LvsCWRGENp6NDhGZ9K7nx1kbhjmmI?=
 =?us-ascii?Q?2iWOeYkP1bgTcriLGaWVHSYT5d8vFWgwLh328OwqUq4IIdoqXXWKEvJeSdx4?=
 =?us-ascii?Q?XACgtgSdMx0LZepZhtbQHoubp2Nv8os3MXvrxDQ/ZEyn18CU/ndKjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oCkXN8nj7dShKXRYg5WDjIqeWQd8XDtPfQoADXWe9pEAU3HR1+yu8VM8k1Jy?=
 =?us-ascii?Q?8QgN7nmRciGVZE5E4pQPQv95E6MeMQqVdQ+5J5p15m2WxY5cpFcXuHVkVafz?=
 =?us-ascii?Q?zKIlrs8+wvagQ0t2ohfoEoLMrrMwLXVjkCSgavay4+diqbISdTBE+AaPxpA9?=
 =?us-ascii?Q?I4u7O2jqaf7gcZ5hpyaCAFCEzEPtaHGCpHhXSKtmKBZmcUoH3ZrgzOWE9wwA?=
 =?us-ascii?Q?P2AMEA80v+pCiSO/sF1+OSJ/HL3xa/IlKMrVkMe23OK5XHWyOcEu2uckMLxb?=
 =?us-ascii?Q?ATja6j3VLYwoiPs9nOyeoWO/EmMYp5sv40tElvvkpm6cbVhpDFWSz/NOd2P2?=
 =?us-ascii?Q?hIKjvC7txfq6Tx3H3bu9son8C+i0yDFC/KTPcnArEKyDDDByIIAkvFYScidF?=
 =?us-ascii?Q?JifQCe1ijowJXZmMkuz35Jw3De8OZuG4LyGRrOjGc8eIhuKWtQvhFimAKcyy?=
 =?us-ascii?Q?6M8VgOQmZeY7RKF9pUYAeJ3SLWAiSg+mbJzQt/Db7lJPF/8reHNAWu5Ba+8e?=
 =?us-ascii?Q?G7tlqC0Lfbc5Pbk98TfIC1U86RwjBif/9HmqR7g13UeTVbCqOE1sMBCC8grB?=
 =?us-ascii?Q?c9w3rKKgFm/xal2eA6f8DTrlB2yms8ixiGqhJX9JyU7a71lQlJDWfaex8Ev7?=
 =?us-ascii?Q?QExVq2DxmuNLWDqucLbiv2DxOZsYnuMusIyT2U3Z4LahITmoBCY/n80X7vpt?=
 =?us-ascii?Q?ID8pST4BDL8BbrwA3fzp5m/kknuHauqfOx0NpiYDd8+fCdFR0HfJg1uBrNeN?=
 =?us-ascii?Q?x3d10LZN8V3lOyMUE+fvLcZM3bzquda/OsSZKNFzkptOq4rjjRb2opKxVTgo?=
 =?us-ascii?Q?0hJMQEFPzdI09YabN8HGUYCHNAkZZUT5tvxno2XgT29cDM0zgxFrO+aLF5ud?=
 =?us-ascii?Q?dAarg/tg8Bxm2z6pfuYFsROYXpgBLe/MiBAXbMomuzpURYPctbKHl1T1fO+t?=
 =?us-ascii?Q?tqddQWX/xZkTcUjJu3d1JlK7iVlUu9rofJLKluPo8RF/akZhQreGXzW7HFt0?=
 =?us-ascii?Q?VKwBhUVnIOiSWffGYoHHQ/ry9qJqvfLKRhAW5Lgvs5xBtNC+OXKB6toq3YrB?=
 =?us-ascii?Q?8j9KWIEpNzz4mLe6BNKLVSLoAZsLU2xnGYEtyU5C5/2ILx4zjOKRtJxX7MG1?=
 =?us-ascii?Q?rIRzqVgDcIH4QQJtSgmCL4u+x+S31TFWN9KIdcmMCf0ytIwYSAzN+c/P4qgG?=
 =?us-ascii?Q?PXYDdUzFB5PLZTItOYA36xCC/EvXRWxjJeM8kZVdk4uXualtOT5rm8DgkoQf?=
 =?us-ascii?Q?fXyLe2Ngz6b1g582TjkB+qsqLnB/2CaopiikEuHWHyBtDjUPThgFvLKEKyYC?=
 =?us-ascii?Q?dUAHpTGB/aTZGsM3eKPlz8BwPerDuaSLhwDgHJrxvgpjjRmKqSL/tS+LVLhR?=
 =?us-ascii?Q?ZRS4tvFokPYvqqK98tSnhdK5YLHt7rl9pnMThxo/ZvAo7oK1ApeMANY+aj0d?=
 =?us-ascii?Q?NCNuMRZgRmgSTA12nTnmUL6BZ0btA/44ufDPR8ncwy4Eo9D/1kS6kvd+WXcz?=
 =?us-ascii?Q?Jcw0FyUhCTOXsSp0Hncwy/CEAkHrgDxurDFDqYNt9T595srxJnAM+TxeuOPx?=
 =?us-ascii?Q?2ONps7yz6cZ57Fk2dRlP+rd4bIqRjwYoV1gQhs8z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad669268-2d61-4886-adda-08ddd656fc08
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 08:38:44.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+mDnEjYIGRUmu6PBAWItO96XdWL7MLNJ7uVLJvQ0ty0tQDHYsg6msGq1vTlNXGp3mJ8+dAUuPol/3/bjBTehg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4994

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 044a3011be49..10f7caff7f0f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4828,7 +4828,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 		return -EPERM;
 	/*
 	 * Updating the link count will likely cause i_uid and i_gid to
-	 * be writen back improperly if their true value is unknown to
+	 * be written back improperly if their true value is unknown to
 	 * the vfs.
 	 */
 	if (HAS_UNMAPPED_ID(idmap, inode))
-- 
2.34.1


