Return-Path: <linux-fsdevel+bounces-78726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LE2OnG2oWnmvwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:21:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D441B9A6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E452B30DF84E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A3D439009;
	Fri, 27 Feb 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJEhBcIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e1GAulZA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJEhBcIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e1GAulZA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0754043636C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205283; cv=none; b=KjGvb5a74dKof8FPaGKqOxU3j1y44r+glCeEWrpn17jcoBsjxDEjArxORheeq7i6OWuIEOUhjpcsogadX6tQTVjZUCnwqddqsk3PyzG4tFuVrcKpJQYGDybrEKHZmfEJ8Uvj9Vx3CsvbAbYBV1I9/UA1IwMGsg29ieE6YjndYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205283; c=relaxed/simple;
	bh=tcGhUcOW1hFQqe00HoYFk6NpgZlM8V/8SFqIKDEtElQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPWSCjdXhfUehH/dIkfeFtLmrUMYkd6uO3DZWe0WQnaptzcje7meETtOnS/fIEHnVVHppshXA0WW9uZ8q2QJWNa7uf2PJinssKwPHnlS/jCs4qdP+tyi+fBqk9rhfBnuVxeN90zpW3Y4neKRdK4sAUmgf5CW/YcjpxhETanvqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZJEhBcIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e1GAulZA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZJEhBcIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e1GAulZA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65CE75D1FA;
	Fri, 27 Feb 2026 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrIsEzH/SWi9NgwQLQ/HiS6/vexz9nBmzCUpEg8O+l8=;
	b=ZJEhBcIWi21aLUjV4+gdNSfqCM9+vflLqU6QjpSwpqznx0yaMlmHEy+MHTZbwax8KMod71
	m5G5NUmW7TZEjxaVCkaE1Tm4bmlKl9SXw8vsz3drGVVSeOnodwIC9QBTWEy/w+UMIg3QIh
	9eYNzbP1VxnR5mCKATfp9yhKR3s0zI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrIsEzH/SWi9NgwQLQ/HiS6/vexz9nBmzCUpEg8O+l8=;
	b=e1GAulZA0vnGK5Tnjx4RFuuJojyVwwsn0T3UvDv1WQwBtzomf3xpNbOI8qOsAd9mqMM/x3
	QDn3fHA78UzcXUBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772205279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrIsEzH/SWi9NgwQLQ/HiS6/vexz9nBmzCUpEg8O+l8=;
	b=ZJEhBcIWi21aLUjV4+gdNSfqCM9+vflLqU6QjpSwpqznx0yaMlmHEy+MHTZbwax8KMod71
	m5G5NUmW7TZEjxaVCkaE1Tm4bmlKl9SXw8vsz3drGVVSeOnodwIC9QBTWEy/w+UMIg3QIh
	9eYNzbP1VxnR5mCKATfp9yhKR3s0zI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772205279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrIsEzH/SWi9NgwQLQ/HiS6/vexz9nBmzCUpEg8O+l8=;
	b=e1GAulZA0vnGK5Tnjx4RFuuJojyVwwsn0T3UvDv1WQwBtzomf3xpNbOI8qOsAd9mqMM/x3
	QDn3fHA78UzcXUBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 528843EA69;
	Fri, 27 Feb 2026 15:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZfslFN+0oWl0GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:14:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E987EA06D4; Fri, 27 Feb 2026 16:14:34 +0100 (CET)
Date: Fri, 27 Feb 2026 16:14:34 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 06/14] xattr: remove rbtree-based simple_xattr
 infrastructure
Message-ID: <p6u2ed73w5cqbajpwf6c3sl7xxcedfpkddtu7sacdv3g7gpucq@lpynytzfrljn>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-6-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-6-c2efa4f74cb7@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78726-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 66D441B9A6A
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:02, Christian Brauner wrote:
> Now that all consumers (shmem, kernfs, pidfs) have been converted to
> use the rhashtable-based simple_xattrs with pointer-based lazy
> allocation, remove the legacy rbtree code path. The rhashtable
> implementation provides O(1) average-case lookup with RCU-based lockless
> reads, replacing the O(log n) rbtree with reader-writer spinlock
> contention.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xattr.c            | 387 +++++++++++++-------------------------------------
>  include/linux/xattr.h |  12 +-
>  2 files changed, 103 insertions(+), 296 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index eb45ae0fd17f..64803097e1dc 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1200,20 +1200,18 @@ void simple_xattr_free(struct simple_xattr *xattr)
>  
>  static void simple_xattr_rcu_free(struct rcu_head *head)
>  {
> -	struct simple_xattr *xattr;
> +	struct simple_xattr *xattr = container_of(head, struct simple_xattr, rcu);
>  
> -	xattr = container_of(head, struct simple_xattr, rcu);
>  	simple_xattr_free(xattr);
>  }
>  
>  /**
> - * simple_xattr_free_rcu - free an xattr object after an RCU grace period
> + * simple_xattr_free_rcu - free an xattr object with RCU delay
>   * @xattr: the xattr object
>   *
> - * Schedule RCU-deferred freeing of an xattr entry. This is used by
> - * rhashtable-based callers of simple_xattr_set() that replace or remove
> - * an existing entry while concurrent RCU readers may still be accessing
> - * it.
> + * Free the xattr object after an RCU grace period. This must be used when
> + * the xattr was removed from a data structure that concurrent RCU readers
> + * may still be traversing. Can handle @xattr being NULL.
>   */
>  void simple_xattr_free_rcu(struct simple_xattr *xattr)
>  {
> @@ -1254,43 +1252,6 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  	return new_xattr;
>  }
>  
> -/**
> - * rbtree_simple_xattr_cmp - compare xattr name with current rbtree xattr entry
> - * @key: xattr name
> - * @node: current node
> - *
> - * Compare the xattr name with the xattr name attached to @node in the rbtree.
> - *
> - * Return: Negative value if continuing left, positive if continuing right, 0
> - * if the xattr attached to @node matches @key.
> - */
> -static int rbtree_simple_xattr_cmp(const void *key, const struct rb_node *node)
> -{
> -	const char *xattr_name = key;
> -	const struct simple_xattr *xattr;
> -
> -	xattr = rb_entry(node, struct simple_xattr, rb_node);
> -	return strcmp(xattr->name, xattr_name);
> -}
> -
> -/**
> - * rbtree_simple_xattr_node_cmp - compare two xattr rbtree nodes
> - * @new_node: new node
> - * @node: current node
> - *
> - * Compare the xattr attached to @new_node with the xattr attached to @node.
> - *
> - * Return: Negative value if continuing left, positive if continuing right, 0
> - * if the xattr attached to @new_node matches the xattr attached to @node.
> - */
> -static int rbtree_simple_xattr_node_cmp(struct rb_node *new_node,
> -					const struct rb_node *node)
> -{
> -	struct simple_xattr *xattr;
> -	xattr = rb_entry(new_node, struct simple_xattr, rb_node);
> -	return rbtree_simple_xattr_cmp(xattr->name, node);
> -}
> -
>  static u32 simple_xattr_hashfn(const void *data, u32 len, u32 seed)
>  {
>  	const char *name = data;
> @@ -1336,41 +1297,19 @@ static const struct rhashtable_params simple_xattr_params = {
>  int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  		     void *buffer, size_t size)
>  {
> -	struct simple_xattr *xattr = NULL;
> +	struct simple_xattr *xattr;
>  	int ret = -ENODATA;
>  
> -	if (xattrs->use_rhashtable) {
> -		guard(rcu)();
> -		xattr = rhashtable_lookup(&xattrs->ht, name,
> -					  simple_xattr_params);
> -		if (xattr) {
> -			ret = xattr->size;
> -			if (buffer) {
> -				if (size < xattr->size)
> -					ret = -ERANGE;
> -				else
> -					memcpy(buffer, xattr->value,
> -					       xattr->size);
> -			}
> -		}
> -	} else {
> -		struct rb_node *rbp;
> -
> -		read_lock(&xattrs->lock);
> -		rbp = rb_find(name, &xattrs->rb_root,
> -			      rbtree_simple_xattr_cmp);
> -		if (rbp) {
> -			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> -			ret = xattr->size;
> -			if (buffer) {
> -				if (size < xattr->size)
> -					ret = -ERANGE;
> -				else
> -					memcpy(buffer, xattr->value,
> -					       xattr->size);
> -			}
> +	guard(rcu)();
> +	xattr = rhashtable_lookup(&xattrs->ht, name, simple_xattr_params);
> +	if (xattr) {
> +		ret = xattr->size;
> +		if (buffer) {
> +			if (size < xattr->size)
> +				ret = -ERANGE;
> +			else
> +				memcpy(buffer, xattr->value, xattr->size);
>  		}
> -		read_unlock(&xattrs->lock);
>  	}
>  	return ret;
>  }
> @@ -1398,6 +1337,11 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>   * nothing if XATTR_CREATE is specified in @flags or @flags is zero. For
>   * XATTR_REPLACE we fail as mentioned above.
>   *
> + * Note: Callers must externally serialize writes. All current callers hold
> + * the inode lock for write operations. The lookup->replace/remove sequence
> + * is not atomic with respect to the rhashtable's per-bucket locking, but
> + * is safe because writes are serialized by the caller.
> + *
>   * Return: On success, the removed or replaced xattr is returned, to be freed
>   * by the caller; or NULL if none. On failure a negative error code is returned.
>   */
> @@ -1406,7 +1350,7 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
>  				      size_t size, int flags)
>  {
>  	struct simple_xattr *old_xattr = NULL;
> -	int err = 0;
> +	int err;
>  
>  	CLASS(simple_xattr, new_xattr)(value, size);
>  	if (IS_ERR(new_xattr))
> @@ -1418,119 +1362,52 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
>  			return ERR_PTR(-ENOMEM);
>  	}
>  
> -	if (xattrs->use_rhashtable) {
> -		/*
> -		 * Lookup is safe without RCU here since writes are
> -		 * serialized by the caller.
> -		 */
> -		old_xattr = rhashtable_lookup_fast(&xattrs->ht, name,
> -						   simple_xattr_params);
> -
> -		if (old_xattr) {
> -			/* Fail if XATTR_CREATE is requested and the xattr exists. */
> -			if (flags & XATTR_CREATE)
> -				return ERR_PTR(-EEXIST);
> -
> -			if (new_xattr) {
> -				err = rhashtable_replace_fast(&xattrs->ht,
> -							     &old_xattr->hash_node,
> -							     &new_xattr->hash_node,
> -							     simple_xattr_params);
> -				if (err)
> -					return ERR_PTR(err);
> -			} else {
> -				err = rhashtable_remove_fast(&xattrs->ht,
> -							    &old_xattr->hash_node,
> -							    simple_xattr_params);
> -				if (err)
> -					return ERR_PTR(err);
> -			}
> -		} else {
> -			/* Fail if XATTR_REPLACE is requested but no xattr is found. */
> -			if (flags & XATTR_REPLACE)
> -				return ERR_PTR(-ENODATA);
> -
> -			/*
> -			 * If XATTR_CREATE or no flags are specified together
> -			 * with a new value simply insert it.
> -			 */
> -			if (new_xattr) {
> -				err = rhashtable_insert_fast(&xattrs->ht,
> -							    &new_xattr->hash_node,
> -							    simple_xattr_params);
> -				if (err)
> -					return ERR_PTR(err);
> -			}
> -
> -			/*
> -			 * If XATTR_CREATE or no flags are specified and
> -			 * neither an old or new xattr exist then we don't
> -			 * need to do anything.
> -			 */
> -		}
> -	} else {
> -		struct rb_node *parent = NULL, **rbp;
> -		int ret;
> -
> -		write_lock(&xattrs->lock);
> -		rbp = &xattrs->rb_root.rb_node;
> -		while (*rbp) {
> -			parent = *rbp;
> -			ret = rbtree_simple_xattr_cmp(name, *rbp);
> -			if (ret < 0)
> -				rbp = &(*rbp)->rb_left;
> -			else if (ret > 0)
> -				rbp = &(*rbp)->rb_right;
> -			else
> -				old_xattr = rb_entry(*rbp, struct simple_xattr,
> -						     rb_node);
> -			if (old_xattr)
> -				break;
> -		}
> +	/* Lookup is safe without RCU here since writes are serialized. */
> +	old_xattr = rhashtable_lookup_fast(&xattrs->ht, name,
> +					   simple_xattr_params);
>  
> -		if (old_xattr) {
> -			/* Fail if XATTR_CREATE is requested and the xattr exists. */
> -			if (flags & XATTR_CREATE) {
> -				err = -EEXIST;
> -				goto out_unlock;
> -			}
> +	if (old_xattr) {
> +		/* Fail if XATTR_CREATE is requested and the xattr exists. */
> +		if (flags & XATTR_CREATE)
> +			return ERR_PTR(-EEXIST);
>  
> -			if (new_xattr)
> -				rb_replace_node(&old_xattr->rb_node,
> -						&new_xattr->rb_node,
> -						&xattrs->rb_root);
> -			else
> -				rb_erase(&old_xattr->rb_node,
> -					 &xattrs->rb_root);
> +		if (new_xattr) {
> +			err = rhashtable_replace_fast(&xattrs->ht,
> +						      &old_xattr->hash_node,
> +						      &new_xattr->hash_node,
> +						      simple_xattr_params);
> +			if (err)
> +				return ERR_PTR(err);
>  		} else {
> -			/* Fail if XATTR_REPLACE is requested but no xattr is found. */
> -			if (flags & XATTR_REPLACE) {
> -				err = -ENODATA;
> -				goto out_unlock;
> -			}
> -
> -			/*
> -			 * If XATTR_CREATE or no flags are specified together
> -			 * with a new value simply insert it.
> -			 */
> -			if (new_xattr) {
> -				rb_link_node(&new_xattr->rb_node, parent, rbp);
> -				rb_insert_color(&new_xattr->rb_node,
> -						&xattrs->rb_root);
> -			}
> +			err = rhashtable_remove_fast(&xattrs->ht,
> +						     &old_xattr->hash_node,
> +						     simple_xattr_params);
> +			if (err)
> +				return ERR_PTR(err);
> +		}
> +	} else {
> +		/* Fail if XATTR_REPLACE is requested but no xattr is found. */
> +		if (flags & XATTR_REPLACE)
> +			return ERR_PTR(-ENODATA);
>  
> -			/*
> -			 * If XATTR_CREATE or no flags are specified and
> -			 * neither an old or new xattr exist then we don't
> -			 * need to do anything.
> -			 */
> +		/*
> +		 * If XATTR_CREATE or no flags are specified together with a
> +		 * new value simply insert it.
> +		 */
> +		if (new_xattr) {
> +			err = rhashtable_insert_fast(&xattrs->ht,
> +						     &new_xattr->hash_node,
> +						     simple_xattr_params);
> +			if (err)
> +				return ERR_PTR(err);
>  		}
>  
> -out_unlock:
> -		write_unlock(&xattrs->lock);
> -		if (err)
> -			return ERR_PTR(err);
> +		/*
> +		 * If XATTR_CREATE or no flags are specified and neither an
> +		 * old or new xattr exist then we don't need to do anything.
> +		 */
>  	}
> +
>  	retain_and_null_ptr(new_xattr);
>  	return old_xattr;
>  }
> @@ -1572,6 +1449,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  			  char *buffer, size_t size)
>  {
>  	bool trusted = ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
> +	struct rhashtable_iter iter;
>  	struct simple_xattr *xattr;
>  	ssize_t remaining_size = size;
>  	int err = 0;
> @@ -1595,77 +1473,34 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  	if (!xattrs)
>  		return size - remaining_size;
>  
> -	if (xattrs->use_rhashtable) {
> -		struct rhashtable_iter iter;
> -
> -		rhashtable_walk_enter(&xattrs->ht, &iter);
> -		rhashtable_walk_start(&iter);
> -
> -		while ((xattr = rhashtable_walk_next(&iter)) != NULL) {
> -			if (IS_ERR(xattr)) {
> -				if (PTR_ERR(xattr) == -EAGAIN)
> -					continue;
> -				err = PTR_ERR(xattr);
> -				break;
> -			}
> -
> -			/* skip "trusted." attributes for unprivileged callers */
> -			if (!trusted && xattr_is_trusted(xattr->name))
> -				continue;
> +	rhashtable_walk_enter(&xattrs->ht, &iter);
> +	rhashtable_walk_start(&iter);
>  
> -			/* skip MAC labels; these are provided by LSM above */
> -			if (xattr_is_maclabel(xattr->name))
> +	while ((xattr = rhashtable_walk_next(&iter)) != NULL) {
> +		if (IS_ERR(xattr)) {
> +			if (PTR_ERR(xattr) == -EAGAIN)
>  				continue;
> -
> -			err = xattr_list_one(&buffer, &remaining_size,
> -					     xattr->name);
> -			if (err)
> -				break;
> +			err = PTR_ERR(xattr);
> +			break;
>  		}
>  
> -		rhashtable_walk_stop(&iter);
> -		rhashtable_walk_exit(&iter);
> -	} else {
> -		struct rb_node *rbp;
> -
> -		read_lock(&xattrs->lock);
> -		for (rbp = rb_first(&xattrs->rb_root); rbp;
> -		     rbp = rb_next(rbp)) {
> -			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> -
> -			/* skip "trusted." attributes for unprivileged callers */
> -			if (!trusted && xattr_is_trusted(xattr->name))
> -				continue;
> +		/* skip "trusted." attributes for unprivileged callers */
> +		if (!trusted && xattr_is_trusted(xattr->name))
> +			continue;
>  
> -			/* skip MAC labels; these are provided by LSM above */
> -			if (xattr_is_maclabel(xattr->name))
> -				continue;
> +		/* skip MAC labels; these are provided by LSM above */
> +		if (xattr_is_maclabel(xattr->name))
> +			continue;
>  
> -			err = xattr_list_one(&buffer, &remaining_size,
> -					     xattr->name);
> -			if (err)
> -				break;
> -		}
> -		read_unlock(&xattrs->lock);
> +		err = xattr_list_one(&buffer, &remaining_size, xattr->name);
> +		if (err)
> +			break;
>  	}
>  
> -	return err ? err : size - remaining_size;
> -}
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);
>  
> -/**
> - * rbtree_simple_xattr_less - compare two xattr rbtree nodes
> - * @new_node: new node
> - * @node: current node
> - *
> - * Compare the xattr attached to @new_node with the xattr attached to @node.
> - * Note that this function technically tolerates duplicate entries.
> - *
> - * Return: True if insertion point in the rbtree is found.
> - */
> -static bool rbtree_simple_xattr_less(struct rb_node *new_node,
> -				     const struct rb_node *node)
> -{
> -	return rbtree_simple_xattr_node_cmp(new_node, node) < 0;
> +	return err ? err : size - remaining_size;
>  }
>  
>  /**
> @@ -1676,33 +1511,29 @@ static bool rbtree_simple_xattr_less(struct rb_node *new_node,
>   * Add an xattr object to @xattrs. This assumes no replacement or removal
>   * of matching xattrs is wanted. Should only be called during inode
>   * initialization when a few distinct initial xattrs are supposed to be set.
> + *
> + * Return: On success zero is returned. On failure a negative error code is
> + * returned.
>   */
>  int simple_xattr_add(struct simple_xattrs *xattrs,
>  		     struct simple_xattr *new_xattr)
>  {
> -	if (xattrs->use_rhashtable)
> -		return rhashtable_insert_fast(&xattrs->ht,
> -					      &new_xattr->hash_node,
> -					      simple_xattr_params);
> -
> -	write_lock(&xattrs->lock);
> -	rb_add(&new_xattr->rb_node, &xattrs->rb_root,
> -	       rbtree_simple_xattr_less);
> -	write_unlock(&xattrs->lock);
> -	return 0;
> +	return rhashtable_insert_fast(&xattrs->ht, &new_xattr->hash_node,
> +				      simple_xattr_params);
>  }
>  
>  /**
>   * simple_xattrs_init - initialize new xattr header
>   * @xattrs: header to initialize
>   *
> - * Initialize relevant fields of a an xattr header.
> + * Initialize the rhashtable used to store xattr objects.
> + *
> + * Return: On success zero is returned. On failure a negative error code is
> + * returned.
>   */
> -void simple_xattrs_init(struct simple_xattrs *xattrs)
> +int simple_xattrs_init(struct simple_xattrs *xattrs)
>  {
> -	xattrs->use_rhashtable = false;
> -	xattrs->rb_root = RB_ROOT;
> -	rwlock_init(&xattrs->lock);
> +	return rhashtable_init(&xattrs->ht, &simple_xattr_params);
>  }
>  
>  /**
> @@ -1710,7 +1541,8 @@ void simple_xattrs_init(struct simple_xattrs *xattrs)
>   *
>   * Dynamically allocate a simple_xattrs header and initialize the
>   * underlying rhashtable. This is intended for consumers that want
> - * rhashtable-based xattr storage.
> + * to lazily allocate xattr storage only when the first xattr is set,
> + * avoiding the per-inode rhashtable overhead when no xattrs are used.
>   *
>   * Return: On success a new simple_xattrs is returned. On failure an
>   * ERR_PTR is returned.
> @@ -1718,14 +1550,15 @@ void simple_xattrs_init(struct simple_xattrs *xattrs)
>  struct simple_xattrs *simple_xattrs_alloc(void)
>  {
>  	struct simple_xattrs *xattrs __free(kfree) = NULL;
> +	int ret;
>  
>  	xattrs = kzalloc(sizeof(*xattrs), GFP_KERNEL);
>  	if (!xattrs)
>  		return ERR_PTR(-ENOMEM);
>  
> -	xattrs->use_rhashtable = true;
> -	if (rhashtable_init(&xattrs->ht, &simple_xattr_params))
> -		return ERR_PTR(-ENOMEM);
> +	ret = simple_xattrs_init(xattrs);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
>  	return no_free_ptr(xattrs);
>  }
> @@ -1784,28 +1617,10 @@ static void simple_xattr_ht_free(void *ptr, void *arg)
>   */
>  void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space)
>  {
> +	might_sleep();
> +
>  	if (freed_space)
>  		*freed_space = 0;
> -
> -	if (xattrs->use_rhashtable) {
> -		rhashtable_free_and_destroy(&xattrs->ht,
> -					    simple_xattr_ht_free, freed_space);
> -	} else {
> -		struct rb_node *rbp;
> -
> -		rbp = rb_first(&xattrs->rb_root);
> -		while (rbp) {
> -			struct simple_xattr *xattr;
> -			struct rb_node *rbp_next;
> -
> -			rbp_next = rb_next(rbp);
> -			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> -			rb_erase(&xattr->rb_node, &xattrs->rb_root);
> -			if (freed_space)
> -				*freed_space += simple_xattr_space(xattr->name,
> -								   xattr->size);
> -			simple_xattr_free(xattr);
> -			rbp = rbp_next;
> -		}
> -	}
> +	rhashtable_free_and_destroy(&xattrs->ht, simple_xattr_ht_free,
> +				    freed_space);
>  }
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 3063ecf0004d..f60357d9f938 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -107,18 +107,10 @@ static inline const char *xattr_prefix(const struct xattr_handler *handler)
>  }
>  
>  struct simple_xattrs {
> -	bool use_rhashtable;
> -	union {
> -		struct {
> -			struct rb_root rb_root;
> -			rwlock_t lock;
> -		};
> -		struct rhashtable ht;
> -	};
> +	struct rhashtable ht;
>  };
>  
>  struct simple_xattr {
> -	struct rb_node rb_node;
>  	struct rhash_head hash_node;
>  	struct rcu_head rcu;
>  	char *name;
> @@ -126,7 +118,7 @@ struct simple_xattr {
>  	char value[];
>  };
>  
> -void simple_xattrs_init(struct simple_xattrs *xattrs);
> +int simple_xattrs_init(struct simple_xattrs *xattrs);
>  struct simple_xattrs *simple_xattrs_alloc(void);
>  struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
>  					       const void *value, int flags);
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

