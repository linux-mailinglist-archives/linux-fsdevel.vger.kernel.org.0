Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705902BC005
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgKUOoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgKUOoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:44:11 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C853FC061A4A;
        Sat, 21 Nov 2020 06:44:09 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so9453246qtp.2;
        Sat, 21 Nov 2020 06:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8hY/Ql0KC3NjThrNmgRpN1eJ4DPqb/Xthh3vnaFG5Q=;
        b=Y51JVFSBTBEljv9F+YxqarzbZ3wLYPY6lk7oI8oyDzUFfWIk4jSp0V73ggApyTsGc+
         FPhEk4l4mqw7N0ShyeMfd+Ky+k+f/oGNY1B+dCyLJNOHmA2bue/n+ZH4Xj87ogPZWXNU
         SW1MYEncChRiPCg/gx2bpGdghlieJYd9crcFtlXp+2GdaU8YcW3P1RfGYoBbkfkT3+ov
         hK8AaWJv1Et9jp5vstFNTwnfLThVPR+l1g1f6293/Y76CwvJp8Pr3q+8IRYM2D6GVSZ+
         HQw6BbOdZNgpxBVFXMlibkQGRuXXrRhE0GNOjZgPUUJvHoKD3JBs6i4fUmjfSl03eC7w
         7Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8hY/Ql0KC3NjThrNmgRpN1eJ4DPqb/Xthh3vnaFG5Q=;
        b=OZ3GVjkmzt9dy/no0qbTTuSpY6SyRqhWRsxX1jeEXhyg2ok9ooLu9Z9Bw3C//bOlwp
         0IUR7ccoUITVCVFcAyWHa5k8GuKX2XOrdfpiL/cbuhzvkNjaqOKvrp55WTlHREQSTwf1
         MC09jieH2k8gAQeCvJSEz396VKn4PIjTB+i0aidu1rVdS9qio79YEnYI1vt/AYygTjl7
         nCJJRNhWERMBvpDqCAn1S/yuWRdHFkRmGn1nBdUjKnK5Dw/vA/h7bAE7bFEBiZMqmg/J
         4EvG44ChmQTbijz7H2i+JbJtfshvur8DQAZW5/xSicgEJULuLhsjSFuXFIwHsCOAIO9d
         A5DQ==
X-Gm-Message-State: AOAM533wxXDU7XApCB/tDgGGVlwTLbtsmkKsW+xjdNt//f8FKzG7VSFJ
        snZMwzHRXp5b+/uTPeY4TJ4OwernmEU=
X-Google-Smtp-Source: ABdhPJwb5UJ1zyYFxc8niQFhSXfXCY02AiebZG1VCk68dQyf7z4lI+isE+9s2K0ZihUTx51wPbxUAA==
X-Received: by 2002:aed:22c5:: with SMTP id q5mr21141065qtc.234.1605969848777;
        Sat, 21 Nov 2020 06:44:08 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id q15sm4055137qki.13.2020.11.21.06.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 06:44:07 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, soheil.kdev@gmail.com,
        willy@infradead.org, arnd@arndb.de, shuochen@google.com,
        linux-man@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: [PATCH v4 4/4] selftests/filesystems: expand epoll with epoll_pwait2
Date:   Sat, 21 Nov 2020 09:44:00 -0500
Message-Id: <20201121144401.3727659-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201121144401.3727659-1-willemdebruijn.kernel@gmail.com>
References: <20201121144401.3727659-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Code coverage for the epoll_pwait2 syscall.

epoll62: Repeat basic test epoll1, but exercising the new syscall.
epoll63: Pass a timespec and exercise the timeout wakeup path.

Changes
  v4:
  - fix sys_epoll_pwait2 to take __kernel_timespec (Arnd).
  - fix sys_epoll_pwait2 to have sigsetsize arg.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../filesystems/epoll/epoll_wakeup_test.c     | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 8f82f99f7748..ad7fabd575f9 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #define _GNU_SOURCE
+#include <asm/unistd.h>
+#include <linux/time_types.h>
 #include <poll.h>
 #include <unistd.h>
 #include <assert.h>
@@ -21,6 +23,19 @@ struct epoll_mtcontext
 	pthread_t waiter;
 };
 
+#ifndef __NR_epoll_pwait2
+#define __NR_epoll_pwait2 -1
+#endif
+
+static inline int sys_epoll_pwait2(int fd, struct epoll_event *events,
+				   int maxevents,
+				   const struct __kernel_timespec *timeout,
+				   const sigset_t *sigset, size_t sigsetsize)
+{
+	return syscall(__NR_epoll_pwait2, fd, events, maxevents, timeout,
+		       sigset, sigsetsize);
+}
+
 static void signal_handler(int signum)
 {
 }
@@ -3377,4 +3392,61 @@ TEST(epoll61)
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
+	EXPECT_EQ(sys_epoll_pwait2(efd, &e, 1, NULL, NULL, 0), 1);
+	EXPECT_EQ(sys_epoll_pwait2(efd, &e, 1, NULL, NULL, 0), 1);
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
+	struct __kernel_timespec ts;
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
+	EXPECT_EQ(sys_epoll_pwait2(efd, &e, 1, &ts, NULL, 0), 0);
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

