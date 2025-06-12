Return-Path: <linux-fsdevel+bounces-51405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF9AD67DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 08:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8061897640
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 06:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64321F0E4B;
	Thu, 12 Jun 2025 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImnXNj2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7E14A8B;
	Thu, 12 Jun 2025 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709224; cv=none; b=m/HaWxqyuJ/HRKfhgzkBSp05lJzGYSaSCaZrlF+Jie0+1JerNg7i4r491v/xvMccsiX5wApZ7o35yICB/1D8+6yQZc+IRmh2ey60FkraTGEJPZ1agpHkeAO2nENvGv1PUxEPL85xFhVR0xNPbwPmRbeyipGDhdfbBTXYq9JXWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709224; c=relaxed/simple;
	bh=ROL57B4C1PzXfkxTk3k39JMgjd/+cIAnEhMhagBXZgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBulsNEBevCXVK8dWyQoLsaLmI0a7kjZU7MP0GlNyQuBwKWBR6JcXsfq6cDK6aIhkpymKli4jApK88rLfqUPRjHpUP5Rvy7Y5Y2xiExRYcQ7qQDtf3s1panwqoqQaXR7RXgfmnCItlED55JOq5u4RyVkNEqTp+sq3b8uNsydYVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImnXNj2V; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acb5ec407b1so103504366b.1;
        Wed, 11 Jun 2025 23:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749709220; x=1750314020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsvPI6p8jzrn37KI0Y8zRydotCTdKcnBA3r1zxQs9lU=;
        b=ImnXNj2V9mtYSuToiL8r6Qz7rx4UnYDQc+NGwmZsFg+IE5GW9aLjPMhAh3ocCKNzH7
         6XnFYXE0Y8YPyGvpgmdhTGR3T+dKPnQINbotrRRXmc2aaC/EiyOaPFZeFRXvdkN6kceb
         bFqySryCsKZIQQDhid5neHC6+G+XUA0tsWQYvgfVXEs9LDioPymM9VgAHEPP561D7H5D
         XiXo+Jx0Oxpc3uiQG+rNmfQ2iAk/WD+tGusPt4gMDj4M1FSpNpCSltlATP84aXv5HQHw
         C40CpIAsJEmyZrzKSV5TfdhFGjSM7tnSragRKzwAtv9wqImiyOy/tT3dXGgd6iC9TY/w
         RO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749709220; x=1750314020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsvPI6p8jzrn37KI0Y8zRydotCTdKcnBA3r1zxQs9lU=;
        b=wVEUpUkbk/xIIaN/LOLbkdCt24v9ROOdvo+lrAFrzhpm9Q7qYJPIo9riinIGI27uWo
         LUDxF9Q26Uj36yif5SsDitBIcv6V8RMdOTpZkBD2Yme5M2qQ7ZKipd4buQNf5a/m+7Ge
         Rrd3RpvcuhpyRFYzP5jfoTBq/HiyR+KGtShmlFhwIWsk2YozfKX3Ii0RuMjnRfV65cfl
         ki4EIBN7WonjruW+TBtWWdQZ0DJrGohK9KVDa0qQE0ScXSEgBB5vn40QEYtYfzmiDVm2
         rzod76t+HwpNottq5hl3wAqpA3txtKJEfgMpC/RKseB+cUcjYaZXp8wjAUH1Oa1oci/s
         PbUw==
X-Forwarded-Encrypted: i=1; AJvYcCVrvMDo52v7MIYYfufTeT0qKA9o5IwvyaeR6wKv/P5YFdvGzh2nscLuUaKODWYoVL+WPPjU0qb0asmbOw==@vger.kernel.org, AJvYcCWE3WRXuB9YSmM8lB58W1z+FZeiPK5hULq+arNk/XGsGnibh2Hqcr9Mo3nrSulB2uPyPbbqRioWml8BWSk2@vger.kernel.org, AJvYcCWfEiUCEeKl/bHX8w8RZfce1Pz/Arqt5NmUzn00LVTkFEf+r7mvniAYocHJA57vg4imGFpl6unV1j2KCOujzA==@vger.kernel.org, AJvYcCWn+EOvoOVZJi4F/ASy+7e1R4rDK6Au4dNBfJVEbwQPPpgMdyt5KgzDQwxR5urMvjFcpcB3leZKAQ==@vger.kernel.org, AJvYcCWuFN4jfa0Si868siQIAIl5/LljRnihGzVLh06UpNR+YJLwQ0zLYPuTwQjto02TJCo7aJY0vnxTbAVE@vger.kernel.org, AJvYcCXCRwNch1YF5dH0zUW16WvABlded2rP+Vy6lK7OlVHRPM2TMPS9h2q0rumpUlQsWkfbwMtAb5zXgACtvPBa8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOowOjG0KD1hwNPIoKyC7QQ8RkJBjrgmHoBno6zVzodoQtCT07
	Y1A2IfFUtVvi18j8jZbc7mrZQLAWuVCPCu8idaGS0zoh9MSk0ith4F+MquzFX/izknTBiaYHcHL
	y9XEcWxe2AAnprPzy3/BFnqM9FajLHhc=
X-Gm-Gg: ASbGncv9CfTzzQE+A/GX8B7/aMJHOiYqPDrkTRtyBiNLF3Wy6MmWyPMRtgCEQtt7N1+
	WxZZ299BZd2oxeJJLlENQ802cB2VUAtWWIOu4Rd9ryA+oYknIuxkRzNNoYhZ64Ju36LEmNsrUw9
	nhQQytO7a/lxxtaZiwwYk5+RUL002iY85znn5KRhh+qOc=
X-Google-Smtp-Source: AGHT+IEfv36oKkPid/8r6FrxPKQB/uPiTZlRIEgJe/VyBosZyqDB53l0dcs1mgmwkGFrRdPIQk1jgMMUkEAouEr/kSM=
X-Received: by 2002:a17:907:7208:b0:ad5:430b:9013 with SMTP id
 a640c23a62f3a-adea2714a7dmr240969966b.42.1749709219937; Wed, 11 Jun 2025
 23:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611225848.1374929-1-neil@brown.name> <20250611225848.1374929-2-neil@brown.name>
In-Reply-To: <20250611225848.1374929-2-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Jun 2025 08:20:08 +0200
X-Gm-Features: AX0GCFvAa4t1BNVGZfnqWhM_rSPz41NDychwwTzBAcMrTlMp36ygzGDsHLheIjA
Message-ID: <CAOQ4uxiFf8sY0SrTAi+6LOFcL3ChfRkGimaoo-GELLyca9_WRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] VFS: change old_dir and new_dir in struct renamedata
 to dentrys
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:59=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> all users of 'struct renamedata' have the dentry for the old and new
> directories, and often have no use for the inode except to store it in
> the renamedata.
>
> This patch changes struct renamedata to hold the dentry, rather than
> the inode, for the old and new directories, and changes callers to
> match.
>
> This results in the removal of several local variables and several
> dereferences of ->d_inode at the cost of adding ->d_inode dereferences
> to vfs_rename().
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/namei.c    |  4 ++--
>  fs/ecryptfs/inode.c      |  4 ++--
>  fs/namei.c               |  6 +++---
>  fs/nfsd/vfs.c            |  7 ++-----
>  fs/overlayfs/copy_up.c   |  6 +++---
>  fs/overlayfs/dir.c       | 16 ++++++++--------
>  fs/overlayfs/overlayfs.h |  6 +++---
>  fs/overlayfs/readdir.c   |  2 +-
>  fs/overlayfs/super.c     |  2 +-
>  fs/overlayfs/util.c      |  2 +-
>  fs/smb/server/vfs.c      |  4 ++--
>  include/linux/fs.h       |  4 ++--
>  12 files changed, 30 insertions(+), 33 deletions(-)
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index aecfc5c37b49..053fc28b5423 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -388,10 +388,10 @@ int cachefiles_bury_object(struct cachefiles_cache =
*cache,
>         } else {
>                 struct renamedata rd =3D {
>                         .old_mnt_idmap  =3D &nop_mnt_idmap,
> -                       .old_dir        =3D d_inode(dir),
> +                       .old_dir        =3D dir,
>                         .old_dentry     =3D rep,
>                         .new_mnt_idmap  =3D &nop_mnt_idmap,
> -                       .new_dir        =3D d_inode(cache->graveyard),
> +                       .new_dir        =3D cache->graveyard,
>                         .new_dentry     =3D grave,
>                 };
>                 trace_cachefiles_rename(object, d_inode(rep)->i_ino, why)=
;
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 493d7f194956..c9fec8b7e000 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -635,10 +635,10 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct ino=
de *old_dir,
>         }
>
>         rd.old_mnt_idmap        =3D &nop_mnt_idmap;
> -       rd.old_dir              =3D d_inode(lower_old_dir_dentry);
> +       rd.old_dir              =3D lower_old_dir_dentry;
>         rd.old_dentry           =3D lower_old_dentry;
>         rd.new_mnt_idmap        =3D &nop_mnt_idmap;
> -       rd.new_dir              =3D d_inode(lower_new_dir_dentry);
> +       rd.new_dir              =3D lower_new_dir_dentry;
>         rd.new_dentry           =3D lower_new_dentry;
>         rc =3D vfs_rename(&rd);
>         if (rc)
> diff --git a/fs/namei.c b/fs/namei.c
> index 019073162b8a..5b0be8bca50d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5007,7 +5007,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname,=
 const char __user *, newname
>  int vfs_rename(struct renamedata *rd)
>  {
>         int error;
> -       struct inode *old_dir =3D rd->old_dir, *new_dir =3D rd->new_dir;
> +       struct inode *old_dir =3D d_inode(rd->old_dir), *new_dir =3D d_in=
ode(rd->new_dir);
>         struct dentry *old_dentry =3D rd->old_dentry;
>         struct dentry *new_dentry =3D rd->new_dentry;
>         struct inode **delegated_inode =3D rd->delegated_inode;
> @@ -5266,10 +5266,10 @@ int do_renameat2(int olddfd, struct filename *fro=
m, int newdfd,
>         if (error)
>                 goto exit5;
>
> -       rd.old_dir         =3D old_path.dentry->d_inode;
> +       rd.old_dir         =3D old_path.dentry;
>         rd.old_dentry      =3D old_dentry;
>         rd.old_mnt_idmap   =3D mnt_idmap(old_path.mnt);
> -       rd.new_dir         =3D new_path.dentry->d_inode;
> +       rd.new_dir         =3D new_path.dentry;
>         rd.new_dentry      =3D new_dentry;
>         rd.new_mnt_idmap   =3D mnt_idmap(new_path.mnt);
>         rd.delegated_inode =3D &delegated_inode;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index cd689df2ca5d..3c87fbd22c57 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1864,7 +1864,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>                             struct svc_fh *tfhp, char *tname, int tlen)
>  {
>         struct dentry   *fdentry, *tdentry, *odentry, *ndentry, *trap;
> -       struct inode    *fdir, *tdir;
>         int             type =3D S_IFDIR;
>         __be32          err;
>         int             host_err;
> @@ -1880,10 +1879,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh =
*ffhp, char *fname, int flen,
>                 goto out;
>
>         fdentry =3D ffhp->fh_dentry;
> -       fdir =3D d_inode(fdentry);
>
>         tdentry =3D tfhp->fh_dentry;
> -       tdir =3D d_inode(tdentry);
>
>         err =3D nfserr_perm;
>         if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tl=
en))
> @@ -1944,10 +1941,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
>         } else {
>                 struct renamedata rd =3D {
>                         .old_mnt_idmap  =3D &nop_mnt_idmap,
> -                       .old_dir        =3D fdir,
> +                       .old_dir        =3D fdentry,
>                         .old_dentry     =3D odentry,
>                         .new_mnt_idmap  =3D &nop_mnt_idmap,
> -                       .new_dir        =3D tdir,
> +                       .new_dir        =3D tdentry,
>                         .new_dentry     =3D ndentry,
>                 };
>                 int retries;
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index d7310fcf3888..8a3c0d18ec2e 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -563,7 +563,7 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
>         if (IS_ERR(index)) {
>                 err =3D PTR_ERR(index);
>         } else {
> -               err =3D ovl_do_rename(ofs, dir, temp, dir, index, 0);
> +               err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, inde=
x, 0);
>                 dput(index);
>         }
>  out:
> @@ -762,7 +762,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
>         struct inode *inode;
> -       struct inode *udir =3D d_inode(c->destdir), *wdir =3D d_inode(c->=
workdir);
> +       struct inode *wdir =3D d_inode(c->workdir);
>         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
>         struct dentry *temp, *upper, *trap;
>         struct ovl_cu_creds cc;
> @@ -829,7 +829,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>         if (IS_ERR(upper))
>                 goto cleanup;
>
> -       err =3D ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
> +       err =3D ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0=
);
>         dput(upper);
>         if (err)
>                 goto cleanup;
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index fe493f3ed6b6..4fc221ea6480 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -107,7 +107,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs=
)
>  }
>
>  /* Caller must hold i_mutex on both workdir and dir */
> -int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
> +int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
>                              struct dentry *dentry)
>  {
>         struct inode *wdir =3D ofs->workdir->d_inode;
> @@ -123,7 +123,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, stru=
ct inode *dir,
>         if (d_is_dir(dentry))
>                 flags =3D RENAME_EXCHANGE;
>
> -       err =3D ovl_do_rename(ofs, wdir, whiteout, dir, dentry, flags);
> +       err =3D ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, f=
lags);
>         if (err)
>                 goto kill_whiteout;
>         if (flags)
> @@ -384,7 +384,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>         if (err)
>                 goto out_cleanup;
>
> -       err =3D ovl_do_rename(ofs, wdir, opaquedir, udir, upper, RENAME_E=
XCHANGE);
> +       err =3D ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, R=
ENAME_EXCHANGE);
>         if (err)
>                 goto out_cleanup;
>
> @@ -491,14 +491,14 @@ static int ovl_create_over_whiteout(struct dentry *=
dentry, struct inode *inode,
>                 if (err)
>                         goto out_cleanup;
>
> -               err =3D ovl_do_rename(ofs, wdir, newdentry, udir, upper,
> +               err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper,
>                                     RENAME_EXCHANGE);
>                 if (err)
>                         goto out_cleanup;
>
>                 ovl_cleanup(ofs, wdir, upper);
>         } else {
> -               err =3D ovl_do_rename(ofs, wdir, newdentry, udir, upper, =
0);
> +               err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper, 0);
>                 if (err)
>                         goto out_cleanup;
>         }
> @@ -774,7 +774,7 @@ static int ovl_remove_and_whiteout(struct dentry *den=
try,
>                 goto out_dput_upper;
>         }
>
> -       err =3D ovl_cleanup_and_whiteout(ofs, d_inode(upperdir), upper);
> +       err =3D ovl_cleanup_and_whiteout(ofs, upperdir, upper);
>         if (err)
>                 goto out_d_drop;
>
> @@ -1246,8 +1246,8 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         if (err)
>                 goto out_dput;
>
> -       err =3D ovl_do_rename(ofs, old_upperdir->d_inode, olddentry,
> -                           new_upperdir->d_inode, newdentry, flags);
> +       err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
> +                           new_upperdir, newdentry, flags);
>         if (err)
>                 goto out_dput;
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 8baaba0a3fe5..65f9d51bed7c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -353,8 +353,8 @@ static inline int ovl_do_remove_acl(struct ovl_fs *of=
s, struct dentry *dentry,
>         return vfs_remove_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name)=
;
>  }
>
> -static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir=
,
> -                               struct dentry *olddentry, struct inode *n=
ewdir,
> +static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddi=
r,
> +                               struct dentry *olddentry, struct dentry *=
newdir,
>                                 struct dentry *newdentry, unsigned int fl=
ags)
>  {
>         int err;
> @@ -826,7 +826,7 @@ static inline void ovl_copyflags(struct inode *from, =
struct inode *to)
>
>  /* dir.c */
>  extern const struct inode_operations ovl_dir_inode_operations;
> -int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
> +int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
>                              struct dentry *dentry);
>  struct ovl_cattr {
>         dev_t rdev;
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 474c80d210d1..68cca52ae2ac 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1235,7 +1235,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                          * Whiteout orphan index to block future open by
>                          * handle after overlay nlink dropped to zero.
>                          */
> -                       err =3D ovl_cleanup_and_whiteout(ofs, dir, index)=
;
> +                       err =3D ovl_cleanup_and_whiteout(ofs, indexdir, i=
ndex);
>                 } else {
>                         /* Cleanup orphan index entries */
>                         err =3D ovl_cleanup(ofs, dir, index);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index e19940d649ca..cf99b276fdfb 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -580,7 +580,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *o=
fs)
>
>         /* Name is inline and stable - using snapshot as a copy helper */
>         take_dentry_name_snapshot(&name, temp);
> -       err =3D ovl_do_rename(ofs, dir, temp, dir, dest, RENAME_WHITEOUT)=
;
> +       err =3D ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_W=
HITEOUT);
>         if (err) {
>                 if (err =3D=3D -EINVAL)
>                         err =3D 0;
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index dcccb4b4a66c..2b4754c645ee 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1115,7 +1115,7 @@ static void ovl_cleanup_index(struct dentry *dentry=
)
>         } else if (ovl_index_all(dentry->d_sb)) {
>                 /* Whiteout orphan index to block future open by handle *=
/
>                 err =3D ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
> -                                              dir, index);
> +                                              indexdir, index);
>         } else {
>                 /* Cleanup orphan index entries */
>                 err =3D ovl_cleanup(ofs, dir, index);
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index ba45e809555a..b8d913c61623 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -764,10 +764,10 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const=
 struct path *old_path,
>         }
>
>         rd.old_mnt_idmap        =3D mnt_idmap(old_path->mnt),
> -       rd.old_dir              =3D d_inode(old_parent),
> +       rd.old_dir              =3D old_parent,
>         rd.old_dentry           =3D old_child,
>         rd.new_mnt_idmap        =3D mnt_idmap(new_path.mnt),
> -       rd.new_dir              =3D new_path.dentry->d_inode,
> +       rd.new_dir              =3D new_path.dentry,
>         rd.new_dentry           =3D new_dentry,
>         rd.flags                =3D flags,
>         rd.delegated_inode      =3D NULL,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 16f40a6f8264..9a83904c9d4a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2016,10 +2016,10 @@ int vfs_unlink(struct mnt_idmap *, struct inode *=
, struct dentry *,
>   */
>  struct renamedata {
>         struct mnt_idmap *old_mnt_idmap;
> -       struct inode *old_dir;
> +       struct dentry *old_dir;
>         struct dentry *old_dentry;
>         struct mnt_idmap *new_mnt_idmap;
> -       struct inode *new_dir;
> +       struct dentry *new_dir;
>         struct dentry *new_dentry;
>         struct inode **delegated_inode;
>         unsigned int flags;
> --

It bothers me a bit that we are keeping the field name while changing its t=
ype.

There is a wide convention in vfs methods and helpers of using
struct inode *dir
as the parent directory inode
and often (but not always) using
struct dentry *parent
as the parent dentry

How do you feel about making struct renamedata use:

struct dentry *old_parent;
struct dentry *new_parent;

I don't think it will add any churn beyond what this patch already does.

Thanks,
Amir.

