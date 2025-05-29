Return-Path: <linux-fsdevel+bounces-50069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14819AC7EF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 15:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BC21C032FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22BE2288C6;
	Thu, 29 May 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aZrOnnOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011067.outbound.protection.outlook.com [52.101.129.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8016226527;
	Thu, 29 May 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526010; cv=fail; b=nTHKSLqPw8vwIgf3NF7SeiwUHGys8aCaAB/+/B2R2qRLwyrmuSOXMNms9cTXaiiyA0zpyfVlIc5X87Rd+4Ea/D5Jlzrmbe02Zue0qzsUZdhTFL6JQjY5Xv4T/yIOF+UGp3G+LVHxqKJrqm6X8oh0xphrH77DJQfdxNz928lqYKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526010; c=relaxed/simple;
	bh=sQw4txyb6Pm91TeS3woOHQ2ne+U2b7Xbqyy5tEOme7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fWjCqzpTVaOG9zLxmsEqSvTurg2wAbpobKJYzbMq89ceY5leBIG0988SG3gnTFcBihk0Hz4FWudEzNklVXisCD2lfcZGtZaHTWhRQVRmz4U83s6rzjoKsbwfY19OAv6kQ+Ulyqm4hhPTCOn/ImQf4nN6H/HtHLd5UFlT1/SSaRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aZrOnnOx; arc=fail smtp.client-ip=52.101.129.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d45bNmLwRN+sCW5mfVVpPUuqqDwpgYl1jttEWU87b9Vs2ZSeROXBrhEVNq2xHICum8hxTvbzvpmMDqHDLuQvWcF8oPaVZYRKMoLXFINGvUxbQLKGwKOSBc0XU5a0OP7c921vMUFgbwvRaCB1QCoaCS/XVB4iKZN7FFk9GxbUYDtjxUClaBooJUTyjF1tcRSbMElUkxWrmB5l66v46MZ68KqLEkQV1Yis4XjeUVsZVAdJa+mXPUePScfdR2otfCd+4aQCvhPxS5kZyjIpQOkAEgYn1I0g3zuUz6uY6bgLo+0/GnZr9wsOV/sXfhSnONer43y0Xtjr55xr59r6273oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2NVLoKNyUSV6Ezr0JuWwpRhV61Zq9dQZNdSD445xBY=;
 b=AJ99sZJGf5tfFEyJZnb1ak/wnBoHIvrpvUYGq8EiDCcx7zDiSyS3p9C5adpJa8w5jMdmMYmsf6LFsqC81x5G5ceksMZUZOeIVY7itz02khiG41DigbJmVhYlUQLKhpaBqvleL+80PSxetpRkIg8PnTJBcWsjO7zxdpU91Q7/4K/IbXTH7HuQYjrIMn8K8kyS88v5bsX3ku3T+pbc5NjlRinvEtMlDEzljB8K9ie0qQF4MDCDHngjap6QeO7YBZ+Gzojf39PArhBVasD4bJphpHyWisaI5An7Iv1yyVAB/CwJTudrYhwCUb5D740qXvGXOXpfkK1p/9X25K2HoDvm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2NVLoKNyUSV6Ezr0JuWwpRhV61Zq9dQZNdSD445xBY=;
 b=aZrOnnOxgOMU52sbQehcsgcjVUXpxUSD3zIFOGGMlwstw9tJTwNizRBEg4M7sxy4q9iHIqVn1mPkP93rQJfuLC4Ipnhyw6AclZZlTOQwNxmAA7tekn/uHKXZzyRuX7mkhJKTWzwPrBGWXGbzgQ7eeBhmAl8O4JIuaiyoubCY0RB+5RnCG6aHB11PVv3OJ7jAZ2iiHLVYQkeo9FzfvBOy2yhgnvDybHSlk91n6GDhnNs7ny5o/jhg7KH2urQSHhZULYJxwFOxGXNcLY8n5rC4ZJ076ddAvXJ5NtHfL4vyrNTfiPrwosGXGBkbGnr5TxtjxOdt9ppReoLkzDAlfgN5ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 13:40:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 13:40:06 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>,
	Kees Cook <kees@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hfs: make splice write available again
Date: Thu, 29 May 2025 08:00:32 -0600
Message-Id: <20250529140033.2296791-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529140033.2296791-1-frank.li@vivo.com>
References: <20250529140033.2296791-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::35) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1623a8-9d26-4971-820d-08dd9eb65260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLlx38hSRfIsDvgGG4hIJ39fyYU5Dn7NeSZ3p6XcxE2p8RweHqp9uKuM47hI?=
 =?us-ascii?Q?LuI6doDZKlyBlSdWKJPNp6CBzxnr45mn8nAqW0KKkzkk56L1GVny4KO1CS2b?=
 =?us-ascii?Q?RM4gfA+44XsvnC13yV7vYBUDPkotbekTfAQCUw7SjmWVy5t6LjIiWUD5khqG?=
 =?us-ascii?Q?HmQnFfyD3wjh/YDcjAjjq6S5Q8R7IQuLAwENJBwceWZu0dsm+IU5P5sa0nFY?=
 =?us-ascii?Q?TuhGYDCo9IB8zU0w81iDb1JDkaX1ymUvlPEDiIIpUfsUdIFWvzfKciKb06fZ?=
 =?us-ascii?Q?D3Yym8H3wz6yY3YAo4UTpbNy9K/ajhesN/FdHeEmFtvjV85MZIMIw2GrsUEo?=
 =?us-ascii?Q?Q0dSI7IHy8apD+klXwAs6Z4YwW4n5F4veSa3jyN8ily39pms95T/X9Yv426N?=
 =?us-ascii?Q?eb7Y60K/j1FoGAPeRVfGyT7IwD0bZRe4Tz31cpbyF4d56A2qkKROYoM4Hiql?=
 =?us-ascii?Q?BlqDs7fMw+/dQWrmYhp+FXwyN/CHA4w9yoG0L6DfMezHM1dvZClvywevj/xQ?=
 =?us-ascii?Q?6v+c9wEeEMT3bct4pTf+wMtCLnlNkGxDZWkE3o1Kij34md716/74hWgmceq6?=
 =?us-ascii?Q?f6qXhqJKuYysVF0OMDfLoKhyBb9Q31FkXXXx/UBZh3OfSzpljE4w8RqZ89KO?=
 =?us-ascii?Q?HaRmUXi5murj4zy6a6iih0fKQxkQVeNmZe1N4yAcRBdjjmF4MOoSCTe8pbN8?=
 =?us-ascii?Q?vriS2op0tZ9TeeET245Hce0btyXT3XLSocNNzvQAuc1q+fJ9v887xTUeQ4ym?=
 =?us-ascii?Q?KevFKn44X3ZX3wK3EjaqabaYheU8dRvELx+DZiQdDrlLCTGVpj6f3K1wHIRq?=
 =?us-ascii?Q?KTWVDHDqERxL+ihzXsBY9DiHZloFDV6wLKPGNxbeo5eeF0Y8nRo5qFnPbR26?=
 =?us-ascii?Q?85XtA39cuajFOEcQWhCBRjZzviZENLnGKZdFGivb0pVtmrbR+/BIsjM7W61Z?=
 =?us-ascii?Q?6U4Zr3VH9t/dK67x7V1mURtruRn3LxTHD42fRNtvzf6DHTEk63NoUmzJ57rT?=
 =?us-ascii?Q?9KN07TZKOK+y/DJKtPS5Dak7JlyXBJbSx5XXBdocI9Iz/sRvpmMbLbhGSV35?=
 =?us-ascii?Q?GNre7Ui4DMR9zEpf7MsugCAenG8dH8qY5pUyWkFToHWqZa4MO04adzTmsp95?=
 =?us-ascii?Q?hzkZhrcZRBhemPGPZ3IMKtYnWwQ4NYWom/cixAf3Z/MNOjFETLVmREsCYv70?=
 =?us-ascii?Q?h5qBhZ9ek/Cc5qaCYi3rG6/TFqu6i4OctEh4LvRRbMhU+e4rkFmSH9Sguyvu?=
 =?us-ascii?Q?5H0yf9tNZ1nJPjjEtF2Qx4JKdy51nddI+ZWEnFZ3ftS5R3e2R2zWh6UKxc7E?=
 =?us-ascii?Q?+1XlnsMS9AKGMg+sZsPUYw3FqOYRoFOmwESGrrgPFlm52JL3w6gnrUGhu7Ab?=
 =?us-ascii?Q?4Ow4uBehzkQXlwc/IwUrYQ2/gBWc2V833pbMFsoINnVony3UTuwwSmLJ4nLu?=
 =?us-ascii?Q?0EGrNH3/OnwyqIZoBGzghWkDNTFk1OXdts6tsPl2d80y4icqdAzaOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mB4UIdSdzqAd7sEkEfmbaGu6U9LGfHAH4RqcIh4MhrHzco/469+gJYNsWd1r?=
 =?us-ascii?Q?PLC4yq/YvIxaUXJz3A+rTstIt7aDE8XgqLrVyUsQ4YvyWMxEjAtArKvfWv60?=
 =?us-ascii?Q?XzzimRMtTXSosbeTqVS53hLBlsVrS79lURSUDp5wkvKrNKAZgfZNcHlXOCqr?=
 =?us-ascii?Q?qDpBxsEmhxDCLA/W6m5r/daI0/+Md/SRD6dhV8wrN1t47yEibvziSszja3sT?=
 =?us-ascii?Q?6hPHZVhHUeLWhqyeJewTFY++xWpgSjZ9dBMMjYggtyggQIRodw/+2+Mv/4yt?=
 =?us-ascii?Q?GcUPXSTcFtdWAKURR1g1p9az5snBEBo0L+FvIaKBRTkFTRCMn1lOJNW8b9sN?=
 =?us-ascii?Q?81Br8TEm6oBH9SfS3iv+A3dag8fMTShDgW32LqMrvAL1RmYXzeB2OiCvooot?=
 =?us-ascii?Q?qEvH4cor9wzH3VHWQ9praXNxzfkiiX4ZX/nmyMBjQqg0LkkAuLrnOThheSW3?=
 =?us-ascii?Q?EaKVgLjM3OPIAjRv6aB6Vu1NzhByjDL7XBvjLHdcUVF1dreXvgeu0HOpkh9S?=
 =?us-ascii?Q?8VtLhkmbTubZJ0+5BFG9PV00vKMqFHtEmUlXTEOyAiQ9v98IL7PtxsVT1o/4?=
 =?us-ascii?Q?YlD++xnkJTsXj+x5jpCElzNYNeRuKPVaXNqGLU4+yxBT8chUYkznVVKBMpHM?=
 =?us-ascii?Q?owl7SA6qDLO386nWeEMXdQvKVCqBkMD5kIqIEr7Ew8NCUaN1vcn8Ho7IwEWF?=
 =?us-ascii?Q?gCemA97/sZX1LmVQ9EMZoXs9Lrzo6c2cPqNzV7S7N1VdoTpk3pLvmklVwnRy?=
 =?us-ascii?Q?sVhwUDfq3lOImifuqI99lpa3JiITje/fvR1zMrSD0cm0ZKSMIbBER8fixKLn?=
 =?us-ascii?Q?dxYuxp6DTQ6lulSoV/9AFShlQRywfALiYcorxVsaUhJW2ozEkw4QoD8Am8wy?=
 =?us-ascii?Q?uVvehAhuxetjdWoiZJnlmWaIxJtKrMrsKLF2YqN+coBPVkKllzcULEjI3taQ?=
 =?us-ascii?Q?pQ3IxsBY0ceejS4h3sbS/Z7R03ZNkiLYb1t3yj8Cieg+5u+zoqaUuKLrrQvl?=
 =?us-ascii?Q?vEyZZNFqMlLiaVj3Rw4yBQsphi9xLfXcKq+Jnd4BYhGBcPAWE7phnqOBTccp?=
 =?us-ascii?Q?SE4ohhoCkuCNW95+uxtAu/IDwhBgXPCCgJdy7OZEAQg28e//whz63sqi2T8A?=
 =?us-ascii?Q?8suM1W4U5B3q/xPUt/V2CsWaGqa+c+QwNYlJeIHAgeWGQktSLTupqgHaaRMz?=
 =?us-ascii?Q?4Mpvv+3VvE+1r9TG2XnREktgvItSlcXRMx3uQuxNlY/JLdRymFN8XMsZq41x?=
 =?us-ascii?Q?QDYsdn+5ra/AnohNCJiIE+nmGCfhk9CcmSbBVKDmw6jeosY2yUKy9RoBEHOa?=
 =?us-ascii?Q?zaZWFdlEaFtqtiNVUtuVfPbCBnEX+txxUDRJsrkS6jZdX0fstnXqLpx9ZGfG?=
 =?us-ascii?Q?qKc7fS7blOPD8X+s8fD//ian0AvguBTpCLEob6owLcJRrqR68NBPh6MqPqD3?=
 =?us-ascii?Q?4bYryGePJ19tCcEy9ERoXMf19MkdUJdYVopQ1KWQbkyz1jYeWCnov0b8NCqQ?=
 =?us-ascii?Q?eAGNMpqGMaQEhveauCvR7fDBY5SX46bI02iq10b3VYEjAGvm5b5DQK/PrqH6?=
 =?us-ascii?Q?K5JLnZtGjvO7Hj/SzovKGrGyQ5XbhQu7OrViO9ew?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1623a8-9d26-4971-820d-08dd9eb65260
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 13:40:06.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUV8DOBSj0ERV8x2/B9MrzeyvrRkRJ9Og72NhAWdsCGfyg4FecTa8Tk5FNrItMQms849/0lM38cgQWfai/aThA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034

Since 5.10, splice() or sendfile() return EINVAL. This was
caused by commit 36e2c7421f02 ("fs: don't allow splice read/write
without explicit ops").

This patch initializes the splice_write field in file_operations, like
most file systems do, to restore the functionality.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a81ce7a740b9..451115360f73 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -692,6 +692,7 @@ static const struct file_operations hfs_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.splice_read	= filemap_splice_read,
+	.splice_write	= iter_file_splice_write,
 	.fsync		= hfs_file_fsync,
 	.open		= hfs_file_open,
 	.release	= hfs_file_release,
-- 
2.48.1


