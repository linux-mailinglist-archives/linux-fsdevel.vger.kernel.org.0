Return-Path: <linux-fsdevel+bounces-38525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC4DA03627
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86CB163F66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A231E3785;
	Tue,  7 Jan 2025 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="riZWvP+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE591E2850;
	Tue,  7 Jan 2025 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221419; cv=fail; b=QFz5GpDxOY5TuQHD36WgUyEawZeSyFahC0FfFs13AjFwjLm/PxcQzX6+iUc+TSgnRYyF1n7V3YyjQ0DgX+LJVJxEQnu7A3se8hBbUEiRCnOkNyesupSGXUIDyKN1gxKS5q/9FDNz+elRMzgLw4vEgdlAPjD8x6slFFRfEvCKnqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221419; c=relaxed/simple;
	bh=I8N8ykoX+IlHs1Dz/s3j0FUyPTi53pkKwSnEOijdpFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DLRS/snO3G1xqAjz7gW49cDkA7Rzvf/hunnGhQQZcQqEf3k3ejlxb1H3F9zzFCQ3e0Xrl4OX+gaC/tUTn8FJeL9AuWxw84IecsxcDGn14+OqBT/l/NVTSaamm+dyTrunWVWj09Lyd2rte/JXKfYtb/OQL2ewjSjvFzAs0kyId2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=riZWvP+E; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFVigdnyIX9L5fo+Hsq/QhQu4W7puYLOE+yiImA0k5JSSZj12awuoTzHLYdNKkcCyh1F8aPFRw+Snylyo8QGKCfcizCyC8kOH9mM2NQekKOjQpcZr7oap6W2P8114pNjmC5fGaQeMZNSWMAI2qtFI4e8cGjZBRLDEL/LS3Gc0zyArB8/btUBWKa2l/02sKVcKhz/sBitDC/ZvkDu4j4TxW+ca4zmYIh/lKmqDzMzt413mwHy3oZ+8trwxyvqjhqwOaKWO8XzuQKEpCwoJVuZ2mLOTOkBj+jDlGICnxCrUM9YVoPlX7+SSomndm2qppGOP1LxTzYhz+b40RQ+x7lfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA6IK/Y2KuCTn5DEQhgF4VkZcX2IeUmqIqn2SXK5C70=;
 b=rVlfBO63MstjnqUEhroa0DRHlGVsflOWMj6Yb5C4VDAuTSponLfIFTqjS2j0q0h1np4+e6pI0JP1MsX23JEfian4f17cxe5PDh1JGC7x83C3Qy6lfFnHJ2F4HBBjPLeddk8xlOq/eWbcnNWyI3a3fuNBrvYYc4Fu+hpn1JcNRhzJ/B0bJ1yM/CwwBpvFubapBFueiyXCYLaAe+EQTP0lB41Roj6OACh14ydXEMswn9KpiScNt1lo2Hg447asUgXYHi+Ymzf+2KqKThMRMOOEGBol9WF7x5kasEX5tAiAG7uuWmfYwShI42Uhjnjaj8aWkSdKqptlt2u/zeSAZlkDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA6IK/Y2KuCTn5DEQhgF4VkZcX2IeUmqIqn2SXK5C70=;
 b=riZWvP+EugTc6rJRGdNjp0WuNgtsR4y2D2ueLZAmwfY9xmTz9ktax1PcyhwtsZoipxgHplwIX1VQVEh/+4wkgyTIh55M+XMz8BS9E45EvkRWJG0zWLgyc1NqY2ZQdDDH9nEMHICSkw9587O0k8fjCwJ8YdtAjdaSv1yYDIDbOijTVkOju4JKNYUb5lP8Z2S2o8FEZh7g0i5A6jKbxbcWyHITUTA0PNL5ZTTroROrdUaW03llZ0wh0izig/LAVMa5SkUwDne77zKJ3l0FsWk2ggqISvaxyLN90r9W5937FD2KVxTN8JOGqoEtnOFrmjA0hb/cadG7z8pexYrqSiwcKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:30 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:30 +0000
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
Subject: [PATCH v5 07/25] fs/dax: Ensure all pages are idle prior to filesystem unmount
Date: Tue,  7 Jan 2025 14:42:23 +1100
Message-ID: <5eadb9096a42f993273cdd755124955665dcea26.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0164.ausprd01.prod.outlook.com
 (2603:10c6:10:d::32) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 8181a272-27e5-4f39-09ec-08dd2ecd73b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kMIxnItGqEUiTrFQH/PLNeGA8a0Ab+idc8fNPBifgYLaddvBX0VUjdeGLDH2?=
 =?us-ascii?Q?x5SRAk2TJGjWMKHzPDrf6g33Nm0k1gdUA1R6LB5H9QeZwtMF8ufi/b4oO288?=
 =?us-ascii?Q?p8sh5rX6FV7aQPtNX6Lu/s2eSW+ieiFzLi3+dSTMlgC/qDOa88MpkzFgo7su?=
 =?us-ascii?Q?SrtbxC6BPwCd7zSQ2+riOVpretXezQYSPNYCWn1snRh7f2hzBSmEkfQ+AvDY?=
 =?us-ascii?Q?2vnwKPKTg27nN136mFdvvTyKEuCo2gwCqHhF6RU6pcCRCQlJHmzApz27xjdR?=
 =?us-ascii?Q?ypjkTehvy0vlQDB4ZMcWJXYUR+kcIRBSbC5GsBku2MuadwsO65amQZD8e46R?=
 =?us-ascii?Q?6lDO8OLZOUE21JiG+gEAJTPBMnQlO5pY0y57ba3nEjstc2QYi5/UvfX30pHK?=
 =?us-ascii?Q?+wFUYXszetktpHWQRkqhp8vGz13+6BlKkomlhhzo+oHANTiYuX50CQOc+yRs?=
 =?us-ascii?Q?SrWa9XZ5P01UDODLTxgiP2rxuCqfEgBM0oOHj5kK2D9C5AFAwGsTyvmrLZwQ?=
 =?us-ascii?Q?+aop0uD2KlmctY4GsR1ESIKsxQd55nt8ymX4vzrLG6nkbK6KDP/hqmlGhW3k?=
 =?us-ascii?Q?n+odqy3wLtE5OcD5V845X+2CKJoNETAYGetvvQu1ecy4ehP2hSsZkE6mmuAr?=
 =?us-ascii?Q?4u56dmCHzfUzJwwbOwfHGM+i2SgHOO4FBjZ3ZbY/WC3L9+MAOh5zBc6lpaUa?=
 =?us-ascii?Q?cRmvZ9hngw9xYn1gb639QKRV8d+AazR62aUc6L0A5zMN6XVKDjWB6AZ8vzvp?=
 =?us-ascii?Q?xM9D4yfafIw2jsfyGNXsavF5et1TTNKjuNd9jJix23lpkFjifPBBw2siwbRc?=
 =?us-ascii?Q?eKcCZuwBq3g4/+/bVIRl4T4VjrD+dpHMZtUheBwHWmljNcFEQXx76Vv8iFcp?=
 =?us-ascii?Q?X5gfnNFcfSQDXjiA+UhAkgnmJgXC2rz9bhgVisbm21GschAlpZ25ItH3hnqD?=
 =?us-ascii?Q?IY1jyREHy0VsVpeitQNr5kahoj6naujoC6ptxMVcSpQuYiBSdPl8kpuyw7W8?=
 =?us-ascii?Q?/pNukj7NwCr+jkN1Vn6jXBfgqhSrsck4cY/QLsa0YT/UpaWgr/8ezHl5pqDM?=
 =?us-ascii?Q?6z1dsHLj5BhsALmtJ5uETszRDmiRIud3DcwuZUsWP2WOKv714dDep5pw+13j?=
 =?us-ascii?Q?Ph3RnQ1v6IBNjwMs9wrE4/J31B7QwOmStD4imPVRUIYsW6lv580DPUI9UFF8?=
 =?us-ascii?Q?kuuvIdjaAMUhZQYc2kTB9IkJNVcdu3zIILhKfh0JCwM5/TD1x+MmwUl1PrMk?=
 =?us-ascii?Q?27tkVtwK5PIPTfHQj/YHyP+py7Mks36aJHNZCuNcURw6s/9OT+yYmdSbERsw?=
 =?us-ascii?Q?FMK1VYfG5asDpKaIyI+UDzq9hUc7dH6EiKRwDwAQjiWSkdvGBvDNGE5V0RL8?=
 =?us-ascii?Q?NHxMBxegTbwwzBLmUVxdt8wsQGAy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k4PBzmYvr4CjoeQdetj83yZAI54DA0cILOA3GBXofhU8dskTQixhwEXHaAMJ?=
 =?us-ascii?Q?Q/yvj5aEAa3+pdWT6H6BL4SOgYIsss8CLMO50l3rOezjkbpvfgCAVZjtk3Ne?=
 =?us-ascii?Q?DP4MQY/r4BZJmY5Van7bBjruasa5dse0mUrOiOQa30qi7ysAT3mOpkGRTIAq?=
 =?us-ascii?Q?zdQcoWaVD0DV64rs1bbY48/xi6MPTbrLQWo1c66x4FTYWi85/8VLijVO3+1u?=
 =?us-ascii?Q?MWuPHjXaZ1cOPlG4KK4JqOyQ77RuR8MLXLEbVsR+n4zSdMzHUg9nAcrd/cY4?=
 =?us-ascii?Q?zDTSiVoQU6mhHgsdp+yDLi/ZEDORvtHNAbNPKWXpYjUTAFRcN23vS9aWTlfQ?=
 =?us-ascii?Q?kOW6lwugAT/7h3YE70oeJtJVuZYol/bjcsvoZ5Yu+tioIV/bfmAHr/lSeYW+?=
 =?us-ascii?Q?+QPwfiVxSAxrSZPozSdHzE4/xlCJRBmoMo+vHND0CUlkMJLr9D+tKWOcE/cj?=
 =?us-ascii?Q?M3Cjb9Y2nM1jvUsqQGlx5/DOXvpAYLsuaqfieaddslN9luH37KL0A8eMXb3g?=
 =?us-ascii?Q?FVRM7oOmBIiALJ0A6dYl/ThTcDnK0JeiRjg1Gq5CS9Qzjt4txHRtob1mzO/8?=
 =?us-ascii?Q?Wtl2all6dUIP5/k+G3KQaFMbcPdSHmnhaMMjjvxHo1nL7eDCSyAiIkdtqBd9?=
 =?us-ascii?Q?QH32JgRA4CIlJcdex9zxmHBGiJC+CYSe2+vlBap7LMSVZQ2pvK6XFmYkL0F+?=
 =?us-ascii?Q?vj/vHTx8YsIJtuB3GRhF6NREfT3bLLc68a3g9bqkTdm1qc4+rtjLkv19I/YJ?=
 =?us-ascii?Q?4SK2WIm/Fw/HyNcwQdP7cm1hioJJ6YDQrvKNzRc755OWtKTxj4d5kq7bLVxv?=
 =?us-ascii?Q?++ts959fmkEzHdFZV138ReSj5HLhmx8Jd8tPO7DIhhEH6YiUXO3rwDX/9KET?=
 =?us-ascii?Q?DIczaxpaBfM1zlxnUurT0NSB4e95Ab2VligdQFxQwjNteGC8nM6fobaFR+MO?=
 =?us-ascii?Q?NLrTLB6BJkkv3D7LSOIjRMOsiQojXph2jtgLt15P2pPok6tyRyZSY07C3yZO?=
 =?us-ascii?Q?d+jkXQHFH1omyfzS/QUz1MOX+oPJTZjMxsNxiAcVW6ETHpoBT4zgS80F3TGW?=
 =?us-ascii?Q?3q/b0DjBTqVf6YEW7JVnUFjvqIN8M6QAgPfTfpCa02SOPXqFk5cQcZjx0ie6?=
 =?us-ascii?Q?gBHqhsWP4+j3RD0a881cdNfuGKFfLszl4yE5+7K1ll2Ygb4OmIgWkw4fZUmb?=
 =?us-ascii?Q?IvfiCPTA67mXPyjD8UXoo/YsoYLrpoqnhjlMzzymcs/THLTwV2EX9VAhFXmb?=
 =?us-ascii?Q?fVL1tYuel/Byxmz20nCe4nNScuo/lup34mFpy66v1ZWP0IurC2+ZIiw3WJjs?=
 =?us-ascii?Q?5sKl50+zVR4DavgnojFrL9QrOfIvGP/qgJQlLyOlpfIa/QYmX9gSlT93CX/Z?=
 =?us-ascii?Q?Lg4fQhLQw6d10J533sxrD9VcRUcCsIebGuqMcxTUmnF2QUzJiqb/8zpPvJgh?=
 =?us-ascii?Q?OmY6QbpPEH2aeDgD4zcwgEHcY/tZ8gwjtLlu9ePPBFI4g6NgtO0Mi3fcYukf?=
 =?us-ascii?Q?kVWwTI0CyHAj8Ye4v4o6V3q/JlgS7XFpbfwjy/c+Nfxbsl0PEm5Q8BP67VVH?=
 =?us-ascii?Q?11IohSNLR5te+8GkxzkN6/WnJ4+kaHgI2IpnhfLY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8181a272-27e5-4f39-09ec-08dd2ecd73b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:30.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZUUcMMgXWSpZvFo+SNizVhxlUYntUuJuYJPi4R0cgeSCi8B1ihUt+zb/nm9vSZNM7MGkJrpqc1F/zCOBB1qrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

File systems call dax_break_mapping() prior to reallocating file
system blocks to ensure the page is not undergoing any DMA or other
accesses. Generally this is needed when a file is truncated to ensure
that if a block is reallocated nothing is writing to it. However
filesystems currently don't call this when an FS DAX inode is evicted.

This can cause problems when the file system is unmounted as a page
can continue to be under going DMA or other remote access after
unmount. This means if the file system is remounted any truncate or
other operation which requires the underlying file system block to be
freed will not wait for the remote access to complete. Therefore a
busy block may be reallocated to a new file leading to corruption.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v5:

 - Don't wait for pages to be idle in non-DAX mappings
---
 fs/dax.c            | 29 +++++++++++++++++++++++++++++
 fs/ext4/inode.c     | 32 ++++++++++++++------------------
 fs/xfs/xfs_inode.c  |  9 +++++++++
 fs/xfs/xfs_inode.h  |  1 +
 fs/xfs/xfs_super.c  | 18 ++++++++++++++++++
 include/linux/dax.h |  2 ++
 6 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 7008a73..4e49cc4 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -883,6 +883,14 @@ static int wait_page_idle(struct page *page,
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
 }
 
+static void wait_page_idle_uninterruptible(struct page *page,
+					void (cb)(struct inode *),
+					struct inode *inode)
+{
+	___wait_var_event(page, page_ref_count(page) == 1,
+			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
+}
+
 /*
  * Unmaps the inode and waits for any DMA to complete prior to deleting the
  * DAX mapping entries for the range.
@@ -911,6 +919,27 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
 }
 EXPORT_SYMBOL_GPL(dax_break_mapping);
 
+void dax_break_mapping_uninterruptible(struct inode *inode,
+				void (cb)(struct inode *))
+{
+	struct page *page;
+
+	if (!dax_mapping(inode->i_mapping))
+		return;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, 0,
+						LLONG_MAX);
+		if (!page)
+			break;
+
+		wait_page_idle_uninterruptible(page, cb, inode);
+	} while (true);
+
+	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+}
+EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ee8e83f..fa35161 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -163,6 +163,18 @@ int ext4_inode_is_fast_symlink(struct inode *inode)
 	       (inode->i_size < EXT4_N_BLOCKS * 4);
 }
 
+static void ext4_wait_dax_page(struct inode *inode)
+{
+	filemap_invalidate_unlock(inode->i_mapping);
+	schedule();
+	filemap_invalidate_lock(inode->i_mapping);
+}
+
+int ext4_break_layouts(struct inode *inode)
+{
+	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
+}
+
 /*
  * Called at the last iput() if i_nlink is zero.
  */
@@ -181,6 +193,8 @@ void ext4_evict_inode(struct inode *inode)
 
 	trace_ext4_evict_inode(inode);
 
+	dax_break_mapping_uninterruptible(inode, ext4_wait_dax_page);
+
 	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
 		ext4_evict_ea_inode(inode);
 	if (inode->i_nlink) {
@@ -3902,24 +3916,6 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-static void ext4_wait_dax_page(struct inode *inode)
-{
-	filemap_invalidate_unlock(inode->i_mapping);
-	schedule();
-	filemap_invalidate_lock(inode->i_mapping);
-}
-
-int ext4_break_layouts(struct inode *inode)
-{
-	struct page *page;
-	int error;
-
-	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
-		return -EINVAL;
-
-	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
-}
-
 /*
  * ext4_punch_hole: punches a hole in a file by releasing the blocks
  * associated with the given offset and length
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 4410b42..c7ec5ab 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2997,6 +2997,15 @@ xfs_break_dax_layouts(
 	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
 }
 
+void
+xfs_break_dax_layouts_uninterruptible(
+	struct inode		*inode)
+{
+	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
+
+	dax_break_mapping_uninterruptible(inode, xfs_wait_dax_page);
+}
+
 int
 xfs_break_layouts(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index c4f03f6..613797a 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -594,6 +594,7 @@ xfs_itruncate_extents(
 }
 
 int	xfs_break_dax_layouts(struct inode *inode);
+void xfs_break_dax_layouts_uninterruptible(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8524b9d..73ec060 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -751,6 +751,23 @@ xfs_fs_drop_inode(
 	return generic_drop_inode(inode);
 }
 
+STATIC void
+xfs_fs_evict_inode(
+	struct inode		*inode)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
+
+	if (IS_DAX(inode)) {
+		xfs_ilock(ip, iolock);
+		xfs_break_dax_layouts_uninterruptible(inode);
+		xfs_iunlock(ip, iolock);
+	}
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+}
+
 static void
 xfs_mount_free(
 	struct xfs_mount	*mp)
@@ -1189,6 +1206,7 @@ static const struct super_operations xfs_super_operations = {
 	.destroy_inode		= xfs_fs_destroy_inode,
 	.dirty_inode		= xfs_fs_dirty_inode,
 	.drop_inode		= xfs_fs_drop_inode,
+	.evict_inode		= xfs_fs_evict_inode,
 	.put_super		= xfs_fs_put_super,
 	.sync_fs		= xfs_fs_sync_fs,
 	.freeze_fs		= xfs_fs_freeze,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index ef9e02c..7c3773f 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -274,6 +274,8 @@ static inline int __must_check dax_break_mapping_inode(struct inode *inode,
 {
 	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
 }
+void dax_break_mapping_uninterruptible(struct inode *inode,
+				void (cb)(struct inode *));
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
-- 
git-series 0.9.1

