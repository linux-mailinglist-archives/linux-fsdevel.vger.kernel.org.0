Return-Path: <linux-fsdevel+bounces-16637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7734C8A0511
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDCE285C97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE0DDA9;
	Thu, 11 Apr 2024 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="szgG42R/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED6D518;
	Thu, 11 Apr 2024 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797093; cv=fail; b=kmhe6de5wWcmG1x4DMxthzqaGlzPFBdlhtfe+2tCN5dwElEHoci3mDoCEpr3T9LGMmvVnvKF+ZEE6xPFfjIlAmSBSgzj1jSk/AD9N4qd6IvpdXPU80VDOExTlQtrnumZLeX/ifSl228bBPSqQgh192pGKh+vGZioo2qhPCoJess=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797093; c=relaxed/simple;
	bh=iDC+XE27WGdKGNBTcifQ/8l3wBTYxkmPBaUhftnB5/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sSKW2ankAeexCnGQSTVCSVsHBLWe+GwB5wneXfaJSs63eecH6l572ui1854+c6LCMnJNIvnL6EG/gChGpfAHD5e8n3rdkKvLywsDjlXC8foHlTLXpHEnTRC5yjAtCP+8e4vHY8xr1wQMBaSV4xtt1pKr7tIS6d4fqMPLm95Hphc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=szgG42R/; arc=fail smtp.client-ip=40.107.223.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5DYjnX0apxHf35/VxJoFF7rkXAeqre03t7VuUoTi3NtzYO2owJqwnUuuYORDzr8Qv86TyJbnrqharMZwLqmK+kiGaKAJHh1bLKQbF4Fn5YSO2mCTeTkd345r44QLhO5JwzVxuBVHRKR0Yjz7WDQprLVcELbM0FnQl/yhg0nGvOuXcbm2DFbGXUErKRKR2NX+u+tK1IiyRZHzDo44ZL6MizyHh9oFN04hDyBmLF2y0z/T47Rd+CtUYGBTn1Op9SZfLQIgSrJaX5Wr7MGxrkryHUElfwNW12dviF+OUiY3xEVLFjmKveb8h9HiNm//l4vLa9fTmz4sKhgS7uggwoHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWq7sIsAjoy6Q8qfUd969PXNtY0sRneqqLCOZHWtLns=;
 b=RLdtwsXyOFCH5T0yyXzuLDU0l+H/jt5pSrLvV+0+i5GLqq21YT0B5ZyYM6HgSZWBH/jsq0sf4dX8C20xMBFMwoUZX45Fu4yIgOzFF4QjqxkotnopibtkaVHQeQ+7YTCpG1Qr0+5pTvcAOGjykaDs7F5/Y/4wvMgSkDgSVmYv0WI2QC1pF81jn2E56kZtovsDCnmtHvS4qYHzciy2RqjfV7P3iDyJn+rTHhuYMVV44xR+zZrOEVno0pEQEvy3ZMeCsoxE7bGXrR+T5B4z650L5Wyf75f6R6SruopWZcmS/ckjGzH/A98y7+2IYILh6+qshKekB/8GlNfCaHuEulQWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWq7sIsAjoy6Q8qfUd969PXNtY0sRneqqLCOZHWtLns=;
 b=szgG42R/j9M9nCh4I9XtGL2akKPtJ0cS+BgO6qry24U79FDmfd4GjY67roQB8re1riD2b4etQCLOphG0EP0bmQtF1NmYbRJ/U0rSSDQZ7culKq26w9vp7EzBE0jlhDHQOfNqnhD8pnvLXfGo8qkT3C2+nxnTAkPRoBORwlEfMFYo5fZurCyECBoa3gVC5tybdjD9P8dMRLAq5jpPZgCuOmDr24imZoBFwTQ0gA4/lwAxw3S5OoTB2YIV6Qxnno8elfkNstR7wGgMgi2eTtDgqttgwCXaI83GZ2TAjxVG7NJl+PUnTFBQBgG3ed/j13ynLD+divxUe7oeT263OW0J1g==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 00:58:09 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:58:09 +0000
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
Subject: [RFC 06/10] fs/dax: Add dax_page_free callback
Date: Thu, 11 Apr 2024 10:57:27 +1000
Message-ID: <d3b9699a56edefe16b695ac09ed659c13391a0d5.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0120.ausprd01.prod.outlook.com
 (2603:10c6:10:1::36) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
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
	b5iZ/h/44MWpPBnZwfbSDpgSF88KmGFRGXL1kx6IDRAcfk7S2uR9dF6nyz7bgXS7yGFKhho1jdW6C92DmEjlsf3I5ATMxwHNZXSHwVU219G3gLw/nXNEpQqIu1e4Jr6KLH3/8Spvu5EoqSYpXbkYvLocpjRlNdmy8lQAGrwfIYLuofDZ+Z13Akzs6te+ha+hd3mFaPsEPikqQeWiMkfGRcE4ajnQQfbVCd50R/IMbuashKyECmTAbMKJCcpOxVMAxaNNlhQXLeEW3JTxzD5d309YkhFQwoo73c2y+7SwXk4ak6fgj5cVwJ3MX0bMAVGv1B24L4h2AlNG5E953B/LfFi3pJ7QL2w+mLmJDJG2vf5icI8H7FIz1ak/YiSci6hkujoCn+CkSH/LUdr9De22YnbkWxogu2wC/vlgaZxbmd7uv5HxI2Gi5cmvMI4VMqwV7unnD+EM/THjbGyLVcaBnLDpzeTzEmifkEyD4Z/n68m4UASifwc3g4bAwHIBCG4hsjdLrBRX0c5p5K6Mc+6spF+7qf8onVQIiqaqFI5TGgifvmNFmZcc7jz40RwjLcVxHDF3oI61o56oQYNy1XTD/BnmLBJ7UsNCBl9rqkmcEXxC9OlJ7oBwliqhxVGRKuq0tJsG7VLnuti1wyCDF3o8/HyTP1wDF8/ULT70ModbxAM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y1djZlK3WKvLZX62X1x7MeSTDIua8cX3Gkaz4MyEAIBoQRQC5ut3+Flxi4A7?=
 =?us-ascii?Q?TG6cq64Tqi7GME7hQZpJZxASnGVthA1EF4H+1aC1UH1I9zjEFHFna187jmFT?=
 =?us-ascii?Q?/PIGdxrG4SC2u5GrsTYKxD/YN+iUQWvn946cez+/zqUaTT2Vkd1DzDBy6UmV?=
 =?us-ascii?Q?m5noEsx0No56g3rLQhvE5u+7VKw/ylOzeRFvOspY1QT1zYEtw9s+drBHbcXa?=
 =?us-ascii?Q?BY1/4jCy6ftiVFYv7HPJ4jYx7nkBiBtqCUGyBEtP/0UKRyzjWUGslehg/tz6?=
 =?us-ascii?Q?X4WsL4qZjs1BC7/FmYXFH2n3ZxCFl0ZNJtJx+LMLP2VfB/hvX9jBXMNDJBBe?=
 =?us-ascii?Q?O4ykmOuE7+7k1n6+vJ2kU7wMmKTapHA26jDd6zyoUPrkMzWpz3C9oaum2mpe?=
 =?us-ascii?Q?d5AKN/hch4dUxuFmnBsRCbwZV5WrCHSxyfUThCVDdwRNXnN6JEqAP/dQMK+V?=
 =?us-ascii?Q?56up6DoJP26+HLvyJ0MGxTTugtzE/GZHOJtamDNRpwq3ss0aAm0nwjbMdm1J?=
 =?us-ascii?Q?8iGWEYG0sSOEaJ1puRCn3aZ/jpgKDc8EdecFl1X9PItnyb4M8hSlupm0/xbf?=
 =?us-ascii?Q?Pks4xR3Q2rco+Qy1UdLgGkuxCDhpkjB64U86Mor5awtwMrMxMSVA50Dw57vl?=
 =?us-ascii?Q?uvwsz4u/umWnQ6ueqFlxYDVWlJS0BA2YJsX8rRzdLSgvOhyYGnRNs+CUEgkB?=
 =?us-ascii?Q?Ox5FptmNFDxnlM2qsKI1Lecn3x8KD+hpks2V6nFTOC6AFlCrjztj1daNnCw4?=
 =?us-ascii?Q?NG9iG5ChblVgw+vROQLrWGIq/8ZnPU4rRU22cXk0nlvtqRU1q7lzegymCs17?=
 =?us-ascii?Q?/HB2TgNK8PddeXnRuvgrWbyuTBjn9Hq/TzlNGVrMv5jCiY3zpdOEvJ2DSQXl?=
 =?us-ascii?Q?IE9HR6BibR+GyuWivxbtjSSbPIvrmN/9NityEXWTCnKPmxmhdh91QUBx36WI?=
 =?us-ascii?Q?EZmyoZwBvJFAIa95au01j7kx2VrjItPLm+LQVDsBMECQWNdj0V9CYTDPyfoW?=
 =?us-ascii?Q?g0g5aPn8H5S+zI1Qeoa3KwfYY1Npn/4v4lJW3sBdbGv9Tuhr+Jb+nguCa1k/?=
 =?us-ascii?Q?FMst+izTJAsk5EocIhhZow7LGalCvN5kYnkV9aY6P8izvuXxHLbcxTR2aKWI?=
 =?us-ascii?Q?R1g8kg07W3IRX8zXLYWg8pJZbALiYc1LrKvNTfOlXF7TwZ9dM0q7pQDZH0tl?=
 =?us-ascii?Q?rPB7tuIALQ8FVg0wcjIfb9B3sLlh1+saKe/G46JdXcnEHqf28ooZILbdrGa4?=
 =?us-ascii?Q?C7Gy7Pq1+R36i73kK482ABaGcmv0a/GWU1ARfWMkSposx4VM+bDWvNARMuwa?=
 =?us-ascii?Q?lRvf4faNPvbiGMb9uQ+sOHk0s5TnzUY9YuktlZo0pFgM3+dB0BKsyGf52sz5?=
 =?us-ascii?Q?B8C0p31zdlwat2VR/3xlv3axSzRILSxDV6ECjjK8lRz/skeUsmltc7gLwDSC?=
 =?us-ascii?Q?wvtW7Ch/4qzoMKGF9ENFdKopg8+pblVYINvNqlB1BFBU7JojrJcbXP52OJLy?=
 =?us-ascii?Q?Pi/WhQMcNOoDcHEzlNN1ADYHDcq57hAL9WShmeg30oCOayQk/p+ch21EzmZ/?=
 =?us-ascii?Q?U2QNv0u4HNGr7KroJZca4lAJtRozL8p8I1Lqjy5c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc425fe-c4b7-4c63-3363-08dc59c27467
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:58:09.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wgsujitMp4RQ6awuizuDAa0W13m4lfGYlIt1Ni85t043cRoI2+lAUH1v8gQezl5iK7zfyPLtZr6J3ltwJJUDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

When a fs dax page is freed it has to notify filesystems that the page
has been unpinned/unmapped and is free. Currently this involves
special code in the page free paths to detect a transition of refcount
from 2 to 1 and to call some fs dax specific code.

A future change will require this to happen when the page refcount
drops to zero. In this case we can use the existing
pgmap->ops->page_free() callback so wire that up for all devices that
support FS DAX (nvdimm and virtio).

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/nvdimm/pmem.c | 1 +
 fs/dax.c              | 6 ++++++
 fs/fuse/virtio_fs.c   | 5 +++++
 include/linux/dax.h   | 1 +
 4 files changed, 13 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4e8fdcb..b027e1f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -444,6 +444,7 @@ static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
 
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 	.memory_failure		= pmem_pagemap_memory_failure,
+	.page_free      	= dax_page_free,
 };
 
 static int pmem_attach_disk(struct device *dev,
diff --git a/fs/dax.c b/fs/dax.c
index a7bd423..17b1c5f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1981,3 +1981,9 @@ int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 					       pos_out, len, remap_flags, ops);
 }
 EXPORT_SYMBOL_GPL(dax_remap_file_range_prep);
+
+void dax_page_free(struct page *page)
+{
+	wake_up_var(page);
+}
+EXPORT_SYMBOL_GPL(dax_page_free);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1d..11bfc28 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -795,6 +795,10 @@ static void virtio_fs_cleanup_dax(void *data)
 	put_dax(dax_dev);
 }
 
+static const struct dev_pagemap_ops fsdax_pagemap_ops = {
+	.page_free = dax_page_free,
+};
+
 static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 {
 	struct virtio_shm_region cache_reg;
@@ -827,6 +831,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 		return -ENOMEM;
 
 	pgmap->type = MEMORY_DEVICE_FS_DAX;
+	pgmap->ops = &fsdax_pagemap_ops;
 
 	/* Ideally we would directly use the PCI BAR resource but
 	 * devm_memremap_pages() wants its own copy in pgmap.  So
diff --git a/include/linux/dax.h b/include/linux/dax.h
index bced4d4..c0c3206 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -212,6 +212,7 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
+void dax_page_free(struct page *page);
 static inline int dax_wait_page_idle(struct page *page,
 				void (cb)(struct inode *),
 				struct inode *inode)
-- 
git-series 0.9.1

