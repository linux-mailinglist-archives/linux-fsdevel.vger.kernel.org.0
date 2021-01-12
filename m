Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724012F2409
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhALAdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbhALAbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:31:03 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD0BC061794;
        Mon, 11 Jan 2021 16:30:23 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q1so486161ion.8;
        Mon, 11 Jan 2021 16:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DEYbNHjZWOz6bmEdkUW7JB71u8LtpaVhWTfcACEFps=;
        b=aplyj3S/LR+szlAbiCz+u4zSfrKX+vYOBjErzLa63S+eozb+TFVEgr6a2yEYfKC1sa
         HyAgXbdimI0mYce59reSgOw4n+8NYnFKbwHzV/keS67i7uX9igMONHS7EQQOCvWOxE3f
         QGyIXcyI1pA33zKXnT944xT0x2OnQQT0v7oAETZg00TSET7Q5lBQkgD9GS9Ydwz/YVJQ
         0eJP2N7ZgLtX9XcyHPe1hMv8HyNT7Al0D7Fkltbuj9Ax3hB4he6r3feFBNa5aHCHNO9K
         XtIkqoYRas1sEh50Dx90ir+w5NRNi+9eONji4qGar4fRwn3K4M+353wA3mouLs1QAMyV
         2eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DEYbNHjZWOz6bmEdkUW7JB71u8LtpaVhWTfcACEFps=;
        b=JyeB4HF8QiAtAKUDlITrJh9hQ0mqJjCAw21zT9a0CKQQZ4bu8YDztLnZjfnyRLE6aE
         MUlbLXklMPnMIHTu5bDqXB+DrY/LzAatbVNTr44YYflEjqX9afWHzhXoYFa+JhmiheOZ
         zblNrXTNxJa/PwyZYmSm4dpQFDEBPrCBZKi1RReWYg7j9TwazSg9FuZBysYtfUaSPsPy
         DdjIZ4P/D0toZy7PNzSAe888YQ6cmg5UTiCZgEAcajf5YNlyDhKSyYz6OM1h/keOOeuK
         VijK+QwL/CY5dZogdz9gvJlZKeSOZqVOCvQyGqTfAwb0gQp0WWw9fslVkGsGkuNB4jFY
         xPbA==
X-Gm-Message-State: AOAM531HSFbZUneRGeUbc1GDBr3ALnIBKq9wuH7S2P5UWfn97srknGGK
        K1KecjSatOTh2F36M/K4Jlqj6gk9NC0=
X-Google-Smtp-Source: ABdhPJzol9tuNj0EM+RGeF5Pp/6MJTBlNgwGN/6IP+cUOq3Wok0fmYHYoKz5CXM0W+aB3UWS1NpX1g==
X-Received: by 2002:a5d:9e0a:: with SMTP id h10mr1305223ioh.149.1610411422496;
        Mon, 11 Jan 2021 16:30:22 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id z10sm741723ioi.47.2021.01.11.16.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 16:30:21 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH 1/6] selftests/filesystems: add initial select and poll selftest
Date:   Mon, 11 Jan 2021 19:30:12 -0500
Message-Id: <20210112003017.4010304-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
References: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Add initial code coverage for select, pselect, poll and ppoll.

Open a socketpair and wait for a read event.
1. run with data waiting
2. run to timeout, if a (short) timeout is specified.

Also optionally pass sigset to pselect and ppoll, to exercise
all datapaths. Build with -m32, -mx32 and -m64 to cover all the
various compat and 32/64-bit time syscall implementations.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../selftests/filesystems/selectpoll.c        | 207 ++++++++++++++++++
 3 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/selectpoll.c

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index f0c0ff20d6cf..d4a2e50475ea 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dnotify_test
 devpts_pts
+selectpoll
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 129880fb42d3..8de184865fa4 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -I../../../../usr/include/
-TEST_GEN_PROGS := devpts_pts
+TEST_GEN_PROGS := devpts_pts selectpoll
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/selectpoll.c b/tools/testing/selftests/filesystems/selectpoll.c
new file mode 100644
index 000000000000..315da0786a6c
--- /dev/null
+++ b/tools/testing/selftests/filesystems/selectpoll.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <asm/unistd.h>
+#include <poll.h>
+#include <unistd.h>
+#include <assert.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <sys/select.h>
+#include <sys/socket.h>
+#include "../kselftest_harness.h"
+
+const unsigned long timeout_us = 5UL * 1000;
+const unsigned long timeout_ns = timeout_us * 1000;
+
+/* (p)select: basic invocation, optionally with data waiting */
+
+FIXTURE(select_basic)
+{
+	fd_set readfds;
+	int sfd[2];
+};
+
+FIXTURE_SETUP(select_basic)
+{
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, self->sfd), 0);
+
+	FD_ZERO(&self->readfds);
+	FD_SET(self->sfd[0], &self->readfds);
+	FD_SET(self->sfd[1], &self->readfds);
+}
+
+FIXTURE_TEARDOWN(select_basic)
+{
+	/* FD_ISSET(self->sfd[0] tested in TEST_F: depends on timeout */
+	ASSERT_EQ(FD_ISSET(self->sfd[1], &self->readfds), 0);
+
+	EXPECT_EQ(close(self->sfd[0]), 0);
+	EXPECT_EQ(close(self->sfd[1]), 0);
+}
+
+TEST_F(select_basic, select)
+{
+	ASSERT_EQ(write(self->sfd[1], "w", 1), 1);
+	ASSERT_EQ(select(self->sfd[1] + 1, &self->readfds,
+			 NULL, NULL, NULL), 1);
+	ASSERT_NE(FD_ISSET(self->sfd[0], &self->readfds), 0);
+}
+
+TEST_F(select_basic, select_with_timeout)
+{
+	struct timeval tv = { .tv_usec = timeout_us };
+
+	ASSERT_EQ(write(self->sfd[1], "w", 1), 1);
+	ASSERT_EQ(select(self->sfd[1] + 1, &self->readfds,
+			 NULL, NULL, &tv), 1);
+	ASSERT_GE(tv.tv_usec, 1000);
+	ASSERT_NE(FD_ISSET(self->sfd[0], &self->readfds), 0);
+}
+
+TEST_F(select_basic, select_timeout)
+{
+	struct timeval tv = { .tv_usec = timeout_us };
+
+	ASSERT_EQ(select(self->sfd[1] + 1, &self->readfds,
+			 NULL, NULL, &tv), 0);
+	ASSERT_EQ(FD_ISSET(self->sfd[0], &self->readfds), 0);
+}
+
+TEST_F(select_basic, pselect)
+{
+	ASSERT_EQ(write(self->sfd[1], "w", 1), 1);
+	ASSERT_EQ(pselect(self->sfd[1] + 1, &self->readfds,
+			  NULL, NULL, NULL, NULL), 1);
+	ASSERT_NE(FD_ISSET(self->sfd[0], &self->readfds), 0);
+}
+
+TEST_F(select_basic, pselect_with_timeout)
+{
+	struct timespec ts = { .tv_nsec = timeout_ns };
+
+	ASSERT_EQ(write(self->sfd[1], "w", 1), 1);
+	ASSERT_EQ(pselect(self->sfd[1] + 1, &self->readfds,
+			  NULL, NULL, &ts, NULL), 1);
+	ASSERT_GE(ts.tv_nsec, 1000);
+	ASSERT_NE(FD_ISSET(self->sfd[0], &self->readfds), 0);
+}
+
+TEST_F(select_basic, pselect_timeout)
+{
+	struct timespec ts = { .tv_nsec = timeout_ns };
+
+	ASSERT_EQ(pselect(self->sfd[1] + 1, &self->readfds,
+			  NULL, NULL, &ts, NULL), 0);
+	ASSERT_EQ(FD_ISSET(self->sfd[0], &self->readfds), 0);
+}
+
+TEST_F(select_basic, pselect_sigset_with_timeout)
+{
+	struct timespec ts = { .tv_nsec = timeout_ns };
+	sigset_t sigmask;
+
+	sigemptyset(&sigmask);
+	sigaddset(&sigmask, SIGUSR1);
+	sigprocmask(SIG_SETMASK, &sigmask, NULL);
+	sigemptyset(&sigmask);
+
+	ASSERT_EQ(write(self->sfd[1], "w", 1), 1);
+	ASSERT_EQ(pselect(self->sfd[1] + 1, &self->readfds,
+			  NULL, NULL, &ts, &sigmask), 1);
+	ASSERT_GE(ts.tv_nsec, 1000);
+	ASSERT_NE(FD_ISSET(self->sfd[0], &self->readfds), 0);
+}
+
+/* (p)poll: basic invocation with data waiting */
+
+FIXTURE(poll_basic)
+{
+	struct pollfd pfds[2];
+	int sfd[2];
+};
+
+FIXTURE_SETUP(poll_basic)
+{
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, self->sfd), 0);
+
+	self->pfds[0].events = POLLIN;
+	self->pfds[0].revents = 0;
+	self->pfds[0].fd = self->sfd[0];
+
+	self->pfds[1].events = POLLIN;
+	self->pfds[1].revents = 0;
+	self->pfds[1].fd = self->sfd[1];
+}
+
+FIXTURE_TEARDOWN(poll_basic)
+{
+	/* FD_ISSET(self->pfds[0] tested in TEST_F: depends on timeout */
+	EXPECT_EQ(self->pfds[1].revents & POLLIN, 0);
+
+	EXPECT_EQ(close(self->sfd[0]), 0);
+	EXPECT_EQ(close(self->sfd[1]), 0);
+}
+
+TEST_F(poll_basic, poll)
+{
+	ASSERT_EQ(write(self->sfd[1], "w", 1), 1);
+	EXPECT_EQ(poll(self->pfds, ARRAY_SIZE(self->pfds), 0), 1);
+	EXPECT_EQ(self->pfds[0].revents & POLLIN, POLLIN);
+}
+
+TEST_F(poll_basic, poll_with_timeout)
+{
+	ASSERT_EQ(write(self->sfd[1], "w", 1), 1);
+	EXPECT_EQ(poll(self->pfds, ARRAY_SIZE(self->pfds), 1001), 1);
+	EXPECT_EQ(self->pfds[0].revents & POLLIN, POLLIN);
+}
+
+TEST_F(poll_basic, poll_timeout)
+{
+	EXPECT_EQ(poll(self->pfds, ARRAY_SIZE(self->pfds), 1001), 0);
+	EXPECT_EQ(self->pfds[0].revents & POLLIN, 0);
+}
+
+TEST_F(poll_basic, ppoll)
+{
+	ASSERT_EQ(write(self->sfd[1], "w", 1), 1);
+	EXPECT_EQ(ppoll(self->pfds, ARRAY_SIZE(self->pfds), NULL, NULL), 1);
+	EXPECT_EQ(self->pfds[0].revents & POLLIN, POLLIN);
+}
+
+TEST_F(poll_basic, ppoll_with_timeout)
+{
+	struct timespec ts = { .tv_nsec = timeout_ns };
+
+	ASSERT_EQ(write(self->sfd[1], "w", 1), 1);
+	EXPECT_EQ(ppoll(self->pfds, ARRAY_SIZE(self->pfds), &ts, NULL), 1);
+	ASSERT_GE(ts.tv_nsec, 1000);
+	EXPECT_EQ(self->pfds[0].revents & POLLIN, POLLIN);
+}
+
+TEST_F(poll_basic, ppoll_timeout)
+{
+	struct timespec ts = { .tv_nsec = timeout_ns };
+
+	EXPECT_EQ(ppoll(self->pfds, ARRAY_SIZE(self->pfds), &ts, NULL), 0);
+	EXPECT_EQ(self->pfds[0].revents & POLLIN, 0);
+}
+
+TEST_F(poll_basic, ppoll_sigset_with_timeout)
+{
+	struct timespec ts = { .tv_nsec = timeout_ns };
+	sigset_t sigmask;
+
+	sigemptyset(&sigmask);
+	sigaddset(&sigmask, SIGUSR1);
+	sigprocmask(SIG_SETMASK, &sigmask, NULL);
+	sigemptyset(&sigmask);
+
+	ASSERT_EQ(write(self->sfd[1], "w", 1), 1);
+	EXPECT_EQ(ppoll(self->pfds, ARRAY_SIZE(self->pfds), &ts, &sigmask), 1);
+	ASSERT_GE(ts.tv_nsec, 1000);
+	EXPECT_EQ(self->pfds[0].revents & POLLIN, POLLIN);
+}
+
+TEST_HARNESS_MAIN
-- 
2.30.0.284.gd98b1dd5eaa7-goog

