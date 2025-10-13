Return-Path: <linux-fsdevel+bounces-64058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7951ABD6CDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 01:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC9419A278F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D17D2FBE18;
	Mon, 13 Oct 2025 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQtvl4Xl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100962EC0B7
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399762; cv=none; b=V/r9JdFQsogAcHBYXuvVWg7ftjYVfS97RUIrT3FbNpoFPPMQrrEPT8Ior6eJmpjoLpihilKVIclmUu8p2ZXrL+EQp3f+UfdlDvTcvZtqYF4+t1sVkdmXeEYUQI/AbXxgTJmAVrXMcGQ4hZXcaR+7mZDWe7IjIuIODB3YGa87LUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399762; c=relaxed/simple;
	bh=FZIguKZiZcKpeMwOLFZQs0XueVfmkOK0/W8soUIla/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OEQHaSIxmWYkPsVQ1kFrGUqeD/5h6isS1RxoES5vGvHHfwhAj8ry5jbxaApATGFW8T2PCHnZ34m3WkRozY31kl3c7cFRdn1Jj8Gba/t4DUEqx3DO0FE7MyL02g/kLX1vfN+f2RA5OqAgz8xCHpM8qcki5KWG02CAayLn9gDromw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQtvl4Xl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so8971779a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760399758; x=1761004558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6p2Gmm9GtTiEQdmbv7JHe7F8yU5Dt+w0nJ/mtKbQefE=;
        b=tQtvl4XlLGiSOOMcFwKATW3Y76p5yLN49pqhxeNdLYqZ6fcZWmiPORJEncSrq0EIXe
         akJaOmW8yUMcZg4zW6JMjaJraVE+TgfHRnhxCBF/0nTiiuthMtVZTrzRSpDmPereLtFX
         jF6xLoV47Vx6GMTxEnfUNp9WQC8jrDGfrtbU9eNwMudfTT3XclB+pa4Zr/A2QxrlbLRc
         tlRw3rbFNlVFq2QOVv9Ekl4gigmw+6g53Z3ObJOeLteRKy2+8j+y0E2RwI6PYcR0VYyo
         TnqMciEXhh5wRP0CrRUH/ZFFXGcSeTnBTTqnlyuhF/+xxy94DPiFgRU2bPJG3See7ZgA
         SD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399758; x=1761004558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6p2Gmm9GtTiEQdmbv7JHe7F8yU5Dt+w0nJ/mtKbQefE=;
        b=tJI/bUOEwSx7VOT/pO1lYemQrhmsyylsMxrz3jfb7nsDwruEMKwp0Fc9jy+4lwaqS8
         bhmJwrghGqN+lNGftedtB3wx8jPR1SteC5A2mhm9fMwdLFHWFC44pJ9J/iW5PwGaDZX1
         eK1ko33C/MJwh+QNtGk3NTytyY7ea7lEYUTxISYgfKrmKa6Bxtywx6eUq1Qff9NzuPWR
         1z9BZJZqi87NGDbI4RHWfzOlNozV4p6PC7KU5k/hunrcyGeJik4HoGafsI9nxeL7dm05
         TwSdFAV+1+3kkuvBAQc8MqP0ky6VHccXXD1P0D7DOtOVy4lYqjRjzq6+kV1NbjASDYdp
         3MPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCjhf+wUK80yBGpDgWKeK0W55GDWCgEzCBSoIF/hAoQ8jWvJTO/BG7El/XG5gO1eXSxh8WBJ+lGpFJzIWb@vger.kernel.org
X-Gm-Message-State: AOJu0YxNvJzf84zfRWdACMH6bGKz9OzNOo9JE6QApP9U2nNbyDvzbJTU
	5Km+Ix6ohb7aWn84TYoC5XtsXD0jFrrbBDmzuy/DQYShjPIJ+zsUKVN/z3eMakk2byEaWXKmOhj
	0rF3ShdxwKka53C84KdtPAZ7BZw==
X-Google-Smtp-Source: AGHT+IHhEwrS3IPzet5E/srq6uBByaIE766KKBgKWp333caW+apU3r/fUvgm9e93/+DRYdrbE6IkdsCUBvqSiVDuog==
X-Received: from pjbrs12.prod.google.com ([2002:a17:90b:2b8c:b0:334:1935:56cc])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d0a:b0:32e:87f6:f5a6 with SMTP id 98e67ed59e1d1-33b50f2300dmr31575363a91.0.1760399758339;
 Mon, 13 Oct 2025 16:55:58 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:51:53 -0700
In-Reply-To: <20251013235259.589015-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013235259.589015-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251013235259.589015-3-kaleshsingh@google.com>
Subject: [PATCH v3 2/5] mm/selftests: add max_vma_count tests
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
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

Changes in v3:
 - Rewrite test using kselftest harness, per Lorenzo
 - Update test diagram to be vertical so as to not exceed 80 chars, per Lorenzo
 - Use vm_util.h helpers, per Lorenzo
 - Update .gitignore, per Lorenzo
 - Add max_vma_count_tests to MEMORY MAPPING section in MAINTAINERS, per
   Lorenzo
 - Remove /proc/*/maps debugging prints and globals, per Lorenzo
 - rename guard regions to holes to avoid confusion with VMA guard
   regions, per David

Changes in v2:
 - Add tests, per Liam (note that the do_brk_flags() path is not easily
   tested from userspace, so it's not included here). Exceeding the limit there
   should be uncommon.

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/max_vma_count_tests.c        | 672 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   5 +
 5 files changed, 680 insertions(+)
 create mode 100644 tools/testing/selftests/mm/max_vma_count_tests.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..aa83e5893e16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16580,6 +16580,7 @@ F:	mm/vma.h
 F:	mm/vma_exec.c
 F:	mm/vma_init.c
 F:	mm/vma_internal.h
+F:	tools/testing/selftests/mm/max_vma_count_tests.c
 F:	tools/testing/selftests/mm/merge.c
 F:	tools/testing/vma/
 
diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index c2a8586e51a1..010f1bced5b9 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -10,6 +10,7 @@ hugetlb-soft-offline
 khugepaged
 map_hugetlb
 map_populate
+max_vma_count_tests
 thuge-gen
 compaction_test
 migration
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eaf9312097f7..4f0b03cdece5 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -93,6 +93,7 @@ TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
 TEST_GEN_FILES += uffd-unit-tests
 TEST_GEN_FILES += uffd-wp-mremap
+TEST_GEN_FILES += max_vma_count_tests
 TEST_GEN_FILES += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 TEST_GEN_FILES += ksm_functional_tests
diff --git a/tools/testing/selftests/mm/max_vma_count_tests.c b/tools/testing/selftests/mm/max_vma_count_tests.c
new file mode 100644
index 000000000000..2c69c6986633
--- /dev/null
+++ b/tools/testing/selftests/mm/max_vma_count_tests.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google LLC
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/prctl.h>  /* Definition of PR_* constants */
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+
+#define TH_LOG_ENABLED			0
+#include "../kselftest_harness.h"
+#include "vm_util.h"
+
+#define DEFAULT_MAX_MAP_COUNT		65530
+#define TEST_AREA_NR_PAGES		3
+#define TEST_AREA_PROT			(PROT_NONE)
+#define EXTRA_MAP_PROT			(PROT_NONE)
+
+/* mremap accounts for the worst case to fail early */
+#define MREMAP_REQUIRED_VMA_SLOTS	6
+
+FIXTURE(max_vma_count) {
+	int max_vma_count;
+	int original_max_vma_count;
+	int test_area_size;
+	int nr_extra_maps;
+	char *test_area;
+	char *extra_maps;
+};
+
+/* To keep checkpatch happy */
+#define max_vma_count_data_t FIXTURE_DATA(max_vma_count)
+
+static int get_max_vma_count(void);
+static bool set_max_vma_count(int val);
+static int get_current_vma_count(void);
+static bool is_test_area_mapped(char *test_area, int test_area_size);
+static bool lower_max_map_count_if_needed(max_vma_count_data_t *self,
+					  struct __test_metadata *_metadata);
+static void restore_max_map_count_if_needed(max_vma_count_data_t *self,
+					    struct __test_metadata *_metadata);
+static bool free_vma_slots(max_vma_count_data_t *self, int slots_to_free);
+static void create_reservation(max_vma_count_data_t *self,
+			       struct __test_metadata *_metadata);
+static void create_extra_maps(max_vma_count_data_t *self,
+			      struct __test_metadata *_metadata);
+
+/**
+ * FIXTURE_SETUP - Sets up the VMA layout for max VMA count testing.
+ *
+ * Sets up a specific VMA layout to test behavior near the max_vma_count limit.
+ * A large memory area is reserved and then unmapped to create a contiguous
+ * address space. Mappings are then created within this space.
+ *
+ * The layout is as follows (addresses increase downwards):
+ *
+ *  base_addr --> +----------------------+
+ *                |      Hole (1 page)   |
+ *                +----------------------+
+ *  TEST_AREA --> |      TEST_AREA       |
+ *                | (unmapped, 3 pages)  |
+ *                +----------------------+
+ *                |      Hole (1 page)   |
+ *                +----------------------+
+ * EXTRA_MAPS --> | Extra Map 1 (1 page) |
+ *                +----------------------+
+ *                |      Hole (1 page)   |
+ *                +----------------------+
+ *                | Extra Map 2 (1 page) |
+ *                +----------------------+
+ *                |         ...          |
+ *                +----------------------+
+ *                | Extra Map N (1 page) |
+ *                +----------------------+
+ *                |      Hole (1 page)   |
+ *                +----------------------+
+ *
+ * "Holes" are unmapped, 1-page gaps used to isolate mappings.
+ * The number of "Extra Maps" is calculated to bring the total VMA count
+ * to MAX_VMA_COUNT - 1.
+ *
+ * Populates TEST_AREA and other globals required for the tests.
+ *
+ * Return: true on success, false on failure.
+ */
+FIXTURE_SETUP(max_vma_count)
+{
+	int initial_vma_count;
+
+	TH_LOG("Setting up vma_max_count test ...");
+
+	self->test_area_size = TEST_AREA_NR_PAGES * psize();
+
+	if (!lower_max_map_count_if_needed(self, _metadata)) {
+		SKIP(return,
+		     "max_map_count too high and cannot be lowered. Please rerun as root.");
+	}
+
+	initial_vma_count = get_current_vma_count();
+	ASSERT_GT(initial_vma_count, 0);
+
+	self->nr_extra_maps = self->max_vma_count - 1 - initial_vma_count;
+	if (self->nr_extra_maps < 1) {
+		SKIP(return,
+		    "Not enough available maps to run test (max: %d, current: %d)",
+		     self->max_vma_count, initial_vma_count);
+	}
+
+	create_reservation(self, _metadata);
+	create_extra_maps(self, _metadata);
+
+	ASSERT_EQ(get_current_vma_count(), self->max_vma_count - 1);
+	TH_LOG("vma_max_count test setup done.");
+}
+
+FIXTURE_TEARDOWN(max_vma_count)
+{
+	/*
+	 * NOTE: Each test is run in a separate process; we leave
+	 * mapping cleanup to process teardown for simplicity.
+	 */
+
+	restore_max_map_count_if_needed(self, _metadata);
+}
+
+static bool mmap_anon(max_vma_count_data_t *self)
+{
+	void *addr =  mmap(NULL, psize(), PROT_READ,
+			   MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
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
+static bool mprotect_nosplit(max_vma_count_data_t *self)
+{
+	return __mprotect(self->test_area, self->test_area_size);
+}
+
+static bool mprotect_2way_split(max_vma_count_data_t *self)
+{
+	return __mprotect(self->test_area, self->test_area_size - psize());
+}
+
+static bool mprotect_3way_split(max_vma_count_data_t *self)
+{
+	return __mprotect(self->test_area + psize(), psize());
+}
+
+static inline bool __munmap(char *addr, int size)
+{
+	return munmap(addr, size) == 0;
+}
+
+static bool munmap_nosplit(max_vma_count_data_t *self)
+{
+	return __munmap(self->test_area, self->test_area_size);
+}
+
+static bool munmap_2way_split(max_vma_count_data_t *self)
+{
+	return __munmap(self->test_area, self->test_area_size - psize());
+}
+
+static bool munmap_3way_split(max_vma_count_data_t *self)
+{
+	return __munmap(self->test_area + psize(), psize());
+}
+
+static bool mremap_dontunmap(max_vma_count_data_t *self)
+{
+	/*
+	 * Using MREMAP_DONTUNMAP will create a new mapping without
+	 * removing the old one, consuming one VMA slot.
+	 */
+	return mremap(self->test_area, self->test_area_size,
+		      self->test_area_size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+		      NULL) != MAP_FAILED;
+}
+
+TEST_F(max_vma_count, mmap_at_1_below_vma_count_limit)
+{
+	int vma_slots_needed = 1;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(mmap_anon(self));
+}
+
+TEST_F(max_vma_count, mmap_at_vma_count_limit)
+{
+	int vma_slots_needed = 0;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_FALSE(mmap_anon(self));
+}
+
+TEST_F(max_vma_count, mprotect_nosplit_at_1_below_vma_count_limit)
+{
+	int vma_slots_needed = 1;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(mprotect_nosplit(self));
+}
+
+TEST_F(max_vma_count, mprotect_nosplit_at_vma_count_limit)
+{
+	int vma_slots_needed = 0;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(mprotect_nosplit(self));
+}
+
+TEST_F(max_vma_count, mprotect_2way_split_at_1_below_vma_count_limit)
+{
+	int vma_slots_needed = 1;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(mprotect_2way_split(self));
+}
+
+TEST_F(max_vma_count, mprotect_2way_split_at_vma_count_limit)
+{
+	int vma_slots_needed = 0;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_FALSE(mprotect_2way_split(self));
+}
+
+TEST_F(max_vma_count, mprotect_3way_split_at_2_below_vma_count_limit)
+{
+	int vma_slots_needed = 2;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(mprotect_3way_split(self));
+}
+
+TEST_F(max_vma_count, mprotect_3way_split_at_1_below_vma_count_limit)
+{
+	int vma_slots_needed = 1;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_FALSE(mprotect_3way_split(self));
+}
+
+TEST_F(max_vma_count, mprotect_3way_split_at_vma_count_limit)
+{
+	int vma_slots_needed = 0;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_FALSE(mprotect_3way_split(self));
+}
+
+TEST_F(max_vma_count, munmap_nosplit_at_1_below_vma_count_limit)
+{
+	int vma_slots_needed = 1;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(munmap_nosplit(self));
+}
+
+TEST_F(max_vma_count, munmap_nosplit_at_vma_count_limit)
+{
+	int vma_slots_needed = 0;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(munmap_nosplit(self));
+}
+
+TEST_F(max_vma_count, munmap_2way_split_at_1_below_vma_count_limit)
+{
+	int vma_slots_needed = 1;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(munmap_2way_split(self));
+}
+
+TEST_F(max_vma_count, munmap_2way_split_at_vma_count_limit)
+{
+	int vma_slots_needed = 0;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(munmap_2way_split(self));
+}
+
+TEST_F(max_vma_count, munmap_3way_split_at_2_below_vma_count_limit)
+{
+	int vma_slots_needed = 2;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(munmap_3way_split(self));
+}
+
+TEST_F(max_vma_count, munmap_3way_split_at_1_below_vma_count_limit)
+{
+	int vma_slots_needed = 1;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(munmap_3way_split(self));
+}
+
+TEST_F(max_vma_count, munmap_3way_split_at_vma_count_limit)
+{
+	int vma_slots_needed = 0;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_FALSE(munmap_3way_split(self));
+}
+
+TEST_F(max_vma_count, mremap_dontunmap_at_required_vma_count_capcity)
+{
+	int vma_slots_needed = MREMAP_REQUIRED_VMA_SLOTS;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_TRUE(mremap_dontunmap(self));
+}
+
+TEST_F(max_vma_count, mremap_dontunmap_at_1_below_required_vma_count_capacity)
+{
+	int vma_slots_needed = MREMAP_REQUIRED_VMA_SLOTS - 1;
+
+	ASSERT_NE(mmap(self->test_area, self->test_area_size, TEST_AREA_PROT,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0),
+		  MAP_FAILED);
+
+	ASSERT_TRUE(free_vma_slots(self, vma_slots_needed));
+
+	ASSERT_EQ(get_current_vma_count(),
+		  self->max_vma_count - vma_slots_needed);
+	ASSERT_TRUE(is_test_area_mapped(self->test_area, self->test_area_size));
+
+	ASSERT_FALSE(mremap_dontunmap(self));
+}
+
+TEST_HARNESS_MAIN
+
+/* --- Utilities --- */
+
+static bool lower_max_map_count_if_needed(max_vma_count_data_t *self,
+			      struct __test_metadata *_metadata)
+{
+	self->max_vma_count = get_max_vma_count();
+
+	ASSERT_GT(self->max_vma_count, 0);
+
+	self->original_max_vma_count = 0;
+	if (self->max_vma_count > DEFAULT_MAX_MAP_COUNT) {
+		self->original_max_vma_count = self->max_vma_count;
+		TH_LOG("Max VMA count: %d; lowering to default %d for test...",
+		       self->max_vma_count, DEFAULT_MAX_MAP_COUNT);
+
+		if (!set_max_vma_count(DEFAULT_MAX_MAP_COUNT))
+			return false;
+		self->max_vma_count = DEFAULT_MAX_MAP_COUNT;
+	}
+	return true;
+}
+
+static void restore_max_map_count_if_needed(max_vma_count_data_t *self,
+					    struct __test_metadata *_metadata)
+{
+	if (!self->original_max_vma_count)
+		return;
+
+	if (self->max_vma_count == self->original_max_vma_count)
+		return;
+
+	if (!set_max_vma_count(self->original_max_vma_count))
+		TH_LOG("Failed to restore max_map_count to %d",
+			self->original_max_vma_count);
+}
+
+static int get_max_vma_count(void)
+{
+	unsigned long val;
+	int ret;
+
+	ret = read_sysfs("/proc/sys/vm/max_map_count", &val);
+	if (ret)
+		return -1;
+	return val;
+}
+
+static bool set_max_vma_count(int val)
+{
+	return write_sysfs("/proc/sys/vm/max_map_count", val) == 0;
+}
+
+static int get_current_vma_count(void)
+{
+	struct procmap_fd pmap;
+	int count = 0;
+	int ret;
+	char vma_name[PATH_MAX];
+
+	ret = open_self_procmap(&pmap);
+	if (ret)
+		return -1;
+
+	pmap.query.query_addr = 0;
+	pmap.query.query_flags = PROCMAP_QUERY_COVERING_OR_NEXT_VMA;
+
+	while (true) {
+		pmap.query.vma_name_addr = (uint64_t)(uintptr_t)vma_name;
+		pmap.query.vma_name_size = sizeof(vma_name);
+		vma_name[0] = '\0';
+
+		ret = query_procmap(&pmap);
+		if (ret != 0)
+			break;
+
+		/*
+		 * The [vsyscall] mapping is a special mapping that
+		 * doesn't count against the max_map_count limit.
+		 * Ignore it here to match the kernel's accounting.
+		 */
+		if (strcmp(vma_name, "[vsyscall]") != 0)
+			count++;
+
+		pmap.query.query_addr = pmap.query.vma_end;
+	}
+
+	close_procmap(&pmap);
+	return count;
+}
+
+static void create_reservation(max_vma_count_data_t *self,
+			       struct __test_metadata *_metadata)
+{
+	size_t reservation_size;
+	void *base_addr = NULL;
+
+	/*
+	 * To break the dependency on knowing the exact number of extra maps
+	 * before creating the reservation, we allocate a reservation size
+	 * large enough for the maximum possible number of extra maps.
+	 * The maximum number of extra maps is bounded by max_vma_count.
+	 */
+	reservation_size = ((self->max_vma_count * 2) +
+				TEST_AREA_NR_PAGES +
+				2 /* Holes around TEST_AREA */) * psize();
+
+	base_addr = mmap(NULL, reservation_size, PROT_NONE,
+			MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(base_addr, MAP_FAILED);
+
+	ASSERT_EQ(munmap(base_addr, reservation_size), 0);
+
+	/* The test area is offset by one hole page from the base address. */
+	self->test_area = (char *)base_addr + psize();
+
+	/* The extra maps start after the test area and another hole page. */
+	self->extra_maps = self->test_area + self->test_area_size + psize();
+}
+
+static void create_extra_maps(max_vma_count_data_t *self,
+			    struct __test_metadata *_metadata)
+{
+	char *ptr = self->extra_maps;
+
+	for (int i = 0; i < self->nr_extra_maps; ++i) {
+		ASSERT_NE(mmap(ptr, psize(), EXTRA_MAP_PROT,
+			MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,
+			-1, 0), MAP_FAILED) {
+			TH_LOG("Failed on mapping #%d of %d", i + 1,
+				self->nr_extra_maps);
+		}
+
+		/*
+		 * Advance pointer by two pages to leave a 1-page hole,
+		 * after each 1-page map.
+		 */
+		ptr += (2 * psize());
+	}
+}
+
+static bool free_vma_slots(max_vma_count_data_t *self, int slots_to_free)
+{
+	for (int i = 0; i < slots_to_free; i++) {
+		if (munmap(self->extra_maps + (i * 2 * psize()), psize()) != 0)
+			return false;
+	}
+
+	return true;
+}
+
+static bool is_test_area_mapped(char *test_area, int test_area_size)
+{
+	struct procmap_fd pmap;
+	bool found = false;
+	int ret;
+
+	ret = open_self_procmap(&pmap);
+	if (ret)
+		return false;
+
+	pmap.query.query_addr = (uint64_t)(uintptr_t)test_area;
+	pmap.query.query_flags = 0; /* Find VMA covering address */
+
+	if (query_procmap(&pmap) == 0 &&
+	    pmap.query.vma_start == (unsigned long)test_area &&
+	    pmap.query.vma_end == (unsigned long)test_area + test_area_size)
+		found = true;
+
+	close_procmap(&pmap);
+	return found;
+}
+
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index d9173f2312b7..a85db61e6a92 100755
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
@@ -426,6 +428,9 @@ fi # VADDR64
 # vmalloc stability smoke test
 CATEGORY="vmalloc" run_test bash ./test_vmalloc.sh smoke
 
+# test operations against max vma count limit
+CATEGORY="max_vma_count" run_test ./max_vma_count_tests
+
 CATEGORY="mremap" run_test ./mremap_dontunmap
 
 CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
-- 
2.51.0.760.g7b8bcc2412-goog


