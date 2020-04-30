Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D511BF8D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 15:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgD3NDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 09:03:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgD3NDi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:03:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C677ACA1;
        Thu, 30 Apr 2020 13:03:35 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Heiher <r@hev.cc>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kselftests: introduce new epoll60 testcase for catching lost wakeups
Date:   Thu, 30 Apr 2020 15:03:25 +0200
Message-Id: <20200430130326.1368509-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This test case catches lost wake up introduced by:
  339ddb53d373 ("fs/epoll: remove unnecessary wakeups of nested epoll")

The test is simple: we have 10 threads and 10 event fds. Each thread
can harvest only 1 event. 1 producer fires all 10 events at once and
waits that all 10 events will be observed by 10 threads.

In case of lost wakeup epoll_wait() will timeout and 0 will be
returned.

Test case catches two sort of problems: forgotten wakeup on event,
which hits the ->ovflist list, this problem was fixed by:
  5a2513239750 ("eventpoll: fix missing wakeup for ovflist in ep_poll_callback")

the other problem is when several sequential events hit the same
waiting thread, thus other waiters get no wakeups. Problem is
fixed in the following patch.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Khazhismel Kumykov <khazhy@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Heiher <r@hev.cc>
Cc: Jason Baron <jbaron@akamai.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../filesystems/epoll/epoll_wakeup_test.c     | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 11eee0b60040..d979ff14775a 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -3,6 +3,7 @@
 #define _GNU_SOURCE
 #include <poll.h>
 #include <unistd.h>
+#include <assert.h>
 #include <signal.h>
 #include <pthread.h>
 #include <sys/epoll.h>
@@ -3136,4 +3137,149 @@ TEST(epoll59)
 	close(ctx.sfd[0]);
 }
 
+enum {
+	EPOLL60_EVENTS_NR = 10,
+};
+
+struct epoll60_ctx {
+	volatile int stopped;
+	int ready;
+	int waiters;
+	int epfd;
+	int evfd[EPOLL60_EVENTS_NR];
+};
+
+static void *epoll60_wait_thread(void *ctx_)
+{
+	struct epoll60_ctx *ctx = ctx_;
+	struct epoll_event e;
+	sigset_t sigmask;
+	uint64_t v;
+	int ret;
+
+	/* Block SIGUSR1 */
+	sigemptyset(&sigmask);
+	sigaddset(&sigmask, SIGUSR1);
+	sigprocmask(SIG_SETMASK, &sigmask, NULL);
+
+	/* Prepare empty mask for epoll_pwait() */
+	sigemptyset(&sigmask);
+
+	while (!ctx->stopped) {
+		/* Mark we are ready */
+		__atomic_fetch_add(&ctx->ready, 1, __ATOMIC_ACQUIRE);
+
+		/* Start when all are ready */
+		while (__atomic_load_n(&ctx->ready, __ATOMIC_ACQUIRE) &&
+		       !ctx->stopped);
+
+		/* Account this waiter */
+		__atomic_fetch_add(&ctx->waiters, 1, __ATOMIC_ACQUIRE);
+
+		ret = epoll_pwait(ctx->epfd, &e, 1, 2000, &sigmask);
+		if (ret != 1) {
+			/* We expect only signal delivery on stop */
+			assert(ret < 0 && errno == EINTR && "Lost wakeup!\n");
+			assert(ctx->stopped);
+			break;
+		}
+
+		ret = read(e.data.fd, &v, sizeof(v));
+		/* Since we are on ET mode, thus each thread gets its own fd. */
+		assert(ret == sizeof(v));
+
+		__atomic_fetch_sub(&ctx->waiters, 1, __ATOMIC_RELEASE);
+	}
+
+	return NULL;
+}
+
+static inline unsigned long long msecs(void)
+{
+	struct timespec ts;
+	unsigned long long msecs;
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	msecs = ts.tv_sec * 1000ull;
+	msecs += ts.tv_nsec / 1000000ull;
+
+	return msecs;
+}
+
+static inline int count_waiters(struct epoll60_ctx *ctx)
+{
+	return __atomic_load_n(&ctx->waiters, __ATOMIC_ACQUIRE);
+}
+
+TEST(epoll60)
+{
+	struct epoll60_ctx ctx = { 0 };
+	pthread_t waiters[ARRAY_SIZE(ctx.evfd)];
+	struct epoll_event e;
+	int i, n, ret;
+
+	signal(SIGUSR1, signal_handler);
+
+	ctx.epfd = epoll_create1(0);
+	ASSERT_GE(ctx.epfd, 0);
+
+	/* Create event fds */
+	for (i = 0; i < ARRAY_SIZE(ctx.evfd); i++) {
+		ctx.evfd[i] = eventfd(0, EFD_NONBLOCK);
+		ASSERT_GE(ctx.evfd[i], 0);
+
+		e.events = EPOLLIN | EPOLLET;
+		e.data.fd = ctx.evfd[i];
+		ASSERT_EQ(epoll_ctl(ctx.epfd, EPOLL_CTL_ADD, ctx.evfd[i], &e), 0);
+	}
+
+	/* Create waiter threads */
+	for (i = 0; i < ARRAY_SIZE(waiters); i++)
+		ASSERT_EQ(pthread_create(&waiters[i], NULL,
+					 epoll60_wait_thread, &ctx), 0);
+
+	for (i = 0; i < 300; i++) {
+		uint64_t v = 1, ms;
+
+		/* Wait for all to be ready */
+		while (__atomic_load_n(&ctx.ready, __ATOMIC_ACQUIRE) !=
+		       ARRAY_SIZE(ctx.evfd))
+			;
+
+		/* Steady, go */
+		__atomic_fetch_sub(&ctx.ready, ARRAY_SIZE(ctx.evfd),
+				   __ATOMIC_ACQUIRE);
+
+		/* Wait all have gone to kernel */
+		while (count_waiters(&ctx) != ARRAY_SIZE(ctx.evfd))
+			;
+
+		/* 1ms should be enough to schedule away */
+		usleep(1000);
+
+		/* Quickly signal all handles at once */
+		for (n = 0; n < ARRAY_SIZE(ctx.evfd); n++) {
+			ret = write(ctx.evfd[n], &v, sizeof(v));
+			ASSERT_EQ(ret, sizeof(v));
+		}
+
+		/* Busy loop for 1s and wait for all waiters to wake up */
+		ms = msecs();
+		while (count_waiters(&ctx) && msecs() < ms + 1000)
+			;
+
+		ASSERT_EQ(count_waiters(&ctx), 0);
+	}
+	ctx.stopped = 1;
+	/* Stop waiters */
+	for (i = 0; i < ARRAY_SIZE(waiters); i++)
+		ret = pthread_kill(waiters[i], SIGUSR1);
+	for (i = 0; i < ARRAY_SIZE(waiters); i++)
+		pthread_join(waiters[i], NULL);
+
+	for (i = 0; i < ARRAY_SIZE(waiters); i++)
+		close(ctx.evfd[i]);
+	close(ctx.epfd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.24.1

