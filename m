Return-Path: <linux-fsdevel+bounces-78732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NnjOjK5oWkYwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:33:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB471B9D9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D0F32130DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4000742189F;
	Fri, 27 Feb 2026 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oIw4CkYL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fldL9BQ4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oIw4CkYL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fldL9BQ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CA1361DCB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205639; cv=none; b=k/QyDJ30+kams3oVGNq77tJupaCg9oYrh3Z1A/nMaRqghXHwNDt1U9FCqDzK4dxKbx7dyxGL1/a0CRshFzblH4YCtehD0h/615C5apUkNAfipbTRsxcMjiMQ6DbxDt7587ptaczQroR+bJIQUm4OuL9l6gvZIA77llBwen8Wqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205639; c=relaxed/simple;
	bh=Ucu5Ro/Hjoewx7VZ1CndqIRj4auAHqA3pNCVtRLfF74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC9OHdtmdCvGdhz2JWTYnEUc9XUm49axV8hcBYwr1uPDNEOpDgrsCo1QnvBvvNjobVdO00XLWK2zoqwtaz9fx4IjXagCRwOQd1xnvTtLzZF0kSz/gIXDBC7p+Cq/RjqMV1yIX+P1dTkT0OtU7pxWqZPi6s46gm6pG+XX4Zg5DcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oIw4CkYL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fldL9BQ4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oIw4CkYL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fldL9BQ4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 776D13FCE2;
	Fri, 27 Feb 2026 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiGwAFn9EKy52FCi+TKx67ubELYVUTHPOvHsztjUS74=;
	b=oIw4CkYLQOpmxTptEaLEpwgchUcB6ZrWHZKkqSdG4I6wJcvA6fOVElgduXUNVr7+7vM3oP
	XtPWm3+jeqT/q9FdmB8QOiMD9Wt9UatM7eq/PscmMW6YeQJ3LjVpX51YHJTI1pXjZFnz7R
	xAZYPt4+qWIJLnHpa0eZpbu8gwuGdaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiGwAFn9EKy52FCi+TKx67ubELYVUTHPOvHsztjUS74=;
	b=fldL9BQ4mj/6HJodbVPi3M2119O6qjKjK/Mzk/0VDb0yxMsjCRi6AKXq+Ap2y/Zyx4N/7o
	1qSj71NtNBLdhyBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiGwAFn9EKy52FCi+TKx67ubELYVUTHPOvHsztjUS74=;
	b=oIw4CkYLQOpmxTptEaLEpwgchUcB6ZrWHZKkqSdG4I6wJcvA6fOVElgduXUNVr7+7vM3oP
	XtPWm3+jeqT/q9FdmB8QOiMD9Wt9UatM7eq/PscmMW6YeQJ3LjVpX51YHJTI1pXjZFnz7R
	xAZYPt4+qWIJLnHpa0eZpbu8gwuGdaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiGwAFn9EKy52FCi+TKx67ubELYVUTHPOvHsztjUS74=;
	b=fldL9BQ4mj/6HJodbVPi3M2119O6qjKjK/Mzk/0VDb0yxMsjCRi6AKXq+Ap2y/Zyx4N/7o
	1qSj71NtNBLdhyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A82D3EA69;
	Fri, 27 Feb 2026 15:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nID8GUS2oWnAIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:20:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3122FA06D4; Fri, 27 Feb 2026 16:20:36 +0100 (CET)
Date: Fri, 27 Feb 2026 16:20:36 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 09/14] xattr: move user limits for xattrs to generic infra
Message-ID: <ba2xttc5jggmzjj3z273vwagyqqjdcg6yzwnnashqdgzwj5zbt@r7sa2xsllyau>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-9-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-9-c2efa4f74cb7@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78732-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7BB471B9D9B
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:05, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/kernfs/inode.c           | 75 ++-------------------------------------------
>  fs/kernfs/kernfs-internal.h |  3 +-
>  fs/xattr.c                  | 65 +++++++++++++++++++++++++++++++++++++++
>  include/linux/kernfs.h      |  2 --
>  include/linux/xattr.h       | 18 +++++++++++
>  5 files changed, 87 insertions(+), 76 deletions(-)
> 
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index dfc3315b5afc..1de10500842d 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -45,8 +45,7 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, bool alloc)
>  	ret->ia_mtime = ret->ia_atime;
>  	ret->ia_ctime = ret->ia_atime;
>  
> -	atomic_set(&ret->nr_user_xattrs, 0);
> -	atomic_set(&ret->user_xattr_size, 0);
> +	simple_xattr_limits_init(&ret->xattr_limits);
>  
>  	/* If someone raced us, recognize it. */
>  	if (!try_cmpxchg(&kn->iattr, &attr, ret))
> @@ -355,69 +354,6 @@ static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
>  	return kernfs_xattr_set(kn, name, value, size, flags);
>  }
>  
> -static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
> -				     const char *full_name,
> -				     struct simple_xattrs *xattrs,
> -				     const void *value, size_t size, int flags)
> -{
> -	struct kernfs_iattrs *attr = kernfs_iattrs_noalloc(kn);
> -	atomic_t *sz = &attr->user_xattr_size;
> -	atomic_t *nr = &attr->nr_user_xattrs;
> -	struct simple_xattr *old_xattr;
> -	int ret;
> -
> -	if (atomic_inc_return(nr) > KERNFS_MAX_USER_XATTRS) {
> -		ret = -ENOSPC;
> -		goto dec_count_out;
> -	}
> -
> -	if (atomic_add_return(size, sz) > KERNFS_USER_XATTR_SIZE_LIMIT) {
> -		ret = -ENOSPC;
> -		goto dec_size_out;
> -	}
> -
> -	old_xattr = simple_xattr_set(xattrs, full_name, value, size, flags);
> -	if (!old_xattr)
> -		return 0;
> -
> -	if (IS_ERR(old_xattr)) {
> -		ret = PTR_ERR(old_xattr);
> -		goto dec_size_out;
> -	}
> -
> -	ret = 0;
> -	size = old_xattr->size;
> -	simple_xattr_free_rcu(old_xattr);
> -dec_size_out:
> -	atomic_sub(size, sz);
> -dec_count_out:
> -	atomic_dec(nr);
> -	return ret;
> -}
> -
> -static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
> -				    const char *full_name,
> -				    struct simple_xattrs *xattrs,
> -				    const void *value, size_t size, int flags)
> -{
> -	struct kernfs_iattrs *attr = kernfs_iattrs_noalloc(kn);
> -	atomic_t *sz = &attr->user_xattr_size;
> -	atomic_t *nr = &attr->nr_user_xattrs;
> -	struct simple_xattr *old_xattr;
> -
> -	old_xattr = simple_xattr_set(xattrs, full_name, value, size, flags);
> -	if (!old_xattr)
> -		return 0;
> -
> -	if (IS_ERR(old_xattr))
> -		return PTR_ERR(old_xattr);
> -
> -	atomic_sub(old_xattr->size, sz);
> -	atomic_dec(nr);
> -	simple_xattr_free_rcu(old_xattr);
> -	return 0;
> -}
> -
>  static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
>  				     struct mnt_idmap *idmap,
>  				     struct dentry *unused, struct inode *inode,
> @@ -440,13 +376,8 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
>  	if (IS_ERR_OR_NULL(xattrs))
>  		return PTR_ERR(xattrs);
>  
> -	if (value)
> -		return kernfs_vfs_user_xattr_add(kn, full_name, xattrs,
> -						 value, size, flags);
> -	else
> -		return kernfs_vfs_user_xattr_rm(kn, full_name, xattrs,
> -						value, size, flags);
> -
> +	return simple_xattr_set_limited(xattrs, &attrs->xattr_limits,
> +					full_name, value, size, flags);
>  }
>  
>  static const struct xattr_handler kernfs_trusted_xattr_handler = {
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 1324ed8c0661..1d3831e3a270 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -27,8 +27,7 @@ struct kernfs_iattrs {
>  	struct timespec64	ia_ctime;
>  
>  	struct simple_xattrs	*xattrs;
> -	atomic_t		nr_user_xattrs;
> -	atomic_t		user_xattr_size;
> +	struct simple_xattr_limits xattr_limits;
>  };
>  
>  struct kernfs_root {
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 328ed7558dfc..5e559b1c651f 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1427,6 +1427,71 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
>  	return old_xattr;
>  }
>  
> +static inline void simple_xattr_limits_dec(struct simple_xattr_limits *limits,
> +					   size_t size)
> +{
> +	atomic_sub(size, &limits->xattr_size);
> +	atomic_dec(&limits->nr_xattrs);
> +}
> +
> +static inline int simple_xattr_limits_inc(struct simple_xattr_limits *limits,
> +					  size_t size)
> +{
> +	if (atomic_inc_return(&limits->nr_xattrs) > SIMPLE_XATTR_MAX_NR) {
> +		atomic_dec(&limits->nr_xattrs);
> +		return -ENOSPC;
> +	}
> +
> +	if (atomic_add_return(size, &limits->xattr_size) <= SIMPLE_XATTR_MAX_SIZE)
> +		return 0;
> +
> +	simple_xattr_limits_dec(limits, size);
> +	return -ENOSPC;
> +}
> +
> +/**
> + * simple_xattr_set_limited - set an xattr with per-inode user.* limits
> + * @xattrs: the header of the xattr object
> + * @limits: per-inode limit counters for user.* xattrs
> + * @name: the name of the xattr to set or remove
> + * @value: the value to store (NULL to remove)
> + * @size: the size of @value
> + * @flags: XATTR_CREATE, XATTR_REPLACE, or 0
> + *
> + * Like simple_xattr_set(), but enforces per-inode count and total value size
> + * limits for user.* xattrs. Uses speculative pre-increment of the atomic
> + * counters to avoid races without requiring external locks.
> + *
> + * Return: On success zero is returned. On failure a negative error code is
> + * returned.
> + */
> +int simple_xattr_set_limited(struct simple_xattrs *xattrs,
> +			     struct simple_xattr_limits *limits,
> +			     const char *name, const void *value,
> +			     size_t size, int flags)
> +{
> +	struct simple_xattr *old_xattr;
> +	int ret;
> +
> +	if (value) {
> +		ret = simple_xattr_limits_inc(limits, size);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
> +	if (IS_ERR(old_xattr)) {
> +		if (value)
> +			simple_xattr_limits_dec(limits, size);
> +		return PTR_ERR(old_xattr);
> +	}
> +	if (old_xattr) {
> +		simple_xattr_limits_dec(limits, old_xattr->size);
> +		simple_xattr_free_rcu(old_xattr);
> +	}
> +	return 0;
> +}
> +
>  static bool xattr_is_trusted(const char *name)
>  {
>  	return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index b5a5f32fdfd1..d8f57f0af5e4 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -99,8 +99,6 @@ enum kernfs_node_type {
>  
>  #define KERNFS_TYPE_MASK		0x000f
>  #define KERNFS_FLAG_MASK		~KERNFS_TYPE_MASK
> -#define KERNFS_MAX_USER_XATTRS		128
> -#define KERNFS_USER_XATTR_SIZE_LIMIT	(128 << 10)
>  
>  enum kernfs_node_flag {
>  	KERNFS_ACTIVATED	= 0x0010,
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index f60357d9f938..90a43a117127 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -118,6 +118,20 @@ struct simple_xattr {
>  	char value[];
>  };
>  
> +#define SIMPLE_XATTR_MAX_NR		128
> +#define SIMPLE_XATTR_MAX_SIZE		(128 << 10)
> +
> +struct simple_xattr_limits {
> +	atomic_t	nr_xattrs;	/* current user.* xattr count */
> +	atomic_t	xattr_size;	/* current total user.* value bytes */
> +};
> +
> +static inline void simple_xattr_limits_init(struct simple_xattr_limits *limits)
> +{
> +	atomic_set(&limits->nr_xattrs, 0);
> +	atomic_set(&limits->xattr_size, 0);
> +}
> +
>  int simple_xattrs_init(struct simple_xattrs *xattrs);
>  struct simple_xattrs *simple_xattrs_alloc(void);
>  struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
> @@ -132,6 +146,10 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
>  				      const char *name, const void *value,
>  				      size_t size, int flags);
> +int simple_xattr_set_limited(struct simple_xattrs *xattrs,
> +			     struct simple_xattr_limits *limits,
> +			     const char *name, const void *value,
> +			     size_t size, int flags);
>  ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  			  char *buffer, size_t size);
>  int simple_xattr_add(struct simple_xattrs *xattrs,
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

