Return-Path: <linux-fsdevel+bounces-42654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C800A4587D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59293A4FE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835051E1DF6;
	Wed, 26 Feb 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmN5y6cE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C7258CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559019; cv=none; b=EV672EJkP50ZlBCmjnU5kLwW7Ii9KeFHhBR1MnLqqip0tBl38y+yjZfnG8w1hd/Xx/3HK4B7bKUD7teE7Ouk1LQnWJUzSRz4KYabUKtoPis9Ly9IF0N01m7CzPqVYAmvEVjH8YpRmZwUh9QQ1UA/BC/OpP7B9ep9s7OOPY/yEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559019; c=relaxed/simple;
	bh=e7EV4qiBTi/LdnvSl61Ond6t4HI5GKrI2L+IwDs1cH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpHKxPU4PK8IxzAwqRGq6hes0zrGvz09Z2EBmtosmOE6HVJwf+RrtrITiEm2l+l2H8r9hm61VAxi1B+FEXK/a0HKKwXsY1yc8l3uP7U1dwK4BGqQMsB0aSG9xSa4MyzJYUhncMSo9xWhSgzOF/uCs8pCyRBNhlahaUjqVqrPS5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmN5y6cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39EDC4CED6;
	Wed, 26 Feb 2025 08:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559018;
	bh=e7EV4qiBTi/LdnvSl61Ond6t4HI5GKrI2L+IwDs1cH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmN5y6cEat91Dusab+PDNQ4YmcmFWzDkbDH9IZcBZAaFYbSKiNz1XEMv9aZdJroDx
	 X7xppMIjyhz7yNyBYUYAYOWAYJ4Mt7LAK/QxTGOsf/watHTYJJjF67eF6KHY2cdGXz
	 CL0SrnisqkdQBMo2vqLkGj5+t57cM6ySL4mgnu+WtorTS6oYi0Ic4a7Dx2vkRXtzSQ
	 08jktzdYC+BHSpO3O406LXlPkhJ/H0+ouiUXI3vfSHf2d7OB07I/TplSgo53GYV6Fp
	 nq9gZ9l0S+yZMaH1OkbjWeLfFDrh1V/IPYMJ4lKFY6CJ9Jmdp/plVIWRXXKpyEYMI2
	 F2ctLfFvhtHrA==
Date: Wed, 26 Feb 2025 09:36:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 10/21] d_alloc_parallel(): set DCACHE_PAR_LOOKUP earlier
Message-ID: <20250226-argument-silbentrennung-9bba44830c11@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-10-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:40PM +0000, Al Viro wrote:
> Do that before new dentry is visible anywhere.  It does create
> a new possible state for dentries present in ->d_children/->d_sib -
> DCACHE_PAR_LOOKUP present, negative, unhashed, not in in-lookup
> hash chains, refcount positive.  Those are going to be skipped
> by all tree-walkers (both d_walk() callbacks in fs/dcache.c and
> explicit loops over children/sibling lists elsewhere) and
> dput() is fine with those.
> 
> NOTE: dropping the final reference to a "normal" in-lookup dentry
> (in in-lookup hash) is a bug - somebody must've forgotten to
> call d_lookup_done() on it and bad things will happen.  With those
> it's OK; if/when we get around to making __dentry_kill() complain
> about such breakage, remember that predicate to check should
> *not* be just d_in_lookup(victim) but rather a combination of that
> with hlist_bl_unhashed(&victim->d_u.d_in_lookup_hash).  Might
> be worth to consider later...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/dcache.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 29db27228d97..9ad7cbb5a6b0 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2518,13 +2518,19 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  	unsigned int hash = name->hash;
>  	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
>  	struct hlist_bl_node *node;
> -	struct dentry *new = d_alloc(parent, name);
> +	struct dentry *new = __d_alloc(parent->d_sb, name);
>  	struct dentry *dentry;
>  	unsigned seq, r_seq, d_seq;
>  
>  	if (unlikely(!new))
>  		return ERR_PTR(-ENOMEM);

This is minor but it would be clearer if the __d_alloc() call was placed
directly above the error handling.

>  
> +	new->d_flags |= DCACHE_PAR_LOOKUP;
> +	spin_lock(&parent->d_lock);
> +	new->d_parent = dget_dlock(parent);
> +	hlist_add_head(&new->d_sib, &parent->d_children);
> +	spin_unlock(&parent->d_lock);
> +
>  retry:
>  	rcu_read_lock();
>  	seq = smp_load_acquire(&parent->d_inode->i_dir_seq);
> @@ -2608,8 +2614,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  		return dentry;
>  	}
>  	rcu_read_unlock();
> -	/* we can't take ->d_lock here; it's OK, though. */
> -	new->d_flags |= DCACHE_PAR_LOOKUP;
>  	new->d_wait = wq;
>  	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
>  	hlist_bl_unlock(b);
> -- 
> 2.39.5
> 

