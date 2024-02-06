Return-Path: <linux-fsdevel+bounces-10496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F8F84BA98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51DCFB25B69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE37134CEC;
	Tue,  6 Feb 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+sHilQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8932A12D150;
	Tue,  6 Feb 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235577; cv=none; b=p6yqFpG1GE3qk7JQ/QJcLnGubasClsvpHmTpjPVO9vHTNgp0QfNn5bp3Q2+tsmss5g3gdNmoq0nfaAGbZAe25Tw7OJ28KU1uWYNxJFlk7E/RHMun0GWLhAWi8Byrt9rxYVVHAgivGN5GFhF39TnslNjgnW1ceEEx3qVVAj2DgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235577; c=relaxed/simple;
	bh=b/T7fVkXIyUcl82kjte27RzYynYV36AFH3cAQFRoTGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3Pu+kDT/mN+usITlFrO1vfDyuyd4lN6ghSpwF2sEbfb2XtH0QJzzEQJQghngAUayVIGO+NnVrJbBtgshOlsqfVw6R3D+Aq40T9LK8ONSOkia93cfrlSW7tgiceHtZ9/BCaqIvr3wMeWPvMSXomwIip6f4d/ZPQrmpUE1/2Xvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+sHilQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14855C433F1;
	Tue,  6 Feb 2024 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707235577;
	bh=b/T7fVkXIyUcl82kjte27RzYynYV36AFH3cAQFRoTGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+sHilQFbhE2BnhrNN+f+Z9KQyVBB16JtQB8/mVn+hghLoxob3VY+isSOVD6LWyqo
	 o4J7J5iuIgIzRwCN/Hf1xG6O1jkOqVkd8Ug778wkMau8riT2yOqmESH7ArONJMyVxw
	 ZcwzPlWmH7+hu4ikTDxJc0kjDTcsGLti7cEo/zlp4ot3pjrqGpElt9Y80HBMzTUBXb
	 lTEYLVpeBE5Af3Mo93v8W2v2m8WyHncTTeI4W6X1LfP6D+7bE5cOwI+wV7Kd/zFNGf
	 sK1CJhgyXFLnyW5Vh+CfOSFP4M9PA6Hjms6W0ms2ZZ5xiuwowcZkpAOXU5ge+3TUfd
	 q93aXEFfdwfpg==
Date: Tue, 6 Feb 2024 17:06:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: taylor.a.jackson@me.com
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Seth Forshee <sforshee@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/mnt_idmapping.c: Return -EINVAL when no map is written
Message-ID: <20240206-tassen-hoben-617fac4c6310@brauner>
References: <20240206-mnt-idmap-inval-v1-1-68bfabb97533@me.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206-mnt-idmap-inval-v1-1-68bfabb97533@me.com>

On Tue, Feb 06, 2024 at 03:17:52PM +0000, Taylor Jackson via B4 Relay wrote:
> From: Taylor Jackson <taylor.a.jackson@me.com>
> 
> This change will return an "invalid argument" error code when a map is
> not provided when attempting to remap files using the id mapped mount
> command, rather than returning nothing.

That should probably explain that before this change it was possible to
create an idmapped mount such that none of the inode's {g,u}id were
mapped and that now this is no longer possible.

> 
> Signed-off-by: Taylor Jackson <taylor.a.jackson@me.com>
> ---

Yup, that looks good to me. It seems unlikely that someone wants none of
the files in that mount to map to anything,

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/mnt_idmapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> index 64c5205e2b5e..3c60f1eaca61 100644
> --- a/fs/mnt_idmapping.c
> +++ b/fs/mnt_idmapping.c
> @@ -214,7 +214,7 @@ static int copy_mnt_idmap(struct uid_gid_map *map_from,
>  	 * anything at all.
>  	 */
>  	if (nr_extents == 0)
> -		return 0;
> +		return -EINVAL;
>  
>  	/*
>  	 * Here we know that nr_extents is greater than zero which means
> 
> ---
> base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
> change-id: 20240206-mnt-idmap-inval-18d3a35f83fd
> 
> Best regards,
> -- 
> Taylor Jackson <taylor.a.jackson@me.com>
> 

