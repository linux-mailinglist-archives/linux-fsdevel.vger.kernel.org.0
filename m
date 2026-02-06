Return-Path: <linux-fsdevel+bounces-76508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJJXG+0/hWme+gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 02:12:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2147AF8E34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 02:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26C75302DE0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD9F238C29;
	Fri,  6 Feb 2026 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="MNZ6BVRi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfZZa1dC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378C22D4D3;
	Fri,  6 Feb 2026 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770340320; cv=none; b=AJZiuWx2PsXVimKg+SHG4rxP8R6PNK0w8A2Ukh3EV144PqviaL/dsYdpzzMY/A3nYe74Ob6g9u4n2pov81GR0Pd/DrKGH2am1hOESbNmUSgQS6ZtoM89sqbxmGnbH94UqNuNzrTPOuS+0yJdSW8GZbPDkjVE8WnmhLkmwpfInrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770340320; c=relaxed/simple;
	bh=ayCDfpzcj1jMB7bidxqby4/XW3dWDd0LiUFbQTwfKDc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=M4HFhF1iVpZOYCeewt3uep2SOfdbdpKxC67amL5tUMZincbq/a7bsr1ZVx9KsiSZK27DnhHazWzybxLjMSvS0Jwl5s4CbzPyVPpBmd4JBMkgpXAQK3AQlnFoBhlmOmGwOl/OGd2hOLxzImglCEzM2nffWO7+ttZgH1VyA1AvC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=MNZ6BVRi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfZZa1dC; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 6E3EC13802E2;
	Thu,  5 Feb 2026 20:11:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 20:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1770340319; x=1770347519; bh=OElqf5JNJ6wb7vQBQFRxNPu5laMFIrMj1jf
	v0Fgyffc=; b=MNZ6BVRiC13zdWbee8cGp2aje7ct2FEZ9mbd2iT9XImE4H66gt0
	Z9K9+VNJh3BNngmXAAbrKjwBYgXryraTQnw689PtTXJ8SOQ0aMq8H0aj6O7iINry
	fD/FOge5iWcu8TOlyoTawmKYahZHpSvZ+QhhlcGNaoP+ne+mfgL0L8613CVw/0Ck
	TXuJVvojD4OhmjtA/fMrGbwfAeB3V6NmMekMvCKAXg06RwbCDm/dd/QUfyPXLKon
	phrwNHkdNibJ0sDQH4zO1im9TmSNQfVN2eSLSiW5y8AJwrcjRy3k+umeFyVxrG3a
	kH6gLmIbi+06yWVjjkAgDGi4XwpIewYNUPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770340319; x=
	1770347519; bh=OElqf5JNJ6wb7vQBQFRxNPu5laMFIrMj1jfv0Fgyffc=; b=P
	fZZa1dCvWAZ1mZprxbhpHzSQ1TJnfWMdJXs1jfFipfrk1ok1tPHguXy5LuZGIIgz
	+Hn/mg451In/5eBXd46RfTHc3y53Sci8hwZhU8/S8VQIj7Z7S65Gu6NCCpJ8Sbqx
	QzKvVA4+90Vcf5FykpVY3MWLig/mpzuzkMz4rypz1JE4JpYG4DZjW1zlLKjc7fU4
	1AkL4dPoWFY8fJ+R++dRf3nGpaW+fOaMztYokr3WlW57Ao1drED9n0c3rTyqGDzH
	kNNEZdIC4kdQxI0d5A5GQdVbqxFzh6IPxoXdBbs701CXH7URwcpDxc3PQm6phyaY
	u8+8zpMZS7pJ4ff8tS62w==
X-ME-Sender: <xms:3j-FaVOjIxKw4KeYsaHlAiI9xDZi7cdTvIjoI6JFiE5jZiWk-93baw>
    <xme:3j-FaTjDfg5P27mbJCCabLPaAur9EBu-IR0bvXR_b1GyWlGTzgxf4QJcvi1NpUd0K
    OpkSj2XWTpVZl3-1aM8R96knqmUn992K9ml7uEvy0F3MaFgXA>
X-ME-Received: <xmr:3j-FaUQL-GT-NwpNzj-mEuloTAJgYNUsTChDIBbaafv1RkZPnA5dihcPDpFPYxBeNNA-7dsuE3w5l9X8TUE9IKNqPtFz4S75tLl51JSRTv_J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeikedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:3j-FaWrXvDSAtKnpLE1EES9TJqj3M9eaNlxWMNxF7eldvJ4ju1DI6g>
    <xmx:3j-FafYE1ffdA5E279WF2FpLYN73djNnfJiz7FIpHonxk7POMQ_tTA>
    <xmx:3j-FaaHwktvOfyhsnLVCQZzgLj6nLPBxSlKoRRAl_TYfcqZuTqY-wA>
    <xmx:3j-FacpzdZBpCXRqkaGc4DXpL2XANHcEa9oKlvQb76UW_WYYyBgk1Q>
    <xmx:3z-Facitt6SaplvTAhjJr6j8Y1FQ-mY9ikZnOPpINMYSce6ySceYnCBy>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 20:11:52 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 10/13] ovl: change ovl_create_real() to get a new lock
 when re-opening created file.
In-reply-to:
 <CAOQ4uxh-MLgwZCstwr6HyPXHVRmtj2F_=xS8pE3FN6Ex-wex4w@mail.gmail.com>
References: <20260204050726.177283-1-neilb@ownmail.net>,
 <20260204050726.177283-11-neilb@ownmail.net>,
 <CAOQ4uxh-MLgwZCstwr6HyPXHVRmtj2F_=xS8pE3FN6Ex-wex4w@mail.gmail.com>
Date: Fri, 06 Feb 2026 12:11:50 +1100
Message-id: <177034031005.16766.246184445940612287@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76508-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,ownmail.net:email,ownmail.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2147AF8E34
X-Rspamd-Action: no action

On Thu, 05 Feb 2026, Amir Goldstein wrote:
> On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > When ovl_create_real() is used to create a file on the upper filesystem
> > it needs to return the resulting dentry - positive and hashed.
> > It is usually the case the that dentry passed to the create function
> > (e.g.  vfs_create()) will be suitable but this is not guaranteed.  The
> > filesystem may unhash that dentry forcing a repeat lookup next time the
> > name is wanted.
> >
> > So ovl_create_real() must be (and is) aware of this and prepared to
> > perform that lookup to get a hash positive dentry.
> >
> > This is currently done under that same directory lock that provided
> > exclusion for the create.  Proposed changes to locking will make this
> > not possible - as the name, rather than the directory, will be locked.
> > The new APIs provided for lookup and locking do not and cannot support
> > this pattern.
> >
> > The lock isn't needed.  ovl_create_real() can drop the lock and then get
> > a new lock for the lookup - then check that the lookup returned the
> > correct inode.  In a well-behaved configuration where the upper
> > filesystem is not being modified by a third party, this will always work
> > reliably, and if there are separate modification it will fail cleanly.
> >
> > So change ovl_create_real() to drop the lock and call
> > ovl_start_creating_upper() to find the correct dentry.  Note that
> > start_creating doesn't fail if the name already exists.
> >
> > This removes the only remaining use of ovl_lookup_upper, so it is
> > removed.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/dir.c       | 24 ++++++++++++++++++------
> >  fs/overlayfs/overlayfs.h |  7 -------
> >  2 files changed, 18 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index ff3dbd1ca61f..ec08904d084d 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -219,21 +219,33 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, =
struct dentry *parent,
> >                 err =3D -EIO;
> >         } else if (d_unhashed(newdentry)) {
> >                 struct dentry *d;
> > +               struct name_snapshot name;
> >                 /*
> >                  * Some filesystems (i.e. casefolded) may return an unhas=
hed
> > -                * negative dentry from the ovl_lookup_upper() call before
> > +                * negative dentry from the ovl_start_creating_upper() ca=
ll before
> >                  * ovl_create_real().
>=20
>=20
> According to the new locking rules, if the hashed dentry itself is
> the synchronization object, is it going to be allowed to
> filesystem to unhash the dentry while the dentry still in the
> "creating" scope? It is hard for me to wrap my head around this.

It can be confusing....

It will be important for the name the remain locked (and hashed) until
the operation (create, remove, rename) either succeeds or fails.  So
leaving a dentry unhashed will be OK providing a subsequent lookup will
also succeed or fail in the same way.  The caller must be able to use
the dentry to access the object (i.e.  the inode) on success, but they
is nothing in POSIX that requires that the object still has any
particular name.

>=20
> Or do we need this here because some filesystems (casefold in
> particular) are not going to support parallel creations?

There is no reason that a casefolding filesystem would not support parallel
ops. And it isn't just casefolding that acts like this.  At least one of
the special filesystems (tracefs maybe) always unhashes on create.  You
only ever get a hashed positive dentry as a result of lookup.
(overlayfs would never see this case of course).

>=20
> >                  * In that case, lookup again after making the newdentry
> >                  * positive, so ovl_create_upper() always returns a hashed
> >                  * positive dentry.
> > +                * As we have to drop the lock before the lookup a race
> > +                * could result in a lookup failure.  In that case we ret=
urn
> > +                * an error.
> >                  */
> > -               d =3D ovl_lookup_upper(ofs, newdentry->d_name.name, paren=
t,
> > -                                    newdentry->d_name.len);
> > -               dput(newdentry);
> > -               if (IS_ERR_OR_NULL(d))
> > +               take_dentry_name_snapshot(&name, newdentry);
> > +               end_creating_keep(newdentry);
> > +               d =3D ovl_start_creating_upper(ofs, parent, &name.name);
> > +               release_dentry_name_snapshot(&name);
>=20
> OK. not saying no to this (yet) but I have to admit that it is pretty
> ugly that the callers of ovl_create_real() want to create a specific
> stable name, which is could be passed in as const char *name
> and yet we end up doing this weird dance here just to keep the name
> from newdentry.

There are three callers of ovl_create_real()

ovl_lookup_or_create() does have a "const char *name".
ovl_create_upper() has a stable dentry from which it can copy a QSTR
ovl_create_temp() would need some sort of dance to keep hold of the
temporary name that was allocated.

If it weren't for ovl_create_temp() I would agree with you.

Though we could have the three callers of ovl_start_creating_temp() pass a
"char name[OVL_TEMPNAME_SIZE]" in, then ovl_create_temp() would have
easy access.
I could do that if you like.

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20


