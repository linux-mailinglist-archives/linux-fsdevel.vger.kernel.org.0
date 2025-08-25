Return-Path: <linux-fsdevel+bounces-58997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C865B33D45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFC53A0142
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CFE2E11BC;
	Mon, 25 Aug 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLPCByag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73792DCF7B;
	Mon, 25 Aug 2025 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119246; cv=none; b=oSotMamGEYnYKPTBImAA2MB5PiccV6LHbWJxG+f+bXAM3X6r58zza7ZygeLEg1w4SKGfkZtvTNuDXi6AOaeO7bxmMv7dVqeDGbJmaSFMtQHm7d+lwQdJgijydoKZTVGgu8eMNBzc70wBMidiwGlgkjBXusSlVkUK8RdzJ5rTVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119246; c=relaxed/simple;
	bh=E+ab+mxNsPLyo6AQ1XDslsP4TqTnE3JrBDz+dRI3TaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACOocAscD3AXlldOtiezk7MWRaB9jFR4AqGY8HM5P7UMiCmR3FtuV9hl8ffGDloocefehbBRuUfN3DZRuH6Tue+4L14AEEBACYi5B3hZGBTkibeGcSuyjlwZYow+fEwDuJ1ALcfmKTwIKNhd9tk9XS+1ki7hJaLJUTqVroYiDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLPCByag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E67C4CEED;
	Mon, 25 Aug 2025 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756119245;
	bh=E+ab+mxNsPLyo6AQ1XDslsP4TqTnE3JrBDz+dRI3TaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLPCByagYYv3+BJkzsOrCb6SAfvEpPFklG+DbVX1ObfkxUDy53uLo3N5YAuB5hgT0
	 xFcbClWlzvOTU38U3T4HOaiojgGmt74+2P+cKDoc6CFEuc7/WKO26ggYl/c4y8kVQg
	 erTytcUO7RPc7/MkcJHjXRKxhfmFDiel9VNysk7Ev0DQcE8fyGWwXt/YehoCyt3gLg
	 2fhq5alPQlvYLZN0VZCDRhoMAdT7cODiKnsxMaQo1U6dQ6kWOO5LoZUexYy6FoJ85y
	 H/RRFD+phQhrXJuHAgOuLdW4qsbxVpn822JmA71SnIojZJ0zxbu5/4T2cXlsv8G3i0
	 awQMPN+DZDgfA==
Date: Mon, 25 Aug 2025 12:54:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 18/50] fs: disallow 0 reference count inodes
Message-ID: <20250825-person-knapp-e802daccfe5b@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <6f4fb1baddecbdab4231c6094bbb05a98bbb7365.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f4fb1baddecbdab4231c6094bbb05a98bbb7365.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:29PM -0400, Josef Bacik wrote:
> Now that we take a full reference for inodes on the LRU, move the logic
> to add the inode to the LRU to before we drop our last reference. This
> allows us to ensure that if the inode has a reference count it can be
> used, and we no longer hold onto inodes that have a 0 reference count.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 53 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index de0ec791f9a3..b4145ddbaf8e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -614,7 +614,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  
>  	if (inode->i_state & (I_FREEING | I_WILL_FREE))
>  		return;
> -	if (atomic_read(&inode->i_count))
> +	if (atomic_read(&inode->i_count) != 1)
>  		return;
>  	if (inode->__i_nlink == 0)
>  		return;
> @@ -1966,28 +1966,11 @@ EXPORT_SYMBOL(generic_delete_inode);
>   * in cache if fs is alive, sync and evict if fs is
>   * shutting down.
>   */
> -static void iput_final(struct inode *inode, bool skip_lru)
> +static void iput_final(struct inode *inode, bool drop)
>  {
> -	struct super_block *sb = inode->i_sb;
> -	const struct super_operations *op = inode->i_sb->s_op;
>  	unsigned long state;
> -	int drop;
>  
>  	WARN_ON(inode->i_state & I_NEW);
> -
> -	if (op->drop_inode)
> -		drop = op->drop_inode(inode);
> -	else
> -		drop = generic_drop_inode(inode);
> -
> -	if (!drop && !skip_lru &&
> -	    !(inode->i_state & I_DONTCACHE) &&
> -	    (sb->s_flags & SB_ACTIVE)) {
> -		__inode_add_lru(inode, true);
> -		spin_unlock(&inode->i_lock);
> -		return;
> -	}
> -
>  	WARN_ON(!list_empty(&inode->i_lru));
>  
>  	state = inode->i_state;
> @@ -2009,8 +1992,29 @@ static void iput_final(struct inode *inode, bool skip_lru)
>  	evict(inode);
>  }
>  
> +static bool maybe_add_lru(struct inode *inode, bool skip_lru)
> +{
> +	const struct super_operations *op = inode->i_sb->s_op;
> +	struct super_block *sb = inode->i_sb;
> +	bool drop = false;
> +
> +	if (op->drop_inode)
> +		drop = op->drop_inode(inode);
> +	else
> +		drop = generic_drop_inode(inode);
> +
> +	if (!drop && !skip_lru &&
> +	    !(inode->i_state & I_DONTCACHE) &&
> +	    (sb->s_flags & SB_ACTIVE))
> +		__inode_add_lru(inode, true);
> +
> +	return drop;
> +}

Can we rewrite this as:

static bool maybe_add_lru(struct inode *inode, bool skip_lru)
{
	const struct super_operations *op = inode->i_sb->s_op;
	const struct super_block *sb = inode->i_sb;
	bool drop = false;

	if (op->drop_inode)
		drop = op->drop_inode(inode);
	else
		drop = generic_drop_inode(inode);

	if (drop)
		return drop;

	if (skip_lru)
		return drop;

	if (inode->i_state & I_DONTCACHE)
		return drop;

	if (!(sb->s_flags & SB_ACTIVE))
		return drop;

	__inode_add_lru(inode, true);
	return drop;
}

so it's a lot easier to follow. I really dislike munging conditions
together with a bunch of ands and negations mixed in.

And btw for both I_DONTCACHE and !SB_ACTIVE it seems that returning
anything other than false from op->drop_inode() would be a bug probably
a technicality but I find it pretty odd.

Maybe we add a VFS_WARN_ON_ONCE() at least in your local testing to see
whether you see anything that ever hits this case.

> +
>  static void __iput(struct inode *inode, bool skip_lru)
>  {
> +	bool drop;
> +
>  	if (!inode)
>  		return;
>  	BUG_ON(inode->i_state & I_CLEAR);
> @@ -2026,8 +2030,17 @@ static void __iput(struct inode *inode, bool skip_lru)
>  	}
>  
>  	spin_lock(&inode->i_lock);
> +
> +	/*
> +	 * If we want to keep the inode around on an LRU we will grab a ref to
> +	 * the inode when we add it to the LRU list, so we can safely drop the
> +	 * callers reference after this. If we didn't add the inode to the LRU
> +	 * then the refcount will still be 1 and we can do the final iput.
> +	 */
> +	drop = maybe_add_lru(inode, skip_lru);
> +
>  	if (atomic_dec_and_test(&inode->i_count))
> -		iput_final(inode, skip_lru);
> +		iput_final(inode, drop);
>  	else
>  		spin_unlock(&inode->i_lock);
>  
> -- 
> 2.49.0
> 

