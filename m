Return-Path: <linux-fsdevel+bounces-46277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8BA860C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB57E9A3938
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B60D1F9A8B;
	Fri, 11 Apr 2025 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3/JB24W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C912818FC89;
	Fri, 11 Apr 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382118; cv=none; b=QytNmd7yBQsG13ynkWTQhOndXw1tTSnUgCOaEH3noe39d25feoatbnllbyztSJoG8Me8EVgknsATqrs2dxe4DeD+OegsMF7rNiS67hsvdzF3a7MZ2FsZ84maE6M6H+8rVQsJnS3FJ4+3jr3IJvEh5YDbxrPzhgtMBC8ZQWERIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382118; c=relaxed/simple;
	bh=N9qG6Bp29G43oBNm6Bl9rtnwBvyVdg5RJEnaWE7bVTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYKv/6A/+DYk43M8mUcXFqnRMx+XKMymkPxJt61TldSUyjcDQzkBn4ny8vbidbBDzr+2CcgbKyKXKaoRd+/YW0oIafpyFK52Em52wwdz1j7iMO82jpJEkxnCPUD1tt85hWuJ04P4si6UPHw2CRDRhO8iwvOsbrPvBPlYEcwYDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3/JB24W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D049C4CEE2;
	Fri, 11 Apr 2025 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744382118;
	bh=N9qG6Bp29G43oBNm6Bl9rtnwBvyVdg5RJEnaWE7bVTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3/JB24WHe9LrvhIKNIGBDyLQRdtO3Sfz6Zw8lbsHfl2OZqJ5/DUNaAtYu6ypX3Df
	 vdR8Dd2TpBPp1p8zcAIZ2JWRWB3VAd9oxbwY3/pv9uKJiDFi4evpsN3bPLJJb70sF3
	 qGIuQzoQ4u3dGYDutVRyi/W+CrLArt2lEhWHZ52jJwyfAX6KYi+wir8a/pHk6OiMFs
	 cusVd30O4J042WiARx/cmGQbmKr6s9xuO/Pqh8n6Or6/DRwot+PvYkFBCihNBZvvW/
	 d2nsLSUYvLeC5MT1Gw43XTi5HKGAVGZhjWg45hFNDIkETwsJYtjL6Ax256UbICqUg/
	 wgO7mBEIiqUtQ==
Date: Fri, 11 Apr 2025 16:35:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 1/5] fs/filesystems: Fix potential unsigned integer
 underflow in fs_name()
Message-ID: <20250411-kaiman-bewahren-bef1f1baee8e@brauner>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
 <20250410-fix_fs-v1-1-7c14ccc8ebaa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410-fix_fs-v1-1-7c14ccc8ebaa@quicinc.com>

On Thu, Apr 10, 2025 at 07:45:27PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> fs_name() has @index as unsigned int, so there is underflow risk for
> operation '@index--'.
> 
> Fix by breaking the for loop when '@index == 0' which is also more proper
> than '@index <= 0' for unsigned integer comparison.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---

This is honestly not worth the effort thinking about.
I'm going to propose that we remove this system call or at least switch
the default to N. Nobody uses this anymore I'm pretty sure.

>  fs/filesystems.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 58b9067b2391ce814e580709b518b405e0f9cb8a..95e5256821a53494d88f496193305a2e50e04444 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -156,15 +156,19 @@ static int fs_index(const char __user * __name)
>  static int fs_name(unsigned int index, char __user * buf)
>  {
>  	struct file_system_type * tmp;
> -	int len, res;
> +	int len, res = -EINVAL;
>  
>  	read_lock(&file_systems_lock);
> -	for (tmp = file_systems; tmp; tmp = tmp->next, index--)
> -		if (index <= 0 && try_module_get(tmp->owner))
> +	for (tmp = file_systems; tmp; tmp = tmp->next, index--) {
> +		if (index == 0) {
> +			if (try_module_get(tmp->owner))
> +				res = 0;
>  			break;
> +		}
> +	}
>  	read_unlock(&file_systems_lock);
> -	if (!tmp)
> -		return -EINVAL;
> +	if (res)
> +		return res;
>  
>  	/* OK, we got the reference, so we can safely block */
>  	len = strlen(tmp->name) + 1;
> 
> -- 
> 2.34.1
> 

