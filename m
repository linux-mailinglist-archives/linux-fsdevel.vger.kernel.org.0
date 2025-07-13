Return-Path: <linux-fsdevel+bounces-54776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE522B03268
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 19:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B31A189125A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445C9285C9D;
	Sun, 13 Jul 2025 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EWP8xdOf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23B367;
	Sun, 13 Jul 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428896; cv=fail; b=ERbZv3L620UEeZhlkfbc3VXU4HU9YqfwSMq16fmW9l0dN98On/ABV1I2Rs9q6yP4bq6M0oKfUrsZuGzhdV3hOuJ/8/gWILAtM8BCjh0ASaSHzI2ye7YVMKqqSQjL+JBoJyuRMME/+un1FxBDJtuTpe69HzT/AZnJBAuczVzHDJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428896; c=relaxed/simple;
	bh=XgGH/jn5i3ZwreXnFnAQm4S9etK58fMAnurujIUUX8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3+cAyahYdrPoyhiKgpNBv7+TVLABrcqprujkV64ADFBMaP1ETkKyM/5yLFo9FAGuJnedO9AY29idWuTCmK3FItG5PuV8Nm52bES3JfYkSR3Q/Wxh/GH71QBylvd2QKxEBa0Vzr631vLNmXJY5Y8itiJT3TUgu+27wwPG+TFJq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EWP8xdOf; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBurinUAR0DK82+yT0hDOdHEqvu8pezSzmg7/sl1M06mD/K8ltbYTY5LTidv8oYwXjCm9/TZICm++fTKjlRFtBc1V11XFhOQ5ajHKACSXXVaz1cJz/BRsNvSI77XIpTlZb0LAJa8QdkqW2rjLR8vvFHcPeaEQt3jr3D04p9dLTh9VpHEx6i6g71Xj7/ApS7dp/HWbeejljivEvKvkOrd4tAmxDpHUrfyCNxZ5A7/w/rLP4zKResXQz9Cm2e/yspogMPDiAZeOTvQPu5TD9UP77qdadh/rcJSHpqo0GYISLe9KRjSpKoqZMdbt6zjgooZJdsJ+0E4RUb+o6iVIBldPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHEry6TrMM6YwTIsEMy6xU6qIRKzlrf+533jG1Q6zBA=;
 b=Mmutlmn1iApevTAODEiCdgPSDFnBdgRBYuZW0fHYZANLMsiXsepGrlxHAkCp+SjWQjq0DBap4ce63pYPC7xQ7G+RdX2AmTBjjyjlIem9ipUvZNiU3gHqKlZnSlI0ukRjhqpPynEzSlgqKXRnOYNx5PYbUzubJPaB3xJz21p8xacl69rkVmKbQwbmBw5BdDsJ3dO3zLqnUqC6NSv4bh4ceNZS+pW/SAyuc+R0cyFoXc5LwwX+c33ck61HaoNDoXLgtq4ED0CURLPoIwGiaBJzgD3+Nc9sApj7yCgSeN96C6/y+vF/Mg+o0ADmafZNo2DDOm9xA7Okq/Jp7PHn/60Xiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHEry6TrMM6YwTIsEMy6xU6qIRKzlrf+533jG1Q6zBA=;
 b=EWP8xdOfq8U3dIj0UsQKaejCedwAOlyk3L5vXa1aYIdGiUiPNxtdEUIshqWFVIBzKmtARuAHrtsZuDfI2fdIqv08yMn1r6Wdt15BOxLBDY8y3uezQp/YkJPmj62gIJkGSPP06AVsReVZ2MkPtBYtassVhHBL5OqRfPEtEQJmjhg=
Received: from BY5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:1e0::21)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Sun, 13 Jul
 2025 17:48:11 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::d4) by BY5PR03CA0011.outlook.office365.com
 (2603:10b6:a03:1e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Sun,
 13 Jul 2025 17:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 17:48:10 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 12:47:50 -0500
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
Subject: [PATCH V9 1/7] KVM: guest_memfd: Use guest mem inodes instead of anonymous inodes
Date: Sun, 13 Jul 2025 17:43:35 +0000
Message-ID: <20250713174339.13981-4-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250713174339.13981-2-shivankg@amd.com>
References: <20250713174339.13981-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 36179e1c-5f07-4767-2ea4-08ddc2356f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FU9eFFQqaIeov9ARThdEUldafSHEIFSpEoUdHx6lPJ2Lho4DNX8Vs9ZrpLBV?=
 =?us-ascii?Q?/vmeEiYuRv2Dn0GxqSrhjjdUYO87FXq6gCIviLdoslvglCGkDPw4zTpKWnU8?=
 =?us-ascii?Q?HlyHvnNoAVmaP738nR7npxXZmJIm/GfW6UjBD1Nv0X9qubSp80FQYYffyaPR?=
 =?us-ascii?Q?DaQQFTNaLXeLrmbszbdVglk5YK/ZMevdiIPAA0hoa3i3cg6FnUPFuTUNzrPs?=
 =?us-ascii?Q?DXh/PeIyd/bnWS59CwhGjTuHk1ufsXYfjseu2hXR1bQJPmQI3B+0r1Ys4hKr?=
 =?us-ascii?Q?33e0IKwnvq2pITWn3jJghPgVCPC8ilf/BAvydw7kgo74acpVQ7oY8viFlJkc?=
 =?us-ascii?Q?nh4QNz4sVegSg2nVNqOBZLrDgLEvDh2F7euNmJnfZ16DEQWYuQr60KXl9rDj?=
 =?us-ascii?Q?FDRkEbQVgfle90KXiQ0vb/i9Ai1F6eb2W9pKIoBawZ1JzNjmoQ+zW8i0EFPn?=
 =?us-ascii?Q?QWLXWPCNO2hxAv2yfeRdvgmLcqy+Pwh1hAKjxY/YjLdPpOV+xnEH4za8BHBz?=
 =?us-ascii?Q?Sflis0pchCpyep8akXeiPBBPghOmP+WuNPFOOuSP8NZQ0Rw9+v9QLC+M4X6Q?=
 =?us-ascii?Q?TCUnn4k4EqsNXDShR0CAnBdyw95Pw5R7qeQIB6ai5dv3w/aswDhsURmzyO1P?=
 =?us-ascii?Q?CjUSmHVuluyGo+3qt2OMlukwsvBWEv2PP+Zeg+KwS05r0YRdqJM8lfJfzB3F?=
 =?us-ascii?Q?/p/vKlKEkI8EiGvcGJ0rIp9maEi91jnijrCvr+tr7pBoGL9uZ+ymdWzsggS0?=
 =?us-ascii?Q?TbC+dbDlGfl67trWGQSEzEdMccUzLfTah2pYPY0NhkJl75dODWUXVdA5rIWA?=
 =?us-ascii?Q?0N3O8qeEj+pqNjmc5JuuXkYfRlymkPZuhnl/7gMFxi/JyakW36C0SUhFRhl3?=
 =?us-ascii?Q?ou/M6ZlNnpquP9rrVEW/BRGEtZvCdi2Gti/+kThQSzrUC9D08Ih+RDq8W4t0?=
 =?us-ascii?Q?ol2+LBJJij8ERGpMpBwpr3dKuN1nH0aa2H7z9367UZTR+fOSFWPaqOSFA/09?=
 =?us-ascii?Q?egJYX6gpYsJBG9nppUqPJMgD+Me9Sm3NLO8XNF0uV/MT6r3pa5PT0URcpLLx?=
 =?us-ascii?Q?qJh3T+MtwHVad1v4m1pOAaK2DOFkf79foQTc/dByCLQKzl3hXepYSRkw16Uu?=
 =?us-ascii?Q?y45cBDFd5q8RQxbKc7utXZZ0hheXRpaSFQnzVemIUpzSe8JaRqNLr4pH42NE?=
 =?us-ascii?Q?X+tv81Huq1jko9Aw1tUAMcHptBE4fJn8Dq2/UUftHfu/gopKksEXV+Z9sX/G?=
 =?us-ascii?Q?7dywOZwpikZT3g1ZTuTfOlv8nbHA/Hhjky2x7nnX419pAXW31P/BJMnngD4U?=
 =?us-ascii?Q?+xCGkN6vOODc2mgvaYKPKCE2VTdsoXrrVqSqHv7quK5fP9Zzdh6pbSVPRjdz?=
 =?us-ascii?Q?UFo0YYybtL9cR9kAAKc9Kd48JDxTs+oN0QOzxpRbv/AF2S5skVxsasY0ZTt9?=
 =?us-ascii?Q?0G4s2lRQKB48xg4X/wqZZxl9aF3OEEEM5rRT5TDYrsMDTmy22tpdF3rxkDjM?=
 =?us-ascii?Q?ydkkx6c9C6gLmk2NGaXqdNNU1IuMthkR2yJn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 17:48:10.9227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36179e1c-5f07-4767-2ea4-08ddc2356f2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243

From: Ackerley Tng <ackerleytng@google.com>

guest_memfd's inode represents memory the guest_memfd is
providing. guest_memfd's file represents a struct kvm's view of that
memory.

Using a custom inode allows customization of the inode teardown
process via callbacks. For example, ->evict_inode() allows
customization of the truncation process on file close, and
->destroy_inode() and ->free_inode() allow customization of the inode
freeing process.

Customizing the truncation process allows flexibility in management of
guest_memfd memory and customization of the inode freeing process
allows proper cleanup of memory metadata stored on the inode.

Memory metadata is more appropriately stored on the inode (as opposed
to the file), since the metadata is for the memory and is not unique
to a specific binding and struct kvm.

Co-developed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---

 include/uapi/linux/magic.h |   1 +
 virt/kvm/guest_memfd.c     | 134 +++++++++++++++++++++++++++++++------
 virt/kvm/kvm_main.c        |   7 +-
 virt/kvm/kvm_mm.h          |  10 ++-
 4 files changed, 127 insertions(+), 25 deletions(-)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index bb575f3ab45e..638ca21b7a90 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -103,5 +103,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
+#define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d01bd7a2c2bd..dabcc2317291 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1,12 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/anon_inodes.h>
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
+#include <linux/fs.h>
 #include <linux/kvm_host.h>
+#include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
-#include <linux/anon_inodes.h>
 
 #include "kvm_mm.h"
 
+static struct vfsmount *kvm_gmem_mnt;
+
 struct kvm_gmem {
 	struct kvm *kvm;
 	struct xarray bindings;
@@ -388,9 +392,51 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };
 
-void kvm_gmem_init(struct module *module)
+static const struct super_operations kvm_gmem_super_operations = {
+	.statfs		= simple_statfs,
+};
+
+static int kvm_gmem_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx;
+
+	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
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
+static int kvm_gmem_init_mount(void)
+{
+	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
+
+	if (IS_ERR(kvm_gmem_mnt))
+		return PTR_ERR(kvm_gmem_mnt);
+
+	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
+	return 0;
+}
+
+int kvm_gmem_init(struct module *module)
 {
 	kvm_gmem_fops.owner = module;
+
+	return kvm_gmem_init_mount();
+}
+
+void kvm_gmem_exit(void)
+{
+	kern_unmount(kvm_gmem_mnt);
+	kvm_gmem_mnt = NULL;
 }
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
@@ -472,11 +518,71 @@ static const struct inode_operations kvm_gmem_iops = {
 	.setattr	= kvm_gmem_setattr,
 };
 
+static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
+						      loff_t size, u64 flags)
+{
+	struct inode *inode;
+
+	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
+	if (IS_ERR(inode))
+		return inode;
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
 
@@ -490,32 +596,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
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
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f1ac872e01e9..9ccdedc9460a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6486,7 +6486,9 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (WARN_ON_ONCE(r))
 		goto err_vfio;
 
-	kvm_gmem_init(module);
+	r = kvm_gmem_init(module);
+	if (r)
+		goto err_gmem;
 
 	r = kvm_init_virtualization();
 	if (r)
@@ -6507,6 +6509,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_register:
 	kvm_uninit_virtualization();
 err_virt:
+	kvm_gmem_exit();
+err_gmem:
 	kvm_vfio_ops_exit();
 err_vfio:
 	kvm_async_pf_deinit();
@@ -6538,6 +6542,7 @@ void kvm_exit(void)
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
+	kvm_gmem_exit();
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
 	kvm_irqfd_exit();
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index ec311c0d6718..089f87ed00dc 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -68,17 +68,23 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 #endif /* HAVE_KVM_PFNCACHE */
 
 #ifdef CONFIG_KVM_GMEM
-void kvm_gmem_init(struct module *module);
+int kvm_gmem_init(struct module *module);
+void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, loff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
-static inline void kvm_gmem_init(struct module *module)
+static inline int kvm_gmem_init(struct module *module)
 {
 
+	return 0;
 }
 
+static inline void kvm_gmem_exit(void) {};
+
+static inline void kvm_gmem_init(struct module *module)
+
 static inline int kvm_gmem_bind(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
 					 unsigned int fd, loff_t offset)
-- 
2.43.0


