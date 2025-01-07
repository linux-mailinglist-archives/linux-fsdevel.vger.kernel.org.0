Return-Path: <linux-fsdevel+bounces-38585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEDAA0441C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416611886831
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC09F1F237D;
	Tue,  7 Jan 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JsNSU8R+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1781E1041
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263248; cv=none; b=T7Uwi+3fUW2VsxTt/Z31vlWAHEy5b8PIAkJY2CaabPxCqgTS9jdK7G7qxvn1ZIkEQgTEzg4XtLOBRvtbPg73pwwIVAhQO6rDwd6Q9Bj1f8msup/trTPDFv4js18EpTUqoWhygfS0deAV1ctERlRwM4ZooJIvUvW4S3CGt2q3ugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263248; c=relaxed/simple;
	bh=0nrlfp/PJ+zSoXDPZV2qGXZamPMKPb7LQQ35+2+6rMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBR7c3HAEkjyKQ1n1dVDPAQiOS8EMDxCZV1a7AM31iai6YVOD4u3oHbpjVN6L5rrrZ4vu6WXAj7u0ibFw+fGaEP1SIDy/awyFobcFkSS2Jblc31N1c79pf5KZxNquL4X/KhDqKLbUvx1C77nZg0U5wSzvbQfhgg2urfcmvwD22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JsNSU8R+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF0C4CEDD;
	Tue,  7 Jan 2025 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736263247;
	bh=0nrlfp/PJ+zSoXDPZV2qGXZamPMKPb7LQQ35+2+6rMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsNSU8R+/keDINflEr4w0N/K2JzMJZvABc/MEJxZbazIjK3TyK2t6DXXWNv3/yvA8
	 dGh9whCiJZYfM7RG9gWMuV31QR2tICtKCW0vgzgcFePJnsUL+xLw1/U3CG3joE4lfx
	 tRzTZHlD8cRKS4jQf+7+nD3xGmcgRF7pmKckHc+0=
Date: Tue, 7 Jan 2025 16:20:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/20] debugfs: fix missing mutex_destroy() in short_fops
 case
Message-ID: <2025010729-uniformly-elderly-aab4@gregkh>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>

On Sun, Dec 29, 2024 at 08:12:04AM +0000, Al Viro wrote:
> we need that in ->real_fops == NULL, ->short_fops != NULL case
> 
> Fixes: 8dc6d81c6b2a "debugfs: add small file operations for most files"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/debugfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 38a9c7eb97e6..c99a0599c811 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -229,7 +229,7 @@ static void debugfs_release_dentry(struct dentry *dentry)
>  		return;
>  
>  	/* check it wasn't a dir (no fsdata) or automount (no real_fops) */
> -	if (fsd && fsd->real_fops) {
> +	if (fsd && (fsd->real_fops || fsd->short_fops)) {
>  		WARN_ON(!list_empty(&fsd->cancellations));
>  		mutex_destroy(&fsd->cancellations_mtx);
>  	}
> -- 
> 2.39.5
> 

I've taken this one now as it fixes an issue in -rc1.

thanks,

greg k-h

