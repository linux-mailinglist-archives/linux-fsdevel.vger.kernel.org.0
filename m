Return-Path: <linux-fsdevel+bounces-78724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFMeKOC0oWmMvgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:14:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E57B51B984C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE379314456E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8243C062;
	Fri, 27 Feb 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n4TpTiQo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="frjS/mKq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n4TpTiQo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="frjS/mKq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140D043C043
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204964; cv=none; b=dNJYvgkKVU/QYGaHC4Z6wAlcOYvXL5WX9gvlKZUhnWChnhCrK0Ede/P2OZEUQLH4xjaaWbKmsFaxXqiX2u3DHBfluNbb6EX2Sn6RMANF03huN+me5uYfi7jfiok7T9HVDpVfR8OXO1V3/qZSaEtL+os9pve2p1vqWfYaJ8DGIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204964; c=relaxed/simple;
	bh=9smuQxeW6OC2ywWonZqPlrsd1307vN8mZ2S7bE9T9Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTeQMMSWxa77ghE3lQX0bKxZK3CG4wgWXgLLhp1SJyanO6x2XLYONUaKXqyTJKI8Hvh3dCaFy6XhsMHmG9gs4YgdoK++zPp0ngCxMqTvYHAFJcKGZrFYPlGdSXAYNI45bC2B3755Qu1qLBVO5eaJQd7TuzdZL4AJjQUoRU4A0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n4TpTiQo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=frjS/mKq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n4TpTiQo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=frjS/mKq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 560223FA0D;
	Fri, 27 Feb 2026 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772204960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgC4TAut0oAE46fR5Ae6UByQ/Iym7IYeieMNOTiDBXU=;
	b=n4TpTiQo7AH/0uoo++HfsYLrlTXL8UK00zJUZSewWB+J9Xg/rbCYE6aWAksOV4N5aan7Fo
	kaSS8i+8J2EGIq9jijKgQgKPGK9Lm6G9CjT2msnz9SDkcvRWe04rmNHCF55M7si0ZnPElF
	Du4XWBE0zpoUUPa9Wd8ApwAtnDJs32M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772204960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgC4TAut0oAE46fR5Ae6UByQ/Iym7IYeieMNOTiDBXU=;
	b=frjS/mKqtQ041leJMmhBzqFTIWXixTqYMtKv1wh/jYW0R1WZiqPIdmGbbyC58w30PY6FeX
	mA2R3jREjsJnubBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n4TpTiQo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="frjS/mKq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772204960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgC4TAut0oAE46fR5Ae6UByQ/Iym7IYeieMNOTiDBXU=;
	b=n4TpTiQo7AH/0uoo++HfsYLrlTXL8UK00zJUZSewWB+J9Xg/rbCYE6aWAksOV4N5aan7Fo
	kaSS8i+8J2EGIq9jijKgQgKPGK9Lm6G9CjT2msnz9SDkcvRWe04rmNHCF55M7si0ZnPElF
	Du4XWBE0zpoUUPa9Wd8ApwAtnDJs32M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772204960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgC4TAut0oAE46fR5Ae6UByQ/Iym7IYeieMNOTiDBXU=;
	b=frjS/mKqtQ041leJMmhBzqFTIWXixTqYMtKv1wh/jYW0R1WZiqPIdmGbbyC58w30PY6FeX
	mA2R3jREjsJnubBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AA553EA69;
	Fri, 27 Feb 2026 15:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nLYzEqCzoWkAFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:09:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0818AA06D4; Fri, 27 Feb 2026 16:09:16 +0100 (CET)
Date: Fri, 27 Feb 2026 16:09:15 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 05/14] pidfs: adapt to rhashtable-based simple_xattrs
Message-ID: <qxctwu77wp7gv4ua3hn6kg7r2vt57laomn3ebjisemzzaybagy@mvoo2wpvu2ux>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-5-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-5-c2efa4f74cb7@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78724-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: E57B51B984C
X-Rspamd-Action: no action

On Mon 16-02-26 14:32:01, Christian Brauner wrote:
> Adapt pidfs to use the rhashtable-based xattr path by switching from a
> dedicated slab cache to simple_xattrs_alloc().
> 
> Previously pidfs used a custom kmem_cache (pidfs_xattr_cachep) that
> allocated a struct containing an embedded simple_xattrs plus
> simple_xattrs_init(). Replace this with simple_xattrs_alloc() which
> combines kzalloc + rhashtable_init, and drop the dedicated slab cache
> entirely.
> 
> Use simple_xattr_free_rcu() for replaced xattr entries to allow
> concurrent RCU readers to finish.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

One question below:

> +static LLIST_HEAD(pidfs_free_list);
> +
> +static void pidfs_free_attr_work(struct work_struct *work)
> +{
> +	struct pidfs_attr *attr, *next;
> +	struct llist_node *head;
> +
> +	head = llist_del_all(&pidfs_free_list);
> +	llist_for_each_entry_safe(attr, next, head, pidfs_llist) {
> +		struct simple_xattrs *xattrs = attr->xattrs;
> +
> +		if (xattrs) {
> +			simple_xattrs_free(xattrs, NULL);
> +			kfree(xattrs);
> +		}
> +		kfree(attr);
> +	}
> +}
> +
> +static DECLARE_WORK(pidfs_free_work, pidfs_free_attr_work);
> +

So you bother with postponing the freeing to a scheduled work because
put_pid() can be called from a context where acquiring rcu to iterate
rhashtable would not be possible? Frankly I have hard time imagining such
context (where previous rbtree code wouldn't have issues as well), in
particular because AFAIR rcu is safe to arbitrarily nest. What am I
missing?

								Honza


>  void pidfs_free_pid(struct pid *pid)
>  {
> -	struct pidfs_attr *attr __free(kfree) = no_free_ptr(pid->attr);
> -	struct simple_xattrs *xattrs __free(kfree) = NULL;
> +	struct pidfs_attr *attr = pid->attr;
>  
>  	/*
>  	 * Any dentry must've been wiped from the pid by now.
> @@ -169,9 +196,10 @@ void pidfs_free_pid(struct pid *pid)
>  	if (IS_ERR(attr))
>  		return;
>  
> -	xattrs = no_free_ptr(attr->xattrs);
> -	if (xattrs)
> -		simple_xattrs_free(xattrs, NULL);
> +	if (likely(!attr->xattrs))
> +		kfree(attr);
> +	else if (llist_add(&attr->pidfs_llist, &pidfs_free_list))
> +		schedule_work(&pidfs_free_work);
>  }
>  
>  #ifdef CONFIG_PROC_FS
> @@ -998,7 +1026,7 @@ static int pidfs_xattr_get(const struct xattr_handler *handler,
>  
>  	xattrs = READ_ONCE(attr->xattrs);
>  	if (!xattrs)
> -		return 0;
> +		return -ENODATA;
>  
>  	name = xattr_full_name(handler, suffix);
>  	return simple_xattr_get(xattrs, name, value, size);
> @@ -1018,22 +1046,16 @@ static int pidfs_xattr_set(const struct xattr_handler *handler,
>  	/* Ensure we're the only one to set @attr->xattrs. */
>  	WARN_ON_ONCE(!inode_is_locked(inode));
>  
> -	xattrs = READ_ONCE(attr->xattrs);
> -	if (!xattrs) {
> -		xattrs = kmem_cache_zalloc(pidfs_xattr_cachep, GFP_KERNEL);
> -		if (!xattrs)
> -			return -ENOMEM;
> -
> -		simple_xattrs_init(xattrs);
> -		smp_store_release(&pid->attr->xattrs, xattrs);
> -	}
> +	xattrs = simple_xattrs_lazy_alloc(&attr->xattrs, value, flags);
> +	if (IS_ERR_OR_NULL(xattrs))
> +		return PTR_ERR(xattrs);
>  
>  	name = xattr_full_name(handler, suffix);
>  	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
>  	if (IS_ERR(old_xattr))
>  		return PTR_ERR(old_xattr);
>  
> -	simple_xattr_free(old_xattr);
> +	simple_xattr_free_rcu(old_xattr);
>  	return 0;
>  }
>  
> @@ -1108,11 +1130,6 @@ void __init pidfs_init(void)
>  					 (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
>  					  SLAB_ACCOUNT | SLAB_PANIC), NULL);
>  
> -	pidfs_xattr_cachep = kmem_cache_create("pidfs_xattr_cache",
> -					       sizeof(struct simple_xattrs), 0,
> -					       (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
> -						SLAB_ACCOUNT | SLAB_PANIC), NULL);
> -
>  	pidfs_mnt = kern_mount(&pidfs_type);
>  	if (IS_ERR(pidfs_mnt))
>  		panic("Failed to mount pidfs pseudo filesystem");
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

