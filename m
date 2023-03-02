Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862CE6A887D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCBSWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCBSWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:22:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1352157D07;
        Thu,  2 Mar 2023 10:22:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso3652586pjs.3;
        Thu, 02 Mar 2023 10:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677781341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT7DjRej2ekzPvp4RUybwviWqduiKjY8zyPv3BIKkXA=;
        b=o5v7G8lumwZj5p1ObLcUV8fpzaoA/gzHG2Wl+S1jm2XdCpvveecBk22AzHU7tiW1pG
         DvTWNRS4v2uyOHs2TFcmarJqecbU4To4CnkqdfX80JtxEP4RbAv+2Y0A5OkSb4Ehu+sd
         gtaYNefXDMB++XkRkUCIs4BZr9RfIU366y6A0+GpRvt7DxfqCofcYIjpf0zulzr1Mo9Z
         p01lC1azVk9/vLo+1z+/3mWQkbfH5ZVYPnxFGl3xY0rXS/px72SEorCAMdRMQj4MFDev
         eyzIPfY0Xrz+n+EwFLj9bVODKztte5lnUC/MldUrF+xsR85Ex1/nxGnaplAyuVZ3tU6Q
         qMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677781341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XT7DjRej2ekzPvp4RUybwviWqduiKjY8zyPv3BIKkXA=;
        b=7Z2pzUTyPzBU593JC/24ZsgE241+3baYtmkuPn2AagYjzftIhvbQ3O4EICK0WZVmTS
         nK+i2Lm+bVcx3jkafMFBtuKmhsDGAVFbsIMLOMbVJzTwpWDGbdZC60jr7BKcbmoTFFq+
         2F2Y/5ouHnaQVfQht9DNRGrWGJwCPsXZsfp0u9oZUbOSo8cqsHCiW3RWduAhHzLNPFIW
         2rZOXO9vKlbir3heXfJUr9HQKzJdLAp0jMI7t+chLgssLc7xHyo1KeITXkif/B8NtiuG
         AknE+W7T29oiKTymnoIld59Vyx5EGjQ3hqvnoRbyzHy74gIqFjDa7Qh90NPUOFPaKhpc
         wTDw==
X-Gm-Message-State: AO0yUKXU+DsiHFtQaHrp0XSdzcAd1xcbTlG2/pTVTeEAYUzu3/rbxBv3
        clxfdBwM+7/HRVNRuV4nMSoUWlqPGeQpJg==
X-Google-Smtp-Source: AK7set9oI7J3Ssr/3yXWTj/92nF6jbZ99lvErrB3wyeEISCqS32nvvKvxPWxAdzzswwRYr55H/ahNg==
X-Received: by 2002:a17:90a:2a47:b0:236:7f67:8338 with SMTP id d7-20020a17090a2a4700b002367f678338mr8657243pjg.4.1677781341437;
        Thu, 02 Mar 2023 10:22:21 -0800 (PST)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090adc8600b00234b785af1dsm89908pjv.26.2023.03.02.10.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:22:21 -0800 (PST)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org,
        aloktiagi <aloktiagi@gmail.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC 3/3] file, epoll: Implement do_replace() and eventpoll_replace()
Date:   Thu,  2 Mar 2023 18:22:07 +0000
Message-Id: <20230302182207.456311-3-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302182207.456311-1-aloktiagi@gmail.com>
References: <20230302182207.456311-1-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/eventpoll.c                                | 38 ++++++++
 fs/file.c                                     | 54 +++++++++++
 include/linux/eventpoll.h                     | 18 ++++
 include/linux/file.h                          |  1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 97 +++++++++++++++++++
 5 files changed, 208 insertions(+)

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
index 04c8775d337a..4e24b7223b62 100644
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
@@ -1129,6 +1137,50 @@ __releases(&files->file_lock)
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
+		tofree = pick_file(ffd->files, n);
+		filp_close(tofree, ffd->files);
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
+		eventpoll_replace(fdfile, file);
+	}
+	/*
+	 * Install the received file in the file descriptor table for all fd
+	 * numbers referencing the same file as the one we are trying to
+	 * replace. Do not install it for the fd number received since that is
+	 * handled in do_dup2()
+	 */
+	iterate_fd_locked(files, n, do_replace_fd_array, &ffd);
+}
+
 int replace_fd(unsigned fd, struct file *file, unsigned flags)
 {
 	int err;
@@ -1146,8 +1198,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
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
index 3337745d81bd..38904fce3840 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -25,6 +25,8 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
 /* Used to release the epoll bits inside the "struct file" */
 void eventpoll_release_file(struct file *file);
 
+void eventpoll_replace_file(struct file *toreplace, struct file *file);
+
 /*
  * This is called from inside fs/file_table.c:__fput() to unlink files
  * from the eventpoll interface. We need to have this facility to cleanup
@@ -53,6 +55,22 @@ static inline void eventpoll_release(struct file *file)
 	eventpoll_release_file(file);
 }
 
+
+/*
+ * This is called from fs/file.c:do_replace() to replace a linked file in the
+ * epoll interface with a new file received from another process. This is useful
+ * in cases where a process is trying to install a new file for an existing one
+ * that is linked in the epoll interface
+ */
+static inline void eventpoll_replace(struct file *toreplace, struct file *file)
+{
+	/*
+	 * toreplace is the file being replaced. Install the new file for the
+	 * existing one that is linked in the epoll interface
+	 */
+	eventpoll_replace_file(toreplace, file);
+}
+
 int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		 bool nonblock);
 
diff --git a/include/linux/file.h b/include/linux/file.h
index 39704eae83e2..80e56b2b44fb 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -36,6 +36,7 @@ struct fd {
 	struct file *file;
 	unsigned int flags;
 };
+
 #define FDPUT_FPUT       1
 #define FDPUT_POS_UNLOCK 2
 
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

