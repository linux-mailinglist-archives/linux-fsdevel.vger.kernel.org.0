Return-Path: <linux-fsdevel+bounces-57278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E2FB202C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1A91612B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCA52DECB4;
	Mon, 11 Aug 2025 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o3xGfD3c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F22DEA94;
	Mon, 11 Aug 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903387; cv=fail; b=o2hR4rw+Nv8nOZ5l0OUR2XH6gcsa95VcssKbOugJvZmFEMBw/2y9/tcO194rHGWB7Ui1XMcWCc6PCRv8HsJNSNQesT+hcA6pyuHpgZ7vk7dP8/rk3z1ldyIzd838LWA92Le11xZrLX8/b7735Jygl/wC3/m4i3WwJVIvkuh5p04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903387; c=relaxed/simple;
	bh=7PQu4u1qsjvQOCpX8Pwv3dRBvWNZtfIMLqmeneXYOOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhWuqf6lIe3bX+dRZIkjb0GdE+u0clC6w6rQR4ZbBPDTlERLcdVuakPquCpwUNnUfTkciqpci+i8g114+l3HoM0dR0lf1LTWiFKAftSvI/DnprtIdZyHaPwdkROIf7Y07Mn1+giQ+2fIYLcCDMHNnm8OECYRKyZ7VWO+CEaS8Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o3xGfD3c; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYyvPkaYpKocTUhaBb33rZJd/NtSafFT7ZFJesoN5LsJnm2jdSsXKJLZ8gEZ46YZFH8Ot92W3E8oBX4i0P0KuM6OOfE0gKxuXN3SF4H8nUeJRS7vmiAkYGjDNxAsmc/e/Cg6gzWHNyICAO0WXrlr80+A+5hENMyjNcKV1f3SSmSRnmciASsI8n24pfjdsakEUtfYeTrziO9V+NNprxmbBLh/uaPlNGdzz/Oxt1jl4cQDolB/JaAy8yZTndcJY1v/ZhCh1GEYeZnn5285Jm9CGab09ZcdpZRgUmquKmEW5krGqSow4O2H3m6isUGUUlHsb34QZ7RQSUrbXmwdX56uTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99yeTHvEb0G/s0XfJ7JQXUrD11ZNBAqE0QxxPNgjeNc=;
 b=gJVDPzxbB+yeQ+tCodfJD7IMEDXmixxsR0C9+5u/aNbyvl9zZX6u2v55/4vlHusAH4ZjUYiojVwsral/9A/kFowM/Sy0w1HiaaosjiRAGj/vgRkTA5G93tkiJ5725is5l7qzVGA2RvIkMZG1TewfmEl1uwpzmmgR1VJbJv1uUrpXt9pf/nNlVfa84KyvGqZaVzJaUkqXzem6fRcHZk2sMLh6GZTQdDNYsdQlb6ox1nPpn0Tf0CtdHmGZmRMpPEa/kFcV+UAtK2fI1HFo53iH9BYQcIMPX0t9/Pcpg1+lHdatF+6pGTnwZhT3xpN+5jKzH4Ir/hxWpoJJSSAS/v8rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99yeTHvEb0G/s0XfJ7JQXUrD11ZNBAqE0QxxPNgjeNc=;
 b=o3xGfD3ckCfK8xXwwXOSNygNvGwTvurD4LqkmGNONJ+LdNUXjVpMeeQIkLcMrutCbEmNKq33w0D6dltPFfptS6HyVEgdOJv7l5pmLmTJWm/axJVkIZX3ZyeZgOh6fkR8Ld4j35UmeHZbcD3vlj/7ohi0G9azww1EE9onGOY6eG4=
Received: from MN2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:208:a8::24)
 by CH1PPFF9270C127.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 11 Aug
 2025 09:09:41 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::c9) by MN2PR12CA0011.outlook.office365.com
 (2603:10b6:208:a8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 09:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 09:09:41 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 04:09:25 -0500
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
Subject: [PATCH RFC V10 6/7] KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
Date: Mon, 11 Aug 2025 09:06:08 +0000
Message-ID: <20250811090605.16057-12-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811090605.16057-2-shivankg@amd.com>
References: <20250811090605.16057-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 7beeb009-852c-4061-a2e8-08ddd8b6ce2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vXOwtBuVTxIdKK+xhTUp6tagw6+FT1+cd1DFuI3bgzOEc7m78XZKAWo5N26Y?=
 =?us-ascii?Q?uaWFmryQKjiC8fDVrsgVXddypI0ehkyEHl5pxyV/GQHw+xaxcqw5idjcM/Of?=
 =?us-ascii?Q?GHfE6gAobxqmt5VyeGB+/U2sZltr4rusoybgkoEjPEZIqEWn8g+D6ZLloYB3?=
 =?us-ascii?Q?kS697SZR1NPrI6Snh3XRGuO1hKgemPpDe3jQpvMyic9XFoy7pYn5LDqXTOP4?=
 =?us-ascii?Q?h4XwftTfRFuu6C0otPO5a8wd6hh9BDSr1L9SLAVBrRqFvmqQmVwSP72Z8jon?=
 =?us-ascii?Q?vW4OrBxTNZzBFJyP5m8fSyV2pmbjYIEXx0jJLBcLvbCGSt5n649AsSgtbdqx?=
 =?us-ascii?Q?coWHR0Ih4kI6Kl0fNNVU4HtNRAxPxN6hINZR6Cs7IXdrUebu3djFXYqZbjbQ?=
 =?us-ascii?Q?ZBWiNYoibt3VRNoFZwdX7qco4Zz3Qo6Cv+xPaTbW96P9KqzkMBX+OouO3W/s?=
 =?us-ascii?Q?QV00I93iPb07DeIj4p9kNlKhvrlXpNunTMNcd+FZej5qBfk5IoTD2VglQz3R?=
 =?us-ascii?Q?dBgF7Ol051k/3tl+SKNnfQSE7hfW6GjCq5AbK9hoWAMjLIsYdn82W/UWxXpD?=
 =?us-ascii?Q?qmnApvQ8uxr6OmPMJkVD0tY26oIoURiHh+RbWWZ2FKc6p1NMNJp7qaN+mdwJ?=
 =?us-ascii?Q?koFBYd2SDiu3gXv9ft1hdi4YpkOlH802nIo7mbuzd+jeV38SgYH1ypCgpkLZ?=
 =?us-ascii?Q?0gZmwWQRX6CU1e/KLLKSHwtKCmuUf3TlsWt2eHQVVDqKYFV9fomcf7O3XhNN?=
 =?us-ascii?Q?DCtHMcaiBx7MWf+QeHzykWAgUeGkwbda3PEoy+iiZIlVstB/SaroVuA40r6q?=
 =?us-ascii?Q?dvPmU9g3Yr9456kf3FCupGdH8URiaSCoa3YXplI65KKK0IqwgmS5VZhFJLV3?=
 =?us-ascii?Q?tIw/pV/GxfkZJwyco7U3okMnF7ECLyLtnLtWfqVE/pALsruQXQPGATkTH9em?=
 =?us-ascii?Q?LWGjCQJMgQSeEXdGY03l3BhYDXvgtmPsLql246ranHO9+rHywvS+F1e0CJs0?=
 =?us-ascii?Q?igfaZs+znFCkxkWMXsHGH+dWVIPYupIY5JMBEhqiL/zvAN0j8zCP0iibPHpg?=
 =?us-ascii?Q?93piefxXM9lSZPiqCMFU2WGDy26m6Nhl2MqI7RyWjgg1pQyrh8KaZYOpkmOI?=
 =?us-ascii?Q?+xoaG+BCQNKNWX2Ie5yZ1e7CAqqg+19drQflITJM4xW1ELr6mwNfsPPkvUWP?=
 =?us-ascii?Q?P7an2udeAPjIJzWkQO4FS5oJY4e4HEDPwlta59TB0gnLdgWa5VCI20DJMqv/?=
 =?us-ascii?Q?POjkSSNwp1MOeWx2o0iXcR6tRPmMvGdjHHmkpcnZil5trurhL7cZBOLMcUnF?=
 =?us-ascii?Q?23GW0eolH8hcOUSGitYAd+nQXCRfJY2MBQsH+wZErJwVm/w61A3cStRecMtT?=
 =?us-ascii?Q?r2Lg7p+o45hG9+IkGV8W/6HnmlClDzhoXztEjA+l0GoJVqOJz2mWIRGw/eFq?=
 =?us-ascii?Q?lgrvVSZXoDgzgFd7qi8X9Z3JJRBCp2wN3T5QkVlOBULf+uaiEuQ+I2yYwF8q?=
 =?us-ascii?Q?IH6oSwVxQmaxTWjXCQ2Z1pWYZyKrxPe7IzUI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:09:41.0627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7beeb009-852c-4061-a2e8-08ddd8b6ce2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127

Previously, guest-memfd allocations followed local NUMA node id in absence
of process mempolicy, resulting in arbitrary memory allocation.
Moreover, mbind() couldn't be used  by the VMM as guest memory wasn't
mapped into userspace when allocation occurred.

Enable NUMA policy support by implementing vm_ops for guest-memfd mmap
operation. This allows the VMM to map the memory and use mbind() to set the
desired NUMA policy. The policy is stored in the inode structure via
kvm_gmem_inode_info, as memory policy is a property of the memory (struct
inode) itself. The policy is then retrieved via mpol_shared_policy_lookup()
and passed to filemap_grab_folio_mpol() to ensure that allocations follow
the specified memory policy.

This enables the VMM to control guest memory NUMA placement by calling
mbind() on the mapped memory regions, providing fine-grained control over
guest memory allocation across NUMA nodes.

The policy change only affect future allocations and does not migrate
existing memory. This matches mbind(2)'s default behavior which affects
only new allocations unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL
flags, which are not supported for guest_memfd as it is unmovable.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 67 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d9c23401e770..7821c1036e49 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,7 @@
 #include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/kvm_host.h>
+#include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 
@@ -18,6 +19,7 @@ struct kvm_gmem {
 };
 
 struct kvm_gmem_inode_info {
+	struct shared_policy policy;
 	struct inode vfs_inode;
 };
 
@@ -26,6 +28,9 @@ static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
 	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
 }
 
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
+						   pgoff_t index);
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
@@ -112,7 +117,25 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
 	/* TODO: Support huge pages. */
-	return filemap_grab_folio(inode->i_mapping, index);
+	struct mempolicy *policy;
+	struct folio *folio;
+
+	/*
+	 * Fast-path: See if folio is already present in mapping to avoid
+	 * policy_lookup.
+	 */
+	folio = __filemap_get_folio(inode->i_mapping, index,
+				    FGP_LOCK | FGP_ACCESSED, 0);
+	if (!IS_ERR(folio))
+		return folio;
+
+	policy = kvm_gmem_get_pgoff_policy(KVM_GMEM_I(inode), index);
+	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
+					 FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					 mapping_gfp_mask(inode->i_mapping), policy);
+	mpol_cond_put(policy);
+
+	return folio;
 }
 
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
@@ -372,8 +395,45 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	return ret;
 }
 
+#ifdef CONFIG_NUMA
+static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+
+	return mpol_set_shared_policy(&KVM_GMEM_I(inode)->policy, vma, mpol);
+}
+
+static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
+					     unsigned long addr, pgoff_t *pgoff)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+
+	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	return mpol_shared_policy_lookup(&KVM_GMEM_I(inode)->policy, *pgoff);
+}
+
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
+						   pgoff_t index)
+{
+	struct mempolicy *mpol;
+
+	mpol = mpol_shared_policy_lookup(&info->policy, index);
+	return mpol ? mpol : get_task_policy(current);
+}
+#else
+static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
+						   pgoff_t index)
+{
+	return NULL;
+}
+#endif /* CONFIG_NUMA */
+
 static const struct vm_operations_struct kvm_gmem_vm_ops = {
-	.fault = kvm_gmem_fault_user_mapping,
+	.fault		= kvm_gmem_fault_user_mapping,
+#ifdef CONFIG_NUMA
+	.get_policy	= kvm_gmem_get_policy,
+	.set_policy	= kvm_gmem_set_policy,
+#endif
 };
 
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
@@ -408,11 +468,14 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 	if (!info)
 		return NULL;
 
+	mpol_shared_policy_init(&info->policy, NULL);
+
 	return &info->vfs_inode;
 }
 
 static void kvm_gmem_destroy_inode(struct inode *inode)
 {
+	mpol_free_shared_policy(&KVM_GMEM_I(inode)->policy);
 }
 
 static void kvm_gmem_free_inode(struct inode *inode)
-- 
2.43.0


