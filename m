Return-Path: <linux-fsdevel+bounces-35561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C7B9D5DE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFEB2838DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F561DE4EB;
	Fri, 22 Nov 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7xSV0xD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A61DC1B7;
	Fri, 22 Nov 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274317; cv=none; b=FbFaGf69FOn+c++zSHmlAWEMVhwTuO2nbOKXgnkYbfzsimX9C8QY0TKcfhH6cuzHj8MV91gz5HpUhU184VR0WLfvm9877tmJ/WEm8XNRulERgVUpwEYtFrk0XGihxJNsb0pohiWBFDrnEd8SLTTSkEVLPPyhUtU7b5g9QeBjoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274317; c=relaxed/simple;
	bh=aRSON2iACIfF4nMH85T1klUkNEnmYuPsQTHx7zhr2fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzZDGv1JC6azNW5x62oes8d+hkzG1SOrTsB340BhsttzJO/KLWkJR4PdMnse9mSn54rRgDTW8Z6rIPLaF2BWm9V3xUIcuMQQ7M7imbPeZ0a6nM+xnxegJWzqNNi8HK+qrUS47O7Tj+Z0YomySVwjWMepRmQiZClLGtPgwKp14hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7xSV0xD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA01C4CECE;
	Fri, 22 Nov 2024 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732274317;
	bh=aRSON2iACIfF4nMH85T1klUkNEnmYuPsQTHx7zhr2fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7xSV0xD8EZ6W8L+jai2EgeOFo4XT/ENW96/CMOdQdIxZd+lzKp/Dfmc2iv9oxDot
	 /eoKU8IGIPu2g/lAupCb1+aO1vgdbW0r1rSxfpql3cfbZGQqAvlyuVKfcCT/ut/So0
	 vH251mpzgpYZH3kt57jkU5xFxb00bVh6MU10RzhQwfVLYjstAIN1giy2SprIk4gmVS
	 I0Evi9xozQNy5oaUmTSa9xU/DB7XOcKLqkpsl5qXPanuRaM5k5Zc4xb9zdVeDYZNyo
	 XD79J0ZLolArh10sn1nEPLboXw7RsD30xif20POMMDNMSmFeyHUIrr5xIrBJiqylQn
	 0Tlyavlw7wCXQ==
Date: Fri, 22 Nov 2024 12:18:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: fix missing nodiratime option and handle
 propagate_from correctly
Message-ID: <20241122-atemzug-boxen-d104f618c6b0@brauner>
References: <20241121-statmount-v1-1-09c85a7d5d50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241121-statmount-v1-1-09c85a7d5d50@kernel.org>

On Thu, Nov 21, 2024 at 09:39:44AM -0500, Jeff Layton wrote:
> The nodiratime option is not currently shown. Also, the test for when
> to display propagate_from: is incorrect. Make it work like it does in
> show_mountinfo().
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> It might be best to just squash this patch into the one that adds the
> new sample program. Also, looks like your vfs-6.14.misc branch hasn't
> been updated yet?

I have not pushed it out but will do so now!

> ---
>  samples/vfs/mountinfo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/vfs/mountinfo.c b/samples/vfs/mountinfo.c
> index d9f21113a93b7aa7606de2edfce5ad0d5bcf2056..349aaade4de53912b96eadb35bf1b7457b4b04fa 100644
> --- a/samples/vfs/mountinfo.c
> +++ b/samples/vfs/mountinfo.c
> @@ -90,6 +90,8 @@ static void show_mnt_attrs(uint64_t flags)
>  		break;
>  	}
>  
> +	if (flags & MOUNT_ATTR_NODIRATIME)
> +		printf(",nodiratime");
>  	if (flags & MOUNT_ATTR_NOSYMFOLLOW)
>  		printf(",nosymfollow");
>  	if (flags & MOUNT_ATTR_IDMAP)
> @@ -102,7 +104,7 @@ static void show_propagation(struct statmount *sm)
>  		printf(" shared:%llu", sm->mnt_peer_group);
>  	if (sm->mnt_propagation & MS_SLAVE) {
>  		printf(" master:%llu", sm->mnt_master);
> -		if (sm->mnt_master)
> +		if (sm->propagate_from && sm->propagate_from != sm->mnt_master)
>  			printf(" propagate_from:%llu", sm->propagate_from);
>  	}
>  	if (sm->mnt_propagation & MS_UNBINDABLE)
> 
> ---
> base-commit: ee05701bd2a2e4559f35742d59922ebb9b006d3c
> change-id: 20241121-statmount-924ab4233d6e
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

