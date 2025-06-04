Return-Path: <linux-fsdevel+bounces-50685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C425CACE702
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 01:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1117A6146
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 23:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8590826C389;
	Wed,  4 Jun 2025 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jweS1w5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3626B974
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749078725; cv=none; b=FORiHxq6b9c+hiLzMMdfYZaOubF/Of+PwC1lIUlNFy7rg2Ce1k+Z8phlBsv38xk1iUzc/XDdEwYO4yK1LELx2MFU9R3BPgcgmnRKFciepBBdI0eVYOPpq4o24XP0y8gxhQJ6sgGZX+jfjJTscGzYe+mGS1BDPyXoc6Wtds7PZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749078725; c=relaxed/simple;
	bh=NW3QXGZa4663WvdXLjeRyaj3Ei25o2AJZLFsBsC7Bnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jk1fcrgcn/6n8TJKvEEHthMyt2uIjWfzSF92gYtGOXmI1Gk38i65wBxvXFKxBmIp55Gy/JapIckDa0idHEhontT9H/GIuHlLCOpJX0VbeJyRGqv6TDrIus6y2hGk+RgNzA3N4fbWnjNpfwSw238B3HZcF8UCV9hk2ZXqdCOPN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jweS1w5I; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so285702a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 16:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749078721; x=1749683521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUhX3Ns/5XBc40xno+kJmwKf1OM3H2+/3zcbV1pSCHo=;
        b=jweS1w5ISouT9RfSpUwve2bo1GEg+UAH2S2b8fxHYNTKKQJPwtC3EH5DlmnKIYBUzp
         UBjn5aZIpYn0l7aOdz1vWNTwKRQGIBPeGul++R9wh8OCLwGHHGSBOIXseaJlYJF/mBTF
         jiHTpFVGzcX+Ah040EntNUJzAD248xgRUanJ3StWVIMr6+bQm6aYOQS2D++5HHwhK4AX
         pNVghNQLBjgNmx34MsM1sYjco0RRjl31BRjyU7iNhRxjXeLatUTEGPPIre/bkrWAEtRA
         xOUI+QSv/Mx5SAeI/5PYPb8msurL9GLeQjfWxLHL3rY6YHUf908JvwsV3fr4XJ0tagUa
         O0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749078721; x=1749683521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUhX3Ns/5XBc40xno+kJmwKf1OM3H2+/3zcbV1pSCHo=;
        b=j+wOCTOUueCvKBZRViF5P4/MSltTgnE69c4fIMScbiPIcFW3pTtKyOBYY2MEgPvZXA
         rSWTPYk+lQj5OdiohTeRzqykGhl7nC8mvK0speCIn/8q0tYH4EZ/d776kHFL/GxaxZyi
         DnpTWuAsCBdBSwMzkyHKHtd/47eTcNe58Ws/Ky0Y++UcZweY1btmvjcbazYq2C1GjR3E
         Yi/MOKxPTUl0JXvytOZoBRN4YhDfcyAf7ibrqK+lwtLhAQDs7CtWm2URCgvyZ+15UAAr
         b7Zg8DcPXBDKKmkuRETmwkKHbXJPMV3SC7ZCCdh5UKgmrrYoQuJWbym3i+2KFZdo0ctv
         WmXg==
X-Forwarded-Encrypted: i=1; AJvYcCVHFJXLuFUxyqW71dFX0SVyyQMNVe4pLtIRSbKprfdHzLNV8aja6D74AyTFbS9jXAgHNja6W9i7Me/xtD3X@vger.kernel.org
X-Gm-Message-State: AOJu0YycGA3vjZ74mRWSqtdrU5G8zCKLrSurB5zH/O6t6Aj7b6fUBoVV
	wcyEo+TQtT4E5NopR6+gNmDZTiSLMny7JwXm6MiJnYeLdazZR74vAXz1BZZZiIduC4cisSrP38s
	nScPaqw==
X-Google-Smtp-Source: AGHT+IHlAlWPhYi49GEO/hAEiP1bg5W9jmU+hP5/sDmo0K6qFC3JqxdpNjH/sVAhRn21WKI+htX2k/ydZrc=
X-Received: from pjbpw2.prod.google.com ([2002:a17:90b:2782:b0:312:187d:382d])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2cf:b0:312:26d9:d5b4
 with SMTP id 98e67ed59e1d1-3130cd97ac5mr7753526a91.17.1749078721150; Wed, 04
 Jun 2025 16:12:01 -0700 (PDT)
Date: Wed,  4 Jun 2025 16:11:45 -0700
In-Reply-To: <20250604231151.799834-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604231151.799834-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.1266.g31b7d2e469-goog
Message-ID: <20250604231151.799834-2-surenb@google.com>
Subject: [PATCH v4 1/7] selftests/proc: add /proc/pid/maps tearing from vma
 split test
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, surenb@google.com
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

Example Command: proc-pid-vm -d 10

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 430 ++++++++++++++++++++-
 1 file changed, 429 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index d04685771952..6e3f06376a1f 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -27,6 +27,7 @@
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdbool.h>
@@ -34,6 +35,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -70,6 +72,8 @@ static void make_private_tmp(void)
 	}
 }
 
+static unsigned long test_duration_sec = 5UL;
+static int page_size;
 static pid_t pid = -1;
 static void ate(void)
 {
@@ -281,11 +285,431 @@ static void vsyscall(void)
 	}
 }
 
-int main(void)
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
+static int test_maps_tearing(void)
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
+
+	/*
+	 * Have to map enough vmas for /proc/pid/maps to containt more than one
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
+
+int usage(void)
+{
+	fprintf(stderr, "Userland /proc/pid/{s}maps test cases\n");
+	fprintf(stderr, "  -d: Duration for time-consuming tests\n");
+	fprintf(stderr, "  -h: Help screen\n");
+	exit(-1);
+}
+
+int main(int argc, char **argv)
 {
 	int pipefd[2];
 	int exec_fd;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "d:h")) != -1) {
+		if (opt == 'd')
+			test_duration_sec = strtoul(optarg, NULL, 0);
+		else if (opt == 'h')
+			usage();
+	}
 
+	page_size = sysconf(_SC_PAGESIZE);
 	vsyscall();
 	switch (g_vsyscall) {
 	case 0:
@@ -578,6 +1002,10 @@ int main(void)
 		assert(err == -ENOENT);
 	}
 
+	/* Test tearing in /proc/$PID/maps */
+	if (test_maps_tearing())
+		return 1;
+
 	return 0;
 }
 #else
-- 
2.49.0.1266.g31b7d2e469-goog


