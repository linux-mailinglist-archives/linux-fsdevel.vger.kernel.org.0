Return-Path: <linux-fsdevel+bounces-50153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A41AC898F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838F617C971
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986A2185BC;
	Fri, 30 May 2025 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AHy/6okF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011058.outbound.protection.outlook.com [52.101.129.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3D213252;
	Fri, 30 May 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591813; cv=fail; b=aeFAxi9GYNegZFs3x7jdXK2v0WWxVLjdH+udV9PEjUiscnTfNsZxYXGczMVqDVZqFT1cx7KoFhyqLvc7xlLtVgYOQerYMQ+J4VbCxu5Qd6ATDG8cf18ZXTKthPQv0iKRn9lYVFgHSdTUVjZnUuJnF+iwLvCe8XFVoSoTN8C05kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591813; c=relaxed/simple;
	bh=j4fgK6xVpNIi2cPufYgRtsVaHAEqAiRx5jOnWyx3VoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLo4K/DrBn2yeckmYWwoP6vZYTvPiG7KjHpPua3xhj+aJ6taHy3paNnfm+s/ovjAFUcxlzodNcv4fG+UQbUzvi0cS4CqZWTqdahxZkdI+pY/fninhQeAnhCuOhzyTzCU2jnDz3PcvoTZtIdsz5lP3Dx0cgw+HxUPQRq/sgpzSdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AHy/6okF; arc=fail smtp.client-ip=52.101.129.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp2agSezBS/h2zzIFL9iOgwWNyDqUVPoRxI4FGRelPiDIb9mOf4ikHE2DGpcwEFxxKP0XZd8tYrRVjxpJPKqqjehEs34xqP708k+ezejl78oqKCABLxLx4RwtWK/4Fd5w1HeCyjnrbYKFLYSRZgzqdwNouNCgvucwpXzoApjjTUPP6kVpesv0RlHZkjWEwRMao/zitVu4SC6ymPttYawSHhxGIKcxsx4AsHi8qlPtYw015ZVWev22hLWmNhksizDfmYHgsy4tTyMtHyM6GVA27GRG6AOt6v42xql5nBpXdXLbTubjgLzR2O9uOUcsKejLvUysmwp0CDxe9X4fSsIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HpYVYk4PyWS1P4Mm5dYgY+eyjqPgaj8plbNGJvWvJo=;
 b=FryNtTUmSAkTmOPWARKXa0SF0x6n5cBea/PUZKO9nUvTKnLM2c2wJAqDD3zHUjXStEqBVCey7MNPavZcUnmoI39d4rogeHnoH7xbyj+/isFAqspEKq9sj6rocw0wS0svDU8E1aMSOqmK6rucwOPYnUJHvi/zjtiAjxg1LxvSXv/HpNx2GmSv4k+mHRWXNRyYK6l51WgZ8NABTtQiuP0F7ooe1SnYGp1H4rWRinriHlRNnLlBnSVNmnw8k0b9w0BrQ6Rq8g/MoHiaEM0xNx66LPE0aITvYdEglRLryCvTvbLSeUxKhVHdoDMJa5g+sYwuWEXXSbZqC8Q9lnzgLg0cOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HpYVYk4PyWS1P4Mm5dYgY+eyjqPgaj8plbNGJvWvJo=;
 b=AHy/6okFYPB1X+6xoDg9xH1rGglsZZ0d1HZqSqidgaVNbMw2WUcctwZ2pJMbuwtOQrlFlhGwLNEtLVEUP9ur9GMibgtVl5vBVZ532Hu53k1kePomPRa6W0E1ZHbtaom6OAOSwJlUzGTCcuphtFoGKNdbijZ8U4EQ4/8Wns18MbW+nKyTB3ON155HRWbep8eQnTBX5GchVa67k7bu6judQi2izjPUURtn5Psr3TPGhL60NQxFMTXW9V2jfHnZ9i2JuN5PEDyH/UEWuJ3E+ZWxmhkmTeTUFRW08wAlRuJxRzPp69YzU4HPraeIK5STBc32Ge58bjh+OXWRyLS0kUWXng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6415.apcprd06.prod.outlook.com (2603:1096:990:14::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 07:56:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 07:56:48 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] hfs: correct superblock flags
Date: Fri, 30 May 2025 02:17:17 -0600
Message-Id: <20250530081719.2430291-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530081719.2430291-1-frank.li@vivo.com>
References: <20250530081719.2430291-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 046140ea-6eff-45f3-2886-08dd9f4f876f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nNeVq/wAgIgbJZU/8bsfePphstyp3aIbnwC9ysKSCM1297fftAuwgHoZaMaE?=
 =?us-ascii?Q?oEIafnebUgk75AoEZ5FfM/ZKgFWklmdFwChsaGwQdw/4Y4ZADqtCOee8G13m?=
 =?us-ascii?Q?OJsn4ZaMVR4bPKNHHhTooVVzceAmNwSJXYUxX8wr+xiIoRccIon3HzxcH/3U?=
 =?us-ascii?Q?DEGMId1Hx2swK66NEx+Y4wx2OkDuXfAuT0NEmm+26lO5BE1GIvCyy8gbJfF0?=
 =?us-ascii?Q?k9e7LOjdBGtHADgIn4MsDU63h+kvgb68wn8foE9qeB7YbikTSsBRsrCt3hMO?=
 =?us-ascii?Q?XtvYrsZXEUU4ll1euAREMIRQgOOC8oXHwg10eaSQ2V3BtUsfYo93elISFdc4?=
 =?us-ascii?Q?PQIl0wpdPc7ZRlwT8k1TDK04YCvrUG2yEYP7Y6O0pSmLgb8ITP4VvkUux+Bd?=
 =?us-ascii?Q?O+2jGxMU9Zf+c7iJ2EZuIxYtiA49BgLxi9pkHUL0YPjxpatUHFn37tMFxSol?=
 =?us-ascii?Q?0h8BN9dFRfGGn7wFxq5H/Jw8K7pxR/8DBeeRCLPgsTWJUIU7+BMFJ3OlZNkU?=
 =?us-ascii?Q?MOMy67KaguTOcL8wTLHkvbzImMaCvLjP3vBVsVVp131vaPgvgdvEyJHp4+FL?=
 =?us-ascii?Q?J7zcdIdbz2Y6VCps9QGpbrxxppLlebRKCNa4X9By8N5tm/xGdUv/I8//Fetq?=
 =?us-ascii?Q?3+Tsv2Z/k7g9F5jdlek/QdCZxJ1Y19sswarnSUHVivfZg57ulbCe1yGvs4qJ?=
 =?us-ascii?Q?o3buVB1WxXJjy3MVcleWANhXrsz1BcwqvuKy24L292vqv1cQ+Ss7NUwKaeeq?=
 =?us-ascii?Q?bB42Mb/dAjaz2mjqLd3Hy12MoLzQkE6y08FO2p31OwxHKYQ3AkAXs7NCF3Hm?=
 =?us-ascii?Q?rJliFgCSoaztTIiMTFRI7PvH7uBxmOO1Z2La+OoqfemgU8eb6fE0gIBfXXxd?=
 =?us-ascii?Q?xcN/ou0n67/4htPj0SA0bTVlc4Qo7EVBPVJ8sO8HhSxf7PwQYXEQ2aDKCdK4?=
 =?us-ascii?Q?oxTEeQ2uQPYyAw5dE98rjWoP3WNZILxHvWl53h+bWxd+od1SzSp9xMCjv8Bo?=
 =?us-ascii?Q?rqN9iLoaJOL4Ldg5ldmdtadE/mpJPP4QRzesNEX5MraeVq7SAl53ZRelx+bO?=
 =?us-ascii?Q?qd0WPC8YTt2A3l8haiwcmZ/4zMBpRQVaJA6CHm8YhsY21U5vz+7rR4XOcoHQ?=
 =?us-ascii?Q?XoGnY6/RlERe8ytYNC40l9/gEetF1zZLTuBu9y0IZM4kKlHhPCWZQe/mWe/k?=
 =?us-ascii?Q?m0kxZMlaqVC39Hcvj0mVrpBfJtLTf08s+esz3/lmoIUYhZeqKs29DMF5Gbf8?=
 =?us-ascii?Q?Z9C8lVmA7du08wIWbL7GoD1NUJCHP9cl+Wa31rygcfYR1noZkCG0dtEH8d4w?=
 =?us-ascii?Q?ZTmfQfnqnKeiNOteKKzEnwDSBfO+xCkGh+yy73jqp1VfFcddw+ie4VqtSFsP?=
 =?us-ascii?Q?9CtWemmz7531HGvS4K7ooxQXNXDCLwwtaYYsMklDvktjJaxftD0OEbsKJwB6?=
 =?us-ascii?Q?HWhw3DY8Za2mKheP+HOjuQXdkltd5KG0Rb9gUO8bOXGdwB1ApqTLVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9c9BNUN4XVBOCilt06XAuGPWp3cAAf4jRGTBnqnHNJBO66bz1lPTpcVZcyU?=
 =?us-ascii?Q?3kwckNgU+3qNBmYVprUPhU2vwKWtiaV3T/S37owNFJWENbJYlbYfdFdhL7AU?=
 =?us-ascii?Q?BjYsMMopHLSyhMoB+DsjlDrqg5KkJUrISwKO/cehjOf2YhytiJ5VqtT+6Cgy?=
 =?us-ascii?Q?dLzO3je5+mk/EiEh27UEr7ZJPcFpmLa6Ewp8U/TJ/xXW/dqKjaMAHD2A93/g?=
 =?us-ascii?Q?HBRHx8yWEsfb1Ecp6mDBqHjgBQsj3GnGyDC0syXajYl2+Drxogen+bZzbyM1?=
 =?us-ascii?Q?sL0vwsqQc5bFxQ+jQKOi45XfUK1x3TXqNmOmLcaX/bvM9x0tr4SZM3lmppY6?=
 =?us-ascii?Q?eejuXAJ35g/ue10f2yFTMce/8oBwV6ti9z8RGNRpkgzPGsa9anPwmLOUpnLY?=
 =?us-ascii?Q?lUSsWudyO5GzniBJFUgoGHGViC2mOgR9eVQpvMLL8i4YvAPq/mndDZGi1UUd?=
 =?us-ascii?Q?gYz76ubUGIazjMoGZN1uz17KeymrZaMRyg0mthHqwrrzs3XtXX0xs9lqq/rA?=
 =?us-ascii?Q?8UMBw6GpmkIiE3a/MWIWwCFAu8VP6QIoFP8Ptir8ZcVOtIs9kTUUMv3VpUhJ?=
 =?us-ascii?Q?GljtSnxQUSzyzTFWIZCUeukvf5p+i9RxczpZLKAs+M9qryxQwyqE3pZOZoMt?=
 =?us-ascii?Q?/hyjszW3HYF7ZWUX24Ax0Hxbqy+gIlSCX6gIHi0OIrXMAbTu8hj0s6YCr55A?=
 =?us-ascii?Q?EAL9f83qeVFoaZR789tGGPaRagEOo/9DvPbPofTpDVZPrcTJEMjTceJQQzq4?=
 =?us-ascii?Q?A0MQIHE9d+TuEgGPAt9DY5adWnDklBJFQNPWWTxLftZksSqIV3/YWBE0INg9?=
 =?us-ascii?Q?gtGE0qVNhvb2MVnuiuu1S/h9FVwig7Mc3q8sgyB0LoouiiMiw5pnwXyiM+cD?=
 =?us-ascii?Q?aUzNSym26QyTyeekZGsM6VoqDbXHG1cydWXt2eSFoBR0ao6U5cOvB5SYjCJN?=
 =?us-ascii?Q?b8Hjf+TbF84oHlGuEHuGPRBUGudK9EMatAisy4W0IyX5pyqmAd+qYSDm8Zv5?=
 =?us-ascii?Q?v7Ft57jnr7NUAu9btYujL0svg2A5Hr5lGrCdmnukC1WMGmnKCCYYnsHgc0sS?=
 =?us-ascii?Q?QGOEawNamJyKWo1UygCPgB9wn38cJFjTCN+LF1/B+72vP5vHhvXcaRLkG5oB?=
 =?us-ascii?Q?O+fh9KFKfkV8ffybiCHMcbIttg//QcCF4guI9zDA82HMbA3fWkrS1ZCBl+dj?=
 =?us-ascii?Q?KEjQJuG8T277Co7aXFTd+ZknwpbgI/pqHKlt1DOB90L6bFZhc4MkaJaGI/hT?=
 =?us-ascii?Q?s8+doyWmLUSK6jzSKrwL/f6tXEqm2snO2Wzh5GPcyoctrWS/DGzfxbCclih+?=
 =?us-ascii?Q?za0tITGEpXKL8WZboMn6dPPV43HAmY0L51L7ZL6+B2kXOIrzTEiDaVy9KtkR?=
 =?us-ascii?Q?jVOiTykte8Op3ePoM0fI1SyUi/3zkoJ6PmHfG0TIogMti2+e3CvDX1tPyaYP?=
 =?us-ascii?Q?UmDGS/o4lL+AnQZgp/R0t9N6aF3tPVZs9cAiYQH7iZEcxK+JUGVKYwRUI1Vy?=
 =?us-ascii?Q?eYsUNwFdci9dF5BUN3AIsKp73f7AS2O4Z9LMFwxpVv3P5RxKSjBlV4zV3kaZ?=
 =?us-ascii?Q?hUC8Qa9sGOlrPKKPCl0mWOQ8BsWFR/MEgyIlLQTO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046140ea-6eff-45f3-2886-08dd9f4f876f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:56:48.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wE5KGqPTj+K2iAv8Wv2eCxqdeOz6ZnewqL7gUvvLbp70yfLws4PAacUIq9WuzdFWFMnJWsiR6vLwzqlcI1tWAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6415

We don't support atime updates of any kind,
because hfs actually does not have atime.

   dirCrDat:      LongInt;    {date and time of creation}
   dirMdDat:      LongInt;    {date and time of last modification}
   dirBkDat:      LongInt;    {date and time of last backup}

   filCrDat:      LongInt;    {date and time of creation}
   filMdDat:      LongInt;    {date and time of last modification}
   filBkDat:      LongInt;    {date and time of last backup}

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index fe09c2093a93..9fab84b157b4 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -331,7 +331,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->sb = sb;
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
-	sb->s_flags |= SB_NODIRATIME;
+	sb->s_flags |= SB_NOATIME;
 	mutex_init(&sbi->bitmap_lock);
 
 	res = hfs_mdb_get(sb);
-- 
2.48.1


