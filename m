Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B505F1D54
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 17:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJAPu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 11:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiJAPts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:49:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2520DCF1;
        Sat,  1 Oct 2022 08:49:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a26so14598520ejc.4;
        Sat, 01 Oct 2022 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ksl9oRrVxE9WFLEuN9a1pJr4ZEPnx6o5UXr/oO09dAA=;
        b=OLxO8MkxtkWu6dV/MpS4uZm5aRe4hi6QKBbQnKq049jz00XxymhtWPNp8OH4dHSehF
         QLKzGLtyLGedORM2/nEmfqMOUGfZ0uxTyQP7GkqM3ZH/UygME84xfItunL/IdgtWOnCw
         zPIfd7yBHgtT+Nlg8TDTO6tum7UDKAVFANgDGxiyyf1t6SkphDu2QKCsT2LEqX33dmDi
         mAJb0M5le3Mr+65ytUkvSuDg7ITF+HeYwGMqFRMZ8kWF1C/1EJKop8QdIHnFlIWTmPdf
         chNkYOfvhcXkSVMLaC+ri+UTQ8z+oZyBfiSCecmDZQfUv2DdGrUL3wVzuFT+3BoyU08d
         TSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ksl9oRrVxE9WFLEuN9a1pJr4ZEPnx6o5UXr/oO09dAA=;
        b=3hewsBDKFUFtJ2iwKXw+9hgbof+FxUhc8WvnAZE0HluHAPJZysK3Znks/npoUq3g0v
         qnE6qp1XCbDLGWbIXOhOSOvKKVBDMuYyiIKL1QWPb1rTitmz7sw8M882aZ1aUGWiBobn
         mSuwyla+jER3RrWaGkJPqEpINWWsW1DFTRQsedg6B0C3ZSFA9CrLEKV1XRKSfTKZ8/59
         xDitH+qOWUaLE3mXDnpxnoWwQX60+KbCdGpI5N8Qw41v0lxG/oHG135wiPD1njblZwtd
         kIg1+PyKXS+9yKYlRa15r6LgAvFEmtJjTQkrNa5x9N8OX4nkRSWVO2X/9/v2JF8/ZGE+
         hu8g==
X-Gm-Message-State: ACrzQf2kUl/3ySr2XysIB3BOCuDd4q2VEuWUrTs60iQAbBNb5uL5iKC0
        ExASvRSskX8Dn54Z1H3sNAfjTESrz7o=
X-Google-Smtp-Source: AMsMyM5b7LYsMTywVS1eMt6eBLmRSfFdEZj59G2ET2NqKyZnoDvGlPdExE74NMGcVEFPV1SR8s9r3g==
X-Received: by 2002:a17:907:a079:b0:77b:8d9:9d9 with SMTP id ia25-20020a170907a07900b0077b08d909d9mr9515362ejc.697.1664639380615;
        Sat, 01 Oct 2022 08:49:40 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7d69a000000b00458cc5f802asm617151edr.73.2022.10.01.08.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 08:49:39 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v8 7/9] selftests/landlock: Test FD passing from a Landlock-restricted to an unrestricted process
Date:   Sat,  1 Oct 2022 17:49:06 +0200
Message-Id: <20221001154908.49665-8-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001154908.49665-1-gnoack3000@gmail.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
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
index 72cdae277b02..6d1b6eedb432 100644
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
+		int ruleset_fd_rx = recv_fd(socket_fds[1]);
 
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
index 7d34592471db..15149d34e43b 100644
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
+/* Receives an FD from a UNIX socket. Returns the received FD, -1 on error. */
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
+		return -1;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (cmsg->cmsg_len != CMSG_LEN(sizeof(fd_rx)))
+		return -1;
+
+	memcpy(&fd_rx, CMSG_DATA(cmsg), sizeof(fd_rx));
+	return fd_rx;
+}
+
+/* Sends an FD on a UNIX socket. Returns 0 on success or -1 on error. */
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
+		return -1;
+	return 0;
+}
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 308f6f36e8c0..93ed80a25a74 100644
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
+		 * Enable Landlock in the child process, open a file descriptor
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
+		/* Enable Landlock. */
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
2.37.3

