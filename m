Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF3D3661F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 00:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhDTWJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 18:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhDTWIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:08:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D87C06138B
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 15:08:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c1-20020a5b0bc10000b02904e7c6399b20so13434916ybr.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 15:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JzTVGZ23fIrylr2XIKhqY641xTnyCDfA+KvZuGCEgRI=;
        b=MavEvrKuEQatbMQrhgSOEKJ0LdjmgV8fvehXxnG6YxPGD0mp63+clcxaQphLEu1rom
         3+XE5Z2HZzKlM9VFQYTiFElOTJxtShLSg/2WboVP79O5zz7d+n+HCNhcv5GaNgCnCqbi
         Q7wacwJxAQod8GT6nGiQ4QEF0YxVnZQtIifA2Jm7mxx0tB+X2HkHOt0s5YOAZpAE6m6l
         npY8hn4Gvnsy1s3rPjyRMUlk4ptHCuaEwoztuq8PPU4+IWVj+mPkoBSs47rCgzomfA+E
         FSEWV5BiWkSFSBSu0UJxkLUyiaYUNBgAIlG5ELE+3fMyBBEcwX4lJNsToL4qK9cnslMx
         b9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JzTVGZ23fIrylr2XIKhqY641xTnyCDfA+KvZuGCEgRI=;
        b=N2pS4N1BveS7ST49zvOVhB6FkUz2rxaSU5DE5iimiKHuL66pIQlD6jx3WSyKsZXzjN
         LDNms/7g5WXeLBhI6dbam5nNagsDfm4EfwLMfojHlhl4e3Dvz/dGygOPDaQSRcDCSfkj
         dXfJWtRo54h+eJ/In/N+zBrPBq+3ihvJs5p4FPOEGFWclEmeaofC+Q0uNNAdbGzwQCnS
         GjdK7n1kIYe5UxbPGcWdFi4pD0SV8wLTTUzR4aiicpmw/Aj97tfJmRhh56cVCOJecuEg
         i5eK+3qFG0A2JZX8YTjKaJDu2g2cVRbC2GfdOv5cy4ON0rf3ovMhGbpIixBAwHQ6d0VF
         jl6w==
X-Gm-Message-State: AOAM530oNL7+58ZcQvzXPNcxM9eNyG42pz7am190AyQEJvhwiAlLOrk3
        sQRSeUA3JTpdNgYHzzwE/XG9eDS0AMBa2HdXL652
X-Google-Smtp-Source: ABdhPJz8PENAiBUnmTR1bV+8HaAXu78+dgmwSP/xGi72OKtkgb8mrm+5gR3j8ariKf9aU8cTFQZuvQ4+AJsiHDlMTmlx
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c40e:ee2c:2ab8:257a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:1883:: with SMTP id
 125mr27293602yby.465.1618956501665; Tue, 20 Apr 2021 15:08:21 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:08:01 -0700
In-Reply-To: <20210420220804.486803-1-axelrasmussen@google.com>
Message-Id: <20210420220804.486803-8-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v4 07/10] userfaultfd/selftests: reinitialize test context in
 each test
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 tools/testing/selftests/vm/userfaultfd.c | 215 ++++++++++++-----------
 1 file changed, 116 insertions(+), 99 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 1f65c4ab7994..3fbc69f513dc 100644
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
@@ -342,6 +343,111 @@ static struct uffd_test_ops hugetlb_uffd_test_ops = {
 
 static struct uffd_test_ops *uffd_test_ops;
 
+static void userfaultfd_open(uint64_t *features)
+{
+	struct uffdio_api uffdio_api;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
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
+}
+
+static inline void munmap_area(void **area)
+{
+	if (*area)
+		if (munmap(*area, nr_pages * page_size))
+			err("munmap");
+
+	*area = NULL;
+}
+
+static void uffd_test_ctx_clear(void)
+{
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
+	munmap_area((void **)&area_src);
+	munmap_area((void **)&area_src_alias);
+	munmap_area((void **)&area_dst);
+	munmap_area((void **)&area_dst_alias);
+}
+
+static void uffd_test_ctx_init_ext(uint64_t *features)
+{
+	unsigned long nr, cpu;
+
+	uffd_test_ctx_clear();
+
+	uffd_test_ops->allocate_area((void **)&area_src);
+	uffd_test_ops->allocate_area((void **)&area_dst);
+
+	uffd_test_ops->release_pages(area_src);
+	uffd_test_ops->release_pages(area_dst);
+
+	userfaultfd_open(features);
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
+}
+
+static inline void uffd_test_ctx_init(uint64_t features)
+{
+	uffd_test_ctx_init_ext(&features);
+}
+
 static int my_bcmp(char *str1, char *str2, size_t n)
 {
 	unsigned long i;
@@ -726,40 +832,6 @@ static int stress(struct uffd_stats *uffd_stats)
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
@@ -868,6 +940,8 @@ static int faulting_process(int signal_test)
 			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
 	if (area_dst == MAP_FAILED)
 		err("mremap");
+	/* Reset area_src since we just clobbered it */
+	area_src = NULL;
 
 	for (; nr < nr_pages; nr++) {
 		count = *area_count(area_dst, nr);
@@ -961,10 +1035,8 @@ static int userfaultfd_zeropage_test(void)
 	printf("testing UFFDIO_ZEROPAGE: ");
 	fflush(stdout);
 
-	uffd_test_ops->release_pages(area_dst);
+	uffd_test_ctx_init(0);
 
-	if (userfaultfd_open(0))
-		return 1;
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
@@ -981,7 +1053,6 @@ static int userfaultfd_zeropage_test(void)
 		if (my_bcmp(area_dst, zeropage, page_size))
 			err("zeropage is not zero");
 
-	close(uffd);
 	printf("done.\n");
 	return 0;
 }
@@ -999,12 +1070,10 @@ static int userfaultfd_events_test(void)
 	printf("testing events (fork, remap, remove): ");
 	fflush(stdout);
 
-	uffd_test_ops->release_pages(area_dst);
-
 	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
 		UFFD_FEATURE_EVENT_REMOVE;
-	if (userfaultfd_open(features))
-		return 1;
+	uffd_test_ctx_init(features);
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
@@ -1037,8 +1106,6 @@ static int userfaultfd_events_test(void)
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
-	close(uffd);
-
 	uffd_stats_report(&stats, 1);
 
 	return stats.missing_faults != nr_pages;
@@ -1058,11 +1125,9 @@ static int userfaultfd_sig_test(void)
 	printf("testing signal delivery: ");
 	fflush(stdout);
 
-	uffd_test_ops->release_pages(area_dst);
-
 	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
-	if (userfaultfd_open(features))
-		return 1;
+	uffd_test_ctx_init(features);
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
@@ -1103,7 +1168,6 @@ static int userfaultfd_sig_test(void)
 	printf("done.\n");
 	if (userfaults)
 		err("Signal test failed, userfaults: %ld", userfaults);
-	close(uffd);
 
 	return userfaults != 0;
 }
@@ -1126,10 +1190,7 @@ static int userfaultfd_minor_test(void)
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	uffd_test_ops->release_pages(area_dst);
-
-	if (userfaultfd_open_ext(&features))
-		return 1;
+	uffd_test_ctx_init_ext(&features);
 	/* If kernel reports the feature isn't supported, skip the test. */
 	if (!(features & UFFD_FEATURE_MINOR_HUGETLBFS)) {
 		printf("skipping test due to lack of feature support\n");
@@ -1183,8 +1244,6 @@ static int userfaultfd_minor_test(void)
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
-	close(uffd);
-
 	uffd_stats_report(&stats, 1);
 
 	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
@@ -1196,50 +1255,9 @@ static int userfaultfd_stress(void)
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
-		return 1;
-
-	count_verify = malloc(nr_pages * sizeof(unsigned long long));
-	if (!count_verify) {
-		perror("count_verify");
-		return 1;
-	}
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
-	if (!pipefd) {
-		perror("pipefd");
-		return 1;
-	}
-	for (cpu = 0; cpu < nr_cpus; cpu++) {
-		if (pipe2(&pipefd[cpu*2], O_CLOEXEC | O_NONBLOCK)) {
-			perror("pipe");
-			return 1;
-		}
-	}
+	uffd_test_ctx_init(0);
 
 	if (posix_memalign(&area, page_size, page_size))
 		err("out of memory");
@@ -1360,7 +1378,6 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
 
-	close(uffd);
 	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
 		|| userfaultfd_events_test() || userfaultfd_minor_test();
 }
-- 
2.31.1.368.gbe11c130af-goog

