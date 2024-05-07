Return-Path: <linux-fsdevel+bounces-18935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F4A8BEAE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 19:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772DD1C240C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706AF16C871;
	Tue,  7 May 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCs90TDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0016C857;
	Tue,  7 May 2024 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104575; cv=none; b=gLIuCMFEpN1Cgm6WNdsvOsWv3N5OHtOdTT9ic6DsX4PPMxBKaNkfep535uVQpulXP/LBj1buhnMGhvCsqkh/lu2omrOmAm/rdLJgbZreJxRvo35yrZ9zrz3Cc9whothZAPDHACk+BGw0dUKMPp9+AYZflTMngcSDsNZfwTH5t2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104575; c=relaxed/simple;
	bh=7vP8j6DVRtxLzZgNQl7oooXokBXhH16yTi4+Bilnelo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSVkvMRlipubU7roGxVl/ohSHGQL1hGlwAFYZqwVxhOBUuv5gGLjjyacrqMt9C2zEi77koytvna2lko6drohb+qUYupBrcKinZFJ0kf8SrcHfm6rMA6eG/T0gitYaDAPz1z84m4ZRMDKfU8jpuql0jM5kbN5wkrwERKgCt40btE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCs90TDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2882DC2BBFC;
	Tue,  7 May 2024 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715104575;
	bh=7vP8j6DVRtxLzZgNQl7oooXokBXhH16yTi4+Bilnelo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCs90TDyslyU+o0zAPC/FcymE8ykJh48djflVZPXK/dyFC2AkC1GlOXS1lItHn55y
	 lqETo8ShtgbldxtGPqr+3BR4+QsxlleaDore6eHTZiOmmYVH/sapZjlb1W9YNJv1az
	 ZI8Q7i4H142m9nZKsfQE/+eoqJe3UXmg/zzuGdF3Zbcmv1ZH4GnvzAnUTHIqnHbF9T
	 Kx4yTRx225NL2gMFA95S1Dwhzr/gWcx5a05lEQgbe/otGcd9rykhUizINo1afsOGsu
	 yQXFii/ahAN1H/zmWE/6fS1PdNe9u1bMsnH+faJHWAR73vA02IMMLYgMRSyiR4f1BH
	 yWRVf720y6BHw==
Date: Tue, 7 May 2024 10:56:13 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tytso@mit.edu, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fscrypto: try to avoid refing parent dentry in
 fscrypt_file_open
Message-ID: <20240507175613.GA25966@sol.localdomain>
References: <20240507093653.297402-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507093653.297402-1-mjguzik@gmail.com>

[+linux-fsdevel]

Thanks!  The general concept looks good.  A few nits below:

On Tue, May 07, 2024 at 11:36:53AM +0200, Mateusz Guzik wrote:
> fscrypto: try to avoid refing parent dentry in fscrypt_file_open

fscrypt, not fscrypto

> Merely checking if the directory is encrypted happens for every open
> when using ext4, at the moment refing and unrefing the parent, costing 2
> atomics and serializing opens of different files.
> 
> The most common case of encryption not being used can be checked for
> with RCU instead.
> 
> Sample result from open1_processes -t 20 ("Separate file open/close") from

Overly long line above

> will-it-scale on Sapphire Rapids (ops/s):
> before:	12539898
> after:	25575494 (+103%)
> 
> Arguably a vfs helper would be nice here.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/crypto/hooks.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> index 104771c3d3f6..16328ec14266 100644
> --- a/fs/crypto/hooks.c
> +++ b/fs/crypto/hooks.c
> @@ -30,21 +30,32 @@
>  int fscrypt_file_open(struct inode *inode, struct file *filp)
>  {
>  	int err;
> -	struct dentry *dir;
> +	struct dentry *dentry, *dentry_parent;
> +	struct inode *inode_parent;
>  
>  	err = fscrypt_require_key(inode);
>  	if (err)
>  		return err;
>  
> -	dir = dget_parent(file_dentry(filp));
> -	if (IS_ENCRYPTED(d_inode(dir)) &&
> -	    !fscrypt_has_permitted_context(d_inode(dir), inode)) {
> +	dentry = file_dentry(filp);
> +	rcu_read_lock();
> +	dentry_parent = READ_ONCE(dentry->d_parent);
> +	inode_parent = d_inode_rcu(dentry_parent);
> +	if (inode_parent != NULL && !IS_ENCRYPTED(inode_parent)) {
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +	rcu_read_unlock();

It would be helpful for there to be a comment here that explains the
optimization.  How about something like the following?

	/*
	 * Getting a reference to the parent dentry is needed for the actual
	 * encryption policy comparison, but it's expensive on multi-core
	 * systems.  Since this function runs on unencrypted files too, start
	 * with a lightweight RCU-mode check for the parent directory being
	 * unencrypted (in which case it's fine for the child to be either
	 * unencrypted, or encrypted with any policy).  Only continue on to the
	 * full policy check if the parent directory is actually encrypted.
	 */

	dentry = file_dentry(filp);
	rcu_read_lock();
        ...

> +
> +	dentry_parent = dget_parent(dentry);
> +	if (IS_ENCRYPTED(d_inode(dentry_parent)) &&
> +	    !fscrypt_has_permitted_context(d_inode(dentry_parent), inode)) {
>  		fscrypt_warn(inode,
>  			     "Inconsistent encryption context (parent directory: %lu)",
> -			     d_inode(dir)->i_ino);
> +			     d_inode(dentry_parent)->i_ino);
>  		err = -EPERM;
>  	}
> -	dput(dir);
> +	dput(dentry_parent);
>  	return err;

The IS_ENCRYPTED() check above can be removed, because it becomes redundant due
to this patch.  I think it was intended to optimize the case of unencrypted
files, like your patch does.  But clearly it wasn't too effective, as it was
after the dget_parent().

- Eric

