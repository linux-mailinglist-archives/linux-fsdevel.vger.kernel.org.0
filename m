Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDB581746
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiGZQVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 12:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiGZQVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:21:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC7E2D1C3;
        Tue, 26 Jul 2022 09:21:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [203.135.47.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6AA656601B12;
        Tue, 26 Jul 2022 17:21:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658852487;
        bh=VRHwVG5nMSenCpzvP39FS74oypjt6/ob2F3QwRpbs00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzzzgPagAmgOFVwSpt0CnS3YVmbe9PDVbteju1u+4gdGMUhL+/UXV6v9KuvDcrhIV
         EVQyfl0WERM6QxiYOOwYV7cOmD0B0pzmPuGxfJH1eKeFJlw+jWwyyeex+sZHj6Tduw
         M+Ct+VjduWKGBp8IoERAhhldgK+jm62tU/Z7TucicildKjW4ewufxOVZ35WVB9kLrO
         sh0ynbgl5yqiCselxf0z9NOb2cxgY5Qua/ZiI5TLUoA54C80UC0J7pVg3Q8bs5zbqW
         SxdeOAHpy3x52qSTWwd8L/ohrRqV92ybvNSflhqZrx+QKvm7OpQlzC3IKotys6Qmxi
         L2ZtkwuYs7a2Q==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
        linux-api@vger.kernel.org (open list:ABI/API),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        krisman@collabora.com
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 4/5] selftests: vm: add process_memwatch syscall tests
Date:   Tue, 26 Jul 2022 21:18:53 +0500
Message-Id: <20220726161854.276359-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726161854.276359-1-usama.anjum@collabora.com>
References: <20220726161854.276359-1-usama.anjum@collabora.com>
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

Several unit tests and functionality tests are included.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
TAP version 13
1..44
ok 1 sanity_tests no flag specified
ok 2 sanity_tests wrong flag specified
ok 3 sanity_tests mixture of correct and wrong flags
ok 4 sanity_tests wrong pidfd
ok 5 sanity_tests pidfd of process with over which no capabilities
ok 6 sanity_tests Clear area with larger vec size
ok 7 Page testing: all new pages must be soft dirty
ok 8 Page testing: all pages must not be soft dirty
ok 9 Page testing: all pages dirty other than first and the last one
ok 10 Page testing: only middle page dirty
ok 11 Page testing: only two middle pages dirty
ok 12 Page testing: only get 2 dirty pages and clear them as well
ok 13 Page testing: Range clear only
ok 14 Large Page testing: all new pages must be soft dirty
ok 15 Large Page testing: all pages must not be soft dirty
ok 16 Large Page testing: all pages dirty other than first and the last one
ok 17 Large Page testing: only middle page dirty
ok 18 Large Page testing: only two middle pages dirty
ok 19 Large Page testing: only get 2 dirty pages and clear them as well
ok 20 Large Page testing: Range clear only
ok 21 Huge page testing: all new pages must be soft dirty
ok 22 Huge page testing: all pages must not be soft dirty
ok 23 Huge page testing: all pages dirty other than first and the last one
ok 24 Huge page testing: only middle page dirty
ok 25 Huge page testing: only two middle pages dirty
ok 26 Huge page testing: only get 2 dirty pages and clear them as well
ok 27 Huge page testing: Range clear only
ok 28 Performance Page testing: page isn't dirty
ok 29 Performance Page testing: all pages must not be soft dirty
ok 30 Performance Page testing: all pages dirty other than first and the last one
ok 31 Performance Page testing: only middle page dirty
ok 32 Performance Page testing: only two middle pages dirty
ok 33 Performance Page testing: only get 2 dirty pages and clear them as well
ok 34 Performance Page testing: Range clear only
ok 35 hpage_unit_tests all new huge page must be dirty
ok 36 hpage_unit_tests all the huge page must not be dirty
ok 37 hpage_unit_tests all the huge page must be dirty and clear
ok 38 hpage_unit_tests only middle page dirty
ok 39 hpage_unit_tests clear first half of huge page
ok 40 hpage_unit_tests clear first half of huge page with limited buffer
ok 41 hpage_unit_tests clear second half huge page
ok 42 unmapped_region_tests Get dirty pages
ok 43 unmapped_region_tests Get dirty pages
ok 44 Test test_simple
 # Totals: pass:44 fail:0 xfail:0 xpass:0 skip:0 error:0
---
 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   2 +
 tools/testing/selftests/vm/memwatch_test.c | 635 +++++++++++++++++++++
 3 files changed, 638 insertions(+)
 create mode 100644 tools/testing/selftests/vm/memwatch_test.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 31e5eea2a9b9..462cff7e23bb 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -14,6 +14,7 @@ mlock2-tests
 mrelease_test
 mremap_dontunmap
 mremap_test
+memwatch_test
 on-fault-limit
 transhuge-stress
 protection_keys
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index d9fa6a9ea584..65b8c94b104d 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -41,6 +41,7 @@ TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
 TEST_GEN_FILES += memfd_secret
+TEST_GEN_PROGS += memwatch_test
 TEST_GEN_FILES += migration
 TEST_GEN_FILES += mlock-random-test
 TEST_GEN_FILES += mlock2-tests
@@ -98,6 +99,7 @@ TEST_FILES += va_128TBswitch.sh
 include ../lib.mk
 
 $(OUTPUT)/madv_populate: vm_util.c
+$(OUTPUT)/memwatch_test: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
 
diff --git a/tools/testing/selftests/vm/memwatch_test.c b/tools/testing/selftests/vm/memwatch_test.c
new file mode 100644
index 000000000000..a109eff5d807
--- /dev/null
+++ b/tools/testing/selftests/vm/memwatch_test.c
@@ -0,0 +1,635 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <malloc.h>
+#include <asm-generic/unistd.h>
+#include <linux/memwatch.h>
+#include "vm_util.h"
+#include "../kselftest.h"
+#include <linux/types.h>
+
+#define TEST_ITERATIONS 10000
+
+static long process_memwatch(pid_t pidfd, void *start, int len,
+			     unsigned int flags, loff_t *vec, int vec_len)
+{
+	return syscall(__NR_process_memwatch, pidfd, start, len, flags, vec, vec_len);
+}
+
+int sanity_tests(int page_size)
+{
+	char *mem;
+	int mem_size, vec_size, ret;
+	loff_t *vec;
+
+	/* 1. wrong operation */
+	vec_size = 100;
+	mem_size = page_size;
+
+	vec = malloc(sizeof(loff_t) * vec_size);
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem || !vec)
+		ksft_exit_fail_msg("error nomem\n");
+
+	ksft_test_result(process_memwatch(0, mem, mem_size, 0, vec, vec_size) < 0,
+			 "%s no flag specified\n", __func__);
+	ksft_test_result(process_memwatch(0, mem, mem_size, 0x01000000, vec, vec_size) < 0,
+			 "%s wrong flag specified\n", __func__);
+	ksft_test_result(process_memwatch(0, mem, mem_size, MEMWATCH_SD_GET | 0xFF,
+			 vec, vec_size) < 0,
+			 "%s mixture of correct and wrong flags\n", __func__);
+	ksft_test_result(process_memwatch(-1, mem, mem_size, MEMWATCH_SD_GET, vec, vec_size) < 0,
+			 "%s wrong pidfd\n", __func__);
+	ksft_test_result(process_memwatch(1, mem, mem_size, MEMWATCH_SD_GET, vec, vec_size) < 0,
+			 "%s pidfd of process with over which no capabilities\n", __func__);
+
+	/* 2. Clear area with larger vec size */
+	ret = process_memwatch(0, mem, mem_size, MEMWATCH_SD_GET | MEMWATCH_SD_CLEAR,
+				  vec, vec_size);
+	ksft_test_result(ret >= 0, "%s Clear area with larger vec size\n", __func__);
+
+	free(vec);
+	munmap(mem, mem_size);
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
+	if (check_huge(map))
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
+	int i, ret;
+	size_t hpage_len = read_pmd_pagesize();
+	size_t num_pages = 1;
+	int map_size = hpage_len * num_pages;
+	int vec_size = map_size/page_size;
+	loff_t *vec, *vec2;
+
+	vec = malloc(sizeof(loff_t) * vec_size);
+	vec2 = malloc(sizeof(loff_t) * vec_size);
+	if (!vec || !vec2)
+		ksft_exit_fail_msg("malloc failed\n");
+
+	map = gethugepage(map_size);
+	if (map) {
+		// 1. all new huge page must be dirty
+		ret = process_memwatch(0, map, map_size, MEMWATCH_SD_GET | MEMWATCH_SD_CLEAR,
+				       vec, vec_size);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size; i++)
+			if (vec[i] != i * page_size)
+				break;
+
+		ksft_test_result(i == vec_size, "%s all new huge page must be dirty\n", __func__);
+
+		// 2. all the huge page must not be dirty
+		ret = process_memwatch(0, map, map_size, MEMWATCH_SD_GET,
+				       vec, vec_size);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 0, "%s all the huge page must not be dirty\n", __func__);
+
+		// 3. all the huge page must be dirty and clear dirty as well
+		memset(map, -1, map_size);
+		ret = process_memwatch(0, map, map_size, MEMWATCH_SD_GET | MEMWATCH_SD_CLEAR,
+				       vec, vec_size);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size; i++)
+			if (vec[i] != i * page_size)
+				break;
+
+		ksft_test_result(ret == vec_size && i == vec_size,
+				 "%s all the huge page must be dirty and clear\n", __func__);
+
+		// 4. only middle page dirty
+		free(map);
+		map = gethugepage(map_size);
+		clear_softdirty();
+		map[vec_size/2 * page_size]++;
+
+		ret = process_memwatch(0, map, map_size, MEMWATCH_SD_GET, vec, vec_size);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size; i++) {
+			if (vec[i] == vec_size/2 * page_size)
+				break;
+		}
+		ksft_test_result(vec[i] == vec_size/2 * page_size,
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
+		ret = process_memwatch(0, map, map_size/2, MEMWATCH_SD_CLEAR, NULL, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = process_memwatch(0, map, map_size, MEMWATCH_SD_GET, vec, vec_size);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size/2; i++)
+			if (vec[i] != (i + vec_size/2) * page_size)
+				break;
+
+		ksft_test_result(i == vec_size/2 && ret == vec_size/2,
+				 "%s clear first half of huge page\n", __func__);
+		free(map);
+	} else {
+		ksft_test_result_skip("clear first half of huge page\n");
+	}
+
+	// 6. clear first half of huge page with limited buffer
+	map = gethugepage(map_size);
+	if (map) {
+		ret = process_memwatch(0, map, map_size, MEMWATCH_SD_CLEAR | MEMWATCH_SD_GET,
+				       vec, vec_size/2);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = process_memwatch(0, map, map_size, MEMWATCH_SD_GET, vec, vec_size);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size/2; i++)
+			if (vec[i] != (i + vec_size/2) * page_size)
+				break;
+
+		ksft_test_result(i == vec_size/2 && ret == vec_size/2,
+				 "%s clear first half of huge page with limited buffer\n",
+				 __func__);
+		free(map);
+	} else {
+		ksft_test_result_skip("clear first half of huge page with limited buffer\n");
+	}
+
+	// 7. clear second half of huge page
+	map = gethugepage(map_size);
+	if (map) {
+		memset(map, -1, map_size);
+		ret = process_memwatch(0, map + map_size/2, map_size/2, MEMWATCH_SD_CLEAR, NULL, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = process_memwatch(0, map, map_size, MEMWATCH_SD_GET, vec, vec_size);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size/2; i++)
+			if (vec[i] != i * page_size)
+				break;
+
+		ksft_test_result(i == vec_size/2, "%s clear second half huge page\n", __func__);
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
+int base_tests(char *prefix, char *mem, int mem_size, int page_size, int skip)
+{
+	int vec_size, i, j, ret, dirty_pages, dirty_pages2;
+	loff_t *vec, *vec2;
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
+	vec = malloc(sizeof(loff_t) * vec_size);
+	vec2 = malloc(sizeof(loff_t) * vec_size);
+
+	/* 1. all new pages must be soft dirty and clear the range for next test */
+	dirty_pages = process_memwatch(0, mem, mem_size, MEMWATCH_SD_GET | MEMWATCH_SD_CLEAR,
+				       vec, vec_size - 2);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	dirty_pages2 = process_memwatch(0, mem, mem_size, MEMWATCH_SD_GET | MEMWATCH_SD_CLEAR,
+					vec2, vec_size);
+	if (dirty_pages2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages2, errno, strerror(errno));
+
+	for (i = 0; i < dirty_pages; i++)
+		if (vec[i] != i * page_size)
+			break;
+	for (j = 0; j < dirty_pages2; j++)
+		if (vec2[j] != (j + vec_size - 2) * page_size)
+			break;
+
+	ksft_test_result(dirty_pages == vec_size - 2 && i == dirty_pages &&
+			 dirty_pages2 == 2 && j == dirty_pages2,
+			 "%s all new pages must be soft dirty\n", prefix);
+
+	// 2. all pages must not be soft dirty
+	dirty_pages = process_memwatch(0, mem, mem_size, MEMWATCH_SD_GET, vec, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0, "%s all pages must not be soft dirty\n", prefix);
+
+	// 3. all pages dirty other than first and the last one
+	memset(mem + page_size, -1, (mem_size - 2 * page_size));
+
+	dirty_pages = process_memwatch(0, mem, mem_size, MEMWATCH_SD_GET, vec, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < dirty_pages; i++) {
+		if (vec[i] != (i + 1) * page_size)
+			break;
+	}
+
+	ksft_test_result(dirty_pages == vec_size - 2 && i == vec_size - 2,
+			 "%s all pages dirty other than first and the last one\n", prefix);
+
+	// 4. only middle page dirty
+	clear_softdirty();
+	mem[vec_size/2 * page_size]++;
+
+	dirty_pages = process_memwatch(0, mem, mem_size, MEMWATCH_SD_GET, vec, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < vec_size; i++) {
+		if (vec[i] == vec_size/2 * page_size)
+			break;
+	}
+	ksft_test_result(vec[i] == vec_size/2 * page_size,
+			 "%s only middle page dirty\n", prefix);
+
+	// 5. only two middle pages dirty and walk over only middle pages
+	clear_softdirty();
+	mem[vec_size/2 * page_size]++;
+	mem[(vec_size/2 + 1) * page_size]++;
+
+	dirty_pages = process_memwatch(0, &mem[vec_size/2 * page_size], 2 * page_size,
+			       MEMWATCH_SD_GET, vec, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 2 && vec[0] == 0 && vec[1] == page_size,
+			 "%s only two middle pages dirty\n", prefix);
+
+	/* 6. only get 2 dirty pages and clear them as well */
+	memset(mem, -1, mem_size);
+
+	/* get and clear second and third pages */
+	ret = process_memwatch(0, mem + page_size, 2 * page_size,
+			       MEMWATCH_SD_GET | MEMWATCH_SD_CLEAR, vec, 2);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	dirty_pages = process_memwatch(0, mem, mem_size, MEMWATCH_SD_GET,
+			       vec2, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < vec_size - 2; i++) {
+		if (i == 0 && (vec[i] != 0 || vec2[i] != 0))
+			break;
+		else if (i == 1 && (vec[i] != page_size || vec2[i] != (i + 2) * page_size))
+			break;
+		else if (i > 1 && (vec2[i] != (i + 2) * page_size))
+			break;
+	}
+
+	ksft_test_result(dirty_pages == vec_size - 2 && i == vec_size - 2,
+			 "%s only get 2 dirty pages and clear them as well\n", prefix);
+	/* 7. Range clear only */
+	memset(mem, -1, mem_size);
+	dirty_pages = process_memwatch(0, mem, mem_size, MEMWATCH_SD_CLEAR, NULL, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	dirty_pages2 = process_memwatch(0, mem, mem_size, MEMWATCH_SD_GET, vec, vec_size);
+	if (dirty_pages2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages2, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0 && dirty_pages2 == 0, "%s Range clear only\n",
+			 prefix);
+
+	free(vec);
+	free(vec2);
+	return 0;
+}
+
+int performance_base_tests(char *prefix, char *mem, int mem_size, int page_size, int skip)
+{
+	int vec_size, i, ret, dirty_pages, dirty_pages2;
+	loff_t *vec, *vec2;
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
+	vec = malloc(sizeof(loff_t) * vec_size);
+	vec2 = malloc(sizeof(loff_t) * vec_size);
+
+	/* 1. all new pages must be soft dirty and clear the range for next test */
+	dirty_pages = process_memwatch(0, mem, mem_size,
+				       MEMWATCH_SD_GET | MEMWATCH_SD_CLEAR |
+				       MEMWATCH_SD_NO_REUSED_REGIONS,
+				       vec, vec_size - 2);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	dirty_pages2 = process_memwatch(0, mem, mem_size,
+					MEMWATCH_SD_GET | MEMWATCH_SD_CLEAR |
+					MEMWATCH_SD_NO_REUSED_REGIONS,
+					vec2, vec_size);
+	if (dirty_pages2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages2, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0 && dirty_pages2 == 0,
+			 "%s page isn't dirty\n", prefix);
+
+	// 2. all pages must not be soft dirty
+	dirty_pages = process_memwatch(0, mem, mem_size,
+				       MEMWATCH_SD_GET | MEMWATCH_SD_NO_REUSED_REGIONS,
+				       vec, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0, "%s all pages must not be soft dirty\n", prefix);
+
+	// 3. all pages dirty other than first and the last one
+	memset(mem + page_size, -1, (mem_size - 2 * page_size));
+
+	dirty_pages = process_memwatch(0, mem, mem_size,
+				       MEMWATCH_SD_GET | MEMWATCH_SD_NO_REUSED_REGIONS,
+				       vec, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < dirty_pages; i++) {
+		if (vec[i] != (i + 1) * page_size)
+			break;
+	}
+
+	ksft_test_result(dirty_pages == vec_size - 2 && i == vec_size - 2,
+			 "%s all pages dirty other than first and the last one\n", prefix);
+
+	// 4. only middle page dirty
+	clear_softdirty();
+	mem[vec_size/2 * page_size]++;
+
+	dirty_pages = process_memwatch(0, mem, mem_size,
+				       MEMWATCH_SD_GET | MEMWATCH_SD_NO_REUSED_REGIONS,
+				       vec, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < vec_size; i++) {
+		if (vec[i] == vec_size/2 * page_size)
+			break;
+	}
+	ksft_test_result(vec[i] == vec_size/2 * page_size,
+			 "%s only middle page dirty\n", prefix);
+
+	// 5. only two middle pages dirty and walk over only middle pages
+	clear_softdirty();
+	mem[vec_size/2 * page_size]++;
+	mem[(vec_size/2 + 1) * page_size]++;
+
+	dirty_pages = process_memwatch(0, &mem[vec_size/2 * page_size], 2 * page_size,
+				       MEMWATCH_SD_GET | MEMWATCH_SD_NO_REUSED_REGIONS,
+				       vec, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 2 && vec[0] == 0 && vec[1] == page_size,
+			 "%s only two middle pages dirty\n", prefix);
+
+	/* 6. only get 2 dirty pages and clear them as well */
+	memset(mem, -1, mem_size);
+
+	/* get and clear second and third pages */
+	ret = process_memwatch(0, mem + page_size, 2 * page_size,
+			       MEMWATCH_SD_GET | MEMWATCH_SD_CLEAR | MEMWATCH_SD_NO_REUSED_REGIONS,
+			       vec, 2);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	dirty_pages = process_memwatch(0, mem, mem_size,
+				       MEMWATCH_SD_GET | MEMWATCH_SD_NO_REUSED_REGIONS,
+				       vec2, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < vec_size - 2; i++) {
+		if (i == 0 && (vec[i] != 0 || vec2[i] != 0))
+			break;
+		else if (i == 1 && (vec[i] != page_size || vec2[i] != (i + 2) * page_size))
+			break;
+		else if (i > 1 && (vec2[i] != (i + 2) * page_size))
+			break;
+	}
+
+	ksft_test_result(dirty_pages == vec_size - 2 && i == vec_size - 2,
+			 "%s only get 2 dirty pages and clear them as well\n", prefix);
+	/* 7. Range clear only */
+	memset(mem, -1, mem_size);
+	dirty_pages = process_memwatch(0, mem, mem_size,
+				       MEMWATCH_SD_CLEAR | MEMWATCH_SD_NO_REUSED_REGIONS,
+				       NULL, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	dirty_pages2 = process_memwatch(0, mem, mem_size,
+					MEMWATCH_SD_GET | MEMWATCH_SD_NO_REUSED_REGIONS,
+					vec, vec_size);
+	if (dirty_pages2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages2, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0 && dirty_pages2 == 0, "%s Range clear only\n",
+			 prefix);
+
+	free(vec);
+	free(vec2);
+	return 0;
+}
+
+int unmapped_region_tests(int page_size)
+{
+	void *start = (void *)0x10000000;
+	int dirty_pages, len = 0x00040000;
+	int vec_size = len / page_size;
+	loff_t *vec = malloc(sizeof(loff_t) * vec_size);
+
+	/* 1. Get dirty pages */
+	dirty_pages = process_memwatch(0, start, len, MEMWATCH_SD_GET, vec, vec_size);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages >= 0, "%s Get dirty pages\n", __func__);
+
+	/* 2. Clear dirty bit of whole address space */
+	dirty_pages = process_memwatch(0, 0, 0x7FFFFFFF, MEMWATCH_SD_CLEAR, NULL, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0, "%s Get dirty pages\n", __func__);
+
+	free(vec);
+	return 0;
+}
+
+static void test_simple(int page_size)
+{
+	int i;
+	char *map;
+	loff_t *vec = NULL;
+
+	map = aligned_alloc(page_size, page_size);
+	if (!map)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	clear_softdirty();
+
+	for (i = 0 ; i < TEST_ITERATIONS; i++) {
+		if (process_memwatch(0, map, page_size, MEMWATCH_SD_GET, vec, 1) == 1) {
+			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
+			break;
+		}
+
+		clear_softdirty();
+		// Write something to the page to get the dirty bit enabled on the page
+		map[0]++;
+
+		if (process_memwatch(0, map, page_size, MEMWATCH_SD_GET, vec, 1) == 0) {
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
+int main(int argc, char **argv)
+{
+	int page_size = getpagesize();
+	size_t hpage_len = read_pmd_pagesize();
+	char *mem, *map;
+	int mem_size;
+
+	ksft_print_header();
+	ksft_set_plan(44);
+
+	/* 1. Sanity testing */
+	sanity_tests(page_size);
+
+	/* 2. Normal page testing */
+	mem_size = 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	base_tests("Page testing:", mem, mem_size, page_size, 0);
+
+	munmap(mem, mem_size);
+
+	/* 3. Large page testing */
+	mem_size = 512 * 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	base_tests("Large Page testing:", mem, mem_size, page_size, 0);
+
+	munmap(mem, mem_size);
+
+	/* 4. Huge page testing */
+	map = gethugepage(hpage_len);
+	if (check_huge(map))
+		base_tests("Huge page testing:", map, hpage_len, page_size, 0);
+	else
+		base_tests("Huge page testing:", NULL, 0, 0, 1);
+
+	free(map);
+
+	/* 5. Normal page testing */
+	mem_size = 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	performance_base_tests("Performance Page testing:", mem, mem_size, page_size, 0);
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
+	return ksft_exit_pass();
+}
-- 
2.30.2

