Return-Path: <linux-fsdevel+bounces-57275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FE0B202AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509913AEE98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F292DEA74;
	Mon, 11 Aug 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="01lttsQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355992DE1F0;
	Mon, 11 Aug 2025 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903314; cv=fail; b=HC6VO+E8HxLMHTMGmXf2EuFXCPp0K34NPmoYHmMKI5f+TlfMJV/lQsQ3jlOp6NtIra2MVlexQ1GkUradKCfeXG11+F25OLyMChf93HA/E7k75VkufFcqab+sBg1Us/D6pLZeMlVp/K2t2eMt8uSXpAKQ8kM9qdPa1WQD3jjrhD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903314; c=relaxed/simple;
	bh=XcNfSml2ZrS4kfRGAqbcw8Q+dDji53exfUpTAuc7S3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oooFqnoXyw80LmpyHTL94esCEHx/AzVydSnSrZVGlRpqhxMCy2FXrfWKPxsIsAXg3iF7JYB4zV5+/0SCH5ShFQWSVNJ0+227oHAEQ0PY7tkYEwp4u/KQEPk20J5vY8FkncKvkBPf77u9Tz9u/t3LSQz9IthsCcPyHHfRVdgZips=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=01lttsQ3; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKRtYUn1o64d9AH0vFP7vF3BSRXZ/H6BmQZ7mh7NMV/BGNEgATjOmaRd2XayZ22A3DFjSwwq6giMiKOOB0ze1U3iLdcVNTiZzgPjTW96sNktU3sDrrsYW6O6qrFX9wScOmEv+gkPp+fOZ123gNcEC6FPqqCiADf+P3UzpmbV7u4BZit7/shVvncGK6/GmClKr6xyZIWvjRoJAWsETLScZsTA914StK0WysHGxnCf+i//vZgeX7fvoy+dRCfq66HX2yo05R0waCwZp/fRv9vt1leJ72bJScFeff7msCBSc89ZSba8e4TNA92jfSOG92RAHHoUQs/jR0RMxKhb5l4vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q6fr2snxcPjm67BulbUwFEIA0kxCdNbJpLJKsOATvM=;
 b=q9NxeJoTzDDk7tI/55r5EXCE0yqUZReLooWPCpOjzpIFwE6NLPhRmFvHzzYr4Avw0FaNg1QSeV8gSl9WtF0cuxSNZkasgVHsgPU0qlhOOohaIRRTjsEcPe//GTUC9+44NTySzbQ6/UDAzGW6zsIQO9KnCu/ldCGCZdUYba07ki1IpO3clXzljyRI4Fr//Gx0m7/KT4CfhwU5a02x7ulxKqHUPH0hoGSYErQpkFChi5P6wmNYtFyhWX65Fnpw5i8ykLBI8qe71Zf7HtdgtyYV5dT45VyInfyAwQHS6KVvRA5fCa/H5n6sRnhXA6hx+O09sIsfLFTiDU8Msz+ZAdezpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q6fr2snxcPjm67BulbUwFEIA0kxCdNbJpLJKsOATvM=;
 b=01lttsQ3oOLQaYfeSx9xiCh1LtIE/5IwuVNwHewH41pCcde/rC2wJ9U3a+8KjkdpSsKzYr6EMqj9vLRP0VzB9buHFUTL5SLIF/xKdsFgJ2AF3rtQ6R48TTOxuN/DxR3Xuh2AXa8yPhMRnS/3DBLkNHm2k6+fmwLQmQiEUycKmQk=
Received: from BN9PR03CA0379.namprd03.prod.outlook.com (2603:10b6:408:f7::24)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 09:08:26 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::6a) by BN9PR03CA0379.outlook.office365.com
 (2603:10b6:408:f7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 09:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 09:08:25 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 04:08:08 -0500
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
Subject: [PATCH RFC V10 3/7] mm/mempolicy: Export memory policy symbols
Date: Mon, 11 Aug 2025 09:06:04 +0000
Message-ID: <20250811090605.16057-8-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811090605.16057-2-shivankg@amd.com>
References: <20250811090605.16057-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: f382ad3f-e898-4965-0e39-08ddd8b6a144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KZBZtdxz6XzksrUYsaZpxtDgub6y1fGvn98kJg6vk2BoqXZkm1h/RjLzkOV5?=
 =?us-ascii?Q?PFmOzBwrtMUxcxesRyY/Jbo95snPcjkNWJWZexveWz1DyDE9DmLZ6yIKn5pg?=
 =?us-ascii?Q?2tew8IsSmzV7/P3WRMLznt/Vx5CTp6Q/W28WbxEcL8eb2FwMd9IZyGB7Q7yt?=
 =?us-ascii?Q?qeuSy5+RtjWCfDLNZlLmJgg0DYJZeIBJSoJ7deHdzt9DcrwXzXfLgbTZm5RG?=
 =?us-ascii?Q?yZlDY2ZtxfDnPfPLb+VhCj4tYNk9W7XNnV1RxUVlgkSKLTyooo8I49ro87OH?=
 =?us-ascii?Q?iSqKxaeYjhP+EBl480taKl0iBiQ/NOteUZGW0WOVchbO47UXgWItX7SRJXCM?=
 =?us-ascii?Q?3QyR/YzFUtRHIIGRwFvDkOV0HP/G2KysXcQF23c7d1QLtjofxDgvEaEpzFjU?=
 =?us-ascii?Q?VJL1hmp0Dc6a7zyL14ASDA4+Hdg9idHAD0DwJXslP8bPsrpaIinErQI6/HTw?=
 =?us-ascii?Q?DbxgoWvX2dSbQrqAf04S0d/00FsNUK2i5dBRbl8s/YZZ8Xpj/xdqjiMnCnav?=
 =?us-ascii?Q?14ZwUx8VnwjdlWSUytc0gTD/nCJ680uoQ9Jp26C+/flu9INn+b1XTH6KnliF?=
 =?us-ascii?Q?MFpEslGQBQlKtp/tf67ccCGuSwJpnAuROCgkStv2e/EeQYzIC2hMnWS2Z1uY?=
 =?us-ascii?Q?RBPj6bbJK3hy+c7XlXdtMRWVx/TZkn5d2DbmzyC/6Yk6DIVEHZMHObTVgnoD?=
 =?us-ascii?Q?myQMI9yvtufa5TPGZwVTPPcFmK0MV6lw+NBnB3SA54TIHlskQXDX/UBzjcuw?=
 =?us-ascii?Q?Pkxi3zrWSQ01uKmqsmjiLAoAK9ol3ZbdiStnyKmuYxKCZyjxgCVYNfkXYKTO?=
 =?us-ascii?Q?LfF1EWWptKRoyqXkybDBkhGCC8o58dkdIWD88EGrWdt8Yi6K8i3GwsWQIcbM?=
 =?us-ascii?Q?Xoos5Q9CKuERjLSMM1FdEtV/txfuzk844zLh54JQKqqWhAv9MQzuzgy/Zyg0?=
 =?us-ascii?Q?h4C+cc5eXr4IIhyq5+D0VUS6Updumo6MLo8n92LHbYHUGhe3EXNmqJnrU7v1?=
 =?us-ascii?Q?EHu99klhW5uUk254NxxVTW7ehUygtIlbuRAjXGNH1AAFcNdNq2muMW7xO2qD?=
 =?us-ascii?Q?ieHfwYdTdelb7SQTWYL05hnuyIyNJm+nBwy1gKdDATwvxXn3Ux7Cqr4Qn5Xe?=
 =?us-ascii?Q?lcCnKw2F+pi8NO48MgeqjDAkwE9V5KpEKayI00cTibupOa1FFZBbHiwPFsc9?=
 =?us-ascii?Q?FNZ4v6gn5oslNA4XHW5Q1clrga3vwx5eaSWjsshYvF3nuYLGO5rqweudnUn1?=
 =?us-ascii?Q?dajJlRMhvhuyi1t9aP5JPg3qYCNQld5v1Ej0805IYlJsaVN7z1Tv1/oGiUjs?=
 =?us-ascii?Q?33H8iEN8AmuucwJe/yha4Ul5bAkkUYxgOwI+3DmPzhaTpCjXeu67rjlgTKcN?=
 =?us-ascii?Q?hlwAvS4IpaZaVbyDE7yig0DmjSOaLW3Ow9BZuhW3qOs7lykfj1F4lwG0w3X/?=
 =?us-ascii?Q?w+JpUZP357wdqrEJU6sgl+pO2VvmwptwsBOxEuSgPPES4hQw2HMwwwNCCwAR?=
 =?us-ascii?Q?poBGqqGZYf4ruQ8fPr7+2hM/afeGgHNAbzjV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:08:25.7294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f382ad3f-e898-4965-0e39-08ddd8b6a144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

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
index eb83cff7db8c..d385202306db 100644
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
@@ -2885,6 +2887,7 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 	read_unlock(&sp->lock);
 	return pol;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(mpol_shared_policy_lookup, "kvm");
 
 static void sp_free(struct sp_node *n)
 {
@@ -3170,6 +3173,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		mpol_put(mpol);	/* drop our incoming ref on sb mpol */
 	}
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(mpol_shared_policy_init, "kvm");
 
 int mpol_set_shared_policy(struct shared_policy *sp,
 			struct vm_area_struct *vma, struct mempolicy *pol)
@@ -3188,6 +3192,7 @@ int mpol_set_shared_policy(struct shared_policy *sp,
 		sp_free(new);
 	return err;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(mpol_set_shared_policy, "kvm");
 
 /* Free a backing policy store on inode delete. */
 void mpol_free_shared_policy(struct shared_policy *sp)
@@ -3206,6 +3211,7 @@ void mpol_free_shared_policy(struct shared_policy *sp)
 	}
 	write_unlock(&sp->lock);
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(mpol_free_shared_policy, "kvm");
 
 #ifdef CONFIG_NUMA_BALANCING
 static int __initdata numabalancing_override;
-- 
2.43.0


