Return-Path: <linux-fsdevel+bounces-8125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A67F82FD30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C73B2615F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 22:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D79D25555;
	Tue, 16 Jan 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AWywaz28";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XiSUPO+1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AWywaz28";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XiSUPO+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA62511E;
	Tue, 16 Jan 2024 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444394; cv=none; b=Kzsiig+LWJIOGLAeChD5uuR/4kCqHU+1rvFlkR3lLLXVtqcK4XXxmpow9EGua5BOVXksq6/nD3uNOZ34vYmYMXl7qSuxxqqXVHSRF8cAkhVLktcYNxtEI4q2abzZjSTCNew1+MsHYFOh1DJz2b20SCxWOzI5GVNtJyFbx/kMis8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444394; c=relaxed/simple;
	bh=LzNuWUOWuxjPgwDQMFFg4cjWKtlDIzeGXgODOBthCKM=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From:To:Cc:Subject:
	 In-reply-to:References:Date:Message-id:X-Spam-Level:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:
	 X-Spam-Flag; b=Tdq3SOhOS9kkuoNVm12/7LNRxTkapyFCj88fIJCPJ2jrSrXxs+UDtA2fQgO28VAemnTvYXisYyuIcaICDscHs3257XwiQHgf4EkBuvzlBfgq706aPqgOmqlA3xGOUS0g2qbzv8vcI2R+D2yqgLp1SqxxS7hA1mN4S3jF6jVRQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AWywaz28; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XiSUPO+1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AWywaz28; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XiSUPO+1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CA3821FD4;
	Tue, 16 Jan 2024 22:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705444391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=morGpJZ/UOKteyeelSkyoCIsz8Np/wPiujALoK37mzo=;
	b=AWywaz28NKcr3/npizIsBc1e0ET3qBjK+FSAwoTPm7ZE0tzyPlWDQuiBH/VlPI133EAX+2
	+0U9a/+MLNzQXKs2BZaISBFRYcHJKthRODmK0UtHpl5srj/HSeESxFhp4SipFfPxbzq+2K
	uUQdov38gw20P4WsAyIJ9giDBzd5/kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705444391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=morGpJZ/UOKteyeelSkyoCIsz8Np/wPiujALoK37mzo=;
	b=XiSUPO+1K92nRkFceNawKLQaVGvE+77HjCafXAmo/SzKBuuMCz17JzTtobJRNYtluXVqxZ
	FEr0h3FJR4yHD2DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705444391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=morGpJZ/UOKteyeelSkyoCIsz8Np/wPiujALoK37mzo=;
	b=AWywaz28NKcr3/npizIsBc1e0ET3qBjK+FSAwoTPm7ZE0tzyPlWDQuiBH/VlPI133EAX+2
	+0U9a/+MLNzQXKs2BZaISBFRYcHJKthRODmK0UtHpl5srj/HSeESxFhp4SipFfPxbzq+2K
	uUQdov38gw20P4WsAyIJ9giDBzd5/kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705444391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=morGpJZ/UOKteyeelSkyoCIsz8Np/wPiujALoK37mzo=;
	b=XiSUPO+1K92nRkFceNawKLQaVGvE+77HjCafXAmo/SzKBuuMCz17JzTtobJRNYtluXVqxZ
	FEr0h3FJR4yHD2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8BA813751;
	Tue, 16 Jan 2024 22:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wegRFxkEp2UnfgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Jan 2024 22:32:57 +0000
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
Subject: Re: [PATCH 13/20] filelock: convert __locks_insert_block, conflict
 and deadlock checks to use file_lock_core
In-reply-to: <20240116-flsplit-v1-13-c9d0f4370a5d@kernel.org>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>,
 <20240116-flsplit-v1-13-c9d0f4370a5d@kernel.org>
Date: Wed, 17 Jan 2024 09:32:54 +1100
Message-id: <170544437475.23031.9738852723187400936@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AWywaz28;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XiSUPO+1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLouahofup1mwqksbidco3ksry)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[46];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,ionkov.net,codewreck.org,crudebyte.com,redhat.com,auristor.com,gmail.com,szeredi.hu,hammerspace.com,oracle.com,netapp.com,talpey.com,suse.cz,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,manguebit.com,microsoft.com,chromium.org,goodmis.org,efficios.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,lists.samba.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.86)[99.40%]
X-Spam-Score: -4.37
X-Rspamd-Queue-Id: 0CA3821FD4
X-Spam-Flag: NO

On Wed, 17 Jan 2024, Jeff Layton wrote:
> Have both __locks_insert_block and the deadlock and conflict checking
> functions take a struct file_lock_core pointer instead of a struct
> file_lock one. Also, change posix_locks_deadlock to return bool.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c | 132 ++++++++++++++++++++++++++++++++-------------------------=
----
>  1 file changed, 70 insertions(+), 62 deletions(-)
>=20


> =20
>  /* Must be called with the blocked_lock_lock held! */
> -static int posix_locks_deadlock(struct file_lock *caller_fl,
> -				struct file_lock *block_fl)
> +static bool posix_locks_deadlock(struct file_lock *caller_fl,
> +				 struct file_lock *block_fl)
>  {
> +	struct file_lock_core *caller =3D &caller_fl->fl_core;
> +	struct file_lock_core *blocker =3D &block_fl->fl_core;
>  	int i =3D 0;
> -	struct file_lock_core *flc =3D &caller_fl->fl_core;
> =20
>  	lockdep_assert_held(&blocked_lock_lock);
> =20
> @@ -1034,16 +1040,16 @@ static int posix_locks_deadlock(struct file_lock *c=
aller_fl,
>  	 * This deadlock detector can't reasonably detect deadlocks with
>  	 * FL_OFDLCK locks, since they aren't owned by a process, per-se.
>  	 */
> -	if (IS_OFDLCK(flc))
> +	if (IS_OFDLCK(caller))
>  		return 0;

      return false;

Thanks,
NeilBrown

