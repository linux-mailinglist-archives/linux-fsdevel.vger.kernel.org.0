Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC04617A9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 11:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiKCKI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiKCKIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:08:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E31DFA3;
        Thu,  3 Nov 2022 03:08:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 774F3660294A;
        Thu,  3 Nov 2022 10:08:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667470088;
        bh=626n+z9DNf3YKf+IKKCXggA9tiB1CJ99myronEy1b5w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IAe6uC2UurFHIMqmG2tZEY06ursiiiOZowEtBLfuh5WjoddoUjyrfEBEs2qDJZs9v
         08zA7+H9E+WbyCUKXiCXPg1oJgzpG5Scn/2o2nn4l5OlwoSZqdL1aKaOHGGUr4uVK2
         pda7/LuU5cyXi+YRuVM5wg5C7eJJZ1X0AkveOcfxvKBnSjGl2/lHuS2JmrVp+H+RNb
         wdf84agZsRyqxkIMM7flSdSuSQF4Q1MWkmfejRsRcJ/kxAwbMWcTS9MNyfzx1WTlBY
         0lxPPsaJIpl/Q4RnFlRVtAKj3MkCI/CjBTpu9PGcLgFwOi+0UAab+w3FDyHkThoIOk
         yG3h0g/1Uwa1A==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: [PATCH v4 3/3] selftests: vm: add pagemap ioctl tests
Date:   Thu,  3 Nov 2022 15:07:36 +0500
Message-Id: <20221103100736.2356351-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103100736.2356351-1-usama.anjum@collabora.com>
References: <20221103100736.2356351-1-usama.anjum@collabora.com>
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
Changes in v4:
- Updated all the tests to conform to new IOCTL

Changes in v3:
- Add another test to do sanity of flags

Changes in v2:
- Update the tests to use the ioctl interface instead of syscall

TAP version 13
1..59
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
ok 30 Performance Page testing: all new pages must be soft dirty
ok 31 Performance Page testing: all pages must not be soft dirty
ok 32 Performance Page testing: all pages dirty other than first and the last one
ok 33 Performance Page testing: only middle page dirty
ok 34 Performance Page testing: only two middle pages dirty
ok 35 Performance Page testing: only get 2 dirty pages and clear them as well
ok 36 Performance Page testing: Range clear only
ok 37 hpage_unit_tests all new huge page must be dirty
ok 38 hpage_unit_tests all the huge page must not be dirty
ok 39 hpage_unit_tests all the huge page must be dirty and clear
ok 40 hpage_unit_tests only middle page dirty
ok 41 hpage_unit_tests clear first half of huge page
ok 42 hpage_unit_tests clear first half of huge page with limited buffer
ok 43 hpage_unit_tests clear second half huge page
ok 44 unmapped_region_tests Get dirty pages
ok 45 unmapped_region_tests Get dirty pages
ok 46 Test test_simple
ok 47 sanity_tests clear op can only be specified with PAGE_IS_DIRTY
ok 48 sanity_tests rmask specified
ok 49 sanity_tests amask specified
ok 50 sanity_tests emask specified
ok 51 sanity_tests rmask and amask specified
ok 52 sanity_tests rmask and amask specified
ok 53 sanity_tests Get sd and present pages with amask
ok 54 sanity_tests Get all the pages with rmask
ok 55 sanity_tests Get sd and present pages with rmask and amask
ok 56 sanity_tests Don't get sd pages
ok 57 sanity_tests Don't get present pages
ok 58 sanity_tests Find dirty present pages with return mask
ok 59 sanity_tests Memory mapped file
 # Totals: pass:59 fail:0 xfail:0 xpass:0 skip:0 error:0
---
 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   5 +-
 tools/testing/selftests/vm/pagemap_ioctl.c | 681 +++++++++++++++++++++
 3 files changed, 685 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pagemap_ioctl.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 8a536c731e3c..4a73983e3e58 100644
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
index 0986bd60c19f..2325bcdb9fae 100644
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
 TEST_GEN_FILES = anon_cow
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
@@ -103,6 +103,7 @@ $(OUTPUT)/anon_cow: vm_util.c
 $(OUTPUT)/khugepaged: vm_util.c
 $(OUTPUT)/ksm_functional_tests: vm_util.c
 $(OUTPUT)/madv_populate: vm_util.c
+$(OUTPUT)/pagemap_ioctl: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
 $(OUTPUT)/userfaultfd: vm_util.c
diff --git a/tools/testing/selftests/vm/pagemap_ioctl.c b/tools/testing/selftests/vm/pagemap_ioctl.c
new file mode 100644
index 000000000000..c55a0efa39f5
--- /dev/null
+++ b/tools/testing/selftests/vm/pagemap_ioctl.c
@@ -0,0 +1,681 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <malloc.h>
+#include <asm-generic/unistd.h>
+#include "vm_util.h"
+#include "../kselftest.h"
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <math.h>
+
+#define PAGEMAP_OP_MASK		(PAGE_IS_SD | PAGE_IS_FILE |		\
+				 PAGE_IS_PRESENT | PAGE_IS_SWAPED)
+#define TEST_ITERATIONS 10
+#define PAGEMAP "/proc/self/pagemap"
+int pagemap_fd;
+
+static long pagemap_ioctl(void *start, int len, void *vec, int vec_len, int flag,
+			  int max_pages, int rmask, int amask, int emask, int return_mask)
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
+	arg.rmask = rmask;
+	arg.amask = amask;
+	arg.emask = emask;
+	arg.return_mask = return_mask;
+
+	ret = ioctl(pagemap_fd, PAGEMAP_SCAN, &arg);
+
+	return ret;
+}
+
+int sanity_tests_sd(int page_size)
+{
+	char *mem, *m[2];
+	int mem_size, vec_size, ret, ret2, i;
+	struct page_region *vec;
+
+	/* 1. wrong operation */
+	vec_size = 100;
+	mem_size = 10 * page_size;
+
+	vec = malloc(sizeof(struct page_region) * vec_size);
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem || !vec)
+		ksft_exit_fail_msg("error nomem\n");
+
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, -1,
+				       0, PAGE_IS_SD, 0, 0, PAGE_IS_SD) < 0,
+			 "%s wrong flag specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 8,
+				       0, 0x1111, 0, 0, PAGE_IS_SD) < 0,
+			 "%s wrong mask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0,
+				       0, PAGE_IS_SD, 0, 0, 0x1000) < 0,
+			 "%s wrong return mask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, PAGEMAP_SD_CLEAR | 0x32,
+				       0, PAGE_IS_SD, 0, 0, PAGE_IS_SD) < 0,
+			 "%s mixture of correct and wrong flag\n", __func__);
+
+	/* 2. Clear area with larger vec size */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, PAGEMAP_SD_CLEAR, 0,
+			    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	ksft_test_result(ret >= 0, "%s Clear area with larger vec size\n", __func__);
+
+	/* 3. Repeated pattern of dirty and non-dirty pages */
+	for (i = 0; i < mem_size; i += 2 * page_size)
+		mem[i]++;
+
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0, PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == mem_size/(page_size * 2),
+			 "%s Repeated pattern of dirty and non-dirty pages\n", __func__);
+
+	/* 4. Repeated pattern of dirty and non-dirty pages in parts*/
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, mem_size/(page_size * 2) - 2, 0,
+			    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ret2 = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0, PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (ret2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret2, errno, strerror(errno));
+
+	ksft_test_result((ret + ret2) == mem_size/(page_size * 2),
+			 "%s Repeated pattern of dirty and non-dirty pages in parts\n", __func__);
+
+	munmap(mem, mem_size);
+
+	/* 5. Two regions */
+	m[0] = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!m[0])
+		ksft_exit_fail_msg("error nomem\n");
+	m[1] = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!m[1])
+		ksft_exit_fail_msg("error nomem\n");
+
+	ret = pagemap_ioctl(m[0], mem_size, NULL, 0, PAGEMAP_SD_CLEAR, 0,
+			    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ret = pagemap_ioctl(m[1], mem_size, vec, 1, 0, 0, PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && vec[0].len == mem_size/page_size,
+			 "%s Two regions\n", __func__);
+
+	munmap(m[0], mem_size);
+	munmap(m[1], mem_size);
+
+	free(vec);
+	return 0;
+}
+
+int base_tests(char *prefix, char *mem, int mem_size, int page_size, int skip, int flags)
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
+	/* 1. all new pages must be soft dirty if PAGEMAP_NO_REUSED_REGIONS isn't used */
+	dirty = pagemap_ioctl(mem, mem_size, vec, 1, flags | PAGEMAP_SD_CLEAR, vec_size - 2,
+			      PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	dirty2 = pagemap_ioctl(mem, mem_size, vec2, 1, flags | PAGEMAP_SD_CLEAR, 0,
+			       PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (dirty2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty2, errno, strerror(errno));
+
+	if (flags != PAGEMAP_NO_REUSED_REGIONS)
+		ksft_test_result(dirty == 1 && vec[0].start == (unsigned long)mem &&
+				 vec[0].len == vec_size - 2 && vec[0].bitmap == PAGE_IS_SD &&
+				 dirty2 == 1 &&
+				 vec2[0].start == (unsigned long)(mem + mem_size - (2 * page_size))
+				 && vec2[0].len == 2 && vec[0].bitmap == PAGE_IS_SD,
+				 "%s all new pages must be soft dirty\n", prefix);
+	else
+		ksft_test_result(dirty == 0 && dirty2 == 0,
+				 "%s all new pages must be soft dirty\n", prefix);
+
+	// 2. all pages must not be soft dirty
+	dirty = pagemap_ioctl(mem, mem_size, vec, 1, flags, 0, PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	ksft_test_result(dirty == 0, "%s all pages must not be soft dirty\n", prefix);
+
+	// 3. all pages dirty other than first and the last one
+	memset(mem + page_size, -1, mem_size - (2 * page_size));
+
+	dirty = pagemap_ioctl(mem, mem_size, vec, 1, flags, 0, PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	ksft_test_result(dirty == 1 && vec[0].len >= vec_size - 2 && vec[0].len <= vec_size,
+			 "%s all pages dirty other than first and the last one\n", prefix);
+
+	// 4. only middle page dirty
+	clear_softdirty();
+	mem[vec_size/2 * page_size]++;
+
+	dirty = pagemap_ioctl(mem, mem_size, vec, vec_size, flags, 0, PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	ksft_test_result(vec[0].start == (uintptr_t)(mem + vec_size/2 * page_size),
+			 "%s only middle page dirty\n", prefix);
+
+	// 5. only two middle pages dirty and walk over only middle pages
+	clear_softdirty();
+	mem[vec_size/2 * page_size]++;
+	mem[(vec_size/2 + 1) * page_size]++;
+
+	dirty = pagemap_ioctl(&mem[vec_size/2 * page_size], 2 * page_size, vec, 1, flags, 0,
+			      PAGE_IS_SD, 0, 0, PAGE_IS_SD);
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
+	ret = pagemap_ioctl(mem + page_size, 2 * page_size, vec, 1, flags | PAGEMAP_SD_CLEAR, 2,
+			    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	dirty = pagemap_ioctl(mem, mem_size, vec2, vec_size, flags, 0,
+			      PAGE_IS_SD, 0, 0, PAGE_IS_SD);
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
+	dirty = pagemap_ioctl(mem, mem_size, NULL, 0, flags | PAGEMAP_SD_CLEAR, 0,
+			      PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	dirty2 = pagemap_ioctl(mem, mem_size, vec, vec_size, flags, 0,
+			       PAGE_IS_SD, 0, 0, PAGE_IS_SD);
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
+	size_t hpage_len = read_pmd_pagesize();
+
+	map = memalign(hpage_len, map_size);
+	if (!map)
+		ksft_exit_fail_msg("memalign failed %d %s\n", errno, strerror(errno));
+
+	ret = madvise(map, map_size, MADV_HUGEPAGE);
+	if (ret)
+		ksft_exit_fail_msg("madvise failed %d %d %s\n", ret, errno, strerror(errno));
+
+	memset(map, 0, map_size);
+
+	if (check_huge_anon(map, map_size/hpage_len, hpage_len))
+		return map;
+
+	free(map);
+	return NULL;
+
+}
+
+int hpage_unit_tests(int page_size)
+{
+	char *map;
+	int ret;
+	size_t hpage_len = read_pmd_pagesize();
+	size_t num_pages = 10;
+	int map_size = hpage_len * num_pages;
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
+		// 1. all new huge page must be dirty
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PAGEMAP_SD_CLEAR, 0,
+				    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].start == (uintptr_t)map &&
+				 vec[0].len == vec_size && vec[0].bitmap == PAGE_IS_SD,
+				 "%s all new huge page must be dirty\n", __func__);
+
+		// 2. all the huge page must not be dirty
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PAGEMAP_SD_CLEAR, 0,
+				    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 0, "%s all the huge page must not be dirty\n", __func__);
+
+		// 3. all the huge page must be dirty and clear dirty as well
+		memset(map, -1, map_size);
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PAGEMAP_SD_CLEAR, 0,
+				    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].start == (uintptr_t)map &&
+				vec[0].len == vec_size && vec[0].bitmap == PAGE_IS_SD,
+				 "%s all the huge page must be dirty and clear\n", __func__);
+
+		// 4. only middle page dirty
+		free(map);
+		map = gethugepage(map_size);
+		clear_softdirty();
+		map[vec_size/2 * page_size]++;
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
+				    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].len > 0,
+				 "%s only middle page dirty\n", __func__);
+
+		free(map);
+	} else {
+		ksft_test_result_skip("all new huge page must be dirty\n");
+		ksft_test_result_skip("all the huge page must not be dirty\n");
+		ksft_test_result_skip("all the huge page must be dirty and clear\n");
+		ksft_test_result_skip("only middle page dirty\n");
+	}
+
+	// 5. clear first half of huge page
+	map = gethugepage(map_size);
+	if (map) {
+		ret = pagemap_ioctl(map, map_size/2, NULL, 0, PAGEMAP_SD_CLEAR, 0,
+				    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
+				    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].len == vec_size/2 &&
+				 vec[0].start == (uintptr_t)(map + map_size/2),
+				 "%s clear first half of huge page\n", __func__);
+		free(map);
+	} else {
+		ksft_test_result_skip("clear first half of huge page\n");
+	}
+
+	// 6. clear first half of huge page with limited buffer
+	map = gethugepage(map_size);
+	if (map) {
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, PAGEMAP_SD_CLEAR, vec_size/2,
+				    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
+				    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].len == vec_size/2 &&
+				 vec[0].start == (uintptr_t)(map + map_size/2),
+				 "%s clear first half of huge page with limited buffer\n",
+				 __func__);
+
+		free(map);
+	} else {
+		ksft_test_result_skip("clear first half of huge page with limited buffer\n");
+	}
+
+	// 7. clear second half of huge page
+	map = gethugepage(map_size);
+	if (map) {
+		memset(map, -1, map_size);
+		ret = pagemap_ioctl(map + map_size/2, map_size, NULL, 0, PAGEMAP_SD_CLEAR, 0,
+				    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
+				    PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && vec[0].len == vec_size/2,
+				 "%s clear second half huge page\n", __func__);
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
+int unmapped_region_tests(int page_size)
+{
+	void *start = (void *)0x10000000;
+	int dirty, len = 0x00040000;
+	int vec_size = len / page_size;
+	struct page_region *vec = malloc(sizeof(struct page_region) * vec_size);
+
+	/* 1. Get dirty pages */
+	dirty = pagemap_ioctl(start, len, vec, vec_size, 0, 0, PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	ksft_test_result(dirty >= 0, "%s Get dirty pages\n", __func__);
+
+	/* 2. Clear dirty bit of whole address space */
+	dirty = pagemap_ioctl(0, 0x7FFFFFFF, NULL, 0,  PAGEMAP_SD_CLEAR, 0,
+			PAGE_IS_SD, 0, 0, PAGE_IS_SD);
+	if (dirty < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty, errno, strerror(errno));
+
+	ksft_test_result(dirty == 0, "%s Get dirty pages\n", __func__);
+
+	free(vec);
+	return 0;
+}
+
+static void test_simple(int page_size)
+{
+	int i;
+	char *map;
+	struct page_region vec;
+
+	map = aligned_alloc(page_size, page_size);
+	if (!map)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	clear_softdirty();
+
+	for (i = 0 ; i < TEST_ITERATIONS; i++) {
+		if (pagemap_ioctl(map, page_size, &vec, 1, 0, 0,
+				  PAGE_IS_SD, 0, 0, PAGE_IS_SD) == 1) {
+			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
+			break;
+		}
+
+		clear_softdirty();
+		// Write something to the page to get the dirty bit enabled on the page
+		map[0]++;
+
+		if (pagemap_ioctl(map, page_size, &vec, 1, 0, 0,
+				  PAGE_IS_SD, 0, 0, PAGE_IS_SD) == 0) {
+			ksft_print_msg("dirty bit was 0, but should be 1 (i=%d)\n", i);
+			break;
+		}
+
+		clear_softdirty();
+	}
+	free(map);
+
+	ksft_test_result(i == TEST_ITERATIONS, "Test %s\n", __func__);
+}
+
+int sanity_tests(int page_size)
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
+	if (!mem || !vec)
+		ksft_exit_fail_msg("error nomem\n");
+
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size,
+				       PAGEMAP_SD_CLEAR | PAGEMAP_NO_REUSED_REGIONS, 0,
+				       PAGEMAP_OP_MASK, 0, 0, PAGEMAP_OP_MASK) < 0,
+			 "%s clear op can only be specified with PAGE_IS_DIRTY\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+				       PAGEMAP_OP_MASK, 0, 0, PAGEMAP_OP_MASK) >= 0,
+			 "%s rmask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+				       0, PAGEMAP_OP_MASK, 0, PAGEMAP_OP_MASK) >= 0,
+			 "%s amask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+				       0, 0, PAGEMAP_OP_MASK, PAGEMAP_OP_MASK) >= 0,
+			 "%s emask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+				       PAGEMAP_OP_MASK, PAGEMAP_OP_MASK, 0, PAGEMAP_OP_MASK) >= 0,
+			 "%s rmask and amask specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, vec, vec_size, PAGEMAP_SD_CLEAR, 0,
+				       0, 0, PAGEMAP_OP_MASK, PAGEMAP_OP_MASK) >= 0,
+			 "%s rmask and amask specified\n", __func__);
+	munmap(mem, mem_size);
+
+	/* 2. Get sd and present pages with amask */
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+	memset(mem, 0, mem_size);
+
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    0, PAGEMAP_OP_MASK, 0, PAGEMAP_OP_MASK);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == (PAGE_IS_SD | PAGE_IS_PRESENT),
+			 "%s Get sd and present pages with amask\n", __func__);
+
+	/* 3. Get sd and present pages with rmask */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    PAGEMAP_OP_MASK, 0, 0, PAGEMAP_OP_MASK);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == (PAGE_IS_SD | PAGE_IS_PRESENT),
+			 "%s Get all the pages with rmask\n", __func__);
+
+	/* 4. Get sd and present pages with rmask and amask */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    PAGE_IS_SD, PAGE_IS_PRESENT, 0, PAGEMAP_OP_MASK);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == (PAGE_IS_SD | PAGE_IS_PRESENT),
+			 "%s Get sd and present pages with rmask and amask\n", __func__);
+
+	/* 5. Don't get sd pages */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    0, 0, PAGE_IS_SD, PAGEMAP_OP_MASK);
+	ksft_test_result(ret == 0, "%s Don't get sd pages\n", __func__);
+
+	/* 6. Don't get present pages */
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    0, 0, PAGE_IS_PRESENT, PAGEMAP_OP_MASK);
+	ksft_test_result(ret == 0, "%s Don't get present pages\n", __func__);
+
+	munmap(mem, mem_size);
+
+	/* 8. Find dirty present pages with return mask */
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+	memset(mem, 0, mem_size);
+
+	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0,
+			    0, PAGEMAP_OP_MASK, 0, PAGE_IS_SD);
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)mem && vec[0].len == vec_size &&
+			 vec[0].bitmap == PAGE_IS_SD,
+			 "%s Find dirty present pages with return mask\n", __func__);
+
+	/* 9. Memory mapped file */
+	int fd;
+	struct stat sbuf;
+
+	fd = open("run_vmtests.sh", O_RDONLY);
+	if (fd < 0) {
+		ksft_test_result_skip("%s Memory mapped file\n");
+		goto free_vec_and_return;
+	}
+
+	ret = stat("run_vmtests.sh", &sbuf);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	fmem = mmap(NULL, sbuf.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (!fmem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	ret = pagemap_ioctl(fmem, sbuf.st_size, vec, vec_size, 0, 0,
+			    0, PAGEMAP_OP_MASK, 0, PAGEMAP_OP_MASK);
+
+	ksft_test_result(ret >= 0 && vec[0].start == (uintptr_t)fmem &&
+			 vec[0].len == ceilf((float)sbuf.st_size/page_size) &&
+			 vec[0].bitmap == (PAGE_IS_SD | PAGE_IS_FILE),
+			 "%s Memory mapped file\n", __func__);
+
+	munmap(fmem, sbuf.st_size);
+
+free_vec_and_return:
+	free(vec);
+	return 0;
+}
+
+int main(void)
+{
+	int page_size = getpagesize();
+	size_t hpage_len = read_pmd_pagesize();
+	char *mem, *map;
+	int mem_size;
+
+	ksft_print_header();
+	ksft_set_plan(59);
+
+	pagemap_fd = open(PAGEMAP, O_RDWR);
+	if (pagemap_fd < 0)
+		return -EINVAL;
+
+	/*
+	 * Soft-dirty PTE bit tests
+	 */
+
+	/* 1. Sanity testing */
+	sanity_tests_sd(page_size);
+
+	/* 2. Normal page testing */
+	mem_size = 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	base_tests("Page testing:", mem, mem_size, page_size, 0, 0);
+
+	munmap(mem, mem_size);
+
+	/* 3. Large page testing */
+	mem_size = 512 * 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	base_tests("Large Page testing:", mem, mem_size, page_size, 0, 0);
+
+	munmap(mem, mem_size);
+
+	/* 4. Huge page testing */
+	map = gethugepage(hpage_len);
+	if (map)
+		base_tests("Huge page testing:", map, hpage_len, page_size, 0, 0);
+	else
+		base_tests("Huge page testing:", NULL, 0, 0, 1, 0);
+
+	free(map);
+
+	/* 5. Performance page testing */
+	mem_size = 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	base_tests("Performance Page testing:", mem, mem_size, page_size, 0,
+		   PAGEMAP_NO_REUSED_REGIONS);
+
+	munmap(mem, mem_size);
+
+	/* 6. Huge page tests */
+	hpage_unit_tests(page_size);
+
+	/* 7. Unmapped address test */
+	unmapped_region_tests(page_size);
+
+	/* 8. Iterative test */
+	test_simple(page_size);
+
+	/*
+	 * Other PTE bit tests
+	 */
+
+	/* 1. Sanity testing */
+	sanity_tests(page_size);
+
+	close(pagemap_fd);
+	return ksft_exit_pass();
+}
-- 
2.30.2

