Return-Path: <linux-fsdevel+bounces-54746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51946B02973
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 07:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6937A44029
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 05:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9311FBE8A;
	Sat, 12 Jul 2025 05:14:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91F132122
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 05:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752297288; cv=none; b=aQutqCvu8NBeY1M7ZbQU1zzi3F4Il3oazFxh/+Pxg0ChVdD3ydjRmrvBOjf6wwpLzyaATmTtYN6HwGtn4z9864UsT8FC+aCvwAsfZSR0N3vfjZVCsgDfSEn8ruFFcyub1oAQ6GHDwDGo+J9HQnnQPxOXfNLISoNEw7wfMyXPDXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752297288; c=relaxed/simple;
	bh=34eWEETg5c+qhCxuY8hk6nA3o77L1gMcIjKPYjRoWv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMVo1OX2kuY8FIXxcWXcx5bRsSUAXfnH2ZoIfJwJMySQkAGzXf8siFkkWfm5kHNCUZ5nhQ0Lh0mNn/pCL7FrAwfQyQQKK7Y/wvg676DTklEk5i7DSEgsnwgw5nMkD3VU7wLFlRtH2SXJU8keOMh4af4BA4JbzslQDTtpTsnBgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 0B79B2015CEF;
	Sat, 12 Jul 2025 07:14:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E718C3C8192; Sat, 12 Jul 2025 07:14:35 +0200 (CEST)
Date: Sat, 12 Jul 2025 07:14:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>
Cc: linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] habanalabs: fix UAF in export_dmabuf()
Message-ID: <aHHvO5Nv984iZQy8@wunner.de>
References: <20250712050231.GX1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712050231.GX1880847@ZenIV>

On Sat, Jul 12, 2025 at 06:02:31AM +0100, Al Viro wrote:
> [dma_buf_fd() fixes; no preferences regarding the tree it goes through -
> up to dri folks]

A MAINTAINERS change for the habanalabs driver landed in Linus' tree
a few hours ago.  I'm adding the new maintainers Yaron, Koby and
Konstantin to the To: header.  Thanks! -- Lukas

> As soon as we'd inserted a file reference into descriptor table, another
> thread could close it.  That's fine for the case when all we are doing is
> returning that descriptor to userland (it's a race, but it's a userland
> race and there's nothing the kernel can do about it).  However, if we
> follow fd_install() with any kind of access to objects that would be
> destroyed on close (be it the struct file itself or anything destroyed
> by its ->release()), we have a UAF.
> 
> dma_buf_fd() is a combination of reserving a descriptor and fd_install().
> habanalabs export_dmabuf() calls it and then proceeds to access the
> objects destroyed on close.  In particular, it grabs an extra reference to
> another struct file that will be dropped as part of ->release() for ours;
> that "will be" is actually "might have already been".
> 
> Fix that by reserving descriptor before anything else and do fd_install()
> only when everything had been set up.  As a side benefit, we no longer
> have the failure exit with file already created, but reference to
> underlying file (as well as ->dmabuf_export_cnt, etc.) not grabbed yet;
> unlike dma_buf_fd(), fd_install() can't fail.
> 
> Fixes: db1a8dd916aa ("habanalabs: add support for dma-buf exporter")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/accel/habanalabs/common/memory.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
> index 601fdbe70179..61472a381904 100644
> --- a/drivers/accel/habanalabs/common/memory.c
> +++ b/drivers/accel/habanalabs/common/memory.c
> @@ -1829,9 +1829,6 @@ static void hl_release_dmabuf(struct dma_buf *dmabuf)
>  	struct hl_dmabuf_priv *hl_dmabuf = dmabuf->priv;
>  	struct hl_ctx *ctx;
>  
> -	if (!hl_dmabuf)
> -		return;
> -
>  	ctx = hl_dmabuf->ctx;
>  
>  	if (hl_dmabuf->memhash_hnode)
> @@ -1859,7 +1856,12 @@ static int export_dmabuf(struct hl_ctx *ctx,
>  {
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  	struct hl_device *hdev = ctx->hdev;
> -	int rc, fd;
> +	CLASS(get_unused_fd, fd)(flags);
> +
> +	if (fd < 0) {
> +		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
> +		return fd;
> +	}
>  
>  	exp_info.ops = &habanalabs_dmabuf_ops;
>  	exp_info.size = total_size;
> @@ -1872,13 +1874,6 @@ static int export_dmabuf(struct hl_ctx *ctx,
>  		return PTR_ERR(hl_dmabuf->dmabuf);
>  	}
>  
> -	fd = dma_buf_fd(hl_dmabuf->dmabuf, flags);
> -	if (fd < 0) {
> -		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
> -		rc = fd;
> -		goto err_dma_buf_put;
> -	}
> -
>  	hl_dmabuf->ctx = ctx;
>  	hl_ctx_get(hl_dmabuf->ctx);
>  	atomic_inc(&ctx->hdev->dmabuf_export_cnt);
> @@ -1890,13 +1885,9 @@ static int export_dmabuf(struct hl_ctx *ctx,
>  	get_file(ctx->hpriv->file_priv->filp);
>  
>  	*dmabuf_fd = fd;
> +	fd_install(take_fd(fd), hl_dmabuf->dmabuf->file);
>  
>  	return 0;
> -
> -err_dma_buf_put:
> -	hl_dmabuf->dmabuf->priv = NULL;
> -	dma_buf_put(hl_dmabuf->dmabuf);
> -	return rc;
>  }
>  
>  static int validate_export_params_common(struct hl_device *hdev, u64 addr, u64 size, u64 offset)
> -- 
> 2.39.5

