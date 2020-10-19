Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04182925C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgJSK1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 06:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgJSK1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603103235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+KU3D6CZGkwaGqgOEZ5SUeu//6q1wj8wVndMUn0nkY=;
        b=fMYNV1S2E+UWJTdIlaVYnOpbL6ievqPx7kukFeG2nnWxn02ADcdG6gSMAG5mfRzkMrkpU8
        hrSLzs/UWuopvvk1N+ZSTJ+Jz+X8XQO5R5987Q87hHgAa2qK190Ph2Yeurh1NXfN2+iYdb
        CPziL6IsWIlCJn38H4SazNqA9HwhOhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-_VUznokVMPeyyxFPWoKEuw-1; Mon, 19 Oct 2020 06:27:13 -0400
X-MC-Unique: _VUznokVMPeyyxFPWoKEuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A90F10066FB;
        Mon, 19 Oct 2020 10:27:11 +0000 (UTC)
Received: from lithium.redhat.com (ovpn-115-42.ams2.redhat.com [10.36.115.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0EEC50B44;
        Mon, 19 Oct 2020 10:27:09 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org
Subject: [PATCH v2 2/2] selftests: add tests for CLOSE_RANGE_CLOEXEC
Date:   Mon, 19 Oct 2020 12:26:54 +0200
Message-Id: <20201019102654.16642-3-gscrivan@redhat.com>
In-Reply-To: <20201019102654.16642-1-gscrivan@redhat.com>
References: <20201019102654.16642-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 .../testing/selftests/core/close_range_test.c | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c99b98b0d461..c9db282158bb 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <syscall.h>
 #include <unistd.h>
+#include <sys/resource.h>
 
 #include "../kselftest_harness.h"
 #include "../clone3/clone3_selftests.h"
@@ -23,6 +24,10 @@
 #define CLOSE_RANGE_UNSHARE	(1U << 1)
 #endif
 
+#ifndef CLOSE_RANGE_CLOEXEC
+#define CLOSE_RANGE_CLOEXEC	(1U << 2)
+#endif
+
 static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 				  unsigned int flags)
 {
@@ -224,4 +229,73 @@ TEST(close_range_unshare_capped)
 	EXPECT_EQ(0, WEXITSTATUS(status));
 }
 
+TEST(close_range_cloexec)
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
+				XFAIL(return, "Skipping test since /dev/null does not exist");
+		}
+
+		open_fds[i] = fd;
+	}
+
+	ret = sys_close_range(1000, 1000, CLOSE_RANGE_CLOEXEC);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			XFAIL(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			XFAIL(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC");
+	}
+
+	/* Ensure the FD_CLOEXEC bit is set also with a resource limit in place.  */
+	EXPECT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
+	rlimit.rlim_cur = 25;
+	EXPECT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit));
+
+	/* Set close-on-exec for two ranges: [0-50] and [75-100].  */
+	ret = sys_close_range(open_fds[0], open_fds[50], CLOSE_RANGE_CLOEXEC);
+	EXPECT_EQ(0, ret);
+	ret = sys_close_range(open_fds[75], open_fds[100], CLOSE_RANGE_CLOEXEC);
+	EXPECT_EQ(0, ret);
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
+	ret = sys_close_range(3, UINT_MAX, CLOSE_RANGE_CLOEXEC);
+	for (i = 0; i <= 100; i++) {
+		int flags = fcntl(open_fds[i], F_GETFD);
+
+		EXPECT_GT(flags, -1);
+		EXPECT_EQ(flags & FD_CLOEXEC, FD_CLOEXEC);
+	}
+}
+
+
 TEST_HARNESS_MAIN
-- 
2.26.2

