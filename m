Return-Path: <linux-fsdevel+bounces-59480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E383CB39AE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 13:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16ED7201584
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB2930E85B;
	Thu, 28 Aug 2025 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfHwDjEO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F8273D6F;
	Thu, 28 Aug 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378956; cv=none; b=MwVoyqlayNCjaZJhdRF3/xTIVB5RZITIPmQXlmTKIUu1Q9OlI8repGlNT0D45wOr2fA46Z0jlyjnbN3uPvOawS2rfE8QxQORrki/1c53mAWrnLQQDU8PUln0tAaoBK2jiOOrho88HcylUt2SHAlJMcGxLh9bdW11rg9AU/M0ajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378956; c=relaxed/simple;
	bh=TiP6eDIlWCu9aD1YkXzlXykr1wDpENnY7juuPACQybw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsZPScHpHRDCzGj4H95P4X+HwK9BEhmqsiia5VH9NSfrp+AfvfBF/FkMQMB5xRIH+JjmDtsPlXDCaD+lPA5RmPHj48MjZpE+I/5vMqu9cnCdFz5QGxwgEyxm5VaeE9N6Hwcvf4UOlYXdf+jXYK0kcDkdm/ENodrlDGaNV2pqd/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfHwDjEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFD1C4CEEB;
	Thu, 28 Aug 2025 11:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756378956;
	bh=TiP6eDIlWCu9aD1YkXzlXykr1wDpENnY7juuPACQybw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfHwDjEOLK+bj2y9uBnQW4oLdC661L9Vb0uOsSamF7weKO/k/rb6I72nk2e0VAB8P
	 uNSg+6hmwu6kL8GaJ9NThueR2RXyzNwNqhEWIdDIPNpxRz7qH2uKjleJT5Fs1NcvS0
	 6AaX4Ul2zApcyhJEwR3v7Z5yYmbG4f9UGQMaILaFo5UKLNk/8nmaX+9U6Vt3abXvO2
	 xn4uhTu1U34A4gy0h8Z1qsb9AQOsjmkEr0y9yyFV/vxci+tTcIrQY6sUBEXyZgeCBD
	 u4c+pDK2rqqgUE4Vu4cfT0ImWEAXWH8wyA7ZjtirqNrNrBp2AiKhzqgpDKjvRUiFNx
	 HMvoDyCIuAgkQ==
Date: Thu, 28 Aug 2025 13:02:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 20/54] fs: disallow 0 reference count inodes
Message-ID: <20250828-aufbau-abblendlicht-a9cf118d33e8@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <df5eb3f393bd0e7cbae103c204363f709c219678.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df5eb3f393bd0e7cbae103c204363f709c219678.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:20AM -0400, Josef Bacik wrote:
> Now that we take a full reference for inodes on the LRU, move the logic
> to add the inode to the LRU to before we drop our last reference. This
> allows us to ensure that if the inode has a reference count it can be
> used, and we no longer hold onto inodes that have a 0 reference count.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 61 ++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9001f809add0..d1668f7fb73e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -598,7 +598,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  
>  	if (inode->i_state & (I_FREEING | I_WILL_FREE))
>  		return;
> -	if (icount_read(inode))
> +	if (icount_read(inode) != 1)
>  		return;
>  	if (inode->__i_nlink == 0)
>  		return;
> @@ -1950,28 +1950,11 @@ EXPORT_SYMBOL(generic_delete_inode);
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
> @@ -1993,8 +1976,37 @@ static void iput_final(struct inode *inode, bool skip_lru)
>  	evict(inode);
>  }
>  
> +static bool maybe_add_lru(struct inode *inode, bool skip_lru)
> +{
> +	const struct super_operations *op = inode->i_sb->s_op;
> +	const struct super_block *sb = inode->i_sb;
> +	bool drop = false;
> +
> +	if (op->drop_inode)
> +		drop = op->drop_inode(inode);
> +	else
> +		drop = generic_drop_inode(inode);
> +
> +	if (drop)
> +		return drop;
> +
> +	if (skip_lru)
> +		return drop;
> +
> +	if (inode->i_state & I_DONTCACHE)
> +		return drop;
> +
> +	if (!(sb->s_flags & SB_ACTIVE))
> +		return drop;
> +
> +	__inode_add_lru(inode, true);
> +	return drop;
> +}
> +
>  static void __iput(struct inode *inode, bool skip_lru)
>  {
> +	bool drop;
> +
>  	if (!inode)
>  		return;
>  	BUG_ON(inode->i_state & I_CLEAR);
> @@ -2010,9 +2022,18 @@ static void __iput(struct inode *inode, bool skip_lru)
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

So before we only put the inode on an LRU when we knew we this was the
last reference. Now we're putting it on the LRU before we know that for
sure.

While __inode_add_lru() now checks whether this is potentially the last
reference we're goint to but, someone could grab another full reference
in between the check, putting it on the LRU and atomic_dec_and_test().
So we are left with an inode on the LRU that previously would not have
ended up there. And then later we need to remove it again. I guess the
arguments are:

(1) It's not a big deal because if the shrinker runs we'll just toss that
    inode from the LRU again.
(2) If it ended up being put on the cached LRU it'll stay there for at
    least as long as the inode is referenced? I guess that's ok too.
(3) The race is not that common?

Anyway, again it would be nice to have some comments noting this
behavior and arguing why that's ok.

> +
>  	if (atomic_dec_and_test(&inode->i_count)) {
>  		/* iput_final() drops i_lock */
> -		iput_final(inode, skip_lru);
> +		iput_final(inode, drop);
>  	} else {
>  		spin_unlock(&inode->i_lock);
>  	}
> -- 
> 2.49.0
> 

