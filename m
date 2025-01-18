Return-Path: <linux-fsdevel+bounces-39596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD3A15F40
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 00:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1283A6D19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 23:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A41DED6C;
	Sat, 18 Jan 2025 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFRt/iFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB71DE8AA
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737242186; cv=none; b=bbjUW59gO6g6skiEu7eogYbA2dgXsL300EzruhAToapQVUS9k/VVoKgzAV1025aR9yvnZHQbaG4JxuvZh8Vge3/bvcA6++SuzXOmY21+3N/El8O7HIIuDvCnw295csmWZ9ISZgJu+TMRWDwaODkW9sGDNtF0cMyMQbwPZ3uHFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737242186; c=relaxed/simple;
	bh=nf9gmZa4aqx37StJicQapDfEQByUQVTZgsHYJIMiH4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SFTYvihxiCTV+EhhcOFwpyGpwkToNCOMdIk0UjiUpU14Iue8BWsSrmQVt/XhEKL8PFb49S8EQSCGJAcmsKQo833z/eI9VKnq1inx6e/UJ0q9SydAXDFFL8IVtEXMPdhVawL/qztIgtc7cJmJYQ8xlgXxAjFPmNWG/Hso9OFwRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFRt/iFU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee6dccd3c9so5965617a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 15:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737242184; x=1737846984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YN6TmY/NDY3/qLUZOajjmh5DrDHEICthyIauzWOR8ZQ=;
        b=PFRt/iFUSyTD3xTvKXubyegdDTIjgEExl+E+H07xPSBKlnX3c1lNcOkU5Qi33TxfsI
         0lA01uxk7PXGtCSExlzslCrK2hmpe43Ljzc5Hi/CrmSzD0JbeoirtlNd56s2kWApUsGv
         jJvl2uDZcubX+xkFd1C5k+odibp8HBqEAwXnpHnrpVbiAljcmLv0BTsG987VSz6euHV+
         qhMCbfpef99LeJs5Y9wktJREW2pVrzSDT6ugSXWQc+dOri4c7OcdCG4Be8a8w3jgMCnk
         s1nGG4A1iZJw3rRbUM4YQtEQheBFI767I8+8assgMNmDanfOIu7ga2PqrSsfSt5k/cqX
         2Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737242184; x=1737846984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN6TmY/NDY3/qLUZOajjmh5DrDHEICthyIauzWOR8ZQ=;
        b=CIixX8xJcYaWGPCyC2DyUP21Y7n24wktDaWeRCyImz+uo9gpy07wRpcvvO7aU5Hz02
         ASeD0QcC55uAkAcEO1+IDjFBBmJZxWg55hmkFUdZIVmABzFVgKtT5YGzc4jMTAHi7nLF
         JbcOBOun5v3NxmnzybAVawGSufCIMwG4cPIu1dyFQ4O70TMfqyYd7UmcMdNDjvV6OqBF
         a4GqjsZSATJFYnD20DIrSafNlILtQIkiRDQDOYaEbeIMJAEjJtxuo6hyTtCXR5NVmOcK
         RVRplY8y1sTW26Z3KpSv5+CSAIlULW8xaxnoFPs9yfJgLxPQgU8g51A4mTdIi9yNkeNH
         u+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS+aHU3aUlfHSgfS7+c58AfPmSAsrKzo+otJHsu5CQouzLHz86/t3pmzU02ggYP1IO5UfuxCVo6w1ImHCm@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKcaactdpnkljsVJXLfEPCxhN+as6zAmzrqrl05Xx2yPJM49+
	Xlqvrb08+44VWwg9o5D+0/TVCa9tLDfioFq3q1BX6O/k7hZj2NmDK3842i4ArDQYu6JaAEjbQkR
	It5KJ3+p9oQ==
X-Google-Smtp-Source: AGHT+IFLLkqbQaii6vgpMggmn1nuWWFx29WluNp02IqS6MEf1N7eQhiWvEopoT1MpbZfEYAZ5yHYOwd2a2T7AQ==
X-Received: from pjzm19.prod.google.com ([2002:a17:90b:693:b0:2d8:8d32:2ea3])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:540b:b0:2ee:ba0c:1726 with SMTP id 98e67ed59e1d1-2f782d9a1c9mr9872038a91.34.1737242183861;
 Sat, 18 Jan 2025 15:16:23 -0800 (PST)
Date: Sat, 18 Jan 2025 23:15:48 +0000
In-Reply-To: <20250118231549.1652825-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250118231549.1652825-3-jiaqiyan@google.com>
Subject: [RFC PATCH v1 2/3] selftests/mm: test userspace MFR for HugeTLB 1G hugepage
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, david@redhat.com, dave.hansen@linux.intel.com, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Tests the userspace memory failure recovery (MFR) policy for HugeTLB 1G
hugepage case:
1. Creates a memfd backed by 1G HugeTLB and had MFD_MF_KEEP_UE_MAPPED set.
2. Allocates and maps in a 1G hugepage to the process.
3. Creates sub-threads to MADV_HWPOISON inner addresses of the hugepage.
4. Checks if the process gets correct SIGBUS for each poisoned raw page.
5. Checks if all memory are still accessible and content valid.
6. Checks if the poisoned 1G hugepage is dealt with after memfd released.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/.gitignore    |   1 +
 tools/testing/selftests/mm/Makefile      |   1 +
 tools/testing/selftests/mm/hugetlb-mfr.c | 267 +++++++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb-mfr.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 121000c28c105..e65a1fa43f868 100644
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
index 63ce39d024bb5..171a9e65ed357 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -62,6 +62,7 @@ TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugetlb-madvise
 TEST_GEN_FILES += hugetlb-read-hwpoison
 TEST_GEN_FILES += hugetlb-soft-offline
+TEST_GEN_FILES += hugetlb-mfr
 TEST_GEN_FILES += hugepage-mmap
 TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
diff --git a/tools/testing/selftests/mm/hugetlb-mfr.c b/tools/testing/selftests/mm/hugetlb-mfr.c
new file mode 100644
index 0000000000000..cb20b81984f5e
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb-mfr.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Tests the userspace memory failure recovery (MFR) policy for HugeTLB 1G
+ * hugepage case:
+ * 1. Creates a memfd backed by 1G HugeTLB and MFD_MF_KEEP_UE_MAPPED bit set.
+ * 2. Allocates and maps a 1G hugepage.
+ * 3. Creates sub-threads to MADV_HWPOISON inner addresses of the hugepage.
+ * 4. Checks if the sub-thread get correct SIGBUS for each poisoned raw page.
+ * 5. Checks if all memory are still accessible and content still valid.
+ * 6. Checks if the poisoned 1G hugepage is dealt with after memfd released.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
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
+#define EPREFIX			" !!! "
+#define BYTE_LENTH_IN_1G	0x40000000
+#define HUGETLB_FILL		0xab
+
+static void *sigbus_addr;
+static int sigbus_addr_lsb;
+static bool expecting_sigbus;
+static bool got_sigbus;
+static bool was_mceerr;
+
+static int create_hugetlbfs_file(struct statfs *file_stat)
+{
+	int fd;
+	int flags = MFD_HUGETLB | MFD_HUGE_1GB | MFD_MF_KEEP_UE_MAPPED;
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
+	if (file_stat->f_bsize != BYTE_LENTH_IN_1G)
+		ksft_exit_fail_msg("Hugepage size is not 1G");
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
+static void test_hwpoison_multiple_pages(unsigned char *start_addr)
+{
+	pthread_t pthread;
+	int ret;
+	unsigned char *hwpoison_addr;
+	unsigned long offsets[] = {0x200000, 0x400000, 0x800000};
+
+	for (size_t i = 0; i < ARRAY_SIZE(offsets); ++i) {
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
+static void test_main(int fd, size_t len)
+{
+	unsigned char *map, *iter;
+	struct sigaction new, old;
+	const unsigned long hugepagesize_kb = BYTE_LENTH_IN_1G / 1024;
+	unsigned long nr_hugepages_before = 0;
+	unsigned long nr_hugepages_after = 0;
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
+	test_hwpoison_multiple_pages(map);
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
+int main(int argc, char **argv)
+{
+	int fd;
+	struct statfs file_stat;
+	size_t len = BYTE_LENTH_IN_1G;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	fd = create_hugetlbfs_file(&file_stat);
+	test_main(fd, len);
+
+	ksft_finished();
+}
-- 
2.48.0.rc2.279.g1de40edade-goog


