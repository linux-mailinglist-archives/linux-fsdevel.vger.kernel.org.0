Return-Path: <linux-fsdevel+bounces-9924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8584638C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAD71F21CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167C945BF8;
	Thu,  1 Feb 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HseYU/9y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1aIpF+ry";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HseYU/9y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1aIpF+ry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10C146433;
	Thu,  1 Feb 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827265; cv=none; b=rLZ39GLoA0r5XD2jTFmTjcUU1+zLeg//aH//z/nF0baZdG3HJ9qFzq6++UFOgiCrhgbabQMQCWmc8Edq3F8s7RhQJmPv67c7DUatvCbW97Qqb6QH/ezUCHhRNYZ1CuTFN4/4Kgx8duUBypEh6nm0HDEN5ZACghrinCK4k0+YS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827265; c=relaxed/simple;
	bh=ClXxASaUXULeBT50w0Vf/sBziLK5cvYxSZVFbclqnIc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iGOchm95uiMKUNx7kbP0Z9tnY1thET0x64ySqO9v0DJg+4YhzLQmCP5OLF5ANsidbxlPfKobBD5z3c2E/Qzm4Og1RUzlPqCzqUNn5mD8N6kYai///LhZGdiIsY8onov5FuCXADXzj8OEp4CNOCjyh/6IyRoBBZrhNWVKgNcbBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HseYU/9y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1aIpF+ry; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HseYU/9y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1aIpF+ry; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 216C122001;
	Thu,  1 Feb 2024 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706827260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiJObclcCMnM9QZ8HHJMdbnAJV5wDWetH4VIIW+wgBE=;
	b=HseYU/9yW865inWvIqKbUpcllx6Q7w25a6jpqdXbN9cKZ3dYrKFeMkGdu3bOjW1ZFu2zM+
	yOBkWiISifXqy0fBGyPIYb4syPjz31uK50gyYiNsOfP1TrRWV6KtO/FSyQLor46z/U92Ta
	mxJAkzde9D6+376AYZ+VHTJB24Nj9m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706827260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiJObclcCMnM9QZ8HHJMdbnAJV5wDWetH4VIIW+wgBE=;
	b=1aIpF+ryzIpa+iFw09BDLtid6Ijh17AB3AvTnRO9tpMhY4y6Hz4QvqTnlyi1WRmpY5iWTL
	waSyK/o6B3XPoQBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706827260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiJObclcCMnM9QZ8HHJMdbnAJV5wDWetH4VIIW+wgBE=;
	b=HseYU/9yW865inWvIqKbUpcllx6Q7w25a6jpqdXbN9cKZ3dYrKFeMkGdu3bOjW1ZFu2zM+
	yOBkWiISifXqy0fBGyPIYb4syPjz31uK50gyYiNsOfP1TrRWV6KtO/FSyQLor46z/U92Ta
	mxJAkzde9D6+376AYZ+VHTJB24Nj9m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706827260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiJObclcCMnM9QZ8HHJMdbnAJV5wDWetH4VIIW+wgBE=;
	b=1aIpF+ryzIpa+iFw09BDLtid6Ijh17AB3AvTnRO9tpMhY4y6Hz4QvqTnlyi1WRmpY5iWTL
	waSyK/o6B3XPoQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DC3113672;
	Thu,  1 Feb 2024 22:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 947/Ae8dvGXOaQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 01 Feb 2024 22:40:47 +0000
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
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Alexander Aring" <aahringo@redhat.com>,
 "David Teigland" <teigland@redhat.com>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, "Mark Fasheh" <mark@fasheh.com>,
 "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.com>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v3 34/47] 9p: adapt to breakup of struct file_lock
In-reply-to: <20240131-flsplit-v3-34-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>,
 <20240131-flsplit-v3-34-c6129007ee8d@kernel.org>
Date: Fri, 02 Feb 2024 09:40:44 +1100
Message-id: <170682724439.13976.1445220862078988301@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="HseYU/9y";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1aIpF+ry
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 R_RATELIMIT(0.00)[to_ip_from(RLouahofup1mwqksbidco3ksry)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[45];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[goodmis.org,kernel.org,efficios.com,oracle.com,zeniv.linux.org.uk,suse.cz,ionkov.net,codewreck.org,crudebyte.com,redhat.com,auristor.com,gmail.com,netapp.com,talpey.com,hammerspace.com,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,manguebit.com,microsoft.com,chromium.org,szeredi.hu,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 216C122001
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Thu, 01 Feb 2024, Jeff Layton wrote:
> Most of the existing APIs have remained the same, but subsystems that
> access file_lock fields directly need to reach into struct
> file_lock_core now.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/9p/vfs_file.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index a1dabcf73380..abdbbaee5184 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -9,7 +9,6 @@
>  #include <linux/module.h>
>  #include <linux/errno.h>
>  #include <linux/fs.h>
> -#define _NEED_FILE_LOCK_FIELD_MACROS
>  #include <linux/filelock.h>
>  #include <linux/sched.h>
>  #include <linux/file.h>
> @@ -108,7 +107,7 @@ static int v9fs_file_lock(struct file *filp, int cmd, s=
truct file_lock *fl)
> =20
>  	p9_debug(P9_DEBUG_VFS, "filp: %p lock: %p\n", filp, fl);
> =20
> -	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type !=3D F_UNLCK) {
> +	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->c.flc_type !=3D F_UNLCK) {

Should this have already been changed to lock_is_unlock() ???

NeilBrown


>  		filemap_write_and_wait(inode->i_mapping);
>  		invalidate_mapping_pages(&inode->i_data, 0, -1);
>  	}
> @@ -127,7 +126,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd=
, struct file_lock *fl)
>  	fid =3D filp->private_data;
>  	BUG_ON(fid =3D=3D NULL);
> =20
> -	BUG_ON((fl->fl_flags & FL_POSIX) !=3D FL_POSIX);
> +	BUG_ON((fl->c.flc_flags & FL_POSIX) !=3D FL_POSIX);
> =20
>  	res =3D locks_lock_file_wait(filp, fl);
>  	if (res < 0)
> @@ -136,7 +135,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd=
, struct file_lock *fl)
>  	/* convert posix lock to p9 tlock args */
>  	memset(&flock, 0, sizeof(flock));
>  	/* map the lock type */
> -	switch (fl->fl_type) {
> +	switch (fl->c.flc_type) {
>  	case F_RDLCK:
>  		flock.type =3D P9_LOCK_TYPE_RDLCK;
>  		break;
> @@ -152,7 +151,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd=
, struct file_lock *fl)
>  		flock.length =3D 0;
>  	else
>  		flock.length =3D fl->fl_end - fl->fl_start + 1;
> -	flock.proc_id =3D fl->fl_pid;
> +	flock.proc_id =3D fl->c.flc_pid;
>  	flock.client_id =3D fid->clnt->name;
>  	if (IS_SETLKW(cmd))
>  		flock.flags =3D P9_LOCK_FLAGS_BLOCK;
> @@ -207,13 +206,13 @@ static int v9fs_file_do_lock(struct file *filp, int c=
md, struct file_lock *fl)
>  	 * incase server returned error for lock request, revert
>  	 * it locally
>  	 */
> -	if (res < 0 && fl->fl_type !=3D F_UNLCK) {
> -		unsigned char type =3D fl->fl_type;
> +	if (res < 0 && fl->c.flc_type !=3D F_UNLCK) {
> +		unsigned char type =3D fl->c.flc_type;
> =20
> -		fl->fl_type =3D F_UNLCK;
> +		fl->c.flc_type =3D F_UNLCK;
>  		/* Even if this fails we want to return the remote error */
>  		locks_lock_file_wait(filp, fl);
> -		fl->fl_type =3D type;
> +		fl->c.flc_type =3D type;
>  	}
>  	if (flock.client_id !=3D fid->clnt->name)
>  		kfree(flock.client_id);
> @@ -235,7 +234,7 @@ static int v9fs_file_getlock(struct file *filp, struct =
file_lock *fl)
>  	 * if we have a conflicting lock locally, no need to validate
>  	 * with server
>  	 */
> -	if (fl->fl_type !=3D F_UNLCK)
> +	if (fl->c.flc_type !=3D F_UNLCK)
>  		return res;
> =20
>  	/* convert posix lock to p9 tgetlock args */
> @@ -246,7 +245,7 @@ static int v9fs_file_getlock(struct file *filp, struct =
file_lock *fl)
>  		glock.length =3D 0;
>  	else
>  		glock.length =3D fl->fl_end - fl->fl_start + 1;
> -	glock.proc_id =3D fl->fl_pid;
> +	glock.proc_id =3D fl->c.flc_pid;
>  	glock.client_id =3D fid->clnt->name;
> =20
>  	res =3D p9_client_getlock_dotl(fid, &glock);
> @@ -255,13 +254,13 @@ static int v9fs_file_getlock(struct file *filp, struc=
t file_lock *fl)
>  	/* map 9p lock type to os lock type */
>  	switch (glock.type) {
>  	case P9_LOCK_TYPE_RDLCK:
> -		fl->fl_type =3D F_RDLCK;
> +		fl->c.flc_type =3D F_RDLCK;
>  		break;
>  	case P9_LOCK_TYPE_WRLCK:
> -		fl->fl_type =3D F_WRLCK;
> +		fl->c.flc_type =3D F_WRLCK;
>  		break;
>  	case P9_LOCK_TYPE_UNLCK:
> -		fl->fl_type =3D F_UNLCK;
> +		fl->c.flc_type =3D F_UNLCK;
>  		break;
>  	}
>  	if (glock.type !=3D P9_LOCK_TYPE_UNLCK) {
> @@ -270,7 +269,7 @@ static int v9fs_file_getlock(struct file *filp, struct =
file_lock *fl)
>  			fl->fl_end =3D OFFSET_MAX;
>  		else
>  			fl->fl_end =3D glock.start + glock.length - 1;
> -		fl->fl_pid =3D -glock.proc_id;
> +		fl->c.flc_pid =3D -glock.proc_id;
>  	}
>  out:
>  	if (glock.client_id !=3D fid->clnt->name)
> @@ -294,7 +293,7 @@ static int v9fs_file_lock_dotl(struct file *filp, int c=
md, struct file_lock *fl)
>  	p9_debug(P9_DEBUG_VFS, "filp: %p cmd:%d lock: %p name: %pD\n",
>  		 filp, cmd, fl, filp);
> =20
> -	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type !=3D F_UNLCK) {
> +	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->c.flc_type !=3D F_UNLCK) {
>  		filemap_write_and_wait(inode->i_mapping);
>  		invalidate_mapping_pages(&inode->i_data, 0, -1);
>  	}
> @@ -325,16 +324,16 @@ static int v9fs_file_flock_dotl(struct file *filp, in=
t cmd,
>  	p9_debug(P9_DEBUG_VFS, "filp: %p cmd:%d lock: %p name: %pD\n",
>  		 filp, cmd, fl, filp);
> =20
> -	if (!(fl->fl_flags & FL_FLOCK))
> +	if (!(fl->c.flc_flags & FL_FLOCK))
>  		goto out_err;
> =20
> -	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type !=3D F_UNLCK) {
> +	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->c.flc_type !=3D F_UNLCK) {
>  		filemap_write_and_wait(inode->i_mapping);
>  		invalidate_mapping_pages(&inode->i_data, 0, -1);
>  	}
>  	/* Convert flock to posix lock */
> -	fl->fl_flags |=3D FL_POSIX;
> -	fl->fl_flags ^=3D FL_FLOCK;
> +	fl->c.flc_flags |=3D FL_POSIX;
> +	fl->c.flc_flags ^=3D FL_FLOCK;
> =20
>  	if (IS_SETLK(cmd) | IS_SETLKW(cmd))
>  		ret =3D v9fs_file_do_lock(filp, cmd, fl);
>=20
> --=20
> 2.43.0
>=20
>=20


