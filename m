Return-Path: <linux-fsdevel+bounces-29515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BEA97A656
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 18:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D671C2205C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B9915D5B6;
	Mon, 16 Sep 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YkW338mG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E815B984;
	Mon, 16 Sep 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505912; cv=fail; b=nJMudvbNJeL7vYOJ9luxr0t8inkE0UyHZqVu8xnK4/jSI62M8q867Tes003gd1/LZo3zk2oYTwgoqRyKJhVA0B8cwuRqprZRaIB59i+XEp3MlydeNSL1lM9J4MFNboLjx3lmcNLHKGcYwl8Xm1rGugbZEpuSpojZ9SGollNJR8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505912; c=relaxed/simple;
	bh=ReSF15x6Fz9cbAIS+BmPe3ITzPb/PVO4IMCRZRH9514=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mN7ZZarj5lUX3UbPw+BUxojUMt6umdQyJOks690dpSr3d50uUzUnSpKurrH6LVnLGLKaqiA60aTLtLA7MTpSym85DFJFGJ5m42VqxPE8LwBQgkmrlFkNQyFoLED3h4D73bHk6wSpJJ6fYE/A8lxnJJKa9v19TvC9RUC0pJ3Ri1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YkW338mG; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5y6xQPiUWn1DkHwR7oPqcS4vfNLDWC0FGJJDw48UDdk/1KWPt2iQeRU9+UoTXqzxdYZSYm8nRKmgRSmIu6nRgFqSepV1MzuZLT6XGer1fUfiaQS0VSP7K4b0QGuegIq0/+vfR5hjnrgK6aalgKM83q7H43Iqme0CDRAh3t7i39Ss7EUXVvDpypyRtQAghverH/WqIEfVgmG8B6DrTVG3qiHKsn3uxtf+KCYkSaP2ViwVR4/ykDNInD8vzFO7Ma+FDWJMmH4DXzZk2ROIxn83KMoXJZdUqaVPU38bNp7/u01g2SX3fJGheGTLyXhPu3EKU6V4ESHG9w9IUoqY90Pqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wOCBU41KU/9jYAjuxEnaob8uAuZTVT2xJKX1zAfNJ4=;
 b=DTWFQBBZJO6MXARF6+3FX8YDTifPLsd3rl8u3iTh0MThXxIMSyW+r0mlmYJGrcj+NJ5emH2YtrVYRuYTXu7vLKVKFqGGvsZel59yKa9xCWRtNoMxSSIez30v5VWUvyw6U7d8BJj/s61j/qn8GrZ9Y8xnNNjRpfd+kCqgVLWlOsaig1H9xxLLBtSqq6Vu+y1qaZAxNTCgtVydKq9qZ75CHX19ICE2U+dYh0qzpQqaPKW1RVAWCSnbo8Za47rHGiIRjUWNpPjfdwaAjMkosubbK2Dm6paV0KS2N38xj6V+mtu1HgQBpAX3vizBFOrLvJLfhLMIVE/ytSp1zW/cFSRoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wOCBU41KU/9jYAjuxEnaob8uAuZTVT2xJKX1zAfNJ4=;
 b=YkW338mGtmM/rP8DoGGhHvxaaWZyPz217gv0nhKYa607H8Xy4KVzPe03YaOw+H/BDKVtp1Y07yERDK+s4LM0RYm1qVch3XeLPumE8o3FsUhrKzBAGjTij9ZS7DtEPLYhoxYx8wwBnYArgHvPcPU5A2lwIJkr+fk4iZB1XGl6WqU=
Received: from SN7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::14)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 16:58:26 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::8a) by SN7P222CA0002.outlook.office365.com
 (2603:10b6:806:124::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 16:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:58:25 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:58:19 -0500
From: Shivank Garg <shivankg@amd.com>
To: <pbonzini@redhat.com>, <corbet@lwn.net>, <akpm@linux-foundation.org>,
	<willy@infradead.org>
CC: <acme@redhat.com>, <namhyung@kernel.org>, <mpe@ellerman.id.au>,
	<isaku.yamahata@intel.com>, <joel@jms.id.au>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>, <shivankg@amd.com>,
	<shivansh.dhiman@amd.com>, <bharata@amd.com>, <nikunj@amd.com>
Subject: [PATCH RFC 1/3] KVM: guest_memfd: Extend creation API to support NUMA mempolicy
Date: Mon, 16 Sep 2024 16:57:41 +0000
Message-ID: <20240916165743.201087-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916165743.201087-1-shivankg@amd.com>
References: <20240916165743.201087-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f062da-5119-462f-3b16-08dcd670c77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sZuALtDDyE42Hp6mjhfDVXmW9wXL+1lX5Uq8rwB9yvdceyK1wqkKEghwGTaL?=
 =?us-ascii?Q?trvdIVuxgxIIUSXVsl9ZPKfe/nCYQV0lHtAUFcmscwNm/6LHip/SHO4TKjLC?=
 =?us-ascii?Q?SIcFcUpJvKpSOlc8B0ya680oyKcaPHVGhpj8DLerjhMo2vYcWqE5kSvkiywS?=
 =?us-ascii?Q?Jh2ETgdXnYzSnS5QYO2DI3DkwYNef2ZCsgKP6dPDpKyKnTK4Q67wuh6jTV+Y?=
 =?us-ascii?Q?erJSdCqt9tRdDZUEt4ioj5TTuclVgFiygOtiiouhZsh/fF91HRO16drBeVNZ?=
 =?us-ascii?Q?G0TSrpXPc/8qAj28TTA2w1hgkzNQBg8M1K0j1QuQ0unvBuM5+Ez9quCiMOVP?=
 =?us-ascii?Q?I2ESXF/m2LOkyPz8Ymu1SQpk0/myqoKeoX3nCCV+P+/1GezdzCvjS5aBb+kW?=
 =?us-ascii?Q?EsDX8b6xzzZTGuzVIRRgGlZkogeQfaXuDi1DX6zf7yVhR1h9xZjW2fmq42SK?=
 =?us-ascii?Q?1MCnv4qJT43ZTOOqH0xkvo1ewgiscEOjCTzzXX1lSorVv/YrWcKQAA4HbwsT?=
 =?us-ascii?Q?Vqnmb2ySKgGxXtKGPdO729SWn678wCf8k3ZoBTsYA9gBrgggMjw3RjWlGpsv?=
 =?us-ascii?Q?FEBemPS3GfysMlcLDX93nbG482gZZokSFjk/zVrT1LFAz5l4exT7QPVxHAoy?=
 =?us-ascii?Q?vk0BBM+7G2VtDz1xAhMaEZDDFR0TtqUBEC6pQHGCQfF8wh5VadFrMLxSTN3H?=
 =?us-ascii?Q?i9/EHcLbvUEUbUMCZfmI9x+gupLhVhw8T1yP5OzymP1ayYD90Rc1IdKdRyAb?=
 =?us-ascii?Q?0zNsgRDO5SkkiLb6oZeJ1Lv9FOUmAouS+Ir+mAVNQj8IqIsiDgolp3d1cmaQ?=
 =?us-ascii?Q?xkePFUfKPPnNv2a/YfFESrI3o+jWyn7/RJIpbIhDhZgPEhuGJpNIHBAnCGRr?=
 =?us-ascii?Q?yQER3GOmG9Dhw87WPN8XhQ6QsIq6cC2+S3PdNsQJUY/ozA1f4vSt5ALM4DP3?=
 =?us-ascii?Q?9jD/aSFspzFa78EZC0QN7YB30e7eQnAk27yjYtMzToWD35yQ7bt6iEYU39U2?=
 =?us-ascii?Q?XyAP8zhXZeX4k/Ae+IxjkgtBCateatGS+sHif8rCGFA9dzHS88Y3L9pjKB+b?=
 =?us-ascii?Q?fpraeNx3Hs0iUwvtK4A+JT8D5RlH77OMW/wg4vdE7+d3eiTG5bBQRyHWrexk?=
 =?us-ascii?Q?HSfjvvJOU2fWzMuJlzWNscK/SBir4dYzigCgLTqTS2E4giIffOkWmmIgEiNR?=
 =?us-ascii?Q?YpYErfFCuufPKyNd0ya037HKzaAMo87w65JkqBb+XPeafNHBRlvmMGey0X3g?=
 =?us-ascii?Q?rGRVFjULDzT0Inaox9es7rzYJwWhwkx5vG1jRamD97RJtzhPCIPZSeqrWzSm?=
 =?us-ascii?Q?lPpMSOL22n6us0EzpagR8UfoXRVJ3VYrC4akyTLzV9E3qXntHpwvvc6GwZjK?=
 =?us-ascii?Q?aqD+uR5UUsbQKJnO863Flokl7t7BCH/dxUJFvG1LfXuZzRisSpQdnLSVZUQm?=
 =?us-ascii?Q?5F+/pVOzQO64qVhwQSiF4LnrMUG1H5UH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:58:25.0515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f062da-5119-462f-3b16-08dcd670c77f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

Extend the API of creating guest-memfd to introduce proper NUMA support,
allowing VMM to set memory policies effectively. The memory policy defines
from which node memory is allocated.

The current implementation of KVM guest-memfd does not honor the settings
provided by VMM. While mbind() can be used for NUMA policy support in
userspace applications, it is not functional for guest-memfd as the memory
is not mapped to userspace.

Currently, SEV-SNP guest use guest-memfd as a memory backend and would
benefit from NUMA support. It enables fine-grained control over memory
allocation, optimizing performance for specific workload requirements.

To apply memory policy on a guest-memfd, extend the KVM_CREATE_GUEST_MEMFD
IOCTL with additional fields related to mempolicy.
- mpol_mode represents the policy mode (default, bind, interleave, or
  preferred).
- host_nodes_addr denotes the userspace address of the nodemask, a bit
  mask of nodes containing up to maxnode bits.
- First bit of flags must be set to use mempolicy.

Store the mempolicy struct in i_private_data of the memfd's inode, which
is currently unused in the context of guest-memfd.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 Documentation/virt/kvm/api.rst | 13 ++++++++-
 include/linux/mempolicy.h      |  4 +++
 include/uapi/linux/kvm.h       |  5 +++-
 mm/mempolicy.c                 | 52 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/kvm.h |  5 +++-
 virt/kvm/guest_memfd.c         | 21 ++++++++++++--
 virt/kvm/kvm_mm.h              |  3 ++
 7 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index b3be87489108..dcb61282c773 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6346,7 +6346,10 @@ and cannot be resized  (guest_memfd files do however support PUNCH_HOLE).
   struct kvm_create_guest_memfd {
 	__u64 size;
 	__u64 flags;
-	__u64 reserved[6];
+	__u64 host_nodes_addr;
+	__u16 maxnode;
+	__u8 mpol_mode;
+	__u8 reserved[37];
   };
 
 Conceptually, the inode backing a guest_memfd file represents physical memory,
@@ -6367,6 +6370,14 @@ a single guest_memfd file, but the bound ranges must not overlap).
 
 See KVM_SET_USER_MEMORY_REGION2 for additional details.
 
+NUMA memory policy support for KVM guest_memfd allows the host to specify
+memory allocation behavior for guest NUMA nodes, similar to mbind(). If
+KVM_GUEST_MEMFD_NUMA_ENABLE flag is set, memory allocations from the guest
+will use the specified policy and host-nodes for physical memory.
+- mpol_mode refers to the policy mode: default, preferred, bind, interleave, or
+  preferred.
+- host_nodes_addr points to bitmask of nodes containing up to maxnode bits.
+
 4.143 KVM_PRE_FAULT_MEMORY
 ---------------------------
 
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 1add16f21612..468eeda2ec2f 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -299,4 +299,8 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 }
 
 #endif /* CONFIG_NUMA */
+
+struct mempolicy *create_mpol_from_args(unsigned char mode,
+					const unsigned long __user *nmask,
+					unsigned short maxnode);
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 637efc055145..fda6cbef0a1d 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1561,7 +1561,10 @@ struct kvm_memory_attributes {
 struct kvm_create_guest_memfd {
 	__u64 size;
 	__u64 flags;
-	__u64 reserved[6];
+	__u64 host_nodes_addr;
+	__u16 maxnode;
+	__u8 mpol_mode;
+	__u8 reserved[37];
 };
 
 #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b858e22b259d..9e9450433fcc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3557,3 +3557,55 @@ static int __init mempolicy_sysfs_init(void)
 
 late_initcall(mempolicy_sysfs_init);
 #endif /* CONFIG_SYSFS */
+
+#ifdef CONFIG_KVM_PRIVATE_MEM
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
+	if (!scratch)
+		return ERR_PTR(-ENOMEM);
+
+	mmap_write_lock(mm);
+	err = mpol_set_nodemask(mpol, &nodes, scratch);
+	mmap_write_unlock(mm);
+	NODEMASK_SCRATCH_FREE(scratch);
+
+	if (err)
+		return ERR_PTR(err);
+
+	return mpol;
+}
+EXPORT_SYMBOL(create_mpol_from_args);
+#endif
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index e5af8c692dc0..e3effcd1e358 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1546,7 +1546,10 @@ struct kvm_memory_attributes {
 struct kvm_create_guest_memfd {
 	__u64 size;
 	__u64 flags;
-	__u64 reserved[6];
+	__u64 host_nodes_addr;
+	__u16 maxnode;
+	__u8 mpol_mode;
+	__u8 reserved[37];
 };
 
 #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e930014b4bdc..8f1877be4976 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
+#include <linux/mempolicy.h>
 
 #include "kvm_mm.h"
 
@@ -445,7 +446,8 @@ static const struct inode_operations kvm_gmem_iops = {
 	.setattr	= kvm_gmem_setattr,
 };
 
-static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
+static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
+			     struct mempolicy *pol)
 {
 	const char *anon_name = "[kvm-gmem]";
 	struct kvm_gmem *gmem;
@@ -478,6 +480,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	inode->i_private = (void *)(unsigned long)flags;
 	inode->i_op = &kvm_gmem_iops;
 	inode->i_mapping->a_ops = &kvm_gmem_aops;
+	inode->i_mapping->i_private_data = (void *)pol;
 	inode->i_mode |= S_IFREG;
 	inode->i_size = size;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
@@ -505,7 +508,8 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 {
 	loff_t size = args->size;
 	u64 flags = args->flags;
-	u64 valid_flags = 0;
+	u64 valid_flags = GUEST_MEMFD_NUMA_ENABLE;
+	struct mempolicy *mpol = NULL;
 
 	if (flags & ~valid_flags)
 		return -EINVAL;
@@ -513,7 +517,18 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	if (size <= 0 || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
-	return __kvm_gmem_create(kvm, size, flags);
+	if (flags & GUEST_MEMFD_NUMA_ENABLE) {
+		unsigned char mode = args->mpol_mode;
+		unsigned short maxnode = args->maxnode;
+		const unsigned long __user *user_nmask =
+				(const unsigned long *)args->host_nodes_addr;
+
+		mpol = create_mpol_from_args(mode, user_nmask, maxnode);
+		if (IS_ERR_OR_NULL(mpol))
+			return PTR_ERR(mpol);
+	}
+
+	return __kvm_gmem_create(kvm, size, flags, mpol);
 }
 
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 715f19669d01..3dd8495ae03d 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -36,6 +36,9 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 #endif /* HAVE_KVM_PFNCACHE */
 
 #ifdef CONFIG_KVM_PRIVATE_MEM
+/* Flag to check NUMA policy while creating KVM guest-memfd. */
+#define GUEST_MEMFD_NUMA_ENABLE BIT_ULL(0)
+
 void kvm_gmem_init(struct module *module);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-- 
2.34.1


