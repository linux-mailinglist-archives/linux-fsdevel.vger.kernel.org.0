Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8CF6C7805
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 07:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCXGfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 02:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCXGe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:34:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036A128EBD;
        Thu, 23 Mar 2023 23:34:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-62810466cccso1570b3a.1;
        Thu, 23 Mar 2023 23:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679639681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UHxirEYHrGb2qE5WPMytj2srWdUEgiXO6PyInqvMe4=;
        b=WI0KaY0dcvuQZtw68eXLEnH4qqNbxGt6nnLeWpHIhsJjRfy/VYOQVqQzj7pZk2/Iz4
         ANhPlCjMgTaCKBhFsuITohJX0YZYwVC+3jBKf68if/JAx6lpuHAft3B4H8as/DqBPEXr
         iStL04NH1aRAupzF3wFWaBiLIyLSe6d2RniXayTN1TJkrlBePaaBNoL0uPzkDwxIx9nX
         qdazb0MK/phhDZvkkIzLszqUfwS/rG4CqV+p2m9aukMC9HtZKaL7RcKafK0kFHvr6Pz8
         U0lVTHEFIO0hR+HK4RYMhyCHgzajU8Q47X3/eLnlkD4vK6npvh9jZMXMoNmIz/apC3mi
         LMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679639681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UHxirEYHrGb2qE5WPMytj2srWdUEgiXO6PyInqvMe4=;
        b=MSlm58YTsIXWGGL3Igko22f+3JJ7pEJLvjYcw2MwF1trzOfhCeEpa1W/VSDxr5vzaZ
         Xh+G0UNaACRgQTywpowbNLN6sU4boGsxi3p+NakXdXA/muHpn0oT2owTDBmbJyp7RXNa
         IqfCzInqXxmsvpSBOBwJ6apZntWMa1T26+kxn21hVpDQBmq59thbm5rK1tYsUAjjahw2
         7HP07R2L7eIeMyyrFIMR0CwgkSX+WbzG7QGQdHPG03rD1gO/TKj/IDgdkIx4cynEvmZQ
         diTiFmQ0pQDedhz8TY7UyH7kVHL5gNmH3YJ+nRL8rHJ2Y9G0MjW/VrBrv6mWE7O6pLan
         ZWLA==
X-Gm-Message-State: AO0yUKWMmyDnFC6Er6h7rbCkNylIGsn1hDxW/p/sfoy+czqDN7q9t4dJ
        P49BlHSRiz993EJzefXGpoB3pxlUnWxuSw==
X-Google-Smtp-Source: AK7set8PATXgGqijCG2kxk5gUFOk3dIMtCakN4pJQei6aZm+oRsWbrRUZdkVwulaMP5voutwOr2Czg==
X-Received: by 2002:a05:6a20:8e19:b0:cb:af96:9436 with SMTP id y25-20020a056a208e1900b000cbaf969436mr674750pzj.0.1679639681266;
        Thu, 23 Mar 2023 23:34:41 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id i10-20020aa78d8a000000b006281bc04392sm5401231pfr.191.2023.03.23.23.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 23:34:40 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, willy@infradead.org, brauner@kernel.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org,
        aloktiagi <aloktiagi@gmail.com>
Subject: [RFC v4 2/2] file, epoll: Implement do_replace() and eventpoll_replace()
Date:   Fri, 24 Mar 2023 06:34:22 +0000
Message-Id: <20230324063422.1031181-2-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324063422.1031181-1-aloktiagi@gmail.com>
References: <20230324063422.1031181-1-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a mechanism to replace a file linked in the epoll interface or a file
that has been dup'ed by a file received via the replace_fd() interface.

eventpoll_replace() is called from do_replace() and finds all instances of the
file to be replaced and replaces them with the new file.

do_replace() also replaces the file in the file descriptor table for all fd
numbers referencing it with the new file.

We have a use case where multiple IPv6 only network namespaces can use a single
IPv4 network namespace for IPv4 only egress connectivity by switching their
sockets from IPv6 to IPv4 network namespace. This allows for migration of
systems to IPv6 only while keeping their connectivity to IPv4 only destinations
intact.

Today, we achieve this by setting up seccomp filter to intercept network system
calls like connect() from a container in a container manager which runs in an
IPv4 only network namespace. The container manager creates a new IPv4 connection
and injects the new file descriptor through SECCOMP_NOTIFY_IOCTL_ADDFD replacing
the original file descriptor from the connect() call. This does not work for
cases where the original file descriptor is handed off to a system like epoll
before the connect() call. After a new file descriptor is injected the original
file descriptor being referenced by the epoll fd is not longer valid leading to
failures. As a workaround the container manager when intercepting connect()
loops through all open socket file descriptors to check if they are referencing
the socket attempting the connect() and replace the reference with the to be
injected file descriptor. This workaround is cumbersome and makes the solution
prone to similar yet to be discovered issues.

The above change will enable us remove the workaround in the container manager
and let the kernel handle the replacement correctly.

Signed-off-by: aloktiagi <aloktiagi@gmail.com>
---
Changes in v4:
  - address review comment to remove the redundant eventpoll_replace() function.
  - removed an extra empty line introduced in include/linux/file.h

Changes in v3:
  - address review comment and iterate over the file table while holding the
    spin_lock(&files->file_lock).
  - address review comment and call filp_close() outside the
    spin_lock(&files->file_lock).
---
 fs/eventpoll.c                                | 38 ++++++++
 fs/file.c                                     | 56 +++++++++++
 include/linux/eventpoll.h                     |  8 ++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 97 +++++++++++++++++++
 4 files changed, 199 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 64659b110973..958ad995fd45 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -935,6 +935,44 @@ void eventpoll_release_file(struct file *file)
 	mutex_unlock(&epmutex);
 }
 
+static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
+			struct file *tfile, int fd, int full_check);
+
+/*
+ * This is called from eventpoll_replace() to replace a linked file in the epoll
+ * interface with a new file received from another process. This is useful in
+ * cases where a process is trying to install a new file for an existing one
+ * that is linked in the epoll interface
+ */
+void eventpoll_replace_file(struct file *toreplace, struct file *file)
+{
+	int fd;
+	struct eventpoll *ep;
+	struct epitem *epi;
+	struct hlist_node *next;
+	struct epoll_event event;
+
+	if (!file_can_poll(file))
+		return;
+
+	mutex_lock(&epmutex);
+	if (unlikely(!toreplace->f_ep)) {
+		mutex_unlock(&epmutex);
+		return;
+	}
+
+	hlist_for_each_entry_safe(epi, next, toreplace->f_ep, fllink) {
+		ep = epi->ep;
+		mutex_lock(&ep->mtx);
+		fd = epi->ffd.fd;
+		event = epi->event;
+		ep_remove(ep, epi);
+		ep_insert(ep, &event, file, fd, 1);
+		mutex_unlock(&ep->mtx);
+	}
+	mutex_unlock(&epmutex);
+}
+
 static int ep_alloc(struct eventpoll **pep)
 {
 	int error;
diff --git a/fs/file.c b/fs/file.c
index cbc258504a64..9ccfe39eb622 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -20,10 +20,18 @@
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/close_range.h>
+#include <linux/eventpoll.h>
 #include <net/sock.h>
 
 #include "internal.h"
 
+struct replace_filefd {
+        struct files_struct *files;
+        unsigned fd;
+        struct file *fdfile;
+        struct file *file;
+};
+
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
 unsigned int sysctl_nr_open_min = BITS_PER_LONG;
 /* our min() is unusable in constant expressions ;-/ */
@@ -1131,6 +1139,52 @@ __releases(&files->file_lock)
 	return -EBUSY;
 }
 
+static int do_replace_fd_array(const void *v, struct file *tofree, unsigned int n)
+{
+	struct replace_filefd *ffd = (void *)v;
+	struct fdtable *fdt;
+
+	fdt = files_fdtable(ffd->files);
+
+	if ((n != ffd->fd) && (tofree == ffd->fdfile)) {
+		get_file(ffd->file);
+		rcu_assign_pointer(fdt->fd[n], ffd->file);
+		spin_unlock(&ffd->files->file_lock);
+		filp_close(ffd->fdfile, ffd->files);
+		cond_resched();
+		spin_lock(&ffd->files->file_lock);
+	}
+	return 0;
+}
+
+static void do_replace(struct files_struct *files,
+        struct file *file, unsigned fd, struct file *fdfile)
+{
+	unsigned n = 0;
+	struct replace_filefd ffd = {
+		.files = files,
+		.fd = fd,
+		.fdfile = fdfile,
+		.file = file
+	};
+
+	/*
+	 * Check if the file referenced by the fd number is linked to the epoll
+	 * interface. If yes, replace the reference with the received file in
+	 * the epoll interface.
+	 */
+	if (fdfile && fdfile->f_ep) {
+		eventpoll_replace_file(fdfile, file);
+	}
+	/*
+	 * Install the received file in the file descriptor table for all fd
+	 * numbers referencing the same file as the one we are trying to
+	 * replace. Do not install it for the fd number received since that is
+	 * handled in do_dup2()
+	 */
+	iterate_fd(files, n, do_replace_fd_array, &ffd);
+}
+
 int replace_fd(unsigned fd, struct file *file, unsigned flags)
 {
 	int err;
@@ -1148,8 +1202,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	if (unlikely(err < 0))
 		goto out_unlock;
 	err = do_dup2(files, file, fd, &fdfile, flags);
+	do_replace(files, file, fd, fdfile);
 	if (fdfile)
 		filp_close(fdfile, files);
+
 	return err;
 
 out_unlock:
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 3337745d81bd..711146e79740 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -25,6 +25,14 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
 /* Used to release the epoll bits inside the "struct file" */
 void eventpoll_release_file(struct file *file);
 
+/*
+ * This is called from fs/file.c:do_replace() to replace a linked file in the
+ * epoll interface with a new file received from another process. This is useful
+ * in cases where a process is trying to install a new file for an existing one
+ * that is linked in the epoll interface
+ */
+void eventpoll_replace_file(struct file *toreplace, struct file *file);
+
 /*
  * This is called from inside fs/file_table.c:__fput() to unlink files
  * from the eventpoll interface. We need to have this facility to cleanup
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 61386e499b77..caf68682519c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -47,6 +47,7 @@
 #include <linux/kcmp.h>
 #include <sys/resource.h>
 #include <sys/capability.h>
+#include <sys/epoll.h>
 
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -4179,6 +4180,102 @@ TEST(user_notification_addfd)
 	close(memfd);
 }
 
+TEST(user_notification_addfd_with_epoll_replace)
+{
+	char c;
+	pid_t pid;
+	long ret;
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
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+
+	/* Create two socket pairs sfd[0] <-> sfd[1] and sfd[2] <-> sfd[3] */
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
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
+		if (syscall(__NR_getppid) != USER_NOTIF_MAGIC)
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
+	addfd.newfd = sfd[0];
+	addfd.id = req.id;
+	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
+	addfd.newfd_flags = O_CLOEXEC;
+
+	/*
+	 * Verfiy we can install and replace a file that is linked in the
+	 * epoll interface. Replace the socket sfd[0] with sfd[2]
+	 */
+	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+	EXPECT_EQ(fd, sfd[0]);
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

