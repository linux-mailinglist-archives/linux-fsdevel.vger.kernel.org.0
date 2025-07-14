Return-Path: <linux-fsdevel+bounces-54783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ECDB03394
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 02:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A695B18973AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 00:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946F4A00;
	Mon, 14 Jul 2025 00:13:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03D184;
	Mon, 14 Jul 2025 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752451993; cv=none; b=KOQ+FkWX1T8ZL4Lrk2AhekKberb1ipD3JfouIMvh8ct6eF47gO2HvOTe4+LaMz+UxV6dmSU4hWn5/1762BWjgqTSL12rjlpLfmx2XN2OyTZ9aVCfniM/6hrA1JInMlsVfp4ea5SaZQpn+x0va2vcHH6WVpHSy9pX/esSHgFEEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752451993; c=relaxed/simple;
	bh=Db22mPyOVmKR9QJi0nscou0LcVY/F9dJeYuSaxvuNQY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ckrnUjegwJcP4u7cOkv86sQhmuKKY9HIp3vj8miecWStuLTIMXb6YsdRkS0zz1d4aKmCGC0ckwHJNMs1tw8f6VC0NeGfhZDMiqmFN3nskWgL/VuuU2+WYZvBgfw9GbYBdPEx5+4tQ7alvBnKKWG9exivw9Qv2T5QYVa/nRXtjv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ub6oc-001vhJ-VK;
	Mon, 14 Jul 2025 00:13:08 +0000
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
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH 01/20] ovl: simplify an error path in ovl_copy_up_workdir()
In-reply-to:
 <CAOQ4uxh6fb6GQcC0_mj=Ft5NbLco7Nb0brhn9d3f7LzMLkRYaw@mail.gmail.com>
References:
 <>, <CAOQ4uxh6fb6GQcC0_mj=Ft5NbLco7Nb0brhn9d3f7LzMLkRYaw@mail.gmail.com>
Date: Mon, 14 Jul 2025 10:13:08 +1000
Message-id: <175245198838.2234665.15268828706322164079@noble.neil.brown.name>

On Fri, 11 Jul 2025, Amir Goldstein wrote:
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > If ovl_copy_up_data() fails the error is not immediately handled but the
> > code continues on to call ovl_start_write() and lock_rename(),
> > presumably because both of these locks are needed for the cleanup.
> > On then (if the lock was successful) is the error checked.
> >
> > This makes the code a little hard to follow and could be fragile.
> >
> > This patch changes to handle the error immediately.  A new
> > ovl_cleanup_unlocked() is created which takes the required directory
> > lock (though it doesn't take the write lock on the filesystem).  This
> > will be used extensively in later patches.
> >
> > In general we need to check the parent is still correct after taking the
> > lock (as ovl_copy_up_workdir() does after a successful lock_rename()) so
> > that is included in ovl_cleanup_unlocked() using new lock_parent() and
> > unlock_parent() calls (it is planned to move this API into VFS code
> > eventually, though in a slightly different form).
>=20
> Since you are not planning to move it to VFS with this name
> AND since I assume you want to merge this ovl cleanup prior
> to the rest of of patches, please use an ovl helper without
> the ovl_ namespace prefix and you have a typo above
> its parent_lock() not lock_parent().

I think you mean "with" rather than "without" ?
But you separately say you would much rather this go into the VFS code
first.=20

For me a core issue is how the patches will land.  If you are happy for
these patches (once they are all approved of course) to land via the vfs
tree, then I can certainly submit the new interfaces in VFS code first,
then the ovl cleanups that use them.

However I assumed that they were so substantial that you would want them
to land via an ovl tree.  In that case I wouldn't want to have to wait
for a couple of new interfaces to land in VFS before you could take the
cleanups.

What process do you imagine?

>=20
> And apropos lock helper names, at the tip of your branch
> the lock helpers used in ovl_cleanup() are named:
> lock_and_check_dentry()/dentry_unlock()
>=20
> I have multiple comments on your choice of names for those helpers:
> 1. Please use a consistent name pattern for lock/unlock.
>     The pattern <obj-or-lock-type>_{lock,unlock}_* is far more common
>     then the pattern lock_<obj-or-lock-type> in the kernel, but at least
>     be consistent with dentry_lock_and_check() or better yet
>     parent_lock() and later parent_lock_get_child()

dentry_lock_and_check() does make sense - thanks.

> 2. dentry_unlock() is a very strange name for a helper that
>     unlocks the parent. The fact that you document what it does
>     in Kernel-doc does not stop people reading the code using it
>     from being confused and writing bugs.

The plan is that dentry_lookup_and_lock() will only lock the parent during a
short interim period.  Maybe there will be one full release where that
is the case.  As soon a practical (and we know this sort of large change
cannot move quickly) dentry_lookup_and_lock() etc will only lock the
dentry, not the directory.  The directory will only get locked
immediately before call the inode_operations - for filesystems that
haven't opted out.  Thus patches in my git tree don't full reflect this
yet (Though the hints are there are the end) but that is my current
plan, based on most recent feedback from Al Viro.

> 3. Why not call it parent_unlock() like I suggested and like you
>     used in this patch set and why not introduce it in VFS to begin with?
>     For that matter parent_unlock_{put,return}_child() is more clear IMO.

Because, as I say about, it is only incidentally about the parent. It is
primarily about the dentry.

> 4. The name dentry_unlock_rename(&rd) also does not balance nicely with
>     the name lookup_and_lock_rename(&rd) and has nothing to do with the
>     dentry_ prefix. How about lookup_done_and_unlock_rename(&rd)?

The is probably my least favourite name....  I did try some "done"
variants (following one from done_path_create()).  But if felt it should
be "done_$function-that-started-this-interaction()" and that resulted in
   done_dentry_lookup_and_lock()
or similar, and having "lock" in an unlock function was weird.
Your "done_and_unlock" addresses this but results and long name that
feels clumsy to me.

I chose the dentry_ prefix before I decided to pass the renamedata
around (and I'm really happy about that latter choice).  So
reconsidering the name is definitely appropriate.
Maybe  renamedata_lock() and renamedata_unlock() ???
renamedata_lock() can do lookups as well as locking, but maybe that is
implied by the presense of old_last and new_last in renamedata...

>=20
> Hope this is not too much complaining for review of a small cleanup patch :=
-p

It's review as requested, not complaining.  Thanks for it.

>=20
> >
> > A fresh cleanup block is added which doesn't share code with other
> > cleanup blocks.  It will get a new users in the next patch.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/copy_up.c   | 12 ++++++++++--
> >  fs/overlayfs/dir.c       | 15 +++++++++++++++
> >  fs/overlayfs/overlayfs.h |  6 ++++++
> >  fs/overlayfs/util.c      | 10 ++++++++++
> >  4 files changed, 41 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 8a3c0d18ec2e..5d21b8d94a0a 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -794,6 +794,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
> >          */
> >         path.dentry =3D temp;
> >         err =3D ovl_copy_up_data(c, &path);
> > +       if (err)
> > +               goto cleanup_need_write;
> > +
> >         /*
> >          * We cannot hold lock_rename() throughout this helper, because of
> >          * lock ordering with sb_writers, which shouldn't be held when ca=
lling
> > @@ -809,8 +812,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
> >                 if (IS_ERR(trap))
> >                         goto out;
> >                 goto unlock;
> > -       } else if (err) {
> > -               goto cleanup;
> >         }
> >
> >         err =3D ovl_copy_up_metadata(c, temp);
> > @@ -857,6 +858,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
> >         ovl_cleanup(ofs, wdir, temp);
> >         dput(temp);
> >         goto unlock;
> > +
> > +cleanup_need_write:
> > +       ovl_start_write(c->dentry);
> > +       ovl_cleanup_unlocked(ofs, c->workdir, temp);
> > +       ovl_end_write(c->dentry);
> > +       dput(temp);
> > +       return err;
> >  }
> >
>=20
> Sorry, I will not accept more messy goto routines.
> I rewrote your simplification based on the tip of your branch.
> Much simpler and no need for this extra routine.
> Just always use ovl_cleanup_unlocked() in this function and
> ovl_start_write() before goto cleanup_unlocked:

Yes, that's much nicer.  Thanks.

I could of minor changes I've noted below just for completeness.

Thanks,
NeilBrown


>=20
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -794,13 +794,16 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>          */
>         path.dentry =3D temp;
>         err =3D ovl_copy_up_data(c, &path);
> +       ovl_start_write(c->dentry);
> +       if (err)
> +               goto cleanup_unlocked;
> +
>         /*
>          * We cannot hold lock_rename() throughout this helper, because of
>          * lock ordering with sb_writers, which shouldn't be held when call=
ing
>          * ovl_copy_up_data(), so lock workdir and destdir and make sure th=
at
>          * temp wasn't moved before copy up completion or cleanup.
>          */
> -       ovl_start_write(c->dentry);
>         trap =3D lock_rename(c->workdir, c->destdir);
>         if (trap || temp->d_parent !=3D c->workdir) {
>                 /* temp or workdir moved underneath us? abort without clean=
up */
> @@ -809,8 +812,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *=
c)
>                 if (IS_ERR(trap))
>                         goto out;
>                 goto unlock;
> -       } else if (err) {
> -               goto cleanup;
>         }
>=20
>         err =3D ovl_copy_up_metadata(c, temp);
> @@ -846,17 +847,17 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>         ovl_inode_update(inode, temp);
>         if (S_ISDIR(inode->i_mode))
>                 ovl_set_flag(OVL_WHITEOUTS, inode);
> -unlock:
> -       unlock_rename(c->workdir, c->destdir);

We need to leave this unlock_rename() here.

>  out:
>         ovl_end_write(c->dentry);
>=20
>         return err;
>=20
>  cleanup:
> -       ovl_cleanup(ofs, wdir, temp);
> +       unlock_rename(c->workdir, c->destdir);
> +cleanup_unlocked:
> +       ovl_cleanup_unlocked(ofs, wdir, temp);

"wdir" becomes "c->workdir".=20

>         dput(temp);
> -       goto unlock;
> +       goto out;
>  }
> ---
>=20
> >  /* Copyup using O_TMPFILE which does not require cross dir locking */
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 4fc221ea6480..cee35d69e0e6 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -43,6 +43,21 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir=
, struct dentry *wdentry)
> >         return err;
> >  }
> >
> > +int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
> > +                        struct dentry *wdentry)
> > +{
> > +       int err;
> > +
> > +       err =3D parent_lock(workdir, wdentry);
> > +       if (err)
> > +               return err;
> > +
> > +       ovl_cleanup(ofs, workdir->d_inode, wdentry);
> > +       parent_unlock(workdir);
> > +
> > +       return err;
> > +}
> > +
> >  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
> >  {
> >         struct dentry *temp;
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 42228d10f6b9..68dc78c712a8 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -416,6 +416,11 @@ static inline bool ovl_open_flags_need_copy_up(int f=
lags)
> >  }
> >
> >  /* util.c */
> > +int parent_lock(struct dentry *parent, struct dentry *child);
> > +static inline void parent_unlock(struct dentry *parent)
> > +{
> > +       inode_unlock(parent->d_inode);
> > +}
>=20
> ovl_parent_unlock() or move to vfs please.
>=20
> >  int ovl_get_write_access(struct dentry *dentry);
> >  void ovl_put_write_access(struct dentry *dentry);
> >  void ovl_start_write(struct dentry *dentry);
> > @@ -843,6 +848,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
> >                                struct inode *dir, struct dentry *newdentr=
y,
> >                                struct ovl_cattr *attr);
> >  int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *de=
ntry);
> > +int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, str=
uct dentry *dentry);
> >  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r);
> >  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
> >                                struct ovl_cattr *attr);
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 2b4754c645ee..a5105d68f6b4 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -1544,3 +1544,13 @@ void ovl_copyattr(struct inode *inode)
> >         i_size_write(inode, i_size_read(realinode));
> >         spin_unlock(&inode->i_lock);
> >  }
> > +
> > +int parent_lock(struct dentry *parent, struct dentry *child)
> > +{
> > +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> > +       if (!child || child->d_parent =3D=3D parent)
> > +               return 0;
> > +
> > +       inode_unlock(parent->d_inode);
> > +       return -EINVAL;
> > +}
>=20
> ovl_parent_lock() or move to vfs please.
>=20
> Thanks,
> Amir.
>=20


