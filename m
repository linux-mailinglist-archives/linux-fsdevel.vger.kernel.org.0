Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171EC70EE4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 08:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbjEXGmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 02:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbjEXGlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 02:41:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E931BE5;
        Tue, 23 May 2023 23:40:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d28c9696cso149818b3a.1;
        Tue, 23 May 2023 23:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684910377; x=1687502377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+WIcvhrqlufXYpxmz6nVoWyH/V6Y60Y7UdO4BRoheE=;
        b=Imcte6o6viQQvMvdioEUep3oe/Zq4TosClhV5vKqzSers6Dmy6RjKrkRX8kDwMG8Xa
         25v0xLmbpTzzHw8jVUd72zv3m3FqmpiMcmF4W1FkKBaLS4mBuKn+n80eEm1p0wCqPQ7X
         gUmsenLMppH3QCpwfq9h9DGy2ex28CwqfBQRjukgoZxCgEx1V5DE0Xznr4nW0dAvLTk+
         KjKaTa7OZEvEEeNAMzannQWdqa9NCXHopNwPZB12snWHa76LXOqy+RtmfqahrU2HdR1L
         VJl/dVG5463LXbU6zcnZ8Nl0plEopHI9Yf7zujrtb46apUWYx2PVTxosSwpvvaLP4BLw
         4XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910377; x=1687502377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+WIcvhrqlufXYpxmz6nVoWyH/V6Y60Y7UdO4BRoheE=;
        b=DgplAcVD+2VAKrrApLkiJX6gX7zncqNgIFSVKP9Jn/oYKKwDCwU9XdlnExNWaryjph
         ek6bLTfsk6rk2iof7WiaZNb8RxVtPQ/S9hL7ouqo1HMfhTyqsXF2ptc9a/sgocc7ArmK
         HPBDHupeXExs54XQdUWRdaIQ37BPqvS6lO1tJD3N09DariS5WGL9RLRks2fL9VhnWfQI
         RSPMvc3rrgJUf5/WhcmAEznlbdN8AOqhh2wpBWBK36fnhoSkcDb+412yUpB6SWOJTUnl
         5V/GV64KxtjCLAaODEOXtApWkvy/J85DXyNRcXmZu4FIH3hxAIP4H2U8ZsCcTfdHH0l1
         47gw==
X-Gm-Message-State: AC+VfDxh9SF/PMz/MNqImLNBORjkgXXjCnNhorLb1+/MYlhGIhwh5hxa
        92jJkoe1is7ylj6/q7PqpSE=
X-Google-Smtp-Source: ACHHUZ6Gg1ZGzHtzXt884mfxqt9thsoEO6s87KwM1rYKxzHzO3/L5zzCVgCvQtBSeSZ5onw0h5FGsw==
X-Received: by 2002:a05:6a00:99d:b0:64d:41f1:7c87 with SMTP id u29-20020a056a00099d00b0064d41f17c87mr1963666pfg.2.1684910376483;
        Tue, 23 May 2023 23:39:36 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b006437c0edf9csm6972703pfo.16.2023.05.23.23.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:39:36 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, willy@infradead.org, brauner@kernel.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org, tycho@tycho.pizza,
        aloktiagi@gmail.com
Subject: [RFC v7 2/2] seccomp: replace existing file in the epoll interface by a new file injected by the syscall supervisor.
Date:   Wed, 24 May 2023 06:39:33 +0000
Message-Id: <20230524063933.2339105-2-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524063933.2339105-1-aloktiagi@gmail.com>
References: <20230524063933.2339105-1-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a mechanism to replace a file linked in the epoll interface by a new
file injected by the syscall supervisor by using the epoll provided
eventpoll_replace_file() api.

Also introduce a new addfd flag SECCOMP_ADDFD_FLAG_REPLACE_REF to allow the supervisor
to indicate that it is interested in getting the original file replaced by the
new injected file.

We have a use case where multiple IPv6 only network namespaces can use a single
IPv4 network namespace for IPv4 only egress connectivity by switching their
sockets from IPv6 to IPv4 network namespace. This allows for migration of
systems to IPv6 only while keeping their connectivity to IPv4 only destinations
intact.

Today, we achieve this by setting up seccomp filter to intercept network system
calls like connect() from a container in a syscall supervisor which runs in an
IPv4 only network namespace. The syscall supervisor creates a new IPv4 connection
and injects the new file descriptor through SECCOMP_NOTIFY_IOCTL_ADDFD replacing
the original file descriptor from the connect() call. This does not work for
cases where the original file descriptor is handed off to a system like epoll
before the connect() call. After a new file descriptor is injected the original
file descriptor being referenced by the epoll fd is not longer valid leading to
failures. As a workaround the syscall supervisor when intercepting connect()
loops through all open socket file descriptors to check if they are referencing
the socket attempting the connect() and replace the reference with the to be
injected file descriptor. This workaround is cumbersome and makes the solution
prone to similar yet to be discovered issues.

The above change will enable us remove the workaround in the syscall supervisor
and let the kernel handle the replacement correctly.

Signed-off-by: aloktiagi <aloktiagi@gmail.com>
---
 include/uapi/linux/seccomp.h                  |   1 +
 kernel/seccomp.c                              |  35 +++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 102 ++++++++++++++++++
 3 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 0fdc6ef02b94..0a74dc5d967f 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -118,6 +118,7 @@ struct seccomp_notif_resp {
 /* valid flags for seccomp_notif_addfd */
 #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
 #define SECCOMP_ADDFD_FLAG_SEND		(1UL << 1) /* Addfd and return it, atomically */
+#define SECCOMP_ADDFD_FLAG_REPLACE_REF	(1UL << 2) /* Update replace references */
 
 /**
  * struct seccomp_notif_addfd
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d3e584065c7f..e4784b70b9e5 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -19,6 +19,7 @@
 #include <linux/audit.h>
 #include <linux/compat.h>
 #include <linux/coredump.h>
+#include <linux/eventpoll.h>
 #include <linux/kmemleak.h>
 #include <linux/nospec.h>
 #include <linux/prctl.h>
@@ -1056,6 +1057,7 @@ static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
 static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_knotif *n)
 {
 	int fd;
+	struct file *old_file = NULL;
 
 	/*
 	 * Remove the notification, and reset the list pointers, indicating
@@ -1064,8 +1066,30 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
 	list_del_init(&addfd->list);
 	if (!addfd->setfd)
 		fd = receive_fd(addfd->file, addfd->flags);
-	else
+	else {
+		int ret = 0;
+		if (addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_REPLACE_REF) {
+			old_file = fget(addfd->fd);
+			if (!old_file) {
+				fd = -EBADF;
+				goto error;
+			}
+			ret = eventpoll_replace_file(old_file, addfd->file, addfd->fd);
+			if (ret < 0) {
+				fd = ret;
+				goto error;
+			}
+		}
 		fd = receive_fd_replace(addfd->fd, addfd->file, addfd->flags);
+		/* In case of error restore all references */
+		if (fd < 0 && addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_REPLACE_REF) {
+			ret = eventpoll_replace_file(addfd->file, old_file, addfd->fd);
+			if (ret < 0) {
+				fd = ret;
+			}
+		}
+	}
+error:
 	addfd->ret = fd;
 
 	if (addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_SEND) {
@@ -1080,6 +1104,9 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
 		}
 	}
 
+	if (old_file)
+		fput(old_file);
+
 	/*
 	 * Mark the notification as completed. From this point, addfd mem
 	 * might be invalidated and we can't safely read it anymore.
@@ -1613,12 +1640,16 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 	if (addfd.newfd_flags & ~O_CLOEXEC)
 		return -EINVAL;
 
-	if (addfd.flags & ~(SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_SEND))
+	if (addfd.flags & ~(SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_SEND |
+			    SECCOMP_ADDFD_FLAG_REPLACE_REF))
 		return -EINVAL;
 
 	if (addfd.newfd && !(addfd.flags & SECCOMP_ADDFD_FLAG_SETFD))
 		return -EINVAL;
 
+	if (!addfd.newfd && (addfd.flags & SECCOMP_ADDFD_FLAG_REPLACE_REF))
+		return -EINVAL;
+
 	kaddfd.file = fget(addfd.srcfd);
 	if (!kaddfd.file)
 		return -EBADF;
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 43ec36b179dc..0ec8e4f9dff6 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -47,6 +47,7 @@
 #include <linux/kcmp.h>
 #include <sys/resource.h>
 #include <sys/capability.h>
+#include <sys/epoll.h>
 
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -4185,6 +4186,107 @@ TEST(user_notification_addfd)
 	close(memfd);
 }
 
+TEST(user_notification_addfd_with_epoll_replace)
+{
+	char c;
+	pid_t pid;
+	long ret;
+	int optval;
+	socklen_t optlen = sizeof(optval);
+	int status, listener, fd;
+	int efd, sfd[4];
+	struct epoll_event e;
+	struct seccomp_notif_addfd addfd = {};
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_notif_syscall(__NR_getsockopt,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+
+	/* Create two socket pairs sfd[0] <-> sfd[1] and sfd[2] <-> sfd[3] */
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		if (socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]) != 0)
+			exit(1);
+
+		efd = epoll_create(1);
+		if (efd == -1)
+			exit(1);
+
+		e.events = EPOLLIN;
+		if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e) != 0)
+			exit(1);
+
+		/*
+		 * fd will be added here to replace an existing one linked
+		 * in the epoll interface.
+		 */
+		if (getsockopt(sfd[0], SOL_SOCKET, SO_DOMAIN, &optval,
+		       &optlen) != USER_NOTIF_MAGIC)
+			exit(1);
+
+		/*
+		 * Write data to the sfd[3] connected to sfd[2], but due to
+		 * the swap, we should see data on sfd[0]
+		 */
+		if (write(sfd[3], "w", 1) != 1)
+			exit(1);
+
+		if (epoll_wait(efd, &e, 1, 0) != 1)
+			exit(1);
+
+		if (read(sfd[0], &c, 1) != 1)
+			exit(1);
+
+		if ('w' != c)
+			exit(1);
+
+		if (epoll_ctl(efd, EPOLL_CTL_DEL, sfd[0], &e) != 0)
+			exit(1);
+
+		close(efd);
+		close(sfd[0]);
+		close(sfd[1]);
+		close(sfd[2]);
+		close(sfd[3]);
+		exit(0);
+	}
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+	addfd.srcfd = sfd[2];
+	addfd.newfd = req.data.args[0];
+	addfd.id = req.id;
+	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_REPLACE_REF;
+	addfd.newfd_flags = O_CLOEXEC;
+
+	/*
+	 * Verfiy we can install and replace a file that is linked in the
+	 * epoll interface. Replace the socket sfd[0] with sfd[2]
+	 */
+	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+	EXPECT_EQ(fd, req.data.args[0]);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	/* Wait for child to finish. */
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
 TEST(user_notification_addfd_rlimit)
 {
 	pid_t pid;
-- 
2.34.1

