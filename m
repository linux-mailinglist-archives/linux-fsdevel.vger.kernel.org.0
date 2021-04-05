Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A69354920
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 01:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbhDEXKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 19:10:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:38366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235683AbhDEXKm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:10:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4218CB148;
        Mon,  5 Apr 2021 23:10:35 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, rpenyaev@suse.de, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] kselftest: introduce new epoll test case
Date:   Mon,  5 Apr 2021 16:10:24 -0700
Message-Id: <20210405231025.33829-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210405231025.33829-1-dave@stgolabs.net>
References: <20210405231025.33829-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This incorporates the testcase originally reported in:

     https://bugzilla.kernel.org/show_bug.cgi?id=208943

Which ensures an event is reported to all threads blocked on the
same epoll descriptor, otherwise only a single thread will receive
the wakeup once the event become ready.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 .../filesystems/epoll/epoll_wakeup_test.c     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index ad7fabd575f9..65ede506305c 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -3449,4 +3449,48 @@ TEST(epoll63)
 	close(sfd[1]);
 }
 
+/*
+ *        t0    t1
+ *     (ew) \  / (ew)
+ *           e0
+ *            | (lt)
+ *           s0
+ */
+TEST(epoll64)
+{
+	pthread_t waiter[2];
+	struct epoll_event e;
+	struct epoll_mtcontext ctx = { 0 };
+
+	signal(SIGUSR1, signal_handler);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, ctx.sfd), 0);
+
+	ctx.efd[0] = epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.sfd[0], &e), 0);
+
+	/*
+	 * main will act as the emitter once both waiter threads are
+	 * blocked and expects to both be awoken upon the ready event.
+	 */
+	ctx.main = pthread_self();
+	ASSERT_EQ(pthread_create(&waiter[0], NULL, waiter_entry1a, &ctx), 0);
+	ASSERT_EQ(pthread_create(&waiter[1], NULL, waiter_entry1a, &ctx), 0);
+
+	usleep(100000);
+	ASSERT_EQ(write(ctx.sfd[1], "w", 1), 1);
+
+	ASSERT_EQ(pthread_join(waiter[0], NULL), 0);
+	ASSERT_EQ(pthread_join(waiter[1], NULL), 0);
+
+	EXPECT_EQ(ctx.count, 2);
+
+	close(ctx.efd[0]);
+	close(ctx.sfd[0]);
+	close(ctx.sfd[1]);
+}
+
 TEST_HARNESS_MAIN
-- 
2.26.2

