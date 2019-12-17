Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACBA61221B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 02:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfLQBuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 20:50:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39685 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfLQBuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:50:07 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ih1zv-0002DT-F6; Tue, 17 Dec 2019 01:50:03 +0000
Date:   Tue, 17 Dec 2019 02:50:02 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: Re: [PATCH v3 2/4] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
Message-ID: <20191217015001.sp6mrhuiqrivkq3u@wittgenstein>
References: <20191217010001.GA14461@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217010001.GA14461@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc Arnd since he fiddled with ioctl()s quite a bit recently.]

On Tue, Dec 17, 2019 at 01:00:04AM +0000, Sargun Dhillon wrote:
> This adds an ioctl which allows file descriptors to be extracted
> from processes based on their pidfd.
> 
> One reason to use this is to allow sandboxers to take actions on file
> descriptors on the behalf of another process. For example, this can be
> combined with seccomp-bpf's user notification to do on-demand fd
> extraction and take privileged actions. For example, it can be used
> to bind a socket to a privileged port. This is similar to ptrace, and
> using ptrace parasitic code injection to extract a file descriptor from a
> process, but without breaking debuggers, or paying the ptrace overhead
> cost.
> 
> You must have the ability to ptrace the process in order to extract any
> file descriptors from it. ptrace can already be used to extract file
> descriptors based on parasitic code injections, so the permissions
> model is aligned.
> 
> The ioctl takes a pointer to pidfd_getfd_args. pidfd_getfd_args contains
> a size, which allows for gradual evolution of the API. There is an options
> field, which can be used to state whether the fd should be opened with
> CLOEXEC, or not. An additional options field may be added in the future
> to include the ability to clear cgroup information about the file
> descriptor at a later point. If the structure is from a newer kernel, and
> includes members which make it larger than the structure that's known to
> this kernel version, E2BIG will be returned.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  Documentation/ioctl/ioctl-number.rst |  1 +
>  include/linux/pid.h                  |  1 +
>  include/uapi/linux/pid.h             | 26 ++++++++++
>  kernel/fork.c                        | 72 ++++++++++++++++++++++++++++
>  4 files changed, 100 insertions(+)
>  create mode 100644 include/uapi/linux/pid.h
> 
> diff --git a/Documentation/ioctl/ioctl-number.rst b/Documentation/ioctl/ioctl-number.rst
> index bef79cd4c6b4..be2efb93acd1 100644
> --- a/Documentation/ioctl/ioctl-number.rst
> +++ b/Documentation/ioctl/ioctl-number.rst
> @@ -272,6 +272,7 @@ Code  Seq#    Include File                                           Comments
>                                                                       <mailto:tim@cyberelk.net>
>  'p'   A1-A5  linux/pps.h                                             LinuxPPS
>                                                                       <mailto:giometti@linux.it>
> +'p'   B0-CF  uapi/linux/pid.h
>  'q'   00-1F  linux/serio.h
>  'q'   80-FF  linux/telephony.h                                       Internet PhoneJACK, Internet LineJACK
>               linux/ixjuser.h                                         <http://web.archive.org/web/%2A/http://www.quicknet.net>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 9645b1194c98..65f1a73040c9 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -5,6 +5,7 @@
>  #include <linux/rculist.h>
>  #include <linux/wait.h>
>  #include <linux/refcount.h>
> +#include <uapi/linux/pid.h>

That should be pidfd.h and the resulting new file be placed under the
pidfd entry in maintainers:
+F:     include/uapi/linux/pidfd.h

>  
>  enum pid_type
>  {
> diff --git a/include/uapi/linux/pid.h b/include/uapi/linux/pid.h
> new file mode 100644
> index 000000000000..4ec02ed8b39a
> --- /dev/null
> +++ b/include/uapi/linux/pid.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_PID_H
> +#define _UAPI_LINUX_PID_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +/* options to pass in to pidfd_getfd_args flags */
> +#define PIDFD_GETFD_CLOEXEC (1 << 0)	/* open the fd with cloexec */

Please, make them cloexec by default unless there's a very good reason
not to.

> +
> +struct pidfd_getfd_args {
> +	__u32 size;		/* sizeof(pidfd_getfd_args) */
> +	__u32 fd;       /* the tracee's file descriptor to get */
> +	__u32 flags;
> +};

I think you want to either want to pad this

+struct pidfd_getfd_args {
+	__u32 size;		/* sizeof(pidfd_getfd_args) */
+	__u32 fd;       /* the tracee's file descriptor to get */
+	__u32 flags;
	__u32 reserved;
+};

or use __aligned_u64 everywhere which I'd personally prefer instead of
this manual padding everywhere.

> +
> +#define PIDFD_IOC_MAGIC			'p'
> +#define PIDFD_IO(nr)			_IO(PIDFD_IOC_MAGIC, nr)
> +#define PIDFD_IOR(nr, type)		_IOR(PIDFD_IOC_MAGIC, nr, type)
> +#define PIDFD_IOW(nr, type)		_IOW(PIDFD_IOC_MAGIC, nr, type)
> +#define PIDFD_IOWR(nr, type)		_IOWR(PIDFD_IOC_MAGIC, nr, type)
> +
> +#define PIDFD_IOCTL_GETFD		PIDFD_IOWR(0xb0, \
> +						struct pidfd_getfd_args)
> +
> +#endif /* _UAPI_LINUX_PID_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 6cabc124378c..d9971e664e82 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1726,9 +1726,81 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  	return poll_flags;
>  }
>  
> +static long pidfd_getfd(struct pid *pid, struct pidfd_getfd_args __user *buf)
> +{
> +	struct pidfd_getfd_args args;
> +	unsigned int fd_flags = 0;
> +	struct task_struct *task;
> +	struct file *file;
> +	u32 user_size;
> +	int ret, fd;
> +
> +	ret = get_user(user_size, &buf->size);
> +	if (ret)
> +		return ret;
> +
> +	ret = copy_struct_from_user(&args, sizeof(args), buf, user_size);
> +	if (ret)
> +		return ret;
> +	if ((args.flags & ~(PIDFD_GETFD_CLOEXEC)) != 0)
> +		return -EINVAL;

Nit: It's more common - especially in this file - to do

if (args.flags & ~PIDFD_GETFD_CLOEXEC)
	return -EINVAL;

> +	if (args.flags & PIDFD_GETFD_CLOEXEC)
> +		fd_flags |= O_CLOEXEC;
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task)
> +		return -ESRCH;

\n

> +	ret = -EPERM;
> +	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
> +		goto out;

\n

Please don't pre-set errors unless they are used by multiple exit paths.
if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
	ret = -EPERM;
	goto out;
}

> +	ret = -EBADF;
> +	file = fget_task(task, args.fd);
> +	if (!file)
> +		goto out;

Same.

> +
> +	fd = get_unused_fd_flags(fd_flags);
> +	if (fd < 0) {
> +		ret = fd;
> +		goto out_put_file;
> +	}

\n

> +	/*
> +	 * security_file_receive must come last since it may have side effects
> +	 * and cannot be reversed.
> +	 */
> +	ret = security_file_receive(file);
> +	if (ret)
> +		goto out_put_fd;
> +
> +	fd_install(fd, file);
> +	put_task_struct(task);
> +	return fd;
> +
> +out_put_fd:
> +	put_unused_fd(fd);
> +out_put_file:
> +	fput(file);
> +out:
> +	put_task_struct(task);
> +	return ret;
> +}
> +
> +static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct pid *pid = file->private_data;
> +	void __user *buf = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case PIDFD_IOCTL_GETFD:
> +		return pidfd_getfd(pid, buf);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  const struct file_operations pidfd_fops = {
>  	.release = pidfd_release,
>  	.poll = pidfd_poll,
> +	.unlocked_ioctl = pidfd_ioctl,
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo = pidfd_show_fdinfo,
>  #endif
> -- 
> 2.20.1
> 
