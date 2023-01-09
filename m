Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950D2661ED1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 07:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbjAIGrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 01:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbjAIGq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:46:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A82712767;
        Sun,  8 Jan 2023 22:46:44 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.24.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE84D6602D52;
        Mon,  9 Jan 2023 06:46:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673246803;
        bh=udTHgMSkizavWzpOjmfViYOsyZHjlSYHhoe8mo1WZXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TKRh6jo2QVioC6jpOuUQX0x4Odm2L6UyZTtbLsfU2sYmwswbpmw7q4/HTGoe4IujY
         TxBfyPYUNApWvuI/lB+eKSEx2tP1aWRMHrRlQMPRreCmb+JC70OGjLPZiB3HSar3xN
         K7/sueYthams0mlnhnw7//JdwpB+cwbcvUTtuDkiviAqupSxv9Jdhj4KbCzDJfhrBE
         1eSWoRERQb1Y99szHLi6K4yKzqUHAN3dOPZxGcMN//PhD0bh9mY+1QAABORgIb8QE/
         jNSG5AtC6/1eqnXdhJGnQZeZjZmrLMbpbrtwubavSdBFeLpXJQ5EA/WQs6KXQh2Id1
         eUPcGxqTXN0VA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v7 4/4] selftests: vm: add pagemap ioctl tests
Date:   Mon,  9 Jan 2023 11:45:19 +0500
Message-Id: <20230109064519.3555250-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230109064519.3555250-1-usama.anjum@collabora.com>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
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

TAP version 13
1..54
ok 1 sanity_tests_sd wrong flag specified
ok 2 sanity_tests_sd wrong mask specified
ok 3 sanity_tests_sd wrong return mask specified
ok 4 sanity_tests_sd mixture of correct and wrong flag
ok 5 sanity_tests_sd Clear area with larger vec size
ok 6 sanity_tests_sd Repeated pattern of dirty and non-dirty pages
ok 7 sanity_tests_sd Repeated pattern of dirty and non-dirty pages in parts
ok 8 sanity_tests_sd Two regions
ok 9 Page testing: all new pages must be soft dirty
ok 10 Page testing: all pages must not be soft dirty
ok 11 Page testing: all pages dirty other than first and the last one
ok 12 Page testing: only middle page dirty
ok 13 Page testing: only two middle pages dirty
ok 14 Page testing: only get 2 dirty pages and clear them as well
ok 15 Page testing: Range clear only
ok 16 Large Page testing: all new pages must be soft dirty
ok 17 Large Page testing: all pages must not be soft dirty
ok 18 Large Page testing: all pages dirty other than first and the last one
ok 19 Large Page testing: only middle page dirty
ok 20 Large Page testing: only two middle pages dirty
ok 21 Large Page testing: only get 2 dirty pages and clear them as well
ok 22 Large Page testing: Range clear only
ok 23 Huge page testing: all new pages must be soft dirty
ok 24 Huge page testing: all pages must not be soft dirty
ok 25 Huge page testing: all pages dirty other than first and the last one
ok 26 Huge page testing: only middle page dirty
ok 27 Huge page testing: only two middle pages dirty
ok 28 Huge page testing: only get 2 dirty pages and clear them as well
ok 29 Huge page testing: Range clear only
ok 30 hpage_unit_tests all new huge page must be dirty
ok 31 hpage_unit_tests all the huge page must not be dirty
ok 32 hpage_unit_tests all the huge page must be dirty and clear
ok 33 hpage_unit_tests only middle page dirty
ok 34 hpage_unit_tests clear first half of huge page
ok 35 hpage_unit_tests clear first half of huge page with limited buffer
ok 36 hpage_unit_tests clear second half huge page
ok 37 Test test_simple
ok 38 mprotect_tests Both pages dirty
ok 39 mprotect_tests Both pages are not soft dirty
ok 40 mprotect_tests Both pages dirty after remap and mprotect
ok 41 mprotect_tests Clear and make the pages dirty
ok 42 sanity_tests clear op can only be specified with PAGE_IS_WT
ok 43 sanity_tests required_mask specified
ok 44 sanity_tests anyof_mask specified
ok 45 sanity_tests excluded_mask specified
ok 46 sanity_tests required_mask and anyof_mask specified
ok 47 sanity_tests Get sd and present pages with anyof_mask
ok 48 sanity_tests Get all the pages with required_mask
ok 49 sanity_tests Get sd and present pages with required_mask and anyof_mask
ok 50 sanity_tests Don't get sd pages
ok 51 sanity_tests Don't get present pages
ok 52 sanity_tests Find dirty present pages with return mask
ok 53 sanity_tests Memory mapped file
ok 54 unmapped_region_tests Get status of pages
 # Totals: pass:54 fail:0 xfail:0 xpass:0 skip:0 error:0
---
 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   5 +-
 tools/testing/selftests/vm/pagemap_ioctl.c | 884 +++++++++++++++++++++
 3 files changed, 888 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pagemap_ioctl.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 1f8c36a9fa10..9e7e0ae26582 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -17,6 +17,7 @@ mremap_dontunmap
 mremap_test
 on-fault-limit
 transhuge-stress
+pagemap_ioctl
 protection_keys
 protection_keys_32
 protection_keys_64
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 89c14e41bd43..54c074440a1b 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -24,9 +24,8 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
 # things despite using incorrect values such as an *occasionally* incomplete
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules
-
 CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
-LDLIBS = -lrt -lpthread
+LDLIBS = -lrt -lpthread -lm
 TEST_GEN_FILES = cow
 TEST_GEN_FILES += compaction_test
 TEST_GEN_FILES += gup_test
@@ -52,6 +51,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_PROGS += pagemap_ioctl
 TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
@@ -103,6 +103,7 @@ $(OUTPUT)/cow: vm_util.c
 $(OUTPUT)/khugepaged: vm_util.c
 $(OUTPUT)/ksm_functional_tests: vm_util.c
 $(OUTPUT)/madv_populate: vm_util.c
+$(OUTPUT)/pagemap_ioctl: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
 $(OUTPUT)/userfaultfd: vm_util.c
diff --git a/tools/testing/selftests/vm/pagemap_ioctl.c b/tools/testing/selftests/vm/pagemap_ioctl.c
new file mode 100644
index 000000000000..668faa042e76
--- /dev/null
+++ b/tools/testing/selftests/vm/pagemap_ioctl.c
@@ -0,0 +1,884 @@
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
+#define PAGEMAP_OP_MASK		(PAGE_IS_WT | PAGE_IS_FILE |	\
+				 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
+#define PAGEMAP_NON_WT_MASK	(PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
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
+	struct pagemap_scan_arg arg;
+	int ret;
+
+	arg.start = (uintptr_t)start;
+	arg.len = len;
+	arg.vec = (uintptr_t)vec;
+	arg.vec_len = vec_len;
+	arg.flags = flag;
+	arg.max_pages = max_pages;
+	arg.required_mask = required_mask;
+	arg.anyof_mask = anyof_mask;
+	arg.excluded_mask = excluded_mask;
+	arg.return_mask = return_mask;
+
+	ret = ioctl(pagemap_fd, PAGEMAP_SCAN, &arg);
+
+	return ret;
+}
+
+int init_uffd(void)
+{
+	struct uffdio_api uffdio_api;
+
+	uffd = syscall(323, O_CLOEXEC | O_NONBLOCK);
+	if (uffd == -1)
+		ksft_exit_fail_msg("uffd syscall failed\n");
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
+		ksft_exit_fail_msg("UFFDIO_API\n");
+
+	if (uffdio_api.api != UFFD_API)
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
+	/* TODO: can it be avoided? Write protect doesn't engage on the pages if they aren't
+	 * present already. The pages can be made present by writing to them.
+	 */
+	memset(lpBaseAddress, -1, dwRegionSize);
+
+	uffdio_register.range.start = (unsigned long)lpBaseAddress;
+	uffdio_register.range.len = dwRegionSize;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
+		ksft_exit_fail_msg("ioctl(UFFDIO_REGISTER)\n");
+
+	if (!(uffdio_register.ioctls & UFFDIO_WRITEPROTECT))
+		ksft_exit_fail_msg("ioctl set is incorrect\n");
+
+	if (rand() % 2) {
+		wp.range.start = (unsigned long)lpBaseAddress;
+		wp.range.len = dwRegionSize;
+		wp.mode = UFFDIO_WRITEPROTECT_MODE_ASYNC_WP;
+
+		if (ioctl(uffd, UFFDIO_WRITEPROTECT, &wp) == -1)
+			ksft_exit_fail_msg("ioctl(UFFDIO_WRITEPROTECT)\n");
+	} else {
+		if (pagemap_ioctl(lpBaseAddress, dwRegionSize, NULL, 0, PAGEMAP_WP_ENGAGE, 0,
+				  0, 0, 0, 0) < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", 1, errno, strerror(errno));
+	}
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
+int clear_softdirty_wp(void *lpBaseAddress, int dwRegionSize)
+{
+	struct uffdio_writeprotect wp;
+
+	if (rand() % 2) {
+		wp.range.start = (unsigned long)lpBaseAddress;
+		wp.range.len = dwRegionSize;
+		wp.mode = UFFDIO_WRITEPROTECT_MODE_ASYNC_WP;
+
+		if (ioctl(uffd, UFFDIO_WRITEPROTECT, &wp) == -1)
+			ksft_exit_fail_msg("ioctl(UFFDIO_WRITEPROTECT)\n");
+	} else {
+		if (pagemap_ioctl(lpBaseAddress, dwRegionSize, NULL, 0, PAGEMAP_WP_ENGAGE, 0,
+				  0, 0, 0, 0) < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", 1, errno, strerror(errno));
+	}
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
+				       0, PAGE_IS_WT, 0, 0, PAGE_IS_WT) < 0,
+			 "%s wrong flag specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 8,
+				       0, 0x1111, 0, 0, PAGE_IS_WT) < 0,
+			 "%s wrong mask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0,
+				       0, PAGE_IS_WT, 0, 0, 0x1000) < 0,
+			 "%s wrong return mask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size,
+				       PAGEMAP_WP_ENGAGE | 0x32,
+				       0, PAGE_IS_WT, 0, 0, PAGE_IS_WT) < 0,
+			 "%s mixture of correct and wrong flag\n", __func__);
+
+	/* 2. Clear area with larger vec size */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, PAGEMAP_WP_ENGAGE, 0,
+			    PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+	ksft_test_result(ret >= 0, "%s Clear area with larger vec size\n", __func__);
+
+	/* 3. Repeated pattern of dirty and non-dirty pages */
+	for (i = 0; i < mem_size; i += 2 * page_size)
+		mem[i]++;
+
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0, PAGE_IS_WT, 0, 0,
+			    PAGE_IS_WT);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == mem_size/(page_size * 2),
+			 "%s Repeated pattern of dirty and non-dirty pages\n", __func__);
+
+	/* 4. Repeated pattern of dirty and non-dirty pages in parts */
+	ret = pagemap_ioctl(mem, mem_size, vec, num_pages/5, PAGEMAP_WP_ENGAGE,
+			    num_pages/2 - 2, PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ret2 = pagemap_ioctl(mem, mem_size, vec, 2, 0, 0, PAGE_IS_WT, 0, 0,
+			     PAGE_IS_WT);
+	if (ret2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret2, errno, strerror(errno));
+
+	ret3 = pagemap_ioctl(mem, mem_size, vec, num_pages/2, 0, 0, PAGE_IS_WT, 0, 0,
+			     PAGE_IS_WT);
+	if (ret3 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret3, errno, strerror(errno));
+
+	ksft_test_result((ret + ret3) == num_pages/2 && ret2 == 2,
+			 "%s Repeated pattern of dirty and non-dirty pages in parts\n", __func__);
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
+	ret = pagemap_ioctl(m[0], mem_size, NULL, 0, PAGEMAP_WP_ENGAGE, 0,
+			    0, 0, 0, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ret = pagemap_ioctl(m[1], mem_size, vec, 1, 0, 0, PAGE_IS_WT, 0, 0,
+			    PAGE_IS_WT);
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
+	int vec_size, ret, dirty, dirty2;
+	struct page_region *vec, *vec2;
+
+	if (skip) {
+		ksft_test_result_skip("%s all new pages must be soft dirty\n", prefix);
+		ksft_test_result_skip("%s all pages must not be soft dirty\n", prefix);
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
+	/* 1. all new pages must be not be soft dirty */
+	dirty = pagemap_ioctl(mem, mem_size, vec, 1, PAGEMAP_WP_ENGAGE, vec_size - 2,
+			      PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	dirty2 = pagemap_ioctl(mem, mem_size, vec2, 1, PAGEMAP_WP_ENGAGE, 0,
+			       PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+	if (dirty2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty2, errno, strerror(errno));
+
+	ksft_test_result(dirty == 0 && dirty2 == 0,
+			 "%s all new pages must be soft dirty\n", prefix);
+
+	/* 2. all pages must not be soft dirty */
+	dirty = pagemap_ioctl(mem, mem_size, vec, 1, 0, 0, PAGE_IS_WT, 0, 0,
+			      PAGE_IS_WT);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	ksft_test_result(dirty == 0, "%s all pages must not be soft dirty\n", prefix);
+
+	/* 3. all pages dirty other than first and the last one */
+	memset(mem + page_size, 0, mem_size - (2 * page_size));
+
+	dirty = pagemap_ioctl(mem, mem_size, vec, 1, 0, 0, PAGE_IS_WT, 0, 0,
+			      PAGE_IS_WT);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	ksft_test_result(dirty == 1 && vec[0].len >= vec_size - 2 && vec[0].len <= vec_size,
+			 "%s all pages dirty other than first and the last one\n", prefix);
+
+	/* 4. only middle page dirty */
+	clear_softdirty_wp(mem, mem_size);
+	mem[vec_size/2 * page_size]++;
+
+	dirty = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0, PAGE_IS_WT, 0, 0,
+			      PAGE_IS_WT);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	if (check_huge_anon(mem, mem_size/hpage_size, hpage_size))
+		ksft_test_result(dirty == 1 && vec[0].len >= 1,
+				 "%s only middle page dirty\n", prefix);
+	else
+		ksft_test_result(vec[0].start == (uintptr_t)(mem + vec_size/2 * page_size),
+				 "%s only middle page dirty\n", prefix);
+
+	/* 5. only two middle pages dirty and walk over only middle pages */
+	clear_softdirty_wp(mem, mem_size);
+	mem[vec_size/2 * page_size]++;
+	mem[(vec_size/2 + 1) * page_size]++;
+
+	dirty = pagemap_ioctl(&mem[vec_size/2 * page_size], 2 * page_size, vec, 1, 0, 0,
+			      PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	ksft_test_result(dirty == 1 && vec[0].start == (uintptr_t)(&mem[vec_size/2 * page_size]) &&
+			 vec[0].len == 2,
+			 "%s only two middle pages dirty\n", prefix);
+
+	/* 6. only get 2 dirty pages and clear them as well */
+	memset(mem, -1, mem_size);
+
+	/* get and clear second and third pages */
+	ret = pagemap_ioctl(mem + page_size, 2 * page_size, vec, 1, PAGEMAP_WP_ENGAGE,
+			    2, PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	dirty = pagemap_ioctl(mem, mem_size, vec2, vec_size, 0, 0,
+			      PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && vec[0].len == 2 &&
+			 vec[0].start == (uintptr_t)(mem + page_size) &&
+			 dirty == 2 && vec2[0].len == 1 && vec2[0].start == (uintptr_t)mem &&
+			 vec2[1].len == vec_size - 3 &&
+			 vec2[1].start == (uintptr_t)(mem + 3 * page_size),
+			 "%s only get 2 dirty pages and clear them as well\n", prefix);
+
+	/* 7. Range clear only */
+	memset(mem, -1, mem_size);
+
+	dirty = pagemap_ioctl(mem, mem_size, NULL, 0, PAGEMAP_WP_ENGAGE, 0,
+			      0, 0, 0, 0);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	dirty2 = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			       PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+	if (dirty2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty2, errno, strerror(errno));
+
+	ksft_test_result(dirty == 0 && dirty2 == 0, "%s Range clear only\n",
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
+	if (check_huge_anon(map, map_size/hpage_size, hpage_size))
+		return map;
+
+	free(map);
+	return NULL;
+
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
+		/* 1. all new huge page must not be dirty */
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PAGEMAP_WP_ENGAGE, 0,
+				    PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 0, "%s all new huge page must be dirty\n", __func__);
+
+		/* 2. all the huge page must not be dirty */
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
+				    PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 0, "%s all the huge page must not be dirty\n", __func__);
+
+		/* 3. all the huge page must be dirty and clear dirty as well */
+		memset(map, -1, map_size);
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PAGEMAP_WP_ENGAGE, 0,
+				    PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].start == (uintptr_t)map &&
+				 vec[0].len == vec_size && vec[0].bitmap == PAGE_IS_WT,
+				 "%s all the huge page must be dirty and clear\n", __func__);
+
+		/* 4. only middle page dirty */
+		wp_free(map, map_size);
+		free(map);
+		map = gethugepage(map_size);
+		wp_init(map, map_size);
+		clear_softdirty_wp(map, map_size);
+		map[vec_size/2 * page_size]++;
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
+				    PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].len > 0,
+				 "%s only middle page dirty\n", __func__);
+
+		wp_free(map, map_size);
+		free(map);
+	} else {
+		ksft_test_result_skip("all new huge page must be dirty\n");
+		ksft_test_result_skip("all the huge page must not be dirty\n");
+		ksft_test_result_skip("all the huge page must be dirty and clear\n");
+		ksft_test_result_skip("only middle page dirty\n");
+	}
+
+	/* 5. clear first half of huge page */
+	map = gethugepage(map_size);
+	if (map) {
+
+		memset(map, 0, map_size);
+
+		ret = pagemap_ioctl(map, map_size/2, NULL, 0, PAGEMAP_WP_ENGAGE, 0,
+				    0, 0, 0, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
+				    PAGE_IS_WT, 0, 0, PAGE_IS_WT);
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
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PAGEMAP_WP_ENGAGE,
+				    vec_size/2, PAGE_IS_WT, 0, 0, PAGE_IS_WT);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
+				    PAGE_IS_WT, 0, 0, PAGE_IS_WT);
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
+		ret = pagemap_ioctl(map + map_size/2, map_size/2, NULL, 0, PAGEMAP_WP_ENGAGE,
+				    0, 0, 0, 0, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
+				    PAGE_IS_WT, 0, 0, PAGE_IS_WT);
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
+	free(vec);
+	free(vec2);
+	return 0;
+}
+
+int unmapped_region_tests(void)
+{
+	void *start = (void *)0x10000000;
+	int dirty, len = 0x00040000;
+	int vec_size = len / page_size;
+	struct page_region *vec = malloc(sizeof(struct page_region) * vec_size);
+
+	/* 1. Get dirty pages */
+	dirty = pagemap_ioctl(start, len, vec, vec_size, 0, 0, PAGEMAP_NON_WT_MASK, 0, 0,
+			      PAGEMAP_NON_WT_MASK);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	ksft_test_result(dirty >= 0, "%s Get status of pages\n", __func__);
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
+	clear_softdirty_wp(map, page_size);
+
+	for (i = 0 ; i < TEST_ITERATIONS; i++) {
+		if (pagemap_ioctl(map, page_size, &vec, 1, 0, 0,
+				  PAGE_IS_WT, 0, 0, PAGE_IS_WT) == 1) {
+			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
+			break;
+		}
+
+		clear_softdirty_wp(map, page_size);
+		/* Write something to the page to get the dirty bit enabled on the page */
+		map[0]++;
+
+		if (pagemap_ioctl(map, page_size, &vec, 1, 0, 0,
+				  PAGE_IS_WT, 0, 0, PAGE_IS_WT) == 0) {
+			ksft_print_msg("dirty bit was 0, but should be 1 (i=%d)\n", i);
+			break;
+		}
+
+		clear_softdirty_wp(map, page_size);
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
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, PAGEMAP_WP_ENGAGE, 0,
+				       PAGEMAP_OP_MASK, 0, 0, PAGEMAP_OP_MASK) < 0,
+			 "%s clear op can only be specified with PAGE_IS_WT\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+				       PAGEMAP_OP_MASK, 0, 0, PAGEMAP_OP_MASK) >= 0,
+			 "%s required_mask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+				       0, PAGEMAP_OP_MASK, 0, PAGEMAP_OP_MASK) >= 0,
+			 "%s anyof_mask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+				       0, 0, PAGEMAP_OP_MASK, PAGEMAP_OP_MASK) >= 0,
+			 "%s excluded_mask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+				       PAGEMAP_OP_MASK, PAGEMAP_OP_MASK, 0, PAGEMAP_OP_MASK) >= 0,
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
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    0, PAGEMAP_OP_MASK, 0, PAGEMAP_OP_MASK);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == (PAGE_IS_WT | PAGE_IS_PRESENT),
+			 "%s Get sd and present pages with anyof_mask\n", __func__);
+
+	/* 3. Get sd and present pages with required_mask */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    PAGEMAP_OP_MASK, 0, 0, PAGEMAP_OP_MASK);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == (PAGE_IS_WT | PAGE_IS_PRESENT),
+			 "%s Get all the pages with required_mask\n", __func__);
+
+	/* 4. Get sd and present pages with required_mask and anyof_mask */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    PAGE_IS_WT, PAGE_IS_PRESENT, 0, PAGEMAP_OP_MASK);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == (PAGE_IS_WT | PAGE_IS_PRESENT),
+			 "%s Get sd and present pages with required_mask and anyof_mask\n",
+			 __func__);
+
+	/* 5. Don't get sd pages */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    0, 0, PAGE_IS_WT, PAGEMAP_OP_MASK);
+	ksft_test_result(ret == 0, "%s Don't get sd pages\n", __func__);
+
+	/* 6. Don't get present pages */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    0, 0, PAGE_IS_PRESENT, PAGEMAP_OP_MASK);
+	ksft_test_result(ret == 0, "%s Don't get present pages\n", __func__);
+
+	wp_free(mem, mem_size);
+	munmap(mem, mem_size);
+
+	/* 8. Find dirty present pages with return mask */
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+	wp_init(mem, mem_size);
+
+	memset(mem, 0, mem_size);
+
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    0, PAGEMAP_OP_MASK, 0, PAGE_IS_WT);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == PAGE_IS_WT,
+			 "%s Find dirty present pages with return mask\n", __func__);
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
+	fmem = mmap(NULL, sbuf.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (fmem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+
+	ret = pagemap_ioctl(fmem, sbuf.st_size, vec, vec_size, 0, 0,
+			    0, PAGEMAP_NON_WT_MASK, 0, PAGEMAP_NON_WT_MASK);
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
+	ret = pagemap_ioctl(mem, 2 * page_size, &vec, 1, 0, 0, PAGE_IS_WT,
+			    0, 0, PAGE_IS_WT);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && vec.len == 2, "%s Both pages dirty\n", __func__);
+
+	/* 2. Start softdirty tracking. Clear VM_SOFTDIRTY and clear the softdirty PTE bit. */
+	ret = pagemap_ioctl(mem, 2 * page_size, NULL, 0, PAGEMAP_WP_ENGAGE, 0,
+			    0, 0, 0, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(pagemap_ioctl(mem, 2 * page_size, &vec, 1, 0, 0, PAGE_IS_WT,
+			 0, 0, PAGE_IS_WT) == 0,
+			 "%s Both pages are not soft dirty\n", __func__);
+
+	/* 3. Remap the second page */
+	mem2 = mmap(mem + page_size, page_size, PROT_READ|PROT_WRITE,
+		    MAP_PRIVATE|MAP_ANON|MAP_FIXED, -1, 0);
+	if (mem2 == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+	wp_init(mem2, page_size);
+
+	/* Protect + unprotect. */
+	mprotect(mem, 2 * page_size, PROT_READ);
+	mprotect(mem, 2 * page_size, PROT_READ|PROT_WRITE);
+
+	/* Modify both pages. */
+	memset(mem, 2, 2 * page_size);
+
+	ret = pagemap_ioctl(mem, 2 * page_size, &vec, 1, 0, 0, PAGE_IS_WT,
+			    0, 0, PAGE_IS_WT);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && vec.len == 2,
+			 "%s Both pages dirty after remap and mprotect\n", __func__);
+
+	/* 4. Clear and make the pages dirty */
+	ret = pagemap_ioctl(mem, 2 * page_size, NULL, 0, PAGEMAP_WP_ENGAGE, 0,
+			    0, 0, 0, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	memset(mem, 'A', 2 * page_size);
+
+	ret = pagemap_ioctl(mem, 2 * page_size, &vec, 1, 0, 0, PAGE_IS_WT,
+			    0, 0, PAGE_IS_WT);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && vec.len == 2,
+			 "%s Clear and make the pages dirty\n", __func__);
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
+	ksft_set_plan(54);
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
+	 * Soft-dirty PTE bit tests
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
+	if (map)
+		base_tests("Huge page testing:", map, hpage_size, 0);
+	else
+		base_tests("Huge page testing:", NULL, 0, 1);
+
+	wp_free(map, hpage_size);
+	free(map);
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
+	close(pagemap_fd);
+	return ksft_exit_pass();
+}
-- 
2.30.2

