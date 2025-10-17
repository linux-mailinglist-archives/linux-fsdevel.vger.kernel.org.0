Return-Path: <linux-fsdevel+bounces-64406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8ABE60AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 03:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6CD1896E95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 01:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3B0C120;
	Fri, 17 Oct 2025 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J8MoDOKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA519D082;
	Fri, 17 Oct 2025 01:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760665000; cv=fail; b=gwHjplGkXsFGSuJmmdHEUzQXGjwfYXZNpM2oIlyYOwxjh+1mefHqa6gG0ECllh8G2DlPu+X1PgY3xpsaOr+E/JpRfaE8JmgjFLLYyz/SJ/3r/YzJaja0ISXjbCKoDqHhtTQOoR3wzTZ/6AxA/C6C8swVnArr5L29/VyGcfnWuqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760665000; c=relaxed/simple;
	bh=Z1Wam1jMMfCRVUnWCXS1hcwHdHl0xrTeehdtStaBYjU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QPcz0k6o4udYlJYkHAsgkRvw97c6rdyeLivW8ct6KT/mOUdZMXecGOdIeQDONOv6+QgY9QURjSy2JsL33/PAO0wQsb9yjTuoQ89WFmxUVowq2VQYR8jI3ZdcWUS+Pk8QpsKc/twvJa5NmUgg5MAaqFnKhWdbnLyGMc/j/+9UgPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J8MoDOKc; arc=fail smtp.client-ip=52.101.53.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbBbI1T4PFNTKSHY5QgDnZb2WjdC/IxIiKAOpm3nBdbBCbDY9Njrd2Oofjc26aKhHFSXW+sBh8+cBHyzxZ7WFu/zuo4ziWtbd2uCkwloM//MwYFU6s/+MKtiGrsucHfnqofUFkZJMku4jOhWiTGqqGptzzHeOxe+mreyYVs9Cowy/u4tlLsxgAHUQbitu9QeLkiX1Bmu5IdD6HfCeSfamZclnpPpfPH9Ju4knEbHWRe9yLESWvkCTJAm7vr5Vv+OIgq1jeM3jHpAjHeDcG6ICzsbVLWDzPNcTEpJXOMlNT/FzcifjHkOWi+oSfG/ePsrXziYewiAnQrHPEcFqZvzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/vfD8Hd24uSEnrfnL2I1rNJXx0u/F9JcQfObRgB1hs=;
 b=G6vKd2MX4R83wsDfgXWXo0ZEc9cFBCMTHMeqlO0WERch3yU9u5Z64tYrZ05h4CTUSqiWaRJkq5adOph+vG6ht/f2e9s9hSvriAfB9Ohhv27y7my2TyO7NBUtrcVTc0KEy9owUx04GUeVdt/V+F7pcSZWvQQ6j2ac0sqsxUrD2ib59a/YUMDA6T9BoRZPZuFZu83m9/jtpDgPifH9K7cCNthRgrwnleo0tbKor/Ujpo/VwPLridn6VVFgmXmBT629WpCTnT+jiu3dElOQAUjC9ZoyNwNtJgSf96Njhd2J8YMy4PBY7OwqpHly6H4nanKPQ3zCpNjJ9sxYwdHXWh6J+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/vfD8Hd24uSEnrfnL2I1rNJXx0u/F9JcQfObRgB1hs=;
 b=J8MoDOKcAF7b30ulr0+WBpD0Dtcv0re9xbjmD/Hbd72QgcXzByzlaugqJXX8H4CvNbEG0zsYeVMD9cztVIiPxmakS+YHIKX20jOle90BBUgN/iAPbthbxNMJHiNn/8rZLR+wP88g5umFf/qWLPRZCfNbPLkm3TPlt0E2V5vAd98poNvBef7my97QBWDEwgz0pTSQw+1YktNh8/ukQO+ZfAkpXG03/ShcMnHUyMGxYLkhzVrg6HzzHYH3wuXtvRc69HYoSFBfq7nm7gBQjNrJSrkknCTkW9N88PLjz2IAmTyAJQpK8SZrjU8OKj8nYrPl6rcBoLKgrYcRkc2d6dg4zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 01:36:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Fri, 17 Oct 2025
 01:36:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com,
	kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Cc: ziy@nvidia.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3] mm/huge_memory: do not change split_huge_page*() target order silently.
Date: Thu, 16 Oct 2025 21:36:30 -0400
Message-ID: <20251017013630.139907-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 048b23db-1302-4449-7a1d-08de0d1d9bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XLP4AnG2cs9YqpX4H1lHGYMydrK+jVOSVGxRWljK2hxDjB39uB9t+5TzvZXp?=
 =?us-ascii?Q?EZwSZIS6WKwJ3mTc4lBiD/lPz6qwDQYmZJYIccbtBtkGLNd0xq3sQ3Pnt1xG?=
 =?us-ascii?Q?wLGpfTQwOeexV9cgs4fmbAt5LTqfnmYHvejwEWm3VWjNBwKUI3fHlIE36cxD?=
 =?us-ascii?Q?EDAAPTeJFU2L5mGdayriSxhlc6Hq6G3SNbtgQoRmDSzdp8jk24leaXcw2eUQ?=
 =?us-ascii?Q?4v+yxKlZDSdVC+FmbDAqnpg4MQi/0YyU5dAXn3UTxnmheh98mIg+ajsy+mVJ?=
 =?us-ascii?Q?5sLCrL3tQ6h6/atv5yIRfz6mdlrfacuTUF9Kwz7DAwj0tNxUIfPwCBeSsxyh?=
 =?us-ascii?Q?S8sF3JkxKzgNX+3oheJ8fEWwJfBkxMeW2pdTTiZA5xiZXiYHZjAUQsUHZ7A5?=
 =?us-ascii?Q?LcVdwSiIgstpDpfeFNrneKMhFfumZ4tibjN9CAoNc1mnNCpPLfhC1CW07nLL?=
 =?us-ascii?Q?H7UWLeDPMnw7R0W/x68qA7I7RMwZSDs6QsmHB6FhXMq2tjH/bQFAM0SuBwpN?=
 =?us-ascii?Q?TKQnzWSLTYHGPLuEltDqwDRXvSX5UsJQTa1B3QV+kdvoc3e3r/NgfDyYx4lI?=
 =?us-ascii?Q?7sjt/rdxbDbBP/4SMlKibL9Jj4e/pSpr+QaqYckh2/W/snHTJ8nwQXm8pLp3?=
 =?us-ascii?Q?djLSh40oMO+jJ5LhlLkOUFjoCBaqtNmXHaM8AUXYARkXORpX98J9dMT3pf26?=
 =?us-ascii?Q?EMJCrsNBrIP8sAGxXV+5uL6TT1X9M/uJZJPRdERxcPa/E5oLS7wB5sSXZ+oI?=
 =?us-ascii?Q?GpL6hAHi0eS54pTDvkC6E8qoL+TXGaSNFNh4NB3Sca+YyojNHqpqc7gJGaW3?=
 =?us-ascii?Q?QMMhkT4gEKzEXiN2AthHNmxP+1X+VC8/Cq6a5LDIvxIO4O1OqrttqbL1cPHf?=
 =?us-ascii?Q?JDHB8ZhQLDWcSFM+r6cOisou7RLQivOLLNbpQR3IHa5kB2MpMHoGUbS3qa2X?=
 =?us-ascii?Q?lE1s02jeHDWHcG/+xkir/sugEJD32KgCJKNECHIYFMITdXk3YzBMGaZF8KYk?=
 =?us-ascii?Q?y/bolEdP+P+p6gjgNLyj3g4bxc/kGiBDUdxjA6vehwFX0IB9GsjQQEYqgRm2?=
 =?us-ascii?Q?l2LNp5/FCA2oRUgS7QyvWvw2/i25GFbsEW+gWxRn/YtLHJUYocTBo3QQQdd8?=
 =?us-ascii?Q?q/TI9kBDPskKbHaSsr5YPyMeNAKLrW5AbrVLm6ozRN/SzKehknyiruZViv+F?=
 =?us-ascii?Q?TmJ9kzdRvvD3zCOVslWJ3RjxTTuz7QxI5OOCRq1eXO7qcNl/DPazMGyhs9o4?=
 =?us-ascii?Q?vWhmo1HKcqpP+yD8kIm6kry+jfWJGH3iT2gyBbodS/e4Y7kgbjnXGOruGdLg?=
 =?us-ascii?Q?wqgx4xsCI32bfUTYedjlRqLhi5zgBB4KFQO8P1i4fn/GkVxvMQwMnf1JOG2x?=
 =?us-ascii?Q?QafA3rKq3Vv5GCs3uOgqYM0+D6Uzp7IvrVD3zb4XhKi4todhrI4UwJufcPNz?=
 =?us-ascii?Q?0dCPkDQ39r0Pljc0LhOALd+yl8wk3daRaEzHkDD14tKG+P9BqYjQrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTqqR/BheKt8dXsVHi3ej/aTnJp3HNVcUU/iAZtnMiK/dubDWWzEL6OkkiUi?=
 =?us-ascii?Q?x7ZJKRz+PCLY83bBCOnAaZcqkYYse2kYaoZ57KDp6Bri9S+VerAzxWiNf573?=
 =?us-ascii?Q?ZXQD6a0WDwoyJhUYddu39J1fubosxY1JYwGmzyBEFYKBrQ8jd5P580dsIovR?=
 =?us-ascii?Q?mUY6vZt48+JFDtcpD6KnfPuxf+n1/OiM2PCveJnelgJb84Ykas/jcDbWCDPo?=
 =?us-ascii?Q?gBOzXcBYlLRgdwD+QVF6h/x+oFg6P/4x6C1FspqS8x8xjaQifHmd1/pPGD2p?=
 =?us-ascii?Q?5l5Hl9nBpu0Gyd3rMHN26xepF3igYO836nCJM1KnImIlHIoA3q/07MYBdKN4?=
 =?us-ascii?Q?bxIEFZMxmSQ3ynfBrSaemh/cf8DzxrIod7P5Iz0fnNBJM8HnaTSf5Nmk9NXz?=
 =?us-ascii?Q?NRaXPuLxWv/G9HuPrCLfxhVCcoyGu+WllkYkidBV8Kbt9JWakF2adavMkjno?=
 =?us-ascii?Q?MEsiXYpNMg4sfGJyOpS1fJryYIYUwhdRt0R83n4+pznVAo7y1YV0++15P3Mg?=
 =?us-ascii?Q?SgD9OxJD8r87K3bTWKiM3wk5P4Nj6jNXEPDuE6K3aaG6KXdQPx2SovCnw2by?=
 =?us-ascii?Q?G8XGDwA2h2H66TezIAvSeUz2xovgYcI2po7L+Q5KcAi69bYkCGaxSlJIQU0t?=
 =?us-ascii?Q?lo4CEEpKj6GKUkFm1/oWGuugJNCYvLE9RIZqi3hVMMI9FgEAjZSZQx8oNXbl?=
 =?us-ascii?Q?fnTm9DlEYBUX8giBChaa+KcMtc7L5N/JqEk7mNGokmI8psw+4EsmouPoqZ4r?=
 =?us-ascii?Q?ctpfpwe0Nw7bBP1+youpi1DXge/eDgefuRDgMp3HKEk5vUM0wFtouVp7qdPd?=
 =?us-ascii?Q?h8JNwGxKntJ6t+EJf7QA7b4Fz0RM6e3EW4aCzfGRAfeL5EAL2gxzKP1uoHdu?=
 =?us-ascii?Q?mvScJdii5Hw1yuGWH+bvRT5/aImfNaFKmeYhJvtFXLQDIBeUXycMGREHcQwe?=
 =?us-ascii?Q?VyI7vgDdwIN/F2+xm9cIGrmzVY1FLjLP8pEsMsXLltCp8PQA6weYW90pPkwW?=
 =?us-ascii?Q?U00FqbtZ2UVUizGuM7SZXGLrMaHuc1j+63G9ucDHSQx3P59Y/BroC+z7p0T8?=
 =?us-ascii?Q?ZOleIdz7/H09H2yn9QbCsxvQmfCJDDGHvm2LiGQXUMIXvZLQy2+vXfvYHlMn?=
 =?us-ascii?Q?L7thhl7HaQYZIB1YDD+UOyFkNCTmYZXNGl+MxLrL7hagZWh2+eLQwcxDfXC0?=
 =?us-ascii?Q?e4emUnl09lHuq+YyZ3NEtzhJA4SRl0oG85j0x9rZxIgJcLWNBwiq+RWJRPmO?=
 =?us-ascii?Q?XHrcvsvZsNY5XLCbuhrw40FXwLRic+FPQCkT/p0P3/yhlcdkAoEh7x0I+Vau?=
 =?us-ascii?Q?1B+vEbzzmPpfS8QXpHuVyOZmBBYjwyZ05P+oNW9u4AGy4kLCc5dSFwPm7WPc?=
 =?us-ascii?Q?SsXmokPvaZ6sgCzeTG13YhTdRKZKdBDAsAumXHlrWPmCe2uNFLyPCgOUrUXQ?=
 =?us-ascii?Q?Tz14UuPF7kBuiE8LUxSBOHdlNQ47FbgBgfQ9kSqXViPSNTCtP8Up1qc7bRG/?=
 =?us-ascii?Q?x8M0pL+oyKvLmxfv3hocJUEONhinIat2HBfJdaYlzZob0r/RosMNc2PHqwQK?=
 =?us-ascii?Q?ZnYbpXHY4tTGwT8aA5RurRk8xhpTeFmRSPv75wBe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048b23db-1302-4449-7a1d-08de0d1d9bdd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 01:36:35.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHeWHrSTB3wgxlkXbCSCmEr7oLijjz+neS3HlNr1k2xlDDLuIVf6M7HDNeYD58zv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462

Page cache folios from a file system that support large block size (LBS)
can have minimal folio order greater than 0, thus a high order folio might
not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
folio in minimum folio order chunks") bumps the target order of
split_huge_page*() to the minimum allowed order when splitting a LBS folio.
This causes confusion for some split_huge_page*() callers like memory
failure handling code, since they expect after-split folios all have
order-0 when split succeeds but in reality get min_order_for_split() order
folios and give warnings.

Fix it by failing a split if the folio cannot be split to the target order.
Rename try_folio_split() to try_folio_split_to_order() to reflect the added
new_order parameter. Remove its unused list parameter.

Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
[The test poisons LBS folios, which cannot be split to order-0 folios, and
also tries to poison all memory. The non split LBS folios take more memory
than the test anticipated, leading to OOM. The patch fixed the kernel
warning and the test needs some change to avoid OOM.]
Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
---
From V2[1]:
1. Removed a typo in try_folio_split_to_order() comment.
2. Sent the Fixes patch separately.

[1] https://lore.kernel.org/linux-mm/20251016033452.125479-1-ziy@nvidia.com/

 include/linux/huge_mm.h | 55 +++++++++++++++++------------------------
 mm/huge_memory.c        |  9 +------
 mm/truncate.c           |  6 +++--
 3 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c4a811958cda..7698b3542c4f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -383,45 +383,30 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
 }
 
 /*
- * try_folio_split - try to split a @folio at @page using non uniform split.
+ * try_folio_split_to_order - try to split a @folio at @page to @new_order using
+ * non uniform split.
  * @folio: folio to be split
- * @page: split to order-0 at the given page
- * @list: store the after-split folios
+ * @page: split to @new_order at the given page
+ * @new_order: the target split order
  *
- * Try to split a @folio at @page using non uniform split to order-0, if
- * non uniform split is not supported, fall back to uniform split.
+ * Try to split a @folio at @page using non uniform split to @new_order, if
+ * non uniform split is not supported, fall back to uniform split. After-split
+ * folios are put back to LRU list. Use min_order_for_split() to get the lower
+ * bound of @new_order.
  *
  * Return: 0: split is successful, otherwise split failed.
  */
-static inline int try_folio_split(struct folio *folio, struct page *page,
-		struct list_head *list)
+static inline int try_folio_split_to_order(struct folio *folio,
+		struct page *page, unsigned int new_order)
 {
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	if (!non_uniform_split_supported(folio, 0, false))
-		return split_huge_page_to_list_to_order(&folio->page, list,
-				ret);
-	return folio_split(folio, ret, page, list);
+	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
+		return split_huge_page_to_list_to_order(&folio->page, NULL,
+				new_order);
+	return folio_split(folio, new_order, page, NULL);
 }
 static inline int split_huge_page(struct page *page)
 {
-	struct folio *folio = page_folio(page);
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * split_huge_page() locks the page before splitting and
-	 * expects the same page that has been split to be locked when
-	 * returned. split_folio(page_folio(page)) cannot be used here
-	 * because it converts the page to folio and passes the head
-	 * page to be split.
-	 */
-	return split_huge_page_to_list_to_order(page, NULL, ret);
+	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
 void deferred_split_folio(struct folio *folio, bool partially_mapped);
 #ifdef CONFIG_MEMCG
@@ -611,14 +596,20 @@ static inline int split_huge_page(struct page *page)
 	return -EINVAL;
 }
 
+static inline int min_order_for_split(struct folio *folio)
+{
+	VM_WARN_ON_ONCE_FOLIO(1, folio);
+	return -EINVAL;
+}
+
 static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
 	VM_WARN_ON_ONCE_FOLIO(1, folio);
 	return -EINVAL;
 }
 
-static inline int try_folio_split(struct folio *folio, struct page *page,
-		struct list_head *list)
+static inline int try_folio_split_to_order(struct folio *folio,
+		struct page *page, unsigned int new_order)
 {
 	VM_WARN_ON_ONCE_FOLIO(1, folio);
 	return -EINVAL;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f14fbef1eefd..fc65ec3393d2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3812,8 +3812,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
-			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
-				     min_order);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -4165,12 +4163,7 @@ int min_order_for_split(struct folio *folio)
 
 int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	return split_huge_page_to_list_to_order(&folio->page, list, ret);
+	return split_huge_page_to_list_to_order(&folio->page, list, 0);
 }
 
 /*
diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..9210cf808f5c 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -194,6 +194,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	size_t size = folio_size(folio);
 	unsigned int offset, length;
 	struct page *split_at, *split_at2;
+	unsigned int min_order;
 
 	if (pos < start)
 		offset = start - pos;
@@ -223,8 +224,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	if (!folio_test_large(folio))
 		return true;
 
+	min_order = mapping_min_folio_order(folio->mapping);
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split(folio, split_at, NULL)) {
+	if (!try_folio_split_to_order(folio, split_at, min_order)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -254,7 +256,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		 */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split(folio2, split_at2, NULL);
+			try_folio_split_to_order(folio2, split_at2, min_order);
 
 		folio_unlock(folio2);
 out:
-- 
2.51.0


