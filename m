Return-Path: <linux-fsdevel+bounces-55075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29BCB06BE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 05:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE0174F56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 03:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33702797BE;
	Wed, 16 Jul 2025 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xbg4ULlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C8275B02
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635165; cv=none; b=MkxRuQH5Y3pEwGCSgiQsfNK0uMJ4f+OES9Y6yU/3xV8y9TOLmA3VOf9A6DEyQqnJJdCASINMIMwYCgr6G+4JdTc22KxbcByZdOFijkmE9WtzimduqljbozUfwYRF4wQrOIGCeWtg1IlkpYUDmncbCFRCiTDWDbzYP1nWOiVWC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635165; c=relaxed/simple;
	bh=jRnrVoMZdZS4l+fMWfTBazH3LP8URmBuww3v7sYZO+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ee75MRoaDcFHC0mwKvA/HW29wI64zQ9Fkgz/Qv6MDZOmLvu1Ob84+vqwFQs1PsQGtn5grbDsshb5DxIMcpX484XcDQLtoG8jL5YbF2ZWeQDdou8Aba91ZB+6n7PjUNtxOir+w6Y8/s4VNbgy7U3e/QNUvKEXa3OZplsLDJyTCcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xbg4ULlj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23824a9bc29so80975295ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752635163; x=1753239963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/p/DdbsN4UfikZMzfuS86WplKsUwY/RIZs4YxJfzTQ=;
        b=xbg4ULljJ81BE+rn2QW+94GL9rlZOFXGbMgmj8ciQ4nbX5qvD1iB9TdQ8VeQvvPIFd
         V87MVUOlnXs7mYI6idyzol3rdw/jp/g3ePlsqOYgo0ogT1xs2rvaMHFu75iGpgzEu8oD
         vLfmrCrLZ//5UohNnlcf+g+r9vaYLqC1iai0Sfr8uECSu2AyhhVJ3842MXEo0ALEMJ6Y
         5X3q7LuymEyzevrav9tASVlX8nG4A8jz1uE096T0niTP+uSmjp+iTpZk8mpaPvxrZbDB
         8OWIrJkAbKl+3z0pQdciBXyk+FHuaBjYhmDuckUHufMiojgk7C1FhUsLBRnaL2hjdH70
         zsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635163; x=1753239963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/p/DdbsN4UfikZMzfuS86WplKsUwY/RIZs4YxJfzTQ=;
        b=pYWwzLFnLL9yW/K1hXumhOHIQufC/WjCsk9jD3m+Gwo64QW/6vT8H0I5HzgLicSZtb
         0YreFGzcjwHneB+uVZvGaXcwDXiq433S32H4fqdAG5te5uh4OLYgdx3/jtSXgzVAYVVJ
         4Mvz0gSB5wVJNWrFAGG1jQOUvlPMWwKaMXdcrpaj66Z3renDa4MDJohKrae6zUUfnDrB
         LL0LNhs1fO3OLnZVdEim3B/ViVsSsYw0NR7wjYt5Eg1V+ucsO52RnecZEGiKBfKnV73K
         7g5CjVOakOGWA8EvWwCJH5fiLnmFPZCMhrgCcsuwlTaqBa4mZMr8ge0SmNAV5vj1bfhm
         152Q==
X-Forwarded-Encrypted: i=1; AJvYcCWskMQYMjoB4mGbNaGWUDpd63XJKy96+KlhK0NMQm213gP1XiLXK5pK2JGhE+ljmm0OJCep+Mk6HrZyrGRm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8sDurSm2D1BJW67Wv5bTmqHosYHFYOCqb1xC4rnoFUhVdhrvp
	sW4g37enGi8I3kSqrCxcYGDi7th8qBkzzWXV+oPTEkTiUlPP2pUP50hB1LC8EutlMNd11eGSAUb
	2dcc4mg==
X-Google-Smtp-Source: AGHT+IFkGF1q6aNwe/z61qYASsZHamHAnhQ/1g6q37bnaz7nWNnHIZmPUI8XdM35nyPrXnVy2DEFTGAWCzc=
X-Received: from pjkk15.prod.google.com ([2002:a17:90b:57ef:b0:31c:2fe4:33b8])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:189:b0:234:a139:1216
 with SMTP id d9443c01a7336-23e25763d12mr18236815ad.44.1752635162726; Tue, 15
 Jul 2025 20:06:02 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:05:50 -0700
In-Reply-To: <20250716030557.1547501-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716030557.1547501-2-surenb@google.com>
Subject: [PATCH v7 1/7] selftests/proc: add /proc/pid/maps tearing from vma
 split test
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

The /proc/pid/maps file is generated page by page, with the mmap_lock
released between pages.  This can lead to inconsistent reads if the
underlying vmas are concurrently modified. For instance, if a vma split
or merge occurs at a page boundary while /proc/pid/maps is being read,
the same vma might be seen twice: once before and once after the change.
This duplication is considered acceptable for userspace handling.
However, observing a "hole" where a vma should be (e.g., due to a vma
being replaced and the space temporarily being empty) is unacceptable.

Implement a test that:
1. Forks a child process which continuously modifies its address space,
specifically targeting a vma at the boundary between two pages.
2. The parent process repeatedly reads the child's /proc/pid/maps.
3. The parent process checks the last vma of the first page and
the first vma of the second page for consistency, looking for the
effects of vma splits or merges.

The test duration is configurable via the -d command-line parameter
in seconds to increase the likelihood of catching the race condition.
The default test duration is 5 seconds.

Example Command: proc-maps-race -d 10

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/.gitignore       |   1 +
 tools/testing/selftests/proc/Makefile         |   1 +
 tools/testing/selftests/proc/proc-maps-race.c | 459 ++++++++++++++++++
 3 files changed, 461 insertions(+)
 create mode 100644 tools/testing/selftests/proc/proc-maps-race.c

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 973968f45bba..19bb333e2485 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -5,6 +5,7 @@
 /proc-2-is-kthread
 /proc-fsconfig-hidepid
 /proc-loadavg-001
+/proc-maps-race
 /proc-multiple-procfs
 /proc-empty-vm
 /proc-pid-vm
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index b12921b9794b..50aba102201a 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -9,6 +9,7 @@ TEST_GEN_PROGS += fd-002-posix-eq
 TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-2-is-kthread
 TEST_GEN_PROGS += proc-loadavg-001
+TEST_GEN_PROGS += proc-maps-race
 TEST_GEN_PROGS += proc-empty-vm
 TEST_GEN_PROGS += proc-pid-vm
 TEST_GEN_PROGS += proc-self-map-files-001
diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
new file mode 100644
index 000000000000..523afd83d34f
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -0,0 +1,459 @@
+/*
+ * Copyright (c) 2025 Suren Baghdasaryan <surenb@google.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/*
+ * Fork a child that concurrently modifies address space while the main
+ * process is reading /proc/$PID/maps and verifying the results. Address
+ * space modifications include:
+ *     VMA splitting and merging
+ *
+ */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+static unsigned long test_duration_sec = 5UL;
+static int page_size;
+
+/* /proc/pid/maps parsing routines */
+struct page_content {
+	char *data;
+	ssize_t size;
+};
+
+#define LINE_MAX_SIZE		256
+
+struct line_content {
+	char text[LINE_MAX_SIZE];
+	unsigned long start_addr;
+	unsigned long end_addr;
+};
+
+static void read_two_pages(int maps_fd, struct page_content *page1,
+			   struct page_content *page2)
+{
+	ssize_t  bytes_read;
+
+	assert(lseek(maps_fd, 0, SEEK_SET) >= 0);
+	bytes_read = read(maps_fd, page1->data, page_size);
+	assert(bytes_read > 0 && bytes_read < page_size);
+	page1->size = bytes_read;
+
+	bytes_read = read(maps_fd, page2->data, page_size);
+	assert(bytes_read > 0 && bytes_read < page_size);
+	page2->size = bytes_read;
+}
+
+static void copy_first_line(struct page_content *page, char *first_line)
+{
+	char *pos = strchr(page->data, '\n');
+
+	strncpy(first_line, page->data, pos - page->data);
+	first_line[pos - page->data] = '\0';
+}
+
+static void copy_last_line(struct page_content *page, char *last_line)
+{
+	/* Get the last line in the first page */
+	const char *end = page->data + page->size - 1;
+	/* skip last newline */
+	const char *pos = end - 1;
+
+	/* search previous newline */
+	while (pos[-1] != '\n')
+		pos--;
+	strncpy(last_line, pos, end - pos);
+	last_line[end - pos] = '\0';
+}
+
+/* Read the last line of the first page and the first line of the second page */
+static void read_boundary_lines(int maps_fd, struct page_content *page1,
+				struct page_content *page2,
+				struct line_content *last_line,
+				struct line_content *first_line)
+{
+	read_two_pages(maps_fd, page1, page2);
+
+	copy_last_line(page1, last_line->text);
+	copy_first_line(page2, first_line->text);
+
+	assert(sscanf(last_line->text, "%lx-%lx", &last_line->start_addr,
+		      &last_line->end_addr) == 2);
+	assert(sscanf(first_line->text, "%lx-%lx", &first_line->start_addr,
+		      &first_line->end_addr) == 2);
+}
+
+/* Thread synchronization routines */
+enum test_state {
+	INIT,
+	CHILD_READY,
+	PARENT_READY,
+	SETUP_READY,
+	SETUP_MODIFY_MAPS,
+	SETUP_MAPS_MODIFIED,
+	SETUP_RESTORE_MAPS,
+	SETUP_MAPS_RESTORED,
+	TEST_READY,
+	TEST_DONE,
+};
+
+struct vma_modifier_info;
+
+typedef void (*vma_modifier_op)(const struct vma_modifier_info *mod_info);
+typedef void (*vma_mod_result_check_op)(struct line_content *mod_last_line,
+					struct line_content *mod_first_line,
+					struct line_content *restored_last_line,
+					struct line_content *restored_first_line);
+
+struct vma_modifier_info {
+	int vma_count;
+	void *addr;
+	int prot;
+	void *next_addr;
+	vma_modifier_op vma_modify;
+	vma_modifier_op vma_restore;
+	vma_mod_result_check_op vma_mod_check;
+	pthread_mutex_t sync_lock;
+	pthread_cond_t sync_cond;
+	enum test_state curr_state;
+	bool exit;
+	void *child_mapped_addr[];
+};
+
+static void wait_for_state(struct vma_modifier_info *mod_info, enum test_state state)
+{
+	pthread_mutex_lock(&mod_info->sync_lock);
+	while (mod_info->curr_state != state)
+		pthread_cond_wait(&mod_info->sync_cond, &mod_info->sync_lock);
+	pthread_mutex_unlock(&mod_info->sync_lock);
+}
+
+static void signal_state(struct vma_modifier_info *mod_info, enum test_state state)
+{
+	pthread_mutex_lock(&mod_info->sync_lock);
+	mod_info->curr_state = state;
+	pthread_cond_signal(&mod_info->sync_cond);
+	pthread_mutex_unlock(&mod_info->sync_lock);
+}
+
+/* VMA modification routines */
+static void *child_vma_modifier(struct vma_modifier_info *mod_info)
+{
+	int prot = PROT_READ | PROT_WRITE;
+	int i;
+
+	for (i = 0; i < mod_info->vma_count; i++) {
+		mod_info->child_mapped_addr[i] = mmap(NULL, page_size * 3, prot,
+				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		assert(mod_info->child_mapped_addr[i] != MAP_FAILED);
+		/* change protection in adjacent maps to prevent merging */
+		prot ^= PROT_WRITE;
+	}
+	signal_state(mod_info, CHILD_READY);
+	wait_for_state(mod_info, PARENT_READY);
+	while (true) {
+		signal_state(mod_info, SETUP_READY);
+		wait_for_state(mod_info, SETUP_MODIFY_MAPS);
+		if (mod_info->exit)
+			break;
+
+		mod_info->vma_modify(mod_info);
+		signal_state(mod_info, SETUP_MAPS_MODIFIED);
+		wait_for_state(mod_info, SETUP_RESTORE_MAPS);
+		mod_info->vma_restore(mod_info);
+		signal_state(mod_info, SETUP_MAPS_RESTORED);
+
+		wait_for_state(mod_info, TEST_READY);
+		while (mod_info->curr_state != TEST_DONE) {
+			mod_info->vma_modify(mod_info);
+			mod_info->vma_restore(mod_info);
+		}
+	}
+	for (i = 0; i < mod_info->vma_count; i++)
+		munmap(mod_info->child_mapped_addr[i], page_size * 3);
+
+	return NULL;
+}
+
+static void stop_vma_modifier(struct vma_modifier_info *mod_info)
+{
+	wait_for_state(mod_info, SETUP_READY);
+	mod_info->exit = true;
+	signal_state(mod_info, SETUP_MODIFY_MAPS);
+}
+
+static void capture_mod_pattern(int maps_fd,
+				struct vma_modifier_info *mod_info,
+				struct page_content *page1,
+				struct page_content *page2,
+				struct line_content *last_line,
+				struct line_content *first_line,
+				struct line_content *mod_last_line,
+				struct line_content *mod_first_line,
+				struct line_content *restored_last_line,
+				struct line_content *restored_first_line)
+{
+	signal_state(mod_info, SETUP_MODIFY_MAPS);
+	wait_for_state(mod_info, SETUP_MAPS_MODIFIED);
+
+	/* Copy last line of the first page and first line of the last page */
+	read_boundary_lines(maps_fd, page1, page2, mod_last_line, mod_first_line);
+
+	signal_state(mod_info, SETUP_RESTORE_MAPS);
+	wait_for_state(mod_info, SETUP_MAPS_RESTORED);
+
+	/* Copy last line of the first page and first line of the last page */
+	read_boundary_lines(maps_fd, page1, page2, restored_last_line, restored_first_line);
+
+	mod_info->vma_mod_check(mod_last_line, mod_first_line,
+				restored_last_line, restored_first_line);
+
+	/*
+	 * The content of these lines after modify+resore should be the same
+	 * as the original.
+	 */
+	assert(strcmp(restored_last_line->text, last_line->text) == 0);
+	assert(strcmp(restored_first_line->text, first_line->text) == 0);
+}
+
+static inline void split_vma(const struct vma_modifier_info *mod_info)
+{
+	assert(mmap(mod_info->addr, page_size, mod_info->prot | PROT_EXEC,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
+		    -1, 0) != MAP_FAILED);
+}
+
+static inline void merge_vma(const struct vma_modifier_info *mod_info)
+{
+	assert(mmap(mod_info->addr, page_size, mod_info->prot,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
+		    -1, 0) != MAP_FAILED);
+}
+
+static inline void check_split_result(struct line_content *mod_last_line,
+				      struct line_content *mod_first_line,
+				      struct line_content *restored_last_line,
+				      struct line_content *restored_first_line)
+{
+	/* Make sure vmas at the boundaries are changing */
+	assert(strcmp(mod_last_line->text, restored_last_line->text) != 0);
+	assert(strcmp(mod_first_line->text, restored_first_line->text) != 0);
+}
+
+static void test_maps_tearing_from_split(int maps_fd,
+					 struct vma_modifier_info *mod_info,
+					 struct page_content *page1,
+					 struct page_content *page2,
+					 struct line_content *last_line,
+					 struct line_content *first_line)
+{
+	struct line_content split_last_line;
+	struct line_content split_first_line;
+	struct line_content restored_last_line;
+	struct line_content restored_first_line;
+
+	wait_for_state(mod_info, SETUP_READY);
+
+	/* re-read the file to avoid using stale data from previous test */
+	read_boundary_lines(maps_fd, page1, page2, last_line, first_line);
+
+	mod_info->vma_modify = split_vma;
+	mod_info->vma_restore = merge_vma;
+	mod_info->vma_mod_check = check_split_result;
+
+	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
+			    &split_last_line, &split_first_line,
+			    &restored_last_line, &restored_first_line);
+
+	/* Now start concurrent modifications for test_duration_sec */
+	signal_state(mod_info, TEST_READY);
+
+	struct line_content new_last_line;
+	struct line_content new_first_line;
+	struct timespec start_ts, end_ts;
+
+	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	do {
+		bool last_line_changed;
+		bool first_line_changed;
+
+		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
+
+		/* Check if we read vmas after split */
+		if (!strcmp(new_last_line.text, split_last_line.text)) {
+			/*
+			 * The vmas should be consistent with split results,
+			 * however if vma was concurrently restored after a
+			 * split, it can be reported twice (first the original
+			 * split one, then the same vma but extended after the
+			 * merge) because we found it as the next vma again.
+			 * In that case new first line will be the same as the
+			 * last restored line.
+			 */
+			assert(!strcmp(new_first_line.text, split_first_line.text) ||
+			       !strcmp(new_first_line.text, restored_last_line.text));
+		} else {
+			/* The vmas should be consistent with merge results */
+			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
+			       !strcmp(new_first_line.text, restored_first_line.text));
+		}
+		/*
+		 * First and last lines should change in unison. If the last
+		 * line changed then the first line should change as well and
+		 * vice versa.
+		 */
+		last_line_changed = strcmp(new_last_line.text, last_line->text) != 0;
+		first_line_changed = strcmp(new_first_line.text, first_line->text) != 0;
+		assert(last_line_changed == first_line_changed);
+
+		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
+
+	/* Signal the modifyer thread to stop and wait until it exits */
+	signal_state(mod_info, TEST_DONE);
+}
+
+int usage(void)
+{
+	fprintf(stderr, "Userland /proc/pid/{s}maps race test cases\n");
+	fprintf(stderr, "  -d: Duration for time-consuming tests\n");
+	fprintf(stderr, "  -h: Help screen\n");
+	exit(-1);
+}
+
+int main(int argc, char **argv)
+{
+	struct vma_modifier_info *mod_info;
+	pthread_mutexattr_t mutex_attr;
+	pthread_condattr_t cond_attr;
+	int shared_mem_size;
+	char fname[32];
+	int vma_count;
+	int maps_fd;
+	int status;
+	pid_t pid;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "d:h")) != -1) {
+		if (opt == 'd')
+			test_duration_sec = strtoul(optarg, NULL, 0);
+		else if (opt == 'h')
+			usage();
+	}
+
+	page_size = sysconf(_SC_PAGESIZE);
+	/*
+	 * Have to map enough vmas for /proc/pid/maps to contain more than one
+	 * page worth of vmas. Assume at least 32 bytes per line in maps output
+	 */
+	vma_count = page_size / 32 + 1;
+	shared_mem_size = sizeof(struct vma_modifier_info) + vma_count * sizeof(void *);
+
+	/* map shared memory for communication with the child process */
+	mod_info = (struct vma_modifier_info *)mmap(NULL, shared_mem_size,
+		    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	assert(mod_info != MAP_FAILED);
+
+	/* Initialize shared members */
+	pthread_mutexattr_init(&mutex_attr);
+	pthread_mutexattr_setpshared(&mutex_attr, PTHREAD_PROCESS_SHARED);
+	assert(!pthread_mutex_init(&mod_info->sync_lock, &mutex_attr));
+	pthread_condattr_init(&cond_attr);
+	pthread_condattr_setpshared(&cond_attr, PTHREAD_PROCESS_SHARED);
+	assert(!pthread_cond_init(&mod_info->sync_cond, &cond_attr));
+	mod_info->vma_count = vma_count;
+	mod_info->curr_state = INIT;
+	mod_info->exit = false;
+
+	pid = fork();
+	if (!pid) {
+		/* Child process */
+		child_vma_modifier(mod_info);
+		return 0;
+	}
+
+	sprintf(fname, "/proc/%d/maps", pid);
+	maps_fd = open(fname, O_RDONLY);
+	assert(maps_fd != -1);
+
+	/* Wait for the child to map the VMAs */
+	wait_for_state(mod_info, CHILD_READY);
+
+	/* Read first two pages */
+	struct page_content page1;
+	struct page_content page2;
+
+	page1.data = malloc(page_size);
+	assert(page1.data);
+	page2.data = malloc(page_size);
+	assert(page2.data);
+
+	struct line_content last_line;
+	struct line_content first_line;
+
+	read_boundary_lines(maps_fd, &page1, &page2, &last_line, &first_line);
+
+	/*
+	 * Find the addresses corresponding to the last line in the first page
+	 * and the first line in the last page.
+	 */
+	mod_info->addr = NULL;
+	mod_info->next_addr = NULL;
+	for (int i = 0; i < mod_info->vma_count; i++) {
+		if (mod_info->child_mapped_addr[i] == (void *)last_line.start_addr) {
+			mod_info->addr = mod_info->child_mapped_addr[i];
+			mod_info->prot = PROT_READ;
+			/* Even VMAs have write permission */
+			if ((i % 2) == 0)
+				mod_info->prot |= PROT_WRITE;
+		} else if (mod_info->child_mapped_addr[i] == (void *)first_line.start_addr) {
+			mod_info->next_addr = mod_info->child_mapped_addr[i];
+		}
+
+		if (mod_info->addr && mod_info->next_addr)
+			break;
+	}
+	assert(mod_info->addr && mod_info->next_addr);
+
+	signal_state(mod_info, PARENT_READY);
+
+	test_maps_tearing_from_split(maps_fd, mod_info, &page1, &page2,
+				     &last_line, &first_line);
+
+	stop_vma_modifier(mod_info);
+
+	free(page2.data);
+	free(page1.data);
+
+	for (int i = 0; i < vma_count; i++)
+		munmap(mod_info->child_mapped_addr[i], page_size);
+	close(maps_fd);
+	waitpid(pid, &status, 0);
+	munmap(mod_info, shared_mem_size);
+
+	return 0;
+}
-- 
2.50.0.727.gbf7dc18ff4-goog


