Return-Path: <linux-fsdevel+bounces-67908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B4C4D4F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A017318C0899
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF40355045;
	Tue, 11 Nov 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MvCFFVYW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P3QkYLWD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AZ504nQQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="33GaccVM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB70358D01
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858635; cv=none; b=Aa4/HSYUXBprH1BBkCJ5WiJElKpG2SJWc7Lr6cxZ5iHYlyOcWychswit63o7YxvFsi6mZXs8udSMU3vlVfy9HomKnHFg7SGKEULEOWSh5mHJZH+X2tytLmrvSMopClDFxHCvL3xt+akSFNrkZpeLBjFaSrgXmt5SoBm26notdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858635; c=relaxed/simple;
	bh=0qIKVWddtsPV5G/8hROLCcnDFjecC5eN+g5hMbRRlOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K77v4x6S2lR4jw/7/SjR5iOGx/cjiHJYzRYCqZ2AKye5rcefE9g1Fjo25aJt8JzhQj4AsVzVquNNTX3MxijBaeWbdzBXd7y+xAVo8DYPfkmynTMVc6m54i0zqd22KWZ1U7pnMBk9+5hEsUNipa1w62wn4LHWHY7qCla/9NzSIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MvCFFVYW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P3QkYLWD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AZ504nQQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=33GaccVM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCD701F6E6;
	Tue, 11 Nov 2025 10:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762858631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tro3eQIQ3vyegRPUo7YaUGYg3RQMDIXBqzFb8qZf8+g=;
	b=MvCFFVYWL5JqlsT/4QlFyaMQSfKKnBXdNafiZLkP6b4bDJO3s7Vrjp/EY45p+ON7HJkvpT
	LdC1gJ3IquF49avQWhiqvR4JUnpy+3etN7fs+6xsdiGPrC2uYQSlexFZxQHUV4LIzhaxUB
	mnAX0YE5SJBgjjCwkCZQNQdhsGIM0Ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762858631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tro3eQIQ3vyegRPUo7YaUGYg3RQMDIXBqzFb8qZf8+g=;
	b=P3QkYLWDDehOJBhUl5o4hYHBQthdkh6UovCAOmKZrTJ2YKlzS4EUJpj3TfJp6hG+M2wwqZ
	rifSI0SkbBM1J9BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762858629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tro3eQIQ3vyegRPUo7YaUGYg3RQMDIXBqzFb8qZf8+g=;
	b=AZ504nQQ/qxjD7wBdRDwoPJZk2UIlqEBuK7dzo2R4HW0ZWZ91xo0ujXogFopSyCucSFt1N
	KE1jhJ7m7aEhPa3FflYyccMsS0xt3HZuxN5zQ+Se3l8GrB7RUsxwyZI3qqDiPquF0b2RZe
	DRY6QjoRn7onOsXLD1a17Wp1q62Jqaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762858629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tro3eQIQ3vyegRPUo7YaUGYg3RQMDIXBqzFb8qZf8+g=;
	b=33GaccVMUKt+yQ5hHqE1wM3DyUhmohaF+FnnT0u2N/oQsU98WvkobEmrkUwEHsmiJkEPmm
	1UkSw875MKOLqeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE43F14904;
	Tue, 11 Nov 2025 10:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NwZlLoUWE2muSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Nov 2025 10:57:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72622A28C8; Tue, 11 Nov 2025 11:57:01 +0100 (CET)
Date: Tue, 11 Nov 2025 11:57:01 +0100
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
Subject: Re: [PATCH v5 02/17] filelock: rework the __break_lease API to use
 flags
Message-ID: <n3nwojvti3upo6a75ndqci476aoo2ceoo3mz2zvuc35pxkcf4d@tqoqua3jjr64>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
 <20251105-dir-deleg-ro-v5-2-7ebc168a88ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-dir-deleg-ro-v5-2-7ebc168a88ac@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Wed 05-11-25 11:53:48, Jeff Layton wrote:
> Currently __break_lease takes both a type and an openmode. With the
> addition of directory leases, that makes less sense. Declare a set of
> LEASE_BREAK_* flags that can be used to control how lease breaks work
> instead of requiring a type and an openmode.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/locks.c               | 29 +++++++++++++++++----------
>  include/linux/filelock.h | 52 +++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 56 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index b33c327c21dcd49341fbeac47caeb72cdf7455db..3cdd84a0fbedc9bd1b47725a9cf963342aafbce9 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1529,24 +1529,31 @@ any_leases_conflict(struct inode *inode, struct file_lease *breaker)
>  /**
>   *	__break_lease	-	revoke all outstanding leases on file
>   *	@inode: the inode of the file to return
> - *	@mode: O_RDONLY: break only write leases; O_WRONLY or O_RDWR:
> - *	    break all leases
> - *	@type: FL_LEASE: break leases and delegations; FL_DELEG: break
> - *	    only delegations
> + *	@flags: LEASE_BREAK_* flags
>   *
>   *	break_lease (inlined for speed) has checked there already is at least
>   *	some kind of lock (maybe a lease) on this file.  Leases are broken on
> - *	a call to open() or truncate().  This function can sleep unless you
> - *	specified %O_NONBLOCK to your open().
> + *	a call to open() or truncate().  This function can block waiting for the
> + *	lease break unless you specify LEASE_BREAK_NONBLOCK.
>   */
> -int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
> +int __break_lease(struct inode *inode, unsigned int flags)
>  {
> -	int error = 0;
> -	struct file_lock_context *ctx;
>  	struct file_lease *new_fl, *fl, *tmp;
> +	struct file_lock_context *ctx;
>  	unsigned long break_time;
> -	int want_write = (mode & O_ACCMODE) != O_RDONLY;
> +	unsigned int type;
>  	LIST_HEAD(dispose);
> +	bool want_write = !(flags & LEASE_BREAK_OPEN_RDONLY);
> +	int error = 0;
> +
> +	if (flags & LEASE_BREAK_LEASE)
> +		type = FL_LEASE;
> +	else if (flags & LEASE_BREAK_DELEG)
> +		type = FL_DELEG;
> +	else if (flags & LEASE_BREAK_LAYOUT)
> +		type = FL_LAYOUT;
> +	else
> +		return -EINVAL;
>  
>  	new_fl = lease_alloc(NULL, type, want_write ? F_WRLCK : F_RDLCK);
>  	if (IS_ERR(new_fl))
> @@ -1595,7 +1602,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  	if (list_empty(&ctx->flc_lease))
>  		goto out;
>  
> -	if (mode & O_NONBLOCK) {
> +	if (flags & LEASE_BREAK_NONBLOCK) {
>  		trace_break_lease_noblock(inode, new_fl);
>  		error = -EWOULDBLOCK;
>  		goto out;
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index c2ce8ba05d068b451ecf8f513b7e532819a29944..47da6aa28d8dc9122618d02c6608deda0f3c4d3e 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -212,7 +212,14 @@ int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
>  void locks_init_lease(struct file_lease *);
>  void locks_free_lease(struct file_lease *fl);
>  struct file_lease *locks_alloc_lease(void);
> -int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
> +
> +#define LEASE_BREAK_LEASE		BIT(0)	// break leases and delegations
> +#define LEASE_BREAK_DELEG		BIT(1)	// break delegations only
> +#define LEASE_BREAK_LAYOUT		BIT(2)	// break layouts only
> +#define LEASE_BREAK_NONBLOCK		BIT(3)	// non-blocking break
> +#define LEASE_BREAK_OPEN_RDONLY		BIT(4)	// readonly open event
> +
> +int __break_lease(struct inode *inode, unsigned int flags);
>  void lease_get_mtime(struct inode *, struct timespec64 *time);
>  int generic_setlease(struct file *, int, struct file_lease **, void **priv);
>  int kernel_setlease(struct file *, int, struct file_lease **, void **);
> @@ -367,7 +374,7 @@ static inline int locks_lock_inode_wait(struct inode *inode, struct file_lock *f
>  	return -ENOLCK;
>  }
>  
> -static inline int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
> +static inline int __break_lease(struct inode *inode, unsigned int flags)
>  {
>  	return 0;
>  }
> @@ -428,6 +435,17 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
>  }
>  
>  #ifdef CONFIG_FILE_LOCKING
> +static inline unsigned int openmode_to_lease_flags(unsigned int mode)
> +{
> +	unsigned int flags = 0;
> +
> +	if ((mode & O_ACCMODE) == O_RDONLY)
> +		flags |= LEASE_BREAK_OPEN_RDONLY;
> +	if (mode & O_NONBLOCK)
> +		flags |= LEASE_BREAK_NONBLOCK;
> +	return flags;
> +}
> +
>  static inline int break_lease(struct inode *inode, unsigned int mode)
>  {
>  	struct file_lock_context *flctx;
> @@ -443,11 +461,11 @@ static inline int break_lease(struct inode *inode, unsigned int mode)
>  		return 0;
>  	smp_mb();
>  	if (!list_empty_careful(&flctx->flc_lease))
> -		return __break_lease(inode, mode, FL_LEASE);
> +		return __break_lease(inode, LEASE_BREAK_LEASE | openmode_to_lease_flags(mode));
>  	return 0;
>  }
>  
> -static inline int break_deleg(struct inode *inode, unsigned int mode)
> +static inline int break_deleg(struct inode *inode, unsigned int flags)
>  {
>  	struct file_lock_context *flctx;
>  
> @@ -461,8 +479,10 @@ static inline int break_deleg(struct inode *inode, unsigned int mode)
>  	if (!flctx)
>  		return 0;
>  	smp_mb();
> -	if (!list_empty_careful(&flctx->flc_lease))
> -		return __break_lease(inode, mode, FL_DELEG);
> +	if (!list_empty_careful(&flctx->flc_lease)) {
> +		flags |= LEASE_BREAK_DELEG;
> +		return __break_lease(inode, flags);
> +	}
>  	return 0;
>  }
>  
> @@ -470,7 +490,7 @@ static inline int try_break_deleg(struct inode *inode, struct inode **delegated_
>  {
>  	int ret;
>  
> -	ret = break_deleg(inode, O_WRONLY|O_NONBLOCK);
> +	ret = break_deleg(inode, LEASE_BREAK_NONBLOCK);
>  	if (ret == -EWOULDBLOCK && delegated_inode) {
>  		*delegated_inode = inode;
>  		ihold(inode);
> @@ -482,7 +502,7 @@ static inline int break_deleg_wait(struct inode **delegated_inode)
>  {
>  	int ret;
>  
> -	ret = break_deleg(*delegated_inode, O_WRONLY);
> +	ret = break_deleg(*delegated_inode, 0);
>  	iput(*delegated_inode);
>  	*delegated_inode = NULL;
>  	return ret;
> @@ -491,20 +511,24 @@ static inline int break_deleg_wait(struct inode **delegated_inode)
>  static inline int break_layout(struct inode *inode, bool wait)
>  {
>  	smp_mb();
> -	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
> -		return __break_lease(inode,
> -				wait ? O_WRONLY : O_WRONLY | O_NONBLOCK,
> -				FL_LAYOUT);
> +	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease)) {
> +		unsigned int flags = LEASE_BREAK_LAYOUT;
> +
> +		if (!wait)
> +			flags |= LEASE_BREAK_NONBLOCK;
> +
> +		return __break_lease(inode, flags);
> +	}
>  	return 0;
>  }
>  
>  #else /* !CONFIG_FILE_LOCKING */
> -static inline int break_lease(struct inode *inode, unsigned int mode)
> +static inline int break_lease(struct inode *inode, bool wait)
>  {
>  	return 0;
>  }
>  
> -static inline int break_deleg(struct inode *inode, unsigned int mode)
> +static inline int break_deleg(struct inode *inode, unsigned int flags)
>  {
>  	return 0;
>  }
> 
> -- 
> 2.51.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

