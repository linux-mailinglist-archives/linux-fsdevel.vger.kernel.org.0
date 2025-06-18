Return-Path: <linux-fsdevel+bounces-52039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E60ADEA43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1955189E142
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635952DFF37;
	Wed, 18 Jun 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s9zHZS3E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9829DB7E;
	Wed, 18 Jun 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246326; cv=fail; b=ggokvOVychTgmH1hLnQ7v4hkSLoOY1Wv2VnusuDr3NssKSnhLGaUyGLn96JGDKoKoV+gIO75vZkBHog4UtrVp2pvcWX4W/F12JOUS50PM8DlTJcEiA3Fs6uus35U1rMIq8yb8jFZyyJlgerok9PpXhvXml/G0w6aaUFzv3fI/ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246326; c=relaxed/simple;
	bh=rGKaxhopsjzg5whXYJ5oOo5z8yaqW79j4exy6KFRsqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzIHrT7qIopam3z6nxY/5ciOu8qR8CAZKVDcfcVgfVUktc2hks5bIKaOzmlUwIBrFuBb+pzc2XSNuG7Cl6gejb98yCq2LuaZBkjeYxqkS20h1/c0tMY4N+Pmt4GgP3hmJjyMv7G+DiRpkq6GJPV3BvZsG4HFJRQ/PSaV66lApkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s9zHZS3E; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhTqyd6O6mVVdrpQDx7BCnOHGgRc5iAuwBTgh8Ow/UxldOwbKnWxXUYGcDbTa7rxM9DWd09WND7ZFNYmykJxCzHgwvRlJoM9Rvrt0P6QWYCxVDAKOE5Wcc+ziilbwGaR4NZg46uMrgbfBmaHNyaXpoaPFm70ayfKUvztVYZlJoydp/U15LhiDHQok0UHwnuYgYUqQmGHSyfuduqyAAbo01AbILM+YO0uwZpFZE3bvwxPIup6Rz8/LaYBfkW4y8EAbnKnp+x27x6B4kQM+9av/XfrqW3uRXO5eBqFVG87QixvE0t2olVPWp8i3NM04sjeFNjPjUS7x56JaNr9bpFhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFphcHKUBvSNXcUaDA1E9dP98Pnht5uF+GigLhSttx4=;
 b=K92VyFzpfbi1Uf8zvZyVLqKyQZ+GrL8lmbf1H3nrgYjNR16a9cp48Dmu/UFvGQ69gMv9RIw+3LARgHqq0nMrsc1w5YVyNmzatK6kGqATxvqavJOg+QpPhmst3NmUwlzM8wQNlEn6WvsecDPbz94SKpPxSXnK/A3U5OEnveeDObTM+rocgxlHQRyrNj47y1nIXonK1DhzqlQFRH0u3JTATOgdUA1F9hF5NuuHAmOnJXB2Bt5gWCTjU65hmhsKeQJ3kC3SxJuvRyl8eqZUXw8A/NtnYqk7FmfBTNJqRNLGHjzkypdCovbYW1g4TgZUEwKmNDyBEcKqS+nbBShtKikF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFphcHKUBvSNXcUaDA1E9dP98Pnht5uF+GigLhSttx4=;
 b=s9zHZS3EdmLSeXHmJa/OzgL4XCgs+PEcjwJp0qrejImlLgjB88iqNtbzGH/VC4YN/oqVcEAweseKLbUETV8SVsjthJB96x60ZO/qSkUWX3h7QBcNKXFEs8ht1rnrTa4MvpUiaIIsBMvFb43zCVlyC3sYy/taxYq+r/Gnq63YRKc=
Received: from SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 11:31:57 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::4b) by SA0PR11CA0210.outlook.office365.com
 (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Wed,
 18 Jun 2025 11:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 11:31:56 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 06:31:41 -0500
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
Subject: [RFC PATCH v8 7/7] KVM: guest_memfd: selftests: Add tests for mmap and NUMA policy support
Date: Wed, 18 Jun 2025 11:29:35 +0000
Message-ID: <20250618112935.7629-8-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: a16d9d3e-3295-40bd-d31f-08ddae5bbb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zb7WaMFy/okY21uLXk+a/PSRd5y7EzGj9x2GFNGa/q9nLiz8tu4RE/PPI/A4?=
 =?us-ascii?Q?gcoth7mWMeIQgf9cfRkckkDH+XGUSTD04YPKtN602oO234NSF5xnsZfzKemU?=
 =?us-ascii?Q?gSklGKhaFTtnZxRh9WWHdVnAO794MDU3SiDLbc9HEQywhLmq3kbAKpmBReyK?=
 =?us-ascii?Q?xtbtgXSOvGSu7CTou4fFSWi3YsG7OKiIDIbw7MuyUTWP/z8AQqjY93TJG+z3?=
 =?us-ascii?Q?nuoZ2kG6JJmH1ewkGUhjVf+6yX1YfzfW/djS23MkADZqyvDb7LHdNQlnCjMv?=
 =?us-ascii?Q?ivL5Z9eYeWkzQO+CX9Bxa/WEQ2LSeNgQTHVdMAjhjR+zew9bbY/2cd5+VfYx?=
 =?us-ascii?Q?yUopCD69Ml3n8ZyDO7J1UwnKkrNVyweQYQVRd+rVOzJGJv+NBFjAyGAc0Brw?=
 =?us-ascii?Q?qSWzODwZZaplgKMi3KBNn9qWhX0/Tw62JzpZjr2L+bwN1u3pHseh3AUg4bRF?=
 =?us-ascii?Q?48jZ6kpJBwCDzNWO3Y+JFGDE3zCQJp5J4p11A4Mt50+F85MGC1xq03Sezvol?=
 =?us-ascii?Q?RXfzYNBR53eA3ZzZTmcE7FUyAV3RyAHwnr/EswJEzYSP8V5n7oX30PvWnYkZ?=
 =?us-ascii?Q?Ws2f4WZioBF6J5hykf9L+HwkDnKI0QmJGMCZYNBjnb8ih4k3SPy4V/8Vg15I?=
 =?us-ascii?Q?WM4JwwclrAZbfFl4xBUODGe75+hmhfKJqK+FBOqv6su9kYHYT3rvk0CsfCKC?=
 =?us-ascii?Q?QCO1NYH0mhUsRIO9qK9UCVGgJFtqoIYwPKpPwBu2ghi4+7PzeNpszjUyIZKL?=
 =?us-ascii?Q?nyXDCEW3bM3HPnPXKUlS3pwm9CU1IfqhMYNvNJgt3rfmtdaMdYaXQ1CoJr9Z?=
 =?us-ascii?Q?tzyXX7HNI/t6yIHKzR3RtMTMwoMQLA8zRRGrR6wm2lTX8BlX5Sblc4VGiUtL?=
 =?us-ascii?Q?EC06U7R2YJfOij4LWBKEpmfZaN6WZKjcOY9Ac/dFHACNEplhC/5BtWk3lUpp?=
 =?us-ascii?Q?H+mp6IUcREgbKtXW/pi2ZxSwi3ilkgvY5cOKHePaGfA52GjVS8LXtgqSb+N4?=
 =?us-ascii?Q?nVHlIVs0lFH6OXy3aqh4QQu7QogZmLWZ8arcXzqw5sN7wceiELp6B5z01b5O?=
 =?us-ascii?Q?EiPiX7hCzlR3MzWoxSWA0PZzihcue+TojqWxSv/P3UV9cvxhYewRRsye3rJ/?=
 =?us-ascii?Q?DprtwyDh6pV9DWoVUUkDWL19eOdCX9az2xj3WgxOI7OBMmnB7YxjJMLrNIHB?=
 =?us-ascii?Q?vE5uwsUDO60hJyUjdadNkuwLQQG7tbI1E+CqjWE6WeHO6xb/w6XFEhGFhEhS?=
 =?us-ascii?Q?ZK7UUmjpqAg2V6DX68/HqsRvlx5NJO3nvSNrPA8w1G73rxraYqAtNyebjLeD?=
 =?us-ascii?Q?W3cT7eycv3hAk3N/njT8h+l8PgvcfAooNKLHKPNaRIDkdmYOfY13F34fr4Zn?=
 =?us-ascii?Q?HQ2ZnOs1qz8gbQ14GMQrewVO5iMQupAUXY8if9uPAdIFf+wP4wyepa7WS6fM?=
 =?us-ascii?Q?rtet+Alfo+How90oITUm2RLyN0mCRsCab0C5g3lFZLATB0F3x68IOuxoc3YK?=
 =?us-ascii?Q?s9WRYLP3V/EbHWxhq7L95E82Nj933NzB7sOA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:31:56.6268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16d9d3e-3295-40bd-d31f-08ddae5bbb78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

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
 .../testing/selftests/kvm/guest_memfd_test.c  | 123 +++++++++++++++++-
 2 files changed, 122 insertions(+), 2 deletions(-)

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
index 5da2ed6277ac..a5d261dcfdf5 100644
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


