Return-Path: <linux-fsdevel+bounces-45974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C5A80121
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27ED460B60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F95826B093;
	Tue,  8 Apr 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5cgOQipR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025D2690FB;
	Tue,  8 Apr 2025 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111541; cv=fail; b=H00Y5kzQC/hRFwZNrwE2P5UurmjnFtL0B/jjeUOcIxh5Ta90t7hwdwtud6ffrd/H6rgp0fKCirrvtTzG0F1NqJnwWX5pH+gfR1g1lu/e6PPfbe8y4ezRnesOLqv0vgJ5kck3G4uJVuCMGqxIPOU3zEsbbQ38HP0vGldSDUHdr/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111541; c=relaxed/simple;
	bh=KlbhwfQj76SQTmFRHL9h0n3H9mi1hP1ugCy/7dctdY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMbKPN8ziQjn46P5mtVUZ/oQ9JXEj7eG6hnZedXUf/R/Ljry2y0pP2NVt1sKfOzriT9LYErx9ZFndx+OroGgR1hvxV6bI7gj8Ye9QCYMPTaW5yukZAdh6o0QoYHPce1Ctz6U91JHVydzU4xtMD1KHpdF5X1UXI2hZCT5oxr9hTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5cgOQipR; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyQwAtaHsH7UxbE7pcai05Q0dxLOqCoxXZBQE5TvgczdaNsQ8WRDjHT03pWyCcS5fGQPWPxnxofeSNWJnW0FLw9uPxmdbXkPd/Pbtx6wL/N30WrRIL5XOHC7a+0zo0aKgfcTyU8Y2whavtc5tO6uu9rCcOzYRLSpwhEQ6HhTHZj/39GMCDdWURyarRqffRihWs3RwvofNsbHsbd1oArz8qf5O+oYwDrJzMuOSRPHfLZbes0/QM/wf2e+vQmjMQoOFtPR6KnzhDS9L/d8V8kchrKUYQOS4KhdG87jB+Na/qf+tHxv6sr+4tYv/65j8GyNikWDR32p8xD7YyZeoz3Etw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhMZrxcjsGJkAgw0vOyTGVNSoY0hcuonKzmboAwMaIE=;
 b=Jrj73AzbKIcZvHxyRZFHPNytBjBRrb44fmL89R2HnOdV/JRlYHUYM+4lB0Xee9Qwk17oPGzyEsvhiiNoKq2VA1QW4PVz8JP9blka8IIDUKAkN0qIXKMzVy5e6h5P6UeRLydyNFE+GsOlD3YqO4/4TZ1g3egBvT4cCh+7GEbh7IcRGKc+8EsLJiLUmmWHkXuHLCsoCoegBiEWiGt0RlOurHCi6BgkxIKtAyIirm/XFhvLWbOha8JveXQUsT+gBKwDzs5prGDP8qph2fs5GsGs1tMV2q74z3kUAiXWt1Bb0qL00gzmqWUvfwOxGoJaE8+OZGZ1Yf57NKtk2aKOdnhpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhMZrxcjsGJkAgw0vOyTGVNSoY0hcuonKzmboAwMaIE=;
 b=5cgOQipRjXHDobchQrt4Sf8qzvyJySL72XW/mRzIiBJs1CvgPNys8cAugrhmwY6oOQAdwNIjUcsxBK/InGYI3ugR+ucgyLJdmAkwOqmF7+aauZb2SmKLMAU6sPTc5XxhufTk0iwrWPp6cx1Y8z0+ejsLkmPaqTueP+sXaUOvmzY=
Received: from SA1PR02CA0016.namprd02.prod.outlook.com (2603:10b6:806:2cf::22)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 11:25:37 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::7f) by SA1PR02CA0016.outlook.office365.com
 (2603:10b6:806:2cf::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 11:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 11:25:35 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 06:25:27 -0500
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
Subject: [PATCH RFC v7 7/8] KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
Date: Tue, 8 Apr 2025 11:24:01 +0000
Message-ID: <20250408112402.181574-8-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 6629e4c2-9548-4e13-9ebb-08dd7690150d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kPDefmjBQkde96rR+qfs9BtiHpQgIB6VoajxD0Tc0XImDMLQ+x52FuDREEw3?=
 =?us-ascii?Q?3Uep88/wuDkfJsmve/njoCgWIVputCD58T4sCgpghDMPlTbG0l8Eeqf31YFU?=
 =?us-ascii?Q?uAVOdcxLkwWfV/sj4478M3p0qdF6zaiKBu2f1SwoL9ufiKLUrcA2bAmOKvrm?=
 =?us-ascii?Q?FE1eRCHCoo5fcH4GQzZ7rBxyIA2tjdIlV4Y71qi6JFOoTPes2sVBoDGxcjyO?=
 =?us-ascii?Q?a32FusZ6Ee+0pr5PEHqCulpi2hod5m+sDXPjqW8dSOWxK4yjbkENf3r5gbrg?=
 =?us-ascii?Q?xMm7a6r9E1KGsI1gqZzFF0F3hoXg4MZ96aBVkk0o4fwzl/kQ/80rBztvP70D?=
 =?us-ascii?Q?WcNQTym4HilEJ+gMKFIQRXSOAB4etyn2jgAcDBVc6yY+DuU3p2gebZIs6kRB?=
 =?us-ascii?Q?HqlkjJ/EjfnqQ6SQrk9zBvR7KGuuKndo2rgnGOMlOCQXe15IpjZv/hrIhF2r?=
 =?us-ascii?Q?FxSgzaZhtfI9Q6onn5tt+Evd2+pvA0PDIQYIa+gioMrJG5Dif0JYAmrEes/p?=
 =?us-ascii?Q?YzfBk1ViM6rbX3jatbCZjLUSfd9Xhb/aTilP7/J3fcYj+3FMIz2G3AvHqi+y?=
 =?us-ascii?Q?cIJhubY55Sr1hiRfhUSzvcZriyRZAjkoghyxv2mBPAdxNNfSWIiuTTxUUAzE?=
 =?us-ascii?Q?7Wn2fwY4zBXz26gguX1JntxdaL9lbIahgNNzPGrWp9Y+xUwdGpaj4Mf6iv3s?=
 =?us-ascii?Q?zanPdTbH4A3GhitWofUoSupXbjLa+8Q44nDtlXzFsvdEJ0Mw/67kpkEiQUMr?=
 =?us-ascii?Q?Z0FhHK6VCVZvwMaBZDPVnPnZGxxmfB6EEqZIA4VM4nbFq9aZ8QxtSp4YERDe?=
 =?us-ascii?Q?DCdV9vy9/+5z3nQZ1Fd1bXVC6CtDNoDEJ6pocszuYsrmsEp61jieN9ElXSt4?=
 =?us-ascii?Q?JJz29gRDrEvVE4AnBqnrI5GGd5dq7j+/A06Rgvmi67L10KzVPnlhjt8omWQg?=
 =?us-ascii?Q?zXLY/gK5N62dOiGGr2AyPPnFazHyh/woG0AP8ZtSoF+iP73G6z1ElDZOxBlF?=
 =?us-ascii?Q?nwljLBQF308r+CETECmJPqbBbMrIfAfClKS3a3Yk5N5Dfn7ehPxKSzhGbTWd?=
 =?us-ascii?Q?JzfICuZ3AaYTM84KFErYbxmtgbA2d8AH00VAM0Iz+2kaa/R8mJutfCHxnO9E?=
 =?us-ascii?Q?cfC8EDUSluqrAbbx39Mk6vtyEiklCAjeGdk4vkyfkUwwq4Pjp1KVcAegjkDd?=
 =?us-ascii?Q?3Dn3K20RqHMPVv4XMj4xBlg86nJHJ3Hwl1M+Owvz2UrcDITALkLoUlo7Bo9v?=
 =?us-ascii?Q?R+gCnmwSP5Z7YjKUeRLpR9b5yP5/VShnnm3dRL+zkbh9nYWkVB2oZxcU5VMJ?=
 =?us-ascii?Q?l1tajSj6v8LUU1agOl9O3JL7x4SKNiYmvJxEP4gD7cEsnDcZcODgLxBTDFmY?=
 =?us-ascii?Q?S0ZUVtLzpQUH0539ZELprICKr2ilAHazMh/Y0pkiyPu0aGKCH4thhToBqMII?=
 =?us-ascii?Q?zxUqDpn8xk+0RUeG4/4SvxV6P5+fS7OUIBYWNZdB+oRlkkLBC/2EmubBhloC?=
 =?us-ascii?Q?Z0/NZJ+FRH6ETFg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:25:35.6435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6629e4c2-9548-4e13-9ebb-08dd7690150d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616

Previously, guest-memfd allocations followed local NUMA node id in absence
of process mempolicy, resulting in arbitrary memory allocation.
Moreover, mbind() couldn't be used since memory wasn't mapped to userspace
in the VMM.

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
 virt/kvm/guest_memfd.c | 75 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 0ccbb152483a..233d3fd5781c 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
 #include <linux/kvm_host.h>
+#include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
@@ -19,6 +20,7 @@ struct kvm_gmem {
 };
 
 struct kvm_gmem_inode_info {
+	struct shared_policy policy;
 	struct inode vfs_inode;
 };
 
@@ -27,6 +29,9 @@ static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
 	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
 }
 
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
+						   pgoff_t index);
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -113,7 +118,24 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
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
@@ -336,12 +358,14 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 	if (!info)
 		return NULL;
 
+	mpol_shared_policy_init(&info->policy, NULL);
+
 	return &info->vfs_inode;
 }
 
 static void kvm_gmem_destroy_inode(struct inode *inode)
 {
-
+	mpol_free_shared_policy(&KVM_GMEM_I(inode)->policy);
 }
 
 static void kvm_gmem_free_inode(struct inode *inode)
@@ -384,7 +408,54 @@ static void kvm_gmem_init_mount(void)
 	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
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
+static const struct vm_operations_struct kvm_gmem_vm_ops = {
+#ifdef CONFIG_NUMA
+	.get_policy	= kvm_gmem_get_policy,
+	.set_policy	= kvm_gmem_set_policy,
+#endif
+};
+
+static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	vma->vm_ops = &kvm_gmem_vm_ops;
+	return 0;
+}
+
 static struct file_operations kvm_gmem_fops = {
+	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
 	.fallocate	= kvm_gmem_fallocate,
-- 
2.34.1


