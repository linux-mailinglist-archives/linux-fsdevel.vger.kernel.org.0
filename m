Return-Path: <linux-fsdevel+bounces-42056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0282A3BB59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007703B2289
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81511D5165;
	Wed, 19 Feb 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aVdx9rNz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF92862BD;
	Wed, 19 Feb 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960196; cv=fail; b=jAgKB2pJUTAWulrGxfbNemtEOKLDy2YyupxRotj0NyrZp7AFGWYFPMCflxKzmQB7nTCE6XsDqeUWZBp5Sstj8Y3+7bDLN7ZeiHBLMsSlMzxNALggPSAI5p/5qnjoI0o6ria0ESUWL/it6cDVxF2zq67p1Fu+T/DFzORh//uhTdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960196; c=relaxed/simple;
	bh=E0rP/JMVExVDjcHKLnJ0uW+p2Yo4OmCf7EP85vGfhyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYZFp1IaoCehodRHu4n3MmxgmemB5+n3n9pBtkxsPA1ERuXGvxm3hJqrLGDCJOmuZF8/37ty92ixavfL7PJyLLFUuLgo55uw/MeJtvLR9PHs2TdvFkyBN8Umb4OVfpEPey5FQ3dnh0YdM6QRjYxovbrVs1h9q4q8Ts2vGicxwOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aVdx9rNz; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSFzALFh6Ex71sAGv5+rsSmyT9Nl2KQcTp+/BfcfFE0yro7xjMW8Tw5BAgtqP5SmoOiDsWwfRKCIZSWPXCFGRA5bEMPavkQBorNi4eMUU/tqLGewDsK7F9ZdcchRv6REBwD3VtfS220rwOzw6eAiIDS9r9spR+2pDnXQ8C1K0dkRSde5lLPk+Hiawh1CJJchj3VJTZhdGk4vEOjMDhPaAdoVjJfj1/3vNpqtqeZ2fst+0+tkL5HzjOLVXYI5BMO8p9EBb8b/nblsJXvbtqYVOcX0psMdImv25M/RvggVfn2oVrV2s9VdO/P1zdYUTzcdK22PHiPPqlZk+B97/A6CNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nqb0jtY+YBE8UTi1L4MtyrkH6UifbjkFhzWBlcaw9g8=;
 b=bDPx8Sz46mZ9zuSe7193iaOUtjR6X5FOgwM+NV59WSqO6vZA+CXdG9BUf43q5JmnpO0j3/24bOu/FwbttW2Cr8xbXgoz36kC5HEzs6G/AAflKGmhDhY8GeBHjJecLFh1t6CjBTYAj5ngAwnBI7CEjDCF6UCWSsDpQsJxAfcF+qGw7B2GfvO1N05Eu0G1qM6OD+Em71ecd12u17ien1kwAqGkSFgbQgKtSH//qxwd4Fx3FtUkjNnYG9fW24pQX1+Qksgynnjj6cOljqO3Qji4MX0h4gy5mkv8gV+vUOzP1qSqWuWQ7RvF26NXtfvsOoD+/+sNsR8BCJC+e94GUo7z9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nqb0jtY+YBE8UTi1L4MtyrkH6UifbjkFhzWBlcaw9g8=;
 b=aVdx9rNzJhDUfYXOvAwwY5fkt8Mma19xs8AkqRqCHCsj2GkGZ6KYEgfck1HPRu+VDwdyC/o4XsWbAbrw2LkQAOS0ZcSbuauL+iJ8sEuw1ES+2zMDHhhoGqcxR27DlDgY7NHFFVZY4qTa3CMOzBNt9AiAOSqOT6qm/yyomGQBzow=
Received: from DS7PR03CA0354.namprd03.prod.outlook.com (2603:10b6:8:55::12) by
 MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 10:16:31 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::94) by DS7PR03CA0354.outlook.office365.com
 (2603:10b6:8:55::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Wed,
 19 Feb 2025 10:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 10:16:30 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 04:16:24 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>
Subject: [RFC PATCH v5 2/4] mm/mempolicy: export memory policy symbols
Date: Wed, 19 Feb 2025 10:15:57 +0000
Message-ID: <20250219101559.414878-3-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 58eca7c8-cff4-4fd5-44a4-08dd50ce7ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xSmjFw0gylpVL3+Fpk7+LmQDjEwN+BIv98+/UBtZ3beMKHMgYQXP9/YX8VET?=
 =?us-ascii?Q?gm7qn2RgWa/eoHnAboaf+TWaRyr0QHThoxM+zQAWuMfR8MZfGyctVBr26qbZ?=
 =?us-ascii?Q?2zB/+A7pJWSBOWHLx+kYhGR2iEzBa8l1dgAojaSpCr/LAj5JbfCnIiGWJra1?=
 =?us-ascii?Q?O3wJUt9q6K/INUG67Pdh2ZkDrYEZ86BrnfIqCa0CTK07c5KYts2n1aX4/AQU?=
 =?us-ascii?Q?h0vr3uBPkWvEhbiQ3yCGnoENHVQy01PRxua0CVAnkrxGd7vL8QY3lNT9U4ks?=
 =?us-ascii?Q?jbds3XellA2gahlrt7VGcGQ6xIdkSyfzE+1yl50+4a4rlUTwQNuiYyZuYk9G?=
 =?us-ascii?Q?XDRzTPqbnkPLmglKjwur6Mif0Tp3hPqooEuu3Ku+r4ly1fUTS2jVo5aupwCa?=
 =?us-ascii?Q?Q0gVD+Xa/ocLV3D/Lp7e1olQ+mLyA1lz6e3JtR26MWqII00lda8y6//tEIWw?=
 =?us-ascii?Q?IuScSADA3z/+Ukd7h6wYmVfT5FUeixdGXZqeHx7yrJGbWxby1wAskqCcVVwX?=
 =?us-ascii?Q?DLU3LQ6nFwjezlUYqJgoapKTDMAEGOWA0urHdHcHG5VynTAAS+AsWVfoaSAv?=
 =?us-ascii?Q?gVxvCExEXxBDUAGJsJQ2cGKLN+vnzvHv7HnDaMgBWhp3I4xdVdu1kcrABLQL?=
 =?us-ascii?Q?gDxU/MeS8AoTD/gXLP26Sukf6jeScGEs3JPIH0oO5aWQ2sFVhH5F70f43Uvy?=
 =?us-ascii?Q?ghbNogtZfLtkE+n4fyp4OKzQBao+kv/2WuH1M9x+m1DaiXX1VJ46ZLQJm88R?=
 =?us-ascii?Q?vBY4uMPmm/a4x4oyvVkmWLSeGm/mWGYPDIPim0KtZRkwWUaKSfSunhWlVKWv?=
 =?us-ascii?Q?gjhvF98qq4IUA4Jar/8/zJ68y0g4OGnPiMN5BAtSFxNKi/5kyYM80IE6Za09?=
 =?us-ascii?Q?yUgWl0nKwrwX2W5YaaSqJz0Vs86kMnI63eFudv2UkcPZZtJtmiQj6JpO5rxo?=
 =?us-ascii?Q?lu4NT5or8hja6wOR5DDjHR6iaotpv3KzPDnNnuXg95DYvUyb/kQVgb5Pi+WM?=
 =?us-ascii?Q?AmSzWDnZI9CywZORa/2S32J59+gfPtlOSldegzJa9ULg+i/Np8SB6w8FIWPf?=
 =?us-ascii?Q?554RiQig8SPG6+4Al25nJdzNm8K8riQ+kchRkMeCuGViLm0nCdnYeQ7jzHTT?=
 =?us-ascii?Q?QxUJZzM8lWvyNokB/Ut0OCHfm7BuBEyKsMZ/CspP1zr3y31CIMKDHhbtQdub?=
 =?us-ascii?Q?Xm3XpY0JStZh06k29lfav7IUeYlc7828dhq0ptBFIUeZ5hBzVOuaOekZhX+T?=
 =?us-ascii?Q?Q7RnttR3at9bPnRFtaa85WQC1ZLCZfx8qOQ3zi3XVhupFfPUzG20fkxZ8yxC?=
 =?us-ascii?Q?uMPmswslLNVKFNbNVrDkRV0jaNE+qOkM2lcVlaaS1x0h3krdyaIt0+3QYlGA?=
 =?us-ascii?Q?inKYVFSs/SaM3MYgdmzcKzv9Yp2vOIA3bmeNDXFT1GnJnTmUtmG1b5aLmrLY?=
 =?us-ascii?Q?oBN02f4koXTwsRIzRBO2fcYFFnzYqxP4fPLw9JlY5Z334hYVg/zA/W48OWna?=
 =?us-ascii?Q?5aeSTjYGt/Q5nwQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:16:30.7922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58eca7c8-cff4-4fd5-44a4-08dd50ce7ab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392

KVM guest_memfd wants to implement support for NUMA policies just like
shmem already does using the shared policy infrastructure. As
guest_memfd currently resides in KVM module code, we have to export the
relevant symbols.

In the future, guest_memfd might be moved to core-mm, at which point the
symbols no longer would have to be exported. When/if that happens is
still unclear.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/mempolicy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bbaadbeeb291..d9c5dcdadcd0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -214,6 +214,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 
 	return &default_policy;
 }
+EXPORT_SYMBOL_GPL(get_task_policy);
 
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
@@ -347,6 +348,7 @@ void __mpol_put(struct mempolicy *pol)
 		return;
 	kmem_cache_free(policy_cache, pol);
 }
+EXPORT_SYMBOL_GPL(__mpol_put);
 
 static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 {
@@ -2736,6 +2738,7 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 	read_unlock(&sp->lock);
 	return pol;
 }
+EXPORT_SYMBOL_GPL(mpol_shared_policy_lookup);
 
 static void sp_free(struct sp_node *n)
 {
@@ -3021,6 +3024,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		mpol_put(mpol);	/* drop our incoming ref on sb mpol */
 	}
 }
+EXPORT_SYMBOL_GPL(mpol_shared_policy_init);
 
 int mpol_set_shared_policy(struct shared_policy *sp,
 			struct vm_area_struct *vma, struct mempolicy *pol)
@@ -3039,6 +3043,7 @@ int mpol_set_shared_policy(struct shared_policy *sp,
 		sp_free(new);
 	return err;
 }
+EXPORT_SYMBOL_GPL(mpol_set_shared_policy);
 
 /* Free a backing policy store on inode delete. */
 void mpol_free_shared_policy(struct shared_policy *sp)
@@ -3057,6 +3062,7 @@ void mpol_free_shared_policy(struct shared_policy *sp)
 	}
 	write_unlock(&sp->lock);
 }
+EXPORT_SYMBOL_GPL(mpol_free_shared_policy);
 
 #ifdef CONFIG_NUMA_BALANCING
 static int __initdata numabalancing_override;
-- 
2.34.1


