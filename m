Return-Path: <linux-fsdevel+bounces-64616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73800BEE314
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 12:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBF8189DB85
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAB82E336F;
	Sun, 19 Oct 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fggXQ0gT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF223EA84
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760870001; cv=none; b=XE4S77BF/5oAw6iuzp0B8E0umpXluAoG0DhGw/mJdBjoJVDwavvUJBiNwKv8N4v+FUHOq1s/MdV8TMoLO1ravIxp1xRcL18l1Rv+1jDn6/J2B8Y20dq5CECSbjPxUvrLkKZgkwg07P/ZBIe0KtbMIxoSu2yED42N0rATbPb3N40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760870001; c=relaxed/simple;
	bh=8G87OwKADVXc9WAAhyJGsJpR3vb7Rmty4FyZD/yEluk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlpGIjrHklnPQEEctE7iTMpgXwxSceZN1DqeQ/8l/ueeAj3V37RDSTdj0gxYXKoUpkxq6mrmvlwE3n7B+00FaHvGHl3EHkggblgk1UoPTd/gNz4MOPfbjw8BPVvcAOLSefLaEFXVXluTPGJs6QkwJDw2KCdiihm59fNzLu8LLEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fggXQ0gT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b5e19810703so546158566b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760869997; x=1761474797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyRq1mworW32mobglj66en0eLFOmWqQB6/yt4ThQj3Q=;
        b=fggXQ0gTmY/4ix3aA+IgqkHnnGjE7rZs1jd/bAZpLcYMpS5SleWE+V1niW9K5uXrMH
         HjWma3ysonnKKlBxK/T81CKa8c1/L3pufE4Dfq3fLA00IhN4IV7dw/wIbQhL8aXQ8Cto
         ElHutb+pKpILHmJgRkHlWSctQwh3YhXsw1lV1BPTbBSCKKk9KnRdP5rVxc9CqYcybzsH
         nULLvyFIrj/yylZj/LuVIS/gpXjNRbTADuuDHxn3Ev8a49VU40X/YYZOIgkQq5L0tYTN
         A+u7H2is4IFhdMbjyPbLjYfJqHuYvfD9OSrfC6bj7AmRTeAU25wZpCGR0U45C7/J19uS
         jZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760869997; x=1761474797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyRq1mworW32mobglj66en0eLFOmWqQB6/yt4ThQj3Q=;
        b=VMlgVpck8ebX+JBCkBOoEkc/QX+fdVa+IdwYXnbRuZPrrYXOd3t3iRFa5Dekk3S3i+
         2nYtrEQosC+1krOogyX1i0l9etUvfT3NNTk9CdCO+EmQpJSnw5APoCsrkKzsC77aa7Jf
         mYe6Z8uT/Yp2xN016d/gXHzi5OfpXSxOe7WFiRGGQ8QgKETrtZiJc7i1hmtXrIZEPs/C
         FYs8hSme25mtZCABgWp8MqflD8l+gflziXCzNDOFI5wsDaCQGpXMN+SYrhsA841ZbIXY
         0rEuPQXY+qnyei1dIZ71gmlel1N1g/+V2TgTt7EW6HLoN3ZUnLf1Rf3Zo+XcCnMGRcb0
         etvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUekal0eurq2uuenrSsKG8RI6Zo9gXXI9DaTR4Xm/6cy+nwrrFWghGA2vJu4RXtiBZkiQVFWwOLn/qkx76t@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFVi8m8jKr3NSo5FXxI1m9inp5n2PGqXBZCp2DvwjOgd2KDMI
	2C3eLulFvMp0JPea7TuEBwwcm1t15eY6j6Z2LkaKOlCFm+AkYmvtkiQQEF5ZNwSYHynxVlN7SCp
	Zrp5rUmFAC9wHBhwhzFCxN79QDN/ZGhM=
X-Gm-Gg: ASbGncvuGI4P81dgwDhIZsUtITB88JoHBPMrZwnuMBdLEK6nVai6E9sM0eg+am+/ERe
	WMZhr3xeCVTvowKX11eGB7hhiCKRWQgISurUr6nfoRNXlT2WITI0FqbC5YD/I2EqWdq8z6h2tFx
	jd3a0cE0bsOH8T6OZMWRiwfyjpZFMVgZJvSbz/99V3Pd0pq0uJCKsKJBt6fTZa8kTbs6ywCSc59
	x/23NSdOd2rMAcMVIcFhfQjG0swFkkvoZGGdjTTTF0UFIFliGT+t2DDAWHV0PH4NsB9oQXEo565
	oAYcOCkJn+buPjNiZcNptjOqd1pd/A==
X-Google-Smtp-Source: AGHT+IHO2sckHff90phmmoPDpszKa2LNYb3rHzneXbU3uC3jtkR5VGsihhiZJPycIc14cqLTyFDwSMw9jai9xa9oJUU=
X-Received: by 2002:a17:907:7f8a:b0:b53:e871:f0fd with SMTP id
 a640c23a62f3a-b6474941574mr1147350266b.52.1760869996599; Sun, 19 Oct 2025
 03:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014756.2073439-1-neilb@ownmail.net> <20251015014756.2073439-10-neilb@ownmail.net>
 <CAOQ4uxg27fWDEqQYJ9yw25PTZ37qjNUJu36SfQNwdCComP0UOA@mail.gmail.com>
In-Reply-To: <CAOQ4uxg27fWDEqQYJ9yw25PTZ37qjNUJu36SfQNwdCComP0UOA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Oct 2025 12:33:05 +0200
X-Gm-Features: AS18NWAvdSiQc-KU3VaiM8o8ETCrg13BK759llU9dn43Xz09bh_hU4_N5cgdsss
Message-ID: <CAOQ4uxjVTpK1OYU9vHROmeXwcs5B+nc67=G7s1YBvp+PW9vU9A@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 12:25=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Wed, Oct 15, 2025 at 3:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wro=
te:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > start_renaming() combines name lookup and locking to prepare for rename=
.
> > It is used when two names need to be looked up as in nfsd and overlayfs=
 -
> > cases where one or both dentrys are already available will be handled
> > separately.
> >
> > __start_renaming() avoids the inode_permission check and hash
> > calculation and is suitable after filename_parentat() in do_renameat2()=
.
> > It subsumes quite a bit of code from that function.
> >
> > start_renaming() does calculate the hash and check X permission and is
> > suitable elsewhere:
> > - nfsd_rename()
> > - ovl_rename()
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
>
> Review comments from v1 not addressed:
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxh+NcAv9v6NtVRrLCMYbpd0ajtvsd=
6c9-W2a7+vur0UJQ@mail.gmail.com/
>

Obviously, I am more attached to my comments on the overlayfs
changes. since you have not replied to those, you might have missed them...

Thanks,
Amir.

> > ---
> >  fs/namei.c               | 197 ++++++++++++++++++++++++++++-----------
> >  fs/nfsd/vfs.c            |  73 +++++----------
> >  fs/overlayfs/dir.c       |  72 ++++++--------
> >  fs/overlayfs/overlayfs.h |  14 +++
> >  include/linux/namei.h    |   3 +
> >  5 files changed, 214 insertions(+), 145 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 04d2819bd351..a2553df8f34e 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3667,6 +3667,129 @@ void unlock_rename(struct dentry *p1, struct de=
ntry *p2)
> >  }
> >  EXPORT_SYMBOL(unlock_rename);
> >
> > +/**
> > + * __start_renaming - lookup and lock names for rename
> > + * @rd:           rename data containing parent and flags, and
> > + *                for receiving found dentries
> > + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> > + *                LOOKUP_NO_SYMLINKS etc).
> > + * @old_last:     name of object in @rd.old_parent
> > + * @new_last:     name of object in @rd.new_parent
> > + *
> > + * Look up two names and ensure locks are in place for
> > + * rename.
> > + *
> > + * On success the found dentrys are stored in @rd.old_dentry,
> > + * @rd.new_dentry.  These references and the lock are dropped by
> > + * end_renaming().
> > + *
> > + * The passed in qstrs must have the hash calculated, and no permissio=
n
> > + * checking is performed.
> > + *
> > + * Returns: zero or an error.
> > + */
> > +static int
> > +__start_renaming(struct renamedata *rd, int lookup_flags,
> > +                struct qstr *old_last, struct qstr *new_last)
> > +{
> > +       struct dentry *trap;
> > +       struct dentry *d1, *d2;
> > +       int target_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> > +       int err;
> > +
> > +       if (rd->flags & RENAME_EXCHANGE)
> > +               target_flags =3D 0;
> > +       if (rd->flags & RENAME_NOREPLACE)
> > +               target_flags |=3D LOOKUP_EXCL;
> > +
> > +       trap =3D lock_rename(rd->old_parent, rd->new_parent);
> > +       if (IS_ERR(trap))
> > +               return PTR_ERR(trap);
> > +
> > +       d1 =3D lookup_one_qstr_excl(old_last, rd->old_parent,
> > +                                 lookup_flags);
> > +       if (IS_ERR(d1))
> > +               goto out_unlock_1;
> > +
> > +       d2 =3D lookup_one_qstr_excl(new_last, rd->new_parent,
> > +                                 lookup_flags | target_flags);
> > +       if (IS_ERR(d2))
> > +               goto out_unlock_2;
> > +
> > +       if (d1 =3D=3D trap) {
> > +               /* source is an ancestor of target */
> > +               err =3D -EINVAL;
> > +               goto out_unlock_3;
> > +       }
> > +
> > +       if (d2 =3D=3D trap) {
> > +               /* target is an ancestor of source */
> > +               if (rd->flags & RENAME_EXCHANGE)
> > +                       err =3D -EINVAL;
> > +               else
> > +                       err =3D -ENOTEMPTY;
> > +               goto out_unlock_3;
> > +       }
> > +
> > +       rd->old_dentry =3D d1;
> > +       rd->new_dentry =3D d2;
> > +       return 0;
> > +
> > +out_unlock_3:
> > +       dput(d2);
> > +       d2 =3D ERR_PTR(err);
> > +out_unlock_2:
> > +       dput(d1);
> > +       d1 =3D d2;
> > +out_unlock_1:
> > +       unlock_rename(rd->old_parent, rd->new_parent);
> > +       return PTR_ERR(d1);
> > +}
> > +
> > +/**
> > + * start_renaming - lookup and lock names for rename with permission c=
hecking
> > + * @rd:           rename data containing parent and flags, and
> > + *                for receiving found dentries
> > + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> > + *                LOOKUP_NO_SYMLINKS etc).
> > + * @old_last:     name of object in @rd.old_parent
> > + * @new_last:     name of object in @rd.new_parent
> > + *
> > + * Look up two names and ensure locks are in place for
> > + * rename.
> > + *
> > + * On success the found dentrys are stored in @rd.old_dentry,
> > + * @rd.new_dentry.  These references and the lock are dropped by
> > + * end_renaming().
> > + *
> > + * The passed in qstrs need not have the hash calculated, and basic
> > + * eXecute permission checking is performed against @rd.mnt_idmap.
> > + *
> > + * Returns: zero or an error.
> > + */
> > +int start_renaming(struct renamedata *rd, int lookup_flags,
> > +                  struct qstr *old_last, struct qstr *new_last)
> > +{
> > +       int err;
> > +
> > +       err =3D lookup_one_common(rd->mnt_idmap, old_last, rd->old_pare=
nt);
> > +       if (err)
> > +               return err;
> > +       err =3D lookup_one_common(rd->mnt_idmap, new_last, rd->new_pare=
nt);
> > +       if (err)
> > +               return err;
> > +       return __start_renaming(rd, lookup_flags, old_last, new_last);
> > +}
> > +EXPORT_SYMBOL(start_renaming);
> > +
> > +void end_renaming(struct renamedata *rd)
> > +{
> > +       unlock_rename(rd->old_parent, rd->new_parent);
> > +       dput(rd->old_dentry);
> > +       dput(rd->new_dentry);
> > +}
> > +EXPORT_SYMBOL(end_renaming);
> > +
> >  /**
> >   * vfs_prepare_mode - prepare the mode to be used for a new inode
> >   * @idmap:     idmap of the mount the inode was found from
> > @@ -5504,14 +5627,11 @@ int do_renameat2(int olddfd, struct filename *f=
rom, int newdfd,
> >                  struct filename *to, unsigned int flags)
> >  {
> >         struct renamedata rd;
> > -       struct dentry *old_dentry, *new_dentry;
> > -       struct dentry *trap;
> >         struct path old_path, new_path;
> >         struct qstr old_last, new_last;
> >         int old_type, new_type;
> >         struct inode *delegated_inode =3D NULL;
> > -       unsigned int lookup_flags =3D 0, target_flags =3D
> > -               LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> > +       unsigned int lookup_flags =3D 0;
> >         bool should_retry =3D false;
> >         int error =3D -EINVAL;
> >
> > @@ -5522,11 +5642,6 @@ int do_renameat2(int olddfd, struct filename *fr=
om, int newdfd,
> >             (flags & RENAME_EXCHANGE))
> >                 goto put_names;
> >
> > -       if (flags & RENAME_EXCHANGE)
> > -               target_flags =3D 0;
> > -       if (flags & RENAME_NOREPLACE)
> > -               target_flags |=3D LOOKUP_EXCL;
> > -
> >  retry:
> >         error =3D filename_parentat(olddfd, from, lookup_flags, &old_pa=
th,
> >                                   &old_last, &old_type);
> > @@ -5556,66 +5671,40 @@ int do_renameat2(int olddfd, struct filename *f=
rom, int newdfd,
> >                 goto exit2;
> >
> >  retry_deleg:
> > -       trap =3D lock_rename(new_path.dentry, old_path.dentry);
> > -       if (IS_ERR(trap)) {
> > -               error =3D PTR_ERR(trap);
> > +       rd.old_parent      =3D old_path.dentry;
> > +       rd.mnt_idmap       =3D mnt_idmap(old_path.mnt);
> > +       rd.new_parent      =3D new_path.dentry;
> > +       rd.delegated_inode =3D &delegated_inode;
> > +       rd.flags           =3D flags;
> > +
> > +       error =3D __start_renaming(&rd, lookup_flags, &old_last, &new_l=
ast);
> > +       if (error)
> >                 goto exit_lock_rename;
> > -       }
> >
> > -       old_dentry =3D lookup_one_qstr_excl(&old_last, old_path.dentry,
> > -                                         lookup_flags);
> > -       error =3D PTR_ERR(old_dentry);
> > -       if (IS_ERR(old_dentry))
> > -               goto exit3;
> > -       new_dentry =3D lookup_one_qstr_excl(&new_last, new_path.dentry,
> > -                                         lookup_flags | target_flags);
> > -       error =3D PTR_ERR(new_dentry);
> > -       if (IS_ERR(new_dentry))
> > -               goto exit4;
> >         if (flags & RENAME_EXCHANGE) {
> > -               if (!d_is_dir(new_dentry)) {
> > +               if (!d_is_dir(rd.new_dentry)) {
> >                         error =3D -ENOTDIR;
> >                         if (new_last.name[new_last.len])
> > -                               goto exit5;
> > +                               goto exit_unlock;
> >                 }
> >         }
> >         /* unless the source is a directory trailing slashes give -ENOT=
DIR */
> > -       if (!d_is_dir(old_dentry)) {
> > +       if (!d_is_dir(rd.old_dentry)) {
> >                 error =3D -ENOTDIR;
> >                 if (old_last.name[old_last.len])
> > -                       goto exit5;
> > +                       goto exit_unlock;
> >                 if (!(flags & RENAME_EXCHANGE) && new_last.name[new_las=
t.len])
> > -                       goto exit5;
> > -       }
> > -       /* source should not be ancestor of target */
> > -       error =3D -EINVAL;
> > -       if (old_dentry =3D=3D trap)
> > -               goto exit5;
> > -       /* target should not be an ancestor of source */
> > -       if (!(flags & RENAME_EXCHANGE))
> > -               error =3D -ENOTEMPTY;
> > -       if (new_dentry =3D=3D trap)
> > -               goto exit5;
> > +                       goto exit_unlock;
> > +       }
> >
> > -       error =3D security_path_rename(&old_path, old_dentry,
> > -                                    &new_path, new_dentry, flags);
> > +       error =3D security_path_rename(&old_path, rd.old_dentry,
> > +                                    &new_path, rd.new_dentry, flags);
> >         if (error)
> > -               goto exit5;
> > +               goto exit_unlock;
> >
> > -       rd.old_parent      =3D old_path.dentry;
> > -       rd.old_dentry      =3D old_dentry;
> > -       rd.mnt_idmap       =3D mnt_idmap(old_path.mnt);
> > -       rd.new_parent      =3D new_path.dentry;
> > -       rd.new_dentry      =3D new_dentry;
> > -       rd.delegated_inode =3D &delegated_inode;
> > -       rd.flags           =3D flags;
> >         error =3D vfs_rename(&rd);
> > -exit5:
> > -       dput(new_dentry);
> > -exit4:
> > -       dput(old_dentry);
> > -exit3:
> > -       unlock_rename(new_path.dentry, old_path.dentry);
> > +exit_unlock:
> > +       end_renaming(&rd);
> >  exit_lock_rename:
> >         if (delegated_inode) {
> >                 error =3D break_deleg_wait(&delegated_inode);
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index cd64ffe12e0b..62109885d4db 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1885,11 +1885,12 @@ __be32
> >  nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, =
int flen,
> >                             struct svc_fh *tfhp, char *tname, int tlen)
> >  {
> > -       struct dentry   *fdentry, *tdentry, *odentry, *ndentry, *trap;
> > +       struct dentry   *fdentry, *tdentry;
> >         int             type =3D S_IFDIR;
> > +       struct renamedata rd =3D {};
> >         __be32          err;
> >         int             host_err;
> > -       bool            close_cached =3D false;
> > +       struct dentry   *close_cached;
> >
> >         trace_nfsd_vfs_rename(rqstp, ffhp, tfhp, fname, flen, tname, tl=
en);
> >
> > @@ -1915,15 +1916,22 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_=
fh *ffhp, char *fname, int flen,
> >                 goto out;
> >
> >  retry:
> > +       close_cached =3D NULL;
> >         host_err =3D fh_want_write(ffhp);
> >         if (host_err) {
> >                 err =3D nfserrno(host_err);
> >                 goto out;
> >         }
> >
> > -       trap =3D lock_rename(tdentry, fdentry);
> > -       if (IS_ERR(trap)) {
> > -               err =3D nfserr_xdev;
> > +       rd.mnt_idmap    =3D &nop_mnt_idmap;
> > +       rd.old_parent   =3D fdentry;
> > +       rd.new_parent   =3D tdentry;
> > +
> > +       host_err =3D start_renaming(&rd, 0, &QSTR_LEN(fname, flen),
> > +                                 &QSTR_LEN(tname, tlen));
> > +
> > +       if (host_err) {
> > +               err =3D nfserrno(host_err);
> >                 goto out_want_write;
> >         }
> >         err =3D fh_fill_pre_attrs(ffhp);
> > @@ -1933,48 +1941,23 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_=
fh *ffhp, char *fname, int flen,
> >         if (err !=3D nfs_ok)
> >                 goto out_unlock;
> >
> > -       odentry =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), =
fdentry);
> > -       host_err =3D PTR_ERR(odentry);
> > -       if (IS_ERR(odentry))
> > -               goto out_nfserr;
> > +       type =3D d_inode(rd.old_dentry)->i_mode & S_IFMT;
> > +
> > +       if (d_inode(rd.new_dentry))
> > +               type =3D d_inode(rd.new_dentry)->i_mode & S_IFMT;
> >
> > -       host_err =3D -ENOENT;
> > -       if (d_really_is_negative(odentry))
> > -               goto out_dput_old;
> > -       host_err =3D -EINVAL;
> > -       if (odentry =3D=3D trap)
> > -               goto out_dput_old;
> > -       type =3D d_inode(odentry)->i_mode & S_IFMT;
> > -
> > -       ndentry =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(tname, tlen), =
tdentry);
> > -       host_err =3D PTR_ERR(ndentry);
> > -       if (IS_ERR(ndentry))
> > -               goto out_dput_old;
> > -       if (d_inode(ndentry))
> > -               type =3D d_inode(ndentry)->i_mode & S_IFMT;
> > -       host_err =3D -ENOTEMPTY;
> > -       if (ndentry =3D=3D trap)
> > -               goto out_dput_new;
> > -
> > -       if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE=
_UNLINK) &&
> > -           nfsd_has_cached_files(ndentry)) {
> > -               close_cached =3D true;
> > -               goto out_dput_old;
> > +       if ((rd.new_dentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_=
BEFORE_UNLINK) &&
> > +           nfsd_has_cached_files(rd.new_dentry)) {
> > +               close_cached =3D dget(rd.new_dentry);
> > +               goto out_unlock;
> >         } else {
> > -               struct renamedata rd =3D {
> > -                       .mnt_idmap      =3D &nop_mnt_idmap,
> > -                       .old_parent     =3D fdentry,
> > -                       .old_dentry     =3D odentry,
> > -                       .new_parent     =3D tdentry,
> > -                       .new_dentry     =3D ndentry,
> > -               };
> >                 int retries;
> >
> >                 for (retries =3D 1;;) {
> >                         host_err =3D vfs_rename(&rd);
> >                         if (host_err !=3D -EAGAIN || !retries--)
> >                                 break;
> > -                       if (!nfsd_wait_for_delegreturn(rqstp, d_inode(o=
dentry)))
> > +                       if (!nfsd_wait_for_delegreturn(rqstp, d_inode(r=
d.old_dentry)))
> >                                 break;
> >                 }
> >                 if (!host_err) {
> > @@ -1983,11 +1966,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_f=
h *ffhp, char *fname, int flen,
> >                                 host_err =3D commit_metadata(ffhp);
> >                 }
> >         }
> > - out_dput_new:
> > -       dput(ndentry);
> > - out_dput_old:
> > -       dput(odentry);
> > - out_nfserr:
> >         if (host_err =3D=3D -EBUSY) {
> >                 /*
> >                  * See RFC 8881 Section 18.26.4 para 1-3: NFSv4 RENAME
> > @@ -2006,7 +1984,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
> >                 fh_fill_post_attrs(tfhp);
> >         }
> >  out_unlock:
> > -       unlock_rename(tdentry, fdentry);
> > +       end_renaming(&rd);
> >  out_want_write:
> >         fh_drop_write(ffhp);
> >
> > @@ -2017,9 +1995,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
> >          * until this point and then reattempt the whole shebang.
> >          */
> >         if (close_cached) {
> > -               close_cached =3D false;
> > -               nfsd_close_cached_files(ndentry);
> > -               dput(ndentry);
> > +               nfsd_close_cached_files(close_cached);
> > +               dput(close_cached);
> >                 goto retry;
> >         }
> >  out:
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index c8d0885ee5e0..ded86855e91c 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -1124,9 +1124,7 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
> >         int err;
> >         struct dentry *old_upperdir;
> >         struct dentry *new_upperdir;
> > -       struct dentry *olddentry =3D NULL;
> > -       struct dentry *newdentry =3D NULL;
> > -       struct dentry *trap, *de;
> > +       struct renamedata rd =3D {};
> >         bool old_opaque;
> >         bool new_opaque;
> >         bool cleanup_whiteout =3D false;
> > @@ -1233,29 +1231,21 @@ static int ovl_rename(struct mnt_idmap *idmap, =
struct inode *olddir,
> >                 }
> >         }
> >
> > -       trap =3D lock_rename(new_upperdir, old_upperdir);
> > -       if (IS_ERR(trap)) {
> > -               err =3D PTR_ERR(trap);
> > -               goto out_revert_creds;
> > -       }
> > +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> > +       rd.old_parent =3D old_upperdir;
> > +       rd.new_parent =3D new_upperdir;
> > +       rd.flags =3D flags;
> >
> > -       de =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
> > -                             old->d_name.len);
> > -       err =3D PTR_ERR(de);
> > -       if (IS_ERR(de))
> > -               goto out_unlock;
> > -       olddentry =3D de;
> > +       err =3D start_renaming(&rd, 0,
> > +                            &QSTR_LEN(old->d_name.name, old->d_name.le=
n),
> > +                            &QSTR_LEN(new->d_name.name, new->d_name.le=
n));
> >
> > -       err =3D -ESTALE;
> > -       if (!ovl_matches_upper(old, olddentry))
> > -               goto out_unlock;
> > +       if (err)
> > +               goto out_revert_creds;
> >
> > -       de =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
> > -                             new->d_name.len);
> > -       err =3D PTR_ERR(de);
> > -       if (IS_ERR(de))
> > +       err =3D -ESTALE;
> > +       if (!ovl_matches_upper(old, rd.old_dentry))
> >                 goto out_unlock;
> > -       newdentry =3D de;
> >
> >         old_opaque =3D ovl_dentry_is_opaque(old);
> >         new_opaque =3D ovl_dentry_is_opaque(new);
> > @@ -1263,15 +1253,15 @@ static int ovl_rename(struct mnt_idmap *idmap, =
struct inode *olddir,
> >         err =3D -ESTALE;
> >         if (d_inode(new) && ovl_dentry_upper(new)) {
> >                 if (opaquedir) {
> > -                       if (newdentry !=3D opaquedir)
> > +                       if (rd.new_dentry !=3D opaquedir)
> >                                 goto out_unlock;
> >                 } else {
> > -                       if (!ovl_matches_upper(new, newdentry))
> > +                       if (!ovl_matches_upper(new, rd.new_dentry))
> >                                 goto out_unlock;
> >                 }
> >         } else {
> > -               if (!d_is_negative(newdentry)) {
> > -                       if (!new_opaque || !ovl_upper_is_whiteout(ofs, =
newdentry))
> > +               if (!d_is_negative(rd.new_dentry)) {
> > +                       if (!new_opaque || !ovl_upper_is_whiteout(ofs, =
rd.new_dentry))
> >                                 goto out_unlock;
> >                 } else {
> >                         if (flags & RENAME_EXCHANGE)
> > @@ -1279,19 +1269,14 @@ static int ovl_rename(struct mnt_idmap *idmap, =
struct inode *olddir,
> >                 }
> >         }
> >
> > -       if (olddentry =3D=3D trap)
> > -               goto out_unlock;
> > -       if (newdentry =3D=3D trap)
> > -               goto out_unlock;
> > -
> > -       if (olddentry->d_inode =3D=3D newdentry->d_inode)
> > +       if (rd.old_dentry->d_inode =3D=3D rd.new_dentry->d_inode)
> >                 goto out_unlock;
> >
> >         err =3D 0;
> >         if (ovl_type_merge_or_lower(old))
> >                 err =3D ovl_set_redirect(old, samedir);
> >         else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent)=
)
> > -               err =3D ovl_set_opaque_xerr(old, olddentry, -EXDEV);
> > +               err =3D ovl_set_opaque_xerr(old, rd.old_dentry, -EXDEV)=
;
> >         if (err)
> >                 goto out_unlock;
> >
> > @@ -1299,19 +1284,22 @@ static int ovl_rename(struct mnt_idmap *idmap, =
struct inode *olddir,
> >                 err =3D ovl_set_redirect(new, samedir);
> >         else if (!overwrite && new_is_dir && !new_opaque &&
> >                  ovl_type_merge(old->d_parent))
> > -               err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
> > +               err =3D ovl_set_opaque_xerr(new, rd.new_dentry, -EXDEV)=
;
> >         if (err)
> >                 goto out_unlock;
> >
> > -       err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
> > -                           new_upperdir, newdentry, flags);
> > -       unlock_rename(new_upperdir, old_upperdir);
> > +       err =3D ovl_do_rename_rd(&rd);
> > +
> > +       dget(rd.new_dentry);
> > +       end_renaming(&rd);
> > +
> > +       if (!err && cleanup_whiteout) {
> > +               ovl_cleanup(ofs, old_upperdir, rd.new_dentry);
> > +       }
> > +       dput(rd.new_dentry);
> >         if (err)
> >                 goto out_revert_creds;
> >
> > -       if (cleanup_whiteout)
> > -               ovl_cleanup(ofs, old_upperdir, newdentry);
> > -
> >         if (overwrite && d_inode(new)) {
> >                 if (new_is_dir)
> >                         clear_nlink(d_inode(new));
> > @@ -1336,14 +1324,12 @@ static int ovl_rename(struct mnt_idmap *idmap, =
struct inode *olddir,
> >         else
> >                 ovl_drop_write(old);
> >  out:
> > -       dput(newdentry);
> > -       dput(olddentry);
> >         dput(opaquedir);
> >         ovl_cache_free(&list);
> >         return err;
> >
> >  out_unlock:
> > -       unlock_rename(new_upperdir, old_upperdir);
> > +       end_renaming(&rd);
> >         goto out_revert_creds;
> >  }
> >
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 49ad65f829dc..aecb527e0524 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -378,6 +378,20 @@ static inline int ovl_do_rename(struct ovl_fs *ofs=
, struct dentry *olddir,
> >         return err;
> >  }
> >
> > +static inline int ovl_do_rename_rd(struct renamedata *rd)
> > +{
> > +       int err;
> > +
> > +       pr_debug("rename(%pd2, %pd2, 0x%x)\n", rd->old_dentry, rd->new_=
dentry,
> > +                rd->flags);
> > +       err =3D vfs_rename(rd);
> > +       if (err) {
> > +               pr_debug("...rename(%pd2, %pd2, ...) =3D %i\n",
> > +                        rd->old_dentry, rd->new_dentry, err);
> > +       }
> > +       return err;
> > +}
> > +
> >  static inline int ovl_do_whiteout(struct ovl_fs *ofs,
> >                                   struct inode *dir, struct dentry *den=
try)
> >  {
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index e5cff89679df..19c3d8e336d5 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -156,6 +156,9 @@ extern int follow_up(struct path *);
> >  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
> >  extern struct dentry *lock_rename_child(struct dentry *, struct dentry=
 *);
> >  extern void unlock_rename(struct dentry *, struct dentry *);
> > +int start_renaming(struct renamedata *rd, int lookup_flags,
> > +                  struct qstr *old_last, struct qstr *new_last);
> > +void end_renaming(struct renamedata *rd);
> >
> >  /**
> >   * mode_strip_umask - handle vfs umask stripping
> > --
> > 2.50.0.107.gf914562f5916.dirty
> >

