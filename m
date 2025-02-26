Return-Path: <linux-fsdevel+bounces-42652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F0A45870
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC87C18943BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99F1E1DFA;
	Wed, 26 Feb 2025 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Qz181Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20F258CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558859; cv=none; b=H0ZEuzBvwc9rctuimXvQ93hj0hMPP9llNdeKhsBB0oLienCPWZyDHDd3oxjxKVLGqx1AZKjQ1WXoPUv4m5pU+j3yD2aUz6XowIIbRiaFkGqLV0Kz/0cjYcoUTAOLby4Ijd20ybrm8Nmy85YESiDebRU9wwIZ2sv7Zr0q2l9tGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558859; c=relaxed/simple;
	bh=BlawBrq+MVf2+FrA1M1sudwM2oq5KZla1iO/Pmvl3Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsXMVFKWBr2jy6Ty4QkekWd0v0z0krVU/xT70mzyUVQI3QVvFq8amINfScezgGtKC5cmUh+F6WB0BGHCCA1XuluLHmQa8QBWglFc7n0EaOj7x9qoIEc1EPgC0xJKwZoImDLWlt/ZCeAkb4y2ZjdCr+oU5MXMwdfs5tH9lTiFtmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Qz181Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA70DC4CED6;
	Wed, 26 Feb 2025 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558857;
	bh=BlawBrq+MVf2+FrA1M1sudwM2oq5KZla1iO/Pmvl3Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7Qz181YA9HmkJ45CUidXK7+DzB6HPaJ9zOHkorKdUogyfQoUYvKPWB6gEJ3crvYE
	 U/R/1TDBFr4qGvTPEVIUN8LcFU7sPIJiKm+b25wp2J/AOo4XlKjMjyOY0glAynbx3G
	 GwoCAmjf7VoUlyfypJbmHzrgrp6/GxkEpdGbhrPfVnyr13D5sq9vQe/dAztkBzKZOD
	 zBLDZR+9JcQQ22Cj0Oxw9FL4GbU3wRI5a4hpCtdtVfTDNjcrw4B5BBJTQnEIP3oFJE
	 5qNDdIG8A0YQyB5WzIAHOGiT6S0fl71Ou/hV30PauR4Uox36/ssOP1w1lR85l/+SG9
	 p40GqqV1Tw6cw==
Date: Wed, 26 Feb 2025 09:34:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 08/21] simple_lookup(): just set DCACHE_DONTCACHE
Message-ID: <20250226-erklangen-wahlrecht-94f3e80ef526@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-8-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:38PM +0000, Al Viro wrote:
> No need to mess with ->d_op at all.  Note that ->d_delete that always
> returns 1 is equivalent to having DCACHE_DONTCACHE in ->d_flags.
> Later the same thing will be placed into ->s_d_flags of the filesystems
> where we want that behaviour for all dentries; then the check in
> simple_lookup() will at least get unlikely() slapped on it.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/libfs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 929bef0fecbd..b15a2148714e 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -75,9 +75,11 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
>  {
>  	if (dentry->d_name.len > NAME_MAX)
>  		return ERR_PTR(-ENAMETOOLONG);
> -	if (!dentry->d_op)
> -		d_set_d_op(dentry, &simple_dentry_operations);
> -
> +	if (!(dentry->d_flags & DCACHE_DONTCACHE)) {
> +		spin_lock(&dentry->d_lock);
> +		dentry->d_flags |= DCACHE_DONTCACHE;
> +		spin_unlock(&dentry->d_lock);
> +	}
>  	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
>  		return NULL;
>  
> -- 
> 2.39.5
> 

