Return-Path: <linux-fsdevel+bounces-45182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F051A741F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 02:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9A37A7D80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 01:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140E41C5F34;
	Fri, 28 Mar 2025 01:14:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395CE3D3B3;
	Fri, 28 Mar 2025 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743124491; cv=none; b=kYPYwVYDvFi3pX5o771s1Fh9Q/ssd7p8PiAQRHLKRBNfsS90uTDAakJmOB/65noUy/huft4rVW/sx1RzNl6m9N6O8CDrR9sEggOnHe+f5bquCIQ7TWzSlETallNwQgMfZENUOTs9Zvgprl2Iw9gs00rhOnw0KZBIVTuODWqT5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743124491; c=relaxed/simple;
	bh=Lrs0qJ2XX490B/P+4HpTQ96ufgdA3j9s94aEfJYo+js=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WAPqWzuxF4CdLoolT7iEUQRK8P/g4O0aWxckYAnTbTuDAiFZIHHR1cPWj4vajgy1geCSdnZQ2sG1V0RNLP5pwGKLn3lflj2/6u5g+4o+2CUFb0f8lOv4gfImLwTysreLHO9D20PfwwxBSr/IUVyAufBDKYtzZFkjlqEft1Ogfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1txyJ1-001t2i-99;
	Fri, 28 Mar 2025 01:14:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] VFS: improve interface for lookup_one functions
In-reply-to: <20250322002719.GC2023217@ZenIV>
References: <>, <20250322002719.GC2023217@ZenIV>
Date: Fri, 28 Mar 2025 12:14:42 +1100
Message-id: <174312448295.9342.4725506312787082473@noble.neil.brown.name>

On Sat, 22 Mar 2025, Al Viro wrote:
> On Wed, Mar 19, 2025 at 02:01:32PM +1100, NeilBrown wrote:
>=20
> > -struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
> > -			  struct dentry *base, int len)
> > +struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr name,
> > +			  struct dentry *base)
>=20
> >  {
> >  	struct dentry *dentry;
> >  	struct qstr this;
> > @@ -2942,7 +2940,7 @@ struct dentry *lookup_one(struct mnt_idmap *idmap, =
const char *name,
> > =20
> >  	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
> > =20
> > -	err =3D lookup_one_common(idmap, name, base, len, &this);
> > +	err =3D lookup_one_common(idmap, name.name, base, name.len, &this);
>=20
> No.  Just look at what lookup_one_common() is doing as the first step.
>=20
>         this->name =3D name;
> 	this->len =3D len;

This code is cleaned up in a later patch. lookup_one_common receives the
address of just one qstr which is initialised with qstr that is passed
in.
So on x86_64, the original qstr is passed in as 2 registers.  These are
stored in the stack and the address is passed to lookup_noperm_common(),
as lookup_one_common() gets inlined.

We have to put the two values onto the stack at some point, either in
the original callers, or in the lookup_one family of functions.  I think
it is cleaner in lookup_one as we don't need to put a & in front of all
the QSTR calls.  But we can change it to pass the pointer if you really
think that is better.

Thanks,
NeilBrown


>=20
> You copy your argument's fields to corresponding fields of *&this.  It migh=
t make
> sense to pass a qstr, but not like that - just pass a _pointer_ to struct q=
str instead.
>=20
> Have lookup_one_common() do this:
>=20
> static int lookup_one_common(struct mnt_idmap *idmap,
>                              struct qstr *this, struct dentry *base)
> {
> 	const unsigned char *name =3D this->name;
> 	int len =3D this->len;
>         if (!len)
>                 return -EACCES;
>=20
>         this->hash =3D full_name_hash(base, name, len);
>         if (is_dot_dotdot(name, len))
>                 return -EACCES;
>=20
>         while (len--) {
>                 unsigned int c =3D *name++;
>                 if (c =3D=3D '/' || c =3D=3D '\0')
>                         return -EACCES;
>         }
>         /*
>          * See if the low-level filesystem might want
>          * to use its own hash..
>          */
>         if (base->d_flags & DCACHE_OP_HASH) {
>                 int err =3D base->d_op->d_hash(base, this);
>                 if (err < 0)
>                         return err;
>         }
>=20
>         return inode_permission(idmap, base->d_inode, MAY_EXEC);
> }
>=20
> and adjust the callers; e.g.
> struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr *this,
> 			  struct dentry *base)
> {
>         struct dentry *dentry;
>         int err;
>=20
>         WARN_ON_ONCE(!inode_is_locked(base->d_inode));
>=20
>         err =3D lookup_one_common(idmap, this, base);
>         if (err)
>                 return ERR_PTR(err);
>=20
>         dentry =3D lookup_dcache(this, base, 0);
>         return dentry ? dentry : __lookup_slow(this, base, 0);
> }
>=20
> with callers passing idmap, &QSTR_LEN(name, len), base instead of
> idmap, name, base, len.  lookup_one_common() looks at the fields
> separately; its callers do not.
>=20


