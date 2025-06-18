Return-Path: <linux-fsdevel+bounces-52037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D95AADEA38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC2B3A8218
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993E2E8E0E;
	Wed, 18 Jun 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3NgkmsV6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB32DBF62;
	Wed, 18 Jun 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246294; cv=fail; b=JO/bIDSJ/jgg0fxUAnypZUBPn9v6pjpRbU73Hzj7Ucag19Cp6lXXQCBCnm5oShW00kC1VIjaC4mOJrBquNLcMwQg6VOZuYSB9E42Z5xEEe2Mo0VAKpF1tzwLlTOQUjnwiLBm0Y2M3rp+RQxd/hfDUrdvpLSlhe1zrtmiLBNTsyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246294; c=relaxed/simple;
	bh=JJtqDa3VWFeXLPo5CDLTbWFpXl4VC/64GAjP58654u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSjCyFB0PbT/yoYleULTPQ+c2HjlYhsdbIH4cEL2PzjXe/UZ1MSwgy9Jv+fPrOjNiOiwTEqPDNRL7dKr9WSCHSOTIoCDjay5xr8zGngQFTK+tAfDxvon1zuRI/c1dOlSBta+qg+UyDVIyszpsSpO0czlL3jSDAThzbKYGuI0KEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3NgkmsV6; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLyhpHMkErdw1UuOP5w/2ngIcY5WgG5Tc9zpyuZtTAhW7WTmgZOIvWdjpc4dMKHDxwy+4EBtwER3LDba41mEA5ZAmWETwCYEslFX3mmlZ+3s+WT44cW+DyGmyStnDNiu/vYvO8/EmZcbHCA3AON4LPdkUesNWL6ExfBwaUL+SKWSHA83leWyIJyHwH6/PtLTP3rb4kWPgextOL8AB/J6e6j2zn1Vm74FqrT9/7R7CIwdbLpL4cJuN8mdie+l+4AwjlnNcw46HMHfN2pBYR/3+V1r5RouCoAuzyEN1f+iKmyMQ6d2EVYnFyHi9d7ygLjKodEKfv1MVjLjSe2OIGEcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfQXSb5tak1K9mOX6+8D2lKXxaLY4oi2TQeAVwUQv7A=;
 b=ZtEWTW/mw/evO+wExrMYhtFCdLWhRb6kvoffkc1D0JjakMXAVdF5PJFtYt3cNb4Az5fteyazN9HBOShf0C8xmQi2u+SjXgoEHHfLwG8oaniP2fcQkPh8mgc6fTCy5JtbwsprLxZQ07HxInasyhBudqrNxDeTFCh/Y52sln8v/hw/rddNAr6zT8m5e8m+pAp6qSkJC3FqOSsZusNygzaKEWTKNDV+PS4v5rmDXQH7plC31Oe1uUdR38p/unzk3t06J5Bs6KqXtHH8hQiNmrM1uj6jp4h/DFZYGNq44bYYMO2NznU+Xuqma7+FmGjO0RQws+NMQJhxgu8+VrB2m6Sopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfQXSb5tak1K9mOX6+8D2lKXxaLY4oi2TQeAVwUQv7A=;
 b=3NgkmsV6Pe3WAIb7XCvjNUfoXF4okcDOaxervL4URWkm8glMAv5RSvnzL3IzP8W7VAqhjnTFu58v7czyjZsQU8LGVDB34Lq2IJXEIJt+8CeyfjWD50FXRtoBVcOBl0d1y0TOpehZO048S7b+UAFQqrkcPuUhK+Dm1gL+yLropGY=
Received: from SA1P222CA0047.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::20)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Wed, 18 Jun
 2025 11:31:30 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::ee) by SA1P222CA0047.outlook.office365.com
 (2603:10b6:806:2d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Wed,
 18 Jun 2025 11:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 11:31:29 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 06:31:09 -0500
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
Subject: [RFC PATCH v8 5/7] KVM: guest_memfd: Add slab-allocated inode cache
Date: Wed, 18 Jun 2025 11:29:33 +0000
Message-ID: <20250618112935.7629-6-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7a7ebc-a1f7-4b44-f2a7-08ddae5bab38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5E7EEkIVQklvmBdhpm4P94mI093+WVTp/FCk/tVr6LsZS7TlRwAr7tnK6Bt?=
 =?us-ascii?Q?VwxQkZsR2O10GDvUgrVHN27ToMmz5RCtcNx1zW08qUvTZrEaAjxeQiLGzh5f?=
 =?us-ascii?Q?xmXkEqI4yf/kXLUhRAhGoZmXAYwmbkRH7/FQceveUjSHNbneAvYLojXOo67U?=
 =?us-ascii?Q?0wAc9K7qfKMetxUzQXG15MCTRytaK+NnRCUIM/mwrCNT2f6UTh2Q5FSLu/Ho?=
 =?us-ascii?Q?NFAKfB9nlVbGs5jiC2eaH8WpwpqJvCxyxkEGUzzrm31s5ZryWh2AIfWjwD9n?=
 =?us-ascii?Q?xIwSE4ueWJiUCCJ8jGowfI8ojzP4l8nbYQSqHhD8NttIivymmuhLIcRtlVBg?=
 =?us-ascii?Q?80s7gr5Xe+uwMYf1x2CYzEzFNuafqT7S+pGoRcby0itsRkvadeNZFc8spXO2?=
 =?us-ascii?Q?/lcqyBJFFqknq084qQibJ5gC9cimfBwzkeXOGoRtrUWE9K5IbijSCr9tnIO8?=
 =?us-ascii?Q?biUxkD6vamHcvbxKuKfLyxqwN+uNYYYXSLtxYRQ+e/O/cL1hxQvlS73mKUja?=
 =?us-ascii?Q?uo/JJxSt0nSjUJ6ovpVIBKVgw2g62ekBvMnon/OaelyIFVo44Xfct8RqLrzV?=
 =?us-ascii?Q?C0lUx8QhW2cQF8P7JZ8oGohgSv4wdhg8By0UDIgNWuHAWaKgJH3D1wd81BEb?=
 =?us-ascii?Q?s1w4t0DNLhC3/Qw/kci9Kru6esrmyN+bMvrpj8UKGsth4QyqlvyYYc8UlkDK?=
 =?us-ascii?Q?1Pukmdyxp+n0ZuAER7p1kWdtmmFve6E4XMDZXL+lxtf37OhVjwN8ypTUKV4S?=
 =?us-ascii?Q?AkBWYn6PowmyTCvfSK5N3iI3yCSHxqlmuMH3Iz0EMv2KILUwBB93906zRyq+?=
 =?us-ascii?Q?GkEw46gkom7PMhubP4sJkYRsJllYMqlPjzx1j8/xakklM0T7SLB5oEyhAXC+?=
 =?us-ascii?Q?rekv7ltmgBBGH21uT/LJ6aPosSnPQCUEeUGW00/E+2r/GnR8Rxu71+1ppwYV?=
 =?us-ascii?Q?sFGGtZw3PODg4dWLVyhhwQRXbaKPZt/zobvL8tkEqW7c/eF8C9F7X4s5WTpk?=
 =?us-ascii?Q?6hVsOk+5U09ejUGPN4L1YmgMEhq3phL5SjkDqfwezoCb5/XmM7jbM05kQe4I?=
 =?us-ascii?Q?ieCqMa1qI6xXHe843/an5TYOb9SNxdhSwMTHyZtvJP8KIGZZZny/56Qk7ZuW?=
 =?us-ascii?Q?HO36YNtvfMmszDE/VMmgV2LkIJTF3bW6mLi7Mif4s3jiaIrJqUZjVj9y977t?=
 =?us-ascii?Q?1mcecoEdVmETn91CG3++dBeYnpznSDhAs8D/cBNd1ZGiGF8BoxQIsxGr0E4a?=
 =?us-ascii?Q?ggjmD1jjPG1lrCHTyvyjGea+oIloNOIqbx8IDMacJ9XuxdwTQg1QEt/Jfiw8?=
 =?us-ascii?Q?yYo5LDW1fKQHTtSEiNHfmf58mwNQ2fgnJ4MMAso9xvCIyvsCM9YQkz2fyNh1?=
 =?us-ascii?Q?tZlwzVQTSqYGQbOZRq+AwlESQHIgu5HokPSw5HyZXxfHrAR32BcrIAGyKGm7?=
 =?us-ascii?Q?Qusnskx09k0xd86O3Ck9gpdrW2f9EBlXCHGKRPRDFv9ZfvMH6bFb3NRgWH/7?=
 =?us-ascii?Q?lZDkUzELHFeTjL6nVcGQc/EutaoOK60G3UFN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:31:29.3719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7a7ebc-a1f7-4b44-f2a7-08ddae5bab38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1

Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
inode cache for guest memory backing, similar to how shmem handles inodes.

This adds the necessary allocation/destruction functions and prepares
for upcoming guest_memfd NUMA policy support changes.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 159df462d193..5a1ce6f5e287 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -17,6 +17,15 @@ struct kvm_gmem {
 	struct list_head entry;
 };
 
+struct kvm_gmem_inode_info {
+	struct inode vfs_inode;
+};
+
+static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
+{
+	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
+}
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -392,8 +401,33 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };
 
+static struct kmem_cache *kvm_gmem_inode_cachep;
+
+static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
+{
+	struct kvm_gmem_inode_info *info;
+
+	info = alloc_inode_sb(sb, kvm_gmem_inode_cachep, GFP_KERNEL);
+	if (!info)
+		return NULL;
+
+	return &info->vfs_inode;
+}
+
+static void kvm_gmem_destroy_inode(struct inode *inode)
+{
+}
+
+static void kvm_gmem_free_inode(struct inode *inode)
+{
+	kmem_cache_free(kvm_gmem_inode_cachep, KVM_GMEM_I(inode));
+}
+
 static const struct super_operations kvm_gmem_super_operations = {
 	.statfs		= simple_statfs,
+	.alloc_inode	= kvm_gmem_alloc_inode,
+	.destroy_inode	= kvm_gmem_destroy_inode,
+	.free_inode	= kvm_gmem_free_inode,
 };
 
 static int kvm_gmem_init_fs_context(struct fs_context *fc)
@@ -426,10 +460,26 @@ static int kvm_gmem_init_mount(void)
 	return 0;
 }
 
+static void kvm_gmem_init_inode(void *foo)
+{
+	struct kvm_gmem_inode_info *info = foo;
+
+	inode_init_once(&info->vfs_inode);
+}
+
+static void kvm_gmem_init_inodecache(void)
+{
+	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
+						  sizeof(struct kvm_gmem_inode_info),
+						  0, SLAB_ACCOUNT,
+						  kvm_gmem_init_inode);
+}
+
 int kvm_gmem_init(struct module *module)
 {
 	kvm_gmem_fops.owner = module;
 
+	kvm_gmem_init_inodecache();
 	return kvm_gmem_init_mount();
 }
 
@@ -437,6 +487,7 @@ void kvm_gmem_exit(void)
 {
 	kern_unmount(kvm_gmem_mnt);
 	kvm_gmem_mnt = NULL;
+	kmem_cache_destroy(kvm_gmem_inode_cachep);
 }
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
-- 
2.43.0


