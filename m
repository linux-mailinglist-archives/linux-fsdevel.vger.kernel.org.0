Return-Path: <linux-fsdevel+bounces-63140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0729BAF0E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 05:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9851E3AA0AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 03:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153A32D640E;
	Wed,  1 Oct 2025 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EndgJMUY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DC6Q/PyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC2A2D63F8
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759288534; cv=none; b=qMpo2cy5cRymXitYJyMN1GhYL66++Wvsgy/aVFcW+FBE2jSfIxGqHPKSe/uKVXJ117JD/L+Hk4aXwYPLtZAwdPquyl9G+wHYZaScuTcLLTo/ynL9jV7ipPGAB+B9yHpkLOMSvaGzS511QTzeWa7MbFpjQ5Vceq+HV4kUFUdHoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759288534; c=relaxed/simple;
	bh=0XTpPCL94gtQW+JGJ1rO/d+QVAlxCEPcAFyG/HsOGQI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=O3RIKVaroX9EQ/K9L1udhMxRKDgJxeyHqtbmmTdxfgIxjsawTMm+nfHczwgmjJgyhU8kBBFIXqLXRYk4h1VVOMMF5IV7WYxkdJ9LbOxU1qp+s0umt5FgoAL6Ir0FnBuwmQRtouoata8C/AoSVW+xj0cJOgJAQoU+yEHByV2qeZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EndgJMUY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DC6Q/PyU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C5C4EC01B4;
	Tue, 30 Sep 2025 23:15:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 30 Sep 2025 23:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759288529; x=1759374929; bh=rowmHRx/6oDUi+Hez5j09l50ExOwClNCKr5
	CKLKUu28=; b=EndgJMUYsSeots4IgVIDqNLtlcsykJEHq99/TqgG3ArK4nWs5sn
	m3U0gjJSIp/Ng8ii0Su9ZIbTv6dGYKnrTsy6j3+bSD1sDay8yGZ6yCPNM1ex0Yzz
	ArtxNnfzHiDId1SKJY7pjUHTnqdFE1iGOOhGpCk9wIFbq35hK7V1I6SwcBB8VJeA
	7Cf3//o/UpIBf1U8eg8fel44g0bE/QdQmRo7ysmXU8mo07ODNwFhhMlKrIPMV4D6
	/vXVfgJgw56g/Gv6dLY5MFzmQB6E90wqHMKGDJlQ0GVprYDuvV+cPNXD4FLtlqm8
	5Ri5MVGVOKy7/p4bXgf/TPHLsR0P5Zn6Bhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759288529; x=
	1759374929; bh=rowmHRx/6oDUi+Hez5j09l50ExOwClNCKr5CKLKUu28=; b=D
	C6Q/PyU+Fl2mDzB/Azf3uJpINnDHkU4W+YOCxpE9eJ0PXeyMdnvGzv6sL8p2bK+o
	KRNWlz9qn5+W50rkHjBRRmrLb1mhQAUznn12jVoFZr1BcNewoscMLK307ssHIycv
	jd4QO8VKUAQHDyYUr6RK+2AhozucVwwNXt4WhK0KTxxkM7mOPpOsM0GOKhPDAGjc
	DB5EEXZ08YTVy4sb3HvqKhUfz1i7mTbGIlMQIo7KfSh38eT7vlXDmCt8SLFM1Ff9
	kD752II453y8cX7gK92lLFp5bvDeYF0tanZWlgFaJlyRp/Tnu+Pb7UCcnCx/kTCF
	H0Bxd5rcbeM/AAqEqUUMw==
X-ME-Sender: <xms:0JzcaMoRWUVe4tbnGgl2BwpmLxr1_WmUvD6Df4CTnTJ4nvmZwtAEag>
    <xme:0JzcaNktUK4s5YJpJyPSJo1rgjjVuEQxAI3A3Z0j5BhcG8PudnqiRxHg4sxW_S8CO
    zZJMrQ7R8yOR6e5DMxojyRTiqStQX3vg93eo8yEGfHIinKJIw>
X-ME-Received: <xmr:0JzcaAPyaMGhm-ksLdaGwPH37I4wV-ljz2NqYuVHmfZzWkbxlaJMfh2CBqr9cGtcqHfiSdxKdpOAAENh2bnlp7R-60OIGGq8_07vQNmpm6w7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvddtfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:0JzcaJPBr1YmTRKecnNblWHNJuS-WzccSBXJDTa4EENqQwGxyz2YLw>
    <xmx:0JzcaJhZh6lpsHfmQQSgTY-VmrQBQ_0TQ01ls0tyDhNRtjfdk_yVCA>
    <xmx:0JzcaOsj779WhgzNNI_p03Ztmf30m1-OShWLp5x1Ia6f9yLyiyhKWA>
    <xmx:0JzcaHRBcMEPXZ5dn4A_MxbAVR9odPz3o-4Ij1AUhAmK6BzM2k4sEw>
    <xmx:0ZzcaIA_b8FlZnrfxXDpLtgxTxqLtJxlg7FRuQOEqMdm52t54LBfQQNk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 23:15:26 -0400 (EDT)
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
Subject: Re: [PATCH 03/11] VFS/nfsd/cachefiles/ovl: add start_creating() and
 end_creating()
In-reply-to:
 <CAOQ4uxidJeex=7H9z8rNEm5OrLqEQ-RRzTU8V3Rt_05Jr4iMPw@mail.gmail.com>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <20250926025015.1747294-4-neilb@ownmail.net>,
 <CAOQ4uxidJeex=7H9z8rNEm5OrLqEQ-RRzTU8V3Rt_05Jr4iMPw@mail.gmail.com>
Date: Wed, 01 Oct 2025 13:15:15 +1000
Message-id: <175928851519.1696783.18251672083984186640@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 30 Sep 2025, Amir Goldstein wrote:
> On Fri, Sep 26, 2025 at 4:50=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > start_creating() is similar to simple_start_creating() but is not so
> > simple.
> > It takes a qstr for the name, includes permission checking, and does NOT
> > report an error if the name already exists, returning a positive dentry
> > instead.
> >
> > This is currently used by nfsd, cachefiles, and overlayfs.
> >
> > end_creating() is called after the dentry has been used.
> > end_creating() drops the reference to the dentry as it is generally no
> > longer needed.  This is exactly end_dirop_mkdir(),
> > but using that everywhere looks a bit odd...
> >
> > These calls help encapsulate locking rules so that directory locking can
> > be changed.
> >
> > Occasionally this change means that the parent lock is held for a
> > shorter period of time, for example in cachefiles_commit_tmpfile().
> > As this function now unlocks after an unlink and before the following
> > lookup, it is possible that the lookup could again find a positive
> > dentry, so a while loop is introduced there.
> >
> > In overlayfs the ovl_lookup_temp() function has ovl_tempname()
> > split out to be used in ovl_start_creating_temp().  The other use
> > of ovl_lookup_temp() is preparing for a rename.  When rename handling
> > is updated, ovl_lookup_temp() will be removed.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/cachefiles/namei.c    | 37 ++++++++--------
> >  fs/namei.c               | 27 ++++++++++++
> >  fs/nfsd/nfs3proc.c       | 14 +++---
> >  fs/nfsd/nfs4proc.c       | 14 +++---
> >  fs/nfsd/nfs4recover.c    | 16 +++----
> >  fs/nfsd/nfsproc.c        | 11 +++--
> >  fs/nfsd/vfs.c            | 42 +++++++-----------
> >  fs/overlayfs/copy_up.c   | 19 ++++----
> >  fs/overlayfs/dir.c       | 94 ++++++++++++++++++++++++----------------
> >  fs/overlayfs/overlayfs.h |  8 ++++
> >  fs/overlayfs/super.c     | 32 +++++++-------
> >  include/linux/namei.h    | 18 ++++++++
> >  12 files changed, 187 insertions(+), 145 deletions(-)
> >
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index d1edb2ac3837..965b22b2f58d 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -93,12 +93,11 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
> >         _enter(",,%s", dirname);
> >
> >         /* search the current directory for the element name */
> > -       inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> >
> >  retry:
> >         ret =3D cachefiles_inject_read_error();
> >         if (ret =3D=3D 0)
> > -               subdir =3D lookup_one(&nop_mnt_idmap, &QSTR(dirname), dir=
);
> > +               subdir =3D start_creating(&nop_mnt_idmap, dir, &QSTR(dirn=
ame));
> >         else
> >                 subdir =3D ERR_PTR(ret);
> >         trace_cachefiles_lookup(NULL, dir, subdir);
> > @@ -141,7 +140,7 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
> >                 trace_cachefiles_mkdir(dir, subdir);
> >
> >                 if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))=
) {
> > -                       dput(subdir);
> > +                       end_creating(subdir, dir);
> >                         goto retry;
> >                 }
> >                 ASSERT(d_backing_inode(subdir));
> > @@ -154,7 +153,8 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
> >
> >         /* Tell rmdir() it's not allowed to delete the subdir */
> >         inode_lock(d_inode(subdir));
> > -       inode_unlock(d_inode(dir));
> > +       dget(subdir);
> > +       end_creating(subdir, dir);
> >
> >         if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
> >                 pr_notice("cachefiles: Inode already in use: %pd (B=3D%lx=
)\n",
> > @@ -196,14 +196,11 @@ struct dentry *cachefiles_get_directory(struct cach=
efiles_cache *cache,
> >         return ERR_PTR(-EBUSY);
> >
> >  mkdir_error:
> > -       inode_unlock(d_inode(dir));
> > -       if (!IS_ERR(subdir))
> > -               dput(subdir);
> > +       end_creating(subdir, dir);
> >         pr_err("mkdir %s failed with error %d\n", dirname, ret);
> >         return ERR_PTR(ret);
> >
> >  lookup_error:
> > -       inode_unlock(d_inode(dir));
> >         ret =3D PTR_ERR(subdir);
> >         pr_err("Lookup %s failed with error %d\n", dirname, ret);
> >         return ERR_PTR(ret);
> > @@ -679,36 +676,37 @@ bool cachefiles_commit_tmpfile(struct cachefiles_ca=
che *cache,
> >
> >         _enter(",%pD", object->file);
> >
> > -       inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
> >         ret =3D cachefiles_inject_read_error();
> >         if (ret =3D=3D 0)
> > -               dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(object->d_nam=
e), fan);
> > +               dentry =3D start_creating(&nop_mnt_idmap, fan, &QSTR(obje=
ct->d_name));
> >         else
> >                 dentry =3D ERR_PTR(ret);
> >         if (IS_ERR(dentry)) {
> >                 trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(=
dentry),
> >                                            cachefiles_trace_lookup_error);
> >                 _debug("lookup fail %ld", PTR_ERR(dentry));
> > -               goto out_unlock;
> > +               goto out;
> >         }
> >
> > -       if (!d_is_negative(dentry)) {
> > +       while (!d_is_negative(dentry)) {
> >                 ret =3D cachefiles_unlink(volume->cache, object, fan, den=
try,
> >                                         FSCACHE_OBJECT_IS_STALE);
> >                 if (ret < 0)
> > -                       goto out_dput;
> > +                       goto out_end;
> > +
> > +               end_creating(dentry, fan);
> >
> > -               dput(dentry);
> >                 ret =3D cachefiles_inject_read_error();
> >                 if (ret =3D=3D 0)
> > -                       dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(objec=
t->d_name), fan);
> > +                       dentry =3D start_creating(&nop_mnt_idmap, fan,
> > +                                               &QSTR(object->d_name));
> >                 else
> >                         dentry =3D ERR_PTR(ret);
> >                 if (IS_ERR(dentry)) {
> >                         trace_cachefiles_vfs_error(object, d_inode(fan), =
PTR_ERR(dentry),
> >                                                    cachefiles_trace_looku=
p_error);
> >                         _debug("lookup fail %ld", PTR_ERR(dentry));
> > -                       goto out_unlock;
> > +                       goto out;
> >                 }
> >         }
> >
> > @@ -729,10 +727,9 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cac=
he *cache,
> >                 success =3D true;
> >         }
> >
> > -out_dput:
> > -       dput(dentry);
> > -out_unlock:
> > -       inode_unlock(d_inode(fan));
> > +out_end:
> > +       end_creating(dentry, fan);
> > +out:
> >         _leave(" =3D %u", success);
> >         return success;
> >  }
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 81cbaabbbe21..064cb44a3a46 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3242,6 +3242,33 @@ struct dentry *lookup_noperm_positive_unlocked(str=
uct qstr *name,
> >  }
> >  EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
> >
> > +/**
> > + * start_creating - prepare to create a given name with permission check=
ing
> > + * @idmap - idmap of the mount
> > + * @parent - directory in which to prepare to create the name
> > + * @name - the name to be created
> > + *
> > + * Locks are taken and a lookup in performed prior to creating
>=20
> typo: is performed
>=20
> > + * an object in a directory.  Permission checking (MAY_EXEC) is performed
> > + * against @idmap.
> > + *
> > + * If the name already exists, a positive dentry is returned, so
> > + * behaviour is similar to O_CREAT without O_EXCL, which doesn't fail
> > + * with -EEXIST.
> > + *
> > + * Returns: a negative or positive dentry, or an error.
> > + */
> > +struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> > +                             struct qstr *name)
> > +{
> > +       int err =3D lookup_one_common(idmap, name, parent);
> > +
> > +       if (err)
> > +               return ERR_PTR(err);
> > +       return start_dirop(parent, name, LOOKUP_CREATE);
> > +}
> > +EXPORT_SYMBOL(start_creating);
> > +
> >  #ifdef CONFIG_UNIX98_PTYS
> >  int path_pts(struct path *path)
> >  {
> > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > index b6d03e1ef5f7..e2aac0def2cb 100644
> > --- a/fs/nfsd/nfs3proc.c
> > +++ b/fs/nfsd/nfs3proc.c
> > @@ -281,14 +281,11 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> >         if (host_err)
> >                 return nfserrno(host_err);
> >
> > -       inode_lock_nested(inode, I_MUTEX_PARENT);
> > -
> > -       child =3D lookup_one(&nop_mnt_idmap,
> > -                          &QSTR_LEN(argp->name, argp->len),
> > -                          parent);
> > +       child =3D start_creating(&nop_mnt_idmap, parent,
> > +                              &QSTR_LEN(argp->name, argp->len));
> >         if (IS_ERR(child)) {
> >                 status =3D nfserrno(PTR_ERR(child));
> > -               goto out;
> > +               goto out_write;
> >         }
> >
> >         if (d_really_is_negative(child)) {
> > @@ -367,9 +364,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> >         status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
> >
> >  out:
> > -       inode_unlock(inode);
> > -       if (child && !IS_ERR(child))
> > -               dput(child);
> > +       end_creating(child, parent);
> > +out_write:
> >         fh_drop_write(fhp);
> >         return status;
> >  }
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 71b428efcbb5..35d48221072f 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -264,14 +264,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> >         if (is_create_with_attrs(open))
> >                 nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
> >
> > -       inode_lock_nested(inode, I_MUTEX_PARENT);
> > -
> > -       child =3D lookup_one(&nop_mnt_idmap,
> > -                          &QSTR_LEN(open->op_fname, open->op_fnamelen),
> > -                          parent);
> > +       child =3D start_creating(&nop_mnt_idmap, parent,
> > +                              &QSTR_LEN(open->op_fname, open->op_fnamele=
n));
> >         if (IS_ERR(child)) {
> >                 status =3D nfserrno(PTR_ERR(child));
> > -               goto out;
> > +               goto out_write;
> >         }
> >
> >         if (d_really_is_negative(child)) {
> > @@ -379,10 +376,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> >         if (attrs.na_aclerr)
> >                 open->op_bmval[0] &=3D ~FATTR4_WORD0_ACL;
> >  out:
> > -       inode_unlock(inode);
> > +       end_creating(child, parent);
> >         nfsd_attrs_free(&attrs);
> > -       if (child && !IS_ERR(child))
> > -               dput(child);
> > +out_write:
> >         fh_drop_write(fhp);
> >         return status;
> >  }
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index 2231192ec33f..93b2a3e764db 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -216,13 +216,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
> >                 goto out_creds;
> >
> >         dir =3D nn->rec_file->f_path.dentry;
> > -       /* lock the parent */
> > -       inode_lock(d_inode(dir));
> >
> > -       dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(dname), dir);
> > +       dentry =3D start_creating(&nop_mnt_idmap, dir, &QSTR(dname));
> >         if (IS_ERR(dentry)) {
> >                 status =3D PTR_ERR(dentry);
> > -               goto out_unlock;
> > +               goto out;
> >         }
> >         if (d_really_is_positive(dentry))
> >                 /*
> > @@ -233,15 +231,13 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
> >                  * In the 4.0 case, we should never get here; but we may
> >                  * as well be forgiving and just succeed silently.
> >                  */
> > -               goto out_put;
> > +               goto out_end;
> >         dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWX=
U);
> >         if (IS_ERR(dentry))
> >                 status =3D PTR_ERR(dentry);
> > -out_put:
> > -       if (!status)
> > -               dput(dentry);
> > -out_unlock:
> > -       inode_unlock(d_inode(dir));
> > +out_end:
> > +       end_creating(dentry, dir);
> > +out:
> >         if (status =3D=3D 0) {
> >                 if (nn->in_grace)
> >                         __nfsd4_create_reclaim_record_grace(clp, dname,
> > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > index 8f71f5748c75..ee1b16e921fd 100644
> > --- a/fs/nfsd/nfsproc.c
> > +++ b/fs/nfsd/nfsproc.c
> > @@ -306,18 +306,16 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> >                 goto done;
> >         }
> >
> > -       inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
> > -       dchild =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(argp->name, argp-=
>len),
> > -                           dirfhp->fh_dentry);
> > +       dchild =3D start_creating(&nop_mnt_idmap, dirfhp->fh_dentry,
> > +                               &QSTR_LEN(argp->name, argp->len));
> >         if (IS_ERR(dchild)) {
> >                 resp->status =3D nfserrno(PTR_ERR(dchild));
> > -               goto out_unlock;
> > +               goto out_write;
> >         }
> >         fh_init(newfhp, NFS_FHSIZE);
> >         resp->status =3D fh_compose(newfhp, dirfhp->fh_export, dchild, di=
rfhp);
> >         if (!resp->status && d_really_is_negative(dchild))
> >                 resp->status =3D nfserr_noent;
> > -       dput(dchild);
> >         if (resp->status) {
> >                 if (resp->status !=3D nfserr_noent)
> >                         goto out_unlock;
> > @@ -423,7 +421,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> >         }
> >
> >  out_unlock:
> > -       inode_unlock(dirfhp->fh_dentry->d_inode);
> > +       end_creating(dchild, dirfhp->fh_dentry);
> > +out_write:
> >         fh_drop_write(dirfhp);
> >  done:
> >         fh_put(dirfhp);
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index aa4a95713a48..90c830c59c60 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1605,19 +1605,16 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> >         if (host_err)
> >                 return nfserrno(host_err);
> >
> > -       inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> > -       dchild =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), den=
try);
> > +       dchild =3D start_creating(&nop_mnt_idmap, dentry, &QSTR_LEN(fname=
, flen));
> >         host_err =3D PTR_ERR(dchild);
> > -       if (IS_ERR(dchild)) {
> > -               err =3D nfserrno(host_err);
> > -               goto out_unlock;
> > -       }
> > +       if (IS_ERR(dchild))
> > +               return nfserrno(host_err);
> > +
> >         err =3D fh_compose(resfhp, fhp->fh_export, dchild, fhp);
> >         /*
> >          * We unconditionally drop our ref to dchild as fh_compose will h=
ave
> >          * already grabbed its own ref for it.
> >          */
> > -       dput(dchild);
> >         if (err)
> >                 goto out_unlock;
> >         err =3D fh_fill_pre_attrs(fhp);
> > @@ -1626,7 +1623,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> >         err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> >         fh_fill_post_attrs(fhp);
> >  out_unlock:
> > -       inode_unlock(dentry->d_inode);
> > +       end_creating(dchild, dentry);
> >         return err;
> >  }
> >
> > @@ -1712,11 +1709,9 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> >         }
> >
> >         dentry =3D fhp->fh_dentry;
> > -       inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> > -       dnew =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentr=
y);
> > +       dnew =3D start_creating(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, =
flen));
> >         if (IS_ERR(dnew)) {
> >                 err =3D nfserrno(PTR_ERR(dnew));
> > -               inode_unlock(dentry->d_inode);
> >                 goto out_drop_write;
> >         }
> >         err =3D fh_fill_pre_attrs(fhp);
> > @@ -1729,11 +1724,11 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> >                 nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
> >         fh_fill_post_attrs(fhp);
> >  out_unlock:
> > -       inode_unlock(dentry->d_inode);
> > +       end_creating(dnew, dentry);
> >         if (!err)
> >                 err =3D nfserrno(commit_metadata(fhp));
> > -       dput(dnew);
> > -       if (err=3D=3D0) err =3D cerr;
> > +       if (!err)
> > +               err =3D cerr;
> >  out_drop_write:
> >         fh_drop_write(fhp);
> >  out:
> > @@ -1788,32 +1783,31 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *=
ffhp,
> >
> >         ddir =3D ffhp->fh_dentry;
> >         dirp =3D d_inode(ddir);
> > -       inode_lock_nested(dirp, I_MUTEX_PARENT);
> > +       dnew =3D start_creating(&nop_mnt_idmap, ddir, &QSTR_LEN(name, len=
));
> >
> > -       dnew =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(name, len), ddir);
> >         if (IS_ERR(dnew)) {
> >                 host_err =3D PTR_ERR(dnew);
> > -               goto out_unlock;
> > +               goto out_drop_write;
> >         }
> >
> >         dold =3D tfhp->fh_dentry;
> >
> >         err =3D nfserr_noent;
> >         if (d_really_is_negative(dold))
> > -               goto out_dput;
> > +               goto out_unlock;
> >         err =3D fh_fill_pre_attrs(ffhp);
> >         if (err !=3D nfs_ok)
> > -               goto out_dput;
> > +               goto out_unlock;
> >         host_err =3D vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
> >         fh_fill_post_attrs(ffhp);
> > -       inode_unlock(dirp);
> > +out_unlock:
> > +       end_creating(dnew, ddir);
> >         if (!host_err) {
> >                 host_err =3D commit_metadata(ffhp);
> >                 if (!host_err)
> >                         host_err =3D commit_metadata(tfhp);
> >         }
> >
> > -       dput(dnew);
> >  out_drop_write:
> >         fh_drop_write(tfhp);
> >         if (host_err =3D=3D -EBUSY) {
> > @@ -1828,12 +1822,6 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
> >         }
> >  out:
> >         return err !=3D nfs_ok ? err : nfserrno(host_err);
> > -
> > -out_dput:
> > -       dput(dnew);
> > -out_unlock:
> > -       inode_unlock(dirp);
> > -       goto out_drop_write;
> >  }
> >
> >  static void
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 27396fe63f6d..6a31ea34ff80 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -613,9 +613,9 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
> >         if (err)
> >                 goto out;
> >
> > -       inode_lock_nested(udir, I_MUTEX_PARENT);
> > -       upper =3D ovl_lookup_upper(ofs, c->dentry->d_name.name, upperdir,
> > -                                c->dentry->d_name.len);
> > +       upper =3D ovl_start_creating_upper(ofs, upperdir,
> > +                                        &QSTR_LEN(c->dentry->d_name.name,
> > +                                                  c->dentry->d_name.len)=
);
> >         err =3D PTR_ERR(upper);
> >         if (!IS_ERR(upper)) {
> >                 err =3D ovl_do_link(ofs, ovl_dentry_upper(c->dentry), udi=
r, upper);
> > @@ -626,9 +626,8 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
> >                         ovl_dentry_set_upper_alias(c->dentry);
> >                         ovl_dentry_update_reval(c->dentry, upper);
> >                 }
> > -               dput(upper);
> > +               end_creating(upper, upperdir);
> >         }
> > -       inode_unlock(udir);
> >         if (err)
> >                 goto out;
> >
> > @@ -894,16 +893,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_c=
tx *c)
> >         if (err)
> >                 goto out;
> >
> > -       inode_lock_nested(udir, I_MUTEX_PARENT);
> > -
> > -       upper =3D ovl_lookup_upper(ofs, c->destname.name, c->destdir,
> > -                                c->destname.len);
> > +       upper =3D ovl_start_creating_upper(ofs, c->destdir,
> > +                                        &QSTR_LEN(c->destname.name,
> > +                                                  c->destname.len));
> >         err =3D PTR_ERR(upper);
> >         if (!IS_ERR(upper)) {
> >                 err =3D ovl_do_link(ofs, temp, udir, upper);
> > -               dput(upper);
> > +               end_creating(upper, c->destdir);
> >         }
> > -       inode_unlock(udir);
> >
> >         if (err)
> >                 goto out;
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index dbd63a74df4b..0ae79efbfce7 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -59,15 +59,21 @@ int ovl_cleanup(struct ovl_fs *ofs, struct dentry *wo=
rkdir,
> >         return 0;
> >  }
> >
> > -struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
> > +#define OVL_TEMPNAME_SIZE 20
> > +static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
> >  {
> > -       struct dentry *temp;
> > -       char name[20];
> >         static atomic_t temp_id =3D ATOMIC_INIT(0);
> >
> >         /* counter is allowed to wrap, since temp dentries are ephemeral =
*/
> > -       snprintf(name, sizeof(name), "#%x", atomic_inc_return(&temp_id));
> > +       snprintf(name, OVL_TEMPNAME_SIZE, "#%x", atomic_inc_return(&temp_=
id));
> > +}
> > +
> > +struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
> > +{
> > +       struct dentry *temp;
> > +       char name[OVL_TEMPNAME_SIZE];
> >
> > +       ovl_tempname(name);
> >         temp =3D ovl_lookup_upper(ofs, name, workdir, strlen(name));
> >         if (!IS_ERR(temp) && temp->d_inode) {
> >                 pr_err("workdir/%s already exists\n", name);
> > @@ -78,6 +84,16 @@ struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, str=
uct dentry *workdir)
> >         return temp;
> >  }
> >
> > +static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
> > +                                             struct dentry *workdir)
> > +{
> > +       char name[OVL_TEMPNAME_SIZE];
> > +
> > +       ovl_tempname(name);
> > +       return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
> > +                             &QSTR(name));
> > +}
> > +
> >  static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
> >  {
> >         int err;
> > @@ -88,35 +104,31 @@ static struct dentry *ovl_whiteout(struct ovl_fs *of=
s)
> >         guard(mutex)(&ofs->whiteout_lock);
> >
> >         if (!ofs->whiteout) {
> > -               inode_lock_nested(wdir, I_MUTEX_PARENT);
> > -               whiteout =3D ovl_lookup_temp(ofs, workdir);
> > -               if (!IS_ERR(whiteout)) {
> > -                       err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> > -                       if (err) {
> > -                               dput(whiteout);
> > -                               whiteout =3D ERR_PTR(err);
> > -                       }
> > -               }
> > -               inode_unlock(wdir);
> > +               whiteout =3D ovl_start_creating_temp(ofs, workdir);
> >                 if (IS_ERR(whiteout))
> >                         return whiteout;
> > -               ofs->whiteout =3D whiteout;
> > +               err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> > +               if (!err)
> > +                       ofs->whiteout =3D dget(whiteout);
> > +               end_creating(whiteout, workdir);
> > +               if (err)
> > +                       return ERR_PTR(err);
> >         }
> >
> >         if (!ofs->no_shared_whiteout) {
> > -               inode_lock_nested(wdir, I_MUTEX_PARENT);
> > -               whiteout =3D ovl_lookup_temp(ofs, workdir);
> > -               if (!IS_ERR(whiteout)) {
> > -                       err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whi=
teout);
> > -                       if (err) {
> > -                               dput(whiteout);
> > -                               whiteout =3D ERR_PTR(err);
> > -                       }
> > -               }
> > -               inode_unlock(wdir);
> > -               if (!IS_ERR(whiteout))
> > +               struct dentry *ret =3D NULL;
>=20
> For clarity please name this var "link".

Is "link" really clearer than "ret"?

Maybe if I make it
   struct dentry *link;
   link =3D ovl_start_creating_temp(ofs, workdir);
   if (IS_ERR(link))
          return link;
   err =3D ovl_do_link(ofs, ofs->whiteout, wdir, link);
   if (!err)
         whiteout =3D dget(link);
   end_creating(whiteout, workdir);
   if (!err)
         return whiteout;

Then "link" makes sense to me.

>=20
> > +
> > +               whiteout =3D ovl_start_creating_temp(ofs, workdir);
> > +               if (IS_ERR(whiteout))
> >                         return whiteout;
> > -               if (PTR_ERR(whiteout) !=3D -EMLINK) {
> > +               err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
> > +               if (!err)
> > +                       ret =3D dget(whiteout);
> > +               end_creating(whiteout, workdir);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               if (err !=3D -EMLINK) {
> >                         pr_warn("Failed to link whiteout - disabling whit=
eout inode sharing(nlink=3D%u, err=3D%lu)\n",
> >                                 ofs->whiteout->d_inode->i_nlink,
> >                                 PTR_ERR(whiteout));
> > @@ -225,10 +237,13 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, =
struct dentry *workdir,
> >                                struct ovl_cattr *attr)
> >  {
> >         struct dentry *ret;
> > -       inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
> > -       ret =3D ovl_create_real(ofs, workdir,
> > -                             ovl_lookup_temp(ofs, workdir), attr);
> > -       inode_unlock(workdir->d_inode);
> > +       ret =3D ovl_start_creating_temp(ofs, workdir);
> > +       if (IS_ERR(ret))
> > +               return ret;
> > +       ret =3D ovl_create_real(ofs, workdir, ret, attr);
> > +       if (!IS_ERR(ret))
> > +               dget(ret);
> > +       end_creating(ret, workdir);
> >         return ret;
> >  }
> >
> > @@ -327,18 +342,21 @@ static int ovl_create_upper(struct dentry *dentry, =
struct inode *inode,
> >  {
> >         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> >         struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> > -       struct inode *udir =3D upperdir->d_inode;
> >         struct dentry *newdentry;
> >         int err;
> >
> > -       inode_lock_nested(udir, I_MUTEX_PARENT);
> > -       newdentry =3D ovl_create_real(ofs, upperdir,
> > -                                   ovl_lookup_upper(ofs, dentry->d_name.=
name,
> > -                                                    upperdir, dentry->d_=
name.len),
> > -                                   attr);
> > -       inode_unlock(udir);
> > +       newdentry =3D ovl_start_creating_upper(ofs, upperdir,
> > +                                            &QSTR_LEN(dentry->d_name.nam=
e,
> > +                                                      dentry->d_name.len=
));
> >         if (IS_ERR(newdentry))
> >                 return PTR_ERR(newdentry);
> > +       newdentry =3D ovl_create_real(ofs, upperdir, newdentry, attr);
> > +       if (IS_ERR(newdentry)) {
> > +               end_creating(newdentry, upperdir);
> > +               return PTR_ERR(newdentry);
> > +       }
> > +       dget(newdentry);
> > +       end_creating(newdentry, upperdir);
>=20
> See suggestion below to make this:
>=20
>         newdentry =3D end_creating_dentry(newdentry, upperdir);
>         if (IS_ERR(newdentry))
>                    return PTR_ERR(newdentry);
>=20
> >
> >         if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
> >             !ovl_allow_offline_changes(ofs)) {
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 4f84abaa0d68..c24c2da953bd 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -415,6 +415,14 @@ static inline struct dentry *ovl_lookup_upper_unlock=
ed(struct ovl_fs *ofs,
> >                                    &QSTR_LEN(name, len), base);
> >  }
> >
> > +static inline struct dentry *ovl_start_creating_upper(struct ovl_fs *ofs,
> > +                                                     struct dentry *pare=
nt,
> > +                                                     struct qstr *name)
> > +{
> > +       return start_creating(ovl_upper_mnt_idmap(ofs),
> > +                             parent, name);
> > +}
> > +
> >  static inline bool ovl_open_flags_need_copy_up(int flags)
> >  {
> >         if (!flags)
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index bd3d7ba8fb95..67abb62e205b 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -300,8 +300,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
> >         bool retried =3D false;
> >
> >  retry:
> > -       inode_lock_nested(dir, I_MUTEX_PARENT);
> > -       work =3D ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(nam=
e));
> > +       work =3D ovl_start_creating_upper(ofs, ofs->workbasedir, &QSTR(na=
me));
> >
> >         if (!IS_ERR(work)) {
> >                 struct iattr attr =3D {
> > @@ -310,14 +309,13 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
> >                 };
> >
> >                 if (work->d_inode) {
> > +                       dget(work);
> > +                       end_creating(work, ofs->workbasedir);
> > +                       if (persist)
> > +                               return work;
> >                         err =3D -EEXIST;
> > -                       inode_unlock(dir);
> >                         if (retried)
> >                                 goto out_dput;
> > -
> > -                       if (persist)
> > -                               return work;
> > -
> >                         retried =3D true;
> >                         err =3D ovl_workdir_cleanup(ofs, ofs->workbasedir=
, mnt, work, 0);
> >                         dput(work);
> > @@ -328,7 +326,9 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
> >                 }
> >
> >                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> > -               inode_unlock(dir);
> > +               if (!IS_ERR(work))
> > +                       dget(work);
> > +               end_creating(work, ofs->workbasedir);
> >                 err =3D PTR_ERR(work);
> >                 if (IS_ERR(work))
> >                         goto out_err;
> > @@ -366,7 +366,6 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
> >                 if (err)
> >                         goto out_dput;
> >         } else {
> > -               inode_unlock(dir);
> >                 err =3D PTR_ERR(work);
> >                 goto out_err;
> >         }
> > @@ -616,14 +615,17 @@ static struct dentry *ovl_lookup_or_create(struct o=
vl_fs *ofs,
> >                                            struct dentry *parent,
> >                                            const char *name, umode_t mode)
> >  {
> > -       size_t len =3D strlen(name);
> >         struct dentry *child;
> >
> > -       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> > -       child =3D ovl_lookup_upper(ofs, name, parent, len);
> > -       if (!IS_ERR(child) && !child->d_inode)
> > -               child =3D ovl_create_real(ofs, parent, child, OVL_CATTR(m=
ode));
> > -       inode_unlock(parent->d_inode);
> > +       child =3D ovl_start_creating_upper(ofs, parent, &QSTR(name));
> > +       if (!IS_ERR(child)) {
> > +               if (!child->d_inode)
> > +                       child =3D ovl_create_real(ofs, parent, child,
> > +                                               OVL_CATTR(mode));
> > +               if (!IS_ERR(child))
> > +                       dget(child);
> > +               end_creating(child, parent);
>=20
> We have a few of those things open code which are not so pretty IMO.
> How about:
>=20
> child =3D end_creating_dentry(child, parent);
>=20
> Which is a variant of the void end_creating() which does dget()
> in the non error case?

I have experimented with that idea.  I'm not convinced.

There are six places where it would help.
One is in cachefiles, the rest are in overlayfs.
Two of them are just=20
   dget()
   end_creating()

There other have some sort of condition on error as you pointed out
above.

That is out of nearly 30 uses for end_creating().

I would rather declare the dentry variable as __free(end_dirop)
or similar so that "end_creating()" would not appear and the dget()
would stand alone with (hopefully) a clear meaning.
But I can't do that until the vfs_mkdir() issue is resolved.

Maybe it would end up being cleaner having and alternate form of
end_creating() which returns a reference.  But I'm not convinced yet.

>=20
> end_creating_dentry() could be matched with start_creating_dentry()
> in common cases where we had a ref on the child before creating and
> we want to keep the ref on the child after creating.

I don't think there is a useful connection between end_creating_dentry()
and start_creating_dentry(), so I wouldn't use that name.
end_creating_return() maybe, or end_creating_keep().

start_creating_dentry() takes an extra ref so it is always correct to
use end_creating() and you don't need a dget() because you already have
a ref.  You only need the dget() (or to avoid the dput()) if a lookup
was performed by start_creating().

>=20
> > +       }
> >         dput(parent);
> >
> >         return child;
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index a7800ef04e76..4cbe930054a1 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -88,6 +88,24 @@ struct dentry *lookup_one_positive_killable(struct mnt=
_idmap *idmap,
> >                                             struct qstr *name,
> >                                             struct dentry *base);
> >
> > +struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> > +                             struct qstr *name);
> > +
> > +/* end_creating - finish action started with start_creating
> > + * @child - dentry returned by start_creating()
> > + * @parent - dentry given to start_creating()
> > + *
> > + * Unlock and release the child.
> > + *
> > + * Unlike end_dirop() this can only be called if start_creating() succee=
ded.
> > + * It handles @child being and error as vfs_mkdir() might have converted=
 the
> > + * dentry to an error - in that case the parent still needs to be unlock=
ed.
> > + */
> > +static inline void end_creating(struct dentry *child, struct dentry *par=
ent)
> > +{
> > +       end_dirop_mkdir(child, parent);
> > +}
> > +
>=20
> That concludes my out-of-order review of this series.
>=20
> The ovl changes look overall good to me.
> I will wait for v2 without end_dirop_mkdir() to re-review this patch.
>=20
> Feel free to take or discard my suggestion for end_creating_dentry().
>=20
> I agree with Jeff that the conversion of if condition to a while loop in
> cachefiles feels odd, because it is not clear if there should be a stop
> condition. Anyway, best if cachefiles developers could review this
> code anyway.
>=20
> Thanks,
> Amir.
>=20

Thanks a lot of the thorough review - I really appreciate it.

NeilBrown

