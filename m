Return-Path: <linux-fsdevel+bounces-63139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB66BAEF7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 03:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A09194369F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748FE246BB9;
	Wed,  1 Oct 2025 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="DUa7pz4W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s5jPX7Ea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1D15A848
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759283126; cv=none; b=h5LZjW4Bv4a+GnzvY1hZYzZCf/KEWIeyyXXpHsNuYcrzxWodLr4ra2PzVsnsbh49Jxbd3NCtsama9ntcfoP/3epcm+zr/uJF6sr7KHcPe9t+zp1rGT1VbDr2p5cYwG1jY88glVHau43yp/QCRGhdo0Y/9Al/KWZGWyQ0GAQLPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759283126; c=relaxed/simple;
	bh=9JvaJGcOiRbmYoQ6BWmjrA2m/uoXicNQelPMvDl+b4Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=I3lWqh5Kh52fwW0n9IZ+ldWHbDN5JRGGa+qMBLU7jPIcypd9MufioMdtZJIVcW79DqSx3uehE6iIW8k8RqS2gRCz3lgbFjS+iPTReRdJrKuCNx4Goh8w7gsJYpy3WKjRPG+IP2SeAoV2AgtPPhB6hD3T2SpBr8Uxm3P9t5cSkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=DUa7pz4W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s5jPX7Ea; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 780ECEC00F9;
	Tue, 30 Sep 2025 21:45:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 30 Sep 2025 21:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759283123; x=1759369523; bh=ZUst76pB/WE0eTgjbmIsYQaywuDg9g7hTQj
	imZfLakE=; b=DUa7pz4WObcoOsFAWhiPFcHL9PSC4rPKdo1pvbny/5mhRpEwgDD
	nZ2EGlpcCHNYLmFX6ZdeGSeTJ5Py6IVwpBfqJ1fMWiC/D13gCv3ppYGj7a8cGbea
	k57IojsL8+w2H9eiQATHQb+PCViC8c8/lcogRa5bbTRWX2VlVfhGtpY1nUAvI41O
	SkVohbx2x2gkOUCkJXY4+H1TCewNJrfQkzd3zMCk2Fvv6OJAiw5oVhcT8XNmB6/e
	WOc5Vw2RDo/mndOOdyweupPEa/hG1vILuoACopApzQfXWhj8Ar8WqYsRpt7d0w68
	cNWXdR3d/BaO7E9NcLbYHg4O+OiiMHDDmrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759283123; x=
	1759369523; bh=ZUst76pB/WE0eTgjbmIsYQaywuDg9g7hTQjimZfLakE=; b=s
	5jPX7Ea+Q8Xfyc2cPORh+/DxuhAgNjz/6B1+M6Trm6993sbk0mf6m8kVw/Lg/MyU
	omhl6TneuawEm6PNewlfwUN+3L38Y6wd4UmMOYWaHjIgV0zf7JZLMYBO00MXwuXh
	HWrjH9fReHi4sUDH1iyGtbbGvC89lYZdRC6c8nkaWODxyh9aGGMx5GfZLi8XOgqX
	/AgaTfAKi7RGpdSY2uq7Qg2nP4+kkkq8aOg4S5PrlD0zeYwDLY6Z0TFD3BkWbe5I
	N9r5hDDDZkNjn9uNnToaJ0UcJqa7crDdMNK2Q1TxIMSt36L3wsCJZJ/jezLRzVyn
	iNxX3sUmZWiOxfjbsXXWw==
X-ME-Sender: <xms:sofcaGifnQRtBbEK2905hiGQqQLZTW-IY87AaKUYz4mO8s4eIrLjqw>
    <xme:sofcaB9uZEftxxqcUvsPrLMAueLe2ps5NEKhy6yTbnhLD623ex7zjGGFt5VDhcZXW
    r6eIwdTMxYgan1VTxAC1Ptkcq_oU8p8sqgTWmGMBJc1GsHQOxI>
X-ME-Received: <xmr:sofcaNEzTxUmJzyBgAxA6VVz7wEXWJX_vBNf6UgIgKDj5YxhOfeIdDSWQN1JXIuc_-K8GHhWeNcstFsnYeQLHF3LmOz0sPB7gAKOfB3EdvJ7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:sofcaEnawDxmqMi3WOPOQX0-dCugotVeM2tRw_o3bvee5ILHQt-VlQ>
    <xmx:sofcaBZjypavPMdD-0-ypFMus2-tCxAYBXD0OcBWbrQ3PXspZnTpPQ>
    <xmx:sofcaJFiKQT94ND1wecRGQONbmMa5mxovcDj-drj2O-SSFfLMttczw>
    <xmx:sofcaCISjtehZyTD-7yuph5DTZjYwERbeLvuUDkV_0vsBTt4hJi9Nw>
    <xmx:s4fcaO4kNI-hdpgJMNiwSDKMbzT20IOBsK44OLMImFpe9V02RogNpzkH>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 21:45:20 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/11] VFS/ovl/smb: introduce start_renaming_dentry()
In-reply-to:
 <CAOQ4uxiZ=R16EN+Ha_HxgxAhE1r2vKX4Ck+H9_AfyB4a6=9=Zw@mail.gmail.com>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <20250926025015.1747294-10-neilb@ownmail.net>,
 <CAOQ4uxiZ=R16EN+Ha_HxgxAhE1r2vKX4Ck+H9_AfyB4a6=9=Zw@mail.gmail.com>
Date: Wed, 01 Oct 2025 11:45:19 +1000
Message-id: <175928311901.1696783.1411913325509395264@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 30 Sep 2025, Amir Goldstein wrote:
> On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > Several callers perform a rename on a dentry they already have, and only
> > require lookup for the target name.  This includes smb/server and a few
> > different places in overlayfs.
> >
> > start_renaming_dentry() performs the required lookup and takes the
> > required lock using lock_rename_child()
> >
> > It is used in three places in overlayfs and in ksmbd_vfs_rename().
> >
> > In the ksmbd case, the parent of the source is not important - the
> > source must be renamed from wherever it is.  So start_renaming_dentry()
> > allows rd->old_parent to be NULL and only checks it if it is non-NULL.
> > On success rd->old_parent will be the parent of old_dentry with an extra
> > reference taken.
>=20
> It is not clear to me why you need to take that extra ref.
> It looks very unnatural for start_renaming/end_renaming
> to take ref on old_parent and not on new_parent.

There is an important difference between old_parent and new_parent.
After the rename, new_parent will still be valid as we will hold a
reference through whichever child is in that parent.
However we might not still have a reference that keeps old_parent valid,
unless we take one ourselves.

>=20
> If ksmbd needs old_parent it can use old->d_parent after
> the start_renaming_dentry() it should be stable. right?
> So what's the point of taking this extra ref?

It is not that ksmbd might need old_parent, it is that end_renaming()
needs old_parent so it can be unlocked.  If we don't explicitly take a
reference, then we cannot be sure that the reference that was found in
start_renaming_dentry() is still valid after vfs_rename() has moved the
old_dentry out of it.

>=20
> > Other start_renaming function also now take the extra
> > reference and end_renaming() now drops this reference as well.
> >
> > ovl_lookup_temp(), ovl_parent_lock(), and ovl_parent_unlock() are
> > all removed as they are no longer needed.
> >
> > OVL_TEMPNAME_SIZE and ovl_tempname() are now declared in overlayfs.h so
> > that ovl_check_rename_whiteout() can access them.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/namei.c               | 106 ++++++++++++++++++++++++++++++++++++---
> >  fs/overlayfs/copy_up.c   |  47 ++++++++---------
> >  fs/overlayfs/dir.c       |  19 +------
> >  fs/overlayfs/overlayfs.h |   8 +--
> >  fs/overlayfs/super.c     |  20 ++++----
> >  fs/overlayfs/util.c      |  11 ----
> >  fs/smb/server/vfs.c      |  60 ++++------------------
> >  include/linux/namei.h    |   2 +
> >  8 files changed, 147 insertions(+), 126 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 79a8b3b47e4d..aca6de83d255 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3686,7 +3686,7 @@ EXPORT_SYMBOL(unlock_rename);
> >
> >  /**
> >   * __start_renaming - lookup and lock names for rename
> > - * @rd:           rename data containing parent and flags, and
> > + * @rd:           rename data containing parents and flags, and
> >   *                for receiving found dentries
> >   * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> >   *                LOOKUP_NO_SYMLINKS etc).
> > @@ -3697,8 +3697,8 @@ EXPORT_SYMBOL(unlock_rename);
> >   * rename.
> >   *
> >   * On success the found dentrys are stored in @rd.old_dentry,
> > - * @rd.new_dentry.  These references and the lock are dropped by
> > - * end_renaming().
> > + * @rd.new_dentry and an extra ref is taken on @rd.old_parent.
> > + * These references and the lock are dropped by end_renaming().
> >   *
> >   * The passed in qstrs must have the hash calculated, and no permission
> >   * checking is performed.
> > @@ -3750,6 +3750,7 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
> >
> >         rd->old_dentry =3D d1;
> >         rd->new_dentry =3D d2;
> > +       dget(rd->old_parent);
> >         return 0;
> >
> >  out_unlock_3:
> > @@ -3765,7 +3766,7 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
> >
> >  /**
> >   * start_renaming - lookup and lock names for rename with permission che=
cking
> > - * @rd:           rename data containing parent and flags, and
> > + * @rd:           rename data containing parents and flags, and
> >   *                for receiving found dentries
> >   * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> >   *                LOOKUP_NO_SYMLINKS etc).
> > @@ -3776,8 +3777,8 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
> >   * rename.
> >   *
> >   * On success the found dentrys are stored in @rd.old_dentry,
> > - * @rd.new_dentry.  These references and the lock are dropped by
> > - * end_renaming().
> > + * @rd.new_dentry.  Also the refcount on @rd->old_parent is increased.
> > + * These references and the lock are dropped by end_renaming().
> >   *
> >   * The passed in qstrs need not have the hash calculated, and basic
> >   * eXecute permission checking is performed against @rd.mnt_idmap.
> > @@ -3799,11 +3800,104 @@ int start_renaming(struct renamedata *rd, int lo=
okup_flags,
> >  }
> >  EXPORT_SYMBOL(start_renaming);
> >
> > +static int
> > +__start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> > +                       struct dentry *old_dentry, struct qstr *new_last)
> > +{
> > +       struct dentry *trap;
> > +       struct dentry *d2;
> > +       int target_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> > +       int err;
> > +
> > +       if (rd->flags & RENAME_EXCHANGE)
> > +               target_flags =3D 0;
> > +       if (rd->flags & RENAME_NOREPLACE)
> > +               target_flags |=3D LOOKUP_EXCL;
> > +
> > +       /* Already have the dentry - need to be sure to lock the correct =
parent */
> > +       trap =3D lock_rename_child(old_dentry, rd->new_parent);
> > +       if (IS_ERR(trap))
> > +               return PTR_ERR(trap);
> > +       if (d_unhashed(old_dentry) ||
> > +           (rd->old_parent && rd->old_parent !=3D old_dentry->d_parent))=
 {
> > +               /* dentry was removed, or moved and explicit parent reque=
sted */
> > +               d2 =3D ERR_PTR(-EINVAL);
> > +               goto out_unlock_2;
> > +       }
> > +
> > +       d2 =3D lookup_one_qstr_excl(new_last, rd->new_parent,
> > +                                 lookup_flags | target_flags);
> > +       if (IS_ERR(d2))
> > +               goto out_unlock_2;
> > +
> > +       if (old_dentry =3D=3D trap) {
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
> > +       rd->old_dentry =3D dget(old_dentry);
> > +       rd->new_dentry =3D d2;
> > +       rd->old_parent =3D dget(old_dentry->d_parent);
> > +       return 0;
> > +
> > +out_unlock_3:
> > +       dput(d2);
> > +       d2 =3D ERR_PTR(err);
> > +out_unlock_2:
> > +       unlock_rename(old_dentry->d_parent, rd->new_parent);
> > +       return PTR_ERR(d2);
>=20
> Please assign err before goto and simplify:
>=20
> out_dput:
>        dput(d2);
> out_unlock:
>        unlock_rename(old_dentry->d_parent, rd->new_parent);
>        return err;

I'll try that change and see if I like the result.

>=20
> > +}
> > +
> > +/**
> > + * start_renaming_dentry - lookup and lock name for rename with permissi=
on checking
> > + * @rd:           rename data containing parents and flags, and
> > + *                for receiving found dentries
> > + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> > + *                LOOKUP_NO_SYMLINKS etc).
> > + * @old_dentry:   dentry of name to move
> > + * @new_last:     name of target in @rd.new_parent
> > + *
> > + * Look up target name and ensure locks are in place for
> > + * rename.
> > + *
> > + * On success the found dentry is stored in @rd.new_dentry and
> > + * @rd.old_parent is confirmed to be the parent of @old_dentry.  If it
> > + * was originally %NULL, it is set.  In either case a refernence is take=
n.
>=20
> Typo: %NULL, typo: refernence
>=20
> > + *
> > + * References and the lock can be dropped with end_renaming()
> > + *
> > + * The passed in qstr need not have the hash calculated, and basic
> > + * eXecute permission checking is performed against @rd.mnt_idmap.
> > + *
> > + * Returns: zero or an error.
> > + */
> > +int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> > +                         struct dentry *old_dentry, struct qstr *new_las=
t)
> > +{
> > +       int err;
> > +
> > +       err =3D lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent=
);
> > +       if (err)
> > +               return err;
> > +       return __start_renaming_dentry(rd, lookup_flags, old_dentry, new_=
last);
> > +}
> > +
> >  void end_renaming(struct renamedata *rd)
> >  {
> >         unlock_rename(rd->old_parent, rd->new_parent);
> >         dput(rd->old_dentry);
> >         dput(rd->new_dentry);
> > +       dput(rd->old_parent);
> >  }
> >  EXPORT_SYMBOL(end_renaming);
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 6a31ea34ff80..3f19548b5d48 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -523,8 +523,8 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
> >  {
> >         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> >         struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> > -       struct dentry *index =3D NULL;
> >         struct dentry *temp =3D NULL;
> > +       struct renamedata rd =3D {};
> >         struct qstr name =3D { };
> >         int err;
> >
> > @@ -556,17 +556,15 @@ static int ovl_create_index(struct dentry *dentry, =
const struct ovl_fh *fh,
> >         if (err)
> >                 goto out;
> >
> > -       err =3D ovl_parent_lock(indexdir, temp);
> > +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> > +       rd.old_parent =3D indexdir;
> > +       rd.new_parent =3D indexdir;
> > +       err =3D start_renaming_dentry(&rd, 0, temp, &name);
> >         if (err)
> >                 goto out;
> > -       index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
> > -       if (IS_ERR(index)) {
> > -               err =3D PTR_ERR(index);
> > -       } else {
> > -               err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, inde=
x, 0);
> > -               dput(index);
> > -       }
> > -       ovl_parent_unlock(indexdir);
> > +
> > +       err =3D ovl_do_rename_rd(&rd);
> > +       end_renaming(&rd);
> >  out:
> >         if (err)
> >                 ovl_cleanup(ofs, indexdir, temp);
> > @@ -763,7 +761,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
> >         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
> >         struct inode *inode;
> >         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
> > -       struct dentry *temp, *upper, *trap;
> > +       struct renamedata rd =3D {};
> > +       struct dentry *temp;
> >         struct ovl_cu_creds cc;
> >         int err;
> >         struct ovl_cattr cattr =3D {
> > @@ -807,29 +806,27 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
> >          * ovl_copy_up_data(), so lock workdir and destdir and make sure =
that
> >          * temp wasn't moved before copy up completion or cleanup.
> >          */
> > -       trap =3D lock_rename(c->workdir, c->destdir);
> > -       if (trap || temp->d_parent !=3D c->workdir) {
> > +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> > +       rd.old_parent =3D c->workdir;
> > +       rd.new_parent =3D c->destdir;
> > +       rd.flags =3D 0;
> > +       err =3D start_renaming_dentry(&rd, 0, temp,
> > +                                   &QSTR_LEN(c->destname.name, c->destna=
me.len));
> > +       if (err =3D=3D -EINVAL || err =3D=3D -EXDEV) {
>=20
> This error code whitelist is not needed and is too fragile anyway.
> After your commit
> 9d23967b18c64 ("ovl: simplify an error path in ovl_copy_up_workdir()")
> any locking error is treated the same - it does not matter what the
> reason for lock_rename() or start_renaming_dentry() is.
>=20
> >                 /* temp or workdir moved underneath us? abort without cle=
anup */
> >                 dput(temp);
> >                 err =3D -EIO;
> > -               if (!IS_ERR(trap))
> > -                       unlock_rename(c->workdir, c->destdir);
> >                 goto out;
> >         }
>=20
> Frankly, we could get rid of the "abort without cleanup"
> comment and instead: err =3D -EIO; goto cleanup_unlocked;
> because before cleanup_unlocked, cleanup was relying on the
> lock_rename() to take the lock for the cleanup, but we don't need
> that anymore.
>=20
> To be clear, I don't think is it important to goto cleanup_unlocked,
> leaving goto out is fine because we are not very sympathetic
> to changes to underlying layers while ovl is mounted, so we should
> not really care about this cleanup, but for the sake of simpler code
> I wouldn't mind the goto cleanup_unlocked.

So I think you are saying that if start_renaming_dentry() returns an
error, we should map that to -EIO and cleanup?

I can do that - sure.

>=20
> > -
> > -       err =3D ovl_copy_up_metadata(c, temp);
> >         if (err)
> >                 goto cleanup;
>=20
> Is this right? should we be calling end_renaming() on error?

You are right- that should be "goto cleanup_unlocked".

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20


