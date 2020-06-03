Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D421EC682
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 03:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgFCBNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 21:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgFCBNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:13:42 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B9C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2020 18:13:42 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id p30so525757pgl.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2020 18:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBsux9GNYVvwlP4X6zcjLbXUNQiaa4HcGGkhihQ37kc=;
        b=Fey2Ug8H0dbv0ROHJD2IS5rnHc2LBbQMOv547Vz84VrPDzFQHbEy97ODS63/V08Jf9
         qAby2AFX412tlWRkNOxM9CyUQmM2jSXDYvOUL1EIH103gA3D7BdpgmCpfveXIpjCwKMK
         EmgVAErOc1CHbXcwASekVHR7UenylK2dplvxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBsux9GNYVvwlP4X6zcjLbXUNQiaa4HcGGkhihQ37kc=;
        b=tp94kYqtggE3vom9w3pqZNwQH7jcCdaKKFaVktun+SzVrqV9MhZgpO8bb8FxkPX7JK
         VDRrrA8Dgho586XsHDDKFPRZTTvoKPGs0CAuoUAFR2ny85hQDjNdjDDyZcs6pZAc71zo
         ZsXUJ5TKbSYt+EPUaJK7/THvAGS02V2p86+SM0XO6CTXL67XTFxTkq1Vnz11B4cNHlig
         QJG15ag5OK8RZ6eKYntffllISx3qanx6U+sHFCDQV5p0SEvM2uaxmj4zUgiIfmgKfi9O
         W0OOAYMNDFGfE6ADSn+qxL3gTOeu0VkMRkbPPFn9Nf8ZuZUWA0kgVapkvac14b/7Ilx4
         cGqw==
X-Gm-Message-State: AOAM533SAT+NVmReQb7tMr58dOojf3jJzZcAjUE9rBf5q03SCvBvm6qn
        hWhg4pm1pnyOkeQy7MVSJT4XaA==
X-Google-Smtp-Source: ABdhPJz5RRq5Mj9lYdNCV8uFi/1B812WvYKHgYb3hsmvigxeNkSrvl7XwZ2hELTVjkK336mlxretWw==
X-Received: by 2002:a17:90a:394b:: with SMTP id n11mr2389811pjf.100.1591146821947;
        Tue, 02 Jun 2020 18:13:41 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id a12sm263222pjw.35.2020.06.02.18.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 18:13:41 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 3/4] seccomp: Introduce addfd ioctl to seccomp user notifier
Date:   Tue,  2 Jun 2020 18:10:43 -0700
Message-Id: <20200603011044.7972-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011044.7972-1-sargun@sargun.me>
References: <20200603011044.7972-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a seccomp notifier ioctl which allows for the listener to "add"
file descriptors to a process which originated a seccomp user
notification. This allows calls like mount, and mknod to be "implemented",
as the return value, and the arguments are data in memory. On the other
hand, calls like connect can be "implemented" using pidfd_getfd.

Unfortunately, there are calls which return file descriptors, like
open, which are vulnerable to TOC-TOU attacks, and require that the
more privileged supervisor can inspect the argument, and perform the
syscall on behalf of the process generating the notification. This
allows the file descriptor generated from that open call to be
returned to the calling process.

In addition, there is funcitonality to allow for replacement of
specific file descriptors, following dup2-like semantics.

This extends a previously added helper (file_receive), and introduces
a new helper built on top of it -- file_receive_replace, which is
meant to assist with calling replace_fd, with files received from
remote processes.

As a note, the seccomp_notif_addfd structure is laid out based on 8-byte
alignment without requiring packing as there have been packing issues with
uapi highlighted before [1][2]. Although we could overload the newfd field
and use -1 to indicate that it is not to be used, doing so requires
changing the size of the fd field, and introduces struct packing
complexity.

[1]: https://lore.kernel.org/lkml/87o8w9bcaf.fsf@mid.deneb.enyo.de/
[2]: https://lore.kernel.org/lkml/a328b91d-fd8f-4f27-b3c2-91a9c45f18c0@rasmusvillemoes.dk/

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Matt Denton <mpdenton@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Chris Palmer <palmer@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Robert Sesek <rsesek@google.com>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org
---
 fs/file.c                    |  29 +++++-
 include/linux/file.h         |   1 +
 include/uapi/linux/seccomp.h |  25 +++++
 kernel/seccomp.c             | 184 ++++++++++++++++++++++++++++++++++-
 4 files changed, 234 insertions(+), 5 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 5afd76fca8c2..eb413c1fdb7f 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -938,15 +938,19 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  * File Receive - Receive a file from another process
  *
  * This function is designed to receive files from other tasks. It encapsulates
- * logic around security and cgroups. The file descriptor provided must be a
- * freshly allocated (unused) file descriptor.
+ * logic around security and cgroups. It can either replace an existing file
+ * descriptor, or install the file at a new unused one. If the file is meant
+ * to be installed on a new file descriptor, it must be allocated with the
+ * right flags by the user and the flags passed must be 0 -- as anything else
+ * is ignored.
  *
  * This helper does not consume a reference to the file, so the caller must put
  * their reference.
  *
  * Returns 0 upon success.
  */
-int file_receive(int fd, struct file *file)
+static int __file_receive(int fd, unsigned int flags, struct file *file,
+			  bool replace)
 {
 	struct socket *sock;
 	int err;
@@ -955,7 +959,14 @@ int file_receive(int fd, struct file *file)
 	if (err)
 		return err;
 
-	fd_install(fd, get_file(file));
+	if (replace) {
+		err = replace_fd(fd, file, flags);
+		if (err)
+			return err;
+	} else {
+		WARN_ON(flags);
+		fd_install(fd, get_file(file));
+	}
 
 	sock = sock_from_file(file, &err);
 	if (sock) {
@@ -966,6 +977,16 @@ int file_receive(int fd, struct file *file)
 	return 0;
 }
 
+int file_receive_replace(int fd, unsigned int flags, struct file *file)
+{
+	return __file_receive(fd, flags, file, true);
+}
+
+int file_receive(int fd, struct file *file)
+{
+	return __file_receive(fd, 0, file, false);
+}
+
 static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
diff --git a/include/linux/file.h b/include/linux/file.h
index 7b56dc23e560..e4ca058fb559 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -94,5 +94,6 @@ extern void fd_install(unsigned int fd, struct file *file);
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
 
+extern int file_receive_replace(int fd, unsigned int flags, struct file *file);
 extern int file_receive(int fd, struct file *file);
 #endif /* __LINUX_FILE_H */
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index c1735455bc53..aec3e43c4418 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -113,6 +113,27 @@ struct seccomp_notif_resp {
 	__u32 flags;
 };
 
+/* valid flags for seccomp_notif_addfd */
+#define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
+
+/**
+ * struct seccomp_notif_addfd
+ * @size: The size of the seccomp_notif_addfd datastructure
+ * @id: The ID of the seccomp notification
+ * @flags: SECCOMP_ADDFD_FLAG_*
+ * @srcfd: The local fd number
+ * @newfd: Optional remote FD number if SETFD option is set, otherwise 0.
+ * @newfd_flags: Flags the remote FD should be allocated under
+ */
+struct seccomp_notif_addfd {
+	__u64 size;
+	__u64 id;
+	__u32 flags;
+	__u32 srcfd;
+	__u32 newfd;
+	__u32 newfd_flags;
+};
+
 #define SECCOMP_IOC_MAGIC		'!'
 #define SECCOMP_IO(nr)			_IO(SECCOMP_IOC_MAGIC, nr)
 #define SECCOMP_IOR(nr, type)		_IOR(SECCOMP_IOC_MAGIC, nr, type)
@@ -124,4 +145,8 @@ struct seccomp_notif_resp {
 #define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
 						struct seccomp_notif_resp)
 #define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
+/* On success, the return value is the remote process's added fd number */
+#define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOR(3,	\
+						struct seccomp_notif_addfd)
+
 #endif /* _UAPI_LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 34dbf77569b3..c39e901e8af5 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -78,10 +78,42 @@ struct seccomp_knotif {
 	long val;
 	u32 flags;
 
-	/* Signals when this has entered SECCOMP_NOTIFY_REPLIED */
+	/*
+	 * Signals when this has changed states, such as the listener
+	 * dying, a new seccomp addfd message, or changing to REPLIED
+	 */
 	struct completion ready;
 
 	struct list_head list;
+
+	/* outstanding addfd requests */
+	struct list_head addfd;
+};
+
+/**
+ * struct seccomp_kaddfd - container for seccomp_addfd ioctl messages
+ *
+ * @file: A reference to the file to install in the other task
+ * @fd: The fd number to install it at. If the fd number is -1, it means the
+ *      installing process should allocate the fd as normal.
+ * @flags: The flags for the new file descriptor. At the moment, only O_CLOEXEC
+ *         is allowed.
+ * @ret: The return value of the installing process. It is set to the fd num
+ *       upon success (>= 0).
+ * @completion: Indicates that the installing process has completed fd
+ *              installation, or gone away (either due to successful
+ *              reply, or signal)
+ *
+ */
+struct seccomp_kaddfd {
+	struct file *file;
+	int fd;
+	unsigned int flags;
+
+	/* To only be set on reply */
+	int ret;
+	struct completion completion;
+	struct list_head list;
 };
 
 /**
@@ -784,6 +816,36 @@ static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
 	return filter->notif->next_id++;
 }
 
+static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
+{
+	int ret, err;
+
+	/*
+	 * Remove the notification, and reset the list pointers, indicating
+	 * that it has been handled.
+	 */
+	list_del_init(&addfd->list);
+
+	if (addfd->fd == -1) {
+		ret = get_unused_fd_flags(addfd->flags);
+		if (ret < 0)
+			goto err;
+
+		err = file_receive(ret, addfd->file);
+		if (err) {
+			put_unused_fd(ret);
+			ret = err;
+		}
+	} else {
+		ret = file_receive_replace(addfd->fd, addfd->flags,
+					   addfd->file);
+	}
+
+err:
+	addfd->ret = ret;
+	complete(&addfd->completion);
+}
+
 static int seccomp_do_user_notification(int this_syscall,
 					struct seccomp_filter *match,
 					const struct seccomp_data *sd)
@@ -792,6 +854,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	u32 flags = 0;
 	long ret = 0;
 	struct seccomp_knotif n = {};
+	struct seccomp_kaddfd *addfd, *tmp;
 
 	mutex_lock(&match->notify_lock);
 	err = -ENOSYS;
@@ -804,6 +867,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	n.id = seccomp_next_notify_id(match);
 	init_completion(&n.ready);
 	list_add(&n.list, &match->notif->notifications);
+	INIT_LIST_HEAD(&n.addfd);
 
 	up(&match->notif->request);
 	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
@@ -812,14 +876,31 @@ static int seccomp_do_user_notification(int this_syscall,
 	/*
 	 * This is where we wait for a reply from userspace.
 	 */
+wait:
 	err = wait_for_completion_interruptible(&n.ready);
 	mutex_lock(&match->notify_lock);
 	if (err == 0) {
+		/* Check if we were woken up by a addfd message */
+		addfd = list_first_entry_or_null(&n.addfd,
+						 struct seccomp_kaddfd, list);
+		if (addfd && n.state != SECCOMP_NOTIFY_REPLIED) {
+			seccomp_handle_addfd(addfd);
+			mutex_unlock(&match->notify_lock);
+			goto wait;
+		}
 		ret = n.val;
 		err = n.error;
 		flags = n.flags;
 	}
 
+	/* If there were any pending addfd calls, clear them out */
+	list_for_each_entry_safe(addfd, tmp, &n.addfd, list) {
+		/* The process went away before we got a chance to handle it */
+		addfd->ret = -ESRCH;
+		list_del_init(&addfd->list);
+		complete(&addfd->completion);
+	}
+
 	/*
 	 * Note that it's possible the listener died in between the time when
 	 * we were notified of a respons (or a signal) and when we were able to
@@ -1060,6 +1141,11 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
 		knotif->error = -ENOSYS;
 		knotif->val = 0;
 
+		/*
+		 * We do not need to wake up any pending addfd messages, as
+		 * the notifier will do that for us, as this just looks
+		 * like a standard reply.
+		 */
 		complete(&knotif->ready);
 	}
 
@@ -1224,6 +1310,100 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 	return ret;
 }
 
+static long seccomp_notify_addfd(struct seccomp_filter *filter,
+				 struct seccomp_notif_addfd __user *uaddfd)
+{
+	struct seccomp_notif_addfd addfd;
+	struct seccomp_knotif *knotif;
+	struct seccomp_kaddfd kaddfd;
+	u64 size;
+	int ret;
+
+	ret = get_user(size, &uaddfd->size);
+	if (ret)
+		return ret;
+
+	ret = copy_struct_from_user(&addfd, sizeof(addfd), uaddfd, size);
+	if (ret)
+		return ret;
+
+	if (addfd.newfd_flags & ~O_CLOEXEC)
+		return -EINVAL;
+
+	if (addfd.flags & ~SECCOMP_ADDFD_FLAG_SETFD)
+		return -EINVAL;
+
+	if (addfd.newfd && !(addfd.flags & SECCOMP_ADDFD_FLAG_SETFD))
+		return -EINVAL;
+
+	kaddfd.file = fget(addfd.srcfd);
+	if (!kaddfd.file)
+		return -EBADF;
+
+	kaddfd.flags = addfd.newfd_flags;
+	kaddfd.fd = (addfd.flags & SECCOMP_ADDFD_FLAG_SETFD) ?
+		    addfd.newfd : -1;
+	init_completion(&kaddfd.completion);
+
+	ret = mutex_lock_interruptible(&filter->notify_lock);
+	if (ret < 0)
+		goto out;
+
+	knotif = find_notification(filter, addfd.id);
+	if (!knotif) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	/*
+	 * We do not want to allow for FD injection to occur before the
+	 * notification has been picked up by a userspace handler, or after
+	 * the notification has been replied to.
+	 */
+	if (knotif->state != SECCOMP_NOTIFY_SENT) {
+		ret = -EINPROGRESS;
+		goto out_unlock;
+	}
+
+	list_add(&kaddfd.list, &knotif->addfd);
+	complete(&knotif->ready);
+	mutex_unlock(&filter->notify_lock);
+
+	/* Now we wait for it to be processed or be interrupted */
+	ret = wait_for_completion_interruptible(&kaddfd.completion);
+	if (ret == 0) {
+		/*
+		 * We had a successful completion. The other side has already
+		 * removed us from the addfd queue, and
+		 * wait_for_completion_interruptible has a memory barrier upon
+		 * success that lets us read this value directly without
+		 * locking.
+		 */
+		ret = kaddfd.ret;
+		goto out;
+	}
+
+	mutex_lock(&filter->notify_lock);
+	/*
+	 * Even though we were woken up by a signal and not a successful
+	 * completion, a completion may have happened in the mean time.
+	 *
+	 * We need to check again if the addfd request has been handled,
+	 * and if not, we will remove it from the queue.
+	 */
+	if (list_empty(&kaddfd.list))
+		ret = kaddfd.ret;
+	else
+		list_del(&kaddfd.list);
+
+out_unlock:
+	mutex_unlock(&filter->notify_lock);
+out:
+	fput(kaddfd.file);
+
+	return ret;
+}
+
 static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg)
 {
@@ -1237,6 +1417,8 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 		return seccomp_notify_send(filter, buf);
 	case SECCOMP_IOCTL_NOTIF_ID_VALID:
 		return seccomp_notify_id_valid(filter, buf);
+	case SECCOMP_IOCTL_NOTIF_ADDFD:
+		return seccomp_notify_addfd(filter, buf);
 	default:
 		return -EINVAL;
 	}
-- 
2.25.1

