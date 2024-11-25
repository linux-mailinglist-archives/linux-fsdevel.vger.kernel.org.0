Return-Path: <linux-fsdevel+bounces-35828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776139D87BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B41169F51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FF618B47C;
	Mon, 25 Nov 2024 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW0D1Ui3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75861AC458
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544193; cv=none; b=iPMXifodRTMDRu0Jm7CR64hwGzwuj8BS4Y4S/0ysKdnb8KatnHsP7sRhrE6ICYinkt96sxFlaqDuuwK6rVJL3bjOd09A8C0Y2ZlYvtCEhvlbk6R50PbX6gVU3+JEjKf8zHkpynBN5Dbh8jobrIOZnNfXs8eL3DH6kEvJ1PrlvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544193; c=relaxed/simple;
	bh=vP2ZR7lwLslUUoeVSJnp4KqqdOJP1b8BCw4zsny6EbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrBMmkZcGIDIQryi6xe53OukPESvkm5NmZwXyHt5OlvlFFdN9nJZL9zcIkWt8ZYITsJ+JB/iDqZCUwzXZ+4k/GVL3Ug3kPCT+x1YmtRANiygOY9XsIkAk+L5KLuM1AIiUQLZtAWLcE7YMSgT4Ym/oe2a9SWdAvcHxrAE7lTM/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iW0D1Ui3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FBFC4CECE;
	Mon, 25 Nov 2024 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732544193;
	bh=vP2ZR7lwLslUUoeVSJnp4KqqdOJP1b8BCw4zsny6EbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iW0D1Ui39T5VJXBxo/y6498HyZLPq4qXHEUBMIYCnzJsHOWI4lLZXgon/n94Rgq2Z
	 +kmOQgSVjh+rmWebBwc+7/hRtBSFwhn7H/0UhWSWvbkMXA/ZwaIUJbVzzY9I8h0TJz
	 cmJbJGYKWdpTIDs09Owb6laWfNfYRPP0d7nx10ReKJevgr5Z6YDXgxsbAQPVxmntXI
	 bLAfqS/yQLDur3e13eiAwFojdo8LOUYHodLwwCEGhD+lfYd1ZiDMRnTKuxlZFLRD71
	 LiyHb+ib51Je0nxNWiTdPzMbqP0RWrDZnKdcW+b2LHitsX534Yop3N3U/JgBF/3DI2
	 FSYCAcyXU6c4A==
Date: Mon, 25 Nov 2024 15:16:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: require inode_owner_or_capable for F_SET_RW_HINT
Message-ID: <20241125-klartext-zeremonie-93fa4356872a@brauner>
References: <20241122122931.90408-1-hch@lst.de>
 <20241122122931.90408-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122122931.90408-2-hch@lst.de>

On Fri, Nov 22, 2024 at 01:29:24PM +0100, Christoph Hellwig wrote:
> F_SET_RW_HINT controls data placement in the file system and / or
> device and should not be available to everyone who can read a given file.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/fcntl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 22dd9dcce7ec..7fc6190da342 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -375,6 +375,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
>  	u64 __user *argp = (u64 __user *)arg;
>  	u64 hint;
>  
> +	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
> +		return -EPERM;
> +

Bah, nice catch.

