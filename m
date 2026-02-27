Return-Path: <linux-fsdevel+bounces-78721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMH8FOWuoWk3vgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:49:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F271B9373
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A01E30A08B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 14:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFE5429801;
	Fri, 27 Feb 2026 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q+sP/s9s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="51hEZ1If";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q+sP/s9s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="51hEZ1If"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA93841C2FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203724; cv=none; b=qZGrzE5N//DkIw9WrI1uD3rUWYQ3qDzUjjjWus9ILwPrbccQHCn3fdMEP+EXoxA9UG2MfViQHCucGgz0V2oJ4YlPoYSG/KNc6C/0ottWy1v3csS5/11/1qqdEB+aiDJqJId+jnqSiKS8CVYkLTywz2YX5cjaLPnPXA1EoK8zEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203724; c=relaxed/simple;
	bh=9tPqWDHNm/v0WOWEXxbEi/t3xtkCJxmqXF+rl1dqmTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiwokNjctlA7IlxerI/nCv1YTSlawQPG0HE91xoJQ6WzesKKCNpIJfSPsQvUmYaPjP9EPXgaR82aMauI1mJHvDHxV2fBFHAInKqMVkxG87v6acRwAmdELiq4ANRudvuNbdgXv9Bkfsoa2jYRrL5DkjfIimU2SdFXgNR49z83kEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q+sP/s9s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=51hEZ1If; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q+sP/s9s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=51hEZ1If; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04F5D6B000;
	Fri, 27 Feb 2026 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772203721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wX2h4vK/6rd+hYyyCXIMwVTcVaURZ/+fA3sex/OXutg=;
	b=Q+sP/s9sZX0qYMLjM1jaE67UpKAaBTeXbbRC8GIqWc25eHyIN2z5XuCrrT753nhBWn9d1g
	7CFT8vmthjFsrVlQuw6cGwB6nOZCPi4ynIybvTitU7XJeitBhFliUQpQViJ7EciMrrSdOk
	PVi1bJc2kxvZBvfr+dhVeSoFJLKYmY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772203721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wX2h4vK/6rd+hYyyCXIMwVTcVaURZ/+fA3sex/OXutg=;
	b=51hEZ1IfH1EiVtVGS2sRJfajbu8S8kXA1dfb9Q4odnmKU+Yoftg7CWkRAeXxEJEaJkXVr8
	S/jl2omsJ+c6YMAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772203721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wX2h4vK/6rd+hYyyCXIMwVTcVaURZ/+fA3sex/OXutg=;
	b=Q+sP/s9sZX0qYMLjM1jaE67UpKAaBTeXbbRC8GIqWc25eHyIN2z5XuCrrT753nhBWn9d1g
	7CFT8vmthjFsrVlQuw6cGwB6nOZCPi4ynIybvTitU7XJeitBhFliUQpQViJ7EciMrrSdOk
	PVi1bJc2kxvZBvfr+dhVeSoFJLKYmY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772203721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wX2h4vK/6rd+hYyyCXIMwVTcVaURZ/+fA3sex/OXutg=;
	b=51hEZ1IfH1EiVtVGS2sRJfajbu8S8kXA1dfb9Q4odnmKU+Yoftg7CWkRAeXxEJEaJkXVr8
	S/jl2omsJ+c6YMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED7C33EA69;
	Fri, 27 Feb 2026 14:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9C/zOciuoWlefgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 14:48:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A6038A06D4; Fri, 27 Feb 2026 15:48:40 +0100 (CET)
Date: Fri, 27 Feb 2026 15:48:40 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 03/14] shmem: adapt to rhashtable-based simple_xattrs
 with lazy allocation
Message-ID: <dbollbb6g6zmgos4qljt2763fncudcwqu3pndc6mmr4ljt4xqh@nszuzq4fep37>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-3-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-3-c2efa4f74cb7@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78721-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: A5F271B9373
X-Rspamd-Action: no action

On Mon 16-02-26 14:31:59, Christian Brauner wrote:
> Adapt tmpfs/shmem to use the rhashtable-based xattr path and switch
> from an embedded struct to pointer-based lazy allocation.
> 
> Change shmem_inode_info.xattrs from embedded 'struct simple_xattrs' to
> a pointer 'struct simple_xattrs *', initialized to NULL. This avoids
> the rhashtable overhead for every tmpfs inode, which helps when a lot of
> inodes exist.
> 
> The xattr store is allocated on first use:
> 
> - shmem_initxattrs(): Allocates via simple_xattrs_alloc() when
>   security modules set initial xattrs during inode creation.
> 
> - shmem_xattr_handler_set(): Allocates on first setxattr, with a
>   short-circuit for removal when no xattrs are stored yet.
> 
> All read paths (shmem_xattr_handler_get, shmem_listxattr) check for
> NULL xattrs pointer and return -ENODATA or 0 respectively.
> 
> Replaced xattr entries are freed via simple_xattr_free_rcu() to allow
> concurrent RCU readers to finish.
> 
> shmem_evict_inode() conditionally frees the xattr store only when
> allocated.
> 
> Also change simple_xattr_add() from void to int to propagate
> rhashtable insertion failures. shmem_initxattrs() is the only caller.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xattr.c               | 26 +++++++++++++-------------
>  include/linux/shmem_fs.h |  2 +-
>  include/linux/xattr.h    |  4 ++--
>  mm/shmem.c               | 44 +++++++++++++++++++++++++++++++-------------
>  4 files changed, 47 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 1d98ea459b7b..eb45ae0fd17f 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1677,19 +1677,19 @@ static bool rbtree_simple_xattr_less(struct rb_node *new_node,
>   * of matching xattrs is wanted. Should only be called during inode
>   * initialization when a few distinct initial xattrs are supposed to be set.
>   */
> -void simple_xattr_add(struct simple_xattrs *xattrs,
> -		      struct simple_xattr *new_xattr)
> -{
> -	if (xattrs->use_rhashtable) {
> -		WARN_ON(rhashtable_insert_fast(&xattrs->ht,
> -					       &new_xattr->hash_node,
> -					       simple_xattr_params));
> -	} else {
> -		write_lock(&xattrs->lock);
> -		rb_add(&new_xattr->rb_node, &xattrs->rb_root,
> -		       rbtree_simple_xattr_less);
> -		write_unlock(&xattrs->lock);
> -	}
> +int simple_xattr_add(struct simple_xattrs *xattrs,
> +		     struct simple_xattr *new_xattr)
> +{
> +	if (xattrs->use_rhashtable)
> +		return rhashtable_insert_fast(&xattrs->ht,
> +					      &new_xattr->hash_node,
> +					      simple_xattr_params);
> +
> +	write_lock(&xattrs->lock);
> +	rb_add(&new_xattr->rb_node, &xattrs->rb_root,
> +	       rbtree_simple_xattr_less);
> +	write_unlock(&xattrs->lock);
> +	return 0;
>  }
>  
>  /**
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index e2069b3179c4..53d325409a8b 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -48,7 +48,7 @@ struct shmem_inode_info {
>  	};
>  	struct timespec64	i_crtime;	/* file creation time */
>  	struct shared_policy	policy;		/* NUMA memory alloc policy */
> -	struct simple_xattrs	xattrs;		/* list of xattrs */
> +	struct simple_xattrs	*xattrs;	/* list of xattrs */
>  	pgoff_t			fallocend;	/* highest fallocate endindex */
>  	unsigned int		fsflags;	/* for FS_IOC_[SG]ETFLAGS */
>  	atomic_t		stop_eviction;	/* hold when working on inode */
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index ee4fd40717a0..3063ecf0004d 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -142,8 +142,8 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
>  				      size_t size, int flags);
>  ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  			  char *buffer, size_t size);
> -void simple_xattr_add(struct simple_xattrs *xattrs,
> -		      struct simple_xattr *new_xattr);
> +int simple_xattr_add(struct simple_xattrs *xattrs,
> +		     struct simple_xattr *new_xattr);
>  int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name);
>  
>  DEFINE_CLASS(simple_xattr,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index fc8020ce2e9f..8761c9b4f1c5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1426,7 +1426,10 @@ static void shmem_evict_inode(struct inode *inode)
>  		}
>  	}
>  
> -	simple_xattrs_free(&info->xattrs, sbinfo->max_inodes ? &freed : NULL);
> +	if (info->xattrs) {
> +		simple_xattrs_free(info->xattrs, sbinfo->max_inodes ? &freed : NULL);
> +		kfree(info->xattrs);
> +	}
>  	shmem_free_inode(inode->i_sb, freed);
>  	WARN_ON(inode->i_blocks);
>  	clear_inode(inode);
> @@ -3118,7 +3121,6 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>  		shmem_set_inode_flags(inode, info->fsflags, NULL);
>  	INIT_LIST_HEAD(&info->shrinklist);
>  	INIT_LIST_HEAD(&info->swaplist);
> -	simple_xattrs_init(&info->xattrs);
>  	cache_no_acl(inode);
>  	if (sbinfo->noswap)
>  		mapping_set_unevictable(inode->i_mapping);
> @@ -4270,10 +4272,13 @@ static int shmem_initxattrs(struct inode *inode,
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>  	const struct xattr *xattr;
> -	struct simple_xattr *new_xattr;
>  	size_t ispace = 0;
>  	size_t len;
>  
> +	CLASS(simple_xattrs, xattrs)();
> +	if (IS_ERR(xattrs))
> +		return PTR_ERR(xattrs);
> +
>  	if (sbinfo->max_inodes) {
>  		for (xattr = xattr_array; xattr->name != NULL; xattr++) {
>  			ispace += simple_xattr_space(xattr->name,
> @@ -4292,24 +4297,24 @@ static int shmem_initxattrs(struct inode *inode,
>  	}
>  
>  	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
> -		new_xattr = simple_xattr_alloc(xattr->value, xattr->value_len);
> +		CLASS(simple_xattr, new_xattr)(xattr->value, xattr->value_len);
>  		if (IS_ERR(new_xattr))
>  			break;
>  
>  		len = strlen(xattr->name) + 1;
>  		new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
>  					  GFP_KERNEL_ACCOUNT);
> -		if (!new_xattr->name) {
> -			kvfree(new_xattr);
> +		if (!new_xattr->name)
>  			break;
> -		}
>  
>  		memcpy(new_xattr->name, XATTR_SECURITY_PREFIX,
>  		       XATTR_SECURITY_PREFIX_LEN);
>  		memcpy(new_xattr->name + XATTR_SECURITY_PREFIX_LEN,
>  		       xattr->name, len);
>  
> -		simple_xattr_add(&info->xattrs, new_xattr);
> +		if (simple_xattr_add(xattrs, new_xattr))
> +			break;
> +		retain_and_null_ptr(new_xattr);
>  	}
>  
>  	if (xattr->name != NULL) {
> @@ -4318,10 +4323,10 @@ static int shmem_initxattrs(struct inode *inode,
>  			sbinfo->free_ispace += ispace;
>  			raw_spin_unlock(&sbinfo->stat_lock);
>  		}
> -		simple_xattrs_free(&info->xattrs, NULL);
>  		return -ENOMEM;
>  	}
>  
> +	smp_store_release(&info->xattrs, no_free_ptr(xattrs));
>  	return 0;
>  }
>  
> @@ -4330,9 +4335,14 @@ static int shmem_xattr_handler_get(const struct xattr_handler *handler,
>  				   const char *name, void *buffer, size_t size)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> +	struct simple_xattrs *xattrs;
> +
> +	xattrs = READ_ONCE(info->xattrs);
> +	if (!xattrs)
> +		return -ENODATA;
>  
>  	name = xattr_full_name(handler, name);
> -	return simple_xattr_get(&info->xattrs, name, buffer, size);
> +	return simple_xattr_get(xattrs, name, buffer, size);
>  }
>  
>  static int shmem_xattr_handler_set(const struct xattr_handler *handler,
> @@ -4343,10 +4353,16 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> +	struct simple_xattrs *xattrs;
>  	struct simple_xattr *old_xattr;
>  	size_t ispace = 0;
>  
>  	name = xattr_full_name(handler, name);
> +
> +	xattrs = simple_xattrs_lazy_alloc(&info->xattrs, value, flags);
> +	if (IS_ERR_OR_NULL(xattrs))
> +		return PTR_ERR(xattrs);
> +
>  	if (value && sbinfo->max_inodes) {
>  		ispace = simple_xattr_space(name, size);
>  		raw_spin_lock(&sbinfo->stat_lock);
> @@ -4359,13 +4375,13 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
>  			return -ENOSPC;
>  	}
>  
> -	old_xattr = simple_xattr_set(&info->xattrs, name, value, size, flags);
> +	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
>  	if (!IS_ERR(old_xattr)) {
>  		ispace = 0;
>  		if (old_xattr && sbinfo->max_inodes)
>  			ispace = simple_xattr_space(old_xattr->name,
>  						    old_xattr->size);
> -		simple_xattr_free(old_xattr);
> +		simple_xattr_free_rcu(old_xattr);
>  		old_xattr = NULL;
>  		inode_set_ctime_current(inode);
>  		inode_inc_iversion(inode);
> @@ -4406,7 +4422,9 @@ static const struct xattr_handler * const shmem_xattr_handlers[] = {
>  static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(d_inode(dentry));
> -	return simple_xattr_list(d_inode(dentry), &info->xattrs, buffer, size);
> +
> +	return simple_xattr_list(d_inode(dentry), READ_ONCE(info->xattrs),
> +				 buffer, size);
>  }
>  #endif /* CONFIG_TMPFS_XATTR */
>  
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

