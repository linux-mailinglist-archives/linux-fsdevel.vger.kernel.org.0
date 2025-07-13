Return-Path: <linux-fsdevel+bounces-54777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6E2B0326D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B933BB1A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 17:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587A02874E1;
	Sun, 13 Jul 2025 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HIOFSBOQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F10367;
	Sun, 13 Jul 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428908; cv=fail; b=OUqwJuNOVtLtDJYd0J+jbL/nHiPAlBx7oRPCnHeF+ZurERR0TtIW0cdRqeniqVt9HXXVfrz0rnhXjDGqhNybDvvmmJ3DYrMEik+/VBqPU0G5gN7U+LyBHOGc2kKTO38AFHRQgVuoqoc6JCE9vosYH8HO5pjGZ4LBsz2qAqa/29U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428908; c=relaxed/simple;
	bh=D+6JD409pVb+77Ug+MkNP2edE5kvzhjFRxqnbtguMj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpX+mlwxZ9OrvSNMd4NGBhSfjWqBqf+T1/9EhGjeVmh24M99WJNdtgYPmGhTdK4QapnWvekJZ2Zm1A50iE8JitdcDIV1ejVDOkemurxZYz4J62NtKXa7tde6m5J9MdQR/HKc1GsThs8gbK+LkW42Ih1QZrd6cxQhJn92tgiXwqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HIOFSBOQ; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnvvPwVn1ezEbH3gST2VXReK64KxocDBmKm1oQGW1OtwZUZ57p/yfAy2tjYZOiApgR/7hN4NEUQ3cTr4GF+e/sXE5cGZfAVIWBojaDzDBABinmqTK2Gfem2gKwOS2nVFiBOx/3mn87J5H8Na0pLEa70GyVsKmUnlAy27+oDldos+ZOZdnkODNJW6gdODc66GuMlx/h83hzY+vBDy6x2BehmrJYPdIzr5CSRnD7xq/UKw28Uavr7cHNmP314iWFPhObhtR8DlrS4fk+TdWxP2Ed5d9aZ8lKRx7XxJBB2aLJw/2/UC8NEgDZsgh6MkuG0EKawNWPZWMetgRrfKvCwxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBfZ/TZ4VBwWXgzIw5njBfpLgomVCPsMziWmRrKE2V8=;
 b=E3dXrOsZqbn3NJm8NDUm0hENXZFu8R4BY/27fdzR0/0PAvzEI/HA5eNMwGxnuFofleZ3XZHaIC4fp+SqWb7of5TDEdBeS9MlNg/tEyONT/z9+548pS3NksjUA3P9r/sE7oqRIqt8UFljDohSA4v//zwL/LvZtI/9UkSkaSTPEWcfx2GT4/4fxqGyEQfVRSQ4bbebJfNZ+RwI7gHxd3F2hf04YOVHGfkqLB1D/N87R/WhKyYsaab9SfaHkjtL6Mi/rGjYPGjfJtoahCC9JrQ5ALw+fio75FGq6KWcb5QOOmLFCukMGl/2m8IQy+CQiydkDcYHhtnOIzvtQyqG8mJIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBfZ/TZ4VBwWXgzIw5njBfpLgomVCPsMziWmRrKE2V8=;
 b=HIOFSBOQcCCc6TKNuNE5U6/J9qX1PLkiy0ccUtgpf3o/9YKbE3WmjhBNyqp5Nau7ONY1oz5Yb/OYS657cSRN3/NBRKQzmVjHazj1aCaGUgRkVR97v1rYTgnaDXKaYBcIxU8ifKScL4gbz7/rDHJAZLAOguSHTBVdxrste6kt6oI=
Received: from SJ0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:a03:3a0::33)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Sun, 13 Jul
 2025 17:48:21 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::b5) by SJ0PR03CA0268.outlook.office365.com
 (2603:10b6:a03:3a0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Sun,
 13 Jul 2025 17:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 17:48:21 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 12:48:05 -0500
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
Subject: [PATCH V9 2/7] mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()
Date: Sun, 13 Jul 2025 17:43:36 +0000
Message-ID: <20250713174339.13981-5-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250713174339.13981-2-shivankg@amd.com>
References: <20250713174339.13981-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 313ac2aa-23e0-42f0-5b78-08ddc2357544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U5YA1zd76wql9WaDp4opB3ZInqs6GB8yMC3DxybFo3n9qWw25XD6i0pyYbWm?=
 =?us-ascii?Q?bcUbXajRi8suBBatXFqY7BdKXBjIFVd5Njivkt+oPiIca4JdPEh/6J1M6RCP?=
 =?us-ascii?Q?eTiQU/cS0VihqaLgT6dFcmoqIHQ8dXZrqYKXJHQYzVcwQmpq8avjGuoMKnsA?=
 =?us-ascii?Q?r8NIPN9Q9rd0mHG8P8mcsmsoT4ScTA2iW89qQD6MFU3/I0prIyfXu3alasom?=
 =?us-ascii?Q?wnfIJxNbLc368OJg11XqcvzPJNAJlQw/fRzTXAN+V1pueX0/Z/UDP/6wDRpB?=
 =?us-ascii?Q?ZdfWMM8FAYT/mEwmf5EO3BCH4jZQerIngL1Ad9EXzcY1Ihls9vUeXZowKtXH?=
 =?us-ascii?Q?uNXfJ3KXWLrbe3bMjS68HzcaLXXRI8aQvHhJ8sfLjDJhiC4GFLR0t7XF8ssc?=
 =?us-ascii?Q?YiV1hgvI4LsAHdsQL7zMPXwg3Vm+a+2DEkoPKHmjcuShXPDT4XCY0EvSYPnQ?=
 =?us-ascii?Q?bQPLNLjdlO9HZkyBOxlJcnsvUysY/tsClnfyRW6v8TXGCsz7T9YSCpgAubfe?=
 =?us-ascii?Q?J2fLgspc5E4sN2ZV/m6rnElkEpbTv0sPlvwD08Zi6ToEfKWjsq2TVobL6KbB?=
 =?us-ascii?Q?Acsauo8UU/VGcotjFcsCpA91roNMMnutfQZXHTOrQAeZaEVvcYbryHvTwHsv?=
 =?us-ascii?Q?KcQWVOLLFDC2bEsFD1hMgkvpQ0/u+iVtSKSI2EpPk++MJCmVtbdxQyjUu91+?=
 =?us-ascii?Q?ONjDNt4oJTqDWPHBy37bkp0waD9zDfrWlPE2zbpyNscdLRC5G87XV8ZcNUI4?=
 =?us-ascii?Q?z888QeVpu8plnDKpKQnG/UIq6GuHE/erEvpSJuYU+1UUr7W3YpWbMseOKqPR?=
 =?us-ascii?Q?p6t/Q4R2Tti3ZqSuOOC0Nb3CfwlvMSYpkwLw50b3bn0DY7raoCbGvHMkeh47?=
 =?us-ascii?Q?cZqRoKWHloiEwLAQ16UroJ/bWKl4k5rovhm4rxOeFl172Rnp8CUSenDoWkkA?=
 =?us-ascii?Q?wqkoVpl2gqPa0LCw5MA2qRYOh/LzH04uvQs3rliPjW8CpFsEHDXXx0qoCwe7?=
 =?us-ascii?Q?vGTCsZak0AzYvuqxn/HMN0NVB62YrJoqPAski6tQbKBihDvPfmlNmNZeNpUJ?=
 =?us-ascii?Q?D7i5q1b+lQKR/TPitZ1F7JgFbUVFKE16net9MMEPVgio4f+ncLSXw45JH5zk?=
 =?us-ascii?Q?krEjObSxdJwecf3xJtEAM99HrWzLDPdnAcy9rf9NNNfgd3qGhkN0FcYwZv1K?=
 =?us-ascii?Q?a1kerLSp6je7Y526QGqfJ6em6fPQuWshWVhdQrrdX7xBdtHOfEQ7HOGT4UB/?=
 =?us-ascii?Q?oc1XR5b71gfNZ5rLVSw5U6jJIR6v0biZMDI00yuQSXJpj4lE8PsHu1xkZ1X2?=
 =?us-ascii?Q?mNQu2rftt+cN/FIfWEFzxNlpVjEOxYEdmzQ3iQoB2Lg/3jKWWX3Dw1VBChy0?=
 =?us-ascii?Q?Yq8RAgXwo8PX909PBUZMYL/yPf+LoRlS8lPKINhXKYomiVby8WY6p3HOxB+F?=
 =?us-ascii?Q?MTccZQk7MVxLks7g9MMXrzNPA+Xj/p/Q6wZEN9UmXfg+P4934iJxbXLhNxY2?=
 =?us-ascii?Q?w3wfRYNdL9Btn6UpgXcPAzIGm1ubIXN2d88i?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 17:48:21.1599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313ac2aa-23e0-42f0-5b78-08ddc2357544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Add a mempolicy parameter to filemap_alloc_folio() to enable NUMA-aware
page cache allocations. This will be used by upcoming changes to
support NUMA policies in guest-memfd, where guest_memory need to be
allocated NUMA policy specified by VMM.

All existing users pass NULL maintaining current behavior.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
index 66bacdd49f78..392344232b16 100644
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
index 48d07939fee4..a0808c8f897f 100644
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
index e3f28a1bb945..f9ce234e1a66 100644
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
index b3c1df93a163..7ef937dd7624 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1942,7 +1942,7 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 		return;
 	}
 
-	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0);
+	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0, NULL);
 	if (!cfolio)
 		return;
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e63fbfbd5b0f..78ea357d2077 100644
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
index bada249b9fb7..a30cd4dd085a 100644
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
@@ -1977,7 +1982,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order);
+			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
 			if (!folio)
 				continue;
 
@@ -2516,7 +2521,7 @@ static int filemap_create_folio(struct kiocb *iocb, struct folio_batch *fbatch)
 	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 		return -EAGAIN;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order, NULL);
 	if (!folio)
 		return -ENOMEM;
 	if (iocb->ki_flags & IOCB_DONTCACHE)
@@ -3853,8 +3858,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
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
index 20d36d6b055e..0b2aec0231e6 100644
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


