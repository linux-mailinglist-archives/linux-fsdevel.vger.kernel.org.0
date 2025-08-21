Return-Path: <linux-fsdevel+bounces-58622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171CCB2FFD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A0C1888963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5D2D949D;
	Thu, 21 Aug 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOaHil6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C71269D18
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792954; cv=none; b=QmvdCYYoADNViZdK+PM78txAOFmOuBYXWWVVgO42uFB/K6Q36R78d1BNDEJQo3rv88KPSux+r7TSh0aOFcu+hFJakO1tqb5tGb7pUFeDCaWourAGgrBN8AYSiguaibSq3+0fO2qvzumxWns3thdAEUx2wYzejekhgL/Y8KhNS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792954; c=relaxed/simple;
	bh=t1qSfp0mHt3vGmG3Q8b1XGAEikame2kgU3KiVMsv2W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMfma2GytIfyEWnuEd5iJsdsvdnv0q7WxtFm1VZOhaZ/yX/suioOlwL2aAAUrYa2t3i1RYs531PYQ42oU+ZeyI3RoZ6IkPApj9ihGBlj9ebtK3f20Nr/G2D1pEHYqZdLmm8GbhS9QOtIQF0iC6ROBM+Iaoi5LCdcfHHLZC0jYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOaHil6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA42C4CEEB;
	Thu, 21 Aug 2025 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755792953;
	bh=t1qSfp0mHt3vGmG3Q8b1XGAEikame2kgU3KiVMsv2W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOaHil6XyddV4xlgYMwHPkHiHBX0cwrBdwi7TkIaOI7OApJ/8Gh9Gn71YeCBfALgt
	 tUIeFsk62IcnCn+5kzek4Dpoz9jXvT5TDmBNbl7xsEaSpcMoQfC/tqfOdJPutX8L2l
	 wf0B/kRpPrqJDnFn4Bn+bxqnSVSDTl5rrwFGODxUyAnDoJUZIb7An6gs6N4O4xZM4K
	 B7danVcDEUmlsBye9ICQVtxu2+D6QwRjKu598BsZERRDcyW1B9W9o0o7XpmQS7/AW7
	 59idQWkl6nlrm3WG8mCyjuJlYjFqG5KngZ9cXLPKfHxRsajds1LvHpxB4Kxa6onbD6
	 1oM0Xlei1gWgA==
Date: Thu, 21 Aug 2025 09:15:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 04/23] fuse: move the backing file idr and code into a
 new source file
Message-ID: <20250821161553.GO7942@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
 <175573709201.17510.5887930789458651774.stgit@frogsfrogsfrogs>
 <CAOQ4uxi_aUvi5o=uLTonKViu3P-wZg_K8vs9m2DMSzOiDpA19w@mail.gmail.com>
 <CAOQ4uxg2=kxTvC4_DKR74oDZg4QMfmXXm5E_6VkS2G_LgGzEgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg2=kxTvC4_DKR74oDZg4QMfmXXm5E_6VkS2G_LgGzEgQ@mail.gmail.com>

On Thu, Aug 21, 2025 at 09:42:07AM +0200, Amir Goldstein wrote:
> On Thu, Aug 21, 2025 at 9:21 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Aug 21, 2025 at 2:53 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > iomap support for fuse is also going to want the ability to attach
> > > backing files to a fuse filesystem.  Move the fuse_backing code into a
> > > separate file so that both can use it.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Are you going to make FUSE_IOMAP depend on FUSE_PASSTHROUGH later on?
> > I can't think of a reason why not.
> 
> Ah I see. They will both depend on FUSE_BACKING
> cool

Yep.  Thanks for your feedback! :)

--D

> >
> > Thanks,
> > Amir.
> >
> > > ---
> > >  fs/fuse/fuse_i.h      |   47 ++++++++-----
> > >  fs/fuse/Makefile      |    2 -
> > >  fs/fuse/backing.c     |  174 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  fs/fuse/passthrough.c |  158 --------------------------------------------
> > >  4 files changed, 203 insertions(+), 178 deletions(-)
> > >  create mode 100644 fs/fuse/backing.c
> > >
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 2cd9f4cdc6a7ef..2be2cbdf060536 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -1535,29 +1535,11 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> > >  void fuse_file_release(struct inode *inode, struct fuse_file *ff,
> > >                        unsigned int open_flags, fl_owner_t id, bool isdir);
> > >
> > > -/* passthrough.c */
> > > -static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode *fi)
> > > -{
> > > -#ifdef CONFIG_FUSE_PASSTHROUGH
> > > -       return READ_ONCE(fi->fb);
> > > -#else
> > > -       return NULL;
> > > -#endif
> > > -}
> > > -
> > > -static inline struct fuse_backing *fuse_inode_backing_set(struct fuse_inode *fi,
> > > -                                                         struct fuse_backing *fb)
> > > -{
> > > -#ifdef CONFIG_FUSE_PASSTHROUGH
> > > -       return xchg(&fi->fb, fb);
> > > -#else
> > > -       return NULL;
> > > -#endif
> > > -}
> > > -
> > > +/* backing.c */
> > >  #ifdef CONFIG_FUSE_PASSTHROUGH
> > >  struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
> > >  void fuse_backing_put(struct fuse_backing *fb);
> > > +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id);
> > >  #else
> > >
> > >  static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
> > > @@ -1568,6 +1550,11 @@ static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
> > >  static inline void fuse_backing_put(struct fuse_backing *fb)
> > >  {
> > >  }
> > > +static inline struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
> > > +                                                      int backing_id)
> > > +{
> > > +       return NULL;
> > > +}
> > >  #endif
> > >
> > >  void fuse_backing_files_init(struct fuse_conn *fc);
> > > @@ -1575,6 +1562,26 @@ void fuse_backing_files_free(struct fuse_conn *fc);
> > >  int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
> > >  int fuse_backing_close(struct fuse_conn *fc, int backing_id);
> > >
> > > +/* passthrough.c */
> > > +static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode *fi)
> > > +{
> > > +#ifdef CONFIG_FUSE_PASSTHROUGH
> > > +       return READ_ONCE(fi->fb);
> > > +#else
> > > +       return NULL;
> > > +#endif
> > > +}
> > > +
> > > +static inline struct fuse_backing *fuse_inode_backing_set(struct fuse_inode *fi,
> > > +                                                         struct fuse_backing *fb)
> > > +{
> > > +#ifdef CONFIG_FUSE_PASSTHROUGH
> > > +       return xchg(&fi->fb, fb);
> > > +#else
> > > +       return NULL;
> > > +#endif
> > > +}
> > > +
> > >  struct fuse_backing *fuse_passthrough_open(struct file *file,
> > >                                            struct inode *inode,
> > >                                            int backing_id);
> > > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > > index 70709a7a3f9523..c79f786d0c90c3 100644
> > > --- a/fs/fuse/Makefile
> > > +++ b/fs/fuse/Makefile
> > > @@ -14,7 +14,7 @@ fuse-y := trace.o     # put trace.o first so we see ftrace errors sooner
> > >  fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
> > >  fuse-y += iomode.o
> > >  fuse-$(CONFIG_FUSE_DAX) += dax.o
> > > -fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
> > > +fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
> > >  fuse-$(CONFIG_SYSCTL) += sysctl.o
> > >  fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
> > >  fuse-$(CONFIG_FUSE_IOMAP) += file_iomap.o
> > > diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> > > new file mode 100644
> > > index 00000000000000..ddb23b7400fc72
> > > --- /dev/null
> > > +++ b/fs/fuse/backing.c
> > > @@ -0,0 +1,174 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * FUSE passthrough to backing file.
> > > + *
> > > + * Copyright (c) 2023 CTERA Networks.
> > > + */
> > > +
> > > +#include "fuse_i.h"
> > > +
> > > +#include <linux/file.h>
> > > +
> > > +struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
> > > +{
> > > +       if (fb && refcount_inc_not_zero(&fb->count))
> > > +               return fb;
> > > +       return NULL;
> > > +}
> > > +
> > > +static void fuse_backing_free(struct fuse_backing *fb)
> > > +{
> > > +       pr_debug("%s: fb=0x%p\n", __func__, fb);
> > > +
> > > +       if (fb->file)
> > > +               fput(fb->file);
> > > +       put_cred(fb->cred);
> > > +       kfree_rcu(fb, rcu);
> > > +}
> > > +
> > > +void fuse_backing_put(struct fuse_backing *fb)
> > > +{
> > > +       if (fb && refcount_dec_and_test(&fb->count))
> > > +               fuse_backing_free(fb);
> > > +}
> > > +
> > > +void fuse_backing_files_init(struct fuse_conn *fc)
> > > +{
> > > +       idr_init(&fc->backing_files_map);
> > > +}
> > > +
> > > +static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
> > > +{
> > > +       int id;
> > > +
> > > +       idr_preload(GFP_KERNEL);
> > > +       spin_lock(&fc->lock);
> > > +       /* FIXME: xarray might be space inefficient */
> > > +       id = idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMIC);
> > > +       spin_unlock(&fc->lock);
> > > +       idr_preload_end();
> > > +
> > > +       WARN_ON_ONCE(id == 0);
> > > +       return id;
> > > +}
> > > +
> > > +static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
> > > +                                                  int id)
> > > +{
> > > +       struct fuse_backing *fb;
> > > +
> > > +       spin_lock(&fc->lock);
> > > +       fb = idr_remove(&fc->backing_files_map, id);
> > > +       spin_unlock(&fc->lock);
> > > +
> > > +       return fb;
> > > +}
> > > +
> > > +static int fuse_backing_id_free(int id, void *p, void *data)
> > > +{
> > > +       struct fuse_backing *fb = p;
> > > +
> > > +       WARN_ON_ONCE(refcount_read(&fb->count) != 1);
> > > +       fuse_backing_free(fb);
> > > +       return 0;
> > > +}
> > > +
> > > +void fuse_backing_files_free(struct fuse_conn *fc)
> > > +{
> > > +       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
> > > +       idr_destroy(&fc->backing_files_map);
> > > +}
> > > +
> > > +int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
> > > +{
> > > +       struct file *file;
> > > +       struct super_block *backing_sb;
> > > +       struct fuse_backing *fb = NULL;
> > > +       int res;
> > > +
> > > +       pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
> > > +
> > > +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> > > +       res = -EPERM;
> > > +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > > +               goto out;
> > > +
> > > +       res = -EINVAL;
> > > +       if (map->flags || map->padding)
> > > +               goto out;
> > > +
> > > +       file = fget_raw(map->fd);
> > > +       res = -EBADF;
> > > +       if (!file)
> > > +               goto out;
> > > +
> > > +       backing_sb = file_inode(file)->i_sb;
> > > +       res = -ELOOP;
> > > +       if (backing_sb->s_stack_depth >= fc->max_stack_depth)
> > > +               goto out_fput;
> > > +
> > > +       fb = kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
> > > +       res = -ENOMEM;
> > > +       if (!fb)
> > > +               goto out_fput;
> > > +
> > > +       fb->file = file;
> > > +       fb->cred = prepare_creds();
> > > +       refcount_set(&fb->count, 1);
> > > +
> > > +       res = fuse_backing_id_alloc(fc, fb);
> > > +       if (res < 0) {
> > > +               fuse_backing_free(fb);
> > > +               fb = NULL;
> > > +       }
> > > +
> > > +out:
> > > +       pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
> > > +
> > > +       return res;
> > > +
> > > +out_fput:
> > > +       fput(file);
> > > +       goto out;
> > > +}
> > > +
> > > +int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> > > +{
> > > +       struct fuse_backing *fb = NULL;
> > > +       int err;
> > > +
> > > +       pr_debug("%s: backing_id=%d\n", __func__, backing_id);
> > > +
> > > +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> > > +       err = -EPERM;
> > > +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > > +               goto out;
> > > +
> > > +       err = -EINVAL;
> > > +       if (backing_id <= 0)
> > > +               goto out;
> > > +
> > > +       err = -ENOENT;
> > > +       fb = fuse_backing_id_remove(fc, backing_id);
> > > +       if (!fb)
> > > +               goto out;
> > > +
> > > +       fuse_backing_put(fb);
> > > +       err = 0;
> > > +out:
> > > +       pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
> > > +{
> > > +       struct fuse_backing *fb;
> > > +
> > > +       rcu_read_lock();
> > > +       fb = idr_find(&fc->backing_files_map, backing_id);
> > > +       fb = fuse_backing_get(fb);
> > > +       rcu_read_unlock();
> > > +
> > > +       return fb;
> > > +}
> > > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > > index 607ef735ad4ab3..e0b8d885bc81f3 100644
> > > --- a/fs/fuse/passthrough.c
> > > +++ b/fs/fuse/passthrough.c
> > > @@ -144,158 +144,6 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
> > >         return backing_file_mmap(backing_file, vma, &ctx);
> > >  }
> > >
> > > -struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
> > > -{
> > > -       if (fb && refcount_inc_not_zero(&fb->count))
> > > -               return fb;
> > > -       return NULL;
> > > -}
> > > -
> > > -static void fuse_backing_free(struct fuse_backing *fb)
> > > -{
> > > -       pr_debug("%s: fb=0x%p\n", __func__, fb);
> > > -
> > > -       if (fb->file)
> > > -               fput(fb->file);
> > > -       put_cred(fb->cred);
> > > -       kfree_rcu(fb, rcu);
> > > -}
> > > -
> > > -void fuse_backing_put(struct fuse_backing *fb)
> > > -{
> > > -       if (fb && refcount_dec_and_test(&fb->count))
> > > -               fuse_backing_free(fb);
> > > -}
> > > -
> > > -void fuse_backing_files_init(struct fuse_conn *fc)
> > > -{
> > > -       idr_init(&fc->backing_files_map);
> > > -}
> > > -
> > > -static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
> > > -{
> > > -       int id;
> > > -
> > > -       idr_preload(GFP_KERNEL);
> > > -       spin_lock(&fc->lock);
> > > -       /* FIXME: xarray might be space inefficient */
> > > -       id = idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMIC);
> > > -       spin_unlock(&fc->lock);
> > > -       idr_preload_end();
> > > -
> > > -       WARN_ON_ONCE(id == 0);
> > > -       return id;
> > > -}
> > > -
> > > -static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
> > > -                                                  int id)
> > > -{
> > > -       struct fuse_backing *fb;
> > > -
> > > -       spin_lock(&fc->lock);
> > > -       fb = idr_remove(&fc->backing_files_map, id);
> > > -       spin_unlock(&fc->lock);
> > > -
> > > -       return fb;
> > > -}
> > > -
> > > -static int fuse_backing_id_free(int id, void *p, void *data)
> > > -{
> > > -       struct fuse_backing *fb = p;
> > > -
> > > -       WARN_ON_ONCE(refcount_read(&fb->count) != 1);
> > > -       fuse_backing_free(fb);
> > > -       return 0;
> > > -}
> > > -
> > > -void fuse_backing_files_free(struct fuse_conn *fc)
> > > -{
> > > -       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
> > > -       idr_destroy(&fc->backing_files_map);
> > > -}
> > > -
> > > -int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
> > > -{
> > > -       struct file *file;
> > > -       struct super_block *backing_sb;
> > > -       struct fuse_backing *fb = NULL;
> > > -       int res;
> > > -
> > > -       pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
> > > -
> > > -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> > > -       res = -EPERM;
> > > -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > > -               goto out;
> > > -
> > > -       res = -EINVAL;
> > > -       if (map->flags || map->padding)
> > > -               goto out;
> > > -
> > > -       file = fget_raw(map->fd);
> > > -       res = -EBADF;
> > > -       if (!file)
> > > -               goto out;
> > > -
> > > -       backing_sb = file_inode(file)->i_sb;
> > > -       res = -ELOOP;
> > > -       if (backing_sb->s_stack_depth >= fc->max_stack_depth)
> > > -               goto out_fput;
> > > -
> > > -       fb = kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
> > > -       res = -ENOMEM;
> > > -       if (!fb)
> > > -               goto out_fput;
> > > -
> > > -       fb->file = file;
> > > -       fb->cred = prepare_creds();
> > > -       refcount_set(&fb->count, 1);
> > > -
> > > -       res = fuse_backing_id_alloc(fc, fb);
> > > -       if (res < 0) {
> > > -               fuse_backing_free(fb);
> > > -               fb = NULL;
> > > -       }
> > > -
> > > -out:
> > > -       pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
> > > -
> > > -       return res;
> > > -
> > > -out_fput:
> > > -       fput(file);
> > > -       goto out;
> > > -}
> > > -
> > > -int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> > > -{
> > > -       struct fuse_backing *fb = NULL;
> > > -       int err;
> > > -
> > > -       pr_debug("%s: backing_id=%d\n", __func__, backing_id);
> > > -
> > > -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> > > -       err = -EPERM;
> > > -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > > -               goto out;
> > > -
> > > -       err = -EINVAL;
> > > -       if (backing_id <= 0)
> > > -               goto out;
> > > -
> > > -       err = -ENOENT;
> > > -       fb = fuse_backing_id_remove(fc, backing_id);
> > > -       if (!fb)
> > > -               goto out;
> > > -
> > > -       fuse_backing_put(fb);
> > > -       err = 0;
> > > -out:
> > > -       pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
> > > -
> > > -       return err;
> > > -}
> > > -
> > >  /*
> > >   * Setup passthrough to a backing file.
> > >   *
> > > @@ -315,12 +163,8 @@ struct fuse_backing *fuse_passthrough_open(struct file *file,
> > >         if (backing_id <= 0)
> > >                 goto out;
> > >
> > > -       rcu_read_lock();
> > > -       fb = idr_find(&fc->backing_files_map, backing_id);
> > > -       fb = fuse_backing_get(fb);
> > > -       rcu_read_unlock();
> > > -
> > >         err = -ENOENT;
> > > +       fb = fuse_backing_lookup(fc, backing_id);
> > >         if (!fb)
> > >                 goto out;
> > >
> > >
> > >
> 

