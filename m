Return-Path: <linux-fsdevel+bounces-76643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHcAHrJDhmmbLQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:40:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E98102DD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BCCA3016D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325F930E0D2;
	Fri,  6 Feb 2026 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAD5qiMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419830C62A;
	Fri,  6 Feb 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406810; cv=none; b=tHBrxlfgmk7W9lwvquxlErudxDWGcjOqAVV11vQDMmvQayE1X5gLpxM/cn9GDKwY1YXVp7oviGTI9hp0oQhAsRV40vO1XYgHSZKdt6ul7x80mSyvji6/pU9ZrGo4zpMyLDNTo83Hg9K4MlnwRQDcP1EJMPGOzSNEQItmWI6Eyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406810; c=relaxed/simple;
	bh=4xMULAc9CiGzhs8emWJMqDwNHC2b2s/1qRfMFzi9Jwo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=C2ao+eU/A2wkJ5wIwMTaPyAVlIyFcoloOfXy+LGkhUHaR8KUBYpi7xqpvb/gP7VxodSoljSk6K2rJF4SxcbHomPKBAIcTiDof250douXS3E9q8IXF+jnegTrx3Z/c+F+qmcKJOrH6+31z/MdS4bbQ0X3yWQY8hcEk+11sQ28oT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAD5qiMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6DEC116C6;
	Fri,  6 Feb 2026 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770406810;
	bh=4xMULAc9CiGzhs8emWJMqDwNHC2b2s/1qRfMFzi9Jwo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=JAD5qiMDINHN1f22ifvUG4DLAEWHyQzvQ25CQkl7tuEPnp5Qkv9OTne/7vzLunEsO
	 5pZY8m/oJuKYPm0Mq9gw26TKIxn4FzDy3rgdvpb2ae/Oze6s4KRwM2mg+OA39pJeoV
	 q+HRyqfshoIhS36LEHOB9+eZqlPe6WeMTVZ7G3Pb35vtVZC8YnFf0EwUpoYXW4y4fe
	 Fmtw5HgCiywTgKrH3MAtZaIPXomjnbxHydiG/v4R8PZVtLYvbEFBavZUuVdBY5D1P9
	 ceud3vH8Jlm99yflzd8DNUx24EcKXyK762XMNnh10rrtg7mZIt2EVDuO7gWv+GlOCc
	 kmHTxYy8fsgLw==
Message-ID: <3cb09bd01df3d43293f2f443ebb6b4a10ea50dee.camel@kernel.org>
Subject: Re: [PATCH v5 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
In-Reply-To: <6a28e81b-1e2e-4457-8bec-4312e6d3246f@oracle.com>
References: <20260205202929.879846-1-dai.ngo@oracle.com>
	 <9194ce4db4391c0e6428f97b05fcee53706fb485.camel@kernel.org>
	 <6a28e81b-1e2e-4457-8bec-4312e6d3246f@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Feb 2026 14:40:03 -0500
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76643-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17E98102DD7
X-Rspamd-Action: no action

On Fri, 2026-02-06 at 10:17 -0800, Dai Ngo wrote:
> On 2/6/26 6:28 AM, Jeff Layton wrote:
> > On Thu, 2026-02-05 at 12:29 -0800, Dai Ngo wrote:
> > > When a layout conflict triggers a recall, enforcing a timeout is
> > > necessary to prevent excessive nfsd threads from being blocked in
> > > __break_lease ensuring the server continues servicing incoming
> > > requests efficiently.
> > >=20
> > > This patch introduces a new function to lease_manager_operations:
> > >=20
> > > lm_breaker_timedout: Invoked when a lease recall times out and is
> > > about to be disposed of. This function enables the lease manager
> > > to inform the caller whether the file_lease should remain on the
> > > flc_list or be disposed of.
> > >=20
> > > For the NFSD lease manager, this function now handles layout recall
> > > timeouts. If the layout type supports fencing and the client has not
> > > been fenced, a fence operation is triggered to prevent the client
> > > from accessing the block device.
> > >=20
> > > While the fencing operation is in progress, the conflicting file_leas=
e
> > > remains on the flc_list until fencing is complete. This guarantees
> > > that no other clients can access the file, and the client with
> > > exclusive access is properly blocked before disposal.
> > >=20
> > Fair point. However...
> >=20
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   Documentation/filesystems/locking.rst |   2 +
> > >   fs/locks.c                            |  15 +++-
> > >   fs/nfsd/blocklayout.c                 |  41 ++++++++--
> > >   fs/nfsd/nfs4layouts.c                 | 113 +++++++++++++++++++++++=
++-
> > >   fs/nfsd/nfs4state.c                   |   1 +
> > >   fs/nfsd/pnfs.h                        |   2 +-
> > >   fs/nfsd/state.h                       |   8 ++
> > >   include/linux/filelock.h              |   1 +
> > >   8 files changed, 169 insertions(+), 14 deletions(-)
> > >=20
> > > v2:
> > >      . Update Subject line to include fencing operation.
> > >      . Allow conflicting lease to remain on flc_list until fencing
> > >        is complete.
> > >      . Use system worker to perform fencing operation asynchronously.
> > >      . Use nfs4_stid.sc_count to ensure layout stateid remains
> > >        valid before starting the fencing operation, nfs4_stid.sc_coun=
t
> > >        is released after fencing operation is complete.
> > >      . Rework nfsd4_scsi_fence_client to:
> > >           . wait until fencing to complete before exiting.
> > >           . wait until fencing in progress to complete before
> > >             checking the NFSD_MDS_PR_FENCED flag.
> > >      . Remove lm_need_to_retry from lease_manager_operations.
> > > v3:
> > >      . correct locking requirement in locking.rst.
> > >      . add max retry count to fencing operation.
> > >      . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
> > >      . remove special-casing of FL_LAYOUT in lease_modify.
> > >      . remove lease_want_dispose.
> > >      . move lm_breaker_timedout call to time_out_leases.
> > > v4:
> > >      . only increment ls_fence_retry_cnt after successfully
> > >        schedule new work in nfsd4_layout_lm_breaker_timedout.
> > > v5:
> > >      . take reference count on layout stateid before starting
> > >        fence worker.
> > >      . restore comments in nfsd4_scsi_fence_client and the
> > >        code that check for specific errors.
> > >      . cancel fence worker before freeing layout stateid.
> > >      . increase fence retry from 5 to 20.
> > >=20
> > > NOTE:
> > >      I experimented with having the fence worker handle lease
> > >      disposal after fencing the client. However, this requires
> > >      the lease code to export the lease_dispose_list function,
> > >      and for the fence worker to acquire the flc_lock in order
> > >      to perform the disposal. This approach adds unnecessary
> > >      complexity and reduces code clarity, as it exposes internal
> > >      lease code details to the nfsd worker, which should not
> > >      be the case.
> > >=20
> > >      Instead, the lm_breaker_timedout operation should simply
> > >      notify the lease code about how to handle a lease that
> > >      times out during a lease break, rather than directly
> > >      manipulating the lease list.
> > >=20
> > Ok, fair point.
> >=20
> > > diff --git a/Documentation/filesystems/locking.rst b/Documentation/fi=
lesystems/locking.rst
> > > index 04c7691e50e0..79bee9ae8bc3 100644
> > > --- a/Documentation/filesystems/locking.rst
> > > +++ b/Documentation/filesystems/locking.rst
> > > @@ -403,6 +403,7 @@ prototypes::
> > >   	bool (*lm_breaker_owns_lease)(struct file_lock *);
> > >           bool (*lm_lock_expirable)(struct file_lock *);
> > >           void (*lm_expire_lock)(void);
> > > +        bool (*lm_breaker_timedout)(struct file_lease *);
> > >  =20
> > >   locking rules:
> > >  =20
> > > @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
> > >   lm_lock_expirable	yes		no			no
> > >   lm_expire_lock		no		no			yes
> > >   lm_open_conflict	yes		no			no
> > > +lm_breaker_timedout     yes             no                      no
> > >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >  =20
> > >   buffer_head
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index 46f229f740c8..0e77423cf000 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode=
, struct list_head *dispose)
> > >   {
> > >   	struct file_lock_context *ctx =3D inode->i_flctx;
> > >   	struct file_lease *fl, *tmp;
> > > +	bool remove =3D true;
> > >  =20
> > >   	lockdep_assert_held(&ctx->flc_lock);
> > >  =20
> > > @@ -1531,8 +1532,18 @@ static void time_out_leases(struct inode *inod=
e, struct list_head *dispose)
> > >   		trace_time_out_leases(inode, fl);
> > >   		if (past_time(fl->fl_downgrade_time))
> > >   			lease_modify(fl, F_RDLCK, dispose);
> > > -		if (past_time(fl->fl_break_time))
> > > -			lease_modify(fl, F_UNLCK, dispose);
> > > +
> > > +		if (past_time(fl->fl_break_time)) {
> > > +			/*
> > > +			 * Consult the lease manager when a lease break times
> > > +			 * out to determine whether the lease should be disposed
> > > +			 * of.
> > > +			 */
> > > +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
> > > +				remove =3D fl->fl_lmops->lm_breaker_timedout(fl);
> > > +			if (remove)
> > > +				lease_modify(fl, F_UNLCK, dispose);
> > When remove is false, and lease_modify() doesn't happen (i.e., the
> > common case where we queue the wq job), when do you actually remove the
> > lease?
>=20
> The lease is removed when the fence worker completes the fencing operatio=
n
> and set ls_fenced to true. When __break_lease/time_out_leases calls
> lm_breaker_timedout again, nfsd4_layout_lm_breaker_timedout returns true
> since ls_fenced is now set.
>=20
> >=20
> > Are you just assuming that after the client is fenced, that the layout
> > stateid's refcount will go to zero? I'm curious what drives that
> > process, if so.
>=20
> No, after completing the fence operation, the fenced worker drops the
> reference count on the layout stateid by calling nfs4_put_stid(). If
> the reference drops to 0 then the layout stateid is freed at this
> point, otherwise it will be freed when the CB_RECALL callback times
> out.
>=20

In principle the stateid could stick around for a while after the fence
has occurred. It would be better to unlock the lease as soon as the
fencing is done, so that tasks waiting on it can proceed (a'la
kernel_setlease() with F_UNLCK).

--=20
Jeff Layton <jlayton@kernel.org>

