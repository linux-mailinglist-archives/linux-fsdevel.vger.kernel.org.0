Return-Path: <linux-fsdevel+bounces-49144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73067AB88EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDE57AA757
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573C91AAE13;
	Thu, 15 May 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="LUvJyP/4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E319D08F
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318108; cv=none; b=qU88Abzj0hpPW0g40N+JRWlmGgJJXYlCLD94XJLI91hP3OAZeklvTH0i6OsCKcHm9jXK79UAjEIR4axS5YM3HKsAoN68PMbO89CeoKqyhzb9ceqvizxBaKzCrDwx5KTr6zN7a1zyV9HcyDF2lSWFb6vIW8N4ymd9KGtUyQXCqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318108; c=relaxed/simple;
	bh=9VmEHRvbOUYY2kOCO7kEzLjU7lCkScd3CaiU4PIIzdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7SndpJxLVgVpZmXuryQLzC7//CG0U2plY3TAxWChpLRYCnOlj2w6UKmJUb/uTkHLIMWze+w3FXh55l2Pndpbp+o/bW48FZrcgOUEB2/s7NiLwxpQeHLilbFqscuzrLgjA6QmCGmzTFqbBTYBbZIoN/ljwBxNS1ebsvbtiu3EPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=LUvJyP/4; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso8523251fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747318105; x=1747922905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zlNPK/1z36znT+gkUbgbVHXLqL8fwZcYFOdBbadwik4=;
        b=LUvJyP/419hEuiW3lsr6iCX+MBEUw9vtrL1a6FCdHBe8ZbZD7QbvW/I9i33vQNLfmW
         KDELluXcESBfeW9Bkfed6TEc08Os3lsGKNWdD2vv8fSUWUTjI8bhDm4wOWfgvnSXX8nX
         ckd8pNDi6K0CbDuOz/mxAQqoosCQISFFBg6n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747318105; x=1747922905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlNPK/1z36znT+gkUbgbVHXLqL8fwZcYFOdBbadwik4=;
        b=XrKSpaLtq05LF1WZQhaMUZDg5xLn0fxI+IKl/EPy7LmiU8U/mSQyoRTOhSwdZriodZ
         pLjt7MNPwe3mVXfPgCyhmFRoeY1imwvh532WHMn28+NFzjfrxC+jOYa0K5hBFRApQVLF
         lO3d6TShQGKbo2OgSkpgdXm6kCYL0y8Fy8m9EWmt0jN3C3W9hD1Gfh8ODtXrDSI5LOv5
         WYDkok07alz1D82S4N0VjNKAj2adht2JsF8PO+K3ktLCyb8fSXN7zF6WG6tbm7fc3Zh/
         BdbBWstkO/xsI6jJDVvD9CYrcG4x2q0YuoDqnkfuoMOcsAHghfnOSWnkm7gqj2KMbslE
         TbZA==
X-Gm-Message-State: AOJu0Yx/n+/+Zo7YXhvkQIDTMcQf3VKAl1qceU5dbdoXe3pNfmzLuzle
	1R5fw/gbDpwhe+V1AkbVybgt7g9rS2sCR1wZ+PGTweSZq4ctdZAoDCg3HrDLcO1Jkxl+TW3Fx2G
	9s7I/O36Bx7XBRtqO4Cm9LbKAMP+VtsB29KEEsg==
X-Gm-Gg: ASbGncskVtW81+wGFG2OhQARKk+2RncWR01IPvilWGCZsulv05P4RR2ATMyCH1pUTkf
	nYmC9s+wZH2UuqAs/ySAiF7+XgEMN/WVQUvyQ0utzSIpIFdYNKs5HtcVq4LD2jB9628/r6FI1ah
	h7haiB6LmzdHNTrDPbOL88zLDX2tW0G7xwJA==
X-Google-Smtp-Source: AGHT+IGG20PtI++hE8yDk6QEBSUwuUvn9V5k/Nv6PNWbTdXdi8Qzd9UzXUUJl23CSX4iciWSDusCvlA50MDj88zA+Bo=
X-Received: by 2002:a2e:a9a2:0:b0:31c:d57e:b6f6 with SMTP id
 38308e7fff4ca-327fabc40e9mr11042271fa.8.1747318104365; Thu, 15 May 2025
 07:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-5-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-5-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 16:08:13 +0200
X-Gm-Features: AX0GCFtEFde-SVXMph4csubR6h1lBYhA7PILE7qan5SniY73PDOxFcp0KliU8N8
Message-ID: <CAJqdLrrNxYGmdZdt_1oTeXw40Ox1D5TQAWtYjweT0AUMLs7mRQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] pidfs, coredump: add PIDFD_INFO_COREDUMP
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Extend the PIDFD_INFO_COREDUMP ioctl() with the new PIDFD_INFO_COREDUMP
> mask flag. This adds the fields @coredump_mask and @coredump_cookie to
> struct pidfd_info.
>
> When a task coredumps the kernel will provide the following information
> to userspace in @coredump_mask:
>
> * PIDFD_COREDUMPED is raised if the task did actually coredump.
> * PIDFD_COREDUMP_SKIP is raised if the task skipped coredumping (e.g.,
>   undumpable).
> * PIDFD_COREDUMP_USER is raised if this is a regular coredump and
>   doesn't need special care by the coredump server.
> * PIDFD_COREDUMP_ROOT is raised if the generated coredump should be
>   treated as sensitive and the coredump server should restrict to the
>   generated coredump to sufficiently privileged users.
>
> If userspace uses the coredump socket to process coredumps it needs to
> be able to discern connection from the kernel from connects from
> userspace (e.g., Python generating it's own coredumps and forwarding
> them to systemd). The @coredump_cookie extension uses the SO_COOKIE of
> the new connection. This allows userspace to validate that the
> connection has been made from the kernel by a crashing task:
>
>    fd_coredump = accept4(fd_socket, NULL, NULL, SOCK_CLOEXEC);
>    getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd, &fd_peer_pidfd_len);
>
>    struct pidfd_info info = {
>            info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
>    };
>
>    ioctl(pidfd, PIDFD_GET_INFO, &info);
>    /* Refuse connections that aren't from a crashing task. */
>    if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED) )
>            close(fd_coredump);
>
>    /*
>     * Make sure that the coredump cookie matches the connection cookie.
>     * If they don't it's not the coredump connection from the kernel.
>     * We'll get another connection request in a bit.
>     */
>    getsocketop(fd_coredump, SOL_SOCKET, SO_COOKIE, &peer_cookie, &peer_cookie_len);
>    if (!info.coredump_cookie || (info.coredump_cookie != peer_cookie))
>            close(fd_coredump);
>
> The kernel guarantees that by the time the connection is made the all
> PIDFD_INFO_COREDUMP info is available.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c              | 34 ++++++++++++++++++++
>  fs/pidfs.c                 | 79 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pidfs.h      | 10 ++++++
>  include/uapi/linux/pidfd.h | 22 +++++++++++++
>  net/unix/af_unix.c         |  7 ++++
>  5 files changed, 152 insertions(+)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index e1256ebb89c1..bfc4a32f737c 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -46,7 +46,9 @@
>  #include <linux/pidfs.h>
>  #include <linux/net.h>
>  #include <linux/socket.h>
> +#include <net/af_unix.h>
>  #include <net/net_namespace.h>
> +#include <net/sock.h>
>  #include <uapi/linux/pidfd.h>
>  #include <uapi/linux/un.h>
>
> @@ -598,6 +600,8 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
>                 if (IS_ERR(pidfs_file))
>                         return PTR_ERR(pidfs_file);
>
> +               pidfs_coredump(cp);
> +
>                 /*
>                  * Usermode helpers are childen of either
>                  * system_unbound_wq or of kthreadd. So we know that
> @@ -876,8 +880,34 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                         goto close_fail;
>                 }
>
> +               /*
> +                * Set the thread-group leader pid which is used for the
> +                * peer credentials during connect() below. Then
> +                * immediately register it in pidfs...
> +                */
> +               cprm.pid = task_tgid(current);
> +               retval = pidfs_register_pid(cprm.pid);
> +               if (retval) {
> +                       sock_release(socket);
> +                       goto close_fail;
> +               }
> +
> +               /*
> +                * ... and set the coredump information so userspace
> +                * has it available after connect()...
> +                */
> +               pidfs_coredump(&cprm);
> +
> +               /*
> +                * ... On connect() the peer credentials are recorded
> +                * and @cprm.pid registered in pidfs...
> +                */
>                 retval = kernel_connect(socket, (struct sockaddr *)(&addr),
>                                         addr_len, O_NONBLOCK | SOCK_COREDUMP);
> +
> +               /* ... So we can safely put our pidfs reference now... */
> +               pidfs_put_pid(cprm.pid);
> +
>                 if (retval) {
>                         if (retval == -EAGAIN)
>                                 coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
> @@ -886,6 +916,10 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                         goto close_fail;
>                 }
>
> +               /* ... and validate that @sk_peer_pid matches @cprm.pid. */
> +               if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid != cprm.pid))
> +                       goto close_fail;
> +
>                 cprm.limit = RLIM_INFINITY;
>                 cprm.file = no_free_ptr(file);
>  #else
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 3b39e471840b..d7b9a0dd2db6 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -20,6 +20,7 @@
>  #include <linux/time_namespace.h>
>  #include <linux/utsname.h>
>  #include <net/net_namespace.h>
> +#include <linux/coredump.h>
>
>  #include "internal.h"
>  #include "mount.h"
> @@ -33,6 +34,8 @@ static struct kmem_cache *pidfs_cachep __ro_after_init;
>  struct pidfs_exit_info {
>         __u64 cgroupid;
>         __s32 exit_code;
> +       __u32 coredump_mask;
> +       __u64 coredump_cookie;
>  };
>
>  struct pidfs_inode {
> @@ -240,6 +243,22 @@ static inline bool pid_in_current_pidns(const struct pid *pid)
>         return false;
>  }
>
> +static __u32 pidfs_coredump_mask(unsigned long mm_flags)
> +{
> +       switch (__get_dumpable(mm_flags)) {
> +       case SUID_DUMP_USER:
> +               return PIDFD_COREDUMP_USER;
> +       case SUID_DUMP_ROOT:
> +               return PIDFD_COREDUMP_ROOT;
> +       case SUID_DUMP_DISABLE:
> +               return PIDFD_COREDUMP_SKIP;
> +       default:
> +               WARN_ON_ONCE(true);
> +       }
> +
> +       return 0;
> +}
> +
>  static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>         struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> @@ -280,6 +299,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>                 }
>         }
>
> +       if (mask & PIDFD_INFO_COREDUMP) {
> +               kinfo.mask |= PIDFD_INFO_COREDUMP;
> +               smp_rmb();
> +               kinfo.coredump_cookie = READ_ONCE(pidfs_i(inode)->__pei.coredump_cookie);
> +               kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
> +       }
> +
>         task = get_pid_task(pid, PIDTYPE_PID);
>         if (!task) {
>                 /*
> @@ -296,6 +322,16 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         if (!c)
>                 return -ESRCH;
>
> +       if (!(kinfo.mask & PIDFD_INFO_COREDUMP)) {
> +               task_lock(task);
> +               if (task->mm) {
> +                       smp_rmb();
> +                       kinfo.coredump_cookie = READ_ONCE(pidfs_i(inode)->__pei.coredump_cookie);
> +                       kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
> +               }
> +               task_unlock(task);
> +       }
> +
>         /* Unconditionally return identifiers and credentials, the rest only on request */
>
>         user_ns = current_user_ns();
> @@ -559,6 +595,49 @@ void pidfs_exit(struct task_struct *tsk)
>         }
>  }
>
> +#if defined(CONFIG_COREDUMP) && defined(CONFIG_UNIX)
> +void pidfs_coredump_cookie(struct pid *pid, u64 coredump_cookie)
> +{
> +       struct pidfs_exit_info *exit_info;
> +       struct dentry *dentry = pid->stashed;
> +       struct inode *inode;
> +
> +       if (WARN_ON_ONCE(!dentry))
> +               return;
> +
> +       inode = d_inode(dentry);
> +       exit_info = &pidfs_i(inode)->__pei;
> +       /* Can't use smp_store_release() because of 32bit. */
> +       smp_wmb();
> +       WRITE_ONCE(exit_info->coredump_cookie, coredump_cookie);
> +}
> +#endif
> +
> +#ifdef CONFIG_COREDUMP
> +void pidfs_coredump(const struct coredump_params *cprm)
> +{
> +       struct pid *pid = cprm->pid;
> +       struct pidfs_exit_info *exit_info;
> +       struct dentry *dentry;
> +       struct inode *inode;
> +       __u32 coredump_mask = 0;
> +
> +       dentry = pid->stashed;
> +       if (WARN_ON_ONCE(!dentry))
> +               return;
> +
> +       inode = d_inode(dentry);
> +       exit_info = &pidfs_i(inode)->__pei;
> +       /* Note how we were coredumped. */
> +       coredump_mask = pidfs_coredump_mask(cprm->mm_flags);
> +       /* Note that we actually did coredump. */
> +       coredump_mask |= PIDFD_COREDUMPED;
> +       /* If coredumping is set to skip we should never end up here. */
> +       VFS_WARN_ON_ONCE(coredump_mask & PIDFD_COREDUMP_SKIP);
> +       smp_store_release(&exit_info->coredump_mask, coredump_mask);
> +}
> +#endif
> +
>  static struct vfsmount *pidfs_mnt __ro_after_init;
>
>  /*
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 2676890c4d0d..497997bc5e34 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -2,11 +2,21 @@
>  #ifndef _LINUX_PID_FS_H
>  #define _LINUX_PID_FS_H
>
> +struct coredump_params;
> +
>  struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
>  void __init pidfs_init(void);
>  void pidfs_add_pid(struct pid *pid);
>  void pidfs_remove_pid(struct pid *pid);
>  void pidfs_exit(struct task_struct *tsk);
> +#ifdef CONFIG_COREDUMP
> +void pidfs_coredump(const struct coredump_params *cprm);
> +#endif
> +#if defined(CONFIG_COREDUMP) && defined(CONFIG_UNIX)
> +void pidfs_coredump_cookie(struct pid *pid, u64 coredump_cookie);
> +#elif defined(CONFIG_UNIX)
> +static inline void pidfs_coredump_cookie(struct pid *pid, u64 coredump_cookie) { }
> +#endif
>  extern const struct dentry_operations pidfs_dentry_operations;
>  int pidfs_register_pid(struct pid *pid);
>  void pidfs_get_pid(struct pid *pid);
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 8c1511edd0e9..69267c5ae6d0 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -25,9 +25,28 @@
>  #define PIDFD_INFO_CREDS               (1UL << 1) /* Always returned, even if not requested */
>  #define PIDFD_INFO_CGROUPID            (1UL << 2) /* Always returned if available, even if not requested */
>  #define PIDFD_INFO_EXIT                        (1UL << 3) /* Only returned if requested. */
> +#define PIDFD_INFO_COREDUMP            (1UL << 4) /* Only returned if requested. */
>
>  #define PIDFD_INFO_SIZE_VER0           64 /* sizeof first published struct */
>
> +/*
> + * Values for @coredump_mask in pidfd_info.
> + * Only valid if PIDFD_INFO_COREDUMP is set in @mask.
> + *
> + * Note, the @PIDFD_COREDUMP_ROOT flag indicates that the generated
> + * coredump should be treated as sensitive and access should only be
> + * granted to privileged users.
> + *
> + * If the coredump AF_UNIX socket is used for processing coredumps
> + * @coredump_cookie will be set to the socket SO_COOKIE of the receivers
> + * client socket. This allows the coredump handler to detect whether an
> + * incoming coredump connection was initiated from the crashing task.
> + */
> +#define PIDFD_COREDUMPED       (1U << 0) /* Did crash and... */
> +#define PIDFD_COREDUMP_SKIP    (1U << 1) /* coredumping generation was skipped. */
> +#define PIDFD_COREDUMP_USER    (1U << 2) /* coredump was done as the user. */
> +#define PIDFD_COREDUMP_ROOT    (1U << 3) /* coredump was done as root. */
> +
>  /*
>   * The concept of process and threads in userland and the kernel is a confusing
>   * one - within the kernel every thread is a 'task' with its own individual PID,
> @@ -92,6 +111,9 @@ struct pidfd_info {
>         __u32 fsuid;
>         __u32 fsgid;
>         __s32 exit_code;
> +       __u32 coredump_mask;
> +       __u32 __spare1;
> +       __u64 coredump_cookie;
>  };
>
>  #define PIDFS_IOCTL_MAGIC 0xFF
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index a9d1c9ba2961..053d2e48e918 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -99,6 +99,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
> +#include <linux/sock_diag.h>
>  #include <linux/socket.h>
>  #include <linux/splice.h>
>  #include <linux/string.h>
> @@ -742,6 +743,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
>
>  struct unix_peercred {
>         struct pid *peer_pid;
> +       u64 cookie;
>         const struct cred *peer_cred;
>  };
>
> @@ -777,6 +779,8 @@ static void drop_peercred(struct unix_peercred *peercred)
>  static inline void init_peercred(struct sock *sk,
>                                  const struct unix_peercred *peercred)
>  {
> +       if (peercred->cookie)
> +               pidfs_coredump_cookie(peercred->peer_pid, peercred->cookie);
>         sk->sk_peer_pid = peercred->peer_pid;
>         sk->sk_peer_cred = peercred->peer_cred;
>  }
> @@ -1713,6 +1717,9 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>         unix_peer(newsk)        = sk;
>         newsk->sk_state         = TCP_ESTABLISHED;
>         newsk->sk_type          = sk->sk_type;
> +       /* Prepare a new socket cookie for the receiver. */
> +       if (flags & SOCK_COREDUMP)
> +               peercred.cookie = sock_gen_cookie(newsk);
>         init_peercred(newsk, &peercred);
>         newu = unix_sk(newsk);
>         newu->listener = other;
>
> --
> 2.47.2
>

