Return-Path: <linux-fsdevel+bounces-42646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E2BA4582B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C246116C85C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61F21ABB6;
	Wed, 26 Feb 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYV+e2s7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2F1E1DEC
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558511; cv=none; b=dffz9hYpjR1sdXczYdwCye6xuu4tpJxtG0r16NaNqJFcYMUWvxsoBkakAft4WzCZIrD271r24kGMU2SyQev8XxzNYaTfxMM+m+lIJfNSe9tgF+WSnCd45nKrQ0S+EATdwbxx/TB3IRSuHhT16ttlDN4kD348Sv5CGZgBffaDiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558511; c=relaxed/simple;
	bh=X5Zy3n9BEVjWbcaD2bsrrMQihAerDcSSz+e+d1/wn/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF+HWvjc28BL9VfRXnjDI6UWKibPpX74+ocr2R8ek9+1mQUCPcjeiV4/K/8bZMSyANKv0HUOAHQ7GC2P4IAGwAmNyB9c1lHC+9+xsnfCFu41GhJFhmB/3NLeSZG4ZCtiyreQcyCvrxkmmm4WM63r38FHxEw+x9tj6R6YrjKQsN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYV+e2s7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A87C4CED6;
	Wed, 26 Feb 2025 08:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558511;
	bh=X5Zy3n9BEVjWbcaD2bsrrMQihAerDcSSz+e+d1/wn/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYV+e2s7c7t54EwPqqPedn7hs4NegCT/eAy3Ti8SdSaxYSPf6HOjFj3+aseWt7TOS
	 MKEwEStxeRmdwiy6+7xRjwJ9s7wyYmo94KCsHFRSbw0Q0iWJXxJoF6iB4aoyzJvyoc
	 rwzP7CTI6UUQJFwE7fY4EnUil7hf98DUllbbxe2HjKOiesdXBlboTXO6ryDA7ZbFDX
	 qeK+8yvOuN63qImKHuVKbjuTRd17GOjm+TfEPTL0B1Jru4E0OTInBOD/4ldan1A9w9
	 HDf1lMt8Hjz5BZG8PpUicqjMsQueGnGvH1AfcdMIIIpi+qCEwhQNPLOQaDWiqH8xU9
	 rBpRRB5X9DTww==
Date: Wed, 26 Feb 2025 09:28:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 02/21] new helper: d_splice_alias_ops()
Message-ID: <20250226-qualm-auspuff-421e62f9e666@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-2-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:32PM +0000, Al Viro wrote:
> Uses of d_set_d_op() on live dentry can be very dangerous; it is going
> to be withdrawn and replaced with saner things.
> 
> The best way for a filesystem is to have the default dentry_operations
> set at mount time and be done with that - __d_alloc() will use that.
> 
> Currently there are two cases when d_set_d_op() is used on a live dentry -
> one is procfs, which has several genuinely different dentry_operations
> instances (different ->d_revalidate(), etc.) and another is
> simple_lookup(), where we would be better off without overriding ->d_op.
> 
> For procfs we have d_set_d_op() calls followed by d_splice_alias();
> provide a new helper (d_splice_alias_ops(inode, dentry, d_ops)) that would
> combine those two, and do the d_set_d_op() part while under ->d_lock.
> That eliminates one of the places where ->d_flags had been modified
> without holding ->d_lock; current behaviour is not racy, but the reasons
> for that are far too brittle.  Better move to uniform locking rules and
> simpler proof of correctness...
> 
> The next commit will convert procfs to use of that helper; it is not
> exported and won't be until somebody comes up with convincing modular
> user for it.
> 
> Again, the best approach is to have default ->d_op and let __d_alloc()
> do the right thing; filesystem _may_ need non-uniform ->d_op (procfs
> does), but there'd better be good reasons for that.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/dcache.c            | 63 ++++++++++++++++++++++++------------------
>  include/linux/dcache.h |  3 ++
>  2 files changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index e3634916ffb9..c85efbda133a 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2641,7 +2641,8 @@ EXPORT_SYMBOL(__d_lookup_unhash_wake);
>  
>  /* inode->i_lock held if inode is non-NULL */
>  
> -static inline void __d_add(struct dentry *dentry, struct inode *inode)
> +static inline void __d_add(struct dentry *dentry, struct inode *inode,
> +			   const struct dentry_operations *ops)
>  {
>  	wait_queue_head_t *d_wait;
>  	struct inode *dir = NULL;
> @@ -2652,6 +2653,8 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
>  		n = start_dir_add(dir);
>  		d_wait = __d_lookup_unhash(dentry);
>  	}
> +	if (unlikely(ops))
> +		d_set_d_op(dentry, ops);
>  	if (inode) {
>  		unsigned add_flags = d_flags_for_inode(inode);
>  		hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
> @@ -2683,7 +2686,7 @@ void d_add(struct dentry *entry, struct inode *inode)
>  		security_d_instantiate(entry, inode);
>  		spin_lock(&inode->i_lock);
>  	}
> -	__d_add(entry, inode);
> +	__d_add(entry, inode, NULL);
>  }
>  EXPORT_SYMBOL(d_add);
>  
> @@ -2981,30 +2984,8 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
>  	return ret;
>  }
>  
> -/**
> - * d_splice_alias - splice a disconnected dentry into the tree if one exists
> - * @inode:  the inode which may have a disconnected dentry
> - * @dentry: a negative dentry which we want to point to the inode.
> - *
> - * If inode is a directory and has an IS_ROOT alias, then d_move that in
> - * place of the given dentry and return it, else simply d_add the inode
> - * to the dentry and return NULL.
> - *
> - * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
> - * we should error out: directories can't have multiple aliases.
> - *
> - * This is needed in the lookup routine of any filesystem that is exportable
> - * (via knfsd) so that we can build dcache paths to directories effectively.
> - *
> - * If a dentry was found and moved, then it is returned.  Otherwise NULL
> - * is returned.  This matches the expected return value of ->lookup.
> - *
> - * Cluster filesystems may call this function with a negative, hashed dentry.
> - * In that case, we know that the inode will be a regular file, and also this
> - * will only occur during atomic_open. So we need to check for the dentry
> - * being already hashed only in the final case.
> - */
> -struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
> +struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
> +				  const struct dentry_operations *ops)
>  {
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
> @@ -3050,9 +3031,37 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
>  		}
>  	}
>  out:
> -	__d_add(dentry, inode);
> +	__d_add(dentry, inode, ops);
>  	return NULL;
>  }
> +
> +/**
> + * d_splice_alias - splice a disconnected dentry into the tree if one exists
> + * @inode:  the inode which may have a disconnected dentry
> + * @dentry: a negative dentry which we want to point to the inode.
> + *
> + * If inode is a directory and has an IS_ROOT alias, then d_move that in
> + * place of the given dentry and return it, else simply d_add the inode
> + * to the dentry and return NULL.
> + *
> + * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
> + * we should error out: directories can't have multiple aliases.
> + *
> + * This is needed in the lookup routine of any filesystem that is exportable
> + * (via knfsd) so that we can build dcache paths to directories effectively.
> + *
> + * If a dentry was found and moved, then it is returned.  Otherwise NULL
> + * is returned.  This matches the expected return value of ->lookup.
> + *
> + * Cluster filesystems may call this function with a negative, hashed dentry.
> + * In that case, we know that the inode will be a regular file, and also this
> + * will only occur during atomic_open. So we need to check for the dentry
> + * being already hashed only in the final case.
> + */
> +struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
> +{
> +	return d_splice_alias_ops(inode, dentry, NULL);
> +}
>  EXPORT_SYMBOL(d_splice_alias);
>  
>  /*
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 4afb60365675..f47f3a47d97b 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -250,6 +250,9 @@ extern struct dentry * d_alloc_anon(struct super_block *);
>  extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
>  					wait_queue_head_t *);
>  extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
> +/* weird procfs mess; *NOT* exported */
> +extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
> +					  const struct dentry_operations *);
>  extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
>  extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
>  			const struct qstr *name);
> -- 
> 2.39.5
> 

