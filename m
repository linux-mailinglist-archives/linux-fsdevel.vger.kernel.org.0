Return-Path: <linux-fsdevel+bounces-41559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A016DA31D03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 04:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1C23A81FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 03:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3571DED47;
	Wed, 12 Feb 2025 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KhETt/2k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ArvtdY0L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KhETt/2k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ArvtdY0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7836AF5;
	Wed, 12 Feb 2025 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331919; cv=none; b=inN9tTNCVix2862DXgJgsbIgTkGELBwFw1BvyN+SA7Ha2SV9u0MMvJdRONjHo6kHLoRFpyhnBv254Uuaf0CSm7rqoO1qgsASup08KxZOC1fFZaCMiINNvPWFzeXn5Y6Duc8CNYiKl3EUpi5OwkJCyvp+px92SA66rVh0OYObp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331919; c=relaxed/simple;
	bh=Qc5HrmEsvinr55OrvplZE6l3v6LB5CNpR8d/hitsSm0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZRs4zu1H8n/vkIgqjZxuwv7r6aN4bDD8dEObXmH7L8LTh6xG3XjZluzdJF5Ie6HU7cw+Et9oZ1JWZiLgbJhF6WqEhs4XmC/Ychb0j4jm1nbQjDZZjQIehbiOLkE41KEnKvH/demHS1NYePHEYrDLSg+93WsSivUJWBl33Bc3Wzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KhETt/2k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ArvtdY0L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KhETt/2k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ArvtdY0L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B12D1200CF;
	Wed, 12 Feb 2025 03:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739331913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCZ+8jrSQCsSAVfd6pHaHlFYfOUW/BKVv9ILN0Jg2fo=;
	b=KhETt/2kRlArwEzS6RC97xoS3iBpEB/7KQEblA4KQo5TG0cKpBzjk4bbahvrNVL7pd1o4T
	p4RjqSd2mow0WYKO4zWHj82PCRj//YJWzkDrzgdkeYYqlp8K+oniNWiaS/8IGFCR+Oyr+4
	NjxXcjbEls+zJf/CFHnJ+wdnYhum5ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739331913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCZ+8jrSQCsSAVfd6pHaHlFYfOUW/BKVv9ILN0Jg2fo=;
	b=ArvtdY0LGBbpU1bXFyECbdjFyUy8Hh3MMVOGUObshyAPkFIZxTQkHWUjJk3899zsZJAdl3
	c9wP81LQRJW8MVCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="KhETt/2k";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ArvtdY0L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739331913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCZ+8jrSQCsSAVfd6pHaHlFYfOUW/BKVv9ILN0Jg2fo=;
	b=KhETt/2kRlArwEzS6RC97xoS3iBpEB/7KQEblA4KQo5TG0cKpBzjk4bbahvrNVL7pd1o4T
	p4RjqSd2mow0WYKO4zWHj82PCRj//YJWzkDrzgdkeYYqlp8K+oniNWiaS/8IGFCR+Oyr+4
	NjxXcjbEls+zJf/CFHnJ+wdnYhum5ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739331913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCZ+8jrSQCsSAVfd6pHaHlFYfOUW/BKVv9ILN0Jg2fo=;
	b=ArvtdY0LGBbpU1bXFyECbdjFyUy8Hh3MMVOGUObshyAPkFIZxTQkHWUjJk3899zsZJAdl3
	c9wP81LQRJW8MVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FB4613707;
	Wed, 12 Feb 2025 03:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dvOcMUIZrGdEXgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Feb 2025 03:45:06 +0000
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
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Tom Talpey" <tom@talpey.com>, "Paul Moore" <paul@paul-moore.com>,
 "Eric Paris" <eparis@redhat.com>, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject:
 Re: [PATCH 2/2] VFS: add common error checks to lookup_one_qstr_excl()
In-reply-to: <20250212032505.GM1977892@ZenIV>
References: <>, <20250212032505.GM1977892@ZenIV>
Date: Wed, 12 Feb 2025 14:45:04 +1100
Message-id: <173933190416.22054.5881139463496565922@noble.neil.brown.name>
X-Rspamd-Queue-Id: B12D1200CF
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 12 Feb 2025, Al Viro wrote:
> On Wed, Feb 12, 2025 at 03:16:08AM +0000, Al Viro wrote:
> > On Fri, Feb 07, 2025 at 02:36:48PM +1100, NeilBrown wrote:
> > > @@ -1690,6 +1692,15 @@ struct dentry *lookup_one_qstr_excl(const struct=
 qstr *name,
> > >  		dput(dentry);
> > >  		dentry =3D old;
> > >  	}
> > > +found:
> >=20
> > ... and if ->lookup() returns an error, this will blow up (as bot has just
> > reported).

Yes, I need an early exit if (IS_ERR(dentry)).  Thanks.

> >=20
> > > +	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
> > > +		dput(dentry);
> > > +		return ERR_PTR(-ENOENT);
> > > +	}
> > > +	if (d_is_positive(dentry) && (flags & LOOKUP_EXCL)) {
> > > +		dput(dentry);
> > > +		return ERR_PTR(-EEXIST);
> > > +	}
> >=20
> >=20
> > > @@ -4077,27 +4084,13 @@ static struct dentry *filename_create(int dfd, =
struct filename *name,
> > >  	 * '/', and a directory wasn't requested.
> > >  	 */
> > >  	if (last.name[last.len] && !want_dir)
> > > -		create_flags =3D 0;
> > > +		create_flags &=3D ~LOOKUP_CREATE;
> >=20
> > See the patch I've posted in earlier thread; the entire "strip LOOKUP_CRE=
ATE"
> > thing is wrong.
>=20
> On top of mainline that's
>=20
> filename_create(): don't force handling trailing slashes into the common pa=
th
>=20
> Only mkdir accepts pathnames that end with / - anything like mknod() (symli=
nk(),
> etc.) always fails on those.  Don't try to force that the common codepath -
> all we are doing is a lookup and check for existence to determine which
> error should it be.  Do that before bothering with mnt_want_write(), etc.;
> as far as underlying filesystem is concerned it's just a lookup.  Simplifies
> the normal codepath and kills the lookup intent dependency on more than
> the call site.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/namei.c b/fs/namei.c
> index 3ab9440c5b93..6189e54f767a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4054,13 +4054,13 @@ static struct dentry *filename_create(int dfd, stru=
ct filename *name,
>  	struct dentry *dentry =3D ERR_PTR(-EEXIST);
>  	struct qstr last;
>  	bool want_dir =3D lookup_flags & LOOKUP_DIRECTORY;
> -	unsigned int reval_flag =3D lookup_flags & LOOKUP_REVAL;
> -	unsigned int create_flags =3D LOOKUP_CREATE | LOOKUP_EXCL;
>  	int type;
>  	int err2;
>  	int error;
> =20
> -	error =3D filename_parentat(dfd, name, reval_flag, path, &last, &type);
> +	lookup_flags &=3D LOOKUP_REVAL;
> +
> +	error =3D filename_parentat(dfd, name, lookup_flags, path, &last, &type);
>  	if (error)
>  		return ERR_PTR(error);
> =20
> @@ -4070,18 +4070,28 @@ static struct dentry *filename_create(int dfd, stru=
ct filename *name,
>  	 */
>  	if (unlikely(type !=3D LAST_NORM))
>  		goto out;
> +	/*
> +	 * mkdir foo/bar/ is OK, but for anything else a slash in the end
> +	 * is always an error; the only question is which one.
> +	 */
> +	if (unlikely(last.name[last.len] && !want_dir)) {
> +		dentry =3D lookup_dcache(&last, path->dentry, lookup_flags);
> +		if (!dentry)
> +			dentry =3D lookup_slow(&last, path->dentry, lookup_flags);

I do see some value in the simplicity of this approach, though maybe not
as much value as you see.  But the above uses inode_lock_share(), rather
than the nested version, so lockdep will complain.
If you open-code a nested lock, or write a new helper, you get very
close to the sequence for calling lookup_one_qstr_excl() below.  So
it isn't clear to me that the benefit is worth the cost.

This current code in filename_create isn't actually wrong is it?

Thanks,
NeilBrown



> +		if (!IS_ERR(dentry)) {
> +			error =3D d_is_positive(dentry) ? -EEXIST : -ENOENT;
> +			dput(dentry);
> +			dentry =3D ERR_PTR(error);
> +		}
> +		goto out;
> +	}
> =20
>  	/* don't fail immediately if it's r/o, at least try to report other error=
s */
>  	err2 =3D mnt_want_write(path->mnt);
> -	/*
> -	 * Do the final lookup.  Suppress 'create' if there is a trailing
> -	 * '/', and a directory wasn't requested.
> -	 */
> -	if (last.name[last.len] && !want_dir)
> -		create_flags =3D 0;
> +	/* do the final lookup */
>  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
>  	dentry =3D lookup_one_qstr_excl(&last, path->dentry,
> -				      reval_flag | create_flags);
> +				lookup_flags | LOOKUP_CREATE | LOOKUP_EXCL);
>  	if (IS_ERR(dentry))
>  		goto unlock;
> =20
> @@ -4089,16 +4099,6 @@ static struct dentry *filename_create(int dfd, struc=
t filename *name,
>  	if (d_is_positive(dentry))
>  		goto fail;
> =20
> -	/*
> -	 * Special case - lookup gave negative, but... we had foo/bar/
> -	 * From the vfs_mknod() POV we just have a negative dentry -
> -	 * all is fine. Let's be bastards - you had / on the end, you've
> -	 * been asking for (non-existent) directory. -ENOENT for you.
> -	 */
> -	if (unlikely(!create_flags)) {
> -		error =3D -ENOENT;
> -		goto fail;
> -	}
>  	if (unlikely(err2)) {
>  		error =3D err2;
>  		goto fail;
>=20


