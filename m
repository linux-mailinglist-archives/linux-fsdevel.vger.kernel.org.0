Return-Path: <linux-fsdevel+bounces-54781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B2AB03283
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAC4189CC1D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A52882A1;
	Sun, 13 Jul 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J3uu+g3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1390285404;
	Sun, 13 Jul 2025 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428969; cv=fail; b=FgPDAzTMZRAlhBhoNlFhUeuVG+uwNs7sCFsxnDJa+zBQPul3MtqTRmaN58DE/qX8OUnJZ0IToh3FOJb6uF2L24inzbg13tSYfZSo6y8h7FyagzIFx6t6x7IteYtP08O2X2CaUua88s/gTHkhpSIuVNL7z9+NB365oRbFR4uUXO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428969; c=relaxed/simple;
	bh=K5R53kNZctp42Ea1BvF3uyz0pmM8QiNJFYHUFaHns3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmKkPnBV4gUacrSgNFKlUdibgmxvBQi6i2cqZnSMgrs1Y0WZKCf7kdNXOBBPfwwHsza7qLMH2x5OH80kn4BgQMkmqgVRLT0WVumm04+oFs62BTNV8UcdeBDE0ShGBVNk4jy7wS3LcAbQli3JGwXxgPYtBPN8EY2SGvuAxi4P6c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J3uu+g3W; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUaQ2APsMnouUCuxWGnmerQcajz697Ad8LFu1ZWIiFsdHMIRDl/7yKKzhZbPqSbv8ORjOoCfjV4K+Y38NQ4BydTt330xeVLUc/my4KGYENL0r83ArvRy1JioNsPVv2t2/JOFaPFTpjTTEAiK/1qBv0ViwZlKCXk3iaYTs6g0NKji5M90B/UTYL4vqPbiHKzMNWUwTBU14iW8CJhPqmEu54+PrnJsfF+WlZJrwAcrx42JdUIxmO9e4wzryhXR17wpAg8AXAvPAV9LxpQ2cPpmSHDa0sVg0Iete5sHyJIGx+suO1HJAQr1fwqKKf6UhpUil0pzqey9HWPWBcTZsCc4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/Wxln1Nupj56Hrkb0yr1rSSkEPeB3D7ncSOmQaDyy8=;
 b=PfwhKmbrvU+Rd902iJOhTCGfRABKI5Rp1/cEmaoCK17RLZAv+XqQl1CoC0G6fNAnqkeFrp4kSjZ9LMnTkDQwbmBKD/RgKI8VpHRXrYKyfa6T2uJj19/WRBotUVv6gCciev/5Rl7+fO98zmZTSNIMbUbnaYjMgDAdDl/5WpcNou+XuTalm9KiVdfKWeB8oN53KKo7yLlrJl3KFMuMvjLfLD63Sqc6n6eaSIr68aQ9CLd4nEFYIfbQOVJ6SQhm7ziQ7gCCxkpsxOiF0n+QL1cKOfKSMvzhVtDB/EZoZ3QfgPpLGMoaUP5fIjvMbeAlmArejCuOUhsNTN7m/7isYmtiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/Wxln1Nupj56Hrkb0yr1rSSkEPeB3D7ncSOmQaDyy8=;
 b=J3uu+g3WwXDLGweo32NsipREJpvS3avjZE327jdJ9sYfMISXtYY5k1dXGE/EimwLV6xwGcsHfumBmehQWWuHtophI/idKOwTP7wkvc31hSfsb5sLoEHudlcQoEV2yj4Vf5WPRqwMOZ7w55dFEuzRnvNDjbktHhA4ZHMA096UvL8=
Received: from BY5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:1e0::18)
 by SA5PPF7D510B798.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Sun, 13 Jul
 2025 17:49:22 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::79) by BY5PR03CA0008.outlook.office365.com
 (2603:10b6:a03:1e0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Sun,
 13 Jul 2025 17:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 17:49:21 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 12:49:06 -0500
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
Subject: [PATCH V9 6/7] KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
Date: Sun, 13 Jul 2025 17:43:40 +0000
Message-ID: <20250713174339.13981-9-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b47af5-1b3a-4528-8a3b-08ddc2359952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yhEfXwqgAs4S/jaycdYsK76j4Ndvldl732s1Q+KatS2SU+EJgbKQQpkUiHAi?=
 =?us-ascii?Q?YNqRqdGtkrAif2MogTldgunMVxux1SN1Sb5iQPTXnQub5tY8Cdqmngc2MU78?=
 =?us-ascii?Q?UnZzo9DoElHm1qqu9KEUYYoBLd6g+CPrpFfyWXSykpDQDqsWGp7olYY/636d?=
 =?us-ascii?Q?TC1AMroJC29VQl2iRBCcUUH9RQ8tiRsDBvnZc8IZolAsnHdZZ2+iILbfjIgY?=
 =?us-ascii?Q?qy4/NoHFPTEeDkrZlSDfYGaoYG636exNN06JtRCKIvRUgI4ViLp/ZHgUdFho?=
 =?us-ascii?Q?lIblMufpG0I63HAfz7ygC/XjTl5Db8IVHhI4jPZDvQN+iyY++ixzHEgB9dnn?=
 =?us-ascii?Q?33Abw1LAhMp2aRizNrIJ1eSgCj0JAArYf5y9ie9Ee5Tn2DZBedfOUeV6S9yr?=
 =?us-ascii?Q?Rp53E3dvyH9Y6piV3jwmtp4pFBJiQhlK+Fn+8BYa2Zzi7R6pcAzAbIpb68AY?=
 =?us-ascii?Q?dEVEjMPEqQ+7wz5FUcs0kM4PZcAZQEPDVp2fr+96V0D84VNBV+qklUlYANCW?=
 =?us-ascii?Q?YeEnNmi3IJMylCnlscOHtXXm2OJYNno7iysdJGfsakCtN+EOfwH4lti3fTYf?=
 =?us-ascii?Q?4hAsceyQf0OSyM/3y0XrcLJhdMarU5c3/uLNog8WnLDC8Gjs76uANRfmhtBE?=
 =?us-ascii?Q?+so9n0VUwyT3UjR57wPd/qDPdTj72k+Yr1aC47rBVczGOI6DTO9soqLyyFXt?=
 =?us-ascii?Q?L2EzizMaH3q5cy90EUNIG1Ns5oMJXc0SROCf6+JL62Yfa4QkBUsHaVPWFIcP?=
 =?us-ascii?Q?k2uilOlUTkhoo1unyuJr6X6NLr+7NPHR7PTljzry0yLGOYiUKeu8S7xROjSE?=
 =?us-ascii?Q?XOtubkAKTkzGe3r7/VM4f7q5poSOyzhN10zjcOhMLPlZj8GucNB0lqpVc9uN?=
 =?us-ascii?Q?pZ4W5Vv9XzP644RanTH2JYYMna5yMMILUlZHnhblxr2sy6+f7lhyYElxDBUg?=
 =?us-ascii?Q?jql4Ke8d06TzwDqP4gj6Z+Y8k6/LkPkNo4z+t42lJuKZrcOIN5TvO/0J0DtY?=
 =?us-ascii?Q?F2RVljNHZuXKYmMEvEt8uoaoLTxGRLOuhhvACSG6nWVGJ3omdHIJuJwvRLMJ?=
 =?us-ascii?Q?06Q+8eBXnlW0TfYIKp/OWlETu2nvmOj9NkFO9XY+AxzLNhdQ+oEIg4I0sgx3?=
 =?us-ascii?Q?qFj95YAvkyoXMkQwUkRC//wYid1wLE/qF3Jz4JZL0CzSegrPXgWYsGMg5vCm?=
 =?us-ascii?Q?gsfeBdMMtTPazAQSWgLqbTi7n86LDCiD+MX7RVjwzqFijA5Qw1UKB3Qk0Tfk?=
 =?us-ascii?Q?XAR7uCsAZIqd7Il2hbRclYmD+qR+ZcRj/10PCkqACzOVW34hbzeFdwkMlgKm?=
 =?us-ascii?Q?V+8LWNSOVyz4aDbMpcKs5ry2bofcvBIonON+wEpdop1vlB4HBQqvbgFKzPGZ?=
 =?us-ascii?Q?6z56Gfbmv3IV5Y7pqBFT9xN1o3PY2Jt50ETI3ram8vbVaBtQ2rCV2js3RTUG?=
 =?us-ascii?Q?yQlhWoGIpBs28GMwbI+/6vlwyDuNQ/pvtKqrvng/kSoFQIYokKoRlQysURtE?=
 =?us-ascii?Q?UM4v2r7Au9KUOAa4y09C+dBUH5ZXhF7yDK7p?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 17:49:21.6516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b47af5-1b3a-4528-8a3b-08ddc2359952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798

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
 virt/kvm/guest_memfd.c | 67 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 989e2b26b344..5c9a5eb5c13f 100644
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
@@ -112,7 +117,25 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
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
+	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
+					 FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					 mapping_gfp_mask(inode->i_mapping), policy);
+	mpol_cond_put(policy);
+
+	return folio;
 }
 
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
@@ -375,8 +398,45 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
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
-	.fault = kvm_gmem_fault_user_mapping,
+	.fault		= kvm_gmem_fault_user_mapping,
+#ifdef CONFIG_NUMA
+	.get_policy	= kvm_gmem_get_policy,
+	.set_policy	= kvm_gmem_set_policy,
+#endif
 };
 
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
@@ -411,11 +471,14 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
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


