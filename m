Return-Path: <linux-fsdevel+bounces-11951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050938596DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 13:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D551F20C71
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031FD63CAE;
	Sun, 18 Feb 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjUBRhd2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F314D11D;
	Sun, 18 Feb 2024 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708258600; cv=none; b=S2DQKW8v/l7evmuXEvn8XHdOMFFw31sGpUOazUgKvJGlArEkKl2t+OO+aFZFt8t1+0wiffSlbmb3VVp6I6LubVsffNke1wYX8xxEbrfJ6wQQ20lLG3Chlnn2yyWgE2xlgTNsMcBQRf4J0nfTXQMgv+nASWV/hUX+uWIDItf7zJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708258600; c=relaxed/simple;
	bh=qeYHnSm+eCC5U6ZzaS+5bdNQA8SxoY1Yxw7k7BI5YWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppcX8V8At8MKjHVlV3RP++CnLDFr8IPXzZDXLKYpMuYrUEFfT6cKt22Tl8F60sSozgP7gzqh6qmU//g1GJlYtI17pZB+Hy+rQhSAkRlFXYfzevPdj6e/CC9PbHtvY1zCY/EGo5AQqYAXzIE18kgPfNnsTCukVEkoErj1soWFrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjUBRhd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA82AC433F1;
	Sun, 18 Feb 2024 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708258599;
	bh=qeYHnSm+eCC5U6ZzaS+5bdNQA8SxoY1Yxw7k7BI5YWU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QjUBRhd2xkoBr4RRVHQ4141A3Q0SAJjtXEWQtdi7smFsE+WHP0K72KBiX7ZzHlg1Y
	 FN9TY0uOk5zgswpUqziUjuRKd+UBHc/MpUQ89y9X0M6JutPHx2Px/MJNfyngIkys0h
	 2uxl7GgmYpWuh5d69xWKp9tjpjXuYGpiHsGpefiKlKjOljQHv/hwOkfw8ZYE9D5d3J
	 NeDdnYt6lgHWooAsRSGDVSVW+g6ppPh2nUCVLKrhlKQ33ayLKQdK4dQBEV+gL1ggfJ
	 ashRdcTcsAWFhYu9cxKiZjQPYxsXJpzQLfoiwjyg0KJG2Cv3GZAc8N2qLUlgJE8L8E
	 UPmKlB6dTO9pg==
Message-ID: <fb748c596936651a6b42781653f0ca29dc45fb5b.camel@kernel.org>
Subject: Re: [PATCH v3 25/47] filelock: convert __locks_insert_block,
 conflict and deadlock checks to use file_lock_core
From: Jeff Layton <jlayton@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Chuck Lever <chuck.lever@oracle.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian
 Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>, Ilya
 Dryomov <idryomov@gmail.com>, Alexander Aring <aahringo@redhat.com>, David
 Teigland <teigland@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Mark
 Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Steve French <sfrench@samba.org>, Paulo
 Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon
 <linkinjeon@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
 gfs2@lists.linux.dev,  linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev,  linux-cifs@vger.kernel.org
Date: Sun, 18 Feb 2024 07:16:34 -0500
In-Reply-To: <20240131-flsplit-v3-25-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
	 <20240131-flsplit-v3-25-c6129007ee8d@kernel.org>
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

On Wed, 2024-01-31 at 18:02 -0500, Jeff Layton wrote:
> Have both __locks_insert_block and the deadlock and conflict checking
> functions take a struct file_lock_core pointer instead of a struct
> file_lock one. Also, change posix_locks_deadlock to return bool.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c | 132 +++++++++++++++++++++++++++++++++----------------------=
------
>  1 file changed, 72 insertions(+), 60 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 1e8b943bd7f9..0dc1c9da858c 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -757,39 +757,41 @@ EXPORT_SYMBOL(locks_delete_block);
>   * waiters, and add beneath any waiter that blocks the new waiter.
>   * Thus wakeups don't happen until needed.
>   */
> -static void __locks_insert_block(struct file_lock *blocker,
> -				 struct file_lock *waiter,
> -				 bool conflict(struct file_lock *,
> -					       struct file_lock *))
> +static void __locks_insert_block(struct file_lock *blocker_fl,
> +				 struct file_lock *waiter_fl,
> +				 bool conflict(struct file_lock_core *,
> +					       struct file_lock_core *))
>  {
> -	struct file_lock *fl;
> -	BUG_ON(!list_empty(&waiter->c.flc_blocked_member));
> +	struct file_lock_core *blocker =3D &blocker_fl->c;
> +	struct file_lock_core *waiter =3D &waiter_fl->c;
> +	struct file_lock_core *flc;
> =20
> +	BUG_ON(!list_empty(&waiter->flc_blocked_member));
>  new_blocker:
> -	list_for_each_entry(fl, &blocker->c.flc_blocked_requests,
> -			    c.flc_blocked_member)
> -		if (conflict(fl, waiter)) {
> -			blocker =3D  fl;
> +	list_for_each_entry(flc, &blocker->flc_blocked_requests, flc_blocked_me=
mber)
> +		if (conflict(flc, waiter)) {
> +			blocker =3D  flc;
>  			goto new_blocker;
>  		}
> -	waiter->c.flc_blocker =3D blocker;
> -	list_add_tail(&waiter->c.flc_blocked_member,
> -		      &blocker->c.flc_blocked_requests);
> -	if ((blocker->c.flc_flags & (FL_POSIX|FL_OFDLCK)) =3D=3D FL_POSIX)
> -		locks_insert_global_blocked(&waiter->c);
> +	waiter->flc_blocker =3D file_lock(blocker);
> +	list_add_tail(&waiter->flc_blocked_member,
> +		      &blocker->flc_blocked_requests);
> =20
> -	/* The requests in waiter->fl_blocked are known to conflict with
> +	if ((blocker->flc_flags & (FL_POSIX|FL_OFDLCK)) =3D=3D (FL_POSIX|FL_OFD=
LCK))

Christian,

There is a bug in the above delta. That should read:

    if ((blocker->flc_flags & (FL_POSIX|FL_OFDLCK)) =3D=3D FL_POSIX)

I suspect that is the cause of the performance regression noted by the
KTR.

I believe the bug is fairly harmless -- it's just putting OFD locks into
the global hash when it doesn't need to, which probably slows down
deadlock checking. I'm going to spin up a patch and test it today, but I
wanted to give you a heads up.

I'll send the patch later today or tomorrow.
=20
> +		locks_insert_global_blocked(waiter);
> +
> +	/* The requests in waiter->flc_blocked are known to conflict with
>  	 * waiter, but might not conflict with blocker, or the requests
>  	 * and lock which block it.  So they all need to be woken.
>  	 */
> -	__locks_wake_up_blocks(&waiter->c);
> +	__locks_wake_up_blocks(waiter);
>  }
> =20
>  /* Must be called with flc_lock held. */
>  static void locks_insert_block(struct file_lock *blocker,
>  			       struct file_lock *waiter,
> -			       bool conflict(struct file_lock *,
> -					     struct file_lock *))
> +			       bool conflict(struct file_lock_core *,
> +					     struct file_lock_core *))
>  {
>  	spin_lock(&blocked_lock_lock);
>  	__locks_insert_block(blocker, waiter, conflict);
> @@ -846,12 +848,12 @@ locks_delete_lock_ctx(struct file_lock *fl, struct =
list_head *dispose)
>  /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
>   * checks for shared/exclusive status of overlapping locks.
>   */
> -static bool locks_conflict(struct file_lock *caller_fl,
> -			   struct file_lock *sys_fl)
> +static bool locks_conflict(struct file_lock_core *caller_flc,
> +			   struct file_lock_core *sys_flc)
>  {
> -	if (lock_is_write(sys_fl))
> +	if (sys_flc->flc_type =3D=3D F_WRLCK)
>  		return true;
> -	if (lock_is_write(caller_fl))
> +	if (caller_flc->flc_type =3D=3D F_WRLCK)
>  		return true;
>  	return false;
>  }
> @@ -859,20 +861,23 @@ static bool locks_conflict(struct file_lock *caller=
_fl,
>  /* Determine if lock sys_fl blocks lock caller_fl. POSIX specific
>   * checking before calling the locks_conflict().
>   */
> -static bool posix_locks_conflict(struct file_lock *caller_fl,
> -				 struct file_lock *sys_fl)
> +static bool posix_locks_conflict(struct file_lock_core *caller_flc,
> +				 struct file_lock_core *sys_flc)
>  {
> +	struct file_lock *caller_fl =3D file_lock(caller_flc);
> +	struct file_lock *sys_fl =3D file_lock(sys_flc);
> +
>  	/* POSIX locks owned by the same process do not conflict with
>  	 * each other.
>  	 */
> -	if (posix_same_owner(&caller_fl->c, &sys_fl->c))
> +	if (posix_same_owner(caller_flc, sys_flc))
>  		return false;
> =20
>  	/* Check whether they overlap */
>  	if (!locks_overlap(caller_fl, sys_fl))
>  		return false;
> =20
> -	return locks_conflict(caller_fl, sys_fl);
> +	return locks_conflict(caller_flc, sys_flc);
>  }
> =20
>  /* Determine if lock sys_fl blocks lock caller_fl. Used on xx_GETLK
> @@ -881,28 +886,31 @@ static bool posix_locks_conflict(struct file_lock *=
caller_fl,
>  static bool posix_test_locks_conflict(struct file_lock *caller_fl,
>  				      struct file_lock *sys_fl)
>  {
> +	struct file_lock_core *caller =3D &caller_fl->c;
> +	struct file_lock_core *sys =3D &sys_fl->c;
> +
>  	/* F_UNLCK checks any locks on the same fd. */
>  	if (lock_is_unlock(caller_fl)) {
> -		if (!posix_same_owner(&caller_fl->c, &sys_fl->c))
> +		if (!posix_same_owner(caller, sys))
>  			return false;
>  		return locks_overlap(caller_fl, sys_fl);
>  	}
> -	return posix_locks_conflict(caller_fl, sys_fl);
> +	return posix_locks_conflict(caller, sys);
>  }
> =20
>  /* Determine if lock sys_fl blocks lock caller_fl. FLOCK specific
>   * checking before calling the locks_conflict().
>   */
> -static bool flock_locks_conflict(struct file_lock *caller_fl,
> -				 struct file_lock *sys_fl)
> +static bool flock_locks_conflict(struct file_lock_core *caller_flc,
> +				 struct file_lock_core *sys_flc)
>  {
>  	/* FLOCK locks referring to the same filp do not conflict with
>  	 * each other.
>  	 */
> -	if (caller_fl->c.flc_file =3D=3D sys_fl->c.flc_file)
> +	if (caller_flc->flc_file =3D=3D sys_flc->flc_file)
>  		return false;
> =20
> -	return locks_conflict(caller_fl, sys_fl);
> +	return locks_conflict(caller_flc, sys_flc);
>  }
> =20
>  void
> @@ -980,25 +988,27 @@ EXPORT_SYMBOL(posix_test_lock);
> =20
>  #define MAX_DEADLK_ITERATIONS 10
> =20
> -/* Find a lock that the owner of the given block_fl is blocking on. */
> -static struct file_lock *what_owner_is_waiting_for(struct file_lock *blo=
ck_fl)
> +/* Find a lock that the owner of the given @blocker is blocking on. */
> +static struct file_lock_core *what_owner_is_waiting_for(struct file_lock=
_core *blocker)
>  {
> -	struct file_lock *fl;
> +	struct file_lock_core *flc;
> =20
> -	hash_for_each_possible(blocked_hash, fl, c.flc_link, posix_owner_key(&b=
lock_fl->c)) {
> -		if (posix_same_owner(&fl->c, &block_fl->c)) {
> -			while (fl->c.flc_blocker)
> -				fl =3D fl->c.flc_blocker;
> -			return fl;
> +	hash_for_each_possible(blocked_hash, flc, flc_link, posix_owner_key(blo=
cker)) {
> +		if (posix_same_owner(flc, blocker)) {
> +			while (flc->flc_blocker)
> +				flc =3D &flc->flc_blocker->c;
> +			return flc;
>  		}
>  	}
>  	return NULL;
>  }
> =20
>  /* Must be called with the blocked_lock_lock held! */
> -static int posix_locks_deadlock(struct file_lock *caller_fl,
> -				struct file_lock *block_fl)
> +static bool posix_locks_deadlock(struct file_lock *caller_fl,
> +				 struct file_lock *block_fl)
>  {
> +	struct file_lock_core *caller =3D &caller_fl->c;
> +	struct file_lock_core *blocker =3D &block_fl->c;
>  	int i =3D 0;
> =20
>  	lockdep_assert_held(&blocked_lock_lock);
> @@ -1007,16 +1017,16 @@ static int posix_locks_deadlock(struct file_lock =
*caller_fl,
>  	 * This deadlock detector can't reasonably detect deadlocks with
>  	 * FL_OFDLCK locks, since they aren't owned by a process, per-se.
>  	 */
> -	if (caller_fl->c.flc_flags & FL_OFDLCK)
> -		return 0;
> +	if (caller->flc_flags & FL_OFDLCK)
> +		return false;
> =20
> -	while ((block_fl =3D what_owner_is_waiting_for(block_fl))) {
> +	while ((blocker =3D what_owner_is_waiting_for(blocker))) {
>  		if (i++ > MAX_DEADLK_ITERATIONS)
> -			return 0;
> -		if (posix_same_owner(&caller_fl->c, &block_fl->c))
> -			return 1;
> +			return false;
> +		if (posix_same_owner(caller, blocker))
> +			return true;
>  	}
> -	return 0;
> +	return false;
>  }
> =20
>  /* Try to create a FLOCK lock on filp. We always insert new FLOCK locks
> @@ -1071,7 +1081,7 @@ static int flock_lock_inode(struct inode *inode, st=
ruct file_lock *request)
> =20
>  find_conflict:
>  	list_for_each_entry(fl, &ctx->flc_flock, c.flc_list) {
> -		if (!flock_locks_conflict(request, fl))
> +		if (!flock_locks_conflict(&request->c, &fl->c))
>  			continue;
>  		error =3D -EAGAIN;
>  		if (!(request->c.flc_flags & FL_SLEEP))
> @@ -1140,7 +1150,7 @@ static int posix_lock_inode(struct inode *inode, st=
ruct file_lock *request,
>  	 */
>  	if (request->c.flc_type !=3D F_UNLCK) {
>  		list_for_each_entry(fl, &ctx->flc_posix, c.flc_list) {
> -			if (!posix_locks_conflict(request, fl))
> +			if (!posix_locks_conflict(&request->c, &fl->c))
>  				continue;
>  			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
>  				&& (*fl->fl_lmops->lm_lock_expirable)(fl)) {
> @@ -1442,23 +1452,25 @@ static void time_out_leases(struct inode *inode, =
struct list_head *dispose)
>  	}
>  }
> =20
> -static bool leases_conflict(struct file_lock *lease, struct file_lock *b=
reaker)
> +static bool leases_conflict(struct file_lock_core *lc, struct file_lock_=
core *bc)
>  {
>  	bool rc;
> +	struct file_lock *lease =3D file_lock(lc);
> +	struct file_lock *breaker =3D file_lock(bc);
> =20
>  	if (lease->fl_lmops->lm_breaker_owns_lease
>  			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
>  		return false;
> -	if ((breaker->c.flc_flags & FL_LAYOUT) !=3D (lease->c.flc_flags & FL_LA=
YOUT)) {
> +	if ((bc->flc_flags & FL_LAYOUT) !=3D (lc->flc_flags & FL_LAYOUT)) {
>  		rc =3D false;
>  		goto trace;
>  	}
> -	if ((breaker->c.flc_flags & FL_DELEG) && (lease->c.flc_flags & FL_LEASE=
)) {
> +	if ((bc->flc_flags & FL_DELEG) && (lc->flc_flags & FL_LEASE)) {
>  		rc =3D false;
>  		goto trace;
>  	}
> =20
> -	rc =3D locks_conflict(breaker, lease);
> +	rc =3D locks_conflict(bc, lc);
>  trace:
>  	trace_leases_conflict(rc, lease, breaker);
>  	return rc;
> @@ -1468,12 +1480,12 @@ static bool
>  any_leases_conflict(struct inode *inode, struct file_lock *breaker)
>  {
>  	struct file_lock_context *ctx =3D inode->i_flctx;
> -	struct file_lock *fl;
> +	struct file_lock_core *flc;
> =20
>  	lockdep_assert_held(&ctx->flc_lock);
> =20
> -	list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
> -		if (leases_conflict(fl, breaker))
> +	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
> +		if (leases_conflict(flc, &breaker->c))
>  			return true;
>  	}
>  	return false;
> @@ -1529,7 +1541,7 @@ int __break_lease(struct inode *inode, unsigned int=
 mode, unsigned int type)
>  	}
> =20
>  	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
> -		if (!leases_conflict(fl, new_fl))
> +		if (!leases_conflict(&fl->c, &new_fl->c))
>  			continue;
>  		if (want_write) {
>  			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
>=20

--=20
Jeff Layton <jlayton@kernel.org>

