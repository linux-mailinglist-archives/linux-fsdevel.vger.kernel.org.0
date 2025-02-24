Return-Path: <linux-fsdevel+bounces-42381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3F6A413B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 03:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF6F7A15D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13481A3031;
	Mon, 24 Feb 2025 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lk/uqCJj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nC37crRK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rTreylf5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UtAzLv+z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BBD198850
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365529; cv=none; b=Nl+wGdXrjr6cN4jUZlYpA1x0IpY/CnGfio+ZM3fA3ZV0G1S8E/dXkN1GrPxXXNWzZB4f7ncM1IQsA7pX2Ok2a6ytuE99uMPQY/lJrVNjclkvZOBf+4JbHWHZbxFtUuOCNrtofR4KVF8Ry5Wg4YoJ/KnlDWoRB1U+XwCp/uoYn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365529; c=relaxed/simple;
	bh=jXWor17FKnDDhH0VmC5rCoae7iirHq7pFepPZzbda1c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kPD3PkpHc8UOD2BYaC7xmVy9ROc+p9rYTahzGMTdLstaMqHD3w3MdG6/GWI4g6syvNIBMZWz+A+m5Exjl6qo+AbJxwndNLg6gpO5v+D9JnNki60fAqbXCCshtiBiEtOZ5ZU8IsZ1RlvRVjUOkEoz+Rs1aH7uPkRu/pDIapz8ddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lk/uqCJj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nC37crRK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rTreylf5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UtAzLv+z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D85891F383;
	Mon, 24 Feb 2025 02:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740365524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF0P8a6Hwqb95loG5irVcapgwjZVYtE4gO0QxGgiXKQ=;
	b=Lk/uqCJjdUedvIhGrbOAhb8qtZ3FfBPtE8qHepyDIlrpFbh/yZ01eiQxtE0rKc+jEleib+
	LA7V135lQ2hI1sT35cd6C3lABAgoCYLZb96H1FpDNNX2nvJtJgCgJpI5xIH447L/MZoPho
	oabDOojCcr2vu9Tk3Y7Rs1LPjTFnKJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740365524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF0P8a6Hwqb95loG5irVcapgwjZVYtE4gO0QxGgiXKQ=;
	b=nC37crRKvzCDWHFvhLEPngNSUcjS8veQogPaXTK4/xMSfgMn3Va7tsnLP8TJXuh4XVdfPZ
	i1xGq9X/ZNMeB0CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740365522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF0P8a6Hwqb95loG5irVcapgwjZVYtE4gO0QxGgiXKQ=;
	b=rTreylf5qRbHpxi0Ie6+jW+DLuU1eaXKk5q3GZlOrPiM3ts2gDZb0b9UfdKoQXBibzTIDG
	HDaQaoxaLkmtsGXUH0wwAenyFfVlNFX3oCh/ZbU6+eyzXy2fRx4JLaBHj3XmV77HN7JQJe
	YeRLrwciELmH3FLeSg4sT4LLL8Hkg5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740365522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF0P8a6Hwqb95loG5irVcapgwjZVYtE4gO0QxGgiXKQ=;
	b=UtAzLv+zO/zhrpZzsvVcXozs26QN4HAyaaOEqxBUY+hU+6nmIeKpoqzqqmU0GYWFXZx45B
	+nK2BFE0IZUk3mDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D28413332;
	Mon, 24 Feb 2025 02:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lp4zNMneu2eXfAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Feb 2025 02:51:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
 netfs@lists.linux.dev
Subject: Re: [PATCH 6/6] VFS: Change vfs_mkdir() to return the dentry.
In-reply-to: <01a3f184-940c-494e-ade2-775e3441fc4e@oracle.com>
References: <>, <01a3f184-940c-494e-ade2-775e3441fc4e@oracle.com>
Date: Mon, 24 Feb 2025 13:51:50 +1100
Message-id: <174036551056.74271.9438990163654268476@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 22 Feb 2025, Chuck Lever wrote:
> On 2/20/25 6:36 PM, NeilBrown wrote:
...
> > +		dchild =3D vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
> > +		if (IS_ERR(dchild)) {
> > +			host_err =3D PTR_ERR(dchild);
> > +		} else if (d_is_negative(dchild)) {
> > +			err =3D nfserr_serverfault;
> > +			goto out;
> > +		} else if (unlikely(dchild !=3D resfhp->fh_dentry)) {
> >  			dput(resfhp->fh_dentry);
> > -			resfhp->fh_dentry =3D dget(d);
> > -			err =3D fh_update(resfhp);
>=20
> Hi Neil, why is this fh_update() call no longer necessary?
>=20

I tried to explain that in the commit message:

                                        I removed the fh_update()
      call as that is not needed and out-of-place.  A subsequent
      nfsd_create_setattr() call will call fh_update() when needed.

I don't think the fh_update() was needed even when first added in=20
Commit 3819bb0d79f5 ("nfsd: vfs_mkdir() might succeed leaving dentry negative=
 unhashed")

as there was already an fh_update() call later in the function.

Thanks,
NeilBrown



>=20
> > -			dput(dchild);
> > -			dchild =3D d;
> > -			if (err)
> > -				goto out;
> > +			resfhp->fh_dentry =3D dget(dchild);
> >  		}
> >  		break;
> >  	case S_IFCHR:
> > @@ -1530,7 +1517,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> >  	err =3D nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
> > =20
> >  out:
> > -	dput(dchild);
> > +	if (!IS_ERR(dchild))
> > +		dput(dchild);
> >  	return err;
> > =20
> >  out_nfserr:
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 21c3aaf7b274..fe493f3ed6b6 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -138,37 +138,6 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, str=
uct inode *dir,
> >  	goto out;
> >  }
> > =20
> > -int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
> > -		   struct dentry **newdentry, umode_t mode)
> > -{
> > -	int err;
> > -	struct dentry *d, *dentry =3D *newdentry;
> > -
> > -	err =3D ovl_do_mkdir(ofs, dir, dentry, mode);
> > -	if (err)
> > -		return err;
> > -
> > -	if (likely(!d_unhashed(dentry)))
> > -		return 0;
> > -
> > -	/*
> > -	 * vfs_mkdir() may succeed and leave the dentry passed
> > -	 * to it unhashed and negative. If that happens, try to
> > -	 * lookup a new hashed and positive dentry.
> > -	 */
> > -	d =3D ovl_lookup_upper(ofs, dentry->d_name.name, dentry->d_parent,
> > -			     dentry->d_name.len);
> > -	if (IS_ERR(d)) {
> > -		pr_warn("failed lookup after mkdir (%pd2, err=3D%i).\n",
> > -			dentry, err);
> > -		return PTR_ERR(d);
> > -	}
> > -	dput(dentry);
> > -	*newdentry =3D d;
> > -
> > -	return 0;
> > -}
> > -
> >  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
> >  			       struct dentry *newdentry, struct ovl_cattr *attr)
> >  {
> > @@ -191,7 +160,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, st=
ruct inode *dir,
> > =20
> >  		case S_IFDIR:
> >  			/* mkdir is special... */
> > -			err =3D  ovl_mkdir_real(ofs, dir, &newdentry, attr->mode);
> > +			newdentry =3D  ovl_do_mkdir(ofs, dir, newdentry, attr->mode);
> > +			err =3D PTR_ERR_OR_ZERO(newdentry);
> >  			break;
> > =20
> >  		case S_IFCHR:
> > @@ -219,7 +189,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, st=
ruct inode *dir,
> >  	}
> >  out:
> >  	if (err) {
> > -		dput(newdentry);
> > +		if (!IS_ERR(newdentry))
> > +			dput(newdentry);
> >  		return ERR_PTR(err);
> >  	}
> >  	return newdentry;
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 0021e2025020..6f2f8f4cfbbc 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -241,13 +241,14 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
> >  	return err;
> >  }
> > =20
> > -static inline int ovl_do_mkdir(struct ovl_fs *ofs,
> > -			       struct inode *dir, struct dentry *dentry,
> > -			       umode_t mode)
> > +static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
> > +					  struct inode *dir,
> > +					  struct dentry *dentry,
> > +					  umode_t mode)
> >  {
> > -	int err =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> > -	pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, err);
> > -	return err;
> > +	dentry =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> > +	pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZERO(den=
try));
> > +	return dentry;
> >  }
> > =20
> >  static inline int ovl_do_mknod(struct ovl_fs *ofs,
> > @@ -838,8 +839,6 @@ struct ovl_cattr {
> > =20
> >  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode =3D (m) })
> > =20
> > -int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
> > -		   struct dentry **newdentry, umode_t mode);
> >  struct dentry *ovl_create_real(struct ovl_fs *ofs,
> >  			       struct inode *dir, struct dentry *newdentry,
> >  			       struct ovl_cattr *attr);
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 61e21c3129e8..b63474d1b064 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -327,9 +327,10 @@ static struct dentry *ovl_workdir_create(struct ovl_=
fs *ofs,
> >  			goto retry;
> >  		}
> > =20
> > -		err =3D ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
> > -		if (err)
> > -			goto out_dput;
> > +		work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> > +		err =3D PTR_ERR(work);
> > +		if (IS_ERR(work))
> > +			goto out_err;
> > =20
> >  		/* Weird filesystem returning with hashed negative (kernfs)? */
> >  		err =3D -EINVAL;
> > diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> > index fe29acef5872..8554aa5a1059 100644
> > --- a/fs/smb/server/vfs.c
> > +++ b/fs/smb/server/vfs.c
> > @@ -206,8 +206,8 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const ch=
ar *name, umode_t mode)
> >  {
> >  	struct mnt_idmap *idmap;
> >  	struct path path;
> > -	struct dentry *dentry;
> > -	int err;
> > +	struct dentry *dentry, *d;
> > +	int err =3D 0;
> > =20
> >  	dentry =3D ksmbd_vfs_kern_path_create(work, name,
> >  					    LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
> > @@ -222,27 +222,15 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const =
char *name, umode_t mode)
> > =20
> >  	idmap =3D mnt_idmap(path.mnt);
> >  	mode |=3D S_IFDIR;
> > -	err =3D vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
> > -	if (!err && d_unhashed(dentry)) {
> > -		struct dentry *d;
> > -
> > -		d =3D lookup_one(idmap, dentry->d_name.name, dentry->d_parent,
> > -			       dentry->d_name.len);
> > -		if (IS_ERR(d)) {
> > -			err =3D PTR_ERR(d);
> > -			goto out_err;
> > -		}
> > -		if (unlikely(d_is_negative(d))) {
> > -			dput(d);
> > -			err =3D -ENOENT;
> > -			goto out_err;
> > -		}
> > -
> > -		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
> > -		dput(d);
> > -	}
> > +	d =3D dentry;
> > +	dentry =3D vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
> > +	if (IS_ERR(dentry))
> > +		err =3D PTR_ERR(dentry);
> > +	else if (d_is_negative(dentry))
> > +		err =3D -ENOENT;
> > +	if (!err && dentry !=3D d)
> > +		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(dentry));
> > =20
> > -out_err:
> >  	done_path_create(&path, dentry);
> >  	if (err)
> >  		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
> > diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> > index c287c755f2c5..3537f3cca6d5 100644
> > --- a/fs/xfs/scrub/orphanage.c
> > +++ b/fs/xfs/scrub/orphanage.c
> > @@ -167,10 +167,11 @@ xrep_orphanage_create(
> >  	 * directory to control access to a file we put in here.
> >  	 */
> >  	if (d_really_is_negative(orphanage_dentry)) {
> > -		error =3D vfs_mkdir(&nop_mnt_idmap, root_inode, orphanage_dentry,
> > -				0750);
> > -		if (error)
> > -			goto out_dput_orphanage;
> > +		orphanage_dentry =3D vfs_mkdir(&nop_mnt_idmap, root_inode,
> > +					     orphanage_dentry, 0750);
> > +		error =3D PTR_ERR(orphanage_dentry);
> > +		if (IS_ERR(orphanage_dentry))
> > +			goto out_unlock_root;
> >  	}
> > =20
> >  	/* Not a directory? Bail out. */
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 8f4fbecd40fc..eaad8e31c0d4 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1971,8 +1971,8 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
> >   */
> >  int vfs_create(struct mnt_idmap *, struct inode *,
> >  	       struct dentry *, umode_t, bool);
> > -int vfs_mkdir(struct mnt_idmap *, struct inode *,
> > -	      struct dentry *, umode_t);
> > +struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
> > +			 struct dentry *, umode_t);
> >  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
> >                umode_t, dev_t);
> >  int vfs_symlink(struct mnt_idmap *, struct inode *,
>=20
>=20
> --=20
> Chuck Lever
>=20


