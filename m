Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1E91169A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 10:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfLIJjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 04:39:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39672 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfLIJjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:39:49 -0500
Received: from [79.140.120.104] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ieFW6-000194-Ab; Mon, 09 Dec 2019 09:39:46 +0000
Date:   Mon, 9 Dec 2019 10:39:45 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 2/4] ptrace: add PTRACE_GETFD request to fetch file
 descriptors from tracees
Message-ID: <20191209093944.g6lgt2cqkec7eaym@wittgenstein>
References: <20191209070621.GA32450@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209070621.GA32450@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 09, 2019 at 07:06:24AM +0000, Sargun Dhillon wrote:
> PTRACE_GETFD is a generic ptrace API that allows the tracer to
> get file descriptors from the tracee.
> 
> One reason to use this is to allow sandboxers to take actions on file
> descriptors on the behalf of a tracee. For example, this can be
> combined with seccomp-bpf's user notification to ptrace on-demand and
> capture an fd without requiring the tracer to always be attached to
> the process. The tracer can then take a privileged action on behalf
> of the tracee, like binding a socket to a privileged port.
> 
> It works whether or not the tracee is stopped. The only prior requirement
> is that the tracer is attached to the process via PTRACE_ATTACH or
> PTRACE_SEIZE. Stopping the process breaks certain runtimes that expect
> to be able to preempt syscalls (quickly). In addition, it is meant to be
> used in an on-demand fashion to avoid breaking debuggers.
> 
> The ptrace call takes a pointer to ptrace_getfd_args in data, and the
> size of the structure in addr. There is an options field, which can
> be used to state whether the fd should be opened with CLOEXEC, or not.
> This options field may be extended in the future to include the ability
> to clear cgroup information about the file descriptor at a later point.
> If the structure is from a newer kernel, and includes members which
> make it larger than the structure that's known to this kernel version,
> E2BIG will be returned.
> 
> The requirement that the tracer has attached to the tracee prior to the
> capture of the file descriptor may be lifted at a later point.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  include/uapi/linux/ptrace.h | 15 +++++++++++++++
>  kernel/ptrace.c             | 35 +++++++++++++++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index a71b6e3b03eb..c84655bcc453 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -101,6 +101,21 @@ struct ptrace_syscall_info {
>  	};
>  };
>  
> +/*
> + * This gets a file descriptor from a process. It requires that the process
> + * has either been attached to. It does not require that the process is
> + * stopped.
> + */
> +#define PTRACE_GETFD	0x420f
> +
> +/* options to pass in to ptrace_getfd_args */
> +#define PTRACE_GETFD_O_CLOEXEC	(1 << 0)	/* open the fd with cloexec */

Hey Sargun,

Thanks for the patch!

Why not simply accept O_CLOEXEC as flag? If that's not possible for some
reason I'd say

#define PTRACE_GETFD_O_CLOEXEC	O_CLOEXEC	/* open the fd with cloexec */

is the right thing to do. This is fairly common:

include/uapi/linux/timerfd.h:#define TFD_CLOEXEC O_CLOEXEC
include/uapi/drm/drm.h:#define DRM_CLOEXEC O_CLOEXEC
include/linux/userfaultfd_k.h:#define UFFD_CLOEXEC O_CLOEXEC
include/linux/eventfd.h:#define EFD_CLOEXEC O_CLOEXEC
include/uapi/linux/eventpoll.h:#define EPOLL_CLOEXEC O_CLOEXEC
include/uapi/linux/inotify.h:/* For O_CLOEXEC and O_NONBLOCK */
include/uapi/linux/inotify.h:#define IN_CLOEXEC O_CLOEXEC
include/uapi/linux/mount.h:#define OPEN_TREE_CLOEXEC    O_CLOEXEC       /* Close the file on execve() */

You can also add a compile-time assert to ptrace like we did for
fs/namespace.c's OPEN_TREE_CLOEXEC:
	BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);

And I'd remove the  _O if you go with a separate flag, i.e.:

#define PTRACE_GETFD_CLOEXEC	O_CLOEXEC	/* open the fd with cloexec */

> +
> +struct ptrace_getfd_args {
> +	__u32 fd;	/* the tracee's file descriptor to get */
> +	__u32 options;

Nit and I'm not set on it at all but "flags" might just be better.

> +} __attribute__((packed));

What's the benefit in using __attribute__((packed)) here? Seems to me that:

+struct ptrace_getfd_args {
+	__u32 fd;	/* the tracee's file descriptor to get */
+	__u32 options;
+};

would just work fine.

> +
>  /*
>   * These values are stored in task->ptrace_message
>   * by tracehook_report_syscall_* to describe the current syscall-stop.
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index cb9ddcc08119..8f619dceac6f 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -31,6 +31,7 @@
>  #include <linux/cn_proc.h>
>  #include <linux/compat.h>
>  #include <linux/sched/signal.h>
> +#include <linux/fdtable.h>
>  
>  #include <asm/syscall.h>	/* for syscall_get_* */
>  
> @@ -994,6 +995,33 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
>  }
>  #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
>  
> +static int ptrace_getfd(struct task_struct *child, unsigned long user_size,
> +			void __user *datavp)
> +{
> +	struct ptrace_getfd_args args;
> +	unsigned int fd_flags = 0;
> +	struct file *file;
> +	int ret;
> +
> +	ret = copy_struct_from_user(&args, sizeof(args), datavp, user_size);
> +	if (ret)
> +		goto out;

Why is this goto out and not just return ret?

> +	if ((args.options & ~(PTRACE_GETFD_O_CLOEXEC)) != 0)
> +		return -EINVAL;
> +	if (args.options & PTRACE_GETFD_O_CLOEXEC)
> +		fd_flags &= O_CLOEXEC;
> +	file = get_task_file(child, args.fd);
> +	if (!file)
> +		return -EBADF;
> +	ret = get_unused_fd_flags(fd_flags);

Why isn't that whole thing just:

ret = get_unused_fd_flags(fd_flags & {PTRACE_GETFD_}O_CLOEXEC);

> +	if (ret >= 0)
> +		fd_install(ret, file);
> +	else
> +		fput(file);
> +out:
> +	return ret;
> +}

So sm like:

static int ptrace_getfd(struct task_struct *child, unsigned long user_size,
			void __user *datavp)
{
	struct ptrace_getfd_args args;
	unsigned int fd_flags = 0;
	struct file *file;
	int ret;

	ret = copy_struct_from_user(&args, sizeof(args), datavp, user_size);
	if (ret)
		return ret;

	if ((args.options & ~(PTRACE_GETFD_O_CLOEXEC)) != 0)
		return -EINVAL;

	file = get_task_file(child, args.fd);
	if (!file)
		return -EBADF;

	/* PTRACE_GETFD_CLOEXEC == O_CLOEXEC */
	ret = get_unused_fd_flags(fd_flags & PTRACE_GETFD_O_CLOEXEC);
	if (ret >= 0)
		fd_install(ret, file);
	else
		fput(file);

	return ret;
}
