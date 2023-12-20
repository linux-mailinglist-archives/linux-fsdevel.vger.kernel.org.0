Return-Path: <linux-fsdevel+bounces-6571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 326C581991F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 08:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C610A1F26F95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 07:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C461D6BE;
	Wed, 20 Dec 2023 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCwvCSYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B21D6A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 07:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A58C433CA;
	Wed, 20 Dec 2023 07:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703056175;
	bh=LCazB3VWDETYb0A0Nb2rDPKBjjh+9A7bJTXdCWaIji0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=uCwvCSYvA9k9QL9oCbUeWCnZBaI63KtL8dQFl6dGrDQWq4Pwgxf+nZnxbtnrMgaWh
	 WrsfJ29owdupmp8BGwvZP+Oy2toWEbr8rvp4InuTkFHBHtTQmsLgLbw9swen3CEfeU
	 na71qkiA0OWtgk8pDEh9zNCLdEQ8loaYl+giCqgiHHBQakkX3GpBc6skfrOJnnVb8d
	 2kL4wMIV8QeWdc7Gp6sT++FRZjDrZq1Vq2qk6+VcfvDt2kLzUPULaUV6lgXSlkRABi
	 UpO91k6XV9HWZV2FPYteegN5iTMB6OlOWTai79dq9PUVqOTYTvZeOCgAQqI8NxMMmZ
	 UcP8AFFm+IGBQ==
Message-ID: <c942060e-ccd7-4060-87f7-cf60d3f1963a@kernel.org>
Date: Wed, 20 Dec 2023 16:09:34 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] zonefs: d_splice_alias() will do the right thing on
 ERR_PTR() inode
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
References: <20231220051348.GY1674809@ZenIV> <20231220051736.GB1674809@ZenIV>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231220051736.GB1674809@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 14:17, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/zonefs/super.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index e6a75401677d..93971742613a 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -747,8 +747,6 @@ static struct dentry *zonefs_lookup(struct inode *dir, struct dentry *dentry,
>  		inode = zonefs_get_dir_inode(dir, dentry);
>  	else
>  		inode = zonefs_get_file_inode(dir, dentry);
> -	if (IS_ERR(inode))
> -		return ERR_CAST(inode);
>  
>  	return d_splice_alias(inode, dentry);
>  }

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


