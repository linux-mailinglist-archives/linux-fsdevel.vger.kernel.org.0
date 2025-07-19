Return-Path: <linux-fsdevel+bounces-55512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25452B0B159
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 20:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC3A56394A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 18:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701E289835;
	Sat, 19 Jul 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+Q9Jddb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489C289368
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949742; cv=none; b=SpiiaSHm+ptkxNkT0kP7J9/1ycmo/Cjx3hmbY2CfYyg3ucTpDqbM2GDVg1ekloVBuE+C/jITXtjWPP3hlvLlnkTCckZNrnI3SY9Zu1Y9BOWB/ocr4KQgmpW9QO065eNHh7YfwBMwNaNyYp07hQnF+EGZEAKPvpXVVUErn710rA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949742; c=relaxed/simple;
	bh=hzHgQqgsigKswQz7j9NJVsuZrK+uK91DpG7o5k2BisM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zuy+Rsux0g936lLjHPGJBAu7GkEp8cve+yffLTsWPt85DzqhLqY1jX7XFT4EBAo066h11x6mUf4xgAAu8o21YEtKmzaOOrfEFJtQkhQRD5Tkrvtln4CWh0fWp3qFQTPzk8AXCcuXDpp5aOnxo01lUhs6iRK6mWNqIFFSbNFA15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+Q9Jddb; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2d9e7fbfedaso3899813fac.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752949739; x=1753554539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPvgBiLqlpShSpauZlW2pytMfVpDu05qY5wabgs+g1Y=;
        b=y+Q9JddbTgCFbudYcAmm5wtVyR9tlUrlHNUvCRPZpPLkiSbEvbsuS6hNamLerNMlrA
         G15XANOlh3x7XjVJy08P8jH1xhGL09quXiR7Ton+AkyLswfo4OtbCx+JQFKDY1Z2IWOb
         Q3dpfXonHrv/ujX31LTuPhUuifLce89lQyeyvXu4Da/Vs/8RplZk87yEknKqipp32bP2
         oY7NT+fEUMPWj7DJgMwyXO0XvkIO+F33n/V8omcydWRlGh+gBsugRzitrEfN2hn6lPxr
         jGhbs865gaqazXq73LX1seVnJaLhz0Txm5nrNWpbHfySxCiIninoOYH2g8YFHjF8pcUc
         QQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752949739; x=1753554539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPvgBiLqlpShSpauZlW2pytMfVpDu05qY5wabgs+g1Y=;
        b=uCML5h3uLtjYBpsvIXa9jFWdnavyw+F0efcW8hX5cIDQKw5mNB2CcINoohz/6h7m9p
         R/kznDeChLOSM3J3j9T7AU+r27ZLU/psyOuX/KcNnRYf2ShPLXPEGoQv17NmLjkMOVXL
         FiZgPDkV4X5uMGYL+gGKtGFk8p/KZCfRyy3/1/3JVOdmr096SOpmxQqgT15NbKBOlK0n
         iIXlZkQ8NcpurKRkcIfDRZUtTGXhehZ9asviWLkXc/6zrShlZazg1JGPHqPBtwgMTUhU
         dMA8FkBexZhPnrZf5M7XNr4h0bHpUr6myWCD1Yndk1wyV0nReVBFWFmGwjaFYpg4Kkxr
         xNfA==
X-Forwarded-Encrypted: i=1; AJvYcCXxLCW1ne+srvFsc5BDN7YskBYAPyxXIXX7Q2JmOVzRWYcjGa7A8XTBO4pXKsWZh2l9PADKAbum/JwqUu4M@vger.kernel.org
X-Gm-Message-State: AOJu0YxEj/QAuDh6KxiAMmqkFqK3uQlb97EE4oa76N9jn5NxRXm7ZZD0
	8i8ZYwluv7S6HR6oZo/RxLPG4vlTWScVQdXq415G5hlMgwNH0B1/AE7ac8bed8AQhWqkOAV8NMR
	SoHnIEw==
X-Google-Smtp-Source: AGHT+IFoGFLafBonuC3rQovXKKJU34G15nWux3XEkMYYSvePU4fdrLMa6Mpo311hHQrdwhevOxqLkpiabCo=
X-Received: from oabde14.prod.google.com ([2002:a05:6870:75ce:b0:2d5:491:29fa])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:8a1e:b0:2ea:7101:7dc1
 with SMTP id 586e51a60fabf-2ffb24a3bf3mr11597629fac.33.1752949739515; Sat, 19
 Jul 2025 11:28:59 -0700 (PDT)
Date: Sat, 19 Jul 2025 11:28:49 -0700
In-Reply-To: <20250719182854.3166724-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719182854.3166724-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719182854.3166724-2-surenb@google.com>
Subject: [PATCH v8 1/6] selftests/proc: add /proc/pid/maps tearing from vma
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

The test duration is configurable via DURATION environment variable
expressed in seconds. The default test duration is 5 seconds.

Example Command: DURATION=10 ./proc-maps-race

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/.gitignore       |   1 +
 tools/testing/selftests/proc/Makefile         |   1 +
 tools/testing/selftests/proc/proc-maps-race.c | 447 ++++++++++++++++++
 3 files changed, 449 insertions(+)
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
index 000000000000..5b28dda08b7d
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2022 Google LLC.
+ * Author: Suren Baghdasaryan <surenb@google.com>
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
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
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
+FIXTURE(proc_maps_race)
+{
+	struct vma_modifier_info *mod_info;
+	struct page_content page1;
+	struct page_content page2;
+	struct line_content last_line;
+	struct line_content first_line;
+	unsigned long duration_sec;
+	int shared_mem_size;
+	int page_size;
+	int vma_count;
+	int maps_fd;
+	pid_t pid;
+};
+
+typedef bool (*vma_modifier_op)(FIXTURE_DATA(proc_maps_race) *self);
+typedef bool (*vma_mod_result_check_op)(struct line_content *mod_last_line,
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
+
+static bool read_two_pages(FIXTURE_DATA(proc_maps_race) *self)
+{
+	ssize_t  bytes_read;
+
+	if (lseek(self->maps_fd, 0, SEEK_SET) < 0)
+		return false;
+
+	bytes_read = read(self->maps_fd, self->page1.data, self->page_size);
+	if (bytes_read <= 0)
+		return false;
+
+	self->page1.size = bytes_read;
+
+	bytes_read = read(self->maps_fd, self->page2.data, self->page_size);
+	if (bytes_read <= 0)
+		return false;
+
+	self->page2.size = bytes_read;
+
+	return true;
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
+static bool read_boundary_lines(FIXTURE_DATA(proc_maps_race) *self,
+				struct line_content *last_line,
+				struct line_content *first_line)
+{
+	if (!read_two_pages(self))
+		return false;
+
+	copy_last_line(&self->page1, last_line->text);
+	copy_first_line(&self->page2, first_line->text);
+
+	return sscanf(last_line->text, "%lx-%lx", &last_line->start_addr,
+		      &last_line->end_addr) == 2 &&
+	       sscanf(first_line->text, "%lx-%lx", &first_line->start_addr,
+		      &first_line->end_addr) == 2;
+}
+
+/* Thread synchronization routines */
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
+static void stop_vma_modifier(struct vma_modifier_info *mod_info)
+{
+	wait_for_state(mod_info, SETUP_READY);
+	mod_info->exit = true;
+	signal_state(mod_info, SETUP_MODIFY_MAPS);
+}
+
+static bool capture_mod_pattern(FIXTURE_DATA(proc_maps_race) *self,
+				struct line_content *mod_last_line,
+				struct line_content *mod_first_line,
+				struct line_content *restored_last_line,
+				struct line_content *restored_first_line)
+{
+	signal_state(self->mod_info, SETUP_MODIFY_MAPS);
+	wait_for_state(self->mod_info, SETUP_MAPS_MODIFIED);
+
+	/* Copy last line of the first page and first line of the last page */
+	if (!read_boundary_lines(self, mod_last_line, mod_first_line))
+		return false;
+
+	signal_state(self->mod_info, SETUP_RESTORE_MAPS);
+	wait_for_state(self->mod_info, SETUP_MAPS_RESTORED);
+
+	/* Copy last line of the first page and first line of the last page */
+	if (!read_boundary_lines(self, restored_last_line, restored_first_line))
+		return false;
+
+	if (!self->mod_info->vma_mod_check(mod_last_line, mod_first_line,
+					   restored_last_line, restored_first_line))
+		return false;
+
+	/*
+	 * The content of these lines after modify+resore should be the same
+	 * as the original.
+	 */
+	return strcmp(restored_last_line->text, self->last_line.text) == 0 &&
+	       strcmp(restored_first_line->text, self->first_line.text) == 0;
+}
+
+static inline bool split_vma(FIXTURE_DATA(proc_maps_race) *self)
+{
+	return mmap(self->mod_info->addr, self->page_size, self->mod_info->prot | PROT_EXEC,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) != MAP_FAILED;
+}
+
+static inline bool merge_vma(FIXTURE_DATA(proc_maps_race) *self)
+{
+	return mmap(self->mod_info->addr, self->page_size, self->mod_info->prot,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) != MAP_FAILED;
+}
+
+static inline bool check_split_result(struct line_content *mod_last_line,
+				      struct line_content *mod_first_line,
+				      struct line_content *restored_last_line,
+				      struct line_content *restored_first_line)
+{
+	/* Make sure vmas at the boundaries are changing */
+	return strcmp(mod_last_line->text, restored_last_line->text) != 0 &&
+	       strcmp(mod_first_line->text, restored_first_line->text) != 0;
+}
+
+FIXTURE_SETUP(proc_maps_race)
+{
+	const char *duration = getenv("DURATION");
+	struct vma_modifier_info *mod_info;
+	pthread_mutexattr_t mutex_attr;
+	pthread_condattr_t cond_attr;
+	unsigned long duration_sec;
+	char fname[32];
+
+	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+	duration_sec = duration ? atol(duration) : 0;
+	self->duration_sec = duration_sec ? duration_sec : 5UL;
+
+	/*
+	 * Have to map enough vmas for /proc/pid/maps to contain more than one
+	 * page worth of vmas. Assume at least 32 bytes per line in maps output
+	 */
+	self->vma_count = self->page_size / 32 + 1;
+	self->shared_mem_size = sizeof(struct vma_modifier_info) + self->vma_count * sizeof(void *);
+
+	/* map shared memory for communication with the child process */
+	self->mod_info = (struct vma_modifier_info *)mmap(NULL, self->shared_mem_size,
+				PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(self->mod_info, MAP_FAILED);
+	mod_info = self->mod_info;
+
+	/* Initialize shared members */
+	pthread_mutexattr_init(&mutex_attr);
+	pthread_mutexattr_setpshared(&mutex_attr, PTHREAD_PROCESS_SHARED);
+	ASSERT_EQ(pthread_mutex_init(&mod_info->sync_lock, &mutex_attr), 0);
+	pthread_condattr_init(&cond_attr);
+	pthread_condattr_setpshared(&cond_attr, PTHREAD_PROCESS_SHARED);
+	ASSERT_EQ(pthread_cond_init(&mod_info->sync_cond, &cond_attr), 0);
+	mod_info->vma_count = self->vma_count;
+	mod_info->curr_state = INIT;
+	mod_info->exit = false;
+
+	self->pid = fork();
+	if (!self->pid) {
+		/* Child process modifying the address space */
+		int prot = PROT_READ | PROT_WRITE;
+		int i;
+
+		for (i = 0; i < mod_info->vma_count; i++) {
+			mod_info->child_mapped_addr[i] = mmap(NULL, self->page_size * 3, prot,
+					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+			ASSERT_NE(mod_info->child_mapped_addr[i], MAP_FAILED);
+			/* change protection in adjacent maps to prevent merging */
+			prot ^= PROT_WRITE;
+		}
+		signal_state(mod_info, CHILD_READY);
+		wait_for_state(mod_info, PARENT_READY);
+		while (true) {
+			signal_state(mod_info, SETUP_READY);
+			wait_for_state(mod_info, SETUP_MODIFY_MAPS);
+			if (mod_info->exit)
+				break;
+
+			ASSERT_TRUE(mod_info->vma_modify(self));
+			signal_state(mod_info, SETUP_MAPS_MODIFIED);
+			wait_for_state(mod_info, SETUP_RESTORE_MAPS);
+			ASSERT_TRUE(mod_info->vma_restore(self));
+			signal_state(mod_info, SETUP_MAPS_RESTORED);
+
+			wait_for_state(mod_info, TEST_READY);
+			while (mod_info->curr_state != TEST_DONE) {
+				ASSERT_TRUE(mod_info->vma_modify(self));
+				ASSERT_TRUE(mod_info->vma_restore(self));
+			}
+		}
+		for (i = 0; i < mod_info->vma_count; i++)
+			munmap(mod_info->child_mapped_addr[i], self->page_size * 3);
+
+		exit(0);
+	}
+
+	sprintf(fname, "/proc/%d/maps", self->pid);
+	self->maps_fd = open(fname, O_RDONLY);
+	ASSERT_NE(self->maps_fd, -1);
+
+	/* Wait for the child to map the VMAs */
+	wait_for_state(mod_info, CHILD_READY);
+
+	/* Read first two pages */
+	self->page1.data = malloc(self->page_size);
+	ASSERT_NE(self->page1.data, NULL);
+	self->page2.data = malloc(self->page_size);
+	ASSERT_NE(self->page2.data, NULL);
+
+	ASSERT_TRUE(read_boundary_lines(self, &self->last_line, &self->first_line));
+
+	/*
+	 * Find the addresses corresponding to the last line in the first page
+	 * and the first line in the last page.
+	 */
+	mod_info->addr = NULL;
+	mod_info->next_addr = NULL;
+	for (int i = 0; i < mod_info->vma_count; i++) {
+		if (mod_info->child_mapped_addr[i] == (void *)self->last_line.start_addr) {
+			mod_info->addr = mod_info->child_mapped_addr[i];
+			mod_info->prot = PROT_READ;
+			/* Even VMAs have write permission */
+			if ((i % 2) == 0)
+				mod_info->prot |= PROT_WRITE;
+		} else if (mod_info->child_mapped_addr[i] == (void *)self->first_line.start_addr) {
+			mod_info->next_addr = mod_info->child_mapped_addr[i];
+		}
+
+		if (mod_info->addr && mod_info->next_addr)
+			break;
+	}
+	ASSERT_TRUE(mod_info->addr && mod_info->next_addr);
+
+	signal_state(mod_info, PARENT_READY);
+
+}
+
+FIXTURE_TEARDOWN(proc_maps_race)
+{
+	int status;
+
+	stop_vma_modifier(self->mod_info);
+
+	free(self->page2.data);
+	free(self->page1.data);
+
+	for (int i = 0; i < self->vma_count; i++)
+		munmap(self->mod_info->child_mapped_addr[i], self->page_size);
+	close(self->maps_fd);
+	waitpid(self->pid, &status, 0);
+	munmap(self->mod_info, self->shared_mem_size);
+}
+
+TEST_F(proc_maps_race, test_maps_tearing_from_split)
+{
+	struct vma_modifier_info *mod_info = self->mod_info;
+
+	struct line_content split_last_line;
+	struct line_content split_first_line;
+	struct line_content restored_last_line;
+	struct line_content restored_first_line;
+
+	wait_for_state(mod_info, SETUP_READY);
+
+	/* re-read the file to avoid using stale data from previous test */
+	ASSERT_TRUE(read_boundary_lines(self, &self->last_line, &self->first_line));
+
+	mod_info->vma_modify = split_vma;
+	mod_info->vma_restore = merge_vma;
+	mod_info->vma_mod_check = check_split_result;
+
+	ASSERT_TRUE(capture_mod_pattern(self, &split_last_line, &split_first_line,
+					&restored_last_line, &restored_first_line));
+
+	/* Now start concurrent modifications for self->duration_sec */
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
+		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
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
+			ASSERT_FALSE(strcmp(new_first_line.text, split_first_line.text) &&
+				     strcmp(new_first_line.text, restored_last_line.text));
+		} else {
+			/* The vmas should be consistent with merge results */
+			ASSERT_FALSE(strcmp(new_last_line.text, restored_last_line.text));
+			ASSERT_FALSE(strcmp(new_first_line.text, restored_first_line.text));
+		}
+		/*
+		 * First and last lines should change in unison. If the last
+		 * line changed then the first line should change as well and
+		 * vice versa.
+		 */
+		last_line_changed = strcmp(new_last_line.text, self->last_line.text) != 0;
+		first_line_changed = strcmp(new_first_line.text, self->first_line.text) != 0;
+		ASSERT_EQ(last_line_changed, first_line_changed);
+
+		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
+
+	/* Signal the modifyer thread to stop and wait until it exits */
+	signal_state(mod_info, TEST_DONE);
+}
+
+TEST_HARNESS_MAIN
-- 
2.50.0.727.gbf7dc18ff4-goog


