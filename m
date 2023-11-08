Return-Path: <linux-fsdevel+bounces-2392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B640F7E58DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 15:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E22813AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9A01BDD3;
	Wed,  8 Nov 2023 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7FJUrn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF610A15;
	Wed,  8 Nov 2023 14:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297A3C433C8;
	Wed,  8 Nov 2023 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699453700;
	bh=eJxbZapPm/6M0I+XUp9Btzt+1gIkmjAVDtIG6A3NHkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7FJUrn/l1AoVJwJZL/0ZUUfeu7zUDGxPeuvc5WV46riT0UEupLbqAqYfC4jSHRWw
	 O/xrNJnyGDXqXXnJgcvjMVxYnfDllYOOKAO1bkIv8fZVk1HMlLMvb49V4XPRWpKC5L
	 zD+a4xLtYI6zhg42Um10Qgs11gIcDmPfP2yfdSXn/o+EgL5raZLh9cQq2X6FH9xHZs
	 eYPRwghj38qdpljaUwNE+PPN0MUEVbzqzIZR0c5JkUGBtcqPdnObiurqAnfoHJJmFF
	 oYIzu9+MfxvLKb5ADDoj2cZscNfRmVBzQhXIlYDRt3GMHFpfi1bUolqadyAOPIbmkp
	 TZW3lPPuVLcBw==
Date: Wed, 8 Nov 2023 15:28:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v9 bpf-next 03/17] bpf: introduce BPF token object
Message-ID: <20231108-verbuchen-unteilbar-9005061e2b48@brauner>
References: <20231103190523.6353-1-andrii@kernel.org>
 <20231103190523.6353-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103190523.6353-4-andrii@kernel.org>

On Fri, Nov 03, 2023 at 12:05:09PM -0700, Andrii Nakryiko wrote:
> Add new kind of BPF kernel object, BPF token. BPF token is meant to
> allow delegating privileged BPF functionality, like loading a BPF
> program or creating a BPF map, from privileged process to a *trusted*
> unprivileged process, all while have a good amount of control over which
> privileged operations could be performed using provided BPF token.
> 
> This is achieved through mounting BPF FS instance with extra delegation
> mount options, which determine what operations are delegatable, and also
> constraining it to the owning user namespace (as mentioned in the
> previous patch).
> 
> BPF token itself is just a derivative from BPF FS and can be created
> through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts
> a path specification (using the usual fd + string path combo) to a BPF
> FS mount. Currently, BPF token "inherits" delegated command, map types,
> prog type, and attach type bit sets from BPF FS as is. In the future,
> having an BPF token as a separate object with its own FD, we can allow
> to further restrict BPF token's allowable set of things either at the creation
> time or after the fact, allowing the process to guard itself further
> from, e.g., unintentionally trying to load undesired kind of BPF
> programs. But for now we keep things simple and just copy bit sets as is.
> 
> When BPF token is created from BPF FS mount, we take reference to the
> BPF super block's owning user namespace, and then use that namespace for
> checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> capabilities that are normally only checked against init userns (using
> capable()), but now we check them using ns_capable() instead (if BPF
> token is provided). See bpf_token_capable() for details.
> 
> Such setup means that BPF token in itself is not sufficient to grant BPF
> functionality. User namespaced process has to *also* have necessary
> combination of capabilities inside that user namespace. So while
> previously CAP_BPF was useless when granted within user namespace, now
> it gains a meaning and allows container managers and sys admins to have
> a flexible control over which processes can and need to use BPF
> functionality within the user namespace (i.e., container in practice).
> And BPF FS delegation mount options and derived BPF tokens serve as
> a per-container "flag" to grant overall ability to use bpf() (plus further
> restrict on which parts of bpf() syscalls are treated as namespaced).
> 
> Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
> within the BPF FS owning user namespace, rounding up the ns_capable()
> story of BPF token.
> 
> The alternative to creating BPF token object was:
>   a) not having any extra object and just pasing BPF FS path to each
>      relevant bpf() command. This seems suboptimal as it's racy (mount
>      under the same path might change in between checking it and using it
>      for bpf() command). And also less flexible if we'd like to further

I don't understand "mount under the same path might change in between
checking it and using it for bpf() command".

Just require userspace to open() the bpffs instance and pass that fd to
bpf() just as you're doing right now. If that is racy then the current
implementation is even more so because it is passing:

bpffs_path_fd
bpffs_pathname

and then performs a lookup. More on that below.

I want to point out that most of this code here is unnecessary if you
use the bpffs fd itself as a token. But that's your decision. I'm just
saying that I'm not sure the critique that it's racy is valid.

>      restrict ourselves compared to all the delegated functionality
>      allowed on BPF FS.
>   b) use non-bpf() interface, e.g., ioctl(), but otherwise also create
>      a dedicated FD that would represent a token-like functionality. This
>      doesn't seem superior to having a proper bpf() command, so
>      BPF_TOKEN_CREATE was chosen.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  41 +++++++
>  include/uapi/linux/bpf.h       |  39 +++++++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/inode.c             |  17 ++-
>  kernel/bpf/syscall.c           |  17 +++
>  kernel/bpf/token.c             | 197 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  39 +++++++
>  7 files changed, 342 insertions(+), 10 deletions(-)
>  create mode 100644 kernel/bpf/token.c
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index df50a7bf1a77..5ab418c78876 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -51,6 +51,10 @@ struct module;
>  struct bpf_func_state;
>  struct ftrace_ops;
>  struct cgroup;
> +struct bpf_token;
> +struct user_namespace;
> +struct super_block;
> +struct inode;
>  
>  extern struct idr btf_idr;
>  extern spinlock_t btf_idr_lock;
> @@ -1572,6 +1576,13 @@ struct bpf_mount_opts {
>  	u64 delegate_attachs;
>  };
>  
> +struct bpf_token {
> +	struct work_struct work;
> +	atomic64_t refcnt;
> +	struct user_namespace *userns;
> +	u64 allowed_cmds;
> +};
> +
>  struct bpf_struct_ops_value;
>  struct btf_member;
>  
> @@ -2029,6 +2040,7 @@ static inline void bpf_enable_instrumentation(void)
>  	migrate_enable();
>  }
>  
> +extern const struct super_operations bpf_super_ops;
>  extern const struct file_operations bpf_map_fops;
>  extern const struct file_operations bpf_prog_fops;
>  extern const struct file_operations bpf_iter_fops;
> @@ -2163,6 +2175,8 @@ static inline void bpf_map_dec_elem_count(struct bpf_map *map)
>  
>  extern int sysctl_unprivileged_bpf_disabled;
>  
> +bool bpf_token_capable(const struct bpf_token *token, int cap);
> +
>  static inline bool bpf_allow_ptr_leaks(void)
>  {
>  	return perfmon_capable();
> @@ -2197,8 +2211,17 @@ int bpf_link_new_fd(struct bpf_link *link);
>  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>  
> +void bpf_token_inc(struct bpf_token *token);
> +void bpf_token_put(struct bpf_token *token);
> +int bpf_token_create(union bpf_attr *attr);
> +struct bpf_token *bpf_token_get_from_fd(u32 ufd);
> +
> +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
> +
>  int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
>  int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
> +struct inode *bpf_get_inode(struct super_block *sb, const struct inode *dir,
> +			    umode_t mode);
>  
>  #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
>  #define DEFINE_BPF_ITER_FUNC(target, args...)			\
> @@ -2561,6 +2584,24 @@ static inline int bpf_obj_get_user(const char __user *pathname, int flags)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline bool bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +	return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> +}
> +
> +static inline void bpf_token_inc(struct bpf_token *token)
> +{
> +}
> +
> +static inline void bpf_token_put(struct bpf_token *token)
> +{
> +}
> +
> +static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
>  static inline void __dev_flush(void)
>  {
>  }
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..f75f289f1749 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -847,6 +847,37 @@ union bpf_iter_link_info {
>   *		Returns zero on success. On error, -1 is returned and *errno*
>   *		is set appropriately.
>   *
> + * BPF_TOKEN_CREATE
> + *	Description
> + *		Create BPF token with embedded information about what
> + *		BPF-related functionality it allows:
> + *		- a set of allowed bpf() syscall commands;
> + *		- a set of allowed BPF map types to be created with
> + *		BPF_MAP_CREATE command, if BPF_MAP_CREATE itself is allowed;
> + *		- a set of allowed BPF program types and BPF program attach
> + *		types to be loaded with BPF_PROG_LOAD command, if
> + *		BPF_PROG_LOAD itself is allowed.
> + *
> + *		BPF token is created (derived) from an instance of BPF FS,
> + *		assuming it has necessary delegation mount options specified.
> + *		BPF FS mount is specified with openat()-style path FD + string.
> + *		This BPF token can be passed as an extra parameter to various
> + *		bpf() syscall commands to grant BPF subsystem functionality to
> + *		unprivileged processes.
> + *
> + *		When created, BPF token is "associated" with the owning
> + *		user namespace of BPF FS instance (super block) that it was
> + *		derived from, and subsequent BPF operations performed with
> + *		BPF token would be performing capabilities checks (i.e.,
> + *		CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN) within
> + *		that user namespace. Without BPF token, such capabilities
> + *		have to be granted in init user namespace, making bpf()
> + *		syscall incompatible with user namespace, for the most part.
> + *
> + *	Return
> + *		A new file descriptor (a nonnegative integer), or -1 if an
> + *		error occurred (in which case, *errno* is set appropriately).
> + *
>   * NOTES
>   *	eBPF objects (maps and programs) can be shared between processes.
>   *
> @@ -901,6 +932,8 @@ enum bpf_cmd {
>  	BPF_ITER_CREATE,
>  	BPF_LINK_DETACH,
>  	BPF_PROG_BIND_MAP,
> +	BPF_TOKEN_CREATE,
> +	__MAX_BPF_CMD,
>  };
>  
>  enum bpf_map_type {
> @@ -1709,6 +1742,12 @@ union bpf_attr {
>  		__u32		flags;		/* extra flags */
>  	} prog_bind_map;
>  
> +	struct { /* struct used by BPF_TOKEN_CREATE command */
> +		__u32		flags;
> +		__u32		bpffs_path_fd;
> +		__aligned_u64	bpffs_pathname;
> +	} token_create;
> +
>  } __attribute__((aligned(8)));
>  
>  /* The description below is an attempt at providing documentation to eBPF
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index f526b7573e97..4ce95acfcaa7 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
>  endif
>  CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
>  
> -obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
> +obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index e49e93bc65e3..3418a0edf7b4 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -99,9 +99,9 @@ static const struct inode_operations bpf_prog_iops = { };
>  static const struct inode_operations bpf_map_iops  = { };
>  static const struct inode_operations bpf_link_iops  = { };
>  
> -static struct inode *bpf_get_inode(struct super_block *sb,
> -				   const struct inode *dir,
> -				   umode_t mode)
> +struct inode *bpf_get_inode(struct super_block *sb,
> +			    const struct inode *dir,
> +			    umode_t mode)
>  {
>  	struct inode *inode;
>  
> @@ -602,11 +602,13 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
>  {
>  	struct bpf_mount_opts *opts = root->d_sb->s_fs_info;
>  	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
> +	u64 mask;
>  
>  	if (mode != S_IRWXUGO)
>  		seq_printf(m, ",mode=%o", mode);
>  
> -	if (opts->delegate_cmds == ~0ULL)
> +	mask = (1ULL << __MAX_BPF_CMD) - 1;
> +	if ((opts->delegate_cmds & mask) == mask)
>  		seq_printf(m, ",delegate_cmds=any");
>  	else if (opts->delegate_cmds)
>  		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
> @@ -639,7 +641,7 @@ static void bpf_free_inode(struct inode *inode)
>  	free_inode_nonrcu(inode);
>  }
>  
> -static const struct super_operations bpf_super_ops = {
> +const struct super_operations bpf_super_ops = {
>  	.statfs		= simple_statfs,
>  	.drop_inode	= generic_delete_inode,
>  	.show_options	= bpf_show_options,
> @@ -814,10 +816,7 @@ static int bpf_get_tree(struct fs_context *fc)
>  
>  static void bpf_free_fc(struct fs_context *fc)
>  {
> -	struct bpf_mount_opts *opts = fc->s_fs_info;
> -
> -	if (opts)
> -		kfree(opts);
> +	kfree(fc->s_fs_info);
>  }
>  
>  static const struct fs_context_operations bpf_context_ops = {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ad4d8e433ccc..0565e46509a6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5346,6 +5346,20 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
>  	return ret;
>  }
>  
> +#define BPF_TOKEN_CREATE_LAST_FIELD token_create.bpffs_pathname
> +
> +static int token_create(union bpf_attr *attr)
> +{
> +	if (CHECK_ATTR(BPF_TOKEN_CREATE))
> +		return -EINVAL;
> +
> +	/* no flags are supported yet */
> +	if (attr->token_create.flags)
> +		return -EINVAL;
> +
> +	return bpf_token_create(attr);
> +}
> +
>  static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
>  {
>  	union bpf_attr attr;
> @@ -5479,6 +5493,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
>  	case BPF_PROG_BIND_MAP:
>  		err = bpf_prog_bind_map(&attr);
>  		break;
> +	case BPF_TOKEN_CREATE:
> +		err = token_create(&attr);
> +		break;
>  	default:
>  		err = -EINVAL;
>  		break;
> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> new file mode 100644
> index 000000000000..32fa395f829b
> --- /dev/null
> +++ b/kernel/bpf/token.c
> @@ -0,0 +1,197 @@
> +#include <linux/bpf.h>
> +#include <linux/vmalloc.h>
> +#include <linux/fdtable.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/idr.h>
> +#include <linux/namei.h>
> +#include <linux/user_namespace.h>
> +
> +bool bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +	/* BPF token allows ns_capable() level of capabilities */
> +	if (token) {
> +		if (ns_capable(token->userns, cap))
> +			return true;
> +		if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
> +			return true;
> +	}
> +	/* otherwise fallback to capable() checks */
> +	return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> +}
> +
> +void bpf_token_inc(struct bpf_token *token)
> +{
> +	atomic64_inc(&token->refcnt);
> +}
> +
> +static void bpf_token_free(struct bpf_token *token)
> +{
> +	put_user_ns(token->userns);
> +	kvfree(token);
> +}
> +
> +static void bpf_token_put_deferred(struct work_struct *work)
> +{
> +	struct bpf_token *token = container_of(work, struct bpf_token, work);
> +
> +	bpf_token_free(token);
> +}
> +
> +void bpf_token_put(struct bpf_token *token)
> +{
> +	if (!token)
> +		return;
> +
> +	if (!atomic64_dec_and_test(&token->refcnt))
> +		return;
> +
> +	INIT_WORK(&token->work, bpf_token_put_deferred);
> +	schedule_work(&token->work);
> +}
> +
> +static int bpf_token_release(struct inode *inode, struct file *filp)
> +{
> +	struct bpf_token *token = filp->private_data;
> +
> +	bpf_token_put(token);
> +	return 0;
> +}
> +
> +static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
> +{
> +	struct bpf_token *token = filp->private_data;
> +	u64 mask;
> +
> +	BUILD_BUG_ON(__MAX_BPF_CMD >= 64);
> +	mask = (1ULL << __MAX_BPF_CMD) - 1;
> +	if ((token->allowed_cmds & mask) == mask)
> +		seq_printf(m, "allowed_cmds:\tany\n");
> +	else
> +		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
> +}
> +
> +#define BPF_TOKEN_INODE_NAME "bpf-token"
> +
> +static const struct inode_operations bpf_token_iops = { };
> +
> +static const struct file_operations bpf_token_fops = {
> +	.release	= bpf_token_release,
> +	.show_fdinfo	= bpf_token_show_fdinfo,
> +};
> +
> +int bpf_token_create(union bpf_attr *attr)
> +{
> +	struct bpf_mount_opts *mnt_opts;
> +	struct bpf_token *token = NULL;
> +	struct user_namespace *userns;
> +	struct inode *inode;
> +	struct file *file;
> +	struct path path;
> +	umode_t mode;
> +	int err, fd;
> +
> +	err = user_path_at(attr->token_create.bpffs_path_fd,
> +			   u64_to_user_ptr(attr->token_create.bpffs_pathname),
> +			   LOOKUP_FOLLOW | LOOKUP_EMPTY, &path);

Do you really need bpffs_path_fd and bpffs_pathname?
This seems unnecessar as you're forcing a lookup that's best done in
userspace through regular open() apis. So I would just make this:

struct { /* struct used by BPF_TOKEN_CREATE command */
	__u32		flags;
	__u32		bpffs_path_fd;
} token_create;

In bpf_token_create() you can then just do:

        struct fd f;
        struct path path;

        f = fdget(attr->token_create.bpffs_path_fd);
        if (!f.file)
                return -EBADF;

        *path = f.file->f_path;
        path_get(path);
        fdput(f);

> +	if (err)
> +		return err;
> +
> +	if (path.mnt->mnt_root != path.dentry) {
> +		err = -EINVAL;
> +		goto out_path;
> +	}
> +	if (path.mnt->mnt_sb->s_op != &bpf_super_ops) {
> +		err = -EINVAL;
> +		goto out_path;
> +	}
> +	err = path_permission(&path, MAY_ACCESS);
> +	if (err)
> +		goto out_path;
> +
> +	userns = path.dentry->d_sb->s_user_ns;
> +	if (!ns_capable(userns, CAP_BPF)) {
> +		err = -EPERM;
> +		goto out_path;
> +	}
> +
> +	mode = S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
> +	inode = bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
> +	if (IS_ERR(inode)) {
> +		err = PTR_ERR(inode);
> +		goto out_path;
> +	}
> +
> +	inode->i_op = &bpf_token_iops;
> +	inode->i_fop = &bpf_token_fops;
> +	clear_nlink(inode); /* make sure it is unlinked */
> +
> +	file = alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
> +	if (IS_ERR(file)) {
> +		iput(inode);
> +		err = PTR_ERR(file);
> +		goto out_path;
> +	}
> +
> +	token = kvzalloc(sizeof(*token), GFP_USER);
> +	if (!token) {
> +		err = -ENOMEM;
> +		goto out_file;
> +	}
> +
> +	atomic64_set(&token->refcnt, 1);
> +
> +	/* remember bpffs owning userns for future ns_capable() checks */
> +	token->userns = get_user_ns(userns);
> +
> +	mnt_opts = path.dentry->d_sb->s_fs_info;
> +	token->allowed_cmds = mnt_opts->delegate_cmds;
> +
> +	fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0) {
> +		err = fd;
> +		goto out_token;
> +	}
> +
> +	file->private_data = token;
> +	fd_install(fd, file);
> +
> +	path_put(&path);
> +	return fd;
> +
> +out_token:
> +	bpf_token_free(token);
> +out_file:
> +	fput(file);
> +out_path:
> +	path_put(&path);
> +	return err;
> +}
> +
> +struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> +{
> +	struct fd f = fdget(ufd);
> +	struct bpf_token *token;
> +
> +	if (!f.file)
> +		return ERR_PTR(-EBADF);
> +	if (f.file->f_op != &bpf_token_fops) {
> +		fdput(f);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	token = f.file->private_data;
> +	bpf_token_inc(token);
> +	fdput(f);
> +
> +	return token;
> +}
> +
> +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
> +{
> +	if (!token)
> +		return false;
> +
> +	return token->allowed_cmds & (1ULL << cmd);
> +}
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..f75f289f1749 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -847,6 +847,37 @@ union bpf_iter_link_info {
>   *		Returns zero on success. On error, -1 is returned and *errno*
>   *		is set appropriately.
>   *
> + * BPF_TOKEN_CREATE
> + *	Description
> + *		Create BPF token with embedded information about what
> + *		BPF-related functionality it allows:
> + *		- a set of allowed bpf() syscall commands;
> + *		- a set of allowed BPF map types to be created with
> + *		BPF_MAP_CREATE command, if BPF_MAP_CREATE itself is allowed;
> + *		- a set of allowed BPF program types and BPF program attach
> + *		types to be loaded with BPF_PROG_LOAD command, if
> + *		BPF_PROG_LOAD itself is allowed.
> + *
> + *		BPF token is created (derived) from an instance of BPF FS,
> + *		assuming it has necessary delegation mount options specified.
> + *		BPF FS mount is specified with openat()-style path FD + string.
> + *		This BPF token can be passed as an extra parameter to various
> + *		bpf() syscall commands to grant BPF subsystem functionality to
> + *		unprivileged processes.
> + *
> + *		When created, BPF token is "associated" with the owning
> + *		user namespace of BPF FS instance (super block) that it was
> + *		derived from, and subsequent BPF operations performed with
> + *		BPF token would be performing capabilities checks (i.e.,
> + *		CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN) within
> + *		that user namespace. Without BPF token, such capabilities
> + *		have to be granted in init user namespace, making bpf()
> + *		syscall incompatible with user namespace, for the most part.
> + *
> + *	Return
> + *		A new file descriptor (a nonnegative integer), or -1 if an
> + *		error occurred (in which case, *errno* is set appropriately).
> + *
>   * NOTES
>   *	eBPF objects (maps and programs) can be shared between processes.
>   *
> @@ -901,6 +932,8 @@ enum bpf_cmd {
>  	BPF_ITER_CREATE,
>  	BPF_LINK_DETACH,
>  	BPF_PROG_BIND_MAP,
> +	BPF_TOKEN_CREATE,
> +	__MAX_BPF_CMD,
>  };
>  
>  enum bpf_map_type {
> @@ -1709,6 +1742,12 @@ union bpf_attr {
>  		__u32		flags;		/* extra flags */
>  	} prog_bind_map;
>  
> +	struct { /* struct used by BPF_TOKEN_CREATE command */
> +		__u32		flags;
> +		__u32		bpffs_path_fd;
> +		__aligned_u64	bpffs_pathname;
> +	} token_create;
> +
>  } __attribute__((aligned(8)));
>  
>  /* The description below is an attempt at providing documentation to eBPF
> -- 
> 2.34.1
> 

