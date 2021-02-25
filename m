Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611D93248D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 03:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhBYCQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 21:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbhBYCQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 21:16:22 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D75C0617AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 18:14:49 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id f3so3084611qtx.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 18:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZsYCxeDvLqZ/7+DecH//BCWhXFmBGzzyJFG7f8MIx+Q=;
        b=pdAJWyOxobhC6+yKFPSPn/sCQjrKJ0P9rvIFKhcLswKi6IvVSKEwjgtEHp1BH7SndH
         Vn+LJrK5CGw2URX5KpU76iRZSjr03/yP/40rJ/C9oTtDCV61C+xfXWg3F2nDwg1PEnXK
         iN5vCL527ZbeVLTl3cuyc65ZOf8mgyw4LADherBkfrdFX720C/F39LVomXEiY75dG50a
         0g1gy08vFMdK9WIpioiK3/rG+lZbLXbnOmMhaFWkX13gIjcSejbdESDOuJxsKAa6UQEg
         LL5bc+CrquCIXQAv6rVoikOYQ0ME6MRtDNVVIrCPPu87xp38oYgmLMZF3yu9DZqzxQgj
         F8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZsYCxeDvLqZ/7+DecH//BCWhXFmBGzzyJFG7f8MIx+Q=;
        b=d/bIcyxNeBn7cC+HaGzD71OssRAIRmRXghtJHVnzJCbxUvYv024o/XqxIF1lCPgQJM
         +9xqdyl/p7LkUUh1Kn5BM1p94Px3/5OjmiYE3ZgW6Fa+803cVgjLgl37rNyMIxtrazeo
         g0V1cPhRg99N83uK7sbik1xsDqeakn4TYS4Hx1VSU56YfLMtITvt2SfKgePX6chY7Tjg
         lRr5qoZOnXXFVd0umaFE97bkY5PoygnBEH1Si3ci4caE5GklZd9eymqV7s7ZzK9wB38x
         LJto+DnQLocAkk+VGu5Qlq0ksijfFFzDTlm4wDPknyNpsexhv0874dj+1mYetHWEZxh8
         EgVw==
X-Gm-Message-State: AOAM532w284iBlR7PP5K8IOj228I69WZ80+y0Czi0zO+F6XO8rvd9xvp
        ZmdHh11v0sqNm3bLu4zEW9XGiDOqnIS3stpXG5yY
X-Google-Smtp-Source: ABdhPJyn4qec/Y/QjAbvRh0T46LXREy/ouV8TJF5wrQnR6HFcCHBu+v9oc3aN//SDlVKq0aSpGuHAEkQ8GSV3bmntA0d
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:a5fd:f848:2fdf:4651])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:242f:: with SMTP id
 gy15mr669807qvb.17.1614219288154; Wed, 24 Feb 2021 18:14:48 -0800 (PST)
Date:   Wed, 24 Feb 2021 18:14:19 -0800
In-Reply-To: <20210225021420.2290912-1-axelrasmussen@google.com>
Message-Id: <20210225021420.2290912-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210225021420.2290912-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 4/5] userfaultfd/selftests: reinitialize test context in each test
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
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
 tools/testing/selftests/vm/userfaultfd.c | 249 ++++++++++++++---------
 1 file changed, 151 insertions(+), 98 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 4a18590fe0f8..5183ddb3080d 100644
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
@@ -376,6 +377,146 @@ static struct uffd_test_ops hugetlb_uffd_test_ops = {
 
 static struct uffd_test_ops *uffd_test_ops;
 
+static int userfaultfd_open(uint64_t *features)
+{
+	struct uffdio_api uffdio_api;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0) {
+		fprintf(stderr,
+			"userfaultfd syscall not available in this kernel\n");
+		return 1;
+	}
+	uffd_flags = fcntl(uffd, F_GETFD, NULL);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = *features;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
+		fprintf(stderr, "UFFDIO_API failed.\nPlease make sure to "
+			"run with either root or ptrace capability.\n");
+		return 1;
+	}
+	if (uffdio_api.api != UFFD_API) {
+		fprintf(stderr, "UFFDIO_API error: %" PRIu64 "\n",
+			(uint64_t)uffdio_api.api);
+		return 1;
+	}
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
+	if (!count_verify) {
+		perror("count_verify");
+		return 1;
+	}
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
+	if (!pipefd) {
+		perror("pipefd");
+		return 1;
+	}
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK)) {
+			perror("pipe");
+			return 1;
+		}
+	}
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
+	if (*area) {
+		if (munmap(*area, nr_pages * page_size)) {
+			perror("munmap");
+			return 1;
+		}
+	}
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
+			if (close(pipefd[i])) {
+				perror("close pipefd");
+				ret = 1;
+			}
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
+		if (close(uffd)) {
+			perror("close uffd");
+			ret = 1;
+		}
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
@@ -859,40 +1000,6 @@ static int stress(struct uffd_stats *uffd_stats)
 	return 0;
 }
 
-static int userfaultfd_open_ext(uint64_t *features)
-{
-	struct uffdio_api uffdio_api;
-
-	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
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
@@ -1010,6 +1117,8 @@ static int faulting_process(int signal_test)
 		perror("mremap");
 		exit(1);
 	}
+	/* Reset area_src since we just clobbered it */
+	area_src = NULL;
 
 	for (; nr < nr_pages; nr++) {
 		count = *area_count(area_dst, nr);
@@ -1113,11 +1222,9 @@ static int userfaultfd_zeropage_test(void)
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
@@ -1143,7 +1250,6 @@ static int userfaultfd_zeropage_test(void)
 		}
 	}
 
-	close(uffd);
 	printf("done.\n");
 	return 0;
 }
@@ -1161,13 +1267,11 @@ static int userfaultfd_events_test(void)
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
@@ -1213,8 +1317,6 @@ static int userfaultfd_events_test(void)
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
-	close(uffd);
-
 	uffd_stats_report(&stats, 1);
 
 	return stats.missing_faults != nr_pages;
@@ -1234,12 +1336,10 @@ static int userfaultfd_sig_test(void)
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
@@ -1297,7 +1397,6 @@ static int userfaultfd_sig_test(void)
 	if (userfaults)
 		fprintf(stderr, "Signal test failed, userfaults: %ld\n",
 			userfaults);
-	close(uffd);
 	return userfaults != 0;
 }
 
@@ -1319,10 +1418,7 @@ static int userfaultfd_minor_test(void)
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
@@ -1390,8 +1486,6 @@ static int userfaultfd_minor_test(void)
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
-	close(uffd);
-
 	uffd_stats_report(&stats, 1);
 
 	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
@@ -1403,52 +1497,12 @@ static int userfaultfd_stress(void)
 	char *tmp_area;
 	unsigned long nr;
 	struct uffdio_register uffdio_register;
-	unsigned long cpu;
 	int err;
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
-
 	if (posix_memalign(&area, page_size, page_size)) {
 		fprintf(stderr, "out of memory\n");
 		return 1;
@@ -1593,7 +1647,6 @@ static int userfaultfd_stress(void)
 	if (err)
 		return err;
 
-	close(uffd);
 	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
 		|| userfaultfd_events_test() || userfaultfd_minor_test();
 }
-- 
2.30.0.617.g56c4b15f3c-goog

