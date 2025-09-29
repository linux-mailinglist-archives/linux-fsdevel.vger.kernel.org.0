Return-Path: <linux-fsdevel+bounces-63026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11186BA8FFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0B0E4E1809
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B43002A1;
	Mon, 29 Sep 2025 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG5Igbka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E518FDAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145025; cv=none; b=pKWr/G7sdjKiwOhrv1JXFbFlNlqvOUmlILYdBlHuJ1dnFMHu1GiqZkLMwOCC5XC/XOiRJDKSKb5pXera1Ddj8GqnXO+zZc0R8bggtYEVKQXyJBiJi8dQoZm9/Kx/wbClbRnDUO4EhCUzAvpT9BYUkjrVYqe0kgf0W1HyMDrGLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145025; c=relaxed/simple;
	bh=ex4JcxZ8dh3HCFck01yfW4ZOuuc1Hhj5Y2lwDCnB1sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLP7rljx+2ZrCXuUVuT/dJT7b7goAI895So0ZxDa+HQBWFRoi18b7WbJxmMGhgP3xHelXphWEuYdU4xHFIla2E2b2FtsADkBQ2FTgv8WXVWg7/TwAafhbQcbmWKdsWFsohSFWMNfMDnLKXerZb7jSy6suFOSKTDZyPx9SpBqxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG5Igbka; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3c2db014easo284200866b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 04:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759145021; x=1759749821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh3ywIwary6Vj2AudMRSeRIaft+tH6rG7ygMgMyuo7I=;
        b=KG5IgbkaM30D9gRnne6itusJWXLC78DeGcdEaPpcWamN0s3x1kctcpMfv+JdTNqVIE
         gmMOBMMtiEGzFPtraX5VoQ3Ej+wA1dZjOK446uQuTECcuGAr2XgU+Gp17cy91iX51H7I
         7t4Fygpco0TcxdofyJ7mnHUM9h8fj8HWtJOkOSluNSGwdKd4PyL45R2MeoJuiSsRySeX
         wS3KtfWA6EviiufHiSvJJPlSrLkY6PIU8+rY8XeZwWaLEpPdkJmSZUS2wUXH4yMIkNNb
         B/A3OOPxrkigQ5XNBm1+AAPkqOkpcYmhXWZSN3XNlhfeWyk/qm2sAA9KCUrbB9YqLJ/n
         HVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145021; x=1759749821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nh3ywIwary6Vj2AudMRSeRIaft+tH6rG7ygMgMyuo7I=;
        b=PDtPSn91i/ZK+xXrNHOSTTC0IHAftQ/hVpuqXUU5ARpvhJ6xI6wRCjdTUkK5fvgZLk
         PSWIcMlYyaarKhZyi2Y6YopqQeP7YS77vUsShyZYUGxL5hY3RrbkIz56HKCbNT074/ip
         NTcj5RPER5XfWYO5WPHTW4hoFpW9RKen/rrCsCP90KaQjZa5Vs/uuveCgQrsMP0ge8Ae
         IxljbHXtnwcjiCaOiVPdhjZDEzfaRzDX/zeO71s8VY3auiV+39GA8KTRMefwTJUV164w
         R8lY6aqb7Ojhra5nu2U6aMNLQBq5Rd4Hel3fTC6ksZE+cCEFVEQIjL1Wp1LRIPjpqAq/
         03iA==
X-Forwarded-Encrypted: i=1; AJvYcCVyWv6Yc3T53XocGiMRx5h4nTOpAWQAu8TjGcHCvj4G+xzKfMjNNXa5DWHktoMONrPOCuP+S+nqD/rJtZyh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaown2dxyxjC4f9zT+7tvbcY+lwS4zHSIXjRaamNfk/KF1sOdu
	Rnprx2ktUN7lsvDAtb1VPgdOHcoQ2qhmNwiBQhiHZwBttuVAjZFRyaPO+RaOkTqIA3/4iSPKSWn
	2wdJ1i3quVNw8yz5bGf2z/Tu7Y65TeII=
X-Gm-Gg: ASbGncvStIfhkLogJDhWOTkrL5j8/f8aGfv+MdStVw0lBr1HdsAwrF/L3J5OJ4aNjcz
	dKp5+INCNW+pL9cqnLcxhWeyKDkWHeFiRFALkO7sBFhn1NwNkASmgM1sk75QTBHX3LjmGhcJknY
	ZXMDB/rj1mLUiYXcldut7ZDPMsZm+n3RNLRFOZ8LrenxUqZ+V2XNWk8wJqzHmFF863XhreUoHRG
	68QmqAdv5Y7gk/eYDycSRCHfPaNe1TSsD8f9Q3KLEFJcyi6U00V
X-Google-Smtp-Source: AGHT+IHI8OegT6dfJEfY+215vl7nSyCJvxOFncVxZ3aL7chwK1AiGcZKM3j4qIvLHh66LjecszKKJHXRubwgCngkzpk=
X-Received: by 2002:a17:907:7f0f:b0:aff:16eb:8b09 with SMTP id
 a640c23a62f3a-b34b6449b22mr1536380866b.5.1759145020650; Mon, 29 Sep 2025
 04:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-9-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-9-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Sep 2025 13:23:28 +0200
X-Gm-Features: AS18NWAcqcWEep_RlcBjVwo6saLQA5rbnr1crT1W8hk9tgayk0tmHH8JbhogxLg
Message-ID: <CAOQ4uxh+NcAv9v6NtVRrLCMYbpd0ajtvsd6c9-W2a7+vur0UJQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
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
> ---
>  fs/namei.c               | 197 ++++++++++++++++++++++++++++-----------
>  fs/nfsd/vfs.c            |  73 +++++----------
>  fs/overlayfs/dir.c       |  72 ++++++--------
>  fs/overlayfs/overlayfs.h |  14 +++
>  include/linux/namei.h    |   3 +
>  5 files changed, 214 insertions(+), 145 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index f5c96f801b74..79a8b3b47e4d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3684,6 +3684,129 @@ void unlock_rename(struct dentry *p1, struct dent=
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

Any reason for this odd spelling of dentries?

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
err =3D IS_ERR(d1);
> +       if (IS_ERR(d1))
> +               goto out_unlock_1;
> +
> +       d2 =3D lookup_one_qstr_excl(new_last, rd->new_parent,
> +                                 lookup_flags | target_flags);
err =3D IS_ERR(d2);
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

I'd rather avoid meaningless label names.

> +out_unlock_3:
out_dput_d2:
> +       dput(d2);
> +       d2 =3D ERR_PTR(err);

This is not pretty IMO, much cleaner to assign err before goto

> +out_unlock_2:
out_dput_d1:
> +       dput(d1);
> +       d1 =3D d2;

This is not pretty IMO, much cleaner to assign err before goto

> +out_unlock_1:
out_unlock:
> +       unlock_rename(rd->old_parent, rd->new_parent);
> +       return PTR_ERR(d1);

return err;
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
> @@ -5509,14 +5632,11 @@ int do_renameat2(int olddfd, struct filename *fro=
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
> @@ -5527,11 +5647,6 @@ int do_renameat2(int olddfd, struct filename *from=
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
> @@ -5561,66 +5676,40 @@ int do_renameat2(int olddfd, struct filename *fro=
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
> index d5b4550fd8f6..091112d931f9 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1862,11 +1862,12 @@ __be32
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
> @@ -1892,15 +1893,22 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
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
> @@ -1910,48 +1918,23 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
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
> @@ -1960,11 +1943,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh =
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
> @@ -1983,7 +1961,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>                 fh_fill_post_attrs(tfhp);
>         }
>  out_unlock:
> -       unlock_rename(tdentry, fdentry);
> +       end_renaming(&rd);
>  out_want_write:
>         fh_drop_write(ffhp);
>
> @@ -1994,9 +1972,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
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
> index 74b1ef5860a4..b37aefe465a2 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1099,9 +1099,7 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
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
> @@ -1208,29 +1206,21 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
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
> @@ -1238,15 +1228,15 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
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
> @@ -1254,19 +1244,14 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
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
> @@ -1274,19 +1259,22 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
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

I would restructure this for better clarity:

        if (!err && cleanup_whiteout)
                whiteout =3D dget(rd.new_dentry);
        end_renaming(&rd);

        if (err)
                goto out_revert_creds;

        if (whiteout) {
                ovl_cleanup(ofs, old_upperdir, whiteout);
                dput(whiteout);
        }

>         if (err)
>                 goto out_revert_creds;
>
> -       if (cleanup_whiteout)
> -               ovl_cleanup(ofs, old_upperdir, newdentry);
> -
>         if (overwrite && d_inode(new)) {
>                 if (new_is_dir)
>                         clear_nlink(d_inode(new));
> @@ -1311,14 +1299,12 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
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
> index 915af58459b7..181fc46195f2 100644
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

This was factored out of ovl_do_rename().
Please avoid duplication and call this from ovl_do_rename().
Even if you are going to remove ovl_do_rename() which has no callers
at the end of your series still, please avoid copying this code mid series.

Thanks,
Amir.

