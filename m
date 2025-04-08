Return-Path: <linux-fsdevel+bounces-45972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25813A80083
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6095E1882568
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E5F26A1AF;
	Tue,  8 Apr 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m8d9YYdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDC268C44;
	Tue,  8 Apr 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111525; cv=fail; b=eQ07iE1Px2rQcL4XeuFb0UCXAlEx5HemRJXiB129pl6Q3w1NApiL+n72HAoqBwhmE2Hd/hXmJa+cAPd/KmFhbn40vLFAHcJXyGrGffO9p1eE2nl4fycj2E3jy89kTa8igIk8bpATP4zoDApWfWNPCFBAgktDOHjXaBUkO/FX0ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111525; c=relaxed/simple;
	bh=hmeM27VRmgcbGxR8D8x2uc8yFa8llyHNxAzhb8N62aU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqQ5btxHzQbyyydw69cVmgHXTQNIObU40iawRbpyQc5YrQgl8sQXEqkqHPS/t8/eOM2/YNXArGyhNReS8cwJ/x1IosJcsW1w1KvTq0HGnRlHATcclPFXBeSuq61db661NSMLzGEq15H6qVLJc6h7YPYA9sKX2ppIGSgXWc5Ho4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m8d9YYdY; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR7tKYgjFOR4broq9+G6IpG/bcJO//E0qQPesMqEJZP0a16XCqr0E22Y24m+SMnn63sMPAxhcqRGX2DMTPrjq4wkeMwZLGlMcMfrdSqSiBaDLd+vbFTNvgxbSzRCzX+wIknLyjpdb8K0wyOvkJC7YZhnGrC1YBfOCTY0FO9slWYNGsEsjDB3g+NSyBzHilRL7RAe9ohnGiSGaIdJ+S8ISzWINjwpWSdHQRgxc9YAoKLd5n67KUQ05uCAEQV058ldQU9S9MokTlz/hteiTBvKJNEYopsFPJ++RivXuIEmMhpp063KgVJw6yIUdTSoHhEpJq9XUbvKvPCBINv+mJFulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtDtGnERGZVqPB/Lfqu6uZhmDvUEr3T8WSdW0Gr4W5Q=;
 b=sMS5klPWhvcwzven8xwAsUWvWxx9KF+7jXSiaAzsZWUCJgiTww+h3Ua9VCmVKx0RUWrDmMcvjOwoR5RgbC+02MSijHI6lhQhTcfsyURwJVdlXsNHXy7ColdLjPXeBWyk+hRjF5gYV75YdSK/5Yddqaw5XFzkGOW+O0vrTOzShwIEUUKnfZMv3y9teWn7zGTxqCpLcs/IYmpED8PUFMAZpoZcharwbxq1ZZgEynGtA+k/YO2OW2QDZS7FW4+KahRyy7bI0rQwnRRhantJi239qWZBXnRf9o1WG2zSXDNMfhnpBOacZjgodSr8Q/G8y++1RUzoIBoxVN1BvhNl3sge6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtDtGnERGZVqPB/Lfqu6uZhmDvUEr3T8WSdW0Gr4W5Q=;
 b=m8d9YYdYPcLhqqs+i/oL+tss0AzWDfK4heDBNoHEHk4Cw70zoT4Fdz+EdUEf0Yku3p38IuLDLWRWzH6tGNnX4sVz0Oky8juMUgfg72Z30Yrz28xZQire4wJ3KwC2GwMr8Y0MRw43NlNMbBD3/Gq8tvrE5HxiFbr8jii1Q2wVFhg=
Received: from PH8PR02CA0003.namprd02.prod.outlook.com (2603:10b6:510:2d0::29)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Tue, 8 Apr
 2025 11:25:20 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::84) by PH8PR02CA0003.outlook.office365.com
 (2603:10b6:510:2d0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 8 Apr 2025 11:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 11:25:20 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 06:25:10 -0500
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
Subject: [PATCH RFC v7 5/8] KVM: guest_memfd: Make guest mem use guest mem inodes instead of anonymous inodes
Date: Tue, 8 Apr 2025 11:23:59 +0000
Message-ID: <20250408112402.181574-6-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: ed778027-b6c4-467a-edc8-08dd76900bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?neqr2vN/D+uZHvExlrSqwn7MPv4B2nmMK8ezTkoH6hm0kHbN4UR7MFyiK9CD?=
 =?us-ascii?Q?ciHdicKN0FjpA1JsQQDQpFspbtPi0JJUoCVEwAXBd3Brq33gWOxOpUbRDbQo?=
 =?us-ascii?Q?uJ4URozxp9kHmzRVWroRCIdakUI298sMzXYSbvVoLkF6SnUoCoZ/V1maMxa0?=
 =?us-ascii?Q?1ZJNRcLkR9ZqRVJI8ZlGx5T9P2DMwKO3OOLD4XgJ+nsesax36yFawB3ULU0K?=
 =?us-ascii?Q?Cj7F4OTvW71s0g1ktlbYoqTEd1XMwFdblYG9ZLuEY2jsMVIgrmrr2ebCbUhS?=
 =?us-ascii?Q?GwQ0ftHT648GrFBQ0/9PDEClPRSE1R4e4wCFvzPDijfLwnbHu7FpcDdh60U0?=
 =?us-ascii?Q?+2m8oSrqajAYF+EGvj0u3Jnf5tJs428eGpWokuG+U/r0ajxkRnqrb59l9/47?=
 =?us-ascii?Q?HFEMRy3PHMA11cAU97avLkgqK32a3nfo78S2GO2W9eGVN19x5JKXdN4coAMO?=
 =?us-ascii?Q?P3em40AwLWOovSv5DUSXqDCMyp7uPRa4t24Dnid4Ap2ya0MIs2grnTjBKuSO?=
 =?us-ascii?Q?iCsCEOidmeauIasLwPh0BVf7RoAs4xzv7MGLA7+e/lkZyLYtU0o9PEG7tH7l?=
 =?us-ascii?Q?3rowWPJgZrT0T7/5hW3McgISBrFHlGABaECxcLhfbR25/UpmEYbMZk5oNjFy?=
 =?us-ascii?Q?4bzhsnTgXIOwaqRwnk47FPiIDzomOlMbR9nS+hs8o10gZtxZzGXyq/yZs0WA?=
 =?us-ascii?Q?v/xpfAD14d6XSqNXfFQexJKtbRXyQ0c+Ykq7ZzQzFxcMvdUSkbPjKXUTEQk8?=
 =?us-ascii?Q?tl4c3KOftz9yitCjTS5m4giNbu06FBNAyJxjFKuRmNa5JOvlGfeAh2wQwY7r?=
 =?us-ascii?Q?T6+2U6Dbi1MuxBswsC6ANDllWYLwTIfyk0vW065pu0g1LuguFBzcoN16Xnsu?=
 =?us-ascii?Q?eWpI4i9wOOb8URf0iE/TeNh2uu5W9kD2Y+Rt0B4tF2di5RO11N2YtdiAWE4d?=
 =?us-ascii?Q?8rVk813lRhkZikoiqC1yicL9zzaCFvlnxwO9MYyurM+861wtH6DClTMKjeZp?=
 =?us-ascii?Q?FozGOVqMx3IDZesGG0ushLC4DxnpnCECnErQG2NpHoJTP67DYBjGTIh8ayaZ?=
 =?us-ascii?Q?LgRS5r89N/xBex9ykEYdK229s9AqAz2q3RkyUO/hTvpxRUp4b3I4DyQbg3NK?=
 =?us-ascii?Q?vYHLHyTyjtqlchn+iTV701HtGYdv4RoxIhwV+cIxQPpMhKyqS0FXexxVYPJS?=
 =?us-ascii?Q?j1vLUufq0xHD6gqAE/uwI55unP03p898SZzluvP5c4E7GE/jMBdSyu15Jp4/?=
 =?us-ascii?Q?SbIWQf/AkpWLcUZAvt/iFUHd1655RxrJ0iIhkpPLxTdoPw/LgUofwzb0KNEv?=
 =?us-ascii?Q?aE80qQdIP2dLowmza1OYsykBrs/n8Fwk9tP3BWdZSa19ia51TYzmjz+9N+VH?=
 =?us-ascii?Q?juoabc7TXki13SbCfEildcaQdVFPaDRVnlTZcLx5w6l9d+P78Wt1x63F2hC+?=
 =?us-ascii?Q?ED56i4+7UIccLQMUamcAulSvcCuSM5/PabI11tiJfgHriNc9KpQM7d5/gfC4?=
 =?us-ascii?Q?e5PaLOmR+SHZeAc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:25:20.1201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed778027-b6c4-467a-edc8-08dd76900bcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968

From: Ackerley Tng <ackerleytng@google.com>

Using guest mem inodes allows us to store metadata for the backing
memory on the inode. Metadata will be added in a later patch to support
HugeTLB pages.

Metadata about backing memory should not be stored on the file, since
the file represents a guest_memfd's binding with a struct kvm, and
metadata about backing memory is not unique to a specific binding and
struct kvm.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/uapi/linux/magic.h |   1 +
 virt/kvm/guest_memfd.c     | 133 +++++++++++++++++++++++++++++++------
 2 files changed, 113 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index bb575f3ab45e..169dba2a6920 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -103,5 +103,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
+#define GUEST_MEMORY_MAGIC	0x474d454d	/* "GMEM" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 88453b040926..002328569c9e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1,12 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
 #include <linux/kvm_host.h>
+#include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
 
 #include "kvm_mm.h"
 
+static struct vfsmount *kvm_gmem_mnt;
+
 struct kvm_gmem {
 	struct kvm *kvm;
 	struct xarray bindings;
@@ -312,6 +317,38 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
 	return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
 
+static const struct super_operations kvm_gmem_super_operations = {
+	.statfs		= simple_statfs,
+};
+
+static int kvm_gmem_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx;
+
+	if (!init_pseudo(fc, GUEST_MEMORY_MAGIC))
+		return -ENOMEM;
+
+	ctx = fc->fs_private;
+	ctx->ops = &kvm_gmem_super_operations;
+
+	return 0;
+}
+
+static struct file_system_type kvm_gmem_fs = {
+	.name		 = "kvm_guest_memory",
+	.init_fs_context = kvm_gmem_init_fs_context,
+	.kill_sb	 = kill_anon_super,
+};
+
+static void kvm_gmem_init_mount(void)
+{
+	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
+	BUG_ON(IS_ERR(kvm_gmem_mnt));
+
+	/* For giggles. Userspace can never map this anyways. */
+	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
+}
+
 static struct file_operations kvm_gmem_fops = {
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
@@ -321,11 +358,13 @@ static struct file_operations kvm_gmem_fops = {
 void kvm_gmem_init(struct module *module)
 {
 	kvm_gmem_fops.owner = module;
+
+	kvm_gmem_init_mount();
 }
 
 void kvm_gmem_exit(void)
 {
-
+	kern_unmount(kvm_gmem_mnt);
 }
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
@@ -407,11 +446,79 @@ static const struct inode_operations kvm_gmem_iops = {
 	.setattr	= kvm_gmem_setattr,
 };
 
+static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
+						      loff_t size, u64 flags)
+{
+	const struct qstr qname = QSTR_INIT(name, strlen(name));
+	struct inode *inode;
+	int err;
+
+	inode = alloc_anon_inode(kvm_gmem_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return inode;
+
+	err = security_inode_init_security_anon(inode, &qname, NULL);
+	if (err) {
+		iput(inode);
+		return ERR_PTR(err);
+	}
+
+	inode->i_private = (void *)(unsigned long)flags;
+	inode->i_op = &kvm_gmem_iops;
+	inode->i_mapping->a_ops = &kvm_gmem_aops;
+	inode->i_mode |= S_IFREG;
+	inode->i_size = size;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_inaccessible(inode->i_mapping);
+	/* Unmovable mappings are supposed to be marked unevictable as well. */
+	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+
+	return inode;
+}
+
+static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
+						  u64 flags)
+{
+	static const char *name = "[kvm-gmem]";
+	struct inode *inode;
+	struct file *file;
+	int err;
+
+	err = -ENOENT;
+	if (!try_module_get(kvm_gmem_fops.owner))
+		goto err;
+
+	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto err_put_module;
+	}
+
+	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
+				 &kvm_gmem_fops);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_inode;
+	}
+
+	file->f_flags |= O_LARGEFILE;
+	file->private_data = priv;
+
+out:
+	return file;
+
+err_put_inode:
+	iput(inode);
+err_put_module:
+	module_put(kvm_gmem_fops.owner);
+err:
+	file = ERR_PTR(err);
+	goto out;
+}
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
-	const char *anon_name = "[kvm-gmem]";
 	struct kvm_gmem *gmem;
-	struct inode *inode;
 	struct file *file;
 	int fd, err;
 
@@ -425,32 +532,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 		goto err_fd;
 	}
 
-	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
-					 O_RDWR, NULL);
+	file = kvm_gmem_inode_create_getfile(gmem, size, flags);
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
 		goto err_gmem;
 	}
 
-	file->f_flags |= O_LARGEFILE;
-
-	inode = file->f_inode;
-	WARN_ON(file->f_mapping != inode->i_mapping);
-
-	inode->i_private = (void *)(unsigned long)flags;
-	inode->i_op = &kvm_gmem_iops;
-	inode->i_mapping->a_ops = &kvm_gmem_aops;
-	inode->i_mode |= S_IFREG;
-	inode->i_size = size;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
-	mapping_set_inaccessible(inode->i_mapping);
-	/* Unmovable mappings are supposed to be marked unevictable as well. */
-	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
-
 	kvm_get_kvm(kvm);
 	gmem->kvm = kvm;
 	xa_init(&gmem->bindings);
-	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
+	list_add(&gmem->entry, &file_inode(file)->i_mapping->i_private_list);
 
 	fd_install(fd, file);
 	return fd;
-- 
2.34.1


