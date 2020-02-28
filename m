Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CDB174127
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 21:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgB1UjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 15:39:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36597 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1UjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 15:39:20 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7mPk-0007vL-LX; Fri, 28 Feb 2020 20:39:16 +0000
Date:   Fri, 28 Feb 2020 21:39:15 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH 3/3] proc: Remove the now unnecessary internal mount of
 proc
Message-ID: <20200228203915.jelui3l5xue5utpx@wittgenstein>
References: <20200212203833.GQ23230@ZenIV.linux.org.uk>
 <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org>
 <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org>
 <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <871rqk2brn.fsf_-_@x220.int.ebiederm.org>
 <878skmsbyy.fsf_-_@x220.int.ebiederm.org>
 <87r1yeqxbp.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r1yeqxbp.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:19:22PM -0600, Eric W. Biederman wrote:
> 
> There remains no more code in the kernel using pids_ns->proc_mnt,
> therefore remove it from the kernel.
> 
> The big benefit of this change is that one of the most error prone and
> tricky parts of the pid namespace implementation, maintaining kernel
> mounts of proc is removed.
> 
> In addition removing the unnecessary complexity of the kernel mount
> fixes a regression that caused the proc mount options to be ignored.
> Now that the initial mount of proc comes from userspace, those mount
> options are again honored.  This fixes Android's usage of the proc
> hidepid option.
> 
> Reported-by: Alistair Strachan <astrachan@google.com>
> Fixes: e94591d0d90c ("proc: Convert proc_mount to use mount_ns.")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/proc/root.c                | 36 -----------------------------------

What about proc_flush_task()? Or is this on top of your other series?

>  include/linux/pid_namespace.h |  2 --
>  include/linux/proc_ns.h       |  5 -----
>  kernel/pid.c                  |  8 --------
>  kernel/pid_namespace.c        |  7 -------
>  5 files changed, 58 deletions(-)
> 
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 608233dfd29c..2633f10446c3 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -292,39 +292,3 @@ struct proc_dir_entry proc_root = {
>  	.subdir		= RB_ROOT,
>  	.name		= "/proc",
>  };
> -
> -int pid_ns_prepare_proc(struct pid_namespace *ns)
> -{
> -	struct proc_fs_context *ctx;
> -	struct fs_context *fc;
> -	struct vfsmount *mnt;
> -
> -	fc = fs_context_for_mount(&proc_fs_type, SB_KERNMOUNT);
> -	if (IS_ERR(fc))
> -		return PTR_ERR(fc);
> -
> -	if (fc->user_ns != ns->user_ns) {
> -		put_user_ns(fc->user_ns);
> -		fc->user_ns = get_user_ns(ns->user_ns);
> -	}
> -
> -	ctx = fc->fs_private;
> -	if (ctx->pid_ns != ns) {
> -		put_pid_ns(ctx->pid_ns);
> -		get_pid_ns(ns);
> -		ctx->pid_ns = ns;
> -	}
> -
> -	mnt = fc_mount(fc);
> -	put_fs_context(fc);
> -	if (IS_ERR(mnt))
> -		return PTR_ERR(mnt);
> -
> -	ns->proc_mnt = mnt;
> -	return 0;
> -}
> -
> -void pid_ns_release_proc(struct pid_namespace *ns)
> -{
> -	kern_unmount(ns->proc_mnt);
> -}
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 2ed6af88794b..4956e362e55e 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -33,7 +33,6 @@ struct pid_namespace {
>  	unsigned int level;
>  	struct pid_namespace *parent;
>  #ifdef CONFIG_PROC_FS
> -	struct vfsmount *proc_mnt;
>  	struct dentry *proc_self;
>  	struct dentry *proc_thread_self;
>  #endif
> @@ -42,7 +41,6 @@ struct pid_namespace {
>  #endif
>  	struct user_namespace *user_ns;
>  	struct ucounts *ucounts;
> -	struct work_struct proc_work;
>  	kgid_t pid_gid;
>  	int hide_pid;
>  	int reboot;	/* group exit code if this pidns was rebooted */
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index 4626b1ac3b6c..e1106a077c1a 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -50,16 +50,11 @@ enum {
>  
>  #ifdef CONFIG_PROC_FS
>  
> -extern int pid_ns_prepare_proc(struct pid_namespace *ns);
> -extern void pid_ns_release_proc(struct pid_namespace *ns);
>  extern int proc_alloc_inum(unsigned int *pino);
>  extern void proc_free_inum(unsigned int inum);
>  
>  #else /* CONFIG_PROC_FS */
>  
> -static inline int pid_ns_prepare_proc(struct pid_namespace *ns) { return 0; }
> -static inline void pid_ns_release_proc(struct pid_namespace *ns) {}
> -
>  static inline int proc_alloc_inum(unsigned int *inum)
>  {
>  	*inum = 1;
> diff --git a/kernel/pid.c b/kernel/pid.c
> index ca08d6a3aa77..60820e72634c 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -144,9 +144,6 @@ void free_pid(struct pid *pid)
>  			/* Handle a fork failure of the first process */
>  			WARN_ON(ns->child_reaper);
>  			ns->pid_allocated = 0;
> -			/* fall through */
> -		case 0:
> -			schedule_work(&ns->proc_work);
>  			break;
>  		}
>  
> @@ -247,11 +244,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  		tmp = tmp->parent;
>  	}
>  
> -	if (unlikely(is_child_reaper(pid))) {
> -		if (pid_ns_prepare_proc(ns))
> -			goto out_free;
> -	}
> -
>  	get_pid_ns(ns);
>  	refcount_set(&pid->count, 1);
>  	for (type = 0; type < PIDTYPE_MAX; ++type)
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index d40017e79ebe..318fcc6ba301 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -57,12 +57,6 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
>  	return READ_ONCE(*pkc);
>  }
>  
> -static void proc_cleanup_work(struct work_struct *work)

There's a comment in kernel/pid_namespace.c that references
proc_cleanup_work(). Can you please remove that as well?

> -{
> -	struct pid_namespace *ns = container_of(work, struct pid_namespace, proc_work);
> -	pid_ns_release_proc(ns);
> -}
> -
>  static struct ucounts *inc_pid_namespaces(struct user_namespace *ns)
>  {
>  	return inc_ucount(ns, current_euid(), UCOUNT_PID_NAMESPACES);
> @@ -114,7 +108,6 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	ns->user_ns = get_user_ns(user_ns);
>  	ns->ucounts = ucounts;
>  	ns->pid_allocated = PIDNS_ADDING;
> -	INIT_WORK(&ns->proc_work, proc_cleanup_work);
>  
>  	return ns;
>  
> -- 
> 2.25.0
> 
