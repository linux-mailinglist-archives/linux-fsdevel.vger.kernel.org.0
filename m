Return-Path: <linux-fsdevel+bounces-53587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3943AF086E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 04:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481093B7AD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 02:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB971993B9;
	Wed,  2 Jul 2025 02:21:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2152770B;
	Wed,  2 Jul 2025 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751422899; cv=none; b=UTMa9nvwgkuo1UkmzEbEBML3iGdcNzUU9leAma0IWXN8IncgsryPaoV02bxer5Cu8s7JDhEXvTumu4m2dwxOY5xQ2HTDnUSm8O6TuNsSMQPccTapdhOh7EphBzWtgAfd+rQ3KBZ4yFYqqZ3mQGOT5vkQ/mW+ERxhchK5UJWzMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751422899; c=relaxed/simple;
	bh=9999S61Vu7jOwyN07oZbgCcmV8CkPCAgN3tegmLvrNY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DWnnrceFoq7qR7ewFM+bnYgfqkGjNIeFTYhuF/oZI7Zzqq+e3LUgvINbuaRmRaVpYEfJx6fnFpRAO7XrD55NpcYzvlfvlqDPRtz2IcC6TI+8G3FNd5q7HFoesEm6lrdoF+q6rg3e2XvMDFjl/fDfxUqouXLLX4vaPTkiMvissbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uWn6M-00GIBy-I2;
	Wed, 02 Jul 2025 02:21:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/12] ovl: whiteout locking changes
In-reply-to:
 <CAOQ4uxjr4TnZCpQoyqyN9nQ8KoJX81Rsxu__GK+30FWVT-o_UQ@mail.gmail.com>
References:
 <>, <CAOQ4uxjr4TnZCpQoyqyN9nQ8KoJX81Rsxu__GK+30FWVT-o_UQ@mail.gmail.com>
Date: Wed, 02 Jul 2025 12:21:34 +1000
Message-id: <175142289421.565058.13059969379613496521@noble.neil.brown.name>

On Thu, 26 Jun 2025, Amir Goldstein wrote:
> On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > ovl_writeout() relies on the workdir i_rwsem to provide exclusive access
> > to ofs->writeout which it manipulates.  Rather than depending on this,
>=20
> typo writeout/whiteout all over this commit message

Fixed - thanks.

>=20
> > add a new mutex, "writeout_lock" to explicitly provide the required
> > locking.
> >
> > Then take the lock on workdir only when needed - to lookup the temp name
> > and to do the whiteout or link.  So ovl_writeout() and similarly
> > ovl_cleanup_and_writeout() and ovl_workdir_cleanup() are now called
> > without the lock held.  This requires changes to
> > ovl_remove_and_whiteout(), ovl_cleanup_index(), ovl_indexdir_cleanup(),
> > and ovl_workdir_create().
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/dir.c       | 71 +++++++++++++++++++++-------------------
> >  fs/overlayfs/overlayfs.h |  2 +-
> >  fs/overlayfs/ovl_entry.h |  1 +
> >  fs/overlayfs/params.c    |  2 ++
> >  fs/overlayfs/readdir.c   | 31 ++++++++++--------
> >  fs/overlayfs/super.c     |  9 +++--
> >  fs/overlayfs/util.c      |  7 ++--
> >  7 files changed, 67 insertions(+), 56 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 5afe17cee305..78b0d956b0ac 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -77,7 +77,6 @@ struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, stru=
ct dentry *workdir)
> >         return temp;
> >  }
> >
> > -/* caller holds i_mutex on workdir */
> >  static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
> >  {
> >         int err;
> > @@ -85,47 +84,51 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
> >         struct dentry *workdir =3D ofs->workdir;
> >         struct inode *wdir =3D workdir->d_inode;
> >
> > +       mutex_lock(&ofs->whiteout_lock);
> >         if (!ofs->whiteout) {
> > +               inode_lock(wdir);
> >                 whiteout =3D ovl_lookup_temp(ofs, workdir);
> > +               if (!IS_ERR(whiteout)) {
> > +                       err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> > +                       if (err) {
> > +                               dput(whiteout);
> > +                               whiteout =3D ERR_PTR(err);
> > +                       }
> > +               }
> > +               inode_unlock(wdir);
> >                 if (IS_ERR(whiteout))
> >                         goto out;
> > -
> > -               err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> > -               if (err) {
> > -                       dput(whiteout);
> > -                       whiteout =3D ERR_PTR(err);
> > -                       goto out;
> > -               }
> >                 ofs->whiteout =3D whiteout;
> >         }
> >
> >         if (!ofs->no_shared_whiteout) {
> > +               inode_lock(wdir);
> >                 whiteout =3D ovl_lookup_temp(ofs, workdir);
> > -               if (IS_ERR(whiteout))
> > -                       goto out;
> > -
> > -               err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
> > -               if (!err)
> > +               if (!IS_ERR(whiteout)) {
> > +                       err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whi=
teout);
> > +                       if (err) {
> > +                               dput(whiteout);
> > +                               whiteout =3D ERR_PTR(err);
> > +                       }
> > +               }
> > +               inode_unlock(wdir);
> > +               if (!IS_ERR(whiteout) || PTR_ERR(whiteout) !=3D -EMLINK)
> >                         goto out;
> >
> > -               if (err !=3D -EMLINK) {
> > -                       pr_warn("Failed to link whiteout - disabling whit=
eout inode sharing(nlink=3D%u, err=3D%i)\n",
> > -                               ofs->whiteout->d_inode->i_nlink, err);
> > -                       ofs->no_shared_whiteout =3D true;
> > -               }
> > -               dput(whiteout);
>=20
> Where did this dput go?

13 lines up in the patch.  It is called when ovl_do_link() fails.  It is
now closer to the ovl_do_link() call.

>=20
> > +               pr_warn("Failed to link whiteout - disabling whiteout ino=
de sharing(nlink=3D%u, err=3D%i)\n",
> > +                       ofs->whiteout->d_inode->i_nlink, err);
> > +               ofs->no_shared_whiteout =3D true;
> >         }
> >         whiteout =3D ofs->whiteout;
> >         ofs->whiteout =3D NULL;
> >  out:
> > +       mutex_unlock(&ofs->whiteout_lock);
> >         return whiteout;
> >  }
> >
> > -/* Caller must hold i_mutex on both workdir and dir */
> >  int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
> >                              struct dentry *dentry)
> >  {
> > -       struct inode *wdir =3D ofs->workdir->d_inode;
> >         struct dentry *whiteout;
> >         int err;
> >         int flags =3D 0;
> > @@ -138,18 +141,26 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
> >         if (d_is_dir(dentry))
> >                 flags =3D RENAME_EXCHANGE;
> >
> > -       err =3D ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, f=
lags);
> > +       err =3D ovl_lock_rename_workdir(ofs->workdir, dir);
> > +       if (!err) {
> > +               if (whiteout->d_parent =3D=3D ofs->workdir)
> > +                       err =3D ovl_do_rename(ofs, ofs->workdir, whiteout=
, dir,
> > +                                           dentry, flags);
> > +               else
> > +                       err =3D -EINVAL;
> > +               unlock_rename(ofs->workdir, dir);
> > +       }
> >         if (err)
> >                 goto kill_whiteout;
> >         if (flags)
> > -               ovl_cleanup(ofs, wdir, dentry);
> > +               ovl_cleanup_unlocked(ofs, ofs->workdir, dentry);
> >
> >  out:
> >         dput(whiteout);
> >         return err;
> >
> >  kill_whiteout:
> > -       ovl_cleanup(ofs, wdir, whiteout);
> > +       ovl_cleanup_unlocked(ofs, ofs->workdir, whiteout);
> >         goto out;
> >  }
> >
> > @@ -777,15 +788,11 @@ static int ovl_remove_and_whiteout(struct dentry *d=
entry,
> >                         goto out;
> >         }
> >
> > -       err =3D ovl_lock_rename_workdir(workdir, upperdir);
> > -       if (err)
> > -               goto out_dput;
> > -
> > -       upper =3D ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
> > -                                dentry->d_name.len);
> > +       upper =3D ovl_lookup_upper_unlocked(ofs, dentry->d_name.name, upp=
erdir,
> > +                                         dentry->d_name.len);
> >         err =3D PTR_ERR(upper);
> >         if (IS_ERR(upper))
> > -               goto out_unlock;
> > +               goto out_dput;
> >
> >         err =3D -ESTALE;
> >         if ((opaquedir && upper !=3D opaquedir) ||
> > @@ -803,8 +810,6 @@ static int ovl_remove_and_whiteout(struct dentry *den=
try,
> >         d_drop(dentry);
> >  out_dput_upper:
> >         dput(upper);
> > -out_unlock:
> > -       unlock_rename(workdir, upperdir);
> >  out_dput:
> >         dput(opaquedir);
> >  out:
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 508003e26e08..25378b81251e 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -732,7 +732,7 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, struct=
 dentry *upper,
> >  void ovl_cache_free(struct list_head *list);
> >  void ovl_dir_cache_free(struct inode *inode);
> >  int ovl_check_d_type_supported(const struct path *realpath);
> > -int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
> > +int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
> >                         struct vfsmount *mnt, struct dentry *dentry, int =
level);
> >  int ovl_indexdir_cleanup(struct ovl_fs *ofs);
> >
> > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > index afb7762f873f..4c1bae935ced 100644
> > --- a/fs/overlayfs/ovl_entry.h
> > +++ b/fs/overlayfs/ovl_entry.h
> > @@ -88,6 +88,7 @@ struct ovl_fs {
> >         /* Shared whiteout cache */
> >         struct dentry *whiteout;
> >         bool no_shared_whiteout;
> > +       struct mutex whiteout_lock;
> >         /* r/o snapshot of upperdir sb's only taken on volatile mounts */
> >         errseq_t errseq;
> >  };
> > diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> > index f42488c01957..cb1a17c066cd 100644
> > --- a/fs/overlayfs/params.c
> > +++ b/fs/overlayfs/params.c
> > @@ -797,6 +797,8 @@ int ovl_init_fs_context(struct fs_context *fc)
> >         fc->s_fs_info           =3D ofs;
> >         fc->fs_private          =3D ctx;
> >         fc->ops                 =3D &ovl_context_ops;
> > +
> > +       mutex_init(&ofs->whiteout_lock);
> >         return 0;
> >
> >  out_err:
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index 2a222b8185a3..fd98444dacef 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -1141,7 +1141,8 @@ static int ovl_workdir_cleanup_recurse(struct ovl_f=
s *ofs, const struct path *pa
> >                 if (IS_ERR(dentry))
> >                         continue;
> >                 if (dentry->d_inode)
> > -                       err =3D ovl_workdir_cleanup(ofs, dir, path->mnt, =
dentry, level);
> > +                       err =3D ovl_workdir_cleanup(ofs, path->dentry, pa=
th->mnt,
> > +                                                 dentry, level);
> >                 dput(dentry);
> >                 if (err)
> >                         break;
> > @@ -1152,24 +1153,27 @@ static int ovl_workdir_cleanup_recurse(struct ovl=
_fs *ofs, const struct path *pa
> >         return err;
> >  }
> >
> > -int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
> > +int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
> >                         struct vfsmount *mnt, struct dentry *dentry, int =
level)
> >  {
> >         int err;
> >
> >         if (!d_is_dir(dentry) || level > 1) {
> > -               return ovl_cleanup(ofs, dir, dentry);
> > +               return ovl_cleanup_unlocked(ofs, parent, dentry);
> >         }
> >
> > -       err =3D ovl_do_rmdir(ofs, dir, dentry);
> > +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> > +       if (dentry->d_parent =3D=3D parent)
> > +               err =3D ovl_do_rmdir(ofs, parent->d_inode, dentry);
> > +       else
> > +               err =3D -EINVAL;
> > +       inode_unlock(parent->d_inode);
> >         if (err) {
> >                 struct path path =3D { .mnt =3D mnt, .dentry =3D dentry };
> >
> > -               inode_unlock(dir);
> >                 err =3D ovl_workdir_cleanup_recurse(ofs, &path, level + 1=
);
> > -               inode_lock_nested(dir, I_MUTEX_PARENT);
> >                 if (!err)
> > -                       err =3D ovl_cleanup(ofs, dir, dentry);
> > +                       err =3D ovl_cleanup_unlocked(ofs, parent, dentry);
> >         }
> >
> >         return err;
> > @@ -1180,7 +1184,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
> >         int err;
> >         struct dentry *indexdir =3D ofs->workdir;
> >         struct dentry *index =3D NULL;
> > -       struct inode *dir =3D indexdir->d_inode;
> >         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs), .dentry =3D i=
ndexdir };
> >         LIST_HEAD(list);
> >         struct ovl_cache_entry *p;
> > @@ -1194,7 +1197,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
> >         if (err)
> >                 goto out;
> >
> > -       inode_lock_nested(dir, I_MUTEX_PARENT);
> >         list_for_each_entry(p, &list, l_node) {
> >                 if (p->name[0] =3D=3D '.') {
> >                         if (p->len =3D=3D 1)
> > @@ -1202,7 +1204,8 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
> >                         if (p->len =3D=3D 2 && p->name[1] =3D=3D '.')
> >                                 continue;
> >                 }
> > -               index =3D ovl_lookup_upper(ofs, p->name, indexdir, p->len=
);
> > +               index =3D ovl_lookup_upper_unlocked(ofs, p->name, indexdi=
r,
> > +                                                 p->len);
> >                 if (IS_ERR(index)) {
> >                         err =3D PTR_ERR(index);
> >                         index =3D NULL;
> > @@ -1210,7 +1213,8 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
> >                 }
> >                 /* Cleanup leftover from index create/cleanup attempt */
> >                 if (index->d_name.name[0] =3D=3D '#') {
> > -                       err =3D ovl_workdir_cleanup(ofs, dir, path.mnt, i=
ndex, 1);
> > +                       err =3D ovl_workdir_cleanup(ofs, indexdir, path.m=
nt,
> > +                                                 index, 1);
> >                         if (err)
> >                                 break;
> >                         goto next;
> > @@ -1220,7 +1224,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
> >                         goto next;
> >                 } else if (err =3D=3D -ESTALE) {
> >                         /* Cleanup stale index entries */
> > -                       err =3D ovl_cleanup(ofs, dir, index);
> > +                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
> >                 } else if (err !=3D -ENOENT) {
> >                         /*
> >                          * Abort mount to avoid corrupting the index if
> > @@ -1236,7 +1240,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
> >                         err =3D ovl_cleanup_and_whiteout(ofs, indexdir, i=
ndex);
> >                 } else {
> >                         /* Cleanup orphan index entries */
> > -                       err =3D ovl_cleanup(ofs, dir, index);
> > +                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
> >                 }
> >
> >                 if (err)
> > @@ -1247,7 +1251,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
> >                 index =3D NULL;
> >         }
> >         dput(index);
> > -       inode_unlock(dir);
> >  out:
> >         ovl_cache_free(&list);
> >         if (err)
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 576b5c3b537c..3583e359655f 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -299,8 +299,8 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
> >         int err;
> >         bool retried =3D false;
> >
> > -       inode_lock_nested(dir, I_MUTEX_PARENT);
> >  retry:
> > +       inode_lock_nested(dir, I_MUTEX_PARENT);
> >         work =3D ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(nam=
e));
> >
> >         if (!IS_ERR(work)) {
> > @@ -311,6 +311,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
> >
> >                 if (work->d_inode) {
> >                         err =3D -EEXIST;
> > +                       inode_unlock(dir);
> >                         if (retried)
> >                                 goto out_dput;
> >
> > @@ -318,7 +319,8 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
> >                                 goto out_unlock;
> >
> >                         retried =3D true;
> > -                       err =3D ovl_workdir_cleanup(ofs, dir, mnt, work, =
0);
> > +                       err =3D ovl_workdir_cleanup(ofs, ofs->workbasedir=
, mnt,
> > +                                                 work, 0);
> >                         dput(work);
> >                         if (err =3D=3D -EINVAL) {
> >                                 work =3D ERR_PTR(err);
> > @@ -328,6 +330,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
> >                 }
> >
> >                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> > +               inode_unlock(dir);
> >                 err =3D PTR_ERR(work);
> >                 if (IS_ERR(work))
> >                         goto out_err;
> > @@ -365,11 +368,11 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
> >                 if (err)
> >                         goto out_dput;
> >         } else {
> > +               inode_unlock(dir);
> >                 err =3D PTR_ERR(work);
> >                 goto out_err;
> >         }
> >  out_unlock:
>=20
> This label name is now misleading

Yep - I'll fix it.

Thanks,
NeilBrown

>=20
> > -       inode_unlock(dir);
> >         return work;
> >
>=20
> Thanks,
> Amir.
>=20


