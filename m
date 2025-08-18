Return-Path: <linux-fsdevel+bounces-58215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FC0B2B3C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 23:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520FF1BA45E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 21:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE3C224234;
	Mon, 18 Aug 2025 21:53:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F725BAF0;
	Mon, 18 Aug 2025 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553983; cv=none; b=fxQbzjpHBb02KM6Y0ENJTqANnT2Jd4yW4Szm2rRQMubeJ/sONfT9P1Bct+gjroT6W0Zt8RMSktWxe2TtuFA7bc1v1x0jwhHkU1syBlRYL8H47XJlqWyNjjnvlVFNhw3yPKCjdoU/bYoPy8orYtQtqlFcbVW/gs0Yb+5L9TGkIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553983; c=relaxed/simple;
	bh=DRMHdG3YWKwtd/b4JUaXjeLRAB0QV9VPh5fLSKg7/3g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=M67OWXZDympLyU5ZO9+VBC7a0VAHNq88LPWc3bU+DuLBL0DMcQwJCnjuZvCOwM1o+R3BYGSiFcaiuJdIJYiSRDyPGUIhO6q+B4NuFS2Mg1KQOgY/U6XWbcMuNs/P8g5eBBalss3vJH8EGR1b7uq2/PJp1fj9UDouNr+73azUx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uo7mP-006FjJ-U7;
	Mon, 18 Aug 2025 21:52:39 +0000
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
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Steve French" <sfrench@samba.org>, "Namjae Jeon" <linkinjeon@kernel.org>,
 "Carlos Maiolino" <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, netfs@lists.linux.dev,
 ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
In-reply-to:
 <CAOQ4uxjFPOZe004Cv+tT=NyQg2JOY6MOYQniSjaefVcg+3s-Kg@mail.gmail.com>
References:
 <>, <CAOQ4uxjFPOZe004Cv+tT=NyQg2JOY6MOYQniSjaefVcg+3s-Kg@mail.gmail.com>
Date: Tue, 19 Aug 2025 07:52:39 +1000
Message-id: <175555395905.2234665.9441673384189011517@noble.neil.brown.name>

On Mon, 18 Aug 2025, Amir Goldstein wrote:
> On Wed, Aug 13, 2025 at 1:53=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > A few callers operate on a dentry which they already have - unlike the
> > normal case where a lookup proceeds an operation.
> >
> > For these callers dentry_lookup_continue() is provided where other
> > callers would use dentry_lookup().  The call will fail if, after the
> > lock was gained, the child is no longer a child of the given parent.
> >
> > There are a couple of callers that want to lock a dentry in whatever
> > its current parent is.  For these a NULL parent can be passed, in which
> > case ->d_parent is used.  In this case the call cannot fail.
> >
> > The idea behind the name is that the actual lookup occurred some time
> > ago, and now we are continuing with an operation on the dentry.
> >
> > When the operation completes done_dentry_lookup() must be called.  An
> > extra reference is taken when the dentry_lookup_continue() call succeeds
> > and will be dropped by done_dentry_lookup().
> >
> > This will be used in smb/server, ecryptfs, and overlayfs, each of which
> > have their own lock_parent() or parent_lock() or similar; and a few
> > other places which lock the parent but don't check if the parent is
> > still correct (often because rename isn't supported so parent cannot be
> > incorrect).
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/namei.c            | 39 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/namei.h |  2 ++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 7af9b464886a..df21b6fa5a0e 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1874,6 +1874,45 @@ struct dentry *dentry_lookup_killable(struct mnt_i=
dmap *idmap,
> >  }
> >  EXPORT_SYMBOL(dentry_lookup_killable);
> >
> > +/**
> > + * dentry_lookup_continue: lock a dentry if it is still in the given par=
ent, prior to dir ops
> > + * @child: the dentry to lock
> > + * @parent: the dentry of the assumed parent
> > + *
> > + * The child is locked - currently by taking i_rwsem on the parent - to
> > + * prepare for create/remove operations.  If the given parent is not
> > + * %NULL and is no longer the parent of the dentry after the lock is
> > + * gained, the lock is released and the call fails (returns
> > + * ERR_PTR(-EINVAL).
> > + *
> > + * On success a reference to the child is taken and returned.  The lock
> > + * and reference must both be dropped by done_dentry_lookup() after the
> > + * operation completes.
> > + */
> > +struct dentry *dentry_lookup_continue(struct dentry *child,
> > +                                     struct dentry *parent)
> > +{
> > +       struct dentry *p =3D parent;
> > +
> > +again:
> > +       if (!parent)
> > +               p =3D dget_parent(child);
> > +       inode_lock_nested(d_inode(p), I_MUTEX_PARENT);
> > +       if (child->d_parent !=3D p) {
>=20
> || d_unhashed(child))
>=20
> ;)

As you say!

>=20
> and what about silly renames? are those also d_unhashed()?

With NFS it is not unhashed (i.e.  it is still hashed, but with a
different name).  I haven't checked AFS.

But does it matter?  As long as it has the right parent and is not
unhashed, it is a suitable dentry to pass to vfs_unlink() etc.

If this race happened with NFS then ovl could try to remove the .nfsXXX
file and would get ETXBUSY due to DCACH_NFSFS_RENAMED.  I don't think
this is a problem.

If we really wanted to be sure the name hadn't changed we could do a
lookup and check that the same dentry is returned.

OVL is by nature exposed to possible races if something else tried to
modify the upper directory tree.  I don't think it needs to provide
perfect semantics in that case, it only needs to fail-safe.  I think
this recent change is enough to be safe in the face of concurrent
unlinks.

Thanks,
NeilBrown

=20
> Thanks,
> Amir.
>=20


