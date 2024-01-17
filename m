Return-Path: <linux-fsdevel+bounces-8149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30868305A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 13:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB9A284570
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911FB1EA71;
	Wed, 17 Jan 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8XBG0m7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54601D681;
	Wed, 17 Jan 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495246; cv=none; b=j+ITsZe15MWyt4r58HeWs9UVHq7sZJ4EgeX53sd2Zp5Zx4+/eNqnXfT2e5i7GW/WxrRukdKzF0/E6trQ0G70tfXeuOoDYD0471fa3abyt9tNV378paT52Lf8/72vGAWN95iDp6DxEm5y5RgAfFKGhtjW5XBaZJpD0Ub14ptiwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495246; c=relaxed/simple;
	bh=vnX++OaG8XIjdFf86sK89KGnj3uGGN/tScXcZnLS/bY=;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=KLuziqx2Bo7Kd4iQ+qYJyDZfPAMOk63BS4xItXc9xcZLcVh8XN63+02TF1TYObGjhAwfbpF/veX6bWAXiGPNioraxMEwiLOaMsFxmaO25C30HFyI3xzYcgoCR2mr6QmfZwMvOqu+plVPYkVh47i39ndTP8/jwcPOQ+yqKvk7TUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8XBG0m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA71C433C7;
	Wed, 17 Jan 2024 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705495245;
	bh=vnX++OaG8XIjdFf86sK89KGnj3uGGN/tScXcZnLS/bY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T8XBG0m7icYvgtYgUCtgqhyGpesFj3ygWRyteRdZpdkCvWCOFrUP9WeNHcGB6nNiy
	 gmL/ViW3FzxW5iJTbx1dX8LmMzJn/KqWmrJcL7Z0gQr3leFmzRJRpWwGZRliyNcYC9
	 4oM+iAUr7atTJ/VUJX1dDaf7cHVx9g3g2/xtYOObAaaYw6N1rQgJmz47pqElEwiROd
	 HttErcrGUTy1mVZvckvJjZXorVTLQbF6siEYIGjKzwGVpT/HKWvfCdK4YHjej1t1jS
	 wMGtquYQ3WwJzpndv+C8srVzAMh+j3GQNgSlXj6uEQB6JZ2ccbt0205ZdvrrkrV1ic
	 5ITq8nmgeChvQ==
Message-ID: <6d7f8219f761bec5661906de80cbbb9b75db900d.camel@kernel.org>
Subject: Re: [PATCH 12/20] filelock: make __locks_delete_block and
 __locks_wake_up_blocks take file_lock_core
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
 <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alexander Aring <aahringo@redhat.com>, David Teigland
 <teigland@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Andreas
 Gruenbacher <agruenba@redhat.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>,  Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,  Jan Kara
 <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, Joel Becker
 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Steve French
 <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg
 <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon
 <linkinjeon@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
 gfs2@lists.linux.dev,  linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org,  ocfs2-devel@lists.linux.dev,
 linux-cifs@vger.kernel.org,  samba-technical@lists.samba.org,
 linux-trace-kernel@vger.kernel.org
Date: Wed, 17 Jan 2024 07:40:39 -0500
In-Reply-To: <170544378717.23031.5597414508293858294@noble.neil.brown.name>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
	, <20240116-flsplit-v1-12-c9d0f4370a5d@kernel.org>
	 <170544378717.23031.5597414508293858294@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-17 at 09:23 +1100, NeilBrown wrote:
> On Wed, 17 Jan 2024, Jeff Layton wrote:
> > Convert __locks_delete_block and __locks_wake_up_blocks to take a struc=
t
> > file_lock_core pointer. Note that to accomodate this, we need to add a
> > new file_lock() wrapper to go from file_lock_core to file_lock.
>=20
> Actually we don't need it.... see below.
>=20
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/locks.c | 43 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/fs/locks.c b/fs/locks.c
> > index eddf4d767d5d..6b8e8820dec9 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -92,6 +92,11 @@ static inline bool IS_LEASE(struct file_lock_core *f=
lc)
> > =20
> >  #define IS_REMOTELCK(fl)	(fl->fl_core.fl_pid <=3D 0)
> > =20
> > +struct file_lock *file_lock(struct file_lock_core *flc)
> > +{
> > +	return container_of(flc, struct file_lock, fl_core);
> > +}
> > +
> >  static bool lease_breaking(struct file_lock *fl)
> >  {
> >  	return fl->fl_core.fl_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDI=
NG);
> > @@ -677,31 +682,35 @@ static void locks_delete_global_blocked(struct fi=
le_lock_core *waiter)
> >   *
> >   * Must be called with blocked_lock_lock held.
> >   */
> > -static void __locks_delete_block(struct file_lock *waiter)
> > +static void __locks_delete_block(struct file_lock_core *waiter)
> >  {
> > -	locks_delete_global_blocked(&waiter->fl_core);
> > -	list_del_init(&waiter->fl_core.fl_blocked_member);
> > +	locks_delete_global_blocked(waiter);
> > +	list_del_init(&waiter->fl_blocked_member);
> >  }
> > =20
> > -static void __locks_wake_up_blocks(struct file_lock *blocker)
> > +static void __locks_wake_up_blocks(struct file_lock_core *blocker)
> >  {
> > -	while (!list_empty(&blocker->fl_core.fl_blocked_requests)) {
> > -		struct file_lock *waiter;
> > +	while (!list_empty(&blocker->fl_blocked_requests)) {
> > +		struct file_lock_core *waiter;
> > +		struct file_lock *fl;
> > +
> > +		waiter =3D list_first_entry(&blocker->fl_blocked_requests,
> > +					  struct file_lock_core, fl_blocked_member);
> > =20
> > -		waiter =3D list_first_entry(&blocker->fl_core.fl_blocked_requests,
> > -					  struct file_lock, fl_core.fl_blocked_member);
>=20
> > +		fl =3D file_lock(waiter);
>=20
> 		fl =3D list_first_entry(&blocker->fl_core.fl_blocked_requests,
> 				      struct file_lock, fl_core.fl_blocked_member);
>=20
>                 waiter =3D &fl->fl_core;
>=20
> achieves the same result without needing file_lock().
>=20
> If you really want to add file_lock() then do so, but you need a better
> justification :-)
>=20
>=20

Except that we actually do need to pass the file_lock pointer to
lm_notify in the block below. There are also some other places that come
up later that will need file_lock() (and file_lease(), for that matter).
I probably could get away without the container_of wrappers, but then
we'd need separate functions for leases for some of the fs/locks.c code.

To be clear, this is not the "cleanest" split ever. If we were
reimplementing leases from scratch today, I'd probably not piggyback on
so much of the file locking code. My main goal here is to get the
initial struct split done. Once that's finished, we may be able to do a
more clean separation later.

>=20
>=20
> >  		__locks_delete_block(waiter);
> > -		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
> > -			waiter->fl_lmops->lm_notify(waiter);
> > +		if ((IS_POSIX(waiter) || IS_FLOCK(waiter)) &&
> > +		    fl->fl_lmops && fl->fl_lmops->lm_notify)
> > +			fl->fl_lmops->lm_notify(fl);


> >  		else
> > -			wake_up(&waiter->fl_core.fl_wait);
> > +			wake_up(&waiter->fl_wait);
> > =20
> >  		/*
> >  		 * The setting of fl_blocker to NULL marks the "done"
> >  		 * point in deleting a block. Paired with acquire at the top
> >  		 * of locks_delete_block().
> >  		 */
> > -		smp_store_release(&waiter->fl_core.fl_blocker, NULL);
> > +		smp_store_release(&waiter->fl_blocker, NULL);
> >  	}
> >  }
> > =20
> > @@ -743,8 +752,8 @@ int locks_delete_block(struct file_lock *waiter)
> >  	spin_lock(&blocked_lock_lock);
> >  	if (waiter->fl_core.fl_blocker)
> >  		status =3D 0;
> > -	__locks_wake_up_blocks(waiter);
> > -	__locks_delete_block(waiter);
> > +	__locks_wake_up_blocks(&waiter->fl_core);
> > +	__locks_delete_block(&waiter->fl_core);
> > =20
> >  	/*
> >  	 * The setting of fl_blocker to NULL marks the "done" point in deleti=
ng
> > @@ -799,7 +808,7 @@ static void __locks_insert_block(struct file_lock *=
blocker,
> >  	 * waiter, but might not conflict with blocker, or the requests
> >  	 * and lock which block it.  So they all need to be woken.
> >  	 */
> > -	__locks_wake_up_blocks(waiter);
> > +	__locks_wake_up_blocks(&waiter->fl_core);
> >  }
> > =20
> >  /* Must be called with flc_lock held. */
> > @@ -831,7 +840,7 @@ static void locks_wake_up_blocks(struct file_lock *=
blocker)
> >  		return;
> > =20
> >  	spin_lock(&blocked_lock_lock);
> > -	__locks_wake_up_blocks(blocker);
> > +	__locks_wake_up_blocks(&blocker->fl_core);
> >  	spin_unlock(&blocked_lock_lock);
> >  }
> > =20
> > @@ -1186,7 +1195,7 @@ static int posix_lock_inode(struct inode *inode, =
struct file_lock *request,
> >  			 * Ensure that we don't find any locks blocked on this
> >  			 * request during deadlock detection.
> >  			 */
> > -			__locks_wake_up_blocks(request);
> > +			__locks_wake_up_blocks(&request->fl_core);
> >  			if (likely(!posix_locks_deadlock(request, fl))) {
> >  				error =3D FILE_LOCK_DEFERRED;
> >  				__locks_insert_block(fl, request,
> >=20
> > --=20
> > 2.43.0
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

