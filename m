Return-Path: <linux-fsdevel+bounces-42058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1266A3BB60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED0916E632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108511DF739;
	Wed, 19 Feb 2025 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bQ+iQtCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FFC1DB546;
	Wed, 19 Feb 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960209; cv=fail; b=WerSdBTw9qefqMUOY+FNw+bMPY5F1z8OrQDLmKcQF/5kfpAt9ySFOkR3xY3497A9t4utxSAy16jtJiIK99O7Z8O7PnzqsirzWvNnjXyiWqD6+5vrRZTQ06eBRXh9u94DgyzCkjxF9rmHihmSSHKz34RhBtnBSta/RYD0kjXVfcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960209; c=relaxed/simple;
	bh=J8IkQ8exK8diwPH576ssWWGA365nMDJvs9NtBQOq4lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZ01972XX1wkLyfUDj1GPf6MWimWtZdvCe7pBaJHLJDhjBGq+zaOxVmvuE07SwyjknLW/X8hQCU3ABtMOdK7u3DE2R8EaQEYbFT089YZ3wl1SwDnbT3+2crN4Y+1kWF6oe2RtWqjgNeJ67I9oVb5Re5QxrUHuEKzo8lJRZdCL+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bQ+iQtCi; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OD/yPLGAf78CV7Vz+QblO4DHdxtGMV6l9cXaRk59ENXIvpcvKUf2kCV4fJ7P0/Dmvmj1CdSWDO3UPS+qMV4fS881dcOVvrV9j5mpOM43x74MYLbz7eCA3ok7Spn5GI16Kr46U6qyKmFW+tcwkt21UQJXuc9KGu5pYasasAWD6Lkxlq0YFFJ68N1oG0+NzLCfHVjTF904e6vga6b5D8VPavvC+GPRVmMpxpf2coGaoBvloySdUIaFJ15df6XXFma7WwHHDjmvzYxfRWBzzoaoGCJ8jPcFqQr0T1qZMXfHHsuh95xdlUVaViEoPyU7rBDq84Hj+ZBuqYsiP3AFGrj9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZradmVSI1c/lwUMCGwWhjOQwoPNyHTXQz6PDS/1+2YM=;
 b=izyhdWPM4VXFOceTMQ7nU4PsebwhGf/65B7wVzwLzndMjGGgVDX7uODm2a/Eur26gEyYEWZJZKgxMbolTs0OXRvB7GxVnnO2TWdpbvBVXreLLlIy4LQ7OHMPUvGw+4Zg9DU7JLWYKMoGOzef4Bi7YEM+a4iUOeonVRsfLaCMB3OJCtXe5uYhracB/LcKxhNM3C6917ke+0pFmXH4ukRwkFfSSW/8zsi6wTTudxnAHKIIEj40jhNV1dOlcmLBD3jwff9nE79xhmaegv/EvzjwVL6PWElm1TIoP5n7lsvBd2lPf8GpKUN1Pm4qEwLCwg57pF6DwbtAjuxGEJ9YVhLjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZradmVSI1c/lwUMCGwWhjOQwoPNyHTXQz6PDS/1+2YM=;
 b=bQ+iQtCiAcD/niKBwByKDlMG6wQF+mMARuA2QOF+ou65Qt4DYmDUw5gZV82+Bt5TWavELNKjV/Iqaz5/2qkNH+HXxHV/w/gARFWK9jIeQSqpZN2a/0RhdZ2rYDI3guZ7SeZWbwBUdmytcTokp3rZGBXW/yY/8gc9RZcwtUCUD8Q=
Received: from DS7PR03CA0335.namprd03.prod.outlook.com (2603:10b6:8:55::34) by
 IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Wed, 19 Feb 2025 10:16:42 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::55) by DS7PR03CA0335.outlook.office365.com
 (2603:10b6:8:55::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 10:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 10:16:41 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 04:16:36 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>
Subject: [RFC PATCH v5 4/4] KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
Date: Wed, 19 Feb 2025 10:15:59 +0000
Message-ID: <20250219101559.414878-5-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219101559.414878-1-shivankg@amd.com>
References: <20250219101559.414878-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b332aca-a3ae-4fad-f87e-08dd50ce8160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u9bxdLOcqOqJA9Y5VtAJNtbQuH8lsZEJWscBxLK7GWdTi3Zu1nsEIMKIYV0E?=
 =?us-ascii?Q?fveLsYdNWbICj1AQNKE61XroPyGlydlHPCjMI7cyjZ0HNzpjBWTSfR8wv8zw?=
 =?us-ascii?Q?BW6LQvPZWgB6UmIUJfxUCL86wDoaiWmpTomK3AnjJMd24cUdmTiDKfD8p+pt?=
 =?us-ascii?Q?wZQ/gc2yfnLGwDzhezDbBMklh2bwnxh8JoFtCQTbI8p6K92oNFX19U+8KXm7?=
 =?us-ascii?Q?GmjIW3DXEqGjaWo7T60FDrMu3rKObp0Sy00EfbxcPkCcRru98ThPsnzKai1W?=
 =?us-ascii?Q?6TpyuznU+FlIuSCf/mW/eWGgeuzTWVRGIvHKefp+SOAwiDtiHjmbj8qFIPiM?=
 =?us-ascii?Q?3ODyyP1X/hr9m6DZ4KDLq7VffI5qCYNsSRBXWch/4UjSRlpzcUK482TnzUDK?=
 =?us-ascii?Q?/tR4HXieXhe19bnhNEKnhgOMAk42rC4QRMqdmPVpIyHDhqxfG4sO081bDg0t?=
 =?us-ascii?Q?3pCe73FAebVaqLb3aWSNiHzNs8ozpD0iZgHLqj55K1XxwYjgWJ+TykRLbkQO?=
 =?us-ascii?Q?xdv5Qs2M1tXxbJQz5a73VM+PHYJRCDRHoxP8E/sqZ5BEMMPUFUfuIntvO0u5?=
 =?us-ascii?Q?OkJG9BOjrSyM4t+c/nbASn/dBlt4LcYipd2HxX2mMVFuS/sgBqGSgQjcJYCN?=
 =?us-ascii?Q?eD6byOBBOc5PgtUKrekwrnOL7COMyFrcEcg78mFXDctQfe+5JI0BgQidisC+?=
 =?us-ascii?Q?K/L7A764cfrdKiDY3s/ehwlMA06VtPwHlb73+QnJYybnQ9Xbpscx/bdC84GN?=
 =?us-ascii?Q?kGBwCdxBpIH8k3FRGQZ+JgLtkg8ex0eoKJ+yzvkmuGGT6y2YndyRqnwyjayI?=
 =?us-ascii?Q?M0aNViMu7LACSVKpnrhS1juwUPN3lCCA9WG9cdMvSbV4nh28/AlIsefmBKs7?=
 =?us-ascii?Q?kD4+4IlLvBDFfxw02I2bgibU2L1ubSbmUekl5qW1+ruBfYxS7GFW8LSja2nm?=
 =?us-ascii?Q?okMzbgdnS6RIaZ6D33I+qzJGOhlfa8LE1+fihCePvFjbLtSWj8M5TR1pwIdO?=
 =?us-ascii?Q?OEA6Kz4q5b3/ZsWeWrFfIJLnRfwgvAG/cev36/aj50LTPszR+aabA0w/3Miv?=
 =?us-ascii?Q?RMH7I7st9Bc34yuPFSQWlx9JuKt13T2cQx2pH/irEHuu35HM8EvKtq4KoGcN?=
 =?us-ascii?Q?TCwkb8myi+Nnjx0jNVAtCAtBPdMq+XzZ+roGrVGf0s6pxiLVrAHSSfpKAfKy?=
 =?us-ascii?Q?9C8lNbWBr7zgihStUn1XW+/FewHQTFcvQwVTZR+j5D10FrTe1+bllBxxL4wU?=
 =?us-ascii?Q?ZKo1tMjl4ZtjkiUhLANGcIQ53+2YyGFuO+vcpECgTNJz09+bGl9Eds5iqpqW?=
 =?us-ascii?Q?qAJBRVTbLttWCn5nAf6BtJ79WZt3/T0vO0q6GMUYgDvzmYzEhi+GbT5yERjV?=
 =?us-ascii?Q?rNjfy/WYScwJ/eCBKPfvPJAF/ld4icX0ur9uFkJxrIfRRges4ds/YjyaJpxP?=
 =?us-ascii?Q?bOkeUOGZ1djwia7LzeVopgdARjIGhSZ3WBz2TK9B9QZFia/adhRLWsosmyYk?=
 =?us-ascii?Q?yAsyVFzH5pJnPfE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:16:41.9641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b332aca-a3ae-4fad-f87e-08dd50ce8160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591

Previously, guest-memfd allocations were following local NUMA node id
in absence of process mempolicy, resulting in random memory allocation.
Moreover, mbind() couldn't be used since memory wasn't mapped to userspace
in VMM.

Enable NUMA policy support by implementing vm_ops for guest-memfd mmap
operation. This allows VMM to map the memory and use mbind() to set the
desired NUMA policy. The policy is then retrieved via
mpol_shared_policy_lookup() and passed to filemap_grab_folio_mpol() to
ensure that allocations follow the specified memory policy.

This enables VMM to control guest memory NUMA placement by calling mbind()
on the mapped memory regions, providing fine-grained control over guest
memory allocation across NUMA nodes.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 76 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f18176976ae3..8d1dfce5d3dc 100644
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
+	folio =  filemap_grab_folio_mpol(inode->i_mapping, index, policy);
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


