Return-Path: <linux-fsdevel+bounces-41142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7148EA2B7DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 02:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F6B188938D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 01:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B725E13D638;
	Fri,  7 Feb 2025 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pbr/Ebv6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="URtQ2pIJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pbr/Ebv6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="URtQ2pIJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB192417EF;
	Fri,  7 Feb 2025 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891734; cv=none; b=nBmsq//HextpFyYGhzPIRdh/Dtb+IdYlS1/09zJQlBFTru+2I34ueyICkO4I2kVYECmCf9c9CaPvruY7j5iriDuOnm8KJ0c850vUP/nhokNtHerV8EfrzTbLHK0sSyhJV5LaIpQxsZ6rBrD+YCXbJ6OZClJgEuOnTkHFQCvFdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891734; c=relaxed/simple;
	bh=Ey5UTQgIuNSeHVOPVOqWRUOfs5NUVVEmfvVeZunpzk4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=h18W1pQNTOCso3SMhiI92YP6M1BAoOGjahIcA372WiIn3rs5niT+DXctesRDUBnIH6fR+ephm//+lB8mV/OSdwbnGtWOgtaPaqaTsod6vnBkS4JRV+Dueky9vrCFRV9DyQKbR+9D3xthSD4RM6k7jbCS2t3BGP0UFQ3pTIpoLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pbr/Ebv6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=URtQ2pIJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pbr/Ebv6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=URtQ2pIJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F72221163;
	Fri,  7 Feb 2025 01:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738891730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2AsCPfAHkdj1ZuTyMgTvB/NeYaxqCP1+QJQCWZHIP0=;
	b=Pbr/Ebv6U3up2NFWLh0u8SYLxl4W8tZHhB4/OsGbFgIDnsohaMa9ATUJJQGUk0EjNf7ezO
	EhJJyZGjTIMCrT7no2FIU95wDgks5bkvz7QvpfxtspgjJtIQhuZ1NRv2MZRkX3F8Pur41U
	3tfoGCnQn6Nmrn+bti+91PmencroXXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738891730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2AsCPfAHkdj1ZuTyMgTvB/NeYaxqCP1+QJQCWZHIP0=;
	b=URtQ2pIJdFBdKb+0LMB6TOdRYhkv6H4P41IUh62jNzA5+SQNZnZEDtOjvbNjrW+zu6m5+x
	bGIsxIExu41J4WDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Pbr/Ebv6";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=URtQ2pIJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738891730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2AsCPfAHkdj1ZuTyMgTvB/NeYaxqCP1+QJQCWZHIP0=;
	b=Pbr/Ebv6U3up2NFWLh0u8SYLxl4W8tZHhB4/OsGbFgIDnsohaMa9ATUJJQGUk0EjNf7ezO
	EhJJyZGjTIMCrT7no2FIU95wDgks5bkvz7QvpfxtspgjJtIQhuZ1NRv2MZRkX3F8Pur41U
	3tfoGCnQn6Nmrn+bti+91PmencroXXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738891730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2AsCPfAHkdj1ZuTyMgTvB/NeYaxqCP1+QJQCWZHIP0=;
	b=URtQ2pIJdFBdKb+0LMB6TOdRYhkv6H4P41IUh62jNzA5+SQNZnZEDtOjvbNjrW+zu6m5+x
	bGIsxIExu41J4WDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BCCF13694;
	Fri,  7 Feb 2025 01:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GMTmD89hpWd6XQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 01:28:47 +0000
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
Subject: Re: [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
In-reply-to: <20250206-herde-zunutze-2ad5be3fea78@brauner>
References: <>, <20250206-herde-zunutze-2ad5be3fea78@brauner>
Date: Fri, 07 Feb 2025 12:28:44 +1100
Message-id: <173889172414.22054.10997679254257474673@noble.neil.brown.name>
X-Rspamd-Queue-Id: 4F72221163
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 07 Feb 2025, Christian Brauner wrote:
> On Thu, Feb 06, 2025 at 04:42:45PM +1100, NeilBrown wrote:
> > lookup_and_lock() combines locking the directory and performing a lookup
> > prior to a change to the directory.
> > Abstracting this prepares for changing the locking requirements.
> >=20
> > done_lookup_and_lock() provides the inverse of putting the dentry and
> > unlocking.
> >=20
> > For "silly_rename" we will need to lookup_and_lock() in a directory that
> > is already locked.  For this purpose we add LOOKUP_PARENT_LOCKED.
> >=20
> > Like lookup_len_qstr(), lookup_and_lock() returns -ENOENT if
> > LOOKUP_CREATE was NOT given and the name cannot be found,, and returns
> > -EEXIST if LOOKUP_EXCL WAS given and the name CAN be found.
> >=20
> > These functions replace all uses of lookup_one_qstr() in namei.c
> > except for those used for rename.
> >=20
> > The name might seem backwards as the lock happens before the lookup.
> > A future patch will change this so that only a shared lock is taken
> > before the lookup, and an exclusive lock on the dentry is taken after a
> > successful lookup.  So the order "lookup" then "lock" will make sense.
> >=20
> > This functionality is exported as lookup_and_lock_one() which takes a
> > name and len rather than a qstr.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/namei.c            | 102 ++++++++++++++++++++++++++++--------------
> >  include/linux/namei.h |  15 ++++++-
> >  2 files changed, 83 insertions(+), 34 deletions(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 69610047f6c6..3c0feca081a2 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1715,6 +1715,41 @@ struct dentry *lookup_one_qstr(const struct qstr *=
name,
> >  }
> >  EXPORT_SYMBOL(lookup_one_qstr);
> > =20
> > +static struct dentry *lookup_and_lock_nested(const struct qstr *last,
> > +					     struct dentry *base,
> > +					     unsigned int lookup_flags,
> > +					     unsigned int subclass)
> > +{
> > +	struct dentry *dentry;
> > +
> > +	if (!(lookup_flags & LOOKUP_PARENT_LOCKED))
> > +		inode_lock_nested(base->d_inode, subclass);
> > +
> > +	dentry =3D lookup_one_qstr(last, base, lookup_flags);
> > +	if (IS_ERR(dentry) && !(lookup_flags & LOOKUP_PARENT_LOCKED)) {
> > +			inode_unlock(base->d_inode);
>=20
> Nit: The indentation here is wrong and the {} aren't common practice.

Thanks.

>=20
> > +	}
> > +	return dentry;
> > +}
> > +
> > +static struct dentry *lookup_and_lock(const struct qstr *last,
> > +				      struct dentry *base,
> > +				      unsigned int lookup_flags)
> > +{
> > +	return lookup_and_lock_nested(last, base, lookup_flags,
> > +				      I_MUTEX_PARENT);
> > +}
> > +
> > +void done_lookup_and_lock(struct dentry *base, struct dentry *dentry,
> > +			  unsigned int lookup_flags)
>=20
> Did you mean done_lookup_and_unlock()?

No.  The thing that we are done with is "lookup_and_lock()".
This matches "done_path_create()" which doesn't create anything.

On the other hand we have d_lookup_done() which puts _done at the end.
Or end_name_hash().  ->write_end(), finish_automount()

I guess I could accept done_lookup_and_unlock() if you prefer that.

>=20
> > +{
> > +	d_lookup_done(dentry);
> > +	dput(dentry);
> > +	if (!(lookup_flags & LOOKUP_PARENT_LOCKED))
> > +		inode_unlock(base->d_inode);
> > +}
> > +EXPORT_SYMBOL(done_lookup_and_lock);
> > +
> >  /**
> >   * lookup_fast - do fast lockless (but racy) lookup of a dentry
> >   * @nd: current nameidata
> > @@ -2754,12 +2789,9 @@ static struct dentry *__kern_path_locked(int dfd, =
struct filename *name, struct
> >  		path_put(path);
> >  		return ERR_PTR(-EINVAL);
> >  	}
> > -	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
> > -	d =3D lookup_one_qstr(&last, path->dentry, 0);
> > -	if (IS_ERR(d)) {
> > -		inode_unlock(path->dentry->d_inode);
> > +	d =3D lookup_and_lock(&last, path->dentry, 0);
> > +	if (IS_ERR(d))
> >  		path_put(path);
> > -	}
> >  	return d;
> >  }
> > =20
> > @@ -3053,6 +3085,22 @@ struct dentry *lookup_positive_unlocked(const char=
 *name,
> >  }
> >  EXPORT_SYMBOL(lookup_positive_unlocked);
> > =20
> > +struct dentry *lookup_and_lock_one(struct mnt_idmap *idmap,
> > +				   const char *name, int len, struct dentry *base,
> > +				   unsigned int lookup_flags)
> > +{
> > +	struct qstr this;
> > +	int err;
> > +
> > +	if (!idmap)
> > +		idmap =3D &nop_mnt_idmap;
>=20
> The callers should pass nop_mnt_idmap. That's how every function that
> takes this argument works. This is a lot more explicit than magically
> fixing this up in the function.

OK.

Thanks,
NeilBrown

