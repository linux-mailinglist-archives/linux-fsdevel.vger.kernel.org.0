Return-Path: <linux-fsdevel+bounces-62931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCE0BA5E65
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 13:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E337B1D2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C952B27C178;
	Sat, 27 Sep 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dnEIHvyF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V6bZX3bN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12BEC8CE
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758972731; cv=none; b=JsvSkRUw3LraJI+LtYPS6DzeTtAvlkrr1Kq8vV4Skt6dKruWLtUyJvGpVwDaYNyGzTMImH29LBfHYjQYYoCYcXGazeNefKGeJX5vbV6RznE496dl/mw2FjrGwIZM8rSsu+dPSnDIb+hxwADwwr6r3gVVxOYV9KINLJiWqo8Eg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758972731; c=relaxed/simple;
	bh=a5RKOyQY/M5uL2f5mE0FaTXKNQon7mgyssXwixWCCjw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jAVKh6QjFlD1IScf8f0aM1wpeEHcZmvxz4477cX9r80DZFjYxUD6mNfz6ZXXASKHWxVZblEjMZc/0qSvxGmhS0mSt7xLYmV6zPjWAK3k8pBCBfpvD//+7S/adSYIua2V0FE/naQoerQ8n88frSDh+v+/OnR35ApmxxoActoV8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dnEIHvyF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V6bZX3bN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0A3A01D00025;
	Sat, 27 Sep 2025 07:32:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 27 Sep 2025 07:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1758972724; x=1759059124; bh=+yVs3wRp0a1+jNDaRtrwCF1sc7fVxKvhFts
	fVIuu89w=; b=dnEIHvyFFLwsf6GziLN3NFnSncCRwUxK9LehsVYbg9AvOekq5x2
	iyT+WeTMNGiaJUGLZa8lm6kDb9Kvg3+XjYFQ83AOpaT0P34E7iDJFYrgP+F/WQTi
	P+WY5IKOCNreAwSXjOOVdf4/Im7vcjIrFMdP2wTR3oYnSKF1f65Euo3JmmzrjqPn
	649Z/6uOoujcOrKf5BKBQrTGxd6aR4d9JjPMrVeBxu6MjYRkF3xpLxh/I5FFeNIG
	BkNIUb8dWHYuUfust+RRNdKskuknn2CT8sTpOm81+W3fAb+FYpSIBzNDeJxa2Hzn
	h1p712AgFqrf68bFSpudXbQyHCwnEWednYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758972724; x=
	1759059124; bh=+yVs3wRp0a1+jNDaRtrwCF1sc7fVxKvhFtsfVIuu89w=; b=V
	6bZX3bNjIiKxWiv7QsALHHO2mshEPJPDd4deQ0sXwuXJEwu2755jSq1nuxCFgy3Z
	h+z41EdnAt9LJn9UIcqgF4Nf60qmMSU6B4/jkEGzCoB9043voWa2jOkLQSRI/M6A
	L15Ya7py36Aqt5Rsvnv6tv54hd5+AL7npTRnUdBSVRyS7SfNhsgJS+SG/DdrySea
	8G47WqpOIV+wQPRfoAoh4fYg8kSfg7JjbdAbotDdm2g2ph+rAIWqgy4KAm8oBdHE
	ua2ftMLlTa0RiyAFCPli75A2R3mBiUeQpKYRez98kyAHA1tNmEiz8XolwU7NxMkt
	T5nQW5EMjMZ85odML+R5g==
X-ME-Sender: <xms:NMvXaL1e7RFyAwUdW1FwtFaayX4wD4PquqTHxQS65rjU4LqEAJXd7A>
    <xme:NMvXaFBDm7ACmXtrYr9dU1DSdlrmc48z-dxzciF_UGwq871bg2yUOzRQ238eWyygw
    EDBUJdahO9i4iS4TNZlDLed75Bdv1w2zv7fyKFmlBHz0E1MMCA>
X-ME-Received: <xmr:NMvXaK7_XSzNmJdvg0aCcJ56vArZWG854Zb-fk3Z4tg3F6SR9YLJuN6Ocij8bk2wnFc3EU9s-Pk7iwNftfK3aBV6tlvUJiMS4tZy5g9aAxDR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvddugecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:NMvXaGI18u6YJ0rfXvR14eUUDow9uI_j10eqI2lSNe5gNlKpwL26iw>
    <xmx:NMvXaLuisnZ6SIFG2cHJQ0dyUqzoGnlJjMUnZxnbWT35yf46MdMzxQ>
    <xmx:NMvXaNK5VsV16lRzKmb3dazX2lVxXhF6ttcgrX2DX6fNh5SLjE_r5w>
    <xmx:NMvXaM-eLKJ4cD7jTRncAV-judPckONQnBS1CbBQaVcdOC-3r-SB8A>
    <xmx:NMvXaLt5U3hwNRAHaoEuXRwrHFNq3UQ7vui5NfUQ1x0gcUCNf0NdcdzB>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 07:32:02 -0400 (EDT)
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
Subject: Re: [PATCH 02/11] VFS: introduce start_dirop() and end_dirop()
In-reply-to:
 <CAOQ4uxi=sM54cByg-WYrw2umocTNzrX4_nhObVbxRP7Muz5JeA@mail.gmail.com>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <20250926025015.1747294-3-neilb@ownmail.net>,
 <CAOQ4uxi=sM54cByg-WYrw2umocTNzrX4_nhObVbxRP7Muz5JeA@mail.gmail.com>
Date: Sat, 27 Sep 2025 21:32:00 +1000
Message-id: <175897272044.1696783.18258431889388637814@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 27 Sep 2025, Amir Goldstein wrote:
> On Fri, Sep 26, 2025 at 4:50=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > The fact that directory operations (create,remove,rename) are protected
> > by a lock on the parent is known widely throughout the kernel.
> > In order to change this - to instead lock the target dentry  - it is
> > best to centralise this knowledge so it can be changed in one place.
> >
> > This patch introduces start_dirop() which is local to VFS code.
> > It performs the required locking for create and remove.  Rename
> > will be handled separately.
> >
> > Various functions with names like start_creating() or start_removing_path=
(),
> > some of which already exist, will export this functionality beyond the VF=
S.
> >
> > end_dirop() is the partner of start_dirop().  It drops the lock and
> > releases the reference on the dentry.
> > It *is* exported so that various end_creating etc functions can be inline.
> >
>=20
> --- from here
> > As vfs_mkdir() drops the dentry on error we cannot use end_dirop() as
> > that won't unlock when the dentry IS_ERR().  For those cases we have
> > end_dirop_mkdir().
> >
> > end_dirop() can always be called on the result of start_dirop(), but not
> > after vfs_mkdir().
> > end_dirop_mkdir() can only be called on the result of start_dirop() if
> > that was not an error, and can also be called on the result of
> > vfs_mkdir().
> >
> > When we change vfs_mkdir() to drop the lock when it drops the dentry,
> > end_dirop_mkdir() can be discarded.
> ---until here
>=20
> I am really struggling swallowing end_dirop_mkdir() as a temp helper
> It's has such fluid and weird semantics nobody has a chance to
> remember or guess, it is scheduled to be removed, and it is
> only used in two helpers end_creating_path() and end_creating()
> (right?) both of which have perfectly understandable and normal
> semantics.
>=20
> So how about we stop pretending that end_dirop_mkdir() is a sane
> abstraction and open code it twice inside the helpers where
> the code makes sense and is well documented?
>=20
> Am I missing some subtlety? or missing the bigger picture?

No, I don't think you are missing anything important.
end_dirop_mkdir() was useful scaffolding for me was I was writing the
code, but now that I look back prompted by you I see that it doesn't add
anything to the final product.  I'll remove it.

>=20
> >
> > As well as adding start_dirop() and end_dirop()/end_dirop_mkdir()
> > this patch uses them in:
> >  - simple_start_creating (which requires sharing lookup_noperm_common()
> >         with libfs.c)
> >  - start_removing_path / start_removing_user_path_at
> >  - filename_create / end_creating_path()
> >  - do_rmdir(), do_unlinkat()
> >
> > The change in do_unlinkat() opens the opportunity for some cleanup.
> > As we don't need to unlock on lookup failure, "inode" can be local
> > to the non-error patch.  Also the "slashes" handler is moved
> > in-line with an "unlikely" annotation on the branch.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/internal.h      |   3 ++
> >  fs/libfs.c         |  36 ++++++-------
> >  fs/namei.c         | 126 +++++++++++++++++++++++++++++++--------------
> >  include/linux/fs.h |   3 ++
> >  4 files changed, 110 insertions(+), 58 deletions(-)
> >
> > diff --git a/fs/internal.h b/fs/internal.h
> > index a33d18ee5b74..d11fe787bbc1 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -67,6 +67,9 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
> >                 const struct path *parentpath,
> >                 struct file *file, umode_t mode);
> >  struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
> > +struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
> > +                          unsigned int lookup_flags);
> > +int lookup_noperm_common(struct qstr *qname, struct dentry *base);
> >
> >  /*
> >   * namespace.c
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index ce8c496a6940..fc979becd536 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> > @@ -2289,27 +2289,25 @@ void stashed_dentry_prune(struct dentry *dentry)
> >         cmpxchg(stashed, dentry, NULL);
> >  }
> >
> > -/* parent must be held exclusive */
> > +/**
> > + * simple_start_creating - prepare to create a given name
> > + * @parent - directory in which to prepare to create the name
> > + * @name - the name to be created
> > + *
> > + * Required lock is taken and a lookup in performed prior to creating an
> > + * object in a directory.  No permission checking is performed.
> > + *
> > + * Returns: a negative dentry on which vfs_create() or similar may
> > + *  be attempted, or an error.
> > + */
> >  struct dentry *simple_start_creating(struct dentry *parent, const char *=
name)
> >  {
> > -       struct dentry *dentry;
> > -       struct inode *dir =3D d_inode(parent);
> > +       struct qstr qname =3D QSTR(name);
> > +       int err;
> >
> > -       inode_lock(dir);
> > -       if (unlikely(IS_DEADDIR(dir))) {
> > -               inode_unlock(dir);
> > -               return ERR_PTR(-ENOENT);
> > -       }
> > -       dentry =3D lookup_noperm(&QSTR(name), parent);
> > -       if (IS_ERR(dentry)) {
> > -               inode_unlock(dir);
> > -               return dentry;
> > -       }
> > -       if (dentry->d_inode) {
> > -               dput(dentry);
> > -               inode_unlock(dir);
> > -               return ERR_PTR(-EEXIST);
> > -       }
> > -       return dentry;
> > +       err =3D lookup_noperm_common(&qname, parent);
> > +       if (err)
> > +               return ERR_PTR(err);
> > +       return start_dirop(parent, &qname, LOOKUP_CREATE | LOOKUP_EXCL);
> >  }
> >  EXPORT_SYMBOL(simple_start_creating);
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 507ca0d7878d..81cbaabbbe21 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2765,6 +2765,69 @@ static int filename_parentat(int dfd, struct filen=
ame *name,
> >         return __filename_parentat(dfd, name, flags, parent, last, type, =
NULL);
> >  }
> >
> > +/**
> > + * start_dirop - begin a create or remove dirop, performing locking and =
lookup
> > + * @parent - the dentry of the parent in which the operation will occur
> > + * @name - a qstr holding the name within that parent
> > + * @lookup_flags - intent and other lookup flags.
> > + *
> > + * The lookup is performed and necessary locks are taken so that, on suc=
cess,
>=20
> typo: necessary
>=20
> > + * the returned dentry can be operated on safely.
> > + * The qstr must already have the hash value calculated.
> > + *
> > + * Returns: a locked dentry, or an error.
> > + *
> > + */
> > +struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
> > +                          unsigned int lookup_flags)
> > +{
> > +       struct dentry *dentry;
> > +       struct inode *dir =3D d_inode(parent);
> > +
> > +       inode_lock_nested(dir, I_MUTEX_PARENT);
> > +       dentry =3D lookup_one_qstr_excl(name, parent, lookup_flags);
> > +       if (IS_ERR(dentry))
> > +               inode_unlock(dir);
> > +       return dentry;
> > +}
> > +
> > +/**
> > + * end_dirop - signal completion of a dirop
> > + * @de - the dentry which was returned by start_dirop or similar.
> > + *
> > + * If the de is an error, nothing happens. Otherwise any lock taken to
> > + * protect the dentry is dropped and the dentry itself is release (dput(=
)).
> > + */
> > +void end_dirop(struct dentry *de)
> > +{
> > +       if (!IS_ERR(de)) {
> > +               inode_unlock(de->d_parent->d_inode);
> > +               dput(de);
> > +       }
> > +}
> > +EXPORT_SYMBOL(end_dirop);
> > +
> > +/**
> > + * end_dirop_mkdir - signal completion of a dirop which could have been =
vfs_mkdir
> > + * @de - the dentry which was returned by start_dirop or similar.
> > + * @parent - the parent in which the mkdir happened.
> > + *
> > + * Because vfs_mkdir() dput()s the dentry on failure, end_dirop() cannot
> > + * be used with it.  Instead this function must be used, and it must not
> > + * be called if the original lookup failed.
> > + *
> > + * If de is an error the parent is unlocked, else this behaves the same =
as
> > + * end_dirop().
> > + */
> > +void end_dirop_mkdir(struct dentry *de, struct dentry *parent)
> > +{
> > +       if (IS_ERR(de))
> > +               inode_unlock(parent->d_inode);
> > +       else
> > +               end_dirop(de);
> > +}
> > +EXPORT_SYMBOL(end_dirop_mkdir);
> > +
> >  /* does lookup, returns the object with parent locked */
> >  static struct dentry *__start_removing_path(int dfd, struct filename *na=
me,
> >                                            struct path *path)
> > @@ -2781,10 +2844,9 @@ static struct dentry *__start_removing_path(int df=
d, struct filename *name,
> >                 return ERR_PTR(-EINVAL);
> >         /* don't fail immediately if it's r/o, at least try to report oth=
er errors */
> >         error =3D mnt_want_write(parent_path.mnt);
> > -       inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
> > -       d =3D lookup_one_qstr_excl(&last, parent_path.dentry, 0);
> > +       d =3D start_dirop(parent_path.dentry, &last, 0);
> >         if (IS_ERR(d))
> > -               goto unlock;
> > +               goto drop;
> >         if (error)
> >                 goto fail;
> >         path->dentry =3D no_free_ptr(parent_path.dentry);
> > @@ -2792,10 +2854,9 @@ static struct dentry *__start_removing_path(int df=
d, struct filename *name,
> >         return d;
> >
> >  fail:
> > -       dput(d);
> > +       end_dirop(d);
> >         d =3D ERR_PTR(error);
> > -unlock:
> > -       inode_unlock(parent_path.dentry->d_inode);
> > +drop:
> >         if (!error)
> >                 mnt_drop_write(parent_path.mnt);
> >         return d;
> > @@ -2910,7 +2971,7 @@ int vfs_path_lookup(struct dentry *dentry, struct v=
fsmount *mnt,
> >  }
> >  EXPORT_SYMBOL(vfs_path_lookup);
> >
> > -static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
> > +int lookup_noperm_common(struct qstr *qname, struct dentry *base)
> >  {
> >         const char *name =3D qname->name;
> >         u32 len =3D qname->len;
> > @@ -4223,21 +4284,18 @@ static struct dentry *filename_create(int dfd, st=
ruct filename *name,
> >          */
> >         if (last.name[last.len] && !want_dir)
> >                 create_flags &=3D ~LOOKUP_CREATE;
> > -       inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
> > -       dentry =3D lookup_one_qstr_excl(&last, path->dentry,
> > -                                     reval_flag | create_flags);
> > +       dentry =3D start_dirop(path->dentry, &last, reval_flag | create_f=
lags);
> >         if (IS_ERR(dentry))
> > -               goto unlock;
> > +               goto out_drop_write;
> >
> >         if (unlikely(error))
> >                 goto fail;
> >
> >         return dentry;
> >  fail:
> > -       dput(dentry);
> > +       end_dirop(dentry);
> >         dentry =3D ERR_PTR(error);
> > -unlock:
> > -       inode_unlock(path->dentry->d_inode);
> > +out_drop_write:
> >         if (!error)
> >                 mnt_drop_write(path->mnt);
> >  out:
> > @@ -4258,9 +4316,7 @@ EXPORT_SYMBOL(start_creating_path);
> >
> >  void end_creating_path(struct path *path, struct dentry *dentry)
> >  {
> > -       if (!IS_ERR(dentry))
> > -               dput(dentry);
> > -       inode_unlock(path->dentry->d_inode);
> > +       end_dirop_mkdir(dentry, path->dentry);
>=20
> I think it is better to open code end_dirop_mkdir()
> here and document semantics of end_creating_path()
> Yes, when you remove the parent lock there will be one
> more place to remove a parent lock, but that place is in fs/namei.c
> not in filesystems code, so I think that's reasonable.
>=20
> >         mnt_drop_write(path->mnt);
> >         path_put(path);
> >  }
> > @@ -4592,8 +4648,7 @@ int do_rmdir(int dfd, struct filename *name)
> >         if (error)
> >                 goto exit2;
> >
> > -       inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
> > -       dentry =3D lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
> > +       dentry =3D start_dirop(path.dentry, &last, lookup_flags);
> >         error =3D PTR_ERR(dentry);
> >         if (IS_ERR(dentry))
> >                 goto exit3;
> > @@ -4602,9 +4657,8 @@ int do_rmdir(int dfd, struct filename *name)
> >                 goto exit4;
> >         error =3D vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, de=
ntry);
> >  exit4:
> > -       dput(dentry);
> > +       end_dirop(dentry);
> >  exit3:
> > -       inode_unlock(path.dentry->d_inode);
> >         mnt_drop_write(path.mnt);
> >  exit2:
> >         path_put(&path);
> > @@ -4705,7 +4759,6 @@ int do_unlinkat(int dfd, struct filename *name)
> >         struct path path;
> >         struct qstr last;
> >         int type;
> > -       struct inode *inode =3D NULL;
> >         struct inode *delegated_inode =3D NULL;
> >         unsigned int lookup_flags =3D 0;
> >  retry:
> > @@ -4721,14 +4774,19 @@ int do_unlinkat(int dfd, struct filename *name)
> >         if (error)
> >                 goto exit2;
> >  retry_deleg:
> > -       inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
> > -       dentry =3D lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
> > +       dentry =3D start_dirop(path.dentry, &last, lookup_flags);
> >         error =3D PTR_ERR(dentry);
>=20
> Maybe it's just me, but possibly
>=20
> if (IS_ERR(dentry))
>         goto exit_drop_write;
>=20
> Could make this code look a bit easier to follow, because...

Maybe...  but that much refactoring really needs to be in a separate
patch.  I was a bit uncomfortable with how much I did already.
Maybe I'll move it all to a follow-up patch.

>=20
> >         if (!IS_ERR(dentry)) {
> > +               struct inode *inode =3D NULL;
> >
> >                 /* Why not before? Because we want correct error value */
> > -               if (last.name[last.len])
> > -                       goto slashes;
> > +               if (unlikely(last.name[last.len])) {
> > +                       if (d_is_dir(dentry))
> > +                               error =3D -EISDIR;
> > +                       else
> > +                               error =3D -ENOTDIR;
> > +                       goto exit3;
> > +               }
> >                 inode =3D dentry->d_inode;
> >                 ihold(inode);
> >                 error =3D security_path_unlink(&path, dentry);
> > @@ -4737,12 +4795,10 @@ int do_unlinkat(int dfd, struct filename *name)
> >                 error =3D vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_=
inode,
> >                                    dentry, &delegated_inode);
> >  exit3:
> > -               dput(dentry);
> > +               end_dirop(dentry);
> > +               if (inode)
> > +                       iput(inode);    /* truncate the inode here */
> >         }
>=20
> The exit3 goto label inside the conditional scope looks
> unconventional and feels wrong.
>=20
> If you do not agree, feel free to ignore this comment.


Thanks a lot,
NeilBrown

