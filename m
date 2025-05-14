Return-Path: <linux-fsdevel+bounces-49071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C37AB7A28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8349E0616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B62E26A09B;
	Wed, 14 May 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdodJE/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C92690FA
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266251; cv=none; b=Flm7uEpx1P6sgXL+RrAycqyCt6XQT9XLpWXgPW4prX+IVoFY4L2RNhjhzfULx5tCvzhzIea4LAGvnFVj86qaHikOQWUwjeZ81stsi82xI5Kc05CRMB58uVeMd43/BDliuSsQiSS2p1VLx1qlCn+4Ovcmr1ViVES54UIw7Ajdrb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266251; c=relaxed/simple;
	bh=YaXMZqa/CJWT3sVvlMcRl825YHOjaW+jUzinohijxTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t1HNVyx9zStU1yWh2tEhhMmF9al+OO7zY1G3/EkPR/m9m8CKz8nlY98RD6bBLDtIRrTYSbf3RBuDp8EukyPIMtir8jDlNRCFIzGdyMXdzr+bSoI9jkBKjkW6PlQEutnpI/SnzwP0i3fKXa5YMtz8SFlj2VX1XsxL0gOFk60nKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EdodJE/p; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ad1e374e2so381682a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266249; x=1747871049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAqx7PB78yrm1J6fClisMvqbdgg3BicIqBxSbwrmM4g=;
        b=EdodJE/pViH8yZ5i7aF3n2+feodg4+9ORS4RGoYH7yF7QL/sRoP09Qsn8f2v2aH0bN
         sxYjkOSPWY6XYE0E+f6iS2LToOsUXVLnLdWuJXeHshMz8MJCewxeXFElHHvis3oFYQBp
         m6+kk803Q0r1Nb+3sPCQNaUMoT+V+4xzTZf8OqDlcl+AVklOeD6CPK8ZvUamVdYmUGxx
         svTmmNLYfO8Q83EpaJoepQLlaXmRo1BmebejJR2Fn9/mtw6SAGlnvlaMV7uaWpnldutf
         Q4QRmi/o4RheTQkF8XxmQSD9kG8Smm/O1jPEOXxNqiff24sJDgxeiiZs3VT8STEiuP8v
         O7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266249; x=1747871049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAqx7PB78yrm1J6fClisMvqbdgg3BicIqBxSbwrmM4g=;
        b=baojfVTw63PQbkWwkF2MWhUUrWOmzuyBwfaOkMZRmxx60rJpGZAwwrYXwfLka8SgGy
         GQMyRbMGIrRd9B0luX8L45Hzim8PWQKqbTyQsc+65Aa0hGfnYnE8H27PoLUIYdVTsql3
         0ajKOcHV1ou60/rVMMi8BD0/6hnuNlvuJ9gXMNP3zhJYH9cqnXp3H3/CAvCps+cO5O/2
         i1GEt7DWKu4MCmKTGKDMbpuBXVCeKRpZqfNkSHd4K+o6u4cmwK1cf/5/l8ZaJDgrn7I/
         6ov9n2Ik/hdE1+3LSL6/+623ynshsCtLlRddgR+JXiJMNkVQzFW5xS8vxFRJqEgQzMHk
         igmA==
X-Forwarded-Encrypted: i=1; AJvYcCW04Q8Fl+PM3M+shx6I0PNy4sFVTega+7rrWI6MzFpa5YCfMfqhrtl6ckVGULhU6xIbedoM99D9p5AaviFo@vger.kernel.org
X-Gm-Message-State: AOJu0YygJgb+Zd4Xd9uOWjq05y31yoUGgP2sSxCUHQtuo7/XEtdga0OC
	zNKyb3mazh5FLVXgxnY9VOgEspsP06RaTgfg/Q1u8x2fADajyS6K0j1/BRPdRy8mxeIoDJAJAFP
	CTzM12V1u5Io3vXRUgjoOVg==
X-Google-Smtp-Source: AGHT+IHTYGGI34KSQ5XCdFQVJvWJnhJg093+O7Y4UZIaW3vTNyanshiaJtG95L6+3kUV6GJKWdEgPBz38RMwUlzgHQ==
X-Received: from pjbpw18.prod.google.com ([2002:a17:90b:2792:b0:2fe:800f:23a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:498c:b0:301:1bce:c26f with SMTP id 98e67ed59e1d1-30e5156ed71mr757330a91.3.1747266249098;
 Wed, 14 May 2025 16:44:09 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:25 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <56149cfab1ab08d73618fd3914addd51dd42193a.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 46/51] KVM: selftests: Test that guest_memfd usage is
 reported via hugetlb
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Using HugeTLB as the huge page allocator for guest_memfd allows reuse
of HugeTLB's reporting mechanism, hence HugeTLB stats must be kept
up-to-date.

This patch tests for the above.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: Ida3319b1d40c593d8167a03506c7030e67fc746b
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/guest_memfd_hugetlb_reporting_test.c  | 384 ++++++++++++++++++
 ...uest_memfd_provide_hugetlb_cgroup_mount.sh |  36 ++
 3 files changed, 421 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c
 create mode 100755 tools/testing/selftests/kvm/guest_memfd_provide_hugetlb_cgroup_mount.sh

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index bc22a5a23c4c..2ffe6bc95a68 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -132,6 +132,7 @@ TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
 TEST_GEN_PROGS_x86 += guest_memfd_test
 TEST_GEN_PROGS_x86 += guest_memfd_conversions_test
+TEST_GEN_PROGS_x86 += guest_memfd_hugetlb_reporting_test
 TEST_GEN_PROGS_x86 += hardware_disable_test
 TEST_GEN_PROGS_x86 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86 += memslot_perf_test
diff --git a/tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c b/tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c
new file mode 100644
index 000000000000..8ff1dda3e02f
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Tests that HugeTLB statistics are correct at various points of the lifecycle
+ * of guest_memfd with 1G page support.
+ *
+ * Providing a HUGETLB_CGROUP_PATH will allow cgroup reservations to be
+ * tested.
+ *
+ * Either use
+ *
+ *   ./guest_memfd_provide_hugetlb_cgroup_mount.sh ./guest_memfd_hugetlb_reporting_test
+ *
+ * or provide the mount with
+ *
+ *   export HUGETLB_CGROUP_PATH=/tmp/hugetlb-cgroup
+ *   mount -t cgroup -o hugetlb none $HUGETLB_CGROUP_PATH
+ *   ./guest_memfd_hugetlb_reporting_test
+ *
+ *
+ * Copyright (C) 2025 Google LLC
+ *
+ * Authors:
+ *   Ackerley Tng <ackerleytng@google.com>
+ */
+
+#include <fcntl.h>
+#include <linux/falloc.h>
+#include <linux/guestmem.h>
+#include <linux/kvm.h>
+#include <linux/limits.h>
+#include <linux/memfd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+
+#include "kvm_util.h"
+#include "test_util.h"
+#include "processor.h"
+
+static unsigned long read_value(const char *file_name)
+{
+	FILE *fp;
+	unsigned long num;
+
+	fp = fopen(file_name, "r");
+	TEST_ASSERT(fp != NULL, "Error opening file %s!\n", file_name);
+
+	TEST_ASSERT_EQ(fscanf(fp, "%lu", &num), 1);
+
+	fclose(fp);
+
+	return num;
+}
+
+enum hugetlb_statistic {
+	FREE_HUGEPAGES,
+	NR_HUGEPAGES,
+	NR_OVERCOMMIT_HUGEPAGES,
+	RESV_HUGEPAGES,
+	SURPLUS_HUGEPAGES,
+	NR_TESTED_HUGETLB_STATISTICS,
+};
+
+enum hugetlb_cgroup_statistic {
+	LIMIT_IN_BYTES,
+	MAX_USAGE_IN_BYTES,
+	USAGE_IN_BYTES,
+	NR_TESTED_HUGETLB_CGROUP_STATISTICS,
+};
+
+enum hugetlb_cgroup_statistic_category {
+	USAGE = 0,
+	RESERVATION,
+	NR_HUGETLB_CGROUP_STATISTIC_CATEGORIES,
+};
+
+static const char *hugetlb_statistics[NR_TESTED_HUGETLB_STATISTICS] = {
+	[FREE_HUGEPAGES] = "free_hugepages",
+	[NR_HUGEPAGES] = "nr_hugepages",
+	[NR_OVERCOMMIT_HUGEPAGES] = "nr_overcommit_hugepages",
+	[RESV_HUGEPAGES] = "resv_hugepages",
+	[SURPLUS_HUGEPAGES] = "surplus_hugepages",
+};
+
+static const char *hugetlb_cgroup_statistics[NR_TESTED_HUGETLB_CGROUP_STATISTICS] = {
+	[LIMIT_IN_BYTES] = "limit_in_bytes",
+	[MAX_USAGE_IN_BYTES] = "max_usage_in_bytes",
+	[USAGE_IN_BYTES] = "usage_in_bytes",
+};
+
+enum test_page_size {
+	TEST_SZ_2M,
+	TEST_SZ_1G,
+	NR_TEST_SIZES,
+};
+
+struct test_param {
+	size_t page_size;
+	int memfd_create_flags;
+	uint64_t guest_memfd_flags;
+	char *hugetlb_size_string;
+	char *hugetlb_cgroup_size_string;
+};
+
+const struct test_param *test_params(enum test_page_size size)
+{
+	static const struct test_param params[] = {
+		[TEST_SZ_2M] = {
+			.page_size = PG_SIZE_2M,
+			.memfd_create_flags = MFD_HUGETLB | MFD_HUGE_2MB,
+			.guest_memfd_flags = GUEST_MEMFD_FLAG_HUGETLB | GUESTMEM_HUGETLB_FLAG_2MB,
+			.hugetlb_size_string = "2048kB",
+			.hugetlb_cgroup_size_string = "2MB",
+		},
+		[TEST_SZ_1G] = {
+			.page_size = PG_SIZE_1G,
+			.memfd_create_flags = MFD_HUGETLB | MFD_HUGE_1GB,
+			.guest_memfd_flags = GUEST_MEMFD_FLAG_HUGETLB | GUESTMEM_HUGETLB_FLAG_1GB,
+			.hugetlb_size_string = "1048576kB",
+			.hugetlb_cgroup_size_string = "1GB",
+		},
+	};
+
+	return &params[size];
+}
+
+static unsigned long read_hugetlb_statistic(enum test_page_size size,
+					    enum hugetlb_statistic statistic)
+{
+	char path[PATH_MAX] = "/sys/kernel/mm/hugepages/hugepages-";
+
+	strcat(path, test_params(size)->hugetlb_size_string);
+	strcat(path, "/");
+	strcat(path, hugetlb_statistics[statistic]);
+
+	return read_value(path);
+}
+
+static unsigned long read_hugetlb_cgroup_statistic(const char *hugetlb_cgroup_path,
+						   enum test_page_size size,
+						   enum hugetlb_cgroup_statistic statistic,
+						   bool reservations)
+{
+	char path[PATH_MAX] = "";
+
+	strcat(path, hugetlb_cgroup_path);
+
+	if (hugetlb_cgroup_path[strlen(hugetlb_cgroup_path) - 1] != '/')
+		strcat(path, "/");
+
+	strcat(path, "hugetlb.");
+	strcat(path, test_params(size)->hugetlb_cgroup_size_string);
+	if (reservations)
+		strcat(path, ".rsvd");
+	strcat(path, ".");
+	strcat(path, hugetlb_cgroup_statistics[statistic]);
+
+	return read_value(path);
+}
+
+static unsigned long hugetlb_baseline[NR_TEST_SIZES]
+				     [NR_TESTED_HUGETLB_STATISTICS];
+
+static unsigned long
+	hugetlb_cgroup_baseline[NR_TEST_SIZES]
+			       [NR_TESTED_HUGETLB_CGROUP_STATISTICS]
+			       [NR_HUGETLB_CGROUP_STATISTIC_CATEGORIES];
+
+
+static void establish_baseline(const char *hugetlb_cgroup_path)
+{
+	const char *p = hugetlb_cgroup_path;
+	int i, j;
+
+	for (i = 0; i < NR_TEST_SIZES; ++i) {
+		for (j = 0; j < NR_TESTED_HUGETLB_STATISTICS; ++j)
+			hugetlb_baseline[i][j] = read_hugetlb_statistic(i, j);
+
+		if (!hugetlb_cgroup_path)
+			continue;
+
+		for (j = 0; j < NR_TESTED_HUGETLB_CGROUP_STATISTICS; ++j) {
+			hugetlb_cgroup_baseline[i][j][USAGE] =
+				read_hugetlb_cgroup_statistic(p, i, j, USAGE);
+			hugetlb_cgroup_baseline[i][j][RESERVATION] =
+				read_hugetlb_cgroup_statistic(p, i, j, RESERVATION);
+		}
+	}
+}
+
+static void assert_stats_at_baseline(const char *hugetlb_cgroup_path)
+{
+	const char *p = hugetlb_cgroup_path;
+
+	/* Enumerate these for easy assertion reading. */
+	TEST_ASSERT_EQ(read_hugetlb_statistic(TEST_SZ_2M, FREE_HUGEPAGES),
+		       hugetlb_baseline[TEST_SZ_2M][FREE_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(TEST_SZ_2M, NR_HUGEPAGES),
+		       hugetlb_baseline[TEST_SZ_2M][NR_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(TEST_SZ_2M, NR_OVERCOMMIT_HUGEPAGES),
+		       hugetlb_baseline[TEST_SZ_2M][NR_OVERCOMMIT_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(TEST_SZ_2M, RESV_HUGEPAGES),
+		       hugetlb_baseline[TEST_SZ_2M][RESV_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(TEST_SZ_2M, SURPLUS_HUGEPAGES),
+		       hugetlb_baseline[TEST_SZ_2M][SURPLUS_HUGEPAGES]);
+
+	TEST_ASSERT_EQ(read_hugetlb_statistic(TEST_SZ_1G, FREE_HUGEPAGES),
+		       hugetlb_baseline[TEST_SZ_1G][FREE_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(TEST_SZ_1G, NR_HUGEPAGES),
+		       hugetlb_baseline[TEST_SZ_1G][NR_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(TEST_SZ_1G, NR_OVERCOMMIT_HUGEPAGES),
+		       hugetlb_baseline[TEST_SZ_1G][NR_OVERCOMMIT_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(TEST_SZ_1G, RESV_HUGEPAGES),
+		       hugetlb_baseline[TEST_SZ_1G][RESV_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(TEST_SZ_1G, SURPLUS_HUGEPAGES),
+		       hugetlb_baseline[TEST_SZ_1G][SURPLUS_HUGEPAGES]);
+
+	if (!hugetlb_cgroup_path)
+		return;
+
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, TEST_SZ_2M, LIMIT_IN_BYTES, USAGE),
+		hugetlb_cgroup_baseline[TEST_SZ_2M][LIMIT_IN_BYTES][USAGE]);
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, TEST_SZ_2M, MAX_USAGE_IN_BYTES, USAGE),
+		hugetlb_cgroup_baseline[TEST_SZ_2M][MAX_USAGE_IN_BYTES][USAGE]);
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, TEST_SZ_2M, USAGE_IN_BYTES, USAGE),
+		hugetlb_cgroup_baseline[TEST_SZ_2M][USAGE_IN_BYTES][USAGE]);
+
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, TEST_SZ_1G, LIMIT_IN_BYTES, RESERVATION),
+		hugetlb_cgroup_baseline[TEST_SZ_1G][LIMIT_IN_BYTES][RESERVATION]);
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, TEST_SZ_1G, MAX_USAGE_IN_BYTES, RESERVATION),
+		hugetlb_cgroup_baseline[TEST_SZ_1G][MAX_USAGE_IN_BYTES][RESERVATION]);
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, TEST_SZ_1G, USAGE_IN_BYTES, RESERVATION),
+		hugetlb_cgroup_baseline[TEST_SZ_1G][USAGE_IN_BYTES][RESERVATION]);
+}
+
+static void assert_stats(const char *hugetlb_cgroup_path,
+			 enum test_page_size size, unsigned long num_reserved,
+			 unsigned long num_faulted)
+{
+	size_t pgsz = test_params(size)->page_size;
+	const char *p = hugetlb_cgroup_path;
+
+	TEST_ASSERT_EQ(read_hugetlb_statistic(size, FREE_HUGEPAGES),
+		       hugetlb_baseline[size][FREE_HUGEPAGES] - num_faulted);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(size, NR_HUGEPAGES),
+		       hugetlb_baseline[size][NR_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(size, NR_OVERCOMMIT_HUGEPAGES),
+		       hugetlb_baseline[size][NR_OVERCOMMIT_HUGEPAGES]);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(size, RESV_HUGEPAGES),
+		       hugetlb_baseline[size][RESV_HUGEPAGES] + num_reserved - num_faulted);
+	TEST_ASSERT_EQ(read_hugetlb_statistic(size, SURPLUS_HUGEPAGES),
+		       hugetlb_baseline[size][SURPLUS_HUGEPAGES]);
+
+	if (!hugetlb_cgroup_path)
+		return;
+
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, size, LIMIT_IN_BYTES, USAGE),
+		hugetlb_cgroup_baseline[size][LIMIT_IN_BYTES][USAGE]);
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, size, MAX_USAGE_IN_BYTES, USAGE),
+		hugetlb_cgroup_baseline[size][MAX_USAGE_IN_BYTES][USAGE]);
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, size, USAGE_IN_BYTES, USAGE),
+		hugetlb_cgroup_baseline[size][USAGE_IN_BYTES][USAGE] + num_faulted * pgsz);
+
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, size, LIMIT_IN_BYTES, RESERVATION),
+		hugetlb_cgroup_baseline[size][LIMIT_IN_BYTES][RESERVATION]);
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, size, MAX_USAGE_IN_BYTES, RESERVATION),
+		hugetlb_cgroup_baseline[size][MAX_USAGE_IN_BYTES][RESERVATION]);
+	TEST_ASSERT_EQ(
+		read_hugetlb_cgroup_statistic(p, size, USAGE_IN_BYTES, RESERVATION),
+		hugetlb_cgroup_baseline[size][USAGE_IN_BYTES][RESERVATION] + num_reserved * pgsz);
+}
+
+/* Use hugetlb behavior as a baseline. guest_memfd should have comparable behavior. */
+static void test_hugetlb_behavior(const char *hugetlb_cgroup_path, enum test_page_size test_size)
+{
+	const struct test_param *param;
+	char *mem;
+	int memfd;
+
+	param = test_params(test_size);
+
+	assert_stats_at_baseline(hugetlb_cgroup_path);
+
+	memfd = memfd_create("guest_memfd_hugetlb_reporting_test",
+			     param->memfd_create_flags);
+
+	assert_stats(hugetlb_cgroup_path, test_size, 0, 0);
+
+	mem = mmap(NULL, param->page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_HUGETLB, memfd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "Couldn't mmap()");
+
+	assert_stats(hugetlb_cgroup_path, test_size, 1, 0);
+
+	*mem = 'A';
+
+	assert_stats(hugetlb_cgroup_path, test_size, 1, 1);
+
+	munmap(mem, param->page_size);
+
+	assert_stats(hugetlb_cgroup_path, test_size, 1, 1);
+
+	madvise(mem, param->page_size, MADV_DONTNEED);
+
+	assert_stats(hugetlb_cgroup_path, test_size, 1, 1);
+
+	madvise(mem, param->page_size, MADV_REMOVE);
+
+	assert_stats(hugetlb_cgroup_path, test_size, 1, 1);
+
+	close(memfd);
+
+	assert_stats_at_baseline(hugetlb_cgroup_path);
+}
+
+static void test_guest_memfd_behavior(const char *hugetlb_cgroup_path,
+				      enum test_page_size test_size)
+{
+	const struct test_param *param;
+	struct kvm_vm *vm;
+	int guest_memfd;
+
+	param = test_params(test_size);
+
+	assert_stats_at_baseline(hugetlb_cgroup_path);
+
+	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
+
+	assert_stats(hugetlb_cgroup_path, test_size, 0, 0);
+
+	guest_memfd = vm_create_guest_memfd(vm, param->page_size,
+					    param->guest_memfd_flags);
+
+	/* fd creation reserves pages. */
+	assert_stats(hugetlb_cgroup_path, test_size, 1, 0);
+
+	fallocate(guest_memfd, FALLOC_FL_KEEP_SIZE, 0, param->page_size);
+
+	assert_stats(hugetlb_cgroup_path, test_size, 1, 1);
+
+	fallocate(guest_memfd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0,
+		  param->page_size);
+
+	assert_stats(hugetlb_cgroup_path, test_size, 1, 0);
+
+	close(guest_memfd);
+
+	/*
+	 * Wait a little for stats to be updated in rcu callback. resv_hugepages
+	 * is updated on truncation in ->free_inode, and ->free_inode() happens
+	 * in an rcu callback.
+	 */
+	usleep(300 * 1000);
+
+	assert_stats_at_baseline(hugetlb_cgroup_path);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	char *hugetlb_cgroup_path;
+
+	hugetlb_cgroup_path = getenv("HUGETLB_CGROUP_PATH");
+
+	establish_baseline(hugetlb_cgroup_path);
+
+	test_hugetlb_behavior(hugetlb_cgroup_path, TEST_SZ_2M);
+	test_hugetlb_behavior(hugetlb_cgroup_path, TEST_SZ_1G);
+
+	test_guest_memfd_behavior(hugetlb_cgroup_path, TEST_SZ_2M);
+	test_guest_memfd_behavior(hugetlb_cgroup_path, TEST_SZ_1G);
+}
diff --git a/tools/testing/selftests/kvm/guest_memfd_provide_hugetlb_cgroup_mount.sh b/tools/testing/selftests/kvm/guest_memfd_provide_hugetlb_cgroup_mount.sh
new file mode 100755
index 000000000000..4180d49771c8
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_provide_hugetlb_cgroup_mount.sh
@@ -0,0 +1,36 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Wrapper that runs test, providing a hugetlb cgroup mount in environment
+# variable HUGETLB_CGROUP_PATH
+#
+# Example:
+#   ./guest_memfd_provide_hugetlb_cgroup_mount.sh ./guest_memfd_hugetlb_reporting_test
+#
+# Copyright (C) 2025, Google LLC.
+
+script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
+
+temp_dir=$(mktemp -d /tmp/guest_memfd_hugetlb_reporting_test_XXXXXX)
+if [[ -z "$temp_dir" ]]; then
+  echo "Error: Failed to create temporary directory for hugetlb cgroup mount." >&2
+  exit 1
+fi
+
+delete_temp_dir() {
+  rm -rf $temp_dir
+}
+trap delete_temp_dir EXIT
+
+
+mount -t cgroup -o hugetlb none $temp_dir
+
+
+cleanup() {
+  umount $temp_dir
+  rm -rf $temp_dir
+}
+trap cleanup EXIT
+
+
+HUGETLB_CGROUP_PATH=$temp_dir $@
-- 
2.49.0.1045.g170613ef41-goog


