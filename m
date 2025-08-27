Return-Path: <linux-fsdevel+bounces-59421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980F7B38918
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4B946407B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8AE2E0B5C;
	Wed, 27 Aug 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="saqCQBEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA9277016;
	Wed, 27 Aug 2025 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317436; cv=fail; b=XJCftqCj8LX3YH99XyJpUaXifD7DPWW4rs+Qq9MvEQMh/uzPfzFvsw4tfTMKXaKQBVH1R0tzqrO1UWfH/F1lgH56R4brJ1BFP/m/s72soeO6p8JKra43ZGfFPCR36c2bm3eu9vP/iRraG4s8ZP7N1XJ2e/Gn31YvViu027yW8IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317436; c=relaxed/simple;
	bh=B1CL6ATwhur2PJ8fD7H7zO99ZBQAvhL8a/WoclDWhTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJR0fr5FGGr7/WG4PHPbTfqa7IWiUYa2TYDsj/TRDRXuq5/05koRkvQnEQYiJ4nRQexHGhuU4iY18puro33n8zBk7EPRpE8shA0M5ssZN+OtQtZDWKPD3cTI5Fm86k6C03K+tJlLy/oiRkajWx0cvbbxxtcm1kWVqTPsdFqTYNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=saqCQBEK; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Crbxdl7vQNLQxLfHFuTNfAYDotXG4cZausWBd2QQ12uhsZkpSPC0Olnn6ln6p1BtwIcSsqQBpvYVIl041iZNoWI8NP6vdfwNaSKBCngNYxHvr3WmtL5lbsFgjE38Sq8OTuuOyRnkejKPFumQERjVzYkk19Iwn+hcgBzlHLHjKoK7v8t4FVuyE0W+A22tbrwUOvNla9cxy34O+PmAU6oD2kXACB9B/ZdJbL0XiIcNJZLCAA+4AAoDvtmaB1sffnq/mcl6Qu3WHnELrXvhzidkIU5yGfmAHqsY7T3xDPn6jQdM70rHoXz9Qz11ViXOYB8dLJcijU8tY0wh1tn8WrpmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh45BlQRd8lKAcWzWmeHjSQU39/827vrG2yxSJSUH2s=;
 b=XxAwEoG34XHdDgaZ7XhQHRf/JblZjgxVDV8T0eTY4P5NvOy4+LQYaNf0S18f8mIRhPbISTPhs8K02yPCBsZ9TKOzxk/nwyrO1DSe43H/b4Yr1b7ooFwSGmcVlBop35z6B+Fj+nNlctU/0VZsJDeWmKXfLaKzjb+pYa6lJwVzlACwFgH0ePXfwMB2s3OvLr/2be+ilGnhQLOa0Sq30UDdAeDhWI9DY6MBJjkv/eCbXzhWgcRN4DhFizWFl/7THXJ79vG7fpM87QXdSwP1+q40THciv+t485x3mjglmDQxvIJAGZlIwmAw80jWUiLNWs+LKoqeqagz7vA4H0vm8K78pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh45BlQRd8lKAcWzWmeHjSQU39/827vrG2yxSJSUH2s=;
 b=saqCQBEKniu2NdXJ0fKOFA32ETu+Ouz/ptHQgvAj9A6g2SvdgGJeUHYj6NTyOmx0O4G/4lHrGA0jhYQCi7i/2R+4hKq4az0EFlXiFT1tYWQfj1ae6tbDYx/aATKbnVpLelPV+yYbkQrXJdTjh+7CsnI/vBm6jzAvAnSDO6xX66A=
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 17:57:11 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e0) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.6 via Frontend Transport; Wed,
 27 Aug 2025 17:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 17:57:11 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 12:56:50 -0500
From: Shivank Garg <shivankg@amd.com>
To: <willy@infradead.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <seanjc@google.com>,
	<vbabka@suse.cz>
CC: <brauner@kernel.org>, <viro@zeniv.linux.org.uk>, <dsterba@suse.com>,
	<xiang@kernel.org>, <chao@kernel.org>, <jaegeuk@kernel.org>, <clm@fb.com>,
	<josef@toxicpanda.com>, <kent.overstreet@linux.dev>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <lihongbo22@huawei.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
	<apopple@nvidia.com>, <tabba@google.com>, <ackerleytng@google.com>,
	<shivankg@amd.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<vannapurve@google.com>, <chao.gao@intel.com>, <bharata@amd.com>,
	<nikunj@amd.com>, <michael.day@amd.com>, <shdhiman@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <jack@suse.cz>,
	<hch@infradead.org>, <cgzones@googlemail.com>, <ira.weiny@intel.com>,
	<rientjes@google.com>, <roypat@amazon.co.uk>, <chao.p.peng@intel.com>,
	<amit@infradead.org>, <ddutile@redhat.com>, <dan.j.williams@intel.com>,
	<ashish.kalra@amd.com>, <gshan@redhat.com>, <jgowans@amazon.com>,
	<pankaj.gupta@amd.com>, <papaluri@amd.com>, <yuzhao@google.com>,
	<suzuki.poulose@arm.com>, <quic_eberman@quicinc.com>,
	<linux-bcachefs@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH kvm-next V11 5/7] KVM: guest_memfd: Add slab-allocated inode cache
Date: Wed, 27 Aug 2025 17:52:47 +0000
Message-ID: <20250827175247.83322-8-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827175247.83322-2-shivankg@amd.com>
References: <20250827175247.83322-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: df7a1307-3632-461b-0cd8-08dde59325fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IrCqZiqASNJkr8Bzps5Md5zNXQTaaQPHmuCU5wucKi7dGsruYQeAD5qsMHUv?=
 =?us-ascii?Q?roDslivbOLCdj2GVZnKw2s1MkXKf3Fw4k7iKNNZUettCfVFr4vZcmwfD2Bb8?=
 =?us-ascii?Q?XYFkwo3Jiw8YFfr0VElE8pntEtoANb8CHcO38Iwvmmb3iCFNP0HPi+s4ZoLo?=
 =?us-ascii?Q?L52T+wJ7nKZ6onP1ad+WD6b/7zFCreWepCAVlYAxioAPcTqpSnWUoo7iWbTo?=
 =?us-ascii?Q?TNMIHUWLFCYfo5BifYKe3bQB8de+b226750KwgFrcumeM4vJSKUd4wqZA/t0?=
 =?us-ascii?Q?0eRDzH89kiBiUOfx6Vca4eeCz+K5CdnmPfpkYThBY1KJB97g9/NvW9Utbixo?=
 =?us-ascii?Q?3fSLsZECxYspI0hJf5WiBgh3qyfTVaKwf41z7EBcgMsBSW4PIyUQOqDN6JO1?=
 =?us-ascii?Q?EgDPKXvRp0WuLXbF9gNv2Cyog+NuiYcYEvAEylSQXqpSZyN3F4wp8TAdX3sA?=
 =?us-ascii?Q?IpdB1S67xW1w/gmO0I036w+dI5JnWHssgyPBDWlX8ib3jz1wcxHWmBBBJArP?=
 =?us-ascii?Q?EobxRz0FxaRfZ2z4ioPkLwuVRyAceBTT9rHCYLc0PN6g57L4T982WJnULy04?=
 =?us-ascii?Q?lpmnXJq31FKkOTGyKqJWy31Pu+4kGtsfvrj7NsVrB53qaUJbTU2cq4iegbXy?=
 =?us-ascii?Q?iqkyQYonJ9jQaqPJHKwBgqyaevt6+V04jkCtvNDeH863NjFVC39OLzrMNJ0A?=
 =?us-ascii?Q?X06t7tqTBiLm69WEMzat559QoFgQKHkxQvIh8txi9JhNaZN8e+ihFreMHsm5?=
 =?us-ascii?Q?mALpbGVAYN1TmvYAYxwGgkc9yEXnEGK1s1Cp8Y/3u9nBmnwiSjWfzjjOF0hK?=
 =?us-ascii?Q?QmsjJrz9hlienBq1lyqEJ30IdzRX0K6u8KyXhl7r0QR59DMHPnwfxB8Mf+vJ?=
 =?us-ascii?Q?0PH09DxFzuyKvnT1kNurWVJ2u0ncW9prm6//kHwIWHbixkWs9EpdA/h4yh15?=
 =?us-ascii?Q?PR1JZ/cJr+3lIgxMpNiYoOEvgn+nuwrcuBSf8KeAfzYYEV4Xo3oJoKszMSzX?=
 =?us-ascii?Q?8r24y3WETpnsmLvjYPvMubBpGVapx/p66x2N5bR7a4FiTPb0CEqVswcdQuYx?=
 =?us-ascii?Q?yAnmiYavvw2dW36vALopCn3mIQD/s7QByX0616/DyBlyX+zUlncrOt/BS2mY?=
 =?us-ascii?Q?XTMsR8kA7MXyzPgIOOSQhbI1CLrVxD7AvDb28K9EiFQOQt16iD3mB89yRK9p?=
 =?us-ascii?Q?f++p3y47uoftQDKar/+NV8u0wNxmIcXpY4r6s5iVhiVuEQf1ktAlH9208w5f?=
 =?us-ascii?Q?U8ciDte7GN6vMoKEbtNs3CLc+yKUqLjGr7Ih1FJciWZAs/EMYYhUXByYG2my?=
 =?us-ascii?Q?qOUUGBlEpnngqUZ+0mGbZtJvbsjd3iA92cSUeaHgc6sTjF9YIoln+s+/282Q?=
 =?us-ascii?Q?zUu7ig8yJgKNokmcbGnkOJqtuKkesJJYarkPtundAHwe/ie/OhPq6jqhOvFx?=
 =?us-ascii?Q?2GVScC5n+G+X6Spa35WzO/iZsDD5F1Qn+4RM9iKIzbAkECTba4+bl9+bGwfU?=
 =?us-ascii?Q?T/INWH/efkKV3Whtvplue8hv6FTO0UG9PB+C?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 17:57:11.5234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7a1307-3632-461b-0cd8-08dde59325fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233

Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
inode cache for guest memory backing, similar to how shmem handles inodes.

This adds the necessary allocation/destruction functions and prepares
for upcoming guest_memfd NUMA policy support changes.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 70 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 6c66a0974055..356947d36a47 100644
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
@@ -389,13 +398,46 @@ static struct file_operations kvm_gmem_fops = {
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
+static const struct super_operations kvm_gmem_super_operations = {
+	.statfs		= simple_statfs,
+	.alloc_inode	= kvm_gmem_alloc_inode,
+	.destroy_inode	= kvm_gmem_destroy_inode,
+	.free_inode	= kvm_gmem_free_inode,
+};
+
 static int kvm_gmem_init_fs_context(struct fs_context *fc)
 {
+	struct pseudo_fs_context *ctx;
+
 	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
 		return -ENOMEM;
 
 	fc->s_iflags |= SB_I_NOEXEC;
 	fc->s_iflags |= SB_I_NODEV;
+	ctx = fc->fs_private;
+	ctx->ops = &kvm_gmem_super_operations;
 
 	return 0;
 }
@@ -417,17 +459,41 @@ static int kvm_gmem_init_mount(void)
 	return 0;
 }
 
+static void kvm_gmem_init_inode(void *foo)
+{
+	struct kvm_gmem_inode_info *info = foo;
+
+	inode_init_once(&info->vfs_inode);
+}
+
 int kvm_gmem_init(struct module *module)
 {
-	kvm_gmem_fops.owner = module;
+	int ret;
+	struct kmem_cache_args args = {
+		.align = 0,
+		.ctor = kvm_gmem_init_inode,
+	};
 
-	return kvm_gmem_init_mount();
+	kvm_gmem_fops.owner = module;
+	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
+						  sizeof(struct kvm_gmem_inode_info),
+						  &args, SLAB_ACCOUNT);
+	if (!kvm_gmem_inode_cachep)
+		return -ENOMEM;
+	ret = kvm_gmem_init_mount();
+	if (ret) {
+		kmem_cache_destroy(kvm_gmem_inode_cachep);
+		return ret;
+	}
+	return 0;
 }
 
 void kvm_gmem_exit(void)
 {
 	kern_unmount(kvm_gmem_mnt);
 	kvm_gmem_mnt = NULL;
+	rcu_barrier();
+	kmem_cache_destroy(kvm_gmem_inode_cachep);
 }
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
-- 
2.43.0


