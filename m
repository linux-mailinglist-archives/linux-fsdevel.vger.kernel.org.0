Return-Path: <linux-fsdevel+bounces-61436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82133B5826E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9101A2088A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8832821423C;
	Mon, 15 Sep 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3qggOJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F42836A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954771; cv=none; b=s6QdQ7kPApORNI9QF/4fMDfdQ2WqitSrcrmmqCmcdod/bhsR36VOsYZn2KRNREvnHcqwGk7HVwDQvgX0bTnWFBfrEOJZeLaLDjPtHE5SsI9G3PBOM/sul5YPUL3ZY3CGpTQPDYAyJsldKkURYUPIJQcCWNMVxFDGidrzbQyRUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954771; c=relaxed/simple;
	bh=riBOge8Wc0Wr4o3sWOGZOQ93vW3XAreUKztk0vzDkEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hJ+l095Gi8zV+hVVuzf7Bn0xp6XY7v73qWuH23SlECav86ttYekb7io8IP9riU1hnjXqjpU3EaF1oY9+sifisEVDS03zkgf18KqySyx5pVKvG9TAKJRh/Sb1V+xC5YP51j3/scmqqfkFDiYIzR0KqN8BROKlm+Egvm6AdvwDhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3qggOJI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32dd3e922fdso6457586a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757954768; x=1758559568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCSSp2N5c9yEXM9I+1aefN3SldFOzk155OGuTtokYU4=;
        b=H3qggOJId+WHEgMkE+pQBOXMo+lhzo6ghpSwLu6SDeGucBahBESu/35Nt37VIo3scI
         6h7g+z6/UDIvZmvvL2JTj/hIR41tZLGjSAimG9QDvY8dWlGOOsh9MJVF79KbaSkW8f2t
         z8zK9G/PQ9AArwrKs71XGbDRvMjEnsrKymuuZbgYBOmJ4LMgzvjrBI6Yd5MUxB0BYMq0
         28Ga1gq7HROViiMrP3LlBG5KtDml9UwouQeVCjoYSjKYAfgTcucYMHbNRk4llc+VEeVp
         Bh8QQJj8t93uCqPBSY9iVa+Y7RGlZvv3yN52W6JBTofdrBzMaNZfVOJEekXiovlumLkX
         YL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954768; x=1758559568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCSSp2N5c9yEXM9I+1aefN3SldFOzk155OGuTtokYU4=;
        b=nUerFgBjkcOHw7u1TYxF7/eRiiW0q5lX93fb49lo86UHarVU4BEQn8FNeQ6nYBW8iN
         wyc6+iXu6ImB0ozJRgROCI3d0Jrkzg3oufOdHppm/b5mC/X2ZMd8Q5aViO3bx5XasLtl
         msyNNaeF9SoRysneSpL/Xz3UpboNIfZir8viPEbBN2Gk2EXG4H80fGHYbVfbcFZ+60jK
         /OARv72QeYYHT+zjlNtyiK7bfJJAq4vPGsUeepeUm8urH9IYU2UKPG/xslqt9ZcqqrRc
         E8Ap/G+dTOu49iOwBrYKsl2VdMKNC/NJFLrflFRyarlMZWp0xmJtZjqgCof+2esYQ8LN
         hgSg==
X-Forwarded-Encrypted: i=1; AJvYcCWIeBLLseJ1pLDKfxwMlhLdColImG2Jh1GMjlBKd6KyOeJDlXZIpdlWVl1JA1PX1knS6c9gA1tHLiK0Ng50@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXiJcVXEuCim9Qwsi1P/XGaftqGB4ZIlhNiq5bUxut9ichNFT
	xyhVTOS43p28m6hXqEYOqyrSIODNjjC0JuaRoJUHwQIgan+m5ppfPNfiYfgomtktmz2JmZ+kMbc
	oDtRYcZZHengvQZfx0QqZ+vw+cQ==
X-Google-Smtp-Source: AGHT+IH629yWc1BxgGvDumfHUKr1KQxr/RK85CqBBR0VFlrjCzLlim4w3J/AZqPO6/2jdfO/Nl5jWNcSFrWm5T8gGA==
X-Received: from pjbnc8.prod.google.com ([2002:a17:90b:37c8:b0:32d:a4d4:bb17])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2889:b0:32e:18f2:7a59 with SMTP id 98e67ed59e1d1-32e18f27cb4mr8891271a91.11.1757954768220;
 Mon, 15 Sep 2025 09:46:08 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:36:33 -0700
In-Reply-To: <20250915163838.631445-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915163838.631445-3-kaleshsingh@google.com>
Subject: [PATCH v2 2/7] mm/selftests: add max_vma_count tests
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a new selftest to verify that the max VMA count limit is correctly
enforced.

This test suite checks that various VMA operations (mmap, mprotect,
munmap, mremap) succeed or fail as expected when the number of VMAs is
close to the sysctl_max_map_count limit.

The test works by first creating a large number of VMAs to bring the
process close to the limit, and then performing various operations that
may or may not create new VMAs. The test then verifies that the
operations that would exceed the limit fail, and that the operations
that do not exceed the limit succeed.

NOTE: munmap is special as it's allowed to temporarily exceed the limit
by one for splits as this will decrease back to the limit once the unmap
succeeds.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
 - Add tests, per Liam (note that the do_brk_flags() path is not easily
   tested from userspace, so it's not included here). Exceeding the limit there
   should be uncommon.

 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/max_vma_count_tests.c        | 709 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   5 +
 3 files changed, 715 insertions(+)
 create mode 100644 tools/testing/selftests/mm/max_vma_count_tests.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index d13b3cef2a2b..00a4b04eab06 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -91,6 +91,7 @@ TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
 TEST_GEN_FILES += uffd-unit-tests
 TEST_GEN_FILES += uffd-wp-mremap
+TEST_GEN_FILES += max_vma_count_tests
 TEST_GEN_FILES += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 TEST_GEN_FILES += ksm_functional_tests
diff --git a/tools/testing/selftests/mm/max_vma_count_tests.c b/tools/testing/selftests/mm/max_vma_count_tests.c
new file mode 100644
index 000000000000..c8401c03425c
--- /dev/null
+++ b/tools/testing/selftests/mm/max_vma_count_tests.c
@@ -0,0 +1,709 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google LLC
+ */
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <linux/prctl.h>  /* Definition of PR_* constants */
+#include <sys/prctl.h>
+
+#include "../kselftest.h"
+
+static int get_max_vma_count(void);
+static bool set_max_vma_count(int val);
+static int get_current_vma_count(void);
+static bool is_current_vma_count(const char *msg, int expected);
+static bool is_test_area_mapped(const char *msg);
+static void print_surrounding_maps(const char *msg);
+
+/* Globals initialized in test_suite_setup() */
+static int MAX_VMA_COUNT;
+static int ORIGINAL_MAX_VMA_COUNT;
+static int PAGE_SIZE;
+static int GUARD_SIZE;
+static int TEST_AREA_SIZE;
+static int EXTRA_MAP_SIZE;
+
+static int MAX_VMA_COUNT;
+
+static int NR_EXTRA_MAPS;
+
+static char *TEST_AREA;
+static char *EXTRA_MAPS;
+
+#define DEFAULT_MAX_MAP_COUNT	65530
+#define TEST_AREA_NR_PAGES	3
+/* 1 before test area + 1 after test area + 1 after extra mappings */
+#define NR_GUARDS		3
+#define TEST_AREA_PROT		(PROT_NONE)
+#define EXTRA_MAP_PROT		(PROT_NONE)
+
+/**
+ * test_suite_setup - Set up the VMA layout for VMA count testing.
+ *
+ * Sets up the following VMA layout:
+ *
+ * +----- base_addr
+ * |
+ * V
+ * +--------------+----------------------+--------------+----------------+--------------+----------------+--------------+-----+----------------+--------------+
+ * |  Guard Page  |                      |  Guard Page  |  Extra Map 1   | Unmapped Gap |  Extra Map 2   | Unmapped Gap | ... |  Extra Map N   | Unmapped Gap |
+ * |  (unmapped)  |      TEST_AREA       |  (unmapped)  | (mapped page)  |  (1 page)    | (mapped page)  |  (1 page)    | ... | (mapped page)  |  (1 page)    |
+ * |   (1 page)   | (unmapped, 3 pages)  |   (1 page)   |    (1 page)    |              |    (1 page)    |              |     |    (1 page)    |              |
+ * +--------------+----------------------+--------------+----------------+--------------+----------------+--------------+-----+----------------+--------------+
+ * ^              ^                      ^              ^                                                                  ^
+ * |              |                      |              |                                                                  |
+ * +--GUARD_SIZE--+                      |              +-- EXTRA_MAPS points here             Sufficient EXTRA_MAPS to ---+
+ *    (PAGE_SIZE) |                      |                                                         reach MAX_VMA_COUNT
+ *                |                      |
+ *                +--- TEST_AREA_SIZE ---+
+ *                |   (3 * PAGE_SIZE)    |
+ *                ^
+ *                |
+ *                +-- TEST_AREA starts here
+ *
+ * Populates TEST_AREA and other globals required for the tests.
+ * If successful, the current VMA count will be MAX_VMA_COUNT - 1.
+ *
+ * Return: true on success, false on failure.
+ */
+static bool test_suite_setup(void)
+{
+	int initial_vma_count;
+	size_t reservation_size;
+	void *base_addr = NULL;
+	char *ptr = NULL;
+
+	ksft_print_msg("Setting up vma_max_count test suite...\n");
+
+	/* Initialize globals */
+	PAGE_SIZE = sysconf(_SC_PAGESIZE);
+	TEST_AREA_SIZE = TEST_AREA_NR_PAGES * PAGE_SIZE;
+	GUARD_SIZE = PAGE_SIZE;
+	EXTRA_MAP_SIZE = PAGE_SIZE;
+	MAX_VMA_COUNT = get_max_vma_count();
+
+	MAX_VMA_COUNT = get_max_vma_count();
+	if (MAX_VMA_COUNT < 0) {
+		ksft_print_msg("Failed to read /proc/sys/vm/max_map_count\n");
+		return false;
+	}
+
+	/*
+	 * If the current limit is higher than the kernel default,
+	 * we attempt to lower it to the default to ensure the test
+	 * can run with a reliably known boundary.
+	 */
+	ORIGINAL_MAX_VMA_COUNT = 0;
+
+	if (MAX_VMA_COUNT > DEFAULT_MAX_MAP_COUNT) {
+		ORIGINAL_MAX_VMA_COUNT = MAX_VMA_COUNT;
+
+		ksft_print_msg("Max VMA count is %d, lowering to default %d for test...\n",
+				MAX_VMA_COUNT, DEFAULT_MAX_MAP_COUNT);
+
+		if (!set_max_vma_count(DEFAULT_MAX_MAP_COUNT)) {
+			ksft_print_msg("WARNING: Failed to lower max_map_count to %d (requires root)n",
+					DEFAULT_MAX_MAP_COUNT);
+			ksft_print_msg("Skipping test. Please run as root: limit needs adjustment\n");
+
+			MAX_VMA_COUNT = ORIGINAL_MAX_VMA_COUNT;
+
+			return false;
+		}
+
+		/* Update MAX_VMA_COUNT for the test run */
+		MAX_VMA_COUNT = DEFAULT_MAX_MAP_COUNT;
+	}
+
+	initial_vma_count = get_current_vma_count();
+	if (initial_vma_count < 0) {
+		ksft_print_msg("Failed to read /proc/self/maps\n");
+		return false;
+	}
+
+	/*
+	 * Calculate how many extra mappings we need to create to reach
+	 * MAX_VMA_COUNT - 1 (excluding test area).
+	 */
+	NR_EXTRA_MAPS = MAX_VMA_COUNT - 1 - initial_vma_count;
+
+	if (NR_EXTRA_MAPS < 1) {
+		ksft_print_msg("Not enough available maps to run test\n");
+		ksft_print_msg("max_vma_count=%d, current_vma_count=%d\n",
+				MAX_VMA_COUNT, initial_vma_count);
+		return false;
+	}
+
+	/*
+	 * Reserve space for:
+	 * - Extra mappings with a 1-page gap after each (NR_EXTRA_MAPS * 2)
+	 * - The test area itself (TEST_AREA_NR_PAGES)
+	 * - The guard pages (NR_GUARDS)
+	 */
+	reservation_size = ((NR_EXTRA_MAPS * 2) +
+				TEST_AREA_NR_PAGES + NR_GUARDS) * PAGE_SIZE;
+
+	base_addr = mmap(NULL, reservation_size, PROT_NONE,
+			MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (base_addr == MAP_FAILED) {
+		ksft_print_msg("Failed tommap initial reservation\n");
+		return false;
+	}
+
+	if (munmap(base_addr, reservation_size) == -1) {
+		ksft_print_msg("Failed to munmap initial reservation\n");
+		return false;
+	}
+
+	/* Get the addr of the test area */
+	TEST_AREA = (char *)base_addr + GUARD_SIZE;
+
+	/*
+	 * Get the addr of the region for extra mappings:
+	 *     test area + 1 guard.
+	 */
+	EXTRA_MAPS = TEST_AREA + TEST_AREA_SIZE + GUARD_SIZE;
+
+	/* Create single-page mappings separated by unmapped pages */
+	ptr = EXTRA_MAPS;
+	for (int i = 0; i < NR_EXTRA_MAPS; ++i) {
+		if (mmap(ptr, PAGE_SIZE, EXTRA_MAP_PROT,
+			MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,
+			-1, 0) == MAP_FAILED) {
+			perror("mmap in fill loop");
+			ksft_print_msg("Failed on mapping #%d of %d\n", i + 1,
+					NR_EXTRA_MAPS);
+			return false;
+		}
+
+		/* Advance pointer by 2 to leave a gap */
+		ptr += (2 * EXTRA_MAP_SIZE);
+	}
+
+	if (!is_current_vma_count("test_suite_setup", MAX_VMA_COUNT - 1))
+		return false;
+
+	ksft_print_msg("vma_max_count test suite setup done.\n");
+
+	return true;
+}
+
+static void test_suite_teardown(void)
+{
+	if (ORIGINAL_MAX_VMA_COUNT && MAX_VMA_COUNT != ORIGINAL_MAX_VMA_COUNT) {
+		if (!set_max_vma_count(ORIGINAL_MAX_VMA_COUNT))
+			ksft_print_msg("Failed to restore max_map_count to %d\n",
+					ORIGINAL_MAX_VMA_COUNT);
+	}
+}
+
+/* --- Test Helper Functions --- */
+static bool mmap_anon(void)
+{
+	void *addr =  mmap(NULL, PAGE_SIZE, PROT_READ,
+			   MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+
+	/*
+	 * Handle cleanup here as the runner doesn't track where this,
+	 *mapping is located.
+	 */
+	if (addr != MAP_FAILED)
+		munmap(addr, PAGE_SIZE);
+
+	return addr != MAP_FAILED;
+}
+
+static inline bool __mprotect(char *addr, int size)
+{
+	int new_prot = ~TEST_AREA_PROT & (PROT_READ | PROT_WRITE | PROT_EXEC);
+
+	return mprotect(addr, size, new_prot) == 0;
+}
+
+static bool mprotect_nosplit(void)
+{
+	return __mprotect(TEST_AREA, TEST_AREA_SIZE);
+}
+
+static bool mprotect_2way_split(void)
+{
+	return __mprotect(TEST_AREA, TEST_AREA_SIZE - PAGE_SIZE);
+}
+
+static bool mprotect_3way_split(void)
+{
+	return __mprotect(TEST_AREA + PAGE_SIZE, PAGE_SIZE);
+}
+
+static inline bool __munmap(char *addr, int size)
+{
+	return munmap(addr, size) == 0;
+}
+
+static bool munmap_nosplit(void)
+{
+	return __munmap(TEST_AREA, TEST_AREA_SIZE);
+}
+
+static bool munmap_2way_split(void)
+{
+	return __munmap(TEST_AREA, TEST_AREA_SIZE - PAGE_SIZE);
+}
+
+static bool munmap_3way_split(void)
+{
+	return __munmap(TEST_AREA + PAGE_SIZE, PAGE_SIZE);
+}
+
+/* mremap accounts for the worst case to fail early */
+static const int MREMAP_REQUIRED_VMA_SLOTS = 6;
+
+static bool mremap_dontunmap(void)
+{
+	void *new_addr;
+
+	/*
+	 * Using MREMAP_DONTUNMAP will create a new mapping without
+	 * removing the old one, consuming one VMA slot.
+	 */
+	new_addr = mremap(TEST_AREA, TEST_AREA_SIZE, TEST_AREA_SIZE,
+			  MREMAP_MAYMOVE | MREMAP_DONTUNMAP, NULL);
+
+	if (new_addr != MAP_FAILED)
+		munmap(new_addr, TEST_AREA_SIZE);
+
+	return new_addr != MAP_FAILED;
+}
+
+struct test {
+	const char *name;
+	bool (*test)(void);
+	 /* How many VMA slots below the limit this test needs to start? */
+	int vma_slots_needed;
+	bool expect_success;
+};
+
+/* --- Test Cases --- */
+struct test tests[] = {
+	{
+		.name = "mmap_at_1_below_vma_count_limit",
+		.test = mmap_anon,
+		.vma_slots_needed = 1,
+		.expect_success = true,
+	},
+	{
+		.name = "mmap_at_vma_count_limit",
+		.test = mmap_anon,
+		.vma_slots_needed = 0,
+		.expect_success = false,
+	},
+	{
+		.name = "mprotect_nosplit_at_1_below_vma_count_limit",
+		.test = mprotect_nosplit,
+		.vma_slots_needed = 1,
+		.expect_success = true,
+	},
+	{
+		.name = "mprotect_nosplit_at_vma_count_limit",
+		.test = mprotect_nosplit,
+		.vma_slots_needed = 0,
+		.expect_success = true,
+	},
+	{
+		.name = "mprotect_2way_split_at_1_below_vma_count_limit",
+		.test = mprotect_2way_split,
+		.vma_slots_needed = 1,
+		.expect_success = true,
+	},
+	{
+		.name = "mprotect_2way_split_at_vma_count_limit",
+		.test = mprotect_2way_split,
+		.vma_slots_needed = 0,
+		.expect_success = false,
+	},
+	{
+		.name = "mprotect_3way_split_at_2_below_vma_count_limit",
+		.test = mprotect_3way_split,
+		.vma_slots_needed = 2,
+		.expect_success = true,
+	},
+	{
+		.name = "mprotect_3way_split_at_1_below_vma_count_limit",
+		.test = mprotect_3way_split,
+		.vma_slots_needed = 1,
+		.expect_success = false,
+	},
+	{
+		.name = "mprotect_3way_split_at_vma_count_limit",
+		.test = mprotect_3way_split,
+		.vma_slots_needed = 0,
+		.expect_success = false,
+	},
+	{
+		.name = "munmap_nosplit_at_1_below_vma_count_limit",
+		.test = munmap_nosplit,
+		.vma_slots_needed = 1,
+		.expect_success = true,
+	},
+	{
+		.name = "munmap_nosplit_at_vma_count_limit",
+		.test = munmap_nosplit,
+		.vma_slots_needed = 0,
+		.expect_success = true,
+	},
+	{
+		.name = "munmap_2way_split_at_1_below_vma_count_limit",
+		.test = munmap_2way_split,
+		.vma_slots_needed = 1,
+		.expect_success = true,
+	},
+	{
+		.name = "munmap_2way_split_at_vma_count_limit",
+		.test = munmap_2way_split,
+		.vma_slots_needed = 0,
+		.expect_success = true,
+	},
+	{
+		.name = "munmap_3way_split_at_2_below_vma_count_limit",
+		.test = munmap_3way_split,
+		.vma_slots_needed = 2,
+		.expect_success = true,
+	},
+	{
+		.name = "munmap_3way_split_at_1_below_vma_count_limit",
+		.test = munmap_3way_split,
+		.vma_slots_needed = 1,
+		.expect_success = true,
+	},
+	{
+		.name = "munmap_3way_split_at_vma_count_limit",
+		.test = munmap_3way_split,
+		.vma_slots_needed = 0,
+		.expect_success = false,
+	},
+	{
+		.name = "mremap_dontunmap_at_required_vma_count_capcity",
+		.test = mremap_dontunmap,
+		.vma_slots_needed = MREMAP_REQUIRED_VMA_SLOTS,
+		.expect_success = true,
+	},
+	{
+		.name = "mremap_dontunmap_at_1_below_required_vma_count_capacity",
+		.test = mremap_dontunmap,
+		.vma_slots_needed = MREMAP_REQUIRED_VMA_SLOTS - 1,
+		.expect_success = false,
+	},
+};
+
+/* --- Test Runner --- */
+int main(int argc, char **argv)
+{
+	int num_tests = ARRAY_SIZE(tests);
+	int failed_tests = 0;
+
+	ksft_set_plan(num_tests);
+
+	if (!test_suite_setup() != 0) {
+		if (MAX_VMA_COUNT > DEFAULT_MAX_MAP_COUNT)
+			ksft_exit_skip("max_map_count too high and cannot be lowered\n"
+					"Please rerun as root.\n");
+		else
+			ksft_exit_fail_msg("Test suite setup failed. Aborting.\n");
+
+	}
+
+	for (int i = 0; i < num_tests; i++) {
+		int maps_to_unmap = tests[i].vma_slots_needed;
+		const char *name = tests[i].name;
+		bool test_passed;
+
+		errno = 0;
+
+		/* 1. Setup: TEST_AREA mapping */
+		if (mmap(TEST_AREA, TEST_AREA_SIZE, TEST_AREA_PROT,
+			MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0)
+				== MAP_FAILED) {
+			ksft_test_result_fail(
+				"%s: Test setup failed to map TEST_AREA\n",
+				name);
+			maps_to_unmap = 0;
+			goto fail;
+		}
+
+		/* Label TEST_AREA to ease debugging */
+		if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, TEST_AREA,
+			TEST_AREA_SIZE, "TEST_AREA")) {
+			ksft_print_msg("WARNING: [%s] prctl(PR_SET_VMA) failed\n",
+					name);
+			ksft_print_msg(
+				"Continuing without named TEST_AREA mapping\n");
+		}
+
+		/* 2. Setup: Adjust VMA count based on test requirements */
+		if (maps_to_unmap > NR_EXTRA_MAPS) {
+			ksft_test_result_fail(
+				"%s: Test setup failed: Invalid VMA slots required %d\n",
+				name, tests[i].vma_slots_needed);
+			maps_to_unmap = 0;
+			goto fail;
+		}
+
+		/* Unmap extra mappings, accounting for the 1-page gap */
+		for (int j = 0; j < maps_to_unmap; j++)
+			munmap(EXTRA_MAPS + (j * 2 * EXTRA_MAP_SIZE),
+				EXTRA_MAP_SIZE);
+
+		/*
+		 * 3. Verify the preconditions.
+		 *
+		 *    Sometimes there isn't an easy way to determine the cause
+		 *    of the test failure.
+		 *    e.g. an mprotect ENOMEM may be due to trying to protect
+		 *         unmapped area or due to hitting MAX_VMA_COUNT limit.
+		 *
+		 *    We verify the preconditions of the test to ensure any
+		 *    expected failures are from the expected cause and not
+		 *    coincidental.
+		 */
+		if (!is_current_vma_count(name,
+			MAX_VMA_COUNT - tests[i].vma_slots_needed))
+			goto fail;
+
+		if (!is_test_area_mapped(name))
+			goto fail;
+
+		/* 4. Run the test */
+		test_passed = (tests[i].test() == tests[i].expect_success);
+		if (test_passed) {
+			ksft_test_result_pass("%s\n", name);
+		} else {
+fail:
+			failed_tests++;
+			ksft_test_result_fail(
+				"%s: current_vma_count=%d,max_vma_count=%d: errno: %d (%s)\n",
+				name, get_current_vma_count(), MAX_VMA_COUNT,
+				errno, strerror(errno));
+			print_surrounding_maps(name);
+		}
+
+		/* 5. Teardown: Unmap TEST_AREA. */
+		munmap(TEST_AREA, TEST_AREA_SIZE);
+
+		/* 6. Teardown: Restore extra mappings to test suite baseline */
+		for (int j = 0; j < maps_to_unmap; j++) {
+			/* Remap extra mappings, accounting for the gap */
+			mmap(EXTRA_MAPS + (j * 2 * EXTRA_MAP_SIZE),
+				EXTRA_MAP_SIZE, EXTRA_MAP_PROT,
+				MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,
+				-1, 0);
+		}
+	}
+
+	test_suite_teardown();
+
+	if (failed_tests > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
+
+/* --- Utilities --- */
+
+static int get_max_vma_count(void)
+{
+	int max_count;
+	FILE *f;
+
+	f = fopen("/proc/sys/vm/max_map_count", "r");
+	if (!f)
+		return -1;
+
+	if (fscanf(f, "%d", &max_count) != 1)
+		max_count = -1;
+
+
+	fclose(f);
+
+	return max_count;
+}
+
+static bool set_max_vma_count(int val)
+{
+	FILE *f;
+	bool success = false;
+
+	f = fopen("/proc/sys/vm/max_map_count", "w");
+	if (!f)
+		return false;
+
+	if (fprintf(f, "%d", val) > 0)
+		success = true;
+
+	fclose(f);
+	return success;
+}
+
+static int get_current_vma_count(void)
+{
+	char line[1024];
+	int count = 0;
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -1;
+
+	while (fgets(line, sizeof(line), f)) {
+		if (!strstr(line, "[vsyscall]"))
+			count++;
+	}
+
+	fclose(f);
+
+	return count;
+}
+
+static bool is_current_vma_count(const char *msg, int expected)
+{
+	int current = get_current_vma_count();
+
+	if (current == expected)
+		return true;
+
+	ksft_print_msg("%s: vma count is %d, expected %d\n", msg, current,
+			expected);
+	return false;
+}
+
+static bool is_test_area_mapped(const char *msg)
+{
+	unsigned long search_start = (unsigned long)TEST_AREA;
+	unsigned long search_end = search_start + TEST_AREA_SIZE;
+	bool found = false;
+	char line[1024];
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f) {
+		ksft_print_msg("failed to open /proc/self/maps\n");
+		return false;
+	}
+
+	while (fgets(line, sizeof(line), f)) {
+		unsigned long start, end;
+
+		if (sscanf(line, "%lx-%lx", &start, &end) != 2)
+			continue;
+
+		/* Check for an exact match of the range */
+		if (start == search_start && end == search_end) {
+			found = true;
+			break;
+		} else if (start > search_end) {
+			/*
+			 *Since maps are sorted, if we've passed the end, we
+			 * can stop searching.
+			 */
+			break;
+		}
+	}
+
+	fclose(f);
+
+	if (found)
+		return true;
+
+	/* Not found */
+	ksft_print_msg(
+		"%s: TEST_AREA is not mapped as a single contiguous block.\n",
+		msg);
+	print_surrounding_maps(msg);
+
+	return false;
+}
+
+static void print_surrounding_maps(const char *msg)
+{
+	unsigned long search_start = (unsigned long)TEST_AREA;
+	unsigned long search_end = search_start + TEST_AREA_SIZE;
+	unsigned long start;
+	unsigned long end;
+	char line[1024] = {};
+	int line_idx = 0;
+	int first_match_idx = -1;
+	int last_match_idx = -1;
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return;
+
+	if (msg)
+		ksft_print_msg("%s\n", msg);
+
+	ksft_print_msg("--- Surrounding VMA entries for TEST_AREA (%p) ---\n",
+			TEST_AREA);
+
+	/* First pass: Read all lines and find the range of matching entries */
+	fseek(f, 0, SEEK_SET); /* Rewind file */
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "%lx-%lx", &start, &end) != 2) {
+			line_idx++;
+			continue;
+		}
+
+		/* Check for any overlap */
+		if (start < search_end && end > search_start) {
+			if (first_match_idx == -1)
+				first_match_idx = line_idx;
+			last_match_idx = line_idx;
+		} else if (start > search_end) {
+			/*
+			 * Since maps are sorted, if we've passed the end, we
+			 * can stop searching.
+			 */
+			break;
+		}
+
+		line_idx++;
+	}
+
+	if (first_match_idx == -1) {
+		ksft_print_msg("TEST_AREA (%p) is not currently mapped.\n",
+				TEST_AREA);
+	} else {
+		/* Second pass: Print the relevant lines */
+		fseek(f, 0, SEEK_SET); /* Rewind file */
+		line_idx = 0;
+		while (fgets(line, sizeof(line), f)) {
+			/* Print 2 lines before the first match */
+			if (line_idx >= first_match_idx - 2 &&
+				line_idx < first_match_idx)
+				ksft_print_msg("   %s", line);
+
+			/* Print all matching TEST_AREA entries */
+			if (line_idx >= first_match_idx &&
+				line_idx <= last_match_idx)
+				ksft_print_msg(">> %s", line);
+
+			/* Print 2 lines after the last match */
+			if (line_idx > last_match_idx &&
+				line_idx <= last_match_idx + 2)
+				ksft_print_msg("   %s", line);
+
+			line_idx++;
+		}
+	}
+
+	ksft_print_msg("--------------------------------------------------\n");
+
+	fclose(f);
+}
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 471e539d82b8..3794b50ec280 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -49,6 +49,8 @@ separated by spaces:
 	test madvise(2) MADV_GUARD_INSTALL and MADV_GUARD_REMOVE options
 - madv_populate
 	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
+- max_vma_count
+	tests for max vma_count
 - memfd_secret
 	test memfd_secret(2)
 - process_mrelease
@@ -417,6 +419,9 @@ fi # VADDR64
 # vmalloc stability smoke test
 CATEGORY="vmalloc" run_test bash ./test_vmalloc.sh smoke
 
+# test operations against max vma count limit
+CATEGORY="max_vma_count" run_test ./max_vma_count_tests
+
 CATEGORY="mremap" run_test ./mremap_dontunmap
 
 CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
-- 
2.51.0.384.g4c02a37b29-goog


