Return-Path: <linux-fsdevel+bounces-41137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D58A2B6E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 01:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A01E3A7A98
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 00:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3827FD;
	Fri,  7 Feb 2025 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XtUzndly";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XD8SlNfu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XtUzndly";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XD8SlNfu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F45672;
	Fri,  7 Feb 2025 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886684; cv=none; b=ZOTYNBqE77oonEwaDWru4KdbAhO2kdiiZ7wEjKTUQXA9gpHrIRMPxme+ENzOIDwv7b5PLBK04Wrj3qOHGcIMu6Xry1BvT727SPh+12RkY5a08kYC0m8E51bHTUCzQNOWdu5DxJmhtHqWfmd+r+gEx0BIePHIM/04WuPtydIjZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886684; c=relaxed/simple;
	bh=saVBqr/hJpTQY2RYoy4yrzJCkF3cmmC2CxC7nBWyr2Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DiF4NtZHewNHHW4p5iyHWRP7LSylhJW32xnsM7I+IV8Y9Aqbv5ai3M9h0Z2tgX0FDP3+J7ddOvkBBi+IMfSAGxiX1cqlO96MNaTgM49IVmbOg+puUhgSJBXIJq0xseP0YqsPz3BARBEbLd8sFh0GmdT8xflKhPycAAxoC8jnJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XtUzndly; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XD8SlNfu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XtUzndly; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XD8SlNfu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 533DD21160;
	Fri,  7 Feb 2025 00:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738886681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EBDJH2327sn5nnuhMv8Vs59h6qEE4J/ulDEnb+qxnI=;
	b=XtUzndly/ljBba7iumOqINDszOhU2ubUPY0G5+P8e0TAflPZ0tlw0T888sbNRO9s5RQy5f
	S0RDl4VldbCOBDhk/SEq5+DkSnRLQkmyLcTqxE26uNLxuLtizaD3n8nDc85d1+Fwx5Pjh/
	VuroSsxQ4yEMv2wuxFo611tkjJsg4jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738886681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EBDJH2327sn5nnuhMv8Vs59h6qEE4J/ulDEnb+qxnI=;
	b=XD8SlNfuPYjw6WQQQkElxc2EhoDd/a2YtZDDJxVgvM1og/8Tk/c9E45NiVSlYF4k7ZnjmS
	HNNdbBekX4kYStCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738886681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EBDJH2327sn5nnuhMv8Vs59h6qEE4J/ulDEnb+qxnI=;
	b=XtUzndly/ljBba7iumOqINDszOhU2ubUPY0G5+P8e0TAflPZ0tlw0T888sbNRO9s5RQy5f
	S0RDl4VldbCOBDhk/SEq5+DkSnRLQkmyLcTqxE26uNLxuLtizaD3n8nDc85d1+Fwx5Pjh/
	VuroSsxQ4yEMv2wuxFo611tkjJsg4jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738886681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EBDJH2327sn5nnuhMv8Vs59h6qEE4J/ulDEnb+qxnI=;
	b=XD8SlNfuPYjw6WQQQkElxc2EhoDd/a2YtZDDJxVgvM1og/8Tk/c9E45NiVSlYF4k7ZnjmS
	HNNdbBekX4kYStCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 913D713796;
	Fri,  7 Feb 2025 00:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lqwMERZOpWeMSQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 00:04:38 +0000
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
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Dave Chinner" <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/19] VFS: use d_alloc_parallel() in
 lookup_one_qstr_excl() and rename it.
In-reply-to: <017ca787f3a167302281b65e60d301d9f1c0f5de.camel@kernel.org>
References: <>, <017ca787f3a167302281b65e60d301d9f1c0f5de.camel@kernel.org>
Date: Fri, 07 Feb 2025 11:04:20 +1100
Message-id: <173888666051.22054.2064348642111556769@noble.neil.brown.name>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 07 Feb 2025, Jeff Layton wrote:
> On Thu, 2025-02-06 at 16:42 +1100, NeilBrown wrote:
> > lookup_one_qstr_excl() is used for lookups prior to directory
> > modifications, whether create, unlink, rename, or whatever.
> >=20
> > To prepare for allowing modification to happen in parallel, change
> > lookup_one_qstr_excl() to use d_alloc_parallel().
> >=20
> > To reflect this, name is changed to lookup_one_qtr() - as the directory
> > may be locked shared.
> >=20
> > If any for the "intent" LOOKUP flags are passed, the caller must ensure
> > d_lookup_done() is called at an appropriate time.  If none are passed
> > then we can be sure ->lookup() will do a real lookup and d_lookup_done()
> > is called internally.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/namei.c            | 47 +++++++++++++++++++++++++------------------
> >  fs/smb/server/vfs.c   |  7 ++++---
> >  include/linux/namei.h |  9 ++++++---
> >  3 files changed, 37 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 5cdbd2eb4056..d684102d873d 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1665,15 +1665,13 @@ static struct dentry *lookup_dcache(const struct =
qstr *name,
> >  }
> > =20
> >  /*
> > - * Parent directory has inode locked exclusive.  This is one
> > - * and only case when ->lookup() gets called on non in-lookup
> > - * dentries - as the matter of fact, this only gets called
> > - * when directory is guaranteed to have no in-lookup children
> > - * at all.
> > + * Parent directory has inode locked: exclusive or shared.
> > + * If @flags contains any LOOKUP_INTENT_FLAGS then d_lookup_done()
> > + * must be called after the intended operation is performed - or aborted.
> >   */
> > -struct dentry *lookup_one_qstr_excl(const struct qstr *name,
> > -				    struct dentry *base,
> > -				    unsigned int flags)
> > +struct dentry *lookup_one_qstr(const struct qstr *name,
> > +			       struct dentry *base,
> > +			       unsigned int flags)
> >  {
> >  	struct dentry *dentry =3D lookup_dcache(name, base, flags);
> >  	struct dentry *old;
> > @@ -1686,18 +1684,25 @@ struct dentry *lookup_one_qstr_excl(const struct =
qstr *name,
> >  	if (unlikely(IS_DEADDIR(dir)))
> >  		return ERR_PTR(-ENOENT);
> > =20
> > -	dentry =3D d_alloc(base, name);
> > -	if (unlikely(!dentry))
> > +	dentry =3D d_alloc_parallel(base, name);
> > +	if (unlikely(IS_ERR_OR_NULL(dentry)))
> >  		return ERR_PTR(-ENOMEM);
> > +	if (!d_in_lookup(dentry))
> > +		/* Raced with another thread which did the lookup */
> > +		return dentry;
> > =20
> >  	old =3D dir->i_op->lookup(dir, dentry, flags);
> >  	if (unlikely(old)) {
> > +		d_lookup_done(dentry);
> >  		dput(dentry);
> >  		dentry =3D old;
> >  	}
> > +	if ((flags & LOOKUP_INTENT_FLAGS) =3D=3D 0)
> > +		/* ->lookup must have given final answer */
> > +		d_lookup_done(dentry);
>=20
> This is kind of an ugly thing for the callers to get right. I think it
> would be cleaner to just push the d_lookup_done() into all of the
> callers that don't pass any intent flags, and do away with this.

I don't understand your concern.  This does not impose on callers,
rather it relieves them of a burden.  d_lookup_done() is fully
idempotent so if a caller does call it, there is no harm done.

In the final result of my series there are 4 callers of this function.
1/ lookup_and_lock() which must always be balanced with
  done_lookup_and_lock(), which calls d_lookup_done()
2/ lookup_and_lock_rename() which is similarly balance with
  done_lookup_and_lock_rename().=20
3/ ksmbd_vfs_path_lookup_locked() which passes zero for the flags and so
   doesn't need d_lookup_done()
4/ ksmbd_vfs_rename() which calls d_lookup_done() as required.

So if I dropped this code it would only affect one caller which would
need to add a call to d_lookup_done() probably immediately after the
successful return of lookup_one_qstr().
While that wouldn't hurt much, I don't see that it would help much
either.

Thanks,
NeilBrown

