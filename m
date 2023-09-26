Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B427AF096
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjIZQVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 12:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIZQVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:21:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE6A139;
        Tue, 26 Sep 2023 09:21:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06F5C433C8;
        Tue, 26 Sep 2023 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695745276;
        bh=il2c9PwkqYyTG1jHOzbY1MvMcvzoBdMMgsAXYbzx4i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9riywJkFigYP2bkgOJbcOgOSvdu0N6ZQlI/GNrt+AAcWiSm+BYhp87GmCF/auJqp
         eMn7m1Oo8++m/lYtXoEPfxbnkRUmlkoe5Nn1dpiCoZSpRd+Lhgh0jEe9qiJelchKYr
         q5L9SFf7+lSmxPTA4ZiGPY3GpeQEzpv/JEDd2TDiUANu3XwFiI5gDazm5wAoxqQAsX
         Z0M3xyh+5S8MSncnMS25mGZTFNq0Tr2JSSRhkenfcLMJgxiQKuxI/snP6CIRMTw2Ar
         i0lEntawkDvVj8AldjPpwLjtx7bMX4YFkoJnrWRiHAk3nm4443ByAsHLry6W27/4rO
         1iCJMa9b5maCA==
Date:   Tue, 26 Sep 2023 18:21:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v5 bpf-next 03/13] bpf: introduce BPF token object
Message-ID: <20230926-augen-biodiesel-fdb05e859aac@brauner>
References: <20230919214800.3803828-1-andrii@kernel.org>
 <20230919214800.3803828-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919214800.3803828-4-andrii@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:47:50PM -0700, Andrii Nakryiko wrote:
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
> through a new bpf() syscall command, BPF_TOKEN_CREAT, which accepts
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
> The alternative to creating BPF token object was:
>   a) not having any extra object and just pasing BPF FS path to each
>      relevant bpf() command. This seems suboptimal as it's racy (mount
>      under the same path might change in between checking it and using it
>      for bpf() command). And also less flexible if we'd like to further
>      restrict ourselves compared to all the delegated functionality
>      allowed on BPF FS.
>   b) use non-bpf() interface, e.g., ioctl(), but otherwise also create
>      a dedicated FD that would represent a token-like functionality. This
>      doesn't seem superior to having a proper bpf() command, so
>      BPF_TOKEN_CREATE was chosen.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  42 ++++++++
>  include/uapi/linux/bpf.h       |  39 +++++++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/inode.c             |   4 +-
>  kernel/bpf/syscall.c           |  17 +++
>  kernel/bpf/token.c             | 189 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  39 +++++++
>  7 files changed, 330 insertions(+), 2 deletions(-)
>  create mode 100644 kernel/bpf/token.c
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 026923a60cad..ae13538f5465 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -51,6 +51,8 @@ struct module;
>  struct bpf_func_state;
>  struct ftrace_ops;
>  struct cgroup;
> +struct bpf_token;
> +struct user_namespace;
>  
>  extern struct idr btf_idr;
>  extern spinlock_t btf_idr_lock;
> @@ -1572,6 +1574,13 @@ struct bpf_mount_opts {
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
> @@ -2162,6 +2171,8 @@ static inline void bpf_map_dec_elem_count(struct bpf_map *map)
>  
>  extern int sysctl_unprivileged_bpf_disabled;
>  
> +bool bpf_token_capable(const struct bpf_token *token, int cap);
> +
>  static inline bool bpf_allow_ptr_leaks(void)
>  {
>  	return perfmon_capable();
> @@ -2196,6 +2207,14 @@ int bpf_link_new_fd(struct bpf_link *link);
>  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>  
> +void bpf_token_inc(struct bpf_token *token);
> +void bpf_token_put(struct bpf_token *token);
> +int bpf_token_create(union bpf_attr *attr);
> +int bpf_token_new_fd(struct bpf_token *token);
> +struct bpf_token *bpf_token_get_from_fd(u32 ufd);
> +
> +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
> +
>  int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
>  int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
>  
> @@ -2557,6 +2576,29 @@ static inline int bpf_obj_get_user(const char __user *pathname, int flags)
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
> +static inline int bpf_token_new_fd(struct bpf_token *token)
> +{
> +	return -EOPNOTSUPP;
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
> index 73b155e52204..36e98c6f8944 100644
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
> @@ -1694,6 +1727,12 @@ union bpf_attr {
>  		__u32		flags;		/* extra flags */
>  	} prog_bind_map;
>  
> +	struct { /* struct used by BPF_TOKEN_CREATE command */
> +		__u32		flags;
> +		__u32		bpffs_path_fd;
> +		__u64		bpffs_pathname;
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
> index 8f66b57d3546..82f11fbffd3e 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -603,11 +603,13 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
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
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index f024caee0bba..93338faa43d5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5302,6 +5302,20 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
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
> @@ -5435,6 +5449,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
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
> index 000000000000..f6ea3eddbee6
> --- /dev/null
> +++ b/kernel/bpf/token.c
> @@ -0,0 +1,189 @@
> +#include <linux/bpf.h>
> +#include <linux/vmalloc.h>
> +#include <linux/anon_inodes.h>
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
> +static ssize_t bpf_dummy_read(struct file *filp, char __user *buf, size_t siz,
> +			      loff_t *ppos)
> +{
> +	/* We need this handler such that alloc_file() enables
> +	 * f_mode with FMODE_CAN_READ.
> +	 */
> +	return -EINVAL;
> +}
> +
> +static ssize_t bpf_dummy_write(struct file *filp, const char __user *buf,
> +			       size_t siz, loff_t *ppos)
> +{
> +	/* We need this handler such that alloc_file() enables
> +	 * f_mode with FMODE_CAN_WRITE.
> +	 */
> +	return -EINVAL;
> +}
> +
> +static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
> +{
> +	struct bpf_token *token = filp->private_data;
> +	u64 mask;
> +
> +	mask = (1ULL << __MAX_BPF_CMD) - 1;
> +	if ((token->allowed_cmds & mask) == mask)
> +		seq_printf(m, "allowed_cmds:\tany\n");
> +	else
> +		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
> +}
> +
> +static const struct file_operations bpf_token_fops = {
> +	.release	= bpf_token_release,
> +	.read		= bpf_dummy_read,
> +	.write		= bpf_dummy_write,
> +	.show_fdinfo	= bpf_token_show_fdinfo,
> +};
> +
> +static struct bpf_token *bpf_token_alloc(void)
> +{
> +	struct bpf_token *token;
> +
> +	token = kvzalloc(sizeof(*token), GFP_USER);
> +	if (!token)
> +		return NULL;
> +
> +	atomic64_set(&token->refcnt, 1);
> +
> +	return token;
> +}
> +
> +int bpf_token_create(union bpf_attr *attr)
> +{
> +	struct path path;
> +	struct bpf_mount_opts *mnt_opts;
> +	struct bpf_token *token;
> +	int ret;
> +
> +	ret = user_path_at(attr->token_create.bpffs_path_fd,
> +			   u64_to_user_ptr(attr->token_create.bpffs_pathname),
> +			   LOOKUP_FOLLOW | LOOKUP_EMPTY, &path);
> +	if (ret)
> +		return ret;
> +
> +	if (path.mnt->mnt_root != path.dentry) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	ret = path_permission(&path, MAY_ACCESS);
> +	if (ret)
> +		goto out;
> +
> +	token = bpf_token_alloc();
> +	if (!token) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* remember bpffs owning userns for future ns_capable() checks */
> +	token->userns = get_user_ns(path.dentry->d_sb->s_user_ns);
> +
> +	mnt_opts = path.dentry->d_sb->s_fs_info;
> +	token->allowed_cmds = mnt_opts->delegate_cmds;
> +
> +	ret = bpf_token_new_fd(token);
> +	if (ret < 0)
> +		bpf_token_free(token);
> +out:
> +	path_put(&path);
> +	return ret;
> +}
> +
> +#define BPF_TOKEN_INODE_NAME "bpf-token"
> +
> +/* Alloc anon_inode and FD for prepared token.
> + * Returns fd >= 0 on success; negative error, otherwise.
> + */
> +int bpf_token_new_fd(struct bpf_token *token)
> +{
> +	return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops, token, O_CLOEXEC);

It's unnecessary to use the anonymous inode infrastructure for bpf
tokens. It adds even more moving parts and makes reasoning about it even
harder. Just keep it all in bpffs. IIRC, something like the following
(broken, non-compiling draft) should work:

/* bpf_token_file - get an unlinked file living in bpffs */
struct file *bpf_token_file(...)
{
        inode = bpf_get_inode(bpffs_mnt->mnt_sb, dir, mode);
        inode->i_op = &bpf_token_iop;
        inode->i_fop = &bpf_token_fops;

	// some other stuff you might want or need

        res = alloc_file_pseudo(inode, bpffs_mnt, "bpf-token", O_RDWR, &bpf_token_fops);
}

Now set your private data that you might need, reserve an fd, install
the file into the fdtable and return the fd. You should have an unlinked
bpffs file that serves as your bpf token.
