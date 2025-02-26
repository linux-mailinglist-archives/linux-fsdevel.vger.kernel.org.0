Return-Path: <linux-fsdevel+bounces-42645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A23A45825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFC13A9CEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265A23815C;
	Wed, 26 Feb 2025 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VredHeHb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CE202C27;
	Wed, 26 Feb 2025 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558493; cv=fail; b=DNXbrsgZNkbUfrwJuF6wgfVMGasV7P+/cltDR0LXSazD0GTWYWbBmkuj/K6ckW4yGmMqMIXG/HVRvWlgbwUcFQ0dfhm+gm37FwAjHeuhCbe7ar9elql6URBDq+ZWmSU6mvn3ul9K1EP1JQGApQIOLsAON/VPzooNtKA7B2VcQnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558493; c=relaxed/simple;
	bh=7PavWSs1Hl2wx0ugPxGR47C7SmvCzimsUwTFdPvSIJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6eLMB/cJGktKjw9Rtnqd+49uLgpmWbX7kxdC4afr+6gEhwCh1zP/7FyXIgssGlg+CG42taTQ2ttf3VUsSx8sKW2Sz+rfPnAexVE6ZzJ8CzG4IhD0w80wqeAUkdop9jTtR/2oCGjc0Bv+RQ2HfS9ExjDjhFyR6WPN7AH8iJFmqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VredHeHb; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxCP4xfOQJQIHRqEhF48vYo1cnOuk4ZHNbz1sjd9oyiavUd78k0VhkSCN7bJ6i1Fv7zQMDkG+aUKMvthi9y6zc5JsAfngClhr3UOqeciHy7a4hToXrBLYJWVkq96EQV5PuU+1HCWsRbasHGsLtC0nutVrchreDZyf+GPMCzX0diaXKhCM5Jr1BEJdLuAD3jkP8wPj7NF4OPkVn6MJj5FB4Dh42BnZ+h5E1GTQ2+lKIAr5HsvHVpOovoosOpJq5wY9UfbEp+2+FrdIP3jzGhHO5i/5qpUc1sCQcFS6mFYe/sl7/Q5XAQKq2rnG3DJCHBR22TiygJmMi7eF6bqEuiYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6St1b1o4opRrG5+XbMZz9/UVH3Qaez2X854bSxUmZdg=;
 b=gWN/1A35Ey/HG/k2TX1T+68nINdaOb9Cd3whh46qjii390WiADYwsfQge2IDzGElG15VquP1CJ69Oqm8artKIamVYe0rqv20zDXy+mtsS8Yeywwv2/6uW70ruvz6XfWQR0G74xWu1fVP9QiK+r3/52EQU1oy7HnrWd8QgtMr6g5UbHWaYgkVc0jiFo8iTNFkbSgLUXG5p1qqAcIQlvjA4gKkouOjBAnfOgpP4ODazl9mFAT1sS68hPNMNihdTmErbdTBn5H5qD2KcOMkioYTgFiBs+/eRRXAgbIj5xz1E3AVaEDr0sXUxKoOhaZXHYQqvXm6cXp3EiPwPxT5r1vK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6St1b1o4opRrG5+XbMZz9/UVH3Qaez2X854bSxUmZdg=;
 b=VredHeHbIBtGfPReY7DACMyYfY8bX0xZ5S7MpGcfs45SQxM0LLv3TJDRPrq1ohlIY/LceJ+EGI8Hd2+yjiTa0ka65VQ7DOuC6IIYjvEnIid3Bj8N700isLZaJzg8KO9peSNrNEXrDHWzHpdHP9oPKvGAekHCRUndMggjwEarrLY=
Received: from SJ0PR03CA0203.namprd03.prod.outlook.com (2603:10b6:a03:2ef::28)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 08:28:09 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::b6) by SJ0PR03CA0203.outlook.office365.com
 (2603:10b6:a03:2ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 08:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:28:09 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 02:28:03 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>, <tabba@google.com>
Subject: [PATCH v6 5/5] KVM: guest_memfd: selftests: add tests for mmap and NUMA policy support
Date: Wed, 26 Feb 2025 08:25:49 +0000
Message-ID: <20250226082549.6034-6-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226082549.6034-1-shivankg@amd.com>
References: <20250226082549.6034-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a7f0b1-5924-4e3c-63cb-08dd563f807d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5zQan82jIdSJSDC+JD4CjI0VBR61V8Vqc3jXlcV4MiCx9wdNjTAyYQRHJyQl?=
 =?us-ascii?Q?ab4DcX8lVhgRwBmrA2I6FNBXRqtjnhO5YFxXn2gyT9qqT52bQceq4KT0llR1?=
 =?us-ascii?Q?JjuC1zuf7CZaHrUe6viBiMlfKwkeWRo0qFQASo6kR1x1xkJQyYpTIJgMAq9B?=
 =?us-ascii?Q?KBGV/5VEOU91rmco+4+jHC4JHrYTmbw2uakMW6OoKBNFm1xL+95W1Cm6osDh?=
 =?us-ascii?Q?HaU85GeLRJ0KAYxPelW7akJjtUCf0A/NLdc8rkxH81d/Ym5RjToXoW8l3zJB?=
 =?us-ascii?Q?QOYJiAhuvI4dDG2R5kW3VPefZxZwEZCZ2YmNQqCqzkLLpASIp1g/TcvPQZW6?=
 =?us-ascii?Q?rwP++4yKMEbjN/h3iji8gw99Kft1G7273Sn/NNVjdS8Pva3+ORXMUV8MBmcZ?=
 =?us-ascii?Q?QaLFbrJ3KBdosct6aVKAH/XT+GYh5LPQEZQ0i/VxrXZvC3lO6uDNua3+2J7Q?=
 =?us-ascii?Q?YjoKCMOSjMzgkfmoheOeJiG6BMGE5M3ge7gGTphpMdkxL3CulZJtYQgpbxgC?=
 =?us-ascii?Q?tm4IDn8Phnx/iEW7OiQjL3ZsoQzp5XmQw2MQbP/IUMinmqr4tzZduhoPEXb2?=
 =?us-ascii?Q?nNxHeLO83c0iS8e7/fFkP1dAF7yFWBUunvjPqrVOEP4mhlXvRpSsyvj0HV1R?=
 =?us-ascii?Q?UFOk7lz/UnrFPAhLD9+6FW8/vTbNVx1lCo2pfOO+CcjEV3MlH2e1a687sHx5?=
 =?us-ascii?Q?95ka/MvBg5nIdmF4srUbljBtnY5oReuaw948rFzOuV/yNjWOPj8JpIx9MuWk?=
 =?us-ascii?Q?/4EhefLRuYKfG92/jE7xel8DlGAj+RuEy+D/c+N23RdMJEPL64t1m6UQP5th?=
 =?us-ascii?Q?BuPn22ijRmhwBAwiQgx3YypCWfty2kLSEqv7lVUe8xoqWex+0w7n1xgAcWTA?=
 =?us-ascii?Q?0UlTgUENRiuo4niXsiZKeEMBtKOXrThOynWwxoyqLVWU/gSwY7SmXJfJhH/p?=
 =?us-ascii?Q?0oJvDbsYc2tYZzblIfOvxdZZDmDVCkZQHH6hOeMcuVaS6UNDUC5m4bP3V9WK?=
 =?us-ascii?Q?uNfx6mFcEL3GrmZARL8GuF5tzUuPPAIvbRf1GvvvtOtnh2ySr1sGAi/SYJno?=
 =?us-ascii?Q?tzOIpnCynqf5jukbJNFe5HAMsDCU5/V9K2lgx9mNTqgfhyOrxHPpqCSe03MJ?=
 =?us-ascii?Q?HKwoVJIaYq91uL3u6Jy5IXJZvZyd/p6cHIc0ZL7EzeUDaXat9r5Oa7mworpJ?=
 =?us-ascii?Q?3V+abmh6+y2QVU5cjOZXShU1M8ojodmAFIRRsk2hPyX821BKjf/99arPd4mW?=
 =?us-ascii?Q?LxHDQ55dGEf9nSXAu+/2YmIlsh++qrQAXXos5zIPXzr1sQU3id+hlEOuDGhC?=
 =?us-ascii?Q?YJcnRMl1EzdxClTdwtPALHA1Flzoh4hOJDRt0j1CKh7F7DRYJWHIpUgabV1d?=
 =?us-ascii?Q?/GZxZmgiB+G5khi3QVAgITXBqHLRxU2k3jaFdfoKyDC4hfsAQCCp3sPkJFE2?=
 =?us-ascii?Q?3t5T3HV+B+8wpnpVcfibcMkB6BnU6Hn/KbJXsaFxP6OBIqIfwIlbTig0HPT7?=
 =?us-ascii?Q?/JkqpRMSfeAF44w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:28:09.3545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a7f0b1-5924-4e3c-63cb-08dd563f807d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

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
index ce687f8d248f..b9c845cc41e0 100644
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


