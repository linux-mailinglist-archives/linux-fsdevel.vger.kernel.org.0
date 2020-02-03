Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7923C15117A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 21:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgBCU73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 15:59:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:47774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgBCU7V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:59:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9E718AD78;
        Mon,  3 Feb 2020 20:59:19 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Max Neunhoeffer <max@arangodb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kselftest: introduce new epoll test case
Date:   Mon,  3 Feb 2020 21:59:07 +0100
Message-Id: <20200203205907.291929-3-rpenyaev@suse.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203205907.291929-1-rpenyaev@suse.de>
References: <20200203205907.291929-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This testcase repeats epollbug.c from the bug:

  https://bugzilla.kernel.org/show_bug.cgi?id=205933

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Max Neunhoeffer <max@arangodb.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Christopher Kohlhoff <chris.kohlhoff@clearpool.io>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../filesystems/epoll/epoll_wakeup_test.c     | 67 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 37a04dab56f0..11eee0b60040 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -7,13 +7,14 @@
 #include <pthread.h>
 #include <sys/epoll.h>
 #include <sys/socket.h>
+#include <sys/eventfd.h>
 #include "../../kselftest_harness.h"
 
 struct epoll_mtcontext
 {
 	int efd[3];
 	int sfd[4];
-	int count;
+	volatile int count;
 
 	pthread_t main;
 	pthread_t waiter;
@@ -3071,4 +3072,68 @@ TEST(epoll58)
 	close(ctx.sfd[3]);
 }
 
+static void *epoll59_thread(void *ctx_)
+{
+	struct epoll_mtcontext *ctx = ctx_;
+	struct epoll_event e;
+	int i;
+
+	for (i = 0; i < 100000; i++) {
+		while (ctx->count == 0)
+			;
+
+		e.events = EPOLLIN | EPOLLERR | EPOLLET;
+		epoll_ctl(ctx->efd[0], EPOLL_CTL_MOD, ctx->sfd[0], &e);
+		ctx->count = 0;
+	}
+
+	return NULL;
+}
+
+/*
+ *        t0
+ *      (p) \
+ *           e0
+ *     (et) /
+ *        e0
+ *
+ * Based on https://bugzilla.kernel.org/show_bug.cgi?id=205933
+ */
+TEST(epoll59)
+{
+	pthread_t emitter;
+	struct pollfd pfd;
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+	int i, ret;
+
+	signal(SIGUSR1, signal_handler);
+
+	ctx.efd[0] = epoll_create1(0);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	ctx.sfd[0] = eventfd(1, 0);
+	ASSERT_GE(ctx.sfd[0], 0);
+
+	e.events = EPOLLIN | EPOLLERR | EPOLLET;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	ASSERT_EQ(pthread_create(&emitter, NULL, epoll59_thread, &ctx), 0);
+
+	for (i = 0; i < 100000; i++) {
+		ret = epoll_wait(ctx.efd[0], &e, 1, 1000);
+		ASSERT_GT(ret, 0);
+
+		while (ctx.count != 0)
+			;
+		ctx.count = 1;
+	}
+	if (pthread_tryjoin_np(emitter, NULL) < 0) {
+		pthread_kill(emitter, SIGUSR1);
+		pthread_join(emitter, NULL);
+	}
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+}
+
 TEST_HARNESS_MAIN
-- 
2.24.1

