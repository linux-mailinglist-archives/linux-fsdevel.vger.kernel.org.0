Return-Path: <linux-fsdevel+bounces-52302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04950AE1480
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 09:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CE23ABBC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB3226861;
	Fri, 20 Jun 2025 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MrIfMcAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66791EB18E;
	Fri, 20 Jun 2025 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403119; cv=fail; b=cdNmfwPwEImsMUQHbpJGI08Aa7WfbUI/4jhcJd2USK7U9NSCxzRoyq8SgLYhtZ7TxiLfZ+fGMp2TVvEmREY2rjyNY7+tdgFv20kpMEEbAz/nSoBBBp3qsSSwL+wPMGERTf12pJY7THGLe0riJs2rQWckwwe7DlivU3y2gDCuWQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403119; c=relaxed/simple;
	bh=VATzEGwlhgA4BhFdDb5QhqSdmrMSrtXTZY3VoYtgmSo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xsobx7HBLYU3Gha+OEkSoq9P82UN1yJsBLyXEMGUyEAvlF+ifKZklk7C6XQ3LDsUAM34BKEA4IFBzpQp7vDVwdLw/RCR1l0I3wldgGQW396whteyi7NEVMcU6h6essP5DuqiQhrYOnc7B4bmgQlhKqjRKV7Kni6uGDRkOZN/rp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MrIfMcAm; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iidl0tBUhJ0VJdbtYGIU1zVdz5PgWfF/qRGbvuzjGNOEztEVgZc5f6QPI4NBZ7UEO2m8xqgaj4KfSqX4T+djTa8369/9Xr66XIbmPS6a2cwe51Gwhe1mmhwJYuoDtDm57sSwVg2tH3VG9jMYiLXlw5K+nyC6+tzv8noZ7ne20PMERrNju5l4xooeakuL/cTo79i9AeAPbi6mFV+Qn42FsJNs/icISwDXAG7gIH+YvlYuCHTJ0bY87RArQ4/Cl50mrpmcyRJE597YV3/860so/9om71OQKj3EKBdhk2vKT6FZ1zawp61mmYPSJCZG11ZvFJQKqrsV/CDFA0W2ogxY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3r1IiA1RE2/twwv6YAKXrHvvGx5r0hLghYqnC/useU=;
 b=Wpt4RtDvmJemKv/EBikI8aJSPBRX6usd1T/hCixOOg3ObnUeNUaMMn56oGyZbV5My8JIys7LP+x5ym6qSaZzuQurZONBrL/OqnT6v6bsDOSI/0ox4mZ0qdW3jgBnkY87PPDXqDVVrUIje+HhIuwPwUX7S3Qdajgl3Jf9e7qNzHoH56XnPMkJjVH17zQFGYlt5r56FQfFuBAJSq7MkPHq581wTl+Kz+IKuYjNbRo2rMUg9fijsFRL3vTHYoEvmZJG7rgvM73a7QCXftXco55BosJR9AqV8shaOhVrgy3Ipu9aJXVUsHTwLv2o9b/unVFfi/eBmi9AdgeVIA1E6+F8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3r1IiA1RE2/twwv6YAKXrHvvGx5r0hLghYqnC/useU=;
 b=MrIfMcAmstKCMxp18WA96MHVoeAARTH59cG1IWpIIJl6fTSRL11L4Z98ZB34WzQM5P0ZjRCUfcFxU84qypEbLF6fHUIDGhVYBeaRoI6PudEGE9W10oMXR6SR7BrdqltcJsKkVY3CfmciY18jb54yJ/5ZBko2NVxF00H77XLcYow=
Received: from CY5PR18CA0011.namprd18.prod.outlook.com (2603:10b6:930:5::20)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 07:05:13 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::8f) by CY5PR18CA0011.outlook.office365.com
 (2603:10b6:930:5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Fri,
 20 Jun 2025 07:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 07:05:13 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Jun
 2025 02:05:07 -0500
From: Shivank Garg <shivankg@amd.com>
To: <david@redhat.com>, <akpm@linux-foundation.org>, <brauner@kernel.org>,
	<paul@paul-moore.com>, <rppt@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <seanjc@google.com>, <vbabka@suse.cz>, <willy@infradead.org>,
	<pbonzini@redhat.com>, <tabba@google.com>, <afranji@google.com>,
	<ackerleytng@google.com>, <shivankg@amd.com>, <jack@suse.cz>,
	<hch@infradead.org>, <cgzones@googlemail.com>, <ira.weiny@intel.com>,
	<roypat@amazon.co.uk>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: [PATCH V2] fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass
Date: Fri, 20 Jun 2025 07:03:30 +0000
Message-ID: <20250620070328.803704-3-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c072bc7-4ceb-4f1d-addb-08ddafc8cd98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eaYp1BBbTeMDYI1ShJ7C9DrQgqJbbvS5pU+Tudmu5ut0PTjh+hoJXgPr5YY8?=
 =?us-ascii?Q?/ZMde5rut0aLT6QNJxBqMEszKs0KJsjcPuaMJzqFdpMgthvivJhSa7zo6Jln?=
 =?us-ascii?Q?kOgIj5N/4es64fEEeNAad90TZNSBhTU04jUBTFW4JHfPVWUBEskMHp1EZqes?=
 =?us-ascii?Q?HTSHZQnpQtspI+MnYj33gtfunHf2vX/2QzyQ6YdV7n/eME7fVp3SJ1/QgEy+?=
 =?us-ascii?Q?xYI3OrEdyo2f7U7Gbw2RmsDuR/62RalF/ncrZExfECrYiy0tNc+YCCGFS9ds?=
 =?us-ascii?Q?QXr0ZUzsCK0tF9FbgvVJZ+oU35fxALgqMFY2K/ExgBOa+5bnrYCKpQVJAmpM?=
 =?us-ascii?Q?5Xt92REwtRjbfYSe2IYi8L6R+Uqd0n1kQjSee7CW9DjnjU/8WY1+wd5gd8hp?=
 =?us-ascii?Q?28pqjYQYCLrM/jdGqwAyg079METGKn7zSltFJFY5ppsAPKJjlSuyOBVGlEhf?=
 =?us-ascii?Q?z2ap3HLIwHMfr6X713X2Pg2ulSZf+qXJq+j9oLuUUNI59YivOC4P+uFX+GDk?=
 =?us-ascii?Q?t7/m+hxUo0nK3zCigs9BOPgQ+cgOD9jGP66kXblG+ndCKDMMhBUGkCIZ8ZRJ?=
 =?us-ascii?Q?8MdqMpZHWBTpi0CrVf7QSk2UmKBkHG4i9E51FbCxaPNthyeA4exJ5VgDO/g+?=
 =?us-ascii?Q?QvLo/iT88ra4EUkCEBHt9kkG2Gk1alTDJc/IL+tDem+KG0E6rYWL62Y9f9oQ?=
 =?us-ascii?Q?06z3NNKZtcErqh7bY57qGpn0ln24+2dk++th6uT4XKD+6gMhijhNgtY02v3Z?=
 =?us-ascii?Q?kSX/pgoOpApvtj39FxWDviexaC04FzlZFdeGKVVfIDhHtlqtThld6meNKSlx?=
 =?us-ascii?Q?XEXqv2KRRg/JBbcT/LQcFK1n1YqGxDx52Z5iEJvbzF9ctQR350PwBRDp5hUq?=
 =?us-ascii?Q?TYCtGJ1hIHOsdKCKb6xHssJK4bHkVP+jOsKW29b04ZMIMMRNyD0v57tSzi93?=
 =?us-ascii?Q?8zjA58kGhSQXuOvYscP/LXZnguQG3JPIRJhu6+FIbagDg+OW7zmqmo6X06of?=
 =?us-ascii?Q?mnbgVmE0FAL9HywcU9r0b5kC4YJYAVlJMXDdCeuqYRxJmzvu2krOzhGwOGoU?=
 =?us-ascii?Q?mMTLmeNe3dRuFnRhsIrLIC2zxqRMKPXiR8tklGEoDW04Qso4Gbxv3cs7YixB?=
 =?us-ascii?Q?J0mdOIlFN+WDAE7emlp4hNkhcysFVizD4a/1wf7rwkH4P0gdKwypKsbo1wne?=
 =?us-ascii?Q?94b/thFat1zvTCVqFtlWq1290FEqxHFE2IRl/cR3Y8GvabsKQV4/xEu93P9F?=
 =?us-ascii?Q?9edtkQze1YHnqZwJodQiS8BUsN/P3F4F5eby1Y3HCx4n98Birfcwcf98mSi1?=
 =?us-ascii?Q?1xXRr/PCb2yLjg9JcAiSJSdytMBLljL1vLFvQmQ3RT+cso3tgD50w5TTpl4i?=
 =?us-ascii?Q?bXHPTVGUPFvdBmUEAB6sFnZvSzRVftCxPeD7rxlqCm1dTLAj7tl+6V2HUjkb?=
 =?us-ascii?Q?KSVzQaIFj9b9a9/HpY5zG5dxaGW0zwqaPG9UwwzRM1zgxVdr9A34M0B4ffC1?=
 =?us-ascii?Q?lscNw/y4iAarB6SBgFR+yHj9xPelUaqdK9guijUGY22ouWft47Qi52ehEQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 07:05:13.3242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c072bc7-4ceb-4f1d-addb-08ddafc8cd98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
anonymous inodes with proper security context. This replaces the current
pattern of calling alloc_anon_inode() followed by
inode_init_security_anon() for creating security context manually.

This change also fixes a security regression in secretmem where the
S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
LSM/SELinux checks to be bypassed for secretmem file descriptors.

As guest_memfd currently resides in the KVM module, we need to export this
symbol for use outside the core kernel. In the future, guest_memfd might be
moved to core-mm, at which point the symbols no longer would have to be
exported. When/if that happens is still unclear.

Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Mike Rapoport <rppt@kernel.org>
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

V1->V2: Use EXPORT_SYMBOL_GPL_FOR_MODULES() since KVM is the only user.

 fs/anon_inodes.c   | 23 ++++++++++++++++++-----
 include/linux/fs.h |  2 ++
 mm/secretmem.c     |  9 +--------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index e51e7d88980a..1d847a939f29 100644
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
+ * @name:	[in]	Name of the class of the newfile (e.g., "secretmem")
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
@@ -118,6 +129,7 @@ static struct inode *anon_inode_make_secure_inode(
 	}
 	return inode;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");
 
 static struct file *__anon_inode_getfile(const char *name,
 					 const struct file_operations *fops,
@@ -132,7 +144,8 @@ static struct file *__anon_inode_getfile(const char *name,
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


