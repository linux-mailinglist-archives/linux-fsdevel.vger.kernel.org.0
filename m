Return-Path: <linux-fsdevel+bounces-65078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F780BFB0ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 11:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD215870A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6E5311961;
	Wed, 22 Oct 2025 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G9J5KCh6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="14G+ZRO8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cw4Kd4WO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q0/1LwQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414230F53E
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123820; cv=none; b=rinAdaLpAo79ppslBW+3vKaMye9OSRTJbWGCxXiU3H6MppXCYimah+RqaIujY2Ckx+Cb9tZTbX2wE6SEUvMTMmZ90QkjfuuglBlSaK/ExRo5DUtYPB8bzc0wap5yMw6QDxecyANFVmsYGDMfYCcvmJ/MVqW2JVhBjqdfDIp7SlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123820; c=relaxed/simple;
	bh=BbjKdKJOIN11/N/Av8tRJFdvvl/rcEy0y/T/ykyBLDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhRkY1f01Lwzb86Jo6Zt63kwW/HjwFuqp9B/D66nFKBtfRURvyg+4gLvVykfIQHV+bBUvIq2sv3sjbVVSrB3xn6MJmBa+R98v6lKk5CqnJaTRxk3dVfV9BD/FDl+vyuhZwBWVRmrachdATXbOfSuYuiruCoKVunvlxn2pL54KEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G9J5KCh6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=14G+ZRO8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cw4Kd4WO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q0/1LwQh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6A691F788;
	Wed, 22 Oct 2025 09:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761123812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWrRoINCj3OqAfg5PTgsjqvXeRUN3tNurbDF1UsQ+SU=;
	b=G9J5KCh6W+1WPd/qBI48zIgYJLRNiHsHnfkiRiTP0Xzyyzdb1KHb8GuQVeUVLuJl/a8YVn
	XNPsdB1Jx8K9KlwbDI2YFXtHvg8ZaxNxPfv17V5TwZu2vztFabLuSstPusCcqDnwgOi+8S
	PB8Nd5XOFFeoYmMoNO6xMj8qKJiMLrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761123812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWrRoINCj3OqAfg5PTgsjqvXeRUN3tNurbDF1UsQ+SU=;
	b=14G+ZRO8KRuFHfqfYaKfca3Mg4mTGnDXIsGqDkPmz4hI/RMvdcY4XYQ1xk1lfbQytLf/uk
	WbYvieYu0JpZciBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cw4Kd4WO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Q0/1LwQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761123808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWrRoINCj3OqAfg5PTgsjqvXeRUN3tNurbDF1UsQ+SU=;
	b=cw4Kd4WOzTalNHRC5kCf/r86pEI4ruZ6cuuR60Cib43IhlIP4H7IfPypaa8eJQIZ8mkj7s
	pCoATgsHVMVqio6AfMa02cN26SSVNk33Ez6Vdo6DGluRbOzllUTn07g2yyZI/8u2q6Pq+5
	vcb55DncI+TB00+jX03tL2ElOHnubaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761123808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWrRoINCj3OqAfg5PTgsjqvXeRUN3tNurbDF1UsQ+SU=;
	b=Q0/1LwQhf1vXYMN24ZHHUpKVytdg28nYw9hc6n1N6ay6PKGXvIm/kT09I7fQl0fNvl4n4k
	OmJeQTUwvheKYoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA47013A29;
	Wed, 22 Oct 2025 09:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XmdINd+d+GisbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Oct 2025 09:03:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 43473A0990; Wed, 22 Oct 2025 11:03:19 +0200 (CEST)
Date: Wed, 22 Oct 2025 11:03:19 +0200
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
Subject: Re: [PATCH v3 09/13] filelock: lift the ban on directory leases in
 generic_setlease
Message-ID: <g7r2bffekbosexqbatj5mb7ljc5rn5rw3dwfehipsxdb6hewyp@heriwuhgh3zo>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
 <20251021-dir-deleg-ro-v3-9-a08b1cde9f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-dir-deleg-ro-v3-9-a08b1cde9f4c@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E6A691F788
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLpnapcpkwxdkc5mopt1ezhhna)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -2.51

On Tue 21-10-25 11:25:44, Jeff Layton wrote:
> With the addition of the try_break_lease calls in directory changing
> operations, allow generic_setlease to hand them out. Write leases on
> directories are never allowed however, so continue to reject them.
> 
> For now, there is no API for requesting delegations from userland, so
> ensure that userland is prevented from acquiring a lease on a directory.
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/locks.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 0b16921fb52e602ea2e0c3de39d9d772af98ba7d..b47552106769ec5a189babfe12518e34aa59c759 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1929,14 +1929,19 @@ static int generic_delete_lease(struct file *filp, void *owner)
>  int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
>  			void **priv)
>  {
> -	if (!S_ISREG(file_inode(filp)->i_mode))
> +	struct inode *inode = file_inode(filp);
> +
> +	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
>  		return -EINVAL;
>  
>  	switch (arg) {
>  	case F_UNLCK:
>  		return generic_delete_lease(filp, *priv);
> -	case F_RDLCK:
>  	case F_WRLCK:
> +		if (S_ISDIR(inode->i_mode))
> +			return -EINVAL;
> +		fallthrough;
> +	case F_RDLCK:
>  		if (!(*flp)->fl_lmops->lm_break) {
>  			WARN_ON_ONCE(1);
>  			return -ENOLCK;
> @@ -2065,6 +2070,9 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
>   */
>  int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
>  {
> +	if (S_ISDIR(file_inode(filp)->i_mode))
> +		return -EINVAL;
> +
>  	if (arg == F_UNLCK)
>  		return vfs_setlease(filp, F_UNLCK, NULL, (void **)&filp);
>  	return do_fcntl_add_lease(fd, filp, arg);
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

