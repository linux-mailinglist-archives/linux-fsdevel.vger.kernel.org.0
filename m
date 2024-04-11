Return-Path: <linux-fsdevel+bounces-16631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6627B8A04F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72CC1F231C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70489BA3F;
	Thu, 11 Apr 2024 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OdkJBitK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2090.outbound.protection.outlook.com [40.107.223.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126743234;
	Thu, 11 Apr 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797066; cv=fail; b=dkJewr6PYeM0sO6aAzh7EK3kmjrBzt7s4/QCTAtf2SiFzTAah56Jns3Gmn31+anMSXNJrjsNIpkfqa0MBRQRM+erwZSwoIjSY4IDA0Ab7ZdXLSw87V/5CqEpHFWQJpTNhpuHn2A9xtQ2euNfttQGKhmDFnMVBx34QIjxguVGgH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797066; c=relaxed/simple;
	bh=q4sflcCiohDqNUIbRH/z+VKYZd7QZMMNx6Zl3zHknO0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DuvgJ4y9VBEtW1USctAoZIeqxRs+JUrEJRpa2BkK9QhE3XkDcL+ovaUPKzhXxV/PcMtANXi1RqiChM7V8ihLyuuRHhMovVlJTv+T7MF6JnkPUEmfP6Xjkhg7tTm1s3cvRzwli/VqYpquiSTsM9l13PP/rFI1rksoLwLjGhLJG+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OdkJBitK; arc=fail smtp.client-ip=40.107.223.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVy1aMEu8XAS1WCZan8oRc26UzTmWi1j0T8fYKS9M4srauIMTddD/UZSedCcf1I3LysVRKe2vSaXlc/zBOScZCK6FGKZ9QEoZfhlgSzZbCbG+X58P0W/0ermwCFzrMdxd3Y5j8hn/vMe9Cc2FJofM4MfA888yxXpXwPBMFa28uO7wZzaWo8K6fzy3so0Cc95gBpGZeMTTw8xtvXTIH/w+quRau4B0Efuyjs/vYJpwmvOaOT27M8XH/w/7mRLrnKkyTDFUWRJvPsu4VubnBfX1zzwaVxAuCoRdvnvUGlIVB4EXldis9tT/bby5oZIjQxBtFgBmC1Po+BGdOQCfWSuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwz3G4pVEJdlpyhp4ZtpEgx+/B+YnG1g293zldnpPzg=;
 b=MyQEpd16nwzltDMGj4wYf/4P3KD3HjTrHsMA9a9q4uwQ+XHYF6KPl50hTptaU4ANu5OlgiNDib5dwtlh5+NhOLU7z7u+HsMSszoeG1DwunhJpGZ5ebTcIGpNUDVR05wC8YU8TTpYhsk21X8vwEMk6sCeM92GQBrI2nIlBGMvepgNDq2VQzuf4V2OJxE9Y7LXecyJkcDBbT+IJ0V8dbG56F3jjnUiDyv4KvgyQhOzEy/jXcOKmtpY9qe8RJnwU5oQQBuTppAVcQmL+jx7fYRkfd9g3bTTq5JSKyk1Friv0LAN3P7oupyt54C/iLPso9IeWIDDiErdg95KOYAKXWshmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwz3G4pVEJdlpyhp4ZtpEgx+/B+YnG1g293zldnpPzg=;
 b=OdkJBitKYplSQAfJL6ZSjLvY5jvc0GrxEZ+7Hw0UyMfyaBtghRaHWPOjpYY2edOxKqTNYCC5TGDLJLpHkoOPlbEBlaLbox7FHevuRD0hrR96crWNp0Id68q+PLXfJrvO/HZ75fx2XBxACKtZpMWxJI/i14tHJimWdmzYR4xqQutM49mRL6s8Z8PDBHZZJAjWvNzQSyWCMPxRwMNC7G701d7da2JbN39p8mbsTCpvH89ZC8g5EFEG2gWeZ4oA87tjKJp+5pxwaOoVlz9/o8N+JH2it0D1QR7KzHh38kBZda3ZuvEA7dIilJXYotAIojILzcW/h4l+lFML8b7K23ejlg==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 00:57:41 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:57:40 +0000
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
Subject: [RFC 00/10] fs/dax: Fix FS DAX page reference counts
Date: Thu, 11 Apr 2024 10:57:21 +1000
Message-ID: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0003.ausprd01.prod.outlook.com (2603:10c6:1::15)
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
	stltYl4F6zWa/yARgh08etfvcq+xoDV9XmPuqv6xp7z2hhHz1b2s2t8fl/cOMmpeV0Ms2RBIMvSrTG4WI6QUMOto7TbqEvWt2BdHZdG0DsD2taJKj3pTAcABsQXZWCPOpfsOMtlNNBPQPMHpCs85wllyQ18s0A0OgvnLYCGENQOZjEyk7cprsXMrZ++mWmwMNhcR8CGpHyatwRUleeuGQdOf1JGTM/c8UsQ/apaEYFhT8/B31PO5g/yCML8CUkFx5F66bT9L9gOXimV6mHHcWpEFKvBhC0nJrfG/phHRU8/yuOAndAGg6i8SenZKizJNYavz7z2/9XdmH4u9idYxDfhlGD47v4DecGwfyqQzFv0b0aG1nqZHdz+E7aM/QJ72jDyHSqDv5mupyO3NX//NFNymSZ26qbuAjdWDK0D9lIfkTU6WlaVQ4msSYVzRSOkrcWkgP2q69eVHGW8TvQ+chgRYFdaTqOeWakA6FzkDu+ThuN5u4ow7oGE+FnS+2x0hh1SNVNsTTFZprXcGJ3pwUn6BNbigF/RR4bVdq4A8N3v5kkt70AHbZAUSI8t/ErRebtogKye4Kyecsuy4x8lfzg2qZwkrp2ys4ctlGufjTRtMg9ptiO6DEk8ZVbYXZ3i7OSL1T3Q1BMKuI/vruXDxw5m4cqvFh0KBvEuVwcMQiNQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zuR4fKit5gB0Do5otoOLKhaAcoB9jNhaE93cDWtEWXLjDrmN2M5Jr27p7sHK?=
 =?us-ascii?Q?D2tcV/LDUOu4iAjM6nJWSuq4bHgXCHkTFu7bOLSrCnks+rzr6kpYRDqJjZfC?=
 =?us-ascii?Q?gwsw+O4bEDOfjSRG3s6echPStLaZ3Y389/TingvKSQxp//d3JCRe0fRT0JYz?=
 =?us-ascii?Q?GbEplMXA6lj9nnSjvauQHuhDSXpDX2CHeodlOVSWpLn5ls15IzYsuqUxbJy2?=
 =?us-ascii?Q?ukX1y9eVh3Um2Tv/74JjMXm3OhSQaVBWcMAAWtlfTvd+VF2GItOmaYEeVVaZ?=
 =?us-ascii?Q?DAQGDnWZj8Hx9L4DjyZJbnDFmnygyX60DuQRyFC/kEmJgN4ZlyGkWQQDe/KT?=
 =?us-ascii?Q?hW6gbOzXWKmtulOd+toQvk5QV3yrlODDxyXk7D5iLLdMe53r+N0Ms5QK4jRP?=
 =?us-ascii?Q?KFsXHaHGmY/6MIzsNu5eQ0qwllVoQWDwgxRO0DK5kAFC2l+5uew17Ur+UB9q?=
 =?us-ascii?Q?Ci8AUwFWb0Av603Gp+Autr4kixLbLI44U3G3zTfNCoJXBkzSIw+RV10iccC5?=
 =?us-ascii?Q?miK5uzAP7eLZ/IeLwsADuZayl/dipE3itEfEsb1LsThSqakJY/r8hRY+n85Y?=
 =?us-ascii?Q?6FnJX/ABShaFmUaqYHGUMLD1lrp/x2dyajf782DouVuSJ2QzXOSF9nU2OFQd?=
 =?us-ascii?Q?9N8XoItbuvuNOO/D/IqRbonlE/toJX8kSg1JdCWp3Qjkhwr6OJVQ2ayhdc19?=
 =?us-ascii?Q?SZEK2CxDrFlfRMC5GGTHecR1nSU3H4Zx3yLZiiHlnaKOUgZI52mDWtnYMeYj?=
 =?us-ascii?Q?IB5ubEIatk0ZPwjBrKaNhpLnvwipHn88NEVzIziTiZNzg2JIwLKDS2OqguQD?=
 =?us-ascii?Q?VjuuhaN0Mm/pRK5C7mGlbKIzuAcD4F19ArnmBZ2ggQfKvHb5+DxWy3eYR3Xx?=
 =?us-ascii?Q?vP0cFB1sebaqR8YooaAnhEx6O/vnmWlgKNWpXbeMJMAVfWxG6JJK9dURR7ly?=
 =?us-ascii?Q?Jq9ZZmTOJQNgsNndpFgObZC5oet0vn8eyJzr0dvXXOfn8HtaoS8vr4VjsVO8?=
 =?us-ascii?Q?1A3DfMSsQwdoB/gNlPNOVbK7HxtaOUJgIY8aHl/ev+3jCzW6gYTCoCzPggjE?=
 =?us-ascii?Q?I9JqbnBwqzGgdc6pz8hhiXtC3M2Q/jtyGLoSTPNu58cQ741to2RmvF1R/z5s?=
 =?us-ascii?Q?NhaaEQVTgowqCO7WsopOBBR8TZ5l4h+d0RLM5NWRNIA0Cz4CepeA3OGYoHGX?=
 =?us-ascii?Q?bW0PuBgb7T5GZlnpRVf/AgOg2T6dw72h6bGj8azz+/43Zfq8+S3bRHPKgzHO?=
 =?us-ascii?Q?mIQ+nAQdWXMbUs8Uaix6POlJjVWgMWoAFvX1KYfs7UPiBrGyP86Eojd6s33B?=
 =?us-ascii?Q?imuU2setDqKD9t9Um/sm7T3AlKypwdlhntjVMZuN50XV9ZfnGjYYVXvNGu6W?=
 =?us-ascii?Q?13P2vZu4jK58GE14K+yFnZrdpVydtTJxvZPv8OQQG/Dcrnt6VVBLLBdQZ9rC?=
 =?us-ascii?Q?j+dywJlA3D+HUPlGZkq010wJfW74ToRfLgokqeu2lweAq9CyXOPKdWoZIPo3?=
 =?us-ascii?Q?wxuVPQIg6CgnI5FAuZ4uKYMR28byBaHORbn+vZPpKhMNRbiWtawJhJMPm3Wk?=
 =?us-ascii?Q?+wqNtk2bI8S4+WfHgjft5DRFNcXVB03+z7AYVLyY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00421e9-8ab1-471b-4428-08dc59c262f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:57:40.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BARh95wurK+T2RmCYquye4qi/IUriTQZtZ4UiFDgiiXJJFTgiTAgNt677Ji/+e0cx10ISNjoEiZWHSCHjnkPoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

FS DAX pages have always maintained their own page reference counts
without following the normal rules for page reference counting. In
particular pages are considered free when the refcount hits one rather
than zero and refcounts are not added when mapping the page.

Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
mechanism for allowing GUP to hold references on the page (see
get_dev_pagemap). However there doesn't seem to be any reason why FS
DAX pages need their own reference counting scheme.

This RFC is an initial attempt at removing the special reference
counting and instead refcount FS DAX pages the same as normal pages.

There are still a couple of rough edges - in particular I haven't
completely removed the devmap PTE bit references from arch specific
code and there is probably some more cleanup of dev_pagemap reference
counting that could be done, particular in mm/gup.c. I also haven't
yet compiled on anything other than x86_64.

Before continuing further with this clean-up though I would appreciate
some feedback on the viability of this approach and any issues I may
have overlooked, as I am not intimately familiar with FS DAX code (or
for that matter the FS layer in general).

I have of course run some basic testing which didn't reveal any
problems.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

Alistair Popple (10):
  mm/gup.c: Remove redundant check for PCI P2PDMA page
  mm/hmm: Remove dead check for HugeTLB and FS DAX
  pci/p2pdma: Don't initialise page refcount to one
  fs/dax: Don't track page mapping/index
  fs/dax: Refactor wait for dax idle page
  fs/dax: Add dax_page_free callback
  mm: Allow compound zone device pages
  fs/dax: Properly refcount fs dax pages
  mm/khugepage.c: Warn if trying to scan devmap pmd
  mm: Remove pXX_devmap

 Documentation/mm/arch_pgtable_helpers.rst    |   6 +-
 arch/arm64/include/asm/pgtable.h             |  24 +---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  42 +-----
 arch/powerpc/mm/book3s64/hash_pgtable.c      |   3 +-
 arch/powerpc/mm/book3s64/pgtable.c           |   8 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c     |   5 +-
 arch/powerpc/mm/pgtable.c                    |   2 +-
 arch/x86/include/asm/pgtable.h               |  31 +---
 drivers/dax/super.c                          |   2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c       |   2 +-
 drivers/nvdimm/pmem.c                        |  10 +-
 drivers/pci/p2pdma.c                         |   4 +-
 fs/dax.c                                     | 158 +++++++-----------
 fs/ext4/inode.c                              |   5 +-
 fs/fuse/dax.c                                |   4 +-
 fs/fuse/virtio_fs.c                          |   8 +-
 fs/userfaultfd.c                             |   2 +-
 fs/xfs/xfs_file.c                            |   4 +-
 include/linux/dax.h                          |  16 ++-
 include/linux/huge_mm.h                      |  11 +-
 include/linux/memremap.h                     |  12 +-
 include/linux/migrate.h                      |   2 +-
 include/linux/mm.h                           |  41 +-----
 include/linux/page-flags.h                   |   6 +-
 include/linux/pgtable.h                      |  17 +--
 lib/test_hmm.c                               |   2 +-
 mm/debug_vm_pgtable.c                        |  51 +------
 mm/gup.c                                     | 165 +------------------
 mm/hmm.c                                     |  40 +----
 mm/huge_memory.c                             | 180 +++++++++-----------
 mm/internal.h                                |   2 +-
 mm/khugepaged.c                              |   2 +-
 mm/mapping_dirty_helpers.c                   |   4 +-
 mm/memory-failure.c                          |   6 +-
 mm/memory.c                                  | 109 ++++++++----
 mm/memremap.c                                |  36 +---
 mm/migrate_device.c                          |   6 +-
 mm/mm_init.c                                 |   5 +-
 mm/mprotect.c                                |   2 +-
 mm/mremap.c                                  |   5 +-
 mm/page_vma_mapped.c                         |   5 +-
 mm/pgtable-generic.c                         |   7 +-
 mm/swap.c                                    |   2 +-
 mm/vmscan.c                                  |   5 +-
 44 files changed, 338 insertions(+), 721 deletions(-)

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
git-series 0.9.1

