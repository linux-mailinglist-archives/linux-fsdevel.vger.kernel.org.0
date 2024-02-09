Return-Path: <linux-fsdevel+bounces-10875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA4F84EF86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 05:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB19D28D45E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 04:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1E15672;
	Fri,  9 Feb 2024 04:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoRVwyMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5B5258;
	Fri,  9 Feb 2024 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451590; cv=none; b=aO9XAw5kL06211R9kOI16nH+h4UwYssrlGqAHTQCsXmajJ6iFgYwd1VxkVgiP4VulYgkfli7HaxZjWgvFsbc2f7tswTiRvD9HuMej/XKH/Rmmymay7tOeDQZlR+Q7hgOsELXAUtn8bRihEiF1WItl29cgi/A/KaAgf44HdvfTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451590; c=relaxed/simple;
	bh=2M34wfVL207/GV10UNusnSeyFndxBECD5cezZE6nxxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXQcPEJ1MFw4KsUYN/G1WaXDq3IcdOqKBhUwA14GB83etHxUST7eM0THLVGYfmwhS7MBsEkQ4yIj5X5+TZVx+wpsIQVBPrVxEQIY10/rOuaASbpkQYRoRMQ8vf3Idtp3TdwcofJbHGV0gWgoPbWLWk6kt3ihB9/JFB7sdXKw8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoRVwyMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA3BC433F1;
	Fri,  9 Feb 2024 04:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707451589;
	bh=2M34wfVL207/GV10UNusnSeyFndxBECD5cezZE6nxxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VoRVwyMuLdd9+uWCAgpY9rxoOLvfjKGdSE86kJ4nsn9lbbXLce5tqi73ZP3FwVllp
	 tHgpWruMJDWdNnX/Ixnp0f3tglT73Tweot2adACCN4jA+WL1jiA+mz4cLtyzldozWg
	 DHLCW2l1yYZE/SIe83Clua21zEh/aICnEdcN0K5AB+x/VjpNkZiIOLbNY9Eelx1nSg
	 DoOnMwaHLlfKQ4UXhs8t4ou7nwZArynsxA3HTGYmhQuoBSYRs7vKSip1wBreyQiHfj
	 8At6sxacdsVuVtQu1t5+x9MSLjTULhL+dhWmmBqhW58H3rJmaACjZy217NlkeODfwq
	 Uw+c68PQHgC7g==
Message-ID: <4af4be6e-2c58-4c14-ad2d-eb3f8101a0c1@kernel.org>
Date: Fri, 9 Feb 2024 13:06:27 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: Simplify the allocation of slab caches in
 zonefs_init_inodecache
Content-Language: en-US
To: Kunwu Chan <chentao@kylinos.cn>, naohiro.aota@wdc.com, jth@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240205081022.433945-1-chentao@kylinos.cn>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240205081022.433945-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/24 17:10, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  fs/zonefs/super.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 93971742613a..9b578e7007e9 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1387,10 +1387,8 @@ static struct file_system_type zonefs_type = {
>  
>  static int __init zonefs_init_inodecache(void)
>  {
> -	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
> -			sizeof(struct zonefs_inode_info), 0,
> -			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
> -			NULL);
> +	zonefs_inode_cachep = KMEM_CACHE(zonefs_inode_info,
> +			SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT);
>  	if (zonefs_inode_cachep == NULL)
>  		return -ENOMEM;
>  	return 0;

I do not really see a meaningful simplification here. Using kmem_cache_create()
directly is not *that* complicated... Also, this changes the name of the cache
from "zonefs_inode_cache" to "zonefs_inode_info".

-- 
Damien Le Moal
Western Digital Research


