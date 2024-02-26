Return-Path: <linux-fsdevel+bounces-12814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED6D8676A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5E8288A87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB9D12881A;
	Mon, 26 Feb 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyoY7LO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395957E570;
	Mon, 26 Feb 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954397; cv=none; b=na3OIJD8vamdLgf3ynKS4e5xOQ5CWPGTzsLYh0zmdEvSt5U08MufNNeXFi55B/Qcs5JAN/9fU2SDQ8QbprnRzqLwCKVyKuWhoxxaKbLuJ6FTeDWFKbqBL4dX0uO0LjMv2+WjhrhzUA5btEXol9fgP43UlrxSZlPqUnd1Xl1hdlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954397; c=relaxed/simple;
	bh=M0oOylNxz4l9CNHQvuMDa7jjrq0NbJbo0mR8tnz3vHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElzGJV8KZbC0XiBPAENFa9UK5r3c0c1q7Q8siwR+6qOzZLzVaywUwTYGK8p67l5Dh2HJb/nZIhE5OGHHho1GrNCUm8eLU9flEEuKEieNTSi+DkG8lApfLM08tYu1lVHHgLLYwqc4sNZUU6h5gjIi3aA+mE1fqX+/2OEfuDc8PH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyoY7LO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3920C433C7;
	Mon, 26 Feb 2024 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708954396;
	bh=M0oOylNxz4l9CNHQvuMDa7jjrq0NbJbo0mR8tnz3vHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DyoY7LO6znuJBW24YVgBlltkCcHIjjL26Ju+7A+qxERFc3NFn4jn4y8KN2QaKTROh
	 C59msM7Xynq44wIhCfdGRbtF9bLJ6aXYzIj7A8VvaECPj8mYdt1oOpNHAtQv+sjO8j
	 lcDH3+XiD2GobpMlbvC6rZRPPmoBvLRa7kzQufBAODrbzYmytsuX+z+17cEd4bU7K2
	 0FHVrBMC+gu6k9Mnz2novFuRxY49XVHQmpVJwAoe5JCyFo+1xZWHbY/+AdlptjxdNH
	 G4nKQM7c2EDhJkUZbOXpkpZW4GIowb6CExCAQ6QjZ2HhufFZMIFt62vMgfR8HYTk5F
	 +n9bBRPXYO+cA==
Message-ID: <5cdbfed3-62cd-41fd-b71a-5c6b1940ceb6@kernel.org>
Date: Mon, 26 Feb 2024 05:33:14 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: chengming.zhou@linux.dev, naohiro.aota@wdc.com, jth@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 Xiongwei.Song@windriver.com, Chengming Zhou <zhouchengming@bytedance.com>
References: <20240224135329.830543-1-chengming.zhou@linux.dev>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240224135329.830543-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/24 5:53, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/zonefs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 236a6d88306f..c6a124e8d565 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1422,7 +1422,7 @@ static int __init zonefs_init_inodecache(void)
>  {
>  	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
>  			sizeof(struct zonefs_inode_info), 0,
> -			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
> +			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
>  			NULL);
>  	if (zonefs_inode_cachep == NULL)
>  		return -ENOMEM;

Looks good, but please rework the commit message as you suggested on the btrfs
list to have more details about this change. Thanks.

-- 
Damien Le Moal
Western Digital Research


