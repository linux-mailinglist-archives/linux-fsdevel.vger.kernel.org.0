Return-Path: <linux-fsdevel+bounces-33689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719789BD2F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 17:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A1282D7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A081DD53A;
	Tue,  5 Nov 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q5GKiOM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252D1DB940;
	Tue,  5 Nov 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825778; cv=fail; b=DoSV+h/NanKktAPmQqB2ozepgpBedaUFkG4j2ET/kT+0T7Nhlv4LPH3SwoH8d/UPJT0T3wsWn6wCyq1AWRPGeWuK/qgqKdm1Ydf9kVkxxF5grAow3Wuhd6ts4PraplQShZHGqkLSVgKtzeN34ThfUKrUlQd/bJNg2t4PJVYA0tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825778; c=relaxed/simple;
	bh=zY82ZtP+UnMynnjFPI2nf6jmxD9SU4PbKqe5dE9+Yaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFhnHTIpjlCZfNhV9yj4PI0jKLYoz0dvfTykR3PpHsPgzqfW0r+CBISuGDSD9KX5smygmYqDMLAVxFNxkI553fObu1UOn09PonYAizftza3b0CSHALUqTns6YFBf60z5vgQ5WGUJyVJPZbI69QlQEIQVyi8M8a2YMtSCpXxrrmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q5GKiOM+; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3T2kqHH159/4ZnLZeL+pPJYhHFASc2AQ9Dv68cZshRsZNTx5TjfJK8p2bSysPJxcaZlzdyMw5HPOrnRq43lL7yYfpXZmTvKowL5N3XfyfqaOmXTPo/tFhKR45UN3SJZ4XI/KfrAQAP+jjE5HcXQh41cfUo+ADJy7IFN9/ayUpJBL84Q6MWaXhQK7uaglvG8XD2dtSHA9Ou3J/ZxPWNkEURN5IgOUP5FMw+t+1IoWt/Gpk9m0V/rxPofN8dLskm1NAlyauOZ3ma848EClY5XKMiLdghbWgDD4SDxtN5uxdBOoE0SIcpOGodqxP5bWrTru3IHaUTJxW0J4xhk8kwa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKH5iUczCRiHl86KVuC6tKdcCK/RD41GSpieUjteNDE=;
 b=kYe7bcrX5Ru7hbLXcxCtXrQ4sXdNNJ+ORSC3XY49lUCqBDJFNjWHz1TPt1h0CnwzwsBq7UIEnqw2NqvrQxVT39lTVj/Okj79Zn2EJes3uFWKQa3QlWOJVvX4a4GTsjbCN4OY++Bp7drUBJQ7F7BFSKZP0SOj6mamTqlJJMjbPfJPas4gSJ2hEFTt9wsPyC2y/1z1HfvPjU/nBzS9BdQqryE4KnFr+DHuvVMCGkIQnazaPyE6WuLYwyo+erzpT+apzfTPWg/3uhOdGFDMbOx3jpwXSGBGBkkHTcA1JqFF849bvPXg0yMw7kJ7DJZpwvYEjgh5HGPkqI75IP0wZ6VdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKH5iUczCRiHl86KVuC6tKdcCK/RD41GSpieUjteNDE=;
 b=Q5GKiOM+5BsFrJ0XTfIUstIgK3fFzkVKh4zRYnM7xr/EQ3i4reXpHyCQXArtr0Iah5eCUU2lHlsFEsJTNT6/90LO1n/y4fNh+IphY8NNDnTfEn/QgOxXf39Sf0sfogJ5vOjYovzQvaJAykykx/utpNO1tL+mkHZcyweDt3ZGNHQ=
Received: from SA9PR11CA0030.namprd11.prod.outlook.com (2603:10b6:806:6e::35)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 16:56:13 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::ef) by SA9PR11CA0030.outlook.office365.com
 (2603:10b6:806:6e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Tue, 5 Nov 2024 16:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 16:56:12 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 10:56:05 -0600
From: Shivank Garg <shivankg@amd.com>
To: <x86@kernel.org>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: <chao.gao@intel.com>, <pgonda@google.com>, <thomas.lendacky@amd.com>,
	<seanjc@google.com>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<willy@infradead.org>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<kees@kernel.org>, <shivankg@amd.com>, <bharata@amd.com>, <nikunj@amd.com>,
	<michael.day@amd.com>, <Neeraj.Upadhyay@amd.com>
Subject: [RFC PATCH 4/4] KVM: guest_memfd: Enforce NUMA mempolicy if available
Date: Tue, 5 Nov 2024 16:55:15 +0000
Message-ID: <20241105165515.154941-3-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105165515.154941-1-shivankg@amd.com>
References: <20241105164549.154700-1-shivankg@amd.com>
 <20241105165515.154941-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 9805a6c8-2b6a-4feb-2820-08dcfdbac14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AhKjNqwuOQ9yLHVD1PLSic7sN0fyQsPfG9/Vk6L0fVk2MB3PuDXuyIoo/17K?=
 =?us-ascii?Q?WMlz+9KOsTHOIG5KVLJWiwP1ASbmb7Z9LlTWJZDgO+k7Ftwq35MLW4pDM5eM?=
 =?us-ascii?Q?nYvh5oX4t5gT+rGsuiFicbnorcxjAvMp7PXljibx0pjgWpcZOOHOyZzW//5V?=
 =?us-ascii?Q?ym8ofnzUQ7O6gJy6xWPMF3HITgB/HIVNixD57o/NaKFyos1s4BdLOUEZuiKc?=
 =?us-ascii?Q?DVwPe3Fb4JtoJvKDe/31CkbnVKZ7gmaepZx6kedMYGLCfTc6F+VnZAFDikPe?=
 =?us-ascii?Q?vYKN/RhAqFGVX0ADrlW4BEYIM3srd/5GrJnTetzBuLEQSmpLTMx5c+x+ERFu?=
 =?us-ascii?Q?u9ytozTO1cuaoKAAeuHli2Hox7F5paCs6YTM77DvIJZ2mjJqkLhk2DV8uBtq?=
 =?us-ascii?Q?d+U1eRIgJ687FEC48H37RXu0YJOk3BlvOVPKpvDmeHDscWh/scJHQ6OOKjnJ?=
 =?us-ascii?Q?pvgTi5VDLXCXm3FPfGaNuAzPw8ygLo0AJF2ekyIxH8fkUWUgFx+ZJKE1/CcZ?=
 =?us-ascii?Q?oS7SYvz065QcGtzExroRi75OCNyMjLE6ffXDfpgYto/HpZ4JotyAKwl4QTvw?=
 =?us-ascii?Q?MTnMZxw1tqAmlNDOycXaEOZUb/V4SD70u2skLeFHoN6qsPvg4mq6We1PxxcK?=
 =?us-ascii?Q?S5ty8xgjKeaTPzyqopeMyp41h2O5Q+2iDxDYKiHAIBWpdtBQWBoDUFIKSeYj?=
 =?us-ascii?Q?3FeyfUxzG+Yft8dKA3eod97P89PxVKRLA4nr0caWJ4ylYoWV3+59fmrO/THs?=
 =?us-ascii?Q?JFO1ktbMQQgGmmC7Hjgt/+20L5CQ6+tdg9vTgWJhXY5Ri41hBD5GyXlTcZ9z?=
 =?us-ascii?Q?94beC8j2mm0rgQ5XhdH3OBnb7ANAeDG1GYgE9Hg0M5fu61Mea+KYXw/RLexy?=
 =?us-ascii?Q?XQe1m1u5saGhLNhRYN6LMgbcYhlO2YmlvrkChR1XInr15CsCVqjMU15P07+6?=
 =?us-ascii?Q?iTkYrnOOvjzvY97ZRo470c0tyRtA7EuMxv9f8zyiekw5c0njaB1hfjBOBFrK?=
 =?us-ascii?Q?2wlgHAmjPoFyhc0U80YsW08wtNaRyvTBAaddY7kbWPrCxPq8ig8HUO0X6Z50?=
 =?us-ascii?Q?DZ3uo2vynuds4Gjg/qX+URPT6MKooxQ2yG111ZFaMivYxfTEpwSZaz8iM+MI?=
 =?us-ascii?Q?7Zyi7uhHwLU6qbImYLYjReThcy0a+Aph5MbngjpGVRJNSiY6YF9dYw+kS05e?=
 =?us-ascii?Q?k5imILvVH6XKWMz9uq/0eAYTvykAzX5hHMbT7gyx3tgAfr9NQSeXyvlRftBk?=
 =?us-ascii?Q?6ZX77MZbzeCF+STwCUQU0JsKDkzQiz+2W9Ptxhinf0eDEUyP6x11WkiJ6DXK?=
 =?us-ascii?Q?L9I+BtPLHTdGqB9jr/wWAKAPTZ66JqygA1vhiEoY7R1NTnaY6etOgjEK6SiM?=
 =?us-ascii?Q?/QZfGn30JyVpGfSjhI/6Vh5IPp/IEycEc9zZolWjFboInzZnLMpoVzemB1Bx?=
 =?us-ascii?Q?TnCLqwpYfdU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:56:12.7593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9805a6c8-2b6a-4feb-2820-08dcfdbac14a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

Enforce memory policy on guest-memfd to provide proper NUMA support.
Previously, guest-memfd allocations were following local NUMA node id
in absence of process mempolicy, resulting in random memory allocation.
Moreover, it cannot use mbind() since memory isn't mapped to userspace.

To support NUMA policies, call fbind() syscall from VMM to store
mempolicy as f_policy in struct kvm_gmem of guest_memfd. The f_policy
is retrieved to pass in filemap_grab_folio_mpol() to ensure that
allocations follow the specified memory policy.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/mempolicy.c         |  2 ++
 virt/kvm/guest_memfd.c | 49 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3a697080ecad..af2e1ef4dae7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -347,6 +347,7 @@ void __mpol_put(struct mempolicy *pol)
 		return;
 	kmem_cache_free(policy_cache, pol);
 }
+EXPORT_SYMBOL(__mpol_put);
 
 static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 {
@@ -2599,6 +2600,7 @@ struct mempolicy *__mpol_dup(struct mempolicy *old)
 	atomic_set(&new->refcnt, 1);
 	return new;
 }
+EXPORT_SYMBOL(__mpol_dup);
 
 /* Slow path of a mempolicy comparison */
 bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2c6fcf7c3ec9..0237bda4382c 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
+#include <linux/mempolicy.h>
 
 #include "kvm_mm.h"
 
@@ -11,6 +12,7 @@ struct kvm_gmem {
 	struct kvm *kvm;
 	struct xarray bindings;
 	struct list_head entry;
+	struct mempolicy *f_policy;
 };
 
 /**
@@ -87,7 +89,8 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 }
 
 static struct folio *kvm_gmem_get_huge_folio(struct inode *inode, pgoff_t index,
-					     unsigned int order)
+					     unsigned int order,
+					     struct mempolicy *policy)
 {
 	pgoff_t npages = 1UL << order;
 	pgoff_t huge_index = round_down(index, npages);
@@ -104,7 +107,7 @@ static struct folio *kvm_gmem_get_huge_folio(struct inode *inode, pgoff_t index,
 				   (loff_t)(huge_index + npages - 1) << PAGE_SHIFT))
 		return NULL;
 
-	folio = filemap_alloc_folio(gfp, order);
+	folio = filemap_alloc_folio_mpol(gfp, order, policy);
 	if (!folio)
 		return NULL;
 
@@ -129,12 +132,26 @@ static struct folio *__kvm_gmem_get_folio(struct file *file, pgoff_t index,
 					  bool allow_huge)
 {
 	struct folio *folio = NULL;
+	struct kvm_gmem *gmem = file->private_data;
+	struct mempolicy *policy = NULL;
+
+	/*
+	 * RCU lock is required to prevent any race condition with set_policy().
+	 */
+	if (IS_ENABLED(CONFIG_NUMA)) {
+		rcu_read_lock();
+		policy = READ_ONCE(gmem->f_policy);
+		mpol_get(policy);
+		rcu_read_unlock();
+	}
 
 	if (gmem_2m_enabled && allow_huge)
-		folio = kvm_gmem_get_huge_folio(file_inode(file), index, PMD_ORDER);
+		folio = kvm_gmem_get_huge_folio(file_inode(file), index, PMD_ORDER, policy);
 
 	if (!folio)
-		folio = filemap_grab_folio(file_inode(file)->i_mapping, index);
+		folio = filemap_grab_folio_mpol(file_inode(file)->i_mapping, index, policy);
+
+	mpol_put(policy);
 
 	pr_debug("%s: allocate folio with PFN %lx order %d\n",
 		 __func__, folio_pfn(folio), folio_order(folio));
@@ -338,6 +355,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	mutex_unlock(&kvm->slots_lock);
 
 	xa_destroy(&gmem->bindings);
+	mpol_put(gmem->f_policy);
 	kfree(gmem);
 
 	kvm_put_kvm(kvm);
@@ -356,10 +374,32 @@ static inline struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
 	return get_file_active(&slot->gmem.file);
 }
 
+#ifdef CONFIG_NUMA
+static int kvm_gmem_set_policy(struct file *file, struct mempolicy *mpol)
+{
+	struct mempolicy *old, *new;
+	struct kvm_gmem *gmem = file->private_data;
+
+	new = mpol_dup(mpol);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	old = gmem->f_policy;
+	WRITE_ONCE(gmem->f_policy, new);
+	synchronize_rcu();
+	mpol_put(old);
+
+	return 0;
+}
+#endif
+
 static struct file_operations kvm_gmem_fops = {
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
 	.fallocate	= kvm_gmem_fallocate,
+#ifdef CONFIG_NUMA
+	.set_policy	= kvm_gmem_set_policy,
+#endif
 };
 
 void kvm_gmem_init(struct module *module)
@@ -489,6 +529,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 
 	kvm_get_kvm(kvm);
 	gmem->kvm = kvm;
+	gmem->f_policy = NULL;
 	xa_init(&gmem->bindings);
 	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
 
-- 
2.34.1


