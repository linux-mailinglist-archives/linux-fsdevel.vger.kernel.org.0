Return-Path: <linux-fsdevel+bounces-42653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB72A45874
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FF63A1E00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA5D1E1DF6;
	Wed, 26 Feb 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnV7nmQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77A258CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558908; cv=none; b=ftzvSi4KHuG8j/SojHGS2CKDuz3+ETSxxRv/+BA+YVKwdW6grIQv9MK4z8hvOc/Lvf7DeeunJhaDGDfuTjP71Yfbj6NwwsuDJthoLNLDrNFBdNs1zceEdNWKT+73QiYUI69gIvhbVBa85ZsKprF2QJexS/nYgKjUk/O7eOqVzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558908; c=relaxed/simple;
	bh=OBTrItW98NcceoDDsVBm/FLj1cpeJZWXEyMwZn+0w8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx6ZMIISDbQV7nLhTFpvlwGbsT5859KlXSb+z9KzqkyTukO+hqp3Wph5/9+0mh0n/pWBmGGZEgRnBkFn9zKPmanLeW/FRhqdbf/1T+cCNgkAdbV+W+NLdRwrJ+6hYGreUHBc8RAtLPwQdx0ScEJe4CTBrwyHiwQVFMPE6ReKT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnV7nmQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0977C4CED6;
	Wed, 26 Feb 2025 08:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558907;
	bh=OBTrItW98NcceoDDsVBm/FLj1cpeJZWXEyMwZn+0w8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnV7nmQcONazW3zzi2ZhjA3rlIdH/HG3MCdkWczH1JuT61AsU8riz/dOsDt/Fjdjv
	 Z1O0K2cCq9SSbM7nRKIAMiuGlf7NEf4TxhbON2dfTD+gBPEgDJosZlZlWkpWqmib7e
	 ATsof7jXZyDz/iktqTd3L9828UrHCWk4QrZnUTwBJc6deBmyAacSAfs/0mfvm8zbye
	 TnfBcWwaB3IIpGOhDEtWnqSFyDI2RSqrH70nAUi8aq2KB96NmPMhgBAfIdADThf3cp
	 jguH0kXGZH7OCt4GZ3aHwidfqDs9aZScXhlG65Qcy4q+gG4YUEBR5omnEZK3FuJ8pq
	 cttz6eY27hjzw==
Date: Wed, 26 Feb 2025 09:35:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 09/21] make d_set_d_op() static
Message-ID: <20250226-praxen-wolle-a8863193923d@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-9-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:39PM +0000, Al Viro wrote:
> Convert the last user (d_alloc_pseudo()) and be done with that.
> Any out-of-tree filesystem using it should switch to d_splice_alias_ops()
> or, better yet, check whether it really needs to have ->d_op vary among
> its dentries.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  Documentation/filesystems/porting.rst | 11 +++++++++++
>  fs/dcache.c                           |  5 ++---
>  include/linux/dcache.h                |  1 -
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 004cd69617a2..61b5771dde53 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1164,3 +1164,14 @@ magic.
>  
>  If your filesystem sets the default dentry_operations, use set_default_d_op()
>  rather than manually setting sb->s_d_op.
> +
> +---
> +
> +**mandatory**
> +
> +d_set_d_op() is no longer exported (or public, for that matter); _if_
> +your filesystem really needed that, make use of d_splice_alias_ops()
> +to have them set.  Better yet, think hard whether you need different
> +->d_op for different dentries - if not, just use set_default_d_op()
> +at mount time and be done with that.  Currently procfs is the only
> +thing that really needs ->d_op varying between dentries.
> diff --git a/fs/dcache.c b/fs/dcache.c
> index a4795617c3db..29db27228d97 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1796,7 +1796,7 @@ struct dentry *d_alloc_pseudo(struct super_block *sb, const struct qstr *name)
>  	if (likely(dentry)) {
>  		dentry->d_flags |= DCACHE_NORCU;
>  		if (!dentry->d_op)
> -			d_set_d_op(dentry, &anon_ops);
> +			dentry->d_op = &anon_ops;
>  	}
>  	return dentry;
>  }
> @@ -1837,7 +1837,7 @@ static unsigned int d_op_flags(const struct dentry_operations *op)
>  	return flags;
>  }
>  
> -void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
> +static void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
>  {
>  	unsigned int flags = d_op_flags(op);
>  	WARN_ON_ONCE(dentry->d_op);
> @@ -1846,7 +1846,6 @@ void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
>  	if (flags)
>  		dentry->d_flags |= flags;
>  }
> -EXPORT_SYMBOL(d_set_d_op);
>  
>  void set_default_d_op(struct super_block *s, const struct dentry_operations *ops)
>  {
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index e8cf1d0fdd08..5a03e85f92a4 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -242,7 +242,6 @@ extern void d_instantiate_new(struct dentry *, struct inode *);
>  extern void __d_drop(struct dentry *dentry);
>  extern void d_drop(struct dentry *dentry);
>  extern void d_delete(struct dentry *);
> -extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op);
>  
>  /* allocate/de-allocate */
>  extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
> -- 
> 2.39.5
> 

