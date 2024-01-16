Return-Path: <linux-fsdevel+bounces-8123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C382FD0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 23:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF1E1F2F238
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 22:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA7219EA;
	Tue, 16 Jan 2024 22:17:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1F1EB53;
	Tue, 16 Jan 2024 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443441; cv=none; b=E7UVpWekq3f8aXurlkm/A671T+7ViRBkTCrpQLi3Wjsbeqa1G6OQSTmbZ5KM6AsFl8Ihd3tR3vrt1KK+TyVCKmMozOYukUWgZLSKnlBBvvI/dWDV/e1MMy5aOor3MNZnqB2oFX5cLcYxvOAkRWttRZXGX+GdwiHf7PZ+9nbJzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443441; c=relaxed/simple;
	bh=c9fNxQOO0OpCqCDvyOc4cQBH2+/Y/B7I7wB7BdxBEPg=;
	h=Received:Received:Received:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:To:Cc:Subject:In-reply-to:References:Date:
	 Message-id:X-Spam-Level:X-Rspamd-Server:X-Spamd-Result:
	 X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=X8ZUwfICVWMg9BB0Z7YrkygIq7QWPW7+nTskNWT9JqEeaNHkult29MaoMT2n+SDDMINWLTElLlMkMWMFQUJfwtFwv0uGa85QLga0TXTizINUW6JqFDxmMmjigbFX+BXAd8oxY+8xezaLO/ozb/9+xznoaGfSDconcTn7Y3kIbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5484A221D7;
	Tue, 16 Jan 2024 22:17:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4DE713751;
	Tue, 16 Jan 2024 22:17:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3eSDHl8Ap2XCegAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Jan 2024 22:17:03 +0000
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
Subject:
 Re: [PATCH 11/20] filelock: convert the IS_* macros to take file_lock_core
In-reply-to: <20240116-flsplit-v1-11-c9d0f4370a5d@kernel.org>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>,
 <20240116-flsplit-v1-11-c9d0f4370a5d@kernel.org>
Date: Wed, 17 Jan 2024 09:16:56 +1100
Message-id: <170544341684.23031.11038222640477022046@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 5484A221D7
X-Spam-Flag: NO

On Wed, 17 Jan 2024, Jeff Layton wrote:
> I couldn't get them to work properly as macros, so convert them
> to static inlines instead (which is probably better for the type safety
> anyway).
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c | 46 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 770aaa5809ba..eddf4d767d5d 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -70,10 +70,26 @@
> =20
>  #include <linux/uaccess.h>
> =20
> -#define IS_POSIX(fl)	(fl->fl_core.fl_flags & FL_POSIX)
Used 3 times... once as
	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
Can an IS_POSIX lock also be IS_OFDLCK ??


> -#define IS_FLOCK(fl)	(fl->fl_core.fl_flags & FL_FLOCK)
Used once.

> -#define IS_LEASE(fl)	(fl->fl_core.fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
Used twice.  Either "IS_LEASE" approves things that aren't leases, or
FL_LEASE is not set on all leases.... Names could be improved.

> -#define IS_OFDLCK(fl)	(fl->fl_core.fl_flags & FL_OFDLCK)

used 4 times - a clear winner :-)

If it would me, I would simply discard these macros and open-code the
tests.  I don't think IS_FLOCK() is easier to read for someone who knows
the code, and I think IS_LEASE() is actually harder to read for someone
who doesn't know the code, as that it does it not really obvious.

But this is just a suggestion, I won't push it.

Thanks,
NeilBrown


> +static inline bool IS_POSIX(struct file_lock_core *flc)
> +{
> +	return flc->fl_flags & FL_POSIX;
> +}
> +
> +static inline bool IS_FLOCK(struct file_lock_core *flc)
> +{
> +	return flc->fl_flags & FL_FLOCK;
> +}
> +
> +static inline bool IS_OFDLCK(struct file_lock_core *flc)
> +{
> +	return flc->fl_flags & FL_OFDLCK;
> +}
> +
> +static inline bool IS_LEASE(struct file_lock_core *flc)
> +{
> +	return flc->fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT);
> +}
> +
>  #define IS_REMOTELCK(fl)	(fl->fl_core.fl_pid <=3D 0)
> =20
>  static bool lease_breaking(struct file_lock *fl)
> @@ -761,6 +777,7 @@ static void __locks_insert_block(struct file_lock *bloc=
ker,
>  					       struct file_lock *))
>  {
>  	struct file_lock *fl;
> +	struct file_lock_core *bflc;
>  	BUG_ON(!list_empty(&waiter->fl_core.fl_blocked_member));
> =20
>  new_blocker:
> @@ -773,7 +790,9 @@ static void __locks_insert_block(struct file_lock *bloc=
ker,
>  	waiter->fl_core.fl_blocker =3D blocker;
>  	list_add_tail(&waiter->fl_core.fl_blocked_member,
>  		      &blocker->fl_core.fl_blocked_requests);
> -	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
> +
> +	bflc =3D &blocker->fl_core;
> +	if (IS_POSIX(bflc) && !IS_OFDLCK(bflc))
>  		locks_insert_global_blocked(&waiter->fl_core);
> =20
>  	/* The requests in waiter->fl_blocked are known to conflict with
> @@ -998,6 +1017,7 @@ static int posix_locks_deadlock(struct file_lock *call=
er_fl,
>  				struct file_lock *block_fl)
>  {
>  	int i =3D 0;
> +	struct file_lock_core *flc =3D &caller_fl->fl_core;
> =20
>  	lockdep_assert_held(&blocked_lock_lock);
> =20
> @@ -1005,7 +1025,7 @@ static int posix_locks_deadlock(struct file_lock *cal=
ler_fl,
>  	 * This deadlock detector can't reasonably detect deadlocks with
>  	 * FL_OFDLCK locks, since they aren't owned by a process, per-se.
>  	 */
> -	if (IS_OFDLCK(caller_fl))
> +	if (IS_OFDLCK(flc))
>  		return 0;
> =20
>  	while ((block_fl =3D what_owner_is_waiting_for(block_fl))) {
> @@ -2157,7 +2177,7 @@ static pid_t locks_translate_pid(struct file_lock *fl=
, struct pid_namespace *ns)
>  	pid_t vnr;
>  	struct pid *pid;
> =20
> -	if (IS_OFDLCK(fl))
> +	if (IS_OFDLCK(&fl->fl_core))
>  		return -1;
>  	if (IS_REMOTELCK(fl))
>  		return fl->fl_core.fl_pid;
> @@ -2721,19 +2741,19 @@ static void lock_get_status(struct seq_file *f, str=
uct file_lock *fl,
>  	if (repeat)
>  		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
> =20
> -	if (IS_POSIX(fl)) {
> +	if (IS_POSIX(&fl->fl_core)) {
>  		if (fl->fl_core.fl_flags & FL_ACCESS)
>  			seq_puts(f, "ACCESS");
> -		else if (IS_OFDLCK(fl))
> +		else if (IS_OFDLCK(&fl->fl_core))
>  			seq_puts(f, "OFDLCK");
>  		else
>  			seq_puts(f, "POSIX ");
> =20
>  		seq_printf(f, " %s ",
>  			     (inode =3D=3D NULL) ? "*NOINODE*" : "ADVISORY ");
> -	} else if (IS_FLOCK(fl)) {
> +	} else if (IS_FLOCK(&fl->fl_core)) {
>  		seq_puts(f, "FLOCK  ADVISORY  ");
> -	} else if (IS_LEASE(fl)) {
> +	} else if (IS_LEASE(&fl->fl_core)) {
>  		if (fl->fl_core.fl_flags & FL_DELEG)
>  			seq_puts(f, "DELEG  ");
>  		else
> @@ -2748,7 +2768,7 @@ static void lock_get_status(struct seq_file *f, struc=
t file_lock *fl,
>  	} else {
>  		seq_puts(f, "UNKNOWN UNKNOWN  ");
>  	}
> -	type =3D IS_LEASE(fl) ? target_leasetype(fl) : fl->fl_core.fl_type;
> +	type =3D IS_LEASE(&fl->fl_core) ? target_leasetype(fl) : fl->fl_core.fl_t=
ype;
> =20
>  	seq_printf(f, "%s ", (type =3D=3D F_WRLCK) ? "WRITE" :
>  			     (type =3D=3D F_RDLCK) ? "READ" : "UNLCK");
> @@ -2760,7 +2780,7 @@ static void lock_get_status(struct seq_file *f, struc=
t file_lock *fl,
>  	} else {
>  		seq_printf(f, "%d <none>:0 ", fl_pid);
>  	}
> -	if (IS_POSIX(fl)) {
> +	if (IS_POSIX(&fl->fl_core)) {
>  		if (fl->fl_end =3D=3D OFFSET_MAX)
>  			seq_printf(f, "%Ld EOF\n", fl->fl_start);
>  		else
>=20
> --=20
> 2.43.0
>=20
>=20


