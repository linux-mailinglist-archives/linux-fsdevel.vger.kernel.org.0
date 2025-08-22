Return-Path: <linux-fsdevel+bounces-58798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E801B318A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F09623AF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FEB2FE564;
	Fri, 22 Aug 2025 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9nfY9g4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B92E8DF3;
	Fri, 22 Aug 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867280; cv=none; b=tJDgQk4bBFd1j78mTCbdILxW/ZkDOBmXqyhuoLmJq8wOCTK2ijH7SGSY2CM+WVZvIq9Ghm6CgduFZ7N0XPRg8wVn3I+ear4s8jqsGLVa542K8WitcdVcSxy0WDy9f+1ykweMQBEfbdV2MgITr5tH7MQk7vw/ph2dErsVQx4BgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867280; c=relaxed/simple;
	bh=D7CI/ujIOMJT8PwGvAS/XDxJEV+NYubtwhBRMoWUMH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTxNsWDH4Zj87pOiA6/hBqTaCEoShuCHicWsw7zcnK32N9GpfCTND8R0Bbpm70yA1VTvVXWqkh9Tl3PO3H5G9ngHJVPCiMvuqRgOyK6eILiGf+uW0a2sfGVK0JLIgI2YPV+XbgasvT6neUiZjJbTk6+nkqBzrj6+Y1CXvdUKbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9nfY9g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49AFC4CEED;
	Fri, 22 Aug 2025 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755867279;
	bh=D7CI/ujIOMJT8PwGvAS/XDxJEV+NYubtwhBRMoWUMH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9nfY9g4Wt4WYRMIggPepWnjhLv3wPQlxkqXfUw03cp0KLdU02+GpW5SHU35kQFRQ
	 YlgLVvro9N7vUU5SRGI7d/uk8EyZZ8vufXJt4m80dL2TJue1D43cM4IxFTncZx7DlJ
	 7XBtgqIfo2bofoPu5/lyi5icBjreki5Maka6Ac3YWck2KaJQqJsaDFbyD2p0WGa0+h
	 IPNi8pm8JW8rq8W02leXwO53uRB32lSzdt9+x33ZBXKsKb4SFpLoHjbm3aKdwS2f26
	 tMAGffVOILiyMy0Ktl+uD9gvCw9E3BKlv9UjRw8lLxpbIBnasC6f+AI+bm7Yr8coKl
	 xUHBDt4vKKU4g==
Date: Fri, 22 Aug 2025 14:54:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 12/50] fs: rework iput logic
Message-ID: <20250822-waran-tragweite-78946c108d13@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <51eb4b2eef8ee1f7bb4f0974b048dc85452d182d.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51eb4b2eef8ee1f7bb4f0974b048dc85452d182d.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:23PM -0400, Josef Bacik wrote:
> Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
> set, we will grab a reference on the inode again and then mark it dirty
> and then redo the put.  This is to make sure we delay the time update
> for as long as possible.
> 
> We can rework this logic to simply dec i_count if it is not 1, and if it
> is do the time update while still holding the i_count reference.
> 
> Then we can replace the atomic_dec_and_lock with locking the ->i_lock
> and doing atomic_dec_and_test, since we did the atomic_add_unless above.
> 
> This is preparation for no longer allowing 0 i_count inodes to exist.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 16acad5583fc..814c03f5dbb1 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1928,22 +1928,23 @@ void iput(struct inode *inode)
>  	if (!inode)
>  		return;
>  	BUG_ON(inode->i_state & I_CLEAR);
> -retry:
> -	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
> -		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> -			/*
> -			 * Increment i_count directly as we still have our
> -			 * i_obj_count reference still. This is temporary and
> -			 * will go away in a future patch.
> -			 */
> -			atomic_inc(&inode->i_count);
> -			spin_unlock(&inode->i_lock);
> -			trace_writeback_lazytime_iput(inode);
> -			mark_inode_dirty_sync(inode);
> -			goto retry;
> -		}
> -		iput_final(inode);
> +
> +	if (atomic_add_unless(&inode->i_count, -1, 1)) {
> +		iobj_put(inode);
> +		return;
>  	}
> +
> +	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> +		trace_writeback_lazytime_iput(inode);
> +		mark_inode_dirty_sync(inode);
> +	}
> +
> +	spin_lock(&inode->i_lock);
> +	if (atomic_dec_and_test(&inode->i_count))
> +		iput_final(inode);

Personally, I'd add a
// drops i_lock
comment behind iput_final() but that's a matter of taste tbf.

> +	else
> +		spin_unlock(&inode->i_lock);
> +
>  	iobj_put(inode);
>  }
>  EXPORT_SYMBOL(iput);

This looks a lot less magical than the current variant! We should maybe
split this patch in two. A cleanup patch that removes the questionable
"drop to zero, take lock then increment from zero again" logic and then
in a separate patch add in the iobj_put(). So the cleanup can go to the
front of the series.

