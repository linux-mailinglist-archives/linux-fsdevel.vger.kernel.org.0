Return-Path: <linux-fsdevel+bounces-41353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A8BA2E328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA251887E65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 04:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B0D15574E;
	Mon, 10 Feb 2025 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iKhucb7o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DK59YW8Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iKhucb7o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DK59YW8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541417591;
	Mon, 10 Feb 2025 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739162178; cv=none; b=BiQ8KDEj8X0KMKEmKjCppdOxCT3P7UXJRX4wEpcG9ytAhyZVyBJy+sH5kEp8FkjP61RBAy1bchzcmYgU7pJYY6VbxmKLuYAg1VSyAnnZXapFeXoWDHV2SLMza/rTQ5h4aDLpPo2AhE8fxbuJXIfIsoBtq7bLsFw/nFgYVgBFJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739162178; c=relaxed/simple;
	bh=Jal0V51wS/3IV3CeOYIwPOr3EmD9bLixle3Xa5+XlZk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Y4iI2/YsocNDRxna0Oov5xZZJ3Wyg/FFlankOEpdmsn8FXZLoUhFWCi9iyDYgAMuL6i5qTJz1GvX4zbv4DWkrYhFCo+ydzz8HozQvoJ+EMQVH/6KlawS89qsKEQyx3PA0cOfpmf5NGg0cpvCLRPxWT5pHd9uqhNm+ebA45LE118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iKhucb7o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DK59YW8Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iKhucb7o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DK59YW8Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA8331F391;
	Mon, 10 Feb 2025 04:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739162174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USljhevswOz9MNxT6YoXfwehy10AWLKUPepXgviuPZ8=;
	b=iKhucb7okltIKMRJpss0jB/ekdgLf9ib4e5eQT9uL51Yu4p+4sX8jWbWCrrPwZhJ5afGU1
	DksZ1AN7qVnmFCL76FiSV/izO9gRhNcMQzD0Y4/4+lw7iDYHY/YsIXTHDwXC9q03smnTKT
	QeeFgLB34OEzemn8oFYKaiGUn+igPQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739162174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USljhevswOz9MNxT6YoXfwehy10AWLKUPepXgviuPZ8=;
	b=DK59YW8YKWijk6ctr60fOrjhJTEg77tvJfyMK4cXrN45nJZBuV/UVtGcShtvOusWvqblDv
	od4fu2o13ILlY5AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739162174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USljhevswOz9MNxT6YoXfwehy10AWLKUPepXgviuPZ8=;
	b=iKhucb7okltIKMRJpss0jB/ekdgLf9ib4e5eQT9uL51Yu4p+4sX8jWbWCrrPwZhJ5afGU1
	DksZ1AN7qVnmFCL76FiSV/izO9gRhNcMQzD0Y4/4+lw7iDYHY/YsIXTHDwXC9q03smnTKT
	QeeFgLB34OEzemn8oFYKaiGUn+igPQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739162174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USljhevswOz9MNxT6YoXfwehy10AWLKUPepXgviuPZ8=;
	b=DK59YW8YKWijk6ctr60fOrjhJTEg77tvJfyMK4cXrN45nJZBuV/UVtGcShtvOusWvqblDv
	od4fu2o13ILlY5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED80F13707;
	Mon, 10 Feb 2025 04:36:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VEWWJzuCqWdaYwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 10 Feb 2025 04:36:11 +0000
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
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] VFS: introduce vfs_mkdir_return()
In-reply-to: <20250207194538.GE1977892@ZenIV>
References: <>, <20250207194538.GE1977892@ZenIV>
Date: Mon, 10 Feb 2025 15:36:04 +1100
Message-id: <173916216443.22054.1710124383016579976@noble.neil.brown.name>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 08 Feb 2025, Al Viro wrote:
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
>=20
> * Calling conventions stink; make it _consume_ dentry reference and
> return dentry reference or ERR_PTR().  Callers will be happier that way
> (check it).

With later patches it will need to consume the lock on the dentry as
well, and either transfer it to the new one or (for error) unlock it.
We need to have the result dentry still locked for fsnotify_mkdir().

Transferring the dentry lock would have to be done in d_splice_alias().=20
The __d_unalias() branch should be ok because I already trylock in there
and fail if I can't get the lock.  For the IS_ROOT branch ....  I think
it is safe to fail if a trylock doesn't succeed.

So I can probably make that work - thanks.

Hmm... kernfs reportedly can leave the mkdir dentry negative and fill in
the inode later.  How does that work?  I assume it will still be hashed
so mkdir won't try the lookup.

done_path_create() will need to accept an IS_ERR() dentry.

>=20
> * Calling conventions should be documented in commit message *and* in
> D/f/porting

What is the scope of "porting" ?  IT seems to be mostly about
_operations interfaces, but I do see other things in there.  I'll try to
remember that - thanks.


>=20
> * devpts, nfs4recover and xfs might as well convert (not going to hit
> the "need a lookup" case anyway)

good point - avoiding the lookup when not requested is a pointless
optimisation because it is hardly every needed and should always be
cheap - we expect it to be in the dcache.

>=20
> * that=20
> +                       /* Need a "const" pointer.  We know d_name is const
> +                        * because we hold an exclusive lock on i_rwsem
> +                        * in d_parent.
> +                        */
> +                       const struct qstr *d_name =3D (void*)&dentry->d_nam=
e;
> +                       d =3D lookup_dcache(d_name, dentry->d_parent, 0);
> +                       if (!d)
> +                               d =3D __lookup_slow(d_name, dentry->d_paren=
t, 0);
> doesn't need a cast.  C is perfectly fine with
> 	T *x =3D foo();
> 	const T *y =3D x;
>=20
> You are not allowed to _strip_ qualifiers; adding them is fine.
> Same reason why you are allowed to pass char * to strlen() without
> any casts whatsoever.

hmm..  I thought I had tried that.  Maybe I didn't try hard enough.
Thanks for the guidance.
>=20
> Comment re stability is fine; the cast is pure WTF material.
>=20


Thanks,
NeilBrown

