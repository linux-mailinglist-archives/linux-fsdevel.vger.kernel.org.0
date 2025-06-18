Return-Path: <linux-fsdevel+bounces-52036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF6ADEA35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0120D4003AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357E82E8DE1;
	Wed, 18 Jun 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wZiZwcA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F772DBF53;
	Wed, 18 Jun 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246293; cv=fail; b=MXP8NaboEwFwiE7JQ+Duny6NPWMR55aP41OZVbsgLjEEnvlL+dZY9K8tEYQaLk7sYXtxNUv79k+ZYIKmYz3bEHtpIM9v4CASH5y0u9x5c0ul1eWXZrt+i5PhU2gxDudcgROUtlK9E/VphvltWkPqawNMsvMdCWllsRr+MQTE8i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246293; c=relaxed/simple;
	bh=lfXGXm+Ek8zzvw23WEeag0FZAgtggJFpXyPM86bM/Jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/fa1DCvxymymL+oXaoTSn+QmJOUEK90mx34l78JdeYoonfCzdSsC0CVCS7HpQZ8aOSmHe6WbZKotZWOAeXmemLmKUtK0ofibAohCPz7RZiLfBsp1U/GygCAWd+6B3v8DK1ASH0mslMz00wtfDIwj/X4jyCZmTAdhNTWPricD9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wZiZwcA1; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI9kOcogCbYhnmm4aaI58otgolz3Wi+LeqfEhPgHT2zc6eR8SU6hRmpEzTt1XbJyKygVHLxf+/iJ3NlztQX4Hg8QoDgIhgUhOhgZ5mZgzpk6EX9D5E1pA5A+bjE3A0gofILQkIp4Zp92mSpnZ9abN7mejfpL7fSLX8O9duAAsECUTruaAZtEccQFaLVxR6h1S5Q1FHY0C+YFDDmjYQUKz5Nta/fEOCs8uoCmUQXUW7rzxFlQ53NS58jYeu0DTdDF75qbx5V5ytCWO6Okx04RQCKOz7Ju7cNYTxet60/+qdCYnmuxEdOWwLrB4ZTPGn9FLGNUSRpnApjssoId8QVV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAmX9iRNDTZi0f1Ik14X6Rpj4CEBbwYZWKOSW4ycUR0=;
 b=UtgELZJli/Dh9Z9PrQKA3sRvA8KRGy4vzUeIaoYFSAgDzqx9I8sNuXzPGnmj+AyIRUqTXkytotOJYiiMRGoavDBJE7gAjo+cRANN+62byWUOpOl3p517r0/+OeQ+stHNDfYene4Xei86gXMD9gDZ+zJo9gA3OLwuIy25xlCBSlW7NlOJXw71uql8VfSemYJ++EqGo7Q5TyN3a/t0N4WKvlRyFlWiZWbBFiIRnfJI9YKU+zFPHCCQX65zE0Idiq1A2KX28tnfCLVukAOmyGwuB8wsP4NIg8aRzscPtR/OhR9gGqn2RdWVDTa/OS+0Tciss0ibULuY65JagD1ztXe4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAmX9iRNDTZi0f1Ik14X6Rpj4CEBbwYZWKOSW4ycUR0=;
 b=wZiZwcA1sVxO4zgBXE2zQbQeNJDMwJKXA3SXAVKYUt55MmErL7YApdjTYH13gsQ1ZVbiHU73Sb5pstcJO+kUWO8LM/36o2Qe7yFLcL49h4A00jOErcpubZEyBf0EeNlC9Pu5jzgfu2Ih02ccHC/lp66CuRP3NEq8UWMXL6n17AQ=
Received: from SN1PR12CA0099.namprd12.prod.outlook.com (2603:10b6:802:21::34)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 11:31:27 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::d1) by SN1PR12CA0099.outlook.office365.com
 (2603:10b6:802:21::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Wed,
 18 Jun 2025 11:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 11:31:27 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 06:30:54 -0500
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
Subject: [RFC PATCH v8 4/7] mm/mempolicy: Export memory policy symbols
Date: Wed, 18 Jun 2025 11:29:32 +0000
Message-ID: <20250618112935.7629-5-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: da92630e-11b1-4f74-87ec-08ddae5ba9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3sTfJJsWNzmXpowWpoY5VKjJLqa0ITKwKDQw/0Pv0WpUN5+aFBreKrXeWt5?=
 =?us-ascii?Q?z0YvARaZVke0KfkVKW9iORR0diMrAkXu/clx8ru87vINMKy4CqL1WV1mV/61?=
 =?us-ascii?Q?qQ+TqcU+iw1VVVVeslEydf7TmpGDd22tzDbQKd7wGCH8rMckwMERXSSxI144?=
 =?us-ascii?Q?V5ND/C9oE6XBpKXwch8mcdyOAj1CUvwfyG0dP0gYdQqfTpnzt6Wcj0P4H0uh?=
 =?us-ascii?Q?Z+BcWIuUEWK4hKjYzpzQTDnCqcdVFoXQX256hBbfY+e9W3ilV454Rs0dHPw4?=
 =?us-ascii?Q?9gRsMSgjRdY6ON8C5hBD+1EIucKqUVjfHHNlXO0XCiiMPwWv7bgjyGwjhJz7?=
 =?us-ascii?Q?InouU4+hDNLLXQxHYP6j/wfvUVm4Un8L0DNMwFvHtEw9tl6rNmej2eWnOyVB?=
 =?us-ascii?Q?pIYMN/LXL5lKW3qJreXOi5jczadLwipNaNP60hryK8FwPtOnx6I2+JS4+z8D?=
 =?us-ascii?Q?4N0cL6wp90RlkNlPFjZJxGCmCIdMC3bdbQvgUW5+QKc/uVQrABL0HPpnrC27?=
 =?us-ascii?Q?FEfRCjLzIMot3GxX7fMZT5Zvv+U/gVomXmzvG4eVH83LCmKIG/IgT0x+jxf2?=
 =?us-ascii?Q?TstFci1Mg8TEqZvrOjcONesCEyX7IahX6k/TZJu/MTg7w8dQ7DEutLdbJDyP?=
 =?us-ascii?Q?mEEhJvd3aIT14GfVpddretneBdlaTeDeZFAT2KpQpdS5x7XoL0tsRRMEcYhY?=
 =?us-ascii?Q?2tEJwuUF9Olg5xwBKHCB54PEOIx3EoVwdZ+tsgbY12wAc/aVcw4U8idHBscP?=
 =?us-ascii?Q?AuOff2sW37BYCJRBNhAUD1fxT6HQ9s70blILLmeST5r2z+fLuXAXxK5l+cvY?=
 =?us-ascii?Q?F2KakRwIuZ6scEKaVlzzzeMh9qDxH50FlytoKbM37JiFcud+1gCgWqCJpjyN?=
 =?us-ascii?Q?a/J5MiZI3CVbhJ+CKECCbLqZOOlthHG7FP4+gNoOJFnVLqQlAgw3+ntKimcE?=
 =?us-ascii?Q?qV4EF5rfxXG+t4V1+MSerkEAIQ37sX06cT+iEKzwqNuODrHZAF/lQGHm3cCp?=
 =?us-ascii?Q?gwtMaTKRZLaa1FAIRXl7RyDRnIqRd15NePI+HacdXuGx5IpEHAAn2ap6D5sd?=
 =?us-ascii?Q?67wfJ4MiGwVytvJh9yU2qPGBVZLN71t2naMH8U0CagTN/MHP+v5SRTLhqOaA?=
 =?us-ascii?Q?5V5Dr0WSny9/G75eMMkjGMUX4k6+SmH4G+ot6ADsub+6SRDJM5dSPwOQMYT3?=
 =?us-ascii?Q?IecN4wfSxHf3E5V0QkretxE+pyKb7AzN1Vmjbjva0kCRTtmX4nGyJxzTel82?=
 =?us-ascii?Q?LBf0Tk8SYAXMXYu12HGifvGt6fp60jIeTFj/4YkZ0Wm38E2Ax+TR4O7YkCrj?=
 =?us-ascii?Q?P2WcHbz0biodqWnDIv+YJ2PjJ/Dnsz4pgGRj2bo3KEnlvqXj0P3YcDqmy0sF?=
 =?us-ascii?Q?AtZ+IiXiVECM4Hmtjh6KGHEPRcDZTMnS+F8GJLBKFdnt8bMYXgf1YMXceLwQ?=
 =?us-ascii?Q?tfP1xrS68Kq0h26G+RxRD7lmYXoJklbjvPJoeTpT6lEHzglnFgYrhFAXUrKM?=
 =?us-ascii?Q?C4Vzb4znO3JJcuYNlOE8O1vXadAtsCI3POfp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:31:27.2711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da92630e-11b1-4f74-87ec-08ddae5ba9f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958

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
index 3b1dfd08338b..d98243cdf090 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -354,6 +354,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 
 	return &default_policy;
 }
+EXPORT_SYMBOL_GPL(get_task_policy);
 
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
@@ -487,6 +488,7 @@ void __mpol_put(struct mempolicy *pol)
 		return;
 	kmem_cache_free(policy_cache, pol);
 }
+EXPORT_SYMBOL_GPL(__mpol_put);
 
 static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 {
@@ -2888,6 +2890,7 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 	read_unlock(&sp->lock);
 	return pol;
 }
+EXPORT_SYMBOL_GPL(mpol_shared_policy_lookup);
 
 static void sp_free(struct sp_node *n)
 {
@@ -3173,6 +3176,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		mpol_put(mpol);	/* drop our incoming ref on sb mpol */
 	}
 }
+EXPORT_SYMBOL_GPL(mpol_shared_policy_init);
 
 int mpol_set_shared_policy(struct shared_policy *sp,
 			struct vm_area_struct *vma, struct mempolicy *pol)
@@ -3191,6 +3195,7 @@ int mpol_set_shared_policy(struct shared_policy *sp,
 		sp_free(new);
 	return err;
 }
+EXPORT_SYMBOL_GPL(mpol_set_shared_policy);
 
 /* Free a backing policy store on inode delete. */
 void mpol_free_shared_policy(struct shared_policy *sp)
@@ -3209,6 +3214,7 @@ void mpol_free_shared_policy(struct shared_policy *sp)
 	}
 	write_unlock(&sp->lock);
 }
+EXPORT_SYMBOL_GPL(mpol_free_shared_policy);
 
 #ifdef CONFIG_NUMA_BALANCING
 static int __initdata numabalancing_override;
-- 
2.43.0


