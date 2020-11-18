Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67202B7BB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 11:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgKRKsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 05:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727784AbgKRKsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605696482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gm3OBX/9hJtnlJ3YS7mlFXt8HRp4QEhmJQZCJ3PsAxw=;
        b=BWdd263oFYXxf+q/aSW3o/kTah6qocM82CTp3KC3+itOGXyZIx14dfNFesFMzOfcOIIQ+W
        H/pf0uWPTCiaiIFx9BdCXvvu2NFjDsF6mtkXMFbJhIPmvFFDpq7yirT/xKl7n2gM1vQ6+A
        +bx5X2s/oYJzWBEhb+s5/7ZpxczmN7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-g-JpIBSuNo-C3Y6xwHJx0w-1; Wed, 18 Nov 2020 05:47:58 -0500
X-MC-Unique: g-JpIBSuNo-C3Y6xwHJx0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FBC686ABD9;
        Wed, 18 Nov 2020 10:47:57 +0000 (UTC)
Received: from lithium.redhat.com (ovpn-113-143.ams2.redhat.com [10.36.113.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6503060C05;
        Wed, 18 Nov 2020 10:47:55 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com
Cc:     linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: [PATCH v3 2/2] selftests: core: add tests for CLOSE_RANGE_CLOEXEC
Date:   Wed, 18 Nov 2020 11:47:46 +0100
Message-Id: <20201118104746.873084-3-gscrivan@redhat.com>
In-Reply-To: <20201118104746.873084-1-gscrivan@redhat.com>
References: <20201118104746.873084-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

check that close_range(initial_fd, last_fd, CLOSE_RANGE_CLOEXEC)
correctly sets the close-on-exec bit for the specified file
descriptors.

Open 100 file descriptors and set the close-on-exec flag for a subset
of them first, then set it for every file descriptor above 2.  Make
sure RLIMIT_NOFILE doesn't affect the result.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 .../testing/selftests/core/close_range_test.c | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c99b98b0d461..18992c383852 100644
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
+	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
+	rlimit.rlim_cur = 25;
+	ASSERT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit));
+
+	/* Set close-on-exec for two ranges: [0-50] and [75-100].  */
+	ret = sys_close_range(open_fds[0], open_fds[50], CLOSE_RANGE_CLOEXEC);
+	ASSERT_EQ(0, ret);
+	ret = sys_close_range(open_fds[75], open_fds[100], CLOSE_RANGE_CLOEXEC);
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
2.28.0

