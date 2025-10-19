Return-Path: <linux-fsdevel+bounces-64614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C69CBEE2ED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 12:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C170B3A2B0F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D742D94B9;
	Sun, 19 Oct 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz3i+qel"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C227280F
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760869537; cv=none; b=uCOMpdIphy5pVWq0r/kBE6HERIHHVUvyi3zsK+gBO356NnNDHADf05X9PC2EVtuVmeu4ZQxD2m+bXHh0fwDjZLPwGnKCWMKV2muhywjZb1z59hq4Zi/NkHryEqmZo7hmL0AYw0TObrckR4q6S7xmuJ5QQ7DBtRy7wnjoXZKS9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760869537; c=relaxed/simple;
	bh=agDWKtspf7rh38Ru+ZMo15GGDuyEtco/DI2i+qKB8bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edqc61FtIswr/J98Qg9O6o3PINcCw53l5LvH5GLv+6Sm2C4MSrCsPCg5AGjApjSG6Vfrj6O8CWMQHB6s/jC0dgQaRffyraVhuzEgnlGTrWn2x123ggU+1LvGk7/BT23YzkgofqyHbGrXOnmQ+7xo/4kY/W0+RQq5Uvoa0zKjhfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xz3i+qel; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso3318060a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760869533; x=1761474333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWgD1BIC7xAjCLJgVJmQMw+OkYt4avHp81ytAygag80=;
        b=Xz3i+qelz6xGZxsAynt6KQLC5ljCvNovBhaLUf0Jr9EbOHsVZwQMH2fWgi7D4lsrPy
         TZXH9WTQmHZbwmjjrE1CgOy00jFLLn+eQ0UzrpR4oHar9y8yAj5R+Q+gcAlDi2jZI6Ld
         MoeVnjnqrhgsh1/W2J2ex0tPqVDscndJosM1eXsyOC9XFpOBYgJ9wbpFuPbeT24K+QGw
         eH3EvLro4UkuYhWAxmbwGIX/YtmkbOJRf4DghlsixG5tmGtNMlabxDxdhLhBiwVwbUNL
         4i63OX51PNeHYZRHtgP/zcptfGvgpnICJqf+5v3e44xFDp0vrlRIfjq5gpCLtS+M7uBj
         D98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760869533; x=1761474333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWgD1BIC7xAjCLJgVJmQMw+OkYt4avHp81ytAygag80=;
        b=LjsonfiQMMHjQJPt8GaF5JC7Urjlu9P53DBT3wJPOk6r/jq67eOhbpC9czrQr0FUPb
         7w/M9DbJCStPQvyXYaFK7I5OK2OQnGHkygD0IF0OpR2DCKyQ0R+576G1ytS9ZXU1E1Sz
         EshVSaVLNJjYGyCE24Su4dZvnv5eiJ5Ndio5ahj9vgcHEmE34u9Ak81y1f9PjiMNQcL9
         xIGv90DLK4HMSeb73+CHZ1oK/gAGQhGYgX0rLK9Wu2as8ZsTJODE88hyAhI1nWZt/Jbf
         SoWMwBpwKdQPe+Ssk3+N3Ub6q7uk1ryI08sxIv0IAA4KoAL58sIfWpPEYA4QGGhKy+no
         XWig==
X-Forwarded-Encrypted: i=1; AJvYcCXMVwZsW0Qns6zKSIvoxPQ+PUQQD8LNE91SZJC25f/AZpTr7Meo3flYY0SkuyVeH6mLXMV/R23URCCpxgX8@vger.kernel.org
X-Gm-Message-State: AOJu0YzifkzPSUi1y/1r3DcBI9Z3YN40qXfzlTri6RXB7RN4O+XJK8MG
	9j1Gml0DqajUvl8DTlANhXSVoXTo2m7fuNTTkeT8VKcwyWuq0+SmYXZVJO/i0YvLDtyW5+ukf5F
	M6imKapKYRdVlrxAGCVrHQzhqBQveENQIgiS2WG0=
X-Gm-Gg: ASbGncst9xuPJ0W41rb+ueqp/3KXNMc0l7zKACiWrNJrsUWnAHtwLrrmq8o61UGWAVf
	exn8UrL7vS3dPXp4Tz5aiVs/MFUdHRxrJZEc+Pr+Zb8ygyafN6e3+uf4qLIzrnEMTHh7q/1cCDt
	Horm3QtzSchOvT6DVrtCM8iFoGxvsc8d7qi0FThIh5d6T4dtkSy54OHhdH4d5AllJF3ng7QBPj0
	FeuPpJbcEPxMOwiVLbPXcfB6xCqmhfbyTPqE+dxOLhSdr+Uh+Mnp8BdNc1/clYwK3DJdCCF896w
	bNgZgVCWlvSUKEuCSo383nxzAmtaIw==
X-Google-Smtp-Source: AGHT+IHSfG5+wbtvu3QJ+PE/YLkyPpuzqwtDz9rGJ5tYi8IIr07phE9JaqAvC+VGg3SBkEatkqKay6GTCp02smqhdgg=
X-Received: by 2002:a05:6402:5247:b0:63c:4d42:9928 with SMTP id
 4fb4d7f45d1cf-63c4d429ba7mr4148629a12.7.1760869532725; Sun, 19 Oct 2025
 03:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014756.2073439-1-neilb@ownmail.net> <20251015014756.2073439-10-neilb@ownmail.net>
In-Reply-To: <20251015014756.2073439-10-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Oct 2025 12:25:21 +0200
X-Gm-Features: AS18NWBIeBayepDXl4T7eel3w8nUJitodcZppPTg5iQ7_ogJE3KKjW7KExAC-IY
Message-ID: <CAOQ4uxg27fWDEqQYJ9yw25PTZ37qjNUJu36SfQNwdCComP0UOA@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> start_renaming() combines name lookup and locking to prepare for rename.
> It is used when two names need to be looked up as in nfsd and overlayfs -
> cases where one or both dentrys are already available will be handled
> separately.
>
> __start_renaming() avoids the inode_permission check and hash
> calculation and is suitable after filename_parentat() in do_renameat2().
> It subsumes quite a bit of code from that function.
>
> start_renaming() does calculate the hash and check X permission and is
> suitable elsewhere:
> - nfsd_rename()
> - ovl_rename()
>
> Signed-off-by: NeilBrown <neil@brown.name>

Review comments from v1 not addressed:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxh+NcAv9v6NtVRrLCMYbpd0ajtvsd6c=
9-W2a7+vur0UJQ@mail.gmail.com/

> ---
>  fs/namei.c               | 197 ++++++++++++++++++++++++++++-----------
>  fs/nfsd/vfs.c            |  73 +++++----------
>  fs/overlayfs/dir.c       |  72 ++++++--------
>  fs/overlayfs/overlayfs.h |  14 +++
>  include/linux/namei.h    |   3 +
>  5 files changed, 214 insertions(+), 145 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 04d2819bd351..a2553df8f34e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3667,6 +3667,129 @@ void unlock_rename(struct dentry *p1, struct dent=
ry *p2)
>  }
>  EXPORT_SYMBOL(unlock_rename);
>
> +/**
> + * __start_renaming - lookup and lock names for rename
> + * @rd:           rename data containing parent and flags, and
> + *                for receiving found dentries
> + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> + *                LOOKUP_NO_SYMLINKS etc).
> + * @old_last:     name of object in @rd.old_parent
> + * @new_last:     name of object in @rd.new_parent
> + *
> + * Look up two names and ensure locks are in place for
> + * rename.
> + *
> + * On success the found dentrys are stored in @rd.old_dentry,
> + * @rd.new_dentry.  These references and the lock are dropped by
> + * end_renaming().
> + *
> + * The passed in qstrs must have the hash calculated, and no permission
> + * checking is performed.
> + *
> + * Returns: zero or an error.
> + */
> +static int
> +__start_renaming(struct renamedata *rd, int lookup_flags,
> +                struct qstr *old_last, struct qstr *new_last)
> +{
> +       struct dentry *trap;
> +       struct dentry *d1, *d2;
> +       int target_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> +       int err;
> +
> +       if (rd->flags & RENAME_EXCHANGE)
> +               target_flags =3D 0;
> +       if (rd->flags & RENAME_NOREPLACE)
> +               target_flags |=3D LOOKUP_EXCL;
> +
> +       trap =3D lock_rename(rd->old_parent, rd->new_parent);
> +       if (IS_ERR(trap))
> +               return PTR_ERR(trap);
> +
> +       d1 =3D lookup_one_qstr_excl(old_last, rd->old_parent,
> +                                 lookup_flags);
> +       if (IS_ERR(d1))
> +               goto out_unlock_1;
> +
> +       d2 =3D lookup_one_qstr_excl(new_last, rd->new_parent,
> +                                 lookup_flags | target_flags);
> +       if (IS_ERR(d2))
> +               goto out_unlock_2;
> +
> +       if (d1 =3D=3D trap) {
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
> +       rd->old_dentry =3D d1;
> +       rd->new_dentry =3D d2;
> +       return 0;
> +
> +out_unlock_3:
> +       dput(d2);
> +       d2 =3D ERR_PTR(err);
> +out_unlock_2:
> +       dput(d1);
> +       d1 =3D d2;
> +out_unlock_1:
> +       unlock_rename(rd->old_parent, rd->new_parent);
> +       return PTR_ERR(d1);
> +}
> +
> +/**
> + * start_renaming - lookup and lock names for rename with permission che=
cking
> + * @rd:           rename data containing parent and flags, and
> + *                for receiving found dentries
> + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> + *                LOOKUP_NO_SYMLINKS etc).
> + * @old_last:     name of object in @rd.old_parent
> + * @new_last:     name of object in @rd.new_parent
> + *
> + * Look up two names and ensure locks are in place for
> + * rename.
> + *
> + * On success the found dentrys are stored in @rd.old_dentry,
> + * @rd.new_dentry.  These references and the lock are dropped by
> + * end_renaming().
> + *
> + * The passed in qstrs need not have the hash calculated, and basic
> + * eXecute permission checking is performed against @rd.mnt_idmap.
> + *
> + * Returns: zero or an error.
> + */
> +int start_renaming(struct renamedata *rd, int lookup_flags,
> +                  struct qstr *old_last, struct qstr *new_last)
> +{
> +       int err;
> +
> +       err =3D lookup_one_common(rd->mnt_idmap, old_last, rd->old_parent=
);
> +       if (err)
> +               return err;
> +       err =3D lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent=
);
> +       if (err)
> +               return err;
> +       return __start_renaming(rd, lookup_flags, old_last, new_last);
> +}
> +EXPORT_SYMBOL(start_renaming);
> +
> +void end_renaming(struct renamedata *rd)
> +{
> +       unlock_rename(rd->old_parent, rd->new_parent);
> +       dput(rd->old_dentry);
> +       dput(rd->new_dentry);
> +}
> +EXPORT_SYMBOL(end_renaming);
> +
>  /**
>   * vfs_prepare_mode - prepare the mode to be used for a new inode
>   * @idmap:     idmap of the mount the inode was found from
> @@ -5504,14 +5627,11 @@ int do_renameat2(int olddfd, struct filename *fro=
m, int newdfd,
>                  struct filename *to, unsigned int flags)
>  {
>         struct renamedata rd;
> -       struct dentry *old_dentry, *new_dentry;
> -       struct dentry *trap;
>         struct path old_path, new_path;
>         struct qstr old_last, new_last;
>         int old_type, new_type;
>         struct inode *delegated_inode =3D NULL;
> -       unsigned int lookup_flags =3D 0, target_flags =3D
> -               LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> +       unsigned int lookup_flags =3D 0;
>         bool should_retry =3D false;
>         int error =3D -EINVAL;
>
> @@ -5522,11 +5642,6 @@ int do_renameat2(int olddfd, struct filename *from=
, int newdfd,
>             (flags & RENAME_EXCHANGE))
>                 goto put_names;
>
> -       if (flags & RENAME_EXCHANGE)
> -               target_flags =3D 0;
> -       if (flags & RENAME_NOREPLACE)
> -               target_flags |=3D LOOKUP_EXCL;
> -
>  retry:
>         error =3D filename_parentat(olddfd, from, lookup_flags, &old_path=
,
>                                   &old_last, &old_type);
> @@ -5556,66 +5671,40 @@ int do_renameat2(int olddfd, struct filename *fro=
m, int newdfd,
>                 goto exit2;
>
>  retry_deleg:
> -       trap =3D lock_rename(new_path.dentry, old_path.dentry);
> -       if (IS_ERR(trap)) {
> -               error =3D PTR_ERR(trap);
> +       rd.old_parent      =3D old_path.dentry;
> +       rd.mnt_idmap       =3D mnt_idmap(old_path.mnt);
> +       rd.new_parent      =3D new_path.dentry;
> +       rd.delegated_inode =3D &delegated_inode;
> +       rd.flags           =3D flags;
> +
> +       error =3D __start_renaming(&rd, lookup_flags, &old_last, &new_las=
t);
> +       if (error)
>                 goto exit_lock_rename;
> -       }
>
> -       old_dentry =3D lookup_one_qstr_excl(&old_last, old_path.dentry,
> -                                         lookup_flags);
> -       error =3D PTR_ERR(old_dentry);
> -       if (IS_ERR(old_dentry))
> -               goto exit3;
> -       new_dentry =3D lookup_one_qstr_excl(&new_last, new_path.dentry,
> -                                         lookup_flags | target_flags);
> -       error =3D PTR_ERR(new_dentry);
> -       if (IS_ERR(new_dentry))
> -               goto exit4;
>         if (flags & RENAME_EXCHANGE) {
> -               if (!d_is_dir(new_dentry)) {
> +               if (!d_is_dir(rd.new_dentry)) {
>                         error =3D -ENOTDIR;
>                         if (new_last.name[new_last.len])
> -                               goto exit5;
> +                               goto exit_unlock;
>                 }
>         }
>         /* unless the source is a directory trailing slashes give -ENOTDI=
R */
> -       if (!d_is_dir(old_dentry)) {
> +       if (!d_is_dir(rd.old_dentry)) {
>                 error =3D -ENOTDIR;
>                 if (old_last.name[old_last.len])
> -                       goto exit5;
> +                       goto exit_unlock;
>                 if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.=
len])
> -                       goto exit5;
> -       }
> -       /* source should not be ancestor of target */
> -       error =3D -EINVAL;
> -       if (old_dentry =3D=3D trap)
> -               goto exit5;
> -       /* target should not be an ancestor of source */
> -       if (!(flags & RENAME_EXCHANGE))
> -               error =3D -ENOTEMPTY;
> -       if (new_dentry =3D=3D trap)
> -               goto exit5;
> +                       goto exit_unlock;
> +       }
>
> -       error =3D security_path_rename(&old_path, old_dentry,
> -                                    &new_path, new_dentry, flags);
> +       error =3D security_path_rename(&old_path, rd.old_dentry,
> +                                    &new_path, rd.new_dentry, flags);
>         if (error)
> -               goto exit5;
> +               goto exit_unlock;
>
> -       rd.old_parent      =3D old_path.dentry;
> -       rd.old_dentry      =3D old_dentry;
> -       rd.mnt_idmap       =3D mnt_idmap(old_path.mnt);
> -       rd.new_parent      =3D new_path.dentry;
> -       rd.new_dentry      =3D new_dentry;
> -       rd.delegated_inode =3D &delegated_inode;
> -       rd.flags           =3D flags;
>         error =3D vfs_rename(&rd);
> -exit5:
> -       dput(new_dentry);
> -exit4:
> -       dput(old_dentry);
> -exit3:
> -       unlock_rename(new_path.dentry, old_path.dentry);
> +exit_unlock:
> +       end_renaming(&rd);
>  exit_lock_rename:
>         if (delegated_inode) {
>                 error =3D break_deleg_wait(&delegated_inode);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index cd64ffe12e0b..62109885d4db 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1885,11 +1885,12 @@ __be32
>  nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, in=
t flen,
>                             struct svc_fh *tfhp, char *tname, int tlen)
>  {
> -       struct dentry   *fdentry, *tdentry, *odentry, *ndentry, *trap;
> +       struct dentry   *fdentry, *tdentry;
>         int             type =3D S_IFDIR;
> +       struct renamedata rd =3D {};
>         __be32          err;
>         int             host_err;
> -       bool            close_cached =3D false;
> +       struct dentry   *close_cached;
>
>         trace_nfsd_vfs_rename(rqstp, ffhp, tfhp, fname, flen, tname, tlen=
);
>
> @@ -1915,15 +1916,22 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
>                 goto out;
>
>  retry:
> +       close_cached =3D NULL;
>         host_err =3D fh_want_write(ffhp);
>         if (host_err) {
>                 err =3D nfserrno(host_err);
>                 goto out;
>         }
>
> -       trap =3D lock_rename(tdentry, fdentry);
> -       if (IS_ERR(trap)) {
> -               err =3D nfserr_xdev;
> +       rd.mnt_idmap    =3D &nop_mnt_idmap;
> +       rd.old_parent   =3D fdentry;
> +       rd.new_parent   =3D tdentry;
> +
> +       host_err =3D start_renaming(&rd, 0, &QSTR_LEN(fname, flen),
> +                                 &QSTR_LEN(tname, tlen));
> +
> +       if (host_err) {
> +               err =3D nfserrno(host_err);
>                 goto out_want_write;
>         }
>         err =3D fh_fill_pre_attrs(ffhp);
> @@ -1933,48 +1941,23 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
>         if (err !=3D nfs_ok)
>                 goto out_unlock;
>
> -       odentry =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), fd=
entry);
> -       host_err =3D PTR_ERR(odentry);
> -       if (IS_ERR(odentry))
> -               goto out_nfserr;
> +       type =3D d_inode(rd.old_dentry)->i_mode & S_IFMT;
> +
> +       if (d_inode(rd.new_dentry))
> +               type =3D d_inode(rd.new_dentry)->i_mode & S_IFMT;
>
> -       host_err =3D -ENOENT;
> -       if (d_really_is_negative(odentry))
> -               goto out_dput_old;
> -       host_err =3D -EINVAL;
> -       if (odentry =3D=3D trap)
> -               goto out_dput_old;
> -       type =3D d_inode(odentry)->i_mode & S_IFMT;
> -
> -       ndentry =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(tname, tlen), td=
entry);
> -       host_err =3D PTR_ERR(ndentry);
> -       if (IS_ERR(ndentry))
> -               goto out_dput_old;
> -       if (d_inode(ndentry))
> -               type =3D d_inode(ndentry)->i_mode & S_IFMT;
> -       host_err =3D -ENOTEMPTY;
> -       if (ndentry =3D=3D trap)
> -               goto out_dput_new;
> -
> -       if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_U=
NLINK) &&
> -           nfsd_has_cached_files(ndentry)) {
> -               close_cached =3D true;
> -               goto out_dput_old;
> +       if ((rd.new_dentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BE=
FORE_UNLINK) &&
> +           nfsd_has_cached_files(rd.new_dentry)) {
> +               close_cached =3D dget(rd.new_dentry);
> +               goto out_unlock;
>         } else {
> -               struct renamedata rd =3D {
> -                       .mnt_idmap      =3D &nop_mnt_idmap,
> -                       .old_parent     =3D fdentry,
> -                       .old_dentry     =3D odentry,
> -                       .new_parent     =3D tdentry,
> -                       .new_dentry     =3D ndentry,
> -               };
>                 int retries;
>
>                 for (retries =3D 1;;) {
>                         host_err =3D vfs_rename(&rd);
>                         if (host_err !=3D -EAGAIN || !retries--)
>                                 break;
> -                       if (!nfsd_wait_for_delegreturn(rqstp, d_inode(ode=
ntry)))
> +                       if (!nfsd_wait_for_delegreturn(rqstp, d_inode(rd.=
old_dentry)))
>                                 break;
>                 }
>                 if (!host_err) {
> @@ -1983,11 +1966,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh =
*ffhp, char *fname, int flen,
>                                 host_err =3D commit_metadata(ffhp);
>                 }
>         }
> - out_dput_new:
> -       dput(ndentry);
> - out_dput_old:
> -       dput(odentry);
> - out_nfserr:
>         if (host_err =3D=3D -EBUSY) {
>                 /*
>                  * See RFC 8881 Section 18.26.4 para 1-3: NFSv4 RENAME
> @@ -2006,7 +1984,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>                 fh_fill_post_attrs(tfhp);
>         }
>  out_unlock:
> -       unlock_rename(tdentry, fdentry);
> +       end_renaming(&rd);
>  out_want_write:
>         fh_drop_write(ffhp);
>
> @@ -2017,9 +1995,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>          * until this point and then reattempt the whole shebang.
>          */
>         if (close_cached) {
> -               close_cached =3D false;
> -               nfsd_close_cached_files(ndentry);
> -               dput(ndentry);
> +               nfsd_close_cached_files(close_cached);
> +               dput(close_cached);
>                 goto retry;
>         }
>  out:
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index c8d0885ee5e0..ded86855e91c 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1124,9 +1124,7 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         int err;
>         struct dentry *old_upperdir;
>         struct dentry *new_upperdir;
> -       struct dentry *olddentry =3D NULL;
> -       struct dentry *newdentry =3D NULL;
> -       struct dentry *trap, *de;
> +       struct renamedata rd =3D {};
>         bool old_opaque;
>         bool new_opaque;
>         bool cleanup_whiteout =3D false;
> @@ -1233,29 +1231,21 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>                 }
>         }
>
> -       trap =3D lock_rename(new_upperdir, old_upperdir);
> -       if (IS_ERR(trap)) {
> -               err =3D PTR_ERR(trap);
> -               goto out_revert_creds;
> -       }
> +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +       rd.old_parent =3D old_upperdir;
> +       rd.new_parent =3D new_upperdir;
> +       rd.flags =3D flags;
>
> -       de =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
> -                             old->d_name.len);
> -       err =3D PTR_ERR(de);
> -       if (IS_ERR(de))
> -               goto out_unlock;
> -       olddentry =3D de;
> +       err =3D start_renaming(&rd, 0,
> +                            &QSTR_LEN(old->d_name.name, old->d_name.len)=
,
> +                            &QSTR_LEN(new->d_name.name, new->d_name.len)=
);
>
> -       err =3D -ESTALE;
> -       if (!ovl_matches_upper(old, olddentry))
> -               goto out_unlock;
> +       if (err)
> +               goto out_revert_creds;
>
> -       de =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
> -                             new->d_name.len);
> -       err =3D PTR_ERR(de);
> -       if (IS_ERR(de))
> +       err =3D -ESTALE;
> +       if (!ovl_matches_upper(old, rd.old_dentry))
>                 goto out_unlock;
> -       newdentry =3D de;
>
>         old_opaque =3D ovl_dentry_is_opaque(old);
>         new_opaque =3D ovl_dentry_is_opaque(new);
> @@ -1263,15 +1253,15 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>         err =3D -ESTALE;
>         if (d_inode(new) && ovl_dentry_upper(new)) {
>                 if (opaquedir) {
> -                       if (newdentry !=3D opaquedir)
> +                       if (rd.new_dentry !=3D opaquedir)
>                                 goto out_unlock;
>                 } else {
> -                       if (!ovl_matches_upper(new, newdentry))
> +                       if (!ovl_matches_upper(new, rd.new_dentry))
>                                 goto out_unlock;
>                 }
>         } else {
> -               if (!d_is_negative(newdentry)) {
> -                       if (!new_opaque || !ovl_upper_is_whiteout(ofs, ne=
wdentry))
> +               if (!d_is_negative(rd.new_dentry)) {
> +                       if (!new_opaque || !ovl_upper_is_whiteout(ofs, rd=
.new_dentry))
>                                 goto out_unlock;
>                 } else {
>                         if (flags & RENAME_EXCHANGE)
> @@ -1279,19 +1269,14 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>                 }
>         }
>
> -       if (olddentry =3D=3D trap)
> -               goto out_unlock;
> -       if (newdentry =3D=3D trap)
> -               goto out_unlock;
> -
> -       if (olddentry->d_inode =3D=3D newdentry->d_inode)
> +       if (rd.old_dentry->d_inode =3D=3D rd.new_dentry->d_inode)
>                 goto out_unlock;
>
>         err =3D 0;
>         if (ovl_type_merge_or_lower(old))
>                 err =3D ovl_set_redirect(old, samedir);
>         else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
> -               err =3D ovl_set_opaque_xerr(old, olddentry, -EXDEV);
> +               err =3D ovl_set_opaque_xerr(old, rd.old_dentry, -EXDEV);
>         if (err)
>                 goto out_unlock;
>
> @@ -1299,19 +1284,22 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>                 err =3D ovl_set_redirect(new, samedir);
>         else if (!overwrite && new_is_dir && !new_opaque &&
>                  ovl_type_merge(old->d_parent))
> -               err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
> +               err =3D ovl_set_opaque_xerr(new, rd.new_dentry, -EXDEV);
>         if (err)
>                 goto out_unlock;
>
> -       err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
> -                           new_upperdir, newdentry, flags);
> -       unlock_rename(new_upperdir, old_upperdir);
> +       err =3D ovl_do_rename_rd(&rd);
> +
> +       dget(rd.new_dentry);
> +       end_renaming(&rd);
> +
> +       if (!err && cleanup_whiteout) {
> +               ovl_cleanup(ofs, old_upperdir, rd.new_dentry);
> +       }
> +       dput(rd.new_dentry);
>         if (err)
>                 goto out_revert_creds;
>
> -       if (cleanup_whiteout)
> -               ovl_cleanup(ofs, old_upperdir, newdentry);
> -
>         if (overwrite && d_inode(new)) {
>                 if (new_is_dir)
>                         clear_nlink(d_inode(new));
> @@ -1336,14 +1324,12 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>         else
>                 ovl_drop_write(old);
>  out:
> -       dput(newdentry);
> -       dput(olddentry);
>         dput(opaquedir);
>         ovl_cache_free(&list);
>         return err;
>
>  out_unlock:
> -       unlock_rename(new_upperdir, old_upperdir);
> +       end_renaming(&rd);
>         goto out_revert_creds;
>  }
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 49ad65f829dc..aecb527e0524 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -378,6 +378,20 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, =
struct dentry *olddir,
>         return err;
>  }
>
> +static inline int ovl_do_rename_rd(struct renamedata *rd)
> +{
> +       int err;
> +
> +       pr_debug("rename(%pd2, %pd2, 0x%x)\n", rd->old_dentry, rd->new_de=
ntry,
> +                rd->flags);
> +       err =3D vfs_rename(rd);
> +       if (err) {
> +               pr_debug("...rename(%pd2, %pd2, ...) =3D %i\n",
> +                        rd->old_dentry, rd->new_dentry, err);
> +       }
> +       return err;
> +}
> +
>  static inline int ovl_do_whiteout(struct ovl_fs *ofs,
>                                   struct inode *dir, struct dentry *dentr=
y)
>  {
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index e5cff89679df..19c3d8e336d5 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -156,6 +156,9 @@ extern int follow_up(struct path *);
>  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
>  extern struct dentry *lock_rename_child(struct dentry *, struct dentry *=
);
>  extern void unlock_rename(struct dentry *, struct dentry *);
> +int start_renaming(struct renamedata *rd, int lookup_flags,
> +                  struct qstr *old_last, struct qstr *new_last);
> +void end_renaming(struct renamedata *rd);
>
>  /**
>   * mode_strip_umask - handle vfs umask stripping
> --
> 2.50.0.107.gf914562f5916.dirty
>

