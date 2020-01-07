Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C8132DCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgAGR7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:59:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43018 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgAGR7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:59:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so226914pfo.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FiPsXn0KrzApuXYqxG18PVYVk7wEeo8ZrT37gaHFfBI=;
        b=kpioiLIjI1jTGeBMVK+2sPJMFqrVLlx0lSeGEPUWLxJNn0nPIcoMIhXsS7uDtaHEmp
         sZIbPV+KAR4mMk7NXaCaN8T2rtVWrYEnbAMaKaGzhpw+8k+rMlxAqwjyvBVnLz4MsZ1/
         T9eX0q5K7FnZDnEgLet+umi0hIvL2eaxcF7FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FiPsXn0KrzApuXYqxG18PVYVk7wEeo8ZrT37gaHFfBI=;
        b=twapWY52EI48d4EL6qiMDgS6qzXC9v9eLYKmaedul3L3OT+t09vhSXXVutnM0p0UnC
         OSLX2AwlHs3M+eoyOGzokpj3Qbma50GqubjXrK0HxDcKMGLzfeYx1wLEv7DKYdofM+XF
         Sl88UBIYosv8qybcc52Isi8N8OL6pOVYAM9zBjgpfECexBv6rH0QXeWVPvYKW6udvrY+
         7pivkhwp2PAqd4n6Lgel2IHFwe86euErHYMsDtqnYZzJUKL/Opp2jiM0xok9+j90QdvI
         k5XeYgBEJHUb3ME9f+8OTLjjKtWxsIofly0DS0JGZUCISy+HI2ffGmU0BWUPBxIj4aKk
         Kr2g==
X-Gm-Message-State: APjAAAWnqN3/fYywNN0D8fD+DA1Vh6Rs/yXowfxwc7W5u7HWQwae/uiC
        PadIhWB/kLvfVV7x8GgKt3S+Mg==
X-Google-Smtp-Source: APXvYqxU3M9MTKxlJSnsbJkM4W9p7TsE+6IKE3BfwNW8o0e6NlPs5+y2KxqSs6H0FBxp1HsQZG9cZA==
X-Received: by 2002:a63:fc57:: with SMTP id r23mr656903pgk.71.1578419977908;
        Tue, 07 Jan 2020 09:59:37 -0800 (PST)
Received: from ubuntu.netflix.com (166.sub-174-194-208.myvzw.com. [174.194.208.166])
        by smtp.gmail.com with ESMTPSA id g7sm210324pfq.33.2020.01.07.09.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:59:37 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        jannh@google.com, cyphar@cyphar.com, christian.brauner@ubuntu.com,
        oleg@redhat.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: [PATCH v9 2/4] pid: Implement pidfd_getfd syscall
Date:   Tue,  7 Jan 2020 09:59:25 -0800
Message-Id: <20200107175927.4558-3-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107175927.4558-1-sargun@sargun.me>
References: <20200107175927.4558-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This syscall allows for the retrieval of file descriptors from other
processes, based on their pidfd. This is possible using ptrace, and
injection of parasitic code to inject code which leverages SCM_RIGHTS
to move file descriptors between a tracee and a tracer. Unfortunately,
ptrace comes with a high cost of requiring the process to be stopped,
and breaks debuggers. This does not require stopping the process under
manipulation.

One reason to use this is to allow sandboxers to take actions on file
descriptors on the behalf of another process. For example, this can be
combined with seccomp-bpf's user notification to do on-demand fd
extraction and take privileged actions. One such privileged action
is binding a socket to a privileged port.

/* prototype */
  /* flags is currently reserved and should be set to 0 */
  int sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);

/* testing */
Ran self-test suite on x86_64

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/pid.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/kernel/pid.c b/kernel/pid.c
index 2278e249141d..0f4ecb57214c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -578,3 +578,93 @@ void __init pid_idr_init(void)
 	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
 			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 }
+
+static struct file *__pidfd_fget(struct task_struct *task, int fd)
+{
+	struct file *file;
+	int ret;
+
+	ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
+		file = fget_task(task, fd);
+	else
+		file = ERR_PTR(-EPERM);
+
+	mutex_unlock(&task->signal->cred_guard_mutex);
+
+	return file ?: ERR_PTR(-EBADF);
+}
+
+static int pidfd_getfd(struct pid *pid, int fd)
+{
+	struct task_struct *task;
+	struct file *file;
+	int ret;
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		return -ESRCH;
+
+	file = __pidfd_fget(task, fd);
+	put_task_struct(task);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ret = security_file_receive(file);
+	if (ret) {
+		fput(file);
+		return ret;
+	}
+
+	ret = get_unused_fd_flags(O_CLOEXEC);
+	if (ret < 0)
+		fput(file);
+	else
+		fd_install(ret, file);
+
+	return ret;
+}
+
+/**
+ * sys_pidfd_getfd() - Get a file descriptor from another process
+ *
+ * @pidfd:	the pidfd file descriptor of the process
+ * @fd:		the file descriptor number to get
+ * @flags:	flags on how to get the fd (reserved)
+ *
+ * This syscall gets a copy of a file descriptor from another process
+ * based on the pidfd, and file descriptor number. It requires that
+ * the calling process has the ability to ptrace the process represented
+ * by the pidfd. The process which is having its file descriptor copied
+ * is otherwise unaffected.
+ *
+ * Return: On success, a cloexec file descriptor is returned.
+ *         On error, a negative errno number will be returned.
+ */
+SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
+		unsigned int, flags)
+{
+	struct pid *pid;
+	struct fd f;
+	int ret;
+
+	/* flags is currently unused - make sure it's unset */
+	if (flags)
+		return -EINVAL;
+
+	f = fdget(pidfd);
+	if (!f.file)
+		return -EBADF;
+
+	pid = pidfd_pid(f.file);
+	if (IS_ERR(pid))
+		ret = PTR_ERR(pid);
+	else
+		ret = pidfd_getfd(pid, fd);
+
+	fdput(f);
+	return ret;
+}
-- 
2.20.1

