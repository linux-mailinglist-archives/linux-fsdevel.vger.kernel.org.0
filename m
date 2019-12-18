Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4122612580E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 00:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLRXzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 18:55:04 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45936 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfLRXzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:55:04 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so3224745iln.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 15:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7Lr3kTkvItIIpHjMeDA8GxtDtNg/P3eKulqPK+7nAVw=;
        b=A2p+MAMq4LUN7tkM+pO+4I1Mjb7gQUd7ZkYMZtb6d0lEkrTN/GsHc4K3FoSsAFJtyu
         8xLR7qXkszqIjGfNzcRpPTUunLgomUwaJNfdRpOfSu7r1clMLJ2lrcJMr6mlmoVJkTR/
         fYMFAzpM0pyVICBd8Q4omVAVYwRu7jgpvDLHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7Lr3kTkvItIIpHjMeDA8GxtDtNg/P3eKulqPK+7nAVw=;
        b=OM0SB2/Cwo8dsfYb194FshzhqF/l4uSy0YOuFYxtqZZVTQwb8Jm2F2+8eiEUY/Xt1x
         /qrm35Yel/S7xYxz32Cfw5iNZqtIqE2nPYbhK8sDIOAgB47eVoGg90pc2gsgXqD8KfiM
         RfjvML2a2svedGCZfo6yiRFx6+3iilTJG+JMHtfKhlSOOvCjzDUvFCcGrxlswHx6mHub
         5IWU6cH0JfDLfKxPBzvR4ie74IvpafFEc0SeCxI29oodkruxZcHN0tROxJ5rxn2ZsM2k
         UBaqqxjE5YZo+RTsQEuPIrtQxXbfKB4+G+M9YgCF+0CCmqLCqTFvpEFaMvVgEVuKfolr
         pajQ==
X-Gm-Message-State: APjAAAVITwhukr/ofiy65kBcHy07zQDEmrLjbdSz2pCUab556fvpJdxB
        XMbaOhlS6+RdOfTHSds892j9Fg==
X-Google-Smtp-Source: APXvYqzybGUSUeJ3Zlzi93nDfkx+ie/7+AIqeAPKutkA3q5osrsoEu83slkGf7ZHiB87OBYjvh1zkA==
X-Received: by 2002:a92:cc42:: with SMTP id t2mr4453841ilq.111.1576713303449;
        Wed, 18 Dec 2019 15:55:03 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id s4sm1144794ilp.21.2019.12.18.15.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 15:55:03 -0800 (PST)
Date:   Wed, 18 Dec 2019 23:55:01 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file descriptors
 from processes
Message-ID: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
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
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 MAINTAINERS                                   |  1 +
 include/uapi/linux/pidfd.h                    | 10 +++
 kernel/fork.c                                 | 77 +++++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 include/uapi/linux/pidfd.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 4ef86433bd67..9f9be681662b 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -273,6 +273,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:tim@cyberelk.net>
 'p'   A1-A5  linux/pps.h                                             LinuxPPS
                                                                      <mailto:giometti@linux.it>
+'p'   B0-CF  linux/pidfd.h
 'q'   00-1F  linux/serio.h
 'q'   80-FF  linux/telephony.h                                       Internet PhoneJACK, Internet LineJACK
              linux/ixjuser.h                                         <http://web.archive.org/web/%2A/http://www.quicknet.net>
diff --git a/MAINTAINERS b/MAINTAINERS
index cc0a4a8ae06a..bc370ff59dbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13014,6 +13014,7 @@ M:	Christian Brauner <christian@brauner.io>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
+F:	include/uapi/linux/pidfd.h
 F:	samples/pidfd/
 F:	tools/testing/selftests/pidfd/
 F:	tools/testing/selftests/clone3/
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
new file mode 100644
index 000000000000..90ff535be048
--- /dev/null
+++ b/include/uapi/linux/pidfd.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_PID_H
+#define _UAPI_LINUX_PID_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define PIDFD_IOCTL_GETFD	_IOWR('p', 0xb0, __u32)
+
+#endif /* _UAPI_LINUX_PID_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f238a3..09b5f233b5a8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
 #include <linux/kasan.h>
+#include <uapi/linux/pidfd.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1790,9 +1791,85 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
+static struct file *__pidfd_getfd_fget_task(struct task_struct *task, u32 fd)
+{
+	struct file *file;
+	int ret;
+
+	ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+		file = ERR_PTR(-EPERM);
+		goto out;
+	}
+
+	file = fget_task(task, fd);
+	if (!file)
+		file = ERR_PTR(-EBADF);
+
+out:
+	mutex_unlock(&task->signal->cred_guard_mutex);
+	return file;
+}
+
+static long pidfd_getfd(struct pid *pid, u32 fd)
+{
+	struct task_struct *task;
+	struct file *file;
+	int ret, retfd;
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		return -ESRCH;
+
+	file = __pidfd_getfd_fget_task(task, fd);
+	put_task_struct(task);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	retfd = get_unused_fd_flags(O_CLOEXEC);
+	if (retfd < 0) {
+		ret = retfd;
+		goto out;
+	}
+
+	/*
+	 * security_file_receive must come last since it may have side effects
+	 * and cannot be reversed.
+	 */
+	ret = security_file_receive(file);
+	if (ret)
+		goto out_put_fd;
+
+	fd_install(retfd, file);
+	return retfd;
+
+out_put_fd:
+	put_unused_fd(retfd);
+out:
+	fput(file);
+	return ret;
+}
+
+static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pid *pid = file->private_data;
+
+	switch (cmd) {
+	case PIDFD_IOCTL_GETFD:
+		return pidfd_getfd(pid, arg);
+	default:
+		return -EINVAL;
+	}
+}
+
 const struct file_operations pidfd_fops = {
 	.release = pidfd_release,
 	.poll = pidfd_poll,
+	.unlocked_ioctl = pidfd_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = pidfd_show_fdinfo,
 #endif
-- 
2.20.1

