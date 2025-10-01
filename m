Return-Path: <linux-fsdevel+bounces-63141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D4BAF13E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 06:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EEF4A3D59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 04:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9A92D6E5A;
	Wed,  1 Oct 2025 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KfbmBv3J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="giGZL3A2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B8239E70
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759292057; cv=none; b=VgtwQBeqxP+qQBeltQGONPgbUEDzK6tSM5bNXoluWRsNBgYjwkFCNCupDSSq73Ki7hGb1R6bwYIyZ7dTT+mMYgLKhNTRiD8BPRkeUc5pe+Nyx0YRonoEi6x23RjpSLVktMoHouqPrNXpxj+Ph7yLxjlA1xxmnSagdSW+ay0EdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759292057; c=relaxed/simple;
	bh=Tv8C4YkbipJn78Nk1Px2BZcJSkKcCsCCdkbiOk9wNv4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BzdjBfY7AoEhrUtXX4TgTT1YTenokC05sMwpgkKyn90tFpBBntDeWRAiqPjJQs5/p7Qw9/MBBTuctdWfv5zfj1qBhrrBr8V+gVFI5PPSGGrBPAhkRJPd/F4LyhJcChDN4vYEcMc0901tnVSsTnWNl+Z/HBJQdeVfDm2oWovDCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KfbmBv3J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=giGZL3A2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D479EC017B;
	Wed,  1 Oct 2025 00:14:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 01 Oct 2025 00:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759292054; x=1759378454; bh=aTU1tOEimNicu448C+PYcVmDCX7arTmiFxw
	XyyJPwN8=; b=KfbmBv3J3+uvKh3L0fYkMUotUfTOBlwrRp3ATyfzkb5j3PzqGxi
	81xK/yABHI6k+uTvU8wALUhMwyEgZcEMm2f2Fs2ja4ISxi5CT1J/hw+bf2NvmFpo
	vA1fgZ0gNTnOARYmXHNS3/mjX47LemgJ2GDiuMckQ8vjiQWhnuD9fnEkAzrjP8Q2
	R87VjDyYIo/dZJ4ZM3q5zucb7eNR80l7X6uzcIgxakfMiOk2d6M6aIgWZojMzKmI
	782mt1O5lX2+xJIPqnxrRtAab46UTk/nsnn0smEPl0MHj+U4b4l99eCiqJxQw+gz
	Aa0MAbhvHYF0TVY/wtoPbysPdsHfqVq+rMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759292054; x=
	1759378454; bh=aTU1tOEimNicu448C+PYcVmDCX7arTmiFxwXyyJPwN8=; b=g
	iGZL3A29igcViQKlRrjcH+mHoy3EpZZ5+F0ZJzfbOPG1mYJl9BbbnFPfzSpRIa7K
	2fZ2BiUMfVn++BRP8RhG2MaxWdmRk1w1+jvhOA/cue4pEgS3M4VpMsEOD8MnsB6j
	e3aayB9uDvgTqpHRH1+xZtUkwcAq7pyIuYc/XSE7gXoIPCgkcrtrR+1INhd8VshI
	9ZPIHfS9o1at8pkb7vBezH+qozEQy5tn/StZeAEBhcE/OYCRmKsbOXi2CRjLaxi6
	efFLV1Eg6T0Z5hAqQapBivL7CvzrYATN0aFqbGcxRLbROKYByDVxbGqJDgIn3mkL
	RdtNAUnpRNt688ejkOHCA==
X-ME-Sender: <xms:larcaE0Te9FOFg5ZxLgsJlxW2CaA4atNSp_SXo70SeTHshe46XcSrA>
    <xme:larcaKCE6uTWa7dDx1Auq4bGM9eqmiAK7P-OthkTaP15n5EpKw2pdJVNxJpoAlcwi
    hui42VkZorUFT4LGAp4Aa3_uA3VeJq_n9VwvMM7Z0H4bur2Ug>
X-ME-Received: <xmr:larcaL6uijwwPydsCQyxYBM0lZCO5F1GRLzDQwx0ppNAm6Wbiah3CsSdiJ64Zhf_IzP6jifZh60Dx-f7_iINYnzUret_0qbxXZdiaMuDA7fr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvdduhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:larcaDIfATp-o4Lqb_9ucL5LbOWtE9K2VTT9Ekk9WLloSwgY4kOp2Q>
    <xmx:larcaEsQ3b3O0GbHItz5X-u7NnHALZmDtnXlZkiWE2MWWFIvpz3eaw>
    <xmx:larcaCLAlhGY4a8Glpc5ApoAdjZjyZ3L_nVfKlru9dM_4OJwuYuRdA>
    <xmx:larcaN8u29DMH06Fe8g8MhWDjYvmwXbWe0CBHnK2z798ZyS25OUHpA>
    <xmx:lqrcaMvTmFVDHzjC3cs3adxZxmkrvj2XjEV2JVJ77QeDsyulWLDzNRNB>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 00:14:11 -0400 (EDT)
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
Subject: Re: [PATCH 10/11] Add start_renaming_two_dentrys()
In-reply-to:
 <CAOQ4uxhftW72em_nQRcxREprYrJM591C6WrAvjxzQYdX4XRPwA@mail.gmail.com>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <20250926025015.1747294-11-neilb@ownmail.net>,
 <CAOQ4uxhftW72em_nQRcxREprYrJM591C6WrAvjxzQYdX4XRPwA@mail.gmail.com>
Date: Wed, 01 Oct 2025 14:14:07 +1000
Message-id: <175929204714.1696783.14507048973444099320@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 30 Sep 2025, Amir Goldstein wrote:
> On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > A few callers want to lock for a rename and already have both dentrys.
> > Also debugfs does want to perform a lookup but doesn't want permission
> > checking, so start_renaming_dentry() cannot be used.
> >
> > This patch introduces start_renaming_two_dentrys() which is given both
> > dentrys.  debugfs performs one lookup itself.  As it will only continue
> > with a negative dentry and as those cannot be renamed or unlinked, it is
> > safe to do the lookup before getting the rename locks.
> >
> > overlayfs uses start_renaming_two_dentrys() in three places and  selinux
> > uses it twice in sel_make_policy_nodes().
> >
>=20
> start_renaming_two_dentries() please

I don't really like "two_dentries" as you wouldn't find it when
searching for "dentry".  But maybe that doesn't matter.  I can't think
of a better name so I've made the change as you suggest.

>=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/debugfs/inode.c           | 48 +++++++++++++--------------
> >  fs/namei.c                   | 63 ++++++++++++++++++++++++++++++++++++
> >  fs/overlayfs/dir.c           | 42 ++++++++++++++++--------
> >  include/linux/namei.h        |  2 ++
> >  security/selinux/selinuxfs.c | 27 ++++++++++------
> >  5 files changed, 133 insertions(+), 49 deletions(-)
> >
> > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > index b863c8d0cbcd..2aad67b8174e 100644
> > --- a/fs/debugfs/inode.c
> > +++ b/fs/debugfs/inode.c
> > @@ -842,7 +842,8 @@ int __printf(2, 3) debugfs_change_name(struct dentry =
*dentry, const char *fmt, .
> >         int error =3D 0;
> >         const char *new_name;
> >         struct name_snapshot old_name;
> > -       struct dentry *parent, *target;
> > +       struct dentry *target;
> > +       struct renamedata rd =3D {};
> >         struct inode *dir;
> >         va_list ap;
> >
> > @@ -855,36 +856,31 @@ int __printf(2, 3) debugfs_change_name(struct dentr=
y *dentry, const char *fmt, .
> >         if (!new_name)
> >                 return -ENOMEM;
> >
> > -       parent =3D dget_parent(dentry);
> > -       dir =3D d_inode(parent);
> > -       inode_lock(dir);
> > +       rd.old_parent =3D dget_parent(dentry);
> > +       rd.new_parent =3D rd.old_parent;
> > +       rd.flags =3D RENAME_NOREPLACE;
> > +       target =3D lookup_noperm_unlocked(&QSTR(new_name), rd.new_parent);
> > +       if (IS_ERR(target))
> > +               return PTR_ERR(target);
> >
> > -       take_dentry_name_snapshot(&old_name, dentry);
> > -
> > -       if (WARN_ON_ONCE(dentry->d_parent !=3D parent)) {
> > -               error =3D -EINVAL;
> > -               goto out;
> > -       }
> > -       if (strcmp(old_name.name.name, new_name) =3D=3D 0)
> > -               goto out;
> > -       target =3D lookup_noperm(&QSTR(new_name), parent);
> > -       if (IS_ERR(target)) {
> > -               error =3D PTR_ERR(target);
> > -               goto out;
> > -       }
> > -       if (d_really_is_positive(target)) {
> > -               dput(target);
> > -               error =3D -EINVAL;
> > +       error =3D start_renaming_two_dentrys(&rd, dentry, target);
> > +       if (error) {
> > +               if (error =3D=3D -EEXIST && target =3D=3D dentry)
> > +                       /* it isn't an error to rename a thing to itself =
*/
> > +                       error =3D 0;
> >                 goto out;
> >         }
> > -       simple_rename_timestamp(dir, dentry, dir, target);
> > -       d_move(dentry, target);
> > -       dput(target);
> > +
> > +       dir =3D d_inode(rd.old_parent);
> > +       take_dentry_name_snapshot(&old_name, dentry);
> > +       simple_rename_timestamp(dir, dentry, dir, rd.new_dentry);
> > +       d_move(dentry, rd.new_dentry);
> >         fsnotify_move(dir, dir, &old_name.name, d_is_dir(dentry), NULL, d=
entry);
> > -out:
> >         release_dentry_name_snapshot(&old_name);
> > -       inode_unlock(dir);
> > -       dput(parent);
> > +       end_renaming(&rd);
> > +out:
> > +       dput(rd.old_parent);
> > +       dput(target);
> >         kfree_const(new_name);
> >         return error;
> >  }
> > diff --git a/fs/namei.c b/fs/namei.c
> > index aca6de83d255..23f9adb43401 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3892,6 +3892,69 @@ int start_renaming_dentry(struct renamedata *rd, i=
nt lookup_flags,
> >         return __start_renaming_dentry(rd, lookup_flags, old_dentry, new_=
last);
> >  }
> >
> > +/**
> > + * start_renaming_two_dentrys - Lock to dentries in given parents for re=
name
>=20
> two_dentries please
>=20
> > + * @rd:           rename data containing parent
> > + * @old_dentry:   dentry of name to move
> > + * @new_dentry:   dentry to move to
> > + *
> > + * Ensure locks are in place for rename and check parentage is still cor=
rect.
> > + *
> > + * On success the two dentrys are stored in @rd.old_dentry and @rd.new_d=
entry and
> > + * @rd.old_parent and @rd.new_parent are confirmed to be the parents of =
the dentruies.
>=20
> typo: dentruies
>=20
> > + *
> > + * References and the lock can be dropped with end_renaming()
> > + *
> > + * Returns: zero or an error.
> > + */
> > +int
> > +start_renaming_two_dentrys(struct renamedata *rd,
> > +                          struct dentry *old_dentry, struct dentry *new_=
dentry)
> > +{
> > +       struct dentry *trap;
> > +       int err;
> > +
> > +       /* Already have the dentry - need to be sure to lock the correct =
parent */
> > +       trap =3D lock_rename_child(old_dentry, rd->new_parent);
> > +       if (IS_ERR(trap))
> > +               return PTR_ERR(trap);
> > +       err =3D -EINVAL;
> > +       if (d_unhashed(old_dentry) ||
> > +           (rd->old_parent && rd->old_parent !=3D old_dentry->d_parent))
> > +               /* old_dentry was removed, or moved and explicit parent r=
equested */
> > +               goto out_unlock;
> > +       if (d_unhashed(new_dentry) ||
> > +           rd->new_parent !=3D new_dentry->d_parent)
> > +               /* new_dentry was removed or moved */
> > +               goto out_unlock;
> > +
> > +       if (old_dentry =3D=3D trap)
> > +               /* source is an ancestor of target */
> > +               goto out_unlock;
> > +
> > +       if (new_dentry =3D=3D trap) {
> > +               /* target is an ancestor of source */
> > +               if (rd->flags & RENAME_EXCHANGE)
> > +                       err =3D -EINVAL;
> > +               else
> > +                       err =3D -ENOTEMPTY;
> > +               goto out_unlock;
> > +       }
> > +
> > +       err =3D -EEXIST;
> > +       if (d_is_positive(new_dentry) && (rd->flags & RENAME_NOREPLACE))
> > +               goto out_unlock;
> > +
> > +       rd->old_dentry =3D dget(old_dentry);
> > +       rd->new_dentry =3D dget(new_dentry);
> > +       rd->old_parent =3D dget(old_dentry->d_parent);
>=20
> This asymmetry between old_parent and new_parent is especially
> odd with two dentries and particularly with RENAME_EXCHANGE
> where the two dentries are alike.
>=20
> Is the old_parent ref really needed?

Yes, as end_renaming() needs to know it can still use the ref.

I've added a note to the start_renaming_dentry() to say why the
reference is taken.


>=20
> > +       return 0;
> > +
> > +out_unlock:
> > +       unlock_rename(old_dentry->d_parent, rd->new_parent);
> > +       return err;
> > +}
>=20
> needs EXPORT_GPL

Yes, thanks.

>=20
> > +
> >  void end_renaming(struct renamedata *rd)
> >  {
> >         unlock_rename(rd->old_parent, rd->new_parent);
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 54423ad00e1c..e8c369e3e277 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -125,6 +125,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, stru=
ct dentry *dir,
> >                              struct dentry *dentry)
> >  {
> >         struct dentry *whiteout;
> > +       struct renamedata rd =3D {};
> >         int err;
> >         int flags =3D 0;
> >
> > @@ -136,10 +137,13 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
> >         if (d_is_dir(dentry))
> >                 flags =3D RENAME_EXCHANGE;
> >
> > -       err =3D ovl_lock_rename_workdir(ofs->workdir, whiteout, dir, dent=
ry);
> > +       rd.old_parent =3D ofs->workdir;
> > +       rd.new_parent =3D dir;
> > +       rd.flags =3D flags;
> > +       err =3D start_renaming_two_dentrys(&rd, whiteout, dentry);
> >         if (!err) {
> > -               err =3D ovl_do_rename(ofs, ofs->workdir, whiteout, dir, d=
entry, flags);
> > -               unlock_rename(ofs->workdir, dir);
> > +               err =3D ovl_do_rename_rd(&rd);
> > +               end_renaming(&rd);
> >         }
> >         if (err)
> >                 goto kill_whiteout;
> > @@ -363,6 +367,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
> >         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> >         struct dentry *workdir =3D ovl_workdir(dentry);
> >         struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> > +       struct renamedata rd =3D {};
> >         struct path upperpath;
> >         struct dentry *upper;
> >         struct dentry *opaquedir;
> > @@ -388,7 +393,11 @@ static struct dentry *ovl_clear_empty(struct dentry =
*dentry,
> >         if (IS_ERR(opaquedir))
> >                 goto out;
> >
> > -       err =3D ovl_lock_rename_workdir(workdir, opaquedir, upperdir, upp=
er);
> > +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> > +       rd.old_parent =3D workdir;
> > +       rd.new_parent =3D upperdir;
> > +       rd.flags =3D RENAME_EXCHANGE;
> > +       err =3D start_renaming_two_dentrys(&rd, opaquedir, upper);
> >         if (err)
> >                 goto out_cleanup_unlocked;
> >
> > @@ -406,8 +415,8 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
> >         if (err)
> >                 goto out_cleanup;
> >
> > -       err =3D ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, R=
ENAME_EXCHANGE);
> > -       unlock_rename(workdir, upperdir);
> > +       err =3D ovl_do_rename_rd(&rd);
> > +       end_renaming(&rd);
> >         if (err)
> >                 goto out_cleanup_unlocked;
> >
> > @@ -420,7 +429,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
> >         return opaquedir;
> >
> >  out_cleanup:
> > -       unlock_rename(workdir, upperdir);
> > +       end_renaming(&rd);
> >  out_cleanup_unlocked:
> >         ovl_cleanup(ofs, workdir, opaquedir);
> >         dput(opaquedir);
> > @@ -443,6 +452,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
> >         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> >         struct dentry *workdir =3D ovl_workdir(dentry);
> >         struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> > +       struct renamedata rd =3D {};
> >         struct dentry *upper;
> >         struct dentry *newdentry;
> >         int err;
> > @@ -474,7 +484,11 @@ static int ovl_create_over_whiteout(struct dentry *d=
entry, struct inode *inode,
> >         if (IS_ERR(newdentry))
> >                 goto out_dput;
> >
> > -       err =3D ovl_lock_rename_workdir(workdir, newdentry, upperdir, upp=
er);
> > +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> > +       rd.old_parent =3D workdir;
> > +       rd.new_parent =3D upperdir;
> > +       rd.flags =3D 0;
> > +       err =3D start_renaming_two_dentrys(&rd, newdentry, upper);
> >         if (err)
> >                 goto out_cleanup_unlocked;
> >
> > @@ -511,16 +525,16 @@ static int ovl_create_over_whiteout(struct dentry *=
dentry, struct inode *inode,
> >                 if (err)
> >                         goto out_cleanup;
> >
> > -               err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper,
> > -                                   RENAME_EXCHANGE);
> > -               unlock_rename(workdir, upperdir);
> > +               rd.flags =3D RENAME_EXCHANGE;
> > +               err =3D ovl_do_rename_rd(&rd);
> > +               end_renaming(&rd);
> >                 if (err)
> >                         goto out_cleanup_unlocked;
> >
> >                 ovl_cleanup(ofs, workdir, upper);
> >         } else {
> > -               err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper, 0);
> > -               unlock_rename(workdir, upperdir);
> > +               err =3D ovl_do_rename_rd(&rd);
> > +               end_renaming(&rd);
> >                 if (err)
> >                         goto out_cleanup_unlocked;
> >         }
> > @@ -540,7 +554,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
> >         return err;
> >
> >  out_cleanup:
> > -       unlock_rename(workdir, upperdir);
> > +       end_renaming(&rd);
> >  out_cleanup_unlocked:
> >         ovl_cleanup(ofs, workdir, newdentry);
> >         dput(newdentry);
>=20
> ovl changes look fine to me.
>=20
> with change of helper name and typo fixes feel free to add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Done.  Thanks for you help.

NeilBrown


>=20
>=20
> Thanks,
> Amir.
>=20


