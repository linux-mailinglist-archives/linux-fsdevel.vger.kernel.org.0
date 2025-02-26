Return-Path: <linux-fsdevel+bounces-42667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE8A4589F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C5B3A9E99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DB1E1E16;
	Wed, 26 Feb 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH+BYskU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CE1E1DF3
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559270; cv=none; b=EgfrHNO/pnAgA+3RK4Xdycb37JLp9vHK4FknYGiPDbn78AxGzNFo6kH9wNQ2FFugELlkHHmlB0o+D4mgkXohe2YSdU3FYINN61Hjbu7essJdWWtmStnB/Oqyy9uNbleoZBYB8dxyfOR9Z8WG2jBMJvz3Oxblr5/UjFlGAZI8LEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559270; c=relaxed/simple;
	bh=NQomfaFw4bWTljZOE95VgxBsMGgvzvqsrXW2Eexm6nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHIL81OyqEMXLaRpStXc6guL767sF8QZ3q56hwSLkkl0+8U1VkkwJhiKXZoA0ptwUZOlnxuh7lBurT9I3d+KgXQE2mNVRnrsAXuJAM2UcNPZbq7ieDzb9wazZbNPAyo9ubF+IJ639AbQ4ZK+olaO4PA7h7FoYWM7OCHxoQTGugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH+BYskU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB4DC4CED6;
	Wed, 26 Feb 2025 08:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559270;
	bh=NQomfaFw4bWTljZOE95VgxBsMGgvzvqsrXW2Eexm6nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fH+BYskUdqQO7uKTBQyZK9ee++SEhajBZpSAZ1EHt5VHQqHiPlEgdgThBOocuQwTe
	 8ITh7Xz8iV3j3UwHudf+nHI1aGhzBrsznkqRAFEOIkdcLmByQbVJuYtxa/ea9FWELK
	 AQyHojm9V6lCxEqcZBa8+pIpN8H7miOYo8FXCN6VAw+IbH0AF+7kQT0PTsIwESsKml
	 SQLwFqUGobMV5vLy3lUY8zsupdUm+zRF10wkC/qgMRn2E28wvXIjZ+oSHobjq1VP9e
	 0c8KaxBJdKLgznOjpG1EZqRzkNe3QOoT1Rak0PoNRWeSG3m2HXXCqRx2sTmCGQAflW
	 dFi18+BkU7FZQ==
Date: Wed, 26 Feb 2025 09:41:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 21/21] afs dynroot: use DCACHE_DONTCACHE
Message-ID: <20250226-leber-zehrt-cc62ebab4419@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-21-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-21-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:51PM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/afs/dynroot.c | 1 -
>  fs/afs/super.c   | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
> index d8bf52f77d93..2fad2987a6dc 100644
> --- a/fs/afs/dynroot.c
> +++ b/fs/afs/dynroot.c
> @@ -211,7 +211,6 @@ const struct inode_operations afs_dynroot_inode_operations = {
>  };
>  
>  const struct dentry_operations afs_dynroot_dentry_operations = {
> -	.d_delete	= always_delete_dentry,
>  	.d_release	= afs_d_release,
>  	.d_automount	= afs_d_automount,
>  };
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index 13d0414a1ddb..b48f524c1cb6 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -488,6 +488,7 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
>  
>  	if (as->dyn_root) {
>  		set_default_d_op(sb, &afs_dynroot_dentry_operations);
> +		sb->s_d_flags |= DCACHE_DONTCACHE;
>  		ret = afs_dynroot_populate(sb);
>  		if (ret < 0)
>  			goto error;
> -- 
> 2.39.5
> 

