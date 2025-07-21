Return-Path: <linux-fsdevel+bounces-55627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1CB0CD7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 01:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2324D6C3B08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 23:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39DC242D7F;
	Mon, 21 Jul 2025 23:04:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE5221F09;
	Mon, 21 Jul 2025 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139055; cv=none; b=V1KZw7rrIDE73xS3k9H7Bg1zfV7y3uGnAdgY0crxlUi69zlNpAv7ZXTSJAAyYNfnCpi9Y201DXGrP2UoVoj68aqPKWlTZMSEA4825rXu/5S2R/OBIl0V4CmNacjaZsmZFurz7a6l+Xc8IrKseBuVu2PJMkkNZERG2DYKDe8GOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139055; c=relaxed/simple;
	bh=gXvOvys/ryU2q0Qk6oGr5PYxo77EpXEX5DbNLvnJUPg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iMY+K1H5ofcxQBMVyLqP5h9cuwcjoaeKz1ecRGE32ckcapd0Qq7u8v4XYul+d3QHVQceznUPXL5aC29HMsyyN8NgEiAu/Xzrg08DvHI9CrZEaVudUJ+5jwboUNFw/xqu5FwMvYgkqJlIxCmagqHuvDSdfhI1iRt/3X+FC9r6FwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1udzYE-002uUz-Gz;
	Mon, 21 Jul 2025 23:04:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] VFS: introduce done_dentry_lookup()
In-reply-to: <b518093d927c52e4a7affce3a91fba618fd3fc09.camel@kernel.org>
References: <>, <b518093d927c52e4a7affce3a91fba618fd3fc09.camel@kernel.org>
Date: Tue, 22 Jul 2025 09:04:07 +1000
Message-id: <175313904724.2234665.16342190171473611948@noble.neil.brown.name>

On Mon, 21 Jul 2025, Jeff Layton wrote:
> On Mon, 2025-07-21 at 17:59 +1000, NeilBrown wrote:
> > done_dentry_lookup() is the first step in introducing a new API for
> > locked operation on names in directories - those that create or remove
> > names.  Rename operations will also be part of this API but will
> > use separate interfaces.
> >=20
> > The plan is to lock just the dentry (or dentries), not the whole
> > directory.  A "dentry_lookup()" operation will perform the locking and
> > lookup with a corresponding "done_dentry_lookup()" releasing the
> > resulting dentry and dropping any locks.
> >=20
> > This done_dentry_lookup() can immediately be used to complete updates
> > started with kern_path_locked() (much as done_path_create() already
> > completes operations started with kern_path_create()).
> >=20
> > So this patch adds done_dentry_lookup() and uses it where
> > kern_path_locked() is used.  It also adds done_dentry_lookup_return()
> > which returns a reference to the dentry rather than dropping it.  This
> > is a less common need in existing code, but still worth its own interface.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  drivers/base/devtmpfs.c |  7 ++-----
> >  fs/bcachefs/fs-ioctl.c  |  3 +--
> >  fs/namei.c              | 38 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/namei.h   |  3 +++
> >  kernel/audit_fsnotify.c |  9 ++++-----
> >  kernel/audit_watch.c    |  3 +--
> >  6 files changed, 49 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> > index 31bfb3194b4c..47bee8166c8d 100644
> > --- a/drivers/base/devtmpfs.c
> > +++ b/drivers/base/devtmpfs.c
> > @@ -265,8 +265,7 @@ static int dev_rmdir(const char *name)
> >  	else
> >  		err =3D -EPERM;
> > =20
> > -	dput(dentry);
> > -	inode_unlock(d_inode(parent.dentry));
> > +	done_dentry_lookup(dentry);
> >  	path_put(&parent);
> >  	return err;
> >  }
> > @@ -349,9 +348,7 @@ static int handle_remove(const char *nodename, struct=
 device *dev)
> >  		if (!err || err =3D=3D -ENOENT)
> >  			deleted =3D 1;
> >  	}
> > -	dput(dentry);
> > -	inode_unlock(d_inode(parent.dentry));
> > -
> > +	done_dentry_lookup(dentry);
> >  	path_put(&parent);
> >  	if (deleted && strchr(nodename, '/'))
> >  		delete_path(nodename);
> > diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
> > index 4e72e654da96..8077ddf4ddc4 100644
> > --- a/fs/bcachefs/fs-ioctl.c
> > +++ b/fs/bcachefs/fs-ioctl.c
> > @@ -351,8 +351,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_f=
s *c, struct file *filp,
> >  		d_invalidate(victim);
> >  	}
> >  err:
> > -	inode_unlock(dir);
> > -	dput(victim);
> > +	done_dentry_lookup(victim);
> >  	path_put(&path);
> >  	return ret;
> >  }
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 1c80445693d4..da160a01e23d 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1714,6 +1714,44 @@ struct dentry *lookup_one_qstr_excl(const struct q=
str *name,
> >  }
> >  EXPORT_SYMBOL(lookup_one_qstr_excl);
> > =20
> > +/**
> > + * done_dentry_lookup - finish a lookup used for create/delete
> > + * @dentry:  the target dentry
> > + *
> > + * After locking the directory and lookup or validating a dentry
> > + * an attempt can be made to create (including link) or remove (including
> > + * rmdir) a dentry.  After this, done_dentry_lookup() can be used to both
> > + * unlock the parent directory and dput() the dentry.
> > + *
> > + * This interface allows a smooth transition from parent-dir based
> > + * locking to dentry based locking.
> > + */
> > +void done_dentry_lookup(struct dentry *dentry)
> > +{
> > +	inode_unlock(dentry->d_parent->d_inode);
> > +	dput(dentry);
> > +}
> > +EXPORT_SYMBOL(done_dentry_lookup);
> > +
> > +/**
> > + * done_dentry_lookup_return - finish a lookup sequence, returning the d=
entry
> > + * @dentry:  the target dentry
> > + *
> > + * After locking the directory and lookup or validating a dentry
> > + * an attempt can be made to create (including link) or remove (including
> > + * rmdir) a dentry.  After this, done_dentry_lookup_return() can be used=
 to
> > + * unlock the parent directory.  The dentry is returned for further use.
> > + *
> > + * This interface allows a smooth transition from parent-dir based
> > + * locking to dentry based locking.
> > + */
> > +struct dentry *done_dentry_lookup_return(struct dentry *dentry)
> > +{
> > +	inode_unlock(dentry->d_parent->d_inode);
> > +	return dentry;
> > +}
> > +EXPORT_SYMBOL(done_dentry_lookup_return);
> > +
> >  /**
> >   * lookup_fast - do fast lockless (but racy) lookup of a dentry
> >   * @nd: current nameidata
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 5d085428e471..e097f11587c9 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -81,6 +81,9 @@ struct dentry *lookup_one_positive_unlocked(struct mnt_=
idmap *idmap,
> >  					    struct qstr *name,
> >  					    struct dentry *base);
> > =20
> > +void done_dentry_lookup(struct dentry *dentry);
> > +struct dentry *done_dentry_lookup_return(struct dentry *dentry);
> > +
> >  extern int follow_down_one(struct path *);
> >  extern int follow_down(struct path *path, unsigned int flags);
> >  extern int follow_up(struct path *);
> > diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> > index c565fbf66ac8..170836c3520f 100644
> > --- a/kernel/audit_fsnotify.c
> > +++ b/kernel/audit_fsnotify.c
> > @@ -85,8 +85,8 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct aud=
it_krule *krule, char *pa
> >  	dentry =3D kern_path_locked(pathname, &path);
> >  	if (IS_ERR(dentry))
> >  		return ERR_CAST(dentry); /* returning an error */
> > -	inode =3D path.dentry->d_inode;
> > -	inode_unlock(inode);
> > +	inode =3D igrab(dentry->d_inode);
>=20
> This is a little confusing. This patch changes "inode" from pointing to
> the parent inode to point to the child inode instead. That actually
> makes a bit more sense given the naming, but might best be done in a
> separate patch.

I could at least explain it properly the commit description.
This is part of my struggle with done_dentry_lookup_return().  Maybe I
should just use that and preserve the current use of dentry here....

Or maybe a separate patch as you say.  I'll ponder it.

>=20
> > +	done_dentry_lookup(dentry);
> > =20
> >  	audit_mark =3D kzalloc(sizeof(*audit_mark), GFP_KERNEL);
> >  	if (unlikely(!audit_mark)) {
> > @@ -97,17 +97,16 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct a=
udit_krule *krule, char *pa
> >  	fsnotify_init_mark(&audit_mark->mark, audit_fsnotify_group);
> >  	audit_mark->mark.mask =3D AUDIT_FS_EVENTS;
> >  	audit_mark->path =3D pathname;
> > -	audit_update_mark(audit_mark, dentry->d_inode);
> > +	audit_update_mark(audit_mark, inode);
> >  	audit_mark->rule =3D krule;
> > =20
> > -	ret =3D fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
> > +	ret =3D fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode=
, 0);
> >  	if (ret < 0) {
> >  		audit_mark->path =3D NULL;
> >  		fsnotify_put_mark(&audit_mark->mark);
> >  		audit_mark =3D ERR_PTR(ret);
> >  	}
> >  out:
> > -	dput(dentry);
> >  	path_put(&path);
> >  	return audit_mark;
> >  }
> > diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> > index 0ebbbe37a60f..f6ecac2109d4 100644
> > --- a/kernel/audit_watch.c
> > +++ b/kernel/audit_watch.c
> > @@ -359,8 +359,7 @@ static int audit_get_nd(struct audit_watch *watch, st=
ruct path *parent)
> >  		watch->ino =3D d_backing_inode(d)->i_ino;
> >  	}
> > =20
> > -	inode_unlock(d_backing_inode(parent->dentry));
> > -	dput(d);
> > +	done_dentry_lookup(d);
> >  	return 0;
> >  }
> > =20
>=20
> It looks right to me though.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20

Thanks,
NeilBrown

