Return-Path: <linux-fsdevel+bounces-42812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998BEA48F76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0BD3B3128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7211A8F7F;
	Fri, 28 Feb 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="In5t2oNe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9946917BA3;
	Fri, 28 Feb 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713531; cv=fail; b=M53BeTT60qbmouLXz8PDunHmHAXUBsojaKkMHgIg7nQqQ28mcCXhnJxvk3TX3Qig/LtIDBan8ezfWDwBVnzxX57A/sTp5Yo23CDz7H02TtwCnlWftShhDNDdYJkvTCuwM/3ghpNIk1GkqdREcsqhYyUQYfUB9BoXBf0VfPaaw38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713531; c=relaxed/simple;
	bh=I0AoIxhlrcaUZTLmjoLeTb64wEnRYASL1wjToALUP1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gr4AQgXPTaV2TY7QN75AlpIBhIpSkIJo1Rfp8LnExeQ14d6iCUU3z6ddP/szhrMnrQj9cqCwhARn0PcsjAxQWbM90tMjJ0fc7C+jcmlcOsv/llpnNQgLwqT68OVxLEJLz6Y8V6URBMh2dB8Rst5l5RDj08gGayDVkp4zbMLQr0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=In5t2oNe; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPutJRstmMMc6MHC/zyKbMkMxA30mKD5jh2WkVMpRiZNekUaJB/q7fYpLfYe+sgRvJV2xNgyUtpEwPZHbiRMIeFjNusrkx7n4KyN0D8vRSjufEMI2MkVGSL7b102Nqd0i6nZyv/ZRt2mY2qFBoNPgaqMnOUOTkUKccg7awirfAypLnstdQwv0CsIPHmNfMuN/H3ZKd2dqSD0vtynXHXXHEMopykHy4osprNU+MyXnnKYuEhkn5TPhmGkNhxqKtxoim8PYrG28T+g6/kL5CYjR6uyDusXAoWKsI59agGHWdDy/NyFK62aETztNIDxUUQ1zVYnHDZS9Ob6UhvrJRFvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92BKGlNCPFH50JMw+ilesSOP0I/ZNI3TrI6Rb+xr1ag=;
 b=ngFrwpPYWm1/XFZqX1l0SaU0tEspMVUDmJshEm+I4wR5ufF9BGzpaf2J0ER0zDqhs8Naawr6i2/1xj/xieUEcHYXEbnhxxTs1Ijf+i6nIpdo9Zs4Hfz+f0mdtugdQi5rrWOWBTgWPsc9du1u1iSaXWJxVKoVHgi7/AjNoSuf3f2HCten7T7q7b6TU95HSmBG4uIbXdRWDgoYFFfn1BJsvsZpEcxfLfpBq3s5tDBHaap7CW5vPXHy9yYxVmH8Lde7MvoZ969+5JpuzFunTv8+dQG19Pn0HhdiWQ92dkmnFcQp8b80gRxtaNqDP+aqgwNbQ0cgCTcSf/rm8UWmFHMmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92BKGlNCPFH50JMw+ilesSOP0I/ZNI3TrI6Rb+xr1ag=;
 b=In5t2oNeMARo4jtdGrHkvFeVbkuVu/0f8b74Gy+xyxu4hlqoJInKkJ/cZZXlxbmVhGToJ4+n39tUQWPi+1YEwiNOITIPNlv02/vCZBvBJEdlKQPgk58gRxCe8EoQEHCRBwDz22438zTyvwWkAiLkrRWUyf/GBB6unh4TL74InnAh6wyAlvZpH/sGNlVWY8PPA2sUQ5JaE2jL9fdOsqUOpKQp6ookxNFAMN9RYj6MdyQbb+XuWbd9muymOGHSb05LP1H507zlZ2IdwGWAnFhtLJ0Obq4mj11Of5iwPC6pGKcYH9sb1wfN8PSUgnImcS0wRLhIKS3a3zQ8zQHt1uqVIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:06 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:05 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v9 09/20] mm/gup: Remove redundant check for PCI P2PDMA page
Date: Fri, 28 Feb 2025 14:31:04 +1100
Message-ID: <260e3dcfaf05ff1c734a49698ed4332b5dae04c2.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8PR01CA0006.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::31) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd65de4-2769-4efc-53c3-08dd57a8790c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xcAI7Ka5WZsjZFFokCtuwJGj6QifVFtsT5uQnCRu3kpK6f2s1j0PIvVZu7z+?=
 =?us-ascii?Q?gQa3l6TV6FxZ26AuJFdn9zsCgRUh+3d7Q1kfNInFSlLte/ROTkb7Z2weIuYJ?=
 =?us-ascii?Q?/qEZtE9RTWcwdH6lu8wGzcm7yhP7gERNHkD3KnlXqJJEk5JykL0SXtcKMSBb?=
 =?us-ascii?Q?o8MHCPonbP6b4E4Nb2vHeLzbC0v/xVipn3k/tZTMqhdzQytp7Jwfwkxbeaok?=
 =?us-ascii?Q?dV27iemSIUwgYccn6uJrlVo7CExJqdQoMv34g11Yujjnx8sp2LD0sdefhq1t?=
 =?us-ascii?Q?A4LNqPyIK/RgDnIDieds/YYdgDEUUFtgIO1vGJC4HiqiXkskp7s1C1SMqrR/?=
 =?us-ascii?Q?3RwmjQhw3et8GJNoKKHZ8gayoMrFELMp9MBViw6IfeiYQoB5uPDcxsMm52An?=
 =?us-ascii?Q?JF0lAjZLpVvv8pLExgObQGlHKpQdAMzGVDaHS89hf1MGnMZVuCm4mjcZRKkx?=
 =?us-ascii?Q?4jUwI9NnWSTLd3Zt+CFHi2rfOnBfwUlrEPpmfpUk0ca3arOMydaIqheDcHNp?=
 =?us-ascii?Q?JLE9djTo7YZ4Bk6RqNlVjc+eozf/+1RkVh65JBzinqTx+1rSVzvNqFmw2+4o?=
 =?us-ascii?Q?yqVcP0F6o9nLyI0zEh7FkKzydQB/To1gYEiYzWo172hisucly8oG8f1MTFqV?=
 =?us-ascii?Q?3Z1iAEun09CwPZ4EL5KMUX5TRhn5Kb09kvfigT9PANqrvWAg7/y5/3PFYwpu?=
 =?us-ascii?Q?8pg+PhdMM/0h4Zy+qY6ZVOJi5tOJrcJY7r4plfbpWJC2Ruo7N01MTe1131hU?=
 =?us-ascii?Q?9tWo1jqwJWnV768XRVH4/dudtsHbL9w7+e5qGWGss1Cz9gzL3EmNK4+SzuUX?=
 =?us-ascii?Q?jUj/flrw+kmAaVY2cs4j0wKm54U7CxhZybTEvdAHC16aCLNNCDHmBmj4GfZk?=
 =?us-ascii?Q?92I8gEP8lmdN8CozcAs96oatlksoATxRr0oWdpQ0k0BL8COQVldExS7sItN1?=
 =?us-ascii?Q?eiPzG4LNnWEbjpzrzDqwgH9iK4ed35YjQP9ZAFVuAtXAN3Za2Vp8bxj3vOy8?=
 =?us-ascii?Q?r6mG608zmSt8XEQ296mGcs/V5zttb303psuR8LcWFQ1F6s41j6TRbbSKIkg1?=
 =?us-ascii?Q?NmA4PlLidgrac2QerUXeMgIA7nyggvzueJn0B3iZOwRseZUZhBsB4EEIFsnK?=
 =?us-ascii?Q?wNC/rgbjZ0G+rfLvGW+flMthT9tzjFCV4FzzQTT+M7dNltC1NS41T5jjsXc+?=
 =?us-ascii?Q?FzNmrabNRZ8W3z36bVx04uIjUxRN+iDB3ydPP+pOuw//aD9TfcZbYWe68z3J?=
 =?us-ascii?Q?l1lRXBE2h+g/NzcHD2BD807jB5sNySwHQPkl6vqQ4S0LL5Kk3ThofxYtSE+8?=
 =?us-ascii?Q?doXBZzOcslwbpuRpsV+stRXSlsvTJeeSno121sKB9NVIcXBGURfVpXipIiyH?=
 =?us-ascii?Q?P/CRwyXXqy5zyckTfVkz9jX/Ynx1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZNSYYM0VgFoTINIbMPdQK3yFiXkRQZ6DjgYShPyr846+Dz5pzCyYWJISak9M?=
 =?us-ascii?Q?vAAKSvdL9mLk2Xp8VryLNZoo+ReIlcExATNn25ak9Cv318EJ87LOAJ7Mb6UJ?=
 =?us-ascii?Q?T27B+g1m9sjW3vHfMWzr68Inu6sOEeaNbY3Iu0D2yLwjmS49fmtgYkLx0q3y?=
 =?us-ascii?Q?7jfF7s0BlNrNRR0b4J7NyUHv9sLmiegP+VF2juUwIdXbZL8+4+SxNfelYkzw?=
 =?us-ascii?Q?gnnPyrq041O460bJgsGyRFqdXLpyLxhb4f4+DroVmaAE+jb8qFB6kGrHYIfD?=
 =?us-ascii?Q?jzz2efmYSO385wwiBGxgSda6cxiQ0q2Q/i41hXG1gKS5EAzdwSnv8wsAHgga?=
 =?us-ascii?Q?D5Xrm32A4sJkucLk0tjB9bdUYi9sGWxjsi8ZnXKtDEE10jZV04r3BEVch8Il?=
 =?us-ascii?Q?JRf7tT8MSnD670y3oJCkkx8bHOVQPunscbdVqPPrRsuo6dxnspgazc11BHyX?=
 =?us-ascii?Q?xypvkfhhjKDwgNLQMgdgRcY2w2kJv8KyYgBmGJGZSYgqKxb4Znhv74XC8vQp?=
 =?us-ascii?Q?s+lJweu57IHrbT2FlxqPwp4HE4DO+MikkD3FFXM5JS9R1/nXgcclkEj6cxZH?=
 =?us-ascii?Q?lhWZVNPDR0oh/3P6MQdRDSsVL2N9kolctfgSinU8Ox9JXfqWl0znE2XaRZfy?=
 =?us-ascii?Q?Kytz7A78EHbPbc4l+LCJhXRV0GD94DPwpXKCgDXyIko+DTFmzvNly2rlLBzy?=
 =?us-ascii?Q?wrh7MyW+YQ1WRAXKW1yB1YnXKo6rtlsgFj1SU4/d58KV4dPoLszdhKzQix7C?=
 =?us-ascii?Q?CjGX+/DT7xDcOT7F3RTpTpimlBGGaDEsFn896sb/pxYskK8Wvy7Hl+GxrKh/?=
 =?us-ascii?Q?paFkqBoIwYF/nXd0385tM227RypSmReiIfAAu/xyYSON2ZGfVIO4a6AVEUCz?=
 =?us-ascii?Q?8HQJdruO7FUT8LM2Jmg/GcvdfcM76qyNIH1l0pefh0YZ4AamhnVNxxijKw98?=
 =?us-ascii?Q?FBWYINQob7NuTRQ2ffAMCL2yr/ksJmiF891Dm8DZrnVCjKCFN2VfxHbY/ION?=
 =?us-ascii?Q?SoVENybr4YKqMOLcUqCF6tcvthLgibc81drWrEUWGasU92HLHw+LF4kHUWGa?=
 =?us-ascii?Q?PVsXz9tOzXsICZ2gFDbLHWCSRPC76itmLtR3DjaZu5uCZ/PsAD1aO3SbjlxE?=
 =?us-ascii?Q?Rq11BMKX8gDx54jMj7NJEeraybfadXYf5Ugmf8YsSXcrsLp42/smDbYN0Y14?=
 =?us-ascii?Q?uyyp6Fyoif6+77Y8iiwlrIvwa4auFcVLn+LxBB9TmZ8fTlK5fL4yC54XMz6y?=
 =?us-ascii?Q?n9BNdxciJsntgOBmVEbqk9kCCoxvO4YVT4p41tx+NTFmgPQOQiJAp/5InQ22?=
 =?us-ascii?Q?vg05nRuh1sQ9HU22yGpGJahEFhvYjhuP4myzJglef4wlyDNa46XlSmB/uDu/?=
 =?us-ascii?Q?mcTfqSsc0ao9qQRdj0nHxulXnw1hITP0GaLJ/sF6jAN1AvLaf9pcWKHRFZQn?=
 =?us-ascii?Q?A2OCDOfFTatS+RPpuPxdBzURiFfL7WKzn6AR8fwXR4omNbUG3QRKqBahXmju?=
 =?us-ascii?Q?VoxxTWRYbiY4gBLB1+AXqfG93/xdS89K8vqSgjOfKZQVSc0FMcByaOm8H2K4?=
 =?us-ascii?Q?5PJ+ApbjpZM95Tbuc7B9mUPxHUl3XaG3rRLwozPa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd65de4-2769-4efc-53c3-08dd57a8790c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:05.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9BB0W9PBNUCspUjlmeVV5947m1zx+SORTEwDRvF8qKXsvSuoZCF6zIC24gVidxIuzKvJ1l7SbULmV/v4fIKkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
check in __gup_device_huge() is redundant. Remove it

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Wiliams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e42e4fd..e5d6454 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3013,11 +3013,6 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
 			break;
 		}
 
-		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
 		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio) {
 			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-- 
git-series 0.9.1

