Return-Path: <linux-fsdevel+bounces-33687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323799BD2E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 17:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561061C20F60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEE51DD0D7;
	Tue,  5 Nov 2024 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XcYmzc9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B317A583;
	Tue,  5 Nov 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825759; cv=fail; b=Al4zc2jpkGOuUWG0e65GRqfVVrePV1ON/VbaaJobKv77oBXmHU32ZTJ6nPiubOg/7DtWiuHV571LdbiDHkRTdhM8C0kteNRe9vlMQL7BsgCGkubVjkgpB5Fx37qoHd+1CekqdOg1RKaXert3B3zs6nnP1a1272dEV5cQAPcYgWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825759; c=relaxed/simple;
	bh=jwimxez9sPMT63zFln3TB1OGmA+o6K2ffCledNKW5Jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTHQQyZlpMV0muivZ0jAIf9fmTH5k1sOvmcQiQqmwynZ/pTtauM680h8nAVUpZgq7DqE6Fp3mtBjARSKpasjuaWoGL/CkbChKsLlRZFo+PHWLqnHHPP0fDpkBii7rU/3iG+eoamFF4c7z4Bbmxd7DJ4ZIee4a7KdCLFXqK5erzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XcYmzc9E; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GO+8KqZksOBgb63gOvUzh3TiPtMInDY9/tcJlUWc32refWK2FWd0/6aNN0TQn8AlHAfzEYHYQUYPNJRZ1qGj50eRjtVscdRHPkLrNv8BjZ3UfsEPSHNMOux1j0Vxdvh14sk20mU5bzMb9B2isxxwP98Qr0ZIkUEgE4Dvyw2bY9/44QEJh+vF3V7JvC3K74heJDLOiEBNdEyy2u0crRJvF3mtCtP/p1IYOei3ve2+usEeX8NTOGOxFEH5M4sbr/nNDI2JSFpFynCcRsNQcqndeKdu/bDN7b1pG8C59+D/RKdCW98ZrAtF61aZF6t2So/QkvTEs4LzOCNpJnokGafHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkA9Oi58zWn7FUe7iSeOcsOE148v28uBRk223S3eB8c=;
 b=TPE27ucvvOAhSzYiTlzdVYDAMBY5tw2Ab0Rf6X4ObgQ32me/vpM1B2Vfm4GG+NmlNRBCRFzVNpCuE0aM2RJj1H7h2bRidJxdsqrFXiQ/iCatKVB1MHCNFV+KvFU7W6zSCWsR5u2ZdrbPvUgZAaJYcMx6bOq2w3xni4v9lpD716o+ApDOL13wPHkxAZx47zzxkjcX9dVKvvzDBCd6YvfE3kl6j+uF0XqUcu9tupUszOG0k6DF74KUiUqKVz0XMeZ8sYRgWjGZovJfcPam1P/RP0YQaFJSItt4zcRheXta12IMW6jeKWLD18d5F1IdXNOKvPnqGVBXLtdOsliT6h/BcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkA9Oi58zWn7FUe7iSeOcsOE148v28uBRk223S3eB8c=;
 b=XcYmzc9E1OexO+8/JosY4XpXR8b9N0pqYOvcrCHxxbghYMdIOTzzC38sp6bCz/KHT8tRyMi5z04FgC6PVwBvGc+X48HK/RaHun8hFjdOU/1k5Cm+K9PXvuIRsjecFr05TnL5hVXPvDR2hxpFa+One9JKY3FKrW3oTwFx0S8PfCo=
Received: from CY5PR18CA0017.namprd18.prod.outlook.com (2603:10b6:930:5::34)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 16:55:54 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::aa) by CY5PR18CA0017.outlook.office365.com
 (2603:10b6:930:5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 16:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 16:55:54 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 10:55:46 -0600
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
	<michael.day@amd.com>, <Neeraj.Upadhyay@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
Subject: [RFC PATCH 2/4] Introduce fbind syscall
Date: Tue, 5 Nov 2024 16:55:13 +0000
Message-ID: <20241105165515.154941-1-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105164549.154700-1-shivankg@amd.com>
References: <20241105164549.154700-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ0PR12MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5cab06-d0e8-4ad5-8b56-08dcfdbab664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5mijMRTxZD5Rhi4Lq1dISlzlnRjFs5kABHXC25kQ1AzRSzY2uaQcY0SyJWwK?=
 =?us-ascii?Q?iZHdbsEqujWkGElhm/QRMXtPAQlXfcYeU6iH+L3rDG7FifPwyinSkcA5DmMC?=
 =?us-ascii?Q?GGZ/XjlDMTDKap8cUZlrazB5fWJGIhBUm/YhLPpPPFpo0/j2ppxvoIDz1aoq?=
 =?us-ascii?Q?Wv6Z+fU0Gaq8OWzWyIcYzWA4G2gMWmJZXRb2BfuPKlJcESwIvC4IJ3RLXGOM?=
 =?us-ascii?Q?tcGefaH9ytsaEikAN8vFhxN95QGVN+BkYagJ1zGD+yfdmqttQnM1/rE/JSm7?=
 =?us-ascii?Q?/wUpFSO+f+GW1VqwEx1qZMD3LJM8Xq54TW8Ng6wnq9zkyXeEJqARhtYRj3qQ?=
 =?us-ascii?Q?IgQoCqTWYNFit7ZKubYVMaFgorqe3ikuwq5/xAb+c7PvErVXLZ2jP1xPx3hF?=
 =?us-ascii?Q?IRnmt1Vs7XRf4XDFAhZLVgruV4bABNFNOoU0exBGiT86ohoQ+sJ8arxm3oAG?=
 =?us-ascii?Q?ozjAXHdTu4dEVrvF8ULG0vMkMTdInPF1PbBoL/ryUkg/jUxRMvV7e2qUoewi?=
 =?us-ascii?Q?viFzrflMzXFKHx1a2iwMu75689PahM52eEMs7K1CKDK+J+cGzwNISbcjrWhy?=
 =?us-ascii?Q?XTif0IYwpM4pHp48nzkoQ6EoVuJkveI92bcJI/xzzRA99oOBRDclQmP+TIBE?=
 =?us-ascii?Q?JUsMr0TkzCwgbQwjzLfBAPvjwDKlA8BL6H0eykeIPzlW02mCCoW2RnqfGPFi?=
 =?us-ascii?Q?7+kd4NObIh+lDiOlbqF/SAbpLQ3dACkTmuPIaBtuod4khQYtbTI+CmA2xJ5D?=
 =?us-ascii?Q?jDQpkS7bMn/xbCDXJzgHo9JIYkuFpTJD1OPV1XKqY3Me8KVOqw2WNjdUd9kF?=
 =?us-ascii?Q?Qess07DGWcjyD8cebX8/bZToT8Ennneqz09FMosC5nCmw9DSrECrjz6ckiha?=
 =?us-ascii?Q?oFvWolSriC1tfxMpj6K4sxmmKGEb+KWy+4LglU53SiaMCuYufmJDyAWNnlad?=
 =?us-ascii?Q?PRWG1x5oY3UAJFrpguJWh90zqRBdSzmr6HBWzJ+FufWpkKdmsyO32LtHqErD?=
 =?us-ascii?Q?MGlDfEqgXNuyw4OV1HgJ470odqKbxuECKfKwozqbShCzKCDK2d1CP/0+EY0Y?=
 =?us-ascii?Q?FB6KN7arW49KQoAWiazx95cTo5AY+vin92it3y2hQU/b5S0z9T/63Fx3eUXa?=
 =?us-ascii?Q?0w8HUwoRFNItDkSaiF7JLssP+snxcMgpH6xh6b7/64jgnAdJxL9LorBftsNG?=
 =?us-ascii?Q?1jRbMPr8/qSEddRIcNwFdJ/qmayVvUZ7zlsyJ1uqJkoqNeB59jho106RjZQj?=
 =?us-ascii?Q?38ASeg4H7ChSK2Joz7Mn23nAXjmcWIeKAFtz/OdpmLnXv/R5i/iCgaos9upV?=
 =?us-ascii?Q?FOLVqN8hzVkREdgfxYhino0IvMWxhxLgi8d+eEkDcBMh/5VPE1vSXEZIrr2M?=
 =?us-ascii?Q?jetmNa5HR6a6+5uVX9gowgqyjPqHEavIc+EgfT/wM4E0VzjP4qNAvKW/SLc2?=
 =?us-ascii?Q?O8M1b8afiAY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:55:54.3836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5cab06-d0e8-4ad5-8b56-08dcfdbab664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944

The new fbind syscall sets the NUMA memory policy for file-backed memory
and has following signature:

long fbind(unsigned int fd, unsigned long mode,
                const unsigned long nodemask[(.maxnode + ULONG_WIDTH - 1)
                                               / ULONG_WIDTH],
                unsigned long maxnode, unsigned int flags);

fbind behaves similar to mbind except that it takes file descriptor as
input instead of address ranges.

TODO:
1. Support fbind syscall on all architectures.
2. Expand commit msg and add documentation.
3. clean-up the code.

[Shivansh: add create_mpol_from_args()]
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/fs.h                     |  3 ++
 include/linux/mempolicy.h              |  3 ++
 include/linux/syscalls.h               |  3 ++
 include/uapi/asm-generic/unistd.h      |  5 ++-
 kernel/sys_ni.c                        |  1 +
 mm/Makefile                            |  2 +-
 mm/fbind.c                             | 49 +++++++++++++++++++++++
 mm/mempolicy.c                         | 55 ++++++++++++++++++++++++++
 10 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 mm/fbind.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 534c74b14fab..0660ce6d08d8 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -468,3 +468,4 @@
 460	i386	lsm_set_self_attr	sys_lsm_set_self_attr
 461	i386	lsm_list_modules	sys_lsm_list_modules
 462	i386	mseal 			sys_mseal
+463	i386	fbind			sys_fbind
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7093ee21c0d1..9794347cc2e6 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -386,6 +386,7 @@
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
 462 	common  mseal			sys_mseal
+463	common	fbind			sys_fbind
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..42042b62bdcd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2058,6 +2058,9 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+#ifdef CONFIG_NUMA
+	int (*set_policy)(struct file *, struct mempolicy *);
+#endif
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 1add16f21612..b9023f6246a7 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -299,4 +299,7 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 }
 
 #endif /* CONFIG_NUMA */
+struct mempolicy *create_mpol_from_args(unsigned char mode,
+					const unsigned long __user *nmask,
+					unsigned short maxnode);
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 4bcf6754738d..2dc686921b9f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -502,6 +502,9 @@ asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *bu
 asmlinkage long sys_newfstatat(int dfd, const char __user *filename,
 			       struct stat __user *statbuf, int flag);
 asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf);
+asmlinkage long sys_fbind(unsigned int fd, unsigned long mode,
+			const unsigned long __user *nmask,
+			unsigned long maxnode, unsigned int flags);
 #if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
 asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user *statbuf);
 asmlinkage long sys_fstatat64(int dfd, const char __user *filename,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 5bf6148cac2b..550730f36dae 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -841,8 +841,11 @@ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 #define __NR_mseal 462
 __SYSCALL(__NR_mseal, sys_mseal)
 
+#define __NR_fbind 463
+__SYSCALL(__NR_fbind, sys_fbind)
+
 #undef __NR_syscalls
-#define __NR_syscalls 463
+#define __NR_syscalls 464
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index c00a86931f8c..f57350e581f6 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -195,6 +195,7 @@ COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
 COND_SYSCALL(cachestat);
 COND_SYSCALL(mseal);
+COND_SYSCALL(fbind);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/Makefile b/mm/Makefile
index d2915f8c9dc0..ba339ddc0be2 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -79,7 +79,7 @@ obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)	+= hugetlb_vmemmap.o
-obj-$(CONFIG_NUMA) 	+= mempolicy.o
+obj-$(CONFIG_NUMA) 	+= mempolicy.o fbind.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
diff --git a/mm/fbind.c b/mm/fbind.c
new file mode 100644
index 000000000000..85ec7d13345c
--- /dev/null
+++ b/mm/fbind.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Implement fbind() syscall.
+ *
+ *  Copyright (c) 2024 AMD
+ *
+ *  Author: Shivank Garg <shivankg@amd.com>
+ */
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/mempolicy.h>
+#include <linux/syscalls.h>
+
+static long do_fbind(unsigned int fd, unsigned long mode,
+		const unsigned long __user *nmask,
+		unsigned long maxnode, unsigned int flags)
+{
+	struct mempolicy *mpol;
+	struct fd f;
+	int ret;
+
+	f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+
+	mpol = create_mpol_from_args(mode, nmask, maxnode);
+	if (IS_ERR_OR_NULL(mpol)) {
+		ret = PTR_ERR(mpol);
+		goto out_putf;
+	}
+
+	if (f.file->f_op->set_policy)
+		ret = f.file->f_op->set_policy(f.file, mpol);
+	else
+		ret = -EOPNOTSUPP;
+
+	mpol_put(mpol);
+out_putf:
+	fdput(f);
+	return ret;
+}
+
+SYSCALL_DEFINE5(fbind, unsigned int, fd, unsigned long, mode,
+		const unsigned long __user *, nmask,
+		unsigned long, maxnode, unsigned int, flags)
+{
+	return do_fbind(fd, mode, nmask, maxnode, flags);
+}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b858e22b259d..3a697080ecad 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3557,3 +3557,58 @@ static int __init mempolicy_sysfs_init(void)
 
 late_initcall(mempolicy_sysfs_init);
 #endif /* CONFIG_SYSFS */
+
+/**
+ * create_mpol_from_args - create a mempolicy structure from args
+ * @mode:  NUMA memory policy mode
+ * @nmask:  bitmask of NUMA nodes
+ * @maxnode:  number of bits in the nodes bitmask
+ *
+ * Create a mempolicy from given nodemask and memory policy such as
+ * default, preferred, interleave or bind.
+ *
+ * Return: error encoded in a pointer or memory policy on success.
+ */
+struct mempolicy *create_mpol_from_args(unsigned char mode,
+					const unsigned long __user *nmask,
+					unsigned short maxnode)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned short mode_flags;
+	struct mempolicy *mpol;
+	nodemask_t nodes;
+	int lmode = mode;
+	int err = -ENOMEM;
+
+	err = sanitize_mpol_flags(&lmode, &mode_flags);
+	if (err)
+		return ERR_PTR(err);
+
+	err = get_nodes(&nodes, nmask, maxnode);
+	if (err)
+		return ERR_PTR(err);
+
+	mpol = mpol_new(mode, mode_flags, &nodes);
+	if (IS_ERR_OR_NULL(mpol))
+		return mpol;
+
+	NODEMASK_SCRATCH(scratch);
+	if (!scratch) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	mmap_write_lock(mm);
+	err = mpol_set_nodemask(mpol, &nodes, scratch);
+	mmap_write_unlock(mm);
+	NODEMASK_SCRATCH_FREE(scratch);
+
+	if (err)
+		goto err_out;
+
+	return mpol;
+
+err_out:
+	mpol_put(mpol);
+	return ERR_PTR(err);
+}
-- 
2.34.1


