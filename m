Return-Path: <linux-fsdevel+bounces-41135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B5EA2B6D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 00:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AF518858A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 23:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A52376EC;
	Thu,  6 Feb 2025 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FDY7pVT2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mB1z9KtZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yqw7VyYB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e1GdTYAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7622654C;
	Thu,  6 Feb 2025 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738885977; cv=none; b=sB26b4SoPhtMz2gb18kSuVN04Ql8pvrCfWEmi8htOxtXhmNYwcOOwA68oMluw+99guDioePdIiqzmItdb2hWLGOnnwHNsIih5NutLvfsA+r3+mYeliLdXXbaMWIsFy53tauTiJB+6xrPN+MZ5j4EjxntfSwvQZzvdrwo7PLHtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738885977; c=relaxed/simple;
	bh=waCZGt17ZFqqxDl/mzVheUB74OvKBqC10ELzxSig4WI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qHT1oliDT8Z89BnXSIG+C+vWRTYO6Koe30KprINwG9pP+Genca9mxYZakOxyw8KgX/LzP2LFbeHp31YSNYOH9ZqjgrZSerwV7VDGC7WXYhkcIT22hCyDJA/5zWuo6/6pvvjj/xz6yCg0qP3wirRYFCIkF2sxGvGeLkIaMy6t/t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FDY7pVT2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mB1z9KtZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yqw7VyYB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e1GdTYAs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27B1521164;
	Thu,  6 Feb 2025 23:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738885973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZoMQAJ88dy0e5doIO+VVPKOriTHGnYyn4XI9eydaeI=;
	b=FDY7pVT2Q0dWogGDi2pIib0f9t2DXBrvgNsp4eheMDQvWaT6vvfNwJIGsHJTJlISjIdliW
	p8aqbO/ohTzFMFd0JLNmM2MORbN0FJYTGrZ4qbgGrXiQ6AAl3vKOaLSQyFzOMGPFGbqX4P
	lMnO3KZZrqSe8UFhx5hZfJ3Lxo1yLVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738885973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZoMQAJ88dy0e5doIO+VVPKOriTHGnYyn4XI9eydaeI=;
	b=mB1z9KtZ8O2MH1+9AQxMjKgiF5OBCCGkzenQn27+dvndYeaQMkWIVG9RPCOd80X5RSBkbg
	qMT8SogAO6XKTxCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yqw7VyYB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e1GdTYAs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738885972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZoMQAJ88dy0e5doIO+VVPKOriTHGnYyn4XI9eydaeI=;
	b=yqw7VyYBGJ6E3lGMT3uaCb0TrTLNz8bR1AcRatYqmRdSF4067oXE+CQsbN/wzZZp1GEMPE
	HIIDwrlt/vlDMDMDuKoCT6+VEsJuX0ei0xDQeMR1T/cD2k+2FBMte++1nKZaX5pmx9LtDf
	JCOpY3qOIFM0Oo/f/GH697abiSaNIXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738885972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZoMQAJ88dy0e5doIO+VVPKOriTHGnYyn4XI9eydaeI=;
	b=e1GdTYAslIP7dfB8rLLqXZG7RopX8+wvKshEI3DFciy2R0cUu6qmm1XR3t6/rN46uPMp4S
	LfbgEqwuGhiszwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 621CC13697;
	Thu,  6 Feb 2025 23:52:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +/B+BVFLpWfvRQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 23:52:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] VFS: introduce vfs_mkdir_return()
In-reply-to: <20250206-zeugnis-vorsehen-a0f524cd0c8b@brauner>
References: <>, <20250206-zeugnis-vorsehen-a0f524cd0c8b@brauner>
Date: Fri, 07 Feb 2025 10:52:37 +1100
Message-id: <173888595790.22054.15435342804967126282@noble.neil.brown.name>
X-Rspamd-Queue-Id: 27B1521164
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 06 Feb 2025, Christian Brauner wrote:
> On Thu, Feb 06, 2025 at 04:42:38PM +1100, NeilBrown wrote:
> > vfs_mkdir() does not guarantee to make the child dentry positive on
> > success.  It may leave it negative and then the caller needs to perform a
> > lookup to find the target dentry.
> >=20
> > This patch introduced vfs_mkdir_return() which performs the lookup if
> > needed so that this code is centralised.
> >=20
> > This prepares for a new inode operation which will perform mkdir and
> > returns the correct dentry.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/cachefiles/namei.c    |  7 +---
> >  fs/namei.c               | 69 ++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/vfs.c            | 21 ++----------
> >  fs/overlayfs/dir.c       | 33 +------------------
> >  fs/overlayfs/overlayfs.h | 10 +++---
> >  fs/overlayfs/super.c     |  2 +-
> >  fs/smb/server/vfs.c      | 24 +++-----------
> >  include/linux/fs.h       |  2 ++
> >  8 files changed, 86 insertions(+), 82 deletions(-)
> >=20
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index 7cf59713f0f7..3c866c3b9534 100644
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
> > @@ -130,7 +129,7 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
> >  			goto mkdir_error;
> >  		ret =3D cachefiles_inject_write_error();
> >  		if (ret =3D=3D 0)
> > -			ret =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> > +			ret =3D vfs_mkdir_return(&nop_mnt_idmap, d_inode(dir), &subdir, 0700);
> >  		if (ret < 0) {
> >  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
> >  						   cachefiles_trace_mkdir_error);
> > @@ -138,10 +137,6 @@ struct dentry *cachefiles_get_directory(struct cache=
files_cache *cache,
> >  		}
> >  		trace_cachefiles_mkdir(dir, subdir);
> > =20
> > -		if (unlikely(d_unhashed(subdir))) {
> > -			cachefiles_put_directory(subdir);
> > -			goto retry;
> > -		}
> >  		ASSERT(d_backing_inode(subdir));
> > =20
> >  		_debug("mkdir -> %pd{ino=3D%lu}",
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 3ab9440c5b93..d98caf36e867 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4317,6 +4317,75 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inod=
e *dir,
> >  }
> >  EXPORT_SYMBOL(vfs_mkdir);
> > =20
> > +/**
> > + * vfs_mkdir_return - create directory returning correct dentry
> > + * @idmap:	idmap of the mount the inode was found from
> > + * @dir:	inode of the parent directory
> > + * @dentryp:	pointer to dentry of the child directory
> > + * @mode:	mode of the child directory
> > + *
> > + * Create a directory.
> > + *
> > + * If the inode has been found through an idmapped mount the idmap of
> > + * the vfsmount must be passed through @idmap. This function will then t=
ake
> > + * care to map the inode according to @idmap before checking permissions.
> > + * On non-idmapped mounts or if permission checking is to be performed o=
n the
> > + * raw inode simply pass @nop_mnt_idmap.
> > + *
> > + * The filesystem may not use the dentry that was passed in.  In that ca=
se
> > + * the passed-in dentry is put and a new one is placed in *@dentryp;
> > + * So on successful return *@dentryp will always be positive.
> > + */
> > +int vfs_mkdir_return(struct mnt_idmap *idmap, struct inode *dir,
> > +		     struct dentry **dentryp, umode_t mode)
> > +{
>=20
> I think this is misnamed. Maybe vfs_mkdir_positive() is better here.
> It also be nice to have a comment on vfs_mkdir() as well pointing out
> that the returned dentry might be negative.

While I'm not particularly fond of vfs_mkdir_return(), I don't see that
vfs_mkdir_positive() is an improvement.  I cannot find any relevant
precedent in the kernel to guide.  Most _return and _positive functions
are for low-level counting primitives :-)

I'm tempted to add another arg to vfs_mkdir() instead of adding a new
function.  That would solve one problem by introducing another: what
arg?  Maybe pass both a 'struct dentry *' and a 'struct dentry **' and
if the latter is not NULL, it gets filled with the new dentry if there
is one.

>=20
> And is there a particular reason to not have it return the new dentry?
> That seems clearer than using the argument as a return value.

If I did that then every caller would need to check if the return value
was not IS_ERR_OR_NULL() and if so, dput() the original dentry and keep
the new one - just like current callers of ->lookup need to.  It seems
cleaner to do that once in vfs_mkdir_return() rather than in all the
callers.  I guess we could *always* return the dentry on success and
dput the old one if it was different or if there were an error.  So

   dentry =3D vfs_mkdir_return(idmap, inode, dentry, mode)

would be the common pattern.  Would you be OK with that?


>=20
> > +	struct dentry *dentry =3D *dentryp;
> > +	int error;
> > +	unsigned max_links =3D dir->i_sb->s_max_links;
> > +
> > +	error =3D may_create(idmap, dir, dentry);
> > +	if (error)
> > +		return error;
> > +
> > +	if (!dir->i_op->mkdir)
> > +		return -EPERM;
> > +
> > +	mode =3D vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> > +	error =3D security_inode_mkdir(dir, dentry, mode);
> > +	if (error)
> > +		return error;
> > +
> > +	if (max_links && dir->i_nlink >=3D max_links)
> > +		return -EMLINK;
> > +
> > +	error =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
>=20
> Why isn't this calling vfs_mkdir() and then only starts differing afterward=
s?

Because once we introduce the new ->mkdir_async which returns a dentry
the two functions start to diverge more.
I could have a __vfs_mkdir() which does both and has a bool arg to tell
it if we want the return value.  That would avoid code duplication.

>=20
> > +	if (!error) {
> > +		fsnotify_mkdir(dir, dentry);
> > +		if (unlikely(d_unhashed(dentry))) {
> > +			struct dentry *d;
> > +			/* Need a "const" pointer.  We know d_name is const
> > +			 * because we hold an exclusive lock on i_rwsem
> > +			 * in d_parent.
> > +			 */
> > +			const struct qstr *d_name =3D (void*)&dentry->d_name;
> > +			d =3D lookup_dcache(d_name, dentry->d_parent, 0);
> > +			if (!d)
> > +				d =3D __lookup_slow(d_name, dentry->d_parent, 0);
>=20
> Quite a few caller's use lookup_one() here which calls
> inode_permission() on @dir again. Are we guaranteed that the permission
> check would always pass?

I think they use lookup_one() because that was the easiest, not because
they need all the functionality.
If the process had permission to create a directory with a given name
but now doesn't have permission to look up that same name, then
something is weird.  Maybe a race with permission changing could do
that.  But I think the process should have the right to hold the dentry
that it has just successfully created.
The lookup is hopefully just a work-around until the new improved
interface is used by all relevant filesystems.


Thanks,
NeilBrown

