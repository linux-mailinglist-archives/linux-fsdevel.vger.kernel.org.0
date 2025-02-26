Return-Path: <linux-fsdevel+bounces-42644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFECA45823
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D25216A7B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D88226D12;
	Wed, 26 Feb 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HfSNhfxB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB419226CF7;
	Wed, 26 Feb 2025 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558489; cv=fail; b=gryWsJ5S0/zEVWzFHnB4wLNvbYMA2J5hxKzv3ziFYeNzymfuhl647vM40FijjZczBR7QBxAzkx6lw/M2Hp4cafG+Kh8mOLiYKAsiPBBZ7PJ5VeqtoTNbdoP6JeIkOzYNcx0nhHIG3P8dUWhu3QktWbT7MeZslICR8h+QDpayE3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558489; c=relaxed/simple;
	bh=wwlTaSpqe3BSi0awC6cAD87okYwpW1GWBR+Tarkp7+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4TYHl4JzpjLCfS9LMbtdUNArwewnOLd590PcNVNA8/j18hmKFPGmQB+X4CV99DbG8WATqX2htHb35JbfvIHyprB1r/3fJjOTkITLku1QLfh3dZv1CkhZ0R8ZhTxSKZatBbTFFtRwymBGF0URL6skhXnlwGb/p2swCdED7MBvKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HfSNhfxB; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7Gr45uUcj+8ujtqbN6CZ2YmjzgplnNsbI0pWAs/0s+NXV3CsQHcjRYr902J8fVl+fV65DG7vK48fvmYEmqaheerUPNNCQYB3J4/qDZq6DVb4Tkt0Af9tqFeltZGTbjKOkimZ9BcGFRoE6LC+lTgXJ9Db45haUmcAlmqIVKpgK8NRc9A1KJqhtGmPZlZeg6uk/N0mjQxNkAOx3R1KppJc4D90PA3GlbOMNxifEvpWuEEAR4MWkHq1nvmwS387V/xVNMjxQfSHBlTM+ut+WuKMS5udKDpzgDF+FyfJ45A0++POzz8Ed+BRGbc9L+P3P24ecz0VDdUF8Tg6WYKInq+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K8XomHJFup4eDpmSplvuSLweqgRZQP8s2KtEa8VxMw=;
 b=vGvmcHmiAsDLjBD3ya/hLAMGz3Il3TcZj0k9sYBamDcnWpzjn23rfaR6Wnw/1ONMZMGUbAAOsLT7fTv3yDIItrB7UIlfbUhx7hED3M5zu5pbU7/waX7G6SqFY3DiHtH2hpcxIDlyAG9vY6eLkwnf6PQDmlCGrWwp3Ci0v5w+KVSAt3Gm+JhywXAdJQNVs8Relp9mj6kAXWfCG67xqrFXuKJAnS0DjE1ER9wgjm0yeiLagXxg5xUfVm1bmVYQv+7TUMeO3LIfva1zDAIR8Rh2J6z8OoBiQe0q0WB3S+PS+iqxfctxv8A5JWmcMepqH7QmbBGOk+dBwp1daAHsIeFllw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K8XomHJFup4eDpmSplvuSLweqgRZQP8s2KtEa8VxMw=;
 b=HfSNhfxBJKpdbsYrWObRKeOMKBDoq/fggKAitYnFdK1TfzOYiohRHI/bMOqRC2WJABwNPC8lpN/w48/4clW9kTR7bEjKswRdnPNWhmAdPIjOjDoYjaCJPN0G7+xQF2iqOdPfwUwh+6pZWPPaI095LJgIFL/OKZXwObqmECqTuBk=
Received: from BYAPR11CA0057.namprd11.prod.outlook.com (2603:10b6:a03:80::34)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 08:28:05 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:80:cafe::5a) by BYAPR11CA0057.outlook.office365.com
 (2603:10b6:a03:80::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 08:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:28:04 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 02:27:57 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>, <tabba@google.com>
Subject: [PATCH v6 4/5] KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
Date: Wed, 26 Feb 2025 08:25:48 +0000
Message-ID: <20250226082549.6034-5-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226082549.6034-1-shivankg@amd.com>
References: <20250226082549.6034-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da0bccf-d93b-4e98-5f64-08dd563f7d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RggYDt4Mtoeh3WLN3hGIM5BY2FlQ6EJuNfqDGH9RhxjWdPhHNmvT8duSdndP?=
 =?us-ascii?Q?bA6hpCxz4XyDvHjqxHu81qmgI7YpI+aZVGHKj8houbfvW05Qx6OH+Wgje8Fz?=
 =?us-ascii?Q?mW22UP97pjbbTR5edhm5BAY3VvIAuDYVgFjHqZCyf9FrA9Jm2ZA0iiWM686R?=
 =?us-ascii?Q?KBqQ9+fuRJPVynnulGNBllHCWfMvkIMfgQzezNj6El9oYDy4fCtQ6SWrviz+?=
 =?us-ascii?Q?l9JAZ/ywaTQWxjjMyBLwzgJx80Pjgovcm6HsdKHXliyD7pnuO9/hsEPv4bZo?=
 =?us-ascii?Q?rfjISij/QrFFnvEiOgm26VvLEnOr2v/lwx57u5mQXWeGli5h8AmaTcdN8hBv?=
 =?us-ascii?Q?q0LgqzBPudR+jK0kI6mQ39sVXVU8cnL+TahGb5On/Uq1KpJXqRDeGyLhDRpZ?=
 =?us-ascii?Q?WpntHFBhw5oa1WujBSghBa2YTNfvslzExgPLoEZHG6agwSIpkxOrIeYFRiJl?=
 =?us-ascii?Q?mfbT875HiHR57+TtVBLDayhJAEdiUzsUml8nUuNCroAJkv1mRLRmBNmipXTr?=
 =?us-ascii?Q?EfaMEuqZU4j0wOn7+Wwx4Il/f11mLBj9on9I5Xbj2ft5XOwzju3Gz0Sai6hw?=
 =?us-ascii?Q?9YRBWlMNe83g/k8oTSlMj/gAGFSVhLND/bsz/+aCmQ8wph81XQdZCpIoq00B?=
 =?us-ascii?Q?OFk6MyWknbJ4RPP2HuNSWvqzGC3wGslUuN+Y2qNQFD8j7SiRuEiGrOwIRQt8?=
 =?us-ascii?Q?jCHJCi4kXgVFCmyz3pEcgcWxs1QkxJ6ksyTx4mVjsk0/oEiSVax4E925gZ6J?=
 =?us-ascii?Q?GPj92I7JCM1CbPqjnEaPYQMwoaZPyr5Nl26ZfyN388YXvtK221D07Fx4x9bm?=
 =?us-ascii?Q?Cg27OjeFjtWIXK2+8eV6rI1FkRIFlVMwtuyFvmQjn+Jh1h6mwsypQwiW3uSU?=
 =?us-ascii?Q?X/+v6mrledrpG/47YtihfA/M6+9e1RhLnYzjBGoDyyts10DJFaRXGwegnAh1?=
 =?us-ascii?Q?1qaZsTdU0C8UIYak5zwXcSosn07VzB5dLhpZYvbUHnHeWRr2dEEDbzKQ12Ef?=
 =?us-ascii?Q?WxPZEgGPbJ6H+0P+AqUCJhWGOxTsAMuI99ojMhrCkFCEAJm5zfOYu6MYGMCF?=
 =?us-ascii?Q?uIn4x94r+HgsTR/dNFiFa/umAa3iFIIwiyY+oVmvUYim/ylEI+GYMxQrpP+N?=
 =?us-ascii?Q?VDukfpt2cqeNuFosikDWHr0A1bBlLfuDvKhhnaIpYc3rE8b419V9+/KeGAkf?=
 =?us-ascii?Q?sFXvH7uAzF2tvMLnjkAvzciow8zO+61Xo0AwcRBoxTk6d8JvZyLJJjSaJq0X?=
 =?us-ascii?Q?UH9ouxEf8inUVuLRa+phGYbCKZ5KPdZkOj5kwMuwnLMC8k5coRyHwzgq1crw?=
 =?us-ascii?Q?VKxLydix5Oi4N/T43yiCo1wbW9lukZ1nHAoMXzSFz6y4r1W/CDogbBJ8GeKz?=
 =?us-ascii?Q?PXSvFG4AHSZksp/WiqTLaArCp/1/oZFy352ZwKrGx9qyTOwyVIlJNvnhZksx?=
 =?us-ascii?Q?pWNplHHaoBDpC+lZX6HscoWQod33cXtdV90AQCBOpzYB3HLMJR/kapOdU8ul?=
 =?us-ascii?Q?UPaaCe6mAItcGIs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:28:04.3631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da0bccf-d93b-4e98-5f64-08dd563f7d81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825

Previously, guest-memfd allocations followed local NUMA node id in absence
of process mempolicy, resulting in arbitrary memory allocation.
Moreover, mbind() couldn't be used since memory wasn't mapped to userspace
in the VMM.

Enable NUMA policy support by implementing vm_ops for guest-memfd mmap
operation. This allows the VMM to map the memory and use mbind() to set
the desired NUMA policy. The policy is then retrieved via
mpol_shared_policy_lookup() and passed to filemap_grab_folio_mpol() to
ensure that allocations follow the specified memory policy.

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
 virt/kvm/guest_memfd.c | 76 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f18176976ae3..b3a8819117a0 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -2,6 +2,7 @@
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
 #include <linux/kvm_host.h>
+#include <linux/mempolicy.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
 
@@ -11,8 +12,12 @@ struct kvm_gmem {
 	struct kvm *kvm;
 	struct xarray bindings;
 	struct list_head entry;
+	struct shared_policy policy;
 };
 
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
+						   pgoff_t index);
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -99,7 +104,25 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
 {
 	/* TODO: Support huge pages. */
-	return filemap_grab_folio(file_inode(file)->i_mapping, index);
+	struct kvm_gmem *gmem = file->private_data;
+	struct inode *inode = file_inode(file);
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
+	policy = kvm_gmem_get_pgoff_policy(gmem, index);
+	folio = filemap_grab_folio_mpol(inode->i_mapping, index, policy);
+	mpol_cond_put(policy);
+
+	return folio;
 }
 
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
@@ -291,6 +314,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	mutex_unlock(&kvm->slots_lock);
 
 	xa_destroy(&gmem->bindings);
+	mpol_free_shared_policy(&gmem->policy);
 	kfree(gmem);
 
 	kvm_put_kvm(kvm);
@@ -312,8 +336,57 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
 {
 	return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
+#ifdef CONFIG_NUMA
+static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
+{
+	struct file *file = vma->vm_file;
+	struct kvm_gmem *gmem = file->private_data;
+
+	return mpol_set_shared_policy(&gmem->policy, vma, new);
+}
+
+static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
+		unsigned long addr, pgoff_t *pgoff)
+{
+	struct file *file = vma->vm_file;
+	struct kvm_gmem *gmem = file->private_data;
+
+	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	return mpol_shared_policy_lookup(&gmem->policy, *pgoff);
+}
+
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
+						   pgoff_t index)
+{
+	struct mempolicy *mpol;
+
+	mpol = mpol_shared_policy_lookup(&gmem->policy, index);
+	return mpol ? mpol : get_task_policy(current);
+}
+#else
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
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
+	file_accessed(file);
+	vma->vm_ops = &kvm_gmem_vm_ops;
+	return 0;
+}
 
 static struct file_operations kvm_gmem_fops = {
+	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
 	.fallocate	= kvm_gmem_fallocate,
@@ -446,6 +519,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	kvm_get_kvm(kvm);
 	gmem->kvm = kvm;
 	xa_init(&gmem->bindings);
+	mpol_shared_policy_init(&gmem->policy, NULL);
 	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
 
 	fd_install(fd, file);
-- 
2.34.1


