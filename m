Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BAC486002
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 05:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiAFEuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 23:50:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39842 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiAFEuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 23:50:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADB5D6197C
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jan 2022 04:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD02FC36AE0;
        Thu,  6 Jan 2022 04:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641444622;
        bh=ILLQzuWjNs8EdgzOy5u5IBbzLYnN9V1R8zeX3tRpxA8=;
        h=From:To:Cc:Subject:Date:From;
        b=b8DHNOPeHO8/xu4gJdh06VV6d2Irj/5Zbm45hbOKZU+UQVg35Ud44xXL0oH7kz6GJ
         lbfyrgVUw4+6ENs3/zTOsWhXRa5nMIBFRQ2rbe817JR+jGPfEwOUMOkxMEJxjssAkS
         hHJb+rtTQWJKdyryI8PiuRWYj9ioNRe6oq/gpwBVbOjIuWKUGWcwsVEabk2MNRAqd0
         +MFAbeNQ8i+/Hj/iakbR1Y0PuXiyXzVcQt7kyFYKnu3ROL2AkY4F4fkK2BCR+N25Vh
         RtxniJCYVZKyoVsSrRab3mKOd8G8Hw5D4o9RRRIX1cuJclIWvnRphBLIszoFHQLmLN
         dz4/eOrEnOoog==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-aio@kvack.org, Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [libaio PATCH] harness: add test for aio poll missed events
Date:   Wed,  5 Jan 2022 20:49:43 -0800
Message-Id: <20220106044943.55242-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a regression test for a recently-fixed kernel bug where aio polls
sometimes didn't complete even if the file is ready.

This is a cleaned-up version of the test which I originally posted at
https://lore.kernel.org/r/YbMKtAjSJdXNTzOk@sol.localdomain

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 harness/cases/23.t | 255 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 255 insertions(+)
 create mode 100644 harness/cases/23.t

diff --git a/harness/cases/23.t b/harness/cases/23.t
new file mode 100644
index 0000000..cc5a8a1
--- /dev/null
+++ b/harness/cases/23.t
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: LGPL-2.1+
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/*
+ * Verify that aio poll doesn't miss any events.  This is a regression test for
+ * kernel commit 363bee27e258 ("aio: keep poll requests on waitqueue until
+ * completed").
+ *
+ * This test repeatedly does the following operations in parallel:
+ *
+ *	Thread 1: Aio-poll the read end of a pipe, then wait for it to complete.
+ *	Thread 2: Splice a byte to the pipe.
+ *	Thread 3: Read from the pipe, then splice another byte to it.
+ *
+ * The pipe will never be empty at the end, so the poll should always complete.
+ * With the bug, that didn't always happen, as the second splice sometimes
+ * didn't cause a wakeup due to the waitqueue entry being temporarily removed,
+ * as per the following buggy sequence of events:
+ *
+ *	1. Thread 1 adds the poll waitqueue entry.
+ *	2. Thread 2 does the first splice.  This calls the poll wakeup function,
+ *	   which deletes the waitqueue entry [BUG!], then schedules the async
+ *	   completion work.
+ *	3. Thread 3 reads from the pipe.
+ *	4. Async work sees that the pipe isn't ready.
+ *	5. Thread 3 splices some data to the pipe, but doesn't call the poll
+ *	   wakeup function because the waitqueue is currently empty.
+ *	6. Async work re-adds the waitqueue entry, as the pipe wasn't ready.
+ *
+ * The reason we use splice() rather than write() is because in order for step
+ * (2) to not complete the poll inline, the kernel must not pass an event mask
+ * to the wakeup function.  This is the case for splice() to a pipe, but not
+ * write() to a pipe (at least in the kernel versions with the bug).
+ */
+#include <poll.h>
+#include <pthread.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <sys/wait.h>
+
+static int tmpfd;
+static int pipefds[2];
+static pthread_barrier_t barrier;
+static bool exiting;
+
+static void fail(const char *format, ...)
+{
+	va_list va;
+
+	va_start(va, format);
+	vfprintf(stderr, format, va);
+	putc('\n', stderr);
+	va_end(va);
+	exit(1);
+}
+
+static void fail_errno(const char *format, ...)
+{
+	va_list va;
+
+	va_start(va, format);
+	vfprintf(stderr, format, va);
+	fprintf(stderr, ": %s", strerror(errno));
+	putc('\n', stderr);
+	va_end(va);
+	exit(1);
+}
+
+/* Thread 2 */
+static void *thrproc2(void *arg)
+{
+	for (;;) {
+		off_t offset = 0;
+
+		pthread_barrier_wait(&barrier);
+		if (exiting)
+			break;
+
+		/* Splice a byte to the pipe. */
+		if (splice(tmpfd, &offset, pipefds[1], NULL, 1, 0) != 1)
+			fail_errno("splice failed in thread 2");
+
+		pthread_barrier_wait(&barrier);
+	}
+	return NULL;
+}
+
+/* Thread 3 */
+static void *thrproc3(void *arg)
+{
+	for (;;) {
+		char c;
+		off_t offset = 0;
+
+		pthread_barrier_wait(&barrier);
+		if (exiting)
+			break;
+
+		/* Read a byte from the pipe. */
+		if (read(pipefds[0], &c, 1) != 1)
+			fail_errno("read failed in thread 3");
+
+		/* Splice a byte to the pipe. */
+		if (splice(tmpfd, &offset, pipefds[1], NULL, 1, 0) != 1)
+			fail_errno("splice failed in thread 3");
+
+		pthread_barrier_wait(&barrier);
+	}
+	return NULL;
+}
+
+static int child_process(void)
+{
+	int ret;
+	io_context_t ctx = NULL;
+	pthread_t t2, t3;
+	int i;
+	struct iocb iocb;
+	struct iocb *iocbs[] = { &iocb };
+	struct io_event event;
+	struct timespec timeout = { .tv_sec = 5 };
+	char c;
+
+	ret = io_setup(1, &ctx);
+	if (ret != 0) {
+		errno = -ret;
+		fail_errno("io_setup failed");
+	}
+
+	if (pipe(pipefds) != 0)
+		fail_errno("pipe failed");
+
+	errno = pthread_barrier_init(&barrier, NULL, 3);
+	if (errno)
+		fail_errno("pthread_barrier_init failed");
+
+	errno = pthread_create(&t2, NULL, thrproc2, NULL);
+	if (errno)
+		fail_errno("pthread_create failed");
+
+	errno = pthread_create(&t3, NULL, thrproc3, NULL);
+	if (errno)
+		fail_errno("pthread_create failed");
+
+	for (i = 0; i < 5000; i++) {
+		/* Thread 1 */
+
+		/* Submit a poll request. */
+		io_prep_poll(&iocb, pipefds[0], POLLIN);
+		ret = io_submit(ctx, 1, iocbs);
+		if (ret != 1) {
+			/* If aio poll isn't supported, skip the test. */
+			errno = -ret;
+			if (errno == EINVAL) {
+				printf("aio poll is not supported\n");
+				return 3;
+			}
+			fail_errno("io_submit failed");
+		}
+
+		/* Tell the other threads to continue. */
+		pthread_barrier_wait(&barrier);
+
+		/*
+		 * Wait for the poll to complete.  Wait at most 5 seconds, in
+		 * case we hit the bug so the poll wouldn't otherwise complete.
+		 */
+		ret = io_getevents(ctx, 1, 1, &event, &timeout);
+		if (ret < 0) {
+			errno = -ret;
+			fail_errno("io_getevents failed");
+		}
+		if (ret == 0) {
+			/*
+			 * The poll eventually timed out rather than giving us
+			 * an event, so we've detected the bug.
+			 */
+			fail("FAIL: poll missed an event!");
+		}
+
+		/* Wait for the other threads to finish their iteration. */
+		pthread_barrier_wait(&barrier);
+
+		/* The pipe has 1 byte; read it to get back to initial state. */
+		if (read(pipefds[0], &c, 1) != 1)
+			fail_errno("read failed in thread 1");
+	}
+	exiting = true;
+	pthread_barrier_wait(&barrier);
+	errno = pthread_join(t2, NULL);
+	if (errno)
+		fail_errno("pthread_join failed");
+	errno = pthread_join(t3, NULL);
+	if (errno)
+		fail_errno("pthread_join failed");
+	return 0;
+}
+
+int test_main(void)
+{
+	char tmpfile_name[] = "/tmp/aio.XXXXXX";
+	int ret;
+	int ncpus;
+	int i;
+	int overall_status = 0;
+	int status;
+
+	/* Create a 1-byte temporary file. */
+	tmpfd = mkstemp(tmpfile_name);
+	if (tmpfd < 0) {
+		fprintf(stderr, "failed to create temporary file: %s\n",
+			strerror(errno));
+		return 1;
+	}
+	if (pwrite(tmpfd, "X", 1, 0) != 1) {
+		fprintf(stderr, "failed to write to temporary file: %s\n",
+			strerror(errno));
+		return 1;
+	}
+
+	/*
+	 * Run the test in multiple processes to increase the chance of hitting
+	 * the race condition.
+	 */
+	ret = sysconf(_SC_NPROCESSORS_CONF);
+	if (ret < 1) {
+		fprintf(stderr, "failed to get number of CPUs: %s\n",
+			strerror(errno));
+		return 1;
+	}
+	ncpus = ret;
+	for (i = 0; i < ncpus; i++) {
+		ret = fork();
+		if (ret < 0) {
+			fprintf(stderr, "fork failed: %s\n", strerror(errno));
+			return 1;
+		}
+		if (ret == 0)
+			exit(child_process());
+	}
+	for (i = 0; i < ncpus; i++) {
+		if (wait(&status) < 0) {
+			fprintf(stderr, "wait failed: %s\n", strerror(errno));
+			return 1;
+		}
+		if (!WIFEXITED(status))
+			overall_status = 1;
+		else if (overall_status == 0)
+			overall_status = WEXITSTATUS(status);
+	}
+	unlink(tmpfile_name);
+	return overall_status;
+}
-- 
2.34.1

