Return-Path: <linux-fsdevel+bounces-59419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A90CB3890C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766B37B7AC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869EA2D7DED;
	Wed, 27 Aug 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jD0Gdc/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D682D29DF;
	Wed, 27 Aug 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317401; cv=fail; b=ttjuFZjPYBIqulyomEHqOfoIvoRANrgUN9edFPU8axqXdng5NZMqAN/hyfa3vnLigL7ntSe2y8ZbeFukhENuvjAWmRZlEMzdBIL3AC7XFbx+j1WfMdIT15XX12mZsNnYS2YehLSdQML8eoMNcVV6KsxHLqaxqfR/v9VR+OYhrGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317401; c=relaxed/simple;
	bh=f+xr5tSYNUlgjaQQuwXDZvtPhjDyZII8cC4DTt2xQoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRp2gCx0F6Jmx7OoMdO0UBFVnLzh4/0UiCWvflV/l7EWxI2EWMGfmpmXp51Akm6W9psAoJZIdX1ZjM09lf3NwkSGFMXyRIjUyeaC+hfyIHkO6fcg3BF4bA1gTEmNy82HAtlGdVB5bWh1hA49PHBqOtFHiaDObjnAv502VUyWM9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jD0Gdc/X; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEC7/5TJXHBZZC3gCYhV7+HH5/SlFdmviSE6GBgTa9q4S4LeifcFhYRBK3E/jtPGDh5faUu1FSlBSk0LF1TyZ+f9ly5URBMD+J5z2Em6gqzXld7rS7YdKaaqwiBQ/ERzI0bincxP63uNA/5cSldvsF6pB9N7DyeM7NJra5hPjgP9xZyBRvVn9WwNpt+omuGW/E0cFS2L4vQynwwfA0WrrOYb71Sei4vF/fKjSd+6N1a464d/DDK0k94fi7TI4PJDVT5fFiA2GxrzDCW6800Ohf7HNbk27mzbKuBrtpfJPbNDlyDXG9nClGyFtwGoAETVp3fNyrv5W1UFp6dgzQhgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxZI0XnfKEPRmBNAqV7ZPx9xYGIyZsZhBVXBJa35aDI=;
 b=PH6AxBlqZ3tU1RZGPE5WLNETD1M7RCDO031JXGYVhy+stdxtUfdD0JySYGHc891PKXSQtGf6sZ+vjv7p5+L8wbRJxDDliQY+qFgYlE31KncMJ7kZwUP5wlWOmMXCiyisz9HLL1zM+hxozl5QkDdDMSHCpLPbv2YeA37ZEqj0k2WQtb1lJJOs46Thr8kklEPIj/uy13Vk5aILzCyKFrR8huJ2ViMrRrEI5KbC0oL/02Hzg0b5eGoF8hbclwhBoOGc8nh3XtWeFA0pZ47bKcIIlXNzkpXGM/rr3jxYIAvs2I9umXqw5+kbcwHTl01k7MZi4niQc22JhjRSV3gzgaBc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxZI0XnfKEPRmBNAqV7ZPx9xYGIyZsZhBVXBJa35aDI=;
 b=jD0Gdc/XPPDF/UCc7T5N0ctccleofEpAn05GYqgKbZXe4aVhMyK/lT193zyFSvsw9KFEzW+H7yFlKN9DAVZ2d60Fp5KwsI0BM6uHcVGDF22KUuhdauMbGDBNM0VQfIbwgD7kQYepMK+oE8KuYWvYVIK9NLYWI+S+e03lxhks3G8=
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 27 Aug
 2025 17:56:32 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::18) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Wed,
 27 Aug 2025 17:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 17:56:32 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 12:56:13 -0500
From: Shivank Garg <shivankg@amd.com>
To: <willy@infradead.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <seanjc@google.com>,
	<vbabka@suse.cz>
CC: <brauner@kernel.org>, <viro@zeniv.linux.org.uk>, <dsterba@suse.com>,
	<xiang@kernel.org>, <chao@kernel.org>, <jaegeuk@kernel.org>, <clm@fb.com>,
	<josef@toxicpanda.com>, <kent.overstreet@linux.dev>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <lihongbo22@huawei.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
	<apopple@nvidia.com>, <tabba@google.com>, <ackerleytng@google.com>,
	<shivankg@amd.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<vannapurve@google.com>, <chao.gao@intel.com>, <bharata@amd.com>,
	<nikunj@amd.com>, <michael.day@amd.com>, <shdhiman@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <jack@suse.cz>,
	<hch@infradead.org>, <cgzones@googlemail.com>, <ira.weiny@intel.com>,
	<rientjes@google.com>, <roypat@amazon.co.uk>, <chao.p.peng@intel.com>,
	<amit@infradead.org>, <ddutile@redhat.com>, <dan.j.williams@intel.com>,
	<ashish.kalra@amd.com>, <gshan@redhat.com>, <jgowans@amazon.com>,
	<pankaj.gupta@amd.com>, <papaluri@amd.com>, <yuzhao@google.com>,
	<suzuki.poulose@arm.com>, <quic_eberman@quicinc.com>,
	<linux-bcachefs@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH kvm-next V11 3/7] mm/mempolicy: Export memory policy symbols
Date: Wed, 27 Aug 2025 17:52:45 +0000
Message-ID: <20250827175247.83322-6-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827175247.83322-2-shivankg@amd.com>
References: <20250827175247.83322-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: ce52832b-9b33-4321-d48f-08dde5930eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6D+v3/Nm0j0TRH1xh4733kthLNmgOxH6pMXCiiwUvd4OpnQtP7xe9YF4C6wz?=
 =?us-ascii?Q?Q3nU7X82phmKJ6IU1tk2tO2Soxr2xYfTcZqoTj4brr8bHwxUTEsBXrLtUAOd?=
 =?us-ascii?Q?DzlGWoRxERqSU1HhK9WzqfkHYJcLvwHso0XVhhVa84lDBjLLXXA3U+ZW7XNv?=
 =?us-ascii?Q?irVM7/BxDT4oRZKi7zBVCauoTnYbHmZMt+WT9iiu/fqnK/WrdnXQi+JKrRf+?=
 =?us-ascii?Q?uwIg8WWONGUUOdt4jEmFT3zljKOFG017+MlLgB5RuedqEcU4yHCmBChqeJmB?=
 =?us-ascii?Q?8wk6EJGb4lkjPwqbPUeqnCek0MTW0lUr5UFLu/XNxVSgb/Po0GQtSLGHNq/E?=
 =?us-ascii?Q?f2tj5qfdd4N5fi6OhHKgRnut8Jhs3YGuI1ORg/lYHPCJaF7jpHnHZO0zPuzd?=
 =?us-ascii?Q?sMZkYHXojVRvoC1Tvmz1vthrcyAY7kDl7nXMQrxGqxegnBgnjqrvXPEoIytW?=
 =?us-ascii?Q?7ygf7UowQWk2LPMeLC3a0rAf83ur5tocOAs/lNzhWJrRa1+qv94SpsFPXRrr?=
 =?us-ascii?Q?LWxqhAIQnBMhzM/HlhEwFIyDJBcGxbftofRFL0MLzQF0Ba67VUg/jgw+Xbme?=
 =?us-ascii?Q?zmscYua90/ok9+vyrdYDkEg5oiLhosRSsG6D3dlgK5EP8wBE7zVg5wy6mSjx?=
 =?us-ascii?Q?899GbVu0pDW1F0XSBnOcCGwOht6yKKiRgPa0CJLue1QuVvnI0exDkp0HOPoN?=
 =?us-ascii?Q?5BnYAK5XRIYgEcSKXsex3scOR9LTzkDZN0N4vPMuGDWNpwPQLQL2tt5Zfvod?=
 =?us-ascii?Q?LUnBNljYNbhsGZGrI2DhzWKwE1L3i9/6x3WLmoTUvhs15MqsZUi0WApI6RlB?=
 =?us-ascii?Q?uOEH8Oo5rlx2EaGVWYjXxHfuh+S4bunA0mk2PD71yH8uhIMVF3t3vpJ0k/ND?=
 =?us-ascii?Q?kK2p2oqMOLKsa8b6MKlTDkKwvMLF+WCUbgXDCh+i64FKKjw/k7o15qgIioDF?=
 =?us-ascii?Q?vySVoA8RogK2W2W2DZq0QZZ4Ff84+2WaUIyHwr5UrEbSA5OytEurT4qm85HD?=
 =?us-ascii?Q?RFqmFeEjEwHnQJfyvJdWMCE6y4OnKOSa286llXfoDSQiAb7cVfs6ssAhHdgt?=
 =?us-ascii?Q?V0rOX5/mqNlzBNFjKw8QAV7qcOelT67eSaO9RZokwOu1EsEe+e41QylnRfrB?=
 =?us-ascii?Q?ijfXU7dVeHf2rzXk/p1BKNYIz04nQ7bW8ancfJ9dNWohsU4qqcqiSa0+iOLP?=
 =?us-ascii?Q?jaUbYqtorUkREAD/LWzodQZkmnEiy2mTDzAdaBbpAetI+XEZcgGpcZqdtZ3U?=
 =?us-ascii?Q?OnkGL1RNVGs9WuiYdKt5wuK0yQrilrkVu4a68XmvRnhfe9xTTpw9mS1ub7Qs?=
 =?us-ascii?Q?Idir/X0suU0XgBZtfbPLXFaYVuFEsTKI6bbHQ5lq70dddEV7Dkzn3GrhApqU?=
 =?us-ascii?Q?eOjlGnTK2VbGIEGiWBR36evloSBWfVxzK3mojJJ7aXpxhTp2mD5rrxvwpjg0?=
 =?us-ascii?Q?RbMVxA66U5Co2rbFRICZfhnjJ4wShWSjqT/XmODkpWF1QoNK3mHsBcO1AuQ2?=
 =?us-ascii?Q?mQsMWvdnJ4tJku3Gzuz4AGkCO6sKchFsJjPL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 17:56:32.5138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce52832b-9b33-4321-d48f-08dde5930eb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

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
index eb83cff7db8c..3d797d47a040 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -354,6 +354,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 
 	return &default_policy;
 }
+EXPORT_SYMBOL_FOR_MODULES(get_task_policy, "kvm");
 
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
@@ -487,6 +488,7 @@ void __mpol_put(struct mempolicy *pol)
 		return;
 	kmem_cache_free(policy_cache, pol);
 }
+EXPORT_SYMBOL_FOR_MODULES(__mpol_put, "kvm");
 
 static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 {
@@ -2885,6 +2887,7 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 	read_unlock(&sp->lock);
 	return pol;
 }
+EXPORT_SYMBOL_FOR_MODULES(mpol_shared_policy_lookup, "kvm");
 
 static void sp_free(struct sp_node *n)
 {
@@ -3170,6 +3173,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		mpol_put(mpol);	/* drop our incoming ref on sb mpol */
 	}
 }
+EXPORT_SYMBOL_FOR_MODULES(mpol_shared_policy_init, "kvm");
 
 int mpol_set_shared_policy(struct shared_policy *sp,
 			struct vm_area_struct *vma, struct mempolicy *pol)
@@ -3188,6 +3192,7 @@ int mpol_set_shared_policy(struct shared_policy *sp,
 		sp_free(new);
 	return err;
 }
+EXPORT_SYMBOL_FOR_MODULES(mpol_set_shared_policy, "kvm");
 
 /* Free a backing policy store on inode delete. */
 void mpol_free_shared_policy(struct shared_policy *sp)
@@ -3206,6 +3211,7 @@ void mpol_free_shared_policy(struct shared_policy *sp)
 	}
 	write_unlock(&sp->lock);
 }
+EXPORT_SYMBOL_FOR_MODULES(mpol_free_shared_policy, "kvm");
 
 #ifdef CONFIG_NUMA_BALANCING
 static int __initdata numabalancing_override;
-- 
2.43.0


