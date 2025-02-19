Return-Path: <linux-fsdevel+bounces-42025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A043A3AD21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 01:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA6A16D6FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 00:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B51A28D;
	Wed, 19 Feb 2025 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JWDu6Ntg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CT6L9jjj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JWDu6Ntg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CT6L9jjj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EECDEEAA
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925235; cv=none; b=rMUq6H9frWXzI2gW8S7r/XkNlvpRbY/YXntQXmk7HchQs36v1ko8SLsgsITxoI8inoetkyiwp2imHAQ7sn+ZFsRD1rACszPUQRdgr0WwXlzFSjp4iovvo6vPfFN/Uh8DL2fGU+7SDSjrnWXwBqcoN+21XYyQkds3SHmydgrA53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925235; c=relaxed/simple;
	bh=pqS5oTvAk0giOqfJRkK2BApGw4XmrLld11iaLG8GYWw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UaI4hHkIztgvC5/Jnwr6Ml9Pd/ZDJaWGnfpYRy4uCC9xk5MpgGvw1Lb3a76EJwJ1aE5fNuSbq+SyXERwCnPZ7xqs8CXRi61oNSTQcaZdqUH7b+e0Ufcit/cHvb+/C0/+T1IYSwDVhD4Fox2vmJgQN/IcQxwkNSTdXg2AorIj56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=fail smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JWDu6Ntg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CT6L9jjj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JWDu6Ntg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CT6L9jjj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5CCA1F399;
	Wed, 19 Feb 2025 00:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739925230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw08EzFgdB6JLWlY70hu+Irj6szsZNns2mHfhg1FblE=;
	b=JWDu6NtgOtAwAiNjvIvz7jJYVYInd+aPgKUXCktVCYBBNfCw1em7dFR7Yar5ATegxItjtv
	J7dBxSxoKBqtcRxsmGCJ9EMVq815GHc+51qrf/OHE0LisVRVGmcqxH2/TTYWli/cSqVDZd
	MzgfJe+PlBEi1DjGIf9Uf96MsgFzXz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739925230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw08EzFgdB6JLWlY70hu+Irj6szsZNns2mHfhg1FblE=;
	b=CT6L9jjjM6NgTUd+8nQYiOrgUAMFm1eeXnVtJ1bC5uHu1fjS6/nEQfMiotgni//NRAQ2kA
	OqfBgegi75RYKkCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739925230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw08EzFgdB6JLWlY70hu+Irj6szsZNns2mHfhg1FblE=;
	b=JWDu6NtgOtAwAiNjvIvz7jJYVYInd+aPgKUXCktVCYBBNfCw1em7dFR7Yar5ATegxItjtv
	J7dBxSxoKBqtcRxsmGCJ9EMVq815GHc+51qrf/OHE0LisVRVGmcqxH2/TTYWli/cSqVDZd
	MzgfJe+PlBEi1DjGIf9Uf96MsgFzXz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739925230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw08EzFgdB6JLWlY70hu+Irj6szsZNns2mHfhg1FblE=;
	b=CT6L9jjjM6NgTUd+8nQYiOrgUAMFm1eeXnVtJ1bC5uHu1fjS6/nEQfMiotgni//NRAQ2kA
	OqfBgegi75RYKkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9430E13A53;
	Wed, 19 Feb 2025 00:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y87PEuwmtWcNGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Feb 2025 00:33:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] VFS: Change vfs_mkdir() to return the dentry.
In-reply-to: <29c98d43dee593901a37dd910851c9606a7e9278.camel@kernel.org>
References: <>, <29c98d43dee593901a37dd910851c9606a7e9278.camel@kernel.org>
Date: Wed, 19 Feb 2025 11:33:44 +1100
Message-id: <173992522496.3118120.85231226577537565@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 19 Feb 2025, Jeff Layton wrote:
> On Mon, 2025-02-17 at 16:30 +1100, NeilBrown wrote:
> > vfs_mkdir() does not currently guarantee to leave the child dentry
> > hashed or make it positive on success.  It may leave it unhashed and
> > negative and then the caller needs to perform a lookup to find the
> > target dentry, if it needs it.
> >=20
> > This patch changes vfs_mkdir() to return the dentry provided by the
> > filesystems which is hashed and positive when provided.  This reduces
> > the need for lookup code which is now included in vfs_mkdir() rather
> > than at various call-sites.  The included lookup does not include the
> > permission check that some of the existing code included in e.g.
> > lookup_one_len().  This should not be necessary for lookup up a
> > directory which has just be successfully created.
> >=20
> > If a different dentry is returned, the first one is put.  If necessary
> > the fact that it is new can be determined by comparing pointers.  A new
> > dentry will certainly have a new pointer (as the old is put after the
> > new is obtained).
> >=20
> > The dentry returned by vfs_mkdir(), when not an error, *is* now
> > guaranteed to be hashed and positive.
> >=20
> > A few callers do not need the dentry, but will now sometimes perform the
> > lookup anyway.  This should be cheap except possibly in the case of cifs.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  drivers/base/devtmpfs.c  |  7 ++--
> >  fs/cachefiles/namei.c    | 10 +++---
> >  fs/ecryptfs/inode.c      | 14 +++++---
> >  fs/init.c                |  7 ++--
> >  fs/namei.c               | 70 +++++++++++++++++++++++++++++++---------
> >  fs/nfsd/nfs4recover.c    |  7 ++--
> >  fs/nfsd/vfs.c            | 28 +++++-----------
> >  fs/overlayfs/dir.c       | 37 +++------------------
> >  fs/overlayfs/overlayfs.h | 15 ++++-----
> >  fs/overlayfs/super.c     |  7 ++--
> >  fs/smb/server/vfs.c      | 31 ++++++------------
> >  fs/xfs/scrub/orphanage.c |  9 +++---
> >  include/linux/fs.h       |  4 +--
> >  13 files changed, 121 insertions(+), 125 deletions(-)
> >=20
> > diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> > index c9e34842139f..8ec756b5dec4 100644
> > --- a/drivers/base/devtmpfs.c
> > +++ b/drivers/base/devtmpfs.c
> > @@ -160,18 +160,17 @@ static int dev_mkdir(const char *name, umode_t mode)
> >  {
> >  	struct dentry *dentry;
> >  	struct path path;
> > -	int err;
> > =20
> >  	dentry =3D kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
> >  	if (IS_ERR(dentry))
> >  		return PTR_ERR(dentry);
> > =20
> > -	err =3D vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
> > -	if (!err)
> > +	dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode=
);
> > +	if (!IS_ERR(dentry))
> >  		/* mark as kernel-created inode */
> >  		d_inode(dentry)->i_private =3D &thread;
> >  	done_path_create(&path, dentry);
> > -	return err;
> > +	return PTR_ERR_OR_ZERO(dentry);
> >  }
> > =20
> >  static int create_path(const char *nodepath)
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index 7cf59713f0f7..8a8337d1be05 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -95,7 +95,6 @@ struct dentry *cachefiles_get_directory(struct cachefil=
es_cache *cache,
> >  	/* search the current directory for the element name */
> >  	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> > =20
> > -retry:
> >  	ret =3D cachefiles_inject_read_error();
> >  	if (ret =3D=3D 0)
> >  		subdir =3D lookup_one_len(dirname, dir, strlen(dirname));
> > @@ -128,10 +127,11 @@ struct dentry *cachefiles_get_directory(struct cach=
efiles_cache *cache,
> >  		ret =3D security_path_mkdir(&path, subdir, 0700);
> >  		if (ret < 0)
> >  			goto mkdir_error;
> > -		ret =3D cachefiles_inject_write_error();
> > -		if (ret =3D=3D 0)
> > -			ret =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> > -		if (ret < 0) {
> > +		subdir =3D ERR_PTR(cachefiles_inject_write_error());
> > +		if (!IS_ERR(subdir))
> > +			subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> > +		ret =3D PTR_ERR(subdir);
> > +		if (IS_ERR(subdir)) {
> >  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
> >  						   cachefiles_trace_mkdir_error);
> >  			goto mkdir_error;
> > diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> > index 6315dd194228..51a5c54eb740 100644
> > --- a/fs/ecryptfs/inode.c
> > +++ b/fs/ecryptfs/inode.c
> > @@ -511,10 +511,16 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idm=
ap *idmap, struct inode *dir,
> >  	struct inode *lower_dir;
> > =20
> >  	rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> > -	if (!rc)
> > -		rc =3D vfs_mkdir(&nop_mnt_idmap, lower_dir,
> > -			       lower_dentry, mode);
> > -	if (rc || d_really_is_negative(lower_dentry))
> > +	if (rc)
> > +		goto out;
> > +
> > +	lower_dentry =3D vfs_mkdir(&nop_mnt_idmap, lower_dir,
> > +				 lower_dentry, mode);
> > +	rc =3D PTR_ERR(lower_dentry);
> > +	if (IS_ERR(lower_dentry))
> > +		goto out;
> > +	rc =3D 0;
> > +	if (d_unhashed(lower_dentry))
> >  		goto out;
> >  	rc =3D ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
> >  	if (rc)
> > diff --git a/fs/init.c b/fs/init.c
> > index e9387b6c4f30..eef5124885e3 100644
> > --- a/fs/init.c
> > +++ b/fs/init.c
> > @@ -230,9 +230,12 @@ int __init init_mkdir(const char *pathname, umode_t =
mode)
> >  		return PTR_ERR(dentry);
> >  	mode =3D mode_strip_umask(d_inode(path.dentry), mode);
> >  	error =3D security_path_mkdir(&path, dentry, mode);
> > -	if (!error)
> > -		error =3D vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> > +	if (!error) {
> > +		dentry =3D vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> >  				  dentry, mode);
> > +		if (IS_ERR(dentry))
> > +			error =3D PTR_ERR(dentry);
> > +	}
> >  	done_path_create(&path, dentry);
> >  	return error;
> >  }
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 19d5ea340a18..f76fee6df369 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4132,7 +4132,8 @@ EXPORT_SYMBOL(kern_path_create);
> > =20
> >  void done_path_create(struct path *path, struct dentry *dentry)
> >  {
> > -	dput(dentry);
> > +	if (!IS_ERR(dentry))
> > +		dput(dentry);
> >  	inode_unlock(path->dentry->d_inode);
> >  	mnt_drop_write(path->mnt);
> >  	path_put(path);
> > @@ -4278,7 +4279,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filenam=
e, umode_t, mode, unsigned, d
> >  }
> > =20
> >  /**
> > - * vfs_mkdir - create directory
> > + * vfs_mkdir - create directory returning correct dentry is possible
> >   * @idmap:	idmap of the mount the inode was found from
> >   * @dir:	inode of the parent directory
> >   * @dentry:	dentry of the child directory
> > @@ -4291,9 +4292,20 @@ SYSCALL_DEFINE3(mknod, const char __user *, filena=
me, umode_t, mode, unsigned, d
> >   * care to map the inode according to @idmap before checking permissions.
> >   * On non-idmapped mounts or if permission checking is to be performed o=
n the
> >   * raw inode simply pass @nop_mnt_idmap.
> > + *
> > + * In the event that the filesystem does not use the *@dentry but leaves=
 it
> > + * negative or unhashes it and possibly splices a different one returnin=
g it,
> > + * the original dentry is dput() and the alternate is returned.
> > + *
> > + * If the file-system reports success but leaves the dentry unhashed or
> > + * negative, a lookup is performed and providing that is positive and
> > + * a directory, it will be returned.  If the lookup is not successful
> > + * the original dentry is unhashed and returned.
> > + *
> > + * In case of an error the dentry is dput() and an ERR_PTR() is returned.
> >   */
> > -int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> > -	      struct dentry *dentry, umode_t mode)
> > +struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> > +			 struct dentry *dentry, umode_t mode)
> >  {
> >  	int error;
> >  	unsigned max_links =3D dir->i_sb->s_max_links;
> > @@ -4301,30 +4313,54 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct ino=
de *dir,
> > =20
> >  	error =3D may_create(idmap, dir, dentry);
> >  	if (error)
> > -		return error;
> > +		goto err;
> > =20
> > +	error =3D -EPERM;
> >  	if (!dir->i_op->mkdir)
> > -		return -EPERM;
> > +		goto err;
> > =20
> >  	mode =3D vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> >  	error =3D security_inode_mkdir(dir, dentry, mode);
> >  	if (error)
> > -		return error;
> > +		goto err;
> > =20
> > +	error =3D -EMLINK;
> >  	if (max_links && dir->i_nlink >=3D max_links)
> > -		return -EMLINK;
> > +		goto err;
> > =20
> >  	de =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
> > +	error =3D PTR_ERR(de);
> >  	if (IS_ERR(de))
> > -		return PTR_ERR(de);
> > +		goto err;
> > +	if (!de && (d_unhashed(dentry) || d_is_negative(dentry))) {
>=20
> Would it be better to push this down into the callers that need it and
> make returning a hashed, positive dentry a requirement for the mkdir
> operation?

nit: I think you mean callees, not callers ?

>=20
> You could just turn this block of code into a helper function that
> those four filesystems could call, which would mean that you could
> avoid the d_unhashed() and d_is_negative() checks on the other
> filesystems.

yes and no.  or maybe...

yes: I would rally like to require that ->mkdir always provided a hashed
positive dentry on success.
no: I would not do it by asking them to use this case, as each
filesystem could more easily do it with internal interfaces more
simply
yes: I guess we could impose this code as a first-cut and encourage each
fs to convert it to better internal code
no: it isn't always possible.  cifs is the main problem (that I'm aware
of).

 cifs is a network filesystem but doesn't (I think) have a concept
 comparable with the NFS filehandle.  I think some handle is involved
 when a file is open, but not otherwise.  The only handle you can use on
 a non-open file is the path name.  This is actually much the same as
 the POSIX user-space interface.
 It means that if you "mkdir" and directory and then want to act on it,
 you need to give the name again, and some other process might have
 removed, or moved the directory and possibly put something else under
 the same name between the lookup and the subsequent act.  So inside
 cifs it can perform a remote lookup for the name after the mkdir and
 might find a directory and can reasonable expect it to be the same
 directory and can fill in some inode information.  But it might find a
 file, or nothing...

How much does this matter?  Is POSIX doesn't allow a 'stat' after
'mkdir' to guarantee to hit the same object, why do we need it in the
kernel?

1/ nfsd needs to reply to "mkdir" with a filehandle for the created
   directory.  This is actually optional in v3 and v4.  So providing we
   get the filesys to return a good dentry whenever it can, we don't
   really need the lookup when the filesys honestly cannot provide
   something.=20

2/ ksmbd wants to effect an "inherit_owner" request to set the owner
   of the child to match the parent ... though it only writes the uid,
   it doesn't call setattr, so that doesn't seem all that important
   for the filesystems which would be problematic

3/ cachefiles ... I've messed up that part of the patch!
   It wants to start creating files in the directory.  I now think it
   would be safest for cachefiles to refused to work on filesystems
   which cannot give an inode back from a mkdir request.  The code in
   question is quite able to fail of something looks wrong.  The inode
   being NULL should just be another wrong thing.

So thanks for asking.  I think it is important for ->mkdir to be able to
return a good dentry if it is possible, but we must accept that
sometimes it isn't possible and I now don't think it is worthwhile for
the in-kernel clients to try a lookup in those cases.  Filesystems can
be encouraged to do the best they can and clients shouldn't assume they
can do any better.

I'll revise my last patch.

Thanks,
NeilBrown


