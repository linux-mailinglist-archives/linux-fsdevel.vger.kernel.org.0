Return-Path: <linux-fsdevel+bounces-44137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6081CA633E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 05:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361813B0267
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 04:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B988154C00;
	Sun, 16 Mar 2025 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TNsLOfxU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A11547C3;
	Sun, 16 Mar 2025 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742099419; cv=fail; b=XpzRs7F19cM7l+ECSxG2XNuEIdMEt0O9XWMRmatiFDfXTXQvMsJ5BJuMUqulJOY8Xl9ftZh0A3sSCoVsxiYGAUpUivxQEpXiE9lVlNF8ng68JHWoqEV7rQ8SZHH0vs+Zwgr1ITzw6O+Q9XZCcCgydNE/hdFHZMNOviamdLhx3BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742099419; c=relaxed/simple;
	bh=ocVke70DuBsTLKPkwiz4iWgqmyL7oTFjMylJsF5Xbqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8dCXLPcb/RKUV6iV1arH4Nz5K5zfuDXpDsFj/uDlwT1dgHtDbcSQcNfkmYTS18nAfVcC41L4ZUAEKU3bwMBEeupH75ZUeT4iIFv+/f6W2viOTx4AAP3yOsznx/AuVmJQbmUEaRVZ3Vp/SuyeAzupzzmvHFFUUpTLUMAsImUqJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TNsLOfxU; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBo3+onBNBTG7rUzIdMFMVJeG+YCP0Unb2jWesCz3mtsM0tQOOCBbPxgjB4oUWtr61V6kvm/FhodgIituP529P/egQY0i2qMFQe+ipckIX9RwBfGwPRQDTHnf1O1yMtwitp7rL/ZPTmpyvYSGtsmOGP8QxYu8HcyvkekcjQ39y2ldWY2kewrsuXpSrKd/3hUMAhl3Sqb1RkL9WuTwjzGrJ9nMDNtAy1lVcsXyqYFicHgHPGrcJeOdBJF+icA9BrHX8WRYGtxpmhFayTGQF5FTw2orB5Y2Pj1VxXgyLoSMEwrOV0wTC1CWIGxXISbhdHpeKHN8+hNPDbU5VWAMR6Keg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDkIWDdnH4drh8UepiLUBz1wE+6cm+QfrkBbplMcEWg=;
 b=llCqIVgUV0nxHObatFHgpP5xuCtOBkg8eokmeFDBHAihFO5ljXzCbVMCUP66svp/YWhlLhXQLTMOmQm6r7jb98hT6ViunTcYLVTbqGg5rHYJajeI7B9cLUmq3nJl4mW2bCGy3+x7tsVX6UKtnCA0mWR/7oTUZ1PsKCseugg+w8/Nh2EYEq9TCI99Me3rqYCAwvHtikkQGXgkmyRLXHIy80nKFmF78vOipZQaZLkYL9AhWb7zfx8mPmpHxVO/p+PTV0YLzPlY7mvBFVbIUG4uXJIyNI86075YkzKsaCLyme7wpSgwn+6TvVa9lSAAM3h5Kdtx10/f4lknKjJmGxWXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDkIWDdnH4drh8UepiLUBz1wE+6cm+QfrkBbplMcEWg=;
 b=TNsLOfxUD+BRzssiWquZn1tNs4AyhG+gTM3Ta0US+IQE4xarIn0rikji3rYjqOn8KEe/BFktL3tJS9UKwe1hZs+W2/lBgPHFZrssmAbDJii7Z1q2IBNYUKTmMPVP/NtGwPKG60w2NRFN5OsAw0eAicPrm1MEvWLF62lQbyGM8r15mrsL3jWeh/mFO43KvdzGtKysEFjEbkjFQ98SNV6G9paywNy2VcPD/iLZ1lhnug+6/6xBb8PuBwxVcPWrGLNSiUg4N9ppru7e/o/XkuB8QIUdTjBaekE+nbE9LeAMQCpNueMB+FwUvMPu2Z5GHwyhtF61sKLEWoFLq5r0ECWXng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 04:30:15 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8511.031; Sun, 16 Mar 2025
 04:30:15 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH RFC 6/6] nouveau: Add SVM support for migrating file-backed pages to the GPU
Date: Sun, 16 Mar 2025 15:29:29 +1100
Message-ID: <e935f82d29f8289862f611c15d28c4504aca2a82.1742099301.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0019.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 019146e4-27ea-4314-ed08-08dd6443401c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tHVe8scBJ6g3yb00fTlKRJjS3dQoydpfi1oIlyTwhGu3j+kqtHb9TGJU3w5W?=
 =?us-ascii?Q?AUmVm6/cXdojntrCpUa+onLAmUzBql7LW2EPnZYhdhGIBdcGvkzznJxGCAKc?=
 =?us-ascii?Q?Gc1iaCAcpmpbLmSyR0aZiMdnS4LBFa+4QQnEEaWTehuKkCR0CRVCHPCgI3qt?=
 =?us-ascii?Q?ij5REgGWID3ocH8VoZt2xn2+JBCKbC/uGDGeQvVs+u0Or/I3isRkfdeQonJm?=
 =?us-ascii?Q?Pf099/jxIIKLXvxamg70sC601iQBThJD2y/MkuWa8xr0ek1M63IXOdeg/fAa?=
 =?us-ascii?Q?egx1WpMo/vn+tOM1Phyng6m1aQ4VwDgBDihkmHr9za9j/AktzYYBza9hgbo1?=
 =?us-ascii?Q?ll1Xdrvu9li9p0ZJXLbz2wFezVuq23wo/84rKFLTuGAThgChcIFTWNYBbuKR?=
 =?us-ascii?Q?L2k38EKi55XhWcl0avxvFqeN3fcq1SzZkUXXCIBgJOSQg44fgC6+4N3zzH2D?=
 =?us-ascii?Q?tst3l3xmDomaQorNgtDOdsvqNJQtinxFgXpVcGrmulZhOxW7s6TXDKK5HO6i?=
 =?us-ascii?Q?LWhcaJSwU1tEGguqLk5yD3D/c3sjYkAuXujUwBAlqpsGu8YpiybrkhlzAJUs?=
 =?us-ascii?Q?lA00RH2xVxpHI5B3+HEZQhfHGBB260tiChX/8obAq+JJk+KG4i1nyN0kO9jP?=
 =?us-ascii?Q?VwCraKGzzUpHaReFzfMKD4oJdrvmwR3kbGwH8WseQKdfKY9CygkGD26/lIsE?=
 =?us-ascii?Q?Fnv1wXPrjV2yKklvmcpzq0ltNuBbQ7hbDTWCJ8OzRTjXojII3WXqkiAdIjaq?=
 =?us-ascii?Q?sRTA3Xjo8pCymxhL+jh5+6T5nItJNuFkKtR51ubtLvgvNJz1qVskHOnTUFKa?=
 =?us-ascii?Q?o2V5UUD8DqCkQwgMohaLvmvWOV+tw6jFM/WVg5LT0vIgHHZwnftZ1qjye0xN?=
 =?us-ascii?Q?D6GLiHZcOEONIahrNC9AUNYDiNvCK7sLf8AU/REo5Vqe24H90l8XkzDrp1bs?=
 =?us-ascii?Q?7+kPHnRHKs7n1LLk5FlOvHVUGtWJMABonnBibxCl7g31lI9z7CAZ1+8lm7M7?=
 =?us-ascii?Q?YwO77NFyPuk6O6IKX1x6ZUe985ku3c1jYk6ETlJPD3xx8Yx4cZymuvKECTh7?=
 =?us-ascii?Q?JtCS8VteWAblD5/Di2TNK+2NAoIzAKIvKc9g/3RrCX6kXRUaxEuDNxEMT/ZF?=
 =?us-ascii?Q?z0lezcyU/xPfGB0XpXOdVXHwmscD2yo5CWCIY/I/scPt7ZUxXElifLX9Eo27?=
 =?us-ascii?Q?gIlNmbr5EHM9+Rqvj/Qe9/rSTszjvS5vioBc4/tkQ1yJ/aqzNWtFCh97IoyN?=
 =?us-ascii?Q?c+i3VCuxju8wzSiX1GNc3p/+YNINOfzYIUhhHimEcaSzT4+aju2M14fA/Kv0?=
 =?us-ascii?Q?ERLfHXJP2wNMVL+GrtlUP4dt2mwRoEKHjcIhqVNlE3iuVeVrxfl9juB2Teyl?=
 =?us-ascii?Q?Hh5dvgtPB8N9A6BCEJ+Wjnv0l8WU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tzpDAJjaOHymwU3HJJr1dyCJd72SFoGiyGDbuNJfWgfnCZbGDLFa4ch6Kckm?=
 =?us-ascii?Q?7NqPdQNbe/vjHoGEEsr2W9oaf0W+SS1JAHcZjiQOx4bTA0xxOSgVFRdZFlSV?=
 =?us-ascii?Q?8NM3rJedIzu9eygJ596L6VS4DS7n0mjYVLefWvTy5XnBNfhdUkLXWhYcvfVh?=
 =?us-ascii?Q?+sEwJTOZgI9JW9V+M3UNMWPQqKCxlOEqVcSTXo9KoEPEzeqBXbaWmxNMcXOR?=
 =?us-ascii?Q?BBxSV2AySPgw0erenRi7CiOHaslYOQhD+zBtLSY+/I0x+kT/W8DTKqYzdlgZ?=
 =?us-ascii?Q?6wN1I2r5F+kRGFCrXQvwLBi3r0+KKyGfcMtPx0Oz4nxRn2dEVcsWwp+8nx+k?=
 =?us-ascii?Q?rb4c7TLtds9yAlPUx7DWp7nm17MnlUZW76L5cZUEu0LWMBLg1rfWtOSuVvO1?=
 =?us-ascii?Q?qULQWMDqT6Y9qQcMzHJoRTvgnWkf3yRXr7LOUCzGPjd+bA2EoSQctvH8hD3O?=
 =?us-ascii?Q?9uhL4OwYlXs9VblmMvmymnJRRBXGnvgj6CWXySRq/7bPJ/+whMOEcNqpd5WD?=
 =?us-ascii?Q?BnOkg43AYF/V0GTcBcFSJ5ldUutlB+IB7gnCJDgoL/g8aYqg+JeWq0hQAROQ?=
 =?us-ascii?Q?y77G50OOx46moXRMKHokKIG5RlYmrKd4q3yq2SetzQo7zMeTdXVD0HTV7l7q?=
 =?us-ascii?Q?y+gYHPP2Rfw/2qvoOg03d2l967zRgdCMahNb1lZDokht2KniHW20Mryhl5a8?=
 =?us-ascii?Q?VN8Xp0jP+dYvQu+/m5l/8qow4b69s4ypM4ACwrHHh9CZ5upIVFTiLlcSvLxs?=
 =?us-ascii?Q?Bfe1Uh+9lMW70sjrPt/MNbwRa8qIXl9e3H6NlF202d73dCOoEEmILpfpON8R?=
 =?us-ascii?Q?xIpYRYNMqhh3DG1OJ1uEgAUzUKWl90fVXZ9H/g+ZOsYqscetTMrCBlEjqUKO?=
 =?us-ascii?Q?aCoPbCcUuWS5sOFVAP7IssQQ9R5lUEornrk92CzEkEP4JnQl8ywu+sz5/Ij/?=
 =?us-ascii?Q?xZjXXDsI37bzvZqyoMCj/paBEq3DWZHf8c6vLPeRNjEEDybOAXpZo6xZbusX?=
 =?us-ascii?Q?a6GzgbR+bO9rsta4oVlBCX93wDCW3+8FdC4GZRDgUJoIR1rvcWsllzrac2r8?=
 =?us-ascii?Q?YNiVt+pdJhsZbDLkd1HRJIoNuTKFKdgDWiByYaB2jtUb8bIqunYhYwB0KMBc?=
 =?us-ascii?Q?HyAOoX5czS+UJRrGclyueK43aP8F32NNAhgf4XM0YyV0OTXiGGhDQ+YlWpoH?=
 =?us-ascii?Q?IcqrMBHlS6y1aiLCmXCm/MkVuxn1yuGGvpDWMMHjwd5Pe7VEozthRkuw8jsM?=
 =?us-ascii?Q?hb7+RoIf7QgI5wCbRU1YsRJgrU2pJeLMu0N8MNDKxYtJsl/dXIl/QPdw25ZV?=
 =?us-ascii?Q?1j92yzGwfoCCrTt6OsmhcU7Opdxh+VfcZqZJAtlyuoSywTfFkhtxC/IWrggp?=
 =?us-ascii?Q?um4haNpq/6bIcenGSRgN7p3cVOcjM2FidITD9GTExRQfShfc1dPeiUk7muqw?=
 =?us-ascii?Q?2OAC1VqTizYZ0dBJQdwdy+qgypxFCajeEsjtiFQ573UbRBXskJhqn2NLJ74s?=
 =?us-ascii?Q?fPz6fRLEyXBH8qZ1ntDFl0TTE6DZCrnVW52tVId2/49rtFbPpUO2Qqe0ufjk?=
 =?us-ascii?Q?pOXtE2uzrpVNTUnZkO0HuklWXs4G6fhm5lfR2aPx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019146e4-27ea-4314-ed08-08dd6443401c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 04:30:15.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qtnb9QJ3zI2b0wBJzD0/uvfokdoYLRUSlerU2hIkRMY3jtK8kRD43TjbsabEcIhVv8Md5w1idXIjRyVWn0c26g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

Currently SVM for Nouveau only allows private anonymous memory to be
migrated to the GPU. Add support for migrating file-backed pages by
implementing the new migrate_to_pagecache() callback to copy pages back
as required.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 1a07256..f9a5103 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -218,9 +218,33 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 	return ret;
 }
 
+static int nouveau_dmem_migrate_to_pagecache(struct page *page,
+						struct page *newpage)
+{
+	struct nouveau_drm *drm = page_to_drm(page);
+	struct nouveau_dmem *dmem = drm->dmem;
+	dma_addr_t dma_addr = 0;
+	struct nouveau_svmm *svmm;
+	struct nouveau_fence *fence;
+
+	set_page_dirty(newpage);
+	svmm = page->zone_device_data;
+	mutex_lock(&svmm->mutex);
+
+	/* TODO: Error handling */
+	WARN_ON_ONCE(nouveau_dmem_copy_one(drm, page, newpage, &dma_addr));
+	mutex_unlock(&svmm->mutex);
+	nouveau_fence_new(&fence, dmem->migrate.chan);
+	nouveau_dmem_fence_done(&fence);
+	dma_unmap_page(drm->dev->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+
+	return 0;
+}
+
 static const struct dev_pagemap_ops nouveau_dmem_pagemap_ops = {
 	.page_free		= nouveau_dmem_page_free,
 	.migrate_to_ram		= nouveau_dmem_migrate_to_ram,
+	.migrate_to_pagecache   = nouveau_dmem_migrate_to_pagecache,
 };
 
 static int
-- 
git-series 0.9.1

