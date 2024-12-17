Return-Path: <linux-fsdevel+bounces-37594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C325E9F4282
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AD116D8F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AE11F1308;
	Tue, 17 Dec 2024 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uleKcHIq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBE1F03E2;
	Tue, 17 Dec 2024 05:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412525; cv=fail; b=DoAj2/Aa+HORLmdEnMIGhj64fmJBFJHSaAx/yw0BI5HxlOdbKau6k8tI7ybeQVADIEBfM4c58cTJVeLsyjcCOf3uf6TEJnL4HUIRYNq3mEaZQP+qpWlBrMRC1e1rdMBh6WbJgZTlcKRjvUlQ3ZdZ2IlOM+W3wigj3MsRHY/GVMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412525; c=relaxed/simple;
	bh=J+pJzyMz0yQbjHMCb1QPm+3tB47RXXRXVdgxFlViQ3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SgVfk42TBNMpmMILc5ryaol/BGePmLDs0zW6jMXnxH7dspoqTfvZySYDzNZCKNAuwpNsoLXw+T0gMIewnmqXYRs8piBQLoHMCIrT3PohGR5XfunpgdkplR/Z5wdGWoQDZdcJ93hhViQsbfBcVbhtJtjuFTlDz62sAjJBCpxNu70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uleKcHIq; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCUtPt+MBg3b9H5fYqyN0kNOt+4PJ7Qr/q7MAtFWZWdAyId/Qzb9gBvYeF/w2EpfbxNnoc8HJahROFzEZZhGRaw/Qxpx+clnhEuXsFp161MyYddeYOc2POWfUxYHj3LlvvJbuozi/R+5pl/N5mvzfR+7RkEJKpZYffYEkVys2SXNsC0oCEIlaHtScQ+fa19bh7yiDG7UyR68ys0RPC1Qc4mti/je1vsHwPTkWW5oebMmaq5qLlIJcfr8XSJVLWPzpbho5zmueBAVn79//LRJCBA97pRCEr1ice5oew1No2173/FBuMeDGrEY5X6TbUAR7LV0O6/S7TTgZ0c2CkUOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqqmhV31DBHyMlPhdEDkr3XHarfIiD+eK0wQw4RnbHU=;
 b=ZRy+J1MTp3Teg3lt/3j4ncIpdwIogdqWohRd/0//LqRBcp/eqo3SbYOndzOHmJkO46LaEiyl2cxhKEJyBd6VKgPSgg1uzHDw+sls0gOxidRSkJd+CDr2QH4sa0DUL3GYRhDai03fyVP6Kn4D6lYwRI+AY5Fmw3cO91TmrbNhfcFYBK8/b55j7ktjuNRqeidv9oJyVkByV526zqkIHC+i50KOqkH3rMzQpn9+wtCCvL9byxfTqf/96Ou7aB2hitLPjhkD+tnaklsBPfoGdnnIQgMgFLMhyFT3wJ8iv7HsBN7/Fa8vhcynPW9d20ZH4p7g4cN1kBXdLExT051DRAOIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqqmhV31DBHyMlPhdEDkr3XHarfIiD+eK0wQw4RnbHU=;
 b=uleKcHIqvyHH0z/sxqcHMsOabWIM3e3Uxu4g2YcjPniuMBeeTcRl4ZxpG8ywwXZr4K9o4CHJhZQNQivLpZ0PImQMZx888NVv7CWrFdqudK8qcIbZUaumUpHSM5boZwxlUSL76PfAv8JDTJbFaYmqwduFAeqebB2OodCqxuDgczjhSeVkTzBkeK6UjKHjTRmTG4p0E0nM4a7LgfPZD11lrPkyo8vY2hu/2x9OOoHyxG2i6OxYS8tBdoOl2v/A64ZRREsYX8y7rE+/6IEOy7yBlva/Cu32LphEU+ZBWXT2oht8R4G3aC4ZH35jIZpLZHh0OeVxRF3g+S20XsLyhui1mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Tue, 17 Dec 2024 05:15:21 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:15:21 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	david@fromorbit.com
Subject: [PATCH v4 20/25] mm/mlock: Skip ZONE_DEVICE PMDs during mlock
Date: Tue, 17 Dec 2024 16:13:03 +1100
Message-ID: <e1fe10474fc06aaf24b17fcd916efffcc8c13f78.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0015.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::25) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ffab83-0f29-4ba4-5116-08dd1e59cdc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7HgEDAOC99NQuV/ovjBRbH5pFoleFeQonUkoGmY2N/4PjApSdSmKKOsUIDia?=
 =?us-ascii?Q?GmA/Jh4fv84mICdWLns8rYN1qSUp7UiAHKTRs6safZdd1pd6PArU3o4iNG5/?=
 =?us-ascii?Q?pxGgzTqYVyAnAF+t/XG1rdJ8aJwp3bPVbZz76Z22oRJaBNQ0QTqatLKks5N2?=
 =?us-ascii?Q?divnyReCWpUdo2/x02l7USyHcR1qPTbskILP0lukLFXUyFJnPyoOPh170dMD?=
 =?us-ascii?Q?HkLe5sZEFZjOxt3i1rSvQMC0p3L3TI3K30mrTEp9Ekv6W/LF+VgSus8+0qMu?=
 =?us-ascii?Q?HN8ZoUeGNENC6zV+rwan47HRgWzpIS/0qGVOF/4E1gRN2/gkdYnTXSEKG96W?=
 =?us-ascii?Q?y9gh6eL96AANtDSSvdTd5Sd7xlKdaaBTKiBlvAdzIl1osNwUItwIFgClB22B?=
 =?us-ascii?Q?0+Ol81cOEatzwPQ/tjsFnu3k7dGtng/ZNd0WqrCghkJ+mqWKnOpad57m6td2?=
 =?us-ascii?Q?yhVv9s7zkNlCCZUGY5RgXvXFr3XzmTaRaWvo55mRtlEMqOlC0Wl8ozjY3/RM?=
 =?us-ascii?Q?YEc8xOfH3eEkNF4XC6VA9G4oizDr660DTvMlb4CEoj+la8ZEa9tJJbfupVhA?=
 =?us-ascii?Q?hTk9sIcZ1D15wk+Rzner4jvTf/Yb6Q+1JmGReIzx6N9Q74+86Ej94snpazGl?=
 =?us-ascii?Q?kLfcaXYtMqjL9zl2LxgsIhbtd5W12Cf015nJ9SJ5DmgqENJVR2J0G4d5lqlK?=
 =?us-ascii?Q?lxFPb8o29kD3QmJ/zm03VQJMusmWKYhjvJ0hIwsugsr5thSmyoj0WcXsCuAr?=
 =?us-ascii?Q?oj1X2pA+ogb8lYby/di9nPVwqDzcdx3pDVWZiUggIu4NVeB4K8JhsfwHF01Q?=
 =?us-ascii?Q?B18ZAIfSxVizmsM/07UFKccpzLa7AsX+qiq73jzGp+T423DBRC5Zj0hQcn+h?=
 =?us-ascii?Q?JuXze7Do+V861TBeVg2jTYnvBLa7Mk5D5nG1z0lHgse7XPbXzleP6RgPF6zq?=
 =?us-ascii?Q?FRvIF9OCMThq3MnCkQYb4v9tmM+scYY1QH6SXmPdSdrjFoeAnzTr8VQT88p7?=
 =?us-ascii?Q?NzMnPIoFinQy3Q0g2OnfiOQXYWVUWF/XpwuzWJMObZcw8bKWRx/Uufy299F6?=
 =?us-ascii?Q?J5KT40p+AHRXtpjNSMxgA0TC2Gs3fRGkMeAK/youC9Mhmhuhn+EFmBG90cYI?=
 =?us-ascii?Q?s8x8oYw5B75xicmJpGoNkY83UsJKwI7IZC7pKDIMxWy22W4jZBft44kShs0f?=
 =?us-ascii?Q?fw2VV1rjuoPT80ygOYuoZg0i6KH5P6kS4wXDscodJhuqP2NugKuILE6MGK7e?=
 =?us-ascii?Q?eBquG25fEPk+s9cmDYOOXY9M+r65Q6OqWBpDXwR/xOevVxicmcSjc3E8yOVd?=
 =?us-ascii?Q?09vVRAeWdMfBILmMvpk9ep2r49maQ5D6zSPV7EbFrMs+2cpLG6JmYrckbWFL?=
 =?us-ascii?Q?hTGMS/4d6jhqqQVadrX3iWJsVay2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/r8Lpt3wmfKBo8Wd8mU0bkCob4mw9RLe6rX30uXr6kFHb/X6Sy97Vg3S2Ns?=
 =?us-ascii?Q?hB8g+WopFrAIt3WvMArw4n92F4F0/v6UW+DELcngIIPE07XCGvofyn5C0Jq1?=
 =?us-ascii?Q?OZUwqR+lBT/7La23dr1XoLUXRaRqkrojmGEy/YCh9mbnaitcycLnBp+tSlGl?=
 =?us-ascii?Q?6T3+1E3dN+3lbLE2JlS3My4gm03eOcRqaPZ9mmZd923z1bxvAmT/86ayepqW?=
 =?us-ascii?Q?udo4W5qg5L/FvXJzTdICTdAoV+cRk8bmpQ18YexSUUcxxcQVN5WgJ19ZJ+34?=
 =?us-ascii?Q?xaMK3iGXtvSDyTuofWdgfUyxmuaq+pgp7ixowgN/9j+x9Wjje79/k3i8iGTu?=
 =?us-ascii?Q?BxfS8AF9/RrIYdcUyP9t10J+vK4OGRVjtTYr74M294fBnxFaRKxq0qYNdnEt?=
 =?us-ascii?Q?8ermEFSenpXvIZRsqZ1VF/0No+26amvtgPi2H6K1j8BQOs90DtwqKZQRoCjZ?=
 =?us-ascii?Q?TGzuqwTlErkI7rxD8e4Vs0Vv6sVwp88anAJiJ4FGV3N3Gf39MSxsj+O3dBET?=
 =?us-ascii?Q?xHNG4akclOb09EwyJJFEsyR2atQA5TjvRFfARp5CYVlESKUrsa+sPj7e2OV6?=
 =?us-ascii?Q?yO+eTSbUAmjFuACKi/XDLAD3uvZQSesNZrJvvRch62H/rr0c5JD7A5v7aWvw?=
 =?us-ascii?Q?aGNKIVkVBcRj5TYycXwFX1sCzworOQwS66NwBEIxGXZi7aSuGsPr9PVO64kC?=
 =?us-ascii?Q?M45G1377DWB7JP3aSGTPJZ76Ua2BraQ50yoJpBawmEDNtkS3FRmcRyzTQgnx?=
 =?us-ascii?Q?OjR7jMcSmjmznZtf7HrGexGk4Ydd6zSuimaSWacaGBKcF1X5JmH+4kpU+tgj?=
 =?us-ascii?Q?3DUKcPo2GjxDVTsVIEO8O2IgATs3qIgn6Xf1sYhVLBNODZsJoQZo9lo3stXR?=
 =?us-ascii?Q?CspY05gfiNcC3QSTZGgY7cB/E8TgmAtRbfiBGtyIpLPg9RimaluQ3/rtwhrx?=
 =?us-ascii?Q?q7F85s3hVGqxV61kWV2/LuQnltCSd3Vlj/IG9/67ARKZHIsihq9dkw5XNd9q?=
 =?us-ascii?Q?RwcmgQ9pA+KlvyuK6deL8ZshH8UqivJ+6OWbINro5IRSdcG+Nnj0s+OcJZNi?=
 =?us-ascii?Q?BY235OMGtHI6fhvr+RG70o7vK6f33hvrLyber4aguPDX8PwS9jsMYUvrgu+j?=
 =?us-ascii?Q?AG0wBdckZ9kQK1w1qlb8ri9vOJ8/e7ujfnRJgCTd6O+hhjJf8jucMnZwDRA6?=
 =?us-ascii?Q?HcttMQ9vkbhQkHotyiKqvYcCb+WuJ8Fv6XmxjEidS8bXtNC939VxDJtj8T6s?=
 =?us-ascii?Q?xxn2/MFpYNE/O11HaU130xREOZW4bgM0zhzARWRetIIIGu4lWpH2HBCN6GQ7?=
 =?us-ascii?Q?nS8e+dSTolcGBc2c+viiULjq0Pxj9rPzIBHhjb38+N08KRBquuJYsu5ZqYcF?=
 =?us-ascii?Q?aZ+grtV/ptNJUBvpTZf21TYXvhKmV9qDOoIFMUtuFl64P3CIhKY6CoVaLnM4?=
 =?us-ascii?Q?NIOUH9E3TzIF5QSJq3O/aow2FwFZpqXeIz6QBjpafzx5SrhtDYgqcrasV+3z?=
 =?us-ascii?Q?BHxz7qnxQLkJ8p0ELdNfFOzBM1ycdh76oz8yo70Jr2xhHXlac4M54rgMutN1?=
 =?us-ascii?Q?Tye/f/LmpI178yIwR2NEZI7QXGrJlMDCZsyF/OJH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ffab83-0f29-4ba4-5116-08dd1e59cdc7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:15:21.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUE5dzK/ieW5Z0sMJKQ4dFadyPVQMFQ7/w4gfzLfjxej3C+xUKede0XbqYdgS5mMhh8WqMMIT0Zhzr8KLNrl2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

At present mlock skips ptes mapping ZONE_DEVICE pages. A future change
to remove pmd_devmap will allow pmd_trans_huge_lock() to return
ZONE_DEVICE folios so make sure we continue to skip those.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/mlock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index cde076f..3cb72b5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -368,6 +368,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
 		folio = pmd_folio(*pmd);
+		if (folio_is_zone_device(folio))
+			goto out;
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
 		else
-- 
git-series 0.9.1

