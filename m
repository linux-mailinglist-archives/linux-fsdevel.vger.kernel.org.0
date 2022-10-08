Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3020F5F84C1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 12:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJHKK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJHKJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 06:09:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F82C12771;
        Sat,  8 Oct 2022 03:09:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r17so15904404eja.7;
        Sat, 08 Oct 2022 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCmk/tBVjbF+7TqU0s2kMsuRpHDv0d5bCD7ppPQIYwk=;
        b=UVXS8anx5Txkk3Nd5214wh8p7gjo5jsdHYueAn4jWMlsbhmu+fiQdGu/zIVniLBd+v
         T8h9Tf9TdFWsENBlRm36qgn7LEqn7sE1HRmUesNY7jw7kxe2b+pC94ox5Acd1WA31fgu
         kEI51KQJFAbYArzhsfDBbYSYfu/ct/N5yA7pei6NodqQfu0FSbeJMxs+OwlHaPffiTzG
         MW/9blMi3lu8iVL5UNyQUIY91nDCp1kOuWd+zXMvTqDJ+IMedE7nS9MAc28v3+U0YZTK
         HR4foAlbvM6PmeEOyMHGCR6vJ8Yp3EMyG6gMST+y1PJe5qABubZkiVMdrkaHei8ok7cF
         txnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCmk/tBVjbF+7TqU0s2kMsuRpHDv0d5bCD7ppPQIYwk=;
        b=ezUoJlgT5ue/Ni5P2FbSdnBehlEMPdAVw1ayCjrWILwpAfMj+gQtZ/mgRT1ljHYzIN
         f2NkiUeZleaCczxvZvx0EsL0KOrAbw/FETrOMRZ8QUQsuxwQhI4duMLeWKaA5K86kXxe
         W34yfFK1ZgmS8AhnoMKPtVoFhUBS2FebjFpKaLyEvR/xeU3v797EmoABwK1YDIRKRMpP
         hV+eGCASuTkQ/zvaEisrvVimVzKB5Y/aj4IvBPnn6IsaDRnmxRxuWFNzbMn7hOy4OApM
         PQoCgyaq0dmWtHEUc/0KUUDiQB0vLZFQI1+LAltlwgePG4sMfX3qSBTP4hS2BOGXnz+W
         XS8w==
X-Gm-Message-State: ACrzQf3bL4egfczW1w1StncjkbmHoOrUpbGGQBoq1BvoXP96Xm3mGzdt
        xtP+g+lssKOtEqFYieL/5xlbw7yCozM=
X-Google-Smtp-Source: AMsMyM5VpgQIYbaxJsaccosJ7hbMkRPX6k/GprDHj9BNjkId3oUryZDPtwhASTf6OIKr8ZG2l4DEzA==
X-Received: by 2002:a17:906:6a1a:b0:78c:fa9c:e621 with SMTP id qw26-20020a1709066a1a00b0078cfa9ce621mr7453287ejc.160.1665223785548;
        Sat, 08 Oct 2022 03:09:45 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e9-20020aa7d7c9000000b00452878cba5bsm3092012eds.97.2022.10.08.03.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 03:09:45 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v9 08/11] selftests/landlock: Test FD passing from restricted to unrestricted processes
Date:   Sat,  8 Oct 2022 12:09:34 +0200
Message-Id: <20221008100935.73706-9-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221008100935.73706-1-gnoack3000@gmail.com>
References: <20221008100935.73706-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A file descriptor created in a restricted process carries Landlock
restrictions with it which will apply even if the same opened file is
used from an unrestricted process.

This change extracts suitable FD-passing helpers from base_test.c and
moves them to common.h. We use the fixture variants from the ftruncate
fixture to exercise the same scenarios as in the open_and_ftruncate
test, but doing the Landlock restriction and open() in a different
process than the ftruncate() call.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/base_test.c | 36 +----------
 tools/testing/selftests/landlock/common.h    | 67 ++++++++++++++++++++
 tools/testing/selftests/landlock/fs_test.c   | 62 ++++++++++++++++++
 3 files changed, 132 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 72cdae277b02..792c3f0a59b4 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -263,23 +263,6 @@ TEST(ruleset_fd_transfer)
 		.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
 	};
 	int ruleset_fd_tx, dir_fd;
-	union {
-		/* Aligned ancillary data buffer. */
-		char buf[CMSG_SPACE(sizeof(ruleset_fd_tx))];
-		struct cmsghdr _align;
-	} cmsg_tx = {};
-	char data_tx = '.';
-	struct iovec io = {
-		.iov_base = &data_tx,
-		.iov_len = sizeof(data_tx),
-	};
-	struct msghdr msg = {
-		.msg_iov = &io,
-		.msg_iovlen = 1,
-		.msg_control = &cmsg_tx.buf,
-		.msg_controllen = sizeof(cmsg_tx.buf),
-	};
-	struct cmsghdr *cmsg;
 	int socket_fds[2];
 	pid_t child;
 	int status;
@@ -298,33 +281,20 @@ TEST(ruleset_fd_transfer)
 				    &path_beneath_attr, 0));
 	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
 
-	cmsg = CMSG_FIRSTHDR(&msg);
-	ASSERT_NE(NULL, cmsg);
-	cmsg->cmsg_len = CMSG_LEN(sizeof(ruleset_fd_tx));
-	cmsg->cmsg_level = SOL_SOCKET;
-	cmsg->cmsg_type = SCM_RIGHTS;
-	memcpy(CMSG_DATA(cmsg), &ruleset_fd_tx, sizeof(ruleset_fd_tx));
-
 	/* Sends the ruleset FD over a socketpair and then close it. */
 	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
 				socket_fds));
-	ASSERT_EQ(sizeof(data_tx), sendmsg(socket_fds[0], &msg, 0));
+	ASSERT_EQ(0, send_fd(socket_fds[0], ruleset_fd_tx));
 	ASSERT_EQ(0, close(socket_fds[0]));
 	ASSERT_EQ(0, close(ruleset_fd_tx));
 
 	child = fork();
 	ASSERT_LE(0, child);
 	if (child == 0) {
-		int ruleset_fd_rx;
+		const int ruleset_fd_rx = recv_fd(socket_fds[1]);
 
-		*(char *)msg.msg_iov->iov_base = '\0';
-		ASSERT_EQ(sizeof(data_tx),
-			  recvmsg(socket_fds[1], &msg, MSG_CMSG_CLOEXEC));
-		ASSERT_EQ('.', *(char *)msg.msg_iov->iov_base);
+		ASSERT_LE(0, ruleset_fd_rx);
 		ASSERT_EQ(0, close(socket_fds[1]));
-		cmsg = CMSG_FIRSTHDR(&msg);
-		ASSERT_EQ(cmsg->cmsg_len, CMSG_LEN(sizeof(ruleset_fd_tx)));
-		memcpy(&ruleset_fd_rx, CMSG_DATA(cmsg), sizeof(ruleset_fd_tx));
 
 		/* Enforces the received ruleset on the child. */
 		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 7d34592471db..d7987ae8d7fc 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <linux/landlock.h>
 #include <sys/capability.h>
+#include <sys/socket.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -189,3 +190,69 @@ static void __maybe_unused clear_cap(struct __test_metadata *const _metadata,
 {
 	_effective_cap(_metadata, caps, CAP_CLEAR);
 }
+
+/* Receives an FD from a UNIX socket. Returns the received FD, or -errno. */
+static int __maybe_unused recv_fd(int usock)
+{
+	int fd_rx;
+	union {
+		/* Aligned ancillary data buffer. */
+		char buf[CMSG_SPACE(sizeof(fd_rx))];
+		struct cmsghdr _align;
+	} cmsg_rx = {};
+	char data = '\0';
+	struct iovec io = {
+		.iov_base = &data,
+		.iov_len = sizeof(data),
+	};
+	struct msghdr msg = {
+		.msg_iov = &io,
+		.msg_iovlen = 1,
+		.msg_control = &cmsg_rx.buf,
+		.msg_controllen = sizeof(cmsg_rx.buf),
+	};
+	struct cmsghdr *cmsg;
+	int res;
+
+	res = recvmsg(usock, &msg, MSG_CMSG_CLOEXEC);
+	if (res < 0)
+		return -errno;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (cmsg->cmsg_len != CMSG_LEN(sizeof(fd_rx)))
+		return -EIO;
+
+	memcpy(&fd_rx, CMSG_DATA(cmsg), sizeof(fd_rx));
+	return fd_rx;
+}
+
+/* Sends an FD on a UNIX socket. Returns 0 on success or -errno. */
+static int __maybe_unused send_fd(int usock, int fd_tx)
+{
+	union {
+		/* Aligned ancillary data buffer. */
+		char buf[CMSG_SPACE(sizeof(fd_tx))];
+		struct cmsghdr _align;
+	} cmsg_tx = {};
+	char data_tx = '.';
+	struct iovec io = {
+		.iov_base = &data_tx,
+		.iov_len = sizeof(data_tx),
+	};
+	struct msghdr msg = {
+		.msg_iov = &io,
+		.msg_iovlen = 1,
+		.msg_control = &cmsg_tx.buf,
+		.msg_controllen = sizeof(cmsg_tx.buf),
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+
+	cmsg->cmsg_len = CMSG_LEN(sizeof(fd_tx));
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	memcpy(CMSG_DATA(cmsg), &fd_tx, sizeof(fd_tx));
+
+	if (sendmsg(usock, &msg, 0) < 0)
+		return -errno;
+	return 0;
+}
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 308f6f36e8c0..f8aae01a2409 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3541,6 +3541,68 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	}
 }
 
+TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
+{
+	int child, fd, status;
+	int socket_fds[2];
+
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
+				socket_fds));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		/*
+		 * Enables Landlock in the child process, open a file descriptor
+		 * where truncation is forbidden and send it to the
+		 * non-landlocked parent process.
+		 */
+		const char *const path = file1_s1d1;
+		const struct rule rules[] = {
+			{
+				.path = path,
+				.access = variant->permitted,
+			},
+			{},
+		};
+		int fd, ruleset_fd;
+
+		ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+
+		fd = open(path, O_WRONLY);
+		ASSERT_EQ(variant->expected_open_result, (fd < 0 ? errno : 0));
+
+		if (fd >= 0) {
+			ASSERT_EQ(0, send_fd(socket_fds[0], fd));
+			ASSERT_EQ(0, close(fd));
+		}
+
+		ASSERT_EQ(0, close(socket_fds[0]));
+
+		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		return;
+	}
+
+	if (variant->expected_open_result == 0) {
+		fd = recv_fd(socket_fds[1]);
+		ASSERT_LE(0, fd);
+
+		EXPECT_EQ(variant->expected_ftruncate_result,
+			  test_ftruncate(fd));
+		ASSERT_EQ(0, close(fd));
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	ASSERT_EQ(0, close(socket_fds[0]));
+	ASSERT_EQ(0, close(socket_fds[1]));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.38.0

