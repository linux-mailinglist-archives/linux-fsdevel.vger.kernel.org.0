Return-Path: <linux-fsdevel+bounces-68595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA78C60E8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 02:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E2534E14F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9CD221F11;
	Sun, 16 Nov 2025 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jg64IfIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C321578F
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763256752; cv=none; b=hRfGmZtBSGH+0F8XxXxeKidSzjO3rHP1HwfJWUfmM0hwm06XhfZdUIzSKBxt5OmVOE7CYZ+a5M9x467G2Rh7KGEvgsiQGbA5nyhqCYBEjLqWBfRwbnmv5qa2fKG7j/5YSC83svnArfMdivkKjxgPBYC33Zf1gs0qDcs9fkwGydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763256752; c=relaxed/simple;
	bh=PCIOkO5ppbzXdEAeBA969ux6NhoyW886ws0WVLWhjWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o7UdPjiSAfgmKuH9fef/7M5aEfA1pQJWxWbWdnSmsA9NmyUM46LKD0utKv7GLMtp45j+3oYFRVXLuEr7efMnrKpFOsMjIzMk45s+IgVZdG1PThIwj32cEzyE/yiN+yoIBurUPG7nxaTZfn8uJFz+EnoY825RLvYgFAYNN8zX9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jg64IfIx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340d3b1baafso6173093a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 17:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763256750; x=1763861550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8sO0/av5qDx17FrXuykncGViP/btoc/Aka3BNjQeG4g=;
        b=Jg64IfIxYtEtmH9xCCnIMGd/9o8dr6jJ2WYjArV251Hn1gPF3RBKw9IY6zl5Nidgs+
         VpS8ggI25YrVswEe9KO68ZjUCyjDcZwB25Oiy1Vy3f2sortoiFUOe1OPjK9O3LKvUdWL
         B5E3tuTFMIk4PovrZvf4SRXkgMKzYXgISmmEFny2nBnEGbzRdEnxxBcPdKpuzOvxzjcY
         Ia71mSQ20MEzsu1JCQcBQimon5jKeGKn5XMuwfWie+gI6/jdtMkNQ0w8C/qFVfaflZHt
         ZQCVNhZCQfnh0C4hnu3fBZ3iL+ooD4Ud+xvoTTUs/trm7Jchmx/9e94eFLV/ewsJc95e
         kVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763256750; x=1763861550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sO0/av5qDx17FrXuykncGViP/btoc/Aka3BNjQeG4g=;
        b=unkm0aOZcmUua2kdei2ZQ9zfCJ0n9conbNCGzhPZsEdAmGjKf+QunMh9Hh1VN0EyiA
         H6krCn9sFo4C2Dsh4xTXqMVCEMQPTkBE+26RcSy7H5ghEWELLvQscgHNdxTVhEB48OT+
         PWr7hSUO23fl0h3nS6iIqTXzu9uC2Ft67BCauUCTZaS/lxNbt0UtQxCHG5O4qrtUteDN
         03ViK83SCL3+7gMYtzFretIZ5l1EZgScpoyL81UpchS9Nggpf7ks58wD0DmBNiSAKmlw
         r+11riOtdyzhxUFPZYEEJWpmHvgCPcMmvuJgNF4MbF5bHdkp2SQ5wIV286xGjVXgmDKE
         WN4w==
X-Forwarded-Encrypted: i=1; AJvYcCUG38Ag7P9Vzh3EL/OXroXO75jZ5p7+0KwQq8YG9QvB/WJyqnSOanGojTBufX27XiNHTENNN38KtEBZdO+u@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgAEaxLyfi52N413e0s9Qpu55t6MvMvJ54UOZHLKAMYkJimr3
	a0wJDXLDusb0UYCS5HQgO8OpvjbXp2eqc4xI3nGgm+R2a+LvLwVrPKU2B+npIbyTpgWp4JUfCwN
	KTOluVbXciwGP2g==
X-Google-Smtp-Source: AGHT+IGPrzGeVqoTqtqjEJcCybfsqm0+GqgGVKnc5pKCVupFwE43PRD/+9yP6BR0ldp/cqiEfhQ5DucGRrs7yA==
X-Received: from pjbbr14.prod.google.com ([2002:a17:90b:f0e:b0:33b:52d6:e13e])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3501:b0:341:88c9:6eb2 with SMTP id 98e67ed59e1d1-343f9e94895mr7528629a91.1.1763256750116;
 Sat, 15 Nov 2025 17:32:30 -0800 (PST)
Date: Sun, 16 Nov 2025 01:32:22 +0000
In-Reply-To: <20251116013223.1557158-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116013223.1557158-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116013223.1557158-3-jiaqiyan@google.com>
Subject: [PATCH v2 2/3] selftests/mm: test userspace MFR for HugeTLB hugepage
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, william.roche@oracle.com, 
	harry.yoo@oracle.com
Cc: tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Test the userspace memory failure recovery (MFR) policy for HugeTLB
1G or 2M hugepage case:
1. Create a memfd backed by HugeTLB and had MFD_MF_KEEP_UE_MAPPED set.
2. Allocate and map 4 hugepages to the process.
3. Create sub-threads to MADV_HWPOISON inner addresses of one hugepage.
4. Check if the process gets correct SIGBUS for each poisoned raw page.
5. Check if all memory are still accessible and content valid.
6. Check if the poisoned hugepage is dealt with after memfd released.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/testing/selftests/mm/.gitignore    |   1 +
 tools/testing/selftests/mm/Makefile      |   1 +
 tools/testing/selftests/mm/hugetlb-mfr.c | 327 +++++++++++++++++++++++
 3 files changed, 329 insertions(+)
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
index eaf9312097f7b..de3bdcf7914cd 100644
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
diff --git a/tools/testing/selftests/mm/hugetlb-mfr.c b/tools/testing/selftests/mm/hugetlb-mfr.c
new file mode 100644
index 0000000000000..30939b2194188
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb-mfr.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Test the userspace memory failure recovery (MFR) policy for HugeTLB
+ * hugepage case:
+ * 1. Create a memfd backed by HugeTLB and MFD_MF_KEEP_UE_MAPPED bit set.
+ * 2. Allocate and map 4 hugepages.
+ * 3. Create sub-threads to MADV_HWPOISON inner addresses of one hugepage.
+ * 4. Check if each sub-thread get correct SIGBUS for the poisoned raw page.
+ * 5. Check if all memory are still accessible and content still valid.
+ * 6. Check if the poisoned hugepage is dealt with after memfd released.
+ *
+ * Two ways to run the test:
+ *   ./hugetlb-mfr 2M
+ * or
+ *   ./hugetlb-mfr 1G
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
+#define EPREFIX			" !!! "
+#define BYTE_LENTH_IN_1G	0x40000000UL
+#define BYTE_LENTH_IN_2M	0x200000UL
+#define HUGETLB_1GB_STR		"1G"
+#define HUGETLB_2MB_STR		"2M"
+#define HUGETLB_FILL		0xab
+
+static const unsigned long offsets_1g[] = {0x200000, 0x400000, 0x800000};
+static const unsigned long offsets_2m[] = {0x020000, 0x040000, 0x080000};
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
+	size_t offsets_count;
+	size_t i;
+
+	if (hugepage_size == BYTE_LENTH_IN_2M) {
+		offsets = offsets_2m;
+		offsets_count = ARRAY_SIZE(offsets_2m);
+	} else {
+		offsets = offsets_1g;
+		offsets_count = ARRAY_SIZE(offsets_1g);
+	}
+
+	for (i = 0; i < offsets_count; ++i) {
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
+int main(int argc, char **argv)
+{
+	int fd;
+	struct statfs file_stat;
+	unsigned long hugepage_size;
+
+	if (argc != 2) {
+		ksft_print_msg("Usage: %s <hugepage_size=1G|2M>\n", argv[0]);
+		return -EINVAL;
+	}
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	hugepage_size = parse_hugepage_size(argv[1]);
+	fd = create_hugetlbfs_file(&file_stat, hugepage_size);
+	test_main(fd, hugepage_size);
+
+	ksft_finished();
+}
-- 
2.52.0.rc1.455.g30608eb744-goog


