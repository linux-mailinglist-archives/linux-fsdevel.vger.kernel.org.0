Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED3045C69A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 15:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354631AbhKXOKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 09:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354598AbhKXOI0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:08:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ACC16154B;
        Wed, 24 Nov 2021 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637760994;
        bh=fNlRwuIqF41mMR60uyW1UQRe88mV+TpOsg4ATZ8RQ4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBl4ICCsc9j8n8yfHt2Mq0VvnfwRlROofh702INsEsENd/IKd6kWB0dOBy9hbBE4n
         M3jnQXhGaY43MEjdPe/M9XTcIq3K+0So0bm9eov/4QHH9/n3gVWFT5mh6yTzBuHh4E
         No83W0lWhHbZX/Jk5Pi4CmXkAy+IocbrUCBrevy3BYHHnsdUst/NvpvmnJxzqzQfXL
         CvDt7up+prqIcn3m58n4Bd4bNhNLx/pd38DCji3/guIj18P2wFiaU1JpqU6WYsAZ58
         /DvYg6Ngul4W2R3vOLtY0Sx3FGZlAlxQgTXIM+EYZGuWhXH+37NUmHs0pQpzMGEnpd
         S5nGuOHwxHQEA==
Date:   Wed, 24 Nov 2021 14:36:31 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: "mount -o lookup=..." support
Message-ID: <20211124133631.jftzzrymaf42mzcu@example.org>
References: <YZvuN0Wqmn7XB4dX@localhost.localdomain>
 <87r1b7lxti.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1b7lxti.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 02:50:17PM -0600, Eric W. Biederman wrote:
> Alexey Dobriyan <adobriyan@gmail.com> writes:
> 
> > Docker implements MaskedPaths configuration option
> >
> > 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
> >
> > to disable certain /proc files. It does overmount with /dev/null per
> > masked file.
> >
> > Give them proper mount option which selectively disables lookup/readdir
> > so that MaskedPaths doesn't need to be updated as time goes on.
> >
> > Syntax is
> >
> > 	mount -t proc proc -o lookup=cpuinfo/uptime /proc
> >
> > 	# ls /proc
> > 				...
> > 	dr-xr-xr-x   8 root       root          0 Nov 22 21:12 995
> > 	-r--r--r--   1 root       root          0 Nov 22 21:12 cpuinfo
> > 	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 self -> 1163
> > 	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 thread-self -> 1163/task/1163
> > 	-r--r--r--   1 root       root          0 Nov 22 21:12 uptime
> >
> > Works at top level only (1 lookup list per superblock)
> > Trailing slash is optional but saves 1 allocation.
> >
> > TODO:
> > 	think what to do with dcache entries across "mount -o remount,lookup=".

I had thoughts of creating whitelists for files in procfs, but I was
thinking about glob-patterns to reduce the size of the list to be passed.

> I think it would be fine, and in fact even a good idea to limit the
> masking of proc entries to the first mount and not allow them
> to be changed with remount.  Especially as this hiding these entries
> is to improve security.
> 
> If you do allow changes during remount it should not be any different
> from creation deletion of a file.  Which I think comes down to
> revalidate would need to check to see if the file is still visible.
> 
> That is the proc filesystem uses the distributed filesystem mechanisms
> for file availability.
> 
> A great big question is what can be usefully enabled (not overmounted)
> other then the subset of proc that are the pid files?
> 
> I suspect defining and validating useful and safe subsets of proc
> is both easier and more maintainable than providing a general mechanism
> for the files.
> 
> 
> I have not read your code in detail but I see some things that look
> wrong.  There is masking of the root directory lookup method, but not
> the root directory readdir.   In proc generic there is masking of
> readdir but not lookup.  Given that all you are looking at is the
> dentry name that seems like it has some very noticable limitations.
> 
> 
> If you do want a high performance masking implementation than I suspect
> the way to build it is to build a set of overlay directories that
> are rb_trees.  One set of directories for each proc super block.
> 
> Those directories could then point to appropriate struct proc_dir_entry.
> 
> All of the dcache operations could work on those overlay directory trees,
> and the operations that add/remove masked entries could manipulate those
> directory trees from the other side.
> 
> As it is I very much worry about what the singly linked lists will do to
> the performance of proc.
> 
> Eric
> 
> 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >
> >  fs/proc/generic.c       |   19 +++++--
> >  fs/proc/internal.h      |   23 +++++++++
> >  fs/proc/proc_net.c      |    2 
> >  fs/proc/root.c          |  115 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/proc_fs.h |    2 
> >  5 files changed, 152 insertions(+), 9 deletions(-)
> >
> > --- a/fs/proc/generic.c
> > +++ b/fs/proc/generic.c
> > @@ -282,7 +282,7 @@ struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
> >   * for success..
> >   */
> >  int proc_readdir_de(struct file *file, struct dir_context *ctx,
> > -		    struct proc_dir_entry *de)
> > +		    struct proc_dir_entry *de, const struct proc_lookup_list *ll)
> >  {
> >  	int i;
> >  
> > @@ -305,14 +305,18 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
> >  
> >  	do {
> >  		struct proc_dir_entry *next;
> > +
> >  		pde_get(de);
> >  		read_unlock(&proc_subdir_lock);
> > -		if (!dir_emit(ctx, de->name, de->namelen,
> > -			    de->low_ino, de->mode >> 12)) {
> > -			pde_put(de);
> > -			return 0;
> > +
> > +		if (ll ? in_lookup_list(ll, de->name, de->namelen) : true) {
> > +			if (!dir_emit(ctx, de->name, de->namelen, de->low_ino, de->mode >> 12)) {
> > +				pde_put(de);
> > +				return 0;
> > +			}
> > +			ctx->pos++;
> >  		}
> > -		ctx->pos++;
> > +
> >  		read_lock(&proc_subdir_lock);
> >  		next = pde_subdir_next(de);
> >  		pde_put(de);
> > @@ -330,7 +334,8 @@ int proc_readdir(struct file *file, struct dir_context *ctx)
> >  	if (fs_info->pidonly == PROC_PIDONLY_ON)
> >  		return 1;
> >  
> > -	return proc_readdir_de(file, ctx, PDE(inode));
> > +	return proc_readdir_de(file, ctx, PDE(inode),
> > +				PDE(inode) == &proc_root ? fs_info->lookup_list : NULL);
> >  }
> >  
> >  /*
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -190,7 +190,7 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
> >  extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int);
> >  struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
> >  extern int proc_readdir(struct file *, struct dir_context *);
> > -int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
> > +int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *, const struct proc_lookup_list *);
> >  
> >  static inline void pde_get(struct proc_dir_entry *pde)
> >  {
> > @@ -318,3 +318,24 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
> >  	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
> >  	pde->proc_dops = &proc_net_dentry_ops;
> >  }
> > +
> > +/*
> > + * "cpuinfo", "uptime" is represented as
> > + *
> > + *	(u8[]){
> > + *		7, 'c', 'p', 'u', 'i', 'n', 'f', 'o',
> > + *		6, 'u', 'p', 't', 'i', 'm', 'e',
> > + *		0
> > + *	}
> > + */
> > +struct proc_lookup_list {
> > +	u8 len;
> > +	char str[];
> > +};
> > +
> > +static inline struct proc_lookup_list *lookup_list_next(const struct proc_lookup_list *ll)
> > +{
> > +	return (struct proc_lookup_list *)((void *)ll + 1 + ll->len);
> > +}
> > +
> > +bool in_lookup_list(const struct proc_lookup_list *ll, const char *str, unsigned int len);
> > --- a/fs/proc/proc_net.c
> > +++ b/fs/proc/proc_net.c
> > @@ -321,7 +321,7 @@ static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
> >  	ret = -EINVAL;
> >  	net = get_proc_task_net(file_inode(file));
> >  	if (net != NULL) {
> > -		ret = proc_readdir_de(file, ctx, net->proc_net);
> > +		ret = proc_readdir_de(file, ctx, net->proc_net, NULL);
> >  		put_net(net);
> >  	}
> >  	return ret;
> > --- a/fs/proc/root.c
> > +++ b/fs/proc/root.c
> > @@ -35,18 +35,22 @@ struct proc_fs_context {
> >  	enum proc_hidepid	hidepid;
> >  	int			gid;
> >  	enum proc_pidonly	pidonly;
> > +	struct proc_lookup_list	*lookup_list;
> > +	unsigned int		lookup_list_len;
> >  };
> >  
> >  enum proc_param {
> >  	Opt_gid,
> >  	Opt_hidepid,
> >  	Opt_subset,
> > +	Opt_lookup,
> >  };
> >  
> >  static const struct fs_parameter_spec proc_fs_parameters[] = {
> >  	fsparam_u32("gid",	Opt_gid),
> >  	fsparam_string("hidepid",	Opt_hidepid),
> >  	fsparam_string("subset",	Opt_subset),
> > +	fsparam_string("lookup",	Opt_lookup),
> >  	{}
> >  };
> >  
> > @@ -112,6 +116,65 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
> >  	return 0;
> >  }
> >  
> > +static int proc_parse_lookup_param(struct fs_context *fc, char *str0)
> > +{
> > +	struct proc_fs_context *ctx = fc->fs_private;
> > +	struct proc_lookup_list *ll;
> > +	char *str;
> > +	const char *slash;
> > +	const char *src;
> > +	unsigned int len;
> > +	int rv;
> > +
> > +	/* Force trailing slash, simplify loops below. */
> > +	len = strlen(str0);
> > +	if (len > 0 && str0[len - 1] == '/') {
> > +		str = str0;
> > +	} else {
> > +		str = kmalloc(len + 2, GFP_KERNEL);
> > +		if (!str) {
> > +			rv = -ENOMEM;
> > +			goto out;
> > +		}
> > +		memcpy(str, str0, len);
> > +		str[len] = '/';
> > +		str[len + 1] = '\0';
> > +	}
> > +
> > +	len = 0;
> > +	for (src = str; (slash = strchr(src, '/')); src = slash + 1) {
> > +		if (slash - src >= 256) {
> > +			rv = -EINVAL;
> > +			goto out_free_str;
> > +		}
> > +		len += 1 + (slash - src);
> > +	}
> > +	len += 1;
> > +
> > +	ctx->lookup_list = ll = kmalloc(len, GFP_KERNEL);
> > +	ctx->lookup_list_len = len;
> > +	if (!ll) {
> > +		rv = -ENOMEM;
> > +		goto out_free_str;
> > +	}
> > +
> > +	for (src = str; (slash = strchr(src, '/')); src = slash + 1) {
> > +		ll->len = slash - src;
> > +		memcpy(ll->str, src, ll->len);
> > +		ll = lookup_list_next(ll);
> > +	}
> > +	ll->len = 0;
> > +
> > +	rv = 0;
> > +
> > +out_free_str:
> > +	if (str != str0) {
> > +		kfree(str);
> > +	}
> > +out:
> > +	return rv;
> > +}
> > +
> >  static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >  {
> >  	struct proc_fs_context *ctx = fc->fs_private;
> > @@ -137,6 +200,11 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >  			return -EINVAL;
> >  		break;
> >  
> > +	case Opt_lookup:
> > +		if (proc_parse_lookup_param(fc, param->string) < 0)
> > +			return -EINVAL;
> > +		break;
> > +
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -157,6 +225,10 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
> >  		fs_info->hide_pid = ctx->hidepid;
> >  	if (ctx->mask & (1 << Opt_subset))
> >  		fs_info->pidonly = ctx->pidonly;
> > +	if (ctx->mask & (1 << Opt_lookup)) {
> > +		fs_info->lookup_list = ctx->lookup_list;
> > +		ctx->lookup_list = NULL;
> > +	}
> >  }
> >  
> >  static int proc_fill_super(struct super_block *s, struct fs_context *fc)
> > @@ -234,11 +306,34 @@ static void proc_fs_context_free(struct fs_context *fc)
> >  	struct proc_fs_context *ctx = fc->fs_private;
> >  
> >  	put_pid_ns(ctx->pid_ns);
> > +	kfree(ctx->lookup_list);
> >  	kfree(ctx);
> >  }
> >  
> > +static int proc_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
> > +{
> > +	struct proc_fs_context *src = fc->fs_private;
> > +	struct proc_fs_context *dst;
> > +
> > +	dst = kmemdup(src, sizeof(struct proc_fs_context), GFP_KERNEL);
> > +	if (!dst) {
> > +		return -ENOMEM;
> > +	}
> > +
> > +	get_pid_ns(dst->pid_ns);
> > +	dst->lookup_list = kmemdup(dst->lookup_list, dst->lookup_list_len, GFP_KERNEL);
> > +	if (!dst->lookup_list) {
> > +		kfree(dst);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	fc->fs_private = dst;
> > +	return 0;
> > +}
> > +
> >  static const struct fs_context_operations proc_fs_context_ops = {
> >  	.free		= proc_fs_context_free,
> > +	.dup		= proc_fs_context_dup,
> >  	.parse_param	= proc_parse_param,
> >  	.get_tree	= proc_get_tree,
> >  	.reconfigure	= proc_reconfigure,
> > @@ -274,6 +369,7 @@ static void proc_kill_sb(struct super_block *sb)
> >  
> >  	kill_anon_super(sb);
> >  	put_pid_ns(fs_info->pid_ns);
> > +	kfree(fs_info->lookup_list);
> >  	kfree(fs_info);
> >  }
> >  
> > @@ -317,11 +413,30 @@ static int proc_root_getattr(struct user_namespace *mnt_userns,
> >  	return 0;
> >  }
> >  
> > +bool in_lookup_list(const struct proc_lookup_list *ll, const char *str, unsigned int len)
> > +{
> > +	while (ll->len > 0) {
> > +		if (ll->len == len && strncmp(ll->str, str, len) == 0) {
> > +			return true;
> > +		}
> > +		ll = lookup_list_next(ll);
> > +	}
> > +	return false;
> > +}
> > +
> >  static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, unsigned int flags)
> >  {
> > +	struct proc_fs_info *proc_sb = proc_sb_info(dir->i_sb);
> > +
> >  	if (!proc_pid_lookup(dentry, flags))
> >  		return NULL;
> >  
> > +	/* Top level only for now */
> > +	if (proc_sb->lookup_list &&
> > +	    !in_lookup_list(proc_sb->lookup_list, dentry->d_name.name, dentry->d_name.len)) {
> > +		    return NULL;
> > +	}
> > +
> >  	return proc_lookup(dir, dentry, flags);
> >  }
> >  
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/fs.h>
> >  
> >  struct proc_dir_entry;
> > +struct proc_lookup_list;
> >  struct seq_file;
> >  struct seq_operations;
> >  
> > @@ -65,6 +66,7 @@ struct proc_fs_info {
> >  	kgid_t pid_gid;
> >  	enum proc_hidepid hide_pid;
> >  	enum proc_pidonly pidonly;
> > +	const struct proc_lookup_list *lookup_list;
> >  };
> >  
> >  static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
> 

-- 
Rgrds, legion

