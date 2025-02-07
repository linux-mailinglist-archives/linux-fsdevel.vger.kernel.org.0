Return-Path: <linux-fsdevel+bounces-41139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1F1A2B71A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 01:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA3516646A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 00:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6F1F5FD;
	Fri,  7 Feb 2025 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxyYXnNG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF4017BBF;
	Fri,  7 Feb 2025 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887820; cv=none; b=gC7mq5RaHfMPQkugxt2CKuwLJxsaYhbrchzHg9e6LpMVqkVegAOyIuG0RHCjO2ObTR0gG4eu+8m/JgA+L5FTS/hexd2quTyG7oHZrewITOVjZvR1XUornvkaHvUWs9ekTkeiiYgTIAF8/o/3G0TiKH9+HARXnJyt0PsMWVI6EuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887820; c=relaxed/simple;
	bh=WsDlcnI4bhIi7Crlb2pW1EAhVlKyqIiH9J9KBTUr7LE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UAnd28Hctr7uwSl7E+lvSI4MIyXWn9F/e7iTuPLvTLOZqn1R41v1b6JqPo0Y6TJ02jQOpysddODymMYF2ySZTgK2PnV5n2M2d6YtZASE3vRpek6Clo9q10NWNQ5bLtx4EOvB5aEKVHb6nwBUEgs3WnsU55kD2RKovHPZGJQ9Kv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxyYXnNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA428C4CEDF;
	Fri,  7 Feb 2025 00:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738887820;
	bh=WsDlcnI4bhIi7Crlb2pW1EAhVlKyqIiH9J9KBTUr7LE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FxyYXnNGgBq85SSrmx3iNwV7UkZ67o29TDME13PfdiSvQnBea0WIc4T2yxxD+4iaY
	 ZnllMXF1x/XiQblOIA5cFGCFjD5fg+p21TTA+BbL3/wv3KHJ/6CdouCQXWMhCdtJjE
	 C5cw756Ykk62jIlzgFRn3FzceIJVHNNLHM9MPQVxEwglgMchQAW33MzOZsc3i9kjVE
	 8ZJsUItaS0ukmtco5yErCQBgG8zGZpo8itLQboJjUOWzhkJTU9c/3LjLM43IQ3qSaO
	 sTlOOr3QhYEdZ0HtiR7Qg2Tq6e59c88Br3ilyfcOBKBuBUw4k4+pb8HOol13hV+6Sl
	 ks7tIqym+eatg==
Message-ID: <6f63593946ef08dc9535b2d7c51d17c884b7aafe.camel@kernel.org>
Subject: Re: [PATCH 03/19] VFS: use d_alloc_parallel() in
 lookup_one_qstr_excl() and rename it.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Linus Torvalds
	 <torvalds@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 06 Feb 2025 19:23:38 -0500
In-Reply-To: <173888666051.22054.2064348642111556769@noble.neil.brown.name>
References: <>, <017ca787f3a167302281b65e60d301d9f1c0f5de.camel@kernel.org>
	 <173888666051.22054.2064348642111556769@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-07 at 11:04 +1100, NeilBrown wrote:
> On Fri, 07 Feb 2025, Jeff Layton wrote:
> > On Thu, 2025-02-06 at 16:42 +1100, NeilBrown wrote:
> > > lookup_one_qstr_excl() is used for lookups prior to directory
> > > modifications, whether create, unlink, rename, or whatever.
> > >=20
> > > To prepare for allowing modification to happen in parallel, change
> > > lookup_one_qstr_excl() to use d_alloc_parallel().
> > >=20
> > > To reflect this, name is changed to lookup_one_qtr() - as the directo=
ry
> > > may be locked shared.
> > >=20
> > > If any for the "intent" LOOKUP flags are passed, the caller must ensu=
re
> > > d_lookup_done() is called at an appropriate time.  If none are passed
> > > then we can be sure ->lookup() will do a real lookup and d_lookup_don=
e()
> > > is called internally.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/namei.c            | 47 +++++++++++++++++++++++++----------------=
--
> > >  fs/smb/server/vfs.c   |  7 ++++---
> > >  include/linux/namei.h |  9 ++++++---
> > >  3 files changed, 37 insertions(+), 26 deletions(-)
> > >=20
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 5cdbd2eb4056..d684102d873d 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -1665,15 +1665,13 @@ static struct dentry *lookup_dcache(const str=
uct qstr *name,
> > >  }
> > > =20
> > >  /*
> > > - * Parent directory has inode locked exclusive.  This is one
> > > - * and only case when ->lookup() gets called on non in-lookup
> > > - * dentries - as the matter of fact, this only gets called
> > > - * when directory is guaranteed to have no in-lookup children
> > > - * at all.
> > > + * Parent directory has inode locked: exclusive or shared.
> > > + * If @flags contains any LOOKUP_INTENT_FLAGS then d_lookup_done()
> > > + * must be called after the intended operation is performed - or abo=
rted.
> > >   */
> > > -struct dentry *lookup_one_qstr_excl(const struct qstr *name,
> > > -				    struct dentry *base,
> > > -				    unsigned int flags)
> > > +struct dentry *lookup_one_qstr(const struct qstr *name,
> > > +			       struct dentry *base,
> > > +			       unsigned int flags)
> > >  {
> > >  	struct dentry *dentry =3D lookup_dcache(name, base, flags);
> > >  	struct dentry *old;
> > > @@ -1686,18 +1684,25 @@ struct dentry *lookup_one_qstr_excl(const str=
uct qstr *name,
> > >  	if (unlikely(IS_DEADDIR(dir)))
> > >  		return ERR_PTR(-ENOENT);
> > > =20
> > > -	dentry =3D d_alloc(base, name);
> > > -	if (unlikely(!dentry))
> > > +	dentry =3D d_alloc_parallel(base, name);
> > > +	if (unlikely(IS_ERR_OR_NULL(dentry)))
> > >  		return ERR_PTR(-ENOMEM);
> > > +	if (!d_in_lookup(dentry))
> > > +		/* Raced with another thread which did the lookup */
> > > +		return dentry;
> > > =20
> > >  	old =3D dir->i_op->lookup(dir, dentry, flags);
> > >  	if (unlikely(old)) {
> > > +		d_lookup_done(dentry);
> > >  		dput(dentry);
> > >  		dentry =3D old;
> > >  	}
> > > +	if ((flags & LOOKUP_INTENT_FLAGS) =3D=3D 0)
> > > +		/* ->lookup must have given final answer */
> > > +		d_lookup_done(dentry);
> >=20
> > This is kind of an ugly thing for the callers to get right. I think it
> > would be cleaner to just push the d_lookup_done() into all of the
> > callers that don't pass any intent flags, and do away with this.
>=20
> I don't understand your concern.  This does not impose on callers,
> rather it relieves them of a burden.  d_lookup_done() is fully
> idempotent so if a caller does call it, there is no harm done.
>=20
> In the final result of my series there are 4 callers of this function.
> 1/ lookup_and_lock() which must always be balanced with
>   done_lookup_and_lock(), which calls d_lookup_done()
> 2/ lookup_and_lock_rename() which is similarly balance with
>   done_lookup_and_lock_rename().=20
> 3/ ksmbd_vfs_path_lookup_locked() which passes zero for the flags and so
>    doesn't need d_lookup_done()
> 4/ ksmbd_vfs_rename() which calls d_lookup_done() as required.
>=20
> So if I dropped this code it would only affect one caller which would
> need to add a call to d_lookup_done() probably immediately after the
> successful return of lookup_one_qstr().
> While that wouldn't hurt much, I don't see that it would help much
> either.
>=20

My concern is about the complex return handling. If the flags are 0,
then I don't need to call d_lookup_done(), but if they aren't 0, then I
do. That's just an easy opportunity to get it wrong if new callers are
added.

My preference would be that the caller must always call d_lookup_done()
on a successful return. If ksmbd_vfs_path_lookup_locked() has to call
it immediately afterward, then that's fine. No need for this special
handling in a generic function, just for a single caller.
--=20
Jeff Layton <jlayton@kernel.org>

