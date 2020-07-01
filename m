Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CF2106C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 10:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgGAI4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 04:56:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51835 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGAI4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:56:05 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jqYWo-0003mV-AJ; Wed, 01 Jul 2020 08:55:38 +0000
Date:   Wed, 1 Jul 2020 10:55:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] prctl: Allow ptrace capable processes to change
 /proc/self/exe
Message-ID: <20200701085537.k7whjbn3icu5rpsq@wittgenstein>
References: <20200701064906.323185-1-areber@redhat.com>
 <20200701064906.323185-4-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200701064906.323185-4-areber@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 01, 2020 at 08:49:06AM +0200, Adrian Reber wrote:
> From: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> 
> Previously, the current process could only change the /proc/self/exe
> link with local CAP_SYS_ADMIN.
> This commit relaxes this restriction by permitting such change with
> CAP_CHECKPOINT_RESTORE, and the ability to use ptrace.
> 
> With access to ptrace facilities, a process can do the following: fork a
> child, execve() the target executable, and have the child use ptrace()
> to replace the memory content of the current process. This technique
> makes it possible to masquerade an arbitrary program as any executable,
> even setuid ones.
> 
> Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  kernel/sys.c                  | 12 ++++--------
>  security/commoncap.c          | 26 ++++++++++++++++++++++++++
>  security/security.c           |  5 +++++
>  security/selinux/hooks.c      | 14 ++++++++++++++
>  6 files changed, 56 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 0098852bb56a..90e51d5e093b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -211,6 +211,7 @@ LSM_HOOK(int, 0, task_kill, struct task_struct *p, struct kernel_siginfo *info,
>  	 int sig, const struct cred *cred)
>  LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
>  	 unsigned long arg3, unsigned long arg4, unsigned long arg5)
> +LSM_HOOK(int, 0, prctl_set_mm_exe_file, struct file *exe_file)
>  LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
>  	 struct inode *inode)
>  LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 2797e7f6418e..0f594eb7e766 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -412,6 +412,7 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
>  			int sig, const struct cred *cred);
>  int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			unsigned long arg4, unsigned long arg5);
> +int security_prctl_set_mm_exe_file(struct file *exe_file);
>  void security_task_to_inode(struct task_struct *p, struct inode *inode);
>  int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
>  void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
> @@ -1124,6 +1125,11 @@ static inline int security_task_prctl(int option, unsigned long arg2,
>  	return cap_task_prctl(option, arg2, arg3, arg4, arg5);
>  }
>  
> +static inline int security_prctl_set_mm_exe_file(struct file *exe_file)
> +{
> +	return cap_prctl_set_mm_exe_file(exe_file);
> +}
> +
>  static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
>  { }
>  
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 00a96746e28a..bb53e8408c63 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1851,6 +1851,10 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
>  	if (err)
>  		goto exit;
>  
> +	err = security_prctl_set_mm_exe_file(exe.file);
> +	if (err)
> +		goto exit;
> +
>  	/*
>  	 * Forbid mm->exe_file change if old file still mapped.
>  	 */
> @@ -2006,14 +2010,6 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  	}
>  
>  	if (prctl_map.exe_fd != (u32)-1) {
> -		/*
> -		 * Make sure the caller has the rights to
> -		 * change /proc/pid/exe link: only local sys admin should
> -		 * be allowed to.
> -		 */
> -		if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> -			return -EINVAL;
> -
>  		error = prctl_set_mm_exe_file(mm, prctl_map.exe_fd);
>  		if (error)
>  			return error;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 59bf3c1674c8..663d00fe2ecc 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1291,6 +1291,31 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  	}
>  }
>  
> +/**
> + * cap_prctl_set_mm_exe_file - Determine whether /proc/self/exe can be changed
> + * by the current process.
> + * @exe_file: The new exe file
> + * Returns 0 if permission is granted, -ve if denied.
> + *
> + * The current process is permitted to change its /proc/self/exe link via two policies:
> + * 1) The current user can do checkpoint/restore. At the time of this writing,
> + *    this means CAP_SYS_ADMIN or CAP_CHECKPOINT_RESTORE capable.
> + * 2) The current user can use ptrace.
> + *
> + * With access to ptrace facilities, a process can do the following:
> + * fork a child, execve() the target executable, and have the child use
> + * ptrace() to replace the memory content of the current process.
> + * This technique makes it possible to masquerade an arbitrary program as the
> + * target executable, even if it is setuid.
> + */
> +int cap_prctl_set_mm_exe_file(struct file *exe_file)
> +{
> +	if (checkpoint_restore_ns_capable(current_user_ns()))
> +		return 0;
> +
> +	return security_ptrace_access_check(current, PTRACE_MODE_ATTACH_REALCREDS);
> +}

What is the reason for having this be a new security hook? Doesn't look
like it needs to be unless I'm missing something. This just seems more
complex than it needs to be.

I might be wrong here but if you look at the callsites for
security_ptrace_access_check() right now, you'll see that it's only
called from kernel/ptrace.c in __ptrace_may_access() and that function
checks right at the top:

	/* Don't let security modules deny introspection */
	if (same_thread_group(task, current))
		return 0;

since you're passing in same_thread_group(current, current) you're
passing this check and never even hitting
security_ptrace_access_check(). So the contract seems to be (as is
obvious from the comment) that a task can't be denied ptrace
introspection. But if you're using security_ptrace_access_check(current)
here and _if_ there would be any lsm that would deny ptrace
introspection to current you'd suddenly introduce a callsite where
ptrace introspection is denied. That seems wrong. So either you meant to
do something else here or you really just want:

checkpoint_restore_ns_capable(current_user_ns())

and none of the rest. But I might be missing the big picture in this
patch.

> +	if (checkpoint_restore_ns_capable(current_user_ns()))
> +		return 0;
> +
>  /**
>   * cap_vm_enough_memory - Determine whether a new virtual mapping is permitted
>   * @mm: The VM space in which the new mapping is to be made
> @@ -1356,6 +1381,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(mmap_file, cap_mmap_file),
>  	LSM_HOOK_INIT(task_fix_setuid, cap_task_fix_setuid),
>  	LSM_HOOK_INIT(task_prctl, cap_task_prctl),
> +	LSM_HOOK_INIT(prctl_set_mm_exe_file, cap_prctl_set_mm_exe_file),
>  	LSM_HOOK_INIT(task_setscheduler, cap_task_setscheduler),
>  	LSM_HOOK_INIT(task_setioprio, cap_task_setioprio),
>  	LSM_HOOK_INIT(task_setnice, cap_task_setnice),
> diff --git a/security/security.c b/security/security.c
> index 2bb912496232..13a1ed32f9e3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1790,6 +1790,11 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  	return rc;
>  }
>  
> +int security_prctl_set_mm_exe_file(struct file *exe_file)
> +{
> +	return call_int_hook(prctl_set_mm_exe_file, 0, exe_file);
> +}
> +
>  void security_task_to_inode(struct task_struct *p, struct inode *inode)
>  {
>  	call_void_hook(task_to_inode, p, inode);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ca901025802a..fca5581392b8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4156,6 +4156,19 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
>  			    secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
>  }
>  
> +static int selinux_prctl_set_mm_exe_file(struct file *exe_file)
> +{
> +	u32 sid = current_sid();
> +
> +	struct common_audit_data ad = {
> +		.type = LSM_AUDIT_DATA_FILE,
> +		.u.file = exe_file,
> +	};
> +
> +	return avc_has_perm(&selinux_state, sid, sid,
> +			    SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
> +}
> +
>  static void selinux_task_to_inode(struct task_struct *p,
>  				  struct inode *inode)
>  {
> @@ -7057,6 +7070,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(task_getscheduler, selinux_task_getscheduler),
>  	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
>  	LSM_HOOK_INIT(task_kill, selinux_task_kill),
> +	LSM_HOOK_INIT(prctl_set_mm_exe_file, selinux_prctl_set_mm_exe_file),
>  	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
>  
>  	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
> -- 
> 2.26.2
> 
