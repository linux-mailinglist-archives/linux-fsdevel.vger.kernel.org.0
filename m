Return-Path: <linux-fsdevel+bounces-33076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689299B3503
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 16:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6732B21F18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E071B1DE4C0;
	Mon, 28 Oct 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5p0otVp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F7A12F585;
	Mon, 28 Oct 2024 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129679; cv=none; b=qBQ8EPd+Mw6FyuDDuAc8INwFHsEzE+4vqk2GxYAKp7klIxRWs/WPeJ7vCWJRiCdF5rtGG5NP2tALS8AHGJ2+rlHBcztcYqSxd8AO5tgPdaEE5sZ2dRZbLT/n6+akQW4Jam4j3EOaHyBPYFwA6EDcmrviRFU6H0GZ7qeuve8VXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129679; c=relaxed/simple;
	bh=/89yC2Iu3fktm/BJsaPrs5gU7sA22nLCmVLbjxgGTfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfLqCwPczkbvHBP10hD/F47BofLupmOIU+vjwgCjilhXXtnNdA0N9km3czUVaGyJ6o7F28rKB1b6vGbGn1Ou0uxXdYfguJUJR6iOOlvvM9odh2iO0uLUFjkA5Tj+8b1Umwb+ej/bR8ZjehxWksRCKnh809HVPLglh8VZ4Z4xytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5p0otVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6774C4CEC3;
	Mon, 28 Oct 2024 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730129678;
	bh=/89yC2Iu3fktm/BJsaPrs5gU7sA22nLCmVLbjxgGTfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5p0otVpR90xwm4rpftwflqf+4ntz2Wkntnikh6ai7qQE/voUADyYDfGdb7UOBisJ
	 57MGUACcSpm89rK3g5bmvlybz5aUQNWsuThEz5wTzblD4IV+/eSTqjHJRrKMhcDCB8
	 5tKJWZ2C/kZErkxWwtFVs01wnThqjWtdIIgFOlTxI9zYH2BdJaG5q6wSX8YTDb8rC6
	 WEnVGwhDxGXi0hIkfLxV3PmjW72ZXqqhy5nkgQ68lNzrbxTmRRYLZBM6KPAyR44BDO
	 Ti0gim9F4SLg0Qr5oNIilktAcpvZ/ddQAkS3wfNSZWmDEfIOVYdRFjMn2VYn9g32JL
	 gaUI1XqzhxUbA==
Date: Mon, 28 Oct 2024 16:34:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <20241028-gesoffen-drehmoment-5314faba9731@brauner>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
 <8eceec08eb64b744b24bf2aa09d4535e77e1ba47.1729926229.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ft377c7j3f5pvc3c"
Content-Disposition: inline
In-Reply-To: <8eceec08eb64b744b24bf2aa09d4535e77e1ba47.1729926229.git.lorenzo.stoakes@oracle.com>


--ft377c7j3f5pvc3c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Oct 26, 2024 at 08:24:58AM +0100, Lorenzo Stoakes wrote:
> It is useful to be able to utilise the pidfd mechanism to reference the
> current thread or process (from a userland point of view - thread group
> leader from the kernel's point of view).
> 
> Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
> PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.
> 
> For convenience and to avoid confusion from userland's perspective we alias
> these:
> 
> * PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
>   the user will want to use, as they would find it surprising if for
>   instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
>   and that failed.
> 
> * PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
>   have no concept of thread groups or what a thread group leader is, and
>   from userland's perspective and nomenclature this is what userland
>   considers to be a process.
> 
> Due to the refactoring of the central __pidfd_get_pid() function we can
> implement this functionality centrally, providing the use of this sentinel
> in most functionality which utilises pidfd's.
> 
> We need to explicitly adjust kernel_waitid_prepare() to permit this (though
> it wouldn't really make sense to use this there, we provide the ability for
> consistency).
> 
> We explicitly disallow use of this in setns(), which would otherwise have
> required explicit custom handling, as it doesn't make sense to set the
> current calling thread to join the namespace of itself.
> 
> As the callers of pidfd_get_pid() expect an increased reference count on
> the pid we do so in the self case, reducing churn and avoiding any breakage
> from existing logic which decrements this reference count.
> 
> This change implicitly provides PIDFD_SELF_* support in the waitid(P_PIDFS,
> ...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
> pidfd_getfd() system calls.
> 
> Things such as polling a pidfs and general fd operations are not supported,
> this strictly provides the sentinel for APIs which explicitly accept a
> pidfd.
> 
> Suggested-by: Pedro Falcato <pedro.falcato@gmail.com>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Currently, a pidfd based system call like pidfd_send_signal() would
simply do:

fdget(pidfd);
// use struct pid
fdput(pidfd);

Where the lifetime of @pid is guaranteed by @file. And in the regular
case where there's only a single thread the file code will avoid taking
a reference. Thus, there's no reference count bump on fdget(), nor a
drop on fdput(), nor a get_pid() or put_pid().

With your patch series you will always cause reference counts on @pid to
be taken for everyone. And I wouldn't be surprised if we get performance
regressions for this.

In one of my earlier mails I had mused about a fdput() like primitive.
What I roughly, hastily, and under the influence of the flu, sketched in
the _completey untested_ patch I appended illustrates roughly what I had
been thinking about.

>  include/linux/pid.h        |  8 ++++--
>  include/uapi/linux/pidfd.h | 10 ++++++++
>  kernel/exit.c              |  4 ++-
>  kernel/nsproxy.c           |  1 +
>  kernel/pid.c               | 51 ++++++++++++++++++++++++--------------
>  5 files changed, 53 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index d466890e1b35..3b2ac7567a88 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -78,11 +78,15 @@ struct file;
>   * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
>   *
>   * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
> - *              @alloc_proc is also set.
> + *              @alloc_proc is also set, or PIDFD_SELF_* to refer to the current
> + *              thread or thread group leader.
>   * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
>   *              of a pidfd, and this will be used to determine the pid.
> +
>   * @flags:      Output variable, if non-NULL, then the file->f_flags of the
> - *              pidfd will be set here.
> + *              pidfd will be set here or If PIDFD_SELF_THREAD is set, this is
> + *              set to PIDFD_THREAD, otherwise if PIDFD_SELF_THREAD_GROUP then
> + *              this is set to zero.
>   *
>   * Returns: If successful, the pid associated with the pidfd, otherwise an
>   *          error.
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 565fc0629fff..6fe1d63b2086 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -29,4 +29,14 @@
>  #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
>  #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
> 
> +/*
> + * Special sentinel values which can be used to refer to the current thread or
> + * thread group leader (which from a userland perspective is the process).
> + */
> +#define PIDFD_SELF		PIDFD_SELF_THREAD
> +#define PIDFD_SELF_PROCESS	PIDFD_SELF_THREAD_GROUP
> +
> +#define PIDFD_SELF_THREAD	-10000 /* Current thread. */
> +#define PIDFD_SELF_THREAD_GROUP	-20000 /* Current thread group leader. */
> +
>  #endif /* _UAPI_LINUX_PIDFD_H */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 619f0014c33b..e4f85ec4ba78 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -71,6 +71,7 @@
>  #include <linux/user_events.h>
>  #include <linux/uaccess.h>
> 
> +#include <uapi/linux/pidfd.h>
>  #include <uapi/linux/wait.h>
> 
>  #include <asm/unistd.h>
> @@ -1739,7 +1740,8 @@ int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
>  		break;
>  	case P_PIDFD:
>  		type = PIDTYPE_PID;
> -		if (upid < 0)
> +		if (upid < 0 && upid != PIDFD_SELF_THREAD &&
> +		    upid != PIDFD_SELF_THREAD_GROUP)
>  			return -EINVAL;
> 
>  		pid = pidfd_get_pid(upid, &f_flags);
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index dc952c3b05af..d239f7eeaa1f 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
>  	struct nsset nsset = {};
>  	int err = 0;
> 
> +	/* If fd is PIDFD_SELF_*, implicitly fail here, as invalid. */
>  	if (!fd_file(f))
>  		return -EBADF;
> 
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 94c97559e5c5..0a1861b4422c 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -535,33 +535,48 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
>  }
>  EXPORT_SYMBOL_GPL(find_ge_pid);
> 
> +static struct pid *pidfd_get_pid_self(unsigned int pidfd, unsigned int *flags)

The @flags argument is unused afaict.

> +{
> +	bool is_thread = pidfd == PIDFD_SELF_THREAD;
> +	enum pid_type type = is_thread ? PIDTYPE_PID : PIDTYPE_TGID;
> +	struct pid *pid = *task_pid_ptr(current, type);
> +
> +	/* The caller expects an elevated reference count. */
> +	get_pid(pid);
> +	return pid;
> +}

Fwiw, what you've done here is essentially reimplement the already
existing get_task_pid() helper that you could simply use.

> +
>  struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
>  			    unsigned int *flags)
>  {
> -	struct pid *pid;
> -	struct fd f = fdget(pidfd);
> -	struct file *file = fd_file(f);
> +	if (pidfd == PIDFD_SELF_THREAD || pidfd == PIDFD_SELF_THREAD_GROUP) {
> +		return pidfd_get_pid_self(pidfd, flags);
> +	} else {

I think the else can just go and we can save an indentation level.

> +		struct pid *pid;
> +		struct fd f = fdget(pidfd);
> +		struct file *file = fd_file(f);
> 
> -	if (!file)
> -		return ERR_PTR(-EBADF);
> +		if (!file)
> +			return ERR_PTR(-EBADF);
> 
> -	pid = pidfd_pid(file);
> -	/* If we allow opening a pidfd via /proc/<pid>, do so. */
> -	if (IS_ERR(pid) && allow_proc)
> -		pid = tgid_pidfd_to_pid(file);
> +		pid = pidfd_pid(file);
> +		/* If we allow opening a pidfd via /proc/<pid>, do so. */
> +		if (IS_ERR(pid) && allow_proc)
> +			pid = tgid_pidfd_to_pid(file);
> 
> -	if (IS_ERR(pid)) {
> +		if (IS_ERR(pid)) {
> +			fdput(f);
> +			return pid;
> +		}
> +
> +		/* Pin pid before we release fd. */
> +		get_pid(pid);
> +		if (flags)
> +			*flags = file->f_flags;
>  		fdput(f);
> +
>  		return pid;
>  	}
> -
> -	/* Pin pid before we release fd. */
> -	get_pid(pid);
> -	if (flags)
> -		*flags = file->f_flags;
> -	fdput(f);
> -
> -	return pid;
>  }
> 
>  /**
> --
> 2.47.0

--ft377c7j3f5pvc3c
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-UNTESTED-SKETCH-DRAFT.patch"

From 120b45b3900d28880b65b776f7a188cab4b38250 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 28 Oct 2024 15:34:59 +0100
Subject: [PATCH] UNTESTED, SKETCH, DRAFT

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c            | 42 +++++++++++++++++++++++++++++++++++++
 include/linux/pidfs.h | 29 +++++++++++++++++++++++++
 kernel/signal.c       | 49 ++++++++++++-------------------------------
 3 files changed, 84 insertions(+), 36 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 80675b6bf884..de7e9e6bbd22 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -22,6 +22,48 @@
 #include "internal.h"
 #include "mount.h"
 
+struct pid_fd pidfd_get(int fd)
+{
+	struct fd f;
+	struct pid *pid;
+
+	/* handle PIDFD_SELF_* cases */
+	if (fd < 0) {
+		if (fd == PIDFD_SELF_THREAD)
+			return (struct pid_fd){ .fd = EMPTY_FD, .pid = get_task_pid(current, PIDTYPE_PID) };
+		if (fd == PIDFD_SELF_THREAD_GROUP)
+			return (struct pid_fd){ .fd = EMPTY_FD, .pid = get_task_pid(current, PIDTYPE_TGID) };
+		return (struct pid_fd){ .fd = EMPTY_FD, .pid = ERR_PTR(-EBADF) };
+	}
+
+	/* handle the regular case */
+	f = fdget(fd);
+	if (!fd_file(f))
+		return (struct pid_fd){ .fd = EMPTY_FD, .pid = ERR_PTR(-EBADF) };
+
+	pid = pidfd_pid(fd_file(f));
+	if (IS_ERR(pid)) {
+		fdput(f);
+		return (struct pid_fd) { .fd = EMPTY_FD, .pid = pid };
+	}
+
+	return (struct pid_fd) { .fd = f, pid = pid } ;
+}
+
+void pidfd_put(struct pid_fd fd)
+{
+	/*
+	 * Handle PIDFD_SELF_* where the struct pid hasn't been attached
+	 * to a file.
+	 */
+	if (fd_empty(fd.fd) && pidfd_valid(fd))
+		put_pid(fd.pid);
+
+	/* Can call unconditionally safely. */
+	fdput(fd.fd);
+
+}
+
 #ifdef CONFIG_PROC_FS
 /**
  * pidfd_show_fdinfo - print information about a pidfd
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 75bdf9807802..ad86b69ee1ea 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -2,6 +2,35 @@
 #ifndef _LINUX_PID_FS_H
 #define _LINUX_PID_FS_H
 
+#include <linux/file.h>
+#include <linux/cleanup.h>
+
+#define PIDFD_SELF           PIDFD_SELF_THREAD
+#define PIDFD_SELF_PROCESS   PIDFD_SELF_THREAD_GROUP
+
+#define PIDFD_SELF_THREAD		-10000 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP		-20000 /* Current thread group leader. */
+
+struct pid_fd {
+	struct fd fd;
+	struct pid *pid;
+};
+
+static inline struct pid *pid_fd_pid(struct pid_fd pfd)
+{
+	return pfd.pid;
+}
+
+static inline bool pidfd_valid(struct pid_fd pfd)
+{
+	return !IS_ERR(pid_fd_pid(pfd));
+}
+
+struct pid_fd pidfd_get(int fd);
+void pidfd_put(struct pid_fd fd);
+
+DEFINE_CLASS(pid_fd, struct pid_fd, pidfd_put(_T), pidfd_get(fd), int fd)
+
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 4344860ffcac..16b10e726038 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -47,6 +47,7 @@
 #include <linux/cgroup.h>
 #include <linux/audit.h>
 #include <linux/sysctl.h>
+#include <linux/pidfs.h>
 #include <uapi/linux/pidfd.h>
 
 #define CREATE_TRACE_POINTS
@@ -3875,17 +3876,6 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
 	return copy_siginfo_from_user(kinfo, info);
 }
 
-static struct pid *pidfd_to_pid(const struct file *file)
-{
-	struct pid *pid;
-
-	pid = pidfd_pid(file);
-	if (!IS_ERR(pid))
-		return pid;
-
-	return tgid_pidfd_to_pid(file);
-}
-
 #define PIDFD_SEND_SIGNAL_FLAGS                            \
 	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
 	 PIDFD_SIGNAL_PROCESS_GROUP)
@@ -3908,7 +3898,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		siginfo_t __user *, info, unsigned int, flags)
 {
 	int ret;
-	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
@@ -3921,25 +3910,18 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
-	/* Is this a pidfd? */
-	pid = pidfd_to_pid(fd_file(f));
-	if (IS_ERR(pid)) {
-		ret = PTR_ERR(pid);
-		goto err;
-	}
+	CLASS(pid_fd, pid_fd)(pidfd);
+	if (!pidfd_valid(pid_fd))
+		return PTR_ERR(pid_fd_pid(pid_fd));
 
-	ret = -EINVAL;
+	pid = pid_fd_pid(pid_fd);
 	if (!access_pidfd_pidns(pid))
-		goto err;
+		return -EINVAL;
 
 	switch (flags) {
 	case 0:
 		/* Infer scope from the type of pidfd. */
-		if (fd_file(f)->f_flags & PIDFD_THREAD)
+		if (pidfd > 0 && fd_file(pid_fd.fd)->f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
@@ -3958,28 +3940,23 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (info) {
 		ret = copy_siginfo_from_user_any(&kinfo, info);
 		if (unlikely(ret))
-			goto err;
+			return ret;
 
-		ret = -EINVAL;
 		if (unlikely(sig != kinfo.si_signo))
-			goto err;
+			return -EINVAL;
 
 		/* Only allow sending arbitrary signals to yourself. */
-		ret = -EPERM;
 		if ((task_pid(current) != pid || type > PIDTYPE_TGID) &&
 		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
-			goto err;
+			return -EPERM;
 	} else {
 		prepare_kill_siginfo(sig, &kinfo, type);
 	}
 
 	if (type == PIDTYPE_PGID)
-		ret = kill_pgrp_info(sig, &kinfo, pid);
-	else
-		ret = kill_pid_info_type(sig, &kinfo, pid, type);
-err:
-	fdput(f);
-	return ret;
+		return kill_pgrp_info(sig, &kinfo, pid);
+
+	return kill_pid_info_type(sig, &kinfo, pid, type);
 }
 
 static int
-- 
2.45.2


--ft377c7j3f5pvc3c--

