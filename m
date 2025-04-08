Return-Path: <linux-fsdevel+bounces-45973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC24A80036
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8020B7A6341
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CB126AA92;
	Tue,  8 Apr 2025 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O6TiZZy5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23244268C44;
	Tue,  8 Apr 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111534; cv=fail; b=Rb+KWY/CiAMEMaGsiHcejzlhBM300RiMrCTPG/diAEr4NyDDgDB8ZcrDlPgNBMxmErBi3oF2DX29R2JiKmNfoPuVVhSqZCKkO/2NLZEzMNns1lFFGzK+4ycn9dpL1+fM2YlYzG1BvUqUpdL47t6lGJyu3bRvkJjiuNQdb/uUsLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111534; c=relaxed/simple;
	bh=EwaFEG3JQTp6E0xZlyqRkKNLYxJYCe9FwQlBWoqCH7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h54mTJS8qHUIUzXW49cgKuAp1S0pmkv5Gz4n+KY8rq94rzSR7pHYMoMjEZjyJCmEpDf4TUrenfYbT/uzIkh9V5s/87849CvjilcnUgjFwZ1Nu7dKWjdshM2dyQI+vmIgvnVyMfqZbJPMN2+Q56nGq40mTWwGvyrCihkEbXJbIv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O6TiZZy5; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smXqU575NUWKBZcow1YOQOn/GTFGxjlktBcLnju2uj/Opsw2m2DJMGyn4eyZsCuvFKJfqq2JH/f2aVpoFkvyALD5UdsAfgflbzNuLDV2p2iitTf2JTEuAnsnQp/5fvLbu5T50asJeBc2hWs/Yu5f3hfhkVtHsPrHcbroDGLMeXVQeqIb8qDEcH9L4Ls+4YQuK7BJQ3foiwWzO8eZSdEjMUFARPlM2h4wQtzXzywYVik0FW4ke7Mg58+UDlAKTfjCwjOQt4MTct6EoyHEb8o/7D5g/MH3qblxBrJQ8DCkHiHezb7w2ZErFrRprJiBSV6FLHFb6gJs9RtN0hklbSGnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNHDj2125+dfDw+HUhTFnCp1kwrnzIBV2zrPrFVna80=;
 b=bMhZp78jm6lo3lTU0TjRitYVBwvCBXCvH7l/3d051tPJBdCTomZK6etDx+Bu23fj3wRMwXk5GAZD8UNtCIGg1KRjCLvApfKyrRUq2/P6a6swJu83XWk6tF2JZADDPSqNY3Kj6eCPToZ4HXpWuuib/yM+gb5hFn0lEzKV1px8ZDYCJVY12oreJDol6C25fBf2rR7oJMOwlO1LdxbOHAR2V4KA7VTgTA5VkLFwVkEWpTxqG4AsRKVf3rpb9h4ehsTKWzjoNURowsFRfBkiY7/Xzw/Ea4Yd2xByl8jYEoIaibiVUcdeCWO1GrDBWScMG/l/gOHINvi8Lhpj4PwLbj2cqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNHDj2125+dfDw+HUhTFnCp1kwrnzIBV2zrPrFVna80=;
 b=O6TiZZy5VdtAaPuk+NOWi/zGH0nrn5ivHJqm3U4oT6zaAR9I+N/aUdHyTbn+jQgkqGTVT9RDWPrRT0PxZHyCws4RCICHnGs02gYxfwNwz2TDd1bxG0tPYCXpEoXg3PG42KfxqBl8byNTneCIAwB2UILKwUzjVX+IqYQ90lA5AbA=
Received: from SA0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:806:130::14)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 8 Apr
 2025 11:25:27 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::6c) by SA0PR13CA0009.outlook.office365.com
 (2603:10b6:806:130::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Tue,
 8 Apr 2025 11:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 11:25:27 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 06:25:18 -0500
From: Shivank Garg <shivankg@amd.com>
To: <seanjc@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<pbonzini@redhat.com>
CC: <ackerleytng@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<tabba@google.com>, <vannapurve@google.com>, <chao.gao@intel.com>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <shivankg@amd.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH RFC v7 6/8] KVM: guest_memfd: Add slab-allocated inode cache
Date: Tue, 8 Apr 2025 11:24:00 +0000
Message-ID: <20250408112402.181574-7-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408112402.181574-1-shivankg@amd.com>
References: <20250408112402.181574-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dba5d47-eca5-4a91-3560-08dd7690101a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0f8g64D2wBB49I2BD7jWy4gneIROVMmGGX2osLwq/NrtHC3mk7f0QVFt6TXQ?=
 =?us-ascii?Q?ik/2Wxa0d/bQvwiFP4E5IUCferrMnHye13KacdohnTLaFWy8aO/wmwmAFCdK?=
 =?us-ascii?Q?KCJjsF0PMzKqR8KaDYh/nW1F64YHIULh46xxne+zRf6Yapej4T+GaFXUCYUs?=
 =?us-ascii?Q?z7skSWaX9BuQdFoWxNRwTwrXnHMXfxqLUk024PHs+Gt0Ty8oVF0hnOZGTj6b?=
 =?us-ascii?Q?NeWwYQrkYnPV+zbBgbY18JxPehDN2FWEBtUTQODbS6zxxuYmEk5VKBDIlSJf?=
 =?us-ascii?Q?U7mE5ngar3XKuCicM+FzTUJ8jTOmNG341DeUkLkZYD0F80NcIRkkrQaDMmC8?=
 =?us-ascii?Q?XEj5IeftWxPOjdBUmfDN24xkawND3jVq27oZAIiyLFpnPLV4CfxKseK7Zm4H?=
 =?us-ascii?Q?fouSScTOvVtGm1S5Dwa2S10GPcBA/2pP1qsxFClhv1CEJbxXw3/yBZHcNM0T?=
 =?us-ascii?Q?OOFF6YVV4cfj1NasLq3vi38IgxbckrKs1Nw4bKwB9EMgIrZDB2SbNzmgghW3?=
 =?us-ascii?Q?OZrUkFm2vAhaP9FA+dwx9RErugIQaPCG61Ik7oxcwmzEgXbhp2jYh/We35xU?=
 =?us-ascii?Q?Ax3k7D8sRV8F5E2vAzw7CmSgmNLQ2cO2JykH/n8CDnnDPBImx/HmKHJE94rg?=
 =?us-ascii?Q?qwwYAI+CyMKfuyPGS7gmMNfO2Brw1PKonKwoj+a5fCQ8a0IyWPOljALfmkp4?=
 =?us-ascii?Q?txmeZ1UNs8Ro4Mr1704LIox8ogizboLr/2t/FbPnMKAiF1XrAxbckXw0vrJA?=
 =?us-ascii?Q?AZeywosr0tqyiF4olmPawzHjwR/JnGWvEI19JqYoKnwLIiIOE20cK1dcmrmu?=
 =?us-ascii?Q?C0rTQ2j1nvPrHfK3c1lyxzMGX6X/97fmPY8G+ccE3jzuchCqenltgXjslid8?=
 =?us-ascii?Q?/vc6ovA+oNjAvoJgXpYnzSdDlgyrqjIGm/qg4gJf6WIZL23ABMOA0Ork4gry?=
 =?us-ascii?Q?8YhCJMluxVYn5ltMORqTJ279DWlIbJUni38Ig8ds8zPnKG9YYf+1NqXX2U5N?=
 =?us-ascii?Q?9lLdRo9Jsd5Axlef0cAdowzOU0QD9RE+tcdDHm9nxFTmFm5Czj5kPy5EqVQ3?=
 =?us-ascii?Q?AKFJteUWQyQ7n6WxBsrtk52Rnvlhqs6+GmoWz244I4R0T7PuUwIOQC0f8ev3?=
 =?us-ascii?Q?g0e9NOnpZel2JjAblkLOl0o/fy51qyoiSUQBVKjYKr7wmZBYCgN+l/Us9dAX?=
 =?us-ascii?Q?1ug8/84qgw9FSiDKt80/XBUP1QaHtbba2hW4t03hoJsp7vD4ZL2SGyzus3EA?=
 =?us-ascii?Q?OkEMBTmoEt6wQ2f9bi7HtLbOm95FzFGKjZlOVCEh5y9WP5k/FZcuV3EJoKnq?=
 =?us-ascii?Q?P2txOptVWphz2Q6T+cJFaniNzLdOmdyYUFAG35TWB3FjOgQoX5TaDWEZHMIK?=
 =?us-ascii?Q?VNuTI83lDufkuhRYLY1jHn0deOH5gUMJSLK8/MhpI+dAjq/jP4VTwE++nzoV?=
 =?us-ascii?Q?Ebz7qJDewfZkGf4ssxWpWd0DBN12IDuoq/3cUaeFeRr5xeLuDrerpYynXgVC?=
 =?us-ascii?Q?6owCSY8+uCpzdtE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:25:27.3374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dba5d47-eca5-4a91-3560-08dd7690101a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184

Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
inode cache for guest memory backing, similar to how shmem handles inodes.

This adds the necessary allocation/destruction functions and prepares
for upcoming guest_memfd NUMA policy support changes.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 002328569c9e..0ccbb152483a 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -18,6 +18,15 @@ struct kvm_gmem {
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
@@ -317,8 +326,34 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
 	return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
 
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
+
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
@@ -355,16 +390,33 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };
 
+static void kvm_gmem_init_inode(void *foo)
+{
+	struct kvm_gmem_inode_info *info = foo;
+
+	inode_init_once(&info->vfs_inode);
+}
+
+static void kvm_gmem_init_inodecache(void)
+{
+	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
+						  sizeof(struct kvm_gmem_inode_info),
+						  0, SLAB_ACCOUNT,
+						  kvm_gmem_init_inode);
+}
+
 void kvm_gmem_init(struct module *module)
 {
 	kvm_gmem_fops.owner = module;
 
+	kvm_gmem_init_inodecache();
 	kvm_gmem_init_mount();
 }
 
 void kvm_gmem_exit(void)
 {
 	kern_unmount(kvm_gmem_mnt);
+	kmem_cache_destroy(kvm_gmem_inode_cachep);
 }
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
-- 
2.34.1


