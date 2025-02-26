Return-Path: <linux-fsdevel+bounces-42642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22EA4581C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FCE188A1DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4305722423E;
	Wed, 26 Feb 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FAEHjlKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860B224226;
	Wed, 26 Feb 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558478; cv=fail; b=gJb2tVcRoRJ3sfZdplkIqvpXZlwAO0GfCQ4z9s/Q0iHgEYGlHgdgaodGXf2KLBd/kUphPmR3rH99NdkjWweJcd8goXK8OAmERd8zFu6YMBQMZxrj6V2QU4aEeMb61tajim7hiA1fpVwda5+5QpwdydAAoKaA5LgUOVS3iXgElXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558478; c=relaxed/simple;
	bh=E0rP/JMVExVDjcHKLnJ0uW+p2Yo4OmCf7EP85vGfhyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lp5+qx8XMJ2cOcaYYOFr+jzJ1Npgog2NoOZutqtikxcnbc4VAjPBO5hPLldi5226D2eywiWAHhTESVvIVY9R+Eg2u5wlhSRI2SVBKk68Yxtl8ahat5Raj/LBy4jW4WlrVHeqgPe83f+yw1IbMkiFFi11FPWUka7q0RpNM3o308M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FAEHjlKB; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XACF9FbezJZarYhSZa0FyrJz9c4AgC5cohR2ZC9f3lWyyYNHg+XGaWEeUh0nRuImV1jZ+6oRM8JQgFFQ5zLwq6kFNhY39tUdAMyJ4lZmWYwUpz2OlE6Md7nlXCPdzuGbMHq6tDS98LTBBzSChRdooS6Qv+Ona/yhF06IyeHFBr20csyBcoBGRPSAeAHGywnBO7D+zG18EHCkgm94Gx3P8DhsgEJUW7PrtI7DdqDB3WkbMciIiOfNhsaiV6eFGkFTxzcruEDAmefxUkdmBZv7KrO8kIDvQlxbN2nTkNl0ZoYUX2YZJG6fMP8SFD2KPXxb3J98POfG3Z5iIDBG4djI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nqb0jtY+YBE8UTi1L4MtyrkH6UifbjkFhzWBlcaw9g8=;
 b=D7/J6L5i5gLyG5hpjexOiDYl4dz2lUU6JdI4mIs5+WQStxq95y3yBkJ5QEUDsGd+apbm2fyuTFAJGucnYGKDv8l4am14hq9w3096jS8wW5B0eC89F7qkhnGfX025T/0s311rItV4YXYljjDc2gND35PxCDJdlnRbZS//R2zIExGcVLRwbp+4h4zOzQ8IpMWnVaBEEFiiHdAC4CT5VEIUSuWeVPcw2ih6TDgD6EHduKxBFS1zNEs+WgnaXmar8BEGgGRmCITC1Vc8m7deBiuhiiMUji9Ec4lRoWbl/O+lFK6G7kIyClFuulR+uTz1/QfPeDkkdFvTPe8zqiu9v1P8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nqb0jtY+YBE8UTi1L4MtyrkH6UifbjkFhzWBlcaw9g8=;
 b=FAEHjlKB1AwP69pHoIRcRIBdVIXbLZAg2PWYtVDp2IUmCyPk/O31HhZ78K6zBTjrAhhTUQ9fACaoERtbqX97OElAmPcevFTWpuCSgy9sB+Ai7WStn826oAHlps368OR9zGoCZU17DxGf8s9rQLzJu41RgS+OZhNq19QmRaH2JKI=
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by IA1PR12MB9522.namprd12.prod.outlook.com (2603:10b6:208:594::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 08:27:54 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::9b) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Wed,
 26 Feb 2025 08:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 08:27:53 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 02:27:46 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>, <tabba@google.com>
Subject: [PATCH v6 2/5] mm/mempolicy: export memory policy symbols
Date: Wed, 26 Feb 2025 08:25:46 +0000
Message-ID: <20250226082549.6034-3-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA1PR12MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3d053b-c0c1-4144-8e24-08dd563f76f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vPqJpuzKhP4iUmzxKcQPW2r0kRf12n/4B/ckcwliG9SebnPTf94JNqTcDGnI?=
 =?us-ascii?Q?5UfRXm/JzDjCWax0G7qdRzb1m4KR9+bWnLhi8/lFsWK51VDWKlnPyZ8G6JaZ?=
 =?us-ascii?Q?Z6B1JE4vAEVdmqjc6n0ZgrBhOywjTwzzJYUeHrZC4c/INXvC5u50Tjc8jynq?=
 =?us-ascii?Q?pVfFhstFBDwDohV2T+RAAT4I1rZDnfTJ/rWRUtNiim4GUJXIGeVBDVIM7Bbd?=
 =?us-ascii?Q?loCRy7NGHHYWOfnYU/r84kaK+tfSZSThnDTYRLT2KRZsIdoBqzmFr6szC5A5?=
 =?us-ascii?Q?uXSMyog+mo8lSJDh+9lXIKaFm8Ygs5ihtzuvvdrzKUwPHp1vX8Kk3EIYfmay?=
 =?us-ascii?Q?oxBDdnnndL9g6qwvmPa4Y4SSXKdbfZ6kw4YoEAHIzUzcjnZnFD2upfruMdrL?=
 =?us-ascii?Q?F3TKWT5d5MoY1/xf6GCM5EX8nPiWmQ3KCaWbzBB7gfSDT01KBo8bK84L5XlE?=
 =?us-ascii?Q?Eb7tZMwqGNJpIBhtHdOGfXlWBi3DRJV/A0OLNMlZRDkThnOuJto6Wzw+npEP?=
 =?us-ascii?Q?SXbeOZi3+0dCFxoLXGRhbLgkcWVdeWui3H00kcz77IU/dzM53xolfEJcguOi?=
 =?us-ascii?Q?lHXc2271nnJx/f0R0AcSH7d4XqIE6eO3ShK13mlU7adBEVOI0S/PXaLXVKI9?=
 =?us-ascii?Q?WUiJvBOfcv0DVD4S/6UTorN3qGxPNDrt9hMSJElAhyxakZxLLya9peR2zaRB?=
 =?us-ascii?Q?wlwBE8V9C68YojpZhPHo+rKCOq7bBL/UH+sUh95G8GxfyKflzDNfJ+e1tgvw?=
 =?us-ascii?Q?tKlP7FgI+dzoP2Uj3tbAi5jfFp/xQX76IVKWNY2rWiwUt5XbUBfEgjd1kt32?=
 =?us-ascii?Q?jVAtNOr2alzU9R8binVSkjYY3MvQsQXl/Ir8HCat6KdyueDaVTQvy8z9T0s/?=
 =?us-ascii?Q?Ug17bQaCBtVdOngmgw9pYj9rNWvkMFpSdQUfCd3Z6iH/+4ox9ejUge93D/OZ?=
 =?us-ascii?Q?47WAaDotDj3NM8Slt1/wNTkeUUvQ8R47k0KVwzPDlC52fMKle5AD3XgZuFSU?=
 =?us-ascii?Q?ez5m1sj02XruugzN+ay6GGmYOlfhij0sFyY48/PUFR/F2xsFmRPpfHWUPVSs?=
 =?us-ascii?Q?5FBH5cmhmSVQvR0B8Q4PSsTUW6tK4t5n13mZ7Kw9oM0YgP7/23BrL42vNeEF?=
 =?us-ascii?Q?O6J/KeZA8WOy19nUaez78aAfkBJHZ0g8OW8ONafUWl/t96ZWzjTkzXCfJJin?=
 =?us-ascii?Q?LgI1pC9pHx86+5ceJ588PkZV86IbHyyz1rrn8XPMVVWFS2qvgFZPH8iiyIt4?=
 =?us-ascii?Q?4GymGQaxpMekaFcWAHxXssm/k+7i4HXaYKDd4DKS4UOmp+CpOvrk9w/RIVy3?=
 =?us-ascii?Q?kg0kqIQfHPBKNgYp3dd8hjDAZAhD97+ERwgo0tsVELpklwvF+IpTBz+H8aTk?=
 =?us-ascii?Q?LgKC0HFaGqxzQYkSWKFOxmuIrrUhvF191p+LM3LAa67uVqTjISvn02mqiDhg?=
 =?us-ascii?Q?dN6w9RCuYJcmtF+HSoIPqZwfpvUUWqHCddRNJ+E1+nBcI3D6haeComepGyNH?=
 =?us-ascii?Q?diW3+HGeHCGonag=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:27:53.3557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3d053b-c0c1-4144-8e24-08dd563f76f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9522

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


