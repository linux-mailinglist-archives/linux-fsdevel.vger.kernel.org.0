Return-Path: <linux-fsdevel+bounces-59004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC7B33DEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE8694E316F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C72E7F22;
	Mon, 25 Aug 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqcgJK5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64303239E9D;
	Mon, 25 Aug 2025 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121165; cv=none; b=SzYBFO0WEaA8PJKPt6lhS1NsJMfuis+b8uoqkXdueuAi0N+DqplJqJIG2OmlF6RMrcLyw1MNJjCjQObL6J2iYinkLJBpMo4k1ctXfXAeC75+7LI6biIYfhqQGN6WDZChmJ4Rz8h9Ic0Jamhj8XTxPF9NWP0Ed/1E0s9fLH3YJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121165; c=relaxed/simple;
	bh=Y8OLTyXKEmSTzO/GdkzitQRCI9Btgh6DIm1hIz6XY1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mr4VI7mIMMz72OJ4yytYSROWRaNqNZuDfbxtN2gKVZtP8sFRwqwfexWDyYE6s+u9ktjD+PTd58mjUExByiIctL1xkyCgMUcD4If6e2ES8xgL7EYRc7kUzXnY5BBCbtJIMz0GymNiZc2NGOn1IUkPtBtTfi/poMDU5M0bZCtDs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqcgJK5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2639BC4CEED;
	Mon, 25 Aug 2025 11:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756121164;
	bh=Y8OLTyXKEmSTzO/GdkzitQRCI9Btgh6DIm1hIz6XY1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqcgJK5bWRVtuqr9y8y8jJ7aG04XlRWeRiMztBFE0Ww21ig2gIkl3l3is86G97UIZ
	 CwVwUG9X9osuHyZ6Ii8L82pw8vOkKZ6mYOUbE88ltuuKFV21ePM84JlQW9XUPxQ3w1
	 IoDHBEleFp/M2qagaRR88Ar2GrCBmvXdXJy+jEIc7ElkR10xPVo49W7xwhk5F1WSwR
	 UOFo+rDYcjMIccSHzCjGAwe5WB3iS0t1rhUu4pri9hGOzF+3wL3Fp00QomErpMBQHl
	 vuc/yy1fK+8tU58jzPZ7HufqL6ntNholl7f1nchdIDj5dgUziZwckflNH3aSzfir+O
	 //dfg7tcG3QHw==
Date: Mon, 25 Aug 2025 13:26:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 22/50] fs: use inode_tryget in find_inode*
Message-ID: <20250825-seicht-anfassen-6c0235f32224@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <0fca9386c2eca65e7fa5a39faca34ebf42d71cd0.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fca9386c2eca65e7fa5a39faca34ebf42d71cd0.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:33PM -0400, Josef Bacik wrote:
> Now that we never drop the i_count to 0 for valid objects, rework the
> logic in the find_inode* helpers to use inode_tryget() to see if they
> have a live inode.  If this fails we can wait for the inode to be freed
> as we know it's currently being evicted.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index b9122c1eee1d..893ac902268b 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1109,6 +1109,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  }
>  
>  static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
> +
>  /*
>   * Called with the inode lock held.
>   */
> @@ -1132,16 +1133,15 @@ static struct inode *find_inode(struct super_block *sb,
>  		if (!test(inode, data))
>  			continue;
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> -			__wait_on_freeing_inode(inode, is_inode_hash_locked);
> -			goto repeat;
> -		}
>  		if (unlikely(inode->i_state & I_CREATING)) {
>  			spin_unlock(&inode->i_lock);
>  			rcu_read_unlock();
>  			return ERR_PTR(-ESTALE);
>  		}
> -		__iget(inode);
> +		if (!inode_tryget(inode)) {
> +			__wait_on_freeing_inode(inode, is_inode_hash_locked);
> +			goto repeat;
> +		}
>  		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
>  		rcu_read_unlock();
> @@ -1174,16 +1174,15 @@ static struct inode *find_inode_fast(struct super_block *sb,
>  		if (inode->i_sb != sb)
>  			continue;
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {

Oh yes, this is such a beautiful change...

> -			__wait_on_freeing_inode(inode, is_inode_hash_locked);
> -			goto repeat;
> -		}


>  		if (unlikely(inode->i_state & I_CREATING)) {
>  			spin_unlock(&inode->i_lock);
>  			rcu_read_unlock();
>  			return ERR_PTR(-ESTALE);
>  		}
> -		__iget(inode);
> +		if (!inode_tryget(inode)) {
> +			__wait_on_freeing_inode(inode, is_inode_hash_locked);
> +			goto repeat;
> +		}
>  		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
>  		rcu_read_unlock();
> -- 
> 2.49.0
> 

