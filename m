Return-Path: <linux-fsdevel+bounces-48319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4738AAD460
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 06:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA663BFF97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 04:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D791D63E8;
	Wed,  7 May 2025 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohos2auG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECBA14A4CC;
	Wed,  7 May 2025 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746591476; cv=none; b=NIgRh8fdxbP4MKtfVWtJY8eZTliAo7HTSKyhDj/a6V22KMhIQM+30DHh9Ge0xZPV9Z2J6i40gvQD8dxoRtU/9e4+aT4QIk1YTdJWZOAr4iKVQwP4LPMLEJsrG5YJNjQa1LasI4d1O+FSsF2sz30u3n8/1kifwIa3anHRzpX+tjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746591476; c=relaxed/simple;
	bh=W8ajmMEgE8eW86aOcLYLYY87JsHIzCFkK/wJw5Pkau4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Itb7nDBopAUD2GT2LU6Vr0RUVahD624hw+v7o9V7wL3yoOlWVCgp9aeAPN+p5IZ4jyf6EmhkRkjPrCFrXpJHBcbzrxmoI64XzfxODfW+sUMWIz9eflAlWO8q9g60KK902rFuQeQT0ZofrRUGRKo6txo3MWSFr3v0bzX/bkABRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohos2auG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CF7C4CEE7;
	Wed,  7 May 2025 04:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746591475;
	bh=W8ajmMEgE8eW86aOcLYLYY87JsHIzCFkK/wJw5Pkau4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ohos2auGwZQ/Zw6kxN9RwpUCdKo60C3+MTsRvFaecs838JJJM9Lws2uZNrUSP7dh5
	 YiCp79ZDbQj82AFOgG7iaFCUIdyaDYhFcQWW1zTvoabJCfPL6d7mJGPgLxoDIo/Nvf
	 Q2cmc7J9grUrVFgd/roo837jWwgIxjkQhENsb3VTU0mK/7lkSYDPsY1z0EKMQBh5Es
	 Mbq8KSBPGVOfqoxEJw2BImCU2QY4mtX8ndDafvlft9Kp2IgffCiWsLp6Zj71t9LRY1
	 dcUe+cRa7y5MMmoeVpIyIbkDzKNz6P9iY0SRt/pvkCY31Jv9+fPxmE7p7GD8x57MvG
	 LBuENz63AQwHw==
Message-ID: <b8fdfa71-6161-473c-9d2f-cc5f158b5050@kernel.org>
Date: Wed, 7 May 2025 13:16:44 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: use ZONEFS_SUPER_SIZE instead of PAGE_SIZE
To: Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <c14f62628e0417498ace0caaa1f4fef2cb0f8477.1745934166.git.jth@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <c14f62628e0417498ace0caaa1f4fef2cb0f8477.1745934166.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 10:42 PM, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Use ZONEFS_SUPER_SIZE constant instead of PAGE_SIZE allocating memory for
> reading the super block in zonefs_read_super().
> 
> While PAGE_SIZE technically isn't incorrect as Linux doesn't support pages
> smaller than 4k ZONEFS_SUPER_SIZE is semantically more correct.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> This patch is based on top of Christoph's series titled "add more bio
> helper" specifically on top of "[PATCH 16/17] zonefs: use bdev_rw_virt in
> zonefs_read_super"

And because of that, I will apply it next cycle I think.

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


-- 
Damien Le Moal
Western Digital Research

