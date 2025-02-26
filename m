Return-Path: <linux-fsdevel+bounces-42655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D2A4587F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188363A8390
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DBC1E1DF6;
	Wed, 26 Feb 2025 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJoLbd2a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A35258CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559069; cv=none; b=HYLldHCa97dYkVm6UxtvkA50WSeSF6mzXw1kpbO91soGZ4SZFws2q+wz2UW7lrcs/43KnFJdEoGtt892dmEW6p/F+v0vMh2xX32T7guMptE+9S8J44YbVYQbj4di29wCr7sYJw3xt9RavYpgdHrOVhz078/n3D9ulKcmJSSqq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559069; c=relaxed/simple;
	bh=bXKr77XV4pdf8fqgdZ0k4/D+OmTSbqwSGS+j16Xm7i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCfIPrZ1VALSAKkB+jaOcvOUpVtwDPLZWcvacaylERyr5F37hQDNbvt3RWp9YHTgV8Q7e6ePyyXuvgh1B06NJ1KZgKlX5/ZGqF26tdLW5Cp6cx7F5tb4qTjMrUTIvUUfzjCu2Nul2+rQheAZHPF7bQk3XKyC8Q3dEVk5DjYnbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJoLbd2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECD4C4CED6;
	Wed, 26 Feb 2025 08:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559069;
	bh=bXKr77XV4pdf8fqgdZ0k4/D+OmTSbqwSGS+j16Xm7i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJoLbd2aYBF7vX2/ecTNx9aw/25JkPaFWmFllHGKYwhTFD+SmVrbqIaML/xi2YlkP
	 +Ru+qhfOylHqaSBEiRxa/INxbxfHgB3l7vl1ayH/D0UD7Sr1tPE6JwiDbXqo0gd1Jx
	 GLX3d4HJzRLTFYQ4ZUmoCj6SEtojSwFHYdVO6/rpXXO5XLrwaZcurYTrJbewuGjpMF
	 8gaADc609MmXVi1vcz7BM/gxHK2OEzreD8AyBbri1HOzo6Yq74Oml0kxGlnC5VH+sv
	 RTqyDK8BdDnRc3D0XydICO0EcSXLVdLZnAe61FSTy5CLOKrGGkgLQSH3RFrbhuGey2
	 Fp8EhHJXwHelQ==
Date: Wed, 26 Feb 2025 09:37:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 11/21] nsfs, pidfs: drop the pointless ->d_delete()
Message-ID: <20250226-gesplittet-kanzlei-a1db90c285ee@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-11-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-11-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:41PM +0000, Al Viro wrote:
> No dentries are ever hashed on those, so ->d_delete() wouldn't be
> even looked at.  If it's unhashed, we are not retaining it in dcache
> once the refcount hits zero, no matter what.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Patches to remove this have already been merged into mainline.

>  fs/nsfs.c  | 1 -
>  fs/pidfs.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 663f8656158d..f7fddf8ecf73 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -37,7 +37,6 @@ static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)
>  }
>  
>  const struct dentry_operations ns_dentry_operations = {
> -	.d_delete	= always_delete_dentry,
>  	.d_dname	= ns_dname,
>  	.d_prune	= stashed_dentry_prune,
>  };
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 63f9699ebac3..c0478b3c55d9 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -521,7 +521,6 @@ static char *pidfs_dname(struct dentry *dentry, char *buffer, int buflen)
>  }
>  
>  const struct dentry_operations pidfs_dentry_operations = {
> -	.d_delete	= always_delete_dentry,
>  	.d_dname	= pidfs_dname,
>  	.d_prune	= stashed_dentry_prune,
>  };
> -- 
> 2.39.5
> 

