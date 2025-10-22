Return-Path: <linux-fsdevel+bounces-65020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E14CBF9D21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F56B503684
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 03:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9E623D288;
	Wed, 22 Oct 2025 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="FIpPBigd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yqdFIpEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1D21B195
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103272; cv=none; b=ZqFakCcVx3tM//WJ4WA9p5GthB2vd1s0Dm3b5TTnQrak7DLx2BLfk6pNJ0E4mvJTBG11U38tRxmMmYZntfjCStXOytUackltFXWccTviTqro0KcXVXgnCXZrrgOoOTHNLHHiM3Sw1Q1UvP2LDlmazGqKts/wOGpPDGAwb5iHhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103272; c=relaxed/simple;
	bh=5WTwVCJzxsKIkRA9pKseP3C408Kh5F/ymXEmzRxZ29g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=dFX/tI+U2Tu6rWA4KQx+LRL1FWiQFpueOplNLv+0C5Hk/xlVw8DlxAhQOj39nZ0UBY/dJYsBVYUOPsx+UXyShsfx8GYuVnIPfpmQYad1CuS+btx6I8iwKyjT/aIaLif2lKRO8cp0ZVQGreTuztrO+PbepxMdDry2MURDEWdGAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FIpPBigd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yqdFIpEg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CA757140003A;
	Tue, 21 Oct 2025 23:21:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 23:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1761103265; x=1761189665; bh=OfbAffNay3BF53rdOt60MWyLl3rKDNk3rBB
	yPNTvz38=; b=FIpPBigdiFs1ITZ0D6wKlxNnPTnXj8z4ciDc8oovyHLo93aW7wQ
	AGTO5XBIbct/77B+Dk7dq3Hndm7DhF2iOAwS3P/SbBPe6ODjHRldIeohcOYvLwQw
	rpWwzuByXZE1DkEF1LtcrtP4Wxy+GHKdieUuuFPeFynBRx9z5Bb1MBvSMURyBZLs
	odWq9JK8FJ7Wc6QHgav/3qdCQ39tohKVPzT/37Ji1IabIVsz+AhMHfuUgB6lEyiz
	wt+fsxHJN/QeeQoEsmc5TXbIAkOBhgXtheJ0cJDsk9DT0uEBq1CpjBsNjR+1rOy5
	vZ1/lBth/eyG4YbGXQP4VerzgwAIm81Mp2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761103265; x=
	1761189665; bh=OfbAffNay3BF53rdOt60MWyLl3rKDNk3rBByPNTvz38=; b=y
	qdFIpEg+FOQBmnnbuzrjmnk/n83I6emY/IAJT6RZfA3ycY/EWIXPwNCm4Ou8qtHG
	Ny9CB56QRwA18KVquZbqM++nnbM4JIsadIgQjZDX9wBC40jGlgzfL5KiPoVFp1Ik
	1tedF/73R7Q793+z9hZKmiluMn8aKJa8krsCmVhOnN1yLIooZeRHnMFH0TDFDj1c
	DQH9YyPQy6/i2rJ4Jj4IWm5OmTOJximrpLZNzSbWDv8VomG+yCeQZJ8LNbX9qR3T
	m8ojPyVFMdcggiBmUilZXrXKK5nBtcAUQtTWXVzl4+TFWXlh7YMSUl+BtJidR/H6
	7lTvqHPpx6r2xfgMKYRkw==
X-ME-Sender: <xms:oU34aFI4BUMcj5adl6RcQgHaCFLPo-IGo6czS_NGu78z3xCooHiL6A>
    <xme:oU34aMHFmtD6mnLWKj8A5WxonF-5QiV6_xDRUavz7BwYl8_s-PlSJR145TbKZQv3B
    XB7Nnl_WZIgBD5fqFqd2giy2EBv0gGzfD2LQHOQr4GAtAvELqQ>
X-ME-Received: <xmr:oU34aMsPhpkCES6zvcUEm29Z-wQP4F1GNujfIN_DAHyN0x6uQF5ZO4tU3Wyk6tk9BcQdE2YUkZ-YyO_PH9fJHb2RIWpSjJJj1vg1yR-ZXL2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oU34aLsfN2g6gczWMSKMGwXIX8tYB6ar_blBb_bEzc5b3LuZzdSIwg>
    <xmx:oU34aKBgojvmjm-PlDviO4ugBUFs2H_0K91nW5q2xB3dpGh0H7XimA>
    <xmx:oU34aFNSIqk6oVe1Asd3bPI7P9OYjYDasoaElNCy6jB8caPqWB8zBQ>
    <xmx:oU34aLxzzP8cCoJS7QOHZ9Y2dsBm9fz1RX1EF_BbmyEYyXRiiRbIDA>
    <xmx:oU34aMg-lM3UbT5OuxXCcMqRDYcw7kwnxhh0tgX5vhPPd6pl549fk-yk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:21:03 -0400 (EDT)
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
Subject: Re: [PATCH v2 06/14] VFS: introduce start_creating_noperm() and
 start_removing_noperm()
In-reply-to:
 <CAOQ4uxgRx_QLJ9PbRqNHJn_=s59bD1RHjcvU1GCCyGbe6uJ_cA@mail.gmail.com>
References: <20251015014756.2073439-1-neilb@ownmail.net>,
 <20251015014756.2073439-7-neilb@ownmail.net>,
 <CAOQ4uxgRx_QLJ9PbRqNHJn_=s59bD1RHjcvU1GCCyGbe6uJ_cA@mail.gmail.com>
Date: Wed, 22 Oct 2025 14:20:58 +1100
Message-id: <176110325819.1793333.7313372661279156904@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 19 Oct 2025, Amir Goldstein wrote:
> On Wed, Oct 15, 2025 at 3:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > xfs, fuse, ipc/mqueue need variants of start_creating or start_removing
> > which do not check permissions.
> > This patch adds _noperm versions of these functions.
> >
> > Note that do_mq_open() was only calling mntget() so it could call
> > path_put() - it didn't really need an extra reference on the mnt.
> > Now it doesn't call mntget() and uses end_creating() which does
> > the dput() half of path_put().
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> I noticed that both Jeff and I had already given our RVB on v1
> and it's not here, so has this patch changed in some fundamental way since =
v1?
> I could really use a "changed since v1" section when that happens.
>=20
> Otherwise, feel free to add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I hadn't changed anything.  I think I started looking at your
suggestions about documentation changes and the fact that mq_unlink()
passes d_inode(dentry->d_parent) to vfs_unlink() ....  and got
distracted.=20

I've added both reviewed-bys (thanks) and changes mq_unlink() to pass
d_inode(mnt->mnt_root) (using the same dentry as was given to
lookup_noperm).

I've also fixed the bug kernel-test-robot reported.

Thanks,
NeilBrown


>=20
> > ---
> >  fs/fuse/dir.c            | 19 +++++++---------
> >  fs/namei.c               | 48 ++++++++++++++++++++++++++++++++++++++++
> >  fs/xfs/scrub/orphanage.c | 11 ++++-----
> >  include/linux/namei.h    |  2 ++
> >  ipc/mqueue.c             | 31 +++++++++-----------------
> >  5 files changed, 73 insertions(+), 38 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index ecaec0fea3a1..40ca94922349 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1397,27 +1397,25 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc=
, u64 parent_nodeid,
> >         if (!parent)
> >                 return -ENOENT;
> >
> > -       inode_lock_nested(parent, I_MUTEX_PARENT);
> >         if (!S_ISDIR(parent->i_mode))
> > -               goto unlock;
> > +               goto put_parent;
> >
> >         err =3D -ENOENT;
> >         dir =3D d_find_alias(parent);
> >         if (!dir)
> > -               goto unlock;
> > +               goto put_parent;
> >
> > -       name->hash =3D full_name_hash(dir, name->name, name->len);
> > -       entry =3D d_lookup(dir, name);
> > +       entry =3D start_removing_noperm(dir, name);
> >         dput(dir);
> > -       if (!entry)
> > -               goto unlock;
> > +       if (IS_ERR(entry))
> > +               goto put_parent;
> >
> >         fuse_dir_changed(parent);
> >         if (!(flags & FUSE_EXPIRE_ONLY))
> >                 d_invalidate(entry);
> >         fuse_invalidate_entry_cache(entry);
> >
> > -       if (child_nodeid !=3D 0 && d_really_is_positive(entry)) {
> > +       if (child_nodeid !=3D 0) {
> >                 inode_lock(d_inode(entry));
> >                 if (get_node_id(d_inode(entry)) !=3D child_nodeid) {
> >                         err =3D -ENOENT;
> > @@ -1445,10 +1443,9 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc,=
 u64 parent_nodeid,
> >         } else {
> >                 err =3D 0;
> >         }
> > -       dput(entry);
> >
> > - unlock:
> > -       inode_unlock(parent);
> > +       end_removing(entry);
> > + put_parent:
> >         iput(parent);
> >         return err;
> >  }
> > diff --git a/fs/namei.c b/fs/namei.c
> > index ae833dfa277c..696e4b794416 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3275,6 +3275,54 @@ struct dentry *start_removing(struct mnt_idmap *id=
map, struct dentry *parent,
> >  }
> >  EXPORT_SYMBOL(start_removing);
> >
> > +/**
> > + * start_creating_noperm - prepare to create a given name without permis=
sion checking
> > + * @parent: directory in which to prepare to create the name
> > + * @name:   the name to be created
> > + *
> > + * Locks are taken and a lookup in performed prior to creating
> > + * an object in a directory.
> > + *
> > + * If the name already exists, a positive dentry is returned.
> > + *
> > + * Returns: a negative or positive dentry, or an error.
> > + */
> > +struct dentry *start_creating_noperm(struct dentry *parent,
> > +                                    struct qstr *name)
> > +{
> > +       int err =3D lookup_noperm_common(name, parent);
> > +
> > +       if (err)
> > +               return ERR_PTR(err);
> > +       return start_dirop(parent, name, LOOKUP_CREATE);
> > +}
> > +EXPORT_SYMBOL(start_creating_noperm);
> > +
> > +/**
> > + * start_removing_noperm - prepare to remove a given name without permis=
sion checking
> > + * @parent: directory in which to find the name
> > + * @name:   the name to be removed
> > + *
> > + * Locks are taken and a lookup in performed prior to removing
> > + * an object from a directory.
> > + *
> > + * If the name doesn't exist, an error is returned.
> > + *
> > + * end_removing() should be called when removal is complete, or aborted.
> > + *
> > + * Returns: a positive dentry, or an error.
> > + */
> > +struct dentry *start_removing_noperm(struct dentry *parent,
> > +                                    struct qstr *name)
> > +{
> > +       int err =3D lookup_noperm_common(name, parent);
> > +
> > +       if (err)
> > +               return ERR_PTR(err);
> > +       return start_dirop(parent, name, 0);
> > +}
> > +EXPORT_SYMBOL(start_removing_noperm);
> > +
> >  #ifdef CONFIG_UNIX98_PTYS
> >  int path_pts(struct path *path)
> >  {
> > diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> > index 9c12cb844231..e732605924a1 100644
> > --- a/fs/xfs/scrub/orphanage.c
> > +++ b/fs/xfs/scrub/orphanage.c
> > @@ -152,11 +152,10 @@ xrep_orphanage_create(
> >         }
> >
> >         /* Try to find the orphanage directory. */
> > -       inode_lock_nested(root_inode, I_MUTEX_PARENT);
> > -       orphanage_dentry =3D lookup_noperm(&QSTR(ORPHANAGE), root_dentry);
> > +       orphanage_dentry =3D start_creating_noperm(root_dentry, &QSTR(ORP=
HANAGE));
> >         if (IS_ERR(orphanage_dentry)) {
> >                 error =3D PTR_ERR(orphanage_dentry);
> > -               goto out_unlock_root;
> > +               goto out_dput_root;
> >         }
> >
> >         /*
> > @@ -170,7 +169,7 @@ xrep_orphanage_create(
> >                                              orphanage_dentry, 0750);
> >                 error =3D PTR_ERR(orphanage_dentry);
> >                 if (IS_ERR(orphanage_dentry))
> > -                       goto out_unlock_root;
> > +                       goto out_dput_orphanage;
> >         }
> >
> >         /* Not a directory? Bail out. */
> > @@ -200,9 +199,7 @@ xrep_orphanage_create(
> >         sc->orphanage_ilock_flags =3D 0;
> >
> >  out_dput_orphanage:
> > -       dput(orphanage_dentry);
> > -out_unlock_root:
> > -       inode_unlock(VFS_I(sc->mp->m_rootip));
> > +       end_creating(orphanage_dentry, root_dentry);
> >  out_dput_root:
> >         dput(root_dentry);
> >  out:
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 9ee76e88f3dd..688e157d6afc 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -92,6 +92,8 @@ struct dentry *start_creating(struct mnt_idmap *idmap, =
struct dentry *parent,
> >                               struct qstr *name);
> >  struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> >                               struct qstr *name);
> > +struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
> > +struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
> >
> >  /**
> >   * end_creating - finish action started with start_creating
> > diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> > index 093551fe66a7..060e8e9c4f59 100644
> > --- a/ipc/mqueue.c
> > +++ b/ipc/mqueue.c
> > @@ -913,13 +913,11 @@ static int do_mq_open(const char __user *u_name, in=
t oflag, umode_t mode,
> >                 goto out_putname;
> >
> >         ro =3D mnt_want_write(mnt);       /* we'll drop it in any case */
> > -       inode_lock(d_inode(root));
> > -       path.dentry =3D lookup_noperm(&QSTR(name->name), root);
> > +       path.dentry =3D start_creating_noperm(root, &QSTR(name->name));
> >         if (IS_ERR(path.dentry)) {
> >                 error =3D PTR_ERR(path.dentry);
> >                 goto out_putfd;
> >         }
> > -       path.mnt =3D mntget(mnt);
> >         error =3D prepare_open(path.dentry, oflag, ro, mode, name, attr);
> >         if (!error) {
> >                 struct file *file =3D dentry_open(&path, oflag, current_c=
red());
> > @@ -928,13 +926,12 @@ static int do_mq_open(const char __user *u_name, in=
t oflag, umode_t mode,
> >                 else
> >                         error =3D PTR_ERR(file);
> >         }
> > -       path_put(&path);
> >  out_putfd:
> >         if (error) {
> >                 put_unused_fd(fd);
> >                 fd =3D error;
> >         }
> > -       inode_unlock(d_inode(root));
> > +       end_creating(path.dentry, root);
> >         if (!ro)
> >                 mnt_drop_write(mnt);
> >  out_putname:
> > @@ -957,7 +954,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_nam=
e)
> >         int err;
> >         struct filename *name;
> >         struct dentry *dentry;
> > -       struct inode *inode =3D NULL;
> > +       struct inode *inode;
> >         struct ipc_namespace *ipc_ns =3D current->nsproxy->ipc_ns;
> >         struct vfsmount *mnt =3D ipc_ns->mq_mnt;
> >
> > @@ -969,26 +966,20 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_n=
ame)
> >         err =3D mnt_want_write(mnt);
> >         if (err)
> >                 goto out_name;
> > -       inode_lock_nested(d_inode(mnt->mnt_root), I_MUTEX_PARENT);
> > -       dentry =3D lookup_noperm(&QSTR(name->name), mnt->mnt_root);
> > +       dentry =3D start_removing_noperm(mnt->mnt_root, &QSTR(name->name)=
);
> >         if (IS_ERR(dentry)) {
> >                 err =3D PTR_ERR(dentry);
> > -               goto out_unlock;
> > +               goto out_drop_write;
> >         }
> >
> >         inode =3D d_inode(dentry);
> > -       if (!inode) {
> > -               err =3D -ENOENT;
> > -       } else {
> > -               ihold(inode);
> > -               err =3D vfs_unlink(&nop_mnt_idmap, d_inode(dentry->d_pare=
nt),
> > -                                dentry, NULL);
> > -       }
> > -       dput(dentry);
> > -
> > -out_unlock:
> > -       inode_unlock(d_inode(mnt->mnt_root));
> > +       ihold(inode);
> > +       err =3D vfs_unlink(&nop_mnt_idmap, d_inode(dentry->d_parent),
> > +                        dentry, NULL);
> > +       end_removing(dentry);
> >         iput(inode);
> > +
> > +out_drop_write:
> >         mnt_drop_write(mnt);
> >  out_name:
> >         putname(name);
> > --
> > 2.50.0.107.gf914562f5916.dirty
> >
>=20


