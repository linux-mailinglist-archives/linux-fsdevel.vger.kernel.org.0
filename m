Return-Path: <linux-fsdevel+bounces-16639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1C68A0518
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7811C21D22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C76BD2E5;
	Thu, 11 Apr 2024 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EIjRoOjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2110.outbound.protection.outlook.com [40.107.223.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7387F9463;
	Thu, 11 Apr 2024 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797106; cv=fail; b=tFPifeLqzS1UlXhAyZylOBGxnGDIwFsq43CeGC8VZmMT50R+kuCmQp2CLllbQs9KiFVcnSrRxjyftQMVbOkjEmqjt7fBAhF/6DqP02FGshdb9JP7qGguh/xMYrZRh0/QWoLACZ58l8jDU3oM7EcYXjWL0+02DxBZQvC48EBZddg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797106; c=relaxed/simple;
	bh=z9RRBl7hqDj9Pxm6ElbtOAnLtOODIy1UYSN99T3Nu30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=otMLVYSSxfyoqrBF5wu7F+WTNDPQF2abXvI/UjS/kzdDU5lp/s9DEwdtcG4JRtBm0ttrFo6KmxAblTifphk9uZ2Np0IIH14qSKtGA7FWS6T1Rk2l9gglgKmVDntOftVdfMKCtIsrt9edtjYHKfFGs5CAh1IyRQfjpNyBIFjvRJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EIjRoOjK; arc=fail smtp.client-ip=40.107.223.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0Dupi2Dx49htZsNTInh4wAr5DijEiFi8uSlTRO7NwypQAqZ9s47lo0ksXR+kRylOVtQlZErfkxuwOaz8OqsbZd2ImQXspvxHnjghW9HM55/4uFdQgJfv3b8CZuWGeodhVhbF3Vu0jzrBd9DgenzvwEPnKi5flB67hZnF30NLoVc5SBy1egbbnMU2T5ecg26WhUPZdT6NhKcToFR0Ht2ZlJLmSvUyd0D2XglVs9sBerMyPs67NhV/7LMAGAa1OblJom67BSnkns/sYDmNTO9a9oMBtfkDi+MVW+07hM9zYz7T3A0PwqERNIfbJB6zWLbWSq+wsbJR7susgqMDw8dEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlTxK9xVNfaIqbmp2oh/rMId/UA/P3vb9bDNNvz/ugQ=;
 b=FWFzZ5pXBcK1WGThYqNYc7HZggnUnZuhUbVuW8EEN+sXvDxlfSprlo97GiaF7orkSAGrfj/9XIaOwqkjwL4351y64aooASYGJ8BbnrsVRz4EKb/wj3hyE3tI00kCniJMLYIC2Z3bsEYeSzYw5YJvgP5vC3CZZDcS4BnNZFHd6laBu0vNZuZvR7HTQnWq9cGMk8cYaYciIjvpcDgVYOvHKrmfI1ZmuJn1fgdsqToH/IGgPWIS0tejbV9h1lq0IdzovrazwFCPQWOoMnAIK4xc0xKmxVzyW99obET9xjbj1vat2ydNSXVytfhQPhimwcTOWkGLYZq63fLGpoUdbXK2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlTxK9xVNfaIqbmp2oh/rMId/UA/P3vb9bDNNvz/ugQ=;
 b=EIjRoOjKwZcMrTAZzwOEtHqR18Is3ZEKGy5PlDUGIfQEomd01gsrrOVIDpYGJK96MsBx5uFjXT+CfMyZGs4jAbAt2coMQXyfY/Pi4AX8DH/euS6fk9RUnq3r/R6ilHKS2wbHy3tsUcTGEfBQx7cLuNJ+PHIeFIyPWMAzIcScA40yjuddnQjwe0WgQJJO+86eKXKDr4Byp4dC1pa/8toRoQ94yxlIe9aqrTD8sZ3FeFjbNlMhSexFZ8kOUMQw62P33+DfJDtwrxBb8vm4ZgoGcSdrQbu37dkTJOQH38PSr1qUU/fxloY9Rc3t735NLibCWPUcXOwjigLjfoPinorpNg==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 00:58:19 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:58:19 +0000
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
Subject: [RFC 08/10] fs/dax: Properly refcount fs dax pages
Date: Thu, 11 Apr 2024 10:57:29 +1000
Message-ID: <5cc5a152d2a03e2702be259c81af2bfe424303cd.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0036.ausprd01.prod.outlook.com (2603:10c6:1:1::24)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O3hh4rS1pV9+d2M217poI7czjUA8Oa/RKBjOwuIfNxf16Y6LgkGMuohYZrT8mB2PGCd44KjV1+RnakzqhjacMmX+FDwJh9GMZ0rjTqYVFcZ57pYicDIzk214kDb6RvErWiQayuewiacC11deBphI0haBWPOYWyEO8qX8o9OPFBWQyvobp2uhXwPB5S+wQbuJrdBYJGv1nfWykHIf01DArPaWBGpbaEZHpYRuZZcaoocCjIgvu96ViJmGWnuN3lRoQEqkf3Qh5LIs6R0YETTnazU24ZOEA22rMOQge3NBvdeDIR0XJM68MDCGK5kgUq59k+RxHP+8okYw64We2L0i6lA+45XuSqo8FNJ3nel+3dij08fNtQt32xWEk+aFhA91/t1oBAYakOdo5CizUZk5ht/Me5Im72N4L3HdGCiDr0UozcA9UhgzkdIisHRON98IInxy/fGhxSXgFeLu64l+h91eDOzgVgV67yK/Gd+i0GFuHTTJh+gLiNGXyjtyGKEYykvGOoqiVGmZilKWlpm0kH27TRNi39tRtQAcg165kROeHq8JVYPzktFe5up5asFXu6aOr8pXPsALpbqQe9HEnGZzUjtnrKjRTOnFKFokDaVAbpg+Vv7HieMHcVjHDX4GFC0VRSr4Bc0t3hrABHZRq7v2MNIy5CnZCdqaoYr63Eo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mne1lztuBpmLdofVPpevtgtEX327i8ibPHesiVN31Pr01tGQIHFyrkIV/pGb?=
 =?us-ascii?Q?EtHkyXL8B0JzdOBiqikc7a7/sPWuY2bufc/I9Z9L/P5nXq0x+PPVVQHOLCfM?=
 =?us-ascii?Q?bgQuqwyLbhg4WmBCqamO1HPt0tN1te0lhXp+KYgh2tJV0dhI/TQm9GRfA5sk?=
 =?us-ascii?Q?jiG5xmVEl5oqlC/qMDJK+Yu8gqDZw17ecz2Kae6C+5wOItkFxSAq2qu0r/w3?=
 =?us-ascii?Q?YgEiwmLF35D8RqCbNma4IDzvn8rRvFEPU3Q/356poNcqj7PvQhnCHciV2J9G?=
 =?us-ascii?Q?VZ+/l84U8zkHOoxtvYVSdqExhrlDzOhBIhXKS6Qn2pt3bMlitLfpvyBtPqhh?=
 =?us-ascii?Q?HwmOQCXSCm45l+feZ6a8mG8RrMt/L1x3os0inDJEZFoD0o+AOoOb5qBDeUlv?=
 =?us-ascii?Q?hEig40rlflqV2VbWfCuVEt5GR6zyefvH4pgPSIQJCbMUCCR+vWcZY9421jXP?=
 =?us-ascii?Q?j62RfJUEFXVhiZQIsUQ4yMxAHIUFBw7Wkqh0qH0s5dpdDZLfC8Af3CNekgkM?=
 =?us-ascii?Q?8l7WdrvmlvZ0+1crIHk5Yhbvw3yC3nheeV/J+2y3mSnZOevACN6RGdnorlBx?=
 =?us-ascii?Q?FV6YmTpkG8rx+TezWpObvdCF+fZ3mQhu4ktILCoOx7y3u3Il1cf6AaL7gEG2?=
 =?us-ascii?Q?knl2m7zjiz4Bk0LfQUnQoT2HcusKTg1hRGttZBbQ9Q72M+eWBb5WMTni+xZl?=
 =?us-ascii?Q?MBWOp6UHzE253jyevS8DUzPkfqkifI2RSnTYEWrIn7rQlBAMBIwHyGsOfIxN?=
 =?us-ascii?Q?2yhw8cOlEM0azEAEqQXcrm+UwrE14Pl5fkUDx/PX/0iV43VADKOrjLuS1G+f?=
 =?us-ascii?Q?IPygv0s5w0m844keF4rlZZrTm+K32ksc4izSdV+c35XNvHhoksU+otcZL+vQ?=
 =?us-ascii?Q?Yvz4lNZW93dWrGou94FL4m/ckoxPt5LtJK1eJjQnbgwd6Kxw1baTq43/128K?=
 =?us-ascii?Q?dc5iDsjskkDBpBdsFRHe04KJKdNu4/7vD5LwksNWc5rz9C88Wu6YAYRmHq48?=
 =?us-ascii?Q?4mVG1oqYr7YChru8CrY0CsYETe7MW78e/zVICGKjXkk764O3cnN2n9KqBSP6?=
 =?us-ascii?Q?3UcRNpoilirkUi07TQlDncaL7VYBt03BPdj3KYd2DFdywGtSPGBFIayrX50+?=
 =?us-ascii?Q?+qoR5wi4oXAtUE2vZ4+AOD4DX49PaZReha1dY/77+jfyPZEEGyHhDB9f+RNv?=
 =?us-ascii?Q?8vQkrLmtQ1H00rvBEO8v6Gg+vnCEblFTd9f++lEviwHvYSHAekcik0BzqIOF?=
 =?us-ascii?Q?5HN3YSHAUqUjRD7BeNXByNBVU36HBJvjJceIhhzr84B0XL3hmcYjW+0y9nSF?=
 =?us-ascii?Q?pAtv9YwghXgGu2xwhlmTrEghvWi+gPD3y8HKbiegjIxdD8+tn0XUfDPmihH5?=
 =?us-ascii?Q?PTfvWQ7hQj46T+T0P+0wNR8gX2XcACUYIJJHh/fwDCDccaD82AZGpdut9Cmg?=
 =?us-ascii?Q?MbJbSJJhOl6kWG9Z6sCjXlBgo9E/0oQUFcTXH6mec3+8Zp8sU1X21bXjqkPo?=
 =?us-ascii?Q?3Wp/2/v3M7TYWQtWGnNTYbjNqXAYLG00GAagrv+y6hZ7jjXkXMEB0bRkABzs?=
 =?us-ascii?Q?05KjaHbdR05xpuTywhQ/3f0ZVZ1y8yj6zKxZ475A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c657f8f-ec9a-4996-4c43-08dc59c27a7f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:58:19.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sgMILOVGMvjytP82o0Z7Dkl0LJOJNWWS0CtxCYdzK5lbMf7hM1kdC1xkqqMGj4jXApRXh5iRtOoVh6RVuLqcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

Currently fs dax pages are considered free when the refcount drops to
one and their refcounts are not increased when mapped via PTEs or
decreased when unmapped. This requires special logic in mm paths to
detect that these pages should not be properly refcounted, and to
detect when the refcount drops to one instead of zero.

On the other hand get_user_pages(), etc. will properly refcount fs dax
pages by taking a reference and dropping it when the page is
unpinned.

Tracking this special behaviour requires extra PTE bits
(eg. pte_devmap) and introduces rules that are potentially confusing
and specific to FS DAX pages. To fix this, and to possibly allow
removal of the special PTE bits in future, convert the fs dax page
refcounts to be zero based and instead take a reference on the page
each time it is mapped as is currently the case for normal pages.

This may also allow a future clean-up to remove the pgmap refcounting
that is currently done in mm/gup.c.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/dax/super.c     |  2 +-
 drivers/nvdimm/pmem.c   |  9 +---
 fs/dax.c                | 91 +++++++++++++++++++++++++++++++++---------
 fs/fuse/virtio_fs.c     |  3 +-
 include/linux/dax.h     |  6 ++-
 include/linux/huge_mm.h |  1 +-
 include/linux/mm.h      | 34 +---------------
 mm/gup.c                |  9 +---
 mm/huge_memory.c        | 80 +++++++++++++++++++++++++++++++++++--
 mm/internal.h           |  2 +-
 mm/memory-failure.c     |  6 +--
 mm/memory.c             | 82 ++++++++++++++++++++++++++++++++++----
 mm/memremap.c           | 24 +----------
 mm/mm_init.c            |  3 +-
 mm/swap.c               |  2 +-
 15 files changed, 251 insertions(+), 103 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0da9232..d393cd3 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -256,7 +256,7 @@ EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
 {
-	if (unlikely(!dax_write_cache_enabled(dax_dev)))
+	if (unlikely(dax_dev && !dax_write_cache_enabled(dax_dev)))
 		return;
 
 	arch_wb_cache_pmem(addr, size);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index b027e1f..c7cb6b4 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -505,7 +505,7 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = PFN_DEV;
+	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
@@ -514,7 +514,7 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
 		pmem->pfn_pad = resource_size(res) -
 			range_len(&pmem->pgmap.range);
-		pmem->pfn_flags |= PFN_MAP;
+		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 		bb_range = pmem->pgmap.range;
 		bb_range.start += pmem->data_offset;
 	} else if (pmem_should_map_pages(dev)) {
@@ -524,9 +524,10 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
-		pmem->pfn_flags |= PFN_MAP;
+		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 		bb_range = pmem->pgmap.range;
 	} else {
+		pmem->pfn_flags = PFN_DEV;
 		addr = devm_memremap(dev, pmem->phys_addr,
 				pmem->size, ARCH_MEMREMAP_PMEM);
 		bb_range.start =  res->start;
@@ -545,8 +546,6 @@ static int pmem_attach_disk(struct device *dev,
 	blk_queue_max_hw_sectors(q, UINT_MAX);
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, q);
-	if (pmem->pfn_flags & PFN_MAP)
-		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 
 	disk->fops		= &pmem_fops;
 	disk->private_data	= pmem;
diff --git a/fs/dax.c b/fs/dax.c
index 17b1c5f..a45793f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -71,6 +71,11 @@ static unsigned long dax_to_pfn(void *entry)
 	return xa_to_value(entry) >> DAX_SHIFT;
 }
 
+static struct folio *dax_to_folio(void *entry)
+{
+	return page_folio(pfn_to_page(dax_to_pfn(entry)));
+}
+
 static void *dax_make_entry(pfn_t pfn, unsigned long flags)
 {
 	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
@@ -318,7 +323,44 @@ static unsigned long dax_end_pfn(void *entry)
  */
 #define for_each_mapped_pfn(entry, pfn) \
 	for (pfn = dax_to_pfn(entry); \
-			pfn < dax_end_pfn(entry); pfn++)
+		pfn < dax_end_pfn(entry); pfn++)
+
+static void dax_device_folio_init(struct folio *folio, int order)
+{
+	int orig_order = folio_order(folio);
+	int i;
+
+	if (orig_order != order) {
+		for (i = 0; i < (1UL << orig_order); i++)
+			ClearPageHead(folio_page(folio, i));
+	}
+
+	if (order > 0) {
+		prep_compound_page(&folio->page, order);
+		if (order > 1) {
+			VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
+			INIT_LIST_HEAD(&folio->_deferred_list);
+		}
+	}
+}
+
+static void dax_associate_new_entry(void *entry, struct address_space *mapping, pgoff_t index)
+{
+	unsigned long order = dax_entry_order(entry);
+	struct folio *folio = dax_to_folio(entry);
+
+	if (!dax_entry_size(entry))
+		return;
+
+	// We don't hold a reference for the DAX pagecache entry for the page. But we
+	// need to initialise the folio so we can hand it out. Nothing else should have
+	// a reference if it's zeroed either.
+	WARN_ON_ONCE(folio_ref_count(folio));
+	WARN_ON_ONCE(folio->mapping);
+	dax_device_folio_init(folio, order);
+	folio->mapping = mapping;
+	folio->index = index;
+}
 
 static struct page *dax_busy_page(void *entry)
 {
@@ -327,7 +369,7 @@ static struct page *dax_busy_page(void *entry)
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (page_ref_count(page) > 1)
+		if (page_ref_count(page))
 			return page;
 	}
 	return NULL;
@@ -346,10 +388,10 @@ dax_entry_t dax_lock_page(struct page *page)
 	XA_STATE(xas, NULL, 0);
 	void *entry;
 
-	/* Ensure page->mapping isn't freed while we look at it */
+	/* Ensure page_folio(page)->mapping isn't freed while we look at it */
 	rcu_read_lock();
 	for (;;) {
-		struct address_space *mapping = READ_ONCE(page->mapping);
+		struct address_space *mapping = READ_ONCE(page_folio(page)->mapping);
 
 		entry = NULL;
 		if (!mapping || !dax_mapping(mapping))
@@ -368,7 +410,7 @@ dax_entry_t dax_lock_page(struct page *page)
 
 		xas.xa = &mapping->i_pages;
 		xas_lock_irq(&xas);
-		if (mapping != page->mapping) {
+		if (mapping != page_folio(page)->mapping) {
 			xas_unlock_irq(&xas);
 			continue;
 		}
@@ -390,7 +432,7 @@ dax_entry_t dax_lock_page(struct page *page)
 
 void dax_unlock_page(struct page *page, dax_entry_t cookie)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page_folio(page)->mapping;
 	XA_STATE(xas, &mapping->i_pages, page->index);
 
 	if (S_ISCHR(mapping->host->i_mode))
@@ -662,8 +704,8 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 }
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
-static int __dax_invalidate_entry(struct address_space *mapping,
-					  pgoff_t index, bool trunc)
+int __dax_invalidate_entry(struct address_space *mapping,
+				  pgoff_t index, bool trunc)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int ret = 0;
@@ -813,6 +855,11 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
+		if (!shared) {
+			dax_associate_new_entry(new_entry, mapping,
+				linear_page_index(vmf->vma, vmf->address));
+		}
+
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -1000,9 +1047,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 		goto out;
 	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
 		goto out;
-	/* For larger pages we need devmap */
-	if (length > 1 && !pfn_t_devmap(*pfnp))
-		goto out;
+
 	rc = 0;
 
 out_check_addr:
@@ -1109,7 +1154,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
+	ret = dax_insert_pfn(vmf->vma, vaddr, pfn, false);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1602,12 +1647,10 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 
 	/* insert PMD pfn */
 	if (pmd)
-		return vmf_insert_pfn_pmd(vmf, pfn, write);
+		return dax_insert_pfn_pmd(vmf, pfn, write);
 
 	/* insert PTE pfn */
-	if (write)
-		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return dax_insert_pfn(vmf->vma, vmf->address, pfn, write);
 }
 
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
@@ -1864,10 +1907,10 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
 	if (order == 0)
-		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
+		ret = dax_insert_pfn(vmf->vma, vmf->address, pfn, true);
 #ifdef CONFIG_FS_DAX_PMD
 	else if (order == PMD_ORDER)
-		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
+		ret = dax_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
 #endif
 	else
 		ret = VM_FAULT_FALLBACK;
@@ -1984,6 +2027,18 @@ EXPORT_SYMBOL_GPL(dax_remap_file_range_prep);
 
 void dax_page_free(struct page *page)
 {
+	/*
+	 * Set trunc to true because we want to remove the entry from the DAX
+	 * page-cache.
+	 */
+	__dax_invalidate_entry(page->mapping, page->index, true);
+
+	/*
+	 * Make sure we flush any cached data to the page now that it's free.
+	 */
+	if (PageDirty(page))
+		dax_flush(NULL, page_address(page), 1);
+
 	wake_up_var(page);
 }
 EXPORT_SYMBOL_GPL(dax_page_free);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 11bfc28..c196cae 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -761,8 +761,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
-					PFN_DEV | PFN_MAP);
+		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index c0c3206..74a40e5 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -217,9 +217,13 @@ static inline int dax_wait_page_idle(struct page *page,
 				void (cb)(struct inode *),
 				struct inode *inode)
 {
+	int i = 0;
 	int ret;
 
-	ret = ___wait_var_event(page, page_ref_count(page) == 1,
+	/*
+	 * Wait for the pgmap->ops->page_free callback.
+	 */
+	ret = ___wait_var_event(page, !page_ref_count(page) || i++,
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
 	return ret;
 }
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fa0350b..bf49efa 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1..f10aa62 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1040,6 +1040,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+extern void prep_compound_page(struct page *page, unsigned int order);
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1400,30 +1402,6 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
-DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-
-bool __put_devmap_managed_page_refs(struct page *page, int refs);
-static inline bool put_devmap_managed_page_refs(struct page *page, int refs)
-{
-	if (!static_branch_unlikely(&devmap_managed_key))
-		return false;
-	if (!is_zone_device_page(page))
-		return false;
-	return __put_devmap_managed_page_refs(page, refs);
-}
-#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-static inline bool put_devmap_managed_page_refs(struct page *page, int refs)
-{
-	return false;
-}
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-
-static inline bool put_devmap_managed_page(struct page *page)
-{
-	return put_devmap_managed_page_refs(page, 1);
-}
-
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
@@ -1535,12 +1513,6 @@ static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
-	/*
-	 * For some devmap managed pages we need to catch refcount transition
-	 * from 2 to 1:
-	 */
-	if (put_devmap_managed_page(&folio->page))
-		return;
 	folio_put(folio);
 }
 
@@ -3465,6 +3437,8 @@ int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
+vm_fault_t dax_insert_pfn(struct vm_area_struct *vma,
+		unsigned long addr, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/gup.c b/mm/gup.c
index a9c8a09..6a3141d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -89,8 +89,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	 * belongs to this folio.
 	 */
 	if (unlikely(page_folio(page) != folio)) {
-		if (!put_devmap_managed_page_refs(&folio->page, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		goto retry;
 	}
 
@@ -156,8 +155,7 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 	 */
 	if (unlikely((flags & FOLL_LONGTERM) &&
 		     !folio_is_longterm_pinnable(folio))) {
-		if (!put_devmap_managed_page_refs(&folio->page, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		return NULL;
 	}
 
@@ -198,8 +196,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
-	if (!put_devmap_managed_page_refs(&folio->page, refs))
-		folio_put_refs(folio, refs);
+	folio_put_refs(folio, refs);
 }
 
 /**
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 064fbd9..c657886 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -901,8 +901,6 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -923,6 +921,79 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
 
+static vm_fault_t insert_page_pmd(struct vm_area_struct *vma, unsigned long addr,
+		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t entry;
+	spinlock_t *ptl;
+	pgprot_t pgprot = vma->vm_page_prot;
+	pgtable_t pgtable = NULL;
+	struct page *page;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
+
+	track_pfn_insert(vma, &pgprot, pfn);
+
+	ptl = pmd_lock(mm, pmd);
+	if (!pmd_none(*pmd)) {
+		if (write) {
+			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
+				goto out_unlock;
+			}
+			entry = pmd_mkyoung(*pmd);
+			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
+				update_mmu_cache_pmd(vma, addr, pmd);
+		}
+
+		goto out_unlock;
+	}
+
+	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
+	if (pfn_t_devmap(pfn))
+		entry = pmd_mkdevmap(entry);
+	if (write) {
+		entry = pmd_mkyoung(pmd_mkdirty(entry));
+		entry = maybe_pmd_mkwrite(entry, vma);
+	}
+
+	if (pgtable) {
+		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		mm_inc_nr_ptes(mm);
+		pgtable = NULL;
+	}
+
+	page = pfn_t_to_page(pfn);
+	folio_get(page_folio(page));
+	folio_add_file_rmap_range(page_folio(page), page, 1, vma, true);
+	add_mm_counter(mm, mm_counter_file(page), HPAGE_PMD_NR);
+	set_pmd_at(mm, addr, pmd, entry);
+	update_mmu_cache_pmd(vma, addr, pmd);
+
+out_unlock:
+	spin_unlock(ptl);
+	if (pgtable)
+		pte_free(mm, pgtable);
+
+	return VM_FAULT_NOPAGE;
+}
+
+vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
+{
+	return insert_page_pmd(vmf->vma, vmf->address & PMD_MASK, vmf->pmd, pfn,
+			vmf->vma->vm_page_prot, write);
+}
+EXPORT_SYMBOL_GPL(dax_insert_pfn_pmd);
+
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 {
@@ -1677,7 +1748,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 						tlb->fullmm);
 	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2092,8 +2163,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
-		if (vma_is_special_huge(vma))
+		if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 			return;
+		}
 		if (unlikely(is_pmd_migration_entry(old_pmd))) {
 			swp_entry_t entry;
 
diff --git a/mm/internal.h b/mm/internal.h
index 30cf724..81597b6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -434,8 +434,6 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 	set_page_private(p, 0);
 }
 
-extern void prep_compound_page(struct page *page, unsigned int order);
-
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4d6e43c..de64958 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -394,18 +394,18 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	pud = pud_offset(p4d, address);
 	if (!pud_present(*pud))
 		return 0;
-	if (pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return PUD_SHIFT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return 0;
-	if (pmd_devmap(*pmd))
+	if (pmd_trans_huge(*pmd))
 		return PMD_SHIFT;
 	pte = pte_offset_map(pmd, address);
 	if (!pte)
 		return 0;
 	ptent = ptep_get(pte);
-	if (pte_present(ptent) && pte_devmap(ptent))
+	if (pte_present(ptent))
 		ret = PAGE_SHIFT;
 	pte_unmap(pte);
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index 52248d4..418b630 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1834,15 +1834,44 @@ static int validate_page_before_insert(struct page *page)
 }
 
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
-			unsigned long addr, struct page *page, pgprot_t prot)
+			unsigned long addr, struct page *page, pgprot_t prot, bool mkwrite)
 {
-	if (!pte_none(ptep_get(pte)))
+	pte_t entry = ptep_get(pte);
+
+	if (!pte_none(entry)) {
+		if (mkwrite) {
+			/*
+			 * For read faults on private mappings the PFN passed
+			 * in may not match the PFN we have mapped if the
+			 * mapped PFN is a writeable COW page.  In the mkwrite
+			 * case we are creating a writable PTE for a shared
+			 * mapping and we expect the PFNs to match. If they
+			 * don't match, we are likely racing with block
+			 * allocation and mapping invalidation so just skip the
+			 * update.
+			 */
+			if (pte_pfn(entry) != page_to_pfn(page)) {
+				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
+				return -EFAULT;
+			}
+			entry = maybe_mkwrite(entry, vma);
+			entry = pte_mkyoung(entry);
+			if (ptep_set_access_flags(vma, addr, pte, entry, 1))
+				update_mmu_cache(vma, addr, pte);
+			return 0;
+		}
 		return -EBUSY;
+	}
+
 	/* Ok, finally just insert the thing.. */
 	get_page(page);
+	if (mkwrite)
+		entry = maybe_mkwrite(mk_pte(page, prot), vma);
+	else
+		entry = mk_pte(page, prot);
 	inc_mm_counter(vma->vm_mm, mm_counter_file(page));
 	page_add_file_rmap(page, vma, false);
-	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
+	set_pte_at(vma->vm_mm, addr, pte, entry);
 	return 0;
 }
 
@@ -1854,7 +1883,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
  * pages reserved for the old functions anyway.
  */
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
-			struct page *page, pgprot_t prot)
+			struct page *page, pgprot_t prot, bool mkwrite)
 {
 	int retval;
 	pte_t *pte;
@@ -1867,7 +1896,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
-	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot, mkwrite);
 	pte_unmap_unlock(pte, ptl);
 out:
 	return retval;
@@ -1883,7 +1912,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 	err = validate_page_before_insert(page);
 	if (err)
 		return err;
-	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	return insert_page_into_pte_locked(vma, pte, addr, page, prot, false);
 }
 
 /* insert_pages() amortizes the cost of spinlock operations
@@ -2020,7 +2049,7 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
-	return insert_page(vma, addr, page, vma->vm_page_prot);
+	return insert_page(vma, addr, page, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vm_insert_page);
 
@@ -2294,7 +2323,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * result in pfn_t_has_page() == false.
 		 */
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
-		err = insert_page(vma, addr, page, pgprot);
+		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
@@ -2307,6 +2336,43 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
+vm_fault_t dax_insert_pfn(struct vm_area_struct *vma,
+		unsigned long addr, pfn_t pfn_t, bool write)
+{
+	pgprot_t pgprot = vma->vm_page_prot;
+	unsigned long pfn = pfn_t_to_pfn(pfn_t);
+	struct page *page = pfn_to_page(pfn);
+	int err;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	track_pfn_insert(vma, &pgprot, pfn_t);
+
+	if (!pfn_modify_allowed(pfn, pgprot))
+		return VM_FAULT_SIGBUS;
+
+	/*
+	 * We refcount the page normally so make sure pfn_valid is true.
+	 */
+	if (!pfn_t_valid(pfn_t))
+		return VM_FAULT_SIGBUS;
+
+	WARN_ON_ONCE(pfn_t_devmap(pfn_t));
+
+	if (WARN_ON(is_zero_pfn(pfn) && write))
+		return VM_FAULT_SIGBUS;
+
+	err = insert_page(vma, addr, page, pgprot, write);
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (err < 0 && err != -EBUSY)
+		return VM_FAULT_SIGBUS;
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(dax_insert_pfn);
+
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
 {
diff --git a/mm/memremap.c b/mm/memremap.c
index 619b059..3aab098 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -505,18 +505,20 @@ void free_zone_device_page(struct page *page)
 	 * handled differently or not done at all, so there is no need
 	 * to clear page->mapping.
 	 */
-	page->mapping = NULL;
 	page_dev_pagemap(page)->ops->page_free(page);
 
 	if (page->pgmap->type == MEMORY_DEVICE_PRIVATE ||
 	    page->pgmap->type == MEMORY_DEVICE_COHERENT)
 		put_dev_pagemap(page->pgmap);
-	else if (page->pgmap->type != MEMORY_DEVICE_PCI_P2PDMA)
+	else if (page->pgmap->type != MEMORY_DEVICE_PCI_P2PDMA &&
+		 page->pgmap->type != MEMORY_DEVICE_FS_DAX)
 		/*
 		 * Reset the page count to 1 to prepare for handing out the page
 		 * again.
 		 */
 		set_page_count(page, 1);
+
+	page->mapping = NULL;
 }
 
 void zone_device_page_init(struct page *page)
@@ -530,21 +532,3 @@ void zone_device_page_init(struct page *page)
 	lock_page(page);
 }
 EXPORT_SYMBOL_GPL(zone_device_page_init);
-
-#ifdef CONFIG_FS_DAX
-bool __put_devmap_managed_page_refs(struct page *page, int refs)
-{
-	if (page->pgmap->type != MEMORY_DEVICE_FS_DAX)
-		return false;
-
-	/*
-	 * fsdax page refcounts are 1-based, rather than 0-based: if
-	 * refcount is 1, then the page is free and the refcount is
-	 * stable because nobody holds a reference on the page.
-	 */
-	if (page_ref_sub_return(page, refs) == 1)
-		wake_up_var(&page->_refcount);
-	return true;
-}
-EXPORT_SYMBOL(__put_devmap_managed_page_refs);
-#endif /* CONFIG_FS_DAX */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index da45abd..2a2864e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1008,7 +1008,8 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 */
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
 	    pgmap->type == MEMORY_DEVICE_COHERENT ||
-	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA)
+	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA ||
+	    pgmap->type == MEMORY_DEVICE_FS_DAX)
 		set_page_count(page, 0);
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index cd8f015..fe76552 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -990,8 +990,6 @@ void release_pages(release_pages_arg arg, int nr)
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			if (put_devmap_managed_page(&folio->page))
-				continue;
 			if (folio_put_testzero(folio))
 				free_zone_device_page(&folio->page);
 			continue;
-- 
git-series 0.9.1

