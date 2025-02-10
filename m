Return-Path: <linux-fsdevel+bounces-41368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E9A2E43C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 07:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD24F3A5806
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901341991A9;
	Mon, 10 Feb 2025 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5JfT5EdU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B66192B76;
	Mon, 10 Feb 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169557; cv=fail; b=ZFyaqgTqHctU20tfCUH8dCncB8I/OBhjpdcTPbGor25xqtoXaWaKrwTdDm/BvmJgIU+lbjgu9brTzQlh8FOCuNJS1lfK47nl1/9Wo1TYj3vBDTOZeiEr6/pkTDDAwwx3jsli8QXTnNU0LyqrAF4vszqdG84aacYhe/pB0bUHpQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169557; c=relaxed/simple;
	bh=F8zDbV/IKGK+pQ3FfP4mgHcyDm6ZgA0saoVSjkiurG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwcOfYdvp4FxYUw8T3RgDUPZK3ePypPsyDlgLoiWdUHOQ1xwz9s3XI8/JWJ25n4nuz21adWAu+VZooOTn/59k1S7Gb5t6exFa9xyDCJL7ykfIk6BDj9DbCAhCByN7SRTGTl7yMhxyq5w858RuiPwb/vcVGSqock8UGf8o2nM9qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5JfT5EdU; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVh4kkDXq7+AjVnDwLlIUznn5XHbwbUITvj6MDT/F+9eELOX8QiAPySybBdSaQR1RXHQVtNoJUB3fcEoLxeTf0Y2F3wO2a7C6TaDZQUHLR3pUqln+8hymxFBLOBVVF/dOAZVi68n1UD6QwPSyx1dS5zTXPnGVgI+fgRUdN1uTMpiOMfTGjf/Fq1SbcKVpPiHobPNww3Xt0qUqZHizlCijgPc/hDaSlsmL89AAwfmhK96BWsXW5MkI6ahOqED4CCGPflBn6XTICfd0AQktST0wGOe4OgDKpU9h30/8FPclmcZInhY51d2K5YTbGaLQWObtBA0kAU5Ge8/E0OXh3GrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARPUQ0qI0jyB3ykl6pWjnHNttD+6UqvBxNWuyZj5uq0=;
 b=pGm4OyZbHDbeNhPnxqhc1j7VFTY8IdgMCaHTHrbZhwrGdExfeE32K1McHJZC4e9hapCuoR5Vlt8hEtzlCL/6E2SQRKQyF1wDdibR6Xnxs5rEn1FvQIoUY84IMqejjleWEn6Y6dECazMXqwQRgQeyP7zXnK/9i6d+rIiQ8X9Yqc3heY3VszExkJvohO/heH4He8rJ/DHgKJWdqvwVggsYfQAR+VNAkqD5H9izYWRH2g/F192+XbMbyVaaUg4znBeKQHmS5/3GDs1oz5E+vsiMEpLuiFMXXHF33eYh05IuhYlwFz0jfkhTUSzwG4Y+b9QyEsBDpt6wBumwPv70XDpyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARPUQ0qI0jyB3ykl6pWjnHNttD+6UqvBxNWuyZj5uq0=;
 b=5JfT5EdUpWflAG+A5cNWMb5GZXzZxtyktEhEzQqNCrdjcQNkmppnGXu9NDEy3dz+GBxRupO9lEhIjwSB1O+IJa30oRMuH21yvnjUITx8pSGXzGYArnXk2IFz6K5rYkpaVh6oGyYN52OuN4e7qAkMeo9Q9Z0OAF51jjVKit5VFpo=
Received: from BN7PR06CA0053.namprd06.prod.outlook.com (2603:10b6:408:34::30)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Mon, 10 Feb
 2025 06:39:08 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::60) by BN7PR06CA0053.outlook.office365.com
 (2603:10b6:408:34::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 06:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 06:39:07 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 00:39:02 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>
Subject: [RFC PATCH v4 3/3] KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
Date: Mon, 10 Feb 2025 06:32:29 +0000
Message-ID: <20250210063227.41125-4-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210063227.41125-1-shivankg@amd.com>
References: <20250210063227.41125-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 6710d119-026d-4c70-b765-08dd499d9eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ECpuUoMmvJklYHEFB0ej3vv5Al5XD0IvhGif5KaApOmYbts4K05nYqCil99a?=
 =?us-ascii?Q?tIuUbo2QFNwmKaTI2ycTg3IQbIHLML4XN1X5rhGC0T54pAdDMLoE/+Soc/eF?=
 =?us-ascii?Q?F3Zrzj+LdSZWAHSnRVWeS7EWIe0nSgyJSyW1bQ/DnfWwI2AraXRjSaZVh1Fm?=
 =?us-ascii?Q?I+5CN5lBltyezheuCX3hR/4U93EKKBDHsLH1ncoP3PSZC+7B9b0l1v/Cyaa5?=
 =?us-ascii?Q?DdyLhJZubfd9GkWkDyBIQ7sOShBzkGYBjbynUlQ8GaNXtdQrRjw8k0lDXWu9?=
 =?us-ascii?Q?ybnXsC0pepT8QBnuHepCgCrSsX0vfQS8NxKFn7SUOU7fYVGX2GD/q4soMKIj?=
 =?us-ascii?Q?uRgB+fUxqb9bZwnKuGE9KTkkieNUPItzuzm4PY4Cvz1f96f2huUdifHAQFwS?=
 =?us-ascii?Q?1tyN1Kdn31T5kBkAgVysTAcq3nwS5z/CLlFqlFKJdfxzSHqJ36o/FF7bkYEZ?=
 =?us-ascii?Q?rn+9v4YnZLfjvkiYyb/noLERB2NDQkGmDHOl3vLEPm1L+Hv5YdgtEC5atxMs?=
 =?us-ascii?Q?RPR+zc6+JS34sgziJ6EfzjNuG1mufu22W5ydLhtDr56Fg/gDlZqINN4xdPCW?=
 =?us-ascii?Q?07v98vBFeona7Q8vxv91/RdMyXwKD+M3bMeFmDRBmatCpUXGmO/X/DAd0mml?=
 =?us-ascii?Q?lkzA0JFUD+VUnADpSC99bh52bsnJa6visFDhgBuLI/n0n2u6G+9vIK7nkKov?=
 =?us-ascii?Q?5Np4gqGTZO8DP13nmHWa6I2tLNpplZ+LnU06lwYzbZmu9MAXoI9jaXkKV6MF?=
 =?us-ascii?Q?LGi6sht+5PsaCXk/VmuJgPTn7jD+vWVZ8UlBlHqQCCmcTqg+mBCtt7c4cBYv?=
 =?us-ascii?Q?hyV8bj59/qx8eTgrH4/43ZER7fd15Yb81Hhl+I7cQOV2olRMiWRcgRJarMbP?=
 =?us-ascii?Q?/naHxsGdGeLo3kJYnZNt54r2JfL4eAm2GtONBtx2mRYENgKRiukh0Ht48Qlf?=
 =?us-ascii?Q?OKhmQ1oC5aqaNb8qS9s/tt64hrl1R2x/9bBKPNO6iux7ZULMYLf9VqNfWMDU?=
 =?us-ascii?Q?2FXwT3KYIpIqDibH/bq2nwEx33Mz8PZt1DIYzGZdbJnvzwY61uyPJ/XProaX?=
 =?us-ascii?Q?Td/LBbGjEVAdOCiAGMya4j/ylmR6SSXKYleUY2nmum//Ux4en+PswgxDSEoR?=
 =?us-ascii?Q?i1AmB7HR6N1P9K0J408B3XlXgNv4zhzKNtMvaAt5m93ssPmh+eVy9qukB74y?=
 =?us-ascii?Q?8HmxkH1QmbHPNNOM9I0k5wMgGGGWLV6v/MvebI56hB4r8Mv8kyBDuMWZkIlB?=
 =?us-ascii?Q?bC/Ece9Mby65oRXVTxvNPMbztDFFWnlUMu3xYlnicDiZ0/Cym08ML7/q8mek?=
 =?us-ascii?Q?lTOxskIOzSqNWtDN4U6UyDEg5/NQ1uhNUjtEPP7rTrHcuC6iKwfvA8tdWZM9?=
 =?us-ascii?Q?4uzPS848UdSuiz4J+L6DMHDU151b9G5wwYMU1vciH29CHUqI7d/kM8tUI6f2?=
 =?us-ascii?Q?EWIHgb77m3zhBMdAskh/J7CYq0Fcm8hXzlQ6zN6xwR/WC0TZnBR2c9dzA/eS?=
 =?us-ascii?Q?pBFvPa7ei0wEOS0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 06:39:07.7059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6710d119-026d-4c70-b765-08dd499d9eb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

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
 virt/kvm/guest_memfd.c | 84 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b2aa6bf24d3a..e1ea8cb292fa 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -2,6 +2,7 @@
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
 #include <linux/kvm_host.h>
+#include <linux/mempolicy.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
 
@@ -11,8 +12,13 @@ struct kvm_gmem {
 	struct kvm *kvm;
 	struct xarray bindings;
 	struct list_head entry;
+	struct shared_policy policy;
 };
 
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
+						   pgoff_t index,
+						   pgoff_t *ilx);
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -96,10 +102,20 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
  * Ignore accessed, referenced, and dirty flags.  The memory is
  * unevictable and there is no storage to write back to.
  */
-static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
+static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
 {
 	/* TODO: Support huge pages. */
-	return filemap_grab_folio(inode->i_mapping, index);
+	struct folio *folio = NULL;
+	struct inode *inode = file_inode(file);
+	struct kvm_gmem *gmem = file->private_data;
+	struct mempolicy *policy;
+	pgoff_t ilx;
+
+	policy = kvm_gmem_get_pgoff_policy(gmem, index, &ilx);
+	folio =  filemap_grab_folio_mpol(inode->i_mapping, index, policy);
+	mpol_cond_put(policy);
+
+	return folio;
 }
 
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
@@ -177,8 +193,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	return 0;
 }
 
-static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
+static long kvm_gmem_allocate(struct file *file, loff_t offset, loff_t len)
 {
+	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	pgoff_t start, index, end;
 	int r;
@@ -201,7 +218,7 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 			break;
 		}
 
-		folio = kvm_gmem_get_folio(inode, index);
+		folio = kvm_gmem_get_folio(file, index);
 		if (IS_ERR(folio)) {
 			r = PTR_ERR(folio);
 			break;
@@ -241,7 +258,7 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
 	else
-		ret = kvm_gmem_allocate(file_inode(file), offset, len);
+		ret = kvm_gmem_allocate(file, offset, len);
 
 	if (!ret)
 		file_modified(file);
@@ -290,6 +307,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	mutex_unlock(&kvm->slots_lock);
 
 	xa_destroy(&gmem->bindings);
+	mpol_free_shared_policy(&gmem->policy);
 	kfree(gmem);
 
 	kvm_put_kvm(kvm);
@@ -311,8 +329,61 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
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
+						   pgoff_t index,
+						   pgoff_t *ilx)
+{
+	struct mempolicy *mpol;
+
+	*ilx = NO_INTERLEAVE_INDEX;
+	mpol = mpol_shared_policy_lookup(&gmem->policy, index);
+	return mpol ? mpol : get_task_policy(current);
+}
+
+static const struct vm_operations_struct kvm_gmem_vm_ops = {
+	.get_policy	= kvm_gmem_get_policy,
+	.set_policy	= kvm_gmem_set_policy,
+};
+
+static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	file_accessed(file);
+	vma->vm_ops = &kvm_gmem_vm_ops;
+	return 0;
+}
+#else
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
+						   pgoff_t index,
+						   pgoff_t *ilx)
+{
+	*ilx = 0;
+	return NULL;
+}
+#endif /* CONFIG_NUMA */
 
 static struct file_operations kvm_gmem_fops = {
+#ifdef CONFIG_NUMA
+	.mmap		= kvm_gmem_mmap,
+#endif
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
 	.fallocate	= kvm_gmem_fallocate,
@@ -445,6 +516,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	kvm_get_kvm(kvm);
 	gmem->kvm = kvm;
 	xa_init(&gmem->bindings);
+	mpol_shared_policy_init(&gmem->policy, NULL);
 	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
 
 	fd_install(fd, file);
@@ -585,7 +657,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 		return ERR_PTR(-EIO);
 	}
 
-	folio = kvm_gmem_get_folio(file_inode(file), index);
+	folio = kvm_gmem_get_folio(file, index);
 	if (IS_ERR(folio))
 		return folio;
 
-- 
2.34.1


