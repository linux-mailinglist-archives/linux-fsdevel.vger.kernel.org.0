Return-Path: <linux-fsdevel+bounces-60911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49AEB52D57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2423A516C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8EF2EA746;
	Thu, 11 Sep 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaoX3LOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3B207A32;
	Thu, 11 Sep 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583099; cv=none; b=lc8IRGGTXzLQniZHiBoMe9zTOgg/t/AgZ/GuzOxGxdnx+UbIpjX0mbSp21g3zGa9ntqe7tq9u4yA7DZJBhT1OIs8R56+N4IsgbSBv0r4IY0cZNmuXTuuWAr03HZXaIskNhTM86BVI8u3pdtcO+UgX3qdE13nKc4DVMjDyH9t/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583099; c=relaxed/simple;
	bh=z75pw58mpU1J8jn8uDK81j/Jt6tUNtkYOdcRD35A4/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSlVXTxblyII5LZHMFb7yLqZR3c6WstVeVKfI+85SXyqyFF/bXUABRRs+zEiAIFD7Fg8iWBebfjMPvMrNVE2oqz8bjlO2+SD2vg+6R5i83mHOv8ct1OC2qWBGXvG9Pfs0CSNZfGJpMf4WaTbQJcDjdY/d2vaxbFTkMdhl52kQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaoX3LOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F021C4CEF0;
	Thu, 11 Sep 2025 09:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757583099;
	bh=z75pw58mpU1J8jn8uDK81j/Jt6tUNtkYOdcRD35A4/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaoX3LOV/jnceBoXDY0xHveKTV+2Iv/EfwWkiwJE6aNm57SGFK25WfhxafNju5RJy
	 iz/QiR2A19eGrqXnNXpg+AyR+ipcRR0nBnXyEgJdGiMJmouIuaaA559rhYXeD/eF4+
	 iyvnu5SQdc1qh0li51LCmsdDh4ByxqaIvEI7v0r5Lq96pqSX0IbpKTt+1gE6JAKAIB
	 1utZ83kizHL1Yk7zSIF8IJuw3DNtG7Y3q+QjrFNF74VkPNT+K5n0V4sq8kRQ8liGfA
	 x22V1tXu98kmCdVkkKN+gdULo1tIH7pCd//ufri8sZ6fVTfJbTTiA9A7J4UqtEBYVj
	 4mRQg1Pq+Wq3w==
Date: Thu, 11 Sep 2025 11:31:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 27/32] nsfs: support file handles
Message-ID: <20250911-werken-raubzug-64735473739c@brauner>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-27-4dd56e7359d8@kernel.org>
 <CAOQ4uxgtQQa-jzsnTBxgUTPzgtCiAaH8X6ffMqd+1Y5Jjy0dmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgtQQa-jzsnTBxgUTPzgtCiAaH8X6ffMqd+1Y5Jjy0dmQ@mail.gmail.com>

On Wed, Sep 10, 2025 at 07:21:22PM +0200, Amir Goldstein wrote:
> On Wed, Sep 10, 2025 at 4:39 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > A while ago we added support for file handles to pidfs so pidfds can be
> > encoded and decoded as file handles. Userspace has adopted this quickly
> > and it's proven very useful.
> 
> > Pidfd file handles are exhaustive meaning
> > they don't require a handle on another pidfd to pass to
> > open_by_handle_at() so it can derive the filesystem to decode in.
> >
> > Implement the exhaustive file handles for namespaces as well.
> 
> I think you decide to split the "exhaustive" part to another patch,
> so better drop this paragraph?

Yes, good point. I've dont that.

> I am missing an explanation about the permissions for
> opening these file handles.
> 
> My understanding of the code is that the opener needs to meet one of
> the conditions:
> 1. user has CAP_SYS_ADMIN in the userns owning the opened namespace
> 2. current task is in the opened namespace

Yes.

> 
> But I do not fully understand the rationale behind the 2nd condition,
> that is, when is it useful?

A caller is always able to open a file descriptor to it's own set of
namespaces. File handles will behave the same way.

> And as far as I can tell, your selftest does not cover this condition
> (only both true or both false)?

I've added this now.

> 
> I suggest to start with allowing only the useful and important
> cases, so if cond #1 is useful enough, drop cond #2 and we can add
> it later if needed and then your selftests already cover cond #1 true and false.
> 
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> After documenting the permissions, with ot without dropping cond #2
> feel free to add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks!

> 
> > ---
> >  fs/nsfs.c                | 176 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/exportfs.h |   6 ++
> >  2 files changed, 182 insertions(+)
> >
> > diff --git a/fs/nsfs.c b/fs/nsfs.c
> > index 6f8008177133..a1585a2f4f03 100644
> > --- a/fs/nsfs.c
> > +++ b/fs/nsfs.c
> > @@ -13,6 +13,12 @@
> >  #include <linux/nsfs.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/mnt_namespace.h>
> > +#include <linux/ipc_namespace.h>
> > +#include <linux/time_namespace.h>
> > +#include <linux/utsname.h>
> > +#include <linux/exportfs.h>
> > +#include <linux/nstree.h>
> > +#include <net/net_namespace.h>
> >
> >  #include "mount.h"
> >  #include "internal.h"
> > @@ -417,12 +423,182 @@ static const struct stashed_operations nsfs_stashed_ops = {
> >         .put_data = nsfs_put_data,
> >  };
> >
> > +struct nsfs_fid {
> > +       u64 ns_id;
> > +       u32 ns_type;
> > +       u32 ns_inum;
> > +} __attribute__ ((packed));
> > +
> > +#define NSFS_FID_SIZE (sizeof(struct nsfs_fid) / sizeof(u32))
> > +
> > +static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> > +                         struct inode *parent)
> > +{
> > +       struct nsfs_fid *fid = (struct nsfs_fid *)fh;
> > +       struct ns_common *ns = inode->i_private;
> > +       int len = *max_len;
> > +
> > +       /*
> > +        * TODO:
> > +        * For hierarchical namespaces we should start to encode the
> > +        * parent namespace. Then userspace can walk a namespace
> > +        * hierarchy purely based on file handles.
> > +        */
> > +       if (parent)
> > +               return FILEID_INVALID;
> > +
> > +       if (len < NSFS_FID_SIZE) {
> > +               *max_len = NSFS_FID_SIZE;
> > +               return FILEID_INVALID;
> > +       }
> > +
> > +       len  = NSFS_FID_SIZE;
> > +
> > +       fid->ns_id = ns->ns_id;
> > +       fid->ns_type = ns->ops->type;
> > +       fid->ns_inum = inode->i_ino;
> > +       *max_len = len;
> > +       return FILEID_NSFS;
> > +}
> > +
> > +static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
> > +                                       int fh_len, int fh_type)
> > +{
> > +       struct path path __free(path_put) = {};
> > +       struct nsfs_fid *fid = (struct nsfs_fid *)fh;
> > +       struct user_namespace *owning_ns = NULL;
> > +       struct ns_common *ns;
> > +       int ret;
> > +
> > +       if (fh_len < NSFS_FID_SIZE)
> > +               return NULL;
> > +
> > +       switch (fh_type) {
> > +       case FILEID_NSFS:
> > +               break;
> > +       default:
> > +               return NULL;
> > +       }
> > +
> > +       scoped_guard(rcu) {
> > +               ns = ns_tree_lookup_rcu(fid->ns_id, fid->ns_type);
> > +               if (!ns)
> > +                       return NULL;
> > +
> > +               VFS_WARN_ON_ONCE(ns->ns_id != fid->ns_id);
> > +               VFS_WARN_ON_ONCE(ns->ops->type != fid->ns_type);
> > +               VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
> > +
> > +               if (!refcount_inc_not_zero(&ns->count))
> > +                       return NULL;
> > +       }
> > +
> > +       switch (ns->ops->type) {
> > +#ifdef CONFIG_CGROUPS
> > +       case CLONE_NEWCGROUP:
> > +               if (!current_in_namespace(to_cg_ns(ns)))
> > +                       owning_ns = to_cg_ns(ns)->user_ns;
> > +               break;
> > +#endif
> > +#ifdef CONFIG_IPC_NS
> > +       case CLONE_NEWIPC:
> > +               if (!current_in_namespace(to_ipc_ns(ns)))
> > +                       owning_ns = to_ipc_ns(ns)->user_ns;
> > +               break;
> > +#endif
> > +       case CLONE_NEWNS:
> > +               if (!current_in_namespace(to_mnt_ns(ns)))
> > +                       owning_ns = to_mnt_ns(ns)->user_ns;
> > +               break;
> > +#ifdef CONFIG_NET_NS
> > +       case CLONE_NEWNET:
> > +               if (!current_in_namespace(to_net_ns(ns)))
> > +                       owning_ns = to_net_ns(ns)->user_ns;
> > +               break;
> > +#endif
> > +#ifdef CONFIG_PID_NS
> > +       case CLONE_NEWPID:
> > +               if (!current_in_namespace(to_pid_ns(ns))) {
> > +                       owning_ns = to_pid_ns(ns)->user_ns;
> > +               } else if (!READ_ONCE(to_pid_ns(ns)->child_reaper)) {
> > +                       ns->ops->put(ns);
> > +                       return ERR_PTR(-EPERM);
> > +               }
> > +               break;
> > +#endif
> > +#ifdef CONFIG_TIME_NS
> > +       case CLONE_NEWTIME:
> > +               if (!current_in_namespace(to_time_ns(ns)))
> > +                       owning_ns = to_time_ns(ns)->user_ns;
> > +               break;
> > +#endif
> > +#ifdef CONFIG_USER_NS
> > +       case CLONE_NEWUSER:
> > +               if (!current_in_namespace(to_user_ns(ns)))
> > +                       owning_ns = to_user_ns(ns);
> > +               break;
> > +#endif
> > +#ifdef CONFIG_UTS_NS
> > +       case CLONE_NEWUTS:
> > +               if (!current_in_namespace(to_uts_ns(ns)))
> > +                       owning_ns = to_uts_ns(ns)->user_ns;
> > +               break;
> > +#endif
> > +       default:
> > +               return ERR_PTR(-EOPNOTSUPP);
> > +       }
> > +
> > +       if (owning_ns && !ns_capable(owning_ns, CAP_SYS_ADMIN)) {
> > +               ns->ops->put(ns);
> > +               return ERR_PTR(-EPERM);
> > +       }
> > +
> > +       /* path_from_stashed() unconditionally consumes the reference. */
> > +       ret = path_from_stashed(&ns->stashed, nsfs_mnt, ns, &path);
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +
> > +       return no_free_ptr(path.dentry);
> > +}
> > +
> > +/*
> > + * Make sure that we reject any nonsensical flags that users pass via
> > + * open_by_handle_at().
> > + */
> > +#define VALID_FILE_HANDLE_OPEN_FLAGS \
> > +       (O_RDONLY | O_WRONLY | O_RDWR | O_NONBLOCK | O_CLOEXEC | O_EXCL)
> > +
> > +static int nsfs_export_permission(struct handle_to_path_ctx *ctx,
> > +                                  unsigned int oflags)
> > +{
> > +       if (oflags & ~(VALID_FILE_HANDLE_OPEN_FLAGS | O_LARGEFILE))
> > +               return -EINVAL;
> > +
> > +       /* nsfs_fh_to_dentry() is performs further permission checks. */
> > +       return 0;
> > +}
> > +
> > +static struct file *nsfs_export_open(struct path *path, unsigned int oflags)
> > +{
> > +       /* Clear O_LARGEFILE as open_by_handle_at() forces it. */
> > +       oflags &= ~O_LARGEFILE;
> > +       return file_open_root(path, "", oflags, 0);
> > +}
> > +
> > +static const struct export_operations nsfs_export_operations = {
> > +       .encode_fh      = nsfs_encode_fh,
> > +       .fh_to_dentry   = nsfs_fh_to_dentry,
> > +       .open           = nsfs_export_open,
> > +       .permission     = nsfs_export_permission,
> > +};
> > +
> >  static int nsfs_init_fs_context(struct fs_context *fc)
> >  {
> >         struct pseudo_fs_context *ctx = init_pseudo(fc, NSFS_MAGIC);
> >         if (!ctx)
> >                 return -ENOMEM;
> >         ctx->ops = &nsfs_ops;
> > +       ctx->eops = &nsfs_export_operations;
> >         ctx->dops = &ns_dentry_operations;
> >         fc->s_fs_info = (void *)&nsfs_stashed_ops;
> >         return 0;
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index cfb0dd1ea49c..3aac58a520c7 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -122,6 +122,12 @@ enum fid_type {
> >         FILEID_BCACHEFS_WITHOUT_PARENT = 0xb1,
> >         FILEID_BCACHEFS_WITH_PARENT = 0xb2,
> >
> > +       /*
> > +        *
> > +        * 64 bit namespace identifier, 32 bit namespace type, 32 bit inode number.
> > +        */
> > +       FILEID_NSFS = 0xf1,
> > +
> >         /*
> >          * 64 bit unique kernfs id
> >          */
> >
> > --
> > 2.47.3
> >

