Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD86125EC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 11:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLSKXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 05:23:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37092 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfLSKXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:23:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so5017394wmf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2019 02:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FtSfxL3ZTjUPPjgZsoN7HkyUwMbWuF7qj1Z+RFdee5c=;
        b=eqNjrupcSJFAoE4dyiw7PStExydc3tBkqPtUaSPhhKY1t14tKF9hVHR1ZsvNEpVOh7
         yhXvxxXYTFBzCvZVMkOXffRTLXKXmNrBG6G329V6ntc8t0fuSdZ/5XUwP/fv0OCX4kmu
         3+aJV8fFkvO72v4kzPzDq9mEkwQ0CMF5h0rSZoxx/QDKbIpKKKpn4SisjgRu9ioR6dBs
         LOhXowfrr4XoAN/cMVRlIDry64KlXvUinCBOyIRQ1WmvC5R1chK7f9cbkIgc48uSHbjU
         2TKgCAlPMyjQTKhiWbPwspUrm370yHfrmokYEIpj6oQYVCPssNYGP2AXR3RLYjM+Gfy9
         4zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FtSfxL3ZTjUPPjgZsoN7HkyUwMbWuF7qj1Z+RFdee5c=;
        b=P1UeXmsDVjFBX1fchwQdXDdcgvPXi6zSBhHExxctsc+RMMuk66yqwje0l9NVpJIWjJ
         E8fWJC6fGGbYsmiGJyXsLQUjJAbsadZUZXdz8+5FrFCDsG9JgmLC8yq8piQPAW7/a0pG
         2AsKgTQvVlfLSPWdZbi0JMOMOqrhRAS0nCHgRMJD2gwLkiQTtQMjigZDseJmZnu5oqWH
         uyEV0QWpHUWEzqIvrKASPbSA2SIbsJawXa4CuyZIrYhaI4qhJRdwijM74bIgACVMzjQi
         gXddj/cTqenogNJhQVnyaDp8FOmXTwlCah3GOIVY1s4WhwF/itsi7pD7fR6+RG1oA2IT
         os3A==
X-Gm-Message-State: APjAAAVKNEThrztkNl51LB/b3b35SdHfmL3nYBrsgNhHF7kq2oFsgy4Y
        TsnodJRX1NX2Ey/6jCtEQuOJtQ==
X-Google-Smtp-Source: APXvYqz6o3cgU+Uct28FpOMtrlLC+k94DAXnX5466b+AwQmrST1aj4PbqlPpAoX9KAA1wEkyM7X/zw==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr8958731wmc.112.1576750985027;
        Thu, 19 Dec 2019 02:23:05 -0800 (PST)
Received: from brauner.io ([79.140.121.60])
        by smtp.gmail.com with ESMTPSA id m3sm5777360wrs.53.2019.12.19.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 02:23:04 -0800 (PST)
Date:   Thu, 19 Dec 2019 11:23:03 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, christian.brauner@ubuntu.com, oleg@redhat.com,
        luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
Message-ID: <20191219102300.lqhxhalpa6ai4t5x@brauner.io>
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:55:01PM +0000, Sargun Dhillon wrote:
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

I think that whole part can go now. :)

The rest is just nits (see below).

> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>  MAINTAINERS                                   |  1 +
>  include/uapi/linux/pidfd.h                    | 10 +++
>  kernel/fork.c                                 | 77 +++++++++++++++++++
>  4 files changed, 89 insertions(+)
>  create mode 100644 include/uapi/linux/pidfd.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 4ef86433bd67..9f9be681662b 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -273,6 +273,7 @@ Code  Seq#    Include File                                           Comments
>                                                                       <mailto:tim@cyberelk.net>
>  'p'   A1-A5  linux/pps.h                                             LinuxPPS
>                                                                       <mailto:giometti@linux.it>
> +'p'   B0-CF  linux/pidfd.h
>  'q'   00-1F  linux/serio.h
>  'q'   80-FF  linux/telephony.h                                       Internet PhoneJACK, Internet LineJACK
>               linux/ixjuser.h                                         <http://web.archive.org/web/%2A/http://www.quicknet.net>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc0a4a8ae06a..bc370ff59dbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13014,6 +13014,7 @@ M:	Christian Brauner <christian@brauner.io>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
> +F:	include/uapi/linux/pidfd.h
>  F:	samples/pidfd/
>  F:	tools/testing/selftests/pidfd/
>  F:	tools/testing/selftests/clone3/
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> new file mode 100644
> index 000000000000..90ff535be048
> --- /dev/null
> +++ b/include/uapi/linux/pidfd.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_PID_H
> +#define _UAPI_LINUX_PID_H

I think that wants to be

#ifndef _UAPI_LINUX_PIDFD_H

> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define PIDFD_IOCTL_GETFD	_IOWR('p', 0xb0, __u32)

As Arnd mentioned, this defines a read-write ioctl where it just needs
to be a read-ioctl.

> +
> +#endif /* _UAPI_LINUX_PID_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2508a4f238a3..09b5f233b5a8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -94,6 +94,7 @@
>  #include <linux/thread_info.h>
>  #include <linux/stackleak.h>
>  #include <linux/kasan.h>
> +#include <uapi/linux/pidfd.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -1790,9 +1791,85 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  	return poll_flags;
>  }
>  
> +static struct file *__pidfd_getfd_fget_task(struct task_struct *task, u32 fd)
> +{
> +	struct file *file;
> +	int ret;
> +
> +	ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> +		file = ERR_PTR(-EPERM);
> +		goto out;
> +	}
> +
> +	file = fget_task(task, fd);
> +	if (!file)
> +		file = ERR_PTR(-EBADF);
> +
> +out:
> +	mutex_unlock(&task->signal->cred_guard_mutex);
> +	return file;
> +}
> +
> +static long pidfd_getfd(struct pid *pid, u32 fd)
> +{
> +	struct task_struct *task;
> +	struct file *file;
> +	int ret, retfd;
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task)
> +		return -ESRCH;
> +
> +	file = __pidfd_getfd_fget_task(task, fd);
> +	put_task_struct(task);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	retfd = get_unused_fd_flags(O_CLOEXEC);
> +	if (retfd < 0) {
> +		ret = retfd;
> +		goto out;
> +	}
> +
> +	/*
> +	 * security_file_receive must come last since it may have side effects
> +	 * and cannot be reversed.
> +	 */
> +	ret = security_file_receive(file);
> +	if (ret)
> +		goto out_put_fd;
> +
> +	fd_install(retfd, file);
> +	return retfd;
> +
> +out_put_fd:
> +	put_unused_fd(retfd);
> +out:
> +	fput(file);
> +	return ret;
> +}
> +
> +static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct pid *pid = file->private_data;
> +
> +	switch (cmd) {
> +	case PIDFD_IOCTL_GETFD:
> +		return pidfd_getfd(pid, arg);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  const struct file_operations pidfd_fops = {
>  	.release = pidfd_release,
>  	.poll = pidfd_poll,
> +	.unlocked_ioctl = pidfd_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo = pidfd_show_fdinfo,
>  #endif
> -- 
> 2.20.1
> 
