Return-Path: <linux-fsdevel+bounces-57658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C3BB243BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31C5189DBCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA9E2EA151;
	Wed, 13 Aug 2025 08:04:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F438286433;
	Wed, 13 Aug 2025 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072282; cv=none; b=mziKFNgfCz0jmUUSsOjh5TXzjHth+UlsqcutfpmGLhrmbAutSAuoEEoLs3fQmRPxK7w6HzYab4OE7N5byqxC6Yf0H5NxvsKg33k6t6LUCsQRxOHTLs0mkIL8HcGzUbZg7fjTGMU0ejVi+TRnDYBdYDT+ghoUOMsFYpKzxchn6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072282; c=relaxed/simple;
	bh=FhzdVlboS0uvBRS2ec6VoJqaPXvCKsIFRA8PZ0M7YZc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VEpT6kl/CeIHjNET535VUxGOgrFM+XfcQnS5QZW2cO86Pdq7Itc92dsdtXEvaLJ4pZE59ztd+kYS5vZWhc12k3XGTVf1Ae9MJZaatIWxcQBlZYO6KCNM5O5d8J4/nsMdKC5qmH9WIOoo9Awkh7GI+/4r68IyDKnyhLNlPiYfYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1um6TH-005b1O-BY;
	Wed, 13 Aug 2025 08:04:33 +0000
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
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 netfs@lists.linux.dev, ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] VFS: add rename_lookup()
In-reply-to: <20250813043531.GB222315@ZenIV>
References: <>, <20250813043531.GB222315@ZenIV>
Date: Wed, 13 Aug 2025 18:04:32 +1000
Message-id: <175507227245.2234665.4311084523419609794@noble.neil.brown.name>

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:08PM +1000, NeilBrown wrote:
> > rename_lookup() combines lookup and locking for a rename.
> >=20
> > Two names - new_last and old_last - are added to struct renamedata so it
> > can be passed to rename_lookup() to have the old and new dentries filled
> > in.
> >=20
> > __rename_lookup() in vfs-internal and assumes that the names are already
> > hashed and skips permission checking.  This is appropriate for use after
> > filename_parentat().
> >=20
> > rename_lookup_noperm() does hash the name but avoids permission
> > checking.  This will be used by debugfs.
>=20
> WTF would debugfs do anything of that sort?  Explain.  Unlike vfs_rename(),
> there we
> 	* are given the source dentry
> 	* are limited to pure name changes - same-directory only and
> target must not exist.
> 	* do not take ->s_vfs_rename_mutex
> 	...

Sure, debugfs_change_name() could have a simplified rename_lookup()
which doesn't just skip the perm checking but also skips other
s_vfs_rename_mutex etc.  But is there any value in creating a neutered
interface just because there is a case where all the functionality isn't
needed?

Or maybe I misunderstand your problem with rename_lookup_noperm().


>=20
> > If either old_dentry or new_dentry are not NULL, the corresponding
> > "last" is ignored and the dentry is used as-is.  This provides similar
> > functionality to dentry_lookup_continue().  After locks are obtained we
> > check that the parent is still correct.  If old_parent was not given,
> > then it is set to the parent of old_dentry which was locked.  new_parent
> > must never be NULL.
>=20
> That screams "bad API" to me...  Again, I want to see the users; you are
> asking to accept a semantics that smells really odd, and it's impossible
> to review without seeing the users.

There is a git tree you could pull.....

My API effectively supports both lock_rename() users and
lock_rename_child() users.  Maybe you want to preserve the two different
APIs.  I'd rather avoid the code duplication.

>=20
> > On success new references are geld on old_dentry, new_dentry and old_pare=
nt.
> >=20
> > done_rename_lookup() unlocks and drops those three references.
> >=20
> > No __free() support is provided as done_rename_lookup() cannot be safely
> > called after rename_lookup() returns an error.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/namei.c            | 318 ++++++++++++++++++++++++++++++++++--------
> >  include/linux/fs.h    |   4 +
> >  include/linux/namei.h |   3 +
> >  3 files changed, 263 insertions(+), 62 deletions(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index df21b6fa5a0e..cead810d53c6 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3507,6 +3507,233 @@ void unlock_rename(struct dentry *p1, struct dent=
ry *p2)
> >  }
> >  EXPORT_SYMBOL(unlock_rename);
> > =20
> > +/**
> > + * __rename_lookup - lookup and lock names for rename
> > + * @rd:           rename data containing relevant details
> > + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> > + *                LOOKUP_NO_SYMLINKS etc).
> > + *
> > + * Optionally look up two names and ensure locks are in place for
> > + * rename.
> > + * Normally @rd.old_dentry and @rd.new_dentry are %NULL and the
> > + * old and new directories and last names are given in @rd.  In this
> > + * case the names are looked up with appropriate locking and the
> > + * results stored in @rd.old_dentry and @rd.new_dentry.
> > + *
> > + * If either are not NULL, then the corresponding lookup is avoided but
> > + * the required locks are still taken.  In this case @rd.old_parent may
> > + * be %NULL, otherwise @rd.old_dentry must still have @rd.old_parent as
> > + * its d_parent after the locks are obtained.  @rd.new_parent must
> > + * always be non-NULL, and must always be the correct parent after
> > + * locking.
> > + *
> > + * On success a reference is held on @rd.old_dentry, @rd.new_dentry,
> > + * and @rd.old_parent whether they were originally %NULL or not.  These
> > + * references are dropped by done_rename_lookup().  @rd.new_parent
> > + * must always be non-NULL and no extra reference is taken.
> > + *
> > + * The passed in qstrs must have the hash calculated, and no permission
> > + * checking is performed.
> > + *
> > + * Returns: zero or an error.
> > + */
> > +static int
> > +__rename_lookup(struct renamedata *rd, int lookup_flags)
> > +{
> > +	struct dentry *p;
> > +	struct dentry *d1, *d2;
> > +	int target_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> > +	int err;
> > +
> > +	if (rd->flags & RENAME_EXCHANGE)
> > +		target_flags =3D 0;
> > +	if (rd->flags & RENAME_NOREPLACE)
> > +		target_flags |=3D LOOKUP_EXCL;
> > +
> > +	if (rd->old_dentry) {
> > +		/* Already have the dentry - need to be sure to lock the correct paren=
t */
> > +		p =3D lock_rename_child(rd->old_dentry, rd->new_parent);
> > +		if (IS_ERR(p))
> > +			return PTR_ERR(p);
> > +		if (d_unhashed(rd->old_dentry) ||
> > +		    (rd->old_parent && rd->old_parent !=3D rd->old_dentry->d_parent)) {
> > +			/* dentry was removed, or moved and explicit parent requested */
> > +			unlock_rename(rd->old_dentry->d_parent, rd->new_parent);
> > +			return -EINVAL;
> > +		}
> > +		rd->old_parent =3D dget(rd->old_dentry->d_parent);
> > +		d1 =3D dget(rd->old_dentry);
> > +	} else {
> > +		p =3D lock_rename(rd->old_parent, rd->new_parent);
> > +		if (IS_ERR(p))
> > +			return PTR_ERR(p);
> > +		dget(rd->old_parent);
> > +
> > +		d1 =3D lookup_one_qstr_excl(&rd->old_last, rd->old_parent,
> > +					  lookup_flags);
> > +		if (IS_ERR(d1))
> > +			goto out_unlock_1;
> > +	}
> > +	if (rd->new_dentry) {
> > +		if (d_unhashed(rd->new_dentry) ||
> > +		    rd->new_dentry->d_parent !=3D rd->new_parent) {
> > +			/* new_dentry was moved or removed! */
> > +			goto out_unlock_2;
> > +		}
> > +		d2 =3D dget(rd->new_dentry);
> > +	} else {
> > +		d2 =3D lookup_one_qstr_excl(&rd->new_last, rd->new_parent,
> > +					  lookup_flags | target_flags);
> > +		if (IS_ERR(d2))
> > +			goto out_unlock_2;
> > +	}
> > +
> > +	if (d1 =3D=3D p) {
> > +		/* source is an ancestor of target */
> > +		err =3D -EINVAL;
> > +		goto out_unlock_3;
> > +	}
> > +
> > +	if (d2 =3D=3D p) {
> > +		/* target is an ancestor of source */
> > +		if (rd->flags & RENAME_EXCHANGE)
> > +			err =3D -EINVAL;
> > +		else
> > +			err =3D -ENOTEMPTY;
> > +		goto out_unlock_3;
> > +	}
> > +
> > +	rd->old_dentry =3D d1;
> > +	rd->new_dentry =3D d2;
> > +	return 0;
> > +
> > +out_unlock_3:
> > +	dput(d2);
> > +	d2 =3D ERR_PTR(err);
> > +out_unlock_2:
> > +	dput(d1);
> > +	d1 =3D d2;
> > +out_unlock_1:
> > +	unlock_rename(rd->old_parent, rd->new_parent);
> > +	dput(rd->old_parent);
> > +	return PTR_ERR(d1);
> > +}
>=20
> This is too fucking ugly to live, IMO.  Too many things are mixed into it.
> I will NAK that until I get a chance to see the users of all that stuff.
> Sorry.
>=20

Can you say more about what you think it ugly?

Are you OK with combining the lookup and the locking in the one
function?
Are you OK with passing a 'struct rename_data' rather than a list of
assorted args?
Are you OK with deducing the target flags in this function, or do you
want them explicitly passed in?
Is it just that the function can use with lock_rename or
lock_rename_child depending on context?

???

Thanks,
NeilBrown

