Return-Path: <linux-fsdevel+bounces-58834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67575B31EA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18CA189CD7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B31B0F19;
	Fri, 22 Aug 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKcXE9PV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887981C5D7B;
	Fri, 22 Aug 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876480; cv=none; b=oD1BEMWM1wMa9OLUSzf6CJXDL9KW/Mi4NApt05IgJzEzVEB/PTIGPz1qDDsFIllu+3mVT6JbsxC7WbxnQWclYOGgS2r7coL4CAKBfJj6I3YrCuhMqWIktAecVefkTKEbw9oDuNBsLol+FK5BufWJAohRnW5JLswn/EjK7g1nMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876480; c=relaxed/simple;
	bh=muNdSXseEu/rJMTulvsFLDBQqTzFlcX+DPy3jXqZ7Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHtnO3BCqegsSQDwu7Yd1K1cCDNHm78C5rWSKUnOrgYiXW7V0QoYLoX/pSrYTwaeqM9F9Ma+gSkFn2lF6V1c2Hccb38VTVn7Gq391UyJw4tLiB9z+RmpyheWasrzwYST4uxkua5KZ/lEcu0vaU36eiOXooCJCcFA66c183UQxqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKcXE9PV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6415AC4CEED;
	Fri, 22 Aug 2025 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755876480;
	bh=muNdSXseEu/rJMTulvsFLDBQqTzFlcX+DPy3jXqZ7Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKcXE9PVGNET2gtGcgqz+g2YJRH4nIhWIjneaBa9U0x/P1cKWlR9GNky6U9FXeDHf
	 MbkkDBlqfwt52qWAZPQTT1Vz6rzpOrMGBaeqksnQm8YHRKfmTmDpoeztkVL87iLriY
	 JdDOi8BYdZ/DEu5YHUilhCrnjakcX/5pJ6qgEikPVc6eqNeEyILAw0NA8gpYB5Z+zW
	 dFmoWyJf9SJHil+J19xnRVXguIe3zBNooDn9I0uJJGq0N0dn7IU2TujOBsqhXtsWyE
	 fX+ej3rX+H1rThLz4b13rHvEr3d2p484J+ZEn/qhXy05v85mmN0rcNTS4oI2WGzb2f
	 A/Y4BD0IhboHw==
Date: Fri, 22 Aug 2025 17:27:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 15/50] fs: delete the inode from the LRU list on lookup
Message-ID: <20250822-werden-hinein-419c34f78154@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <d595f459d9574e980628eb43f617cbf4fd1a9137.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d595f459d9574e980628eb43f617cbf4fd1a9137.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:26PM -0400, Josef Bacik wrote:
> When we move to holding a full reference on the inode when it is on an
> LRU list we need to have a mechanism to re-run the LRU add logic. The
> use case for this is btrfs's snapshot delete, we will lookup all the
> inodes and try to drop them, but if they're on the LRU we will not call
> ->drop_inode() because their refcount will be elevated, so we won't know
> that we need to drop the inode.
> 
> Fix this by simply removing the inode from it's respective LRU list when
> we grab a reference to it in a way that we have active users.  This will
> ensure that the logic to add the inode to the LRU or drop the inode will
> be run on the final iput from the user.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index adcba0a4d776..72981b890ec6 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1146,6 +1146,7 @@ static struct inode *find_inode(struct super_block *sb,
>  			return ERR_PTR(-ESTALE);
>  		}
>  		__iget(inode);
> +		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
>  		rcu_read_unlock();
>  		return inode;
> @@ -1187,6 +1188,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
>  			return ERR_PTR(-ESTALE);
>  		}
>  		__iget(inode);
> +		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
>  		rcu_read_unlock();
>  		return inode;
> @@ -1653,6 +1655,7 @@ struct inode *igrab(struct inode *inode)
>  	spin_lock(&inode->i_lock);
>  	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
>  		__iget(inode);
> +		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
>  	} else {
>  		spin_unlock(&inode->i_lock);

Interesting, so the previous behavior implies that igrab(),
find_inode(), find_inode_fast() are called on inodes that are hashed and
on an LRU. None of them even raise I_REFERENCED.

I would think that this means that there are callers that grab very
temporary references to inodes that they immediately drop without
wanting to prevent reclaim.

Oh, because btrfs subvolume delete is effectively a recursive directory
removal and that's why that happens? I wonder if there are other users.
So if this regresses someone it would regress btrfs I guess. :)

