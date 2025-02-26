Return-Path: <linux-fsdevel+bounces-42657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E644A45885
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4066B18853BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D941E1DF6;
	Wed, 26 Feb 2025 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2fCPGIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2955258CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559119; cv=none; b=iELUn7/kvgRjNFmXWAN0zp3vnP52i7Qs7cPwQ9HKHaRYbYM7wtA3rn3QIRUHUH4RSlYQxKgN0+Ww1feQqKxINH6fltWgLl//884eOnesU65ngCs06VX/TiiBA/gaIw9j3VD8T/PzVVptsVcCPYo93r0qCYgvNIf04sZR+7o5XUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559119; c=relaxed/simple;
	bh=YhTaC48R9C1srjKbvIHTFraacNBd1S11HidCQIpWlSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHAIVncyXEnFDUhZfbHJ4i4xwqyugx1rkqb985npau1yfWNj2oQlpCeXR5phT8GUvu7ZIq36WSxQ8ZzirN11RNz1q+vOSc/QWF5ZPQQkm3I/aRPnhspLMrEOu9NDnR/CDXuWa3SbQEzvSM8BPE8MoZjjHAmF1f7mWFLd6La+eJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2fCPGIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A74C4CED6;
	Wed, 26 Feb 2025 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559119;
	bh=YhTaC48R9C1srjKbvIHTFraacNBd1S11HidCQIpWlSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2fCPGIxAR84fkL2CLJHKfCmQkZZecV5ZYMMaBc5FJezDGxAOmFBYYySQ3e982vvF
	 +wd4Uam2U+I7ODoqNHGjaD9tFgYOBL6tok/QESHi82VoAT/Tdm8NxhXXv7WSplFfPH
	 JaHC1O8wFeeHim0eSEbUTHGMH08ChBO3H3VRKlUIXdH1hPOO3RMCWxtiktEvK7KwXa
	 BonERjmA4HK4xcXlCJSHMZlc5/ULK6WWsNqL7SRbIrGFtH+Evy0VAJEdV8U8WDNjHp
	 KKOZYlQEGfyr2Yt1HO098HMo0wq0oLmUDY9IFHFxhZisYfWw0cLM27R/arGbN26WQY
	 LOIvur9KGTHLg==
Date: Wed, 26 Feb 2025 09:38:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 13/21] devpts, sunrpc: don't bother with ->d_delete or
 ->d_op, for that matter
Message-ID: <20250226-eignung-berggipfel-f851dff734a5@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-13-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-13-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:43PM +0000, Al Viro wrote:
> Just put DCACHE_DONTCACHE into ->s_d_flags.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/devpts/inode.c     | 2 +-
>  net/sunrpc/rpc_pipe.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index f092973236ef..39344af02d1f 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -433,7 +433,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
>  	s->s_blocksize_bits = 10;
>  	s->s_magic = DEVPTS_SUPER_MAGIC;
>  	s->s_op = &devpts_sops;
> -	set_default_d_op(s, &simple_dentry_operations);
> +	s->s_d_flags = DCACHE_DONTCACHE;
>  	s->s_time_gran = 1;
>  
>  	error = -ENOMEM;
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index e093e4cf20fa..acb28a502580 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -1363,7 +1363,7 @@ rpc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_blocksize_bits = PAGE_SHIFT;
>  	sb->s_magic = RPCAUTH_GSSMAGIC;
>  	sb->s_op = &s_ops;
> -	set_default_d_op(sb, &simple_dentry_operations);
> +	sb->s_d_flags = DCACHE_DONTCACHE;
>  	sb->s_time_gran = 1;
>  
>  	inode = rpc_get_inode(sb, S_IFDIR | 0555);
> -- 
> 2.39.5
> 

