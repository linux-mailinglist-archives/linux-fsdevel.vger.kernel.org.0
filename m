Return-Path: <linux-fsdevel+bounces-59417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3C5B388FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284DD7B4053
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738C42D7397;
	Wed, 27 Aug 2025 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sKejWGMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F93277016;
	Wed, 27 Aug 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317347; cv=fail; b=UK0ykBUvcywlGoosLlobZNEHNYdBM2yklanbAM9qczfMaqz+xK2cyqPZyfc1jPyWBssdxvREIm786LdF978C5VA+2Rfdgk8LGssuaH7cVqNFrRQzYN1K9+hc2BkG58urNNv56eGtkIB+wcezbYZz3ku4YynGXB/AZYPiy9bYOSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317347; c=relaxed/simple;
	bh=xJU8b6KU5ZD8zD5x8H6rKLEzgPBwZuQuKGel79bp7ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbDXM5jQ/b0xsKGjsdYp6Pj/TXpg6XNEauUBwDL/+Xfx5n9AYJm46+LBam3giOQZ5PANu9ISBvqh0Q7w8Ds7UvhE2UB0aJVkmZyy6PI6V8U/VLcpr8DtH+xwX2XNI9V1CVpkR8ClILYp2CaI8siq4DzHRh1DdBaNlf8XqycbEOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sKejWGMi; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC3qCTY/WZSpUqrTuoLP5zYuGXQNSPFGGckMJajzWrAt7gYQQxdgsyv9kOeob34zSGk3RGcf+Yf1q22wA/Dm/7u4kGejVoT/AFxFm9nGmqzNoBdx+cip2fNti8Takc4TO/Ks80LgipCKCavGqVdi6mqCNzmQk2qQK9uKSDf2ikpVvMm/YeLbf1IrBs7OT6LCX31yFjvj1R54/m71bq2M6d5nh8fXFEiLzqIU79ZFF3zn980SBQevHhXlpgmkli7DH120FkuW6cDnfK+R5UaBxfTkm9qEoHGaKYpHi8q409zjagO3szinNbDP+WsZNP8X3Xnb6s0g5XC0+RfW873K9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pzaw/tMHhGW5q3HtuFLiF+Jhys0tvCCauTRmjgnHzU=;
 b=LqjF82CNpk5Ddwwjk5EtOyExNj1yvorRWvsM6Vv/daLyFwfvugbHMwVpZ+niIGlbxDsLfEGV0KcymsPl1n+esQ9XErwJjUyAwwesW6M7VtWGXeMVwrJbm4DZt/a/p55AbB24jEquNaVnHOnxw8Ij3IHKpQHlNKLqJaJtlgDxSGUDegEBXzC95vlVwR73+Ci0gKxRvlq1gIn23tHAvAi8VqGayQte9TMtZBn2lwSE0cszqddSt3Mci0lyzuzPpUVborPQusw0CPzgCAW4XUUDvsBH3dfd/ZVM+LZjsaVDsG5pAUHVmS8OyOBVQdVyFsG+7TJnAqzwQO2IkeGgm8zbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pzaw/tMHhGW5q3HtuFLiF+Jhys0tvCCauTRmjgnHzU=;
 b=sKejWGMi/n/GKknBq/Z+GeqD6dZ+QZDh0VZQORifeCBtTmuM8Ozv0AVtdSjvLMz9sK2XZNwE5k+i2FkSRAjOWXrIQq2x4vfFymXIZzWq19HH2mUT/zwzTB08c/PRcfOLEOKzU9muFnsikR9soE/Vw340i+bnOpoOARe+pu4gCcI=
Received: from SJ0PR13CA0135.namprd13.prod.outlook.com (2603:10b6:a03:2c6::20)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 27 Aug
 2025 17:55:42 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::4) by SJ0PR13CA0135.outlook.office365.com
 (2603:10b6:a03:2c6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.5 via Frontend Transport; Wed,
 27 Aug 2025 17:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 17:55:41 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 12:55:22 -0500
From: Shivank Garg <shivankg@amd.com>
To: <willy@infradead.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <seanjc@google.com>,
	<vbabka@suse.cz>
CC: <brauner@kernel.org>, <viro@zeniv.linux.org.uk>, <dsterba@suse.com>,
	<xiang@kernel.org>, <chao@kernel.org>, <jaegeuk@kernel.org>, <clm@fb.com>,
	<josef@toxicpanda.com>, <kent.overstreet@linux.dev>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <lihongbo22@huawei.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
	<apopple@nvidia.com>, <tabba@google.com>, <ackerleytng@google.com>,
	<shivankg@amd.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<vannapurve@google.com>, <chao.gao@intel.com>, <bharata@amd.com>,
	<nikunj@amd.com>, <michael.day@amd.com>, <shdhiman@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <jack@suse.cz>,
	<hch@infradead.org>, <cgzones@googlemail.com>, <ira.weiny@intel.com>,
	<rientjes@google.com>, <roypat@amazon.co.uk>, <chao.p.peng@intel.com>,
	<amit@infradead.org>, <ddutile@redhat.com>, <dan.j.williams@intel.com>,
	<ashish.kalra@amd.com>, <gshan@redhat.com>, <jgowans@amazon.com>,
	<pankaj.gupta@amd.com>, <papaluri@amd.com>, <yuzhao@google.com>,
	<suzuki.poulose@arm.com>, <quic_eberman@quicinc.com>,
	<linux-bcachefs@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH kvm-next V11 1/7] mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()
Date: Wed, 27 Aug 2025 17:52:43 +0000
Message-ID: <20250827175247.83322-4-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827175247.83322-2-shivankg@amd.com>
References: <20250827175247.83322-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 704515d4-baf1-47b1-06ca-08dde592f084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jB/+Sj+sdis2Lh5H6ALTX11EUaHH62zfkM/Zg0onQGGjWM1B4v5L/wlgLqCq?=
 =?us-ascii?Q?sgObBCd0YmL3G1I/rmSLUSBgVcYhdJBsXG9v+Qb224t+RgPbyyWiDzVetiTZ?=
 =?us-ascii?Q?tMM618175vjKc/7R1a5ZYic+uHpyH0zUFMV1yKOMKVHtBayDYnJ2nH07ORNj?=
 =?us-ascii?Q?pa9mSJd0LdphQ/mOXksz7RtoaRMROvjDkDb2499qK3hPIxQ5txXYmhKbKtby?=
 =?us-ascii?Q?9RxWvIajn62FJWzbhEfosExuFvL8NaFxZTdcxQ+qF+aPV+hcrGl96RsSrh0/?=
 =?us-ascii?Q?UpdGEAvhvSO1NUaqDT+bYr+dJZSZuRCVMr+UPE1anGjFPkQdD1JrRCqTeMwZ?=
 =?us-ascii?Q?ZvR49rAHzYdPxgUUNEAKBzU5/xDYLrZz4fXLcnzkiv/lt+CdSVukkMCzbjak?=
 =?us-ascii?Q?0PoIRCspN92xugxp/qDz5Mx0OuLJfrwdUZ95+kyNoKWRoojAzdptqD2FNeip?=
 =?us-ascii?Q?OzuorC/J2SOXu9GJmcWKEZ4w2qcvEUbpZvRx/eFYwXaQu3+yEoDpVGaRvCZx?=
 =?us-ascii?Q?dPOFiuF61Hlf3kqP9TMoH969jhhUdsxHr/MZrL1+Uh00SeSLanBLFE2m6RCV?=
 =?us-ascii?Q?UYb3HqhdAAKkI5GCXmB39GcPvHrw2dh5rD5OA4vOfe6KRnty8mu747PF/yCq?=
 =?us-ascii?Q?lNCKbOEPxJApXQ238/T4pqDwNMXbrc0xAmS/DEdpr/CnPgwBFvx1AHmCNh00?=
 =?us-ascii?Q?PRb9UDWBna1IxFx3vb2ZRnQMDSD5UqonDpCL9vOVeguZ5uhXjRxJgZAydmeD?=
 =?us-ascii?Q?jk+G/Drs+pXpn6kkdPfmZHzaboELTlEQAhCTKBLg0Lo85HKGAMVFB9d25z9u?=
 =?us-ascii?Q?UDk7b8/D9qdjeLP8dKGBlEtJ14uxFTQ9DPbdrtCWiTSrxzt/GuvjJno8pnfq?=
 =?us-ascii?Q?UXySmDTZAaGUrALteUNF+nNZr10wEge16tneVpRxC/78OK0s+C2h4kZzdgvX?=
 =?us-ascii?Q?s0lvuOLJi4vlB3R5iVTETsubEcXRSYPJjZHGOhpvkzY+AG2xI9zm1hOs+Eez?=
 =?us-ascii?Q?Npzl7RIBVwMvcTt8sGKs+l7zxwYmfECryEjWAFp5fuZhLv9V6KoQqe1JcXRc?=
 =?us-ascii?Q?5nivamZgqUszz1ENUgHDJEfowUWjyBApy2j4weLnZe9vFlnOeEFUX+/DliU4?=
 =?us-ascii?Q?rKLbaJ737jyjlpGRc7b/DS+8aB4ckgBW4ncsjdA469fas2boy1C+fZF79Bzq?=
 =?us-ascii?Q?eXAkT43mkjO6swxLZGgvwOzuS2igRoUwiRwDydhB5nM17A4478gpwm6TkebI?=
 =?us-ascii?Q?m3/1EwnYmvZBDvEjSCcY01lsgw0l4Q7oywNQOQj6hCc9qBm73jwWB1nhxL3R?=
 =?us-ascii?Q?4DjpN/P3o3b8eis81KrutsTxYTI4DtB08psFtqexIqhG7ZS6RUB97c7IDRuI?=
 =?us-ascii?Q?T9oWBDx6E7yRj1FWH18HhaEEw+4zDyPtMQDiR1e2ggVNSyaLykBYlpDeWEyT?=
 =?us-ascii?Q?oOfFrGLHIG2iyo7TnDF7MC+cA4ipFT7gmvvbwDaG0EruG8GE+v/bILdv5zA/?=
 =?us-ascii?Q?9U1krwIyEIwENi4+F3RtX1KuiKGNOK/woPoq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 17:55:41.8313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 704515d4-baf1-47b1-06ca-08dde592f084
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Add a mempolicy parameter to filemap_alloc_folio() to enable NUMA-aware
page cache allocations. This will be used by upcoming changes to
support NUMA policies in guest-memfd, where guest_memory need to be
allocated NUMA policy specified by VMM.

All existing users pass NULL maintaining current behavior.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 fs/bcachefs/fs-io-buffered.c |  2 +-
 fs/btrfs/compression.c       |  4 ++--
 fs/btrfs/verity.c            |  2 +-
 fs/erofs/zdata.c             |  2 +-
 fs/f2fs/compress.c           |  2 +-
 include/linux/pagemap.h      |  8 +++++---
 mm/filemap.c                 | 14 +++++++++-----
 mm/readahead.c               |  2 +-
 8 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index 1c54b9b5bd69..3af2eabb7ed3 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -124,7 +124,7 @@ static int readpage_bio_extend(struct btree_trans *trans,
 			if (folio && !xa_is_value(folio))
 				break;
 
-			folio = filemap_alloc_folio(readahead_gfp_mask(iter->mapping), order);
+			folio = filemap_alloc_folio(readahead_gfp_mask(iter->mapping), order, NULL);
 			if (!folio)
 				break;
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index d09d622016ef..139f9609e737 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -474,8 +474,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(mapping_gfp_constraint(mapping,
-								   ~__GFP_FS), 0);
+		folio = filemap_alloc_folio(mapping_gfp_constraint(mapping, ~__GFP_FS),
+					    0, NULL);
 		if (!folio)
 			break;
 
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index b7a96a005487..c43a789ba6d2 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -742,7 +742,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 	}
 
 	folio = filemap_alloc_folio(mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS),
-				    0);
+				    0, NULL);
 	if (!folio)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2d73297003d2..e9a1bf7568c9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -562,7 +562,7 @@ static void z_erofs_bind_cache(struct z_erofs_frontend *fe)
 			 * Allocate a managed folio for cached I/O, or it may be
 			 * then filled with a file-backed folio for in-place I/O
 			 */
-			newfolio = filemap_alloc_folio(gfp, 0);
+			newfolio = filemap_alloc_folio(gfp, 0, NULL);
 			if (!newfolio)
 				continue;
 			newfolio->private = Z_EROFS_PREALLOCATED_FOLIO;
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 5c1f47e45dab..56a51c9ba4f1 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1942,7 +1942,7 @@ static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
 		return;
 	}
 
-	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0);
+	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0, NULL);
 	if (!cfolio)
 		return;
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 12a12dae727d..ce617a35dc35 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -646,9 +646,11 @@ static inline void *detach_page_private(struct page *page)
 }
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
+struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *policy);
 #else
-static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *policy)
 {
 	return folio_alloc_noprof(gfp, order);
 }
@@ -659,7 +661,7 @@ static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int o
 
 static inline struct page *__page_cache_alloc(gfp_t gfp)
 {
-	return &filemap_alloc_folio(gfp, 0)->page;
+	return &filemap_alloc_folio(gfp, 0, NULL)->page;
 }
 
 static inline gfp_t readahead_gfp_mask(struct address_space *x)
diff --git a/mm/filemap.c b/mm/filemap.c
index 751838ef05e5..495f7f5c3d2e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -989,11 +989,16 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *policy)
 {
 	int n;
 	struct folio *folio;
 
+	if (policy)
+		return folio_alloc_mpol_noprof(gfp, order, policy,
+				NO_INTERLEAVE_INDEX, numa_node_id());
+
 	if (cpuset_do_page_mem_spread()) {
 		unsigned int cpuset_mems_cookie;
 		do {
@@ -1978,7 +1983,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order);
+			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
 			if (!folio)
 				continue;
 
@@ -2517,7 +2522,7 @@ static int filemap_create_folio(struct kiocb *iocb, struct folio_batch *fbatch)
 	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 		return -EAGAIN;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order, NULL);
 	if (!folio)
 		return -ENOMEM;
 	if (iocb->ki_flags & IOCB_DONTCACHE)
@@ -3916,8 +3921,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp,
-					    mapping_min_folio_order(mapping));
+		folio = filemap_alloc_folio(gfp, mapping_min_folio_order(mapping), NULL);
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		index = mapping_align_index(mapping, index);
diff --git a/mm/readahead.c b/mm/readahead.c
index 406756d34309..a4dfa837dfbd 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -183,7 +183,7 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 {
 	struct folio *folio;
 
-	folio = filemap_alloc_folio(gfp_mask, order);
+	folio = filemap_alloc_folio(gfp_mask, order, NULL);
 	if (folio && ractl->dropbehind)
 		__folio_set_dropbehind(folio);
 
-- 
2.43.0


