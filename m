Return-Path: <linux-fsdevel+bounces-60444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FA9B46AAF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F73AD7F6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC52E6CB6;
	Sat,  6 Sep 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cPMTMG3K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9mQjnsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189402C21EC
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757151004; cv=none; b=D7LI1JHQFOc8itdFUs7u9HEh/2FSYJu+ZvmDT+tWSNqwWjsfliqiTcVVvNqKLROqp10eSsGgnl8sYbduizsp/vJxL8vDxSwKKq3r4NLl9xJGrypmVHlXqKpXVe1C61hGUFzRBTO/53mZDciCUqIPIFtRFNzKsrtLzWTwTUPr/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757151004; c=relaxed/simple;
	bh=fP4s9K6dzp0NfxKCFMCPa5yIqMIBkakEKixIb6QJfoU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=KIxeb75k2esX+8WnZOmO1KhXTNbebo1QKmQFACKMOO/NAzNS1KoYh66JruCbA8+Un5P5JBb5N8GUavASXZeNhg7mBHrDr3gmzxPMmoyLiC807atIrmVsXS3UIQ77qyXXaunZWzobmIgWusLB7E9Dw3Sb11H8cvtIcB/Idraa6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cPMTMG3K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9mQjnsE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2AC21EC0258;
	Sat,  6 Sep 2025 05:30:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 06 Sep 2025 05:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757151000;
	 x=1757237400; bh=6ng82Mhc31Gg+/Z+DuewVLke1sDGYjFRDD188Uk1QJM=; b=
	cPMTMG3KB0iso9Idzxh1PK9BTeqQ9nWhZ3JSOK1wz9MqyYF/A4qP0LCq9Czpepdy
	fEazX2MnWQTBbR3rf8Qd8xBx3Z3WnBsHA9Q5tSOnjM2UDnna+j/2YvURKz3GMRoW
	8Ei/RgA/cX+wNaFhU1uxaQDd1aqdPzMVlmAa8w8Q0JMF0HBE2PXgC0YvOe3lIcYY
	rvQgC/EBHgh16XhsIjdwc1hW6yFzmOJ1KDJkzDmQhtqTzftvH2sZBSiLBcw1ougy
	0FcrJo8rNZObo/5ttNbYse5XIngXxIKjt5Ousu8UlP/+dQVA+rMKl131ifosh6JQ
	VD4YxjaHDdKY4LcvPOgcNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757151000; x=
	1757237400; bh=6ng82Mhc31Gg+/Z+DuewVLke1sDGYjFRDD188Uk1QJM=; b=Y
	9mQjnsEWlanq47xOBrg0ehRJ1aCZOoiLDKO7LTjjqQlt1zAzn4Vfd5SJarAfQXgt
	rGOrT3Zt10n/hkkm6fAjd9MptwEgBhBGVohyhngZXpjndTwxUdjvFHbU9DSXpvyy
	u3Xu78Vl1+DYM3T+iJWVwmBpMoxFL8tnWfFOOHbE82nIHccrLGXkrfjDtpTgN479
	lgnvtWe5RhtQBOp+J1gwHQLLPlL8D5NGKahLRTGvSehLPkjEnLQSVXGjEVTm43gn
	1bWl+Dd2F4gQOC2ATIN7YDmsVPbVvxeS1EPoJvgCzDYfsgzQ4CMBMwgflgV0Uvo7
	GYIztYpV/hXi6TFHZ8FJg==
X-ME-Sender: <xms:F_-7aGbPqosK7t0JpBmdSxue9yB5X8R6AOhJp2ahD4PO152-C6KaWg>
    <xme:F_-7aHU6UerMYIrcZkbsmBvKXq9kFSDajmddTE1pMSDTyfsA7Xd7rCRjvGSI_YtJ1
    Vfp2zcC8wuoCQ>
X-ME-Received: <xmr:F_-7aDRDaBAxsuSMLhkGL0LaQiWFubhWj_gUSz6OTCI4Ff6mb9IEyRrMO9oxZgcCyd-DTuzltFrF6-ZgHGV6PTDB-1OErTZrPRpzTYCpO0x0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffksehtqhertddttdejnecuhfhrohhmpedfpfgvihhluehr
    ohifnhdfuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epueffkeetfeffieevfefgledukeelgfelveejteeutdduffduuedujeetteehffefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:F_-7aNOveP1BCwBFuR1b_J2gKC7ODGrNqg1Z-Wb26Gy_D89KtU5jcw>
    <xmx:F_-7aJTey05RoC0Bc8jDdRkyUxtkWx_nURZQ33FY5kv7vs9f4VMEmw>
    <xmx:F_-7aDiMrKXapUVBwoXlZwIprr7jZ-1F7hbBoEjonJr9ET4srlh9Ww>
    <xmx:F_-7aK8iQvNukL5G-QEZQD3lX_L7VXT6Sa4aLfEZATF3-r80nfNzTA>
    <xmx:GP-7aLzVqVA2GSCvT8iBdgag6pMAIjbSPkmZxc1Y55iyOF8gB0KFBz_A>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 05:29:57 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH 6/6] VFS: rename kern_path_locked() to kern_path_removing()
In-reply-to:
 <CAOQ4uxj_JAT6ctwGkw-jVm0_9GDmzcAhL4yVFpxm=1mZ0oWceQ@mail.gmail.com>
References:
 <>, <CAOQ4uxj_JAT6ctwGkw-jVm0_9GDmzcAhL4yVFpxm=1mZ0oWceQ@mail.gmail.com>
Date: Sat, 06 Sep 2025 19:29:54 +1000
Message-id: <175715099454.2850467.15900619784045413971@noble.neil.brown.name>

On Sat, 06 Sep 2025, Amir Goldstein wrote:
> On Sat, Sep 6, 2025 at 7:01=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > Also rename user_path_locked_at() to user_path_removing_at()
> >
> > Add done_path_removing() to clean up after these calls.
> >
> > The only credible need for a locked positive dentry is to remove it, so
> > make that explicit in the name.
>=20
> That's a pretty bold statement...

True - but it appears to be the case.

>=20
> I generally like the done_ abstraction that could be also used as a guard
> cleanup helper.
>=20
> The problem I have with this is that {kern,done}_path_removing rhymes with
> {kern,done}_path_create, while in fact they are very different.

As far as I can see the only difference is that one prepares to remove
an object and the other prepares to create an object - as reflected in
the names.

What other difference do you see?

>=20
> What is the motivation for the function rename (you did not specify it)?
> Is it just because done_path_locked() sounds weird or something else?

Making the name more specific discourages misuse.  It also highlights
the similarity to kern_path_create (which obviously works because you
noticed it).

This also prepares readers for when they see my next series which adds
start_creating and start_removing (with _noperm and _killable options
and end_foo()) so that they will think "oh, this fits an established
pattern - good".

Note that I chose "end_" for symmetry with end_creating() in debugfs and
tracefs_end_creating() which already exist.
Maybe they should be changed to "done_" but I'm not so keen on done_ as
if there was an error then it wasn't "done".  And end_ matches start_
better than done_.  They mark the start and end of a code fragment which
tries to create or remove (or rename - I have a selection of
start_renaming options too).
(simple_start_creating() was introduced a few months ago and I'm basing
 some of my naming choices on that).

Maybe kern_path_create() should be renamed to start_path_creating().
We don't really need the "kern" - that is the default.


>=20
> I wonder if using guard semantics could be the better choice if
> looking to clarify the code.

Al suggested in reply to a previous patch that RAII (aka guard etc)
should be added separately so it can be reviewed separately.

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  Documentation/filesystems/porting.rst | 10 ++++++++++
> >  drivers/base/devtmpfs.c               | 12 ++++--------
> >  fs/bcachefs/fs-ioctl.c                |  6 ++----
> >  fs/namei.c                            | 23 +++++++++++++++++------
> >  include/linux/namei.h                 |  5 +++--
> >  5 files changed, 36 insertions(+), 20 deletions(-)
> >
> > diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> > index 85f590254f07..defbae457310 100644
> > --- a/Documentation/filesystems/porting.rst
> > +++ b/Documentation/filesystems/porting.rst
> > @@ -1285,3 +1285,13 @@ rather than a VMA, as the VMA at this stage is not=
 yet valid.
> >  The vm_area_desc provides the minimum required information for a filesys=
tem
> >  to initialise state upon memory mapping of a file-backed region, and out=
put
> >  parameters for the file system to set this state.
> > +
> > +---
> > +
> > +**mandatory**
> > +
> > +kern_path_locked and user_path_locked_at() are renamed to
> > +kern_path_removing() and user_path_removing_at() and should only
> > +be used when removing a name.  done_path_removing() should be called
> > +after removal.
> > +
> > diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> > index 31bfb3194b4c..26d0beead1f0 100644
> > --- a/drivers/base/devtmpfs.c
> > +++ b/drivers/base/devtmpfs.c
> > @@ -256,7 +256,7 @@ static int dev_rmdir(const char *name)
> >         struct dentry *dentry;
> >         int err;
> >
> > -       dentry =3D kern_path_locked(name, &parent);
> > +       dentry =3D kern_path_removing(name, &parent);
> >         if (IS_ERR(dentry))
> >                 return PTR_ERR(dentry);
> >         if (d_inode(dentry)->i_private =3D=3D &thread)
> > @@ -265,9 +265,7 @@ static int dev_rmdir(const char *name)
> >         else
> >                 err =3D -EPERM;
> >
> > -       dput(dentry);
> > -       inode_unlock(d_inode(parent.dentry));
> > -       path_put(&parent);
> > +       done_path_removing(dentry, &parent);
> >         return err;
> >  }
> >
> > @@ -325,7 +323,7 @@ static int handle_remove(const char *nodename, struct=
 device *dev)
> >         int deleted =3D 0;
> >         int err =3D 0;
> >
> > -       dentry =3D kern_path_locked(nodename, &parent);
> > +       dentry =3D kern_path_removing(nodename, &parent);
> >         if (IS_ERR(dentry))
> >                 return PTR_ERR(dentry);
> >
> > @@ -349,10 +347,8 @@ static int handle_remove(const char *nodename, struc=
t device *dev)
> >                 if (!err || err =3D=3D -ENOENT)
> >                         deleted =3D 1;
> >         }
> > -       dput(dentry);
> > -       inode_unlock(d_inode(parent.dentry));
> > +       done_path_removing(dentry, &parent);
> >
> > -       path_put(&parent);
> >         if (deleted && strchr(nodename, '/'))
> >                 delete_path(nodename);
> >         return err;
> > diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
> > index 4e72e654da96..9446cefbe249 100644
> > --- a/fs/bcachefs/fs-ioctl.c
> > +++ b/fs/bcachefs/fs-ioctl.c
> > @@ -334,7 +334,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_f=
s *c, struct file *filp,
> >         if (arg.flags)
> >                 return -EINVAL;
> >
> > -       victim =3D user_path_locked_at(arg.dirfd, name, &path);
> > +       victim =3D user_path_removing_at(arg.dirfd, name, &path);
> >         if (IS_ERR(victim))
> >                 return PTR_ERR(victim);
> >
> > @@ -351,9 +351,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_f=
s *c, struct file *filp,
> >                 d_invalidate(victim);
> >         }
> >  err:
> > -       inode_unlock(dir);
> > -       dput(victim);
> > -       path_put(&path);
> > +       done_path_removing(victim, &path);
> >         return ret;
> >  }
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 104015f302a7..c750820b27b9 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2757,7 +2757,8 @@ static int filename_parentat(int dfd, struct filena=
me *name,
> >  }
> >
> >  /* does lookup, returns the object with parent locked */
> > -static struct dentry *__kern_path_locked(int dfd, struct filename *name,=
 struct path *path)
> > +static struct dentry *__kern_path_removing(int dfd, struct filename *nam=
e,
> > +                                          struct path *path)
> >  {
> >         struct path parent_path __free(path_put) =3D {};
> >         struct dentry *d;
> > @@ -2815,24 +2816,34 @@ struct dentry *kern_path_parent(const char *name,=
 struct path *path)
> >         return d;
> >  }
> >
> > -struct dentry *kern_path_locked(const char *name, struct path *path)
> > +struct dentry *kern_path_removing(const char *name, struct path *path)
> >  {
> >         struct filename *filename =3D getname_kernel(name);
> > -       struct dentry *res =3D __kern_path_locked(AT_FDCWD, filename, pat=
h);
> > +       struct dentry *res =3D __kern_path_removing(AT_FDCWD, filename, p=
ath);
> >
> >         putname(filename);
> >         return res;
> >  }
> >
> > -struct dentry *user_path_locked_at(int dfd, const char __user *name, str=
uct path *path)
> > +void done_path_removing(struct dentry *dentry, struct path *path)
> > +{
> > +       if (!IS_ERR(dentry)) {
> > +               inode_unlock(path->dentry->d_inode);
> > +               dput(dentry);
> > +               path_put(path);
> > +       }
> > +}
> > +EXPORT_SYMBOL(done_path_removing);
> > +
> > +struct dentry *user_path_removing_at(int dfd, const char __user *name, s=
truct path *path)
> >  {
> >         struct filename *filename =3D getname(name);
> > -       struct dentry *res =3D __kern_path_locked(dfd, filename, path);
> > +       struct dentry *res =3D __kern_path_removing(dfd, filename, path);
> >
> >         putname(filename);
> >         return res;
> >  }
> > -EXPORT_SYMBOL(user_path_locked_at);
> > +EXPORT_SYMBOL(user_path_removing_at);
> >
> >  int kern_path(const char *name, unsigned int flags, struct path *path)
> >  {
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 1d5038c21c20..37568f8055f9 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -62,8 +62,9 @@ struct dentry *kern_path_parent(const char *name, struc=
t path *parent);
> >  extern struct dentry *kern_path_create(int, const char *, struct path *,=
 unsigned int);
> >  extern struct dentry *user_path_create(int, const char __user *, struct =
path *, unsigned int);
> >  extern void done_path_create(struct path *, struct dentry *);
> > -extern struct dentry *kern_path_locked(const char *, struct path *);
> > -extern struct dentry *user_path_locked_at(int , const char __user *, str=
uct path *);
> > +extern struct dentry *kern_path_removing(const char *, struct path *);
> > +extern struct dentry *user_path_removing_at(int , const char __user *, s=
truct path *);
> > +void done_path_removing(struct dentry *dentry, struct path *path);
> >  int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
> >                            struct path *parent, struct qstr *last, int *t=
ype,
> >                            const struct path *root);
> > --
> > 2.50.0.107.gf914562f5916.dirty
> >
>=20


