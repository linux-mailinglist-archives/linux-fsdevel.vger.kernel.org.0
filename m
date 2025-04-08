Return-Path: <linux-fsdevel+bounces-45975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABFCA800C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D168806F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639A26B2C5;
	Tue,  8 Apr 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1nGzQi0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07783269830;
	Tue,  8 Apr 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111550; cv=fail; b=g+woaMcE7tcfpxAHniUOdXhCd0fZeIUMz+LgcYwCcuL2TICp6iWfRf5VhQ2QVuxUkJZI+DXGeRDOAw/QSyzRzYbqgqksH7du/VV4YpuG9JKdRZscFaRMIcL1fjLhL57Tlip9GYfhLTjZlu0ONH6TsBU349X92mBqtC02NpNA5EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111550; c=relaxed/simple;
	bh=Kz+P/RTCAV+IHH6jfCxgAC+39TqHYY/n/RIXpSndehc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgPDz2kA49x/ziv1g0HjFB7d6n6AdMJrxVMRtQh2v96uRFP6SX6khVX5XSq8ScRQWnlRqNjieyJHEgh3l8+6osUL95gISpUdrdiHxz5o1Kj5EFPA2yx9/smZvA9Wfej/oxv+h6OPJJ3tam1LdvQKs2hypyhDCp5zBFzetle3mYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1nGzQi0K; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UArTsph1PsEiFHUjDMC9vtoI7cOmg7RE7d+VPhwzuKHOf4FLoyj6Ajjc9tAWkub2QUJZIQst4P5h6HryZDEDY+qzWDDtRPQ9zftnZUwd9kMxVnDIeUxBP/+D+Oc4kvD6GuhZcNptZKcjBl3ZtyszI1/KeAGcptemx/s/RGlC4QC0BFNiW+bEJ6ujtFCrnRu1P6FC/bkJ5MZzgSOo6+yKEaLFgp8yoWhhohVmfTzx4qp2E5NG7dMLBc8VDPOFlPWls03YUpFZhcykHnYa/PCpARpFgjIx3ioHoT9jVdtVoBJXQZdA8l858MwMJ8A11KEGY6hhGVtyK+V/wZKIi34lCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqM4P2Fn56kQQ99zKTO6kLMZqx/0D3d8nce8i2TLu+8=;
 b=FZlSdZWkdj60FrCNW16FUIwSZMhgpz7NPQVGliQTw8HSWz5FSQKu8HlKlWBniACMMiyZjXsDD61GlM8lizYPhvdYtxaodk12pMp8qLxlpbb71eRGOGIAsIh82Bs1oVtjJdZ4PwpddTm6f22yfsvc0PH/cKmw2v+WqLNuFLN8SdSWWG5PEMGtT/qG3ecP3aTs5L//PdNI+x2gWm5xun5rn5R1teqInz/G+YXa/x4kxnOxvWOwk42VxnR0+lr4HvHpLsJuGKaP7PXS9Wj1V0JQfXXvJH4hAnsqEcqlmlhl22fJb+qJyph0iXG+30sKG+rlGlJol/TCjAhzs8Ao6zG9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqM4P2Fn56kQQ99zKTO6kLMZqx/0D3d8nce8i2TLu+8=;
 b=1nGzQi0KAXZsNOf9UuQTsndpC1vMq4naevXca07Ba1jUe/tffoGAu2P6UkekJB1Bsv79c9nfSt35ok7d0dhjo5xsDHYFCxBq0FPHkf/+2z2c2RCLklNIsTFL5FInE9+8Wjw0yA8Nf0dbwF6XiByEs2qVAzUUBopE1N9aPWNVUlE=
Received: from PH7PR17CA0007.namprd17.prod.outlook.com (2603:10b6:510:324::18)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Tue, 8 Apr
 2025 11:25:44 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::4d) by PH7PR17CA0007.outlook.office365.com
 (2603:10b6:510:324::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Tue,
 8 Apr 2025 11:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 11:25:44 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 06:25:35 -0500
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
Subject: [PATCH RFC v7 8/8] KVM: guest_memfd: selftests: Add tests for mmap and NUMA policy support
Date: Tue, 8 Apr 2025 11:24:02 +0000
Message-ID: <20250408112402.181574-9-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 90159200-b307-4202-552b-08dd76901a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?44SCRYxL9gRlx7xh3pkZTbvLTebxamSVUDncf6nm0aytM2Ntvrtb9373TGIR?=
 =?us-ascii?Q?evym4zNAuN19Sdkh/xTgZVREV2uXobK2nu62HUWmtkwg7/brbsjztqz7mvdn?=
 =?us-ascii?Q?T1obQdETrpbAtbG/j1m8wKtOO4EhCY8Uitz+vQIKrDPuBbEmKTx5ZqzqOvEy?=
 =?us-ascii?Q?0YRetvAzqcEMDGxUFFyygOsfl6EI/nUNgEUzLxQipWQVmuRwq6OQXgmgwpOx?=
 =?us-ascii?Q?Qupqi4GlAdnLVEAJtw9D7lSQGLHgZ8D/GbGqcHPujcbNdCJ0uFWDmpg4FbIW?=
 =?us-ascii?Q?Ss+K/ETYJEN8vGiuUcJRb8xVt/qKYDLBgEo+GFiirmOXyLLf2fJ14z54DGPG?=
 =?us-ascii?Q?DjLiafsaBkk6tL8VKcMBbjAjBxvydzIYVF1wwT5rarb3Hs6s7p26ZqLZUhYf?=
 =?us-ascii?Q?ci+7A0e26oNwNVKwd/L0u2U4qy728yPi3gJrpRfw2e/BiC3K9S219DGlelkD?=
 =?us-ascii?Q?8cKttBAx+t1dKi1UG4dwIsIo7q6UEH5LAdBH3IOQ8Y12mtiuLaW7pUXwuCbk?=
 =?us-ascii?Q?i3A2b4qqhVH6+ytcdrzI0X9zRYDjvvxEw0uTFIRl/QOOr/z0xixNqZq5/ZUA?=
 =?us-ascii?Q?XDvzTSRDMdcitqCkGr8Y31FVS7+9quQvkDRoGIrneMjKyRpchcFrRnH1h2Nm?=
 =?us-ascii?Q?JnJ9x6bgyHAY06akg79XnikyWPAyEM1m+HMvPLArFeSLW4oYbVqq8fFXr5qR?=
 =?us-ascii?Q?dkWorSaqNdktpBcJagqjEewQ1SwE4uoHMuLZGie28v0rCdlV9QSLfTs1O9Kw?=
 =?us-ascii?Q?vKoW+5UdA1ACrA0zAuDCDlZqt8T7YR2x53OzP7Sm00qlS120hDv1IuLKK6jE?=
 =?us-ascii?Q?HWr4owKO2yGvZfOIEBqlEaznlxCGyQspzL2HvMLKMdaG3tV8gROndOYX/cxB?=
 =?us-ascii?Q?zcoKGIsbF7/0JybQcOWkLF2jBXcgiWdcGV4vzgZHLsPt40WQq7VCo/YpBdK7?=
 =?us-ascii?Q?vF3xBmdRsaJzQJG6yk+aVTWMTQRLwfBo0bKmZsir5jwi0/6EwaAdyXO7iHRg?=
 =?us-ascii?Q?kAbj9gMjwsUubW3kQRXPJ92UYyyCy0IkXRO5OtOeDtPKSROsdFO5xnVPemBO?=
 =?us-ascii?Q?NesYMlrd8JfLmJclFTM+6X6mvJFrAf6nw7TH/uEMVPTkKffsx8KtRLFlz8wH?=
 =?us-ascii?Q?FBeObNT8QLHbOAoMAlDQ/FKZjXw2erYQMqtgMEmN8V+4aSIaya/Ic/1HQjJa?=
 =?us-ascii?Q?NLiNB4kNz55d0BmBaSvzrGotOV6KVuVQ7Ur4clYWRNa7d4kwj4JXcInPBW/q?=
 =?us-ascii?Q?EliASzr8cvtgJJf7lirmidI59gqpC1NNOE6RExt+2cd+klvmOXqLoSJYvV+Z?=
 =?us-ascii?Q?T2aCVozE/49iGLxrIVnhRGl4EVNURPA5PuwSFIhCmlJbMP3OVCKNaZRY2yPb?=
 =?us-ascii?Q?AkPrCMe2wmegTNsTD3DdjVMsRKpME4YBBGN/YYFlzVH2lwlRR8q+RPSFwIlw?=
 =?us-ascii?Q?/fEBtBbijrAWodolq8P5cq9g9IwLp1VSfo8iGbpa24tN528BEMpQeDPCXHr3?=
 =?us-ascii?Q?GHSpLVmypScd4Z1yW7usowTxzZwqshLHyOFg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:25:44.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90159200-b307-4202-552b-08dd76901a12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220

Add tests for memory mapping and NUMA memory policy binding in
guest_memfd. This extends the existing selftests by adding proper
validation for:
- Basic mmap() functionality
- KVM GMEM set_policy and get_policy() vm_ops functionality using
  mbind() and get_mempolicy()
- NUMA policy application before and after memory allocation

These tests help ensure NUMA support for guest_memfd works correctly.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 86 ++++++++++++++++++-
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ce687f8d248f..2af6d0d8f091 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -13,9 +13,11 @@
 
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
+#include <linux/mempolicy.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 
 #include "kvm_util.h"
 #include "test_util.h"
@@ -34,12 +36,86 @@ static void test_file_read_write(int fd)
 		    "pwrite on a guest_mem fd should fail");
 }
 
-static void test_mmap(int fd, size_t page_size)
+static void test_mmap(int fd, size_t page_size, size_t total_size)
 {
 	char *mem;
 
-	mem = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	TEST_ASSERT_EQ(mem, MAP_FAILED);
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap should succeed");
+	TEST_ASSERT(munmap(mem, total_size) == 0, "munmap should succeed");
+}
+
+static void test_mbind(int fd, size_t page_size, size_t total_size)
+{
+	unsigned long nodemask = 1; /* nid: 0 */
+	unsigned long maxnode = 8;
+	unsigned long get_nodemask;
+	int get_policy;
+	void *mem;
+	int ret;
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
+	unsigned long nodemask = 1;  /* Node 0 */
+	unsigned long maxnode = 8;
+	void *mem;
+	int ret;
+
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap should succeed");
+
+	/* Set NUMA policy after allocation */
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, page_size * 2);
+	TEST_ASSERT(!ret, "fallocate with aligned offset and size should succeed");
+	ret = syscall(__NR_mbind, mem, page_size * 2, MPOL_BIND, &nodemask,
+		      maxnode, 0);
+	TEST_ASSERT(!ret, "mbind should succeed");
+
+	/* Set NUMA policy before allocation */
+	ret = syscall(__NR_mbind, mem + page_size * 2, page_size, MPOL_BIND,
+		      &nodemask, maxnode, 0);
+	TEST_ASSERT(!ret, "mbind should succeed");
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, page_size * 2, page_size * 2);
+	TEST_ASSERT(!ret, "fallocate with aligned offset and size should succeed");
+
+	TEST_ASSERT(munmap(mem, total_size) == 0, "munmap should succeed");
 }
 
 static void test_file_size(int fd, size_t page_size, size_t total_size)
@@ -190,7 +266,9 @@ int main(int argc, char *argv[])
 	fd = vm_create_guest_memfd(vm, total_size, 0);
 
 	test_file_read_write(fd);
-	test_mmap(fd, page_size);
+	test_mmap(fd, page_size, total_size);
+	test_mbind(fd, page_size, total_size);
+	test_numa_allocation(fd, page_size, total_size);
 	test_file_size(fd, page_size, total_size);
 	test_fallocate(fd, page_size, total_size);
 	test_invalid_punch_hole(fd, page_size, total_size);
-- 
2.34.1


