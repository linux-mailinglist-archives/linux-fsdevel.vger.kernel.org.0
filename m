Return-Path: <linux-fsdevel+bounces-52934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF3AE8912
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D31188C4D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC659264A8E;
	Wed, 25 Jun 2025 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRPq9UUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3B1A7264;
	Wed, 25 Jun 2025 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867396; cv=none; b=fwWqJfHh4tywOjvTrUDNsXCnV037u3XsZWAFE8uqfMCP21fy1FsSg5c+Hb1V04rb2K1qmsPtzRClLyiLtm0Vh8io9b0tKDyuZ6biAi0VFoAK/I6MS0fvHj6e1EPoJH8vafb/UxPr0UQqESxepXPZ0WfUTgRuZz5YZ25zH03yfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867396; c=relaxed/simple;
	bh=zK99S5UabvsJEec6HtjAXnkXr/EuKTtc9pgk8zMHlzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLM6Bp3JwKT8V1e3j8z6pSf2T356fI3HdHv8++/c1PzhFAn6uAj1qJwFBrEC85IpDB/xniMUmRc3v0QRbsbMDRDVPlvQ6DHXtrnGu4dJWGjVXjXYWTHKNuPGt8wd1pkJyViRcPoUuLJbJfRnebJ58qG7MxbXtRh+M4j8SgVrseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRPq9UUC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so7170266b.2;
        Wed, 25 Jun 2025 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867393; x=1751472193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lk61li/sZpsssak1WimMF7Ptc4fFLg+kXjcIFqtam0Q=;
        b=cRPq9UUCuBtyWR//xlHhUNqgwbsO6fwQxs/IHWEt5hXfDoxCOY4twDnEUevx6B/eUC
         Uxj2QKcvGUlE3aVX6wNJPsQgdXYSy89TS2qpPxS9g2pqLsFLh3mIg5ep5rr8HgfrjDTH
         0mzCYzQOKm7PuC0uvc2sIy+qSs4AJZ7YZCU6Q90P0dFlxanAXLubnn42+4jfCF2Mv2IU
         gxoGdxK+LhC3jRJV2mfx5ebN74+ThR2x09DR30dPjmNyMO/Qpr84FNs3r/qIOEGiU4ou
         a8EXbMod1cy2jPEhCZ8WtBuMHd0kr142Saj4nY8cdaYG7Ym02WoRCV/SlD0xWzbL6Oem
         ScXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867393; x=1751472193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lk61li/sZpsssak1WimMF7Ptc4fFLg+kXjcIFqtam0Q=;
        b=U9+wKdQm4JPQCQ31U9q9Ys7AdntrlKd1yzS/gibHNItCkXZOiUowPl4ltW/mpkW2CV
         hwFhYzE41R7oQWeXsW2o/COOsGW7/1I6fmZcu6oVROljGfHvmg8sx5x42NylZr8Xg4RN
         rgzaALjD9ushPcOOl4CHGj6Bf5FTUr4sC/wIChGLqawPECM3fZ7PZEGU6CnBZXhM/p8p
         7SVDGw5i3/c8Jo0nWcU+8sERSQTNK0KdAP2OZP/Vc2l6kT1ebWytiiYBUxKSjziGRV31
         BS2bVS7xDXbjcoVEHrDkGUVN+OmXxOY6QqxerS0llK1Xw5xXCAbrRup9ABChAfvRKe8t
         aPYw==
X-Forwarded-Encrypted: i=1; AJvYcCUv5pEUEzmH9txOOl9KMCnRYds8yyD/Ma9pzbx7luNHNvQK7BtgtylvzW7/AIAqaXWY4hqIKLvypwRj075dPQ==@vger.kernel.org, AJvYcCVE/VRXA5m/8TvshG+0WvfIb7nOiJSmEm9+TQxxRaEixw78N1HRvXg7PQvygZkNkaz66BjWtOCSd55OueVq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9S/5nsNayzVh1FNtK7ox8OAJ++OXWZuDzYXXTj0Iul8GLL8SW
	26yDg5mAidDZxyR2Y9R2FlTyYrXsLYp6y0tQ1bogmlBFwqMe1rP2v7zWFYeHG/TtGtJOqaPP5hu
	EbdNm6Cc5iqUsTnXIBK6iFcRkTGQdAn7FuykM6/c=
X-Gm-Gg: ASbGncvZy9il4tqeKnC8KhbsujPaGyVSO95A2gbEHJrSYFDXdOFUP5pd+q4Dlax5/9T
	8xSOh7yaPWS7mvfWhMk57Kp21AysqCTJuDMkBmKOPQFcOw40hFcO1/oEIJkaeSVDsQKHuaOMj4q
	ByTX6gBEULS6cALKQTLBubq10x8XfSPJrWis+nV95Bct7ZelCxWbkWqA==
X-Google-Smtp-Source: AGHT+IFCBSMDaO4N2j6/3P/mdwG4qvmlSLKkW6INbt42brgG7kzgWqF2V16+QL+679S5TzczWmQ2k7LHRrEgdqwbRJc=
X-Received: by 2002:a17:906:8f03:b0:ad5:430b:9013 with SMTP id
 a640c23a62f3a-ae0beabad4cmr328260166b.42.1750867390334; Wed, 25 Jun 2025
 09:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-3-neil@brown.name>
 <CAOQ4uxjzZGK6fw9=dFiC8kZCUtA7NVQVE_Sa2wdHLZ9ZD7upgA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjzZGK6fw9=dFiC8kZCUtA7NVQVE_Sa2wdHLZ9ZD7upgA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 18:02:57 +0200
X-Gm-Features: Ac12FXyfKUr2H_RQFLNZrY4-2bcpQvEy381NoOK3oRDIT5SXYmwACl4KVXR2LII
Message-ID: <CAOQ4uxhCSbsPvnG1h0Bi=80KROtbCBBaB9SgZtpxMDjAVmPoKw@mail.gmail.com>
Subject: Re: [PATCH 02/12] ovl: Call ovl_create_temp() and ovl_create_index()
 without lock held.
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 5:44=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote=
:
> >
> > ovl currently locks a directory or two and then performs multiple actio=
ns
> > in one or both directories.  This is incompatible with proposed changes
> > which will lock just the dentry of objects being acted on.
> >
> > This patch moves calls to ovl_create_temp() and ovl_create_index() out
> > of the locked region and has them take and release the relevant lock
> > themselves.
> >
> > The lock that was taken before these functions are called is now taken
> > after.  This means that any code between where the lock was taken and
> > these calls is now unlocked.  This necessitates the creation of
> > _unlocked() versions of ovl_cleanup() and ovl_lookup_upper().  These
> > will be used more widely in future patches.
> >
> > ovl_cleanup_unlocked() takes a dentry for the directory rather than an
> > inode as this simplifies calling slightly.
> >
> > Note that when we move a lookup or create out of a locked region in
> > which the dentry is acted on, we need to ensure after taking the lock
> > that the dentry is still in the directory we expect it to be in.  It is
> > conceivable that it was moved.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/copy_up.c   | 37 +++++++++++-------
> >  fs/overlayfs/dir.c       | 84 +++++++++++++++++++++++++---------------
> >  fs/overlayfs/overlayfs.h | 10 +++++
> >  fs/overlayfs/super.c     |  7 ++--
> >  4 files changed, 88 insertions(+), 50 deletions(-)
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 8a3c0d18ec2e..7a21ad1f2b6e 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -517,15 +517,12 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, s=
truct dentry *upper,
> >
> >  /*
> >   * Create and install index entry.
> > - *
> > - * Caller must hold i_mutex on indexdir.
> >   */
> >  static int ovl_create_index(struct dentry *dentry, const struct ovl_fh=
 *fh,
> >                             struct dentry *upper)
> >  {
> >         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> >         struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> > -       struct inode *dir =3D d_inode(indexdir);
> >         struct dentry *index =3D NULL;
> >         struct dentry *temp =3D NULL;
> >         struct qstr name =3D { };
> > @@ -558,17 +555,21 @@ static int ovl_create_index(struct dentry *dentry=
, const struct ovl_fh *fh,
> >         err =3D ovl_set_upper_fh(ofs, upper, temp);
> >         if (err)
> >                 goto out;
> > -
> > +       lock_rename(indexdir, indexdir);
>
> This is a really strange hack.
> I assume your next patch set is going to remove this call, but I do not w=
ish
> to merge this hack as is for an unknown period of time.
>
> Please introduce helpers {un,}lock_parent()
>
> >         index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
> >         if (IS_ERR(index)) {
> >                 err =3D PTR_ERR(index);
> > +       } else if (temp->d_parent !=3D indexdir) {
> > +               err =3D -EINVAL;
> > +               dput(index);
>
> This can be inside lock_parent(parent, child)
> where child is an optional arg.
>
> err =3D lock_parent(indexdir, temp);
> if (err)
>        goto out;
>
> Because we should be checking this right after lock and
> not after ovl_lookup_upper().
>
> >         } else {
> >                 err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, in=
dex, 0);
> >                 dput(index);
> >         }
> > +       unlock_rename(indexdir, indexdir);
> >  out:
> >         if (err)
> > -               ovl_cleanup(ofs, dir, temp);
> > +               ovl_cleanup_unlocked(ofs, indexdir, temp);
> >         dput(temp);
> >  free_name:
> >         kfree(name.name);
> > @@ -779,9 +780,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
> >                 return err;
> >
> >         ovl_start_write(c->dentry);
> > -       inode_lock(wdir);
> >         temp =3D ovl_create_temp(ofs, c->workdir, &cattr);
> > -       inode_unlock(wdir);
> >         ovl_end_write(c->dentry);
> >         ovl_revert_cu_creds(&cc);
> >
> > @@ -794,6 +793,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
> >          */
> >         path.dentry =3D temp;
> >         err =3D ovl_copy_up_data(c, &path);
> > +       if (err)
> > +               goto cleanup_write_unlocked;
> >         /*
> >          * We cannot hold lock_rename() throughout this helper, because=
 of
> >          * lock ordering with sb_writers, which shouldn't be held when =
calling
> > @@ -801,6 +802,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_=
ctx *c)
> >          * temp wasn't moved before copy up completion or cleanup.
> >          */
> >         ovl_start_write(c->dentry);
> > +
> > +       if (S_ISDIR(c->stat.mode) && c->indexed) {
> > +               err =3D ovl_create_index(c->dentry, c->origin_fh, temp)=
;
> > +               if (err)
> > +                       goto cleanup_unlocked;
> > +       }
> > +
> >         trap =3D lock_rename(c->workdir, c->destdir);
> >         if (trap || temp->d_parent !=3D c->workdir) {
> >                 /* temp or workdir moved underneath us? abort without c=
leanup */
> > @@ -809,20 +817,12 @@ static int ovl_copy_up_workdir(struct ovl_copy_up=
_ctx *c)
> >                 if (IS_ERR(trap))
> >                         goto out;
> >                 goto unlock;
> > -       } else if (err) {
> > -               goto cleanup;
> >         }
> >
> >         err =3D ovl_copy_up_metadata(c, temp);
> >         if (err)
> >                 goto cleanup;
> >
> > -       if (S_ISDIR(c->stat.mode) && c->indexed) {
> > -               err =3D ovl_create_index(c->dentry, c->origin_fh, temp)=
;
> > -               if (err)
> > -                       goto cleanup;
> > -       }
> > -
> >         upper =3D ovl_lookup_upper(ofs, c->destname.name, c->destdir,
> >                                  c->destname.len);
> >         err =3D PTR_ERR(upper);
> > @@ -857,6 +857,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_=
ctx *c)
> >         ovl_cleanup(ofs, wdir, temp);
> >         dput(temp);
> >         goto unlock;
> > +
> > +cleanup_write_unlocked:
> > +       ovl_start_write(c->dentry);
> > +cleanup_unlocked:
> > +       ovl_cleanup_unlocked(ofs, c->workdir, temp);
> > +       dput(temp);
> > +       goto out;
> >  }
>
> Wow these various cleanup flows are quite hard to follow.
> This is a massive patch set which is very hard for me to review
> and it will also be hard for me to maintain the code as it is.
> We need to figure out a way to simplify the code flow
> either more re-factoring or using some scoped cleanup hooks.
> I am open to suggestions.
>
> Thanks,
> Amir.
>
> >
> >  /* Copyup using O_TMPFILE which does not require cross dir locking */
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 4fc221ea6480..a51a3dc02bf5 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -43,6 +43,21 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wd=
ir, struct dentry *wdentry)
> >         return err;
> >  }
> >
> > +int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
> > +                        struct dentry *wdentry)
> > +{
> > +       int err;
> > +
> > +       inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
> > +       if (wdentry->d_parent =3D=3D workdir)
> > +               ovl_cleanup(ofs, workdir->d_inode, wdentry);
> > +       else
> > +               err =3D -EINVAL;
> > +       inode_unlock(workdir->d_inode);
> > +
> > +       return err;
> > +}
> > +

Just to illustrate what I meant and how the flow of ovl_cleanup_unlocked()
and later on ovl_cleanup() would look simpler:

int lock_parent(struct dentry *parent, struct dentry *child)
{
       int err;

       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
       if (!child || child->d_parent =3D=3D parent)
              return 0;

       inode_unlock(parent->d_inode);
       return -EINVAL;
}

int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
                        struct dentry *wdentry)
{
       int err;

       err =3D parent_lock(workdir, wdentry);
       if (err)
               return err;

       ovl_cleanup(ofs, workdir->d_inode, wdentry);
       parent_unlock(workdir);
       return 0;
}

Thanks,
Amir.

