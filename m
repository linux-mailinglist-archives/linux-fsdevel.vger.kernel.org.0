Return-Path: <linux-fsdevel+bounces-30128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DD3986945
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 00:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00941C20F30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 22:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899615884A;
	Wed, 25 Sep 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kGZ3Mr79";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qzz1Yl9n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kGZ3Mr79";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qzz1Yl9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974E14A4F7;
	Wed, 25 Sep 2024 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727304150; cv=none; b=cEepf6PgUGvSYCf0kr7pL8aGNlT4b1hzGoBqtoXhJSBT0+Q0suYk/LwfA/xZXK91y7kXRsGXQW6hxibh5klFLABe/rzOO5CcVnKXPxJe6hnYtL0rARJH6QHyKm7hTUsT6Pn7pQ1RK0TeCnvSlKG3hMtO1jarF9tf0SiigNcCx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727304150; c=relaxed/simple;
	bh=x86wChhTp2lt/uWnUdhLiOkh/OWqELNmLmBC9IqiF/Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rNshtWEKRf4Et7pneMJA78RWo4O/+bxKEcEBHiY/vBAPpAA+WJNqQjkfnyanqCPx6loanvewVJV7wVg0xndxBLgWvRJKJrPkHhegpACHFUsYj0+/FNT10jjyKwL8bcG7xCBlKvM0dT5cVquepfjeT1L85+8Q0YIZaB4zsySg7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kGZ3Mr79; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qzz1Yl9n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kGZ3Mr79; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qzz1Yl9n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 041B021AE9;
	Wed, 25 Sep 2024 22:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727304147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdFnuXTTBbFcdFksPYy3Lj53mCkrYzN5k4YxwFnAMD4=;
	b=kGZ3Mr79cm5x/GUuNiXEVyyImQOYtGWtnxdBNeDqNHJRzcQicqj4ZVgiJKpQYJndW6eZ7t
	U0E8xD25CHZqHgBA54d1nb8Q9yGlIOpjeK6FbZpvYV1YeR1gTK05qUqiUfGnL/g5iprxPY
	voJ/p8egRfC/dlV0tZ2xbDioQG40kZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727304147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdFnuXTTBbFcdFksPYy3Lj53mCkrYzN5k4YxwFnAMD4=;
	b=qzz1Yl9naG/hiB/agN5NSykjAfyK8F1I+legtSoDSVtXkIc47W+KPgWEBDC4r5R8WD9u61
	9T2t1tYWPTL/HNDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727304147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdFnuXTTBbFcdFksPYy3Lj53mCkrYzN5k4YxwFnAMD4=;
	b=kGZ3Mr79cm5x/GUuNiXEVyyImQOYtGWtnxdBNeDqNHJRzcQicqj4ZVgiJKpQYJndW6eZ7t
	U0E8xD25CHZqHgBA54d1nb8Q9yGlIOpjeK6FbZpvYV1YeR1gTK05qUqiUfGnL/g5iprxPY
	voJ/p8egRfC/dlV0tZ2xbDioQG40kZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727304147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdFnuXTTBbFcdFksPYy3Lj53mCkrYzN5k4YxwFnAMD4=;
	b=qzz1Yl9naG/hiB/agN5NSykjAfyK8F1I+legtSoDSVtXkIc47W+KPgWEBDC4r5R8WD9u61
	9T2t1tYWPTL/HNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5998513885;
	Wed, 25 Sep 2024 22:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EUbAA9CR9GZsdAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 22:42:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH - RFC] VFS: disable new delegations during
 delegation-breaking operations
In-reply-to: <20240925221956.GM3550746@ZenIV>
References: <172646129988.17050.4729474250083101679@noble.neil.brown.name>,
 <20240925221956.GM3550746@ZenIV>
Date: Thu, 26 Sep 2024 08:42:06 +1000
Message-id: <172730412642.17050.14414465745251978669@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 26 Sep 2024, Al Viro wrote:
> On Mon, Sep 16, 2024 at 02:34:59PM +1000, NeilBrown wrote:
>=20
> > @@ -5011,7 +5012,8 @@ int do_renameat2(int olddfd, struct filename *from,=
 int newdfd,
> >  	struct path old_path, new_path;
> >  	struct qstr old_last, new_last;
> >  	int old_type, new_type;
> > -	struct inode *delegated_inode =3D NULL;
> > +	struct inode *delegated_inode_old =3D NULL;
> > +	struct inode *delegated_inode_new =3D NULL;
> >  	unsigned int lookup_flags =3D 0, target_flags =3D LOOKUP_RENAME_TARGET;
> >  	bool should_retry =3D false;
> >  	int error =3D -EINVAL;
> > @@ -5118,7 +5120,8 @@ int do_renameat2(int olddfd, struct filename *from,=
 int newdfd,
> >  	rd.new_dir	   =3D new_path.dentry->d_inode;
> >  	rd.new_dentry	   =3D new_dentry;
> >  	rd.new_mnt_idmap   =3D mnt_idmap(new_path.mnt);
> > -	rd.delegated_inode =3D &delegated_inode;
> > +	rd.delegated_inode_old =3D &delegated_inode_old;
> > +	rd.delegated_inode_new =3D &delegated_inode_new;
> >  	rd.flags	   =3D flags;
> >  	error =3D vfs_rename(&rd);
> >  exit5:
> > @@ -5128,9 +5131,14 @@ int do_renameat2(int olddfd, struct filename *from=
, int newdfd,
> >  exit3:
> >  	unlock_rename(new_path.dentry, old_path.dentry);
> >  exit_lock_rename:
> > -	if (delegated_inode) {
> > -		error =3D break_deleg_wait(&delegated_inode);
> > -		if (!error)
> > +	if (delegated_inode_old) {
> > +		error =3D break_deleg_wait(&delegated_inode_old, error);
> > +		if (error =3D=3D -EWOULDBLOCK)
> > +			goto retry_deleg;
>=20
> Won't that goto leak a reference to delegated_inode_new?

I don't think so.
The old delegated_inode_new will be carried in to vfs_rename() and
passed to try_break_deleg() which will notice that it is not-NULL and
will "do the right thing".

Both _old and _new are initialised to zero at the start of
do_renameat2(), Both are passed to break_deleg_wait() on the last time
through the retry_deleg loop which will drop the references - or will
preserve the reference if it isn't the last time - and both are only set
by try_break_deleg() which is careful to check if a prior value exists.
So I think there are no leaks.

Thanks,
NeilBrown


>=20
> > +	}
> > +	if (delegated_inode_new) {
> > +		error =3D break_deleg_wait(&delegated_inode_new, error);
> > +		if (error =3D=3D -EWOULDBLOCK)
> >  			goto retry_deleg;
> >  	}
> >  	mnt_drop_write(old_path.mnt);
>=20
> > -static inline int break_deleg_wait(struct inode **delegated_inode)
> > +static inline int break_deleg_wait(struct inode **delegated_inode, int r=
et)
> >  {
> > -	int ret;
> > -
> > -	ret =3D break_deleg(*delegated_inode, O_WRONLY);
> > -	iput(*delegated_inode);
> > -	*delegated_inode =3D NULL;
> > +	if (ret =3D=3D -EWOULDBLOCK) {
> > +		ret =3D break_deleg(*delegated_inode, O_WRONLY);
> > +		if (ret =3D=3D 0)
> > +			ret =3D -EWOULDBLOCK;
> > +	}
> > +	if (ret !=3D -EWOULDBLOCK) {
> > +		atomic_dec(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
> > +		iput(*delegated_inode);
> > +		*delegated_inode =3D NULL;
> > +	}
> >  	return ret;
> >  }
>=20


