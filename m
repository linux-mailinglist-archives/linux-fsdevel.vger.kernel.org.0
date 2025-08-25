Return-Path: <linux-fsdevel+bounces-59008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0032B33E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4963A9D1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ABE2EBBA2;
	Mon, 25 Aug 2025 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd5qbvw/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC030242925;
	Mon, 25 Aug 2025 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122241; cv=none; b=dku6h0QR84YMGfur5i2BbdQ9eCpkUILYk09UpEubZGQ7gead6xwOlmsUTPFT9Bs8J+NDcV2RQ/MrkEqqpEFA/icwYc+pbHn2omAbY2m41etAmjQo64hkKTdTBRKya+y5zQFmJhmvgoUxBzl5fPjV7pWIoUJlrvCNgjAusEusmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122241; c=relaxed/simple;
	bh=K5JuuyG1PL1zhALtA/UhfaL0oQSSF6cy2FTrZgdl0oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UErJzFVKEF/bnmyXsdwI9Cp2ifr/r+lXqGCRWfOTEqyJvYZrd1g/KY5cY6E755gSix2bbAUnhyAQySDHo5CdA4FBRStfmmnr/q71x7z8cpiQEDV8TMIvecUnVauKcOpIGGD6CUEVqgomc3VWDE8IUqESaDxh+pdrfhH2yZi/g0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd5qbvw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE6BC4CEED;
	Mon, 25 Aug 2025 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756122241;
	bh=K5JuuyG1PL1zhALtA/UhfaL0oQSSF6cy2FTrZgdl0oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dd5qbvw/Sa4mJId77pAAA6ahW45Y+62pTmukAA4ZvenHvwX5DoBohivociKbEJ5cJ
	 3Boa7E3ZqZgv4m46plxz7LBUnFKgQobbT2+b1Gsv8ZOvrHdPKoTYR3aNiV9lgyZmxt
	 +AtYr63tWw9+tYvd71Fkgy6dlMMunALchramuN0Kd51ZlC6y7dNWh7tLmYXMKPZz0E
	 sPJQVZVnXc+nI0zjAJKHv/Rdcte76cVdwn8agEGkBoyd0ExhEvp+smakRl5S1r3ju0
	 dByF/10ywoDD79rNqR7SyxPe1ZMYJdQJe2MDDKdOmZMQkZtXpTijp9zDwwKAx9GRXz
	 5/WClGSJWdRMQ==
Date: Mon, 25 Aug 2025 13:43:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 27/50] fs: use inode_tryget in evict_inodes
Message-ID: <20250825-jungautor-aprikosen-9e6622636614@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <7564463eb7f0cb60a84b99f732118774d2ddacaa.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7564463eb7f0cb60a84b99f732118774d2ddacaa.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:38PM -0400, Josef Bacik wrote:
> Instead of checking I_WILL_FREE|I_FREEING we can simply use
> inode_tryget() to determine if we have a live inode that can be evicted.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index a14b3a54c4b5..4e1eeb0c3889 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -983,12 +983,16 @@ void evict_inodes(struct super_block *sb)
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> +		if (inode->i_state & I_NEW) {
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}
> +
> +		if (!inode_tryget(inode)) {

So it reads like if we fail to take a reference count on @inode then
someone else is already evicting it. I get that.

But what's confusing to me is that the __iget() call you're removing
was an increment from zero earlier in your series because evict_inodes()
was only callable on inodes that had a zero i_count.

Oh, ok, I forgot, you mandate that for an inode to be on an LRU they
must now hold an i_count reference not just an i_obj_count reference.

So in the prior scheme i_count was zero and wouldn't go back up from
zero. In your scheme is i_count guaranteed to be one and after you've
grabbed another reference and it's gone up to 2 is that the max it can
reach or is it possible that i_count can be grabbed by others somehow?

>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
>  
> -		__iget(inode);
>  		inode_lru_list_del(inode);
>  		list_add(&inode->i_lru, &dispose);
>  		spin_unlock(&inode->i_lock);
> -- 
> 2.49.0
> 

