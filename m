Return-Path: <linux-fsdevel+bounces-29700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8BE97C77D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 11:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DEF283AF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229171953AD;
	Thu, 19 Sep 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H3POO4VL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F519DF8B;
	Thu, 19 Sep 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739115; cv=fail; b=dCcYTAE/53UOhq7Wypa6dl1UD+JYK0oXim/e/NIMWSu2EM7SHCqEt+JpQk7GiXt3wp4cpR1uL/avq72XBT2BxT7rRZi/F1zG5EdEUyEA6ggVxYUXUpBRpqYwgdiAgMhVybtI2AZazyEeXcaTdFO4SXodkcb+ruHNgxOSBFfZ4rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739115; c=relaxed/simple;
	bh=ReSF15x6Fz9cbAIS+BmPe3ITzPb/PVO4IMCRZRH9514=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emJvgo+wJBbIjZsMAq0FIuteYbrfiRT4e12PIm1yF/e88e4tOC/xFogp2Xz51gtsDNtxNC+k9myrTGDgFcA2fqbNImJCl7LCpou9hEFwSu+LZvF8uCi35wvW82NneOjRmO1SeTxnfEJGDbfv21t/UU5/dgcsoy+IIkNTZ9YHVeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H3POO4VL; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vv98mZ055XpIpRH7oeVcm2n29qWOKhwYeS8+YQYXVOQ66lLuGFfsx4ot0T+Q//v63o5Wwdi5AQOD4y6VAd6bL1u0cHOdRxGsd+2Ex7ihwNCIHG1pvrHYLUjCifFke8HUw7hSBdRLxh8/CQX8O4gwdUYOFSfv6IKX3mpyxvOIh/u/YTw1OCW9hjgTbqfenhEvb4syQtj+3z8+fuTKSIQS3WZro4Vl41ilIfNz4w6L/YBdTQ9JJCXW8CUb7WT8qsyK1NDwBI1tz9/22EYMsWkDX0dFaO0gkRAsxbeVDTIDqs/vQJPc8TfrkM5sBstTwBgoaIcSb9uHWxDzQpeks4WuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wOCBU41KU/9jYAjuxEnaob8uAuZTVT2xJKX1zAfNJ4=;
 b=nFSDLYXIWGcYyXuv4R4ct1ERo1/R1bd0X5z314kli9YEdy5nDgMbaolyGD3QNACkRxhUjZG2yCqlMoGt52L4u5lv5aOV+vXSd+lGLRXhZjHVClsRqTYM99U0Oe9TMgspC63zeqQPJddMhzfPxu/oYTVbKDe5bwgUrZFrw+f36V8DEfYehdWqjuaY5nJvH7hBteOPNLVaWo2nqTcyJ8c93Q+RdFVhe0EP+A1h+4aGEwLSY24/EdBPrObQkFWUkQxK/eyBCQTgaVVLwPNqXo5AY5G5/VOodWQ4/OsHnCavL8BCheNzE4JwDkEWV7H/Kx1fc3MWnSwMr0PzFgz6NEUXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wOCBU41KU/9jYAjuxEnaob8uAuZTVT2xJKX1zAfNJ4=;
 b=H3POO4VLjrtWTRSVMGOiZ6zqWp1sSOpudJburHalHlF79Upd3tLNM3spgt2H3EXZnb9UH+4uvQA3Kc0bQ91lKLSQXV1yBtW+0aGmxxnkFWAf/AhXbJceRNvRv/+2XKGX+FKp5isY9/z5CN0DlF7XmNQPS3qBaqzu5Aq4Xq9m4Hc=
Received: from DM5PR07CA0098.namprd07.prod.outlook.com (2603:10b6:4:ae::27) by
 DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.17; Thu, 19 Sep 2024 09:45:09 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::a2) by DM5PR07CA0098.outlook.office365.com
 (2603:10b6:4:ae::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Thu, 19 Sep 2024 09:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 09:45:09 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:45:01 -0500
From: Shivank Garg <shivankg@amd.com>
To: <pbonzini@redhat.com>, <corbet@lwn.net>, <akpm@linux-foundation.org>,
	<willy@infradead.org>
CC: <acme@redhat.com>, <namhyung@kernel.org>, <mpe@ellerman.id.au>,
	<isaku.yamahata@intel.com>, <joel@jms.id.au>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>, <shivankg@amd.com>,
	<bharata@amd.com>, <nikunj@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
Subject: [RFC PATCH V2 1/3] KVM: guest_memfd: Extend creation API to support NUMA mempolicy
Date: Thu, 19 Sep 2024 09:44:36 +0000
Message-ID: <20240919094438.10987-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919094438.10987-1-shivankg@amd.com>
References: <20240919094438.10987-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 58805957-a8ea-462c-956b-08dcd88fc019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rv8E5uecIgabxP5ll8kOmFJCjFHgm1nd/NbLTRCoeB6GJIKxcfS97sWMS7/N?=
 =?us-ascii?Q?4BSU2qRf8b82hH2hG+vJPMqHwViciAIvDFJodMeh+H/5aeQQZoEv+Y0argQG?=
 =?us-ascii?Q?5jCPSXW9Hz5hRANf0fh0NFmP1BuJDkIoeriIWUC/SjRZiIdALsROaZkxXdFA?=
 =?us-ascii?Q?kqSGuN2vcdLGc+4dOV3muJ9eXPen2/rI/fuYMaJB34G9ihI24L26uCXwmY9M?=
 =?us-ascii?Q?9HLNX46UxS6iCR78gBmYgzTm04Fb55Bbs4wDnIUKR4dilds8rd8Ms9R3BFM3?=
 =?us-ascii?Q?nwqqtCcU899fByw8VgmHkQYJWLYK5z7lMe0cHWVYUtv2rGz7vq4qgHnMDdP2?=
 =?us-ascii?Q?6Vzzxjrt811baWe+wRlsVetb0WkbwSSMm9O9WVArk6kXpRTO87u66php6sGb?=
 =?us-ascii?Q?Zs3yKXF/GwpOlNzUhPrrWan9Waa+FKUP9+QvSOPIkTTAdoBsgy3yzTdfrZi5?=
 =?us-ascii?Q?aCzINm7wLiWGVexDQfMol0fedvfpEV5g8ba003JVaDyxIQCtfojuOpSCvi8w?=
 =?us-ascii?Q?IA6x1b8Ai7U8C2m777aGD2g9VDZYoVh55e21A/NFZhuq4P8wDEd5GQf+OBm9?=
 =?us-ascii?Q?fSKnWsvXfxTMNWvUTHeK7Wk/EO7KNcNNYhZHmWOZ1YQyguDdlEoU0BJTYBFE?=
 =?us-ascii?Q?Aziu/dovUHC9Hujei3is6oU7k6Mn2EDov7GliO9ZplWmrSkzSGeYOEkSmcNo?=
 =?us-ascii?Q?RDMEr+R9B/2F/EBfkm1CSeOLbT3txJEsSLVEka5UBb5djJwFi7PxjtdhUx87?=
 =?us-ascii?Q?JssnQ9d5NHh9CJwJfSC/QnEKqhgl8u25CO1sNie2j70vOqFiDuS6HeNww1j/?=
 =?us-ascii?Q?2lPm1VfjS1X3DAdfjQk0BImq2oqbTdtiRSRZRiB9cQ7XRqwZKBn1eAg5tZbT?=
 =?us-ascii?Q?k/lvvnnhXd3N7c4EjuqyVo+1NCBdGRDXz0N2vqsAZXe475LoPLSrs13VBuE4?=
 =?us-ascii?Q?2hkO4UCXRknjhu2ldwDAbUwFcdBSi3FYPX/DCOUikkSEuekFDlMaOa8OntFi?=
 =?us-ascii?Q?sybaRoLI6yf4VdvgT1+2MxbCHbYkbG6Je8L7XSOIJ8z6x3KghhtMkoWOBaRK?=
 =?us-ascii?Q?VEKP1OHGCb63Jv4G8XsniIEJpo4N6ot1B5u3fxRj7y79VAh/dHupl1bIJ15j?=
 =?us-ascii?Q?8hMM8PMvMxLiesjyoEn7Uzoz2vTNTIM+64ncfjMfuluu1ZRF3Q8plTZGZjpr?=
 =?us-ascii?Q?VBNxp6Mm1kxzqZDjTpWqyZw/PHwRs7eQbPqt5GpK+BE4suGiPj7sK6x2rByQ?=
 =?us-ascii?Q?rvIb7Y+vuKeOZlcN9l1kWTouRXwdmlnkIuNwrB2+nUCrCGfwn1vGl9q+3lW6?=
 =?us-ascii?Q?0RhdPexdV2vNjp+mXHJpHIg2xj8MVY3SSQVqM++o4cyiHTHqa+qcTnjE0JqE?=
 =?us-ascii?Q?D0m+9qg59GpWl6Qd4/BRJl2rDQibFBmjkbQhiVV+1Er9wXf+vmg1aJ+GAbxw?=
 =?us-ascii?Q?tzqeULvC7jj6hT1ZORHJC9I4rBuU10ha?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:45:09.3655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58805957-a8ea-462c-956b-08dcd88fc019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216

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


