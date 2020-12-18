Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36742DE52F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgLROzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 09:55:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34476 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgLROzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:55:22 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kqH9U-0006v9-KN; Fri, 18 Dec 2020 14:54:40 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/4] selftests/core: add test for CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC
Date:   Fri, 18 Dec 2020 15:54:14 +0100
Message-Id: <20201218145415.801063-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <https://lore.kernel.org/linux-fsdevel/20201217213303.722643-1-christian.brauner@ubuntu.com>
References: <https://lore.kernel.org/linux-fsdevel/20201217213303.722643-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a test to verify that CLOSE_RANGE_UNSHARE works correctly when combined
with CLOSE_RANGE_CLOEXEC for the single-threaded case.

Cc: Giuseppe Scrivano <gscrivan@redhat.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 .../testing/selftests/core/close_range_test.c | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index bc592a1372bb..862444f1c244 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -313,5 +313,75 @@ TEST(close_range_cloexec)
 	}
 }
 
+TEST(close_range_cloexec_unshare)
+{
+	int i, ret;
+	int open_fds[101];
+	struct rlimit rlimit;
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		fd = open("/dev/null", O_RDONLY);
+		ASSERT_GE(fd, 0) {
+			if (errno == ENOENT)
+				SKIP(return, "Skipping test since /dev/null does not exist");
+		}
+
+		open_fds[i] = fd;
+	}
+
+	ret = sys_close_range(1000, 1000, CLOSE_RANGE_CLOEXEC);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC");
+	}
+
+	/* Ensure the FD_CLOEXEC bit is set also with a resource limit in place.  */
+	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
+	rlimit.rlim_cur = 25;
+	ASSERT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit));
+
+	/* Set close-on-exec for two ranges: [0-50] and [75-100].  */
+	ret = sys_close_range(open_fds[0], open_fds[50],
+			      CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_UNSHARE);
+	ASSERT_EQ(0, ret);
+	ret = sys_close_range(open_fds[75], open_fds[100],
+			      CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_UNSHARE);
+	ASSERT_EQ(0, ret);
+
+	for (i = 0; i <= 50; i++) {
+		int flags = fcntl(open_fds[i], F_GETFD);
+
+		EXPECT_GT(flags, -1);
+		EXPECT_EQ(flags & FD_CLOEXEC, FD_CLOEXEC);
+	}
+
+	for (i = 51; i <= 74; i++) {
+		int flags = fcntl(open_fds[i], F_GETFD);
+
+		EXPECT_GT(flags, -1);
+		EXPECT_EQ(flags & FD_CLOEXEC, 0);
+	}
+
+	for (i = 75; i <= 100; i++) {
+		int flags = fcntl(open_fds[i], F_GETFD);
+
+		EXPECT_GT(flags, -1);
+		EXPECT_EQ(flags & FD_CLOEXEC, FD_CLOEXEC);
+	}
+
+	/* Test a common pattern.  */
+	ret = sys_close_range(3, UINT_MAX,
+			      CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_UNSHARE);
+	for (i = 0; i <= 100; i++) {
+		int flags = fcntl(open_fds[i], F_GETFD);
+
+		EXPECT_GT(flags, -1);
+		EXPECT_EQ(flags & FD_CLOEXEC, FD_CLOEXEC);
+	}
+}
 
 TEST_HARNESS_MAIN
-- 
2.29.2

