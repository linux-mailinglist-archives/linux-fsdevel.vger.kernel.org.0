Return-Path: <linux-fsdevel+bounces-41146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1874A2B8C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 03:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5211672F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 02:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10221519B4;
	Fri,  7 Feb 2025 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ss6c7U/l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SArUN9Ff";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ss6c7U/l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SArUN9Ff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A522417D3;
	Fri,  7 Feb 2025 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894635; cv=none; b=Sz7OkpckGsChFe0ieYJ7jddrAtAOclsMCB97CfSnjGV8hpg8jK6vYVwZvRVGV3vnBvVMRlZi3ALLpETe0PaNU8GcDXCo7Zt6ngXvH2CDABq19EceFmDwJ08TeM3oTJj/HqnNx6MwwjVwDXeilaTttdmC16M2W/+5r9RoHvvfAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894635; c=relaxed/simple;
	bh=1e+RwjPPN2sO50qBjYvICNRSf32YSEvUcVQpef1EMVk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cEmSgIB6tCl8MpEFtNF4aeGpDze5Jva5KNYDW6kUR7H55MXWnUgUrMG2dtQh0KB/AV3+X4xw/QcEz+sdpcqeaI59vBgK3txLeZkoRpA3zjKZ/UVMJE9PEA06xqazfaHz/ZPpiAyT/jUBNEF8hhd9neS5HUuKlTDfuTp1+pgBtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ss6c7U/l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SArUN9Ff; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ss6c7U/l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SArUN9Ff; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FDE41F38D;
	Fri,  7 Feb 2025 02:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738894631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9MfRUjBovYT7C8N+g0JKWAPi7xoFRWK3tvTcwzpMM4=;
	b=ss6c7U/lv/wXpwg2bU8lY3uVSXXiA6dI0mC2wyeVBJ3pfm4k3l4n3nbAPmaeVo6dF0NLEF
	7BJRfdMdG4C4dUi0r37EdU8Smbm4z/ykBtIWp+/yDNWN7Mr8XrHrMOreM6jE/jvps3fgQx
	YNoKg8NBiECSZua8Ygxk2khV/BzHgA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738894631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9MfRUjBovYT7C8N+g0JKWAPi7xoFRWK3tvTcwzpMM4=;
	b=SArUN9FfwPh9SQzO7XTNbIwdS6PcHi7m2c9op1pd7rBCzhNChR6Wb70maMWbBzEdcy69wp
	QXSwbvLh2uwukwBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738894631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9MfRUjBovYT7C8N+g0JKWAPi7xoFRWK3tvTcwzpMM4=;
	b=ss6c7U/lv/wXpwg2bU8lY3uVSXXiA6dI0mC2wyeVBJ3pfm4k3l4n3nbAPmaeVo6dF0NLEF
	7BJRfdMdG4C4dUi0r37EdU8Smbm4z/ykBtIWp+/yDNWN7Mr8XrHrMOreM6jE/jvps3fgQx
	YNoKg8NBiECSZua8Ygxk2khV/BzHgA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738894631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9MfRUjBovYT7C8N+g0JKWAPi7xoFRWK3tvTcwzpMM4=;
	b=SArUN9FfwPh9SQzO7XTNbIwdS6PcHi7m2c9op1pd7rBCzhNChR6Wb70maMWbBzEdcy69wp
	QXSwbvLh2uwukwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC9E713806;
	Fri,  7 Feb 2025 02:17:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4aZzHyRtpWfsagAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 02:17:08 +0000
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
Subject: Re: [PATCH 14/19] VFS: Ensure no async updates happening in directory
 being removed.
In-reply-to: <20250206-ungeeignet-erhielten-1e46ff51d728@brauner>
References: <>, <20250206-ungeeignet-erhielten-1e46ff51d728@brauner>
Date: Fri, 07 Feb 2025 13:17:01 +1100
Message-id: <173889462175.22054.10174686267926452398@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 07 Feb 2025, Christian Brauner wrote:
> On Thu, Feb 06, 2025 at 04:42:51PM +1100, NeilBrown wrote:
> > vfs_rmdir takes an exclusive lock on the target directory to ensure
> > nothing new is created in it while the rmdir progresses.  With the
>=20
> It also excludes concurrent mount operations.

And it excludes chown and ACL changes.  I doubt those are important.  I
do need to check mount/unmount.

>=20
> > possibility of async updates continuing after the inode lock is dropped
> > we now need extra protection.
> >=20
> > Any async updates will have DCACHE_PAR_UPDATE set on the dentry.  We
> > simply wait for that flag to be cleared on all children.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/dcache.c |  2 +-
> >  fs/namei.c  | 40 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index fb331596f1b1..90dee859d138 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -53,7 +53,7 @@
> >   *   - d_lru
> >   *   - d_count
> >   *   - d_unhashed()
> > - *   - d_parent and d_chilren
> > + *   - d_parent and d_children
> >   *   - childrens' d_sib and d_parent
> >   *   - d_u.d_alias, d_inode
> >   *
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 3a107d6098be..e8a85c9f431c 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1839,6 +1839,27 @@ bool d_update_lock(struct dentry *dentry,
> >  	return true;
> >  }
> > =20
> > +static void d_update_wait(struct dentry *dentry, unsigned int subclass)
> > +{
> > +	/* Note this may only ever be called in a context where we have
> > +	 * a lock preventing this dentry from becoming locked, possibly
> > +	 * an update lock on the parent dentry.  The must be a smp_mb()
> > +	 * after that lock is taken and before this is called so that
> > +	 * the following test is safe. d_update_lock() provides that
> > +	 * barrier.
> > +	 */
> > +	if (!(dentry->d_flags & DCACHE_PAR_UPDATE))
> > +		return
> > +	lock_acquire_exclusive(&dentry->d_update_map, subclass,
> > +			       0, NULL, _THIS_IP_);
> > +	spin_lock(&dentry->d_lock);
> > +	wait_var_event_spinlock(&dentry->d_flags,
> > +				!check_dentry_locked(dentry),
> > +				&dentry->d_lock);
> > +	spin_unlock(&dentry->d_lock);
> > +	lock_map_release(&dentry->d_update_map);
> > +}
> > +
> >  bool d_update_trylock(struct dentry *dentry,
> >  		      struct dentry *base,
> >  		      const struct qstr *last)
> > @@ -4688,6 +4709,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode=
 *dir,
> >  		     struct dentry *dentry)
> >  {
> >  	int error =3D may_delete(idmap, dir, dentry, 1);
> > +	struct dentry *child;
> > =20
> >  	if (error)
> >  		return error;
> > @@ -4697,6 +4719,24 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inod=
e *dir,
> > =20
> >  	dget(dentry);
> >  	inode_lock(dentry->d_inode);
> > +	/*
> > +	 * Some children of dentry might be active in an async update.
> > +	 * We need to wait for them.  New children cannot be locked
> > +	 * while the inode lock is held.
> > +	 */
> > +again:
> > +	spin_lock(&dentry->d_lock);
> > +	for (child =3D d_first_child(dentry); child;
> > +	     child =3D d_next_sibling(child)) {
> > +		if (child->d_flags & DCACHE_PAR_UPDATE) {
> > +			dget(child);
> > +			spin_unlock(&dentry->d_lock);
> > +			d_update_wait(child, I_MUTEX_CHILD);
> > +			dput(child);
> > +			goto again;
> > +		}
> > +	}
> > +	spin_unlock(&dentry->d_lock);
>=20
> That looks like it can cause stalls when you call rmdir on a directory
> that has a lots of children and a larg-ish subset of them has pending
> async updates, no?
>=20

It can certainly block waiting for other operations to complete, but
that is already the case when waiting for an exclusive lock on i_rwsem.=20
Any thread that has already tried to get that lock might get it before
rmdir eventually succeeds.  So I don't think that is a behavioural
change.

I'm not concerned about walking the sibling list under a spinlock if the
list if very long.  Maybe I could periodically take a ref to the current
child, drop and reclaim the spinlock, and hopefully continue from there.
Doing that on a non-D_PAR_UPDATE dentry should be safe.  I wonder if
that complexity is worth it.

Thanks,
NeilBrown

