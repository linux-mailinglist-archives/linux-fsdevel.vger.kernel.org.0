Return-Path: <linux-fsdevel+bounces-51216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFE2AD479A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 03:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3823A89A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 01:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3A2030A;
	Wed, 11 Jun 2025 01:00:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537D944E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603619; cv=none; b=K+xEaJmrXluLsIy7DYTcvet/NoDIpUxPfuJkzVO7WYto2gs3z3Q+UswL4PMxogFEXg60N2acmmksqMpvibm68C89Jf/sR2iQAvPhTaefQtA8XJcoWDODksRuKJJ3817w0oda7Lo8ZLsErmM0wAWPO+KKBREgdZ76Fcgy+hiGQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603619; c=relaxed/simple;
	bh=tK2j7VPVlwYPO0yCJuWBsC4NOph9FjJWMfuf/NYQ14A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HArO2BPWxk7TIwW+5xAvvdETRbLpkDtDs2/wzqpSlStfo5f/5UcHdDdYvCkQkk4ce4XbchsasKoc/zOqsqMc8/56Uor6+QV2zzQQQMjF12Sr5koMVW6Z8t/8ZBhA5FBT+E/znwzEWo7y7uhe/D0l0H5AcDTvVpIC89alY7DEgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uP9p1-007vCR-97;
	Wed, 11 Jun 2025 01:00:07 +0000
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
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH 5/8] Introduce S_DYING which warns that S_DEAD might follow.
In-reply-to: <20250610205732.GG299672@ZenIV>
References: <>, <20250610205732.GG299672@ZenIV>
Date: Wed, 11 Jun 2025 11:00:06 +1000
Message-id: <174960360675.608730.17207039742680720579@noble.neil.brown.name>

On Wed, 11 Jun 2025, Al Viro wrote:
> On Mon, Jun 09, 2025 at 05:34:10PM +1000, NeilBrown wrote:
> > Once we support directory operations (e.g. create) without requiring the
> > parent to be locked, the current practice locking a directory while
> > processing rmdir() or similar will not be sufficient to wait for
> > operations to complete and to block further operations.
> >=20
> > This patch introduced a new inode flag S_DYING.  It indicates that
> > a rmdir or similar is being processed and new directory operations must
> > not commence in the directory.  They should not abort either as the
> > rmdir might fail - instead they should block.  They can do this by
> > waiting for a lock on the inode.
> >=20
> > A new interface rmdir_lock() locks the inode, sets this flag, and waits
> > for any children with DCACHE_LOCK set to complete their operation, and
> > for any d_in_lookup() children to complete the lookup.  It should be
> > called before attempted to delete the directory or set S_DEAD.  Matching
> > rmdir_unlock() clears the flag and unlocks the inode.
> >=20
> > dentry_lock() and d_alloc_parallel() are changed to block while this
> > flag it set and to fail if the parent IS_DEADDIR(), though dentry_lock()
> > doesn't block for d_in_lookup() dentries.
>=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 4ad76df21677..c590f25d0d49 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1770,8 +1770,11 @@ static bool __dentry_lock(struct dentry *dentry,
> >  			  struct dentry *base, const struct qstr *last,
> >  			  unsigned int subclass, int state)
> >  {
> > +	struct dentry *parent;
> > +	struct inode *dir;
> >  	int err;
> > =20
> > +retry:
> >  	lock_acquire_exclusive(&dentry->dentry_map, subclass, 0, NULL, _THIS_IP=
_);
> >  	spin_lock(&dentry->d_lock);
> >  	err =3D wait_var_event_any_lock(&dentry->d_flags,
> > @@ -1782,10 +1785,43 @@ static bool __dentry_lock(struct dentry *dentry,
> >  		spin_unlock(&dentry->d_lock);
> >  		return false;
> >  	}
> > -
> > -	dentry->d_flags |=3D DCACHE_LOCK;
> > +	parent =3D dentry->d_parent;
>=20
> Why will it stay the parent?  Matter of fact, why will it stay positive?

As long as we continue to hold dentry->d_lock it will stay the
parent, and so will have a reference, and so will stay positive.

>=20
> > +	dir =3D igrab(parent->d_inode);
>=20
> ... and not oops right here?

Still holding dentry->d_lock here so parent cannot have changed.

>=20
> > +	lock_map_release(&dentry->dentry_map);
> >  	spin_unlock(&dentry->d_lock);
> > -	return true;
> > +
> > +	if (state =3D=3D TASK_KILLABLE) {
> > +		err =3D down_write_killable(&dir->i_rwsem);
> > +		if (err) {
> > +			iput(dir);
> > +			return false;
> > +		}
> > +	} else
> > +		inode_lock(dir);
> > +	/* S_DYING much be clear now */
> > +	inode_unlock(dir);
> > +	iput(dir);
> > +	goto retry;
>=20
> OK, I'm really confused now.  Is it allowed to call dentry_lock() while hol=
ding
> ->i_rwsem of the parent?

Yes.

>=20
> Where does your dentry lock nest wrt ->i_rwsem?  As a bonus (well, malus, I=
 guess)
> question, where does it nest wrt parent *and* child inodes' ->i_rwsem for r=
mdir
> and rename?

Between inode of parent of the dentry and inode of the dentry.

In this case we aren't holding the dentry lock when we lock the parent.
We might already have the parent locked when calling dentry_lock() if
the filesystem hasn't opted out) but in that case S_DYING will not be
set.  It is only set while holding the i_rw_sem in case which doesn't
lock dentries.  So if S_DYING is set here, then it must be safe to lock
the parent.

>=20
> Tangentially connected question: which locks are held for ->unlink() in your
> scheme?  You do need *something* on the victim inode to protect ->i_nlink
> modifications, and anything on dentries of victim or their parent directori=
es
> is not going to give that.
>=20

I haven't change the locking on non-directories at all.  The target of
->unlink() will be locked after the dentry is locked (which is after the
parent is locked if the fs requires that).

->i_nlink for non-directories is still protected by ->i_rwsem on the
inode.
->i_nlink for directories is something the fs will have to handle
when opting out of i_rwsem on directory ops.  NFS, for example, already
takes inode->i_lock when calling inc_nlink() or drop_nlink().  The
set_nlink() in nfs_update_inode() isn't obviously protected but as the
number is informational it possibly doesn't matter.

Thanks,
NeilBrown


