Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91DB233470
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgG3OaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:30:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:38614 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgG3OaO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:30:14 -0400
Received: from [192.168.15.64]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k19ZA-0004Nj-9q; Thu, 30 Jul 2020 17:29:52 +0300
Subject: Re: [PATCH 11/23] fs: Add /proc/namespaces/ directory
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611041929.535980.14513096920129728440.stgit@localhost.localdomain>
 <20200730132610.b6bhcugpnrmpywvi@wittgenstein>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9072f9f9-11fa-a0d8-2f7f-6b359b7ece68@virtuozzo.com>
Date:   Thu, 30 Jul 2020 17:30:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730132610.b6bhcugpnrmpywvi@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.07.2020 16:26, Christian Brauner wrote:
> On Thu, Jul 30, 2020 at 03:00:19PM +0300, Kirill Tkhai wrote:
>> This is a new directory to show all namespaces, which can be
>> accessed from this /proc tasks credentials.
>>
>> Every /proc is related to a pid_namespace, and the pid_namespace
>> is related to a user_namespace. The items, we show in this
>> /proc/namespaces/ directory, are the namespaces,
>> whose user_namespaces are the same as /proc's user_namespace,
>> or their descendants.
>>
>> Say, /proc has pid_ns->user_ns, so in /proc/namespace we show
>> only a ns, which is in_userns(pid_ns->user_ns, ns->user_ns).
>>
>> The final result is like below:
>>
>> # ls /proc/namespaces/ -l
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'cgroup:[4026531835]' -> 'cgroup:[4026531835]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'ipc:[4026531839]' -> 'ipc:[4026531839]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531840]' -> 'mnt:[4026531840]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531861]' -> 'mnt:[4026531861]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532133]' -> 'mnt:[4026532133]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532134]' -> 'mnt:[4026532134]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532135]' -> 'mnt:[4026532135]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532136]' -> 'mnt:[4026532136]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'net:[4026531993]' -> 'net:[4026531993]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'pid:[4026531836]' -> 'pid:[4026531836]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'time:[4026531834]' -> 'time:[4026531834]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'user:[4026531837]' -> 'user:[4026531837]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'uts:[4026531838]' -> 'uts:[4026531838]'
> 
> So usually, the /proc/<pid>/ns entries are guarded by
> ptrace_may_access() but from skimming the patch it seems that
> /proc/namespaces/ would be accessible by any user.
> 
> I think we should guard /proc/namespaces/. Either by restricting it to
> userns CAP_SYS_ADMIN or - to make it work with unprivileged CRIU - by
> ns_capable(proc's_pid_ns->user_ns, CAP_SYS_PTRACE).

I do agree with you, the restrictions have to be strict.

Advising this, do you mean only open() on /proc/namespaces/* files?
I'm not sure we should prohibit simple readdir of this directory. What do you think?
 
> This should probably also be a mount option on procfs given that we now
> allow a restricted view of procfs.
> 
> Christian
> 
>>
>> Every namespace may be open like ordinary file in /proc/[pid]/ns.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  fs/nsfs.c               |    2 
>>  fs/proc/Makefile        |    1 
>>  fs/proc/internal.h      |   16 ++
>>  fs/proc/namespaces.c    |  314 +++++++++++++++++++++++++++++++++++++++++++++++
>>  fs/proc/root.c          |   17 ++-
>>  include/linux/proc_fs.h |    1 
>>  6 files changed, 345 insertions(+), 6 deletions(-)
>>  create mode 100644 fs/proc/namespaces.c
>>
>> diff --git a/fs/nsfs.c b/fs/nsfs.c
>> index ee4be67d3a0b..61b789d2089c 100644
>> --- a/fs/nsfs.c
>> +++ b/fs/nsfs.c
>> @@ -58,7 +58,7 @@ static void nsfs_evict(struct inode *inode)
>>  	ns->ops->put(ns);
>>  }
>>  
>> -static int __ns_get_path(struct path *path, struct ns_common *ns)
>> +int __ns_get_path(struct path *path, struct ns_common *ns)
>>  {
>>  	struct vfsmount *mnt = nsfs_mnt;
>>  	struct dentry *dentry;
>> diff --git a/fs/proc/Makefile b/fs/proc/Makefile
>> index dc2d51f42905..34ff671c6d59 100644
>> --- a/fs/proc/Makefile
>> +++ b/fs/proc/Makefile
>> @@ -25,6 +25,7 @@ proc-y	+= util.o
>>  proc-y	+= version.o
>>  proc-y	+= softirqs.o
>>  proc-y	+= task_namespaces.o
>> +proc-y	+= namespaces.o
>>  proc-y	+= self.o
>>  proc-y	+= thread_self.o
>>  proc-$(CONFIG_PROC_SYSCTL)	+= proc_sysctl.o
>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>> index 572757ff97be..d19fe5574799 100644
>> --- a/fs/proc/internal.h
>> +++ b/fs/proc/internal.h
>> @@ -134,10 +134,11 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
>>  		     kuid_t *ruid, kgid_t *rgid);
>>  
>>  unsigned name_to_int(const struct qstr *qstr);
>> -/*
>> - * Offset of the first process in the /proc root directory..
>> - */
>> -#define FIRST_PROCESS_ENTRY 256
>> +
>> +/* Offset of "namespaces" entry in /proc root directory */
>> +#define NAMESPACES_ENTRY 256
>> +/* Offset of the first process in the /proc root directory */
>> +#define FIRST_PROCESS_ENTRY (NAMESPACES_ENTRY + 1)
>>  
>>  /* Worst case buffer size needed for holding an integer. */
>>  #define PROC_NUMBUF 13
>> @@ -168,6 +169,7 @@ extern void proc_pid_evict_inode(struct proc_inode *);
>>  extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
>>  extern void pid_update_inode(struct task_struct *, struct inode *);
>>  extern int pid_delete_dentry(const struct dentry *);
>> +extern int proc_emit_namespaces(struct file *, struct dir_context *);
>>  extern int proc_pid_readdir(struct file *, struct dir_context *);
>>  struct dentry *proc_pid_lookup(struct dentry *, unsigned int);
>>  extern loff_t mem_lseek(struct file *, loff_t, int);
>> @@ -222,6 +224,12 @@ void set_proc_pid_nlink(void);
>>  extern struct inode *proc_get_inode(struct super_block *, struct proc_dir_entry *);
>>  extern void proc_entry_rundown(struct proc_dir_entry *);
>>  
>> +/*
>> + * namespaces.c
>> + */
>> +extern int proc_setup_namespaces(struct super_block *);
>> +extern void proc_namespaces_init(void);
>> +
>>  /*
>>   * task_namespaces.c
>>   */
>> diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
>> new file mode 100644
>> index 000000000000..ab47e1555619
>> --- /dev/null
>> +++ b/fs/proc/namespaces.c
>> @@ -0,0 +1,314 @@
>> +#include <linux/pid_namespace.h>
>> +#include <linux/user_namespace.h>
>> +#include <linux/namei.h>
>> +#include "internal.h"
>> +
>> +static unsigned namespaces_inum __ro_after_init;
>> +
>> +int proc_emit_namespaces(struct file *file, struct dir_context *ctx)
>> +{
>> +	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
>> +	struct inode *inode = d_inode(fs_info->proc_namespaces);
>> +
>> +	return dir_emit(ctx, "namespaces", 10, inode->i_ino, DT_DIR);
>> +}
>> +
>> +static int parse_namespace_dentry_name(const struct dentry *dentry,
>> +		const char **type, unsigned int *type_len, unsigned int *inum)
>> +{
>> +	const char *p, *name;
>> +	int count;
>> +
>> +	*type = name = dentry->d_name.name;
>> +	p = strchr(name, ':');
>> +	*type_len = p - name;
>> +	if (!p || p == name)
>> +		return -ENOENT;
> 
> Hm, rather:
> 
> p = strchr(name, ':');
> if (!p || p == name)
> 	return -ENOENT;
> *type_len = p - name;
> 
>> +
>> +	p += 1;
>> +	if (sscanf(p, "[%u]%n", inum, &count) != 1 || *(p + count) != '\0' ||
>> +	    *inum < PROC_NS_MIN_INO)
>> +		return -ENOENT;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct ns_common *get_namespace_by_dentry(struct pid_namespace *pid_ns,
>> +						 const struct dentry *dentry)
>> +{
>> +	unsigned int type_len, inum, p_inum;
>> +	struct user_namespace *user_ns;
>> +	struct ns_common *ns;
>> +	const char *type;
>> +
>> +	if (parse_namespace_dentry_name(dentry, &type, &type_len, &inum) < 0)
>> +		return NULL;
>> +
>> +	p_inum = inum - 1;
>> +	ns = ns_get_next(&p_inum);
>> +	if (!ns)
>> +		return NULL;
>> +
>> +	if (ns->inum != inum || strncmp(type, ns->ops->name, type_len) != 0 ||
>> +	    ns->ops->name[type_len] != '\0') {
>> +		ns->ops->put(ns);
>> +		return NULL;
>> +	}
>> +
>> +	if (ns->ops != &userns_operations)
>> +		user_ns = ns->ops->owner(ns);
>> +	else
>> +		user_ns = container_of(ns, struct user_namespace, ns);
>> +
>> +	if (!in_userns(pid_ns->user_ns, user_ns)) {
>> +		ns->ops->put(ns);
>> +		return NULL;
>> +	}
>> +
>> +	return ns;
>> +}
>> +
>> +static struct dentry *proc_namespace_instantiate(struct dentry *dentry,
>> +		struct task_struct *task, const void *ptr);
>> +
>> +static struct dentry *proc_namespaces_lookup(struct inode *dir, struct dentry *dentry,
>> +					     unsigned int flags)
>> +{
>> +	struct pid_namespace *pid_ns = proc_pid_ns(dir->i_sb);
>> +	struct task_struct *task;
>> +	struct ns_common *ns;
>> +
>> +	ns = get_namespace_by_dentry(pid_ns, dentry);
>> +	if (!ns)
>> +		return ERR_PTR(-ENOENT);
>> +
>> +	read_lock(&tasklist_lock);
>> +	task = get_task_struct(pid_ns->child_reaper);
>> +	read_unlock(&tasklist_lock);
>> +
>> +	dentry = proc_namespace_instantiate(dentry, task, ns);
>> +	put_task_struct(task);
>> +	ns->ops->put(ns);
>> +
>> +	return dentry;
>> +}
>> +
>> +static int proc_namespaces_permission(struct inode *inode, int mask)
>> +{
>> +	if ((mask & MAY_EXEC) && S_ISLNK(inode->i_mode))
>> +		return -EACCES;
>> +
>> +	return 0;
>> +}
>> +
>> +static int proc_namespaces_getattr(const struct path *path, struct kstat *stat,
>> +				   u32 request_mask, unsigned int query_flags)
>> +{
>> +	struct inode *inode = d_inode(path->dentry);
>> +
>> +	generic_fillattr(inode, stat);
>> +	return 0;
>> +}
>> +
>> +static const struct inode_operations proc_namespaces_inode_operations = {
>> +	.lookup		= proc_namespaces_lookup,
>> +	.permission	= proc_namespaces_permission,
>> +	.getattr	= proc_namespaces_getattr,
>> +};
>> +
>> +static int proc_namespaces_readlink(struct dentry *dentry, char __user *buffer, int buflen)
>> +{
>> +	struct inode *dir = dentry->d_parent->d_inode;
>> +	struct pid_namespace *pid_ns = proc_pid_ns(dir->i_sb);
>> +	struct ns_common *ns;
>> +
>> +	ns = get_namespace_by_dentry(pid_ns, dentry);
>> +	if (!ns)
>> +		return -ENOENT;
>> +	ns->ops->put(ns);
>> +
>> +	/* proc_namespaces_readdir() creates dentry names in namespace format */
>> +	return readlink_copy(buffer, buflen, dentry->d_iname);
>> +}
>> +
>> +int __ns_get_path(struct path *path, struct ns_common *ns);
>> +
>> +static const char *proc_namespaces_getlink(struct dentry *dentry,
>> +				struct inode *inode, struct delayed_call *done)
>> +{
>> +	struct pid_namespace *pid_ns = proc_pid_ns(inode->i_sb);
>> +	struct ns_common *ns;
>> +	struct path path;
>> +	int ret;
>> +
>> +	if (!dentry)
>> +		return ERR_PTR(-ECHILD);
>> +
>> +	while (1) {
>> +		ret = -ENOENT;
>> +		ns = get_namespace_by_dentry(pid_ns, dentry);
>> +		if (!ns)
>> +			goto out;
>> +
>> +		ret = __ns_get_path(&path, ns);
>> +		if (ret == -EAGAIN)
>> +			continue;
>> +		if (ret)
>> +			goto out;
>> +		break;
>> +	}
>> +
>> +	ret = nd_jump_link(&path);
>> +out:
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +static const struct inode_operations proc_namespaces_link_inode_operations = {
>> +	.readlink	= proc_namespaces_readlink,
>> +	.get_link	= proc_namespaces_getlink,
>> +};
>> +
>> +static int namespace_delete_dentry(const struct dentry *dentry)
>> +{
>> +	struct inode *dir = dentry->d_parent->d_inode;
>> +	struct pid_namespace *pid_ns = proc_pid_ns(dir->i_sb);
>> +	struct ns_common *ns;
>> +
>> +	ns = get_namespace_by_dentry(pid_ns, dentry);
>> +	if (!ns)
>> +		return 1;
>> +
>> +	ns->ops->put(ns);
>> +	return 0;
>> +}
>> +
>> +const struct dentry_operations namespaces_dentry_operations = {
>> +	.d_delete	= namespace_delete_dentry,
>> +};
>> +
>> +static void namespace_update_inode(struct inode *inode)
>> +{
>> +	struct user_namespace *user_ns = proc_pid_ns(inode->i_sb)->user_ns;
>> +
>> +	inode->i_uid = make_kuid(user_ns, 0);
>> +	if (!uid_valid(inode->i_uid))
>> +		inode->i_uid = GLOBAL_ROOT_UID;
>> +
>> +	inode->i_gid = make_kgid(user_ns, 0);
>> +	if (!gid_valid(inode->i_gid))
>> +		inode->i_gid = GLOBAL_ROOT_GID;
>> +}
>> +
>> +static struct dentry *proc_namespace_instantiate(struct dentry *dentry,
>> +	struct task_struct *task, const void *ptr)
>> +{
>> +	const struct ns_common *ns = ptr;
>> +	struct inode *inode;
>> +	struct proc_inode *ei;
>> +
>> +	/*
>> +	 * Create inode with credentials of @task, and add it to @task's
>> +	 * quick removal list.
>> +	 */
>> +	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | S_IRWXUGO);
>> +	if (!inode)
>> +		return ERR_PTR(-ENOENT);
>> +
>> +	ei = PROC_I(inode);
>> +	inode->i_op = &proc_namespaces_link_inode_operations;
>> +	ei->ns_ops = ns->ops;
>> +	namespace_update_inode(inode);
>> +
>> +	d_set_d_op(dentry, &namespaces_dentry_operations);
>> +	return d_splice_alias(inode, dentry);
>> +}
>> +
>> +static int proc_namespaces_readdir(struct file *file, struct dir_context *ctx)
>> +{
>> +	struct pid_namespace *pid_ns = proc_pid_ns(file_inode(file)->i_sb);
>> +	struct user_namespace *user_ns;
>> +	struct task_struct *task;
>> +	struct ns_common *ns;
>> +	unsigned int inum;
>> +
>> +	read_lock(&tasklist_lock);
>> +	task = get_task_struct(pid_ns->child_reaper);
>> +	read_unlock(&tasklist_lock);
>> +
>> +	if (!dir_emit_dots(file, ctx))
>> +		goto out;
>> +
>> +	inum = ctx->pos - 2;
>> +	while ((ns = ns_get_next(&inum)) != NULL) {
>> +		unsigned int len;
>> +		char name[32];
>> +
>> +		if (ns->ops != &userns_operations)
>> +			user_ns = ns->ops->owner(ns);
>> +		else
>> +			user_ns = container_of(ns, struct user_namespace, ns);
>> +
>> +		if (!in_userns(pid_ns->user_ns, user_ns))
>> +			goto next;
>> +
>> +		len = snprintf(name, sizeof(name), "%s:[%u]", ns->ops->name, inum);
>> +
>> +		if (!proc_fill_cache(file, ctx, name, len,
>> +			proc_namespace_instantiate, task, ns)) {
>> +			ns->ops->put(ns);
>> +			break;
>> +		}
>> +next:
>> +		ns->ops->put(ns);
>> +		ctx->pos = inum + 2;
>> +	}
>> +out:
>> +	put_task_struct(task);
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations proc_namespaces_file_operations = {
>> +	.read		= generic_read_dir,
>> +	.iterate_shared	= proc_namespaces_readdir,
>> +	.llseek		= generic_file_llseek,
>> +};
>> +
>> +int proc_setup_namespaces(struct super_block *s)
>> +{
>> +	struct proc_fs_info *fs_info = proc_sb_info(s);
>> +	struct inode *root_inode = d_inode(s->s_root);
>> +	struct dentry *namespaces;
>> +	int ret = -ENOMEM;
>> +
>> +	inode_lock(root_inode);
>> +	namespaces = d_alloc_name(s->s_root, "namespaces");
>> +	if (namespaces) {
>> +		struct inode *inode = new_inode_pseudo(s);
>> +		if (inode) {
>> +			inode->i_ino = namespaces_inum;
>> +			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
>> +			inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
>> +			inode->i_uid = GLOBAL_ROOT_UID;
>> +			inode->i_gid = GLOBAL_ROOT_GID;
>> +			inode->i_op = &proc_namespaces_inode_operations;
>> +			inode->i_fop = &proc_namespaces_file_operations;
>> +			d_add(namespaces, inode);
>> +			ret = 0;
>> +		} else {
>> +			dput(namespaces);
>> +		}
>> +	}
>> +	inode_unlock(root_inode);
>> +
>> +	if (ret)
>> +		pr_err("proc_setup_namespaces: can't allocate /proc/namespaces\n");
>> +	else
>> +		fs_info->proc_namespaces = namespaces;
>> +
>> +	return ret;
>> +}
>> +
>> +void __init proc_namespaces_init(void)
>> +{
>> +	proc_alloc_inum(&namespaces_inum);
>> +}
>> diff --git a/fs/proc/root.c b/fs/proc/root.c
>> index 5e444d4f9717..e4e4f90fca3d 100644
>> --- a/fs/proc/root.c
>> +++ b/fs/proc/root.c
>> @@ -206,6 +206,10 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
>>  		return -ENOMEM;
>>  	}
>>  
>> +	ret = proc_setup_namespaces(s);
>> +	if (ret)
>> +		return ret;
>> +
>>  	ret = proc_setup_self(s);
>>  	if (ret) {
>>  		return ret;
>> @@ -272,6 +276,9 @@ static void proc_kill_sb(struct super_block *sb)
>>  	dput(fs_info->proc_self);
>>  	dput(fs_info->proc_thread_self);
>>  
>> +	if (fs_info->proc_namespaces)
>> +		dput(fs_info->proc_namespaces);
>> +
>>  	kill_anon_super(sb);
>>  	put_pid_ns(fs_info->pid_ns);
>>  	kfree(fs_info);
>> @@ -289,6 +296,7 @@ void __init proc_root_init(void)
>>  {
>>  	proc_init_kmemcache();
>>  	set_proc_pid_nlink();
>> +	proc_namespaces_init();
>>  	proc_self_init();
>>  	proc_thread_self_init();
>>  	proc_symlink("mounts", NULL, "self/mounts");
>> @@ -326,8 +334,15 @@ static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentr
>>  
>>  static int proc_root_readdir(struct file *file, struct dir_context *ctx)
>>  {
>> -	if (ctx->pos < FIRST_PROCESS_ENTRY) {
>> +	if (ctx->pos < NAMESPACES_ENTRY) {
>>  		int error = proc_readdir(file, ctx);
>> +		if (unlikely(error <= 0))
>> +			return error;
>> +		ctx->pos = NAMESPACES_ENTRY;
>> +	}
>> +
>> +	if (ctx->pos == NAMESPACES_ENTRY) {
>> +		int error = proc_emit_namespaces(file, ctx);
>>  		if (unlikely(error <= 0))
>>  			return error;
>>  		ctx->pos = FIRST_PROCESS_ENTRY;
>> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
>> index 97b3f5f06db9..8b0002a6cacf 100644
>> --- a/include/linux/proc_fs.h
>> +++ b/include/linux/proc_fs.h
>> @@ -61,6 +61,7 @@ struct proc_fs_info {
>>  	struct pid_namespace *pid_ns;
>>  	struct dentry *proc_self;        /* For /proc/self */
>>  	struct dentry *proc_thread_self; /* For /proc/thread-self */
>> +	struct dentry *proc_namespaces;	 /* For /proc/namespaces */
>>  	kgid_t pid_gid;
>>  	enum proc_hidepid hide_pid;
>>  	enum proc_pidonly pidonly;
>>
>>

