Return-Path: <linux-fsdevel+bounces-76504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEWdGC00hWkl+AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 01:22:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4422F8956
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 01:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2028E3023DC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 00:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F2420DD52;
	Fri,  6 Feb 2026 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Toy3OUKz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mG6CPkhW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6271E3DE5;
	Fri,  6 Feb 2026 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337282; cv=none; b=OrNGoTS9SvA8k5WRcSuj9Kr2TislL5K/aW9iV+48OwDT2zIq16amwDcwuISXXe+CjGDl84VNEEvwLk5sfbcP5fKS0lZPlrGCKpprKejPv8Kl61tXJ5kYsLUgDwTAks/7fs5wDnT/A9GZKHVsK7BNMzq8YeXRQMn9UadHSEn2pCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337282; c=relaxed/simple;
	bh=VS688kmTOerW5kLLzHeK6bUW9BpPShhuYIroSr7p9jo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Fpghwre9LS3UfF0NqC2a8LLag/4nAwh2qEZfOnQ4d1do+BH8flJYg6G6I7mPydx3zj6EcwItDAKOgCZKQAtwcgbU2ZwNBBcZUSwdk83aWQ+ptfv7i523nae0cTWSRgp9drozyNAteSlzqqiHfrPOfVyuBhi4bJ+lJ7bRwFj2bOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Toy3OUKz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mG6CPkhW; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 068041380420;
	Thu,  5 Feb 2026 19:21:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 05 Feb 2026 19:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1770337280; x=1770344480; bh=DmksmkpWEFjDfVOkfeg8VRIAIhqDjvEflXp
	Cuv+Zy1k=; b=Toy3OUKzFZ/MXYhK4rOI5A0BLeaMjnJ4CZNKeHk564BSavXVzS4
	qfKdNrxakQxclMIlJ5ClebrV25619IF1gJCgtLFLxy2tGhMMqpe+SNOrzaRSt1iN
	2L1jczM6EYyQld7yKh4PmXvmp48M3kWTnxzgJgQ4NgY56CgqF9faU/xNQNFdzWAg
	oa3g/TDlIE/RQeOJX2av7+ohxCHh+vPRuXgoC+V+mXOXVFYRvLn93QYb3ZmJdv9g
	1TXzMch7sMk1bdRcCGMuqIVeVxlZRoAOiArwyX31PVdtnu/2HXiSTEMdgK5GtTRL
	oSxi8xkNenxfehm+xxq28ydhr8BONYZn/nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770337280; x=
	1770344480; bh=DmksmkpWEFjDfVOkfeg8VRIAIhqDjvEflXpCuv+Zy1k=; b=m
	G6CPkhWw3EZsOe4CLqXD23vIBrQbqnahY2jgRN/UZ7ltoMPUR9ebgYLBHG02oafq
	7yOTC7Nc5l3zva1NTUnjKJ/VBuQG9nR4vWRhJoyO7gg6BKc9+nYsS7rBEPQSXv82
	uKaywbbv+QCoViLK9H/DOwLc9Zvr2FrhfvNFhVbFu3wHYN3qU85RjZRbWuGolAuN
	jKxmK30WImx4rXv7aZJ1yA0PUHdMOnyMntp+WMqiOBMD+0htLpQqBfFLCD2MaPEl
	w6H6JJkKrlBBDgqtDpjWBQlQszHSwKRB+EnnpccQqFRAp4A2U7Psqb9PXfzGmNxv
	qcuCNdOx1FeEyi7Y60LAA==
X-ME-Sender: <xms:_zOFaTGg81dJa15ymcfPdPu9aEr8hepsSeCXNF76WiHLuVzS1TkRXQ>
    <xme:_zOFab7h5EUA_NOI5TxJbnaWmYm_hvto0Q3xtongwU43ODdCqcuS6riEiEAObt8j_
    bnMDR_SBdNU8RDrxgyIlhVoRFJUs0o-Pa43FOVG8Zl4umIW5Q>
X-ME-Received: <xmr:_zOFaVJuZxIdc6BE__hhv0-qjiCqA245jU3C5IeZZQbXf6d69lH476A1ArFMffisI8PQ73tfmqtTGCwPFhuNJOahrqo8lUUY2ioFZeKLJzRz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeijedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:_zOFaWCYEJXkjaLebHvyJmDQINpOi3ipHwHwXfxkqxX5hdtfyusVew>
    <xmx:_zOFabQxo3Fa2K8iVOJctyPkt9nfGPjcj38BzwgujnxC3gjOLdTAlQ>
    <xmx:_zOFaYextvdPZR5y49EMZ0kfIqh7dOBJCGFKTJdTSP8wqz5XrCnBpQ>
    <xmx:_zOFabg5BfPKeRr-0Xa6rJqWY1PtnzM_R0UOGA8wFbJriDagCmEVkw>
    <xmx:ADSFadNlJldg85dJB9Ejs3OXt0OEUMuvbIWGhn08pJ85rcZBZ5KBTxh3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 19:21:13 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 04/13] Apparmor: Use simple_start_creating() /
 simple_done_creating()
In-reply-to: <7fbfbeb0d57484172304b727bd888d1a1105f96d.camel@kernel.org>
References: <20260204050726.177283-1-neilb@ownmail.net>,
 <20260204050726.177283-5-neilb@ownmail.net>,
 <7fbfbeb0d57484172304b727bd888d1a1105f96d.camel@kernel.org>
Date: Fri, 06 Feb 2026 11:21:09 +1100
Message-id: <177033726944.16766.14495020155654514261@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76504-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noble.neil.brown.name:mid,messagingengine.com:dkim,ownmail.net:dkim,brown.name:replyto,brown.name:email]
X-Rspamd-Queue-Id: D4422F8956
X-Rspamd-Action: no action

On Thu, 05 Feb 2026, Jeff Layton wrote:
> On Wed, 2026-02-04 at 15:57 +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > Instead of explicitly locking the parent and performing a look up in
> > apparmor, use simple_start_creating(), and then simple_done_creating()
> > to unlock and drop the dentry.
> >=20
> > This removes the need to check for an existing entry (as
> > simple_start_creating() acts like an exclusive create and can return
> > -EEXIST), simplifies error paths, and keeps dir locking code
> > centralised.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  security/apparmor/apparmorfs.c | 38 ++++++++--------------------------
> >  1 file changed, 9 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> > index 907bd2667e28..7f78c36e6e50 100644
> > --- a/security/apparmor/apparmorfs.c
> > +++ b/security/apparmor/apparmorfs.c
> > @@ -282,32 +282,19 @@ static struct dentry *aafs_create(const char *name,=
 umode_t mode,
> > =20
> >  	dir =3D d_inode(parent);
> > =20
> > -	inode_lock(dir);
> > -	dentry =3D lookup_noperm(&QSTR(name), parent);
> > +	dentry =3D simple_start_creating(parent, name);
> >  	if (IS_ERR(dentry)) {
> >  		error =3D PTR_ERR(dentry);
> > -		goto fail_lock;
> > -	}
> > -
> > -	if (d_really_is_positive(dentry)) {
> > -		error =3D -EEXIST;
> > -		goto fail_dentry;
> > +		goto fail;
> >  	}
> > =20
> >  	error =3D __aafs_setup_d_inode(dir, dentry, mode, data, link, fops, iop=
s);
> > +	simple_done_creating(dentry);
> >  	if (error)
> > -		goto fail_dentry;
> > -	inode_unlock(dir);
> > -
> > -	return dentry;
> > -
> > -fail_dentry:
> > -	dput(dentry);
> > -
> > -fail_lock:
> > -	inode_unlock(dir);
> > +		goto fail;
> > +	return 0;
>=20
> As KTR points out, this should be "return NULL;"

Actually it should be "return dentry;" which is what the original code
did.
I've no idea how it became 0...
Callers of aafs_create() will silently treat NULL as failure.

>=20
> > +fail:
> >  	simple_release_fs(&aafs_mnt, &aafs_count);
> > -
> >  	return ERR_PTR(error);
> >  }
> > =20
> > @@ -2572,8 +2559,7 @@ static int aa_mk_null_file(struct dentry *parent)
> >  	if (error)
> >  		return error;
> > =20
> > -	inode_lock(d_inode(parent));
> > -	dentry =3D lookup_noperm(&QSTR(NULL_FILE_NAME), parent);
> > +	dentry =3D simple_start_creating(parent, NULL_FILE_NAME);
> >  	if (IS_ERR(dentry)) {
> >  		error =3D PTR_ERR(dentry);
> >  		goto out;
> > @@ -2581,7 +2567,7 @@ static int aa_mk_null_file(struct dentry *parent)
> >  	inode =3D new_inode(parent->d_inode->i_sb);
> >  	if (!inode) {
> >  		error =3D -ENOMEM;
> > -		goto out1;
> > +		goto out;
> >  	}
> > =20
> >  	inode->i_ino =3D get_next_ino();
> > @@ -2593,18 +2579,12 @@ static int aa_mk_null_file(struct dentry *parent)
> >  	aa_null.dentry =3D dget(dentry);
> >  	aa_null.mnt =3D mntget(mount);
> > =20
> > -	error =3D 0;
> > -
> > -out1:
> > -	dput(dentry);
> >  out:
> > -	inode_unlock(d_inode(parent));
> > +	simple_done_creating(dentry);
> >  	simple_release_fs(&mount, &count);
> >  	return error;
> >  }
> > =20
> > -
> > -
> >  static const char *policy_get_link(struct dentry *dentry,
> >  				   struct inode *inode,
> >  				   struct delayed_call *done)
>=20
> Assuming you fix the minor problem above.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20

Thanks,
NeilBrown

