Return-Path: <linux-fsdevel+bounces-45969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EC4A800B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BC2447666
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1D9269AE8;
	Tue,  8 Apr 2025 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZXH9w5np"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4D5268C72;
	Tue,  8 Apr 2025 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111500; cv=fail; b=MyO0bDDk9gJ3Kf1kBA+HeJDf2aO6LElr3ZmDx+RU589iTMH55xqIRNWe7ZLCPdJWX5hQ3fjRqQymPgYX/ayP3ohT6+NKncjZgVu6kQZMcuj6jH25wFbde+D1M4I7PxAh/2QuJkP3zNIKL9y6aZA8alzxfqRvPJe3r9aKJTPhLLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111500; c=relaxed/simple;
	bh=JNNLMRlqhuOVLdn6i8F9kg2HPti+4tk5C59pMjk31gI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muxqvNIn5IvS3vCCs4fsUNUyQeDGYxxIFXzj6JIiIefptqzDXWO1UdUb8Iw2kF1zyoQkREL0fuuJ2UNSIgeYoyig5SLSdV09uZBCrys0lmkDT06tPGFuNkgwEjP4YiEpTfu4uCREwTEY/LjqauAorjOgYPRiWyXNSu2vA2RcOBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZXH9w5np; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwPLhT8YSFU21JPLkRT6UkXV2tJ+waOdJzaTGb9ky5jd6f+7ILmslyckDZCrLMDJjxvzEUsjVFttR1Pqz7wSAwcU3+eeVedvPUO9OTY18GwODo17W2XjhAga7ui8KrSZfRlL0ToTD6bDwuglkZIViP0VQI6Q2D4aqoQyVhTbU8vUCOwB47RYeLhi6pUTQalp2FeoC83MadMyGMiCChvBx7SewgG3oYWUZh4EME4oo3kCAekN3sAqeoUyM1sCRHyFczgJWl2xs5HTiMEddx2LBVhT/JaOw2k3xHRK542nI/bQsNThj/iJhTodXlaccxtyouTUipbc3vsZgu4fdm9hDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC5zkN3Ii5Gf9UJRMbWuXIYhBpL1BVZgJ5RZreT9LUM=;
 b=cciwiy28RCKXWc8it8q4b0X7mxaDoNVOwYQAdCWpJz8NaKqKelxchCjeORJl1O+RSDH1RLmWfi64npNqGBCqLHg5ODnKcxSLgUWNjPnVFUb3pCKEyLEyH/sLqlxH85dY9so8iGkzQAmAwZYT4dIOfH/E9NCmNF9ubT74C7U/6xCFpEGYtd823TIgzlW7tTmebcsfWvQsajlROUCC8pA5/ACMdwnejNoJc7n44ld4Kvk5Zwe1K5YOrxuEDhJnH9rBdA2VLD9yQeiB4y/XtX6gw+un3ij9wME2qRL+0E2ALm2djLnDIrO+HuIVxgmd5w23E2ppnhzSEAlVs8NuhOhOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC5zkN3Ii5Gf9UJRMbWuXIYhBpL1BVZgJ5RZreT9LUM=;
 b=ZXH9w5npREZChpcvhzv1VS+gjhOuTuEzyba2/M2Kcijf/RNBZjS4QSOz74EsL5KVFfECaLgCw0Jf9pjTx1I91KxkvVN0CVZm6huJzkJtKOZ8+Qr3f3Xc54sF0hYyWwk0RAQ6cE8pPN5aRsCkIiZL5JG/w78THa3YGVHnF5wwQ4o=
Received: from PH8P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::16)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Tue, 8 Apr
 2025 11:24:54 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::ee) by PH8P221CA0001.outlook.office365.com
 (2603:10b6:510:2d8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Tue,
 8 Apr 2025 11:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 11:24:53 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 06:24:45 -0500
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
Subject: [PATCH RFC v7 2/8] mm/mempolicy: Export memory policy symbols
Date: Tue, 8 Apr 2025 11:23:56 +0000
Message-ID: <20250408112402.181574-3-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f2b2b9-81de-4a19-a2ad-08dd768ffc09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ncv7d+HHrSFsE76Hgt2uc8RQCJjRi6uoRhZs+QQXisQeDTzpCTYinKiUlkk9?=
 =?us-ascii?Q?OPC8trWPmlLo/fsoooRFsyJV8oRSiJ/YzZAgfY3fO1anwTSeW5ZP7cl/7ahJ?=
 =?us-ascii?Q?m4CjtwlvghXoVRcm1JMWt3EXUni5wyC119BtRgdxmQm4QYsyo9u/ZMsW6Ecn?=
 =?us-ascii?Q?ne1I4nlad+AjTjvFvCAS7tjZVMzDsV5Vt/b3wkLmeYPzxUa0WDMupuozEU43?=
 =?us-ascii?Q?A3Md26CrygcYchzVT1dnq7gz+7SnDxdHcMOWUjfs08cqHkJEgvad4kCw+jlt?=
 =?us-ascii?Q?h0xt8WHT+w43CKBM4sYLJwpVA8suWtm0n8HqoNb46/paf0yFPX2VyqU4zaji?=
 =?us-ascii?Q?Grq6/5Vaj1DLrp53N9BxPcMcQ9ZfM0+f12hXZa+JQKOrTLolXYgffSfyWrGE?=
 =?us-ascii?Q?/l7YArFtivfZcxszbJmK3H7r45BnhQTv7mQ2uji/9ezmEPNC+Yc0R+n7eisE?=
 =?us-ascii?Q?3ST0/Y2U+IaHlx9Fm9q3jkNx1yH+g7IR8ovxcu5UwFHpeVLoSRj8wiCjBVZd?=
 =?us-ascii?Q?be3OGEAYgoJ7TaO1/vEZyBRKQq1fZ09gPMlk0XU07g2/SOT92p/RW07xcoZj?=
 =?us-ascii?Q?luUOBaot3ouMGUeat6fvCQeDLrRsVlwxvX4TlX9R4arbGtxWIjl0n358nSM+?=
 =?us-ascii?Q?o54q/1/66mtG1pUGFN99MrC2qFEA1IRdYStQ2/1XoJeUcZlt014THNTq87L6?=
 =?us-ascii?Q?a2mhcQN8cjN4kDuMD80ilQYmTTaskOpJwPUWGRvXJOjVCqc8M09unBPRMVb/?=
 =?us-ascii?Q?SnXMy6pNZAtIkD65q8D66We5GqpLY1TsPIQ+hkWkVmSGcCR864DDcrPTb09o?=
 =?us-ascii?Q?JM49b+dVUSNr/P3msTN0xVo5W7MYssqvHsd4moy6mwUAsbMxRwnIyBH1ds56?=
 =?us-ascii?Q?KdPKmHwarK7n2SblfZstjQtij5hEMoQzVhC61Yz/XlmRicJfEcStt5PYdBoW?=
 =?us-ascii?Q?1hVjxN5j21aWwr9iOfHM6fi9bi6Xo+mjtf7KqF/Bz91Ak+o3SASIB8GXjrIl?=
 =?us-ascii?Q?4RldibgdQEwY2SjQxg7h7jSOrxb2Mv/WWNprBQbUjA2uWbteV2WFrwdWqRr+?=
 =?us-ascii?Q?F1Z0ogJPLVNM2BnjMx/IIAgFwm5fn4mHWYtGWwmkP/Kk15h771UCp2j7GCTk?=
 =?us-ascii?Q?pPiGk+k6/+a1dSQvXZPSCXgxGNvjzyxmEIfaUJPHJAodUlPHfP1lDMzdzdRg?=
 =?us-ascii?Q?Q+TbSFFiW5e92RlazBKM3gDZRgXijOnuVQdhvAVDyIdL3VteFYxi0KnbJEI6?=
 =?us-ascii?Q?HUCzEgXcvsv5yogpj7OsNoZpJanrU0L1QDYslPOQ0FQP4YApDxyQ1gLoSVhe?=
 =?us-ascii?Q?ojvLuBfLXRtucYf3/0+ItVL0kl/jttn2kwvT0jo6BXteo5Lk4xQTUOB+d8MP?=
 =?us-ascii?Q?QofBLMmcimgBs6oYwhvw0GocMTXH90Qrn0JeW5NFojMotQcrChDc1+Sbt0sF?=
 =?us-ascii?Q?QLsAARQ/s0VWiht/FxSMsPyXP8711sEt5TzP92AGu1CImlUa2V87nyJdLsHw?=
 =?us-ascii?Q?fWkT4BqhqWj3Eo4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:24:53.6744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f2b2b9-81de-4a19-a2ad-08dd768ffc09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142

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
index b28a1e6ae096..18182dd38fc1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -245,6 +245,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 
 	return &default_policy;
 }
+EXPORT_SYMBOL_GPL(get_task_policy);
 
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
@@ -378,6 +379,7 @@ void __mpol_put(struct mempolicy *pol)
 		return;
 	kmem_cache_free(policy_cache, pol);
 }
+EXPORT_SYMBOL_GPL(__mpol_put);
 
 static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 {
@@ -2767,6 +2769,7 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 	read_unlock(&sp->lock);
 	return pol;
 }
+EXPORT_SYMBOL_GPL(mpol_shared_policy_lookup);
 
 static void sp_free(struct sp_node *n)
 {
@@ -3052,6 +3055,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		mpol_put(mpol);	/* drop our incoming ref on sb mpol */
 	}
 }
+EXPORT_SYMBOL_GPL(mpol_shared_policy_init);
 
 int mpol_set_shared_policy(struct shared_policy *sp,
 			struct vm_area_struct *vma, struct mempolicy *pol)
@@ -3070,6 +3074,7 @@ int mpol_set_shared_policy(struct shared_policy *sp,
 		sp_free(new);
 	return err;
 }
+EXPORT_SYMBOL_GPL(mpol_set_shared_policy);
 
 /* Free a backing policy store on inode delete. */
 void mpol_free_shared_policy(struct shared_policy *sp)
@@ -3088,6 +3093,7 @@ void mpol_free_shared_policy(struct shared_policy *sp)
 	}
 	write_unlock(&sp->lock);
 }
+EXPORT_SYMBOL_GPL(mpol_free_shared_policy);
 
 #ifdef CONFIG_NUMA_BALANCING
 static int __initdata numabalancing_override;
-- 
2.34.1


