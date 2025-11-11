Return-Path: <linux-fsdevel+bounces-67904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274BAC4D39B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C373A4AA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C94350D5F;
	Tue, 11 Nov 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="048Duv24";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pxjRMTfX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="048Duv24";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pxjRMTfX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53532350D52
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858173; cv=none; b=CkmAIGBVBAhw6qXgZpEpEMiWwbl54Ep8TsRBXJXgNJdfntQ9MjYAwbPwrCh6LQOxWoYu7Y077nOsjpqEWPb0VA582+t6m5GLQ40KdLGIr1tAaIAGgs6ojJ4zZxG1C7B9S1UWz/VrE/R98V+xDg6yMDOIudeaU591qEHqa6whRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858173; c=relaxed/simple;
	bh=QnrX/TwlWRahwxQuTR/tZGFBnLTfhK/PImeHFdSAbjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc+M5/JL7NJ2sL1IwbQEo1u8aQQUbc+FjEPUaRwhNyKUjZ9sFo5ra47ORurOHH+KAil5POzWwjidYSPjOWeE9CmZyA9vEWZ90EZbBtkdzci2YJK0GSmD6EdBVdogMm4F4+o4ZK/umgnWZUO2OVtw8zloLlBNiuU4C4/ETsatnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=048Duv24; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pxjRMTfX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=048Duv24; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pxjRMTfX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE4751F790;
	Tue, 11 Nov 2025 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762858168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkJQ+ETHMLX8gaociQ/ZH4e9YkkTx1BYT1F+DHiUNow=;
	b=048Duv24jecDa2dlRX/r4T68dJo/Q1HZM6/bFhJcik5peshmjaYc5a6cz7ijm0CHJBlC+1
	Nqkcs4oNsAsUZ/7YwQ/BoizzVYPNZhm7pWFegg7mtXkt4VC4hO08pkJlUbTTQbBrak61yb
	3nfEtOGq2e/tF3lKT4RtbNvnIyX+F4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762858168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkJQ+ETHMLX8gaociQ/ZH4e9YkkTx1BYT1F+DHiUNow=;
	b=pxjRMTfX6kH3ijVgNX4+D7CfwQqIa0aJAtKl6cNDjcZOJTtdTt3PR653T1tMeG8lvmlwI6
	lKgj7ADcTdiZRGCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762858168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkJQ+ETHMLX8gaociQ/ZH4e9YkkTx1BYT1F+DHiUNow=;
	b=048Duv24jecDa2dlRX/r4T68dJo/Q1HZM6/bFhJcik5peshmjaYc5a6cz7ijm0CHJBlC+1
	Nqkcs4oNsAsUZ/7YwQ/BoizzVYPNZhm7pWFegg7mtXkt4VC4hO08pkJlUbTTQbBrak61yb
	3nfEtOGq2e/tF3lKT4RtbNvnIyX+F4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762858168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkJQ+ETHMLX8gaociQ/ZH4e9YkkTx1BYT1F+DHiUNow=;
	b=pxjRMTfX6kH3ijVgNX4+D7CfwQqIa0aJAtKl6cNDjcZOJTtdTt3PR653T1tMeG8lvmlwI6
	lKgj7ADcTdiZRGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D1CD148FC;
	Tue, 11 Nov 2025 10:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YkhWJrgUE2k9QQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Nov 2025 10:49:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 466A7A28C8; Tue, 11 Nov 2025 11:49:24 +0100 (CET)
Date: Tue, 11 Nov 2025 11:49:24 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 01/17] filelock: make lease_alloc() take a flags
 argument
Message-ID: <zmpoq5aaprvu7ymytrensjue2qwkcsj6aiylfan2adbreftknb@mwinvi3uwb2p>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
 <20251105-dir-deleg-ro-v5-1-7ebc168a88ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-dir-deleg-ro-v5-1-7ebc168a88ac@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 05-11-25 11:53:47, Jeff Layton wrote:
> __break_lease() currently overrides the flc_flags field in the lease
> after allocating it. A forthcoming patch will add the ability to request
> a FL_DELEG type lease.
> 
> Instead of overriding the flags field, add a flags argument to
> lease_alloc() and lease_init() so it's set correctly after allocating.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/locks.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 04a3f0e2072461b6e2d3d1cd12f2b089d69a7db3..b33c327c21dcd49341fbeac47caeb72cdf7455db 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -585,7 +585,7 @@ static const struct lease_manager_operations lease_manager_ops = {
>  /*
>   * Initialize a lease, use the default lock manager operations
>   */
> -static int lease_init(struct file *filp, int type, struct file_lease *fl)
> +static int lease_init(struct file *filp, unsigned int flags, int type, struct file_lease *fl)
>  {
>  	if (assign_type(&fl->c, type) != 0)
>  		return -EINVAL;
> @@ -594,13 +594,13 @@ static int lease_init(struct file *filp, int type, struct file_lease *fl)
>  	fl->c.flc_pid = current->tgid;
>  
>  	fl->c.flc_file = filp;
> -	fl->c.flc_flags = FL_LEASE;
> +	fl->c.flc_flags = flags;
>  	fl->fl_lmops = &lease_manager_ops;
>  	return 0;
>  }
>  
>  /* Allocate a file_lock initialised to this type of lease */
> -static struct file_lease *lease_alloc(struct file *filp, int type)
> +static struct file_lease *lease_alloc(struct file *filp, unsigned int flags, int type)
>  {
>  	struct file_lease *fl = locks_alloc_lease();
>  	int error = -ENOMEM;
> @@ -608,7 +608,7 @@ static struct file_lease *lease_alloc(struct file *filp, int type)
>  	if (fl == NULL)
>  		return ERR_PTR(error);
>  
> -	error = lease_init(filp, type, fl);
> +	error = lease_init(filp, flags, type, fl);
>  	if (error) {
>  		locks_free_lease(fl);
>  		return ERR_PTR(error);
> @@ -1548,10 +1548,9 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  	int want_write = (mode & O_ACCMODE) != O_RDONLY;
>  	LIST_HEAD(dispose);
>  
> -	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
> +	new_fl = lease_alloc(NULL, type, want_write ? F_WRLCK : F_RDLCK);
>  	if (IS_ERR(new_fl))
>  		return PTR_ERR(new_fl);
> -	new_fl->c.flc_flags = type;
>  
>  	/* typically we will check that ctx is non-NULL before calling */
>  	ctx = locks_inode_context(inode);
> @@ -2033,7 +2032,7 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
>  	struct fasync_struct *new;
>  	int error;
>  
> -	fl = lease_alloc(filp, arg);
> +	fl = lease_alloc(filp, FL_LEASE, arg);
>  	if (IS_ERR(fl))
>  		return PTR_ERR(fl);
>  
> 
> -- 
> 2.51.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

