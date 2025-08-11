Return-Path: <linux-fsdevel+bounces-57273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D0B202A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7823E3AFE6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBFB2DCF77;
	Mon, 11 Aug 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wjgGGC80"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C415ADB4;
	Mon, 11 Aug 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903258; cv=fail; b=dKHWXd+64Cd5Gnd4cOJvFIgA5eEAEf4iwhvPCEoucsKV2p2iDom+6GvpYmefml1ctiy0TkphBvridqWwCsEzhmC6KMB60zlXUb+JzLc93lMKqEzLo34kbY9LmOwN0O3tHxOGSdNmhZwr3p+234TtNlDIHxsOkUXTOJj2svg1DbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903258; c=relaxed/simple;
	bh=Rtuexo4FpaZfZTqqrpoxkQBJl55xPL0zOEpA9IB4UVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIQqTTkTyJB9RBEFem+XoV+Znodx+TynZ7okv8N3eRe4Sn4qn0ba64syVO1WKw4whBeIOWFPWOe7PG/DDhxARxARmGsgih/0BKpr/kZFDU8v++fOiAXLyXY4wFt4YwLxB5fUOBFH6oOamzlZVa2dVJ+sA2NNoozjri5XA7RpFsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wjgGGC80; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJctWfe6ZX1TnKovy7lQGYsTC6MvpsftXUdIfyi0WBB/+qK8LJuqKvghGS9Qihxs7O9hV/e2XKpuT6FchHs3cLM7BnRlqE6RxrY5iZQ86TLLpTp5uEG66pk4t+iCJwnOhj5PZRRWX4aVluBK4kcl0XEcoZAqTLiiXE6YozA6I8rdUKlQ4MUba9RwmhFW+ZbGzmOxFuDjdwOB3lvc+GqUPjGwxb+i/KorscJnn3QTt2sW58wDnTGbWL3cy02TVF0H7eTS2vU5OxcPdwAKy6RpG0a6cd9s2JmZmoGrlfkxjb6IePXjrZ6hbtDwcffAu4PZyFJcHrPOkqjQKw5rqJRC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X17jLWl9NZlz5hTLZR2DO4sWr968T4USn5/oBTg7DM=;
 b=k1tbGo97dUlLs5sIr7L8K+Mtyb/Tuop+wgeLS/iXmtvcK3F6O0qWONARoxjzsLsUQWEF2TVTj0DU4T2JuFdzxvfIqsQT8GJRNpMiGXUhDAnvN4emqPG0AXF7TiPNacoZiYGYh15yd/6oirJAwoDkh3vNe/j1vcdBsI0wVlkH3Oec9wDadxI3dmUbZneKO+ULsV0EEU9XEpsoURcWgmwag9wHDNli9VWAcOR8hOrXUOXdR8mg0DXIMntaWWchuElbEhORFg8GENYDXKpqzHXQ36bFNjfgMU5mRt/xYcSNeaSef/7cNcm80BK0SBnYn/Tgxq6ol8lU3F+fLZleiBtzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X17jLWl9NZlz5hTLZR2DO4sWr968T4USn5/oBTg7DM=;
 b=wjgGGC80XsKj5NgoBgrNBcd7li88LshRPXYMPbDPRd6vUgFtyRlBwh4LIGtX7iT6mEkP5k5uqQNxjjAQ65Cb8BGh1VrhN0yQcmsZnnOaEQ3cU3fVhEoMRbvXSn0afr9pXx9qC1pFLJ9IZW6yLIicOuU13LjnuDYHhpvUwOknQp8=
Received: from BN9PR03CA0361.namprd03.prod.outlook.com (2603:10b6:408:f7::6)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 09:07:31 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::8d) by BN9PR03CA0361.outlook.office365.com
 (2603:10b6:408:f7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 09:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 09:07:31 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 04:07:14 -0500
From: Shivank Garg <shivankg@amd.com>
To: <seanjc@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<pbonzini@redhat.com>, <brauner@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <ackerleytng@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<tabba@google.com>, <vannapurve@google.com>, <chao.gao@intel.com>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<shdhiman@amd.com>, <yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <kalyazin@amazon.com>, <peterx@redhat.com>,
	<shivankg@amd.com>, <jack@suse.cz>, <rppt@kernel.org>, <hch@infradead.org>,
	<cgzones@googlemail.com>, <ira.weiny@intel.com>, <rientjes@google.com>,
	<roypat@amazon.co.uk>, <ziy@nvidia.com>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <kent.overstreet@linux.dev>,
	<ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<chao.p.peng@intel.com>, <amit@infradead.org>, <ddutile@redhat.com>,
	<dan.j.williams@intel.com>, <ashish.kalra@amd.com>, <gshan@redhat.com>,
	<jgowans@amazon.com>, <pankaj.gupta@amd.com>, <papaluri@amd.com>,
	<yuzhao@google.com>, <suzuki.poulose@arm.com>, <quic_eberman@quicinc.com>,
	<aneeshkumar.kizhakeveetil@arm.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH RFC V10 1/7] mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()
Date: Mon, 11 Aug 2025 09:06:00 +0000
Message-ID: <20250811090605.16057-4-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811090605.16057-2-shivankg@amd.com>
References: <20250811090605.16057-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8f5065-38a4-4380-e403-08ddd8b680e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/7hdfl6bDhdJ29RqZVHWtNWbN6RvjrRjFB3wN25wIzxbARFjsn17RycWQ6j+?=
 =?us-ascii?Q?xIE6n1OKyh34y8HLwoQ6s6kwrQ+HQNKWEWHS441YEBVF3x8edSxs2ZGQ09sd?=
 =?us-ascii?Q?6hb1n1eLOi/UEg/LGcfTvkGiDKjineGT+ihNX/WqGL66RMSsWKpfeTtTA6vf?=
 =?us-ascii?Q?HERmAIsxibNd1zHTFsEihhnY16B5CSQuCGCulfWm1/vr/9zEVoneNSROFdk8?=
 =?us-ascii?Q?yrWf5grw63gsd/A9X0059lPPn3Ozf/nDaZCMwhWg1o5dT711IS9S38hbvWTw?=
 =?us-ascii?Q?j9F0DRGsb98wpxClrCETVWBTeg0a2pb8aR9yCjth78ssmwO7hfdUonfjTwdG?=
 =?us-ascii?Q?pDWqO/zm96h2BAtLeNLMCsHOr4vAoh9UlRG4uNmlyDqp+/ERoMCznwUrduTN?=
 =?us-ascii?Q?tfdd+2qTFPfNfOlP75QKzlX7ndyEEXPIrcF1lTti+XGo7rL9UgqOBEVF6ot3?=
 =?us-ascii?Q?gepJSffDZ7RemWsmF7pNhoBVL6BMQZzeafmcKPu6sa47sYR4tqA6f9qqgRcz?=
 =?us-ascii?Q?0bFVqnzLmyFmlShMx85a9JRxA1Goqz2rF2OsVe1Yn13xVYqlrRDcXucMbV3Q?=
 =?us-ascii?Q?taDxgWhi4/cLDWtiJlBrBBwVJ4BdOCx+0p7zbgl5dTTKwnHq5cQTqFBYEGup?=
 =?us-ascii?Q?3YooE0LFD6Vh+L0rUsA3DNvREv70OTGIbJXg74WnPn5Fjck/+AwTOFLBKFv4?=
 =?us-ascii?Q?5ehasO5zzsIUA7MpRrPfLJbM8IlukhUpzv4IgJpkLAQg8GjBW6gKzzaC65R4?=
 =?us-ascii?Q?maUcZRLMN2CBAzwbNOLP8tM3T87Vca1vmqwdr1U6PDOm2zIUMC4upORIs8c/?=
 =?us-ascii?Q?R48gIKFZZ6XVizXIE2pCXGKMcJVb7NlweFtoty2EvRrRJGHggYX+fBLvZDaO?=
 =?us-ascii?Q?skqemQG7mfIQKfZQxYKBTfOHZr5MqId9fRFHlZ/vZ7iobV6/s0zZjnQdUGmY?=
 =?us-ascii?Q?IiZQiXhb3x4SghzqxQlTYzztcTAZ6japJ9roP5z1kqVgaac7XmvZOJDOkoO7?=
 =?us-ascii?Q?+GR+yuf5vSdprm+diZZm2z9Tc/R9QIfSJ/RPSScmQHp0lj78aFk+sb60P+d0?=
 =?us-ascii?Q?SXq0WmRcpBGjjWcO/26RWypp7umrl5XnF+7Ik0bodcYgwjSKzXTZDl3tNc2d?=
 =?us-ascii?Q?kqZyB9QniWbxyF7JDNYsE7qrn77Lkn3Ap6RubKfR+Doi2opYkQFkZ3lGOwfi?=
 =?us-ascii?Q?rxDqoNCnFj74l01jPQ/Ds2hgpZZ/cvQVkcdMtMnm45e1ryrwRAsnb8ouPyF7?=
 =?us-ascii?Q?pGCsfOH1MixWqZTRI7rVal3fPV2FhW9CLmn9dp+0gUcJWmiiZhDL60bXySfd?=
 =?us-ascii?Q?m56i1/mBQrWc5Zm8WCzOPE/VCS+xQxuNIA4ERcJGlxP8xbyFMRbB9DSQi4Zk?=
 =?us-ascii?Q?lxML513N7E4CEYftIgxIhQDQnVYBovN2mZyEgB6nrRbQk1lJciDjbMDkYk/X?=
 =?us-ascii?Q?szHcUDlir+1upzsFXBtNPKbhzM+v9+iyGNxk+vv7h+aSsTloX1Y/xTDEJ4Ma?=
 =?us-ascii?Q?kCkWpBZKt6+FDULcMh6QFf4jbjEuEuk6FlDf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:07:31.4441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8f5065-38a4-4380-e403-08ddd8b680e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980

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
index 792f20888a8f..09e2ed2ae0d1 100644
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


