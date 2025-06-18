Return-Path: <linux-fsdevel+bounces-52038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7302FADEA58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209B27ADC2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810A02EA160;
	Wed, 18 Jun 2025 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fM8VtP/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442882DFF17;
	Wed, 18 Jun 2025 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246307; cv=fail; b=g8dzL1wDdSHLAw/p1B10AJ1Qx5HlzWDWfCYTwDcMXRXxIcJORDjL7lBVzkTq6Wt/p5A/dGlcd1cNuSuhm/sIgePrlGtBP/04dQy8Ec2uKyxFOMBEEGGsnbFvOnsT3PZWpdTzqrtUF1bc9cWMSM0U8d0kdlo0X2//K721DpzknYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246307; c=relaxed/simple;
	bh=NhuU8ppHG2STCJcBdjxhd78hD8i5jObNdOKIlpbKBDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbKxYfMYvx4tc92HscqpPiAv5LR4NfblDwTnqVQYf0wEtFmz4kCOu1KDtm/cvbkgx8/URv1ifNvLhyLrMGA04Jo6PNyAsAag1vrewgfTWS5CWIAES0Br6b6tAtme1Pg+IjyqO/J+gagAclBUcik4rT5Xz97hXPlyPK73B0D7bt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fM8VtP/0; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0EEAkLUcV1J0lhA0r/52NgO7vpW7jdWD5qpWyfWWJBlQmxU5F8ablvY0yThM6gwQhdnxY/TpMC7mKrlr+saAqZidRVyVzYa4mho34xuO4MbBKyGZkmAvUf3J1saCqHFmr0FWYOPZ3Gn8ILZhbNZzjZLrtlyCRTwuDn1RWdTlmjdVEwitv6UGO5xXUmPEWhLCoEZXcFwpe1niMnYXtsBxqYRvQDCH1jEDp6mgMm5+3de3/zsI4IJqPwnTjsamRnI4M6q4CRbPBslWJKysrcyoZUec3rBu291u1Atu0xiW5mc1l5ZzG9wzF9Qc3ommd4uCY9X+zJStr+TRunQDS2KcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/udd3S7OSs9ba5kuMi2wHriDONJNB4tzfZ126Bnl04=;
 b=GDambBnexJZOGtxRungd5MR1DH4PZ7idbB+hslQ6/ugkUKH3v1j4cUASUUi/HGbRRGhorPQp9L+BbpUdT5ZiOfNQsk3vx0N103tFdCWwiDQb3XmToFJr04zo11Y/49xpvRI4PbREyNU8HgQG4dGs0K08I2Scr4oWrU1Cig62vvlF3MVEOYGakhxPD7BWUHcJKXga5lEQDNp/LEHMgia3G1TAXfljCIDC4OMSmdIJKX8Ew7zV49LXSkmMQl9DZFPafQfrAJL5ISYF4cCS/QbrOGcB9AJK/8+cttgBi6zN1xsMKcLVDP6Sxu9rAi+Ga6TsxWiXYuW93JjPM7UEFnRtFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/udd3S7OSs9ba5kuMi2wHriDONJNB4tzfZ126Bnl04=;
 b=fM8VtP/0/v+ckL9EK1Ldi5pZ98Vi5RCmiWF5tPaRk0RVa0TBsUAOvFtkzuFXZbYfwAe0dWQ/dOWvLKM01f6ew/SFr9LHJ+fzz657i7g9qCC+h0Qe63N7BA39HAMdhDAglqMkxzoq1zyFxTXCX0up2GnsKVLjaYjRg2HxVWyJ6tg=
Received: from SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) by IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 11:31:41 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::1e) by SN6PR2101CA0027.outlook.office365.com
 (2603:10b6:805:106::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.7 via Frontend Transport; Wed,
 18 Jun 2025 11:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 11:31:41 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 06:31:25 -0500
From: Shivank Garg <shivankg@amd.com>
To: <seanjc@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<pbonzini@redhat.com>, <brauner@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <ackerleytng@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<tabba@google.com>, <vannapurve@google.com>, <chao.gao@intel.com>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <shivankg@amd.com>,
	<jack@suse.cz>, <rppt@kernel.org>, <hch@infradead.org>,
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
Subject: [RFC PATCH v8 6/7] KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
Date: Wed, 18 Jun 2025 11:29:34 +0000
Message-ID: <20250618112935.7629-7-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112935.7629-1-shivankg@amd.com>
References: <20250618112935.7629-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd81e82-2871-4cc4-0d81-08ddae5bb246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQUO9xLoZiW1LxMDt6SC0Pu4tB0MqtcQFQ1f6tbCni2e0QWkJgg4cGoH9SvX?=
 =?us-ascii?Q?dWZoHUKK95w0KQSqB2qM9OnjSh264fy0cUHSrlD66Td+QmzHz3bSc8HcvTq4?=
 =?us-ascii?Q?nTg63bKVy3/dRbEFL9kOJWTWU/WiJ+uP40zVAsv839uMAqR1TRHimssz7pGu?=
 =?us-ascii?Q?xzOYYxOCdTYVloOE4HeZyBdlsyGKWSR0L5lEpBg7zFPTJccgRUhrehPL/PgV?=
 =?us-ascii?Q?+0xw2cH25NAGfQtm8ENpx2V/pmtj3xzBjgnQJ49UAcXntxYxryFSnpeGzj2k?=
 =?us-ascii?Q?iuEJRgcmSihI9VYVVtzXN33uyZa+B02H1Yi4rew69G7wPXk067iGp9bPbtbE?=
 =?us-ascii?Q?RCWTjblnIpL26sCqBwYvDEAccQlO+wBJYCGke1L8eu85YxbboZO8RBKrExYT?=
 =?us-ascii?Q?MT6SllNVIG+F0zstl8+dCw/EK28UXQ7v6Y+11iiPCAhv93LRmFWI1sm3KwtV?=
 =?us-ascii?Q?y9ehlLfsYT8larhHBmE2aIy1K4QO3FuqGsdnWdij3OeEwhnwsUkWJAzZbLeU?=
 =?us-ascii?Q?/5HC/1XnYUQy89L3ypki4G5mmbyg7sgmD7U0r5bD0yGhYyDX0wF8Q1+DC1YI?=
 =?us-ascii?Q?55OuD5rHsLGajmBiu2R23YlKu12T7AB/lgukq+Y9KHD9nuiKpB4RjLUU1Kn1?=
 =?us-ascii?Q?QseS5xwz5rLfQtSn1btB85sO6JS+SsaRdBFV5kd4ffbWZxXSFWARK8l9X2eB?=
 =?us-ascii?Q?bJQfUvzl7xYAn39RnQbtudvAXhoFP3T4karoi/iqaCo3WbDMcHnRKRcQL0kA?=
 =?us-ascii?Q?JeQPnm/Bbrrw44Fqm06nSeTzpoq0WBejDBIU9lWYkKwhvJU9oAof5PvN/vCk?=
 =?us-ascii?Q?roco/BMchG9e1MCwaNFtFlxatcD/azwpwOCv6uwc7oYHTh8QdTd1sejCPQC0?=
 =?us-ascii?Q?kPledpOCemUeGL5d45tynMFUtYyUqNGtSMfMHrleUrBA6WqhRduWdbqauGkB?=
 =?us-ascii?Q?judxOlZypmZpXCDKSTNc5h93B6Fwn88XhVjVftxAftRBMm5bb+Xc4jKmHn+r?=
 =?us-ascii?Q?tpk8BfEKJK8Ps3ShwDMonnuFF4k/gaLqqolb1/icG8BjQqMk7KL3R4cIrN+q?=
 =?us-ascii?Q?IV/pet7J3ValEVne9xIA5yhmWsr/+j9q/xlZj7ukBuqDUAF0x0M56pvJI8aA?=
 =?us-ascii?Q?sOJnIUfRbR4UcPSE5ciw/dzspK5adwsUx0BBbtQiwqhhXvKF9QVbZUGl6Q6C?=
 =?us-ascii?Q?rJgF/RUUKiD7Og25QeO4oCato2cehz/7HMWSwp3lC6p5qUd5/uFb4ovKBMtM?=
 =?us-ascii?Q?6iq9nx+9MnfCKIZOl63B3L3T/oHPPmW/nO+VfWHDm3KR7I1g144xgPqdTiuF?=
 =?us-ascii?Q?KEI0moK2pLYS2s3Wk8ZWjeHQ0zolOJ/3LHs38B9ngudWn+cqFSmj5DX0RzLP?=
 =?us-ascii?Q?25aVXipCdvZWM7IM0TnCgqbM/5j3WVobbjPvjuST2slE8EgAR4HAxPgs/W25?=
 =?us-ascii?Q?gu3mz2mKW+Uhv8ifRZ39V8s46drhSfs3cbndzrgpXcu9kooNXyUqxolWsLX9?=
 =?us-ascii?Q?j58IilTTAXAgchE77Lxr4FoFNjQI72ZeCPNp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:31:41.2027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd81e82-2871-4cc4-0d81-08ddae5bb246
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

Previously, guest-memfd allocations followed local NUMA node id in absence
of process mempolicy, resulting in arbitrary memory allocation.
Moreover, mbind() couldn't be used  by the VMM as guest memory wasn't
mapped into userspace when allocation occurred.

Enable NUMA policy support by implementing vm_ops for guest-memfd mmap
operation. This allows the VMM to map the memory and use mbind() to set the
desired NUMA policy. The policy is stored in the inode structure via
kvm_gmem_inode_info, as memory policy is a property of the memory (struct
inode) itself. The policy is then retrieved via mpol_shared_policy_lookup()
and passed to filemap_grab_folio_mpol() to ensure that allocations follow
the specified memory policy.

This enables the VMM to control guest memory NUMA placement by calling
mbind() on the mapped memory regions, providing fine-grained control over
guest memory allocation across NUMA nodes.

The policy change only affect future allocations and does not migrate
existing memory. This matches mbind(2)'s default behavior which affects
only new allocations unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL
flags, which are not supported for guest_memfd as it is unmovable.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 69 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 5a1ce6f5e287..2bd5ff3abd87 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/kvm_host.h>
+#include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 
@@ -18,6 +19,7 @@ struct kvm_gmem {
 };
 
 struct kvm_gmem_inode_info {
+	struct shared_policy policy;
 	struct inode vfs_inode;
 };
 
@@ -26,6 +28,9 @@ static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
 	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
 }
 
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
+						   pgoff_t index);
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -112,7 +117,24 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
 	/* TODO: Support huge pages. */
-	return filemap_grab_folio(inode->i_mapping, index);
+	struct mempolicy *policy;
+	struct folio *folio;
+
+	/*
+	 * Fast-path: See if folio is already present in mapping to avoid
+	 * policy_lookup.
+	 */
+	folio = __filemap_get_folio(inode->i_mapping, index,
+				    FGP_LOCK | FGP_ACCESSED, 0);
+	if (!IS_ERR(folio))
+		return folio;
+
+	policy = kvm_gmem_get_pgoff_policy(KVM_GMEM_I(inode), index);
+	folio = filemap_grab_folio_mpol(inode->i_mapping, index, policy,
+					NO_INTERLEAVE_INDEX);
+	mpol_cond_put(policy);
+
+	return folio;
 }
 
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
@@ -375,12 +397,52 @@ static vm_fault_t kvm_gmem_fault_shared(struct vm_fault *vmf)
 	return ret;
 }
 
+#ifdef CONFIG_NUMA
+static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+
+	return mpol_set_shared_policy(&KVM_GMEM_I(inode)->policy, vma, mpol);
+}
+
+static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
+					     unsigned long addr, pgoff_t *pgoff)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+
+	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	return mpol_shared_policy_lookup(&KVM_GMEM_I(inode)->policy, *pgoff);
+}
+
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
+						   pgoff_t index)
+{
+	struct mempolicy *mpol;
+
+	mpol = mpol_shared_policy_lookup(&info->policy, index);
+	return mpol ? mpol : get_task_policy(current);
+}
+#else
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
+						   pgoff_t index)
+{
+	return NULL;
+}
+#endif /* CONFIG_NUMA */
+
 static const struct vm_operations_struct kvm_gmem_vm_ops = {
-	.fault = kvm_gmem_fault_shared,
+	.fault		= kvm_gmem_fault_shared,
+#ifdef CONFIG_NUMA
+	.get_policy	= kvm_gmem_get_policy,
+	.set_policy	= kvm_gmem_set_policy,
+#endif
 };
 
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct kvm_gmem *gmem = file->private_data;
+	struct kvm *kvm = gmem->kvm;
+
 	if (!kvm_gmem_supports_shared(file_inode(file)))
 		return -ENODEV;
 
@@ -411,11 +473,14 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 	if (!info)
 		return NULL;
 
+	mpol_shared_policy_init(&info->policy, NULL);
+
 	return &info->vfs_inode;
 }
 
 static void kvm_gmem_destroy_inode(struct inode *inode)
 {
+	mpol_free_shared_policy(&KVM_GMEM_I(inode)->policy);
 }
 
 static void kvm_gmem_free_inode(struct inode *inode)
-- 
2.43.0


