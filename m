Return-Path: <linux-fsdevel+bounces-51743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB74AADAFBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBADC3A2293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ABB2E424C;
	Mon, 16 Jun 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzRz1DSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B82E06FA;
	Mon, 16 Jun 2025 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075190; cv=fail; b=Ev+g0oP/ZoH61NMPcKXK74pG149oK9mS29mC0tSsMFGGn41OIFZuXC8yovlXZNOglEIZ0d6J6y65rJ0NI48CQHa5dz42DKtoKyWqQooTUUYfDtV8gR61o58FsMVKatNQan8U8z9lhCwoLn1d96Gq4oQoVClPIxHil050OZmIYdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075190; c=relaxed/simple;
	bh=hXq4B3gR9UQgo4NiVvq848ukxqpFYwJPkpAsVGk+Gco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UsDwyoXu8PU+CK/B8jsbx0ZQJaC91cow1tusm8KRX1PJ0pQGi2DynD+3xOk89P8LSfzlrPkKD4LztXXmP4e3fXHUHD9YM/nathXPM0dbZQXPOaKQW2CyjE4/hM5BX8HTW/kNsNErD4ij+ZBCfVpumGhARBcHrxNp6NL1H6gilbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzRz1DSj; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0wVwv/X8GpIoCBvvV/mjvZEZaV1Fdacq7XM73hHnXVa9XfalxgxV4zwHBooe0zEb4bypcOoayjgF2kZ0W5xOG4dUBSMnBq+21t6r6FfqmNHW9kyYltDOsZ5CgInmnZF3a+Z/DapgkZiEW/Nhr73IzG7TB/X5qXaPBWjzqWl+urxmxKaxZ8vEPc+AzmlUK4fvNGEoEdAQ8GOJRVRpdODiiVuaqkri2gc1gt6xGaah/M6bZsLklcgZzOgZpC9iAJ/fMPrT5QYeJcTs7BDCt6wCMlzcqewdA9Mi58sUn202uBPdIheX6VmvzAhicGqExJ+o3cQ9AIRJXaI9l9HJsjJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCXqsi9Y77b9azBq7EEv3MOFkKZx+H9ffdl+x9Eg39c=;
 b=Vve3H+E8Ov4RXDbHfDS8kr7MFr6KD5CKcXLHmCDuEw9g0RTlE36l4XguXL2liB2MkpSsvT5QzWS/WdyXL3H2fqOLL8XODBCZvocqKOR/g+HmyXzcKesL+1MvffnGoZah84bOS8zvLz8F+/DFSQUAqy01/QAswX2IMTvZsooj1DAGhytTVIR0PGFB7b33c1b1egyO13bogdIoaZtwDrBe92p4+i1volXskkApjpSDFOVVvqxRC9He49u/kQUYb3CQRp40vATJDCW41NCWnPQ1I4j8B+yggcm9JYjZIxjaFAkf0z7wZtF8Sz/M+ZB6coL576BR2q7fuag5tVYRhAv36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCXqsi9Y77b9azBq7EEv3MOFkKZx+H9ffdl+x9Eg39c=;
 b=pzRz1DSjk4Q69sBHpvBwqpI2zrWsPzHUGebDVAerkQHZ5yhlOfBLWaE4kdni4yaXR1scUW1pl6XyeAhjySuUWnxxIWqLIp46RtIdAxgafmhavUF2VxOP2Koa7mOhymOXgRqK/f+O+L1xpXIqndvVuqSFCcoqRfEJJtMbLvR4k2EmGJEIs4EWTix/V+5vSQ5VjxTb96ckDuVz9a8hmm39V/ZR+Jb70oWtZq00kxQz1vs6XSHlQmh2bwRXK3pdI3pw+86WNFU7tZYH1PoqyfUFfq9ZEmESDtd5I9SYum0YYM886SEKz0v21oFIPbddFhzDvp/xQ1eMxq/epKdQx5mAIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:59:45 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:59:45 +0000
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
Subject: [PATCH v2 14/14] mm/memremap: Remove unused devmap_managed_key
Date: Mon, 16 Jun 2025 21:58:16 +1000
Message-ID: <51ccdbbc3d7b76a7f6e2aefb543eba52d653a230.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0010.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::20) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ff5685-7cb5-4b73-f268-08ddaccd493a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qiRilpxgOHCvm0KB/odeqcYLqq71qd/uF2tuPVQSuLGZ0SAAgPIkENUZOxTk?=
 =?us-ascii?Q?QpgjOqkqInLtEEa3H38876PC7wY+Hw/q8cRKVqGQUnCsM+C22u7OfDAR+ZiZ?=
 =?us-ascii?Q?pIy8JN7WvapkTZJ/iUjyLLHzILykVMbC9dYehMUIzRAinQA37/qMzmhZ7XTs?=
 =?us-ascii?Q?GVyhYxpRIeKZ7vSldINPs9Vjb4DlMZFYfoT3R7ntdRssVb2PjLgYUIw+Iqnn?=
 =?us-ascii?Q?ns+c9fEQd8zVkM0e7tVIKL5VNTBIUp4lCeBDG+MI009/cTrzR3yt285YbEDT?=
 =?us-ascii?Q?vXUng48qPmNsR2r/Ppl3BXbsLiVpO84LEIwbr0/6b/5QIOYDCxaKg7JcPngi?=
 =?us-ascii?Q?TIS26/e7qXbFBAfzA4bV/ROqyiF2+BCh2ppRUGZYO0HKQ7TM/OpCmrwDIaoA?=
 =?us-ascii?Q?s0oC2eoL8/m14+NBxFsdbSXLnbCtu7Zp1Gwm+sJ8mDhawrk6buiVZKHorlkP?=
 =?us-ascii?Q?GSGrgwQzsAoYDy/0efFzcQX8VgxUhSlYbutRqEaDgcHK0PLPHKLZ5yyehRcw?=
 =?us-ascii?Q?+WCqnq8GBLVyJNmcKGsOmukXpmmL5IXHdpEqJ/sxNNlW9qybZ/pEHA12y/Da?=
 =?us-ascii?Q?AXDppPwTjhfy33Cww702bWNdrJGGGTd4FoJIoxh64NAkVA2tr/W/IWjdS3tH?=
 =?us-ascii?Q?7Hgr8VB0tpsBdBu7X1+Fjt/lDrJzFbUb7PdLf7Mxhgz7b9iidhvurQiHzlG5?=
 =?us-ascii?Q?Db2Wscc88WSkznlBxqi18wXTjMGpDXTYOsTFhu6V/9yAaoWwH5d2+ZOoNZkc?=
 =?us-ascii?Q?IHj/yrjR032tN/chSiduONuyFETLTd95R/TahR+VYCPLaJz04HwU2W+3X+nU?=
 =?us-ascii?Q?RWZO428nnM6MD+VCIOKlUphajxVZgAp1vun9sni8ne/T1Zr3FgueePy2hH7I?=
 =?us-ascii?Q?cKVsDVnn8+ZwgITZHZ0EztkJFSmr3lyH644X9QIDReSiW9CsNp+vcS1Bmcmi?=
 =?us-ascii?Q?2krkiZCHULJZzuZi49QBfd1nburfu/VRF8xXYxS+Tt2Tq5YYnAdcm2Ch5mCH?=
 =?us-ascii?Q?S6excMFeHdaCKzOahh59kpiBNAtQE58O3rRkxzz0ZT4yAPArGHrNJn3FucZX?=
 =?us-ascii?Q?Ji2Bt4ML+mmlWg5pHuRxsqhKqIjsX8x8mbsk6K43PEmADS9JnZ6qXlUATzlX?=
 =?us-ascii?Q?GpmJdhFXyWMMvioDJR4MVzorbD2FTpYXFNfYO7FssxyRv0fgdYSVb1sw3PB6?=
 =?us-ascii?Q?lXgd95oLYFAmepMdc82U6iBLrJhNXcbQtqHE1XOPeQj59XOYJIRt3RYMD1bS?=
 =?us-ascii?Q?jUkmfZi19E+1aomNnDqeA3iyKafgcq6z7aS3Y32pgQvJIpRPrEFFayPySV7+?=
 =?us-ascii?Q?tPZWkTeDRAPunGiavK756vc3lbUdq+Nty3nH9C0pYihNvrNIgDbznzXyGpN7?=
 =?us-ascii?Q?pwuAnP3BQdobrsB90sRkZ6W19Jl+VgCDFMbhGXqZa4PjwexcR+J7WFcDO0fw?=
 =?us-ascii?Q?NdKH3WGdpSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8dA0xVAoKNbJEUldONRjvNVpH2AXUswlI1HsZ0nt6QQDlu5POE4KBeID4Fq8?=
 =?us-ascii?Q?crTf9LwthtimtZuJKtJ6GvfZGyKxJNu7ZB1yEV8LMbU8rECgkj7be3MLvzoE?=
 =?us-ascii?Q?vgnv2JzOX3CRaU3ufCibYjN3Ga4seJWxsuNTWxnFLeACdEAaSsn0r6A2tYNn?=
 =?us-ascii?Q?pyBsyAvpqCwP5gB5YO9X2UUUrWUa1UQBYfQj1/yrsXV+WFwn4I65JGoTUYtF?=
 =?us-ascii?Q?Z3RS88Q4tJazotFoO9D7LfTZnoZKfCDPRDWrswnl0geALRTHeFeqe3xDv+ii?=
 =?us-ascii?Q?E0TQb4bbc8zYyCzi1EFf5iVtx0V7rvIuqdkkuuDKSo8qEAriq3aEnd+9OHuT?=
 =?us-ascii?Q?Mdg/BOykLJWANFbWEMB+wIZVcCdddm8Z6p7shSXZp9togJUkCnLsL+1o25JT?=
 =?us-ascii?Q?Hchuz8ZGWRVZulGVGbo6zbuSv39ZOyY0o5pqJehFsP0lg5B0i+TOKTnzp746?=
 =?us-ascii?Q?g0lHBCvf2cMDYWxlgLGsY8tJ1qljU++BCCcdVTN/eHt2JuNYBe7vYl5iEP7D?=
 =?us-ascii?Q?p7o6TG/ull/dsRP4UoZZ3JpFnFcqpSqGyuzaNGV8qDSpmXyHKJbBmedmks7r?=
 =?us-ascii?Q?8hxos+apV3faBKe+EPRztV8Da4YmGwWJd55PzSVlWO6uCglWhRkSnXzwE5Jf?=
 =?us-ascii?Q?4Dp5HR+6BKZZeyUeJ2yv+60OTHTKTsMRdJVAB/eej315f9g6Gqf7yrsx+b4S?=
 =?us-ascii?Q?tumVeJmf/I8NG29OWH/PBgZVf9DrCD25MpPlyk6iu8amYIqmy0ckd6kK0WKc?=
 =?us-ascii?Q?PTBj/wDXxn6WqFTqBhbuxg3XLVp3ELA7JLBKs1nm9n+ndRERi0VZYUNfU786?=
 =?us-ascii?Q?HgNSNRIfDhxKBFTQOlPOcFU8KGMnopWwEh9CIzdzTTm9fszw6KBF2F6/05ms?=
 =?us-ascii?Q?n1tvuOf4SaUDWjfMXhs8G2oOqOb1KdBkt9racwjuOTats0eZGcqBiGdMZvD0?=
 =?us-ascii?Q?1MhvGKFI1qjumwGcw3JZLdsb7cDxsmQCsg2o7UBhRVO52aOd0q0kp21UFsja?=
 =?us-ascii?Q?7V3QcuDQF5pVVFMgIv93vxcCjQs40ofqFWAcLmWs5LKvDtTZWphyWsHDEHUh?=
 =?us-ascii?Q?xOpl5vH8Eck+yVbRNPo0joKdJxOVn47W2S2t60PUsUDaSkJWj0ZMKQPlLo0n?=
 =?us-ascii?Q?j1cPYHUJKD3vjoLtQm6U3OiyX/d75JU2Jvf4+yS3R7wl7WwG3w7dN3E1mXaQ?=
 =?us-ascii?Q?ksP9hEUoV3YxkOHDXyKRAXEmh6UjQYV0TkyEip679Iw7mZzS98GkFlAC1nK9?=
 =?us-ascii?Q?8ODzNbttlm1I9EDbvR1WbI2YA387cOwaNEQvCziiXGnpL0EeNykg08a2TAov?=
 =?us-ascii?Q?TV3zCQ1LAMrrYSIIMrgpUGC+0KW4WoCmpTvXmraEzSy/L+HmNnJjnrb+hLSK?=
 =?us-ascii?Q?I8T4eexqOJkWTDJK6/sJEfQKOPQ/3mhrtdsLFnYkJ8/8zKQ5gQkrw4UMLctt?=
 =?us-ascii?Q?V2R+6YtCHwNl2MFUpkQoc9ZC/Vua5abuFO9gLhSxmPkXvW3fgt5h0CEWewSb?=
 =?us-ascii?Q?1k3FUUpQEF5V2xOBgXg9NMraTBXw4mRHudII/lpuT2wraRcaM9h9mvJWPbuI?=
 =?us-ascii?Q?ggvgQ51VgD5TtSMj9S9LEzDiLy+j2zArXQAqRXI6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ff5685-7cb5-4b73-f268-08ddaccd493a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:59:45.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRrqvzR6pizpDzAEKVt3gYb2rRugus0s/wZKT/Ekbej3fVKqrLMRPyQ09cKW5AXGYaDhi7njN9M32WA8ya/3CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

It's no longer used so remove it.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/memremap.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 044a455..f75078c 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -38,30 +38,6 @@ unsigned long memremap_compat_align(void)
 EXPORT_SYMBOL_GPL(memremap_compat_align);
 #endif
 
-#ifdef CONFIG_FS_DAX
-DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
-EXPORT_SYMBOL(devmap_managed_key);
-
-static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
-{
-	if (pgmap->type == MEMORY_DEVICE_FS_DAX)
-		static_branch_dec(&devmap_managed_key);
-}
-
-static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
-{
-	if (pgmap->type == MEMORY_DEVICE_FS_DAX)
-		static_branch_inc(&devmap_managed_key);
-}
-#else
-static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
-{
-}
-static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
-{
-}
-#endif /* CONFIG_FS_DAX */
-
 static void pgmap_array_delete(struct range *range)
 {
 	xa_store_range(&pgmap_array, PHYS_PFN(range->start), PHYS_PFN(range->end),
@@ -150,7 +126,6 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 	percpu_ref_exit(&pgmap->ref);
 
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
-	devmap_managed_enable_put(pgmap);
 }
 EXPORT_SYMBOL_GPL(memunmap_pages);
 
@@ -349,8 +324,6 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	if (error)
 		return ERR_PTR(error);
 
-	devmap_managed_enable_get(pgmap);
-
 	/*
 	 * Clear the pgmap nr_range as it will be incremented for each
 	 * successfully processed range. This communicates how many
-- 
git-series 0.9.1

