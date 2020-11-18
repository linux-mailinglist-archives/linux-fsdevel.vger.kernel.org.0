Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD92B7FB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 15:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgKROqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 09:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgKROq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:46:26 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37654C0613D4;
        Wed, 18 Nov 2020 06:46:26 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so1742665qtp.7;
        Wed, 18 Nov 2020 06:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpJw+6GQDkHrI+U7oYKu3KUyHi+2aDVppoVqit5UpRE=;
        b=CbTSGd8Fc28xIGZDo2GxItE8kcIhTi6mo253AyBAM094s2tNuh1F686SiwMLyXzDyI
         1dAKY9kHtX4rXFt8lhxibN9n1Qed5hFw6LrvWnfTkUj5ZS/lNgRf3/r8KUcg8VjuUFCt
         atYFtVTVRFiNPcuZWFDSh6K2oweaIj3K30IPQPH1Qqwr0FPm/p4adZwdd2zrRE5jZ14G
         Ei6veZ77ySi1vEsn2WBhUm3afHIIU3NCkAWnj6d4Ab/ZJ9Xi9W3JgsRyOIp72dNt7NqC
         jMtPywkLxQwBRt2/6wZXHKKQL0A7bHolT/dZFDWYvRj+BA0NVtRPwcanOntbCdk3frqe
         eqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpJw+6GQDkHrI+U7oYKu3KUyHi+2aDVppoVqit5UpRE=;
        b=jL8/iThyLCj6VGz5HwGDJEQPgsA3NiZUGAzqvIrmeGVXccB+ttbOWThc444LszLuUr
         T08Ab4FLy6x9lTvw6A/S0zg9bkcGQjzGJNFh2fEr5EvNzT6AQ4Z0PBCKop1UNX/ZjxD8
         0ZeXhQzEiFOgzVQDDCVMIuqBU1GK6bh0S/MBDXnwygjOeF93VBpjrG1efX2lkDp0gH/x
         pV/PqRmtgd/AsHL0hKYZWHiEK7Uutt/366Unv+P8ujXRp6XLH7qxXgYfUHka1SBQSny4
         HgEvtOng9wMjzapV1gIoVV+D2S0q58OFfFSKd4cKT8eOr40zY48RxmguBA3QFLsUQGFG
         6xuw==
X-Gm-Message-State: AOAM531eYmjZe+oJM8f4Te/FuKWrhjJ5ILRqob5QN30opE5YOASt7eXm
        //ftnk1wJjKryqqsvh75sn1sH1ITI0c=
X-Google-Smtp-Source: ABdhPJzaRKlLVWmU7nYmuhhnkbEeGnVEa8Xy5qPoVhS5k1IEm7WKFpZN614rM9JJjd4LuvrDqmlQMQ==
X-Received: by 2002:ac8:6c28:: with SMTP id k8mr4266052qtu.316.1605710784994;
        Wed, 18 Nov 2020 06:46:24 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id k188sm4910810qkd.98.2020.11.18.06.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:46:24 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, soheil.kdev@gmail.com, arnd@arndb.de,
        shuochen@google.com, linux-man@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH v3 2/2] selftests/filesystems: expand epoll with epoll_pwait2
Date:   Wed, 18 Nov 2020 09:46:17 -0500
Message-Id: <20201118144617.986860-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Code coverage for the epoll_pwait2 syscall.

epoll62: Repeat basic test epoll1, but exercising the new syscall.
epoll63: Pass a timespec and exercise the timeout wakeup path.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../filesystems/epoll/epoll_wakeup_test.c     | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 8f82f99f7748..4d5656978746 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #define _GNU_SOURCE
+#include <asm/unistd.h>
 #include <poll.h>
 #include <unistd.h>
 #include <assert.h>
@@ -21,6 +22,18 @@ struct epoll_mtcontext
 	pthread_t waiter;
 };
 
+#ifndef __NR_epoll_pwait2
+#define __NR_epoll_pwait2 -1
+#endif
+
+static inline int sys_epoll_pwait2(int fd, struct epoll_event *events,
+				   int maxevents,
+				   const struct timespec *timeout,
+				   const sigset_t *sigset)
+{
+	return syscall(__NR_epoll_pwait2, fd, events, maxevents, timeout, sigset);
+}
+
 static void signal_handler(int signum)
 {
 }
@@ -3377,4 +3390,61 @@ TEST(epoll61)
 	close(ctx.evfd);
 }
 
+/* Equivalent to basic test epoll1, but exercising epoll_pwait2. */
+TEST(epoll62)
+{
+	int efd;
+	int sfd[2];
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd = epoll_create(1);
+	ASSERT_GE(efd, 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	ASSERT_EQ(write(sfd[1], "w", 1), 1);
+
+	EXPECT_EQ(sys_epoll_pwait2(efd, &e, 1, NULL, NULL), 1);
+	EXPECT_EQ(sys_epoll_pwait2(efd, &e, 1, NULL, NULL), 1);
+
+	close(efd);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
+/* Epoll_pwait2 basic timeout test. */
+TEST(epoll63)
+{
+	const int cfg_delay_ms = 10;
+	unsigned long long tdiff;
+	struct timespec ts;
+	int efd;
+	int sfd[2];
+	struct epoll_event e;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sfd), 0);
+
+	efd = epoll_create(1);
+	ASSERT_GE(efd, 0);
+
+	e.events = EPOLLIN;
+	ASSERT_EQ(epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e), 0);
+
+	ts.tv_sec = 0;
+	ts.tv_nsec = cfg_delay_ms * 1000 * 1000;
+
+	tdiff = msecs();
+	EXPECT_EQ(sys_epoll_pwait2(efd, &e, 1, &ts, NULL), 0);
+	tdiff = msecs() - tdiff;
+
+	EXPECT_GE(tdiff, cfg_delay_ms);
+
+	close(efd);
+	close(sfd[0]);
+	close(sfd[1]);
+}
+
 TEST_HARNESS_MAIN
-- 
2.29.2.454.gaff20da3a2-goog

