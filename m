Return-Path: <linux-fsdevel+bounces-45971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADA3A80012
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C217A6C31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E01226A0C8;
	Tue,  8 Apr 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s1XZalsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9616268FE5;
	Tue,  8 Apr 2025 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111516; cv=fail; b=nNk0gGNGei9hileOZIOxuoZTy1wE8YASgVDhlD35jv+wjjnb389L7L3y1ySaRPuwBNnnN91/oidOMNeK4dJa+l2ybXa1owQBJVpx1KlbZz1nJAsAlRzn+sb80ldjn2Rl6eTlcn1KUX99BbcmHg6j9Ynmg0s41hyRIJuD/mkJZQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111516; c=relaxed/simple;
	bh=jNMG2ZtK4IDdiYCPz1B6Sj7cBTo3745yhkxiiTm1gJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBJFzdsrL1+AdIKg79S6BmY9Mld+s1s/6E15wogZUPpdOQfcGbVleuEpzez4JTj1WVJqw2hYYeQoFtnDYhh6lgi3ezTB+KzHrAjS8n/xYCMFdqi+dbuwZVc2fe8RxJLEYICxdACI37HHO0QOirPTwXD9Boet31o96IsmWeLXntk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s1XZalsz; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD8y3lcoZ1iWn3cxEIB2zAtDZvDjTpo9I9FPxWLAey4PV99Z0FZsH1sTTtW1uXnt4MzBVHpNA1kWKHDZ6KQrUF2EHlqCCTbBUSYI3yfu+YwLFOJrWwJhQeFjM41K/NC00C3y3t9Oqy7pPFBboz+m/7JqtiFq+AvJQWZF83fl8C8OB+/Rzt+T3JXR/NPcPPE7M51qtaJEqjj5jsbiiwHQTAnb4nCoPghzm16wBav+TIzewiIG0oTUpCXRqt7ShBad3JP8ChX9h1NKBWSSS1boFTNGckumoLDCkghF3xE0tv9p3f8tamRodHn8yKcp6Q3/M+JhJmdmY1Mdmj5DRO5j1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsJfiIWvnnVL8+FaE/0HSXr+gQhYoiD9aQegFlkmumQ=;
 b=J/oxO0TGu4JfXz6r1KIRipHho6eZldkTcqet0t7Xed0wCSWfnVX0PfuuKTpY3y5dGwr20aWBQzQZfwBiPyp3NyQ6aC5XwlauyHP93od07v8qWAJEv74/I6NBuxF+D8/uf2D53Mu49Ym4rIFMl5/ZURJ7i4+M6utxE0+W4oUH84vMHzIrJKybvSqkVpF1wJa3GdJJ7hMF6z5Unt12mSFMjPSsTmobrTtVmMn8sGCjJotsNUpwmBeb6GbPMfSfSSynPO8pPNabrky489SIp5RbI8g8Uhmb1CDhPU7dZFjqfp7Jm1sn7mCjy62Lu5XtbYwd878wzMF7Do5DXDCAfDLdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsJfiIWvnnVL8+FaE/0HSXr+gQhYoiD9aQegFlkmumQ=;
 b=s1XZalsz+1XdBsuiOX53aarsfNu6JOyXK07De6czvKM/s5JpmlVWwz9eLS9iA8PEgoxzhAjm6GQyXTQClQIr9/yl6F6TOfN0F4izjH6O8AshqrJGuDn6snwGwyUOIpSfUjWnYKvk9Joj54qLx+GYfugTPE7Dl69k49oLUXKfuVY=
Received: from PH8PR02CA0018.namprd02.prod.outlook.com (2603:10b6:510:2d0::8)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 11:25:11 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::2f) by PH8PR02CA0018.outlook.office365.com
 (2603:10b6:510:2d0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Tue,
 8 Apr 2025 11:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 11:25:10 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 06:25:02 -0500
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
Subject: [PATCH RFC v7 4/8] KVM: Add kvm_gmem_exit() cleanup function
Date: Tue, 8 Apr 2025 11:23:58 +0000
Message-ID: <20250408112402.181574-5-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4436c7-1e37-44b5-7e2a-08dd7690062a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gxC6SjeXtximb3oqkb139F4GbNSM6/Iz0ya018YyW4u76fPAmdiffyMaJZEf?=
 =?us-ascii?Q?hmSnP0Qjwse32RIPcnQptCYmmAaaU+t3TLFPJleUTrk6jk147w50lLmFiatz?=
 =?us-ascii?Q?/akDvlmqC9oahVoNSc7uNb+DMwVV7dCaQ9h5F+nifESHout3crHweKFCMqHD?=
 =?us-ascii?Q?n5mEy2H0RHulMV/n6EdhTBlgh3D0RIgtVACZM0m4B+6m8haQHGDW2IhO1AlW?=
 =?us-ascii?Q?hONtjA46OIvF7LX2wH18EGax7yy3Uw9N6vyOrYcVH5IUCNVH1odlN/gVRCu4?=
 =?us-ascii?Q?mmMijmw2gjhpasimUwDmCeXHQlXMG6YN+YG0vC0y6+f0pcuZsWbqQwYCHN36?=
 =?us-ascii?Q?TQmK7d72q7ONmsjlEnUDyrm+fRuyy7aRkNswf/dnefvjUOEoS3ZgS46Et1ad?=
 =?us-ascii?Q?FQ1VDp+t6z4nTp4e6KvSlSrOgkSbmwoQF7YbgfJwv3pxtIG9qYnOTEIaZocW?=
 =?us-ascii?Q?uXlPsDjFYv3E6OytAymDHYi82JKTj5W4ebR5XyLooNJL9T4WhC/IEQ5T0gUb?=
 =?us-ascii?Q?+mOWOJHauqRCC0QxmYfUTVrwRigjvWetG81XqDyhp3BxQWUvCBjB3k9rGIy6?=
 =?us-ascii?Q?7qJhuDvVEqm6Ua9QIfKpsQGDS6fWsSveeP9ZAl2rnBq18mjUYzwZG0ST6bZi?=
 =?us-ascii?Q?FCtg7uj7rrWGKxNvomMPEBBJtBo5Y6LczNcFmVXdnJZr6h3RQynhrBETKUWx?=
 =?us-ascii?Q?gyboofXM0E+OX7v4+P4sqW9Joh09sus+g6cijFON27vJy3GJGzWAU7ehaeXZ?=
 =?us-ascii?Q?3HmqKDAB+P/Wpf1AR5ta34h8y4mIAQTCoYR2CHFKPX5UDHA0u/b67hJdo9P7?=
 =?us-ascii?Q?AGaWZShJ/7s+7PHB+l0MBtFL4jPWpFF3PIUtWY1bepIwdOJEb+oGI+LbuG8H?=
 =?us-ascii?Q?1bCJQAe0wOL2LwGWc5b3bYbCCPvtprkgC3bXXt0K2kmYOLw1av7s8IDcwv/2?=
 =?us-ascii?Q?BFoP3y6hRTs8S4mYUrhyICFqR3eeT48NHfk9GqwQ4AsV/f194DMaNArkjUWq?=
 =?us-ascii?Q?jn0kfWa0HHraghf1NSR0yE7jR7TzqL8Lj3U6Hs7Gswac9tEfpZaAkqKKpVwB?=
 =?us-ascii?Q?bsgcSTfgU96hvw4EgxX5C8Hllh1rTusEhOC9HwB559Rdqz0OoDlULNlJzZ8d?=
 =?us-ascii?Q?Tr9rgHkgrmhnWgB7lG1kUmiRH/IdTZeDHtTW5TWiTVQCVhL1im6CtzjAl8Zc?=
 =?us-ascii?Q?UKnvFYUmCWij/j61uq5CVQICp+Gr73vBJf4576GiTk+jRJRJI1D9tokusqQs?=
 =?us-ascii?Q?0OKpag5K63DAXlUqHhwL4idnGMFYbP9R3QXaRjzcc71vcAi+mcLBV3KYzQmV?=
 =?us-ascii?Q?8JBRoggaYcPM2Iw7uIjqZk7JdPPF3uNpiCmyM1/Xh4kdX8s0J/zT2YcsPfto?=
 =?us-ascii?Q?cnpVWuMy1xKAJyyx/wPvKzNvvJi91tBD7204araAdBDsBPN9UcIoJxVM4Gi+?=
 =?us-ascii?Q?eUeq5CtPkBsUX7jZA9xcMKD1Sf4BagI313CwtexIv+FWbTGjX41uxn4Bx02P?=
 =?us-ascii?Q?Fvs7/QOUGsg8IRM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:25:10.6669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4436c7-1e37-44b5-7e2a-08dd7690062a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049

Add empty kvm_gmem_exit() function for proper cleanup of guest memory
resources. Call it from both kvm_init() error path and kvm_exit().

This is preparatory change for upcoming work that involves KVM guest_memfd
using inodes to store metadata for backing memory.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 5 +++++
 virt/kvm/kvm_main.c    | 2 ++
 virt/kvm/kvm_mm.h      | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b2aa6bf24d3a..88453b040926 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -323,6 +323,11 @@ void kvm_gmem_init(struct module *module)
 	kvm_gmem_fops.owner = module;
 }
 
+void kvm_gmem_exit(void)
+{
+
+}
+
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
 				  struct folio *dst, struct folio *src,
 				  enum migrate_mode mode)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e85b33a92624..39580f79908a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6441,6 +6441,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_register:
 	kvm_uninit_virtualization();
 err_virt:
+	kvm_gmem_exit();
 	kvm_vfio_ops_exit();
 err_vfio:
 	kvm_async_pf_deinit();
@@ -6471,6 +6472,7 @@ void kvm_exit(void)
 	debugfs_remove_recursive(kvm_debugfs_dir);
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
+	kvm_gmem_exit();
 	kmem_cache_destroy(kvm_vcpu_cache);
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index acef3f5c582a..8070956b1a43 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -69,6 +69,7 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 
 #ifdef CONFIG_KVM_PRIVATE_MEM
 void kvm_gmem_init(struct module *module);
+void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, loff_t offset);
@@ -79,6 +80,11 @@ static inline void kvm_gmem_init(struct module *module)
 
 }
 
+static inline void kvm_gmem_exit(void)
+{
+
+}
+
 static inline int kvm_gmem_bind(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
 					 unsigned int fd, loff_t offset)
-- 
2.34.1


