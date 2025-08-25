Return-Path: <linux-fsdevel+bounces-59001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C803BB33DD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8031A82CA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FFD2E62D6;
	Mon, 25 Aug 2025 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVWFA3Hf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB62C08DA;
	Mon, 25 Aug 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120893; cv=none; b=rwWztyj4hdSHMEuK8poufW9LYlmb31EkdtybL6NaV6Tk0bwC2Xr9EbQusSdBBxx5lBXGmK81w3EIS3PiieC4Q36rctyKO9HLwMYQapgdHgSW3TD+31HudKHiO1X2+IzMzOdnQdhYLcJJYiaexzbZsBiMl4NNqgqE64Y9jiFh0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120893; c=relaxed/simple;
	bh=zaEkbmbDR/+qcQobbzpKW9uvKEvz5Rlhx8O6GTrlejA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilC+UCDs/8dXspzxUNBoPK3KD66vCSLU/Hb5WvIHnZNpU0eelnsOu+AOlY6y6ATKXysqp6kt1EVhuYfGNhOhQyeKVkfivGNuc9RO4BQWzICY7kUUBuENlAf7bGskiQ3r8tsZw3Enm94DFio2zwEt1zzmrUvUd1TrtVA/4Be0MCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVWFA3Hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274CBC4CEED;
	Mon, 25 Aug 2025 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756120892;
	bh=zaEkbmbDR/+qcQobbzpKW9uvKEvz5Rlhx8O6GTrlejA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVWFA3HfN6A/Yay+ZMosizwnG0PNVeppOiGxlWZoWyU23LMmnbOA0NO/NvejLwVnM
	 r5mdFbJ1o9NtKjQg1/4XdI3pzbwPwEVfuohui9tzaZn03+KIqc1OBc/HdHJtKoOdTv
	 AmSucisSFgrqsNOtLZPIj8R23XBqxiYsZyhyiTMaFFGbvI6H/cyF720FUPwnUxY+im
	 bEzbG4L1pPvky6CgNHUF2kSdqbXV1FHBFKus6uRbDGtRn6a4KYeJ1ubJ5oGIYNrUPU
	 GNwgE2ieFm1K0gwoXTCRMDxOpIqmsSiZ6fdynanWw1ayF+1wbvAmMLiFuBCwevT8k5
	 2s+p2B9IMKVNw==
Date: Mon, 25 Aug 2025 13:21:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 21/50] fs: use refcount_inc_not_zero in igrab
Message-ID: <20250825-bahnnetz-fragen-c6571104ea56@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <27904789c7dc983dce3f65be80c76919dd1765bf.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27904789c7dc983dce3f65be80c76919dd1765bf.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:32PM -0400, Josef Bacik wrote:
> We are going to use igrab everywhere we want to acquire a live inode.
> Update it to do a refcount_inc_not_zero on the i_count, and if
> successful grab an reference to i_obj_count. Add a comment explaining
> why we do this and the safety.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c         | 26 +++++++++++++-------------
>  include/linux/fs.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 28d197731914..b9122c1eee1d 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1648,20 +1648,20 @@ EXPORT_SYMBOL(iunique);
>  
>  struct inode *igrab(struct inode *inode)
>  {
> +	lockdep_assert_not_held(&inode->i_lock);
> +
> +	inode = inode_tryget(inode);
> +	if (!inode)
> +		return NULL;
> +
> +	/*
> +	 * If this inode is on the LRU, take it off so that we can re-run the
> +	 * LRU logic on the next iput().
> +	 */
>  	spin_lock(&inode->i_lock);
> -	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
> -		__iget(inode);
> -		inode_lru_list_del(inode);
> -		spin_unlock(&inode->i_lock);
> -	} else {
> -		spin_unlock(&inode->i_lock);
> -		/*
> -		 * Handle the case where s_op->clear_inode is not been
> -		 * called yet, and somebody is calling igrab
> -		 * while the inode is getting freed.
> -		 */
> -		inode = NULL;
> -	}
> +	inode_lru_list_del(inode);
> +	spin_unlock(&inode->i_lock);
> +
>  	return inode;
>  }
>  EXPORT_SYMBOL(igrab);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 34fb40ba8a94..b731224708be 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3393,6 +3393,33 @@ static inline void iobj_get(struct inode *inode)
>  	refcount_inc(&inode->i_obj_count);
>  }
>  
> +static inline struct inode *inode_tryget(struct inode *inode)
> +{
> +	/*
> +	 * We are using inode_tryget() because we're interested in getting a
> +	 * live reference to the inode, which is ->i_count. Normally we would
> +	 * grab i_obj_count first, as it is the highe priority reference.
> +	 * However we're only interested in making sure we have a live inode,
> +	 * and we know that if we get a reference for i_count then we can safely
> +	 * acquire i_obj_count because we always drop i_obj_count after dropping
> +	 * an i_count reference.
> +	 *
> +	 * This is meant to be used either in a place where we have an existing
> +	 * i_obj_count reference on the inode, or under rcu_read_lock() so we
> +	 * know we're safe in accessing this inode still.

Maybe add a debug assert to that effect?

VFS_WAR_ON_ONCE(!icount_read(inode) && !rcu_read_lock_held());

> +	 */
> +	if (!refcount_inc_not_zero(&inode->i_count)) {
> +		/*
> +		 * If we failed to increment the reference count, then the
> +		 * inode is being freed or has been freed.  We return NULL
> +		 * in this case.
> +		 */
> +		return NULL;
> +	}

I would invert the logic here?

	if (refcount_inc_not_zero()) {
		iobj_get(inode);
		return inode;
	}

        /*
         * If we failed to increment the reference count, then the
         * inode is being freed or has been freed.  We return NULL
         * in this case.
         */
	return NULL;

