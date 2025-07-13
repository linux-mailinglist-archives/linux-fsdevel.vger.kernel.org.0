Return-Path: <linux-fsdevel+bounces-54780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19722B0327B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 19:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB4D3BB742
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91F27C154;
	Sun, 13 Jul 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zam0z5NH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA38255F2B;
	Sun, 13 Jul 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428951; cv=fail; b=mB2IEUkuGDi9EWyPSFukyJum1HhDzXRVv/h9XdLUEmylWi4V/TsQAqdh+Mi6g11yxy6ewRg1wDXBF0QSPsWnnUxzj2ArHTEEyq6XttZ2H1Jr2IzgwGM/ZyJvhpPesWwHbiwZdL2KscFrRmws6kNlXzZWQ+q6gh/U4ilAWdSD0iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428951; c=relaxed/simple;
	bh=GeccQzH+SB2nfgl2D+0SrQzvXZYRY45L6mIPASbrrCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0RQ+OOnpBYBGh1IukDVsmzaJdU4G0gLaWzMrTy701ETZpu5CXfLmj9O/8g7yIRvjLdsPhqIMsaLrF/jXawHWQD/6rGj+tDCWpJUsk7CaN8krkTszdgohXbJg/TaY3FqDPHzD3d1WR2zIhbdsAFg6K6ow+Ee3t2HDz7dqQMtqk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zam0z5NH; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+pugnGz3C0Q8fPKm6Pp7m12q895s3Xedjq0WXZR8mPQTYU1otmqr6kTlR4AZlpVCEnvevTxDbXCyqA9QLJXNdDAKiv3j0fab3/LipNd2NgYNNt6DET7PoRziDHHKDzhyRAx0cqE07zVXKkNJrqci9Haqx7zgAi08tRjvCqf+sNpgXIsCpcL0sKLVP+iHzDw292erzK+6c1uy6cumEgG5GVJtovJe8oyjSY04n9R7R0FfleK5boM2LetThCZfU2OIbp/Yn8j0zlAKC1JOJcKFNJulRGfSiV/IkT6T7Pi0+O9UfWm5LgXVqnvNqlfZvgVOtTFvbTpcjFr64EXIP9zHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRslfXg1FfLdRhN1RCeZhZ8lWrpPq+GzUdZBZnLnT54=;
 b=QwWjbK2hjM5OwIxa3e4JxUi5YhDRITw7sbkSD5EnXCcoFhgKbFUE7NpFmQLTgYlq/E1T0ODeSvQ8/3oKH+bqxQGr1SrYP5M9uE5GNkDre/I1qoKTV+67V5QXAJrPT4GerNVqZgNAtfXhIuBjwUT+qaxd4xK20IAjOea9DpAOKAlGUAyhTmiRFtxR1Dh9dfytX+lPsA9QO50S3qrqmU7NpiEuSlL3Rn4VXY80Kz+lO6puTiURAhxm/dEraHVJbCsp+axbt8ZDVXW9+znYnpYXVFL9ADTj2BzX77pp/5uIr/x5BXlG5dKNrvbYRTo7JvNrR3sLBVn9qvgFXjkitjTFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRslfXg1FfLdRhN1RCeZhZ8lWrpPq+GzUdZBZnLnT54=;
 b=zam0z5NHZ2R4lD4t5S1M23tmD1kEuU7dJB0RVSugGWaweBNzhZ7M4+nj04UCHZje/ZW5+C6XOMbvHiZBVVBA0wd+lZIS8Xw5NQZAnsak3U2qj8UJzNLZ00ZLfp++lF3D8CmnO6zW+TCA7e9hIFNMsRrxmE58HSvi+ywR3YV+3FA=
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.21; Sun, 13 Jul 2025 17:49:07 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::89) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Sun,
 13 Jul 2025 17:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 17:49:06 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 12:48:50 -0500
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
Subject: [PATCH V9 5/7] KVM: guest_memfd: Add slab-allocated inode cache
Date: Sun, 13 Jul 2025 17:43:39 +0000
Message-ID: <20250713174339.13981-8-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: e62adb62-ea74-4c94-0b62-08ddc2359071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xOonWxU5ZF3c0dlhJRyU1BinyNf9xhoXlSHz6qbfaGdcWRGhm1EzMyn5KYJR?=
 =?us-ascii?Q?cAHCbxnuUPpuM8I7m0NfDCT6In8dXwE/jUWSpfVNyrEGhCuxhP3h02eMZOk4?=
 =?us-ascii?Q?wpKhVh1onPf/Fp0o/uWrfZCJon7U86RKHjjkAO4z4Tfw7qCciVEKK+eud7Wb?=
 =?us-ascii?Q?Hz7LCj6nZvowQBa7jKikxDpcEEWzbHsmAUaqUeW5rguUCMxP8rUseyQ9kueu?=
 =?us-ascii?Q?BGGsbJyZVO6WRFjldrIrfh1XMwsMBVmtFFgS3kznRd4TJLnsmMpFX5yWFpPB?=
 =?us-ascii?Q?BzlEjLPS3x72APj4antFx9AEhWysmEZSNW3KNsAGar4nQnur3RHHRRZYLZrC?=
 =?us-ascii?Q?0GhNEz9611Qb4oKxd6i8m7e290xQmS29ATvqgvS14qaQVwERPbRSR/ftr3rg?=
 =?us-ascii?Q?kF3KusBW66i+a3ToFb8f0ssNuWWuBvEfk9knNwZgWRqWfujxCJBclVR7Nzm+?=
 =?us-ascii?Q?0h/bORCYtxg+gJxEmLMl/t9kqIPeQqvIJ7ZKANLn9v8wQTQTbCzyemTiG6ua?=
 =?us-ascii?Q?YTI5U8wQeDiEy6zL2d528GXSRFp+WdgnbU4vNqfw9NxUlRi6nvWxDGqWUW4c?=
 =?us-ascii?Q?vLvFl55Rv5bpznnywqd+SFxPyMAPKEEtJOmMNRJqFD9u7m8nzwV6K9lv2s7X?=
 =?us-ascii?Q?tAur11AehQouOpc66NGhW0YnxYgKOiOQBub9SAhOHB23CidOjxp544uPT6RK?=
 =?us-ascii?Q?drGd8eZU+1Fgvs+8LwHFLuCiJVNKcmD7eG6ougy2Us3Nenmx2yiYhVwEHVVp?=
 =?us-ascii?Q?D4CN+IjNE8L3Uet5skDQis/FUTWI7Xq0u1aozgbow88PBW4AK0t2Or9PD0PI?=
 =?us-ascii?Q?80MteGmyI8KphkxGtimYLsDQHKnMxgpeyJJVVtckSkTSBQLQZy8ELER6r+uB?=
 =?us-ascii?Q?YZGmK2d/Zfl7sAw7G4FQh9avzVCGrGDMd5IlfN9P1aPS4joHl8WT1nb4dlcU?=
 =?us-ascii?Q?1StNDa9B9Dp7YrW5eaKTskUR6DRZpJXO/IXXuDZzCWM/k9qHncvSsTv+iJzK?=
 =?us-ascii?Q?oZKbCl0uA2ADYVDCLndOlTkZTWYlfnrrv4ogDxJqMd9YICyQffWuDvasrx1M?=
 =?us-ascii?Q?Fb/Op8nmnlvwQS8mXli3kZ9h6k5hpSSURuwu8+WvpMcho8n0UhAu3ULm4Bzp?=
 =?us-ascii?Q?5sBklIwH+BiaLcJ2cBCnOFK+O+T/ZRnb9T0gMd5MZ5F6HuPBJ6d1/DzPg7Jy?=
 =?us-ascii?Q?pM51Tk19/KxRMv/++8rzqBlFLcuU++EgHLmMPtXaRyXPqm7xgY8cwIWFWbFM?=
 =?us-ascii?Q?XyyIz2P+2ujqwopj3XRxeOpLzyZovt4fUj7CNcxI6cHl9vgnpHxlAN5ZxhBx?=
 =?us-ascii?Q?qu2VeKzEk1+IEBvtSXWyHdWChbmaq0tSko5yge9A6rujU+izt8abslfPLLMN?=
 =?us-ascii?Q?AI+o7BhZYiooAfEqEZQcG/ib0WkU7WRgIcGN1NWqldjP2higC8NXyTOAAu6i?=
 =?us-ascii?Q?x2S5AhhOqMiBSssylTX8VREw7LwC1hOW/wT6K0h7EUCaiYgjKdNF3qPV3U2M?=
 =?us-ascii?Q?B+vhnrsdZR1d4pT4pkpnuPGp7jK8dzvYW45S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 17:49:06.7517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e62adb62-ea74-4c94-0b62-08ddc2359071
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012

Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
inode cache for guest memory backing, similar to how shmem handles inodes.

This adds the necessary allocation/destruction functions and prepares
for upcoming guest_memfd NUMA policy support changes.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 58 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index dabcc2317291..989e2b26b344 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -17,6 +17,15 @@ struct kvm_gmem {
 	struct list_head entry;
 };
 
+struct kvm_gmem_inode_info {
+	struct inode vfs_inode;
+};
+
+static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
+{
+	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
+}
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -392,8 +401,33 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };
 
+static struct kmem_cache *kvm_gmem_inode_cachep;
+
+static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
+{
+	struct kvm_gmem_inode_info *info;
+
+	info = alloc_inode_sb(sb, kvm_gmem_inode_cachep, GFP_KERNEL);
+	if (!info)
+		return NULL;
+
+	return &info->vfs_inode;
+}
+
+static void kvm_gmem_destroy_inode(struct inode *inode)
+{
+}
+
+static void kvm_gmem_free_inode(struct inode *inode)
+{
+	kmem_cache_free(kvm_gmem_inode_cachep, KVM_GMEM_I(inode));
+}
+
 static const struct super_operations kvm_gmem_super_operations = {
 	.statfs		= simple_statfs,
+	.alloc_inode	= kvm_gmem_alloc_inode,
+	.destroy_inode	= kvm_gmem_destroy_inode,
+	.free_inode	= kvm_gmem_free_inode,
 };
 
 static int kvm_gmem_init_fs_context(struct fs_context *fc)
@@ -426,17 +460,37 @@ static int kvm_gmem_init_mount(void)
 	return 0;
 }
 
+static void kvm_gmem_init_inode(void *foo)
+{
+	struct kvm_gmem_inode_info *info = foo;
+
+	inode_init_once(&info->vfs_inode);
+}
+
 int kvm_gmem_init(struct module *module)
 {
-	kvm_gmem_fops.owner = module;
+	int ret;
 
-	return kvm_gmem_init_mount();
+	kvm_gmem_fops.owner = module;
+	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
+						  sizeof(struct kvm_gmem_inode_info),
+						  0, SLAB_ACCOUNT,
+						  kvm_gmem_init_inode);
+	if (!kvm_gmem_inode_cachep)
+		return -ENOMEM;
+	ret = kvm_gmem_init_mount();
+	if (ret) {
+		kmem_cache_destroy(kvm_gmem_inode_cachep);
+		return ret;
+	}
+	return 0;
 }
 
 void kvm_gmem_exit(void)
 {
 	kern_unmount(kvm_gmem_mnt);
 	kvm_gmem_mnt = NULL;
+	kmem_cache_destroy(kvm_gmem_inode_cachep);
 }
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
-- 
2.43.0


