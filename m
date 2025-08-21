Return-Path: <linux-fsdevel+bounces-58620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B354B2FFB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 18:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C137BE8E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393932D0627;
	Thu, 21 Aug 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekl5knYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FC29D272
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792792; cv=none; b=u/gtVJYnhdUZvgni5atzYVgobFoTFn19H6JJC63D8lMeX77hzC0egU1Bk2COGoYUzKmIYBCMsUrt9Dz0xx9bdvEhVlTeMs7Mh78EsVgvsJ/pHC5s22uwrY8/5R7+FhLYYuzVEfD3nECdJkQy84fHcM7/OKBzluss5nX/G6K2FCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792792; c=relaxed/simple;
	bh=/+Nnd4jYz6Q0S2KOc1wA5iVTitxPSg/zGz0CMvTk9eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4g/trWXghFJORx14yWQbcwOmaoHnvX9XbLK/yEAshKNEn1MWquNtBuLYk4Xj10EX5Jj6r7ZwpmG1e4zNKmECB6Qe5eXGv26WO6Up7sgAHTnpPyEF4EOWK+jnWJd/Roe+EvnuppnAKMe5rH2rbBchK3hpBlzDVfxTnRrwNvZe1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekl5knYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D04BC4CEEB;
	Thu, 21 Aug 2025 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755792792;
	bh=/+Nnd4jYz6Q0S2KOc1wA5iVTitxPSg/zGz0CMvTk9eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekl5knYj5g5LwrFjWtmlN1rAIbfLoBPL2krnzOu4P0J6E9djPRUdvuL9pX/9lcjx5
	 rucJjpvZpDGzSZNN5k8eu04zZNbqEYIQzAcGJdQ2cSJkWkzvx/vLSwiqYYqF7nGKqw
	 DQuq3M3JmsRprHEFV8Vz4rq/7JvpjQ+xwLzD64wTX8JEwqsd8TU/YGb4JeAyf8o/HT
	 X+r/7mInNn5xp4rbzF68zeKE5qE1DG4twrzudPLN+EuIJVRE1cMMByjMTreMwTLmHx
	 A1PWQJdEcWX+XimUwXM5+6ez0uFOELvT5qchnDfpho4H+nulAQSaBbnvZZCpoUsWrj
	 dxuNdqiZJGzKA==
Date: Thu, 21 Aug 2025 09:13:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 05/23] fuse: move the passthrough-specific code back to
 passthrough.c
Message-ID: <20250821161311.GM7942@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
 <175573709222.17510.17568403217413241879.stgit@frogsfrogsfrogs>
 <CAOQ4uxg_A-Zck33c61_yn+jiWRW8OjKO4QxJQJ31Tci0sxFpQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg_A-Zck33c61_yn+jiWRW8OjKO4QxJQJ31Tci0sxFpQA@mail.gmail.com>

On Thu, Aug 21, 2025 at 11:05:28AM +0200, Amir Goldstein wrote:
> On Thu, Aug 21, 2025 at 2:53 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > In preparation for iomap, move the passthrough-specific validation code
> > back to passthrough.c and create a new Kconfig item for conditional
> > compilation of backing.c.  In the next patch, iomap will share the
> > backing structures.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h      |   14 ++++++
> >  fs/fuse/fuse_trace.h  |   35 ++++++++++++++++
> >  fs/fuse/Kconfig       |    4 ++
> >  fs/fuse/Makefile      |    3 +
> >  fs/fuse/backing.c     |  106 +++++++++++++++++++++++++++++++++++++------------
> >  fs/fuse/dev.c         |    4 +-
> >  fs/fuse/inode.c       |    4 +-
> >  fs/fuse/passthrough.c |   28 +++++++++++++
> >  8 files changed, 165 insertions(+), 33 deletions(-)
> >
> >

<snip to the relevant parts>

> > diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> > index ddb23b7400fc72..c128bed95a76b8 100644
> > --- a/fs/fuse/backing.c
> > +++ b/fs/fuse/backing.c
> > @@ -102,46 +101,68 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
> >         if (!file)
> >                 goto out;
> >
> > -       backing_sb = file_inode(file)->i_sb;
> > -       res = -ELOOP;
> > -       if (backing_sb->s_stack_depth >= fc->max_stack_depth)
> > -               goto out_fput;
> > -
> >         fb = kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
> >         res = -ENOMEM;
> >         if (!fb)
> > -               goto out_fput;
> > +               goto out_file;
> >
> > +       /* fb now owns file */
> >         fb->file = file;
> > +       file = NULL;
> >         fb->cred = prepare_creds();
> >         refcount_set(&fb->count, 1);
> >
> > +       /*
> > +        * Each _backing_open function should either:
> > +        *
> > +        * 1. Take a ref to fb if it wants the file and return 0.
> > +        * 2. Return 0 without taking a ref if the backing file isn't needed.
> > +        * 3. Return an errno explaining why it couldn't attach.
> > +        *
> > +        * If at least one subsystem bumps the reference count to open it,
> > +        * we'll install it into the index and return the index.  If nobody
> > +        * opens the file, the error code will be passed up.  EPERM is the
> > +        * default.
> > +        */
> > +       passthrough_res = fuse_passthrough_backing_open(fc, fb);
> > +
> > +       if (refcount_read(&fb->count) < 2) {
> > +               if (passthrough_res)
> > +                       res = passthrough_res;
> > +               if (!res)
> > +                       res = -EPERM;
> > +               goto out_fb;
> > +       }
> > +
> >         res = fuse_backing_id_alloc(fc, fb);
> > -       if (res < 0) {
> > -               fuse_backing_free(fb);
> > -               fb = NULL;
> > -       }
> > +       if (res < 0)
> > +               goto out_fb;
> > +
> > +       trace_fuse_backing_open(fc, res, fb);
> >
> > -out:
> >         pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
> > -
> > +       fuse_backing_put(fb);
> >         return res;
> >
> > -out_fput:
> > -       fput(file);
> > -       goto out;
> > +out_fb:
> > +       fuse_backing_free(fb);
> > +out_file:
> > +       if (file)
> > +               fput(file);
> > +out:
> > +       pr_debug("%s: ret=%i\n", __func__, res);
> > +       return res;
> >  }
> >
> >  int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> >  {
> > -       struct fuse_backing *fb = NULL;
> > -       int err;
> > +       struct fuse_backing *fb = NULL, *test_fb;
> > +       int err, passthrough_err;
> >
> >         pr_debug("%s: backing_id=%d\n", __func__, backing_id);
> >
> > -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> >         err = -EPERM;
> > -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > +       if (!fc->passthrough)
> >                 goto out;
> >
> >         err = -EINVAL;
> > @@ -149,12 +170,45 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> >                 goto out;
> >
> >         err = -ENOENT;
> > -       fb = fuse_backing_id_remove(fc, backing_id);
> > +       fb = fuse_backing_lookup(fc, backing_id);
> >         if (!fb)
> >                 goto out;
> >
> > +       /*
> > +        * Each _backing_close function should either:
> > +        *
> > +        * 1. Release the ref that it took in _backing_open and return 0.
> > +        * 2. Don't release the ref if the backing file is busy, and return 0.
> > +        * 2. Return an errno explaining why it couldn't detach.
> > +        *
> > +        * If there are no more active references to the backing file, it will
> > +        * be closed and removed from the index.  If there are still active
> > +        * references to the backing file other than the one we just took, the
> 
> That does not look right.
> The fuse_backing object can often outliive the backing_id mapping
> 1. fuse server attached backing fd to backing id 1
> 2. fuse server opens a file with passthrough to backing id 1
> 3. fuse inode holds a refcount to the fuse_backing object
> 4. fuse server closes backing id 1 mapping
> 5. fuse server closes file, drops last reference to fuse_backing object

Ah, I didn't account for backing files needing to outlive being
registered in the index.  Ok, my whole approach above is wrong. :)

> IOW, fb->count is not about being in the index.
> With your code the fuse server call in #4 above will end up leaving the
> fuse_backing object in the index and after #5 it will remain a dangling
> object in the index.
> 
> TBH, I don't understand why we need any of the complexity
> of two subsystems claiming the same fuse_backing object for two
> different purposes.

I decided I should explore your suggestion from v2:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxiZTTEOs4HYD0vGi3XtihyDiQbDFXBCuGKoJyFPQv_+Lw@mail.gmail.com/
...and it didn't occur to me that, well, there's plenty of device_id
address space so if some weird server has to register the same fd twice
for two subsystems to use it, that's completely ok. :)

> Also, I think that an explicit statement from the server about the
> purpose of the backing file is due (like your commit message implies)
> This could be easily done with the backing open flags member:

Hrm.  That /would/ eliminate all the stupid {iomap,passthrough}_res
juggling if you were only allowed to register a backing id with a
single subsystem.  Worst case, a hybrid iomap+passthrough fs ends up
with the same file registered with multiple ids.

Yeah, let's do that.

> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index c63990254649c..e5a675fca7505 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -96,7 +96,7 @@ int fuse_backing_open(struct fuse_conn *fc, struct
> fuse_backing_map *map)
>                 goto out;
> 
>         res = -EINVAL;
> -       if (map->flags || map->padding)
> +       if (map->flags & ~FUSE_BACKING_VALID_FLAGS || map->padding)
>                 goto out;
> 
>         file = fget_raw(map->fd);
> @@ -127,8 +127,10 @@ int fuse_backing_open(struct fuse_conn *fc,
> struct fuse_backing_map *map)
>          * opens the file, the error code will be passed up.  EPERM is the
>          * default.
>          */
> -       passthrough_res = fuse_passthrough_backing_open(fc, fb);
> -       iomap_res = fuse_iomap_backing_open(fc, fb);
> +       if (map->flags & FUSE_BACKING_IOMAP)
> +               iomap_res = fuse_iomap_backing_open(fc, fb);
> +       else
> +               passthrough_res = fuse_passthrough_backing_open(fc, fb);
> 
>         if (refcount_read(&fb->count) < 2) {
>                 if (passthrough_res)
> @@ -192,8 +194,10 @@ int fuse_backing_close(struct fuse_conn *fc, int
> backing_id)
>          * references to the backing file other than the one we just took, the
>          * error code will be passed up.  EBUSY is the default.
>          */
> -       passthrough_err = fuse_passthrough_backing_close(fc, fb);
> -       iomap_err = fuse_iomap_backing_close(fc, fb);
> +       if (fb->bdev)
> +               iomap_err = fuse_iomap_backing_close(fc, fb);
> +       else
> +               passthrough_err = fuse_passthrough_backing_close(fc, fb);

Yes, that's a lot better, thanks. :D

> 
>         if (refcount_read(&fb->count) > 1) {
>                 if (passthrough_err)
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 70b5530e587d4..ee81903ad2f98 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1148,6 +1148,10 @@ struct fuse_notify_retrieve_in {
>         uint64_t        dummy4;
>  };
> 
> +/* basic file I/O functionality through iomap */
> +#define FUSE_BACKING_IOMAP             (1 << 0)
> +#define FUSE_BACKING_VALID_FLAGS       (FUSE_BACKING_IOMAP)
> +
>  struct fuse_backing_map {
>         int32_t         fd;
>         uint32_t        flags;
> 
> 
> > +        * error code will be passed up.  EBUSY is the default.
> > +        */
> > +       passthrough_err = fuse_passthrough_backing_close(fc, fb);
> > +
> > +       if (refcount_read(&fb->count) > 1) {
> > +               if (passthrough_err)
> > +                       err = passthrough_err;
> > +               if (!err)
> > +                       err = -EBUSY;
> > +               goto out_fb;
> > +       }
> > +
> > +       trace_fuse_backing_close(fc, backing_id, fb);
> > +
> > +       err = -ENOENT;
> > +       test_fb = fuse_backing_id_remove(fc, backing_id);
> > +       if (!test_fb)
> > +               goto out_fb;
> > +
> > +       WARN_ON(fb != test_fb);
> > +       pr_debug("%s: fb=0x%p, err=0\n", __func__, fb);
> > +       fuse_backing_put(fb);
> > +       return 0;
> > +out_fb:
> >         fuse_backing_put(fb);
> > -       err = 0;
> >  out:
> >         pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index dbde17fff0cda9..31d9f006836ac1 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2623,7 +2623,7 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
> >         if (!fud)
> >                 return -EPERM;
> >
> > -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > +       if (!IS_ENABLED(CONFIG_FUSE_BACKING))
> >                 return -EOPNOTSUPP;
> >
> >         if (copy_from_user(&map, argp, sizeof(map)))
> > @@ -2640,7 +2640,7 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
> >         if (!fud)
> >                 return -EPERM;
> >
> > -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > +       if (!IS_ENABLED(CONFIG_FUSE_BACKING))
> >                 return -EOPNOTSUPP;
> >
> >         if (get_user(backing_id, argp))
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 9448a11c828fef..1f3f91981410aa 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -993,7 +993,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
> >         fc->name_max = FUSE_NAME_LOW_MAX;
> >         fc->timeout.req_timeout = 0;
> >
> > -       if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > +       if (IS_ENABLED(CONFIG_FUSE_BACKING))
> >                 fuse_backing_files_init(fc);
> >
> >         INIT_LIST_HEAD(&fc->mounts);
> > @@ -1030,7 +1030,7 @@ void fuse_conn_put(struct fuse_conn *fc)
> >                         WARN_ON(atomic_read(&bucket->count) != 1);
> >                         kfree(bucket);
> >                 }
> > -               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > +               if (IS_ENABLED(CONFIG_FUSE_BACKING))
> >                         fuse_backing_files_free(fc);
> >                 call_rcu(&fc->rcu, delayed_release);
> >         }
> > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > index e0b8d885bc81f3..dfc61cc4bd21af 100644
> > --- a/fs/fuse/passthrough.c
> > +++ b/fs/fuse/passthrough.c
> > @@ -197,3 +197,31 @@ void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb)
> >         put_cred(ff->cred);
> >         ff->cred = NULL;
> >  }
> > +
> > +int fuse_passthrough_backing_open(struct fuse_conn *fc,
> > +                                 struct fuse_backing *fb)
> > +{
> > +       struct super_block *backing_sb;
> > +
> > +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> > +       if (!capable(CAP_SYS_ADMIN))
> > +               return -EPERM;
> 
> This limitation is not specific to fuse passthrough.
> While the fuse passthrough use case is likely to request many fuse
> backing files,
> the limitation is here to protect from malicious actors and the same ioctl used
> by the iomap fuse server can just as well open many "lsof invisible" files,
> so the limitation should be in the generic function.

Hrmm.  Well for iomap block devices I'm not as worried because (a) you
sort of need privileges to open them, (b) there aren't that many block
devices, and (c) to use fuse-iomap at all you need CAP_SYS_RAWIO.

As for the invisibility problem, I wonder if I could just make
/sys/block/XXX/holder have a symlink to the fuse mount?  For fuse2fs we
need to maintain the open fd to /dev/XXX, but I suppose that's not
necessarily true for a fuse server.

> > +
> > +       backing_sb = file_inode(fb->file)->i_sb;
> > +       if (backing_sb->s_stack_depth >= fc->max_stack_depth)
> > +               return -ELOOP;
> > +
> > +       fuse_backing_get(fb);
> > +       return 0;
> > +}
> > +
> > +int fuse_passthrough_backing_close(struct fuse_conn *fc,
> > +                                  struct fuse_backing *fb)
> > +{
> > +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> > +       if (!capable(CAP_SYS_ADMIN))
> > +               return -EPERM;
> > +
> 
> Probably this comment in upstream is not very accurate because there is no
> harm done in closing the backing files, but sure for symmetry.
> Same comment as above through, unless there are reasons to relax
> CAP_SYS_ADMIN for file iomap, would leave this in the genetic code.

<nod>

> And then there is not much justification left for the close helpers IMO,
> especially given that the implementation wrt removing from index is
> incorrect, I would keep it simple:
> 
> @@ -175,11 +177,19 @@ int fuse_backing_close(struct fuse_conn *fc, int
> backing_id)
>         if (backing_id <= 0)
>                 goto out;
> 
> -       err = -ENOENT;
> -       fb = fuse_backing_lookup(fc, backing_id);
> -       if (!fb)
> +       err = -EPERM;
> +       if (!capable(CAP_SYS_ADMIN))
>                 goto out;
> 
> +       err = -EBUSY;
> +       if (fb->bdev)
> +               goto out;
> +
> +       fb = fuse_backing_id_remove(fc, backing_id);
> +       if (!fb)
> +               err = -ENOENT;
> +       goto out_fb;

I'll think about this, though I don't know how much of the security
checking would need to be relaxed to enable the completely locked down
fuse4fs systemd service that I was imagining.  My guess is that I'll
have to establish iomap capability (aka CAP_SYS_RAWIO) when /dev/fuse is
first opened by the mount helper, then the mount helper opens all the
block devices required, and finally it passes all these fds into the
contained service.

<shrug> As I said, food for thought for v5 :)

--D

> +
> 
> Thanks,
> Amir.
> 

