Return-Path: <linux-fsdevel+bounces-51738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5D7ADAFA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5213B60CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51227932E;
	Mon, 16 Jun 2025 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kUJqGMQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02275292B39;
	Mon, 16 Jun 2025 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075161; cv=fail; b=Ix/KLzG2ZTWgt9qi8MI1lsmF9AoV5U3w0Ilfm+H5kE0t91p+0wqgCgBtt0kbQYzbVh+ECaTlInuThFT0Qrnssecfz/30ZXElCHuSfuQ4ZQja57skHW3Rd4tAfqFywyQ4FmukblZKPwnkq4hWq2/5b4A8OCArOUZAA/bKvVhtvBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075161; c=relaxed/simple;
	bh=JiFu9ULNuTwFGKZYQA6ZmjP1MwUjLy3JTs4GTmxCjCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smVTX3whwlGDWmyqK36hLtGDsNPJHiDZvZLbn8w9WRwjVvT0pnH5BTQ+HfrITNHE5GteRGF1gKzEWLCcLkpgNU6nJfe7NPAswSy+zsdxyFj1ODtkxLXVHFVY5G1gwcTVX6z2x1ckmPSvJm48XARFPOhJlhKGHZu5nkCadb8DLSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kUJqGMQv; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Di4wdesScfi57RM6aSSejuuqQaUDIklY9JmYo2w+4pr2sesTlmGJXqDeg0fgxzj2JKgkHXAP2bnk2jlegJKzB4BKidGsU8eu9O2UDaf9rMBMwZ1twbHTRTvOYBgmievP5MfDnJIPMS/n1lH51vBA5odGUtvChZf8uz2tu6RrdG7wDaeR1AWCbTVNvPrDKidRq8PLvVvExEO/YyUYoDSUx9erLxvCqfbu/Lo7imHnt6H4V4ob99RfgiYouu70yUYFOxR+IRSAJLsTMx/z00s7fJ7qgBhbaCuikwyF4NAseiYdvsnjOJXwM/12pk18infA05bPQsJparTG8oFhW5dt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xUx1c5+/hnEU6D1bGTRIx4BR8cbdVRqbt77ULR2tT4=;
 b=Soh8R8uGVYZKRxUyC5B7493TZc4FCT7MpJBbxGX6QfimU4Us24LfBE8oyyVy2r6wwicZPVxkERsYiusI3GWP0jhMDV99V8t/EmOpnGsXZdR7KJUehfzXRvTIZCa6nkxxbYqj8tzTwNo2ipAYDr967KYU6efiCPS7NzyNwlihJQiwRxRU41ByLfyniQ2HbTpyHbSyCu1QVwAfnlPpr+/irnfKDewA4yCuRHaXW3ePoeGh8l+3P39KCbw80tV2hFnX8ZqzHo4Ae8w0sBxtLv2CwvXYZqDE0KcUvluz0W+s5/RHMJ7JobmgCdvtwn/7MOs3K8l+O/V6PHeu1vSJSjz3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xUx1c5+/hnEU6D1bGTRIx4BR8cbdVRqbt77ULR2tT4=;
 b=kUJqGMQvS/vtaOxHcPvn5viiUPIfOlP+N0F/Knkea2FAXMW6z295YyakyJ3+qSRm4E3nlijrrJ1Y5nYgHqq4cMui6TA6DzYNwyVTnvEKHr38M/vTqL8D0/Ye9baAa4rCM+2WB92tLjgSerxl430suYCzpeOoHYu7kl6RQ+2YZeG+jCJ9tSi1hqPgtXfLfZFePUtiFxDxQhIXIWURg/9ts/XMbTUryZOSvJ/GKsr24HVThip6taovq+10Vo8deSMAta71WzLcntCpNJ4eNSuTNEj5PPvpHzpPlTEQ53e3dgr6vxDqhqwg8NkEn81O//CtUB9CepKuQ9NKMYwkC/HwDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:59:16 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:59:16 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 08/14] mm/khugepaged: Remove redundant pmd_devmap() check
Date: Mon, 16 Jun 2025 21:58:10 +1000
Message-ID: <d4aa84277015fe21978232ed4ac91bd7270e9ee0.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0014.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:208::6) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 721e4d2a-a9de-4cba-a206-08ddaccd37ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H59VhGGio/sPZp/kabZ3OQ/K9+BtcrpGk3N87trms3MbWlBrSbw3jxdbF6Uw?=
 =?us-ascii?Q?jhfjYglKGQ3mRgEClBU5svhZg3Mx3cx16hofOJVzLLT8H/iNL6+vMVmyaf5I?=
 =?us-ascii?Q?iznmCRCg5bBcVstYAnm92b84/jSR4wkQY+/9mdnf6BmFq8m5VP0BySiAQng/?=
 =?us-ascii?Q?sfMc+D0ofcvBQ1cMHj/c77YIYR3QNAlvhhtHWGD76TUKiV81zsEl+jp1jzCM?=
 =?us-ascii?Q?Eve6DklwM8kEpQsd2BTZYjQVidAY0dqJ+qjYpOWEft75WPWufrUTTPAbLm3G?=
 =?us-ascii?Q?AF/JKs08rtlMtXlEP1SZb0OLDjQBtBd4ujwSQSyn2+uZk0sQWHO3m0Fw9DGV?=
 =?us-ascii?Q?W60iUZzXsTuZJZdZldRfsBt66feEoibj8ApVFiGcQxqrPGGWfmq8CaTsat1T?=
 =?us-ascii?Q?skcsjAd0YYRlmGW5WV4099J07J5Vdj6nLW3lQ3VDuNFNOoLOHJqBq4RgjH0+?=
 =?us-ascii?Q?xR7p8p33q79SA1yv0My69GSj/SiaJnJlfDatgEZ7ulkjmcI2VTOxdw5OZZ4b?=
 =?us-ascii?Q?ysQ0KhLmoWNyci39wlqoV/CQFacOGA32WSmpiyrVf0Vfy9JAh13aMyMNjlob?=
 =?us-ascii?Q?TXm1IuTQn1od3A/vEx39nm1XlVDV16KQr8m79XKRjtc5pgBEHLYXhcYUeeo6?=
 =?us-ascii?Q?Nvfkd3rmXve3z/HzBu87XCpHXvvko5HA87wtVU8aqUjVYoSOaG+8LfLdb7MT?=
 =?us-ascii?Q?EkpULo92jxNPw2/Xw+6Yhnje9v+uPo6qCCZKx9w2UFkGgbL6pgjcBZNfkwDB?=
 =?us-ascii?Q?daLLMomALvScknrvlXo8tTlDSO3KfS+KrOTxsmk/hAx1hFXopOmUYZtkVv7J?=
 =?us-ascii?Q?JEdEisVMSed0kdUqzt2HijJKKAEzci2rTfBjQc3ZRg1XbCWFhssCgv+03EiV?=
 =?us-ascii?Q?QVikQ9YsAvooAM7U2drBFEFtFUELES/9RvW/o8IRDcNeuuiZb+Mk85K6F3zI?=
 =?us-ascii?Q?PCdNLdaKUdcb0ZJgFEneylItrsFMqZTyQei1fZ7v9HKbxUVpaJtnpd37gQFo?=
 =?us-ascii?Q?BKdvJZaibJvN7Gul7NTJFkgogMVk/6ii+7b8kqMrgHr2YuIMWA5PqDUK+T6f?=
 =?us-ascii?Q?IulMDeAPgIEwdQmyH4nTDd+tE2r/X4or1M2lAB3gG7tp4ArUmKO4jWZaMtcR?=
 =?us-ascii?Q?jAL1k5oksDLnzWMwUXKqls66dKAH4423F4i/ySRwMqW9BbNR3OB7NudycST2?=
 =?us-ascii?Q?xA0xDLHHLnnLAOLfjeC3pQesJUsmx4U63amvRdAOY5G8eguSviCvjKmgxubM?=
 =?us-ascii?Q?bs1me8X1f9Qo/2bCJQpRU4f2A+Nk3hqvrUyyC/IdDQVu/L9jjNVAAoz3Mbey?=
 =?us-ascii?Q?l0N+E28WUNhp2IBqRFNQlWSI7GHyly295SDBejg5plY2NRnhUacbvNiHjtm6?=
 =?us-ascii?Q?pz1I/WqH87ubTjlZDxHNveDJ5E/oAMc9kQVdFmRt/CkbI4Lp1Uqyf1p3NYL0?=
 =?us-ascii?Q?GCDiQoMJ09A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bQu8ti42BdFfL3A+xR9lv5GYytnnvncmr9ohk2cTnLvtGtZ1FxFjpNyO6jIb?=
 =?us-ascii?Q?KfN0RI6SG+lbJimVKK00ehx8FOc77tnJPuyGMcp1KcAKqrzdTEVHIwqXdsNG?=
 =?us-ascii?Q?ymOjcAvWkMj6ZxfBIoql58frN7bnAOhfD5V8zF0wDwKG2GpDY/DsjwV03SiE?=
 =?us-ascii?Q?lws/pWhlpEdRc/u+8Rkl4NovHeFw3W6QXMFzeABiONWyt96zA78jsQYRibxa?=
 =?us-ascii?Q?fKBxoplKg+jhYJNbaVG5oeW6VFp0msPisXaQKM3LVNLx1BkfqRE8MwH9NjEo?=
 =?us-ascii?Q?lzUIfINja3VDRqTOEkoUQFseC56Xawdr5HRTsoA+QhmQ1xcWZ82isccxC5Di?=
 =?us-ascii?Q?hwUlLm3H3n5SF3LrX8NaijrTGsGeu4o3oESd6Czh2VdUrqc3yZLKWlUOxjLy?=
 =?us-ascii?Q?PI/ozwZmpsksBqGGx3zjd6hvqahflvl/lIXrbPJsW1Yrloi6a18l8WyyrGO9?=
 =?us-ascii?Q?i/puccdhY8UCUNQ0F4GkaM6SQXmLxN5d8tT3BdZYOvrvR1sYagnsd/a1RwlB?=
 =?us-ascii?Q?YKzBWfrrlCI1CFVpTjq2XfikPb78jfLtyQi4PJ9KGh2jLfn37skb3hXmYKje?=
 =?us-ascii?Q?WQO/aJuX7TUxh03QMBAZBvdffDMc7izSbOcN2R4YK8xpezuEuSIIoXnqsRup?=
 =?us-ascii?Q?CEftlDwMQAoBAHT9HWUbWwO8I091YN7gMX/aONQDz3yz9UrlvtYqsBVYzuPs?=
 =?us-ascii?Q?lcOt/dQkgPg1aR9rffgPC6ae9MQKsG6hNb7yDrGBZsHc316+2hKSbvwj2Cb5?=
 =?us-ascii?Q?rd8C9g+I6C2cFGYAoWai5DMRsvglH/5FTLWmES5VZK5xey/LSMrG/F3pwS2a?=
 =?us-ascii?Q?2/vkFxzA/M7/bujoYDDb32Ul4Ea42Kg6+wFCRWZLato0Y7ivYupSbYxIEeId?=
 =?us-ascii?Q?Ot0GJjjX5Gj9rYpVxASQ7sr15wi5+YtlJMSxFjyJmaEHuh3wSzd4ovatkbIg?=
 =?us-ascii?Q?vxF7v3hAD3aV/KgX8BsPtAo1xOzdVwJ5BF8qQ7Kwy93h1i5RWrLWZoNjjkc0?=
 =?us-ascii?Q?441+8v+8qFqGUQUejQdd2V0eXVxN5Jg1t2kfhOZ4CawVVLDvglUE5DUd5OC4?=
 =?us-ascii?Q?6NG+JnENJnsjxku0psJcYrBHPd0xVwPUwUmCviETg3d9JsEYY8n7kvqb6bla?=
 =?us-ascii?Q?s3EMRP3mgVRKQzXWYg6ZE537XljTVamaDK/IMmxaizRXxLvrk6BS2O/xG7ix?=
 =?us-ascii?Q?HQKDkq9DzA48dltpzM5RLzOD5HBJ/3praB/GFZ8IuPuDcv2NcHE2GlOKRp8A?=
 =?us-ascii?Q?Eqs99WE1Bf2kEH67JCkG6qUN3XSpgHOU2qXBF8vLdc1a3Wq6Tw4Ig4QcUMK3?=
 =?us-ascii?Q?PzLqsuCMdr/7g2jhacffZLpGggOFI6jnnatSflHbllJ/nGJH/1S6myh37Lsn?=
 =?us-ascii?Q?Qv/ghu2gvjuHls6n/f0DS5u4LQ6D5nBuKfvBKm1F8x9rYhK4id9Fm9mynlge?=
 =?us-ascii?Q?F+IRKtvHbCe1eY964sP9xNzB6Bs59/Xb7vc+bEe4oFeDMFQR/Pq30Zmowjf4?=
 =?us-ascii?Q?AuVk++luX/jc8euYBNYoAnhSdWwf7i1I9ryKeoIN3kykCZiDNjRwqkbfTrZZ?=
 =?us-ascii?Q?HqyQCZ+RPEzsRnMpx+oRLjrCI87thTXeDBWrRcQX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721e4d2a-a9de-4cba-a206-08ddaccd37ee
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:59:16.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VdXLI07pTpBfSsgZj2qgdFs50Wfd60VBRKXfhsZP5ez1RJ9Ui0MXHheK8fd015qVjVzO+e5+4Sfe5vnm8To4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

The only users of pmd_devmap were device dax and fs dax. The check for
pmd_devmap() in check_pmd_state() is therefore redundant as callers
explicitly check for is_zone_device_page(), so this check can be dropped.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/khugepaged.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 15203ea..d45d08b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -945,8 +945,6 @@ static inline int check_pmd_state(pmd_t *pmd)
 		return SCAN_PMD_NULL;
 	if (pmd_trans_huge(pmde))
 		return SCAN_PMD_MAPPED;
-	if (pmd_devmap(pmde))
-		return SCAN_PMD_NULL;
 	if (pmd_bad(pmde))
 		return SCAN_PMD_NULL;
 	return SCAN_SUCCEED;
-- 
git-series 0.9.1

