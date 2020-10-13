Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B2B28CFCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 16:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbgJMOG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 10:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388275AbgJMOG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602597987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2c0z0nnK5G/Cjc6T69QlHdgqzKaRCEYH2YcGXaZfvs=;
        b=P4FirxbJIc9tN/z5XTum55FtDyvH/H098hpw1W3TAhbZ4IhJJWnqLpqaFiv+Ts8Ecv5NI2
        jPX4F0VzHPYqjs9dWGLgY2/E/BMtHGW+1WlvihbhpmK94k/9MzgOpzbMeTPIr/mjO1h3IB
        uOQsomr4oEOWrCZzvIpiWQWGo3a7tYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-BqIk-o_9Ps67-_bglI0HLw-1; Tue, 13 Oct 2020 10:06:25 -0400
X-MC-Unique: BqIk-o_9Ps67-_bglI0HLw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC27E1020905;
        Tue, 13 Oct 2020 14:06:23 +0000 (UTC)
Received: from lithium.redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B9655C1C2;
        Tue, 13 Oct 2020 14:06:22 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        christian.brauner@ubuntu.com, containers@lists.linux-foundation.org
Subject: [PATCH 2/2] selftests: add tests for CLOSE_RANGE_CLOEXEC
Date:   Tue, 13 Oct 2020 16:06:09 +0200
Message-Id: <20201013140609.2269319-3-gscrivan@redhat.com>
In-Reply-To: <20201013140609.2269319-1-gscrivan@redhat.com>
References: <20201013140609.2269319-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 .../testing/selftests/core/close_range_test.c | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c99b98b0d461..b8789262cd7d 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -23,6 +23,10 @@
 #define CLOSE_RANGE_UNSHARE	(1U << 1)
 #endif
 
+#ifndef CLOSE_RANGE_CLOEXEC
+#define CLOSE_RANGE_CLOEXEC	(1U << 2)
+#endif
+
 static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 				  unsigned int flags)
 {
@@ -224,4 +228,44 @@ TEST(close_range_unshare_capped)
 	EXPECT_EQ(0, WEXITSTATUS(status));
 }
 
+TEST(close_range_cloexec)
+{
+	int i, ret;
+	int open_fds[101];
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
+	EXPECT_EQ(-1, sys_close_range(open_fds[0], open_fds[100], -1)) {
+		if (errno == ENOSYS)
+			XFAIL(return, "close_range() syscall not supported");
+	}
+
+	EXPECT_EQ(0, sys_close_range(open_fds[0], open_fds[50], CLOSE_RANGE_CLOEXEC));
+
+	for (i = 0; i <= 50; i++) {
+		int flags = fcntl(open_fds[i], F_GETFD);
+
+		EXPECT_GT(flags, -1);
+		EXPECT_EQ(flags & FD_CLOEXEC, FD_CLOEXEC);
+	}
+
+	for (i = 51; i <= 100; i++) {
+		int flags = fcntl(open_fds[i], F_GETFD);
+
+		EXPECT_GT(flags, -1);
+		EXPECT_EQ(flags & FD_CLOEXEC, 0);
+	}
+}
+
+
 TEST_HARNESS_MAIN
-- 
2.26.2

