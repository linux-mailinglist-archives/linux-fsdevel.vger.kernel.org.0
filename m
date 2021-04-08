Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5464F35907E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhDHXoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 19:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbhDHXn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:43:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81110C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 16:43:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y13so3532879ybk.20
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 16:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k822bRDmtTrziFIcDdTViBhFB3AGLYRYm2w1YLs2VOg=;
        b=f4YMCWG4vKdVJmmBUAtXNIwSMYRV3ij0I4fC+cvpCp9uf6F11PZFl41XLH9pf3d0QP
         3k9gr0FVzKIbK2aT2PEybMZT+cE6mxavym4u6jBDsjVyecO1VZKOn2E00+nL603MQts7
         9TvHWrf9UnJLUkbhxxdRjlQzQwbA4Ntwiq4bGUgRHKmrK04smKF58bQNCP+GinAuyRY8
         ijRkQjaCEIquZi8K5IpZcQjUH4VbmTbbP3xpzY1EkvAd99RTSSLYMYWaVUhahN5cLaye
         LFbuszRDnYEXg4AzIR74gSQojrU1VOwwdAqsE9bXFUkoUDMMLb9CME7sdtdE/1XnifpI
         WzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k822bRDmtTrziFIcDdTViBhFB3AGLYRYm2w1YLs2VOg=;
        b=f+qSKpJHZOXfduw3I9eVGzi2jn+4KDI6j4fNo1q2Zh0dL3gg4US5HBMbs1KAhPZfMo
         GIC/wNkLEsRQn42R719LUolc1grkqzwVKxeKm/7QwmPDiAM1RfY6iRF0YJmzxTT6SI9M
         pES1UKlWGKQLmxg1pNIdW1zJ2le6ZDpxXFCpdsF1o9m8zETUgKn1YQIX2M9Z1YtShZMB
         sdF8xnw4fCVIP3WmoIP6zcPHsQgEZNhmM4zJ65D/847kKd5s9nR4ELk5f9zBRP1Y6g5I
         2IQwnjILEHUd78JD6HiWZcjJKPC/xMXajwP2HRQBtkb5LdXwQwsrFvCxnMao5MzPrw62
         uDog==
X-Gm-Message-State: AOAM531Etrep8g2eWI1g0BGXCH14j09lrWvsGlJUEhnTgGCcW08Qu5eh
        /7pQtyVr9NaiiRdn1zE1ElOJ1wqStndEQP3ynK3r
X-Google-Smtp-Source: ABdhPJye+kHIsbkEGD8DVxtB2/PLogEU4neb7Zlc4c9yBH3sz33SCcoh3TaGKUxFZuLR6pRwrWvarcuMIkcjKH787diS
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d06:d00f:a626:675a])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:802:: with SMTP id
 x2mr10296897ybp.28.1617925423799; Thu, 08 Apr 2021 16:43:43 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:43:25 -0700
In-Reply-To: <20210408234327.624367-1-axelrasmussen@google.com>
Message-Id: <20210408234327.624367-8-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 7/9] userfaultfd/selftests: reinitialize test context in each test
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, the context (fds, mmap-ed areas, etc.) are global. Each test
mutates this state in some way, in some cases really "clobbering it"
(e.g., the events test mremap-ing area_dst over the top of area_src, or
the minor faults tests overwriting the count_verify values in the test
areas). We run the tests in a particular order, each test is careful to
make the right assumptions about its starting state, etc.

But, this is fragile. It's better for a test's success or failure to not
depend on what some other prior test case did to the global state.

To that end, clear and reinitialize the test context at the start of
each test case, so whatever prior test cases did doesn't affect future
tests.

This is particularly relevant to this series because the events test's
mremap of area_dst screws up assumptions the minor fault test was
relying on. This wasn't a problem for hugetlb, as we don't mremap in
that case.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 221 +++++++++++++----------
 1 file changed, 129 insertions(+), 92 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 4b49b2cf9819..9b032cfdc262 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -89,7 +89,8 @@ static int shm_fd;
 static int huge_fd;
 static char *huge_fd_off0;
 static unsigned long long *count_verify;
-static int uffd, uffd_flags, finished, *pipefd;
+static int uffd = -1;
+static int uffd_flags, finished, *pipefd;
 static char *area_src, *area_src_alias, *area_dst, *area_dst_alias;
 static char *zeropage;
 pthread_attr_t attr;
@@ -343,6 +344,124 @@ static struct uffd_test_ops hugetlb_uffd_test_ops = {
 
 static struct uffd_test_ops *uffd_test_ops;
 
+static int userfaultfd_open(uint64_t *features)
+{
+	struct uffdio_api uffdio_api;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0)
+		err("userfaultfd syscall not available in this kernel");
+	uffd_flags = fcntl(uffd, F_GETFD, NULL);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = *features;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
+		err("UFFDIO_API failed.\nPlease make sure to "
+		    "run with either root or ptrace capability.");
+	if (uffdio_api.api != UFFD_API)
+		err("UFFDIO_API error: %" PRIu64, (uint64_t)uffdio_api.api);
+
+	*features = uffdio_api.features;
+	return 0;
+}
+
+static int uffd_test_ctx_init_ext(uint64_t *features)
+{
+	unsigned long nr, cpu;
+
+	uffd_test_ops->allocate_area((void **)&area_src);
+	if (!area_src)
+		return 1;
+	uffd_test_ops->allocate_area((void **)&area_dst);
+	if (!area_dst)
+		return 1;
+
+	if (uffd_test_ops->release_pages(area_src))
+		return 1;
+
+	if (uffd_test_ops->release_pages(area_dst))
+		return 1;
+
+	if (userfaultfd_open(features))
+		return 1;
+
+	count_verify = malloc(nr_pages * sizeof(unsigned long long));
+	if (!count_verify)
+		err("count_verify");
+
+	for (nr = 0; nr < nr_pages; nr++) {
+		*area_mutex(area_src, nr) =
+			(pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
+		count_verify[nr] = *area_count(area_src, nr) = 1;
+		/*
+		 * In the transition between 255 to 256, powerpc will
+		 * read out of order in my_bcmp and see both bytes as
+		 * zero, so leave a placeholder below always non-zero
+		 * after the count, to avoid my_bcmp to trigger false
+		 * positives.
+		 */
+		*(area_count(area_src, nr) + 1) = 1;
+	}
+
+	pipefd = malloc(sizeof(int) * nr_cpus * 2);
+	if (!pipefd)
+		err("pipefd");
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
+			err("pipe");
+
+	return 0;
+}
+
+static inline int uffd_test_ctx_init(uint64_t features)
+{
+	return uffd_test_ctx_init_ext(&features);
+}
+
+static inline int munmap_area(void **area)
+{
+	if (*area)
+		if (munmap(*area, nr_pages * page_size))
+			err("munmap");
+
+	*area = NULL;
+	return 0;
+}
+
+static int uffd_test_ctx_clear(void)
+{
+	int ret = 0;
+	size_t i;
+
+	if (pipefd) {
+		for (i = 0; i < nr_cpus * 2; ++i) {
+			if (close(pipefd[i]))
+				err("close pipefd");
+		}
+		free(pipefd);
+		pipefd = NULL;
+	}
+
+	if (count_verify) {
+		free(count_verify);
+		count_verify = NULL;
+	}
+
+	if (uffd != -1) {
+		if (close(uffd))
+			err("close uffd");
+		uffd = -1;
+	}
+
+	huge_fd_off0 = NULL;
+	ret |= munmap_area((void **)&area_src);
+	ret |= munmap_area((void **)&area_src_alias);
+	ret |= munmap_area((void **)&area_dst);
+	ret |= munmap_area((void **)&area_dst_alias);
+
+	return ret;
+}
+
 static int my_bcmp(char *str1, char *str2, size_t n)
 {
 	unsigned long i;
@@ -727,40 +846,6 @@ static int stress(struct uffd_stats *uffd_stats)
 	return 0;
 }
 
-static int userfaultfd_open_ext(uint64_t *features)
-{
-	struct uffdio_api uffdio_api;
-
-	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
-	if (uffd < 0) {
-		fprintf(stderr,
-			"userfaultfd syscall not available in this kernel\n");
-		return 1;
-	}
-	uffd_flags = fcntl(uffd, F_GETFD, NULL);
-
-	uffdio_api.api = UFFD_API;
-	uffdio_api.features = *features;
-	if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
-		fprintf(stderr, "UFFDIO_API failed.\nPlease make sure to "
-			"run with either root or ptrace capability.\n");
-		return 1;
-	}
-	if (uffdio_api.api != UFFD_API) {
-		fprintf(stderr, "UFFDIO_API error: %" PRIu64 "\n",
-			(uint64_t)uffdio_api.api);
-		return 1;
-	}
-
-	*features = uffdio_api.features;
-	return 0;
-}
-
-static int userfaultfd_open(uint64_t features)
-{
-	return userfaultfd_open_ext(&features);
-}
-
 sigjmp_buf jbuf, *sigbuf;
 
 static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
@@ -869,6 +954,8 @@ static int faulting_process(int signal_test)
 			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
 	if (area_dst == MAP_FAILED)
 		err("mremap");
+	/* Reset area_src since we just clobbered it */
+	area_src = NULL;
 
 	for (; nr < nr_pages; nr++) {
 		count = *area_count(area_dst, nr);
@@ -962,11 +1049,9 @@ static int userfaultfd_zeropage_test(void)
 	printf("testing UFFDIO_ZEROPAGE: ");
 	fflush(stdout);
 
-	if (uffd_test_ops->release_pages(area_dst))
+	if (uffd_test_ctx_clear() || uffd_test_ctx_init(0))
 		return 1;
 
-	if (userfaultfd_open(0))
-		return 1;
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
@@ -983,7 +1068,6 @@ static int userfaultfd_zeropage_test(void)
 		if (my_bcmp(area_dst, zeropage, page_size))
 			err("zeropage is not zero");
 
-	close(uffd);
 	printf("done.\n");
 	return 0;
 }
@@ -1001,13 +1085,11 @@ static int userfaultfd_events_test(void)
 	printf("testing events (fork, remap, remove): ");
 	fflush(stdout);
 
-	if (uffd_test_ops->release_pages(area_dst))
-		return 1;
-
 	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
 		UFFD_FEATURE_EVENT_REMOVE;
-	if (userfaultfd_open(features))
+	if (uffd_test_ctx_clear() || uffd_test_ctx_init(features))
 		return 1;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
@@ -1040,8 +1122,6 @@ static int userfaultfd_events_test(void)
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
-	close(uffd);
-
 	uffd_stats_report(&stats, 1);
 
 	return stats.missing_faults != nr_pages;
@@ -1061,12 +1141,10 @@ static int userfaultfd_sig_test(void)
 	printf("testing signal delivery: ");
 	fflush(stdout);
 
-	if (uffd_test_ops->release_pages(area_dst))
-		return 1;
-
 	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
-	if (userfaultfd_open(features))
+	if (uffd_test_ctx_clear() || uffd_test_ctx_init(features))
 		return 1;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
@@ -1128,10 +1206,7 @@ static int userfaultfd_minor_test(void)
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	if (uffd_test_ops->release_pages(area_dst))
-		return 1;
-
-	if (userfaultfd_open_ext(&features))
+	if (uffd_test_ctx_clear() || uffd_test_ctx_init_ext(&features))
 		return 1;
 	/* If kernel reports the feature isn't supported, skip the test. */
 	if (!(features & UFFD_FEATURE_MINOR_HUGETLBFS)) {
@@ -1186,8 +1261,6 @@ static int userfaultfd_minor_test(void)
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
-	close(uffd);
-
 	uffd_stats_report(&stats, 1);
 
 	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
@@ -1199,44 +1272,11 @@ static int userfaultfd_stress(void)
 	char *tmp_area;
 	unsigned long nr;
 	struct uffdio_register uffdio_register;
-	unsigned long cpu;
 	struct uffd_stats uffd_stats[nr_cpus];
 
-	uffd_test_ops->allocate_area((void **)&area_src);
-	if (!area_src)
-		return 1;
-	uffd_test_ops->allocate_area((void **)&area_dst);
-	if (!area_dst)
-		return 1;
-
-	if (userfaultfd_open(0))
+	if (uffd_test_ctx_init(0))
 		return 1;
 
-	count_verify = malloc(nr_pages * sizeof(unsigned long long));
-	if (!count_verify)
-		err("count_verify");
-
-	for (nr = 0; nr < nr_pages; nr++) {
-		*area_mutex(area_src, nr) = (pthread_mutex_t)
-			PTHREAD_MUTEX_INITIALIZER;
-		count_verify[nr] = *area_count(area_src, nr) = 1;
-		/*
-		 * In the transition between 255 to 256, powerpc will
-		 * read out of order in my_bcmp and see both bytes as
-		 * zero, so leave a placeholder below always non-zero
-		 * after the count, to avoid my_bcmp to trigger false
-		 * positives.
-		 */
-		*(area_count(area_src, nr) + 1) = 1;
-	}
-
-	pipefd = malloc(sizeof(int) * nr_cpus * 2);
-	if (!pipefd)
-		err("pipefd");
-	for (cpu = 0; cpu < nr_cpus; cpu++)
-		if (pipe2(&pipefd[cpu*2], O_CLOEXEC | O_NONBLOCK))
-			err("pipe");
-
 	if (posix_memalign(&area, page_size, page_size))
 		err("out of memory");
 	zeropage = area;
@@ -1356,9 +1396,6 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
 
-	if (close(uffd))
-		err("close uffd");
-
 	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
 		|| userfaultfd_events_test() || userfaultfd_minor_test();
 }
-- 
2.31.1.295.g9ea45b61b8-goog

