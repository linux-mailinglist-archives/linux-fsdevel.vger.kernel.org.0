Return-Path: <linux-fsdevel+bounces-74742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCQgBz0McGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:14:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD54D979
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CA06A6EDDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207CA3D3CEE;
	Tue, 20 Jan 2026 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuAchwS5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454829E0E8;
	Tue, 20 Jan 2026 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946635; cv=none; b=Dg0lLIBEHHYlc8L6PPpZB/YwNHivYcI12vTvE5VhzD8RdSYs4nro3iBcz4Dt+7PY/uVtafnhEl29mKG2INEOnYL3+uy5dsuZik1Mdy0yjfqC/d3lXHfdVwI9OvPbYgEcLdjemf0xkjQpgsVAq2wrBAfC7FHKp6t/qDVuktKfOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946635; c=relaxed/simple;
	bh=QtV8uULyytRK2EusY3+AapAO9h5BLlsEFlYD5L8vIrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pw6TzPpAgR09T3x65XUlcIkAD6fkonUxCTpgkWwtWVh2peR4O79A6cUpLCYRJtUvUQJfP/D+3rQymt5MqnlJv2RCBYvbJz9PDNsmCSU/BseabxYlIVL3bX+YWU873wzoD6tsDTomn7DvGQlzwHAIbr+6msLM/KxUc7gjpVwj89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuAchwS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E27C19422;
	Tue, 20 Jan 2026 22:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768946634;
	bh=QtV8uULyytRK2EusY3+AapAO9h5BLlsEFlYD5L8vIrs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fuAchwS59QIn6qKHG/s5e+Xu364XFn4ijkDoH/LuDyHL9No3Eqs8665KslbHlKWoT
	 bEpsZVPbMnbcDy13EKsPxL43SuzqJ3/WY8qRL+usTfXIN/YaSQS4kt7mmXq9WWDyp8
	 D0/0ujdIGgH48yu5/VvkQkkVKvENbaKioKAWb8NW8tu+Tn9rejlgP3LtlS7qC7qVTH
	 W71y/dFuApORh+A6KBAGSDHqX/xVPaH0voCswihFjuxSnsJXLzdHoiVMqEHOGRJpms
	 qWt+5wlj8kdCkCi80L64H5XGI4K/bSmsxAjDiginy/VrMINAxIfxuNhhVN3owWa6LV
	 RS1RsdHhZQQPg==
Message-ID: <06f45f752d868d267947035dd578dca615d4b68e.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Tue, 20 Jan 2026 17:03:52 -0500
In-Reply-To: <59921524-57d4-4880-9374-b9b420104266@oracle.com>
References: <20260119174737.3619599-1-dai.ngo@oracle.com>
	 <f02d32dc80e1a51f4a91c5e3ce2a5fe10680e4ea.camel@kernel.org>
	 <a1dc8306-6422-45c8-a5b0-8d10a4d89279@oracle.com>
	 <f2203e755aca4da45b099b18aac03b0a9d299343.camel@kernel.org>
	 <59921524-57d4-4880-9374-b9b420104266@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74742-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9ABD54D979
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 13:42 -0800, Dai Ngo wrote:
> On 1/20/26 1:28 PM, Jeff Layton wrote:
> > On Tue, 2026-01-20 at 13:22 -0800, Dai Ngo wrote:
> > > On 1/20/26 12:41 PM, Jeff Layton wrote:
> > > > On Mon, 2026-01-19 at 09:47 -0800, Dai Ngo wrote:
> > > > > When a layout conflict triggers a recall, enforcing a timeout
> > > > > is necessary to prevent excessive nfsd threads from being tied
> > > > > up in __break_lease and ensure the server can continue servicing
> > > > > incoming requests efficiently.
> > > > >=20
> > > > > This patch introduces two new functions in lease_manager_operatio=
ns:
> > > > >=20
> > > > > 1. lm_breaker_timedout: Invoked when a lease recall times out,
> > > > >      allowing the lease manager to take appropriate action.
> > > > >=20
> > > > >      The NFSD lease manager uses this to handle layout recall
> > > > >      timeouts. If the layout type supports fencing, a fence
> > > > >      operation is issued to prevent the client from accessing
> > > > >      the block device.
> > > > >=20
> > > > > 2. lm_need_to_retry: Invoked when there is a lease conflict.
> > > > >      This allows the lease manager to instruct __break_lease
> > > > >      to return an error to the caller, prompting a retry of
> > > > >      the conflicting operation.
> > > > >=20
> > > > >      The NFSD lease manager uses this to avoid excessive nfsd
> > > > >      from being blocked in __break_lease, which could hinder
> > > > >      the server's ability to service incoming requests.
> > > > >=20
> > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > ---
> > > > >    Documentation/filesystems/locking.rst |  4 ++
> > > > >    fs/locks.c                            | 29 +++++++++++-
> > > > >    fs/nfsd/nfs4layouts.c                 | 65 +++++++++++++++++++=
++++++--
> > > > >    include/linux/filelock.h              |  7 +++
> > > > >    4 files changed, 100 insertions(+), 5 deletions(-)
> > > > >=20
> > > > > diff --git a/Documentation/filesystems/locking.rst b/Documentatio=
n/filesystems/locking.rst
> > > > > index 04c7691e50e0..ae9a1b207b95 100644
> > > > > --- a/Documentation/filesystems/locking.rst
> > > > > +++ b/Documentation/filesystems/locking.rst
> > > > > @@ -403,6 +403,8 @@ prototypes::
> > > > >    	bool (*lm_breaker_owns_lease)(struct file_lock *);
> > > > >            bool (*lm_lock_expirable)(struct file_lock *);
> > > > >            void (*lm_expire_lock)(void);
> > > > > +        void (*lm_breaker_timedout)(struct file_lease *);
> > > > > +        bool (*lm_need_to_retry)(struct file_lease *, struct fil=
e_lock_context *);
> > > > >   =20
> > > > >    locking rules:
> > > > >   =20
> > > > > @@ -417,6 +419,8 @@ lm_breaker_owns_lease:	yes     	no			no
> > > > >    lm_lock_expirable	yes		no			no
> > > > >    lm_expire_lock		no		no			yes
> > > > >    lm_open_conflict	yes		no			no
> > > > > +lm_breaker_timedout     no              no                      =
yes
> > > > > +lm_need_to_retry        yes             no                      =
no
> > > > >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >   =20
> > > > >    buffer_head
> > > > > diff --git a/fs/locks.c b/fs/locks.c
> > > > > index 46f229f740c8..cd08642ab8bb 100644
> > > > > --- a/fs/locks.c
> > > > > +++ b/fs/locks.c
> > > > > @@ -381,6 +381,14 @@ lease_dispose_list(struct list_head *dispose=
)
> > > > >    	while (!list_empty(dispose)) {
> > > > >    		flc =3D list_first_entry(dispose, struct file_lock_core, flc=
_list);
> > > > >    		list_del_init(&flc->flc_list);
> > > > > +		if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
> > > > > +			struct file_lease *fl;
> > > > > +
> > > > > +			fl =3D file_lease(flc);
> > > > > +			if (fl->fl_lmops &&
> > > > > +					fl->fl_lmops->lm_breaker_timedout)
> > > > > +				fl->fl_lmops->lm_breaker_timedout(fl);
> > > > > +		}
> > > > >    		locks_free_lease(file_lease(flc));
> > > > >    	}
> > > > >    }
> > > > > @@ -1531,8 +1539,10 @@ static void time_out_leases(struct inode *=
inode, struct list_head *dispose)
> > > > >    		trace_time_out_leases(inode, fl);
> > > > >    		if (past_time(fl->fl_downgrade_time))
> > > > >    			lease_modify(fl, F_RDLCK, dispose);
> > > > > -		if (past_time(fl->fl_break_time))
> > > > > +		if (past_time(fl->fl_break_time)) {
> > > > >    			lease_modify(fl, F_UNLCK, dispose);
> > > > > +			fl->c.flc_flags |=3D FL_BREAKER_TIMEDOUT;
> > > > > +		}
> > > > When the lease times out, you go ahead and remove it but then mark =
it
> > > > with FL_BREAKER_TIMEDOUT. Then later, you call ->lm_breaker_timedou=
t if
> > > > that's set.
> > > >=20
> > > > That means that when this happens, there is a window of time where
> > > > there is no lease, but the rogue client isn't yet fenced. That soun=
ds
> > > > like a problem as you could allow competing access.
> > > I have to think more about the implication of competing access. Since
> > > the thread that detects the conflict is in the process of fencing the
> > > other client and has not accessed the file data yet, I don't see the
> > > problem of allowing the other client to continue access the file unti=
l
> > > fence operation completed.
> > >=20
> > Isn't the whole point of write layout leases to grant exclusive access
> > to an external client? At the point where you lose the lease, any
> > competing access can then proceed. Maybe a local file writer starts
> > writing to the file at that point. But...what if the client is still
> > writing stuff to the backing store? Won't that corrupt data (and maybe
> > metadata)?
>=20
> The lease is removed but in_conflict is set. Doesn't that prevent other
> client to access the file until in_conflict is cleared?
>=20

Ok, I guess you're right...

The usual pattern is to call try_break_lease() first and then to call
break_lease() to wait for that to complete later (after all of the vfs
locks are unwound).=20

So, this might work, but it seems like it would be more "correct" to
set flc_in_conflict earlier, before you return EWOULDBLOCK on the first
attempt.

...and honestly, it would still be better to just do the fencing before
you remove the lease. That just seems less hacky (though the locking
may be more of a challenge), as the presence of the lease is what
indicates exclusive access.

If you did that, then I think you could look for the presence of a
lease on the list with FL_UNLOCK_PENDING or FL_DOWNGRADE_PENDING set,
instead of the flc_in_conflict file flag.

> >=20
> > > > I think you'll have to do this in reverse order: fence the client a=
nd
> > > > then remove the lease.
> > > >=20
> > > > >    	}
> > > > >    }
> > > > >   =20
> > > > > @@ -1633,6 +1643,8 @@ int __break_lease(struct inode *inode, unsi=
gned int flags)
> > > > >    	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list=
) {
> > > > >    		if (!leases_conflict(&fl->c, &new_fl->c))
> > > > >    			continue;
> > > > > +		if (new_fl->fl_lmops !=3D fl->fl_lmops)
> > > > > +			new_fl->fl_lmops =3D fl->fl_lmops;
> > > > >    		if (want_write) {
> > > > >    			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
> > > > >    				continue;
> > > > > @@ -1657,6 +1669,18 @@ int __break_lease(struct inode *inode, uns=
igned int flags)
> > > > >    		goto out;
> > > > >    	}
> > > > >   =20
> > > > > +	/*
> > > > > +	 * Check whether the lease manager wants the operation
> > > > > +	 * causing the conflict to be retried.
> > > > > +	 */
> > > > > +	if (new_fl->fl_lmops && new_fl->fl_lmops->lm_need_to_retry &&
> > > > > +			new_fl->fl_lmops->lm_need_to_retry(new_fl, ctx)) {
> > > > > +		trace_break_lease_noblock(inode, new_fl);
> > > > > +		error =3D -ERESTARTSYS;
> > > > > +		goto out;
> > > > > +	}
> > > > > +	ctx->flc_in_conflict =3D true;
> > > > > +
> > > > I guess flc_in_conflict is supposed to indicate "hey, we're already
> > > > doing a layout break on this inode". That seems reasonable, if a li=
ttle
> > > > klunky.
> > > >=20
> > > > It would be nice if you could track this flag inside of nfsd's data
> > > > structures instead (since only it cares about the flag), but I don'=
t
> > > > think it has any convenient per-inode structures to set this in.
> > > Can we move this flag in to nfsd_file? set the flag there and clear
> > > the flag when fencing completed.
> > >=20
> > No, there can be several nfsd_file objects per inode. I think that'd be
> > hard to do.
>=20
> ok I see. Can we leave in_conflict flag there for now until we can come
> up with better solution?
>=20
> -Dai
>=20
> >=20
> > > > >    restart:
> > > > >    	fl =3D list_first_entry(&ctx->flc_lease, struct file_lease, c=
.flc_list);
> > > > >    	break_time =3D fl->fl_break_time;
> > > > > @@ -1693,6 +1717,9 @@ int __break_lease(struct inode *inode, unsi=
gned int flags)
> > > > >    	spin_unlock(&ctx->flc_lock);
> > > > >    	percpu_up_read(&file_rwsem);
> > > > >    	lease_dispose_list(&dispose);
> > > > > +	spin_lock(&ctx->flc_lock);
> > > > > +	ctx->flc_in_conflict =3D false;
> > > > > +	spin_unlock(&ctx->flc_lock);
> > > > >    free_lock:
> > > > >    	locks_free_lease(new_fl);
> > > > >    	return error;
> > > > > diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> > > > > index ad7af8cfcf1f..e7777d6ee8d0 100644
> > > > > --- a/fs/nfsd/nfs4layouts.c
> > > > > +++ b/fs/nfsd/nfs4layouts.c
> > > > > @@ -747,11 +747,9 @@ static bool
> > > > >    nfsd4_layout_lm_break(struct file_lease *fl)
> > > > >    {
> > > > >    	/*
> > > > > -	 * We don't want the locks code to timeout the lease for us;
> > > > > -	 * we'll remove it ourself if a layout isn't returned
> > > > > -	 * in time:
> > > > > +	 * Enforce break lease timeout to prevent NFSD
> > > > > +	 * thread from hanging in __break_lease.
> > > > >    	 */
> > > > > -	fl->fl_break_time =3D 0;
> > > > >    	nfsd4_recall_file_layout(fl->c.flc_owner);
> > > > >    	return false;
> > > > >    }
> > > > > @@ -782,10 +780,69 @@ nfsd4_layout_lm_open_conflict(struct file *=
filp, int arg)
> > > > >    	return 0;
> > > > >    }
> > > > >   =20
> > > > > +/**
> > > > > + * nfsd_layout_breaker_timedout - The layout recall has timed ou=
t.
> > > > Please fix this kdoc header.
> > > I noticed this too, will fix in v2.
> > >=20
> > > > > + * If the layout type supports fence operation then do it to sto=
p
> > > > > + * the client from accessing the block device.
> > > > > + *
> > > > > + * @fl: file to check
> > > > > + *
> > > > > + * Return value: None.
> > > > > + */
> > > > > +static void
> > > > > +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
> > > > > +{
> > > > > +	struct nfs4_layout_stateid *ls =3D fl->c.flc_owner;
> > > > > +	struct nfsd_file *nf;
> > > > > +	u32 type;
> > > > > +
> > > > > +	rcu_read_lock();
> > > > > +	nf =3D nfsd_file_get(ls->ls_file);
> > > > > +	rcu_read_unlock();
> > > > > +	if (!nf)
> > > > > +		return;
> > > > > +	type =3D ls->ls_layout_type;
> > > > > +	if (nfsd4_layout_ops[type]->fence_client)
> > > > > +		nfsd4_layout_ops[type]->fence_client(ls, nf);
> > > > > +	nfsd_file_put(nf);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * nfsd4_layout_lm_conflict - Handle multiple conflicts in the s=
ame file.
> > > > kdoc header is wrong here. This should be for nfsd4_layout_lm_retry=
().
> > > I noticed this too, will fix in v2. Kernel test robot also
> > > complains about this.
> > >=20
> > > > > + *
> > > > > + * This function is called from __break_lease when a conflict oc=
curs.
> > > > > + * For layout conflicts on the same file, each conflict triggers=
 a
> > > > > + * layout  recall. Only the thread handling the first conflict n=
eeds
> > > > > + * to remain in __break_lease to manage the timeout for these re=
calls;
> > > > > + * subsequent threads should not wait in __break_lease.
> > > > > + *
> > > > > + * This is done to prevent excessive nfsd threads from becoming =
tied up
> > > > > + * in __break_lease, which could hinder the server's ability to =
service
> > > > > + * incoming requests.
> > > > > + *
> > > > > + * Return true if thread should not wait in __break_lease else r=
eturn
> > > > > + * false.
> > > > > + */
> > > > > +static bool
> > > > > +nfsd4_layout_lm_retry(struct file_lease *fl,
> > > > > +				struct file_lock_context *ctx)
> > > > > +{
> > > > > +	struct svc_rqst *rqstp;
> > > > > +
> > > > > +	rqstp =3D nfsd_current_rqst();
> > > > > +	if (!rqstp)
> > > > > +		return false;
> > > > > +	if ((fl->c.flc_flags & FL_LAYOUT) && ctx->flc_in_conflict)
> > > > This should never be called for anything but a FL_LAYOUT lease, sin=
ce
> > > > you're only setting this in nfsd4_layouts_lm_ops.
> > > I will remove the check for FL_LAYOUT in v2.
> > >=20
> > > Thanks,
> > > -Dai
> > >=20
> > > > > +		return true;
> > > > > +	return false;
> > > > > +}
> > > > > +
> > > > >    static const struct lease_manager_operations nfsd4_layouts_lm_=
ops =3D {
> > > > >    	.lm_break		=3D nfsd4_layout_lm_break,
> > > > >    	.lm_change		=3D nfsd4_layout_lm_change,
> > > > >    	.lm_open_conflict	=3D nfsd4_layout_lm_open_conflict,
> > > > > +	.lm_breaker_timedout	=3D nfsd4_layout_lm_breaker_timedout,
> > > > > +	.lm_need_to_retry	=3D nfsd4_layout_lm_retry,
> > > > >    };
> > > > >   =20
> > > > >    int
> > > > > diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> > > > > index 2f5e5588ee07..6967af8b7fd2 100644
> > > > > --- a/include/linux/filelock.h
> > > > > +++ b/include/linux/filelock.h
> > > > > @@ -17,6 +17,7 @@
> > > > >    #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
> > > > >    #define FL_LAYOUT	2048	/* outstanding pNFS layout */
> > > > >    #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
> > > > > +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
> > > > >   =20
> > > > >    #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
> > > > >   =20
> > > > > @@ -50,6 +51,9 @@ struct lease_manager_operations {
> > > > >    	void (*lm_setup)(struct file_lease *, void **);
> > > > >    	bool (*lm_breaker_owns_lease)(struct file_lease *);
> > > > >    	int (*lm_open_conflict)(struct file *, int);
> > > > > +	void (*lm_breaker_timedout)(struct file_lease *fl);
> > > > > +	bool (*lm_need_to_retry)(struct file_lease *fl,
> > > > > +			struct file_lock_context *ctx);
> > > > >    };
> > > > >   =20
> > > > >    struct lock_manager {
> > > > > @@ -145,6 +149,9 @@ struct file_lock_context {
> > > > >    	struct list_head	flc_flock;
> > > > >    	struct list_head	flc_posix;
> > > > >    	struct list_head	flc_lease;
> > > > > +
> > > > > +	/* for FL_LAYOUT */
> > > > > +	bool			flc_in_conflict;
> > > > >    };
> > > > >   =20
> > > > >    #ifdef CONFIG_FILE_LOCKING

--=20
Jeff Layton <jlayton@kernel.org>

