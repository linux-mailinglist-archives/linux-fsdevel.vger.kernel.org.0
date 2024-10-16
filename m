Return-Path: <linux-fsdevel+bounces-32111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39999A0AE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 15:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64925286F83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6B8208D9F;
	Wed, 16 Oct 2024 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbCCAoz9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485922076D3;
	Wed, 16 Oct 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083661; cv=none; b=hoAuxmCLgzO9LCZ9I6PEIvbZqaepLVQG4F/uwWbtlespjtpMf1tIq0lcLjMpyFNbA8hBss5Q38Mk99Qc7jIflBhlu7T5qt2BaFTiAlZt/3rjNyXPk7c1DmwqgZc17e0Iu5tqRrFFSfTkeFfWxqtwS5c529o4ULLWY6hXv/+4c0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083661; c=relaxed/simple;
	bh=AQJQ52Y20rrXyjBF5uA6GMPy25kJ+zP7PIIyA12Eb3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rlmz2D0QihYWnPz5BxLdxsa1bngr7qwiwoV9sjtvdYh7nxH+GdpxsE9eI8tVqwtftly9rt108GNMVdi4ELuYuLrRjbGUQG/t8ASEJva51mJJS68tZ+NyERUYYtHzH20sXBTkRtR1yQ0qW6+JnFFk07os9mJvaf9YhD3QluH0p98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbCCAoz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C835C4CEC5;
	Wed, 16 Oct 2024 13:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729083660;
	bh=AQJQ52Y20rrXyjBF5uA6GMPy25kJ+zP7PIIyA12Eb3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbCCAoz9IPzUFd0JxerVoaRYzpOHduc/0PJ3//oseEfrW6BiFMorA52SizQt+i2J0
	 j0WF9CQeyKct+P6ac4KIqCFwWwe0oxF+6gPZQrqYrld2oeGl9qahJBNO8wq5wYTvqg
	 rL0moXxOCkQsXtrWfFVgDUVNgFsB/FVz8BsLElT7GGSc4oViW0hxHXvKBOSR69VbTV
	 gikoiDIhAKJ7lM9b05AHuvqtF00Yif/Og2PEz55P/DkY02nJdIFy/jdTQcxCgmMDZP
	 ckTrF481yJH4oZpOY4H0avaJW+RDYgUnm5E/O+a+oOv3F97GvcGEnHzLXNq3z+OBSW
	 Ps+Ne3e+9elUg==
Date: Wed, 16 Oct 2024 15:00:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate
 pid lookup
Message-ID: <20241016-beinbruch-zeltplatz-4bfdedca1ee8@brauner>
References: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
 <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>

On Fri, Oct 11, 2024 at 12:05:55PM +0100, Lorenzo Stoakes wrote:
> The means by which a pid is determined from a pidfd is duplicated, with
> some callers holding a reference to the (pid)fd, and others explicitly
> pinning the pid.
> 
> Introduce __pidfd_get_pid() which abstracts both approaches and provide
> optional output parameters for file->f_flags and the fd (the latter of
> which, if provided, prevents the function from decrementing the fd's
> refernce count).
> 
> Additionally, allow the ability to open a pidfd by opening a /proc/<pid>
> directory, utilised by the pidfd_send_signal() system call, providing a
> pidfd_get_pid_proc() helper function to do so.
> 
> Doing this allows us to eliminate open-coded pidfd pid lookup and to
> consistently handle this in one place.
> 
> This lays the groundwork for a subsequent patch which adds a new sentinel
> pidfd to explicitly reference the current process (i.e. thread group
> leader) without the need for a pidfd.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/pid.h | 42 +++++++++++++++++++++++++++++++-
>  kernel/pid.c        | 58 ++++++++++++++++++++++++++++++---------------
>  kernel/signal.c     | 22 ++++-------------
>  3 files changed, 84 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index a3aad9b4074c..68b02eab7509 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_PID_H
>  #define _LINUX_PID_H
>  
> +#include <linux/file.h>
>  #include <linux/pid_types.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> @@ -72,8 +73,47 @@ extern struct pid init_struct_pid;
>  
>  struct file;
>  
> +
> +/**
> + * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
> + *
> + * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
> + *              @alloc_proc is also set.
> + * @pin_pid:    If set, then the reference counter of the returned pid is
> + *              incremented. If not set, then @fd should be provided to pin the
> + *              pidfd.
> + * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
> + *              of a pidfd, and this will be used to determine the pid.
> + * @flags:      Output variable, if non-NULL, then the file->f_flags of the
> + *              pidfd will be set here.
> + * @fd:         Output variable, if non-NULL, then the pidfd reference will
> + *              remain elevated and the caller will need to decrement it
> + *              themselves.
> + *
> + * Returns: If successful, the pid associated with the pidfd, otherwise an
> + *          error.
> + */
> +struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
> +			    bool allow_proc, unsigned int *flags,
> +			    struct fd *fd);
> +
> +static inline struct pid *pidfd_get_pid(unsigned int pidfd, unsigned int *flags)
> +{
> +	return __pidfd_get_pid(pidfd, /* pin_pid = */ true,
> +			       /* allow_proc = */ false,
> +			       flags, /* fd = */ NULL);
> +}
> +
> +static inline struct pid *pidfd_to_pid_proc(unsigned int pidfd,
> +					    unsigned int *flags,
> +					    struct fd *fd)
> +{
> +	return __pidfd_get_pid(pidfd, /* pin_pid = */ false,
> +			       /* allow_proc = */ true,
> +			       flags, fd);
> +}
> +
>  struct pid *pidfd_pid(const struct file *file);
> -struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
>  struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
>  void do_notify_pidfd(struct task_struct *task);
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 2715afb77eab..25cc1c36a1b1 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -36,6 +36,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/init_task.h>
>  #include <linux/syscalls.h>
> +#include <linux/proc_fs.h>
>  #include <linux/proc_ns.h>
>  #include <linux/refcount.h>
>  #include <linux/anon_inodes.h>
> @@ -534,22 +535,46 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
>  }
>  EXPORT_SYMBOL_GPL(find_ge_pid);
>  
> -struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
> +struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
> +			    bool allow_proc, unsigned int *flags,
> +			    struct fd *fd)

Hm, we should never return a struct fd. A struct fd is an inherently
scoped-bound concept - or at least aims to be. Simply put, we always
want to have the fdget() and the fdput() in the same scope as the file
pointer you can access via fd_file() is only valid as long as we're in
the syscall.

Ideally we mostly use CLASS(fd/fd_raw) and nearly never fdget(). The
point is that this is the wrong api to expose.

It would probably be wiser if you added a pidfd based fdget() inspired
primitive.

