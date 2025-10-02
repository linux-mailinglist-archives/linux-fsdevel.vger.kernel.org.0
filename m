Return-Path: <linux-fsdevel+bounces-63274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65637BB3B52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 12:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170E37B01C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD530DECB;
	Thu,  2 Oct 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQOvi+PJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C10149C7B
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759402622; cv=none; b=ik83TOuv+ue5RcPPHmzIXIqua80vs+bfoEGQDgxy7/XBwFXasDghSlVO8rfvUCdo4YMSlACiPYfsYVoXiYBDFdqJscrwBw4164GPdncvyRyKnnKlfBFyEGyHvJCTJYgVFtpS0/xmkjOKF31pP3RWjLNZlXBAxaUad3M6Xfmneow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759402622; c=relaxed/simple;
	bh=bFAfoQYZfZG/OFu35ffLfpWEFGLWZmZSSerCIEO0Kys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5rdNlLNAZyP8Kl5i5GDZakPWXwB1D6NR5IQ84ZCLObqvK54HTR+iOReLEAQ1tO8/T9oss4ga7Ca6xR4k/h+XBHTgc7dl8Dh4oA2nImiuZZjHHaFvybvHdzlIW8Var92tFpovcVEbLAnNgoUsLhn1A3oQBpCKJHT0MTyAYjz/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQOvi+PJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso1563050a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759402618; x=1760007418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac1ZPcaP9FXTMNFAgAibRINlvG69HM6RcKaIVqmJ3xQ=;
        b=ZQOvi+PJDqP8TvhpHyx5f84kP3ET90zczP18lMmdI7HSLnkuX7NcvuWYBritl9jIQg
         pJh2xdt9zQmJrhnrsMbabXaF9XeZaxlC673LGz8ci2XHCE7JRRi9aszOyT3z20aCccdN
         gve7LBgkiCd6zeti4eBuc8fwx6KvKUb8GBIqMfpt0B56H75Fkd47YMmyvxbrzJpQTeCG
         Q35ne1Rd07PnEk31gB+oAsu/4nstZPhqvk+gXVPUo1jBEG4IiFLOEXtA7r1zfTPmOzB1
         zVSe1UyVhI7W/LsxPCTuAslCy+19YWUE/6HifhKhU+YQpt0V2xXgVgf2Vwr9296Qq8Zq
         49Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759402618; x=1760007418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac1ZPcaP9FXTMNFAgAibRINlvG69HM6RcKaIVqmJ3xQ=;
        b=WZKz3typnjZa7VQyJ55+ktAeG2sXblTd+FOfhqOVvM8lyZmaT8WyLjfd7vMOD1znQD
         fZokXnfChMdQ4Al+ZYS7vbQQVI7fLLdfzrVoIgiSAE9ZmNdjHdH8oNP6Zcwn4L0p/thu
         CKdLAxKQciLz4o0SgcilIwqLUtnOki+nrla3AsZ1gWDpPahqlFoa0G9ksdQrYq+n99U0
         qfLP/99wYcNRSgIjxcSWUzgl4G5wkVFjtsUbJq6PgnA8BOkshUyrPqxpujQqM8hKInbN
         2Q/ya+Q7WVIhimBGHOr7WL+D1HxHgaWnKOBeQF0P3iQ4vazOGMk/vBPDATzm+0Bi7T9c
         uvXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUodiB8/yeObTyOlf2liSvN4+5S2GLEXhsI0d7W5UdKZ4ZOsdV7P7ln3cwY/nT59NnLr/Esa/B0/4BfSkzf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5svmnOzrEjkw7trTP08dI0ZPcDTnQ9IGwTjdQX20DzYYwi0Bs
	iMe0EMyLlUK5a3KLOJATPIJSB5WdcUqOhWBNl1xx1KZuH12xuoBFqjC8VnuORGfkw1xE7yJJyip
	JzxD6akDoqI+JVic/yq499U2wh+0QDLE=
X-Gm-Gg: ASbGnct2jxcAM9yM1A/Sd/hiym0TtSPHugkufdzovk6CBrHbvjN7DyCOYHTeKB+wbET
	GwXCr/Ae/q+cC9+3Lw3COM071SdoBi82+XclClD5en6wMfdIpeQo9DF+FoD7ydoW3hutHF3bGA6
	h0nWyQQ1x0pE+G8TGmJ23Vzo7Xwbu7e5Hc2Z/s++mqr5+r4XLAdhVyEdRnFh2s+aWtiRLC9J4jM
	A9BclFIrq5akK+6n+5No3oHLR7k+hzKYKf0sLIuyKNmUhUgZ3609k0mzFeYKQ4y4rDb1OgUZheW
X-Google-Smtp-Source: AGHT+IFA/eaOUTuXNaR9jGf6uIONgKBDywn6e94A4+L8dPFg096MCgZ8cyvRPLG6xFh3z4r2TiBl6QCsC+DbZ/PjGhI=
X-Received: by 2002:a05:6402:3507:b0:633:3bf6:f0ab with SMTP id
 4fb4d7f45d1cf-63678c43276mr7533420a12.7.1759402618135; Thu, 02 Oct 2025
 03:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-10-neilb@ownmail.net>
 <CAOQ4uxiZ=R16EN+Ha_HxgxAhE1r2vKX4Ck+H9_AfyB4a6=9=Zw@mail.gmail.com> <175928311901.1696783.1411913325509395264@noble.neil.brown.name>
In-Reply-To: <175928311901.1696783.1411913325509395264@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 2 Oct 2025 12:56:46 +0200
X-Gm-Features: AS18NWCYldPJ1Q2YZD72w8YN5ZQ1zRDk16q6Kb9SNgpfegVhHYT9kroj90y05lo
Message-ID: <CAOQ4uxh7V487fDG8bfxB6_sbNwczjv3TY7JOWAwkC5dDCzqwaA@mail.gmail.com>
Subject: Re: [PATCH 09/11] VFS/ovl/smb: introduce start_renaming_dentry()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 3:45=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> On Tue, 30 Sep 2025, Amir Goldstein wrote:
> > On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > Several callers perform a rename on a dentry they already have, and o=
nly
> > > require lookup for the target name.  This includes smb/server and a f=
ew
> > > different places in overlayfs.
> > >
> > > start_renaming_dentry() performs the required lookup and takes the
> > > required lock using lock_rename_child()
> > >
> > > It is used in three places in overlayfs and in ksmbd_vfs_rename().
> > >
> > > In the ksmbd case, the parent of the source is not important - the
> > > source must be renamed from wherever it is.  So start_renaming_dentry=
()
> > > allows rd->old_parent to be NULL and only checks it if it is non-NULL=
.
> > > On success rd->old_parent will be the parent of old_dentry with an ex=
tra
> > > reference taken.
> >
> > It is not clear to me why you need to take that extra ref.
> > It looks very unnatural for start_renaming/end_renaming
> > to take ref on old_parent and not on new_parent.
>
> There is an important difference between old_parent and new_parent.
> After the rename, new_parent will still be valid as we will hold a
> reference through whichever child is in that parent.
> However we might not still have a reference that keeps old_parent valid,
> unless we take one ourselves.
>
> >
> > If ksmbd needs old_parent it can use old->d_parent after
> > the start_renaming_dentry() it should be stable. right?
> > So what's the point of taking this extra ref?
>
> It is not that ksmbd might need old_parent, it is that end_renaming()
> needs old_parent so it can be unlocked.  If we don't explicitly take a
> reference, then we cannot be sure that the reference that was found in
> start_renaming_dentry() is still valid after vfs_rename() has moved the
> old_dentry out of it.
>
> >
> > > Other start_renaming function also now take the extra
> > > reference and end_renaming() now drops this reference as well.
> > >
> > > ovl_lookup_temp(), ovl_parent_lock(), and ovl_parent_unlock() are
> > > all removed as they are no longer needed.
> > >
> > > OVL_TEMPNAME_SIZE and ovl_tempname() are now declared in overlayfs.h =
so
> > > that ovl_check_rename_whiteout() can access them.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/namei.c               | 106 ++++++++++++++++++++++++++++++++++++-=
--
> > >  fs/overlayfs/copy_up.c   |  47 ++++++++---------
> > >  fs/overlayfs/dir.c       |  19 +------
> > >  fs/overlayfs/overlayfs.h |   8 +--
> > >  fs/overlayfs/super.c     |  20 ++++----
> > >  fs/overlayfs/util.c      |  11 ----
> > >  fs/smb/server/vfs.c      |  60 ++++------------------
> > >  include/linux/namei.h    |   2 +
> > >  8 files changed, 147 insertions(+), 126 deletions(-)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 79a8b3b47e4d..aca6de83d255 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -3686,7 +3686,7 @@ EXPORT_SYMBOL(unlock_rename);
> > >
> > >  /**
> > >   * __start_renaming - lookup and lock names for rename
> > > - * @rd:           rename data containing parent and flags, and
> > > + * @rd:           rename data containing parents and flags, and
> > >   *                for receiving found dentries
> > >   * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL=
,
> > >   *                LOOKUP_NO_SYMLINKS etc).
> > > @@ -3697,8 +3697,8 @@ EXPORT_SYMBOL(unlock_rename);
> > >   * rename.
> > >   *
> > >   * On success the found dentrys are stored in @rd.old_dentry,
> > > - * @rd.new_dentry.  These references and the lock are dropped by
> > > - * end_renaming().
> > > + * @rd.new_dentry and an extra ref is taken on @rd.old_parent.
> > > + * These references and the lock are dropped by end_renaming().
> > >   *
> > >   * The passed in qstrs must have the hash calculated, and no permiss=
ion
> > >   * checking is performed.
> > > @@ -3750,6 +3750,7 @@ __start_renaming(struct renamedata *rd, int loo=
kup_flags,
> > >
> > >         rd->old_dentry =3D d1;
> > >         rd->new_dentry =3D d2;
> > > +       dget(rd->old_parent);
> > >         return 0;
> > >
> > >  out_unlock_3:
> > > @@ -3765,7 +3766,7 @@ __start_renaming(struct renamedata *rd, int loo=
kup_flags,
> > >
> > >  /**
> > >   * start_renaming - lookup and lock names for rename with permission=
 checking
> > > - * @rd:           rename data containing parent and flags, and
> > > + * @rd:           rename data containing parents and flags, and
> > >   *                for receiving found dentries
> > >   * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL=
,
> > >   *                LOOKUP_NO_SYMLINKS etc).
> > > @@ -3776,8 +3777,8 @@ __start_renaming(struct renamedata *rd, int loo=
kup_flags,
> > >   * rename.
> > >   *
> > >   * On success the found dentrys are stored in @rd.old_dentry,
> > > - * @rd.new_dentry.  These references and the lock are dropped by
> > > - * end_renaming().
> > > + * @rd.new_dentry.  Also the refcount on @rd->old_parent is increase=
d.
> > > + * These references and the lock are dropped by end_renaming().
> > >   *
> > >   * The passed in qstrs need not have the hash calculated, and basic
> > >   * eXecute permission checking is performed against @rd.mnt_idmap.
> > > @@ -3799,11 +3800,104 @@ int start_renaming(struct renamedata *rd, in=
t lookup_flags,
> > >  }
> > >  EXPORT_SYMBOL(start_renaming);
> > >
> > > +static int
> > > +__start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> > > +                       struct dentry *old_dentry, struct qstr *new_l=
ast)
> > > +{
> > > +       struct dentry *trap;
> > > +       struct dentry *d2;
> > > +       int target_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> > > +       int err;
> > > +
> > > +       if (rd->flags & RENAME_EXCHANGE)
> > > +               target_flags =3D 0;
> > > +       if (rd->flags & RENAME_NOREPLACE)
> > > +               target_flags |=3D LOOKUP_EXCL;
> > > +
> > > +       /* Already have the dentry - need to be sure to lock the corr=
ect parent */
> > > +       trap =3D lock_rename_child(old_dentry, rd->new_parent);
> > > +       if (IS_ERR(trap))
> > > +               return PTR_ERR(trap);
> > > +       if (d_unhashed(old_dentry) ||
> > > +           (rd->old_parent && rd->old_parent !=3D old_dentry->d_pare=
nt)) {
> > > +               /* dentry was removed, or moved and explicit parent r=
equested */
> > > +               d2 =3D ERR_PTR(-EINVAL);
> > > +               goto out_unlock_2;
> > > +       }
> > > +
> > > +       d2 =3D lookup_one_qstr_excl(new_last, rd->new_parent,
> > > +                                 lookup_flags | target_flags);
> > > +       if (IS_ERR(d2))
> > > +               goto out_unlock_2;
> > > +
> > > +       if (old_dentry =3D=3D trap) {
> > > +               /* source is an ancestor of target */
> > > +               err =3D -EINVAL;
> > > +               goto out_unlock_3;
> > > +       }
> > > +
> > > +       if (d2 =3D=3D trap) {
> > > +               /* target is an ancestor of source */
> > > +               if (rd->flags & RENAME_EXCHANGE)
> > > +                       err =3D -EINVAL;
> > > +               else
> > > +                       err =3D -ENOTEMPTY;
> > > +               goto out_unlock_3;
> > > +       }
> > > +
> > > +       rd->old_dentry =3D dget(old_dentry);
> > > +       rd->new_dentry =3D d2;
> > > +       rd->old_parent =3D dget(old_dentry->d_parent);
> > > +       return 0;
> > > +
> > > +out_unlock_3:
> > > +       dput(d2);
> > > +       d2 =3D ERR_PTR(err);
> > > +out_unlock_2:
> > > +       unlock_rename(old_dentry->d_parent, rd->new_parent);
> > > +       return PTR_ERR(d2);
> >
> > Please assign err before goto and simplify:
> >
> > out_dput:
> >        dput(d2);
> > out_unlock:
> >        unlock_rename(old_dentry->d_parent, rd->new_parent);
> >        return err;
>
> I'll try that change and see if I like the result.
>
> >
> > > +}
> > > +
> > > +/**
> > > + * start_renaming_dentry - lookup and lock name for rename with perm=
ission checking
> > > + * @rd:           rename data containing parents and flags, and
> > > + *                for receiving found dentries
> > > + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL=
,
> > > + *                LOOKUP_NO_SYMLINKS etc).
> > > + * @old_dentry:   dentry of name to move
> > > + * @new_last:     name of target in @rd.new_parent
> > > + *
> > > + * Look up target name and ensure locks are in place for
> > > + * rename.
> > > + *
> > > + * On success the found dentry is stored in @rd.new_dentry and
> > > + * @rd.old_parent is confirmed to be the parent of @old_dentry.  If =
it
> > > + * was originally %NULL, it is set.  In either case a refernence is =
taken.
> >
> > Typo: %NULL, typo: refernence
> >
> > > + *
> > > + * References and the lock can be dropped with end_renaming()
> > > + *
> > > + * The passed in qstr need not have the hash calculated, and basic
> > > + * eXecute permission checking is performed against @rd.mnt_idmap.
> > > + *
> > > + * Returns: zero or an error.
> > > + */
> > > +int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> > > +                         struct dentry *old_dentry, struct qstr *new=
_last)
> > > +{
> > > +       int err;
> > > +
> > > +       err =3D lookup_one_common(rd->mnt_idmap, new_last, rd->new_pa=
rent);
> > > +       if (err)
> > > +               return err;
> > > +       return __start_renaming_dentry(rd, lookup_flags, old_dentry, =
new_last);
> > > +}
> > > +
> > >  void end_renaming(struct renamedata *rd)
> > >  {
> > >         unlock_rename(rd->old_parent, rd->new_parent);
> > >         dput(rd->old_dentry);
> > >         dput(rd->new_dentry);
> > > +       dput(rd->old_parent);
> > >  }
> > >  EXPORT_SYMBOL(end_renaming);
> > >
> > > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > > index 6a31ea34ff80..3f19548b5d48 100644
> > > --- a/fs/overlayfs/copy_up.c
> > > +++ b/fs/overlayfs/copy_up.c
> > > @@ -523,8 +523,8 @@ static int ovl_create_index(struct dentry *dentry=
, const struct ovl_fh *fh,
> > >  {
> > >         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> > >         struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> > > -       struct dentry *index =3D NULL;
> > >         struct dentry *temp =3D NULL;
> > > +       struct renamedata rd =3D {};
> > >         struct qstr name =3D { };
> > >         int err;
> > >
> > > @@ -556,17 +556,15 @@ static int ovl_create_index(struct dentry *dent=
ry, const struct ovl_fh *fh,
> > >         if (err)
> > >                 goto out;
> > >
> > > -       err =3D ovl_parent_lock(indexdir, temp);
> > > +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> > > +       rd.old_parent =3D indexdir;
> > > +       rd.new_parent =3D indexdir;
> > > +       err =3D start_renaming_dentry(&rd, 0, temp, &name);
> > >         if (err)
> > >                 goto out;
> > > -       index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len=
);
> > > -       if (IS_ERR(index)) {
> > > -               err =3D PTR_ERR(index);
> > > -       } else {
> > > -               err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, =
index, 0);
> > > -               dput(index);
> > > -       }
> > > -       ovl_parent_unlock(indexdir);
> > > +
> > > +       err =3D ovl_do_rename_rd(&rd);
> > > +       end_renaming(&rd);
> > >  out:
> > >         if (err)
> > >                 ovl_cleanup(ofs, indexdir, temp);
> > > @@ -763,7 +761,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up=
_ctx *c)
> > >         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
> > >         struct inode *inode;
> > >         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
> > > -       struct dentry *temp, *upper, *trap;
> > > +       struct renamedata rd =3D {};
> > > +       struct dentry *temp;
> > >         struct ovl_cu_creds cc;
> > >         int err;
> > >         struct ovl_cattr cattr =3D {
> > > @@ -807,29 +806,27 @@ static int ovl_copy_up_workdir(struct ovl_copy_=
up_ctx *c)
> > >          * ovl_copy_up_data(), so lock workdir and destdir and make s=
ure that
> > >          * temp wasn't moved before copy up completion or cleanup.
> > >          */
> > > -       trap =3D lock_rename(c->workdir, c->destdir);
> > > -       if (trap || temp->d_parent !=3D c->workdir) {
> > > +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> > > +       rd.old_parent =3D c->workdir;
> > > +       rd.new_parent =3D c->destdir;
> > > +       rd.flags =3D 0;
> > > +       err =3D start_renaming_dentry(&rd, 0, temp,
> > > +                                   &QSTR_LEN(c->destname.name, c->de=
stname.len));
> > > +       if (err =3D=3D -EINVAL || err =3D=3D -EXDEV) {
> >
> > This error code whitelist is not needed and is too fragile anyway.
> > After your commit
> > 9d23967b18c64 ("ovl: simplify an error path in ovl_copy_up_workdir()")
> > any locking error is treated the same - it does not matter what the
> > reason for lock_rename() or start_renaming_dentry() is.
> >
> > >                 /* temp or workdir moved underneath us? abort without=
 cleanup */
> > >                 dput(temp);
> > >                 err =3D -EIO;
> > > -               if (!IS_ERR(trap))
> > > -                       unlock_rename(c->workdir, c->destdir);
> > >                 goto out;
> > >         }
> >
> > Frankly, we could get rid of the "abort without cleanup"
> > comment and instead: err =3D -EIO; goto cleanup_unlocked;
> > because before cleanup_unlocked, cleanup was relying on the
> > lock_rename() to take the lock for the cleanup, but we don't need
> > that anymore.
> >
> > To be clear, I don't think is it important to goto cleanup_unlocked,
> > leaving goto out is fine because we are not very sympathetic
> > to changes to underlying layers while ovl is mounted, so we should
> > not really care about this cleanup, but for the sake of simpler code
> > I wouldn't mind the goto cleanup_unlocked.
>
> So I think you are saying that if start_renaming_dentry() returns an
> error, we should map that to -EIO and cleanup?
>

Yes. That sounds right.

Thanks,
Amir.

