Return-Path: <linux-fsdevel+bounces-41138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E41A2B6F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 01:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E911885179
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB1F81E;
	Fri,  7 Feb 2025 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tYVPqc4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZcgWolhn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tYVPqc4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZcgWolhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7B184;
	Fri,  7 Feb 2025 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886928; cv=none; b=FnN/+D6RJfjAzUcjiGhMv16zxaVgiBNW02cfxZhoKbQGzrFG36qHR83hK7FtvRJA/tOFRZj3D9L4CVissXCfZbFAoYliwOMrwHHinqJzxqX5wKwdZQywTAuBK6pLP60CvZd6isuHxakH5vpZJyW/ehm0+hKWKh98rDrMup4o+Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886928; c=relaxed/simple;
	bh=1R6usBM+LsTZvWsjlBzmGHuKsOpye6uZVWPv8IkL840=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Jbxqcfs/3GvvCKnkBd6GuDbLOqvDSJnMjVUayg6WPvRjGPuzZXYR00+xBqWIyJnNSsoGe7m5WvdgwFh109ZKiCmrv7RQ4ZyvRMqRyKSXcfeUGMSbqy5nxuG2K+GoSfC0URCH0NyZsDV7tFrR4gJusmQt/lpkaz4GcQCnJnq5S9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tYVPqc4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZcgWolhn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tYVPqc4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZcgWolhn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A21AB1F38D;
	Fri,  7 Feb 2025 00:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738886924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plQwxa1wkqAsSgnBriEp5ByWy+CvNHoYsmnLdolPu0I=;
	b=tYVPqc4X5CqjvqUjXCJtkPn/dQfD8tiJNjxLoPpZCEWiT53XFiKl1IKgT84uYG4Ol9BYsv
	aTbHMBvq3xVD4dP8VZe6HgPOzf+XouZpS03CIwpwEtqX6AuuWCq4g77X2FatqY7V969IeA
	+9p//iFY1PldJEKOoGGKWDanPxOL88A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738886924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plQwxa1wkqAsSgnBriEp5ByWy+CvNHoYsmnLdolPu0I=;
	b=ZcgWolhngZnG8T8axXkqbhmHr3JWmqFud4ONT/ZM7UV90xXqaS1uj/iAsOhNDWXkJL/EGy
	l4fXFyLQJg2zdpAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tYVPqc4X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZcgWolhn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738886924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plQwxa1wkqAsSgnBriEp5ByWy+CvNHoYsmnLdolPu0I=;
	b=tYVPqc4X5CqjvqUjXCJtkPn/dQfD8tiJNjxLoPpZCEWiT53XFiKl1IKgT84uYG4Ol9BYsv
	aTbHMBvq3xVD4dP8VZe6HgPOzf+XouZpS03CIwpwEtqX6AuuWCq4g77X2FatqY7V969IeA
	+9p//iFY1PldJEKOoGGKWDanPxOL88A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738886924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plQwxa1wkqAsSgnBriEp5ByWy+CvNHoYsmnLdolPu0I=;
	b=ZcgWolhngZnG8T8axXkqbhmHr3JWmqFud4ONT/ZM7UV90xXqaS1uj/iAsOhNDWXkJL/EGy
	l4fXFyLQJg2zdpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9AEC13796;
	Fri,  7 Feb 2025 00:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RcqSIglPpWd9SgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 00:08:41 +0000
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
Subject: Re: [PATCH 04/19] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
In-reply-to: <20250206-verrechnen-ablenken-d1d58bc4931c@brauner>
References: <>, <20250206-verrechnen-ablenken-d1d58bc4931c@brauner>
Date: Fri, 07 Feb 2025 11:08:38 +1100
Message-id: <173888691873.22054.11466111333534613133@noble.neil.brown.name>
X-Rspamd-Queue-Id: A21AB1F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 07 Feb 2025, Christian Brauner wrote:
> On Thu, Feb 06, 2025 at 01:31:56PM +0100, Christian Brauner wrote:
> > On Thu, Feb 06, 2025 at 04:42:41PM +1100, NeilBrown wrote:
> > > No callers of kern_path_locked() or user_path_locked_at() want a
> > > negative dentry.  So change them to return -ENOENT instead.  This
> > > simplifies callers.
> > >=20
> > > This results in a subtle change to bcachefs in that an ioctl will now
> > > return -ENOENT in preference to -EXDEV.  I believe this restores the
> > > behaviour to what it was prior to
> > >  Commit bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> >=20
> > It would be nice if you could send this as a separate cleanup patch.
> > It seems unrelated to the series.

I'll do that, thanks.

> >=20
> > >  drivers/base/devtmpfs.c | 65 +++++++++++++++++++----------------------
> > >  fs/bcachefs/fs-ioctl.c  |  4 ---
> > >  fs/namei.c              |  4 +++
> > >  kernel/audit_watch.c    | 12 ++++----
> > >  4 files changed, 40 insertions(+), 45 deletions(-)
> > >=20
> > > diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> > > index b848764ef018..c9e34842139f 100644
> > > --- a/drivers/base/devtmpfs.c
> > > +++ b/drivers/base/devtmpfs.c
> > > @@ -245,15 +245,12 @@ static int dev_rmdir(const char *name)
> > >  	dentry =3D kern_path_locked(name, &parent);
> > >  	if (IS_ERR(dentry))
> > >  		return PTR_ERR(dentry);
> > > -	if (d_really_is_positive(dentry)) {
> > > -		if (d_inode(dentry)->i_private =3D=3D &thread)
> > > -			err =3D vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
> > > -					dentry);
> > > -		else
> > > -			err =3D -EPERM;
> > > -	} else {
> > > -		err =3D -ENOENT;
> > > -	}
> > > +	if (d_inode(dentry)->i_private =3D=3D &thread)
> > > +		err =3D vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
> > > +				dentry);
> > > +	else
> > > +		err =3D -EPERM;
> > > +
> > >  	dput(dentry);
> > >  	inode_unlock(d_inode(parent.dentry));
> > >  	path_put(&parent);
> > > @@ -310,6 +307,8 @@ static int handle_remove(const char *nodename, stru=
ct device *dev)
> > >  {
> > >  	struct path parent;
> > >  	struct dentry *dentry;
> > > +	struct kstat stat;
> > > +	struct path p;
> > >  	int deleted =3D 0;
> > >  	int err;
> > > =20
> > > @@ -317,32 +316,28 @@ static int handle_remove(const char *nodename, st=
ruct device *dev)
> > >  	if (IS_ERR(dentry))
> > >  		return PTR_ERR(dentry);
> > > =20
> > > -	if (d_really_is_positive(dentry)) {
> > > -		struct kstat stat;
> > > -		struct path p =3D {.mnt =3D parent.mnt, .dentry =3D dentry};
> > > -		err =3D vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> > > -				  AT_STATX_SYNC_AS_STAT);
> > > -		if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> > > -			struct iattr newattrs;
> > > -			/*
> > > -			 * before unlinking this node, reset permissions
> > > -			 * of possible references like hardlinks
> > > -			 */
> > > -			newattrs.ia_uid =3D GLOBAL_ROOT_UID;
> > > -			newattrs.ia_gid =3D GLOBAL_ROOT_GID;
> > > -			newattrs.ia_mode =3D stat.mode & ~0777;
> > > -			newattrs.ia_valid =3D
> > > -				ATTR_UID|ATTR_GID|ATTR_MODE;
> > > -			inode_lock(d_inode(dentry));
> > > -			notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
> > > -			inode_unlock(d_inode(dentry));
> > > -			err =3D vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
> > > -					 dentry, NULL);
> > > -			if (!err || err =3D=3D -ENOENT)
> > > -				deleted =3D 1;
> > > -		}
> > > -	} else {
> > > -		err =3D -ENOENT;
> > > +	p.mnt =3D parent.mnt;
> > > +	p.dentry =3D dentry;
> > > +	err =3D vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> > > +			  AT_STATX_SYNC_AS_STAT);
> > > +	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> > > +		struct iattr newattrs;
> > > +		/*
> > > +		 * before unlinking this node, reset permissions
> > > +		 * of possible references like hardlinks
> > > +		 */
> > > +		newattrs.ia_uid =3D GLOBAL_ROOT_UID;
> > > +		newattrs.ia_gid =3D GLOBAL_ROOT_GID;
> > > +		newattrs.ia_mode =3D stat.mode & ~0777;
> > > +		newattrs.ia_valid =3D
> > > +			ATTR_UID|ATTR_GID|ATTR_MODE;
> > > +		inode_lock(d_inode(dentry));
> > > +		notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
> > > +		inode_unlock(d_inode(dentry));
> > > +		err =3D vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
> > > +				 dentry, NULL);
> > > +		if (!err || err =3D=3D -ENOENT)
> > > +			deleted =3D 1;
> > >  	}
> > >  	dput(dentry);
> > >  	inode_unlock(d_inode(parent.dentry));
> > > diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
> > > index 15725b4ce393..595b57fabc9a 100644
> > > --- a/fs/bcachefs/fs-ioctl.c
> > > +++ b/fs/bcachefs/fs-ioctl.c
> > > @@ -511,10 +511,6 @@ static long bch2_ioctl_subvolume_destroy(struct bc=
h_fs *c, struct file *filp,
> > >  		ret =3D -EXDEV;
> > >  		goto err;
> > >  	}
> > > -	if (!d_is_positive(victim)) {
> > > -		ret =3D -ENOENT;
> > > -		goto err;
> > > -	}
> > >  	ret =3D __bch2_unlink(dir, victim, true);
> > >  	if (!ret) {
> > >  		fsnotify_rmdir(dir, victim);
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index d684102d873d..1901120bcbb8 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -2745,6 +2745,10 @@ static struct dentry *__kern_path_locked(int dfd=
, struct filename *name, struct
> > >  	}
> > >  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
> > >  	d =3D lookup_one_qstr(&last, path->dentry, 0);
> > > +	if (!IS_ERR(d) && d_is_negative(d)) {
> > > +		dput(d);
> > > +		d =3D ERR_PTR(-ENOENT);
>=20
> This doesn't unlock which afaict does cause issue with your devtmpfs
> changes:

I unlocks a little further down.  The above leaves 'd' as an err, and it
followed by
	if (IS_ERR(d)) {
		inode_unlock(path->dentry->d_inode);
		path_put(path);
	}
	return d;

so I don't think there is a problem here.

Thanks for the review.

NeilBrown

