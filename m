Return-Path: <linux-fsdevel+bounces-61769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACF4B59AD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257AE1885007
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D22A34A32F;
	Tue, 16 Sep 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caFORS3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942F350D58;
	Tue, 16 Sep 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034138; cv=none; b=TB48zWwU6Ea+hYW/VTc4rliMfLo0aZRWix9x+/A5mPBJtre3adjfmLN+fvJdRRWfe66fkQRi/NHkl+9X9UHIY4NCwMrcJ7VlNlWqdCNLthfogRrnNCHuvis09CaMnWJAlSn9QF6Li93qznEw3NmnpaM+fKmY9vgF0EXgQbZlDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034138; c=relaxed/simple;
	bh=TRr/2UXPDRkUkqFcLmPRWONMEbtMrFxBh6CLCV3ubBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT5uoaJyQKdElG2cGE0rQv2KEqPcjc69niQk4JT/kHKW8rleBF8EUjLX9sqE7i8hCx6VPAdmZEzMGIS28dlNFHhy+NyZrdMdXlZ7EpZwORKWJRb2JE38+kRd/uSoAxjxzPsPVnTj4Xsimsn4Prc1dgFk4FwRx4NIHIHFq5NPaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caFORS3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17363C4CEEB;
	Tue, 16 Sep 2025 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034138;
	bh=TRr/2UXPDRkUkqFcLmPRWONMEbtMrFxBh6CLCV3ubBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caFORS3gP8vJppuURuzCF0XEIYePvaHjEWiZeXc2l0MdNx0Yr+g7wavauUYeocCjb
	 bdD/9V6+4Ny2mcTzY7DgGFKLa195k3SVKgKOXIAbq6qXMoJn+4c5q0+IW1WR853wsp
	 d8QYC87SbmuPQy4rWTXmI8r8abG89pcUATDgCsVL7pfVLZF5eVJY8nH8IwIkw+vkEC
	 mVZ//3azFzM4xBvxZvZr5iHMV06JM7VnEhcqb0IwUZ8Y4jCWjDUYGfGdsjGrZJ+Q37
	 7xybHcAi9K+EKa4OVALVcNWiSY5ci7XECx0aglZLDwMFRwt54tizx/QhyPql//a+fx
	 u9eKXCX3dabcg==
Date: Tue, 16 Sep 2025 07:48:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chen Linxuan <me@black-desk.cn>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 7/8] fuse: propagate default and file acls on creation
Message-ID: <20250916144857.GD8096@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150177.381990.5457916685867195048.stgit@frogsfrogsfrogs>
 <CAC1kPDOv4sy3NPexFtdoROFi18b98W+PbP+9t8y4Jd5fQqCxCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC1kPDOv4sy3NPexFtdoROFi18b98W+PbP+9t8y4Jd5fQqCxCg@mail.gmail.com>

On Tue, Sep 16, 2025 at 02:41:30PM +0800, Chen Linxuan wrote:
> On Tue, Sep 16, 2025 at 8:26 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > For local filesystems, propagate the default and file access ACLs to new
> > children when creating them, just like the other in-kernel local
> > filesystems.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h |    4 ++
> >  fs/fuse/acl.c    |   65 ++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/dir.c    |   92 +++++++++++++++++++++++++++++++++++++++++-------------
> >  3 files changed, 138 insertions(+), 23 deletions(-)
> >
> >
<snip>
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index a7f47e43692f1c..b116e42431ee12 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -877,10 +905,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
> >  {
> >         struct fuse_mknod_in inarg;
> >         struct fuse_mount *fm = get_fuse_mount(dir);
> > +       struct posix_acl *default_acl, *acl;
> >         FUSE_ARGS(args);
> > +       int err;
> >
> > -       if (!fm->fc->dont_mask)
> > -               mode &= ~current_umask();
> > +       err = fuse_acl_create(dir, &mode, &default_acl, &acl);
> 
> Please excuse me if this is a dumb question.
> In this function (including fuse_mkdir and fuse_symlink),
> why can't we pair fuse_acl_create and posix_acl_release together
> within the same function,
> just like in fuse_create_open?

It seemed cleaner to have create_new_{entry,nondir} consume the two acl
arguments rather than have to change every callsite:

	fuse_acl_create(...., &default_acl, &acl);

	...

	ret = create_new_nondir(..., default_acl, acl);
	posix_acl_release(default_acl);
	posix_acl_release(acl);
	return ret;

since create_new_entry is really the bottom half of mknod, mkdir,
symlink, and link.

--D

> Thanks,
> Chen Linxuan
> 
> > +       if (err)
> > +               return err;
> >
> >         memset(&inarg, 0, sizeof(inarg));
> >         inarg.mode = mode;
> > @@ -892,7 +923,8 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
> >         args.in_args[0].value = &inarg;
> >         args.in_args[1].size = entry->d_name.len + 1;
> >         args.in_args[1].value = entry->d_name.name;
> > -       return create_new_nondir(idmap, fm, &args, dir, entry, mode);
> > +       return create_new_nondir(idmap, fm, &args, dir, entry, mode,
> > +                                default_acl, acl);
> >  }
> >
> >  static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
> > @@ -924,13 +956,17 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> >  {
> >         struct fuse_mkdir_in inarg;
> >         struct fuse_mount *fm = get_fuse_mount(dir);
> > +       struct posix_acl *default_acl, *acl;
> >         FUSE_ARGS(args);
> > +       int err;
> >
> > -       if (!fm->fc->dont_mask)
> > -               mode &= ~current_umask();
> > +       mode |= S_IFDIR;        /* vfs doesn't set S_IFDIR for us */
> > +       err = fuse_acl_create(dir, &mode, &default_acl, &acl);
> > +       if (err)
> > +               return ERR_PTR(err);
> >
> >         memset(&inarg, 0, sizeof(inarg));
> > -       inarg.mode = mode;
> > +       inarg.mode = mode & ~S_IFDIR;
> >         inarg.umask = current_umask();
> >         args.opcode = FUSE_MKDIR;
> >         args.in_numargs = 2;
> > @@ -938,7 +974,8 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> >         args.in_args[0].value = &inarg;
> >         args.in_args[1].size = entry->d_name.len + 1;
> >         args.in_args[1].value = entry->d_name.name;
> > -       return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
> > +       return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR,
> > +                               default_acl, acl);
> >  }
> >
> >  static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
> > @@ -946,7 +983,14 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >  {
> >         struct fuse_mount *fm = get_fuse_mount(dir);
> >         unsigned len = strlen(link) + 1;
> > +       struct posix_acl *default_acl, *acl;
> > +       umode_t mode = S_IFLNK | 0777;
> >         FUSE_ARGS(args);
> > +       int err;
> > +
> > +       err = fuse_acl_create(dir, &mode, &default_acl, &acl);
> > +       if (err)
> > +               return err;
> >
> >         args.opcode = FUSE_SYMLINK;
> >         args.in_numargs = 3;
> > @@ -955,7 +999,8 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >         args.in_args[1].value = entry->d_name.name;
> >         args.in_args[2].size = len;
> >         args.in_args[2].value = link;
> > -       return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK);
> > +       return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK,
> > +                                default_acl, acl);
> >  }
> >
> >  void fuse_flush_time_update(struct inode *inode)
> > @@ -1155,7 +1200,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
> >         args.in_args[0].value = &inarg;
> >         args.in_args[1].size = newent->d_name.len + 1;
> >         args.in_args[1].value = newent->d_name.name;
> > -       err = create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
> > +       err = create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, newent,
> > +                               inode->i_mode, NULL, NULL);
> >         if (!err)
> >                 fuse_update_ctime_in_cache(inode);
> >         else if (err == -EINTR)
> >
> >
> >
> 

