Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BE270D46A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjEWG6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 02:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjEWG6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 02:58:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A31133;
        Mon, 22 May 2023 23:58:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae4048627aso5172315ad.0;
        Mon, 22 May 2023 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684825088; x=1687417088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+WIcvhrqlufXYpxmz6nVoWyH/V6Y60Y7UdO4BRoheE=;
        b=np11PijIe6/1E8zaM9kkKFmFOLP7KoM0lYhATsntntEfQW9L+ryPJYnOACZ8ZWGvZ8
         FeWsXPDeMg+hJJvNgUP4A0jpo0DGGLvooS392XURs0IuEJoBlsjVZSeVBacPG2Rwe4LR
         6mmqdO0spNx2hjHBpLw2ku56C0c47EITn4oM65qgMWEmmAhzVJUo65s7a3boHxxrdDfM
         N8X5ND4IK/cYDmlpUHqCqr2fvSo4bdXYnGPWpqUmXdht0EiNgq21Yo8nV7QCtqrP7h0L
         EWvVa6d8kR3wI+PTVlRoIBffFNqjgtz15wtzcLiDTefsm8kcdE2HSEDzYjmRjGXzPLj5
         575Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684825088; x=1687417088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+WIcvhrqlufXYpxmz6nVoWyH/V6Y60Y7UdO4BRoheE=;
        b=Z3ah0PWXlIJhDrDel+uQSHefQ1cqREJL8Yqxe7O7IKJUSdj4IMBxu6fdZmKsXh+WB/
         9sIrZr9NN7K5S+1Unt0itrmVK+HcEgy5BvyGfkv2a7pdJVdCG7s0lYD3abVamU2AFn/D
         hjQAMhQ/ETNhPh/tDnqkCbDRrDzxP24Svj1F2jboZmfHqMYOeixv5JtGw7hdXMKC7Bej
         th1UaC7HPwK9mc1d/WGjZKsQYzVKuAKlVonR7OKeAKt7tlgXtu9FV8xM7fpL3Ws02iXV
         uBFodrNSOaR/S+SYHsPgMkYGKuRtULZxxBRyQjAXoafgDyeFqm2uDgVpaqiKWrPAoAQG
         6ObA==
X-Gm-Message-State: AC+VfDwaeu+3h74grvVrGajDn7znJZjHpnJomtHuLN+bXVdx+tSdG52h
        T4E3aflTddkIw2qczJk3mlc=
X-Google-Smtp-Source: ACHHUZ7n++tA5X7dagtyHFAUPD+y8RFyeIAHij14p1CeLKqfexcz0k9zszB0b4qjrG9BNe3mWKXewQ==
X-Received: by 2002:a17:902:daca:b0:1ad:eada:598b with SMTP id q10-20020a170902daca00b001adeada598bmr14938583plx.3.1684825088318;
        Mon, 22 May 2023 23:58:08 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090282c600b001ac912cac1asm5945593plz.175.2023.05.22.23.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 23:58:08 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, willy@infradead.org, brauner@kernel.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org, tycho@tycho.pizza,
        aloktiagi@gmail.com
Subject: [RFC v6 2/2] seccomp: replace existing file in the epoll interface by a new file injected by the syscall supervisor.
Date:   Tue, 23 May 2023 06:58:02 +0000
Message-Id: <20230523065802.2253926-2-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523065802.2253926-1-aloktiagi@gmail.com>
References: <20230523065802.2253926-1-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

