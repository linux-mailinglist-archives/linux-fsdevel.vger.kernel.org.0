Return-Path: <linux-fsdevel+bounces-52033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2C2ADEA07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F39189D60E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22062BEC3F;
	Wed, 18 Jun 2025 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LFPNz7G/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0E2853F3;
	Wed, 18 Jun 2025 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246229; cv=fail; b=FV1p44ktI1apQ5xjvwvB0E7qyFZ4yHD34bRekBfsOrqpIx993YtjKMIrSRENbfb+69mJYm0iWCW3fXSYEtNF1RT9Tdp7vhdFXWN0mcqAk5PxDoEEBdwnUDmtJO10jowFcWmTaLC4WHX+v5plWyCnxNDR0qn6aqS3smz3E5Gr3rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246229; c=relaxed/simple;
	bh=8c/UtJr/3Cg8TRzWzkSIuEChLE3Zp/thakGso0tnfFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgZuvFSQkQTP4+WXoNYwO8cwOvbtSFRP9cBPTYQJ6MlKKmUW67I7RGBhnbwhniWC139JOGSgn/FXuEJrfXOLaQpqUQ7noZ07+oYlzyTAN2KWAKNPnSWhoT/bi4TNlRJP127sba24Ik4cs3yHqAgT33HayY0aTSsXHSRoiHDZCjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LFPNz7G/; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slEiPHKwp0p6eeJAbM5J5ENdqqv4yZYup9Da5RF14KN2syMl3qXXF5iEN4D72c0/LuAcQMMV60izdOHZ5P9VBEp01Zc6YtvXQo4BUEbCMrpv31ImNpCY0hkNdYt7xVW+FedGYPBcJIpgmoQIlmtwggJbj7e6k5XoTA1bfkxg9o8BjEVP709t2SbrIYe4z2gnKOxDGLcDCJpp1YJSdpTyslqlle2FcYeKT/28rJruBwOOcF1nXZ2Qxn13PfsuaKBvUEm/qsvXnDyrwZeBqi+1EYBhglu/fQupx5Xc/+Mec3S1hp5gN2jX8u9Q1yvEcMGU2OVnztr4BfNpmi7bZ0U0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVvjv1zEScwp44LjQhxl0FatJUjtklmF4PWpFgttafA=;
 b=jLN0IKxuPJnSmJye8h1AkVyw+TV0QtEotZhJbyUolY2Cc82hdy8yGrx02eTLmPTWcXlk8pW4RMdaLxdvklZD7k/AkExbiWqQsPGvsqN0vehSmGxuAzo7ccjN0RHQI85iLHG3d2hjJGlASSxEfp4BAp2br1Pbj055alKGEE3jFoajOQam2ZxU4pRCXkHo+zj8t6bzVYA2q8F2B8LueLStJSyqKB+trzUOTZF55HYsIYwjjoKjDmLpqih5KRiUQsVZh2FvrZuwjdWN/sQuuozwGwC+f9KlunbgI0cl76lbtS7PSBQs01s+ZquOV0A5oE3uc3o02d+Iy2ZR4rsqC+YG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVvjv1zEScwp44LjQhxl0FatJUjtklmF4PWpFgttafA=;
 b=LFPNz7G/TrKsHB8J/tFdfFSP3egRspIJOEweFKFrbRoR4m+3s2hXeIU5/k8dZxO/Bsq8e+rvJATp/7FJL6IB/8qqTuSGj2Kq2v31epjoLBNehLCgvBgpOg97V3LymMSNe6FDzkR38ug7j5YsBq6c5tLy6FPxnD7VUalGoGwSAlA=
Received: from DS0PR17CA0001.namprd17.prod.outlook.com (2603:10b6:8:191::19)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Wed, 18 Jun
 2025 11:30:24 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::e2) by DS0PR17CA0001.outlook.office365.com
 (2603:10b6:8:191::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Wed,
 18 Jun 2025 11:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 11:30:24 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 06:30:08 -0500
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
Subject: [RFC PATCH v8 1/7] security: Export anon_inode_make_secure_inode for KVM guest_memfd
Date: Wed, 18 Jun 2025 11:29:29 +0000
Message-ID: <20250618112935.7629-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 0185bf54-fcc2-416e-9e68-08ddae5b8466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IUM7mMnULIb5vPRADkjUuwY2j75YxtM62YQgtmW/Db9h56bkOxR0gRGesKBM?=
 =?us-ascii?Q?KYiCES0H5rwAwy+TYsl6beQTRIbgW7426dk6ntTRv3fxKE//SHAPMPRrcJs7?=
 =?us-ascii?Q?sRzd6JGlANXidIW+z96Npzvass7RG7WOfSyrT7gU3aU/n8KFqtVXImBCBV4m?=
 =?us-ascii?Q?nnX5wmbVu+Knac+KE63/d1tJazx2cpCzsxHvTCOjssnBIUMWFS1snjVm6ONN?=
 =?us-ascii?Q?T4whIu8IMwfVS5nWUumcUV4kULUZjNQrYSvTrvyMnClTXMOEZQirYgZaYAfE?=
 =?us-ascii?Q?eO60NnnkINmUNzGjUfPd6m7yE/2UaxeqPKVpGvWj/25CXlvkoO4c2IJxpcO/?=
 =?us-ascii?Q?nyT4PKPDoPcIl0LZj26xUF/XruF8JV1uzJMbPbDPw8rmS9lErIgcM9HrtNbd?=
 =?us-ascii?Q?eJ7qOUYePyA39vHX2cQ+dYG9rbp8h01T7bVG33YmwRXHW53hxz7lmrQG+MX/?=
 =?us-ascii?Q?5Gt47WDL/kcsxiiuofoI7nJ3iH3w0gMFQMtmu0bO//4XvdCH+5tFb2sLZAEC?=
 =?us-ascii?Q?uHMgtB7DidhKC117oE0ciGslfOIUo7qQhQYzAJmjjh3cQt7EM9m91W6QvECS?=
 =?us-ascii?Q?8R72wV8dIqegJ0SyqSSVAZm4yRHqNlpJ5ZYIqjztjO7fDJj/bj61EkdDnnCr?=
 =?us-ascii?Q?ZPgSpIyJVAD6z3gUYE3oc27F+889Cuq4T4UIBA9hitY6HvVmYLAnpp2aZL8j?=
 =?us-ascii?Q?igC9Q8x4OXexgMemc5Bg5b2mnFHf/xF7zPTCBJKRKqckAkrIkgrpmwaQx++T?=
 =?us-ascii?Q?fQW+QfGzS3Ia3ZJ/8BUr6xL+E/pEWzvaohbOT42TobcDrCohesOxLDcAe0oT?=
 =?us-ascii?Q?YhpVwb4a0xSiXqj3OgbyoEbpLhwdiOlBRbyA/IjG7GNCIWSetmRt2diVEC5V?=
 =?us-ascii?Q?0hUHLLJzrChvrQ6MhFlw74ioSaSlFKTLhu85eMwjlRQq1GzTWqyA8J978PN3?=
 =?us-ascii?Q?7ViG5M5fnYWwFI+CxTklqXFcICKs7KhQsvoA7u3gcv7Zd/FgFt0SUOUdte37?=
 =?us-ascii?Q?vtDbMWUZeD3QJQjsBZacfEyS0caCw8t0VIU0Q6WuIQiAg9CPEtRCmJZYgcwZ?=
 =?us-ascii?Q?rhpzAZoMVJ+IqjOyAo35GVjrpFpMYE+8WD9+VpbwzZw7RpRzKEIAUJ5PQdhr?=
 =?us-ascii?Q?fZvFdPGB/ggVg1fNSak4vJLVGJgzVf+NN/56S4FPlXcAekp5QSE6n8T7Ukr1?=
 =?us-ascii?Q?iaaNg13hBlEysUBy4dK23oGJCE+PXvN5jP49p4oZgA93dDWzd27PgJMxd1gH?=
 =?us-ascii?Q?lDABw1MmrGt6qHDTI+Bc3ZAt+0FixQLG77aa70CTZR4PdOgnKWeR3H/6fntd?=
 =?us-ascii?Q?QZb7SgborgXWWehmkabRPORATqdK6Q1/HXFkXO3OyWeOJ5J4zBh8CLOYmi8D?=
 =?us-ascii?Q?PQVzy2W+l2ZpdpR4uP5i6AIojlttb6LgTbGKEFqLTJGtDAQBuWp7Jzv2kiCg?=
 =?us-ascii?Q?ky6stn1uHrNjeNbL2Tp8y6ve753+OLMI8d1sTOJ5D+NHca5obmnhhZDFMEmW?=
 =?us-ascii?Q?sJo/arT2rsMdrNtSh2QmNTs4FnxLGqpw0uV/6vFqMYE1IYBuuO6RVgfv3A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:30:24.2223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0185bf54-fcc2-416e-9e68-08ddae5b8466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763

KVM guest_memfd is implementing its own inodes to store metadata for
backing memory using a custom filesystem. This requires the ability to
allocate an anonymous inode with security context using
anon_inode_make_secure_inode().

As guest_memfd currently resides in the KVM module, we need to export this
symbol for use outside the core kernel. In the future, guest_memfd might be
moved to core-mm, at which point the symbols no longer would have to be
exported. When/if that happens is still unclear.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---

The handling of the S_PRIVATE flag for these inodes was discussed
extensively ([1], [2])
My understanding [3], is that because KVM guest_memfd and secretmem
results in user-visible file descriptors, its inodes should not bypass
LSM security checks. Therefore, anon_inode_make_secure_inode() (as
implemented in this patch) correctly clears the S_PRIVATE flag
set by alloc_anon_inode() to ensure proper security policy enforcement.

[1] https://lore.kernel.org/all/b9e5fa41-62fd-4b3d-bb2d-24ae9d3c33da@redhat.com
[2] https://lore.kernel.org/all/cover.1748890962.git.ackerleytng@google.com
[3] https://lore.kernel.org/all/647ab7a4-790f-4858-acf2-0f6bae5b7f99@amd.com

 fs/anon_inodes.c   | 20 +++++++++++++++++---
 include/linux/fs.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index e51e7d88980a..441fff40b55a 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -98,14 +98,26 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
-static struct inode *anon_inode_make_secure_inode(
+/**
+ * anon_inode_make_secure_inode - allocate an anonymous inode with security context
+ * @sb:		[in]	Superblock to allocate from
+ * @name:	[in]	Name of the class of the newfile (e.g., "secretmem")
+ * @context_inode:
+ *		[in]	Optional parent inode for security inheritance
+ *
+ * The function ensures proper security initialization through the LSM hook
+ * security_inode_init_security_anon().
+ *
+ * Return:	Pointer to new inode on success, ERR_PTR on failure.
+ */
+struct inode *anon_inode_make_secure_inode(struct super_block *sb,
 	const char *name,
 	const struct inode *context_inode)
 {
 	struct inode *inode;
 	int error;
 
-	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	inode = alloc_anon_inode(sb);
 	if (IS_ERR(inode))
 		return inode;
 	inode->i_flags &= ~S_PRIVATE;
@@ -118,6 +130,7 @@ static struct inode *anon_inode_make_secure_inode(
 	}
 	return inode;
 }
+EXPORT_SYMBOL_GPL(anon_inode_make_secure_inode);
 
 static struct file *__anon_inode_getfile(const char *name,
 					 const struct file_operations *fops,
@@ -132,7 +145,8 @@ static struct file *__anon_inode_getfile(const char *name,
 		return ERR_PTR(-ENOENT);
 
 	if (make_inode) {
-		inode =	anon_inode_make_secure_inode(name, context_inode);
+		inode =	anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
+						     name, context_inode);
 		if (IS_ERR(inode)) {
 			file = ERR_CAST(inode);
 			goto err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..7ba45be0d7a0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3604,6 +3604,8 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
+extern struct inode *anon_inode_make_secure_inode(struct super_block *sb,
+	const char *name, const struct inode *context_inode);
 extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 extern const struct dentry_operations simple_dentry_operations;
 
-- 
2.43.0


