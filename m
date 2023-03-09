Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E736B262A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjCIOBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjCIOAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:00:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A52F5FE97;
        Thu,  9 Mar 2023 05:58:26 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.145.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 81DF0660304F;
        Thu,  9 Mar 2023 13:58:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678370305;
        bh=0x2f0hNy+Z3DgJ4eWDX3Xi46yrLYfMYa1RXt0Qt1hfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcTkk9HJEoyhuLBZ5TAlsIgco9qf8GDLkyjeAectLs/GbgFvmbN4MJl3zlT4HJRoz
         5boBSL0RA94JEwUVE6m/DqjXSD0Yxhrt/r4gp5CGQ+Bou7IKilv0gCpOPJfJ7oKcCx
         PIZKkXugzvgYwr+g6s1mpjBODTMUVy8QQ1bPsMM5FzM0dxDestqVMRI23JSw/OSsrv
         KDt+lmj5GmLTv4ZWxNCeBPDefsN7n9ALVn3c+NN+Ox8sLm1HnFRl9pggsFfb1S8hyp
         zL1IMRYAP5XvPOzOEl3ynGRfF1QkEpov3/eHU/osDmnM2fRKVkEaPCtRdNdibND9ZJ
         7PaafBOL8Re1Q==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v11 7/7] selftests: mm: add pagemap ioctl tests
Date:   Thu,  9 Mar 2023 18:57:18 +0500
Message-Id: <20230309135718.1490461-8-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309135718.1490461-1-usama.anjum@collabora.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add pagemap ioctl tests. Add several different types of tests to judge
the correction of the interface.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v11:
- Rebase on top of next-20230216 and update tests

Chages in v7:
- Add and update all test cases

Changes in v6:
- Rename variables

Changes in v4:
- Updated all the tests to conform to new IOCTL

Changes in v3:
- Add another test to do sanity of flags

Changes in v2:
- Update the tests to use the ioctl interface instead of syscall
---
 tools/testing/selftests/mm/.gitignore      |   1 +
 tools/testing/selftests/mm/Makefile        |   4 +-
 tools/testing/selftests/mm/config          |   1 +
 tools/testing/selftests/mm/pagemap_ioctl.c | 920 +++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh  |   4 +
 5 files changed, 929 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/mm/pagemap_ioctl.c
 mode change 100644 => 100755 tools/testing/selftests/mm/run_vmtests.sh

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 1f8c36a9fa10..9e7e0ae26582 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -17,6 +17,7 @@ mremap_dontunmap
 mremap_test
 on-fault-limit
 transhuge-stress
+pagemap_ioctl
 protection_keys
 protection_keys_32
 protection_keys_64
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index fbf5646b1072..9fcba8e87f28 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -30,7 +30,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
 MAKEFLAGS += --no-builtin-rules
 
 CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
-LDLIBS = -lrt -lpthread
+LDLIBS = -lrt -lpthread -lm
 TEST_GEN_FILES = cow
 TEST_GEN_FILES += compaction_test
 TEST_GEN_FILES += gup_test
@@ -56,6 +56,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_PROGS += pagemap_ioctl
 TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
@@ -108,6 +109,7 @@ $(OUTPUT)/cow: vm_util.c
 $(OUTPUT)/khugepaged: vm_util.c
 $(OUTPUT)/ksm_functional_tests: vm_util.c
 $(OUTPUT)/madv_populate: vm_util.c
+$(OUTPUT)/pagemap_ioctl: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
 $(OUTPUT)/userfaultfd: vm_util.c
diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
index be087c4bc396..4309916f629e 100644
--- a/tools/testing/selftests/mm/config
+++ b/tools/testing/selftests/mm/config
@@ -1,5 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_USERFAULTFD=y
+CONFIG_PTE_MARKER_UFFD_WP=y
 CONFIG_TEST_VMALLOC=m
 CONFIG_DEVICE_PRIVATE=y
 CONFIG_TEST_HMM=m
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
new file mode 100644
index 000000000000..f0fc43694472
--- /dev/null
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -0,0 +1,920 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <fcntl.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <malloc.h>
+#include "vm_util.h"
+#include "../kselftest.h"
+#include <linux/types.h>
+#include <linux/userfaultfd.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <math.h>
+#include <asm/unistd.h>
+
+#define PAGEMAP_BITS_ALL	(PAGE_IS_WRITTEN | PAGE_IS_FILE |	\
+				 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
+#define PAGEMAP_NON_WRITTEN_BITS	(PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
+				 PAGE_IS_SWAPPED)
+
+#define TEST_ITERATIONS 10
+#define PAGEMAP "/proc/self/pagemap"
+int pagemap_fd;
+int uffd;
+int page_size;
+int hpage_size;
+
+static long pagemap_ioctl(void *start, int len, void *vec, int vec_len, int flag,
+			  int max_pages, long required_mask, long anyof_mask, long excluded_mask,
+			  long return_mask)
+{
+	struct pm_scan_arg arg;
+
+	arg.start = (uintptr_t)start;
+	arg.len = len;
+	arg.vec = (uintptr_t)vec;
+	arg.vec_len = vec_len;
+	arg.flags = flag;
+	arg.size = sizeof(struct pm_scan_arg);
+	arg.max_pages = max_pages;
+	arg.required_mask = required_mask;
+	arg.anyof_mask = anyof_mask;
+	arg.excluded_mask = excluded_mask;
+	arg.return_mask = return_mask;
+
+	return ioctl(pagemap_fd, PAGEMAP_SCAN, &arg);
+}
+
+int init_uffd(void)
+{
+	struct uffdio_api uffdio_api;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd == -1)
+		ksft_exit_fail_msg("uffd syscall failed\n");
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = UFFD_FEATURE_WP_UNPOPULATED | UFFD_FEATURE_WP_ASYNC;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
+		ksft_exit_fail_msg("UFFDIO_API\n");
+
+	if (!(uffdio_api.api & UFFDIO_REGISTER_MODE_WP) ||
+	    !(uffdio_api.features & UFFD_FEATURE_WP_UNPOPULATED) ||
+	    !(uffdio_api.features & UFFD_FEATURE_WP_ASYNC))
+		ksft_exit_fail_msg("UFFDIO_API error %llu\n", uffdio_api.api);
+
+	return 0;
+}
+
+int wp_init(void *lpBaseAddress, int dwRegionSize)
+{
+	struct uffdio_register uffdio_register;
+	struct uffdio_writeprotect wp;
+
+	uffdio_register.range.start = (unsigned long)lpBaseAddress;
+	uffdio_register.range.len = dwRegionSize;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+		ksft_exit_fail_msg("ioctl(UFFDIO_REGISTER)\n");
+
+	if (!(uffdio_register.ioctls & UFFDIO_WRITEPROTECT))
+		ksft_exit_fail_msg("ioctl set is incorrect\n");
+
+	wp.range.start = (unsigned long)lpBaseAddress;
+	wp.range.len = dwRegionSize;
+	wp.mode = UFFDIO_WRITEPROTECT_MODE_WP;
+
+	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &wp))
+		ksft_exit_fail_msg("ioctl(UFFDIO_WRITEPROTECT)\n");
+
+	return 0;
+}
+
+int wp_free(void *lpBaseAddress, int dwRegionSize)
+{
+	struct uffdio_register uffdio_register;
+
+	uffdio_register.range.start = (unsigned long)lpBaseAddress;
+	uffdio_register.range.len = dwRegionSize;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
+	if (ioctl(uffd, UFFDIO_UNREGISTER, &uffdio_register.range))
+		ksft_exit_fail_msg("ioctl unregister failure\n");
+	return 0;
+}
+
+int wp_addr_range(void *lpBaseAddress, int dwRegionSize)
+{
+	struct uffdio_writeprotect wp;
+
+	wp.range.start = (unsigned long)lpBaseAddress;
+	wp.range.len = dwRegionSize;
+	wp.mode = UFFDIO_WRITEPROTECT_MODE_WP;
+
+	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &wp))
+		ksft_exit_fail_msg("ioctl(UFFDIO_WRITEPROTECT)\n");
+
+	return 0;
+}
+
+int userfaultfd_tests(void)
+{
+	int mem_size, vec_size, written, num_pages = 16;
+	char *mem, *vec;
+
+	mem_size = num_pages * page_size;
+	mem = mmap(NULL, mem_size, PROT_NONE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+
+	wp_init(mem, mem_size);
+
+	/* Change protection of pages differently */
+	mprotect(mem, mem_size/8, PROT_READ|PROT_WRITE);
+	mprotect(mem + 1 * mem_size/8, mem_size/8, PROT_READ);
+	mprotect(mem + 2 * mem_size/8, mem_size/8, PROT_READ|PROT_WRITE);
+	mprotect(mem + 3 * mem_size/8, mem_size/8, PROT_READ);
+	mprotect(mem + 4 * mem_size/8, mem_size/8, PROT_READ|PROT_WRITE);
+	mprotect(mem + 5 * mem_size/8, mem_size/8, PROT_NONE);
+	mprotect(mem + 6 * mem_size/8, mem_size/8, PROT_READ|PROT_WRITE);
+	mprotect(mem + 7 * mem_size/8, mem_size/8, PROT_READ);
+
+	wp_addr_range(mem + (mem_size/16), mem_size - 2 * (mem_size/8));
+	wp_addr_range(mem, mem_size);
+
+	vec_size = mem_size/page_size;
+	vec = malloc(sizeof(struct page_region) * vec_size);
+
+	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_OP_GET | PM_SCAN_OP_WP, vec_size - 2,
+			      PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	if (written < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+
+	ksft_test_result(written == 0, "%s all new pages must not be written (dirty)\n", __func__);
+
+	wp_free(mem, mem_size);
+	munmap(mem, mem_size);
+	free(vec);
+	return 0;
+}
+
+int sanity_tests_sd(void)
+{
+	char *mem, *m[2];
+	int mem_size, vec_size, ret, ret2, ret3, i, num_pages = 10;
+	struct page_region *vec;
+
+	vec_size = 100;
+	mem_size = num_pages * page_size;
+
+	vec = malloc(sizeof(struct page_region) * vec_size);
+	if (!vec)
+		ksft_exit_fail_msg("error nomem\n");
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+
+	wp_init(mem, mem_size);
+
+	/* 1. wrong operation */
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, -1,
+				       0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN) < 0,
+			 "%s wrong flag specified\n", __func__);
+
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 8,
+				       0, 0x1111, 0, 0, PAGE_IS_WRITTEN) < 0,
+			 "%s wrong mask specified\n", __func__);
+
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0,
+				       0, PAGE_IS_WRITTEN, 0, 0, 0x1000) < 0,
+			 "%s wrong return mask specified\n", __func__);
+
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size,
+				       PM_SCAN_OP_WP | PM_SCAN_OP_GET | 0x32,
+				       0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN) < 0,
+			 "%s mixture of correct and wrong flag\n", __func__);
+
+	ksft_test_result(pagemap_ioctl(mem, mem_size, NULL, 0, PM_SCAN_OP_WP,
+				       0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN) < 0,
+			 "%s PM_SCAN_OP_WP cannot be used without get\n", __func__);
+
+	/* 2. Clear area with larger vec size */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET | PM_SCAN_OP_WP, 0,
+			    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	ksft_test_result(ret >= 0, "%s Clear area with larger vec size\n", __func__);
+
+	/* 3. Repeated pattern of written and non-written pages */
+	for (i = 0; i < mem_size; i += 2 * page_size)
+		mem[i]++;
+
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0, PAGE_IS_WRITTEN, 0,
+			    0, PAGE_IS_WRITTEN);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == mem_size/(page_size * 2),
+			 "%s Repeated pattern of written and non-written pages\n", __func__);
+
+	/* 4. Repeated pattern of written and non-written pages in parts */
+	ret = pagemap_ioctl(mem, mem_size, vec, num_pages/5, PM_SCAN_OP_GET | PM_SCAN_OP_WP,
+			    num_pages/2 - 2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ret2 = pagemap_ioctl(mem, mem_size, vec, 2, PM_SCAN_OP_GET, 0, PAGE_IS_WRITTEN, 0, 0,
+			     PAGE_IS_WRITTEN);
+	if (ret2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret2, errno, strerror(errno));
+
+	ret3 = pagemap_ioctl(mem, mem_size, vec, num_pages/2, PM_SCAN_OP_GET, 0, PAGE_IS_WRITTEN,
+			     0, 0, PAGE_IS_WRITTEN);
+	if (ret3 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret3, errno, strerror(errno));
+
+	ksft_test_result((ret + ret3) == num_pages/2 && ret2 == 2,
+			 "%s Repeated pattern of written and non-written pages in parts\n",
+			 __func__);
+
+	wp_free(mem, mem_size);
+	munmap(mem, mem_size);
+
+	/* 5. Two regions */
+	m[0] = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (m[0] == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+	m[1] = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (m[1] == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+
+	wp_init(m[0], mem_size);
+	wp_init(m[1], mem_size);
+
+	memset(m[0], 'a', mem_size);
+	memset(m[1], 'b', mem_size);
+
+	wp_addr_range(m[0], mem_size);
+
+	ret = pagemap_ioctl(m[1], mem_size, vec, 1, PM_SCAN_OP_GET, 0, PAGE_IS_WRITTEN, 0, 0,
+			    PAGE_IS_WRITTEN);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && vec[0].len == mem_size/page_size,
+			 "%s Two regions\n", __func__);
+
+	wp_free(m[0], mem_size);
+	wp_free(m[1], mem_size);
+	munmap(m[0], mem_size);
+	munmap(m[1], mem_size);
+
+	free(vec);
+	return 0;
+}
+
+int base_tests(char *prefix, char *mem, int mem_size, int skip)
+{
+	int vec_size, ret, written, written2;
+	struct page_region *vec, *vec2;
+
+	if (skip) {
+		ksft_test_result_skip("%s all new pages must not be written (dirty)\n", prefix);
+		ksft_test_result_skip("%s all pages must be written (dirty)\n", prefix);
+		ksft_test_result_skip("%s all pages dirty other than first and the last one\n",
+				      prefix);
+		ksft_test_result_skip("%s only middle page dirty\n", prefix);
+		ksft_test_result_skip("%s only two middle pages dirty\n", prefix);
+		ksft_test_result_skip("%s only get 2 dirty pages and clear them as well\n", prefix);
+		ksft_test_result_skip("%s Range clear only\n", prefix);
+		return 0;
+	}
+
+	vec_size = mem_size/page_size;
+	vec = malloc(sizeof(struct page_region) * vec_size);
+	vec2 = malloc(sizeof(struct page_region) * vec_size);
+
+	/* 1. all new pages must be not be written (dirty) */
+	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_OP_GET | PM_SCAN_OP_WP, vec_size - 2,
+			      PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	if (written < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+
+	ksft_test_result(written == 0, "%s all new pages must not be written (dirty)\n", prefix);
+
+	/* 2. all pages must be written */
+	memset(mem, -1, mem_size);
+
+	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_OP_GET, 0, PAGE_IS_WRITTEN, 0, 0,
+			      PAGE_IS_WRITTEN);
+	if (written < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+
+	ksft_test_result(written == 1 && vec[0].len == mem_size/page_size,
+			 "%s all pages must be written (dirty)\n", prefix);
+
+	/* 3. all pages dirty other than first and the last one */
+	wp_addr_range(mem, mem_size);
+	memset(mem + page_size, 0, mem_size - (2 * page_size));
+
+	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_OP_GET, 0, PAGE_IS_WRITTEN, 0, 0,
+			      PAGE_IS_WRITTEN);
+	if (written < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+
+	ksft_test_result(written == 1 && vec[0].len >= vec_size - 2 && vec[0].len <= vec_size,
+			 "%s all pages dirty other than first and the last one\n", prefix);
+
+	/* 4. only middle page dirty */
+	wp_addr_range(mem, mem_size);
+	mem[vec_size/2 * page_size]++;
+
+	written = pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0, PAGE_IS_WRITTEN,
+				0, 0, PAGE_IS_WRITTEN);
+	if (written < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+
+	ksft_test_result(written == 1 && vec[0].len >= 1,
+			 "%s only middle page dirty\n", prefix);
+
+	/* 5. only two middle pages dirty and walk over only middle pages */
+	wp_addr_range(mem, mem_size);
+	mem[vec_size/2 * page_size]++;
+	mem[(vec_size/2 + 1) * page_size]++;
+
+	written = pagemap_ioctl(&mem[vec_size/2 * page_size], 2 * page_size, vec, 1, PM_SCAN_OP_GET,
+				0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	if (written < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+
+	ksft_test_result(written == 1 && vec[0].start == (uintptr_t)(&mem[vec_size/2 * page_size])
+			 && vec[0].len == 2,
+			 "%s only two middle pages dirty\n", prefix);
+
+	/* 6. only get 2 dirty pages and clear them as well */
+	memset(mem, -1, mem_size);
+
+	/* get and clear second and third pages */
+	ret = pagemap_ioctl(mem + page_size, 2 * page_size, vec, 1, PM_SCAN_OP_GET | PM_SCAN_OP_WP,
+			    2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	written = pagemap_ioctl(mem, mem_size, vec2, vec_size, PM_SCAN_OP_GET, 0,
+			      PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	if (written < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && vec[0].len == 2 &&
+			 vec[0].start == (uintptr_t)(mem + page_size) &&
+			 written == 2 && vec2[0].len == 1 && vec2[0].start == (uintptr_t)mem &&
+			 vec2[1].len == vec_size - 3 &&
+			 vec2[1].start == (uintptr_t)(mem + 3 * page_size),
+			 "%s only get 2 written pages and clear them as well\n", prefix);
+
+	/* 7. Range clear only */
+	memset(mem, -1, mem_size);
+
+	wp_addr_range(mem, mem_size);
+
+	written2 = pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+			       PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+	if (written2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", written2, errno, strerror(errno));
+
+	ksft_test_result(written2 == 0, "%s Range clear only\n",
+			 prefix);
+
+	free(vec);
+	free(vec2);
+	return 0;
+}
+
+void *gethugepage(int map_size)
+{
+	int ret;
+	char *map;
+
+	map = memalign(hpage_size, map_size);
+	if (!map)
+		ksft_exit_fail_msg("memalign failed %d %s\n", errno, strerror(errno));
+
+	ret = madvise(map, map_size, MADV_HUGEPAGE);
+	if (ret)
+		ksft_exit_fail_msg("madvise failed %d %d %s\n", ret, errno, strerror(errno));
+
+	wp_init(map, map_size);
+
+	return map;
+}
+
+int hpage_unit_tests(void)
+{
+	char *map;
+	int ret;
+	size_t num_pages = 10;
+	int map_size = hpage_size * num_pages;
+	int vec_size = map_size/page_size;
+	struct page_region *vec, *vec2;
+
+	vec = malloc(sizeof(struct page_region) * vec_size);
+	vec2 = malloc(sizeof(struct page_region) * vec_size);
+	if (!vec || !vec2)
+		ksft_exit_fail_msg("malloc failed\n");
+
+	map = gethugepage(map_size);
+	if (map) {
+		/* 1. all new huge page must not be written (dirty) */
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PM_SCAN_OP_GET | PM_SCAN_OP_WP, 0,
+				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 0, "%s all new huge page must not be written (dirty)\n",
+				 __func__);
+
+		/* 2. all the huge page must not be written */
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 0, "%s all the huge page must not be written\n", __func__);
+
+		/* 3. all the huge page must be written and clear dirty as well */
+		memset(map, -1, map_size);
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PM_SCAN_OP_GET | PM_SCAN_OP_WP, 0,
+				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].start == (uintptr_t)map &&
+				 vec[0].len == vec_size && vec[0].bitmap == PAGE_IS_WRITTEN,
+				 "%s all the huge page must be written and clear\n", __func__);
+
+		/* 4. only middle page written */
+		wp_free(map, map_size);
+		free(map);
+		map = gethugepage(map_size);
+		wp_init(map, map_size);
+		wp_addr_range(map, map_size);
+		map[vec_size/2 * page_size]++;
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].len > 0,
+				 "%s only middle page written\n", __func__);
+
+		wp_free(map, map_size);
+		free(map);
+	} else {
+		ksft_test_result_skip("all new huge page must be written\n");
+		ksft_test_result_skip("all the huge page must not be written\n");
+		ksft_test_result_skip("all the huge page must be written and clear\n");
+		ksft_test_result_skip("only middle page written\n");
+	}
+
+	/* 5. clear first half of huge page */
+	map = gethugepage(map_size);
+	if (map) {
+
+		memset(map, 0, map_size);
+
+		wp_addr_range(map, map_size/2);
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].len == vec_size/2 &&
+				 vec[0].start == (uintptr_t)(map + map_size/2),
+				 "%s clear first half of huge page\n", __func__);
+		wp_free(map, map_size);
+		free(map);
+	} else {
+		ksft_test_result_skip("clear first half of huge page\n");
+	}
+
+	/* 6. clear first half of huge page with limited buffer */
+	map = gethugepage(map_size);
+	if (map) {
+		memset(map, 0, map_size);
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PM_SCAN_OP_GET | PM_SCAN_OP_WP,
+				    vec_size/2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].len == vec_size/2 &&
+				 vec[0].start == (uintptr_t)(map + map_size/2),
+				 "%s clear first half of huge page with limited buffer\n",
+				 __func__);
+		wp_free(map, map_size);
+		free(map);
+	} else {
+		ksft_test_result_skip("clear first half of huge page with limited buffer\n");
+	}
+
+	/* 7. clear second half of huge page */
+	map = gethugepage(map_size);
+	if (map) {
+		memset(map, -1, map_size);
+
+		wp_addr_range(map + map_size/2, map_size/2);
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].len == vec_size/2,
+				 "%s clear second half huge page\n", __func__);
+		wp_free(map, map_size);
+		free(map);
+	} else {
+		ksft_test_result_skip("clear second half huge page\n");
+	}
+
+	/* 8. get half huge page */
+	map = gethugepage(map_size);
+	if (map) {
+		memset(map, -1, map_size);
+
+		ret = pagemap_ioctl(map, map_size, vec, 1, PM_SCAN_OP_GET, hpage_size/(2*page_size),
+				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].len == hpage_size/(2*page_size),
+				 "%s get half huge page\n", __func__);
+		wp_free(map, map_size);
+		free(map);
+	} else {
+		ksft_test_result_skip("get half huge page\n");
+	}
+
+	free(vec);
+	free(vec2);
+	return 0;
+}
+
+int unmapped_region_tests(void)
+{
+	void *start = (void *)0x10000000;
+	int written, len = 0x00040000;
+	int vec_size = len / page_size;
+	struct page_region *vec = malloc(sizeof(struct page_region) * vec_size);
+
+	/* 1. Get written pages */
+	written = pagemap_ioctl(start, len, vec, vec_size, PM_SCAN_OP_GET, 0,
+			      PAGEMAP_NON_WRITTEN_BITS, 0, 0, PAGEMAP_NON_WRITTEN_BITS);
+	if (written < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+
+	ksft_test_result(written >= 0, "%s Get status of pages\n", __func__);
+
+	free(vec);
+	return 0;
+}
+
+static void test_simple(void)
+{
+	int i;
+	char *map;
+	struct page_region vec;
+
+	map = aligned_alloc(page_size, page_size);
+	if (!map)
+		ksft_exit_fail_msg("aligned_alloc failed\n");
+	wp_init(map, page_size);
+
+	wp_addr_range(map, page_size);
+
+	for (i = 0 ; i < TEST_ITERATIONS; i++) {
+		if (pagemap_ioctl(map, page_size, &vec, 1, PM_SCAN_OP_GET, 0,
+				  PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN) == 1) {
+			ksft_print_msg("written bit was 1, but should be 0 (i=%d)\n", i);
+			break;
+		}
+
+		wp_addr_range(map, page_size);
+		/* Write something to the page to get the written bit enabled on the page */
+		map[0]++;
+
+		if (pagemap_ioctl(map, page_size, &vec, 1, PM_SCAN_OP_GET, 0,
+				  PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN) == 0) {
+			ksft_print_msg("written bit was 0, but should be 1 (i=%d)\n", i);
+			break;
+		}
+
+		wp_addr_range(map, page_size);
+	}
+	wp_free(map, page_size);
+	free(map);
+
+	ksft_test_result(i == TEST_ITERATIONS, "Test %s\n", __func__);
+}
+
+int sanity_tests(void)
+{
+	char *mem, *fmem;
+	int mem_size, vec_size, ret;
+	struct page_region *vec;
+
+	/* 1. wrong operation */
+	mem_size = 10 * page_size;
+	vec_size = mem_size / page_size;
+
+	vec = malloc(sizeof(struct page_region) * vec_size);
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED || vec == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+
+	wp_init(mem, mem_size);
+
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size,
+				       PM_SCAN_OP_GET | PM_SCAN_OP_WP, 0, PAGEMAP_BITS_ALL, 0, 0,
+				       PAGEMAP_BITS_ALL) < 0,
+			 "%s clear op can only be specified with PAGE_IS_WRITTEN\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+				       PAGEMAP_BITS_ALL, 0, 0, PAGEMAP_BITS_ALL) >= 0,
+			 "%s required_mask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+				       0, PAGEMAP_BITS_ALL, 0, PAGEMAP_BITS_ALL) >= 0,
+			 "%s anyof_mask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+				       0, 0, PAGEMAP_BITS_ALL, PAGEMAP_BITS_ALL) >= 0,
+			 "%s excluded_mask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+				       PAGEMAP_BITS_ALL, PAGEMAP_BITS_ALL, 0,
+				       PAGEMAP_BITS_ALL) >= 0,
+			 "%s required_mask and anyof_mask specified\n", __func__);
+	wp_free(mem, mem_size);
+	munmap(mem, mem_size);
+
+	/* 2. Get sd and present pages with anyof_mask */
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+	wp_init(mem, mem_size);
+
+	memset(mem, 0, mem_size);
+
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+			    0, PAGEMAP_BITS_ALL, 0, PAGEMAP_BITS_ALL);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == (PAGE_IS_WRITTEN | PAGE_IS_PRESENT),
+			 "%s Get sd and present pages with anyof_mask\n", __func__);
+
+	/* 3. Get sd and present pages with required_mask */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+			    PAGEMAP_BITS_ALL, 0, 0, PAGEMAP_BITS_ALL);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == (PAGE_IS_WRITTEN | PAGE_IS_PRESENT),
+			 "%s Get all the pages with required_mask\n", __func__);
+
+	/* 4. Get sd and present pages with required_mask and anyof_mask */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+			    PAGE_IS_WRITTEN, PAGE_IS_PRESENT, 0, PAGEMAP_BITS_ALL);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == (PAGE_IS_WRITTEN | PAGE_IS_PRESENT),
+			 "%s Get sd and present pages with required_mask and anyof_mask\n",
+			 __func__);
+
+	/* 5. Don't get sd pages */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+			    0, 0, PAGE_IS_WRITTEN, PAGEMAP_BITS_ALL);
+	ksft_test_result(ret == 0, "%s Don't get sd pages\n", __func__);
+
+	/* 6. Don't get present pages */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+			    0, 0, PAGE_IS_PRESENT, PAGEMAP_BITS_ALL);
+	ksft_test_result(ret == 0, "%s Don't get present pages\n", __func__);
+
+	wp_free(mem, mem_size);
+	munmap(mem, mem_size);
+
+	/* 8. Find written present pages with return mask */
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+	wp_init(mem, mem_size);
+
+	memset(mem, 0, mem_size);
+
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+			    0, PAGEMAP_BITS_ALL, 0, PAGE_IS_WRITTEN);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == PAGE_IS_WRITTEN,
+			 "%s Find written present pages with return mask\n", __func__);
+	wp_free(mem, mem_size);
+	munmap(mem, mem_size);
+
+	/* 9. Memory mapped file */
+	int fd;
+	struct stat sbuf;
+
+	fd = open(__FILE__, O_RDONLY);
+	if (fd < 0) {
+		ksft_test_result_skip("%s Memory mapped file\n");
+		goto free_vec_and_return;
+	}
+
+	ret = stat(__FILE__, &sbuf);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	fmem = mmap(NULL, sbuf.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (fmem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem %ld %s\n", errno, strerror(errno));
+
+	ret = pagemap_ioctl(fmem, sbuf.st_size, vec, vec_size, PM_SCAN_OP_GET, 0,
+			    0, PAGEMAP_NON_WRITTEN_BITS, 0, PAGEMAP_NON_WRITTEN_BITS);
+
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)fmem &&
+			 vec[0].len == ceilf((float)sbuf.st_size/page_size) &&
+			 vec[0].bitmap == PAGE_IS_FILE,
+			 "%s Memory mapped file\n", __func__);
+
+	munmap(fmem, sbuf.st_size);
+	close(fd);
+
+free_vec_and_return:
+	free(vec);
+	return 0;
+}
+
+int mprotect_tests(void)
+{
+	int ret;
+	char *mem, *mem2;
+	struct page_region vec;
+	int pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+
+	if (pagemap_fd < 0) {
+		fprintf(stderr, "open() failed\n");
+		exit(1);
+	}
+
+	/* 1. Map two pages */
+	mem = mmap(0, 2 * page_size, PROT_READ|PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+	wp_init(mem, 2 * page_size);
+
+	/* Populate both pages. */
+	memset(mem, 1, 2 * page_size);
+
+	ret = pagemap_ioctl(mem, 2 * page_size, &vec, 1, PM_SCAN_OP_GET, 0, PAGE_IS_WRITTEN,
+			    0, 0, PAGE_IS_WRITTEN);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && vec.len == 2, "%s Both pages written\n", __func__);
+
+	/* 2. Start tracking */
+	wp_addr_range(mem, 2 * page_size);
+
+	ksft_test_result(pagemap_ioctl(mem, 2 * page_size, &vec, 1, PM_SCAN_OP_GET, 0,
+				       PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN) == 0,
+			 "%s Both pages are not written (dirty)\n", __func__);
+
+	/* 3. Remap the second page */
+	mem2 = mmap(mem + page_size, page_size, PROT_READ|PROT_WRITE,
+		    MAP_PRIVATE|MAP_ANON|MAP_FIXED, -1, 0);
+	if (mem2 == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+	wp_init(mem2, page_size);
+
+	/* Protect + unprotect. */
+	mprotect(mem, page_size, PROT_NONE);
+	mprotect(mem, 2 * page_size, PROT_READ);
+	mprotect(mem, 2 * page_size, PROT_READ|PROT_WRITE);
+
+	/* Modify both pages. */
+	memset(mem, 2, 2 * page_size);
+
+	/* Protect + unprotect. */
+	mprotect(mem, page_size, PROT_NONE);
+	mprotect(mem, page_size, PROT_READ);
+	mprotect(mem, page_size, PROT_READ|PROT_WRITE);
+
+	ret = pagemap_ioctl(mem, 2 * page_size, &vec, 1, PM_SCAN_OP_GET, 0, PAGE_IS_WRITTEN,
+			    0, 0, PAGE_IS_WRITTEN);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && vec.len == 2,
+			 "%s Both pages written after remap and mprotect\n", __func__);
+
+	/* 4. Clear and make the pages written */
+	wp_addr_range(mem, 2 * page_size);
+
+	memset(mem, 'A', 2 * page_size);
+
+	ret = pagemap_ioctl(mem, 2 * page_size, &vec, 1, PM_SCAN_OP_GET, 0, PAGE_IS_WRITTEN,
+			    0, 0, PAGE_IS_WRITTEN);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && vec.len == 2,
+			 "%s Clear and make the pages written\n", __func__);
+
+	wp_free(mem, 2 * page_size);
+	munmap(mem, 2 * page_size);
+	return 0;
+}
+
+int main(void)
+{
+	char *mem, *map;
+	int mem_size;
+
+	ksft_print_header();
+	ksft_set_plan(57);
+
+	page_size = getpagesize();
+	hpage_size = read_pmd_pagesize();
+
+	pagemap_fd = open(PAGEMAP, O_RDWR);
+	if (pagemap_fd < 0)
+		return -EINVAL;
+
+	if (init_uffd())
+		ksft_exit_fail_msg("uffd init failed\n");
+
+	/*
+	 * Written (dirty) PTE bit tests
+	 */
+
+	/* 1. Sanity testing */
+	sanity_tests_sd();
+
+	/* 2. Normal page testing */
+	mem_size = 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+	wp_init(mem, mem_size);
+
+	base_tests("Page testing:", mem, mem_size, 0);
+
+	wp_free(mem, mem_size);
+	munmap(mem, mem_size);
+
+	/* 3. Large page testing */
+	mem_size = 512 * 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+	wp_init(mem, mem_size);
+
+	base_tests("Large Page testing:", mem, mem_size, 0);
+
+	wp_free(mem, mem_size);
+	munmap(mem, mem_size);
+
+	/* 4. Huge page testing */
+	map = gethugepage(hpage_size);
+	if (map) {
+		base_tests("Huge page testing:", map, hpage_size, 0);
+		wp_free(map, hpage_size);
+		free(map);
+	} else {
+		base_tests("Huge page testing:", NULL, 0, 1);
+	}
+
+	/* 6. Huge page tests */
+	hpage_unit_tests();
+
+	/* 7. Iterative test */
+	test_simple();
+
+	/* 8. Mprotect test */
+	mprotect_tests();
+
+	/*
+	 * Other PTE bit tests
+	 */
+
+	/* 1. Sanity testing */
+	sanity_tests();
+
+	/* 2. Unmapped address test */
+	unmapped_region_tests();
+
+	/* 3. Userfaultfd tests */
+	userfaultfd_tests();
+
+	close(pagemap_fd);
+	return ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
old mode 100644
new mode 100755
index 8984e0bb58c7..f7e1370cc581
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -50,6 +50,8 @@ separated by spaces:
 	memory protection key tests
 - soft_dirty
 	test soft dirty page bit semantics
+- pagemap
+	test pagemap_scan IOCTL
 - cow
 	test copy-on-write semantics
 example: ./run_vmtests.sh -t "hmm mmap ksm"
@@ -268,6 +270,8 @@ fi
 
 CATEGORY="soft_dirty" run_test ./soft-dirty
 
+CATEGORY="pagemap" run_test ./pagemap_ioctl
+
 # COW tests
 CATEGORY="cow" run_test ./cow
 
-- 
2.39.2

