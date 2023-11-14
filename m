Return-Path: <linux-fsdevel+bounces-2848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DBF7EB586
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 18:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E220B1C20AA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C12C192;
	Tue, 14 Nov 2023 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKdyNlcT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5352C18B
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 17:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2874C433C7;
	Tue, 14 Nov 2023 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699982959;
	bh=g39laiWffI3DPXTx8JHtLQmGV3Kz98YnU4YPFc8UTHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKdyNlcTEbGiW44XiD6StyaS5EvLwTQVS92gDTAHAOaDjDkkwOEDPjx07zrtEn6vf
	 2PFW6GzaFtgfmLdzO7xbZx8OBIbHTsan93wZjMT8cQc3Q514yHN1FKlN9sNwLOqPAe
	 zgcVc1bq6bGpSXkAJdcSh0Hnt6JyTG/mTUWxmk8Me2AlEuK4vDR/9GX5VGRCFJKyUs
	 OUlr7bmgQFu9CCSszigWf8GQmKlJRxhaCT/ilsfUTSIlmqUiAZihY0QBsyHbSTPH/v
	 /W84IRGBgZwK9WfpXtfEBHgXl3GrIsuTrAd45tx49FXnC3GQWd8PMYdDMF60jBrREW
	 ETTnSIc+SL6Xw==
Date: Tue, 14 Nov 2023 18:29:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: akpm@linux-foundation.org, hughd@google.com, jlayton@redhat.com,
	viro@zeniv.linux.org.uk, Tavian Barnes <tavianator@tavianator.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] libfs: getdents() should return 0 after reaching EOD
Message-ID: <20231114-begleichen-miniatur-3c3a02862c4c@brauner>
References: <169997697704.4588.14555611205729567800.stgit@bazille.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169997697704.4588.14555611205729567800.stgit@bazille.1015granger.net>

On Tue, Nov 14, 2023 at 10:49:37AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The new directory offset helpers don't conform with the convention
> of getdents() returning no more entries once a directory file
> descriptor has reached the current end-of-directory.
> 
> To address this, copy the logic from dcache_readdir() to mark the
> open directory file descriptor once EOD has been reached. Rewinding
> resets the mark.
> 
> Reported-by: Tavian Barnes <tavianator@tavianator.com>
> Closes: https://lore.kernel.org/linux-fsdevel/20231113180616.2831430-1-tavianator@tavianator.com/
> Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/libfs.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index e9440d55073c..1c866b087f0c 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -428,7 +428,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>  }
>  
> -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  {
>  	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
>  	XA_STATE(xas, &so_ctx->xa, ctx->pos);
> @@ -437,7 +437,8 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  	while (true) {
>  		dentry = offset_find_next(&xas);
>  		if (!dentry)
> -			break;
> +			/* readdir has reached the current EOD */
> +			return (void *)0x10;
>  
>  		if (!offset_dir_emit(ctx, dentry)) {
>  			dput(dentry);
> @@ -447,6 +448,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  		dput(dentry);
>  		ctx->pos = xas.xa_index + 1;
>  	}
> +	return NULL;
>  }
>  
>  /**
> @@ -479,7 +481,12 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
>  
> -	offset_iterate_dir(d_inode(dir), ctx);
> +	if (ctx->pos == 2)
> +		file->private_data = NULL;
> +	else if (file->private_data == (void *)0x10)
> +		return 0;
> +
> +	file->private_data = offset_iterate_dir(d_inode(dir), ctx);

I think it's usually best practice to only modify the file->private_data
pointer during f_op->open and f_op->close but not override
file->private_data once the file is visible to other threads. I think
here it might not matter because access to file->private_data is
serialized on f_pos_lock and it's not used by anything else.

