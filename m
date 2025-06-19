Return-Path: <linux-fsdevel+bounces-52155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6C4ADFEBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B541769D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 07:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969BB24418F;
	Thu, 19 Jun 2025 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DmHaTI5j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B325B67D;
	Thu, 19 Jun 2025 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318350; cv=fail; b=Nyjok3raxbSRCZSuhWYhH3U9oFHusNtvMx8FTwbPs/xhcvApTu+e/H4q65p2QCXfqJcRqTpZZlTlWJLqO3Hkn9z5qsJ1F1U2ZTwOJkh4pzTZvLLpvxl6UPamuDfITugROjIHYZ8HAZ7OU9NmqZwQREolxOi+WJ7gA0I7t9TdPIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318350; c=relaxed/simple;
	bh=WHtJPAJoAsyhjdmcdnrukpUHDmNdXt0bSrVAZCyDYz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oRHlW6RV7S5PoTPBbp7AU6U+yECDXN1M1o1dXS0I8kQ43IhKN4OvfCo/pLacvYx/54/uuGNw6z5MwzMjJ+JGafA2O/xuLU21NGcJwwDJBKY8/aPeeRQIs3gXhVgsRepQMyaS1cHZbWzaTNN7MVAYJStzH5Y4pUKckwxw2qzTIBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DmHaTI5j; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMJKDkrPgRoaO68OZeiDsqqLMHPRfGUXfyXqlOj0+7fm4efPAw2GFdP2VJdxhA2dVtlhHkY5ajX5I8H7q5k7MfqwmgS+D+hS2d5TpBC9g78I7QBRFYdqpHOHrD5v2vId4Yek79VilDduSNme9ff7OS8aYlAbIdCoZQ9YhgD63T+HoQT8j+yLd6Xdi7kMMHQhkT7Lds6Wq1rO2iqmyL1QPZTOQmqcPXgSIazYCziSvrthSEW4cU1CW02qoe9JqDi+skq7+Lcp7TAWKnGj/CqIylicXdjTmlyYkhVCxRmH9geVvz7egCzhIH4ZaHxNXcRmz7wExvWT4UpFpM3bnglQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyAu5QLsuT5D7J4WeL4pZ2R/Mfd55tZpEG2h/AxJN3w=;
 b=XhlTAk13vthC+T3tYamE97Cll4ZKBS1MR3FAcAmufphBnd7VYFLYqnaVgj2RMbL9CpyRCdnqLkxrZkJekxDSLoz8U5aU1NtJaZ8v2fUzt9pX/J8r07vUvW6Y6CVZ1c90Mmh1eW1WrnxRklYTYdB1h5OVCJkIa5Rc9rDX52a02ZlBz1aL4Rad6E07/28G0e+YLKiK8QxgEphRWzP09LOXv9w9ziqzcGLJGFEiOZrZ5XnSV9q1MFn+4vftod0Rap8MTbcIt9mUunvFvdd51jh/5SvtAIqobLljtgRew/cB95Vsu1vonkngBfa5udzS5NZhMrmXh8Mxknq4xEO938jr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyAu5QLsuT5D7J4WeL4pZ2R/Mfd55tZpEG2h/AxJN3w=;
 b=DmHaTI5jJSdPZw/qgwLEm/6wS0QMQ5W9+Vbd6kIsYQgj+f+CPnyA+Mtmkzj5G4PojyfGF3bCVcNHe2OqkRhe4mPoiroflhXhnRe4UNWmFw95X0tJTZ6O++YDncF6pCT1lRer8kAd+BTbQwqFzJDHCehyF1+90JFs5xbTkdcczc0=
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 07:32:24 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::f9) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Thu,
 19 Jun 2025 07:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 07:32:23 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Jun
 2025 02:32:17 -0500
From: Shivank Garg <shivankg@amd.com>
To: <david@redhat.com>, <akpm@linux-foundation.org>, <brauner@kernel.org>,
	<paul@paul-moore.com>, <rppt@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <seanjc@google.com>, <vbabka@suse.cz>, <willy@infradead.org>,
	<pbonzini@redhat.com>, <tabba@google.com>, <afranji@google.com>,
	<ackerleytng@google.com>, <shivankg@amd.com>, <jack@suse.cz>,
	<hch@infradead.org>, <cgzones@googlemail.com>, <ira.weiny@intel.com>,
	<roypat@amazon.co.uk>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: [PATCH] fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass
Date: Thu, 19 Jun 2025 07:31:37 +0000
Message-ID: <20250619073136.506022-2-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 83113392-21d2-45ab-3bcc-08ddaf036ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NM0Kow1mtt2rVtSQlJj5W14WK/TjMdoJDJw9GayznIFlB0FqVtHH9vQfGdqE?=
 =?us-ascii?Q?xNbhLIsLCgdTx9CmZVqCLwzvjWM1FMfHyYUrBtUMM3drZHfIqsaMJmsiriyb?=
 =?us-ascii?Q?cyIFLUGcuDi3j7EyaoDBZi1JU4dYHrkgG8ycTK+H/hhazTqTPRdl/U1pIJfw?=
 =?us-ascii?Q?3AfkiKNqsHzdLdclisZ1YRHzHzfTwdvTfMk6w19KVZjGXm0TzHVYsUagiO+D?=
 =?us-ascii?Q?Q6mdFzywI71qgqIz55W+yp7W9zK8CxkzxeXJxiGkmaLbVYyP5CTpLr8Mrjx2?=
 =?us-ascii?Q?Zqze6zJtrlvuNMGG9aJBxgCkFNg6sttfzunNb+ra0KP+WH8UZdgGx4fnUvhd?=
 =?us-ascii?Q?2eeQZXrRug1eYhN3FuESk2j1EfhMxgs1kHSmtwfk+6f8LXEfIdaLDHL1UG7c?=
 =?us-ascii?Q?MFQfhatn7dg2Nzqp5FGiAN8tzCqohrvN/pXU/BMaVPKXQKLEZJ4Yzayp3rnB?=
 =?us-ascii?Q?2m4iHGEZ3m8woHcoONKoANumkVjpL6neBq+oky+1INTzHDHklDq2xw+/IZ9z?=
 =?us-ascii?Q?DOiJv72u7vrkmucysT61dJA6uTE1iq5NEstMhFqfMf/LEQrk3zjJCvbuk/t5?=
 =?us-ascii?Q?vPymRBUXC12qlxE33tu0IBs8jzMCwlYTRbdMIQmIQApACOE4uH7s36WN3K1p?=
 =?us-ascii?Q?8zKQKStCHIxMQRWrWlv59AvxiIuk9Hdu69qqoz8sDzRCrkHlC4k/haTTbLmV?=
 =?us-ascii?Q?J+0mjegcinWpyrWa5C6mRO4CF3t7ua36pakjd8NiyW+g/JplV0iVvEk0h1uQ?=
 =?us-ascii?Q?pwShGanoc0CerGH4rrhOlVlQw6OZvFZwx71rEIweraniLamETKfa9ZuRb3Lu?=
 =?us-ascii?Q?csmmyFV/5abJa/UgjmG/9wvbttrbgaG1/iHWxxHHSC8RpIPvW2q+5cA9OPEj?=
 =?us-ascii?Q?Xng83u1GfmXAPd/sa3u21hY+adlFAC2Yg2vRiPwNE2BmtWPRU5AG+ZgqW4pD?=
 =?us-ascii?Q?dBM31wrNfAqlQ9YHXHp5AQXhXHByHQDcBBoHefQXu11x3Yf7cPte4r6pksc1?=
 =?us-ascii?Q?YSjSXSH6Po0l/at+294mSb4u6wD9A9o8XfE3Z0CxMbaeSK568DvlNjQIvM1O?=
 =?us-ascii?Q?6fp5Acoag06EOnJdZaYSBnkiNLrY8mEfj985jiZXhYYKTshP4X1KwZxRV9KG?=
 =?us-ascii?Q?l7jnSyrGRM/OhczBYdrJX25Q8iRifKjDq00i0SDOk+9g8oKMUcvp5B8K6SVm?=
 =?us-ascii?Q?cAenBVgdLUpKeetM+nQq5VFRtyXJS3y66/IGPDMcnQvL+eju92QmnO2hdVfW?=
 =?us-ascii?Q?b5xY5wWapW3nzwdK+sE5jwOxT4JbMFpWnOFzxa3fMpm52wst7lVqPdr1BFTm?=
 =?us-ascii?Q?j/d0BsvFlQEsKmgdC7+3lB88bnI+M9zKc5PRvLEXZHwn2jQzOseqXPFhgv60?=
 =?us-ascii?Q?JDM5hH8Vfhb5/W0GZOzWF1yo6/1b6PrZmEg+o0GvmU624ho3NaFwxpKZrbLI?=
 =?us-ascii?Q?jbmLOen48+hoMz3RCpaVLwiB00fpxXhwpxdimMArClo9E2r3zkSm1mHZmCcm?=
 =?us-ascii?Q?sSP4pxdWgjJH2IRDUDrT2KFk//D4Y21sU3cMOdqForhmF6hIAYSzd9g1XQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:32:23.6224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83113392-21d2-45ab-3bcc-08ddaf036ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051

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
results in user-visible file descriptors, so they should be subject to
LSM/SELinux security policies rather than bypassing them with S_PRIVATE.

[1] https://lore.kernel.org/all/b9e5fa41-62fd-4b3d-bb2d-24ae9d3c33da@redhat.com
[2] https://lore.kernel.org/all/cover.1748890962.git.ackerleytng@google.com
[3] https://lore.kernel.org/all/aFOh8N_rRdSi_Fbc@kernel.org

 fs/anon_inodes.c   | 23 ++++++++++++++++++-----
 include/linux/fs.h |  2 ++
 mm/secretmem.c     |  9 +--------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index e51e7d88980a..ca6cfb1cd496 100644
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
+EXPORT_SYMBOL_GPL(anon_inode_make_secure_inode);
 
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


