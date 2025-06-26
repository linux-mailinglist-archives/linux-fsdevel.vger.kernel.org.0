Return-Path: <linux-fsdevel+bounces-53114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEB6AEA675
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 21:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEFF562D2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0472EFDB2;
	Thu, 26 Jun 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gdl6jHki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058C194AD5;
	Thu, 26 Jun 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966153; cv=fail; b=LdKiRdzZFDDK/ccUUkQgROQX04XsWWLsiNxEzR5yve2cI4c8HnlsdUUq6YnGOVjdXFtGKBmEICTYnZnuWV8jBfbnaZlqMWHVRp6bP+4vakx4TWjai15fkMumfiaSPznmIIugOLpjUqZY7AJgsWXQwLv6/RsVf4BLUL4o0d7lF7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966153; c=relaxed/simple;
	bh=NnrJSWvBthnPANa4FFmG4DpdKt6nRWOypJ+9/ieXfzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LwydVXj+kn4aRE9yBPyFsGorjtU23pK5jBRLD4xn0hCIzx7naYHa1kCPig9LBRnGhY0QisH5mYkVb+pXGgVVA+0bQVU0n/j6W97hb6ADykDNRPYwyZ1OOerGoU/rDCMrk0as8u++zcjXWiOSdRkbSSTg8pGTFiYYNF4bNVzMQhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gdl6jHki; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBc/53OxJEeJqRAmC7JbkHNNMJuStccwzI72VhQ9l5/NcCUfdYxvyAWs743Docp0LLRncfKzGJHc4pwop6t1/cp/SFhJbLpuyHignQuWyMjf3jwcM5AWmKBM0Kpm9d2oeNH10tuQLOmXjzKv3qyvx2u4OHCUMyiDWLn8/CR3RQmzMgPp2F9odY3VUebkNtGfkbvJiOqcON1leDlIV+t8Z2lrloUiMVMrXIZ+ICjERc+zWr2HfIsylYFZVEn209Ur/c+XMFwPmuKmYy+igx53mUvrL5OFeqqWHOH3opEfGBzTORWV+fLXQnsq7RZgKoKXvkSnWVXzPT/8tsvPLjmvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/7NlTokNQ+3vqtOkidoHStFd3Lv4la+h1IwMPDmcD0=;
 b=M2BBfQF/Vjf6xSzdsTGTOeqLVI4wpaulbLulK9z5AgQntkqEWSpLmtGaZYvGb6F797TVKr/MJg05Ix8sjeIcg+B56Wud3mnnimtXOk7/O6Vz7tj/5hqrwJhL4To4bKNyg+d76DKWB6C34uPHkmxPbb5L7VvjouQHDeN/kdeKktTy2GspbcKlqA0y+TsF22m/Bgl3Xf63bTAqdr0Y65Wv3WrRtBnUA02h0/Yjeg4+zodWuLrs5yLGzFliYL7HjS6o0TC0KQs3jkrOIkMJ/nGqw6VjtKQXVMJRRRYowTdXvTuS/MqEu5pBWiezcb/i2PwUgQubPp0mVKX7plpim9EpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/7NlTokNQ+3vqtOkidoHStFd3Lv4la+h1IwMPDmcD0=;
 b=Gdl6jHki0D3jzO3auHXcR2lHovWW+qrAdKzZJoIir4Gt9QBuniYOZgjql1r/1/yK+9fyATLXFfObVAxumZwFKAvlAtEvPZAULsGFnGci3+fxP1rYQyu+YKvskDSJMNIp6FIUMZa9VIb54rK9BC5B+u5KKLjqhyRpRq5dFb8lfjM=
Received: from SA9PR13CA0059.namprd13.prod.outlook.com (2603:10b6:806:22::34)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 26 Jun
 2025 19:29:09 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::33) by SA9PR13CA0059.outlook.office365.com
 (2603:10b6:806:22::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Thu,
 26 Jun 2025 19:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:29:09 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 14:29:02 -0500
From: Shivank Garg <shivankg@amd.com>
To: <david@redhat.com>, <akpm@linux-foundation.org>, <brauner@kernel.org>,
	<paul@paul-moore.com>, <rppt@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <seanjc@google.com>, <vbabka@suse.cz>, <willy@infradead.org>,
	<pbonzini@redhat.com>, <tabba@google.com>, <afranji@google.com>,
	<ackerleytng@google.com>, <shivankg@amd.com>, <jack@suse.cz>,
	<hch@infradead.org>, <cgzones@googlemail.com>, <ira.weiny@intel.com>,
	<roypat@amazon.co.uk>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: [PATCH V3] fs: generalize anon_inode_make_secure_inode() and fix secretmem LSM bypass
Date: Thu, 26 Jun 2025 19:14:29 +0000
Message-ID: <20250626191425.9645-5-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c9c9e6-76fc-4dae-c820-08ddb4e7b93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KKLqvudKy67fz1Dt8GV/poTLI+35c9/kDGJyzcmwk2mdniERHtb+M1fHx5/1?=
 =?us-ascii?Q?E+vofGDqkVjCoKixZvfpoZ2Z7q544NiMebcOhBU3YTMK8ChQryshu7vBqZw+?=
 =?us-ascii?Q?VHwdMfhZYXJVUxp8c3P+T3r5Z6OPXKFEr8jjUs/ExBfBVuAf2rpOhlF+AUig?=
 =?us-ascii?Q?roOlg4jKqwxbhI1Hn8nVPzL0k31fiUDhJ52QpUsgS9papdVZ+tRePUdTH8iq?=
 =?us-ascii?Q?5LLzERXF8kZMb/GfwPqj3GnFCXDgfP0Q2EtvnBPDk0P2EizxjSf/9Jzyl+XA?=
 =?us-ascii?Q?htf9h9l2H+CEC9jIiK2xDmJp+g3r0cRLhjRaLF2f6O/oAIZQB0SlWtZIIY0l?=
 =?us-ascii?Q?J5Q7t36nBbnKbqa2Ye318nn+mxtttdysnrj4Z6lDynf793Q2VUPR0UUm27Eh?=
 =?us-ascii?Q?y7ejjxPmWnZp6FLVRhsdUyT8Yj8bkx02zn1EDcMs2Bzy3Qdoimn0koRcabzv?=
 =?us-ascii?Q?HLggWcALgS+l0DOjU0z6bx+FzF6V4mX8iJyHN8V01A770EQryp6WopfV+ys4?=
 =?us-ascii?Q?BOzp8jPcZVLWgR3YIiuseA7Vpt2YiQoBYGREoJiGtLgQySB8MsClNICMTLtW?=
 =?us-ascii?Q?WfENXlyxAB6wcTM6UHrHTzBETb4moz01mZNmSS4CNxTLfKE8qqprDm8HOGnT?=
 =?us-ascii?Q?m2DZdzqgYDCQ4X14+P8bGHkx3Z2UloA+yXS22NpUrRcjxO2+UDI8H9wP/qZS?=
 =?us-ascii?Q?mpsqnNkp2wphlm8/gZrmWZJU6iwPe4QtbNwWgdUv1DR3VUNd+G+0rdQffYdF?=
 =?us-ascii?Q?jw3goZPI9XypZPPy8l0Wu9/PXqRyEOEfjZlN1fM2izsSLAK+XTk3X0L+kbtx?=
 =?us-ascii?Q?W3ZQhVOgJY5SIxPgoqFuRBJw97nhg+IZ+z7MeDYAq321GqJamwtX54zQVp+j?=
 =?us-ascii?Q?bgOGRiIIJSACqLK79MVEbc6+ntGtMKW3AHAgJNlOYEyI2a+NPOA5zOmLlgnQ?=
 =?us-ascii?Q?WyIFPqXIBfi89DnS5WQio7KbwayT9H9KVM8zSvEtEw4P7mzT7MB+Fl0BZbkZ?=
 =?us-ascii?Q?6L5DtvHdroKs7cxbGSenWCMSDfgaSftfzS6xwnMsuOCsuVTrpmBrG6COxQEa?=
 =?us-ascii?Q?f066hmPutXfR9vMhL+C++x49oRnU2pxjsbw8L4yz6NiFjMtJyFPf+cmIXjL9?=
 =?us-ascii?Q?epWo9/nstis1HVQyfMeZfCb5OWouKp6XoZ6gPnu+TZDFITo/mzDGJ20d3rGM?=
 =?us-ascii?Q?j7qBZuykNW9Q18AklsfzxxoZNaEk7a+1cx6UP5sykT1hOnGNsgR2Syk3G1fz?=
 =?us-ascii?Q?TqVAbOD1ZS5mYKO1rMQqa2mB0m5dGV6gxVsrfTrlFIxdOda0XkGc5JHvm1C7?=
 =?us-ascii?Q?88V/PYkA6GLrA9Oe0ZUYkzcm64OZxne3rsIT/smQGGMN+SXn5Nec/E6PhwI6?=
 =?us-ascii?Q?bi4a8TxaJHRg7WchpVbsP1h2bosp3JplywleexxjMX/JArDG+6lJXr9m3xbZ?=
 =?us-ascii?Q?etGkA8xnfDvteJqLiHN/HtKSDkmS1lASkBLs68sDyG80glDpHlFUuulWCeBu?=
 =?us-ascii?Q?qkZ+Zbik2HTdzv5+rYnNd6Tm6dfNFh/RYfxFG0gnhTkEmBXZf/8We82QfA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:29:09.4032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c9c9e6-76fc-4dae-c820-08ddb4e7b93c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156

Extend anon_inode_make_secure_inode() to take superblock parameter and
make it available via fs.h. This allows other subsystems to create
anonymous inodes with proper security context.

Use this function in secretmem to fix a security regression, where
S_PRIVATE flag wasn't cleared after alloc_anon_inode(), causing
LSM/SELinux checks to be skipped.

Using anon_inode_make_secure_inode() ensures proper security context
initialization through security_inode_init_security_anon().

Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
The handling of the S_PRIVATE flag for these inodes was discussed
extensively ([1], [2], [3]).

As per discussion [3] with Mike and Paul, KVM guest_memfd and secretmem
result in user-visible file descriptors, so they should be subject to
LSM/SELinux security policies rather than bypassing them with S_PRIVATE.

[1] https://lore.kernel.org/all/b9e5fa41-62fd-4b3d-bb2d-24ae9d3c33da@redhat.com
[2] https://lore.kernel.org/all/cover.1748890962.git.ackerleytng@google.com
[3] https://lore.kernel.org/all/aFOh8N_rRdSi_Fbc@kernel.org

V3:
- Drop EXPORT to be added later in separate patch for KVM guest_memfd and
  keep this patch focused on fix.

V2: https://lore.kernel.org/all/20250620070328.803704-3-shivankg@amd.com
- Use EXPORT_SYMBOL_GPL_FOR_MODULES() since KVM is the only user.

V1: https://lore.kernel.org/all/20250619073136.506022-2-shivankg@amd.com

 fs/anon_inodes.c   | 22 +++++++++++++++++-----
 include/linux/fs.h |  2 ++
 mm/secretmem.c     |  9 +--------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index e51e7d88980a..c530405edd15 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -98,14 +98,25 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
-static struct inode *anon_inode_make_secure_inode(
-	const char *name,
-	const struct inode *context_inode)
+/**
+ * anon_inode_make_secure_inode - allocate an anonymous inode with security context
+ * @sb:		[in]	Superblock to allocate from
+ * @name:	[in]	Name of the class of the new file (e.g., "secretmem")
+ * @context_inode:
+ *		[in]	Optional parent inode for security inheritance
+ *
+ * The function ensures proper security initialization through the LSM hook
+ * security_inode_init_security_anon().
+ *
+ * Return:	Pointer to new inode on success, ERR_PTR on failure.
+ */
+struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
+					   const struct inode *context_inode)
 {
 	struct inode *inode;
 	int error;
 
-	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	inode = alloc_anon_inode(sb);
 	if (IS_ERR(inode))
 		return inode;
 	inode->i_flags &= ~S_PRIVATE;
@@ -132,7 +143,8 @@ static struct file *__anon_inode_getfile(const char *name,
 		return ERR_PTR(-ENOENT);
 
 	if (make_inode) {
-		inode =	anon_inode_make_secure_inode(name, context_inode);
+		inode =	anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
+						     name, context_inode);
 		if (IS_ERR(inode)) {
 			file = ERR_CAST(inode);
 			goto err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b085f161ed22..040c0036320f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3608,6 +3608,8 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
+struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
+					   const struct inode *context_inode);
 extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 extern const struct dentry_operations simple_dentry_operations;
 
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 589b26c2d553..9a11a38a6770 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
 	struct file *file;
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
-	int err;
 
-	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	inode = anon_inode_make_secure_inode(secretmem_mnt->mnt_sb, anon_name, NULL);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
-	if (err) {
-		file = ERR_PTR(err);
-		goto err_free_inode;
-	}
-
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR, &secretmem_fops);
 	if (IS_ERR(file))
-- 
2.43.0


