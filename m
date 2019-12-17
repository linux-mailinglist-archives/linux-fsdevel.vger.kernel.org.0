Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3712210E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 02:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfLQBAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 20:00:08 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44902 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfLQBAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:00:07 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so6972084iln.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 17:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Sm2OFZZDnAm6HtYHTigzrKnwqviaFvFk+BMgRHfZfe0=;
        b=oRLMMSkO+qHMibdj8oUxIIvrRnjhoJEziOmUykia3GgnJrLlCi9Hd6JWEfmfATUNep
         YBi5QHH+F6MEu4kv3rp4K5VhB4YLNozdd8+XLVxEFY+HFLdap4Z2+L08GakI6ZUdmKGp
         k5QE6YgyJ75tucqvsFI8KGKybCrDhDGNlji3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Sm2OFZZDnAm6HtYHTigzrKnwqviaFvFk+BMgRHfZfe0=;
        b=n80DrmXXyIkNZJoHG41UQGZEggYRXzjtPZ+7cTPqZY+bAgXKGhvi6pYCJSWQhIxKRU
         rS7M4KQZq3TqfOfUzP9c6nOta3DX2wD3Hrm3vIfVoPmX9qSYgKxo+kErCTvnQfEbNfSL
         jRkdPgp/vmRH/YA1kC5zsDDmipv18dgYUP4xre6eSCtNGP7dxZGyaTu7+GaIKWkZ7MWx
         iBhNAIDF7yr2ynVLG6gSwcle7kSA7ppxEoVTIDDzKBUQ/y7V9UqS8Cyb/lgf7VVnMQm1
         gEpUOsDEg+kbb538rkmyvbT8F4Um3kBP68Ijzs4F+Aw3sWc8GugjjqGkzAYfLMvHfAwV
         vZQg==
X-Gm-Message-State: APjAAAVqgYjFMV7eQDsFZLpbdyGq3j1P1fQ/yX/K+q9r1DakpCUuG5WQ
        jdAqK0XKOYXMOgpMqMfujbrQXQ==
X-Google-Smtp-Source: APXvYqwDTW2pfVKMawWRTUOtmh1yg1fQppqbiiKryZiM1i1L4nbkUdOL3QTYQt4FCw4ea7tt7oGqYQ==
X-Received: by 2002:a92:485a:: with SMTP id v87mr14375978ila.128.1576544406791;
        Mon, 16 Dec 2019 17:00:06 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id h6sm4832431iom.43.2019.12.16.17.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 17:00:06 -0800 (PST)
Date:   Tue, 17 Dec 2019 01:00:04 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com
Subject: [PATCH v3 2/4] pid: Add PIDFD_IOCTL_GETFD to fetch file descriptors
 from processes
Message-ID: <20191217010001.GA14461@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds an ioctl which allows file descriptors to be extracted
from processes based on their pidfd.

One reason to use this is to allow sandboxers to take actions on file
descriptors on the behalf of another process. For example, this can be
combined with seccomp-bpf's user notification to do on-demand fd
extraction and take privileged actions. For example, it can be used
to bind a socket to a privileged port. This is similar to ptrace, and
using ptrace parasitic code injection to extract a file descriptor from a
process, but without breaking debuggers, or paying the ptrace overhead
cost.

You must have the ability to ptrace the process in order to extract any
file descriptors from it. ptrace can already be used to extract file
descriptors based on parasitic code injections, so the permissions
model is aligned.

The ioctl takes a pointer to pidfd_getfd_args. pidfd_getfd_args contains
a size, which allows for gradual evolution of the API. There is an options
field, which can be used to state whether the fd should be opened with
CLOEXEC, or not. An additional options field may be added in the future
to include the ability to clear cgroup information about the file
descriptor at a later point. If the structure is from a newer kernel, and
includes members which make it larger than the structure that's known to
this kernel version, E2BIG will be returned.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 Documentation/ioctl/ioctl-number.rst |  1 +
 include/linux/pid.h                  |  1 +
 include/uapi/linux/pid.h             | 26 ++++++++++
 kernel/fork.c                        | 72 ++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 include/uapi/linux/pid.h

diff --git a/Documentation/ioctl/ioctl-number.rst b/Documentation/ioctl/ioctl-number.rst
index bef79cd4c6b4..be2efb93acd1 100644
--- a/Documentation/ioctl/ioctl-number.rst
+++ b/Documentation/ioctl/ioctl-number.rst
@@ -272,6 +272,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:tim@cyberelk.net>
 'p'   A1-A5  linux/pps.h                                             LinuxPPS
                                                                      <mailto:giometti@linux.it>
+'p'   B0-CF  uapi/linux/pid.h
 'q'   00-1F  linux/serio.h
 'q'   80-FF  linux/telephony.h                                       Internet PhoneJACK, Internet LineJACK
              linux/ixjuser.h                                         <http://web.archive.org/web/%2A/http://www.quicknet.net>
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 9645b1194c98..65f1a73040c9 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -5,6 +5,7 @@
 #include <linux/rculist.h>
 #include <linux/wait.h>
 #include <linux/refcount.h>
+#include <uapi/linux/pid.h>
 
 enum pid_type
 {
diff --git a/include/uapi/linux/pid.h b/include/uapi/linux/pid.h
new file mode 100644
index 000000000000..4ec02ed8b39a
--- /dev/null
+++ b/include/uapi/linux/pid.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_PID_H
+#define _UAPI_LINUX_PID_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* options to pass in to pidfd_getfd_args flags */
+#define PIDFD_GETFD_CLOEXEC (1 << 0)	/* open the fd with cloexec */
+
+struct pidfd_getfd_args {
+	__u32 size;		/* sizeof(pidfd_getfd_args) */
+	__u32 fd;       /* the tracee's file descriptor to get */
+	__u32 flags;
+};
+
+#define PIDFD_IOC_MAGIC			'p'
+#define PIDFD_IO(nr)			_IO(PIDFD_IOC_MAGIC, nr)
+#define PIDFD_IOR(nr, type)		_IOR(PIDFD_IOC_MAGIC, nr, type)
+#define PIDFD_IOW(nr, type)		_IOW(PIDFD_IOC_MAGIC, nr, type)
+#define PIDFD_IOWR(nr, type)		_IOWR(PIDFD_IOC_MAGIC, nr, type)
+
+#define PIDFD_IOCTL_GETFD		PIDFD_IOWR(0xb0, \
+						struct pidfd_getfd_args)
+
+#endif /* _UAPI_LINUX_PID_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 6cabc124378c..d9971e664e82 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1726,9 +1726,81 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
+static long pidfd_getfd(struct pid *pid, struct pidfd_getfd_args __user *buf)
+{
+	struct pidfd_getfd_args args;
+	unsigned int fd_flags = 0;
+	struct task_struct *task;
+	struct file *file;
+	u32 user_size;
+	int ret, fd;
+
+	ret = get_user(user_size, &buf->size);
+	if (ret)
+		return ret;
+
+	ret = copy_struct_from_user(&args, sizeof(args), buf, user_size);
+	if (ret)
+		return ret;
+	if ((args.flags & ~(PIDFD_GETFD_CLOEXEC)) != 0)
+		return -EINVAL;
+	if (args.flags & PIDFD_GETFD_CLOEXEC)
+		fd_flags |= O_CLOEXEC;
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		return -ESRCH;
+	ret = -EPERM;
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+		goto out;
+	ret = -EBADF;
+	file = fget_task(task, args.fd);
+	if (!file)
+		goto out;
+
+	fd = get_unused_fd_flags(fd_flags);
+	if (fd < 0) {
+		ret = fd;
+		goto out_put_file;
+	}
+	/*
+	 * security_file_receive must come last since it may have side effects
+	 * and cannot be reversed.
+	 */
+	ret = security_file_receive(file);
+	if (ret)
+		goto out_put_fd;
+
+	fd_install(fd, file);
+	put_task_struct(task);
+	return fd;
+
+out_put_fd:
+	put_unused_fd(fd);
+out_put_file:
+	fput(file);
+out:
+	put_task_struct(task);
+	return ret;
+}
+
+static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pid *pid = file->private_data;
+	void __user *buf = (void __user *)arg;
+
+	switch (cmd) {
+	case PIDFD_IOCTL_GETFD:
+		return pidfd_getfd(pid, buf);
+	default:
+		return -EINVAL;
+	}
+}
+
 const struct file_operations pidfd_fops = {
 	.release = pidfd_release,
 	.poll = pidfd_poll,
+	.unlocked_ioctl = pidfd_ioctl,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = pidfd_show_fdinfo,
 #endif
-- 
2.20.1

