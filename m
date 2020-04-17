Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BEB1AE552
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 20:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgDQS6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 14:58:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38564 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgDQS6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:58:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPWBl-0000c7-MH; Fri, 17 Apr 2020 12:58:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPWBj-0005Qa-Vo; Fri, 17 Apr 2020 12:58:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>
References: <20200409123752.1070597-1-gladkov.alexey@gmail.com>
        <20200409123752.1070597-3-gladkov.alexey@gmail.com>
Date:   Fri, 17 Apr 2020 13:55:05 -0500
In-Reply-To: <20200409123752.1070597-3-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Thu, 9 Apr 2020 14:37:46 +0200")
Message-ID: <87tv1iaqnq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jPWBj-0005Qa-Vo;;;mid=<87tv1iaqnq.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18JkROI2nWPSE5+pIhayhkWLUXbXWbGhIs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1156 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 13 (1.1%), b_tie_ro: 10 (0.9%), parse: 1.92
        (0.2%), extract_message_metadata: 21 (1.8%), get_uri_detail_list: 9
        (0.8%), tests_pri_-1000: 15 (1.3%), tests_pri_-950: 1.58 (0.1%),
        tests_pri_-900: 1.46 (0.1%), tests_pri_-90: 122 (10.5%), check_bayes:
        118 (10.3%), b_tokenize: 27 (2.4%), b_tok_get_all: 16 (1.4%),
        b_comp_prob: 4.7 (0.4%), b_tok_touch_all: 65 (5.7%), b_finish: 1.00
        (0.1%), tests_pri_0: 965 (83.5%), check_dkim_signature: 1.03 (0.1%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 0.30 (0.0%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 7 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RESEND v11 2/8] proc: allow to mount many instances of proc in one pid namespace
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> This patch allows to have multiple procfs instances inside the
> same pid namespace. The aim here is lightweight sandboxes, and to allow
> that we have to modernize procfs internals.
>
> 1) The main aim of this work is to have on embedded systems one
> supervisor for apps. Right now we have some lightweight sandbox support,
> however if we create pid namespacess we have to manages all the
> processes inside too, where our goal is to be able to run a bunch of
> apps each one inside its own mount namespace without being able to
> notice each other. We only want to use mount namespaces, and we want
> procfs to behave more like a real mount point.
>
> 2) Linux Security Modules have multiple ptrace paths inside some
> subsystems, however inside procfs, the implementation does not guarantee
> that the ptrace() check which triggers the security_ptrace_check() hook
> will always run. We have the 'hidepid' mount option that can be used to
> force the ptrace_may_access() check inside has_pid_permissions() to run.
> The problem is that 'hidepid' is per pid namespace and not attached to
> the mount point, any remount or modification of 'hidepid' will propagate
> to all other procfs mounts.
>
> This also does not allow to support Yama LSM easily in desktop and user
> sessions. Yama ptrace scope which restricts ptrace and some other
> syscalls to be allowed only on inferiors, can be updated to have a
> per-task context, where the context will be inherited during fork(),
> clone() and preserved across execve(). If we support multiple private
> procfs instances, then we may force the ptrace_may_access() on
> /proc/<pids>/ to always run inside that new procfs instances. This will
> allow to specifiy on user sessions if we should populate procfs with
> pids that the user can ptrace or not.
>
> By using Yama ptrace scope, some restricted users will only be able to see
> inferiors inside /proc, they won't even be able to see their other
> processes. Some software like Chromium, Firefox's crash handler, Wine
> and others are already using Yama to restrict which processes can be
> ptracable. With this change this will give the possibility to restrict
> /proc/<pids>/ but more importantly this will give desktop users a
> generic and usuable way to specifiy which users should see all processes
> and which users can not.
>
> Side notes:
> * This covers the lack of seccomp where it is not able to parse
> arguments, it is easy to install a seccomp filter on direct syscalls
> that operate on pids, however /proc/<pid>/ is a Linux ABI using
> filesystem syscalls. With this change LSMs should be able to analyze
> open/read/write/close...
>
> In the new patchset version I removed the 'newinstance' option
> as suggested by Eric W. Biederman.

Some very small requests.

1) Can you please not place fs_info in fs_context, and instead allocate
   fs_info in fill_super?  Unless I have misread introduced a resource
   leak if proc is not mounted or if proc is simply reconfigured.

2) Can you please move hide_pid and pid_gid into fs_info in this patch?
   As was shown by my recent bug fix 

3) Can you please rebase on on v5.7-rc1 or v5.7-rc2 and repost these
   patches please?  I thought I could do it safely but between my bug
   fixes, and Alexey Dobriyan's parallel changes to proc these patches
   do not apply cleanly.

   Plus there is a resource leak in this patch.

Eric


> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/proc/base.c                | 13 +++++++----
>  fs/proc/inode.c               |  4 ++--
>  fs/proc/root.c                | 42 ++++++++++++++++++++++-------------
>  fs/proc/self.c                |  6 ++---
>  fs/proc/thread_self.c         |  6 ++---
>  include/linux/pid_namespace.h |  4 ----
>  include/linux/proc_fs.h       | 12 ++++++++++
>  7 files changed, 55 insertions(+), 32 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 74f948a6b621..3b9155a69ade 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3301,6 +3301,7 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
>  {
>  	struct task_struct *task;
>  	unsigned tgid;
> +	struct proc_fs_info *fs_info;
>  	struct pid_namespace *ns;
>  	struct dentry *result = ERR_PTR(-ENOENT);
>  
> @@ -3308,7 +3309,8 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
>  	if (tgid == ~0U)
>  		goto out;
>  
> -	ns = dentry->d_sb->s_fs_info;
> +	fs_info = proc_sb_info(dentry->d_sb);
> +	ns = fs_info->pid_ns;
>  	rcu_read_lock();
>  	task = find_task_by_pid_ns(tgid, ns);
>  	if (task)
> @@ -3372,6 +3374,7 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
>  int proc_pid_readdir(struct file *file, struct dir_context *ctx)
>  {
>  	struct tgid_iter iter;
> +	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
>  	struct pid_namespace *ns = proc_pid_ns(file_inode(file));
>  	loff_t pos = ctx->pos;
>  
> @@ -3379,13 +3382,13 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
>  		return 0;
>  
>  	if (pos == TGID_OFFSET - 2) {
> -		struct inode *inode = d_inode(ns->proc_self);
> +		struct inode *inode = d_inode(fs_info->proc_self);
>  		if (!dir_emit(ctx, "self", 4, inode->i_ino, DT_LNK))
>  			return 0;
>  		ctx->pos = pos = pos + 1;
>  	}
>  	if (pos == TGID_OFFSET - 1) {
> -		struct inode *inode = d_inode(ns->proc_thread_self);
> +		struct inode *inode = d_inode(fs_info->proc_thread_self);
>  		if (!dir_emit(ctx, "thread-self", 11, inode->i_ino, DT_LNK))
>  			return 0;
>  		ctx->pos = pos = pos + 1;
> @@ -3599,6 +3602,7 @@ static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry
>  	struct task_struct *task;
>  	struct task_struct *leader = get_proc_task(dir);
>  	unsigned tid;
> +	struct proc_fs_info *fs_info;
>  	struct pid_namespace *ns;
>  	struct dentry *result = ERR_PTR(-ENOENT);
>  
> @@ -3609,7 +3613,8 @@ static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry
>  	if (tid == ~0U)
>  		goto out;
>  
> -	ns = dentry->d_sb->s_fs_info;
> +	fs_info = proc_sb_info(dentry->d_sb);
> +	ns = fs_info->pid_ns;
>  	rcu_read_lock();
>  	task = find_task_by_pid_ns(tid, ns);
>  	if (task)
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index 1e730ea1dcd6..6e4c6728338b 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -167,8 +167,8 @@ void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock
>  
>  static int proc_show_options(struct seq_file *seq, struct dentry *root)
>  {
> -	struct super_block *sb = root->d_sb;
> -	struct pid_namespace *pid = sb->s_fs_info;
> +	struct proc_fs_info *fs_info = proc_sb_info(root->d_sb);
> +	struct pid_namespace *pid = fs_info->pid_ns;
>  
>  	if (!gid_eq(pid->pid_gid, GLOBAL_ROOT_GID))
>  		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, pid->pid_gid));
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 2633f10446c3..b28adbb0b937 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -30,7 +30,7 @@
>  #include "internal.h"
>  
>  struct proc_fs_context {
> -	struct pid_namespace	*pid_ns;
> +	struct proc_fs_info	*fs_info;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Please don't do this. As best as I can tell that introduces a memory
leak of proc is not mounted.  Please allocate fs_info in 

>  	unsigned int		mask;
>  	int			hidepid;
>  	int			gid;
> @@ -92,7 +92,8 @@ static void proc_apply_options(struct super_block *s,
>  
>  static int proc_fill_super(struct super_block *s, struct fs_context *fc)
>  {
> -	struct pid_namespace *pid_ns = get_pid_ns(s->s_fs_info);
> +	struct proc_fs_context *ctx = fc->fs_private;
> +	struct pid_namespace *pid_ns = get_pid_ns(ctx->fs_info->pid_ns);
>  	struct inode *root_inode;
>  	int ret;
>  
> @@ -106,6 +107,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
>  	s->s_magic = PROC_SUPER_MAGIC;
>  	s->s_op = &proc_sops;
>  	s->s_time_gran = 1;
> +	s->s_fs_info = ctx->fs_info;
>  
>  	/*
>  	 * procfs isn't actually a stacking filesystem; however, there is
> @@ -113,7 +115,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
>  	 * top of it
>  	 */
>  	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
> -	
> +
>  	/* procfs dentries and inodes don't require IO to create */
>  	s->s_shrink.seeks = 0;
>  
> @@ -140,7 +142,8 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
>  static int proc_reconfigure(struct fs_context *fc)
>  {
>  	struct super_block *sb = fc->root->d_sb;
> -	struct pid_namespace *pid = sb->s_fs_info;
> +	struct proc_fs_info *fs_info = proc_sb_info(sb);
> +	struct pid_namespace *pid = fs_info->pid_ns;
>  
>  	sync_filesystem(sb);
>  
> @@ -150,16 +153,14 @@ static int proc_reconfigure(struct fs_context *fc)
>  
>  static int proc_get_tree(struct fs_context *fc)
>  {
> -	struct proc_fs_context *ctx = fc->fs_private;
> -
> -	return get_tree_keyed(fc, proc_fill_super, ctx->pid_ns);
> +	return get_tree_nodev(fc, proc_fill_super);
>  }
>  
>  static void proc_fs_context_free(struct fs_context *fc)
>  {
>  	struct proc_fs_context *ctx = fc->fs_private;
>  
> -	put_pid_ns(ctx->pid_ns);
> +	put_pid_ns(ctx->fs_info->pid_ns);
>  	kfree(ctx);
>  }
>  
> @@ -178,9 +179,15 @@ static int proc_init_fs_context(struct fs_context *fc)
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	ctx->pid_ns = get_pid_ns(task_active_pid_ns(current));
> +	ctx->fs_info = kzalloc(sizeof(struct proc_fs_info), GFP_KERNEL);
> +	if (!ctx->fs_info) {
> +		kfree(ctx);
> +		return -ENOMEM;
> +	}
> +
> +	ctx->fs_info->pid_ns = get_pid_ns(task_active_pid_ns(current));
>  	put_user_ns(fc->user_ns);
> -	fc->user_ns = get_user_ns(ctx->pid_ns->user_ns);
> +	fc->user_ns = get_user_ns(ctx->fs_info->pid_ns->user_ns);
>  	fc->fs_private = ctx;
>  	fc->ops = &proc_fs_context_ops;
>  	return 0;
> @@ -188,15 +195,18 @@ static int proc_init_fs_context(struct fs_context *fc)
>  
>  static void proc_kill_sb(struct super_block *sb)
>  {
> -	struct pid_namespace *ns;
> +	struct proc_fs_info *fs_info = proc_sb_info(sb);
> +	struct pid_namespace *ns = fs_info->pid_ns;
> +
> +	if (fs_info->proc_self)
> +		dput(fs_info->proc_self);
> +
> +	if (fs_info->proc_thread_self)
> +		dput(fs_info->proc_thread_self);
>  
> -	ns = (struct pid_namespace *)sb->s_fs_info;
> -	if (ns->proc_self)
> -		dput(ns->proc_self);
> -	if (ns->proc_thread_self)
> -		dput(ns->proc_thread_self);
>  	kill_anon_super(sb);
>  	put_pid_ns(ns);
> +	kfree(fs_info);
>  }
>  
>  static struct file_system_type proc_fs_type = {
> diff --git a/fs/proc/self.c b/fs/proc/self.c
> index 57c0a1047250..309301ac0136 100644
> --- a/fs/proc/self.c
> +++ b/fs/proc/self.c
> @@ -36,10 +36,10 @@ static unsigned self_inum __ro_after_init;
>  int proc_setup_self(struct super_block *s)
>  {
>  	struct inode *root_inode = d_inode(s->s_root);
> -	struct pid_namespace *ns = proc_pid_ns(root_inode);
> +	struct proc_fs_info *fs_info = proc_sb_info(s);
>  	struct dentry *self;
>  	int ret = -ENOMEM;
> -	
> +
>  	inode_lock(root_inode);
>  	self = d_alloc_name(s->s_root, "self");
>  	if (self) {
> @@ -62,7 +62,7 @@ int proc_setup_self(struct super_block *s)
>  	if (ret)
>  		pr_err("proc_fill_super: can't allocate /proc/self\n");
>  	else
> -		ns->proc_self = self;
> +		fs_info->proc_self = self;
>  
>  	return ret;
>  }
> diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
> index f61ae53533f5..2493cbbdfa6f 100644
> --- a/fs/proc/thread_self.c
> +++ b/fs/proc/thread_self.c
> @@ -36,7 +36,7 @@ static unsigned thread_self_inum __ro_after_init;
>  int proc_setup_thread_self(struct super_block *s)
>  {
>  	struct inode *root_inode = d_inode(s->s_root);
> -	struct pid_namespace *ns = proc_pid_ns(root_inode);
> +	struct proc_fs_info *fs_info = proc_sb_info(s);
>  	struct dentry *thread_self;
>  	int ret = -ENOMEM;
>  
> @@ -60,9 +60,9 @@ int proc_setup_thread_self(struct super_block *s)
>  	inode_unlock(root_inode);
>  
>  	if (ret)
> -		pr_err("proc_fill_super: can't allocate /proc/thread_self\n");
> +		pr_err("proc_fill_super: can't allocate /proc/thread-self\n");
>  	else
> -		ns->proc_thread_self = thread_self;
> +		fs_info->proc_thread_self = thread_self;
>  
>  	return ret;
>  }
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 4956e362e55e..de4534d93cb6 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -32,10 +32,6 @@ struct pid_namespace {
>  	struct kmem_cache *pid_cachep;
>  	unsigned int level;
>  	struct pid_namespace *parent;
> -#ifdef CONFIG_PROC_FS
> -	struct dentry *proc_self;
> -	struct dentry *proc_thread_self;
> -#endif
>  #ifdef CONFIG_BSD_PROCESS_ACCT
>  	struct fs_pin *bacct;
>  #endif
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index 40a7982b7285..5920a4ecd71b 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -27,6 +27,17 @@ struct proc_ops {
>  	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
>  };
>  
> +struct proc_fs_info {
> +	struct pid_namespace *pid_ns;
> +	struct dentry *proc_self;        /* For /proc/self */
> +	struct dentry *proc_thread_self; /* For /proc/thread-self */
> +};
> +
> +static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
> +{
> +	return sb->s_fs_info;
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  
>  typedef int (*proc_write_t)(struct file *, char *, size_t);
> @@ -161,6 +172,7 @@ int open_related_ns(struct ns_common *ns,
>  /* get the associated pid namespace for a file in procfs */
>  static inline struct pid_namespace *proc_pid_ns(const struct inode *inode)
>  {
> +	return proc_sb_info(inode->i_sb)->pid_ns;
>  	return inode->i_sb->s_fs_info;
>  }
