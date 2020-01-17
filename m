Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E38A314149B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 00:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgAQXGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 18:06:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgAQXGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9Jk4K6+zM/z+rUgtMCtvyK2a+37DJxesv3XUbh+Vyoo=; b=XsWkvrfrPz0fwoeslrk01HqaN
        t/J0vEDVfCPa22NNKmK4ZrrBhMoLiWe8tPPcTQ+zP9giX4JwiDBim7yjYEMV1+xrWMwfwDoqzG1wO
        WJwSh3Eyx2A/sqgTHute+MZ5pKxoUJvvizoOma6rwuLdGpw/kMabDGLzWGyi43U9YcG0RJnxZZNPR
        Pmh1uFYH9HFCGk2aVmfzG7+5sPxtomLpMcFjn+Rs3yQCTCcr7pkiSkWM9aCtsBq7Rv3TvyBiCJTdo
        47mGECZ4S/A3nZaMaXLWWsfyCTwPq/yzYIOiRlBJSQr5pYR2YVOFkFNWVkZ7uKw3Xu1Trr3SiR47G
        0vu5vxycw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isagk-000647-Bu; Fri, 17 Jan 2020 23:06:02 +0000
Date:   Fri, 17 Jan 2020 15:06:02 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, christian.brauner@ubuntu.com, oleg@redhat.com,
        luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: Re: [PATCH v8 2/3] pid: Introduce pidfd_getfd syscall
Message-ID: <20200117230602.GA31944@bombadil.infradead.org>
References: <20200103162928.5271-1-sargun@sargun.me>
 <20200103162928.5271-3-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103162928.5271-3-sargun@sargun.me>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 03, 2020 at 08:29:27AM -0800, Sargun Dhillon wrote:
> +++ b/kernel/pid.c
> @@ -578,3 +578,93 @@ void __init pid_idr_init(void)
>  	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
>  			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
>  }
> +
> +static struct file *__pidfd_fget(struct task_struct *task, int fd)
> +{
> +	struct file *file;
> +	int ret;
> +
> +	ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
> +		file = fget_task(task, fd);
> +	else
> +		file = ERR_PTR(-EPERM);
> +
> +	mutex_unlock(&task->signal->cred_guard_mutex);
> +
> +	return file ?: ERR_PTR(-EBADF);
> +}
> +
> +static int pidfd_getfd(struct pid *pid, int fd)
> +{
> +	struct task_struct *task;
> +	struct file *file;
> +	int ret;
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task)
> +		return -ESRCH;
> +
> +	file = __pidfd_fget(task, fd);
> +	put_task_struct(task);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	ret = security_file_receive(file);
> +	if (ret) {
> +		fput(file);
> +		return ret;
> +	}
> +
> +	ret = get_unused_fd_flags(O_CLOEXEC);
> +	if (ret < 0)
> +		fput(file);
> +	else
> +		fd_install(ret, file);
> +
> +	return ret;
> +}
> +
> +/**
> + * sys_pidfd_getfd() - Get a file descriptor from another process
> + *
> + * @pidfd:	the pidfd file descriptor of the process
> + * @fd:		the file descriptor number to get
> + * @flags:	flags on how to get the fd (reserved)
> + *
> + * This syscall gets a copy of a file descriptor from another process
> + * based on the pidfd, and file descriptor number. It requires that
> + * the calling process has the ability to ptrace the process represented
> + * by the pidfd. The process which is having its file descriptor copied
> + * is otherwise unaffected.
> + *
> + * Return: On success, a cloexec file descriptor is returned.
> + *         On error, a negative errno number will be returned.
> + */

We don't usually kernel-doc syscalls.  They should have manpages instead.

> +SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
> +		unsigned int, flags)
> +{
> +	struct pid *pid;
> +	struct fd f;
> +	int ret;
> +
> +	/* flags is currently unused - make sure it's unset */
> +	if (flags)
> +		return -EINVAL;

Is EINVAL the right errno here?  Often we use ENOSYS for bad flags to
syscalls.

> +	f = fdget(pidfd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	pid = pidfd_pid(f.file);
> +	if (IS_ERR(pid))
> +		ret = PTR_ERR(pid);
> +	else
> +		ret = pidfd_getfd(pid, fd);

You can simplify this by having pidfd_pid() return ERR_PTR(-EBADF) if
!f.file, and having pidfd_getfd() return PTR_ERR() if IS_ERR(pid).  Then
this function looks like:

	if (flags)
		return -EINVAL;

	f = fdget(pidfd);
	pid = pidfd_pid(f.file);
	ret = pidfd_getfd(pid, fd);
	fdput(f);
	return ret;

You could even eliminate the 'pid' variable and just do:

	ret = pidfd_getfd(pidfd_pid(f.file), fd);

but that's a step too far for me.

It's unfortunate that -EBADF might mean that either the first or second
argument is a bad fd number.  I'm not sure I have a good alternative though.
