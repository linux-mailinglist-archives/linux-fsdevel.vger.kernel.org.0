Return-Path: <linux-fsdevel+bounces-11624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9BA85580F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 01:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D631F2818A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBCC145FFA;
	Wed, 14 Feb 2024 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVSOA2rj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B81420C4;
	Wed, 14 Feb 2024 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955147; cv=none; b=fOqEEu8ktKJ1EVIz+3vH/HNXNgbVLogodtGMvCA2FzIR4wwx0w40Qz8dOOfDWzmUIS8MiC2J988GerMFcdGqTgcCCskI9LtJDCHdAuHhh4QNlwpcMpaTQZt3MlSd3E3DrobqbZxlrpIEl4mSidxBzYZeLUIMXoSzvu521mMEEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955147; c=relaxed/simple;
	bh=BKcXm1qqYWOlTZyU6bx2ZkL1Mu0/Nbno89RNGSj8xP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBbNnjudK/Xisisk2DrEScW6EzIJsIg7Jckjox1vfSclEGFNeRPzK/hKCFU09fzacQNzNBC0H8TpkXtcvPv/M5FOqZ/Ly0wP7l78xwZULMzfw7WE9vyxuKTIj3Xl/LZCkw5e7DLIqwRN/3aQVPC6PnqtFs0NHjBaK6i1tkq8KTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVSOA2rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D3C433C7;
	Wed, 14 Feb 2024 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707955146;
	bh=BKcXm1qqYWOlTZyU6bx2ZkL1Mu0/Nbno89RNGSj8xP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVSOA2rjzKIzPjyfuF+bMP9xI0wX2KW+oRcezoVimBGVPqX1z6gkl2czYeYhp9Qa+
	 qg28wTTSHzAhkJoOHB3uP0x5vjFujAfhUcTnpMiZVl3WwKZpLQNfqH4ydu8VIUBQVk
	 9iUYBFJVIbKv9qCLNVFjz2WwwX0GlggjnOxhoMjV9QhkpmTVch+/MEPiwmt3O+UOAp
	 eObkOz8M6OadXl6RqzkcrD8XSAgXBEsiCYdGq6uqfby2sVSeOUQv5OJEHFsHaiho11
	 o3wvgs5SSdtTApXmat27ugEcHl63Nzf+wUkXRYx8CdHCwQxrs+m2QyRwfMuZYCrkOT
	 MGzUHWqcRIyKg==
Date: Wed, 14 Feb 2024 15:59:04 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v6 03/10] fscrypt: Drop d_revalidate for valid dentries
 during lookup
Message-ID: <20240214235904.GH1638@sol.localdomain>
References: <20240213021321.1804-1-krisman@suse.de>
 <20240213021321.1804-4-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213021321.1804-4-krisman@suse.de>

On Mon, Feb 12, 2024 at 09:13:14PM -0500, Gabriel Krisman Bertazi wrote:
> Finally, we need to clean the dentry->flags even for unencrypted
> dentries, so the ->d_lock might be acquired even for them.  In order to

might => must?

> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 47567a6a4f9d..d1f17b90c30f 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -951,10 +951,29 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
>  static inline void fscrypt_prepare_dentry(struct dentry *dentry,
>  					  bool is_nokey_name)
>  {
> +	/*
> +	 * This code tries to only take ->d_lock when necessary to write
> +	 * to ->d_flags.  We shouldn't be peeking on d_flags for
> +	 * DCACHE_OP_REVALIDATE unlocked, but in the unlikely case
> +	 * there is a race, the worst it can happen is that we fail to
> +	 * unset DCACHE_OP_REVALIDATE and pay the cost of an extra
> +	 * d_revalidate.
> +	 */
>  	if (is_nokey_name) {
>  		spin_lock(&dentry->d_lock);
>  		dentry->d_flags |= DCACHE_NOKEY_NAME;
>  		spin_unlock(&dentry->d_lock);
> +	} else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
> +		   dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
> +		/*
> +		 * Unencrypted dentries and encrypted dentries where the
> +		 * key is available are always valid from fscrypt
> +		 * perspective. Avoid the cost of calling
> +		 * fscrypt_d_revalidate unnecessarily.
> +		 */
> +		spin_lock(&dentry->d_lock);
> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
> +		spin_unlock(&dentry->d_lock);
>  	}
>  }

Does this all get optimized out when !CONFIG_FS_ENCRYPTION?

As-is, I don't think the d_revalidate part will be optimized out.

You may need to create a !CONFIG_FS_ENCRYPTION stub explicitly.

- Eric

