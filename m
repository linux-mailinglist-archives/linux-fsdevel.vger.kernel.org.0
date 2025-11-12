Return-Path: <linux-fsdevel+bounces-68120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC16C54D9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510E23A626D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 23:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0EA2ECD27;
	Wed, 12 Nov 2025 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="O8Cw12Ff";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wqTcIeR9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDF26F467;
	Wed, 12 Nov 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762991518; cv=none; b=aca2+rF26s50N/wc4jh5CsMlJxuNknJe8U5R2F6QhgY5bDHHoTTsGrqDvgDro49u44wZmFDnyYEKPCuO4Ae/gRoSSC3taFFQwrYtVXKF6Z6L4hE1hTBKwjXxdFZ1gGLTODaCgP+J0mslxOM7blHGruuhYhcpDhQWboPjrm+aIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762991518; c=relaxed/simple;
	bh=dK7IbDcqDtdOuQtskmOfKdPwCiCeuG8ImXE6nIEMOEU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AzORPSBIcscIyLUWEJm76fXXeggenJTaVwNhAeT0yVee3/z0c6Eg5TlZNmX+XWylAXhMZ7H7HC+ZFMjOSgehdbLQnjVJ15/85dm+KcPfa0/DoZNRnJV5pVZThNeveVHPg8IbE1S4iWNzc6IIpolukGSJHTvQaQzsJLUUNsLq1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=O8Cw12Ff; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wqTcIeR9; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 8CAD713806CD;
	Wed, 12 Nov 2025 18:51:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 12 Nov 2025 18:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762991515; x=1762998715; bh=UdcYk1BKf44XnH9Jgk+1ornLG0gv8gXEsFL
	T4vJdMwg=; b=O8Cw12FfY4TSGDKlLYMYlqpb9reOjchW8/QhIGRaxSufoHZXxkx
	pGnxW+NUsRU5GrMpOk7reVENeWjn6BK0gCyoFGRvw4+k238K3cWBWljzUIgJXOTm
	On6YcHPTqcgtciAoRv5PVDYZP0UugTdPHqmQ0SWzVu5iWsXh6jL5UijtODR7mheO
	cgI/+QX/rDVauTx5HGiuTUWVtB0+Md0CdegROdD8Q47PLL1TP5RH3iH1mT/lNM7M
	qDWnz64XYviYKX8dFNKvWptdhQPCKGUgo9MQbwxIJHoHwhgyqfCgCk4tX76wrdG0
	clk0fzc7quDtJS9UJXRPEbc/fNF3LsnxlAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762991515; x=
	1762998715; bh=UdcYk1BKf44XnH9Jgk+1ornLG0gv8gXEsFLT4vJdMwg=; b=w
	qTcIeR9mBTDvTe2kWovm154V2Xd4kdZYaryqecqKuX/zrLfR9lnfhor5tgUO/tUU
	3hK0Z14Wr/wgEJft7nJN1TAGhG9bPuOn5rAAT9wvcVDnJOfMO24fGYOiL0cYf6/L
	s1kjlNh1Pgl40x5kaM0mTQur/oImPSvVIDE64z7i7PyjZsclpf4GvJedi2eNnFI2
	lOwSevCTeur1hu03l78QG2aguYlH1/hk3Q4i4fmWTLbYkgR0VNO+PN/MugSHgajN
	MWOCOhRoaUJjTE7lK3qCNQL/CCz/3qHGwFJpxmJ7GWkug2iL7/AUNJjsTshE9Z0Y
	7GPJhz2NaKKUSO4zXymlg==
X-ME-Sender: <xms:mR0VaemzNyA7060A7K4SgErH2H_FHN0R2aYyPSdBuzs3SsMNJXJ6vg>
    <xme:mR0Vabk1TZfPr5Z5978pDR82H7X_ZgP08Pzg__H5mrLbKueaKc5S__Cw8LgiXplih
    KvWLo-FQoG0Le-7LBI38aAftY0c4t-g1mfWL-o2-vAICHtTOg>
X-ME-Received: <xmr:mR0VaTe33jM6r5M5-roIJ8Is0-xuczQ7YBlT33asdFUgV4hSYg5nNxSE55LWus0TVPq_f643wBbbqyrm0Mr3XE4xwM6qIfCqoWZJpQFJmczJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:mR0VaZwDtIKh0yj5-HgxKKk477oz_0eMopNhUvqwnpNjwVN6slQb4A>
    <xmx:mR0Vadu_kFHZiGyiyZ-dZkhRP5t3f3LEeCV3qkOggsMloM4L05E_2A>
    <xmx:mR0VaeqGHWvsK7C2DZH9aX4CDBZBR1UVGx2T3MuTz5wYXkgOoBH92w>
    <xmx:mR0VaY1ZJVFyIs_gDKNvSaPa24QH4fIXRo0Zr16C8rURXgIy9aA0jw>
    <xmx:mx0VafhO9plU1agrOx-UpDm8yN6UYgH7TRSeVqMpsFpxMdL5XSKDCNg6>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 18:51:43 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "David Howells" <dhowells@redhat.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Stefan Berger" <stefanb@linux.ibm.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v5 05/14] VFS/nfsd/cachefiles/ovl: introduce
 start_removing() and end_removing()
In-reply-to: <230c32bf9997f26b0cfe8c1a4c9309cf91c5071c.camel@kernel.org>
References: <20251106005333.956321-1-neilb@ownmail.net>,
 <20251106005333.956321-6-neilb@ownmail.net>,
 <230c32bf9997f26b0cfe8c1a4c9309cf91c5071c.camel@kernel.org>
Date: Thu, 13 Nov 2025 10:51:38 +1100
Message-id: <176299149888.634289.17179562954493545471@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 13 Nov 2025, Jeff Layton wrote:
> On Thu, 2025-11-06 at 11:50 +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > start_removing() is similar to start_creating() but will only return a
> > positive dentry with the expectation that it will be removed.  This is
> > used by nfsd, cachefiles, and overlayfs.  They are changed to also use
> > end_removing() to terminate the action begun by start_removing().  This
> > is a simple alias for end_dirop().
> >=20
> > Apart from changes to the error paths, as we no longer need to unlock on
> > a lookup error, an effect on callers is that they don't need to test if
> > the found dentry is positive or negative - they can be sure it is
> > positive.
> >=20
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/cachefiles/namei.c    | 32 ++++++++++++++------------------
> >  fs/namei.c               | 27 +++++++++++++++++++++++++++
> >  fs/nfsd/nfs4recover.c    | 18 +++++-------------
> >  fs/nfsd/vfs.c            | 26 ++++++++++----------------
> >  fs/overlayfs/dir.c       | 15 +++++++--------
> >  fs/overlayfs/overlayfs.h |  8 ++++++++
> >  include/linux/namei.h    | 18 ++++++++++++++++++
> >  7 files changed, 89 insertions(+), 55 deletions(-)
> >=20
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index 0a136eb434da..c7f0c6ab9b88 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -260,6 +260,7 @@ static int cachefiles_unlink(struct cachefiles_cache =
*cache,
> >   * - File backed objects are unlinked
> >   * - Directory backed objects are stuffed into the graveyard for userspa=
ce to
> >   *   delete
> > + * On entry dir must be locked.  It will be unlocked on exit.
> >   */
> >  int cachefiles_bury_object(struct cachefiles_cache *cache,
> >  			   struct cachefiles_object *object,
> > @@ -274,28 +275,30 @@ int cachefiles_bury_object(struct cachefiles_cache =
*cache,
> > =20
> >  	_enter(",'%pd','%pd'", dir, rep);
> > =20
> > +	/* end_removing() will dput() @rep but we need to keep
> > +	 * a ref, so take one now.  This also stops the dentry
> > +	 * being negated when unlinked which we need.
> > +	 */
> > +	dget(rep);
> > +
> >  	if (rep->d_parent !=3D dir) {
> > -		inode_unlock(d_inode(dir));
> > +		end_removing(rep);
> >  		_leave(" =3D -ESTALE");
> >  		return -ESTALE;
> >  	}
> > =20
> >  	/* non-directories can just be unlinked */
> >  	if (!d_is_dir(rep)) {
> > -		dget(rep); /* Stop the dentry being negated if it's only pinned
> > -			    * by a file struct.
> > -			    */
> >  		ret =3D cachefiles_unlink(cache, object, dir, rep, why);
> > -		dput(rep);
> > +		end_removing(rep);
> > =20
> > -		inode_unlock(d_inode(dir));
> >  		_leave(" =3D %d", ret);
> >  		return ret;
> >  	}
> > =20
> >  	/* directories have to be moved to the graveyard */
> >  	_debug("move stale object to graveyard");
> > -	inode_unlock(d_inode(dir));
> > +	end_removing(rep);
> > =20
> >  try_again:
> >  	/* first step is to make up a grave dentry in the graveyard */
> > @@ -749,26 +752,20 @@ static struct dentry *cachefiles_lookup_for_cull(st=
ruct cachefiles_cache *cache,
> >  	struct dentry *victim;
> >  	int ret =3D -ENOENT;
> > =20
> > -	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> > +	victim =3D start_removing(&nop_mnt_idmap, dir, &QSTR(filename));
> > =20
> > -	victim =3D lookup_one(&nop_mnt_idmap, &QSTR(filename), dir);
> >  	if (IS_ERR(victim))
> >  		goto lookup_error;
> > -	if (d_is_negative(victim))
> > -		goto lookup_put;
> >  	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
> >  		goto lookup_busy;
> >  	return victim;
> > =20
> >  lookup_busy:
> >  	ret =3D -EBUSY;
> > -lookup_put:
> > -	inode_unlock(d_inode(dir));
> > -	dput(victim);
> > +	end_removing(victim);
> >  	return ERR_PTR(ret);
> > =20
> >  lookup_error:
> > -	inode_unlock(d_inode(dir));
> >  	ret =3D PTR_ERR(victim);
> >  	if (ret =3D=3D -ENOENT)
> >  		return ERR_PTR(-ESTALE); /* Probably got retired by the netfs */
> > @@ -816,18 +813,17 @@ int cachefiles_cull(struct cachefiles_cache *cache,=
 struct dentry *dir,
> > =20
> >  	ret =3D cachefiles_bury_object(cache, NULL, dir, victim,
> >  				     FSCACHE_OBJECT_WAS_CULLED);
> > +	dput(victim);
> >  	if (ret < 0)
> >  		goto error;
> > =20
> >  	fscache_count_culled();
> > -	dput(victim);
> >  	_leave(" =3D 0");
> >  	return 0;
> > =20
> >  error_unlock:
> > -	inode_unlock(d_inode(dir));
> > +	end_removing(victim);
> >  error:
> > -	dput(victim);
> >  	if (ret =3D=3D -ENOENT)
> >  		return -ESTALE; /* Probably got retired by the netfs */
> > =20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 8873ad0f05b0..38dda29552f6 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3248,6 +3248,33 @@ struct dentry *start_creating(struct mnt_idmap *id=
map, struct dentry *parent,
> >  }
> >  EXPORT_SYMBOL(start_creating);
> > =20
> > +/**
> > + * start_removing - prepare to remove a given name with permission check=
ing
> > + * @idmap:  idmap of the mount
> > + * @parent: directory in which to find the name
> > + * @name:   the name to be removed
> > + *
> > + * Locks are taken and a lookup in performed prior to removing
> > + * an object from a directory.  Permission checking (MAY_EXEC) is perfor=
med
> > + * against @idmap.
> > + *
> > + * If the name doesn't exist, an error is returned.
> > + *
> > + * end_removing() should be called when removal is complete, or aborted.
> > + *
> > + * Returns: a positive dentry, or an error.
> > + */
> > +struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> > +			      struct qstr *name)
> > +{
> > +	int err =3D lookup_one_common(idmap, name, parent);
> > +
> > +	if (err)
> > +		return ERR_PTR(err);
> > +	return start_dirop(parent, name, 0);
> > +}
> > +EXPORT_SYMBOL(start_removing);
> > +
> >  #ifdef CONFIG_UNIX98_PTYS
> >  int path_pts(struct path *path)
> >  {
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index c247a7c3291c..3eefaa2202e3 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -324,20 +324,12 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *=
nn)
> >  	dprintk("NFSD: nfsd4_unlink_clid_dir. name %s\n", name);
> > =20
> >  	dir =3D nn->rec_file->f_path.dentry;
> > -	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> > -	dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(name), dir);
> > -	if (IS_ERR(dentry)) {
> > -		status =3D PTR_ERR(dentry);
> > -		goto out_unlock;
> > -	}
> > -	status =3D -ENOENT;
> > -	if (d_really_is_negative(dentry))
> > -		goto out;
> > +	dentry =3D start_removing(&nop_mnt_idmap, dir, &QSTR(name));
> > +	if (IS_ERR(dentry))
> > +		return PTR_ERR(dentry);
> > +
> >  	status =3D vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
> > -out:
> > -	dput(dentry);
> > -out_unlock:
> > -	inode_unlock(d_inode(dir));
> > +	end_removing(dentry);
> >  	return status;
> >  }
> > =20
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 24e501abad0e..6291c371caa7 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -2044,7 +2044,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> >  {
> >  	struct dentry	*dentry, *rdentry;
> >  	struct inode	*dirp;
> > -	struct inode	*rinode;
> > +	struct inode	*rinode =3D NULL;
> >  	__be32		err;
> >  	int		host_err;
> > =20
> > @@ -2063,24 +2063,21 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, int type,
> > =20
> >  	dentry =3D fhp->fh_dentry;
> >  	dirp =3D d_inode(dentry);
> > -	inode_lock_nested(dirp, I_MUTEX_PARENT);
> > =20
> > -	rdentry =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
> > +	rdentry =3D start_removing(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, fle=
n));
> > +
> >  	host_err =3D PTR_ERR(rdentry);
> >  	if (IS_ERR(rdentry))
> > -		goto out_unlock;
> > +		goto out_drop_write;
> > =20
> > -	if (d_really_is_negative(rdentry)) {
> > -		dput(rdentry);
> > -		host_err =3D -ENOENT;
> > -		goto out_unlock;
> > -	}
> > -	rinode =3D d_inode(rdentry);
> >  	err =3D fh_fill_pre_attrs(fhp);
> >  	if (err !=3D nfs_ok)
> >  		goto out_unlock;
> > =20
> > +	rinode =3D d_inode(rdentry);
> > +	/* Prevent truncation until after locks dropped */
> >  	ihold(rinode);
> > +
> >  	if (!type)
> >  		type =3D d_inode(rdentry)->i_mode & S_IFMT;
> > =20
> > @@ -2102,10 +2099,10 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, int type,
> >  	}
> >  	fh_fill_post_attrs(fhp);
> > =20
> > -	inode_unlock(dirp);
> > -	if (!host_err)
> > +out_unlock:
> > +	end_removing(rdentry);
> > +	if (!err && !host_err)
> >  		host_err =3D commit_metadata(fhp);
> > -	dput(rdentry);
> >  	iput(rinode);    /* truncate the inode here */
> > =20
> >  out_drop_write:
> > @@ -2123,9 +2120,6 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
> >  	}
> >  out:
> >  	return err !=3D nfs_ok ? err : nfserrno(host_err);
> > -out_unlock:
> > -	inode_unlock(dirp);
> > -	goto out_drop_write;
> >  }
> > =20
> >  /*
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index b9160fefbd00..20682afdbd20 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -866,17 +866,17 @@ static int ovl_remove_upper(struct dentry *dentry, =
bool is_dir,
> >  			goto out;
> >  	}
> > =20
> > -	inode_lock_nested(dir, I_MUTEX_PARENT);
> > -	upper =3D ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
> > -				 dentry->d_name.len);
> > +	upper =3D ovl_start_removing_upper(ofs, upperdir,
> > +					 &QSTR_LEN(dentry->d_name.name,
> > +						   dentry->d_name.len));
> >  	err =3D PTR_ERR(upper);
> >  	if (IS_ERR(upper))
> > -		goto out_unlock;
> > +		goto out_dput;
> > =20
> >  	err =3D -ESTALE;
> >  	if ((opaquedir && upper !=3D opaquedir) ||
> >  	    (!opaquedir && !ovl_matches_upper(dentry, upper)))
> > -		goto out_dput_upper;
> > +		goto out_unlock;
> > =20
> >  	if (is_dir)
> >  		err =3D ovl_do_rmdir(ofs, dir, upper);
> > @@ -892,10 +892,9 @@ static int ovl_remove_upper(struct dentry *dentry, b=
ool is_dir,
> >  	 */
> >  	if (!err)
> >  		d_drop(dentry);
> > -out_dput_upper:
> > -	dput(upper);
> >  out_unlock:
> > -	inode_unlock(dir);
> > +	end_removing(upper);
> > +out_dput:
> >  	dput(opaquedir);
> >  out:
> >  	return err;
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index beeba96cfcb2..49ad65f829dc 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -423,6 +423,14 @@ static inline struct dentry *ovl_start_creating_uppe=
r(struct ovl_fs *ofs,
> >  			      parent, name);
> >  }
> > =20
> > +static inline struct dentry *ovl_start_removing_upper(struct ovl_fs *ofs,
> > +						      struct dentry *parent,
> > +						      struct qstr *name)
> > +{
> > +	return start_removing(ovl_upper_mnt_idmap(ofs),
> > +			      parent, name);
> > +}
> > +
> >  static inline bool ovl_open_flags_need_copy_up(int flags)
> >  {
> >  	if (!flags)
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 37b72f4a64f0..6d1069f93ebf 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -91,6 +91,8 @@ struct dentry *lookup_one_positive_killable(struct mnt_=
idmap *idmap,
> > =20
> >  struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> >  			      struct qstr *name);
> > +struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> > +			      struct qstr *name);
> > =20
> >  /**
> >   * end_creating - finish action started with start_creating
> > @@ -122,6 +124,22 @@ static inline void end_creating(struct dentry *child=
, struct dentry *parent)
> >  		end_dirop(child);
> >  }
> > =20
> > +/**
> > + * end_removing - finish action started with start_removing
> > + * @child:  dentry returned by start_removing()
> > + * @parent: dentry given to start_removing()
> > + *
> > + * Unlock and release the child.
> > + *
> > + * This is identical to end_dirop().  It can be passed the result of
> > + * start_removing() whether that was successful or not, but it not needed
> > + * if start_removing() failed.
> > + */
> > +static inline void end_removing(struct dentry *child)
> > +{
> > +	end_dirop(child);
> > +}
> > +
> >  extern int follow_down_one(struct path *);
> >  extern int follow_down(struct path *path, unsigned int flags);
> >  extern int follow_up(struct path *);
>=20
> This looks fine to me (particularly the knfsd parts), but doesn't ksmbd
> need to be similarly converted?

ksmbd removes names in two places.

ksmbd_vfs_unlink() is changed to use start_removing_dentry() in the next
patch as you noticed when reviewing it.

ksmbd_vfs_remove_file() is called after ksmbd_vfs_kern_path_locked()
which is only used there.  I should possible renamed to
ksmbd_vfs_kern_path_start_removing() and then the "do_lock" flag to
__ksmbd_vfs_kern_path() and ksmbd_vfs_path_lookup() should become
"for_remove" and then the lock/lookup in the "if (do_lock)" branch
(which will become "if (for_remove)") should use start_removing.

I'll insert a patch to do this.

>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks,
NeilBrown



