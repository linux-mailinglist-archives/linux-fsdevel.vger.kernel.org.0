Return-Path: <linux-fsdevel+bounces-16640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE7F8A051C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A98D1F22D8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311DA12E6C;
	Thu, 11 Apr 2024 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JtdSSb8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2093.outbound.protection.outlook.com [40.107.94.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C729463;
	Thu, 11 Apr 2024 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797111; cv=fail; b=f16oTvmaA/F2XBxv28BlyKvwdoHOnlK9A0n0xD44ZjiGb8qU/e1d5l5sfqf4rhllUpaZgJpZ6OJWNgVeJ2mp3VWlyie+Q0flcAC66ItrY1gF/wo0mgqzwos2oFr271yuDzzduA1n154m2l8YcSf4cqwKQqXhLq1gDqwQWr02xK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797111; c=relaxed/simple;
	bh=vm5cTowGNk500VEneXXyM4cm2nBcdqEWWuwtetM8m8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WfUn50Wq7HK8nyGnr6mxed/DAAVpp+s0TgfZhraFrKthK3mANsl7VlUg1AgBOa+NLBkj1KR4YrYr68T29ch2r7Hap7VVAXgM4cFBIFnLJqqUKuKvi5+GlqgnH7Ag1LE6jA4XdR/1WALHNEEkAGEH9EKIkGYYSOJ43/SKwdSHxQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JtdSSb8N; arc=fail smtp.client-ip=40.107.94.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD3yfIjLf/60rzu2DMfzmmOk+9Je+GLid2cktBFXKhX79/W/mfzvwhKv3SFj4kSDXqyj7wJaP4s1iljoWt00ujqpQB0Df+81UsPvCB+1M4N+nczyaJAYHtaiEqxypY5nN+WrqgtVIKwFSdASxiafv9CVIM+V4We3zAtlMV5I2Kv0y5O57Hovbp8J5vrgHYsJzet3O3ZpboDJl/NTGrIBMneEbMxocO4rQl5WAc+Nf+wsTUJBTqBUB2XinFjgDlSploXNx/Iy7sMgqzhszaUoK81X2inV5ORl6N2pATjcmoZlLtCkPykSmv5vcZi2bFllNvrLTTy3w/d72milELsolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XTR2wGTQYyMdv9FC/UxmLCHq78nuoZnJtxOmETBa3s=;
 b=XGgVtU2oC5mNAkKLDEhoBGnKgrsHRtSrRdYEYPM+vEhZiwr39wJyj4uNpuflyCDpA8ZDEf+s/6g/USS9292s+8ZLuzd+q+SRw11EihopKX4THc6urvGo0zoHbMOVW75//ib/L0JPbPZmvAZ/vh41D7CHeuijxZ5FgxGYz4VmunNUF3It6CGOVA9YWG2leys12YBHmir4jiN8xZVppJpiqOTwbDH+rcllERRrkD6aXaJ1xVa4uQP9u8N/LxYR36Nl9Aa3vOH7LDSr01HgY8VIUlk5b7KqJ1FoLzftHGDqy2bIBwomS/d3Z/nVm1sLiEOB9jIP2vnFMJfvt/cqcIZZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XTR2wGTQYyMdv9FC/UxmLCHq78nuoZnJtxOmETBa3s=;
 b=JtdSSb8NTFOzi51/wzvF2ds75rNXj7APUajn47VmCTGfQADenk/Njks7HiWFcRxr/Q4oLq8lqTN2sLrcMZgwJyShnN++J+faZVYg+hq3TyTkzjW8Ake6f0JMYoCEe/IiajREMaZIXB7TRigVijxcCrPUOx8XOdJqtgnTAkQVWIxboUAUaFaaw6YDh7MAQCo4qgePxIScUSXcPMEDPTFtoO5MgiwwG0SEWRiVnT0bStSetaN42jLb3VY4Fcnj1HMnRHmvAhQ7CgyMPjkdf6f7bB+uPgvD1K96vAfJtMBOrQjADG8ULFo0syjnn5b94u65oY6bBLUAiKA2lV1tlwcVdw==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 11 Apr 2024 00:58:25 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:58:24 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: david@fromorbit.com,
	dan.j.williams@intel.com,
	jhubbard@nvidia.com,
	rcampbell@nvidia.com,
	willy@infradead.org,
	jgg@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	djwong@kernel.org,
	hch@lst.de,
	david@redhat.com,
	ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	jglisse@redhat.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [RFC 09/10] mm/khugepage.c: Warn if trying to scan devmap pmd
Date: Thu, 11 Apr 2024 10:57:30 +1000
Message-ID: <68427031c58645ba4b751022bf032ffd6b247427.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0056.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM4PR12MB6182:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cmonbTBRCOA51WctoFnOuzaMkdzgO5gz6oRLuQYHZ6s1IdGXDxZU9f7gTvrR56NLA6T+EhXzFeogs7rStRTl5U1rVkdM+gTDnQSa28j1l1KVtG2OQQHcHBmfA+27MQKh/JI1Gdty73M7us6KHpLEPJwJmfcX+XUydjCY4zQ1v3wBUXi5eAvU0Z5tS0qFRU69W+aEQNtJIlbppLl6O+kcf4aGld+jGy1or6yuV5XE8MKRvoO1IouGNF22041PIQzBDLlRglEMmP2IJptSIrKeQQEmCieI5C4SxLeqIQcy5JseMW7TM5Nx/1dCEbMsBkw7wcmxFxHorYp7SrHbriy8sQdo3HJwqWFiZa4dyfrnje3zPaKa9NibcGcDp7vZPYJSYzN/jTjC+azoJZle/MhFvstLViItL2TVt2m6Xrf1I+aDwOIdsvAOIibfqz8j3J1icjhrX+ylxGZrSKiSn4vkUnLM/0VwW82f+dsWShO7/k6FKhHs6BtYJuWMg1+8FRNBBnMSw/SRqLQyjIiEFJtMkikno8MVwIh8ZGNmLCTLCP368VaSGP10Yz2WQ4waLpXX2wCmCJpVVRZrdj+GnvFn8qLHiAOh+p6PXRIZFo+rCLqWF8O7E12BqAZ8UHQhnvAN/4zsRtkLNCrlDKK+3RxCoCoalaDXdKiVCby0K7KwDIQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?klDNgqQyG0ZaTIWUdE82QNzLPmytAQa7CiOzSKvNOjs8CrPu6YaYfGmJwD1A?=
 =?us-ascii?Q?u1T2HRy+/jFX94YrJj4DZ60OWtKSwWExUtqcTVbqo1Mlq4APj/dkH9N+rnM0?=
 =?us-ascii?Q?XQB8WY4kgGNKfkzo2DYJ4MbWKbrS9pgWrPDPU2pyP4JbZw6ZGq1IBgPSJWfn?=
 =?us-ascii?Q?pbiRlybFcKFHsZkjXZfsx33cy5HESfnXwiSMZSPPYpa9vIoHqLlEEA+QREAP?=
 =?us-ascii?Q?uprBAwh5c5fGYcspE8erPaMlw8gpBZXIM6ns3O6o8ssRekBI3i/8UJ7iPOEC?=
 =?us-ascii?Q?MyWd0OiH9irXDQYc2yqLptlo6hejoUfvP8N8a+fOVZHLM9YlejFEctvwkzI3?=
 =?us-ascii?Q?n63RsnjhAjyrxU7KnUrX9x4MMmCet1MSTr/9ylFDs025A30NZSyF1Z0roWO6?=
 =?us-ascii?Q?URqzOrL88X881WvQoIyhTbHT5HLNVKkfVUGcijm5ivdAc5nWZWUHGWyV4eu/?=
 =?us-ascii?Q?n0mcMuqtnF5BJ6bOphrFcqm6spIdys9GqHMkw7UYVhNjbp5/L6rSaFBjajKx?=
 =?us-ascii?Q?YvECR36V/DQdQnFnUJMlrZvHnxylNnEPTtJcDYgGU8bNuxGlYgV5YewS10UZ?=
 =?us-ascii?Q?1avK/44fXj8nQoLbbbE1YjR8lmVlLA3siOGbIHsMh9Tsmvio3udDoYY7/9WM?=
 =?us-ascii?Q?87LGwclJJbmXlGx1aW/kumJHAK+18h1BuAaI1BbE364kiZO/O4V8upQBUPw3?=
 =?us-ascii?Q?ulC0CkH+sU9Zvs+FFXUhFhmuq9r7Fzja3jutlPUPQ/+XJ4teCJp1qj9gz5M1?=
 =?us-ascii?Q?Zym1euxh/0UoDIaNyLZk7A/8TN/5VATNfg9CdReJ6MygpkRviKD/DCmEwE8f?=
 =?us-ascii?Q?kgOmTvwzXqVhAXaqkRg55a1iA4Ro5B9VzxODWhlaw6lrtb2H5I/bVtzDvMr1?=
 =?us-ascii?Q?VI0DlumQPnz4Q+JkaWVTqYTXMLmUmGxz0Jkisjln2tLzR6N1dcmUy/OFn4aB?=
 =?us-ascii?Q?VcuVBdWJ6GgVmbyCzcfvvRVKH0TmLpItVJ6//SjIrczOkD2WaKoWOCwtXT7c?=
 =?us-ascii?Q?ENfKzFUI9fAP81aXN3nWxhi/rMFbGArJWZ3/pnbCmWxQvNg/5z36M4BpoJ10?=
 =?us-ascii?Q?Wp8o3j/fHBkQIImAoj3fX+k858iw7QqHlnyirbDPKwf1uVAou/PsdkrvveX7?=
 =?us-ascii?Q?QEWn99NW6pVKm4ASkKPX2nsUUlit5GPt1HHPs2Dkr00C32OCpV62z0LLLEO+?=
 =?us-ascii?Q?q7PmIpn18qNidNNjFWfmwXNlvS3Mj5UzRI/mS9YGTmbLf48rhYlxbtjc0di2?=
 =?us-ascii?Q?cAkpQQzs9axmePofZvWKG0wpAAu74te4DAVnZ/JC/yCcguyxdU4dKZdC34eD?=
 =?us-ascii?Q?206KNhAV7jdFkN5+UxdGFPfMf5Qc2xLsfrOx3dkwhz+jBrGz8S/ketbZ6IKP?=
 =?us-ascii?Q?y0CenOw1Pkhe8x2BVg5sm04t8wgK87BOPrBTvuTw7HB58eIiK+791SHkBdP+?=
 =?us-ascii?Q?EFZEowejh/QIqvWDN///63xrXwGa5aYlZDCaai28rEIpHqErRA0eHlYU3JdM?=
 =?us-ascii?Q?QXpr9Ox3MDpj7YU0tmkl6/zbS6d0HF1XWC8gyfRUaHwKi1bk59OrHjzFxmFZ?=
 =?us-ascii?Q?raUy2rrPIGwgUPNmusITunzcrmmHO3wu5is8rbVY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b41f58-dfd9-48b3-f23a-08dc59c27d7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:58:24.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAk0jOaQCaxsAp4+UYf/BQSLAjAtGXPwKGKRe3qGu/c6cRZhg1HKFmfmfrnFZGVgiXQN6saoo2/HTAgLiku8uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

The only user of devmap PTEs is FS DAX, and khugepaged should not be
scanning these VMAs. This is checked by calling
hugepage_vma_check. Therefore khugepaged should never encounter a
devmap PTE. Warn if this occurs.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Note this is a transitory patch to test the above assumption both at
runtime and during review. I will likely remove it as the whole thing
gets deleted when pXX_devmap is removed.
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 88433cc..b10db15 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -955,7 +955,7 @@ static int find_pmd_or_thp_or_none(struct mm_struct *mm,
 		return SCAN_PMD_NULL;
 	if (pmd_trans_huge(pmde))
 		return SCAN_PMD_MAPPED;
-	if (pmd_devmap(pmde))
+	if (WARN_ON_ONCE(pmd_devmap(pmde)))
 		return SCAN_PMD_NULL;
 	if (pmd_bad(pmde))
 		return SCAN_PMD_NULL;
-- 
git-series 0.9.1

