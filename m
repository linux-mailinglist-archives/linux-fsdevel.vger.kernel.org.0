Return-Path: <linux-fsdevel+bounces-41367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBDAA2E439
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 07:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E30F16652E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD8B1A4F0A;
	Mon, 10 Feb 2025 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CRnGF8gA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A23987D;
	Mon, 10 Feb 2025 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169545; cv=fail; b=WF8kl1Nu+DVw6DzHxFQQksaiR/fRjNYAoiiRLY4OA6wCb4O8al7gMQvP55hFqJDAkQSeGuzGMrhPQh1nDzUdsUWVSXcTqDWEORyGz6zLYlQKCdR5fO63NxMnNBn2BANuVgXzj+/c6CNVtVSSBFyAu61hihYAUqwyMCnuvOFE7N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169545; c=relaxed/simple;
	bh=D+wLC4Fdnbz6o9C25toMvmJFcey3rMVvF4W+h8VrB0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WielhCtPkY6cbMb72TDALj1VPwjKKLu7nQRLzlm7WsmjxE2K1oL4USj3/yALfNN9b+IqsfdcOIQ0O8sgEVTh2gVXelivg+FEYmGo4f1iGnG4Yu4Np26ZssJvabEcWoRy24FDBHynTZ//UhG194LN9TFqWtrEeU503KnhGrlAlG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CRnGF8gA; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0BLAwzYHadGlMlUpE/UpFURc2X7Istjj+D9aFigbv9uESy0wNaKcZEvbidSiI0MnJq+CUraCfQPRUpodrLVKBs81MnwgXEHZ+W39R7wv8QLFng5lI7M5VK0k+fcrVPmb2rzwjv4TRQOQoWfppLJXHwon5OP4y6YB+ISJt+5bLVaDk29PDfV9Qr/krwyNvTgNTu+kMu1lqfV7X/oMGwdKXQvrjNeyYsinrHiIQDkhsdpn3L17fbGx0wN+fG2JKxm9FCmrfzcit9Ln+wSXQ9MzrQXe+opqHOdM4NvEH+XE/2h6LKGVtLxqAbJL4+7PZeB/gdUiS5cfxMNB1w8BIRhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5Mxbbtw3oz3yU7GkS2l8DQ/1dodFTGqb6nIsH8nUP4=;
 b=C4O5QOIkFTZNp6MDm4BxS1TN0gOqM8SeEnrmZXI7TAcWN+fNCjkXfqCkupWzupUkoG1iJsyjVXh9hmgbknlXcNJ5d+6uJEZT1HFIUaJCc7pKK6F4OVC532eWPZkQ21+vlR/HNGT4UXWcH5YpfV7piviJgK0zG8vVBv3F/36VkYtH76c4ZZm8Cs3eNRDVjNzQQJL298GQuKeBb1o1s/GWPB5E4yxEBxVxmZTcYbcwsYA/pl6B9mrptYYZKNiq1467JEf5t0zh11KM9jqDsCqb5cUM8KUVCMPLB5r+R/vn73lxqEPK7zUiL5Ni4x1X2VtRj1K3/5kIK6vVniAwqHviPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5Mxbbtw3oz3yU7GkS2l8DQ/1dodFTGqb6nIsH8nUP4=;
 b=CRnGF8gAvjY5HzMHqqM4BwccznM9+KcsrA1xfKjiGpJb0vUMSXLGEpLaZ/WhDtuzmpUt9kyYE80p1/UyyhvjLjfkX4sRba0dV80jFbgsDdbKp8CfToME5taz3lWwvdCRhSIl2Oy4AIZ4iI4UvWGu9ybtkTSk2sC0yUv0LUDpy8g=
Received: from BLAPR03CA0047.namprd03.prod.outlook.com (2603:10b6:208:32d::22)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 06:39:01 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::b3) by BLAPR03CA0047.outlook.office365.com
 (2603:10b6:208:32d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 06:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 06:39:00 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 00:38:54 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>
Subject: [RFC PATCH v4 2/3] mm/mempolicy: export memory policy symbols
Date: Mon, 10 Feb 2025 06:32:28 +0000
Message-ID: <20250210063227.41125-3-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 6817be59-455e-4336-8d09-08dd499d9a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mCdi0pV0JlrwoxpriC5aXTSUxzmUF5V1Eje0leH1hRpQWMfxphnZC55Zou/d?=
 =?us-ascii?Q?+v5DRBzC3X1m/9loKhJt2NUTWhlIsMWtFwhCPurOvf0Nrb/Bt+EjOfBNzyPd?=
 =?us-ascii?Q?THmgCC2mlV3aaEkY+GF2XYtCm6pDqQQFtFuYW0wDGoBmQ1cMICeNe8J3Tk5g?=
 =?us-ascii?Q?AwKjYZWNZjQ3rxoew4xSmIF8T8iHzvOsUXHm6PTdI7iE5FipdugFK7CFaLXE?=
 =?us-ascii?Q?6xsyLsKz/+HuqwR+961Yakx9emNgFcQlAUdl8iiKsGjM8qSP1aUosYCGKUAx?=
 =?us-ascii?Q?f/s+XVVeelpTHeqH6kWxd9kx3UDzwUmIaDDsR8jjqzAiqbCXCXjuwpqbKkwM?=
 =?us-ascii?Q?SCLofaOMvlqUEwd+OZtA4TwaPhhysevbnOVs+yGrIEu0gPM7oec7Ap/SgQlG?=
 =?us-ascii?Q?Qq+e0ZtP8xhhzJQvaBmLZb8+q75EKHCTt+9gWB2b5vgru0qx7Tq+uj1MfvIK?=
 =?us-ascii?Q?Ux03dleMKT6K4njMNuRboUsBrUuqlxLI27D/BHrY0pBrR+rurihIlwBIrRRu?=
 =?us-ascii?Q?bvPStre4rVrFe41grK4RjNi75KsXgDpdpdc2v9LOXRUawkszdpckkjR7oB4i?=
 =?us-ascii?Q?AETOiYCvcM9W/xYgwbNxS3EJwudK6QlBW5mHnosvu+i/wkOADtZpKwoTHtOq?=
 =?us-ascii?Q?+Qcxi7naZImBEdBaMn4R+RlGsHerswG7LUcWIwx6DfZRoL2Bu4JnoYGeAcz+?=
 =?us-ascii?Q?ZaLtcm005jbtFeg7wfI4nU/zVpSfnQRCjlIW9LRi994mp7drsFYWk6kypISY?=
 =?us-ascii?Q?1gud7NVWNc55HlN4yAhhXophxTUL8VkW3fIZ+D2jkDkFmysYv+P6EMVcPN0R?=
 =?us-ascii?Q?QnmzxuhKcv+MgyzvujwMJmbDKD/feCLBL0SswARfLbwnBbfZd1VzjM7yuWNp?=
 =?us-ascii?Q?nqZvymIqWN8uuKnq33GLmf/unRVvMIN8ltPFLJcW6clgOWV1O5R/lBBspLsW?=
 =?us-ascii?Q?jRaChcxgaRnpASlJuC2Lz0gXZTg9RP+9agrR924X93/J7RTvsmkwhDF2l+7J?=
 =?us-ascii?Q?b+Irf9GNz0NwOWmm57bcTUtXbb42jx1nYyHAEqeIppgzcftQwJ4p/HRmqLOS?=
 =?us-ascii?Q?XIAQGtF21QzOQT1L4SSH2SndLI7SWxXkfXDZiAmfkQv2uiApvaMLBo/b9Aty?=
 =?us-ascii?Q?QOfwM6KkJqoa8vMs0yhFp6bIR9CNu+7TBUTMh+7lSJioBWa1zQ5GZAr7fCV3?=
 =?us-ascii?Q?Jih0fMyrLmhaPt19BYZp2tMr7EYfyiObQmqEMNjeYF7Klxk+xesiyTGLw0pc?=
 =?us-ascii?Q?CoCUq8QQxWK83lg8iJy+S5C2F0BfLKHAe93QMtpYuYXvDjEeQAr3i5XZj1yR?=
 =?us-ascii?Q?MpZn2ikuyN9vuLpirTC+mu8J02z84kq+SIXygGflH2dz/bToxekKFfD1sr7T?=
 =?us-ascii?Q?Cru5k4SLX+xEljYP3VuD7MWT662pBBaW0bKYsJaGIQTcDo1EB+frSYnSncUH?=
 =?us-ascii?Q?m+f0Mzy4wkvm8wVQZXvmH71PKeeILbMCaB5PKNNZp10jZvdyqesibUsyz8Gh?=
 =?us-ascii?Q?SePOVmnMQDCvQiY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 06:39:00.3950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6817be59-455e-4336-8d09-08dd499d9a59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698

Export memory policy related symbols needed by the KVM guest-memfd to
implement NUMA policy support.

These symbols are required to implement per-memory region NUMA policies
for guest memory, allowing VMMs to control guest memory placement across
NUMA nodes.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/mempolicy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bbaadbeeb291..9c15780cfa63 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -214,6 +214,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 
 	return &default_policy;
 }
+EXPORT_SYMBOL(get_task_policy);
 
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
@@ -347,6 +348,7 @@ void __mpol_put(struct mempolicy *pol)
 		return;
 	kmem_cache_free(policy_cache, pol);
 }
+EXPORT_SYMBOL(__mpol_put);
 
 static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 {
@@ -2736,6 +2738,7 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 	read_unlock(&sp->lock);
 	return pol;
 }
+EXPORT_SYMBOL(mpol_shared_policy_lookup);
 
 static void sp_free(struct sp_node *n)
 {
@@ -3021,6 +3024,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		mpol_put(mpol);	/* drop our incoming ref on sb mpol */
 	}
 }
+EXPORT_SYMBOL(mpol_shared_policy_init);
 
 int mpol_set_shared_policy(struct shared_policy *sp,
 			struct vm_area_struct *vma, struct mempolicy *pol)
@@ -3039,6 +3043,7 @@ int mpol_set_shared_policy(struct shared_policy *sp,
 		sp_free(new);
 	return err;
 }
+EXPORT_SYMBOL(mpol_set_shared_policy);
 
 /* Free a backing policy store on inode delete. */
 void mpol_free_shared_policy(struct shared_policy *sp)
@@ -3057,6 +3062,7 @@ void mpol_free_shared_policy(struct shared_policy *sp)
 	}
 	write_unlock(&sp->lock);
 }
+EXPORT_SYMBOL(mpol_free_shared_policy);
 
 #ifdef CONFIG_NUMA_BALANCING
 static int __initdata numabalancing_override;
-- 
2.34.1


