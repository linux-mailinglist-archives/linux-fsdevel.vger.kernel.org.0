Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA079312A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 23:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbjIEVpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 17:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbjIEVoo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F3A199
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693950168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXvYIDhk9Xunttv7gLZeZ6m5tePV5F/iEIjQTI0WMa4=;
        b=PwGwsk6P1xWHNl0u6nlKM/1aRicywEQ3mMHqic9Vs0nM5tP9pGIl7wNTQxE2Nou9oR++sF
        CaGKG6T49+S4/Mti4MkG0L7SnTKwUGSZWjINbt6gXeF7t+R5NYwdFTdQv/NcEa+ByGSlbi
        qz5tPNT/U4EXgBhLBf3FZOOmYPho9so=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-g1ZEE6SxOQOcRNlXN23eRA-1; Tue, 05 Sep 2023 17:42:47 -0400
X-MC-Unique: g1ZEE6SxOQOcRNlXN23eRA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7708c1ae500so2640185a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 14:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950167; x=1694554967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXvYIDhk9Xunttv7gLZeZ6m5tePV5F/iEIjQTI0WMa4=;
        b=B8/93SiVOipEivxT1g7WR53hLqeHQr5LJwvOR9NGCiQeG7LWdFfPJaFgGBNuj8hr6l
         LoKifNazX5w2oBm/6dlsyt0Phh+gcO000Qcz5NjmrZdvDPOg+uJ8ZixuG73LAMQeokyM
         /EGFaNcYQ9f1IhK9NIqwKDJXxzrAFs/eNFx7G3blV2ru0virDheWiRhG0tnk1S0FZ7Wh
         xXZlBT7DFaWmlLSuveD/R20Kkpk254/Ocwn12gV3hu19FzzAAT2M5LYpEF7JkA2V48ss
         UwodeL84ps5gs2S6Jtv/Eki1AnaV/Pih9nlBRCulRB8vV0CQDtNpOXgxIOIsj9l8/JRB
         8xZw==
X-Gm-Message-State: AOJu0YxG4JBnNaZmeNGgZXEZSdIJQw7I3Mu6hPLNjYaa8fPOX1uap+kU
        vhlFNTinhmT1f3QQ+kH1W6FCYDTmEAKzePMNbqk+TQ/ubuKyDzcGO+lw5TT9zXiE3NKPFQ89UEn
        stGwVRCOkbYh88NvpuZ10rIubpQ==
X-Received: by 2002:a05:620a:1a26:b0:76c:ed4e:ac10 with SMTP id bk38-20020a05620a1a2600b0076ced4eac10mr16770229qkb.6.1693950167013;
        Tue, 05 Sep 2023 14:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGbQRi3lj2GCHZMrI9G7N8PmFSehzLMjlA7R138X4fKreXMS+kXyyfOvFWMrTvBreLVK2oMg==
X-Received: by 2002:a05:620a:1a26:b0:76c:ed4e:ac10 with SMTP id bk38-20020a05620a1a2600b0076ced4eac10mr16770206qkb.6.1693950166761;
        Tue, 05 Sep 2023 14:42:46 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i2-20020a37c202000000b007682af2c8aasm4396938qkm.126.2023.09.05.14.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:42:46 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Anish Moorthy <amoorthy@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christian Brauner <brauner@kernel.org>, peterx@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 7/7] selftests/mm: uffd perf test
Date:   Tue,  5 Sep 2023 17:42:35 -0400
Message-ID: <20230905214235.320571-8-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214235.320571-1-peterx@redhat.com>
References: <20230905214235.320571-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple perf test for userfaultfd missing mode, on private anon only.
It mostly only tests the messaging, so memory type / fault type may not
that much yet.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/Makefile      |   2 +
 tools/testing/selftests/mm/uffd-common.c |  18 ++
 tools/testing/selftests/mm/uffd-common.h |   1 +
 tools/testing/selftests/mm/uffd-perf.c   | 207 +++++++++++++++++++++++
 4 files changed, 228 insertions(+)
 create mode 100644 tools/testing/selftests/mm/uffd-perf.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 6a9fc5693145..acb22517d37e 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -64,6 +64,7 @@ TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
 TEST_GEN_FILES += uffd-unit-tests
+TEST_GEN_FILES += uffd-perf
 TEST_GEN_FILES += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 TEST_GEN_FILES += ksm_functional_tests
@@ -120,6 +121,7 @@ $(TEST_GEN_FILES): vm_util.c
 
 $(OUTPUT)/uffd-stress: uffd-common.c
 $(OUTPUT)/uffd-unit-tests: uffd-common.c
+$(OUTPUT)/uffd-perf: uffd-common.c
 
 ifeq ($(ARCH),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 851284395b29..afbf2f7add56 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -725,3 +725,21 @@ int uffd_get_features(uint64_t *features)
 
 	return 0;
 }
+
+uint64_t get_usec(void)
+{
+    uint64_t val = 0;
+    struct timespec t;
+    int ret = clock_gettime(CLOCK_MONOTONIC, &t);
+
+    if (ret == -1) {
+        perror("clock_gettime() failed");
+        /* should never happen */
+        exit(-1);
+    }
+
+    val = t.tv_nsec / 1000;     /* ns -> us */
+    val += t.tv_sec * 1000000;  /* s -> us */
+
+    return val;
+}
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 9d66ad5c52cb..4273201ae19f 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -123,6 +123,7 @@ int uffd_open_dev(unsigned int flags);
 int uffd_open_sys(unsigned int flags);
 int uffd_open(unsigned int flags);
 int uffd_get_features(uint64_t *features);
+uint64_t get_usec(void);
 
 #define TEST_ANON	1
 #define TEST_HUGETLB	2
diff --git a/tools/testing/selftests/mm/uffd-perf.c b/tools/testing/selftests/mm/uffd-perf.c
new file mode 100644
index 000000000000..eda99718311a
--- /dev/null
+++ b/tools/testing/selftests/mm/uffd-perf.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Userfaultfd performance tests.
+ *
+ *  Copyright (C) 2023  Red Hat, Inc.
+ */
+
+#include "uffd-common.h"
+
+#ifdef __NR_userfaultfd
+
+#define  DEF_MEM_SIZE_MB  (512)
+#define  MB(x)  ((x) * 1024 * 1024)
+#define  DEF_N_TESTS  5
+
+static volatile bool perf_test_started;
+static unsigned int n_uffd_threads, n_worker_threads;
+static uint64_t nr_pages_per_worker;
+static unsigned long n_tests = DEF_N_TESTS;
+
+static void setup_env(unsigned long mem_size_mb)
+{
+	/* Test private anon only for now */
+	map_shared = false;
+	uffd_test_ops = &anon_uffd_test_ops;
+	page_size = psize();
+	nr_cpus = n_uffd_threads;
+	nr_pages = MB(mem_size_mb) / page_size;
+	nr_pages_per_worker = nr_pages / n_worker_threads;
+	if (nr_pages_per_worker == 0)
+		err("each worker should at least own one page");
+}
+
+void *worker_fn(void *opaque)
+{
+	unsigned long i = (unsigned long) opaque;
+	unsigned long page_nr, start_nr, end_nr;
+	int v = 0;
+
+	start_nr = i * nr_pages_per_worker;
+	end_nr = (i + 1) * nr_pages_per_worker;
+
+	while (!perf_test_started);
+
+	for (page_nr = start_nr; page_nr < end_nr; page_nr++)
+		v += *(volatile int *)(area_dst + page_nr * page_size);
+
+	return NULL;
+}
+
+static uint64_t run_perf(uint64_t mem_size_mb, bool poll)
+{
+	pthread_t worker_threads[n_worker_threads];
+	pthread_t uffd_threads[n_uffd_threads];
+	const char *errmsg = NULL;
+	struct uffd_args *args;
+	uint64_t start, end;
+	int i, ret;
+
+	if (uffd_test_ctx_init(0, &errmsg))
+		err("%s", errmsg);
+
+	/*
+	 * By default, uffd is opened with NONBLOCK mode; use block mode
+	 * when test read()
+	 */
+	if (!poll) {
+		int flags = fcntl(uffd, F_GETFL);
+
+		if (flags < 0)
+			err("fcntl(F_GETFL) failed");
+
+		if (flags & O_NONBLOCK)
+			flags &= ~O_NONBLOCK;
+
+		if (fcntl(uffd, F_SETFL, flags))
+			err("fcntl(F_SETFL) failed");
+	}
+
+	ret = uffd_register(uffd, area_dst, MB(mem_size_mb),
+			    true, false, false);
+	if (ret)
+		err("uffd_register() failed");
+
+	args = calloc(nr_cpus, sizeof(struct uffd_args));
+	if (!args)
+		err("calloc()");
+
+	for (i = 0; i < n_uffd_threads; i++) {
+		args[i].cpu = i;
+		uffd_fault_thread_create(&uffd_threads[i], NULL,
+					 &args[i], poll);
+	}
+
+	for (i = 0; i < n_worker_threads; i++) {
+		if (pthread_create(&worker_threads[i], NULL,
+				   worker_fn, (void *)(uintptr_t)i))
+			err("create uffd threads");
+	}
+
+	start = get_usec();
+	perf_test_started = true;
+	for (i = 0; i < n_worker_threads; i++)
+		pthread_join(worker_threads[i], NULL);
+	end = get_usec();
+
+	for (i = 0; i < n_uffd_threads; i++) {
+		struct uffd_args *p = &args[i];
+
+		uffd_fault_thread_join(uffd_threads[i], i, poll);
+
+		assert(p->wp_faults == 0 && p->minor_faults == 0);
+	}
+
+	free(args);
+
+	ret = uffd_unregister(uffd, area_dst, MB(mem_size_mb));
+	if (ret)
+		err("uffd_unregister() failed");
+
+	return end - start;
+}
+
+static void usage(const char *prog)
+{
+	printf("usage: %s <options>\n", prog);
+	puts("");
+	printf("  -m: size of memory to test (in MB, default: %u)\n",
+	       DEF_MEM_SIZE_MB);
+	puts("  -p: use poll() (the default)");
+	puts("  -r: use read()");
+	printf("  -t: test rounds (default: %u)\n", DEF_N_TESTS);
+	puts("  -u: number of uffd threads (default: n_cpus)");
+	puts("  -w: number of worker threads (default: n_cpus)");
+	puts("");
+	exit(KSFT_FAIL);
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long mem_size_mb = DEF_MEM_SIZE_MB;
+	uint64_t result, sum = 0;
+	bool use_poll = true;
+	int opt, count;
+
+	n_uffd_threads = n_worker_threads = sysconf(_SC_NPROCESSORS_ONLN);
+
+	while ((opt = getopt(argc, argv, "hm:prt:u:w:")) != -1) {
+		switch (opt) {
+		case 'm':
+			mem_size_mb = strtoul(optarg, NULL, 10);
+			break;
+		case 'p':
+			use_poll = true;
+			break;
+		case 'r':
+			use_poll = false;
+			break;
+		case 't':
+			n_tests = strtoul(optarg, NULL, 10);
+			break;
+		case 'u':
+			n_uffd_threads = strtoul(optarg, NULL, 10);
+			break;
+		case 'w':
+			n_worker_threads = strtoul(optarg, NULL, 10);
+			break;
+		case 'h':
+		default:
+			/* Unknown */
+			usage(argv[0]);
+			break;
+		}
+	}
+
+	setup_env(mem_size_mb);
+
+	printf("Message mode: \t\t%s\n", use_poll ? "poll" : "read");
+	printf("Mem size: \t\t%lu (MB)\n", mem_size_mb);
+	printf("Uffd threads: \t\t%u\n", n_uffd_threads);
+	printf("Worker threads: \t%u\n", n_worker_threads);
+	printf("Test rounds: \t\t%lu\n", n_tests);
+	printf("Time used (us): \t");
+
+	for (count = 0; count < n_tests; count++) {
+		result = run_perf(mem_size_mb, use_poll);
+		sum += result;
+		printf("%" PRIu64 ", ", result);
+		fflush(stdout);
+	}
+	printf("\b\b \n");
+	printf("Average (us): \t\t%"PRIu64"\n", sum / n_tests);
+
+	return KSFT_PASS;
+}
+
+#else /* __NR_userfaultfd */
+
+#warning "missing __NR_userfaultfd definition"
+
+int main(void)
+{
+	printf("Skipping %s (missing __NR_userfaultfd)\n", __file__);
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_userfaultfd */
-- 
2.41.0

