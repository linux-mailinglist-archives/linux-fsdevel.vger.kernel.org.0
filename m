Return-Path: <linux-fsdevel+bounces-62932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0E7BA5E95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 13:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEAB7AD93F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A097C2DF715;
	Sat, 27 Sep 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eboe/dfV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qe+NBdA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA12253A0
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758974169; cv=none; b=GitKjw5B6sRDHoRHC2qnBxITee748S0MBkMeBdOQBByTfn+makX+AimEZO7lPrGUhDPr0vEDiAmWDCNti/iH+p1BfrDT6yL8vzjkJQzmUcYiQSGdoMhSIMSGieyIGSspNfoRqZbjpuEzVzTlPHR+nrcQsR5behafOS+KLsem01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758974169; c=relaxed/simple;
	bh=O3j3+rEUMZhHC+I7d/zG4MkuWaSos0u2FACTmf8eZ2Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NzH7bQsuv4etTqVn828yOMrJnhHcH2rEZ5HB3OoyRgNhUSLnZ6Ed5ixnC5z3gX0GVI+8RYd9uVTQ71Kx1+eE5p6emEQEZ80bhkwRQx2FPtXjFsJXFmTGnv6JkgOGXaJH5cx3uCQrCB/lmO6m0sax1yr18D/1A0Pf2A08H4RBK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eboe/dfV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qe+NBdA8; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 465287A00A7;
	Sat, 27 Sep 2025 07:56:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 27 Sep 2025 07:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1758974163; x=1759060563; bh=Fsj3a8+k646vdF5VX/yUiqIFTU96kq9IV7W
	JMB6or1E=; b=eboe/dfV4Oic89Alaz3w8fTo+mInuIqmMGwa7aId1W2YCs0OFos
	R5/CJIICbMMvifOZxVJ4DNatdvluIoaZFFs4JlsVYa4MDNV7NC73gBedsNjbFC13
	HlgBmDl9BJ3wTlqW/xlf7hfA09m9ZNL3tn/7j0qLwnQT2vD1nmsroTdmfXCXj5S8
	jxUQNFhRqIsTY/9syWGM6rxGLLp/1FakS85zbYnfAY1k1RDakEIgdCVxn/DxOpyq
	asrJw9KmoOhLgxnsNV4+aWDuJ+p3hayudssKkJuTXx6h02TtPONJj4huvL632NO+
	pUkVREZM4vxx4CSmw8vLnVmU9FEmEXNOFHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758974163; x=
	1759060563; bh=Fsj3a8+k646vdF5VX/yUiqIFTU96kq9IV7WJMB6or1E=; b=q
	e+NBdA8Y01A0skPgKKnbj5U7QaO2jiObtfQESSKa2sSgldLy66QXvlG/ReaBWjLK
	BUv/2K2xcLEpFL7tF/o+piuO2s7vUtgshZYuIpn4WblJJHeNF1C7k5EXXEPdiK9O
	2EKRUskoJz302IEm4vMKf/wHom4eejXWVZBdlKQ+/Y5jTynXJvk1x9RotmQaLsPf
	LyuiBlCWA/FN0KaQ2Ps7UxsDBMxqxgrAQ981WtTDSX4cN8dpljPzm9jyXnPR/nMx
	lVfsaVFP9FZzvC31mfytSwUnhl+dloN1aPBJHc7rGIN+79RF04cSKQtlanakyzE7
	amYNCmjHiKpvEog2Xco9w==
X-ME-Sender: <xms:0tDXaFIsRidq0fR-q8tzitkvHwzGj8SbIdOV6RKTCrGCHYc4aTopIQ>
    <xme:0tDXaMGpektgJxR1MqjnVc0pQFVXknEgxQndtIpocWc_noShXKyRiGkA1NRKHsaWT
    sLgYUZx8eHkWqjHAd4NoEn8zQWC2VJ8LYgcyLx5ZohP5JTM>
X-ME-Received: <xmr:0tDXaMsjskH7qy90kPSwewB10qTmz1cHe91CLi09OEQs9sfdtQfObXbmMR5YBnPLUAsSjihG4B9-N92-q08iDu3OwdCE6uuV4jm0AHMZpLy7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvddukecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:0tDXaLuj8wyAP44y_TNS0vc6ohBWC8kYCsGuxsLN8yeY3N2mHBiJbA>
    <xmx:0tDXaKCUfm53ghZsIMHKyTlxZqHLePteTDbf_ngOQA3BVNGF5oJHLw>
    <xmx:0tDXaFN2nBfIDvmrNvEAqr2o6kX5mS_lfOrZgYHVjQuryyPy220c3w>
    <xmx:0tDXaLzHJfbapjaijEY7tg7sfmcHVn16IysDL-8qt5qlQveFL6XVMA>
    <xmx:09DXaI_2O2VEoAx4A2u1CZP_Vc9xw4sgddQzOGQsznqalmBkyPU5BUcR>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 07:55:59 -0400 (EDT)
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
Subject: Re: [PATCH 06/11] VFS: introduce start_removing_dentry()
In-reply-to:
 <CAOQ4uxjq9+9DgEsmB=PS95CN+j0ft8sr4n70FtoeKPTAcJG-rA@mail.gmail.com>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <20250926025015.1747294-7-neilb@ownmail.net>,
 <CAOQ4uxjq9+9DgEsmB=PS95CN+j0ft8sr4n70FtoeKPTAcJG-rA@mail.gmail.com>
Date: Sat, 27 Sep 2025 21:55:57 +1000
Message-id: <175897415709.1696783.15714806988614290926@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 27 Sep 2025, Amir Goldstein wrote:
> On Fri, Sep 26, 2025 at 4:50=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > start_removing_dentry() is similar to start_removing() but instead of
> > providing a name for lookup, the target dentry is given.
> >
> > start_removing_dentry() checks that the dentry is still hashed and in
> > the parent, and if so it locks and increases the refcount so that
> > end_removing() can be used to finish the operation.
> >
> > This is used in cachefiles, overlayfs, smb/server, and apparmor.
> >
> > There will be other users including ecryptfs.
> >
> > As start_removing_dentry() takes an extra reference to the dentry (to be
> > put by end_removing()), there is no need to explicitly take an extra
> > reference to stop d_delete() from using dentry_unlink_inode() to negate
> > the dentry - as in cachefiles_delete_object(), and ksmbd_vfs_unlink().
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> Feel free to add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>=20
> After answering/fixing the questions below...
>=20
> > ---
> >  fs/cachefiles/interface.c      | 14 +++++++++-----
> >  fs/cachefiles/namei.c          | 22 ++++++++++++----------
> >  fs/cachefiles/volume.c         | 10 +++++++---
> >  fs/namei.c                     | 29 +++++++++++++++++++++++++++++
> >  fs/overlayfs/dir.c             | 10 ++++------
> >  fs/overlayfs/readdir.c         |  8 ++++----
> >  fs/smb/server/vfs.c            | 27 ++++-----------------------
> >  include/linux/namei.h          |  2 ++
> >  security/apparmor/apparmorfs.c |  8 ++++----
> >  9 files changed, 75 insertions(+), 55 deletions(-)
> >
> > diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
> > index 3e63cfe15874..3f8a6f1a8fc3 100644
> > --- a/fs/cachefiles/interface.c
> > +++ b/fs/cachefiles/interface.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/mount.h>
> >  #include <linux/xattr.h>
> >  #include <linux/file.h>
> > +#include <linux/namei.h>
> >  #include <linux/falloc.h>
> >  #include <trace/events/fscache.h>
> >  #include "internal.h"
> > @@ -428,11 +429,14 @@ static bool cachefiles_invalidate_cookie(struct fsc=
ache_cookie *cookie)
> >                 if (!old_tmpfile) {
> >                         struct cachefiles_volume *volume =3D object->volu=
me;
> >                         struct dentry *fan =3D volume->fanout[(u8)cookie-=
>key_hash];
> > -
> > -                       inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
> > -                       cachefiles_bury_object(volume->cache, object, fan,
> > -                                              old_file->f_path.dentry,
> > -                                              FSCACHE_OBJECT_INVALIDATED=
);
> > +                       struct dentry *obj;
> > +
> > +                       obj =3D start_removing_dentry(fan, old_file->f_pa=
th.dentry);
> > +                       if (!IS_ERR(obj))
> > +                               cachefiles_bury_object(volume->cache, obj=
ect,
> > +                                                      fan, obj,
> > +                                                      FSCACHE_OBJECT_INV=
ALIDATED);
> > +                       end_removing(obj);
> >                 }
> >                 fput(old_file);
> >         }
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index 3064d439807b..80a3055d8ae5 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -424,13 +424,12 @@ int cachefiles_delete_object(struct cachefiles_obje=
ct *object,
> >
> >         _enter(",OBJ%x{%pD}", object->debug_id, object->file);
> >
> > -       /* Stop the dentry being negated if it's only pinned by a file st=
ruct. */
> > -       dget(dentry);
> > -
> > -       inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
> > -       ret =3D cachefiles_unlink(volume->cache, object, fan, dentry, why=
);
> > -       inode_unlock(d_backing_inode(fan));
> > -       dput(dentry);
> > +       dentry =3D start_removing_dentry(fan, dentry);
> > +       if (IS_ERR(dentry))
> > +               ret =3D PTR_ERR(dentry);
> > +       else
> > +               ret =3D cachefiles_unlink(volume->cache, object, fan, den=
try, why);
> > +       end_removing(dentry);
> >         return ret;
> >  }
> >
> > @@ -643,9 +642,12 @@ bool cachefiles_look_up_object(struct cachefiles_obj=
ect *object)
> >
> >         if (!d_is_reg(dentry)) {
> >                 pr_err("%pd is not a file\n", dentry);
> > -               inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
> > -               ret =3D cachefiles_bury_object(volume->cache, object, fan=
, dentry,
> > -                                            FSCACHE_OBJECT_IS_WEIRD);
> > +               struct dentry *de =3D start_removing_dentry(fan, dentry);
> > +               if (!IS_ERR(de))
>=20
> I see that other callers do not check return value from
> cachefiles_bury_object(), but this call site does.
> Shouldn't we treat this error as well (assign it to ret)?

Yes, that make sense.

 if (IS_ERR(de))
     ret =3D PTR_ERR(de);
 else
     ret =3D cachefiles_bury_object(.....)

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20
> > +                       ret =3D cachefiles_bury_object(volume->cache, obj=
ect,
> > +                                                    fan, de,
> > +                                                    FSCACHE_OBJECT_IS_WE=
IRD);
> > +               end_removing(de);
> >                 dput(dentry);
> >                 if (ret < 0)
> >                         return false;
> > diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
> > index 781aac4ef274..ddf95ff5daf0 100644
> > --- a/fs/cachefiles/volume.c
> > +++ b/fs/cachefiles/volume.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/fs.h>
> >  #include <linux/slab.h>
> > +#include <linux/namei.h>
> >  #include "internal.h"
> >  #include <trace/events/fscache.h>
> >
> > @@ -58,9 +59,12 @@ void cachefiles_acquire_volume(struct fscache_volume *=
vcookie)
> >                 if (ret < 0) {
> >                         if (ret !=3D -ESTALE)
> >                                 goto error_dir;
> > -                       inode_lock_nested(d_inode(cache->store), I_MUTEX_=
PARENT);
> > -                       cachefiles_bury_object(cache, NULL, cache->store,=
 vdentry,
> > -                                              FSCACHE_VOLUME_IS_WEIRD);
> > +                       vdentry =3D start_removing_dentry(cache->store, v=
dentry);
> > +                       if (!IS_ERR(vdentry))
> > +                               cachefiles_bury_object(cache, NULL, cache=
->store,
> > +                                                      vdentry,
> > +                                                      FSCACHE_VOLUME_IS_=
WEIRD);
> > +                       end_removing(vdentry);
> >                         cachefiles_put_directory(volume->dentry);
> >                         cond_resched();
> >                         goto retry;
> > diff --git a/fs/namei.c b/fs/namei.c
> > index bd5c45801756..cb4d40af12ae 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3344,6 +3344,35 @@ struct dentry *start_removing_noperm(struct dentry=
 *parent,
> >  }
> >  EXPORT_SYMBOL(start_removing_noperm);
> >
> > +/**
> > + * start_removing_dentry - prepare to remove a given dentry
> > + * @parent - directory from which dentry should be removed
> > + * @child - the dentry to be removed
> > + *
> > + * A lock is taken to protect the dentry again other dirops and
> > + * the validity of the dentry is checked: correct parent and still hashe=
d.
> > + *
> > + * If the dentry is valid a reference is taken and returned.  If not
> > + * an error is returned.
> > + *
> > + * end_removing() should be called when removal is complete, or aborted.
> > + *
> > + * Returns: the valid dentry, or an error.
> > + */
> > +struct dentry *start_removing_dentry(struct dentry *parent,
> > +                                    struct dentry *child)
> > +{
> > +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> > +       if (unlikely(IS_DEADDIR(parent->d_inode) ||
> > +                    child->d_parent !=3D parent ||
> > +                    d_unhashed(child))) {
> > +               inode_unlock(parent->d_inode);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +       return dget(child);
> > +}
> > +EXPORT_SYMBOL(start_removing_dentry);
> > +
> >  #ifdef CONFIG_UNIX98_PTYS
> >  int path_pts(struct path *path)
> >  {
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index c4057b4a050d..74b1ef5860a4 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -47,14 +47,12 @@ static int ovl_cleanup_locked(struct ovl_fs *ofs, str=
uct inode *wdir,
> >  int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
> >                 struct dentry *wdentry)
> >  {
> > -       int err;
> > -
> > -       err =3D ovl_parent_lock(workdir, wdentry);
> > -       if (err)
> > -               return err;
> > +       wdentry =3D start_removing_dentry(workdir, wdentry);
> > +       if (IS_ERR(wdentry))
> > +               return PTR_ERR(wdentry);
> >
> >         ovl_cleanup_locked(ofs, workdir->d_inode, wdentry);
> > -       ovl_parent_unlock(workdir);
> > +       end_removing(wdentry);
> >
> >         return 0;
> >  }
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index 15cb06fa0c9a..213ff42556e7 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -1158,11 +1158,11 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struc=
t dentry *parent,
> >         if (!d_is_dir(dentry) || level > 1)
> >                 return ovl_cleanup(ofs, parent, dentry);
> >
> > -       err =3D ovl_parent_lock(parent, dentry);
> > -       if (err)
> > -               return err;
> > +       dentry =3D start_removing_dentry(parent, dentry);
> > +       if (IS_ERR(dentry))
> > +               return PTR_ERR(dentry);
> >         err =3D ovl_do_rmdir(ofs, parent->d_inode, dentry);
> > -       ovl_parent_unlock(parent);
> > +       end_removing(dentry);
> >         if (err) {
> >                 struct path path =3D { .mnt =3D mnt, .dentry =3D dentry };
> >
> > diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> > index 1cfa688904b2..56b755a05c4e 100644
> > --- a/fs/smb/server/vfs.c
> > +++ b/fs/smb/server/vfs.c
> > @@ -48,24 +48,6 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work =
*work,
> >         i_uid_write(inode, i_uid_read(parent_inode));
> >  }
> >
> > -/**
> > - * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
> > - * @parent: parent dentry
> > - * @child: child dentry
> > - *
> > - * Returns: %0 on success, %-ENOENT if the parent dentry is not stable
> > - */
> > -int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
> > -{
> > -       inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> > -       if (child->d_parent !=3D parent) {
> > -               inode_unlock(d_inode(parent));
> > -               return -ENOENT;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> >  static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
> >                                  char *pathname, unsigned int flags,
> >                                  struct path *path, bool do_lock)
> > @@ -1083,18 +1065,17 @@ int ksmbd_vfs_unlink(struct file *filp)
> >                 return err;
> >
> >         dir =3D dget_parent(dentry);
> > -       err =3D ksmbd_vfs_lock_parent(dir, dentry);
> > -       if (err)
> > +       dentry =3D start_removing_dentry(dir, dentry);
> > +       err =3D PTR_ERR(dentry);
> > +       if (IS_ERR(dentry))
> >                 goto out;
> > -       dget(dentry);
> >
> >         if (S_ISDIR(d_inode(dentry)->i_mode))
> >                 err =3D vfs_rmdir(idmap, d_inode(dir), dentry);
> >         else
> >                 err =3D vfs_unlink(idmap, d_inode(dir), dentry, NULL);
> >
> > -       dput(dentry);
> > -       inode_unlock(d_inode(dir));
> > +       end_removing(dentry);
> >         if (err)
> >                 ksmbd_debug(VFS, "failed to delete, err %d\n", err);
> >  out:
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 20a88a46fe92..32a007f1043e 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -94,6 +94,8 @@ struct dentry *start_removing(struct mnt_idmap *idmap, =
struct dentry *parent,
> >                               struct qstr *name);
> >  struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
> >  struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
> > +struct dentry *start_removing_dentry(struct dentry *parent,
> > +                                    struct dentry *child);
> >
> >  /* end_creating - finish action started with start_creating
> >   * @child - dentry returned by start_creating()
> > diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> > index 391a586d0557..9d08d103f142 100644
> > --- a/security/apparmor/apparmorfs.c
> > +++ b/security/apparmor/apparmorfs.c
> > @@ -355,17 +355,17 @@ static void aafs_remove(struct dentry *dentry)
> >         if (!dentry || IS_ERR(dentry))
> >                 return;
> >
> > +       /* ->d_parent is stable as rename is not supported */
> >         dir =3D d_inode(dentry->d_parent);
> > -       inode_lock(dir);
> > -       if (simple_positive(dentry)) {
> > +       dentry =3D start_removing_dentry(dentry->d_parent, dentry);
> > +       if (!IS_ERR(dentry) && simple_positive(dentry)) {
> >                 if (d_is_dir(dentry))
> >                         simple_rmdir(dir, dentry);
> >                 else
> >                         simple_unlink(dir, dentry);
> >                 d_delete(dentry);
> > -               dput(dentry);
> >         }
> > -       inode_unlock(dir);
> > +       end_removing(dentry);
> >         simple_release_fs(&aafs_mnt, &aafs_count);
> >  }
> >
> > --
> > 2.50.0.107.gf914562f5916.dirty
> >
>=20


