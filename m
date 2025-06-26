Return-Path: <linux-fsdevel+bounces-53065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 007CDAE98A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C72D7B0D42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F000E29ACED;
	Thu, 26 Jun 2025 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IStPaNkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580402676CD;
	Thu, 26 Jun 2025 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927096; cv=none; b=bWYWBeXZ4fuZx/6xCeQ1+sXgW7AmTufpxy8gYXBxmAPvrv4xjWLePavHERg/z8fn32oyy7OHpXjbj3EyS7wt+qKQcae+06ov6E4J9nL1iOoKTFgj4+5AOYMP4EjL8mjIX1d4vMu7xb08fugiMUK5MC1yQXe6Qc+fmxRKKEkUof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927096; c=relaxed/simple;
	bh=fcdRgxgO6/Bua4siffnEn76OuY0xSirhNWgSf6Wk9cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEDMz7ppVly78KcqjeHZeYWE9IcpI8fesQMJxj/du5Jgej3nDZjuI9QaZg4c2OZpgbYJY50wu9AUwC4+UwznurSAsGmXY2x2YjynCjm3eaDoF+ZUFZuLG+Eb9OMAoO88hjuucUmhoCMjrFva8muYEWKuUhIAr7Xj0grHz3+Jwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IStPaNkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BF9C4CEEB;
	Thu, 26 Jun 2025 08:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750927095;
	bh=fcdRgxgO6/Bua4siffnEn76OuY0xSirhNWgSf6Wk9cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IStPaNktKbZJtQ8Dl4D0soJjKG+qYCV9ZOQq2F1T3FjzPtmL8pPe1eEueTBeSi4xz
	 lFBG6fliUFk/fLZ/inJMpVJRXVBX5gOx8WcHvy8lwXcPXIbUJwrD+qKGKNbOnTIECg
	 bXUzICNFseEaDiFuTEmS4yC3WHfyzi2gkPq1xvwQBtshFDMG6l8RolPTf6WESj+FYq
	 6hJbqwNcmQYjqL2dDzyoJTCDjMlpvBkOpR33z3b2U3Nb+64mpup0WDC52pmXVaJSaY
	 rZHW8r3ZZVl2xVg+Z+7BZeyZC+7XeJrEcWJ0VTE2XOiNW9hyOrFLKKTsFCWX/dMttl
	 fbIeNp3E61TWg==
Date: Thu, 26 Jun 2025 10:38:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH 1/6] fs: add a new remove_bdev() super operations callback
Message-ID: <20250626-schildern-flutlicht-36fa57d43570@brauner>
References: <cover.1750895337.git.wqu@suse.com>
 <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com>

On Thu, Jun 26, 2025 at 09:23:42AM +0930, Qu Wenruo wrote:
> The new remove_bdev() call back is mostly for multi-device filesystems
> to handle device removal.
> 
> Some multi-devices filesystems like btrfs can have the ability to handle
> device lose according to the setup (e.g. all chunks have extra mirrors),
> thus losing a block device will not interrupt the normal operations.
> 
> Btrfs will soon implement this call back by:
> 
> - Automatically degrade the fs if read-write operations can be
>   maintained
> 
> - Shutdown the fs if read-write operations can not be maintained
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/super.c         |  4 +++-
>  include/linux/fs.h | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 80418ca8e215..07845d2f9ec4 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1463,7 +1463,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  		sync_filesystem(sb);
>  	shrink_dcache_sb(sb);
>  	evict_inodes(sb);
> -	if (sb->s_op->shutdown)
> +	if (sb->s_op->remove_bdev)
> +		sb->s_op->remove_bdev(sb, bdev, surprise);
> +	else if (sb->s_op->shutdown)
>  		sb->s_op->shutdown(sb);

This makes ->remove_bdev() and ->shutdown() mutually exclusive. I really
really dislike this pattern. It introduces the possibility that a
filesystem accidently implement both variants and assumes both are
somehow called. That can be solved by an assert at superblock initation
time but it's still nasty.

The other thing is that this just reeks of being the wrong api. We
should absolutely aim for the methods to not be mutually exclusive. I
hate that with a passion. That's just an ugly api and I want to have as
little of that as possible in our code.

>  
>  	super_unlock_shared(sb);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b085f161ed22..5e84e06c7354 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2367,7 +2367,25 @@ struct super_operations {
>  				  struct shrink_control *);
>  	long (*free_cached_objects)(struct super_block *,
>  				    struct shrink_control *);
> +	/*
> +	 * Callback to shutdown the fs.
> +	 *
> +	 * If a fs can not afford losing any block device, implement this callback.
> +	 */
>  	void (*shutdown)(struct super_block *sb);
> +
> +	/*
> +	 * Callback to handle a block device removal.
> +	 *
> +	 * Recommended to implement this for multi-device filesystems, as they
> +	 * may afford losing a block device and continue operations.
> +	 *
> +	 * @surprse:	indicates a surprise removal. If true the device/media is
> +	 *		already gone. Otherwise we're prepareing for an orderly
> +	 *		removal.
> +	 */
> +	void (*remove_bdev)(struct super_block *sb, struct block_device *bdev,
> +			    bool surprise);
>  };

Yeah, I think that's just not a good api. That looks a lot to me like we
should just collapse both functions even though earlier discussion said
we shouldn't. Just do:

s/shutdown/remove_bdev/

or

s/shutdown/shutdown_bdev()

The filesystem will know whether it has to kill the filesystem or if it
can keep going even if the device is lost. Hell, if we have to we could
just have it return whether it killed the superblock or just the device
by giving the method a return value. But for now it probably doesn't
matter.

