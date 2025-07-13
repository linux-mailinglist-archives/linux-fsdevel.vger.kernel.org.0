Return-Path: <linux-fsdevel+bounces-54779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D7B03276
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 19:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C687A5655
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF6288C09;
	Sun, 13 Jul 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lJXmeMy+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E019D07A;
	Sun, 13 Jul 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428936; cv=fail; b=q/e268QyID+pqyQOORipmPr6q3xlHp5XVa75vfThb0kyOmFUPl4KIC5nmNYcRY1b9DZsRmhXI4f7A2r4VCz4XdFTNszsDOxvqKBQrhUdjP8LckD65MVeLQKKKMp/T2AJZq3ROGgMaVA625VN/iCOA2pyUt3RpVi5ib5bJsrESak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428936; c=relaxed/simple;
	bh=iE9d4Den1dvoDhkkaVMmJJQpP+gH/Fs5HtXiiqSJvgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4GW+MYpnM4aHmWO3tdGzrCtBF5ddXgrcarWBZgAxf8yH2gjI5yB4BOAKfFWIJNHSWKcnSYUvkU/Zh5AKccD7HHAKdRuVZSUqfO2h6E+mIo5IsQkAyfms6URT5AHA9UAjGTagMs5s60wC2UJ7kkpERJ/KL5d4UkS7oYbdizwnp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lJXmeMy+; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIH4FGemcONA2X50RnSnHVm6Qrz0wcJ5LtnvsixlIr63dYQvwphzTd8tzQLtD8SJrnAkj9FOKZ79OQ1yvBRfxrocWwuMHa1zwlLX6s43C8ZDR3wnPOFMfQHDO3q7gRLEaVxmM4i8r3rvoULQqfTGPl9lOLJOBAMg42Sb3U1vgkAI5HaQajLaXyZVC6dc2Z+AoKpavG4bTC6yGgvZudpQEH60zACrCNhui9xCPCesb1OkvtMthk/wQbRpnPqBitUSpIdgnyx8aOeTeIATeKtmF9+IKVe8g42totdBnn6aL4hQwllExdYDSvcogAU2vgxqyW9qkGV3KfBMbaZWCcMItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTjj+lVZp0RixDQuYKs/TN0YmDJpa6lnG98n9bmpL9k=;
 b=WKcJMapWzKTig6eTaqocdYxzM6ocA+QErXcukVYJPiV849XTg/RxQEkYMoOt/hSognDmZB6XIjP+rhFz67sHi5EnzkOsHyVGbW9Sl7glBDPhWnDii+SKOnlrTDslKahIjXQkY9+wNcNEIM08IoJ2cJ8jUW9dSEsVpk3Pfv3l50AFtv4Jn8kOCjf7BwaVqrUe0yFk2pVhjfWnjSE4t9aae9CfmgChVKgotKwab2thOspkJns+bKQhQfvuA554CL+X07H+bQ7wwBx3OGBbGsMzp64vQ7/btajKHPRRvhMKl8g9G+GyOZa9u9DjiwcUuVvyikCAkOaLLyX0yBrQYiiYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTjj+lVZp0RixDQuYKs/TN0YmDJpa6lnG98n9bmpL9k=;
 b=lJXmeMy+9kZ4XigTJzOfAvOsfmVXqL4wAGi0G5kpzcBTTNms44WjkUgpQck1Lk5OMfD9OXJnmQmiL/LMrnocD19sqGwSQKMB3fjhr/CY0UKTQv2gCoPO+DsSBJw+h09uc8yFUSMdPB2M7Dem5pdjPYex3k2BAl9kiEwWrOu1g0I=
Received: from BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Sun, 13 Jul
 2025 17:48:51 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::81) by BY5PR03CA0027.outlook.office365.com
 (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Sun,
 13 Jul 2025 17:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 17:48:51 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 12:48:35 -0500
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
Subject: [PATCH V9 4/7] mm/mempolicy: Export memory policy symbols
Date: Sun, 13 Jul 2025 17:43:38 +0000
Message-ID: <20250713174339.13981-7-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bf1582-9468-4c11-e590-08ddc2358742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?np14MBrIx0sY7627s80IPmyH58CZ75QiahyJk/ra8k3Keue+wT+kKJmXDBH2?=
 =?us-ascii?Q?zkL+PwKZfhNXF6SXmJXsiOQOtGTrfbDmr8MP+9lHfkNIyQKx7Fzr+Y+6eBAX?=
 =?us-ascii?Q?Pb11eInX8ojSy6i2zbpziVEbDYOEWYDGzrhauq7uiBDXgFulo5pNqblVHb3J?=
 =?us-ascii?Q?1aueakYVLvH/UI3Xx3hEa+HfamfiT2SEPgmZseKWSm9D9AdGYU54UUTnhICf?=
 =?us-ascii?Q?3Q4+wJtwEVyIHzIbEczDQBSLic5dPF7S0M0AGZLa5GqYt4GEjCirLDEbJRTP?=
 =?us-ascii?Q?P8eIysxmkU2aimcMlSNf9YMpd72zGi8XU9zfTl7ISi3tixQe0RuuVUqnlsSc?=
 =?us-ascii?Q?FkLFG3sRbAnPAPqL2pQwpZBDonne0cDLUOH5cmo6BtTKq/p5br/tCiHzs+aP?=
 =?us-ascii?Q?UKDw24W1VfMwFBpUnFiTN0XHExIyduFfaglDY9oTuBbMIC/EuoUvRhnIzHfR?=
 =?us-ascii?Q?h/Q3UpiLAdwC4eV1oy7Bo8SMurbKPrCqtIIMJBrvP1+2ybCwHW3NqmgLZIqH?=
 =?us-ascii?Q?j/iFkxu0fZ8V13VTB2OjoZzYYRGctgms2GSdS2LQ1RBAYMCp3njL5fCiFBB2?=
 =?us-ascii?Q?7Ii0B+xlV4hM5yVy7V6OiicxU5SzbkQw4gkxX/kbO8wYSI2Ar2V94ClUWVQf?=
 =?us-ascii?Q?NwcEaSFFwqYGdySOYxo6i3lKq9yiiuXnnU4omUXvlMYo7MvCazcyJleEDqlE?=
 =?us-ascii?Q?iWA0DFSF3agkAHKg4Bqq2EItz1+TI2Wvr2qC+DwZB6YB4tpcHLKjHPZZLRvd?=
 =?us-ascii?Q?JZhGHVNBv9p+JOrCL2QwRvL0Y+W8tNWUG7fs1d9znjo6ea26X2Bt1d9s10xf?=
 =?us-ascii?Q?GPEdQhhtNYrH0A8XqJ5EEfnYM8k0AQ8rsfv1LbbdaRmWFatIb9G+qP6QIVCC?=
 =?us-ascii?Q?jyz/OC2ToxAkyVbxbsdFWBqoe4Yg73AwVHkzOvQvfV7SET4c8HRPccVdCTg9?=
 =?us-ascii?Q?hjZTYGWQlXGrikU+pd6qe8iNcu6v7FQtXhiFvyu4wcXI5Zcr3DpbGEU9ODP4?=
 =?us-ascii?Q?thzW6QadD7yok0nKp6skIn95c5OrbzzcfnWS7WWZK/aDIpZk2KAOO6F4Ohli?=
 =?us-ascii?Q?grOkFLTt56z6MeFekZSTmSSVyjVCho6T8e5EUBM/qdCjl0ztFjzW8M1p8H3l?=
 =?us-ascii?Q?swG7FWmpQsVwVm+Sbz5aYVy56UPOXFeHdkiY6G85v3KjHL8FeervSIZibHEf?=
 =?us-ascii?Q?Vg4xjOLcGfrzGs4vJ7aAjBHDRhzylznWKVOuhX2u0UwEvNVEDcl2TRnYTj2A?=
 =?us-ascii?Q?yDsENV+8QwpE15jeZ9qgk1ukaUKEmp5vgWwDu/vbLBDV8Xxunis64iqqhHaX?=
 =?us-ascii?Q?uZ3U02R0ZxA4BwMB54cj0Siq5wWJpVkHGmX8ZzrS/izXeA2dCi5s9Qpd7q17?=
 =?us-ascii?Q?mbbaJD4KTEEiRrB9KZ52LTQglWWOnPLPrkx2yToxWMsdvGiqS9uSNy8QgO6v?=
 =?us-ascii?Q?L3lAXus7fbbsUR8VjscVjdViB2uO6yjo4P3uECXcNVd1ju86haKGWyZVVtOV?=
 =?us-ascii?Q?w5oKwf1Iq13v/oUv1JV75KQOwOUMKz/4FGc+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 17:48:51.3488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bf1582-9468-4c11-e590-08ddc2358742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081

KVM guest_memfd wants to implement support for NUMA policies just like
shmem already does using the shared policy infrastructure. As
guest_memfd currently resides in KVM module code, we have to export the
relevant symbols.

In the future, guest_memfd might be moved to core-mm, at which point the
symbols no longer would have to be exported. When/if that happens is
still unclear.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/mempolicy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3b1dfd08338b..a502e06cfaa2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -354,6 +354,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 
 	return &default_policy;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(get_task_policy, "kvm");
 
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
@@ -487,6 +488,7 @@ void __mpol_put(struct mempolicy *pol)
 		return;
 	kmem_cache_free(policy_cache, pol);
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(__mpol_put, "kvm");
 
 static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 {
@@ -2888,6 +2890,7 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 	read_unlock(&sp->lock);
 	return pol;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(mpol_shared_policy_lookup, "kvm");
 
 static void sp_free(struct sp_node *n)
 {
@@ -3173,6 +3176,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		mpol_put(mpol);	/* drop our incoming ref on sb mpol */
 	}
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(mpol_shared_policy_init, "kvm");
 
 int mpol_set_shared_policy(struct shared_policy *sp,
 			struct vm_area_struct *vma, struct mempolicy *pol)
@@ -3191,6 +3195,7 @@ int mpol_set_shared_policy(struct shared_policy *sp,
 		sp_free(new);
 	return err;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(mpol_set_shared_policy, "kvm");
 
 /* Free a backing policy store on inode delete. */
 void mpol_free_shared_policy(struct shared_policy *sp)
@@ -3209,6 +3214,7 @@ void mpol_free_shared_policy(struct shared_policy *sp)
 	}
 	write_unlock(&sp->lock);
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(mpol_free_shared_policy, "kvm");
 
 #ifdef CONFIG_NUMA_BALANCING
 static int __initdata numabalancing_override;
-- 
2.43.0


