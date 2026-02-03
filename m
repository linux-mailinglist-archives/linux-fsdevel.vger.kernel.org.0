Return-Path: <linux-fsdevel+bounces-76225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP4+LWBLgmnNRwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 20:24:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2C1DE21E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 20:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4E26309F2FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 19:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD2329378;
	Tue,  3 Feb 2026 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fb4Ff997"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554573570D1
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146641; cv=none; b=bc2ZNuH5rqfPq0A3ZrBN/+5zHq41rBWf8WgjVhJHC64VpNUSv92AByzdLBVvQvft5YE0NVsTNwZzD7iPKdvlwi17V+H5SrAigo4ub+Mlp3lmiTIr8Tu7+gVhnIh2gvu97q18G5WOaynqVa9grwOtB/nALVs+sHSh3ubaYXWzZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146641; c=relaxed/simple;
	bh=0w4YgQ3XBgJ/xRPJAs39Nc0jXU5ZQmqnnH9JMqCZzEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RLb3FqpaZK3c/BVQ5oOmgA2pecwcUpqyXm7gJrHCRyZuLRrQbyk7d28JiBU0mmf9rQI8E4ZbmXGvm8HE3x7PHxiluVKQXBbnRS98AZmPZOdNfE7rIfYXG5rSOV+ZAyICml9iLnSsoNgul6wK2U+EhEQ4FiKtS5cvI1SY3s/F6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fb4Ff997; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8216fece04cso104412b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 11:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770146639; x=1770751439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/tlxC7jV4F7Lz2K5ysVxinzelO7YC4ddlq8CWE746MQ=;
        b=Fb4Ff997dnrrKkZWK9Y/u+JvAxDBn7kJA3/HX10a4akJlIeAKc0yWZPoxV38xCGktW
         86RkjKf+KEuKRUnO6fJZCFzVi7Ioxr08Sx/Q4xnnGheMyWDrHdhJCnpEchUjrU9AD/D0
         IMisldXbH1qPt31oE+HCw+Cn7Z4af2OowEn4XPmXJdexQrLPDt+TgEkDjdlwCdtHqRcI
         QqnrsYm0QsshSz+dF0xK1uCLNO5Ri9/12oXE4hmWIVZMZmjxyuR+R4tKg6ImxOuTzl9W
         5ehi91x92kxJkFeJgPYPkHflIKj/0M3LbOJ5o7UJeWxRy9NSqN1TkayPJv+/ova0XsyF
         /vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770146639; x=1770751439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tlxC7jV4F7Lz2K5ysVxinzelO7YC4ddlq8CWE746MQ=;
        b=bNmeVKtT3YSBaSNBSGWEuIlZa7ibkbssBzg1o+LXxL+NIIbStOfCECP3J2ubZ6ocGV
         5Kna+uBdgtwfh+OmkGuUKrKYorDWh/HxC1RKEJwSiYfL35aNqt0nDrCh23LsMDgqxB2r
         5NsuHa900SNEBasVdCg/GH9T9mNz7/lwHbL6EhDTmwomMeXd/W89o90+y2DDXfu5yTZY
         nW8dUc4vQO42EMbz9kKQAmNonQ0N8he2EXuWLVnQVnO/ChaSkAWUYXzKvcvzmdDsfZVz
         KJEcNtUfFTbR+Sri0lJsIAJKxIy8CCrqZaZ/R0cWFj7p0atzCXZr8HG+ySzYA5O5+MoT
         HB/A==
X-Forwarded-Encrypted: i=1; AJvYcCVgNGpw8cBzb7UlR5Bfc8HOe6pWJ9jeKsdvBDn89H4epgT0E0TMIpc436AET0bNNxjIr0/zGlW4vNu4I8T9@vger.kernel.org
X-Gm-Message-State: AOJu0YyCatWycnsUrXHJQhMaPPoDTxQx88gOH9P1kn6PyBYV+Q/w4/ox
	usNRyGaoZgNEzD58iflY4frETo0w/GluHTWnJf8z5iupc4MnccvP3yXLwwHQxAO5EYrE23fqd4A
	et14JbN8tjOUQEg==
X-Received: from pfh34.prod.google.com ([2002:a05:6a00:12e2:b0:7dd:8bba:639b])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2171:b0:824:1c29:f1c3 with SMTP id d2e1a72fcca58-8241c29f7dfmr368201b3a.21.1770146638563;
 Tue, 03 Feb 2026 11:23:58 -0800 (PST)
Date: Tue,  3 Feb 2026 19:23:51 +0000
In-Reply-To: <20260203192352.2674184-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203192352.2674184-3-jiaqiyan@google.com>
Subject: [PATCH v3 2/3] selftests/mm: test userspace MFR for HugeTLB hugepage
From: Jiaqi Yan <jiaqiyan@google.com>
To: linmiaohe@huawei.com, william.roche@oracle.com, harry.yoo@oracle.com, 
	jane.chu@oracle.com
Cc: nao.horiguchi@gmail.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76225-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B2C1DE21E
X-Rspamd-Action: no action

Test the userspace memory failure recovery (MFR) policy for HugeTLB:

1. Create a memfd backed by HugeTLB and had MFD_MF_KEEP_UE_MAPPED set.

2. Allocate and map 4 hugepages to the process.

3. Create sub-threads to MADV_HWPOISON inner addresses of the 1st hugepage.

4. Check if the process gets correct SIGBUS for each poisoned raw page.

5. Check if all memory are still accessible and content valid.

6. Check if the poisoned hugepage is dealt with after memfd released.

Two configurables in the test:

- hugepage_size: size of the hugepage, 1G or 2M.

- nr_hwp_pages: number of pages within the 1st hugepage to MADV_HWPOISON.

Reviewed-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/.gitignore    |   1 +
 tools/testing/selftests/mm/Makefile      |   3 +
 tools/testing/selftests/mm/hugetlb-mfr.c | 369 +++++++++++++++++++++++
 3 files changed, 373 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb-mfr.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index c2a8586e51a1f..11664d20935db 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -5,6 +5,7 @@ hugepage-mremap
 hugepage-shm
 hugepage-vmemmap
 hugetlb-madvise
+hugetlb-mfr
 hugetlb-read-hwpoison
 hugetlb-soft-offline
 khugepaged
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eaf9312097f7b..7469142a87dcc 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -63,6 +63,7 @@ TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugetlb-madvise
 TEST_GEN_FILES += hugetlb-read-hwpoison
 TEST_GEN_FILES += hugetlb-soft-offline
+TEST_GEN_FILES += hugetlb-mfr
 TEST_GEN_FILES += hugepage-mmap
 TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
@@ -233,6 +234,8 @@ $(OUTPUT)/migration: LDLIBS += -lnuma
 
 $(OUTPUT)/rmap: LDLIBS += -lnuma
 
+$(OUTPUT)/hugetlb-mfr: LDLIBS += -lnuma
+
 local_config.mk local_config.h: check_config.sh
 	/bin/sh ./check_config.sh $(CC)
 
diff --git a/tools/testing/selftests/mm/hugetlb-mfr.c b/tools/testing/selftests/mm/hugetlb-mfr.c
new file mode 100644
index 0000000000000..6de59efdb101f
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb-mfr.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Test the userspace memory failure recovery (MFR) policy for HugeTLB
+ * hugepage case:
+ * 1. Create a memfd backed by HugeTLB and MFD_MF_KEEP_UE_MAPPED bit set.
+ * 2. Allocate and map 4 hugepages.
+ * 3. Create sub-threads to MADV_HWPOISON inner addresses of the 1st hugepage.
+ * 4. Check if each sub-thread get correct SIGBUS for the poisoned raw pages.
+ * 5. Check if all memory are still accessible and content still valid.
+ * 6. Check if the poisoned hugepage is dealt with after memfd released.
+ *
+ * Test takes two arguments:
+ * - hugepage_size: size of the hugepage, 1G or 2M.
+ * - nr_hwp_pages: number of pages within the 1st hugepage to MADV_HWPOISON.
+ *
+ * Example ways to run the test:
+ *   ./hugetlb-mfr 2M 3
+ * or
+ *   ./hugetlb-mfr 1G 1
+ * assuming /sys/kernel/mm/hugepages/hugepages-${xxx}kB/nr_hugepages > 4
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <numaif.h>
+#include <numa.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <linux/magic.h>
+#include <linux/memfd.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/statfs.h>
+#include <sys/types.h>
+
+#include "../kselftest.h"
+#include "vm_util.h"
+
+#define min(a, b) ((a) < (b) ? (a) : (b))
+
+#define EPREFIX			" !!! "
+#define BYTE_LENTH_IN_1G	0x40000000UL
+#define BYTE_LENTH_IN_2M	0x200000UL
+#define HUGETLB_1GB_STR		"1G"
+#define HUGETLB_2MB_STR		"2M"
+#define HUGETLB_FILL		0xab
+
+static const unsigned long offsets_1g[] = {
+	0x200000, 0x3ff000, 0x801000, 0x2000000,
+	0x3fff000, 0x4001000, 0x7fff000, 0x8011000
+};
+static const unsigned long offsets_2m[] = {
+	0x020000, 0x041000, 0x07f000, 0x120000,
+	0x13f000, 0x141000, 0x17f000, 0x18f000
+};
+static size_t nr_hwp_pages;
+
+static void *sigbus_addr;
+static int sigbus_addr_lsb;
+static bool expecting_sigbus;
+static bool got_sigbus;
+static bool was_mceerr;
+
+static int create_hugetlbfs_file(struct statfs *file_stat,
+				 unsigned long hugepage_size)
+{
+	int fd;
+	int flags = MFD_HUGETLB | MFD_MF_KEEP_UE_MAPPED;
+
+	if (hugepage_size == BYTE_LENTH_IN_2M)
+		flags |= MFD_HUGE_2MB;
+	else
+		flags |= MFD_HUGE_1GB;
+
+	fd = memfd_create("hugetlb_tmp", flags);
+	if (fd < 0)
+		ksft_exit_fail_perror("Failed to memfd_create");
+
+	memset(file_stat, 0, sizeof(*file_stat));
+	if (fstatfs(fd, file_stat)) {
+		close(fd);
+		ksft_exit_fail_perror("Failed to fstatfs");
+	}
+	if (file_stat->f_type != HUGETLBFS_MAGIC) {
+		close(fd);
+		ksft_exit_fail_msg("Not hugetlbfs file");
+	}
+
+	ksft_print_msg("Created hugetlb_tmp file\n");
+	ksft_print_msg("hugepagesize=%#lx\n", file_stat->f_bsize);
+	if (file_stat->f_bsize != hugepage_size)
+		ksft_exit_fail_msg("Hugepage size is not %#lx", hugepage_size);
+
+	return fd;
+}
+
+/*
+ * SIGBUS handler for "do_hwpoison" thread that mapped and MADV_HWPOISON
+ */
+static void sigbus_handler(int signo, siginfo_t *info, void *context)
+{
+	if (!expecting_sigbus)
+		ksft_exit_fail_msg("unexpected sigbus with addr=%p",
+				   info->si_addr);
+
+	got_sigbus = true;
+	was_mceerr = (info->si_code == BUS_MCEERR_AO ||
+		      info->si_code == BUS_MCEERR_AR);
+	sigbus_addr = info->si_addr;
+	sigbus_addr_lsb = info->si_addr_lsb;
+}
+
+static void *do_hwpoison(void *hwpoison_addr)
+{
+	int hwpoison_size = getpagesize();
+
+	ksft_print_msg("MADV_HWPOISON hwpoison_addr=%p, len=%d\n",
+		       hwpoison_addr, hwpoison_size);
+	if (madvise(hwpoison_addr, hwpoison_size, MADV_HWPOISON) < 0)
+		ksft_exit_fail_perror("Failed to MADV_HWPOISON");
+
+	pthread_exit(NULL);
+}
+
+static void test_hwpoison_multiple_pages(unsigned char *start_addr,
+					 unsigned long hugepage_size)
+{
+	pthread_t pthread;
+	int ret;
+	unsigned char *hwpoison_addr;
+	const unsigned long *offsets;
+	size_t i;
+
+	if (hugepage_size == BYTE_LENTH_IN_2M)
+		offsets = offsets_2m;
+	else
+		offsets = offsets_1g;
+
+	for (i = 0; i < nr_hwp_pages; ++i) {
+		sigbus_addr = (void *)0xBADBADBAD;
+		sigbus_addr_lsb = 0;
+		was_mceerr = false;
+		got_sigbus = false;
+		expecting_sigbus = true;
+		hwpoison_addr = start_addr + offsets[i];
+
+		ret = pthread_create(&pthread, NULL, &do_hwpoison, hwpoison_addr);
+		if (ret)
+			ksft_exit_fail_perror("Failed to create hwpoison thread");
+
+		ksft_print_msg("Created thread to hwpoison and access hwpoison_addr=%p\n",
+			       hwpoison_addr);
+
+		pthread_join(pthread, NULL);
+
+		if (!got_sigbus)
+			ksft_test_result_fail("Didn't get a SIGBUS\n");
+		if (!was_mceerr)
+			ksft_test_result_fail("Didn't get a BUS_MCEERR_A(R|O)\n");
+		if (sigbus_addr != hwpoison_addr)
+			ksft_test_result_fail("Incorrect address: got=%p, expected=%p\n",
+					      sigbus_addr, hwpoison_addr);
+		if (sigbus_addr_lsb != pshift())
+			ksft_test_result_fail("Incorrect address LSB: got=%d, expected=%d\n",
+					      sigbus_addr_lsb, pshift());
+
+		ksft_print_msg("Received expected and correct SIGBUS\n");
+	}
+}
+
+static int read_nr_hugepages(unsigned long hugepage_size,
+			     unsigned long *nr_hugepages)
+{
+	char buffer[256] = {0};
+	char cmd[256] = {0};
+
+	sprintf(cmd, "cat /sys/kernel/mm/hugepages/hugepages-%ldkB/nr_hugepages",
+		hugepage_size);
+	FILE *cmdfile = popen(cmd, "r");
+
+	if (cmdfile == NULL) {
+		ksft_perror(EPREFIX "failed to popen nr_hugepages");
+		return -1;
+	}
+
+	if (!fgets(buffer, sizeof(buffer), cmdfile)) {
+		ksft_perror(EPREFIX "failed to read nr_hugepages");
+		pclose(cmdfile);
+		return -1;
+	}
+
+	*nr_hugepages = atoll(buffer);
+	pclose(cmdfile);
+	return 0;
+}
+
+/*
+ * Main thread that drives the test.
+ */
+static void test_main(int fd, unsigned long hugepage_size)
+{
+	unsigned char *map, *iter;
+	struct sigaction new, old;
+	const unsigned long hugepagesize_kb = hugepage_size / 1024;
+	unsigned long nr_hugepages_before = 0;
+	unsigned long nr_hugepages_after = 0;
+	unsigned long nodemask = 1UL << 0;
+	unsigned long len = hugepage_size * 4;
+	int ret;
+
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) != 0) {
+		close(fd);
+		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
+	}
+	ksft_print_msg("NR hugepages before MADV_HWPOISON is %ld\n", nr_hugepages_before);
+
+	if (ftruncate(fd, len) < 0)
+		ksft_exit_fail_perror("Failed to ftruncate");
+
+	ksft_print_msg("Allocated %#lx bytes to HugeTLB file\n", len);
+
+	map = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("Failed to mmap");
+
+	ksft_print_msg("Created HugeTLB mapping: %p\n", map);
+
+	ret = mbind(map, len, MPOL_BIND, &nodemask, sizeof(nodemask) * 8,
+		    MPOL_MF_STRICT | MPOL_MF_MOVE);
+	if (ret < 0) {
+		perror("mbind");
+		ksft_exit_fail_msg("Failed to bind to node\n");
+	}
+
+	memset(map, HUGETLB_FILL, len);
+	ksft_print_msg("Memset every byte to 0xab\n");
+
+	new.sa_sigaction = &sigbus_handler;
+	new.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGBUS, &new, &old) < 0)
+		ksft_exit_fail_msg("Failed to setup SIGBUS handler");
+
+	ksft_print_msg("Setup SIGBUS handler successfully\n");
+
+	test_hwpoison_multiple_pages(map, hugepage_size);
+
+	/*
+	 * Since MADV_HWPOISON doesn't corrupt the memory in hardware, and
+	 * MFD_MF_KEEP_UE_MAPPED keeps the hugepage mapped, every byte should
+	 * remain accessible and hold original data.
+	 */
+	expecting_sigbus = false;
+	for (iter = map; iter < map + len; ++iter) {
+		if (*iter != HUGETLB_FILL) {
+			ksft_print_msg("At addr=%p: got=%#x, expected=%#x\n",
+				       iter, *iter, HUGETLB_FILL);
+			ksft_test_result_fail("Memory content corrupted\n");
+			break;
+		}
+	}
+	ksft_print_msg("Memory content all valid\n");
+
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0) {
+		close(fd);
+		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
+	}
+
+	/*
+	 * After MADV_HWPOISON, hugepage should still be in HugeTLB pool.
+	 */
+	ksft_print_msg("NR hugepages after MADV_HWPOISON is %ld\n", nr_hugepages_after);
+	if (nr_hugepages_before != nr_hugepages_after)
+		ksft_test_result_fail("NR hugepages reduced by %ld after MADV_HWPOISON\n",
+				      nr_hugepages_before - nr_hugepages_after);
+
+	/* End of the lifetime of the created HugeTLB memfd. */
+	if (ftruncate(fd, 0) < 0)
+		ksft_exit_fail_perror("Failed to ftruncate to 0");
+	munmap(map, len);
+	close(fd);
+
+	/*
+	 * After freed by userspace, MADV_HWPOISON-ed hugepage should be
+	 * dissolved into raw pages and removed from HugeTLB pool.
+	 */
+	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0) {
+		close(fd);
+		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
+	}
+	ksft_print_msg("NR hugepages after closure is %ld\n", nr_hugepages_after);
+	if (nr_hugepages_before != nr_hugepages_after + 1)
+		ksft_test_result_fail("NR hugepages is not reduced after memfd closure\n");
+
+	ksft_test_result_pass("All done\n");
+}
+
+static unsigned long parse_hugepage_size(char *argv)
+{
+	if (strncasecmp(argv, HUGETLB_1GB_STR, strlen(HUGETLB_1GB_STR)) == 0)
+		return BYTE_LENTH_IN_1G;
+
+	if (strncasecmp(argv, HUGETLB_2MB_STR, strlen(HUGETLB_2MB_STR)) == 0)
+		return BYTE_LENTH_IN_2M;
+
+	ksft_print_msg("Please provide valid hugepage_size: 1G or 2M\n");
+	assert(false);
+}
+
+static size_t parse_nr_hwp_pages(char *argv)
+{
+	unsigned long val;
+	char *endptr;
+	size_t limit = min(ARRAY_SIZE(offsets_1g), ARRAY_SIZE(offsets_2m));
+
+	if (strlen(argv) < 1) {
+		ksft_print_msg("Please provide valid nr_hwpoison: 1-8\n");
+		assert(false);
+	}
+
+	errno = 0;
+	val = strtoul(argv, &endptr, 10);
+
+	if (*endptr != '\0') {
+		ksft_print_msg("Found invalid chars: '%s", endptr);
+		assert(false);
+	}
+
+	if (errno == ERANGE) {
+		ksft_print_msg("Value '%s' out of range for size_t\n", argv);
+		assert(false);
+	}
+
+	if (val > limit) {
+		ksft_print_msg("Value '%s' must < %lu\n", argv, limit);
+		assert(false);
+	}
+
+	return val;
+}
+
+int main(int argc, char **argv)
+{
+	int fd;
+	struct statfs file_stat;
+	unsigned long hugepage_size;
+
+	if (argc != 3) {
+		ksft_print_msg("Usage: %s <hugepage_size=1G|2M> <nr_hwp_pages>\n", argv[0]);
+		return -EINVAL;
+	}
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	hugepage_size = parse_hugepage_size(argv[1]);
+	nr_hwp_pages = parse_nr_hwp_pages(argv[2]);
+	fd = create_hugetlbfs_file(&file_stat, hugepage_size);
+	test_main(fd, hugepage_size);
+
+	ksft_finished();
+}
-- 
2.53.0.rc2.204.g2597b5adb4-goog


