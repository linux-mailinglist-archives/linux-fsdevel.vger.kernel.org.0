Return-Path: <linux-fsdevel+bounces-55147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C423DB07505
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FB258231C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5D72F4300;
	Wed, 16 Jul 2025 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="McTle0yz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012041.outbound.protection.outlook.com [40.107.75.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C272F2C6C;
	Wed, 16 Jul 2025 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666580; cv=fail; b=poOQkt86FJJLGzfdsE27nric026355BB2qCssMBmY3iaEU8KDX1ZAC/cpybYA5AxSjP3jjUPodv1S9cJBKkq1icqBk16/+/ckktL41cHntHJB6Qk8lmXv+GC7jp6KQz7or54toC0QK5kGHVuc8lY35utbs5l8E1soS3tUcoxSqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666580; c=relaxed/simple;
	bh=wpCN6KMfQUvbC5InO0cCMg54CdAI5vuqptrLOH+DUfA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n7vKHfdDG+kfmmjFVzXOuNDyhOyDyJAV97EfZmZD8y140tD31tWAA0DTAHAxnzIYb6JnA3+GgAZWOsiA7Xf2AGLRl9HDI5ZwN4HJLPe7LjTAkhA7Itt42YmQ6TakyJjx61fdYAUfZ0dbK4ii3dObyvxr0aO5YfExiZzJt7PMLvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=McTle0yz; arc=fail smtp.client-ip=40.107.75.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DymkjLl4b9S2wpZ65VvMji4/8mhUGwl77RJXkwewzxkxQU8SvHtqX2tEFKWhWC7ZR9XoQ5VDcBNWpK32jOHPWEhnoi+UG4ZHrgq33gyIlYNn3irayO6/r/H+1PeDEWV0F0SPasiGpIVmgByZXoaWTJyhDVkX9AjGa7VGLU1si7CPR7fwmW8CQMJ41ae5VOgaDcUGjbD7HZOlUDpRF2MyfCS8nSbBrfksZj3XNsPAWiU9Svt/C5Uvg+gMMnDGxyc/JV7/Eg47h068grHHdqEUcQ8hMQIRAU1TB6IJZK8ppBu3fnqkUZOi1Fs+VJX6ayglmT8dtbd6YEG6G/wUE9fzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TIEiXrpNXk1dv/jUtzS3JTJ50vQSRUHFN+obK6SMrM=;
 b=h/P8O82dbJ2U7h8BT9JoPCv1E9louXsPr08ZH6KOgjcVgcoKATICfvdcC3mf6PG8MeCNHj4cfdFuwwhlQYGkQE7EgnNHSzVQozI/p2JVnWEVkFpITeJHuU4lpje2ZJdaWml3BMCHH12E2vW1kQvWYstFYWCmRL4tFqCwAtz/TzyPXivKoV3w+Uxal4IwY32HO+IZep91Aysxr9lxMNc0G/xO1/3pIRrYC5WU7NeMNVv5s2AuC5UaGqR94iUXHDAwUWeZ8sVZw3+2ddh/RlAnZPovfEMOiySRvhj7fgDscL5bdaj9kjB3OfSxi6y2o7kOLHNHd/VBh6qkK5FUhDMUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TIEiXrpNXk1dv/jUtzS3JTJ50vQSRUHFN+obK6SMrM=;
 b=McTle0yzQTapQhjJAfm4vgeA0woqus+5G0UTHlL7FIuy9UJ/EQ2WBmks5eA6rEBxsB5dnCIoXc6S/90TFLCrNWP3lS4OhpPpjzlJ2V83nGrgU5VZ6O1bVUZ8I+vXCUlJwdk9F02HniEZ0CEP/FhoAAa3oSwTpeRPz1wcCq7jZa/kp4zm/IEVx3LEcQrlHhPLMh9rnPIHXbR9BsWmHZ5L1y5ZexlAvm/+PT2JInBE31y/3KHZPa9xz2SwC9GKFHivq8FeCthOo1uPt8fTRxraEWt/QitKv7/QitVrx1NQVY1f7Pu8ZFUWVqmlvPkODXXbzN+tDbAkLuWzzzxRwCpYcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by TYSPR06MB6749.apcprd06.prod.outlook.com (2603:1096:400:470::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 11:49:32 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8901.028; Wed, 16 Jul 2025
 11:49:32 +0000
From: Qi Han <hanqi@vivo.com>
To: miklos@szeredi.hu,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liulei.rjpt@vivo.com,
	Qi Han <hanqi@vivo.com>
Subject: [RFC PATCH] fuse: modification of FUSE passthrough call sequence
Date: Wed, 16 Jul 2025 06:10:36 -0600
Message-Id: <20250716121036.250841-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|TYSPR06MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: dd86afe1-5491-4537-e894-08ddc45ec1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AoFpq8ZvdfkPUm71/Ko72q2k5aMdxSAUv6sFrlaZmVYlWd5kKAtNePQa9PYi?=
 =?us-ascii?Q?A1bcrKzxAFI3JTO28QaQ5C5stCQ7TESM3eaxiWyMBKJ64s+XSc5EgFAZ/l1P?=
 =?us-ascii?Q?t4Xom/B3wkhSEH6RTpmfAO8ExfzbuHYz/Vqz7namHdXWZn8D1v7gHia1g5Pr?=
 =?us-ascii?Q?AglyuI/ktA/JmBZNTtcgCyr6P7NeY67ENnYVu2MCzhAImcraF1OLVEMmIqPe?=
 =?us-ascii?Q?V834u8XjeBvSG06vWz8LhY2FbhUgTjDXXRSxzDxLOIfo+Z38xOSV428fFssX?=
 =?us-ascii?Q?d25WC1Y2JlXaFSaZj6sZhzzuhPO+f9fOr1cn6VioA9wJ11gN2HPrceaniCV2?=
 =?us-ascii?Q?q2bOhCyJrEUSp3jQRp4YzAuW3l3FiwRd5zMZdGyKdS9IVgbrrsK9aQxTl0fF?=
 =?us-ascii?Q?8f86/yCjQ5Z4YAMhQMQoC3hHg8+x9BMdL4j79lqYvVL7TdaBowrOZpxBss8E?=
 =?us-ascii?Q?TMhwd8mrMf/b0I9uCWPTnK1pcS1gcdpjmtOWykKKwXSu9cukC5qKJjTIR8vq?=
 =?us-ascii?Q?gW61bpaxc1gVsdFqmj6pvfoTMz9nCw5lbFV3Gwoqe/Z4A+HbbppuhcpGId54?=
 =?us-ascii?Q?ANxm4vFcuBqqtbE8KP9jXcztxe42ct3wI0MxQLI8pD33Xwh4HW58UhUAC1p2?=
 =?us-ascii?Q?IvE0afqejSTZZcLkEEEB8X2HIc/7KV8f3NQcyeugG7sDIEEeHCJxNtG+wwi5?=
 =?us-ascii?Q?ljY81zp70aLNHxdTT4drBL9D3XRwqw3U7p7t1ALMteVzgwx3T7ChU02aP+zS?=
 =?us-ascii?Q?3IL8bJT0RH1L66WIlHVfmKoeG2Emh39qS1ifmVpcTlsEtAOnKoKjaYl3WW9O?=
 =?us-ascii?Q?pgy/vKtfoKkzfgmh6JacwIodDpWrWTe9XjQ0J2B6ZLDAZl1SxiAJlgVUS1BV?=
 =?us-ascii?Q?MMbzswOJyKF9SVoyl2p+GsVu6HVqchyzQNFvNN+lM88faPKQwz7WokKwA8n5?=
 =?us-ascii?Q?1G0+/jJAUiSJQ3St2hgG0k1suBezRfcTYGN4kL53eFO+STvGeNcEH9noteCo?=
 =?us-ascii?Q?XNF40xR/53BomvAT3p0d3k1HKiF7sdHMXUTvAK7xPpLYSWQmlWmFh2rvr+9u?=
 =?us-ascii?Q?SSPBNoYy+YQMZgv5SIxTBSVEHkeMdBc3w4p+pEMWPTzVCR7HPxmFeAOFCck9?=
 =?us-ascii?Q?I2isSyymSJxnxbc45IabPJatQDcy2lrVAujl1rIluEPzOETIP/HpAQeoa6U3?=
 =?us-ascii?Q?RDLFCsN9f/VuDzmEyCL+rHQ8zVYrZS+iVzSA8rs3PJJzCaTUItes8C51V62h?=
 =?us-ascii?Q?6BD1pJcZWLVMId3S/t65j+thuNgF5WaLYhsSuEEWQwu4aQhH4dnQFEZlaDAV?=
 =?us-ascii?Q?H1w7KqZK+OIxNdlbVlLberOyDJuY5WbFkP2WMTSLKH8XkU+HoLw7makjnSKV?=
 =?us-ascii?Q?ssrpWGF9yQJJHgyLSaRTPAgBhG+GNdLmU9DNqoWXiD1zgXGZGySE2uF+iw+B?=
 =?us-ascii?Q?HJ9HqJb9JYgr6RgPcs0BxrP+ULq76MICv8VRqkH3DBIM/DOQpD8yLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cqbt9JkaD3vk65yheMrwzj42eVWRRqER1Rgmdgc6WmyttbaI9WQe7DHMh1Fp?=
 =?us-ascii?Q?reiOg3yBAioj2Y7zSiArGDvSK44/SvTXhPHMiIKuyiW1TwAB4wj2FJijftM0?=
 =?us-ascii?Q?Ji85Z/im4g73QLDSujZBeC2it3Phe5E4V+jwjYazhb9dE6nRlS1z3WsfSG+C?=
 =?us-ascii?Q?vc2eibJv0shcaFKo/JVI/FZbpbrXTFOGoElKahBIbh4YwtXzExgvPhj7oV5U?=
 =?us-ascii?Q?tVPTXJjzk5DNzUyLJfDoOYzzKoHPljxTsmQ9baDaHDIe83+EpBqZpSXkaX/r?=
 =?us-ascii?Q?f8EW0W/ki3cfsuQA5dfIlUuMqNHx1Xt/ZD1OGANctISq+p/gEWwymc+97Qy9?=
 =?us-ascii?Q?6IriAPMVVGpVaMmiIvOXOjYwwbfwjWtjwC4l03rkNE0rtNasD5Zsq0I4zHk7?=
 =?us-ascii?Q?C6kTRQ4YC30AKe/0tMUq7aadBN4HKSrfXG//JiE+/sWwR/1k2bK/7SPYvRHu?=
 =?us-ascii?Q?IiMHKHGqUgMErSBsotR0kUrf8AcBXgNNOZeIx+XUksJQcXxXLpxZS/eMQ5ZC?=
 =?us-ascii?Q?thgy/0+0W1Pge88P+mnrbQqVJOlRC3HjdhysCr0pKlJnRC4TkoUJ+Bq3kU1y?=
 =?us-ascii?Q?vo0IBwARl6EqGb6zL8IyaDMGxdcIXR5d/oJWqIqaTYEuAaqVJ9hquS8XKU4F?=
 =?us-ascii?Q?Wsxp25hhiGSq1DTz8hp5B93w/ygv7MP2eRZZhYKXqUIctwpjgO8nG3QXgZJ3?=
 =?us-ascii?Q?DoA7B0TCi3xL5V1seG2DvlMOZCsjGoUhjbBxYWO718cpn/U+u8flWF8Pe6tq?=
 =?us-ascii?Q?iwgN5WP2+iStYvjVEX/5yyjo0nrNYUDg+I5Y84Kf7SeIcLd0kkASpMpQzms3?=
 =?us-ascii?Q?CoATob17ZYJOQc0sLH5biAfj9kgRFwpNwYmEgnW1y2EaHLC4J92nON8hIbFD?=
 =?us-ascii?Q?NsV/APmXyQTXXHSnHiEZf86BUnYkn3YIcDOZigbU0RG7hELFsRL5SWaNRPDO?=
 =?us-ascii?Q?qOg7bUJ6XOmKLBL8SHqAlgSXCG77QPVCG2JUhG+3CslOdkr8cBsa4DjneBr3?=
 =?us-ascii?Q?rpTWvdEqCltgpCD+xU5d+6qq4MEAi/5tFI6UN3TYS80fvV+QNYJJM9Ir+smg?=
 =?us-ascii?Q?vwBRylo1ceFkgg+KyDB79PBR9xJmm50UgEWizN5wQ8k8MZG9ns21HFTqkLy+?=
 =?us-ascii?Q?JvWy0np/6XXmAf3vyFO2rj8dTJZ3wvpPa+W+8ABq/qXK/b5ZyDP3g4PLnjYb?=
 =?us-ascii?Q?P4W03c+p+OhDTqYOZrUFOjw2TtvxO03+eupIY1j2+y3FqQboEUp4GqLqHNsK?=
 =?us-ascii?Q?rL7dVTcHlEDtZr26Z9EjcSqx1lWTzEjkI/tVcmGVUXZJ1XJvIhzxxqdYB1JT?=
 =?us-ascii?Q?Wz+tO44abTMsbVpcC6HaBKvvuHwahQbcot8EXCmWUKf5I2JSwjc0CM0JvVH4?=
 =?us-ascii?Q?ThLvnk8xy75pFnEb9FZSI0CJnDwroM1h5bxzUBvx59Oez2ZHGt0NZ3UAQ0cW?=
 =?us-ascii?Q?pgyE1ZH2LhHMjCSRPr/RHWHKxDg530//dbzCGJz0nQrLsCERbTGAi4DCrrHw?=
 =?us-ascii?Q?/d68ewE6aEmBGdQfZWuAkwDffUEzu3xLt+volDfFcohYFrERdBtT+TmjXduy?=
 =?us-ascii?Q?KrsQtsFTGjk+W3lDVbeWG36Q0vJYb8StMCvxpk9W?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd86afe1-5491-4537-e894-08ddc45ec1c6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:49:01.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMx41PsL9mJCuiqhx2G0MvB/LjZ+ogxwLtK4k13BnpZlOmPgETP+2srZA1VfDus6WZ8kVM/c8toXJUnhdgu48w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6749

Hi, Amir
In the commit [1], performing read/write operations with DIRECT_IO on
a FUSE file path does not trigger FUSE passthrough. I am unclear about
the reason behind this behavior. Is it possible to modify the call
sequence to support passthrough for files opened with DIRECT_IO?
Thank you!

[1]
https://lore.kernel.org/all/20240206142453.1906268-7-amir73il@gmail.com/

Reported-by: Lei Liu <liulei.rjpt@vivo.com>
Signed-off-by: Qi Han <hanqi@vivo.com>
---
 fs/fuse/file.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2ddfb3bb6483..689f9ee938f1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1711,11 +1711,11 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
-	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
-	if (ff->open_flags & FOPEN_DIRECT_IO)
-		return fuse_direct_read_iter(iocb, to);
-	else if (fuse_file_passthrough(ff))
+
+	if (fuse_file_passthrough(ff))
 		return fuse_passthrough_read_iter(iocb, to);
+	else if (ff->open_flags & FOPEN_DIRECT_IO)
+		return fuse_direct_read_iter(iocb, to);
 	else
 		return fuse_cache_read_iter(iocb, to);
 }
@@ -1732,11 +1732,10 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
-	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
-	if (ff->open_flags & FOPEN_DIRECT_IO)
-		return fuse_direct_write_iter(iocb, from);
-	else if (fuse_file_passthrough(ff))
+	if (fuse_file_passthrough(ff))
 		return fuse_passthrough_write_iter(iocb, from);
+	else if (ff->open_flags & FOPEN_DIRECT_IO)
+		return fuse_direct_write_iter(iocb, from);
 	else
 		return fuse_cache_write_iter(iocb, from);
 }
-- 
2.48.1


