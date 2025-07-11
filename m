Return-Path: <linux-fsdevel+bounces-54614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF7AB019D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAD93A585B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9BE286409;
	Fri, 11 Jul 2025 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkqxFLJs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2722192EF;
	Fri, 11 Jul 2025 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229856; cv=none; b=VhXiyshGDaTufH/5Yivx5KbNXBb35eihY21iUZrSfaBK5PWmcMnJmmQBvOv4XWzcxjDOArTh7uSUeM4dDMM+yU92Wh8maeGiPbQsPrMlrf44ra3m+95WpQMPKJcT1vSm0c0316vBGOknfTQGUNivGu3c47IpxD+heWH2f/yrapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229856; c=relaxed/simple;
	bh=s/1CaiEG16tWw7h0p4qTTyDRMvWMRFpOuiSgG1SW8xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGUm1EoIZtNaGCmKBdZuaO6Iq6kmgnJu7IvTt+EW1GoF0SHsZNgdd7D5+lgr5gCGYglkJ44z0EFPs6hh2cKq5wgxkCze3IcVsQ9LSwIdQpdBlFjNRbrKSjrY1z2r7b1v8kdIRnNaEDAiuw6OvYYBIUFXeZLVxt17bAjHU8uJnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkqxFLJs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so195520466b.1;
        Fri, 11 Jul 2025 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752229853; x=1752834653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USgXhQb/tYJAHZBRJmdeogPvaF4/Tvv9dmU6AFLQNqw=;
        b=mkqxFLJstNleQr1ahwaxtTq9lX0EgvPUFCWw7Unw3Otc97+VwRpTRfxC4GMPYPS0Mp
         nZ/Zno0zJ2jGoc7SypEkzu+cZ3eygJvc12FM5u+FVRiQ8mFGGwyr0MAs8SgshA2SMZX8
         9QpjSIFUMs+y7CkFUZJmZSUEo5idjMdGEXEARw6Kc8FLf9AM5C5LmAoRZPT8QZJBddqV
         zjj1pbwopgKtyzXw3Xb0fO8ggu08dt0aCTg55oyl5rAR10YL2CPjuBBcqoB07gVCPlem
         uGrPBc8JE7WYJ7xKTFfcXqKWF6DbYiMMRsXKpSOJ8pk1xBqwrt8JXs3vSo3XMGy7zzil
         nG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752229853; x=1752834653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USgXhQb/tYJAHZBRJmdeogPvaF4/Tvv9dmU6AFLQNqw=;
        b=chYggPPRUpm7PFQB7PQZ+mxW0ewsagsK46EtccChhdc9vXTJwbc+/YggJu2FbkYWOo
         /cnjy1Pwwxt18tX7TasZEZRQVyQ/uvFfXRTrdLkr6iOxy77cP3bzYrsnY/Gd5XCvB/cF
         c/pJmXORJtmuXL3Sl6mK1MfvESgmnCWV5xGsg/7u+7gHN8MphVW+I0bJaUovegnGegJ0
         twFLS7hRn3ODElAkl6M8wIYiaa6oL8yrgVIf2Fa9OEHZUjflxTEGDfiQflon4cBS4/e+
         eExpp4m5F1ADwGSKRzWMppxjTb0hTXT8PMdgfkUB2LZNJsKEAFA2NLPaXyQxO0FOOgGR
         85qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5Q18yaUaOkVP8zTb391tZONKSeS8ax1CDVPf5kOBqPLmX0gH59Sqa4FEseXE6RiyaFyyITYW+QwMAJd7@vger.kernel.org, AJvYcCXZHxBAXLJAk/vTMYZ50Sre4MkUfzbN5tUXG/ZDX07WEGUSRKOb5l5QF/FIObhuNMHQL/SdZND5we8HMlYdkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi7E3JQPliojpaG6dbMTU6sBm9EeNbAS0DexXZZzRteGPNY/gU
	a+6AauWlQma7zm+jMEKJTV4HJOi+CyQWqkzEavhy1PxPGXLEr9F8bhIQInQ1QLeM5rJzTTTCO+t
	3d3ggCQw8wcf9bfcN5xFSvFVBYxIUyb4=
X-Gm-Gg: ASbGncsbtumaSpM/DoA7/hk2me9AihtziDqSZIOZo0URUXDlQY6TtWJMLl2a+eqs8t8
	o7AZLo8ipbFWHclFsrwqAvLDNMDKxmZMbAW18Btb00rKo15Py8g+m9EKB8HUvPnB0iLs6mcmDby
	J4ueO6uHx7dzh4MfbZgAOkqhYWegBzBXqJvv/Vm7Exn0abI8NUkeYxkfrbMnPSwjq4fqT8M6IgH
	1BcdRs=
X-Google-Smtp-Source: AGHT+IGA7/FL0BDusUfE4z4xxDof5BuoEOQkpe/eKV13WSrf7eMz1xf7m427ZrcV8gkiP6rfLaRsuHzIKSN/U29aW8s=
X-Received: by 2002:a17:907:c12:b0:ae3:ed39:89ba with SMTP id
 a640c23a62f3a-ae7010b7e8fmr163514766b.11.1752229852242; Fri, 11 Jul 2025
 03:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-2-neil@brown.name>
 <CAOQ4uxh6fb6GQcC0_mj=Ft5NbLco7Nb0brhn9d3f7LzMLkRYaw@mail.gmail.com>
In-Reply-To: <CAOQ4uxh6fb6GQcC0_mj=Ft5NbLco7Nb0brhn9d3f7LzMLkRYaw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 12:30:41 +0200
X-Gm-Features: Ac12FXxjcBhmdqWV6BchA9VhIkAonOeHz2eZcBAkBHfd1Dw2T-prLZCOtzpm96A
Message-ID: <CAOQ4uxi7tseWt4NsLQhFEEYqKMeskro71so8p8e0CNuqfA6ATg@mail.gmail.com>
Subject: Re: [PATCH 01/20] ovl: simplify an error path in ovl_copy_up_workdir()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 10:25=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote=
:
> >
> > If ovl_copy_up_data() fails the error is not immediately handled but th=
e
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
> > In general we need to check the parent is still correct after taking th=
e
> > lock (as ovl_copy_up_workdir() does after a successful lock_rename()) s=
o
> > that is included in ovl_cleanup_unlocked() using new lock_parent() and
> > unlock_parent() calls (it is planned to move this API into VFS code
> > eventually, though in a slightly different form).
>
> Since you are not planning to move it to VFS with this name
> AND since I assume you want to merge this ovl cleanup prior
> to the rest of of patches, please use an ovl helper without
> the ovl_ namespace prefix and you have a typo above
> its parent_lock() not lock_parent().
>
> And apropos lock helper names, at the tip of your branch
> the lock helpers used in ovl_cleanup() are named:
> lock_and_check_dentry()/dentry_unlock()
>
> I have multiple comments on your choice of names for those helpers:
> 1. Please use a consistent name pattern for lock/unlock.
>     The pattern <obj-or-lock-type>_{lock,unlock}_* is far more common
>     then the pattern lock_<obj-or-lock-type> in the kernel, but at least
>     be consistent with dentry_lock_and_check() or better yet
>     parent_lock() and later parent_lock_get_child()
> 2. dentry_unlock() is a very strange name for a helper that
>     unlocks the parent. The fact that you document what it does
>     in Kernel-doc does not stop people reading the code using it
>     from being confused and writing bugs.
> 3. Why not call it parnet_unlock() like I suggested and like you
>     used in this patch set and why not introduce it in VFS to begin with?
>     For that matter parent_unlock_{put,return}_child() is more clear IMO.
> 4. The name dentry_unlock_rename(&rd) also does not balance nicely with
>     the name lookup_and_lock_rename(&rd) and has nothing to do with the
>     dentry_ prefix. How about lookup_done_and_unlock_rename(&rd)?
>
> Hope this is not too much complaining for review of a small cleanup patch=
 :-p
>
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
> > @@ -794,6 +794,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
> >          */
> >         path.dentry =3D temp;
> >         err =3D ovl_copy_up_data(c, &path);
> > +       if (err)
> > +               goto cleanup_need_write;
> > +
> >         /*
> >          * We cannot hold lock_rename() throughout this helper, because=
 of
> >          * lock ordering with sb_writers, which shouldn't be held when =
calling
> > @@ -809,8 +812,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
> >                 if (IS_ERR(trap))
> >                         goto out;
> >                 goto unlock;
> > -       } else if (err) {
> > -               goto cleanup;
> >         }
> >
> >         err =3D ovl_copy_up_metadata(c, temp);
> > @@ -857,6 +858,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_=
ctx *c)
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
>
> Sorry, I will not accept more messy goto routines.
> I rewrote your simplification based on the tip of your branch.
> Much simpler and no need for this extra routine.
> Just always use ovl_cleanup_unlocked() in this function and
> ovl_start_write() before goto cleanup_unlocked:
>
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -794,13 +794,16 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
>          */
>         path.dentry =3D temp;
>         err =3D ovl_copy_up_data(c, &path);
> +       ovl_start_write(c->dentry);
> +       if (err)
> +               goto cleanup_unlocked;
> +
>         /*
>          * We cannot hold lock_rename() throughout this helper, because o=
f
>          * lock ordering with sb_writers, which shouldn't be held when ca=
lling
>          * ovl_copy_up_data(), so lock workdir and destdir and make sure =
that
>          * temp wasn't moved before copy up completion or cleanup.
>          */
> -       ovl_start_write(c->dentry);
>         trap =3D lock_rename(c->workdir, c->destdir);
>         if (trap || temp->d_parent !=3D c->workdir) {
>                 /* temp or workdir moved underneath us? abort without cle=
anup */
> @@ -809,8 +812,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>                 if (IS_ERR(trap))
>                         goto out;
>                 goto unlock;
> -       } else if (err) {
> -               goto cleanup;
>         }
>
>         err =3D ovl_copy_up_metadata(c, temp);
> @@ -846,17 +847,17 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
>         ovl_inode_update(inode, temp);
>         if (S_ISDIR(inode->i_mode))
>                 ovl_set_flag(OVL_WHITEOUTS, inode);
> -unlock:
> -       unlock_rename(c->workdir, c->destdir);
>  out:
>         ovl_end_write(c->dentry);
>
>         return err;
>
>  cleanup:
> -       ovl_cleanup(ofs, wdir, temp);
> +       unlock_rename(c->workdir, c->destdir);
> +cleanup_unlocked:
> +       ovl_cleanup_unlocked(ofs, wdir, temp);
>         dput(temp);
> -       goto unlock;
> +       goto out;
>  }
> ---
>
> >  /* Copyup using O_TMPFILE which does not require cross dir locking */
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 4fc221ea6480..cee35d69e0e6 100644
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
> >  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *work=
dir)
> >  {
> >         struct dentry *temp;
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 42228d10f6b9..68dc78c712a8 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -416,6 +416,11 @@ static inline bool ovl_open_flags_need_copy_up(int=
 flags)
> >  }
> >
> >  /* util.c */
> > +int parent_lock(struct dentry *parent, struct dentry *child);
> > +static inline void parent_unlock(struct dentry *parent)
> > +{
> > +       inode_unlock(parent->d_inode);
> > +}
>
> ovl_parent_unlock() or move to vfs please.
>
> >  int ovl_get_write_access(struct dentry *dentry);
> >  void ovl_put_write_access(struct dentry *dentry);
> >  void ovl_start_write(struct dentry *dentry);
> > @@ -843,6 +848,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
> >                                struct inode *dir, struct dentry *newden=
try,
> >                                struct ovl_cattr *attr);
> >  int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *=
dentry);
> > +int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, s=
truct dentry *dentry);
> >  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *work=
dir);
> >  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *work=
dir,
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
>
> ovl_parent_lock() or move to vfs please.
>

BTW, I prefer to define them in vfs if I wasn't clear (in a separate patch)
Where you can later rename them to:
parent_lock_get_child()/parent_unlock_put_child()
and fork the parallel lookup variants.

Thanks,
Amir.

