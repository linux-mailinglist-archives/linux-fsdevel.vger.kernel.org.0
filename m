Return-Path: <linux-fsdevel+bounces-67389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE515C3DBAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 00:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67BBB4E73FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AAE34EEEA;
	Thu,  6 Nov 2025 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRUFiQbB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81F7134AB;
	Thu,  6 Nov 2025 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470136; cv=none; b=Q8SxfYrcMy2cBPPDStTY+d1ZyaySFmXq095uSWN1wHBC/m1NyVMnKwKgxQe7VUeUSNLBcVEHvhqtEhn17lrI2HalSS+RR8a7ebLQtkarxGVqtA3SQgg9rcD78XkThbSTeOmKwHP5nXQBUzFafQx4TgKvhPtPjiCi+UU43EHbcuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470136; c=relaxed/simple;
	bh=UY1imTrzC/CqV5PJiJDgiPltA+ChlnpZcKbm4ew8z24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNxOdnUiy/2UqUoDdiQ9m8xZSms6apAqJaH7CqXWCXqSdJpdCKvaheKXSQr6vVJMNuWTY9zb0D7vCVDxmyNuXpxP5c8j1tNlYa9X91RUUEt5Q+jbOcaR17gmaAe7DiCah97Kpvjd/bdZmRfPE6w8/BmDuqr3MuFrXkbKGZ6eQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRUFiQbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5751BC116C6;
	Thu,  6 Nov 2025 23:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762470135;
	bh=UY1imTrzC/CqV5PJiJDgiPltA+ChlnpZcKbm4ew8z24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRUFiQbB1Gtje35/1hE3t+Dhb2Z1l9a1YC2T80s/RCpzUDueKsKjvN/u+jd4rY5uN
	 WVaOKVN93XL/qoZszHc1pePEy81mqmV1uby2C1cav5pjpbc4KRu7h3H+sKfktJ256Y
	 SPSZMCd5OGeLeGldase/1u6VrhcpJiJHiOJneF2zSmF0DqRAIOLfoXhgzJ2Ve6BX+R
	 wz7oA/u9vfhlYKGZZJBTKYTmzSXlfH+ybLFFP+i7qO5RoBbGWUMApIMWc59NiQBmNI
	 /T3yYCNqfTOpeqYTQuUopFOjKTb1CfCotJNIjKeJzMpx3vdsmGyIwPuthjiPET4WsU
	 +P5Jdp+aW5D/g==
Date: Thu, 6 Nov 2025 15:02:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/31] fuse: isolate the other regular file IO paths from
 iomap
Message-ID: <20251106230214.GI196391@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810546.1424854.8347542331053081677.stgit@frogsfrogsfrogs>
 <CAOQ4uxh80xhhPWTQOi8pTc2b3qveYcNkNV0-hsxh3p2u27nuUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh80xhhPWTQOi8pTc2b3qveYcNkNV0-hsxh3p2u27nuUg@mail.gmail.com>

On Thu, Nov 06, 2025 at 07:44:46PM +0100, Amir Goldstein wrote:
> On Wed, Oct 29, 2025 at 1:47 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > iomap completely takes over all regular file IO, so we don't need to
> > access any of the other mechanisms at all.  Gate them off so that we can
> > eventually overlay them with a union to save space in struct fuse_inode.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> 
> I apologize for providing criticism which is not very productive.
> 
> Looking at this I don't feel much confidence to say that all cases are covered
> and worse, I don't have much confidence that future coder won't easily
> write some code that accesses the wrong side of the union.
> 
> I don't really have great ideas on how to improve.
> Maybe at least some of the gates can be inside the _nowrite accessors?
> 
> Please don't take this as any sort of objection to this patch.

I'll happily drop "fuse: overlay iomap inode info in struct fuse_inode"
because C unions are ***awful bug nests anyway.  Maybe someday when
we're porting fuse to Rust. ;)

--D

> Thanks,
> Amir.
> 
> >  fs/fuse/dir.c    |   14 +++++++++-----
> >  fs/fuse/file.c   |   18 +++++++++++++-----
> >  fs/fuse/inode.c  |    3 ++-
> >  fs/fuse/iomode.c |    2 +-
> >  4 files changed, 25 insertions(+), 12 deletions(-)
> >
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 3c222b99d6e699..18eb1bb192bb58 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1991,6 +1991,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >         FUSE_ARGS(args);
> >         struct fuse_setattr_in inarg;
> >         struct fuse_attr_out outarg;
> > +       const bool is_iomap = fuse_inode_has_iomap(inode);
> >         bool is_truncate = false;
> >         bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
> >         loff_t oldsize;
> > @@ -2048,12 +2049,15 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >                 if (err)
> >                         return err;
> >
> > -               fuse_set_nowrite(inode);
> > -               fuse_release_nowrite(inode);
> > +               if (!is_iomap) {
> > +                       fuse_set_nowrite(inode);
> > +                       fuse_release_nowrite(inode);
> > +               }
> >         }
> >
> >         if (is_truncate) {
> > -               fuse_set_nowrite(inode);
> > +               if (!is_iomap)
> > +                       fuse_set_nowrite(inode);
> >                 set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> >                 if (trust_local_cmtime && attr->ia_size != inode->i_size)
> >                         attr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
> > @@ -2125,7 +2129,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >         if (!is_wb || is_truncate)
> >                 i_size_write(inode, outarg.attr.size);
> >
> > -       if (is_truncate) {
> > +       if (is_truncate && !is_iomap) {
> >                 /* NOTE: this may release/reacquire fi->lock */
> >                 __fuse_release_nowrite(inode);
> >         }
> > @@ -2149,7 +2153,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >         return 0;
> >
> >  error:
> > -       if (is_truncate)
> > +       if (is_truncate && !is_iomap)
> >                 fuse_release_nowrite(inode);
> >
> >         clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 42c85c19f3b13b..bd9c208a46c78d 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -238,6 +238,7 @@ static int fuse_open(struct inode *inode, struct file *file)
> >         struct fuse_conn *fc = fm->fc;
> >         struct fuse_file *ff;
> >         int err;
> > +       const bool is_iomap = fuse_inode_has_iomap(inode);
> >         bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
> >         bool is_wb_truncate = is_truncate && fc->writeback_cache;
> >         bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
> > @@ -259,7 +260,7 @@ static int fuse_open(struct inode *inode, struct file *file)
> >                         goto out_inode_unlock;
> >         }
> >
> > -       if (is_wb_truncate || dax_truncate)
> > +       if ((is_wb_truncate || dax_truncate) && !is_iomap)
> >                 fuse_set_nowrite(inode);
> >
> >         err = fuse_do_open(fm, get_node_id(inode), file, false);
> > @@ -272,7 +273,7 @@ static int fuse_open(struct inode *inode, struct file *file)
> >                         fuse_truncate_update_attr(inode, file);
> >         }
> >
> > -       if (is_wb_truncate || dax_truncate)
> > +       if ((is_wb_truncate || dax_truncate) && !is_iomap)
> >                 fuse_release_nowrite(inode);
> >         if (!err) {
> >                 if (is_truncate)
> > @@ -520,12 +521,14 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
> >  {
> >         struct inode *inode = file->f_mapping->host;
> >         struct fuse_conn *fc = get_fuse_conn(inode);
> > +       const bool need_sync_writes = !fuse_inode_has_iomap(inode);
> >         int err;
> >
> >         if (fuse_is_bad(inode))
> >                 return -EIO;
> >
> > -       inode_lock(inode);
> > +       if (need_sync_writes)
> > +               inode_lock(inode);
> >
> >         /*
> >          * Start writeback against all dirty pages of the inode, then
> > @@ -536,7 +539,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
> >         if (err)
> >                 goto out;
> >
> > -       fuse_sync_writes(inode);
> > +       if (need_sync_writes)
> > +               fuse_sync_writes(inode);
> >
> >         /*
> >          * Due to implementation of fuse writeback
> > @@ -560,7 +564,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
> >                 err = 0;
> >         }
> >  out:
> > -       inode_unlock(inode);
> > +       if (need_sync_writes)
> > +               inode_unlock(inode);
> >
> >         return err;
> >  }
> > @@ -1942,6 +1947,9 @@ static struct fuse_file *__fuse_write_file_get(struct fuse_inode *fi)
> >  {
> >         struct fuse_file *ff;
> >
> > +       if (fuse_inode_has_iomap(&fi->inode))
> > +               return NULL;
> > +
> >         spin_lock(&fi->lock);
> >         ff = list_first_entry_or_null(&fi->write_files, struct fuse_file,
> >                                       write_entry);
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 9b9e7b2dd0d928..7602595006a19d 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -191,7 +191,8 @@ static void fuse_evict_inode(struct inode *inode)
> >                 if (inode->i_nlink > 0)
> >                         atomic64_inc(&fc->evict_ctr);
> >         }
> > -       if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
> > +       if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode) &&
> > +           !fuse_inode_has_iomap(inode)) {
> >                 WARN_ON(fi->iocachectr != 0);
> >                 WARN_ON(!list_empty(&fi->write_files));
> >                 WARN_ON(!list_empty(&fi->queued_writes));
> > diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> > index 3728933188f307..0a534e5a6db5f6 100644
> > --- a/fs/fuse/iomode.c
> > +++ b/fs/fuse/iomode.c
> > @@ -203,7 +203,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
> >          * io modes are not relevant with DAX and with server that does not
> >          * implement open.
> >          */
> > -       if (FUSE_IS_DAX(inode) || !ff->args)
> > +       if (fuse_inode_has_iomap(inode) || FUSE_IS_DAX(inode) || !ff->args)
> >                 return 0;
> >
> >         /*
> >
> >

