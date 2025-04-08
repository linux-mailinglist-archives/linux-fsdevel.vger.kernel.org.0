Return-Path: <linux-fsdevel+bounces-45970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAECA80074
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35571893C1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBC6269D1B;
	Tue,  8 Apr 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sVqyJoI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5E268C61;
	Tue,  8 Apr 2025 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111508; cv=fail; b=AWKTf6FA92m6u9yAOQGC6e4aOnYCFzBDhurfaoixN+iS7mi9Naw/K9Sckpu9cMvm7ifDz01sTLgrYThT5I8YYNFumwuNIv+hy+BzzJAlCagXTbHJhUvGmgeJT1izp24lfC707KJ+jWonBJliLAN5FXFNQte1dXpS/k4W4fPFNY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111508; c=relaxed/simple;
	bh=aAG1b2xEtAYKL34AheW09dcHsdsergw+mkvhYgy9jYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POWJsQJn7s9+9f4oJwGhevlTvEJlSBOssGyLvwckHhc1beuwZqU1i0fHT3hVy/m0/2ezb+9QCkeqwWFmOBxwrRNotVtYxqyS17kJ3+GH1vzNu/3vkgbu3reKq60lkYnncYT304l8HKHk8FYXt3+MorGZ9/vWfPqzeTFVyEDISQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sVqyJoI3; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+8eqQcwvkhoZ+ULoCanRLe72JPxtTWUM0zzjSdylZ79q+n1JUYH+fZN/pV7qJsomh8pmENq15X+3vFtocd0L2eD0KkLTmMy8f4wgD7gRGmcjydBv/apOJj1ZeUGd24T/nsWLgV5uMAKtHyLvaVWEZsC//E6FOOQEbZQHvna0ve9ZMsuPqkuPhxT9lLMUTygBdp+3eSKrRIg3hcUN7QtbMHcEFYURQWxlgAbsGRbiSFqAqyd4JtS8Tu7jIGO+GsXo1LMJ8zFi84CHR5GTJ/7d+4a4GtnHHFhkRGYWVPXMbmFwyTS3qd6cpi8vmcLGaSknNq8IRoG9QbSvlewW5zZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYHq9jnSXndSvuTqlUZsfvxk1dzgclFuAnLBjLJpGB4=;
 b=g0sJpEZOIQ05dWHQF8UU96MuMJkp2oRF2NBCOCc9nvbjvimYH7wAec2LCc4sf9GkIRvspe+5AEWeUtm4lHF7YsXjbmpj0O4noR+FATr/vGfaaZvsVk5b/7h7uOPv3/5Qz9WjinZxhyv0GC1/rje3405ZHdEVCoWlakKjo9q457BTDU9332ReprXnotlyxIsTy56b8PDbX0OYmzJx6SbSExg3Cten2vB/6hzxr/eOv0Rn2DVtXaCJUXuHy97EWjqvnHcvKncNm+KLH6PUGCoS5ZH9OYdYDxVRg+wvE1Dij9PGon22bbzDUWefsLDKCCyUlFiXaEAcCJ/KrfJVoNr7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYHq9jnSXndSvuTqlUZsfvxk1dzgclFuAnLBjLJpGB4=;
 b=sVqyJoI3autnWi1Ro5LcMY2srDh17clyt2logF/WFtB3HYUjwX/7m/ihNHZE3+3EKyOfs8yskiPifUwVz/MxFK03M2gL+Ppu8FrkKrMR4SzKFj9Fg7i1KT/8157CDgvkEC5NaqfB+s9kaTQo4g3dv97svrmDUzqQxViN/sT8JgE=
Received: from BY3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:254::9)
 by SJ0PR12MB8613.namprd12.prod.outlook.com (2603:10b6:a03:44d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Tue, 8 Apr
 2025 11:25:02 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::c1) by BY3PR05CA0004.outlook.office365.com
 (2603:10b6:a03:254::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Tue,
 8 Apr 2025 11:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 11:25:02 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 06:24:53 -0500
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
Subject: [PATCH RFC v7 3/8] security: Export security_inode_init_security_anon for KVM guest_memfd
Date: Tue, 8 Apr 2025 11:23:57 +0000
Message-ID: <20250408112402.181574-4-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SJ0PR12MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 867ce280-46c1-4e7e-852f-08dd76900135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1tele9hNbvM4yZewnRp8S4sFhwsugE0WMUwjfSJYoRE+nremhCnig4iKl9MD?=
 =?us-ascii?Q?kcWNOnNqK7gYj0a4wqAsGER6hhwkudCdjPuKp8YFyWHwSZiTeHdMdmaJXTNC?=
 =?us-ascii?Q?GNnKcszxkSDgV99RHLVLx9aQO7iECSHj+Q9yB2Vqrr3oS+s7lXWE8pYJrtUi?=
 =?us-ascii?Q?iNy6DaMspOxLKPPU5i3GoPpkHCZzvqoRbDIgi1Jl1Rhcp4oxrGv/XkmD18AX?=
 =?us-ascii?Q?jLORjlrz7DZotbcv+72aaFrB21I7BP9jDPimSVbIb81SQGCBdqccs96nMNs1?=
 =?us-ascii?Q?0dXZsabPJO2XAMrZMtzLpfSKNVkhEKSO3KhsVwj/bKI9hhSaZdgSn5e8zVSI?=
 =?us-ascii?Q?AG3dOSuEqjx3L4S4D0opBtqBCTFLko2AyFw+i1cBE3gIx8uEjb53AAw4c19e?=
 =?us-ascii?Q?nBuouA/I1kpFekTzUDC57/MQwasJhtroddbgD+p82+pxksoW9bsIxqzkaq7J?=
 =?us-ascii?Q?Oj23WudNJ53mc4dTYKH9x2NZEN/Hz6NnrKZ16tycTNtHM4OgMIxNupMVHaZb?=
 =?us-ascii?Q?f9gy3eMp/578baC+MCXJGQAsxWwsZENzUR2nJyD0kQVQy6RZpLLFLOTaaa78?=
 =?us-ascii?Q?fYFjXWly+jXcx1CXuQuiUOU8vD93zRRYEkttUQUm0+HVkrAzoBu2YKMM94/4?=
 =?us-ascii?Q?EcqU6zAu1Nn1PX5WqZ5fQFrFrULgTje8PvBQK90aW+7ybO3w9ZaDLVla71vq?=
 =?us-ascii?Q?MQVQLxKWe9YOptd4pTOfX4ZQQq3i8oLPzo+wx5oOUO1UEOpl5EGk3udbMWgr?=
 =?us-ascii?Q?XRrHjSfmAtrAekyiZOTrHB9hVWZ5UJFzJw8Q7hgeiVL+S2yqtBS7pc/G+YFI?=
 =?us-ascii?Q?zbFWUbSwKBJsKNiSqlRyI+fqpfr1mhGqOZ5xTE9b8goOukktr4Q0VAzniOT/?=
 =?us-ascii?Q?/XEC+mCHNKW0+4sFB4f8QuRpLCHILNQLGdF291MOH8rvJkDD+JCmxt3I2MnT?=
 =?us-ascii?Q?/TbhK+aFeUvEY3qzEXpyVAU6m6ObjsZq1iZGXHaq7razq4B8xEstdO3LG2vg?=
 =?us-ascii?Q?n1Ph3BUg5VUFdo8XOQCtgx8K8Ox3EJdtzgDRLmxP1qgJc9Misq/tj3jJKbHj?=
 =?us-ascii?Q?/YQ0XyoP+Mpc1RleRTgHYoFXjro0ffl+UvS/GoI5IrbREVKFYQfrG8JL8oRS?=
 =?us-ascii?Q?7AUwntmziNVTYOXDJcRF8YFxxmBJPP5UJlsCtUXbk6jVLsVdMR4q6dlI6Enh?=
 =?us-ascii?Q?ho2FzFRbSfBglue2FsoBgmuLcoyXWPU/RXc1nageHZN/yQQpqbKKJs85pk1f?=
 =?us-ascii?Q?NlsAn4ryloNH9ajyCfzl75m2FhggWCILerQvT2VAo9nKkyRk8yxkDQ7ddIty?=
 =?us-ascii?Q?RzW6O9iLJzR958wAmGF7jCZUy2eV8MSxn7tB4s5cjNvuDkx8yjxKJBzzyb0q?=
 =?us-ascii?Q?ED9RfidUoT1CNEYhPhxVP+T0Nv5cbZ0ZNaE0beRO7NeXwED9PaSOCReqnGjF?=
 =?us-ascii?Q?NFRET7WVT1ln3fMYyUY+N26SpqRr6xk2wnAxyBFVhYjox6Wy9pI8gmsj4aMc?=
 =?us-ascii?Q?Sm+nVE/djn38pJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:25:02.3506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867ce280-46c1-4e7e-852f-08dd76900135
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8613

KVM guest_memfd is implementing its own inodes to store metadata for
backing memory using a custom filesystem. This requires the ability to
initialize anonymous inode using security_inode_init_security_anon().

As guest_memfd currently resides in the KVM module, we need to export this
symbol for use outside the core kernel. In the future, guest_memfd might be
moved to core-mm, at which point the symbols no longer would have to be
exported. When/if that happens is still unclear.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 security/security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..097283bb06a5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1877,6 +1877,7 @@ int security_inode_init_security_anon(struct inode *inode,
 	return call_int_hook(inode_init_security_anon, inode, name,
 			     context_inode);
 }
+EXPORT_SYMBOL(security_inode_init_security_anon);
 
 #ifdef CONFIG_SECURITY_PATH
 /**
-- 
2.34.1


