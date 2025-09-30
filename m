Return-Path: <linux-fsdevel+bounces-63091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A44BABC14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBE31C1028
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3251A28469D;
	Tue, 30 Sep 2025 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0XbnqrA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BF1494C3
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216109; cv=none; b=qx77OczSRsSkns3+EE/oKJF2iFd46At7XC6R6HGmcQSWdZsgJ3Bxp1hVdEl1G3TIDqo345Upk8S/E+yzdlxkhgHi5K5YXlUKjZX+ykWjCgTIekuJXzs93/Dhuka5HoHcOEp6XFV7H62nhk2Y+c52KHOjKS8fIPJs1s8m5Ik/6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216109; c=relaxed/simple;
	bh=uFfnmZViX+AzUHxC4eiMMEA1AugyinoRfN94To1LVow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P27G0RdDB1R/F6HiXzknGFcwQTWCQ5StO4kNSXX+af1DhHTxdJ4dxFFuImLRJdwqCTYl16fzcXWimgubL+Z5TcwzpnuK6m9qs5zHwfC6oJSu478OT7fYJcDGbvdYE+ogi7ghY5BCj+9dRc+1Y9x1DBT3WIXzTT0UR+G0kfyv4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0XbnqrA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fc2d92d34so10071130a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 00:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759216106; x=1759820906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji0F1zXGeuAURl3mj8YxHkq0Tq1yOt4ZhIf0C1FZ7gc=;
        b=E0XbnqrAK6RwmB/oZCnTlJyhDRcxbtq74ea6CQILSv4wpTD6+Xu4dQkw6M8UEHBGi4
         qCKF/iPW503uf8wOWaRFlDi/EX/8TKuEuIffedUAmN7PxdfhQJEVpfSFUVbdiuWjTkYB
         a+vAfzwJkNYnaqNzsNH5wvmBSXQuZWUCDEfMQAwFjRrkKsm+B0caq7HFnY++2fXxNl3k
         dlU/2MxIelLQmVuhk8/wxzn8Oo1+nH1PBexYr9neDQBd5ZQpwNNgyjd90iXfxhabmIsC
         l+rFeNCdwbCt8O/OXWCYDx+oDr93/5qJSEGCPGX5DgkR6R6Y2DgED9ZXVrabuPbrTZTQ
         CpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216106; x=1759820906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ji0F1zXGeuAURl3mj8YxHkq0Tq1yOt4ZhIf0C1FZ7gc=;
        b=QeS3IXwSDvjt/jcXwF5xKSyX08Zb1Zrlrh273VrGN3kaIKTy7xzvwIO3R2H4ShWDTh
         vsMtAr0O6BPgKVbghqhAa026Vxx1jk+qtXVgvNc4l91jknwxk0/oa0kfRp03hj+eIRgU
         ccNgaPX+sNal1XfE4+Bjs1WxKC3QepKppPns0ZZTuL9QR+psyzVL/LdkzCZ6vr8AexhH
         HPxbNTkM/xA95uZlBBLyRKLl7rCvaoA8RS4LNMVN14dv7ZXeqDVPgabSth20SCs+pYTe
         kRijamta8DemZVpWrS137AojRdZFhsotIHQIjOvgP05yWOzwvZ8wEveXRhPb3vOkT5Ap
         54tg==
X-Forwarded-Encrypted: i=1; AJvYcCVf5w8HKC1HRWzqMmpQmanU3Cqpq9SRyYIM4QFFFtJ46L+OpDy2LrGgVzTiLIkePxpOu98H4zKn+FugXHE5@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWIPjG22BUEed/YEv0vl9vigJgTUzxuIbde0WdEAM7OZnwDrI
	0Lcd5lS0j0V42b5/7PX2mFNeq2vqHiX9fzSCX9OGeAxZ7GoNXqnu9AFyDXSYc/NY1EubcKyLqub
	DZ1SbzEGWWyj4AZ4Gx37SrIma6f+UYTI=
X-Gm-Gg: ASbGncvH/qFE/X6vaQEtWIsUHIxO1Bkx57Xp7LLNkOm/nXeuSdgP7GHy9PbuGlQWpDd
	IeABBAT839Y0jWefCWb//SE6ppXoeM7nm3aWFXrpey43vb3a7YKlZ2Mcm9ZeB25VcoptjFIv+ZK
	6Gmjg60HdjNOj4wBG3QE44VSOWvxm4CC1JOE2VFfVcDYoSoo3ehY0xNFKZ4x6XYUF4eWBjBYbrG
	axHqy8FzZ/wLbVwm2K/riORut/MOiBB07qWU93sW/02Swz2W4upaCrCwSrmctAshiR3lDNogOS7
X-Google-Smtp-Source: AGHT+IGGihdDBI6FWBPVgGKuCFuht/k9/GTmDUpzMwQ4PmSY4HVzmOB387j2TnuD3oxUXxoKCb+esORSGJtvl8n7bIQ=
X-Received: by 2002:a05:6402:5357:b0:62f:a3ae:ff0d with SMTP id
 4fb4d7f45d1cf-6349f9eef37mr13208901a12.14.1759216105429; Tue, 30 Sep 2025
 00:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-10-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-10-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Sep 2025 09:08:13 +0200
X-Gm-Features: AS18NWBICGoXqFlLahbWnkIjrYCK1tsvSrfOBf32s_ACs3-08XIUummn40DFbc0
Message-ID: <CAOQ4uxiZ=R16EN+Ha_HxgxAhE1r2vKX4Ck+H9_AfyB4a6=9=Zw@mail.gmail.com>
Subject: Re: [PATCH 09/11] VFS/ovl/smb: introduce start_renaming_dentry()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Several callers perform a rename on a dentry they already have, and only
> require lookup for the target name.  This includes smb/server and a few
> different places in overlayfs.
>
> start_renaming_dentry() performs the required lookup and takes the
> required lock using lock_rename_child()
>
> It is used in three places in overlayfs and in ksmbd_vfs_rename().
>
> In the ksmbd case, the parent of the source is not important - the
> source must be renamed from wherever it is.  So start_renaming_dentry()
> allows rd->old_parent to be NULL and only checks it if it is non-NULL.
> On success rd->old_parent will be the parent of old_dentry with an extra
> reference taken.

It is not clear to me why you need to take that extra ref.
It looks very unnatural for start_renaming/end_renaming
to take ref on old_parent and not on new_parent.

If ksmbd needs old_parent it can use old->d_parent after
the start_renaming_dentry() it should be stable. right?
So what's the point of taking this extra ref?

> Other start_renaming function also now take the extra
> reference and end_renaming() now drops this reference as well.
>
> ovl_lookup_temp(), ovl_parent_lock(), and ovl_parent_unlock() are
> all removed as they are no longer needed.
>
> OVL_TEMPNAME_SIZE and ovl_tempname() are now declared in overlayfs.h so
> that ovl_check_rename_whiteout() can access them.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c               | 106 ++++++++++++++++++++++++++++++++++++---
>  fs/overlayfs/copy_up.c   |  47 ++++++++---------
>  fs/overlayfs/dir.c       |  19 +------
>  fs/overlayfs/overlayfs.h |   8 +--
>  fs/overlayfs/super.c     |  20 ++++----
>  fs/overlayfs/util.c      |  11 ----
>  fs/smb/server/vfs.c      |  60 ++++------------------
>  include/linux/namei.h    |   2 +
>  8 files changed, 147 insertions(+), 126 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 79a8b3b47e4d..aca6de83d255 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3686,7 +3686,7 @@ EXPORT_SYMBOL(unlock_rename);
>
>  /**
>   * __start_renaming - lookup and lock names for rename
> - * @rd:           rename data containing parent and flags, and
> + * @rd:           rename data containing parents and flags, and
>   *                for receiving found dentries
>   * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
>   *                LOOKUP_NO_SYMLINKS etc).
> @@ -3697,8 +3697,8 @@ EXPORT_SYMBOL(unlock_rename);
>   * rename.
>   *
>   * On success the found dentrys are stored in @rd.old_dentry,
> - * @rd.new_dentry.  These references and the lock are dropped by
> - * end_renaming().
> + * @rd.new_dentry and an extra ref is taken on @rd.old_parent.
> + * These references and the lock are dropped by end_renaming().
>   *
>   * The passed in qstrs must have the hash calculated, and no permission
>   * checking is performed.
> @@ -3750,6 +3750,7 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
>
>         rd->old_dentry =3D d1;
>         rd->new_dentry =3D d2;
> +       dget(rd->old_parent);
>         return 0;
>
>  out_unlock_3:
> @@ -3765,7 +3766,7 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
>
>  /**
>   * start_renaming - lookup and lock names for rename with permission che=
cking
> - * @rd:           rename data containing parent and flags, and
> + * @rd:           rename data containing parents and flags, and
>   *                for receiving found dentries
>   * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
>   *                LOOKUP_NO_SYMLINKS etc).
> @@ -3776,8 +3777,8 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
>   * rename.
>   *
>   * On success the found dentrys are stored in @rd.old_dentry,
> - * @rd.new_dentry.  These references and the lock are dropped by
> - * end_renaming().
> + * @rd.new_dentry.  Also the refcount on @rd->old_parent is increased.
> + * These references and the lock are dropped by end_renaming().
>   *
>   * The passed in qstrs need not have the hash calculated, and basic
>   * eXecute permission checking is performed against @rd.mnt_idmap.
> @@ -3799,11 +3800,104 @@ int start_renaming(struct renamedata *rd, int lo=
okup_flags,
>  }
>  EXPORT_SYMBOL(start_renaming);
>
> +static int
> +__start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> +                       struct dentry *old_dentry, struct qstr *new_last)
> +{
> +       struct dentry *trap;
> +       struct dentry *d2;
> +       int target_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> +       int err;
> +
> +       if (rd->flags & RENAME_EXCHANGE)
> +               target_flags =3D 0;
> +       if (rd->flags & RENAME_NOREPLACE)
> +               target_flags |=3D LOOKUP_EXCL;
> +
> +       /* Already have the dentry - need to be sure to lock the correct =
parent */
> +       trap =3D lock_rename_child(old_dentry, rd->new_parent);
> +       if (IS_ERR(trap))
> +               return PTR_ERR(trap);
> +       if (d_unhashed(old_dentry) ||
> +           (rd->old_parent && rd->old_parent !=3D old_dentry->d_parent))=
 {
> +               /* dentry was removed, or moved and explicit parent reque=
sted */
> +               d2 =3D ERR_PTR(-EINVAL);
> +               goto out_unlock_2;
> +       }
> +
> +       d2 =3D lookup_one_qstr_excl(new_last, rd->new_parent,
> +                                 lookup_flags | target_flags);
> +       if (IS_ERR(d2))
> +               goto out_unlock_2;
> +
> +       if (old_dentry =3D=3D trap) {
> +               /* source is an ancestor of target */
> +               err =3D -EINVAL;
> +               goto out_unlock_3;
> +       }
> +
> +       if (d2 =3D=3D trap) {
> +               /* target is an ancestor of source */
> +               if (rd->flags & RENAME_EXCHANGE)
> +                       err =3D -EINVAL;
> +               else
> +                       err =3D -ENOTEMPTY;
> +               goto out_unlock_3;
> +       }
> +
> +       rd->old_dentry =3D dget(old_dentry);
> +       rd->new_dentry =3D d2;
> +       rd->old_parent =3D dget(old_dentry->d_parent);
> +       return 0;
> +
> +out_unlock_3:
> +       dput(d2);
> +       d2 =3D ERR_PTR(err);
> +out_unlock_2:
> +       unlock_rename(old_dentry->d_parent, rd->new_parent);
> +       return PTR_ERR(d2);

Please assign err before goto and simplify:

out_dput:
       dput(d2);
out_unlock:
       unlock_rename(old_dentry->d_parent, rd->new_parent);
       return err;

> +}
> +
> +/**
> + * start_renaming_dentry - lookup and lock name for rename with permissi=
on checking
> + * @rd:           rename data containing parents and flags, and
> + *                for receiving found dentries
> + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> + *                LOOKUP_NO_SYMLINKS etc).
> + * @old_dentry:   dentry of name to move
> + * @new_last:     name of target in @rd.new_parent
> + *
> + * Look up target name and ensure locks are in place for
> + * rename.
> + *
> + * On success the found dentry is stored in @rd.new_dentry and
> + * @rd.old_parent is confirmed to be the parent of @old_dentry.  If it
> + * was originally %NULL, it is set.  In either case a refernence is take=
n.

Typo: %NULL, typo: refernence

> + *
> + * References and the lock can be dropped with end_renaming()
> + *
> + * The passed in qstr need not have the hash calculated, and basic
> + * eXecute permission checking is performed against @rd.mnt_idmap.
> + *
> + * Returns: zero or an error.
> + */
> +int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> +                         struct dentry *old_dentry, struct qstr *new_las=
t)
> +{
> +       int err;
> +
> +       err =3D lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent=
);
> +       if (err)
> +               return err;
> +       return __start_renaming_dentry(rd, lookup_flags, old_dentry, new_=
last);
> +}
> +
>  void end_renaming(struct renamedata *rd)
>  {
>         unlock_rename(rd->old_parent, rd->new_parent);
>         dput(rd->old_dentry);
>         dput(rd->new_dentry);
> +       dput(rd->old_parent);
>  }
>  EXPORT_SYMBOL(end_renaming);
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 6a31ea34ff80..3f19548b5d48 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -523,8 +523,8 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> -       struct dentry *index =3D NULL;
>         struct dentry *temp =3D NULL;
> +       struct renamedata rd =3D {};
>         struct qstr name =3D { };
>         int err;
>
> @@ -556,17 +556,15 @@ static int ovl_create_index(struct dentry *dentry, =
const struct ovl_fh *fh,
>         if (err)
>                 goto out;
>
> -       err =3D ovl_parent_lock(indexdir, temp);
> +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +       rd.old_parent =3D indexdir;
> +       rd.new_parent =3D indexdir;
> +       err =3D start_renaming_dentry(&rd, 0, temp, &name);
>         if (err)
>                 goto out;
> -       index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
> -       if (IS_ERR(index)) {
> -               err =3D PTR_ERR(index);
> -       } else {
> -               err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, inde=
x, 0);
> -               dput(index);
> -       }
> -       ovl_parent_unlock(indexdir);
> +
> +       err =3D ovl_do_rename_rd(&rd);
> +       end_renaming(&rd);
>  out:
>         if (err)
>                 ovl_cleanup(ofs, indexdir, temp);
> @@ -763,7 +761,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
>         struct inode *inode;
>         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
> -       struct dentry *temp, *upper, *trap;
> +       struct renamedata rd =3D {};
> +       struct dentry *temp;
>         struct ovl_cu_creds cc;
>         int err;
>         struct ovl_cattr cattr =3D {
> @@ -807,29 +806,27 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
>          * ovl_copy_up_data(), so lock workdir and destdir and make sure =
that
>          * temp wasn't moved before copy up completion or cleanup.
>          */
> -       trap =3D lock_rename(c->workdir, c->destdir);
> -       if (trap || temp->d_parent !=3D c->workdir) {
> +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +       rd.old_parent =3D c->workdir;
> +       rd.new_parent =3D c->destdir;
> +       rd.flags =3D 0;
> +       err =3D start_renaming_dentry(&rd, 0, temp,
> +                                   &QSTR_LEN(c->destname.name, c->destna=
me.len));
> +       if (err =3D=3D -EINVAL || err =3D=3D -EXDEV) {

This error code whitelist is not needed and is too fragile anyway.
After your commit
9d23967b18c64 ("ovl: simplify an error path in ovl_copy_up_workdir()")
any locking error is treated the same - it does not matter what the
reason for lock_rename() or start_renaming_dentry() is.

>                 /* temp or workdir moved underneath us? abort without cle=
anup */
>                 dput(temp);
>                 err =3D -EIO;
> -               if (!IS_ERR(trap))
> -                       unlock_rename(c->workdir, c->destdir);
>                 goto out;
>         }

Frankly, we could get rid of the "abort without cleanup"
comment and instead: err =3D -EIO; goto cleanup_unlocked;
because before cleanup_unlocked, cleanup was relying on the
lock_rename() to take the lock for the cleanup, but we don't need
that anymore.

To be clear, I don't think is it important to goto cleanup_unlocked,
leaving goto out is fine because we are not very sympathetic
to changes to underlying layers while ovl is mounted, so we should
not really care about this cleanup, but for the sake of simpler code
I wouldn't mind the goto cleanup_unlocked.

> -
> -       err =3D ovl_copy_up_metadata(c, temp);
>         if (err)
>                 goto cleanup;

Is this right? should we be calling end_renaming() on error?

Thanks,
Amir.

