Return-Path: <linux-fsdevel+bounces-47602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B3AA0F7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827B84A2321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD3B217F35;
	Tue, 29 Apr 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+RcvVL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E51BF37;
	Tue, 29 Apr 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938124; cv=none; b=j9gCiA704OhtZsheyGM9K26tmsd0bIwttjTtBO5LlkXcncyloPUNIHJ9KKKGFT0e/Pr+VcRf8Illj2TZ58LQ6GYG0hurZ0S5JokmaH6VslwJ4pGkuYF9up9h+YZXY6HryVeJuAGgmA8iozc4tZtDXI3XRrBs7j2NEozsv+SZT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938124; c=relaxed/simple;
	bh=xxrhrbslaKkkPFZLrwGjlachyjJaJ9EgfJlvRH5Vhzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJwKzZWjJ5RP4/Y4NdPtB5l5XWeNvrjzQ/pKO8CjpFveMH4oIL4LNh+HRYyyRgMpjPBkCWdQfWWMU8/mfsfplWgIkGpiUhP6140vZEO/OfJB7m5Kvk2UtTYH5nYLqoMjfjY4aSRTEgC5TfiOn/ftK8EurBkqFrjkO9VJ4l8JPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+RcvVL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3BEC4CEE3;
	Tue, 29 Apr 2025 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745938123;
	bh=xxrhrbslaKkkPFZLrwGjlachyjJaJ9EgfJlvRH5Vhzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+RcvVL/+sXmy4nK8UBOmjHGkteYfD34W+9+jHy2xXjfMeHxVOq/9oByrW7xcTG3z
	 O8+XQfz43fd9bs/4+b/DbTAszcxwN6newZH+N1r4emiP3xnxdgw0wY+Zyjs9GwlbUI
	 F5K35KfcTKz4dHUY1GdgV9mkNI3vHy6ALNitc5LchvXfnYyHgAMfR/SXdku08j3l9B
	 xOV5Tx4hH3XTmdtiVbJd9s31biCsTJs3zxxuIXxbriZmZ3n4Jk1oC+Q4fHNekENvrk
	 wUVvkTwQXiV8XCwHc7bQL/aiGqIn79zHnm5XO1DQG1hWu4ejcGAAMjJXWjcq61BBhT
	 E8sOjRDS1pdZA==
Date: Tue, 29 Apr 2025 07:48:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: use ZONEFS_SUPER_SIZE instead of PAGE_SIZE
Message-ID: <20250429144842.GC1035866@frogsfrogsfrogs>
References: <c14f62628e0417498ace0caaa1f4fef2cb0f8477.1745934166.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14f62628e0417498ace0caaa1f4fef2cb0f8477.1745934166.git.jth@kernel.org>

On Tue, Apr 29, 2025 at 03:42:53PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Use ZONEFS_SUPER_SIZE constant instead of PAGE_SIZE allocating memory for
> reading the super block in zonefs_read_super().
> 
> While PAGE_SIZE technically isn't incorrect as Linux doesn't support pages
> smaller than 4k ZONEFS_SUPER_SIZE is semantically more correct.

Yeah, that is less likely to leave a landmine if the super size ever
gets bigger or someone goes nuts and reintroduces tinypages.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> This patch is based on top of Christoph's series titled "add more bio
> helper" specifically on top of "[PATCH 16/17] zonefs: use bdev_rw_virt in
> zonefs_read_super"
> ---
>  fs/zonefs/super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index d165eb979f21..4dc7f967c861 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1113,11 +1113,12 @@ static int zonefs_read_super(struct super_block *sb)
>  	u32 crc, stored_crc;
>  	int ret;
>  
> -	super = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	super = kmalloc(ZONEFS_SUPER_SIZE, GFP_KERNEL);
>  	if (!super)
>  		return -ENOMEM;
>  
> -	ret = bdev_rw_virt(sb->s_bdev, 0, super, PAGE_SIZE, REQ_OP_READ);
> +	ret = bdev_rw_virt(sb->s_bdev, 0, super, ZONEFS_SUPER_SIZE,
> +			   REQ_OP_READ);
>  	if (ret)
>  		goto free_super;
>  
> -- 
> 2.43.0
> 
> 

