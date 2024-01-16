Return-Path: <linux-fsdevel+bounces-8124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5CC82FD1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 23:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D8E29342F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 22:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AA723747;
	Tue, 16 Jan 2024 22:23:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466C23744;
	Tue, 16 Jan 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443807; cv=none; b=qz/cTAAI4r/nUFJDyTVOSkfR14ztOuwd8QNL1nUFJs96BVGSrPE5d536ygmsIc3TNrltvjFSpxdCY2dE0JHBXPojYzUzZkWHEfACSWf/BM9pGFdFygCUHZQCIgfsXB7mgzq2LbJ3Nt0Lq9seML2RsHcfXtLuavVyk/JQQ2MUCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443807; c=relaxed/simple;
	bh=+9So/8C/UHwU34J+AJWGCIa/pW2jaEdlYaVwPROAc40=;
	h=Received:Received:Received:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:To:Cc:Subject:In-reply-to:References:Date:
	 Message-id:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=dlnlsl2pvH+zXrNgsBcGn3Gbl4Ddn2OEdJgB0WuEoCpUM+UAhGstUmpxmDJaSapYqbF6NXGh4tlcJTHhcSZHpqwFEDEurfgOSesQSNR4rwwbicBFZ2qMYn7sVnx+g916viP0qdSWlinhd0TFOwS/O9qScx/lpZ8onq16roTO6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CAC4A221E8;
	Tue, 16 Jan 2024 22:23:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2693A13751;
	Tue, 16 Jan 2024 22:23:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SEsoM80Bp2UZfAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Jan 2024 22:23:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Alexander Aring" <aahringo@redhat.com>,
 "David Teigland" <teigland@redhat.com>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Jan Kara" <jack@suse.cz>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.com>, "Ronnie Sahlberg" <lsahlber@redhat.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-trace-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 12/20] filelock: make __locks_delete_block and
 __locks_wake_up_blocks take file_lock_core
In-reply-to: <20240116-flsplit-v1-12-c9d0f4370a5d@kernel.org>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>,
 <20240116-flsplit-v1-12-c9d0f4370a5d@kernel.org>
Date: Wed, 17 Jan 2024 09:23:07 +1100
Message-id: <170544378717.23031.5597414508293858294@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CAC4A221E8
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, 17 Jan 2024, Jeff Layton wrote:
> Convert __locks_delete_block and __locks_wake_up_blocks to take a struct
> file_lock_core pointer. Note that to accomodate this, we need to add a
> new file_lock() wrapper to go from file_lock_core to file_lock.

Actually we don't need it.... see below.

>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index eddf4d767d5d..6b8e8820dec9 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -92,6 +92,11 @@ static inline bool IS_LEASE(struct file_lock_core *flc)
> =20
>  #define IS_REMOTELCK(fl)	(fl->fl_core.fl_pid <=3D 0)
> =20
> +struct file_lock *file_lock(struct file_lock_core *flc)
> +{
> +	return container_of(flc, struct file_lock, fl_core);
> +}
> +
>  static bool lease_breaking(struct file_lock *fl)
>  {
>  	return fl->fl_core.fl_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
> @@ -677,31 +682,35 @@ static void locks_delete_global_blocked(struct file_l=
ock_core *waiter)
>   *
>   * Must be called with blocked_lock_lock held.
>   */
> -static void __locks_delete_block(struct file_lock *waiter)
> +static void __locks_delete_block(struct file_lock_core *waiter)
>  {
> -	locks_delete_global_blocked(&waiter->fl_core);
> -	list_del_init(&waiter->fl_core.fl_blocked_member);
> +	locks_delete_global_blocked(waiter);
> +	list_del_init(&waiter->fl_blocked_member);
>  }
> =20
> -static void __locks_wake_up_blocks(struct file_lock *blocker)
> +static void __locks_wake_up_blocks(struct file_lock_core *blocker)
>  {
> -	while (!list_empty(&blocker->fl_core.fl_blocked_requests)) {
> -		struct file_lock *waiter;
> +	while (!list_empty(&blocker->fl_blocked_requests)) {
> +		struct file_lock_core *waiter;
> +		struct file_lock *fl;
> +
> +		waiter =3D list_first_entry(&blocker->fl_blocked_requests,
> +					  struct file_lock_core, fl_blocked_member);
> =20
> -		waiter =3D list_first_entry(&blocker->fl_core.fl_blocked_requests,
> -					  struct file_lock, fl_core.fl_blocked_member);

> +		fl =3D file_lock(waiter);

		fl =3D list_first_entry(&blocker->fl_core.fl_blocked_requests,
				      struct file_lock, fl_core.fl_blocked_member);

                waiter =3D &fl->fl_core;

achieves the same result without needing file_lock().

If you really want to add file_lock() then do so, but you need a better
justification :-)

NeilBrown



>  		__locks_delete_block(waiter);
> -		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
> -			waiter->fl_lmops->lm_notify(waiter);
> +		if ((IS_POSIX(waiter) || IS_FLOCK(waiter)) &&
> +		    fl->fl_lmops && fl->fl_lmops->lm_notify)
> +			fl->fl_lmops->lm_notify(fl);
>  		else
> -			wake_up(&waiter->fl_core.fl_wait);
> +			wake_up(&waiter->fl_wait);
> =20
>  		/*
>  		 * The setting of fl_blocker to NULL marks the "done"
>  		 * point in deleting a block. Paired with acquire at the top
>  		 * of locks_delete_block().
>  		 */
> -		smp_store_release(&waiter->fl_core.fl_blocker, NULL);
> +		smp_store_release(&waiter->fl_blocker, NULL);
>  	}
>  }
> =20
> @@ -743,8 +752,8 @@ int locks_delete_block(struct file_lock *waiter)
>  	spin_lock(&blocked_lock_lock);
>  	if (waiter->fl_core.fl_blocker)
>  		status =3D 0;
> -	__locks_wake_up_blocks(waiter);
> -	__locks_delete_block(waiter);
> +	__locks_wake_up_blocks(&waiter->fl_core);
> +	__locks_delete_block(&waiter->fl_core);
> =20
>  	/*
>  	 * The setting of fl_blocker to NULL marks the "done" point in deleting
> @@ -799,7 +808,7 @@ static void __locks_insert_block(struct file_lock *bloc=
ker,
>  	 * waiter, but might not conflict with blocker, or the requests
>  	 * and lock which block it.  So they all need to be woken.
>  	 */
> -	__locks_wake_up_blocks(waiter);
> +	__locks_wake_up_blocks(&waiter->fl_core);
>  }
> =20
>  /* Must be called with flc_lock held. */
> @@ -831,7 +840,7 @@ static void locks_wake_up_blocks(struct file_lock *bloc=
ker)
>  		return;
> =20
>  	spin_lock(&blocked_lock_lock);
> -	__locks_wake_up_blocks(blocker);
> +	__locks_wake_up_blocks(&blocker->fl_core);
>  	spin_unlock(&blocked_lock_lock);
>  }
> =20
> @@ -1186,7 +1195,7 @@ static int posix_lock_inode(struct inode *inode, stru=
ct file_lock *request,
>  			 * Ensure that we don't find any locks blocked on this
>  			 * request during deadlock detection.
>  			 */
> -			__locks_wake_up_blocks(request);
> +			__locks_wake_up_blocks(&request->fl_core);
>  			if (likely(!posix_locks_deadlock(request, fl))) {
>  				error =3D FILE_LOCK_DEFERRED;
>  				__locks_insert_block(fl, request,
>=20
> --=20
> 2.43.0
>=20
>=20


