Return-Path: <linux-fsdevel+bounces-54782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C50B03281
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF20E3BB880
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BFE288C2C;
	Sun, 13 Jul 2025 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a1PvBTnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC61285C98;
	Sun, 13 Jul 2025 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428985; cv=fail; b=mjUtTNoR5x1Kmg3lwFnBrycQuZHauYO0/yOcFBfmqVZu7sZDmaMx0reaDbNwmcyFII3jiCaGGGOMx/LBG1xzPaFVYN75O+vUFFmOzeAA0785v99aSpFyKHD6EWhnxus/DPnjG9fRnbrBVaaQNetD8ckO8v0XboOreirRPIAHnjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428985; c=relaxed/simple;
	bh=DFbOIpUIIdycsIHS6x0Qj9ca5JRubTDSJ97GR4+pFpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6tkFcut5qnkkPItAZl//XEYp3yQXH0QETlvkX4nd5zlBFMzbDKxSmye/Hu9ikGsL4Mb+opUhYntAYXEGLxqbSwG2aJuZNbxeNby8bZ0Z2qgpT60C+iS9py0A8BLG0YYNC/mcaPLO+PvoE378/LUW+P2EAR7saa/FBfXkjsLxS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a1PvBTnZ; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEPww0AqJOeROSBjdr2R04guHoKf0hYeXV4wnO1sLQUvANv9bLWN7PN2yXb4nmfgdRYpA7Twr7EAwOmplf/ETGXqkDx7foaO6XMrTtjIzgwwRfMqWPek8wJL2vkQlNQ+U0vLcrcbiXPXj1bpGcjs5h4tpof37T/q1Zjhs1oBcky5QXbQeqvu/nWGb9cIeduXpqR/ply//GwcrFX1e2VzIQb8Cj2td56rD8v/Se+o1V6Uc4x6J+NXGm8NtHQgdPGOSxL1dWsyNctvYRp2GXekiryDrljk/qLhUHAnEN7rcX4vRPaIoGT4AA6teBK1S50pCO+ifKxfw4tjqy1X+hSDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CVimU9xw3Fu7ChZR7ZXtFlrGo59bHwQQCmVDL+EEJ4=;
 b=gAHlziJk0drxQO1MHOO/krOkV9XDSxWplLOJo05OBqR7MXuM2v3mT7fxo9mVs+G2xBTrOCkuN7BZeymaXdvioLqLGgVWycfBXlpcVKS39OAk0VmGSRLyshKnOY82aGi3XK2M89GGH1rdWzQerZq+VrkYk9lX/aaHAmSl7GrSjoEiHHVZ2dN+MAWSjmPHssLlMFoyLoL/g2bbQuMwZJlGRICKRxsq2PnXU/9TICyrEtutU/g13GiXmc2WaTmfxN9bTSV/CQQlC/Jl36cA/jJRkUaW5Lb4PxboWMvv9X0qSPmKQ9fspZCBNK4Jhcr9FDVJiIyv4OdWsNScOcNjoaidWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CVimU9xw3Fu7ChZR7ZXtFlrGo59bHwQQCmVDL+EEJ4=;
 b=a1PvBTnZw53Bb+eBTUlLI1c56tcLWVgWVZhLJP1t16bC9Y5pzjCaYTIFHTriz+J4c3Qs8mHcRhcd8YlujkNa3rUw3yjbUxMVgW/EoJCj0zMHCCnbN5Q51IeXISbXogFyQKA0pHWFpYKePbwlAIBILV9z4WNXKIEjsEaIpX9osYM=
Received: from MW4PR04CA0263.namprd04.prod.outlook.com (2603:10b6:303:88::28)
 by IA1PR12MB9530.namprd12.prod.outlook.com (2603:10b6:208:593::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Sun, 13 Jul
 2025 17:49:37 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::27) by MW4PR04CA0263.outlook.office365.com
 (2603:10b6:303:88::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Sun,
 13 Jul 2025 17:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 17:49:36 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 12:49:21 -0500
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
Subject: [PATCH V9 7/7] KVM: guest_memfd: selftests: Add tests for mmap and NUMA policy support
Date: Sun, 13 Jul 2025 17:43:41 +0000
Message-ID: <20250713174339.13981-10-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|IA1PR12MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: f74b6b1e-5f13-4b59-180a-08ddc235a266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cRY4V6V2FPUV3nVZu67KVdOTUiLf/Ry/8MOehSZbjE/QdS7fFp2c8phq8Lu9?=
 =?us-ascii?Q?snaJlBjDqpvofG0pVnBSJxVa0zGzhfs31ehFN5xUIzrF+6dV5E9/H7dBKT8V?=
 =?us-ascii?Q?tGXeGeqx0GwH4U6x2vmSZXR/0EkW68jCv+Uni5fFonEboQiM3lOnRgY63dn5?=
 =?us-ascii?Q?IAiC2SI6GRPra9PB3OJjL3G25hInAqB2pJp8VfuvAXCTCriXVI5cnYhDXcIw?=
 =?us-ascii?Q?TOhtpiLjo+/H+xg4r50NAgvTq85X/AoX5F2TzJ+OpL6ktB+EU0Co9vBCVekq?=
 =?us-ascii?Q?lzs1uj5sOgaq7b9HyK8KWYN125CaUBUUQA003o1zx8wp6oujmG55Gu8259+6?=
 =?us-ascii?Q?v5KcolCtpi6OEXzRHVRLogk0noX9ecrcCFxFuweRjVixU7lJ4RodgUjoV+va?=
 =?us-ascii?Q?tsKooK01kn61D712zlIKqLdlI3VW9wN8fgfIUmR+PgbzKAfYgTEscWkG9q7e?=
 =?us-ascii?Q?+Vk5f5FGBv4pCnU4oZZTCPiScLZ8R2jh2bGckBobXZlWbGH1qEc1ts3A+4m8?=
 =?us-ascii?Q?DrktFavF00wQ/8AlBPfI3nPLvhSYtMzvn5+eR8EQqSWm6W0MrW5myZpUvxQ8?=
 =?us-ascii?Q?JQ8Xme4a4rIzUXl5ZOVCFxWwaiv7AhSmMOjwFa27JgtwEyvM8tGIM2v5GiER?=
 =?us-ascii?Q?h9FgTkYIsX8f+R7BoWdLBcfnDpc2MxLxt0MmTIzg6hxn1mnG0ZmH25JQSZjh?=
 =?us-ascii?Q?uFBWVjfrjiB1vUoAbE3U3NfJ6HHKeAScLx1g7Oqw6IyDKzz5nFTK6zbfT3fA?=
 =?us-ascii?Q?m/P/iDIekcnYd2wh4MkcHmxuaHpV/QbiPwBk91luFdUG4xacd9uYVZIFpuYR?=
 =?us-ascii?Q?/nd+O9GCjgstEnHFt1zTx8V4j2Mpb1J5BtTcScbRyBeQy2lOzZyi2s+CaWTi?=
 =?us-ascii?Q?bWJ45rpC7pdBbYcxxwa0gZILrV7gvKNzX5PLHOPzc2+rFr6d+f7qKQzCdnnC?=
 =?us-ascii?Q?jdIiGh3OhVvB7opLY7trzRod5iiC3eJPAUgcSeACNq6K5lFxarPPFlwX3pwa?=
 =?us-ascii?Q?9bdzs19qkWU6+Nk2y1E/W6AA/7InmmDYNKGgUDl7LhKZd0qUKXdZG2hnI0fd?=
 =?us-ascii?Q?NDxiGcz91qcENqsxk53hhgV7tUlZ0OUv9Y40yrwqsHVKx/tvDtTkTCIeiP35?=
 =?us-ascii?Q?jqnV07NgJAENh1OzhaVmc/1kYPZoePhOKib6UY8upV18t/9SgWd8y2z7gg1V?=
 =?us-ascii?Q?yIUW27O8kfKGmdRSf48Rp7YFQ2Pd6JAeiKsYs7muSibO2BfMwig9gadjAUJG?=
 =?us-ascii?Q?aGnYfn5CtWuLC4GoFM10Z5FsEcuqKk+brmrPlkOaTpDgB2VKg2JCk/1r5KGQ?=
 =?us-ascii?Q?vKZ8vDISwwdPOpl8sUoBBAnuNr2dREjehiYnXxqdBsLgv1Rz2SLd3WILNOrY?=
 =?us-ascii?Q?/qqkKn+gD3oKse4w2bk9oVyEE7N7HlicpSjTxRH0/hWWYXNflioFYw8gWtMw?=
 =?us-ascii?Q?7B1bPFC4XivBdarJEo0kdWoQ/Nkc6eXpPjIRfy4TInbfyJ15xVa/Z6AmV0TA?=
 =?us-ascii?Q?ci2kl2Cb1VEVYLq2XUBsNS3U5bFtswfgd/XD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 17:49:36.7972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f74b6b1e-5f13-4b59-180a-08ddc235a266
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9530

Add tests for NUMA memory policy binding and NUMA aware allocation in
guest_memfd. This extends the existing selftests by adding proper
validation for:
- KVM GMEM set_policy and get_policy() vm_ops functionality using
  mbind() and get_mempolicy()
- NUMA policy application before and after memory allocation

These tests help ensure NUMA support for guest_memfd works correctly.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/guest_memfd_test.c  | 122 +++++++++++++++++-
 2 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index e11ed9e59ab5..f4bb02231d6a 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -273,6 +273,7 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
 	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
 
 LDLIBS += -ldl
+LDLIBS += -lnuma
 LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 
 LIBKVM_C := $(filter %.c,$(LIBKVM))
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 1252e74fbb8f..d8f3beccd5a0 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -7,6 +7,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <numa.h>
+#include <numaif.h>
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
@@ -18,6 +20,7 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 
 #include "kvm_util.h"
 #include "test_util.h"
@@ -115,6 +118,122 @@ static void test_mmap_not_supported(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT_EQ(mem, MAP_FAILED);
 }
 
+#define TEST_REQUIRE_NUMA_MULTIPLE_NODES()	\
+	TEST_REQUIRE(numa_available() != -1 && numa_max_node() >= 1)
+
+static void test_mbind(int fd, size_t page_size, size_t total_size)
+{
+	unsigned long nodemask = 1; /* nid: 0 */
+	unsigned long maxnode = 8;
+	unsigned long get_nodemask;
+	int get_policy;
+	char *mem;
+	int ret;
+
+	TEST_REQUIRE_NUMA_MULTIPLE_NODES();
+
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap for mbind test should succeed");
+
+	/* Test MPOL_INTERLEAVE policy */
+	ret = syscall(__NR_mbind, mem, page_size * 2, MPOL_INTERLEAVE,
+		      &nodemask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind with INTERLEAVE to node 0 should succeed");
+	ret = syscall(__NR_get_mempolicy, &get_policy, &get_nodemask,
+		      maxnode, mem, MPOL_F_ADDR);
+	TEST_ASSERT(!ret && get_policy == MPOL_INTERLEAVE && get_nodemask == nodemask,
+		    "Policy should be MPOL_INTERLEAVE and nodes match");
+
+	/* Test basic MPOL_BIND policy */
+	ret = syscall(__NR_mbind, mem + page_size * 2, page_size * 2, MPOL_BIND,
+		      &nodemask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind with MPOL_BIND to node 0 should succeed");
+	ret = syscall(__NR_get_mempolicy, &get_policy, &get_nodemask,
+		      maxnode, mem + page_size * 2, MPOL_F_ADDR);
+	TEST_ASSERT(!ret && get_policy == MPOL_BIND && get_nodemask == nodemask,
+		    "Policy should be MPOL_BIND and nodes match");
+
+	/* Test MPOL_DEFAULT policy */
+	ret = syscall(__NR_mbind, mem, total_size, MPOL_DEFAULT, NULL, 0, 0);
+	TEST_ASSERT(!ret, "mbind with MPOL_DEFAULT should succeed");
+	ret = syscall(__NR_get_mempolicy, &get_policy, &get_nodemask,
+		      maxnode, mem, MPOL_F_ADDR);
+	TEST_ASSERT(!ret && get_policy == MPOL_DEFAULT && get_nodemask == 0,
+		    "Policy should be MPOL_DEFAULT and nodes zero");
+
+	/* Test with invalid policy */
+	ret = syscall(__NR_mbind, mem, page_size, 999, &nodemask, maxnode, 0);
+	TEST_ASSERT(ret == -1 && errno == EINVAL,
+		    "mbind with invalid policy should fail with EINVAL");
+
+	TEST_ASSERT(munmap(mem, total_size) == 0, "munmap should succeed");
+}
+
+static void test_numa_allocation(int fd, size_t page_size, size_t total_size)
+{
+	unsigned long node0_mask = 1;  /* Node 0 */
+	unsigned long node1_mask = 2;  /* Node 1 */
+	unsigned long maxnode = 8;
+	void *pages[4];
+	int status[4];
+	char *mem;
+	int ret, i;
+
+	TEST_REQUIRE_NUMA_MULTIPLE_NODES();
+
+	/* Clean slate: deallocate all file space, if any */
+	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, total_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap should succeed");
+
+	for (i = 0; i < 4; i++)
+		pages[i] = (char *)mem + page_size * i;
+
+	/* Set NUMA policy after allocation */
+	memset(mem, 0xaa, page_size);
+	ret = syscall(__NR_mbind, pages[0], page_size, MPOL_BIND, &node0_mask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind after allocation page 0 to node 0 should succeed");
+	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	/* Set NUMA policy before allocation */
+	ret = syscall(__NR_mbind, pages[0], page_size * 2, MPOL_BIND, &node1_mask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind page 0, 1 to node 1 should succeed");
+	ret = syscall(__NR_mbind, pages[2], page_size * 2, MPOL_BIND, &node0_mask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind page 2, 3 to node 0 should succeed");
+	memset(mem, 0xaa, total_size);
+
+	/* Validate if pages are allocated on specified NUMA nodes */
+	ret = syscall(__NR_move_pages, 0, 4, pages, NULL, status, 0);
+	TEST_ASSERT(ret >= 0, "move_pages should succeed for status check");
+	TEST_ASSERT(status[0] == 1, "Page 0 should be allocated on node 1");
+	TEST_ASSERT(status[1] == 1, "Page 1 should be allocated on node 1");
+	TEST_ASSERT(status[2] == 0, "Page 2 should be allocated on node 0");
+	TEST_ASSERT(status[3] == 0, "Page 3 should be allocated on node 0");
+
+	/* Punch hole for all pages */
+	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, total_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	/* Change NUMA policy nodes and reallocate */
+	ret = syscall(__NR_mbind, pages[0], page_size * 2, MPOL_BIND, &node0_mask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind page 0, 1 to node 0 should succeed");
+	ret = syscall(__NR_mbind, pages[2], page_size * 2, MPOL_BIND, &node1_mask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind page 2, 3 to node 1 should succeed");
+	memset(mem, 0xaa, total_size);
+
+	ret = syscall(__NR_move_pages, 0, 4, pages, NULL, status, 0);
+	TEST_ASSERT(ret >= 0, "move_pages should succeed after reallocation");
+	TEST_ASSERT(status[0] == 0, "Page 0 should be allocated on node 0");
+	TEST_ASSERT(status[1] == 0, "Page 1 should be allocated on node 0");
+	TEST_ASSERT(status[2] == 1, "Page 2 should be allocated on node 1");
+	TEST_ASSERT(status[3] == 1, "Page 3 should be allocated on node 1");
+
+	TEST_ASSERT(munmap(mem, total_size) == 0, "munmap should succeed");
+}
+
 static void test_file_size(int fd, size_t page_size, size_t total_size)
 {
 	struct stat sb;
@@ -275,7 +394,8 @@ static void test_with_type(unsigned long vm_type, uint64_t guest_memfd_flags,
 	if (expect_mmap_allowed) {
 		test_mmap_supported(fd, page_size, total_size);
 		test_fault_overflow(fd, page_size, total_size);
-
+		test_mbind(fd, page_size, total_size);
+		test_numa_allocation(fd, page_size, total_size);
 	} else {
 		test_mmap_not_supported(fd, page_size, total_size);
 	}
-- 
2.43.0


