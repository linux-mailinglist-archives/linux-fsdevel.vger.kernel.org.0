Return-Path: <linux-fsdevel+bounces-62926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B68BA5C28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 11:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C0A16AECE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5623BF9B;
	Sat, 27 Sep 2025 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpLjg2AP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE141C84A1
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758964357; cv=none; b=FiXlr9+F8GAgyHYPCbstYWB1c5quGHw8gtFkVqHU3+lTlthW4noahh352B13ESaqi5C1yHoeHjVF3J8kDSicZA8eiZE3u+WjxABqCw988QfmkFTXFsq3+/mBXg3t04iRSL2o+97DBKAx4eRFcR1tgK18gDWJKEqCVo4svS6zB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758964357; c=relaxed/simple;
	bh=4mNirq6N2QwrKBLwthyPwejPSVQfSyz6gvrVjwdQE9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+Ts8ojxsUUSuqTwzUUundsIEXju1egBWVyIxYMkaKl9V7To50ElwKYI9egyOnseiebbLxxf9ML5fZZEvdBfTZYv6xZWNdwKevyDKoBLxUwBJGOj/CecFUk/AbjoZELlGjkN5xE3asQUhmVfBaPo+IgzSq/gEaQaoKbGC72FB08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpLjg2AP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so5568303a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758964354; x=1759569154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cchPsOJ/gKFBejIlQ2LvMUERwhBK52hJrE+slzn8c24=;
        b=hpLjg2AP1eL9XBx9gZb9sW+S8Vy+p6iLoOEIuhoZs8ol/FeC0xuuDpREWFSlTTqqbM
         POWGHT7KAsYi6GH9YLwBzg7R0ndDCGGCpqai6e5cfxZX2S6S2UMs7efDg60XFbO6eyGl
         D9ZEp0qx+iiq15ZE1a2PGl4vmlICu9xh9akdR63y5tAVzlswCl27zn4kOODQafcnqeYX
         fi7/sPpYmwHw2GtbHosW6tJI6EwYJyrGSOgzAo/sAckN88jjn2gePBSzZbYZp8zdEoza
         WG4yeNY8ewfc73BB2b41bqzhBXcbK1I4ZoGIfOQQZLsWxr8bvIfe1PvFfc59P4uujqhm
         d+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758964354; x=1759569154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cchPsOJ/gKFBejIlQ2LvMUERwhBK52hJrE+slzn8c24=;
        b=fscuc8k3JeMqw9bE3pKar8jUhNvOfInEDlm4ZHtUQZeUkBfJ3E/i/QNo8q3NEa2o7R
         GOHuKyxsYr0VZEG89q8W3Efw6aSa2W+5oP/4YWAPt9I8gwBUmQTEKpWxmwZPCjy6qJ2g
         NOnjV6+90b9W3TtV4S5O2SNJ0irnUsTD2y+8jsRuuLpSMuAaRQa5xv0zBkDA0SoPPNFu
         /wV0t/ZWl6MKuxQIUAqgHxiFUlQB9CIroyiAWcmKAXW7f5xLy2mChAZXHXFlSS9ryC5z
         nhBdujHKDUdLjtz1ByYW8qJclB49SPqMDp5fItuoOMFvhxu8gb75LQsdAU1fK01YZiuA
         VgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlzn/6q+HuBTVHtSVoEwUcOTDNHHlw9xROYuPfgK3kHAthGroRv9AwsoppsstRmBOB/pr37/IyhDk1BVNx@vger.kernel.org
X-Gm-Message-State: AOJu0YxoeMZPZdyRhXPF3IQ+f4LhfWTzi9JuSauvpt7io+ASSXQc+js6
	5VRG43lwrdt3oriB7hVDdTsu+K6cIPY+khrsMJ0Nmsti1oB4hs0zDJL17cTCQTcYRAP1+TCK/8i
	Wg7Y8pslL8aBnKRwblp1YM4qoPFmzh/ktiRgsOJg=
X-Gm-Gg: ASbGncuurB0Rwc/HKjk1sMnC++xlCLChiTg04pFMmKg2kyuN1OEFZVTmiWyo0/1dArz
	jrcx8HV1h2Mg/0GhQ/1LE1Grrlpe+zRIQd90ZfZ2caiZjIueLwUNIV4orUV7mN7ejIof+Oo73Kx
	uNWYG1p9HrYfDMWBs5driu86iIApk+ggAeVUocB8BCqGye4erKg+cunnrrGcRdyjGu7ZujZ2f8s
	zSoOKCDhMrdNy+L5ZS2E9QHXzS9ATUdUPRXzeEo9xVJwwpkpK6m
X-Google-Smtp-Source: AGHT+IFiINJ9PYlCYWEhn0hINgzyl392a4B81fInFdjGZ2vAx7Htt6+SqjC4RJrL1T/9/PWModTxZdtSlycug0R5Lfc=
X-Received: by 2002:a05:6402:278c:b0:636:24da:490b with SMTP id
 4fb4d7f45d1cf-63624da4ce7mr364467a12.33.1758964353513; Sat, 27 Sep 2025
 02:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-5-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-5-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 27 Sep 2025 11:12:22 +0200
X-Gm-Features: AS18NWBpr0IrVxeKQhWpcbtIj7zlfJkMZb8ddKePBxf40dN-nxP0zgGCNjLRdBA
Message-ID: <CAOQ4uxiWAAP=fuQTHnFnqKgwDcbB5wzQowv++qKdDm7++NKSFg@mail.gmail.com>
Subject: Re: [PATCH 04/11] VFS/nfsd/cachefiles/ovl: introduce start_removing()
 and end_removing()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:50=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> start_removing() is similar to start_creating() but will only return a
> positive dentry with the expectation that it will be removed.  This is
> used by nfsd, cachefiles, and overlayfs.  They are changed to also use
> end_removing() to terminate the action begun by start_removing().  This
> is a simple alias for end_dirop().
>
> Apart from changes to the error paths, as we no longer need to unlock on
> a lookup error, an effect on callers is that they don't need to test if
> the found dentry is positive or negative - they can be sure it is
> positive.
>
> Signed-off-by: NeilBrown <neil@brown.name>

I may be reviewing out of order to make progress
because the start_creating() patches are harder to chew on.

For this one though, with minor nit below fix, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> ---
>  fs/cachefiles/namei.c    | 25 ++++++++++---------------
>  fs/namei.c               | 27 +++++++++++++++++++++++++++
>  fs/nfsd/nfs4recover.c    | 18 +++++-------------
>  fs/nfsd/vfs.c            | 26 ++++++++++----------------
>  fs/overlayfs/dir.c       | 15 +++++++--------
>  fs/overlayfs/overlayfs.h |  8 ++++++++
>  include/linux/namei.h    | 17 +++++++++++++++++
>  7 files changed, 84 insertions(+), 52 deletions(-)
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 965b22b2f58d..3064d439807b 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -260,6 +260,7 @@ static int cachefiles_unlink(struct cachefiles_cache =
*cache,
>   * - File backed objects are unlinked
>   * - Directory backed objects are stuffed into the graveyard for userspa=
ce to
>   *   delete
> + * On entry dir must be locked.  It will be unlocked on exit.
>   */
>  int cachefiles_bury_object(struct cachefiles_cache *cache,
>                            struct cachefiles_object *object,
> @@ -275,7 +276,8 @@ int cachefiles_bury_object(struct cachefiles_cache *c=
ache,
>         _enter(",'%pd','%pd'", dir, rep);
>
>         if (rep->d_parent !=3D dir) {
> -               inode_unlock(d_inode(dir));
> +               dget(rep);
> +               end_removing(rep);

This look odd so deserve a comment.

>                 _leave(" =3D -ESTALE");
>                 return -ESTALE;
>         }
> @@ -286,16 +288,16 @@ int cachefiles_bury_object(struct cachefiles_cache =
*cache,
>                             * by a file struct.
>                             */
>                 ret =3D cachefiles_unlink(cache, object, dir, rep, why);
> -               dput(rep);
> +               end_removing(rep);
>
> -               inode_unlock(d_inode(dir));
>                 _leave(" =3D %d", ret);
>                 return ret;
>         }
>
>         /* directories have to be moved to the graveyard */
>         _debug("move stale object to graveyard");
> -       inode_unlock(d_inode(dir));
> +       dget(rep);
> +       end_removing(rep);

ditto

>
>  try_again:
>         /* first step is to make up a grave dentry in the graveyard */
> @@ -745,26 +747,20 @@ static struct dentry *cachefiles_lookup_for_cull(st=
ruct cachefiles_cache *cache,
>         struct dentry *victim;
>         int ret =3D -ENOENT;
>
> -       inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> +       victim =3D start_removing(&nop_mnt_idmap, dir, &QSTR(filename));
>
> -       victim =3D lookup_one(&nop_mnt_idmap, &QSTR(filename), dir);
>         if (IS_ERR(victim))
>                 goto lookup_error;
> -       if (d_is_negative(victim))
> -               goto lookup_put;
>         if (d_inode(victim)->i_flags & S_KERNEL_FILE)
>                 goto lookup_busy;
>         return victim;
>
>  lookup_busy:
>         ret =3D -EBUSY;
> -lookup_put:
> -       inode_unlock(d_inode(dir));
> -       dput(victim);
> +       end_removing(victim);
>         return ERR_PTR(ret);
>
>  lookup_error:
> -       inode_unlock(d_inode(dir));
>         ret =3D PTR_ERR(victim);
>         if (ret =3D=3D -ENOENT)
>                 return ERR_PTR(-ESTALE); /* Probably got retired by the n=
etfs */
> @@ -812,18 +808,17 @@ int cachefiles_cull(struct cachefiles_cache *cache,=
 struct dentry *dir,
>
>         ret =3D cachefiles_bury_object(cache, NULL, dir, victim,
>                                      FSCACHE_OBJECT_WAS_CULLED);
> +       dput(victim);
>         if (ret < 0)
>                 goto error;
>
>         fscache_count_culled();
> -       dput(victim);
>         _leave(" =3D 0");
>         return 0;
>
>  error_unlock:
> -       inode_unlock(d_inode(dir));
> +       end_removing(victim);
>  error:
> -       dput(victim);
>         if (ret =3D=3D -ENOENT)
>                 return -ESTALE; /* Probably got retired by the netfs */
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 064cb44a3a46..0d9e98961758 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3269,6 +3269,33 @@ struct dentry *start_creating(struct mnt_idmap *id=
map, struct dentry *parent,
>  }
>  EXPORT_SYMBOL(start_creating);
>
> +/**
> + * start_removing - prepare to remove a given name with permission check=
ing
> + * @idmap - idmap of the mount
> + * @parent - directory in which to find the name
> + * @name - the name to be removed
> + *
> + * Locks are taken and a lookup in performed prior to removing
> + * an object from a directory.  Permission checking (MAY_EXEC) is perfor=
med
> + * against @idmap.
> + *
> + * If the name doesn't exist, an error is returned.
> + *
> + * end_removing() should be called when removal is complete, or aborted.
> + *
> + * Returns: a positive dentry, or an error.
> + */
> +struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> +                             struct qstr *name)
> +{
> +       int err =3D lookup_one_common(idmap, name, parent);
> +
> +       if (err)
> +               return ERR_PTR(err);
> +       return start_dirop(parent, name, 0);
> +}
> +EXPORT_SYMBOL(start_removing);
> +
>  #ifdef CONFIG_UNIX98_PTYS
>  int path_pts(struct path *path)
>  {
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 93b2a3e764db..0f33e13a9da2 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -345,20 +345,12 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *=
nn)
>         dprintk("NFSD: nfsd4_unlink_clid_dir. name %s\n", name);
>
>         dir =3D nn->rec_file->f_path.dentry;
> -       inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> -       dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(name), dir);
> -       if (IS_ERR(dentry)) {
> -               status =3D PTR_ERR(dentry);
> -               goto out_unlock;
> -       }
> -       status =3D -ENOENT;
> -       if (d_really_is_negative(dentry))
> -               goto out;
> +       dentry =3D start_removing(&nop_mnt_idmap, dir, &QSTR(name));
> +       if (IS_ERR(dentry))
> +               return PTR_ERR(dentry);
> +
>         status =3D vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
> -out:
> -       dput(dentry);
> -out_unlock:
> -       inode_unlock(d_inode(dir));
> +       end_removing(dentry);
>         return status;
>  }
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 90c830c59c60..d5b4550fd8f6 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2021,7 +2021,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>  {
>         struct dentry   *dentry, *rdentry;
>         struct inode    *dirp;
> -       struct inode    *rinode;
> +       struct inode    *rinode =3D NULL;
>         __be32          err;
>         int             host_err;
>
> @@ -2040,24 +2040,21 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, int type,
>
>         dentry =3D fhp->fh_dentry;
>         dirp =3D d_inode(dentry);
> -       inode_lock_nested(dirp, I_MUTEX_PARENT);
>
> -       rdentry =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), de=
ntry);
> +       rdentry =3D start_removing(&nop_mnt_idmap, dentry, &QSTR_LEN(fnam=
e, flen));
> +
>         host_err =3D PTR_ERR(rdentry);
>         if (IS_ERR(rdentry))
> -               goto out_unlock;
> +               goto out_drop_write;
>
> -       if (d_really_is_negative(rdentry)) {
> -               dput(rdentry);
> -               host_err =3D -ENOENT;
> -               goto out_unlock;
> -       }
> -       rinode =3D d_inode(rdentry);
>         err =3D fh_fill_pre_attrs(fhp);
>         if (err !=3D nfs_ok)
>                 goto out_unlock;
>
> +       rinode =3D d_inode(rdentry);
> +       /* Prevent truncation until after locks dropped */
>         ihold(rinode);
> +
>         if (!type)
>                 type =3D d_inode(rdentry)->i_mode & S_IFMT;
>
> @@ -2079,10 +2076,10 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, int type,
>         }
>         fh_fill_post_attrs(fhp);
>
> -       inode_unlock(dirp);
> -       if (!host_err)
> +out_unlock:
> +       end_removing(rdentry);
> +       if (!err && !host_err)
>                 host_err =3D commit_metadata(fhp);
> -       dput(rdentry);
>         iput(rinode);    /* truncate the inode here */
>
>  out_drop_write:
> @@ -2100,9 +2097,6 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>         }
>  out:
>         return err !=3D nfs_ok ? err : nfserrno(host_err);
> -out_unlock:
> -       inode_unlock(dirp);
> -       goto out_drop_write;
>  }
>
>  /*
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 0ae79efbfce7..c4057b4a050d 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -841,17 +841,17 @@ static int ovl_remove_upper(struct dentry *dentry, =
bool is_dir,
>                         goto out;
>         }
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
> -       upper =3D ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
> -                                dentry->d_name.len);
> +       upper =3D ovl_start_removing_upper(ofs, upperdir,
> +                                        &QSTR_LEN(dentry->d_name.name,
> +                                                  dentry->d_name.len));
>         err =3D PTR_ERR(upper);
>         if (IS_ERR(upper))
> -               goto out_unlock;
> +               goto out_dput;
>
>         err =3D -ESTALE;
>         if ((opaquedir && upper !=3D opaquedir) ||
>             (!opaquedir && !ovl_matches_upper(dentry, upper)))
> -               goto out_dput_upper;
> +               goto out_unlock;
>
>         if (is_dir)
>                 err =3D ovl_do_rmdir(ofs, dir, upper);
> @@ -867,10 +867,9 @@ static int ovl_remove_upper(struct dentry *dentry, b=
ool is_dir,
>          */
>         if (!err)
>                 d_drop(dentry);
> -out_dput_upper:
> -       dput(upper);
>  out_unlock:
> -       inode_unlock(dir);
> +       end_removing(upper);
> +out_dput:
>         dput(opaquedir);
>  out:
>         return err;
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index c24c2da953bd..915af58459b7 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -423,6 +423,14 @@ static inline struct dentry *ovl_start_creating_uppe=
r(struct ovl_fs *ofs,
>                               parent, name);
>  }
>
> +static inline struct dentry *ovl_start_removing_upper(struct ovl_fs *ofs=
,
> +                                                     struct dentry *pare=
nt,
> +                                                     struct qstr *name)
> +{
> +       return start_removing(ovl_upper_mnt_idmap(ofs),
> +                             parent, name);
> +}
> +
>  static inline bool ovl_open_flags_need_copy_up(int flags)
>  {
>         if (!flags)
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 4cbe930054a1..63941fdbc23d 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -90,6 +90,8 @@ struct dentry *lookup_one_positive_killable(struct mnt_=
idmap *idmap,
>
>  struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *pa=
rent,
>                               struct qstr *name);
> +struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> +                             struct qstr *name);
>
>  /* end_creating - finish action started with start_creating
>   * @child - dentry returned by start_creating()
> @@ -106,6 +108,21 @@ static inline void end_creating(struct dentry *child=
, struct dentry *parent)
>         end_dirop_mkdir(child, parent);
>  }
>
> +/* end_removing - finish action started with start_removing
> + * @child - dentry returned by start_removing()
> + * @parent - dentry given to start_removing()
> + *
> + * Unlock and release the child.
> + *
> + * This is identical to end_dirop().  It can be passed the result of
> + * start_removing() whether that was successful or not, but it not neede=
d
> + * if start_removing() failed.
> + */
> +static inline void end_removing(struct dentry *child)
> +{
> +       end_dirop(child);
> +}
> +
>  extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);
>  extern int follow_up(struct path *);
> --
> 2.50.0.107.gf914562f5916.dirty
>

