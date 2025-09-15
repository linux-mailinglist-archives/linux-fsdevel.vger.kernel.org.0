Return-Path: <linux-fsdevel+bounces-61399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28472B57D19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CEA1AA2F53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09962315D37;
	Mon, 15 Sep 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bNR4R6FA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kXVZgNRq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bNR4R6FA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kXVZgNRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF33315D29
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942920; cv=none; b=B0nEZ4L3KsMLOukNJeGfxkej7XTkM5657/KOKnIA8eJOyQDDz1jbalTLqRNrNWjRSVKd8YAcX6kXTGx3DRFuRqLNFov/Yn4/DpfSTQWbZO2QYLzA+KjRSMbI9got4AxdUVKdjLgZZys/vgCtj25xcmdmxhIXsOU3FA14jjYd6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942920; c=relaxed/simple;
	bh=1AW4t4m6IiHUftKocp6VIyAkHCIooVduXxKVptt40PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZemURTt6iXR2aCGmrl/9sZysHR5B9tPhl2nlZwOPgYHnWVwga+DksSdzX8AOo7+jkG7CKJmo0b1VYokJZgJu1QTZxaO+oXvOa8LVc4DTl5b79VAeRvS3akDfh80dXYtlaGO4pp1S8Svtxf2zUCSgruObH38VRTDWkD9W45fr3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bNR4R6FA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kXVZgNRq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bNR4R6FA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kXVZgNRq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64A6B1FB3B;
	Mon, 15 Sep 2025 13:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757942916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fh2vl3+uAnoFHC+NjtnoTcOHnOS9CFU/hHs/bP7JMG0=;
	b=bNR4R6FALKJQFagyxuMJVny9MRcdRheTibLPuOdI3N9VWPz1UVqy4t31q9NPZQiaDsgNxv
	8domcKZEj0qkd6JIQsOHZSv1BnILvngKu7FNsZJrxmqz+rQ0fYm1fQ5z7tonW06c6t6Pvx
	0QUFW5P6j5JaKurqRfXxa2TMsbsaxwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757942916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fh2vl3+uAnoFHC+NjtnoTcOHnOS9CFU/hHs/bP7JMG0=;
	b=kXVZgNRq73fYquBOv5Gd6JCZO2bjeCgVyRCbya/8OaDivP9pCcU4v4vylnfj3Uzb03VhgZ
	wBEx95vInt4e0cAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bNR4R6FA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kXVZgNRq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757942916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fh2vl3+uAnoFHC+NjtnoTcOHnOS9CFU/hHs/bP7JMG0=;
	b=bNR4R6FALKJQFagyxuMJVny9MRcdRheTibLPuOdI3N9VWPz1UVqy4t31q9NPZQiaDsgNxv
	8domcKZEj0qkd6JIQsOHZSv1BnILvngKu7FNsZJrxmqz+rQ0fYm1fQ5z7tonW06c6t6Pvx
	0QUFW5P6j5JaKurqRfXxa2TMsbsaxwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757942916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fh2vl3+uAnoFHC+NjtnoTcOHnOS9CFU/hHs/bP7JMG0=;
	b=kXVZgNRq73fYquBOv5Gd6JCZO2bjeCgVyRCbya/8OaDivP9pCcU4v4vylnfj3Uzb03VhgZ
	wBEx95vInt4e0cAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4929B1372E;
	Mon, 15 Sep 2025 13:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P7aLEYQUyGgUTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 13:28:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E532FA0A06; Mon, 15 Sep 2025 15:28:31 +0200 (CEST)
Date: Mon, 15 Sep 2025 15:28:31 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 30/33] nsfs: add missing id retrieval support
Message-ID: <bmkl6ii7y7fbkzndiukfuxpgsysli6552zzg2fsax4xqhgms73@wk7sfbp6hqyl>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-30-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-30-1a247645cef5@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 64A6B1FB3B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -2.51

On Fri 12-09-25 13:52:53, Christian Brauner wrote:
> The mount namespace has supported id retrieval for a while already.
> Add support for the other types as well.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/nsfs.c                 | 25 +++++++++++++------------
>  include/uapi/linux/nsfs.h |  6 ++++--
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 22765fcab18e..8484bc4dd3de 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -177,6 +177,7 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
>  	case NS_GET_TGID_FROM_PIDNS:
>  	case NS_GET_PID_IN_PIDNS:
>  	case NS_GET_TGID_IN_PIDNS:
> +	case NS_GET_ID:
>  		return true;
>  	}
>  
> @@ -226,18 +227,6 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  		argp = (uid_t __user *) arg;
>  		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
>  		return put_user(uid, argp);
> -	case NS_GET_MNTNS_ID: {
> -		__u64 __user *idp;
> -		__u64 id;
> -
> -		if (ns->ops->type != CLONE_NEWNS)
> -			return -EINVAL;
> -
> -		mnt_ns = container_of(ns, struct mnt_namespace, ns);
> -		idp = (__u64 __user *)arg;
> -		id = mnt_ns->ns.ns_id;
> -		return put_user(id, idp);
> -	}
>  	case NS_GET_PID_FROM_PIDNS:
>  		fallthrough;
>  	case NS_GET_TGID_FROM_PIDNS:
> @@ -283,6 +272,18 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  			ret = -ESRCH;
>  		return ret;
>  	}
> +	case NS_GET_MNTNS_ID:
> +		if (ns->ops->type != CLONE_NEWNS)
> +			return -EINVAL;
> +		fallthrough;
> +	case NS_GET_ID: {
> +		__u64 __user *idp;
> +		__u64 id;
> +
> +		idp = (__u64 __user *)arg;
> +		id = ns->ns_id;
> +		return put_user(id, idp);
> +	}
>  	}
>  
>  	/* extensible ioctls */
> diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> index fa86fe3c8bd3..5d5bf22464c9 100644
> --- a/include/uapi/linux/nsfs.h
> +++ b/include/uapi/linux/nsfs.h
> @@ -16,8 +16,6 @@
>  #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
>  /* Get owner UID (in the caller's user namespace) for a user namespace */
>  #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> -/* Get the id for a mount namespace */
> -#define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, __u64)
>  /* Translate pid from target pid namespace into the caller's pid namespace. */
>  #define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
>  /* Return thread-group leader id of pid in the callers pid namespace. */
> @@ -42,6 +40,10 @@ struct mnt_ns_info {
>  /* Get previous namespace. */
>  #define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
>  
> +/* Retrieve namespace identifiers. */
> +#define NS_GET_MNTNS_ID		_IOR(NSIO, 5,  __u64)
> +#define NS_GET_ID		_IOR(NSIO, 13, __u64)
> +
>  enum init_ns_ino {
>  	IPC_NS_INIT_INO		= 0xEFFFFFFFU,
>  	UTS_NS_INIT_INO		= 0xEFFFFFFEU,
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

