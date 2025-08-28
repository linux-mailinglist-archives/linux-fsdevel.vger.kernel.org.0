Return-Path: <linux-fsdevel+bounces-59491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A616DB39D81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F3985713
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A5E3101AA;
	Thu, 28 Aug 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk3jPTY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AA30F944;
	Thu, 28 Aug 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384830; cv=none; b=qbyhlAQecfZNiuL3beeBuDhBKBj2OnxnlO6MPpzTAi1Pa9MtNDDGyrdwmRLVoT8BABI8/TEyab0tDRhbhMZpKDHDFJWt2x5NcHcIU33xLHXIHPDrDtvjfYDDeuXhnuTakhSweM4cL2JUlRM+GQF0XRg8CMYgtmsPNOC8D6fDQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384830; c=relaxed/simple;
	bh=aLlKvcNrJdKssApUKqZnCs6aOM0GJeWFycjakJliqCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqI4Z2qKZLs1iEi+YCx4E/YQTuP9L2+Dq/uXQDDmjYdJ5jF2V/hT/Hb8q5FLEfra8Nf1JyMcRioFp95Qo0o/9HcBfho6kWQN++4YO6VDEkOPqAxxhgxzXWtBCnCzJ7sqQFyNcfamYLfA2LM5sGg71GMgMRSh1N3XZs1oLN29UCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk3jPTY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2B7C4CEEB;
	Thu, 28 Aug 2025 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384829;
	bh=aLlKvcNrJdKssApUKqZnCs6aOM0GJeWFycjakJliqCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk3jPTY/ma5WbIaYrID7YZGw0Ya0pI5/evmB+I4DWKuJ5+aQjLA5+FYUNBU+wfD89
	 NoXIa3aRkxe46AkZj0MjX3Rcut1iMul0gLD39NbkRscUUbpTZfSKhoHWWTx/AqVc88
	 bnxSyvpvq/WeFsZ5FdazuaymtnC4MMl1XedbDrqIGo1QXbOmSqJHAST4pl6BOh64Jn
	 +rGsC5SIfD6WyY/ivv6fefk9Y7U1ndzDmqJwNj3xjxnW0lHi4MX1srQFluBGCZ3HOk
	 5tvaU6mUyqbqf7GFIREFAla7FYyu1uIVFPfiHsYHaqbQX/dgFB07vZ0ckXfsgZ+C/D
	 im7jwcawuXk4w==
Date: Thu, 28 Aug 2025 14:40:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 48/54] fs: remove some spurious I_FREEING references
 in inode.c
Message-ID: <20250828-redeverbot-material-2e2f9f71d9b7@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <da562975b6a07b1cc8341a6374ca82cd453d986c.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da562975b6a07b1cc8341a6374ca82cd453d986c.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:48AM -0400, Josef Bacik wrote:
> Now that we have the i_count reference count rules set so that we only
> go into these evict paths with a 0 count, update the sanity checks to
> check that instead of I_FREEING.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index eb74f7b5e967..da38c9fbb9a7 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -858,7 +858,7 @@ void clear_inode(struct inode *inode)
>  	 */
>  	xa_unlock_irq(&inode->i_data.i_pages);
>  	BUG_ON(!list_empty(&inode->i_data.i_private_list));
> -	BUG_ON(!(inode->i_state & I_FREEING));
> +	BUG_ON(icount_read(inode) != 0);
>  	BUG_ON(inode->i_state & I_CLEAR);
>  	BUG_ON(!list_empty(&inode->i_wb_list));

These should probably all be WARN_ON()s.

>  	/* don't need i_lock here, no concurrent mods to i_state */
> @@ -871,19 +871,19 @@ EXPORT_SYMBOL(clear_inode);
>   * to. We remove any pages still attached to the inode and wait for any IO that
>   * is still in progress before finally destroying the inode.
>   *
> - * An inode must already be marked I_FREEING so that we avoid the inode being
> + * An inode must already have an i_count of 0 so that we avoid the inode being
>   * moved back onto lists if we race with other code that manipulates the lists
>   * (e.g. writeback_single_inode). The caller is responsible for setting this.
>   *
>   * An inode must already be removed from the LRU list before being evicted from
> - * the cache. This should occur atomically with setting the I_FREEING state
> - * flag, so no inodes here should ever be on the LRU when being evicted.
> + * the cache. This should always be the case as the LRU list holds an i_count
> + * reference on the inode, and we only evict inodes with an i_count of 0.
>   */
>  static void evict(struct inode *inode)
>  {
>  	const struct super_operations *op = inode->i_sb->s_op;
>  
> -	BUG_ON(!(inode->i_state & I_FREEING));
> +	BUG_ON(icount_read(inode) != 0);
>  	BUG_ON(!list_empty(&inode->i_lru));
>  
>  	if (!list_empty(&inode->i_io_list))
> @@ -897,8 +897,8 @@ static void evict(struct inode *inode)
>  	/*
>  	 * Wait for flusher thread to be done with the inode so that filesystem
>  	 * does not start destroying it while writeback is still running. Since
> -	 * the inode has I_FREEING set, flusher thread won't start new work on
> -	 * the inode.  We just have to wait for running writeback to finish.
> +	 * the inode has a 0 i_count, flusher thread won't start new work on the
> +	 * inode.  We just have to wait for running writeback to finish.
>  	 */
>  	inode_wait_for_writeback(inode);
>  	spin_unlock(&inode->i_lock);
> -- 
> 2.49.0
> 

