Return-Path: <linux-fsdevel+bounces-55629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F158B0CE1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 01:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC3B17D3E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 23:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B0024676B;
	Mon, 21 Jul 2025 23:27:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91781D63E8;
	Mon, 21 Jul 2025 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140448; cv=none; b=T+GZjMS4xU4UzLNzRiz9mTwzaolAVf2rlLZZnLA73BUOW4BfwpLmkcNFMHhqEASFAQ3LjbPnVN2NVZGrwJ/vw3XEzGiZpv/tpLKnqke3oz7FOBxjqY+W1+r6tCnogEBH9vqcmqM4fiYPSr+JuZddOcGi1dT4ADzeD0+lr4yjB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140448; c=relaxed/simple;
	bh=wu6r7SueNbSDs+99zByyvGTNFeG15Yh/QQupmUTFrKs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PIXj1sON3DDuICkXBX00USKLQEGCsSilT42MV7K85DTqZR5EALDtKOGQT+7g3vC/YNrR5oEpEb9B4NML9ZhHkq4fW96pu4Dugi7ZpdJ0Jm88kixNQSOq9Arzx3nEh50LyPNgzULbtzKo4JgSiTozN2ehcXHD4zHZBtVD4zCNOp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1udzuk-002uhe-1f;
	Mon, 21 Jul 2025 23:27:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] VFS: introduce dentry_lookup() and friends
In-reply-to:
 <CAOQ4uxhiDNWjZXGhE31ZBPC_gUStETh4gyE8WxCRgiefiTCjCg@mail.gmail.com>
References:
 <>, <CAOQ4uxhiDNWjZXGhE31ZBPC_gUStETh4gyE8WxCRgiefiTCjCg@mail.gmail.com>
Date: Tue, 22 Jul 2025 09:27:23 +1000
Message-id: <175314044347.2234665.1726134532379221703@noble.neil.brown.name>

On Mon, 21 Jul 2025, Amir Goldstein wrote:
> On Mon, Jul 21, 2025 at 10:55=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > dentry_lookup() combines locking the directory and performing a lookup
> > prior to a change to the directory.
> > Abstracting this prepares for changing the locking requirements.
> >
> > dentry_lookup_noperm() does the same without needing a mnt_idmap and
> > without checking permissions.  This is useful for internal filesystem
> > management (e.g.  creating virtual files in response to events) and in
> > other cases similar to lookup_noperm().
> >
> > dentry_lookup_hashed() also does no permissions checking and assumes
> > that the hash of the name has already been stored in the qstr.
>=20
> That's a very confusing choice of name because _hashed() (to me) sounds
> like the opposite of d_unhashed() which is not at all the case.

True.  But maybe the confusion what already there.
You can "d_add()" a dentry and later "d_drop()" the dentry and if the
dentry isn't between those two operations, then it is "d_unhashed()"
which leaks out the implementation detail (hash table) for dentry
lookup. Maybe d_unhashed() should be d_added() with inverted meaning?

There is only one user of this interface outside of namei.c so I could
unexported to keep the confusion local.  That would mean
ksmbd_vfs_path_lookup() would hav to use dentry_lookup_noperm() which
would recalculate the hash which vfs_path_parent_lookup() already
calculated (and we cannot simply tell it not to bother calculating).
Actually it already uses lookup_noperm_unlocked() in the
don't-need-a-lock-branch which recalculates the hash.....

Would making that name static ease your concern?

>=20
> > This is useful following filename_parentat().
> >
> > These are intended to be paired with done_dentry_lookup() which provides
> > the inverse of putting the dentry and unlocking.
> >
> > Like lookup_one_qstr_excl(), dentry_lookup() returns -ENOENT if
> > LOOKUP_CREATE was NOT given and the name cannot be found,, and returns
> > -EEXIST if LOOKUP_EXCL WAS given and the name CAN be found.
> >
> > These functions replace all uses of lookup_one_qstr_excl() in namei.c
> > except for those used for rename.
> >
> > Some of the variants should possibly be inlines in a header.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/namei.c            | 158 ++++++++++++++++++++++++++++++------------
> >  include/linux/namei.h |   8 ++-
> >  2 files changed, 119 insertions(+), 47 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 950a0d0d54da..f292df61565a 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1714,17 +1714,98 @@ struct dentry *lookup_one_qstr_excl(const struct =
qstr *name,
> >  }
> >  EXPORT_SYMBOL(lookup_one_qstr_excl);
> >
> > +/**
> > + * dentry_lookup_hashed - lookup and lock a name prior to dir ops
> > + * @last: the name in the given directory
> > + * @base: the directory in which the name is to be found
> > + * @lookup_flags: %LOOKUP_xxx flags
> > + *
> > + * The name is looked up and necessary locks are taken so that
> > + * the name can be created or removed.
> > + * The "necessary locks" are currently the inode node lock on @base.
> > + * The name @last is expected to already have the hash calculated.
> > + * No permission checks are performed.
> > + * Returns: the dentry, suitably locked, or an ERR_PTR().
> > + */
> > +struct dentry *dentry_lookup_hashed(struct qstr *last,
> > +                                   struct dentry *base,
> > +                                   unsigned int lookup_flags)
> > +{
> > +       struct dentry *dentry;
> > +
> > +       inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
> > +
> > +       dentry =3D lookup_one_qstr_excl(last, base, lookup_flags);
> > +       if (IS_ERR(dentry))
> > +               inode_unlock(base->d_inode);
> > +       return dentry;
> > +}
> > +EXPORT_SYMBOL(dentry_lookup_hashed);
>=20
> Observation:
>=20
> This part could be factored out of
> __kern_path_locked()/kern_path_locked_negative()

This patch does exactly that....

>=20
> If you do that in patch 2 while introducing done_dentry_lookup() then
> it also makes
> a lot of sense to balance the introduced done_dentry_lookup() with the
> factored out
> helper __dentry_lookup_locked() or whatever its name is.

I don't think I want a __dentry_lookup_locked().  The lock and the
lookup need to be tightly connected.
But maybe I cold introduce dentry_lookup_hashed() in patch 2 ...
Or maybe call it __dentry_lookup() ??

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20


